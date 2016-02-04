{***************************************************************************}
{ TTntTaskDialog component                                                  }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2007 - 2008                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit TntTaskDialog;

{$R TntTASKDIALOG.RES}

{$INCLUDE TntCompilers.inc}
{$J+}
{$R-}
{$B-}
{$C+}


{$IFDEF DELPHI_7_UP}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$ENDIF}

interface

uses
  Classes, Windows, Messages, Forms, Dialogs, SysUtils, StdCtrls, Graphics,
  Consts, Math, ExtCtrls, Controls, ComCtrls, ComObj, ShellAPI, CommCtrl,
  TntClasses, TntForms, TntStdCtrls, TntPictures, TntControls, TntWindows,
  TntSysUtils, Clipbrd;

const
{$IFNDEF DELPHI_6_UP}
  sLineBreak = #13#10;
{$ENDIF}

  MAJ_VER = 1; // Major version nr.
  MIN_VER = 3; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // 1.0.0.0 : First release
  // 1.1.0.0 : New : support for Information & Shield footer icon
  // 1.2.0.0 : Inherits all improvements of ansi TaskDialog version
  // 1.3.0.0 : Fixed : issue with identical accelerator key for expand/collaps state

type
  {$IFDEF DELPHI_UNICODE}
  TWideCaption = string;
  {$ENDIF}

  {$IFNDEF DELPHI_6_UP}
  PBoolean = ^Boolean;
  {$ENDIF}

  TTaskDialogResult = (trNone, trOk, trCancel);

  TTaskDialogOption = (doHyperlinks, doCommandLinks, doCommandLinksNoIcon, doExpandedDefault, doExpandedFooter, doAllowMinimize, doVerifyChecked, doProgressBar, doProgressBarMarquee, doTimer, doNoDefaultRadioButton, doAllowDialogCancel);

  TTaskDialogOptions = set of TTaskDialogOption;

  TTaskDialogIcon = (tiBlank, tiWarning, tiQuestion, tiError, tiInformation,tiNotUsed,tiShield);

  TTaskDialogFooterIcon = (tfiBlank, tfiWarning, tfiQuestion, tfiError, tfiInformation, tfiShield);

  TTaskDialogProgressState = (psNormal, psError, psPaused);

  TTaskDialogPosition = (dpScreenCenter, dpOwnerFormCenter);

  TCommonButton = (cbOK, cbYes, cbNo, cbCancel, cbRetry, cbClose);

  TTaskDialogButtonClickEvent = procedure(Sender: TObject; ButtonID: integer) of object;
  TTaskDialogHyperlinkClickEvent = procedure(Sender: TObject; HRef: WideString) of object;
  TTaskDialogVerifyClickEvent = procedure(Sender: TObject; Checked: boolean) of object;
  TTaskDialogCloseEvent = procedure(Sender: TObject; var CanClose: boolean) of object;

  TTaskDialogProgressEvent = procedure(Sender: TObject; var Pos: integer; var State: TTaskDialogProgressState) of object;

  TCommonButtons = set of TCommonButton;

  TAdvMessageForm = class;

  TTntTaskDialog = class(TComponent)
  private
    FTitle: WideString;
    FContent: WideString;
    FFooter: WideString;
    FInstruction: WideString;
    FCommonButtons: TCommonButtons;
    FExpandedText: WideString;
    FCollapsControlText: WideString;
    FExpandControlText: WideString;
    FButtonResult: integer;
    FVerifyResult: boolean;
    FVerifyText: WideString;
    FCustomButtons: TTntStringList;
    FCustomIcon: TIcon;
    FOptions: TTaskDialogOptions;
    FRadioButtons: TTntStringList;
    FhWnd: THandle;
    FOnCreated: TNotifyEvent;
    FOnTimer: TNotifyEvent;
    FProgressBarMin: integer;
    FProgressBarMax: integer;
    FOnDialogHyperlinkClick: TTaskDialogHyperlinkClickEvent;
    FOnDialogClick: TTaskDialogButtonClickEvent;
    FOnDialogRadioClick: TTaskDialogButtonClickEvent;
    FOnDialogVerifyClick: TTaskDialogVerifyClickEvent;
    FOnDialogProgress: TTaskDialogProgressEvent;
    FOnDialogClose: TTaskDialogCloseEvent;
    FIcon: TTaskDialogIcon;
    FFooterIcon: TTaskDialogFooterIcon;
    FDefaultButton: integer;
    FDefaultRadioButton: integer;
    FDialogForm: TAdvMessageForm;
    FDlgPosition: TTaskDialogPosition;
    FFont: TFont;
    FApplicationIsParent: Boolean;
    FModalParent: THandle;
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    function GetVersionNr: Integer;
    procedure SetCustomButtons(const Value: TTntStringList);
    procedure SetRadioButtons(const Value: TTntStringList);
    procedure SetContent(const Value: WideString);
    procedure SetInstruction(const Value: WideString);
    procedure SetFooter(const Value: WideString);
    procedure SetExpandedText(const Value: WideString);
    procedure SetFont(const Value: TFont);
    procedure SetCustomIcon(const Value: TIcon);    
  protected
    function CreateButton(AOwner: TComponent): TWinControl; virtual;
    procedure SetButtonCaption(aButton: TWinControl; Value: TWideCaption); virtual;
    procedure SetButtonCancel(aButton: TWinControl; Value: Boolean); virtual;
    procedure SetButtonDefault(aButton: TWinControl; Value: Boolean); virtual;
    procedure SetButtonModalResult(aButton: TWinControl; Value: Integer); virtual;
    function GetButtonModalResult(aButton: TWinControl): Integer; virtual;
  public
    property hWnd: THandle read FhWnd write FhWnd;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: integer;
    procedure Clear;
    procedure EnableButton(ButtonID: integer; Enabled: boolean);
    procedure ClickButton(ButtonID: integer);
    property RadioButtonResult: integer read FButtonResult write FButtonResult;
    property VerifyResult: boolean read FVerifyResult write FVerifyResult;
    property ModalParent: THandle read FModalParent write FModalParent;
  published
    property CustomButtons: TTntStringList read FCustomButtons write SetCustomButtons;
    property CustomIcon: TIcon read FCustomIcon write SetCustomIcon;    
    property RadioButtons: TTntStringList read FRadioButtons write SetRadioButtons;
    property CommonButtons: TCommonButtons read FCommonButtons write FCommonButtons;
    property DefaultButton: integer read FDefaultButton write FDefaultButton;
    property DefaultRadioButton: integer read FDefaultRadioButton write FDefaultRadioButton;
    property DialogPosition: TTaskDialogPosition read FDlgPosition write FDlgPosition default dpScreenCenter;
    property ExpandedText: WideString read FExpandedText write SetExpandedText;
    property Font: TFont read FFont write SetFont;
    property Footer: WideString read FFooter write SetFooter;
    property FooterIcon: TTaskDialogFooterIcon read FFooterIcon write FFooterIcon;
    property Icon: TTaskDialogIcon read FIcon write FIcon;
    property Title: WideString read FTitle write FTitle;
    property Instruction: WideString read FInstruction write SetInstruction;
    property Content: WideString read FContent write SetContent;
    property ExpandControlText: WideString read FExpandControlText write FExpandControlText;
    property CollapsControlText: WideString read FCollapsControlText write FCollapsControlText;
    property Options: TTaskDialogOptions read FOptions write FOptions;
    property ApplicationIsParent: boolean read FApplicationIsParent write FApplicationIsParent default true;
    property VerificationText: WideString read FVerifyText write FVerifyText;

    property ProgressBarMin: integer read FProgressBarMin write FProgressBarMin default 0;
    property ProgressBarMax: integer read FProgressBarMax write FProgressBarMax default 100;
    property Version: string read GetVersion write SetVersion;

    property OnDialogCreated: TNotifyEvent read FOnCreated write FOnCreated;
    property OnDialogClose: TTaskDialogCloseEvent read FOnDialogClose write FOnDialogClose;
    property OnDialogButtonClick: TTaskDialogButtonClickEvent read FOnDialogClick write FOnDialogClick;
    property OnDialogRadioClick: TTaskDialogButtonClickEvent read FOnDialogRadioClick write FOnDialogRadioClick;
    property OnDialogHyperlinkClick: TTaskDialogHyperlinkClickEvent read FOnDialogHyperlinkClick write FOnDialogHyperLinkClick;
    property OnDialogTimer: TNotifyEvent read FOnTimer write FOnTimer;
    property OnDialogVerifyClick: TTaskDialogVerifyClickEvent read FOnDialogVerifyClick write FOnDialogVerifyClick;
    property OnDialogProgress: TTaskDialogProgressEvent read FOnDialogProgress write FOnDialogProgress;
  end;

  TTaskDialogButton = class(TCustomControl)
  private
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FGlyph: TBitmap;
    FGlyphDisabled: TBitmap;
    FGlyphDown: TBitmap;
    FGlyphHot: TBitmap;
    FMouseInControl: Boolean;
    FMouseDown: Boolean;
    FBorderColorDown: TColor;
    FBorderColorHot: TColor;
    FBorderColor: TColor;
    FModalResult: TModalResult;
    FHeadingFont: TFont;
    FAutoFocus: boolean;
    FCaption: widestring;
    procedure OnPictureChanged(Sender: TObject);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetGlyph(const Value: TBitmap);
    procedure SetGlyphDisabled(const Value: TBitmap);
    procedure SetGlyphDown(const Value: TBitmap);
    procedure SetGlyphHot(const Value: TBitmap);
    procedure SetHeadingFont(const Value: TFont);
  protected
    procedure Paint; override;
    procedure KeyPress(var Key: char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    property AutoFocus: boolean read FAutoFocus write FAutoFocus;
  published
    property Anchors;
    property BorderColor: TColor read FBorderColor write FBorderColor;
    property BorderColorHot: TColor read FBorderColorHot write FBorderColorHot;
    property BorderColorDown: TColor read FBorderColorDown write FBorderColorDown;
    property Caption: widestring read FCaption write FCaption;
    property Constraints;
    property Enabled;
    property HeadingFont: TFont read FHeadingFont write SetHeadingFont;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property Picture: TBitmap read FGlyph write SetGlyph;
    property PictureHot: TBitmap read FGlyphHot write SetGlyphHot;
    property PictureDown: TBitmap read FGlyphDown write SetGlyphDown;
    property PictureDisabled: TBitmap read FGlyphDisabled write SetGlyphDisabled;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TAdvMessageForm = class(TTntForm)
  private
    Message: TTntLabel;
    FHorzMargin: Integer;
    FVertMargin: Integer;
    FHorzSpacing: Integer;
    FVertSpacing: Integer;
    FExpandButton: TTaskDialogButton;
    FExpanded: Boolean;
    //FExpandLabel: TLabel;
    FExpandControlText: WideString;
    FCollapsControlText: WideString;
    FcmBtnList: TList;
    FcsBtnList: TList;
    FTaskDialog: TTntTaskdialog;
    FFooterIcon: TImage;
    FFooterIconID: PChar;
    FRadioList: TList;
    FVerificationCheck: TTntCheckBox;
    FProgressBar: TProgressBar;
    FIcon: TImage;
    FFooterXSize: Integer;
    FFooterYSize: Integer;
    FContentXSize: Integer;
    FContentYSize: Integer;
    FExpTextXSize: Integer;
    FExpTextYSize: Integer;
    FExpTextTop: Integer;
    FAnchor: WideString;
    FTimer: TTimer;
    FWhiteWindowHeight: Integer;
    FHorzParaMargin: Integer;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure OnTimer(Sender: TObject);
    procedure OnExpandButtonClick(Sender: TObject);
    procedure OnVerifyClick(Sender: TObject);
    procedure OnRadioClick(Sender: TObject);
    procedure OnButtonClick(Sender: TObject);
    procedure SetExpandButton(const Value: TTaskDialogButton);
    procedure GetTextSize(Canvas: TCanvas; Text: WideString; var W, H: Integer);
    //procedure GetMultiLineTextSize(Canvas: TCanvas; Text: string; HeadingFont, ParaFont: TFont; var W, H: Integer);
    //procedure HelpButtonClick(Sender: TObject);
  protected
    procedure SetExpanded(Value: Boolean);
    procedure CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure WriteToClipBoard(Text: WideString);
    function GetFormText: WideString;
    procedure Paint; override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DoClose(var Action: TCloseAction); override;

    function GetButton(ButtonID: Integer; var TaskButton: TTaskDialogButton): TTntButton;
    procedure EnableButton(ButtonID: integer; Enabled: boolean);
    procedure ClickButton(ButtonID: integer);
    function IsAnchor(x, y: integer): WideString;
    function GetFooterRect: TRect;
    function GetContentRect: TRect;
    function GetExpTextRect: TRect;
    procedure DrawExpandedText;
    procedure DrawContent;
    procedure DrawFooter;
    property Expanded: Boolean read FExpanded default true;
    property ExpandButton: TTaskDialogButton read FExpandButton write SetExpandButton;
    procedure DoShow; override;
  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer); {$IFNDEF CPPB} reintroduce; {$ENDIF}
    destructor Destroy; override;
    procedure BuildTaskDialog(TaskDialog: TTntTaskdialog);
    procedure SetPositions;
    procedure UpdateDialog;
  end;

  function AdvMessageDlgPos(TaskDialog: TTntTaskdialog; X, Y: Integer): Integer;

var
  DRAWBORDER: Boolean = True;

implementation

uses
  TntSystem, TntGraphics, TntClipBrd;

{$I 'TntHTMLEng.pas'}

