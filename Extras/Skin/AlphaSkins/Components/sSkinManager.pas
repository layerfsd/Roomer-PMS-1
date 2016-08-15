unit sSkinManager;
{$I sDefs.inc}
// {$DEFINE LOGGED}
// {$DEFINE DEBUGOBJ}
//+
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, IniFiles, menus, ExtCtrls,
  {$IFDEF  DELPHI_XE2} UITypes,    {$ENDIF}
  {$IFNDEF DELPHI5}    Types,      {$ENDIF}
  {$IFDEF  LOGGED}     sDebugMsgs, {$ENDIF}
  {$IFDEF  FPC}        LMessages,  {$ENDIF}
  sConst, sMaskData, sSkinMenus, sStyleSimply, sDefaults, acntUtils;


{$IFNDEF NOTFORHELP}
const
  acCurrentVersion = '11.12';

{$R sXB.res}   // Default ext borders
{$R sOEff.res} // Default outer masks

const
  iMaxFileSize = 30000;
{$ENDIF}


type
{$IFNDEF NOTFORHELP}
  TacSkinListData = record
    skName: string;
    skImageIndex: integer;
  end;

  TacSkinData = packed record // Data for exchange with SkinEditor
    Magic:    integer;
    SkinName: array [0..127] of AnsiChar;
    SkinDir:  array [0..511] of AnsiChar;
    Data:     array [0..iMaxFileSize] of AnsiChar;
  end;
  PacSkinData = ^TacSkinData;


  TacSkinTypes = (stUnpacked, stPacked, stAllSkins);
  TacSkinPlaces = (spInternal, spExternal, spAllPlaces);
  TacScaleMode = (sm100, sm125, sm150, smAuto, smOldMode);

  TacMenuItemData = record
    Font: TFont;
  end;

  TacSysDlgData = record
    WindowHandle: THandle;
  end;

  TacGetExtraLineData = procedure (FirstItem: TMenuItem; var SkinSection: string; var Caption: string; var Glyph: TBitmap; var LineVisible: boolean) of object;
  TacSysDlgInit       = procedure (DlgData: TacSysDlgData; var AllowSkinning: boolean) of object;
  TacGetPopupItemData = procedure (Item: TMenuItem; State: TOwnerDrawState; ItemData: TacMenuItemData) of object;

  TacExtFileData = record
    Bmp: TBitmap;
    FileName: string;
    MaskType: integer;
  end;

  TacExtArray = array of TacExtFileData;


  TBitmap = Graphics.TBitmap;
  TsSkinManager = class;
  TsStoredSkin = class;
  TacSkinInfo = type string;


  TacSkinEffects = class(TPersistent)
  private
    FAllowGlowing,
    FAllowAnimation,
    FAllowAeroBluring,
    FDiscoloredGlyphs,
    FAllowOuterEffects: boolean;
    procedure SetDiscoloredGlyphs (const Value: boolean);
    procedure SetAllowOuterEffects(const Value: boolean);
  public
    Manager: TsSkinManager;
    constructor Create;
  published
    property AllowAnimation:    boolean read FAllowAnimation    write FAllowAnimation      default True;
    property AllowAeroBluring:  boolean read FAllowAeroBluring  write FAllowAeroBluring    default True;
    property AllowGlowing:      boolean read FAllowGlowing      write FAllowGlowing        default True;
    property AllowOuterEffects: boolean read FAllowOuterEffects write SetAllowOuterEffects default False;
    property DiscoloredGlyphs:  boolean read FDiscoloredGlyphs  write SetDiscoloredGlyphs  default False;
  end;


  TacBtnEffects = class(TPersistent)
  private
    FEvents: TacBtnEvents;
  public
    constructor Create;
  published
    property Events: TacBtnEvents read FEvents write FEvents default [beMouseEnter, beMouseLeave, beMouseDown, beMouseUp];
  end;


  TacFormAnimation = class(TPersistent)
  private
    FTime: word;
    FActive: boolean;
    FMode: TacAnimType;
  public
    constructor Create; virtual;
    property Mode: TacAnimType read FMode write FMode default atAero;
  published
    property Active: boolean read FActive write FActive default True;
    property Time: word read FTime write FTime default 0;
  end;


  TacBlendOnMoving = class(TacFormAnimation)
  private
    FBlendValue: byte;
  public
    constructor Create; override;
  published
    property Active default False;
    property BlendValue: byte read FBlendValue write FBlendValue default 170;
    property Time default 1000;
  end;


  TacMinimizing = class(TacFormAnimation)
  public
    constructor Create; override;
  published
    property Time default 120;
  end;


  TacFormShow = class(TacFormAnimation)
  published
    property Mode;
  end;


  TacFormHide = class(TacFormAnimation)
  published
    property Mode;
  end;


  TacPageChange = class(TacFormAnimation);


  TacDialogShow = class(TacFormAnimation)
  public
    constructor Create; override;
  published
    property Time default 0;
    property Mode;
  end;


  TacSkinChanging = class(TacFormAnimation)
  public
    constructor Create; override;
  published
    property Time default 100;
    property Mode default atFading;
  end;


  TacAnimEffects = class(TPersistent)
  private
    FFormHide,
    FDialogHide: TacFormHide;

    FFormShow:      TacFormShow;
    FButtons:       TacBtnEffects;
    FPageChange:    TacPageChange;
    FMinimizing:    TacMinimizing;
    FDialogShow:    TacDialogShow;
    FSkinChanging:  TacSkinChanging;
    FBlendOnMoving: TacBlendOnMoving;
  public
    Manager: TsSkinManager;
    constructor Create;
    destructor Destroy; override;
  published
    property BlendOnMoving: TacBlendOnMoving read FBlendOnMoving write FBlendOnMoving;
    property Buttons:       TacBtnEffects    read FButtons       write FButtons;
    property DialogShow:    TacDialogShow    read FDialogShow    write FDialogShow;
    property FormShow:      TacFormShow      read FFormShow      write FFormShow;
    property FormHide:      TacFormHide      read FFormHide      write FFormHide;
    property DialogHide:    TacFormHide      read FDialogHide    write FDialogHide;
    property Minimizing:    TacMinimizing    read FMinimizing    write FMinimizing;
    property PageChange:    TacPageChange    read FPageChange    write FPageChange;
    property SkinChanging:  TacSkinChanging  read FSkinChanging  write FSkinChanging;
  end;


  TsStoredSkin = class(TCollectionItem)
  private
    FName,
    FAuthor,
    FDescription: string;

    FShadow1Blur,
    FShadow1Offset,
    FShadow1Transparency: integer;

    FBorderColor,
    FShadow1Color: TColor;

    FVersion: real;
    FMasterBitmap: TBitmap;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadData (Reader: TStream);
    procedure WriteData(Writer: TStream);
  public
    PackedData: TMemoryStream;
    procedure Assign(Source: TPersistent); override;
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Name: string read FName write FName;
    property MasterBitmap: TBitmap read FMasterBitmap write FMasterBitmap;

    property Shadow1Color: TColor read FShadow1Color write FShadow1Color;
    property Shadow1Offset: integer read FShadow1Offset write FShadow1Offset;
    property Shadow1Blur: integer read FShadow1Blur write FShadow1Blur default -1;
    property Shadow1Transparency: integer read FShadow1Transparency write FShadow1Transparency;

    property BorderColor: TColor read FBorderColor write FBorderColor default clFuchsia;

    property Version: real read FVersion write FVersion;
    property Author:      string read FAuthor      write FAuthor;
    property Description: string read FDescription write FDescription;
  end;


  TsStoredSkins = class(TCollection)
  private
    FOwner: TsSkinManager;
    function  GetItem(Index: Integer): TsStoredSkin;
    procedure SetItem(Index: Integer; Value: TsStoredSkin);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TsSkinManager);
    destructor Destroy; override;
    property Items[Index: Integer]: TsStoredSkin read GetItem write SetItem; default;
    function IndexOf(const SkinName: string): integer;
  end;


  ThirdPartyList = class(TPersistent)
  private
    FThirdEdits,
    FThirdButtons,
    FThirdBitBtns,
    FThirdCheckBoxes,
    FThirdGroupBoxes,
    FThirdListViews,
    FThirdPanels,
    FThirdGrids,
    FThirdTreeViews,
    FThirdComboBoxes,
    FThirdWWEdits,
    FThirdVirtualTrees,
    FThirdGridEh,
    FThirdPageControl,
    FThirdTabControl,
    FThirdToolBar,
    FThirdStatusBar,
    FThirdSpeedButton,
    FThirdScrollControl,
    FThirdUpDownBtn,
{$IFDEF ADDWEBBROWSER}
    FThirdWebBrowser,
{$ENDIF}
    FThirdScrollBar,
    FThirdStaticText,
    FThirdNativePaint: string;
  public
    // These functions used in the LoadThirdParty and other procedures
    function  GetString(const Index: Integer): string;
    procedure SetString(const Index: Integer; const Value: string);
  published
    property ThirdEdits        : string index ord(tpEdit         ) read GetString write SetString;
    property ThirdButtons      : string index ord(tpButton       ) read GetString write SetString;
    property ThirdBitBtns      : string index ord(tpBitBtn       ) read GetString write SetString;
    property ThirdCheckBoxes   : string index ord(tpCheckBox     ) read GetString write SetString;
    property ThirdGroupBoxes   : string index ord(tpGroupBox     ) read GetString write SetString;
    property ThirdListViews    : string index ord(tpListView     ) read GetString write SetString;
    property ThirdPanels       : string index ord(tpPanel        ) read GetString write SetString;
    property ThirdGrids        : string index ord(tpGrid         ) read GetString write SetString;
    property ThirdTreeViews    : string index ord(tpTreeView     ) read GetString write SetString;
    property ThirdComboBoxes   : string index ord(tpComboBox     ) read GetString write SetString;
    property ThirdWWEdits      : string index ord(tpWWEdit       ) read GetString write SetString;
    property ThirdVirtualTrees : string index ord(tpVirtualTree  ) read GetString write SetString;
    property ThirdGridEh       : string index ord(tpGridEh       ) read GetString write SetString;
    property ThirdPageControl  : string index ord(tpPageControl  ) read GetString write SetString;
    property ThirdTabControl   : string index ord(tpTabControl   ) read GetString write SetString;
    property ThirdToolBar      : string index ord(tpToolBar      ) read GetString write SetString;
    property ThirdStatusBar    : string index ord(tpStatusBar    ) read GetString write SetString;
    property ThirdSpeedButton  : string index ord(tpSpeedButton  ) read GetString write SetString;
    property ThirdScrollControl: string index ord(tpScrollControl) read GetString write SetString;
    property ThirdUpDown       : string index ord(tpUpDownBtn    ) read GetString write SetString;
    property ThirdScrollBar    : string index ord(tpScrollBar    ) read GetString write SetString;
    property ThirdStaticText   : string index ord(tpStaticText   ) read GetString write SetString;
    property ThirdNativePaint  : string index ord(tpNativePaint  ) read GetString write SetString;
{$IFDEF ADDWEBBROWSER}
    property ThirdWebBrowser   : string index ord(tpWebBrowser   ) read GetString write SetString;
{$ENDIF}
  end;


  TacSkinningRule = (srStdForms, srStdDialogs, srThirdParty);
  TacSkinningRules = set of TacSkinningRule;

  TacPaletteColors = (pcMainColor, pcLabelText, pcWebText, pcWebTextHot, pcEditText, pcEditBG,
    pcSelectionBG, pcSelectionText, pcSelectionBG_Focused, pcSelectionText_Focused,
    pcEditBG_Inverted, pcEditText_Inverted, pcEditBG_OddRow, pcEditBG_EvenRow, // Reserved
    pcEditText_Ok, pcEditText_Warning, pcEditText_Alert, pcEditText_Caution, pcEditText_Bypassed,
    pcEditBG_Ok, pcEditBG_Warning, pcEditBG_Alert, pcEditBG_Caution, pcEditBG_Bypassed,
    pcEditText_Highlight1, pcEditText_Highlight2, pcEditText_Highlight3, // Reserved
    pcBorder, pcHintBG, pcHintText);

  TacPaletteArray = array [TacPaletteColors] of TColor;

  TacBrushes = array [pcEditBG..pcEditBG] of HBRUSH;

  TacScrollBarsSupport = class(TPersistent)
  private
    FScrollSize,
    FButtonsSize: integer;

    FOwner: TsSkinManager;
    procedure SetScrollSize (const Value: integer);
    procedure SetButtonsSize(const Value: integer);
  public
    constructor Create(AOwner: TsSkinManager);
  published
    property ScrollSize:  integer read FScrollSize  write SetScrollSize  default -1;
    property ButtonsSize: integer read FButtonsSize write SetButtonsSize default -1;
  end;


  TacButtonsSupport = class(TPersistent)
  private
    FShowFocusRect,
    FShiftContentOnClick: boolean;
  public
    constructor Create(AOwner: TsSkinManager);
  published
    property ShowFocusRect:       boolean read FShowFocusRect       write FShowFocusRect       default True;
    property ShiftContentOnClick: boolean read FShiftContentOnClick write FShiftContentOnClick default True;
  end;


  TacLabelsSupport = class(TPersistent)
  private
    FTransparentAlways: boolean;
  public
    constructor Create(AOwner: TsSkinManager);
  published
    property TransparentAlways: boolean read FTransparentAlways write FTransparentAlways default True;
  end;


  TacOptions = class(TPersistent)
  private
    FNoMouseHover,
    FStdGlyphsOrder,
    FCheckEmptyAlpha,
    FChangeSysColors,
    FNativeBordersMaximized: boolean;

    FOwner: TsSkinManager;
    FScaleMode: TacScaleMode;
    FOptimizingPriority: TacOptimizingPriority;
    function  GetBool(const Index: Integer): boolean;
    procedure SetBool(const Index: Integer; const Value: boolean);
    procedure SetScaleMode(const Value: TacScaleMode);
  public
    constructor Create(AOwner: TsSkinManager);
  published
    property NoMouseHover           : boolean index 1 read GetBool write SetBool default False;
    property StdGlyphsOrder         : boolean index 3 read GetBool write SetBool default False;
    property ChangeSysColors        : boolean index 4 read GetBool write SetBool default False;
    property CheckEmptyAlpha        : boolean index 0 read GetBool write SetBool default False;
    property NativeBordersMaximized : boolean index 2 read GetBool write SetBool default False;
    property ScaleMode: TacScaleMode read FScaleMode write SetScaleMode default smOldMode;
    property OptimizingPriority: TacOptimizingPriority read FOptimizingPriority write FOptimizingPriority default opSpeed;
  end;


  TacSkinListController = class(TObject)
  public
    SkinManager: TsSkinManager;
    Timer: TTimer;
    ImgList: TImageList;
    SkinList: array of TacSkinListData;
    Controls: array of TControl;
    procedure SendSkinChanged;
    procedure SendListChanged;
    procedure UpdateData(UpdateNow: boolean = False);
    constructor Create(AOwner: TsSkinManager);
    function CtrlIndex(Ctrl: TControl): integer;
    procedure AddControl(Ctrl: TControl);
    procedure DelControl(Ctrl: TControl);
    destructor Destroy; override;
  end;


  TacImageItem = record
    FileName: string;
    IsBitmap: boolean;
    FileStream: TMemoryStream;
  end;

  TacImageItems = array of TacImageItem;


  TScaleChangeData = record
    OldScaleMode: TacScaleMode;
    NewScaleMode: TacScaleMode;
    OldScalePercent: integer;
    NewScalePercent: integer;
  end;

  TScaleChangeEvent = procedure (Sended: TObject; ScaleChangeData: TScaleChangeData) of object;


  TacSkinConvertor = class(TPersistent)
  public
    Options,
    PackedData: TMemoryStream;
    ImageCount: integer;
    Files: TacImageItems;
    procedure Clear;
    destructor Destroy; override;
  end;

  TsCharArray = array [1..16] of AnsiChar;
{$ENDIF} // NOTFORHELP

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsSkinManager = class(TComponent)
  private
{$IFNDEF NOTFORHELP}
    FActive,
    FSkinnedPopups,
    FExtendedBorders,
    GlobalHookInstalled: boolean;

    FOnActivate,
    FOnDeactivate,
    FOnSkinLoading,
    FOnAfterChange,
    FOnBeforeChange,
    FOnSkinListChanged: TNotifyEvent;

    FKeyList,
    FCommonSections: TStringList;

    FSkinName: TsSkinName;
    FSkinDirectory: TsDirectory;
    FBuiltInSkins: TsStoredSkins;
    FOptions: TacOptions;
    ExtArray: TacExtArray;
    FGroupIndex: integer;
    FMenuSupport: TacMenuSupport;
    FAnimEffects: TacAnimEffects;
    FActiveControl: hwnd;
    FSkinningRules: TacSkinningRules;
    FThirdParty: ThirdPartyList;
    FEffects: TacSkinEffects;
    FScrollsOptions: TacScrollBarsSupport;
    FButtonsSupport: TacButtonsSupport;
    FLabelsSupport: TacLabelsSupport;

    FOnGetPopupLineData: TacGetExtraLineData;
    FOnGetPopupItemData: TacGetPopupItemData;
    FOnSysDlgInit: TacSysDlgInit;
    FOnScaleModeChange: TScaleChangeEvent;
{$IFNDEF FPC}
    FSkinableMenus: TsSkinableMenus;
{$ENDIF}
    procedure ClearExtArray;
    function SearchExtFile(s: string): TBitmap;
{$IFNDEF FPC}
    procedure SetSkinnedPopups(const Value: boolean);
{$ENDIF}
    function GetVersion: string;
    function GetSkinInfo: TacSkinInfo;
    procedure UpdateCurrentSkin;
    function GetIsDefault: boolean;
    function MainWindowHook(var Message: TMessage): boolean;
    function GetExtendedBorders: boolean;

    procedure SetActiveControl      (const Value: hwnd);
    procedure SetSkinDirectory      (const Value: string);
    procedure SetActive             (const Value: boolean);
    procedure SetVersion            (const Value: string);
    procedure SetHueOffset          (const Value: integer);
    procedure SetBrightness         (const Value: integer);
    procedure SetSaturation         (const Value: integer);
    procedure SetIsDefault          (const Value: boolean);
    procedure SetExtendedBorders    (const Value: boolean);
    procedure SetSkinName           (const Value: TsSkinName);
    procedure SetSkinInfo           (const Value: TacSkinInfo);
    procedure SetKeyList            (const Value: TStringList);
    procedure SetBuiltInSkins       (const Value: TsStoredSkins);
    procedure SetActiveGraphControl (const Value: TGraphicControl);
    procedure SetFSkinningRules     (const Value: TacSkinningRules);
    procedure SetCommonSections     (const Value: TStringList);
  protected
    FActiveGraphControl: TGraphicControl;
{$IFNDEF DELPHI2005}
    TimerCheckHot: TTimer;
    procedure OnCheckHot(Sender: TObject);
{$ENDIF}
    procedure SendNewSkin(Repaint: boolean = True);
    procedure SendRemoveSkin;
    procedure FreeBitmaps;
{$ENDIF} // NOTFORHELP
  public
    NoAutoUpdate: boolean;
    ShowState: TShowAction;
    PreviewBuffer: TacSkinData;
    CommonSkinData: TsSkinData;
{$IFNDEF NOTFORHELP}
    SkinIsPacked,
    SkinRemoving: boolean;

    MasterBitmap,
    ShdaTemplate,
    ShdiTemplate: TBitmap;

    FHueOffset,
    FSaturation,
{$IFNDEF NOFONTSCALEPATCH}
    SysFontScale, // 0 - Small, 1 - Medium, 2 - Big
{$ENDIF}
    FBrightness: integer;

    ma: TsMaskArray;
    gd: TsGeneralDataArray;
    oe: TacOutEffArray;
    ConstData: TConstantSkinData;
    FormShadowSize: TRect;
    ThirdLists: TStringLists;
    Palette: TacPaletteArray;
    Brushes: TacBrushes;
    SkinListController: TacSkinListController;
    // Skin loading
    procedure LoadAllMasks;
    procedure InitMaskIndexes;
    procedure LoadAllGeneralData;
    function MakeNewItem(SkinIndex: integer; const PropertyName, AClassName: string; ImgType: TacImgType; R: TRect; Count, DrawMode: integer; Masktype: smallint): integer;
    procedure InitConstantIndexes;
    procedure ReloadSkin;
    procedure ReloadPackedSkin;
    procedure CheckVersion;
    procedure CheckShadows;
    // Getting info
    function GetScale: integer;
    function GetSkinNames        (sl: TacStrings; SkinType: TacSkinTypes = stAllSkins): acString;
    function GetExternalSkinNames(sl: TacStrings; SkinType: TacSkinTypes = stAllSkins): acString;
    function GetFullSkinDirectory: string;
    function GetRandomSkin: acString;
    // Getting current skin info
    function GetSkinIndex(const SkinSection: string): integer;
    function GetMaskIndex(const SkinSection, mask: string): integer; overload;
    function GetMaskIndex(const SkinIndex: integer; mask: string): integer; overload;
    function GetMaskIndex(const SkinIndex: integer; const SkinSection, mask: string): integer; overload;
    function GetTextureIndex(aSkinIndex: integer; const SkinSection, PropName: string): integer; overload;
    function GetTextureIndex(aSkinIndex: integer; const PropName: string): integer; overload;
    procedure GetSkinSections(sl: TStrings);
(*
    function MaskWidthTop    (MaskIndex: integer): integer; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
    function MaskWidthLeft   (MaskIndex: integer): integer; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
    function MaskWidthBottom (MaskIndex: integer): integer; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
    function MaskWidthRight  (MaskIndex: integer): integer; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
*)
    function IsValidSkinIndex(SkinIndex: integer): boolean;
    function IsValidImgIndex(ImageIndex: integer): boolean;
    // Getting colors
    function GetGlobalColor:         TColor;
    function GetGlobalFontColor:     TColor;
    function GetActiveEditColor:     TColor;
    function GetActiveEditFontColor: TColor;
    function GetHighLightColor    (Focused: boolean = True): TColor;
    function GetHighLightFontColor(Focused: boolean = True): TColor;
    // Updating
    procedure BeginUpdate;
    procedure EndUpdate(Repaint: boolean = False; AllowAnimation: boolean = True);
    function ScaleInt(Value: integer; SysScale: integer = 0): integer;
    procedure RepaintForms(DoLockForms: boolean = True);
    procedure UpdateSkin(Repaint: boolean = True);
    procedure UpdateSkinSection(const SectionName: string);
    procedure UpdateScale(Ctrl: TWinControl; iCurrentScale: integer = 100);
    procedure UpdateAllScale;
    // Hooks
    procedure InstallHook;
    procedure UnInstallHook;
    // Other routines
    procedure ExtractInternalSkin(const NameOfSkin, DestDir: string);
    procedure ExtractByIndex(Index: integer; const DestDir: string);
    // Inherited
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Loaded; override;
    // Properties
    property GroupIndex: integer read FGroupIndex write FGroupIndex;
{$IFNDEF FPC}
    property SkinableMenus: TsSkinableMenus read FSkinableMenus write FSkinableMenus;
{$ENDIF}
    property ActiveControl: hwnd read FActiveControl write SetActiveControl;
    property ActiveGraphControl: TGraphicControl read FActiveGraphControl write SetActiveGraphControl;
{$ENDIF} // NOTFORHELP
  published
    property OnScaleModeChange: TScaleChangeEvent read FOnScaleModeChange write FOnScaleModeChange; // Declare before the Options property

    property Effects: TacSkinEffects read FEffects write FEffects;
    property ExtendedBorders: boolean read GetExtendedBorders write SetExtendedBorders default False;
{$IFNDEF FPC}
    property SkinnedPopups: boolean read FSkinnedPopups write SetSkinnedPopups default True;
{$ENDIF}
    property AnimEffects: TacAnimEffects read FAnimEffects write FAnimEffects;
    property ButtonsOptions: TacButtonsSupport read FButtonsSupport write FButtonsSupport;
    property IsDefault: boolean read GetIsDefault write SetIsDefault default True;
    property Active: boolean read FActive write SetActive default True;
    property CommonSections: TStringList read FCommonSections write SetCommonSections;
    property Brightness: integer read FBrightness write SetBrightness default 0;
    property Saturation: integer read FSaturation write SetSaturation default 0;
    property HueOffset: integer read FHueOffset write SetHueOffset default 0;
    property InternalSkins: TsStoredSkins read FBuiltInSkins write SetBuiltInSkins;
    property LabelsOptions: TacLabelsSupport read FLabelsSupport write FLabelsSupport;
    property MenuSupport: TacMenuSupport read FMenuSupport write FMenuSupport;
    property Options: TacOptions read FOptions write FOptions;
    property ScrollsOptions: TacScrollBarsSupport read FScrollsOptions write FScrollsOptions;
    property SkinDirectory: TsDirectory read FSkinDirectory write SetSkinDirectory;
    property KeyList: TStringList read FKeyList write SetKeyList;
    property SkinName: TsSkinName read FSkinName write SetSkinName;
    property SkinInfo: TacSkinInfo read GetSkinInfo write SetSkinInfo;
    property SkinningRules: TacSkinningRules read FSkinningRules write SetFSkinningRules default [srStdForms, srStdDialogs, srThirdParty];
    property ThirdParty: ThirdPartyList read FThirdParty write FThirdParty;
    property Version: string read GetVersion write SetVersion stored False;

    {:@event}
    property OnGetMenuExtraLineData: TacGetExtraLineData read FOnGetPopupLineData write FOnGetPopupLineData;
    {:@event}
    property OnGetPopupItemData: TacGetPopupItemData read FOnGetPopupItemData write FOnGetPopupItemData;
    {:@event}
    property OnSysDlgInit: TacSysDlgInit read FOnSysDlgInit write FOnSysDlgInit;

    property OnActivate:        TNotifyEvent read FOnActivate        write FOnActivate;
    property OnAfterChange:     TNotifyEvent read FOnAfterChange     write FOnAfterChange;
    property OnBeforeChange:    TNotifyEvent read FOnBeforeChange    write FOnBeforeChange;
    property OnDeactivate:      TNotifyEvent read FOnDeactivate      write FOnDeactivate;
    property OnSkinListChanged: TNotifyEvent read FOnSkinListChanged write FOnSkinListChanged;
    property OnSkinLoading:     TNotifyEvent read FOnSkinLoading     write FOnSkinLoading;
  end;


