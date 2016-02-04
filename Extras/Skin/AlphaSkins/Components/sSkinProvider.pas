unit sSkinProvider;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//{$DEFINE DEBUG}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, sDefaults, menus, ExtCtrls, Buttons, Controls,
  {$IFDEF DELPHI_XE2} UITypes,   {$ENDIF}
  {$IFDEF DELPHI7UP}  Types,     {$ENDIF}
  {$IFDEF FPC}        LMessages, {$ENDIF}
  {$IFDEF TNTUNICODE} TntWideStrUtils, TntMenus, TntStdCtrls, TntControls, {$ENDIF}
  sConst, sCommondata, acSBUtils, sSkinMenus, sSkinManager, acGlow, acThdTimer, acTitleBar;

type
{$IFNDEF NOTFORHELP}
  TacLabelColor = record
    Color:      TColor;
    Control:    TControl;
    ParentFont: boolean;
  end;


  TacFormsCouple = record
    Slave,
    Master: TForm;
    Pos:    TPoint;
  end;


  TacGraphItem = class(TPersistent)
  public
    Adapter:  TObject;
    Ctrl:     TControl;
    SkinData: TsCommonData;
    Handler:  TacSpeedButtonHandler;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure DoHook(Control: TControl);
  end;


  TacCtrlAdapter = class;
  TacAdapterItem = class(TPersistent)
  protected
    COC: integer;
  public
    WinCtrl: TWinControl;
    ScrollWnd: TacMainWnd;
    Adapter: TacCtrlAdapter;
    constructor Create(AAdapter: TacCtrlAdapter; ACtrl: TWinControl); virtual;
    destructor Destroy; override;
    procedure DoHook(Control: TWinControl; SkinParams: TacSkinParams);
  end;

  PacSkinParams = ^TacSkinParams;

  TsSkinProvider = class;
  TacBorderForm  = class;
  TacSBAnimation = class;

  TacNCHitTest = procedure(var Msg: TWMNcHitTest) of object;
  TacAnimEvent = (aeShowing, aeHiding, aeSkinChanging);
{$ENDIF}

  TsGripMode = (gmNone, gmRightBottom);
  TsResizeMode = (rmStandard, rmBorder);

  TacAfterAnimation = procedure(AnimType: TacAnimEvent) of object;
  TAddItemEvent     = procedure(Item: TComponent; var CanBeAdded: boolean; var SkinSection: string)   of object;
  TAddItemExEvent   = procedure(Item: TComponent; var CanBeAdded: boolean; SkinParams: PacSkinParams) of object;

{$IFNDEF NOTFORHELP}
  TsSystemMenu = class;

  TsCaptionButton = record
    State,
    GlowID,
    ImageIndex: integer;

    Rect: TRect;
    HitCode: Cardinal;
    Timer: TacSBAnimation;
    HaveAlignment: boolean;
  end;

  PsCaptionButton = ^TsCaptionButton;

  TacAddedTitle = class(TPersistent)
  private
    FShowMainCaption: boolean;
    procedure SetShowMainCaption(const Value: boolean);
  protected
    FFont: TFont;
    FText: acString;
    procedure SetText(const Value: acString);
    procedure SetFont(const Value: TFont);
    procedure Repaint;
  public
    FOwner: TsSkinProvider;
    constructor Create; virtual;
    destructor Destroy; override;
  published
    property Font: TFont read FFont write SetFont;
    property Text: acString read FText write SetText;
    property ShowMainCaption: boolean read FShowMainCaption write SetShowMainCaption default True;
  end;
{$ENDIF} // NOTFORHELP


  TsTitleButton = class(TCollectionItem)
{$IFNDEF NOTFORHELP}
  private
    FOnMouseUp,
    FOnMouseDown: TMouseEvent;

    FEnabled,
    FVisible,
    FUseSkinData: boolean;

    FName: string;
    FGlyph: TBitmap;
    FHint: acString;
    procedure SetName   (const Value: string);
    procedure SetGlyph  (const Value: TBitmap);
    procedure SetVisible(const Value: boolean);
    procedure MouseDown(BtnIndex: integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseUp  (BtnIndex: integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnGlyphChange(Sender: TObject);
  public
{$IFDEF TNTUNICODE}
    HintWnd: TTntHintWindow;
{$ELSE}
    HintWnd: THintWindow;
{$ENDIF}
    Data: TsCaptionButton;
    procedure AssignTo(Dest: TPersistent); override;
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    function GetDisplayName: string; override;
  published
{$ENDIF} // NOTFORHELP
    property Enabled: boolean read FEnabled write FEnabled default True;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property Hint: acString read FHint write FHint;
    property Name: string read FName write SetName;
    property UseSkinData: boolean read FUseSkinData write FUseSkinData default True;
    property Visible: boolean read FVisible write SetVisible default True;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp:   TMouseEvent read FOnMouseUp   write FOnMouseUp;
  end;


  TsTitleButtons = class(TCollection)
{$IFNDEF NOTFORHELP}
  private
    FOwner: TsSkinProvider;
    function  GetItem(Index: Integer): TsTitleButton;
    procedure SetItem(Index: Integer; Value: TsTitleButton);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TsSkinProvider);
    destructor Destroy; override;
{$ENDIF} // NOTFORHELP
    property Items[Index: Integer]: TsTitleButton read GetItem write SetItem; default;
  end;


  TsTitleIcon = class (TPersistent)
{$IFNDEF NOTFORHELP}
  private
    FHeight,
    FWidth: integer;

    FOwner: TsSkinProvider;
    FGlyph: TBitmap;
    FVisible: boolean;
    procedure SetGlyph  (const Value: TBitmap);
    procedure SetVisible(const Value: boolean);
  public
    constructor Create(AOwner: TsSkinProvider);
    destructor Destroy; override;
  published
{$ENDIF} // NOTFORHELP
    property Glyph:   TBitmap read FGlyph   write SetGlyph;
    property Height:  integer read FHeight  write FHeight    default 0;
    property Width:   integer read FWidth   write FWidth     default 0;
    property Visible: boolean read FVisible write SetVisible default True;
  end;


{$IFNDEF NOTFORHELP}
  TacMenuItemPos = (ipTop, ipBottom, ipBeforeClose);

  TacSysSubMenu = class(TPersistent)
  private
    FCaption: string;
    FPosition: TacMenuItemPos;
    FPopupMenu: TPopupMenu;
  public
    constructor Create(AOwner: TsSkinProvider);
  published
    property Caption: string read FCaption write FCaption;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property Position: TacMenuItemPos read FPosition write FPosition default ipBeforeClose;
  end;


  TacFormHeader = class(TPersistent)
  private
    FOwner: TsSkinProvider;
    FAdditionalHeight: integer;
    procedure SetAdditionalHeight(const Value: integer);
  public
    constructor Create(AOwner: TsSkinProvider);
  published
    property AdditionalHeight: integer read FAdditionalHeight write SetAdditionalHeight;
  end;


  TacLabelsColors = array of TacLabelColor;
{$ENDIF} // NOTFORHELP

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsSkinProvider = class(TComponent)
{$IFNDEF NOTFORHELP}
  private
    CurrentHT,
    UserBtnIndex,
    FSnapBuffer: integer;

    RgnChanged,
    FScreenSnap,
    FShowAppIcon,
    FMakeSkinMenu,
    FUseGlobalColor,
    ControlsChanged,
    FAllowAnimation,
    FDrawClientArea,
    FAllowExtBorders,
    FirstInitialized,
    FAllowSkin3rdParty,
    FAllowBlendOnMoving,
    FDrawNonClientArea: boolean;

    FIconRect,
    FHintRect: TRect;

    FTitleSkin,
    FMenuLineSkin: TsSkinSection;

    FHintTimer:        TTimer;
    FGripMode:         TsGripMode;
    FTitleIcon:        TsTitleIcon;
    FGluedForms:       TStringList;
    FResizeMode:       TsResizeMode;
    FAddedTitle:       TacAddedTitle;
    FSysSubMenu:       TacSysSubMenu;
    FTitleButtons:     TsTitleButtons;
    FCaptionAlignment: TAlignment;

    FOnSkinItem:       TAddItemEvent;
    FOnExtHitTest:     TacNCHitTest;
    FOnAfterAnimation: TacAfterAnimation;
    FOnSkinItemEx:     TAddItemExEvent;
    FFormHeader:       TacFormHeader;
    FThirdParty:       ThirdPartyList;
    FDisabledBlendValue: byte;

    procedure OnHintTimer(Sender: TObject);
    procedure StartHintTimer(TitleItem: TacTitleBarItem);

    function GetLinesCount: integer; // Returns a count of menu lines
    procedure OnChildMnuClick(Sender: TObject);
    procedure SetCaptionAlignment  (const Value: TAlignment);
    procedure SetDisabledBlendValue(const Value: byte);
    procedure SetShowAppIcon       (const Value: boolean);
    procedure SetUseGlobalColor    (const Value: boolean);
    procedure SetDrawNonClientArea (const Value: boolean);
    procedure SetAllowExtBorders   (const Value: boolean);
    procedure SetTitleSkin         (const Value: TsSkinSection);
    procedure SetMenuLineSkin      (const Value: TsSkinSection);
    procedure SetTitleBar          (const Value: TsTitleBar);
    procedure SetTitleButtons      (const Value: TsTitleButtons);
    procedure SetGluedForms        (const Value: TStringList);

    function HaveSysMenu: boolean;
    procedure InitIndexes;
  protected
    bCapture,
    bInProcess,
    FSysExHeight,
    ClearButtons,
    OwnThirdLists,
    MenusInitialized,
    FMenuOwnerDraw: boolean;

    VCenter,
    LockCount,
    FLinesCount,
    FHeaderIndex,
    FHeaderHeight,
    FTitleSkinIndex,
    FCaptionSkinIndex: integer;

    NormalBounds,
    LastClientRect: TRect;

    FGlow1,
    FGlow2,
    TempBmp,
    CoverBmp,
    MenuLineBmp: TBitmap;

    MDIMin,
    MDIMax,
    ButtonMin,
    ButtonMax,
    ButtonHelp,
    ButtonClose,
    MDIClose: TsCaptionButton;

    ArOR:             TAOR;
    HotItem:          TMenuItemData;
    FTitleBar:        TsTitleBar;
    LayerForm,
    CoverForm:        TForm;
    FormTimer:        TacThreadedTimer;
    FCommonData:      TsScrollWndData;
    SavedLabelColors: TacLabelsColors;

    procedure AdapterRemove;
    procedure AdapterCreate;
    procedure SendToAdapter(Message: TMessage);
    // Painting procedures <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    function  PaintAll: boolean;
    function  HeaderUsed: boolean;
    procedure PaintForm(DC: hdc; SendUpdated: boolean = True);
    procedure PaintCaption(DC: hdc);

    procedure PaintTitleContent(CaptWidth: integer);
    procedure PaintTitleItem(Item: TacTitleBarItem; R: TRect; Bmp: TBitmap);
    procedure UpdateLayerForm;

    procedure RepaintButton(i: integer);
{$IFNDEF FPC}
    procedure RepaintMenuItem(mi: TMenuItem; R: TRect; State: TOwnerDrawState);
{$ENDIF}
    procedure SaveBGForBtns(CaptWidth: integer; Full: boolean = False);
    procedure RestoreBtnsBG(CaptWidth: integer);

    procedure OurPaintHandler(const Msg: TWMPaint);
    procedure ProcessMessage(Msg: Cardinal; WPar: WPARAM = 0; LPar: LPARAM = 0);

{$IFNDEF DISABLEPREVIEWMODE}
    procedure AC_ASEMSG             (var Message: TMessage);
    procedure AC_WMCopyData         (var Message: TWMCopyData);
{$ENDIF}
    function AC_SMAlphaCmd_Common   (var Message: TMessage): boolean;
    function AC_SMAlphaCmd_Skinned  (var Message: TMessage): boolean;
    function AC_SMAlphaCmd_Unskinned(var Message: TMessage): boolean;

    procedure AC_CMEnabledChanged   (var Message: TMessage);
    procedure AC_CMFloat            (var Message: TMessage);
    procedure AC_CMMenuChanged      (var Message: TMessage);
    procedure AC_CMMouseEnter       (var Message: TMessage);
    procedure AC_CMRecreateWnd      (var Message: TMessage);
    procedure AC_CMShowingChanged   (var Message: TMessage);
{$IFNDEF ALITE}
    procedure AC_CMMouseWheel       (var Message: TCMMouseWheel);
{$ENDIF}
    procedure AC_WMActivate         (var Message: TWMActivate);
    procedure AC_WMActivateApp      (var Message: TMessage);
    procedure AC_WMChildActivate    (var Message: TMessage);
{$IFNDEF FPC}
    procedure AC_WMContextMenu      (var Message: TMessage);
{$ENDIF}
    procedure AC_WMControlListChange(var Message: TCMControlListChange);
    procedure AC_WMCreate           (var Message: TMessage);
    procedure AC_WMEnterMenuLoop    (var Message: TMessage);
    procedure AC_WMEraseBkGnd       (var Message: TMessage);
    procedure AC_WMEraseBkGndHandler(aDC: hdc);
    procedure AC_WMExitMenuLoop     (var Message: TMessage);
    procedure AC_WMExitSizeMove     (var Message: TMessage);
    procedure AC_WMGetMinMaxInfo    (var Message: TWMGetMinMaxInfo);
{$IFNDEF FPC}
    procedure AC_WMInitMenuPopup    (var Message: TWMInitMenuPopup);
{$ENDIF}
    procedure AC_WMLButtonUp        (var Message: TWMNCLButtonUp);
    procedure AC_WMMDIDestroy       (var Message: TMessage);
    procedure AC_WMMeasureItem      (var Message: TMessage);
    procedure AC_WMMove             (var Message: TMessage);
    procedure AC_WMMouseLeave       (var Message: TMessage);
    procedure AC_WMMouseMove        (var Message: TMessage);
    procedure AC_WMNCActivate       (var Message: TWMNCActivate);
    procedure AC_WMNCCreate         (var Message: TMessage);
    procedure AC_WMNCDestroy;
    procedure AC_WMNCHitTest        (var Message: TMessage);
    procedure AC_WMNCLButtonDblClick(var Message: TMessage);
    procedure AC_WMNCLButtonDown    (var Message: TWMNCLButtonDown);
    procedure AC_WMNCMouseMove      (var Message: TWMNCMouseMove);
    procedure AC_WMNCPaint          (var Message: TMessage);
    procedure AC_WMNCPaintHandler;
    procedure AC_WMNCRButtonDown    (var Message: TMessage);
    procedure AC_WMNCRButtonUp      (var Message: TWMNCLButtonDown);
    procedure AC_WMNotify           (var Message: TMessage);
    procedure AC_WMPaint            (var Message: TMessage);
    procedure AC_WMParentNotify     (var Message: TMessage);
    procedure AC_WMPrint            (var Message: TMessage);
    procedure AC_WMQueryEndSession  (var Message: TMessage);
    procedure AC_WMSetIcon          (var Message: TMessage);
    procedure AC_WMSetRedraw        (var Message: TMessage);
    procedure AC_WMSetText          (var Message: TMessage);
    procedure AC_WMSettingChange    (var Message: TMessage);
    procedure AC_WMSize             (var Message: TMessage);
    procedure AC_WMSizing           (var Message: TMessage);
    procedure AC_WMShowWindow       (var Message: TMessage);
    procedure AC_WMStyleChanged     (var Message: TMessage);
    procedure AC_WMSysColorChange   (var Message: TMessage);
    procedure AC_WMSysCommand       (var Message: TMessage);
    procedure AC_WMVisibleChanged   (var Message: TMessage);
    procedure AC_WMWindowPosChanged (var Message: TMessage);
    procedure AC_WMWindowPosChanging(var Message: TWMWindowPosChanging);
{$IFNDEF NOWNDANIMATION}
    procedure AC_WMWindowPosChanged_Unskinned (var Message: TWMWindowPosChanged);
    procedure AC_CMVisibleChanged_Unskinned   (var Message: TMessage);
    procedure AC_WMClose                      (var Message: TMessage);
    procedure StartMoveForm;
{$ENDIF}
    // Special calculations <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    function HTProcess(var Message: TWMNCHitTest): integer;
    function CursorToPoint(const x, y: integer): TPoint;
    function MDIButtonsNeeded: boolean;
    function RBGripPoint(const ImgIndex: integer): TPoint;
    function FormLeftTop: TPoint;
    function SysButtonsCount: integer;
    function SmallButtonWidth: integer;
    function ButtonHeight: integer;
    function SmallButtonHeight: integer;
    procedure SendOwnerToBack;

    function LimitRect(db: integer; R: TRect; Invert: boolean = False): TRect;
    function CheckEdges(rStatic, rDynamic: TRect; NewX, NewY: integer): TSize;
    procedure CheckNewPosition(var X: integer; var Y: integer);
    function Linked(f: TForm): boolean;
    procedure MoveGluedForms(BlendMoving: boolean = False);
    procedure UpdateSlaveFormsList;

    function SysButtonWidth(const Btn: TsCaptionButton): integer;
    function TitleBtnsWidth: integer;
    function UserButtonWidth(const Btn: TsTitleButton): integer;
    function BarWidth(const i: integer): integer;
    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    procedure KillAnimations;
    procedure UpdateIconsIndexes;

    procedure StartMove     (X, Y: Integer);
    procedure StopMove      (X, Y: Integer);
    procedure DrawFormBorder(X, Y: Integer);

    procedure SetHotHT    (const i: integer; const Repaint: boolean = True);
    procedure SetPressedHT(const i: integer);

    function ActualTitleHeight(Max: boolean = False): integer;
    function GetTopCoord: integer; virtual;
    function FormChanged: boolean;
    function IconVisible: boolean;
    function TitleSkinSection: string;
    procedure TryInitMenu;
    procedure CheckSysMenu(const Skinned: boolean);
    procedure InitExBorders(const Active: boolean);
  public
    RTInit,
    RTEmpty,
    InAero,
    InMenu,
    fAnimating,
    BigButtons,
    FormActive,
    MenuChanged,
    RgnChanging,
    FInAnimation,
    SkipAnimation: boolean;

    Form,
    CaptForm: TForm;

    ThirdLists: TStringLists;

    MDIForm: TObject;
    ListSW: TacScrollWnd;
    OldWndProc: TWndMethod;
    Adapter: TacCtrlAdapter;
    ShowAction: TShowAction;
    SystemMenu: TsSystemMenu;
    BorderForm: TacBorderForm;
    OldCaptFormProc: TWndMethod;

{$IFDEF DEBUG}
    FFormState: Cardinal;
    procedure SetFormState(const Value: Cardinal);
    property FormState: Cardinal read FFormState write SetFormState;
{$ELSE}
    FormState: Cardinal;
{$ENDIF}

    procedure CalcItems;
    constructor Create(AOwner: TComponent); override;
    constructor CreateRT(AOwner: TComponent; InitRT: boolean = True);
    destructor Destroy; override;
    procedure DropSysMenu(x, y: integer);
    procedure AfterConstruction; override;
    procedure Loaded; override;
    procedure LoadInit;
    procedure InitLabel(const Control: TControl; const Skinned: boolean);
    procedure PrepareForm;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function OffsetX: integer;
    function OffsetY: integer;
    function ShadowSize: TRect;

    procedure NewWndProc(var Message: TMessage);  // Main window procedure hook

    procedure HookMDI(Active: boolean = True);
    function HeaderHeight: integer;  // Height of the header + menu lines
    function BorderHeight (CheckSkin: boolean = True): integer;
    function BorderWidth  (CheckSkin: boolean = True): integer;
    function CaptionHeight(CheckSkin: boolean = True): integer;
    function CaptionWidth: integer;
    function MenuHeight: integer;
    function MenuPresent: boolean;
    function FormColor: TColor;

    procedure MdiIcoFormPaint(Sender: TObject);

    procedure CaptFormPaintDC(aDC: hdc);
    procedure CaptFormPaint(Sender: TObject);
    procedure NewCaptFormProc(var Message: TMessage);
    procedure UpdateTitleBar;

    function UpdateMenu: boolean;
{$IFNDEF FPC}
    procedure InitMenuItems(A: boolean);
{$ENDIF}
    procedure RepaintMenu;
    property IconRect: TRect read FIconRect;
    property LinesCount: integer read GetLinesCount;
  published
{$ENDIF} // NOTFORHELP
    property AllowAnimation:     boolean read FAllowAnimation     write FAllowAnimation      default True;
    property AllowExtBorders:    boolean read FAllowExtBorders    write SetAllowExtBorders   default True;
    property AllowBlendOnMoving: boolean read FAllowBlendOnMoving write FAllowBlendOnMoving  default True;
    property AllowSkin3rdParty:  boolean read FAllowSkin3rdParty  write FAllowSkin3rdParty   default True;
    property DrawNonClientArea:  boolean read FDrawNonClientArea  write SetDrawNonClientArea default True;
    property DrawClientArea:     boolean read FDrawClientArea     write FDrawClientArea      default True;
    property MakeSkinMenu:       boolean read FMakeSkinMenu       write FMakeSkinMenu        default DefMakeSkinMenu;
    property ScreenSnap:         boolean read FScreenSnap         write FScreenSnap          default False;
    property ShowAppIcon:        boolean read FShowAppIcon        write SetShowAppIcon       default True;
    property UseGlobalColor:     boolean read FUseGlobalColor     write SetUseGlobalColor    default True;

    property AddedTitle: TacAddedTitle read FAddedTitle write FAddedTitle;
    property CaptionAlignment: TAlignment read FCaptionAlignment write SetCaptionAlignment default Classes.taLeftJustify;
    property DisabledBlendValue: byte read FDisabledBlendValue write SetDisabledBlendValue default MaxByte;
    property FormHeader: TacFormHeader read FFormHeader write FFormHeader;
    property GluedForms: TStringList read FGluedForms write SetGluedForms;
    property SkinData: TsScrollWndData read FCommonData write FCommonData;
    property GripMode: TsGripMode read FGripMode write FGripMode default gmNone;
    property ResizeMode: TsResizeMode read FResizeMode write FResizeMode default rmStandard;
    property SnapBuffer: integer read FSnapBuffer write FSnapBuffer default 10;
    property SysSubMenu: TacSysSubMenu read FSysSubMenu write FSysSubMenu;
    property TitleBar: TsTitleBar read FTitleBar write SetTitleBar;
    property TitleButtons: TsTitleButtons read FTitleButtons write SetTitleButtons;
    property TitleIcon: TsTitleIcon read FTitleIcon write FTitleIcon;
    property TitleSkin: TsSkinSection read FTitleSkin write SetTitleSkin;
    property ThirdParty: ThirdPartyList read FThirdParty write FThirdParty;
    property MenuLineSkin: TsSkinSection read FMenuLineSkin write SetMenuLineSkin;

    {:@event}
    property OnAfterAnimation: TacAfterAnimation read FOnAfterAnimation write FOnAfterAnimation;
    property OnExtHitTest: TacNCHitTest    read FOnExtHitTest write FOnExtHitTest;
    property OnSkinItem:   TAddItemEvent   read FOnSkinItem   write FOnSkinItem;
    property OnSkinItemEx: TAddItemExEvent read FOnSkinItemEx write FOnSkinItemEx;
  end;
{$IFNDEF NOTFORHELP}


  TacSBAnimation = class(TTimer)
  public
    CurrentLevel,
    CurrentState,
    MaxIterations: integer;

    BorderForm: TacBorderForm;
    SkinData: TsCommonData;
    FormHandle: hwnd;
    PBtnData: PsCaptionButton;
    Up: boolean;
    AForm: TForm;
    ABmp: TBitmap;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetFormBounds: TRect;
    function Offset: integer;
    function Step: integer;
    procedure MakeForm;
    procedure UpdateForm(const Blend: integer);
    procedure StartAnimation(NewState: integer; ToUp: boolean);
    procedure ChangeState   (NewState: integer; ToUp: boolean);
    procedure MakeImg;
    procedure CheckMouseLeave;
    procedure OnAnimTimer(Sender: TObject);
  end;


  TacBorderForm = class(TPersistent)
  protected
    LastTopLeft,
    LastMousePos: TPoint;

    LeftPressed,
    acInMouseMsg,
    MovRgnChanged,
    MaxMoving: boolean;

    FOwner: TObject;
    sp: TsSkinProvider;
  public
    ExBorderShowing,
    ResetRgn: boolean;

    AForm: TForm;
    OldBorderProc: TWndMethod;
    ShadowTemplate: TBitmap;
    ParentHandle: THandle;
    SkinData: TsCommonData;

    constructor Create(AOwner: TObject);
    procedure CreateNewForm;
    destructor Destroy; override;
    procedure KillAnimations;
    function OffsetX: integer;
    function OffsetY: integer;
    // Access from owners
    function ButtonMin:   TsCaptionButton;
    function ButtonMax:   TsCaptionButton;
    function ButtonClose: TsCaptionButton;
    function ButtonHelp:  TsCaptionButton;

    function OwnerHandle: hwnd;
    function ShadowSize: TRect;
    function CaptionHeight(CheckSkin: boolean = True): integer;
    function MenuHeight: integer;
    function IconRect: TRect;
    procedure SetHotHT(const i: integer; Repaint: boolean = True);
    procedure PaintAll;
    function MinTopCoord: integer;
    function MakeRgn(NewWidth: integer = 0; NewHeight: integer = 0): HRGN;
    function FormState: cardinal;
    procedure UpdateRgn;

    procedure SendOwnerToBack;
    procedure UpdateExBordersPos(Redraw: boolean = True; Blend: byte = MaxByte);

    procedure BorderProc    (var Message: TMessage);
    function Ex_WMNCHitTest (var Message: TWMNCHitTest): integer;
    function Ex_WMSetCursor (var Message: TWMSetCursor): boolean;
    function MouseAboveTheShadow(Message: TWMMouse): boolean;
    function GetTopWnd: THandle;
  end;


{$IFDEF TNTUNICODE}
  TsCustomSysMenu = class(TTntPopupMenu)
{$ELSE}
  TsCustomSysMenu = class(TPopupMenu)
{$ENDIF}
  public
    function VisibleClose:   boolean; virtual; abstract;
    function VisibleMax:     boolean; virtual; abstract;
    function VisibleMin:     boolean; virtual; abstract;
    function EnabledMax:     boolean; virtual; abstract;
    function EnabledMin:     boolean; virtual; abstract;
    function EnabledRestore: boolean; virtual; abstract;
  end;


  TsSystemMenu = class(TsCustomSysMenu)
  public
    SubMenu,
    ItemMove,
    ItemSize,
    ItemClose,
    ItemRestore,
    ItemMinimize,
    ItemMaximize: TMenuItem;

    ExtItemsCount: integer;
    FOwner: TsSkinProvider;
    FForm: TCustomForm;
    constructor Create(AOwner: TComponent); override;
    procedure Generate;
    procedure UpdateItems(Full: boolean = False);
    procedure UpdateGlyphs;
    procedure MakeSkinItems;

    function VisibleRestore: boolean;
    function VisibleSize:    boolean;
    function VisibleMin:     boolean; override;
    function VisibleMax:     boolean; override;
    function VisibleClose:   boolean; override;

    function EnabledRestore: boolean; override;
    function EnabledMin:     boolean; override;
    function EnabledMax:     boolean; override;
    function EnabledMove:    boolean;
    function EnabledSize:    boolean;
    function EnabledClose:   boolean;

    procedure RestoreClick (Sender: TObject);
    procedure MoveClick    (Sender: TObject);
    procedure SizeClick    (Sender: TObject);
    procedure MinClick     (Sender: TObject);
    procedure MaxClick     (Sender: TObject);
    procedure CloseClick   (Sender: TObject);
    procedure SkinSelect   (Sender: TObject);
    procedure ExtClick     (Sender: TObject);
  end;


{$IFNDEF NOTFORHELP}
  TacAdapterItems = array of TacAdapterItem;
  TacGraphItems = array of TacGraphItem;
{$ENDIF}


  TacCtrlAdapter = class(TPersistent)
{$IFNDEF NOTFORHELP}
  protected
    bFlag: boolean;
  public
    CtrlClass: TObject;
    DefaultSection: string;
    Items: TacAdapterItems;
    GraphItems: TacGraphItems;
    Provider: TsSkinProvider;
    function IsControlSupported(Control: TComponent): boolean;
    function Count: integer;
    constructor Create(AProvider: TsSkinProvider);
    destructor Destroy; override;
    function GetItem(Index: integer): TacAdapterItem;
    function GetCommonData(Index: integer): TsCommonData;
    function IndexOf(Ctrl: TWinControl): integer;
    procedure AfterConstruction; override;
{$ENDIF} // NOTFORHELP
    procedure AddAllItems(OwnerCtrl: TWinControl = nil);
    procedure AddNewItem(const Ctrl: TSpeedButton); overload;
    procedure AddNewItem(const Ctrl: TWinControl); overload;
    procedure AddNewItem(const Ctrl: TWinControl; const SkinSection: string); overload;
    procedure RemoveItem(Index: integer);
    procedure RemoveAllItems;
    procedure CleanItems;
    procedure WndProc(var Message: TMessage);
  end;


  TacMoveTimer = class(TacThreadedTimer)
  public
    BlendValue: byte;
    FormHandle: THandle;
    BorderForm: TacBorderForm;

    BlendStep,
    CurrentBlendValue: real;
    procedure TimeHandler; override;
  end;


const
  // FormStates
  FS_SIZING         = $1;
  FS_BLENDMOVING    = $80;
  FS_ANIMMINIMIZING = $100;
  FS_ANIMCLOSING    = $200;
  FS_ANIMRESTORING  = $400;
  FS_THUMBDRAWING   = $800;
  FS_CHANGING       = $1000;

  FS_MAXHEIGHT      = $2000;
  FS_MAXWIDTH       = $4000;
  FS_ACTIVATE       = $8000;
  FS_LOCKED         = $10000;   // Lock for animation
  FS_SCROLLUPDATING = $20000;   // Update ListSW object
  FS_POSCHANGING    = $40000;
  FS_ZOOMING        = $80000;
  FS_DISABLED       = $100000;

  ScrollWidth       = 18;
  IconicHeight      = 26;

  HTUDBTN           = 1000;

var
  ItemsRemoving: boolean = False;


function AeroIsEnabled: boolean;
function ForbidSysAnimating: boolean;
procedure InitDwm(const Handle: THandle; const Skinned: boolean; const Repaint: boolean = False);
function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: DWORD; pvAttribute: Pointer; cbAttribute: DWORD): HResult;
procedure DwmInvalidateIconicBitmaps(hwnd: HWND);
function IsBorderUnchanged(const BorderIndex: integer; const sm: TsSkinManager): boolean;
procedure UpdateRgn(sp: TsSkinProvider; Repaint: boolean = True; AllChildren: boolean = False);
procedure FillArOR (sp: TsSkinProvider);
function GetRgnFromArOR(sp: TsSkinProvider; X: integer = 0; Y: integer = 0): hrgn;
procedure UpdateSkinCaption(SkinProvider: TsSkinProvider);
procedure UpdateProviderThirdNames(sm: TsSkinProvider);
function GetSkinProvider(Cmp: TComponent): TsSkinProvider;
function GetWindowWidth (Handle: hwnd): integer;
function GetClientWidth (Handle: hwnd): integer;
function GetWindowHeight(Handle: hwnd): integer;
function GetClientHeight(Handle: hwnd): integer;

function SkinMenuOffset (const sp: TsSkinProvider): TPoint;
function SkinTitleHeight(const BorderForm: TacBorderForm): integer;
function SkinBorderWidth(const BorderForm: TacBorderForm): integer;
function DiffTitle      (const BorderForm: TacBorderForm): integer;
function DiffBorder     (const BorderForm: TacBorderForm): integer;
function SysBorderWidth (const Handle: hwnd; const BorderForm: TacBorderForm; CheckSkin: boolean = True): integer;
function SysBorderHeight(const Handle: hwnd; const BorderForm: TacBorderForm; CheckSkin: boolean = True): integer;
function SysCaptHeight(Form: TForm): integer;

{$IFNDEF NOWNDANIMATION}
function StartMinimizing(sp: TsSkinProvider): boolean;
function  StartRestoring (sp: TsSkinProvider): boolean;

procedure StartBlendOnMoving (sp: TsSkinProvider; ToMove: boolean = True);
procedure FinishBlendOnMoving(sp: TsSkinProvider; CoverForm: TForm = nil);
{$ENDIF}
function GetFormImage(sp: TsSkinProvider; CacheReplaced: boolean = False): TBitmap;
function MakeCoverForm(Wnd: THandle): TForm;

procedure StartSBAnimation(const Btn: PsCaptionButton; const State: integer; const Iterations: integer; const ToUp: boolean; const SkinProvider: TsSkinProvider; acDialog: pointer = nil);
{$IFNDEF DELPHI6UP}
function GetWindowThreadProcessId(hWnd: THandle; var dwProcessId: DWORD): DWORD; stdcall; overload;
{$ENDIF}
function SetThumbIcon (Handle: HWND; sp: TsSkinProvider; Width, Height: integer): boolean;
function SetPreviewBmp(Handle: HWND; sp: TsSkinProvider): boolean;
{$ENDIF} // NOTFORHELP

implementation


uses
  math, CommCtrl, ComCtrls, StdCtrls,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFDEF ADDWEBBROWSER} acWB, {$ENDIF}
  {$IFNDEF ALITE} sFrameAdapter, sScrollBox, acAlphaHints, {$ENDIF}
  sVclUtils, sBorders, sGraphUtils, sSkinProps, sLabel, sMaskData, acntUtils, sMessages, sStyleSimply, sMDIForm,
  sAlphaGraph, acDials, acAlphaImageList, sThirdParty;


const
  FS_MAXBOUNDS = FS_MAXHEIGHT or FS_MAXWIDTH;
  FS_FULLPAINTING = FS_CHANGING or FS_BLENDMOVING or FS_ANIMMINIMIZING;
  HTITEM = 2000;

  UserButtonsOffset = 6;

var
  FSysWndCaptHeight:  integer = 0;
  FSysToolCaptHeight: integer = 0;

type
  _DWM_BLURBEHIND = packed record
    dwFlags: DWORD;
    fEnable: Bool;
    hRgnBlur: HRGN;
    fTransitionOnMaximized: Bool;
  end;


  TacMinTimer = class(TacThreadedTimer)
  public
    CurrentAlpha,
    BlendStep,
    CurRight,
    CurLeft,
    CurTop,
    CurBottom: real;

    StepCount,
    XFrom,
    YFrom,
    XTo,
    YTo: integer;

    DeltaX,
    DeltaY,
    DeltaW,
    DeltaH: real;

    AlphaOrigin,
    AlphaTo: byte;

    RectFrom,
    RectTo: TRect;

    TBPosition: Cardinal;
    AnimForm: TForm;

    sp: TsSkinProvider;
    FormHandle: THandle;
    BorderForm: TacBorderForm;
    SavedImage, AlphaBmp: TBitmap;
    Minimized, AlphaFormWasCreated: boolean;

    function AlphaFrom: byte;
    constructor Create(AOwner: TComponent); override;
    constructor CreateOwned(AOwner: TComponent; ChangeEvent: boolean); override;
    destructor Destroy; override;
    function GetRectTo: TRect;
    procedure InitData;
    procedure UpdateDstRect;
    procedure TimeHandler; override;
  end;


  PDWM_BLURBEHIND = ^_DWM_BLURBEHIND;
  TDWM_BLURBEHIND = _DWM_BLURBEHIND;


var
  hDWMAPI: HMODULE = 0;

  ntop, nleft, nbottom, nright, nX, nY, nDirection, nMinHeight, nMinWidth, nDC: Integer;
  bMode: Boolean; // True - move, False - size
  deskwnd: HWND;
  formDC: HDC;

  biClicked:   boolean = False;
  MDICreating: boolean = False;
  ChildProvider: TsSkinProvider = nil;
  MDIIconsForm: TForm = nil;

  GluedArray: array of TacFormsCouple;


_DwmSetIconicThumbnail:         function(hwnd: HWND; hbmp: HBITMAP; dwSITFlags: DWORD): HResult; stdcall;
_DwmSetIconicLivePreviewBitmap: function(hwnd: HWND; hbmp: HBITMAP; var pptClient: TPoint; dwSITFlags: DWORD): HResult; stdcall;
_DwmSetWindowAttribute:         function(hwnd: HWND; dwAttribute: DWORD; pvAttribute: Pointer; cbAttribute: DWORD): HResult; stdcall;
_DwmEnableBlurBehindWindow:     function(hWnd: HWND; const pBlurBehind: PDWM_BLURBEHIND): HRESULT; stdcall;
_DwmInvalidateIconicBitmaps:    function(hwnd: HWND): HResult; stdcall;
_DwmIsCompositionEnabled:       function(out pfEnabled: BOOL): HResult; stdcall;


const
  ModName = 'DWMAPI.DLL';
  iMinBorderSize = 6;


type
  TacItemSkinData = class(TObject)
  public
    SkinIndex: integer;
    SkinSection: string;
  end;

  PacItemSkinData = ^TacItemSkinData;


procedure InitDwmApi;
begin
  if hDWMAPI = 0 then
    hDWMAPI := LoadLibrary(ModName);
end;


procedure DelFromGluedArray(f: TForm);
var
  n, l: integer;
begin
  l := Length(GluedArray);
  n := 0;
  while n < l do begin
    if GluedArray[n].Slave = f then begin
      if n <> l - 1 then begin
        GluedArray[n].Master := GluedArray[l - 1].Master;
        GluedArray[n].Slave  := GluedArray[l - 1].Slave;
      end;
      SetLength(GluedArray, l - 1);
    end;
    inc(n);
  end;
end;


function SetThumbIcon(Handle: HWND; sp: TsSkinProvider; Width, Height: integer): boolean;
Const
  Flag = 0;
var
  Bmp, BmpForm, SrcBmp: TBitmap;
  w, h: integer;
begin
  Result := False;
  if (Win32MajorVersion >= 6) and (Width <> 0) and (Height <> 0) then begin
    if not Assigned(_DwmSetIconicThumbnail) then begin
      InitDwmApi;
      if hDWMAPI > 0 then begin
        _DwmSetIconicThumbnail := GetProcAddress(hDWMAPI, 'DwmSetIconicThumbnail');
        if not Assigned(_DwmSetIconicThumbnail) then
          Exit;
      end
    end;
    if (sp.FormTimer <> nil) and (sp.FormTimer is TacMintimer) and TacMintimer(sp.FormTimer).Minimized then
      SrcBmp := TacMintimer(sp.FormTimer).SavedImage
    else
      SrcBmp := sp.SkinData.FCacheBmp;

    if (SrcBmp <> nil) and not SrcBmp.Empty then begin
      if Width / Height <= SrcBmp.Width / SrcBmp.Height then begin // Width is a main size
        w := Width;
        h := Round(w * SrcBmp.Height / SrcBmp.Width);
      end
      else begin
        h := Height;
        w := Round(h * SrcBmp.Width / SrcBmp.Height);
      end;
      if (w <> 0) and (h <> 0) then begin
        sp.FormState := sp.FormState or FS_THUMBDRAWING;
        Bmp := CreateBmp32(w, h);
        // Fast out
        Stretch(SrcBmp, Bmp, w, h, ftTriangle);
        if _DwmSetIconicThumbnail(Handle, Bmp.Handle, Flag) <> S_OK then
          Bmp.Free
        else begin
          Result := True;
          if SrcBmp = sp.SkinData.FCacheBmp then begin
            // Full out
            BmpForm := CreateBmp32(SrcBmp);
            BmpForm := GetFormImage(sp);
            Stretch(BmpForm, Bmp, w, h, ftTriangle);
            _DwmSetIconicThumbnail(Handle, Bmp.Handle, Flag);
            FreeAndNil(BmpForm);
            if sp.BorderForm <> nil then
              sp.BorderForm.UpdateExBordersPos(False); // Repaint cache
          end;
          FreeAndNil(Bmp);
          sp.FormState := sp.FormState and not FS_THUMBDRAWING;
        end;
      end;
    end;
  end;
end;


function SetPreviewBmp(Handle: HWND; sp: TsSkinProvider): boolean;
const
  Flag = 1;
var
  p: TPoint;
  BmpForm, SrcBmp: TBitmap;
begin
  Result := False;
  if (Win32MajorVersion >= 6) then begin
    if not Assigned(_DwmSetIconicLivePreviewBitmap) then begin
      InitDwmApi;
      if hDWMAPI > 0 then begin
        _DwmSetIconicLivePreviewBitmap := GetProcAddress(hDWMAPI, 'DwmSetIconicLivePreviewBitmap');
        if not Assigned(_DwmSetIconicLivePreviewBitmap) then
          Exit;
      end
    end;
    if (sp.FormTimer <> nil) and (sp.FormTimer is TacMintimer) and TacMintimer(sp.FormTimer).Minimized then
      SrcBmp := TacMintimer(sp.FormTimer).SavedImage
    else
      SrcBmp := sp.SkinData.FCacheBmp;

    if (SrcBmp <> nil) and not SrcBmp.Empty then begin
      sp.FormState := sp.FormState or FS_THUMBDRAWING;
      p := MkPoint;
      if SrcBmp = sp.SkinData.FCacheBmp then begin
        // Full out
        BmpForm := CreateBmp32(SrcBmp);
        BmpForm := GetFormImage(sp);
        Result := _DwmSetIconicLivePreviewBitmap(Handle, BmpForm.Handle, p, Flag) = S_OK;
        FreeAndNil(BmpForm);
        if sp.BorderForm <> nil then
          sp.BorderForm.UpdateExBordersPos(False); // Repaint cache
      end
      else // Fast out
        Result := _DwmSetIconicLivePreviewBitmap(Handle, SrcBmp.Handle, p, Flag) = S_OK;

      sp.FormState := sp.FormState and not FS_THUMBDRAWING;
    end;
  end;
end;


function GetTopWindow: THandle;
begin
  Result := HWND_TOPMOST;
end;


procedure DwmInvalidateIconicBitmaps(hwnd: HWND);
begin
  if (Win32MajorVersion >= 6) then
    if Assigned(_DwmInvalidateIconicBitmaps) then
      _DwmInvalidateIconicBitmaps(hwnd)
    else
      if hDWMAPI > 0 then begin
        _DwmInvalidateIconicBitmaps := GetProcAddress(hDWMAPI, 'DwmInvalidateIconicBitmaps');
        if Assigned(_DwmInvalidateIconicBitmaps) then
          _DwmInvalidateIconicBitmaps(hwnd);
      end;
end;


function MakeCoverForm(Wnd: THandle): TForm;
var
  R: TRect;
  DC: hdc;
  Bmp: TBitmap;
begin
  Result := TForm.Create(nil);
  Result.Visible := False;
  Result.BorderStyle := bsNone;
  Result.Tag := ExceptTag;
  SetWindowLong(Result.Handle, GWL_EXSTYLE, GetWindowLong(Result.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE);
  SetClassLong(Result.Handle, GCL_STYLE, GetClassLong(Result.Handle, GCL_STYLE) and not NCS_DROPSHADOW);
  GetWindowRect(Wnd, R);
  Result.SetBounds(R.Left, R.Top, WidthOf(R), HeightOf(R));
  Bmp := CreateBmp32(Result.Width, Result.Height);
  // Copy the window image
  DC := GetWindowDC(Wnd);
  try
    BitBlt(Bmp.Canvas.Handle, 0, 0, Result.Width, Result.Height, DC, 0, 0, SRCCOPY);
    FillAlphaRect(Bmp, MkRect(Bmp), MaxByte);
  finally
    ReleaseDC(Wnd, DC);
  end;
  SetFormBlendValue(Result.Handle, Bmp, MaxByte);
  SetWindowPos(Result.Handle, HWND_TOPMOST, R.Left, R.Top, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
  FreeAndNil(Bmp);
end;


function ShellTrayWnd: THandle;
begin
  Result := FindWindow('Shell_TrayWnd', nil);
end;


procedure SetBlurBehindWindow(AHandle: HWND; AEnabled: Boolean; ARGN: HRGN);
const
  DWM_BB_ENABLE = 1;
  DWM_BB_BLURREGION = 2;
var
  _BlurBehind: TDWM_BLURBEHIND;
begin
  if hDWMAPI <> 0 then begin
    with _BlurBehind do begin
      dwFlags := DWM_BB_ENABLE;
      if ARGN <> 0 then
        dwFlags := dwFlags or DWM_BB_BLURREGION;

      fTransitionOnMaximized := False;
      hRgnBlur := ARGN;
      fEnable := AEnabled;
    end;
    if Pointer(@_DwmEnableBlurBehindWindow) <> nil then
      _DwmEnableBlurBehindWindow(AHandle, @_BlurBehind);

    if ARGN <> 0 then
      DeleteObject(ARGN);
  end;
end;


{$IFNDEF NOWNDANIMATION}
function StartMinimizing(sp: TsSkinProvider): boolean;
var
  h: THandle;
begin
  Result := False;
  if {(sp.BorderForm <> nil) or} (acWinVer < 6) or AeroIsEnabled then begin
    if sp.SkinData.SkinManager.AnimEffects.Minimizing.Active then begin
      Result := True;
      sp.KillAnimations;
      if (sp.FormState and FS_ANIMMINIMIZING = FS_ANIMMINIMIZING) then
        Exit;

      sp.FormState := sp.FormState or FS_ANIMMINIMIZING;
      sp.fAnimating := True;
      if Assigned(sp.FormTimer) and not (sp.FormTimer is TacMintimer) then
        FreeAndNil(sp.FormTimer);

      if not Assigned(sp.FormTimer) then
        sp.FormTimer := TacMinTimer.CreateOwned(sp, True)
      else
        if (sp.FormState and FS_ANIMRESTORING <> FS_ANIMRESTORING) then
          TacMinTimer(sp.FormTimer).InitData;

      sp.FormState := sp.FormState and not FS_ANIMRESTORING;
      if (TacMinTimer(sp.FormTimer).CurrentAlpha >= TacMinTimer(sp.FormTimer).AlphaFrom) then // If not in animation already
        if sp.BorderForm <> nil then begin
          sp.BorderForm.UpdateExBordersPos(False); // Repaint cache
          SetBlurBehindWindow(sp.BorderForm.AForm.Handle, False, 0);
          CopyBmp(TacMinTimer(sp.FormTimer).SavedImage, sp.SkinData.FCacheBmp); // Save cache
          sp.BorderForm.ExBorderShowing := True;
          SetWindowPos(sp.BorderForm.AForm.Handle, GetTopWindow, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOSIZE or SWP_NOREDRAW);
          SetWindowRgn(sp.BorderForm.AForm.Handle, 0, False);
        end
        else begin
          if TacMinTimer(sp.FormTimer).SavedImage <> nil then
            FreeAndNil(TacMinTimer(sp.FormTimer).SavedImage);

          TacMinTimer(sp.FormTimer).SavedImage := GetFormImage(sp);
        end;

      if (sp.LayerForm <> nil) and IsWindowVisible(sp.LayerForm.Handle) then
        sp.LayerForm.Hide;

      if GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED <> WS_EX_LAYERED then
        SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

      SetLayeredWindowAttributes(sp.Form.Handle, clNone, 0, ULW_ALPHA);
      if not AeroIsEnabled then
        Sleep(4 * acTimerInterval); // Antiblinking

  //    if (sp.BorderForm <> nil) or (acWinVer < 6) or AeroIsEnabled then begin
        TacMinTimer(sp.FormTimer).TimeHandler;
        if TacMinTimer(sp.FormTimer).StepCount > 1 then
          sp.FormTimer.Enabled := True;
  //    end;
    end;
  {$IFDEF D2007}
    if not Application.MainFormOnTaskBar then begin
      if sp.Form = Application.MainForm then
        h := Application.Handle
      else
        h := sp.Form.Handle;
    end
    else
  {$ENDIF}
      h := sp.Form.Handle;

    UpdatePreview(h, True);
    DwmInvalidateIconicBitmaps(h);
  end;
end;


function StartRestoring(sp: TsSkinProvider): boolean;
var
  h: THandle;
begin
  Result := True;
  if Assigned(sp.FormTimer) and (sp.FormTimer is TacMinTimer) and sp.SkinData.SkinManager.AnimEffects.Minimizing.Active then
    if (sp.FormState and FS_ANIMRESTORING <> FS_ANIMRESTORING) then begin
      sp.FormState := sp.FormState and not FS_ANIMMINIMIZING;
      sp.FormState := sp.FormState or FS_ANIMRESTORING;
      sp.fAnimating := True;
      sp.SkinData.SkinManager.ShowState := saRestore;
      if sp.BorderForm <> nil then begin
        sp.BorderForm.ExBorderShowing := True;
        if sp.BorderForm.AForm = nil then begin
          sp.BorderForm.CreateNewForm;
          SetFormBlendValue(sp.BorderForm.AForm.Handle, TacMinTimer(sp.FormTimer).AlphaBmp, 0);
        end;
        TacMinTimer(sp.FormTimer).AnimForm := sp.BorderForm.AForm;
        SetWindowPos(sp.BorderForm.AForm.Handle, GetTopWindow, 0, 0, 0, 0, SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOSIZE or SWP_NOMOVE or SWP_NOREDRAW);

        if GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED <> WS_EX_LAYERED then
          SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

        SetLayeredWindowAttributes(sp.Form.Handle, clNone, 0, ULW_ALPHA);
        sp.FormTimer.Enabled := True;
        // Form image update
        sp.FormActive := True;
        sp.SkinData.BGChanged := True;
        sp.PaintAll;
        sp.SkipAnimation := False;
      end
      else
        if (sp.BorderForm <> nil) or (acWinVer < 6) or AeroIsEnabled then begin
          if GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED <> WS_EX_LAYERED then
            SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

          SetLayeredWindowAttributes(sp.Form.Handle, clNone, 0, ULW_ALPHA);
          sp.FormTimer.Enabled := True;
        end
        else
          sp.FormTimer.TimeHandler;
{$IFDEF D2009}
      if not Application.MainFormOnTaskBar and (sp.Form = Application.MainForm) then
        h := Application.Handle
      else
{$ENDIF}
        h := sp.Form.Handle;

      UpdatePreview(h, False);
    end;
end;


procedure FinishBlendOnMoving(sp: TsSkinProvider; CoverForm: TForm = nil);
var
  i, cx, cy: integer;
  TmpForm: TForm;
  rgn: hrgn;
begin
  if sp.BorderForm <> nil then begin
{$IFDEF DELPHI7UP}
    if sp.Form.AlphaBlend then
      SetFormBlendValue(sp.BorderForm.AForm.Handle, sp.SkinData.FCacheBmp, sp.Form.AlphaBlendValue)
    else
{$ENDIF}
      SetFormBlendValue(sp.BorderForm.AForm.Handle, sp.SkinData.FCacheBmp, MaxByte);

    if sp.FSysExHeight then
      cy := sp.ShadowSize.Top + DiffTitle(sp.BorderForm) + SysBorderWidth(sp.Form.Handle, sp.BorderForm, False) //  4 { For MinMax patching }
    else
      cy := sp.BorderForm.OffsetY;

    cx := SkinBorderWidth(sp.BorderForm) - SysBorderWidth(sp.Form.Handle, sp.BorderForm, False) + sp.ShadowSize.Left;
    SetWindowPos(sp.Form.Handle, 0, sp.BorderForm.AForm.Left + cx, sp.BorderForm.AForm.Top + cy, 0, 0, SWP_NOACTIVATE {Activate later} or SWP_NOSENDCHANGING or SWP_NOREDRAW or SWP_NOZORDER or SWP_NOOWNERZORDER or SWP_NOSIZE);
    sp.FormState := sp.FormState and not FS_BLENDMOVING;
{$IFDEF DELPHI7UP}
    if sp.Form.AlphaBlend then begin
      sp.BorderForm.ExBorderShowing := False;
      sp.BorderForm.UpdateExBordersPos(True);
      SetLayeredWindowAttributes(sp.Form.Handle, clNone, sp.Form.AlphaBlendValue, ULW_ALPHA);
    end
    else
{$ENDIF}
    begin
      if sp.BorderForm <> nil then
        SetWindowPos(sp.Form.Handle, sp.BorderForm.AForm.Handle, 0, 0, 0, 0, SWP_NOSENDCHANGING or SWP_NOREDRAW or SWP_NOOWNERZORDER or SWP_NOSIZE or SWP_NOMOVE);
        
      SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
    end;
    sp.SkinData.BGChanged := True; // Update a form cache (remove images of controls)
    RedrawWindow(sp.Form.Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_ALLCHILDREN or RDW_UPDATENOW);
    if sp.Form <> Application.MainForm then
      Sleep(20); // Avoid a blinking
    // Activate
    SetWindowPos(sp.Form.Handle, 0, 0, 0, 0, 0, SWP_NOSENDCHANGING or SWP_NOREDRAW or SWP_NOZORDER or SWP_NOOWNERZORDER or SWP_NOSIZE or SWP_NOMOVE);
    if AeroIsEnabled and (sp.Form.Menu <> nil) then
      sp.ProcessMessage(WM_NCPAINT, 0, 0); // Menu repaint

    sp.BorderForm.ExBorderShowing := False;
    sp.BorderForm.UpdateExBordersPos(True); // Redraw and update region and z-order
    if (acMousePos.Y = acWorkRect(acMousePos).Top) and (sp.Form.BorderStyle in [bsSizeable]) and (biMaximize in sp.Form.BorderIcons) then
      sp.Form.WindowState := wsMaximized;
  end
  else begin
{$IFDEF DELPHI7UP}
    if sp.Form.AlphaBlend then
      SetLayeredWindowAttributes(sp.Form.Handle, clNone, sp.Form.AlphaBlendValue, ULW_ALPHA)
    else
{$ENDIF}
    begin
      if CoverForm = nil then
        TmpForm := MakeCoverForm(sp.Form.Handle)
      else
        TmpForm := CoverForm;

      if (sp.BorderForm = nil) and not IsZoomed(sp.Form.Handle) then begin
        rgn := GetRgnFromArOR(sp);
        SetWindowRgn(TmpForm.Handle, rgn, False);
      end;
      SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
      UpdateWindow(sp.Form.Handle);
      if Assigned(sp.FormTimer) then
        sp.FormTimer.Enabled := False;

      RedrawWindow(sp.Form.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN or RDW_UPDATENOW);
      FreeAndNil(TmpForm);
    end;
    sp.FormState := sp.FormState and not FS_BLENDMOVING;
  end;
  for i := 0 to Length(GluedArray) - 1 do
    if (GluedArray[i].Master.Handle = sp.Form.Handle) and IsWindowVisible(GluedArray[i].Slave.Handle) then
      SendAMessage(GluedArray[i].Slave.Handle, AC_SETALPHA, MaxByte);
      
  if Assigned(sp.FormTimer) then begin
    TacMoveTimer(sp.FormTimer).CurrentBlendValue := MaxByte;
    FreeAndNil(sp.FormTimer);
  end;
end;


procedure StartBlendOnMoving(sp: TsSkinProvider; ToMove: boolean = True);
var
  TmpForm: TForm;
  rgn: hrgn;
begin
  if (sp.FormState and FS_BLENDMOVING <> FS_BLENDMOVING) then begin
    TmpForm := nil;
    sp.UpdateSlaveFormsList;
    if sp.SkinData.SkinManager.AnimEffects.BlendOnMoving.Active then begin
      sp.FormState := sp.FormState or FS_BLENDMOVING;
      if Assigned(sp.FormTimer) then
        FreeAndNil(sp.FormTimer);

      sp.FormTimer := TacMoveTimer.CreateOwned(sp, True);
{$IFDEF DELPHI7UP}
      if sp.Form.AlphaBlend then
        TacMoveTimer(sp.FormTimer).CurrentBlendValue := sp.Form.AlphaBlendValue
      else
{$ENDIF}
        TacMoveTimer(sp.FormTimer).CurrentBlendValue := MaxByte;

      TacMoveTimer(sp.FormTimer).BorderForm := sp.BorderForm;
      TacMoveTimer(sp.FormTimer).FormHandle := sp.Form.Handle;
      if sp.AllowBlendOnMoving then
        TacMoveTimer(sp.FormTimer).BlendValue := sp.SkinData.SkinManager.AnimEffects.BlendOnMoving.BlendValue
      else
        TacMoveTimer(sp.FormTimer).BlendValue := MaxByte;

      if sp.SkinData.SkinManager.AnimEffects.BlendOnMoving.Time > acTimerInterval then
        TacMoveTimer(sp.FormTimer).BlendStep := (MaxByte - TacMoveTimer(sp.FormTimer).BlendValue) / (sp.SkinData.SkinManager.AnimEffects.BlendOnMoving.Time / acTimerInterval) // * 2
      else
        TacMoveTimer(sp.FormTimer).BlendStep := MaxByte - TacMoveTimer(sp.FormTimer).BlendValue{ * 2};

      TacMoveTimer(sp.FormTimer).Interval := acTimerInterval;
      if sp.BorderForm <> nil then begin
        sp.BorderForm.UpdateExBordersPos(False);
{$IFDEF DELPHI7UP}
        if sp.Form.AlphaBlend then // and (sp.Form.AlphaBlendValue < MaxByte)
          SetLayeredWindowAttributes(sp.Form.Handle, clNone, 0, ULW_ALPHA);
{$ENDIF}
        sp.BorderForm.ExBorderShowing := True;
        SetWindowPos(sp.Form.Handle, sp.BorderForm.AForm.Handle, 0, 0, 0, 0, SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOSIZE or SWP_NOMOVE or SWP_NOREDRAW);
        SetFormBlendValue(sp.Form.Handle, nil, 0);
        sp.FormTimer.Enabled := True;

        sp.BorderForm.AForm.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
        sp.BorderForm.MovRgnChanged := False;

        if (sp.BorderForm.LastTopLeft.X <> -1) and (sp.BorderForm.LastTopLeft.Y <> -1) then
          if (sp.BorderForm.LastTopLeft.Y < 0) and (Win32MajorVersion >= 6) then // Avoid of a form auto aligning
            sp.BorderForm.AForm.SetBounds(sp.BorderForm.LastTopLeft.X, sp.BorderForm.LastTopLeft.Y, sp.BorderForm.AForm.Width, sp.BorderForm.AForm.Height);
      end
      else begin
{$IFDEF DELPHI7UP}
        if not sp.Form.AlphaBlend then
{$ENDIF}
        begin
          TmpForm := MakeCoverForm(sp.Form.Handle);
          if (sp.BorderForm = nil) and not IsZoomed(sp.Form.Handle) then begin
            rgn := GetRgnFromArOR(sp);
            SetWindowRgn(TmpForm.Handle, rgn, False);
          end;
          if GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED <> WS_EX_LAYERED then
            SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

          SetLayeredWindowAttributes(sp.Form.Handle, clNone, MaxByte, ULW_ALPHA);
          RedrawWindow(sp.Form.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_UPDATENOW);
          ShowWindow(TmpForm.Handle, SW_HIDE);
        end;
        sp.FormTimer.Enabled := True;
        if ToMove then
          sp.Form.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
      end;
      if ToMove then
        FinishBlendOnMoving(sp, TmpForm);
    end;
  end;
end;
{$ENDIF}


function GetFormImage(sp: TsSkinProvider; CacheReplaced: boolean = False): TBitmap;
begin
  if sp.SkinData.FCacheBmp <> nil then begin
    Result := CreateBmp32(sp.SkinData.FCacheBmp);
    Result.Canvas.Lock;
    try
      SkinPaintTo(Result, sp.Form, 0, 0, sp);
      if sp.BorderForm = nil then
        FillAlphaRect(Result, MkRect(Result), MaxByte);
    finally
      Result.Canvas.UnLock;
    end;
    if CacheReplaced then
      FreeAndNil(sp.SkinData.FCacheBmp);
  end
  else
    Result := nil;
end;


procedure StartSBAnimation(const Btn: PsCaptionButton; const State: integer; const Iterations: integer; const ToUp: boolean; const SkinProvider: TsSkinProvider; acDialog: pointer = nil);
var
  i: integer;
begin
  if Btn^.Timer = nil then begin
    if SkinProvider <> nil then begin
      Btn^.Timer := TacSBAnimation.Create(SkinProvider);
      Btn^.Timer.BorderForm := SkinProvider.BorderForm;
      Btn^.Timer.FormHandle := SkinProvider.Form.Handle;
      Btn^.Timer.SkinData := SkinProvider.SkinData;
      i := max(1, integer(SkinProvider.SkinData.SkinManager.Effects.AllowAnimation) * Iterations);
    end
    else
      if acDialog <> nil then
        with TacDialogWnd(acDialog) do begin
          Btn^.Timer := TacSBAnimation.Create(Application);
          Btn^.Timer.BorderForm := BorderForm;
          Btn^.Timer.FormHandle := CtrlHandle;
          Btn^.Timer.SkinData := SkinData;
          i := max(1, integer(TacDialogWnd(acDialog).SkinData.SkinManager.Effects.AllowAnimation) * Iterations);
        end
      else
        Exit;

    if (Btn^.Timer <> nil) and not Application.Terminated then begin
      Btn^.Timer.Enabled := False;
      Btn^.Timer.PBtnData := Btn;
      Btn^.Timer.MaxIterations := i; // Iterations;
      Btn^.Timer.Interval := acTimerInterval;
      Btn^.Timer.StartAnimation(State, True);
    end;
  end
  else begin
    if ToUp then
      Btn^.Timer.CurrentState := State;

    Btn^.Timer.MaxIterations := Iterations;
    Btn^.Timer.Up := ToUp;
    Btn^.Timer.Enabled := True;
    if State = 2 then begin
      FreeAndNil(Btn^.Timer.ABmp);
      FreeAndNil(Btn^.Timer.AForm);
      Btn^.Timer.MakeForm;
      Btn^.Timer.MakeImg;
    end;
    Btn^.Timer.CurrentLevel := max(1, integer(Btn^.Timer.SkinData.SkinManager.Effects.AllowAnimation) * Iterations); // Iterations;
  end;
end;


function IsMenuVisible(sp: TsSkinProvider): boolean;
begin
  if (sp.Form.Menu <> nil) {$IFNDEF FPC}and not sp.Form.Menu.AutoMerge{$ENDIF} then
    Result := (sp.Form.Menu.Items.Count > 0) and (sp.Form.FormStyle <> fsMDIChild) and (sp.Form.BorderStyle <> bsDialog)
  else
    Result := False;
end;


function SysBorderWidth(const Handle: hwnd; const BorderForm: TacBorderForm; CheckSkin: boolean = True): integer;
var
  Style: ACNativeInt;
begin
  Result := 0;
  if CheckSkin then
    Result := SkinBorderWidth(BorderForm);

  if Result = 0 then begin
    Style := GetWindowLong(Handle, GWL_STYLE);
    if (Style and WS_THICKFRAME = WS_THICKFRAME) then
      if (BorderForm = nil) or (BorderForm.SkinData.SkinManager = nil) {or (BorderForm.SkinData.SkinManager.CommonSkinData.ExDrawMode = 1)} then
        if (acWinVer >= 8) and (BorderForm <> nil) then // If Windows 10
          Result := ac_CXSIZEFRAME + 4
        else
          Result := ac_CXSIZEFRAME
      else
        Result := SendAMessage(Handle, AC_GETBORDERWIDTH, ac_CXSIZEFRAME)
    else
      if (Style and WS_BORDER = WS_BORDER) then
        if (BorderForm = nil) or (BorderForm.SkinData.SkinManager = nil) or (BorderForm.SkinData.SkinManager.CommonSkinData.ExDrawMode = 1) then
          Result := ac_CXFIXEDFRAME
        else
          Result := SendAMessage(Handle, AC_GETBORDERWIDTH, ac_CXFIXEDFRAME);
  end
end;


function SysBorderHeight(const Handle: hwnd; const BorderForm: TacBorderForm; CheckSkin: boolean = True): integer;
begin
  if BorderForm = nil {Used in caption only when borders are std} then
    Result := SysBorderWidth(Handle, BorderForm, CheckSkin)
  else
    Result := 0;
end;


function SysCaptHeight(Form: TForm): integer;
begin
  if (Form = nil) then begin
    if FSysWndCaptHeight = 0 then
      FSysWndCaptHeight := ac_CYCAPTION;

    Result := FSysWndCaptHeight;
  end
  else
    if (Form.BorderStyle in [bsToolWindow, bsSizeToolWin]) and not IsIconic(Form.Handle) then begin
      if FSysToolCaptHeight = 0 then
        FSysToolCaptHeight := ac_CYSMCAPTION;

      Result := FSysToolCaptHeight;
    end
    else begin
      if FSysWndCaptHeight = 0 then
        FSysWndCaptHeight := ac_CYCAPTION;

      Result := FSysWndCaptHeight;
    end;
end;


function HaveDefShadow(const sp: TsSkinProvider): boolean;
begin
  Result := True;
end;


function SkinTitleHeight(const BorderForm: TacBorderForm): integer;
begin
  if BorderForm <> nil then
    if (BorderForm.sp <> nil) and IsZoomed(BorderForm.sp.Form.Handle) then
      Result := BorderForm.SkinData.SkinManager.CommonSkinData.ExMaxHeight
    else
      Result := BorderForm.SkinData.SkinManager.CommonSkinData.ExTitleHeight
  else
    Result := 0;
end;


function SkinBorderWidth(const BorderForm: TacBorderForm): integer;
begin
  if (BorderForm <> nil) and (BorderForm.SkinData.SkinManager <> nil) then
    Result := BorderForm.SkinData.SkinManager.CommonSkinData.ExBorderWidth
  else
    Result := 0;
end;


function SkinMenuOffset(const sp: TsSkinProvider): TPoint;
begin
  if sp.BorderForm <> nil then begin
    Result.Y := sp.CaptionHeight - SysCaptHeight(sp.Form) + SysBorderHeight(sp.Form.Handle, sp.BorderForm) - SysBorderHeight(sp.Form.Handle, sp.BorderForm, False);
    Result.X := SysBorderWidth(sp.Form.Handle, sp.BorderForm) - SysBorderWidth(sp.Form.Handle, sp.BorderForm, False);
  end
  else
    Result := MkPoint;
end;


function DiffTitle(const BorderForm: TacBorderForm): integer;
begin
  if BorderForm <> nil then
    Result := BorderForm.CaptionHeight - BorderForm.CaptionHeight(False) - SysBorderWidth(BorderForm.OwnerHandle, BorderForm, False)
  else
    Result := 0;
end;


function DiffBorder(const BorderForm: TacBorderForm): integer;
begin
  if BorderForm <> nil then
    Result := SysBorderWidth(BorderForm.OwnerHandle, BorderForm) - SysBorderWidth(BorderForm.OwnerHandle, BorderForm, False)
  else
    Result := 0;
end;


function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: DWORD; pvAttribute: Pointer; cbAttribute: DWORD): HResult;
begin
  if Assigned(_DwmSetWindowAttribute) then
    Result := _DwmSetWindowAttribute(hwnd, dwAttribute, pvAttribute, cbAttribute)
  else begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then begin
      _DwmSetWindowAttribute := GetProcAddress(hDWMAPI, 'DwmSetWindowAttribute');
      if Assigned(_DwmSetWindowAttribute) then
        Result := _DwmSetWindowAttribute(hwnd, dwAttribute, pvAttribute, cbAttribute);

      _DwmEnableBlurBehindWindow := GetProcAddress(hDWMAPI, 'DwmEnableBlurBehindWindow');
    end;
  end;
end;


function AeroIsEnabled: boolean;
var
  b: Longbool;
begin
  Result := False;
  if (Win32MajorVersion >= 6) then begin
    b := False;
    if Assigned(_DwmIsCompositionEnabled) then
      Result := _DwmIsCompositionEnabled(b) = S_OK
    else begin
      InitDwmApi;
      if hDWMAPI > 0 then begin
        _DwmIsCompositionEnabled := GetProcAddress(hDWMAPI, 'DwmIsCompositionEnabled');
        if Assigned(_DwmIsCompositionEnabled) then
          Result := _DwmIsCompositionEnabled(b) = S_OK;
      end
    end;
  end;
  Result := Result and b;
end;


function ForbidSysAnimating: boolean;
begin
  Result := not AeroIsEnabled;
end;


procedure InitDwm(const Handle: THandle; const Skinned: boolean; const Repaint: boolean = False);
var
  Policy: Longint;
begin
  if AeroIsEnabled then
    Policy := integer(Skinned); // DWMNCRP_DISABLED (if True) or DWMNCRP_USEWINDOWSTYLE
    
  DwmSetWindowAttribute(Handle, 3{DWMWA_TRANSITIONS_FORCEDISABLED}, @Policy, Sizeof(Policy));
end;


function IsBorderUnchanged(const BorderIndex: integer; const sm: TsSkinManager): boolean;
begin
  Result := (BorderIndex < 0) or (sm.ma[BorderIndex].ImageCount = 1)
end;


function IsGripVisible(const sp: TsSkinProvider): boolean;
begin
  Result := (sp.GripMode = gmRightBottom) and not IsZoomed(sp.Form.Handle) and (GetWindowLong(sp.Form.Handle, GWL_STYLE) and WS_SIZEBOX = WS_SIZEBOX)
end;


function InAnimation(const sp: TsSkinProvider): boolean;
begin
  Result := sp.FInAnimation; // Will be changed later for optimizing
end;


procedure PaintGrip(const aDC: hdc; const sp: TsSkinProvider);
var
  i, w1, w2, dx, h1, h2, dy: integer;
  BG: TacBGInfo;
  Bmp: TBitmap;
  p: TPoint;
begin
  i := sp.FCommonData.SkinManager.ConstData.GripRightBottom;
  if sp.FCommonData.SkinManager.IsValidImgIndex(i) then begin
    Bmp := CreateBmp32(MkSize(sp.FCommonData.SkinManager.ma[i]));
    p := sp.RBGripPoint(i);
    BG.R := MkRect(Bmp);
    BG.PleaseDraw := False;
    sp.FCommonData.FCacheBmp.Canvas.Lock;
    GetBGInfo(@BG, sp.Form);
    if BG.BgType <> btCache then begin
      FillDC(Bmp.Canvas.Handle, BG.R, BG.Color);
      w1 := sp.SkinData.SkinManager.MaskWidthRight(sp.SkinData.BorderIndex);
      h1 := sp.SkinData.SkinManager.MaskWidthBottom(sp.SkinData.BorderIndex);
      w2 := SysBorderWidth(sp.Form.Handle, sp.BorderForm);
      h2 := w2;
      dx := w1 - w2;
      dy := h1 - h2;
      if (dx > 0) and (dy > 0) then begin
        // Right border
        BitBlt(Bmp.Canvas.Handle, Bmp.Width - dx, 0, dx, Bmp.Height,
               sp.SkinData.FCacheBmp.Canvas.Handle, sp.SkinData.FCacheBmp.Width - w1 - sp.ShadowSize.Right, sp.SkinData.FCacheBmp.Height - h2 - Bmp.Height - sp.ShadowSize.Bottom, SRCCOPY);
        // Bottom border
        BitBlt(Bmp.Canvas.Handle, 0, Bmp.Height - dy, Bmp.Width, dy,
               sp.SkinData.FCacheBmp.Canvas.Handle, sp.SkinData.FCacheBmp.Width - w2 - Bmp.Width - sp.ShadowSize.Right, sp.SkinData.FCacheBmp.Height - h1 - sp.ShadowSize.Bottom, SRCCOPY);
      end;
    end
    else
      BitBlt(Bmp.Canvas.Handle, 0, 0, BG.R.Right, BG.R.Bottom, sp.SkinData.FCacheBmp.Canvas.Handle, p.X, p.Y, SRCCOPY);

    sp.FCommonData.FCacheBmp.Canvas.UnLock;
    DrawSkinGlyph(Bmp, MkPoint, 0, 1, sp.FCommonData.SkinManager.ma[i], MakeCacheInfo(Bmp));
    BitBlt(aDC, p.X, p.Y, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(Bmp);
  end;
end;


function CtrlIsReadyForHook(const Ctrl: TWinControl): boolean;
begin
  Result := Ctrl.HandleAllocated{$IFDEF TNTUNICODE} and Ctrl.Visible and (Ctrl.Parent <> nil){$ENDIF} // Showing is False when Parent changed
end;


procedure MakeCaptForm(sp: TsSkinProvider; Full: boolean = False);
var
  DC: hdc;
  cR: TRect;
  p: TPoint;
  Flags: Longint;
  Rgn, SubRgn: hrgn;
  t, h, l, w: integer;
begin
  if sp.FDrawNonClientArea and not InAnimation(sp) {or (sp.LockCount > 0) } and (sp.Form.WindowState <> wsMinimized) and sp.Form.Showing then begin
    if ((sp.BorderForm <> nil) and (sp.Form.Menu = nil) {and (AddHeight = 0)}) then
      Exit;

    if (sp.Form.FormStyle = fsMDIChild) and (MDISkinProvider <> nil) and
         (TsSkinProvider(MDISkinProvider).LockCount > 0) or (sp.FormState and FS_BLENDMOVING = FS_BLENDMOVING) then
      Exit;

    if sp.CaptForm = nil then begin
      sp.CaptForm := TForm.Create(Application);
      if sp.CaptForm = nil then
        Exit;

      sp.CaptForm.Visible := False;
      sp.CaptForm.BorderStyle := bsNone;
      sp.CaptForm.Tag := ExceptTag;
      sp.CaptForm.HandleNeeded;
      if not sp.CaptForm.HandleAllocated then begin
        FreeAndNil(sp.CaptForm);
        Exit;
      end;
      SetClassLong(sp.CaptForm.Handle, GCL_STYLE, GetClassLong(sp.CaptForm.Handle, GCL_STYLE) and not NCS_DROPSHADOW);
      sp.CaptForm.OnPaint := sp.CaptFormPaint;
      sp.OldCaptFormProc := sp.CaptForm.WindowProc;
      sp.CaptForm.WindowProc := sp.NewCaptFormProc;
    end;
    if sp.BorderForm <> nil then begin
      h := sp.MenuHeight * sp.LinesCount + 1;
      t := sp.Form.Top + sp.OffsetY - h - sp.ShadowSize.Top - DiffTitle(sp.BorderForm);
      l := sp.Form.Left + SysBorderWidth(sp.Form.Handle, sp.BorderForm, False);
      w := sp.Form.Width - 2 * SysBorderWidth(sp.Form.Handle, sp.BorderForm, False);
      if h <> 0 then
        inc(h);
    end
    else begin

      h := sp.Form.Height;
      t := sp.Form.Top;
      l := sp.Form.Left;
      w := sp.Form.Width;

      Rgn := CreateRectRgn(0, 0, w, h);
      cR := acClientRect(sp.Form.Handle);
      SubRgn := CreateRectRgn(cR.Left, cR.Top, cR.Right, cR.Bottom);
      CombineRgn(Rgn, Rgn, SubRgn, RGN_DIFF);
      DeleteObject(SubRgn);

      if (sp.Form.Parent <> nil) or (sp.Form.FormStyle = fsMDIChild) then begin
        DC := GetDC(sp.Form.Handle);
        if GetClipBox(DC, cR) = NULLREGION then begin
          FreeAndNil(sp.CaptForm);
          ReleaseDC(sp.Form.Handle, DC);
          Exit;
        end;
        if (cR.Left < cR.Right) and (cR.Top < cR.Bottom) then begin
          SubRgn := CreateRectRgn(cR.Left, cR.Top, cR.Right, cR.Bottom);
          CombineRgn(Rgn, Rgn, SubRgn, RGN_AND);
//          CombineRgn(Rgn, Rgn, SubRgn, RGN_XOR);
          DeleteObject(SubRgn);
        end;
        ReleaseDC(sp.Form.Handle, DC);
{
        GetWindowRecT(sp.Form.Handle, R1);
        GetWindowRecT(sp.Form.Parent.Handle, R2);
        cR := RectsAnd(R1, R2);
        if (cR.Left < cR.Right) and (cR.Top < cR.Bottom) then begin
          OffsetRect(cR, -R1.Left, -R1.Top);
          SubRgn := CreateRectRgn(cR.Left, cR.Top, cR.Right, cR.Bottom);
          CombineRgn(Rgn, Rgn, SubRgn, RGN_DIFF);
          DeleteObject(SubRgn);
        end;
}
      end;

      SetWindowRgn(sp.CaptForm.Handle, Rgn, False);
    end;
    sp.CaptForm.SetBounds(l, t, w, h);

    Flags := SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOREDRAW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER;
    if (sp.Form.FormStyle = fsMDIChild) then begin
      if MDISkinProvider <> nil then
        p := TsSkinProvider(MDISkinProvider).Form.ClientToScreen(Point(sp.Form.Left + GetAlignShift(TsSkinProvider(MDISkinProvider).Form, alLeft, True){ + 2}, sp.Form.Top + GetAlignShift(TsSkinProvider(MDISkinProvider).Form, alTop, True){ + 2}));

      SetWindowPos(sp.CaptForm.Handle, 0, p.x, p.y, sp.Form.Width, sp.HeaderHeight, Flags);
    end
    else
      if GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and WS_EX_TOPMOST = WS_EX_TOPMOST then
        SetWindowPos(sp.CaptForm.Handle, HWND_TOPMOST, l, t, w, h, Flags)
      else
        SetWindowPos(sp.CaptForm.Handle, 0{GetNextWindow(sp.Form.Handle, GW_HWNDPREV)}, l, t, w, h, Flags);

    ShowWindow(sp.CaptForm.Handle, SW_SHOWNOACTIVATE);
    RedrawWindow(sp.CaptForm.Handle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE or RDW_FRAME);
  end;
end;


procedure KillCaptForm(sp: TsSkinProvider);
var
  f: TForm;
begin
  if sp.CaptForm <> nil then begin
    f := sp.CaptForm;
    sp.CaptForm := nil;
    f.WindowProc := sp.OldCaptFormProc;
//    SetWindowLong(f.Handle, GWL_STYLE, GetWindowLong(f.Handle, GWL_STYLE) and not WS_VISIBLE);
    f.Free;
  end;
end;


procedure FillArOR(sp: TsSkinProvider);
var
  i: integer;
begin
  SetLength(sp.ArOR, 0);
  with sp.SkinData do begin
    if SkinManager.IsValidImgIndex(BorderIndex) then begin
      AddRgn(sp.ArOR, sp.CaptionWidth, SkinManager.ma[BorderIndex], 0, False);                                              // TopBorderRgn
      AddRgn(sp.ArOR, sp.CaptionWidth, SkinManager.ma[BorderIndex], sp.Form.Height - SkinManager.ma[BorderIndex].WB, True); // BottomBorderRgn
    end;
    // TitleRgn
    i := sp.FTitleSkinIndex;
    if SkinManager.IsValidSkinIndex(i) then begin
      i := SkinManager.GetMaskIndex(i, s_BordersMask);
      if SkinManager.IsValidImgIndex(i) then
        AddRgn(sp.ArOR, sp.CaptionWidth, SkinManager.ma[i], 0, False);
    end;
  end;
end;


function IsSizeBox(Handle: hWnd): boolean;
begin
  Result := GetWindowLong(Handle, GWL_STYLE) and WS_SIZEBOX = WS_SIZEBOX;
end;


function HaveBorder(sp: TsSkinProvider): boolean;
begin
  Result := (sp.Form.BorderStyle <> bsNone) or (GetWindowLong(sp.Form.Handle, GWL_STYLE) and WS_CHILD = WS_CHILD)// or (TForm(sp.Form).FormStyle = fsMDIChild) {remove fsMDIChild in Beta}
end;


procedure UpdateRgn(sp: TsSkinProvider; Repaint: boolean = True; AllChildren: boolean = False);
const
  BE_ID = $41A2;
  CM_BEWAIT = CM_BASE + $0C4D;
var
  R: TRect;
  rgn: HRGN;
  sbw, i: integer;
begin
  if sp.DrawNonClientArea and sp.Form.HandleAllocated and not sp.InMenu and (HaveBorder(sp) or IsIconic(sp.Form.Handle) or IsSizeBox(sp.Form.Handle)) {and sp.RgnChanged} then
    with sp do begin
      if not FirstInitialized and (SendMessage(Form.Handle, CM_BEWAIT, BE_ID, 0) = BE_ID) then
        Exit; // BE compatibility

      if ((sp.Form.Parent = nil) or (TForm(sp.Form).DragKind <> dkDock)) {regions changing disabled when docking used} then begin
        RgnChanging := True;

        if (BorderForm <> nil) then begin
          sbw := SysBorderWidth(sp.Form.Handle, sp.BorderForm, False);
          if sp.FSysExHeight then
            i := SysCaptHeight(sp.Form) + SysBorderWidth(sp.Form.Handle, sp.BorderForm, False)
          else
            i := SysBorderHeight(sp.Form.Handle, sp.BorderForm, False) + SysCaptHeight(sp.Form) + SysBorderWidth(sp.Form.Handle, sp.BorderForm, False);

{$IFNDEF NOFONTSCALEPATCH}
          if sp.SkinData.SkinManager.SysFontScale > 0 then
            rgn := CreateRectRgn(sbw{ - 1}, i - 1, sp.Form.Width - sbw{ + 1}, sp.Form.Height - sbw {+ 1})
          else
{$ENDIF}
            rgn := CreateRectRgn(sbw, i, sp.Form.Width - sbw, sp.Form.Height - sbw);
        end
        else
          if IsZoomed(sp.Form.Handle) and (sp.Form.Constraints.MaxWidth = 0) and (sp.Form.Constraints.MaxHeight = 0) and (Form.FormStyle <> fsMDIChild) then begin
            R := MkRect(sp.Form.Width, sp.Form.Height);
            InflateRect(R, - SysBorderWidth(sp.Form.Handle, sp.BorderForm, False), - SysBorderHeight(sp.Form.Handle, sp.BorderForm, False));
            rgn := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
          end
          else
            rgn := GetRgnFromArOR(sp);

        sp.RgnChanged := False;
        if AllChildren then
          SetWindowRgn(Form.Handle, rgn, Repaint{ True - repainting is required })
        else begin
          SetWindowRgn(Form.Handle, rgn, False);
          if Repaint then begin
            RedrawWindow(sp.Form.Handle, nil, 0, RDW_INVALIDATE or RDW_NOCHILDREN {or RDW_FRAME or RDW_NOERASE});//
            sp.ProcessMessage(WM_NCPAINT, 0, 0);
          end;
        end;

        RgnChanging := False;
      end
      else
        SetWindowRgn(Form.Handle, 0, False);
    end;
end;


function GetRgnFromArOR(sp: TsSkinProvider; X: integer = 0; Y: integer = 0): hrgn;
var
  l, i: integer;
  subrgn: HRGN;
begin
  l := Length(sp.ArOR);
  i := sp.CaptionWidth + X;
  Result := CreateRectRgn(X, Y, i, sp.Form.Height + Y);
  if l > 0 then
    for i := 0 to l - 1 do begin
      subrgn := CreateRectRgn(sp.ArOR[i].Left + X, sp.ArOR[i].Top + Y, sp.ArOR[i].Right + X, sp.ArOR[i].Bottom + Y);
      CombineRgn(Result, Result, subrgn, RGN_DIFF);
      DeleteObject(subrgn);
    end;
end;


procedure RefreshFormScrolls(SkinProvider: TsSkinProvider; var ListSW: TacScrollWnd; Repaint: boolean);
var
  sp: TacSkinParams;
begin
  if not (csDestroying in SkinProvider.ComponentState) and SkinProvider.Form.HandleAllocated and
       {TForm(SkinProvider.Form).AutoScroll and }(SkinProvider.FormState and FS_SCROLLUPDATING <> FS_SCROLLUPDATING) then begin

    SkinProvider.FormState := SkinProvider.FormState or FS_SCROLLUPDATING;
    if SkinProvider.SkinData.Skinned then begin
      if Assigned(Ac_UninitializeFlatSB) then
        Ac_UninitializeFlatSB(SkinProvider.Form.Handle);

      if (ListSW <> nil) and ListSW.Destroyed then
        FreeAndNil(ListSW);

      if ListSW = nil then begin
        sp.SkinSection := '';
        sp.HorzScrollBtnSize := -1;
        sp.VertScrollBtnSize := -1;
        sp.HorzScrollSize := -1;
        sp.VertScrollSize := -1;
        sp.Control := SkinProvider.Form;
        ListSW := TacScrollWnd.Create(SkinProvider.Form.Handle, SkinProvider.SkinData, SkinProvider.SkinData.SkinManager, sp, False);
      end;
    end
    else begin
      if ListSW <> nil then
        FreeAndNil(ListSW);

      if Assigned(Ac_InitializeFlatSB) then
        Ac_InitializeFlatSB(SkinProvider.Form.Handle);
    end;
    SkinProvider.FormState := SkinProvider.FormState and not FS_SCROLLUPDATING;
  end;
end;


procedure UpdateSkinCaption(SkinProvider: TsSkinProvider);
var
  DC, SavedDC: hdc;
begin
  if InAnimation(SkinProvider) or not SkinProvider.Form.visible or not SkinProvider.DrawNonClientArea or
       (csDestroyingHandle in SkinProvider.Form.ControlState) or not SkinProvider.SkinData.Skinned then
    Exit;
    
  with SkinProvider do
    if (TForm(Form).FormStyle = fsMDIChild) and (Form.WindowState = wsMaximized) then begin
      TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
      DC := GetWindowDC(TsSkinProvider(MDISkinProvider).Form.Handle);
      SavedDC := SaveDC(DC);
      try
        TsSkinProvider(MDISkinProvider).PaintCaption(DC);
      finally
        RestoreDC(DC, SavedDC);
        ReleaseDC(TsSkinProvider(MDISkinProvider).Form.Handle, DC);
      end;
    end
    else
      if SkinProvider.BorderForm = nil then begin
        FCommonData.BGChanged := True;
        DC := GetWindowDC(Form.Handle);
        SavedDC := SaveDC(DC);
        try
          if SkinData.FCacheBmp = nil then // Preventing of painting before ExBorders, usually when MainMenu exists
            InitExBorders(SkinData.SkinManager.ExtendedBorders);

          PaintCaption(DC);
        finally
          RestoreDC(DC, SavedDC);
          ReleaseDC(Form.Handle, DC);
        end;
      end
      else begin
        if SkinProvider.FGlow1 <> nil then
          FreeAndNil(SkinProvider.FGlow1);

        if SkinProvider.FGlow2 <> nil then
          FreeAndNil(SkinProvider.FGlow2);

        FCommonData.BGChanged := True;
        if SkinProvider.Form.Menu <> nil then
          SkinProvider.ProcessMessage(WM_NCPAINT);
          
        SkinProvider.BorderForm.UpdateExBordersPos;
      end
end;


function GetNearestSize(Max: integer): integer;
begin
  case Max of
    -100..8: Result := 1;
    9..16:   Result := 8;
    else     Result := 16
  end;
end;


function GetSkinProvider(Cmp: TComponent): TsSkinProvider;
var
  c: TComponent;
  sp: integer;
begin
  Result := nil;
  c := Cmp;
  while Assigned(c) and not (c is TCustomForm) do
    c := c.Owner;

  if (c is TCustomForm) then begin
    sp := SendMessage(TCustomForm(c).Handle, SM_ALPHACMD, MakeWParam(0, AC_GETPROVIDER), 0);
    if sp <> 0 then
      Result := TsSkinProvider(sp);
  end;
end;


function TitleIconWidth(SP: TsSkinProvider): integer;
begin
  if SP.IconVisible then
    if SP.TitleIcon.Width <> 0 then
      Result := SP.TitleIcon.Width
    else begin
      Result := GetNearestSize(SP.CaptionHeight);
      if SP.TitleIcon.Glyph.Width <> 0 then
        Result := Round(SP.TitleIcon.Glyph.Width * Result / SP.CaptionHeight)
    end
  else
    Result := 0;
end;


function TitleIconHeight(SP: TsSkinProvider): integer;
begin
  if SP.IconVisible then
    if SP.TitleIcon.Height <> 0 then
      Result := SP.TitleIcon.Height
    else
      Result := GetNearestSize(SP.CaptionHeight)
  else
    Result := 0;
end;


procedure DrawAppIcon(SkinProvider: TsSkinProvider);
var
  R: TRect;
  Ico: hicon;
  Bmp: TBitmap;
  S0, D0, S, D: PRGBAArray;
  iW, iH, x, y, DeltaS, DeltaD: integer;
begin
  with SkinProvider do
    if IconVisible then begin
      R := FIconRect;
      if not TitleIcon.Glyph.Empty then begin
        if TitleIcon.Glyph.PixelFormat <> pf32bit then begin
          TitleIcon.Glyph.PixelFormat := pf32bit;
          if InitLine(TitleIcon.Glyph, Pointer(S0), DeltaS) then
            for y := 0 to TitleIcon.Glyph.Height - 1 do begin
              S := Pointer(LongInt(S0) + DeltaS * Y);
              for x := 0 to TitleIcon.Glyph.Width - 1 do
                with S[x] do
                  if sFuchsia.C <> S[x].C then
                    A := MaxByte
            end;
        end;
        TitleIcon.Glyph.Transparent := True;
        TitleIcon.Glyph.TransparentColor := clFuchsia;
        iW := iff(TitleIcon.Width = 0, Round(TitleIcon.Glyph.Width * GetNearestSize(HeaderHeight - 2) / HeaderHeight - 2), TitleIcon.Width);
        iH := iff(TitleIcon.Height = 0, GetNearestSize(HeaderHeight - 2), TitleIcon.Height);
        if TitleIcon.Glyph.PixelFormat = pf32bit then
          if (TitleIcon.Glyph.Width = iW) or (TitleIcon.Glyph.Height = iH) then
            CopyByMask(Rect(R.Left, R.Top, R.Left + TitleIcon.Glyph.Width, R.Left + TitleIcon.Glyph.Height),
                     MkRect(TitleIcon.Glyph), FCommonData.FCacheBmp, TitleIcon.Glyph, EmptyCI, False)
          else
            DrawBmp(FCommonData.FCacheBmp.Canvas, TitleIcon.Glyph, Rect(R.Left, R.Top, R.Left + iW, R.Top + iH), False)
        else
          FCommonData.FCacheBmp.Canvas.StretchDraw(Rect(R.Left, R.Top, R.Left + iW, R.Top + iH), TitleIcon.Glyph);
      end
      else begin
        Bmp := CreateBmp32(R);
        BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
        if TForm(Form).Icon.Handle <> 0 then
          DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, TForm(Form).Icon.Handle, TitleIconWidth(SkinProvider), TitleIconHeight(SkinProvider), 0, 0, DI_NORMAL)
        else
          if Application.Icon.Handle <> 0 then begin
            Ico := hicon(SendMessage(Application.{$IFNDEF FPC}Handle{$ELSE}MainFormHandle{$ENDIF}, WM_GETICON, 2 {ICON_SMALL2}, 0));
            if Ico <> 0 then
              DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, Ico, TitleIconWidth(SkinProvider), TitleIconHeight(SkinProvider), 0, 0, DI_NORMAL);
          end
          else begin
            iW := iff(TitleIcon.Width = 0,  max(16, CaptionHeight - R.Top), TitleIcon.Width);
            iH := iff(TitleIcon.Height = 0, max(16, CaptionHeight - R.Top), TitleIcon.Height);
            if (iH > 16) and (AppIconLarge <> nil) then
              DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, AppIconLarge.Handle, iW, iH, 0, 0, DI_NORMAL)
            else
              if (AppIcon <> nil) then
                DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, AppIcon.Handle, iW, iH, 0, 0, DI_NORMAL)
              else
                DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, LoadIcon(0, IDI_APPLICATION), TitleIconWidth(SkinProvider), TitleIconHeight(SkinProvider), 0, 0, DI_NORMAL);
          end;

        if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(FCommonData.FCacheBmp, Pointer(D0), DeltaD) then
          for y := 0 to Bmp.Height - 1 do begin
            S := Pointer(LongInt(S0) + DeltaS * Y);
            D := Pointer(LongInt(D0) + DeltaD * (y + R.Top));
            for x := 0 to Bmp.Width - 1 do begin
              with D[x + R.Left] do
                if (I <> S[x].I){ or (D[x + R.Left].G <> S[x].G) or (D[x + R.Left].B <> S[x].B)} then
                  A := MaxByte
                else
                  I := S[x].I;
            end;
          end;
          
        FreeAndNil(Bmp);
      end;
    end;
end;


function GetWindowWidth(Handle: hwnd): integer;
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  Result := WidthOf(R)
end;


function GetClientWidth(Handle: hwnd): integer;
var
  R: TRect;
begin
  GetClientRect(Handle, R);
  Result := WidthOf(R)
end;


function GetWindowHeight(Handle: hwnd): integer;
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  Result := HeightOf(R)
end;


function GetClientHeight(Handle: hwnd): integer;
var
  R: TRect;
begin
  GetClientRect(Handle, R);
  Result := HeightOf(R)
end;


procedure LoadThirdNames(sm: TsSkinProvider; Overwrite: boolean = False);
var
  i: integer;
  s: string;
begin
  sm.OwnThirdLists := False;
  for i := 0 to High(acThirdNames) do begin
    s := sm.ThirdParty.GetString(i);
    if s <> '' then
      sm.OwnThirdLists := True;

    sm.ThirdLists[i].Text := s;
  end;
end;


procedure UpdateProviderThirdNames(sm: TsSkinProvider);
var
  i: integer;
begin
  for i := 0 to High(acThirdNames) do
    sm.ThirdParty.SetString(i, sm.ThirdLists[i].Text);
end;


procedure TsSkinProvider.AfterConstruction;
begin
  inherited;
  if Form <> nil then begin
    LoadThirdNames(Self);
    if not RTEmpty and not RTInit and Assigned(FCommonData.SkinManager) and FCommonData.SkinManager.Active and not (csDesigning in ComponentState) then
      PrepareForm;
  end;
end;


function TsSkinProvider.BarWidth(const i: integer): integer;
begin
  Result := (WidthOfImage(FCommonData.SkinManager.ma[i])) * 2 + TitleBtnsWidth;
end;


function TsSkinProvider.BorderHeight(CheckSkin: boolean = True): integer;
begin
  Result := SysBorderHeight(Form.Handle, BorderForm, CheckSkin) + Form.BorderWidth
end;


function TsSkinProvider.BorderWidth(CheckSkin: boolean = True): integer;
begin
  Result := SysBorderWidth(Form.Handle, BorderForm, CheckSkin) + Form.BorderWidth;
end;


function TsSkinProvider.ButtonHeight: integer;
begin
  if FCommonData.SkinManager.IsValidImgIndex(ButtonClose.ImageIndex) then
    Result := HeightOfImage(FCommonData.SkinManager.ma[ButtonClose.ImageIndex])
  else
    Result := 21;
end;


function TsSkinProvider.SysButtonsCount: integer;
begin
  Result := 0;
  if Assigned(SystemMenu) and HaveSysMenu then begin
    inc(Result);
    if SystemMenu.VisibleMax then
      inc(Result);

    if SystemMenu.VisibleMin then
      inc(Result);

    if (biHelp in Form.BorderIcons) then
      inc(Result);
  end;
end;


function TsSkinProvider.SysButtonWidth(const Btn: TsCaptionButton): integer;
begin
  with FCommonData.SkinManager do
    if IsValidImgIndex(Btn.ImageIndex) then
      if ma[Btn.ImageIndex].Bmp = nil then
        Result := WidthOfImage(ma[Btn.ImageIndex])
      else
        Result := ma[Btn.ImageIndex].Bmp.Width div ma[Btn.ImageIndex].ImageCount
    else
      Result := 21;
end;


function TsSkinProvider.CaptionHeight(CheckSkin: boolean = True): integer;

  function SysHeight: integer;
  begin
    Result := iff((Form.BorderStyle in [bsToolWindow, bsSizeToolWin]) and not IsIconic(Form.Handle), ac_CYSMCAPTION, ac_CYCAPTION);
  end;

begin
  if HaveBorder(Self) and (GetWindowLong(Form.Handle, GWL_STYLE) and WS_CAPTION = WS_CAPTION) or IsIconic(Form.Handle) then begin
    if CheckSkin then
      Result := SkinTitleHeight(Self.BorderForm)
    else
      Result := 0;

    if FSysExHeight then // Used for GetMinMax message (Y can't be smaller then Zero there)
      Result := max(Result, SysHeight + 4)
    else
      if Result = 0 then
        Result := SysHeight;
  end
  else
    Result := 0;
end;


{$IFNDEF DISABLEPREVIEWMODE}     
procedure TrySayHelloToEditor(const Handle: THandle);
var
  h: hwnd;
  Count: integer;
begin
  if acPreviewNeeded and (acPreviewHandle = 0) and ((Application.MainForm <> nil) and Application.MainForm.HandleAllocated and
       (Application.MainForm.Handle = Handle) or (Application.MainForm = nil)) then begin
    acPreviewHandle := Handle;
    acPreviewNeeded := False;
    for Count := 0 to 100 do begin
      h := FindWindow(nil, PChar(s_EditorCapt));
      if (h <> 0) then begin
        if (SendMessage(h, ASE_MSG, ASE_HELLO, LPARAM(Handle)) = 1) then
          Break;
      end
      else
        Break;
    end;
  end;
end;
{$ENDIF}


procedure SetCaseSens(sl: TStringList; Value: boolean = True); overload;
begin
  {$IFDEF DELPHI6UP} sl.CaseSensitive := Value; {$ENDIF}
end;


constructor TsSkinProvider.Create(AOwner: TComponent);
var
  i: integer;
  sp: TsSkinProvider;
begin
  if not (AOwner is TCustomForm) then
    Raise EAbort.Create('TsSkinProvider component may be used with forms only!');
{$IFNDEF DISABLEPREVIEWMODE}
  acPreviewNeeded := not (csDesigning in ComponentState) and (ParamCount > 0) and (ParamStr(1) = s_PreviewKey); // If called from the SkinEditor for a skin preview (Skin Edit mode)
{$ENDIF}
  Form := TForm(AOwner);
  RTEmpty := False;
  // Search other SkinProvider
  if (csDesigning in AOwner.ComponentState) then begin
    for i := 0 to Form.ComponentCount - 1 do
      if (Form.Components[i] is TsSkinProvider){ and (Form.Components[i] <> Self) }then begin
        Form := nil;
        ShowWarning('Only one instance of the TsSkinProvider component is allowed!');
        Exit;
      end;
  end
  else begin
    sp := TsSkinProvider(Form.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETPROVIDER), 0));
    if (sp <> nil) then
      if sp.RTInit then
        FreeAndNil(sp)
      else
        RTEmpty := True;
  end;
  
  if (csDesigning in AOwner.ComponentState) then
    for i := 0 to Form.ComponentCount - 1 do
      if (Form.Components[i] is TsTitleBar) then
        FTitleBar := TsTitleBar(Form.Components[i]);

  inherited Create(AOwner);
  FGlow1 := nil;
  FGlow2 := nil;
  RTInit := False;
  FThirdParty := ThirdPartyList.Create;
  SetLength(ThirdLists, High(acThirdNames) + 1);
  for i := 0 to High(acThirdNames) do begin
    ThirdLists[i] := TStringList.Create;
    SetCaseSens(ThirdLists[i]);
  end;
  FDrawNonClientArea := True;
  FDrawClientArea := True;
  FTitleSkinIndex := -1;
  FHeaderIndex := -1;
  FCaptionSkinIndex := -1;
  FInAnimation := False;
  FAllowAnimation := True;
  FAllowExtBorders := True;
  FAllowBlendOnMoving := True;
  CoverForm := nil;
  OldWndProc := nil;
  FormTimer := nil;

  fAnimating := False;
  InMenu := False;
  ShowAction := saIgnore;
  bCapture := False;
  bInProcess := False;

  FCommonData := TsScrollWndData.Create(Self, False);
  FCommonData.SkinSection := s_Form;
  FCommonData.COC := COC_TsSkinProvider;
  if (Form.ControlState <> []) and (Form.BorderStyle <> bsNone) then
    FCommonData.Updating := True;

  FAddedTitle := TacAddedTitle.Create;
  FAddedTitle.FOwner := Self;
  FFormHeader := TacFormHeader.Create(Self);

  FResizeMode := rmStandard;
  FUseGlobalColor := True;
  MDIForm := nil;
  InAero := AeroIsEnabled;

  MenuChanged := True;
  FMakeSkinMenu := DefMakeSkinMenu;
  MenusInitialized := False;
  RgnChanged := True;
  RgnChanging := False;
  FScreenSnap := False;
  FSnapBuffer := 10;
  FAllowSkin3rdParty := True;
  FDisabledBlendValue := MaxByte;

  FShowAppIcon := True;
  FCaptionAlignment := Classes.taLeftJustify;
  FTitleIcon := TsTitleIcon.Create(Self);
  FTitleButtons := TsTitleButtons.Create(Self);
  FSysSubMenu := TacSysSubMenu.Create(Self);
  FGluedForms := TStringList.Create;

  FGripMode := gmNone;
  ClearButtons := False;
  OldCaptFormProc := nil;

  if not (csDesigning in ComponentState) and not RTEmpty then begin
    Form.DoubleBuffered := False;
    TempBmp := TBitmap.Create;
    TempBmp.Canvas.Lock;
    MenuLineBmp := CreateBmp32;
    ClearButtons := True;
    SetLength(ArOR, 0);
    FLinesCount := -1;
    OldWndProc := Form.WindowProc;
    Form.WindowProc := NewWndProc;
    IntSkinForm(Form);
    FormActive := True;
  end;
end;


destructor TsSkinProvider.Destroy;
var
  i: integer;
begin
  if Assigned(FAddedTitle) then begin
    if FHintTimer <> nil then
      FreeAndNil(FHintTimer);

    InitExBorders(False);
    FreeAndNil(FAddedTitle);
    if not (csDesigning in ComponentState) then begin
      KillAnimations;
      if Form <> nil then begin
        IntUnskinForm(Form);
        Form.WindowProc := OldWndProc;
        if (Form.FormStyle = fsMDIChild) and Assigned(Form.Menu) then
          if Assigned(MDISkinProvider) and
               not (csDestroying in TsSkinProvider(MDISkinProvider).ComponentState) and
                 not (csDestroying in TsSkinProvider(MDISkinProvider).Form.ComponentState) then begin
            TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
            TsSkinProvider(MDISkinProvider).FLinesCount := -1;
            TsSkinProvider(MDISkinProvider).ProcessMessage(WM_NCPAINT);
          end;

        if MDISkinProvider = Self then begin
          if MDIForm <> nil then
            HookMDI(False);

          MDISkinProvider := nil;
        end;
      end;
      if Assigned(SystemMenu) then
        FreeAndNil(SystemMenu);

      if Assigned(TempBmp) then
        FreeAndnil(TempBmp);

      if Assigned(MenuLineBmp) then
        FreeAndNil(MenuLineBmp);
    end;
  end;

  DelFromGluedArray(Form);

  if ChildProvider = Self then
    ChildProvider := nil;

  if Assigned(FGlow1) then
    FreeAndNil(FGlow1);

  if Assigned(FGlow2) then
    FreeAndNil(FGlow2);

  if Assigned(FTitleIcon) then
    FreeAndNil(FTitleIcon);

  if Assigned(FTitleButtons) then
    FreeAndNil(FTitleButtons);

  FreeAndNil(FSysSubMenu);

  if Assigned(Adapter) then
    FreeAndNil(Adapter);

  if ListSW <> nil then
    FreeAndNil(ListSW);

  if FCommonData <> nil then
    FreeAndNil(FCommonData);

  if Assigned(FormTimer) then
    FreeAndNil(FormTimer);

  UpdateProviderThirdNames(Self);
  for i := 0 to Length(ThirdLists) - 1 do
    if ThirdLists[i] <> nil then
      FreeAndNil(ThirdLists[i]);

  SetLength(ThirdLists, 0);
  FreeAndNil(FThirdParty); 

  FreeAndNil(FFormHeader);
  FreeAndNil(FGluedForms);
  inherited Destroy;
end;


procedure TsSkinProvider.RepaintButton(i: integer);
var
  R: TRect;
  DC, SavedDC: hdc;
  BarItem: TacTitleBarItem;
  CurButton: PsCaptionButton;
  cx, ind, x, y, addY: integer;
  BtnDisabled, BtnLayered: boolean;
begin
  x := 0;
  y := 0;
  CurButton := nil;
  BarItem := nil;
  case i of
    HTCLOSE:      CurButton := @ButtonClose;
    HTMAXBUTTON:  CurButton := @ButtonMax;
    HTMINBUTTON:  CurButton := @ButtonMin;
    HTHELP:       CurButton := @ButtonHelp;
    HTCHILDCLOSE: CurButton := @MDIClose;
    HTCHILDMAX:   CurButton := @MDIMax;
    HTCHILDMIN:   CurButton := @MDIMin
    else
      if Between(i, HTUDBTN, (HTUDBTN + TitleButtons.Count - 1)) then begin
        if TitleButtons.Items[i - HTUDBTN].Visible then
          CurButton := @TitleButtons.Items[i - HTUDBTN].Data;
      end
      else
        if Assigned(FTitleBar) and Between(i, HTITEM, (HTITEM + FTitleBar.Items.Count - 1)) then
          if FTitleBar.Items[i - HTITEM].Visible then
            BarItem := FTitleBar.Items[i - HTITEM];
  end;
  if (i in [HTCHILDCLOSE]) and not MDIButtonsNeeded then
    Exit;

  if i >= HTITEM then
    BtnLayered := True
  else // Bar items may be layered only
    BtnLayered := not ((i in [HTCHILDCLOSE..HTCHILDMIN]) or (not FCommonData.SkinManager.Effects.AllowGlowing and (BorderForm = nil)) or (FormState <> 0) or (Form.Parent <> nil) or (Form.FormStyle = fsMDIChild));

  if not BtnLayered then begin
    if (CurButton <> nil) and (CurButton^.State <> -1) then begin
      BtnDisabled := False;
      if CurButton^.Rect.Left <= FIconRect.Right then
        Exit;

      cx := CaptionWidth - CurButton^.Rect.Left;
      BitBlt(FCommonData.FCacheBmp.Canvas.Handle, // Restore a button BG
             CurButton^.Rect.Left, CurButton^.Rect.Top, SysButtonwidth(CurButton^), ButtonHeight, TempBmp.Canvas.Handle, TempBmp.Width - cx, CurButton^.Rect.Top, SRCCOPY);
      // if Max btn and form is maximized then Norm btn
      if (i = HTMAXBUTTON) and (Form.WindowState = wsMaximized) then
        ind := FCommonData.SkinManager.ConstData.MaskNormBtn
      else
        case i of
          HTCHILDMIN: begin
            ind := CurButton^.ImageIndex;
            if ChildProvider <> nil then
              BtnDisabled := not ChildProvider.SystemMenu.EnabledMin;

            if BtnDisabled then
              Exit;
          end;
          HTCHILDMAX: begin // Correction of the Maximize button (may be Normalize)
            if Assigned(Form.ActiveMDIChild) and (Form.ActiveMDIChild.WindowState = wsMaximized) then begin
              ind := FCommonData.SkinManager.ConstData.MaskNormSmall;
              if ind < 0 then
                ind := FCommonData.SkinManager.ConstData.MaskNormBtn // For compatibility
            end
            else
              ind := CurButton^.ImageIndex;

            if ChildProvider <> nil then
              BtnDisabled := not ChildProvider.SystemMenu.EnabledRestore;
          end
          else
            if IsIconic(Form.Handle) then
              case i of
                HTMINBUTTON:
                  ind := FCommonData.SkinManager.ConstData.MaskNormBtn;

                HTMAXBUTTON: begin
                  ind := FCommonData.SkinManager.ConstData.MaskMaxBtn;
                  if not SystemMenu.EnabledMax then
                    BtnDisabled := True;
                end

                else
                  ind := CurButton^.ImageIndex;
              end
            else
              ind := CurButton^.ImageIndex;
        end;

      if FCommonData.SkinManager.IsValidImgIndex(ind) then // Drawing of the button from skin
        if i < HTUDBTN then // if not user defined
          DrawSkinGlyph(FCommonData.FCacheBmp, Point(CurButton^.Rect.Left, CurButton^.Rect.Top),
                        CurButton^.State, 1 + integer(not FormActive or BtnDisabled) * integer((CurButton^.State = 0) or BtnDisabled),
                        FCommonData.SkinManager.ma[ind], MakeCacheInfo(SkinData.FCacheBmp))
        else
          if (TitleButtons.Items[i - HTUDBTN].UseSkinData) then
            DrawSkinGlyph(FCommonData.FCacheBmp, Point(CurButton^.Rect.Left, CurButton^.Rect.Top),
                          CurButton^.State, 1 + integer(not FormActive) * integer(CurButton^.State = 0),
                          FCommonData.SkinManager.ma[ind], MakeCacheInfo(SkinData.FCacheBmp));

      // If user Glyph is defined
      if (i >= HTUDBTN) and Assigned(TitleButtons.Items[i - HTUDBTN].Glyph) then
        if TitleButtons.Items[i - HTUDBTN].Glyph.PixelFormat = pf32bit then begin
          x := CurButton^.Rect.Left + integer(CurButton^.State = 2) + (WidthOf(CurButton^.Rect) - TitleButtons.Items[i - HTUDBTN].Glyph.Width) div 2;
          y := CurButton^.Rect.Top + integer(CurButton^.State = 2) + (HeightOf(CurButton^.Rect) - TitleButtons.Items[i - HTUDBTN].Glyph.Height) div 2;
          CopyByMask(Rect(x, y, x + TitleButtons.Items[i - HTUDBTN].Glyph.Width, y + TitleButtons.Items[i - HTUDBTN].Glyph.Height),
                     MkRect(TitleButtons.Items[i - HTUDBTN].Glyph), FCommonData.FCacheBmp,
                     TitleButtons.Items[i - HTUDBTN].Glyph, MakeCacheInfo(FCommonData.FCacheBmp, x, y), True);
        end
        else
          CopyTransBitmaps(FCommonData.FCacheBmp, TitleButtons.Items[i - HTUDBTN].Glyph,
               CurButton^.Rect.Left + integer(CurButton^.State = 2) + (WidthOf(CurButton^.Rect) - TitleButtons.Items[i - HTUDBTN].Glyph.Width) div 2,
               CurButton^.Rect.Top + integer(CurButton^.State = 2) + (HeightOf(CurButton^.Rect) - TitleButtons.Items[i - HTUDBTN].Glyph.Height) div 2,
               TsColor(TitleButtons.Items[i - HTUDBTN].Glyph.Canvas.Pixels[0, TitleButtons.Items[i - HTUDBTN].Glyph.Height - 1]));

      // Copying to form
      DC := GetWindowDC(Form.Handle);
      SavedDC := SaveDC(DC);
      try
        if BorderForm <> nil then
          if IsZoomed(Form.Handle) then begin
            if FSysExHeight then
              addY := ShadowSize.Top + DiffTitle(BorderForm) + 4
            else
              addY := BorderForm.OffsetY;

            BitBlt(DC, CurButton^.Rect.Left - DiffBorder(Self.BorderForm) - ShadowSize.Left, CurButton^.Rect.Top - addY, WidthOf(CurButton^.Rect), HeightOf(CurButton^.Rect),
                   FCommonData.FCacheBmp.Canvas.Handle, CurButton^.Rect.Left, CurButton^.Rect.Top, SRCCOPY)
          end
          else
            BitBlt(DC, CurButton^.Rect.Left - DiffBorder(Self.BorderForm) - ShadowSize.Left, CurButton^.Rect.Top - DiffTitle(Self.BorderForm) - ShadowSize.Top, WidthOf(CurButton^.Rect), HeightOf(CurButton^.Rect),
                   FCommonData.FCacheBmp.Canvas.Handle, CurButton^.Rect.Left, CurButton^.Rect.Top, SRCCOPY)
        else
          BitBlt(DC, CurButton^.Rect.Left, CurButton^.Rect.Top, WidthOf(CurButton^.Rect), HeightOf(CurButton^.Rect),
                 FCommonData.FCacheBmp.Canvas.Handle, CurButton^.Rect.Left, CurButton^.Rect.Top, SRCCOPY);

        if (CurButton^.State = 1) and (i in [HTCLOSE, HTMAXBUTTON, HTMINBUTTON]) then begin
          case i of
            HTCLOSE:     x := FCommonData.SkinManager.CommonSkinData.BICloseGlow;
            HTMAXBUTTON: x := FCommonData.SkinManager.CommonSkinData.BIMaxGlow;
            HTMINBUTTON: x := FCommonData.SkinManager.CommonSkinData.BIMinGlow;
          end;
          if x > 0 then begin
            case i of
              HTCLOSE:     y := FCommonData.SkinManager.CommonSkinData.BICloseGlowMargin;
              HTMAXBUTTON: y := FCommonData.SkinManager.CommonSkinData.BIMaxGlowMargin;
              HTMINBUTTON: y := FCommonData.SkinManager.CommonSkinData.BIMinGlowMargin;
            end;
            if BorderForm <> nil then
              GetWindowRect(BorderForm.AForm.Handle, R)
            else
              GetWindowRect(Form.Handle, R);

            OffsetRect(R, CurButton^.Rect.Left, CurButton^.Rect.Top);
            R.Right := R.Left + WidthOf(CurButton^.Rect);
            R.Bottom := R.Top + HeightOf(CurButton^.Rect);

            if SkinData.SkinManager.Effects.AllowGlowing and (Form.Parent = nil) and (Form.FormStyle <> fsMDIChild) then
              if BorderForm <> nil then
                CurButton^.GlowID := ShowGlow(R, s_GlobalInfo, FCommonData.SkinManager.ma[CurButton.ImageIndex].PropertyName + s_Glow,
                                              y, MaxByte, BorderForm.AForm.Handle, FCommonData)
              else
                CurButton^.GlowID := ShowGlow(R, s_GlobalInfo, FCommonData.SkinManager.ma[CurButton.ImageIndex].PropertyName + s_Glow,
                                              y, MaxByte, Form.Handle, FCommonData);
          end;
        end
        else
          if (CurButton <> nil) then
            HideGlow(CurButton^.GlowID);
      finally
        RestoreDC(DC, SavedDC);
        ReleaseDC(Form.Handle, DC);
      end;
    end
    else
      if (CurButton <> nil) then
        HideGlow(CurButton^.GlowID);
  end
  else begin
    ind := max(1, integer(SkinData.SkinManager.Effects.AllowAnimation) * 10);
    // Old title buttons
    if (CurButton <> nil) and (CurButton^.State <> -1) then
      case CurButton^.State of
        1:   StartSBAnimation(CurButton, CurButton^.State, ind, True,  Self);
        2:   StartSBAnimation(CurButton, CurButton^.State, 1,   True,  Self)
        else StartSBAnimation(CurButton, CurButton^.State, ind, False, Self)
      end
    // Title Bar Items
    else
      if BarItem <> nil then
        if BorderForm <> nil then
          case BarItem.State of
            1:   StartItemAnimation(BarItem, ind, True,  BorderForm.AForm);
            2:   StartItemAnimation(BarItem, ind, True,  BorderForm.AForm)
            else StartItemAnimation(BarItem, ind, False, BorderForm.AForm)
          end
        else
          case BarItem.State of
            1:   StartItemAnimation(BarItem, ind, True);
            2:   StartItemAnimation(BarItem, ind, True)
            else StartItemAnimation(BarItem, ind, False)
          end
  end;
end;


function TsSkinProvider.HTProcess(var Message: TWMNCHitTest): integer;
const
  DefRESULT = HTCLIENT;
var
  NewP, p: TPoint;
  GripVisible: boolean;
  R, hrect, vrect: TRect;
  ii, i, sbw, SysBtnCount, BtnIndex: integer;

  function GetBtnIndex: integer;
  var
    i, c: integer;
  begin
    Result := 0;
    if BorderForm = nil then begin
      if SystemMenu = nil then
        PrepareForm;

      if SystemMenu <> nil then begin
        c := 0;
        if HaveSysMenu and Assigned(SystemMenu) then begin
          inc(c);
          if PtInRect(ButtonClose.Rect, p) then
            Result := c
          else begin
            if SystemMenu.VisibleMax then begin
              inc(c);
              if PtInRect(ButtonMax.Rect, p) then begin
                Result := c;
                Exit;
              end;
            end;
            if SystemMenu.VisibleMin then begin
              inc(c);
              if PtInRect(ButtonMin.Rect, p) then
                Result := c
            end;
            if Result <> 0 then
              Exit;

            if (biHelp in Form.BorderIcons) then begin
              inc(c);
              if PtInRect(ButtonHelp.Rect, p) then begin
                Result := c;
                Exit;
              end;
            end;
          end;
        end;
        for i := 0 to TitleButtons.Count - 1 do begin
          inc(c);
          if not TitleButtons[i].Visible then
            Continue;

          if PtInRect(TitleButtons[i].Data.Rect, p) then begin
            Result := c;
            Exit;
          end;
        end;
        if Assigned(FTitleBar) then
          for i := 0 to FTitleBar.Items.Count - 1 do begin
            inc(c);
            if not FTitleBar.Items[i].Visible then
              Continue;

            if PtInRect(FTitleBar.Items[i].Rect, p) then begin
              if FTitleBar.Items[i].Style in [bsSpacing, bsInfo] then
                Result := 0
              else
                Result := c;

              Exit;
            end;
          end;
      end;
    end;
  end;

begin
  p := CursorToPoint(Message.XPos, Message.YPos);
  Result := DefRESULT;
  BtnIndex := GetBtnIndex;
  if (BtnIndex > 0) then begin
    SysBtnCount := 0;
    if HaveSysMenu then begin
      inc(SysBtnCount);
      if SystemMenu.VisibleMax then
        inc(SysBtnCount);

      if SystemMenu.VisibleMin or IsIconic(Form.Handle) then
        inc(SysBtnCount);

      if biHelp in Form.BorderIcons then
        inc(SysBtnCount);
    end;
    if (BtnIndex <= SysBtnCount) then begin
      case BtnIndex of
        1:
          if HaveSysMenu then
            if SystemMenu.EnabledClose then
              Result := HTCLOSE
            else
              Result := HTCAPTION;

        2:
          if SystemMenu.VisibleMax then
            Result := iff(SystemMenu.EnabledMax or (SystemMenu.EnabledRestore and not IsIconic(Form.Handle)), HTMAXBUTTON, HTCAPTION)
          else
            if (SystemMenu.VisibleMin) or IsIconic(Form.Handle) then
              Result := iff(SystemMenu.EnabledMin, HTMINBUTTON, HTCAPTION)
            else
              if (biHelp in Form.BorderIcons) then
                Result := HTHELP;

        3:
          if (SystemMenu.VisibleMin) or IsIconic(Form.Handle) then
            if not IsIconic(Form.Handle) then
              Result := iff(SystemMenu.EnabledMin, HTMINBUTTON, HTCAPTION)
            else
              Result := HTMINBUTTON
          else
            if (biHelp in Form.BorderIcons) then
              Result := HTHELP;

        4:
          if (biHelp in Form.BorderIcons) and SystemMenu.VisibleMax then
            Result := HTHELP;
      end;
    end
    else
      if (BtnIndex <= TitleButtons.Count + SysBtnCount) then begin // UDF button
        BtnIndex := BtnIndex - SysBtnCount - 1;
        if TitleButtons.Items[BtnIndex].Enabled then
          Result := HTUDBTN + BtnIndex;
      end
      else
        if FTitleBar <> nil then begin
          BtnIndex := BtnIndex - SysBtnCount - TitleButtons.Count - 1;
          if FTitleBar.Items[BtnIndex].Enabled and ((FTitleBar.Items[BtnIndex].Style <> bsTab) or not FTitleBar.Items[BtnIndex].Down) then
            Result := HTITEM + BtnIndex;
        end;

    if Result <> DefRESULT then
      Exit;
  end;

  sbw := SysBorderWidth(Form.Handle, BorderForm);
  if (Form.WindowState <> wsMaximized) and (GetWindowLong(Form.Handle, GWL_STYLE) and WS_SIZEBOX = WS_SIZEBOX) and (BorderForm = nil) then begin
    if (p.Y < SysBorderHeight(Form.Handle, BorderForm, False)) then
      Result := HTTOP;

    if (p.Y > Form.Height - sbw) then
      Result := HTBOTTOM;

    if (p.X < sbw) then
      if Result = HTTOP then
        Result := HTTOPLEFT
      else
        Result := iff(Result = HTBOTTOM, HTBOTTOMLEFT, HTLEFT);

    if (p.X > Form.Width - sbw) then
      if Result = HTTOP then
        Result := HTTOPRIGHT
      else
        Result := iff(Result = HTBOTTOM, HTBOTTOMRIGHT, HTRIGHT);

    if Result <> DefRESULT then
      Exit;
  end;
  ii := SysCaptHeight(Form);
  ii := ii + SysBorderHeight(Form.Handle, BorderForm);
  if Between(p.Y, 0, ii) then begin
    if Between(p.Y, SysCaptHeight(Form) + SysBorderHeight(Form.Handle, BorderForm, False), CaptionHeight(False) + SysBorderHeight(Form.Handle, BorderForm, False) + MenuHeight) then begin
      Result := HTMENU;
      Exit;
    end;
    Result := iff(PtInRect(FIconRect, p), HTSYSMENU, HTCAPTION);
  end
  else begin
    ii := ii + GetLinesCount * MenuHeight;
    if p.Y <= ii then begin
      // MDI child buttons            
      if MDIButtonsNeeded then begin
        NewP := Point(p.X + ShadowSize.Left + DiffBorder(BorderForm), p.Y + ShadowSize.Top + DiffTitle(BorderForm));
        if PtInRect(MDICLose.Rect, NewP) then
          Result := HTCHILDCLOSE
        else
          if PtInRect(MDIMax.Rect, NewP) then
            Result := HTCHILDMAX
          else
            Result := iff(PtInRect(MDIMin.Rect, NewP), HTCHILDMIN, HTMENU);
      end
      else
        Result := HTMENU;
    end
    else begin
      if IsGripVisible(Self) then
        GripVisible := True
      else
        if Assigned(ListSW) and Assigned(ListSW.sbarVert) and ListSW.sbarVert.fScrollVisible and ListSW.sbarHorz.fScrollVisible then begin
          Ac_GetHScrollRect(ListSW, Form.Handle, hrect);
          Ac_GetVScrollRect(ListSW, Form.Handle, vrect);
          GetWindowRect(Form.Handle, R);
          GripVisible := PtInRect(Rect(hrect.Right - R.Left, hrect.Top - R.Top, vrect.Right - R.Left, hrect.Bottom - R.Top), p)
        end
        else
          GripVisible := False;

      if GripVisible then begin
        i := FCommonData.SkinManager.ConstData.GripRightBottom;
        if FCommonData.SkinManager.IsValidImgIndex(i) then
          if (BorderForm <> nil) then begin
            if (p.y > RBGripPoint(i).y - DiffTitle(Self.BorderForm) - ShadowSize.Top) and (p.x > RBGripPoint(i).x - DiffBorder(Self.BorderForm) - ShadowSize.Left) then
              Result := HTBOTTOMRIGHT;
          end
          else
            if (p.y > RBGripPoint(i).y) and (p.x > RBGripPoint(i).x) then
              Result := HTBOTTOMRIGHT;
      end;
    end;
  end;
end;


procedure UpdateMainForm(UpdateNow: boolean = True);
var
  Flags: Cardinal;
begin
  if Assigned(MDISkinProvider) then
    with TsSkinProvider(MDISkinProvider) do
      if DrawNonClientArea then begin
        FCommonData.BeginUpdate;
        if Assigned(MDIForm) then
          TsMDIForm(MDIForm).UpdateMDIIconItem;

        FCommonData.BGChanged := True;
        if FGlow1 <> nil then
          FreeAndNil(FGlow1);

        if FGlow2 <> nil then
          FreeAndNil(FGlow2);

        MenuChanged := True;
        FLinesCount := -1;
        FCommonData.EndUpdate;

        Flags := RDW_ERASE or RDW_FRAME or RDW_INTERNALPAINT or RDW_INVALIDATE;
        if UpdateNow then
          Flags := Flags + RDW_UPDATENOW;

        RedrawWindow(Form.ClientHandle, nil, 0, Flags);
        RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);

        if UpdateNow and (BorderForm <> nil) then
          BorderForm.UpdateExBordersPos;
      end
      else
        RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
end;


function HandleEdge(eDynamic: integer; eStatic, SnapDistance: integer): integer;
begin
  if BetWeen(eDynamic, eStatic - SnapDistance, eStatic + SnapDistance) then
    Result := eDynamic - eStatic
  else
    Result := 0;
end;


type
  TAccessForm = class(TForm);

function ExtBordersNeeded(sp: TsSkinProvider): boolean;
begin
  if (sp.SkinData <> nil) and (sp.SkinData.SkinManager <> nil) and sp.SkinData.SkinManager.ExtendedBorders and sp.AllowExtBorders and
       (not sp.SkinData.SkinManager.Options.NativeBordersMaximized or (sp.Form.WindowState <> wsMaximized)) then
    Result := True
  else
    Result := False
end;


function SearchWndByID(ID: WParam; Component: TComponent): TWincontrol;
var
  i: integer;
  ind: integer;
begin
  Result := nil;
  for i := 0 to Component.ComponentCount - 1 do begin
    if (Component.Components[i] is TWinControl) and
         TWinControl(Component.Components[i]).HandleAllocated then begin

      ind := GetDlgCtrlID(TWinControl(Component.Components[i]).Handle);
      if (ind = integer(ID)) then begin
        Result := TWinControl(Component.Components[i]);
        Exit;
      end;
    end;
    Result := SearchWndByID(ID, Component.Components[i]);
    if Result <> nil then
      Exit;
  end;
end;


procedure TsSkinProvider.NewWndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
//  if Form.Tag = 1 then
    AddToLog(Message);
{$ENDIF}
  if (Message.Msg <> SM_ALPHACMD) or not AC_SMAlphaCmd_Common(Message) then
    if (csDestroying in Form.ComponentState) or not FCommonData.Skinned then begin
      if (Message.Msg = SM_ALPHACMD) and AC_SMAlphaCmd_Unskinned(Message) then
        Exit;

{$IFNDEF NOWNDANIMATION}
      case Message.Msg of
        CM_VISIBLECHANGED: AC_CMVisibleChanged_Unskinned(Message);
  {$IFNDEF ALITE}
        CM_MOUSEWHEEL: begin
          AC_CMMouseWheel(TCMMouseWheel(Message));
          Exit;
        end;
  {$ENDIF}
      end;
{$ENDIF}
      OldWndProc(Message);
      case Message.Msg of
{$IFNDEF NOWNDANIMATION}
        WM_WINDOWPOSCHANGED: AC_WMWindowPosChanged_Unskinned(TWMWindowPosChanging(Message));
{$ENDIF}
        WM_NCDESTROY: AC_WMNCDestroy;
      end;
    end
    else
      case Message.Msg of
        WM_DWMSENDICONICLIVEPREVIEWBITMAP:
          if ac_ChangeThumbPreviews then // Task menu support when not MainFormOnTaskBar
            Message.Result := LRESULT(SetPreviewBmp(Form.Handle, Self));

        WM_DWMSENDICONICTHUMBNAIL:
          if ac_ChangeThumbPreviews and (Message.LParamHi <> 0) and (Message.LParamLo <> 0) then // Task menu support when not MainFormOnTaskBar
            Message.Result := LRESULT(SetThumbIcon(Form.Handle, Self, Message.LParamHi, Message.LParamLo));

        SM_ALPHACMD:          AC_SMAlphaCmd_Skinned(Message);
        WM_NCMOUSEMOVE:       AC_WMNCMouseMove(TWMNCMouseMove(Message));
        WM_SETREDRAW:         AC_WMSetRedraw(Message);
        WM_EXITSIZEMOVE:      AC_WMExitSizeMove(Message);
        WM_GETMINMAXINFO:     AC_WMGetMinMaxInfo(TWMGetMinMaxInfo(Message));
        WM_SETICON:           AC_WMSetIcon(Message);
  {$IFNDEF FPC}
        WM_CONTEXTMENU:       AC_WMContextMenu(Message);
        WM_INITMENUPOPUP:     AC_WMInitMenuPopup(TWMInitMenuPopup(Message));
  {$ENDIF}
        WM_STYLECHANGED:      AC_WMStyleChanged(Message);
        WM_SHOWWINDOW:        AC_WMShowWindow(Message);
        WM_SETTEXT:           AC_WMSetText(Message);
        CM_ENABLEDCHANGED:    AC_CMEnabledChanged(Message);
        WM_SYSCOLORCHANGE:    AC_WMSysColorChange(Message);
        WM_CHILDACTIVATE:     AC_WMChildActivate(Message);
        WM_SIZE:              AC_WMSize(Message);
        WM_MOVE:              AC_WMMove(Message);
        WM_ENTERMENULOOP:     AC_WMEnterMenuLoop(Message);
        WM_EXITMENULOOP:      AC_WMExitMenuLoop(Message);
        WM_NCHITTEST:         AC_WMNCHitTest(Message);
        WM_SIZING:            AC_WMSizing(Message);
        CM_MOUSEENTER:        AC_CMMouseEnter(Message);
        WM_NCCREATE:          AC_WMNCCreate(Message);
        WM_NCLBUTTONDOWN:     AC_WMNCLButtonDown(TWMNCLButtonDown(Message));
        WM_SETTINGCHANGE:     AC_WMSettingChange(Message);
        WM_MOUSEMOVE:         AC_WMMouseMove(Message);
        WM_NCRBUTTONDOWN:     AC_WMNCRButtonDown(Message);
        WM_NCRBUTTONUP:       AC_WMNCRButtonUp(TWMNCLButtonDown(Message));
        CM_FLOAT:             AC_CMFloat(Message);
        CM_MENUCHANGED:       AC_CMMenuChanged(Message);
        WM_PRINT:             AC_WMPrint(Message);
        WM_NCPAINT:           AC_WMNCPaint(Message);
        WM_ERASEBKGND:        AC_WMEraseBkGnd(Message);
        WM_PAINT:             AC_WMPaint(Message);
        CM_RECREATEWND:       AC_CMRecreateWnd(Message);
        WM_NCACTIVATE:        AC_WMNCActivate(TWMNCActivate(Message));
        WM_ACTIVATE:          AC_WMActivate(TWMActivate(Message));
        WM_ACTIVATEAPP:       AC_WMActivateApp(Message);
        CM_VISIBLECHANGED:    AC_WMVisibleChanged(Message);
        WM_NCLBUTTONDBLCLK:   AC_WMNCLButtonDblClick(Message);
        WM_MEASUREITEM:       AC_WMMeasureItem(Message);
        WM_SYSCOMMAND:        AC_WMSysCommand(Message);
        WM_WINDOWPOSCHANGING: AC_WMWindowPosChanging(TWMWindowPosChanging(Message));
        WM_QUERYENDSESSION:   AC_WMQueryEndSession(Message);
        WM_WINDOWPOSCHANGED:  AC_WMWindowPosChanged(Message);
        WM_CREATE:            AC_WMCreate(Message);
        WM_PARENTNOTIFY:      AC_WMParentNotify(Message);
        WM_NOTIFY:            AC_WMNotify(Message);
        CM_CONTROLLISTCHANGE: AC_WMControlListChange(TCMControlListChange(Message));

        WM_MDIACTIVATE,
        WM_MDIDESTROY:        AC_WMMDIDestroy(Message);

        WM_MOUSELEAVE,
        CM_MOUSELEAVE:        AC_WMMouseLeave(Message);

        WM_NCLBUTTONUP,
        WM_LBUTTONUP:         AC_WMLButtonUp(TWMNCLButtonUp(Message));

        WM_ENTERIDLE:         Message.Result := 0;
        WM_PRINTCLIENT:       ;

{
        147, Std menu haven't captions if disabled
}
{$IFNDEF ALITE}
        CM_MOUSEWHEEL:        AC_CMMouseWheel(TCMMouseWheel(Message));
{$ENDIF}

{$IFNDEF DISABLEPREVIEWMODE}
        ASE_MSG:              AC_ASEMSG(Message); // Used with ASkinEditor
        WM_COPYDATA:          AC_WMCopyData(TWMCopyData(Message));
{$ENDIF}

//{$IFNDEF NOWNDANIMATION}
        CM_SHOWINGCHANGED:    AC_CMShowingChanged(Message);
{$IFNDEF NOWNDANIMATION}
        WM_CLOSE:             AC_WMClose(Message);
{$ENDIF}
        787:                  DropSysMenu(Mouse.CursorPos.X, Mouse.CursorPos.Y);
        45132, 48205:         Message.Result := 0
        else
          OldWndProc(Message);
      end;
end;


function MaxBtnOffset(sp: TsSkinProvider; Max: boolean = False): integer;
var
  i1, i2: integer;
begin
  with sp do begin
    i1 := sp.ActualTitleHeight(Max);
    i2 := SysCaptHeight(sp.Form);
    if (i1 > i2 + 4) then // If skinned caption height is bigger than unskinned
      Result := i1 - (i2 + 4) {sbwf} // Get difference between captions
    else
      Result := 0;
  end;
end;


procedure TsSkinProvider.PaintTitleContent(CaptWidth: integer);
var
  i, index, b, x, y: integer;
  TitleButton: TsTitleButton;
  sMan: TsSkinManager;

  procedure PaintButton(var Btn: TsCaptionButton; BtnEnabled: boolean);
  begin
    if Btn.ImageIndex >= 0 then
      DrawSkinGlyph(FCommonData.FCacheBmp, Btn.Rect.TopLeft, Btn.State * integer(Btn.Timer = nil),
                    1 + integer(not FormActive or not BtnEnabled or not Form.Enabled) * integer((Btn.State = 0) or (Btn.Timer <> nil)),
                    sMan.ma[Btn.ImageIndex], MakeCacheInfo(SkinData.FCacheBmp));
  end;

begin
  if HaveBorder(Self) then begin
    sMan := FCommonData.SkinManager;
    // Copy back stored background
    RestoreBtnsBG(CaptWidth);
    // Paint sys buttons
    if Assigned(SystemMenu) and HaveSysMenu then begin
      PaintButton(ButtonClose, SystemMenu.VisibleClose and SystemMenu.EnabledClose);
      if SystemMenu.VisibleMax then
        PaintButton(ButtonMax, SystemMenu.EnabledMax);

      if SystemMenu.VisibleMin then
        PaintButton(ButtonMin, SystemMenu.EnabledMin);

      if biHelp in Form.BorderIcons then
        PaintButton(ButtonHelp, True);
    end;
    // Paint title buttons
    if (TitleButtons <> nil) and (TitleButtons.Count > 0) then // TitleButtons will be removed soon
      for index := 0 to TitleButtons.Count - 1 do
        if TitleButtons.Items[index].Visible then begin
          TitleButton := TitleButtons.Items[index];
          PaintButton(TitleButton.Data, TitleButton.Enabled);
          TitleButton.Data.HitCode := HTUDBTN + index;
          if Assigned(TitleButton.Glyph) and not TitleButton.Glyph.Empty then
            if TitleButton.Glyph.PixelFormat = pf32bit then begin
              x := TitleButton.Data.Rect.Left + (UserButtonWidth(TitleButton) - TitleButton.Glyph.Width) div 2;
              y := TitleButton.Data.Rect.Top + (ButtonHeight - TitleButton.Glyph.Height) div 2;
              CopyByMask(Rect(x, y, x + TitleButton.Glyph.Width, y + TitleButton.Glyph.Height),
                         MkRect(TitleButton.Glyph), FCommonData.FCacheBmp, TitleButton.Glyph, MakeCacheInfo(FCommonData.FCacheBmp, 0, 0), True);
            end
            else
              CopyTransBitmaps(FCommonData.FCacheBmp, TitleButton.Glyph,
                               TitleButton.Data.Rect.Left + (UserButtonWidth(TitleButton) - TitleButton.Glyph.Width) div 2,
                               TitleButton.Data.Rect.Top + (ButtonHeight - TitleButton.Glyph.Height) div 2,
                               TsColor(TitleButton.Glyph.Canvas.Pixels[0, TitleButton.Glyph.Height - 1]));
        end;

    // Paint Bar items
    if Assigned(FTitleBar) and (FTitleBar.Items.Count > 0) then begin
      for index := FTitleBar.Items.Count - 1 downto 0 do
        with FTitleBar.Items[index] do
          if ((Style <> bsTab) or not Down) and Visible then
            if (Rect.Left > 0) and (Rect.Right < CaptWidth) then
              PaintTitleItem(FTitleBar.Items[index], Rect, FCommonData.FCacheBmp);
      // Paint active tab if exists
      for index := FTitleBar.Items.Count - 1 downto 0 do
        with FTitleBar.Items[index] do
          if (Style = bsTab) and Down and Visible then
            if (Rect.Left > 0) and (Rect.Right < CaptWidth) then
              PaintTitleItem(FTitleBar.Items[index], Rect, FCommonData.FCacheBmp);
    end;
    // Paint MDI child buttons if maximized
    if MDIButtonsNeeded then begin
      b := CaptionHeight + SysBorderHeight(Form.Handle, BorderForm) + ShadowSize.Top + (MenuHeight - SmallButtonHeight) div 2 + (GetLinesCount - 1) * MenuHeight; // Buttons top
      if sMan.IsValidImgIndex(MDIMin.ImageIndex) then begin
        MDIMin.Rect := Bounds(CaptWidth - SysBorderWidth(Form.Handle, BorderForm) - 3 * (SmallButtonWidth + 1) - ShadowSize.Right, b, SmallButtonWidth, SmallButtonHeight);
        DrawSkinGlyph(FCommonData.FCacheBmp, MDIMin.Rect.TopLeft,
                  MDIMin.State, 1 + integer(not FormActive or not ChildProvider.SystemMenu.EnabledMin), sMan.ma[MDIMin.ImageIndex], MakeCacheInfo(SkinData.FCacheBmp));
      end;
      if Assigned(TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild) and { Draw norm. button when maximized }
           (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState <> wsMaximized) then
        i := MDIMax.ImageIndex
      else
        i := iff(sMan.ConstData.MaskNormSmall < 0, sMan.ConstData.MaskNormBtn, sMan.ConstData.MaskNormSmall);

      MDIMax.Rect := Bounds(CaptWidth - SysBorderWidth(Form.Handle, BorderForm) - 2 * (SmallButtonWidth + 1) - ShadowSize.Right, b, SmallButtonWidth, SmallButtonHeight);
      if sMan.IsValidImgIndex(i) then
        DrawSkinGlyph(FCommonData.FCacheBmp, MDIMax.Rect.TopLeft,
                      MDIMax.State, 1 + integer(not FormActive or not ChildProvider.SystemMenu.EnabledRestore),
                      sMan.ma[i], MakeCacheInfo(SkinData.FCacheBmp));

      if sMan.IsValidImgIndex(MDIClose.ImageIndex) then begin
        MDIClose.Rect := Bounds(CaptWidth - SysBorderWidth(Form.Handle, BorderForm) - SmallButtonWidth - 1 - ShadowSize.Right, b, SmallButtonWidth, SmallButtonHeight);
        DrawSkinGlyph(FCommonData.FCacheBmp, MDIClose.Rect.TopLeft, MDIClose.State, 1 + integer(not FormActive), sMan.ma[MDIClose.ImageIndex],
                      MakeCacheInfo(SkinData.FCacheBmp));
      end;
    end;
  end;
end;


procedure TsSkinProvider.PaintCaption(DC: hdc);
var
  h, hh, bh, bw, hmnu, w: integer;
begin
  h := SysBorderHeight(Form.Handle, BorderForm) + CaptionHeight;
  if IsIconic(Form.Handle) then
    inc(h);

  w := CaptionWidth;
  if FCommonData.BGChanged or not IsCached(FCommonData) then begin
    if MenuChanged or
         (FCommonData.FCacheBmp = nil) or
           IsBorderUnchanged(FCommonData.BorderIndex, FCommonData.SkinManager) or
             (FCommonData.FCacheBmp.Width <> w) or
               (FCommonData.FCacheBmp.Height <> Form.Height) or
                 not HaveBorder(Self) then // if ready caption BG
      ControlsChanged := not FirstInitialized;

    PaintAll;
    FCommonData.BGChanged := False;
    FCommonData.Updating := False;
  end;
  hmnu := integer(MenuPresent) * (LinesCount * MenuHeight + 1);
  bh := BorderHeight;
  if GetWindowLong(Form.Handle, GWL_STYLE) and WS_CAPTION = WS_CAPTION then
    hh := HeaderHeight
  else
    hh := bh;

  bw := BorderWidth;
  if hh <> 0 then
    BitBlt(DC, 0, 0, w, hh, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY) // Title and menu line update
  else
    BitBlt(DC, 0, 0, w, hmnu, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY); // Only menu line update

  BitBlt(DC, 0, hh, bw, FCommonData.FCacheBmp.Height - hh, FCommonData.FCacheBmp.Canvas.Handle, 0, h + hmnu + TForm(Form).BorderWidth, SRCCOPY); // Left border update
  BitBlt(DC, bw, Form.Height - bh, w - bw, bh, FCommonData.FCacheBmp.Canvas.Handle, // Bottom border update
         SysBorderwidth(Form.Handle, BorderForm) + TForm(Form).BorderWidth, Form.Height - bh, SRCCOPY);
  BitBlt(DC, FCommonData.FCacheBmp.Width - bw, hh, bh, FCommonData.FCacheBmp.Height - bh, FCommonData.FCacheBmp.Canvas.Handle, // Right border update
         FCommonData.FCacheBmp.Width - bw, h + hmnu + TForm(Form).BorderWidth, SRCCOPY);
end;


procedure TsSkinProvider.PaintForm(DC: hdc; SendUpdated: boolean = True);
var
  Changed: boolean;
  i, w: integer;
  R: TRect;
begin
  R := Form.ClientRect;
  if (SkinData.CtrlSkinState and ACS_FAST = ACS_FAST) then begin
    if (Form.FormStyle <> fsMDIForm) then begin
      if Form.BorderStyle = bsSingle then
        i := integer(SkinData.BorderIndex >= 0) * ac_CXFIXEDFRAME - SkinData.SkinManager.ma[SkinData.BorderIndex].WL
      else
        i := 0;

      FillDC(DC, R, FormColor);
      if DrawNonClientArea and (FCommonData.FCacheBmp <> nil) and (i > 0) then
        with SkinData.SkinManager do begin
          // Top border
          BitBlt(DC, R.Left, R.Top, WidthOf(R), ma[SkinData.BorderIndex].WT - i, FCommonData.FCacheBmp.Canvas.Handle, OffsetX, OffsetY, SRCCOPY);
          // Left
          BitBlt(DC, R.Left, R.Top, ma[SkinData.BorderIndex].WL - i, HeightOf(R), FCommonData.FCacheBmp.Canvas.Handle, OffsetX, OffsetY, SRCCOPY);
          // Right
          w := R.Right - (ma[SkinData.BorderIndex].WR - i);
          BitBlt(DC, w, R.Top, ma[SkinData.BorderIndex].WL - i, HeightOf(R), FCommonData.FCacheBmp.Canvas.Handle, OffsetX + w, OffsetY, SRCCOPY);
          // Bottom
          w := R.Bottom - (ma[SkinData.BorderIndex].WB - i);
          BitBlt(DC, R.Left, w, R.Right, ma[SkinData.BorderIndex].WB - i, FCommonData.FCacheBmp.Canvas.Handle, OffsetX, OffsetY + w, SRCCOPY);
        end;
    end;
  end
  else begin
    Changed := FCommonData.BGChanged;
    PaintAll;
    if (Form.FormStyle <> fsMDIForm) then begin
      CopyWinControlCache(Form, FCommonData, Rect(OffsetX, OffsetY, 0, 0), MkRect(Form.ClientWidth, Form.ClientHeight), DC, False);
      PaintControls(DC, Form, ControlsChanged or Changed, MkPoint, Form.Handle, False);
    end;
    if SendUpdated then begin
      SetParentUpdated(Form);
      SendToAdapter(MakeMessage(SM_ALPHACMD, MakeWParam(0, AC_ENDPARENTUPDATE), 0, 0));
    end;
  end;
  ControlsChanged := False;
end;


procedure ShowHint(Btn: TsTitleButton);
var
  p: TPoint;
begin
  if (Btn.HintWnd = nil) {and TsTitleButtons(Btn.Collection).FOwner.Form.ShowHint} then begin
    p := acMousePos;
    if HintWindowClass = THintWindow then
      Btn.HintWnd := acShowHintWnd(Btn.Hint, Point(p.X + 8, p.Y + 16))
    else
      acShowHintWnd(Btn.Hint, Point(p.X + 8, p.Y + 16));
  end;
end;


procedure HideHint(Btn: TsTitleButton);
begin
  if Btn.HintWnd <> nil then
    FreeAndNil(Btn.HintWnd);
end;

{$IFNDEF ALITE}
type
  TAccessAlphaHints = class(TsAlphaHints);
{$ENDIF}

procedure TsSkinProvider.SetHotHT(const i: integer; const Repaint: boolean = True);
begin
  if (i <> CurrentHT) and FDrawNonClientArea then begin
    if HotItem.Item <> nil then begin
  {$IFNDEF FPC}
      RepaintMenuItem(HotItem.Item, HotItem.R, []);
  {$ENDIF}
      HotItem.Item := nil;
    end;
    if FHintTimer <> nil then
      FreeAndNil(FHintTimer);

    if not ((CurrentHT = i) or (CurrentHT = -1) and (i = 0)) then
      if (CurrentHT > 0) then begin
  {$IFNDEF ALITE}
        if (acAlphaHints.Manager <> nil) and (TAccessAlphaHints(acAlphaHints.Manager).HideTimer <> nil) and TAccessAlphaHints(acAlphaHints.Manager).HideTimer.Enabled then
          TAccessAlphaHints(acAlphaHints.Manager).HideTimer.OnTimer(TAccessAlphaHints(acAlphaHints.Manager).HideTimer);
  {$ENDIF}
        case CurrentHT of
          HTCLOSE:      ButtonClose.State := 0;
          HTMAXBUTTON:  ButtonMax.State   := 0;
          HTMINBUTTON:  ButtonMin.State   := 0;
          HTHELP:       ButtonHelp.State  := 0;
          HTCHILDCLOSE: MDIClose.State    := 0;
          HTCHILDMAX:   MDIMax.State      := 0;
          HTCHILDMIN:   MDIMin.State      := 0
          else
            if BetWeen(CurrentHT, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin
              TitleButtons.Items[CurrentHT - HTUDBTN].Data.State := 0;
              HideHint(TitleButtons.Items[CurrentHT - HTUDBTN]);
            end
            else
              if BetWeen(CurrentHT, HTITEM, HTITEM + MaxByte) then
                if Assigned(FTitleBar) and (CurrentHT - HTITEM < FTitleBar.Items.Count) then begin
                  if Assigned(FTitleBar.Items[CurrentHT - HTITEM].OnMouseLeave) then
                    FTitleBar.Items[CurrentHT - HTITEM].OnMouseLeave(FTitleBar.Items[CurrentHT - HTITEM]);

                  FTitleBar.Items[CurrentHT - HTITEM].State := 0;
                  HideHintWnd(FTitleBar.Items[CurrentHT - HTITEM]);
                end;
        end;
        if Repaint then
          RepaintButton(CurrentHT);
      end;

    CurrentHT := i;
    if biClicked or (CurrentHT <= 0) then
      Exit; // If button is pressed and position of form is changed

    case CurrentHT of
      HTCLOSE:      ButtonClose.State := 1;
      HTMAXBUTTON:  ButtonMax.State   := 1;
      HTMINBUTTON:  ButtonMin.State   := 1;
      HTHELP:       ButtonHelp.State  := 1;
      HTCHILDCLOSE: MDIClose.State    := 1;
      HTCHILDMAX:   MDIMax.State      := 1;
      HTCHILDMIN:   MDIMin.State      := 1;

      HTUDBTN..HTUDBTN + MaxByte: begin
        TitleButtons.Items[CurrentHT - HTUDBTN].Data.State := 1;
        ShowHint(TitleButtons.Items[CurrentHT - HTUDBTN]);
      end;

      HTITEM..HTITEM + MaxByte: if Assigned(FTitleBar) then
        if (CurrentHT - HTITEM < FTitleBar.Items.Count) then begin
          if Assigned(FTitleBar.Items[CurrentHT - HTITEM].OnMouseEnter) then
            FTitleBar.Items[CurrentHT - HTITEM].OnMouseEnter(FTitleBar.Items[CurrentHT - HTITEM]);

          FTitleBar.Items[CurrentHT - HTITEM].State := 1;
          if SkinData.SkinManager.Effects.AllowAnimation then
            StartHintTimer(FTitleBar.Items[CurrentHT - HTITEM]);
        end;
    end;
    if Repaint then begin
      RepaintButton(CurrentHT);
      case CurrentHT of
        HTITEM..HTITEM + MaxByte:
          if Assigned(FTitleBar) and (FTitleBar.Items[CurrentHT - HTITEM].State <> 1) then begin
            FTitleBar.Items[CurrentHT - HTITEM].State := 0;
            UpdateSkinCaption(Self); // Title repainting under the Layered wnd
            FTitleBar.Items[CurrentHT - HTITEM].State := 1;
          end;
      end;
    end;
  end;
end;


procedure TsSkinProvider.SetPressedHT(const i: integer);
begin
  if (CurrentHT <> i) and (CurrentHT <> 0) then begin
    case CurrentHT of
      HTCLOSE:      ButtonClose.State := 0;
      HTMAXBUTTON:  ButtonMax.State   := 0;
      HTMINBUTTON:  ButtonMin.State   := 0;
      HTHELP:       ButtonHelp.State  := 0;
      HTCHILDCLOSE: MDIClose.State    := 0;
      HTCHILDMAX:   MDIMax.State      := 0;
      HTCHILDMIN:   MDIMin.State      := 0
      else
        if BetWeen(CurrentHT, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin
          TitleButtons.Items[CurrentHT - HTUDBTN].Data.State := 0;
          HideHint(TitleButtons.Items[CurrentHT - HTUDBTN]);
        end
        else
          if BetWeen(CurrentHT, HTITEM, HTITEM + MaxByte) then
            if Assigned(FTitleBar) then begin
              FTitleBar.Items[CurrentHT - HTITEM].State := 0;
              HideHintWnd(FTitleBar.Items[CurrentHT - HTITEM]);
            end;
    end;
    RepaintButton(CurrentHT);
  end;
  CurrentHT := i;
  case CurrentHT of
    HTCLOSE:
      if (SystemMenu.EnabledClose) then
        ButtonClose.State := 2
      else begin
        CurrentHT := 0;
        Exit;
      end;

    HTMAXBUTTON:
      if SystemMenu.EnabledMax or ((Form.WindowState = wsMaximized) and SystemMenu.EnabledRestore) then
        ButtonMax.State := 2
      else begin
        CurrentHT := 0;
        Exit;
      end;

    HTMINBUTTON:
      ButtonMin.State := 2;

    HTHELP:
      ButtonHelp.State := 2;

    HTCHILDCLOSE:
      MDIClose.State := 2;

    HTCHILDMAX:
      if SystemMenu.EnabledMax then
        MDIMax.State := 2;

    HTCHILDMIN:
      MDIMin.State := 2

    else
      if BetWeen(CurrentHT, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin
        TitleButtons.Items[CurrentHT - HTUDBTN].Data.State := 2;
        HideHint(TitleButtons.Items[CurrentHT - HTUDBTN]);
      end
      else
        if BetWeen(CurrentHT, HTITEM, HTITEM + MaxByte) then
          if Assigned(FTitleBar) then begin
            FTitleBar.Items[CurrentHT - HTITEM].State := 2;
            HideHintWnd(FTitleBar.Items[CurrentHT - HTITEM]);
            if FTitleBar.Items[CurrentHT - HTITEM].Style = bsTab then begin
              if FTitleBar.Items[CurrentHT - HTITEM].Timer <> nil then
                FreeAndNil(FTitleBar.Items[CurrentHT - HTITEM].Timer);

              CurrentHT := -1;
              Exit; // No animation
            end;
          end;
  end;
  biClicked := True;
  RepaintButton(CurrentHT);
end;


type
  TacAccessTitleBar = class(TsTitleBar);


function TsSkinProvider.PaintAll: boolean;
var
  s: acString;
  BG: TacBGInfo;
  acM: TMessage;
  CI: TCacheInfo;
  Mask: TsMaskData;
  ts, tsAdded: TSize;
  sMan: TsSkinManager;
  CurrentItem: TMenuItem;
  SavedCanvas, SavedDC: hdc;
  r, rForm, rC, aShadowSize: TRect;
  Iconic, exBorders, ShowCaption: boolean;
  x, w, h, y, fHeight, fWidth, fCaptHeight, iDrawMode, iDrawState: integer;
  iDiff, ItemProcessed, ChangedIndex, VisIndex, Index, i, sbw, TitleIndex, CY, maxCY: integer;
{$IFNDEF FPC}
  function ProcessMerged(CurrentIndex: integer): boolean;
  var
    i, j, VisJ, w: integer;
    LocalItem: TMenuItem;
  begin
    Result := False;
    if Assigned(Form.ActiveMDIChild) and Assigned(Form.ActiveMDIChild.Menu) then
      for i := ItemProcessed to Form.ActiveMDIChild.Menu.Items.Count - 1 do
        if Form.ActiveMDIChild.Menu.Items[i].Visible then begin
          LocalItem := Form.ActiveMDIChild.Menu.Items[i];
          // If MDI form and included other
          if (LocalItem.GroupIndex > ChangedIndex) and (LocalItem.GroupIndex <= CurrentIndex) then begin
            if not Assigned(LocalItem.OnMeasureItem) or not Assigned(LocalItem.OnAdvancedDrawItem) then
              Continue;

            Result := (LocalItem.GroupIndex >= CurrentIndex);
            ChangedIndex := LocalItem.GroupIndex;
            j := i;
            VisJ := j;
            while (j < Form.ActiveMDIChild.Menu.Items.Count) do begin
              LocalItem := Form.ActiveMDIChild.Menu.Items[j];
              if (LocalItem.GroupIndex > CurrentIndex) and (Index <= Form.Menu.Items.Count - 1) then
                Exit;

              GetMenuItemRect(Form.ActiveMDIChild.Handle, Form.ActiveMDIChild.Menu.Handle, VisJ, R);
              w := WidthOf(R);
              ChangedIndex := LocalItem.GroupIndex;
              if x + w > Form.Width - 2 * sbw - 2 * TForm(Form).BorderWidth then begin
                x := sbw + aShadowSize.Left;
                inc(y, MenuHeight);
              end;
              r := Rect(x, y, x + w, y + MenuHeight);
              LocalItem.OnAdvancedDrawItem(LocalItem, FCommonData.FCacheBmp.Canvas, R, []);
              x := r.Right;
              ItemProcessed := i + 1;
              inc(j);
              inc(VisIndex);
              inc(VisJ);
            end;
          end;
        end;
  end;
{$ENDIF}
  procedure PaintTitle(CaptWidth: integer);
  begin
    if (CaptionHeight <> 0) and FDrawNonClientArea then begin // Paint title
      TitleIndex := FTitleSkinIndex;
      if sMan.IsValidSkinIndex(TitleIndex) and not exBorders then
        if Iconic then
          PaintItem(TitleIndex, ci, True, min(integer(FormActive), FCommonData.SkinManager.gd[TitleIndex].States - 1), Rect(rForm.Left, rForm.Top, rForm.Right, rForm.Bottom), MkPoint, FCommonData.FCacheBmp, sMan)
        else
          PaintItem(TitleIndex, ci, True, min(integer(FormActive), FCommonData.SkinManager.gd[TitleIndex].States - 1), Rect(rForm.Left, rForm.Top, rForm.Right, fCaptHeight), MkPoint, FCommonData.FCacheBmp, sMan);

      if (FormHeader.AdditionalHeight > 0) and (FHeaderIndex >= 0) then
        PaintItem(FHeaderIndex, ci, True, integer(FormActive), Rect(rForm.Left, rForm.Top, rForm.Right, fCaptHeight + FormHeader.AdditionalHeight), MkPoint, FCommonData.FCacheBmp, sMan);

      DrawAppIcon(Self); // Draw app icon
      if (SysButtonsCount > 0) then begin // Paint title toolbar if defined in skin
        i := sMan.GetMaskIndex(FCommonData.SkinIndex, s_NormalTitleBar);
        if sMan.IsValidImgIndex(i) then
          DrawSkinRect(FCommonData.FCacheBmp, Rect(CaptWidth - BarWidth(i), 0, FCommonData.FCacheBmp.Width, h - CY),
                       EmptyCI, sMan.ma[i], iDrawState, True);
      end;
    end;
  end;

  procedure PaintText;
  const
    iAddedIndent = 4;
  var
    cRect: TRect;
    Flags: Cardinal;
    sIndex, i: integer;
    SavedTitle: TBitmap;
    TextAlign: TAlignment;
  begin
    if (CaptionHeight <> 0) and FDrawNonClientArea then begin // Out the title text
      // Receive a caption rect
      if Assigned(FTitleBar) then begin
        R.Left  := FTitleBar.BarRect.Left  + FTitleBar.LeftWidth + 8;
        R.Right := FTitleBar.BarRect.Right - FTitleBar.RightWidth - 8;
      end
      else begin
        R.Left := SysBorderWidth(Form.Handle, BorderForm) + integer(IconVisible) * WidthOf(FIconRect) + 4 +
                  sMan.CommonSkinData.BILeftMargin + aShadowSize.Left + integer(FCaptionSkinIndex > -1) * 2;

        R.Right := FCommonData.FCacheBmp.Width - TitleBtnsWidth - 12 - aShadowSize.Right;
      end;
      R.Bottom := fCaptHeight;
      if IsZoomed(Form.Handle) then
        R.Top := iff(BorderForm <> nil, aShadowSize.Top + 1, 3 {SysBorderWidth(Form.Handle, BorderForm, False) div 2 + 1;})
      else
        R.Top := aShadowSize.Top + 2;
      // Adding a vertical offset
      if (BorderForm <> nil){ExBorders} then begin
        OffsetRect(R, 0, sMan.CommonSkinData.ExCenterOffs);
        if (Form.WindowState = wsMaximized) and
            (sMan.CommonSkinData.ExMaxHeight <> 0) and
             (sMan.CommonSkinData.ExTitleHeight <> sMan.CommonSkinData.ExMaxHeight) then

          OffsetRect(R, 0, (sMan.CommonSkinData.ExTitleHeight - sMan.CommonSkinData.ExMaxHeight) div 2)
      end;
      if Assigned(FTitleBar) then
        ShowCaption := FTitleBar.ShowCaption
      else
        ShowCaption := AddedTitle.ShowMainCaption;

      if not IsRectEmpty(R) then begin
        // Receive a size of the added text
        if (FAddedTitle.Text <> '') then begin
          FCommonData.FCacheBmp.Canvas.Font.Assign(FAddedTitle.FFont);
          acGetTextExtent(FCommonData.FCacheBmp.Canvas.Handle, FAddedTitle.Text, tsAdded);
        end
        else
          tsAdded := MkSize(0, 0);

        if ShowCaption then begin
          // Receive a size of the caption text
          FCommonData.FCacheBmp.Canvas.Font.Handle := acGetTitleFont;
          FCommonData.FCacheBmp.Canvas.Font.Height := GetCaptionFontSize;
          if ac_UseSysCharSet then
            FCommonData.FCacheBmp.Canvas.Font.Charset := GetDefFontCharSet
          else
            FCommonData.FCacheBmp.Canvas.Font.Charset := Form.Font.Charset;

          s := {$IFDEF TNTUNICODE} WideString(GetWndText(Form.Handle)) {$ELSE} Form.Caption {$ENDIF};
          acGetTextExtent(FCommonData.FCacheBmp.Canvas.Handle, s, ts);
        end
        else begin
          ts := tsAdded;
          tsAdded := MkSize;
        end;
        // Correct a rect with received height of text
        maxCY := max(ts.cy, tsAdded.cy);
        if FTitleBar = nil then
          R.Top := VCenter - maxCY div 2
        else
          R.Top := TacAccessTitleBar(FTitleBar).FBarVCenter - maxCY div 2;

        R.Bottom := R.Top + maxCY;
        TextAlign := CaptionAlignment;
        if Form.UseRightToLeftAlignment then
          if TextAlign = Classes.taLeftJustify then
            TextAlign := Classes.taRightJustify
          else
            if TextAlign = Classes.taRightJustify then
              TextAlign := Classes.taLeftJustify;

        case TextAlign of
          Classes.taCenter: begin
            R.Left := max(R.Left, R.Left + (WidthOf(R) - ts.cx - tsAdded.cx - iAddedIndent) div 2);
            R.Right := min(R.Left + ts.cx, R.Right);
          end;
          Classes.taRightJustify: begin
            i := ts.cx + tsAdded.cx + iAddedIndent;
            if i < WidthOf(R) then
              R.Left := R.Right - i;
          end;
        end;
        Flags := DT_END_ELLIPSIS or DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX or iff(Form.UseRightToLeftReading, DT_RTLREADING, DT_LEFT);
        if ShowCaption then begin
          cRect := R;
          acDrawText(FCommonData.FCacheBmp.Canvas.Handle, s, cRect, Flags or DT_CALCRECT);
          if FCaptionSkinIndex > -1 then begin // If Caption panel must be drawn
            InflateRect(cRect, 4, 2);
            SavedTitle := CreateBmp32(fWidth, fCaptHeight);
            BitBlt(SavedTitle.Canvas.Handle, 0, 0, fWidth, fCaptHeight, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
            CI := MakeCacheInfo(SavedTitle, cRect.Left, cRect.Top);
            PaintItem(FCaptionSkinIndex, CI, True, min(integer(FormActive),
                      FCommonData.SkinManager.gd[FCaptionSkinIndex].States - 1), cRect, MkPoint, FCommonData.FCacheBmp, sMan);

            FreeAndNil(SavedTitle);
            sIndex := FCaptionSkinIndex;
          end
          else
            sIndex := FTitleSkinIndex;

          if (sIndex >= 0) then begin
            // Draw a text glowing
            if not x64woAero or (SkinData.SkinManager.CommonSkinData.Version > 7.50) then begin
              i := sMan.gd[sIndex].Props[integer(FormActive)].GlowSize;
              if i <> 0 then
                if FormActive then
                  acDrawGlowForText(FCommonData.FCacheBmp, PacChar(s), R, Flags, BF_RECT, i, sMan.gd[sIndex].Props[1].GlowColor, FGlow1)
                else
                  acDrawGlowForText(FCommonData.FCacheBmp, PacChar(s), R, Flags, BF_RECT, i, sMan.gd[sIndex].Props[0].GlowColor, FGlow2);
            end;
            // Text output
            FCommonData.FCacheBmp.Canvas.Brush.Style := bsClear;
            if (BorderForm = nil) then
              acWriteTextEx(FCommonData.FCacheBmp.Canvas, PacChar(s), Form.Enabled, R, Flags, sIndex, FormActive, sMan)
            else
              WriteText32(FCommonData.FCacheBmp, PacChar(s), Form.Enabled, R, Flags, sIndex, FormActive, sMan);
          end;
          R.Left := cRect.Right;
        end
        else
          tsAdded := ts;
        // Additional text
        if (FAddedTitle.Text <> '') then begin
          inc(R.Left, iAddedIndent);
          R.Right := R.Left + tsAdded.cx + 4;
          if (R.Left + 8 < R.Right) and (FTitleSkinIndex >= 0) then begin
            FCommonData.FCacheBmp.Canvas.Font.Assign(FAddedTitle.Font);
            if (FAddedTitle.Font.Color = clNone) or (FAddedTitle.Font.Color = clWindowText) then
              FCommonData.FCacheBmp.Canvas.Font.Color := sMan.gd[FTitleSkinIndex].Props[integer(FormActive)].FontColor.Color
            else
              if not FormActive then
                FCommonData.FCacheBmp.Canvas.Font.Color := MixColors(sMan.gd[FTitleSkinIndex].Props[0].FontColor.Color, FAddedTitle.Font.Color, 0.5);

            if (BorderForm = nil) then begin
              FCommonData.FCacheBmp.Canvas.Brush.Style := bsClear;
              acDrawText(FCommonData.FCacheBmp.Canvas.Handle, PacChar(FAddedTitle.Text), R, Flags)
            end
            else
              WriteText32(FCommonData.FCacheBmp, PacChar(FAddedTitle.Text), True, R, Flags, -1, FormActive, sMan);
          end;
        end;
      end;
    end;
  end;

begin
  Result := True;
  if (csCreating in Form.ControlState) or (FormState and FS_BLENDMOVING = FS_BLENDMOVING) or
        (FormState and FS_ANIMCLOSING = FS_ANIMCLOSING) or (SkinData.SkinIndex < 0) then
    Exit;
    
  Iconic := IsIconic(Form.Handle) and (Application.MainForm <> Form);
  CY := SysBorderHeight(Form.Handle, BorderForm, False);
  h := 2 * CY + CaptionHeight;
  aShadowSize := ShadowSize;
  fCaptHeight := CaptionHeight + SysBorderHeight(Form.Handle, BorderForm, False) + aShadowSize.Top;
  if Iconic then
    fHeight := fCaptHeight - aShadowSize.Top + 2
  else
    fHeight := Form.Height;

  if BorderForm <> nil then begin
    iDiff := DiffBorder(Self.BorderForm);
    fHeight := fHeight + iDiff + DiffTitle(Self.BorderForm) + aShadowSize.Top + aShadowSize.Bottom;
  end
  else
    iDiff := 0;

  fWidth := CaptionWidth;
  sMan := SkinData.SkinManager;
  iDrawState := min(integer(FormActive), sMan.gd[FCommonData.SkinIndex].States - 1);
  exBorders := (BorderForm <> nil) and (sMan.CommonSkinData.ExDrawMode = 1);
  with FCommonData do
    if FCacheBmp = nil then begin // If first loading
      FCacheBmp := CreateBmp32(fWidth, fHeight);
      FCacheBmp.Canvas.Handle;
      UpdateSkinState(FCommonData, False);
      acM := MakeMessage(SM_ALPHACMD, MakeWParam(0, AC_GETSKINSTATE), 1, 0); // Initialization of all child states
      if not (csLoading in Form.ComponentState) then
        AlphaBroadCast(Form, acM);
    end;

  if (Form.FormStyle = fsMDIForm) and (Form.ActiveMDIChild <> nil) and (Form.ActiveMDIChild.WindowState = wsMaximized) then
    if (fsShowing in Form.ActiveMDIChild.FormState) and MenuChanged then
      Exit;

  ItemProcessed := 0;
  sbw := SysBorderWidth(Form.Handle, BorderForm);
  rForm := Rect(aShadowSize.Left, aShadowSize.Top, fWidth - aShadowSize.Right, fHeight - aShadowSize.Bottom);
  Result := True;
  if FCommonData.BGChanged then begin
    CalcItems;
//    RgnChanged := True;
    ci.Ready := False;
    FCommonData.FCacheBmp.Width  := fWidth;
    FCommonData.FCacheBmp.Height := fHeight;
    if sMan.IsValidSkinIndex(FCommonData.SkinIndex) then begin
      if Form.Parent = nil then
        CI := EmptyCI
      else begin
        BG.DrawDC := 0;
        BG.Offset := MkPoint;
        BG.PleaseDraw := False;
        GetBGInfo(@BG, Form.Parent, False);
        if BG.BgType = btNotReady then begin
          FCommonData.FUpdating := True;
          Result := False;
          Exit;
        end;
        CI := BGInfoToCI(@BG);
      end;
      // Paint the form with borders
      if (SkinData.CtrlSkinState and ACS_FAST <> ACS_FAST) then begin // If cache is required
        if HaveBorder(Self) or (Form.Parent <> nil) and not exBorders then
          PaintItem(FCommonData, CI, False, iDrawState, rForm, MkPoint(Form), FCommonData.FCacheBmp, Form.Parent <> nil)
        else begin
          PaintItemBG(FCommonData.SkinIndex, CI, iDrawState, rForm, MkPoint(Form), FCommonData.FCacheBmp, sMan);
          with sMan.gd[FCommonData.SkinIndex] do begin
            if sMan.IsValidImgIndex(ImgTL) then
              DrawSkinGlyph(FCommonData.FCacheBmp, rForm.TopLeft, iDrawState, 1, sMan.ma[ImgTL], MakeCacheInfo(FCommonData.FCacheBmp));

            if sMan.IsValidImgIndex(ImgTR) then
              DrawSkinGlyph(FCommonData.FCacheBmp, Point(rForm.Right - WidthOfImage(sMan.ma[ImgTR]), rForm.Top), iDrawState, 1, sMan.ma[ImgTR], MakeCacheInfo(FCommonData.FCacheBmp));

            if sMan.IsValidImgIndex(ImgBL) then
              DrawSkinGlyph(FCommonData.FCacheBmp, Point(0, rForm.Bottom - HeightOfImage(sMan.ma[ImgBL])), iDrawState, 1, sMan.ma[ImgBL], MakeCacheInfo(FCommonData.FCacheBmp));

            if sMan.IsValidImgIndex(ImgBR) then
              DrawSkinGlyph(FCommonData.FCacheBmp, Point(rForm.Right - WidthOfImage(sMan.ma[ImgBR]), rForm.Bottom - HeightOfImage(sMan.ma[ImgBR])), iDrawState, 1, sMan.ma[ImgBR], MakeCacheInfo(FCommonData.FCacheBmp));
          end;
        end;
      end
      else
        if (BorderForm = nil) then begin // If not extended borders
          FillDC(FCommonData.FCacheBmp.Canvas.Handle, MkRect(FCommonData.FCacheBmp.Width, CaptionHeight + BorderWidth + LinesCount * MenuHeight + 1), FormColor);
          PaintBorderFast(FCommonData.FCacheBmp.Canvas.Handle, rForm, BorderWidth, FCommonData, iDrawState);
        end
        else begin
          FillRect32(FCommonData.FCacheBmp, Rect(aShadowSize.Left, aShadowSize.Top, FCommonData.FCacheBmp.Width - aShadowSize.Right, FCommonData.FCacheBmp.Height - aShadowSize.Bottom), FormColor);
          if not exBorders and (FCommonData.BorderIndex >= 0) then
            PaintBorderFast(FCommonData.FCacheBmp.Canvas.Handle, rForm, BorderWidth, FCommonData, iDrawState);
        end;

      ci := MakeCacheInfo(FCommonData.FCacheBmp, OffsetX, OffsetY); // Prepare cache info
      if not exBorders then
        PaintTitle(fWidth);

{$IFNDEF FPC}
      // Menu line drawing
      if IsMenuVisible(Self) and MenuPresent and (MenuHeight > 0) and DrawNonClientArea and sMan.SkinnedPopups then begin
        if FMenuLineSkin <> '' then
          i := sMan.GetSkinIndex(FMenuLineSkin)
        else
          i := -1;

        if i < 0 then
          i := sMan.ConstData.Sections[ssMenuLine]; // Paint menu bar

        if sMan.IsValidSkinIndex(i) then
          PaintItem(i, ci, True, iDrawState,
                     Rect(aShadowSize.Left, fCaptHeight, FCommonData.FCacheBmp.Width - aShadowSize.Right, fCaptHeight + LinesCount * MenuHeight + 1),
                    Point(aShadowSize.Left, fCaptHeight), FCommonData.FCacheBmp, sMan);

        MenuLineBmp.Width  := fWidth - aShadowSize.Left - aShadowSize.Right; // Store bg for Menu line
        MenuLineBmp.Height := LinesCount * MenuHeight + 1;
        y := OffsetY - LinesCount * MenuHeight - Form.BorderWidth - 1;
        BitBlt(MenuLineBmp.Canvas.Handle, 0, 0, MenuLineBmp.Width, MenuLineBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, OffsetX - Form.BorderWidth, y, SRCCOPY);
        // Draw maximized child form system icon on menuline
        if ChildIconPresent and (MDISkinProvider = Self) then
          if Form.ActiveMDIChild.Icon.Handle <> 0 then
            DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, sbw + 1 + aShadowSize.Left, fCaptHeight + 1, Form.ActiveMDIChild.Icon.Handle, MenuHeight - 2, MenuHeight - 2, 0, 0, DI_NORMAL)
          else
            if AppIcon <> nil then
              DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, sbw + 1 + aShadowSize.Left, fCaptHeight + 1, AppIcon.Handle, MenuHeight - 2, MenuHeight - 2, 0, 0, DI_NORMAL)
            else
              DrawIconEx(FCommonData.FCacheBmp.Canvas.Handle, sbw + 1 + aShadowSize.Left, fCaptHeight + 1, LoadIcon(0, IDI_APPLICATION), MenuHeight - 2, MenuHeight - 2, 0, 0, DI_NORMAL);

        // << Menu items >> //
        x := sbw + aShadowSize.Left;
        y := fCaptHeight;
        ChangedIndex := -1;
        Index := 0;
        VisIndex := 0;
        TryInitMenu;
        while Index < Form.Menu.Items.Count do begin
          if (x = sbw + aShadowSize.Left) and (MDISkinProvider = Self) and ChildIconPresent then begin // Skip Item with child icon
            GetMenuItemRect(Form.Handle, Form.Menu.Handle, 0, R);
            inc(x, WidthOf(R));
            inc(VisIndex);
            Continue;
          end;
          CurrentItem := Form.Menu.Items[Index];
          if ((CurrentItem.GroupIndex = ChangedIndex) or ProcessMerged(CurrentItem.GroupIndex)) then begin
            inc(Index);
            Continue;
          end
          else begin
            if not CurrentItem.Visible then begin
              inc(Index);
              Continue;
            end;
            if not Assigned(CurrentItem.OnMeasureItem) or not Assigned(CurrentItem.OnAdvancedDrawItem) then
              if not CurrentItem.GetParentMenu.OwnerDraw then begin
                MenusInitialized := False;
                TryInitMenu;
              end
              else
                sMan.SkinableMenus.InitMenuLine(Form.Menu, True);

            GetMenuItemRect(Form.Handle, Form.Menu.Handle, VisIndex, R);
            w := WidthOf(R);
            OffsetRect(R, -Form.Left + iDiff + aShadowSize.Left, -Form.Top + DiffTitle(Self.BorderForm) + aShadowSize.Top + 4 * integer(FSysExHeight));
            if Assigned(CurrentItem.OnAdvancedDrawItem) then
              CurrentItem.OnAdvancedDrawItem(CurrentItem, FCommonData.FCacheBmp.Canvas, R, [odNoAccel, odReserved1]);

            inc(x, w);
            inc(Index);
            inc(VisIndex);
          end;
        end;
        ProcessMerged(MaxInt);
      end; // End menu drawing
{$ENDIF}
      if not exBorders and (BorderForm <> nil) then
        PaintText;

      // Paint MDIArea
      if (Form.FormStyle = fsMDIForm) and Assigned(MDIForm) then begin
        rC.Left := BorderWidth + GetAlignShift(Form, alLeft) + aShadowSize.Left;
        rC.Top := fCaptHeight + LinesCount * MenuHeight * integer(MenuPresent) + Form.BorderWidth + GetAlignShift(Form, alTop);

        if Menuheight <> 0 then
          inc(rC.Top);

        rC.Right  := FCommonData.FCacheBmp.Width  - BorderWidth - GetAlignShift(Form, alRight)  - aShadowSize.Right;
        rC.Bottom := FCommonData.FCacheBmp.Height - BorderWidth - GetAlignShift(Form, alBottom) - aShadowSize.Bottom;
        CI := MakeCacheInfo(FCommonData.FCacheBmp);
        i := sMan.GetSkinIndex(s_MDIArea);
        PaintItem(i, CI, False, 0, Rect(rC.Left, rC.Top, rC.Right, rC.Bottom), rC.TopLeft, FCommonData.FCacheBmp.Canvas.Handle, sMan);
      end;

      if (BorderForm <> nil) then
        with sMan do begin // Painting of form shadow if required
          if FormActive then
            BorderForm.ShadowTemplate := sMan.ShdaTemplate
          else
            BorderForm.ShadowTemplate := sMan.ShdiTemplate;

          if BorderForm.ShadowTemplate <> nil then begin
            i := BorderForm.CaptionHeight;
            if exBorders then begin
              ChangedIndex := sMan.ConstData.ExBorder; // Index of extended border in skin
              iDrawMode := sMan.ma[ChangedIndex].DrawMode and BDM_STRETCH;
              PaintControlByTemplate(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, MkRect(fWidth, fHeight),
                  MkRect(BorderForm.ShadowTemplate),
                  Rect(ma[ChangedIndex].WL, min(ma[ChangedIndex].WT, CaptionHeight + (FCommonData.FCacheBmp.Height - CaptionHeight) div 2),
                       ma[ChangedIndex].WR, min(ma[ChangedIndex].WB, (FCommonData.FCacheBmp.Height - CaptionHeight) div 2)),

                  Rect(aShadowSize.Left + BorderWidth, aShadowSize.Top + i, aShadowSize.Right + BorderWidth, aShadowSize.Bottom + BorderWidth),//!!! + 2),
                  Rect(iDrawMode, iDrawMode, iDrawMode, iDrawMode), False, False);
              PaintTitle(fWidth);
              PaintText;
            end
            else begin
              if sMan.ConstData.ExBorder >= 0 then begin
                Mask := sMan.ma[sMan.ConstData.ExBorder];
                PaintControlByTemplate(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, MkRect(fWidth, fHeight),
                    MkRect(BorderForm.ShadowTemplate), Rect(Mask.WL, Mask.WT, Mask.WR, Mask.WB), aShadowSize, // Offsets to content
                    Rect(Mask.DrawMode, Mask.DrawMode, Mask.DrawMode, Mask.DrawMode), Mask.DrawMode <> 0, False)
              end
              else begin // If internal shadows
                sbw := (BorderForm.ShadowTemplate.Width - 1) div 2;
                PaintControlByTemplate(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, MkRect(fWidth, fHeight),
                    MkRect(BorderForm.ShadowTemplate),
                    Rect(sbw, sbw, sbw, sbw),
                    aShadowSize, Rect(1, 1, 1, 1), False, False); // For internal shadows - stretch only allowed
              end;
              // Draw shadows in corners
              if sMan.IsValidImgIndex(TitleIndex) then
                TitleIndex := sMan.gd[TitleIndex].BorderIndex;

              if sMan.IsValidImgIndex(TitleIndex) then begin // If title mask exists
                x := sMan.MaskWidthRight(TitleIndex);
                // LeftTop
                R := Rect(aShadowSize.Left, aShadowSize.Top, aShadowSize.Left + sMan.MaskWidthLeft(TitleIndex),
                          aShadowSize.Top + sMan.MaskWidthTop(TitleIndex));
                FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R, aShadowSize.TopLeft, TitleIndex, sMan, HTTOPLEFT);
                // RightTop
                R := Rect(FCommonData.FCacheBmp.Width - aShadowSize.Right - x, aShadowSize.Top, FCommonData.FCacheBmp.Width - aShadowSize.Right,
                          aShadowSize.Top + sMan.MaskWidthTop(TitleIndex));
                FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R,
                  Point(BorderForm.ShadowTemplate.Width - aShadowSize.Right - x, aShadowSize.Top), TitleIndex, sMan, HTTOPRIGHT);
              end
              else
                if (FCommonData.BorderIndex >= 0) and (FCommonData.BorderIndex < Length(sMan.ma)) then begin
                  x := sMan.MaskWidthRight(FCommonData.BorderIndex);
                  // LeftTop
                  R := Rect(aShadowSize.Left, aShadowSize.Top, aShadowSize.Left + min(sMan.MaskWidthLeft(FCommonData.BorderIndex), 8), aShadowSize.Top + min(sMan.MaskWidthTop(FCommonData.BorderIndex), 8));
                  FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R, aShadowSize.TopLeft, FCommonData.BorderIndex, sMan, HTTOPLEFT);
                  // RightTop
                  R := Rect(FCommonData.FCacheBmp.Width - aShadowSize.Right - x,  aShadowSize.Top, FCommonData.FCacheBmp.Width - aShadowSize.Right,
                            aShadowSize.Top + sMan.MaskWidthTop(FCommonData.BorderIndex));
                  FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R,
                                    Point(max(0, BorderForm.ShadowTemplate.Width - aShadowSize.Right - x), aShadowSize.Top), FCommonData.BorderIndex, sMan, HTTOPRIGHT);
                end;

              if (FCommonData.BorderIndex >= 0) and (FCommonData.BorderIndex < Length(sMan.ma)) then begin
                y := sMan.MaskWidthBottom(FCommonData.BorderIndex);
                x := sMan.MaskWidthRight(FCommonData.BorderIndex);
                // LeftBottom
                R := Rect(aShadowSize.Left, FCommonData.FCacheBmp.Height - aShadowSize.Bottom - y, aShadowSize.Left + sMan.MaskWidthLeft(FCommonData.BorderIndex),
                          FCommonData.FCacheBmp.Height - aShadowSize.Bottom);
                FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R, Point(aShadowSize.Left, max(0, BorderForm.ShadowTemplate.Height - aShadowSize.Bottom - y)), FCommonData.BorderIndex, sMan, HTBOTTOMLEFT);
                // RightBottom
                R := Rect(FCommonData.FCacheBmp.Width - aShadowSize.Right - x, FCommonData.FCacheBmp.Height - aShadowSize.Bottom - y,
                          FCommonData.FCacheBmp.Width - aShadowSize.Right,     FCommonData.FCacheBmp.Height - aShadowSize.Bottom);
                FillTransPixels32(FCommonData.FCacheBmp, BorderForm.ShadowTemplate, R,
                  Point(max(0, BorderForm.ShadowTemplate.Width - aShadowSize.Right - x), max(0, BorderForm.ShadowTemplate.Height - aShadowSize.Bottom - y)), FCommonData.BorderIndex, sMan, HTBOTTOMRIGHT);
              end;
            end;
          end;
        end;

      if BorderForm = nil then
        PaintText;

      if IsGripVisible(Self) and IsCached(FCommonData) then begin
        FCommonData.BGChanged := False;
        if FCommonData.SkinManager.IsValidImgIndex(FCommonData.SkinManager.ConstData.GripRightBottom) then
          DrawSkinGlyph(FCommonData.FCacheBmp, RBGripPoint(FCommonData.SkinManager.ConstData.GripRightBottom), 0, 1, FCommonData.SkinManager.ma[FCommonData.SkinManager.ConstData.GripRightBottom], MakeCacheInfo(FCommonData.FCacheBmp));
      end;

      if (CaptionHeight <> 0) and FDrawNonClientArea then begin
        SaveBGForBtns(fWidth, True);
        PaintTitleContent(fWidth);
      end;
    end;
    MenuChanged := False;
    FCommonData.BGChanged := False;
    if Assigned(Form.OnPaint) and IsCached(SkinData) then begin
      SavedCanvas := Form.Canvas.Handle;
      Form.Canvas.Handle := SkinData.FCacheBmp.Canvas.Handle;
      SavedDC := SaveDC(Form.Canvas.Handle);
      MoveWindowOrg(Form.Canvas.Handle, OffsetX, OffsetY);
      Form.Canvas.Lock;
      Form.OnPaint(Form);
      Form.Canvas.Unlock;
      RestoreDC(Form.Canvas.Handle, SavedDC);
      Form.Canvas.Handle := SavedCanvas;
    end;
    SkinData.PaintOuterEffects(Form, Point(OffsetX, OffsetY));
    FirstInitialized := True;
    FCommonData.BGChanged := False;
  end;
  FCommonData.Updating := False;
end;


function TsSkinProvider.FormLeftTop: TPoint;
var
  p: TPoint;
  R: TRect;
begin
  if TForm(Form).FormStyle = fsMDIChild then begin
    p := Form.ClientToScreen(MkPoint);
    Result.x := p.x - SysBorderWidth (Form.Handle, BorderForm);
    Result.y := p.y - SysBorderHeight(Form.Handle, BorderForm) - integer(not IsIconic(Form.Handle)) * CaptionHeight;
  end
  else begin
    GetWindowRect(Form.Handle, R);
    Result.x := R.Left;
    Result.y := R.Top;
  end;
end;


procedure TsSkinProvider.DropSysMenu(x, y: integer);
var
  mi: TMenuitem;
  SysMenu: HMENU;
  SelItem: DWORD;

  procedure EnableCommandItem(uIDEnableItem: UINT; Enable: Boolean);
  begin
    EnableMenuItem(SysMenu, uIDEnableItem, MF_BYCOMMAND or iff(Enable, MF_ENABLED, MF_GRAYED or MF_DISABLED));
  end;

begin
  if SystemMenu = nil then
    PrepareForm;

  if (SystemMenu = nil) { Skin can't be loaded} {$IFDEF D2005}or (Application.ActiveFormHandle <> Form.Handle) {$ENDIF} then
    Exit;

{$IFNDEF FPC}
  if SkinData.SkinManager.SkinnedPopups then begin
    SystemMenu.UpdateItems(SystemMenu.ExtItemsCount > 0);
    if FMakeSkinMenu and (SystemMenu.Items.Count > 0) then begin
      if SystemMenu.Items[0].Name = s_SkinSelectItemName then begin
        while SystemMenu.Items[0].Count > 0 do begin
          mi := SystemMenu.Items[0].Items[0];
          SystemMenu.Items[0].Delete(0);
          FreeAndNil(mi);
        end;
        mi := SystemMenu.Items[0];
        SystemMenu.Items.Delete(0);
        FreeAndNil(mi);
      end;
      SystemMenu.MakeSkinItems;
    end;
    SkinData.SkinManager.SkinableMenus.HookPopupMenu(SystemMenu, True);
    SystemMenu.WindowHandle := Form.Handle;
    SystemMenu.Popup(x, y);
    SystemMenu.WindowHandle := 0;
  end
  else
{$ENDIF}
  begin
    // Prevent of painting by system (white line)
    SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_VISIBLE);
    //get a modifiable copy of the original sysmenu
    SysMenu := GetSystemMenu(Form.Handle, False);
    //read and emulate states from skin SystemMenu
    with SystemMenu do begin
      EnableCommandItem(SC_RESTORE , VisibleRestore and EnabledRestore);
      EnableCommandItem(SC_MOVE    , EnabledMove    and not IsIconic(Form.Handle));
      EnableCommandItem(SC_SIZE    , VisibleSize    and EnabledSize and (Form.WindowState = wsNormal));
      EnableCommandItem(SC_MINIMIZE, VisibleMin     and EnabledMin);
      EnableCommandItem(SC_MAXIMIZE, VisibleMax     and EnabledMax);
      EnableCommandItem(SC_CLOSE   , VisibleClose   and EnabledClose);
    end;
    SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_VISIBLE);
    //Get menuselection from menu, do not send it on automatically
    SelItem := LongWord(TrackPopupMenu(SysMenu, TPM_LEFTBUTTON or TPM_RIGHTBUTTON or TPM_RETURNCMD, x, y, 0, Form.Handle, nil));
    //If the sysmenu tracking resulted in a selection, post it as a WM_SYSCOMMAND
    if SelItem > 0 then
      PostMessage(Form.Handle, WM_SYSCOMMAND, SelItem, 0);
  end;
end;


function TsSkinProvider.CursorToPoint(const x, y: integer): TPoint;
begin
  Result := FormLeftTop;
  Result.x := x - Result.x;
  Result.y := y - Result.y;
end;


function TsSkinProvider.MenuPresent: boolean;
var
 i, VisibleItems: integer;
begin
  Result := False;
  if (Form.BorderStyle <> bsDialog) and (Form.FormStyle <> fsMDIChild) then
    if (Form.Menu <> nil) {$IFNDEF FPC}and not Form.Menu.AutoMerge{$ENDIF} then begin
      VisibleItems := 0;
      for i := 0 to Form.Menu.Items.Count - 1 do
        if Form.Menu.Items[i].Visible then begin
          inc(VisibleItems);
          Break;
        end;

      if (Form.FormStyle = fsMDIForm) and Assigned(Form.ActiveMDIChild) and Assigned(Form.ActiveMDIChild.Menu) then
        for i := 0 to Form.ActiveMDIChild.Menu.Items.Count - 1 do
          if Form.ActiveMDIChild.Menu.Items[i].Visible then begin
            inc(VisibleItems);
            Break;
          end;

      Result := VisibleItems > 0;
    end;
end;


function TsSkinProvider.OffsetX: integer;
var
  i: integer;
begin
  if (BorderForm <> nil) then
    Result := BorderWidth + ShadowSize.Left
  else begin
    if Assigned(ListSW) and Assigned(ListSW.sBarVert) and ListSW.sBarVert.fScrollVisible then
      i := GetScrollMetric(ListSW.sBarVert, SM_SCROLLWIDTH)
    else
      i := 0;

    Result := (GetWindowWidth(Form.Handle) - GetClientWidth(Form.Handle) - i) div 2
  end;
end;


function TsSkinProvider.OffsetY: integer;
var
  i: integer;
begin
  if (BorderForm <> nil) then
    Result := CaptionHeight + LinesCount * MenuHeight + Form.BorderWidth + ShadowSize.Top + integer(MenuHeight <> 0)
  else begin
    if Assigned(ListSW) and Assigned(ListSW.sBarHorz) and ListSW.sBarHorz.fScrollVisible then
      i := GetScrollMetric(ListSW.sBarHorz, SM_SCROLLWIDTH)
    else
      i := 0;

    Result := GetWindowHeight(Form.Handle) - GetClientHeight(Form.Handle) - BorderWidth * integer(GetWindowLong(Form.Handle, GWL_STYLE) and WS_BORDER = WS_BORDER) - i;
  end;
end;


function TsSkinProvider.GetLinesCount: integer;
var
  i, y1, y2: integer;
  R: TRect;
begin
  if FLinesCount <> -1 then
    Result := FLinesCount
  else
    if (Form.Menu <> nil) and (Form.WindowState <> wsMinimized) then begin
      Result := 1;
      if GetMenuItemRect(Form.Handle, Form.Menu.Handle, 0, R) then begin
        y1 := R.Bottom;
        GetClientRect(Form.Handle, R);
        if (ListSW <> nil) then
          i := integer(ListSW.sBarHorz.fScrollVisible) * GetSystemMetrics(SM_CYHSCROLL)
        else
          i := 0;

        y2 := Form.Top + Form.Height - HeightOf(R) - BorderHeight(False) - i - Form.BorderWidth * 2;
        if y2 > y1 then
          inc(Result, (y2 - y1) div (GetSystemMetrics(SM_CYMENU) - 2));

        FLinesCount := Result;
      end
      else
        Result := 0;
    end
    else
      Result := 0;
end;


procedure TsSkinProvider.Loaded;
begin
  inherited;
  LoadThirdNames(Self);
  if not RTEmpty and not RTInit and Assigned(FCommonData.SkinManager) and not (csDesigning in ComponentState) and FCommonData.Skinned(True) then
    LoadInit;
end;


procedure TsSkinProvider.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent is TsSkinManager) then
    case Operation of
      opInsert:
        if not Assigned(SkinData.SkinManager) then
          SkinData.SkinManager := TsSkinManager(AComponent);

      opRemove:
        if AComponent = SkinData.SkinManager then
          SkinData.SkinManager := nil;
    end
  else
    if (AComponent is TWinControl) then
      case Operation of
        opInsert:
          if Assigned(Adapter) then
            if TacCtrlAdapter(Adapter).IsControlSupported(TWincontrol(AComponent)) then
              TacCtrlAdapter(Adapter).AddNewItem(TWincontrol(AComponent));
      end
    else
      if (AComponent is TsTitleBar) then
        case Operation of
          opInsert:
            if FTitleBar = nil then
              FTitleBar := TsTitleBar(AComponent);

          opRemove:
            FTitleBar := nil;
        end;
end;


function TsSkinProvider.FormChanged: boolean;
begin
  Result := (FCommonData.FCacheBmp = nil) or (CaptionWidth <> FCommonData.FCacheBmp.Width) or (Form.Height <> FCommonData.FCacheBmp.Height)
end;


{$IFNDEF FPC}
procedure TsSkinProvider.RepaintMenuItem(mi: TMenuItem; R: TRect; State: TOwnerDrawState);
var
  DC, SavedDC: hdc;
begin
  SavedDC := 0;
  if MenuPresent and (Form.Menu.FindItem(mi.Handle, fkHandle) <> nil) then begin
    mi.OnAdvancedDrawItem(mi, FCommonData.FCacheBmp.Canvas, R, State);
    DC := GetWindowDC(Form.Handle);
    try
      SavedDC := SaveDC(DC);
      BitBlt(DC, R.Left, R.Top, WidthOf(R), HeightOf(R), FCommonData.FCacheBmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
    finally
      RestoreDC(DC, SavedDC);
      ReleaseDC(Form.Handle, DC);
    end;
  end;
end;
{$ENDIF}


function TsSkinProvider.SmallButtonWidth: integer;
begin
  if FCommonData.SkinManager.IsValidImgIndex(MDIClose.ImageIndex) then
    if Assigned(FCommonData.SkinManager.ma[MDIClose.ImageIndex].Bmp) then
      Result := FCommonData.SkinManager.ma[MDIClose.ImageIndex].Bmp.Width div 3
    else
      Result := WidthOfImage(FCommonData.SkinManager.ma[MDIClose.ImageIndex])
  else
    Result := 16;
end;


function TsSkinProvider.SmallButtonHeight: integer;
begin
  if FCommonData.SkinManager.IsValidImgIndex(MDIClose.ImageIndex) then
    if Assigned(FCommonData.SkinManager.ma[MDIClose.ImageIndex].Bmp) then
      Result := FCommonData.SkinManager.ma[MDIClose.ImageIndex].Bmp.Height shr 1
    else
      Result := HeightOfImage(FCommonData.SkinManager.ma[MDIClose.ImageIndex])
  else
    Result := 16;
end;


function TsSkinProvider.HaveSysMenu: boolean;
begin
  Result := biSystemMenu in Form.BorderIcons
end;


function TsSkinProvider.HeaderHeight: integer;
begin
  if (BorderForm <> nil) then
    Result := CaptionHeight + SysBorderHeight(Form.Handle, BorderForm, False)
  else
    if CaptionHeight(BorderForm = nil) = 0 then
      Result := GetWindowHeight(Form.Handle) - GetClientHeight(Form.Handle) - integer(GetWindowLong(Form.Handle, GWL_STYLE) and WS_BORDER = WS_BORDER) * BorderHeight
    else
      Result := GetWindowHeight(Form.Handle) - GetClientHeight(Form.Handle) - BorderHeight;

  if Result < 0 then
    Result := 0;
    
  if IsIconic(Form.Handle) then
    inc(Result, SysBorderHeight(Form.Handle, BorderForm, False));

  if SkinData.Skinned and Assigned(ListSW) and Assigned(ListSW.sBarHorz) and ListSW.sBarHorz.fScrollVisible then
    dec(Result, GetScrollMetric(ListSW.sBarHorz, SM_SCROLLWIDTH));
end;


function TsSkinProvider.MDIButtonsNeeded: boolean;
begin
  Result := (ChildProvider <> nil) and
            (Form.FormStyle = fsMDIForm) and
            Assigned(Form.ActiveMDIChild) and
            (Form.ActiveMDIChild.WindowState = wsMaximized) and
            (Form.Menu <> nil) and
            (biSystemMenu in Form.ActiveMDIChild.BorderIcons);
end;


function TsSkinProvider.MenuHeight: integer;
begin
  if IsMenuVisible(Self) then
    Result := GetSystemMetrics(SM_CYMENU) - 1
  else
    Result := 0;
end;


type
  TAccessMenuItem = class(TMenuItem);
  TAccessMenu = class(TMainMenu);

function TsSkinProvider.UpdateMenu: boolean;
begin
  Result := False;
  if not fGlobalFlag then begin
    fGlobalFlag := True;
    if (Form.Menu <> nil) and (Form.Menu.Items.Count > 0) and (Form.Menu.Items[0] <> nil)
        {and (Form.Menu.BiDiMode = bdLeftToRight) Avoiding a Delphi bug when position of menus is wrong (when RTL)} then begin
{$IFNDEF FPC}
      TAccessMenuItem(Form.Menu.Items[0]).MenuChanged(True);
      SkinData.BeginUpdate;
      TAccessMenu(Form.Menu).AdjustBiDiBehavior;
      SkinData.EndUpdate;
{$ENDIF}
      Result := True;
    end;
    fGlobalFlag := False;
  end;
end;


function TsSkinProvider.IconVisible: boolean;
begin
  Result := TitleIcon.Visible and ((Form.BorderStyle = bsSizeable) or (Form.BorderStyle = bsSingle)) and FShowAppIcon and
            (GetSystemMenu(Form.Handle, False) <> 0);
end;


procedure TsSkinProvider.SetCaptionAlignment(const Value: TAlignment);
begin
  if FCaptionAlignment <> Value then begin
    FCaptionAlignment := Value;
    FCommonData.BGChanged := True;
    if Form.Visible and not (csDesigning in ComponentState) and SkinData.Skinned then
      UpdateSkinCaption(Self);
  end;
end;


procedure TsSkinProvider.SetShowAppIcon(const Value: boolean);
begin
  if FShowAppIcon <> Value then begin
    FShowAppIcon := Value;
    FCommonData.BGChanged := True;
    if Form.Visible then
      ProcessMessage(WM_NCPAINT, 0, 0);
  end;
end;


procedure TsSkinProvider.SetTitleButtons(const Value: TsTitleButtons);
begin
  FTitleButtons.Assign(Value);
end;


function TsSkinProvider.RBGripPoint(const ImgIndex :integer): TPoint;
begin
  with FCommonData do
    if FCacheBmp <> nil then
      Result := Point(FCacheBmp.Width  - WidthOfImage (SkinManager.ma[ImgIndex]) - SysBorderWidth(Form.Handle, BorderForm) - ShadowSize.Right  - 1,
                      FCacheBmp.Height - HeightOfImage(SkinManager.ma[ImgIndex]) - SysBorderWidth(Form.Handle, BorderForm) - ShadowSize.Bottom - 1)
    else
      Result := MkPoint;
end;


{$IFNDEF FPC}
procedure TsSkinProvider.InitMenuItems(A: boolean);
var
  i: integer;

  procedure ProcessComponent(const c: TComponent);
  var
    i: integer;
  begin
    if (c <> nil) then begin
      if (c is TFrame) then
        for i := 0 to c.ComponentCount - 1 do
          ProcessComponent(c.Components[i])
      else
        if (c is TMainMenu) then begin
          FCommonData.SkinManager.SkinableMenus.InitMenuLine(TMainMenu(c), A and FDrawNonCLientArea);
          for i := 0 to TMainMenu(c).Items.Count - 1 do
            FCommonData.SkinManager.SkinableMenus.HookItem(TMainMenu(c).Items[i], A and FCommonData.SkinManager.SkinnedPopups);
        end
        else
          if (c is TPopupMenu) then
            FCommonData.SkinManager.SkinableMenus.HookPopupMenu(TPopupMenu(c), A and FCommonData.SkinManager.SkinnedPopups)
          else
            if (c is TMenuItem) then
              if not (TMenuItem(c).GetParentMenu is TMainMenu) then
                FCommonData.SkinManager.SkinableMenus.HookItem(TMenuItem(c), A and FCommonData.SkinManager.SkinnedPopups)
              else
                for i := 0 to c.ComponentCount - 1 do
                  ProcessComponent(c.Components[i]);
    end;
  end;

begin
  if (csDesigning in Form.ComponentState) or
       (FCommonData.SkinManager.SkinableMenus = nil) or
         not FCommonData.SkinManager.IsDefault then
    Exit;

  for i := 0 to Form.ComponentCount - 1 do
    ProcessComponent(Form.Components[i]);
end;
{$ENDIF}


procedure TsSkinProvider.StartMove(X, Y: Integer);
begin
  if (ResizeMode = rmBorder) and Form.Enabled then begin
    //Common section
    bInProcess := True;
    deskwnd    := GetDesktopWindow();
    formDC     := GetWindowDC(deskwnd);
    nDC        := SaveDC(formDC);
    ntop       := Form.Top;
    nleft      := Form.Left;
    SetROP2(formDC, R2_NOT);
    if bMode then begin //Move section
      nX := X;
      nY := Y;
      DrawFormBorder(nleft, ntop);
    end
    else begin //Size section
      nMinHeight := Form.Constraints.MinHeight;
      nMinWidth  := Form.Constraints.MinWidth;
      nbottom    := Form.top + Form.height;
      nright     := Form.left + Form.width;
      DrawFormBorder(0, 0);
    end;
  end;
end;


{$IFNDEF NOWNDANIMATION}
procedure TsSkinProvider.StartMoveForm;
begin
  if not FormActive then begin // If form activating
    FormActive := True;
    SkinData.BGChanged := True;
  end;
  if Form.CanFocus then
    SetFocus(Form.Handle);

  StartBlendOnMoving(Self);
end;
{$ENDIF}


procedure TsSkinProvider.StopMove(X, Y: Integer);
begin
  if ResizeMode = rmBorder then begin
    //Common section
    ReleaseCapture;
    bInProcess := FALSE;
    if bMode then begin //Move section
      DrawFormBorder(nleft, ntop);
      RestoreDC(formDC, nDC);
      ReleaseDC(deskwnd, formDC);
      MoveWindow(Form.handle, nleft, ntop, Form.width, Form.height, TRUE)
    end
    else begin //Size section
      DrawFormBorder(0,0);
      RestoreDC(formDC, nDC);
      ReleaseDC(deskwnd, formDC);
      if not bCapture then
        MoveWindow(Form.handle, nleft, ntop, nright - nleft, nbottom - ntop, TRUE);

      bCapture := FALSE;
    end;
  end;
end;


procedure TsSkinProvider.DrawFormBorder(X, Y: Integer);
var
  pts: array [1..5] of TPoint;
  incX, incY: integer;
  msp: TsSkinProvider;
begin
  if ResizeMode = rmBorder then begin
    if Form.FormStyle = fsMDIChild then begin
      msp := TsSkinProvider(MDISkinProvider);
      incX := msp.Form.Left + SysBorderWidth(msp.Form.Handle, msp.BorderForm) + msp.Form.BorderWidth + 1;
      incY := msp.Form.Top + SysBorderHeight(msp.Form.Handle, msp.BorderForm) * 2 + msp.CaptionHeight + msp.LinesCount * msp.MenuHeight * integer(msp.MenuPresent) + msp.Form.BorderWidth - 2;
      X := X + incX;
      Y := Y + incY;
    end
    else begin
      incX := 0;
      incY := 0;
    end;

    if bMode then begin // Move section
      pts[1] := point(X, Y);
      pts[2] := point(X, Y + Form.Height);
      pts[3] := point(X + Form.Width, Y + Form.Height);
      pts[4] := point(X + Form.Width, Y);
      pts[5] := point(X, Y);
      PolyLine(formDC, pts, 5);
    end
    else begin //Size section
      pts[1].X := nleft   + incX;
      pts[1].Y := ntop    + incY;
      pts[2].X := nleft   + incX;
      pts[2].Y := nbottom + incY;
      pts[3].X := nright  + incX;
      pts[3].Y := nbottom + incY;
      pts[4].X := nright  + incX;
      pts[4].Y := ntop    + incY;
      pts[5].X := nleft   + incX;
      pts[5].Y := ntop    + incY;
      PolyLine(formDC, pts, 5);
    end;
  end;
end;


procedure TsSkinProvider.SetUseGlobalColor(const Value: boolean);
begin
  if FUseGlobalColor <> Value then begin
    FUseGlobalColor := Value;
    if FCommonData.Skinned and
         Assigned(Form) and
           Value and
             not SkinData.CustomColor then
      Form.Color := FCommonData.SkinManager.GetGlobalColor
  end;
end;


procedure TsSkinProvider.RepaintMenu;
begin
  SkinData.BGChanged := True;
  MenuChanged := True;
  FLinesCount := -1;
  ProcessMessage(WM_NCPAINT, 0, 0);
end;


function TsSkinProvider.CaptionWidth: integer;
begin
  if IsIconic(Form.Handle) and (Application.MainForm <> Form) then
    Result := 160
  else
    Result := Form.Width + integer(BorderForm <> nil) * 2 * DiffBorder(Self.BorderForm);

  inc(Result, ShadowSize.Left + ShadowSize.Right);
end;


procedure TsSkinProvider.UpdateIconsIndexes;
begin
  BigButtons := Form.BorderStyle in [bsSingle, bsSizeable];
  if FCommonData.SkinManager.IsValidSkinIndex(FCommonData.SkinManager.ConstData.IndexGlobalInfo) then begin
    ButtonMin.HitCode   := HTMINBUTTON;
    ButtonMax.HitCode   := HTMAXBUTTON;
    ButtonClose.HitCode := HTCLOSE;
    with FCommonData.SkinManager do begin // For compatibility with skins with version < 4.33
      if BigButtons then begin
        ButtonMin.ImageIndex := ConstData.MaskMinBtn;
        ButtonMax.ImageIndex := ConstData.MaskMaxBtn;

        if (SystemMenu <> nil) and (SystemMenu.VisibleMax or SystemMenu.VisibleMin) then
          ButtonClose.ImageIndex := ConstData.MaskCloseBtn
        else begin
          ButtonClose.ImageIndex := ConstData.MaskCloseAloneBtn;
          if ButtonClose.ImageIndex < 0 then
            ButtonClose.ImageIndex := ConstData.MaskCloseBtn
        end;
        ButtonHelp.ImageIndex := ConstData.MaskHelpBtn;
        ButtonMin.HaveAlignment := True;
      end
      else begin
        ButtonClose.ImageIndex := ConstData.MaskCloseSmall;
        ButtonMin  .ImageIndex := ConstData.MaskMinSmall;
        ButtonMax  .ImageIndex := ConstData.MaskMaxSmall;
        ButtonHelp .ImageIndex := ConstData.MaskHelpSmall;
        if ButtonHelp.ImageIndex < 0 then
          ButtonHelp.ImageIndex := ConstData.MaskHelpBtn;

        ButtonMin.HaveAlignment := False;
      end;
      ButtonMax  .HaveAlignment := ButtonMin.HaveAlignment;
      ButtonClose.HaveAlignment := ButtonMin.HaveAlignment;
      ButtonHelp .HaveAlignment := ButtonMin.HaveAlignment;
      if ButtonClose.ImageIndex < 0 then begin
        ButtonClose.ImageIndex := ConstData.MaskCloseBtn;
        ButtonMin  .ImageIndex := ConstData.MaskMinBtn;
        ButtonMax  .ImageIndex := ConstData.MaskMaxBtn;
        ButtonHelp .ImageIndex := ConstData.MaskHelpBtn;
        ButtonMin  .HaveAlignment := True;
        ButtonMax  .HaveAlignment := True;
        ButtonClose.HaveAlignment := True;
        ButtonHelp .HaveAlignment := True;

        if (Form.FormStyle = fsMDIForm) and not (csDesigning in ComponentState) then begin
          MDIMin  .ImageIndex := ConstData.MaskMinBtn;
          MDIMax  .ImageIndex := ConstData.MaskMaxBtn;
          MDIClose.ImageIndex := ConstData.MaskCloseBtn;
        end;
        MDIMin  .HaveAlignment := True;
        MDIMax  .HaveAlignment := True;
        MDIClose.HaveAlignment := True;
      end
      else begin
        if (Form.FormStyle = fsMDIForm) and not (csDesigning in ComponentState) then begin
          MDIMin  .ImageIndex := ConstData.MaskMinSmall;
          MDIMax  .ImageIndex := ConstData.MaskMaxSmall;
          MDIClose.ImageIndex := ConstData.MaskCloseSmall;
          MDIMin  .HaveAlignment := False;
          MDIMax  .HaveAlignment := False;
          MDIClose.HaveAlignment := False;
        end;
        if MDIMin.ImageIndex < 0 then begin
          MDIMin  .ImageIndex := ButtonMin.ImageIndex;
          MDIMax  .ImageIndex := ButtonMax.ImageIndex;
          MDIClose.ImageIndex := ButtonClose.ImageIndex;
          MDIMin  .HaveAlignment := True;
          MDIMax  .HaveAlignment := True;
          MDIClose.HaveAlignment := True;
        end;
      end;
    end;
    UserBtnIndex := FCommonData.SkinManager.GetMaskIndex(FCommonData.SkinManager.ConstData.IndexGlobalInfo, s_TitleButtonMask);
  end;
end;


procedure TsSkinProvider.SetTitleSkin(const Value: TsSkinSection);
begin
  if FTitleSkin <> Value then begin
    FTitleSkin := Value;
    FTitleSkinIndex := -1;
    FCommonData.BGChanged := True;
    if Form.Visible then
      if BorderForm <> nil then
        BorderForm.UpdateExBordersPos
      else
        ProcessMessage(WM_NCPAINT, 0, 0);
  end;
end;


function TsSkinProvider.TitleSkinSection: string;
begin
  Result := iff(FTitleSkin = '', s_FormTitle, FTitleSkin);
end;


procedure TsSkinProvider.TryInitMenu;
begin
  if not MenusInitialized then begin
{$IFNDEF FPC}
    if Form.Menu <> nil then
      SkinData.SkinManager.SkinableMenus.InitMenuLine(Form.Menu, FDrawNonClientArea);
{$ENDIF}

    MenusInitialized := UpdateMenu;
  end;
end;


procedure TsSkinProvider.SetMenuLineSkin(const Value: TsSkinSection);
begin
  if (FMenuLineSkin <> Value) then begin
    FMenuLineSkin := Value;
    if (csDesigning in ComponentState) then
      SkinData.Invalidate;
  end;
end;


procedure TsSkinProvider.PrepareForm;
begin
  if RTInit or
       RTEmpty or
         (FCommonData.SkinManager = nil) or
           (Form = nil) or
             not Form.HandleAllocated or
               not FCommonData.SkinManager.CommonSkinData.Active then
    Exit;

{$IFNDEF FPC}
  if (Form.Menu <> nil) and Form.Menu.OwnerDraw then begin
    FMenuOwnerDraw := Form.Menu.OwnerDraw;
    MenusInitialized := True;
  end
  else
    FMenuOwnerDraw := False;
{$ENDIF}

  FCommonData.Loaded;
  InitIndexes;
{$IFNDEF FPC}
  if SystemMenu = nil then begin
    SystemMenu := TsSystemMenu.Create(Self);
    SystemMenu.FForm := Form;
    SystemMenu.WindowHandle := 0;
    SystemMenu.UpdateItems;
  end;
  CheckSysMenu(True);
{$ENDIF}
  if ClearButtons and FCommonData.SkinManager.CommonSkinData.Active then begin
    ClearButtons := False;
    if (Form.FormStyle = fsMDIForm) and not (csDesigning in ComponentState) then
      HookMDI;
  end;
  FCommonData.UpdateIndexes;
  UpdateTitleBar;
  UpdateIconsIndexes;

  if (Form.FormStyle = fsMDIChild) then // If form is MDIChild and menus are merged then
    if Assigned(MDISkinProvider) and
         not (csDestroying in TsSkinProvider(MDISkinProvider).ComponentState) and
           not (csDestroying in TsSkinProvider(MDISkinProvider).Form.ComponentState) and
             SkinData.Skinned then begin

      TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
      TsSkinProvider(MDISkinProvider).FLinesCount := -1;
    end;

  if not (csCreating in Form.ControlState) and
       not (csReadingState in Form.ControlState) and
         not (csLoading in ComponentState) and
           (SkinData.SkinManager <> nil) and
             UseGlobalColor and
               not SkinData.CustomColor then

    Form.Color := SkinData.SkinManager.GetGlobalColor;
    
  if SystemMenu <> nil then
    SystemMenu.UpdateGlyphs;

  if not (csLoading in Form.ComponentState) and Form.Showing then
    InitExBorders(SkinData.SkinManager.ExtendedBorders);
end;


procedure TsSkinProvider.HookMDI(Active: boolean);
begin
  if Active then begin
    if not WndIsSkinned(Form.ClientHandle){GetBoolMsg(Form.ClientHandle, AC_CTRLHANDLED)} and Assigned(MDIForm) then
      FreeAndNil(MDIForm);

    if not Assigned(MDIForm) then begin
      MDISkinProvider := Self;
      TsMDIForm(MDIForm) := TsMDIForm.Create(Self);
      if MDIForm <> nil then
        TsMDIForm(MDIForm).ConnectToClient;
    end;
  end
  else
    if Assigned(MDIForm) then
      FreeAndNil(MDIForm);
end;


function TsSkinProvider.TitleBtnsWidth: integer;
var
  i: integer;
begin
  with FCommonData.SkinManager.CommonSkinData do begin
    Result := BIRightMargin;
    if Assigned(SystemMenu) and HaveSysMenu then begin
      inc(Result, SysButtonWidth(ButtonClose));
      if SystemMenu.VisibleMax then
        inc(Result, SysButtonWidth(ButtonMax) + integer(BigButtons) * BISpacing);

      if SystemMenu.VisibleMin then
        inc(Result, SysButtonWidth(ButtonMin) + integer(BigButtons) * BISpacing);

      if (biHelp in Form.BorderIcons) then
        inc(Result, SysButtonWidth(ButtonHelp) + integer(BigButtons) * BISpacing);
    end;
    if TitleButtons.Count > 0 then
      inc(Result, UserButtonsOffset);

    for i := 0 to TitleButtons.Count - 1 do
      inc(Result, UserButtonWidth(TitleButtons[i]) + integer(BigButtons) * BISpacing);
  end;
end;


function TsSkinProvider.UserButtonWidth(const Btn: TsTitleButton): integer;
begin
  if Assigned(Btn.Glyph) then
    Result := Btn.Glyph.Width + 2
  else
    Result := 0;

  if FCommonData.SkinManager.IsValidImgIndex(UserBtnIndex) then
    Result := max(Result, WidthOf(FCommonData.SkinManager.ma[UserBtnIndex].R) div FCommonData.SkinManager.ma[UserBtnIndex].ImageCount)
  else
    Result := max(Result, 21);
end;


procedure TsSkinProvider.AdapterCreate;
begin
  if not (csDesigning in ComponentState) and FCommonData.Skinned then begin
    Adapter := TacCtrlAdapter.Create(Self);
    if (Form <> nil) {and IsWindowVisible(Form.Handle) }then
      TacCtrlAdapter(Adapter).AddAllItems;
  end;
end;


procedure TsSkinProvider.AdapterRemove;
begin
  if not (csDesigning in ComponentState) then begin
    SendToAdapter(MakeMessage(SM_ALPHACMD, MakeWParam(0, AC_REMOVESKIN), LongWord(SkinData.SkinManager), 0));
    FreeAndNil(Adapter);
  end;
end;


procedure TsSkinProvider.SendOwnerToBack;
begin
  if BorderForm <> nil then
    BorderForm.SendOwnerToBack;
end;


procedure TsSkinProvider.SendToAdapter(Message: TMessage);
begin
  if not (csDesigning in ComponentState) and Assigned(Adapter) then
    TacCtrlAdapter(Adapter).WndProc(Message)
end;


procedure TsSkinProvider.MdiIcoFormPaint(Sender: TObject);
begin
  with TForm(Sender) do
    BitBlt(Canvas.Handle, 0, 0, 60, GetSystemMetrics(SM_CYMENU) + 3, SkinData.FCacheBmp.Canvas.Handle,
           Form.Width - 60 + SysBorderWidth(Form.Handle, BorderForm) - ShadowSize.Right, CaptionHeight + ShadowSize.Top, SRCCOPY);
end;


procedure TsSkinProvider.CaptFormPaint(Sender: TObject);
begin
  if (CaptForm <> nil) and not (csDestroying in CaptForm.ComponentState) and (SkinData.FCacheBmp <> nil) and (MenuLineBmp <> nil) then
    CaptFormPaintDC(CaptForm.Canvas.Handle);
end;


procedure TsSkinProvider.CaptFormPaintDC(aDC: hdc);
var
  DC: hdc;
begin
  if FCommonData.FCacheBmp <> nil then begin
    if aDC <> 0 then
      DC := aDC
    else
      DC := GetDC(CaptForm.Handle);

    try
      if BorderForm <> nil then // If paint menu only
        BitBlt(DC, 0, 0, CaptForm.Width, CaptForm.Height, FCommonData.FCacheBmp.Canvas.Handle, OffsetX - Form.BorderWidth, OffsetY - LinesCount * MenuHeight - Form.BorderWidth - 1, SRCCOPY)
      else
        BitBlt(DC, 0, 0, CaptForm.Width, CaptForm.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);

    except
      if aDC = 0 then
        ReleaseDC(CaptForm.Handle, DC);
    end;
  end;
end;


procedure TsSkinProvider.NewCaptFormProc(var Message: TMessage);
begin
  if Message.Msg in [WM_ERASEBKGND, WM_NCPAINT] then
    CaptFormPaintDC(TWMPaint(Message).DC)
  else
    OldCaptFormProc(Message);
end;


procedure TsSkinProvider.SaveBGForBtns(CaptWidth: integer; Full: boolean = False);
var
  cy, sbh: integer;
begin
  TempBmp.PixelFormat := FCommonData.FCacheBmp.PixelFormat;
  TempBmp.Width  := TitleBtnsWidth + SysBorderWidth(Form.Handle, BorderForm) + 10 + ShadowSize.Right;
  sbh := SysBorderHeight(Form.Handle, BorderForm);
  TempBmp.Height := CaptionHeight + sbh + SysBorderWidth(Form.Handle, BorderForm, False) + MenuHeight + ShadowSize.Top;
  cy := iff(Full, TempBmp.Height, CaptionHeight + sbh);
  BitBlt(TempBmp.Canvas.Handle, 0, 0, TempBmp.Width, cy, FCommonData.FCacheBmp.Canvas.Handle, CaptWidth - TempBmp.Width - 1, 0, SRCCOPY);
end;


procedure TsSkinProvider.RestoreBtnsBG(CaptWidth: integer);
begin
  if Assigned(TempBmp) then
    BitBlt(FCommonData.FCacheBmp.Canvas.Handle, CaptWidth - TempBmp.Width - 1, 0, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
end;


procedure TsSkinProvider.AC_WMEraseBkGndHandler(aDC: hdc);
var
  DC, SavedDC: hdc;
  cR: TRect;
begin
  if InAero then
    if (GetClipBox(aDC, cR) = NULLREGION) or (WidthOf(cR) = 0) or (HeightOf(cR) = 0) then
      aDC := 0; // New DC is needed

  if (aDC = 0) or (SkinData.PrintDC <> 0) and (aDC <> SkinData.PrintDC) then
    DC := GetDC(Form.Handle)
  else
    DC := aDC;

  try
    FCommonData.FUpdating := False;
    if not fAnimating and
         not (csDestroying in Form.ComponentState) and
           not ((Form.FormStyle = fsMDIChild) and
             (MDISkinProvider <> nil) and
               not MDICreating and
                 Assigned(TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild) and
                   (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState = wsMaximized) and
                     (Form <> TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild)) then begin
      SavedDC := SaveDC(DC);
      ExcludeControls(DC, Form, actGraphic, 0, 0);
      PaintForm(DC);
      if IsGripVisible(Self) then begin
        MoveWindowOrg(DC, -OffsetX, -OffsetY);
        PaintGrip(DC, Self);
      end;
      RestoreDC(DC, SavedDC);
      PaintControls(DC, Form, True, MkPoint);

      if not SkinData.SkinManager.Effects.AllowOuterEffects then
        SetParentUpdated(Form);
    end;
  finally
    if (DC <> aDC) then
      ReleaseDC(Form.Handle, DC);
  end;
end;


procedure TsSkinProvider.AC_WMNCPaintHandler;
var
  i, y, th, ty, sbw, dy: integer;
  DC, SavedDC: hdc;
  bIconic: boolean;

  function UpdateCache: boolean;
  begin
    Result := True;
    if (SkinData.FCacheBmp <> nil) and (SkinData.FCacheBmp.Width = 0) then
      SkinData.BGChanged := True; // If Cache is not ready

    if FCommonData.BGChanged and not PaintAll then
      Result := False;
  end;
  
begin
  if not MDICreating and FDrawNonClientArea and (LockCount <= 0) then begin // If not maximized mdi child was created
    if (ResizeMode = rmBorder) and AeroIsEnabled then
      ResizeMode := rmStandard;

    if (Form.FormStyle = fsMDIChild) and
         (MDISkinProvider <> nil) and Assigned(TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild) and
           (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState = wsMaximized) and
             (Form <> TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild) then
        Exit;

    TryInitMenu;
    if UpdateCache then begin
      if not RgnChanging and RgnChanged then begin
        bIconic := IsIconic(Form.Handle);
        if (HaveBorder(Self) or IsSizeBox(Form.Handle) or bIconic) then begin
          if bIconic { If form is iconic but shown on taskbar only} and (GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_APPWINDOW = WS_EX_APPWINDOW) then
            Exit;

          if (BorderForm = nil) then
            FillArOR(Self);

          RgnChanged := False;
          if (fsShowing in Form.FormState) and (Form.Position <> poDefault) and (Form.WindowState <> wsMaximized) then
//            UpdateRgn(Self, False)
            UpdateRgn(Self, True, True) // Removing of std borders with repaint
          else begin
            UpdateRgn(Self, not InAnimationProcess);// and (Form.Parent <> nil));
            if not SkinData.BGChanged then
              Exit; // If not repainted
          end;
        end
        else
          SetWindowRgn(Form.Handle, 0, False);
      end;
      FCommonData.FUpdating := False;
      DC := GetWindowDC(Form.Handle);
      SavedDC := SaveDC(DC);
      try
        if (BorderForm <> nil) then begin
          i := Form.BorderWidth;
          y := CaptionHeight(False);
    {
          if ListSW.cxLeftEdge > 4 then
            sbw := ListSW.cxLeftEdge
          else
    }
          sbw := SysBorderWidth(Form.Handle, BorderForm, False);

          inc(y, sbw);
          if FSysExHeight then
            dec(y, 4);

          ty := MenuHeight * LinesCount + integer(IsMenuVisible(Self)) + Form.BorderWidth;
{$IFNDEF NOFONTSCALEPATCH}
          if SkinData.SkinManager.SysFontScale > 0 then begin
            dec(y, 1);
            inc(ty, 2);
          end;
{$ENDIF}
          th := y + ty;
          dy := OffsetY - ty;

          BitBlt(DC, sbw, y,
                 FCommonData.FCacheBmp.Width - ShadowSize.Left - ShadowSize.Right,
                 ty,
                 FCommonData.FCacheBmp.Canvas.Handle, SysBorderWidth(Form.Handle, BorderForm) + ShadowSize.Left, dy, SRCCOPY); // Title and menu line update
          if i <> 0 then begin
            // Left
            BitBlt(DC, sbw, th, i, Form.Height - sbw, FCommonData.FCacheBmp.Canvas.Handle, OffsetX - Form.BorderWidth, OffsetY, SRCCOPY);
            // Bottom
            BitBlt(DC, sbw + Form.BorderWidth, Form.Height - i - sbw, Form.Width - i - sbw - Form.BorderWidth, i, FCommonData.FCacheBmp.Canvas.Handle, BorderWidth + ShadowSize.Left, FCommonData.FCacheBmp.Height - BorderWidth - ShadowSize.Bottom, SRCCOPY); // Bottom border update
            // Right
            BitBlt(DC, Form.Width - i - sbw, th, i, FCommonData.FCacheBmp.Height - sbw, FCommonData.FCacheBmp.Canvas.Handle, FCommonData.FCacheBmp.Width - BorderWidth - ShadowSize.Right, OffsetY, SRCCOPY); // Right border update
          end;
        end
        else
          if not HaveBorder(Self) and IsSizeBox(Form.Handle) and not IsIconic(Form.Handle) then begin
            i := BorderWidth + 3;
            BitBlt(DC, 0, 0, Form.Width, i, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY); // Title and menu line update
            BitBlt(DC, 0, i, i, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, i, SRCCOPY); // Left border update
            BitBlt(DC, i, Form.Height - i, Form.Width - i, i, FCommonData.FCacheBmp.Canvas.Handle, i, Form.Height - i, SRCCOPY); // Bottom border update
            BitBlt(DC, FCommonData.FCacheBmp.Width - i, i, i, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, FCommonData.FCacheBmp.Width - i, i, SRCCOPY); // Right border update
          end
          else
            PaintCaption(DC);
      finally
        RestoreDC(DC, SavedDC);
        ReleaseDC(Form.Handle, DC);
      end;
      RgnChanging := False;
    end;
  end;
end;


function TsSkinProvider.FormColor: TColor;
begin
  if FCommonData.Skinned and not SkinData.CustomColor then
    Result := FCommonData.SkinManager.gd[FCommonData.Skinindex].Props[integer(FormActive)].Color
  else
    Result := ColorToRGB(Form.Color);
end;


procedure TsSkinProvider.OurPaintHandler(const Msg: TWMPaint);
var
  SavedDC: hdc;
  PS: TPaintStruct;
begin
  if fAnimating or InAnimationProcess and (Msg.DC = 0) or (csDestroying in Form.ComponentState) then begin
    BeginPaint(Form.Handle, PS);
    EndPaint(Form.Handle, PS);
    Exit;
  end;
  if not InAnimationProcess then
    BeginPaint(Form.Handle, PS);

  SavedDC := SaveDC(Form.Canvas.Handle);
  try
    Form.Canvas.Lock;
    if Form.Parent <> nil then
      FCommonData.FUpdating := FCommonData.Updating
    else
      FCommonData.FUpdating := False;

    if not ((Form.FormStyle = fsMDIChild) and
         (MDISkinProvider <> nil) and
           not MDICreating and
             Assigned(TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild) and
               (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState = wsMaximized) and
                 (Form <> TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild)) then
      PaintForm(Form.Canvas.Handle);

  finally
    Form.Canvas.UnLock;
    RestoreDC(Form.Canvas.Handle, SavedDC);
    Form.Canvas.Handle := 0;
    if not InAnimationProcess then
      EndPaint(Form.Handle, PS);
  end;
end;


procedure TsSkinProvider.CheckSysMenu(const Skinned: boolean);
begin
  if Skinned then
    if FDrawNonClientArea then begin
      if GetWindowLong(Form.Handle, GWL_STYLE) and WS_SYSMENU = WS_SYSMENU then
        SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_SYSMENU)
    end
    else
      SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_SYSMENU)
  else
    if HaveSysMenu then begin
      SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_SYSMENU);
      // Update title icon (not updated automatically in some cases)
      Form.Perform(WM_SETICON, 0, Form.Perform(WM_GETICON, 0, 0));
    end;
end;


procedure TsSkinProvider.SetDrawNonClientArea(const Value: boolean);
begin
  if (FDrawNonClientArea <> Value) then begin
    FDrawNonClientArea := Value;
    if (csDesigning in ComponentState) then
      Exit;
      
    if Value then begin
      CheckSysMenu(True);
      if not (csDesigning in ComponentState) and (Form <> nil) and Form.Showing and SkinData.Skinned then begin
        SkinData.BGChanged := True;
        TryInitMenu;
        InitExBorders(SkinData.SkinManager.ExtendedBorders);
        RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
        RefreshFormScrolls(Self, ListSW, False);
      end;
    end
    else begin
      if BorderForm <> nil then
        FreeAndNil(BorderForm);

{$IFNDEF FPC}
      if SkinData.SkinManager <> nil then
        SkinData.SkinManager.SkinableMenus.InitMenuLine(Form.Menu, False);
{$ENDIF}

      if (uxthemeLib <> 0) then
        Ac_SetWindowTheme(Form.Handle, nil, nil);

      if ListSW <> nil then
        FreeAndNil(ListSW);

      if HaveSysMenu then
        SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_SYSMENU);

      if Form.Showing then
        SetWindowRgn(Form.Handle, 0, True);

      if BorderForm <> nil then
        BorderForm.UpdateExBordersPos;
    end;
  end;
end;


{$IFNDEF FPC}
procedure TsSkinProvider.AC_WMInitMenuPopup(var Message: TWMInitMenuPopup);
var
  s: acString;
  sCut: string;
  c, i: integer;
  mi: TMenuItemInfo;
  TmpItem: TMenuItem;

  function GetItemText(ID: Cardinal; var Caption: acString; var ShortCut: String; uFlag: Cardinal): boolean;
  var
    Text: array[0..MaxByte] of acChar;
  begin
    Result := {$IFDEF TNTUNICODE}GetMenuStringW{$ELSE}GetMenuString{$ENDIF}(Message.MenuPopup, ID, Text, MaxByte, uFlag) <> 0;
  end;
  
begin
  if SkinData.SkinManager.SkinnedPopups then begin
    if Message.SystemMenu then
      EnableMenuItem(Message.MenuPopup, SC_SIZE, MF_BYCOMMAND or MF_GRAYED)
    else
      acCanHookMenu := False; // Menu skinning is supported

    // Remove MDI items
    if Form.WindowMenu <> nil then begin
      i := Form.WindowMenu.Count - 1;
      while i >= 0 do begin
        if Form.WindowMenu.Items[i].Tag and $200 = $200 then
          Form.WindowMenu.Delete(i);

        dec(i);
      end;
    end;
    if (Form.FormStyle = fsMDIForm) and (Form.MDIChildCount > 0) and (Form.WindowMenu <> nil) and //then begin
      (Form.WindowMenu.Handle = Message.MenuPopup) then begin
        for i := 0 to Form.WindowMenu.Count - 1 do
          Form.WindowMenu.Items[i].InitiateAction;
        // Clear old items
        c := GetMenuItemCount(Message.MenuPopup);
        i := c;
        while i >= 0 do begin
          if GetItemText(i, s, sCut, MF_BYPOSITION) then begin
            RemoveMenu(Message.MenuPopup, i, MF_BYPOSITION);
            dec(i);
            Continue;
          end;
          mi.cbSize := SizeOf(mi);
          mi.fMask := MIIM_STATE or MIIM_DATA or MIIM_FTYPE;
          if GetMenuItemInfo(Message.MenuPopup, i, True, mi) then
            if (mi.dwItemData = 0) and (mi.fType and MF_SEPARATOR = MF_SEPARATOR) then
              RemoveMenu(Message.MenuPopup, i, MF_BYPOSITION);

          dec(i);
        end;
        if Form.WindowMenu.Items[Form.WindowMenu.Count - 1].Caption <> CharMinus then begin
          TmpItem := TMenuItem.Create(Self);
          TmpItem.Caption := CharMinus;
          Form.WindowMenu.Add(TmpItem);
        end;
        for i := 0 to Form.MDIChildCount - 1 do
          if Form.MDIChildren[i].Visible then begin
            TmpItem := TMenuItem.Create(Self);
            TmpItem.Caption := Form.MDIChildren[i].Caption;
            TmpItem.OnClick := OnChildMnuClick;
            TmpItem.Tag := i;
            if Form.MDIChildren[i] = Form.ActiveMDIChild then
              TmpItem.Checked := True;

            TmpItem.Tag := TmpItem.Tag or $200;
            Form.WindowMenu.Add(TmpItem);
          end;

        Message.Result := 0;
      end
    else
      OldWndProc(TMessage(Message));
  end;
end;
{$ENDIF}


procedure TsSkinProvider.InitExBorders(const Active: boolean);
begin
  if Active and HaveBorder(Self)
       and DrawNonClientArea and
         (Form.Parent = nil) and
           (Form.FormStyle <> fsMDIChild) and
             FAllowExtBorders and
               not ((Form.WindowState = wsMaximized) and
                 SkinData.SkinManager.Options.NativeBordersMaximized) then begin
    if BorderForm = nil then begin
      BorderForm := TacBorderForm.Create(Self);
      BorderForm.SkinData := FCommonData;
    end;
    FCommonData.BGChanged := True;
    BorderForm.UpdateExBordersPos;
  end
  else
    if BorderForm <> nil then
      FreeAndNil(BorderForm);
end;


procedure TsSkinProvider.AC_WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var
  R: TRect;
  sbwf, addY: integer;
begin
  if FDrawNonClientArea and (Form.BorderStyle <> bsNone) and (Form.FormStyle <> fsMDIChild) and (Form.Parent = nil) then begin
    R := acWorkRect(Form);
    sbwf := SysBorderWidth(Form.Handle, nil, False); // Standard border width
    if (BorderForm <> nil) and not ((Form.WindowState = wsMaximized) and not ExtBordersNeeded(Self)) and not
          ((FormState and FS_ZOOMING = FS_ZOOMING) and SkinData.SkinManager.Options.NativeBordersMaximized) then
      if GetWindowLong(Form.Handle, GWL_STYLE) and WS_CAPTION = WS_CAPTION then begin // If for caption is visible
        FSysExHeight := (FormState and FS_ZOOMING = FS_ZOOMING) {IsZoomed(Form.Handle)} and (ActualTitleHeight(True) > (SysCaptHeight(Form) + 4));
        addY := MaxBtnOffset(Self, True);
      end
      else
        addY := 0
    else
      addY := 0;

    Message.MinMaxInfo^.ptMaxPosition.Y := - sbwf + addY;
    Message.MinMaxInfo^.ptMaxPosition.X := - sbwf;
    sbwf := sbwf * 2;
    Message.MinMaxInfo^.ptMaxSize.X := WidthOf(R)  + sbwf;
    Message.MinMaxInfo^.ptMaxSize.Y := HeightOf(R) + sbwf - addY;
    Message.Result := 0;
  end;
  OldWndProc(TMessage(Message));
end;


function TsSkinProvider.ShadowSize: TRect;
begin
  if BorderForm <> nil then
    Result := SkinData.SkinManager.FormShadowSize
  else
    Result := MkRect;
end;


procedure TsSkinProvider.KillAnimations;
var
  i: integer;
begin
  if ButtonMin.Timer <> nil then
    FreeAndNil(ButtonMin.Timer);

  if ButtonMax.Timer <> nil then
    FreeAndNil(ButtonMax.Timer);

  if ButtonClose.Timer <> nil then
    FreeAndNil(ButtonClose.Timer);

  if ButtonHelp.Timer <> nil then
    FreeAndNil(ButtonHelp.Timer);

  if (TitleButtons <> nil) then
    for i := 0 to TitleButtons.Count - 1 do
      if TitleButtons[i].Data.Timer <> nil then
        FreeAndNil(TitleButtons[i].Data.Timer);

  if not (csDestroying in ComponentState) and Assigned(FTitleBar) then
    for i := 0 to FTitleBar.Items.Count - 1 do
      if FTitleBar.Items[i].Timer <> nil then
        FreeAndNil(FTitleBar.Items[i].Timer);
end;


procedure TsSkinProvider.SetAllowExtBorders(const Value: boolean);
begin
  if FAllowExtBorders <> Value then begin
    FAllowExtBorders := Value;
    if not (csLoading in ComponentState) and not (csDesigning in ComponentState) then begin
      InitExBorders(True);
      FCommonData.BGChanged := True;
      RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);
    end;
  end;
end;


{$IFNDEF ALITE}
var
  bacWheelFlag: boolean = False;


function FindScrollBox(Ctrl: TWinControl; ScrPoint: TPoint): TsScrollBox;
var
  c: TControl;
begin
  c := Ctrl.ControlAtPos(Ctrl.ScreenToClient(ScrPoint), false, true);
  if (c <> nil) and (c is TWinControl) then
    if (c is TsScrollBox) then
      Result := TsScrollBox(c)
    else
      Result := FindScrollBox(TWinControl(c), ScrPoint)
  else
    Result := nil;
end;


procedure TsSkinProvider.AC_CMMouseWheel(var Message: TCMMouseWheel);
var
  sb: TsScrollBox;
begin
  OldWndProc(TMessage(Message));
  if not bacWheelFlag then begin
    bacWheelFlag := True;
    if Message.Result = 0 then begin
      sb := FindScrollBox(Form, acMousePos);
      if (sb <> nil) and sb.AutoMouseWheel then
        Message.Result := LRESULT(sb.DoMouseWheel(Message.ShiftState, Message.WheelDelta, SmallPointToPoint(Message.Pos)));
    end;
    bacWheelFlag := False;
  end;
end;
{$ENDIF}


constructor TsSkinProvider.CreateRT(AOwner: TComponent; InitRT: boolean = True);
var
  i: integer;
begin
  Create(AOwner);
  RTInit := True;
  for i := 0 to Form.ComponentCount - 1 do
    if (Form.Components[i] is TsTitleBar) then
      FTitleBar := TsTitleBar(Form.Components[i]);
end;


procedure TsSkinProvider.LoadInit;
var
  mi, i: integer;
begin
  if Form.HandleAllocated then
    InitDwm(Form.Handle, DrawNonClientArea);

  PrepareForm;
  if Adapter = nil then
    AdapterCreate;

  if Assigned(SystemMenu) then
    SystemMenu.UpdateItems;

  mi := FCommonData.SkinManager.GetMaskIndex(FCommonData.SkinManager.ConstData.IndexGlobalInfo, s_TitleButtonMask);
  for i := 0 to TitleButtons.Count - 1 do
    TitleButtons.Items[i].Data.ImageIndex := iff(TitleButtons.Items[i].UseSkinData, mi, -1);

  if Assigned(MDIForm) then
    TsMDIForm(MDIForm).ConnectToClient;

  if (Form.BorderStyle = bsSizeToolWin) then begin
    AllowBlendOnMoving := False; // Not use for dock windows
    UseGlobalColor := True;
  end;
end;


procedure TsSkinProvider.OnChildMnuClick(Sender: TObject);
var
  i: integer;
begin
  i := TMenuItem(Sender).Tag and not $200;
  if i < Form.MDIChildCount then
    Form.MDIChildren[i].BringToFront;
end;


procedure TsSkinProvider.AC_WMNCMouseMove(var Message: TWMNCMouseMove);
var
  M: TWMNCHitTest;
begin
  if Form.Enabled then begin
    FCommonData.SkinManager.ActiveControl := Form.Handle;
    M.Msg := WM_NCHitTest;
    M.XPos := SmallInt(Message.XCursor);
    M.YPos := SmallInt(Message.YCursor);
    M.Unused := 0;
    M.Result := 0;
    Message.HitTest := HTProcess(M);
    case Message.HitTest of
      HTCLOSE, HTMINBUTTON, HTMAXBUTTON, HTHELP, HTUDBTN..HTUDBTN + 100, HTITEM..HTITEM + 100:
        SetHotHT(Message.HitTest); // Title icon hovered

      HTCHILDCLOSE, HTCHILDMAX, HTCHILDMIN:
        SetHotHT(Message.HitTest); // MDI icon hovered

      else begin
        SetHotHT(0);
        OldWndProc(TMessage(Message));
      end;
    end;
  end;  
end;


procedure TsSkinProvider.ProcessMessage(Msg: Cardinal; WPar: WPARAM = 0; LPar: LPARAM = 0);
var
  acM: TMessage;
begin
  acM := MakeMessage(Msg, WPar, LPar, 0);
  NewWndProc(acM);
end;


procedure TsSkinProvider.CalcItems;
var
  i, mi, Index, FullRight: integer;
  Bar: TacAccessTitleBar;
  FBarRect: TRect;

  procedure ProcSysButton(var Btn: TsCaptionButton; var Index: integer; UserBtn: TsTitleButton = nil);
  var
    w: integer;
  begin
    if UserBtn = nil then
      w := SysButtonWidth(Btn)
    else
      w := UserButtonWidth(UserBtn);
    // Left/Right coords of button
    Btn.Rect.Right := FBarRect.Right;
    Btn.Rect.Left := Btn.Rect.Right - w;
    if Btn.HaveAlignment { If not user button and not small } and (FCommonData.SkinManager.CommonSkinData.BIVAlign = 1) { Top aligning } then
      Btn.Rect.Top := FBarRect.Top
    else // va_center
      Btn.Rect.Top := VCenter - ButtonHeight div 2;

    Btn.Rect.Bottom := Btn.Rect.Top + ButtonHeight;
    // New right Offset
    FBarRect.Right := Btn.Rect.Left - integer(BigButtons) * FCommonData.SkinManager.CommonSkinData.BISpacing;
    inc(Index);
  end;

begin
  with FCommonData.SkinManager.CommonSkinData do begin
    // Center of header (vertical)
    if (BorderForm <> nil) then begin
      // Get top coordinate of the title bar
      FBarRect.Top := GetTopCoord;
      FHeaderHeight := CaptionHeight + ShadowSize.Top;
      VCenter := FHeaderHeight - ActualTitleHeight div 2;
      // Center of header (vertical)
      if (Form.WindowState = wsMaximized) and (ExTitleHeight <> ExMaxHeight) then
        OffsetRect(FIconRect, 0, (ExTitleHeight - ExMaxHeight) div 2 - 2)
      else
        VCenter := VCenter + ExCenterOffs;
    end
    else begin
      VCenter := CaptionHeight div 2;
      if IsZoomed(Form.Handle) then
        if (acWinVer >= 8) and (BorderForm <> nil) then // If Windows 10
          FBarRect.Top := ac_CXSIZEFRAME - 1 + 4
        else
          FBarRect.Top := ac_CXSIZEFRAME - 1
      else
        FBarRect.Top := 0;
      // Height of (Caption + Border + TopShadow)
      FHeaderHeight := CaptionHeight + SysBorderHeight(Form.Handle, BorderForm) + ShadowSize.Top;
      inc(VCenter, SysBorderWidth(Form.Handle, nil) div 2);
    end;
    if IsZoomed(Form.Handle) then
      inc(VCenter, 2);
    // Calc Icon Rect
    FIconRect.Left := SysBorderWidth(Form.Handle, BorderForm) + BILeftMargin + ShadowSize.Left;
    if IconVisible then begin
      FIconRect.Right := FIconRect.Left + TitleIconWidth(Self);
      FIconRect.Top := VCenter - TitleIconHeight(Self) div 2;
      FIconRect.Bottom := FIconRect.Top + TitleIconHeight(Self);
    end
    else
      FIconRect.Right := FIconRect.Left; // Icon is not shown

    // Calc sys buttons and right offset of bar
    i := 1;
    FullRight := CaptionWidth - BIRightMargin - ShadowSize.Right - Max(4, SysBorderWidth(Form.Handle, BorderForm));
    if not BigButtons then
      inc(FullRight, min(0, DiffBorder(BorderForm) - 2));

    FBarRect.Right := FullRight;
    if Assigned(SystemMenu) and HaveSysMenu then begin
      // Close button
      ProcSysButton(ButtonClose, i);
      // Max button
      if SystemMenu.VisibleMax then begin
        ButtonMax.ImageIndex := iff(Form.WindowState <> wsMaximized, SkinData.SkinManager.ConstData.MaskMaxBtn, SkinData.SkinManager.ConstData.MaskNormBtn);
        ProcSysButton(ButtonMax, i);
      end
      else
        ButtonMax.Rect.Right := ButtonMax.Rect.Left; // Is not shown
      // Min button
      if SystemMenu.VisibleMin then begin
        ButtonMin.ImageIndex := iff((Form.WindowState = wsMinimized) and IsIconic(Form.Handle) and (Application.MainForm <> Form), FCommonData.SkinManager.ConstData.MaskNormBtn, FCommonData.SkinManager.ConstData.MaskMinBtn); // If form is minimized then changing to Normalize
        ProcSysButton(ButtonMin, i);
      end
      else
        ButtonMin.Rect.Right := ButtonMin.Rect.Left; // Is not shown

      if biHelp in Form.BorderIcons then begin
        dec(FBarRect.Right, 6); // Spacing between help button and others
        ProcSysButton(ButtonHelp, i);
      end
      else
        ButtonHelp.Rect.Right := ButtonHelp.Rect.Left; // Is not shown
    end
    else
      ButtonClose.Rect.Right := ButtonClose.Rect.Left; // Is not shown

    if TitleButtons.Count > 0 then begin
      FBarRect.Right := FBarRect.Right - UserButtonsOffset; // Spacing between old buttons and others
      mi := UserBtnIndex;
      Index := 0;
      for i := 0 to TitleButtons.Count - 1 do
        if TitleButtons.Items[i].Visible then begin
          TitleButtons.Items[i].Data.Rect.Right := FBarRect.Right;
          TitleButtons.Items[i].Data.ImageIndex := iff(TitleButtons.Items[i].UseSkinData and FCommonData.SkinManager.IsValidImgIndex(mi), mi, -1);
          ProcSysButton(TitleButtons.Items[i].Data, Index, TitleButtons.Items[i]);
                        TitleButtons.Items[i].Data.HitCode := HTUDBTN + i;
        end;
    end;
    // Init the TacTitleBar component if defined
    if Assigned(FTitleBar) then begin
      Bar := TacAccessTitleBar(FTitleBar);
      Bar.FFullRight := FullRight;
      Bar.FBarRect.Left := FIconRect.Right;
      if FIconRect.Right <> FIconRect.Left then
        for i := 0 to Bar.Items.Count - 1 do
          if Bar.Items[i].Visible and (Bar.Items[i].Align = tbaLeft) then begin
            inc(Bar.FBarRect.Left, UserButtonsOffset);
            Break;
          end;

      Bar.FBarRect.Top := GetTopCoord;
      Bar.FBarRect.Bottom := FHeaderHeight;
      Bar.FBarRect.Right := FBarRect.Right;
      Bar.FBarVCenter := VCenter;
      dec(Bar.FBarRect.Right, UserButtonsOffset); // Spacing between sys buttons and others
      FBarRect := Bar.FBarRect;
      FTitleBar.CalcSizes;
    end;
  end;
end;


procedure TsSkinProvider.PaintTitleItem(Item: TacTitleBarItem; R: TRect; Bmp: TBitmap);
var
  ts: TSize;
  s: ACstring;
  gColor: TColor;
  Flags: Cardinal;
  sSection: string;
  sMan: TsSkinManager;
  bR, rText, rC: TRect;
  isd: PacItemSkinData;
  TmpBmp, DstBmp: TBitmap;
  x, y, h, n, sIndex, gSize, iState: integer;

  procedure PaintContent(R: TRect);
  var
    DownSize, ArrowSize, cSize, ImgNdx: integer;
    C: TColor;
  begin
    if Item.Caption <> '' then begin
      s := Item.Caption;
      ts := GetStringSize(DstBmp.Canvas.Font.Handle, s);
    end
    else
      ts := MkSize;

    if (Item.Style in [bsMenu, bsButton]) and (Item.DropDownMenu <> nil) then begin
      ArrowSize := 1 + 3 * integer(Item.Style = bsMenu);
      DownSize := GetStringSize(DstBmp.Canvas.Font.Handle, 'W').cx;
    end
    else begin
      ArrowSize := 0;
      DownSize := 0;
    end;

    C := clNone;
    if not Item.Enabled or not Form.Enabled then
      ImgNdx := Item.DisabledImageIndex
    else
      case Item.State of
        0: begin
          ImgNdx := Item.ImageIndex;
          if SkinData.SkinManager.Effects.DiscoloredGlyphs then
            if sIndex >= 0 then
              C := SkinData.SkinManager.gd[sIndex].Props[0].Color
            else
              C := iff(FTitleSkinIndex >= 0, SkinData.SkinManager.gd[FTitleSkinIndex].Props[0].Color, $FFFFFF);
        end;

        1:
          ImgNdx := Item.HotImageIndex

        else
          ImgNdx := Item.PressedImageIndex;
      end;

    if ImgNdx < 0 then
      ImgNdx := Item.ImageIndex;

    case Item.Alignment of
      taLeftJustify:
        x := R.Left + FTitleBar.ItemsMargin + Item.IntXMargin;

      taCenter: begin
        if Assigned(FTitleBar.Images) and Between(ImgNdx, 0, GetImageCount(FTitleBar.Images) - 1) then
          cSize := FTitleBar.Images.Width + Item.Spacing * integer(ts.cx > 0)
        else
          if Assigned(Item.Glyph) and not Item.Glyph.Empty then
            cSize := Item.Glyph.Width + Item.Spacing * integer(ts.cx > 0)
          else
            cSize := 0;

        x := R.Left + (Item.Width - cSize - ts.cx - ArrowSize - DownSize) div 2;
      end;

      taRightJustify: begin
        if Assigned(FTitleBar.Images) and Between(ImgNdx, 0, GetImageCount(FTitleBar.Images) - 1) then
          cSize := FTitleBar.Images.Width + Item.Spacing * integer(ts.cx > 0)
        else
          if Assigned(Item.Glyph) and not Item.Glyph.Empty then
            cSize := Item.Glyph.Width + Item.Spacing * integer(ts.cx > 0)
          else
            cSize := 0;

        x := R.Left + (Item.Width - cSize - ts.cx - ArrowSize - DownSize);
      end;
    end;

    if Assigned(FTitleBar.Images) and Between(ImgNdx, 0, GetImageCount(FTitleBar.Images) - 1) then begin
      y := R.Top + (Item.Height - FTitleBar.Images.Height) div 2;
      if FTitleBar.Images is TsAlphaImageList then
        DrawAlphaImgList(FTitleBar.Images, DstBmp, x, y, ImgNdx, 0, C, 0, 1, False)
      else
        FTitleBar.Images.Draw(DstBmp.Canvas, x, y, ImgNdx);

      inc(x, integer(Item.Caption <> '') * Item.Spacing + FTitleBar.Images.Width);
    end
    else
      if Assigned(Item.Glyph) and not Item.Glyph.Empty then begin
        y := R.Top + (Item.Height - Item.Glyph.Height) div 2;
        Item.Glyph.Transparent := True;
        Item.Glyph.TransparentColor := Item.Glyph.Canvas.Pixels[0, 0];
        if Item.Glyph.PixelFormat = pf32bit then
          CopyBmp32(Rect(x, y, x + Item.Glyph.Width, y + Item.Glyph.Height),
                    MkRect(Item.Glyph), DstBmp, Item.Glyph, EmptyCI, False, C, 0, False)
        else
          DstBmp.Canvas.Draw(x, y, Item.Glyph);

        inc(x, integer(Item.Caption <> '') * Item.Spacing + Item.Glyph.Width);
      end;

    rText := R;
    rText.Left := x;
    Flags := DT_LEFT or {DT_VCENTER or }DT_SINGLELINE or DT_END_ELLIPSIS;
    if Item.Caption <> '' then begin
//      s := Item.Caption;
//      ts := GetStringSize(DstBmp.Canvas.Font.Handle, s);
      y := Item.Height - ts.cy;
      rText.Top := R.Top + y div 2;
      rText.Bottom := rText.Bottom + ts.cy;
      if gSize <> 0 then
        acDrawGlowForText(DstBmp, PacChar(s), rText, Flags, BF_RECT, gSize, gColor, Item.FontData.GlowMask);

      WriteText32(DstBmp, PacChar(s), Form.Enabled, rText, Flags, sIndex, boolean(iState), sMan);
    end;
    if (ArrowSize <> 0) then begin
      rText.Left := rText.Left + ts.cx + ArrowSize;
      s := acDownChar;
      DstBmp.Canvas.Font.Name := acDownFont;
      DstBmp.Canvas.Font.Charset := DEFAULT_CHARSET;
      ts := GetStringSize(DstBmp.Canvas.Font.Handle, s);
      y := Item.Height - ts.cy;
      rText.Top := R.Top + y div 2;
      rText.Bottom := rText.Bottom + ts.cy;
      if gSize <> 0 then
        acDrawGlowForText(DstBmp, PacChar(s), rText, Flags, BF_RECT, gSize, gColor, Item.FontData.GlowMask);

      WriteText32(DstBmp, PacChar(s), Form.Enabled, rText, Flags, sIndex, boolean(iState), sMan);
    end;
  end;

  procedure PaintItemSection(sIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer;
                             R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TObject = nil);
  var
    LayeredWndMode: boolean;
    DrawState: integer;
  begin
    with TsSkinManager(SkinManager) do
      if IsValidSkinIndex(sIndex) then begin
        LayeredWndMode := True;
        DrawState := min(min(State, gd[sIndex].States), ac_MaxPropsIndex);
        if gd[sIndex].Props[DrawState].Transparency = 100 then
          if gd[sIndex].BorderIndex < 0 then
            LayeredWndMode := False
          else
            if State = 0 then
              LayeredWndMode := ma[gd[sIndex].BorderIndex].DrawMode and BDM_ACTIVEONLY <> BDM_ACTIVEONLY;

        if not LayeredWndMode then
          PaintItem(sIndex, ci, Filling, State, R, pP, ItemBmp.Canvas.Handle, SkinManager)
        else
          PaintItem32(sIndex, Filling, State, R, pP, ItemBmp, SkinManager);
      end;
  end;

begin
  h := Item.Height;
  bR := R;
  sMan := SkinData.SkinManager;
  if Item.Data = nil then
    Exit;

  isd := PacItemSkinData(Item.Data);
  sIndex := isd^.SkinIndex;
  if sIndex >= Length(sMan.gd) then
    Exit;
  
  sSection := isd^.SkinSection;
  if Item.Enabled and Form.Enabled then
    DstBmp := Bmp
  else begin
    DstBmp := TBitmap.Create;
    DstBmp.Assign(Bmp); // Copy an image for disabled (semitransparent Btn drawing)
  end;

  if Item.ContentSize.cx = 0 then
    Item.UpdateSize(not Item.AutoSize);

  DstBmp.Canvas.Font.Assign(Item.FontData.UsedFont);
  if sIndex >= 0 then
    iState := min(Item.State, min(sMan.gd[sIndex].States - 1, ac_MaxPropsIndex))
  else
    iState := 0;

  if not Item.FontData.UseSysColor then
    DstBmp.Canvas.Font.Color := Item.FontData.Font.Color
  else
    if sMan.IsValidSkinIndex(sIndex) then
      DstBmp.Canvas.Font.Color := sMan.gd[sIndex].Props[iState].FontColor.Color;

  if not Item.FontData.UseSysFontName then
    DstBmp.Canvas.Font.Name := Item.FontData.Font.Name;

  if not Item.FontData.UseSysGlowing then begin
    gSize  := Item.FontData.GlowSize;
    gColor := Item.FontData.GlowColor;
  end
  else
    if sMan.IsValidSkinIndex(sIndex) then begin
      gSize := min(48, sMan.gd[sIndex].Props[iState].GlowSize);
      gColor := sMan.gd[sIndex].Props[iState].GlowColor;
    end
    else begin
      gSize  := 0;
      gColor := 0;
    end;

  if not Item.FontData.UseSysSize then
    DstBmp.Canvas.Font.Height := Item.FontData.Font.Height;

  if not Item.FontData.UseSysStyle then
    DstBmp.Canvas.Font.Style := Item.FontData.Font.Style;

  if ac_UseSysCharSet then
    DstBmp.Canvas.Font.Charset := GetDefFontCharSet
  else
    DstBmp.Canvas.Font.Charset := Form.Font.Charset;

  // Clear bmp for a layered window
  if FCommonData.FCacheBmp <> Bmp then
    FillRect32(DstBmp, bR, 0, 0);

  case Item.Style of
    bsMenu:
      if sIndex < 0 then begin
        n := HeightOf(FTitleBar.BarRect) - 2;
        if h > n then begin
          h := n;
          bR.Bottom := bR.Top + h;
        end;
        TmpBmp := FTitleBar.FDefaultMenuBtn;
        rC.Left := Item.State * (TmpBmp.Width div 3);
        rC.Top := 0;
        rC.Right := rC.Left + (TmpBmp.Width div 3);
        rC.Bottom := TmpBmp.Height;
        PaintItemNoAlpha(DstBmp, FTitleBar.FDefaultMenuBtn, bR, rC, Rect(8, 2, 8, 4));
        // Init default font props
        if Item.FontData.UseSysColor then
          DstBmp.Canvas.Font.Color := clWhite;

        if Item.FontData.UseSysGlowing then begin
          gSize := 2;
          gColor := $000E5A8D;
        end;
      end
      else // Section is defined in a skin
        PaintItemSection(sIndex, {sSection, }MakeCacheInfo(SkinData.FCacheBmp), True, Item.State, bR, Item.Rect.TopLeft{ bR.TopLeft}, DstBmp, {False, }sMan);

    bsTab: begin
      iState := min(Item.State, 1);
      n := HeightOf(FTitleBar.BarRect) - 2;
      if h > n then begin
        h := n;
        bR.Top := bR.Bottom - h;
      end;
      if sIndex >= 0 then begin
        if not Item.Down then begin
          InflateRect(bR, 0, -1);
          OffsetRect(bR, 0, 1);
        end;
        PaintItemsection(sIndex, MakeCacheInfo(Bmp), True, Item.State, bR, bR.TopLeft, DstBmp, sMan);
        if Item.FontData.UseSysGlowing then begin
          gSize  := sMan.gd[sIndex].Props[min(iState, ac_MaxPropsIndex)].GlowSize;
          gColor := sMan.gd[sIndex].Props[min(iState, ac_MaxPropsIndex)].GlowColor;
        end
      end;
      // Align content to center
      bR.Left := bR.Left + (WidthOf(bR) - Item.ContentSize.cx - 1) div 2;
      bR.Right := bR.Left + Item.ContentSize.cx;
    end;

    bsInfo, bsButton: begin
      PaintItemsection(sIndex, MakeCacheInfo(Bmp), True, Item.State, bR, bR.TopLeft, DstBmp, sMan);
      // Init default font props
      if (Item.SkinSection = '') and (Item.State = 0) then begin // Get font color from title if button is not active
        iState := integer(FormActive);
        if Item.FontData.UseSysColor and (FTitleSkinIndex >= 0) and (FTitleSkinIndex < Length(sMan.gd)) then
          DstBmp.Canvas.Font.Color := sMan.gd[FTitleSkinIndex].Props[min(iState, ac_MaxPropsIndex)].FontColor.Color
        else
          DstBmp.Canvas.Font.Color := 0;

        if Item.FontData.UseSysGlowing and (FTitleSkinIndex >= 0) and (FTitleSkinIndex < Length(sMan.gd)) then begin
          gSize  := sMan.gd[FTitleSkinIndex].Props[min(iState, ac_MaxPropsIndex)].GlowSize;
          gColor := sMan.gd[FTitleSkinIndex].Props[min(iState, ac_MaxPropsIndex)].GlowColor;
        end
        else begin
          gSize  := 0;
          gColor := 0;
        end;
        sIndex := FTitleSkinIndex;
      end;
    end

    else
      iState := integer(FormActive);
  end;
  PaintContent(bR);
  if not Item.Enabled or not Form.Enabled then begin
    SumBmpRect(Bmp, DstBmp, 128, R, R.TopLeft);
    DstBmp.Free;
  end;
end;


procedure TsSkinProvider.UpdateTitleBar;
var
  i: integer;
  isd: PacItemSkinData;
  Defined: boolean;

  procedure UpdateItemIndex(i: integer);
  begin
    Defined := False;
    isd := PacItemSkinData(FTitleBar.Items[i].Data);
    isd^.SkinIndex := -1;
    // If custom skin section is defined
    if FTitleBar.Items[i].SkinSection <> '' then begin
      isd^.SkinSection := FTitleBar.Items[i].SkinSection;
      isd^.SkinIndex := SkinData.SkinManager.GetSkinIndex(isd^.SkinSection);
      if isd^.SkinIndex >= 0 then
        Defined := True;
    end;
    // Search default skin section
    if not Defined then
      case FTitleBar.Items[i].Style of
        bsButton: begin
          isd^.SkinSection := s_TBBTN;
          isd^.SkinIndex := SkinData.SkinManager.GetSkinIndex(isd^.SkinSection);
        end;
        bsMenu: begin
          isd^.SkinSection := s_TBMENUBTN;
          isd^.SkinIndex := SkinData.SkinManager.GetSkinIndex(isd^.SkinSection);
        end;
        bsTab: begin
          isd^.SkinSection := s_TBTAB;
          isd^.SkinIndex := SkinData.SkinManager.GetSkinIndex(isd^.SkinSection);
        end;
      end;

    Defined := isd^.SkinIndex >= 0;
    // Search skin section as replacement
    if not Defined then
      case FTitleBar.Items[i].Style of
        bsButton: begin
          isd^.SkinSection := s_ToolButton;
          isd^.SkinIndex := SkinData.SkinManager.GetSkinIndex(isd^.SkinSection);
        end;
        bsTab: begin
          isd^.SkinSection := s_TabTop;
          isd^.SkinIndex := SkinData.SkinManager.ConstData.Tabs[tlSingle][asTop].SkinIndex;
        end;
      end;
  end;

begin
  if Assigned(FTitleBar) then
    for i := 0 to FTitleBar.Items.Count - 1 do begin
      if FTitleBar.Items[i].Data = nil then begin
        isd := new(PacItemSkinData);
        isd^ := TacItemSkinData.Create;
        FTitleBar.Items[i].Data := @(TObject(isd^));
      end;
      UpdateItemIndex(i);
      FTitleBar.Items[i].OnDrawItem := PaintTitleItem;
    end;
end;


function TsSkinProvider.GetTopCoord: integer;
begin
  if (BorderForm <> nil) then
    with FCommonData.SkinManager.CommonSkinData do
      if IsZoomed(Form.Handle) then begin
        Result := ShadowSize.Top + 4;
//        if (ExMaxHeight <> 0) and (ExMaxHeight <> ExTitleHeight) then
//          inc(Result, max(0, ExTitleHeight - ExMaxHeight));
      end
      else
        Result := ShadowSize.Top + BITopMargin
  else
    Result := integer(IsZoomed(Form.Handle)) * 6;
end;


function TsSkinProvider.ActualTitleHeight(Max: boolean = False): integer;
begin
  with FCommonData.SkinManager.CommonSkinData do
    Result := iff(Max or (ExMaxHeight <> 0) and IsZoomed(Form.Handle), ExMaxHeight, ExTitleHeight);
end;


procedure TsSkinProvider.SetTitleBar(const Value: TsTitleBar);
begin
  if FTitleBar <> Value then begin
    FTitleBar := Value;
    UpdateSkinCaption(Self);
  end;
end;


procedure TsSkinProvider.InitLabel(const Control: TControl; const Skinned: boolean);
var
  Ndx, FoundNdx, l: integer;
begin
  if Control is TCustomLabel then
    with TLabel(Control) do begin
      FoundNdx := -1;
      l := Length(SavedLabelColors);
      for Ndx := 0 to l - 1 do
        if SavedLabelColors[Ndx].Control = Control then begin
          FoundNdx := Ndx;
          Break;
        end;

      if Skinned then begin
        if Tag and ExceptTag <> ExceptTag then begin
          if FoundNdx < 0 then begin
            SetLength(SavedLabelColors, l + 1);
            SavedLabelColors[l].Control := Control;
            SavedLabelColors[l].Color := TLabel(Control).Font.Color;
            SavedLabelColors[l].ParentFont := ParentFont;

            if Transparent or SkinData.SkinManager.LabelsOptions.TransparentAlways then
              ControlStyle := ControlStyle - [csOpaque];
          end;
          // Otherwise, just change a color when skin is changed
          Font.Color := DefaultManager.GetGlobalFontColor;
        end;
      end
      else begin
        // If control was found in the array
        if FoundNdx >= 0 then begin
          if SavedLabelColors[FoundNdx].ParentFont then begin
            if not ParentFont then
              ParentFont := True
            else
              if Parent <> nil then
                Font.Color := TsHackedControl(Parent).Font.Color;
          end
          else
            Font.Color := SavedLabelColors[FoundNdx].Color;
          // Remove array item
          SavedLabelColors[FoundNdx].Color   := SavedLabelColors[l - 1].Color;
          SavedLabelColors[FoundNdx].Control := SavedLabelColors[l - 1].Control;
          SetLength(SavedLabelColors, l - 1);
        end;
          
        if Transparent or SkinData.SkinManager.LabelsOptions.TransparentAlways then
          ControlStyle := ControlStyle + [csOpaque];
      end;
    end;
end;


procedure RepaintHeadCtrl(Ctrl: TControl; Data: integer);
begin
  if (Ctrl is TWinControl) then begin
    if not (csDestroying in Ctrl.ComponentState) and TWinControl(Ctrl).HandleAllocated then begin
      SendMessage(TWinControl(Ctrl).Handle, SM_ALPHACMD, MakeWParam(1, Word(AC_UPDATING)), 0);
      SendMessage(TWinControl(Ctrl).Handle, SM_ALPHACMD, MakeWParam(1, Word(AC_SETBGCHANGED)), 0);
    end;
  end
  else begin
    Ctrl.Perform(SM_ALPHACMD, MakeWParam(1, Word(AC_UPDATING)), 0);
    Ctrl.Perform(SM_ALPHACMD, MakeWParam(1, Word(AC_SETBGCHANGED)), 0);
  end;
end;


procedure TsSkinProvider.AC_WMNCActivate(var Message: TWMNCActivate);
var
  R: TRect;
begin
  if (FormState and FS_ANIMRESTORING = FS_ANIMRESTORING) then
    Exit;

  ClearGlows(False);
  if not (csDestroying in ComponentState) and DrawNonClientArea and Form.HandleAllocated then begin
    if Form.Showing and HeaderUsed then
      sVCLUtils.IterateControls(Form, FormHeader.AdditionalHeight, RepaintHeadCtrl);

    if SystemMenu = nil then
      PrepareForm; // If not intitialized (occurs when Scaled = False)

    FormState := FormState or FS_ACTIVATE;
    if FormState and FS_BLENDMOVING <> FS_BLENDMOVING then
      FormActive := TWMNCActivate(Message).Active;

    if not FormActive and (ShowAction = saMaximize) then // <<<<< Caption blinking removing
      ShowAction := saIgnore
    else
      if not (ShowAction = saMaximize) then begin
        // Check if cache changing is not required
        if SkinData.SkinIndex >= 0 then begin
          if SkinData.BorderIndex >= 0 then begin
            if (SkinData.SkinManager.ma[SkinData.BorderIndex].ImageCount > 1) or (SkinData.SkinManager.gd[SkinData.SkinIndex].States > 1) then
              FCommonData.BGChanged := True;
          end
          else
            if (SkinData.SkinManager.gd[SkinData.SkinIndex].States > 1) then
              FCommonData.BGChanged := True;
        end
        else
          FCommonData.BGChanged := True;

        FCommonData.FUpdating := False;
      end
      else
        FCommonData.FUpdating := BorderForm = nil; // >>>>> Caption blinking removing

    if Form.Showing and IsWindowVisible(Form.Handle) then begin
      if FormActive <> (TWMActivate(Message).Active <> WA_INACTIVE) then
        FCommonData.BGChanged := True;

      if AeroIsEnabled then begin
        if (BorderForm = nil) then
{$IFDEF D2007}
          if InAero or Application.MainFormOnTaskBar and (Form <> Application.MainForm) and (Application.MainForm <> nil) and (Application.MainForm.WindowState = wsMinimized) then
          else
{$ENDIF}
            ProcessMessage(WM_SETREDRAW, 0, 0)
        else
          if (SkinData.FCacheBmp <> nil) and (GetLinesCount > 0) then begin // Menu line hiding
            if BorderForm.AForm = nil then
              BorderForm.CreateNewForm;

            SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
{$IFDEF DELPHI7UP}
            if Form.AlphaBlend then
              SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, Form.AlphaBlendValue)
            else
{$ENDIF}
              SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, MaxByte);

            SetWindowPos(BorderForm.AForm.Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
          end;

        if not fAnimating and ((BorderForm = nil) or IsMenuVisible(Self)) and not Assigned(Form.OnPaint) {Problem with specifically handled events} then begin
//          SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_VISIBLE); // Borders blinking removing
          MakeCaptForm(Self);
        end;
      end
      else
        if fAnimating then begin
          if RTInit then
            ProcessMessage(WM_SETREDRAW, 0, 0)
        end
        else
          if not (fsShowing in Form.FormState) {not FormActive} and ((BorderForm = nil) or IsMenuVisible(Self)) and not Assigned(Form.OnPaint) {Problem with specifically handled events} then
            MakeCaptForm(Self);

      if (BorderForm <> nil) and not fAnimating and (FormState and FS_BLENDMOVING <> FS_BLENDMOVING) and not AeroIsEnabled then // Forbid a borders painting by system
        UpdateRgn(Self, False);

      OldWndProc(TMessage(Message));

      if AeroIsEnabled then begin
        if (BorderForm = nil) then begin
{$IFDEF D2007}
          if InAero or Application.MainFormOnTaskBar and (Form <> Application.MainForm) and (Application.MainForm <> nil) and (Application.MainForm.WindowState = wsMinimized) then begin
//            if not fAnimating then
//              SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_VISIBLE); // Returning visibility
          end
          else
{$ENDIF}
          begin
            ProcessMessage(WM_SETREDRAW, 1, 0);
//            if not fAnimating then
//              SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_VISIBLE); // Returning visibility

            RedrawWindow(Form.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_UPDATENOW or RDW_NOERASE);
          end;
        end;
        if not fAnimating then begin
          ProcessMessage(WM_NCPAINT);
          KillCaptForm(Self);
        end;
      end
      else begin
        if fAnimating or RTInit then
          ProcessMessage(WM_SETREDRAW, 1, 0)
        else
          if (BorderForm = nil) or IsMenuVisible(Self) then begin
            RedrawWindow(Form.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_NOERASE or RDW_FRAME);
            KillCaptForm(Self);
          end;

        if RTInit then
          RedrawWindow(Form.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_ERASE or RDW_INVALIDATE);
      end;
    end
    else
      OldWndProc(TMessage(Message));

    if Assigned(Form) and
         (Form.Visible) and
           (Form.FormStyle = fsMDIChild) and
             (fsCreatedMDIChild in Form.FormState) and
               (fsshowing in Form.FormState) and
                 Assigned(MDISkinProvider) and
                   Assigned(TsSkinProvider(MDISkinProvider).MDIForm) then begin
      TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
      TsSkinProvider(MDISkinProvider).FLinesCount := -1;
      TsMDIForm(TsSkinProvider(MDISkinProvider).MDIForm).UpdateMDIIconItem;

      SendMessage(TsSkinProvider(MDISkinProvider).Form.Handle, WM_NCPAINT, 0, 0);
      SendMessage(TsSkinProvider(MDISkinProvider).Form.ClientHandle, WM_NCPAINT, 0, 0);
    end;
    if (GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = WS_EX_LAYERED) and (FormTimer = nil) then
      ProcessMessage(WM_NCPAINT);

    if (csCreating in Form.ControlState) then Exit;

    if HaveBorder(Self) and (FormState and FS_BLENDMOVING <> FS_BLENDMOVING) then
      if MDIButtonsNeeded then begin
        if (TWMActivate(Message).Active <> WA_INACTIVE) or (Form.ActiveMDIChild.Active) then begin
          FormActive := (TWMActivate(Message).Active <> WA_INACTIVE) or (Form.ActiveMDIChild.Active);
          FLinesCount := -1;
        end;
      end
      else
        if FormActive <> (TWMActivate(Message).Active <> WA_INACTIVE) then begin
          FormActive := (TWMActivate(Message).Active <> WA_INACTIVE);
          FLinesCount := -1;
        end;

    FormState := FormState and not FS_ACTIVATE;
    if ((FormTimer = nil) or not FormTimer.Enabled {and DrawNonClientArea}) then begin
      // If size of form is not initialized yet (wsMaximized)
      GetWindowRect(Form.Handle, R);
      if (WidthOf(R) = Form.Width) or (HeightOf(R) = Form.Height) then begin
        ProcessMessage(WM_NCPAINT);
        if (BorderForm <> nil) then
          case Form.WindowState of
            wsMaximized:
              if SkinData.SkinManager.Options.NativeBordersMaximized then begin
                FreeAndNil(BorderForm);
                UpdateRgn(Self, False);
              end
              else {if Form.Menu <> nil then }
                BorderForm.UpdateExBordersPos;

            wsNormal:
              if (FormTimer = nil) or (FormTimer is TacMinTimer) and (TacMinTimer(FormTimer).StepCount > 1) then
                BorderForm.UpdateExBordersPos;
          end;
      end;
    end{
    else
      if (FormTimer is TacMinTimer) and (TacMinTimer(FormTimer).AnimForm <> nil) then begin
        FreeAndNil(TacMinTimer(FormTimer).AnimForm);
        SkinData.BGChanged := True;
        UpdateSkinCaption(Self);
      end};

    TryInitMenu;
    if FCommonData.Skinned and (Adapter = nil) then
      AdapterCreate;
  end
  else
    OldWndProc(TMessage(Message));
end;


procedure TsSkinProvider.AC_WMActivate(var Message: TWMActivate);
begin
//  if (FormState and FS_DISABLED = FS_DISABLED) and (Message.Active = 1) then
//    Exit;
    
  OldWndProc(TMessage(Message));
  if (Form <> nil) and Form.Showing then begin
    if (ListSW = nil) {and FDrawNonClientArea }then
      RefreshFormScrolls(Self, ListSW, False);

    if not (csCreating in Form.ControlState) then begin
      FLinesCount := -1;
      if TMessage(Message).WParamLo = 1 then begin
{$IFNDEF FPC}
        if not (csDesigning in SkinData.SkinManager.ComponentState) then
          InitMenuItems(SkinData.Skinned); // Update after skinning in run-time
{$ENDIF}
        if Assigned(SystemMenu) then
          SystemMenu.UpdateItems;

        if not DrawNonClientArea then
          FCommonData.FUpdating := False;

        if (Form.BorderStyle = bsNone) then
          SetParentUpdated(Form);
      end;
      if HeaderUsed then
        SetParentUpdated(Form);
    end;
  end;
  UpdateSlaveFormsList;
end;


procedure TsSkinProvider.AC_WMWindowPosChanging( var Message: TWMWindowPosChanging);
var
  cR: TRect;
{$IFNDEF NOWNDANIMATION}
  i: integer;
{$ENDIF}
begin
  if not RgnChanging and not (csLoading in Form.ComponentState) then
    with TWMWindowPosChanged(Message) do begin
      if Form.HandleAllocated and
           not IsZoomed(Form.Handle) and
             (WindowPos.Flags and SWP_NOMOVE <> SWP_NOMOVE) and
               ((WindowPos^.X <> 0) or (WindowPos^.Y <> 0)) then

        with WindowPos^ do begin
          if SkinData.SkinManager.Options.NativeBordersMaximized and (Form.WindowState = wsNormal) and (BorderForm = nil) and ExtBordersNeeded(Self) and Form.HandleAllocated and IsWindowVisible(Form.Handle) then
            Self.InitExBorders(True);

          if FScreenSnap and Form.Showing then
            CheckNewPosition(X, Y);

          if FormState and FS_MAXBOUNDS <> 0 then begin
            cR := NormalBounds;
            if FormState and FS_MAXHEIGHT = FS_MAXHEIGHT then begin
              if Form.Top = WindowPos^.Y then begin
                WindowPos^.Y := NormalBounds.Top;
                WindowPos^.cy := WindowPos^.cy - (NormalBounds.Top - Form.Top);
              end
              else
                WindowPos^.cy := NormalBounds.Top + NormalBounds.Bottom;

              FormState := FormState and not FS_MAXHEIGHT;
            end;
            if FormState and FS_MAXWIDTH = FS_MAXWIDTH then
              FormState := FormState and not FS_MAXWIDTH;

            Message.Result := 0;
            Exit;
          end;
        end;
{$IFNDEF NOWNDANIMATION}
      if Assigned(SkinData.SkinManager) and acLayered and DrawNonClientArea then
        if not SkipAnimation then
          if ((WindowPos.Flags and SWP_HIDEWINDOW = SWP_HIDEWINDOW) or
               (TWindowPos(WindowPos^).x = -32000))
                 and (SkinData.FCacheBmp <> nil {it's possible under Aero}) then begin // Window will be hidden
            if not IsIconic(Form.Handle) then begin
              if (SkinData.SkinManager.ShowState <> saMinimize) then // Closing
                if FAllowAnimation and (SkinData.SkinManager.AnimEffects.FormHide.Active) and
                     SkinData.SkinManager.Effects.AllowAnimation and
                       (FormState and FS_ANIMCLOSING <> FS_ANIMCLOSING) and
                         (Form.Parent = nil) then begin

                  // Preparing for a hiding animation
                  FormState := FormState or FS_ANIMCLOSING;
                  SkinData.FCacheBmp := GetFormImage(Self, True);
                  if BorderForm <> nil then begin
                    BorderForm.ExBorderShowing := True;
  {$IFDEF DELPHI7UP}
                    if Form.AlphaBlend then
                      i := Form.AlphaBlendValue
                    else
  {$ENDIF}
                      i := MaxByte;

                    SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
                    SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, i);
                    SetWindowPos(BorderForm.AForm.Handle, 0, BorderForm.AForm.Left, BorderForm.AForm.Top, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
                    SendOwnerToBack;
                  end
                  else
                    CoverForm := MakeCoverForm(Form.Handle);
                end;
            end
            // If minimized by Aero shake, but wnd is visible still
            else
              if (Form.WindowState <> wsMinimized) and not IsIconic(Form.Handle) and (TWindowPos(WindowPos^).x = -32000) then begin
                OldWndProc(TMessage(Message));
                StartMinimizing(Self);
                Form.WindowState := wsMinimized;
                Exit;
              end;
          end
          else
            if (WindowPos.Flags and SWP_SHOWWINDOW = SWP_SHOWWINDOW) then
              if (BorderForm <> nil) and (BorderForm.AForm = nil) then begin // Update after showing by SWP_SHOW (in ScaleBy)
                BorderForm.CreateNewForm;
                BorderForm.ExBorderShowing := False;
                BorderForm.UpdateExBordersPos();
              end;
    end
    // Resizing of form
    else begin
      FormState := FormState and not FS_ANIMCLOSING;
      with TWMWindowPosChanging(Message) do
        if (BorderForm <> nil) and
             (BorderForm.AForm <> nil) and
               (WindowPos^.cx <> 0) and
                 (WindowPos^.cy <> 0) and
                   (WindowPos.Flags and SWP_NOACTIVATE = SWP_NOACTIVATE) and
                     (FormState and FS_ANIMMINIMIZING <> FS_ANIMMINIMIZING) and
                       (WindowPos.Flags and SWP_NOMOVE <> SWP_NOMOVE) and
                         (WindowPos.Flags and SWP_NOSIZE <> SWP_NOSIZE) then
          if ((WindowPos^.cx < LastClientRect.Right) or (WindowPos^.cy < LastClientRect.Bottom)) and
               ((ListSW = nil) or (not ListSW.sBarVert.fScrollVisible and not ListSW.sBarHorz.fScrollVisible)) and
                 BorderForm.AForm.HandleAllocated then
            if not IsIconic(Form.Handle) then begin
              FormState := FormState or FS_SIZING;
              SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn(WindowPos^.cx, WindowPos^.cy), False);
              if BorderForm.AForm <> nil then
                SetWindowPos(Form.Handle, BorderForm.AForm.Handle, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);

              FormState := FormState and not FS_SIZING;
            end
            else begin
              SkinData.BGChanged := True;
              BorderForm.UpdateExBordersPos(True);
            end;
{$ENDIF}
    end;

  OldWndProc(TMessage(Message));
end;


const
  StateFlags: array [boolean] of WParam = (SC_MAXIMIZE, SC_RESTORE);


procedure TsSkinProvider.AC_WMLButtonUp(var Message: TWMNCLButtonUp);
var
  p: TPoint;
  hTest: Longint;
  m: TWMNCHitTest;
  Item: TacTitleBarItem;
begin
  if FDrawNonClientArea and Form.Enabled then begin
    if (BorderForm <> nil) and (Message.HitTest = HTTRANSPARENT) then
      Message.HitTest := BorderForm.Ex_WMNCHitTest(TWMNCHitTest(Message));

    case Message.HitTest of
      HTCLOSE:
        if (SystemMenu.EnabledClose and biClicked) then begin
          ButtonClose.State := 0;
          SendMessage(Form.Handle, WM_SYSCOMMAND, SC_CLOSE, 0);
          if csDestroying in Form.ComponentState then
            Exit;

          KillAnimations;
          if (Form <> nil) and Form.Visible then
            if FCommonData <> nil then begin
              FCommonData.BGChanged := True; // Clear cache if form closing was cancelled
              SetHotHT(0);
            end;
        end;

      HTMAXBUTTON:
        if (SystemMenu.EnabledMax or (Form.WindowState = wsMaximized) and SystemMenu.EnabledRestore) then 
          if biClicked then begin
            SetHotHT(0);
            RgnChanged := True;
            if Form.FormStyle = fsMDIChild then
              ChildProvider := nil;

            SendMessage(Form.Handle, WM_SYSCOMMAND, StateFlags[Form.WindowState = wsMaximized], 0);
            SystemMenu.UpdateItems;
            biClicked := False;
          end
          else begin
            SetHotHT(0);
            OldWndProc(TMessage(Message));
          end;

      HTMINBUTTON:
        if biClicked then begin
          if BorderForm <> nil then
            p := Point(Message.XCursor - BorderForm.AForm.Left, Message.YCursor - BorderForm.AForm.Top)
          else
            p := CursorToPoint(Message.XCursor, Message.YCursor);

          if PtInRect(ButtonMin.Rect, p) then begin
            SetHotHT(0);
            if (Application.MainForm = Form) then begin
              SkipAnimation := True;
              SendMessage(Form.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
              SkipAnimation := False;
            end
            else
              SendMessage(Form.Handle, WM_SYSCOMMAND, iff(IsIconic(Form.Handle), SC_RESTORE, SC_MINIMIZE), 0);

            FCommonData.BGChanged := True;
          end
          else
            OldWndProc(TMessage(Message));
        end
        else begin
          SetHotHT(0);
          OldWndProc(TMessage(Message));
        end;

      HTHELP:
        if biClicked then begin
          SendMessage(Form.Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
          SetHotHT(0);
          SystemMenu.UpdateItems;
          biClicked := False;
          Form.Perform(WM_NCPAINT, 0, 0);
        end
        else
          SetHotHT(0);

      // MDI child buttons
      HTCHILDCLOSE:
        if biClicked then begin
          biClicked := False;
          SendMessage(Form.ActiveMDIChild.Handle, WM_SYSCOMMAND, SC_CLOSE, 0);
          SetHotHT(0, False);
        end;

      HTCHILDMAX: begin
        if biClicked then
          SendMessage(Form.ActiveMDIChild.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
          
        biClicked := False;
        SetHotHT(0, False);
      end;

      HTCHILDMIN: begin
        if biClicked then begin
          TsSkinProvider(MDISkinProvider).FCommonData.BeginUpdate;
          biClicked := False;
          SendMessage(Form.ActiveMDIChild.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
        end;
        SetHotHT(0);
      end

      else
        if BetWeen(Message.HitTest, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin
          if biClicked then
            TitleButtons.Items[Message.HitTest - HTUDBTN].MouseUp(Message.HitTest - HTUDBTN, mbLeft, [], Message.XCursor, Message.YCursor);

          biClicked := False;
          SetHotHT(0);
        end
        else
          if BetWeen(Message.HitTest, HTITEM, HTITEM + MaxByte) then begin
            if biClicked and Assigned(FTitleBar) then begin
              Item := FTitleBar.Items[Message.HitTest - HTITEM];
              Item.State := 0; // Reset state
              Item.DoMouseUp(mbLeft, [], Message.XCursor, Message.YCursor);
              if not Item.Visible then begin
                if Assigned(Item.Timer) then
                  FreeAndNil(Item.Timer);
              end
              else
                if not Item.Down then begin
                  with acMousePos do begin
                    m.XPos := X;
                    m.YPos := Y;
                  end;
                  if (BorderForm <> nil) then
                    hTest := BorderForm.Ex_WMNCHitTest(m)
                  else
                    hTest := HTProcess(m);
                  // Button is hovered still
                  if hTest = Message.HitTest then begin
                    // Show animation to hot State
                    Item.State := 1;
                    if BorderForm <> nil then
                      StartItemAnimation(Item, 1, False, BorderForm.AForm)
                    else
                      StartItemAnimation(Item, 1, False);
                  end;
                  Item.State := 0;
                end;

              biClicked := False;
            end;
          end
          else
            if IsIconic(Form.Handle) then
              if Assigned(MDISkinProvider) then
                DropSysMenu(acMousePos.x + FormLeftTop.X, acMousePos.y)
              else
                OldWndProc(TMessage(Message))
            else
              if (ResizeMode = rmBorder) and Form.Enabled and (Form.WindowState <> wsMaximized) and bInProcess then begin
                // Common section
                p := Form.ClientToScreen(Point(Message.XCursor, Message.YCursor));
                StopMove(p.x, p.y);
                ReleaseCapture;
              end
              else
                OldWndProc(TMessage(Message));

      biClicked := False;
    end;
  end
  else
    OldWndProc(TMessage(Message));
end;


procedure TsSkinProvider.StartHintTimer(TitleItem: TacTitleBarItem);
begin
  if TitleItem.ShowHint and (TitleItem.Hint <> '') {and Form.ShowHint} then begin
    if FHintTimer = nil then
      FHintTimer := TTimer.Create(nil);

    FHintRect := TitleItem.Rect;
    if BorderForm <> nil then
      OffsetRect(FHintRect, BorderForm.AForm.Left, BorderForm.AForm.Top)
    else
      OffsetRect(FHintRect, Form.Left, Form.Top);

    FHintTimer.Tag := Integer(TitleItem);
    if Application.HintPause > 0 then begin
      FHintTimer.Interval := Application.HintPause;
      FHintTimer.OnTimer := OnHintTimer;
      FHintTimer.Enabled := True;
    end
    else
      ShowHintWnd(TacTitleBarItem(FHintTimer.Tag));
  end;
end;


procedure TsSkinProvider.OnHintTimer(Sender: TObject);
begin
  if (FHintTimer <> nil) and (FHintTimer.Tag <> 0) then begin
    FHintTimer.Enabled := False;
    if PtInRect(FHintRect, acMousePos) then
      ShowHintWnd(TacTitleBarItem(FHintTimer.Tag));
  end;
end;


procedure TsSkinProvider.AC_WMSize(var Message: TMessage);
var
  cR: TRect;
  acM: TMessage;
  X, Y, i: integer;
  UpdateClient: boolean;
begin
  KillAnimations;
  if not SkinData.FUpdating and IsWindowVisible(Form.Handle) and (FormState and FS_ANIMRESTORING <> FS_ANIMRESTORING) then
    with FCommonData.SkinManager do begin
      if IsGripVisible(Self) then
        if IsValidImgIndex(ConstData.GripRightBottom) then begin // If grip image is defined in skin
          X := WidthOfImage (ma[ConstData.GripRightBottom]);
          Y := HeightOfImage(ma[ConstData.GripRightBottom]);
          if (Form.ClientWidth > WidthOf(LastClientRect)) or (Form.ClientHeight > HeightOf(LastClientRect)) then
            if not IsCached(SkinData) then // Refresh rect where Grip was drawn
              if (WidthOf(LastClientRect) <> 0) then begin
                cR := Rect(LastClientRect.Right - X, LastClientRect.Bottom - Y, LastClientRect.Right, LastClientRect.Bottom);
                InvalidateRect(Form.Handle, @cR, not IsCached(FCommonData));
              end;

          if (Form.ClientWidth < WidthOf(LastClientRect)) or (Form.ClientHeight < HeightOf(LastClientRect)) then begin
            cR := Rect(Form.ClientWidth - X, Form.ClientHeight - Y, Form.ClientWidth, Form.ClientHeight);
            InvalidateRect(Form.Handle, @cR, not IsCached(FCommonData));
          end;
        end;

      if (Form.ClientWidth < WidthOf(LastClientRect)) or (Form.ClientHeight < HeightOf(LastClientRect)) or (WidthOf(LastClientRect) = 0) then begin
        i := GetMaskIndex(FCommonData.SkinIndex, s_ImgTopRight);
        if i > -1 then begin
          X := WidthOfImage (ma[i]);
          Y := HeightOfImage(ma[i]);
          cR := Rect(LastClientRect.Right - X, LastClientRect.Bottom - Y, LastClientRect.Right, LastClientRect.Bottom);
          InvalidateRect(Form.Handle, @cR, not IsCached(FCommonData));
        end;
        i := GetMaskIndex(FCommonData.SkinIndex, s_ImgBottomRight);
        if i > -1 then begin
          X := WidthOfImage (ma[i]);
          Y := HeightOfImage(ma[i]);
          cR := Rect(LastClientRect.Right - X, LastClientRect.Bottom - Y, LastClientRect.Right, LastClientRect.Bottom);
          InvalidateRect(Form.Handle, @cR, not IsCached(FCommonData));
        end;
      end;

      if Assigned(FGlow1) then
        FreeAndNil(FGlow1);

      if Assigned(FGlow2) then
        FreeAndNil(FGlow2);

      FLinesCount := -1;
  {$IFNDEF NOWNDANIMATION}
      if (FormState and FS_BLENDMOVING = FS_BLENDMOVING) then
        FinishBlendOnMoving(Self);
  {$ENDIF}

      if (Form.Parent = nil) and FDrawClientArea then begin
        FCommonData.FUpdating := True;
        OldWndProc(Message);
        FCommonData.FUpdating := False;
      end
      else
        OldWndProc(Message);

      if not InAnimationProcess then
        if Form.Showing then begin
          if FormChanged and (not (IsIconic(Form.Handle) and InAero)) then begin
            FCommonData.BGChanged := True;
            if FCommonData.FCacheBmp <> nil then
              UpdateClient := IsCached(FCommonData) and ((FCommonData.FCacheBmp.Width > Form.Width) or (FCommonData.FCacheBmp.Height > Form.Height))
            else
              UpdateClient := False;

            if FDrawNonClientArea then begin
              if SkinData.SkinManager.Options.NativeBordersMaximized and (Form.WindowState = wsMaximized) and (BorderForm <> nil) then
                FreeAndNil(BorderForm);
              // If can optimize (Pre-paint the form while is under the BorderForm)
              if (BorderForm <> nil) then begin // Update extended borders
                if BorderForm.AForm = nil then
                  BorderForm.CreateNewForm;

                if ((ListSW = nil) or
                     (not ListSW.sBarVert.fScrollVisible and not ListSW.sBarHorz.fScrollVisible)) and
                       (ResizeMode = rmStandard) then

                  FormState := FormState or FS_SIZING;

                BorderForm.UpdateExBordersPos; // If ExtBorder exists already
                FCommonData.FUpdating := True;
                FormState := FormState and not FS_SIZING;
                BorderForm.ExBorderShowing := True;
                // Move ExtBorder on top
                SetWindowPos(BorderForm.AForm.Handle, 0, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOREDRAW or SWP_NOSIZE or SWP_NOMOVE);
                SendOwnerToBack;
                BorderForm.ExBorderShowing := False;
                RgnChanged := True;
                UpdateRgn(Self, True, True);
                FCommonData.FUpdating := False;
              end
              else begin
                RgnChanged := True;
                FillArOR(Self);
                UpdateRgn(Self, True, True);
              end;

              if FCommonData.FUpdating then
                Exit;

              if (SkinData.BGType and BGT_GRADIENTVERT = BGT_GRADIENTVERT) and
                   (HeightOf(LastClientRect) <> Form.ClientHeight) or
                     (SkinData.BGType and BGT_GRADIENTHORZ = BGT_GRADIENTHORZ) and
                       (WidthOf(LastClientRect) <> Form.ClientWidth) or
                         (SkinData.BGType and BGT_STRETCH = BGT_STRETCH) and ((SkinData.BGType and BGT_TEXTURELEFT = BGT_TEXTURELEFT) or (SkinData.BGType and BGT_TEXTURERIGHT = BGT_TEXTURERIGHT)) and
                           (HeightOf(LastClientRect) <> Form.ClientHeight) or
                             (SkinData.BGType and BGT_STRETCH = BGT_STRETCH) and ((SkinData.BGType and BGT_TEXTURETOP = BGT_TEXTURETOP) or (SkinData.BGType and BGT_TEXTUREBOTTOM = BGT_TEXTUREBOTTOM)) and
                               (WidthOf(LastClientRect) <> Form.ClientWidth)
              then begin                                                    
                acM := MakeMessage(SM_ALPHACMD, MakeWParam(1, AC_SETCHANGEDIFNECESSARY), 0, 0);
                AlphaBroadCast(Form, acM);
              end;
              // If can optimize (Pre-paint the form while is under the BorderForm)
              if (BorderForm <> nil) and
                   ((ListSW = nil) or
                      (ListSW.sBarVert = nil) or
                        (ListSW.sBarHorz = nil) or
                          (not ListSW.sBarVert.fScrollVisible and
                            not ListSW.sBarHorz.fScrollVisible)) then begin // Pre-paint the form while is under the BorderForm

                if BorderForm.AForm = nil then
                  BorderForm.CreateNewForm;
                // Repaint Form
                RedrawWindow(Form.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
                // Move ExtBorder back (z-order)
                if (BorderForm <> nil) and (BorderForm.AForm <> nil) then begin
                  SetWindowPos(BorderForm.AForm.Handle, Form.Handle, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOREDRAW or SWP_NOSIZE or SWP_NOMOVE);
                  if (BorderForm <> nil) and (BorderForm.AForm <> nil) then
                    SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False); // Update borders region

                  SendOwnerToBack;
                  BorderForm.ExBorderShowing := False;
                end
                else begin
                  UpdateRgn(Self, False);
                end;
              end
              else
                RedrawWindow(Form.Handle, nil, 0, RDW_NOFRAME or RDW_NOERASE or RDW_INVALIDATE or RDW_UPDATENOW);

              SetParentUpdated(Form);
            end
            else
              if UpdateClient {and not InAero }then
                InvalidateRect(Form.Handle, nil, False);

            if Assigned(Form.OnResize) then
              Form.OnResize(Form);

            LastClientRect := MkRect(Form.ClientWidth, Form.ClientHeight);
            Exit;
          end
          else
            if (Form.FormStyle = fsMDIForm) and IsCached(SkinData) or (Form.FormStyle = fsMDIChild) then begin
              FillArOR(Self);
              UpdateRgn(Self, True, True) // Update region
            end
            else
              case Message.WParam of
                SIZE_MAXIMIZED:
                  if (Form.FormStyle = fsMDIChild) and (Form.WindowState = wsMaximized) then begin // Repaint MDI child buttons
                    TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
                    TsSkinProvider(MDISkinProvider).MenuChanged := True;
                    RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
                  end;
              end;
        end
        else
          FCommonData.BGChanged := True;

      LastClientRect := MkRect(Form.ClientWidth, Form.ClientHeight);
    end
  else begin
    RgnChanged := True;
    FCommonData.BGChanged := True;
    OldWndProc(Message);
  end;
end;


function TsSkinProvider.AC_SMAlphaCmd_Common(var Message: TMessage): boolean;
var
  i: integer;
begin
  Result := True;
  case Message.WParamHi of
    AC_REMOVESKIN:
      if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
        if ListSW <> nil then
          FreeAndNil(ListSW);

        InitDwm(Form.Handle, False);
        CommonMessage(Message, FCommonData);
        FLinesCount := -1;
        FTitleSkinIndex := -1;
        FCaptionSkinIndex := -1;
        AlphaBroadCast(Form, Message);
        AdapterRemove;
        if Assigned(SkinData.SkinManager) then
          DeleteUnusedBmps(True);

        if (Form <> nil) and not (csDestroying in Form.ComponentState) then begin
          if Assigned(SkinData.SkinManager) then begin
{$IFNDEF FPC}
            InitMenuItems(False);
{$ENDIF}
            CheckSysMenu(False);
            if (Form.FormStyle = fsMDIForm) and (MDIForm <> nil) then
              HookMDI(False);

            if HaveBorder(Self) and not InMenu then
              SetWindowRgn(Form.Handle, 0, True); // Return standard kind

            UpdateMenu;
            if UseGlobalColor and not SkinData.CustomColor then
              Form.Color := clBtnFace;

            InitExBorders(False);
            RedrawWindow(Form.ClientHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE or RDW_ALLCHILDREN or RDW_UPDATENOW);
          end;
          for i := 0 to Form.ControlCount - 1 do
            if (Form.Controls[i] is TLabel) then
              InitLabel(Form.Controls[i], False);

          if FCommonData.FCacheBmp <> nil then
            FreeAndNil(FCommonData.FCacheBmp);
        end;
      end
      else begin
        CommonMessage(Message, FCommonData);
        AlphaBroadCast(Form, Message);
      end;

    AC_SETNEWSKIN: begin
      if not (csDestroying in Form.ComponentState) and Assigned(SkinData) then
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and not Assigned(SystemMenu) then
          PrepareForm;

      Result := False;
    end;

    AC_GETAPPLICATION: 
      Message.Result := LRESULT(Application);

    AC_PARENTCLOFFSET: 
      Message.Result := MakeLong(OffsetX, OffsetY);

    AC_CTRLHANDLED:
      Message.Result := 1;

    AC_ENDUPDATE: begin
      if SkinData.CtrlSkinState and ACS_MNUPDATING = ACS_MNUPDATING then begin
        SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_MNUPDATING;
        SendMessage(Form.Handle, CM_MENUCHANGED, 0, 0);
      end;
      Result := False;
    end;

    AC_GETBG:
      if (FCommonData <> nil) and FCommonData.Skinned then begin
        PacBGInfo(Message.LParam)^.Offset := MkPoint;
        if FCommonData.BGChanged and (not FCommonData.FUpdating or FInAnimation) and IsCached(SkinData) then begin
          if (BorderForm = nil) and SkinData.SkinManager.ExtendedBorders and (Form.WindowState <> wsMaximized) then begin
            Result := False; // Broken bg because ext borders are not ready
            Exit;
          end;
          PaintAll;
        end;

        if PacBGInfo(Message.LParam)^.PleaseDraw then begin
          inc(PacBGInfo(Message.LParam)^.Offset.X, OffsetX);
          inc(PacBGInfo(Message.LParam)^.Offset.Y, OffsetY);
        end;
        if Assigned(Form.OnPaint) then begin
          PacBGInfo(Message.LParam)^.Bmp := SkinData.FCacheBmp;
          PacBGInfo(Message.LParam)^.Offset := Point(OffsetX, OffsetY);
          PacBGInfo(Message.LParam)^.BgType := btCache;
          Exit;
        end;

        if FCommonData.SkinIndex > -1 then
          InitBGInfo(FCommonData, PacBGInfo(Message.LParam), min(integer(FormActive), FCommonData.SkinManager.gd[FCommonData.SkinIndex].States - 1))
        else
          InitBGInfo(FCommonData, PacBGInfo(Message.LParam), min(integer(FormActive), 0));

        if (PacBGInfo(Message.LParam)^.BgType = btCache) then begin
          if not PacBGInfo(Message.LParam)^.PleaseDraw then
            if PacBGInfo(Message.LParam)^.Bmp = nil then begin
              PaintAll;
              PacBGInfo(Message.LParam)^.Bmp := FCommonData.FCacheBmp;
            end;

        end;
        with PacBGInfo(Message.LParam)^.Offset do begin
          X := X + OffsetX;
          if X <> 0 then
            PacBGInfo(Message.LParam)^.FillRect.Left := max(0, PacBGInfo(Message.LParam)^.FillRect.Left - X);

          Y := Y + OffsetY;
          if Y <> 0 then
            PacBGInfo(Message.LParam)^.FillRect.Top  := max(0, PacBGInfo(Message.LParam)^.FillRect.Top - Y);
        end;
      end
      else
        Result := False;

    AC_GETSKINSTATE: begin
      if FCommonData.CtrlSkinState and ACS_BGUNDEF = ACS_BGUNDEF then
        UpdateSkinState(FCommonData, False);

      Message.Result := FCommonData.CtrlSkinState;
    end

    else
      Result := False;
  end;
end;


function TsSkinProvider.AC_SMAlphaCmd_Unskinned(var Message: TMessage): boolean;
var
  i: integer;
begin
  Result := True;
  case Message.WParamHi of
    AC_PREPARECACHE:
      SkinData.BGChanged := False;

    AC_GETPROVIDER:
      Message.Result := LRESULT(Self); // Used for menuline init

    AC_SETNEWSKIN:
      if not (csDestroying in Form.ComponentState) and Assigned(SkinData) then begin
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          KillAnimations;
          DeleteUnusedBmps(True);
          FCommonData.UpdateIndexes;
          FTitleSkinIndex := -1;
          InitIndexes;

          if (SkinData.SkinManager <> nil) then begin
            if (BorderForm <> nil) and IsZoomed(Form.Handle) then
              FSysExHeight := ActualTitleHeight > (SysCaptHeight(Form) + 4)
            else
              FSysExHeight := False;

            CheckSysMenu(True);
            UpdateIconsIndexes;
            if (Form.FormStyle = fsMDIForm) and (Screen.ActiveForm = Form.ActiveMDIChild) then
              FormActive := True;

            if not (csLoading in SkinData.SkinManager.ComponentState) then begin
              // Menus skinning
              if (Form.Menu <> nil) and FMenuOwnerDraw then
                MenusInitialized := True;
{$IFNDEF FPC}
              InitMenuItems(True); // Update after skinning in run-time
{$ENDIF}
              if not MenusInitialized then
                MenusInitialized := UpdateMenu;

              // Labels skinning
              if Adapter <> nil then
                for i := 0 to Form.ControlCount - 1 do
                  if (Form.Controls[i] is TLabel) and Adapter.IsControlSupported(Form.Controls[i]) then
                    InitLabel(Form.Controls[i], True);
            end;
            // Menu Line refresh
            FCommonData.BGChanged := True;
            FLinesCount := -1;
            if (TForm(Form).FormStyle = fsMDIForm) then
              HookMDI;

            // Update skin data in the TitleBar
            UpdateTitleBar;
            InitDwm(Form.Handle, DrawNonClientArea);
          end;
          if Adapter = nil then
            AdapterCreate
          else
            TacCtrlAdapter(Adapter).AddAllItems;
        end;
      end
      else
        Result := False;

    else
      Result := False;
  end;
end;


function TsSkinProvider.AC_SMAlphaCmd_Skinned(var Message: TMessage): boolean;
var
  i: integer;
begin
  Result := False;
  case Message.WParamHi of
    AC_CONTROLLOADED:
      if (Form <> nil) and not (csLoading in Form.ComponentState) then
        if (Adapter <> nil) then
          if (Message.LParam <> 0) then
            TacCtrlAdapter(Adapter).AddAllItems(TWinControl(Message.LParam))
          else
            TacCtrlAdapter(Adapter).AddAllItems(Form);

    AC_PREPARING:
      if (FCommonData <> nil) then begin
        Message.Result := LRESULT(not InAnimationProcess{LionDev} {and IsCached(FCommonData) }and (FCommonData.FUpdating));
        Result := True;
      end;

    AC_ENDPARENTUPDATE:
      if FCommonData.FUpdating then begin
        FCommonData.FUpdating := False;
        RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);
        Result := True;
      end;

    AC_SETBGCHANGED:
      FCommonData.BGChanged := True;

    AC_GETFONTINDEX:
      if (FormHeader.AdditionalHeight > 0) and (FHeaderIndex >= 0) and (PacPaintInfo(Message.LParam).R.Top < FormHeader.AdditionalHeight) then begin
        PacPaintInfo(Message.LParam)^.FontIndex := FHeaderIndex;
        Message.Result := 1;
      end
      else
        if SkinData.SkinManager.gd[SkinData.SkinIndex].GiveOwnFont {and True {Remove it with updating of all skins} then begin
          PacPaintInfo(Message.LParam)^.FontIndex := SkinData.SkinIndex;
          Message.Result := 1;
        end;

    AC_GETBORDERWIDTH: begin
      Result := True;
      if (ListSW <> nil) and (ListSW.cxLeftEdge <> 0) then
        Message.Result := ListSW.cxLeftEdge - Form.BorderWidth
      else begin
        Message.Result := (Form.Width - Form.ClientWidth) div 2 - Form.BorderWidth;
        if Message.Result = 0 then
          Message.Result := Message.LParam;
      end;
    end;

    AC_SETPOSCHANGING:
      if Message.LParam = 1 then
        FormState := FormState or FS_POSCHANGING
      else
        FormState := FormState and not FS_POSCHANGING;

    AC_GETPOSCHANGING:
      Message.Result := integer(FormState and FS_POSCHANGING = FS_POSCHANGING);

    AC_SETALPHA: if IsWindowVisible(Form.Handle) then begin
      if BorderForm <> nil then
        SetFormBlendValue(BorderForm.AForm.Handle, BorderForm.SkinData.FCacheBmp, Message.LParam);

      if Message.LParam <> MaxByte then begin
        if GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED <> WS_EX_LAYERED then
          SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

        SetLayeredWindowAttributes(Form.Handle, clNone, Message.LParam, ULW_ALPHA);
      end
      else
        if GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = WS_EX_LAYERED then
          SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
    end;

    AC_NCPAINT: begin
      if Message.LParam = 1 then
        FCommonData.BGChanged := True;

      UpdateSkinCaption(Self);
    end;

    AC_UPDATING: begin
      FCommonData.Updating := Message.WParamLo = 1;
      if FCommonData.Updating then
        FCommonData.BGChanged := True;
    end;

    AC_REFRESH:
      if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
        if Adapter = nil then
          AdapterCreate
        else
          TacCtrlAdapter(Adapter).AddAllItems;

        if FDrawNonClientArea and FDrawClientArea then
          RefreshFormScrolls(Self, ListSW, False);

        if (Form.Parent <> nil) and (Form.FormStyle <> fsMDIChild) then
          FCommonData.CtrlSkinState := FCommonData.CtrlSkinState and not ACS_FAST;

        FLinesCount := -1;
        if not (csLoading in SkinData.SkinManager.ComponentState) then begin
          UpdateMenu;
{$IFNDEF FPC}
          InitMenuItems(SkinData.Skinned);
{$ENDIF}
        end;
        if HaveBorder(Self) then
          RgnChanged := True;
        // Update skin data in the TitleBar
        UpdateTitleBar;
        if Form.Visible then begin
          FCommonData.BGChanged := True;
          InitExBorders(SkinData.SkinManager.ExtendedBorders);
          if not InAnimationProcess then
            if (Form.FormStyle = fsMDIForm) and Assigned(Form.ActiveMDIChild) and (Form.ActiveMDIChild.WindowState = wsMaximized) then begin
              ProcessMessage(WM_NCPAINT);
              InvalidateRect(Form.ActiveMDIChild.Handle, nil, True);
            end
            else begin
              RedrawWindow(Form.Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_UPDATENOW or RDW_FRAME or RDW_NOCHILDREN);
              if Form.FormStyle = fsMDIForm then
                RedrawWindow(Form.ClientHandle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_UPDATENOW or RDW_FRAME or RDW_NOCHILDREN);
            end;

          if UseGlobalColor and not SkinData.CustomColor then
            Form.Color := SkinData.SkinManager.GetGlobalColor;

          if MDIForm <> nil then
            TsMDIForm(MDIForm).ConnectToClient;

          FCommonData.Updating := False;                               // Form image is prepared now
          if SystemMenu <> nil then
            SystemMenu.UpdateGlyphs;

          SendToAdapter(Message);                                      // Sending message to all child adapted controls
          if (BorderForm <> nil) {and (FormState and FS_CHANGING <> FS_CHANGING) }then begin
            BorderForm.UpdateExBordersPos;
//            UpdateRgn(Self, True, True);
          end;
        end;
      end;

    AC_CHILDCHANGED: begin
      if (FCommonData.SkinManager.gd[SkinData.SkinIndex].Props[0].GradientPercent + FCommonData.SkinManager.gd[SkinData.SkinIndex].Props[0].ImagePercent > 0) then
        Message.LParam := 1
      else
        Message.LParam := LPARAM((SkinData.BorderIndex >= 0) and (SkinData.SkinManager.ma[SkinData.BorderIndex].DrawMode and BDM_FILL = BDM_FILL));

      Message.Result := Message.LParam;
      Result := True;
    end;

    AC_GETCONTROLCOLOR: begin
      Message.Result := GetBGColor(SkinData, 0);
      Result := True;
    end;

    AC_GETPROVIDER: begin
      Message.Result := LRESULT(Self);
      Result := True;
    end; // Used for menuline init

    AC_SETNEWSKIN:
      if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
        DeleteUnusedBmps(True);
        FCommonData.UpdateIndexes;
        FTitleSkinIndex := -1;
//        FTitleSkinIndex := FTitleSkinIndex;
        InitIndexes;
        if TempBmp <> nil then begin
          TempBmp.Height := 0;
          TempBmp.Width  := 0;
        end;
        if (SkinData.SkinManager <> nil) then begin
          UpdateIconsIndexes;
          DeleteUnusedBmps(True);
          CheckSysMenu(FDrawNonClientArea);
{$IFNDEF FPC}
          SkinData.SkinManager.SkinableMenus.UpdateMenus;
{$ENDIF}
          // Menu Line refresh
          FCommonData.BGChanged := True;
          FLinesCount := -1;
          UpdateTitleBar;

          ProcessMessage(WM_NCPAINT);
          if (TForm(Form).FormStyle = fsMDIForm) {and not Assigned(MDIForm) }then
            HookMDI;
        end;
        if Assigned(FTitleBar) then
          for i := 0 to FTitleBar.Items.Count - 1 do
            if FTitleBar.Items[i].Timer <> nil then
              FreeAndNil(FTitleBar.Items[i].Timer);
      end;

    AC_PREPARECACHE:
      if not aSkinChanging and FCommonData.BGChanged then begin
        PaintAll;
        if SkinData.BGChanged and
           ((csCreating in Form.ControlState) or
             (FormState and FS_BLENDMOVING = FS_BLENDMOVING) or
               (FormState and FS_ANIMCLOSING = FS_ANIMCLOSING) or
                 (SkinData.Skinindex < 0)) then
          SkinData.BGChanged := False;
      end;


    AC_MOUSELEAVE: begin
      SetHotHT(-1);
      biClicked := False;
    end;

    AC_BEFORESCROLL:
      if FCommonData.RepaintIfMoved then
        SendMessage(Form.Handle, WM_SETREDRAW, 0, 0);

    AC_AFTERSCROLL:
      if FCommonData.RepaintIfMoved then begin
        SendMessage(Form.Handle, WM_SETREDRAW, 1, 0);
        RedrawWindow(Form.Handle, nil, 0, {RDW_NOERASE or }RDW_UPDATENOW or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_FRAME or RDW_ERASE);
        if MDISkinProvider = Self then
          RedrawWindow(Form.ClientHandle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_FRAME);
      end;
  end;
end;


procedure TsSkinProvider.AC_CMShowingChanged(var Message: TMessage);
var
  i: integer;
{$IFNDEF NOWNDANIMATION}
  X: integer;
  lInted: boolean;
{$ENDIF}
begin
{$IFNDEF NOWNDANIMATION}
  x := MaxByte;
{$ENDIF}
  if FDrawNonClientArea and FDrawClientArea then begin // If first showing
    if Form.Showing then begin
      if (Form.FormStyle = fsMDIChild){ and ((MDISkinProvider = nil) or TsSkinProvider(MDISkinProvider).FInAnimation) }then begin
        if Adapter <> nil then
          TacCtrlAdapter(Adapter).AddAllItems(Form);

        RefreshFormScrolls(Self, ListSW, False);
        OldWndProc(Message);
        Exit;
      end;

      if (Form.FormStyle = fsMDIForm) then
        HookMDI;

      InitDwm(Form.Handle, True);
      FormState := FormState and not FS_ANIMCLOSING;
      if BorderForm <> nil then
        BorderForm.ExBorderShowing := False;

      if (FormTimer <> nil) and (FormTimer is TacMinTimer) then
        FreeAndNil(FormTimer);
{$IFNDEF DISABLEPREVIEWMODE}
      if acPreviewNeeded and Form.HandleAllocated and ((Application.MainForm = nil) or (Application.MainForm = Form)) then
        TrySayHelloToEditor(Form.Handle);
{$ENDIF}
      TryInitMenu;
      if Adapter <> nil then
        TacCtrlAdapter(Adapter).AddAllItems(Form);

{$IFNDEF NOWNDANIMATION}
      fAnimating := FAllowAnimation and ((Form.FormStyle = fsMDIChild) or (Form.Parent = nil)) and
                    SkinData.SkinManager.Effects.AllowAnimation and
                    SkinData.SkinManager.AnimEffects.FormShow.Active{$IFNDEF DISABLEPREVIEWMODE} and (acPreviewHandle <> Form.Handle){$ENDIF};

      lInted := False;
      if fAnimating then begin
        FCommonData.Updating := True; // Don't draw child controls
        FInAnimation := True;
        lInted := DoLayered(Form.Handle, True);
        X := MaxByte;
        if lInted then begin
          if BorderForm = nil then
            FillArOR(Self);

          if (Form.WindowState <> wsMaximized) then
            UpdateRgn(Self, False);

          RgnChanging := False;
{$IFDEF DELPHI7UP}
        end
        else begin
          X := Form.AlphaBlendValue;
//          Form.AlphaBlendValue := 0;
{$ENDIF}
        end;
        for i := 0 to Form.ControlCount - 1 do
          if Form.Controls[i].Visible and not (Form.Controls[i] is TCoolBar) then {TCoolBar must have Painting processed for buttons aligning}
            Form.Controls[i].Perform(WM_SETREDRAW, 0, 0);
      end
      else
{$ENDIF}
        SkinData.Updating := False;

      InitExBorders(SkinData.SkinManager.ExtendedBorders);
      OldWndProc(Message);
{$IFNDEF NOWNDANIMATION}
      if not SkinData.Skinned then  // Check - if form is not skinned already
        if fAnimating then begin
          for i := 0 to Form.ControlCount - 1 do
            if Form.Controls[i].Visible then
              Form.Controls[i].Perform(WM_SETREDRAW, 1, 0);

          SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
          RedrawWindow(Form.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE);
          RgnChanging := False;
          Exit;
        end;
{$ENDIF}

{$IFDEF DELPHI7UP}
      if X <> MaxByte then begin
        X := Form.AlphaBlendValue;
        Form.AlphaBlendValue := 0;
      end;
{$ENDIF}

      RefreshFormScrolls(Self, ListSW, False);
{$IFNDEF NOWNDANIMATION}
      if fAnimating then begin
        for i := 0 to Form.ControlCount - 1 do
          if Form.Controls[i].Visible then
            Form.Controls[i].Perform(WM_SETREDRAW, 1, 0);

        if lInted then
          DoLayered(Form.Handle, False);

        fAnimating := False;
        AnimShowForm(Self, SkinData.SkinManager.AnimEffects.FormShow.Time, X, SkinData.SkinManager.AnimEffects.FormShow.Mode);
        RgnChanging := False;
      end
      else
{$ENDIF}
        RedrawWindow(Form.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE);

      LastClientRect := MkRect(Form.ClientWidth, Form.ClientHeight);
      if (Form.FormStyle = fsMDIChild) and (Form.WindowState = wsMaximized) then
        UpdateMainForm;
    end
    else begin
      if (BorderForm <> nil) then
        if ((not SkinData.SkinManager.AnimEffects.FormHide.Active or
              (SkinData.SkinManager.AnimEffects.FormHide.Time div acTimerInterval = 0)) or
                not FAllowAnimation or not SkinData.SkinManager.Effects.AllowAnimation) then
          FreeAndNil(BorderForm)
        else begin
          // Preparing for a hiding animation
          FormState := FormState or FS_ANIMCLOSING;
          SkinData.FCacheBmp := GetFormImage(Self, True);
          FormState := FormState and not FS_ANIMCLOSING;
          SkinData.BGChanged := False; // Do not update cache
          if (BorderForm.AForm <> nil) and (BorderForm.AForm.HandleAllocated) then begin
{$IFDEF DELPHI7UP}
            if Form.AlphaBlend then
              i := Form.AlphaBlendValue
            else
{$ENDIF}
              i := MaxByte;

            SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
            SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, i);
            SetWindowPos(BorderForm.AForm.Handle, 0, BorderForm.AForm.Left, BorderForm.AForm.Top, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
          end;
        end;

      OldWndProc(Message);
    end;
  end
  else begin // Backgrounds must be drawn by all controls for a blinking prevent
    OldWndProc(Message);
    if AeroIsEnabled and Form.Showing then
      SendMessage(Form.Handle, WM_SETREDRAW, 1, 0);

    SkinData.FUpdating := False;
    if AeroIsEnabled then
      RedrawWindow(Form.Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_UPDATENOW);
  end;
end;


procedure TsSkinProvider.AC_WMShowWindow(var Message: TMessage);
var
  i: integer;
begin
  if (Form.FormStyle <> fsMDIChild) then begin
    if (Message.WParam = 1) then begin
      // Updating ExBorders after minimizing by system
      if (BorderForm <> nil) then
        BorderForm.ExBorderShowing := False;

{
      if FormState and FS_ANIMRESTORING = FS_ANIMRESTORING then
        FormState := FS_ANIMRESTORING
      else
        FormState := 0;}
      FormState := FormState and not FS_ANIMRESTORING;
      // RedrawUnder Aero
      if AeroIsEnabled then
        if not InAnimationProcess and (GetWindowLong(Form.Handle, GWL_EXSTYLE) and WS_EX_LAYERED <> WS_EX_LAYERED) then
          RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_ALLCHILDREN or RDW_INVALIDATE);
    end
    else begin
      // Prepare for hiding
(*
      if FAllowAnimation and
           not IsIconic(Form.Handle) and
             not SkipAnimation and
               SkinData.SkinManager.Active and
                 DrawNonClientArea and
                   (SkinData.SkinManager.AnimEffects.FormHide.Active) {and
           (SkinData.SkinManager.AnimEffects.FormHide.Time > 0) }then begin
        acHideTimer := nil;
        SkipAnimation := True;
        AnimHideForm(Self);
        while InAnimationProcess do
          Continue;

        DoLayered(Form.Handle, False);
        SkipAnimation := False;
      end
*)      
    end;
    case TWMShowWindow(Message).Status of
      SW_PARENTCLOSING:
        if ShowAction <> saIgnore then
          if IsIconic(Form.Handle) then
            ShowAction := saMinimize
          else
            if IsZoomed(Form.Handle) then
              ShowAction := saMaximize
            else
              ShowAction := saRestore;

      SW_PARENTOPENING:
        if SkinData.SkinManager.AnimEffects.Minimizing.Active and (Application.MainForm = Form) then begin // Restore
          OldWndProc(Message);
          Exit;
        end;
    end;
  end;
  OldWndProc(Message);
  if (Message.WParam = 1) then begin
    if (Form.FormStyle = fsMDIChild) and (Form.WindowState = wsMaximized) then
      TsSkinProvider(MDISkinProvider).RepaintMenu;

    if (Form.FormStyle = fsMDIForm) then
      for i := 0 to Form.MDIChildCount - 1 do
        if not WndIsSkinned(Form.MDIChildren[i].Handle){not GetBoolMsg(Form.MDIChildren[i].Handle, AC_CTRLHANDLED)} then
          AddSupportedForm(Form.MDIChildren[i].Handle);

    if (Form.Parent <> nil) and (Form.FormStyle <> fsMDIChild) then begin
      FCommonData.CtrlSkinState := FCommonData.CtrlSkinState and not ACS_FAST;
      FCommonData.BGChanged := True;
    end;
  end;
end;


procedure TsSkinProvider.AC_WMExitSizeMove(var Message: TMessage);
var
  i: integer;
begin
  OldWndProc(Message);
  if (BorderForm <> nil) and (acSupportedList <> nil) then
    for i := 0 to acSupportedList.Count - 1 do
      if acSupportedList[i] <> nil then
        SendAMessage(TacProvider(acSupportedList[i]).CtrlHandle, AC_INVALIDATE); // Update of some popup Dlgs
end;


procedure TsSkinProvider.AC_WMSetIcon(var Message: TMessage);
begin
  if not (csLoading in ComponentState) and (Message.LParam <> 0) and not InAnimationProcess and Form.Showing then begin
    if not AeroIsEnabled then
      SendMessage(Form.Handle, WM_SETREDRAW, 0, 0);

    OldWndProc(Message);
    if not AeroIsEnabled then
      SendMessage(Form.Handle, WM_SETREDRAW, 1, 0);

    UpdateSkinCaption(Self);
  end
  else
    OldWndProc(Message);
end;


{$IFNDEF NOWNDANIMATION}
procedure TsSkinProvider.AC_CMVisibleChanged_Unskinned(var Message: TMessage);
var
  i: integer;
begin
  if FDrawNonClientArea and not Application.Terminated then // If first showing
    if (Message.WParam = 0) and (SkinData.SkinManager <> nil) and SkinData.SkinManager.CommonSkinData.Active then
      if not IsIconic(Form.Handle) then begin
        if (SkinData.SkinManager.ShowState <> saMinimize) then // Closing
          if FAllowAnimation and (SkinData.SkinManager.AnimEffects.FormHide.Active) and
               SkinData.SkinManager.Effects.AllowAnimation and
                 (FormState and FS_ANIMCLOSING <> FS_ANIMCLOSING) and
                   (Form.Parent = nil) then begin

            // Preparing for a hiding animation
            FormState := FormState or FS_ANIMCLOSING;
            if BorderForm <> nil then begin
              BorderForm.ExBorderShowing := True;
{$IFDEF DELPHI7UP}
              if Form.AlphaBlend then
                i := Form.AlphaBlendValue
              else
{$ENDIF}
                i := MaxByte;

              SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
              SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, i);
              SetWindowPos(BorderForm.AForm.Handle, 0, BorderForm.AForm.Left, BorderForm.AForm.Top, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
            end
            else
              if Form.Parent = nil then
                CoverForm := MakeCoverForm(Form.Handle);
          end;
      end
      // If minimized by Aero shake, but wnd is visible still
      else
        if (Form.WindowState <> wsMinimized) and (TWindowPos(TWMWindowPosChanged(Message).WindowPos^).x = -32000) then begin
          OldWndProc(TMessage(Message));
          Form.WindowState := wsMinimized;
          StartMinimizing(Self);
        end;
end;


procedure TsSkinProvider.AC_WMWindowPosChanged_Unskinned(var Message: TWMWindowPosChanged);
begin
  if Assigned(SkinData.SkinManager) and acLayered then // Patch for BDS
    if (TWMWindowPosChanged(Message).WindowPos.Flags and SWP_HIDEWINDOW = SWP_HIDEWINDOW) {$IFDEF D2011} and not Application.Terminated{$ENDIF} then
      if FAllowAnimation and
           not IsIconic(Form.Handle) and
             not SkipAnimation and
               SkinData.SkinManager.Active and
                 DrawNonClientArea and
                   SkinData.SkinManager.Effects.AllowAnimation and
                     (SkinData.SkinManager.AnimEffects.FormHide.Active) {and
           (SkinData.SkinManager.AnimEffects.FormHide.Time > 0) }then begin
        acHideTimer := nil;
        SkipAnimation := True;
        AnimHideForm(Self);
        while InAnimationProcess do
          Continue;

        DoLayered(Form.Handle, False);
        SkipAnimation := False;
      end
end;


procedure TsSkinProvider.AC_WMClose(var Message: TMessage);
var
  i: integer;
begin
  if FAllowAnimation and
       (SkinData.SkinManager.AnimEffects.FormHide.Active) and //(SkinData.SkinManager.AnimEffects.FormHide.Time > 0) and
         SkinData.SkinManager.Effects.AllowAnimation and
           DrawNonClientArea and
             (FormState and FS_ANIMCLOSING <> FS_ANIMCLOSING) and
               (Form.Parent = nil) then begin
    OldWndProc(Message);
    if not (csDestroying in Form.ComponentState) then begin // Sometimes form may be destroyed already
      // Preparing for a hiding animation
      FormState := FormState or FS_ANIMCLOSING;
      SkinData.FCacheBmp := GetFormImage(Self, True);
      FormState := FormState and not FS_ANIMCLOSING;
      SkinData.BGChanged := False; // Do not update cache
      if (BorderForm <> nil) and (BorderForm.AForm <> nil) and (BorderForm.AForm.HandleAllocated) then begin
{$IFDEF DELPHI7UP}
        if Form.AlphaBlend then
          i := Form.AlphaBlendValue
        else
{$ENDIF}
          i := MaxByte;

        SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False);
        SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, i);
        SetWindowPos(BorderForm.AForm.Handle, 0, BorderForm.AForm.Left, BorderForm.AForm.Top, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
      end;
    end;
  end
  else
    OldWndProc(Message);
end;
{$ENDIF}


procedure TsSkinProvider.AC_WMSysCommand(var Message: TMessage);
var
  i: integer;
  UpdateClient: boolean;
{$IFNDEF NOWNDANIMATION}
  bAnim: boolean;
{$ENDIF}
begin
  if Form.FormStyle <> fsMDIChild then
    case Message.WParamLo of
      SC_DRAGMOVE:
        Form.Repaint; // Faster switching between a forms (avoid of system delay)

{$IFNDEF NOWNDANIMATION}
      SC_MAXIMIZE:
        if (Form.Parent = nil) and (FormTimer <> nil) and TacMinTimer(FormTimer).Minimized then begin
          FormState := FormState or FS_ZOOMING;
          bAnim := acGetAnimation;
          acSetAnimation(False);
          StartRestoring(Self);
          OldWndProc(Message);
          acSetAnimation(bAnim);
          FormState := FormState and not FS_ZOOMING;
          Exit;
        end;

      SC_MINIMIZE:
        if (Form <> Application.MainForm) and SkinData.SkinManager.AnimEffects.Minimizing.Active then begin
          bAnim := acGetAnimation;
          acSetAnimation(False);
          StartMinimizing(Self);
          OldWndProc(Message);
          acSetAnimation(bAnim);
          Exit;
        end;

      SC_RESTORE:
        if FormState and FS_ANIMCLOSING = FS_ANIMCLOSING then begin // If all windows were hidden
          FormState := FormState and not FS_ANIMCLOSING;
          if BorderForm <> nil then
            BorderForm.ExBorderShowing := False;

          bAnim := acGetAnimation;
          acSetAnimation(False);
          OldWndProc(Message);
          acSetAnimation(bAnim);
          Exit;
        end
        else
          if {$IFDEF D2007}Application.MainFormOnTaskBar or {$ENDIF} (Form <> Application.MainForm) then
            if IsIconic(Form.Handle) then begin
              bAnim := acGetAnimation;
              acSetAnimation(False);
              RgnChanged := True;
              StartRestoring(Self);
              OldWndProc(Message);
              if (BorderForm <> nil) and (BorderForm.AForm = nil) then begin
                FInAnimation := False;
                if BorderForm <> nil then
                  BorderForm.UpdateExBordersPos;
              end;
              acSetAnimation(bAnim);
              Exit;
            end
            else
              if (BorderForm <> nil) and (BorderForm.AForm = nil) or (BorderForm = nil) and ExtBordersNeeded(Self) then begin
                if BorderForm <> nil then
                  FreeAndNil(BorderForm);

                InitExBorders(True);
                UpdateRgn(Self, False);
              end;

{$IFDEF D2005}
      else
        if {$IFDEF D2007} Application.MainFormOnTaskBar and {$ENDIF} (Form = Application.MainForm) and IsIconic(Form.Handle) and (Form.Parent = nil) then
          if (FormTimer <> nil) then begin
            SendMessage(Application.Handle, Message.Msg, Message.WParam, Message.LParam);
            Exit;
          end
          else
            if (BorderForm = nil) and AeroIsEnabled then begin
              OldWndProc(Message);
              RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
              InvalidateRect(Form.Handle, nil, True);
              Exit;
            end;
{$ENDIF} // D2005
{$ENDIF}
    end;

  if (ResizeMode = rmBorder) and Form.Enabled and not bInProcess then
    if ($FFF0 and Message.WParam = SC_MOVE) then begin         // Move section
      SetCapture(Form.handle);
      bCapture := True; bMode := True;
    end
    else
      if ($FFF0 and Message.WParam = SC_SIZE) then begin    // Size section
        SetCapture(Form.handle);
        nDirection := 0;
        bCapture := True; bMode := False;
      end;

  case Form.FormStyle of
    fsMDIChild: begin
      UpdateClient := (Form.WindowState = wsMaximized) and (Message.WParam <> SC_MAXIMIZE) and (Form.WindowState <> wsNormal);
      if UpdateClient and (MDISkinProvider <> nil) then
        TsSkinProvider(MDISkinProvider).FCommonData.BeginUpdate; // Speed rising

      case $FFF0 and Message.WParam of
        SC_CLOSE:
          if MDISkinProvider <> nil then begin
            if Assigned(TsSkinProvider(MDISkinProvider).MDIForm) and UpdateClient then
              UpdateMainForm; // If CloseQuery used then must be repainted before

            TsSkinProvider(MDISkinProvider).InMenu := True;
            OldWndProc(Message);
            if not (csDestroying in Form.ComponentState) and not (csDestroying in ComponentState) then
              SetHotHT(0, False);

            TsSkinProvider(MDISkinProvider).InMenu := False;
            if Assigned(TsSkinProvider(MDISkinProvider).MDIForm) then
              if UpdateClient then
                UpdateMainForm;

            Exit;
          end;

        SC_KEYMENU:
          ;

        SC_RESTORE: begin
          if Form.WindowState = wsMinimized then
            UpdateClient := True;

          if MDICreating then
            Exit;

          OldWndProc(Message);
          SkinData.BGChanged := True;
          if DrawNonClientArea then
            SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_SYSMENU);

          RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_ERASE or RDW_INVALIDATE or RDW_UPDATENOW);
          // Updating of childs
          if (MDISkinProvider <> nil) then
            for i := 0 to TsSkinProvider(MDISkinProvider).Form.MDIChildCount - 1 do
              if TsSkinProvider(MDISkinProvider).Form.MDIChildren[i] <> Form then begin
                if TsSkinProvider(MDISkinProvider).Form.MDIChildren[i].WindowState = wsMaximized then
                  TsSkinProvider(MDISkinProvider).Form.MDIChildren[i].WindowState := wsNormal;

                RedrawWindow(TsSkinProvider(MDISkinProvider).Form.MDIChildren[i].Handle, nil, 0, RDW_FRAME or RDW_INTERNALPAINT or RDW_ERASE or RDW_UPDATENOW);
              end;

          if UpdateClient then
            UpdateMainForm;

          SystemMenu.UpdateItems(True);
          Exit;
        end;

        SC_MINIMIZE: begin
          OldWndProc(Message);
          if UpdateClient then
            UpdateMainForm;
            
          SystemMenu.UpdateItems(True);
          FCommonData.BGChanged := True;
          UpdateMainForm;
          Exit;
        end;

        SC_MAXIMIZE: begin
          ChildProvider := Self;
          SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) and not WS_VISIBLE);
          OldWndProc(Message);
          SetWindowLong(Form.Handle, GWL_STYLE, GetWindowLong(Form.Handle, GWL_STYLE) or WS_VISIBLE);
          RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INTERNALPAINT or RDW_ERASE or RDW_UPDATENOW);
          if (MDISkinProvider <> nil) and Assigned(TsSkinProvider(MDISkinProvider).MDIForm) then
            UpdateMainForm;

          SystemMenu.UpdateItems(True);
          Exit;
        end

        else
          OldWndProc(Message);
      end;
      if MDISkinProvider <> nil then
        TsSkinProvider(MDISkinProvider).FCommonData.EndUpdate;
    end;

    fsMDIForm: begin
      OldWndProc(Message);
      case Message.WParam of
        SC_MAXIMIZE, SC_RESTORE, SC_MINIMIZE: begin
          TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
          TsSkinProvider(MDISkinProvider).FLinesCount := -1;
          SendMessage(Form.Handle, WM_NCPAINT, 0, 0);
          if (Message.WParam = SC_MAXIMIZE) and (BorderForm <> nil) then
            BorderForm.UpdateExBordersPos(True);
        end;
      end;
    end

    else begin
      case Message.WParam of
        SC_MAXIMIZE: begin
          if (BorderForm <> nil) and SkinData.SkinManager.Options.NativeBordersMaximized or (Message.WParam = SC_RESTORE) then
            FreeAndNil(BorderForm);

          FormState := FormState or FS_ZOOMING;
        end;
      end;

      OldWndProc(Message);
      case Message.WParam of
        SC_KEYMENU:
          if (TWMSysCommand(Message).Key = VK_SPACE) and HaveSysMenu and HaveBorder(Self) then
            if IsIconic(Form.Handle) then
              DropSysMenu(FormLeftTop.x + SysBorderWidth(Form.Handle, BorderForm), FormLeftTop.y + BorderHeight + HeightOf(FIconRect) - 16)
            else
              DropSysMenu(FormLeftTop.x + SysBorderWidth(Form.Handle, BorderForm), FormLeftTop.y + BorderHeight + HeightOf(FIconRect));

        SC_MAXIMIZE, SC_RESTORE: begin
          if Message.WParam = SC_MAXIMIZE then
            FormState := FormState and not FS_ZOOMING
          else
            if (FormTimer <> nil) and TacMinTimer(FormTimer).Minimized then
              FreeAndNil(FormTimer); // Kill if not killed yet

          if SystemMenu.VisibleMax then
            CurrentHT := HTMAXBUTTON;

          SetHotHT(0);
          if (Message.WParam = SC_RESTORE) then begin
            FCommonData.BGChanged := True;
            if not HaveBorder(Self) then
              SetWindowRgn(Form.Handle, 0, True)
            else begin
              if (SkinData.SkinManager <> nil) and
                   SkinData.SkinManager.ExtendedBorders and
                     AllowExtBorders and
                       DrawNonClientArea and
                         (Form.Parent = nil) and
                           (Form.FormStyle <> fsMDIChild) then begin
                FInAnimation := False;
                if BorderForm <> nil then
                  BorderForm.UpdateExBordersPos
                else begin
                  InitExBorders(True);
                  UpdateRgn(Self, True, True);
                end;
              end;
              RedrawWindow(Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
            end;
          end;
        end;
      end;
    end;
  end;

  case Message.WParamLo of
    SC_MINIMIZE: begin
      if SkinData.SkinManager.AnimEffects.Minimizing.Active then
        fAnimating := False; // Reset if was defined in the StartMinAnimation

      if (BorderForm <> nil) and (BorderForm.AForm <> nil) then
        if (FormState and FS_ANIMMINIMIZING <> FS_ANIMMINIMIZING) then begin
          BorderForm.ExBorderShowing := True;
          FreeAndNil(BorderForm.AForm);
          BorderForm.ExBorderShowing := False;
        end;
    end;
  end;
end;


procedure TsSkinProvider.AC_WMSetText(var Message: TMessage);
begin
  if Form.HandleAllocated and IsWindowVisible(Form.Handle) and not (csCreating in Form.ControlState) and FDrawNonClientArea then begin
    if Assigned(FGlow1) then
      FreeAndNil(FGlow1);

    if Assigned(FGlow2) then
      FreeAndNil(FGlow2);

    if (Form.FormStyle = fsMdiChild) and (Form.WindowState = wsMaximized) then begin
      TsSkinProvider(MDISkinProvider).FCommonData.BGChanged := True;
      MakeCaptForm(TsSkinProvider(MDISkinProvider));
      OldWndProc(Message);
      KillCaptForm(TsSkinProvider(MDISkinProvider));
    end
    else
      if not AeroIsEnabled then begin
        FCommonData.BGChanged := True;
        MakeCaptForm(Self);
        OldWndProc(Message);
        KillCaptForm(Self);
{$IFDEF DELPHI6UP}
  {$IFNDEF DELPHI7UP}
        if Form.AlphaBlend then
  {$ENDIF}
          ProcessMessage(WM_NCPAINT, 0, 0);
{$ENDIF}
      end
      else begin
        if BorderForm = nil then
          MakeCaptForm(Self);

        OldWndProc(Message);
        UpdateSkinCaption(Self);
        if BorderForm = nil then
          KillCaptForm(Self);
      end;

    if BorderForm <> nil then
      BorderForm.UpdateExBordersPos;
  end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_CMEnabledChanged(var Message: TMessage);
begin
  OldWndProc(Message);
  if FDrawNonClientArea then begin
    if (BorderForm <> nil) and (BorderForm.AForm <> nil) then
      BorderForm.AForm.Enabled := Form.Enabled;

    if DisabledBlendValue < MaxByte then begin
      if not Form.Enabled then
        FormState := FormState or FS_DISABLED
      else
        FormState := FormState and not FS_DISABLED;

      UpdateLayerForm;
    end;
    SkinData.BGChanged := True;
    ProcessMessage(WM_NCPAINT, 0, 0);
    if BorderForm <> nil then
      BorderForm.UpdateExBordersPos(True);
  end;
end;


procedure TsSkinProvider.AC_WMChildActivate(var Message: TMessage);
begin
  OldWndProc(Message);
  UpdateMenu;
  if (MDISkinProvider <> nil) and (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild <> nil) then
    if TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState = wsMaximized then
      TsMDIForm(TsSkinProvider(MDISkinProvider).MDIForm).UpdateMDIIconItem // Repaint of main form icons and menus
    else
      CheckSysMenu(True); // Reinit of sysmenu
end;


procedure TsSkinProvider.AC_WMEnterMenuLoop(var Message: TMessage);
begin
  if (Form.FormStyle = fsMDIForm) and not InMenu and (Form.ActiveMDIChild <> nil) and (Form.ActiveMDIChild.WindowState = wsMaximized) then begin
    InMenu := True;
    if MDIIconsForm = nil then begin
      MDIIconsForm := TForm.Create(Application);
      MDIIconsForm.BorderStyle := bsNone;
      SetClassLong(MDIIconsForm.Handle, GCL_STYLE, GetClassLong(MDIIconsForm.Handle, GCL_STYLE) and not NCS_DROPSHADOW);
    end;
    MDIIconsForm.Tag := ExceptTag;
    MDIIconsForm.Visible := False;
    MDIIconsForm.Name := 'acMDIIcons';
    MDIIconsForm.OnPaint := MdiIcoFormPaint;
    SetWindowPos(MDIIconsForm.Handle, 0, Form.BoundsRect.Right - 60 - SysBorderWidth(Form.Handle, BorderForm, False),
                 Form.Top + SysCaptHeight(Form) + SysBorderWidth(Form.Handle, BorderForm, False), 60,
                 GetSystemMetrics(SM_CYMENU) - 1 + 4, SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOREDRAW);
  end;
  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMStyleChanged(var Message: TMessage);
begin
  OldWndProc(Message);
  if (SystemMenu <> nil) and (SystemMenu.ItemClose <> nil) and (SystemMenu.ItemClose.Visible <> (biSystemMenu in Form.BorderIcons)) then begin
    SystemMenu.UpdateItems;
    UpdateSkinCaption(Self);
  end
  else
    if (Message.WParam = WParam(GWL_EXSTYLE)) and
         (FormState and FS_BLENDMOVING <> FS_BLENDMOVING) and
           (FormState and FS_ANIMMINIMIZING <> FS_ANIMMINIMIZING) and
             (FormState and FS_ANIMRESTORING <> FS_ANIMRESTORING) then

      if ((PStyleStruct(Message.LParam)^.styleNew and WS_EX_LAYERED) <> (PStyleStruct(Message.LParam)^.styleOld and WS_EX_LAYERED)) and
           (BorderForm <> nil) and (FormState and FS_DISABLED <> FS_DISABLED) then {AlphaBlend is changed}
        BorderForm.UpdateExBordersPos;
end;


procedure TsSkinProvider.AC_WMSetRedraw(var Message: TMessage);
begin
  if (Message.WParam = 1) then
    LockCount := max(0, LockCount - 1)
  else
    inc(LockCount);

  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMMove(var Message: TMessage);
begin
  KillAnimations;
  ClearGlows(False); // Hide a glow effect on a focused control if exists
  if (BorderForm = nil) and ExtBordersNeeded(Self){ and Form.HandleAllocated} and not (csLoading in Form.ComponentState) and
        (FormState and FS_ANIMMINIMIZING <> FS_ANIMMINIMIZING) and (FormState and FS_ANIMRESTORING <> FS_ANIMRESTORING) then
    InitExBorders(True);

  OldWndProc(Message);
  if BorderForm = nil then
    MoveGluedForms;
end;


procedure TsSkinProvider.AC_WMNCDestroy;
begin
  if (Form.FormStyle = fsMDIChild) and Assigned(MDISkinProvider) then
    with TsSkinProvider(MDISkinProvider) do
      if Assigned(MDIForm) and not (csDestroying in ComponentState) and  not (csDestroying in Form.ComponentState) and SkinData.Skinned(True) then begin
        RepaintMenu;
        if Form.ActiveMDIChild = nil then
          RedrawWindow(Form.ClientHandle, nil, 0, RDW_ERASE or RDW_FRAME or RDW_INTERNALPAINT or RDW_INVALIDATE or RDW_UPDATENOW);
      end;

  if (CoverForm <> nil) and ((acHideTimer = nil) or (acHideTimer.Form <> Form)) then
    FreeAndNil(CoverForm); // Kill cover form if not nil and no animation
end;


procedure TsSkinProvider.AC_WMSysColorChange(var Message: TMessage);
begin
  OldWndProc(Message);
  UpdateMenu;
end;


procedure TsSkinProvider.AC_WMExitMenuLoop(var Message: TMessage);
begin
  InMenu := False;
  if Assigned(MDIIconsForm) then
    FreeAndNil(MDIIconsForm);

  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMNCHitTest(var Message: TMessage);
var
  i: integer;
  p: TPoint;
begin
  if RTInit then begin
    RTInit := False;
    LoadInit;
  end;
  if (CaptionHeight = 0) or not FDrawNonClientArea then
    OldWndProc(Message)
  else begin
    Message.Result := HTProcess(TWMNCHitTest(Message));
    // Hide standard border icons
    if (Message.Result in [HTMAXBUTTON, HTCLOSE, HTMINBUTTON]) and (Form.FormStyle = fsMDIChild) then
      CheckSysMenu(True);

    if (Message.Result in [Windows.HTCAPTION, Windows.HTNOWHERE, HTMENU, HTCLIENT, HTLEFT..HTBOTTOMRIGHT]) then begin
      if IsGripVisible(Self) then begin
        i := FCommonData.SkinManager.ConstData.GripRightBottom;
        if FCommonData.SkinManager.IsValidImgIndex(i) then begin
          p := CursorToPoint(TWMNCHitTest(Message).XPos, TWMNCHitTest(Message).YPos);
          if (BorderForm <> nil) then begin
            if (p.y > RBGripPoint(i).y - DiffTitle(Self.BorderForm) - ShadowSize.Top) and (p.x > RBGripPoint(i).x - DiffBorder(Self.BorderForm) - ShadowSize.Left) then begin
              Message.Result := HTBOTTOMRIGHT;
              Exit;
            end;
          end
          else
            if (p.y > RBGripPoint(i).y) and (p.x > RBGripPoint(i).x) then begin
              Message.Result := HTBOTTOMRIGHT;
              Exit;
            end;
        end;
      end;
      OldWndProc(Message);
    end
    else
      if (ResizeMode = rmBorder) and (nDirection = 0) and Form.Enabled and (Message.Result in [HTCAPTION, HTLEFT..HTBOTTOMRIGHT]) then
        nDirection := Message.Result;
  end;
end;


{$IFNDEF DISABLEPREVIEWMODE}
procedure TsSkinProvider.AC_WMCopyData(var Message: TWMCopyData);
begin
  OldWndProc(TMessage(Message));
  if (Message.Result = 0) and (acPreviewHandle = Form.Handle) and not acSkinPreviewUpdating then begin // SkinManager is upadated by SkinEditor (Preview mode)
    acSkinPreviewUpdating := True;
    if (Message.CopyDataStruct <> nil) and (Message.From = 7) and (PacSkinData(Message.CopyDataStruct^.lpData)^.Magic = ASE_MSG) then begin
      CopyMemory(@DefaultManager.PreviewBuffer, PacSkinData(Message.CopyDataStruct^.lpData), SizeOf(TacSkinData));
      PostMessage(Application.{$IFNDEF FPC}Handle{$ELSE}MainFormHandle{$ENDIF}, SM_ALPHACMD, MakeWParam(0, AC_COPYDATA), 0);
    end;
    acSkinPreviewUpdating := False;
  end;
end;


procedure TsSkinProvider.AC_ASEMSG(var Message: TMessage);
begin
  case Message.WParam of
    ASE_HELLO: OldWndProc(Message);
    ASE_CLOSE: Form.Close;
    ASE_ALIVE: Message.Result := 1;
  end;
end;
{$ENDIF}


{$IFNDEF FPC}
procedure TsSkinProvider.AC_WMContextMenu(var Message: TMessage);
begin
  if (Form.PopupMenu <> nil) then
    SkinData.SkinManager.SkinableMenus.HookPopupMenu(Form.PopupMenu, SkinData.SkinManager.SkinnedPopups);

  OldWndProc(Message);
end;
{$ENDIF}


procedure TsSkinProvider.AC_WMNCLButtonDown(var Message: TWMNCLButtonDown);
var
  p: TPoint;
  lInted: boolean;
begin
  if FDrawNonClientArea then begin
    if (BorderForm <> nil) and (Message.HitTest = HTOBJECT) then begin
      OldWndProc(TMessage(Message));
      Exit;
    end;
    if (BorderForm <> nil) and (Message.HitTest = HTTRANSPARENT) then
      Message.HitTest := BorderForm.Ex_WMNCHitTest(TWMNCHitTest(Message));

    case Message.HitTest of
      HTCLOSE, HTMAXBUTTON, HTMINBUTTON, HTHELP, HTCHILDCLOSE..HTCHILDMIN: begin
        if Assigned(ChildProvider) then
          if ((Message.HitTest = HTCHILDMIN) and not ChildProvider.SystemMenu.EnabledMin) or
             ((Message.HitTest = HTCHILDMAX) and not ChildProvider.SystemMenu.EnabledRestore) then
            Exit;

        SetPressedHT(Message.HitTest);
      end;

      HTMENU:
        OldWndProc(TMessage(Message));

      HTSYSMENU: begin
        Message.Result := 0;
        OldWndProc(TMessage(Message));
        if Message.Result <> 0 then
          Exit;

        SetHotHT(0);
        biClicked := False;
{$IFNDEF FPC}
        if not SkinData.SkinManager.SkinnedPopups then begin // Check and Exit when DblClick and not SkinnedPopups
          Delay(200);
          if SkinData.FUpdating then
            Exit;
        end;
{$ENDIF}
        if Form.FormStyle = fsMDIChild then begin
          if Assigned(MDISkinProvider) then begin
            p := FormLeftTop;
            DropSysMenu(p.x, p.y + SysCaptHeight(Form) + 4 - integer(IsIconic(Form.Handle)) * 16)
          end;
        end
        else
          DropSysMenu(FormLeftTop.x + SysBorderWidth(Form.Handle, BorderForm, False), FormLeftTop.y + BorderHeight + HeightOf(FIconRect) + SysBorderHeight(Form.Handle, BorderForm, False));
      end

      else
        if BetWeen(Message.HitTest, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin
          SetPressedHT(Message.HitTest);
          TitleButtons.Items[Message.HitTest - HTUDBTN].MouseDown(Message.HitTest - HTUDBTN, mbLeft, [], Message.XCursor, Message.YCursor);
        end
        else
          if BetWeen(Message.HitTest, HTITEM, HTITEM + MaxByte) then begin
            if Assigned(FTitleBar) then
              with FTitleBar.Items[Message.HitTest - HTITEM] do begin
                if Style <> bsTab then begin
                  SetPressedHT(Message.HitTest);
{$IFNDEF FPC}
                  if SkinData.SkinManager.SkinnedPopups then
                    if (Style in [bsMenu, bsButton]) and (DropDownMenu <> nil) then
                      SkinData.SkinManager.SkinableMenus.HookPopupMenu(DropDownMenu, True);
{$ENDIF}
                end;
                DoMouseDown(mbLeft, [], Message.XCursor, Message.YCursor);
              end;
          end
          else
            if IsIconic(Form.Handle) then
              Form.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0)
            else begin
              SetHotHT(0);
              if (Form.WindowState <> wsMaximized) or (CursorToPoint(0, Message.YCursor).y > SysBorderHeight(Form.Handle, BorderForm) + CaptionHeight) then begin
                SystemParametersInfo(SPI_GETDRAGFULLWINDOWS, 0, @lInted, 0);
                UpdateSlaveFormsList;
                if lInted then begin
                  if (ResizeMode = rmBorder) and Form.Enabled and not (Message.HitTest in [HTMENU]) then begin
                    // If caption pressed then activate form (standard procedure)
                    if (Message.HitTest in [HTMENU, HTCAPTION]) then
                      OldWndProc(TMessage(Message));

                    bMode := not (Message.HitTest in [HTRIGHT, HTLEFT, HTBOTTOM, HTTOP, HTTOPLEFT, HTTOPRIGHT, HTBOTTOMLEFT, HTBOTTOMRIGHT]);
                    p := Point(Message.XCursor, Message.YCursor);
                    SendMessage(Form.Handle, WM_SYSCOMMAND, iff(bMode, SC_MOVE, SC_SIZE), 0);
                    StartMove(p.X, p.Y);
                  end
                  else begin
{$IFNDEF NOWNDANIMATION}
                    if (Message.HitTest = HTCAPTION) and
                         (Form.FormStyle <> fsMDIChild) and
                           SkinData.SkinManager.AnimEffects.BlendOnMoving.Active and
                             not IsIconic(Form.Handle) and
                               not ((SkinData.SkinManager.AnimEffects.BlendOnMoving.BlendValue = MaxByte) or
                                 not AllowBlendOnMoving) then begin
                      StartMoveForm;
                      Exit;
                    end;
{$ENDIF}
                    OldWndProc(TMessage(Message));
                  end
                end
                else
                  OldWndProc(TMessage(Message));
              end
              else begin
                OldWndProc(TMessage(Message));
                if not Form.Active and Form.Enabled and Form.CanFocus then
                  Form.SetFocus; // Focusing if maximized
              end;
            end;
    end
  end
  else begin
    // Skinned sysmenu
    case Message.HitTest of
      HTSYSMENU: begin
        SetHotHT(0);
        biClicked := False;
        if Form.FormStyle = fsMDIChild then begin
          if Assigned(MDISkinProvider) then begin
            p := FormLeftTop;
            DropSysMenu(p.x, p.y + CaptionHeight + 4);
          end;
        end
        else
          DropSysMenu(FormLeftTop.x + SysBorderWidth(Form.Handle, BorderForm),
                      FormLeftTop.y + BorderHeight + HeightOf(FIconRect) + SysBorderHeight(Form.Handle, BorderForm, False));
      end
      else
        OldWndProc(TMessage(Message));
    end
  end;
end;


procedure TsSkinProvider.AC_WMMouseMove(var Message: TMessage);
var
  X, Y: integer;
  p: TPoint;
begin
  OldWndProc(Message);
  SetHotHT(0);
  if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) then
    DefaultManager.ActiveControl := 0;

  if (ResizeMode = rmBorder) and Form.Enabled then begin
    p := Form.ClientToScreen(Point(TWMMouseMove(Message).XPos, TWMMouseMove(Message).YPos));
    X := p.X;
    Y := p.Y;
    if bMode then begin // Move section
      if bCapture then
        bCapture := False;

      if bInProcess then begin
        DrawFormBorder(nLeft, nTop);
        nleft := nleft + (X - nX);
        ntop := nTop + (Y - nY);
        nY := Y;
        nX := X;
        DrawFormBorder(nLeft, nTop);
      end;
    end
    else begin
      //Size section
      if bCapture then begin
        nX := X;
        nY := Y;
        bCapture := False;
      end;
      if bInProcess then begin
        DrawFormBorder(0, 0);
        case nDirection of
          HTLEFT: begin
            nleft := Form.left + X - nX;
            if nright - nleft < nMinWidth then
              nleft := nright - nMinWidth;
          end;

          HTRIGHT: begin
            nright := Form.left + Form.width + X - nX;
            if nright - nleft < nMinWidth then
              nright := Form.left + nMinWidth;
          end;

          HTBOTTOM: begin
            nbottom := Form.top + Form.height + Y - nY;
            if nbottom - ntop < nMinHeight then
              nbottom := Form.top + nMinHeight;
          end;

          HTTOP: begin
            ntop := Form.top + Y - nY;
            if nbottom - ntop < nMinHeight then
              ntop := nbottom - nMinHeight;
          end;

          HTBOTTOMLEFT: begin
            nbottom := Form.top + Form.height + Y - nY;
            if nbottom - ntop < nMinHeight then
              nbottom := Form.top + nMinHeight;

            nleft := Form.left + X - nX;
            if nright - nleft < nMinWidth then
              nleft := nright - nMinWidth;
          end;

          HTTOPRIGHT: begin
            ntop := Form.top + Y - nY;
            if nbottom - ntop < nMinHeight then
              ntop := nbottom - nMinHeight;

            nright := Form.left + Form.width + X - nX;
            if nright - nleft < nMinWidth then
              nright := Form.left + nMinWidth;
          end;

          HTTOPLEFT: begin
            ntop := Form.top + Y - nY;
            if nbottom - ntop < nMinHeight then
              ntop := nbottom - nMinHeight;

            nleft := Form.left + X - nX;
            if nright - nleft < nMinWidth then
              nleft := nright - nMinWidth;
          end

          else begin
            nbottom := Form.top + Form.height + Y - nY;
            if nbottom - ntop < nMinHeight then
              nbottom := Form.top + nMinHeight;

            nright := Form.left + Form.width + X - nX;
            if nright - nleft < nMinWidth then
              nright := Form.left + nMinWidth;
          end;
        end;
        DrawFormBorder(0, 0);
      end;
    end;
  end;
end;


procedure TsSkinProvider.AC_WMSettingChange(var Message: TMessage);
begin
  FCommonData.BGChanged := True;
  if Message.WParam = SPI_SETWORKAREA then
    if FormTimer is TacMinTimer then
      with TacMinTimer(FormTimer) do begin
        SkinData.BGChanged := True;
        UpdateDstRect;
        CurLeft   := RectTo.Left;
        CurTop    := RectTo.Top;
        CurRight  := RectTo.Right;
        CurBottom := RectTo.Bottom;
      end;

  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMNCRButtonDown(var Message: TMessage);
begin
  if not (TWMNCLButtonUp(Message).HitTest in [HTCAPTION, HTSYSMENU]) then
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMNCRButtonUp(var Message: TWMNCLButtonDown);
begin
  if HaveBorder(Self) then begin
    if (BorderForm <> nil) and (Message.HitTest = HTTRANSPARENT) then
      Message.HitTest := BorderForm.Ex_WMNCHitTest(TWMNCHitTest(Message))
    else
      Message.HitTest := HTProcess(TWMNCHitTest(Message));

    case TWMNCLButtonUp(Message).HitTest of
      HTCAPTION, HTSYSMENU: begin
        SetHotHT(0);
        biClicked := False;
        DropSysMenu(TWMNCLButtonUp(Message).XCursor, TWMNCLButtonUp(Message).YCursor);
      end
    end;
  end
  else
    OldWndProc(TMessage(Message));
end;


procedure TsSkinProvider.AC_WMSizing(var Message: TMessage);
begin
  OldWndProc(Message);
  if BorderForm <> nil then
    BorderForm.UpdateExBordersPos(False);
end;


procedure TsSkinProvider.AC_WMMouseLeave(var Message: TMessage);
begin
  // If not title bar items (solves a problem with tabs hovering)
  if (CurrentHT < HTITEM) or (BorderForm = nil) then
    SetHotHT(-1);

  biClicked := False;
  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_CMMouseEnter(var Message: TMessage);
begin
  // If not title bar items (solves a problem with tabs hovering)
  if (BorderForm <> nil) then
    SetHotHT(-1);

  biClicked := False;
  OldWndProc(Message);
  FCommonData.SkinManager.ActiveControl := Form.Handle;
  if (BorderForm <> nil) and BorderForm.ResetRgn and (FormState and FS_SIZING <> FS_SIZING) then
    BorderForm.UpdateRgn;
end;


procedure TsSkinProvider.AC_WMNCCreate(var Message: TMessage);
begin
  OldWndProc(Message);
  if Form.FormStyle <> fsMDIChild { Solving the problem with menu } then
    PrepareForm;
end;


procedure TsSkinProvider.AC_CMFloat(var Message: TMessage);
begin
  OldWndProc(Message);
  if ListSW <> nil then
    FreeAndNil(ListSW);

  SendAMessage(Form.Handle, AC_REFRESH, Cardinal(SkinData.SkinManager));
end;


procedure TsSkinProvider.AC_CMMenuChanged(var Message: TMessage);
begin
  if not (fsCreating in Form.FormState) and Form.Visible and not InAnimation(Self) then
    if SkinData.CtrlSkinState and ACS_LOCKED <> ACS_LOCKED then begin
      FLinesCount := -1;
      MenuChanged := True; // Menu may be invisible after form opening ????
      FCommonData.BGChanged := True;
    end;

  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMPrint(var Message: TMessage);
var
  DC, SavedDC: hdc;
  i: integer;
  cR: TRect;
begin
  if not (csLoading in ComponentState) and not (fsCreating in Form.FormState) and not (csDestroying in Form.ComponentState) then begin
    InitDwm(Form.Handle, True);
    if (Form.FormStyle = fsMDIChild) and (MDISkinProvider <> nil) then
      with TsSkinProvider(MDISkinProvider) do
        if Assigned(Form.ActiveMDIChild) and (Form.ActiveMDIChild.WindowState = wsMaximized) and (Form <> Form.ActiveMDIChild) then
          Exit;

    if not MenusInitialized then
      if UpdateMenu then
        MenusInitialized := True;

    // Support of DevEx cxPrintWindow
    if Message.LParam and PRF_ERASEBKGND = PRF_ERASEBKGND then
      ProcessMessage(WM_ERASEBKGND, Message.WParam, Message.LParam)
    else begin
      DC := TWMPaint(Message).DC;
      FCommonData.PrintDC := DC;
      FCommonData.FUpdating := False;
      if BorderForm <> nil then begin
        if FCommonData.BGChanged then
          PaintAll;

        BitBlt(DC, 0, 0, FCommonData.FCacheBmp.Width, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
        MoveWindowOrg(DC, OffsetX, OffsetY);
        GetClientRect(Form.Handle, cR);
        IntersectClipRect(DC, 0, 0, WidthOf(cR), HeightOf(cR));
        if (Form.FormStyle <> fsMDIForm) then
          PaintControls(DC, Form, True, MkPoint, 0, not (FormState and FS_ANIMCLOSING = FS_ANIMCLOSING));
      end
      else begin
        if FDrawNonClientArea then
          if not HaveBorder(Self) and IsSizeBox(Form.Handle) then begin
            if FCommonData.BGChanged then
              PaintAll;

            i := Form.BorderWidth + 3;
            BitBlt(DC, 0, 0, Form.Width, i, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY); // Title and menu line update
            BitBlt(DC, 0, i, i, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, i, SRCCOPY); // Left border update
            BitBlt(DC, i, Form.Height - i, Form.Width - i, i, FCommonData.FCacheBmp.Canvas.Handle, i, Form.Height - i, SRCCOPY); // Bottom border update
            BitBlt(DC, FCommonData.FCacheBmp.Width - i, i, i, FCommonData.FCacheBmp.Height, FCommonData.FCacheBmp.Canvas.Handle, FCommonData.FCacheBmp.Width - i, i, SRCCOPY); // Right border update
          end
          else
            PaintCaption(DC);

        MoveWindowOrg(DC, OffsetX, OffsetY);
        GetClientRect(Form.Handle, cR);
        IntersectClipRect(DC, 0, 0, WidthOf(cR), HeightOf(cR));
        if SkinData.CtrlSkinState and ACS_FAST <> ACS_FAST then
          PaintForm(DC)
        else begin
          SavedDC := SaveDC(DC);
          ExcludeControls(DC, Form, actGraphic, 0, 0);
          PaintForm(DC);
          RestoreDC(DC, SavedDC);
          if (Form.FormStyle <> fsMDIForm) then
            PaintControls(DC, Form, True, MkPoint, 0, not (FormState and FS_ANIMCLOSING = FS_ANIMCLOSING));
        end;
      end;
      if Form.FormStyle = fsMDIForm then
        SendMessage(Form.ClientHandle, WM_PRINT, WPARAM(DC), 0);

      FCommonData.PrintDC := 0;
      if Assigned(Form.OnPaint) then begin
        Form.Canvas.Handle := DC;
        Form.OnPaint(Form);
        Form.Canvas.Handle := 0;
      end;
    end;
  end;
end;


procedure TsSkinProvider.AC_WMNCPaint(var Message: TMessage);
var
  R: TRect;
begin
  if SystemMenu = nil then
    PrepareForm;

  if DrawNonClientArea then
    if (SkinData.CtrlSkinState and ACS_LOCKED = ACS_LOCKED) or
         (SkinData.CtrlSkinState and ACS_MNUPDATING = ACS_MNUPDATING) or
           (IsMenuVisible(Self) and (Form.Menu.WindowHandle = 0)) or
             (FormState and FS_ANIMCLOSING = FS_ANIMCLOSING) then
      Exit;

  if RTInit then begin
    RTInit := False;
    LoadInit;
  end;
  if (Form.Parent = nil) or not InUpdating(SkinData) then
    if DrawNonClientArea and not (InAnimationProcess and (Form.FormStyle = fsMDIChild)) then begin
      if fAnimating or not Form.Showing or (csLoading in ComponentState) or (csDestroyingHandle in Form.ControlState) or (SystemMenu = nil) then
        Exit;

      if IsIconic(Form.Handle) then
        FCommonData.BGChanged := True
      else begin
        GetWindowRect(Form.Handle, R);
        if (WidthOf(R) <> Form.Width) or (HeightOf(R) <> Form.Height) then
          Exit; // If size of form is not initialized yet (wsMaximized)
      end;

      if not Assigned(Adapter) then
        AdapterCreate; // Preventing of std controls BG erasing before hooking

      if SkinData.FCacheBmp = nil then // Preventing of painting before ExBorders, usually when MainMenu exists
        InitExBorders(SkinData.SkinManager.ExtendedBorders);

      AC_WMNCPaintHandler;
      Message.Result := 0;
    end
    else
      OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMEraseBkGnd(var Message: TMessage);
var
  cR: TRect;
begin
  if IsWindowVisible(form.Handle){ Form.Showing} and FDrawClientArea then begin
    if (SkinData.CtrlSkinState and ACS_LOCKED = ACS_LOCKED) or FCommonData.FUpdating then
      Exit;

    if not (csPaintCopy in Form.ControlState) and (Message.WParam <> WParam(Message.LParam) {PerformEraseBackground, TntSpeedButtons}) then begin
      if not IsCached(FCommonData) or ((Form.FormStyle = fsMDIForm) and (Form.ActiveMDIChild <> nil) and (Form.ActiveMDIChild.WindowState = wsMaximized)) then begin
        if (Form.FormStyle = fsMDIChild) and (FCommonData.FCacheBmp <> nil) and (MDISkinProvider <> nil) then begin
          GetClientRect(TsSkinProvider(MDISkinProvider).Form.Handle, cR);
          if (PtInRect(cR, Form.BoundsRect.TopLeft) and PtInRect(cR, Form.BoundsRect.BottomRight)) then begin
            FCommonData.FCacheBmp.Height := min(FCommonData.FCacheBmp.Height, CaptionHeight + SysBorderHeight(Form.Handle, BorderForm) + LinesCount * MenuHeight + 1);
            FCommonData.BGChanged := True;
          end
        end;
        AC_WMEraseBkGndHandler(TWMPaint(Message).DC);
        if MDICreating then begin
          MDICreating := False;
          if Form.FormStyle = fsMDIChild then
            ChildProvider := Self;
        end;
      end
      else
        if not FCommonData.FUpdating then begin
          if (FCommonData.FCacheBmp <> nil) and not FCommonData.BGChanged then
            CopyWinControlCache(Form, FCommonData, Rect(OffsetX, OffsetY, OffsetX + Form.ClientWidth, OffsetY + Form.ClientHeight), MkRect(Form.ClientWidth, Form.ClientHeight), TWMPaint(Message).DC, False);

          SetParentUpdated(Form);
        end
    end
    else
      if (Message.WParam <> 0) then // From PaintTo
        if not FCommonData.BGChanged then
          if IsCached(FCommonData) then
            BitBlt(TWMPaint(Message).DC, 0, 0, Form.Width, Form.Height, FCommonData.FCacheBmp.Canvas.Handle, OffsetX, OffsetY, SRCCOPY)
          else
            FillDC(TWMPaint(Message).DC, MkRect(Form), GetBGColor(SkinData, 0));

    Message.Result := 1;
  end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMPaint(var Message: TMessage);
var
  DC: hdc;
  PS: TPaintStruct;
begin
  if FDrawClientArea and (FormState and FS_ANIMRESTORING <> FS_ANIMRESTORING) {(Form.WindowState <> wsMinimized)} then begin
    if (csPaintCopy in Form.ControlState) then
      Exit; // Implemented in WM_ERASEBKGND

    if (BorderForm <> nil) and not InAnimation(Self) and ((BorderForm.AForm = nil) or not IsWindowVisible(BorderForm.AForm.Handle)) then begin
      BorderForm.UpdateExBordersPos(False);
//      UpdateRgn(Self, True, True);
    end;

    if IsCached(FCommonData) {or (Form.Parent <> nil)} {!!!and not AeroIsEnabled} then
      if Form.Showing then begin
        OurPaintHandler(TWMPaint(Message));
        if MDICreating then
          MDICreating := False;

        if (Form.FormStyle = fsMDIForm) then begin
          if TWMPaint(Message).DC = 0 then
            DC := GetDC(Form.Handle)
          else
            DC := TWMPaint(Message).DC;

          PaintControls(DC, Form, True, MkPoint);
          if TWMPaint(Message).DC = 0 then
            ReleaseDC(Form.Handle, DC);
        end;
        Message.Result := 0;
      end
      else (* if (BorderForm <> nil) {$IFDEF DELPHI7UP} or Form.AlphaBlend {$ENDIF} then *)
        OldWndProc(Message)
    else
      if Form.Showing then begin
        if not (csDestroying in ComponentState) then
          InvalidateRect(Form.Handle, nil, True); // BG updating (for repainting of graphic controls)

        BeginPaint(Form.Handle, PS);
        EndPaint  (Form.Handle, PS);
        Message.Result := 0;
      end
      else
        OldWndProc(Message);

    if not DrawNonClientArea and (Form.Menu <> nil) then
      ProcessMessage(WM_NCPAINT, 0, 0);
  end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_CMRecreateWnd(var Message: TMessage);
begin
  OldWndProc(TMessage(Message));
{$IFNDEF DISABLEPREVIEWMODE}
  if (acPreviewHandle <> 0) and Form.HandleAllocated then
    TrySayHelloToEditor(Form.Handle);
{$ENDIF}
end;


procedure TsSkinProvider.AC_WMActivateApp(var Message: TMessage);
begin
  OldWndProc(Message);
  if (sPopupCalendar <> nil) and sPopupCalendar.Visible then
    sPopupCalendar.Close;

  if (Message.WParam = 1) and (SkinData.SkinManager.AnimEffects.Minimizing.Active) and (FormState and FS_ANIMMINIMIZING <> FS_ANIMMINIMIZING) then
    if (BorderForm <> nil) then begin
      if FormState and FS_DISABLED <> FS_DISABLED then
        BorderForm.UpdateExBordersPos(False) // Update z-order ( BDS )
    end
    else
      if (Application.MainForm = Form) and
           (Message.WParam = 1) and
             (Application.MainForm.WindowState = wsMinimized) and
               not IsIconic(Application.MainForm.Handle) and
                 ((FormTimer = nil) or
                   not TacMinTimer(FormTimer).Minimized) then begin // Restore a main form if is not restored still
        Application.MainForm.WindowState := wsNormal;
        InvalidateRect(Application.MainForm.Handle, nil, True);
        RedrawWindow(Application.MainForm.Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_FRAME or RDW_ERASE or RDW_UPDATENOW);
      end;
end;


procedure TsSkinProvider.AC_WMMDIDestroy(var Message: TMessage);
begin
  OldWndProc(Message);
  if (Form.FormStyle = fsMDIChild) and Assigned(MDISkinProvider) and not (csDestroying in TsSkinProvider(MDISkinProvider).ComponentState) then
    with TsSkinProvider(MDISkinProvider) do
      if (Form.WindowState <> wsMaximized) then begin
        MenusInitialized := False;
        Menuchanged := True;
        SkinData.BGChanged := True;
        FLinesCount := -1;
        ProcessMessage(WM_NCPAINT, 0, 0);
      end
      else begin
        SkinData.BGChanged := True;
        ProcessMessage(WM_NCPAINT, 0, 0);
        UpdateMainForm(True);
      end;

  ChildProvider := Self;
end;


procedure TsSkinProvider.AC_WMVisibleChanged(var Message: TMessage);
begin
  if (Message.WParam = 1) then
    if RTInit then begin
      RTInit := False;
      LoadInit;
      InitExBorders(SkinData.SkinManager.ExtendedBorders);
    end;

  OldWndProc(Message);
  if (Message.WParam = 0) then begin
    if Assigned(SkinData) and Assigned(SkinData.FCacheBmp) and not (csDestroying in Form.ComponentState) then begin
      SkinData.FCacheBmp.Width  := 0;
      SkinData.FCacheBmp.Height := 0;
    end;
    KillAnimations;
  end
  else
    if Form.Parent <> nil then
      SetParentUpdated(Form); // Updating of controls which are not refreshed
end;


procedure TsSkinProvider.AC_WMNCLButtonDblClick(var Message: TMessage);
var
  p: TPoint;
begin
  if (ResizeMode = rmBorder) and bInProcess then begin
    p := Form.ClientToScreen(Point(TWMMouse(Message).XPos, TWMMouse(Message).YPos));
    StopMove(p.x, p.y);
    ReleaseCapture;
    bInProcess := False;
  end;
  case TWMNCHitMessage(Message).HitTest of
    HTSYSMENU: begin
{$IFNDEF FPC}
      if not SkinData.SkinManager.SkinnedPopups then // Check and Exit when DblClick and not SkinnedPopups
{$ENDIF}
        SkinData.FUpdating := True;

      Form.Close;
    end;

    HTCAPTION: begin
      if HaveSysMenu and (SystemMenu.EnabledMax or SystemMenu.EnabledRestore) or not HaveBorder(Self) and IsIconic(Form.Handle) then begin
        SendMessage(Form.Handle, WM_SYSCOMMAND, StateFlags[(Form.WindowState = wsMaximized) or IsIconic(Form.Handle)], 0);
        SystemMenu.UpdateItems;
      end
      else
        if IsIconic(Form.Handle) then begin
          SendMessage(Form.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
          SystemMenu.UpdateItems;
        end;

      TWMNCHitMessage(Message).HitTest := 0;
    end

    else
      OldWndProc(Message);
  end;
end;


procedure TsSkinProvider.AC_WMMeasureItem(var Message: TMessage);
var
  mi: TMenuItem;
begin
  if (Form.FormStyle = fsMDIForm) and (MDISkinProvider = Self) then
    MDISkinProvider := Self;

{$IFNDEF FPC}
  if IsMenuVisible(Self) and Assigned(SkinData.SkinManager) and (PMeasureItemStruct(Message.LParam)^.CtlType = ODT_MENU) then begin
    mi := Form.Menu.FindItem(PMeasureItemStruct(Message.LParam)^.itemID, fkCommand);
    if mi <> nil then
      SkinData.SkinManager.SkinableMenus.InitItem(mi, True);
  end;
{$ENDIF}
  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMQueryEndSession(var Message: TMessage);
begin
  FadingForbidden := True;
  if not Application.Terminated then
    while acAnimCount > 0 do
      Application.ProcessMessages;

  OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMWindowPosChanged(var Message: TMessage);
begin
  if Assigned(SkinData.SkinManager) and acLayered and DrawNonClientArea then begin
    if (BorderForm <> nil) and Form.HandleAllocated and IsZoomed(Form.Handle) then
      FSysExHeight := ActualTitleHeight > (SysCaptHeight(Form) + 4)
    else
      FSysExHeight := False;
{$IFNDEF NOWNDANIMATION}
    if (TWMWindowPosChanged(Message).WindowPos.Flags and SWP_HIDEWINDOW = SWP_HIDEWINDOW) then
      if not SkipAnimation{ and (Form = Application.MainForm)} and (SkinData.FCacheBmp <> nil {it's possible under Aero}) then // Window will be hidden
        if not IsIconic(Form.Handle) then begin
          if (SkinData.SkinManager.ShowState = saMinimize) and (Form = Application.MainForm) then begin
            if SkinData.SkinManager.AnimEffects.Minimizing.Active then begin
              OldWndProc(Message);
              fAnimating := False;
              Exit;
            end;
          end
          else
            if (SkinData.SkinManager.ShowState <> saMinimize) then begin // Closing
              if FAllowAnimation and (SkinData.SkinManager.AnimEffects.FormHide.Active) and
                   SkinData.SkinManager.Effects.AllowAnimation and
                     (Form.Parent = nil) and (Form.FormStyle <> fsMDIChild) then begin
                if AeroIsEnabled then
                  DoLayered(Form.Handle, True);

                OldWndProc(Message);
                SkipAnimation := True;
                AnimHideForm(Self);
                if not Application.Terminated then begin
                  if AeroIsEnabled then
                    DoLayered(Form.Handle, False);

                  SkipAnimation := False;
                end;
                Exit;
              end
              else // Closing not main form
                if BorderForm <> nil then
                  if BorderForm.AForm <> nil then
                    FreeAndNil(BorderForm.AForm);
            end
            else // Minimize not main form
              if BorderForm <> nil then
                if BorderForm.AForm <> nil then
                  FreeAndNil(BorderForm.AForm);
        end;

{$ENDIF}
    OldWndProc(Message);
    if not FInAnimation and (BorderForm <> nil) and Form.Visible and not IsIconic(Form.Handle) then
      if (TWMWindowPosChanged(Message).WindowPos^.Flags and SWP_NOREDRAW <> SWP_NOREDRAW) and
           (TWMWindowPosChanged(Message).WindowPos^.Flags and SWP_DRAWFRAME <> SWP_DRAWFRAME) and
             (FormState and FS_BLENDMOVING <> FS_BLENDMOVING) then
        if (FormState and FS_DISABLED <> FS_DISABLED) then
          if (TWMWindowPosChanged(Message).WindowPos^.Flags and 3 = 3) and (BorderForm.AForm <> nil) then
            if AeroIsEnabled and (Application.MainForm = Form) and (GetActiveWindow = Form.Handle) then
              SetWindowPos(BorderForm.AForm.Handle, BorderForm.GetTopWnd{HWND_TOPMOST}, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER)
            else
              SetWindowPos(BorderForm.AForm.Handle, Form.Handle, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER)
          else
            BorderForm.UpdateExBordersPos(False); // Update z-order ( BDS )

          SendOwnerToBack;
  end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMCreate(var Message: TMessage);
begin
  if (Form.FormStyle = fsMDIChild) then begin
    if (MDISkinProvider = nil) then
      AddSupportedForm(Application.MainForm.Handle);

    if (MDISkinProvider <> nil) and
         (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild <> nil) and
           (TsSkinProvider(MDISkinProvider).Form.ActiveMDIChild.WindowState = wsMaximized) then
      MDICreating := True
    else
      MDICreating := False;
  end;
  OldWndProc(Message);
  if (Form.FormStyle <> fsMDIChild) then
    PrepareForm; // Problem with MDI menu solving
end;


procedure TsSkinProvider.AC_WMParentNotify(var Message: TMessage);
var
  acM: TMessage;
  wctrl: TWinControl;
begin
  if (Form <> nil) and
       not (csLoading in ComponentState) and
         not (csLoading in Form.ComponentState) and
           (Message.WParamLo in [WM_CREATE, WM_DESTROY]) and
             (srThirdParty in SkinData.SkinManager.SkinningRules) then begin
    OldWndProc(Message);
    if Assigned(Adapter) and (Message.WParamLo = WM_CREATE) then
      if Message.LParam <> 0 then begin
//        if not IsWindowVisible(Message.LParam) then Exit; // Patch for invisible inplace edits in DevExpress (test in the next Beta)
        wctrl := SearchWndByID(Message.LParam, Application);
        if wctrl = nil then
          TacCtrlAdapter(Adapter).AddAllItems
        else
          TacCtrlAdapter(Adapter).AddNewItem(wctrl);
      end
      else
        TacCtrlAdapter(Adapter).AddAllItems;

    acM := MakeMessage(SM_ALPHACMD, MakeWParam(0, AC_GETSKINSTATE), 1, 0);
    AlphaBroadCast(Form, acM);
    if FDrawNonClientArea then
      UpdateScrolls(ListSW, True);
  end
  else
    OldWndProc(Message);
end;


procedure TsSkinProvider.AC_WMNotify(var Message: TMessage);
begin
  OldWndProc(Message);
  case TWMNotify(Message).NMHdr^.code of
    TCN_SELCHANGE:
      if Adapter <> nil then
        TacCtrlAdapter(Adapter).AddAllItems; // Comment this line in the BETA version (prevent slow pages switching)
  end;
end;


procedure TsSkinProvider.AC_WMControlListChange(var Message: TCMControlListChange);
var
  acM: TMessage;
begin
  if (Message.Control <> nil) then begin
    OldWndProc(TMessage(Message));
    if Message.Control is TWinControl then begin
      if Adapter <> nil then
        TacCtrlAdapter(Adapter).AddNewItem(TWinControl(Message.Control));

      acM := MakeMessage(SM_ALPHACMD, MakeWParam(0, AC_GETSKINSTATE), 1, 0);
      AlphaBroadCast(TWinControl(Message.Control), acM);
    end;
    Message.Control.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETSKINSTATE), 1);
  end
  else
    OldWndProc(TMessage(Message));
end;


procedure TsSystemMenu.CloseClick(Sender: TObject);
begin
  Sendmessage(FForm.Handle, WM_SYSCOMMAND, SC_CLOSE, 0);
end;


constructor TsSystemMenu.Create(AOwner: TComponent);
begin
  FOwner := TsSkinProvider(AOwner);
  FForm := FOwner.Form;
  SubMenu := nil;
  inherited Create(AOwner);
  Name := s_SysMenu + IntToStr(GetTickCount);
  Generate;
end;


function TsSystemMenu.EnabledClose: boolean;
var
  mnu: HMENU;
begin
  mnu := GetSystemMenu(FForm.Handle, False);
  Result := GetMenuState(mnu, SC_CLOSE, MF_BYCOMMAND) and MF_DISABLED <> MF_DISABLED;
end;


function TsSystemMenu.EnabledMax: boolean;
begin
  Result := ((TForm(FForm).FormStyle = fsMDIChild) or ((FForm.BorderStyle in [bsSingle, bsSizeable]))) and (biMaximize in FOwner.Form.BorderIcons);
end;


function TsSystemMenu.EnabledMin: boolean;
begin
  Result := (biMinimize in FOwner.Form.BorderIcons) and not (IsIconic(FForm.Handle) and (FForm <> Application.MainForm));
end;


function TsSystemMenu.EnabledMove: boolean;
begin
  Result := (FForm.WindowState <> wsMaximized);
end;


function TsSystemMenu.EnabledRestore: boolean;
begin
  Result := ((biMaximize in FOwner.Form.BorderIcons) and (FForm.WindowState <> wsNormal)) or (FForm.WindowState = wsMinimized);
end;


function TsSystemMenu.EnabledSize: boolean;
begin
  Result := (FForm.BorderStyle <> bsSingle) and not IsIconic(FForm.Handle);
end;


procedure TsSystemMenu.ExtClick(Sender: TObject);
begin
  PostMessage(FForm.Handle, WM_SYSCOMMAND, TComponent(Sender).Tag, 0);
end;


function CloneMenuitem(SourceItem: TMenuItem): TMenuItem;
var
  i: Integer;
begin
  with SourceItem Do Begin
    Result := NewItem(Caption, Shortcut, Checked, Enabled, OnClick, HelpContext, Name + 'Copy');
    Result.ImageIndex := SourceItem.ImageIndex;
    for i := 0 to Count - 1 do
      Result.Add(CloneMenuItem(Items[i]));
  end;
end;


procedure TsSystemMenu.Generate;
var
  Menu: HMENU;
  mi: TMenuItem;
  i, c: integer;
  u: UINT;
  s: acString;
  sCut: string;
  TmpItem: TMenuItem;

  function CreateSystemItem(const Caption: acString; const Name: string; EventProc: TNotifyEvent): TMenuItem; begin
    Result := TacMenuItem.Create(Self);
    Result.Caption := Caption;
    Result.OnClick := EventProc;
    Result.Name := Name;
  end;

  function GetItemText(ID: Cardinal; var Caption: acString; var ShortCut: String; uFlag: Cardinal; DefText: string = ''): boolean;
  var
    Text: array [0..MaxByte] of acChar;
{$IFDEF TNTUNICODE}
    ws: WideString;
{$ENDIF}
    P: integer;
  begin
    Result := {$IFDEF TNTUNICODE}GetMenuStringW{$ELSE}GetMenuString{$ENDIF}(Menu, ID, Text, MaxByte, uFlag) <> 0;
    if Result then begin
      P := Pos(#9, Text);
      if P = 0 then
        ShortCut := ''
      else begin
        ShortCut := Copy(Text, P + 1, Length(Text) - P);
{$IFDEF TNTUNICODE}
        ws := Text;
        ws := Copy(ws, 1, P - 1);
        Caption := ws;
        Exit;
{$ELSE}
        StrLCopy(Text, Text, P - 1);
{$ENDIF}
      end;
      Caption := Text;
    end
    else
      Caption := DefText;
  end;

  procedure TrySubMenu(Position: TacMenuItemPos);
  var
    i: integer;
  begin
    if (FOwner.SysSubMenu.Position = Position) and (FOwner.SysSubMenu.Caption <> '') and (FOwner.SysSubMenu.PopupMenu <> nil) then begin
      if Position = ipBottom then
        Self.Items.Add(CreateSystemItem(CharMinus, 'ac_BtmDiv', nil));

      SubMenu := CreateSystemItem(FOwner.SysSubMenu.Caption, 'ac_SubMenu', nil);
      Self.Items.Add(SubMenu);
      for i := 0 to FOwner.SysSubMenu.PopupMenu.Items.Count - 1 do begin
        mi := CloneMenuitem(FOwner.SysSubMenu.PopupMenu.Items[i]);
        SubMenu.Add(mi);
      end;
      Images := FOwner.SysSubMenu.PopupMenu.Images;
      if Position in [ipTop, ipBeforeClose] then
        Self.Items.Add(CreateSystemItem(CharMinus, 'ac_TopDiv', nil));
    end;
  end;

begin
  Items.Clear;
  ExtItemsCount := 0;
  Menu := GetSystemMenu(FForm.Handle, False);
  if Menu <> 0 then begin
    TrySubMenu(ipTop);

    GetItemText(SC_RESTORE, s, sCut, MF_BYCOMMAND, acs_RestoreStr);
    ItemRestore := CreateSystemItem(s, 'acIR', RestoreClick);
    ItemRestore.Tag := SC_RESTORE;
    Self.Items.Add(ItemRestore);

    GetItemText(SC_MOVE, s, sCut, MF_BYCOMMAND, acs_MoveStr);
    ItemMove := CreateSystemItem(s, 'acIM', MoveClick);
    Self.Items.Add(ItemMove);
    ItemMove.Tag := SC_MOVE;

    GetItemText(SC_SIZE, s, sCut, MF_BYCOMMAND, acs_SizeStr);
    ItemSize := CreateSystemItem(s, 'acIS', SizeClick);
    Self.Items.Add(ItemSize);
    ItemSize.Tag := SC_SIZE;

    GetItemText(SC_MINIMIZE, s, sCut, MF_BYCOMMAND, acs_MinimizeStr);
    ItemMinimize := CreateSystemItem(s, 'acIN', MinClick);
    Self.Items.Add(ItemMinimize);
    ItemMinimize.Tag := SC_MINIMIZE;

    GetItemText(SC_MAXIMIZE, s, sCut, MF_BYCOMMAND, acs_MaximizeStr);
    ItemMaximize := CreateSystemItem(s, 'acIX', MaxClick);
    Self.Items.Add(ItemMaximize);
    ItemMaximize.Tag := SC_MAXIMIZE;

{$IFNDEF FPC}
    Self.Items.InsertNewLineAfter(ItemMaximize);
{$ENDIF}
    TmpItem := nil;
    c := GetMenuItemCount(Menu);
    for i := 0 to c - 1 do begin
      u := GetMenuItemID(Menu, i);
      if ((u < $F000) or (u >= $F200)) and GetItemText(i, s, sCut, MF_BYPOSITION) then begin // If some external menuitems are exists
        TmpItem := TacMenuItem.Create(Self);
        TmpItem.Caption := s;
        TmpItem.Tag := LongInt(u);
{$IFNDEF FPC}
        if sCut <> '' then
          TmpItem.ShortCut := TextToShortCut(sCut);
{$ENDIF}

        TmpItem.OnClick := ExtClick;
        Self.Items.Add(TmpItem);
        inc(ExtItemsCount);
      end;
    end;
{$IFNDEF FPC}
    if ExtItemsCount > 0 then
      Self.Items.InsertNewLineAfter(TmpItem);
{$ENDIF}

    TrySubMenu(ipBeforeClose);
    GetItemText(SC_CLOSE, s, sCut, MF_BYCOMMAND, acs_CloseStr);
    ItemClose := CreateSystemItem(s, 'acIC', CloseClick);
{$IFNDEF FPC}
    if sCut <> '' then
      ItemClose.ShortCut := TextToShortCut(sCut);
{$ENDIF}

    Self.Items.Add(ItemClose);
    ItemClose.Tag := SC_CLOSE;
    ItemClose.Enabled := EnabledClose;
    TrySubMenu(ipBottom);
  end;
end;


procedure TsSystemMenu.MakeSkinItems;
var
  sl: TacStringList;
  i: integer;
  SkinItem, TempItem: TMenuItem;
  b: boolean;
begin
  if Assigned(FOwner.SkinData.SkinManager) then begin
    sl := TacStringList.Create;
    FOwner.SkinData.SkinManager.GetSkinNames(sl);
    b := False;
    if sl.Count > 0 then begin
      SkinItem := TacMenuItem.Create(Self);
      SkinItem.Caption := acs_AvailSkins;
      SkinItem.Name := s_SkinSelectItemName;
      Self.Items.Insert(0, SkinItem);
{$IFNDEF FPC}
      Self.Items.InsertNewLineAfter(SkinItem);
{$ENDIF}
      for i := 0 to sl.Count - 1 do begin
        TempItem := TacMenuItem.Create(Self);
        TempItem.Caption := sl[i];
        TempItem.OnClick := SkinSelect;
        TempItem.Name := s_SkinSelectItemName + IntToStr(i);
        TempItem.RadioItem := True;
        if not b and (TempItem.Caption = FOwner.SkinData.SkinManager.SkinName) then begin
          TempItem.Checked := True;
          b := True;
        end;
{$IFNDEF FPC}
        if (i <> 0) and (i mod 20 = 0) then
          TempItem.Break := mbBreak;
{$ENDIF}

        SkinItem.Add(TempItem);
      end;
    end;
    FreeAndNil(sl);
  end;
end;


procedure TsSystemMenu.MaxClick(Sender: TObject);
begin
  Sendmessage(FForm.Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
  UpdateItems;
end;


procedure TsSystemMenu.MinClick(Sender: TObject);
begin
  FOwner.SkipAnimation := True;
  SendMessage(FOwner.Form.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  FOwner.SkipAnimation := False;
  FOwner.SystemMenu.UpdateItems;
end;


procedure TsSystemMenu.MoveClick(Sender: TObject);
begin
  Sendmessage(FForm.Handle, WM_SYSCOMMAND, SC_MOVE, 0);
end;


procedure TsSystemMenu.RestoreClick(Sender: TObject);
begin
  Sendmessage(FForm.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  UpdateItems;
end;


procedure TsSystemMenu.SizeClick(Sender: TObject);
begin
  Sendmessage(FForm.Handle, WM_SYSCOMMAND, SC_SIZE, 0);
end;


procedure TsSystemMenu.SkinSelect(Sender: TObject);
var
  sSkinName, sInternalSkin: string;
  iIndex: Integer;
begin
  if Assigned(FOwner.SkinData.SkinManager) then begin
    sSkinName := DelChars(TMenuItem(Sender).Caption, '&');
    sInternalSkin := acs_InternalSkin;
    iIndex := Pos(sInternalSkin, sSkinName);
    if iIndex > 0 then
      sSkinName := Copy(sSkinName, 1, iIndex - 1 + Length(sInternalSkin));

    FOwner.SkinData.SkinManager.SkinName := sSkinName;
  end;
end;


procedure TsSystemMenu.UpdateGlyphs;
begin
//
end;


procedure TsSystemMenu.UpdateItems(Full: boolean = False);
begin
  if Full or (ItemClose = nil) then
    Generate;

  if Assigned(Self) and Assigned(FForm) then begin
    if ItemRestore <> nil then begin
      ItemRestore.Visible := VisibleRestore;
      ItemRestore.Enabled := EnabledRestore;
    end;
    if ItemMove <> nil then begin
      ItemMove.Visible := True;
      ItemMove.Enabled := EnabledMove;
    end;
    if ItemSize <> nil then begin
      ItemSize.Visible := VisibleSize;
      ItemSize.Enabled := EnabledSize;
    end;
    if ItemMinimize <> nil then begin
      ItemMinimize.Visible := VisibleMin;
      ItemMinimize.Enabled := EnabledMin;
    end;
    if ItemMaximize <> nil then begin
      ItemMaximize.Visible := VisibleMax;
      ItemMaximize.Enabled := EnabledMax;
    end;
    if ItemClose <> nil then begin
      ItemClose.Visible := VisibleClose;
      ItemClose.Enabled := EnabledClose;
    end;
  end;
end;


function TsSystemMenu.VisibleClose: boolean;
var
  hMenuHandle: hwnd;
begin
  Result := False;
  if FOwner.HaveSysMenu then begin
    hMenuHandle := GetSystemMenu(FForm.Handle, False);
    if hMenuHandle <> 0 then
      Result := integer(GetMenuState(hMenuHandle, SC_CLOSE, MF_BYCOMMAND)) <> -1;
  end
end;


function TsSystemMenu.VisibleMax: boolean;
begin
  if (Self <> nil) and FOwner.HaveSysMenu then
    Result := (IsIconic(Self.FForm.Handle) {$IFDEF D2009}and not (Application.MainFormOnTaskBar and (FForm = Application.MainForm)){$ENDIF}) or
               (TForm(FForm).FormStyle = fsMDIChild) or
               (((FForm.BorderStyle <> bsSingle) or (biMaximize in FOwner.Form.BorderIcons)) and
                not (FForm.BorderStyle in [bsNone, bsSizeToolWin, bsToolWindow, bsDialog]) and
               FOwner.HaveSysMenu) and (biMaximize in FOwner.Form.BorderIcons)
  else
    Result := False;
end;


function TsSystemMenu.VisibleMin: boolean;
begin
  if (Self <> nil) and FOwner.HaveSysMenu then
    if IsIconic(FForm.Handle) or (TForm(FForm).FormStyle = fsMDIChild) then
      Result := True
    else
      Result := not (FForm.BorderStyle in [bsNone, bsDialog, bsSizeToolWin, bsToolWindow]) and
                ((FForm.BorderStyle <> bsSingle) or (biMinimize in FOwner.Form.BorderIcons)) and
                (biMinimize in FOwner.Form.BorderIcons) and FOwner.HaveSysMenu
  else
    Result := False;
end;


function TsSystemMenu.VisibleRestore: boolean;
begin
  if (Self <> nil) and FOwner.HaveSysMenu then
    Result := (TForm(FForm).FormStyle = fsMDIChild) or not (FForm.BorderStyle in [bsNone, bsDialog, bsSizeToolWin, bsToolWindow]) and FOwner.HaveSysMenu
  else
    Result := False;
end;


function TsSystemMenu.VisibleSize: boolean;
begin
  if Self <> nil then
    Result := (TForm(FForm).FormStyle = fsMDIChild) or ((FForm.BorderStyle <> bsDialog) and (FForm.BorderStyle <> bsNone) and (FForm.BorderStyle <> bsToolWindow))
  else
    Result := False;
end;


constructor TsTitleIcon.Create;
begin
  FOwner := AOwner;
  FGlyph := TBitmap.Create;
  FHeight := 0;
  FWidth  := 0;
  FVisible := True;
end;


destructor TsTitleIcon.Destroy;
begin
  FreeAndNil(FGlyph);
  inherited Destroy;
end;


procedure TsTitleIcon.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
end;


procedure TsTitleIcon.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then begin
    FVisible := Value;
    if not (csLoading in FOwner.ComponentState) and not (csDesigning in FOwner.ComponentState) then
      UpdateSkinCaption(FOwner);
  end;
end;


constructor TsTitleButtons.Create(AOwner: TsSkinProvider);
begin
  inherited Create(TsTitleButton);
  FOwner := AOwner;
end;


destructor TsTitleButtons.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;


function TsTitleButtons.GetItem(Index: Integer): TsTitleButton;
begin
  Result := TsTitleButton(inherited GetItem(Index))
end;


function TsTitleButtons.GetOwner: TPersistent;
begin
  Result := FOwner;
end;


procedure TsTitleButtons.SetItem(Index: Integer; Value: TsTitleButton);
begin
  inherited SetItem(Index, Value);
end;


procedure TsTitleButton.AssignTo(Dest: TPersistent);
begin
  if Dest = nil then
    inherited
  else begin
    TsTitleButton(Dest).Enabled := Enabled;
    TsTitleButton(Dest).Glyph := Glyph;
    TsTitleButton(Dest).Hint := Hint;
    TsTitleButton(Dest).Name := Name;
    TsTitleButton(Dest).UseSkinData := UseSkinData;
    TsTitleButton(Dest).OnMouseDown := OnMouseDown;
    TsTitleButton(Dest).OnMouseUp := OnMouseUp;
  end;
end;


constructor TsTitleButton.Create(ACollection: TCollection);
begin
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := OnGlyphChange;
  FUseSkinData := True;
  FEnabled := True;
  FVisible := True;
  HintWnd := nil;
  inherited Create(ACollection);
  if FName = '' then
    FName := ClassName;
end;


destructor TsTitleButton.Destroy;
begin
  if Data.Timer <> nil then
    FreeAndNil(Data.Timer);

  FreeAndNil(FGlyph);
  if HintWnd <> nil then
    FreeAndNil(HintWnd);

  inherited Destroy;
end;


function TsTitleButton.GetDisplayName: string;
begin
  Result := Name;
end;


procedure TsTitleButton.MouseDown(BtnIndex: integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseDown) then
    FOnMouseDown(Self, Button, Shift, X, Y);
end;


procedure TsTitleButton.MouseUp(BtnIndex: integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseUp) then
    FOnMouseUp(Self, Button, Shift, X, Y);
end;


procedure TsTitleButton.OnGlyphChange(Sender: TObject);
begin
  if Data.Timer <> nil then
    FreeAndNil(Data.Timer);
end;


procedure TsTitleButton.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
end;


procedure TsTitleButton.SetName(const Value: string);
begin
  if FName <> Value then
    FName := Value;
end;


procedure TsTitleButton.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then begin
    FVisible := Value;
    UpdateSkinCaption(TsTitleButtons(Collection).FOwner);
  end
end;


procedure TacCtrlAdapter.AddNewItem(const Ctrl: TWinControl);
begin
  AddNewItem(Ctrl, DefaultSection);
end;


procedure TacCtrlAdapter.AddNewItem(const Ctrl: TWinControl; const SkinSection: string);
var
  i, Index, l: integer;
  Found: boolean;
  CanAdd: boolean;
  sp: TsSkinProvider;
  SkinParams: TacSkinParams;
begin
  if Provider.FAllowSkin3rdParty then begin
    if (Ctrl = nil) or (Ctrl.Tag and ExceptTag = ExceptTag) or (Ctrl.Parent = nil) or WndIsSkinned(Ctrl.Handle){GetBoolMsg(Ctrl, AC_CTRLHANDLED)} then
      Exit;

    // Init params
    CanAdd := True;
    SkinParams.SkinSection := SkinSection;
    SkinParams.UseSkinFontColor := True;
    SkinParams.UseSkinColor := True;
    SkinParams.VertScrollSize := -1;
    SkinParams.HorzScrollSize := -1;
    SkinParams.VertScrollBtnSize := -1;
    SkinParams.HorzScrollBtnSize := -1;

    if Assigned(Provider.OnSkinItem) then begin
      Provider.FOnSkinItem(Ctrl, CanAdd, SkinParams.SkinSection);
      if not CanAdd then
        Exit;
    end;

    if Assigned(Provider.FOnSkinItemEx) then begin
      Provider.FOnSkinItemEx(Ctrl, CanAdd, @SkinParams);
      if not CanAdd then
        Exit;
    end;
    if Ctrl is TFrame then begin
  {$IFNDEF ALITE}
      with TsFrameAdapter.Create(Ctrl) do ;
//        SkinData.SkinSection := s_GroupBox;
  {$ENDIF}
      Exit;
    end;
    if Ctrl is TForm then begin
      sp := TsSkinProvider.Create(Ctrl);
      sp.SkinData.SkinSection := iff(SkinParams.SkinSection = '', s_Form, SkinParams.SkinSection);
      sp.PrepareForm;
      InitDwm(Ctrl.Handle, True);
      Exit;
    end;

    Index := -1;
    l := Length(Items);
    Found := False;
    for i := 0 to l - 1 do
      if (Items[i].WinCtrl = Ctrl) then begin // If added in list already, then go to Exit
        Index := i;
        Found := True;
        Break;
      end;

    if Index = -1 then begin
      SetLength(Items, l + 1);
      l := Length(Items);
      Index := l - 1;
      Items[Index] := TacAdapterItem.Create(Self, Ctrl);
    end;
    if Found then begin
      if Assigned(Items[Index].ScrollWnd) and Items[Index].ScrollWnd.Destroyed then begin
        FreeAndNil(Items[Index].ScrollWnd);
        if (Items[Index].WinCtrl.Parent <> nil) then
          Items[Index].DoHook(Ctrl, SkinParams);
      end
    end
    else begin
      if (Items[Index].WinCtrl.Parent <> nil) then
        Items[Index].DoHook(Ctrl, SkinParams);

      if Index < Length(Items) then
        if Items[Index].ScrollWnd = nil then begin // If no success
          FreeAndNil(Items[Index]);
          SetLength(Items, Index);
        end;
    end;
  end;
end;


procedure TacCtrlAdapter.AddNewItem(const Ctrl: TSpeedButton);
var
  i, Index, l: integer;
  Found, CanAdd: boolean;
  SkinParams: TacSkinParams;
begin
  if Provider.FAllowSkin3rdParty then begin
    if (Ctrl = nil) or (Ctrl.Tag and ExceptTag = ExceptTag) or (Ctrl.Parent = nil) or (Ctrl.Perform(SM_ALPHACMD, MakeWParam(0, Word(AC_CTRLHANDLED)), 0) = 1) then
      Exit;

    // Init params
    CanAdd := True;
    SkinParams.SkinSection := s_SpeedButton;
    SkinParams.UseSkinFontColor := True;

    if Assigned(Provider.OnSkinItem) then begin
      Provider.FOnSkinItem(Ctrl, CanAdd, SkinParams.SkinSection);
      if not CanAdd then
        Exit;
    end;

    if Assigned(Provider.FOnSkinItemEx) then begin
      Provider.FOnSkinItemEx(Ctrl, CanAdd, @SkinParams);
      if not CanAdd then
        Exit;
    end;

    Index := -1;
    l := Length(GraphItems);
    Found := False;
    for i := 0 to l - 1 do
      if (GraphItems[i].Ctrl = Ctrl) then begin // If added in list already, then go to Exit
        Index := i;
        Found := True;
        Break;
      end;

    if Index = -1 then begin
      SetLength(GraphItems, l + 1);
      l := Length(GraphItems);
      Index := l - 1;
      GraphItems[Index] := TacGraphItem.Create;
      GraphItems[Index].Adapter := Self;
      GraphItems[Index].Ctrl := Ctrl;
    end;
    GraphItems[Index].SkinData.SkinSection := iff(Ctrl.Flat, s_SpeedButton_Small, s_SpeedButton);
    if Found and Assigned(GraphItems[Index].Handler) and GraphItems[Index].Handler.Destroyed then begin
      FreeAndNil(GraphItems[Index].Handler);
      GraphItems[Index].DoHook(Ctrl);
    end
    else
      if not Found then begin
        if (GraphItems[Index].Ctrl.Parent <> nil) then
          GraphItems[Index].DoHook(Ctrl);

        if GraphItems[Index].Handler = nil then begin
          FreeAndNil(GraphItems[Index]);
          SetLength(GraphItems, Index);
        end;
      end;
  end;
end;


procedure TacCtrlAdapter.AddAllItems(OwnerCtrl: TWinControl = nil);
var
  i: integer;
  sSection: string;
  Owner: TWinControl;
begin
  if Provider.FAllowSkin3rdParty and not bFlag and (srThirdParty in Provider.SkinData.SkinManager.SkinningRules) then begin
    bFlag := True;
    if OwnerCtrl = nil then
      Owner := Provider.Form
    else
      Owner := OwnerCtrl;

    if Owner <> nil then begin
      CleanItems;
      for i := 0 to Owner.ComponentCount - 1 do begin
        if IsControlSupported(Owner.Components[i]) then
          if (Owner.Components[i] is TWinControl) then begin
            sSection := '';
            AddNewItem(TWinControl(Owner.Components[i]), sSection);
          end
          else
            if (Owner.Components[i] is TCustomLabel) and not (Owner.Components[i] is TsCustomLabel) then
              Provider.InitLabel(TCustomLabel(Owner.Components[i]), True);

        if (Owner.Components[i] is TWinControl) then
          if TWinControl(Owner.Components[i]).HandleAllocated then
            if (TWinControl(Owner.Components[i]).Parent <> nil) then begin
              bFlag := False;
              AddAllItems(TWinControl(Owner.Components[i])); // Recursion
            end;
      end;
      for i := 0 to Owner.ControlCount - 1 do begin
        if IsControlSupported(Owner.Controls[i]) then
          if (Owner.Controls[i] is TWinControl) then begin
            sSection := '';
            AddNewItem(TWinControl(Owner.Controls[i]), sSection);
          end
          else
            if (Owner.Controls[i] is TLabel) then
              Provider.InitLabel(Owner.Controls[i], True)
            else
              if (Owner.Controls[i] is TSpeedButton) then
                AddNewItem(TSpeedButton(Owner.Controls[i]));

        if (Owner.Controls[i] is TWinControl) then
          if TWinControl(Owner.Controls[i]).HandleAllocated then
            if (TWinControl(Owner.Controls[i]).Parent <> nil) then begin
              bFlag := False;
              AddAllItems(TWinControl(Owner.Controls[i])); // Recursion
            end

      end;
    end;
    bFlag := False;
  end;
end;


function TacCtrlAdapter.Count: integer;
begin
  Result := Length(Items);
end;


destructor TacCtrlAdapter.Destroy;
begin
  CleanItems;
  RemoveAllItems;
  inherited Destroy;
end;


function TacCtrlAdapter.GetCommonData(Index: integer): TsCommonData;
begin
  Result := nil;
end;


function TacCtrlAdapter.GetItem(Index: integer): TacAdapterItem;
begin
  if (Index > -1) and (Index < Count) then
    Result := Items[Index]
  else
    Result := nil;
end;


function TacCtrlAdapter.IndexOf(Ctrl: TWinControl): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(Items) - 1 do
    if Items[i].WinCtrl = Ctrl then begin
      Result := i;
      Exit;
    end;
end;


procedure TacCtrlAdapter.RemoveItem(Index: integer);
var
  l: integer;
begin
  l := Count;
  if (Index < l) and (l > 0) then begin
    if Items[Index] <> nil then
      FreeAndNil(Items[Index]);

    Items[Index] := Items[l - 1];
    SetLength(Items, l - 1);
  end;
end;


function TacCtrlAdapter.IsControlSupported(Control: TComponent): boolean;

  function CheckSkinEvent: boolean;
  var
    CanAdd: boolean;
    SkinParams: TacSkinParams;
  begin
    CanAdd := True;
    SkinParams.UseSkinFontColor := True;
    SkinParams.UseSkinColor := True;

    if Assigned(Provider.OnSkinItem) then
      Provider.FOnSkinItem(Control, CanAdd, SkinParams.SkinSection);

    if Assigned(Provider.FOnSkinItemEx) then
      Provider.FOnSkinItemEx(Control, CanAdd, @SkinParams);

    Result := SkinParams.UseSkinFontColor and CanAdd;
  end;

  function SearchSupport(Lists: TStringLists; CheckEvent: boolean; var Found: boolean): boolean;
  var
    i, j: integer;
  begin
    Result := False;
    for j := 0 to Length(Lists) - 1 do
      for i := 0 to Lists[j].Count - 1 do
        if Lists[j][i] = Control.ClassName then begin
          Result := True;
          if CheckEvent then
            Found := CheckSkinEvent
          else
            Found := True;

          Exit;
        end;
  end;

begin
  Result := False;
  if (Control.Tag and ExceptTag = ExceptTag) or ((Control is TWinControl) and not CtrlIsReadyForHook(TWinControl(Control))) then
    Exit;

  if not (Control is TWinControl) or not WndIsSkinned(TWinControl(Control).Handle){not GetBoolMsg(TWinControl(Control), AC_CTRLHANDLED)} then
    if not (Control is TGraphicControl) then begin
      if Control is TFrame then
        Result := CheckSkinEvent
      else
        if (Control is TForm) then
          Result := CheckSkinEvent
        else begin
          if Provider.OwnThirdLists then begin
            if SearchSupport(Provider.ThirdLists, False, Result) then
              Exit;
          end
          else
            if SearchSupport(Provider.SkinData.SkinManager.ThirdLists, False, Result) then
              Exit;
        end;
    end
    else
      if (Control is TCustomLabel) then
        Result := CheckSkinEvent
      else
        if (Control is TSpeedButton) then
          // Search if control exists in the List of supported
          if Provider.OwnThirdLists then begin
            if SearchSupport(Provider.ThirdLists, True, Result) then
              Exit;
          end
          else
            if SearchSupport(Provider.SkinData.SkinManager.ThirdLists, True, Result) then
              Exit;
end;


procedure TacCtrlAdapter.RemoveAllItems;
var
  l: integer;
begin
  if not ItemsRemoving then begin
    ItemsRemoving := True;
    while Length(Items) > 0 do begin
      l := Length(Items);
      FreeAndNil(Items[l - 1]);
      SetLength(Items, l - 1);
    end;
    while Length(GraphItems) > 0 do begin
      l := Length(GraphItems);
      if Application.Terminated then begin
        GraphItems[l - 1].Ctrl := nil;
        GraphItems[l - 1].Handler.Ctrl := nil;
      end;
      FreeAndNil(GraphItems[l - 1]);
      SetLength(GraphItems, l - 1);
    end;
    ItemsRemoving := False;
  end;
end;


procedure TacCtrlAdapter.WndProc(var Message: TMessage);
var
  i, l: integer;
begin
  l := Length(Items) - 1;
  for i := 0 to l do
    with Items[i] do
      if (ScrollWnd <> nil) and not ScrollWnd.Destroyed and (WinCtrl.Parent <> nil) then
//        ScrollWnd.ProcessMessage(Message.Msg, Message.WParam, Message.LParam) // Uncomment in Beta
        SendMessage(WinCtrl.Handle, Message.Msg, Message.WParam, Message.LParam)
{ // Not used for TSpeedButton because we doesn't know control exists still or not (we haven't a message about control destroying) // }
end;


procedure TacCtrlAdapter.AfterConstruction;
begin
  inherited;
end;


constructor TacCtrlAdapter.Create(AProvider: TsSkinProvider);
begin
  Provider := AProvider;
  Items := nil;
  ItemsRemoving := False;
  bFlag := False;
end;


procedure TacCtrlAdapter.CleanItems;
var
  i, j, l: integer;
begin
  i := 0;
  while i < Length(Items) do begin
    if (Items[i] = nil) or (Items[i].ScrollWnd = nil) or Items[i].ScrollWnd.Destroyed then begin
      if Items[i] <> nil then
        FreeAndNil(Items[i]);

      l := Length(Items);
      for j := i to l - 2 do begin
        Items[j] := Items[j + 1];
        Items[j + 1] := nil;
      end;
      SetLength(Items, Length(Items) - 1);
    end;
    inc(i)
  end;
  i := 0;
  while i < Length(GraphItems) do begin
    if (GraphItems[i] = nil) or (GraphItems[i].Handler = nil) or GraphItems[i].Handler.Destroyed then begin
      if GraphItems[i] <> nil then
        FreeAndNil(GraphItems[i]);

      for j := i to Length(GraphItems) - 2 do begin
        GraphItems[j] := GraphItems[j + 1];
        GraphItems[j + 1] := nil;
      end;
      SetLength(GraphItems, Length(GraphItems) - 1);
    end;
    inc(i);
  end;
end;


constructor TacAdapterItem.Create(AAdapter: TacCtrlAdapter; ACtrl: TWinControl);
begin
  Adapter := AAdapter;
  WinCtrl := ACtrl;
  ScrollWnd := nil;
  ScrollWnd := nil;
end;


destructor TacAdapterItem.Destroy;
begin
  if (ScrollWnd <> nil) then
    FreeAndNil(ScrollWnd);

  inherited Destroy;
end;


const
  WndTypes: array [TacThirdPartyTypes] of TClass = (TacEditWnd, {$IFDEF D2010}TacButtonWnd{$ELSE}TacBtnWnd{$ENDIF}, TacBitBtnWnd,
    TacCheckBoxWnd, TacComboBoxWnd, TacGridWnd, TacGroupBoxWnd, TacListViewWnd, TacPanelWnd, TacTreeViewWnd, TacWWComboBoxWnd, TacGridEhWnd,
    TacVirtualTreeViewWnd, TacPageControlWnd, TacTabControlWnd, TacToolBarVCLWnd, TacStatusBarWnd, TacEditWnd {SeedButton}, TacScrollBoxWnd,
    TacSpinWnd, {$IFDEF ADDWEBBROWSER} TacWBWnd, {$ENDIF} TacSBWnd, TacStaticTextWnd, TacNativePaint);


procedure TacAdapterItem.DoHook(Control: TWinControl; SkinParams: TacSkinParams);

  procedure SearchSupport(Lists: TStringLists; ClName: string);
  var
    i, j: integer;
  begin
    for j := 0 to Length(Lists) - 1 do
      for i := 0 to Lists[j].Count - 1 do
        if Lists[j][i] = ClName then begin
          ScrollWnd := TacScrollWndClass(WndTypes[TacThirdPartyTypes(j)]).Create(Control.Handle, nil, Adapter.Provider.SkinData.SkinManager, SkinParams);
          ScrollWnd.Adapter := Adapter;
          Exit;
        end;
  end;

begin
  if (Control.Tag and ExceptTag <> ExceptTag) and CtrlIsReadyForHook(Control) and not WndIsSkinned(Control.Handle){not GetBoolMsg(Control, AC_CTRLHANDLED)} and (Adapter.Provider.SkinData.SkinManager <> nil) then begin
    WinCtrl := Control;
    SkinParams.Control := Control;
    if Adapter.Provider.OwnThirdLists then
      SearchSupport(Adapter.Provider.ThirdLists, Control.ClassName)
    else
      SearchSupport(Adapter.Provider.SkinData.SkinManager.ThirdLists, Control.ClassName);
  end;
end;


procedure TacBorderForm.BorderProc(var Message: TMessage);
var
  M2: TWMNCLButtonDown;
  Rgn, NewRgn: hrgn;
  p, Offs: TPoint;
  M: TWMNCHitTest;
  Form: TForm;
  i: integer;
  cR: TRect;
{$IFNDEF NOWNDANIMATION}
  b: byte;
{$ENDIF}
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_SETFOCUS:
      if (sp <> nil) and (sp.Form <> nil) and not (csDestroying in sp.Form.ComponentState) and IsWindowVisible(sp.Form.Handle) then
        if sp.Form.CanFocus and sp.Form.Enabled then
          sp.Form.SetFocus;

    WM_NCMOUSEMOVE: begin
      if SkinData.SkinManager.ActiveGraphControl <> nil then
        SkinData.SkinManager.ActiveGraphControl := nil;

      if LeftPressed then begin
        AForm.SetBounds(AForm.Left + acMousePos.X - LastMousePos.X, AForm.Top + acMousePos.Y - LastMousePos.Y, AForm.Width, AForm.Height);
        LastMousePos := acMousePos;
      end
      else begin
        M.XPos := SmallInt(TWMNCMouseMove(Message).XCursor);
        M.YPos := SmallInt(TWMNCMouseMove(Message).YCursor);
        Message.Result := Ex_WMNCHitTest(M);
        case Message.Result of
          HTCLOSE, HTMINBUTTON, HTMAXBUTTON, HTHELP, HTUDBTN..HTITEM + 100:
            SetHotHT(Message.Result) // Title icon hovered
          else begin
            SetHotHT(0);

            if MaxMoving and IsZoomed(TsSkinProvider(FOwner).Form.Handle) then begin
              p := acMousePos;
              if (abs(LastMousePos.X - p.X) > 5) or (abs(LastMousePos.Y - p.Y) > 5) then begin
                Self.ExBorderShowing := True; // Lock visual changes
                TsSkinProvider(FOwner).Form.WindowState := wsNormal;
                p.X := p.X - TsSkinProvider(FOwner).Form.Width div 2;
                if BetWeen(p.Y, 0, 24) then
                  p.Y := -8
                else
                  p.Y := p.Y - 8;

                TsSkinProvider(FOwner).Form.SetBounds(p.X, p.Y, TsSkinProvider(FOwner).Form.Width, TsSkinProvider(FOwner).Form.Height);
                ExBorderShowing := False; // Unlock visual changes
{$IFNDEF NOWNDANIMATION}
                if SkinData.SkinManager.AnimEffects.BlendOnMoving.Active and
                     not ((SkinData.SkinManager.AnimEffects.BlendOnMoving.BlendValue = MaxByte) or not TsSkinProvider(FOwner).AllowBlendOnMoving) then
                  TsSkinProvider(FOwner).StartMoveForm
                else
{$ENDIF}
                begin
                  M2.Msg := WM_NCLBUTTONDOWN;
                  M2.HitTest := HTCAPTION;
                  with acMousePos do begin
                    M2.XCursor := X;
                    M2.YCursor := Y;
                  end;
                  BorderProc(TMessage(M2));
                end;
                MaxMoving := False;
              end;
            end;
          end;
        end;
      end;
    end;

    WM_MOUSEMOVE, WM_LBUTTONDOWN..WM_MBUTTONDBLCLK:
      if MouseAboveTheShadow(TWMMouse(Message)) then begin
        if SkinData.SkinManager.ActiveGraphControl <> nil then
          SkinData.SkinManager.ActiveGraphControl := nil;

        acInMouseMsg := True;
        NewRgn := CreateRectRgn(TWMMouse(Message).XPos, TWMMouse(Message).YPos, TWMMouse(Message).XPos + 1, TWMMouse(Message).YPos + 1);
        Rgn := MakeRgn;
        if Rgn = 0 then
          Rgn := CreateRectRgn(0, 0, AForm.Width, AForm.Height);

        CombineRgn(Rgn, Rgn, NewRgn, RGN_XOR);
        DeleteObject(NewRgn);
        if (FOwner is TsSkinProvider) then
          if not (fsModal in TAccessForm(TsSkinProvider(FOwner).Form).FormState {Report builder repainting bug} ) then
            SetWindowRgn(AForm.Handle, Rgn, False)
          else
            DeleteObject(Rgn)
        else
          SetWindowRgn(AForm.Handle, Rgn, False);

        ResetRgn := True;
        acInMouseMsg := False;
        Exit;
      end;

    WM_NCHITTEST:
      if MouseAboveTheShadow(TWMMouse(Message)) then begin
        Message.Result := HTTRANSPARENT;
        OldBorderProc(Message);
      end
      else begin
        OldBorderProc(Message);
        Message.Result := LRESULT(Windows.HTOBJECT);
      end;

    WM_NCLBUTTONDBLCLK: begin
      MaxMoving := False;
      if (FOwner is TsSkinProvider) then
        if (TsSkinProvider(FOwner).ResizeMode = rmBorder) and TsSkinProvider(FOwner).bInProcess then begin
          p := TsSkinProvider(FOwner).Form.ClientToScreen(Point(TWMMouse(Message).XPos, TWMMouse(Message).YPos));
          TsSkinProvider(FOwner).StopMove(p.x, p.y);
          ReleaseCapture;
          TsSkinProvider(FOwner).bInProcess := False;
        end;

      TWMNCHitMessage(Message).HitTest := Ex_WMNCHitTest(TWMNCHitTest(Message));
      if (FOwner is TsSkinProvider) then
        case TWMNCHitMessage(Message).HitTest of
          HTSYSMENU:
            SendMessage(OwnerHandle, WM_SYSCOMMAND, SC_CLOSE, 0);

          HTCAPTION:
            with TsSkinProvider(FOwner) do begin
              if HaveSysMenu and (SystemMenu.EnabledMax or SystemMenu.EnabledRestore) or not HaveBorder(TsSkinProvider(FOwner)) and IsIconic(TsSkinProvider(FOwner).Form.Handle) then begin
                SendMessage(Form.Handle, WM_SYSCOMMAND, StateFlags[(Form.WindowState = wsMaximized) or IsIconic(Form.Handle)], 0);
                SystemMenu.UpdateItems;
              end
              else
                if IsIconic(Form.Handle) then begin
                  SendMessage(Form.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
                  SystemMenu.UpdateItems;
                end;

              TWMNCHitMessage(Message).HitTest := 0;
            end;

          HTRIGHT, HTLEFT: begin
            Form := sp.Form;
            if (Form.BorderStyle = bsSizeable) then
              if FormState and FS_MAXWIDTH = FS_MAXWIDTH then begin
                Form.SetBounds(sp.NormalBounds.Left, sp.Form.Top, sp.NormalBounds.Right, Form.Height);
                sp.FormState := sp.FormState and not FS_MAXWIDTH;
              end
              else begin
                cR := acWorkRect(Form);
                i := DiffBorder(Self);
                sp.NormalBounds.Left  := Form.Left;
                sp.NormalBounds.Right := Form.Width;
                Form.SetBounds(cR.Left + i, Form.Top, WidthOf(cR) - 2 * i, Form.Height);
                sp.FormState := sp.FormState or FS_MAXWIDTH;
              end;
          end;

          HTTOP, HTBOTTOM: begin
            Form := sp.Form;
            if (Form.BorderStyle = bsSizeable) then
              if FormState and FS_MAXHEIGHT = FS_MAXHEIGHT then begin
                Form.SetBounds(Form.Left, sp.NormalBounds.Top, Form.Width, sp.NormalBounds.Bottom);
                sp.FormState := sp.FormState and not FS_MAXHEIGHT;
              end
              else begin
                cR := acWorkRect(Form);
                i := DiffTitle(Self);
                sp.NormalBounds.Top := Form.Top;
                sp.NormalBounds.Bottom := Form.Height;
                Form.SetBounds(Form.Left, cR.Top + i, Form.Width, HeightOf(cR) - i - DiffBorder(Self));
                sp.FormState := sp.FormState or FS_MAXHEIGHT;
              end;
          end;

          HTITEM..HTITEM + MaxByte:
            with TsSkinProvider(FOwner) do
              if (FOwner is TsSkinProvider) and Assigned(FTitleBar) then
                with TWMNCHitMessage(Message) do begin
                  if FTitleBar.Items[HitTest - HTITEM].Timer <> nil then
                    FreeAndNil(FTitleBar.Items[HitTest - HTITEM].Timer);

                  SetHotHT(HitTest);
                  SetPressedHT(HitTest);
                  FTitleBar.Items[HitTest - HTITEM].DoClick;
                end;
        end;
    end;

    WM_SETCURSOR:
      if not Ex_WMSetCursor(TWMSetCursor(Message)) then
        OldBorderProc(Message);

    WM_MOUSEACTIVATE: begin
      Message.Result := MA_NOACTIVATE;
      if (FOwner is TsSkinProvider) then begin
        if TsSkinProvider(FOwner).Form.Enabled then
          SetForegroundWindow(OwnerHandle);
      end
      else
        if IsWindowEnabled(OwnerHandle) then
          SetForegroundWindow(OwnerHandle);
    end;

    WM_NCRBUTTONUP:
      if not MouseAboveTheShadow(TWMMouse(Message)) then begin
        TWMNCLButtonDown(Message).HitTest := HTTRANSPARENT;
        SendMessage(OwnerHandle, Message.Msg, Message.wParam, Message.lParam);
      end;

    WM_NCLBUTTONUP:
      if not MouseAboveTheShadow(TWMMouse(Message)) then begin
        MaxMoving := False;
        TWMNCLButtonDown(Message).HitTest := HTTRANSPARENT;
        SendMessage(OwnerHandle, Message.Msg, Message.wParam, Message.lParam);
      end;

    WM_NCRBUTTONDOWN:
      if not MouseAboveTheShadow(TWMMouse(Message)) then begin
        TWMNCLButtonDown(Message).HitTest := Ex_WMNCHitTest(TWMNCHitTest(Message));
        SendMessage(OwnerHandle, Message.Msg, Message.wParam, Message.lParam);
      end;

    WM_NCLBUTTONDOWN:
      if not MouseAboveTheShadow(TWMMouse(Message)) then begin
        ExBorderShowing := False;
        if not MaxMoving then
          TWMNCLButtonDown(Message).HitTest := HTTRANSPARENT;
{$IFNDEF NOWNDANIMATION}
        i := Ex_WMNCHitTest(TWMNCHitTest(Message));
        case i of
          HTSYSMENU: begin
            SendMessage(OwnerHandle, Message.Msg, i, Message.lParam);
            Exit;
          end;

          HTCAPTION:
            if FOwner is TsSkinProvider then
              if not IsZoomed(OwnerHandle) then begin
                if SkinData.SkinManager.AnimEffects.BlendOnMoving.Active and
                     not IsIconic(OwnerHandle) and not (AeroIsEnabled and
                       ((SkinData.SkinManager.AnimEffects.BlendOnMoving.BlendValue = MaxByte) or
                         not TsSkinProvider(FOwner).AllowBlendOnMoving){ AlphaMoving is not required then begin} ) then begin
                  StartBlendOnMoving(TsSkinProvider(FOwner));
                  Exit;
                end;
              end
              else begin // Emulation of Aero behaviour
                MaxMoving := True;
                LastMousePos := acMousePos;
                Exit;
              end
            else
              if SkinData.SkinManager.AnimEffects.BlendOnMoving.Active then begin
                StartBlendOnMovingDlg(TacDialogWnd(FOwner));
                Exit;
              end;
        end;
        if not MaxMoving then
          TWMNCLButtonDown(Message).HitTest := HTTRANSPARENT;
{$ENDIF}
        SendMessage(OwnerHandle, Message.Msg, Message.wParam, Message.lParam);
      end;

    WM_WINDOWPOSCHANGING:
      if (FOwner is TsSkinProvider) and (FormState and FS_BLENDMOVING = FS_BLENDMOVING){ and (FormState and FS_ANIMMINIMIZING = FS_ANIMMINIMIZING)} then begin
        if TsSkinProvider(FOwner).FScreenSnap and
              not IsZoomed(TsSkinProvider(FOwner).Form.Handle) and
                ((TWMWindowPosChanging(Message).WindowPos^.X <> 0) or (TWMWindowPosChanging(Message).WindowPos^.Y <> 0)) then
          with TWMWindowPosChanging(Message).WindowPos^ do begin
            if SkinData.SkinManager.CommonSkinData.ExDrawMode = 0 then begin
              Offs.X := DiffBorder(Self) + ShadowSize.Left;
              Offs.Y := DiffTitle(Self)  + ShadowSize.Top;
            end
            else begin
              Offs.X := DiffBorder(Self) + SkinData.SkinManager.CommonSkinData.ExContentOffs;
              Offs.Y := DiffTitle(Self)  + SkinData.SkinManager.CommonSkinData.ExContentOffs;
            end;
            p := Point(X + Offs.X, Y + Offs.Y);
            TsSkinProvider(FOwner).CheckNewPosition(p.X, p.Y);
            X := p.X - Offs.X;
            Y := p.Y - Offs.Y;
          end;

        OldBorderProc(Message);
        sp.BorderForm.LastTopLeft := sp.BorderForm.AForm.BoundsRect.TopLeft;
      end
      else
        OldBorderProc(Message);

{$IFNDEF NOWNDANIMATION}
    WM_SHOWWINDOW:
      if acLayered and (FOwner is TsSkinProvider) and
           not InAnimationProcess{$IFDEF D2007} and Application.MainFormOnTaskBar {$ENDIF} and
             TsSkinProvider(FOwner).DrawNonClientArea and
               (TsSkinProvider(FOwner).Form = Application.MainForm) then begin

        if (Message.WParam = 0) and (Message.LParam in [0, SW_PARENTCLOSING]) then
          if (FormState and FS_ANIMMINIMIZING = FS_ANIMMINIMIZING) then begin
            Message.Result := 0;
            Exit;
          end
          else
            if (FormState and FS_ANIMCLOSING <> FS_ANIMCLOSING) then begin // Prepare cache if closed with Application.MainFormOnTaskBar (Animation in Application terminating)
              if TsSkinProvider(FOwner).AllowAnimation and
                   SkinData.SkinManager.AnimEffects.FormHide.Active and
                     SkinData.SkinManager.Effects.AllowAnimation and
                       (TsSkinProvider(FOwner).SkinData.SkinManager.ShowState <> saMinimize) then begin // Patch for BDS when MainFormOnTaskBAr
                TsSkinProvider(FOwner).FormState := TsSkinProvider(FOwner).FormState or FS_ANIMCLOSING;
                TsSkinProvider(FOwner).SkinData.FCacheBmp := GetFormImage(TsSkinProvider(FOwner), True);
                ExBorderShowing := True;
{$IFDEF DELPHI7UP}
                if TsSkinProvider(FOwner).Form.AlphaBlend then
                  b := TsSkinProvider(FOwner).Form.AlphaBlendValue
                else
{$ENDIF}
                  b := MaxByte;
{$IFDEF D2010}
                if not Application.MainFormOnTaskBar then // Ignore std closing of ext borders
{$ENDIF}
                begin
                  SetFormBlendValue(AForm.Handle, SkinData.FCacheBmp, b);
                  SetWindowRgn(AForm.Handle, MakeRgn, False);
                  SetWindowPos(AForm.Handle, 0, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
                end;
                Exit;
              end;
            end
            else
              Exit;

        OldBorderProc(Message);
      end
      else
        if (TsSkinProvider(FOwner).Form = Application.MainForm) then
{$IFDEF D2010}
          if not Application.Terminated and not Application.MainFormOnTaskBar or (Message.WParam = 1) then // Ignore std closing of ext borders
{$ENDIF}
            OldBorderProc(Message);
{$ENDIF}

    WM_WINDOWPOSCHANGED: begin
      KillAnimations;
      OldBorderProc(Message);
      if (sp <> nil) and not (csDestroying in sp.ComponentState) and not (csDestroying in sp.Form.ComponentState) and (AForm <> nil) and not (csDestroying in AForm.ComponentState) then begin
        if (sp.FormTimer = nil) and IsIconic(sp.Form.Handle) then
          if (sp.FormState and FS_ANIMMINIMIZING <> FS_ANIMMINIMIZING) then begin { Form.WindowState = wsMinimized}
            sp.SkinData.BGChanged := True;
            UpdateExBordersPos(False);
          end;

        if (sp.Form.FormStyle = fsStayOnTop) and AForm.HandleAllocated then
          SetWindowPos(AForm.Handle, iff(AeroIsEnabled and (Application.MainForm = sp.Form) and (GetActiveWindow = sp.Form.Handle), GetTopWnd{HWND_TOPMOST}, sp.Form.Handle),
                      0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER)
      end;
    end;

    WM_ERASEBKGND, WM_NCPAINT:;

    WM_MOVE: begin
      if (sp <> nil) and (sp.FormState and FS_BLENDMOVING = FS_BLENDMOVING) and ((AForm.Top < MinTopCoord) or MovRgnChanged) then begin
        ResetRgn := True;
        UpdateRgn;
      end;
      if sp is TsSkinProvider then
        TsSkinProvider(sp).MoveGluedForms(True);
    end

    else
      OldBorderProc(Message);
  end;
end;


constructor TacBorderForm.Create(AOwner: TObject);
begin
  FOwner := AOwner;
  if FOwner is TsSkinProvider then
    sp := TsSkinProvider(FOwner)
  else
    sp := nil;

  LeftPressed := False;
  LastMousePos := Point(-9999, -9999);
  ParentHandle := 0;
  ExBorderShowing := False;
  ResetRgn := False;
  MovRgnChanged := False;
  CreateNewForm;
end;


destructor TacBorderForm.Destroy;
var
  i: integer;
begin
  KillAnimations;
  if AForm <> nil then
    FreeAndNil(AForm);

  if Assigned(sp) and not (csDestroying in sp.ComponentState) and Assigned(sp.FTitleBar) then
    with sp.FTitleBar do
      if Assigned(Items) then
        for i := 0 to Items.Count - 1 do
          Items[i].ExtForm := nil;

  inherited;
end;


function TacBorderForm.Ex_WMNCHitTest(var Message: TWMNCHitTest): integer;
const
  BtnSpacing = 1;
  DefRESULT = HTTRANSPARENT;
var
  p: TPoint;
  Handle: hwnd;
  rShadow, R, hrect, vrect: TRect;
  SysMenu: TsCustomSysMenu;
  i, SysBtnCount, BtnIndex: integer;
  GripVisible, HelpIconVisible, CloseIconVisible: boolean;

  function GetBtnIndex: integer;
  var
    i, c: integer;
  begin
    Result := 0;
    c := 0;
    if (FOwner is TsSkinProvider) then
      with TsSkinProvider(FOwner) do begin
        if SystemMenu = nil then // not initialize yet
          Exit;

        if HaveSysMenu and Assigned(SystemMenu) then begin
          inc(c);
          if PtInRect(ButtonClose.Rect, p) then
            Result := c
          else begin
            if SystemMenu.VisibleMax then begin
              inc(c);
              if PtInRect(ButtonMax.Rect, p) then begin
                Result := c;
                Exit;
              end;
            end;
            if SystemMenu.VisibleMin then begin
              inc(c);
              if PtInRect(ButtonMin.Rect, p) then
                Result := c;
            end;
            if Result <> 0 then
              Exit;

            if (biHelp in Form.BorderIcons) then begin
              inc(c);
              if PtInRect(ButtonHelp.Rect, p) then begin
                Result := c;
                Exit;
              end;
            end;
          end;
        end;
        for i := 0 to TitleButtons.Count - 1 do begin
          inc(c);
          if not TitleButtons[i].Visible then
            Continue;

          if PtInRect(TitleButtons[i].Data.Rect, p) then begin
            Result := c;
            Exit;
          end;
        end;
        // Title bar items
        if FTitleBar <> nil then
          for i := 0 to FTitleBar.Items.Count - 1 do begin
            inc(c);
            if not FTitleBar.Items[i].Visible then
              Continue;

            if PtInRect(FTitleBar.Items[i].Rect, p) then begin
              Result := iff(FTitleBar.Items[i].Style in [bsSpacing, bsInfo], 0, c);
              Exit;
            end;
          end;
      end
    else
      with FOwner as TacDialogWnd do begin
        inc(c);
        if PtInRect(TacDialogWnd(FOwner).ButtonClose.Rect, p) then
          Result := c
        else begin
          if SystemMenu.VisibleMax then begin
            inc(c);
            if PtInRect(TacDialogWnd(FOwner).ButtonMax.Rect, p) then begin
              Result := c;
              Exit;
            end;
          end;
          if SystemMenu.VisibleMin then begin
            inc(c);
            if PtInRect(TacDialogWnd(FOwner).ButtonMin.Rect, p) then
              Result := c
          end;
          if Result = 0 then
            if TacDialogWnd(FOwner).VisibleHelp then begin
              inc(c);
              if PtInRect(TacDialogWnd(FOwner).ButtonHelp.Rect, p) then begin
                Result := c;
                Exit;
              end;
            end;
        end;
      end
  end;

begin
  if (FOwner is TsSkinProvider) then begin
    Message.Result := Windows.HTNOWHERE;
    if Assigned(sp.FOnExtHitTest) then
      sp.FOnExtHitTest(TWMNcHitTest(Message));

    if Message.Result <> Windows.HTNOWHERE then begin
      Result := Message.Result;
      Exit;
    end;
  end;
  Result := DefRESULT;
  if IsWindowEnabled(OwnerHandle) then begin
    p := Point(Message.XPos - AForm.Left, Message.YPos - AForm.Top);
    if FOwner is TsSkinProvider then begin
      SysMenu := sp.SystemMenu;
      Handle := sp.Form.Handle;
      CloseIconVisible := sp.HaveSysMenu;
    end
    else begin
      SysMenu := TacDialogWnd(FOwner).SystemMenu;
      Handle := TacDialogWnd(FOwner).CtrlHandle;
      CloseIconVisible := TacDialogWnd(FOwner).SystemMenu.VisibleClose;
    end;
    rShadow := SkinData.SkinManager.FormShadowSize;
    HelpIconVisible := GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CONTEXTHELP = WS_EX_CONTEXTHELP;
    with FOwner do begin
      BtnIndex := GetBtnIndex;
      if (BtnIndex > 0) then begin
        SysBtnCount := 0;
        if CloseIconVisible then begin
          inc(SysBtnCount);
          if SysMenu.VisibleMax then
            inc(SysBtnCount);

          if SysMenu.VisibleMin or IsIconic(OwnerHandle) then
            inc(SysBtnCount);

          if HelpIconVisible then
            inc(SysBtnCount);
        end;
        if (BtnIndex <= SysBtnCount) then begin
          case BtnIndex of
            1:
              if CloseIconVisible then
                if FOwner is TsSkinProvider then
                  if sp.SystemMenu.VisibleClose then
                    Result := iff(sp.SystemMenu.EnabledClose, HTCLOSE, HTCAPTION)
                  else
                    Result := Windows.HTNOWHERE
                else
                  Result := iff(TacDialogWnd(FOwner).EnabledClose, HTCLOSE, Windows.HTNOWHERE);

            2:
              if SysMenu.VisibleMax then
                Result := iff(SysMenu.EnabledMax or (SysMenu.EnabledRestore and not IsIconic(Handle)), HTMAXBUTTON, HTCAPTION)
              else
                if (SysMenu.VisibleMin) or IsIconic(Handle) then
                  Result := iff(SysMenu.EnabledMin, HTMINBUTTON, HTCAPTION)
                else
                  if HelpIconVisible then
                    Result := HTHELP;

            3:
              if (SysMenu.VisibleMin) or IsIconic(Handle) then
                if not IsIconic(Handle) then
                  Result := iff(SysMenu.EnabledMin, HTMINBUTTON, HTCAPTION)
                else
                  Result := HTMINBUTTON
              else
                if HelpIconVisible then
                  Result := HTHELP;

            4:
              if HelpIconVisible and SysMenu.VisibleMax then
                Result := HTHELP;
          end;
        end
        else
          if (FOwner is TsSkinProvider) then
            if (BtnIndex <= sp.TitleButtons.Count + SysBtnCount) then begin // UDF button
              BtnIndex := BtnIndex - SysBtnCount - 1;
              if sp.TitleButtons.Items[BtnIndex].Enabled then
                Result := HTUDBTN + BtnIndex;
            end
            else
              if sp.FTitleBar <> nil then begin
                BtnIndex := BtnIndex - SysBtnCount - sp.TitleButtons.Count - 1;
                if sp.FTitleBar.Items[BtnIndex].Enabled and
                     ((sp.FTitleBar.Items[BtnIndex].Style <> bsTab) or
                        not sp.FTitleBar.Items[BtnIndex].Down) then

                  Result := HTITEM + BtnIndex;
              end;

        if Result <> DefRESULT then
          Exit;
      end;

     if not IsZoomed(Handle) and (GetWindowLong(Handle, GWL_STYLE) and WS_SIZEBOX = WS_SIZEBOX) then
        with SkinData.SkinManager.CommonSkinData do
          if SkinData.SkinManager.CommonSkinData.ExDrawMode = 1 then begin // If borders replaced
            R := Rect(rShadow.Left - SkinData.SkinManager.CommonSkinData.ExShadowOffs,
                      rShadow.Top - ExShadowOffsT,
                      AForm.Width - rShadow.Right + ExShadowOffsR,
                      AForm.Height - rShadow.Bottom + ExShadowOffsB);
            if PtInRect(R, p) then begin
              if Between(p.Y, rShadow.Top - ExShadowOffsT, 4{SysBorderWidth(Handle, Self, False)} + rShadow.Top - ExShadowOffsT) then
                Result := HTTOP;

              if Between(p.Y, AForm.Height - SysBorderWidth(Handle, Self, False) - rShadow.Bottom + ExShadowOffsB, AForm.Height - rShadow.Bottom + ExShadowOffsB) then
                Result := HTBOTTOM;

              if Between(p.X, rShadow.Left - ExShadowOffs, SysBorderWidth(Handle, Self, False) + rShadow.Left - ExShadowOffs) then
                if Result = HTTOP then
                  Result := HTTOPLEFT
                else
                  Result := iff(Result = HTBOTTOM, HTBOTTOMLEFT, HTLEFT);

              if Between(p.X, AForm.Width - SysBorderWidth(Handle, Self, False) - rShadow.Right + ExShadowOffsR, AForm.Width - rShadow.Right + ExShadowOffsR) then
                if Result = HTTOP then
                  Result := HTTOPRIGHT
                else
                  Result := iff(Result = HTBOTTOM, HTBOTTOMRIGHT, HTRIGHT);

              if Result <> DefRESULT then
                Exit;
            end;
          end
          else begin
            i := max(ExBorderWidth, iMinBorderSize);
            if Between(p.Y, rShadow.Top - i, rShadow.Top) then
              Result := HTTOP;

            if Between(p.Y, AForm.Height - rShadow.Bottom, AForm.Height - rShadow.Bottom + i) then
              Result := HTBOTTOM;

            if Between(p.X, rShadow.Left - i, rShadow.Left) then
              if Result = HTTOP then
                Result := HTTOPLEFT
              else
                Result := iff(Result = HTBOTTOM, HTBOTTOMLEFT, HTLEFT);

            if Between(p.X, AForm.Width - rShadow.Right, AForm.Width - rShadow.Right + i) then
              if Result = HTTOP then
                Result := HTTOPRIGHT
              else
                Result := iff(Result = HTBOTTOM, HTBOTTOMRIGHT, HTRIGHT);

            if Result <> DefRESULT then
              Exit;
          end;

      if Between(p.Y, 0, CaptionHeight + SysBorderHeight(OwnerHandle, Self) + rShadow.Top) then
        Result := iff(PtInRect(IconRect, p), HTSYSMENU, HTCAPTION)
      else
        if p.Y <= CaptionHeight + SysBorderHeight(OwnerHandle, Self) + MenuHeight then
          Result := HTMENU
        else
          if PtInRect(Rect(ShadowSize.Left, ShadowSize.Top, AForm.Width - ShadowSize.Right, AForm.Height - ShadowSize.Bottom), p) then begin // Grip?
            GripVisible := False;
            if (FOwner is TsSkinProvider) then
              with TsSkinProvider(FOwner) do
                if IsGripVisible(TsSkinProvider(FOwner)) then
                  GripVisible := True
                else
                  if Assigned(ListSW) and Assigned(ListSW.sbarVert) and ListSW.sbarVert.fScrollVisible and ListSW.sbarHorz.fScrollVisible then begin
                    Ac_GetHScrollRect(ListSW, Form.Handle, hrect);
                    Ac_GetVScrollRect(ListSW, Form.Handle, vrect);
                    GetWindowRect(Form.Handle, R);
                    GripVisible := PtInRect(Rect(hrect.Right - R.Left, hrect.Top - R.Top, vrect.Right - R.Left, hrect.Bottom - R.Top), p)
                  end;

            if GripVisible then begin
              i := SkinData.SkinManager.ConstData.GripRightBottom;
              if SkinData.SkinManager.IsValidImgIndex(i) then
                if (p.y > TsSkinProvider(FOwner).RBGripPoint(i).y) and (p.x > TsSkinProvider(FOwner).RBGripPoint(i).x) then
                  Result := HTBOTTOMRIGHT;
            end;
          end;
    end;
  end;
end;


function TacBorderForm.Ex_WMSetCursor(var Message: TWMSetCursor): boolean;
var
  M: TWMNCHitTest;
  nCursor: HCURSOR;
begin
  M.Msg := WM_NCHitTest;
  M.XPos := SmallInt(acMousePos.X);
  M.YPos := SmallInt(acMousePos.Y);
  M.Unused := 0;
  M.Result := 0;
  Message.HitTest := {$IFDEF D2009}SmallInt{$ELSE}Word{$ENDIF}(Ex_WMNCHitTest(M));
  Result := False;
  if not MouseAboveTheShadow(TWMMouse(M)) then begin
    nCursor := 0;
    case Message.HitTest of
      HTCAPTION, HTMENU:        nCursor := LoadCursor(0, IDC_ARROW);
      HTLEFT, HTRIGHT:          nCursor := LoadCursor(0, IDC_SIZEWE);
      HTTOP, HTBOTTOM:          nCursor := LoadCursor(0, IDC_SIZENS);
      HTTOPRIGHT, HTBOTTOMLEFT: nCursor := LoadCursor(0, IDC_SIZENESW);
      HTTOPLeft, HTBOTTOMRIGHT: nCursor := LoadCursor(0, IDC_SIZENWSE)
    end;
    if nCursor <> 0 then begin
      SetCursor(nCursor);
      Result := True;
    end;
  end
end;


function TacBorderForm.MouseAboveTheShadow(Message: TWMMouse): boolean;
var
  p: TPoint;
  i: integer;
begin
  Result := False;
  if FormState and FS_BLENDMOVING <> FS_BLENDMOVING then begin
    UpdateRgn;
    if not (csDestroying in Application.ComponentState) and
         (SkinData <> nil) and
           (AForm <> nil) and
             (Self.SkinData.SkinManager <> nil) and
               Self.SkinData.SkinManager.Active then begin
      if Message.Msg = WM_MOUSEMOVE then
        p := Point(Message.XPos, Message.YPos)
      else
        p := Point(Message.XPos - AForm.Left, Message.YPos - AForm.Top);

      if not IsZoomed(OwnerHandle) then
        with SkinData.SkinManager.CommonSkinData do
          if ExDrawMode = 1 then begin
            if (p.Y < ShadowSize.Top - ExShadowOffsT) or
                 (p.Y > AForm.Height - ShadowSize.Bottom + ExShadowOffsB) or
                   (p.X < ShadowSize.Left - ExShadowOffs) or
                     (p.X > AForm.Width - ShadowSize.Right + ExShadowOffsR) then begin
              Result := True;
              SetHotHT(HTTRANSPARENT);
            end;
          end
          else begin
            i := max(iMinBorderSize, ExBorderWidth);
            if (p.Y < ShadowSize.Top - i) or
                 (p.Y > AForm.Height - ShadowSize.Bottom + i) or
                   (p.X < ShadowSize.Left - i) or
                     (p.X > AForm.Width - ShadowSize.Right + i) then begin
              Result := True;
              SetHotHT(HTTRANSPARENT);
            end;
          end;
    end;
  end;
end;


const
  wScreenOffset = {$IFDEF D2010}90{$ELSE}{$IFDEF D2009}86{$ELSE}90{$ENDIF}{$ENDIF};

type
  TOffsetArray = array [0..wScreenOffset] of byte;

  TAccessScreen = class(TComponent)
  public
    Offset: TOffsetArray;
    FAlignLevel: Word;
  end;

  
procedure TacBorderForm.UpdateExBordersPos(Redraw: boolean = True; Blend: byte = MaxByte);
var
  bRgn: hrgn;
  oWnd: THandle;
  FBmpSize: TSize;
  Flags: Cardinal;
  iInsAfter: hwnd;
  SavedDC, DC: hdc;
  ShSize, R, fR: TRect;
  bSizeChanged: boolean;
  FBlend: TBlendFunction;
  p, FBmpTopLeft: TPoint;
  w, h, cy, cx, yAeroTab: integer;

  procedure MakeBluringRgn;
  var
    subrgn: hrgn;
    Offset: integer;

    procedure HandleRect(R: TRect);
    var
      X, Y: integer;
    begin
      for Y := R.Top to R.Bottom do
        for X := R.Left to R.Right do
          with GetAPixel(SkinData.FCacheBmp, X, Y) do
            if (R = 0) and (G = 0) and (B = 0) then begin // Black color is not blurred
              subrgn := CreateRectRgn(X, Y, X + 1, Y + 1);
              CombineRgn(bRgn, bRgn, subrgn, RGN_DIFF);
              DeleteObject(subrgn);
            end;
    end;

  begin
    fR := Rect(ShSize.Left - 1, ShSize.Top - 1, AForm.Width - ShSize.Right + 1, AForm.Height - ShSize.Bottom + 1);
    bRgn := CreateRectRgn(fR.Left, fR.Top, fR.Right, fR.Bottom);
    Offset := SkinData.SkinManager.CommonSkinData.ExContentOffs;
    // Top left
    R := Rect(fR.Left, fR.Top, fR.Left + Offset, fR.Top + Offset);
    HandleRect(R);
    // Top rigth
    R := Rect(fR.Right - Offset, fR.Top, fR.Right, fR.Top + Offset);
    HandleRect(R);
    // Bottom left
    R := Rect(fR.Left, fR.Bottom - Offset, fR.Left + Offset, fR.Bottom);
    HandleRect(R);
    // Bottom right
    R := Rect(fR.Right - Offset, fR.Bottom - Offset, fR.Right, fR.Bottom);
    HandleRect(R);
  end;

begin
  with FOwner do begin
    oWnd := OwnerHandle;
    if Application.Terminated or
         ExBorderShowing or
           (oWnd = 0) or
             not GetWindowRect(oWnd, fR) or
               (SkinData.PrintDC <> 0) or
                 InAnimationProcess then
      Exit;

    if (sp <> nil) and (fR.Left <> sp.Form.Left) and not IsIconic(oWnd) then
      Exit; // Window Rect is not correct

    if (AForm = nil) then
      CreateNewForm;

    if sp <> nil then begin
      if sp.SkinData.CtrlSkinState and ACS_LOCKED = ACS_LOCKED then
        Exit;

      if InAnimation(sp) or
           SkinData.FUpdating or
             not sp.DrawNonClientArea
               or (TAccessScreen(Screen).FAlignLevel = 1) then
        Exit;

      if (csDestroying in sp.ComponentState) or (csDestroying in sp.Form.ComponentState) then begin
        sp.InitExBorders(False);
        Exit;
      end
      else
        if not (IsWindowVisible(sp.Form.Handle) or ((sp.FormState <> 0) and (sp.FormState <> FS_ACTIVATE))) then begin
          FreeAndNil(AForm);
          SkinData.BGChanged := True; // Whole image will be redrawn later
          Exit;
        end;

      ExBorderShowing := True;
      if sp.Form.FormStyle = fsStayOnTop then begin // Patch for a Delphi problem concerning StayOnTop forms
        if (GetActiveWindow = ownd) then begin
          SetWindowPos(oWnd, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING);
          SendOwnerToBack;
        end;
      end
      else
        if GetWindowLong(oWnd, GWL_EXSTYLE) and WS_EX_TOPMOST = WS_EX_TOPMOST then begin
          SetWindowPos(oWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING);
          SendOwnerToBack;
        end;

      iInsAfter := GetTopWnd;
      ExBorderShowing := True;
      yAeroTab := 0;
    end
    else begin // sp = nil
      if not IsWindowVisible(oWnd) then
        Exit; // If dialog is not visible still

      ExBorderShowing := True;
      Flags := GetWindowLong(oWnd, GWL_EXSTYLE);
      if (Flags and WS_EX_TOPMOST = WS_EX_TOPMOST) then begin
        if GetActiveWindow = ownd then begin
          SetWindowPos(oWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING);
          SendOwnerToBack;
        end;
        iInsAfter := HWND_TOPMOST;
      end
      else
        iInsAfter := 0;

      yAeroTab := 0;
    end;
    ShSize := ShadowSize;
    if (FormState and FS_FULLPAINTING <> 0) or aSkinChanging {or (FormState and FS_DISABLED = FS_DISABLED)} then begin
      if SkinData.BGChanged then
        PaintAll;

      Redraw := True;
//      if (FormState and FS_DISABLED <> FS_DISABLED) then
      if sp <> nil then begin
        GetWindowRect(oWnd, R);
        if not InAnimation(sp) and (sp.SkinData.FCacheBmp <> nil) and (R.Right <= acWorkRect(sp.Form).Right) and (R.Bottom <= acWorkRect(sp.Form).Bottom) then begin
          // Fast screen copying
          DC := GetWindowDC(oWnd);
          SavedDC := SaveDC(DC);
          try
            R := ACClientRect(oWnd);
            BitBlt(SkinData.FCacheBmp.Canvas.Handle, OffsetX + R.Left, OffsetY + R.Top, WidthOf(R), HeightOf(R), DC, R.Left, R.Top, SRCCOPY);
            FillAlphaRect(SkinData.FCacheBmp, Rect(OffsetX + R.Left, OffsetY + R.Top, OffsetX + R.Left + WidthOf(R), OffsetY + R.Top + HeightOf(R)), MaxByte);
          finally
            RestoreDC(DC, SavedDC);
            ReleaseDC(oWnd, DC);
          end;
        end
        else
          sp.SkinData.FCacheBmp := GetFormImage(sp, True)
      end
      else begin // sp = nil
        DC := GetWindowDC(oWnd);
        SavedDC := SaveDC(DC);
        try
          R := ACClientRect(oWnd);
          BitBlt(SkinData.FCacheBmp.Canvas.Handle, OffsetX + R.Left, OffsetY + R.Top, WidthOf(R), HeightOf(R), DC, R.Left, R.Top, SRCCOPY);
          FillAlphaRect(SkinData.FCacheBmp, Rect(OffsetX + R.Left, OffsetY + R.Top, OffsetX + R.Left + WidthOf(R), OffsetY + R.Top + HeightOf(R)), MaxByte);
        finally
          RestoreDC(DC, SavedDC);
          ReleaseDC(oWnd, DC);
        end;
      end;
    end
    else
      if SkinData.BGChanged then begin
        PaintAll;
        Redraw := True;
      end;

    if (sp <> nil) and sp.FSysExHeight then
      cy := ShSize.Top + DiffTitle(Self) + 4 // SysBorderWidth(oWnd, Self, False) { For MinMax patching }
    else
      cy := OffsetY;

    cx := SkinBorderWidth(Self) - SysBorderWidth(oWnd, Self, False) + ShSize.Left;
    w := SkinData.FCacheBmp.Width;
    h := SkinData.FCacheBmp.Height;

    if iInsAfter = 0 then
      if isIconic(oWnd) or (FormState and FS_SIZING = FS_SIZING) then
        iInsAfter := GetNextWindow(oWnd, GW_HWNDPREV)
      else
        iInsAfter := oWnd;

    Flags := SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER;
    if (FormState and FS_SIZING = FS_SIZING) then
      Flags := Flags or SWP_NOZORDER;

    if Redraw or (AForm.Width <> w) or (AForm.Height <> h) then
      bSizeChanged := True
    else begin
      Flags := Flags or SWP_NOSIZE;
      bSizeChanged := False;
    end;

    if not Redraw then
      Flags := Flags or SWP_NOREDRAW;

    p := Point(fR.Left - cx {+ 100}, fr.Top - cy);
    if acLayered and bSizeChanged and not acInMouseMsg then begin
      FBmpSize := MkSize(SkinData.FCacheBmp);
      FBmpTopLeft := MkPoint;
{$IFDEF DELPHI6UP}
      if FOwner is TsSkinProvider and TsSkinProvider(FOwner).Form.AlphaBlend then
        FBlend.SourceConstantAlpha := TsSkinProvider(FOwner).Form.AlphaBlendValue
      else
{$ENDIF}
        FBlend.SourceConstantAlpha := Blend;

      FBlend.BlendOp := AC_SRC_OVER;
      FBlend.BlendFlags := 0;
      FBlend.AlphaFormat := AC_SRC_ALPHA;

      if (AForm.Width <> w) or (AForm.Height <> h) then
        AForm.SetBounds(p.X, p.Y, w, h - yAeroTab);

      if (FOwner is TsSkinProvider) and (TsSkinProvider(FOwner).Form.WindowState = wsMaximized) then begin // Solving a problem with hidden taskbar
        if yAeroTab <> 0 then
          SkinData.FCacheBmp.Height := SkinData.FCacheBmp.Height - ShSize.Bottom - SysBorderWidth(TsSkinProvider(FOwner).Form.Handle, Self) - yAeroTab;

        FBmpSize.cy := SkinData.FCacheBmp.Height;
        AForm.Height := FBmpSize.cy;
      end;
      AForm.HandleNeeded;
      if AForm.HandleAllocated then begin
        if SkinData.SkinManager.Effects.AllowAeroBluring and SkinData.SkinManager.CommonSkinData.UseAeroBluring then begin
          MakeBluringRgn;
          SetBlurBehindWindow(AForm.Handle, True, bRgn);
        end
        else
          SetBlurBehindWindow(AForm.Handle, False, 0);

        if (FormState and FS_BLENDMOVING = FS_BLENDMOVING) then
          SetWindowRgn(AForm.Handle, MakeRgn, False);

        DC := GetDC(0);
        UpdateLayeredWindow(AForm.Handle, DC, @p, @FBmpSize, SkinData.FCacheBmp.Canvas.Handle, @FBmpTopLeft, clNone, @FBlend, ULW_ALPHA);
        ReleaseDC(0, DC);
        if FormState and FS_FULLPAINTING <> FS_BLENDMOVING then
          SetWindowRgn(AForm.Handle, MakeRgn, False); // Change rgn after blend-moving

        if GetWindowLong(AForm.Handle, GWL_STYLE) and WS_VISIBLE <> WS_VISIBLE then begin
          if Blend = 0 then
            SetWindowLong(oWnd, GWL_STYLE, GetWindowLong(oWnd, GWL_STYLE) and not WS_VISIBLE); // Preventing of the main form painting

          SetWindowPos(AForm.Handle, iInsAfter, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE or SWP_NOMOVE); // or SWP_NOOWNERZORDER);
          SendOwnerToBack;
          if Blend = 0 then
            SetWindowLong(oWnd, GWL_STYLE, GetWindowLong(oWnd, GWL_STYLE) or WS_VISIBLE);

          if (Blend = MaxByte) and (FormState and FS_SIZING <> FS_SIZING) then
            // Additional update of the form region (avoiding of the empty form issue)
            if sp <> nil then
              sSkinProvider.UpdateRgn(sp, True, True)
            else
              aCDials.UpdateRgn(TacDialogWnd(FOwner), True);
        end
        else begin
          SetWindowPos(AForm.Handle, iInsAfter, 0, 0, 0, 0, Flags or SWP_NOSIZE or SWP_NOMOVE);
          SendOwnerToBack;
          if (Blend = MaxByte) and (FormState and FS_SIZING <> FS_SIZING) then
            // Additional update of the form region (avoiding of the empty form issue)
            if sp <> nil then
              sSkinProvider.UpdateRgn(sp, Redraw)
            else
              aCDials.UpdateRgn(TacDialogWnd(FOwner), Redraw);
        end;
      end;
    end
    else begin
      SetWindowPos(AForm.Handle, iInsAfter, p.X, p.Y, 0, 0, Flags or SWP_NOSIZE);
      SendOwnerToBack;
    end;
  end;
  ExBorderShowing := False;
end;


procedure TacBorderForm.KillAnimations;
begin
  if FOwner is TsSkinProvider then
    TsSkinProvider(FOwner).KillAnimations
  else
    if FOwner is TacDialogWnd then
      TacDialogWnd(FOwner).KillAnimations;
end;


function TacBorderForm.OffsetX: integer;
begin
  Result := SkinBorderWidth(Self) - SysBorderWidth(OwnerHandle, Self, False) + ShadowSize.Left
end;


function TacBorderForm.OffsetY: integer;
var
  i1, i2: integer;
begin
  i2 := CaptionHeight(False);
  if i2 <> 0 then
    i1 := SkinTitleHeight(Self)
  else
    i1 := 0;

  Result := ShadowSize.Top - SysBorderWidth(OwnerHandle, Self, False) + i1 - i2
end;


function TacBorderForm.OwnerHandle: hwnd;
begin
  if FOwner is TsSkinProvider then
    if TsSkinProvider(FOwner).Form.HandleAllocated then
      Result := TsSkinProvider(FOwner).Form.Handle
    else
      Result := 0
  else
    if (FOwner is TacDialogWnd) then
      Result := TacDialogWnd(FOwner).CtrlHandle
    else
      Result := 0;
end;


function TacBorderForm.ShadowSize: TRect;
begin
  Result := SkinData.SkinManager.FormShadowSize;
end;


procedure TacBorderForm.SendOwnerToBack;
begin
{$IFNDEF NOFONTSCALEPATCH}
  if (AForm <> nil) and (SkinData.SkinManager.SysFontScale > 0) and not aSkinChanging then // Dialogs patch for big fonts
    SetWindowPos(OwnerHandle, AForm.Handle, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOREDRAW);
{$ENDIF}
end;


procedure TacBorderForm.SetHotHT(const i: integer; Repaint: boolean);
begin
  if FOwner is TsSkinProvider then
    TsSkinProvider(FOwner).SetHotHT(i)
  else
    TacDialogWnd(FOwner).SetHotHT(i);
end;


function TacBorderForm.CaptionHeight(CheckSkin: boolean = True): integer;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).CaptionHeight(CheckSkin)
  else
    Result := TacDialogWnd(FOwner).CaptionHeight(CheckSkin)
end;


function TacBorderForm.MenuHeight: integer;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).MenuHeight
  else
    Result := 0;
end;


function TacBorderForm.IconRect: TRect;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).IconRect
  else
    Result := TacDialogWnd(FOwner).IconRect
end;


procedure TacBorderForm.PaintAll;
begin
  if FOwner is TsSkinProvider then
    TsSkinProvider(FOwner).PaintAll
  else
    TacDialogWnd(FOwner).PaintAll
end;


function TacBorderForm.ButtonClose: TsCaptionButton;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).ButtonClose
  else
    Result := TacDialogWnd(FOwner).ButtonClose
end;


function TacBorderForm.ButtonHelp: TsCaptionButton;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).ButtonHelp
  else
    Result := TacDialogWnd(FOwner).ButtonHelp
end;


function TacBorderForm.ButtonMax: TsCaptionButton;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).ButtonMax
  else
    Result := TacDialogWnd(FOwner).ButtonMax
end;


function TacBorderForm.ButtonMin: TsCaptionButton;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).ButtonMin
  else
    Result := TacDialogWnd(FOwner).ButtonMin
end;


function TacBorderForm.MakeRgn(NewWidth: integer = 0; NewHeight: integer = 0): HRGN;
var
  R: TRect;
  SubRgn: hrgn;
  i, cx, dx: integer;

  function ClientRgn: hrgn;
  var
    cR, rClient, rInt: TRect;
  begin
    if sp <> nil then begin
      cR.Left := sp.OffsetX;
      cR.Top := sp.OffsetY;

      if (FormState and FS_SIZING = FS_SIZING) and not (fsShowing in sp.Form.FormState) then begin
        if sp.LastClientRect.Right < sp.Form.ClientWidth then
          cR.Right := cR.Left + sp.LastClientRect.Right
        else
          if (NewWidth <> 0) and (NewWidth > sp.Form.Constraints.MinWidth) then
            cR.Right := cR.Left + sp.Form.ClientWidth - (TsSkinProvider(FOwner).Form.Width - NewWidth)
          else
            cR.Right := cR.Left + sp.Form.ClientWidth;

        if sp.LastClientRect.Bottom < sp.Form.ClientHeight then
          cR.Bottom := cR.Top + sp.LastClientRect.Bottom
        else
          if (NewHeight <> 0) and (NewHeight > sp.Form.Constraints.MinHeight) then
            cR.Bottom := cR.Top + sp.Form.ClientHeight - (sp.Form.Height - NewHeight)
          else
            cR.Bottom := cR.Top + sp.Form.ClientHeight;
      end
      else begin
        cR.Right := cR.Left + sp.Form.ClientWidth;
        cR.Bottom := cR.Top + sp.Form.ClientHeight;
        if sp.ListSW <> nil then begin
          if (sp.ListSW.sBarVert <> nil) and sp.ListSW.sBarVert.fScrollVisible then
            cR.Right := cR.Right + GetScrollMetric(sp.ListSW.sBarVert, SM_SCROLLWIDTH);

          if (sp.ListSW.sBarVert <> nil) and sp.ListSW.sBarHorz.fScrollVisible then
            cR.Bottom := cR.Bottom + GetScrollMetric(sp.ListSW.sBarHorz, SM_SCROLLWIDTH);
        end;
      end;
      if (sp.LinesCount > 0) and (FormState and FS_ACTIVATE <> FS_ACTIVATE) then
        dec(cR.Top, sp.LinesCount * sp.MenuHeight);
    end
    else begin
      cR.Left := TacDialogWnd(FOwner).OffsetX;
      cR.Top := TacDialogWnd(FOwner).OffsetY;
      if (FormState and FS_SIZING = FS_SIZING) then begin
        GetClientRect(TacDialogWnd(FOwner).CtrlHandle, rClient);
        if TacDialogWnd(FOwner).LastClientRect.Right < WidthOf(rClient) then
          cR.Right := cR.Left + TacDialogWnd(FOwner).LastClientRect.Right
        else
          if (NewWidth <> 0) then
            cR.Right := cR.Left + WidthOf(rClient) - (TacDialogWnd(FOwner).WndSize.cx - NewWidth)
          else
            cR.Right := cR.Left + WidthOf(rClient);

        if TacDialogWnd(FOwner).LastClientRect.Bottom < HeightOf(rClient) then
          cR.Bottom := cR.Top + TacDialogWnd(FOwner).LastClientRect.Bottom
        else
          if (NewHeight <> 0) then
            cR.Bottom := cR.Top + HeightOf(rClient) - (TacDialogWnd(FOwner).WndSize.cy - NewHeight)
          else
            cR.Bottom := cR.Top + HeightOf(rClient);
      end
      else begin
        cR.Left := SkinBorderWidth(Self) + ShadowSize.Left;
        GetClientRect(OwnerHandle, rInt);
        cR.Right := cR.Left + WidthOf(rInt);
        cR.Bottom := SkinData.FCacheBmp.Height - SkinBorderWidth(Self) - ShadowSize.Bottom;
      end;
    end;
    Result := CreateRectRgn(cR.Left, cR.Top, cR.Right, cR.Bottom);
  end;

begin
  if AForm <> nil then begin
    if IsZoomed(OwnerHandle) then begin
      i := SysBorderWidth(OwnerHandle, Self, False);
      cx := i;
      dx := DiffBorder(Self);
      R := Rect(cx + dx + ShadowSize.Left, 4 + ShadowSize.Top, AForm.Width - cx - dx - ShadowSize.Right, AForm.Height - cx - dx - ShadowSize.Bottom);
      Result := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
    end
    else
      Result := 0;

    if (FormState and FS_FULLPAINTING = 0) and (FormState and FS_ANIMCLOSING <> FS_ANIMCLOSING) {or (FOwner is TsSkinProvider) and sp.Form.Showing)} then begin
      if Result = 0 then
        Result := CreateRectRgn(0, 0, AForm.Width, AForm.Height);

//      if (FormState and FS_DISABLED <> FS_DISABLED) then begin
      SubRgn := ClientRgn;
      CombineRgn(Result, Result, SubRgn, RGN_XOR);
      DeleteObject(SubRgn);
//      end;
    end
    else
      if AForm.Top < MinTopCoord then begin
        if Result = 0 then
          Result := CreateRectRgn(0, 0, AForm.Width, AForm.Height);

        SubRgn := CreateRectRgn(0, 0, AForm.Width, MinTopCoord - AForm.Top);
        CombineRgn(Result, Result, SubRgn, RGN_XOR);
        DeleteObject(SubRgn);
        MovRgnChanged := True;
      end
      else
        MovRgnChanged := False;
  end
  else
    Result := 0;
end;


function TacBorderForm.FormState: cardinal;
begin
  if FOwner is TsSkinProvider then
    Result := TsSkinProvider(FOwner).FormState
  else
    Result := TacDialogWnd(FOwner).FormState
end;


function TacBorderForm.GetTopWnd: THandle;
begin
  if sp.Form.FormStyle = fsStayOnTop then // Patch for a Delphi problem concerning StayOnTop forms
    Result := HWND_TOP
  else
    if GetWindowLong(OwnerHandle, GWL_EXSTYLE) and WS_EX_TOPMOST = WS_EX_TOPMOST then
      Result := HWND_TOPMOST
    else
      Result := OwnerHandle;
end;


procedure TacBorderForm.CreateNewForm;
var
  Flags: ACNativeInt;
begin
  AForm := TForm.Create(nil);
  AForm.Visible := False;
  AForm.BorderStyle := bsNone;
  AForm.Tag := ExceptTag;

  Flags := WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE or WS_EX_LAYERED;

  SetWindowLong(AForm.Handle, GWL_EXSTYLE, Flags);
  SetClassLong(AForm.Handle, GCL_STYLE, GetClassLong(AForm.Handle, GCL_STYLE) and not NCS_DROPSHADOW);
  ParentHandle := LongWord(SetWindowLong(AForm.Handle, GWL_HWNDPARENT, LONG_PTR(OwnerHandle)));

  OldBorderProc := AForm.WindowProc;
  AForm.WindowProc := BorderProc;
end;


procedure TacBorderForm.UpdateRgn;
begin
  if ResetRgn then begin
    ResetRgn := False;
    SetWindowRgn(AForm.Handle, MakeRgn, False);
  end;
end;


procedure TacSBAnimation.ChangeState(NewState: integer; ToUp: boolean);
begin
  Up := ToUp;
  Enabled := True;
end;


procedure TacSBAnimation.CheckMouseLeave;
var
  P: TPoint;
  R: TRect;
begin
  if BorderForm <> nil then
    p := Point(acMousePos.X - BorderForm.AForm.Left, acMousePos.Y - BorderForm.AForm.Top)
  else begin
    GetWindowRect(FormHandle, R);
    p := Point(acMousePos.X - R.Left, acMousePos.Y - R.Top);
  end;
  if not PtInRect(PBtnData^.Rect, P) then begin
    Enabled := False;
    SendMessage(FormHandle, WM_MOUSELEAVE, 0, 0);
  end;
end;


constructor TacSBAnimation.Create(AOwner: TComponent);
begin
  inherited;
  CurrentLevel := 0;
  CurrentState := 0;
  aBmp := nil;
  AForm := nil;
  Up := False;
  OnTimer := OnAnimTimer;
end;


destructor TacSBAnimation.Destroy;
begin
  Enabled := False;
  if AForm <> nil then
    FreeAndNil(AForm);

  if ABmp <> nil then
    FreeAndNil(ABmp);

  PBtnData^.Timer := nil;
  inherited;
end;


function TacSBAnimation.GetFormBounds: TRect;
var
  mi, mOffset: integer;
begin
  if BorderForm <> nil then
    GetWindowRect(BorderForm.AForm.Handle, Result)
  else
    GetWindowRect(FormHandle, Result);

  OffsetRect(Result, PBtnData^.Rect.Left, PBtnData^.Rect.Top);
  mOffset := Offset;
  if mOffset <> 0 then begin
    mi := SkinData.SkinManager.GetMaskIndex(SkinData.SkinManager.ConstData.IndexGlobalInfo, SkinData.SkinManager.ma[PBtnData^.ImageIndex].PropertyName + s_Glow + ZeroChar);
    if (mi > -1) then begin
      Result.Left   := Result.Left - mOffset;
      Result.Top    := Result.Top  - mOffset;
      Result.Right  := Result.Left + WidthOf (SkinData.SkinManager.ma[mi].R);
      Result.Bottom := Result.Top  + HeightOf(SkinData.SkinManager.ma[mi].R);
    end
    else
      mOffset := 0;
  end;
  if mOffset = 0 then begin
    Result.Right := Result.Left + WidthOf (PBtnData^.Rect, True);
    Result.Bottom := Result.Top + HeightOf(PBtnData^.Rect, True);
  end;
end;


procedure TacSBAnimation.MakeForm;
begin
  if AForm = nil then begin
    AForm := TForm.Create(nil);
    AForm.Visible := False;
    AForm.BorderStyle := bsNone;
    SetClassLong(AForm.Handle, GCL_STYLE, GetClassLong(AForm.Handle, GCL_STYLE) and not NCS_DROPSHADOW);
    AForm.Tag := ExceptTag;
    SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE or WS_EX_TRANSPARENT);
    if (BorderForm <> nil) and (BorderForm.AForm.FormStyle = fsStayOnTop) then
      SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_TOPMOST);
  end;
end;


procedure TacSBAnimation.MakeImg;
var
  R: TRect;
  b: boolean;
  CI: TCacheInfo;
  S0, S: PRGBAArray;
  TitleButton: TsTitleButton;
  mi, x, y, j, DeltaS, ImgIndex: integer;
begin
  mi := -1;
  if (CurrentState = 0) and (ABmp <> nil) then
    Exit; // Updating is not required

  R := GetFormBounds;
  b := SkinData.SkinManager.Effects.AllowGlowing and (CurrentState = 1) and (PBtnData^.HitCode in [HTCLOSE, HTMAXBUTTON, HTMINBUTTON]);
  if (SkinData.FOwnerObject is TsSkinProvider) and (PBtnData^.HitCode = HTMINBUTTON) and IsIconic(TsSkinProvider(SkinData.FOwnerObject).Form.Handle) then
    ImgIndex := SkinData.SkinManager.ConstData.MaskNormBtn
  else
    ImgIndex := PBtnData^.ImageIndex;

  if ImgIndex < 0 then
    b := False;

  if b then begin
    mi := SkinData.SkinManager.GetMaskIndex(SkinData.SkinManager.ConstData.IndexGlobalInfo, SkinData.SkinManager.ma[ImgIndex].PropertyName + s_Glow + ZeroChar);
    b := mi <> -1;
  end;
  if ABmp = nil then
    ABmp := CreateBmp32(R);

  if b then begin
    with SkinData.SkinManager do
      if IsValidImgIndex(mi) then
        BitBlt(ABmp.Canvas.Handle, 0, 0, ABmp.Width, ABmp.Height, ma[mi].Bmp.Canvas.Handle, 0, 0, SRCCOPY);
  end
  else begin
    CI.X := PBtnData^.Rect.Left;
    CI.Y := PBtnData^.Rect.Top;
    if (SkinData.FOwnerObject is TsSkinProvider) and (TsSkinProvider(SkinData.FOwnerObject).TempBmp <> nil) then begin
      CI.X := CI.X - (TsSkinProvider(SkinData.FOwnerObject).CaptionWidth - TsSkinProvider(SkinData.FOwnerObject).TempBmp.Width - 1);
      CI.Bmp := TsSkinProvider(SkinData.FOwnerObject).TempBmp;
    end
    else
      CI.Bmp := SkinData.FCacheBmp;

    CI.Ready := True;
    FillRect32(ABmp, MkRect(ABmp), 0, 0);
//    FillAlphaRect(ABmp, MkRect(ABmp), 0);
    if (ImgIndex > -1) then
      DrawSkinGlyph(ABmp, MkPoint, PBtnData^.State, 1, SkinData.SkinManager.ma[ImgIndex], MakeCacheInfo(ABmp));

    if (BorderForm = nil) then
      if (ImgIndex < 0) or (SkinData.SkinManager.ma[ImgIndex].MaskType = 0) then
        if InitLine(ABmp, Pointer(S0), DeltaS) then
          for y := 0 to ABmp.Height - 1 do begin // If AlphaChannel must be updated
            S := Pointer(LongInt(S0) + DeltaS * Y);
            for x := 0 to ABmp.Width - 1 do
              with S[x] do
                if C = clFuchsia then
                  A := MaxByte;
          end;

    if not AeroIsEnabled and (Win32MajorVersion >= 6) then
      UpdateAlpha(ABmp);
  end;
  if (Self.SkinData.FOwnerObject is TsSkinProvider) then
    with TsSkinProvider(Self.SkinData.FOwnerObject) do
      if Between(PBtnData^.HitCode, HTUDBTN, HTUDBTN + TitleButtons.Count - 1) then begin // User defined button glyph
        j := PBtnData^.HitCode - HTUDBTN;
        TitleButton := TitleButtons.Items[j];
        if not TitleButton.Glyph.Empty then
          if TitleButton.Glyph.PixelFormat = pf32bit then begin
            x := (ABmp.Width - TitleButton.Glyph.Width) div 2;
            y := (ABmp.Height - TitleButton.Glyph.Height) div 2;
            if (PBtnData^.State = 2) then begin
              inc(x);
              inc(y);
            end;
            CopyByMask(Rect(x, y, x + TitleButton.Glyph.Width, y + TitleButton.Glyph.Height),
                       MkRect(TitleButton.Glyph), ABmp, TitleButton.Glyph, EmptyCI, True);
          end
          else
            CopyTransBitmaps(ABmp, TitleButton.Glyph,
                             integer(PBtnData^.State = 2) + (WidthOf(PBtnData^.Rect) - TitleButton.Glyph.Width) div 2,
                             integer(PBtnData^.State = 2) + (HeightOf(PBtnData^.Rect) - TitleButton.Glyph.Height) div 2,
                             TsColor(TitleButton.Glyph.Canvas.Pixels[0, TitleButton.Glyph.Height - 1]));
      end;
end;


function TacSBAnimation.Offset: integer;
begin
  Result := 0;
  if SkinData.SkinManager.Effects.AllowGlowing and (CurrentState = 1) and (PBtnData^.HitCode in [HTCLOSE, HTMAXBUTTON, HTMINBUTTON]) then
    case PBtnData^.HitCode of
      HTCLOSE:     Result := SkinData.SkinManager.CommonSkinData.BICloseGlowMargin;
      HTMAXBUTTON: Result := SkinData.SkinManager.CommonSkinData.BIMaxGlowMargin;
      HTMINBUTTON: Result := SkinData.SkinManager.CommonSkinData.BIMinGlowMargin;
    end;
end;


procedure TacSBAnimation.OnAnimTimer(Sender: TObject);
begin
  if Enabled then
    if Up then
      if CurrentLevel >= MaxIterations then begin
        CheckMouseLeave;
        if MaxIterations <> -1 then begin
          MaxIterations := -1;
          UpdateForm(MaxByte);
        end;
      end
      else begin
        UpdateForm(max(min(CurrentLevel * Step, MaxByte), 0));
        inc(CurrentLevel);
      end
    else
      if CurrentLevel <= 0 then begin
        CurrentState := -1;
        Enabled := False;
        if (ABmp <> nil) then
          FreeAndNil(ABmp);

        if (AForm <> nil) then
          FreeAndNil(AForm);
      end
      else begin
        UpdateForm(max(0, min(CurrentLevel * Step, MaxByte)));
        dec(CurrentLevel);
      end;
end;


procedure TacSBAnimation.StartAnimation(NewState: integer; ToUp : boolean);
begin
  if CurrentState <> NewState then begin
    CurrentState := NewState;
    if NewState <> 0 then begin
      if NewState = 2 then begin
        FreeAndNil(AForm);
        FreeAndNil(ABmp);
      end;
      CurrentLevel := 1;
      Up := ToUp;
      UpdateForm(min(Step, MaxByte));
      inc(CurrentLevel);
    end
    else begin
      Up := False;
      dec(CurrentLevel);
      UpdateForm(min(Step, MaxByte));
    end;
    if Maxiterations > 1 then
      Enabled := True;
  end;
end;


function TacSBAnimation.Step: integer;
begin
  Result := max(MaxByte div MaxIterations, 0);
end;


procedure TacSBAnimation.UpdateForm(const Blend: integer);
var
  DC: hdc;
  R: TRect;
  iInsAfter: hwnd;
  Flags: Cardinal;
  FBmpSize: TSize;
  FBmpTopLeft: TPoint;
  OwnerHandle: THandle;
  FBlend: TBlendFunction;
begin
  if ABmp = nil then
    MakeImg;

  if AForm = nil then
    MakeForm;

  if (ABmp <> nil) and (AForm <> nil) then begin
    FBmpSize := MkSize(ABmp);
    R := GetFormBounds;
    if FBmpSize.cx <> WidthOf(R) then // If image is hiding
      InflateRect(R, (FBmpSize.cx - WidthOf(R)) div 2, (FBmpSize.cy - HeightOf(R)) div 2);

    if BorderForm <> nil then
      OwnerHandle := BorderForm.AForm.Handle
    else
      OwnerHandle := FormHandle;

    if GetWindowLong(OwnerHandle, GWL_EXSTYLE) and WS_EX_TOPMOST = WS_EX_TOPMOST then
      iInsAfter := HWND_TOPMOST
    else
      iInsAfter := GetNextWindow(OwnerHandle, GW_HWNDPREV);

    Flags := SWP_NOACTIVATE or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING;
    // Replacement of SetWindowPos (for Aero)
    AForm.Left := R.Left;
    AForm.Top := R.Top;
    AForm.Width  := FBmpSize.cx;
    AForm.Height := FBmpSize.cy;
    FBmpTopLeft := MkPoint;
    FBlend.SourceConstantAlpha := Blend;
    FBlend.BlendOp := AC_SRC_OVER;
    FBlend.BlendFlags := 0;
    FBlend.AlphaFormat := AC_SRC_ALPHA;
    SetWindowPos(AForm.Handle, iInsAfter, 0, 0, 0, 0, Flags or SWP_NOMOVE or SWP_NOSIZE);
    DC := GetDC(0);
    SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_LAYERED or WS_EX_NOACTIVATE or WS_EX_TRANSPARENT);
    UpdateLayeredWindow(AForm.Handle, DC, nil, @FBmpSize, ABmp.Canvas.Handle, @FBmpTopLeft, clNone, @FBlend, ULW_ALPHA);
    ShowWindow(AForm.Handle, SW_SHOWNOACTIVATE);
    ReleaseDC(0, DC);
  end;
end;


constructor TacGraphItem.Create;
begin
  SkinData := TsCommonData.Create(Self, True);
  SkinData.COC := COC_TsAdapter;
  Handler := nil;
end;


destructor TacGraphItem.Destroy;
begin
  if (Handler <> nil) then
    FreeAndNil(Handler);

  SkinData.ClearLinks;
  FreeAndNil(SkinData);
  inherited Destroy;
end;


procedure TacGraphItem.DoHook(Control: TControl);
begin
  if (Control.Tag and ExceptTag <> ExceptTag) then begin
    Self.Ctrl := Control;
    SkinData.FOwnerControl := Control;
    SkinData.FOwnerObject := TObject(Control);
    Handler := TacSpeedButtonHandler.Create(Ctrl, SkinData, SkinData.SkinManager, SkinData.SkinSection);
  end;
end;


constructor TacAddedTitle.Create;
begin
  FFont := TFont.Create;
  FFont.Color := clNone;
  FShowMainCaption := True;
end;


destructor TacAddedTitle.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;


procedure TacAddedTitle.Repaint;
begin
  if not (csLoading in FOwner.ComponentState) then
    UpdateSkinCaption(FOwner);
end;


procedure TacAddedTitle.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  Repaint;
end;


procedure TacAddedTitle.SetShowMainCaption(const Value: boolean);
begin
  if FShowMainCaption <> Value then begin
    FShowMainCaption := Value;
    Repaint;
  end;
end;


procedure TacAddedTitle.SetText(const Value: acString);
begin
  if FText <> Value then begin
    FText := Value;
    Repaint;
  end;
end;


procedure TacMoveTimer.TimeHandler;
var
  i: integer;
begin
  if Enabled then begin
    if BorderForm <> nil then
      SetFormBlendValue(BorderForm.AForm.Handle, BorderForm.SkinData.FCacheBmp, Trunc(CurrentBlendValue))
    else begin
      if GetWindowLong(FormHandle, GWL_EXSTYLE) and WS_EX_LAYERED <> WS_EX_LAYERED then
        SetWindowLong(FormHandle, GWL_EXSTYLE, GetWindowLong(FormHandle, GWL_EXSTYLE) or WS_EX_LAYERED);

      SetLayeredWindowAttributes(FormHandle, clNone, Trunc(CurrentBlendValue), ULW_ALPHA);
    end;

    for i := 0 to Length(GluedArray) - 1 do
      if GluedArray[i].Master.Handle = FormHandle then
        SendAMessage(GluedArray[i].Slave.Handle, AC_SETALPHA, Trunc(CurrentBlendValue));

    if CurrentBlendValue > BlendValue then
      CurrentBlendValue := CurrentBlendValue - BlendStep;
  end;
end;


type
  TTBButtonX = packed record
    iBitmap,
    idCommand: Integer;
    fsState,
    fsStyle: Byte;
    bReserved: array [1..6] of Byte;
    dwData: Longint;
    iString: Integer;
  end;

  TacAppInfo = record
    Wnd: THandle;
  end;


{$IFNDEF DELPHI6UP}
function GetWindowThreadProcessId(hWnd: THandle; var dwProcessId: DWORD): DWORD; external user32 name 'GetWindowThreadProcessId';
{$ENDIF}


function GetAppRect: TRect;
const
  Buffer_Size = $1000;
var
  wndR: TRect;
  ai: TacAppInfo;
  si: TSystemInfo;
  ButtonX: TTBButton;
  i, bCount: integer;
  processID: Cardinal;
  ipRemoteBuffer: Pointer;
  hProcess, appHandle: THandle;
  hDesktop, hTray, hRebar, hTask, hToolBar: hwnd;
  ipBytesRead: {$IFDEF DELPHI_XE2}NativeUInt{$ELSE}Cardinal{$ENDIF};
begin
  FillChar(Result, SizeOf(TRect), 0);
  GetSystemInfo(si);
  hDesktop := GetDesktopWindow;
  if hDesktop <> 0 then begin
    hTray := FindWindowEx(hDesktop, 0, 'Shell_TrayWnd', nil);
    if hTray <> 0 then begin
      hRebar := FindWindowEx(hTray, 0, 'ReBarWindow32', nil);
      if hRebar <> 0 then begin
        hTask := FindWindowEx(hReBar, 0, 'MSTaskSwWClass', nil);
        if hTask <> 0 then begin
          hToolBar := FindWindowEx(hTask, 0, 'ToolbarWindow32', nil);
          if hToolBar <> 0 then begin
            bCount := SendMessage(hToolBar, TB_BUTTONCOUNT, 0, 0);
            if bCount > 0 then begin
              processId := 0;
              GetWindowThreadProcessId(hToolBar, processID);
              if processID <> 0 then begin
                hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, processId);
                if hProcess <> 0 then begin
                  ipRemoteBuffer := VirtualAllocEx(hProcess, nil, Buffer_Size, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
                  if (ipRemoteBuffer <> nil) then begin
                    i := -1;
                    while i < bCount do begin
                      inc(i);
                      if SendMessage(hToolbar, TB_GETBUTTON, i, LPARAM(ipRemoteBuffer)) = 0 then
                        Continue;

                      if not ReadProcessMemory(hProcess, ipRemoteBuffer, @ButtonX, SizeOf(TTBButtonX), ipBytesRead) then
                        Continue;

                      if (ButtonX.fsStyle and $D {not TBSTYLE_BUTTON ...} <> 0) or (ButtonX.fsState and TBSTATE_HIDDEN = TBSTATE_HIDDEN) then
                        Continue;

                      if not ReadProcessMemory(hProcess, Pointer(ButtonX.dwData), @ai, SizeOf(TacAppInfo), ipBytesRead) then
                        Continue;

                      if ipBytesRead = 0 then
                        Continue;
{$IFDEF D2009}
                      if Application.MainFormOnTaskBar and (Application.MainForm <> nil) then
                        appHandle := Application.MainForm.Handle
                      else
{$ENDIF}
                      appHandle := Application.{$IFDEF FPC}MainFormHandle{$ELSE}Handle{$ENDIF};
                      if (ai.Wnd = appHandle) then begin
                        if SendMessage(hToolBar, TB_GETITEMRECT, i, LPARAM(ipRemoteBuffer)) <> 0 then
                          ReadProcessMemory(hProcess, ipRemoteBuffer, @Result, SizeOf(TRect), ipBytesRead);

                        if ipBytesRead <> 0 then begin
                          GetWindowRect(hToolBar, wndR);
                          OffsetRect(Result, wndR.Left, wndR.Top);
                        end;
                        Break;
                      end;
                    end;
                    VirtualFreeEx(hProcess, ipRemoteBuffer, 0, MEM_RELEASE);
                    CloseHandle(hProcess);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;


function TacMinTimer.AlphaFrom: byte;
begin
  if FOwner is TsSkinProvider then
{$IFDEF DELPHI7UP}
    if TsSkinProvider(FOwner).Form.AlphaBlend then
      Result := TsSkinProvider(FOwner).Form.AlphaBlendValue
    else
{$ENDIF}
      Result := MaxByte
  else
    Result := MaxByte;

  if ((acWinVer < 6) or AeroIsEnabled) then
    if (sp = nil) and (DefaultManager.AnimEffects.Minimizing.Time > acTimerInterval) or (sp.SkinData.SkinManager.AnimEffects.Minimizing.Time > acTimerInterval) then
      Result := Result div 4; // Animation started not from full Alpha value
end;


constructor TacMinTimer.Create(AOwner: TComponent);
begin
  inherited;
  AnimForm := nil;
  AlphaBmp := nil;
  Minimized := False;
  AlphaFormWasCreated := False;
end;


constructor TacMinTimer.CreateOwned(AOwner: TComponent; ChangeEvent: boolean);
begin
  inherited CreateOwned(AOwner, True);
  InitData;
  SavedImage := TBitmap.Create;
end;


destructor TacMinTimer.Destroy;
begin
  if AlphaFormWasCreated and Assigned(AnimForm) then
    FreeAndNil(AnimForm);

  if Assigned(SavedImage) then
    FreeAndNil(SavedImage);

  if AlphaBmp <> nil then
    FreeAndNil(AlphaBmp);

  inherited;
end;


function TacMinTimer.GetRectTo: TRect;
var
  R: TRect;
begin
  if ShellTrayWnd <> 0 then begin
    if not AeroIsEnabled then
      Result := GetAppRect
    else
      Result.Left := Result.Right;

    if Result.Left = Result.Right then begin
      GetWindowRect(ShellTrayWnd, R);
      Result := R;
      if R.Top = 0 then 
        if R.Left = 0 then
          TBPosition := iff(WidthOf(R) > HeightOf(R), BF_TOP, BF_LEFT)
        else
          TBPosition := BF_RIGHT
      else
        TBPosition := iff(Between(R.Left, -4, 0) {For windows without themes}, BF_BOTTOM, BF_RIGHT);

      case TBPosition of
        BF_LEFT:  Result := Rect(R.Right, YFrom,    R.Right, YFrom);
        BF_TOP:   Result := Rect(XFrom,   R.Bottom, XFrom,   R.Bottom);
        BF_RIGHT: Result := Rect(R.Left,  YFrom,    R.Left,  YFrom)
        else      Result := Rect(XFrom,   R.Top,    XFrom,   R.Top); { BF_BOTTOM }
      end;
    end;
  end
  else
    Result := MkRect(0);
end;


procedure TacMinTimer.InitData;
const
  iMinStepCount = 1;
var
  aTime: integer;
begin
  Interval := acTimerInterval;
  if FOwner is TsSkinProvider then begin
    sp := TsSkinProvider(FOwner);
    BorderForm := sp.BorderForm;
  end
  else
    sp := nil;

  aTime := sp.SkinData.SkinManager.AnimEffects.Minimizing.Time;
  StepCount := max(iMinStepCount, aTime div integer(Self.Interval));
  AlphaOrigin := AlphaFrom;
  if FormHandle = 0 then
    FormHandle := sp.Form.Handle;

  CurrentAlpha := AlphaFrom;
  if (CurrentAlpha <= 0) and Minimized then begin // Minimized
    CurLeft   := RectTo.Left;
    CurTop    := RectTo.Top;
    CurRight  := RectTo.Right;
    CurBottom := RectTo.Bottom;
  end
  else
    if (CurrentAlpha >= AlphaFrom) then begin // Normal
      if (BorderForm <> nil) and (BorderForm.AForm <> nil) then
        RectFrom := BorderForm.AForm.BoundsRect
      else
        GetWindowRect(FormHandle, RectFrom);

      XFrom := RectFrom.Left + WidthOf(RectFrom) div 2;
      YFrom := RectFrom.Top + HeightOf(RectFrom) div 2;
      UpdateDstRect;
      CurLeft   := RectFrom.Left;
      CurTop    := RectFrom.Top;
      CurRight  := RectFrom.Right;
      CurBottom := RectFrom.Bottom;
    end;

  BlendStep := (AlphaFrom - AlphaTo) / Max(iMinStepCount, StepCount - 1);
  if AlphaBmp = nil then
    AlphaBmp := CreateBmp32(RectFrom)
  else begin
    AlphaBmp.Width  := WidthOf(RectFrom);
    AlphaBmp.Height := HeightOf(RectFrom);
  end;
  SetStretchBltMode(AlphaBmp.Canvas.Handle, 0);
  if BorderForm <> nil then begin
    AnimForm := BorderForm.AForm
  end
  else begin
    if AnimForm <> nil then
      FreeAndNil(AnimForm);

    AnimForm := MakeCoverForm(FormHandle);
    AlphaFormWasCreated := True;
    SetWindowRgn(AnimForm.Handle, 0, False);
  end;
end;


procedure TacMinTimer.TimeHandler;
var
  p: TPoint;
  W, H: real;
  X, Y: integer;
  bAnim: boolean;
  ChildSP: TsSkinProvider;
begin
  if not InHandler then begin
    InHandler := True;
    // Check if direction must be changed
    if not Minimized then begin
      if (sp.FormState and FS_ANIMRESTORING = FS_ANIMRESTORING) then
        Minimized := True;
    end
    else
      if (sp.FormState and FS_ANIMMINIMIZING = FS_ANIMMINIMIZING) then
        Minimized := False;

    if (AnimForm = nil) {or not AnimForm.HandleAllocated} then begin
      Enabled := False;
      InHandler := False;
      Exit;
    end
    else
      AnimForm.HandleNeeded;

    if not AnimForm.HandleAllocated then begin
      Enabled := False;
      InHandler := False;
      Exit;
    end;

    if sp.BorderForm <> nil then
      sp.BorderForm.ExBorderShowing := True;

    if not Minimized then begin // If in minimizing process
      FillDC(AlphaBmp.Canvas.Handle, MkRect(AlphaBmp), 0);
      CurLeft   := DeltaX + DeltaW + CurLeft;
      CurRight  := DeltaX - DeltaW + CurRight;
      CurTop    := DeltaY + DeltaH + CurTop;
      CurBottom := DeltaY - DeltaH + CurBottom;
      CurrentAlpha := max(0, CurrentAlpha - BlendStep);
      if CurrentAlpha <= 0 then begin // Finish of animation
        Enabled := False;
        if sp <> nil then begin
          sp.fAnimating := False;
          sp.SetHotHT(0);
          sp.FormState := sp.FormState and not FS_ANIMMINIMIZING;
          SetWindowLong(sp.Form.Handle, GWL_EXSTYLE, GetWindowLong(sp.Form.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
          if sp.BorderForm <> nil then begin
            FreeAndNil(sp.BorderForm.AForm);
            AnimForm := nil;
  {$IFDEF D2005}
            if {$IFDEF D2007}Application.MainformOnTaskBar and{$ENDIF} (Application.MainForm <> nil) then
              SetActiveWindow(Application.MainForm.Handle);
  {$ENDIF}
            sp.BorderForm.ExBorderShowing := False;
//            if (sp.BorderForm <> nil) and ((acWinVer < 6) or AeroIsEnabled) and (StepCount > 1) then
            if sp.Form <> Application.MainForm then
              sp.BorderForm.UpdateExBordersPos;
          end
          else begin
            FillDC(AlphaBmp.Canvas.Handle, MkRect(AlphaBmp), 0);
            SetFormBlendValue(AnimForm.Handle, AlphaBmp, Trunc(CurrentAlpha), @p);
            ShowWindow(AnimForm.Handle, SW_HIDE);
            sp.ProcessMessage(WM_NCPAINT);
          end;
        end;
        Minimized := True;
      end
      else begin
        W := max(0, CurRight - CurLeft);
        H := max(0, CurBottom - CurTop);
        X := Round(CurLeft + W / 2);
        Y := Round(CurTop + H / 2);
        StretchBlt(AlphaBmp.Canvas.Handle, Round(AlphaBmp.Width - W) div 2, Round(AlphaBmp.Height - H) div 2,
                   Round(W), Round(H), SavedImage.Canvas.Handle, 0, 0, SavedImage.Width, SavedImage.Height, SRCCOPY);

        p := Point(X - AlphaBmp.Width div 2, Y - AlphaBmp.Height div 2);
        SetFormBlendValue(AnimForm.Handle, AlphaBmp, Trunc(CurrentAlpha), @p);
        SetWindowPos(AnimForm.Handle, ShellTrayWnd, 0, 0, 0, 0,
                     SWP_NOMOVE or SWP_SHOWWINDOW or SWP_NOSIZE or SWP_NOREDRAW or SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
      end;
    end
    else begin // If in restoring process
      CurLeft   := CurLeft   - (DeltaX + DeltaW);
      CurRight  := CurRight  - (DeltaX - DeltaW);
      CurTop    := CurTop    - (DeltaY + DeltaH);
      CurBottom := CurBottom - (DeltaY - DeltaH);
      CurrentAlpha := min(MaxByte, CurrentAlpha + BlendStep);
      if (CurrentAlpha >= AlphaFrom) then begin // Finish of animation
        Enabled := False;
        p := RectFrom.TopLeft;
        if (acWinVer >= 6) and not AeroIsEnabled and (sp.BorderForm <> nil) then begin
          sp.BorderForm.UpdateRgn;
  {$IFDEF DELPHI7UP}
          if (sp <> nil) and sp.Form.AlphaBlend then
            SetFormBlendValue(AnimForm.Handle, SavedImage, sp.Form.AlphaBlendValue, @p)
          else
  {$ENDIF}
            SetFormBlendValue(AnimForm.Handle, SavedImage, MaxByte, @p);
        end
        else
          SetFormBlendValue(AnimForm.Handle, SavedImage, AlphaOrigin, @p);

        bAnim := acGetAnimation;
        acSetAnimation(False);
        ShowWindow(FormHandle, iff(IsZoomed(FormHandle), SW_SHOWMAXIMIZED, SW_SHOWNOACTIVATE));
        acSetAnimation(bAnim);
        SetWindowPos(AnimForm.Handle, 0, 0, 0, 0, 0,
                     SWP_NOMOVE or SWP_NOSIZE or SWP_NOREDRAW or SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);

        if sp.FormState and FS_DISABLED = FS_DISABLED then begin
          ShowWindow(AnimForm.Handle, SW_SHOW);
          Sleep(50);
        end;

//        if (sp.BorderForm = nil) then begin
//          SetWindowLong(FormHandle, GWL_STYLE, GetWindowLong(FormHandle, GWL_STYLE) and not WS_VISIBLE);

{$IFDEF DELPHI7UP}
        if (sp <> nil) and sp.Form.AlphaBlend then
          SetLayeredWindowAttributes(sp.Form.Handle, clNone, sp.Form.AlphaBlendValue, ULW_ALPHA)
        else
{$ENDIF}
          SetWindowLong(FormHandle, GWL_EXSTYLE, GetWindowLong(FormHandle, GWL_EXSTYLE) and not WS_EX_LAYERED);

//        if sp.BorderForm = nil then
//          SetWindowLong(FormHandle, GWL_STYLE, GetWindowLong(FormHandle, GWL_STYLE) or WS_VISIBLE);

        if sp <> nil then begin
          sp.fAnimating := False;
          sp.FormState := sp.FormState and not FS_ANIMRESTORING;
          if sp.BorderForm <> nil then
            if not ExtBordersNeeded(sp) then begin
              sp.BorderForm := nil; // AnimForm will be destroyed later
              if sp.Form <> Application.MainForm then
                sp.SkinData.BGChanged := True;
            end
            else
              sp.BorderForm.ExBorderShowing := False;
        end;

        if (sp.Form.Menu <> nil) and (sp.BorderForm = nil) and AeroIsEnabled then
          sp.SkinData.BGChanged := True; // Menu repaint

        RedrawWindow(FormHandle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_UPDATENOW or RDW_FRAME or RDW_INTERNALPAINT);
        Minimized := False;
        if (sp <> nil) and (sp.BorderForm <> nil) and (sp.BorderForm.AForm = AnimForm) then begin
          sp.BorderForm.UpdateExBordersPos(True);
          AnimForm := nil;
        end
        else begin
          SetWindowPos(AnimForm.Handle, FormHandle, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOREDRAW or SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
          FreeAndnil(AnimForm);
        end;

        if IsWindowEnabled(FormHandle) and IsWindowVisible(FormHandle) then
          if (sp.Form.FormStyle = fsMDIForm) and (sp.Form.ActiveMDIChild <> nil) then begin
            ChildSP := GetSkinProvider(sp.Form.ActiveMDIChild);
            if ChildSP <> nil then begin
              ChildSP.FormActive := True;
              UpdateSkinCaption(ChildSP);
            end;
          end
          else begin
            if Application.MainForm = sp.Form then
              SetActiveWindow(Application.{$IFNDEF FPC}Handle{$ELSE}MainFormHandle{$ENDIF})
            else
              SetActiveWindow(FormHandle);

            if IsWindowVisible(FormHandle) and IsWindowEnabled(FormHandle) then
              SetFocus(FormHandle);
          end;

          if sp.FormState and FS_DISABLED = FS_DISABLED then begin
            sp.UpdateLayerForm;
          end;

        if Assigned(Application.OnRestore) then
          Application.OnRestore(Application);
      end
      else begin
        SetWindowRgn(AnimForm.Handle, 0, False);
        W := max(0, CurRight - CurLeft);
        H := max(0, CurBottom - CurTop);
        X := Round(CurLeft + W / 2);
        Y := Round(CurTop  + H / 2);
        StretchBlt(AlphaBmp.Canvas.Handle, Round(AlphaBmp.Width - W) div 2, Round(AlphaBmp.Height - H) div 2, Round(W), Round(H),
                   SavedImage.Canvas.Handle, 0, 0, SavedImage.Width, SavedImage.Height, SRCCOPY);

        p := Point(X - AlphaBmp.Width div 2, Y - AlphaBmp.Height div 2);
        SetFormBlendValue(AnimForm.Handle, AlphaBmp, Trunc(CurrentAlpha), @p);
        SetWindowPos(AnimForm.Handle, ShellTrayWnd, 0, 0, 0, 0, SWP_NOMOVE or SWP_SHOWWINDOW or SWP_NOSIZE or SWP_NOREDRAW or SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER);
      end;
    end;
    InHandler := False;
  end;
end;


procedure TacMinTimer.UpdateDstRect;
begin
  RectTo := GetRectTo;
  XTo := RectTo.Left + WidthOf(RectTo) div 2;
  YTo := RectTo.Top + HeightOf(RectTo) div 2;
  DeltaX := (XTo - XFrom) / StepCount;
  DeltaY := (YTo - YFrom) / StepCount;
  DeltaW := (WidthOf(RectFrom)  - WidthOf(RectTo))  / (2 * StepCount);
  DeltaH := (HeightOf(RectFrom) - HeightOf(RectTo)) / (2 * StepCount);
  AlphaTo := 0;
end;


constructor TacSysSubMenu.Create(AOwner: TsSkinProvider);
begin
  FPosition := ipBeforeClose;
end;


function TacBorderForm.MinTopCoord: integer;
begin
  Result := acWorkRect(AForm).Top;
end;


procedure TsSkinProvider.SetGluedForms(const Value: TStringList);
begin
  FGluedForms.Assign(Value);
end;


function TsSkinProvider.CheckEdges(rStatic, rDynamic: TRect; NewX, NewY: integer): TSize;
begin
  Result := MkSize(HandleEdge(NewX, rStatic.Left, FSnapBuffer), HandleEdge(NewY, rStatic.Top,  FSnapBuffer));
  if Result.cx = 0 then
    Result.cx := HandleEdge(NewX + WidthOf(rDynamic), rStatic.Right, FSnapBuffer);

  if Result.cy = 0 then
    Result.cy := HandleEdge(NewY + HeightOf(rDynamic), rStatic.Bottom, FSnapBuffer);
end;


function TsSkinProvider.LimitRect(db: integer; R: TRect; Invert: boolean = False): TRect;
var
  Ml: integer;
begin
  Result := R;
  if BorderForm <> nil then
    with BorderForm.SkinData.SkinManager.CommonSkinData do begin
      Ml := iff(Invert, 1, -1);
      inc(Result.Left,   (-db                    - ExShadowOffs)  * Ml);
      inc(Result.Top,    (-DiffTitle(BorderForm) - ExShadowOffsT) * Ml);
      inc(Result.Right,  ( db                    + ExShadowOffsR) * Ml);
      inc(Result.Bottom, (+db                    + ExShadowOffsB) * Ml);
    end;
end;


procedure TsSkinProvider.CheckNewPosition(var X: integer; var Y: integer);
var
  cR, vR, fR: TRect;
  i: integer;
  PosOffset: TSize;

  function CheckWithForm(f: TForm): boolean;
  var
    Rects: array [TacSide] of TRect;
    j: TacSide;
    DiffB: integer;
  begin
    GetWindowRect(f.Handle, vR);
    DiffB := DiffBorder(BorderForm);
    vR := LimitRect(DiffB, vR, True);
    Rects[asLeft]   := LimitRect(DiffB, Rect(cR.Left,  vR.Top,    vR.Left,  vR.Bottom));
    Rects[asTop]    := LimitRect(DiffB, Rect(vR.Left,  cR.Top,    vR.Right, vR.Top));
    Rects[asRight]  := LimitRect(DiffB, Rect(vR.Right, vR.Top,    cR.Right, vR.Bottom));
    Rects[asBottom] := LimitRect(DiffB, Rect(vR.Left,  vR.Bottom, vR.Right, cR.Bottom));
    for j := asLeft to asBottom do
      if (PosOffset.cx = 0) or (PosOffset.cy = 0) then begin
        case j of
          asLeft, asRight: if (fR.Top > Rects[j].Bottom) or (fR.Bottom < Rects[j].Top) then Continue;
          asTop, asBottom: if (fR.Right < Rects[j].Left) or (fR.Left > Rects[j].Right) then Continue;
        end;
        with CheckEdges(Rects[j], fR, X, Y) do begin
          if PosOffset.cx = 0 then
            PosOffset.cx := cx;

          if PosOffset.cy = 0 then
            PosOffset.cy := cy;
        end
      end
      else
        Break;

    Result := (PosOffset.cx <> 0) and (PosOffset.cy <> 0);
  end;

begin
  if FormState and FS_POSCHANGING <> FS_POSCHANGING then begin
    DelFromGluedArray(Form);
    cR := acWorkRect(Form);
    GetWindowRect(Form.Handle, fR);
    PosOffset := MkSize;
    for i := 0 to Length(HookedComponents) - 1 do
      if (HookedComponents[i] is TForm) and (HookedComponents[i] <> Form) and TForm(HookedComponents[i]).Visible and not Linked(TForm(HookedComponents[i])) then
        if CheckWithForm(TForm(HookedComponents[i])) then
          Break;

    if (PosOffset.cx = 0) or (PosOffset.cy = 0) then begin // Look for screen
      cR := LimitRect(DiffBorder(BorderForm), acWorkRect(Form));
      with CheckEdges(cR, fR, X, Y) do begin
        if PosOffset.cx = 0 then PosOffset.cx := cx;
        if PosOffset.cy = 0 then PosOffset.cy := cy;
      end;
    end;
    dec(x, PosOffset.cx);
    dec(y, PosOffset.cy);
  end;
end;


function TsSkinProvider.Linked(f: TForm): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to Length(GluedArray) - 1 do
    if (GluedArray[i].Master = Form) and (GluedArray[i].Slave = f) then begin
      Result := True;
      Exit;
    end;
end;


procedure TsSkinProvider.MoveGluedForms(BlendMoving: boolean = False);
var
  j, k: integer;

  procedure UpdateFormPos(Ndx: integer);
  var
    p: TPoint;
  begin
    with GluedArray[Ndx] do begin
      SendAMessage(Slave, AC_SETPOSCHANGING, 1);
      if BlendMoving and (BorderForm <> nil) then begin
        p := BorderForm.AForm.BoundsRect.TopLeft;
        if SkinData.SkinManager.CommonSkinData.ExDrawMode = 0 then begin
          inc(p.X, DiffBorder(BorderForm) + ShadowSize.Left);
          inc(p.Y, DiffTitle(BorderForm)  + ShadowSize.Top);
        end
        else begin
          inc(p.X, DiffBorder(BorderForm) + SkinData.SkinManager.CommonSkinData.ExContentOffs);
          inc(p.Y, DiffTitle(BorderForm)  + SkinData.SkinManager.CommonSkinData.ExContentOffs);
        end;
      end
      else
        p := Master.BoundsRect.TopLeft;

      Slave.SetBounds(p.X + Pos.X, p.Y + Pos.Y, Slave.Width, Slave.Height);
      SendAMessage(Slave, AC_SETPOSCHANGING, 0);
    end;
  end;

begin
  if FormState and FS_POSCHANGING <> FS_POSCHANGING then
    for j := 0 to GluedForms.Count - 1 do
      for k := 0 to Length(GluedArray) - 1 do
        if (GluedArray[k].Master = Form) and (GluedArray[k].Slave.Name = GluedForms[j]) then
          UpdateFormPos(k);
end;


procedure TsSkinProvider.UpdateSlaveFormsList;
var
  i, j, k, l, ndx: integer;
  R1, R2: TRect;
begin
  for i := 0 to GluedForms.Count - 1 do
    for k := 0 to Length(HookedComponents) - 1 do
      if (HookedComponents[k] is TForm) and (HookedComponents[k] <> Form) and
            TForm(HookedComponents[k]).Visible and (TForm(HookedComponents[k]).Name = GluedForms[i]) then begin

        GetWindowRect(TForm(HookedComponents[k]).Handle, R1);
        GetWindowRect(Form.Handle, R2);
        R1 := LimitRect(DiffBorder(BorderForm), R1, True);
        R2 := LimitRect(DiffBorder(BorderForm), R2, True);
        if (R1.Top = R2.Bottom) or (R1.Left = R2.Right) or (R2.Top = R1.Bottom) or (R2.Left = R1.Right) then begin // Add to list
          l := Length(GluedArray);
          ndx := -1;
          for j := 0 to l - 1 do
            if (GluedArray[j].Master = Form) and (GluedArray[j].Slave = TForm(HookedComponents[k])) then begin
              ndx := j;
              Break;
            end;

          if ndx < 0 then begin
            SetLength(GluedArray, l + 1);
            with GluedArray[l] do begin
              Master := Form;
              Slave := TForm(HookedComponents[k]);
              Pos := Point(TForm(HookedComponents[k]).Left - Form.Left, TForm(HookedComponents[k]).Top - Form.Top);
            end;
          end
          else
            GluedArray[ndx].Pos := Point(TForm(HookedComponents[k]).Left - Form.Left, TForm(HookedComponents[k]).Top - Form.Top);
        end;
      end;
end;


constructor TacFormHeader.Create(AOwner: TsSkinProvider);
begin
  FOwner := AOwner;
end;


procedure TacFormHeader.SetAdditionalHeight(const Value: integer);
begin
  if FAdditionalHeight <> Value then begin
    FAdditionalHeight := Value;
    if not (csLoading in FOwner.ComponentState) then
      FOwner.SkinData.Invalidate;
  end;
end;


procedure TsSkinProvider.InitIndexes;
begin
  FCaptionSkinIndex := FCommonData.SkinManager.GetSkinIndex(s_Caption);
  FHeaderIndex      := FCommonData.SkinManager.GetSkinIndex(s_FormHeader);
  FTitleSkinIndex   := FCommonData.SkinManager.GetSkinIndex(iff(FTitleSkin = '', s_FormTitle, FTitleSkin));
end;


function TsSkinProvider.HeaderUsed: boolean;
begin
  Result := (FormHeader.AdditionalHeight > 0) and (FHeaderIndex >= 0) and (SkinData.SkinManager.gd[FHeaderIndex].States > 1);
end;


procedure TsSkinProvider.UpdateLayerForm;
begin
{$IFDEF DELPHI6UP}
  if not Form.Enabled then begin
    if LayerForm = nil then begin
      LayerForm := TForm.Create(Form);
      LayerForm.BorderStyle := bsNone;
      LayerForm.Color := clBlack;
      LayerForm.Tag := ExceptTag;
      LayerForm.Position := poDesigned;
      LayerForm.AlphaBlend := True;
      LayerForm.Enabled := False;
    end;
    LayerForm.AlphaBlendValue := MaxByte - FDisabledBlendValue;
    if BorderForm <> nil then begin
      LayerForm.Left   := Form.Left   - DiffBorder(BorderForm) - 1;
      LayerForm.Width  := Form.Width  + DiffBorder(BorderForm) * 2 + 2;
      LayerForm.Top    := Form.Top    - DiffTitle (BorderForm) - 1;
      LayerForm.Height := Form.Height + DiffTitle (BorderForm) + DiffBorder(BorderForm) + 2;
    end
    else
      LayerForm.BoundsRect := Form.BoundsRect;

    SetWindowLong(LayerForm.Handle, GWL_EXSTYLE, GetWindowLong(LayerForm.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE);
    LayerForm.Show;
  end
  else
    if LayerForm <> nil then
      FreeAndNil(LayerForm);
{$ENDIF}
end;

{$IFDEF DEBUG}
procedure TsSkinProvider.SetFormState(const Value: Cardinal);
begin
  FFormState := Value;
end;
{$ENDIF}

procedure TsSkinProvider.SetDisabledBlendValue(const Value: byte);
begin
  if FDisabledBlendValue <> Value then begin
    FDisabledBlendValue := Value;
    if not (csDesigning in ComponentState) then
      UpdateLayerForm;
  end;
end;


initialization

finalization
  if hDWMAPI > 0 then
    FreeLibrary(hDWMAPI);

end.