const
   TDE_CONTENT                         = 0;
   TDE_EXPANDED_INFORMATION            = 1;
   TDE_FOOTER                          = 2;
   TDE_MAIN_INSTRUCTION                = 3;

    TDF_ENABLE_HYPERLINKS               = $0001;
    TDF_USE_HICON_MAIN                  = $0002;
    TDF_USE_HICON_FOOTER                = $0004;
    TDF_ALLOW_DIALOG_CANCELLATION       = $0008;
    TDF_USE_COMMAND_LINKS               = $0010;
    TDF_USE_COMMAND_LINKS_NO_ICON       = $0020;
    TDF_EXPAND_FOOTER_AREA              = $0040;
    TDF_EXPANDED_BY_DEFAULT             = $0080;
    TDF_VERIFICATION_FLAG_CHECKED       = $0100;
    TDF_SHOW_PROGRESS_BAR               = $0200;
    TDF_SHOW_MARQUEE_PROGRESS_BAR       = $0400;
    TDF_CALLBACK_TIMER                  = $0800;
    TDF_POSITION_RELATIVE_TO_WINDOW     = $1000;
    TDF_RTL_LAYOUT                      = $2000;
    TDF_NO_DEFAULT_RADIO_BUTTON         = $4000;
    TDF_CAN_BE_MINIMIZED                = $8000;

    TDM_NAVIGATE_PAGE                   = WM_USER+101;
    TDM_CLICK_BUTTON                    = WM_USER+102; // wParam = Button ID
    TDM_SET_MARQUEE_PROGRESS_BAR        = WM_USER+103; // wParam = 0 (nonMarque) wParam != 0 (Marquee)
    TDM_SET_PROGRESS_BAR_STATE          = WM_USER+104; // wParam = new progress state
    TDM_SET_PROGRESS_BAR_RANGE          = WM_USER+105; // lParam = MAKELPARAM(nMinRange, nMaxRange)
    TDM_SET_PROGRESS_BAR_POS            = WM_USER+106; // wParam = new position
    TDM_SET_PROGRESS_BAR_MARQUEE        = WM_USER+107; // wParam = 0 (stop marquee), wParam != 0 (start marquee), lparam = speed (milliseconds between repaints)
    TDM_SET_ELEMENT_TEXT                = WM_USER+108; // wParam = element (TASKDIALOG_ELEMENTS), lParam = new element text (LPCWSTR)
    TDM_CLICK_RADIO_BUTTON              = WM_USER+110; // wParam = Radio Button ID
    TDM_ENABLE_BUTTON                   = WM_USER+111; // lParam = 0 (disable), lParam != 0 (enable), wParam = Button ID
    TDM_ENABLE_RADIO_BUTTON             = WM_USER+112; // lParam = 0 (disable), lParam != 0 (enable), wParam = Radio Button ID
    TDM_CLICK_VERIFICATION              = WM_USER+113; // wParam = 0 (unchecked), 1 (checked), lParam = 1 (set key focus)
    TDM_UPDATE_ELEMENT_TEXT             = WM_USER+114; // wParam = element (TASKDIALOG_ELEMENTS), lParam = new element text (LPCWSTR)
    TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE = WM_USER+115; // wParam = Button ID, lParam = 0 (elevation not required), lParam != 0 (elevation required)
    TDM_UPDATE_ICON                     = WM_USER+116;  // wParam = icon element (TASKDIALOG_ICON_ELEMENTS), lParam = new icon (hIcon if TDF_USE_HICON_* was set, PCWSTR otherwise)

    TDN_CREATED                         = 0;
    TDN_NAVIGATED                       = 1;
    TDN_BUTTON_CLICKED                  = 2;            // wParam = Button ID
    TDN_HYPERLINK_CLICKED               = 3;            // lParam = (LPCWSTR)pszHREF
    TDN_TIMER                           = 4;            // wParam = Milliseconds since dialog created or timer reset
    TDN_DESTROYED                       = 5;
    TDN_RADIO_BUTTON_CLICKED            = 6;            // wParam = Radio Button ID
    TDN_DIALOG_CONSTRUCTED              = 7;
    TDN_VERIFICATION_CLICKED            = 8;             // wParam = 1 if checkbox checked, 0 if not, lParam is unused and always 0
    TDN_HELP                            = 9;
    TDN_EXPANDO_BUTTON_CLICKED          = 10;            // wParam = 0 (dialog is now collapsed), wParam != 0 (dialog is now expanded)

    TDCBF_OK_BUTTON            = $0001; // selected control return value IDOK
    TDCBF_YES_BUTTON           = $0002; // selected control return value IDYES
    TDCBF_NO_BUTTON            = $0004; // selected control return value IDNO
    TDCBF_CANCEL_BUTTON        = $0008; // selected control return value IDCANCEL
    TDCBF_RETRY_BUTTON         = $0010; // selected control return value IDRETRY
    TDCBF_CLOSE_BUTTON         = $0020;  // selected control return value IDCLOSE

    PBST_NORMAL        =     $0001;
    PBST_ERROR         =     $0002;
    PBST_PAUSED        =     $0003;
{
    TD_ICON_BLANK = 100;
    TD_ICON_WARNING = 101;
    TD_ICON_QUESTION = 102;
    TD_ICON_ERROR = 103;
    TD_ICON_INFORMATION = 104;
    TD_ICON_BLANK_AGAIN = 105;
    TD_ICON_SHIELD = 106;
}
    // Well, Microsoft did it again, incorrect TD_ICON_xxx values in the SDK
    // and changing values just between last beta2 & RTM... Gotta love them.
    // These values were obtained emperically by the lack of proper documentation

    TD_ICON_BLANK = 17;
    TD_ICON_WARNING = 84;
    TD_ICON_QUESTION = 99;
    TD_ICON_ERROR = 98;
    TD_ICON_INFORMATION = 81;
    TD_ICON_BLANK_AGAIN = 0;
    TD_ICON_SHIELD = 78;


type
  TProControl = class(TControl);
  
  PTASKDIALOG_BUTTON = ^TTASKDIALOG_BUTTON;
  TTASKDIALOG_BUTTON  = record
    nButtonID: integer;
    pszButtonText: pwidechar;
  end;

  TTaskDialogWideString = array[0..255] of widechar;

  TTaskDialogButtonArray = array of TTASKDIALOG_BUTTON;
  TTaskDialogWideStringArray = array of TTaskDialogWideString;

  PTASKDIALOGCONFIG = ^TTASKDIALOGCONFIG;
  TTASKDIALOGCONFIG = record
    cbSize: integer;
    hwndParent: THandle;
    hInstance: THandle;
    dwFlags: integer;   // TASKDIALOG_FLAGS dwFlags;
    dwCommonButtons: integer; //  TASKDIALOG_COMMON_BUTTON_FLAGS
    pszWindowTitle: pwidechar;
    hMainIcon: integer;
    pszMainInstruction: pwidechar;
    pszContent: pwidechar;
    cButtons: integer;
    pbuttons: pinteger;  // const TASKDIALOG_BUTTON* pButtons;
    nDefaultButton: integer;
    cRadioButtons: integer;
    pRadioButtons: pinteger; //const TASKDIALOG_BUTTON* pRadioButtons;
    nDefaultRadioButton: integer;
    pszVerificationText: pwidechar;
    pszExpandedInformation: pwidechar;
    pszExpandedControlText: pwidechar;
    pszCollapsedControlText: pwidechar;
    case Integer of
    0: (hFooterIcon: HICON);
    1: (pszFooterIcon: pwidechar;
        pszFooter: pwidechar;
        pfCallback: pinteger;
        pData: pointer;
        cxWidth: integer  // width of the Task Dialog's client area in DLU's.
                               // If 0, Task Dialog will calculate the ideal width.
              );
{
    hFooterIcon: integer;
    pszFooter: pwidechar;
    pfCallBack: pinteger; // PFTASKDIALOGCALLBACK pfCallback;
    pData: pointer;
    cxWidth: integer;
}
  end;

//------------------------------------------------------------------------------

procedure RunElevated(HWND: THandle; pszPath, pszParameters, pszDirectory: string);
var
  shex :  SHELLEXECUTEINFO;
begin
  fillchar(shex, sizeof(shex),0);
  shex.cbSize := sizeof( SHELLEXECUTEINFO );
  shex.fMask := 0;
  shex.wnd := hwnd;
  shex.lpVerb := 'runas';
  shex.lpFile := pchar(pszPath);
  shex.lpParameters := pchar(pszParameters);
  shex.lpDirectory := nil;
  shex.nShow := SW_NORMAL;
  ShellExecuteEx(@shex);
end;

//------------------------------------------------------------------------------

function IsVista: boolean;
var
  hKernel32: HMODULE;
begin
  hKernel32 := GetModuleHandle('kernel32');
  if (hKernel32 > 0) then
  begin
    Result := GetProcAddress(hKernel32, 'GetLocaleInfoEx') <> nil;
  end
  else
    Result := false;
end;

//------------------------------------------------------------------------------

procedure VistaShellOpen(HWND: THandle; Command, Param: WideString);
begin
  // if we only have a param we are executing a link
  if Command <> '' then
begin
  if IsVista then
    RunElevated(HWND, Command, Param, '')
  else
      Tnt_ShellExecuteW(HWND, 'open', PWidechar(Param), nil, nil, SW_NORMAL);
  end
  else
  begin
    // open link with user's default browser
    Tnt_ShellExecuteW(hWnd, 'open', PWideChar(Param), nil, nil, SW_NORMAL)
  end;
end;

//------------------------------------------------------------------------------