{$IFNDEF NOTFORHELP}
var
  IsNT: boolean;
  SkinFile: TMemIniFile;
  DefaultManager: TsSkinManager;
  UnPackedFirst: boolean = False;
  acMemSkinFile: TStringList;


function SysColorToSkin(const AColor: TColor; ASkinManager: TsSkinManager = nil): TColor;
{$IFDEF D2007}
procedure UpdateCommonDlgs(sManager: TsSkinManager);
{$ENDIF}
procedure UpdatePreview(Handle: HWND; Enabled: boolean);
function ChangeImageInSkin(const SkinSection, PropName, FileName: string; sm: TsSkinManager): boolean;
//procedure ChangeSkinBrightness(sManager: TsSkinManager; Value: integer);
function GetScrollSize     (sm: TsSkinManager): integer;
function GetComboBtnSize   (sm: TsSkinManager): integer;
procedure UpdateThirdNames (sm: TsSkinManager);
procedure LoadThirdNames   (sm: TsSkinManager; Overwrite: boolean = False);
procedure LoadSkinFromFile(const FileName: string; var Convertor: TacSkinConvertor; pwds: TStringList; SkinManager: TComponent);

{$IFNDEF DISABLEPREVIEWMODE}
procedure ReceiveData(SkinReceiver: TsSkinManager);
{$ENDIF}

function ExtractPackedData(var Convertor: TacSkinConvertor; pwds: TStringList; SkinManager: TComponent): boolean;
function GetPreviewStream(aStream: TMemoryStream; SkinFileName: string): boolean; overload;
function GetPreviewStream(aStream: TMemoryStream; SrcStream: TMemoryStream): boolean; overload;
function GetPreviewImage(aBitmap: TBitmap; SkinFileName: string): boolean;

{$IFNDEF DEBUGOBJ}
  {$IFDEF WIN64}
    {$l xdecode64.obj}
  {$ELSE}
    {$l xdecode32.obj}
  {$ENDIF}
function asSkinDecode(PackedData: TsCharArray; Keys: array of Int64; const Length, FormSum: integer; out FilesCount: integer; out Offset: integer): integer; cdecl; external;
{$ENDIF}

{$ENDIF} // NOTFORHELP
implementation


uses
  math, StdCtrls, ImgList,
{$IFDEF FPC}
  ZLibEx,
{$ELSE}
  {$IFNDEF WIN64}
    acZLibEx,
  {$ELSE}
    ZLib,
  {$ENDIF}
{$ENDIF}
{$IFDEF DEBUGOBJ}
  xdecode,
{$ENDIF}
{$IFNDEF ALITE}
  acPathDialog, acPopupController,
{$ENDIF}
  sMessages, acAlphaImageList, sVclUtils, sCommonData, acGlow, sThirdParty, sSkinProps, acDials, sGraphUtils,
  sGradient, sSkinProvider, sAlphaGraph;


var
  rsta: TBitmap = nil;
  rsti: TBitmap = nil;
  sc: TacSkinConvertor;
  OSVerInfo: TOSVersionInfo;
  ac_SetProcessDPIAware: function(): BOOL; stdcall;


const
  acTranspVer = 7.45;


function GetSkinVersion(sf: TMemIniFile): real;
var
  OldSeparator: char;
