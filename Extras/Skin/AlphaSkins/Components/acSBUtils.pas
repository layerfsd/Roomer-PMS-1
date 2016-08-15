unit acSBUtils;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  {$IFDEF FPC} JwaWinUser, LMessages, {$ENDIF}
  Windows, Classes, Messages, Controls, Graphics, ExtCtrls, Grids, CommCtrl, Forms, ComCtrls, StdCtrls, TypInfo,
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFNDEF DELPHI5}   types,   {$ENDIF}
  {$IFDEF FPC}        LCLType, {$ENDIF}
  sSkinManager, sCommonData, sConst;


const
  SM_BTNSIZE = 0;
  SM_SCROLLWIDTH = 1;


type
  TDropMarkMode = (dmmNone, dmmLeft, dmmRight);
  THeaderPaintElements = set of (hpeBackground, hpeDropMark, hpeHeaderGlyph, hpeSortGlyph, hpeText);
  TacScrollWnd = class;


  TacSkinParams = record
    Control: TControl;
    SkinSection: string;

    UseSkinColor,
    UseSkinFontColor: boolean;

    VertScrollSize,
    HorzScrollSize,
    VertScrollBtnSize,
    HorzScrollBtnSize: integer;
  end;


  THeaderPaintInfo = record // Do not change this record (imported from VT lib)
    TargetCanvas:     TCanvas;
    Column:           TCollectionItem;

    PaintRectangle,
    TextRectangle:    TRect;

    IsHoverIndex,
    IsDownIndex,
    IsEnabled,
    ShowHeaderGlyph,
    ShowSortGlyph,
    ShowRightBorder:  Boolean;

    DropMark:         TDropMarkMode;

    GlyphPos,
    SortGlyphPos:     TPoint;
  end;


  TacScrollBar = class(TObject)
  protected
    fScrollFlags,           // flags
    nBarType: word;         // SB_HORZ / SB_VERT

    nArrowWidth,            // parallel size (width of horz, height of vert)
    nArrowLength,           // perpendicular size (height of a horizontal, width of a vertical)
    nButSizeAfter,          // size to the right / below the bar
    nButSizeBefore,         // size to the left / above the bar
    nMinThumbSize: integer;

    fButVisibleBefore,         // if the buttons to the left are visible
    fButVisibleAfter: boolean; // if the buttons to the right are visible

    sw: TacScrollWnd;
  public
    fScrollVisible: boolean;
    ScrollInfo: TScrollInfo;    // positional data (range, position, page size etc)
    constructor Create;
  end;


  TacSpeedButtonHandler = class(TObject)
  public
    Ctrl: TControl;
    PCtrl: ^TControl;
    Destroyed: boolean;
    OldWndProc: TWndMethod;
    SkinData: TsCommonData;
    SkinManager: TsSkinManager;
    constructor Create(Btn: TControl; ASkinData: TsCommonData; ASkinManager: TsSkinManager; const SkinSection: string; Repaint: boolean = True); virtual;
    destructor Destroy; override;
    function CallPrevWndProc(const Msg: longint; const WParam: WPARAM; var lParam: LPARAM): LRESULT;
    procedure acWndProc(var Message: TMessage);
    procedure AC_WMPaint(var Message: TWMPaint);
    function PrepareCache: boolean;
    procedure DrawCaption;
    procedure DrawGlyph;
    function Caption: acString;
    function ImgRect: TRect;
    function GlyphHeight: integer;
    function CaptionRect: TRect;
    function TextRectSize: TSize;
    function GlyphWidth: integer;
    procedure DoDrawText(Rect: TRect; Flags: Longint);
    function CurrentState: integer;
  end;


  TacMainWnd = class(TObject)
  public
    DlgMode,
    Destroyed,
    DontRepaint,
    OwnSkinData,
    InDestroying,
    ParamsChanged: boolean;

    WndRect,
    ParentRect: TRect;

    StdColor,
    StdFontColor: TColor;

    ParentWnd,
    CtrlHandle:   hwnd;

    WndSize:      TSize;
    WndPos:       TPoint;
    Caption:      AcString;
    Tag:          integer;
    OldCtrlStyle: TControlStyle;
    OldWndProc:   TWndMethod;
    OldProc:      Pointer;
    SkinManager:  TsSkinManager;
    SkinData:     TsCommonData;
    NewWndProcInstance: Pointer;
    Adapter: TObject;
    procedure AfterCreation;    virtual;
    procedure SaveStdParams;    virtual;
    procedure RestoreStdParams; virtual;
    procedure SetSkinParams;    virtual;
    procedure InitSkinData;     virtual;
    constructor Create(AHandle: hwnd; ASkinData: TsCommonData; ASkinManager: TsSkinManager; const SkinParams: TacSkinParams; Repaint: boolean = True); virtual;
    destructor Destroy; override;
    function CallPrevWndProc(const Handle: hwnd; const Msg: longint; const WParam: WPARAM; var LParam: LPARAM): LRESULT;
    procedure acWndProc(var Message: TMessage); virtual;
    function ProcessMessage(Msg: Cardinal; WPar: WPARAM = 0; LPar: LPARAM = 0): LRESULT;
  end;


  TacSBWnd = class(TacMainWnd)
  private
    FCurrPos,
    FBar1State,
    FBar2State,
    FBtn1State,
    FBtn2State,
    FSliderState: integer;

    FSI: TScrollInfo;
    procedure SetInteger(const Index, Value: integer);
  public
    FBtn1Rect,
    FBtn2Rect,
    FBar1Rect,
    FBar2Rect,
    FSliderRect: TRect;

    p: TPoint;
    CI: TCacheInfo;
    Control: TScrollBar;
    FRepainting: boolean;
    FLockCount, MouseOffset, ScrollCode: integer;

    function Bar1Rect: TRect;
    function Bar2Rect: TRect;
    function Btn1Rect: TRect;
    function Btn2Rect: TRect;

    function BarIsHot: boolean;
    function SliderRect: TRect;
    function SliderSize: integer;
    function WorkSize: integer;
    function PositionToCoord: integer;
    procedure DrawSlider(b: TBitmap);
    function SysBtnSize: integer;

    function CoordToPosition(const ap: TPoint): integer;
    procedure UpdateBar;
    procedure WMNCHitTest(var Message: TWMNCHitTest);

    procedure AfterCreation; override;
    procedure InitScrollData;
    procedure acWndProc(var Message: TMessage); override;
    procedure WMPaint(var Msg: TWMPaint);
    procedure CMMouseLeave;
    procedure CMMouseEnter;
    procedure LMouseDown(const X, Y: Integer);
    procedure LMouseUp  (const X, Y: Integer);

    property Btn1State  : integer index 0 read FBtn1State   write SetInteger;
    property Btn2State  : integer index 1 read FBtn2State   write SetInteger;
    property Bar1State  : integer index 2 read FBar1State   write SetInteger;
    property Bar2State  : integer index 3 read FBar2State   write SetInteger;
    property SliderState: integer index 4 read FSliderState write SetInteger;
  end;


  TacStaticWnd = class(TacMainWnd)
  public
    procedure AfterCreation; override;
    procedure AC_WMPaint(var Message: TWMPaint); virtual;
    procedure acWndProc (var Message: TMessage); override;
    function PaintText: boolean; virtual;
  end;


  TacEdgeWnd = class(TacStaticWnd)
  public
    procedure AC_WMPaint(var Message: TWMPaint); override;
    procedure acWndProc (var Message: TMessage); override;
  end;


  TacIconWnd = class(TacStaticWnd)
  public
    IsBmp: boolean;
    FBmp: TBitmap;
    procedure AfterCreation; override;
    destructor Destroy; override;
    function PaintText: boolean; override;
  end;


  TacLinkWnd = class(TacStaticWnd)
  public
    procedure acWndProc(var Message: TMessage); override;
    function PaintText: boolean; override;
  end;


  TacBtnWnd = class(TacMainWnd)
  protected
    FMouseClicked: boolean;
  public
    procedure AfterCreation; override;
    function CtrlStyle: dword;
    function Down: boolean;
    function CurrentState: integer; virtual;
    procedure DrawCaption;
    procedure DrawGlyph; virtual;
    function GlyphSize: TSize; virtual;
    procedure DoDrawText(var Rect: TRect; const Flags: Longint);
    function CaptionRect: TRect; virtual;
    function MaxCaptionWidth: integer; virtual;
    function TextRectSize: TSize;
    procedure Repaint;
    procedure PrepareCache; virtual;
    procedure SetSkinParams; override;
    procedure RestoreStdParams; override;
    procedure ac_WMPaint(const Message: TWMPaint);
    procedure acWndProc   (var Message: TMessage); override;
  end;


  TacBitBtnWnd = class(TacBtnWnd)
  public
    function GlyphRect:   TRect;
    function CaptionRect: TRect; override;
    function CurrentState:    integer; override;
    function MaxCaptionWidth: integer; override;
    function GlyphSize: TSize; override;
    procedure DrawGlyph; override;
  end;


  TacSplitBtnWnd = class(TacBtnWnd)
  public
    ArrowWidth: integer;
    function ArrowRect: TRect;
    function CaptionRect: TRect; override;
    procedure PrepareCache; override;
  end;


{$IFDEF D2009}
  TacButtonWnd = class(TacBtnWnd)
  public
    Btn: TButton;
    function HaveImage: boolean;
    function CaptionRect: TRect; override;
    function GlyphIndex: integer;
    function GlyphRect: TRect;
    function GlyphSize: TSize; override;
    procedure DrawGlyph; override;
    procedure AfterCreation; override;
  end;
{$ENDIF}


  TacSizerWnd = class(TacMainWnd)
  public
    procedure AfterCreation; override;
    procedure AC_WMPaint(const Message: TWMPaint);
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacSpinWnd = class(TacMainWnd)
  public
    lOffset,
    Btn1State,
    Btn2State: integer;

    bMousePressed: boolean;
    function IsVertical: boolean;
    procedure AfterCreation; override;
    procedure PrepareCache;
    procedure AC_WMPaint(const Message: TWMPaint);
    procedure acWndProc(var Message: TMessage); override;
  end;


  TAPoint = array of TPoint;


  TacTrackWnd = class(TacMainWnd)
  public
    TickHeight: integer;
    bMousePressed: boolean;
    iStep: real;
    function IsVertical: boolean;
    procedure AfterCreation; override;
    procedure PrepareCache;
    procedure PaintBody;
    procedure PaintBar;
    procedure PaintThumb(i: integer);
    procedure PaintTicksHor;
    procedure PaintTicksVer;
    procedure PaintTick(P: TPoint; Horz: boolean);
    function TickMarks: TTickMark;
    function TickStyle: TTickStyle;
    function TickCount: integer;
    function TicksArray: TAPoint;
    function TickPos(const i: integer): integer;
    function ThumbRect: TRect;
    function ChannelRect: TRect;
    function Mode: integer;
    procedure AC_WMPaint(const Message: TWMPaint);
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacCheckBoxWnd = class(TacMainWnd)
  public
    OwnerDraw: boolean;
    function State: TCheckBoxState;
    function CtlState: integer;
    function CheckRect: TRect;
    function SkinCheckRect  (const i: integer): TRect;
    function SkinGlyphWidth (const i: integer): integer;
    function SkinGlyphHeight(const i: integer): integer;
    procedure DrawSkinGlyph (const i: integer);
    procedure DrawCheckText;

    function GlyphMaskIndex(const AState: TCheckBoxState): smallint;
    procedure PrepareCache;
    procedure AC_WMPaint(const Message: TWMPaint);
    procedure AfterCreation; override;
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacContainerWnd = class(TacMainWnd)
  public
    ClientRect: TRect;
    BorderWidth: integer;
    procedure PrepareCache;
    procedure AfterCreation; override;
    procedure AC_WMPaint  (const Message: TWMPaint);
    procedure AC_WMPrint  (const Message: TWMPaint);
    procedure AC_WMNCPaint(const Message: TMessage);
    procedure acWndProc     (var Message: TMessage); override;
  end;


  TacSearchWnd = class(TacMainWnd)
  public
    ClientRect: TRect;
    procedure AfterCreation; override;
    procedure PrepareCache;
    procedure AC_WMNCPaint(const Message: TMessage);
    procedure acWndProc     (var Message: TMessage); override;
  end;


  TacToolBarWnd = class(TacMainWnd)
  public
    ClientRect: TRect;
    BorderWidth: integer;
    procedure PrepareCache;
    procedure DrawButtons (const Bmp: TBitmap);
    procedure DrawBtn     (const Index: integer; const R: TRect; const DC: hdc);
    function GetButtonRect(const Index: integer): TRect;
    procedure AC_WMPaint  (const Message: TWMPaint);
    procedure AC_WMPrint  (const Message: TWMPaint);
    procedure AC_WMNCPaint(const Message: TMessage);
    procedure acWndProc     (var Message: TMessage); override;
    function Count: integer;
  end;


  TacTransPanelWnd = class(TacMainWnd)
  public
    procedure AfterCreation; override;
    procedure AC_WMPaint(const Message: TWMPaint);
    procedure acWndProc   (var Message: TMessage); override;
  end;


  TacGroupBoxWnd = class(TacMainWnd)
  public
    procedure AfterCreation; override;
    function CaptionRect: TRect;
    procedure PrepareCache;
    procedure WriteText(R: TRect);
    procedure AC_WMPaint   (Message: TWMPaint);
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacTabWnd = class(TacMainWnd)
  public
    function DisplayRect: TRect;
    procedure PrepareCache;
    procedure AC_WMPaint   (Message: TWMPaint);
    procedure AC_WMNCPaint (Message: TWMPaint);
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacScrollWnd = class(TacMainWnd)
  public
    fThumbTracking,
    fLeftScrollbar,
    ScrollsInitialized,
    bPreventStyleChange: boolean; // To prevent calling original WindowProc in response to our own temporary style change (fixes TreeView problem)

    sBarHorz,
    sBarVert: TacScrollBar;

    cxLeftEdge,
    cxRightEdge,
    cyTopEdge,
    cyBottomEdge: integer;

    procedure InitSkinData; override;
    destructor Destroy; override;
    procedure acWndProc(var Message: TMessage); override;
  end;

{
  TacFrameWnd = class(TacScrollWnd)
  public
    Frame: TFrame;
    Adapter: TObject;
    procedure AC_WMPaint(const aDC: hdc);
    procedure SearchAdapter;
    function PrepareCache: boolean;
    procedure OurPaintHandler(aDC: hdc);
    procedure acWndProc(var Message: TMessage); override;
  end;
}

  TacAccessPanel = class(TCustomPanel);

  TacPanelWnd = class(TacMainWnd) // TPanel and others
  public
    Panel: TacAccessPanel;
    procedure AfterCreation; override;
    function PrepareCache: boolean;
    procedure AC_WMNCPaint(aDC: hdc = 0);
    procedure AC_WMPaint  (aDC: hdc);
    procedure acWndProc(var Message: TMessage); override;
    procedure WriteText(R: TRect; aCanvas: TCanvas = nil);
  end;


  TacStaticTextWnd = class(TacMainWnd)
  public
    Control: TWinControl;
    procedure AfterCreation; override;
    function PrepareCache: boolean;
    procedure AC_WMNCPaint(aDC: hdc = 0);
    procedure AC_WMPaint  (aDC: hdc);
    procedure acWndProc(var Message: TMessage); override;
    procedure WriteText(R: TRect; aCanvas: TCanvas = nil);
  end;


{$IFNDEF NOMNUHOOK}
  TacMnuWnd = class(TacScrollWnd)
  protected
    Shown,
    bFlag: boolean;
  public
    RgnChanged: integer;
    procedure PrepareCache;
    procedure acWndProc(var Message: TMessage); override;
    procedure AfterCreation; override;
  end;
{$ENDIF}


  TacBaseWnd = class(TacScrollWnd)
  public
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacMDIWnd = class(TacBaseWnd)
  public
    FForm: TForm;
    SkinProvider: TObject;
    MDISkinData: TsCommonData;
    destructor Destroy; override;
    procedure acWndProc(var Message: TMessage); override;
    procedure UpdateGraphControls;
  end;


  TacEditWnd = class(TacBaseWnd) // TCustomEdit, TCustomListbox compatible
  public
    FClientRect: TRect;
    FrameColor: integer;

    SingleLineEdit,
    CtrlListChanged: boolean;

    Color,
    FocusColor,
    FixedGradientFrom,
    FixedGradientTo: TColor;
{$IFDEF D2010}
    DrawingStyle: TGridDrawingStyle;
{$ENDIF}
    constructor Create(AHandle: hwnd; ASkinData: TsCommonData; ASkinManager: TsSkinManager; const SkinParams: TacSkinParams; Repaint: boolean = True); override;
    procedure acWndProc(var Message: TMessage); override;
    function HandleAlphaCmd(var Message: TMessage): boolean;
    procedure SaveStdParams; override;
    procedure SetSkinParams; override;
    procedure RestoreStdParams; override;
    function ClientRect: TRect;
  end;


  TacScrollBoxWnd = class(TacScrollWnd)
  public
    procedure PrepareCache;
    procedure AC_WMNCPaint(aDC: hdc);
    procedure AC_WMPaint(aDC: hdc);
    procedure acWndProc(var Message: TMessage); override;
    procedure AfterCreation; override;
  end;


  TacNativePaint = class(TacScrollBoxWnd)
  public
    procedure AfterCreation; override;
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacComboListWnd = class(TacEditWnd) // ComboListBox
  public
    Showed,
    DBScroll,
    SimplyBox: boolean;
    procedure AfterCreation; override;
    constructor CreateEx(AHandle: hwnd; ASkinData: TsCommonData; ASkinManager: TsSkinManager; const SkinSection: string; Repaint: boolean; Simply: boolean);
    procedure SetSkinParams; override;
    destructor Destroy; override;
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacListViewWnd = class(TacEditWnd) // TCustomListView compatible
  public
    FhWndHeader: HWnd;

    FhHeaderProc,
    FhDefHeaderProc: Pointer;

    FPressedColumn,
    HoverColIndex: integer;
    function AutoSizedCols: boolean;
    function ViewStyle: TViewStyle;
    procedure AfterCreation;    override;
    procedure SaveStdParams;    override;
    procedure SetSkinParams;    override;
    procedure RestoreStdParams; override;
    procedure acWndProc(var Message: TMessage); override;
    // Header
    procedure ColumnSkinPaint(ControlRect: TRect; cIndex: Integer; DC: hdc);
    function HotTrack: boolean;
    procedure HeaderWndProc(var Message: TMessage);
    function GetHeaderColumnRect(Index: Integer): TRect;
    procedure PaintHeader(DC: hdc);
  end;


  TacGridWnd = class(TacEditWnd) // TCustomGrid compatible
  public
    IndColor,
    FixedColor,
    TitleColor,
    EvenRowColor,
    OddRowColor,
    FooterColor,
    GridLineColor,
    TitleFontColor,
    SelectionColor,
    FooterCellColor,
    SelectionTextColor,
    GridFixedLineColor,
    FixedGradientMirrorTo,
    FixedGradientMirrorFrom: TColor;

    procedure acWndProc(var Message: TMessage); override;
    procedure SaveStdParams; override;
    procedure SetSkinParams; override;
    procedure RestoreStdParams; override;
  end;


  TacGridEhWnd = class(TacGridWnd) // TGridEh compatible
  public
    Fixed3D: boolean;
    DarkColor,
    BrightColor,
    DataHorzColor,
    DataVertColor,
    DataGroupColor,
    CategoriesColor,
    CategoriesFontColor,
    RowDetailColor: TColor;

    IndHorzLines,
    IndVertLines,
    InfFillStyle,
    TitleHorzLines,
    TitleFillStyle: integer;

    procedure acWndProc(var Message: TMessage); override;
    procedure SaveStdParams; override;
    procedure SetSkinParams; override;
    procedure RestoreStdParams; override;
  end;


  TacTreeViewWnd = class(TacEditWnd) // TCustomTreeView compatible
  protected
    SkipBG: boolean;
  public
    procedure acWndProc(var Message: TMessage); override;
    procedure SetSkinParams; override;
    procedure RestoreStdParams; override;
  end;


  TacComboBoxWnd = class(TacEditWnd) // TCustomComboBox compatible
  public
    FListHandle: hwnd;
    LBoxOpening: boolean;
    ListSW: TacComboListWnd;
    LBSkinData: TsCommonData;
    function ButtonHeight: integer;
    function ButtonRect: TRect; virtual;
    procedure PaintButton(DC: hdc);
    procedure RepaintButton;
    procedure PaintText;
    procedure PrepareSimple;
    procedure AfterCreation; override;
    destructor Destroy; override;
    procedure Invalidate;
    function EasyComboBox: boolean;
    procedure CNDrawItem(var Message: TWMDrawItem);
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState; DC: hdc);
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacVirtualTreeViewWnd = class(TacEditWnd) // TVirtualStringTree compatible
  public
    HotColor,
    FileTextColor,
    FolderTextColor,
    SelectionTextColor,
    CompressedTextColor,
    FocusedSelectionColor,
    UnfocusedSelectionColor,
    FocusedSelectionBorderColor,
    UnfocusedSelectionBorderColor: TColor;
    OwnerDraw: boolean;
    PropInfo: PPropInfo;
    procedure AdvancedHeaderDraw     (Sender: TPersistent; var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements);
    procedure HeaderDrawQueryElements(Sender: TPersistent; var PaintInfo: THeaderPaintInfo; var   Elements: THeaderPaintElements);
    procedure SaveStdParams; override;
    procedure SetSkinParams; override;
    procedure RestoreStdParams; override;
    procedure acWndProc(var Message: TMessage); override;
  end;


  // TacWWComboBoxWnd
  TacWWComboBoxWnd = class(TacComboBoxWnd)
  private
    FShowButton: Boolean;
    ListBox: TCustomListBox;
    ListBoxSW: TacScrollWnd;
    ListBoxSkinData: TsScrollWndData;
    function GetShowButton(aCtrl: TWinControl): Boolean;
  public
    procedure acWndProc(var Message: TMessage); override;
    function ButtonRect: TRect;  override;
    procedure AfterCreation; override;
    destructor Destroy; override;
  end;


  // Windows TabControl
  TacTabControlWnd = class(TacMainWnd)
  public
    BtnSW: TacSpinWnd;
    function TabCount: integer;
    function ClientRect: TRect; virtual;
    function PageRect:   TRect; virtual;
    function TabRect(const Index: integer): TRect;
    function TabRow(TabIndex: integer): integer;
    function TabsRect: TRect;
    function TabPosition: TTabPosition;
    function Style: TTabStyle;

    function ActiveTabIndex: integer;
    function SkinTabRect(Index: integer; Active: boolean): TRect;

    procedure CheckUpDown;
    procedure DrawSkinTabs(const CI: TCacheInfo);
    procedure DrawSkinTab(Index: Integer; State: integer; Bmp: TBitmap; OffsetPoint: TPoint); overload;
    procedure DrawSkinTab(Index: Integer; State: integer; DC: hdc); overload;

    procedure AC_WMPaint(var Message: TWMPaint);
    procedure acWndProc (var Message: TMessage); override;
    procedure AfterCreation; override;
    destructor Destroy; override;
  end;


  TacPageWnd = class(TacMainWnd)
  public
    Page: TTabSheet;
    function TabPosition: TTabPosition;
    procedure AC_WMEraseBKGnd(var Message: TWMPaint);
    procedure acWndProc(var Message: TMessage); override;
    procedure AfterCreation; override;
  end;


  TacPageControlWnd = class(TacTabControlWnd) // TPageControl from Delphi
  public
    procedure InitPages;
    procedure AfterCreation;    override;
    function PageRect:   TRect; override;
    function ClientRect: TRect; override;
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacToolBarVCLWnd = class(TacMainWnd)
  public
    ToolBar: TToolBar;
    HotButtonIndex: integer;
    DroppedButton: TToolButton;
    procedure PrepareCache;
    function DisplayRect: TRect;
    procedure AfterCreation; override;
    procedure WMNCPaint(const aDC: hdc = 0);
    function GetButtonRect(Index: integer): TRect;
    function IndexByMouse(MousePos: TPoint): integer;
    procedure OurAdvancedCustomDraw(Sender: TToolBar; const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
{$IFNDEF FPC}
    procedure RepaintButton(Index: integer);
    procedure OurAdvancedCustomDrawButton(Sender: TToolBar; Button: TToolButton; State: TCustomDrawState; Stage: TCustomDrawStage; var Flags: TTBCustomDrawFlags; var DefaultDraw: Boolean);
{$ENDIF}
    procedure acWndProc(var Message: TMessage); override;
  end;


  TacStatusBarWnd = class(TacMainWnd)
  public
    StatusBar: TStatusBar;
    function SimplePanel: boolean;
    function PartsCount: integer;
    function PartText(const Index: integer): acString;
    function PartRect(const Index: integer): TRect;

    procedure AfterCreation; override;
    procedure PaintPanels;
    procedure PaintGrip;
    procedure DrawPanel(const Index: integer; const Rect: TRect);
    procedure InternalDrawPanel(const Index: integer; const Rect: TRect);
    procedure DoDrawText(const Text: acString; var Rect: TRect; const Flags: Longint);
    procedure PrepareCache;
    procedure WMPaint(const aDC: hdc = 0);
    procedure WMNCPaint(const aDC: hdc = 0);
    procedure acWndProc(var Message: TMessage); override;
  end;

  TGetDBFieldCheckState = function(DataLink: TObject): TCheckBoxState;

const
  // TabControl offsets
  TopOffset    = 4;
  BottomOffset = 2;
  LeftOffset   = 1;
  RightOffset  = 1;
  acTabSides: array [TTabPosition] of TacSide = (asTop, asBottom, asLeft, asRight);

var
  nLastSBPos:     integer = -1;
  acMinThumbSize: integer = 16;
  acDlgMode:      boolean;

  Ac_UninitializeFlatSB: procedure(hWnd: HWND); stdcall;
  Ac_InitializeFlatSB:    function(hWnd: HWND): Bool; stdcall;

  GetDBFieldCheckState: TGetDBFieldCheckState = nil;

type
  TacScrollWndClass = class of TacMainWnd;
  TacWinControl = class(TWinControl);


procedure InitCtrlData(Wnd: hwnd; var ParentWnd: hwnd; var WndRect: TRect; var ParentRect: TRect; var WndSize: TSize; var WndPos: TPoint);
function Ac_GetScrollWndFromHwnd(const AHandle: hwnd): TacScrollWnd;

procedure RefreshScrolls     (SkinData: TsScrollWndData; var ListSW: TacScrollWnd);
procedure RefreshEditScrolls (SkinData: TsScrollWndData; var ListSW: TacScrollWnd);
procedure RefreshTreeScrolls (SkinData: TsScrollWndData; var ListSW: TacScrollWnd; SkipBGMessage: boolean);

procedure UninitializeACScroll(Handle: hwnd; FreeSW: boolean; Repaint: boolean; var ListSW: TacScrollWnd);
procedure UninitializeACWnd   (Handle: hwnd; FreeSW: boolean; Repaint: boolean; var ListSW: TacMainWnd);
// Painting
function ac_NCDraw(sw: TacScrollWnd; Handle: hwnd; ThumbPos: integer = -1; aDC: hdc = 0): LRESULT;
procedure PrepareCache(SkinData: TsCommonData; CtrlHandle: hwnd = 0; DlgMode: boolean = False);
procedure ac_DrawScrollBtn(bRect: TRect; State: integer; Bmp: TBitmap; cd: TsCommonData; Side: TacSide);
procedure ac_DrawSlider   (bRect: TRect; State: integer; Bmp: TBitmap; sm: TsSkinManager; Vert: boolean);
// Scroll Data
procedure ac_GetHScrollRect(sw: TacScrollWnd; Handle: hwnd; var R: TRect);
procedure ac_GetVScrollRect(sw: TacScrollWnd; Handle: hwnd; var R: TRect);

function GetScrollMetric(sBar: TacScrollBar; metric: integer; Btn: boolean = False): integer;
procedure SendScrollMessage(const Handle: hwnd; const scrMsg: integer; const scrId: integer; const pos: integer);
procedure UpdateScrolls(const sw: TacScrollWnd; const Repaint: boolean = False);
function BtnDrawRect(R: TRect; cd: TsCommonData; Side: TacSide): TRect;
// Paint Data
procedure AlphaBroadCastCheck(const Control: TControl; const Handle: hwnd; var Message);
function MayBeHot(const SkinData: TsCommonData; const ByMouse: boolean = True): boolean;

implementation


uses
  SysUtils, math, Buttons, ImgList, ToolWin, Menus,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFNDEF ALITE} sSplitter, sFrameAdapter, {$ENDIF}
  {$IFDEF TNTUNICODE} TntControls, TntStdCtrls, TntButtons, {$ENDIF}
  {$IFDEF USEPNG} PngImageList, PngFunctions, PngImage, {$ENDIF}
  {$IFDEF ADDWEBBROWSER} acWB, {$ENDIF}
  acntUtils, sGraphUtils, sStyleSimply, sSkinProps, sDefaults, sSkinProvider, acDials, sSkinMenus, sFade, sBorders,
  sThirdParty, acGlow, sAlphaGraph, sMessages, sVclUtils, sMaskData, sMDIForm, acAlphaImageList, acThdTimer, acntTypes;


const
  acPropStr = 'ACSBSC';

  SM_SCROLL_LENGTH = 0;

  COOLSB_NONE     = -1;
  HTSCROLL_NONE	  = -1;
  HTSCROLL_NORMAL = -1;
  SYSTEM_METRIC   = -1;

  COOLSB_TIMERID1 = 65533; // initial timer
  COOLSB_TIMERID2 = 65534; // scroll message timer
  COOLSB_TIMERID3 = 65522; // mouse hover timer
  COOLSB_TIMERINTERVAL1	= 300;
  COOLSB_TIMERINTERVAL2	= 55;
  COOLSB_TIMERINTERVAL3	= 20;	// mouse hover time

  HTSCROLL_LEFT      = SB_LINELEFT;
  HTSCROLL_UP        = SB_LINEUP;
  HTSCROLL_DOWN      = SB_LINEDOWN;
  HTSCROLL_RIGHT     = SB_LINERIGHT;
  HTSCROLL_THUMB     = SB_THUMBTRACK;
  HTSCROLL_PAGELEFT  = SB_PAGELEFT;
  HTSCROLL_PAGERIGHT = SB_PAGERIGHT;
  HTSCROLL_PAGEUP    = SB_PAGEUP;
  HTSCROLL_PAGEDOWN  = SB_PAGEDOWN;

  CSBS_THUMBALWAYS = 4;
  CSBS_VISIBLE     = 8;

// Font types
  FONT_CAPTION   = 1;
  FONT_SMCAPTION = 2;
  FONT_MENU      = 3;
  FONT_STATUS    = 4;
  FONT_MESSAGE   = 5;

  ERASE_OK       = 1;

  // Properties names
  acDisabledKind            = 'DisabledKind';
  acColor                   = 'Color';
  // DBGrid
  acTitleFont               = 'TitleFont';
  acDataSource              = 'DataSource';

  // AdvGrid
  acFont                    = 'Font';
  acFixedFont               = 'FixedFont';
  acFixedColor              = 'FixedColor';
  acSelectionColor          = 'SelectionColor';
  acSelectionTextColor      = 'SelectionTextColor';
  acControlLook             = 'ControlLook';
  acFixedGradientFrom       = 'FixedGradientFrom';
  acFixedGradientTo         = 'FixedGradientTo';
  acFixedGradientMirrorFrom = 'FixedGradientMirrorFrom';
  acFixedGradientMirrorTo   = 'FixedGradientMirrorTo';
  acGridFixedLineColor      = 'GridFixedLineColor';
  acGridLineColor           = 'GridLineColor';

  // wwGrid
  acIndColor                = 'IndicatorIconColor';
  acFooterColor             = 'FooterColor';
  acFooterCellColor         = 'FooterCellColor';
  acTitleColor              = 'TitleColor';
  acTwwDBGrid               = 'TwwDBGrid';
  acDataColor               = 'DataColor';
  acShadowColor             = 'ShadowColor';
  acLineColors              = 'LineColors';

  acVETColors               = 'VETColors';
  acColors                  = 'Colors';
  acHotColor                = 'HotColor';
  accoWrapCaption           = 'coWrapCaption';
  acSortDirection           = 'SortDirection';

  acCompressedTextColor     = 'CompressedTextColor';
  acFileTextColor           = 'FileTextColor';
  acFolderTextColor         = 'FolderTextColor';

  acFocusedSelectionColor         = 'FocusedSelectionColor';
  acFocusedSelectionBorderColor   = 'FocusedSelectionBorderColor';
  acUnfocusedSelectionBorderColor = 'UnfocusedSelectionBorderColor';
  acUnfocusedSelectionColor       = 'UnfocusedSelectionColor';

  // Raize
  acFocusColor = 'FocusColor';

  // MustangPeak
  acOnAdvancedHeaderDraw      = 'OnAdvancedHeaderDraw';
  acOnHeaderDrawQueryElements = 'OnHeaderDrawQueryElements';
  achoOwnerDraw     = 'hoOwnerDraw';
  achoVisible       = 'hoVisible';
  acPaintInfoColumn = 'PaintInfoColumn';
  acThemed          = 'Themed';
  acStyle           = 'Style';
  acHeight          = 'Height';
  acOptions         = 'Options';
  acHeader          = 'Header';

  // SMDBFrid
  acGridStyle       = 'GridStyle';
  acTitle           = 'Title';
  acStartColor      = 'StartColor';
  acEndColor        = 'EndColor';

  // EhLib
  acOptionsEh       = 'OptionsEh';
  acdghFixed3D      = 'dghFixed3D';
  acEvenRowColor    = 'EvenRowColor';
  acOddRowColor     = 'OddRowColor';
  acGridLineParams  = 'GridLineParams';
  acBrightColor     = 'BrightColor';
  acDataGrouping    = 'DataGrouping';
  acDataHorzColor   = 'DataHorzColor';
  acDataVertColor   = 'DataVertColor';
  acDarkColor       = 'DarkColor';
  acIndicatorParams = 'IndicatorParams';
  acHorzLines       = 'HorzLines';
  acVertLines       = 'VertLines';
  acFillStyle       = 'FillStyle';
  acTitleParams     = 'TitleParams';
  acSecondColor     = 'SecondColor';
  acVertLineColor   = 'VertLineColor';
  acRowDetailPanel  = 'RowDetailPanel';
  acRowCategories   = 'RowCategories';
  acText            = 'Text';


var
  uCurrentScrollbar     : integer = COOLSB_NONE;
  uMouseOverScrollbar   : integer = COOLSB_NONE;

  uScrollTimerPortion   : integer = HTSCROLL_NONE;
  uLastHitTestPortion   : integer = HTSCROLL_NONE;
  uHitTestPortion       : integer = HTSCROLL_NONE;
  uCurrentScrollPortion : integer = HTSCROLL_NONE;

  hwndCurSB:     THandle = 0;
  uScrollTimerMsg: dword = 0;
  uMouseOverId:    dword = 0;

  nThumbPos,
  nThumbSize,
  nThumbMouseOffset: integer;

  rcThumbBounds,
  MouseOverRect: TRect;

  uScrollTimerId: longint = 0;
  bDroppedDown: boolean = False;

  ServWndList: TList;
  Ac_GetScrollBarInfo: function(hwnd: HWND; idObject: Longint; var psbi: TScrollBarInfo): BOOL; stdcall;


type
  TAdvancedHeaderPaintEvent      = procedure(Sender: TPersistent; var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements) of object;
  THeaderPaintQueryElementsEvent = procedure(Sender: TPersistent; var PaintInfo: THeaderPaintInfo; var   Elements: THeaderPaintElements) of object;

  PAdvancedHeaderPaintEvent = ^TAdvancedHeaderPaintEvent;
  PHeaderPaintQueryElementsEvent = ^THeaderPaintQueryElementsEvent;

  TAccessWinControl = class(TWinControl);


function ac_GetSysFont(const fType: integer): hFont;
var
  NonClientMetrics: TNonClientMetricsW;
begin
  FillChar(NonClientMetrics, SizeOf(NonClientMetrics), 0);
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfoW(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    with NonClientMetrics do
      case fType of
        FONT_CAPTION:   Result := CreateFontIndirectW({$IFDEF FPC}@lfCaptionFont  {$ELSE}lfCaptionFont  {$ENDIF});
        FONT_SMCAPTION: Result := CreateFontIndirectW({$IFDEF FPC}@lfSmCaptionFont{$ELSE}lfSmCaptionFont{$ENDIF});
        FONT_MENU:      Result := CreateFontIndirectW({$IFDEF FPC}@lfMenuFont     {$ELSE}lfMenuFont     {$ENDIF});
        FONT_STATUS:    Result := CreateFontIndirectW({$IFDEF FPC}@lfStatusFont   {$ELSE}lfStatusFont   {$ENDIF})
        else            Result := CreateFontIndirectW({$IFDEF FPC}@lfMessageFont  {$ELSE}lfMessageFont  {$ENDIF}); {FONT_MESSAGE}
      end
    else
      Result := 0;
end;


procedure LoadSysFont(const aCanvas: TCanvas; const aFontType: integer);
var
  FontHandle: HFont;
  NewFont: TFont;
begin
  FontHandle := ac_GetSysFont(aFontType);
  if FontHandle <> 0 then begin
    NewFont := TFont.Create;
    NewFont.Handle := FontHandle;
    aCanvas.Font.Assign(NewFont);
    SelectObject(aCanvas.Handle, aCanvas.Font.Handle);
    NewFont.Free;
  end
end;


procedure LoadCtrlFont(const ListSW: TacMainWnd);
var
  hf: hFont;
begin
  with ListSW, SkinData.FCacheBMP do
    if SkinData.FOwnerControl <> nil then begin
      Canvas.Font.Assign(TsAccessControl(SkinData.FOwnerControl).Font);
      SelectObject(Canvas.Handle, Canvas.Font.Handle);
    end
    else begin
      hf := Cardinal(TrySendMessage(CtrlHandle, WM_GETFONT, 0, 0));
      if hf <> 0 then begin
        Canvas.Font.Handle := hf;
        if (Canvas.Font.Charset = 0) and (Pos('MS Shell Dlg', Canvas.Font.Name) = 0) {avoid a bad font output in file dialogs} then
          Canvas.Font.Charset := DEFAULT_CHARSET;

        SelectObject(Canvas.Handle, hf);
      end
      else
        LoadSysFont(Canvas, FONT_MESSAGE);
    end;
end;


procedure AlphaBroadCastCheck(const Control: TControl; const Handle: hwnd; var Message);
begin
  if Control <> nil then
    AlphaBroadcast(TWinControl(Control), Message)
  else
    AlphaBroadcast(Handle, Message);
end;


function MayBeHot(const SkinData: TsCommonData; const ByMouse: boolean = True): boolean;
begin
  Result := False;
  with SkinData do
    if (SkinData <> nil) and (SkinManager <> nil) and (SkinIndex >= 0) and (BorderIndex >= 0) then begin
      if not ByMouse or not (COC in sNoHotEdits) or ac_AllowHotEdits then
        with SkinManager do
          Result := (not Options.NoMouseHover or not ByMouse) and ((ma[BorderIndex].ImageCount > 1) or (gd[SkinIndex].States > 1));
  end;
end;


procedure TryChangeIntProp(const Obj: TObject; const Name: string; Value: TColor);
begin
  if (Obj <> nil) and HasProperty(Obj, Name) then
    SetIntProp(Obj, Name, Value);
end;


function TryGetColorProp(const Obj: TObject; const Name: string): TColor;
begin
  if (Obj <> nil) and HasProperty(Obj, Name) then
    Result := ColorToRGB(GetIntProp(Obj, Name))
  else
    Result := 0;
end;


function TryGetIntProp(const Obj: TObject; const Name: string): integer;
begin
  if (Obj <> nil) and HasProperty(Obj, Name) then
    Result := GetIntProp(Obj, Name)
  else
    Result := 0;
end;


function SearchWndAsCtrl(Wnd: hwnd; Component: TComponent): TWincontrol;
var
  i: integer;
begin
  Result := nil;
  with Component do
    for i := 0 to ComponentCount - 1 do begin
      if (Components[i] is TWinControl) and TWinControl(Components[i]).HandleAllocated and (TWinControl(Components[i]).Handle = Wnd) then begin
        Result := TWinControl(Components[i]);
        Exit;
      end;
      Result := SearchWndAsCtrl(Wnd, Components[i]);
      if Result <> nil then
        Exit;
    end;
end;


procedure InitCtrlData(Wnd: hwnd; var ParentWnd: hwnd; var WndRect: TRect; var ParentRect: TRect; var WndSize: TSize; var WndPos: TPoint);
begin
  GetWindowRect(Wnd, WndRect);
  ParentWnd := GetParent(Wnd);
  GetWindowRect(ParentWnd, ParentRect);
  WndSize := MkSize(WndRect);
  WndPos := WndRect.TopLeft;
  ScreenToClient(ParentWnd, WndPos);
end;


procedure UpdateWndCorners(SkinData: TsCommonData; State: integer; Wnd: TacMainWnd);
var
  dw, dh, w, iWidth, iHeight: integer;
  ParentColor: TsColor;
  ParentRGB: TsColor_;
  SrcBmp: TBitmap;
  CI: TCacheInfo;

  procedure CopyTransCorner(SrcBmp: Graphics.TBitMap; X, Y: integer; SrcRect: TRect);
  var
    h, w, DeltaS, DeltaD, sX, sY, SrcX, DstX, DstY: Integer;
    CacheWidth, CacheHeight, CIWidth, CIHeight: integer;
    S0, S: PRGBAArray_S;
    D0, D: PRGBAArray_D;
  begin
    if not SkinData.FCacheBmp.Empty then begin
      if SrcRect.Top < 0 then
        SrcRect.Top := 0;

      if SrcRect.Bottom >= SrcBmp.Height then
        SrcRect.Bottom := SrcBmp.Height - 1;

      if SrcRect.Left < 0 then
        SrcRect.Left := 0;

      if SrcRect.Right >= SrcBmp.Width then
        SrcRect.Right := SrcBmp.Width - 1;

      h := HeightOf(SrcRect);
      w := WidthOf(SrcRect);

      if ci.Ready then begin
        if ci.Bmp.PixelFormat = pf32bit then
          if not InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(SkinData.FCacheBmp, Pointer(D0), DeltaD) then
            try
              CacheWidth := SkinData.FCacheBmp.Width;
              CacheHeight := SkinData.FCacheBmp.Height;
              CIWidth := ci.Bmp.Width;
              CIHeight := ci.Bmp.Height;
              for sY := 0 to h do begin
                DstY := sY + Y;
                if (DstY < CacheHeight) and (DstY >= 0) then begin
                  S := Pointer(LongInt(S0) + DeltaS * (sY + SrcRect.Top));
                  D := Pointer(LongInt(D0) + DeltaD * DstY);
                  for sX := 0 to w do begin
                    DstX := sX + X;
                    if (DstX < CacheWidth) and (DstX >= 0) then begin
                      SrcX := sX + SrcRect.Left;
                      if S[SrcX].SC = sFuchsia.C {if transparent pixel} then
                        if (ci.Y + DstY < CIHeight) and (ci.X + DstX < CIWidth) and (ci.Y + DstY >= 0) and (ci.X + DstX >= 0) then
                          with GetAPixel(ci.Bmp, ci.X + DstX, ci.Y + DstY), D[DstX] do begin
                            DR := B;
                            DG := G;
                            DB := R;
                          end;
                    end;
                  end
                end;
              end;
            finally
            end;
      end
      else
        if ParentColor.C <> clFuchsia then
          if not InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(SkinData.FCacheBmp, Pointer(D0), DeltaD) then begin
            CacheWidth := SkinData.FCacheBmp.Width;
            CacheHeight := SkinData.FCacheBmp.Height;
            for sY := 0 to h do begin
              DstY := sY + Y;
              if (DstY < CacheHeight) and (DstY >= 0) then begin
                S := Pointer(LongInt(S0) + DeltaS * (sY + SrcRect.Top));
                D := Pointer(LongInt(D0) + DeltaD * DstY);
                for sX := 0 to w do begin
                  DstX := sX + X;
                  if (DstX < CacheWidth) and (DstX >= 0) then begin
                    SrcX := sX + SrcRect.Left;
                    if S[SrcX].SC = sFuchsia.C {if transparent pixel} then
                      D[DstX].DC := ParentRGB.C
                  end;
                end
              end;
            end;
          end;
    end;
  end;

  procedure CopyMasterCorner(R1, R2: TRect; Bmp: TBitmap);
  var
    S0, S: PRGBAArray_S;
    D0, D: PRGBAArray_D;
    DeltaS, DeltaD, X, Y, h, w, dX1, dX2: Integer;
    col: TsColor;
  begin
    if not SkinData.FCacheBmp.Empty then begin
      if CI.Ready then begin
        if R1.Left + ci.X < 0 then
          R1.Left := -ci.X;

        if R1.Top + ci.Y < 0 then
          R1.Top := -ci.Y;
      end;
      h := Min(HeightOf(R1), HeightOf(R2));
      h := Min(h, SkinData.FCacheBmp.Height - R1.Top);
      h := Min(h, Bmp.Height - R2.Top) - 1;
      if h < 0 then
        Exit;

      w := Min(WidthOf(R1), WidthOf(R2));
      w := Min(w, SkinData.FCacheBmp.Width - R1.Left);
      w := Min(w, Bmp.Width - R2.Left) - 1;

      if CI.Ready then begin
        if R1.Left + w + CI.X > CI.Bmp.Width then
          w := CI.Bmp.Width - R1.Left - CI.X;

        if R1.Top + h + CI.Y > CI.Bmp.Height then
          h := CI.Bmp.Height - R1.Top - CI.Y;
      end;
      if (w <= 0) or (h <= 0) then
        Exit;

      if R1.Left < R2.Left then begin
        if R1.Left < 0 then begin
          inc(R2.Left, - R1.Left);
          dec(h, - R1.Left);
          R1.Left := 0;
        end;
      end
      else
        if R2.Left < 0 then begin
          inc(R1.Left, - R2.Left);
          dec(h, - R2.Left);
          R2.Left := 0;
        end;

      if R1.Top < R2.Top then begin
        if R1.Top < 0 then begin
          inc(R2.Top, - R1.Top);
          dec(h, - R1.Top);
          R1.Top := 0;
        end;
      end
      else
        if R2.Top < 0 then begin
          inc(R1.Top, - R2.Top);
          dec(h, - R2.Top);
          R2.Top := 0;
        end;

      col.C := CI.FillColor;
      if not CI.Ready then begin
        if CI.FillColor <> clFuchsia then
          if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(SkinData.FCacheBmp, Pointer(D0), DeltaD) then
            for Y := 0 to h do begin
              S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
              D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
              for X := 0 to w do
                if S[R2.Left + X].SC = sFuchsia.C then
                  D[R1.Left + X].DC := col.C
            end;

      end
      else
        if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(SkinData.FCacheBmp, Pointer(D0), DeltaD) then
          for Y := 0 to h do begin
            S := Pointer(LongInt(S0) + DeltaS * (R2.Top + Y));
            D := Pointer(LongInt(D0) + DeltaD * (R1.Top + Y));
            dX1 := R1.Left;
            dX2 := R2.Left;
            for X := 0 to w do begin
              if S[dX2].SC = sFuchsia.C then
                D[dX1].DC := GetAPixel(ci.Bmp, dX1 + ci.X, R1.Top + ci.Y + Y).C;

              inc(dX1);
              inc(dX2);
            end;
          end;
    end;
  end;

begin
  with Skindata do
    if Assigned(SkinManager) and not Wnd.DlgMode then begin
      if SkinManager.IsValidImgIndex(BorderIndex) and Assigned(FCacheBmp) and (Wnd.WndSize.cx > 1) and (Wnd.WndSize.cy > 1) then begin
        CI := GetParentCacheHwnd(Wnd.CtrlHandle);
        with SkinManager.ma[BorderIndex] do begin
          dw := Width;  // Width of mask
          dh := Height; // Height of mask
          if (dw <> 0) and (dh <> 0) then begin
            iWidth  := Wnd.WndSize.cx;
            iHeight := Wnd.WndSize.cy;
            if (ImageCount = 0) and (Bmp <> nil) then begin // if external
              MaskType := 1;
              ImageCount := 3;
              R := MkRect(Bmp);
            end;
            if not CI.Ready then begin
              ParentColor.C := ColorToRGB(CI.FillColor);
              ParentRGB.R := ParentColor.R;
              ParentRGB.G := ParentColor.G;
              ParentRGB.B := ParentColor.B;
            end
            else begin
              inc(CI.X, Wnd.WndPos.x);
              inc(CI.Y, Wnd.WndPos.y);
            end;
            if State >= ImageCount then
              State := ImageCount - 1;

            dw := State * dw;
            w := Width - wl - wr; // Width of piece of mask
            if Bmp <> nil then
              SrcBmp := Bmp
            else
              SrcBmp := SkinManager.MasterBitmap;

            if MaskType = 0 then begin // Copy without mask
              CopyTransCorner(SrcBmp, 0, 0, Rect(R.Left + dw, R.Top, R.Left + dw + wl - 1, R.Top + wt - 1));
              CopyTransCorner(SrcBmp, 0, iHeight - wb, Rect(R.Left, R.Bottom - wb, R.Left + wl - 1, R.Bottom - 1));
              CopyTransCorner(SrcBmp, iWidth - wr, iHeight - wb, Rect(R.Left + dw + wl + w, R.Bottom - wb, R.Left + dw + wl + w + wr - 1, R.Bottom - 1));
              CopyTransCorner(SrcBmp, iWidth - wr, 0, Rect(R.Left + dw + wl + w, R.Top, R.Left + dw + wl + w + wr - 1, R.Top + wb - 1));
            end
            else begin
              CopyMasterCorner(MkRect(wl + 1, wt + 1), Rect(R.Left + dw, R.Top, R.Left + dw + wl, R.Top + wt), SrcBmp);
              CopyMasterCorner(Rect(0, iHeight - wb, wl, iHeight), Rect(R.Left + dw, R.Top + dh - wb, R.Left + dw + wl, R.Top + dh), SrcBmp);
              CopyMasterCorner(Rect(iWidth - wr, iHeight - wb, iWidth, iHeight), Rect(R.Left + dw + wl + w, R.Top + dh - wb, R.Left + dw + wl + w + wr, R.Top + dh), SrcBmp);
              CopyMasterCorner(Rect(iWidth - wr, 0, iWidth, wt), Rect(R.Left + dw + wl + w, R.Top, R.Left + dw + wl + w + wr, R.Top + wt), SrcBmp);
            end;
          end;
        end;
      end;
    end;
end;


procedure RefreshScrolls(SkinData: TsScrollWndData; var ListSW: TacScrollWnd);
var
  sp: TacSkinParams;
begin
  if [csLoading, csDestroying, csDesigning] * SkinData.FOwnerControl.ComponentState = [] then
    if SkinData.Skinned then begin
      if Assigned(Ac_UninitializeFlatSB) then
        Ac_UninitializeFlatSB(TWinControl(SkinData.FOwnerControl).Handle);

      if (ListSW <> nil) and ListSW.Destroyed then
        FreeAndNil(ListSW);

      if ListSW = nil then
        ListSW := TacScrollWnd.Create(TWinControl(SkinData.FOwnerControl).Handle, SkinData, SkinData.SkinManager, sp);
    end
    else begin
      if ListSW <> nil then
        FreeAndNil(ListSW);

      if Assigned(Ac_InitializeFlatSB) then
        Ac_InitializeFlatSB(TWinControl(SkinData.FOwnerControl).Handle);
    end;
end;


procedure RefreshEditScrolls(SkinData: TsScrollWndData; var ListSW: TacScrollWnd);
var
  sp: TacSkinParams;
begin
  if SkinData.Skinned then begin
    if (ListSW <> nil) and ListSW.Destroyed then
      FreeAndNil(ListSW);

    if ListSW = nil then
      ListSW := TacEditWnd.Create(TWinControl(SkinData.FOwnerControl).Handle, SkinData, SkinData.SkinManager, sp);
  end
  else
    if ListSW <> nil then
      FreeAndNil(ListSW);
end;


procedure RefreshTreeScrolls(SkinData: TsScrollWndData; var ListSW: TacScrollWnd; SkipBGMessage: boolean);
var
  sp: TacSkinParams;
begin
  if SkinData.Skinned then begin
    if (ListSW <> nil) and ListSW.Destroyed then
      FreeAndNil(ListSW);

    if ListSW = nil then
      ListSW := TacTreeViewWnd.Create(TWinControl(SkinData.FOwnerControl).Handle, SkinData, SkinData.SkinManager, sp);

    if SkipBGMessage then
      TacTreeViewWnd(ListSW).SkipBG := SkipBGMessage;
  end
  else
    if ListSW <> nil then
      FreeAndNil(ListSW);
end;


procedure UpdateScrolls(const sw: TacScrollWnd; const Repaint: boolean = False);
begin
  if sw <> nil then
    if IsWindowVisible(sw.CtrlHandle) then
      if (sw.SkinData = nil) or not sw.SkinData.FUpdating then
        if (sw.sbarHorz <> nil) and (sw.sbarVert <> nil) then begin
          sw.sbarHorz.ScrollInfo.cbSize := SizeOf(TScrollInfo);
          sw.sbarHorz.ScrollInfo.fMask := SIF_ALL;
          GetScrollInfo(sw.CtrlHandle, SB_HORZ, {$IFDEF FPC}@sw.sbarHorz.ScrollInfo{$ELSE}sw.sbarHorz.ScrollInfo{$ENDIF});
          sw.sbarVert.ScrollInfo.cbSize := SizeOf(TScrollInfo);
          sw.sbarVert.ScrollInfo.fMask := SIF_ALL;
          GetScrollInfo(sw.CtrlHandle, SB_VERT, {$IFDEF FPC}@sw.sbarVert.ScrollInfo{$ELSE}sw.sbarVert.ScrollInfo{$ENDIF});
          if Repaint and not InAnimationProcess then
            Ac_NCDraw(sw, sw.CtrlHandle);
        end;
end;


procedure SendControlLoaded(Ctrl: hwnd);
var
  pWnd: hwnd;
begin
  pWnd := GetParent(Ctrl);
  if pWnd <> 0 then
    SendControlLoaded(pWnd)
  else
    SendAMessage(Ctrl, AC_CONTROLLOADED, 0);
end;


procedure PrepareCache(SkinData: TsCommonData; CtrlHandle: hwnd = 0; DlgMode: boolean = False);
var
  DC: hdc;
  P: TPoint;
  pc: acChar;
  s: acString;
  pHwnd: hwnd;
  ci: TCacheInfo;
  R, rCtrl: TRect;
  Flags: Cardinal;
  BGInfo: TacBGInfo;
  dk: TsDisabledKind;
  i, iSingle, BordWidth: integer;
begin
  if (SkinData <> nil) and SkinData.BGChanged then begin
    if CtrlHandle = 0 then
      Exit;

    GetWindowRect(CtrlHandle, rCtrl);
    InitCacheBmp(SkinData);
    pHwnd := GetParent(CtrlHandle);
    if pHwnd <> 0 then begin
      BGInfo.PleaseDraw := False;
      GetBGInfo(@BGInfo, pHwnd);
      if BGInfo.BgType = btNotReady then begin
        SkinData.Updating := True;
        Exit;
      end;
      BGInfo.FillRect := MkRect;
      CI := BGInfoToCI(@BGInfo);
    end
    else
      CI := EmptyCI;

    SkinData.FCacheBmp.Width := WidthOf(rCtrl);
    SkinData.FCacheBmp.Height := HeightOf(rCtrl);
    if DlgMode and (DefaultManager.Palette[pcBorder] <> clFuchsia) then begin
      FillDC(SkinData.FCacheBmp.Canvas.Handle, MkRect(SkinData.FCacheBmp), ColorToRGB(clWindow));
      SkinData.FCacheBmp.Canvas.Brush.Color := DefaultManager.Palette[pcBorder];
      SkinData.FCacheBmp.Canvas.FrameRect(MkRect(SkinData.FCacheBmp));
    end
    else begin
      pHwnd := GetParent(CtrlHandle);
      if pHwnd = 0 then
        Exit;

      P := rCtrl.TopLeft;
      if not ScreenToClient(pHwnd, P) then
        Exit;

      if (Application.BiDiMode = bdRightToLeft) and (CI.Bmp <> nil) then begin
        DC := GetDC(GetParent(CtrlHandle));
        if acGetLayout(DC) <> 0 then begin
          p.X := CI.Bmp.Width - p.X; // Inversion of control coords if canvas is mirrored
          if Assigned(SkinData.SkinManager) and SkinData.SkinManager.ExtendedBorders then
            dec(p.X, 2 * ci.X);
        end;
      end;

      if Assigned(SkinData.SkinManager) and SkinData.SkinManager.IsValidSkinIndex(SkinData.SkinIndex) then
        if (SkinData.FOwnerControl is TCustomListBox) and (TListBox(SkinData.FOwnerControl).BorderStyle = bsNone) then
          PaintItemBG(SkinData, CI, integer(SkinData.FFocused or (SkinData.FMouseAbove) and MayBeHot(SkinData)), MkRect(SkinData.FCacheBmp), p, SkinData.FCacheBmp)
        else
          PaintItem(SkinData, CI, True, integer(SkinData.FFocused or (SkinData.FMouseAbove) and MayBeHot(SkinData)), MkRect(SkinData.FCacheBmp), p, SkinData.FCacheBmp, not DlgMode);
    end;
    if (SkinData.FOwnerControl <> nil) and not IsWindowEnabled(CtrlHandle) then
{$IFDEF TNTUNICODE}
      if (SkinData.FOwnerControl is TTntEdit) then with TTntEdit(SkinData.FOwnerControl) do
{$ELSE}
      if (SkinData.FOwnerControl is TCustomEdit) then with TEdit(SkinData.FOwnerControl) do
{$ENDIF}
      begin
        SkinData.FCacheBMP.Canvas.Font.Assign(Font);
        if BorderStyle <> bsNone then begin
          BordWidth := 1 {$IFNDEF FPC}+ integer(Ctl3D){$ENDIF};
          BordWidth := BordWidth {$IFDEF DELPHI7UP} + integer(BevelKind <> bkNone) * (integer(BevelOuter <> bvNone) + integer(BevelInner <> bvNone)) {$ENDIF};
        end
        else
          BordWidth := 0;

        Flags := DT_TOP or DT_NOPREFIX or DT_SINGLELINE;
        iSingle := integer(BorderStyle = bsSingle);
        R := Rect(BordWidth + iSingle, BordWidth + iSingle, Width - BordWidth - iSingle, Height - BordWidth);
      {$IFNDEF D2009}
        if IsRightToLeft then begin
          Flags := Flags or DT_RTLREADING or DT_RIGHT;
          dec(R.Right);
        end;
      {$ENDIF}
        if Text <> '' then begin
          if PasswordChar <> #0 then begin
      {$IFDEF D2009}
            if PasswordChar = '*' then
              pc := #9679
            else
      {$ENDIF}
              pc := PasswordChar;

            for i := 1 to Length(Text) do
              s := s + pc;
          end
          else
            s := Text;

          acWriteTextEx(SkinData.FCacheBMP.Canvas, PacChar(s), True, R, Flags {$IFDEF D2009}or Cardinal(GetStringFlags(SkinData.FOwnerControl, Alignment)) and not DT_VCENTER{$ENDIF}, SkinData, ControlIsActive(SkinData));
        end
      {$IFDEF D2009}
        else
          if TextHint <> '' then begin
            SkinData.FCacheBMP.Canvas.Brush.Style := bsClear;
            SkinData.FCacheBMP.Canvas.Font.Color := BlendColors(Font.Color, Color, 180);
            acDrawText(SkinData.FCacheBMP.Canvas.Handle, TextHint, R, Flags {$IFDEF D2009}or Cardinal(GetStringFlags(SkinData.FOwnerControl, Alignment)) and not DT_VCENTER{$ENDIF});
          end;
      {$ENDIF}
      end;

    if SkinData.FOwnerControl <> nil then
      if not SkinData.FOwnerControl.Enabled then begin
{$IFNDEF FPC}
        if HasProperty(SkinData.FOwnerControl, acDisabledKind) then begin
          if CheckSetProp(SkinData.FOwnerControl, acDisabledKind, 'dkBlended') then
            dk := [dkBlended]
          else
            dk := [];

          if CheckSetProp(SkinData.FOwnerControl, acDisabledKind, 'dkGrayed') then
            dk := dk + [dkGrayed];
        end
        else
{$ENDIF}
          dk := [dkBlended];

        CI := GetParentCache(SkinData);
        BmpDisabledKind(SkinData.FCacheBmp, dk, SkinData.FOwnerControl.Parent, CI, MkPoint(SkinData.FOwnerControl));
      end;

    SkinData.BGChanged := False;
  end;
end;


procedure Ac_RedrawNonClient(Handle: hwnd; fFrameChanged: boolean);
begin
  if not fFrameChanged then
    TrySendMessage(Handle, WM_NCPAINT, 1, 0)
  else
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);
end;


procedure UninitializeACScroll(Handle: hwnd; FreeSW: boolean; Repaint: boolean; var ListSW: TacScrollWnd);
begin
  if ListSW <> nil then begin
    if not ListSW.Destroyed and (ListSW.SkinData <> nil) and (ListSW.SkinData.FOwnerControl <> nil) then begin
      // restore the window procedure with the original one
      if Assigned(ListSW.OldWndProc) then begin
        ListSW.SkinData.WndProc := ListSW.OldWndProc;
        if ListSW.SkinData.FOwnerObject is TsSkinProvider then
          TsSkinProvider(ListSW.SkinData.FOwnerObject).Form.WindowProc := ListSW.OldWndProc
        else
          TacWinControl(ListSW.SkinData.FOwnerControl).WindowProc := ListSW.OldWndProc;
      end
      else begin
        if DWord(GetWindowLong(Handle, GWL_WNDPROC)) = DWord(ListSW.NewWndProcInstance) then
          SetWindowLong(Handle, GWL_WNDPROC, LONG_PTR(ListSW.oldproc));

        if ListSW.NewWndProcInstance <> nil then begin
          {$IFDEF DELPHI7UP}Classes.{$ENDIF}FreeObjectInstance(ListSW.NewWndProcInstance);
          ListSW.NewWndProcInstance := nil;
        end;
      end;
      ListSW.RestoreStdParams;
      if Assigned(ListSW.sBarHorz) then begin
        ListSW.sBarHorz.sw := nil;
        FreeAndNil(ListSW.sBarHorz);
      end;
      if Assigned(ListSW.sBarVert) then begin
        ListSW.sBarVert.sw := nil;
        FreeAndNil(ListSW.sBarVert);
      end;
      // Force WM_NCCALCSIZE and WM_NCPAINT so the original scrollbars can kick in
      if IsWindowVisible(Handle) then
        Ac_RedrawNonClient(Handle, Repaint);

      if ListSW.OwnSkinData and (ListSW.SkinData <> nil) then begin
        ListSW.SkinData.FOwnerControl := nil;
        ListSW.SkinData.FOwnerObject := nil;
        ListSW.SkinData.FSWHandle := 0;
      end;
      ListSW.Destroyed := True;
    end;

    if FreeSW and (ListSW <> nil) then begin
      if ListSW.OldProc <> nil then begin
        SetWindowLong(ListSW.CtrlHandle, GWL_WNDPROC, LONG_PTR(ListSW.OldProc));
        ListSW.oldproc := nil;
      end;
      ListSW.OldWndProc := nil;
      FreeAndnil(ListSW);
    end;
  end;
end;


function Ac_GetScrollWndFromHwnd(const AHandle: hwnd): TacScrollWnd;
begin
  Result := TacScrollWnd(GetProp(AHandle, acPropStr));
end;


function HookScrollWnd(Handle: hwnd; ASkinManager: TsSkinManager; ASkinData: TsCommonData = nil): TacScrollWnd;
var
  sp: TacSkinParams;
begin
  if Ac_GetScrollWndFromHwnd(Handle) = nil then
    Result := TacScrollWnd.Create(Handle, ASkinData, ASkinManager, sp)
  else
    Result := nil;
end;


function Ac_GetScrollBarFromHwnd(const Handle: hwnd; const nBar: word): TacScrollBar;
var
  sw: TacScrollWnd;
begin
  Result := nil;
  sw := Ac_GetScrollWndFromHwnd(Handle);
  if Assigned(sw) then
    case nBar of
      SB_HORZ: Result := sw.sbarHorz;
      SB_VERT: Result := sw.sbarVert
    end;
end;


function Ac_SetMinThumbSize(const Handle: hwnd; const wBar: word; const Size: word): boolean;
var
  sBar: TacScrollBar;
begin
  Result := False;
  if Ac_GetScrollWndFromHwnd(Handle) <> nil then begin
    if wBar in [SB_HORZ, SB_BOTH] then begin
      sBar := Ac_GetScrollBarFromHwnd(Handle, SB_HORZ);
      if sBar <> nil then
        sBar.nMinThumbSize := Size;
    end;
    if wBar in [SB_VERT, SB_BOTH] then begin
      sBar := Ac_GetScrollBarFromHwnd(Handle, SB_VERT);
      if sBar <> nil then
        sBar.nMinThumbSize := Size;
    end;
    Result := True;
  end;
end;


procedure InitializeACWnd(sw: TacMainWnd; AHandle: hwnd);
begin
  with sw do begin
    DontRepaint := False;
    CtrlHandle := AHandle;
    SetProp(CtrlHandle, acPropStr, Cardinal(sw));
    if (sw.SkinData.FOwnerControl <> nil) or (sw.SkinData.FOwnerObject is TsSkinProvider) then begin
      sw.SkinData.WndProc := acWndProc;
      if sw.SkinData.FOwnerObject is TsSkinProvider then begin
        OldWndProc := TsSkinProvider(sw.SkinData.FOwnerObject).Form.WindowProc;
        TsSkinProvider(sw.SkinData.FOwnerObject).Form.WindowProc := acWndProc;
      end
      else begin
        OldWndProc := TacWinControl(sw.SkinData.FOwnerControl).WindowProc;
        TacWinControl(sw.SkinData.FOwnerControl).WindowProc := acWndProc;
      end
    end
    else begin
      OldProc := Pointer(GetWindowLong(CtrlHandle, GWL_WNDPROC));
      NewWndProcInstance := {$IFDEF DELPHI7UP}Classes.{$ENDIF}MakeObjectInstance(acWndProc);
      SetWindowLong(CtrlHandle, GWL_WNDPROC, LONG_PTR(NewWndProcInstance));
    end;
  end;
end;


procedure InitializeACScrolls(sw: TacScrollWnd; AHandle: hwnd; Repaint: boolean = True);
var
  dwCurStyle: ACNativeInt;
begin
  with sw do begin
    DontRepaint := False;
    CtrlHandle := AHandle;
    sbarHorz := TacScrollBar.Create;
    sbarHorz.sw := sw;
    sbarVert := TacScrollBar.Create;
    sbarVert.sw := sw;

    sbarHorz.ScrollInfo.cbSize := SizeOf(TScrollInfo);
    sbarHorz.ScrollInfo.fMask := SIF_ALL;
    GetScrollInfo(CtrlHandle, SB_HORZ, {$IFDEF FPC}@sbarHorz.ScrollInfo{$ELSE}sbarHorz.ScrollInfo{$ENDIF});

    sbarVert.ScrollInfo.cbSize := SizeOf(TScrollInfo);
    sbarVert.ScrollInfo.fMask := SIF_ALL;
    GetScrollInfo(CtrlHandle, SB_VERT, {$IFDEF FPC}@sbarVert.ScrollInfo{$ELSE}sbarVert.ScrollInfo{$ENDIF});

    fLeftScrollbar := GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_LEFTSCROLLBAR = WS_EX_LEFTSCROLLBAR;
    dwCurStyle := GetWindowLong(CtrlHandle, GWL_STYLE);
    SetProp(CtrlHandle, acPropStr, ACNativeInt(sw));

    if dwCurStyle and WS_HSCROLL <> 0 then
      sw.sBarHorz.fScrollFlags := CSBS_VISIBLE;

    if dwCurStyle and WS_VSCROLL <> 0 then
      sw.sbarVert.fScrollFlags := CSBS_VISIBLE;

    sbarHorz.nBarType := SB_HORZ;
    sbarVert.nBarType := SB_VERT;

    sbarHorz.nArrowLength := SYSTEM_METRIC;
    sbarHorz.nArrowWidth  := SYSTEM_METRIC;
    sbarVert.nArrowLength := SYSTEM_METRIC;
    sbarVert.nArrowWidth  := SYSTEM_METRIC;

    bPreventStyleChange   := False;
    InitializeACWnd(sw, AHandle);
    Ac_SetMinThumbSize(CtrlHandle, SB_BOTH, acMinThumbSize);
    if Ac_GetScrollWndFromHwnd(CtrlHandle) <> nil then begin
      sbarVert := Ac_GetScrollBarFromHwnd(CtrlHandle, SB_VERT);
      sbarHorz := Ac_GetScrollBarFromHwnd(CtrlHandle, SB_HORZ);
      if Repaint then
        Ac_RedrawNonClient(CtrlHandle, True);
    end;
  end;
end;


procedure UninitializeACWnd(Handle: hwnd; FreeSW: boolean; Repaint: boolean; var ListSW: TacMainWnd);
var
  Destroyed: Boolean;
begin
  Destroyed := True;
  if ListSW <> nil then begin
    if not ListSW.Destroyed then begin
      // restore the window procedure with the original one
      if Assigned(ListSW.OldWndProc) then begin
        ListSW.SkinData.WndProc := ListSW.OldWndProc;
        if ListSW.SkinData.FOwnerObject is TsSkinProvider then
          TsSkinProvider(ListSW.SkinData.FOwnerObject).Form.WindowProc := ListSW.OldWndProc
        else
          if ListSW.SkinData.FOwnerControl <> nil then
            TacWinControl(ListSW.SkinData.FOwnerControl).WindowProc := ListSW.OldWndProc;
      end
      else
        if DWord(GetWindowLong(ListSW.CtrlHandle, GWL_WNDPROC)) = DWord(ListSW.NewWndProcInstance) then begin
          SetWindowLong(Handle, GWL_WNDPROC, LONG_PTR(ListSW.oldproc));
          ListSW.oldproc := nil;
          if ListSW.NewWndProcInstance <> nil then begin
            {$IFDEF DELPHI7UP}Classes.{$ENDIF}FreeObjectInstance(ListSW.NewWndProcInstance);
            ListSW.NewWndProcInstance := nil;
          end;
        end
        else
          Destroyed := False;

      ListSW.RestoreStdParams;
      // Force WM_NCCALCSIZE and WM_NCPAINT so the original scrollbars can kick in
      if IsWindowVisible(Handle) then
        Ac_RedrawNonClient(Handle, Repaint);

      if ListSW.OwnSkinData and (ListSW.SkinData <> nil) then
        ListSW.SkinData.ClearLinks;

      ListSW.Destroyed := Destroyed;
    end;
    if FreeSW and (ListSW <> nil) then begin
      ListSW.oldproc := nil;
      ListSW.OldWndProc := nil;
      FreeAndnil(ListSW);
    end;
  end;
end;


function Ac_GetScrollInfoFromHwnd(Handle: hwnd; fnBar: integer): TScrollInfo;
var
  sb: TacScrollBar;
begin
  Result.cbSize := 0;
  sb := Ac_GetScrollBarFromHwnd(Handle, fnBar);
  if sb <> nil then
    if fnBar = SB_HORZ then
      Result := sb.scrollInfo
    else
      if fnBar = SB_VERT then
        Result := sb.scrollInfo
      else
        Result.cbSize := 0;
end;


function Ac_ShowScrollBar(Handle: hwnd; wBar: integer; fShow: boolean): boolean;
var
  sbar: TacScrollBar;
  bFailed: boolean;
  dwStyle: ACNativeInt;
begin
  bFailed := FALSE;
  dwStyle := GetWindowLong(Handle, GWL_STYLE);
  if Ac_GetScrollWndFromHwnd(Handle) = nil then
    Result := ShowScrollBar(Handle, wBar, fShow)
  else begin
    if wBar in [SB_HORZ, SB_BOTH] then begin
      sbar := Ac_GetScrollBarFromHwnd(Handle, SB_HORZ);
      if sbar <> nil then begin
        sbar.fScrollFlags := sbar.fScrollFlags and not CSBS_VISIBLE;
        sbar.fScrollFlags := sbar.fScrollFlags or (integer(fShow) * CSBS_VISIBLE);
        if fShow then
          SetWindowLong(Handle, GWL_STYLE, dwStyle or WS_HSCROLL)
        else
          SetWindowLong(Handle, GWL_STYLE, dwStyle and not WS_HSCROLL);
      end;
    end;
    if wBar in [SB_VERT, SB_BOTH] then begin
      sbar := Ac_GetScrollBarFromHwnd(Handle, SB_VERT);
      if sbar <> nil then begin
        sbar.fScrollFlags := sbar.fScrollFlags and not CSBS_VISIBLE;
        sbar.fScrollFlags := sbar.fScrollFlags or (integer(fShow) * CSBS_VISIBLE);
        if fShow then
          SetWindowLong(Handle, GWL_STYLE, dwStyle or WS_VSCROLL)
        else
          SetWindowLong(Handle, GWL_STYLE, dwStyle and not WS_VSCROLL);
      end;
    end;
    if bFailed then
      Result := False
    else begin
      SetWindowPos(Handle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);
      Result := True;
    end;
  end;
end;


function Ac_IsThumbTracking(Handle: hwnd): boolean;
var
  sw: TacScrollWnd;
begin
  sw := Ac_GetScrollWndFromHwnd(Handle);
  if sw = nil then
    Result := FALSE
  else
    Result := sw.fThumbTracking;
end;


function GetScrollMetric(sBar: TacScrollBar; metric: integer; Btn: boolean = False): integer;
begin
  Result := 0;
  if sbar <> nil then
    with sbar.sw.SkinManager do
      if sBar.nBarType = SB_HORZ then begin
        if metric = SM_BTNSIZE then begin // Size of button
          if TsScrollWndData(sBar.sw.SkinData).HorzScrollData.ButtonsSize >= 0 then
            Result := TsScrollWndData(sBar.sw.SkinData).HorzScrollData.ButtonsSize
          else
            if ScrollsOptions.ButtonsSize >= 0 then
              Result := ScrollsOptions.ButtonsSize
            else
              if sBar.nArrowLength >= 0 then
                Result := sBar.nArrowLength
              else
                with ConstData.ScrollBtns[asLeft] do begin
                  Result := GetScrollSize(sBar.sw.SkinManager);
                  if Result < 0 then
                    Result := -sBar.nArrowLength * acScrollBtnLength
                end;
        end
        else // Height of scrolllbar
          if TsScrollWndData(sBar.sw.SkinData).HorzScrollData.ScrollWidth >= 0 then
            Result := TsScrollWndData(sBar.sw.SkinData).HorzScrollData.ScrollWidth
          else begin
            Result := GetScrollSize(sBar.sw.SkinManager);
            if Result < 0 then
              if sBar.nArrowWidth < 0 then
                Result := -sBar.nArrowWidth * GetSystemMetrics(SM_CYHSCROLL)
              else
                Result := sBar.nArrowWidth;
          end;
      end
      else
        if metric = SM_BTNSIZE then begin // Size of button
          if TsScrollWndData(sBar.sw.SkinData).VertScrollData.ButtonsSize >= 0 then
            Result := TsScrollWndData(sBar.sw.SkinData).VertScrollData.ButtonsSize
          else
            if ScrollsOptions.ButtonsSize >= 0 then
              Result := ScrollsOptions.ButtonsSize
            else
              if sBar.nArrowLength >= 0 then
                Result := sBar.nArrowLength
              else
                with ConstData.ScrollBtns[asTop] do begin
                  Result := GetScrollSize(sBar.sw.SkinManager);
                  if Result < 0 then
                    Result := -sBar.nArrowLength * acScrollBtnLength
                end;
        end
        else // Height of scrolllbar
          if TsScrollWndData(sBar.sw.SkinData).VertScrollData.ScrollWidth >= 0 then
            Result := TsScrollWndData(sBar.sw.SkinData).VertScrollData.ScrollWidth
          else begin
            Result := GetScrollSize(sBar.sw.SkinManager);
            if Result < 0 then
              if sBar.nArrowWidth < 0 then
                Result := -sBar.nArrowWidth * GetSystemMetrics(SM_CXVSCROLL)
              else
                Result := sBar.nArrowWidth;
          end;
end;


procedure AC_GetHScrollRect(sw: TacScrollWnd; Handle: hwnd; var R: TRect);
begin
  GetWindowRect(Handle, R);
  if sw.fLeftScrollbar then begin
    inc(R.Left, sw.cxLeftEdge + integer(sw.sbarVert.fScrollVisible) * (GetScrollMetric(sw.sbarVert, SM_SCROLLWIDTH)));
    dec(R.Right, sw.cxRightEdge);
  end
  else begin
    inc(R.Left, sw.cxLeftEdge);
    dec(R.Right,sw.cxRightEdge + integer(sw.sbarVert.fScrollVisible) * (GetScrollMetric(sw.sbarVert, SM_SCROLLWIDTH)));
  end;
  dec(R.Bottom, sw.cyBottomEdge);
  R.Top	:= R.Bottom - integer(sw.sbarHorz.fScrollVisible) * GetScrollMetric(sw.sbarHorz, SM_SCROLLWIDTH);
end;


procedure AC_GetVScrollRect(sw: TacScrollWnd; Handle: hwnd; var R: TRect);
begin
  GetWindowRect(Handle, R);
  inc(R.Top, sw.cyTopEdge);
  dec(R.Bottom, sw.cyBottomEdge + integer(sw.sbarHorz.fScrollVisible) * (GetScrollMetric(sw.sbarHorz, SM_SCROLLWIDTH)));
  if sw.fLeftScrollbar then begin
    inc(R.Left, sw.cxLeftEdge);
    R.Right := R.Left + integer(sw.sbarVert.fScrollVisible) * GetScrollMetric(sw.sbarVert, SM_SCROLLWIDTH);
  end
  else begin
    dec(R.Right, sw.cxRightEdge);
    R.Left := R.Right - integer(sw.sbarVert.fScrollVisible) * GetScrollMetric(sw.sbarVert, SM_SCROLLWIDTH);
  end;
end;


function Ac_GripVisible(sw: TacScrollWnd; Handle: THandle; R: TRect): boolean;
var
  parRect: TRect;
  parHandle: hwnd;
begin
  Result := False;
  parHandle := GetParent(Handle);
  if GetParent(parHandle) = 0 then begin
    GetClientRect(parHandle, parRect);
    MapWindowPoints(parHandle, 0, parRect, 2);
    Result := (parHandle = 0) or
              (not sw.fLeftScrollbar and (parRect.right = R.right + sw.cxRightEdge) and (parRect.bottom = R.bottom + sw.cyBottomEdge))
               or (sw.fLeftScrollbar and (parRect.left  = R.left  - sw.cxLeftEdge)  and (parRect.bottom = R.bottom + sw.cyBottomEdge))
  end;
end;


function Ac_IsScrollInfoActive(const si: TScrollInfo): boolean;
begin
  if (si.nPage > UINT(si.nMax)) or (si.nMax <= si.nMin) or (si.nMax = 0) then
    Result := False
  else
    Result := True;
end;


function Ac_IsScrollbarActive(const sb: TacScrollBar): boolean;
var
  sbi: TScrollBarInfo;
  idObject: Int64;
begin
  sbi.cbSize := SizeOf(sbi);
  case sb.nBarType of
    SB_HORZ: idObject := OBJID_HSCROLL;
    SB_VERT: idObject := OBJID_VSCROLL
    else     idObject := OBJID_CLIENT;
  end;
  if Assigned(Ac_GetScrollBarInfo) then
    if not Ac_GetScrollBarInfo(sb.sw.CtrlHandle, longint(idObject), sbi) then
      Result := False
    else
      if ((sb.fScrollFlags and ESB_DISABLE_BOTH = ESB_DISABLE_BOTH) or
              (sb.fScrollFlags and CSBS_THUMBALWAYS <> 0) and not Ac_IsScrollInfoActive(sb.scrollInfo)) or
                  (sbi.rgstate[0] and STATE_SYSTEM_UNAVAILABLE <> 0) then
        Result := False
      else
        Result := True
  else // Win95
    if sb.nBarType = SB_VERT then
      Result := (GetWindowLong(sb.sw.CtrlHandle, GWL_STYLE) and WS_VSCROLL <> 0)
    else
      Result := (GetWindowLong(sb.sw.CtrlHandle, GWL_STYLE) and WS_HSCROLL <> 0);
end;


function Ac_CalcThumbSize(const sb: TacScrollBar; const R: TRect; var pthumbsize: integer; var pthumbpos: integer): integer;
var
  scrollsize, workingsize, siMaxMin, butsize, startcoord, thumbpos, thumbsize: integer;
begin
  thumbpos  := 0;
  thumbsize := 0;
  butsize := GetScrollMetric(sb, SM_SCROLL_LENGTH);
  if sb.nBarType = SB_HORZ then begin
    scrollsize := R.right - R.left;
    startcoord := R.left;
  end
  else begin
    scrollsize := R.Bottom - R.Top;
    startcoord := R.Top;
  end;
  siMaxMin := sb.scrollInfo.nMax - sb.scrollInfo.nMin + 1;
  workingsize := scrollsize - butsize * 2;
  if sb.scrollInfo.nPage = 0 then
    thumbsize := max(butsize, sb.nMinThumbSize)
  else
    if siMaxMin > 0 then
      thumbsize := MulDiv(integer(sb.scrollInfo.nPage), workingsize, siMaxMin);

  if (butsize = 0) and (thumbsize < 19) then
    thumbsize := 19
  else
    if thumbsize < sb.nMinThumbSize then
      thumbsize := sb.nMinThumbSize;

  if siMaxMin > 0 then begin
    if sb.scrollInfo.nPos <> 0 then
      sb.scrollInfo.nPos := sb.scrollInfo.nPos;

    thumbpos := MulDiv(sb.scrollInfo.nPos - sb.scrollInfo.nMin, workingsize - thumbsize, siMaxMin - max(1, integer(sb.scrollInfo.nPage)));
    if thumbpos < 0 then
      thumbpos := 0;

    if thumbpos >= workingsize - thumbsize then
      thumbpos := workingsize - thumbsize;
  end;
  inc(thumbpos, startcoord + butsize);
  pthumbpos := thumbpos;
  pthumbsize := thumbsize;
  Result := 1;
end;


procedure DrawCenterGlyph(b: TBitmap; Ndx: integer; State: integer; sm: TsSkinManager; R: TRect);
var
  p: TPoint;
  w, h: integer;
begin
  with sm do
    if IsValidImgIndex(Ndx) then begin
      w := ma[Ndx].Width;
      h := ma[Ndx].Height;
      p.x := R.Left + (WidthOf(R) - w) div 2;
      p.y := R.Top + (HeightOf(R) - h) div 2;
      DrawSkinGlyph(b, p, State, 1, ma[Ndx], MakeCacheInfo(b));
    end;
end;


procedure ac_DrawScrollBtn(bRect: TRect; State: integer; Bmp: TBitmap; cd: TsCommonData; Side: TacSide);
var
  C: TColor;
  b: TBitmap;
  ci: TCacheInfo;
  dRect, gRect: TRect;
begin
  if not IsRectEmpty(bRect) then begin
    dRect := BtnDrawRect(bRect, cd, Side);
    b := CreateBmp32(dRect);
    with cd.SkinManager.ConstData.ScrollBtns[Side] do begin
      Ci := MakeCacheInfo(Bmp);
      PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1], Ci, True, State, MkRect(b), dRect.TopLeft, b, cd.SkinManager);
      if bRect.Top <> dRect.Top then
        gRect.Top := bRect.Top - dRect.Top
      else
        gRect.Top := 0;

      if bRect.Left <> dRect.Left then
        gRect.Left := bRect.Left - dRect.Left
      else
        gRect.Left := 0;

      gRect.Bottom := gRect.Top + HeightOf(bRect);
      gRect.Right := gRect.Left + WidthOf(bRect);

      if GlyphIndex >= 0 then
        DrawCenterGlyph(b, GlyphIndex, State, cd.SkinManager, gRect)
      else begin
        C := cd.SkinManager.gd[SkinIndex].Props[min(State, ac_MaxPropsIndex)].FontColor.Color;
        if Side in [asLeft, asRight] then
          OffsetRect(gRect, 0, -1);

        if (State > 1) and cd.SkinManager.ButtonsOptions.ShiftContentOnClick then
          OffsetRect(gRect, 1, 1);

        DrawColorArrow(b, C, gRect, Side);
      end;
    end;
    BitBlt(Bmp.Canvas.Handle, dRect.Left, dRect.Top, b.Width, b.Height, b.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(b);
  end;
end;


procedure ac_DrawSlider(bRect: TRect; State: integer; Bmp: TBitmap; sm: TsSkinManager; Vert: boolean);
var
  b: TBitmap;
  ci: TCacheInfo;
begin
  b := CreateBmp32(bRect);
  with sm.ConstData.Sliders[Vert] do begin
    Ci := MakeCacheInfo(Bmp, bRect.Left, bRect.Top);
    PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1], Ci, True, State, MkRect(b), MkPoint, b, sm);
    DrawCenterGlyph(b, GlyphIndex, State, sm, MkRect(b));
  end;
  BitBlt(Bmp.Canvas.Handle, bRect.Left, bRect.Top, b.Width, b.Height, b.Canvas.Handle, 0, 0, SRCCOPY);
  FreeAndNil(b);
end;


function Ac_NCDrawHScrollbar(sb: TacScrollBar; Handle: hwnd; DC: hdc; R: TRect; uDrawFlags: integer; SliderPos: integer = -1): LRESULT;
var
  c: TsColor;
  Bmp: TBitmap;
  BG: TacBGInfo;
  CI: TCacheInfo;
  sm: TsSkinManager;
  ctrl, thumb: TRect;
  IsEnabled, fMouseOverL, fBarHot, fMouseOverR: boolean;
  lbState, rbState, tdiv2, butwidth, scrollwidth, workingwidth, thumbwidth, realthumbsize, thumbpos: integer;
begin
  Result := 0;
  if not sb.sw.fThumbTracking then begin
    sm := sb.sw.SkinManager;
    if not sb.fScrollVisible or (sm = nil) or not sm.IsValidSkinIndex(sm.ConstData.Scrolls[asLeft].SkinIndex) or (WidthOf(R) < 2) then
      Exit;
    
    GetScrollInfo(sb.sw.CtrlHandle, sb.nBarType, {$IFDEF FPC}@sb.ScrollInfo{$ELSE}sb.ScrollInfo{$ENDIF});
    butwidth := GetScrollMetric(sb, SM_SCROLL_LENGTH, True);
    scrollwidth := R.right - R.left;
    if scrollwidth <= 0 then
      Exit;

    Result := 1;
    workingwidth := scrollwidth - butwidth * 2;
    GetScrollMetric(sb, SM_SCROLL_LENGTH);
    thumbwidth := 0;
    thumbpos := 0;
    if sb.sw.SkinData.FOwnerControl <> nil then
      IsEnabled := Ac_IsScrollbarActive(sb) and sb.sw.SkinData.FOwnerControl.Enabled
    else
      IsEnabled := Ac_IsScrollbarActive(sb);

    fBarHot := sb.nBarType = uMouseOverScrollbar;
    fMouseOverL := (uHitTestPortion = HTSCROLL_LEFT)  and fBarHot and IsEnabled and (Handle = hwndCurSB);
    fMouseOverR := (uHitTestPortion = HTSCROLL_RIGHT) and fBarHot and IsEnabled and (Handle = hwndCurSB);
    if Handle <> hwndCurSB then
      uDrawFlags := HTSCROLL_NONE;

    Ac_CalcThumbSize(sb, R, thumbwidth, thumbpos);
    if SliderPos <> -1 then
      thumbpos := SliderPos;

    if Handle = hwndCurSB then begin
      if uDrawFlags = HTSCROLL_LEFT then
        lbState := 2
      else
        lbState := integer(fMouseOverL);

      if uDrawFlags = HTSCROLL_RIGHT then
        rbState := 2
      else
        rbState := integer(fMouseOverR)
    end
    else begin
      lbState := 0;
      rbState := 0
    end;
    // Draw the scrollbar now //
    Bmp := CreateBmp32(R);
    BG.PleaseDraw := False;
    GetBGInfo(@BG, Handle);
    if sb.sw is TacMdiWnd then begin
      GetWindowRect(TacMdiWnd(sb.sw).FForm.ClientHandle, thumb);
      GetWindowRect(TacMdiWnd(sb.sw).FForm.Handle, ctrl);
      BG.Offset.X := thumb.Left - ctrl.Left;
      BG.Offset.Y := thumb.Top - ctrl.top;
    end
    else
      if sb.sw.SkinData.FOwnerObject is TsSkinProvider then
        if TsSkinProvider(sb.sw.SkinData.FOwnerObject).BorderForm = nil then
          BG.Offset := MkPoint
        else
          BG.Offset := Point(DiffBorder(TsSkinProvider(sb.sw.SkinData.FOwnerObject).BorderForm) + sb.sw.SkinData.SkinManager.FormShadowSize.Left,
                             DiffTitle (TsSkinProvider(sb.sw.SkinData.FOwnerObject).BorderForm) + sb.sw.SkinData.SkinManager.FormShadowSize.Top);

    CI := BGInfoToCI(@BG);
    if scrollwidth > butwidth * 2 then begin
      tdiv2 := thumbpos + thumbwidth div 2 - R.Left;
      with sm.ConstData.Scrolls[asLeft] do
        PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                      CI, True, integer(uDrawFlags = HTSCROLL_PAGELEFT) * 2, MkRect(tdiv2, Bmp.Height),
                      Point(R.Left - sb.sw.cxLeftEdge, R.Top - sb.sw.cyTopEdge), Bmp, sm);
      with sm.ConstData.Scrolls[asRight] do
        PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                      CI, True, integer(uDrawFlags = HTSCROLL_PAGERIGHT) * 2, Rect(tdiv2, 0, Bmp.Width, Bmp.Height),
                      Point(R.Left + tdiv2 - sb.sw.cxLeftEdge, R.Top - sb.sw.cyTopEdge), Bmp, sm);
      // LEFT ARROW
      SetRect(ctrl, R.left, R.top, R.left + butwidth, R.bottom);
      ac_DrawScrollBtn(MkRect(WidthOf(Ctrl), HeightOf(Ctrl)), lbState, Bmp, sb.sw.SkinData, asLeft);
      // RIGHT ARROW
      SetRect(ctrl, R.right - butwidth, R.top, R.right, R.bottom);
      OffsetRect(ctrl, -R.Left, -R.Top);
      ac_DrawScrollBtn(ctrl, rbState, Bmp, sb.sw.SkinData, asRight);
      // MIDDLE PORTION
      // Getting real values
      realthumbsize := MulDiv(integer(sb.scrollInfo.nPage), scrollwidth - 2 * butwidth, sb.scrollInfo.nMax - sb.scrollInfo.nMin);
      if (realthumbsize < sb.nMinThumbSize) or (realthumbsize < workingWidth - 1) then
        realthumbsize := min(sb.nMinThumbSize, workingWidth - 1);

      if IsEnabled and (realthumbsize > 0) and (realthumbsize <= workingWidth) then begin
        // Draw the THUMB finally
        SetRect(thumb, thumbpos, R.top, thumbpos + thumbwidth, R.bottom);
        OffsetRect(thumb, -R.Left, -R.Top);
        ac_DrawSlider(thumb, integer((uHitTestPortion = HTSCROLL_THUMB) and fBarHot and IsEnabled and (Handle = hwndCurSB)), Bmp, sm, False);
      end;
    end
    // not enough room for the scrollbar, so just draw the buttons (scaled in size to fit)
    else begin
      butWidth := Bmp.width div 2;
      with sm.ConstData.Scrolls[asLeft] do
        PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1], CI, True, 0, MkRect(butWidth, Bmp.Height), MkPoint, Bmp, sm);
      with sm.ConstData.Scrolls[asRight] do
        PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1], CI, True, 0, Rect(butWidth, 0, Bmp.Width, Bmp.Height), MkPoint, Bmp, sm);

      ac_DrawScrollBtn(MkRect(butWidth, Bmp.Height), lbState, Bmp, sb.sw.SkinData, asLeft);
      ac_DrawScrollBtn(Rect(butWidth, 0, Bmp.Width, Bmp.Height), rbState, Bmp, sb.sw.SkinData, asRight);
    end;
    if not IsEnabled then begin
      BG.PleaseDraw := False;
      GetBGInfo(@BG, Handle);
      CI := BGInfoToCI(@BG);
      if sb.sw.SkinData.FOwnerObject is TsSkinProvider then begin
        CI.X := 0;
        CI.Y := 0;
      end;
      if CI.Ready then
        BlendTransRectangle(Bmp, 0, 0, CI.Bmp, R, DefBlendDisabled)
      else begin
        c.C := CI.FillColor;
        FadeBmp(bmp, MkRect(bmp.Width + 1, bmp.Height + 1), 60, c, 0, 0);
      end;
    end;
    BitBlt(DC, R.Left, R.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(Bmp);
  end;
end;


function Ac_NCDrawVScrollbar(sb: TacScrollBar; Handle: hwnd; DC: hdc; R: TRect; uDrawFlags: integer; SliderPos: integer = -1): LRESULT;
var
  lbState, rbState, tdiv2, butheight, scrollHeight, workingHeight, thumbHeight, realthumbsize, thumbpos: integer;
  IsEnabled, fMouseOverT, fBarHot, fMouseOverB: boolean;
  ctrl, thumb: TRect;
  sm: TsSkinManager;
  CI: TCacheInfo;
  BG: TacBGInfo;
  Bmp: TBitmap;
  c: TsColor;
begin
  Result := 0;
  if not sb.sw.fThumbTracking and not sb.sw.DontRepaint then begin
    sm := sb.sw.SkinManager;
    if not sb.fScrollVisible or (sm = nil) or not sm.IsValidSkinIndex(sm.ConstData.Scrolls[asTop].SkinIndex) or (HeightOf(R) < 2) then
      Exit;

    GetScrollInfo(sb.sw.CtrlHandle, sb.nBarType, {$IFDEF FPC}@sb.ScrollInfo{$ELSE}sb.ScrollInfo{$ENDIF});
    butheight := GetScrollMetric(sb, SM_SCROLL_LENGTH, True);
    scrollHeight := R.Bottom - R.Top;
    if scrollHeight > 0 then begin
      Result := 1;
      workingHeight := scrollHeight - butheight * 2;
      thumbHeight := 0;
      thumbpos := 0;
      if sb.sw.SkinData.FOwnerControl <> nil then
        IsEnabled := Ac_IsScrollbarActive(sb) and sb.sw.SkinData.FOwnerControl.Enabled
      else
        IsEnabled := Ac_IsScrollbarActive(sb);

      fBarHot := sb.nBarType = uMouseOverScrollbar;
      if Handle = hwndCurSB then begin
        fMouseOverT := (uHitTestPortion = HTSCROLL_UP)   and fBarHot and IsEnabled and (Handle = hwndCurSB);
        fMouseOverB := (uHitTestPortion = HTSCROLL_DOWN) and fBarHot and IsEnabled and (Handle = hwndCurSB);
      end
      else begin
        fMouseOverT := False;
        fMouseOverB := False;
      end;
      if Handle <> hwndCurSB then
        uDrawFlags := HTSCROLL_NONE;

      Ac_CalcThumbSize(sb, R, thumbHeight, thumbpos);
      if SliderPos <> -1 then
        thumbpos := SliderPos;

      if Handle = hwndCurSB then begin
        if uDrawFlags = HTSCROLL_UP then
          lbState := 2
        else
          lbState := integer(fMouseOverT);

        if uDrawFlags = HTSCROLL_DOWN then
          rbState := 2
        else
          rbState := integer(fMouseOverB);
      end
      else begin
        lbState := 0;
        rbState := 0
      end;
      // Draw the scrollbar now
      Bmp := CreateBmp32(R);
      BG.PleaseDraw := False;
      GetBGInfo(@BG, Handle);
      if sb.sw is TacMdiWnd then begin
        GetWindowRect(TacMdiWnd(sb.sw).FForm.ClientHandle, thumb);
        GetWindowRect(TacMdiWnd(sb.sw).FForm.Handle, ctrl);
        BG.Offset.X := thumb.Left - ctrl.Left;
        BG.Offset.Y := thumb.Top  - ctrl.top;
      end
      else
        if sb.sw.SkinData.FOwnerObject is TsSkinProvider then
          if TsSkinProvider(sb.sw.SkinData.FOwnerObject).BorderForm = nil then
            BG.Offset := MkPoint
          else
            BG.Offset := Point(DiffBorder(TsSkinProvider(sb.sw.SkinData.FOwnerObject).BorderForm) + sb.sw.SkinData.SkinManager.FormShadowSize.Left, DiffTitle(TsSkinProvider(sb.sw.SkinData.FOwnerObject).BorderForm) + sb.sw.SkinData.SkinManager.FormShadowSize.Top);

      CI := BGInfoToCI(@BG);
      if scrollHeight > butheight * 2 then begin
        tdiv2 := thumbpos + thumbHeight div 2 - R.Top;
        with sm.ConstData.Scrolls[asTop] do
          PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                        CI, True, integer(uDrawFlags = HTSCROLL_PAGEUP) * 2, MkRect(Bmp.Width, tdiv2),
                        Point(R.Left - sb.sw.cxLeftEdge, R.Top - sb.sw.cyTopEdge), Bmp, sm);
        with sm.ConstData.Scrolls[asBottom] do
          PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                        CI, True, integer(uDrawFlags = HTSCROLL_PAGEDOWN) * 2, Rect(0, tdiv2, Bmp.Width, Bmp.Height),
                        Point(R.Left - sb.sw.cxLeftEdge, R.Top + tdiv2 - sb.sw.cyTopEdge), Bmp, sm);
        // TOP ARROW
        SetRect(ctrl, R.left, R.top, R.Right, R.Top + butheight);
        OffsetRect(ctrl, -R.Left, -R.Top);
        ac_DrawScrollBtn(Ctrl, lbState, Bmp, sb.sw.SkinData, asTop);
        // Bottom ARROW
        SetRect(ctrl, R.Left, R.Bottom - butheight, R.Right, R.bottom);
        OffsetRect(ctrl, -R.Left, -R.Top);
        ac_DrawScrollBtn(ctrl, rbState, Bmp, sb.sw.SkinData, asBottom);
        //MIDDLE PORTION
        // Getting real values
        realthumbsize := MulDiv(integer(sb.scrollInfo.nPage), scrollheight - 2 * butheight, sb.scrollInfo.nMax - sb.scrollInfo.nMin);
        if (realthumbsize < sb.nMinThumbSize) or (realthumbsize < workingHeight - 1) then
          realthumbsize := min(sb.nMinThumbSize, workingHeight - 1);

        if IsEnabled and (thumbHeight > 0) and (realthumbsize <= workingHeight) then begin
          //Draw the THUMB finally
          SetRect(thumb, R.Left, thumbpos, R.Right, thumbpos + thumbHeight);
          OffsetRect(thumb, -R.Left, -R.Top);
          ac_DrawSlider(thumb, integer((uHitTestPortion = HTSCROLL_THUMB) and fBarHot and IsEnabled and (Handle = hwndCurSB)), Bmp, sm, True);
        end;
      end
      //not enough room for the scrollbar, so just draw the buttons (scaled in size to fit)
      else begin
        butheight := Bmp.Height div 2;
        with sm.ConstData.Scrolls[asTop] do
          PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                        CI, True, 0, MkRect(Bmp.Width, butHeight), R.TopLeft, Bmp, sm);

        with sm.ConstData.Scrolls[asBottom] do
          PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1], CI, True, 0, Rect(0, butHeight, Bmp.Width, Bmp.Height), Point(R.Left, ButHeight), Bmp, sm);

        ac_DrawScrollBtn(MkRect(Bmp.Width, butheight), lbState, Bmp, sb.sw.SkinData, asTop);
        ac_DrawScrollBtn(Rect(0, Bmp.Height - butheight, Bmp.Width, Bmp.Height), rbState, Bmp, sb.sw.SkinData, asBottom);
      end;
      if not IsEnabled then begin
        BG.PleaseDraw := False;
        GetBGInfo(@BG, Handle);
        CI := BGInfoToCI(@BG);
        if sb.sw.SkinData.FOwnerObject is TsSkinProvider then begin
          CI.X := 0;
          CI.Y := 0;
        end;
        if CI.Ready then
          BlendTransRectangle(Bmp, 0, 0, CI.Bmp, R, DefBlendDisabled)
        else begin
          c.C := CI.FillColor;
          FadeBmp(bmp, MkRect(bmp.Width + 1, bmp.Height + 1), 60, c, 0, 0);
        end;
      end;
      BitBlt(DC, R.Left, R.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
      FreeAndNil(Bmp);
    end;
  end;
end;


function Ac_NCDraw(sw: TacScrollWnd; Handle: hwnd; ThumbPos: integer = -1; aDC: hdc = 0): LRESULT;
var
  DC: hdc;
  bGrip: TBitmap;
  parHandle: hwnd;
  sb: TacScrollBar;
  BGInfo: TacBGInfo;
  LeftRight: integer;
  WinRect, R, parRect, R2: TRect;
begin
  Result := 0;
  if sw <> nil then begin
    if sw.SkinData <> nil then
      with sw.SkinData do begin
        if InUpdating(sw.SkinData) then
          Exit;

        if Assigned(FOwnerControl) and ((csCreating in FOwnerControl.ControlState) or not (IsWindowVisible(sw.CtrlHandle) or TWinControl(FOwnerControl).Showing)) then
          Exit;

        if sw.SkinData.BGChanged then
          SendAMessage(sw.CtrlHandle, AC_PREPARECACHE);
      end;

    GetWindowRect(Handle, WinRect);
    if aDC = 0 then
      DC := GetWindowDC(Handle)
    else
      DC := aDC;

    sb := sw.sBarHorz;
    if sb <> nil then begin
      if sb.fScrollVisible then begin
        AC_GetHScrollRect(sw, Handle, R);
        OffsetRect(R, -WinRect.Left, -WinRect.Top);
        Ac_NCDrawHScrollbar(sb, Handle, dc, R, iff(uCurrentScrollbar = SB_HORZ, uScrollTimerPortion, HTSCROLL_NONE), ThumbPos);
      end;
      sb := sw.sBarVert;
      if sb <> nil then begin
        if sb.fScrollVisible then begin
          AC_GetVScrollRect(sw, Handle, R);
          OffsetRect(R, -WinRect.Left, -WinRect.Top);
          Ac_NCDrawVScrollbar(sb, Handle, dc, R, iff(uCurrentScrollbar = SB_VERT, uScrollTimerPortion, HTSCROLL_NONE), ThumbPos);
        end;
        if sw.sbarHorz.fScrollVisible and sw.sbarVert.fScrollVisible then begin
          GetWindowRect(Handle, R);
          OffsetRect(R, -winrect.left, -winrect.top);
          dec(R.bottom, sw.cyBottomEdge);
          R.top := R.bottom - GetScrollMetric(sw.sbarHorz, SM_SCROLLWIDTH);
          if sw.fLeftScrollbar then begin
            inc(R.left, sw.cxLeftEdge);
            R.right := R.left + GetScrollMetric(sw.sbarVert, SM_SCROLLWIDTH);
          end
          else begin
            dec(R.right, sw.cxRightEdge);
            R.left := R.right  - GetScrollMetric(sw.sbarVert, SM_SCROLLWIDTH);
          end;
          // Paint dead zone
          Windows.CopyRect(R2, R);
          parHandle := GetParent(Handle);
          GetClientRect(parHandle, parRect);
          MapWindowPoints(parHandle, 0, parRect, 2);
          OffsetRect(R2, winrect.left, winrect.top);
          // Paint BG
          BGInfo.PleaseDraw := False;
          GetBGInfo(@BGInfo, Handle);
          bGrip := CreateBmp32(R);
          // If scrolls are not transparent
          with sw.SkinManager, ConstData.Scrolls[asLeft] do
            if (SkinIndex >= 0) and (gd[SkinIndex].Props[0].Transparency <> 100) then begin
              if gd[SkinIndex].Props[0].Color <> clFuchsia then
                BGInfo.Color := sw.SkinManager.gd[sw.SkinManager.ConstData.Scrolls[asLeft].SkinIndex].Props[0].Color
              else
                BGInfo.Color := GetGlobalColor;

              if not Ac_IsScrollbarActive(sw.sBarVert) or not Ac_IsScrollbarActive(sw.sBarHorz) then
                BGInfo.Color := BlendColors(gd[sw.SkinData.SkinIndex].Props[integer(ControlIsActive(sw.SkinData))].Color, BGInfo.Color, sDefaults.DefBlendDisabled);

              FillDC(bGrip.Canvas.Handle, MkRect(bGrip), BGInfo.Color);
            end
            else
              if (BGInfo.BgType = btCache) then // If AlphaSkins are fully supported
                BitBlt(bGrip.Canvas.Handle, 0, 0, bGrip.Width, bGrip.Height, BGInfo.Bmp.Canvas.Handle, R.Left, R.Top, SRCCOPY)
              else begin
                BGInfo.Color := GetGlobalColor;
                FillDC(bGrip.Canvas.Handle, MkRect(bGrip), BGInfo.Color);
              end;

          // Grip if exists
          if Ac_GripVisible(sw, Handle, R2) then begin
            LeftRight := sw.SkinManager.ConstData.GripRightBottom;
            if sw.SkinManager.IsValidImgIndex(LeftRight) then
              with sw.SkinManager.ma[LeftRight] do
                DrawSkinGlyph(bGrip, Point(bGrip.Width - Width, bGrip.Height - Height),
                                  0, 1, sw.SkinManager.ma[LeftRight], BGInfoToCI(@BGInfo));
          end;
          BitBlt(dc, R.Left, R.Top, bGrip.Width, bGrip.Height, bGrip.Canvas.Handle, 0, 0, SRCCOPY);
          FreeAndNil(bGrip);
        end;
        if aDC = 0 then
          ReleaseDC(Handle, DC);
      end;
    end;
  end;
end;


function Ac_NCDrawScrollbar(sb: TacScrollBar; Handle: hwnd; DC: hdc; R: TRect; uDrawFlags: integer; ThumbPos: integer = -1): LRESULT;
begin
  if sb.nBarType = SB_HORZ then
    Result := Ac_NCDrawHScrollbar(sb, Handle, dc, R, uDrawFlags, ThumbPos)
  else
    Result := Ac_NCDrawVScrollbar(sb, Handle, dc, R, uDrawFlags, ThumbPos);
end;


function Ac_NCCalcSize(const sw: TacScrollWnd; const Handle: hwnd; const wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  R, OldRect: TRect;
  nwStyle, dwStyle: ACNativeInt;
  sb: TacScrollBar;
begin
  with TNCCalcSizeParams(Pointer(lParam)^) do begin
    OldRect := rgrc[0];
    dwStyle := GetWindowLong(Handle, GWL_STYLE);
    if dwStyle and (WS_VSCROLL or WS_HSCROLL) <> 0 then begin
      nwStyle := dwStyle and not WS_VSCROLL and not WS_HSCROLL;
      sw.bPreventStyleChange := True;
      SetWindowLong(Handle, GWL_STYLE, nwStyle);
      Result := sw.CallPrevWndProc(Handle, WM_NCCALCSIZE, wParam, lParam);
      SetWindowLong(Handle, GWL_STYLE, dwStyle);
      sw.bPreventStyleChange := False;
    end
    else
      Result := sw.CallPrevWndProc(Handle, WM_NCCALCSIZE, wParam, lParam);


    if not (sw.SkinData.FOwnerObject is TsSkinProvider) and not ((sw is TacListViewWnd) and TacListViewWnd(sw).AutoSizedCols) then
      if (sw.SkinManager.gd[sw.SkinData.SkinIndex].ScrollBorderOffset < 0) and (rgrc[0].left - oldrect.left > 1) then
        InflateRect(rgrc[0], -sw.SkinManager.gd[sw.SkinData.SkinIndex].ScrollBorderOffset, -sw.SkinManager.gd[sw.SkinData.SkinIndex].ScrollBorderOffset);

    R := rgrc[0];
    sw.cxLeftEdge   := R.left - oldrect.left;
    sw.cxRightEdge  := oldrect.right - R.right;
    sw.cyTopEdge    := R.top - oldrect.top;
    sw.cyBottomEdge := oldrect.bottom - R.bottom;

    sb := sw.sbarHorz;
  {$IFDEF ADDWEBBROWSER}
    if sw is TacWBWnd then begin
      if TacWBWnd(sw).Container <> nil then begin
        if TacWBWnd(sw).Container.HScrollBar.Visible then
          if R.bottom - R.top >= GetScrollMetric(sb, SM_SCROLLWIDTH) then
            dec(rgrc[0].bottom, GetScrollMetric(sb, SM_SCROLLWIDTH) - GetSystemMetrics(SM_CYHSCROLL));

        if TacWBWnd(sw).Container.VScrollBar.Visible then
          if R.right - R.left >= GetScrollMetric(sw.sbarVert, SM_SCROLLWIDTH) then
            if sw.fLeftScrollbar then
              inc(rgrc[0].left, GetScrollMetric(sw.sbarVert, SM_SCROLLWIDTH) - GetSystemMetrics(SM_CXVSCROLL))
            else
              dec(rgrc[0].right, GetScrollMetric(sw.sbarVert, SM_SCROLLWIDTH) - GetSystemMetrics(SM_CXVSCROLL));
      end;
    end
    else
  {$ENDIF}
      if sb <> nil then begin
        if dwStyle and WS_HSCROLL <> 0 then
          sb.fScrollFlags := CSBS_VISIBLE
        else
          sb.fScrollFlags := 0;

        if (sb.fScrollFlags and CSBS_VISIBLE <> 0) and (R.bottom - R.top >= GetScrollMetric(sb, SM_SCROLLWIDTH)) then begin
          dec(rgrc[0].bottom, GetScrollMetric(sb, SM_SCROLLWIDTH));
          sb.fScrollVisible := True;
        end
        else
          sb.fScrollVisible := False;

        sb := sw.sbarVert;
        if dwStyle and WS_VSCROLL = WS_VSCROLL then
          sb.fScrollFlags := CSBS_VISIBLE
        else
          sb.fScrollFlags := 0;

        if (sb.fScrollFlags and CSBS_VISIBLE <> 0) and (R.right - R.left >= GetScrollMetric(sb, SM_SCROLLWIDTH)) then begin
          if sw.fLeftScrollbar then
            inc(rgrc[0].left, GetScrollMetric(sb, SM_SCROLLWIDTH))
          else
            dec(rgrc[0].right, GetScrollMetric(sb, SM_SCROLLWIDTH));

          sb.fScrollVisible := True;
        end
        else
          sb.fScrollVisible := False;
      end
  end;
end;


function Ac_Notify(const sw: TacScrollWnd; const Handle: hwnd; const wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := sw.CallPrevWndProc(Handle, WM_NOTIFY, wParam, lParam);
end;


function Ac_ThumbTrackHorz(sbar: TacScrollBar; Handle: hwnd; x, y: integer): LRESULT;
var
  DC: hdc;
  pt: TPoint;
  Bmp: TBitmap;
  BG: TacBGInfo;
  CI: TCacheInfo;
  sm: TsSkinManager;
  R, rc, winrect: TRect;
  thumbpos, pos, siMaxMin, btnWidth, tdiv2: integer;
begin
  pt := Point(x, y);
  rc := rcThumbBounds;

  btnWidth := GetScrollMetric(sbar, SM_BTNSIZE);
  inc(rc.left,  btnWidth);
  dec(rc.right, btnWidth);
  btnWidth := GetScrollMetric(sbar, SM_BTNSIZE, True);

  thumbpos := pt.x - nThumbMouseOffset;
  if thumbpos < rc.left then
    thumbpos := rc.left;

  if thumbpos > rc.right - nThumbSize then
    thumbpos := rc.right - nThumbSize;

  GetWindowRect(Handle, WinRect);

  AC_GetHScrollRect(sbar.sw, Handle, R);
  OffsetRect(R, -winrect.left, -winrect.top);
  Bmp := CreateBmp32(R);
  sm := sbar.sw.SkinManager;
  OffsetRect(rc, -winrect.left, -winrect.top);

  BG.PleaseDraw := False;
  GetBGInfo(@BG, Handle);
  if sbar.sw.SkinData.FOwnerObject is TsSkinProvider then
    if TsSkinProvider(sbar.sw.SkinData.FOwnerObject).BorderForm = nil then
      BG.Offset := MkPoint
    else
      BG.Offset := Point(DiffBorder(TsSkinProvider(sbar.sw.SkinData.FOwnerObject).BorderForm) + sbar.sw.SkinData.SkinManager.FormShadowSize.Left, DiffTitle(TsSkinProvider(sbar.sw.SkinData.FOwnerObject).BorderForm) + sbar.sw.SkinData.SkinManager.FormShadowSize.Top);

  CI := BGInfoToCI(@BG);
  dec(thumbpos, winrect.left);
  tdiv2 := thumbpos + nThumbSize div 2 - R.Left;
  with sm.ConstData.Scrolls[asLeft] do
    PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1], CI, True, 0, MkRect(tdiv2, Bmp.Height),
    Point(R.Left - sbar.sw.cxLeftEdge, R.Top - sbar.sw.cyTopEdge), Bmp, sm);

  with sm.ConstData.Scrolls[asRight] do
    PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1], CI, True, 0, Rect(tdiv2, 0, Bmp.Width, Bmp.Height),
    Point(R.Left + tdiv2 - sbar.sw.cxLeftEdge, R.Top - sbar.sw.cyTopEdge), Bmp, sm);

  if btnWidth <> 0 then begin
    ac_DrawScrollBtn(MkRect(BtnWidth, Bmp.Height), 0, Bmp, sbar.sw.SkinData, asLeft);
    ac_DrawScrollBtn(Rect(Bmp.Width - BtnWidth, 0, Bmp.Width, Bmp.Height), 0, Bmp, sbar.sw.SkinData, asRight);
  end;
  ac_DrawSlider(Rect(thumbpos - R.Left, 0, thumbpos + nThumbSize - R.Left, Bmp.Height), 2, Bmp, sm, False);
  dc := GetWindowDC(Handle);
  BitBlt(dc, R.Left, R.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
  ReleaseDC(Handle, dc);
  FreeAndNil(Bmp);
  siMaxMin := sbar.scrollInfo.nMax - sbar.scrollInfo.nMin;
  if siMaxMin > 0 then
    pos := MulDiv(thumbpos - Rc.left, siMaxMin - integer(sbar.scrollInfo.nPage) + 1, Rc.right - Rc.left - nThumbSize)
  else
    pos := thumbpos - Rc.left;

  if pos <> nLastSBPos then begin
    sbar.scrollInfo.nTrackPos := sbar.scrollInfo.nMin + pos;
    sbar.sw.DontRepaint := True;
    SendScrollMessage(Handle, uScrollTimerMsg, SB_THUMBTRACK, sbar.scrollInfo.nTrackPos);
    sbar.sw.DontRepaint := False;
  end;
  nLastSBPos := pos;
  Result := 0;
end;


function Ac_ThumbTrackVert(sbar: TacScrollBar; Handle: hwnd; x, y: integer): LRESULT;
var
  DC: hdc;
  pt: TPoint;
  Bmp: TBitmap;
  BG: TacBGInfo;
  CI: TCacheInfo;
  sm: TsSkinManager;
  R, rc, winrect: TRect;
  thumbpos, pos, siMaxMin, btnHeight, tdiv2: integer;
begin
  pt := Point(x, y);
  rc := rcThumbBounds;

  btnHeight := GetScrollMetric(sbar, SM_BTNSIZE);
  inc(rc.Top,  btnHeight);
  dec(rc.Bottom, btnHeight);
  btnHeight := GetScrollMetric(sbar, SM_BTNSIZE, true);

  thumbpos := pt.y - nThumbMouseOffset;
  if thumbpos < rc.Top then
    thumbpos := rc.Top;

  if thumbpos > rc.Bottom - nThumbSize then
    thumbpos := rc.Bottom - nThumbSize;

  GetWindowRect(Handle, WinRect);
  AC_GetVScrollRect(sbar.sw, Handle, R);
  OffsetRect(R, -winrect.left, -winrect.top);
  Bmp := CreateBmp32(R);
  sm := sbar.sw.SkinManager;
  OffsetRect(rc, -winrect.left, -winrect.top);
  BG.PleaseDraw := False;
  GetBGInfo(@BG, Handle);
  if sbar.sw.SkinData.FOwnerObject is TsSkinProvider then
    if TsSkinProvider(sbar.sw.SkinData.FOwnerObject).BorderForm = nil then
      BG.Offset := MkPoint
    else
      BG.Offset := Point(DiffBorder(TsSkinProvider(sbar.sw.SkinData.FOwnerObject).BorderForm) + sbar.sw.SkinData.SkinManager.FormShadowSize.Left, DiffTitle(TsSkinProvider(sbar.sw.SkinData.FOwnerObject).BorderForm) + sbar.sw.SkinData.SkinManager.FormShadowSize.Top);

  CI := BGInfoToCI(@BG);
  dec(thumbpos, winrect.Top);
  tdiv2 := thumbpos + nThumbSize div 2 - R.Top;
  with sm.ConstData.Scrolls[asTop] do
    PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                  CI, True, 0, MkRect(Bmp.Width, tdiv2),
                  Point(R.Left - sbar.sw.cxLeftEdge, R.Top - sbar.sw.cyTopEdge), Bmp, sm);
  with sm.ConstData.Scrolls[asBottom] do
    PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                  CI, True, 0, Rect(0, tdiv2, Bmp.Width, Bmp.Height),
                  Point(R.Left - sbar.sw.cxLeftEdge, R.Top + tdiv2 - sbar.sw.cyTopEdge), Bmp, sm);

  if btnHeight <> 0 then begin
    ac_DrawScrollBtn(MkRect(Bmp.Width, BtnHeight), 0, Bmp, sbar.sw.SkinData, asTop);
    ac_DrawScrollBtn(Rect(0, Bmp.Height - BtnHeight, Bmp.Width, Bmp.Height), 0, Bmp, sbar.sw.SkinData, asBottom);
  end;

  ac_DrawSlider(Rect(0, thumbpos - R.Top, Bmp.Width, thumbpos + nThumbSize - R.Top), 2, Bmp, sm, True);

  dc := GetWindowDC(Handle);
  BitBlt(dc, R.Left, R.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
  ReleaseDC(Handle, dc);
  FreeAndNil(Bmp);

  siMaxMin := sbar.scrollInfo.nMax - sbar.scrollInfo.nMin;
  if siMaxMin > 0 then
    if thumbpos - Rc.Top = HeightOf(Rc) - nThumbSize then // If max
      pos := siMaxMin - integer(sbar.scrollInfo.nPage) + 2
    else
      pos := MulDiv(thumbpos - Rc.Top, siMaxMin - integer(sbar.scrollInfo.nPage) + 2, HeightOf(Rc) - nThumbSize)
  else
    pos := thumbpos - Rc.Top;

  if pos <> nLastSBPos then begin
    sbar.scrollInfo.nTrackPos := sbar.scrollInfo.nMin + pos;
    sbar.sw.DontRepaint := True;
    SendScrollMessage(Handle, uScrollTimerMsg, SB_THUMBTRACK, sbar.scrollInfo.nTrackPos);
    sbar.sw.DontRepaint := False;
  end;
  nLastSBPos := pos;
  Result := 0;
end;


function GetScrollRect(sw: TacScrollWnd; nBar: integer; Handle: hwnd; var R: TRect): boolean;
begin
  Result := True;
  if nBar = SB_HORZ then
    Ac_GetHScrollRect(sw, Handle, R)
  else
    if nBar = SB_VERT then
      Ac_GetVScrollRect(sw, Handle, R)
    else
      Result := False;
end;


function Ac_GetHorzScrollPortion(sb: TacScrollBar; R: TRect; x, y: integer): integer;
var
  WorkingWidth, ScrollWidth, ButWidth, ThumbWidth, ThumbPos: integer;
begin
  Result := HTSCROLL_NONE;
  ButWidth := GetScrollMetric(sb, SM_SCROLL_LENGTH, False);
  ScrollWidth := WidthOf(R);
  WorkingWidth := ScrollWidth - ButWidth * 2;
  if (y >= R.Top) and (y < R.Bottom) then begin
    Ac_CalcThumbSize(sb, R, ThumbWidth, ThumbPos);
    if ScrollWidth <= ButWidth * 2 then
      ButWidth := ScrollWidth div 2;

    if (x >= R.Left) and (x < R.Left + ButWidth) then
      Result := HTSCROLL_LEFT
    else
      if (x >= R.Right - ButWidth) and (x < R.Right) then
        Result := HTSCROLL_RIGHT
      else
        if ThumbWidth >= WorkingWidth then
          Result := HTSCROLL_NONE
        else
          if (x >= ThumbPos) and (x < ThumbPos + ThumbWidth) then
            Result := HTSCROLL_THUMB
          else
            if (x >= R.Left + ButWidth) and (x < ThumbPos) then
              Result := HTSCROLL_PAGELEFT
            else
              if (x >= ThumbPos + ThumbWidth) and (x < R.Right - ButWidth) then
                Result := HTSCROLL_PAGERIGHT;
  end;
end;


function Ac_GetVertScrollPortion(sb: TacScrollBar; R: TRect; x, y: integer): integer;
var
  workingHeight, scrollHeight, butHeight, thumbHeight, thumbpos: integer;
begin
  Result := HTSCROLL_NONE;
  butHeight := GetScrollMetric(sb, SM_SCROLL_LENGTH, False);
  scrollHeight := HeightOf(R);
  workingHeight := scrollHeight - butHeight * 2;
  if (x >= R.Left) and (x < R.Right) then begin
    Ac_CalcThumbSize(sb, R, thumbHeight, thumbpos);
    if scrollHeight <= butHeight * 2 then
      butHeight := scrollHeight div 2;

    if (y >= R.Top) and (y < R.Top + butHeight) then
      Result := HTSCROLL_LEFT
    else
      if (y >= R.Bottom - butHeight) and (y < R.Bottom) then
        Result := HTSCROLL_RIGHT
      else
        if thumbHeight >= workingHeight then
          Result := HTSCROLL_NONE
        else
          if (y >= thumbpos) and (y < thumbpos + thumbHeight) then
            Result := HTSCROLL_THUMB
          else
            if (y >= R.Top + butHeight) and (y < thumbpos) then
              Result := HTSCROLL_PAGELEFT
            else
              if (y >= thumbpos + thumbHeight) and (y < R.Bottom - butHeight) then
                Result := HTSCROLL_PAGERIGHT;
  end;
end;


function Ac_GetHorzPortion(sb: TacScrollBar; Handle: hwnd; R: TRect; x, y: integer): integer;
var
  rc: TRect;
begin
  rc := R;
  if (y < rc.top) or (y >= rc.bottom) then
    Result := HTSCROLL_NONE
  else
    Result := Ac_GetHorzScrollPortion(sb, rc, x, y);
end;


function Ac_GetVertPortion(sb: TacScrollBar; Handle: hwnd; R: TRect; x, y: integer): integer;
var
  rc: TRect;
begin
  rc := R;
  if (x < rc.Left) or (x >= rc.Right) then
    Result := HTSCROLL_NONE
  else
    Result := Ac_GetVertScrollPortion(sb, rc, x, y);
end;


function Ac_GetPortion(sbar: TacScrollBar; Handle: hwnd; R: TRect; x, y: integer): integer;
begin
  if sbar.nBarType = SB_HORZ then
    Result := Ac_GetHorzPortion(sbar, Handle, R, x, y)
  else
    if sbar.nBarType = SB_VERT then
      Result := Ac_GetVertPortion(sbar, Handle, R, x, y)
    else
      Result := HTSCROLL_NONE;
end;


procedure Ac_GetRealHorzScrollRect(sb: TacScrollBar; var R: TRect);
begin
  if sb.fButVisibleBefore then
    inc(R.Left, sb.nButSizeBefore);

  if sb.fButVisibleAfter then
    dec(R.Right, sb.nButSizeAfter);
end;


procedure Ac_GetRealVertScrollRect(sb: TacScrollBar; var R: TRect);
begin
  if sb.fButVisibleBefore then
    inc(R.top, sb.nButSizeBefore);

  if sb.fButVisibleAfter then
    dec(R.bottom, sb.nButSizeAfter);
end;


procedure Ac_GetRealScrollRect(const sb: TacScrollBar; var R: TRect);
begin
  if sb.nBarType = SB_HORZ then
    Ac_GetRealHorzScrollRect(sb, R)
  else
    Ac_GetRealVertScrollRect(sb, R);
end;


function Ac_MouseMove(sw: TacScrollWnd; Handle: hwnd; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  thisportion, x, y, lastportion: integer;
  R, WinRect: TRect;
  nlParam: longint;
  sb: TacScrollBar;
  pt: TPoint;
  dc: hdc;
begin
  lastportion := 0;
  if sw.fThumbTracking then begin
    lParam := GetMessagePos();
    x := SmallInt(LOWORD(LongWord(lParam)));
    y := SmallInt(HIWORD(LongWord(lParam)));
    case uCurrentScrollbar of
      SB_HORZ: begin
        Result := Ac_ThumbTrackHorz(sw.sbarHorz, Handle, x,y);
        Exit;
      end;
      SB_VERT: begin
        Result := Ac_ThumbTrackVert(sw.sbarVert, Handle, x,y);
        Exit;
      end
    end;
  end;
  if uCurrentScrollPortion = HTSCROLL_NONE then
    Result := sw.CallPrevWndProc(Handle, WM_MOUSEMOVE, WParam, LParam)
  else begin
    LongWord(nlParam) := GetMessagePos();
    GetWindowRect(Handle, winrect);
    pt.x := SmallInt(LOWORD(LongWord(nlParam)));
    pt.y := SmallInt(HIWORD(LongWord(nlParam)));
    // emulate the mouse input on a scrollbar here...
    case uCurrentScrollbar of
      SB_VERT: sb := sw.sbarVert
      else     sb := sw.sbarHorz;
    end;
    // get the total area of the normal scrollbar area
    GetScrollRect(sw, sb.nBarType, Handle, R);
    // see if we clicked in the inserted buttons / normal scrollbar
    // thisportion = GetPortion(sb, hwnd, &rect, LOWORD(lParam), HIWORD(lParam));
    thisportion := Ac_GetPortion(sb, Handle, R, pt.x, pt.y);
    // we need to do different things depending on if the
    // user is activating the scrollbar itself, or one of
    // the inserted buttons
    case uCurrentScrollPortion of
      HTSCROLL_LEFT, HTSCROLL_RIGHT, HTSCROLL_THUMB, HTSCROLL_PAGELEFT, HTSCROLL_PAGERIGHT, HTSCROLL_NONE: begin
        // adjust the total scroll area to become where the scrollbar
        // really is (take into account the inserted buttons)
        Ac_GetRealScrollRect(sb, R);
        OffsetRect(R, -winrect.left, -winrect.top);
        dc := GetWindowDC(Handle);
        if thisportion <> uCurrentScrollPortion then begin
          uScrollTimerPortion := HTSCROLL_NONE;
          if lastportion <> thisportion then
            Ac_NCDrawScrollbar(sb, Handle, dc, R, HTSCROLL_NORMAL);
        end
        // otherwise, draw the button in its depressed / clicked state
        else begin
          uScrollTimerPortion := uCurrentScrollPortion;
          if lastportion <> thisportion then
            Ac_NCDrawScrollbar(sb, Handle, dc, R, thisportion);
        end;
        ReleaseDC(Handle, dc);
      end
    end;
    // must return zero here, because we might get cursor anomilies
    // CallWindowProc(sw->oldproc, hwnd, WM_MOUSEMOVE, wParam, lParam);
    Result := 0;
  end
end;


function Ac_NCMouseMove(sw: TacScrollWnd; Handle: hwnd; wHitTest: WPARAM; lParam: LPARAM): LRESULT;
const
  SBTypes: array [HTHSCROLL..HTVSCROLL] of integer = (SB_HORZ, SB_VERT);
begin
  // Install a timer for the mouse-over events, if the mouse moves over one of the scrollbars
  hwndCurSB := Handle;
  if wHitTest in [HTHSCROLL, HTVSCROLL] then begin
    if uMouseOverScrollbar = SBTypes[wHitTest] then begin
      Result := sw.CallPrevWndProc(Handle, WM_NCMOUSEMOVE, wHitTest, LParam);
      Exit;
    end;
    uLastHitTestPortion := HTSCROLL_NONE;
    uHitTestPortion := HTSCROLL_NONE;
    GetScrollRect(sw, SBTypes[wHitTest], Handle, MouseOverRect);
    uMouseOverScrollbar := SBTypes[wHitTest];
    uMouseOverId := SetTimer(Handle, COOLSB_TIMERID3, COOLSB_TIMERINTERVAL3, nil);
    Ac_NCDraw(sw, Handle);
  end;
  Result := sw.CallPrevWndProc(Handle, WM_NCMOUSEMOVE, wHitTest, LParam);
end;


function Ac_SetCursor(sw: TacScrollWnd; Handle: hwnd; var wParam: WPARAM; var lParam: LPARAM): LRESULT;
begin
  Result := sw.CallPrevWndProc(Handle, WM_SETCURSOR, WParam, LParam);
end;


function Ac_StyleChange(const sw: TacScrollWnd; const Handle: hwnd; const wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  ss: TStyleStruct;
begin
  ss := TStyleStruct(Pointer(lParam)^);
  if wParam = Windows.WParam(GWL_EXSTYLE) then
    sw.fLeftScrollbar := ss.styleNew and WS_EX_LEFTSCROLLBAR <> 0;

  Result := sw.CallPrevWndProc(Handle, WM_STYLECHANGED, WParam, LParam);
end;


function Ac_NCHitTest(sw: TacScrollWnd; Handle: hwnd; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  pt: TPoint;
  hrect, vrect: TRect;
begin
  if (sw.SkinData.SkinManager.ActiveControl <> sw.CtrlHandle) and
        not sw.SkinData.FMouseAbove and ((sw.SkinData.FOwnerControl = nil) or acMouseInControl(sw.SkinData.FOwnerControl)) then
    sw.SkinData.SkinManager.ActiveControl := sw.CtrlHandle;

  pt.x := SmallInt(LoWord(longword(lParam)));
  pt.y := SmallInt(HiWord(longWord(lParam)));
  if sw.sbarHorz.fScrollVisible then
    Ac_GetHScrollRect(sw, Handle, hrect);

  if sw.sbarVert.fScrollVisible then
    Ac_GetVScrollRect(sw, Handle, vrect);

  if sw.sbarHorz.fScrollVisible and PtInRect(hrect, pt) then
    if not Ac_IsScrollbarActive(sw.sbarHorz) then
      Result := Windows.HTNOWHERE
    else
      Result := HTHSCROLL
  else
    if sw.sbarVert.fScrollVisible and PtInRect(vrect, pt) then
      if not Ac_IsScrollbarActive(sw.sbarVert) then
        Result := Windows.HTNOWHERE
      else
        Result := HTVSCROLL
    else
      if Ac_GripVisible(sw, Handle, Rect(hrect.Right, hrect.Top, vrect.Right, hrect.Bottom)) and PtInRect(Rect(hrect.Right, hrect.Top, vrect.Right, hrect.Bottom), pt) then
        Result := HTBOTTOMRIGHT
      else
        Result := sw.CallPrevWndProc(Handle, WM_NCHITTEST, WParam, LParam);
end;


procedure SendScrollMessage(const Handle: hwnd; const scrMsg: integer; const scrId: integer; const pos: integer);
var
  si: TScrollInfo;
  BarFlag: integer;
begin
{$IFDEF LOGGED}
//  AddToLog(MakeMessage(scrMsg, scrID, pos, 0));
{$ENDIF}
  if SendAMessage(Handle, AC_BEFORESCROLL, MakeLPAram(Word(ScrId), Word(ScrMsg))) <> 1 then begin // If using more then 64K is not forbidden (is not used in ListView)
    si.cbSize := SizeOf(TScrollInfo);
    si.fMask := SIF_ALL;
    BarFlag := iff(ScrMsg = WM_HSCROLL, SB_HORZ, SB_VERT);
    GetScrollInfo(Handle, BarFlag, {$IFDEF FPC}@si{$ELSE}si{$ENDIF});
    // Patch for DBGridEh
    case scrId of
      SB_THUMBTRACK: begin
        si.cbSize := SizeOf(TScrollInfo);
        si.fMask := SIF_POS;
        si.nPos := pos;
        SetScrollInfo(Handle, BarFlag, {$IFDEF FPC}@si{$ELSE}si{$ENDIF}, False);
      end;
    end;
    TrySendMessage(Handle, Cardinal(ScrMsg), MakeWParam(Longword(ScrId), min(Longword(Pos), MaxWord)), 0);
  end
  else
    TrySendMessage(Handle, Cardinal(ScrMsg), MakeWParam(Longword(ScrId), min(Longword(Pos), MaxWord)), Pos {Sending this value specially for a ListView});

  SendAMessage(Handle, AC_AFTERSCROLL, MakeLPAram(Word(ScrId), Word(ScrMsg)));
end;


function Ac_NCLButtonDown(sw: TacScrollWnd; Handle: hwnd; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  R, WinRect: TRect;
  sb: TacScrollBar;
  pt: TPoint;
  DC: hdc;

  procedure JustDoIt;
  begin
    if Ac_IsScrollbarActive(sb) then begin
      Ac_GetRealScrollRect(sb, R);
      if uCurrentScrollbar = SB_HORZ then
        uScrollTimerPortion := Ac_GetHorzScrollPortion(sb, R, pt.x, pt.y)
      else
        uScrollTimerPortion := Ac_GetVertScrollPortion(sb, R, pt.x, pt.y);

      GetWindowRect(Handle, WinRect);
      OffsetRect(R, -WinRect.left, -WinRect.top);
      dc := GetWindowDC(Handle);

      Ac_NCDrawScrollbar(sb, Handle, dc, R, uScrollTimerPortion);
      ReleaseDC(Handle, dc);

      SendScrollMessage(Handle, uScrollTimerMsg, uCurrentScrollPortion, 0);
      uScrollTimerPortion := uCurrentScrollPortion;
      uScrollTimerId := SetTimer(Handle, COOLSB_TIMERID1, COOLSB_TIMERINTERVAL1, nil);
    end;
  end;

begin
  Result := 0;
  pt.x := SmallInt(LoWord(LongWord(lParam)));
  pt.y := SmallInt(HiWord(LongWord(lParam)));
  hwndCurSB := Handle;
  case wParam of
    HTHSCROLL: begin
      uScrollTimerMsg := WM_HSCROLL;
      uCurrentScrollbar := SB_HORZ;
      sb := sw.sbarHorz;
      // get the total area of the normal Horz scrollbar area
      Ac_GetHScrollRect(sw, Handle, R);
      uCurrentScrollPortion := Ac_GetHorzPortion(sb, Handle, R, SmallInt(LoWord(LongWord(lParam))), SmallInt(HiWord(LongWord(lParam))));
    end;

    HTVSCROLL: begin
      uScrollTimerMsg := WM_VSCROLL;
      uCurrentScrollbar := SB_VERT;
      sb := sw.sbarVert;
      Ac_GetVScrollRect(sw, Handle, R);
      uCurrentScrollPortion := Ac_GetVertPortion(sb, Handle, R, SmallInt(LOWORD(LongWord(lParam))), SmallInt(HIWORD(LongWord(lParam))));
    end

    else begin // NORMAL PROCESSING
      uCurrentScrollPortion := HTSCROLL_NONE;
      Result := sw.CallPrevWndProc(Handle, WM_NCLBUTTONDOWN, WParam, LParam);
      Exit;
    end;
  end;

  case uCurrentScrollPortion of
    HTSCROLL_THUMB: begin
      if not Ac_IsScrollbarActive(sb) then
        Exit;

      Ac_GetRealScrollRect(sb, R);
      Ac_CalcThumbSize(sb, R, nThumbSize, nThumbPos);
      // remember the bounding rectangle of the scrollbar work area
      rcThumbBounds := R;
      sw.fThumbTracking := True;
      sb.scrollInfo.nTrackPos := sb.scrollInfo.nPos;
      nThumbMouseOffset := iff(wParam = HTVSCROLL, pt.y, pt.x) - nThumbPos;
      nLastSBPos := sb.scrollInfo.nPos;
      GetWindowRect(Handle, WinRect);
      OffsetRect(R, -WinRect.left, -WinRect.top);
      dc := GetWindowDC(Handle);
      Ac_NCDrawScrollbar(sb, Handle, dc, R, HTSCROLL_THUMB);
      ReleaseDC(Handle, dc);
    end;

    HTSCROLL_LEFT:
      if sb.fScrollFlags and ESB_DISABLE_LEFT <> 0 then
        Exit
      else
        JustDoIt;

    HTSCROLL_RIGHT:
      if sb.fScrollFlags and ESB_DISABLE_RIGHT <> 0 then
        Exit
      else
        JustDoIt;

    HTSCROLL_PAGELEFT, HTSCROLL_PAGERIGHT:
      JustDoIt
    else
      Result := sw.CallPrevWndProc(Handle, WM_NCLBUTTONDOWN, WParam, LParam);
  end;
  if uCurrentScrollPortion <> -1 then
    SetCapture(Handle);
end;


function Ac_LButtonUp(sw: TacScrollWnd; Handle: hwnd; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  DC: hdc;
  pt: TPoint;
  sb: TacScrollBar;
  R, WinRect: TRect;
  ThumbPos, BtnHeight, ThumbSize: integer;
begin
  Result := 0;
  // current scrollportion is the button that we clicked down on
  if uCurrentScrollPortion <> HTSCROLL_NONE then begin
    // For popup listboxes
    if (sw.SkinData.FOwnerControl <> nil) or not ((sw is TacComboListWnd) and not TacComboListWnd(sw).SimplyBox) or (sw.Tag = ACT_RELCAPT) then
      ReleaseCapture;

    sb := sw.sbarHorz;
    lParam := GetMessagePos();
    GetWindowRect(Handle, winrect);
    pt.x := SmallInt(LOWORD(LongWord(lParam)));
    pt.y := SmallInt(HIWORD(LongWord(lParam)));
    // emulate the mouse input on a scrollbar here...
    case uCurrentScrollbar of
      SB_HORZ: begin
        // get the total area of the normal Horz scrollbar area
        sb := sw.sbarHorz;
        Ac_GetHScrollRect(sw, Handle, R);
      end;
      SB_VERT: begin
        // get the total area of the normal Horz scrollbar area
        sb := sw.sbarVert;
        Ac_GetVScrollRect(sw, Handle, R);
      end;
    end;
    case uCurrentScrollPortion of
      HTSCROLL_LEFT, HTSCROLL_RIGHT, HTSCROLL_PAGELEFT, HTSCROLL_PAGERIGHT, HTSCROLL_NONE: begin
        KillTimer(Handle, uScrollTimerId);
        // In case we were thumb tracking, make sure we stop NOW
        if sw.fThumbTracking then begin
          sw.DontRepaint := True;
          SendScrollMessage(Handle, uScrollTimerMsg, SB_THUMBPOSITION, nLastSBPos);
          sw.fThumbTracking := False;
        end;
        // send the SB_ENDSCROLL message now that scrolling has finished
        sw.DontRepaint := True;
        SendScrollMessage(Handle, uScrollTimerMsg, SB_ENDSCROLL, 0);
        sw.DontRepaint := False;
        // adjust the total scroll area to become where the scrollbar
        // really is (take into account the inserted buttons)
        Ac_GetRealScrollRect(sb, R);
        OffsetRect(R, -winrect.left, -winrect.top);
        dc := GetWindowDC(Handle);
        // draw whichever scrollbar sb is
        Ac_NCDrawScrollbar(sb, Handle, dc, R, HTSCROLL_NORMAL);
        ReleaseDC(Handle, dc);
      end;

      HTSCROLL_THUMB: begin
        if (sw is TacComboListWnd) and TacComboListWnd(sw).DBScroll then begin // Correcting a position for DBLookupCombo
          Ac_CalcThumbSize(sb, R, ThumbSize, ThumbPos);
          ThumbPos := pt.y - R.Top;
          btnHeight := GetScrollMetric(sb, SM_BTNSIZE);
          if ThumbPos > BtnHeight then
            if ThumbPos + ThumbSize >= HeightOf(R) - BtnHeight then
              nLastSBPos := 4
            else
              if ThumbPos + ThumbSize div 2 < HeightOf(R) div 2 then
                nLastSBPos := 1
              else
                nLastSBPos := 3
          else
            nLastSBPos := 0;
        end;
        // In case we were thumb tracking, make sure we stop NOW
        if sw.fThumbTracking then begin
          sw.DontRepaint := True;
          SendScrollMessage(Handle, uScrollTimerMsg, SB_THUMBPOSITION, nLastSBPos);
          sw.fThumbTracking := False;
        end;
        // send the SB_ENDSCROLL message now that scrolling has finished
        sw.DontRepaint := True;
        SendScrollMessage(Handle, uScrollTimerMsg, SB_ENDSCROLL, nLastSBPos);
        sw.DontRepaint := False;
        // adjust the total scroll area to become where the scrollbar
        // really is (take into account the inserted buttons)
        Ac_GetRealScrollRect(sb, R);
        OffsetRect(R, -winrect.left, -winrect.top);
        dc := GetWindowDC(Handle);
        // draw whichever scrollbar sb is
        Ac_NCDrawScrollbar(sb, Handle, dc, R, HTSCROLL_NORMAL);
        ReleaseDC(Handle, dc);
      end;
    end;
    // reset our state to default
    uCurrentScrollPortion := HTSCROLL_NONE;
    uScrollTimerPortion	  := HTSCROLL_NONE;
    uScrollTimerId	      := 0;
    uScrollTimerMsg       := 0;
    uCurrentScrollbar     := COOLSB_NONE;
    if longint(WParam) <> -1 then // Do not call default handler
      if sw.SkinData.FOwnerControl <> nil then begin
        if (sw.SkinData.FOwnerControl.ClassName <> 'TImageEnView') and (sw.SkinData.FOwnerControl.ClassName <> 'TImageEnVect') then
          Result := sw.CallPrevWndProc(Handle, WM_LBUTTONUP, WParam, LParam);
      end
      else
        if not ((sw is TacComboListWnd) and not TacComboListWnd(sw).SimplyBox) then
          Result := sw.CallPrevWndProc(Handle, WM_LBUTTONUP, WParam, LParam);
  end
  else
    Result := sw.CallPrevWndProc(Handle, WM_LBUTTONUP, WParam, LParam);
end;


function Ac_Timer(const sw: TacScrollWnd; const Handle: hwnd; const wTimerId: WPARAM; lParam: LPARAM): LRESULT;
var
  DC: hdc;
  pt: TPoint;
  bCalled: boolean;
  sbar: TacScrollBar;
  rect, winrect: TRect;
begin
  Result := 0;
  // let all timer messages go past if we don't have a timer installed ourselves
  if (uScrollTimerId = 0) and (uMouseOverId = 0) then begin
    Result := sw.CallPrevWndProc(Handle, WM_TIMER, wTimerID, LParam);
    bCalled := True;
  end
  else
    bCalled := False;
  // mouse-over timer
  if wTimerId = COOLSB_TIMERID3 then begin
    if sw.fThumbTracking then
      Exit;
    // if the mouse moves outside the current scrollbar, then kill the timer..
    GetCursorPos(pt);
    if not PtInRect(MouseOverRect, pt) then begin
      KillTimer(Handle, uMouseOverId);
      uMouseOverId := 0;
      uMouseOverScrollbar := COOLSB_NONE;
      uLastHitTestPortion := HTSCROLL_NONE;
      uHitTestPortion := HTSCROLL_NONE;
      Ac_NCDraw(sw, Handle);//, 1, 0);
    end
    else begin
      if uMouseOverScrollbar = SB_HORZ then begin
        uHitTestPortion := Ac_GetHorzPortion(sw.sbarHorz, Handle, MouseOverRect, pt.x, pt.y);
        sbar := sw.sbarHorz;
      end
      else begin
        uHitTestPortion := Ac_GetVertPortion(sw.sbarVert, Handle, MouseOverRect, pt.x, pt.y);
        sbar := sw.sbarVert;
      end;
      if uLastHitTestPortion <> uHitTestPortion then begin
        rect := MouseOverRect;
        Ac_GetRealScrollRect(sbar, rect);
        GetWindowRect(Handle, winrect);
        OffsetRect(rect, -winrect.left, -winrect.top);
        dc := GetWindowDC(Handle);
        Ac_NCDrawScrollbar(sbar, Handle, dc, rect, HTSCROLL_NONE);
        ReleaseDC(Handle, dc);
      end;
      uLastHitTestPortion := uHitTestPortion;
    end;
    Exit;
  end;
  // if the first timer goes off, then we can start a more
  // regular timer interval to auto-generate scroll messages
  // this gives a slight pause between first pressing the scroll arrow, and the
  // actual scroll starting
  if wTimerID = COOLSB_TIMERID1 then begin
    KillTimer(Handle, uScrollTimerId);
    uScrollTimerId := SetTimer(Handle, COOLSB_TIMERID2, COOLSB_TIMERINTERVAL2, nil);
    Result := 0;
  end
  // send the scrollbar message repeatedly
  else
    if wTimerID = COOLSB_TIMERID2 then begin
      // need to process a spoof WM_MOUSEMOVE, so that
      // we know where the mouse is each time the scroll timer goes off.
      // This is so we can stop sending scroll messages if the thumb moves
      // under the mouse.
      GetCursorPos(pt);
      ScreenToClient(Handle, pt);
      if pt.X < 0 then
        pt.X := 0;

      if pt.Y < 0 then
        pt.Y := 0;

      Ac_MouseMove(sw, Handle, MK_LBUTTON, MAKELPARAM(Word(pt.x), Word(pt.y)));
      if uScrollTimerPortion <> HTSCROLL_NONE then begin
        sw.DontRepaint := True;
        SendScrollMessage(Handle, uScrollTimerMsg, uScrollTimerPortion, 0);
        sw.DontRepaint := False;
      end;
      Result := 0;
    end
    else
      if not bCalled then
        Result := sw.CallPrevWndProc(Handle, WM_TIMER, wTimerID, LParam);
end;


destructor TacScrollWnd.Destroy;
begin
  if Assigned(sBarHorz) then
    FreeAndnil(sBarHorz);

  if Assigned(sBarVert) then
    FreeAndnil(sBarVert);

  inherited Destroy;
end;


procedure TacScrollWnd.acWndProc(var Message: TMessage);
var
  i: integer;
  M: TMEssage;
  ListSW: TacScrollWnd;
begin
  case Message.Msg of
{$IFNDEF FPC}
    WM_CONTEXTMENU:
      if (SkinData <> nil) and (SkinData.FOwnerControl <> nil) and (TsAccessControl(SkinData.FOwnerControl).PopupMenu <> nil) then
        if SkinData.SkinManager <> nil then
          SkinData.SkinManager.SkinableMenus.HookPopupMenu(TsAccessControl(SkinData.FOwnerControl).PopupMenu, SkinData.SkinManager.Active);
{$ENDIF}

    WM_UPDATEUISTATE:
      Exit;

    CM_RECREATEWND: begin
{$IFNDEF DELPHI6UP}
      if SkinData.FOwnerControl is TTreeView then // TreeView have a problem under D5
        Exit;
{$ENDIF}
      if not IsWindowVisible(CtrlHandle) and (SkinData.FOwnerControl is TCustomComboBox) and (SkinData.FOwnerControl.Name = '') then
        Exit; // Problem with TDriveComboBox
    end;

    WM_DESTROY, WM_NCDESTROY:
      if not Destroyed then begin
        if SkinData.FOwnerControl is TWinControl then
          with TWinControl(SkinData.FOwnerControl) do
            for i := 0 to ControlCount - 1 do
              if Controls[i] is TSpeedButton then
                Controls[i].Perform(WM_DESTROY, 0, 0);

        if (OldProc <> nil) or Assigned(OldWndProc) then begin
          ListSW := Self;
          try
            if SkinData.FOwnerControl <> nil then begin
              UninitializeACScroll(CtrlHandle, False, False, ListSW);
              Message.Result := TrySendMessage(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
            end
            else begin
              Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
              if Message.Result = 0 then
                UninitializeACScroll(CtrlHandle, False, False, ListSW);
            end;
          finally
            Message.Result := 1;
          end;
        end
        else
          Message.Result := TrySendMessage(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);

        Exit;
      end;
  end;
  if not Destroyed then
    if not Assigned(SkinData) or not SkinData.Skinned then begin
      if Assigned(SkinData) and (Message.Msg = SM_ALPHACMD) then
        case Message.WParamHi of
          AC_SETNEWSKIN:
            if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then
              SkinData.UpdateIndexes;

          AC_GETSKINDATA: begin
            Message.Result := LRESULT(SkinData);
            Exit;
          end;
        end;

      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
    end
    else begin
      case Message.Msg of
        SM_ALPHACMD:
          case Message.WParamHi of
            AC_GETBG:
              if SkinData <> nil then begin
                Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
                if PacBGInfo(Message.LParam).BgType = btUnknown then
                  InitBGInfo(SkinData, PacBGInfo(Message.LParam), 0);

                Exit;
              end;

            AC_GETSCALE: begin
              Message.Result := CurrentScale(SkinData);
              Exit;
            end;

            AC_GETLISTSW: begin
              Message.Result := LResult(Self);
              Exit;
            end;

            AC_CTRLHANDLED: begin
              Message.Result := 1;
              Exit;
            end;

            AC_GETAPPLICATION: begin
              Message.Result := LRESULT(Application);
              Exit;
            end;

            AC_REMOVESKIN:
              if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then
                if not Destroyed then
                  RestoreStdParams;

            AC_SETSECTION: begin
              if (Message.LParam <> 0) and (SkinData <> nil) then begin
                SkinData.SkinSection := PacSectionInfo(Message.LParam).siName;
                Message.Result := 1;
              end
              else
                Message.Result := 0;

              Exit;
            end;

            AC_SETNEWSKIN:
              if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
                SkinData.UpdateIndexes;
                Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
                AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);
                Exit;
              end;

            AC_REFRESH:
              if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
                SkinData.UpdateIndexes;
                SkinData.BGChanged := True;
              end;

            AC_MOUSEENTER: begin
              M := MakeMessage(CM_MOUSEENTER, 0, 0, 0);
              CommonWndProc(M, SkinData);
              Exit;
            end;

            AC_MOUSELEAVE: begin
              M := MakeMessage(CM_MOUSELEAVE, 0, 0, 0);
              CommonWndProc(M, SkinData);
              Exit;
            end;

            AC_UPDATING:
              Skindata.Updating := Message.WParamLo = 1;

            AC_ENDPARENTUPDATE: {if SkinData.FUpdating then ??? }begin
{$IFNDEF ALITE}
  {$IFDEF D2006}
              if SkinData.FOwnerObject is TsFrameAdapter then
{                if (csAligning in TsFrameAdapter(SkinData.FOwnerObject).Frame.ControlState) then} begin
                  Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
                  Exit;
                end;
  {$ENDIF}
{$ENDIF}
              if SkinData.FUpdating then begin
                if not InUpdating(SkinData, True) then begin
//                  InvalidateRect(CtrlHandle, nil, True);
//                  SendMessage(CtrlHandle, WM_ERASEBKGND, 0, 0);
                  RedrawWindow(CtrlHandle, nil, 0, RDWA_ALLNOW);
                  if SkinData.FOwnerControl <> nil then
                    SetParentUpdated(TWinControl(SkinData.FOwnerControl));
                end;
              end
              else
                if (SkinData.CtrlSkinState and ACS_FAST <> 0) and (SkinData.FOwnerControl <> nil) then
                  SetParentUpdated(TWinControl(SkinData.FOwnerControl));

              Exit;
            end;

            AC_GETCONTROLCOLOR: begin
              Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
              if Message.Result = 0 then
                Message.Result := GetBGColor(SkinData, 0);

              Exit;
            end;

            AC_GETSKINDATA: begin
              Message.Result := LRESULT(SkinData);
              Exit;
            end;

            AC_PREPARECACHE: begin
              Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
              if SkinData.BGChanged and not InUpdating(SkinData) then begin
                InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
                PrepareCache(SkinData, CtrlHandle, DlgMode);
                UpdateWndCorners(SkinData, 0, Self);
              end;
              Exit;
            end;

            AC_CHILDCHANGED: begin
              Message.Result := LRESULT(ChildBgIsChanged(SkinData));
              Exit;
            end;
          end;
  {
        CM_UIACTIVATE: if WndSize.cx <> 0 then begin // Hack. Updating of scrollbars after window activation
          Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
          if Message.Result = 0
            then SetWindowPos(CtrlHandle, 0, 0, 0, WndSize.cx, WndSize.cy, SWP_NOMOVE or SWP_NOZORDER or SWP_NOCOPYBITS or SWP_NOSENDCHANGING or SWP_NOREPOSITION or SWP_FRAMECHANGED);
          Exit;
        end;
  }
        WM_NCCALCSIZE: begin
          Message.Result := Ac_NCCalcSize(Self, Self.CtrlHandle, Message.wParam, Message.lParam);
          ScrollsInitialized := True;
          Exit;
        end;

        WM_NCPAINT: begin
          if not ScrollsInitialized then
            SetWindowPos(CtrlHandle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);

          if IsWindowVisible(CtrlHandle) and not InUpdating(SkinData) and not DontRepaint and ScrollsInitialized then
            Message.Result := LRESULT(Ac_NCDraw(Self, CtrlHandle));//, Message.WParam, Message.LParam));
        end;

        WM_NCRBUTTONDOWN, WM_NCRBUTTONUP, WM_NCMBUTTONDOWN, WM_NCMBUTTONUP:
          if Message.wParam in [HTHSCROLL, HTVSCROLL] then begin
            Message.Result := 0;
            Exit;
          end;

        WM_NCLBUTTONDBLCLK: if Message.wParam in [HTHSCROLL, HTVSCROLL] then begin
          Message.Result := Ac_NCLButtonDown(Self, CtrlHandle, Message.wParam, Message.lParam);
          Exit;
        end;

        WM_NCHITTEST: begin
          Message.Result := Ac_NCHitTest(Self, CtrlHandle, Message.WParam, Message.LParam);
          Exit;
        end;

        WM_NCLBUTTONDOWN: if Message.wParam in [HTHSCROLL, HTVSCROLL] then begin
          Message.Result := Ac_NCLButtonDown(Self, CtrlHandle, Message.wParam, Message.lParam);
          Exit;
        end;

        WM_LBUTTONUP: begin
          Message.Result := Ac_LButtonUp(Self, CtrlHandle, Message.WParam, Message.LParam);
          Exit;
        end;

        WM_NOTIFY: begin
          Message.Result := Ac_Notify(Self, CtrlHandle, Message.WPAram, Message.LParam);
          Exit;
        end;

        WM_MOUSEMOVE: begin
          Message.Result := Ac_MouseMove(Self, CtrlHandle, Message.WPAram, Message.LParam);
          Exit;
        end;

        WM_TIMER: begin
          Message.Result := Ac_Timer(Self, CtrlHandle, Message.WPAram, Message.LParam);
          if not DontRepaint and not fThumbTracking then
            UpdateScrolls(Self, True);

          Exit;
        end;

        WM_STYLECHANGED: begin
          if bPreventStyleChange then // the NCPAINT handler has told us to eat this message!
            Message.Result := 0
          else
            Message.Result := Ac_StyleChange(Self, CtrlHandle, Message.WPAram, Message.LParam);

          Exit;
        end;

        WM_NCMOUSEMOVE: begin
          Message.Result := Ac_NCMouseMove(Self, CtrlHandle, Message.WPAram, Message.LParam);
          Exit;
        end;

        WM_SYSCOMMAND:
          if Message.WParamlo = 61559 then
            Exit; // Prevent of standard scrollbar showing after wnd activation
      end;
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      case Message.Msg of
        WM_MOUSEWHEEL, CM_MOUSEWHEEL:
          if not DontRepaint then
            UpdateScrolls(Self, True);

        CM_FOCUSCHANGED:
          UpdateScrolls(Self, True);
      end;
    end;
end;


procedure TacEditWnd.acWndProc(var Message: TMessage);
var
  DC, SavedDC: hdc;
  PS: TPaintStruct;
  R: TRect;

  procedure EmulPaint;
  begin
    BeginPaint(CtrlHandle, {$IFDEF FPC}@PS{$ELSE}PS{$ENDIF});
    EndPaint(CtrlHandle, {$IFDEF FPC}@PS{$ELSE}PS{$ENDIF});
  end;

begin
{$IFDEF LOGGED}
//  if (SkinData <> nil) {and (SkinData.FOwnerControl.Tag = 1) }then
//    AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end;
    end;

  if not Assigned(SkinData) or not SkinData.Skinned then begin
    inherited acWndProc(Message);
    Exit;
  end;

  case Message.Msg of
    SM_ALPHACMD:
      if HandleAlphaCmd(Message) then
        Exit;

//    WM_USER + 68{EM_SETCHARFORMAT}: // Prevent of OnChange event calling in RichEdit
//      if SkinData.Updating then Exit;

    WM_PRINT: begin
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      if Message.Result = 2 then
        Exit; // Processed already

      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      SkinData.Updating := False;
      SkinData.BGChanged := True;
      DC := TWMPaint(Message).DC;
      if not ParamsChanged then
        SetSkinParams;

      if SkinData = nil then
        Exit;

      PrepareCache(SkinData, CtrlHandle, DlgMode);
      if not DlgMode then
        UpdateWndCorners(SkinData, 0, Self);

      if PRF_CLIENT and Message.LParam <> 0 then begin // Patch for using with BE
        MoveWindowOrg(DC, -cxLeftEdge, -cxLeftEdge);
        IntersectClipRect(DC, 0, 0, SkinData.FCacheBmp.Width - cxLeftEdge, SkinData.FCacheBmp.Height - cxLeftEdge);
      end
      else begin
        BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, cxLeftEdge);
        Message.Result := Ac_NCDraw(Self, Self.CtrlHandle, -1, DC);
      end;

      SavedDC := SaveDC(DC);
      MoveWindowOrg(DC, cxLeftEdge, cxLeftEdge);
      if (sBarVert <> nil) and (sBarHorz <> nil) then
        IntersectClipRect(DC, 0, 0,
                          SkinData.FCacheBmp.Width  - 2 * cxLeftEdge - integer(sBarVert.fScrollVisible) * GetScrollMetric(sBarVert, SM_SCROLLWIDTH),
                          SkinData.FCacheBmp.Height - 2 * cxLeftEdge - integer(sBarHorz.fScrollVisible) * GetScrollMetric(sBarHorz, SM_SCROLLWIDTH));

      if IsCached(SkinData) then
        with SkinData.FCacheBmp do
          if PRF_CLIENT and Message.LParam <> 0 then // Patch for using with BE
            BitBlt(DC, 0, 0, Width, Height, Canvas.Handle, 0, 0, SRCCOPY)
          else
            BitBlt(DC, 0, 0, Width, Height, Canvas.Handle, cxLeftEdge, cxLeftEdge, SRCCOPY)
      else
        FillDC(DC, MkRect(WndSize), Color);

{$IFNDEF D2005}
      if SkinData.FOwnerControl is TCustomListBox then begin // Fix empty ListBox drawing bug, fixed in latest Delphi versions
        if TCustomListBox(SkinData.FOwnerControl).Items.Count <> 0 then
          TrySendMessage(CtrlHandle, WM_PAINT, WPARAM(DC), 0);
      end
      else
{$ENDIF}
        TrySendMessage(CtrlHandle, WM_PAINT, WPARAM(DC), 0);

      TrySendMessage(CtrlHandle, WM_PRINTCLIENT, WPARAM(DC), PRF_CLIENT or PRF_OWNED);
      RestoreDC(DC, SavedDC);
      if not (SkinData.COC in [COC_TsListView]) then
        Exit;
    end;

    WM_SETTEXT, CM_ENABLEDCHANGED, CM_FONTCHANGED: begin
      Skindata.BGChanged := True;
      if SkinData.CtrlSkinState and ACS_CHANGING = 0 then begin
        if not SkinData.FUpdating then
          RedrawWindow(CtrlHandle, nil, 0, RDWA_REPAINT);
      end;{
      else
        Exit;}
    end;

    WM_ERASEBKGND:
      if IsWindowVisible(CtrlHandle) and not bPreventStyleChange then begin
        if (TWMPaint(Message).DC <> SkinData.PrintDC) and (GetClipBox(TWMPaint(Message).DC, R) = NULLREGION) then begin
          Message.Result := ERASE_OK;
          Exit;
        end;
        if InUpdating(SkinData) then
          Exit;

        if not ParamsChanged then
          SetSkinParams;

        if SingleLineEdit and not IsWindowEnabled(CtrlHandle) then begin
          Message.Result := ERASE_OK;
          Exit;
        end
        else
          if (Win32MajorVersion >= 6) and InAnimationProcess and (TWMPaint(Message).DC <> SkinData.PrintDC) then begin
            Message.Result := ERASE_OK;
            Exit;
          end;
      end;

    WM_PAINT:
      if IsWindowVisible(CtrlHandle) and not bPreventStyleChange then begin
        if (TWMPaint(Message).DC <> SkinData.PrintDC) and (GetClipBox(TWMPaint(Message).DC, R) = NULLREGION) then begin
          EmulPaint;
          Exit;
        end;
        if SingleLineEdit and not IsWindowEnabled(CtrlHandle) then begin
          BeginPaint(CtrlHandle, {$IFDEF FPC}@PS{$ELSE}PS{$ENDIF});
          DC := GetWindowDC(CtrlHandle);
          SavedDC := SaveDC(DC);
          try
            BitBlt(DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
          finally
            RestoreDC(DC, SavedDC);
            ReleaseDC(CtrlHandle, DC);
          end;
          EndPaint(CtrlHandle, {$IFDEF FPC}@PS{$ELSE}PS{$ENDIF});
          Exit;
        end;
        if InUpdating(SkinData) or InAnimationProcess and (SkinData.PrintDC = 0) then begin
          EmulPaint;
          Exit;
        end
        else
          Message.Result := Ac_NCDraw(Self, Self.CtrlHandle, -1, hdc(Message.wParam));

        if not ParamsChanged then
          SetSkinParams;
      end;

    WM_SETREDRAW:
      if (Message.WParam = 1) and CtrlListChanged then begin
        AddToAdapter(TWinControl(SkinData.FOwnerControl));
        CtrlListChanged := False;
      end;

    WM_NCPAINT:
      if IsWindowVisible(CtrlHandle) and not bPreventStyleChange then begin
        if not InAnimationProcess then begin
          InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
          if InUpdating(SkinData) then
            Exit;

          DC := GetWindowDC(CtrlHandle);
          if (DC <> SkinData.PrintDC) and (GetClipBox(DC, R) = NULLREGION) then begin
            ReleaseDC(CtrlHandle, DC);
            Exit;
          end;
          if SkinData.BGChanged then begin
            if not ParamsChanged then
              SetSkinParams;

            PrepareCache(SkinData, CtrlHandle, DlgMode);
          end;
          SavedDC := SaveDC(DC);
          try
            Message.Result := Ac_NCDraw(Self, Self.CtrlHandle, -1, DC);
            if (DC <> 0) and (SkinData <> nil) then begin
//{$IFNDEF DELPHI7UP}
              if cxLeftEdge < 0 then
                cxLeftEdge := 2;
//{$ENDIF}
              BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, max(0, cxLeftEdge))
            end;
          finally
            RestoreDC(DC, SavedDC);
            ReleaseDC(CtrlHandle, DC);
          end;
        end;
        Exit;
      end;

    WM_SETFOCUS, WM_KILLFOCUS: begin
      if MayBeHot(SkinData, False) and (Skindata.FOwnerControl is TWinControl) and TWinControl(Skindata.FOwnerControl).CanFocus and TWinControl(Skindata.FOwnerControl).TabStop then begin
        Skindata.BGChanged := True;
        Skindata.FFocused := WM_SETFOCUS = Message.Msg;
        inherited acWndProc(Message);
        SetSkinParams;
        RedrawWindow(CtrlHandle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE or RDW_FRAME);
      end
      else
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);

      Exit;
    end;
  end;
  inherited acWndProc(Message);
  case Message.Msg of
    CM_CONTROLLISTCHANGE:
      CtrlListChanged := True;

    WM_PARENTNOTIFY:
      if Message.WParamLo in [WM_CREATE, WM_DESTROY] then
        if (Message.WParamLo = WM_CREATE) and (srThirdParty in SkinData.SkinManager.SkinningRules) then
          CtrlListChanged := True;

    LB_GETTOPINDEX: // Fix of empty ListBox drawing bug
      if SkinData.FOwnerControl is TCustomListBox then
        if (Message.Result = 0) and (TCustomListBox(SkinData.FOwnerControl).Items.Count = 0) then
          Message.Result := -1;

    LB_SETCURSEL:
      UpdateScrolls(Self, True);

    LB_INSERTSTRING, LB_SETTOPINDEX, EM_REPLACESEL, LB_ADDSTRING:
      UpdateScrolls(Self, True);

    WM_SETFONT, WM_KEYDOWN, WM_KEYUP, CN_KEYDOWN, CN_KEYUP, WM_LBUTTONDOWN:
      if not DontRepaint then
        UpdateScrolls(Self, True);

    CM_MOUSEENTER, CM_MOUSELEAVE:
      if SkinData <> nil then
        CommonWndProc(Message, SkinData);

    WM_SIZE:
      if IsWindowVisible(CtrlHandle) then
        ProcessMessage(WM_NCPAINT, 0, 0);
//        SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);

    WM_MOUSEMOVE:
      if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) and IsWindowEnabled(CtrlHandle) then begin
        if DefaultManager.ActiveControl <> CtrlHandle then
          DefaultManager.ActiveControl := CtrlHandle;

        if not SkinData.Updating and (GetCapture <> 0) then
          UpdateScrolls(Self, True); // For ImageEn and similar products
      end;
  end;
end;


function TacEditWnd.ClientRect: TRect;
begin
  if FClientRect.Top = -1 then // Not initialized
    FClientRect := ACClientRect(CtrlHandle);

  Result := FClientRect;
end;


constructor TacEditWnd.Create(AHandle: hwnd; ASkinData: TsCommonData; ASkinManager: TsSkinManager; const SkinParams: TacSkinParams; Repaint: boolean);
begin
  if aHandle <> 0 then begin
    if (Repaint or not (Self is TacComboListWnd)) and
         not (Self is TacGridWnd) and
           not (Self is TacVirtualTreeViewWnd) and
             (uxthemeLib <> 0) and
               (SkinParams.SkinSection <> s_Dialog) then
      if ASkinData = nil then begin
        if (Win32MajorVersion < 6) or (SkinParams.SkinSection = s_ComboBox) then
          Ac_SetWindowTheme(AHandle, s_Space, s_Space) // Don't touch win themes in dialogs
      end
      else
        if not ((ASkinData.COC in [COC_TsListView{, COC_TsTreeView}]) and (Win32MajorVersion >= 6)) then
          if ASkinData.FOwnerControl <> nil then begin
            if not HasProperty(ASkinData.FOwnerControl, 'UseXPThemes') then
              Ac_SetWindowTheme(AHandle, s_Space, s_Space); // Patch for TRichViewEdit control
          end
          else
            Ac_SetWindowTheme(AHandle, s_Space, s_Space);

    CtrlHandle := AHandle;
    FClientRect.Top := -1;
    NewWndProcInstance := nil;
    SkinManager := ASkinManager;
    Destroyed := False;
    if ASkinData <> nil then
      SkinData := TsScrollWndData(ASkinData)
    else begin
      OwnSkinData := True;
      InitSkinData;
      with SkinData as TsScrollWndData do begin
        if SkinParams.SkinSection <> '' then
          SkinData.SkinSection := SkinParams.SkinSection;

        SkinData.FOwnerControl := SkinParams.Control;
        if (SkinData.FOwnerControl <> nil) and HasProperty(SkinData.FOwnerControl, 'PanelBorder') then // If TDBCtrlGrid
          SkinData.SkinSection := s_Transparent;

        SkinData.FOwnerObject := TObject(SkinParams.Control);
        SkinData.CustomFont := not SkinParams.UseSkinFontColor;
        SkinData.CustomColor := not SkinParams.UseSkinColor;
        if SkinParams.HorzScrollBtnSize >= 0 then
          HorzScrollData.ButtonsSize := SkinParams.HorzScrollBtnSize;

        if SkinParams.VertScrollBtnSize >= 0 then
          VertScrollData.ButtonsSize := SkinParams.VertScrollBtnSize;

        if SkinParams.HorzScrollSize >= 0 then
          HorzScrollData.ScrollWidth := SkinParams.HorzScrollSize;

        if SkinParams.VertScrollSize >= 0 then
          VertScrollData.ScrollWidth := SkinParams.VertScrollSize;
      end;
    end;
    SkinData.CustomFont := ac_KeepOwnFont or SkinData.CustomFont;
    if OwnSkinData then
      SkinData.COC := COC_TsAdapterEdit;

    if (SkinData.SkinSection = '') and (SkinData.COC > COC_TsAdapter) then
      if SkinParams.SkinSection = ''  then
        SkinData.SkinSection := s_Edit
      else
        SkinData.SkinSection := SkinParams.SkinSection;

    SaveStdParams;
    ParamsChanged := False;
    DlgMode := acDlgMode;
    InitializeACScrolls(Self, AHandle, Repaint);
    if SkinData.FOwnerControl <> nil then begin
      OldCtrlStyle := SkinData.FOwnerControl.ControlStyle;
      SingleLineEdit := (SkinData.FOwnerControl is TCustomEdit) and (GetWindowLong(CtrlHandle, GWL_STYLE) and ES_MULTILINE = 0);
      if not (SkinData.FOwnerControl is TCustomListView) then
        SkinData.FOwnerControl.ControlStyle := SkinData.FOwnerControl.ControlStyle + [csOpaque];
    end
    else
      SingleLineEdit := False;
  end;
  CtrlListChanged := False;
  AfterCreation;
end;


function TacEditWnd.HandleAlphaCmd(var Message: TMessage): boolean;
begin
  Result := False;
  case Message.WParamHi of
    AC_CTRLHANDLED: begin
      Message.Result := 1;
      Result := True;
    end;

    AC_GETAPPLICATION: begin
      Message.Result := LRESULT(Application);
      Result := True;
    end;

    AC_SETSCALE: begin
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      Result := CommonMessage(Message, SkinData);
      Exit;
    end;

    AC_ENDPARENTUPDATE:
      if SkinData.FUpdating then
        if not InUpdating(SkinData, True) then
          RedrawWindow(CtrlHandle, nil, 0, RDWA_ALLNOW);

    AC_PREPARECACHE: begin
      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      PrepareCache(SkinData, CtrlHandle, DlgMode);
      UpdateWndCorners(SkinData, 0, Self);
      Result := True;
    end;

    AC_GETSKININDEX: begin
      PacSectionInfo(Message.LParam)^.siSkinIndex := SkinData.SkinIndex;
      Result := True;
    end;

    AC_REFRESH:
      if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
        inherited acWndProc(Message);
        if SkinData <> nil then
          SetSkinParams;
      end;

    AC_BEFORESCROLL: begin
      if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_LEFTSCROLLBAR <> 0 then
        TrySendMessage(CtrlHandle, WM_SETREDRAW, 0, 0)
      else
        inherited acWndProc(Message);

      Result := True;
    end;

    AC_AFTERSCROLL: begin
      if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_LEFTSCROLLBAR <> 0 then begin
        TrySendMessage(CtrlHandle, WM_SETREDRAW, 1, 0);
        InvalidateRect(CtrlHandle, nil, True);
      end
      else
        inherited acWndProc(Message);

      Result := True;
    end;

    AC_GETBG:
      if SkinData <> nil then begin
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        with PacBGInfo(Message.LParam)^ do begin
          if BgType = btUnknown then
            if SkinData.CustomColor then begin // Used in ComboListWnd and similar windows
              BgType := btFill;
              if SkinData.FOwnerControl <> nil then
                Color := TsAccessControl(SkinData.FOwnerControl).Color
              else
                Color := Self.Color;
            end
            else
              InitBGInfo(SkinData, PacBGInfo(Message.LParam), 0);

          inc(Offset.X, cxLeftEdge);
          inc(Offset.Y, cyTopEdge);
        end;
        Result := True;
      end;

    else
      Result := CommonMessage(Message, SkinData);
  end;
end;


type
  TsAccessGrid = class(TCustomGrid);


procedure TacEditWnd.RestoreStdParams;
var
  TempOnChange: TNotifyEvent;
begin
  inherited;
  if Assigned(SkinData) then
    with SkinData do begin
{$IFDEF D2010}
      if FOwnerControl is TCustomGrid then begin
        TsAccessGrid(FOwnerControl).DrawingStyle       := DrawingStyle;
        TsAccessGrid(FOwnerControl).GradientStartColor := FixedGradientFrom;
        TsAccessGrid(FOwnerControl).GradientEndColor   := FixedGradientTo;
      end;
{$ENDIF}
      if Assigned(FOwnerControl) and not (csDestroying in FOwnerControl.ComponentState) then begin
        if SkinData.CustomColor then
//          TsAccessControl(FOwnerControl).Color := StdColor
        else
          TsAccessControl(FOwnerControl).Color := clWindow;

        CtrlSkinState := CtrlSkinState or ACS_CHANGING;
        TempOnChange := TsAccessControl(FOwnerControl).Font.OnChange;
        TsAccessControl(FOwnerControl).Font.OnChange := nil; // Prevent a recreating of some controls
        if SkinData.CustomFont then
//          TsAccessControl(FOwnerControl).Font.Color := StdFontColor
        else
          TsAccessControl(FOwnerControl).Font.Color := clWindowText;

        TsAccessControl(FOwnerControl).Font.OnChange := TempOnChange;

        CtrlSkinState := CtrlSkinState and not ACS_CHANGING;

        if (SkinData <> nil) and HasProperty(SkinData.FOwnerControl, acFocusColor) then
          SetIntProp(SkinData.FOwnerControl, acFocusColor, FocusColor);
      end;
      if IsWindowVisible(CtrlHandle) and not (csDestroying in FOwnerControl.ComponentState) then // Scrollbars updating if exists
        SetWindowPos(CtrlHandle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);
    end;
end;


procedure TacEditWnd.SaveStdParams;
begin
  inherited;
{$IFDEF D2010}
  if SkinData.FOwnerControl is TCustomGrid then begin
    DrawingStyle      := TsAccessGrid(SkinData.FOwnerControl).DrawingStyle;
    FixedGradientFrom := TsAccessGrid(SkinData.FOwnerControl).GradientStartColor;
    FixedGradientTo   := TsAccessGrid(SkinData.FOwnerControl).GradientEndColor;
  end;
{$ENDIF}
  if Assigned(SkinData) and Assigned(SkinData.FOwnerControl) then begin
    StdColor := TsAccessControl(SkinData.FOwnerControl).Color;
    StdFontColor := TsAccessControl(SkinData.FOwnerControl).Font.Color;
    if HasProperty(SkinData.FOwnerControl, acFocusColor) then
      FocusColor := GetIntProp(SkinData.FOwnerControl, acFocusColor);
  end
end;


procedure TacEditWnd.SetSkinParams;
var
  C: TColor;
  b: boolean;
begin
  if not bPreventStyleChange then begin
    if Assigned(SkinData) then
      SkinData.Updating := True;

    bPreventStyleChange := True;
    inherited;
{$IFDEF D2010}
    if SkinData.FOwnerControl is TCustomGrid then begin
      if DrawingStyle <> gdsClassic then
        TsAccessGrid(SkinData.FOwnerControl).DrawingStyle := gdsGradient;

      TsAccessGrid(SkinData.FOwnerControl).GradientStartColor := BlendColors(SkinData.SkinManager.GetGlobalColor, SkinData.SkinManager.GetActiveEditColor, 127);
      TsAccessGrid(SkinData.FOwnerControl).GradientEndColor := SkinData.SkinManager.GetGlobalColor;
    end;
{$ENDIF}
    if Assigned(SkinData) and Assigned(SkinData.SkinManager) and SkinData.SkinManager.IsValidSkinIndex(SkinData.SkinIndex) then begin
      if Assigned(SkinData.FOwnerControl) then begin // If VCL used
        if ControlIsActive(SkinData) then
          b := SkinData.SkinManager.gd[SkinData.SkinIndex].States > 1
        else
          b := False;

        if not SkinData.CustomColor then begin
          C := GetBGColor(SkinData, integer(b));
          if HasProperty(SkinData.FOwnerControl, acFocusColor) then begin
            if TsAccessControl(SkinData.FOwnerControl).Color <> C then
              SetIntProp(SkinData.FOwnerControl, acColor, C);

            SetIntProp(SkinData.FOwnerControl, acFocusColor, C);
          end
          else
            if TsAccessControl(SkinData.FOwnerControl).Color <> C then
              TsAccessControl(SkinData.FOwnerControl).Color := C;

          Color := C;
        end;
        if not SkinData.CustomFont then begin
          C := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[integer(b)].FontColor.Color;
          if TsAccessControl(SkinData.FOwnerControl).Font.Color <> C then begin
            SkinData.CtrlSkinState := SkinData.CtrlSkinState or ACS_CHANGING;
            TsAccessControl(SkinData.FOwnerControl).Font.Color := C;
            SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_CHANGING;
            if Destroyed then
              Exit;
          end;
        end
      end
      else begin
        if not SkinData.CustomColor then
          if not DlgMode then
            Color := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Color
          else
            Color := ColorToRGB(clWindow);

        FrameColor := SkinData.SkinManager.Palette[pcBorder];
      end;
      if SkinData <> nil then begin
        SkinData.BGChanged := True;
        SkinData.Updating := False;
      end;
    end
    else
      FrameColor := clBlack;

    bPreventStyleChange := False;
  end;
end;


type
  TacAccessLV = class(TListView);


procedure TacListViewWnd.acWndProc(var Message: TMessage);
var
  R: TRect;
  M: TMessage;
  SavedDC: hdc;
  WndName: string;
  DstPos, Delta: integer;
begin
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_GETSKININDEX: begin
          PacSectionInfo(Message.LParam)^.siSkinIndex := SkinData.SkinIndex;
          Exit;
        end;

        AC_REFRESH:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            inherited;
            M := MakeMessage(WM_PAINT, 0, 0, 0);
            HeaderWndProc(M);
            Exit;
          end;

        AC_BEFORESCROLL: begin
          Message.Result := 1; // it's a listview
          Exit;
        end

        else
          CommonMessage(Message, SkinData);
      end;

    WM_NCPAINT: begin
      Message.Result := 0;
      inherited;
    end;

    WM_NCHITTEST:
      if (HoverColIndex >= 0) or (FPressedColumn >= 0) then begin
        HoverColIndex := -1;
        FPressedColumn := -1;
        PaintHeader(0);
      end;

    WM_VSCROLL: begin
      if Message.WParamLo = SB_THUMBTRACK then begin
        DstPos := iff(Message.LParam <> 0, Message.LParam, Message.WParamHi);
        if nLastSBPos <> DstPos then begin // If CurPos is changed
          Delta := DstPos - nLastSBPos;
          if (ViewStyle = vsReport) and (SendMessage(CtrlHandle, LVM_FIRST + 175 {LVM_ISGROUPVIEWENABLED}, 0, 0) = 0) then begin
            ListView_GetItemRect(CtrlHandle, 0, R, LVIR_BOUNDS);
            Delta := Delta * HeightOf(R);
          end;
          ListView_Scroll(CtrlHandle, 0, Delta);
        end
      end
      else begin
        Message.LParam := 0;
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      end;
      Exit;
    end;

    WM_PRINT: begin
      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      if not ParamsChanged then
        SetSkinParams;
        
      FillDC(TWMPaint(Message).DC, MkRect(WndSize), Color);
    end;

    WM_HSCROLL: begin
      case Message.WParamLo of
        SB_THUMBTRACK: begin
          DstPos := iff(Message.LParam <> 0, Message.LParam, Message.WParamHi);
          Delta := DstPos - nLastSBPos;
          if ViewStyle = vsList then begin
            ListView_GetItemRect(CtrlHandle, 0, R, LVIR_BOUNDS);
            Delta := Delta * WidthOf(R);
          end;
          ListView_Scroll(CtrlHandle, Delta, 0);
        end

        else
          Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      end;
      Exit;
    end;

    WM_PAINT:
      SetSkinParams;
  end;
  inherited acWndProc(Message);
  case Message.Msg of
    WM_SIZE: begin
      SkinData.BGChanged := True;
      PrepareCache(SkinData, CtrlHandle, DlgMode);
      InvalidateRect(CtrlHandle, nil, True);
    end;

    WM_LBUTTONUP:
      ReleaseCapture;

    LVM_ARRANGE, WM_STYLECHANGED:
      if not SkinData.Updating then
        UpdateScrolls(Self, True);

    WM_PRINT:
      if ViewStyle = vsReport then begin
        SavedDC := SaveDC(TWMPaint(Message).DC);
        MoveWindowOrg(TWMPaint(Message).DC, cxLeftEdge, cxLeftEdge);
        IntersectClipRect(TWMPaint(Message).DC, 0, 0,
                          SkinData.FCacheBmp.Width  - 2 * cxLeftEdge - integer(sBarVert.fScrollVisible) * GetScrollMetric(sBarVert, SM_SCROLLWIDTH),
                          SkinData.FCacheBmp.Height - 2 * cxLeftEdge - integer(sBarHorz.fScrollVisible) * GetScrollMetric(sBarHorz, SM_SCROLLWIDTH));
        PaintHeader(TWMPaint(Message).DC);
        RestoreDC(TWMPaint(Message).DC, SavedDC);
      end;

    WM_PARENTNOTIFY:
      with TWMParentNotify(Message) do begin
        SetLength(WndName, 96);
        SetLength(WndName, GetClassName(ChildWnd, PChar(WndName), Length(WndName)));
        if WndName = WC_HEADER then
          case Event of
            WM_CREATE:
              if FhWndHeader <> 0 then begin
                SetWindowLong(FhWndHeader, GWL_WNDPROC, LONG_PTR(FhDefHeaderProc));
                FhWndHeader := 0;
              end
              else begin
                FhWndHeader := ChildWnd;
                FhDefHeaderProc := Pointer(GetWindowLong(FhWndHeader, GWL_WNDPROC));
                SetWindowLong(FhWndHeader, GWL_WNDPROC, LONG_PTR(FhHeaderProc));
              end;
          end;
      end;

    LVM_INSERTITEMA:
      if not SkinData.Updating then
        UpdateScrolls(Self, True);

    WM_KILLFOCUS, WM_SETFOCUS:
      SetSkinParams;
  end;
end;


procedure TacListViewWnd.AfterCreation;
var
  Wnd: HWND;
begin
  if SkinData <> nil then
    SkinData.COC := COC_TsListView; // Prevent a disabling of native themes

  inherited;
  HoverColIndex := -1;
  FhHeaderProc := {$IFDEF DELPHI7UP}Classes.{$ENDIF}MakeObjectInstance(HeaderWndProc);
  Wnd := FindWindowEx(CtrlHandle, 0, WC_HEADER{'SysHeader32'}, nil);
  FPressedColumn := -1;
  if Wnd <> 0 then
    if FhWndHeader = 0 then begin
      FhWndHeader := Wnd;
      FhDefHeaderProc := Pointer(GetWindowLong(FhWndHeader, GWL_WNDPROC));
      SetWindowLong(FhWndHeader, GWL_WNDPROC, LONG_PTR(FhHeaderProc));
    end;
end;


function TacListViewWnd.AutoSizedCols: boolean;
var
  i: integer;
begin
  if SkinData.FOwnerControl is TCustomListView then
    with TListView(SkinData.FOwnerControl) do
      for i := 0 to Columns.Count - 1 do
        if Columns[i].AutoSize then begin
          Result := True;
          Exit;
        end;

  Result := False;
end;


procedure TacListViewWnd.ColumnSkinPaint(ControlRect: TRect; cIndex: Integer; DC: hdc);
const
  HDF_SORTDOWN = $0200;
  HDF_SORTUP   = $0400;
var
  C: TColor;
  tmpdc: HDC;
  ws: acString;
  CI: TCacheInfo;
  ArrowSide: TacSide;
  R, gR, TextRC: TRect;
  ts, ArrowSize: TSize;
  OldFont, NewFont: hFont;
  TempBmp: Graphics.TBitmap;
  Buf: array [0..1023] of acChar;
  Flags, gWidth, State, si, ArrowIndex: integer;
{$IFDEF TNTUNICODE}
  Item: THDItemW;
{$ELSE}
  Item: THDItem;
{$ENDIF}
begin
  try
    TempBmp := CreateBmp32(ControlRect);
    R := MkRect(TempBmp);
    if FPressedColumn >= 0 then
      State := iff(FPressedColumn = cIndex, 2, 0)
    else
      State := integer(HoverColIndex = cIndex);

    CI.Ready := False;
    if SkinData.FOwnerControl <> nil then
      CI.FillColor := TacAccessLV(SkinData.FOwnerControl).Color
    else
      CI.FillColor := ColorToRGB(clWindow);

    si := PaintSection(TempBmp, SkinData.SkinManager.ConstData.Sections[ssColHeader], SkinData.SkinManager.ConstData.Sections[ssButton], State, SkinData.SkinManager, ControlRect.TopLeft, CI.FillColor);
    NewFont := LongWord(SendMessage(CtrlHandle, WM_GETFONT, 0, 0));
    if NewFont <> 0 then
      OldFont := SelectObject(TempBmp.Canvas.Handle, NewFont)
    else
      OldFont := 0;

    TextRC := R;
    InflateRect(TextRC, -4, -1);
    TempBmp.Canvas.Brush.Style := bsClear;
    FillChar(Item, SizeOf(Item), 0);
    FillChar(Buf, SizeOf(Buf), 0);
    Item.pszText := PacChar(@Buf);
    Item.cchTextMax := SizeOf(Buf);
    Item.Mask := HDI_TEXT or HDI_FORMAT or HDI_IMAGE or HDI_BITMAP or HDI_ORDER;
    if (cIndex >= 0) and bool(SendMessage(FHwndHeader, {$IFDEF TNTUNICODE}HDM_GETITEMW{$ELSE}HDM_GETITEM{$ENDIF}, cIndex, LPARAM(@Item))) then begin
      ws := acString(Item.pszText);
      Flags := DT_END_ELLIPSIS or DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER;
      if (SkinData.FOwnerControl = nil) or (TacAccessLV(SkinData.FOwnerControl).SmallImages = nil) or (Item.fmt and (LVCFMT_IMAGE or LVCFMT_COL_HAS_IMAGES) = 0) then begin
{$IFNDEF FPC}
        Item.iImage := -1;
{$ENDIF}
        gWidth := 0;
      end
      else
        gWidth := TacAccessLV(SkinData.FOwnerControl).SmallImages.Width + 4;

      if item.fmt and HDF_SORTDOWN = HDF_SORTDOWN then begin
        ArrowSide := asBottom;
        ArrowIndex := SkinData.SkinManager.ConstData.ScrollBtns[ArrowSide].GlyphIndex;
      end
      else
        if item.fmt and HDF_SORTUP = HDF_SORTUP then begin
          ArrowSide := asTop;
          ArrowIndex := SkinData.SkinManager.ConstData.ScrollBtns[ArrowSide].GlyphIndex;
        end
        else begin
          ArrowSide := asLeft;
          ArrowIndex := -2;
        end;

      if ArrowIndex <> -2 then
        if ArrowIndex >= 0 then
          ArrowSize := MkSize(SkinData.SkinManager.ma[ArrowIndex].Width + 6, SkinData.SkinManager.ma[ArrowIndex].Height)
        else
          ArrowSize := MkSize(6, 3)
      else
        ArrowSize := MkSize;
{$IFDEF TNTUNICODE}
      GetTextExtentPoint32W(TempBmp.Canvas.Handle, PacChar(ws), Length(ws), ts);
{$ELSE}
      GetTextExtentPoint32(TempBmp.Canvas.Handle, PacChar(ws), Length(ws), ts);
{$ENDIF}
      inc(ts.cx, 5);
      case Item.fmt and $0ff of
        HDF_CENTER: begin
          TextRc.Left := (WidthOf(TextRc) - ts.cx - ArrowSize.cx - gWidth) div 2 + TextRc.Left + gWidth;
          TextRc.Right := TextRc.Left + ts.cx;
        end;
        HDF_RIGHT: begin
          TextRc.Right := TextRc.Right - ArrowSize.cx;
          TextRc.Left := TextRc.Right - ts.cx;
        end
        else begin
          TextRc.Left := TextRc.Left + gWidth;
          TextRc.Right := TextRc.Left + ts.cx;
        end
      end;
      if ArrowIndex >= 0 then
        DrawSkinGlyph(TempBmp, Point(TextRc.Right + 6, (HeightOf(TextRc) - ArrowSize.cy) div 2), State, 1, SkinData.SkinManager.ma[ArrowIndex], MakeCacheInfo(TempBmp))
      else
        if ArrowIndex = -1 then begin
          gR.Left := TextRc.Right + 6;
          gR.Top := (HeightOf(TextRc) - ArrowSize.cy) div 2;
          gR.Right := gR.Left + 6;
          gR.Bottom := gR.Top + 3;
          C := SkinData.SkinManager.gd[si].Props[min(State, ac_MaxPropsIndex)].FontColor.Color;
          DrawColorArrow(TempBmp, C, gR, ArrowSide);
        end;

      if State = 2 then
        if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
          OffsetRect(TextRc, 1, 1);

      acWriteTextEx(TempBmp.Canvas, PacChar(ws), True, TextRc, Flags, si, State <> 0, SkinData.SkinManager);
{$IFNDEF FPC}
      if (item.iImage > 0) and (SkinData.FOwnerControl <> nil) then
        TacAccessLV(SkinData.FOwnerControl).SmallImages.Draw(TempBmp.Canvas, TextRc.Left - gWidth, (HeightOf(TextRc) - TacAccessLV(SkinData.FOwnerControl).SmallImages.Height) div 2 + integer(State = 2), Item.iImage, TacAccessLV(SkinData.FOwnerControl).Enabled);
{$ENDIF}
    end;
    if OldFont <> 0 then
      SelectObject(TempBmp.Canvas.Handle, OldFont);

    if DC = 0 then
      tmpdc := GetDC(FhWndHeader)
    else
      tmpdc := DC;

    try
      BitBlt(tmpdc, ControlRect.Left, ControlRect.Top, R.Right, R.Bottom, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
    finally
      if DC = 0 then
        ReleaseDC(FhWndHeader, tmpdc);
    end;
    FreeAndNil(TempBmp);
  except
    Application.HandleException(Self);
  end;
end;


function TacListViewWnd.GetHeaderColumnRect(Index: Integer): TRect;
var
  rc: TRect;
  SectionOrder: array of Integer;
begin
  if GetWindowLong(FhWndHeader, GWL_STYLE) and HDS_FULLDRAG <> 0 then begin
    SetLength(SectionOrder, Header_GetItemCount(FhWndHeader));
    Header_GetOrderArray(FhWndHeader, Header_GetItemCount(FhWndHeader), {$IFDEF FPC}LParam{$ELSE}PInteger{$ENDIF}(SectionOrder));
    if Length(SectionOrder) > 0 then
      Header_GETITEMRECT(FhWndHeader, SectionOrder[Index], {$IFDEF FPC}Longint{$ENDIF}(@rc))
    else
      Header_GETITEMRECT(FhWndHeader, Index, {$IFDEF FPC}Longint{$ENDIF}(@rc));
  end
  else
    Header_GETITEMRECT(FhWndHeader, Index, {$IFDEF FPC}Longint{$ENDIF}(@rc));

  Result := rc;
end;


procedure TacListViewWnd.HeaderWndProc(var Message: TMessage);
var
  Info: THDHitTestInfo;
  CurIndex: integer;

  function MouseToColIndex(p: TSmallPoint): integer;
  var
    ltPoint: TPoint;
    i, c: integer;
    rc: TRect;
  begin
    if SkinData.FOwnerControl <> nil then
      ltPoint := TacAccessLV(SkinData.FOwnerControl).ScreenToClient(Point(p.x, p.y))
    else begin
      GetWindowRect(FhWndHeader, rc);
      ltPoint.X := p.x - rc.Left;
      ltPoint.Y := p.y - rc.Top;
    end;
    Result := -2;
    c := Header_GetItemCount(FhWndHeader) - 1;
    for i := 0 to c do begin
      rc := GetHeaderColumnRect(i);
      if PtInRect(rc, ltPoint) then begin
        Result := i;
        Exit;
      end;
    end;
  end;

begin
  if ViewStyle = vsReport then begin
    try
      with Message do begin
        case Msg of
          WM_NCHITTEST:
            if HotTrack then begin
              Result := CallWindowProc(FhDefHeaderProc, FhWndHeader, Msg, WParam, LParam);
              CurIndex := MouseToColIndex(TWMNCHitTest(Message).Pos);
              if HoverColIndex <> CurIndex then begin
                HoverColIndex := Header_OrderToIndex(FhWndHeader, CurIndex);
                PaintHeader(0);
              end;
              Exit;
            end;

          WM_LBUTTONUP:
            if HotTrack then
              FPressedColumn := -1;

          WM_PAINT: begin
            PaintHeader(0);
            Exit;
          end;

          WM_ERASEBKGND: begin
            Message.Result := ERASE_OK;
            Exit;
          end;

          WM_WINDOWPOSCHANGING:
            if IsWindowVisible(CtrlHandle) then
              ProcessMessage(WM_NCPAINT, 0, 0);

          WM_NCDESTROY: begin
            Result := CallWindowProc(FhDefHeaderProc, FhWndHeader, Msg, WParam, LParam);
            FhWndHeader := 0;
            FhDefHeaderProc := nil;
            Exit;
          end;
        end;
        Result := CallWindowProc(FhDefHeaderProc, FhWndHeader, Msg, WParam, LParam);
        case Msg of
          WM_LBUTTONDOWN:
            if HotTrack then begin
              Info.{$IFDEF FPC}pt{$ELSE}Point{$ENDIF}.X := TWMMouse(Message).XPos;
              Info.{$IFDEF FPC}pt{$ELSE}Point{$ENDIF}.Y := TWMMouse(Message).YPos;
              SendMessage(FhWndHeader, HDM_HITTEST, 0, Windows.LPARAM(@Info));
              if (Info.Flags and HHT_ONDIVIDER = 0) and (Info.Flags and HHT_ONDIVOPEN = 0) then
                FPressedColumn := Info.{$IFDEF FPC}iItem{$ELSE}Item{$ENDIF}
              else
                FPressedColumn := -1;

              RedrawWindow(FhWndHeader, nil, 0, RDW_INVALIDATE);
            end;
        end;
      end;
    except
      Application.HandleException(Self);
    end;
  end
  else
    if (FhDefHeaderProc <> nil) and (FhWndHeader <> 0) then
      with Message do
        Result := CallWindowProc(FhDefHeaderProc, FhWndHeader, Msg, WParam, LParam);
end;


function TacListViewWnd.HotTrack: boolean;
begin
  Result := True;
end;


procedure TacListViewWnd.PaintHeader;
var
  PS: TPaintStruct;
  rc, HeaderR: TRect;
  i, Index, count, RightPos: Integer;
begin
  if ViewStyle = vsReport then begin
    BeginPaint(FhWndHeader, {$IFDEF FPC}@PS{$ELSE}PS{$ENDIF});
    try
      RightPos := 0;
      count := Header_GetItemCount(FhWndHeader) - 1;
      if count >= 0 then
        // Draw Columns Headers
        for i := 0 to count do begin
          rc := GetHeaderColumnRect(i);
          if not IsRectEmpty(rc) then begin
            Index := Header_OrderToIndex(FhWndHeader, i);
            ColumnSkinPaint(rc, Index, DC);
          end;
          if RightPos < rc.Right then
            RightPos := rc.Right;
        end
      else
        rc := GetHeaderColumnRect(0);

      // Draw background section
      if Windows.GetWindowRect(FhWndHeader, HeaderR) then begin
        rc := Rect(RightPos, 0, WidthOf(HeaderR), HeightOf(HeaderR));
        if not IsRectEmpty(rc) then
          ColumnSkinPaint(rc, -2, DC);
      end;
    finally
      EndPaint(FhWndHeader, {$IFDEF FPC}@PS{$ELSE}PS{$ENDIF});
    end;
  end;
end;


procedure TacListViewWnd.RestoreStdParams;
begin
  if FhWndHeader <> 0 then begin
    SetWindowLong(FhWndHeader, GWL_WNDPROC, LONG_PTR(FhDefHeaderProc));
    FhWndHeader := 0;
  end;
  if FhHeaderProc <> nil then begin
    {$IFDEF DELPHI7UP}Classes.{$ENDIF}FreeObjectInstance(FhHeaderProc);
    FhHeaderProc := nil;
  end;
  inherited RestoreStdParams;
  ListView_SetTextColor(CtrlHandle, ColorToRGB(StdFontColor));
  ListView_SetTextBkColor(CtrlHandle, ColorToRGB(StdColor));
  if SkinData.FOwnerControl <> nil then
    TsAccessControl(SkinData.FOwnerControl).Color := StdColor;
    
  RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE);
end;


procedure TacListViewWnd.SaveStdParams;
begin
  inherited;
  if CtrlHandle <> 0 then
    if SkinData.FOwnerControl <> nil then begin
      StdColor     := TsAccessControl(SkinData.FOwnerControl).Color;
      StdFontColor := TsAccessControl(SkinData.FOwnerControl).Font.Color;
    end
    else begin
      StdColor     := TColor(SendMessage(CtrlHandle, LVM_GETBKCOLOR,   0, 0));
      StdFontColor := TColor(SendMessage(CtrlHandle, LVM_GETTEXTCOLOR, 0, 0));
    end;
end;


procedure TacListViewWnd.SetSkinParams;
var
  State: integer;
begin
  inherited;
  if CtrlHandle <> 0 then
    if DlgMode then begin
      ListView_SetBkColor(CtrlHandle, ColorToRGB(clWindow));
      ListView_SetTextBkColor(CtrlHandle, ColorToRGB(clWindow));
      ListView_SetTextColor(CtrlHandle, ColorToRGB(clWindowText));
    end
    else
      if DefaultManager.IsValidSkinIndex(SkinData.SkinIndex) then
        with SkinData.SkinManager.gd[Skindata.SkinIndex] do begin
          State := integer(ControlIsActive(SkinData) and (States > 1));
          if not SkinData.CustomColor then begin
            ListView_SetBkColor(CtrlHandle, Props[State].Color);
            ListView_SetTextBkColor(CtrlHandle, ColorToRGB(Props[State].Color));
          end;
          if not SkinData.CustomFont then
            ListView_SetTextColor(CtrlHandle, Props[State].FontColor.Color);
        end;
end;


function TacListViewWnd.ViewStyle: TViewStyle;
var
  St: dword;
begin
  if SkinData.FOwnerControl <> nil then
    Result := TacAccessLV(SkinData.FOwnerControl).ViewStyle
  else begin
    St := dword(SendMessage(CtrlHandle, LVM_FIRST + 143 {LVM_GETVIEW}, 0, 0));
    case St of
      0:   Result := vsIcon;
      1:   Result := vsReport;
      2:   Result := vsSmallIcon;
      3:   Result := vsList
      else Result := vsList
    end;
  end;
end;


procedure TacGridWnd.acWndProc(var Message: TMessage);
var
  Grid: TsAccessGrid;
  sb: TScrollStyle;
  SavedDC: hdc;
  p: TPoint;
  R: TRect;
begin
  case Message.Msg of
    WM_ERASEBKGND: begin
      SkinData.Updating := SkinData.Updating;
      Message.Result := ERASE_OK;
      Exit; // Blinking removing in loading
    end;

    WM_LBUTTONUP:
      if Self.sBarVert.fScrollVisible then begin
        p := acMousePos;
        AC_GetVScrollRect(Self, CtrlHandle, R);
        if PtInRect(R, p) then begin // If in scrollbar
          Message.Result := Ac_LButtonUp(Self, CtrlHandle, WPARAM(-1) {do not call def handler}, Message.LParam);
          Exit;
        end;
      end;

    WM_VSCROLL:
      with TWMVScroll(Message), sBarVert.ScrollInfo do begin
        // TDBGrid params
        if (ScrollCode = SB_THUMBPOSITION) and HasProperty(SkinData.FOwnerControl, acDataSource) then begin
//          if Pos > 4 then
//            TWMVScroll(Message).Pos := TWMVScroll(Message).Pos;
          cbSize := SizeOf(TScrollInfo);
          fMask := SIF_ALL;
          nPos := nTrackPos;
          if not HasProperty(SkinData.FOwnerControl, 'DataSource') then // SkinData.FOwnerControl.ClassName = acTwwDBGrid
            inc(sBarVert.ScrollInfo.nPos);

          SetScrollInfo(CtrlHandle, SB_VERT, {$IFDEF FPC}@sBarVert.ScrollInfo{$ELSE}sBarVert.ScrollInfo{$ENDIF}, False);
        end;
        // For DBGridEH
        if (ScrollCode = SB_THUMBTRACK) and HasProperty(SkinData.FOwnerControl, acDataSource) then begin
          cbSize := SizeOf(TScrollInfo);
          fMask := SIF_ALL;
          nPos := nTrackPos;
          SetScrollInfo(CtrlHandle, SB_VERT, {$IFDEF FPC}@sBarVert.ScrollInfo{$ELSE}sBarVert.ScrollInfo{$ENDIF}, False);
        end;
        if (ScrollCode = SB_ENDSCROLL) and HasProperty(SkinData.FOwnerControl, acDataSource) and (SkinData.FOwnerControl.ClassName <> acTwwDBGrid) then
          SendScrollMessage(CtrlHandle, WM_VSCROLL, SB_THUMBPOSITION, sBarVert.ScrollInfo.nTrackPos);
      end;

    WM_PRINT:
      with TWMPaint(Message) do begin
        inherited acWndProc(Message);
        SavedDC := SaveDC(DC);
        MoveWindowOrg(DC, cxLeftEdge, cxLeftEdge);
        IntersectClipRect(DC, 0, 0,
                          SkinData.FCacheBmp.Width  - 2 * cxLeftEdge - integer(sBarVert.fScrollVisible) * GetScrollMetric(sBarVert, SM_SCROLLWIDTH),
                          SkinData.FCacheBmp.Height - 2 * cxLeftEdge - integer(sBarHorz.fScrollVisible) * GetScrollMetric(sBarHorz, SM_SCROLLWIDTH));
        SendMessage(CtrlHandle, WM_PAINT, Message.WParam, Unused);
        RestoreDC(DC, SavedDC);
        Exit;
      end;
  end;
  inherited acWndProc(Message);
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and (SkinData.FOwnerControl is TCustomGrid) then begin
            Grid := TsAccessGrid(SkinData.FOwnerControl);
            sb := Grid.ScrollBars;
            Grid.ScrollBars := ssNone;
            Grid.ScrollBars := sb;
          end;
      end;

    WM_WINDOWPOSCHANGED:
      if IsWindowVisible(CtrlHandle) then
        ProcessMessage(WM_NCPAINT, 0, 0);

    WM_PAINT:
      UpdateScrolls(Self, True)
  end;
end;


procedure TacGridWnd.RestoreStdParams;
var
  f, l: TObject;
begin
  inherited;
  if Assigned(SkinData) and Assigned(SkinData.FOwnerControl) and not (csDestroying in SkinData.FOwnerControl.ComponentState) then begin
    TryChangeIntProp(SkinData.FOwnerControl, acFixedColor, FixedColor);
    // TDBGrid params
    if HasProperty(SkinData.FOwnerControl, acTitleFont) then begin
      f := TFont(GetObjProp(SkinData.FOwnerControl, acTitleFont));
      TFont(f).Color := TitleFontColor;
    end;
    // AdvGrid params
    if HasProperty(SkinData.FOwnerControl, acControlLook) then begin
      if HasProperty(SkinData.FOwnerControl, acFixedFont) then begin
        f := TFont(GetObjProp(SkinData.FOwnerControl, acFixedFont));
        TFont(f).Color := TitleFontColor;
      end;
      TryChangeIntProp(SkinData.FOwnerControl, acGridFixedLineColor, GridFixedLineColor);
      TryChangeIntProp(SkinData.FOwnerControl, acGridLineColor, GridLineColor);
      l := TObject(GetObjProp(SkinData.FOwnerControl, acControlLook));
      if l <> nil then begin
        TryChangeIntProp(l, acFixedGradientFrom, FixedGradientFrom);
        TryChangeIntProp(l, acFixedGradientTo, FixedGradientTo);
        TryChangeIntProp(l, acFixedGradientMirrorFrom, FixedGradientMirrorFrom);
        TryChangeIntProp(l, acFixedGradientMirrorTo, FixedGradientMirrorTo);
      end;
      TryChangeIntProp(SkinData.FOwnerControl, acSelectionColor, SelectionColor);
      TryChangeIntProp(SkinData.FOwnerControl, acSelectionTextColor, SelectionTextColor);
    end;
    // TSMDBGrid params
    l := TObject(GetObjProp(SkinData.FOwnerControl, acGridStyle));
    if l <> nil then begin
      f := TObject(GetObjProp(l, acTitle));
      if f <> nil then begin
        TryChangeIntProp(f, acStartColor, FixedGradientFrom);
        TryChangeIntProp(f, acEndColor, FixedGradientTo);
      end;
    end;
    // wwDBGrid params
    if HasProperty(SkinData.FOwnerControl, acLineColors) then begin
      l := GetObjProp(SkinData.FOwnerControl, acLineColors);
      TryChangeIntProp(l, acFixedColor, GridFixedLineColor);
      TryChangeIntProp(l, acDataColor, GridLineColor);
      TryChangeIntProp(l, acShadowColor, GridLineColor);
    end;
    TryChangeIntProp(SkinData.FOwnerControl, acFooterColor, FooterColor);
    TryChangeIntProp(SkinData.FOwnerControl, acFooterCellColor, FooterCellColor);
    TryChangeIntProp(SkinData.FOwnerControl, acTitleColor, TitleColor);
    TryChangeIntProp(SkinData.FOwnerControl, acIndColor, IndColor);
  end;
end;


procedure TacGridWnd.SaveStdParams;
var
  f, l: TObject;
begin
  inherited;
  FixedColor := TryGetColorProp(SkinData.FOwnerControl, acFixedColor);
  // TDBGrid params
  if HasProperty(SkinData.FOwnerControl, acTitleFont) then begin
    f := TFont(GetObjProp(SkinData.FOwnerControl, acTitleFont));
    TitleFontColor := TFont(f).Color;
  end;
  // AdvGrid params
  if HasProperty(SkinData.FOwnerControl, acControlLook) then begin
    if HasProperty(SkinData.FOwnerControl, acFixedFont) then begin
      f := TFont(GetObjProp(SkinData.FOwnerControl, acFixedFont));
      TitleFontColor := ColorToRGB(TFont(f).Color);
    end;
    GridFixedLineColor := TryGetColorProp(SkinData.FOwnerControl, acGridFixedLineColor);
    GridLineColor := TryGetColorProp(SkinData.FOwnerControl, acGridLineColor);
    l := TObject(GetObjProp(SkinData.FOwnerControl, acControlLook));
    if l <> nil then begin
      FixedGradientFrom := TryGetColorProp(l, acFixedGradientFrom);
      if FixedGradientFrom = clNone then
        FixedGradientFrom := clBtnFace;

      FixedGradientTo := TryGetColorProp(l, acFixedGradientTo);
      if FixedGradientTo = clNone then
        FixedGradientTo := clBtnFace;

      FixedGradientMirrorFrom := TryGetColorProp(l, acFixedGradientMirrorFrom);
      if FixedGradientMirrorFrom = clNone then
        FixedGradientMirrorFrom := clBtnFace;

      FixedGradientMirrorTo := TryGetColorProp(l, acFixedGradientMirrorTo);
      if FixedGradientMirrorTo = clNone then
        FixedGradientMirrorTo := clBtnFace;
    end;
    SelectionColor := TryGetColorProp(SkinData.FOwnerControl, acSelectionColor);
    SelectionTextColor := TryGetColorProp(SkinData.FOwnerControl, acSelectionTextColor);
  end;
  // TSMDBGrid params
  l := TObject(GetObjProp(SkinData.FOwnerControl, acGridStyle));
  if l <> nil then begin
    f := TObject(GetObjProp(l, acTitle));
    if f <> nil then begin
      FixedGradientFrom := TryGetColorProp(f, acStartColor);
      if FixedGradientFrom = clNone then
        FixedGradientFrom := clBtnFace;

      FixedGradientTo := TryGetColorProp(f, acEndColor);
      if FixedGradientTo = clNone then
        FixedGradientTo := clBtnFace;
    end;
  end;
  // wwDBGrid params
  if HasProperty(SkinData.FOwnerControl, acLineColors) then begin
    l := GetObjProp(SkinData.FOwnerControl, acLineColors);
    GridFixedLineColor := TryGetColorProp(l, acFixedColor);
    GridLineColor := TryGetColorProp(l, acDataColor);
  end;
  FooterColor     := TryGetColorProp(SkinData.FOwnerControl, acFooterColor);
  FooterCellColor := TryGetColorProp(SkinData.FOwnerControl, acFooterCellColor);
  TitleColor      := TryGetColorProp(SkinData.FOwnerControl, acTitleColor);
  IndColor        := TryGetColorProp(SkinData.FOwnerControl, acIndColor);
end;


procedure TacGridWnd.SetSkinParams;
var
  f, l: TObject;
  CGlobal: TColor;
begin
  inherited;
  with SkinData, SkinManager do begin
    CGlobal := Palette[pcMainColor];
    TryChangeIntProp(FOwnerControl, acFixedColor, CGlobal);
    // TDBGrid params
    if HasProperty(FOwnerControl, acTitleFont) then begin
      f := TFont(GetObjProp(FOwnerControl, acTitleFont));
      TFont(f).Color := Palette[pcLabelText];
    end;
    // AdvGrid params <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    if HasProperty(FOwnerControl, acControlLook) then begin
      if HasProperty(FOwnerControl, acFixedFont) then begin
        f := TFont(GetObjProp(FOwnerControl, acFixedFont));
        TFont(f).Color := Palette[pcLabelText];
      end;
      TryChangeIntProp(FOwnerControl, acGridFixedLineColor, Palette[pcBorder]);
      TryChangeIntProp(FOwnerControl, acGridLineColor, BlendColors(GetActiveEditColor, GetActiveEditFontColor, 180));
      l := TObject(GetObjProp(FOwnerControl, acControlLook));
      if l <> nil then begin
        TryChangeIntProp(l, acFixedGradientFrom,       BlendColors(CGlobal, GetActiveEditColor, 127));
        TryChangeIntProp(l, acFixedGradientTo,         CGlobal);
        TryChangeIntProp(l, acFixedGradientMirrorFrom, BlendColors(CGlobal, 0, 243));
        TryChangeIntProp(l, acFixedGradientMirrorTo,   BlendColors(CGlobal, clWhite, 230));
      end;
      TryChangeIntProp(FOwnerControl, acSelectionColor,     GetHighLightColor);
      TryChangeIntProp(FOwnerControl, acSelectionTextColor, GetHighLightFontColor);
    end; // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    // TSMDBGrid params
    l := TObject(GetObjProp(FOwnerControl, acGridStyle));
    if l <> nil then begin
      f := TObject(GetObjProp(l, acTitle));
      if f <> nil then begin
        TryChangeIntProp(f, acStartColor, BlendColors(CGlobal, GetActiveEditColor, 127));
        TryChangeIntProp(f, acEndColor, CGlobal);
      end;
    end;
    // wwDBGrid params
    if HasProperty(FOwnerControl, acLineColors) then begin
      l := GetObjProp(FOwnerControl, acLineColors);
      TryChangeIntProp(l, acFixedColor,  Palette[pcBorder]);
      TryChangeIntProp(l, acDataColor,   BlendColors(GetActiveEditColor, GetActiveEditFontColor, 205));
      TryChangeIntProp(l, acShadowColor, BlendColors(GetActiveEditColor, GetActiveEditFontColor, 205));
    end;
    TryChangeIntProp(FOwnerControl, acFooterColor,     gd[ConstData.IndexGlobalInfo].Props[0].Color);
    TryChangeIntProp(FOwnerControl, acFooterCellColor, gd[ConstData.IndexGlobalInfo].Props[0].Color);
    TryChangeIntProp(FOwnerControl, acTitleColor,      gd[ConstData.IndexGlobalInfo].Props[0].Color);
    TryChangeIntProp(FOwnerControl, acIndColor,        gd[SkinIndex].Props[0].FontColor.Color);
  end;
end;


procedure TacTreeViewWnd.acWndProc(var Message: TMessage);
var
  DC: hdc;
  C: TColor;
  State: integer;
begin
  if SkinData <> nil then
    case Message.Msg of
      WM_LBUTTONUP: begin
        inherited;
        ReleaseCapture;
      end;

      WM_ERASEBKGND:
        if not SkipBG then begin
          if (SkinData.FOwnerControl <> nil) and Assigned(TTreeView(SkinData.FOwnerControl).OnAdvancedCustomDraw) then
            Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam)
          else
            if (SkinData.SkinManager <> nil) and not InUpdating(SkinData) then begin
              if SkinData.BGChanged then
                PrepareCache(SkinData, CtrlHandle, DlgMode);

              if Message.WParam <> 0 then
                DC := hdc(Message.WParam)
              else
                DC := GetWindowDC(CtrlHandle);

              try
                if not SkinData.CustomColor then begin
                  State := integer(SkinData.FFocused or SkinData.FMouseAbove and MayBeHot(SkinData));
                  C := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[State].Color
                end
                else
                  if SkinData.FOwnerControl <> nil then
                    C := TsAccessControl(SkinData.FOwnerControl).Color
                  else
                    C := ColorToRGB(clWindow);

                FillDC(DC, MkRect(WndSize), iff(DlgMode, ColorToRGB(clWindow), C));
              finally
                if Message.WParam = 0 then
                  ReleaseDC(CtrlHandle, DC);
              end;
              Message.Result := ERASE_OK;
            end
        end
        else
          inherited;
      else
        inherited;
    end
    else
      inherited;
end;


procedure TacTreeViewWnd.RestoreStdParams;
begin
  inherited;
  if IsWindowVisible(CtrlHandle) then begin
    TreeView_SetBkColor(CtrlHandle, ColorToRGB(StdColor));
    TreeView_SetTextColor(CtrlHandle, ColorToRGB(StdFontColor));
  end;
end;


procedure TacTreeViewWnd.SetSkinParams;
var
  C, fC: TColor;
  State: integer;
begin
  inherited;
  C := 0;
  fC := 0;
  if DlgMode then begin
    TreeView_SetBkColor  (CtrlHandle, ColorToRGB(clWindow));
    TreeView_SetTextColor(CtrlHandle, ColorToRGB(clWindowText));
  end
  else
    if SkinData <> nil then
      with SkinData do begin
        State := integer(ControlIsActive(SkinData));
        if not CustomColor then
          C := SkinManager.gd[SkinIndex].Props[State].Color
        else
          if FOwnerControl <> nil then
            C := TsAccessControl(FOwnerControl).Color;

        if not CustomFont then
          fC := SkinManager.gd[SkinIndex].Props[State].FontColor.Color
        else
          if FOwnerControl <> nil then
            fC := TsAccessControl(FOwnerControl).Font.Color;

        if FOwnerControl <> nil then
          with TsAccessControl(FOwnerControl) do begin
            if Font.Color <> fC then
              Font.Color := fC;

            if Color <> C then
              TreeView_SetBkColor(CtrlHandle, ColorToRGB(C));
          end
        else
          TreeView_SetBkColor(CtrlHandle, ColorToRGB(C));
      end;
end;


{$IFNDEF DELPHI5}
type
  TAccessCombo = class(TComboBox);
{$ENDIF}


procedure TacComboBoxWnd.acWndProc(var Message: TMessage);
var
  DC: hdc;
  R: TRect;
  i: integer;
  b, Simple: boolean;
  si: TacSectionInfo;
{$IFNDEF DELPHI5}
  fHandle: THandle;
{$ENDIF}
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            inherited;
            if FListHandle <> 0 then begin
              SetWindowLong(FListHandle, GWL_STYLE, GetWindowLong(FListHandle, GWL_STYLE) and not WS_THICKFRAME or WS_BORDER);
              UninitializeACScroll(FListHandle, True, False, TacScrollWnd(ListSW));
              FListHandle := 0;
            end;
            Exit
          end;

        AC_MOUSEENTER, AC_MOUSELEAVE: begin
          inherited;
          RepaintButton;
        end;

        else
          inherited;
      end;

    WM_DRAWITEM: begin
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      Invalidate;
    end;

    CN_DRAWITEM:
      if EasyComboBox then // If TComboBox
        CNDrawItem(TWMDrawItem(Message))
      else
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);

    CB_SETCURSEL, CM_CHANGED, CM_TEXTCHANGED:
      if EasyComboBox then begin
        SetRedraw(CtrlHandle, 0);
        SkinData.BGChanged := True;
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        SetRedraw(CtrlHandle, 1);
        RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
      end
      else
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);

    WM_ERASEBKGND:
      Message.Result := ERASE_OK;

    WM_PRINT: begin
      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      SkinData.Updating := True;
      if not ParamsChanged then
        SetSkinParams;

      if Destroyed then
        Exit;

      SkinData.Updating := False;
      SkinData.BGChanged := True;
      if GetWindowLong(CtrlHandle, GWL_STYLE) and CBS_DROPDOWNLIST = CBS_SIMPLE then
        PrepareSimple
      else
        PrepareCache(SkinData, CtrlHandle, DlgMode);

      if SkinData <> nil then
        with SkinData do begin
          if (FOwnerControl is TComboBox) and (TComboBox(FOwnerControl).ItemIndex >= 0) then
            with TComboBox(FOwnerControl) do
              DrawItem(ItemIndex, Rect(3, 3, Width - WidthOf(ButtonRect), Height - 3), [odComboBoxEdit], FCacheBmp.Canvas.Handle)
          else
            PaintText;

          UpdateWndCorners(SkinData, 0, Self);
          DC := TWMPaint(Message).DC;
          BitBlt(DC, 0, 0, FCacheBmp.Width, FCacheBmp.Height, FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
          PaintButton(DC);
        end;
    end;

    WM_NCCALCSIZE: begin
      inherited;
      cxLeftEdge := 3;
    end;

    WM_PAINT: begin
      if not ParamsChanged then
        SetSkinParams;

      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      Simple := (GetWindowLong(CtrlHandle, GWL_STYLE) and CBS_DROPDOWNLIST = CBS_SIMPLE);
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      if TWMPaint(Message).DC = 0 then begin
        DC := GetWindowDC(CtrlHandle);
        TWMPaint(Message).DC := DC;
        b := True;
      end
      else begin
        DC := TWMPaint(Message).DC;
        b := False;
      end;
      if Simple then begin
        PrepareSimple;
        BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, 3);
      end
      else begin
        SkinData.BGChanged := True;
        SendMessage(CtrlHandle, SM_ALPHACMD, AC_PREPARECACHE_HI, 0);
        BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, 3);
        PaintButton(DC);
      end;
      if b then
        ReleaseDC(CtrlHandle, DC);
    end;


    CM_MOUSEENTER:
      if not SkinData.FMouseAbove then begin
        SkinData.FMouseAbove := True;
        SkinData.BGChanged := True;
        inherited;
{$IFNDEF DELPHI5}
        if (SkinData.FOwnerControl is TComboBox) and (TAccessCombo(SkinData.FOwnerControl).Style = csDropDown) then
{$IFNDEF FPC}
        if not SkinData.FFocused then
            SendMessage(TAccessCombo(SkinData.FOwnerControl).FEditHandle, EM_SETSEL, -1, 0);
{$ENDIF}
{$ENDIF}
        Invalidate;
      end;

    CM_MOUSELEAVE:
      if SkinData.FMouseAbove then begin
        GetWindowRect(CtrlHandle, R);
{$IFNDEF DELPHI5}
        if not SkinData.FFocused and (SkinData.FOwnerControl <> nil) {$IFNDEF FPC}and (GetFocus = TAccessCombo(SkinData.FOwnerControl).FEditHandle){$ENDIF} then
          SkinData.FFocused := True;
{$ELSE}
        SkinData.FFocused := False;
{$ENDIF}
        if PtInRect(R, acMousePos) then
          Exit;

        SkinData.FMouseAbove := False;
        SkinData.BGChanged := True;
        inherited;
{$IFNDEF DELPHI5}
        if (SkinData <> nil) and (SkinData.FOwnerControl is TComboBox) and (TAccessCombo(SkinData.FOwnerControl).Style = csDropDown) then
{$IFNDEF FPC}
          if not SkinData.FFocused then
            SendMessage(TAccessCombo(SkinData.FOwnerControl).FEditHandle, EM_SETSEL, -1, 0);
{$ENDIF}
{$ENDIF}
        Invalidate;
      end;

    WM_SETFOCUS, WM_LBUTTONUP: begin
      SkinData.FFocused := True;
      if MayBeHot(SkinData, False) and Assigned(Skindata.FOwnerControl) and TWinControl(Skindata.FOwnerControl).CanFocus and TWinControl(Skindata.FOwnerControl).TabStop then begin
        SetSkinParams;
        RedrawWindow(CtrlHandle, nil, 0, RDWA_NOCHILDRENNOW);
      end;
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      if SkinData <> nil then
        RepaintButton;
    end;

    CM_EXIT, WM_KILLFOCUS: begin
{$IFNDEF DELPHI5}
      if SkinData.FOwnerControl <> nil then begin
        fHandle := GetFocus;
        SkinData.FFocused := (fHandle = {$IFNDEF FPC}TAccessCombo(SkinData.FOwnerControl).FEditHandle{$ELSE}CtrlHandle{$ENDIF});
      end
      else
{$ENDIF}
        SkinData.FFocused := False;

      Skindata.BGChanged := True;
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      if MayBeHot(SkinData, False) and Assigned(Skindata.FOwnerControl) and TWinControl(Skindata.FOwnerControl).CanFocus and TWinControl(Skindata.FOwnerControl).TabStop then begin
        SetSkinParams;
{$IFNDEF DELPHI5}
{$IFNDEF FPC}
        if (SkinData.FOwnerControl is TComboBox) and (TAccessCombo(SkinData.FOwnerControl).Style = csDropDown) then
          SendMessage(TAccessCombo(SkinData.FOwnerControl).FEditHandle, EM_SETSEL, -1, 0);
{$ENDIF}
{$ENDIF}
        RedrawWindow(CtrlHandle, nil, 0, RDWA_NOCHILDRENNOW);
      end;
      RepaintButton;
    end;

    CN_COMMAND: begin
      case TWMCommand(Message).NotifyCode of
        CBN_CLOSEUP: begin
          bDroppedDown := False;
          SkinData.BGChanged := True;
          RepaintButton;
        end;
        CBN_DROPDOWN:
          bDroppedDown := True;
      end;
      inherited;
    end;

    WM_COMMAND: begin
      if GetWindowLong(CtrlHandle, GWL_STYLE) and CBS_SIMPLE = 0 then
        if TWMCommand(Message).NotifyCode = CBN_CLOSEUP then begin
          SkinData.BGChanged := True;
          bDroppedDown := False;
          RepaintButton;
        end
        else
          if TWMCommand(Message).NotifyCode = CBN_DROPDOWN then
            bDroppedDown := True;

      inherited;
    end;

    WM_CTLCOLORLISTBOX:
      if not LBoxOpening then begin
        LBoxOpening := True;
        inherited;
{$IFDEF TNTUNICODE}
        if SkinData.FOwnerControl is TTntCustomComboBox then Exit;
{$ENDIF}
        if FListHandle = 0 then begin
          FListHandle := Message.LParam;
          if ListSW = nil then begin
            Simple := GetWindowLong(CtrlHandle, GWL_STYLE) and CBS_DROPDOWNLIST = CBS_SIMPLE;
            if SkinData.FOwnerControl = nil then
              acDlgMode := DlgMode;

            b := SendMessage(CtrlHandle, CB_GETCOUNT, 0, 0) > 0;
            ListSW := TacComboListWnd.CreateEx(FListHandle, nil, SkinData.SkinManager, s_Edit, b, Simple);
            if SkinData.FOwnerControl = nil then
              acDlgMode := False;
          end;
          si.siSkinIndex := -1;
          SendMessage(FListHandle, SM_ALPHACMD, AC_GETSKININDEX shl 16, LPARAM(@si));// - 1;
          i := si.siSkinIndex;
          if (i >= 0) and not DlgMode then
            with SkinData.SkinManager.gd[i].Props[0] do begin
              if FontColor.Color >= 0 then
                SetTextColor(hdc(Message.WParam), Cardinal(FontColor.Color));

              SetBkColor(hdc(Message.WParam), Cardinal(Color));
              Message.Result := LRESULT(CreateSolidBrush(Cardinal(Color)));
            end;
        end;
        LBoxOpening := False;
      end;

    else
      inherited;
  end;
end;


procedure TacComboBoxWnd.AfterCreation;
begin
  LBoxOpening := False;
  LBSkinData := TsCommonData.Create(nil, True);
  inherited;
end;


function TacComboBoxWnd.ButtonHeight: integer;
begin
  with SkinData.SkinManager.ConstData.ComboBtn do
    if GlyphIndex >= 0 then
      Result := SkinData.SkinManager.ma[GlyphIndex].Height
    else
      Result := 16;
end;


function TacComboBoxWnd.ButtonRect: TRect;
var
  w: integer;
  r: TRect;
  Style: Longint;
begin
  Style := GetWindowLong(CtrlHandle, GWL_STYLE);
  if not DlgMode or (Style and CBS_DROPDOWNLIST = CBS_DROPDOWNLIST) then begin
    w := GetComboBtnSize(Skindata.SkinManager) + 2
  end
  else
    if Style and CBS_DROPDOWN = CBS_DROPDOWN then begin
      w := GetComboBtnSize(Skindata.SkinManager);
//      if not DlgMode {or (GetWindowLong(CtrlHandle, GWL_STYLE) and CBS_DROPDOWN <> CBS_DROPDOWN)} then
//        inc(w, 2);
    end
    else
      w := 0;

  GetWindowRect(CtrlHandle, r);
  if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_RTLREADING <> 0 {SysLocale.MiddleEast }then
    Result.Left := SkinData.SkinManager.CommonSkinData.ComboBoxMargin
  else
    Result.Left := WidthOf(r) - w - SkinData.SkinManager.CommonSkinData.ComboBoxMargin;

  Result.Top := SkinData.SkinManager.CommonSkinData.ComboBoxMargin;
  Result.Right := Result.Left + w;
  Result.Bottom := HeightOf(r) - SkinData.SkinManager.CommonSkinData.ComboBoxMargin;
end;


procedure TacComboBoxWnd.CNDrawItem(var Message: TWMDrawItem);
var
  AState: TOwnerDrawState;
begin
  with Message.DrawItemStruct^ do begin
{$IFDEF FPC}
    AState := TOwnerDrawState(itemState);
{$ELSE}
    AState := TOwnerDrawState(LongRec(itemState).Lo);
{$ENDIF}
    if itemState and ODS_COMBOBOXEDIT <> 0 then
      Include(AState, odComboBoxEdit);

    if itemState and ODS_DEFAULT <> 0 then
      Include(AState, odDefault);

    DrawItem(integer(itemID), rcItem, AState, hDC);
  end;
end;


destructor TacComboBoxWnd.Destroy;
begin
  FreeAndNil(LBSkinData);
  if Assigned(ListSW) then begin
    UninitializeACScroll(ListSW.CtrlHandle, True, False, TacScrollWnd(ListSW));
    FListHandle := 0;
  end;
  inherited;
end;


procedure TacComboBoxWnd.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState; DC: hdc);
var
  C: TColor;
  s: ACString;
  Bmp: TBitmap;
  aRect: TRect;
  CI: TCacheInfo;
  ComboBox: TComboBox;
  DrawStyle: Cardinal;
  sNdx, aState: integer;
{$IFDEF DELPHI6UP}
  OldDC,
{$ENDIF}
  SavedDC: hdc;
begin
  aRect := Rect;
  DrawStyle := DT_NOPREFIX or DT_EXPANDTABS or DT_SINGLELINE or DT_TOP or DT_NOCLIP;
  if SkinData.FOwnerControl <> nil then
    ComboBox := TComboBox(SkinData.FOwnerControl)
  else
    ComboBox := nil;

  if SkinData.BGChanged then
    PrepareCache(SkinData, CtrlHandle);

  Bmp := CreateBmp32(Rect.Right, Rect.Bottom);
  Bmp.Canvas.Font.Assign(ComboBox.Font);
  if odComboBoxEdit in State then begin
    CI := MakeCacheInfo(SkinData.FCacheBmp, Rect.Left, Rect.Top);
    if (ControlIsActive(SkinData) or (GetFocus <> 0) and ComboBox.Focused or SkinData.FFocused) and (SkinData.SkinManager.gd[SkinData.SkinIndex].States > 1) then
      aState := 1
    else
      aState := 0;
  end
  else begin
    CI.Bmp := nil;
    CI.Ready := False;
    CI.FillColor := Color;
    aState := integer(SkinData.SkinManager.gd[SkinData.SkinIndex].States > 1);
  end;
  s := ComboBox.Items[Index];
  if odSelected in State then begin
    sNdx := SkinData.SkinManager.ConstData.Sections[ssSelection];
    C := SkinData.SkinManager.GetHighLightColor(True);
    ComboBox.Canvas.Brush.Color := C;
    if sNdx < 0 then
      FillDC(Bmp.Canvas.Handle, MkRect(Bmp), C)
    else
      PaintItem(sNdx, CI, True, 1, Rect, MkPoint, Bmp, SkinData.SkinManager);

    ComboBox.Canvas.Font.Color := SkinData.SkinManager.GetHighLightFontColor(True);
  end
  else begin
    sNdx := -1;
    C := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[min(aState, ac_MaxPropsIndex)].Color;
    ComboBox.Canvas.Font.Color := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[min(aState, ac_MaxPropsIndex)].FontColor.Color;
    if CI.Ready then
      BitBlt(Bmp.Canvas.Handle, Rect.Left, Rect.Top, Bmp.Width, Bmp.Height, CI.Bmp.Canvas.Handle, CI.X, CI.Y, SRCCOPY)
    else
      FillDC(Bmp.Canvas.Handle, Rect, C);

    ComboBox.Canvas.Brush.Color := C;
  end;
  if odSelected in State then
    Bmp.Canvas.Font.Color := SkinData.SkinManager.GetHighLightFontColor(True)
  else
    Bmp.Canvas.Font.Color := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[min(aState, ac_MaxPropsIndex)].FontColor.Color;

  if Assigned(ComboBox.OnDrawItem) and (ComboBox.Style in [csOwnerDrawFixed, csOwnerDrawVariable]) then begin
    if IsValidIndex(Index, ComboBox.Items.Count) then begin
{$IFDEF DELPHI6UP}
      if not ComboBox.Canvas.HandleAllocated then
        OldDC := 0
      else
        OldDC := ComboBox.Canvas.Handle;
{$ENDIF}
      ComboBox.Canvas.Handle := Bmp.Canvas.Handle;
      Bmp.Canvas.Lock;
      ComboBox.Canvas.Lock;
      SavedDC := SaveDC(ComboBox.Canvas.Handle);
      try
        SelectObject(ComboBox.Canvas.Handle, Bmp.Canvas.Font.Handle);
        ComboBox.OnDrawItem(ComboBox, Index, Rect, State);
      finally
        ComboBox.Canvas.Unlock;
        RestoreDC(ComboBox.Canvas.Handle, SavedDC);
        Bmp.Canvas.UnLock;
      end;
{$IFDEF DELPHI6UP}
      ComboBox.Canvas.Handle := OldDC;
{$ENDIF}
    end
  end
  else begin
    if ComboBox.UseRightToLeftAlignment then
      DrawStyle := DrawStyle or DT_RIGHT;

    if ComboBox.UseRightToLeftReading then
      DrawStyle := DrawStyle or DT_RTLREADING;

    if (csDropDown = ComboBox.Style) and (odComboBoxEdit in State) then begin
      Bmp.Canvas.Brush.Style := bsClear;
      AcDrawText(Bmp.Canvas.Handle, ComboBox.Text, aRect, DrawStyle);
    end
    else begin
      InflateRect(aRect, -2, 0);
      if sNdx = -1 then begin
        Bmp.Canvas.Brush.Style := bsClear;
        AcDrawText(Bmp.Canvas.Handle, s, aRect, DrawStyle);
      end
      else
        acWriteTextEx(Bmp.Canvas, PACChar(s), True, aRect, DrawStyle, sNdx, (odSelected in State) or (aState > 0), SkinData.SkinManager);

      if (odFocused in State) and (sNdx < 0) then begin
        Bmp.Canvas.Brush.Style := bsSolid;
        InflateRect(aRect, 2, 0);
        DrawFocusRect(Bmp.Canvas.Handle, aRect);
      end;
    end;
  end;
  BitBlt(DC, Rect.Left, Rect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
  FreeAndNil(Bmp);
end;


function TacComboBoxWnd.EasyComboBox: boolean;
begin
  Result := SkinData.FOwnerControl is TCustomComboBox;
end;


procedure TacComboBoxWnd.Invalidate;
begin
{$IFDEF DELPHI7UP}
  if (SkinData <> nil) and (SkinData.FOwnerControl <> nil) then begin // Invalidate ComboBoxEx
    InvalidateRect(CtrlHandle, nil, True);
    UpdateWindow(CtrlHandle);
  end;
{$ENDIF}
end;


procedure TacComboBoxWnd.PaintButton;
var
  C: TColor;
  R, wR: TRect;
  Mode: integer;
  TmpBtn: TBitmap;
begin
  if SkinData <> nil then begin
    if (FListHandle <> 0) and IsWindowVisible(FListHandle) then
      Mode := 2
    else
      Mode := integer(ControlIsActive(SkinData) or (DefaultManager.ActiveControl = CtrlHandle));

    R := ButtonRect;
    TmpBtn := CreateBmpLike(SkinData.FCacheBmp);
    with SkinData.SkinManager, ConstData.ComboBtn do begin
      if SkinIndex >= 0 then begin
        BitBlt(TmpBtn.Canvas.Handle, 0, 0, TmpBtn.Width, TmpBtn.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
        PaintItem(SkinIndex, MakeCacheInfo(TmpBtn),
                  True, Mode, R, MkPoint, TmpBtn, SkinData.SkinManager, BGIndex[0], BGIndex[1]);
      end
      else
        BitBlt(TmpBtn.Canvas.Handle, 0, 0, TmpBtn.Width, TmpBtn.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);

      if GlyphIndex >= 0 then begin
        GetWindowRect(CtrlHandle, wR);
        DrawSkinGlyph(TmpBtn, Point(R.Left + (WidthOf(R) - ma[GlyphIndex].Width) div 2,
                      (HeightOf(wR) - ButtonHeight) div 2), Mode, 1, ma[GlyphIndex], MakeCacheInfo(TmpBtn));
      end
      else begin // Paint without glyph
        C := iff(SkinIndex >= 0, gd[SkinIndex].Props[min(Mode, ac_MaxPropsIndex)].FontColor.Color, clBlack);
        DrawColorArrow(TmpBtn, C, R, asBottom);
      end;
    end;
    BitBlt(DC, R.Left, R.Top, WidthOf(R), HeightOf(R), TmpBtn.Canvas.Handle, R.Left, R.Top, SRCCOPY);
    FreeAndNil(TmpBtn);
  end;
end;


procedure TacComboBoxWnd.PaintText;
var
  s: string;
  wR, R: TRect;
  li, Len: Integer;
  DropDownList: boolean;
  Text: array [0..4095] of Char;
begin
  if SkinData.FOwnerControl <> nil then
    SkinData.FCacheBMP.Canvas.Font.Assign(TsAccessControl(SkinData.FOwnerControl).Font);

  GetWindowRect(CtrlHandle, wR);
  if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_RTLREADING <> 0 then
    R := Rect(ButtonRect.Right, 3, WndSize.cx - 3, 3)
  else
    R := Rect(3, 3, ButtonRect.Left, HeightOf(wR) - 3);

  li := ProcessMessage(CB_GETCURSEL, 0, 0);
  if li >= 0 then begin
    Len := ProcessMessage(CB_GETLBTEXT, li, LPARAM(@Text));
    if Len = CB_ERR then
      Len := 0;
      
    SetString(s, Text, Len);
  end
  else begin
    Len := ProcessMessage(WM_GETTEXTLENGTH, 0, 0);
    SetString(s, PChar(nil), Len);
    if Len <> 0 then
      ProcessMessage(WM_GETTEXT, Len + 1, LPARAM(s));
  end;
  DropDownList := GetWindowLong(CtrlHandle, GWL_STYLE) and CBS_DROPDOWNLIST = CBS_DROPDOWNLIST;
  if (GetFocus = CtrlHandle) and DropDownList then begin
    SkinData.FCacheBMP.Canvas.Brush.Style := bsSolid;
    FillDC(SkinData.FCacheBMP.Canvas.Handle, R, clHighLight);
    SkinData.FCacheBMP.Canvas.Font.Color := clHighLightText;
  end
  else
    SkinData.FCacheBMP.Canvas.Brush.Style := bsClear;

  SkinData.FCacheBMP.Canvas.Brush.Style := bsClear;
  if s <> '' then
    SkinData.FCacheBMP.Canvas.TextRect(R, R.Left + integer(DropDownList), R.Top + integer(DropDownList), s);

  if (GetFocus = CtrlHandle) and DropDownList then
    DrawFocusRect(SkinData.FCacheBMP.Canvas.Handle, R);
end;


procedure TacComboBoxWnd.PrepareSimple;
begin
  with SkinData do begin
    FCacheBmp.Width := WndSize.cx;
    FCacheBmp.Height := ProcessMessage(CB_GETITEMHEIGHT, 0, 0) + 8;
    if DlgMode and (DefaultManager.Palette[pcBorder] <> clFuchsia) then begin
      FillDC(FCacheBmp.Canvas.Handle, MkRect(FCacheBmp), ColorToRGB(clWindow));
      FCacheBmp.Canvas.Brush.Color := DefaultManager.Palette[pcBorder];
      FCacheBmp.Canvas.FrameRect(MkRect(FCacheBmp));
    end
    else
      PaintItem(SkinData, GetParentCache(SkinData), True, integer(ControlIsActive(SkinData)), MkRect(FCacheBmp), MkPoint, FCacheBmp, True);
  end;
end;


procedure TacComboBoxWnd.RepaintButton;
var
  DC: hdc;
begin
  DC := GetWindowDC(CtrlHandle);
  PaintButton(DC);
  ReleaseDC(CtrlHandle, DC);
end;


procedure TacGridEhWnd.acWndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  inherited;
  case Message.Msg of
    WM_PARENTNOTIFY:
      if (Message.WParamLo = WM_CREATE) and (srThirdParty in SkinData.SkinManager.SkinningRules) then
        AddToAdapter(TWinControl(SkinData.FOwnerControl));
{
    WM_SIZE: begin
      for i := 0 to TWinControl(SkinData.FOwnerControl).ControlCount - 1 do begin
        if TWinControl(SkinData.FOwnerControl).Controls[i] is TWinControl then begin
          Panel := TWinControl(TWinControl(SkinData.FOwnerControl).Controls[i]);
          AddToAdapter(Panel);
          for j := 0 to Panel.ControlCount - 1 do
            if (Panel.Controls[j] is TWinControl) and (Panel.Controls[j].Width <> 0) then begin
              if Panel.Controls[j].Width = Panel.Controls[j].Height then begin
                AddToAdapter(TWinControl(SkinData.FOwnerControl))
              end
              else
                AddToAdapter(TWinControl(SkinData.FOwnerControl))
            end;
        end;
      end;
    end;}
  end;
end;


procedure TacGridEhWnd.RestoreStdParams;
var
  obj: TObject;
begin
  inherited;
  if not (csDestroying in SkinData.FOwnerControl.ComponentState) then begin
    // Disable themed columns
{$IFNDEF FPC}
    if {$IFDEF DELPHI7UP}acThemesEnabled and {$ENDIF} HasProperty(SkinData.FOwnerControl, acOptionsEh) then
      SetSetPropValue(SkinData.FOwnerControl, acOptionsEh, acdghFixed3D, Fixed3D);
{$ENDIF}
    TryChangeIntProp(SkinData.FOwnerControl, acEvenRowColor, EvenRowColor);
    TryChangeIntProp(SkinData.FOwnerControl, acOddRowColor, OddRowColor);

    obj := GetObjProp(SkinData.FOwnerControl, acGridLineParams);
    if obj <> nil then begin
      BrightColor   := TryGetColorProp(obj, acBrightColor);
      DataHorzColor := TryGetColorProp(obj, acDataHorzColor);
      DataVertColor := TryGetColorProp(obj, acDataVertColor);
      DarkColor     := TryGetColorProp(obj, acDarkColor);
    end;

    obj := GetObjProp(SkinData.FOwnerControl, acIndicatorParams);
    if obj <> nil then begin
      TryChangeIntProp(obj, acColor, IndColor);
      TryChangeIntProp(obj, acHorzLines, IndHorzLines);
      TryChangeIntProp(obj, acVertLines, IndVertLines);
      SetOrdProp(obj, acFillStyle, InfFillStyle);
    end;

    obj := GetObjProp(SkinData.FOwnerControl, acTitleParams);
    if obj <> nil then begin
      TryChangeIntProp(obj, acColor, TitleColor);
      TryChangeIntProp(obj, acSecondColor, FixedGradientTo);
  //    TryChangeIntProp(obj, acHorzLines, TitleHorzLines);
      SetOrdProp(obj, acFillStyle, TitleFillStyle);
      TryChangeIntProp(obj, acVertLineColor, GridFixedLineColor);
    end;

    obj := GetObjProp(SkinData.FOwnerControl, acDataGrouping);
    if (obj <> nil) and (GetIntProp(obj, 'ParentColor') = 1) then
      TryChangeIntProp(obj, acColor, DataGroupColor);

    obj := GetObjProp(SkinData.FOwnerControl, acRowCategories);
    if obj <> nil then begin
      TryChangeIntProp(obj, acColor, CategoriesColor);
      obj := GetObjProp(obj, acFont);
      if obj <> nil then
        TryChangeIntProp(obj, acColor, CategoriesFontColor);
    end;

    obj := GetObjProp(SkinData.FOwnerControl, acRowDetailPanel);
    if obj <> nil then
      RowDetailColor := TryGetColorProp(obj, acColor);
  end;
end;


procedure TacGridEhWnd.SaveStdParams;
var
  obj: TObject;
begin
  inherited;
{$IFNDEF FPC}
  if {$IFDEF DELPHI7UP}acThemesEnabled and {$ENDIF} HasProperty(SkinData.FOwnerControl, acOptionsEh) then
    Fixed3D := CheckSetProp(SkinData.FOwnerControl, acOptionsEh, acdghFixed3D);
{$ENDIF}
  EvenRowColor := TryGetColorProp(SkinData.FOwnerControl, acEvenRowColor);
  if EvenRowColor = clNone then
    EvenRowColor := ColorToRGB(clWindow);

  OddRowColor := TryGetColorProp(SkinData.FOwnerControl, acOddRowColor);
  if OddRowColor = clNone then
    OddRowColor := ColorToRGB(clWindow);

  obj := GetObjProp(SkinData.FOwnerControl, acGridLineParams);
  if obj <> nil then begin
    TryChangeIntProp(obj, acBrightColor,   BrightColor);
    TryChangeIntProp(obj, acDataHorzColor, DataHorzColor);
    TryChangeIntProp(obj, acDataVertColor, DataVertColor);
    TryChangeIntProp(obj, acDarkColor,     DarkColor);
  end;

  obj := GetObjProp(SkinData.FOwnerControl, acIndicatorParams);
  if obj <> nil then begin
    IndColor     := TryGetIntProp(obj, acColor);
    IndHorzLines := TryGetIntProp(obj, acHorzLines);
    IndVertLines := TryGetIntProp(obj, acVertLines);
    InfFillStyle := GetOrdProp(obj, acFillStyle);
  end;

  obj := GetObjProp(SkinData.FOwnerControl, acTitleParams);
  if obj <> nil then begin
    TitleColor         := TryGetColorProp(obj, acColor);
    FixedGradientTo    := TryGetColorProp(obj, acSecondColor);
    GridFixedLineColor := TryGetColorProp(obj, acVertLineColor);
//    TitleHorzLines     := TryGetIntProp  (obj, acHorzLines);
    TitleFillStyle     := GetOrdProp     (obj, acFillStyle);
  end;

  obj := GetObjProp(SkinData.FOwnerControl, acDataGrouping);
  if obj <> nil then
    DataGroupColor := TryGetColorProp(obj, acColor);

  obj := GetObjProp(SkinData.FOwnerControl, acRowCategories);
  if obj <> nil then begin
    CategoriesColor := TryGetColorProp(obj, acColor);
    obj := GetObjProp(obj, acFont);
    if obj <> nil then
      CategoriesFontColor := TryGetColorProp(obj, acColor);
  end;

  obj := GetObjProp(SkinData.FOwnerControl, acRowDetailPanel);
  if obj <> nil then
    TryChangeIntProp(obj, acColor, RowDetailColor);
end;


procedure TacGridEhWnd.SetSkinParams;
var
  obj: TObject;
begin
  inherited;
  with SkinData, SkinManager do begin
{$IFNDEF FPC}
    if {$IFDEF DELPHI7UP}acThemesEnabled and {$ENDIF} HasProperty(FOwnerControl, acOptionsEh) then
      SetSetPropValue(FOwnerControl, acOptionsEh, acdghFixed3D, False);
{$ENDIF}

    if EvenRowColor <> OddRowColor then begin
      TryChangeIntProp(FOwnerControl, acEvenRowColor, Palette[pcEditBG_EvenRow]);
      TryChangeIntProp(FOwnerControl, acOddRowColor,  Palette[pcEditBG_OddRow]);
    end;

    obj := GetObjProp(FOwnerControl, acGridLineParams);
    if obj <> nil then begin
      TryChangeIntProp(obj, acBrightColor,   BlendColors(clWhite, GetActiveEditColor, 51));
      TryChangeIntProp(obj, acDataHorzColor, BlendColors(GetActiveEditFontColor, GetActiveEditColor, 51));
      TryChangeIntProp(obj, acDataVertColor, BlendColors(GetActiveEditFontColor, GetActiveEditColor, 51));
      TryChangeIntProp(obj, acDarkColor,     BlendColors(clBlack, GetGlobalColor, 77));
    end;

    obj := GetObjProp(FOwnerControl, acIndicatorParams);
    if obj <> nil then begin
      TryChangeIntProp(obj, acColor, Palette[pcMainColor]);
      TryChangeIntProp(obj, acHorzLines, 0);
      TryChangeIntProp(obj, acVertLines, 0);
      SetOrdProp(obj, acFillStyle, 2);
    end;

    obj := GetObjProp(FOwnerControl, acTitleParams);
    if obj <> nil then begin
      TryChangeIntProp(obj, acColor, Palette[pcMainColor]);
      TryChangeIntProp(obj, acSecondColor, BlendColors($FFFFFF, Palette[pcMainColor], 26));
  //    TryChangeIntProp(obj, acHorzLines, 0);
      SetOrdProp(obj, acFillStyle, 3);
      TryChangeIntProp(obj, acVertLineColor, Palette[pcBorder]);
    end;

    obj := GetObjProp(FOwnerControl, acDataGrouping);
    if (obj <> nil) and (GetIntProp(obj, 'ParentColor') = 1) then
      TryChangeIntProp(obj, acColor, BlendColors($FFFFFF, Palette[pcMainColor], 26));

    obj := GetObjProp(FOwnerControl, acRowCategories);
    if obj <> nil then begin
      TryChangeIntProp(obj, acColor, BlendColors($FFFFFF, Palette[pcMainColor], 26));
      obj := GetObjProp(obj, acFont);
      if obj <> nil then
        TryChangeIntProp(obj, acColor, Palette[pcLabelText]);
    end;

    obj := GetObjProp(FOwnerControl, acRowDetailPanel);
    if obj <> nil then
      TryChangeIntProp(obj, acColor, Palette[pcMainColor]);
  end;
end;


procedure TacComboListWnd.acWndProc(var Message: TMessage);
var
  pDC, DC, SavedDC: hdc;
  wR, pR: TRect;
  BG: TacBGInfo;
  pt: TPoint;
  h: integer;

  procedure PrepareCache;
  begin
    InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
    if SimplyBox then
      SendAMessage(CtrlHandle, AC_PREPARECACHE)
    else
      with SkinData do begin
        GetWindowRect(CtrlHandle, wR);
        UpdateIndexes;
        SetSkinParams;
        FCacheBmp.Width := WidthOf(wR);
        FCacheBmp.Height := HeightOf(wR);
        FCacheBmp.Canvas.Brush.Style := bsSolid;
        FCacheBmp.Canvas.Brush.Color := Color;
        FCacheBmp.Canvas.Pen.Color := FrameColor;
        FCacheBmp.Canvas.Rectangle(MkRect(FCacheBmp));
        BGChanged := False;
      end;
  end;

begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_ERASEBKGND: begin
      if TWMPaint(Message).DC <> 0 then begin
        Message.Result := ERASE_OK;
        FillDC(TWMPaint(Message).DC, MkRect(WndSize), Color);
      end
      else
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);

      Exit;
    end;

    WM_VSCROLL, WM_HSCROLL: begin // Direct calling of standard scrolling
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      Exit;
    end;

    WM_NCCALCSIZE: begin
      Message.Result := Ac_NCCalcSize(Self, Self.CtrlHandle, Message.wParam, Message.lParam);
      Exit;
    end;

    WM_NCLBUTTONDBLCLK, WM_NCLBUTTONDOWN:
      with Message do begin
        wParam := Ac_NCHitTest(Self, CtrlHandle, WParam, LParam);
        if wParam in [HTHSCROLL, HTVSCROLL] then
          Result := Ac_NCLButtonDown(Self, CtrlHandle, wParam, lParam);

        Exit;
      end;

    WM_LBUTTONUP:
      with Message do begin
        InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
        h := LParam;
        pt.x := SmallInt(LoWord(longword(LParam)));
        pt.y := SmallInt(HiWord(longWord(LParam)));
        inc(pt.X, Self.WndRect.Left);
        inc(pt.Y, Self.WndRect.Top);
        LParam := MakeLParam(Word(pt.X), Word(pt.Y));
        WParam := Ac_NCHitTest(Self, CtrlHandle, WParam, LParam);
        if not (WParam in [Windows.HTNOWHERE, HTCLIENT]) then begin
          Result := Ac_LButtonUp(Self, CtrlHandle, WParam, LParam);
          if SimplyBox then
            ReleaseCapture;
        end
        else begin
          LParam := h;
          Ac_LButtonUp(Self, CtrlHandle, WParam, LParam);
        end;
        Exit;
      end;

    WM_PRINT, WM_PRINTCLIENT:
      with Message do begin
        if (WParam <> 0) and IsWindowVisible(CtrlHandle) then begin
          PrepareCache;
          Result := CallPrevWndProc(CtrlHandle, Msg, WParam, LParam);
          if (Msg = WM_PRINTCLIENT) or (ProcessMessage(LB_GETCOUNT, 0, 0) < 1) then
            Exit;

          DC := hdc(WParam);
          OffsetRect(wR, -wR.Left, -wR.Top);
          if (uCurrentScrollPortion = HTSCROLL_NONE) and not Showed then
            BitBltBorder(DC, wR.Left, wR.Top, WidthOf(wR), HeightOf(wR), SkinData.FCacheBmp.Canvas.Handle, 0, 0, 1);

          Result := Ac_NCDraw(Self, Self.CtrlHandle, -1, DC);
        end;
        Exit;
      end;

    WM_NCPAINT:
      if not DontRepaint then begin
        InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
        PrepareCache;
        if not DlgMode then
          UpdateWndCorners(SkinData, 0, Self);

        DC := GetWindowDC(CtrlHandle);
        SavedDC := SaveDC(DC);
        try
          BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, 1);//2);
          Message.Result := Ac_NCDraw(Self, Self.CtrlHandle, -1, DC);
          if SimplyBox then begin
            BG.PleaseDraw := False;
            GetBGInfo(@BG, GetParent(GetParent(CtrlHandle))); // Get and draw a piece of the dialog BG
            GetWindowRect(ParentWnd, pR);
            h := pR.Bottom - WndRect.Bottom;
            OffsetRect(WndRect, -WndRect.Left, -WndRect.Top);
            OffsetRect(pR, -pR.Left, -pR.Top);
            wR := Rect(0, WndRect.Bottom, WndRect.Right, HeightOf(pR));

            pDC := GetWindowDC(GetParent(CtrlHandle));
            GetWindowRect(GetParent(ParentWnd), wR);
            pR := ParentRect;
            if BG.BgType = btCache then
              BitBlt(pDC, 0, HeightOf(pR) - h, WidthOf(pR), HeightOf(pR), BG.Bmp.Canvas.Handle, pR.Left - wR.Left + BG.Offset.X, pR.Top - wR.Top + WndSize.cy + BG.Offset.Y, SRCCOPY)
            else
              FillDC(pDC, Rect(0, HeightOf(pR) - h, WidthOf(pR), HeightOf(pR)), BG.Color);

            ReleaseDC(GetParent(CtrlHandle), pDC);
          end;
        finally
          RestoreDC(DC, SavedDC);
          ReleaseDC(CtrlHandle, DC);
        end;
        Exit;
      end;

    $1AF: begin
      Showed := False;
      if SkinData <> nil then
        SkinData.BGChanged := True;
    end;
    
    $1AE:
      Showed := True;
  end;
  inherited acWndProc(Message);
  case Message.Msg of
    WM_WINDOWPOSCHANGED:
      UpdateScrolls(Self, True);
  end;
end;


procedure TacComboListWnd.AfterCreation;
begin
  if SkinData = nil then
    InitSkinData;

  Showed := False;
  DBScroll := False;
  GetWindowRect(CtrlHandle, WndRect);
  inherited;
end;


constructor TacComboListWnd.CreateEx(AHandle: hwnd; ASkinData: TsCommonData; ASkinManager: TsSkinManager; const SkinSection: string; Repaint, Simply: boolean);
var
  sp: TacSkinParams;
begin
  SimplyBox := Simply;
  sp.SkinSection := SkinSection;
  sp.HorzScrollBtnSize := -1;
  sp.VertScrollBtnSize := -1;
  sp.HorzScrollSize := -1;
  sp.VertScrollSize := -1;
  sp.UseSkinColor := True;
  sp.UseSkinFontColor := True;
  sp.Control := nil;
  Create(AHandle, ASkinData, ASkinManager, sp, Repaint);
  if not SimplyBox then
    SetWindowPos(CtrlHandle, 0, 0, 0, WndSize.cx + 1, WndSize.cy, SWPA_FRAMECHANGED and not SWP_NOSIZE);
end;


destructor TacComboListWnd.Destroy;
begin
  if uxthemeLib <> 0 then
    Ac_SetWindowTheme(CtrlHandle, nil, nil);

  if SkinData <> nil then
    FreeAndNil(SkinData);

  inherited;
end;


procedure TacComboListWnd.SetSkinParams;
begin
  if not bPreventStyleChange then begin
    if Assigned(SkinData) then
      SkinData.Updating := True;

    bPreventStyleChange := True;
    with SkinData, SkinManager do
      if Assigned(SkinData) and Assigned(SkinManager) and IsValidSkinIndex(SkinIndex) then begin
        if not CustomColor then
          if not DlgMode then
            Color := gd[SkinIndex].Props[integer(gd[SkinIndex].States > 1)].Color
          else
            Color := ColorToRGB(clWindow);

        FrameColor := Palette[pcBorder];
        if SkinData <> nil then begin
          BGChanged := True;
          Updating := False;
        end;
      end
      else
        FrameColor := clBlack;

    bPreventStyleChange := False;
  end;
end;


procedure TacBaseWnd.acWndProc(var Message: TMessage);
begin
  if Destroyed or not Assigned(SkinData) or not SkinData.Skinned then
    inherited
  else begin
    case Message.Msg of
      SM_ALPHACMD:
        case Message.WParamHi of
          AC_REFRESH:
            if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
              inherited;
              if IsWindowVisible(CtrlHandle) then
                SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);

              Exit;
            end;
            
          AC_PREPARECACHE:
            if SkinData <> nil then
              PrepareCache(SkinData, CtrlHandle);
        end;

      WM_EXITSIZEMOVE, WM_SIZE:
        if SkinData <> nil then
          SkinData.BGChanged := True;

      WM_SETCURSOR: begin
        Message.Result := Ac_SetCursor(Self, CtrlHandle, Message.WPAram, Message.LParam);
        Exit
      end;

      8448:
        Exit;
    end;
    inherited;
    case Message.Msg of
      WM_ENABLE, CM_ENABLEDCHANGED:
        if IsWindowVisible(CtrlHandle) then
          SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);

      WM_SIZE, WM_HSCROLL, WM_VSCROLL:
        if not DontRepaint then
          UpdateScrolls(Self, True)
    end;
  end;
end;


type
  TAccessProvider = class(TsSkinProvider);


procedure TacMDIWnd.acWndProc(var Message: TMessage);
var
  DC, SavedDC: HDC;
  si: TScrollInfo;

  function DstRect(const sp: TsSkinProvider): TRect;
  begin
    GetWindowRect(sp.Form.ClientHandle, Result);
    OffsetRect(Result, -Result.Left, -Result.Top);
  end;

  function SrcRect(const sp: TsSkinProvider): TRect;
  var
    fR: TRect;
    dX, dY: integer;
  begin
    GetWindowRect(sp.Form.Handle, fR);
    GetWindowRect(sp.Form.ClientHandle, Result);
    if sp.BorderForm <> nil then begin
      dX := DiffBorder(sp.BorderForm) + sp.ShadowSize.Left;
      dY := DiffTitle (sp.BorderForm) + sp.ShadowSize.Top;
    end
    else begin
      dX := 0;
      dY := 0;
    end;
    OffsetRect(Result, -fR.Left + dX, - fR.Top + dY);
  end;

  procedure PaintClient(const DC: HDC; PaintBorder: boolean);
  var
    SrcR, DstR: TRect;
    bw, W, H: Integer;
    sp: TAccessProvider;
  begin
    sp := TAccessProvider(SkinProvider);
    if not sp.fAnimating then
      with sp.SkinData do begin
        SrcR := SrcRect(sp);
        DstR := DstRect(sp);
        w := WidthOf(SrcR);
        h := HeightOf(SrcR);
        bw := SkinManager.GetSkinIndex(s_MdiArea);
        if IsCached(sp.SkinData) or (bw >= 0) then begin
          if (FCacheBmp = nil) or BGChanged then
            sp.PaintAll;

          if FCacheBmp <> nil then begin
            if PaintBorder then
              bw := 0
            else
              bw := integer(GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE <> 0) * 2;

            BitBlt(DC, DstR.Left, DstR.Top, w, h, FCacheBmp.Canvas.Handle, SrcR.Left + bw, SrcR.Top + bw, SRCCOPY);
          end;
        end
        else
          FillDC(DC, DstR, sp.FormColor);
      end;
  end;

  procedure PaintBorders(const DC: HDC);
  var
    sp: TAccessProvider;
    bw, W, H: Integer;
    R: TRect;
  begin
    sp := TAccessProvider(SkinProvider);
    if MDISkinData.FCacheBmp <> nil then begin
      R := SrcRect(sp);
      w := WidthOf(R);
      h := HeightOf(R);
      bw := sp.SkinData.SkinManager.GetSkinIndex(s_MdiArea);
      if IsCached(sp.SkinData) or (bw >= 0) then
        BitBltBorder(DC, 0, 0, w, h, MDISkinData.FCacheBmp.Canvas.Handle, R.Left, R.Top, 2)
      else begin
        bw := integer(GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE <> 0) * 2;
        FillDCBorder(DC, MkRect(w, h), bw, bw, bw, bw, sp.FormColor);
      end;
    end;
  end;

begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_GETCACHE: begin
        SendAMessage(FForm, AC_GETCACHE);
        Exit;
      end;

      AC_BEFORESCROLL: begin
        if Message.LParamLo in [SB_THUMBTRACK, SB_THUMBPOSITION] then
          Message.Result := 1; // it's MDI THUMB

        Exit;
      end;

      AC_AFTERSCROLL: begin
        UpdateScrolls(Self, True);
        Exit;
      end;

      AC_GETBG: begin
        SendMessage(FForm.Handle, Message.Msg, Message.WParam, Message.LParam);
        Exit;
      end;
    end
  else
    if MDISkinData <> nil then
      case Message.Msg of
        WM_MDICREATE: begin
          Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
          if Message.Result <> 0 then
            acDials.AddSupportedForm(Message.Result);

          Exit;
        end;

        WM_PRINT:
          if MDISkinData.Skinned and DrawSkinnedMDIWall and DrawSkinnedMDIScrolls and (TWMPaint(Message).DC <> 0) then begin
            Message.Result := 0;
            if TsSkinProvider(SkinProvider).BorderForm <> nil then
              Exit;

            if Assigned(FForm.ActiveMDIChild) and (FForm.ActiveMDIChild.WindowState = wsMaximized) then
              Exit;

            SavedDC := SaveDC(TWMPaint(Message).DC);
            try
              PaintClient(TWMPaint(Message).DC, True);
              Ac_NCDraw(Self, Self.CtrlHandle, -1, TWMPaint(Message).DC);
            finally
              RestoreDC(TWMPaint(Message).DC, SavedDC);
            end;
            Exit;
          end;

        WM_NCPAINT:
          if MDISkinData.Skinned and DrawSkinnedMDIWall and DrawSkinnedMDIScrolls then begin
            if not (Assigned(FForm.ActiveMDIChild) and (FForm.ActiveMDIChild.WindowState = wsMaximized)) and not InAnimationProcess then begin
              DC := GetWindowDC(FForm.ClientHandle);
              try
                PaintBorders(DC);
                Message.Result := Ac_NCDraw(Self, Self.CtrlHandle, -1, DC);
              finally
                ReleaseDC(FForm.ClientHandle, DC);
              end;
            end;
            Message.Result := 1;
            Exit;
          end;

        WM_PAINT:
          if InAnimationProcess then
            Exit;

        WM_ERASEBKGND:
          if MDISkinData.Skinned and DrawSkinnedMDIWall and DrawSkinnedMDIScrolls and (TWMEraseBkGnd(Message).DC <> 0) then begin
            if InAnimationProcess then
              Exit;

            if Assigned(FForm.ActiveMDIChild) and (FForm.ActiveMDIChild.WindowState = wsMaximized) then
              UpdateGraphControls
            else begin
              DC := TWMEraseBkGnd(Message).DC;
              SavedDC := SaveDC(DC);
              try
                PaintClient(DC, False);
              finally
                RestoreDC(DC, SavedDC);
              end;
            end;
            Message.Result := ERASE_OK;
            Exit;
          end;

        WM_STYLECHANGED: begin
          Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
          Exit;
        end;

        WM_WINDOWPOSCHANGING:
          TsSkinProvider(MDISkinProvider).SkinData.BGChanged := True;

        WM_MDISETMENU:
          with TAccessProvider(MDISkinProvider) do begin
            Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
            SkinData.BGChanged := True;
            MenuChanged := True;
            FLinesCount := -1;
            Exit;
          end;

        WM_MDITILE, WM_MDICASCADE:
          with TAccessProvider(MDISkinProvider) do begin
            Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
            SkinData.BGChanged := True;
            FLinesCount := -1;
            if (Form.FormStyle = fsMDIForm) and Assigned(Form.ActiveMDIChild) then
              SetWindowLong(Form.ActiveMDIChild.Handle, GWL_STYLE, GetWindowLong(Form.ActiveMDIChild.Handle, GWL_STYLE) and not WS_SYSMENU);

            if Assigned(MDIForm) then
              TsMDIForm(MDIForm).UpdateMDIIconItem;

            InvalidateRect(CtrlHandle, nil, True);
            RedrawWindow(Form.ClientHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
            SystemMenu.UpdateItems;
            Exit;
          end;

        WM_WINDOWPOSCHANGED:
          if SkinProvider <> nil then // Update menu after restoring of child windows (WindowState := wsNormal)
            RedrawWindow(TsSkinProvider(SkinProvider).Form.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);

        WM_VSCROLL, WM_HSCROLL: begin
          if Message.WParamLo = SB_THUMBTRACK then
            Exit;
            
          if Message.WParamLo = SB_THUMBPOSITION then begin
            si.cbSize := SizeOf(TScrollInfo);
            si.fMask := SIF_ALL;
            if Message.Msg = WM_VSCROLL then begin
              GetScrollInfo(CtrlHandle, SB_VERT, {$IFDEF FPC}@SI{$ELSE}SI{$ENDIF});
              ScrollWindow(CtrlHandle, 0, (si.nPos - si.nMin - (nLastSBPos - 1)) * 8, nil, nil);
            end
            else begin
              GetScrollInfo(CtrlHandle, SB_HORZ, {$IFDEF FPC}@SI{$ELSE}SI{$ENDIF});
              ScrollWindow(CtrlHandle, (si.nPos - si.nMin - (nLastSBPos - 1)) * 8, 0, nil, nil);
            end;
            Exit;
          end;
        end;
      end;

  inherited;
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_BEFORESCROLL:
          SendMessage(CtrlHandle, WM_SETREDRAW, 0, 0);

        AC_AFTERSCROLL: begin
          SendMessage(CtrlHandle, WM_SETREDRAW, 1, 0);
          if Message.LParamLo <> SB_THUMBTRACK then begin
            RedrawWindow(CtrlHandle, nil, 0, RDWA_ALL);
            UpdateScrolls(Self, False);
            ReleaseCapture
          end
        end;
      end;

    WM_MDIREFRESHMENU:
      UpdateSkinCaption(TsSkinProvider(SkinProvider));

    WM_PARENTNOTIFY, 63: begin
      sbarVert.fScrollVisible := GetWindowLong(CtrlHandle, GWL_STYLE) and WS_VSCROLL <> 0;
      sbarHorz.fScrollVisible := GetWindowLong(CtrlHandle, GWL_STYLE) and WS_HSCROLL <> 0;
      UpdateScrolls(Self, True);
    end;
  end;
end;


destructor TacMDIWnd.Destroy;
begin
  MDISkinData := nil;
  SkinProvider := nil;
  inherited;
end;


procedure TacMDIWnd.UpdateGraphControls;
{$IFNDEF ALITE}
var
  i: integer;
  BG: TacBGInfo;
{$ENDIF}
begin
{$IFNDEF ALITE}
  if (FForm.MDIChildCount > 0) and (FForm.ActiveMDIChild <> nil) and (FForm.ActiveMDIChild.WindowState = wsMaximized) then
    for i := 0 to FForm.ControlCount - 1 do
      if FForm.Controls[i] is TsSplitter then begin
        BG.BgType := btUnknown;
        BG.PleaseDraw := True;
        BG.R := FForm.Controls[i].BoundsRect;
        BG.DrawDC := FForm.Canvas.Handle;
        SendMessage(FForm.Handle, SM_ALPHACMD, AC_GETBG_HI, LPARAM(@BG));
      end;
{$ENDIF}
end;


procedure TacVirtualTreeViewWnd.acWndProc(var Message: TMessage);
var
  SavedDC, DC: hdc;
  pOffset: TPoint;
  HeaderProp: TObject;
  l: LParam;
begin
  if Assigned(SkinData) and SkinData.Skinned then
    case Message.Msg of
      WM_HSCROLL: begin
        if TWMVScroll(Message).ScrollCode = SB_THUMBTRACK then begin
          sBarHorz.ScrollInfo.cbSize := SizeOf(TScrollInfo);
          sBarHorz.ScrollInfo.fMask := SIF_ALL;
          sBarHorz.ScrollInfo.nPos := sBarHorz.ScrollInfo.nTrackPos;
          SetScrollInfo(CtrlHandle, SB_HORZ, {$IFDEF FPC}@sBarHorz.ScrollInfo{$ELSE}sBarHorz.ScrollInfo{$ENDIF}, False);
        end;
        inherited;
        Exit;
      end;

      WM_VSCROLL: begin
        if TWMVScroll(Message).ScrollCode = SB_THUMBTRACK then begin
          sBarVert.ScrollInfo.cbSize := SizeOf(TScrollInfo);
          sBarVert.ScrollInfo.fMask := SIF_ALL;
          sBarVert.ScrollInfo.nPos := sBarVert.ScrollInfo.nTrackPos;
          SetScrollInfo(CtrlHandle, SB_VERT, {$IFDEF FPC}@sBarVert.ScrollInfo{$ELSE}sBarVert.ScrollInfo{$ENDIF}, False);
        end;
        SendMessage(CtrlHandle, WM_SETREDRAW, 0, 0);
        inherited;
        SendMessage(CtrlHandle, WM_SETREDRAW, 1, 0);
        RedrawWindow(TWinControl(SkinData.FOwnerControl).Handle, nil, 0, RDWA_ALLNOW);
        Exit;
      end;

      WM_ERASEBKGND:
        Exit;

      WM_PRINT: begin
        SkinData.Updating := False;
        DC := TWMPaint(Message).DC;
        if SkinData.BGChanged then begin
          if not ParamsChanged then
            SetSkinParams;

          if SkinData = nil then
            Exit;
            
          PrepareCache(SkinData, CtrlHandle);
        end;
        SavedDC := SaveDC(DC);
        pOffset.X := cxLeftEdge;
        pOffset.Y := cxLeftEdge;
        HeaderProp := GetObjProp(SkinData.FOwnerControl, acHeader);
{$IFNDEF FPC}
        if HeaderProp <> nil then begin
          if CheckSetProp(HeaderProp, acOptions, achoVisible) then
            inc(pOffset.Y, GetIntProp(HeaderProp, acHeight))
        end
        else
{$ENDIF}
          pOffset.Y := cxLeftEdge;

        MoveWindowOrg(DC, pOffset.X, pOffset.Y);
        l := 0;
        CallPrevWndProc(CtrlHandle, WM_PRINTCLIENT, WPARAM(DC), LPARAM(l));
        RestoreDC(DC, SavedDC);
        CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        UpdateWndCorners(SkinData, 0, Self);
        BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, cxLeftEdge);
        Message.Result := Ac_NCDraw(Self, CtrlHandle, -1, DC);
        Exit;
      end;

      WM_NCPAINT:
        if IsWindowVisible(CtrlHandle) then begin
          InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
          if InUpdating(SkinData) then
            Exit;

          if SkinData.BGChanged then begin
            if not ParamsChanged then
              SetSkinParams;

            PrepareCache(SkinData, CtrlHandle, DlgMode);
          end;
          UpdateWndCorners(SkinData, 0, Self);
          DC := GetWindowDC(CtrlHandle);
          SavedDC := SaveDC(DC);
          try
            BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle,
                         0, 0, 2 * integer(GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE = WS_EX_CLIENTEDGE));
            l := 0;
            CallPrevWndProc(CtrlHandle, WM_PRINT, WPARAM(DC), LPARAM(l));
            Message.Result := Ac_NCDraw(Self, Self.CtrlHandle, -1, DC);
          finally
            RestoreDC(DC, SavedDC);
            ReleaseDC(CtrlHandle, DC);
          end;
          Exit;
        end;
    end;

  inherited;
end;


procedure TacVirtualTreeViewWnd.RestoreStdParams;
var
  Method: TMethod;
  PropInfo: PPropInfo;
  obj, Obj2, HeaderProp: TObject;
  PEvent1: PAdvancedHeaderPaintEvent;
  PEvent2: PHeaderPaintQueryElementsEvent;
begin
  inherited;
  if not (csDestroying in SkinData.FOwnerControl.ComponentState) then begin
    if HasProperty(SkinData.FOwnerControl, acVETColors) then begin
      obj := GetObjProp(SkinData.FOwnerControl, acVETColors);
      if obj <> nil then begin
        SetIntProp(obj, acCompressedTextColor, CompressedTextColor);
        SetIntProp(obj, acFileTextColor,       FileTextColor);
        SetIntProp(obj, acFolderTextColor,     FolderTextColor);
      end;
    end;

    if HasProperty(SkinData.FOwnerControl, acColors) then begin
      obj := GetObjProp(SkinData.FOwnerControl, acColors);
      if obj <> nil then begin
        SetIntProp(obj, acFocusedSelectionBorderColor,   FocusedSelectionBorderColor);
        SetIntProp(obj, acFocusedSelectionColor,         FocusedSelectionColor);
        SetIntProp(obj, acUnfocusedSelectionBorderColor, UnfocusedSelectionBorderColor);
        SetIntProp(obj, acUnfocusedSelectionColor,       UnfocusedSelectionColor);
        SetIntProp(obj, acSelectionTextColor,            SelectionTextColor);
        SetIntProp(obj, acHotColor,                      HotColor);
      end;
    end;                                         

    PropInfo := GetPropInfo(SkinData.FOwnerControl.ClassInfo, acOnAdvancedHeaderDraw);
    if (PropInfo <> nil) and (PropInfo^.PropType^^.Kind = tkMethod) then begin
      Method := GetMethodProp(SkinData.FOwnerControl, PropInfo);
      if Assigned(Method.Code) then begin
        PEvent1 := PAdvancedHeaderPaintEvent(@Method.Code);
        PEvent1^ := nil;
        Method.Data := Self;
        SetMethodProp(SkinData.FOwnerControl, PropInfo, Method);
      end;
    end;
    PropInfo := GetPropInfo(SkinData.FOwnerControl.ClassInfo, acOnHeaderDrawQueryElements);
    if (PropInfo <> nil) and (PropInfo^.PropType^^.Kind = tkMethod) then begin
      Method := GetMethodProp(SkinData.FOwnerControl, PropInfo);
      if Assigned(Method.Code) then begin
        PEvent2 := PHeaderPaintQueryElementsEvent(@Method.Code);
        PEvent2^ := nil;
        Method.Data := Self;
        SetMethodProp(SkinData.FOwnerControl, PropInfo, Method);
      end;
    end;

    HeaderProp := GetObjProp(SkinData.FOwnerControl, acHeader);
{$IFNDEF FPC}
    if HeaderProp <> nil then
      SetSetPropValue(HeaderProp, acOptions, achoOwnerDraw, OwnerDraw);
{$ENDIF}

    Obj2 := GetObjProp(SkinData.FOwnerControl, acPaintInfoColumn);
    if Obj2 <> nil then begin
      TryChangeIntProp(SkinData.FOwnerControl, acThemed, 1);
      TryChangeIntProp(Obj2, acColor, clBtnFace);
      HeaderProp := GetObjProp(SkinData.FOwnerControl, acHeader);
      if HeaderProp <> nil then begin
        TryChangeIntProp(HeaderProp, acColor, clBtnFace);
        obj := GetObjProp(HeaderProp, acFont);
        TryChangeIntProp(obj, acColor, clBtnText);
      end;
    end;
  end;
end;


procedure TacVirtualTreeViewWnd.SetSkinParams;
var
  C: TColor;
  Method: TMethod;
  obj, Obj2, HeaderProp: TObject;
  PEvent1: PAdvancedHeaderPaintEvent;
  PEvent2: PHeaderPaintQueryElementsEvent;
begin
  inherited;
  if HasProperty(SkinData.FOwnerControl, acVETColors) then begin
    obj := GetObjProp(SkinData.FOwnerControl, acVETColors);
    if obj <> nil then begin
      C := SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].FontColor.Color;
      SetIntProp(obj, acCompressedTextColor, C);
      SetIntProp(obj, acFileTextColor,       C);
      SetIntProp(obj, acFolderTextColor,     C);
    end;
  end;

  if HasProperty(SkinData.FOwnerControl, acColors) then begin
    obj := GetObjProp(SkinData.FOwnerControl, acColors);
    if obj <> nil then begin
      C := SkinData.SkinManager.GetHighLightColor;
      SetIntProp(obj, acFocusedSelectionBorderColor, C);
      SetIntProp(obj, acFocusedSelectionColor, C);
      SetIntProp(obj, acHotColor, SkinData.SkinManager.GetActiveEditFontColor);
      C := BlendColors(C, SkinData.SkinManager.GetActiveEditColor, 127);
      SetIntProp(obj, acUnfocusedSelectionBorderColor, C);
      SetIntProp(obj, acUnfocusedSelectionColor, C);
      SetIntProp(obj, acSelectionTextColor, SkinData.SkinManager.GetHighLightfontColor);
    end;
  end;

  PropInfo := GetPropInfo(SkinData.FOwnerControl.ClassInfo, acOnAdvancedHeaderDraw);
  if (PropInfo <> nil) and (PropInfo^.PropType^^.Kind = tkMethod) then begin
    Method := GetMethodProp(SkinData.FOwnerControl, PropInfo);
    if not Assigned(Method.Code) then begin
      PEvent1 := PAdvancedHeaderPaintEvent(@Method.Code);
      PEvent1^ := AdvancedHeaderDraw;
      Method.Data := Self;
      SetMethodProp(SkinData.FOwnerControl, PropInfo, Method);
      PropInfo := GetPropInfo(SkinData.FOwnerControl.ClassInfo, acOnHeaderDrawQueryElements);
      if (PropInfo <> nil) and (PropInfo^.PropType^^.Kind = tkMethod) then begin
        Method := GetMethodProp(SkinData.FOwnerControl, PropInfo);
        if not Assigned(Method.Code) then begin
          PEvent2 := PHeaderPaintQueryElementsEvent(@Method.Code);
          PEvent2^ := HeaderDrawQueryElements;
          Method.Data := Self;
          SetMethodProp(SkinData.FOwnerControl, PropInfo, Method);
        end;
      end;
{$IFNDEF FPC}
      if PropInfo <> nil then begin
        HeaderProp := GetObjProp(SkinData.FOwnerControl, acHeader);
        if HeaderProp <> nil then
          SetSetPropValue(HeaderProp, acOptions, achoOwnerDraw, True);
      end;
{$ENDIF}
    end;
  end;
  Obj2 := GetObjProp(SkinData.FOwnerControl, acPaintInfoColumn);
  if Obj2 <> nil then begin
    TryChangeIntProp(Obj2, acColor, SkinData.SkinManager.GetGlobalColor);
    TryChangeIntProp(Obj2, acStyle, 1);
    HeaderProp := GetObjProp(SkinData.FOwnerControl, acHeader);
    if HeaderProp <> nil then begin
      TryChangeIntProp(HeaderProp, acColor, SkinData.SkinManager.GetActiveEditColor);
      obj := GetObjProp(HeaderProp, acFont);
      TryChangeIntProp(obj, acColor, SkinData.SkinManager.GetGlobalFontColor);
      if TWinControl(SkinData.FOwnerControl).HandleAllocated then
        RedrawWindow(TWinControl(SkinData.FOwnerControl).Handle, nil, 0, RDWA_NOCHILDRENNOW);
    end;
  end;
end;


procedure TacVirtualTreeViewWnd.SaveStdParams;
var
  obj: TObject;
  HeaderProp: TObject;
begin
  inherited;
  if HasProperty(SkinData.FOwnerControl, acVETColors) then begin
    obj := GetObjProp(SkinData.FOwnerControl, acVETColors);
    if obj <> nil then begin
      CompressedTextColor := GetIntProp(obj, acCompressedTextColor);
      FileTextColor       := GetIntProp(obj, acFileTextColor);
      FolderTextColor     := GetIntProp(obj, acFolderTextColor);
    end;
  end;
  if HasProperty(SkinData.FOwnerControl, acColors) then begin
    obj := GetObjProp(SkinData.FOwnerControl, acColors);
    if obj <> nil then begin
      FocusedSelectionBorderColor   := GetIntProp(obj, acFocusedSelectionBorderColor);
      FocusedSelectionColor         := GetIntProp(obj, acFocusedSelectionColor);
      UnfocusedSelectionBorderColor := GetIntProp(obj, acUnfocusedSelectionBorderColor);
      UnfocusedSelectionColor       := GetIntProp(obj, acUnfocusedSelectionColor);
      SelectionTextColor            := GetIntProp(obj, acSelectionTextColor);
      HotColor                      := GetIntProp(obj, acHotColor);
    end;
  end;
  HeaderProp := GetObjProp(SkinData.FOwnerControl, acHeader);
{$IFNDEF FPC}
  if HeaderProp <> nil then
    OwnerDraw := CheckSetProp(HeaderProp, acOptions, achoOwnerDraw);
{$ENDIF}
end;


procedure TacVirtualTreeViewWnd.AdvancedHeaderDraw(Sender: TPersistent; var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements);
var
  C: TColor;
  Bmp: TBitmap;
  Side: TacSide;
  Text: acString;
  Flags: Cardinal;
  TextRC, gR: TRect;
  si, State, Index: integer;
  HeaderProp, FontProp: TObject;
begin
  if Assigned(Self) and not DontRepaint and Assigned(SkinData) and SkinData.Skinned and (PaintInfo.TargetCanvas <> nil) then
    with SkinData.SkinManager do begin
      if IsValidSkinIndex(ConstData.Sections[ssColHeader]) then
        si := ConstData.Sections[ssColHeader]
      else
        si := ConstData.Sections[ssButton];

      if PaintInfo.Column = nil then begin
        Bmp := CreateBmp32(PaintInfo.PaintRectangle);
        PaintItem(si, MakeCacheInfo(SkinData.FCacheBmp), True, 0, MkRect(Bmp), PaintInfo.PaintRectangle.TopLeft, Bmp);
        BitBlt(PaintInfo.TargetCanvas.Handle, PaintInfo.PaintRectangle.Left, PaintInfo.PaintRectangle.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        Bmp.Free;
      end
      else begin
        if PaintInfo.IsDownIndex then
          State := 2
        else
          State := integer(PaintInfo.IsHoverIndex);

        Bmp := CreateBmp32(PaintInfo.PaintRectangle);
        if hpeBackground in Elements then begin
          PaintItem(si, MakeCacheInfo(SkinData.FCacheBmp), True, State, MkRect(Bmp), PaintInfo.PaintRectangle.TopLeft, Bmp);
          BitBlt(PaintInfo.TargetCanvas.Handle, PaintInfo.PaintRectangle.Left, PaintInfo.PaintRectangle.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        end
        else begin
          BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, PaintInfo.TargetCanvas.Handle, PaintInfo.PaintRectangle.Left, PaintInfo.PaintRectangle.Top, SRCCOPY);
          if (hpeText in Elements) and not (hpeDropMark in Elements) then begin
{$IFDEF TNTUNICODE}
            Text := GetWideStrProp(PaintInfo.Column, acText);
{$ELSE}
            Text := GetStrProp(PaintInfo.Column, acText);
{$ENDIF}
            if Text <> '' then begin
              TextRC := PaintInfo.TextRectangle;
              OffsetRect(TextRC, -PaintInfo.PaintRectangle.Left, -PaintInfo.PaintRectangle.Top);
              HeaderProp := GetObjProp(SkinData.FOwnerControl, acHeader);
              if HeaderProp <> nil then begin
                FontProp := GetObjProp(HeaderProp, acFont);
                if FontProp <> nil then
                  Bmp.Canvas.Font.Assign(TFont(FontProp));
              end;
              acWriteTextEx(Bmp.Canvas, PacChar(Text), True, TextRC, 0, Si, State <> 0, DefaultManager);
            end;
          end;
          if (hpeSortGlyph in Elements) and PaintInfo.ShowSortGlyph then begin
            HeaderProp := GetObjProp(SkinData.FOwnerControl, acHeader);
            if HeaderProp <> nil then begin
              Side := asTop;
              if GetOrdProp(HeaderProp, acSortDirection) = 0 then
                Index := ConstData.ScrollBtns[asTop].GlyphIndex
              else
                Index := ConstData.ScrollBtns[asBottom].GlyphIndex;

              if Index >= 0 then
                DrawSkinGlyph(Bmp, Point(PaintInfo.SortGlyphPos.x - PaintInfo.PaintRectangle.Left,
                              (HeightOf(PaintInfo.PaintRectangle) - ma[Index].Height) div 2), State, 1, ma[Index], MakeCacheInfo(Bmp))
              else begin
                C := gd[ConstData.ScrollBtns[Side].SkinIndex].Props[min(State, ac_MaxPropsIndex)].FontColor.Color;
                gR.Left := PaintInfo.SortGlyphPos.x - PaintInfo.PaintRectangle.Left;
                gR.Top := (HeightOf(PaintInfo.PaintRectangle) - ma[Index].Height) div 2;
                gR.Bottom := gR.Top + 3;
                gR.Right := gR.Left + 6;
                if (State > 1) and ButtonsOptions.ShiftContentOnClick then
                  OffsetRect(gR, 1, 1);

                DrawColorArrow(Bmp, C, gR, Side);
              end;
            end;
          end;
          if hpeDropMark in Elements then begin
{$IFDEF TNTUNICODE}
            Text := GetWideStrProp(PaintInfo.Column, acText);
{$ELSE}
            Text := GetStrProp(PaintInfo.Column, acText);
{$ENDIF}
            if Text <> '' then begin
              TextRC := PaintInfo.TextRectangle;
              OffsetRect(TextRC, -PaintInfo.PaintRectangle.Left, -PaintInfo.PaintRectangle.Top);
              HeaderProp := GetObjProp(SkinData.FOwnerControl, acHeader);
              if HeaderProp <> nil then begin
                FontProp := GetObjProp(HeaderProp, acFont);
                if FontProp <> nil then
                  Bmp.Canvas.Font.Assign(TFont(FontProp));
              end;
              // HTG
              Flags := DT_VCENTER or DT_END_ELLIPSIS + TextWrapping[Pos(accoWrapCaption, GetSetProp(PaintInfo.Column, acOptions)) > 0];
              acWriteTextEx(Bmp.Canvas, PacChar(Text), True, TextRC, Flags, Si, State <> 0, DefaultManager);
            end;
          end;
          BitBlt(PaintInfo.TargetCanvas.Handle, PaintInfo.PaintRectangle.Left, PaintInfo.PaintRectangle.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        end;
        FreeAndNil(Bmp);
      end;
    end;
end;


procedure TacVirtualTreeViewWnd.HeaderDrawQueryElements(Sender: TPersistent; var PaintInfo: THeaderPaintInfo; var Elements: THeaderPaintElements);
begin
  Elements := [hpeBackground, hpeDropMark, hpeSortGlyph, hpeText]
end;


function TacMainWnd.ProcessMessage(Msg: Cardinal; WPar: WPARAM = 0; LPar: LPARAM = 0): LRESULT;
var
  M: TMessage;
begin
  M.Msg := Msg;
  M.WParam := WPar;
  M.LParam := LPar;
  acWndProc(M);
  Result := M.Result;
end;


procedure TacMainWnd.acWndProc(var Message: TMessage);
var
  i: integer;
begin
  case Message.Msg of
    WM_CREATE, WM_NCCREATE: begin
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      if SkinData <> nil then
        SkinData.InitCommonProp;
    end;

    WM_SIZE:
      SkinData.BGChanged := True;

    WM_UPDATEUISTATE:
      Exit;

{$IFNDEF FPC}
    WM_CONTEXTMENU:
      if (SkinData <> nil) and (SkinData.FOwnerControl <> nil) then
        with SkinData, TsAccessControl(FOwnerControl) do
          if PopupMenu <> nil then
            if SkinManager <> nil then
              SkinManager.SkinableMenus.HookPopupMenu(PopupMenu, SkinManager.Active);
{$ENDIF}

    WM_DESTROY, WM_NCDESTROY: begin
      if SkinData.AnimTimer <> nil then
        StopTimer(SkinData);

      HideGlow(SkinData.GlowID);
      if SkinData.FOwnerControl is TWinControl then
        with TWinControl(SkinData.FOwnerControl) do
          for i := 0 to ControlCount - 1 do
            if Controls[i] is TSpeedButton then
              Controls[i].Perform(WM_DESTROY, 0, 0);

      if (OldProc <> nil) or Assigned(OldWndProc) then
        try
          if SkinData.FOwnerControl <> nil then begin
            UninitializeACWnd(CtrlHandle, False, False, Self);
            Message.Result := SendMessage(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
          end
          else begin
            Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
            if Message.Result = 0 then
              UninitializeACWnd(CtrlHandle, False, False, Self);
          end;
        finally
          Message.Result := 1;
        end
      else
        Message.Result := SendMessage(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);

      Exit;
    end;

    WM_MOUSEMOVE:
      if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) and IsWindowEnabled(CtrlHandle) and (DefaultManager.ActiveControl <> CtrlHandle) then
        DefaultManager.ActiveControl := CtrlHandle;

    WM_SETTEXT: begin
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      Caption := GetWndText(CtrlHandle);
    end;

    WM_PRINT: begin
      Message.Result := SendMessage(CtrlHandle, WM_PAINT, Message.WParam, Message.LParam);
      Exit;
    end;
  end;
  if not Assigned(SkinData) or not Assigned(SkinData.SkinManager) or not SkinData.SkinManager.Active then
    Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam)
  else begin
    if Message.Msg = SM_ALPHACMD then
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit;
        end;

        AC_GETLISTSW: begin
          Message.Result := LResult(Self);
          Exit;
        end;

        AC_GETBG:
          if SkinData <> nil then begin
            InitBGInfo(SkinData, PacBGInfo(Message.LParam), 0, CtrlHandle);
            Exit;
          end;

        AC_PRINTING: begin
          if Message.LParam = 0 then
            SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_PRINTING
          else
            SkinData.CtrlSkinState := SkinData.CtrlSkinState or ACS_PRINTING;

          SkinData.PrintDC := hdc(Message.LParam);
        end;

        AC_SETNEWSKIN:
          with SkinData do
            if ACUInt(Message.LParam) = ACUInt(SkinManager) then begin
              UpdateIndexes;
              BGChanged := True;
              AlphaBroadCastCheck(FOwnerControl, CtrlHandle, Message);
            end;

        AC_ENDPARENTUPDATE:
          if SkinData.FUpdating then begin
            if not InUpdating(SkinData, True) then begin
              SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);
              RedrawWindow(CtrlHandle, nil, 0, RDWA_ALLNOW);
            end;
            if SkinData.FOwnerControl <> nil then
              SetParentUpdated(TWinControl(SkinData.FOwnerControl));

            Exit;
          end;

        AC_GETAPPLICATION: begin
          Message.Result := LRESULT(Application);
          Exit
        end;

        AC_REFRESH:
          with SkinData do
            if ACUInt(Message.LParam) = ACUInt(SkinManager) then begin
              UpdateIndexes;
              BGChanged := True;
              Updating := False;
              if not InAnimationProcess then
                if FOwnerControl <> nil then begin
                  if FOwnerControl.Visible then
                    SendMessage(CtrlHandle, WM_PAINT, 0, 0);
                end
                else
                  if IsWindowVisible(CtrlHandle) then
                    SendMessage(CtrlHandle, WM_PAINT, 0, 0);

              AlphaBroadCastCheck(FOwnerControl, CtrlHandle, Message);
              Exit;
            end;

        AC_PREPARING:
          if SkinData <> nil then begin
            Message.Result := LRESULT(SkinData.Updating);
            Exit;
          end;

        AC_SETSECTION: begin
          if (Message.LParam <> 0) and (SkinData <> nil) then begin
            SkinData.SkinSection := PacSectionInfo(Message.LParam).siName;
            Message.Result := 1;
          end
          else
            Message.Result := 0;

          Exit;
        end;

        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then
            RestoreStdParams;

        AC_PREPARECACHE:
          if SkinData <> nil then
            PrepareCache(SkinData, CtrlHandle);

        AC_CHILDCHANGED:
          if SkinData.FOwnerControl <> nil then begin
            CommonMessage(Message, SkinData);
            Exit;
          end;

        AC_GETCONTROLCOLOR: begin
          Message.Result := 0;
          Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
          if Message.Result = 0 then
            Message.Result := GetBGColor(SkinData, 0, CtrlHandle);

          Exit;
        end;

        AC_GETSKINDATA: begin
          Message.Result := LRESULT(SkinData);
          Exit;
        end
(*
        AC_GETFONTINDEX:
          if SkinData.Skinned then
            with SkinData.SkinManager.gd[SkinData.SkinIndex] do
              if NeedParentFont(SkinData) then
                Message.Result := GetFontIndex(SkinData.FOwnerControl.Parent, PacPaintInfo(Message.LParam))
              else
                if GiveOwnFont then begin
                  PacPaintInfo(Message.LParam)^.FontIndex := SkinData.SkinIndex; {Remove "GiveOwnFont" with updating of all skins}
                  Message.Result := 1;
                end;    *)
        else
          if CommonMessage(Message, SkinData) then
            Exit;

      end;

    Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
  end;
end;


procedure TacMainWnd.AfterCreation;
begin
  SkinData.Loading := False;
  SkinData.InitCommonProp;
end;


function TacMainWnd.CallPrevWndProc(const Handle: hwnd; const Msg: longint; const WParam: WPARAM; var LParam: LPARAM): LRESULT;
var
  M: TMessage;
begin
  if Assigned(OldWndProc) then begin
    M.Msg := Msg;
    M.WParam := WParam;
    M.LParam := LParam;
    M.Result := 0;
    OldWndProc(M);
    Result := M.Result;
    LParam := M.LParam;
  end
  else
    if Assigned(OldProc) then
      try
        Result := CallWindowProc(OldProc, Handle, Msg, WParam, LParam)
      except
        Result := 0;
      end
    else
      Result := 0;
end;


constructor TacMainWnd.Create(AHandle: hwnd; ASkinData: TsCommonData; ASkinManager: TsSkinManager; const SkinParams: TacSkinParams; Repaint: boolean);
begin
  CtrlHandle := AHandle;
  OldWndProc := nil;
  OldProc := nil;
  if uxthemeLib <> 0 then
    if (ASkinData = nil) or (ASkinData.COC <> COC_TsSkinProvider) {or not (ASkinData.FOwnerObject is TsSkinProvider) or TsSkinProvider(ASkinData.FOwnerObject).DrawNonClientArea} then
      if {$IFNDEF NOMNUHOOK}not (Self is TacMnuWnd) and{$ENDIF} (SkinParams.SkinSection <> s_Dialog) and not acDlgMode then
        Ac_SetWindowTheme(AHandle, s_Space, s_Space);

  NewWndProcInstance := nil;
  SkinManager := ASkinManager;
  Destroyed := False;
  if ASkinData <> nil then
    SkinData := ASkinData
  else begin
    OwnSkinData := True;
    InitSkinData;
    if SkinParams.SkinSection <> '' then
      SkinData.SkinSection := SkinParams.SkinSection;

    SkinData.FOwnerControl := SkinParams.Control;
    SkinData.FOwnerObject := TObject(SkinParams.Control);
    SkinData.CustomFont := not SkinParams.UseSkinFontColor;
    SkinData.CustomColor := not SkinParams.UseSkinColor;
  end;
  SkinData.CustomFont := ac_KeepOwnFont or SkinData.CustomFont;
  SkinData.FSWHandle := AHandle;
  Tag := 0;
  DlgMode := acDlgMode;
  SaveStdParams;
  ParamsChanged := False;
  Caption := GetWndText(AHandle);
  if not (Self is TacScrollWnd) then
    InitializeACWnd(Self, AHandle)
  else
    InitializeACScrolls(TacScrollWnd(Self), AHandle, Repaint);

  if SkinData.FOwnerControl <> nil then begin
    OldCtrlStyle := SkinData.FOwnerControl.ControlStyle;
    SkinData.FOwnerControl.ControlStyle := SkinData.FOwnerControl.ControlStyle + [csOpaque];
  end;
  AfterCreation;
end;


destructor TacMainWnd.Destroy;
begin
  if SkinData <> nil then begin
    if SkinManager <> nil then
      if not Destroyed then begin
        if (SkinData.FOwnerControl <> nil) and (OldCtrlStyle <> []) then
          SkinData.FOwnerControl.ControlStyle := OldCtrlStyle;

        if not ItemsRemoving or SkinManager.SkinRemoving or (Adapter <> nil) and TacCtrlAdapter(Adapter).Provider.SkinData.SkinManager.SkinRemoving then begin
          if Assigned(OldWndProc) then begin
            SkinData.WndProc := OldWndProc;
            if SkinData.FOwnerObject is TsSkinProvider then
              TsSkinProvider(SkinData.FOwnerObject).Form.WindowProc := OldWndProc
            else
              TacWinControl(SkinData.FOwnerControl).WindowProc := OldWndProc
          end
          else
            if OldProc <> nil then begin
              if DWord(GetWindowLong(CtrlHandle, GWL_WNDPROC)) = DWord(NewWndProcInstance) then
                SetWindowLong(CtrlHandle, GWL_WNDPROC, LONG_PTR(oldproc));

              oldproc := nil;
              if NewWndProcInstance <> nil then begin
                {$IFDEF DELPHI7UP}Classes.{$ENDIF}FreeObjectInstance(NewWndProcInstance);
                NewWndProcInstance := nil;
              end;
            end;

          RestoreStdParams;
        end;
        if (uxthemeLib <> 0) and (SkinData <> nil) then
          if (SkinData.FOwnerObject is TsSkinProvider) then begin
            if TsSkinProvider(SkinData.FOwnerObject).DrawNonClientArea then
              Ac_SetWindowTheme(CtrlHandle, nil, nil);
          end
          else
            if not ((SkinData.COC in [COC_TsListView]) and AeroIsEnabled) then
              Ac_SetWindowTheme(CtrlHandle, nil, nil);

        Destroyed := True;
      end
      else
        if (SkinData.FOwnerControl <> nil) and not (csDestroying in SkinData.FOwnerControl.ComponentState) then
          RestoreStdParams;

    if OwnSkinData then
      FreeAndNil(SkinData)
    else
      SkinData := nil;

    RemoveProp(CtrlHandle, acPropStr);
  end;
  SkinManager := nil;
  inherited Destroy;
end;


procedure TacMainWnd.InitSkinData;
begin
  if SkinData = nil then
    SkinData := TsCommonData.Create(nil, True);

  SkinData.Loading := True;
end;


procedure TacMainWnd.RestoreStdParams;
begin
  if Self.OwnSkinData then
    SkinData.RemoveCommonProp;

  RemoveProp(CtrlHandle, acPropStr);
end;


procedure TacMainWnd.SaveStdParams;
begin
//
end;


procedure TacMainWnd.SetSkinParams;
begin
  ParamsChanged := True;
end;


procedure TacStaticWnd.acWndProc(var Message: TMessage);
var
  PS: TPaintStruct;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if (GetWindowLong(CtrlHandle, GWL_STYLE) and WS_TABSTOP = 0) and (GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_STATICEDGE = 0) then
    case Message.Msg of
      WM_UPDATEUISTATE:
        if IsWindowVisible(CtrlHandle) then begin
          Inherited;
          Exit
        end;

      WM_NCPAINT:
        Exit;

      WM_ERASEBKGND:
        if IsWindowVisible(CtrlHandle) then begin
          Message.Result := ERASE_OK;
          Exit;
        end;

      WM_PRINT: begin
        AC_WMPaint(TWMPaint(Message));
        Exit;
      end;

      WM_PAINT: begin
        BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
        if IsWindowVisible(CtrlHandle) then
          AC_WMPaint(TWMPaint(Message));

        EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
        Exit;
      end;

      WM_CANCELMODE: begin
        Inherited;
        Exit
      end;

      WM_ENABLE, WM_MOVE:
        if IsWindowVisible(CtrlHandle) then begin
          SkinData.BGChanged := True;
          Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
          RedrawWindow(CtrlHandle, nil, 0, RDW_ERASE or RDW_UPDATENOW or RDW_INVALIDATE);
          Exit;
        end;

      WM_SETTEXT:
        if IsWindowVisible(CtrlHandle) then begin
          ProcessMessage(WM_SETREDRAW, 0, 0);
          Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
          Caption := GetWndText(CtrlHandle);
          SkinData.BGChanged := True;
          ProcessMessage(WM_SETREDRAW, 1, 0);
          RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_UPDATENOW);
          Exit;
        end;
    end;

  inherited;
end;


procedure TacStaticWnd.AC_WMPaint(var Message: TWMPaint);
var
  DC, SavedDC: hdc;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  if Message.DC = 0 then
    DC := GetWindowDC(CtrlHandle)
  else
    DC := Message.DC;

  SavedDC := SaveDC(DC);
  if Application.BiDiMode = bdRightToLeft then
    acSetLayout(DC, 0);

  SkinData.BGChanged := True;
  SkinData.FCacheBmp.Width := WndSize.cx;
  SkinData.FCacheBmp.Height := WndSize.cy;
  PrepareCache(SkinData, CtrlHandle);
  if PaintText then
    BitBlt(DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);

  RestoreDC(DC, SavedDC);
  if Message.DC <> DC then
    ReleaseDC(CtrlHandle, DC);
end;


{$IFNDEF TNTUNICODE}
function _WStr(lpString: PWideChar; cchCount: Integer): WideString;
begin
  if cchCount = -1 then
    Result := lpString
  else
    Result := Copy(WideString(lpString), 1, cchCount);
end;


function ac_DrawTextW(hDC: HDC; lpString: PWideChar; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    Result := DrawTextW(hDC, lpString, nCount, lpRect, uFormat)
  else
    Result := DrawTextA(hDC, PAnsiChar(AnsiString(_WStr(lpString, nCount))), -1, lpRect, uFormat);
end;


function WStrEnd(Str: PWideChar): PWideChar;
begin
  // returns a pointer to the end of a null terminated string
  Result := Str;
  While Result^ <> #0 do
    Inc(Result);
end;


function WStrLen(Str: PWideChar): Cardinal;
begin
  Result := WStrEnd(Str) - Str;
end;
{$ENDIF}


procedure TacStaticWnd.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_Transparent;

  inherited;
end;


function TacStaticWnd.PaintText: boolean;
var
  rText: TRect;
  Flags: Cardinal;
  pi: TacPaintInfo;
  FontIndex: integer;
begin
  if Caption <> '' then begin
    SkinData.FCacheBmp.Canvas.Brush.Style := bsClear;
    rText := MkRect(WndSize);
    LoadCtrlFont(Self);
    Flags := DT_EXPANDTABS or DT_WORDBREAK or DT_NOCLIP or DT_TABSTOP;
    Flags := Flags or MAKEWORD(0, 10);
    if GetWindowLong(CtrlHandle, GWL_STYLE) and SS_NOPREFIX <> 0 then
      Flags := Flags or DT_NOPREFIX;

    if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_RIGHT <> 0 then
      Flags := Flags or DT_RIGHT;

    if Application.BiDiMode = bdRightToLeft then
      Flags := Flags or DT_RTLREADING;

    pi.SkinManager := SkinData.SkinManager;
    pi.R := MkRect;
    pi.State := 0;
    pi.FontIndex := -1;

    if (SendMessage(CtrlHandle, SM_ALPHACMD, AC_GETFONTINDEX_HI, LParam(@pi)) > 0) and (pi.FontIndex >= 0) then
      FontIndex := pi.FontIndex
    else
      FontIndex := SkinData.SkinIndex;

    acWriteTextEx(SkinData.FCacheBmp.Canvas, PacChar(Caption), True, rText, Flags, FontIndex, False);
  end;
  Result := True;
end;


procedure TacBtnWnd.ac_WMPaint(const Message: TWMPaint);
var
  PS: TPaintStruct;
  DC: hdc;
begin
  BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  if SkinData.Skinned then
    if not TimerIsActive(SkinData) then begin
      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      if not (InAnimationProcess and (0 = SkinData.PrintDC)) {if shown before animation} then begin
        SkinData.Updating := SkinData.Updating and not InAnimationProcess;
        if not SkinData.FUpdating then begin
          if Message.DC = 0 then
            DC := GetDC(CtrlHandle)
          else
            DC := Message.DC;

          if Application.BiDiMode = bdRightToLeft then
            acSetLayout(DC, 0);

          SkinData.BGChanged := True;
          PrepareCache;
          BitBlt(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
          if Message.DC = 0 then
            ReleaseDC(CtrlHandle, DC);
        end;
      end;
    end
    else begin
      DC := GetDC(CtrlHandle);
      if Application.BiDiMode = bdRightToLeft then
        acSetLayout(DC, 0);

      BitBlt(DC, 0, 0, SkinData.AnimTimer.BmpOut.Width, SkinData.AnimTimer.BmpOut.Height, SkinData.AnimTimer.BmpOut.Canvas.Handle, 0, 0, SRCCOPY);
      ReleaseDC(CtrlHandle, DC);
    end;

  EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
end;


procedure TacBtnWnd.acWndProc(var Message: TMessage);
var
  R: TRect;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_MOUSEENTER:
          if not SkinData.FMouseAbove and (DefaultManager.ActiveControl = CtrlHandle) and not SkinData.SkinManager.Options.NoMouseHover then begin
            GetWindowRect(CtrlHandle, R);
            if PtInRect(R, acMousePos) then begin
              SkinData.BGChanged := False;
              SkinData.Updating := False;
              SkinData.FMouseAbove := True;
              DoChangePaint(SkinData, 1, UpdateWindow_CB, True, False);
            end;
            Exit;
          end;

        AC_MOUSELEAVE:
          if SkinData.FMouseAbove then begin
            if (SkinData.FOwnerControl = nil) or not acMouseInControl(SkinData.FOwnerControl) then begin
              SkinData.Updating := False;
              SkinData.BGChanged := False;
              SkinData.FMouseAbove := False;
              DoChangePaint(SkinData, 0, UpdateWindow_CB, True, False, False);
            end;
            Exit;
          end;

        AC_ENDPARENTUPDATE:
          if SkinData.FUpdating then begin
            if not InUpdating(SkinData, True) then
              RedrawWindow(CtrlHandle, nil, 0, RDWA_ALLNOW);

            Exit;
          end;

        AC_PREPARECACHE: begin
          PrepareCache;
          Exit;
        end;
      end;

    WM_PAINT:
      if IsWindowVisible(CtrlHandle) or (SkinData.CtrlSkinState and ACS_PRINTING <> 0) then begin
        if not ParamsChanged then
          SetSkinParams;

        AC_WMPaint(TWMPaint(Message));
        Exit;
      end;

    WM_ENABLE:
      if IsWindowVisible(CtrlHandle) then begin
        SetRedraw(CtrlHandle, 0);
        Inherited;
        SetRedraw(CtrlHandle, 1);
        SkinData.BGChanged := True;
        Repaint;
        Exit;
      end;

    WM_MOUSELEAVE:
      if DefaultManager.ActiveControl = CtrlHandle then
        DefaultManager.ActiveControl := 0;

    WM_MOUSEHOVER:
      SendAMessage(CtrlHandle, AC_MOUSEENTER);
{
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      if not ac_WMLButtonDown(Message) then
        Exit;
}
    BM_SETSTATE:
      if IsWindowVisible(CtrlHandle) then begin
        SetRedraw(CtrlHandle, 0);
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        SetRedraw(CtrlHandle, 1);
        SkinData.BGChanged := True;
        StopTimer(SkinData);
        Repaint;
        Exit;
      end;

    WM_NCPAINT, WM_UPDATEUISTATE: begin
      Message.Result := 0;
      Exit;
    end;

    WM_ERASEBKGND: begin
      Message.Result := ERASE_OK;
      Exit;
    end;

    WM_PRINT: begin
      AC_WMPaint(TWMPaint(Message));
      Exit;
    end;

    WM_MOVE:
      with SkinData.SkinManager.gd[SkinData.SkinIndex] do
        if (Props[0].Transparency > 0) or (Props[1].Transparency > 0) and ControlIsActive(SkinData) then begin
          SkinData.BGChanged := True;
          Repaint;
        end;

//    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
//      StopTimer(SkinData);

    WM_SETFOCUS:
      if IsWindowEnabled(CtrlHandle) then begin
        SetRedraw(CtrlHandle, 0);
        inherited;
        SetRedraw(CtrlHandle, 1);
        SkinData.FFocused := True;
        SkinData.BGChanged := True;
        StopTimer(SkinData);
        RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_FRAME);
        Exit;
      end;

    WM_KILLFOCUS:
      if IsWindowEnabled(CtrlHandle) then begin
        if (SkinData.FOwnerControl = nil) or not (csDestroying in SkinData.FOwnerControl.ComponentState) then begin
          SetRedraw(CtrlHandle, 0);
          inherited;
          SetRedraw(CtrlHandle, 1);
          SkinData.FFocused := False;
          SkinData.BGChanged := True;
          RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_FRAME);
        end
        else
          inherited;

        Exit
      end;

    WM_SETTEXT:
      if IsWindowVisible(CtrlHandle) then begin
        SetRedraw(CtrlHandle, 0);
        inherited;
        SetRedraw(CtrlHandle, 1);
        SkinData.BGChanged := True;
        Repaint;
        Exit;
      end;

    WM_LBUTTONUP:
      if SkinData <> nil then
        if SkinData.FMouseAbove then begin
          StopTimer(SkinData);
          SkinData.FMouseAbove := False;
          inherited;
          if IsWindowVisible(CtrlHandle) then
            SendAMessage(CtrlHandle, AC_MOUSEENTER);
            
          Exit;
        end
        else begin
          inherited;
          if Assigned(SkinData) then begin
            StopTimer(SkinData);
            SkinData.BGChanged := False;
            DoChangePaint(SkinData, 0, UpdateWindow_CB, True, True);
          end;
          Exit;
        end;
  end;
  inherited;
  case Message.Msg of
    WM_MOUSEMOVE:
      if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) and IsWindowEnabled(CtrlHandle) and not SkinData.SkinManager.Options.NoMouseHover then begin
        GetWindowRect(CtrlHandle, R);
        if PtInRect(R, acMousePos) then begin
          if DefaultManager.ActiveControl <> CtrlHandle then
            DefaultManager.ActiveControl := CtrlHandle;
        end
        else
          if DefaultManager.ActiveControl = CtrlHandle then
            DefaultManager.ActiveControl := 0;
      end;
  end;
end;


procedure TacBtnWnd.PrepareCache;
var
  DC: hdc;
  R: TRect;
  p: TPoint;
  C: TsColor;
  CI: TCacheInfo;
  iState: integer;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  CI := GetParentCacheHwnd(CtrlHandle);
  InitCacheBmp(SkinData);
  SkinData.FCacheBMP.Width := WndSize.cx;
  SkinData.FCacheBMP.Height := WndSize.cy;
  if (CurrentState = 3 {Def/Focused}) and (SkinData.SkinManager.gd[SkinData.SkinIndex].States < 4) then
    iState := 1
  else
    iState := min(CurrentState, SkinData.SkinManager.gd[SkinData.SkinIndex].States - 1);

  p := WndPos;
  if (Application.BiDiMode = bdRightToLeft) and (CI.Bmp <> nil) then begin
    DC := GetDC(GetParent(CtrlHandle));
    if acGetLayout(DC) <> 0 then begin
      p.X := CI.Bmp.Width - p.X; // Inversion of control coords if canvas is mirrored
      if Assigned(SkinData.SkinManager) and SkinData.SkinManager.ExtendedBorders then
        dec(p.X, 2 * ci.X);
    end;
  end;

  PaintItem(SkinData, CI, True, iState, MkRect(WndSize), p, SkinData.FCacheBMP, True, integer(Down), integer(Down));
  DrawCaption;
  DrawGlyph;
  if not IsWindowEnabled(CtrlHandle) then
    if CI.Ready then begin
      C.A := MaxByte;
      R := MkRect(WndSize);
      OffsetRect(R, WndPos.x + CI.x, WndPos.y + CI.y);
      BlendTransRectangle(SkinData.FCacheBmp, 0, 0, CI.Bmp, R, DefBlendDisabled);
    end
    else begin
      C.C := CI.FillColor;
      BlendTransBitmap(SkinData.FCacheBmp, DefBlendDisabled, C);
    end;

  SkinData.BGChanged := False;
end;


function TacBtnWnd.CurrentState: integer;
begin
  if Down then begin
    Result := 2;
    HideGlow(SkinData.GlowID);
  end
  else
    if not IsWindowEnabled(CtrlHAndle) then
      Result := 0
    else begin
      if SkinData.FOwnerControl <> nil then begin // Patch Andreas for activ button
        if not (csDesigning in SkinData.FOwnerControl.ComponentState) and ControlIsActive(SkinData) then begin
          Result := 1;
          Exit;
        end;
      end
      else
        if (GetFocus = CtrlHandle) or (DefaultManager.ActiveControl = CtrlHandle) or SkinData.FFocused then begin
          Result := 1;
          Exit;
        end;

      if SkinData.FOwnerControl <> nil then
        Result := integer(GetWindowLong(CtrlHandle, GWL_STYLE) and BS_DEFPUSHBUTTON = BS_DEFPUSHBUTTON)
      else
        Result := 3 * integer(CtrlStyle and BS_DEFPUSHBUTTON <> 0);
    end;
end;


function TacBtnWnd.CtrlStyle: dword;
begin
  Result := GetWindowLong(CtrlHandle, GWL_STYLE);
end;


function TacBtnWnd.Down: boolean;
begin
  Result := ProcessMessage(BM_GETSTATE, 0, 0) and BST_PUSHED = BST_PUSHED;
end;


procedure TacBtnWnd.DrawCaption;
var
  R: TRect;
  DrawStyle: Cardinal;
  State: integer;
begin
  LoadCtrlFont(Self);
  R := CaptionRect;
  // Calculate vertical layout
  DrawStyle := DT_EXPANDTABS or DT_CENTER;
  if CtrlStyle and BS_MULTILINE = BS_MULTILINE then
    DrawStyle := DrawStyle or DT_WORDBREAK;

  if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_RTLREADING <> 0 then
    DrawStyle := DrawStyle or DT_RTLREADING;

  with SkinData do begin
    SetBkMode(FCacheBMP.Canvas.Handle, TRANSPARENT);
    DoDrawText(R, DrawStyle);
    if IsWindowEnabled(CtrlHandle) and SkinManager.ButtonsOptions.ShowFocusRect and (ProcessMessage(BM_GETSTATE, 0, 0) and BST_FOCUS <> 0) and (Caption <> '') then begin
      InflateRect(R, 2, 1);
      if R.Top < 3 then
        R.Top := 3;

      if R.Bottom > WndSize.cy - 3 then
        R.Bottom := WndSize.cy - 3;

      State := min(1, SkinManager.gd[SkinIndex].States);
      FocusRect(FCacheBMP.Canvas, R, SkinManager.gd[SkinIndex].Props[min(State, ac_MaxPropsIndex)].FontColor.Color, clNone);
    end;
  end;
end;


function TacBtnWnd.CaptionRect: TRect;
var
  l, t, r, b: integer;
  Size: TSize;
begin
  Size := TextRectSize;
  l := (WndSize.cx - Size.cx) div 2;
  t := (WndSize.cy - Size.cy) div 2;
  b := WndSize.cy - t;
  r := WndSize.cx - l;
  Result := Rect(l - 1, t, r + 2, b);
  if Down then
    if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
      OffsetRect(Result, 1, 1);
end;


procedure TacBtnWnd.DoDrawText(var Rect: TRect; const Flags: Integer);
begin
  acWriteTextEx(SkinData.FCacheBMP.Canvas, PacChar(Caption), True, Rect, Flags, SkinData, CurrentState <> 0);
end;


function TacBtnWnd.TextRectSize: TSize;
var
  R: TRect;
  DrawStyle: Cardinal;
begin
  R := MkRect(MaxCaptionWidth + 2, 0);
  DrawStyle := DT_EXPANDTABS or DT_CENTER or DT_CALCRECT or DT_NOPREFIX;
  if CtrlStyle and BS_MULTILINE = BS_MULTILINE then
    DrawStyle := DrawStyle or DT_WORDBREAK;

  acDrawText(SkinData.FCacheBMP.Canvas.Handle, Caption, R, DrawStyle);
  Result := MkSize(R);
end;


procedure TacBtnWnd.DrawGlyph;
begin
//
end;


function TacBtnWnd.GlyphSize: TSize;
begin
  Result := MkSize;
end;


function TacBtnWnd.MaxCaptionWidth: integer;
begin
  if Caption <> '' then
    if Glyphsize.cx <> 0 then
      Result := max(0, WndSize.cx - Glyphsize.cx)
    else
      Result := WndSize.cx + 1
  else
    Result := 0;
end;


procedure TacBtnWnd.Repaint;
begin
  RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
end;


procedure TacBtnWnd.RestoreStdParams;
begin
  inherited;
end;


procedure TacBtnWnd.SetSkinParams;
begin
  inherited;
end;


procedure TacBtnWnd.AfterCreation;
begin
  FMouseClicked := False;
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_Button;

  inherited;
end;


procedure TacSizerWnd.AC_WMPaint(const Message: TWMPaint);
var
  PS: TPaintStruct;
  DC: hdc;
  Bmp: TBitmap;
  i: integer;
  BG: TacBGInfo;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  DC := GetDC(CtrlHandle);
  Bmp := CreateBmp32(WndSize);
  try
    i := SkinData.SkinManager.ConstData.GripRightBottom;
    if SkinData.SkinManager.IsValidImgIndex(i) then begin
      BG.DrawDC := Bmp.Canvas.Handle;
      BG.R := MkRect(WndSize);
      BG.Offset.X := WndPos.X;
      BG.Offset.Y := WndPos.Y;
      BG.PleaseDraw := True;
      SendMessage(ParentWnd, SM_ALPHACMD, AC_GETBG_HI, LPARAM(@BG));
      with SkinData.SkinManager do
        DrawSkinGlyph(Bmp, Point(max(WndSize.cx - ma[i].Width, 0), max(WndSize.cy - ma[i].Height, 0)), 0, 1, ma[i], MakeCacheInfo(Bmp));

      BitBlt(DC, 0, 0, WndSize.cx, WndSize.cy, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    end;
  finally
    FreeAndNil(Bmp);
    ReleaseDC(CtrlHandle, DC);
    EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  end;
end;


procedure TacSizerWnd.acWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_NCPAINT, WM_ERASEBKGND: begin
      Message.Result := ERASE_OK;
      Exit;
    end;

    WM_PAINT: begin
      AC_WMPaint(TWMPaint(Message));
      Exit;
    end;
  end;
  inherited;
  case Message.Msg of
    WM_NCHITTEST: begin
      if IsWindowEnabled(CtrlHandle) then
        DefaultManager.ActiveControl := 0;

      Message.Result := HTBOTTOMRIGHT;
    end;
  end;
end;


procedure TacSizerWnd.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_Transparent;

  inherited;
end;


procedure TacToolBarWnd.acWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_PRINT: begin
      AC_WMPrint(TWMPaint(Message));
      Exit;
    end;

    WM_NCPAINT: begin
      AC_WMNCPaint(Message);
      Exit;
    end;

    WM_ERASEBKGND: begin
      Message.Result := ERASE_OK;
      Exit;
    end;

    WM_PAINT:
      if IsWindowVisible(CtrlHandle) then begin
        AC_WMPaint(TWMPaint(Message));
        Exit;
      end;
  end;
  inherited;
  case Message.Msg of
    WM_WINDOWPOSCHANGED, WM_SIZE: begin
      SkinData.BGChanged := True;
      RedrawWindow(CtrlHandle, nil, 0, RDWA_ALLNOW);
    end;

    WM_MOUSEMOVE:
      if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) and IsWindowEnabled(CtrlHandle) then
        DefaultManager.ActiveControl := CtrlHandle;
  end;
end;


function TacToolBarWnd.Count: integer;
begin
  Result := ProcessMessage(TB_BUTTONCOUNT, 0, 0);
end;


procedure TacToolBarWnd.AC_WMNCPaint(const Message: TMessage);
var
  DC, SavedDC: hdc;
begin
  if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE <> 0 then
    if not InUpdating(SkinData) then begin
      PrepareCache;
      DC := GetWindowDC(CtrlHandle);
      SavedDC := SaveDC(DC);
      try
        BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, (WndSize.cx - WidthOf(ClientRect)) div 2);
      finally
        RestoreDC(DC, SavedDC);
        ReleaseDC(CtrlHandle, DC);
      end;
    end;
end;


procedure TacToolBarWnd.PrepareCache;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  if SkinData.BGChanged then begin
    GetClientRect(CtrlHandle, ClientRect);
    acSBUtils.PrepareCache(SkinData, CtrlHandle, False);
    UpdateWndCorners(SkinData, 0, Self);
    BorderWidth := (WndSize.cy - HeightOf(ClientRect)) div 2;
    SkinData.BGChanged := False;
  end;
end;


procedure TacToolBarWnd.AC_WMPaint(const Message: TWMPaint);
var
  PS: TPaintStruct;
begin
  BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  if not InUpdating(SkinData) then
    AC_WMPrint(Message);

  EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
end;


procedure TacToolBarWnd.AC_WMPrint(const Message: TWMPaint);
var
  DC: hdc;
  TempBmp: TBitmap;
begin
  PrepareCache;
  TempBmp := CreateBmp32(SkinData.FCacheBmp);
  DrawButtons(TempBmp);
  if Message.DC = 0 then
    DC := GetDC(CtrlHandle)
  else
    DC := Message.DC;

  FillAlphaRect(TempBmp, MkRect(TempBmp), MaxByte);
  BitBlt(DC, 0, 0, SkinData.FCacheBmp.Width - 2 * BorderWidth, SkinData.FCacheBmp.Height - 2 * BorderWidth, TempBmp.Canvas.Handle, BorderWidth, BorderWidth, SRCCOPY);
  FreeAndNil(TempBmp);
  if Message.DC = 0 then
    ReleaseDC(CtrlHandle, DC);
end;


procedure TacToolBarWnd.DrawButtons(const Bmp: TBitmap);
var
  i, c: integer;
  r: TRect;
begin
  BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
  c := Count;
  for i := 0 to c - 1 do begin
    r := GetButtonRect(i);
    OffsetRect(r, BorderWidth, BorderWidth);
    DrawBtn(i, r, Bmp.Canvas.Handle);
  end;
end;


function TacToolBarWnd.GetButtonRect(const Index: integer): TRect;
begin
  ProcessMessage(TB_GETITEMRECT, Index, LPARAM(@Result));
end;


{$IFDEF TNTUNICODE}
function StrPasW(const Str: PWideChar): WideString;
begin
  Result := Str;
end;
{$ENDIF}


procedure TacToolBarWnd.DrawBtn(const Index: integer; const R: TRect; const DC: hdc);
const
  Margin = 2;
var
  pt: TPoint;
  Btn: TTBBUTTON;
  tm: TTextMetric;
  BtnBmp: TBitmap;
  ArrowSize: TSize;
  s, s1, s2: acString;
  OldFont, NewFont: hFont;
  rT, rText, nRect: TRect;
  buf: array [0..1023] of acChar;
  BtnIndex, i, cx, cy, count, Ndx, si, mi, State, ArrowIndex, pOffset: integer;
begin
  if ProcessMessage(TB_GETBUTTON, Index, LPARAM(@Btn)) <> 0 then begin
    BtnBmp := CreateBmp32(r);
    if Btn.fsStyle = TBSTYLE_SEP then begin // Separator
      si := DefaultManager.GetSkinIndex(s_Divider);
      mi := DefaultManager.GetMaskIndex(si, s_BordersMask);
      if DefaultManager.IsValidImgIndex(mi) then begin
        nRect.Top := 2;
        nRect.Left := BtnBmp.Width div 2 - 1;
        nRect.Bottom := BtnBmp.Height - 2;
        nRect.Right := nRect.Left + 4;
        BitBlt(BtnBmp.Canvas.Handle, 0, 0, BtnBmp.Width, BtnBmp.Height, SkinData.FCacheBmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
        PaintItem(si, MakeCacheInfo(SkinData.FCacheBmp), True, 0, nRect, Point(R.Left + nRect.Left, R.Top + nRect.Top), BtnBmp);
        BitBlt(DC, r.Left, r.Top, BtnBmp.Width, BtnBmp.Height, BtnBmp.Canvas.Handle, 0, 0, SRCCOPY);
        FreeAndNil(BtnBmp);
      end;
      Exit
    end;
    cy := 0;
    cx := 0;
    BtnIndex := SkinData.SkinManager.ConstData.Sections[ssToolButton];
    pOffset := 0;
    if Btn.fsState and TBSTATE_ENABLED = 0 then
      State := 0
    else
      if Btn.fsState and TBSTATE_PRESSED <> 0 then begin
        State := 2;
        pOffset := 1;
      end
      else begin
        GetCursorPos(pt);
        State := integer(PtInRect(Rect(R.Left + WndRect.Left, R.Top + WndRect.Top, R.Right + WndRect.Left, R.Bottom + WndRect.Top), pt))
      end;

    PaintItem(BtnIndex, MakeCacheInfo(SkinData.FCacheBmp), True, State, MkRect(BtnBmp), r.TopLeft, BtnBmp);
{$IFDEF TNTUNICODE}
    if ProcessMessage(TB_GETBUTTONTEXTW, Btn.idCommand, LPARAM(@buf)) <> -1 then
      s := StrPasW(buf)
{$ELSE}
    if ProcessMessage(TB_GETBUTTONTEXT, Btn.idCommand, LPARAM(@buf)) <> -1 then
      s := StrPas(buf)
{$ENDIF}
    else
      s := '';

    if Btn.iBitmap >= 0 then begin
      i := ProcessMessage(TB_GETIMAGELIST, 0, 0);
      if i <> 0 then begin
        ImageList_GetIconSize(i, cx, cy);
        ImageList_SetBkColor(i, CLR_NONE);
        if Btn.fsStyle and $0080 = $0080 then begin // BTNS_WHOLEDROPDOWN
          ArrowIndex := SkinData.SkinManager.ConstData.ScrollBtns[asBottom].GlyphIndex;
          if ArrowIndex >= 0 then begin
            ArrowSize := MkSize(DefaultManager.ma[ArrowIndex]);
            if s <> '' then begin
              DrawSkinGlyph(BtnBmp, Point((BtnBmp.Width - ArrowSize.cx) div 2 + pOffset, (BtnBmp.Height - ArrowSize.cy) div 2 + pOffset), State, 1, DefaultManager.ma[ArrowIndex], MakeCacheInfo(BtnBmp));
              ImageList_Draw(i, Btn.iBitmap, BtnBmp.Canvas.Handle, (WidthOf(r) - cx - ArrowSize.cx) div 2 + pOffset, 4 + pOffset, 0);
            end
            else begin
              DrawSkinGlyph(BtnBmp, Point(BtnBmp.Width - 1 - ArrowSize.cx - pOffset, (BtnBmp.Height - ArrowSize.cy) div 2 + pOffset), State, 1, DefaultManager.ma[ArrowIndex], MakeCacheInfo(BtnBmp));
              ImageList_Draw(i, Btn.iBitmap, BtnBmp.Canvas.Handle, (WidthOf(r) - cx - ArrowSize.cx) div 2 + pOffset, 4 + pOffset, 0);
            end;
          end
          else
            ImageList_Draw(i, Btn.iBitmap, BtnBmp.Canvas.Handle, (WidthOf(r) - cx) div 2 + pOffset, 4 + pOffset, 0);
        end
        else
          if s = '' then
            ImageList_Draw(i, Btn.iBitmap, BtnBmp.Canvas.Handle, (WidthOf(r) - cx) div 2 + pOffset, (HeightOf(r) - cy) div 2 + pOffset, 0)
          else
            ImageList_Draw(i, Btn.iBitmap, BtnBmp.Canvas.Handle, (WidthOf(r) - cx) div 2 + pOffset, 4 + pOffset, 0);
      end
      else begin
        cy := 0;
        cx := 0;
      end;
    end;

    if s <> '' then begin
      NewFont := LongWord(ProcessMessage(WM_GETFONT, 0, 0));
      if NewFont <> 0 then
        OldFont := SelectObject(BtnBmp.Canvas.Handle, NewFont)
      else
        OldFont := 0;

      GetTextMetrics(BtnBmp.Canvas.Handle, {$IFDEF FPC}@tm{$ELSE}tm{$ENDIF});
      rText.Left := Margin + pOffset;
      rText.Right := WidthOf(r) - Margin + pOffset;
      rText.Top := Margin + integer(cy <> 0) * (cy + 2) + pOffset;
      rText.Bottom := HeightOf(r) - Margin + pOffset;
      BtnBmp.Canvas.Brush.Style := bsClear;
      count := acWordCount(s, [s_Space]);
      for i := 1 to count do begin
        s2 := Copy(s, 1, acWordPosition(i, s, [s_Space]) - 2);
        if (BtnBmp.Canvas.TextWidth(s2) > WidthOf(R)) or (i = count) then begin
          s1 := Copy(s, 1, acWordPosition(i - 1, s, [s_Space]) - 2);
          s2 := Copy(s, acWordPosition(i - 1, s, [s_Space]), Length(s));
        end
      end;
      Ndx := iff((State = 0) and SkinData.SkinManager.gd[SkinData.SkinIndex].GiveOwnFont, SkinData.SkinIndex, BtnIndex);
      if (s1 = '') or (s2 = '') then
        acWriteTextEx(BtnBmp.Canvas, PacChar(s), True, rText, DT_WORDBREAK or DT_CENTER or DT_END_ELLIPSIS or DT_VCENTER, Ndx, State <> 0)
      else begin
        rT := rText;
        rT.Bottom := rT.Top + tm.tmHeight;
        acWriteTextEx(BtnBmp.Canvas, PacChar(s1), True, rT, DT_CENTER, Ndx, State <> 0);
        rT.Top := rT.Bottom;
        rT.Bottom := rText.Bottom;
        rT.Left := rText.Left;
        rT.Right := rText.Right;
        acWriteTextEx(BtnBmp.Canvas, PacChar(s2), True, rT, DT_LEFT or DT_END_ELLIPSIS, Ndx, State <> 0)
      end;
      if OldFont <> 0 then
        SelectObject(BtnBmp.Canvas.Handle, OldFont);
    end;
    if Btn.fsState and TBSTATE_ENABLED = 0 then begin
      rText := MkRect(BtnBmp);
      OffsetRect(rText, R.Left, R.Top);
      BlendTransRectangle(BtnBmp, 0, 0, SkinData.FCacheBmp, rText, DefBlendDisabled);
    end;
    BitBlt(DC, r.Left, r.Top, BtnBmp.Width, BtnBmp.Height, BtnBmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(BtnBmp);
  end;
end;


procedure TacTransPanelWnd.acWndProc(var Message: TMessage);
var
  PS: TPaintStruct;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_NCPAINT:
      Message.Result := 0;

    WM_PAINT: begin
      BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
      try
        AC_WMPaint(TWMPaint(Message));
      finally
        EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
        Message.Result := 0;
      end;
    end;

    WM_ERASEBKGND: begin
      AC_WMPaint(TWMPaint(Message));
      Message.Result := ERASE_OK;
    end

    else
      inherited;
  end;
end;


procedure TacTransPanelWnd.AC_WMPaint(const Message: TWMPaint);
var
  PS: TPaintStruct;
  DC: hdc;
begin
  GetWindowRect(CtrlHandle, WndRect);
  WndSize := MkSize(WndRect);
  BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  if Message.DC <> 0 then
    DC := Message.DC
  else
    DC := GetWindowDC(CtrlHandle);

  SkinData.BGChanged := True;
  PrepareCache(SkinData, CtrlHandle);
  CopyHwndCache(CtrlHandle, SkinData, MkRect, MkRect(WndSize), DC, False, 0, 0);
  if Message.DC <> DC then
    ReleaseDC(CtrlHandle, DC);

  EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
end;


procedure TacTransPanelWnd.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_Transparent;

  inherited;
end;


procedure TacGroupBoxWnd.AC_WMPaint(Message: TWMPaint);
var
  DC: hdc;
  cRect: TRect;
  PS: TPaintStruct;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  if not InUpdating(SkinData) then begin
    if (Message.DC = 0) or (Message.Unused <> 1) then
      DC := GetDC(CtrlHandle)
    else
      DC := Message.DC;

    PrepareCache;
    if DlgMode then begin
      cRect.Top    := HeightOf(CaptionRect);
      cRect.Left   := DefaultManager.ma[SkinData.BorderIndex].WL;
      cRect.Right  := WndSize.cx - DefaultManager.ma[SkinData.BorderIndex].WR;
      cRect.Bottom := WndSize.cy - DefaultManager.ma[SkinData.BorderIndex].WB;
      ExcludeClipRect(DC, cRect.Left, cRect.Top, cRect.Right, cRect.Bottom);
    end;
    if SkinData.FOwnerControl <> nil then begin
      CopyWinControlCache(TWinControl(SkinData.FOwnerControl), SkinData, MkRect, MkRect(WndSize), DC, False);
      PaintControls(DC, TWinControl(SkinData.FOwnerControl), False, MkPoint);
    end
    else
      CopyHwndCache(CtrlHandle, SkinData, MkRect, MkRect(WndSize), DC, False);

    if DC <> Message.DC then
      ReleaseDC(CtrlHandle, DC);

    SetParentUpdated(CtrlHandle);
  end;
  EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
end;


procedure TacGroupBoxWnd.acWndProc(var Message: TMessage);
begin
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_GETSERVICEINT: begin
          Message.Result := HeightOf(CaptionRect);
          Exit
        end;

        AC_REMOVESKIN:
          SkinData.FOwnerControl.ControlStyle := SkinData.FOwnerControl.ControlStyle - [csOpaque];
      end;

    WM_ERASEBKGND:
      if not DlgMode then begin
        if (SkinData.FOwnerControl <> nil) and not (csPaintCopy in SkinData.FOwnerControl.ControlState) and (Message.WParam <> WParam(Message.LParam)) then begin
          if csDesigning in SkinData.FOwnerControl.ComponentState then
            inherited; // Drawing in the BDS IDE
        end
        else
          if Message.WParam <> 0 then begin // From PaintTo
            if SkinData.BGChanged then
              PrepareCache;

            if not SkinData.BGChanged then
              if IsCached(SkinData) then
                BitBlt(TWMPaint(Message).DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY)
              else
                FillDC(TWMPaint(Message).DC, MkRect(WndSize), GetControlColor(CtrlHandle));

          end;

        Message.Result := ERASE_OK;
        Exit;
      end;

    WM_NCPAINT:
      if DlgMode then begin
        AC_WMPaint(TWMPaint(MakeMessage(WM_NCPAINT, 0, 0, 0)));
        Message.Result := 1;
        Exit;
      end;

    WM_PRINT: begin
      SkinData.BGChanged := True;
      SkinData.Updating := False;
      Message.LParam := 1;
      AC_WMPaint(TWMPaint(Message));
      Exit;
    end;

    WM_PAINT:
      if not DlgMode then begin
        AC_WMPaint(TWMPaint(Message));
        Message.Result := 0;
        Exit;
      end;

    WM_PARENTNOTIFY:
      if Message.WParamLo in [WM_CREATE, WM_DESTROY] then begin
        inherited;
        if (Message.WParamLo = WM_CREATE) and (SkinData.FOwnerControl <> nil) then
          AddToAdapter(TWinControl(SkinData.FOwnerControl));

        Exit;
      end;

    WM_SETFOCUS, WM_KILLFOCUS: begin
      SetRedraw(CtrlHandle, 0);
      inherited;
      SetRedraw(CtrlHandle, 1);
      SkinData.BGChanged := True;
      RedrawWindow(CtrlHandle, nil, 0, RDWA_REPAINT);
      Exit;
    end;

    WM_SETTEXT: begin
      inherited;
      SkinData.BGChanged := True;
      RedrawWindow(CtrlHandle, nil, 0, RDWA_REPAINT);
      Exit;
    end;    
  end;
  inherited;
end;


procedure TacGroupBoxWnd.PrepareCache;
var
  P: TPoint;
  cRect: TRect;
  BGInfo: TacBGInfo;
begin
  InitCacheBmp(SkinData);
  SkinData.FCacheBmp.Width := WndSize.cx;
  SkinData.FCacheBmp.Height := WndSize.cy;

  LoadCtrlFont(Self);
  cRect := CaptionRect;

  BGInfo.PleaseDraw := False;
  GetBGInfo(@BGInfo, ParentWnd);
  P := Point(WndPos.X, WndPos.Y);
  if BGInfo.BgType = btCache then
    BitBlt(SkinData.FCacheBmp.Canvas.Handle, 0, 0, WndSize.cx, HeightOf(cRect), BGInfo.Bmp.Canvas.Handle, P.X + BGInfo.Offset.X, P.Y + BGInfo.Offset.Y, SRCCOPY)
  else
    FillDC(SkinData.FCacheBmp.Canvas.Handle, MkRect(WndSize.cx, cRect.Bottom), BGInfo.Color);

  PaintItem(SkinData, BGInfoToCI(@BGInfo), False, 0, Rect(0, HeightOf(cRect) div 2, WndSize.cx, WndSize.cy), Point(P.x, P.y + HeightOf(cRect) div 2), SkinData.FCacheBMP, True);
  if Caption <> '' then
    WriteText(cRect);

  SkinData.BGChanged := False;
end;


function TacGroupBoxWnd.CaptionRect: TRect;
const
  Margin = 4;
var
  Size: TSize;
begin
  if Caption = '' then
    Result := MkRect
  else
    acDrawText(SkinData.FCacheBMP.Canvas.Handle, Caption, Result, DT_CENTER or DT_CALCRECT);

  Size := MkSize(Result);
  if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_RTLREADING <> 0 then
    Result.Left := WndSize.cx - Size.cx - 2 * Margin - 6
  else
    Result.Left := 6;

  Result.Top := 0;
  Result.Bottom := Result.Top + Maxi(4, Size.cy) + 2;
  Result.Right := Result.Left + Size.cx + 2 * Margin;
  if Result.Right > WndSize.cx then
    Result.Right := WndSize.cx - 1;
end;


procedure TacGroupBoxWnd.WriteText(R: TRect);
var
  FontIndex: integer;
  BGInfo: TacBGInfo;
  pi: TacPaintInfo;
  Flags: Cardinal;
begin
  BGInfo.PleaseDraw := False;
  GetBGInfo(@BGInfo, ParentWnd);
  if BGInfo.BgType = btCache then
    BitBlt(SkinData.FCacheBmp.Canvas.Handle, R.Left, R.Top, WidthOf(R), HeightOf(R), BGInfo.Bmp.Canvas.Handle, WndPos.x + R.Left + BGInfo.Offset.X, WndPos.y + R.Top + BGInfo.Offset.y, SRCCOPY)
  else
    FillDC(SkinData.FCacheBmp.Canvas.Handle, R, BGInfo.Color);

  SkinData.FCacheBMP.Canvas.Brush.Style := bsClear;
  Flags := DT_CENTER or DT_SINGLELINE or DT_VCENTER;
  if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_RTLREADING <> 0 then
    Flags := Flags or DT_RTLREADING;

  pi.SkinManager := SkinData.SkinManager;
  pi.R := MkRect;
  pi.State := 0;
  pi.FontIndex := -1;

  if (SendMessage(CtrlHandle, SM_ALPHACMD, AC_GETFONTINDEX_HI, LParam(@pi)) > 0) and (pi.FontIndex >= 0) then
    FontIndex := pi.FontIndex
  else
    FontIndex := SkinData.SkinIndex;

  acWriteTextEx(SkinData.FCacheBMP.Canvas, PacChar(Caption), True, R, Flags, FontIndex, False);
end;


procedure TacGroupBoxWnd.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_GroupBox;

  inherited;
end;


procedure TacCheckBoxWnd.AC_WMPaint(const Message: TWMPaint);
var
  PS: TPaintStruct;
  DC: hdc;
begin
  BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  if not TimerIsActive(SkinData) then begin
    InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
    if not InUpdating(SkinData) then
      if not OwnerDraw then
        if IsWindowVisible(CtrlHandle) or (Message.DC <> 0) then begin
          InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
          if Message.DC = 0 then
            DC := GetDC(CtrlHandle)
          else
            DC := Message.DC;

          PrepareCache;
          BitBlt(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
          if Message.DC = 0 then
            ReleaseDC(CtrlHandle, DC);
        end;
  end
  else begin
    DC := GetDC(CtrlHandle);
    BitBlt(DC, 0, 0, SkinData.AnimTimer.BmpOut.Width, SkinData.AnimTimer.BmpOut.Height, SkinData.AnimTimer.BmpOut.Canvas.Handle, 0, 0, SRCCOPY);
    ReleaseDC(CtrlHandle, DC);
  end;
  EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
end;


procedure TacCheckBoxWnd.acWndProc(var Message: TMessage);
var
  CI: TCacheInfo;
  R: TRect;
  DC: hdc;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_MOUSEENTER:
          if not SkinData.FMouseAbove and (DefaultManager.ActiveControl = CtrlHandle) and not SkinData.SkinManager.Options.NoMouseHover then begin
            GetWindowRect(CtrlHandle, R);
            if PtInRect(R, acMousePos) then begin
              SkinData.FMouseAbove := True;
              SkinData.BGChanged := False;
              SkinData.Updating := False;
              DoChangePaint(SkinData, 1, UpdateWindow_CB, True, False);
            end;
            Exit;
          end;

        AC_MOUSELEAVE:
          if SkinData.FMouseAbove then begin
            SkinData.FMouseAbove := False;
            SkinData.Updating := False;
            SkinData.BGChanged := False;
            DoChangePaint(SkinData, 0, UpdateWindow_CB, True, False);
            Exit;
          end;

        AC_PREPARECACHE: begin
          PrepareCache;
          Exit;
        end;
      end;

    WM_DESTROY, WM_NCDESTROY: begin
      inherited;
      Exit;
    end;

    WM_NCPAINT:
      Exit;

    WM_ERASEBKGND: begin
      if OwnerDraw then begin
        InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
        CI := GetParentCacheHwnd(CtrlHandle);
        if Message.WParam <> 0 then
          DC := hdc(Message.WParam)
        else
          DC := GetDC(CtrlHandle);

        if CI.Ready then
          BitBlt(DC, 0, 0, WndSize.cx, WndSize.cy, CI.Bmp.Canvas.Handle, WndPos.X, WndPos.Y, SRCCOPY)
        else
          FillDC(DC, MkRect(WndSize), CI.FillColor);

        if hdc(Message.WParam) <> DC then
          ReleaseDC(CtrlHandle, DC);
      end;
      Message.Result := ERASE_OK;
      Exit;
    end;

    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      StopTimer(SkinData);

    WM_PAINT: begin
      AC_WMPaint(TWMPaint(Message));
      Exit;
    end;

    CM_TEXTCHANGED, WM_ENABLE, BM_SETSTATE, BM_SETCHECK:
      if IsWindowVisible(CtrlHandle) then begin
        SetRedraw(CtrlHandle, 0);
        StopTimer(SkinData);
        inherited;
        SetRedraw(CtrlHandle, 1);
        SendMessage(CtrlHandle, WM_PAINT, 0, 0);
        Exit;
      end;
  end;    
  inherited;
  case Message.Msg of
    WM_KEYUP, WM_KEYDOWN:
      if TWMKey(Message).CharCode = VK_SPACE then
        SendMessage(CtrlHandle, WM_PAINT, 0, 0);

    WM_SETFOCUS, WM_KILLFOCUS:
      SendMessage(CtrlHandle, WM_PAINT, 0, 0);

    WM_NCHITTEST:
      if IsWindowEnabled(CtrlHandle) and (DefaultManager.ActiveControl <> CtrlHandle) then
        DefaultManager.ActiveControl := CtrlHandle;
  end;
end;


procedure TacCheckBoxWnd.PrepareCache;
var
  R: TRect;
  C: TsColor;
  CI: TCacheInfo;
begin
  InitCacheBmp(SkinData);
  if not OwnerDraw then begin
    SkinData.FCacheBmp.Width  := WndSize.cx;
    SkinData.FCacheBmp.Height := WndSize.cy;
    CI := GetParentCacheHwnd(CtrlHandle);
    PaintItem(SkinData, CI, True, integer(ControlIsActive(SkinData)), MkRect(WndSize), WndPos, SkinData.FCacheBmp, False);
    DrawCheckText;
    DrawSkinGlyph(GlyphMaskIndex(State));
    if not IsWindowEnabled(CtrlHandle) then
      if CI.Ready then begin
        R := MkRect(WndSize);
        OffsetRect(R, CI.X + WndPos.x, CI.Y + WndPos.y);
        BlendTransRectangle(SkinData.FCacheBmp, 0, 0, CI.Bmp, R, DefBlendDisabled);
      end
      else begin
        C.C := CI.FillColor;
        BlendTransBitmap(SkinData.FCacheBmp, DefBlendDisabled, C);
      end;
  end;
end;


procedure TacCheckBoxWnd.DrawCheckText;
const
  Margin = 0;
var
  rText: TRect;
  pi: TacPaintInfo;
  FontIndex: integer;
  WordWrap, Focused: boolean;
  Fmt, State, t, b, w, h, dx: integer;
begin
  if Caption <> '' then begin
    w := WndSize.cx - (WidthOf(CheckRect) + 2);
    WordWrap := GetWindowLong(CtrlHandle, GWL_STYLE) and BS_MULTILINE = BS_MULTILINE;
    Focused := ProcessMessage(BM_GETSTATE, 0, 0) and BST_FOCUS = BST_FOCUS;

    rText := MkRect(w, 0);
    Fmt := DT_CALCRECT;
    if WordWrap then
      Fmt := Fmt or DT_WORDBREAK
    else
      Fmt := Fmt or DT_SINGLELINE;

    LoadCtrlFont(Self);
    AcDrawText(SkinData.FCacheBMP.Canvas.Handle, Caption, rText, Fmt);
    h := HeightOf(rText);
    dx := WidthOf(rText);
    t := Max((WndSize.cy - h) div 2, 0);
    b := WndSize.cy - t;
    Fmt := 0;
    if GetWindowLong(CtrlHandle, GWL_STYLE) and BS_LEFTTEXT <> BS_LEFTTEXT then begin
      rText := Rect(WndSize.cx - w - Margin + 2, t, WndSize.cx - w - Margin + 2 + dx, b);
      if not WordWrap then
        Fmt := DT_LEFT;

      OffsetRect(rText, -integer(WordWrap), -1);
    end
    else
      if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_RTLREADING <> 0 then begin
        rText.Right := WndSize.cx - Margin - WidthOf(CheckRect) - 6;
        rText.Left := rText.Right - dx;
        rText.Top := t;
        rText.Bottom := b;
        if not WordWrap then
          Fmt := DT_RIGHT;

        Fmt := Fmt or DT_RTLREADING;
      end
      else
        rText := Rect(Margin + 2, t, dx + Margin + 2, b);

    if WordWrap then
      Fmt := Fmt or DT_WORDBREAK or DT_TOP
    else
      Fmt := Fmt or DT_SINGLELINE or DT_TOP;

    pi.SkinManager := SkinData.SkinManager;
    pi.R := MkRect;
    pi.State := 0;
    pi.FontIndex := -1;

    if (SendMessage(CtrlHandle, SM_ALPHACMD, AC_GETFONTINDEX_HI, LParam(@pi)) > 0) and (pi.FontIndex >= 0) then
      FontIndex := pi.FontIndex
    else
      FontIndex := SkinData.SkinIndex;

    acWriteTextEx(SkinData.FCacheBmp.Canvas, PacChar(Caption), True, rText, Fmt, FontIndex, ControlIsActive(SkinData));
    SkinData.FCacheBmp.Canvas.Pen.Style := psClear;
    SkinData.FCacheBmp.Canvas.Brush.Style := bsSolid;
    if Focused then begin
      InflateRect(rText, 2, 0);
      State := min(1, SkinData.SkinManager.gd[SkinData.SkinIndex].States);
      FocusRect(SkinData.FCacheBMP.Canvas, rText, SkinData.SkinManager.gd[SkinData.SkinIndex].Props[min(State, ac_MaxPropsIndex)].FontColor.Color, clNone);
    end;
  end;
end;


function TacCheckBoxWnd.CheckRect: TRect;
var
  i: integer;
begin
  i := GlyphMaskIndex(cbChecked);
  if SkinData.SkinManager.IsValidImgIndex(i) then
    Result := SkinCheckRect(i)
  else
    Result := MkRect(16, 16);
end;


function TacCheckBoxWnd.CtlState: integer;
begin
  if ProcessMessage(BM_GETSTATE, 0, 0) and BST_PUSHED <> 0 then
    Result := 2
  else
    if not SkinData.SkinManager.Options.NoMouseHover and ((ProcessMessage(BM_GETSTATE, 0, 0) and BST_FOCUS <> 0) or (DefaultManager.ActiveControl = CtrlHandle)) then
      Result := 1
    else
      Result := 0
end;


function TacCheckBoxWnd.GlyphMaskIndex(const AState: TCheckBoxState): smallint;
var
  Style: ACNativeInt;
begin
  Style := GetWindowLong(CtrlHandle, GWL_STYLE);
  with SkinData.SkinManager do
    if (Style and BS_RADIOBUTTON <> BS_RADIOBUTTON) and (Style and BS_AUTORADIOBUTTON <> BS_AUTORADIOBUTTON) or
         (Style and BS_AUTOCHECKBOX = BS_AUTOCHECKBOX) or
           (Style and BS_CHECKBOX = BS_CHECKBOX) or
             (Style and BS_3STATE = BS_3STATE) then
      Result := ConstData.CheckBox[AState]
    else
      Result := ConstData.RadioButton[AState = cbChecked];
end;


function TacCheckBoxWnd.SkinCheckRect(const i: integer): TRect;
var
  h, w, hdiv: integer;
begin
  Result := MkRect;
  if i >= 0 then begin
    h := SkinGlyphHeight(i);
    w := SkinGlyphWidth(i);
    hdiv := (WndSize.cy - h) div 2;
    if GetWindowLong(CtrlHandle, GWL_STYLE) and BS_LEFTTEXT <> BS_LEFTTEXT then
      Result := Rect(0, hdiv, w, h + hdiv)
    else
      Result := Rect(WndSize.cx - w, hdiv, WndSize.cx, h + hdiv)
  end;
end;


function TacCheckBoxWnd.SkinGlyphHeight(const i: integer): integer;
begin
{  with SkinData.SkinManager do
    if Assigned(ma[i].Bmp) then
      Result := ma[i].Bmp.Height div 2
    else}
      Result := SkinData.SkinManager.ma[i].Height;
end;


function TacCheckBoxWnd.SkinGlyphWidth(const i: integer): integer;
begin
{  with SkinData.SkinManager do begin

    if ma[i].ImageCount = 0 then
      ma[i].ImageCount := 1;
}
    Result := SkinData.SkinManager.ma[i].Width;
//  end;
end;


procedure TacCheckBoxWnd.DrawSkinGlyph(const i: integer);
var
  R: TRect;
begin
  if (SkinData.FCacheBmp.Width > 0) and (i >= 0) then begin
    R := SkinCheckRect(i);
    sAlphaGraph.DrawSkinGlyph(SkinData.FCacheBmp, R.TopLeft, CtlState, 1, SkinData.SkinManager.ma[i], MakeCacheInfo(SkinData.FCacheBmp))
  end;
end;


function TacCheckBoxWnd.State: TCheckBoxState;
var
  dLink: TObject;
begin
  if (SkinData.FOwnerControl is TCustomCheckBox) and Assigned(GetDBFieldCheckState) and HasProperty(SkinData.FOwnerControl, 'DataField') then begin
    dLink := TObject(SkinData.FOwnerControl.Perform(CM_GETDATALINK, 0, 0));
    if dLink <> nil then begin
      Result := GetDBFieldCheckState(dLink);
      Exit;
    end;
  end;
  if ProcessMessage(BM_GETSTATE, 0, 0) and BST_INDETERMINATE <> 0 then
    Result := cbGrayed
  else
    if ProcessMessage(BM_GETSTATE, 0, 0) and BST_CHECKED <> 0 then
      Result := cbChecked
    else
      Result := cbUnChecked
end;


procedure TacCheckBoxWnd.AfterCreation;
var
  Style: Cardinal;
begin
  Style := GetWindowLong(CtrlHandle, GWL_STYLE) and SS_TYPEMASK;
  OwnerDraw := Style and SS_SIMPLE = SS_SIMPLE;
  SkinData.COC := COC_TsCheckBox;
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_CheckBox;

  inherited;
end;


procedure TacLinkWnd.acWndProc(var Message: TMessage);
var
  ps: TPaintStruct;
begin
  if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_STATICEDGE = 0 then
    case Message.Msg of
      WM_UPDATEUISTATE:
        if IsWindowVisible(CtrlHandle) then
          Inherited;

      WM_NCPAINT: ;

      WM_ERASEBKGND:
        if IsWindowVisible(CtrlHandle) then begin
          AC_WMPaint(TWMPaint(Message));
          Message.Result := ERASE_OK;
        end
        else
          inherited;

      WM_PAINT: begin
        BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
        EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
      end;

      WM_MOVE: begin
        SkinData.BGChanged := True;
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        RedrawWindow(CtrlHandle, nil, 0, RDWA_ALLNOW);
      end;

      WM_SETTEXT: begin
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        Caption := GetWndText(CtrlHandle);
        SkinData.BGChanged := True;
        RedrawWindow(CtrlHandle, nil, 0, RDWA_ALLNOW);
      end

      else
        inherited;
    end
  else
    inherited;
end;


function TacLinkWnd.PaintText: boolean;
var
  s: acString;
  rText: TRect;
  Flags: Cardinal;
begin
  Result := True;
  SkinData.FCacheBmp.Canvas.Brush.Style := bsClear;
  rText := MkRect(WndSize.cx + 4, WndSize.cy);
  LoadCtrlFont(Self);
  SkinData.FCacheBmp.Canvas.Font.Style := SkinData.FCacheBmp.Canvas.Font.Style + [fsUnderline];
  Flags := DT_LEFT or DT_TOP or DT_EXPANDTABS or DT_WORDBREAK or DT_NOCLIP;
  s := Caption;
  s := ReplaceStr(s, '<A>', '');
  s := ReplaceStr(s, '</A>', '');
  SkinData.FCacheBmp.Canvas.Brush.Style := bsClear;
  acWriteTextEx(SkinData.FCacheBmp.Canvas, PacChar(s), True, rText, Flags, SkinData, False);
end;


procedure TacIconWnd.AfterCreation;
begin
  IsBmp := (GetWindowLong(CtrlHandle, GWL_STYLE) and SS_TYPEMASK) and SS_ICON <> SS_ICON;
  FBmp := nil;
  inherited;
end;


destructor TacIconWnd.Destroy;
begin
  if FBmp <> nil then
    FreeAndNil(FBmp);

  inherited;
end;


function TacIconWnd.PaintText: boolean;
var
  hi: hIcon;
begin
  if not IsBmp then begin // Icon
    hi := hIcon(ProcessMessage(STM_GETICON, 0, 0));
    if hi <> 0 then begin
      DrawIconEx(SkinData.FCacheBmp.Canvas.Handle, 0, 0, hi, 0, 0, 0, 0, DI_NORMAL);
      Result := True;
    end
    else
      Result := False;
  end
  else begin
    if FBmp = nil then begin
      FBmp := TBitmap.Create;
      FBmp.Handle := hBitmap(ProcessMessage(STM_GETIMAGE, IMAGE_BITMAP, 0));
    end;
    if not FBmp.Empty then begin
      if FBmp.PixelFormat = pf32bit then
        CopyBmp32(MkRect(WndSize), MkRect(FBmp.Width, FBmp.Height), SkinData.FCacheBmp, FBmp, MakeCacheInfo(SkinData.FCacheBmp), True, clNone, 1, True)
      else
        BitBlt(SkinData.FCacheBmp.Canvas.Handle, 0, 0, min(WndSize.cx, FBmp.Width), min(WndSize.cy, FBmp.Height), FBmp.Canvas.Handle, 0, 0, SRCCOPY);

      Result := True;
    end
    else
      Result := False;
  end
end;


procedure TacTabWnd.AC_WMPaint(Message: TWMPaint);
var
  PS: TPaintStruct;
  DC: hdc;
begin
//  InvalidateRect(CtrlHandle, nil, True); // Background update (for repaint of graphic controls and for tansheets refreshing)
  BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  if IsWindowVisible(CtrlHandle) then begin
    DC := GetDC(CtrlHandle);
    PrepareCache;
    ReleaseDC(CtrlHandle, DC);
  end;
  EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
end;


procedure TacTabWnd.acWndProc(var Message: TMessage);
var
  cRect: TRect;
begin
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_GETCACHE: begin
          inherited;
          GetClientRect(CtrlHandle, cRect);
          Exit;
        end;
      end;

    WM_ERASEBKGND:
      Message.Result := ERASE_OK;

    WM_NCPAINT:
      if DlgMode then begin
        InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
        AC_WMNCPaint(TWMPaint(Message));
        Exit;
      end;

    WM_PRINT, WM_PAINT: begin
      AC_WMPaint(TWMPaint(Message));
      Message.Result := 0;
      Exit;
    end;        
  end;
  inherited;
end;


procedure TacTabWnd.PrepareCache;
begin
  SkinData.FCacheBmp.Width := WndSize.cx;
  SkinData.FCacheBmp.Height := WndSize.cy;
end;


procedure TacTabWnd.AC_WMNCPaint(Message: TWMPaint);
var
  DC: hdc;
  cRect: TRect;
begin
  if not InUpdating(SkinData) then begin
    DC := GetWindowDC(CtrlHandle);
    PrepareCache;
    cRect := DisplayRect;
    BitBlt(DC, 0, 0, WndSize.cx, cRect.Top, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
    BitBlt(DC, 0, cRect.Top, cRect.Left, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, cRect.Top, SRCCOPY);
    ReleaseDC(CtrlHandle, DC);
  end;
end;


function TacTabWnd.DisplayRect: TRect;
begin
  GetClientRect(CtrlHandle, Result);
  ProcessMessage(TCM_ADJUSTRECT, 0, LPARAM(@Result));
  Inc(Result.Top, 2);
end;


procedure TacSpinWnd.AC_WMPaint(const Message: TWMPaint);
var
  PS: TPaintStruct;
  DC: hdc;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  if IsVertical then begin
    if not PtInRect(WndRect, acMousePos) then begin
      Btn1State := 0;
      Btn2State := 0;
    end
    else
      if PtInRect(Rect(WndRect.Left, WndRect.Top, WndRect.Right, WndRect.Bottom - WndSize.cy div 2), acMousePos) then begin
        Btn1State := 1 + integer(bMousePressed);
        Btn2State := 0;
      end
      else begin
        Btn1State := 0;
        Btn2State := 1 + integer(bMousePressed);
      end;

    BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
    if not InUpdating(SkinData) then begin
      if Message.DC = 0 then
        DC := GetDC(CtrlHandle)
      else
        DC := Message.DC;

      SkinData.BGChanged := True;
      PrepareCache;
      BitBlt(DC, lOffset, 0, SkinData.FCacheBmp.Width - lOffset, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, lOffset, 0, SRCCOPY);
      if Message.DC <> 0 then
        ReleaseDC(CtrlHandle, DC);
    end;
    EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  end
  else begin
    if not PtInRect(WndRect, acMousePos) then begin
      Btn1State := 0;
      Btn2State := 0;
    end
    else
      if PtInRect(Rect(WndRect.Left, WndRect.Top, WndRect.Right - WndSize.cx div 2, WndRect.Bottom), acMousePos) then begin
        Btn1State := 1 + integer(bMousePressed);
        Btn2State := 0;
      end
      else begin
        Btn1State := 0;
        Btn2State := 1 + integer(bMousePressed);
      end;

    BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
    if not InUpdating(SkinData) then begin
      if Message.DC = 0 then
        DC := GetDC(CtrlHandle)
      else
        DC := Message.DC;

      SkinData.BGChanged := True;
      PrepareCache;
      BitBlt(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      if Message.DC <> 0 then
        ReleaseDC(CtrlHandle, DC);
    end;
    EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  end;
end;


procedure TacSpinWnd.acWndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_MOUSELEAVE:
          RedrawWindow(CtrlHandle, nil, 0, RDWA_ALLNOW);
      end;

    WM_NCPAINT, WM_ERASEBKGND: begin
      Message.Result := ERASE_OK;
      Exit;
    end;

    WM_PAINT: begin
      AC_WMPaint(TWMPaint(Message));
      Message.Result := 0;
      Exit;
    end;

    WM_LBUTTONDOWN:
      bMousePressed := True;

    WM_LBUTTONUP:
      bMousePressed := False;

    WM_MOUSELEAVE:
      InvalidateRect(CtrlHandle, nil, False);
  end;
  inherited;
  case Message.Msg of
    WM_LBUTTONDOWN, WM_LBUTTONUP:
      RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);

    WM_LBUTTONDBLCLK: begin
      bMousePressed := True;
      RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);
      bMousePressed := False;
    end;

    WM_MOUSEMOVE:
      if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) and IsWindowEnabled(CtrlHandle) then
        if PtInRect(WndRect, acMousePos) then
          if DefaultManager.ActiveControl <> CtrlHandle then
            DefaultManager.ActiveControl := CtrlHandle
          else
            RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW)
        else
          if DefaultManager.ActiveControl = CtrlHandle then
            DefaultManager.ActiveControl := 0;
  end;
end;


procedure TacSpinWnd.PrepareCache;
var
  R, Btn1Rect, Btn2Rect: TRect;
  sArrowMask: integer;
  ParentBG: TacBGInfo;
  CI: TCacheInfo;
  p: TPoint;
begin
  ParentBG.Offset := MkPoint;
  ParentBG.PleaseDraw := False;
  GetBGInfo(@ParentBG, ParentWnd);
  CI := BGInfoToCI(@ParentBG);
  InitCacheBmp(SkinData);
  SkinData.FCacheBMP.Width  := WndSize.cx;
  SkinData.FCacheBMP.Height := WndSize.cy;

  if IsVertical then begin
    Btn1Rect := Rect(lOffset, 0, WndSize.cx, WndSize.cy div 2 + WndSize.cy mod 2);
    Btn2Rect := Rect(lOffset, WndSize.cy div 2, WndSize.cx, WndSize.cy);
    with SkinData.SkinManager do begin
      SkinData.SkinSection := SkinData.SkinManager.ConstData.UpDownBtns[asTop].SkinSection;
      PaintItem(SkinData, CI, True, Btn1State, Btn1Rect, Point(WndPos.X + Btn1Rect.Left, WndPos.Y + Btn1Rect.Top), SkinData.FCacheBMP, False);
      with ConstData.ScrollBtns[asTop] do
        if GlyphIndex >= 0 then begin
          p.x := Btn1Rect.Left + (WidthOf(Btn1Rect) - ma[GlyphIndex].Width) div 2;
          p.y := Btn1Rect.Top + (HeightOf(Btn1Rect) - ma[GlyphIndex].Height) div 2;
          DrawSkinGlyph(SkinData.FCacheBMP, p, Btn1State, 1, ma[GlyphIndex], MakeCacheInfo(SkinData.FCacheBmp));
        end
        else begin
          sArrowMask := GetFontIndex(SkinData.FOwnerControl, SkinData.SkinIndex, SkinData.SkinManager, Btn1State); // Receive parent font if needed
          R := Btn1Rect;
          if Btn1State = 2 then
            if ButtonsOptions.ShiftContentOnClick then
              OffsetRect(R, 1, 1);

          if sArrowMask >= 0 then
            DrawColorArrow(SkinData.FCacheBMP, gd[sArrowMask].Props[math.min(integer(Btn1State > 0), ac_MaxPropsIndex)].FontColor.Color, R, asTop)
          else
            DrawColorArrow(SkinData.FCacheBMP, 0, R, asTop);
        end;

      SkinData.SkinSection := SkinData.SkinManager.ConstData.UpDownBtns[asbottom].SkinSection;
      PaintItem(SkinData, CI, True, Btn2State, Btn2Rect, Point(WndPos.X + Btn2Rect.Left, WndPos.Y + Btn2Rect.Top), SkinData.FCacheBMP, False);
      with ConstData.ScrollBtns[asBottom] do
        if GlyphIndex >= 0 then begin
          p.x := Btn2Rect.Left + (WidthOf(Btn2Rect) - ma[GlyphIndex].Width) div 2;
          p.y := Btn2Rect.Top + (HeightOf(Btn2Rect) - ma[GlyphIndex].Height) div 2;
          DrawSkinGlyph(SkinData.FCacheBMP, p, Btn2State, 1, ma[GlyphIndex], MakeCacheInfo(SkinData.FCacheBmp));
        end
        else begin
          sArrowMask := GetFontIndex(SkinData.FOwnerControl, SkinData.SkinIndex, SkinData.SkinManager, Btn2State); // Receive parent font if needed
          R := Btn2Rect;
          if Btn2State = 2 then
            if ButtonsOptions.ShiftContentOnClick then
              OffsetRect(R, 1, 1);

          if sArrowMask >= 0 then
            DrawColorArrow(SkinData.FCacheBMP, gd[sArrowMask].Props[math.min(integer(Btn2State > 0), ac_MaxPropsIndex)].FontColor.Color, R, asBottom)
          else
            DrawColorArrow(SkinData.FCacheBMP, 0, R, asBottom);
        end;
    end;
  end
  else begin
{    SkinData.SkinSection := SkinData.SkinManager.ConstData.UpDownBtns[asLeft].SkinSection;
    if SkinData.SkinIndex < 0 then
      SkinData.SkinSection := s_Button;}

    Btn1Rect := MkRect(WndSize.cx div 2 + WndSize.cx mod 2, WndSize.cy);
    Btn2Rect := Rect(WndSize.cx div 2, 0, WndSize.cx, WndSize.cy);
    with SkinData.SkinManager do begin
      SkinData.SkinSection := SkinData.SkinManager.ConstData.UpDownBtns[asLeft].SkinSection;
      PaintItem(SkinData, CI, True, Btn1State, Btn1Rect, Point(WndPos.X, WndPos.Y), SkinData.FCacheBMP, True);
      with ConstData.ScrollBtns[asLeft] do
        if GlyphIndex >= 0 then begin
          p.x := Btn1Rect.Left + (WidthOf(Btn1Rect) - ma[GlyphIndex].Width) div 2;
          p.y := Btn1Rect.Top + (HeightOf(Btn1Rect) - ma[GlyphIndex].Height) div 2;
          DrawSkinGlyph(SkinData.FCacheBMP, p, Btn1State, 1, ma[GlyphIndex], MakeCacheInfo(SkinData.FCacheBmp));
        end
        else begin
          sArrowMask := GetFontIndex(SkinData.FOwnerControl, SkinData.SkinIndex, SkinData.SkinManager, Btn1State); // Receive parent font if needed
          R := Btn1Rect;
          if Btn1State = 2 then
            if ButtonsOptions.ShiftContentOnClick then
              OffsetRect(R, 1, 1);

          if sArrowMask >= 0 then
            DrawColorArrow(SkinData.FCacheBMP, gd[sArrowMask].Props[math.min(integer(Btn1State > 0), ac_MaxPropsIndex)].FontColor.Color, R, asLeft)
          else
            DrawColorArrow(SkinData.FCacheBMP, 0, R, asLeft);
        end;

      SkinData.SkinSection := SkinData.SkinManager.ConstData.UpDownBtns[asRight].SkinSection;
      PaintItem(SkinData, CI, True, Btn2State, Btn2Rect, Point(WndPos.X, WndPos.Y), SkinData.FCacheBMP, True);
      with ConstData.ScrollBtns[asRight] do
        if GlyphIndex >= 0 then begin
          p.x := Btn2Rect.Left + (WidthOf(Btn2Rect) - ma[GlyphIndex].Width) div 2;
          p.y := Btn2Rect.Top + (HeightOf(Btn2Rect) - ma[GlyphIndex].Height) div 2;
          DrawSkinGlyph(SkinData.FCacheBMP, p, Btn2State, 1, ma[GlyphIndex], MakeCacheInfo(SkinData.FCacheBmp));
        end
        else begin
          sArrowMask := GetFontIndex(SkinData.FOwnerControl, SkinData.SkinIndex, SkinData.SkinManager, Btn1State); // Receive parent font if needed
          R := Btn2Rect;
          if Btn2State = 2 then
            if ButtonsOptions.ShiftContentOnClick then
              OffsetRect(R, 1, 1);

          if sArrowMask >= 0 then
            DrawColorArrow(SkinData.FCacheBMP, gd[sArrowMask].Props[math.min(integer(Btn2State > 0), ac_MaxPropsIndex)].FontColor.Color, R, asRight)
          else
            DrawColorArrow(SkinData.FCacheBMP, 0, R, asRight);
        end;
    end;
  end;
end;


function TacSpinWnd.IsVertical: boolean;
begin
  Result := GetWindowLong(CtrlHandle, GWL_STYLE) and UDS_HORZ <> UDS_HORZ;
end;


procedure TacSpinWnd.AfterCreation;
begin
  bMousePressed := False;
  Btn1State := 0;
  Btn2State := 0;
  lOffset := 0;
  inherited;
end;


function TacBitBtnWnd.CaptionRect: TRect;
var
  GlyphPos: TPoint;
  gSize, cSize: TSize;
begin
  gSize := GlyphSize;
  cSize := TextRectSize;
  if SkinData.FOwnerControl is TBitBtn then begin
    CalcButtonLayout(MkRect(WndSize), Point(gSize.cx, gSize.cy), cSize, TBitBtn(SkinData.FOwnerControl).Layout, taCenter, 0, 0, GlyphPos, Result, DT_CENTER);
    if CurrentState = 2 then
      if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
        OffsetRect(Result, 1, 1);
  end
  else begin
    Result := inherited CaptionRect;
    if gSize.cx <> 0 then
      OffsetRect(Result, gSize.cx div 2 + 1, 0);
  end;
end;


function TacBitBtnWnd.CurrentState: integer;
var
  Wnd: THandle;
begin
  if Down then begin
    Result := 2;
    HideGlow(SkinData.GlowID);
  end
  else begin
    if not IsWindowEnabled(CtrlHAndle) then begin
      Result := 0;
      Exit
    end;

    if SkinData.FOwnerControl <> nil then begin // Patch Andreas for activ button
      if not (csDesigning in SkinData.FOwnerControl.ComponentState) and ControlIsActive(SkinData) then begin
        Result := 1;
        Exit;
      end;
    end
    else
      if (GetFocus = CtrlHandle) or (DefaultManager.ActiveControl = CtrlHandle) or SkinData.FFocused then begin
        Result := 1;
        Exit;
      end;

    // BS_OWNERDRAW is not compatible with BS_DEFPUSHBUTTON
    if (SkinData.FOwnerControl is TBitBtn) and TBitBtn(SkinData.FOwnerControl).Default then begin
      Wnd := GetFocus;
      // Focused control is a button
      if Wnd <> 0 then
        Result := iff(GetWindowLong(Wnd, GWL_STYLE) and BS_USERBUTTON = BS_USERBUTTON, 0, 3)
      else
        Result := 3
    end
    else
      Result := 0;
  end;
end;


procedure TacBitBtnWnd.DrawGlyph;
var
  DrawData: TacDrawGlyphData;
begin
  if SkinData.FOwnerControl is TBitBtn then
    with TBitBtn(SkinData.FOwnerControl) do begin
      if Glyph.PixelFormat = pfDevice then
        Glyph.HandleType := bmDIB;

      DrawData.Images            := nil;
      DrawData.Glyph             := Glyph;
      DrawData.ImageIndex        := 0;
      DrawData.SkinIndex         := SkinData.SkinIndex;
      DrawData.SkinManager       := SkinData.SkinManager;
      DrawData.DstBmp            := SkinData.FCacheBmp;
      DrawData.ImgRect           := GlyphRect;
      DrawData.NumGlyphs         := NumGlyphs;
      DrawData.Enabled           := Enabled;
      DrawData.Blend             := 0;
      DrawData.Down              := Down;
      DrawData.CurrentState      := CurrentState;
      DrawData.Grayed            := (DrawData.CurrentState = 0) and (SkinData.SkinManager <> nil) and SkinData.SkinManager.Effects.DiscoloredGlyphs and SkinData.Skinned;
      DrawData.DisabledGlyphKind := DefDisabledGlyphKind;
      DrawData.Reflected         := False;
      if DrawData.Grayed then
        DrawData.BGColor := SkinData.SkinManager.gd[DrawData.SkinIndex].Props[0].Color;

      acDrawGlyphEx(DrawData);
    end
end;


function TacBitBtnWnd.GlyphRect: TRect;
var
  rText: TRect;
  Size, sText: TSize;
  x, y, sp, dh, dw: integer;
begin
  Size := GlyphSize;
  if SkinData.FOwnerControl is TBitBtn then begin
    x := 0;
    y := 0;
    Result := MkRect;
    sText := TextRectSize;
    sp := TBitBtn(SkinData.FOwnerControl).Spacing * integer((Size.cx > 0) and (Caption <> ''));
    dw := (WndSize.cx - Size.cx - sText.cx - Sp) div 2;
    dh := (WndSize.cy - Size.cy - sText.cy - Sp) div 2;
    case TBitBtn(SkinData.FOwnerControl).Layout of
      blGlyphLeft: begin
        x := dw;
        y := (WndSize.cy - Size.cy) div 2;
      end;

      blGlyphRight: begin
        x := (WndSize.cx - Size.cx + Sp + sText.cx) div 2;
        y := (WndSize.cy - Size.cy) div 2;
      end;

      blGlyphTop: begin
        x := (WndSize.cx - Size.cx) div 2 + 1;
        y := dh;
      end;

      blGlyphBottom: begin
        x := (WndSize.cx - Size.cx) div 2 + 1;
        y := WndSize.cy - dh - Size.cy;
      end;
    end;
    if CurrentState = 2 then
      if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then begin
        inc(x);
        inc(y);
      end;
      
    Result := Rect(x, y, x + Size.cx, y + Size.cy);
  end
  else
    if Size.cx = 0 then
      Result := MkRect
    else begin
      rText := CaptionRect;
      Result.Right := rText.Left - 2;
      Result.Left := Result.Right - Size.cx;
      Result.Top := (WndSize.cy - Size.cy) div 2 + integer(Down);
      Result.Bottom := Result.Top + Size.cy;
    end;
end;


function TacBitBtnWnd.GlyphSize: TSize;
var
  hBmp: hBitmap;
begin
  if SkinData.FOwnerControl is TBitBtn then
    if TBitBtn(SkinData.FOwnerControl).Glyph <> nil then
      with TBitBtn(SkinData.FOwnerControl).Glyph do
        Result := MkSize(Width div TBitBtn(SkinData.FOwnerControl).NumGlyphs, Height)
    else
      Result.cx := 0
  else begin
    hBmp := ProcessMessage(BM_GETIMAGE, IMAGE_BITMAP, 0);
    if hBmp = 0 then
      Result.cx := 0
    else
      GetBitmapDimensionEx(hBmp, Result);
  end;
end;


function TacBitBtnWnd.MaxCaptionWidth: integer;
begin
  if SkinData.FOwnerControl is TBitBtn then
    with SkinData.FOwnerControl as TBitBtn do
      if Caption <> '' then begin
        Result := Width - 2 * Margin;
        case Layout of
          blGlyphLeft, blGlyphRight:
            Result := Result - (Spacing + GlyphSize.cx) * integer(GlyphSize.cy <> 0);
        end;
      end
      else
        Result := 0
  else
    Result := inherited MaxCaptionWidth;
end;


{$IFDEF D2009}
function TacButtonWnd.HaveImage: boolean;
begin
  if Btn <> nil then
    with Btn do
      Result := (Images <> nil) and IsValidIndex(ImageIndex, GetImageCount(Images))
  else
    Result := False;
end;


function TacButtonWnd.CaptionRect: TRect;
const
  wBorder = 3;
var
  l, t, r, b: integer;
  Size: TSize;
begin
  l := 0;
  t := 0;
  r := 0;
  b := 0;
  if Btn <> nil then
    SkinData.FCacheBMP.Canvas.Font := Btn.Font;

  Size := TextRectSize;
  with Btn do begin
    if HaveImage and (Btn.ImageAlignment <> iaCenter) then begin
      case ImageAlignment of
        iaLeft: begin
          l := ImageMargins.Left + wBorder + Images.Width;
          l := l + (Width - l - Size.cx) div 2;
          r := l + Size.cx;
          t := (Height - Size.cy) div 2;
          b := Height - t;
        end;

        iaRight: begin
          r := ImageMargins.Right + wBorder + Images.Width;
          l := (Width - r - Size.cx) div 2;
          r := l + Size.cx;
          t := (Height - Size.cy) div 2;
          b := Height - t;
        end;

        iaTop: begin
          t := ImageMargins.Top + wBorder + Images.Height;
          t := t + (Height - t - Size.cy) div 2;
          b := t + Size.cy;
          l := (Width - Size.cx) div 2;
          r := Width - l;
        end;

        iaBottom: begin
          b := ImageMargins.Bottom + wBorder + Images.Height;
          t := (Height - b - Size.cy) div 2;
          b := t + Size.cy;
          l := (Width - Size.cx) div 2;
          r := Width - l;
        end;
      end;
    end
    else begin
      l := (Width - Size.cx) div 2;
      r := Width - l;
      t := (Height - Size.cy) div 2;
      b := Height - t;
    end;
  end;
  Result := Rect(l - 1, t, r + 2, b);
  if CurrentState = 2 then
    if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
      OffsetRect(Result, 1, 1);
end;


procedure TacButtonWnd.DrawGlyph;
var
  DrawData: TacDrawGlyphData;
begin
  if not HaveImage then
    inherited
  else begin
    DrawData.Images            := Btn.Images;
    DrawData.Glyph             := nil;
    DrawData.ImageIndex        := GlyphIndex;
    DrawData.SkinIndex         := SkinData.SkinIndex;
    DrawData.SkinManager       := SkinData.SkinManager;
    DrawData.DstBmp            := SkinData.FCacheBmp;
    DrawData.ImgRect           := GlyphRect;
    DrawData.NumGlyphs         := 1;
    DrawData.Enabled           := Btn.Enabled;
    DrawData.Blend             := 0;
    DrawData.Down              := Down;
    DrawData.Grayed            := SkinData.Skinned and (SkinData.SkinManager <> nil) and SkinData.SkinManager.Effects.DiscoloredGlyphs;
    DrawData.CurrentState      := CurrentState;
    DrawData.DisabledGlyphKind := DefDisabledGlyphKind;
    DrawData.Reflected         := False;
    acDrawGlyphEx(DrawData);
  end;
end;


function TacButtonWnd.GlyphIndex: integer;
var
  State: integer;
begin
  if not Btn.Enabled then
    State := 4
  else
    if CurrentState = 2 then
      State := 2
    else
      State := iff(Btn.Focused, 3, CurrentState);

  with Btn do
    case State of
      0: Result := ImageIndex;
      1: Result := iff(IsValidIndex(HotImageIndex,      GetImageCount(Images)), HotImageIndex,      ImageIndex);
      2: Result := iff(IsValidIndex(PressedImageIndex,  GetImageCount(Images)), PressedImageIndex,  ImageIndex);
      3: Result := iff(IsValidIndex(SelectedImageIndex, GetImageCount(Images)), SelectedImageIndex, ImageIndex);
      4: Result := iff(IsValidIndex(DisabledImageIndex, GetImageCount(Images)), DisabledImageIndex, ImageIndex)
      else Result := -1;
    end;
end;


function TacButtonWnd.GlyphRect: TRect;
const
  wBorder = 3;
var
  l, t, r, b: integer;
begin
  l := 0;
  t := 0;
  r := 0;
  b := 0;
  if HaveImage then
    with Btn do begin
      case ImageAlignment of
        iaLeft: begin
          l := ImageMargins.Left + wBorder;
          r := l + Images.Width;
          t := (Height - Images.Height) div 2;
          b := t + Images.Height;
        end;

        iaRight: begin
          r := Width - ImageMargins.Right - wBorder;
          l := r - Images.Width;
          t := (Height - Images.Height) div 2;
          b := t + Images.Height;
        end;

        iaTop: begin
          t := ImageMargins.Bottom + wBorder;
          b := t + Images.Height;
          l := (Width - Images.Width) div 2;
          r := l + Images.Width;
        end;

        iaBottom: begin
          b := Height - ImageMargins.Bottom - wBorder;
          t := b - Images.Height;
          l := (Width - Images.Width) div 2;
          r := l + Images.Width;
        end;

        iaCenter: begin
          t := (Height - Images.Height) div 2;
          b := t + Images.Height;
          l := (Width - Images.Width) div 2;
          r := l + Images.Width;
        end;
      end;
      Result := Rect(l, t, r, b);
      if CurrentState = 2 then
        if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
          OffsetRect(Result, 1, 1);
    end
  else
    Result := MkRect;
end;


function TacButtonWnd.GlyphSize: TSize;
begin
  if HaveImage then
    Result := MkSize(Btn.Images.Width, Btn.Images.Height)
  else
    Result := MkSize;
end;


procedure TacButtonWnd.AfterCreation;
begin
  if (SkinData <> nil) and (SkinData.FOwnerControl <> nil) then
    Btn := TButton(SkinData.FOwnerControl);

  inherited;
end;
{$ENDIF}

{$IFNDEF NOMNUHOOK}
const
  MA_NEEDUPDATE    = 1;
  MA_SHOWN         = 2;
  MA_UPDATEBORDERS = 3;


procedure TacMnuWnd.acWndProc(var Message: TMessage);
var
  DC: hdc;
  mi: TacMenuInfo;
  i: integer;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_DESTROY, WM_NCDESTROY: begin
      if (OldProc <> nil) or Assigned(OldWndProc) then begin
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        UninitializeACWnd(CtrlHandle, False, False, TacMainWnd(Self));
        Destroyed := True; // Mark as destroyed
        RgnChanged := 0;
        ClearCache;
        DC := 0;
        for i := 0 to Length(MnuArray) - 1 do
          if (MnuArray[i] <> nil) and not MnuArray[i].Destroyed then begin
            DC := 1;
            RedrawWindow(MnuArray[i].CtrlHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW); // Update frames of visible menus
          end;

        if DC = 0 then
          ClearMnuArray; // Clear all if no visible menus

        acCanHookMenu := False;
      end
      else
        Message.Result := SendMessage(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);

      Exit;
    end;
  end;

  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_UPDATING:
        Message.LParam := RgnChanged;

      AC_GETAPPLICATION:
        Message.Result := LRESULT(Application);

      AC_CTRLHANDLED:
        Message.Result := 1;

      AC_DROPPEDDOWN:
        if IsWindowVisible(CtrlHandle) then
          RgnChanged := 1;
    end
  else
    if acCanHookMenu then
      case Message.Msg of
        WM_WINDOWPOSCHANGING: begin
          inherited;
          if not bFlag then
            with TWMWindowPosChanged(Message) do
              if (WindowPos.Flags and SWP_NOREDRAW = 0) and (WindowPos.Flags and SWP_SHOWWINDOW <> 0) then
                if not IsWindowVisible(CtrlHandle) then begin
                  bFlag := True;
                  SetWindowLong(CtrlHandle, GWL_EXSTYLE, GetWindowLong(CtrlHandle, GWL_EXSTYLE) or WS_EX_LAYERED);
                  SetLayeredWindowAttributes(CtrlHandle, clNone, 0, ULW_ALPHA); // Hide window for a blinking avoiding
                  bFlag := False;
                end;
        end;

        WM_ERASEBKGND: begin
          PrepareCache;
          if Message.WParam <> 0 then
            DC := hdc(Message.WParam)
          else
            DC := GetDC(CtrlHandle);

          BitBlt(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 3, 3, SRCCOPY);
          if DC <> hdc(Message.WParam) then
            ReleaseDC(CtrlHandle, DC);

          RgnChanged := 0;
          Message.Result := ERASE_OK;
        end;

        WM_NCPAINT: begin
          if not IsNT then
            inherited
          else begin
            mi.Bmp := nil;
            mi := SkinData.SkinManager.SkinableMenus.GetMenuInfo(nil, 0, 0, nil, CtrlHandle);
            DC := GetWindowDC(CtrlHandle);
            if (mi.Bmp <> nil) and (mi.Bmp.Width + 6 = WndSize.cx) and (mi.Bmp.Height = WndSize.cy) then // If cache image is exists already
              BitBltBorder(DC, 0, 0, mi.Bmp.Width, mi.Bmp.Height, mi.Bmp.Canvas.Handle, 0, 0, 3)
            else begin
              PrepareCache;
              BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, 3);
            end;
            ReleaseDC(CtrlHandle, DC);
            // Update BG, avoid a blinking
            if AeroIsEnabled and not Shown then
              RedrawWindow(CtrlHandle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE or RDW_ERASE);

            if SkinData.SkinManager.MenuSupport.AlphaBlend < MaxByte then begin
              SetWindowLong(CtrlHandle, GWL_EXSTYLE, GetWindowLong(CtrlHandle, GWL_EXSTYLE) or WS_EX_LAYERED);
              SetLayeredWindowAttributes(CtrlHandle, clNone, SkinData.SkinManager.MenuSupport.AlphaBlend, ULW_ALPHA);
            end
            else
              SetWindowLong(CtrlHandle, GWL_EXSTYLE, GetWindowLong(CtrlHandle, GWL_EXSTYLE) and not WS_EX_LAYERED);
          end;
          Shown := True;
        end

        else
          inherited;
      end
    else
      inherited;
end;


procedure TacMnuWnd.AfterCreation;
begin
  RgnChanged := 0;
  Shown := False;
  bFlag := False;
  inherited;
end;


procedure TacMnuWnd.PrepareCache;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  if SkinData.BGChanged then begin
    InitCacheBmp(SkinData);
    SkinData.FCacheBMP.Width := WndSize.cx;
    SkinData.FCacheBMP.Height := WndSize.cy;
    PaintItem(SkinData, EmptyCI, True, 0, MkRect(WndSize), Point(WndRect.Left - ParentRect.Left, WndRect.Top - ParentRect.Top), SkinData.FCacheBMP, False, 0, 0);
    UpdateWndCorners(SkinData, 0, Self);
    SkinData.BGChanged := False;
  end;
end;
{$ENDIF}


procedure TacWWComboBoxWnd.acWndProc(var Message: TMessage);
var
  i: integer;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if Message.Msg = WM_CTLCOLORLISTBOX then
    Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam)
  else begin
    inherited;
    case Message.Msg of
      WM_PARENTNOTIFY:
        if (Message.WParamLo = WM_CREATE) and (SkinData.FOwnerControl <> nil) then
          with TWinControl(SkinData.FOwnerControl) do
            for i := 0 to ControlCount - 1 do
              if Controls[i] is TCustomListBox then begin
                ListBox := TCustomListBox(Controls[i]);
                ListBoxSkinData := TsScrollWndData.Create(ListBox, True);
                ListBoxSkinData.SkinSection := s_EDIT;
                ListBoxSkinData.FOwnerControl := ListBox;
                RefreshEditScrolls(ListBoxSkinData, ListBoxSW);
                if (ListBoxSW <> nil) and ListBoxSW.Destroyed then
                  FreeAndNil(ListBoxSW);

                RefreshEditScrolls(ListBoxSkinData, ListBoxSW);
              end;
    end;
  end;
end;


procedure TacWWComboBoxWnd.AfterCreation;
begin
  ListBox := nil;
  ListBoxSkinData := nil;
  if SkinData.FOwnerControl <> nil then
    FShowButton := GetShowButton(TWinControl(SkinData.FOwnerControl));

  inherited;
end;


function TacWWComboBoxWnd.ButtonRect: TRect;
const
  bWidth = 2;
var
  w: integer;
  r: TRect;
begin
  if FShowButton then
    w := GetSystemMetrics(SM_CXVSCROLL)
  else
    w := 0;

  GetWindowRect(CtrlHandle, r);
  if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_RTLREADING <> 0 then
    Result.Left := bWidth
  else
    Result.Left := WidthOf(r) - w - bWidth;

  Result.Top := bWidth;
  Result.Right := Result.Left + w;
  Result.Bottom := HeightOf(r) - bWidth;
end;


destructor TacWWComboBoxWnd.Destroy;
begin
  if ListBoxSkinData <> nil then
    FreeAndNil(ListBoxSkinData);

  inherited;
end;


function TacWWComboBoxWnd.GetShowButton(aCtrl: TWinControl): Boolean;
begin
  if aCtrl is TComboBox then
    Result := (aCtrl as TComboBox).Style in [StdCtrls.csDropDown, StdCtrls.csDropDownList]
  else
    Result := True;
end;


procedure TacPanelWnd.AC_WMPaint(aDC: hdc);
var
  b: boolean;
  w: integer;
  R, ClRect: TRect;
  DC, SaveIndex: HDC;
begin
  if not (csDestroying in SkinData.FOwnerControl.ComponentState) then begin
    if (SkinData.FOwnerControl.Parent <> nil) and (csCreating in SkinData.FOwnerControl.Parent.ControlState) then
      Exit;

    if not SkinData.Updating then begin
      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      if aDC = 0 then
        DC := GetWindowDC(Panel.Handle)
      else
        DC := aDC;

      SaveIndex := SaveDC(DC);
      try
        // If transparent and form resizing processed
        b := SkinData.HalfVisible or SkinData.BGChanged;
        if SkinData.RepaintIfMoved then begin
          GetClipBox(DC, R);
          SkinData.HalfVisible := (WidthOf(R) <> Panel.Width) or (HeightOf(R) <> Panel.Height)
        end
        else
          SkinData.HalfVisible := False;

        if b then
          PrepareCache;

        GetClientRect(CtrlHandle, ClRect);
        w := (WidthOf(WndRect) - WidthOf(ClRect)) div 2;
        if Panel <> nil then begin
          CopyWinControlCache(Panel, SkinData, Rect(w, w, 0, 0), MkRect(Panel.Width - 2 * w, Panel.Height - 2 * w), DC, True);
          sVCLUtils.PaintControls(DC, Panel, b and SkinData.RepaintIfMoved, MkPoint);
          SetParentUpdated(Panel);
        end
        else
          BitBlt(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);

      finally
        RestoreDC(DC, SaveIndex);
        if aDC = 0 then
          ReleaseDC(Panel.Handle, DC);
      end;
    end;
  end;
end;


procedure TacPanelWnd.acWndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  M: TMessage;
begin
{$IFDEF LOGGED}
//  if (Panel <> nil) and (Panel.Tag = 1) then
//    AddToLog(Message);
{$ENDIF}
  if (SkinData.FOwnerControl <> nil) and (csAcceptsControls in TWinControl(SkinData.FOwnerControl).ControlStyle) then begin
    if Message.Msg = SM_ALPHACMD then
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit;
        end; // AlphaSkins supported

        AC_GETAPPLICATION: begin
          Message.Result := LRESULT(Application);
          Exit;
        end;

        AC_SETNEWSKIN, AC_REFRESH: begin
          inherited;
          AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);
          Exit;
        end;

        AC_REMOVESKIN: begin
          SkinData.SkinIndex := -1;
          SkinData.FOwnerControl.ControlStyle := SkinData.FOwnerControl.ControlStyle - [csOpaque];
          inherited;
          Exit;
        end;

        AC_PREPARECACHE: begin
          PrepareCache;
          Exit;
        end;

        AC_ENDPARENTUPDATE: begin
          if SkinData.FUpdating then begin
            SkinData.Updating := False;
            RedrawWindow(CtrlHandle, nil, 0, RDWA_ALLNOW)
          end;
          if SkinData.FOwnerControl <> nil then
            SetParentUpdated(TWinControl(SkinData.FOwnerControl));

          Exit;
        end;
      end
    else
      if Assigned(SkinData) and SkinData.Skinned then
        case Message.Msg of
          WM_PAINT: begin
            InvalidateRect(CtrlHandle, nil, True);
            BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
            EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
            Exit;
          end;

          WM_NCPAINT: begin
            AC_WMNCPaint;
            Message.Result := 0;
            Exit;
          end;

          WM_ERASEBKGND: begin
            AC_WMPaint(TWMPaint(Message).DC);
            Message.Result := ERASE_OK;
            Exit;
          end;

          WM_UPDATEUISTATE: begin
            Message.Result := 1;
            Exit;
          end;

          WM_PRINT: begin
            SkinData.BGChanged := True;
            AC_WMPaint(TWMPaint(Message).DC);
            AC_WMNCPaint(TWMPaint(Message).DC);
            Exit;
          end;

          CM_SHOWINGCHANGED:
            if SkinData.FOwnerControl.Visible then begin
              if SkinData.SkinManager.Options.OptimizingPriority = opMemory then
                SkinData.Updating := False;

              AddToAdapter(TWinControl(SkinData.FOwnerControl));
              M := MakeMessage(SM_ALPHACMD, AC_SETNEWSKIN_HI, Longint(SkinData.SkinManager), 0);
              AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, M);
              M := MakeMessage(SM_ALPHACMD, AC_REFRESH_HI, Longint(SkinData.SkinManager), 0);
              AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, M);
            end;

          WM_PARENTNOTIFY:
            if Message.WParamLo in [WM_CREATE, WM_DESTROY] then begin
              inherited;
              if Message.WParamLo = WM_CREATE then
                AddToAdapter(TWinControl(SkinData.FOwnerControl));

              Exit;
            end;

          CM_TEXTCHANGED:
            SkinData.BGChanged := True;

          WM_WINDOWPOSCHANGED, WM_WINDOWPOSCHANGING:
            if SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Transparency <> 0 then
              SkinData.BGChanged := True;

          WM_SETTEXT:
            if IsWindowVisible(CtrlHandle) then begin
              SetRedraw(CtrlHandle, 0);
              inherited;
              SetRedraw(CtrlHandle, 1);
              SkinData.BGChanged := True;
              SendMessage(CtrlHandle, WM_PAINT, 0, 0);
              Exit;
            end;

          CM_VISIBLECHANGED: begin
            SkinData.BGChanged := True;
            SkinData.Updating := False;
            if Message.WParam = 1 then begin
              PrepareCache;
              inherited;
              if Panel <> nil then
                SetParentUpdated(Panel);
            end
            else
              inherited;

            Exit;
          end;
        end;
  end;
  inherited;
  case Message.Msg of
    WM_WINDOWPOSCHANGING:
      SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);
  end;
end;


function TacPanelWnd.PrepareCache: boolean;
var
  Panel: TacAccessPanel;
  CI: TCacheInfo;
  w: integer;
  R: TRect;
begin
  Panel := TacAccessPanel(SkinData.FOwnerControl);
  InitCacheBmp(SkinData);
  CI := GetParentCache(SkinData);
  if not CI.Ready and (CI.FillColor = clFuchsia) then begin
    SkinData.Updating := True;
    Result := False;
  end
  else begin
    Result := True;
    PaintItem(SkinData, CI, False, 0, MkRect(Panel.Width, Panel.Height), MkPoint(Panel), SkinData.FCacheBMP, False);
    R := Panel.ClientRect;
    w := Panel.BorderWidth + integer(Panel.BevelInner <> bvNone) * Panel.BevelWidth + integer(Panel.BevelOuter <> bvNone) * Panel.BevelWidth;
    InflateRect(R, -w, -w);
    WriteText(R, SkinData.FCacheBmp.Canvas);
    SkinData.BGChanged := False;
  end;
end;


procedure TacPanelWnd.AC_WMNCPaint(aDC: hdc = 0);
var
  DC: hdc;
  w: integer;
  ClRect: TRect;
begin
  if not InUpdating(SkinData) then begin
    GetWindowRect(CtrlHandle, WndRect);
    GetClientRect(CtrlHandle, ClRect);
    WndSize := MkSize(WndRect);
    if aDC = 0 then
      DC := GetWindowDC(CtrlHandle)
    else
      DC := aDC;

    try
      if not PrepareCache then begin
        SkinData.Updating := True;
        Exit;
      end;
      w := (WidthOf(WndRect) - WidthOf(ClRect)) div 2;
      if w > 0 then
        BitBltBorder(DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, 0, w);
    finally
      if aDC = 0 then
        ReleaseDC(CtrlHandle, DC);
    end;
  end;
end;


procedure TacPanelWnd.WriteText(R: TRect; aCanvas: TCanvas);
var
  Flags: Cardinal;
  h: integer;
begin
  if (Panel = nil) or (Panel.Tag <> 999) then begin // If SilentPanel
    if SkinData.FOwnerControl <> nil then
      aCanvas.Font.Assign(TsAccessControl(SkinData.FOwnerControl).Font);

    aCanvas.Brush.Style := bsClear;
    h := aCanvas.TextHeight('Wg');
    R.Top := (R.Bottom + R.Top - h) div 2;
    R.Bottom := R.Top + h;
    Flags := DT_VCENTER;
    if Panel <> nil then
      Flags := Flags or Cardinal(GetStringFlags(Panel, Panel.Alignment)) or DT_WORDBREAK
    else
      Flags := Flags or DT_CENTER;

    if SkinData.FOwnerControl <> nil then
      acWriteTextEx(aCanvas, PacChar(Caption), SkinData.FOwnerControl.Enabled, R, Flags, SkinData, False)
    else
      acWriteTextEx(aCanvas, PacChar(Caption), True, R, DT_CENTER or DT_VCENTER, SkinData, False);
  end;
end;


procedure TacPanelWnd.AfterCreation;
var
  b: boolean;
  m: TMessage;
begin
  if SkinData.FOwnerControl <> nil then begin
    b := SkinData.FUpdating;
    SkinData.Updating := True;
    Panel := TacAccessPanel(SkinData.FOwnerControl);
    if SkinData.SkinSection = '' then
      case Panel.BevelOuter of // If not custom SkinSection
        bvRaised:  SkinData.SkinSection := iff(Panel.BevelInner = bvLowered, s_GroupBox, s_Panel);
        bvLowered: SkinData.SkinSection := iff(Panel.BevelInner = bvRaised,  s_GroupBox, s_PanelLow)
        else       SkinData.SkinSection := iff(Panel.BorderStyle = bsNone,   s_Transparent, s_PanelLow);
      end;

    SkinData.Updating := b;
    m.Msg := SM_ALPHACMD;
    m.WParam := AC_SETNEWSKIN_HI;
    m.LParam := LParam(SkinData.SkinManager);
    AlphaBroadCast(Panel, m);
  end
  else
    Panel := nil;

  inherited;
end;


procedure TacTabControlWnd.AC_WMPaint(var Message: TWMPaint);
var
  ChangedSkinSection: string;
  DC, SavedDC, TabDC: hdc;
  ci: TCacheInfo;
  R: TRect;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  SavedDC := 0;
  TabDC := 0;
  if not InUpdating(SkinData) then begin
    if (Message.Unused = 1) or InAnimationProcess or (SkinData.CtrlSkinState and ACS_PRINTING <> 0) then
      DC := Message.DC
    else begin
      DC := GetDC(CtrlHandle);
      SavedDC := SaveDC(DC);
    end;
    try
      // If transparent and form resizing processed
      SkinData.BGChanged := True;
      if TabCount <= 0 then
        ChangedSkinSection := s_Transparent
      else
        if SkinData.SkinSection = s_PageControl then
          ChangedSkinSection := s_PageControl + sTabPositions[TabPosition]
        else
          ChangedSkinSection := SkinData.SkinSection;

      SkinData.SkinIndex := SkinData.SkinManager.GetSkinIndex(ChangedSkinSection);
      CI := GetParentCacheHwnd(CtrlHandle);
      InitCacheBmp(SkinData);
      if SkinData.BGChanged then begin
        SkinData.FCacheBmp.Width := WndSize.cx;
        SkinData.FCacheBmp.Height := WndSize.cy;
        if TabCount > 0 then
          DrawSkinTabs(CI);

        R := PageRect;
        PaintItem(SkinData.SkinIndex, CI, False, 0, R, Point(WndPos.X, WndPos.Y), SkinData.FCacheBmp, SkinData.SkinManager);
        SkinData.BGChanged := False;
      end;
      if (TabCount > 0) and (ActiveTabIndex >= 0) then begin
        R := SkinTabRect(ActiveTabIndex, True);
        TabDC := SaveDC(DC);
        ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
      end;
      BitBlt(DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      if (TabCount > 0) and (ActiveTabIndex >= 0) then begin
        RestoreDC(DC, TabDC);
        if Message.Unused <> 1 then begin
          RestoreDC(DC, SavedDC);
          SavedDC := SaveDC(DC);
        end;
        DrawSkinTab(ActiveTabIndex, 2, DC);
      end;
      if SkinData.FOwnerControl <> nil then
        sVCLUtils.PaintControls(DC, TWinControl(SkinData.FOwnerControl), True, MkPoint);
    finally
      if DC <> Message.DC then begin
        RestoreDC(DC, SavedDC);
        ReleaseDC(CtrlHandle, DC);
      end;
    end;
  end
end;


procedure TacTabControlWnd.acWndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  i: integer;
  R: TRect;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if SkinData <> nil then
    if Message.Msg = SM_ALPHACMD then
      case Message.WParamHi of
        AC_GETSERVICEINT: begin
          Message.Result := LRESULT(SkinData.SkinManager);
          Exit;
        end;

        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit;
        end;

        AC_REMOVESKIN: begin
          if Message.LParam = LPARAM(SkinData.SkinManager) then begin
            CommonWndProc(Message, SkinData);
            CheckUpDown;
            AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);
            InvalidateRect(CtrlHandle, nil, True);
            RedrawWindow(CtrlHandle, nil, 0, RDWA_ALLNOW);
          end
          else
            AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);

          Exit;
        end;

        AC_REFRESH: begin
          if Message.LParam = LPARAM(SkinData.SkinManager) then begin
            CommonWndProc(Message, SkinData);
            InvalidateRect(CtrlHandle, nil, True);
            CheckUpDown;
          end;
          AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);
          Exit;
        end;

        AC_SETNEWSKIN: begin
          if Message.LParam = LPARAM(SkinData.SkinManager) then
            CommonWndProc(Message, SkinData);

          if SkinData.FOwnerControl <> nil then // Be sure that Tabs handles allocated already
            with TWinControl(SkinData.FOwnerControl) do
              for i := 0 to ControlCount - 1 do
                if (Controls[i] is TWinControl) and not TWinControl(Controls[i]).HandleAllocated then
                  TWinControl(Controls[i]).HandleNeeded;

          AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);
          Exit;
        end;

        AC_PREPARING:
          if SkinData.Skinned then begin
            Message.Result := LRESULT(SkinData.FUpdating);
            Exit;
          end;

        AC_ENDPARENTUPDATE:
          if SkinData.Skinned then begin
            SkinData.Updating := False;
            InvalidateRect(CtrlHandle, nil, True);
            Exit;
          end;

        AC_GETBG:
          if SkinData.Skinned then begin
            CommonWndProc(Message, SkinData);
            Exit;
          end;
      end
    else
      if SkinData.Skinned then
        case Message.Msg of
          TCM_SETCURSEL: begin
            ProcessMessage(WM_SETREDRAW, 0, 0);
            inherited;
            ProcessMessage(WM_SETREDRAW, 1, 0);
            Exit;
          end;

          WM_PRINT: begin
            CheckUpDown;
            AC_WMPaint(TWMPaint(Message));
            if (BtnSW <> nil) and not SkinData.BGChanged then
              RedrawWindow(BtnSW.CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);

            Exit;
          end;

          WM_NCPAINT:
            Exit;

          WM_ERASEBKGND:
            if IsWindowVisible(CtrlHandle) then begin
              if not InAnimationProcess then
                AC_WMPaint(TWMPaint(Message));

              CheckUpDown;
              Message.Result := ERASE_OK;
              Exit;
            end;

          WM_PAINT: begin
            InvalidateRect(CtrlHandle, nil, True); // Background update (for repaint of graphic controls and for tansheets refreshing)
            BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
            EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
            if (BtnSW <> nil) and not SkinData.BGChanged then
              RedrawWindow(BtnSW.CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);

            Exit;
          end;
        end;

  inherited;
  if (SkinData <> nil) and SkinData.Skinned then
    case Message.Msg of
      CM_CONTROLLISTCHANGE:
        CheckUpDown;
{
      WM_GETDLGCODE: begin
        SendAMessage(GetParent(CtrlHandle), AC_UPDATECHILDREN);
        RedrawWindow(CtrlHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN)
      end;
}
      TCM_SETCURSEL:
        RedrawWindow(CtrlHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);

      WM_SIZE: begin
        CheckUpDown;
        GetWindowRect(CtrlHandle, R);
        if (WidthOf(R) < WndSize.cx) or (HeightOf(R) < WndSize.cy) then
          RedrawWindow(CtrlHandle, nil, 0, RDWA_NOCHILDREN);
      end;
    end;
end;


function TacTabControlWnd.TabCount: integer;
begin
  Result := ProcessMessage(TCM_GETITEMCOUNT, 0, 0);
end;


procedure TacTabControlWnd.DrawSkinTabs(const CI: TCacheInfo);
var
  i, Row, rc: integer;
  aRect: TRect;
begin
  aRect := TabsRect;
  if not ci.Ready then begin
    SkinData.FCacheBmp.Canvas.Brush.Style := bsSolid;
    SkinData.FCacheBmp.Canvas.Brush.Color := CI.FillColor;
    SkinData.FCacheBmp.Canvas.FillRect(aRect);
  end
  else
    BitBlt(SkinData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, min(WidthOf(aRect), ci.Bmp.Width), min(HeightOf(aRect), ci.Bmp.Height),
           ci.Bmp.Canvas.Handle, ci.X + WndPos.x + aRect.Left, ci.Y + WndPos.Y + aRect.Top, SRCCOPY);

  // Draw tabs in a special order
  rc := TabCtrl_GetRowCount(CtrlHandle);
  for Row := 1 to rc do
    for i := 0 to TabCount - 1 do
      if (i <> ActiveTabIndex) and (TabRow(i) = Row) then
        DrawSkinTab(i, 0, SkinData.FCacheBmp, MkPoint);
end;


function TacTabControlWnd.PageRect: TRect;
begin
  Result := MkRect(WndSize);
  if TabCount > 0 then
    case TabPosition of
      tpTop:    Result.Top    := ClientRect.Top    - TopOffset;
      tpBottom: Result.Bottom := ClientRect.Bottom + BottomOffset;
      tpLeft:   Result.Left   := ClientRect.Left   - LeftOffset;
      tpRight:  Result.Right  := ClientRect.Right  + RightOffset;
    end;
end;


function TacTabControlWnd.ActiveTabIndex: integer;
begin
  Result := ProcessMessage(TCM_GETCURSEL, 0, 0);
end;


function TacTabControlWnd.SkinTabRect(Index: integer; Active: boolean): TRect;
var
  aTabsCovering: integer;
begin
  Result := MkRect;
  if IsValidIndex(Index, TabCount) then begin
    Result := TabRect(Index);
    if (Style = tsTabs) and (Result.Left <> Result.Right) then begin
      aTabsCovering := 0;
      if Style = tsTabs then
        aTabsCovering := SkinData.SkinManager.CommonSkinData.TabsCovering;

      if Active then
        dec(Result.Bottom, 1)
      else begin
        inc(Result.Bottom, 3);
        dec(Result.Right, 1);
      end;

      case TabPosition of
        tpTop: begin
          InflateRect(Result, 2 * Integer(Active), 2 * Integer(Active));
          inc(Result.Bottom, 1);
        end;

        tpBottom: begin
          InflateRect(Result, 2 * Integer(Active), Integer(Active));
          dec(Result.Top, 2);
          if Active then
            inc(Result.Bottom)
          else
            dec(Result.Bottom, 3);
        end;

        tpLeft: begin
          InflateRect(Result, 0, 1);
          inc(Result.Right, 2);
          if Active then
            InflateRect(Result, 1, 1)
          else begin
            dec(Result.Bottom, 4);
            inc(Result.Right, 2);
          end;
        end;

        tpRight: begin
          InflateRect(Result, 1, 0);
          OffsetRect(Result, -1, -1);
          if Active then begin
            InflateRect(Result, 1, 1);
            inc(Result.Bottom, 3);
          end
          else
            dec(Result.Bottom, 2);
        end;
      end;
      if aTabsCovering > 0 then
        if TabPosition in [tpTop, tpBottom] then begin
          OffsetRect (Result, aTabsCovering, 0);
          InflateRect(Result, aTabsCovering, 0);
        end
        else begin
          OffsetRect (Result, 0, aTabsCovering);
          InflateRect(Result, 0, aTabsCovering);
        end;
    end;
  end;
end;


procedure TacTabControlWnd.DrawSkinTab(Index, State: integer; Bmp: TBitmap; OffsetPoint: TPoint);
var
  Font: TFont;
  SavedDC: hdc;
  CI: TCacheInfo;
  pFont: PLogFontA;
  lCaption: ACString;
  VertFont: TLogFont;
  TabSection: string;
  bFont, cFont: hfont;
  ItemData: {$IFDEF TNTUNICODE}TTCItemW{$ELSE}TTCItem{$ENDIF};
  ImgList: HImageList;
  bFontChanged: boolean;
  rText, aRect, R: TRect;
  TempBmp: Graphics.TBitmap;
  PageControl: TPageControl;
  ImageList: TCustomImageList;
  Buffer: array [0..4095] of AcChar;
  i, h, w, iHeight, iWidth, TabsCovering, TabIndex, TabMask, TabState: integer;

  function ColorTone: TColor;
  begin
    if State = 0 then
      if TabIndex >= 0 then
        Result := SkinData.SkinManager.gd[TabIndex].Props[0].Color
      else
        Result := clBtnFace
    else
      Result := clNone;
  end;

  procedure MakeVertFont(Orient: integer);
  begin
    Font := TFont.Create;
    Font.Assign(Bmp.Canvas.Font);
    pFont := PLogFontA(@VertFont);
    GetObject(Bmp.Canvas.Handle, SizeOf(TLogFont), pFont);
    VertFont.lfEscapement := Orient;
    VertFont.lfHeight := Bmp.Canvas.Font.Height;
    VertFont.lfStrikeOut := integer(fsStrikeOut in Bmp.Canvas.Font.Style);
    VertFont.lfItalic := integer(fsItalic in Bmp.Canvas.Font.Style);
    VertFont.lfUnderline := integer(fsUnderline	in Bmp.Canvas.Font.Style);
    VertFont.lfWeight := FW_NORMAL;
    VertFont.lfCharSet := Bmp.Canvas.Font.Charset;
    VertFont.lfWidth := 0;
    Vertfont.lfOutPrecision := OUT_DEFAULT_PRECIS;
    VertFont.lfClipPrecision := CLIP_DEFAULT_PRECIS;
    VertFont.lfOrientation := VertFont.lfEscapement;
    VertFont.lfPitchAndFamily := Default_Pitch;
    VertFont.lfQuality := Default_Quality;
    StrPCopy(VertFont.lfFaceName, Bmp.Canvas.Font.Name);
    if Font.Name <> 'MS Sans Serif' then
      StrPCopy(VertFont.lfFaceName, Font.Name)
    else
      VertFont.lfFaceName := 'Arial';

    Bmp.Canvas.Font.Handle := CreateFontIndirect(VertFont);
    Bmp.Canvas.Font.Color := SkinData.SkinManager.gd[TabIndex].Props[integer(State <> 0)].FontColor.Color;
  end;

  procedure KillVertFont;
  begin
    if Font <> nil then begin
      Bmp.Canvas.Font.Assign(Font);
      FreeAndNil(Font);
    end;
  end;

begin
  if Index >= 0 then begin
    bFont := LongWord(ProcessMessage(WM_GETFONT, 0, 0));
    cFont := SelectObject(Bmp.Canvas.Handle, bFont);
    R := SkinTabRect(Index, Index = ActiveTabIndex);
    if (State = 1) and (R.Left < 0) then
      Exit;

    rText := SkinTabRect(Index, (State = 2) and (Index = ActiveTabIndex));
    aRect := rText;
    ItemData.mask := TCIF_IMAGE or TCIF_STATE or TCIF_TEXT;
{$IFNDEF FPC}
    ItemData.dwStateMask := TCIF_STATE;
{$ENDIF}
    ItemData.pszText := Buffer;
    ItemData.cchTextMax := SizeOf(Buffer);
    ProcessMessage({$IFDEF TNTUNICODE}TCM_GETITEMW{$ELSE}TCM_GETITEM{$ENDIF}, Index, LPARAM(@ItemData));
    lCaption := Buffer;
    if SkinData.FOwnerControl is TPageControl then
      PageControl := TPageControl(SkinData.FOwnerControl)
    else
      PageControl := nil;

    TabsCovering := 0;
    // Tabs drawing
    with SkinData.SkinManager do begin
      if ConstData.Tabs[tlSingle][asTop].SkinIndex > 0 then begin // new style
        TabState := State;
        case Style of
          tsTabs: with ConstData.Tabs[tlSingle][acTabSides[TabPosition]] do begin
            TabIndex   := SkinIndex;
            TabMask    := MaskIndex;
            TabSection := SkinSection;
            TabsCovering := CommonSkinData.TabsCovering;
          end;

          tsButtons: begin
            TabSection := s_Button;
            TabIndex   := GetSkinIndex(TabSection);
            TabMask    := GetMaskIndex(TabIndex, s_BordersMask);
          end

          else begin
            TabSection := s_ToolButton;
            TabIndex   := GetSkinIndex(TabSection);
            TabMask    := GetMaskIndex(TabIndex, s_BordersMask);
          end;
        end;

        if IsValidImgIndex(TabMask) then begin // Drawing of tab
          TempBmp := CreateBmp32(aRect);
          try
            if (State = 2) and (Index = ActiveTabIndex) then begin
              // Restore BG for Active tab
              BitBlt(TempBmp.Canvas.Handle, aRect.Left + OffsetPoint.x, aRect.Top + OffsetPoint.y, TempBmp.Width, TempBmp.Height,
                       SkinData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, SRCCOPY);
              OffsetRect(R, OffsetPoint.X, OffsetPoint.Y);
              BitBlt(TempBmp.Canvas.Handle, 0, 0, TempBmp.Width, TempBmp.Height,
                     SkinData.FCacheBmp.Canvas.Handle, SkinTabRect(Index, Index = ActiveTabIndex).Left,
                     SkinTabRect(Index, Index = ActiveTabIndex).Top, SRCCOPY);
              // Paint active tab
              BitBlt(Bmp.Canvas.Handle, aRect.Left + OffsetPoint.x, aRect.Top + OffsetPoint.y, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
              CI := MakeCacheInfo(TempBmp);
              PaintItem(TabIndex, CI, True, TabState, MkRect(TempBmp), MkPoint, Bmp, SkinData.SkinManager);
            end
            else begin
              CI := MakeCacheInfo(SkinData.FCacheBmp);
              if State = 1 then
                CI.X := 0;

              PaintItem(TabIndex, CI, True, TabState, MkRect(TempBmp), aRect.TopLeft, TempBmp, SkinData.SkinManager);
              SavedDC := SaveDC(Bmp.Canvas.Handle);
              R := PageRect;
              if TabPosition in [tpLeft, tpTop] then
                ExcludeClipRect(Bmp.Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);

              BitBlt(Bmp.Canvas.Handle, aRect.Left + OffsetPoint.x, aRect.Top + OffsetPoint.y, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
              RestoreDC(Bmp.Canvas.Handle, SavedDC);
            end;
          finally
            FreeAndNil(TempBmp);
          end;
        end;
      end;
    end;
    // End of tabs drawing
    // Drawing of the tab content
    OffsetRect(rText, OffsetPoint.x, OffsetPoint.y);
    R := rText;
{$IFNDEF FPC}
    if (PageControl <> nil) and TPageControl(SkinData.FOwnerControl).OwnerDraw and Assigned(TPageControl(SkinData.FOwnerControl).OnDrawTab) then begin
      PageControl.Canvas.Handle := Bmp.Canvas.Handle;
      PageControl.Canvas.Font.Assign(TsAccessControl(SkinData.FOwnerControl).Font);
      Bmp.Canvas.Font.Assign(PageControl.Canvas.Font);
      if TabIndex >= 0 then begin
        Bmp.Canvas.Font.Color := SkinData.SkinManager.gd[TabIndex].Props[min(State, ac_MaxPropsIndex)].FontColor.Color;
        PageControl.Canvas.Font.Color := Bmp.Canvas.Font.Color;
      end
      else
        Bmp.Canvas.Font.Color := PageControl.Canvas.Font.Color;

      PageControl.OnDrawTab(TPageControl(SkinData.FOwnerControl), Index, R, State = 2);
      bFontChanged := (Bmp.Canvas.Font.Color <> PageControl.Canvas.Font.Color) or
                      (Bmp.Canvas.Font.Style <> PageControl.Canvas.Font.Style) or
                      (Bmp.Canvas.Font.Name <> PageControl.Canvas.Font.Name);

      if bFontChanged then
        Bmp.Canvas.Font.Assign(PageControl.Canvas.Font);

      PageControl.Canvas.Handle := 0;
    end
    else
{$ENDIF}
      bFontChanged := False;

    InflateRect(R, -3, -3);
    ImgList := ProcessMessage(TCM_GETIMAGELIST, 0, 0);
    if SkinData.FOwnerControl = nil then
      ImageList := nil
    else
      ImageList := TTabControl(SkinData.FOwnerControl).Images;

    if TabPosition in [tpTop, tpBottom] then begin
      if TabsCovering > 0 then
        InflateRect(R, -TabsCovering * 2, 0);
    end
    else
      if TabsCovering > 0 then
        InflateRect(R, 0, -TabsCovering * 2);

    if (SkinData.FOwnerControl <> nil) and not bFontChanged then
      Bmp.Canvas.Font.Assign(TsAccessControl(SkinData.FOwnerControl).Font);

    case TabPosition of
      tpTop, tpBottom: begin
        if (ImgList <> 0) and (ItemData.iImage >= 0) then begin
          ImageList_GetIconSize(ImgList, w, h);
          if ImageList <> nil then
            if (ImageList is TsAlphaImageList) and SkinData.SkinManager.Effects.DiscoloredGlyphs then
              DrawAlphaImgList(ImageList, Bmp,
                               rText.Left + (WidthOf(rText) - (acTextWidth(Bmp.Canvas, lCaption) + w + 8)) div 2,
                               rText.Top + (HeightOf(rText) - w) div 2,
                               ItemData.iImage, 0, ColorTone, 0, 1, False)
            else
              ImageList.Draw(Bmp.Canvas,
                             rText.Left + (WidthOf(rText) - (acTextWidth(Bmp.Canvas, lCaption) + w + 8)) div 2,
                             rText.Top + (HeightOf(rText) - w) div 2,
                             ItemData.iImage, True)
          else
            ImageList_Draw(ImgList, ItemData.iImage, Bmp.Canvas.handle,
                           rText.Left + (WidthOf(rText) - (acTextWidth(Bmp.Canvas, lCaption) + w + 8)) div 2,
                           rText.Top + (HeightOf(rText) - w) div 2, ILD_NORMAL);

          inc(rText.Left, w);
        end;
        R := rText;
        if bFontChanged then begin
          Bmp.Canvas.Brush.Style := bsClear;
          acWriteText(Bmp.Canvas, PACChar(lCaption), True, rText, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
        end
        else
          acWriteTextEx(Bmp.Canvas, PACChar(lCaption), True, rText, DT_CENTER or DT_SINGLELINE or DT_VCENTER, TabIndex, State <> 0, SkinData.SkinManager);
      end;

      tpLeft: begin
        Bmp.Canvas.Brush.Style := bsClear;
        MakeVertFont(-2700);
        with acTextExtent(bmp.Canvas, lCaption) do begin
          h := cx;
          w := cy;
        end;
        if (ImgList <> 0) and (ItemData.iImage >= 0) then begin
          ImageList_GetIconSize(ImgList, iWidth, iHeight);
          if Index = ActiveTabIndex then
            OffsetRect(rText, 2, 0);

          i := rText.Bottom - (HeightOf(rText) - (iHeight + 4 + h)) div 2 - iHeight;
          if ImageList <> nil then
            if (ImageList is TsAlphaImageList) and SkinData.SkinManager.Effects.DiscoloredGlyphs then
              DrawAlphaImgList(ImageList, Bmp, rText.Left + (WidthOf(rText) - iWidth) div 2, i, ItemData.iImage, 0, ColorTone, 0, 1, False)//Reflected)
            else
              ImageList.Draw(Bmp.Canvas, rText.Left + (WidthOf(rText) - iWidth) div 2, i, ItemData.iImage, True)
          else
            ImageList_Draw(ImgList, ItemData.iImage, Bmp.Canvas.handle, rText.Left + (WidthOf(rText) - iWidth) div 2, i, ILD_TRANSPARENT);

          Bmp.Canvas.Brush.Style := bsClear;
          acTextRect(bmp.Canvas, rText, rText.Left + (WidthOf(rText) - w) div 2, i - 4, lCaption);
          InflateRect(rText, (w - WidthOf(rText)) div 2, (h - HeightOf(rText)) div 2 + 2);
          OffsetRect(rText, 0, - (4 + h) div 2);
        end
        else begin
          Bmp.Canvas.Brush.Style := bsClear;
          acTextRect(Bmp.Canvas, rText, rText.Left + (WidthOf(rText) - w) div 2, rText.Bottom - (HeightOf(rText) - h) div 2, lCaption);
          InflateRect(rText, (w - WidthOf(rText)) div 2, (h - HeightOf(rText)) div 2);
        end;
        KillVertFont;
      end;

      tpRight: begin
        Bmp.Canvas.Brush.Style := bsClear;
        MakeVertFont(-900);
        OffsetRect(rText, -2, -1);
        with acTextExtent(bmp.Canvas, lCaption) do begin
          h := cx;
          w := cy;
        end;
        if (ImgList <> 0) and (ItemData.iImage >= 0) then begin
          ImageList_GetIconSize(ImgList, iWidth, iHeight);
          if Index = ActiveTabIndex then
            OffsetRect(rText, 2, 0);

          i := rText.Top + (HeightOf(rText) - (iHeight + 4 + h)) div 2;
          if ImageList <> nil then
            if (ImageList is TsAlphaImageList) and SkinData.SkinManager.Effects.DiscoloredGlyphs then
              DrawAlphaImgList(ImageList, Bmp, rText.Left + (WidthOf(rText) - iWidth) div 2, i, ItemData.iImage, 0, ColorTone, 0, 1, False)//Reflected)
            else
              ImageList.Draw(Bmp.Canvas, rText.Left + (WidthOf(rText) - iWidth) div 2, i, ItemData.iImage, True)
          else
            ImageList_Draw(ImgList, ItemData.iImage, Bmp.Canvas.handle, rText.Left + (WidthOf(rText) - iWidth) div 2, i, ILD_TRANSPARENT);

          Bmp.Canvas.Brush.Style := bsClear;
          acTextRect(Bmp.Canvas, rText, rText.Left + (WidthOf(rText) - w) div 2 + w, i + 4 + iHeight, lCaption);
          InflateRect(rText, (w - WidthOf(rText)) div 2, (h - HeightOf(rText)) div 2 + 2);
          OffsetRect(rText, 0, + (4 + iHeight) div 2);
        end
        else begin
          Bmp.Canvas.Brush.Style := bsClear;
          acTextRect(Bmp.Canvas, rText, rText.Left + (WidthOf(rText) - w) div 2 + w, rText.Top + (HeightOf(rText) - h) div 2, lCaption);
          InflateRect(rText, (w - WidthOf(rText)) div 2, (h - HeightOf(rText)) div 2 + 2);
        end;
        KillVertFont;
      end;
    end;
    SelectObject(Bmp.Canvas.Handle, cFont);
  end;
end;


procedure TacTabControlWnd.DrawSkinTab(Index, State: integer; DC: hdc);
var
  aRect: TRect;
  TempBmp: TBitmap;
begin
  if Index >= 0 then begin
    aRect := SkinTabRect(Index, State = 2);
    TempBmp := CreateBmp32(aRect);
    DrawSkinTab(Index, State, TempBmp, Point(-aRect.Left, -aRect.Top));
    BitBlt(DC, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(TempBmp);
  end;
end;


function TacTabControlWnd.TabRect(const Index: integer): TRect;
begin
  TabCtrl_GetItemRect(CtrlHandle, Index, Result);
end;


function EnumPages(Child: HWND; Data: LParam): BOOL; stdcall;
type
  PHWND = ^HWND;
var
  ParentWnd: hwnd;
  SkinManager: Longint;
  sp: TacSkinParams;
begin
  ParentWnd := PHWND(Data)^;
  if GetParent(Child) = ParentWnd then begin
    SkinManager := SendMessage(ParentWnd, SM_ALPHACMD, AC_GETSERVICEINT_HI, 0);
    if (SkinManager <> 0) and not GetBoolMsg(Child, AC_CTRLHANDLED) then begin
      if ServWndList = nil then
        ServWndList := TList.Create;

      sp.SkinSection := s_Transparent; {Fully transparent}
      sp.Control := nil;
      ServWndList.Add(TacPageWnd.Create(Child, nil, TsSkinManager(SkinManager), sp));
    end;
  end;
  Result := True;
end;


function TacTabControlWnd.ClientRect: TRect;
begin
  Result := MkRect(WndSize);
  ProcessMessage(TCM_ADJUSTRECT, 0, LPARAM(@Result));
  Inc(Result.Top, 2);
end;


function TacTabControlWnd.TabsRect: TRect;
var
  r: TRect;
begin
  Result := MkRect(WndSize);
  if TabCount > 0 then begin
    r := ClientRect;
    case TabPosition of
      tpTop:    Result.Bottom := R.Top    - TopOffset;
      tpBottom: Result.Top    := R.Bottom + BottomOffset;
      tpLeft:   Result.Right  := R.Left   - LeftOffset;
      tpRight:  Result.Left   := R.Right  + RightOffset;
    end;
  end;
end;


function TacTabControlWnd.TabRow(TabIndex: integer): integer;
var
  h, w, rCount: integer;
  R, tR: TRect;
begin
  rCount := TabCtrl_GetRowCount(CtrlHandle);
  if rCount > 1 then begin
    R := TabRect(TabIndex);
    tR := TabsRect;
    w := WidthOf(R);
    h := HeightOf(R);
    case TabPosition of
      tpTop:    Result := (R.Bottom + h div 2) div h;
      tpLeft:   Result := (R.Right  + w div 2) div w;
      tpRight:  Result := rCount - (R.Right - tR.Left + w div 2) div w + 1
      else      Result := rCount - (R.Bottom - tR.Top + h div 2) div h + 1;
    end;
  end
  else
    Result := 1;
end;


function TacTabControlWnd.TabPosition: TTabPosition;
var
  Style: ACNativeInt;
begin
  Style := GetWindowLong(CtrlHandle, GWL_STYLE);
  if Style and TCS_VERTICAL <> 0 then
    if Style and TCS_RIGHT <> 0 then
      Result := tpRight
    else
      Result := tpLeft
  else
    if Style and TCS_BOTTOM <> 0 then
      Result := tpBottom
    else
      Result := tpTop;
end;


function TacTabControlWnd.Style: TTabStyle;
var
  Style: ACNativeInt;
begin
  Style := GetWindowLong(CtrlHandle, GWL_STYLE);
  if Style and TCS_FLATBUTTONS <> 0 then
    Result := tsFlatButtons
  else
    if Style and TCS_BUTTONS <> 0 then
      Result := tsButtons
    else
      Result := tsTabs
end;


procedure TacTabControlWnd.CheckUpDown;
var
  Wnd: HWND;
  sp: TacSkinParams;
begin
  if SkinData.Skinned then begin
    Wnd := FindWindowEx(CtrlHandle, 0, 'msctls_updown32', nil);
    if Wnd <> 0 then begin
      if BtnSW <> nil then
        FreeAndNil(BtnSW);

      sp.SkinSection := s_UpDown;
      sp.Control := nil;
      BtnSW := TacSpinWnd.Create(Wnd, nil, SkinData.SkinManager, sp);
    end
    else
      if BtnSW <> nil then
        FreeAndNil(BtnSW);
  end;
end;


destructor TacTabControlWnd.Destroy;
begin
  inherited;
  if BtnSW <> nil then
    FreeAndNil(BtnSW);
end;


procedure TacTabControlWnd.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_PageControl;

  inherited;
end;


procedure TacPageWnd.acWndProc(var Message: TMessage);
var
  PS: TPaintStruct;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if (SkinData <> nil) and SkinData.Skinned then
    case Message.Msg of
      SM_ALPHACMD:
        case Message.WParamHi of
          AC_CTRLHANDLED: begin
            Message.Result := 1;
            Exit;
          end;

          AC_REMOVESKIN: begin
            if Message.LParam = LPARAM(SkinData.SkinManager) then begin
              CommonWndProc(Message, SkinData);
              InvalidateRect(CtrlHandle, nil, True);
            end;
            AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);
          end;

          AC_REFRESH: begin
            if Message.LParam = LPARAM(SkinData.SkinManager) then begin
              CommonWndProc(Message, SkinData);
              InvalidateRect(CtrlHandle, nil, True);
            end;
            AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);
            Exit;
          end;

          AC_SETNEWSKIN: begin
            if Message.LParam = LPARAM(SkinData.SkinManager) then
              CommonMessage(Message, SkinData);
              
            AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);
            Exit;
          end;

          AC_PREPARING: begin
            Message.Result := LRESULT(SkinData.FUpdating);
            Exit;
          end;

          AC_ENDPARENTUPDATE:
            if SkinData.Updating then begin
              SkinData.Updating := False;
              InvalidateRect(CtrlHandle, nil, True);
              Exit;
            end;

          AC_GETBG:
            with PacBGInfo(Message.LParam)^ do begin
              GetBGInfo(PacBGInfo(Message.LParam), GetParent(CtrlHandle), PleaseDraw);
              if Page <> nil then begin
                Offset.X := Offset.X + Page.Left;
                Offset.Y := Offset.Y + Page.Top;
              end
              else begin
                Offset.X := Offset.X + WndPos.X;
                Offset.Y := Offset.Y + WndPos.Y;
              end;
              Exit;
            end;
        end;

      WM_PRINT: begin
        AC_WMEraseBKGnd(TWMPaint(Message));
        SendMessage(CtrlHandle, WM_PAINT, Message.WParam, Message.LParam);
        Exit;
      end;

      WM_NCPAINT:
        Exit;

      WM_ERASEBKGND:
        if IsWindowVisible(CtrlHandle) then begin
          AC_WMEraseBKGnd(TWMPaint(Message));
          Message.Result := ERASE_OK;
          Exit;
        end;

      WM_PAINT:
        if IsWindowVisible(CtrlHandle) then begin
          BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
          AC_WMEraseBKGnd(TWMPaint(Message));
          EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
          Exit;
        end;
    end;

  inherited;
  case Message.Msg of
    WM_PARENTNOTIFY:
      if Message.WParamLo = WM_CREATE then
        SendControlLoaded(CtrlHandle);
  end
end;


procedure TacPageWnd.AC_WMEraseBKGnd(var Message: TWMPaint);
const
  cWidth = 3;
var
  ParentBG: TacBGInfo;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  ParentBG.Bmp := nil;
  ParentBG.Offset := MkPoint;
  GetBGInfo(@ParentBG, ParentWnd, False);
  if ParentBG.BgType = btCache then begin
    if ParentBG.Bmp.Empty then
      SendMessage(ParentWnd, WM_PAINT, Longint(ParentBG.Bmp.Canvas.Handle), 0); // Prepare image

    if not ParentBG.Bmp.Empty then // Image is ready
      BitBlt(Message.DC, 0, 0, WndSize.cx, WndSize.cy, ParentBG.Bmp.Canvas.Handle, WndPos.X + ParentBG.Offset.X, WndPos.Y + ParentBG.Offset.Y, SRCCOPY)
    else
      Exit;
  end
  else
    if (Page <> nil) and (Page.PageControl <> nil) then begin
      FillDC(Message.DC, MkRect(WndSize), ParentBG.Color);
      if (SendMessage(Page.PageControl.Handle, TCM_GETITEMCOUNT, 0, 0) > 0) and (ParentBG.Bmp <> nil) then
        case TabPosition of
          tpTop:    BitBlt(Message.DC, 0, 0, WndSize.cx, cWidth, ParentBG.Bmp.Canvas.Handle, WndPos.X + ParentBG.Offset.X, WndPos.Y + ParentBG.Offset.Y, SRCCOPY);
          tpLeft:   BitBlt(Message.DC, 0, 0, 3, WndSize.cy, ParentBG.Bmp.Canvas.Handle, WndPos.X, WndPos.Y, SRCCOPY);
          tpBottom: BitBlt(Message.DC, 0, WndSize.cy - cWidth, WndSize.cx, cWidth, ParentBG.Bmp.Canvas.Handle, WndPos.X, WndPos.Y + WndSize.cy - cWidth, SRCCOPY);
          tpRight:  BitBlt(Message.DC, WndSize.cx - cWidth, 0, cWidth, WndSize.cy, ParentBG.Bmp.Canvas.Handle, WndPos.X + WndSize.cx - cWidth, WndPos.Y, SRCCOPY);
        end;
    end;

  if Page <> nil then begin
    sVCLUtils.PaintControls(Message.DC, Page, True, MkPoint, CtrlHandle);
    SetParentUpdated(Page);
  end;
  Message.Result := 1;
end;


function TacPageWnd.TabPosition: TTabPosition;
var
  Style: ACNativeInt;
begin
  Style := GetWindowLong(GetParent(CtrlHandle), GWL_STYLE);
  if Style and TCS_VERTICAL <> 0 then
    if Style and TCS_RIGHT <> 0 then
      Result := tpRight
    else
      Result := tpLeft
  else
    if Style and TCS_BOTTOM <> 0 then
      Result := tpBottom
    else
      Result := tpTop;
end;


procedure TacPageWnd.AfterCreation;
begin
  Page := nil;
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  inherited;
end;


procedure TacPageControlWnd.acWndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if (SkinData <> nil) and SkinData.Skinned then
    case Message.Msg of
      WM_NCPAINT: begin
        InitPages;
        Exit;
      end;

      WM_ERASEBKGND:
        if IsWindowVisible(CtrlHandle) then begin
          if not InAnimationProcess then
            AC_WMPaint(TWMPaint(Message));

          Message.Result := ERASE_OK;
          Exit;
        end;

      TCM_SETCURSEL:
        if SkinData.FOwnerControl <> nil then begin
          InitPages;
          AddToAdapter(TWinControl(SkinData.FOwnerControl));
        end;

      WM_PRINT: begin
        CheckUpDown;
        InitPages;
        SkinData.Updating := False;
        AC_WMPaint(TWMPaint(Message));
        Exit;
      end;

      WM_PARENTNOTIFY:
        case Message.WParamLo of
          WM_CREATE, WM_DESTROY: InitPages;
        end;
    end;

  inherited;
end;


procedure TacPageControlWnd.AfterCreation;
begin
  InitPages;
  inherited;
end;


function TacPageControlWnd.ClientRect: TRect;
begin
  Result := MkRect(WndSize);
  ProcessMessage(TCM_ADJUSTRECT, 0, LPARAM(@Result));
  Inc(Result.Top, 2);
end;


procedure TacPageControlWnd.InitPages;
var
  i: integer;
  pw: TacPageWnd;
  ChildWnd: HWND;
  sp: TacSkinParams;
begin
  if SkinData.FOwnerControl is TPageControl then
    with TPageControl(SkinData.FOwnerControl) do
      for i := 0 to PageCount - 1 do begin
        if Pages[i].HandleAllocated then
          if not WndIsSkinned(Pages[i].Handle) then begin
            if ServWndList = nil then
              ServWndList := TList.Create;

            sp.SkinSection := s_Transparent;
            sp.Control := nil;
            pw := TacPageWnd.Create(Pages[i].Handle, nil, TsSkinManager(SkinManager), sp);
            pw.Page := Pages[i];
            pw.SkinData.FOwnerControl := Pages[i];
            pw.SkinData.FOwnerObject := Pages[i];
            ServWndList.Add(pw);
          end;
      end
  else begin
    ChildWnd := CtrlHandle;
    EnumChildWindows(CtrlHandle, @EnumPages, LPARAM(@ChildWnd));
  end;
end;


function TacPageControlWnd.PageRect: TRect;
begin
  Result := MkRect(WndSize);
  if TabCount > 0 then
    case TabPosition of
      tpTop:    Result.Top    := ClientRect.Top    - TopOffset;
      tpBottom: Result.Bottom := ClientRect.Bottom + BottomOffset;
      tpLeft:   Result.Left   := ClientRect.Left   - LeftOffset;
      tpRight:  Result.Right  := ClientRect.Right  + RightOffset;
    end;
end;


procedure TacToolBarVCLWnd.acWndProc(var Message: TMessage);
var
  OldIndex, i, h, w: integer;
  PS: TPaintStruct;
  RC: TRect;
begin
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then
          DroppedButton := nil;

{$IFNDEF FPC}
      AC_SETNEWSKIN: begin
        ToolBar.OnAdvancedCustomDraw := OurAdvancedCustomDraw;
        ToolBar.OnAdvancedCustomDrawButton := OurAdvancedCustomDrawButton;
      end;
{$ENDIF}

      AC_REMOVESKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
{$IFNDEF FPC}
          ToolBar.OnAdvancedCustomDraw := nil;
          ToolBar.OnAdvancedCustomDrawButton := nil;
{$ENDIF}
          DroppedButton := nil;
        end;

      AC_PREPARECACHE:
        Exit;

      AC_GETBG:
        if SkinData <> nil then begin
          InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
          InitBGInfo(SkinData, PacBGInfo(Message.LParam), 0, CtrlHandle);
          PacBGInfo(Message.LParam).Offset.X := PacBGInfo(Message.LParam).Offset.X + DisplayRect.Left;
          PacBGInfo(Message.LParam).Offset.Y := PacBGInfo(Message.LParam).Offset.Y + DisplayRect.Top;
          Exit;
        end;

      else
        if CommonMessage(Message, SkinData) then
          Exit;
    end;

  if (SkinData <> nil) and SkinData.Skinned then
    case Message.Msg of
      WM_ERASEBKGND: begin
        Message.Result := ERASE_OK;
        Exit;
      end;

      WM_PAINT:
        if InUpdating(SkinData) then begin
          BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
          EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
          Exit;
        end;

      WM_NCPAINT: begin
        if not InAnimationProcess then
          WMNCPaint;

        Exit;
      end;

      WM_PRINT: begin
        RC := ACClientRect(ToolBar.Handle);
        w := WidthOf(Rc);
        h := HeightOf(Rc);
        SkinData.Updating := False;
        if SkinData.BGChanged then
          PrepareCache;

        with TWMPaint(Message) do begin
          BitBlt(DC, 0, 0, ToolBar.Width, Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
          BitBlt(DC, 0, Rc.Top, Rc.Left, h, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Top, SRCCOPY);
          BitBlt(DC, 0, Rc.Bottom, ToolBar.Width, ToolBar.Height - h - Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Bottom, SRCCOPY);
          BitBlt(DC, Rc.Right, Rc.Top, ToolBar.Width - Rc.Left - w, h, SkinData.FCacheBmp.Canvas.Handle, Rc.Right, Rc.Top, SRCCOPY);
          MoveWindowOrg(DC, Rc.Left, Rc.Top);
          IntersectClipRect(DC, 0, 0, w, h);
          SendMessage(CtrlHandle, WM_PAINT, Message.WParam, 0);
        end;
        Exit;
      end;

      CN_NOTIFY:
        with TWMNotify(Message) do
          case TWMNotify(Message).NMHdr^.code of
            TBN_DROPDOWN:
              with PNMToolBar(NMHdr)^ do
                if ToolBar.Perform(TB_GETBUTTON, iItem, LPARAM(@tbButton)) <> 0 then begin
                  DroppedButton := TToolButton(tbButton.dwData);
                  DroppedButton.Repaint;
                end;

            TBN_DELETINGBUTTON:
              if HotButtonIndex >= ToolBar.ButtonCount then
                HotButtonIndex := -1;
          end;
    end;

  if not CommonWndProc(Message, SkinData) then begin
    inherited;
    if (SkinData <> nil) and SkinData.Skinned then
      case Message.Msg of
        CN_DROPDOWNCLOSED:
          if DroppedButton <> nil then begin
            HotButtonIndex := -1;
            i := DroppedButton.Index;
            DroppedButton := nil;
{$IFNDEF FPC}
            RepaintButton(i);
{$ENDIF}
          end;

        WM_SIZE: begin
          if not SkinData.Updating then
            RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE);

          Exit;
        end;

        CM_MOUSELEAVE:
          if not ToolBar.Flat and not (csDesigning in ToolBar.ComponentState) then begin
            OldIndex := HotButtonIndex;
            HotButtonIndex := -1;
{$IFNDEF FPC}
            if (OldIndex >= 0) and not ToolBar.Buttons[OldIndex].Down then
              RepaintButton(OldIndex);
{$ENDIF}

            HotButtonIndex := -1;
          end;

        WM_MOUSEMOVE:
          if not ToolBar.Flat and not (csDesigning in ToolBar.ComponentState) then
            with TWMMouse(Message) do begin
              i := IndexByMouse(Point(TWMMouse(Message).XPos, TWMMouse(Message).YPos));
              if i <> HotButtonIndex then begin
                if (i >= 0) and not ToolBar.Buttons[i].Enabled then
                  Exit;

                OldIndex := HotButtonIndex;
                HotButtonIndex := i;
{$IFNDEF FPC}
                if (OldIndex >= 0) and not ToolBar.Buttons[OldIndex].Down then
                  RepaintButton(OldIndex);

                if (HotButtonIndex >= 0) and not ToolBar.Buttons[HotButtonIndex].Down then
                  RepaintButton(HotButtonIndex);
{$ENDIF}
              end;
            end;
      end;
  end;
end;


procedure CopyCache(Control: TWinControl; SkinData: TsCommonData; SrcRect, DstRect: TRect; DstDC: HDC);
var
  i: integer;
  SaveIndex: HDC;
  Designing: boolean;
begin
  with Control do begin
    sAlphaGraph.UpdateCorners(SkinData, 0);
    SaveIndex := SaveDC(DstDC);
    IntersectClipRect(DstDC, DstRect.Left, DstRect.Top, DstRect.Right, DstRect.Bottom);
    Designing := csDesigning in ComponentState;
    try
      for i := 0 to Control.ControlCount - 1 do begin
        if (Controls[i] is TToolButton) and (csDesigning in ComponentState) then
          Continue;

        if (Controls[i] is TGraphicControl) and StdTransparency then
          Continue;

        if not Controls[i].Visible or not RectIsVisible(DstRect, Controls[i].BoundsRect) then
          Continue;

        if (csOpaque in Controls[i].ControlStyle) or (Controls[i] is TGraphicControl) or Designing then
          ExcludeClipRect(DstDC, Controls[i].Left, Controls[i].Top,
                          Controls[i].Left + Controls[i].Width, Controls[i].Top + Controls[i].Height);
      end;
      BitBlt(DstDC, DstRect.Left, DstRect.Top, WidthOf(DstRect), HeightOf(DstRect), SkinData.FCacheBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top, SRCCOPY);
    finally
      RestoreDC(DstDC, SaveIndex);
    end;
  end;
end;


procedure TacToolBarVCLWnd.AfterCreation;
begin
  HotButtonIndex := -1;
  if SkinData.FOwnerControl is TToolBar then begin
    ToolBar := TToolBar(SkinData.FOwnerControl);
{$IFNDEF FPC}
    ToolBar.OnAdvancedCustomDraw := OurAdvancedCustomDraw;
    ToolBar.OnAdvancedCustomDrawButton := OurAdvancedCustomDrawButton;
{$ENDIF}
    if SkinData.SkinSection = '' then
      SkinData.SkinSection := s_ToolBar;
  end
  else
    ToolBar := nil;

  inherited;
end;


function TacToolBarVCLWnd.DisplayRect: TRect;
var
  RW: TRect;
begin
  GetClientRect(CtrlHandle, Result);
  if (WidthOf(Result) <> WndSize.cx) or (HeightOf(Result) <> WndSize.cy) then begin
    GetWindowRect(CtrlHandle, RW);
    MapWindowPoints(0, CtrlHandle, RW, 2);
    OffsetRect(Result, -RW.Left, -RW.Top);
  end;
end;


function TacToolBarVCLWnd.GetButtonRect(Index: integer): TRect;
begin
  ToolBar.Perform(TB_GETITEMRECT, Index, LPARAM(@Result))
end;


function TacToolBarVCLWnd.IndexByMouse(MousePos: TPoint): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to ToolBar.ButtonCount - 1 do
    if PtInRect(GetButtonRect(i), MousePos) then begin
      if (TControl(ToolBar.Buttons[I]) is TToolButton) and (ToolBar.Buttons[i].Style in [tbsButton, tbsCheck, tbsDropDown]) then
        Result := i;

      Exit;
    end;
end;


procedure TacToolBarVCLWnd.OurAdvancedCustomDraw(Sender: TToolBar; const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  RC, RW: TRect;
begin
  if SkinData.Skinned(True) then begin
    if not InUpdating(SkinData) then
      if not (Stage in [cdPrePaint]) then
        DefaultDraw := False
      else begin
        SkinData.FCacheBMP.Canvas.Font.Assign(Sender.Font);
        if SkinData.BGChanged then
          PrepareCache;

        Windows.GetClientRect(Sender.Handle, RC);
        GetWindowRect(Sender.Handle, RW);
        MapWindowPoints(0, Sender.Handle, RW, 2);
        OffsetRect(RC, -RW.Left, -RW.Top);

        CopyCache(Sender, SkinData, RC, ARect, Sender.Canvas.Handle);
        sVCLUtils.PaintControls(Sender.Canvas.Handle, Sender, True, MkPoint);
        SetParentUpdated(Sender);
        if (RC.Left > 0) or (RC.Top > 0) or (RC.Right <> Sender.Width) or (RC.Bottom <> Sender.Height) then
          SendMessage(Sender.Handle, WM_NCPAINT, 0, 0);
      end;
  end
  else
    DefaultDraw := True;
end;


{$IFNDEF FPC}
procedure TacToolBarVCLWnd.OurAdvancedCustomDrawButton(Sender: TToolBar; Button: TToolButton; State: TCustomDrawState; Stage: TCustomDrawStage; var Flags: TTBCustomDrawFlags; var DefaultDraw: Boolean);
var
  R, iR: TRect;
  ci: TCacheInfo;
  BtnBmp: TBitmap;
  bWidth, bHeight, Mode, SkinIndex, BorderIndex: integer;

  function AddedWidth: integer;
  begin
    if Button.Style = tbsDropDown then
      Result := GetSystemMetrics(SM_CXVSCROLL) - 2
    else
      Result := 0
  end;

  function IntButtonWidth: integer;
  begin
    Result := Button.Width - AddedWidth;
  end;

  procedure DrawBtnCaption;
  var
    cRect: TRect;

    function CaptionRect: TRect;
    var
      l, t, r, b, dh: integer;
    begin
      if not ToolBar.List then begin
        l := (IntButtonWidth - SkinData.FCacheBMP.Canvas.TextWidth(Button.Caption)) div 2;
        if Assigned(ToolBar.Images) then begin
          dh := (Button.Height - ToolBar.Images.Height - SkinData.FCacheBMP.Canvas.TextHeight('A') - 3) div 2;
          t := dh + ToolBar.Images.Height + 3;
        end
        else begin
          dh := (Button.Height - SkinData.FCacheBMP.Canvas.TextHeight('A')) div 2;
          t := dh;
        end;
        r := IntButtonWidth - l;
        b := Button.Height - dh;
        Result := Rect(l - 1, t, r + 2, b);
      end
      else begin
        if Assigned(ToolBar.Images) and (Button.ImageIndex >= 0) then
          Result.Left := 6 + ToolBar.Images.Width
        else
          Result.Left := 1;

        Result.Right := IntButtonWidth - 2;
        Result.Top := 2;
        Result.Bottom := Button.Height - 2;
      end;
      if Mode = 2 then
        if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
          OffsetRect(Result, 1, 1);
    end;

  begin
    if ToolBar.ShowCaptions then begin
      cRect := CaptionRect;
      acWriteTextEx(BtnBMP.Canvas, PacChar(Button.Caption), True, cRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE, GetFontIndex(Button, SkinIndex, SkinData.SkinManager), Mode > 0);
    end;
  end;

  procedure DrawBtnGlyph;
  begin
    if Assigned(ToolBar.Images) and (Button.ImageIndex >= 0) and (Button.ImageIndex < GetImageCount(ToolBar.Images)) then
      CopyToolBtnGlyph(ToolBar, Button, State, Stage, Flags, BtnBmp);
  end;

  procedure DrawArrow;
  var
    Mode, x, y: integer;
    gR: TRect;
  begin
    with SkinData.SkinManager, ConstData.ScrollBtns[asBottom] do
      if GlyphIndex >= 0 then begin
        if (DroppedButton = Button) and Assigned(Button.DropDownMenu) or Button.Down then
          Mode := 2
        else
          Mode := integer(cdsHot in State);

        R.Left := IntButtonWidth;
        R.Right := Button.Width;
        BorderIndex := GetMaskIndex(SkinIndex, s_BordersMask);
        if IsValidImgIndex(BorderIndex) then
          DrawSkinRect(BtnBmp, R, ci, ma[BorderIndex], Mode, True);

        if (GlyphIndex >= 0) and (GlyphIndex < High(SkinData.SkinManager.ma)) then begin
          x := IntButtonWidth + (AddedWidth - 3 - ma[GlyphIndex].Width) div 2 + 2;
          y := (ToolBar.ButtonHeight - ma[GlyphIndex].Height) div 2;
          DrawSkinGlyph(BtnBmp, Point(x, y), Mode, 1, ma[GlyphIndex], MakeCacheInfo(BtnBmp));
        end
        else begin
          gR.Left := IntButtonWidth + (AddedWidth - 3 - ma[GlyphIndex].Width) div 2 + 2;
          gR.Top := (ToolBar.ButtonHeight - ma[GlyphIndex].Height) div 2;
          gR.Right := gR.Left + 6;
          gR.Bottom := gR.Top + 3;
          if Mode = 2 then
            if ButtonsOptions.ShiftContentOnClick then
              OffsetRect(R, 1, 1);

          DrawColorArrow(BtnBmp, gd[SkinData.SkinIndex].Props[math.min(integer(Mode > 0), ac_MaxPropsIndex)].FontColor.Color, gR, asBottom)
        end;
      end;
  end;

begin
  if SkinData.Skinned then begin
    DefaultDraw := False;
    if not (Stage in [cdPrePaint]) then
      DefaultDraw := False
    else begin
      if not ToolBar.Flat and not (csDesigning in ToolBar.ComponentState) and (HotButtonIndex = Button.Index) then
        State := State + [cdsHot];

      Flags := Flags + [tbNoEtchedEffect, tbNoEdges];
      iR := GetButtonRect(Button.Index);
      bWidth := WidthOf(iR, True);
      bHeight := HeightOf(iR, True);
      BtnBmp := CreateBmp32(bWidth, bHeight);
      if (bWidth <> 0) and (bHeight <> 0) then begin
        BtnBmp.Canvas.Font.Assign(ToolBar.Font);
        if not Button.Marked and not Button.Indeterminate and ((State = []) or (State = [cdsDisabled])) then
          Mode := 0
        else
          if (cdsSelected in State) or (cdsChecked in State) or Button.Marked or Button.Indeterminate then
            Mode := 2
          else
            Mode := 1;

        SkinIndex := SkinData.SkinManager.ConstData.Sections[ssToolButton];// .GetSkinIndex(s_TOOLBUTTON);
        ci := MakeCacheInfo(SkinData.FCacheBmp,
                            ToolBar.BorderWidth * 2 + integer(ebLeft in ToolBar.EdgeBorders) * (integer(ToolBar.EdgeInner <> esNone) + integer(ToolBar.EdgeOuter <> esNone)),
                            ToolBar.BorderWidth * 2 + integer(ebTop in ToolBar.EdgeBorders ) * (integer(ToolBar.EdgeInner <> esNone) + integer(ToolBar.EdgeOuter <> esNone)));
        R := MkRect(bWidth, Button.Height);
        OffsetRect(R, ToolBar.ClientRect.Left, ToolBar.ClientRect.Top);

        PaintItemBg(SkinIndex, ci, Mode, R, MkPoint(Button), BtnBmp, SkinData.SkinManager);
        R.Right := bWidth - AddedWidth;

        ci.X := ci.X + Button.Left;
        ci.Y := ci.Y + Button.Top;
        BorderIndex := SkinData.SkinManager.GetMaskIndex(SkinIndex, s_BordersMask);
        if BorderIndex >= 0 then
          DrawSkinRect(BtnBmp, R, ci, SkinData.SkinManager.ma[BorderIndex], Mode, True);

        DrawBtnCaption;
        DrawBtnGlyph;
        if Button.Style = tbsDropDown then
          DrawArrow;

        if not Button.Enabled or Button.Indeterminate then
          BmpDisabledKind(BtnBmp, [dkBlended], ToolBar.Parent, CI, MkPoint);

        BitBlt(ToolBar.Canvas.Handle, Button.Left, Button.Top, bWidth, bHeight, BtnBmp.Canvas.Handle, 0, 0, SRCCOPY);
        FreeAndNil(BtnBmp);
      end;
    end;
  end
  else begin
    DefaultDraw := True;
    inherited;
  end;
end;
{$ENDIF}


procedure TacToolBarVCLWnd.PrepareCache;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  InitCacheBmp(SkinData);
  PaintItem(SkinData, GetParentCache(SkinData), False, 0, MkRect(SkinData.FCacheBmp), Point(WndPos.X, WndPos.Y), SkinData.FCacheBmp, False);
  SkinData.BGChanged := False;
end;


{$IFNDEF FPC}
procedure TacToolBarVCLWnd.RepaintButton(Index: integer);
var
  Def: boolean;
  RC, RW: TRect;
  DC, SavedDC: HDC;
  Flags: TTBCustomDrawFlags;
begin
  if (Index >= 0) and ToolBar.Buttons[Index].Visible then begin
    Flags := [tbNoEtchedEffect, tbNoEdges];
    Def := False;
    DC := GetWindowDC(ToolBar.Handle);
    SavedDC := SaveDC(DC);
    try
      Windows.GetClientRect(ToolBar.Handle, RC);
      GetWindowRect(ToolBar.Handle, RW);
      MapWindowPoints(0, ToolBar.Handle, RW, 2);
      OffsetRect(RC, -RW.Left, -RW.Top);
      MoveWindowOrg(DC, -RW.Left, -RW.Top);

      ToolBar.Canvas.Handle := DC;
      OurAdvancedCustomDrawButton(ToolBar, ToolBar.Buttons[Index], [], cdPrePaint, Flags, Def)
    finally
      ToolBar.Canvas.Handle := 0;
      RestoreDC(DC, SavedDC);
      ReleaseDC(ToolBar.Handle, DC);
    end;
  end;
end;
{$ENDIF}


procedure TacToolBarVCLWnd.WMNCPaint(const aDC: hdc);
var
  DC: hdc;
  w, h: integer;
  RC, RW: TRect;
begin
  if not InUpdating(SkinData, False) then begin
    Windows.GetClientRect(ToolBar.Handle, RC);
    if (WidthOf(RC) <> ToolBar.Width) or (HeightOf(RC) <> ToolBar.Height) then begin
      GetWindowRect(ToolBar.Handle, RW);
      MapWindowPoints(0, ToolBar.Handle, RW, 2);
      OffsetRect(RC, -RW.Left, -RW.Top);
      if aDC = 0 then
        DC := GetWindowDC(CtrlHandle)
      else
        DC := aDC;

      if SkinData.BGChanged then
        PrepareCache;

      ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
      { Draw borders in non-client area }
      w := WidthOf(Rc);
      h := HeightOf(Rc);
      BitBlt(DC, 0, 0, ToolBar.Width, Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      BitBlt(DC, 0, Rc.Top, Rc.Left, h, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Top, SRCCOPY);
      BitBlt(DC, 0, Rc.Bottom, ToolBar.Width, ToolBar.Height - h - Rc.Top, SkinData.FCacheBmp.Canvas.Handle, 0, Rc.Bottom, SRCCOPY);
      BitBlt(DC, Rc.Right, Rc.Top, ToolBar.Width - Rc.Left - w, h, SkinData.FCacheBmp.Canvas.Handle, Rc.Right, Rc.Top, SRCCOPY);
      IntersectClipRect(DC, RW.Left, RW.Top, RW.Right, RW.Bottom);
      if aDC = 0 then
        ReleaseDC(CtrlHandle, DC);
    end;
  end;
end;


procedure TacStatusBarWnd.acWndProc(var Message: TMessage);
var
  PS: TPaintStruct;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if (SkinData <> nil) and SkinData.Skinned then
    case Message.Msg of
      WM_ERASEBKGND: begin
        WMPaint(hdc(Message.WParam));
        Message.Result := ERASE_OK;
        Exit;
      end;

      WM_NCPAINT: begin
        if not InAnimationProcess then
          WMNCPaint;

        Exit;
      end;

      WM_PAINT: begin
        InvalidateRect(CtrlHandle, nil, True);
        BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
        EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
        Exit;
      end;

      WM_PRINT: begin
        WMPaint(hdc(Message.WParam));
        Exit;
      end;
    end;

  inherited;
  if (Message.Msg = WM_SIZE) and (SkinData <> nil) and SkinData.Skinned then
    RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_ERASE);
end;


procedure TacStatusBarWnd.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_StatusBar;

  if SkinData.FOwnerControl is TStatusBar then
    StatusBar := TStatusBar(SkinData.FOwnerControl)
  else
    StatusBar := nil;

  inherited;
end;

procedure TacStatusBarWnd.DoDrawText(const Text: acString; var Rect: TRect; const Flags: Integer);
begin
  if Assigned(StatusBar) then
    SkinData.FCacheBmp.Canvas.Font.Assign(StatusBar.Font);

  acWriteTextEx(SkinData.FCacheBMP.Canvas, PacChar(Text), True, Rect, Flags or DT_SINGLELINE or DT_VCENTER, SkinData, False);
end;


procedure TacStatusBarWnd.DrawPanel(const Index: integer; const Rect: TRect);
var
  aRect: TRect;
begin
  aRect := Rect;
  InflateRect(aRect, -1, -1);
  InternalDrawPanel(Index, aRect);
end;


procedure TacStatusBarWnd.InternalDrawPanel(const Index: integer; const Rect: TRect);
var
  s: acString;
  SavedDC: hdc;
  aRect: TRect;
  CI: TCacheInfo;
  TempBmp: TBitmap;
  si, mi, SkinIndex: integer;
begin
  if Assigned(SkinData.SkinManager) then
    with SkinData.SkinManager do begin
      aRect := Rect;
      InflateRect(aRect, -1, -1);
      if IsValidSkinIndex(SkinData.SkinIndex) then begin
        SkinIndex := GetMaskIndex(SkinData.SkinIndex, s_StatusPanelMask);
        if IsValidImgIndex(SkinIndex) then
          if SimplePanel then
            DrawSkinRect(SkinData.FCacheBmp, MkRect(WndSize), EmptyCI, ma[SkinIndex], 0, True)
          else
            DrawSkinRect(SkinData.FCacheBmp, Rect, EmptyCI, ma[SkinIndex], 0, True)
        else
          if not (SimplePanel or (Index = PartsCount - 1)) then begin
            si := ConstData.Sections[ssDivider];
            if IsValidskinIndex(si) then begin
              mi := GetMaskIndex(si, s_BordersMask);
              if IsValidImgIndex(mi) then begin
                TempBmp := CreateBmp32(max(2, (ma[mi].WL + ma[mi].WR)), WndSize.cy - 2);
                BitBlt(TempBmp.Canvas.Handle, 0, 0, TempBmp.Width, TempBmp.Height, SkinData.FCacheBmp.Canvas.Handle, Rect.Right - TempBmp.Width, Rect.Top, SRCCOPY);
                CI := MakeCacheInfo(SkinData.FCacheBmp);
                PaintItem(si, CI, True, 0, MkRect(TempBmp.Width, TempBmp.Height), Point(Rect.Right - TempBmp.Width, 1), TempBmp, SkinData.SkinManager);
                BitBlt(SkinData.FCacheBmp.Canvas.Handle, Rect.Right - TempBmp.Width, 1, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
                FreeAndNil(TempBmp);
              end;
            end;
          end;
      end;
      if (StatusBar <> nil) and IsValidIndex(Index, StatusBar.Panels.Count) and (StatusBar.Panels[Index].Style = psOwnerDraw) and Assigned(StatusBar.OnDrawPanel) then begin
        SavedDC := StatusBar.Canvas.Handle;
        StatusBar.Canvas.Handle := SkinData.FCacheBmp.Canvas.Handle;
        StatusBar.OnDrawPanel(StatusBar, StatusBar.Panels[Index], Rect);
        StatusBar.Canvas.Handle := SavedDC;
      end
      else begin
        dec(aRect.Bottom, 1);
        inc(aRect.Left, 2);
        dec(aRect.Right, 4);
        s := PartText(Index);
        s := CutText(SkinData.FCacheBmp.Canvas, s, WidthOf(aRect));
        if StatusBar <> nil then
          with StatusBar do
            if not SimplePanel and IsValidIndex(Index, Panels.Count) then
              DoDrawText(s, aRect, GetStringFlags(StatusBar, Panels[Index].Alignment))
            else
              DoDrawText(s, aRect, GetStringFlags(StatusBar, taLeftJustify))
      end;
    end;
end;


procedure TacStatusBarWnd.PaintGrip;
var
  GripPos: TPoint;
begin
  if (SkinData.SkinManager <> nil) and (SkinData.FOwnerControl is TStatusBar) then
    with SkinData.SkinManager, TStatusBar(SkinData.FOwnerControl), ConstData do
      if SizeGrip and IsValidImgIndex(GripRightBottom) then begin
        GripPos := point(SkinData.FCacheBmp.Width  - ma[GripRightBottom].Width - BorderWidth,
                         SkinData.FCacheBmp.Height - ma[GripRightBottom].Height - BorderWidth);
        DrawSkinGlyph(SkinData.FCacheBmp, GripPos, 0, 1, ma[GripRightBottom], MakeCacheInfo(SkinData.FCacheBmp));
      end;
end;


procedure TacStatusBarWnd.PaintPanels;
var
  i: integer;
begin
  if SimplePanel then
    InternalDrawPanel(-1, Rect(0, 1, WndSize.cx - 1, WndSize.cy - 1))
  else
    for i := 0 to PartsCount - 1 do
      DrawPanel(i, PartRect(i));
end;


function TacStatusBarWnd.PartRect(const Index: integer): TRect;
begin
  ProcessMessage(SB_GETRECT, Index, LPARAM(@Result));
end;


function TacStatusBarWnd.PartsCount: integer;
begin
  Result := ProcessMessage(SB_GETPARTS, 0, 0);
end;


function TacStatusBarWnd.PartText(const Index: integer): acString;
var
  Len: integer;
begin
  if PartsCount = 0 then
    Result := ''
  else
    if SimplePanel then begin
      Len := ProcessMessage(WM_GETTEXTLENGTH, 0, 0);
      SetString(Result, PacChar(nil), Len);
      if Len <> 0 then
        ProcessMessage(WM_GETTEXT, Len + 1, LPARAM(Result))
      else
        Result := '';
    end
    else
      if StatusBar <> nil then
        if StatusBar.Panels.Count > 0 then
          Result := StatusBar.Panels[Index].Text
        else
          Result := StatusBar.SimpleText
      else
        Result := '';
end;


procedure TacStatusBarWnd.PrepareCache;
begin
  InitCacheBmp(SkinData);
  PaintItem(SkinData, GetParentCache(SkinData), False, 0, MkRect(SkinData.FCacheBmp), Point(WndPos.X, WndPos.Y), SkinData.FCacheBmp, False);
  PaintPanels;
  PaintGrip;                       
  SkinData.BGChanged := False;
end;


function TacStatusBarWnd.SimplePanel: boolean;
begin
  Result := ProcessMessage(SB_ISSIMPLE, 0, 0) = 1;
end;


procedure TacStatusBarWnd.WMNCPaint(const aDC: hdc);
var
  DC: hdc;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  if SkinData.FOwnerControl is TStatusBar then begin
    if aDC = 0 then
      DC := GetWindowDC(CtrlHandle)
    else
      DC := aDC;

    if SkinData.BGChanged then
      PrepareCache;
    // Draw borders in non-client area
    BitBltBorder(DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, 0, TStatusBar(SkinData.FOwnerControl).BorderWidth);
    if aDC = 0 then
      ReleaseDC(CtrlHandle, DC);
  end;
end;


procedure TacStatusBarWnd.WMPaint(const aDC: hdc);
var
  DC: hdc;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  if aDC = 0 then
    DC := GetWindowDC(CtrlHandle)
  else
    DC := aDC;

  PrepareCache;
  // Draw borders in non-client area
  BitBlt(DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
  if aDC = 0 then
    ReleaseDC(CtrlHandle, DC);
end;


type
  TAccessButton = class(TSpeedButton);


procedure TacSpeedButtonHandler.acWndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      with Ctrl do
        case Message.WParamHi of
          AC_CTRLHANDLED: begin
            Message.Result := 1;
            Exit;
          end;

          AC_GETAPPLICATION: begin
            Message.Result := LRESULT(Application);
            Exit;
          end;

          AC_SETNEWSKIN:
            if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
              CommonWndProc(Message, SkinData);
              Exit;
            end;

          AC_REMOVESKIN:
            if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and not (csDestroying in ComponentState) then begin
              CommonWndProc(Message, SkinData);
              if Visible then
                Repaint;

              Ctrl.WindowProc := OldWndProc;
              SkinData.WndProc := OldWndProc;
              Destroyed := True;
              Exit;
            end;

          AC_ENDPARENTUPDATE:
            if InUpdating(SkinData) then begin
              SkinData.Updating := False;
              Exit;
            end;

          AC_REFRESH:
            if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
              CommonWndProc(Message, SkinData);
              if Visible then
                Repaint;

              Exit;
            end;

          AC_INVALIDATE: begin
            SkinData.Updating := False;
            SkinData.BGChanged := True;
            Repaint;
          end;
        end;

    WM_DESTROY:
      if not Destroyed then begin
        Destroyed := True;
        if Ctrl <> nil then begin
          Ctrl.WindowProc := OldWndProc;
          SkinData.WndProc := OldWndProc;
          Ctrl := nil;
          PCtrl := nil;
          OldWndProc(Message);
        end;
        Exit;
      end;

    CM_MOUSEENTER, CM_MOUSELEAVE: begin
      SkinData.FMouseAbove := CM_MOUSEENTER = Message.Msg;
      SkinData.BGChanged := True;
      Message.Result := CallPrevWndProc((Message.Msg), Message.WParam, Message.LParam);
      Ctrl.Repaint;
      Exit;
    end;

    WM_PAINT: begin
      AC_WMPaint(TWMPaint(Message));
      Exit;
    end
  end;

  Message.Result := CallPrevWndProc(Message.Msg, Message.WParam, Message.LParam);
end;


procedure TacSpeedButtonHandler.AC_WMPaint(var Message: TWMPaint);
var
  DC, SavedDC: hdc;
begin
  if Message.DC <> 0 then begin
    DC := Message.DC;
    SavedDC := SaveDC(DC);
    PrepareCache;
    UpdateCorners(SkinData, 0);
    BitBlt(DC, 0, 0, Ctrl.Width, Ctrl.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
    RestoreDC(DC, SavedDC);
  end;
end;


function TacSpeedButtonHandler.CallPrevWndProc(const Msg: longint; const WParam: WPARAM; var lParam: LPARAM): LRESULT;
var
  M: TMessage;
begin
  Result := 0;
  if Assigned(OldWndProc) then begin
    M.Msg := Msg;
    M.WParam := WParam;
    M.LParam := LParam;
    M.Result := 0;
    OldWndProc(M);
    Result := M.Result;
    LParam := M.LParam;
  end
end;


function TacSpeedButtonHandler.Caption: acString;
begin
{$IFDEF TNTUNICODE}
  if Ctrl is TTntSpeedButton then
    Result := TTntSpeedButton(Ctrl).Caption
  else
{$ENDIF}
    Result := TSpeedButton(Ctrl).Caption
end;


function TacSpeedButtonHandler.CaptionRect: TRect;
var
  Size: TSize;
  DoOffset: boolean;
begin
  with TSpeedButton(Ctrl) do begin
    Size := TextRectSize;
    DoOffset := (CurrentState = 2) and (not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick);
    if not Glyph.Empty then begin
      Result := ImgRect;
      case Layout of
        blGlyphLeft: begin
          Result.Left := Result.Right + Spacing;
          Result.Top := (Height - Size.cy) div 2;
        end;

        blGlyphRight: begin
          Result.Left := Result.Left - Spacing - Size.cx;
          Result.Top := (Height - Size.cy) div 2;
        end;

        blGlyphTop: begin
          Result.Left := (Width - Size.cx) div 2;
          Result.Top := Result.Bottom + Spacing - integer(DoOffset);
        end;

        blGlyphBottom: begin
          Result.Left := (Width - Size.cx) div 2;
          Result.Top := Result.Top - Spacing - Size.cy;
        end;
      end;
    end
    else
      if Margin <> -1 then
        case Layout of
          blGlyphLeft: begin
            Result.Left := Margin;
            Result.Top := (Height - Size.cy) div 2;
          end;

          blGlyphRight: begin
            Result.Left := Width - Margin - Size.cx;
            Result.Top := (Height - Size.cy) div 2;
          end;

          blGlyphTop: begin
            Result.Left := (Width - Size.cx) div 2;
            Result.Top := Margin;
          end;

          blGlyphBottom: begin
            Result.Left := (Width - Size.cx) div 2;
            Result.Top := Height - Margin - Size.cy;
          end;
        end
      else begin
        Result.Left := (Width - Size.cx) div 2;
        Result.Top := (Height - Size.cy) div 2;
      end;

    Result.Right := Result.Left + Size.cx;
    Result.Bottom := Result.Top + Size.cy;
    if DoOffset then
      OffsetRect(Result, 1, 1);
  end;
end;


constructor TacSpeedButtonHandler.Create(Btn: TControl; ASkinData: TsCommonData; ASkinManager: TsSkinManager; const SkinSection: string; Repaint: boolean);
begin
  Ctrl := Btn;
  PCtrl := @Btn;
  OldWndProc := nil;
  SkinManager := ASkinManager;
  Destroyed := False;
  SkinData := ASkinData;
  if SkinManager = nil then
    SkinManager := SkinData.SkinManager;

  if SkinData.SkinSection = '' then
    SkinData.SkinSection := SkinSection;

  OldWndProc := Ctrl.WindowProc;
  Ctrl.WindowProc := acWndProc;
  SkinData.WndProc := acWndProc;
end;


function TacSpeedButtonHandler.CurrentState: integer;
begin
  if TAccessButton(Ctrl).FState in [bsDown, bsExclusive] then
    Result := 2
  else
    Result := integer(ControlIsActive(SkinData));
end;


destructor TacSpeedButtonHandler.Destroy;
begin
  try
    if not Destroyed and Assigned(Ctrl) and Assigned(PCtrl) then
      with Ctrl do
        if (Left <> Width) and (Top <> Height) and (Tag <> Left) then begin // If not destroyed already
          WindowProc := OldWndProc;
          SkinData.WndProc := OldWndProc;
        end;
  finally
    SkinManager := nil;
  end;
  inherited Destroy;
end;


procedure TacSpeedButtonHandler.DoDrawText(Rect: TRect; Flags: Integer);
begin
  with TAccessButton(Ctrl) do begin
    Flags := {$IFDEF FPC}Flags{$ELSE}DrawTextBiDiModeFlags(Flags){$ENDIF} and not DT_SINGLELINE;
    SkinData.FCacheBMP.Canvas.Font.Assign(Font);
    acWriteTextEx(SkinData.FCacheBMP.Canvas, PacChar(Caption), True, Rect, Flags, SkinData, CurrentState <> 0);
  end;
end;


procedure TacSpeedButtonHandler.DrawCaption;
begin
  if Caption <> '' then begin
    SkinData.FCacheBmp.Canvas.Font.Assign(TAccessButton(Ctrl).Font);
    SkinData.FCacheBMP.Canvas.Brush.Style := bsClear;
    DoDrawText(CaptionRect, DT_EXPANDTABS or DT_WORDBREAK or DT_CENTER);
  end;
end;


procedure TacSpeedButtonHandler.DrawGlyph;
var
  DrawData: TacDrawGlyphData;
begin
  if Ctrl is TSpeedButton then
    with TSpeedButton(Ctrl) do begin
      if Glyph.PixelFormat = pfDevice then
        Glyph.HandleType := bmDIB;

      DrawData.Images            := nil;
      DrawData.Glyph             := Glyph;
      DrawData.ImageIndex        := 0;
      DrawData.SkinIndex         := SkinData.SkinIndex;
      DrawData.SkinManager       := SkinData.SkinManager;
      DrawData.DstBmp            := SkinData.FCacheBmp;
      DrawData.ImgRect           := ImgRect;
      DrawData.NumGlyphs         := NumGlyphs;
      DrawData.Enabled           := Enabled;
      DrawData.Blend             := 0;
      DrawData.Down              := Down;
      DrawData.CurrentState      := CurrentState;
      DrawData.Grayed            := (DrawData.CurrentState = 0) and (SkinData.SkinManager <> nil) and SkinData.SkinManager.Effects.DiscoloredGlyphs and SkinData.Skinned;
      DrawData.DisabledGlyphKind := DefDisabledGlyphKind;
      DrawData.Reflected         := False;
      if DrawData.Grayed then
        DrawData.BGColor := SkinData.SkinManager.gd[DrawData.SkinIndex].Props[0].Color;

      acDrawGlyphEx(DrawData);
    end
end;


function TacSpeedButtonHandler.GlyphHeight: integer;
begin
  if not TSpeedButton(Ctrl).Glyph.Empty then
    Result := TSpeedButton(Ctrl).Glyph.Height
  else
    Result := 0;
end;


function TacSpeedButtonHandler.GlyphWidth: integer;
begin
  with TSpeedButton(Ctrl) do
    if not Glyph.Empty then
      Result := Glyph.Width div NumGlyphs
    else
      Result := 0;
end;


function TacSpeedButtonHandler.ImgRect: TRect;
var
  x, y, dw, dh, gw, gh: integer;
begin
  x := 0;
  y := 0;
  with TSpeedButton(Ctrl) do begin
    Result := MkRect;
    gw := GlyphWidth;
    gh := GlyphHeight;
    dw := (Width  - gw - Spacing * integer((gw > 0) and (Caption <> '')) - TextRectSize.cx) div 2;
    dh := (Height - gh - Spacing * integer((gh > 0) and (Caption <> '')) - TextRectSize.cy) div 2;
    case Layout of
      blGlyphLeft: begin
        if Margin <> -1 then
          x := Margin
        else
          x := dw;

        y := (Height - gh) div 2;
      end;

      blGlyphRight: begin
        if Margin <> -1 then
          x := Width - gw - Margin
        else
          x := Width - dw - gw;

        y := (Height - GlyphHeight) div 2;
      end;

      blGlyphTop: begin
        x := (Width - gw) div 2;
        if Margin <> -1 then
          y := Margin
        else
          y := dh;
      end;

      blGlyphBottom: begin
        x := (Width - gw) div 2;
        if Margin <> -1 then
          y := Height - gh - Margin
        else
          y := Height - dh - gh;
      end;
    end;
    if CurrentState = 2 then
      if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then begin
        inc(x);
        inc(y);
      end;
      
    Result := Rect(x, y, x + gw, y + gh);
  end;
end;


function TacSpeedButtonHandler.PrepareCache: boolean;
var
  CI: TCacheInfo;
  ParentBG: TacBGInfo;
begin
  Result := True;
  InitCacheBmp(SkinData);
  SkinData.FCacheBmp.Canvas.Font.Assign(TsAccessControl(Ctrl).Font);
  ParentBG.BgType := btUnknown;
  ParentBG.DrawDC := 0;
  ParentBG.PleaseDraw := False;
  GetBGInfo(@ParentBG, Ctrl.Parent);
  CI := BGInfoToCI(@ParentBG);
  if not CI.Ready or (CI.Bmp.Width <> 0) then begin
    PaintItem(SkinData, CI, True, CurrentState, MkRect(Ctrl), MkPoint(Ctrl), SkinData.FCacheBmp, True, integer(CurrentState = 2), integer(CurrentState = 2));
    UpdateCorners(SkinData, CurrentState);
    DrawCaption;
    DrawGlyph;
    if not Ctrl.Enabled then begin
      CI := GetParentCache(SkinData);
      BmpDisabledKind(SkinData.FCacheBmp, DefDisabledKind, Ctrl.Parent, CI, MkPoint(Ctrl));
    end;
    SkinData.BGChanged := False;
  end;
end;


function TacSpeedButtonHandler.TextRectSize: TSize;
var
  R: TRect;
begin
  if Caption <> '' then begin
    R := MkRect(MaxByte, 0);
    acDrawText(SkinData.FCacheBMP.Canvas.Handle, Caption, R, DT_EXPANDTABS or DT_WORDBREAK or DT_CALCRECT);
    Result := MkSize(R);
  end
  else
    Result := MkSize;
end;


var
  huser32:   HMODULE = 0;
  hcomctl32: HMODULE = 0;


procedure TacEdgeWnd.acWndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_PAINT: begin
      Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      AC_WMPaint(TWMPaint(Message));
    end;

    WM_NCPAINT, WM_ERASEBKGND:
      ;

    else
      inherited;
  end;
end;


procedure TacEdgeWnd.AC_WMPaint(var Message: TWMPaint);
var
  DC, SavedDC: hdc;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  if Message.DC = 0 then
    DC := GetWindowDC(CtrlHandle)
  else
    DC := Message.DC;

  SavedDC := SaveDC(DC);
  SkinData.BGChanged := True;
  SkinData.FCacheBmp.Width := WndSize.cx;
  SkinData.FCacheBmp.Height := WndSize.cy;
  PrepareCache(SkinData, CtrlHandle);
  PaintText;
  BitBltBorder(DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, 0, 2);
  RestoreDC(DC, SavedDC);
  if Message.DC = 0 then
    ReleaseDC(CtrlHandle, DC);
end;


procedure TacTrackWnd.AC_WMPaint(const Message: TWMPaint);
var
  PS: TPaintStruct;
  DC: hdc;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  if not InUpdating(SkinData) then begin
    InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
    SendMessage(ParentWnd, SM_ALPHACMD, MakeWParam(0, AC_GETCACHE), 0);
    if IsWindowVisible(CtrlHandle) or (Message.DC <> 0) then begin
      if Message.DC = 0 then
        DC := GetDC(CtrlHandle)
      else
        DC := Message.DC;

      PrepareCache;
      BitBlt(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      if Message.DC = 0 then
        ReleaseDC(CtrlHandle, DC);
    end;
  end;
  EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
end;


procedure TacTrackWnd.acWndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_NCPAINT, WM_ERASEBKGND:
      Exit;

    WM_PAINT: begin
      AC_WMPaint(TWMPaint(Message));
      Exit;
    end;

    WM_LBUTTONDOWN:
      bMousePressed := True;

    WM_LBUTTONUP:
      bMousePressed := False;
  end;
  inherited;
end;


function TacTrackWnd.IsVertical: boolean;
begin
  Result := GetWindowLong(CtrlHandle, GWL_STYLE) and TBS_VERT <> 0;
end;


procedure TacTrackWnd.PrepareCache;
begin
  InitCacheBmp(SkinData);
  SkinData.FCacheBmp.Width := WndSize.cx;
  SkinData.FCacheBmp.Height := WndSize.cy;
  PaintBody;
end;


procedure TacTrackWnd.PaintBody;
var
  R: TRect;
  CI: TCacheInfo;
begin
  CI := GetParentCacheHwnd(CtrlHandle);
  PaintItem(SkinData, CI, True, Mode, MkRect(WndSize), WndPos, SkinData.FCacheBmp, False);
  if SkinData.SkinManager.ConstData.Sections[ssTrackBar] >= 0 then begin
    PaintBar;
    PaintThumb(ProcessMessage(TBM_GETPOS, 0, 0));
    if not IsWindowEnabled(CtrlHandle) then
      if CI.Ready then begin
        R := MkRect(WndSize);
        OffsetRect(R, CI.X + WndPos.x, CI.Y + WndPos.y);
        BlendTransRectangle(SkinData.FCacheBmp, 0, 0, CI.Bmp, R, DefBlendDisabled);
      end
      else
        BlendTransBitmap(SkinData.FCacheBmp, DefBlendDisabled, TsColor(CI.FillColor));
  end;
end;


procedure TacTrackWnd.PaintBar;
var
  w, h, i: integer;
  CI: TCacheInfo;
  aRect: TRect;
begin
  aRect := ChannelRect;
  i := SkinData.SkinManager.GetMaskIndex(SkinData.SkinManager.ConstData.Sections[ssTrackBar], s_SliderChannelMask);
  if SkinData.SkinManager.IsValidImgIndex(i) then begin
    if IsVertical then begin
      h := SkinData.SkinManager.ma[i].Width - 1;
      w := WidthOf(aRect);
      aRect.Left := aRect.Left + (w - h) div 2;
      aRect.Right := aRect.Left + h;
    end
    else begin
      h := SkinData.SkinManager.ma[i].Height - 1;
      w := HeightOf(aRect);
      aRect.Top := aRect.Top + (w - h) div 2;
      aRect.Bottom := aRect.Top + h;
    end;
    CI := MakeCacheInfo(SkinData.FCacheBmp);
    DrawSkinRect(SkinData.FCacheBmp, aRect, CI, SkinData.SkinManager.ma[i], integer(ControlIsActive(SkinData)), True);
  end;
  if IsVertical then
    PaintTicksVer
  else
    PaintTicksHor;
end;


procedure TacTrackWnd.PaintThumb(i: integer);
var
  Bmp: TBitmap;
  GlyphSize: TSize;
  Stretched: boolean;
  aRect, DrawRect: TRect;

  procedure RotateBmp180(const Bmp: TBitmap; const Horz: boolean);
  var
    w, h, x, y: integer;
    c: TColor;
  begin
    w := Bmp.Width - 1;
    h := Bmp.Height - 1;
    if not Horz then
      for x := 0 to w do
        for y := 0 to (h) div 2 do begin
          c := GetAPixel(Bmp, x, y).C;
          SetAPixel(Bmp, x, y, GetAPixel(Bmp, x, h - y));
          SetAPixel(Bmp, x, h - y, c);
        end
    else
      for y := 0 to h do
        for x := 0 to w div 2 do begin
          c := GetAPixel(Bmp, x, y).C;
          SetAPixel(Bmp, x, y, GetAPixel(Bmp, w - x, y));
          SetAPixel(Bmp, w - x, y, c);
        end;
  end;

  function PrepareBG: TRect;
  var
    TmpBmp: TBitmap;
  begin
    if Stretched or (TickMarks = tmTopLeft) then begin
      Bmp := CreateBmp32(GlyphSize);
      Result := MkRect(GlyphSize);
      TmpBmp := CreateBmp32(aRect);
      BitBlt(TmpBmp.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, SkinData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, SRCCOPY);
      Stretch(TmpBmp, Bmp, Bmp.Width, Bmp.Height, ftMitchell);
      if TickMarks = tmTopLeft then
        RotateBmp180(Bmp, IsVertical);

      FreeAndNil(TmpBmp);
    end
    else begin
      Bmp := SkinData.FCacheBmp;
      Result := aRect;
    end;
  end;

  procedure ReturnToCache;
  var
    TmpBmp: TBitmap;
  begin
    if SkinData.FCacheBmp <> Bmp then begin
      if TickMarks = tmTopLeft then
        RotateBmp180(Bmp, IsVertical);

      TmpBmp := CreateBmp32(aRect);
      Stretch(Bmp, TmpBmp, TmpBmp.Width, TmpBmp.Height, ftMitchell);
      BitBlt(SkinData.FCacheBmp.Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
      FreeAndNil(TmpBmp);
    end
  end;

begin
  aRect := ThumbRect;
  with SkinData.SkinManager do begin
    if IsVertical then
      i := GetMaskIndex(ConstData.Sections[ssTrackBar], s_SliderVertMask)
    else
      i := -1;

    if i < 0 then
      i := GetMaskIndex(ConstData.Sections[ssTrackBar], s_SliderHorzMask);

    if IsValidImgIndex(i) then begin
      GlyphSize := MkSize(ma[i]);
      if not IsVertical and (HeightOf(aRect) = 23) or IsVertical and (WidthOf(aRect) = 23) then
        Stretched := False
      else
        Stretched := (HeightOf(aRect) <> GlyphSize.cy) or (WidthOf(aRect) <> GlyphSize.cx);

      DrawRect := PrepareBG;
      DrawSkinGlyph(Bmp, point(DrawRect.Left + (WidthOf(DrawRect) - GlyphSize.cx) div 2, DrawRect.Top + (HeightOf(DrawRect) - GlyphSize.cy) div 2), Mode, 1, ma[i], MakeCacheInfo(Bmp));
      ReturnToCache;
      if Bmp <> Self.SkinData.FCacheBmp then
        FreeAndNil(Bmp);
    end;
  end;
end;


function TacTrackWnd.ChannelRect: TRect;
begin
  Result := MkRect(1, 1);
  ProcessMessage(TBM_GETCHANNELRECT, 0, LPARAM(@Result));
  if IsVertical then begin
    Changei(Result.Left, Result.Top);
    Changei(Result.Right, Result.Bottom);
  end;
end;


procedure TacTrackWnd.PaintTicksHor;
var
  i, mh: integer;
  pa: TAPoint;
  cr: TRect;
begin
  pa := nil;
  cr := ChannelRect;
  mh := (HeightOf(ThumbRect) - HeightOf(cr)) div 2 + 2;
  if TickStyle <> tsNone then begin
    pa := TicksArray;
    if TickMarks in [tmTopLeft, tmBoth] then
      for i := 0 to High(pa) do
        PaintTick(Point(pa[i].x, cr.Top - mh - TickHeight), True);

    if TickMarks in [tmBottomRight, tmBoth] then
      for i := 0 to High(pa) do
        PaintTick(Point(pa[i].x, cr.Bottom + mh), True);
  end;
end;


procedure TacTrackWnd.PaintTicksVer;
var
  i, mh: integer;
  pa: TAPoint;
  cr: TRect;
begin
  if TickStyle <> tsNone then begin
    pa := TicksArray;
    cr := ChannelRect;
    mh := (WidthOf(ThumbRect) - WidthOf(cr)) div 2 + 2;
    if TickMarks in [tmTopLeft, tmBoth] then
      for i := 0 to High(pa) do
        PaintTick(Point(cr.Left - mh - TickHeight, pa[i].y), False);

    if TickMarks in [tmBottomRight, tmBoth] then
      for i := 0 to High(pa) do
        PaintTick(Point(cr.Right + mh, pa[i].y), False);
  end
  else
    pa := nil;
end;


function TacTrackWnd.TickMarks: TTickMark;
var
  Style: ACNativeInt;
begin
  Style := GetWindowLong(CtrlHandle, GWL_STYLE);
  if Style and TBS_BOTH <> 0 then
    Result := tmBoth
  else
    if Style and TBS_TOP <> 0 then
      Result := tmTopLeft
    else
      Result := tmBottomRight;
end;


function TacTrackWnd.ThumbRect: TRect;
begin
  Result := MkRect(1, 1);
  ProcessMessage(TBM_GETTHUMBRECT, 0, LPARAM(@Result));
end;


function TacTrackWnd.Mode: integer;
begin
  Result := integer(bMousePressed)
end;


function TacTrackWnd.TicksArray: TAPoint;
var
  i, w, c: integer;
  ChRect, ThRect: TRect;
begin
  Result := nil;
  ChRect := ChannelRect;
  ThRect := ThumbRect;
  c := TickCount;
  SetLength(Result, c);
  if TickStyle = tsAuto then 
    if IsVertical then begin
      iStep := (HeightOf(ChRect) - HeightOf(ThRect)) / (TickCount - 1);
      w := HeightOf(ThRect) div 2;
      for i := 0 to c - 1 do
        Result[i] := Point(0, Round(ChRect.Top + i * iStep + w));
    end
    else begin
      iStep := (WidthOf(ChRect) - WidthOf(ThRect)) / (TickCount - 1);
      w := WidthOf(ThRect) div 2;
      for i := 0 to c - 1 do
        Result[i] := Point(Round(ChRect.Left + i * iStep + w), 0);
    end
  else
    if IsVertical then begin
      Result[0] := Point(0, ChRect.Top + HeightOf(ThRect) div 2);
      for i := 0 to c - 3 do
        Result[i + 1] := Point(0, TickPos(i));

      Result[c - 1] := Point(0, ChRect.Bottom - HeightOf(ThRect) div 2);
    end
    else begin
      Result[0] := Point(ChRect.Left + WidthOf(ThRect) div 2, 0);
      for i := 0 to c - 3 do
        Result[i + 1] := Point(TickPos(i), 0);

      Result[c - 1] := Point(ChRect.Right - WidthOf(ThRect) div 2, 0);
    end;
end;


function TacTrackWnd.TickStyle: TTickStyle;
begin
  if GetWindowLong(CtrlHandle, GWL_STYLE) and TBS_NOTICKS <> 0 then
    Result := tsNone
  else
    Result := tsAuto;
end;


procedure TacTrackWnd.PaintTick(P: TPoint; Horz: boolean);
var
  GlyphIndex, w: integer;
  R: TRect;
begin
  with SkinData.SkinManager do begin
    if Horz then
      GlyphIndex := GetMaskIndex(ConstData.Sections[ssTrackBar], s_TickHorz)
    else
      GlyphIndex := GetMaskIndex(ConstData.Sections[ssTrackBar], s_TickVert);

    if GlyphIndex >= 0 then begin
      if Horz then
        dec(P.x, ma[GlyphIndex].Width)
      else
        dec(P.y, ma[GlyphIndex].Height);

      DrawSkinGlyph(SkinData.FCacheBmp, P, Mode, 1, ma[GlyphIndex], MakeCacheInfo(SkinData.FCacheBmp))
    end
    else begin
      if Horz then
        R := Rect(P.x, P.y, P.x + 2, P.Y + TickHeight)
      else
        R := Rect(P.x, P.y, P.x + TickHeight, P.Y + 2);

      w := 1;
      DrawRectangleOnDC(SkinData.FCacheBmp.Canvas.Handle, R, ColorToRGB(clBtnShadow), ColorToRGB(clWhite), w);
    end;
  end;
end;


function TacTrackWnd.TickCount: integer;
begin
  Result := ProcessMessage(TBM_GETNUMTICS, 0, 0);
end;


function TacTrackWnd.TickPos(const i: integer): integer;
begin
  Result := integer(ProcessMessage(TBM_GETTICPOS, longint(i), 0));
end;


procedure TacTrackWnd.AfterCreation;
begin
  TickHeight := 4;
  inherited;
end;


procedure TacSBWnd.acWndProc(var Message: TMessage);
var
  i: integer;
  p: TPoint;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if (Control <> nil) and (Message.Msg = SM_ALPHACMD) and not (csDestroying in Control.ComponentState) then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end;

      AC_GETAPPLICATION: begin
        Message.Result := LRESULT(Application);
        Exit;
      end;

      AC_REMOVESKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonMessage(Message, SkinData);
          Exit;
        end;

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonMessage(Message, SkinData);
          Exit;
        end;

      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonMessage(Message, SkinData);
          SkinData.BGChanged := True;
          Exit;
        end;

      AC_INVALIDATE:
        Control.Repaint;

      AC_ENDPARENTUPDATE: begin
        if SkinData.FUpdating then begin
          if not InUpdating(SkinData, True) then begin
            RedrawWindow(CtrlHandle, nil, 0, {RDW_ALLCHILDREN or }RDW_INVALIDATE or RDW_UPDATENOW or RDW_ERASE);
            if SkinData.FOwnerControl is TWinControl then
              SetParentUpdated(TWinControl(SkinData.FOwnerControl));
          end;
        end
        else
          if SkinData.CtrlSkinState and ACS_FAST <> 0 then
            if SkinData.FOwnerControl is TWinControl then
              SetParentUpdated(TWinControl(SkinData.FOwnerControl));

        Exit;
      end
    end;
  if Assigned(SkinData) then begin
    case Message.Msg of
      CN_CTLCOLORSCROLLBAR: begin
        ExcludeClipRect(hdc(Message.WParam), 0, 0, Control.Width, Control.Height);
        Exit;
      end;

      SBM_SETSCROLLINFO:
        if Control.Width <> Control.Height then begin
          with PScrollInfo(Message.LParam)^ do begin
            if Boolean(fMask and SIF_PAGE) and (FSI.nPage <> nPage) then
              FSI.nPage := PScrollInfo(Message.LParam)^.nPage;

            if Boolean(fMask and SIF_POS) and (FSI.nPos <> nPos) then
              FSI.nPos := PScrollInfo(Message.LParam)^.nPos;

            if Boolean(fMask and SIF_RANGE) and ((FSI.nMin <> nMin) or (FSI.nMax <> nMax)) then begin
              if nMax - nMin < 0 then begin
                FSI.nMin := 0;
                FSI.nMax := 0;
              end
              else begin
                FSI.nMin := nMin;
                FSI.nMax := nMax;
              end;
              if Boolean(fMask and SIF_POS) then begin
                if Control.Min <> FSI.nMin then
                  Control.Min := FSI.nMin;

                if (Cardinal(Control.PageSize) <> FSI.nPage) and (FSI.nPage < Cardinal(Control.Max)) then
                  Control.PageSize := FSI.nPage;

                if Control.PageSize > FSI.nMax then
                  Control.PageSize := FSI.nMax;

                if FSI.nMax <> Control.Max then
                  Control.Max := FSI.nMax;
              end;
            end;

            if integer(FSI.nPage) < 0 then
              FSI.nPage := 0
            else
              if integer(FSI.nPage) > (FSI.nMax - FSI.nMin + 1) then
                FSI.nPage := (FSI.nMax - FSI.nMin + 1);

            if FSI.nPos < FSI.nMin then
              FSI.nPos := FSI.nMin
            else
              if FSI.nPos > (FSI.nMax - Math.Max(Integer(FSI.nPage) - 1, 0)) then
                FSI.nPos := (FSI.nMax - Math.Max(Integer(FSI.nPage) - 1, 0));

            if ScrollCode <> SB_THUMBTRACK then
              FCurrPos := FSI.nPos;
          end;
          if Control.Visible then begin
            i := FLockCount;
            ProcessMessage(WM_SETREDRAW, 0, 0);
            inherited;
            while FLockCount > 0 do
              ProcessMessage(WM_SETREDRAW, 1, 0); // Clear Lock

            InvalidateRect(Control.Handle, nil, True);
            RedrawWindow(Control.Handle, nil, 0, RDWA_NOCHILDRENNOW);
            while FLockCount < i do
              ProcessMessage(WM_SETREDRAW, 0, 0); // Restore Lock
          end
          else
            inherited;

          Exit;
        end;

      CM_CHANGED: begin
        i := FLockCount;
        if Control.Visible then begin
          ProcessMessage(WM_SETREDRAW, 0, 0);
          inherited;
          while FLockCount > 0 do
            ProcessMessage(WM_SETREDRAW, 1, 0); // Clear Lock

          InvalidateRect(Control.Handle, nil, True);
          RedrawWindow(Control.Handle, nil, 0, RDWA_NOCHILDRENNOW);
          while FLockCount < i do
            ProcessMessage(WM_SETREDRAW, 0, 0); // Restore Lock
        end
        else
          inherited;

        Exit;
      end;

      WM_PRINT:
        if (DefaultManager <> nil) and DefaultManager.Active then begin
          SendMessage(Control.Handle, WM_PAINT, Message.WParam, Message.LParam);
          Control.Perform(WM_NCPAINT, Message.WParam, Message.LParam);
          Exit;
        end;

      WM_NCPAINT:
        Exit;

      WM_PAINT: begin
        WMPaint(TWMPaint(Message));
        Exit;
      end;

      WM_NCLBUTTONDBLCLK, WM_LBUTTONDBLCLK: begin
        if Control.Visible then begin
          SetRedraw(Control.Handle, 0);
          inherited;
          SetRedraw(Control.Handle, 1);
        end
        else
          inherited;

        p := Control.ScreenToClient(acMousePos);
        LMouseDown(p.X, p.Y);
        LMouseUp(p.X, p.Y);
        Exit;
      end;

      WM_NCLBUTTONDOWN, WM_LBUTTONDOWN: begin
        LMouseDown(TWMMouse(Message).XPos, TWMMouse(Message).YPos);
        if Control.Visible then begin
          while FLockCount > 0 do
            SetRedraw(Control.Handle, 1);

          SetWindowLong(Control.Handle, GWL_STYLE, GetWindowLong(Control.Handle, GWL_STYLE) or WS_VISIBLE);
          inherited;
          InvalidateRect(Control.Handle, nil, True);
          RedrawWindow(Control.Handle, nil, 0, RDWA_NOCHILDRENNOW);
        end
        else
          inherited;

        Exit;
      end;

      WM_CAPTURECHANGED: begin
        p := Control.ScreenToClient(acMousePos);
        LMouseUp(p.X, p.Y);
      end;

      WM_NCLBUTTONUP, WM_LBUTTONUP:
        LMouseUp(TWMMouse(Message).XPos, TWMMouse(Message).YPos);

      WM_SETREDRAW:
        if not FRepainting then
          if Message.WParam = 0 then
            inc(FLockCount)
          else
            dec(FLockCount);

      CM_ENABLEDCHANGED: begin
        inherited;
        SkinData.Invalidate;
        Exit;
      end;

      WM_NCHITTEST:
        WMNCHitTest(TWMNCHitTest(Message));

      CM_MOUSELEAVE: begin
        CMMouseLeave;
        Exit;
      end;

      CM_MOUSEENTER: begin
        CMMouseEnter;
        Exit;
      end;
    end;
    CommonWndProc(Message, SkinData);
  end;
  inherited;
end;


function TacSBWnd.Bar1Rect: TRect;
begin
  FBar1Rect.Left := 0;
  FBar1Rect.Top := 0;
  if Control.Kind = sbHorizontal then begin
    FBar1Rect.Right := PositionToCoord;
    FBar1Rect.Bottom := Control.Height;
  end
  else begin
    FBar1Rect.Right := Control.Width;
    FBar1Rect.Bottom := PositionToCoord;
  end;
  Result := FBar1Rect;
end;


function TacSBWnd.Bar2Rect: TRect;
begin
  if Control.Kind = sbHorizontal then begin
    FBar2Rect.Left   := PositionToCoord;
    FBar2Rect.Top    := 0;
    FBar2Rect.Right  := Control.Width;
    FBar2Rect.Bottom := Control.Height;
  end
  else begin
    FBar2Rect.Left   := 0;
    FBar2Rect.Top    := PositionToCoord;
    FBar2Rect.Right  := Control.Width;
    FBar2Rect.Bottom := Control.Height;
  end;
  Result := FBar2Rect;
end;


function TacSBWnd.BarIsHot: boolean;
begin
  Result := ControlIsActive(SkinData);
end;


function BtnDrawRect(R: TRect; cd: TsCommonData; Side: TacSide): TRect;
var
  w: integer;
begin
  Result := R;
  with cd.SkinManager, ConstData.ScrollBtns[Side] do
    if (SkinIndex >= 0) and gd[SkinIndex].ReservedBoolean and (MaskIndex >= 0) then begin
      w := 17;//GetScrollSize(cd.SkinManager);
      case Side of
        asLeft:   Result.Right  := Result.Right  + (ma[MaskIndex].Width  - w);
        asTop:    Result.Bottom := Result.Bottom + (ma[MaskIndex].Height - w);
        asRight:  Result.Left   := Result.Left   - (ma[MaskIndex].Width  - w);
        asBottom: Result.Top    := Result.Top    - (ma[MaskIndex].Height - w);
      end
    end;
end;


function TacSBWnd.Btn1Rect: TRect;
begin
  FBtn1Rect.TopLeft := MkPoint;
  with Control do
    if Kind = sbHorizontal then begin
      FBtn1Rect.Bottom := Height;
      FBtn1Rect.Right := SysBtnSize;
      if WidthOf(FBtn1Rect) > Width div 2 then
        FBtn1Rect.Right := Width div 2;
    end
    else begin
      FBtn1Rect.Right := Width;
      FBtn1Rect.Bottom := SysBtnSize;
      if HeightOf(FBtn1Rect) > Height div 2 then
        FBtn1Rect.Bottom := Height div 2;
    end;

  Result := FBtn1Rect;
end;


function TacSBWnd.Btn2Rect: TRect;
begin
  with Control do
    if Kind = sbHorizontal then begin
      FBtn2Rect.Left := Width - SysBtnSize;
      FBtn2Rect.Top := 0;
      FBtn2Rect.Right := Width;
      FBtn2Rect.Bottom := Height;
      if WidthOf(FBtn2Rect) > Width div 2 then
        FBtn2Rect.Left := Width div 2;
    end
    else begin
      FBtn2Rect.Left := 0;
      FBtn2Rect.Top := Height - SysBtnSize;
      FBtn2Rect.Right := Width;
      FBtn2Rect.Bottom := Height;
      if HeightOf(FBtn2Rect) > Height div 2 then
        FBtn2Rect.Top := Height div 2;
    end;

  Result := FBtn2Rect;
end;


procedure TacSBWnd.CMMouseEnter;
begin
  Bar1State := 1;
  Bar2State := 1;
  UpdateBar;
end;


procedure TacSBWnd.CMMouseLeave;
begin
  Btn1State := 0;
  Btn2State := 0;
  if SliderState <> 2 then begin
    SliderState := 0;
    Bar1State := 0;
    Bar2State := 0;
  end;
  UpdateBar;
end;


function TacSBWnd.CoordToPosition(const ap: TPoint): integer;
var
  ss, BtnSize: integer;
  r: real;
begin
  if Control.Enabled then begin
    ss := SliderSize;
    if Control.Kind = sbHorizontal then begin
      BtnSize := SysBtnSize;
      r := Control.Width - 2 * BtnSize - ss;
      if r = 0 then
        Result := 0
      else
        Result := Round((ap.x - BtnSize - ss / 2) * (FSI.nMax - FSI.nMin - Math.Max(Integer(FSI.nPage) - 1, 0)) / r)
    end
    else begin
      BtnSize := SysBtnSize;
      r := Control.Height - 2 * BtnSize - ss;
      if r = 0 then
        Result := 0
      else
        Result := Round((ap.y - BtnSize - ss / 2) * (FSI.nMax - FSI.nMin- Math.Max(Integer(FSI.nPage) -1, 0)) / r);
    end;
  end
  else
    Result := 0;
end;


procedure TacSBWnd.DrawSlider(b: TBitmap);
var
  R: TRect;
begin
  R := SliderRect;
  if Control.Kind = sbVertical then begin
    if HeightOf(R) > Control.Height - HeightOf(FBtn1Rect) - HeightOf(FBtn2Rect) then
      Exit;
  end
  else
    if WidthOf(R) > Control.Width - WidthOf(FBtn1Rect) - WidthOf(FBtn2Rect) then
      Exit;

  ac_DrawSlider(R, SliderState, b, SkinData.SkinManager, Control.Kind = sbVertical);
end;


function TacSBWnd.SysBtnSize: integer;
begin
  if Control.Kind = sbHorizontal then
    Result := GetScrollSize(Skindata.SkinManager)
  else
    Result := GetScrollSize(Skindata.SkinManager)
end;


procedure TacSBWnd.InitScrollData;
begin
  FSI.nMax := Control.Max;
  FSI.nMin := Control.Min;
  FSI.nPos := Control.Position;
  FSI.nTrackPos := Control.Position;
  FSI.nPage := Control.PageSize;
  FCurrPos := Control.Position;
end;


procedure TacSBWnd.LMouseDown(const X, Y: Integer);
var
  i: integer;
begin
  if Control.Enabled then begin
    MouseOffset := 0;
    if PtInRect(Btn1Rect, Point(x,y)) then begin
      if Btn1State <> 2 then begin
        if Control.Kind = sbVertical then
          ScrollCode := SB_LINEUP
        else
          ScrollCode := SB_LINELEFT;

        Btn1State := 2;
      end;
    end
    // If Button2 pressed...
    else
      if PtInRect(Btn2Rect, Point(x,y)) then begin
        if Btn2State <> 2 then begin
          Btn2State := 2;
          if Control.Kind = sbVertical then
            ScrollCode := SB_LINEDOWN
          else
            ScrollCode := SB_LINERIGHT;

        end;
      end
      // If slider pressed...
      else
        if PtInRect(SliderRect, Point(x,y)) then begin
          ScrollCode := SB_THUMBTRACK;
          if SliderState <> 2 then begin
            i := CoordToPosition(Point(x, y));
            MouseOffset := i - Control.Position;
            SliderState := 2;
          end;
        end
        else
          if PtInRect(Bar1Rect, Point(x,y)) then begin
            if Control.Kind = sbVertical then
              ScrollCode := SB_PAGEUP
            else
              ScrollCode := SB_PAGELEFT;

            if Bar1State <> 2 then begin
              Bar1State := 2;
              Bar2State := integer(BarIsHot);
            end;
          end
          else begin
            if Control.Kind = sbVertical then
              ScrollCode := SB_PAGEDOWN
            else
              ScrollCode := SB_PAGERIGHT;

            if Bar2State <> 2 then begin
              Bar1State := integer(BarIsHot);
              Bar2State := 2;
            end;
          end;

    UpdateBar;
  end;
end;


procedure TacSBWnd.LMouseUp(const X, Y: Integer);
begin
  if Control.Enabled then begin
    if PtInRect(SliderRect, Point(X, Y)) or (SliderState = 2) then begin
      ScrollCode := SB_THUMBPOSITION;
      Bar1State := integer(BarIsHot);
      Bar2State := Bar1State;
      if SliderState = 2 then
        SliderState := integer(PtInRect(SliderRect, Point(X, Y)));
    end
    else
      if PtInRect(Btn1Rect, Point(X, Y)) and (Btn1State = 2) then
        Btn1State := 1
      else
        if PtInRect(Btn2Rect, Point(X, Y)) and (Btn2State = 2) then
          Btn2State := 1
        else
          if Bar1State = 2 then
            Bar1State := integer(BarIsHot)
          else
            if Bar2State = 2 then
              Bar2State := integer(BarIsHot);

    UpdateBar;
    ScrollCode := SB_ENDSCROLL;
  end;
end;


function TacSBWnd.PositionToCoord: integer;
var
  i: integer;
begin
  i := FSI.nMax - FSI.nMin - Math.Max(Integer(FSI.nPage) - 1, 0);
  if i <> 0 then
    if Control.Kind = sbHorizontal then
      Result := SysBtnSize + SliderSize div 2 + Round((FCurrPos - FSI.nMin) * ((Control.Width - 2 * SysBtnSize - SliderSize) / i))
    else
      Result := SysBtnSize + SliderSize div 2 + Round((FCurrPos - FSI.nMin) * ((Control.Height - 2 * SysBtnSize - SliderSize) / i))
  else
    if Control.Kind = sbHorizontal then
      Result := Control.Width div 2
    else
      Result := Control.Height div 2;
end;


procedure TacSBWnd.SetInteger(const Index, Value: integer);
begin
  case Index of
    0: if FBtn1State <> Value then begin
      FBtn1State := Value;
      case Value of
        1, 2: begin
          FBtn2State := 0;
          FSliderState := 0;
          FBar1State := 1;
          FBar2State := 1;
        end;
      end;
    end;

    1: if FBtn2State <> Value then begin
      FBtn2State := Value;
      case Value of
        1, 2: begin
          FBtn1State := 0;
          FSliderState := 0;
          FBar1State := 1;
          FBar2State := 1;
        end;
      end;
    end;

    2: if FBar1State <> Value then begin
      FBar1State := Value;
      case Value of
        1, 2: begin
          FBtn1State := 0;
          FBtn2State := 0;
          FSliderState := 0;
          FBar2State := 1;
        end;
      end;
    end;

    3: if FBar2State <> Value then begin
      FBar2State := Value;
      case Value of
        1, 2: begin
          FBtn1State := 0;
          FBtn2State := 0;
          FSliderState := 0;
          FBar1State := 1;
        end;
      end;
    end;

    4: if FSliderState <> Value then begin
      FSliderState := Value;
      case Value of
        1, 2: begin
          FBtn1State := 0;
          FBtn2State := 0;
          FBar1State := 1;
          FBar2State := 1;
        end;
      end;
    end;
  end;
end;


function TacSBWnd.SliderRect: TRect;
begin
  if Control.Kind = sbHorizontal then begin
    if Control.Max = Control.Min then
      FSliderRect.Left := Btn1Rect.Right
    else
      FSliderRect.Left := Round(PositionToCoord - SliderSize / 2);

    FSliderRect.Top := 0;
    FSliderRect.Right := FSliderRect.Left + SliderSize;
    FSliderRect.Bottom := Control.Height;
  end
  else begin
    if Control.Max = Control.Min then
      FSliderRect.Top := Btn1Rect.Bottom
    else
      if Control.Position = Control.Max - Control.PageSize then
        FSliderRect.Top := Btn2Rect.Top - SliderSize
      else
        FSliderRect.Top := Round(PositionToCoord - SliderSize / 2);

    FSliderRect.Left := 0;
    FSliderRect.Right := Control.Width;
    FSliderRect.Bottom := FSliderRect.Top + SliderSize;
  end;
  Result := FSliderRect;
end;


function TacSBWnd.SliderSize: integer;
begin
  if FSI.nPage = 0 then
    Result := acMinThumbSize
  else
    Result := math.max(acMinThumbSize, Round(FSI.nPage * (WorkSize / (FSI.nMax - Math.Max(Integer(FSI.nPage) - 1, 0) + integer(FSI.nPage) - FSI.nMin))));
end;


procedure TacSBWnd.UpdateBar;
begin
  Control.Repaint;
end;


procedure TacSBWnd.WMNCHitTest(var Message: TWMNCHitTest);
var
  i: integer;
begin
  with Control do
    if Enabled then begin
      if PtInRect(SliderRect, ScreenToClient(SmallPointToPoint(Message.Pos))) or (SliderState = 2) then
        if SliderState <> 2 then
          SliderState := 1
        else begin
          i := CoordToPosition(ScreenToClient(Point(Message.Pos.X, Message.Pos.Y))) - MouseOffset;
          if Position <> i then
            Position := i;
        end
      else
        if PtInRect(Btn1Rect, ScreenToClient(SmallPointToPoint(Message.Pos))) then begin
          if Btn1State <> 2 then
            Btn1State := 1;
        end
        else
          if PtInRect(Btn2Rect, ScreenToClient(SmallPointToPoint(Message.Pos))) then begin
            if Btn2State <> 2 then
              Btn2State := 1;
          end
          else
            if (SliderState = 2) then begin
              i := CoordToPosition(ScreenToClient(SmallPointToPoint(Message.Pos)));
              if Position <> i then
                Position := i;
            end
            else begin
              SliderState := 0;
              Btn1State := 0;
              Btn2State := 0;
            end;

      if Self <> nil then
        UpdateBar;
    end;
  inherited;
end;


procedure TacSBWnd.WMPaint(var Msg: TWMPaint);
var
  DC, SavedDC: hdc;
  bmp: TBitmap;
  lCI: TCacheInfo;
  LocalState: integer;
  PS: TPaintStruct;
  BG: TacBGInfo;
  Side: TacSide;
begin
  if Control <> nil then begin
    bmp := nil;
    BeginPaint(Control.Handle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
    if Msg.DC = 0 then
      DC := GetDC(Control.Handle)
    else
      DC := Msg.DC;

    SavedDC := SaveDC(DC);
    try
      if ControlIsReady(Control) and ([csDestroying, csLoading] * Control.ComponentState = []) and not SkinData.Updating then begin
        if Control.Width <> Control.Height then begin // If not grip
          InitCacheBmp(SkinData);
          if not Control.Enabled then
            bmp := CreateBmpLike(SkinData.FCacheBmp)
          else
            bmp := SkinData.FCacheBmp;

          BG.PleaseDraw := False;
          GetBGInfo(@BG, Control.Parent);
          lCI := BGInfoToCI(@BG);
          with SkinData, SkinManager.ConstData do begin
            Bar1Rect;
            if not IsRectEmpty(FBar1Rect) then begin
              if Control.Enabled then
                LocalState := max(Bar1State, integer(BarIsHot))
              else
                LocalState := 0;

              if Control.Kind = sbHorizontal then
                Side := asLeft
              else
                Side := asTop;

              with Scrolls[Side] do
                if SkinManager.IsValidSkinIndex(SkinIndex) then
                  PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                              lCi, True, LocalState, FBar1Rect, MkPoint(Control), FCacheBmp, SkinManager);
            end;
            Bar2Rect;
            if not IsRectEmpty(FBar2Rect) then begin
              if Control.Enabled then
                LocalState := max(Bar2State, integer(BarIsHot))
              else
                LocalState := 0;

              if Control.Kind = sbHorizontal then
                Side := asRight
              else
                Side := asBottom;

              with Scrolls[Side] do
                if SkinManager.IsValidSkinIndex(SkinIndex) then
                  PaintItemFast(SkinIndex, MaskIndex, BGIndex[0], BGIndex[1],
                                lCi, True, LocalState, FBar2Rect, Point(Control.Left + FBar2Rect.Left, Control.Top + FBar2Rect.Top), FCacheBmp, SkinManager)
            end;
          end;
          BitBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
          CI.Bmp := bmp;
          CI.Ready := bmp <> nil;
          if Control.Kind = sbHorizontal then begin
            ac_DrawScrollBtn(Btn1Rect, Btn1State, Bmp, SkinData, asLeft);
            ac_DrawScrollBtn(Btn2Rect, Btn2State, Bmp, SkinData, asRight);
          end
          else begin
            ac_DrawScrollBtn(Btn1Rect, Btn1State, Bmp, SkinData, asTop);
            ac_DrawScrollBtn(Btn2Rect, Btn2State, Bmp, SkinData, asBottom);
          end;
          if Control.Enabled then
            DrawSlider(bmp);

          BG.PleaseDraw := False;
          if not Control.Enabled then begin
            lCI := GetParentCache(SkinData);
            BmpDisabledKind(bmp, [dkBlended], Control.Parent, lCI, MkPoint(Control));
          end;
          BitBlt(DC, 0, 0, bmp.Width, bmp.Height, bmp.Canvas.Handle, 0, 0, SRCCOPY);
          if not Control.Enabled and Assigned(bmp) then
            FreeAndNil(bmp);
        end
        else
          if SkinData.SkinManager.ConstData.Scrolls[asLeft].SkinIndex >= 0 then
            FillDC(DC, MkRect(Control), SkinData.SkinManager.gd[SkinData.SkinManager.ConstData.Scrolls[asLeft].SkinIndex].Props[0].Color)
          else
            FillDC(DC, MkRect(Control), SkinData.SkinManager.GetGlobalColor);
      end;
    finally
      RestoreDC(DC, SavedDC);
      if Msg.DC = 0 then
        ReleaseDC(Control.Handle, DC);

      EndPaint(Control.Handle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
    end;
  end;
end;


function TacSBWnd.WorkSize: integer;
begin
  if Control.Kind = sbHorizontal then
    Result := Control.Width - 2 * SysBtnSize
  else
    Result := Control.Height - 2 * SysBtnSize;
end;


procedure TacSBWnd.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_Transparent;

  if SkinData.FOwnerControl is TWinControl then begin
    Control := TScrollBar(SkinData.FOwnerControl);
    Control.TabStop := False;
  end;
  if SkinData.FOwnerControl is TScrollBar then
    InitScrollData;

  FRepainting := False;
  MouseOffset := 0;
  ScrollCode := 0;
  inherited;
end;


procedure TacScrollBoxWnd.AC_WMNCPaint(aDC: hdc);
var
  DC: hdc;
  w: integer;
  ClRect: TRect;
begin
  GetWindowRect(CtrlHandle, WndRect);
  GetClientRect(CtrlHandle, ClRect);
  WndSize := MkSize(WndRect);
  if aDC = 0 then
    DC := GetWindowDC(CtrlHandle)
  else
    DC := aDC;

  try
    PrepareCache;
    Ac_NCDraw(Self, Self.CtrlHandle, -1, DC);
    w := (WidthOf(WndRect) - WidthOf(ClRect)) div 2;
    if w > 0 then
      BitBltBorder(DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, 0, w);
  finally
    if aDC = 0 then
      ReleaseDC(CtrlHandle, DC);
  end
end;


procedure TacScrollBoxWnd.AC_WMPaint(aDC: hdc);
var
  DC, SaveIndex: HDC;
  Ctrl: TWinControl;
  R, ClRect: TRect;
  w: integer;
  b: boolean;
begin
  Ctrl := TWinControl(SkinData.FOwnerControl);
  if not (csDestroying in Ctrl.ComponentState) then begin
    if (Ctrl.Parent <> nil) and (csCreating in Ctrl.Parent.ControlState) then
      Exit;

    if not InUpdating(SkinData) then begin
      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      if aDC = 0 then
        DC := GetWindowDC(Ctrl.Handle)
      else
        DC := aDC;

      SaveIndex := SaveDC(DC);
      try
        // If transparent and form resizing processed
        b := SkinData.HalfVisible or SkinData.BGChanged;
        if SkinData.RepaintIfMoved then begin
          GetClipBox(DC, R);
          SkinData.HalfVisible := (WidthOf(R) <> Ctrl.Width) or (HeightOf(R) <> Ctrl.Height)
        end
        else
          SkinData.HalfVisible := False;

        if b then
          PrepareCache;

        GetClientRect(CtrlHandle, ClRect);
        w := 2;
        CopyWinControlCache(Ctrl, SkinData, Rect(w, w, 0, 0), MkRect(Ctrl.Width - 2 * w, Ctrl.Height - 2 * w), DC, True);
        sVCLUtils.PaintControls(DC, Ctrl, b and SkinData.RepaintIfMoved, MkPoint);
        SetParentUpdated(Ctrl);
      finally
        RestoreDC(DC, SaveIndex);
        if aDC = 0 then
          ReleaseDC(Ctrl.Handle, DC);
      end;
    end;
  end;
end;


procedure TacScrollBoxWnd.acWndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  M: TMessage;
  SavedDC, DC: hdc;
  R: TRect;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit
      end; // AlphaSkins supported

      AC_GETAPPLICATION: begin
        Message.Result := LRESULT(Application);
        Exit
      end;

      AC_SETNEWSKIN, AC_REFRESH: begin
        inherited;
        CommonMessage(Message, SkinData);
        AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);
        if AC_REFRESH = Message.WParamHi then
          SetWindowPos(CtrlHandle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);

        Exit;
      end;

      AC_REMOVESKIN: begin
        SkinData.SkinIndex := -1;
        SkinData.FOwnerControl.ControlStyle := SkinData.FOwnerControl.ControlStyle - [csOpaque];
        CommonMessage(Message, SkinData);
        SetWindowPos(CtrlHandle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);
        Exit;
      end;

      AC_PREPARECACHE:
        Exit;
    end
  else
    if (SkinData.FOwnerControl <> nil) and (csAcceptsControls in TWinControl(SkinData.FOwnerControl).ControlStyle) then
      if Assigned(SkinData) and SkinData.Skinned then
        case Message.Msg of
          WM_PAINT: begin
            InvalidateRect(CtrlHandle, nil, True);
            BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
            EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
            Exit;
          end;

          WM_NCPAINT:
            if IsWindowVisible(CtrlHandle) and not bPreventStyleChange then begin
              UpdateScrolls(Self, False);
              if not InAnimationProcess then begin
                InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
                if InUpdating(SkinData) then
                  Exit;

                DC := GetWindowDC(CtrlHandle);
                if (DC <> SkinData.PrintDC) and (GetClipBox(DC, R) = NULLREGION) then begin
                  ReleaseDC(CtrlHandle, DC);
                  Exit;
                end;
                if SkinData.BGChanged then begin
                  if not ParamsChanged then
                    SetSkinParams;

                  PrepareCache;
                end;
                SavedDC := SaveDC(DC);
                try
                  Message.Result := Ac_NCDraw(Self, Self.CtrlHandle, -1, DC);
                  if (DC <> 0) and (SkinData <> nil) then
                    BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, 2);
                finally
                  RestoreDC(DC, SavedDC);
                  ReleaseDC(CtrlHandle, DC);
                end;
              end;
              Exit;
            end;

          WM_ERASEBKGND: begin
            AC_WMPaint(TWMPaint(Message).DC);
            Message.Result := ERASE_OK;
            Exit;
          end;

          WM_UPDATEUISTATE: begin
            Message.Result := 1;
            Exit;
          end;

          WM_PRINT: begin
            AC_WMPaint(TWMPaint(Message).DC);
            AC_WMNCPaint(TWMPaint(Message).DC);
            Exit;
          end;

          CM_SHOWINGCHANGED:
            if SkinData.FOwnerControl.Visible then begin
              AddToAdapter(TWinControl(SkinData.FOwnerControl));
              M := MakeMessage(SM_ALPHACMD, AC_SETNEWSKIN_HI, Longint(SkinData.SkinManager), 0);
              AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, M);
              M := MakeMessage(SM_ALPHACMD, AC_REFRESH_HI, Longint(SkinData.SkinManager), 0);
              AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, M);
            end;

          WM_PARENTNOTIFY:
            if Message.WParamLo in [WM_CREATE, WM_DESTROY] then begin
              inherited;
              if Message.WParamLo = WM_CREATE then
                AddToAdapter(TWinControl(SkinData.FOwnerControl));

              Exit;
            end;

          WM_SIZE, CM_TEXTCHANGED:
            SkinData.BGChanged := True;

          WM_WINDOWPOSCHANGED, WM_WINDOWPOSCHANGING:
            if SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Transparency <> 0 then
              SkinData.BGChanged := True;

          WM_SETTEXT:
            if IsWindowVisible(CtrlHandle) then begin
              ProcessMessage(WM_SETREDRAW, 0, 0);
              inherited;
              ProcessMessage(WM_SETREDRAW, 1, 0);
              SkinData.BGChanged := True;
              SendMessage(CtrlHandle, WM_PAINT, 0, 0);
              Exit;
            end;
        end;

  inherited;
  case Message.Msg of
    WM_WINDOWPOSCHANGING:
      SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);
  end;
end;


procedure TacScrollBoxWnd.PrepareCache;
var
  Panel: TacAccessPanel;
  CI: TCacheInfo;
  w: integer;
  R: TRect;
begin
  Panel := TacAccessPanel(SkinData.FOwnerControl);
  InitCacheBmp(SkinData);
  CI := GetParentCache(SkinData);
  PaintItem(SkinData, CI, False, 0, MkRect(Panel), MkPoint(Panel), SkinData.FCacheBMP, False);
  R := Panel.ClientRect;
  w := Panel.BorderWidth + integer(Panel.BevelInner <> bvNone) * Panel.BevelWidth + integer(Panel.BevelOuter <> bvNone) * Panel.BevelWidth;
  InflateRect(R, -w, -w);
  SkinData.BGChanged := False;
end;


procedure TacScrollBoxWnd.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_PanelLow;

  inherited;
end;


procedure TacContainerWnd.acWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_PRINT: begin
      AC_WMPrint(TWMPaint(Message));
      Exit;
    end;

    WM_NCPAINT:
      if IsWindowVisible(CtrlHandle) then begin
        AC_WMNCPaint(Message);
        Exit;
      end;

    WM_ERASEBKGND: begin
      Message.Result := ERASE_OK;
      Exit;
    end;

    WM_PAINT:
      if IsWindowVisible(CtrlHandle) then begin
        AC_WMPaint(TWMPaint(Message));
        Exit;
      end;

    WM_WINDOWPOSCHANGED, WM_SIZE:
      SkinData.BGChanged := True;
  end;
  inherited;
  case Message.Msg of
    WM_WINDOWPOSCHANGED:
      SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);

    WM_SIZE:
      SkinData.BGChanged := True;

    WM_MOUSEMOVE:
      if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) and IsWindowEnabled(CtrlHandle) then
        DefaultManager.ActiveControl := CtrlHandle;
  end;
end;


procedure TacContainerWnd.AC_WMNCPaint(const Message: TMessage);
var
  DC, SavedDC: hdc;
begin
  if GetWindowLong(CtrlHandle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE <> 0 then
    if not InUpdating(SkinData) then begin
      PrepareCache;
      DC := GetWindowDC(CtrlHandle);
      SavedDC := SaveDC(DC);
      try
        BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, (WndSize.cx - WidthOf(ClientRect)) div 2);
      finally
        RestoreDC(DC, SavedDC);
        ReleaseDC(CtrlHandle, DC);
      end;
    end;
end;


procedure TacContainerWnd.AC_WMPaint(const Message: TWMPaint);
var
  PS: TPaintStruct;
begin
  BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
  if not InUpdating(SkinData) then
    AC_WMPrint(Message);

  EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
end;


procedure TacContainerWnd.AC_WMPrint(const Message: TWMPaint);
var
  DC: hdc;
begin
  if IsWindowVisible(CtrlHandle) then begin
    SkinData.BGChanged := True;
    PrepareCache;
    if Message.DC = 0 then
      DC := GetDC(CtrlHandle)
    else
      DC := Message.DC;

    // Filling for toolbar which placed on the glass zone
    FillAlphaRect(SkinData.FCacheBmp, MkRect(SkinData.FCacheBmp.Width - 2 * BorderWidth, SkinData.FCacheBmp.Height - 2 * BorderWidth), 255);
    BitBlt(DC, 0, 0, SkinData.FCacheBmp.Width - 2 * BorderWidth, SkinData.FCacheBmp.Height - 2 * BorderWidth, SkinData.FCacheBmp.Canvas.Handle, BorderWidth, BorderWidth, SRCCOPY);
    if Message.DC = 0 then
      ReleaseDC(CtrlHandle, DC);
  end;
end;


procedure TacContainerWnd.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_Transparent;

  inherited;
end;

procedure TacContainerWnd.PrepareCache;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  if SkinData.BGChanged then begin
    GetClientRect(CtrlHandle, ClientRect);
    acSBUtils.PrepareCache(SkinData, CtrlHandle, False);
    UpdateWndCorners(SkinData, 0, Self);
    BorderWidth := (WndSize.cy - HeightOf(ClientRect)) div 2;
    SkinData.BGChanged := False;
  end;
end;


procedure TacSearchWnd.acWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_NCPAINT: begin
      AC_WMNCPaint(Message);
      Exit;
    end;

    WM_PAINT: begin
      inherited;
      AC_WMNCPaint(Message);
      Exit;
    end;

    WM_ERASEBKGND: begin
      Message.Result := ERASE_OK;
      Exit;
    end;
  end;
  inherited;
  case Message.Msg of
    WM_SIZE: begin
      SkinData.BGChanged := True;
      RedrawWindow(CtrlHandle, nil, 0, RDW_UPDATENOW or RDW_INVALIDATE);
    end;

    WM_MOUSEMOVE:
      if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) and IsWindowEnabled(CtrlHandle) then
        DefaultManager.ActiveControl := CtrlHandle;
  end;
end;


procedure TacSearchWnd.AC_WMNCPaint(const Message: TMessage);
var
  DC, SavedDC: hdc;
begin
  if not InUpdating(SkinData) then begin
    PrepareCache;
    DC := GetWindowDC(CtrlHandle);
    SavedDC := SaveDC(DC);
    try
      BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, 3);
    finally
      RestoreDC(DC, SavedDC);
      ReleaseDC(CtrlHandle, DC);
    end;
  end;
end;


procedure TacSearchWnd.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_Transparent;

  inherited;
end;

procedure TacSearchWnd.PrepareCache;
begin
  InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
  if SkinData.BGChanged then begin
    GetClientRect(CtrlHandle, ClientRect);
    acSBUtils.PrepareCache(SkinData, CtrlHandle, False);
    UpdateWndCorners(SkinData, 0, Self);
    SkinData.BGChanged := False;
  end;
end;


procedure TacStaticTextWnd.AC_WMNCPaint(aDC: hdc = 0);
var
  DC: hdc;
  w: integer;
  ClRect: TRect;
begin
  if not InUpdating(SkinData) then begin
    GetWindowRect(CtrlHandle, WndRect);
    GetClientRect(CtrlHandle, ClRect);
    WndSize.cx := WidthOf(WndRect);
    WndSize.cy := HeightOf(WndRect);
    if aDC = 0 then
      DC := GetWindowDC(CtrlHandle)
    else
      DC := aDC;

    try
      if not PrepareCache then begin
        SkinData.Updating := True;
        Exit;
      end;
      w := (WidthOf(WndRect) - WidthOf(ClRect)) div 2;
      if w > 0 then
        BitBltBorder(DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, 0, 0, w);
    finally
      if aDC = 0 then
        ReleaseDC(CtrlHandle, DC);
    end
  end;
end;


procedure TacStaticTextWnd.AC_WMPaint(aDC: hdc);
var
  w: integer;
  b: boolean;
  R, ClRect: TRect;
  DC, SaveIndex: HDC;
  Panel: TacAccessPanel;
begin
  Panel := TacAccessPanel(SkinData.FOwnerControl);
  if not (csDestroying in Panel.ComponentState) then begin
    if (Panel.Parent <> nil) and (csCreating in Panel.Parent.ControlState) then
      Exit;

    if not InUpdating(SkinData) then begin
      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      if aDC = 0 then
        DC := GetWindowDC(Panel.Handle)
      else
        DC := aDC;

      SaveIndex := SaveDC(DC);
      try
        // If transparent and form resizing processed
        b := SkinData.HalfVisible or SkinData.BGChanged;
        if SkinData.RepaintIfMoved then begin
          GetClipBox(DC, R);
          SkinData.HalfVisible := (WidthOf(R) <> Panel.Width) or (HeightOf(R) <> Panel.Height)
        end
        else
          SkinData.HalfVisible := False;

        if b then
          PrepareCache;

        GetClientRect(CtrlHandle, ClRect);
        w := (WidthOf(WndRect) - WidthOf(ClRect)) div 2;
        CopyWinControlCache(Panel, SkinData, Rect(w, w, 0, 0), MkRect(Panel.Width - 2 * w, Panel.Height - 2 * w), DC, True);
        sVCLUtils.PaintControls(DC, Panel, b and SkinData.RepaintIfMoved, MkPoint);
        SetParentUpdated(Panel);
      finally
        RestoreDC(DC, SaveIndex);
        if aDC = 0 then
          ReleaseDC(Panel.Handle, DC);
      end;
    end;
  end;
end;


procedure TacStaticTextWnd.acWndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  M: TMessage;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if SkinData.FOwnerControl <> nil then begin
    if Message.Msg = SM_ALPHACMD then
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit
        end; // AlphaSkins supported

        AC_GETAPPLICATION: begin
          Message.Result := LRESULT(Application);
          Exit
        end;

        AC_SETNEWSKIN, AC_REFRESH: begin
          inherited;
          AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, Message);
          Exit;
        end;

        AC_REMOVESKIN: begin
          SkinData.SkinIndex := -1;
          SkinData.FOwnerControl.ControlStyle := SkinData.FOwnerControl.ControlStyle - [csOpaque];
          inherited;
          Exit;
        end;

        AC_PREPARECACHE:
          PrepareCache;

{        AC_ENDPARENTUPDATE: begin
          if SkinData.FUpdating then begin
            SkinData.Updating := False;
            RedrawWindow(CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ERASE)
          end;
          if SkinData.FOwnerControl <> nil then
            SetParentUpdated(TWinControl(SkinData.FOwnerControl));

          Exit;
        end;                 }
      end
    else
      if Assigned(SkinData) and SkinData.Skinned then
        case Message.Msg of
          CM_ENABLEDCHANGED: begin
            ProcessMessage(WM_SETREDRAW, 0, 0);
            inherited;
            ProcessMessage(WM_SETREDRAW, 1, 0);
            InvalidateRect(CtrlHandle, nil, True);
            Exit;
          end;

          WM_PAINT: begin
            InvalidateRect(CtrlHandle, nil, True);
            BeginPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
            EndPaint(CtrlHandle, {$IFDEF FPC}@ps{$ELSE}ps{$ENDIF});
            Exit;
          end;

          WM_NCPAINT: begin
            AC_WMNCPaint;
            Message.Result := 0;
            Exit;
          end;

          WM_ERASEBKGND: begin
            AC_WMPaint(TWMPaint(Message).DC);
            Message.Result := ERASE_OK;
            Exit;
          end;

          WM_UPDATEUISTATE: begin
            Message.Result := 1;
            Exit;
          end;

          WM_PRINT: begin
            AC_WMPaint(TWMPaint(Message).DC);
            AC_WMNCPaint(TWMPaint(Message).DC);
            Exit;
          end;

          CM_SHOWINGCHANGED:
            if SkinData.FOwnerControl.Visible then begin
              AddToAdapter(TWinControl(SkinData.FOwnerControl));
              M := MakeMessage(SM_ALPHACMD, AC_SETNEWSKIN_HI, Longint(SkinData.SkinManager), 0);
              AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, M);
              M := MakeMessage(SM_ALPHACMD, AC_REFRESH_HI, Longint(SkinData.SkinManager), 0);
              AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, M);
            end;

          WM_PARENTNOTIFY:
            case Message.WParamLo of
              WM_CREATE, WM_DESTROY: begin
                inherited;
                if Message.WParamLo = WM_CREATE then
                  AddToAdapter(TWinControl(SkinData.FOwnerControl));

                Exit;
              end;
            end;

          CM_TEXTCHANGED:
            SkinData.BGChanged := True;

          WM_WINDOWPOSCHANGED, WM_WINDOWPOSCHANGING:
            if SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Transparency <> 0 then
              SkinData.BGChanged := True;

          WM_SETTEXT:
            if IsWindowVisible(CtrlHandle) then begin
              ProcessMessage(WM_SETREDRAW, 0, 0);
              inherited;
              ProcessMessage(WM_SETREDRAW, 1, 0);
              SkinData.BGChanged := True;
              SendMessage(CtrlHandle, WM_PAINT, 0, 0);
              Exit;
            end;
        end;
  end;
  inherited;
  case Message.Msg of
    WM_WINDOWPOSCHANGING:
      SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);
  end;
end;


function TacStaticTextWnd.PrepareCache: boolean;
var
  R: TRect;
  CI: TCacheInfo;
  Panel: TacAccessPanel;
begin
  Panel := TacAccessPanel(SkinData.FOwnerControl);
  InitCacheBmp(SkinData);
  CI := GetParentCache(SkinData);
  if not CI.Ready and (CI.FillColor = clFuchsia) then begin
    SkinData.Updating := True;
    Result := False;
  end
  else begin
    Result := True;
    if SkinData.CustomColor then
      FillDC(SkinData.FCacheBmp.Canvas.Handle, MkRect(Control), TStaticText(Control).Color)
    else
      PaintItem(SkinData, CI, False, 0, MkRect(Panel), MkPoint(Panel), SkinData.FCacheBMP, False);

    R := Panel.ClientRect;
    SkinData.FCacheBmp.Canvas.Brush.Style := bsClear;
    WriteText(R, SkinData.FCacheBmp.Canvas);
    SkinData.BGChanged := False;
  end;
end;


procedure TacStaticTextWnd.WriteText(R: TRect; aCanvas: TCanvas);
const
  Alignments: array [0..2] of TAlignment = (taLeftJustify, taRightJustify, taCenter);
var
  Flags: Cardinal;
  Alignment: integer;
begin
  if Control <> nil then
    aCanvas.Font.Assign(TAccessWinControl(Control).Font);

  aCanvas.Brush.Style := bsClear;
  if Control <> nil then begin
    Alignment := GetOrdProp(Control, 'Alignment');
    Flags := GetStringFlags(Control, Alignments[Alignment]) or DT_WORDBREAK;
  end
  else
    Flags := DT_CENTER;

  if SkinData.FOwnerControl <> nil then
    acWriteTextEx(aCanvas, PacChar(Caption), Control.Enabled, R, Flags, SkinData, False)
  else
    acWriteTextEx(aCanvas, PacChar(Caption), True, R, DT_CENTER or DT_VCENTER, SkinData, False);
end;


procedure TacStaticTextWnd.AfterCreation;
var
  b: boolean;
begin
  with SkinData do
    if FOwnerControl <> nil then begin
      b := FUpdating;
      Updating := True;
      Control := TWinControl(FOwnerControl);
      if SkinSection = '' then
{$IFNDEF FPC}
        with TAccessWinControl(FOwnerControl) do
          if BevelKind <> bkNone then
            case BevelOuter of // If not custom SkinSection
              bvRaised:  SkinSection := iff(BevelInner = bvLowered, s_GroupBox, s_Panel);
              bvLowered: SkinSection := iff(BevelInner = bvRaised, s_GroupBox, s_PanelLow);
              else       SkinSection := s_Transparent
            end
{$ENDIF}
          else
            if (FOwnerControl is TStaticText) and (TStaticText(FOwnerControl).BorderStyle <> sbsNone) then
              SkinSection := s_GroupBox
            else
              SkinSection := s_Transparent;

      SkinData.Updating := b;
    end
    else
      Control := nil;

  inherited;
end;


constructor TacScrollBar.Create;
begin
  fButVisibleBefore := False;
  fButVisibleAfter := False;
  nButSizeBefore := 0;
  nButSizeAfter := 0;
end;


procedure TacScrollWnd.InitSkinData;
begin
  cxLeftEdge := -1;
  ScrollsInitialized := False;
  SkinData := TsScrollWndData.Create(nil);
  SkinData.Loading := True;
end;


procedure TacNativePaint.acWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_PAINT, WM_ERASEBKGND://, WM_NCPAINT:
      CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);

    SM_ALPHACMD:
      case Message.WParamHi of
        AC_PREPARECACHE: begin
          Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
          if SkinData.BGChanged {and not InUpdating(SkinData) }then begin
            InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
            PrepareCache;//(SkinData, CtrlHandle, DlgMode);
            UpdateWndCorners(SkinData, 0, Self);
          end;
          Exit;
        end

        else
          inherited;
      end

    else
      inherited;
  end;
end;


procedure TacNativePaint.AfterCreation;
begin
  if SkinData.SkinSection = '' then
    SkinData.SkinSection := s_Transparent;

  inherited;
end;


function TacSplitBtnWnd.ArrowRect: TRect;
begin
  Result := MkRect(SkinData.FCacheBmp);
  Result.Left := Result.Right - ArrowWidth * 2 - 6;
end;


function TacSplitBtnWnd.CaptionRect: TRect;
begin
  ArrowWidth := 8;
  Result := inherited CaptionRect;
  OffsetRect(Result, -ArrowWidth, 0);
end;


procedure TacSplitBtnWnd.PrepareCache;
var
  R: TRect;
  C: TColor;
begin
  inherited;
  R := ArrowRect;
  C := SkinManager.gd[SkinData.SkinIndex].Props[min(CurrentState, ac_MaxPropsIndex)].FontColor.Color;
  DrawColorArrow(SkinData.FCacheBmp, C, R, asBottom);
end;


initialization
  huser32 := LoadLibrary(user32);
  if huser32 <> 0 then
    Ac_GetScrollBarInfo := GetProcAddress(huser32, 'GetScrollBarInfo');

  hcomctl32 := LoadLibrary(comctl32);
  if hcomctl32 <> 0 then begin
    Ac_UninitializeFlatSB := GetProcAddress(hcomctl32, 'UninitializeFlatSB');
    Ac_InitializeFlatSB   := GetProcAddress(hcomctl32, 'InitializeFlatSB');
  end;


finalization
  ClearMnuArray;    
  if huser32 <> 0 then
    FreeLibrary(huser32);

  if hcomctl32 <> 0 then
    FreeLibrary(hcomctl32);
    
  if ServWndList <> nil then begin
    while ServWndList.Count > 0 do begin
      TObject(ServWndList[0]).Free;
      ServWndList.Delete(0);
    end;
    FreeAndNil(ServWndList);
    FreeAndNil(acSupportedList);
  end;

end.