function GetFileVersion(const AFileName: WideString): Cardinal;
var
  FileName: WideString;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := Cardinal(-1);
  // GetFileVersionInfo modifies the filename parameter data while parsing.
  // Copy the string const into a local variable to create a writeable copy.
  FileName := AFileName;
  UniqueString(FileName);
  InfoSize := Tnt_GetFileVersionInfoSizeW(PWideChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if Tnt_GetFileVersionInfoW(PWideChar(FileName), Wnd, InfoSize, VerBuf) then
        if Tnt_VerQueryValueW(VerBuf, '\', Pointer(FI), VerSize) then
          Result:= FI.dwFileVersionMS;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;


function TaskDialogCallbackProc(hWnd: THandle; msg, wParam, lparam: integer; refData: pointer): integer; stdcall;
var
  td: TTntTaskdialog;
  SPos: integer;
  State: TTaskDialogProgressState;
  Res: integer;
  CanClose: boolean;
  Anchor: WideString;
  
begin
  td := nil;
  if Assigned(refdata) then
    td := TTntTaskdialog(refdata);

  Res := 0;

  if Assigned(td) then
    td.hWnd := hWnd;

  case msg of
  TDN_CREATED:
    begin
      if Assigned(td) and Assigned(td.OnDialogCreated) then
      begin
        td.OnDialogCreated(td);

        if (doProgressBar in td.Options) then
        begin
          SendMessage(hWnd, TDM_SET_PROGRESS_BAR_RANGE, 0, MakeLParam(td.ProgressBarMin,td.ProgressBarMax));
        end;
      end;
    end;
  TDN_BUTTON_CLICKED:
    begin
      if Assigned(td) and Assigned(td.OnDialogButtonClick) then
      begin
        td.OnDialogButtonClick(td, wParam);
      end;

      if Assigned(td) and Assigned(td.OnDialogClose) then
      begin
        CanClose := true;
        td.OnDialogClose(td, CanClose);
        if not CanClose then
          Res := 1;
      end;
    end;
  TDN_RADIO_BUTTON_CLICKED:
    begin
      if Assigned(td) and Assigned(td.OnDialogRadioClick) then
      begin
        td.OnDialogRadioClick(td, wParam);
      end;
    end;
  TDN_HYPERLINK_CLICKED:
    begin
      if Assigned(td) then
      begin
        Anchor := WideCharToString(PWideChar(lparam));

        if not Assigned(td.OnDialogHyperlinkClick) then
        begin
          if (HTMLPos('://', Anchor) > 0) then
            VistaShellOpen(0, '', Anchor);
        end;

        if Assigned(td.OnDialogHyperlinkClick) then
        begin
          td.OnDialogHyperlinkClick(td, PWideChar(lparam));
        end;
      end;
    end;
  TDN_VERIFICATION_CLICKED:
    begin
      if Assigned(td) and Assigned(td.OnDialogVerifyClick) then
      begin
        td.OnDialogVerifyClick(td, bool(wparam));
      end;
    end;
  TDN_TIMER:
    begin
      if Assigned(td) and Assigned(td.OnDialogTimer) then
      begin
        td.OnDialogTimer(td);
      end;

      if Assigned(td) and Assigned(td.OnDialogProgress) then
      begin
        td.OnDialogProgress(td, SPos, State);
        SendMessage(hWnd,TDM_SET_PROGRESS_BAR_POS,SPos,0);
        case State of
        psNormal: SendMessage(hWnd,TDM_SET_PROGRESS_BAR_STATE, PBST_NORMAL, 0);
        psError: SendMessage(hWnd,TDM_SET_PROGRESS_BAR_STATE, PBST_ERROR, 0);
        psPaused: SendMessage(hWnd,TDM_SET_PROGRESS_BAR_STATE, PBST_PAUSED, 0);
        end;
      end;
    end;
  end;

  Result := Res;
end;

//------------------------------------------------------------------------------

function RemoveSpaces(S: WideString): WideString;
var
  i: Integer;
begin
  Result := S;
  for i := 1 to Length(s) do
  begin
    if (s[i] = ' ') then
      Result := copy(S, 2, Length(S)-1)
    else
      Break;
  end;

  for i := Length(s) downto 1 do
  begin
    if (s[i] = ' ') then
      Result := copy(S, 1, Length(S)-1)
    else
      Break;
  end;
end;

//------------------------------------------------------------------------------

procedure SplitInToLines(Text: WideString; sl: TTntStringList);
var
  i, j: Integer;
  s, rs: WideString;
begin
  if (Text <> '') and Assigned(sl) then
  begin
    rs := #13;
    if (HTMLPos('\n', Text) > 0) or (HTMLPos(rs, Text) > 0) then
    begin
      Text := RemoveSpaces(Text);
      while (Length(Text) > 0) do
      begin
        i := HTMLPos('\n', Text);
        j := 2;
        if (i <= 0) then
        begin
          i := HTMLPos(rs, Text);
          j := 2;
        end;

        if (i <= 0) then
        begin
          i := Length(Text)+1;
          j := 0;
        end;  
        s := copy(Text, 1, i-1);
        Delete(Text, 1, i-1+j);
        s := RemoveSpaces(s);
        sl.Add(s);
        Text := RemoveSpaces(Text);
      end;
    end
    else
      sl.Add(Text);
  end;
end;

//------------------------------------------------------------------------------

procedure GetMultiLineTextSize(Canvas: TCanvas; Text: widestring; HeadingFont, ParaFont: TFont; DrawTextBiDiModeFlagsReadingOnly: Longint; var W, H: Integer; WithSpace: Boolean = True);
var
  R: TRect;
  i, tw, th: Integer;
  s: widestring;
  OldFont: TFont;
  SL: TTntStringList;
begin
  if Assigned(Canvas) then
  begin
    OldFont := TFont.Create;
    OldFont.Assign(Canvas.Font);
    if (HTMLPos('\n', Text) > 0) or (HTMLPos(#13, Text) > 0) then
    begin
      tw := 0;
      th := 0;

      SL := TTntStringList.Create;
      SplitInToLines(Text, SL);
      s := RemoveSpaces(SL[0]);

      if (s <> '') then
      begin
        Canvas.Font.Assign(HeadingFont);
        SetRect(R, 0, 0, 0, 0);
        Tnt_DrawTextW( Canvas.handle, PWideChar(s), -1, R,
          DT_CALCRECT or DT_LEFT or DT_SINGLELINE or DrawTextBiDiModeFlagsReadingOnly);
        tw := R.Right;
        th := R.Bottom;
        if WithSpace then
        begin
          tw := tw + 8;
          th := th + 10;
        end;
      end;

      Canvas.Font.Assign(ParaFont);
      for i:= 1 to SL.Count-1 do
      begin
        s := SL[i];
        if (s <> '') then
        begin
          SetRect(R, 0, 0, 0, 0);
          Tnt_DrawTextW( Canvas.handle, PWideChar(s), -1, R,
            DT_CALCRECT or DT_LEFT or DT_SINGLELINE or DrawTextBiDiModeFlagsReadingOnly);
          if WithSpace then
          begin
            tw := Max(tw, R.Right + 8);
            th := th + R.Bottom + 2;
          end
          else
          begin
            tw := Max(tw, R.Right);
            th := th + R.Bottom;
          end;
        end;
      end;

      W := tw;
      H := th;
      SL.Free;
    end
    else
    begin
      Canvas.Font.Assign(HeadingFont);
      SetRect(R, 0, 0, 0, 0);
      Tnt_DrawTextW( Canvas.handle, PWideChar(Text), -1, R,
        DT_CALCRECT or DT_LEFT or DT_SINGLELINE or DrawTextBiDiModeFlagsReadingOnly);
      W := R.Right;
      H := R.Bottom;
    end;

    Canvas.Font.Assign(OldFont);
    OldFont.Free;
  end;
end;

//------------------------------------------------------------------------------

{ TTntTaskdialog }

procedure TTntTaskDialog.Clear;
begin
  CommonButtons := [];
  RadioButtons.Clear;
  CustomButtons.Clear;
  Icon := tiBlank;
  FooterIcon := tfiBlank;
  Instruction := '';
  Title := '';
  Content := '';
  Footer := '';
  VerificationText := '';
  ExpandControlText := '';
  CollapsControlText := '';
  ExpandedText := '';
  DefaultRadioButton := 200;
  DefaultButton := 0;
  Options := [];
  VerifyResult := false;
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.ClickButton(ButtonID: integer);
begin
  SendMessage(hWnd, TDM_CLICK_BUTTON, ButtonID, 0);
  if Assigned(FDialogForm) then
    FDialogForm.ClickButton(ButtonID);
end;

//------------------------------------------------------------------------------

constructor TTntTaskDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCustomButtons := TTntStringList.Create;
  FRadioButtons := TtntStringList.Create;
  FProgressBarMin := 0;
  FProgressBarMax := 100;
  FDialogForm := nil;
  FApplicationIsParent := true;  
  FFont := TFont.Create;
  FModalParent := 0;
  FCustomIcon := TIcon.Create;
  FDefaultRadioButton := 200; 
end;

//------------------------------------------------------------------------------

destructor TTntTaskDialog.Destroy;
begin
  FRadioButtons.Free;
  FCustomButtons.Free;
  FCustomIcon.Free;  
  FFont.Free;
  inherited;
end;

//------------------------------------------------------------------------------

function TTntTaskDialog.CreateButton(AOwner: TComponent): TWinControl;
begin
  Result := TTntButton.Create(AOwner);
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.EnableButton(ButtonID: integer; Enabled: boolean);
begin
  SendMessage(hWnd, TDM_ENABLE_BUTTON, ButtonID, integer(Enabled));
  if Assigned(FDialogForm) then
    FDialogForm.EnableButton(ButtonID, Enabled);
end;

//------------------------------------------------------------------------------

function ConvertNL(const s: WideString): WideString;
begin
  if HTMLPos('\n',s) > 0 then
    Result := Tnt_WideStringReplace(s,'\n',#10,[rfReplaceAll])
  else
    Result := s;
end;

//------------------------------------------------------------------------------

function TTntTaskDialog.Execute: integer;
var
  verinfo: TOSVersionInfo;
  DLLHandle: THandle;
  res,radiores: integer;
  verify: boolean;
  TaskDialogConfig : TTASKDIALOGCONFIG;
  TaskDialogIndirectProc : function(AConfig: PTASKDIALOGCONFIG; Res: pinteger;  ResRadio: pinteger; VerifyFLag: pboolean): integer cdecl stdcall;

  {wTitle: TTaskDialogWideString;
  wDesc: TTaskDialogWideString;
  wContent: TTaskDialogWideString;
  wExpanded: TTaskDialogWideString;
  wExpandedControl: TTaskDialogWideString;
  wCollapsedControl: TTaskDialogWideString;
  wFooter: TTaskDialogWideString;
  wVerifyText: TTaskDialogWideString;}

  TBA: TTaskDialogButtonArray;
  TBWS: TTaskDialogWideStringArray;
  i: integer;

  TRA: TTaskDialogButtonArray;
  TRWS: TTaskDialogWideStringArray;
  ComCtlVersion: integer;
  s: array of widestring;

begin
  Result := -1;

  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(verinfo);

  ComCtlVersion := GetFileVersion('COMCTL32.DLL');
  ComCtlVersion := (ComCtlVersion shr 16) and $FF;

  if (verinfo.dwMajorVersion >= 6) and (ComCtlVersion > 5) then
  begin
    // check COMCTL version ...

    DLLHandle := LoadLibrary('comctl32.dll');
    if DLLHandle >= 32 then
    begin
      @TaskDialogIndirectProc := GetProcAddress(DLLHandle,'TaskDialogIndirect');

      if Assigned(TaskDialogIndirectProc) then
      begin
        FillChar(TaskDialogConfig, sizeof(TTASKDIALOGCONFIG),0);
        TaskDialogConfig.cbSize := sizeof(TTASKDIALOGCONFIG);

        if ModalParent <> 0 then
        begin
          TaskDialogConfig.hwndParent := ModalParent
        end
        else
        begin
          if Assigned(Self.Owner) and not ApplicationIsParent then
            TaskDialogConfig.hwndParent := (Self.Owner as TWinControl).Handle
          else
             TaskDialogConfig.hwndParent := Application.Handle;
        end;

        if FCustomButtons.Count > 0 then
        begin
          SetLength(TBA, FCustomButtons.Count);
          SetLength(TBWS, FCustomButtons.Count);
          SetLength(s, FCustomButtons.Count);
          for i := 0 to FCustomButtons.Count - 1 do
          begin
            s[i] := ConvertNL(FCustomButtons.Strings[i]) + #0#0;
            TBA[i].pszButtonText := PWideChar(s[i]);
            TBA[i].nButtonID := i + 100;
          end;

          TaskDialogConfig.cButtons := FCustomButtons.Count;
          TaskDialogConfig.pbuttons := @TBA[0];
        end;

        if FRadioButtons.Count > 0 then
        begin
          SetLength(TRA, FRadioButtons.Count);
          SetLength(TRWS, FRadioButtons.Count);
          SetLength(s, FRadioButtons.Count);

          for i := 0 to FRadioButtons.Count - 1 do
          begin
            s[i] := ConvertNL(FRadioButtons.Strings[i]) + #0#0;
            TRA[i].pszButtonText := PWideChar(s[i]);
            TRA[i].nButtonID := i + 200;
          end;

          TaskDialogConfig.cRadioButtons := FRadioButtons.Count;
          TaskDialogConfig.pRadioButtons := @TRA[0];
        end;

        if FTitle <> '' then
        begin
          TaskDialogConfig.pszWindowTitle := PWideChar(ConvertNL(FTitle));
        end;

        if FInstruction <> '' then
        begin
          TaskDialogConfig.pszMainInstruction := PWideChar(ConvertNL(FInstruction));
        end;

        if FContent <> '' then
        begin
          TaskDialogConfig.pszContent := PWideChar(ConvertNL(FContent));
        end;

        if FFooter <> '' then
        begin
          TaskDialogConfig.pszFooter := PWideChar(ConvertNL(FFooter));
        end;

        if FExpandControlText <> '' then
        begin
          TaskDialogConfig.pszExpandedControlText := PWideChar(FExpandControlText);
        end;

        if FCollapsControlText <> '' then
        begin
          TaskDialogConfig.pszCollapsedControlText := PWideChar(FCollapsControlText);
        end;

        if FExpandedText <> '' then
        begin
          TaskDialogConfig.pszExpandedInformation := PWideChar(FExpandedText);
        end;

        if FVerifyText <> '' then
        begin
          TaskDialogConfig.pszVerificationText := PWideChar(FVerifyText);
        end;

        if cbOk in FCommonButtons then
          TaskDialogConfig.dwCommonButtons := TaskDialogConfig.dwCommonButtons or TDCBF_OK_BUTTON;

        if cbYes in FCommonButtons then
          TaskDialogConfig.dwCommonButtons := TaskDialogConfig.dwCommonButtons or TDCBF_YES_BUTTON;

        if cbNo in FCommonButtons then
          TaskDialogConfig.dwCommonButtons := TaskDialogConfig.dwCommonButtons or TDCBF_NO_BUTTON;

        if cbCancel in FCommonButtons then
          TaskDialogConfig.dwCommonButtons := TaskDialogConfig.dwCommonButtons or TDCBF_CANCEL_BUTTON;

        if cbClose in FCommonButtons then
          TaskDialogConfig.dwCommonButtons := TaskDialogConfig.dwCommonButtons or TDCBF_CLOSE_BUTTON;

        if cbRetry in FCommonButtons then
          TaskDialogConfig.dwCommonButtons := TaskDialogConfig.dwCommonButtons or TDCBF_RETRY_BUTTON;

        if doCommandLinks in FOptions then
          TaskDialogConfig.dwFlags := TDF_USE_COMMAND_LINKS;

        if doCommandLinksNoIcon in FOptions then
          TaskDialogConfig.dwFlags := TDF_USE_COMMAND_LINKS_NO_ICON;

        if doHyperlinks in FOptions then
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_ENABLE_HYPERLINKS;

        if doExpandedDefault in FOptions then
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_EXPANDED_BY_DEFAULT;

        if doExpandedFooter in FOptions then
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_EXPAND_FOOTER_AREA;

        if doAllowMinimize in FOptions then
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_CAN_BE_MINIMIZED;

        if doVerifyChecked in FOptions then
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_VERIFICATION_FLAG_CHECKED;

        if doProgressBar in FOptions then
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_SHOW_PROGRESS_BAR;

        if doProgressBarMarquee in FOptions then
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_SHOW_MARQUEE_PROGRESS_BAR;

        if (doProgressBarMarquee in FOptions) or
           (doProgressBar in FOptions) or
           (doTimer in FOptions) then
           TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_CALLBACK_TIMER;

        if (DialogPosition = dpOwnerFormCenter) then
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_POSITION_RELATIVE_TO_WINDOW;

        if doNoDefaultRadioButton in FOptions then
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_NO_DEFAULT_RADIO_BUTTON;

        if doAllowDialogCancel in FOptions then
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_ALLOW_DIALOG_CANCELLATION;

        TaskDialogConfig.hInstance := 0;

        if not CustomIcon.Empty then
        begin
          TaskDialogConfig.hMainIcon := CustomIcon.Handle;
          TaskDialogConfig.dwFlags := TaskDialogConfig.dwFlags or TDF_USE_HICON_MAIN;
        end
        else
        begin
          case Icon of
            tiWarning: TaskDialogConfig.hMainIcon := TD_ICON_WARNING;
            tiQuestion: TaskDialogConfig.hMainIcon := TD_ICON_QUESTION;
            tiError: TaskDialogConfig.hMainIcon := TD_ICON_ERROR;
            tiShield: TaskDialogConfig.hMainIcon := TD_ICON_SHIELD;
            tiBlank: TaskDialogConfig.hMainIcon := TD_ICON_BLANK;
            tiInformation: TaskDialogConfig.hMainIcon := TD_ICON_INFORMATION;
          end;
        end;  

        case FooterIcon of
          tfiWarning: TaskDialogConfig.hFooterIcon := TD_ICON_WARNING;
          tfiQuestion: TaskDialogConfig.hFooterIcon := TD_ICON_QUESTION;
          tfiError: TaskDialogConfig.hFooterIcon := TD_ICON_ERROR;
          tfiInformation: TaskDialogConfig.hFooterIcon := THandle(MAKEINTRESOURCEW(Word(-3)));
          tfiShield: TaskDialogConfig.hFooterIcon := THandle(MAKEINTRESOURCEW(Word(-4)));
        end;

        TaskDialogConfig.pfCallBack := Pointer(@TaskDialogCallbackProc); // Pointer added
        TaskDialogConfig.pData := Self;

        TaskDialogConfig.nDefaultButton := DefaultButton;
        TaskDialogConfig.nDefaultRadioButton := DefaultRadioButton;


        TaskDialogIndirectProc(@TaskDialogConfig, @res, @radiores, @verify);

        RadioButtonResult := radiores;
        VerifyResult := verify;
        Result := res;

      end;
    end;
  end
  else
    Result := AdvMessageDlgPos(Self, -1, -1);
end;

//------------------------------------------------------------------------------

function TTntTaskDialog.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn))) + '.' + IntToStr(Lo(Hiword(vn))) + '.' +
    IntToStr(Hi(Loword(vn))) + '.' + IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

function TTntTaskDialog.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER, REL_VER), MakeWord(MIN_VER, MAJ_VER));
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetContent(const Value: WideString);
begin
  if (FContent <> Value) then
  begin
    FContent := Value;
    SendMessage(hWnd, TDM_UPDATE_ELEMENT_TEXT, TDE_CONTENT, Integer(PWideChar(FContent)));
    if Assigned(FDialogForm) then
      FDialogForm.UpdateDialog;
  end;
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetCustomButtons(const Value: TTntStringList);
begin
  FCustomButtons.Assign(Value);
end;

procedure TTntTaskDialog.SetCustomIcon(const Value: TIcon);
begin
  FCustomIcon.Assign(Value);
end;
//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetExpandedText(const Value: WideString);
begin
  if (FExpandedText <> Value) then
  begin
    FExpandedText := Value;
    SendMessage(hWnd, TDM_UPDATE_ELEMENT_TEXT, TDE_EXPANDED_INFORMATION, Integer(PWideChar(FExpandedText)));
    if Assigned(FDialogForm) then
      FDialogForm.UpdateDialog;
  end;
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetFooter(const Value: WideString);
begin
  if (FFooter <> Value) then
  begin
    FFooter := Value;
    SendMessage(hWnd, TDM_UPDATE_ELEMENT_TEXT, TDE_FOOTER, Integer(PWideChar(FFooter)));
    if Assigned(FDialogForm) then
      FDialogForm.UpdateDialog;
  end;
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetInstruction(const Value: WideString);
begin
  if (FInstruction <> Value) then
  begin
    FInstruction := Value;
    SendMessage(hWnd, TDM_UPDATE_ELEMENT_TEXT, TDE_MAIN_INSTRUCTION, Integer(PWideChar(FInstruction)));
    if Assigned(FDialogForm) then
      FDialogForm.UpdateDialog;
  end;
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetRadioButtons(const Value: TTntStringList);
begin
  FRadioButtons.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetVersion(const Value: string);