begin
  OldSeparator := {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator;
  {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator := s_Dot;
  Result := sf.ReadFloat(s_GlobalInfo, s_Version, 0);
  {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator := OldSeparator;
end;


{$IFNDEF DISABLEPREVIEWMODE}
procedure ReceiveData(SkinReceiver: TsSkinManager);
begin
  with SkinReceiver do
    if PreviewBuffer.Magic = ASE_MSG then begin
      UnPackedFirst := True; // Unpacked skins have the first priority

      BeginUpdate;
      acMemSkinFile := TStringList.Create;
      acMemSkinFile.Text := PreviewBuffer.Data;

      SkinDirectory := PreviewBuffer.SkinDir;
      SkinName := PreviewBuffer.SkinName;
      EndUpdate(True, False);

      FreeAndNil(acMemSkinFile);
    end;
end;
{$ENDIF}


procedure LoadSkinFromFile(const FileName: string; var Convertor: TacSkinConvertor; pwds: TStringList; SkinManager: TComponent);
begin
  if FileExists(FileName) then begin
    if Convertor = nil then
      Convertor := TacSkinConvertor.Create
    else
      Convertor.Clear;

    Convertor.PackedData := TMemoryStream.Create;
    Convertor.PackedData.LoadFromFile(FileName);
    Convertor.PackedData.Seek(0, 0);
    ExtractPackedData(Convertor, pwds, SkinManager);
    FreeAndnil(Convertor.PackedData);
  end;
end;


procedure UpdatePreview(Handle: HWND; Enabled: boolean);
var
  Policy: Longint;
begin
  if ac_ChangeThumbPreviews then begin
    Policy := integer(Enabled);
    if DwmSetWindowAttribute(Handle, 10{DWMWA_HAS_ICONIC_BITMAP}, @Policy, 4) = S_OK then
      DwmSetWindowAttribute(Handle, 7{DWMWA_FORCE_ICONIC_REPRESENTATION}, @Policy, 4);

    DwmInvalidateIconicBitmaps(Handle);
  end;
end;


function SysColorToSkin(const AColor: TColor; ASkinManager: TsSkinManager = nil): TColor;
{$IFNDEF DELPHI7UP}
const
  clHotLight                = TColor($FF000000 or 26);
  clGradientActiveCaption   = TColor($FF000000 or 27);
  clGradientInactiveCaption = TColor($FF000000 or 28);
  clMenuHighlight           = TColor($FF000000 or 29);
  clMenuBar                 = TColor($FF000000 or 30);
{$ENDIF}
begin
  if ASkinManager = nil then
    ASkinManager := DefaultManager;

  if (ASkinManager <> nil) and ASkinManager.CommonSkinData.Active then
    case AColor of
      clScrollBar, clBackground, clBtnFace, clAppWorkSpace, clMenu:
        Result := ASkinManager.Palette[pcMainColor];

      clWindow:
        Result := ASkinManager.Palette[pcEditBG];

      clWindowText:
        Result := ASkinManager.Palette[pcEditText];

      clInactiveBorder, clActiveBorder, cl3DLight, cl3DDkShadow, clBtnShadow, clWindowFrame:
        Result := ASkinManager.Palette[pcBorder];


      clGradientActiveCaption, clActiveCaption:
        if ASkinManager.ConstData.Sections[ssFormTitle] >= 0 then
          Result := ASkinManager.gd[ASkinManager.ConstData.Sections[ssFormTitle]].Props[1].Color
        else
          Result := ASkinManager.Palette[pcMainColor];

      clCaptionText:
        if ASkinManager.ConstData.Sections[ssFormTitle] >= 0 then
          Result := ASkinManager.gd[ASkinManager.ConstData.Sections[ssFormTitle]].Props[1].FontColor.Color
        else
          Result := ASkinManager.Palette[pcMainColor];

      clGradientInactiveCaption, clInactiveCaption:
        if ASkinManager.ConstData.Sections[ssFormTitle] >= 0 then
          Result := ASkinManager.gd[ASkinManager.ConstData.Sections[ssFormTitle]].Props[0].Color
        else
          Result := ASkinManager.Palette[pcMainColor];

      clInactiveCaptionText:
        if ASkinManager.ConstData.Sections[ssFormTitle] >= 0 then
          Result := ASkinManager.gd[ASkinManager.ConstData.Sections[ssFormTitle]].Props[0].FontColor.Color
        else
          Result := ASkinManager.Palette[pcMainColor];

      clMenuBar:
        Result := ASkinManager.Palette[pcMainColor];

      clMenuText:
        Result := ASkinManager.Palette[pcLabelText];

      clHighlight:
        Result := ASkinManager.Palette[pcSelectionBG_Focused];

      clHighlightText:
        Result := ASkinManager.Palette[pcSelectionText_Focused];

      clGrayText:
        Result := BlendColors(ASkinManager.Palette[pcMainColor], ASkinManager.Palette[pcLabelText], 127);

      clBtnText:
        if ASkinManager.ConstData.Sections[ssButton] >= 0 then
          Result := ASkinManager.gd[ASkinManager.ConstData.Sections[ssButton]].Props[0].FontColor.Color
        else
          Result := ASkinManager.Palette[pcMainColor];

      clBtnHighlight:
        if ASkinManager.ConstData.Sections[ssButton] >= 0 then
          Result := ASkinManager.gd[ASkinManager.ConstData.Sections[ssButton]].Props[1].Color
        else
          Result := ASkinManager.Palette[pcMainColor];

      clInfoText:
        Result := ASkinManager.Palette[pcHintText];

      clInfoBk:
        Result := ASkinManager.Palette[pcHintBG];

      clHotLight:
        Result := ASkinManager.Palette[pcWebText];

      clMenuHighlight:
        if ASkinManager.ConstData.Sections[ssMenuItem] >= 0 then
          Result := ASkinManager.gd[ASkinManager.ConstData.Sections[ssMenuItem]].Props[1].Color
        else
          Result := ColorToRGB(AColor)

      else
        Result := ColorToRGB(AColor);
    end
  else
    Result := ColorToRGB(AColor);
end;


{$IFDEF D2007}
procedure UpdateCommonDlgs(sManager: TsSkinManager);
begin
  if DefaultManager = sManager then
    UseLatestCommonDialogs := not (srStdDialogs in sManager.SkinningRules) or not sManager.Active;
end;
{$ENDIF}


function ExtInt(const aPos: integer; const s: string; const aDelim: TSysCharSet): integer;
{$IFNDEF DELPHI6UP}
var
  subs: string;
{$ENDIF}
begin
{$IFDEF DELPHI6UP}
  if not TryStrToInt(ExtractWord(aPos, s, aDelim), Result) then
    Result := 0;
{$ELSE}
  subs := ExtractWord(aPos, s, aDelim);
  if subs <> '' then
    Result := StrToInt(subs)
  else
    Result := 0;
{$ENDIF}
end;


function GetCornerType(sm: TsSkinManager; const mask: TsMaskData): integer;
var
  C: TsColor;
  Bmp: TBitmap;
  dx, i, X, Y, w, h, l, t: integer;

  procedure Checkbits;
  begin
    Y := t;
    while (Y < h) and (Result = 0) do begin
      X := l;
      while (X < w) and (Result = 0) do begin
        C := GetAPixel(Bmp, X, Y);
        if C.I = clFuchsia then begin
          Result := 1;
          Exit;
        end;
        inc(X);
      end;
      inc(Y);
    end;
  end;
  
begin
  if (mask.SkinIndex = sm.ConstData.Sections[ssButtonHuge]) and (mask.PropertyName = s_BordersMask) then
    Result := 2 {Region changed}
  else begin
    Result := 0; // Normal corner
    if HeightOf(mask.R) > 0 then begin
      if Mask.Bmp <> nil then
        Bmp := Mask.Bmp
      else
        Bmp := sm.MasterBitmap;

      dx := Mask.Width;
      for i := 0 to Mask.ImageCount - 1 do begin
        // Left top
        l := mask.R.Left + i * dx;
        t := mask.R.Top;
        w := min(l + mask.WL, Bmp.Width  - 1);
        h := min(mask.R.Top  + mask.WT, Bmp.Height - 1);
        Checkbits;
        if Result > 0 then Exit;
        // Right top
        l := mask.R.Left + i * dx + WidthOf(mask.R) div mask.ImageCount - mask.WR;
        t := mask.R.Top;
        w := min(l + mask.WR, Bmp.Width - 1);
        h := min(mask.R.Top + mask.WT, Bmp.Height - 1);
        Checkbits;
        if Result > 0 then Exit;
        // Left bottom
        l := mask.R.Left + i * dx;
        t := mask.R.Top + HeightOf(mask.R) div (mask.MaskType + 1) - mask.WB;
        w := min(mask.R.Left + mask.WL, Bmp.Width - 1);
        h := min(t + mask.WB, Bmp.Height - 1);
        Checkbits;
        if Result > 0 then Exit;
        // Right bottom
        l := mask.R.Left + i * dx + WidthOf(mask.R) div mask.ImageCount - mask.WR;
        t := mask.R.Top + HeightOf(mask.R) div (mask.MaskType + 1) - mask.WB;
        w := min(mask.R.Left + mask.WL, Bmp.Width - 1);
        h := min(t + mask.WB, Bmp.Height - 1);
        Checkbits;
      end;
    end;
  end;
end;


function ChangeImageInSkin(const SkinSection, PropName, FileName: string; sm: TsSkinManager): boolean;
var
  i, l: integer;
  s: string;
begin
  Result := False;
  with sm do
    if CommonSkinData.Active and (SkinSection <> '') and (PropName <> '') and FileExists(FileName) then begin
      s := UpperCase(PropName);
      // If property is Background texture
      if (s = s_Pattern) or ( s = s_HotPattern) then begin
        // If loaded file is Bitmap
        if pos('.BMP', UpperCase(FileName)) > 0 then begin
          l := Length(ma);
          // ma - is array of records with image description
          if l > 0 then
            // search of the required image in the massive
            for i := 0 to l - 1 do
              if (UpperCase(ma[i].PropertyName) = s) and (UpperCase(ma[i].ClassName) = UpperCase(skinSection)) then begin
                // If found then we must define new Bmp
                if ma[i].Bmp = nil then
                  ma[i].Bmp := TBitmap.Create;

                ma[i].Bmp.LoadFromFile(FileName);
                if ma[i].Bmp.PixelFormat <> pf32bit then begin
                  ma[i].Bmp.PixelFormat := pf32bit;
                  FillAlphaRect(ma[i].Bmp, MkRect(ma[i].Bmp), MaxByte);
                end;
                ma[i].R := MkRect(ma[i].Bmp);
                // To exit
                Result := True;
                Break;
              end;

          // If not found then add a new image
          if not Result then begin
            l := Length(ma) + 1;
            SetLength(ma, l);
            with ma[l - 1] do begin
              PropertyName := '';
              ClassName := '';
              try
                Bmp := TBitmap.Create;
                Bmp.LoadFromFile(FileName);
              finally
                PropertyName := s;
                ClassName := UpperCase(SkinSection);
                Manager := sm;
                R := MkRect(Bmp);
                ImageCount := 1;
                ImgType := itisaTexture;
              end;
            end;
            if ma[l - 1].Bmp.Width <= 0 then begin
              FreeAndNil(ma[l - 1].Bmp);
              SetLength(ma, l - 1);
            end;
            Result := True;
          end;
        end;
      end
      // If property is not a background texture
      else
        if pos('.BMP', FileName) > 0 then begin
          l := Length(ma);
          if l > 0 then
            for i := 0 to l - 1 do
              with ma[i] do
                if (PropertyName = s) and (ClassName = UpperCase(SkinSection)) then begin
                  Bmp.LoadFromFile(FileName);
                  Result := True;
                  Exit
                end;
        end;
    end;
end;


const
  ChangeableColors: set of TacPaletteColors = [pcMainColor, pcLabelText, pcWebText, pcEditText, pcEditBG,
    pcSelectionBG, pcSelectionText, pcSelectionBG_Focused, pcSelectionText_Focused,
    pcEditBG_Inverted, pcEditText_Inverted, pcEditBG_OddRow, pcEditBG_EvenRow, pcBorder, pcHintBG, pcHintText];

    
procedure ChangeSkinSaturation(sManager: TsSkinManager; Value: integer);
var
  i, l, j, n: integer;
  pc: TacPaletteColors;
begin
  if Value <> 0 then begin
    Value := LimitIt(Value * MaxByte div 100, -MaxByte, MaxByte);
    with sManager do begin
      ChangeBitmapPixels(MasterBitmap, ChangeColorSaturation, Value, clFuchsia);
      l := Length(ExtArray);
      for i := 0 to l - 1 do
        if Assigned(ExtArray[i].Bmp) then
          ChangeBitmapPixels(ExtArray[i].Bmp, ChangeColorSaturation, Value, clFuchsia);

      l := Length(gd);
      for i := 0 to l - 1 do
        with gd[i] do
          for j := 0 to ac_MaxPropsIndex do
            with Props[j] do begin
              for n := 0 to Length(GradientArray) - 1 do begin
                GradientArray[n].Color1 := ChangeSaturation(GradientArray[n].Color1, Value);
                GradientArray[n].Color2 := ChangeSaturation(GradientArray[n].Color2, Value);
              end;
              if Color            <> -1 then Color            := ChangeSaturation(Color,            Value);
              if GlowColor        <> -1 then GlowColor        := ChangeSaturation(GlowColor,        Value);
              if FontColor.Color  <> -1 then FontColor.Color  := ChangeSaturation(FontColor.Color,  Value);
              if FontColor.Left   <> -1 then FontColor.Left   := ChangeSaturation(FontColor.Left,   Value);
              if FontColor.Top    <> -1 then FontColor.Top    := ChangeSaturation(FontColor.Top,    Value);
              if FontColor.Right  <> -1 then FontColor.Right  := ChangeSaturation(FontColor.Right,  Value);
              if FontColor.Bottom <> -1 then FontColor.Bottom := ChangeSaturation(FontColor.Bottom, Value);
            end;

      with sManager do begin
        CommonSkinData.Shadow1Color := ChangeSaturation(CommonSkinData.Shadow1Color, Value);
        for pc := Low(Palette) to High(Palette) do
          if (pc in ChangeableColors) then
            Palette[pc] := ChangeSaturation(Palette[pc], Value);
      end;
    end;
  end;
end;


procedure ChangeSkinBrightness(sManager: TsSkinManager; Value: integer);
var
  i, j, n: integer;
  MasksBmp: TBitmap;

  procedure RestoreMasterMasks;
  var
    i: integer;
  begin
    for i := 0 to Length(sManager.ma) - 1 do
      with sManager, ma[i] do
        if (Bmp = nil) { if image is in MasterBmp } and (MaskType = 1) then
          BitBlt(MasterBitmap.Canvas.Handle, R.Left, R.Top + HeightOf(R) div 2, WidthOf(R), HeightOf(R) div 2,
                     MasksBmp.Canvas.Handle, R.Left, R.Top + HeightOf(R) div 2, SRCCOPY);
  end;

begin
  if Value <> 0 then
    with sManager do begin
      MasksBmp := CreateBmp32;
      CopyBmp(MasksBmp, sManager.MasterBitmap); // Save MasterBmp
      ChangeBitmapPixels(MasterBitmap, ChangeColorBrightness, Value, clFuchsia);
      RestoreMasterMasks;
      for i := 0 to Length(ExtArray) - 1 do
        with ExtArray[i] do
          if Bmp <> nil then
            if MaskType = 0 then begin // Loaded from PNG
              ChangeBitmapPixels(Bmp, ChangeColorBrightness, Value, clFuchsia);
              if Value > 0 then
                if CommonSkindata.Version >= acTranspVer then {New mode of layered wnd}
                  UpdateAlpha(Bmp, MkRect(Bmp))
                else
                  UpdateTransPixels(Bmp);
            end
            else
              with MasksBmp do begin
                Width := Bmp.Width;
                Height := Bmp.Height div 2;
                BitBlt(Canvas.Handle, 0, 0, Width, Height, Bmp.Canvas.Handle, 0, Height, SRCCOPY); // Save mask
                ChangeBitmapPixels(Bmp, ChangeColorBrightness, Value, clFuchsia);
                BitBlt(Bmp.Canvas.Handle, 0, Height, Width, Height, Canvas.Handle, 0, 0, SRCCOPY); // Restore mask
              end;

      MasksBmp.Free;
      for i := 0 to Length(gd) - 1 do
        with gd[i] do
          for j := 0 to ac_MaxPropsIndex do
            with Props[j] do begin
              for n := 0 to Length(GradientArray) - 1 do
                with GradientArray[n] do begin
                  Color1 := ChangeBrightness(Color1, Value);
                  Color2 := ChangeBrightness(Color2, Value);
                end;

              if Color            <> -1 then Color            := ChangeBrightness(Color,            Value);
              if GlowColor        <> -1 then GlowColor        := ChangeBrightness(GlowColor,        Value);
              if FontColor.Color  <> -1 then FontColor.Color  := ChangeBrightness(FontColor.Color,  Value);
              if FontColor.Left   <> -1 then FontColor.Left   := ChangeBrightness(FontColor.Left,   Value);
              if FontColor.Top    <> -1 then FontColor.Top    := ChangeBrightness(FontColor.Top,    Value);
              if FontColor.Right  <> -1 then FontColor.Right  := ChangeBrightness(FontColor.Right,  Value);
              if FontColor.Bottom <> -1 then FontColor.Bottom := ChangeBrightness(FontColor.Bottom, Value);
            end;
    end;
end;


procedure ChangeSkinHue(sManager: TsSkinManager; Value: integer);
var
  ExceptNdx: array of TBitmap;
  i, j, n, x, y: integer;
  pc: TacPaletteColors;
  TmpBmp: TBitmap;
  SavedDC: hdc;

  procedure SaveImage(const Name: string);
  var
    Index: integer;

    procedure AddToArray(Bmp: TBitmap);
    begin
      SetLength(ExceptNdx, Length(ExceptNdx) + 1);
      ExceptNdx[Length(ExceptNdx) - 1] := Bmp;
    end;

  begin
    Index := sManager.GetMaskIndex(sManager.ConstData.IndexGlobalInfo, Name);
    if Index >= 0 then
      with sManager.ma[Index] do begin
        if Bmp = nil { If Image is in MasterBitmap } then
          with R do
            ExcludeClipRect(sManager.MasterBitmap.Canvas.Handle, Left, Top, Right, Bottom)
        else
          AddToArray(Bmp);
        // Glow glyphs
        if (sManager.GetMaskIndex(sManager.ConstData.IndexGlobalInfo, Name + s_Glow + ZeroChar) >= 0) and (Bmp <> nil) then
          AddToArray(Bmp);
      end;
  end;

begin
  if Value <> 0 then begin
    SetLength(ExceptNdx, 0);
    with sManager do begin
      // Save images of border icons if needed
      if CommonSkinData.BIKeepHUE > 0 then begin
        TmpBmp := CreateBmp32(MasterBitmap.Width, MasterBitmap.Height);
        TmpBmp.Assign(MasterBitmap);
        ChangeBitmapPixels(TmpBmp, ChangeColorHUE, Value, clFuchsia);
        SavedDC := SaveDC(MasterBitmap.Canvas.Handle);
        try
          SaveImage(s_BorderIconClose);
          SaveImage(s_BorderIconCloseAlone);
          SaveImage(s_SmallIconClose);
          if CommonSkinData.BIKeepHUE = 1 then begin
            SaveImage(s_BorderIconMaximize);
            SaveImage(s_BorderIconMinimize);
            SaveImage(s_BorderIconNormalize);
            SaveImage(s_BorderIconHelp);
            SaveImage(s_SmallIconMaximize);
            SaveImage(s_SmallIconMinimize);
            SaveImage(s_SmallIconNormalize);
          end;
          BitBlt(MasterBitmap.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
        finally
          TmpBmp.Free;
          RestoreDC(MasterBitmap.Canvas.Handle, SavedDC);
        end;
      end
      else
        ChangeBitmapPixels(MasterBitmap, ChangeColorHUE, Value, clFuchsia);

      for i := 0 to Length(ExtArray) - 1 do
        if Assigned(ExtArray[i].Bmp) then begin
          if CommonSkinData.BIKeepHUE > 0 then begin
            x := Length(ExceptNdx) - 1;
            y := 0;
            for j := 0 to x do
              if ExceptNdx[j] = ExtArray[i].Bmp then begin
                y := 1;
                Break
              end;

            if y = 1 then // if excepted
              Continue;
          end;
          ChangeBitmapPixels(ExtArray[i].Bmp, ChangeColorHUE, Value, clFuchsia);
        end;

      for i := 0 to Length(gd) - 1 do
        with gd[i] do
          for j := 0 to ac_MaxPropsIndex do
            with Props[j] do begin
              if GradientPercent > 0 then
                for n := 0 to Length(GradientArray) - 1 do
                  with GradientArray[n] do begin
                    Color1 := ChangeHue(Value, Color1);
                    Color2 := ChangeHue(Value, Color2);
                  end;

              if Color            <> -1 then Color           := ChangeHue(Value, Color);
              if GlowColor        <> -1 then GlowColor       := ChangeHue(Value, GlowColor);
              if FontColor.Color  <> -1 then FontColor.Color := ChangeHue(Value, FontColor.Color);
              if FontColor.Left   <> -1 then FontColor.Left  := ChangeHue(Value, FontColor.Left);
              if FontColor.Top    <> -1 then FontColor.Top   := ChangeHue(Value, FontColor.Top);
              if FontColor.Right  <> -1 then FontColor.Right := ChangeHue(Value, FontColor.Right);
              if FontColor.Bottom <> -1 then FontColor.Bottom:= ChangeHue(Value, FontColor.Bottom);
            end;

      with sManager, CommonSkinData do begin
        Shadow1Color := ChangeHue(Value, Shadow1Color);
        for pc := Low(Palette) to High(Palette) do
          if pc in ChangeableColors then
            Palette[pc] := ChangeHue(Value, Palette[pc]);
      end;
    end;
    SetLength(ExceptNdx, 0);
  end;
end;

{$IFNDEF WIN64}
type
  TJumpOfs = Integer;
  PPointer = ^Pointer;

  PXRedirCode = ^TXRedirCode;
  TXRedirCode = packed record
    Jump: Byte;
    Offset: TJumpOfs;
  end;

  PWin9xDebugThunk = ^TWin9xDebugThunk;
  TWin9xDebugThunk = packed record
    PUSH: Byte;
    Addr: Pointer;
    JMP: TXRedirCode;
  end;

  PAbsoluteIndirectJmp = ^TAbsoluteIndirectJmp;
  TAbsoluteIndirectJmp = packed record
    OpCode: Word; // $FF25(Jmp, FF /4)
    Addr: PPointer;
  end;

var
  WinCreatePen, WinGetSysColor, WinGetSysColorBrush: TXRedirCode;

function acGetActualAddr(Proc: Pointer): Pointer;

  function IsWin9xDebugThunk(AAddr: Pointer): Boolean;
  begin
    Result := (AAddr <> nil) and (PWin9xDebugThunk(AAddr).PUSH = $68) and (PWin9xDebugThunk(AAddr).JMP.Jump = $E9);
  end;

begin
  if Proc <> nil then begin
    if (Win32Platform <> VER_PLATFORM_WIN32_NT) and IsWin9xDebugThunk(Proc) then
      Proc := PWin9xDebugThunk(Proc).Addr;

    if PAbsoluteIndirectJmp(Proc).OpCode = $25FF then
      Result := PAbsoluteIndirectJmp(Proc).Addr^
    else
      Result := Proc;
  end
  else
    Result := nil;
end;


procedure acHookProc(Proc, Dest: Pointer; var BackupCode: TXRedirCode);
var
  n: ACUInt;
  Code: TXRedirCode;
begin
  Proc := acGetActualAddr(Proc);
  if Proc <> nil then
    if ReadProcessMemory(GetCurrentProcess, Proc, @BackupCode, SizeOf(BackupCode), n) then begin
      Code.Jump := $E9;
      Code.Offset := PAnsiChar(Dest) - PAnsiChar(Proc) - SizeOf(Code);
      WriteProcessMemory(GetCurrentProcess, Proc, @Code, SizeOf(Code), n);
    end;
end;


procedure acUnhookProc(Proc: Pointer; var BackupCode: TXRedirCode);
var
  n: ACUInt;
begin
  if (BackupCode.Jump <> 0) and (Proc <> nil) then begin
    Proc := acGetActualAddr(Proc);
    Assert(Proc <> nil);
    WriteProcessMemory(GetCurrentProcess, Proc, @BackupCode, SizeOf(BackupCode), n);
    BackupCode.Jump := 0;
  end;
end;


procedure HookCreatePen;          forward;
procedure UnHookCreatePen;        forward;
procedure HookGetSysColor;        forward;
procedure UnHookGetSysColor;      forward;
procedure HookGetSysColorBrush;   forward;
procedure UnHookGetSysColorBrush; forward;


function acCreatePen(Style, Width: Integer; Color: COLORREF): HPEN; stdcall;
begin
  if DefaultManager <> nil then
    with DefaultManager do
      case Color of
        COLOR_INACTIVEBORDER:Color := CommonSkinData.SysInactiveBorderColor;
        COLOR_HIGHLIGHT:     Color := Palette[pcSelectionBG_Focused];
        COLOR_HIGHLIGHTTEXT: Color := Palette[pcSelectionText_Focused];
        COLOR_WINDOW:        Color := Palette[pcEditBG];
        COLOR_BTNFACE:       Color := Palette[pcMainColor];
        COLOR_WINDOWFRAME:   Color := Palette[pcBorder];
        COLOR_BTNSHADOW:     Color := BlendColors(Palette[pcMainColor], 0, 205);
        COLOR_3DDKSHADOW:    Color := BlendColors(Palette[pcMainColor], 0, 205);
        COLOR_3DLIGHT:       Color := BlendColors(Palette[pcMainColor], $FFFFFF, 205);
        clSilver:            Color := BlendColors(Palette[pcEditText], Palette[pcEditBG], 38);
        $F0F0F0:             Color := BlendColors(Palette[pcEditText], Palette[pcEditBG], 38);
      end;

  UnHookCreatePen;
  Result := CreatePen(Style, Width, Color);
  HookCreatePen;
end;


function acGetSysColor(nIndex: Integer): DWORD; stdcall;
begin
  if DefaultManager <> nil then
    with DefaultManager do
      case nIndex of
        COLOR_INACTIVEBORDER:Result := CommonSkinData.SysInactiveBorderColor;
        COLOR_HIGHLIGHT:     Result := Palette[pcSelectionBG_Focused];
        COLOR_HIGHLIGHTTEXT: Result := Palette[pcSelectionText_Focused];
        COLOR_WINDOW:        Result := Palette[pcEditBG];
        COLOR_WINDOWTEXT:    Result := Palette[pcEditText];
        COLOR_WINDOWFRAME:   Result := Palette[pcBorder];
        COLOR_BTNSHADOW:     Result := BlendColors(Palette[pcMainColor], 0, 205);
        COLOR_3DDKSHADOW:    Result := BlendColors(Palette[pcMainColor], 0, 205);
        COLOR_3DLIGHT:       Result := BlendColors(Palette[pcMainColor], $FFFFFF, 205)
        else begin
          UnHookGetSysColor;
          Result := GetSysColor(nIndex);
          HookGetSysColor;
        end;
      end
  else
    Result := 0;
end;


function acGetSysColorBrush(nIndex: Integer): HBRUSH; stdcall;
begin
  if DefaultManager <> nil then
    with DefaultManager do
      case nIndex of
        COLOR_HIGHLIGHT:     Result := CreateSolidBrush(Cardinal(Palette[pcSelectionBG_Focused]));
        COLOR_HIGHLIGHTTEXT: Result := CreateSolidBrush(Cardinal(Palette[pcSelectionText_Focused]));
        COLOR_WINDOW:        Result := Brushes[pcEditBG];
        COLOR_WINDOWTEXT:    Result := CreateSolidBrush(Cardinal(Palette[pcEditText]))
        else begin
          UnHookGetSysColorBrush;
          Result := GetSysColorBrush(nIndex);
          HookGetSysColorBrush;
        end;
      end
  else
    Result := 0;
end;


var
  SysColorsHooked:      boolean = False;
  SysCreatePenHooked:   boolean = False;
  SysColorsHookedBrush: boolean = False;


procedure HookGetSysColor;
begin
  if not SysColorsHooked then
    acHookProc(@Windows.GetSysColor, @acGetSysColor, WinGetSysColor);

  SysColorsHooked := True;
end;


procedure UnHookGetSysColor;
begin
  if SysColorsHooked then begin
    SysColorsHooked := False;
    acUnhookProc(@Windows.GetSysColor, WinGetSysColor);
  end;
end;


procedure HookGetSysColorBrush;
begin
  if not SysColorsHookedBrush then begin
    SysColorsHookedBrush := True;
    acHookProc(@Windows.GetSysColorBrush, @acGetSysColorBrush, WinGetSysColorBrush);
  end;
end;

procedure UnHookGetSysColorBrush;
begin
  if SysColorsHookedBrush then
    acUnhookProc(@Windows.GetSysColorBrush, WinGetSysColorBrush);

  SysColorsHookedBrush := False;
end;


procedure HookCreatePen;
begin
  if not SysCreatePenHooked then begin
    SysCreatePenHooked := True;
    acHookProc(@Windows.CreatePen, @acCreatePen, WinCreatePen);
  end;
end;

procedure UnHookCreatePen;
begin
  if SysCreatePenHooked then
    acUnhookProc(@Windows.CreatePen, WinCreatePen);

  SysCreatePenHooked := False;
end;
{$ENDIF} // WIN64


procedure LoadThirdNames(sm: TsSkinManager; Overwrite: boolean = False);
var
  i: integer;
begin
  for i := 0 to High(acThirdNames) do begin
    if Overwrite or (sm.ThirdParty.GetString(i) = '') then
      sm.ThirdParty.SetString(i, acThirdNames[i]);

    sm.ThirdLists[i].Text := sm.ThirdParty.GetString(i);
  end;
end;


procedure UpdateThirdNames(sm: TsSkinManager);
var
  i: integer;
begin
  for i := 0 to High(acThirdNames) do
    sm.ThirdParty.SetString(i, sm.ThirdLists[i].Text);
end;


function GetScrollSize(sm: TsSkinManager): integer;
begin
  if sm = nil then
    Result := GetSystemMetrics(SM_CXVSCROLL)
  else
    if sm.ScrollsOptions.ScrollSize < 0 then
      Result := GetSystemMetrics(SM_CXVSCROLL)
    else
      Result := sm.ScrollsOptions.ScrollSize;
end;


function GetComboBtnSize(sm: TsSkinManager): integer;
begin
  Result := max(GetSystemMetrics(SM_CXVSCROLL), GetScrollSize(sm));
end;


procedure TsSkinManager.AfterConstruction;
begin
  inherited;
  LoadThirdNames(Self);
  if FSkinDirectory = '' then
    FSkinDirectory := DefSkinsDir;

  if ([csLoading, csReading] * ComponentState = []) and Assigned(InitDevEx) then begin
    if (Options.ScaleMode <> smOldMode) and Assigned(ac_SetProcessDPIaware) then
      ac_SetProcessDPIaware;

    InitDevEx(Active and (SkinName <> ''));
  end;
end;


procedure SetCaseSens(sl: TStringList; Value: boolean = True); overload;
begin
  {$IFDEF DELPHI6UP} sl.CaseSensitive := Value; {$ENDIF}
end;


procedure SetCaseSens(sl: TMemIniFile; Value: boolean = True); overload;
begin
  {$IFDEF DELPHI6UP} sl.CaseSensitive := Value; {$ENDIF}
end;


constructor TsSkinManager.Create(AOwner: TComponent);
var
  i, l: integer;
  Section: TacSection;
begin
  CommonSkinData := TsSkinData.Create;
  CommonSkinData.Active := False;
  inherited Create(AOwner);
  FEffects := TacSkinEffects.Create;
  FEffects.Manager := Self;
  FThirdParty := ThirdPartyList.Create;
  FExtendedBorders := False;
  NoAutoUpdate := False;
  ShowState := saIgnore;
  FormShadowSize := MkRect;

{$IFNDEF NOFONTSCALEPATCH}
  try
    i := ReadRegInt(HKEY_CURRENT_USER, 'Control Panel\Desktop\WindowMetrics', 'AppliedDPI');
  except
    i := 0;
  end;
  case i of
    144..MaxInt: SysFontScale := 2;
    120..143:    SysFontScale := 1
    else         SysFontScale := 0;
  end;
{$ENDIF}

  l := High(acThirdNames);
  SetLength(ThirdLists, l + 1);
  for i := 0 to l do begin
    ThirdLists[i] := TStringList.Create;
    SetCaseSens(ThirdLists[i]);
  end;
  CommonSkinData.SysInactiveBorderColor := ColorToRGB(clInactiveBorder);
  FBuiltInSkins := TsStoredSkins.Create(Self);
  FCommonSections := TStringList.Create;
  FKeyList := TStringList.Create;
  SetCaseSens(FCommonSections);
  FSkinnedPopups := True;
  FHueOffset := 0;
  FBrightness := 0;
  for Section := Low(ConstData.Sections) to High(ConstData.Sections) do
    ConstData.Sections[Section] := GetSkinIndex(acSectNames[Section]);

  FMenuSupport := TacMenuSupport.Create;
  FOptions := TacOptions.Create(Self);
  FScrollsOptions := TacScrollBarsSupport.Create(Self);
  FButtonsSupport := TacButtonsSupport.Create(Self);
  FLabelsSupport := TacLabelsSupport.Create(Self);
  FAnimEffects := TacAnimEffects.Create;
  FAnimEffects.Manager := Self;
  GlobalHookInstalled := False;
  FSkinningRules := [srStdForms, srStdDialogs, srThirdParty];
  SkinListController := TacSkinListController.Create(Self);
  if DefaultManager = nil then begin
    DefaultManager := Self;
{$IFNDEF FPC}
    if IsNT and not (csDesigning in ComponentState) then
      Application.HookMainWindow(MainWindowHook);
{$ENDIF}
  end;
  FActive := True;
  SkinRemoving := False;

{$IFNDEF FPC}
  FSkinableMenus := TsSkinableMenus.Create(Self);
{$ENDIF}

{$IFNDEF DELPHI2005}
  TimerCheckHot := TTimer.Create(Self);
  TimerCheckHot.Interval := 100;
  TimerCheckHot.OnTimer := OnCheckHot;
{$ENDIF}
  SetLength(gd, 0);
  SetLength(ma, 0);
end;


destructor TsSkinManager.Destroy;
var
  ColorItem: TacPaletteColors;
  i: integer;
begin
  Active := False;
  FExtendedBorders := False;
  FreeAndNil(FAnimEffects);
  FreeAndNil(FBuiltInSkins);
{$IFNDEF FPC}
  FreeAndNil(FSkinableMenus);
{$ENDIF}
{$IFNDEF DELPHI2005}
  TimerCheckHot.Free;
{$ENDIF}
  FreeAndNil(FEffects);
  if ShdaTemplate <> nil then
    FreeAndNil(ShdaTemplate);

  if ShdiTemplate <> nil then
    FreeAndNil(ShdiTemplate);

  FreeAndNil(FCommonSections);
  FreeAndNil(FKeyList);

  FreeAndNil(CommonSkinData);
  FreeAndNil(FMenuSupport);
  FreeAndNil(FOptions);
  FreeAndNil(FScrollsOptions);
  FreeAndNil(FButtonsSupport);
  FreeAndNil(FLabelsSupport);
  FreeAndNil(SkinListController);
  FreeBitmaps;
  if DefaultManager = Self then begin
{$IFNDEF FPC}
    if IsNT and not (csDesigning in ComponentState) then
      Application.UnHookMainWindow(MainWindowHook);
{$ENDIF}

    DefaultManager := nil;
  end;
  UpdateThirdNames(Self);
  for i := 0 to Length(ThirdLists) - 1 do
    if ThirdLists[i] <> nil then
      FreeAndNil(ThirdLists[i]);

  for ColorItem := low(Brushes) to high(Brushes) do 
    if Brushes[ColorItem] <> 0 then
      DeleteObject(Brushes[ColorItem]);

  SetLength(ThirdLists, 0);
  FreeAndNil(FThirdParty);
  inherited Destroy;
end;


procedure TsSkinManager.ExtractByIndex(Index: integer; const DestDir: string);
var
  DirName: string;
begin
  DirName := NormalDir(DestDir);
  if not acDirExists(DirName) then
    if not CreateDir(DirName) then begin
{$IFNDEF ALITE}
      ShowError(DirName + ' directory creation error.');
{$ENDIF}
      Exit;
    end;

  if InternalSkins[Index].PackedData <> nil then
    InternalSkins[Index].PackedData.SaveToFile(DirName + InternalSkins[Index].Name + ' extracted.asz');
end;


procedure TsSkinManager.ExtractInternalSkin(const NameOfSkin, DestDir: string);
var
  i: integer;
  Executed: boolean;
begin
  Executed := False;
  for i := 0 to InternalSkins.Count - 1 do
    if InternalSkins[i].Name = NameOfskin then begin
      if acDirExists(Destdir) then
        ExtractByIndex(i, Destdir)
      else
        {$IFNDEF ALITE}ShowError{$ELSE}ShowMessage{$ENDIF}('Directory does not exists.');

      Executed := True;
    end;

  if not Executed then
    {$IFNDEF ALITE}ShowError{$ELSE}ShowMessage{$ENDIF}('Skin does not exists.');
end;


function TsSkinManager.GetExternalSkinNames(sl: TacStrings; SkinType: TacSkinTypes = stAllSkins): acString;
var
  FileInfo: TacSearchRec;
  s, SkinPath: acString;
  stl: TacStringList;
  DosCode: Integer;
begin
  Result := '';
  SkinPath := GetFullskinDirectory;
  sl.Clear;
  stl := TacStringList.Create;
  // External skins names loading
  if acDirExists(SkinPath) then begin
    s := SkinPath + '\*.*';
    DosCode := acFindFirst(s, faDirectory, FileInfo);
    try
      while DosCode = 0 do begin
        if FileInfo.Name[1] <> s_Dot then
          if (SkinType in [stUnpacked, stAllSkins]) and
                (FileInfo.Attr and faDirectory <> 0) and
                  FileExists(SkinPath + s_Slash + FileInfo.Name + s_Slash + OptionsDatName) then begin
            stl.Add(FileInfo.Name);
            if Result = '' then
              Result := FileInfo.Name;
          end
          else
            if (SkinType in [stPacked, stAllSkins]) and (FileInfo.Attr and faDirectory = 0) and (ExtractFileExt(FileInfo.Name) = s_Dot + acSkinExt) then begin
              s := FileInfo.Name;
              Delete(s, pos(s_Dot + acSkinExt, LowerCase(s)), 4);
              stl.Add(s);
              if Result = '' then
                Result := s;
            end;

        DosCode := acFindNext(FileInfo);
      end;
    finally
      acFindClose(FileInfo);
    end;
  end;
  stl.Sort;
  sl.Assign(stl);
  FreeAndNil(stl);
end;


function TsSkinManager.GetFullSkinDirectory: string;
var
  s: string;
begin
  Result := SkinDirectory;
  if pos('..', Result) = 1 then begin
    s := GetAppPath;
    Delete(s, Length(s), 1);
    while (s[Length(s)] <> '/') and (s[Length(s)] <> s_Slash) do
      Delete(s, Length(s), 1);

    Delete(Result, 1, 3);
    Result := s + Result;
  end
  else
    if (pos('.\', Result) = 1) or (pos('./', Result) = 1) then begin
      Delete(Result, 1, 2);
      Result := GetAppPath + Result;
    end
    else
      if s_Dot = Result then
        Result := GetAppPath
      else
        if (pos(':', Result) <= 0) and (pos('\\', Result) <= 0) then
          Result := GetAppPath + Result;

  NormalDir(Result);
end;


function TsSkinManager.GetGlobalColor: TColor;
begin
  Result := Palette[pcMainColor];
end;


function TsSkinManager.GetGlobalFontColor: TColor;
begin
  Result := Palette[pcLabelText];
end;


function TsSkinManager.GetSkinNames(sl: TacStrings; SkinType: TacSkinTypes = stAllSkins): acString;
var
  FileInfo: TacSearchRec;
  s, SkinPath: acString;
  stl: TacStringList;
  DosCode: Integer;
begin
  Result := '';
  SkinPath := GetFullskinDirectory;
  sl.Clear;
  stl := TacStringList.Create;
  // Internal skins names loading
  if InternalSkins.Count > 0 then
    for DosCode := 0 to InternalSkins.Count - 1 do begin
      stl.Add(InternalSkins[DosCode].Name);
      if Result = '' then
        Result := InternalSkins[DosCode].Name;
    end;
  // External skins names loading
  if acDirExists(SkinPath) then begin
    s := SkinPath + '\*.*';
    DosCode := acFindFirst(s, faDirectory, FileInfo);
    try
      while DosCode = 0 do begin
        if FileInfo.Name[1] <> s_Dot then
          if (SkinType in [stUnpacked, stAllSkins]) and
                (FileInfo.Attr and faDirectory <> 0) and
                  FileExists(SkinPath + s_Slash + FileInfo.Name + s_Slash + OptionsDatName) then begin
            stl.Add(FileInfo.Name);
            if Result = '' then
              Result := FileInfo.Name;
          end
          else
            if (SkinType in [stPacked, stAllSkins]) and (FileInfo.Attr and faDirectory = 0) and (ExtractFileExt(FileInfo.Name) = s_Dot + acSkinExt) then begin
              s := FileInfo.Name;
              Delete(s, pos(s_Dot + acSkinExt, LowerCase(s)), 4);
              stl.Add(s);
              if Result = '' then
                Result := s;
            end;

        DosCode := acFindNext(FileInfo);
      end;
    finally
      acFindClose(FileInfo);
    end;
  end;
  stl.Sort;
  sl.Assign(stl);
  FreeAndNil(stl);
end;


procedure TsSkinManager.GetSkinSections(sl: TStrings);
var
  i: integer;
begin
  sl.Clear;
  if CommonSkinData.Active then
    for i := Low(gd) to High(gd) do
      sl.Add(gd[i].ClassName);
end;


function TsSkinManager.GetSkinInfo: TacSkinInfo;
var
  s: char;
begin
  if CommonSkinData.Active then begin
    s := {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator;
    {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator := s_Dot;
    Result := FloatToStr(CommonSkinData.Version);
    {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator := s;
  end
  else
    Result := 'N/A';
end;


function TsSkinManager.GetVersion: string;
begin
  Result := acCurrentVersion {$IFDEF RUNIDEONLY} + ' Trial'{$ENDIF};
end;


procedure TsSkinManager.InitConstantIndexes;
var
  b: boolean;
  Side: TacSide;
  tg: TacTitleGlyph;
  i, iScale: integer;
  tPos: TacTabLayout;
  Section: TacSection;
  CheckState: TCheckBoxState;

  function GetGlobalIndex(const sName: string): integer;
  begin
    Result := GetMaskIndex(ConstData.IndexGlobalInfo, s_GlobalInfo, sName)
  end;

  function GetGlyphNdx(const sName: string; const SectionIndex: integer = -1; Png: boolean = False): integer;
  var
    C: TColor;
    SrcBmp: TBitmap;
    CanFree: boolean;
    S0, S1, S2: PRGBAArray_S;
    h, x, y, Delta: integer;

    function InExternal(Bmp: TBitmap): boolean;
    var
      i: integer;
    begin
      for i := 0 to Length(ExtArray) - 1 do
        if ExtArray[i].Bmp = Bmp then begin
          Result := True;
          Exit;
        end;

      Result := False;
    end;

  begin
    if SectionIndex < 0 then
      Result := GetGlobalIndex(sName + aSfxs[iScale])
    else
      Result := GetMaskIndex(SectionIndex, sName + aSfxs[iScale]);

    if (Result < 0) and (aSfxs[iScale] <> '') then begin // Make new scaled glyph
      if SectionIndex < 0 then
        Result := GetGlobalIndex(sName)
      else
        Result := GetMaskIndex(SectionIndex, sName);

      if Result >= 0 then
        with ma[Result] do begin
          CanFree := True;
          h := HeightOf(R);
          // Prepare SrcBmp
          if not Png then begin
            if MaskType = 0 then begin
              SrcBmp := CreateBmp32(WidthOf(R), h * 2);
              FillRect32(SrcBmp, Rect(0, h, SrcBmp.Width, SrcBmp.Height), 0, 0);
              if Bmp <> nil then begin
                BitBlt(SrcBmp.Canvas.Handle, 0, 0, SrcBmp.Width, h, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
                if not InExternal(Bmp) then
                  FreeAndNil(Bmp);
              end
              else
                BitBlt(SrcBmp.Canvas.Handle, 0, 0, SrcBmp.Width, h, MasterBitmap.Canvas.Handle, R.Left, R.Top, SRCCOPY);
            end
            else
              if Bmp <> nil then begin
                SrcBmp := Bmp;
                CanFree := False;
              end
              else begin
                SrcBmp := CreateBmp32(WidthOf(R), HeightOf(R));
                BitBlt(SrcBmp.Canvas.Handle, 0, 0, SrcBmp.Width, SrcBmp.Height, MasterBitmap.Canvas.Handle, R.Left, R.Top, SRCCOPY);
              end;

            h := SrcBmp.Height div 2;
            C := Palette[pcMainColor];
            if InitLine(SrcBmp, Pointer(S0), Delta) then
              for y := 0 to h - 1 do begin
                S1 := Pointer(LongInt(S0) + Delta * Y);
                S2 := Pointer(LongInt(S0) + Delta * (h + Y));
                for X := 0 to SrcBmp.Width - 1 do
                  with S1[X] do
                    if SC = sFuchsia.C then begin
                      S2[X].SC := $FFFFFF;
                      SC := C;
                      SA := 0;
                    end;
              end;

            Bmp := CreateBmp32(ScaleInt(WidthOf(R) div ImageCount) * ImageCount, ScaleInt(HeightOf(R) * iff(MaskType = 0, 2, 1) div 2) * 2);
          end
          else begin
            CanFree := False;
            SrcBmp := Bmp;
            Bmp := CreateBmp32(ScaleInt(WidthOf(R) div ImageCount) * ImageCount, ScaleInt(HeightOf(R)));
          end;
          Stretch(SrcBmp, Bmp, Bmp.Width, Bmp.Height, ftMitchell);
          MaskType := 1;
          R := MkRect(Bmp);
          if CanFree then
            SrcBmp.Free;
        end;
    end;
  end;

  function GetExtBordNdx(const sName: string): integer;
  begin
    Result := GetGlobalIndex(sName + aSfxs[iScale]);
    if (Result < 0) and (aSfxs[iScale] <> '') then
      Result := GetGlobalIndex(sName);
  end;

  procedure ReadConstElementData(var ed: TacConstElementData; const ASection: string = ''; const AltSection1: string = ''; const AltSection2: string = ''; ScaleGlyph: boolean = True);
  begin
    with ed do begin
      if ASection <> '' then
        SkinSection := ASection;

      SkinIndex  := GetSkinIndex(SkinSection);
      if SkinIndex < 0 then begin
        Skinsection := AltSection1;
        SkinIndex  := GetSkinIndex(SkinSection);
        if SkinIndex < 0 then begin
          Skinsection := AltSection2;
          SkinIndex  := GetSkinIndex(SkinSection);
        end;
      end;
      MaskIndex  := GetMaskIndex(SkinIndex, SkinSection, s_BordersMask);
      if ScaleGlyph then
        GlyphIndex := GetGlyphNdx(s_ItemGlyph, SkinIndex)
      else
        GlyphIndex := GetMaskIndex(SkinIndex, s_ItemGlyph);

      BGIndex[0] := GetMaskIndex(SkinIndex, SkinSection, s_Pattern);
      BGIndex[1] := GetMaskIndex(SkinIndex, SkinSection, s_HotPattern);
    end;
  end;

  procedure ReadTrackBarData(var Data: TacTrackBarData; Horz: boolean);
  begin
    with Data do begin
      SkinIndex  := GetSkinIndex(s_TrackBar);
      MaskIndex  := GetMaskIndex(SkinIndex, s_BordersMask);
      ProgIndex  := GetMaskIndex(SkinIndex, ProgArray[Horz]);
      TickIndex  := GetGlyphNdx(ThickArray[Horz], SkinIndex);
      SlideIndex := GetMaskIndex(SkinIndex, s_SliderChannelMask);
      if not Horz then
        GlyphIndex := GetGlyphNdx(s_SliderVertMask, SkinIndex)
      else
        GlyphIndex := -1;

      if GlyphIndex < 0 then
        GlyphIndex := GetGlyphNdx(s_SliderHorzMask, SkinIndex);

      BGIndex[0] := GetMaskIndex(SkinIndex, s_Pattern);
      BGIndex[1] := GetMaskIndex(SkinIndex, s_HotPattern);
    end;
  end;

begin
  iScale := GetScale;
  with ConstData do begin
    IndexGlobalInfo := GetSkinIndex(s_GlobalInfo);
    // Glyphs
    for CheckState := cbUnchecked to cbGrayed do
      CheckBox[CheckState] := GetGlyphNdx(acCheckGlyphs[CheckState]);

    for CheckState := cbUnchecked to cbGrayed do
      SmallCheckBox[CheckState] := GetGlyphNdx(acSmallChecks[CheckState]);

    for b := False to True do
      RadioButton[b] := GetGlyphNdx(acRadioGlyphs[b]);

    // Masks
    ExBorder        := GetExtBordNdx(s_ExBorder);
    GripRightBottom := GetGlyphNdx(s_GripImage);
    GripHorizontal  := GetGlobalIndex(s_GripHorz);
    GripVertical    := GetGlobalIndex(s_GripVert);

    ReadConstElementData(MenuItem, s_MenuItem);
    ReadConstElementData(ComboBtn, s_ComboBtn);
    ComboBtn.GlyphIndex := GetMaskIndex(s_ComboBox, s_ItemGlyph);

    // Some sections
    for tPos := tlFirst to tlSingle do
      for Side := asLeft to asBottom do
        ReadConstElementData(Tabs[tPos][Side], acTabSections[tPos][Side]);

    for b := False to True do begin
      ReadConstElementData(Sliders[b], acScrollSliders[b]);
      ReadTrackBarData(TrackBar[b], b);
    end;

    for Side := asLeft to asBottom do begin
      ReadConstElementData(ScrollBtns[Side], acScrollBtns [Side], '', '', False);
      ReadConstElementData(Scrolls   [Side], acScrollParts[Side], '', '', False);
      ReadConstElementData(UpDownBtns[Side], acUpDownBtns [Side], s_UpDown, s_Button, False);
    end;
    // Title icons
    for tg := Low(TacTitleGlyph) to High(TacTitleGlyph) do
      TitleGlyphs[tg] := GetGlyphNdx(acTitleGlyphs[tg]);

    if TitleGlyphs[tgCloseAlone] < 0 then
      TitleGlyphs[tgCloseAlone] := TitleGlyphs[tgClose];

    for tg := tgSmallClose to tgSmallHelp do
      if TitleGlyphs[tg] < 0 then
        TitleGlyphs[tg] := TitleGlyphs[TacTitleGlyph(ord(tg) - 5)];

    // Title icons glows
    for tg := tgCloseAlone to tgNormal do
      for i := 0 to Length(TitleGlows[tg]) - 1 do
        TitleGlows[tg][i] := GetGlyphNdx(acTitleGlyphs[tg] + s_Glow + IntToStr(i), ConstData.IndexGlobalInfo, True);

    if TitleGlyphs[tgCloseAlone] = TitleGlyphs[tgClose] then begin
      GlowMargins[tgCloseAlone] := GlowMargins[tgClose];
      SetLength(TitleGlows[tgCloseAlone], Length(TitleGlows[tgClose]));
      for i := 0 to Length(TitleGlows[tgCloseAlone]) - 1 do
        TitleGlows[tgCloseAlone][i] := TitleGlows[tgClose][0];
    end;

    // Some sections
    for Section := Low(Sections) to High(Sections) do
      Sections[Section] := GetSkinIndex(acSectNames[Section]);
  end;
  InitMaskIndexes;
  CheckShadows;
end;


procedure TsSkinManager.InitMaskIndexes;
var
  i: integer;

  procedure CheckBorderWidth(var AValue: SmallInt; md: TsMaskData; AVert: boolean);
  begin
    if AValue <= 0 then
      if md.BorderWidth > 0 then
        AValue := md.BorderWidth
      else
        if AVert then
          AValue := md.Height
        else
          AValue := md.Width;
  end;

begin
  for i := 0 to Length(gd) - 1 do
    if i <> ConstData.IndexGlobalInfo then
      with gd[i] do begin
        BorderIndex := GetMaskIndex(i, s_BordersMask);
        OuterMask   := GetMaskIndex(i, s_OuterMask);
        ImgTL       := GetMaskIndex(i, s_ImgTopLeft);
        ImgTR       := GetMaskIndex(i, s_ImgTopRight);
        ImgBL       := GetMaskIndex(i, s_ImgBottomLeft);
        ImgBR       := GetMaskIndex(i, s_ImgBottomRight);

        Props[0].TextureIndex := GetTextureIndex(i, ClassName, s_Pattern);
        if States > 1 then
          Props[1].TextureIndex := GetTextureIndex(i, ClassName, s_HotPattern);

        if (States > 2) and UseState2 then
          Props[2].TextureIndex := GetTextureIndex(i, ClassName, s_Pattern2)
        else
          Props[2].TextureIndex := Props[1].TextureIndex;

        if BorderIndex < 0 then
          ScrollBorderOffset := -2
        else
          if (ClassName = s_Edit) or (ClassName = s_AlphaEdit) then
            with ma[gd[i].BorderIndex] do
              if (WL = 1) and (WT = 1) and (WR = 1) and (WB = 1) then
                ScrollBorderOffset := -1
              else
                ScrollBorderOffset := 0
          else
            ScrollBorderOffset := 0;
      end;

  for i := 0 to Length(ma) - 1 do
    with ma[i] do begin
      case ImageCount of
        0:   Width := 0;
        1:   Width := WidthOf(R)
        else Width := WidthOf(R) div ImageCount;
      end;
      case MaskType of
       -1:   Height := 0;
        0:   Height := HeightOf(R);
        1:   Height := HeightOf(R) div 2
        else Height := HeightOf(R) div (MaskType + 1)
      end;
      if ImageCount = 0 then begin
        CheckBorderWidth(WT, ma[i], True);
        CheckBorderWidth(WB, ma[i], True);
        CheckBorderWidth(WL, ma[i], False);
        CheckBorderWidth(WB, ma[i], False);
        ImageCount := 1;
      end;
    end;
end;


procedure TsSkinManager.Loaded;
begin
  inherited;
  if (Options.ScaleMode <> smOldMode) and Assigned(ac_SetProcessDPIaware) then
    ac_SetProcessDPIaware;

  if FSkinDirectory = '' then
    FSkinDirectory := DefSkinsDir;

  if FMenuSupport.IcoLineSkin = '' then
    FMenuSupport.IcoLineSkin := s_MenuIcoLine;

  LoadThirdNames(Self);
  if Active and (SkinName <> '') then
    SendNewSkin(False);

{$IFDEF D2007}
  UpdateCommonDlgs(Self);
{$ENDIF}
  if ([csLoading, csReading] * ComponentState = []) and Assigned(InitDevEx) then
    InitDevEx(Active and (SkinName <> ''));

  if Assigned(FOnActivate) and FActive and not (csDesigning in ComponentState) then
    FOnActivate(Self);

  SkinListController.UpdateData(False);
end;


{$IFNDEF DELPHI2005}
procedure TsSkinManager.OnCheckHot(Sender: TObject);
var
  R: TRect;
begin
  if FActiveControl <> 0 then begin
    GetWindowRect(FActiveControl, R);
    if not PtInRect(R, acMousePos) then begin
      ActiveControl := 0;
      ActiveGraphControl.Perform(SM_ALPHACMD, AC_MOUSELEAVE_HI, LPARAM(ActiveGraphControl));
    end;
  end;
end;
{$ENDIF}


procedure TsSkinManager.SendNewSkin(Repaint: boolean = True);
var
  M: TMessage;
  i: integer;
begin
  if [csLoading, csReading] * ComponentState = [] then begin
    if IsDefault then
      ClearGlows;

    if not (csDesigning in ComponentState) and Repaint then
      LockForms(Self);

{$IFNDEF FPC}
    SkinableMenus.SkinBorderWidth := -1;
{$ENDIF}

    CommonSkinData.Active := False;
    RestrictDrawing := True;

    M.Msg := SM_ALPHACMD;
    M.WParam := AC_SETNEWSKIN_HI;
    M.LParam := LPARAM(Self);
    M.Result := 0;
    if csDesigning in ComponentState then
      for i := 0 to Screen.FormCount - 1 do begin
        with Screen.Forms[i] do
          if (Name = '') or (Name = 'AppBuilder') or (Name = 'PropertyInspector') then
            Continue;

        AlphaBroadCast(Screen.Forms[i], M);
        SendToHooked(M);
      end
      else
        AppBroadCastS(M);

    RestrictDrawing := False;
    CommonSkinData.Active := True;
    if (DefaultManager = Self) and not GlobalHookInstalled then
      InstallHook;

    if Assigned(InitDevEx) then
      InitDevEx(True);

    if Assigned(RefreshDevEx) then
      RefreshDevEx;

    if Repaint then
      RepaintForms(False);
  end;
end;


procedure TsSkinManager.SendRemoveSkin;
var
  M: TMessage;
  i: integer;
begin
  if IsDefault and Assigned(InitDevEx) then
    InitDevEx(False);

{$IFNDEF ALITE}
  if acIntController <> nil then
    acIntController.KillAllForms(nil);
{$ENDIF}

  SkinRemoving := True;
  ClearGlows;
  UninstallHook;
  CommonSkinData.Active := False;
  M.Msg := SM_ALPHACMD;
  M.WParam := AC_REMOVESKIN_HI;
  M.LParam := LPARAM(Self);
  M.Result := 0;
  if csDesigning in ComponentState then
    for i := 0 to Screen.FormCount - 1 do begin
      with Screen.Forms[i] do
        if (Name = '') or (Name = 'AppBuilder') or (pos('EditWindow_', Name) > 0) or (pos('DockSite', Name) > 0) or (Name = 'PropertyInspector') then
          Continue;

      AlphaBroadCast(Screen.Forms[i], M);
      SendToHooked(M);
    end
  else
    AppBroadCastS(M);

  FreeBitmaps;
  SetLength(gd, 0);
  SkinRemoving := False;
end;


procedure TsSkinManager.SetActive(const Value: boolean);
begin
  if FActive <> Value then begin
    FActive := Value;
    if not Value then begin
      if FSkinName <> '' then begin
        if not (csLoading in ComponentState) then
          SendRemoveSkin;

        InitConstantIndexes;
{$IFDEF D2007}
        UpdateCommonDlgs(Self);
{$ENDIF}
        if Assigned(FOnDeactivate) and ([csDesigning, csDestroying] * ComponentState = []) then
          FOnDeactivate(Self);
      end;
    end
    else
      SkinName := FSkinName;
  end;
  SkinListController.SendSkinChanged;
end;


procedure TsSkinManager.SetBuiltInSkins(const Value: TsStoredSkins);
begin
  FBuiltInSkins.Assign(Value);
end;


procedure TsSkinManager.SetCommonSections(const Value: TStringList);
var
  i: integer;
  s: string;
begin
  FCommonSections.Assign(Value);
  for i := 0 to FCommonSections.Count - 1 do begin
    s := FCommonSections[i];
    if (s <> '') and (s[1] <> ';') then
      FCommonSections[i] := acntUtils.DelChars(s, s_Space);
  end;
  SkinName := SkinName;
end;


procedure TsSkinManager.SetSkinDirectory(const Value: string);
begin
  if FSkinDirectory <> Value then begin
    FSkinDirectory := Value;
    CommonSkinData.SkinPath := GetFullSkinDirectory;
    SkinListController.UpdateData(False);
    if Assigned(FOnSkinListChanged) then
      FOnSkinListChanged(Self);
  end;
end;


procedure TsSkinManager.SetSkinName(const Value: TsSkinName);
var
  s, OldName, s1: string;
begin
  OldName := FSkinName;
  FSkinName := Value;
  if FActive then begin
    if Assigned(FOnBeforeChange) then
      FOnBeforeChange(Self);
    // Save form image to layered window if ExtendedBorders
    if ExtendedBorders and not NoAutoUpdate and AnimEffects.SkinChanging.Active and Effects.AllowAnimation then
      CopyExForms(Self);

    aSkinChanging := True;
    CommonSkinData.Active := False;
    s := Value;
    if Length(Value) > 4 then begin
      s1 := Copy(Value, Length(Value) - 3, 4);
      if UpperCase(s1) = UpperCase(s_Dot + acSkinExt) then begin
        Delete(s, Length(Value) - 3, 4);
        FSkinName := s;
      end;
    end;
    s := NormalDir(SkinDirectory) + s + s_Dot + acSkinExt;
    SkinIsPacked := False;
    if UnPackedFirst and acDirExists(NormalDir(SkinDirectory) + Value) then
      SkinIsPacked := False
    else
      SkinIsPacked := FileExists(s);

    try
      if SkinIsPacked then
        ReloadPackedSkin
      else
        ReloadSkin;
    except
      on E: Exception do begin
        FSkinName := OldName;
        ShowError(E.Message);
      end;
    end;

    if FActive then begin
      if not NoAutoUpdate then
        SendNewSkin;
    end
    else
      SendRemoveSkin;

    if Assigned(FOnActivate) and ([csDesigning, csLoading] * ComponentState = []) then
      FOnActivate(Self);

    aSkinChanging := False;
    if not NoAutoUpdate and Assigned(OnAfterChange) then
      FOnAfterChange(Self);
  end;
  SkinListController.SendSkinChanged;
{$IFDEF D2007}
  UpdateCommonDlgs(Self);
{$ENDIF}
end;


{$IFNDEF FPC}
procedure TsSkinManager.SetSkinnedPopups(const Value: boolean);
begin
  if FSkinnedPopups <> Value then begin
    FSkinnedPopups := Value;
    if not (csDesigning in ComponentState) and FSkinnedPopups and (SkinableMenus <> nil) and IsDefault then
      if FSkinnedPopups then
        SkinableMenus.UpdateMenus
      else
        SkinableMenus.InitItems(False);
  end;
end;
{$ENDIF}


procedure TsSkinManager.SetKeyList(const Value: TStringList);
begin
  FKeyList.Assign(Value);
end;


procedure TsSkinManager.SetSkinInfo(const Value: TacSkinInfo);
begin
  //
end;


procedure TsSkinManager.SetVersion(const Value: string);
begin
  //
end;


type
  TAccessControl = class(TWinControl);


procedure TsSkinManager.UpdateScale(Ctrl: TWinControl; iCurrentScale: integer = 100);
const
  SWP_HIDE = SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_HIDEWINDOW;
  SWP_SHOW = SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_SHOWWINDOW;
var
  R: TRect;
  b, IsVisible: boolean;
  w, h, iOldScale, iNewScale: integer;
begin
  iOldScale := Ctrl.Perform(SM_ALPHACMD, AC_GETSCALE shl 16, 0);
  if iOldScale = 0 then
    iOldScale := iCurrentScale;

  // If system scale not changed
{
  if SysFontScale = 0 then
    iNewScale := aScalePercents[GetScale]
  else
}
    iNewScale := aScalePercents[GetScale];
//    iNewScale := 100;

  if iNewScale <> iOldScale then
    with TAccessControl(Ctrl) do begin
      w := MulDiv(Width, iNewScale, iOldScale);
      h := MulDiv(Height, iNewScale, iOldScale);
      R := BoundsRect;

      b := Effects.AllowAnimation;
      Effects.AllowAnimation := False;
      IsVisible := HandleAllocated and IsWindowVisible(Handle);

      if IsVisible then
        SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_HIDE);

      DisableAlign;
      ChangeScale(iNewScale, iOldScale);

      SetBounds(R.Left, R.Top, w, h);
      Perform(SM_ALPHACMD, AC_SETSCALE_HI, iNewScale);

      EnableAlign;
      if IsVisible then
        SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_SHOW);

      Effects.AllowAnimation := b;
    end;
end;


procedure TsSkinManager.UpdateSkin(Repaint: boolean = True);
begin
  if Active then
    SendNewSkin(Repaint);
end;


procedure TsSkinManager.UpdateSkinSection(const SectionName: string);
var
  M: TMessage;
  i: integer;
  s: string;
begin
  M.Msg := SM_ALPHACMD;
  M.WParamHi := AC_UPDATESECTION;
  s := UpperCase(SectionName);
  M.LParam := integer(PChar(s));
  M.Result := 0;
  if csDesigning in ComponentState then
    for i := 0 to Screen.FormCount - 1 do
      AlphaBroadCast(Screen.Forms[i], M)
  else
    AppBroadCastS(M);
end;


procedure TsSkinManager.RepaintForms(DoLockForms: boolean = True);
var
  ap: TacProvider;
  M: TMessage;
  i: integer;
begin
  M.Msg := SM_ALPHACMD;
  M.LParam := LPARAM(Self);
  if not (csDesigning in ComponentState) then begin
    M.WParam := AC_STOPFADING_HI;
    M.Result := 0;
    AppBroadCastS(M);
  end;
  M.WParam := AC_REFRESH_HI;
  M.Result := 0;
  if csDesigning in ComponentState then
    for i := 0 to Screen.FormCount - 1 do begin
      with Screen.Forms[i] do
        if (Name = '') or (Name = 'AppBuilder') or (Name = 'PropertyInspector') then
          Continue;

      AlphaBroadCast(Screen.Forms[i], M);
      SendToHooked(M);
    end
    else
      if not (csLoading in ComponentState) {and (Application.MainForm <> nil) Changing in DLL}then begin
        if DoLockForms then
          LockForms(Self);

        AppBroadCastS(M);
        UnLockForms(Self, not NoAutoUpdate);
      end
      else
        AppBroadCastS(M);

  if Assigned(acMagnForm) then
    SendMessage(acMagnForm.Handle, M.Msg, M.WParam, M.LParam);
  // Repaint dialogs
  if acSupportedList <> nil then
    for i := 0 to acSupportedList.Count - 1 do begin
      ap := TacProvider(acSupportedList[i]);
      if (ap <> nil) and (ap.ListSW <> nil) and IsWindowVisible(ap.ListSW.CtrlHandle) then
        RedrawWindow(ap.ListSW.CtrlHandle, nil, 0, RDWA_ALL);
    end;
end;


procedure TsSkinManager.SetHueOffset(const Value: integer);
begin
  if FHueOffset <> Value then begin
    FHueOffset := Value;
    UpdateCurrentSkin;
  end;
end;


procedure TsSkinManager.SetSaturation(const Value: integer);
begin
  if FSaturation <> Value then begin
    FSaturation := Value;
    UpdateCurrentSkin;
  end;
end;


function TsSkinManager.GetActiveEditColor: TColor;
begin
  Result := Palette[pcEditBG];
end;


function TsSkinManager.GetActiveEditFontColor: TColor;
begin
  Result := Palette[pcEditText];
end;


function TsSkinManager.GetHighLightColor(Focused: boolean = True): TColor;
begin
  Result := iff(Focused, Palette[pcSelectionBG_Focused], Palette[pcSelectionBG]);
end;


function TsSkinManager.GetHighLightFontColor(Focused: boolean = True): TColor;
begin
  Result := iff(Focused, Palette[pcSelectionText_Focused], Palette[pcSelectionText]);
end;


function TsSkinManager.IsValidImgIndex(ImageIndex: integer): boolean;
begin
  Result := (ImageIndex >= 0) and (ImageIndex < Length(ma));
end;


function TsSkinManager.IsValidSkinIndex(SkinIndex: integer): boolean;
begin
  Result := {(CommonSkinData <> nil) and} (SkinIndex >= 0) and (SkinIndex < Length(gd));
end;


function CopyInt(s: string; Pos, Size: integer): integer;
begin
  Result := StrToInt(Copy(s, Pos, Size));
end;


function CopyRect(s: string; Pos: integer): TRect;
begin
  Result := Rect(CopyInt(s, Pos, 4), CopyInt(s, Pos + 5, 4), CopyInt(s, Pos + 10, 4), CopyInt(s, Pos + 15, 4));
end;


procedure TsSkinManager.LoadAllMasks;
var
  i, j, l, iGlobal, iScale, iMasterBmp: integer;
  Sections, Values: TStringList;
  sf: TMemIniFile;
  s: string;

  function AddExternalItem(s: string; Stream: TMemoryStream; aMaskType: integer = 0): TBitmap;
  var
    n: integer;
    sName: string;
    TempJpg: TacJpegClass;
  begin
    Result := nil;
    if Stream = nil then begin
      if pos(':', s) <= 0 then
        sName := CommonSkinData.SkinPath + s
      else
        sName := s;

      if not FileExists(sName) then
        Exit;
    end;
    n := Length(ExtArray);
    SetLength(ExtArray, n + 1);
    with ExtArray[n] do begin
      FileName := s;
      MaskType := aMaskType;
      if Stream <> nil then
        Stream.Seek(0, 0);

      Bmp := TBitmap.Create;
      if pos('.BMP', s) > 0 then
        if Stream = nil then
          Bmp.LoadFromFile(sName)
        else
          Bmp.LoadFromStream(Stream)
      else
        if (pos('.JPG', s) > 0) or (pos('.JPEG', s) > 0) then begin
          TempJpg := TacJpegClass.Create;
          if Stream = nil then
            TempJpg.LoadFromFile(sName)
          else
            TempJpg.LoadFromStream(Stream);

          Bmp.Width  := TempJpg.Width;
          Bmp.Height := TempJpg.Height;
          Bmp.Canvas.Draw(0, 0, TempJpg);
          TempJpg.Free;
        end
        else
          if pos('.PNG', s) > 0 then begin
            if Stream = nil then
              LoadBmpFromPngFile(Bmp, sName)
            else
              LoadBmpFromPngStream(Bmp, Stream);

            if FBrightness <= 0 then // Otherwise updated later (after changing of brightness)
              if CommonSkindata.Version > acTranspVer then // New mode of layered wnd
                UpdateAlpha(Bmp, MkRect(Bmp));
          end;

      if Bmp.PixelFormat <> pf32bit then begin
        SetBmp32Pixels(Bmp);
        FillAlphaRect(Bmp, MkRect(Bmp), MaxByte, clFuchsia);
      end;
      Result := Bmp;
    end;
  end;

  procedure LoadExtFile(s: string; var Item: TsMaskData; Delimiter: char);
  var
    sName: string;
    i: integer;
  begin
    sName := ExtractWord(7, s, [Delimiter]);
    Item.Bmp := SearchExtFile(sName);
    if Item.Bmp = nil then // If without bmp still - loading
      if SkinIsPacked then
        for i := 0 to sc.ImageCount - 1 do begin
          if UpperCase(sc.Files[i].FileName) = sName then begin
            Item.Bmp := AddExternalItem(sName, sc.Files[i].FileStream);
            Break; // Found and loaded
          end;
        end
      else
        Item.Bmp := AddExternalItem(sName, nil);
  end;

  procedure LoadTexture(s: string);
  var
    m, NewNdx: integer;
  begin
    if Length(s) > 24 then
      m := CopyInt(s, 25, 1)
    else
      m := 0;

    NewNdx := MakeNewItem(i, Values[j], Sections[i], itisaTexture, CopyRect(s, 2), 1, CopyInt(s, 22, 2), m);
    if Length(s) > 26 then // If external file
      LoadExtFile(s, ma[NewNdx], TexChar);
  end;

  procedure LoadBorder(s: string);
  var
    l: integer;
  begin
    if iScale > 0 then // Search a better source
      s := UpperCase(sf.ReadString(Sections[i], Values[j] + aSfxs[iScale], s));

    l := MakeNewItem(i, Values[j], Sections[i], acImgTypes[Min(ExtInt(4, s, [CharExt]), Length(acImgTypes) - 1)], CopyRect(s, 2), CopyInt(s, 42, 1), CopyInt(s, 46, 1), CopyInt(s, 44, 1));
    with ma[l] do begin
      WL := CopyInt(s, 22, 4);
      WT := CopyInt(s, 27, 4);
      WR := CopyInt(s, 32, 4);
      WB := CopyInt(s, 37, 4);
      BorderWidth := CopyInt(s, 48, 1);
      if WL + WT + WR + WB = 0 then // If BorderWidths are not defined
        if BorderWidth <> 0 then begin
          WL := BorderWidth;
          WT := BorderWidth;
          WR := BorderWidth;
          WB := BorderWidth;
        end
        else begin
          WL := WidthOf(R) div (ImageCount * 3);
          WT := HeightOf(R) div ((1 + MaskType) * 3);
          WR := WL;
          WB := WT;
        end;

      CornerType := GetCornerType(Self, ma[l]);
    end;
  end;

  procedure LoadExternal(s: string);
  var
    c, NewNdx: integer;
    sName, sExt: string;
    Bmp: TBitmap;
  begin
    if iScale > 0 then begin // Search a better source
      sName := UpperCase(sf.ReadString(Sections[i], Values[j] + aSfxs[iScale], ''));
      if sName <> '' then begin
        s := sName;
        sExt := aSfxs[iScale];
      end;
    end;
    sName := ExtractWord(1, s, [CharExt]);
    Bmp := SearchExtFile(sName);
    if Bmp = nil then // If without bmp still - loading
      if SkinIsPacked then begin
        for c := 0 to sc.ImageCount - 1 do
          if UpperCase(sc.Files[c].FileName) = sName then begin
            // Add Bitmap to external bitmaps list
            Bmp := AddExternalItem(sName, sc.Files[c].FileStream);
            Break; // Found and loaded
          end;
      end
      else
        Bmp := AddExternalItem(sName, nil);

    if (Bmp <> nil) and (Bmp.Width > 0) then begin
      if pos(CharExt, s) > 0 then
        NewNdx := MakeNewItem(i, Values[j], Sections[i], acImgTypes[Min(ExtInt(4, s, [CharExt]), Length(acImgTypes) - 1)],
                              MkRect(Bmp), ExtInt(2, s, [CharExt]), 0, ExtInt(3, s, [CharExt]))
      else
        NewNdx := MakeNewItem(i, Values[j], Sections[i], itisaTexture, MkRect(Bmp), 1, 0, 0);

      ma[NewNdx].Bmp := Bmp;
      ma[NewNdx].PropertyName := ma[NewNdx].PropertyName + sExt;
      Bmp.Canvas.Handle;
      Bmp.Canvas.Lock;
      with ma[NewNdx] do begin
        if WordCount(s, [CharExt]) > 4 then begin // if border widths are defined
          WL := ExtInt(5, s, [CharExt]);
          WT := ExtInt(6, s, [CharExt]);
          WR := ExtInt(7, s, [CharExt]);
          WB := ExtInt(8, s, [CharExt]);
        end
        else begin
          WL := WidthOf(R)  div (ImageCount * 3);
          WT := HeightOf(R) div ((1 + MaskType) * 3);
          WR := WL;
          WB := WT;
        end;

        if WordCount(s, [CharExt]) > 8 then
          DrawMode := ExtInt(9, s, [CharExt])
        else
          DrawMode := 0;

        if ImgType = itisaBorder then
          CornerType := GetCornerType(Self, ma[NewNdx]);
      end;
    end;
  end;

begin
  FreeBitmaps;
  if SkinFile <> nil then begin
    iScale := GetScale;
    sf := SkinFile;
    CommonSkinData.Version := GetSkinVersion(sf);
    // Reading of the MasterBitmap if exists
    s := sf.ReadString(s_GlobalInfo, s_MasterBitmap, '');
    MasterBitmap := TBitmap.Create;
    if SkinIsPacked then begin
      for i := 0 to sc.ImageCount - 1 do
        if UpperCase(sc.Files[i].FileName) = s then begin
          sc.Files[i].FileStream.Seek(0, 0);
          MasterBitmap.LoadFromStream(sc.Files[i].FileStream);
          MasterBitmap.Canvas.Handle;
          MasterBitmap.Canvas.Lock;
          Break;
        end
    end
    else begin
      if pos(':', s) <= 0 then
        s := CommonSkinData.SkinPath + s;

      if (s <> '') and FileExists(s) then
        MasterBitmap.LoadFromFile(s);
    end;
    if MasterBitmap.PixelFormat <> pf32bit then begin
      MasterBitmap.PixelFormat := pf32bit;
      FillAlphaRect(MasterBitmap, MkRect(MasterBitmap), MaxByte, clFuchsia);
    end;
    MasterBitmap.Transparent := True;
    MasterBitmap.TransparentColor := clFuchsia;
    MasterBitmap.HandleType := bmDIB;
    Sections := TStringList.Create;
    SetCaseSens(Sections);
    Values := TStringList.Create;
    iGlobal := -1;
    iMasterBmp := -1;
    SetCaseSens(Values);
    try
      sf.ReadSections(Sections);
      for i := 0 to Sections.Count - 1 do begin
        if (iGlobal < 0) and (Sections[i] = s_GlobalInfo) then
          iGlobal := i;

        sf.ReadSection(Sections[i], Values);
        // Search and load all images from section
        for j := 0 to Values.Count - 1 do begin
          if (i = iGlobal) and (iMasterBmp = -1) and (Values[j] = s_MasterBitmap) then begin
            iMasterBmp := j;
            Continue;
          end;
          s := UpperCase(sf.ReadString(Sections[i], Values[j], ''));
          if s <> '' then
            case s[1] of
              TexChar: LoadTexture(s);
              CharGlyph: MakeNewItem(i, Values[j], Sections[i], itisaGlyph, CopyRect(s, 2), CopyInt(s, 22, 1), 0, CopyInt(s, 24, 1));
              CharMask:
                if pos('*', Values[j]) = 0 then // Ignore non standard property
                  LoadBorder(s);

              CharExt: begin
                if pos('*', Values[j]) = 0 then // Ignore non standard property
                  LoadExternal(s);
              end

              else
                if (pos('.JPG', s) > 0) or (pos('.BMP', s) > 0) then
                  LoadExternal(s);
            end
        end;
      end;
    finally
      FreeAndNil(Values);
      FreeAndNil(Sections);
      sf := nil;
    end;
  end;

  if CommonSections.Count > 0 then begin
    sf := TMemInifile.Create('');
    SetCaseSens(sf);
    sf.SetStrings(CommonSections);

    Sections := TStringList.Create;
    SetCaseSens(Sections);

    Values := TStringList.Create;
    SetCaseSens(Values);
    try
      sf.ReadSections(Sections);
      sf.SetStrings(CommonSections);
      for i := 0 to Sections.Count - 1 do begin
        if UpperCase(Sections[i]) = s_GlobalInfo then
          Continue;

        sf.ReadSection(Sections[i], Values);
        for j := 0 to Values.Count - 1 do begin
          s := AnsiUpperCase(sf.ReadString(Sections[i], Values[j], CharMinus));
          if pos('.BMP', s) > 0 then begin
            if pos(':', s) <= 0 then
              s := CommonSkinData.SkinPath + s;

            if FileExists(s) then begin
              l := Length(ma) + 1;
              SetLength(ma, l);
              with ma[l - 1] do begin
                PropertyName := '';
                ClassName := '';
                Manager := Self;
                try
                  Bmp := TBitmap.Create;
                  Bmp.LoadFromFile(s);
                  if Bmp.PixelFormat <> pf32bit then begin
                    Bmp.PixelFormat := pf32bit;
                    FillAlphaRect(Bmp, MkRect(Bmp), MaxByte, clFuchsia);
                  end;
                finally
                  PropertyName := UpperCase(Values[j]);
                  ClassName := UpperCase(Sections[i]);
                end;
                if Bmp.Width <= 0 then begin
                  FreeAndNil(Bmp);
                  SetLength(ma, l - 1);
                end
              end;
            end
          end
        end
      end;
    finally
      FreeAndNil(Values);
      FreeAndNil(sf);
      FreeAndNil(Sections);
    end;
  end;
end;


procedure TsSkinManager.FreeBitmaps;
var
  j, l: integer;
begin
  while Length(ma) > 0 do begin
    l := Length(ma) - 1;
    with ma[l] do
      if Bmp <> nil then begin
        for j := 0 to Length(ExtArray) - 1 do
          if Bmp = ExtArray[j].Bmp then begin
            Bmp := nil; // Will be destroyed in ClearExtArray
            Break;
          end;

        if Bmp <> nil then
          FreeAndNil(Bmp);
      end;

    SetLength(ma, l);
  end;
  ClearExtArray;
  if Assigned(MasterBitmap) then
    FreeAndNil(MasterBitmap);
end;


procedure CopyProperties(var Dst, Src: TsGenState);
var
  i: integer;
begin
  with Src do begin
    Dst.Color           := Color;
    Dst.FontColor       := FontColor;
    Dst.ImagePercent    := ImagePercent;
    Dst.TextureIndex    := TextureIndex;
    Dst.GlowSize        := GlowSize;
    Dst.Transparency    := Transparency;
    Dst.GlowColor       := GlowColor;
    Dst.GradientPercent := GradientPercent;
    SetLength(Dst.GradientArray, Length(GradientArray));
    for i := 0 to Length(GradientArray) - 1 do
      Dst.GradientArray[i] := GradientArray[i];
  end;
end;


procedure TsSkinManager.LoadAllGeneralData;
type
  TacGetInteger = function(const ClassName, PropertyName: string; DefaultValue: integer; MaxValue: integer = MaxInt): integer;
const
  acMaxBlur = 5;

  acPropsArray: array [0..ac_MaxPropsIndex, 0..11] of string =
    ((s_Color,    s_FontColor,    s_TCLeft,    s_TCTop,    s_TCRight,    s_TCBottom,    s_GlowColor,    s_GlowSize,    s_GradientPercent,    s_GradientData,    s_ImagePercent,    s_Transparency),
     (s_HotColor, s_HotFontColor, s_HotTCLeft, s_HotTCTop, s_HotTCRight, s_HotTCBottom, s_HotGlowColor, s_HotGlowSize, s_HotGradientPercent, s_HotGradientData, s_HotImagePercent, s_HotTransparency),
     (s_Color2,   s_FontColor2,   s_TCLeft2,   s_TCTop2,   s_TCRight2,   s_TCBottom2,   s_GlowColor2,   s_GlowSize2,   s_GradientPercent2,   s_GradientData2,   s_ImagePercent2,   s_Transparency2)
    );

  acDefProp: TsGenState = (
    GlowSize:        0;
    ImagePercent:    0;
    TextureIndex:   -1;
    Transparency:    0;
    GradientPercent: 0;
    Color:           $FFFFFF;
    GlowColor:       $FFFFFF;
    FontColor: (
      Color:   0;
      Left:   -1;
      Top:    -1;
      Right:  -1;
      Bottom: -1
    );
  );
var
  iScale, i, j, l, SkinIndex, ParentIndex: integer;
  gData, gTempData, acDefGenData: TsGeneralData;
  ColorItem: TacPaletteColors;
  Sections, Ini: TStringList;
  sf: TMemIniFile;
  s: string;

  function FindString(const ClassName, PropertyName, DefaultValue: string): string;
  var
    s: string;
  begin
    Result := sf.ReadString(ClassName, PropertyName, CharQuest);
    if Result = CharQuest then begin
      s := sf.ReadString(ClassName, s_ParentClass, CharQuest);
      if (s <> '') and (s <> CharQuest) and (s <> ClassName) then
        Result := FindString(s, PropertyName, CharQuest);

      if Result = CharQuest then
        Result := DefaultValue;
    end;
  end;

  function FindBoolean(const ClassName, PropertyName: string; DefaultValue: boolean): boolean;
  var
    s: string;
  begin
    s := sf.ReadString(ClassName, PropertyName, CharQuest);
    if s = CharQuest then begin
      s := sf.ReadString(ClassName, s_ParentClass, CharQuest);
      if (s <> '') and (s <> CharQuest) and (s <> ClassName) then
        s := FindString(s, PropertyName, CharQuest);
    end;
    if s = CharQuest then
      Result := DefaultValue
    else
      Result := (s = s_TrueStr) or (s = CharOne);
  end;

  function FindInteger(const ClassName, PropertyName: string; DefaultValue: integer; MaxValue: integer = MaxInt): integer;
  var
    s: string;
  begin
    Result := sf.ReadInteger(ClassName, PropertyName, -1);
    if Result < 0 then begin
      s := sf.ReadString(ClassName, s_ParentClass, CharQuest);
      if (s <> '') and (s <> CharQuest) and (s <> ClassName) then
        Result := FindInteger(s, PropertyName, -1);

      if Result < 0 then
        Result := DefaultValue
      else
        Result := ColorToRGB(Result);
    end;
    if MaxValue < Result then
      Result := MaxValue;
  end;


  function GetPropInteger(const Section, Name: string; AlternateValue: integer): integer;
  begin
    Result := acntUtils.ReadIniInteger(Ini, Sections, Section, Name, -1);
    if Result < 0 then
      Result := AlternateValue;
  end;


  function GetPropBool(const Section, Name: string; AlternateValue: boolean): boolean;
  var
    s: string;
  begin
    s := UpperCase(acntUtils.ReadIniString(Ini, Sections, Sections[i], Name, CharQuest));
    if s = CharQuest then
      Result := AlternateValue
    else
      Result := (s = CharOne) or (s = s_TrueStr);
  end;


  function GetPropStr(const Section, Name, AlternateValue: string): string;
  var
    s: string;
  begin
    s := acntUtils.ReadIniString(Ini, Sections, Section, Name, CharQuest);
    Result := iff(s = CharQuest, AlternateValue, s);
  end;


  procedure MakeMask(var oed: TacOutEffData; sPropName: string);
  var
    s: string;
    ResBmp: TBitmap;
    Size, wd2, Ndx: integer;
    par: array [0..2] of TPoint;
  begin
    case oed.Source of
      0:
        oed.Mask := -1;

      1: begin
        s := sf.ReadString(s_GlobalInfo, sPropName, '');
        if s <> '' then begin
          Size := MakeNewItem(i, sPropName, s_GlobalInfo, itisaBorder, CopyRect(s, 2), CopyInt(s, 42, 1), CopyInt(s, 46, 1), CopyInt(s, 44, 1));
          with ma[Size] do begin
            WL := CopyInt(s, 22, 4);
            WT := CopyInt(s, 27, 4);
            WR := CopyInt(s, 32, 4);
            WB := CopyInt(s, 37, 4);
            BorderWidth := CopyInt(s, 48, 1);
            CornerType := 0;
          end;
          oed.Mask := Size;
        end
        else
          oed.Mask := -1;
      end

      else begin
        ResBmp := TBitmap.Create;
        ResBmp.LoadFromResourceName(hInstance, 'BLUR5');
        Size := ResBmp.Width;
        wd2 := Size div 2;
        if oed.WidthL = -1 then oed.WidthL := wd2;
        if oed.WidthT = -1 then oed.WidthT := wd2;
        if oed.WidthR = -1 then oed.WidthR := wd2;
        if oed.WidthB = -1 then oed.WidthB := wd2;
        Ndx := MakeNewItem(i, sPropName, s_GlobalInfo, itisaBorder, MkRect(Size, Size * 2), 1, 1, 1);
        with ma[Ndx] do begin
          Bmp := CreateBmp32(Size, Size * 2);
          BorderWidth := wd2;
          WL := BorderWidth;
          WT := BorderWidth;
          WR := BorderWidth;
          WB := BorderWidth;
          // Paint
          // Bottom bevel color
          FillDC(Bmp.Canvas.Handle, MkRect(Size, wd2), oed.ColorT);
          // Top bevel color
          FillDC(Bmp.Canvas.Handle, MkRect(0, wd2, Size, Size), oed.ColorB);
          Bmp.Canvas.Brush.Style := bsSolid;
          Bmp.Canvas.Pen.Style := psSolid;
          // Left bevel color
          Bmp.Canvas.Brush.Color := oed.ColorL;
          Bmp.Canvas.Pen.Color := oed.ColorL;
          par[0] := Point(0, 1);
          par[1] := Point(wd2 - 1, wd2);
          par[2] := Point(0, Size - 2);
          Bmp.Canvas.Polygon(par);
          // Right bevel color
          Bmp.Canvas.Brush.Color := oed.ColorR;
          Bmp.Canvas.Pen.Color := oed.ColorR;
          par[0] := Point(Size - 1, 1);
          par[1] := Point(wd2 + 1, wd2);
          par[2] := Point(Size - 1, Size - 2);
          Bmp.Canvas.Polygon(par);
          // Copy mask
          BitBlt(Bmp.Canvas.Handle, 0, Size, Size, Size, ResBmp.Canvas.Handle, 0, 0, SRCCOPY);
          oed.Mask := Ndx;
        end;
        ResBmp.Free;
      end;
    end;
  end;


  procedure FillProps(var Props: TsGenState; DefProps: TsGenState; State: smallint; CommonSection: boolean);
  var
    GradientData: string;
  begin
    if not CommonSection then begin
      Props.Color            := FindInteger(s, acPropsArray[State, 0], DefProps.Color);
      Props.FontColor.Color  := FindInteger(s, acPropsArray[State, 1], DefProps.FontColor.Color);
      Props.FontColor.Left   := FindInteger(s, acPropsArray[State, 2], DefProps.FontColor.Left);
      Props.FontColor.Top    := FindInteger(s, acPropsArray[State, 3], DefProps.FontColor.Top);
      Props.FontColor.Right  := FindInteger(s, acPropsArray[State, 4], DefProps.FontColor.Right);
      Props.FontColor.Bottom := FindInteger(s, acPropsArray[State, 5], DefProps.FontColor.Bottom);
      Props.GlowColor        := FindInteger(s, acPropsArray[State, 6], DefProps.GlowColor);
      Props.GlowSize         := FindInteger(s, acPropsArray[State, 7], DefProps.GlowSize);
      Props.GradientPercent  := FindInteger(s, acPropsArray[State, 8], DefProps.GradientPercent);
      GradientData           := FindString (s, acPropsArray[State, 9], s_Space);
      Props.ImagePercent     := FindInteger(s, acPropsArray[State,10], DefProps.ImagePercent);
      Props.Transparency     := FindInteger(s, acPropsArray[State,11], DefProps.Transparency);
    end
    else begin
      Props.Color            := GetPropInteger(Sections[i], acPropsArray[State, 0], DefProps.Color);
      Props.FontColor.Color  := GetPropInteger(Sections[i], acPropsArray[State, 1], DefProps.FontColor.Color);
      Props.FontColor.Left   := GetPropInteger(Sections[i], acPropsArray[State, 2], DefProps.FontColor.Left);
      Props.FontColor.Top    := GetPropInteger(Sections[i], acPropsArray[State, 3], DefProps.FontColor.Top);
      Props.FontColor.Right  := GetPropInteger(Sections[i], acPropsArray[State, 4], DefProps.FontColor.Right);
      Props.FontColor.Bottom := GetPropInteger(Sections[i], acPropsArray[State, 5], DefProps.FontColor.Bottom);
      Props.GlowColor        := GetPropInteger(Sections[i], acPropsArray[State, 6], DefProps.GlowColor);
      Props.GlowSize         := GetPropInteger(Sections[i], acPropsArray[State, 7], DefProps.GlowSize);
      Props.GradientPercent  := GetPropInteger(Sections[i], acPropsArray[State, 8], DefProps.GradientPercent);
      GradientData           := GetPropStr    (Sections[i], acPropsArray[State, 9], s_Space);
      Props.ImagePercent     := GetPropInteger(Sections[i], acPropsArray[State,10], DefProps.ImagePercent);
      Props.Transparency     := GetPropInteger(Sections[i], acPropsArray[State,11], DefProps.Transparency);
    end;
    if Length(GradientData) > 2 then
      PrepareGradArray(GradientData, Props.GradientArray)
    else
      Props.GradientPercent := 0;
  end;


  procedure LoadGlobalData;
  var
    tg: TacTitleGlyph;

    function GlobalInteger(Name: string; Def: integer): integer;
    begin
      Result := sf.ReadInteger(s_GlobalInfo, Name, Def);
    end;

    function ScaledInteger(Name: string; Def: integer): integer;
    begin
      Result := sf.ReadInteger(s_GlobalInfo, Name + aSfxs[iScale], -1);
      if (Result < 0) and (aSfxs[iScale] <> '') then // Make new scaled value
        Result := sf.ReadInteger(s_GlobalInfo, Name, Def) * aScalePercents[iScale] div 100
    end;

  begin
    with CommonSkinData, ConstData do begin
      iScale := GetScale;
      Author        := sf.ReadString(s_GlobalInfo, s_Author,      '');
      Description   := sf.ReadString(s_GlobalInfo, s_Description, '');

      ExBorderWidth := GlobalInteger(s_BorderWidth,    4);

      // << Scaled values
      ExTitleHeight := ScaledInteger(s_TitleHeight,   30); if ExTitleHeight <= 0 then ExTitleHeight := 30;
      ExMaxHeight   := ScaledInteger(s_MaxTitleHeight, 0); if ExMaxHeight   <= 0 then ExMaxHeight   := ExTitleHeight;
      ExCenterOffs  := ScaledInteger(s_CenterOffset,   0);
      // Scaled values >>
      ExContentOffs := GlobalInteger(s_FormOffset, GetSystemMetrics(SM_CXSIZEFRAME));
      ExDrawMode    := GlobalInteger(s_BorderMode,     0);

      BrightMin     := GlobalInteger(s_BrightMin,    -50);
      BrightMax     := GlobalInteger(s_BrightMax,     50);

      ExShadowOffs  := GlobalInteger(s_ShadowOffset,   0);
      ExShadowOffsR := GlobalInteger(s_ShadowOffsetR,  ExShadowOffs);
      ExShadowOffsT := GlobalInteger(s_ShadowOffsetT,  ExShadowOffs);
      ExShadowOffsB := GlobalInteger(s_ShadowOffsetB,  ExShadowOffs);

      BISpacing     := ScaleInt(GlobalInteger(s_BISpacing, 0));

      BIVAlign      := GlobalInteger(s_BIVAlign,       0);
      BIRightMargin := GlobalInteger(s_BIRightMargin,  0);
      BILeftMargin  := GlobalInteger(s_BILeftMargin,   0);
      BITopMargin   := GlobalInteger(s_BITopMargin,    0);
      BIKeepHUE     := GlobalInteger(s_BIKeepHUE,      0);

      UseAeroBluring := GlobalInteger(s_UseAeroBluring, 0) <> 0;

      for tg := tgCloseAlone to tgNormal do begin
        GlowMargins[tg] := ScaledInteger(acTitleGlyphs[tg] + s_GlowMargin, 0);
        SetLength(TitleGlows[tg], GlobalInteger(s_BorderIconClose + s_Glow, 0));
      end;

      Shadow1Color        := GlobalInteger(s_Shadow1Color,        0);
      Shadow1Offset       := GlobalInteger(s_Shadow1Offset,       0);
      Shadow1Blur         := GlobalInteger(s_Shadow1Blur,        -1);
      Shadow1Transparency := GlobalInteger(s_Shadow1Transparency, 0);

      ComboBoxMargin      := GlobalInteger(s_ComboMargin,  2);
      SliderMargin        := GlobalInteger(s_SliderMargin, 1);
      // Outer effects
      SetLength(oe, 2);
      with oe[1] do begin // Main shadow
        ColorL  := GlobalInteger(s_ShadowColorL,  0);
        ColorR  := GlobalInteger(s_ShadowColorR,  0);
        ColorT  := GlobalInteger(s_ShadowColorT,  0);
        ColorB  := GlobalInteger(s_ShadowColorB,  0);

        WidthL  := GlobalInteger(s_ShadowWidthL, -1);
        WidthR  := GlobalInteger(s_ShadowWidthR, -1);
        WidthT  := GlobalInteger(s_ShadowWidthT, -1);
        WidthB  := GlobalInteger(s_ShadowWidthB, -1);

        OffsetL := GlobalInteger(s_ShadowOffsL,   3);
        OffsetR := GlobalInteger(s_ShadowOffsR,   3);
        OffsetT := GlobalInteger(s_ShadowOffsT,   2);
        OffsetB := GlobalInteger(s_ShadowOffsB,   5);

        Source  := GlobalInteger(s_ShadowSource,  2);
        Opacity := GlobalInteger(s_ShadowOpacity, 60);
      end;
      MakeMask(oe[1], s_ShadowMask);
      with oe[0] do begin // Main lowered bevel
        ColorL  := GlobalInteger(s_LowColorL,  $FFFFFF);
        ColorR  := GlobalInteger(s_LowColorR,  $FFFFFF);
        ColorT  := GlobalInteger(s_LowColorT,  0);
        ColorB  := GlobalInteger(s_LowColorB,  $FFFFFF);

        WidthL  := GlobalInteger(s_LowWidthL, -1);
        WidthR  := GlobalInteger(s_LowWidthR, -1);
        WidthT  := GlobalInteger(s_LowWidthT, -1);
        WidthB  := GlobalInteger(s_LowWidthB, -1);

        OffsetL := GlobalInteger(s_LowOffsL,   2);
        OffsetR := GlobalInteger(s_LowOffsR,   2);
        OffsetT := GlobalInteger(s_LowOffsT,   2);
        OffsetB := GlobalInteger(s_LowOffsB,   4);

        Source  := GlobalInteger(s_LowSource,  2);
        Opacity := GlobalInteger(s_LowOpacity, 200);
      end;
      MakeMask(oe[0], s_LowMask);
    end;
  end;

begin
  with CommonSkinData do
    if SkinFile <> nil then begin
      sf := SkinFile;
      // Global info
      CommonSkindata.Version := GetSkinVersion(sf);
      LoadGlobalData;
      CheckVersion;
      TabsCovering   := sf.ReadInteger(s_TabTop,    s_TabsCovering, 0);
      RibbonCovering := sf.ReadInteger(s_RibbonTab, s_TabsCovering, 0);
      Sections := TStringList.Create;
      SetCaseSens(Sections);
      try
        SetLength(gd, 0);
        sf.ReadSections(Sections);
        for i := 0 to Sections.Count - 1 do begin
          s := Sections[i];
          l := Length(gd) + 1;
          SetLength(gd, l);
          // General data
          with gd[i] do begin
            ClassName          := Sections[i];
            ParentClass        := sf.ReadString(s, s_ParentClass,   '');
            ReservedBoolean    := FindBoolean(s, s_ReservedBoolean, False);
            GiveOwnFont        := FindBoolean(s, s_GiveOwnFont,     False);

            GlowCount          := FindInteger(s, s_Glow,           0, MaxByte);
            GlowMargin         := FindInteger(s, s_GlowMargin,     0, MaxByte);
            States             := FindInteger(s, s_States,         3, MaxByte);

            OuterOffset.Left   := FindInteger(s, s_OuterOffsL,     0, MaxByte);
            OuterOffset.Top    := FindInteger(s, s_OuterOffsT,     0, MaxByte);
            OuterOffset.Right  := FindInteger(s, s_OuterOffsR,     0, MaxByte);
            OuterOffset.Bottom := FindInteger(s, s_OuterOffsB,     0, MaxByte);
            OuterOpacity       := FindInteger(s, s_OuterOpacity, 200, MaxByte);
            OuterMode          := FindInteger(s, s_OuterMode,      2); // Shadowed by definition
            ImgTL := -1;
            ImgTR := -1;
            ImgBL := -1;
            ImgBR := -1;

            FillProps(Props[0], acDefProp, 0, False);

            if States > 1 then
              FillProps(Props[1], acDefProp, 1, False)
            else
              CopyProperties(Props[1], Props[0]); // For back/w compatibility

            UseState2 := FindInteger(s, s_UseState2, 0) = 1;
            if UseState2 then
              FillProps(Props[2], acDefProp, 2, False)
            else
              CopyProperties(Props[2], Props[1]); // For back/w compatibility
          end;
        end;
      finally
        FreeAndNil(Sections);
      end;
    end;

  if CommonSections.Count > 0 then begin
    with acDefGenData do begin
      for i := 0 to ac_MaxPropsIndex do
        Props[i] := acDefProp;

      States := 3;
      GiveOwnFont := False;
      ReservedBoolean := False;
      GlowCount := 0;
      GlowMargin := 0;
    end;
    Sections := TStringList.Create;
    SetCaseSens(Sections);
    GetIniSections(CommonSections, Sections);
    try
      for i := 0 to Sections.Count - 1 do begin
        l := Length(gd);
        gData.ClassName := '';
        SkinIndex := -1;
        for ParentIndex := 0 to l - 1 do
          if gd[ParentIndex].ClassName = Sections[i] then begin
            gData := gd[ParentIndex];
            SkinIndex := ParentIndex;
            break;
          end;

        Ini := nil;
        if gData.ClassName = '' then begin
          l := Length(gd) + 1;
          SetLength(gd, l);
          gData.ClassName := Sections[i];
          Ini := CommonSections;
          gData.ParentClass := UpperCase(ReadIniString(Ini, Sections, gData.ClassName, s_ParentClass, s_MinusOne));
          ParentIndex := -1;
          for j := 0 to Length(gd) - 1 do
            if UpperCase(gd[j].ClassName) = gData.ParentClass then begin
              ParentIndex := j;
              break;
            end;
        end;
        // General data
        if Ini <> nil then begin
          if ParentIndex >= 0 then
            gTempData := gd[ParentIndex]
          else
            gTempData := acDefGenData;

          gData.States := GetPropInteger(Sections[i], s_States, gTempData.States);
          FillProps(gData.Props[0], gTempData.Props[0], 0, True);
          if gData.States > 1 then
            FillProps(gData.Props[1], gTempData.Props[1], 1, True)
          else
            CopyProperties(gData.Props[1], gData.Props[0]);

          gd[i].UseState2 := FindInteger(s, s_UseState2, 0) = 1;
          if gd[i].UseState2 then
            FillProps(gData.Props[2], gTempData.Props[2], 2, True)
          else
            CopyProperties(gData.Props[2], gData.Props[1]);

          gData.ReservedBoolean := GetPropBool   (Sections[i], s_ReservedBoolean, gTempData.ReservedBoolean);
          gData.GiveOwnFont     := GetPropBool   (Sections[i], s_GiveOwnFont,     gTempData.GiveOwnFont);
          gData.GlowCount       := GetPropInteger(Sections[i], s_Glow,            gTempData.GlowCount);
          gData.GlowMargin      := GetPropInteger(Sections[i], s_GlowMargin,      gTempData.GlowMargin);
          if gData.ClassName <> '' then begin
            if SkinIndex >= 0 then
              gd[SkinIndex] := gData
            else
              gd[l - 1] := gData;

            gData.ClassName := '';
          end;
        end;
      end;
    finally
      if Assigned(Sections) then begin
        with Sections do
          while Count > 0 do begin
            if Objects[0] <> nil then
              TStringList(Objects[0]).Free;

            Delete(0);
          end;

        FreeAndNil(Sections);
      end;
    end;
  end;
//  InitMaskIndexes;
  // Load a main color palette
  Palette[pcMainColor] := sf.ReadInteger(s_GlobalInfo, s_Color,     ColorToRGB(clBtnFace));
  Palette[pcLabelText] := sf.ReadInteger(s_GlobalInfo, s_FontColor, clBlack);

  Palette[pcWebText]    := sf.ReadInteger(s_GlobalInfo, s_TCBottom, ColorToRGB(clBlue));
  Palette[pcWebTextHot] := sf.ReadInteger(s_GlobalInfo, s_TCTop,    ColorToRGB(clRed));

  Palette[pcBorder] := sf.ReadInteger(s_GlobalInfo, s_BorderColor, clBlack);
  // Receive edit color from EDIT section
  i := GetSkinIndex(s_Edit);
  if i >= 0 then begin
    Palette[pcEditText] := ColorToRGB(gd[i].Props[0].FontColor.Color);
    Palette[pcEditBG]   := ColorToRGB(gd[i].Props[0].Color);
  end
  else begin
    Palette[pcEditText] := ColorToRGB(clWindowText);
    Palette[pcEditBG]   := ColorToRGB(clWindow);
  end;
  // Receive colors from HINT section
  i := GetSkinIndex(s_Hint);
  if i >= 0 then begin
    Palette[pcHintText] := ColorToRGB(gd[i].Props[0].FontColor.Color);
    Palette[pcHintBG]   := ColorToRGB(gd[i].Props[0].Color);
  end
  else begin
    Palette[pcHintText] := ColorToRGB(clInfoText);
    Palette[pcHintBG]   := ColorToRGB(clInfoBk);
  end;
  // Receive a selection Text Color
  i := GetSkinIndex(s_Selection);
  if IsValidSkinIndex(i) then begin
    if gd[i].States > 1 then begin
      Palette[pcSelectionText_Focused] := gd[i].Props[1].FontColor.Color;
      Palette[pcSelectionBG_Focused]   := gd[i].Props[1].Color;
    end
    else begin
      Palette[pcSelectionText_Focused] := gd[i].Props[0].FontColor.Color;
      Palette[pcSelectionBG_Focused]   := gd[i].Props[0].Color;
    end;
    Palette[pcSelectionText] := gd[i].Props[0].FontColor.Color;
    Palette[pcSelectionBG]   := gd[i].Props[0].Color;
  end
  else begin
    Palette[pcSelectionText_Focused] := -1;
    Palette[pcSelectionText]         := -1;
    Palette[pcSelectionBG_Focused]   := -1;
    Palette[pcSelectionBG]           := -1;
  end;
  if (Palette[pcSelectionText] = -1) or (Palette[pcSelectionText] = clFuchsia) then begin
    i := GetSkinIndex(s_MenuItem);
    if IsValidSkinIndex(i) then begin
      Palette[pcSelectionText]       := gd[i].Props[1].FontColor.Color;
      Palette[pcSelectionBG]         := gd[i].Props[1].Color;
      Palette[pcSelectionBG_Focused] := gd[i].Props[1].Color;
      if (Palette[pcSelectionText] <> -1) and (Palette[pcSelectionText] <> clFuchsia) then
        Palette[pcSelectionText] := ColorToRGB(Palette[pcSelectionText])
      else
        Palette[pcSelectionText] := clHighLightText;

      Palette[pcSelectionText_Focused] := Palette[pcSelectionText];
    end
    else begin
      Palette[pcSelectionText_Focused] := ColorToRGB(clHighLightText);
      Palette[pcSelectionText]         := ColorToRGB(clHighLightText);
      Palette[pcSelectionBG]           := ColorToRGB(clHighLight);
      Palette[pcSelectionBG_Focused]   := ColorToRGB(clHighLight);
    end;
  end;
  Palette[pcEditText_Ok]       := sf.ReadInteger(s_GlobalInfo, s_EditTextOk,      clGreen);
  Palette[pcEditText_Warning]  := sf.ReadInteger(s_GlobalInfo, s_EditTextWarning, $008484);
  Palette[pcEditText_Alert]    := sf.ReadInteger(s_GlobalInfo, s_EditTextAlert,   clRed);
  Palette[pcEditText_Caution]  := sf.ReadInteger(s_GlobalInfo, s_EditTextAlert,   $8597D9);
  Palette[pcEditText_Bypassed] := sf.ReadInteger(s_GlobalInfo, s_EditTextAlert,   $4AB28F);

  Palette[pcEditBG_Ok]       := sf.ReadInteger(s_GlobalInfo, s_EditBGOk,      $6Cc2a5);
  Palette[pcEditBG_Warning]  := sf.ReadInteger(s_GlobalInfo, s_EditBGWarning, $40ffFF);
  Palette[pcEditBG_Alert]    := sf.ReadInteger(s_GlobalInfo, s_EditBGAlert,   $95a7e9);
  Palette[pcEditBG_Caution]  := sf.ReadInteger(s_GlobalInfo, s_EditBGAlert,   $8597D9);
  Palette[pcEditBG_Bypassed] := sf.ReadInteger(s_GlobalInfo, s_EditBGAlert,   $4AB28F);

  Palette[pcEditText_Highlight1] := sf.ReadInteger(s_GlobalInfo, s_EditTextHighlight1, clBlack);
  Palette[pcEditText_Highlight2] := sf.ReadInteger(s_GlobalInfo, s_EditTextHighlight2, clBlack);
  Palette[pcEditText_Highlight3] := sf.ReadInteger(s_GlobalInfo, s_EditTextHighlight3, clBlack);

  Palette[pcEditText_Inverted] := sf.ReadInteger(s_GlobalInfo, s_EditText_Inverted, Palette[pcEditBG]);
  Palette[pcEditBG_Inverted]   := sf.ReadInteger(s_GlobalInfo, s_EditBG_Inverted,   Palette[pcEditText]);
  Palette[pcEditBG_OddRow]     := sf.ReadInteger(s_GlobalInfo, s_EditBG_OddRow,     Palette[pcEditBG]);
  Palette[pcEditBG_EvenRow]    := sf.ReadInteger(s_GlobalInfo, s_EditBG_EvenRow,    BlendColors(Palette[pcEditText], Palette[pcEditBG], 13));

  for ColorItem := low(Brushes) to high(Brushes) do begin
    if Brushes[ColorItem] <> 0 then
      DeleteObject(Brushes[ColorItem]);

    Brushes[ColorItem] := CreateSolidBrush(Palette[ColorItem]);
  end;

  // Add TRANSPARENT skin section
  if GetSkinIndex(s_Transparent) < 0 then begin
    l := Length(gd);
    SetLength(gd, l + 1);
    // General data
    gd[l].ClassName   := s_Transparent;
    gd[l].ParentClass := '';
    gd[l].States      := 1;
    for i := 0 to ac_MaxPropsIndex do
      with gd[l].Props[i] do begin
        Transparency := 100;
        Color := $FFFFFF;
        FontColor.Color  := Palette[pcLabelText];
        FontColor.Left   := -1;
        FontColor.Top    := -1;
        FontColor.Right  := -1;
        FontColor.Bottom := -1;
      end;
  end;

  // Change skin Colors if needed
  ChangeSkinHue(Self, HueOffset);
  ChangeSkinSaturation(Self, Saturation);
  ChangeSkinBrightness(Self, FBrightness);

  // Add TRANSPARENT skin section
  if GetSkinIndex(s_MainColor) < 0 then begin
    l := Length(gd);
    SetLength(gd, l + 1);
    // General data
    gd[l].ClassName   := s_MainColor;
    gd[l].ParentClass := '';
    gd[l].States      := 1;
    for i := 0 to ac_MaxPropsIndex do
      with gd[l].Props[i] do begin
        Transparency := 0;
        Color := Palette[pcMainColor];
        FontColor.Color  := Palette[pcLabelText];
        FontColor.Left   := -1;
        FontColor.Top    := -1;
        FontColor.Right  := -1;
        FontColor.Bottom := -1;
      end;
  end;
end;


function TsSkinManager.GetScale: integer;
begin
  if (csDesigning in ComponentState) or (Options.ScaleMode = smOldMode) then
    Result := 0
  else
    if Options.ScaleMode = smAuto then
      Result := SysFontScale
    else
      Result := ord(Options.ScaleMode);
end;


function TsSkinManager.GetSkinIndex(const SkinSection: string): integer;
var
  i, l: integer;
begin
  Result := -1;
  if SkinSection <> '' then begin
    l := Length(gd);
    if l > 0 then
      for i := 0 to l - 1 do
        if gd[i].ClassName = SkinSection then begin
          Result := i;
          Exit;
        end;
  end;
end;


function TsSkinManager.GetMaskIndex(const SkinIndex: integer; const SkinSection, mask: string): integer;
var
  i: integer;
  s: string;
begin
  if SkinIndex >= 0 then begin
    for i := 0 to Length(ma) - 1 do
      if (ma[i].SkinIndex = SkinIndex) and (ma[i].PropertyName = mask) then begin
        Result := i;
        Exit;
      end;

    if IsValidIndex(SkinIndex, Length(ma)) then begin
      s := gd[SkinIndex].ParentClass;
      if (s <> '') and (SkinSection <> s) then begin
        i := GetSkinIndex(s);
        if i >= 0 then begin
          Result := GetMaskIndex(i, s, mask);
          Exit;
        end;
      end;
    end;
  end;
  Result := -1;
end;


procedure TsSkinManager.SetIsDefault(const Value: boolean);
begin
  if Value or (DefaultManager = nil) then begin
    DefaultManager := Self;
    if Active then
      SendNewSkin
    else
      SendRemoveSkin;
  end
end;


function TsSkinManager.GetRandomSkin: acString;
var
  sl: TacStringList;
begin
  sl := TacStringList.Create;
  GetSkinNames(sl);
  if sl.Count > 0 then begin
    Randomize;
    Result := sl[Random(sl.Count)]
  end
  else
    Result := '';

  FreeAndNil(sl);
end;


function TsSkinManager.GetIsDefault: boolean;
begin
  Result := DefaultManager = Self;
end;


function TsSkinManager.GetTextureIndex(aSkinIndex: integer; const SkinSection, PropName: string): integer;
var
  i, l: integer;
begin
  if aSkinIndex >= 0 then begin
    l := Length(ma);
    if (l > 0) and (SkinSection <> '') then begin
      for i := 0 to l - 1 do
        with ma[i] do
          if (ImgType = itisaTexture) and (PropertyName = PropName) and (ClassName = SkinSection) then begin
            Result := i;
            Exit;
          end;

      if (gd[aSkinIndex].ParentClass <> '') and (SkinSection <> gd[aSkinIndex].ParentClass) then begin
        i := GetSkinIndex(gd[aSkinIndex].ParentClass);
        if i >= 0 then begin
          Result := GetTextureIndex(i, gd[aSkinIndex].ParentClass, PropName);
          Exit;
        end;
      end;
    end;
  end;
  Result := -1;
end;


function TsSkinManager.GetTextureIndex(aSkinIndex: integer; const PropName: string): integer;
var
  i, l: integer;
begin
  if aSkinIndex >= 0 then begin
    l := Length(ma);
    if l > 0 then begin
      for i := 0 to l - 1 do
        with ma[i] do
          if (SkinIndex = aSkinIndex) and (ImgType = itisaTexture) and (PropertyName = PropName) then begin
            Result := i;
            Exit;
          end;

      if gd[aSkinIndex].ParentClass <> '' then begin
        Result := GetTextureIndex(GetSkinIndex(gd[aSkinIndex].ParentClass), PropName);
        Exit;
      end;
    end;
  end;
  Result := -1;
end;


function TsSkinManager.GetMaskIndex(const SkinSection, mask: string): integer;
var
  i: integer;
begin
  if SkinSection <> '' then
    for i := 0 to Length(ma) - 1 do
      if (ma[i].ClassName = SkinSection) and (ma[i].PropertyName = mask) then begin
        Result := i;
        Exit;
      end;

  Result := -1;
end;


function TsSkinManager.GetMaskIndex(const SkinIndex: integer; mask: string): integer;
var
  i: integer;
begin
  Result := -1;
  if SkinIndex >= 0 then begin
    for i := 0 to Length(ma) - 1 do
      if ma[i].SkinIndex = SkinIndex then
        if ma[i].PropertyName = mask then begin
          Result := i;
          Exit;
        end;

    if gd[SkinIndex].ParentClass <> '' then
      Result := GetMaskIndex(GetSkinIndex(gd[SkinIndex].ParentClass), mask);
  end;
end;


function MakePreviewBmp(sp: TObject; Width: integer = 200; Height: integer = 140): TBitmap;
var
  TmpBmp: TBitmap;
begin
  Result := CreateBmp32(Width, Height);
  with sp as TsSkinProvider do
    if BorderForm <> nil then begin
      TmpBmp := CreateBmp32(SkinData.FCacheBmp);
      FormState := FormState or FS_BLENDMOVING;
      BorderForm.UpdateExBordersPos(False); // Repaint cache
      FormState := FormState and not FS_BLENDMOVING;
      TmpBmp.Assign(SkinData.FCacheBmp);
      BorderForm.UpdateExBordersPos(False); // Repaint cache
    end
    else
      TmpBmp := GetFormImage(sp as TsSkinProvider);

  Stretch(TmpBmp, Result, Width, Height, ftMitchell);
  FreeAndNil(TmpBmp);
end;


function MakeThumbIcon(sp: TObject; Width: integer = 200; Height: integer = 140): TBitmap;
var
  TmpBmp: TBitmap;
begin
  Result := CreateBmp32(Width, Height);
  with sp as TsSkinProvider do begin
    TmpBmp := CreateBmp32(SkinData.FCacheBmp);
    if BorderForm <> nil then begin
      FormState := FormState or FS_BLENDMOVING;
      BorderForm.UpdateExBordersPos(False); // Repaint cache
      FormState := FormState and not FS_BLENDMOVING;
      TmpBmp.Assign(SkinData.FCacheBmp);
      BorderForm.UpdateExBordersPos(False); // Repaint cache
    end
    else
      TmpBmp := GetFormImage(sp as TsSkinProvider);
  end;
  Stretch(TmpBmp, Result, Width, Height, ftMitchell);
  FreeAndNil(TmpBmp);
end;


type
  TAccessProvider = class(TsSkinProvider);

function TsSkinManager.MainWindowHook(var Message: TMessage): boolean;
var
  R: TRect;
  Wnd: hwnd;
  i: integer;
  mi: TacMenuInfo;
  sp: TsSkinProvider;
  FMenuItem: TMenuItem;
{$IFNDEF NOWNDANIMATION}
  b: boolean;
{$ENDIF}
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  Result := False;
  case Message.Msg of
    SM_ALPHACMD:
      if Message.WParamHi = AC_COPYDATA then
        ReceiveData(Self);

    WM_COPYDATA:
      if (Message.Result = 0) and not acSkinPreviewUpdating then begin // SkinManager is upadated by SkinEditor (Preview mode)
        acSkinPreviewUpdating := True;
        with PCopyDataStruct(Message.LParam)^ do
          if (Message.LParam <> 0) and (Message.WParam = 7) and (PacSkinData(lpData)^.Magic = ASE_MSG) then begin
            CopyMemory(@PreviewBuffer, PacSkinData(lpData), SizeOf(TacSkinData));
            PostMessage(Application.{$IFNDEF FPC}Handle{$ELSE}MainFormHandle{$ENDIF}, SM_ALPHACMD, AC_COPYDATA shl 16, 0);
          end;

        acSkinPreviewUpdating := False;
        Result := True;
      end;

{$IFNDEF FPC}
    WM_DRAWMENUBORDER:
      if SkinnedPopups then begin
        FMenuItem := TMenuItem(Message.LParam);
        if Assigned(FMenuItem) then
          if GetMenuItemRect(0, FMenuItem.Parent.Handle, 0, R) or GetMenuItemRect(PopupList.Window, FMenuItem.Parent.Handle, 0, R) then begin
            Wnd := WindowFromPoint(Point(r.Left + WidthOf(r) div 2, r.Top + HeightOf(r) div 2));
            if (Wnd <> 0) and (GetWndClassName(Wnd) = '#32768') then begin // If menu is found
              mi := SkinableMenus.GetMenuInfo(FMenuItem, 0, 0, nil, Wnd);
              if mi.Bmp <> nil then
                SkinableMenus.DrawWndBorder(Wnd, mi.Bmp);
            end;
          end;

        Result := True;
      end;

    WM_DWMSENDICONICLIVEPREVIEWBITMAP:
      if ac_ChangeThumbPreviews and (Application.MainForm <> nil) then // Task menu support when not MainFormOnTaskBar
        try
          sp := TsSkinProvider(SendAMessage(Application.MainForm.Handle, AC_GETPROVIDER));
          if sp <> nil then
            Result := SetPreviewBmp(Application.Handle, sp);
        finally
          Message.Result := 0;
        end;

    WM_DWMSENDICONICTHUMBNAIL:
      if ac_ChangeThumbPreviews and (Application.MainForm <> nil) and (Message.LParamHi <> 0) and (Message.LParamLo <> 0) then // Task menu support when not MainFormOnTaskBar
        try
          sp := TsSkinProvider(SendAMessage(Application.MainForm.Handle, AC_GETPROVIDER));
          if sp <> nil then
            Result := SetThumbIcon(Application.Handle, sp, Message.LParamHi, Message.LParamLo);
        finally
          Message.Result := 0;
        end;

    WM_DRAWMENUBORDER2: if SkinnedPopups then begin
      Wnd := HWND(Message.LParam);
      if (Wnd <> 0) and (GetWndClassName(Wnd) = '#32768') then begin // If menu is found
        mi := SkinableMenus.GetMenuInfo(nil, 0, 0, nil, Wnd);
        if mi.Bmp <> nil then
          SkinableMenus.DrawWndBorder(Wnd, mi.Bmp);
      end;
      Result := True;
    end;
{$ENDIF}

    $031A{ <- WM_THEMECHANGED}:
      Result := True;

{$IFDEF D2005}
    787:
      if {$IFDEF D2007}Application.MainFormOnTaskBar and {$ENDIF}(Application.MainForm <> nil) then begin // Task menu support when not MainFormOnTaskBar
        try
          sp := TsSkinProvider(SendAMessage(Application.MainForm.Handle, AC_GETPROVIDER));
        except
          sp := nil;
        end;
        if sp <> nil then begin
          sp.DropSysMenu(Mouse.CursorPos.X, Mouse.CursorPos.Y);
          Result := True;
        end;
      end;
{$ENDIF}

    CM_ACTIVATE: // Solving a problem in Report Builder dialogs and similar windows
      for i := Screen.FormCount - 1 downto 0 do
        if Screen.Forms[i].HandleAllocated then
          SendAMessage(Screen.Forms[i].Handle, AC_INVALIDATE);

{$IFNDEF NOWNDANIMATION}
    WM_WINDOWPOSCHANGED: if acLayered then 
      if (TWMWindowPosChanged(Message).WindowPos.Flags and SWP_HIDEWINDOW <> 0) then
        if (AnimEffects.FormHide.Active) and Effects.AllowAnimation and (AnimEffects.FormHide.Time > 0) and not IsIconic(Application.{$IFDEF FPC}MainFormHandle{$ELSE}Handle{$ENDIF}) and Application.Terminated then begin
          if (Application.MainForm = nil) or not Application.MainForm.HandleAllocated or not IsWindowVisible(Application.MainForm.Handle) then
            Exit;

          sp := TsSkinProvider(SendAMessage(Application.MainForm.Handle, AC_GETPROVIDER));
          if (sp <> nil) and sp.DrawNonClientArea and not sp.SkipAnimation and sp.AllowAnimation then begin
            sp.SkipAnimation := True;
            sp.FormState := sp.FormState or FS_ANIMCLOSING;
            if sp.BorderForm <> nil then
              SetWindowRgn(sp.BorderForm.AForm.Handle, sp.BorderForm.MakeRgn, False);

            if AeroIsEnabled then
              DoLayered(Application.MainForm.Handle, True, 254);

            Application.MainForm.Update;
            acHideTimer := nil;
            AnimHideForm(sp);
            while InAnimationProcess do
              Continue;
          end;
        end;
{$ENDIF}

    WM_SYSCOMMAND: if CommonSkinData.Active then
      case Message.WParam of
        SC_MINIMIZE: begin
          ShowState := saMinimize;
{$IFNDEF NOWNDANIMATION}
          if not IsIconic(Application.{$IFDEF FPC}MainFormHandle{$ELSE}Handle{$ENDIF}) and ((Application.MainForm <> nil) and Application.MainForm.Visible) then begin
            sp := TsSkinProvider(SendAMessage(Application.MainForm.Handle, AC_GETPROVIDER));
            if sp <> nil then
              if AnimEffects.Minimizing.Active and Effects.AllowAnimation then begin
                if sp.DrawNonClientArea then begin
                  sp.SkipAnimation := True;
                  i := integer(StartMinimizing(sp));
                  if not AeroIsEnabled then begin
                    Result := True;
                    b := acGetAnimation;
                    acSetAnimation(False);
                    Application.Minimize;
                    acSetAnimation(b);
                  end;
                  if (i = 0) and (sp.BorderForm <> nil) and (sp.BorderForm.AForm <> nil) then
                    if sp.FormState and FS_ANIMMINIMIZING = 0 then begin
                      sp.BorderForm.ExBorderShowing := True;
                      FreeAndNil(sp.BorderForm.AForm);
                      sp.BorderForm.ExBorderShowing := False;
                    end;
                end;
              end
              else
                if (sp.BorderForm <> nil) and (sp.BorderForm.AForm <> nil) then begin
                  sp.BorderForm.ExBorderShowing := True;
                  FreeAndNil(sp.BorderForm.AForm);
//                  sp.BorderForm.ExBorderShowing := False; Restored later
                end;
          end;
{$ENDIF}
        end;

        SC_RESTORE: begin
          ShowState := saRestore;
{$IFNDEF NOWNDANIMATION}
          if Application.MainForm <> nil then begin
            if not Application.MainForm.Showing then
{$IFDEF D2007}if not Application.MainFormOnTaskBar then {$ENDIF}
                Exit;

            sp := TsSkinProvider(SendAMessage(Application.MainForm.Handle, AC_GETPROVIDER));
            if sp = nil then
              Exit;

            if sp.FormState and FS_ANIMCLOSING <> 0 then begin // If all windows were hidden
              sp.FormState := sp.FormState and not FS_ANIMCLOSING;
              // Update ExtBorders in the WM_NCPAINT message
              if sp.SkinData.SkinManager.ExtendedBorders and sp.AllowExtBorders and (sp.BorderForm = nil) then
                FreeAndNil(sp.SkinData.FCacheBmp);

              if sp.BorderForm <> nil then
                sp.BorderForm.ExBorderShowing := False;

              b := acGetAnimation;
              acSetAnimation(False);
              Application.Restore;
              if AeroIsEnabled then begin
                RedrawWindow(Application.MainForm.Handle, nil, 0, RDWA_ALL);
                if GetWindowLong(Application.MainForm.Handle, GWL_EXSTYLE) and WS_EX_LAYERED <> 0 then begin
                  sp.SkinData.BGChanged := True;
                  SetWindowLong(Application.MainForm.Handle, GWL_EXSTYLE, GetWindowLong(Application.MainForm.Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
                end;
              end;
              acSetAnimation(b);
            end
            else
              if sp.SkinData.SkinManager.AnimEffects.Minimizing.Active and sp.SkinData.SkinManager.Effects.AllowAnimation and Application.MainForm.Visible {and IsIconic(Application.Handle) }then begin
                if sp <> nil then begin
                  if not sp.DrawNonClientArea then
                    Exit;

                  if not StartRestoring(sp) then
                    with TAccessProvider(sp), Application.MainForm do
                      if CoverForm <> nil then begin
                        if CoverForm.HandleAllocated then
                          SetWindowPos(Handle, CoverForm.Handle, 0, 0, 0, 0, SWPA_SHOWZORDERONLY);

                        InvalidateRect(Handle, nil, True);
                        RedrawWindow(Handle, nil, 0, RDWA_ALLNOW);
                        if CoverForm <> nil then
                          FreeAndNil(CoverForm);
                      end
                      else begin
                        ShowWindow(Handle, SW_RESTORE);
                        InvalidateRect(Handle, nil, True);
                        RedrawWindow(Handle, nil, 0, RDWA_ALLNOW);
                      end;
                end;
                if not AeroIsEnabled then begin
                  Result := True;
                  b := acGetAnimation;
                  acSetAnimation(False);
                  Application.Restore;
                  acSetAnimation(b);
                end;
              end
              else
                if AeroIsEnabled then
{$IFDEF D2009}
                  if not Application.MainFormOnTaskBar then
{$ENDIF}
                  with Application.MainForm do begin
                    Result := True;
                    b := acGetAnimation;
                    acSetAnimation(False);
                    Application.Restore;
                    if not Visible then
                      Show; // If app was started as minimized

                    acSetAnimation(b);
                    InvalidateRect(Handle, nil, True);
                    RedrawWindow(Handle, nil, 0, RDWA_ALL);
                  end;
          end;
{$ENDIF} // NOWNDANIMATION
        end
        else
          ShowState := saIgnore;
      end;
  end;
end;


procedure TsSkinManager.ReloadSkin;
var
  s: string;
  i: integer;
  sl: TStringList;
  TempSkinFile: TMemIniFile;
begin
  if FActive then begin
    aSkinChanging := True;
    CommonSkinData.SkinPath := GetFullSkinDirectory + s_Slash + SkinName + s_Slash;
    s := CommonSkinData.SkinPath + OptionsDatName;
    TempSkinFile := nil;
    if acMemSkinFile <> nil then begin
      TempSkinFile := TMemIniFile.Create(s + '_');
      SetCaseSens(TempSkinFile);
      TempSkinFile.SetStrings(acMemSkinFile);
    end
    else
      if FileExists(s) then begin // If used external skins
        SkinIsPacked := False;
        TempSkinFile := TMemIniFile.Create(s);
        SetCaseSens(TempSkinFile);
      end
      else begin // If used internal skins
        CommonSkinData.SkinPath := '';
        i := InternalSkins.IndexOf(FSkinName);
        if (i < 0) and (InternalSkins.Count > 0) then begin
          FSkinName := InternalSkins.Items[0].Name;
          i := 0;
        end
        else
          if InternalSkins.Count <= 0 then begin
            FActive := False;
            Exit;
          end;

        if InternalSkins.Items[i].PackedData.Size > 0 then begin // if packed
          if Assigned(sc) then
            FreeAndNil(sc);

          SkinIsPacked := True;
          sc := TacSkinConvertor.Create;
          sc.PackedData := InternalSkins.Items[i].PackedData;
          ExtractPackedData(sc, FKeyList, Self);
          sc.PackedData := nil;

          sc.Options.Seek(0, 0);
          sl := TStringList.Create;
          SetCaseSens(sl);
          sl.LoadFromStream(sc.Options);
          TempSkinFile := TMemIniFile.Create('');
          SetCaseSens(TempSkinFile);
          TempSkinFile.SetStrings(sl);
          FreeAndNil(sl);
        end
        else
          SkinIsPacked := False;
      end;

    CommonSkinData.Version := GetSkinVersion(TempSkinFile);
    CheckVersion;
    if Assigned(SkinFile) then
      FreeAndNil(SkinFile);

    Skinfile := TempSkinFile;

    LoadAllMasks;
    LoadAllGeneralData;
    InitConstantIndexes;
    if Assigned(FOnSkinLoading) then
      FOnSkinLoading(Self);

    aSkinChanging := False;
    if Assigned(SkinFile) then
      FreeAndNil(SkinFile);

    if Assigned(sc) then
      FreeAndNil(sc);
  end;
end;

{
function TsSkinManager.MaskWidthBottom(MaskIndex: integer): integer;
begin
  Result := ma[MaskIndex].WB;
end;


function TsSkinManager.MaskWidthLeft(MaskIndex: integer): integer;
begin
  Result := ma[MaskIndex].WL;
end;


function TsSkinManager.MaskWidthRight(MaskIndex: integer): integer;
begin
  Result := ma[MaskIndex].WR;
end;


function TsSkinManager.MaskWidthTop(MaskIndex: integer): integer;
begin
  Result := ma[MaskIndex].WT;
end;
}

procedure TsSkinManager.SetActiveControl(const Value: hwnd);
var
  OldHwnd: hwnd;
begin
  if FActiveControl <> Value then begin
    // Try reset graph control
    if (FActiveControl <> 0) and (FActiveGraphControl <> nil) then begin
      ActiveGraphControl := nil;
      if FActiveGraphControl <> nil then
        Exit; // If control is hot yet
    end;
    OldHwnd := FActiveControl;
    FActiveControl := Value;
    if OldHwnd <> 0 then
      SendAMessage(OldHwnd, AC_MOUSELEAVE, LPARAM(Self));

    if FActiveControl <> 0 then
      SendAMessage(FActiveControl, AC_MOUSEENTER, LPARAM(Self));
  end;
end;


procedure TsSkinManager.InstallHook;
var
  dwThreadID: DWORD;
begin
  if not (csDesigning in ComponentState) and (DefaultManager = Self) then
    if not GlobalHookInstalled then begin
      GlobalHookInstalled := True;
      if acSupportedList = nil then
        acSupportedList := TList.Create;

      dwThreadID := GetCurrentThreadId;
      HookCallback := SetWindowsHookEx(WH_CBT, SkinHookCBT, 0, dwThreadID);
{$IFNDEF WIN64}
      if Options.ChangeSysColors then begin
        HookGetSysColor;
        HookGetSysColorBrush;
        HookCreatePen;
      end;
{$ENDIF} // WIN64
    end;
end;


procedure TsSkinManager.UnInstallHook;
var
  i: integer;
begin
  if not (csDesigning in ComponentState) and (DefaultManager = Self) then
    if GlobalHookInstalled then begin
      ClearMnuArray;
      if HookCallBack <> 0 then
        UnhookWindowsHookEx(HookCallback);

      if acSupportedList <> nil then begin
        for i := 0 to acSupportedList.Count - 1 do
          if acSupportedList[i] <> nil then
            TObject(acSupportedList[i]).Free;

        FreeAndNil(acSupportedList);
      end;
{$IFNDEF WIN64}
      if Options.ChangeSysColors then begin
        UnHookGetSysColor;
        UnHookGetSysColorBrush;
        UnHookCreatePen;
      end;
{$ENDIF} // WIN64
      GlobalHookInstalled := False;
      HookCallback := 0;
    end;
end;


procedure TsSkinManager.ReloadPackedSkin;
var
  sl: TStringList;
  TempSkinFile: TMemIniFile;
begin
  if FActive then begin
    aSkinChanging := True;
    sc := nil;
    LoadSkinFromFile(NormalDir(SkinDirectory) + SkinName + s_Dot + acSkinExt, sc, FKeyList, Self);
    if sc.Options = nil then begin
      aSkinChanging := True;
      ShowMessage('Internal format error in the "' + SkinName + '" skin. Please, update this skin to latest version.');
      aSkinChanging := False;
    end
    else begin
      sc.Options.Seek(0, 0);
      sl := TStringList.Create;
      SetCaseSens(sl);
      sl.LoadFromStream(sc.Options);
      TempSkinFile := TMemIniFile.Create('');
      SetCaseSens(TempSkinFile);
      TempSkinFile.SetStrings(sl);
      FreeAndNil(sl);
      CommonSkinData.SkinPath := GetFullSkinDirectory + s_Slash;
      CommonSkinData.Version := GetSkinVersion(TempSkinFile);

      CheckVersion;
      if Assigned(SkinFile) then
        FreeAndNil(SkinFile);

      Skinfile := TempSkinFile;
      LoadAllMasks;
      LoadAllGeneralData;
      InitConstantIndexes;
      if Assigned(FOnSkinLoading) then
        FOnSkinLoading(Self);

      aSkinChanging := False;
      if Assigned(SkinFile) then
        FreeAndNil(SkinFile);

      if Assigned(sc) then
        FreeAndNil(sc);
    end;
  end;
end;


procedure TsSkinManager.SetFSkinningRules(const Value: TacSkinningRules);
begin
  FSkinningRules := Value;
{$IFDEF D2007}
  UpdateCommonDlgs(Self);
{$ENDIF}
end;


procedure TsSkinManager.SetExtendedBorders(const Value: boolean);
var
  s: string;
begin
  if FExtendedBorders <> Value then begin
    FExtendedBorders := Value;
    if CommonSkinData.Active then begin
      aSkinChanging := True;
      s := NormalDir(SkinDirectory) + SkinName + s_Dot + acSkinExt;
      SkinIsPacked := FileExists(s);
      CheckShadows;
      if SkinIsPacked then
        ReloadPackedSkin
      else
        ReloadSkin;

      aSkinChanging := False;
      if [csLoading, csReading, csDesigning] * ComponentState = [] then
        RepaintForms;
    end;
  end;
end;


procedure TsSkinManager.CheckShadows;
var
  w, h: integer;
begin
  if FActive and ExtendedBorders then begin
    if ShdaTemplate <> nil then
      FreeAndNil(ShdaTemplate);

    if ShdiTemplate <> nil then
      FreeAndNil(ShdiTemplate);

    ShdaTemplate := TBitmap.Create;
    ShdiTemplate := TBitmap.Create;
    if ConstData.ExBorder >= 0 then begin
      with CommonSkinData do
        if ExDrawMode = 0 then
          with ma[ConstData.ExBorder] do begin // Shadow only
            // Calc a width from beginning of image to beginning of content
            FormShadowSize.Top    := WT - CommonSkinData.ExContentOffs;
            FormShadowSize.Left   := WL - ExContentOffs;
            FormShadowSize.Right  := WR - ExContentOffs;
            FormShadowSize.Bottom := WB - ExContentOffs;
          end
        else // Receive an offset to content
          FormShadowSize := Rect(ExContentOffs, ExContentOffs, ExContentOffs, ExContentOffs);

      w := ma[ConstData.ExBorder].Width;
      h := ma[ConstData.ExBorder].Height;
      ShdiTemplate.PixelFormat := pf32bit;
      ShdiTemplate.Width := w;
      ShdiTemplate.Height := h;
      BitBlt(ShdiTemplate.Canvas.Handle, 0, 0, w, h, ma[ConstData.ExBorder].Bmp.Canvas.Handle, 0, 0, SRCCOPY);
      if ma[ConstData.ExBorder].ImageCount = 1 then
        ShdaTemplate.Assign(ShdiTemplate)
      else begin
        ShdaTemplate.PixelFormat := pf32bit;
        ShdaTemplate.Width  := w;
        ShdaTemplate.Height := h;
        BitBlt(ShdaTemplate.Canvas.Handle, 0, 0, w, h, ma[ConstData.ExBorder].Bmp.Canvas.Handle, w, 0, SRCCOPY);
      end;
    end
    else
      if (rsta <> nil) and (rsti <> nil) then begin
        ShdaTemplate.Assign(rsta);
        ShdiTemplate.Assign(rsti);
        w := 9;
        FormShadowSize := Rect(w, w, w, w);
      end;
  end
  else
    FormShadowSize := MkRect;
end;


procedure TsSkinManager.CheckVersion;
var
  b: boolean;
begin
  if CommonSkinData.Version < CompatibleSkinVersion then begin
    if csDesigning in ComponentState then
      ShowMessage('You are using an old version of the "' + SkinName + '" skin. ' +
                  'Please, update skins to latest or contact the AlphaControls support for upgrading of existing skin.' + s_0D0A + s_0D0A +
                  'This notification occurs in design-time only for your information and will not occur in real-time.')
  end
  else
    if CommonSkinData.Version > MaxCompSkinVersion then begin
      b := srStdDialogs in SkinningRules;
      SkinningRules := SkinningRules - [srStdDialogs];
      MessageDlg('This version of the skin has not complete support by used AlphaControls package release.' + s_0D0A +
                 'Components must be updated to latest version for using this skin.', mtWarning, [mbOk], 0);
      if b then
        SkinningRules := SkinningRules + [srStdDialogs];
    end;
end;


function TsSkinManager.GetExtendedBorders: boolean;
begin
  Result := FExtendedBorders and Assigned(UpdateLayeredWindow);
end;


procedure TsSkinManager.BeginUpdate;
begin
  NoAutoUpdate := True;
end;


procedure TsSkinManager.EndUpdate(Repaint: boolean = False; AllowAnimation: boolean = True);
var
  b: boolean;
begin
  NoAutoUpdate := False;
  if AllowAnimation then
    UpdateSkin(Repaint)
  else begin
    b := AnimEffects.SkinChanging.Active;
    AnimEffects.SkinChanging.Active := False;
    UpdateSkin(Repaint);
    AnimEffects.SkinChanging.Active := b;
  end;
  if Assigned(FOnAfterChange) then
    FOnAfterChange(Self);
end;


procedure TsSkinManager.SetActiveGraphControl(const Value: TGraphicControl);
var
  sd: TsCommonData;
  OldControl: TGraphicControl;
begin
  if Value <> FActiveGraphControl then begin
    // Check if graph control is Hot still
    if (Value = nil) and (FActiveGraphControl <> nil) then begin
      sd := TsCommonData(FActiveGraphControl.Perform(SM_ALPHACMD, AC_GETSKINDATA_HI, 0));
      if (sd <> nil) and sd.FMouseAbove then
        Exit;
    end;
    OldControl := FActiveGraphControl;
    FActiveGraphControl := Value;
    if OldControl <> nil then
      OldControl.Perform(SM_ALPHACMD, AC_MOUSELEAVE_HI, LPARAM(Self));
  end;
end;


procedure TsSkinManager.SetBrightness(const Value: integer);
var
  i: integer;
begin
  i := LimitIt(Value, -100, 100);
  if FBrightness <> i then begin
    FBrightness := i;
    UpdateCurrentSkin;
  end;
end;


procedure ScaleImageList(ImgList: TCustomImageList; Data: Longint);
begin
  if ImgList is TsAlphaImageList then
    with TsAlphaImageList(ImgList) do begin
      acBeginUpdate;
      ScaleValue := Data;
      acEndUpdate(False);
    end
  else
    if ImgList is TsVirtualImageList then
      with TsVirtualImageList(ImgList) do begin
        acBeginUpdate;
        Width  := MulDiv(Width,  aScalePercents[Data], aScalePercents[CurrentScale]);
        Height := MulDiv(Height, aScalePercents[Data], aScalePercents[CurrentScale]);
        CurrentScale := Data;
        acEndUpdate(False);
      end;
end;


procedure TsSkinManager.UpdateAllScale;
var
  i: integer;
begin
  i := 0;
  IterateImageLists(ScaleImageList, GetScale);
  while i < Length(HookedComponents) do begin
    if HookedComponents[i] is TForm then
      UpdateScale(TForm(HookedComponents[i]));

    inc(i);
  end;
end;


procedure TsSkinManager.UpdateCurrentSkin;
var
  s: string;
begin
  if FActive and ([csLoading, csReading] * ComponentState = []) then begin
    aSkinChanging := True;
    s := NormalDir(SkinDirectory) + SkinName + s_Dot + acSkinExt;
    SkinIsPacked := FileExists(s);
    if SkinIsPacked then
      ReloadPackedSkin
    else
      ReloadSkin;

    SendNewSkin;
    aSkinChanging := False;
    if not NoAutoUpdate then begin
      if Assigned(FOnAfterChange) then
        FOnAfterChange(Self);
        
      RepaintForms;
    end;
  end
end;


procedure TsStoredSkins.Assign(Source: TPersistent);
begin
  //
end;


constructor TsStoredSkins.Create(AOwner: TsSkinManager);
begin
  inherited Create(TsStoredSkin);
  FOwner := AOwner;
end;


destructor TsStoredSkins.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;


function TsStoredSkins.GetItem(Index: Integer): TsStoredSkin;
begin
  Result := TsStoredSkin(inherited GetItem(Index))
end;


function TsStoredSkins.GetOwner: TPersistent;
begin
  Result := FOwner;
end;


function TsStoredSkins.IndexOf(const SkinName: string): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if GetItem(i).Name = SkinName then begin
      Result := i;
      Exit;
    end;
end;


procedure TsStoredSkins.SetItem(Index: Integer; Value: TsStoredSkin);
begin
  inherited SetItem(Index, Value);
end;


procedure TsStoredSkins.Update(Item: TCollectionItem);
begin
  inherited;
  if Assigned(FOwner.OnSkinListChanged) then
    FOwner.OnSkinListChanged(FOwner);
end;


procedure TsStoredSkin.Assign(Source: TPersistent);
var
  Src: TsStoredSkin;
begin
  if Source = nil then
    inherited
  else begin
    Src := TsStoredSkin(Source);
    PackedData.LoadFromStream(Src.PackedData);
    FMasterBitmap.Assign(Src.MasterBitmap);
    FName                := Src.Name;
    FAuthor              := Src.Author;
    FVersion             := Src.Version;
    FBorderColor         := Src.BorderColor;
    FDescription         := Src.Description;
    FShadow1Blur         := Src.Shadow1Blur;
    FShadow1Color        := Src.Shadow1Color;
    FShadow1Offset       := Src.Shadow1Offset;
    FShadow1Transparency := Src.Shadow1Transparency;
  end;
end;


constructor TsStoredSkin.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FMasterBitmap := TBitmap.Create;
  PackedData := TMemoryStream.Create;
  FShadow1Blur := -1;
  FBorderColor := clFuchsia;
end;


procedure TsStoredSkin.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, True);
end;


destructor TsStoredSkin.Destroy;
begin
  FreeAndNil(FMasterBitmap);
  FreeAndNil(PackedData);
  inherited Destroy;
end;


procedure TsStoredSkin.ReadData(Reader: TStream);
begin
  PackedData.LoadFromStream(Reader);
end;


procedure TsStoredSkin.WriteData(Writer: TStream);
begin
  PackedData.SaveToStream(Writer);
end;


constructor TacAnimEffects.Create;
begin
  FBlendOnMoving := TacBlendOnMoving.Create;
  FButtons       := TacBtnEffects.Create;
  FDialogShow    := TacDialogShow.Create;
  FFormShow      := TacFormShow.Create;
  FFormHide      := TacFormHide.Create;
  FDialogHide    := TacFormHide.Create;
  FMinimizing    := TacMinimizing.Create;
  FPageChange    := TacPageChange.Create;
  FSkinChanging  := TacSkinChanging.Create;
end;


destructor TacAnimEffects.Destroy;
begin
  FreeAndNil(FBlendOnMoving);
  FreeAndNil(FButtons);
  FreeAndNil(FDialogShow);
  FreeAndNil(FFormShow);
  FreeAndNil(FFormHide);
  FreeAndNil(FDialogHide);
  FreeAndNil(FMinimizing);
  FreeAndNil(FPageChange);
  FreeAndNil(FSkinChanging);
  inherited;
end;


constructor TacBtnEffects.Create;
begin
  FEvents := [beMouseEnter, beMouseLeave, beMouseDown, beMouseUp]
end;


constructor TacFormAnimation.Create;
begin
  FActive := True;
  FTime := 0;
  FMode := atAero;
end;


constructor TacDialogShow.Create;
begin
  inherited;
  FTime := 0;
end;


constructor TacSkinChanging.Create;
begin
  inherited;
  FTime := 100;
  FMode := atFading
end;


function ThirdPartyList.GetString(const Index: Integer): string;
begin
  case Index of
    ord(tpEdit)         : Result := FThirdEdits;
    ord(tpButton)       : Result := FThirdButtons;
    ord(tpBitBtn)       : Result := FThirdBitBtns;
    ord(tpCheckBox)     : Result := FThirdCheckBoxes;
    ord(tpGroupBox)     : Result := FThirdGroupBoxes;
    ord(tpListView)     : Result := FThirdListViews;
    ord(tpPanel)        : Result := FThirdPanels;
    ord(tpGrid)         : Result := FThirdGrids;
    ord(tpTreeView)     : Result := FThirdTreeViews;
    ord(tpComboBox)     : Result := FThirdComboBoxes;
    ord(tpwwEdit)       : Result := FThirdWWEdits;
    ord(tpVirtualTree)  : Result := FThirdVirtualTrees;
    ord(tpGridEh)       : Result := FThirdGridEh;
    ord(tpPageControl)  : Result := FThirdPageControl;
    ord(tpTabControl)   : Result := FThirdTabControl;
    ord(tpToolBar)      : Result := FThirdToolBar;
    ord(tpStatusBar)    : Result := FThirdStatusBar;
    ord(tpSpeedButton)  : Result := FThirdSpeedButton;
    ord(tpScrollControl): Result := FThirdScrollControl;
    ord(tpUpDownBtn)    : Result := FThirdUpDownBtn;
    ord(tpScrollBar)    : Result := FThirdScrollBar;
    ord(tpStaticText)   : Result := FThirdStaticText;
    ord(tpNativePaint)  : Result := FThirdNativePaint;
{$IFDEF ADDWEBBROWSER}
    ord(tpWebBrowser)   : Result := FThirdWebBrowser;
{$ENDIF}
  end
end;


procedure ThirdPartyList.SetString(const Index: Integer; const Value: string);
begin
  case Index of
    ord(tpEdit)         :   FThirdEdits         := Value;
    ord(tpButton)       :   FThirdButtons       := Value;
    ord(tpBitBtn)       :   FThirdBitBtns       := Value;
    ord(tpCheckBox)     :   FThirdCheckBoxes    := Value;
    ord(tpGroupBox)     :   FThirdGroupBoxes    := Value;
    ord(tpListView)     :   FThirdListViews     := Value;
    ord(tpPanel)        :   FThirdPanels        := Value;
    ord(tpGrid)         :   FThirdGrids         := Value;
    ord(tpTreeView)     :   FThirdTreeViews     := Value;
    ord(tpComboBox)     :   FThirdComboBoxes    := Value;
    ord(tpwwEdit)       :   FThirdWWEdits       := Value;
    ord(tpVirtualTree)  :   FThirdVirtualTrees  := Value;
    ord(tpGridEh)       :   FThirdGridEh        := Value;
    ord(tpPageControl)  :   FThirdPageControl   := Value;
    ord(tpTabControl)   :   FThirdTabControl    := Value;
    ord(tpToolBar)      :   FThirdToolBar       := Value;
    ord(tpStatusBar)    :   FThirdStatusBar     := Value;
    ord(tpSpeedButton)  :   FThirdSpeedButton   := Value;
    ord(tpScrollControl):   FThirdScrollControl := Value;
    ord(tpUpDownBtn)    :   FThirdUpDownBtn     := Value;
    ord(tpScrollBar)    :   FThirdScrollBar     := Value;
    ord(tpStaticText)   :   FThirdStaticText    := Value;
    ord(tpNativePaint)  :   FThirdNativePaint   := Value;
{$IFDEF ADDWEBBROWSER}
    ord(tpWebBrowser)   :   FThirdWebBrowser    := Value;
{$ENDIF}
  end
end;


constructor TacSkinEffects.Create;
begin
  FAllowGlowing      := True;
  FAllowAnimation    := True;
  FAllowAeroBluring  := True;
  FAllowOuterEffects := False;
end;


procedure TacSkinEffects.SetAllowOuterEffects(const Value: boolean);
begin
  if FAllowOuterEffects <> Value then begin
    FAllowOuterEffects := Value;
    if not (csLoading in Manager.ComponentState) and not Manager.NoAutoUpdate then
      Manager.RepaintForms(False);
  end;
end;


procedure TacSkinEffects.SetDiscoloredGlyphs(const Value: boolean);
begin
  if FDiscoloredGlyphs <> Value then begin
    FDiscoloredGlyphs := Value;
    if not (csLoading in Manager.ComponentState) and not Manager.NoAutoUpdate then
      Manager.RepaintForms;
  end;
end;


constructor TacMinimizing.Create;
begin
  inherited;
  FTime := 120;
end;


constructor TacBlendOnMoving.Create;
begin
  inherited;
  FActive := False;
  FBlendValue := 170;
  Time := 1000;
end;


constructor TacScrollBarsSupport.Create;
begin
  FButtonsSize := -1;
  FScrollSize := -1;
  FOwner := AOwner;
end;


procedure TacScrollBarsSupport.SetButtonsSize(const Value: integer);
begin
  if FButtonsSize <> Value then begin
    FButtonsSize := Value;
    if not (csLoading in FOwner.ComponentState) then
      FOwner.RepaintForms(False);
  end;
end;


procedure TacScrollBarsSupport.SetScrollSize(const Value: integer);
var
  M: TMessage;
begin
  if FScrollSize <> Value then begin
    FScrollSize := Value;
    if not (csLoading in FOwner.ComponentState) then begin
      M.Msg := SM_ALPHACMD;
      M.WParamHi := AC_REINITSCROLLS;
      AppBroadCastS(M);
    end;
  end;
end;


constructor TacButtonsSupport.Create(AOwner: TsSkinManager);
begin
  FShowFocusRect := True;
  FShiftContentOnClick := True;
end;


constructor TacLabelsSupport.Create(AOwner: TsSkinManager);
begin
  FTransparentAlways := True;
end;


constructor TacOptions.Create(AOwner: TsSkinManager);
begin
  FOwner := AOwner;
  FCheckEmptyAlpha        := False;
  FNoMouseHover           := False;
  FNativeBordersMaximized := False;
  FStdGlyphsOrder         := False;
  FChangeSysColors        := False;
  FScaleMode              := smOldMode;
  FOptimizingPriority     := opSpeed;
end;


function TacOptions.GetBool(const Index: Integer): boolean;
begin
  case Index of
    0: Result := FCheckEmptyAlpha;
    1: Result := FNoMouseHover;
    2: Result := FNativeBordersMaximized;
    3: Result := FStdGlyphsOrder
  else Result := FChangeSysColors; // 4
  end;
end;


procedure TacOptions.SetBool(const Index: Integer; const Value: boolean);
begin
  case Index of
    0: FCheckEmptyAlpha        := Value;
    1: FNoMouseHover           := Value;
    2: FNativeBordersMaximized := Value;
    3: FStdGlyphsOrder         := Value;
    4: begin
      FChangeSysColors := Value;
{$IFNDEF WIN64}
      if FOwner.IsDefault and ([csDesigning, csLoading] * FOwner.ComponentState = []) then
        if not Value then begin
          UnHookGetSysColor;
          UnHookGetSysColorBrush;
          UnHookCreatePen;
        end
        else begin
          HookGetSysColor;
          HookGetSysColorBrush;
          HookCreatePen;
        end;
{$ENDIF} // WIN64
    end;
  end;
end;


procedure TacOptions.SetScaleMode(const Value: TacScaleMode);
var
  OldScale: integer;
  ScaleChangeData: TScaleChangeData;

  procedure UpdateVariables;
  begin
    if FOwner.IsDefault then begin
      ac_ArrowWidth := MulDiv(ac_ArrowWidth, aScalePercents[FOwner.GetScale], aScalePercents[OldScale]);
      ac_ArrowHeight := ac_ArrowWidth div 2 + ac_ArrowWidth mod 2;
    end;
  end;

begin
  if FScaleMode <> Value then begin
    OldScale := FOwner.GetScale;

    if Assigned(FOwner.OnScaleModeChange) then begin
      ScaleChangeData.OldScaleMode := FScaleMode;
      ScaleChangeData.NewScaleMode := Value;

      ScaleChangeData.OldScalePercent := aScalePercents[OldScale];
      ScaleChangeData.NewScalePercent := aScalePercents[ord(Value)];

      FOwner.OnScaleModeChange(FOwner, ScaleChangeData);
    end;
    FScaleMode := Value;
    with FOwner do
      if not (csDesigning in FOwner.ComponentState) then begin
        UpdateVariables;
        if not (csLoading in ComponentState) then begin
          BeginUpdate;
          UpdateAllScale;
          UpdateCurrentSkin;
          EndUpdate(True, False);
        end;
      end;
  end;
end;


procedure TsSkinManager.ClearExtArray;
var
  i: integer;
begin
  for i := 0 to Length(ExtArray) - 1 do
    if ExtArray[i].Bmp <> nil then
      FreeAndNil(ExtArray[i].Bmp);

  SetLength(ExtArray, 0);
end;


function TsSkinManager.ScaleInt(Value: integer; SysScale: integer = 0): integer;
var
  iScale: integer;
begin
  if Options.ScaleMode = smOldMode then
    Result := Value
  else
    if SysScale = 0 then
      case GetScale of
        1:   Result := Value + Value div 4;
        2:   Result := Value + Value div 2
        else Result := Value;
      end
    else begin
      iScale := GetScale;
      if iScale > SysScale then
        Result := Value * aScalePercents[SysScale] div 100
      else
        if iScale < SysScale then
          Result := Value
        else
          Result := Value;
    end;
{    if Value < SysScale then
      Result := Value * 100 div SysScale
    else}
end;


function TsSkinManager.SearchExtFile(s: string): TBitmap;
var
  i: integer;
begin
  for i := 0 to Length(ExtArray) - 1 do
    if ExtArray[i].FileName = s then begin
      Result := ExtArray[i].Bmp;
      Exit;
    end;

  Result := nil;
end;


function TsSkinManager.MakeNewItem(SkinIndex: integer; const PropertyName, AClassName: string; ImgType: TacImgType; R: TRect; Count, DrawMode: integer; Masktype: smallint): integer;
begin
  Result := Length(ma);
  SetLength(ma, Result + 1);
  ma[Result].PropertyName := PropertyName;
  ma[Result].ClassName    := AClassName;
  ma[Result].SkinIndex    := SkinIndex;
  ma[Result].DrawMode     := DrawMode;
  ma[Result].Masktype     := Masktype;
  ma[Result].ImgType      := ImgType;
  ma[Result].ImageCount   := Count;
  ma[Result].Manager      := Self;
  ma[Result].R            := R;
end;


procedure TacSkinConvertor.Clear;
begin
  while Length(Files) > 0 do begin
    Files[Length(Files) - 1].FileStream.Free;
    SetLength(Files, Length(Files) - 1);
  end;
  if Options <> nil then
    FreeAndNil(Options);

  if PackedData <> nil then
    FreeAndNil(PackedData);
end;


destructor TacSkinConvertor.Destroy;
begin
  Clear;
  inherited;
end;


function TryStrTo64(s: AnsiString; out l: Int64): boolean;
var
  i: integer;
begin
  l := 0;
  Result := True;
  for i := 1 to Length(S) do
    if S[i] in ['0'..'9'] then
      l := 10 * l + Ord(S[i]) - Ord('0')
    else begin
      Result := False;
      Break;
    end;
end;


function ExtractPackedData(var Convertor: TacSkinConvertor; pwds: TStringList; SkinManager: TComponent): boolean;
var
  s: AnsiString;
  l, i, c, r: Integer;
  cArray: TsCharArray;
  KeysArray: array of Int64;
  decompr: TZDecompressionStream;
  bStdDialogs, bSysColors: boolean;

  procedure DisableManager;
  begin
    with TsSkinManager(SkinManager) do begin
      bStdDialogs := srStdDialogs in SkinningRules;
      SkinningRules := SkinningRules - [srStdDialogs];
      bSysColors := Options.ChangeSysColors;
      Options.ChangeSysColors := False;
    end;
  end;

  procedure EnableManager;
  begin
    with TsSkinManager(SkinManager) do begin
      if bStdDialogs then
        SkinningRules := SkinningRules + [srStdDialogs];

      Options.ChangeSysColors := bSysColors;
    end;
  end;

begin
  // Check file type
  SetLength(KeysArray, pwds.Count);
  for i := 0 to pwds.Count - 1 do begin
    s := pwds[i];
    s := DelChars(s, #13);
    s := DelChars(s, #10);
    s := DelChars(s, ' ');
    if not TryStrTo64(s, KeysArray[i]) then begin
      KeysArray[i] := 0;
      DisableManager;
      MessageDlg('Secure key has incorrect format', mtError, [mbOk], 0);
      EnableManager;
    end;
  end;
  Convertor.PackedData.Seek(0, 0);
  if SkinManager.Owner <> nil then
    for i := 1 to Length(SkinManager.Owner.Name) do
      inc(c, ord(SkinManager.Owner.Name[i]));

  Convertor.PackedData.Read(cArray, SizeOf(TsCharArray));
  DisableManager;
  l := asSkinDecode(cArray, KeysArray, pwds.Count, c, c, r);
  EnableManager;
  case l of
   -1: begin
      Result := False;
      DisableManager;
      MessageDlg('Loaded data is not a packed AlphaSkin file', mtError, [mbOk], 0);
      EnableManager;
      Exit;
    end

    else begin
{$IFDEF WIN64}
      if l = -3 then
        MessageDlg('Unregistered skin has been loaded.'#13#10'If you have a key for this skin, please insert it in the KeyList.', mtInformation, [mbOk], 0);
{$ENDIF}
      Convertor.PackedData.Seek(iff(l = 0, 8, 10), 0);
      // Extract all files
      Convertor.ImageCount := c - 1;
      for i := 1 to c do begin
        // Get length of file name
        Convertor.PackedData.Read(l, SizeOf(l));
        // Extract file name
        SetLength(s, l);
        Convertor.PackedData.Read(s[1], l);
        // Get length of file
        Convertor.PackedData.Read(l, SizeOf(l));
        Decompr := TZDecompressionStream.Create(Convertor.PackedData);
        // Extract file
        if UpperCase(s) = UpperCase('Options.dat') then begin
          Convertor.Options := TMemoryStream.Create;
          Convertor.Options.CopyFrom(Decompr, l - r);
        end
        else begin
          SetLength(Convertor.Files, Length(Convertor.Files) + 1);
          with Convertor.Files[Length(Convertor.Files) - 1] do begin
            FileName := s;
            IsBitmap := UpperCase(ExtractFileExt(s)) = '.BMP';
            FileStream := TMemoryStream.Create;
            FileStream.CopyFrom(Decompr, l - r);
          end;
        end;
        FreeAndNil(Decompr);
      end;
      Result := True;
    end;
  end;
end;


function GetPreviewStream(aStream: TMemoryStream; SkinFileName: string): boolean; overload;
var
  fs: TMemoryStream;
begin
  Result := False;
  if FileExists(SkinFileName) then begin
    fs := TMemoryStream.Create;
    fs.LoadFromFile(SkinFileName);
    try
      Result := GetPreviewStream(aStream, fs);
    finally
      fs.Free;
    end;
  end;
end;


function GetPreviewStream(aStream: TMemoryStream; SrcStream: TMemoryStream): boolean; overload;
const
  sMagic = 'previewimg';
  sEncoded: array [0..3] of AnsiChar = ('A', 'S', 'z', 'c');
var
  l, position: integer;
  sStream: TStringStream;
begin
  Result := False;

  sStream := TStringStream.Create{$IFNDEF D2010}(''){$ENDIF};
  SrcStream.Seek(0, 0);
  sStream.CopyFrom(SrcStream, SrcStream.Size);

  position := Pos(sMagic, AnsiString(sStream.DataString));
  if position > 0 then begin
    SrcStream.Seek(position + Length(sMagic) - 1, 0);
    SrcStream.Read(l, SizeOf(l));
    try
      aStream.Size := l;
      aStream.CopyFrom(SrcStream, l);
      aStream.Seek(0, 0);
    finally
      Result := True;
    end;
  end;
  sStream.Free;
end;


function GetPreviewImage(aBitmap: TBitmap; SkinFileName: string): boolean;
var
  ImgStream: TMemoryStream;
begin
  Result := False;
  aBitmap.Assign(nil);
  ImgStream := TMemoryStream.Create;
  if GetPreviewStream(ImgStream, SkinFileName) then
    try
      aBitmap.LoadFromStream(ImgStream);
    finally
      Result := True;
    end;

  ImgStream.Free;
end;


var
  rst: TResourceStream = nil;
  ic: integer;


procedure TacSkinListController.AddControl(Ctrl: TControl);
var
  i: integer;
  DoUpdate: boolean;
begin
  DoUpdate := (Length(Controls) = 0) and (Length(SkinList) = 0);
  i := CtrlIndex(Ctrl);
  if i < 0 then begin
    SetLength(Controls, Length(Controls) + 1);
    Controls[Length(Controls) - 1] := Ctrl;
  end;
  if DoUpdate then
    UpdateData(True);
end;


constructor TacSkinListController.Create(AOwner: TsSkinManager);
begin
  SkinManager := AOwner;
  ImgList := TsAlphaImageList.Create(AOwner);
  TsAlphaImageList(ImgList).IgnoreTransparency := True;
  ImgList.Height := 100;
  ImgList.Width := 140;
  TsAlphaImageList(ImgList).AllowScale := False;
end;


function TacSkinListController.CtrlIndex(Ctrl: TControl): integer;
var
  i: integer;
begin
  for i := 0 to Length(Controls) - 1 do
    if Controls[i] = Ctrl then begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;


procedure TacSkinListController.DelControl(Ctrl: TControl);
var
  i: integer;
begin
  i := CtrlIndex(Ctrl);
  if i >= 0 then
    Controls[i] := nil;
end;


destructor TacSkinListController.Destroy;
begin
  ImgList.Free;
  inherited;
end;


procedure TacSkinListController.SendListChanged;
var
  i: integer;
begin
  for i := 0 to Length(Controls) - 1 do
    if Controls[i] <> nil then
      Controls[i].Perform(SM_ALPHACMD, AC_SKINLISTCHANGED shl 16, 0);
end;


procedure TacSkinListController.SendSkinChanged;
var
  i: integer;
begin
  for i := 0 to Length(Controls) - 1 do
    if Controls[i] <> nil then
      if (Controls[i] is TWinControl) and TWinControl(Controls[i]).HandleAllocated then
        PostMessage(TWinControl(Controls[i]).Handle, SM_ALPHACMD, AC_SKINCHANGED shl 16, 0)
      else
        Controls[i].Perform(SM_ALPHACMD, AC_SKINCHANGED shl 16, 0);
end;


procedure TacSkinListController.UpdateData(UpdateNow: boolean);
var
  FileInfo: TacSearchRec;
  i, DosCode: Integer;
  sp: string;

  procedure AddSkin(const AName: string; IntIndex: integer);
  var
    l: integer;
    Stream: TMemoryStream;
  begin
    Stream := TMemoryStream.Create;
    l := Length(SkinList);
    SetLength(SkinList, l + 1);
    SkinList[l].skName := AName;
    SkinList[l].skImageIndex := -1;
    if IntIndex < 0 then begin // External
      if GetPreviewStream(Stream, sp + AName) then
        if TsAlphaImageList(ImgList).TryLoadFromPngStream(Stream) then
          SkinList[l].skImageIndex := TsAlphaImageList(ImgList).Items.Count - 1;

      Delete(SkinList[l].skName, pos(s_Dot + acSkinExt, LowerCase(AName)), 4);
    end
    else begin
      if GetPreviewStream(Stream, SkinManager.InternalSkins[IntIndex].PackedData) then
        if TsAlphaImageList(ImgList).TryLoadFromPngStream(Stream) then
          SkinList[l].skImageIndex := TsAlphaImageList(ImgList).Items.Count - 1;
    end;
    Stream.Free;
  end;

begin
  if [csLoading, csDestroying] * SkinManager.ComponentState = [] then begin
    SetLength(SkinList, 0);
    TsAlphaImageList(ImgList).Clear;
    TsAlphaImageList(ImgList).Handle;

    sp := NormalDir(SkinManager.GetFullskinDirectory);
    // Internal skins names loading
    if SkinManager.InternalSkins.Count > 0 then
      for i := 0 to SkinManager.InternalSkins.Count - 1 do
        AddSkin(SkinManager.InternalSkins[i].Name, i);

    // External skins names loading
    if acDirExists(sp) then begin
  //    sp := sp + '\*.*';
      DosCode := acFindFirst(sp + '*.*', faDirectory, FileInfo);
      try
        while DosCode = 0 do begin
          if FileInfo.Name[1] <> s_Dot then
            if (FileInfo.Attr and faDirectory = 0) and (ExtractFileExt(FileInfo.Name) = s_Dot + acSkinExt) then
              AddSkin(FileInfo.Name, -1);

          DosCode := acFindNext(FileInfo);
        end;
      finally
        acFindClose(FileInfo);
      end;
    end;
    SendListChanged;
  end;
end;


var
  huser32: HMODULE = 0;

initialization
  OSVerInfo.dwOSVersionInfoSize := sizeof(OSVerInfo);
  GetVersionEx(OSVerInfo);
  IsNT := OSVerInfo.dwPlatformId = VER_PLATFORM_WIN32_NT;

  rst := TResourceStream.Create(hInstance, 'acSHDA', RT_RCDATA);
  rsta := TBitmap.Create;
  LoadBmpFromPngStream(rsta, rst);
  UpdateTransPixels(rsta);
  FreeAndNil(rst);

  rst := TResourceStream.Create(hInstance, 'acSHDI', RT_RCDATA);
  rsti := TBitmap.Create;
  LoadBmpFromPngStream(rsti, rst);
  UpdateTransPixels(rsti);
  FreeAndNil(rst);

  if ParamCount > 0 then
    for ic := 1 to ParamCount do
      if LowerCase(ParamStr(ic)) = '/acver' then begin
        ShowMessage('AlphaControls v' + acCurrentVersion);
        Break;
      end;

  huser32 := LoadLibrary(user32);
  if huser32 <> 0 then
    ac_SetProcessDPIAware := GetProcAddress(huser32, 'SetProcessDPIAware');

finalization
  FreeAndNil(rsta);
  FreeAndNil(rsti);

  if huser32 <> 0 then
    FreeLibrary(huser32);

end.