begin

end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetButtonCancel(aButton: TWinControl; Value: Boolean);
begin
  if not Assigned(aButton) or not (aButton is TTntButton) then
    Exit;

  TTntButton(aButton).Cancel := Value;
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetButtonDefault(aButton: TWinControl; Value: Boolean);
begin
  if not Assigned(aButton) or not (aButton is TTntButton) then
    Exit;

  TTntButton(aButton).Default := Value;
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetButtonModalResult(aButton: TWinControl; Value: Integer);
begin
  if not Assigned(aButton) or not (aButton is TTntButton) then
    Exit;

  TTntButton(aButton).ModalResult := Value;
end;

//------------------------------------------------------------------------------

function TTntTaskDialog.GetButtonModalResult(
  aButton: TWinControl): Integer;
begin
  Result := mrNone;
  if not Assigned(aButton) or not (aButton is TTntButton) then
    Exit;

  Result := TTntButton(aButton).ModalResult;
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetButtonCaption(aButton: TWinControl;
  Value: TWideCaption);
begin
  if not Assigned(aButton) or not (aButton is TTntButton) then
    Exit;

  TTntButton(aButton).Caption := Value;
end;

//------------------------------------------------------------------------------

procedure TTntTaskDialog.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

//------------------------------------------------------------------------------

{ TTaskDialogButton }

constructor TTaskDialogButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := OnPictureChanged;

  FGlyphHot := TBitmap.Create;

  FGlyphDown := TBitmap.Create;

  FGlyphDisabled := TBitmap.Create;
  FGlyphDisabled.OnChange := OnPictureChanged;

  FHeadingFont := TFont.Create;

  SetBounds(0, 0, 23, 22);
  ShowHint := False;
  FBorderColorDown := clNone;
  FBorderColorHot := clNone;
  FBorderColor := clNone;
end;

//------------------------------------------------------------------------------

destructor TTaskDialogButton.Destroy;
begin
  FGlyph.Free;
  FGlyphHot.Free;
  FGlyphDown.Free;
  FGlyphDisabled.Free;
  FHeadingFont.Free;
  inherited;
end;

procedure TTaskDialogButton.DoEnter;
begin
  inherited;
  Invalidate;
end;

procedure TTaskDialogButton.DoExit;
begin
  inherited;
  Invalidate;
end;

procedure TTaskDialogButton.KeyPress(var Key: char);
begin
  inherited;
  if (Key = #32) or (Key = #13) then
  begin
    Click;
  end;
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.Paint;
var
  Pic: TBitmap;
  x, y: Integer;
  bw, bh, i: Integer;
  R: TRect;
  TR: TRect;
  BrClr: TColor;
  SL: TTntStringList;
begin
  inherited;

  R := ClientRect;
  BrClr := clNone;
  if FMouseDown then
    BrClr := BorderColorDown
  else if FMouseInControl then
    BrClr := BorderColorHot;
  if not Enabled then
    BrClr := clNone;

  if GetFocus = Handle then
    BrClr := BorderColorDown;
  Pic := Picture;
  if FMouseDown and not FGlyphDown.Empty then
    Pic := FGlyphDown
  else if FMouseInControl and not FGlyphHot.Empty then
    Pic := FGlyphHot;

  if not Enabled and not PictureDisabled.Empty then
    Pic := PictureDisabled;

  if Assigned(Pic) and not Pic.Empty then
  begin
    Pic.Transparent := True;
    if (Caption = '') then
    begin
      x := (Width - Pic.Width) div 2;
      y := (Height - Pic.Height) div 2;
    end
    else
    begin
      x := 4;
      y := (Height - Pic.Height) div 2;
    end;

    Canvas.Draw(x, y, Pic);
    R.Left := x + Pic.Width + 3;
  end
  else
    R.Left := R.Left + 2;

  if (Caption <> '') then
  begin

    if (HTMLPos('\n', Caption) > 0) or (HTMLPos(#13, Caption) > 0) then
    begin
      TR := R;
      SL := TTntStringList.Create;
      SplitInToLines(Caption, SL);
      GetMultiLineTextSize(Canvas, Caption, HeadingFont, Self.Font, DrawTextBiDiModeFlagsReadingOnly, bw, bh);
      TR.Top := 2 + (Height - bh) div 2;

      Canvas.Brush.Style := bsClear;
      if (SL[0] <> '') then
      begin
        Canvas.Font.Assign(HeadingFont);
        Tnt_DrawTextW(Canvas.Handle, PWideChar(SL[0]),Length(SL[0]), TR, DT_LEFT or DT_TOP or DT_SINGLELINE);
        TR.Top := TR.Top + Canvas.TextHeight('gh') + 4;
      end;

      Canvas.Font.Assign(Self.Font);
      for i:= 1 to SL.count-1 do
      begin
        Tnt_DrawTextW(Canvas.Handle, PWideChar(SL[i]),Length(SL[i]), TR, DT_LEFT or DT_TOP or DT_SINGLELINE);
        TR.Top := TR.Top + Canvas.TextHeight('gh') + 2;
      end;
      SL.Free;
    end
    else

    begin
      Canvas.Brush.Style := bsClear;
      Canvas.Font.Assign(HeadingFont);
      Tnt_DrawTextW(Canvas.Handle,PWideChar(Caption),Length(Caption), R, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
    end;
  end;

  if (BrClr <> clNone) then
  begin
    R := ClientRect;
    Canvas.Pen.Color := BrClr;
    Canvas.Brush.Style := bsClear;
    Canvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, 2, 2);
  end;
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  
  if (ssLeft in Shift) then
  begin
    FMouseDown := True;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  FMouseDown := False;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.SetGlyphDown(const Value: TBitmap);
begin
  FGlyphDown.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.SetGlyphHot(const Value: TBitmap);
begin
  FGlyphHot.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.SetGlyphDisabled(const Value: TBitmap);
begin
  FGlyphDisabled.Assign(Value);
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.OnPictureChanged(Sender: TObject);
begin
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseInControl := True;

  if AutoFocus then
    SetFocus;

  Invalidate; 
  if Assigned(FOnMouseEnter) then
     FOnMouseEnter(Self);
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseInControl := False;
  Invalidate;

  if Assigned(FOnMouseLeave) then
     FOnMouseLeave(Self);
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.SetHeadingFont(const Value: TFont);
begin
  FHeadingFont.Assign(Value);
end;

//------------------------------------------------------------------------------

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

//------------------------------------------------------------------------------

var
  ButtonWidths : array[TCommonButton] of integer;  // initialized to zero
  ButtonCaptions: array[TCommonButton] of Pointer; // = (
  //  @SMsgDlgOK, @SMsgDlgYes, @SMsgDlgNo, @SMsgDlgCancel, @SMsgDlgRetry, @SMsgDlgAbort);
  ButtonNames: array[TCommonButton] of string = ('OK', 'Yes', 'No', 'Cancel', 'Retry', 'Abort');
                                                //tiBlank, tiWarning, tiQuestion, tiError, tiInformation,tiNotUsed,tiShield
  IconIDs: array[TTaskDialogIcon] of PChar = (IDI_ASTERISK, IDI_EXCLAMATION, IDI_QUESTION, IDI_ERROR, IDI_INFORMATION, nil, IDI_HAND);
  FooterIconIDs: array[TTaskDialogFooterIcon] of PChar = (nil, IDI_EXCLAMATION, IDI_QUESTION, IDI_HAND, IDI_INFORMATION, IDI_WINLOGO);
  Captions: array[TTaskDialogIcon] of Pointer;
  // = (nil, @SMsgDlgWarning, @SMsgDlgConfirm, @SMsgDlgError, @SMsgDlgInformation);
  ModalResults: array[TCommonButton] of Integer = (mrOk, mrYes, mrNo, mrCancel, mrRetry, mrAbort);
  //(tiBlank, tiWarning, tiQuestion, tiError, tiShield);
  //(mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);

function CreateAdvMessageDlg(TaskDialog: TTntTaskdialog): TForm;
begin
  Result := nil;
  if not Assigned(TaskDialog) then
    Exit;

  if TaskDialog.ApplicationIsParent then
    Result := TAdvMessageForm.CreateNew(Application,0)
  else
    Result := TAdvMessageForm.CreateNew((TaskDialog.Owner) as TCustomForm,0);

  with Result do
  begin
    BiDiMode := Application.BiDiMode;
    if doAllowMinimize in TaskDialog.Options then
    begin
      BorderStyle := bsSingle;
      BorderIcons := [biSystemMenu,biMinimize]
    end
    else
    begin
      BorderStyle := bsDialog;
      BorderIcons := [];
    end;

    //FormStyle := fsStayOnTop;
    
    Font.Assign(TaskDialog.Font);
    Canvas.Font := Font;
    KeyPreview := True;
    OnKeyDown := TAdvMessageForm(Result).CustomKeyDown;
  end;
  TAdvMessageForm(Result).BuildTaskDialog(TaskDialog);
end;

//------------------------------------------------------------------------------

function AdvMessageDlgPos(TaskDialog: TTntTaskdialog; X, Y: Integer): Integer;
var
  DlgForm: TAdvMessageForm;
begin
  Result := -1;
  if not Assigned(TaskDialog) then
    Exit;

  DlgForm := TAdvMessageForm(CreateAdvMessageDlg(TaskDialog));
  TaskDialog.FDialogForm := DlgForm;
  if Assigned(TaskDialog.OnDialogCreated) then
    TaskDialog.OnDialogCreated(TaskDialog);
    
  with DlgForm do
    try
      Color := clWhite;
      //HelpContext := HelpCtx;
      //HelpFile := HelpFileName;
      if X >= 0 then Left := X;
      if Y >= 0 then Top := Y;
      if TaskDialog.DialogPosition = dpOwnerFormCenter then
      begin
        if (Y < 0) and (X < 0) then Position := poOwnerFormCenter;
      end
      else
      begin
        if (Y < 0) and (X < 0) then Position := poScreenCenter;
      end;
      Result := ShowModal;
    finally
      TaskDialog.FDialogForm := nil;
      Free;
    end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.GetTextSize(Canvas: TCanvas; Text: WideString;var W, H: Integer);
var
  R: TRect;
begin
  if (Text = '') then
  begin
    W := 0;
    H := 0;
    Exit;
  end;

  if Assigned(Canvas) then
  begin

    if W = 0 then
      SetRect(R, 0, 0, 1000, 100)
    else
      SetRect(R, 0, 0, W, 100);

    Tnt_DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text)+1, R,
      DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK or DT_NOPREFIX or
      DrawTextBiDiModeFlagsReadingOnly);

    W := R.Right;
    H := R.Bottom;
  end;
end;

//------------------------------------------------------------------------------

const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 14;
  mcButtonSpacing = 4;

procedure TAdvMessageForm.BuildTaskDialog(TaskDialog: TTntTaskdialog);
var
  DialogUnits: TPoint;
  ButtonWidth, ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X, Y, ALeft: Integer;
  B, DefaultButton, CancelButton: TCommonButton;
  IconID: PChar;
  TextRect, FR: TRect;
  Msg: WideString;
  DlgType: TTaskDialogIcon;
  Buttons: TCommonButtons;
  i, bw, bh, h, w, j, FooterIconTextWidth, FooterIconTextHeight: Integer;
  CmBtnGroupWidth, CsBtnGroupWidth: Integer;
  r, re: trect;
  anchor, stripped: WideString;
  HyperLinks,MouseLink, k, l, n: Integer;
  Focusanchor: WideString;
  OldFont, hf, pf: TFont;
  verifTextWidth: Integer;
  v: Boolean;
begin
  if not Assigned(TaskDialog) then
    Exit;

  FTaskDialog := TaskDialog;
  Msg := TaskDialog.Instruction;
  DlgType := TaskDialog.Icon;
  Buttons := TaskDialog.CommonButtons;

  OldFont := TFont.Create;
  OldFont.Assign(Canvas.Font);

  DialogUnits := GetAveCharSize(Canvas);
  FHorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
  FVertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
  FHorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
  FVertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);

  w := 0;

  Font.Assign(TaskDialog.Font);
  Caption := TaskDialog.Title;

  if (Caption <> '') then
  begin
    w := 1000;
    GetTextSize(Canvas, Caption, w, l);
    w := w + 50;
  end;

  ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);
  ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
  ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
  CmBtnGroupWidth := 0;
  CsBtnGroupWidth := 0;
  ButtonCount := 0;
  FHorzParaMargin := FHorzMargin;
  Y := FVertMargin;
  FcmBtnList.Clear;

  if TaskDialog.DefaultButton = 0 then
  begin
    if (cbOk in Buttons) then DefaultButton := cbOk else
      if cbYes in Buttons then DefaultButton := cbYes else
        DefaultButton := cbRetry;
    if cbCancel in Buttons then CancelButton := cbCancel else
      if cbNo in Buttons then CancelButton := cbNo else
        CancelButton := cbOk;
  end
  else
  begin
    case TaskDialog.DefaultButton of
    1: if (cbOk in Buttons) then DefaultButton := cbOK
       else
         DefaultButton := cbYes;
    2: if (cbCancel in Buttons) then DefaultButton := cbCancel
       else
         DefaultButton := cbNo;
    end;
  end;

  for B := Low(TCommonButton) to High(TCommonButton) do
  begin
    if B in Buttons then
    begin
      if ButtonWidths[B] = 0 then
      begin
        TextRect := Rect(0,0,0,0);
        Tnt_DrawTextW(Canvas.Handle,
          PWideChar(WideLoadResString(ButtonCaptions[B])), -1,
          TextRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE or
          DrawTextBiDiModeFlagsReadingOnly);
        with TextRect do
          ButtonWidths[B] := Right - Left + 16;
      end;

      if ButtonWidths[B] > ButtonWidth then
        ButtonWidth := ButtonWidths[B];

      i := FcmBtnList.Add(TaskDialog.CreateButton(Self));

      with TWinControl(FcmBtnList.Items[i]) do
      begin
        Name := ButtonNames[B];
        Parent := Self;
        TaskDialog.SetButtonCaption(TWinControl(FcmBtnList.Items[i]), WideLoadResString(ButtonCaptions[B]));
        TaskDialog.SetButtonModalResult(TWinControl(FcmBtnList.Items[i]), ModalResults[B]);
        //ModalResult := ModalResults[B];

        if (TaskDialog.GetButtonModalResult(TWinControl(FcmBtnList.Items[i])) = mrCancel) and
           (doAllowDialogCancel in TaskDialog.Options) then
          TaskDialog.SetButtonCancel(TWinControl(FcmBtnList.Items[i]), True);
          //Cancel := true;

        if (B = DefaultButton) then
        begin
          //Default := True;
          TaskDialog.SetButtonDefault(TWinControl(FcmBtnList.Items[i]), True);
          TabOrder := 0;
        end;

        if (B = CancelButton) and (doAllowDialogCancel in TaskDialog.Options) and
          (TaskDialog.GetButtonModalResult(TWinControl(FcmBtnList.Items[i])) = mrCancel) then
          TaskDialog.SetButtonCancel(TWinControl(FcmBtnList.Items[i]), True);

        Width := Max(60, ButtonWidths[B]);
        Height := ButtonHeight;
        cmBtnGroupWidth := cmBtnGroupWidth + Width + ButtonSpacing;


        //if B = mbHelp then
          //OnClick := TMessageForm(Result).HelpButtonClick;
      end;

      TTntButton(FcmBtnList.Items[i]).Font.Assign(TaskDialog.Font);

      //Inc(ButtonCount);
    end;
  end;

  FcsBtnList.Clear;
  if not (docommandLinks in TaskDialog.Options) then
  begin
    for i:= 0 to TaskDialog.CustomButtons.Count-1 do
    begin

      TextRect := Rect(0,0,0,0);
      Tnt_DrawTextW(Canvas.Handle,
        PWideChar(TaskDialog.CustomButtons[i]), -1,
        TextRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE or
        DrawTextBiDiModeFlagsReadingOnly);
      with TextRect do bw := Right - Left + 16;
      if bw > ButtonWidth then
        ButtonWidth := bw;

      j := FcsBtnList.Add(TaskDialog.CreateButton(Self));
      with TWinControl(FcsBtnList.Items[j]) do
      begin
        Name := 'Button'+inttostr(i);
        Parent := Self;
        TaskDialog.SetButtonCaption(TWinControl(FcsBtnList.Items[j]), TaskDialog.CustomButtons[i]);
        //ModalResult := i + 100; //mrAbort;
        TaskDialog.SetButtonModalResult(TWinControl(FcsBtnList.Items[j]), i + 100);
        v := (TaskDialog.GetButtonModalResult(TWinControl(FcsBtnList.Items[j])) = TaskDialog.DefaultButton);
        TaskDialog.SetButtonDefault(TWinControl(FcsBtnList.Items[j]), V);
        //Default := (ModalResult = TaskDialog.DefaultButton);
        //if V then
        //  TabOrder := 0;
        //if B = DefaultButton then Default := True;
        //if B = CancelButton then Cancel := True;
        Width := Max(60, bw);
        Height := ButtonHeight;
        TProControl(FcsBtnList.Items[j]).OnClick := OnButtonClick;
        CsBtnGroupWidth := CsBtnGroupWidth + Width + ButtonSpacing;
      end;

      TTntButton(FcsBtnList.Items[i]).Font.Assign(TaskDialog.Font);
    end;
  end
  else
  begin
    n := 0;
    hf := TFont.Create;
    pf := TFont.Create;
    hf.Assign(TaskDialog.Font);
    hf.Size := 11;
    hf.Style := [fsBold];

    pf.Assign(TaskDialog.Font);
    for i:= 0 to TaskDialog.CustomButtons.Count-1 do
    begin
      Canvas.Font.Size := 10;
      Canvas.Font.Style := [];
      bw := 0;
      bh := 0;
      GetMultiLineTextSize(Canvas, TaskDialog.CustomButtons[i], Hf, Pf, DrawTextBiDiModeFlagsReadingOnly, bw, bh);

      {TextRect := Rect(0,0,0,0);
      Windows.DrawText( Canvas.handle,
        PChar(TaskDialog.CustomButtons[i]), -1,
        TextRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE or
        DrawTextBiDiModeFlagsReadingOnly);
      with TextRect do bw := (Right - Left) + 8 + 18;}
      bw := bw + 26;
      if bw > ButtonWidth then
        ButtonWidth := bw;

      if bw > n then
        n := bw;

      if not (doCommandLinksNoIcon in TaskDialog.Options) then
        w := Max(w, n + FHorzMargin*2 + FHorzSpacing + 32)
      else
        w := Max(w, n + FHorzMargin);

      j := FcsBtnList.Add(TTaskDialogButton.Create(Self));

      with TTaskDialogButton(FcsBtnList.Items[j]) do
      begin
        Name := 'Button'+inttostr(i);
        Parent := Self;
        Caption := TaskDialog.CustomButtons[i];
        Font.Assign(TaskDialog.Font);
        Font.Color := RGB(0, 83, 196);
        HeadingFont.Assign(hf);
        HeadingFont.Color := RGB(0, 83, 196);//RGB(21, 28, 85);
        ModalResult := i + 100; //mrAbort;
        //Default := (ModalResult = TaskDialog.DefaultButton);
        BorderColorHot := RGB(108, 225, 255);
        BorderColorDown := RGB(108, 225, 255);
        Width := Max(60, n);
        AutoFocus := true;
        Height := Max(bh, Max(ButtonHeight, Canvas.TextHeight('gh') + 20));

        if not (doCommandLinksNoIcon in TaskDialog.Options) then
        begin
          Picture.LoadFromResourceName(HInstance, 'TD_TNTARW');
          Picture.TransparentColor:=clFuchsia;
          PictureHot.LoadFromResourceName(HInstance, 'TD_TNTARWHOT');
          PictureHot.TransparentColor:=clFuchsia;
          PictureDown.LoadFromResourceName(HInstance, 'TD_TNTARWDOWN');
          PictureDown.TransparentColor:=clFuchsia;
        end;

        TabStop := true;
        OnClick := OnButtonClick;
        //CsBtnGroupWidth := CsBtnGroupWidth + Width + ButtonSpacing;
      end;

    end;
    Canvas.Font.Assign(OldFont);
    hf.Free;
    pf.Free;
  end;

  // if no button then OK button is added
  if (FcmBtnList.Count = 0) and (FcsBtnList.Count = 0) then
  begin
    b := cbOK;
    TextRect := Rect(0,0,0,0);
    Tnt_DrawTextW(Canvas.handle,
      PWideChar(WideLoadResString(ButtonCaptions[B])), -1,
      TextRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE or
      DrawTextBiDiModeFlagsReadingOnly);
    with TextRect do ButtonWidths[B] := Right - Left + 8;

    //if ButtonWidths[B] > ButtonWidth then
      //ButtonWidth := ButtonWidths[B];

    i := FcmBtnList.Add(TaskDialog.CreateButton(Self));
    with TWinControl(FcmBtnList.Items[i]) do
    begin
      Name := ButtonNames[B];
      Parent := Self;
      TaskDialog.SetButtonCaption(TWinControl(FcmBtnList.Items[i]), WideLoadResString(ButtonCaptions[B]));
      TaskDialog.SetButtonModalResult(TWinControl(FcmBtnList.Items[i]), ModalResults[B]);
      //ModalResult := ModalResults[B];
      //Default := True;
      TaskDialog.SetButtonDefault(TWinControl(FcmBtnList.Items[i]), True);
      //Cancel := True; // handle ESC
      if doAllowDialogCancel in TaskDialog.Options then
        TaskDialog.SetButtonCancel(TWinControl(FcmBtnList.Items[i]), True);
      Width := Max(60, ButtonWidths[B]);
      Height := ButtonHeight;
      cmBtnGroupWidth := cmBtnGroupWidth + Width + ButtonSpacing;
      //if B = mbHelp then
        //OnClick := TMessageForm(Result).HelpButtonClick;
    end;
  end;

  // Instruction
  Canvas.Font.Size := 11;
  Canvas.Font.Style := [fsBold];

  SetRect(TextRect, 0, 0, Screen.Width div 2, 0);
  Tnt_DrawTextW(Canvas.Handle, PWideChar(Msg), Length(Msg) + 1, TextRect,
    DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK or
    DrawTextBiDiModeFlagsReadingOnly);

  Canvas.Font.Assign(OldFont);

  IconID := IconIDs[DlgType];

  IconTextWidth := TextRect.Right;
  IconTextHeight := TextRect.Bottom;
  if IconID <> nil then
  begin
    Inc(IconTextWidth, 32 + FHorzSpacing);
    if IconTextHeight < 32 then IconTextHeight := 32;
  end;

  {if DlgType <> tiBlank then
    Caption := LoadResString(Captions[DlgType]) else
    Caption := Application.Title;}

  if ((IconID <> nil) or not (TaskDialog.CustomIcon.Empty)) {and not (doCommandLinksNoIcon in TaskDialog.Options)} then
  begin
    FIcon := TImage.Create(Self);
    with FIcon do
    begin
      Name := 'Image';
      Parent := Self;

      if not TaskDialog.CustomIcon.Empty then
      begin
        Picture.Icon.Assign(TaskDialog.CustomIcon);
      end
      else
      begin

        case TaskDialog.Icon of
        tiShield: Picture.Bitmap.Handle := LoadBitmap(hInstance, 'TD_TNTSHIELD');
        tiBlank:
          begin
            Picture.Bitmap.Height := 32;
            Picture.Bitmap.Width := 32;
            Picture.Bitmap.Canvas.Brush.Color := clWhite;
            Picture.Bitmap.Canvas.Pen.Style := psClear;
            Picture.Bitmap.Canvas.Rectangle(0,0,31,31);
          end;
        else
          Picture.Icon.Handle := LoadIcon(0, IconID);
        end;
      end;  

      SetBounds(FHorzMargin, Y, 32, 32);
    end;
  end;

  Message := TTntLabel.Create(Self);
  with Message do
  begin
    Name := 'Instr';
    Parent := Self;
    {$IFDEF DELPHI_7_UP}
    WordWrap := True;
    {$ENDIF}
    Caption := Msg;
    Font.Assign(TaskDialog.Font);
    Font.Size := 11;
    Font.Color := RGB(0, 83, 196);
    Font.Style := [fsBold];
    BoundsRect := TextRect;
    BiDiMode := Self.BiDiMode;
    ShowAccelChar := false;
    ALeft := IconTextWidth - TextRect.Right + FHorzMargin;
    if UseRightToLeftAlignment then
      ALeft := Self.ClientWidth - ALeft - Width;
    SetBounds(ALeft, Y,
      TextRect.Right, TextRect.Bottom);
    y := Y + Height + FVertSpacing;
    FHorzParaMargin := ALeft;
  end;

  if (doTimer in TaskDialog.Options) then
  begin
    FTimer := TTimer.Create(Self);
    FTimer.Interval := 100;
    FTimer.OnTimer := OnTimer;
    FTimer.Enabled := True;
  end;

  if (doProgressBar in TaskDialog.Options) then
  begin
    FProgressBar := TProgressBar.Create(Self);
    with FProgressBar do
    begin
      Name := 'ProgressBar';
      Parent := Self;
      BoundsRect := Rect(FHorzMargin, Y, Width - FHorzMargin, Y + 12);
      Min := TaskDialog.ProgressBarMin;
      Max := TaskDialog.ProgressBarMax;
      Position := 0;
    end;

    if not Assigned(FTimer) then
    begin
      FTimer := TTimer.Create(Self);
      FTimer.Interval := 100;
      FTimer.OnTimer := OnTimer;
      FTimer.Enabled := True;
    end;
  end;


  if (TaskDialog.RadioButtons.Count > 0) then
  begin
    if (doNodefaultRadioButton in FTaskDialog.Options) then
      FTaskDialog.RadioButtonResult := 0
    else
      FTaskDialog.RadioButtonResult := FTaskDialog.DefaultRadioButton;
      
    for i := 0 to TaskDialog.RadioButtons.Count-1 do
    begin
      j := FRadioList.Add(TTntRadioButton.Create(Self));
      with TTntRadioButton(FRadioList.Items[j]) do
      begin
        Name := 'Radio'+inttostr(i);
        Parent := Self;
        Font.Name := Canvas.Font.Name;
        Font.Size := 8;
        {$IFDEF DELPHI_7_UP}
        WordWrap := False;
        {$ENDIF}
        BoundsRect := TextRect;
        BiDiMode := Self.BiDiMode;
        Caption := TaskDialog.RadioButtons[i];

        if doNoDefaultRadioButton in TaskDialog.Options then
          Checked := False
        else
        begin
          if (TaskDialog.DefaultRadioButton > 0) then
            Checked := (j + 200 = TaskDialog.DefaultRadioButton)
          else
          begin
            Checked := (i = 0);
          end;
        end;
        Left := FHorzParaMargin + FHorzMargin; //ALeft + FHorzMargin;
        Top := Y;
        Width := Self.Width - Left - 4;
        OnClick := OnRadioClick;
        GetTextSize(Canvas, Caption, k, l);
        w := Max(w, Left + k + FHorzMargin + 20);
      end;
    end;
  end;

  if (TaskDialog.ExpandedText <> '') then
  begin
    (*FExpandLabel := TLabel.Create(Self);
    with FExpandLabel do
    begin
      Name := 'Expand';
      Parent := Self;
      {$IFDEF DELPHI_7_UP}
      WordWrap := True;
      {$ENDIF}
      ShowAccelChar := false;
      BiDiMode := Self.BiDiMode;
      FExpandLabel.Caption := TaskDialog.ExpandedText;
      Left := ALeft;
      Top := Y;
    end; *)

    FExpTextXSize := 0;
    FExpTextYSize := 0;
    r := Rect(FHorzMargin, Y, 300, Y + 26);
    if (doHyperlinks in FTaskDialog.Options) then
    begin
      HTMLDrawEx(Canvas, TaskDialog.ExpandedText, r, nil, x, y, -1, -1, 1, true, false, false, true, true, false, true,
         1.0, clBlue, clNone, clNone, clGray, anchor, stripped, focusanchor, FExpTextXSize, FExpTextYSize, hyperlinks,
         mouselink, re, nil, nil);
    end
    else
    begin
      FExpTextXSize := r.Right - r.Left;
      GetTextSize(Canvas, FTaskDialog.ExpandedText, FExpTextXSize, FExpTextYSize);
    end;

    FExpandButton := TTaskDialogButton.Create(Self);
    with FExpandButton do
    begin
      Name := 'ExpandButton';
      Parent := Self;
      Caption := '';
      ModalResult := mrNone;
      Width := 19;
      Height := 19;
      OnClick := OnExpandButtonClick;
      Picture.LoadFromResourceName(HInstance, 'TD_TNTCOLP');
      Picture.TransparentColor:=clFuchsia;
      PictureHot.LoadFromResourceName(HInstance, 'TD_TNTCOLPHOT');
      PictureHot.TransparentColor:=clFuchsia;
      PictureDown.LoadFromResourceName(HInstance, 'TD_TNTCOLPDOWN');
      PictureDown.TransparentColor:=clFuchsia;
    end;
  end;

  verifTextWidth := 0;
  if (TaskDialog.VerificationText <> '') then
  begin
    k := 0;
    FVerificationCheck := TTntCheckBox.Create(Self);
    with FVerificationCheck do
    begin
      Name := 'Verification';
      Parent := Self;
      {$IFDEF DELPHI_7_UP}
      WordWrap := False;
      {$ENDIF}
      BoundsRect := TextRect;
      BiDiMode := Self.BiDiMode;
      Caption := TaskDialog.VerificationText;
      Left := FHorzMargin;
      Color := RGB(240, 240, 240);
      OnClick := OnVerifyClick;
      Checked := (doVerifyChecked in TaskDialog.Options);
      GetTextSize(Canvas, Caption, k, l);
      verifTextWidth := k + FVertSpacing * 2;
      w := Max(w, Left + k);
      Width := w;
    end;
  end;

  FFooterXSize := 0;
  FFooterYSize := 0;
  if (TaskDialog.Footer <> '') then
  begin
    r := Rect(FHorzMargin, Y, 300, Y + 26);
    HTMLDrawEx(Canvas, TaskDialog.Footer, r, nil, x, y, -1, -1, 1, true, false, false, true, true, false, true,
       1.0, clBlue, clNone, clNone, clGray, anchor, stripped, focusanchor, FFooterXSize, FFooterYSize, hyperlinks,
       mouselink, re, nil, nil);

    IconID := FooterIconIDs[TaskDialog.FooterIcon];
    FooterIconTextWidth := TextRect.Right;
    FooterIconTextHeight := TextRect.Bottom;
    if IconID <> nil then
    begin
      Inc(FooterIconTextWidth, 24 + FHorzSpacing);
      if FooterIconTextHeight < 24 then FooterIconTextHeight := 24;
    end;

    if IconID <> nil then
    begin
      FFooterIcon := TImage.Create(Self);
      FFooterIconID := IconID;

      with FFooterIcon do
      begin
        Name := 'FooterImage';
        Parent := Self;
        Visible := False;
        SetBounds(FHorzMargin, Y, 16, 16);
      end;
    end;
  end;

  ButtonGroupWidth := CmBtnGroupWidth + CsBtnGroupWidth + verifTextWidth;
  if (TaskDialog.ExpandedText <> '') and Assigned(FExpandButton) then
  begin
    k := 0;
    l := 0;
    GetTextSize(Canvas, FTaskDialog.CollapsControlText, k, l);
    GetTextSize(Canvas, FTaskDialog.ExpandControlText, n, l);
    k := Max(k, n);
    ButtonGroupWidth := ButtonGroupWidth + FExpandButton.Width + FHorzSpacing + k + FHorzSpacing;
  end;

  //-- setting Form Width
  k := Max(FFooterXSize, Max(IconTextWidth, ButtonGroupWidth)) + FHorzMargin * 2;
  k := Max(FExpTextXSize + FHorzMargin * 2, k);
  w := Max(w, k);
  w := Max(w, 350);


//  if w > 800 then
//    w := 800;

  ClientWidth := w;

  if (doProgressBar in TaskDialog.Options) then
  begin
    FProgressBar.Width := ClientWidth - FHorzMargin*2;
  end;

  SetPositions;

  if (TaskDialog.ExpandedText <> '') then
  begin
    SetExpanded((doExpandedDefault in TaskDialog.Options));
  end;

  Left := (Screen.Width div 2) - (Width div 2);
  Top := (Screen.Height div 2) - (Height div 2);
  OldFont.Free;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.UpdateDialog;
var
  DialogUnits: TPoint;
  ButtonSpacing, ButtonGroupWidth, IconTextWidth, X, Y: Integer;
  IconID: PChar;
  TextRect: TRect;
  Msg: WideString;
  DlgType: TTaskDialogIcon;
  Buttons: TCommonButtons;
  i, w: Integer;
  CmBtnGroupWidth, CsBtnGroupWidth: Integer;
  r, re: trect;
  anchor, stripped: WideString;
  HyperLinks,MouseLink, k, l, n: Integer;
  Focusanchor: WideString;
  OldFont: TFont;
begin
  if not Assigned(FTaskDialog) then
    Exit;

  Msg := FTaskDialog.Instruction;
  DlgType := FTaskDialog.Icon;
  Buttons := FTaskDialog.CommonButtons;

  OldFont := TFont.Create;
  OldFont.Assign(Canvas.Font);

  DialogUnits := GetAveCharSize(Canvas);
  w := 0;

  Caption := FTaskDialog.Title;

  if (Caption <> '') then
  begin
    w := 1000;
    GetTextSize(Canvas, Caption, w, l);
    w := w + 50;
  end;

  ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
  CmBtnGroupWidth := 0;
  CsBtnGroupWidth := 0;
  Y := FVertMargin;
  //ALeft := 0;

  for i := 0 to FcmBtnList.Count-1 do
  begin
    CmBtnGroupWidth := CmBtnGroupWidth + TTntButton(FcmBtnList.Items[i]).Width + ButtonSpacing;
  end;

  if not (docommandLinks in FTaskDialog.Options) then
  begin
    for i := 0 to FcsBtnList.Count-1 do
    begin
      CsBtnGroupWidth := CsBtnGroupWidth + TTntButton(FcsBtnList.Items[i]).Width + ButtonSpacing;
    end;
  end
  else
  begin
  
  end;

  // Instruction
  Canvas.Font.Size := 11;
  Canvas.Font.Style := [fsBold];

  SetRect(TextRect, 0, 0, Screen.Width div 2, 0);
  Tnt_DrawTextW(Canvas.Handle, PWideChar(Msg), Length(Msg) + 1, TextRect,
    DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK or
    DrawTextBiDiModeFlagsReadingOnly);

  Canvas.Font.Assign(OldFont);


  IconID := IconIDs[DlgType];
  IconTextWidth := TextRect.Right;
  if (IconId <> nil) then
  begin
    Inc(IconTextWidth, 32 + FHorzSpacing);
  end;

  if Assigned(Message) then
  begin
    Message.Caption := Msg;
    //ALeft := IconTextWidth - TextRect.Right + FHorzMargin;
    //if UseRightToLeftAlignment then
      //ALeft := Self.ClientWidth - ALeft - Width;
    y := Y + Height + FVertSpacing;
  end;

  if (FTaskDialog.RadioButtons.Count > 0) then
  begin
    FTaskDialog.RadioButtonResult := FTaskDialog.DefaultRadioButton;

    for i := 0 to FRadioList.Count-1 do
    begin
      with TTntRadioButton(FRadioList.Items[i]) do
      begin
        BoundsRect := TextRect;
        Left := FHorzParaMargin + FHorzMargin;
        Top := Y;
        Width := Self.Width - Left - 4;
        GetTextSize(Canvas, Caption, k, l);
        w := Max(w, Left + k + FHorzMargin + 20);
      end;
    end;
  end;

  {if (FTaskDialog.ExpandedText <> '') and Assigned(FExpandLabel) then
  begin
    with FExpandLabel do
    begin
      Left := ALeft;
      Top := Y;
      FExpandLabel.Caption := FTaskDialog.ExpandedText;
    end;
  end; }

  if (FTaskDialog.VerificationText <> '') and Assigned(FVerificationCheck) then
  begin
    k := 0;
    with FVerificationCheck do
    begin
      BoundsRect := TextRect;
      Caption := FTaskDialog.VerificationText;
      Left := FHorzMargin;
      Top := Y;
      GetTextSize(Canvas, Caption, k, l);
      w := Max(w, Left + k);
    end;
  end;

  FFooterXSize := 0;
  FFooterYSize := 0;
  if (FTaskDialog.Footer <> '') then
  begin
    r := Rect(FHorzMargin, Y, 300, Y + 26);
    x := 0;
    HTMLDrawEx(Canvas, FTaskDialog.Footer, r, nil, x, y, -1, -1, 1, true, false, false, true, true, false, true,
       1.0, clBlue, clNone, clNone, clGray, anchor, stripped, focusanchor, FFooterXSize, FFooterYSize, hyperlinks,
       mouselink, re, nil, nil);

    if Assigned(FFooterIcon) then
    begin
      FFooterIcon.SetBounds(FHorzMargin, Y, 16, 16);
    end;
  end;

  ButtonGroupWidth := CmBtnGroupWidth + CsBtnGroupWidth;
  if (FTaskDialog.ExpandedText <> '') and Assigned(FExpandButton) then
  begin
    k := 0;
    l := 0;
    GetTextSize(Canvas, FTaskDialog.CollapsControlText, k, l);
    GetTextSize(Canvas, FTaskDialog.ExpandControlText, n, l);
    k := Max(k, n);
    ButtonGroupWidth := ButtonGroupWidth + FExpandButton.Width + FHorzSpacing + k + FHorzSpacing;
  end;

  //-- setting Form Width
  k := Max(FFooterXSize, Max(IconTextWidth, ButtonGroupWidth)) + FHorzMargin * 2;
  w := Max(w, k);
  w := Max(w, 350);


  ClientWidth := w;

  if (doProgressBar in FTaskDialog.Options) and Assigned(FProgressBar) then
  begin
    FProgressBar.Width := ClientWidth - FHorzMargin*2;
  end;

  SetPositions;

  OldFont.Free;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.SetPositions;
var
  DialogUnits: TPoint;
  HorzMargin, VertMargin, VertSpacing, ButtonSpacing, ButtonGroupWidth, X, Y: Integer;
  i, h: Integer;
  CmBtnGroupWidth, CsBtnGroupWidth, BtnH: Integer;
  X1, y1: Integer;
  r, re: trect;
  anchor, stripped: WideString;
  HyperLinks,MouseLink: Integer;
  Focusanchor: WideString;
  ExpTextTop: Integer;
  verifTextWidth, k,l: Integer;
  //lbl:TLabel;
  //ExH: integer;
begin
  if not Assigned(FTaskDialog) then
    Exit;

  DialogUnits := GetAveCharSize(Canvas);
  HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
  VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
  VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
  ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
  CmBtnGroupWidth := 0;
  CsBtnGroupWidth := 0;
  Y := VertMargin;

  // Instruction Label
  if (Message.Caption <> '') then
    y := Y + Message.Height + VertSpacing
  else
    Message.Visible := False;

  if (FTaskDialog.Content <> '') then
  begin
    //FContent.Width := ClientWidth - FContent.Left - HorzMargin;
    //FContent.Top := Y;
    //Y := Y + FContent.Height + VertSpacing;
    X1 := 0;
    Y1 := 0;
    r := GetContentRect;
    r := Rect(r.Left, Y, R.Right, Y + 26);

    if (doHyperlinks in FTaskDialog.Options) then
    begin
      HTMLDrawEx(Canvas, FTaskDialog.Content, r, nil, x1, y1, -1, -1, 1, true, true, false, true, true, false, true,
         1.0, clBlue, clNone, clNone, clGray, anchor, stripped, focusanchor, FContentXSize, FContentYSize, hyperlinks,
         mouselink, re, nil, nil);
    end
    else
    begin
      {
      if (Message.Caption <> '') then
        FContentXSize := Message.Width
      else
        FContentXSize := 360;

      if FContentXSize < 360 then
        FContentXSize := 360;
      }
      FContentXSize := r.Right - r.Left;

      GetTextSize(Canvas, FTaskDialog.Content, FContentXSize, FContentYSize);
    end;

    y1 := FContentYSize;
    if (Message.Caption = '') and Assigned(FIcon) then
    begin
      y1 := Max(FIcon.Height, Y1);
    end;

    Y := Y + Y1 + VertSpacing;
  end
  else
  begin
    if (FTaskDialog.RadioButtons.Count = 0) and not (doCommandLinks in FTaskDialog.Options) then
      Y := Y + VertSpacing;
      
    if (Message.Caption = '') and Assigned(FIcon) then
      Y := Y + VertSpacing + VertMargin;
  end;

  if (doProgressBar in FTaskDialog.Options) then
  begin
    if Assigned(FIcon) then
    begin
      Y := Max(Y, FIcon.Top + FIcon.Height+3);
    end;
    FProgressBar.Top := Y;
    Y := Y + FProgressBar.Height + VertSpacing;
  end;

  if (FTaskDialog.RadioButtons.Count > 0) then
  begin
    for i:= 0 to FRadioList.Count-1 do
    begin
      TTntRadioButton(FRadioList.Items[i]).Top := Y;
      TTntRadioButton(FRadioList.Items[i]).Width := ClientWidth - TTntRadioButton(FRadioList.Items[i]).Left - HorzMargin;
      Y := Y + TTntRadioButton(FRadioList.Items[i]).Height + 4;
    end;
    Y := Y + VertSpacing - 4;
  end;

  FExpTextXSize := 0;
  FExpTextYSize := 0;
  ExpTextTop := 0;
  if (FTaskDialog.ExpandedText <> '') then
  begin
    if FExpanded then
    begin
      (*lbl := TLabel.Create(self);
      {$IFDEF DELPHI_7_UP}
      lbl.WordWrap := true;
      {$ENDIF}
      lbl.Width := ClientWidth - FExpandLabel.Left - HorzMargin;
      lbl.Caption := FTaskDialog.FExpandedText;
      ExH := lbl.Height;
      lbl.Free;

      FExpandLabel.Top := Y;
      FExpandLabel.Width := ClientWidth - FExpandLabel.Left - HorzMargin;
      FExpandLabel.Height := ExH;

      Y := Y + FExpandLabel.Height + VertSpacing;
      FExpandLabel.Visible := True;
      *)
      X1 := 0;
      Y1 := 0;
      r := GetExpTextRect;
      r := Rect(r.Left, Y, R.Right, Y + 26);

      if (doHyperlinks in FTaskDialog.Options) then
      begin
        HTMLDrawEx(Canvas, FTaskDialog.ExpandedText, r, nil, x1, y1, -1, -1, 1, true, true, false, true, true, false, true,
           1.0, clBlue, clNone, clNone, clGray, anchor, stripped, focusanchor, FExpTextXSize, FExpTextYSize, hyperlinks,
           mouselink, re, nil, nil);
      end
      else
      begin
        FExpTextXSize := r.Right - r.Left;
        GetTextSize(Canvas, FTaskDialog.ExpandedText, FExpTextXSize, FExpTextYSize);
      end;

      ExpTextTop := Y;
      FExpTextTop := ExpTextTop;
      Y := Y + FExpTextYSize + VertSpacing;
    end
    else
    begin
      //FExpandLabel.Visible := False;
    end;
  end;

  if not (docommandLinks in FTaskDialog.Options) then
  begin
    for i:= 0 to FcsBtnList.Count-1 do
    begin
      CsBtnGroupWidth := CsBtnGroupWidth + TTntButton(FcsBtnList.Items[i]).Width{ + ButtonSpacing};
    end;

    if (FcsBtnList.Count > 0) then
      CsBtnGroupWidth := CsBtnGroupWidth + (FcsBtnList.Count-1) * ButtonSpacing;
  end
  else
  begin
    for i:= 0 to FcsBtnList.Count-1 do
    begin
      if Assigned(FIcon) then
        TTaskDialogButton(FcsBtnList.Items[i]).Left := FHorzParaMargin; // FIcon.Left + FIcon.Width + FHorzSpacing;
      TTaskDialogButton(FcsBtnList.Items[i]).Top := Y;
      TTaskDialogButton(FcsBtnList.Items[i]).Width := ClientWidth - TTaskDialogButton(FcsBtnList.Items[i]).Left - HorzMargin;
      Y := Y + TTaskDialogButton(FcsBtnList.Items[i]).Height + 2;
    end;
    FWhiteWindowHeight := Y;
    Y := Y + VertSpacing;
  end;

  for i := 0 to FcmBtnList.Count-1 do
  begin
    CmBtnGroupWidth := CmBtnGroupWidth + TTntButton(FcmBtnList.Items[i]).Width{ + ButtonSpacing};
  end;
  CmBtnGroupWidth := CmBtnGroupWidth + (FcmBtnList.Count-1) * ButtonSpacing;

  verifTextWidth := 0;
  if (FTaskDialog.VerificationText <> '') then
  begin
    GetTextSize(Canvas, FTaskDialog.VerificationText, k, l);
    verifTextWidth := k + FVertSpacing * 2;
  end;


  ButtonGroupWidth := CsBtnGroupWidth + CmBtnGroupWidth;

  X := (ClientWidth - ButtonGroupWidth - FHorzSpacing - 4); //(ClientWidth - ButtonGroupWidth) div 2;
  h := Y;
  BtnH := 0;

  if (FTaskDialog.ExpandedText <> '') then
  begin
    X := (ClientWidth - ButtonGroupWidth - FHorzSpacing - 4);
    {
    k := 0;
    l := 0;
    GetTextSize(Canvas, FTaskDialog.CollapsControlText, k, l);
    GetTextSize(Canvas, FTaskDialog.ExpandControlText, n, l);
    k := Max(k, n);
    ButtonGroupWidth := ButtonGroupWidth + FExpandButton.Width + ButtonSpacing + k + FHorzSpacing;
    }
  end;

  if (FTaskDialog.ExpandedText <> '') then
  begin
    with FExpandButton do
    begin
      Top := Y;
      Left := FVertMargin; //X;
      //Inc(X, FExpandButton.Width + ButtonSpacing);
      if (FExpandButton.Height > BtnH) then
        BtnH := FExpandButton.Height;
    end;
  end;

  if (FTaskDialog.VerificationText <> '') and Assigned(FVerificationCheck) then
  begin
    FVerificationCheck.Left := FVertMargin + 3;
    FVerificationCheck.Top := Y + BtnH + 5; // fix top space: + 5
    FVerificationCheck.Width := verifTextWidth - FVertSpacing;
    //X := FVerificationCheck.Left + FVerificationCheck.Width + FVertMargin;
  end;

  if not (docommandLinks in FTaskDialog.Options) then
  begin
    for i:= 0 to FcsBtnList.Count-1 do
    begin
      with TTntButton(FcsBtnList.Items[i]) do
      begin
        Top := Y;
        Left := X;
        Inc(X, TTntButton(FcsBtnList.Items[i]).Width + ButtonSpacing);
        //if (i = 0) then
          //h := h + TButton(FcsBtnList.Items[i]).Height;
        if (TTntButton(FcsBtnList.Items[i]).Height > BtnH) then
          BtnH := TTntButton(FcsBtnList.Items[i]).Height;
      end;
    end;
    if (FcsBtnList.Count > 0) then
      FWhiteWindowHeight := TTntButton(FcsBtnList.items[0]).Top{ - (FVertSpacing div 2)};
  end;

  for i := 0 to FcmBtnList.Count-1 do
  begin
    with TTntButton(FcmBtnList.Items[i]) do
    begin
      Top := Y;
      Left := X;
      Inc(X, TTntButton(FcmBtnList.Items[i]).Width + ButtonSpacing);
      //if (i = 0) then
        //h := h + TButton(FcmBtnList.Items[i]).Height;
      if (TTntButton(FcmBtnList.Items[i]).Height > BtnH) then
        BtnH := TTntButton(FcmBtnList.Items[i]).Height;
    end;

    if (FcmBtnList.Count > 0) then
      FWhiteWindowHeight := TTntButton(FcmBtnList.items[0]).Top{ - (FVertSpacing div 2)};
  end;

  if (FTaskDialog.VerificationText <> '') and Assigned(FVerificationCheck) then
  begin
    h := h + Max(BtnH, FVerificationCheck.Height + VertSpacing);
    y := y + Max(BtnH + FVertSpacing, FVerificationCheck.Height + VertSpacing);
  end
  else
  begin
    h := h + BtnH;
    if (BtnH > 0) then
      y := y + BtnH + FVertSpacing;
  end;

  if (FTaskDialog.Footer <> '') then
  begin
    X1 := 0;
    Y1 := 0;
    if Assigned(FFooterIcon) then
      r := Rect(HorzMargin + 20, Y, Width - HorzMargin, Y + 100)
    else
      r := Rect(HorzMargin, Y, Width - HorzMargin, Y + 100);
      
    HTMLDrawEx(Canvas, FTaskDialog.Footer, r, nil, x1, y1, -1, -1, 1, true, false, false, true, true, false, true,
       1.0, clBlue, clNone, clNone, clGray, anchor, stripped, focusanchor, FFooterXSize, FFooterYSize, hyperlinks,
       mouselink, re, nil, nil);

    y1 := FFooterYSize;
    if Assigned(FFooterIcon) then
    begin
      FFooterIcon.Top := Y;
      y1 := Max(Y1, 20);
    end;
    h := h + Y1 + VertSpacing;
  end;

  h := h + VertMargin;
  ClientHeight := h;
  if (FcmBtnList.Count = 0) and ((docommandLinks in FTaskDialog.Options) or (not (docommandLinks in FTaskDialog.Options) and (FcsBtnList.Count = 0))) then
    FWhiteWindowHeight := Height;
    
  if (ExpTextTop > 0) and (doExpandedFooter in FTaskDialog.Options) then
    FWhiteWindowHeight := ExpTextTop;
end;

//------------------------------------------------------------------------------

constructor TAdvMessageForm.CreateNew(AOwner: TComponent; Dummy: Integer);
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited CreateNew(AOwner);
  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);

  FExpandButton := nil;
  FExpanded := true;
  //FExpandLabel := nil;
  FExpandControlText := '';
  FCollapsControlText := '';
  FcmBtnList := TList.Create;
  FcsBtnList := TList.Create;
  FRadioList := TList.Create;
  FFooterXSize := 0;
  FFooterYSize := 0;
  FWhiteWindowHeight := Height;
  FHorzParaMargin := 0;
end;

//------------------------------------------------------------------------------

{procedure TAdvMessageForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;}

//------------------------------------------------------------------------------

procedure TAdvMessageForm.CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((ssAlt in Shift) and (Key = VK_F4)) then
    Key := 0;

  if (Shift = [ssCtrl]) and (Key = Word('C')) then
  begin
    Beep;
    WriteToClipBoard(GetFormText);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.WriteToClipBoard(Text: WideString);
begin
  // Unicode clipboard support from TntClipBrd
  {$IFDEF DELPHI_UNICODE}
  Clipboard.AsText := GetFormtext;
  {$ENDIF}
  {$IFNDEF DELPHI_UNICODE}
  TntClipboard.AsWideText := GetFormtext;
  {$ENDIF}
end;

//------------------------------------------------------------------------------

function TAdvMessageForm.GetFormText: WideString;
var
  DividerLine, ButtonCaptions: WideString;
  I: integer;
begin
  DividerLine := StringOfChar('-', 27) + sLineBreak;
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TTntButton then
      ButtonCaptions := ButtonCaptions + TTntButton(Components[I]).Caption +
        StringOfChar(' ', 3);
  ButtonCaptions := Tnt_WideStringReplace(ButtonCaptions,'&','', [rfReplaceAll]);
  Result := Format('%s%s%s%s%s%s%s%s%s%s', [DividerLine, Caption, sLineBreak,
    DividerLine, Message.Caption, sLineBreak, DividerLine, ButtonCaptions,
    sLineBreak, DividerLine]);
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.SetExpandButton(const Value: TTaskDialogButton);
begin
  if Assigned(FExpandButton) then
    FExpandButton.OnClick := nil;

  FExpandButton := Value;

  if Assigned(FExpandButton) then
    FExpandButton.OnClick := OnExpandButtonClick;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.OnExpandButtonClick(Sender: TObject);
begin
  if Assigned(FExpandButton) then
  begin
    SetExpanded(not Expanded);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.SetExpanded(Value: Boolean);
begin
  if FExpanded then
  begin
    if not Value then
    begin
      FExpandButton.Picture.LoadFromResourceName(HInstance, 'TD_TNTEXP');
      FExpandButton.Picture.TransparentColor := clFuchsia;
      FExpandButton.PictureHot.LoadFromResourceName(HInstance, 'TD_TNTEXPHOT');
      FExpandButton.PictureHot.TransparentColor := clFuchsia;
      FExpandButton.PictureDown.LoadFromResourceName(HInstance, 'TD_TNTEXPDOWN');
      FExpandButton.PictureDown.TransparentColor := clFuchsia;
    end;
  end
  else
  begin
    if Value then
    begin
      FExpandButton.Picture.LoadFromResourceName(HInstance, 'TD_TNTCOLP');
      FExpandButton.Picture.TransparentColor := clFuchsia;
      FExpandButton.PictureHot.LoadFromResourceName(HInstance, 'TD_TNTCOLPHOT');
      FExpandButton.PictureHot.TransparentColor := clFuchsia;
      FExpandButton.PictureDown.LoadFromResourceName(HInstance, 'TD_TNTCOLPDOWN');
      FExpandButton.PictureDown.TransparentColor := clFuchsia;      
    end;
  end;
  FExpanded := Value;
  SetPositions;
  Invalidate;
end;

//------------------------------------------------------------------------------

destructor TAdvMessageForm.Destroy;
begin
  FcmBtnList.Free;
  FcsBtnList.Free;
  FRadioList.Free;
  if Assigned(FTimer) then
    FTimer.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.DrawExpandedText;
var
  r, re: trect;
  anchor, stripped: WideString;
  HyperLinks,MouseLink: Integer;
  Focusanchor: WideString;
  xsize, ysize: Integer;
begin
  if not Assigned(FTaskDialog) or (not FExpanded) then
    Exit;

  R := GetExpTextRect;
  if (FTaskDialog.ExpandedText <> '') then
  begin
    if (doHyperlinks in FTaskDialog.Options) then
    begin
      HTMLDrawEx(Canvas, FTaskDialog.ExpandedText, R, nil, 0, 0, -1, -1, 1, false, false, false, false, False, false,
        true, 1.0, clBlue, clNone, clNone, clGray, anchor, stripped, focusanchor, xsize, ysize,
        hyperlinks, mouselink, re, nil , nil);
    end
    else
    begin
      Tnt_DrawTextW(Canvas.Handle,PWideChar(FTaskDialog.ExpandedText),Length(FTaskDialog.ExpandedText), R, DT_EXPANDTABS or DT_LEFT or DT_VCENTER or DT_WORDBREAK or DT_NOPREFIX);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.DrawContent;
var
  r, re: trect;
  anchor, stripped: WideString;
  HyperLinks,MouseLink: Integer;
  Focusanchor: WideString;
  xsize, ysize: Integer;
begin
  if not Assigned(FTaskDialog) then
    Exit;

  R := GetContentRect;
  if (FTaskDialog.Content <> '') then
  begin
    if (doHyperlinks in FTaskDialog.Options) then
    begin
      HTMLDrawEx(Canvas, FTaskDialog.Content, R, nil, 0, 0, -1, -1, 1, false, false, false, false, False, false,
        true, 1.0, clBlue, clNone, clNone, clGray, anchor, stripped, focusanchor, xsize, ysize,
        hyperlinks, mouselink, re, nil , nil);
    end
    else
    begin
      Tnt_DrawTextW(Canvas.Handle,PWideChar(FTaskDialog.Content),Length(FTaskDialog.Content), R, DT_EXPANDTABS or DT_LEFT or DT_VCENTER or DT_WORDBREAK or DT_NOPREFIX);
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvMessageForm.GetContentRect: TRect;
var
  X, Y: Integer;
begin
  Result := Rect(-1, -1, -1, -1);
  if Assigned(FTaskDialog) and (FTaskDialog.Content <> '') then
  begin
    X := FHorzMargin;
    if Assigned(FIcon) then
      X := FIcon.Left + FIcon.Width + FHorzSpacing;
    if (Message.Caption <> '') then
      Y := Message.Top + Message.Height + FVertSpacing
    else
      Y := FVertMargin;
    Result := Rect(X, Y, ClientWidth - FHorzMargin, Y + FContentYSize);
  end;
end;

//------------------------------------------------------------------------------

function TAdvMessageForm.GetExpTextRect: TRect;
var
  X, Y: Integer;
begin
  Result := Rect(-1, -1, -1, -1);
  if Assigned(FTaskDialog) and FExpanded then
  begin
    X := FHorzMargin;
    if Assigned(FIcon) then
      X := FIcon.Left + FIcon.Width + FHorzSpacing;
    {if (Message.Caption <> '') then
      Y := Message.Top + Message.Height + FVertSpacing
    else
      Y := FVertMargin;

    if (FTaskDialog.Content <> '') then
      y := Y + FContentYSize + FVertSpacing;

    if (doProgressBar in FTaskDialog.Options) then
    begin
      if Assigned(FIcon) then
      begin
        Y := Max(Y, FIcon.Top + FIcon.Height+3);
      end;

      if Assigned(FProgressBar) then
        Y := Y + FProgressBar.Height + FVertSpacing;
    end;

    if (FTaskDialog.RadioButtons.Count > 0) then
    begin
      if (FRadioList.Count > 0) then
        Y := Y + TRadioButton(FRadioList.Items[FRadioList.Count-1]).Height + FVertSpacing;
    end;}
    Y := FExpTextTop;

    Result := Rect(X, Y, ClientWidth - FHorzMargin, Y + FExpTextYSize);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.DrawFooter;
var
  r, re: trect;
  anchor, stripped: WideString;
  HyperLinks,MouseLink: Integer;
  Focusanchor: WideString;
  xsize, ysize, i: Integer;
  bmp: TBitmap;
  IconH: THandle;
  shieldbmp: TBitmap;

begin
  if not Assigned(FTaskDialog) then
    Exit;

  if (FTaskDialog.Footer <> '') then
  begin
    R := GetFooterRect;

    i := R.Top - FVertSpacing;
    Canvas.Pen.Color := RGB(223, 223, 223);
    Canvas.MoveTo(2, i);
    Canvas.LineTo(ClientWidth -3, i);
    Canvas.Pen.Color := clWhite;
    Canvas.MoveTo(2, i+1);
    Canvas.LineTo(ClientWidth -3, i+1);

    if Assigned(FFooterIcon) then
    begin
      IconH := LoadImage(0,FFooterIconID,IMAGE_ICON,16,16, LR_SHARED);

      bmp := TBitmap.Create;
      bmp.Width := 16;
      bmp.Height := 16;
      bmp.Transparent := True;
      bmp.Canvas.Brush.Color := RGB(240, 240, 240);
      bmp.Canvas.Rectangle(0,0,16,16);
      //DrawIcon(bmp.Canvas.Handle,0, 0, IconH);
      //Canvas.StretchDraw(Rect(R.Left, R.Top-2, R.Left+16, R.Top+14), bmp);

      if FTaskDialog.FooterIcon = tfiShield then
      begin
        shieldbmp := TBitmap.Create;
        shieldbmp.Handle := LoadBitmap(hInstance, 'TD_TNTSHIELD');
        bmp.Canvas.StretchDraw(Rect(0,0,16,16),shieldbmp);
        shieldbmp.Free;
      end
      else
      begin
        DrawIconEx(bmp.Canvas.Handle, 0, 0, IconH, 16, 16, 0, bmp.Canvas.Brush.Handle, DI_NORMAL); //Replaced DrawIcon
      end;

      Canvas.Draw(R.Left, R.Top, bmp);
      bmp.Free;

      R.Left := R.Left + 20;
    end;

    HTMLDrawEx(Canvas, FTaskDialog.Footer, R, nil, 0, 0, -1, -1, 1, false, false, false, false, False, false,
       true, 1.0, clBlue, clNone, clNone, clGray, anchor, stripped, focusanchor, xsize, ysize,
       hyperlinks, mouselink, re, nil , nil);
  end;
end;

//------------------------------------------------------------------------------

function TAdvMessageForm.GetFooterRect: TRect;
begin
  Result := Rect(-1, -1, -1, -1);
  if Assigned(FTaskDialog) and (FTaskDialog.Footer <> '') then
  begin
    Result := Rect(FHorzMargin, ClientHeight - FFooterYSize-10, ClientWidth - FHorzMargin, ClientHeight);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.Paint;
var
  i: Integer;
  R: TRect;
  s: WideString;
  VerInfo: TOSVersionInfo;

begin
  inherited;
  i := FWhiteWindowHeight;
  {if (FcmBtnList.Count > 0) then
    i := TButton(FcmBtnList.Items[0]).Top
  else if (FcsBtnList.Count > 0) then
    i := TButton(FcsBtnList.Items[0]).Top;}

  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(verinfo);

  if (i > 0) then
  begin
    R := ClientRect;
    R.Top := i - (FVertSpacing div 2) ;
    Canvas.Brush.Color := RGB(240, 240, 240);
    Canvas.FillRect(R);
    Canvas.Pen.Color := RGB(223, 223, 223);
    Canvas.MoveTo(R.Left, R.Top);
    Canvas.LineTo(R.Right, R.Top);
    R := ClientRect;
    Canvas.Brush.Style := bsClear;

    if (verinfo.dwMajorVersion >= 6) then
      Canvas.Pen.Style := psClear
    else
      Canvas.Pen.Style := psSolid;

    if DRAWBORDER and not IsVista then
    begin
      Canvas.Pen.Color := clGray;
      Canvas.Rectangle(R.Left+1, R.Top+1, R.Right-1, R.Bottom-1);
    end;
    Canvas.Pen.Style := psSolid;
  end;

  DrawContent;
  DrawExpandedText;
  if Assigned(FTaskDialog) and (FTaskDialog.ExpandedText <> '') and Assigned(FExpandButton) then
  begin
    if not FExpanded then
      s := FTaskDialog.CollapsControlText
    else
      s := FTaskDialog.ExpandControlText;

    Canvas.Brush.Style := bsClear;
    R := Rect(FExpandButton.Left + FExpandButton.Width + FHorzSpacing - 5, FExpandButton.Top, ClientRect.Right, FExpandButton.Top + FExpandButton.Height); 
    Tnt_DrawTextW(Canvas.Handle,PWideChar(s),Length(s), R, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
  end;
  DrawFooter;
end;

//------------------------------------------------------------------------------

function TAdvMessageForm.IsAnchor(x, y: integer): WideString;
var
  r: trect;
  xsize, ysize: integer;
  anchor, stripped: WideString;

  HyperLinks,MouseLink: Integer;
  Focusanchor: WideString;
  re: TRect;
  AText: WideString;
begin
  Result := '';
  if not Assigned(FTaskDialog) then
    Exit;
    
  AText := '';
  R := GetFooterRect;
  if PtInRect(R, Point(X, Y)) then
  begin
    if Assigned(FFooterIcon) then
    begin
      R.Left := R.Left + 20;
    end;
    AText := FTaskDialog.Footer;
  end
  else
  begin
    R := GetContentRect;
    if PtInRect(R, Point(X, y)) then
      AText := FTaskDialog.Content
    else
    begin
      R := GetExpTextRect;
      if PtInRect(R, Point(X, y)) then
        AText := FTaskDialog.ExpandedText;
    end;
  end;

  Anchor := '';
  if (AText <> '') then
  begin
    if HTMLDrawEx(Canvas, AText, r, nil, x, y, -1, -1, 1, true, false, false, true, true, false, true,
       1.0, clBlue, clNone, clNone, clGray, anchor, stripped, focusanchor, xsize, ysize, hyperlinks,
       mouselink, re, nil, nil) then
      Result := anchor;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Anchor: WideString;
begin
  inherited;
  Anchor := IsAnchor(X, Y);
  if Anchor <> '' then
  begin
    if not Assigned(FTaskDialog.OnDialogHyperlinkClick) then
    begin
      if (HTMLPos('://', anchor) > 0) then
        VistaShellOpen(0, '', Anchor);
    end;

    if Assigned(FTaskDialog.OnDialogHyperlinkClick) then
      FTaskDialog.OnDialogHyperlinkClick(FTaskDialog, Anchor);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  anchor: WideString;
begin
  anchor := IsAnchor(x, y);
  if (Anchor <> '') then
  begin
    if (self.Cursor = crDefault) or (fAnchor <> Anchor) then
    begin
      fAnchor := Anchor;
      self.Cursor := crHandPoint;
      //if fAnchorHint then
        //Application.CancelHint;
      //if Assigned(fAnchorEnter) then fAnchorEnter(self, anchor);
    end;
  end
  else
  begin
    if (self.Cursor = crHandPoint) then
    begin
      self.Cursor := crDefault;
      //if assigned(fAnchorExit) then fAnchorExit(self, anchor);
    end;
  end;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.OnTimer(Sender: TObject);
var
  State: TTaskDialogProgressState;
  Pos: Integer;
begin
  if Assigned(FTaskDialog) then
  begin
    if Assigned(FTaskDialog.OnDialogTimer) then
      FTaskDialog.OnDialogTimer(FTaskDialog);
      
    if Assigned(FTaskDialog.OnDialogProgress) then
    begin
      Pos := FProgressBar.Position;
      FTaskDialog.OnDialogProgress(FTaskDialog, Pos, State);
      FProgressBar.Position := Pos;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.ClickButton(ButtonID: integer);
var
  Btn: TTntButton;
  TaskBtn: TTaskDialogButton;
begin
  TaskBtn := nil;
  Btn := GetButton(ButtonID, TaskBtn);
  if Assigned(Btn) then
    Btn.Click
  else if Assigned(TaskBtn) then
    TaskBtn.Click;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.EnableButton(ButtonID: integer;
  Enabled: boolean);
var
  Btn: TTntButton;
  TaskBtn: TTaskDialogButton;
begin
  TaskBtn := nil;
  Btn := GetButton(ButtonID, TaskBtn);
  if Assigned(Btn) then
    Btn.Enabled := Enabled
  else if Assigned(TaskBtn) then
    TaskBtn.Enabled := Enabled;
end;

//------------------------------------------------------------------------------

function TAdvMessageForm.GetButton(ButtonID: Integer; var TaskButton: TTaskDialogButton): TTntButton;
var
  i, j: Integer;
begin
  j := 0;
  Result := nil;
  for i := 0 to FcmBtnList.Count-1 do
  begin
    Inc(j);
    if (j >= ButtonID) then
    begin
      TTntButton(FcmBtnList.Items[i]).Enabled := Enabled;
      Result := TTntButton(FcmBtnList.Items[i]);
      break;
    end;
  end;

  if not Assigned(Result) then
  begin
    j := 99;
    for i := 0 to FcsBtnList.Count-1 do
    begin
      Inc(j);
      if (j >= ButtonID) then
      begin
        if (doCommandLinks in FTaskDialog.Options) then
        begin
          TTaskDialogButton(FcsBtnList.Items[i]).Enabled := Enabled;
          TaskButton := TTaskDialogButton(FcsBtnList.Items[i]);
        end
        else
        begin
          TTntButton(FcsBtnList.Items[i]).Enabled := Enabled;
          Result := TTntButton(FcsBtnList.Items[i]);
        end;
        break;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TTaskDialogButton.Click;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if Form <> nil then
    Form.ModalResult := ModalResult;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.OnVerifyClick(Sender: TObject);
begin
  if not Assigned(FTaskDialog) or not Assigned(FVerificationCheck) then
    Exit;

  FTaskDialog.VerifyResult := FVerificationCheck.Checked;

  if Assigned(FVerificationCheck) and Assigned(FTaskDialog.OnDialogVerifyClick) then
    FTAskDialog.OnDialogVerifyClick(FTaskDialog, FVerificationCheck.Checked);
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.OnRadioClick(Sender: TObject);
begin
  if not Assigned(FTaskDialog) or not Assigned(FRadioList) then
    Exit;

  FTaskDialog.RadioButtonResult := FRadioList.IndexOf(Sender) + 200;  
  if Assigned(FTaskDialog) and Assigned(FTaskDialog.OnDialogRadioClick) then
    FTAskDialog.OnDialogRadioClick(FTaskDialog, FTaskDialog.RadioButtonResult);
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.DoClose(var Action: TCloseAction);
var
  CanClose: Boolean;
begin
  CanClose := True;
  if Assigned(FTaskDialog) and Assigned(FTaskDialog.OnDialogClose) then
  begin
    FTaskDialog.OnDialogClose(FTaskDialog, CanClose);
  end;

  if not CanClose then
    Action := caNone;
  inherited;
end;

procedure TAdvMessageForm.DoShow;
var
  defBtn: integer;
begin
  inherited;

  defBtn := -1;
  if FTaskDialog.DefaultButton <> 0 then
  begin
    if (FTaskDialog.DefaultButton - 100 >= 0) and (FTaskDialog.DefaultButton - 100 < FTaskDialog.CustomButtons.Count) then
       defBtn := FTaskDialog.DefaultButton - 100;
  end;

  if defBtn <> -1 then
  begin
    if (docommandLinks in FTaskDialog.Options) then
      TTaskDialogButton(FcsBtnList[defBtn]).SetFocus
    else
      TCustomControl(FcsBtnList[defBtn]).SetFocus;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.OnButtonClick(Sender: TObject);
begin
  if not Assigned(FTaskDialog) or not Assigned(FcsBtnList) then
    Exit;

  if Assigned(FTaskDialog) and Assigned(FTaskDialog.onDialogButtonClick) then
    FTAskDialog.OnDialogButtonClick(FTaskDialog, FcsBtnList.IndexOf(Sender) + 100);
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.CMDialogChar(var Message: TCMDialogChar);
var
  I: Integer;
begin
  if Assigned(FTaskDialog) and (docommandLinks in FTaskDialog.Options) then
  begin
    for I:= 0 to FcsBtnList.Count-1 do
    begin
      if (TControl(FcsBtnList[I]) is TTaskDialogButton) and IsAccel(Message.CharCode, TTaskDialogButton(FcsBtnList[I]).Caption) and CanFocus then
      begin
        TTaskDialogButton(FcsBtnList[I]).Click;
        Message.Result := 1;
        Exit;
      end;
    end;
  end;

  if (FTaskDialog.ExpandControlText <> '') and Expanded then
  begin
    if IsAccel(Message.CharCode, FTaskDialog.FExpandControlText) then
    begin
      OnExpandButtonClick(Self);
    end;
  end
  else
  if (FTaskDialog.CollapsControlText <> '') and not Expanded then
    if IsAccel(Message.CharCode, FTaskDialog.FCollapsControlText) then
    begin
      OnExpandButtonClick(Self);
    end;
  
  inherited;

  if Assigned(FTaskDialog) and (doAllowDialogCancel in FTaskDialog.Options) and (Message.CharCode = VK_ESCAPE) then
  begin
    Self.Close;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvMessageForm.WMKeyDown(var Message: TWMKeyDown);
begin
  inherited;
end;

//------------------------------------------------------------------------------


initialization
  //cbOK, cbYes, cbNo, cbCancel, cbRetry, cbClose);
  ButtonCaptions[cbOK] := @SMsgDlgOK;
  ButtonCaptions[cbYes] := @SMsgDlgYes;
  ButtonCaptions[cbNo] := @SMsgDlgNo;
  ButtonCaptions[cbCancel] := @SMsgDlgCancel;
  ButtonCaptions[cbRetry] := @SMsgDlgRetry;
  ButtonCaptions[cbClose] := @SCloseButton;
  // was @SMsgDlgAbort, now better fits international delphi versions  

  Captions[tiBlank] := nil;
  Captions[tiWarning] := @SMsgDlgWarning;
  Captions[tiQuestion] := @SMsgDlgConfirm;
  Captions[tiError] := @SMsgDlgError;
  Captions[tiShield] := @SMsgDlgInformation;

end.
