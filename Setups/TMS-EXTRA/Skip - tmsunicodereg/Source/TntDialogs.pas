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

unit TntDialogs;

{$INCLUDE TntCompilers.inc}

{$IFDEF DELPHI_UNICODE}
interface

uses
  Dialogs;

type
  TTntOpenDialog = class(TOpenDialog);
  TTntSaveDialog = class(TSaveDialog);
  TTntFindDialog = class(TFindDialog);
  TTntReplaceDialog = class(TReplaceDialog);

var
  WideMessageDlg: function(const Msg: String; DlgType: TMsgDlgType;
    Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer = MessageDlg;
//  WideMessageDlg: function(const Msg: String; DlgType: TMsgDlgType;
//    Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer = MessageDlg;
  WideMessageDlgPos: function(const Msg: String; DlgType: TMsgDlgType;
    Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer = MessageDlgPos;
//  WideMessageDlgPos: function(const Msg: String; DlgType: TMsgDlgType;
//    Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer; DefaultButton: TMsgDlgBtn): Integer = MessageDlg;
  WideMessageDlgPosHelp: function(const Msg: String; DlgType: TMsgDlgType;
    Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
    const HelpFileName: String): Integer = MessageDlgPosHelp;
//  WideMessageDlgPosHelp: function(const Msg: String; DlgType: TMsgDlgType;
//    Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
//    const HelpFileName: String; DefaultButton: TMsgDlgBtn): Integer = MessageDlgPosHelp;

  WideShowMessage: procedure(const Msg: String) = ShowMessage;
  WideShowMessageFmt: procedure(const Msg: String; Params: array of const) = ShowMessageFmt;
  WideShowMessagePos: procedure(const Msg: String; X, Y: Integer) = ShowMessagePos;


implementation

{$ENDIF}

{$IFNDEF DELPHI_UNICODE}

{$R-,T-,H+,X+}
interface

{ TODO: Property editor for TTntOpenDialog.Filter }

(*$HPPEMIT 'namespace Dialogs {'*)
(*$HPPEMIT 'typedef _OFNOTIFYEXA TOFNotifyExA;'*)
(*$HPPEMIT 'typedef _OFNOTIFYEXW TOFNotifyExW;'*)
(*$HPPEMIT 'typedef _OFNOTIFYEXA TOFNotifyEx;'*)
(*$HPPEMIT '};'*)

uses
  Classes, Messages, CommDlg, Dialogs, Windows, Controls,
  TntClasses, TntForms, TntSysUtils, SysUtils, TntShlObj, ActiveX;

type

{ TCustomFileDialog }

  EPlatformVersionException = class(Exception);

  TFileDialogOption = (fdoOverWritePrompt, fdoStrictFileTypes,
    fdoNoChangeDir, fdoPickFolders, fdoForceFileSystem,
    fdoAllNonStorageItems, fdoNoValidate, fdoAllowMultiSelect,
    fdoPathMustExist, fdoFileMustExist, fdoCreatePrompt,
    fdoShareAware, fdoNoReadOnlyReturn, fdoNoTestFileCreate,
    fdoHideMRUPlaces, fdoHidePinnedPlaces, fdoNoDereferenceLinks,
    fdoDontAddToRecent, fdoForceShowHidden, fdoDefaultNoMiniMode,
    fdoForcePreviewPaneOn);
  TFileDialogOptions = set of TFileDialogOption;

  TFileDialogOverwriteResponse = (forDefault = FDEOR_DEFAULT,
    forAccept = FDEOR_ACCEPT, forRefuse = FDEOR_REFUSE);
  TFileDialogShareViolationResponse = (fsrDefault = FDESVR_DEFAULT,
    fsrAccept = FDESVR_ACCEPT, fsrRefuse = FDESVR_REFUSE);

  TFileDialogCloseEvent = procedure(Sender: TObject; var CanClose: Boolean) of object;
  TFileDialogFolderChangingEvent = procedure(Sender: TObject; var CanChange: Boolean) of object;
  TFileDialogOverwriteEvent = procedure(Sender: TObject;
    var Response: TFileDialogOverwriteResponse) of object;
  TFileDialogShareViolationEvent = procedure(Sender: TObject;
    var Response: TFileDialogShareViolationResponse) of object;

  TFileTypeItem = class(TCollectionItem)
  private
    FDisplayName: Widestring;
    FDisplayNameWStr: LPCWSTR;
    FFileMask: Widestring;
    FFileMaskWStr: LPCWSTR;
    function GetDisplayNameWStr: LPCWSTR;
    function GetFileMaskWStr: LPCWSTR;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property DisplayNameWStr: LPCWSTR read GetDisplayNameWStr;
    property FileMaskWStr: LPCWSTR read GetFileMaskWStr;
  published
    property DisplayName: Widestring read FDisplayName write FDisplayName;
    property FileMask: Widestring read FFileMask write FFileMask;
  end;

  TFileTypeItems = class(TCollection)
  private
    function GetItem(Index: Integer): TFileTypeItem;
    procedure SetItem(Index: Integer; const Value: TFileTypeItem);
  public
    function Add: TFileTypeItem;
    function FilterSpecArray: TComdlgFilterSpecArray;
    property Items[Index: Integer]: TFileTypeItem read GetItem write SetItem; default;
  end;

  TFavoriteLinkItem = class(TCollectionItem)
  private
    FLocation: Widestring;
  published
  protected
    function GetDisplayName: string; override;
  published
    property Location: Widestring read FLocation write FLocation;
  end;

  TFavoriteLinkItems = class;

  TFavoriteLinkItemsEnumerator = class
  private
    FIndex: Integer;
    FCollection: TFavoriteLinkItems;
  public
    constructor Create(ACollection: TFavoriteLinkItems);
    function GetCurrent: TFavoriteLinkItem;
    function MoveNext: Boolean;
    property Current: TFavoriteLinkItem read GetCurrent;
  end;

  TFavoriteLinkItems = class(TCollection)
  private
    function GetItem(Index: Integer): TFavoriteLinkItem;
    procedure SetItem(Index: Integer; const Value: TFavoriteLinkItem);
  public
    function Add: TFavoriteLinkItem;
    function GetEnumerator: TFavoriteLinkItemsEnumerator;
    property Items[Index: Integer]: TFavoriteLinkItem read GetItem write SetItem; default;
  end;

  TCustomFileDialog = class(TComponent)
  private
    FClientGuid: string;
    FDefaultExtension: WideString;
    FDefaultFolder: WideString;
    FDialog: IFileDialog;
    FFavoriteLinks: TFavoriteLinkItems;
    FFileName: TWideFileName;
    FFileNameLabel: WideString;
    FFiles: TTntStrings;
    FFileTypeIndex: Cardinal;
    FFileTypes: TFileTypeItems;
    FHandle: HWnd;
    FOkButtonLabel: WideString;
    FOptions: TFileDialogOptions;
    FShellItem: IShellItem;
    FShellItems: IShellItemArray;
    FTitle: WideString;
    FOnExecute: TNotifyEvent;
    FOnFileOkClick: TFileDialogCloseEvent;
    FOnFolderChange: TNotifyEvent;
    FOnFolderChanging: TFileDialogFolderChangingEvent;
    FOnOverwrite: TFileDialogOverwriteEvent;
    FOnSelectionChange: TNotifyEvent;
    FOnShareViolation: TFileDialogShareViolationEvent;
    FOnTypeChange: TNotifyEvent;
    function GetDefaultFolder: WideString;
    function GetFileName: TWideFileName;
    function GetFiles: TTntStrings;
    procedure GetWindowHandle;
    procedure SetClientGuid(const Value: string);
    procedure SetDefaultFolder(const Value: WideString);
    procedure SetFavoriteLinks(const Value: TFavoriteLinkItems);
    procedure SetFileName(const Value: TWideFileName);
    procedure SetFileTypes(const Value: TFileTypeItems);
  protected
    function CreateFileDialog: IFileDialog; virtual; abstract;
    procedure DoOnExecute; dynamic;
    function DoOnFileOkClick: Boolean; dynamic;
    procedure DoOnFolderChange; dynamic;
    function DoOnFolderChanging: Boolean; dynamic;
    procedure DoOnOverwrite(var Response: TFileDialogOverwriteResponse); dynamic;
    procedure DoOnSelectionChange; dynamic;
    procedure DoOnShareViolation(var Response: TFileDialogShareViolationResponse); dynamic;
    procedure DoOnTypeChange; dynamic;
    function GetFileNames(Items: IShellItemArray): HResult; dynamic;
    function GetItemName(Item: IShellItem; var ItemName: TWideFileName): HResult; dynamic;
    function GetResults: HResult; virtual;
  protected
    function FileOkClick: HResult; dynamic;
    function FolderChange: HResult; dynamic;
    function FolderChanging(psiFolder: IShellItem): HResult; dynamic;
    function Overwrite(psiFile: IShellItem; var Response: Cardinal): HResult; dynamic;
    function SelectionChange: HResult; dynamic;
    function ShareViolation(psiFile: IShellItem; var Response: Cardinal): HResult; dynamic;
    function TypeChange: HResult; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; overload; virtual;
    function Execute(ParentWnd: HWND): Boolean; overload; virtual;
    property ClientGuid: string read FClientGuid write SetClientGuid;
    property DefaultExtension: WideString read FDefaultExtension write FDefaultExtension;
    property DefaultFolder: WideString read GetDefaultFolder write SetDefaultFolder;
    property Dialog: IFileDialog read FDialog;
    property FavoriteLinks: TFavoriteLinkItems read FFavoriteLinks write SetFavoriteLinks;
    property FileName: TWideFileName read GetFileName write SetFileName;
    property FileNameLabel: WideString read FFileNameLabel write FFileNameLabel;
    property Files: TTntStrings read GetFiles;
    property FileTypes: TFileTypeItems read FFileTypes write SetFileTypes;
    property FileTypeIndex: Cardinal read FFileTypeIndex write FFileTypeIndex default 1;
    property Handle: HWnd read FHandle;
    property OkButtonLabel: WideString read FOkButtonLabel write FOkButtonLabel;
    property Options: TFileDialogOptions read FOptions write FOptions;
    property ShellItem: IShellItem read FShellItem;
    property ShellItems: IShellItemArray read FShellItems;
    property Title: WideString read FTitle write FTitle;
    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
    property OnFileOkClick: TFileDialogCloseEvent read FOnFileOkClick write FOnFileOkClick;
    property OnFolderChange: TNotifyEvent read FOnFolderChange write FOnFolderChange;
    property OnFolderChanging: TFileDialogFolderChangingEvent read FOnFolderChanging write FOnFolderChanging;
    property OnOverwrite: TFileDialogOverwriteEvent read FOnOverwrite write FOnOverwrite;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnShareViolation: TFileDialogShareViolationEvent read FOnShareViolation write FOnShareViolation;
    property OnTypeChange: TNotifyEvent read FOnTypeChange write FOnTypeChange;
  end;

{ TFileOpenDialog }

  TCustomFileOpenDialog = class(TCustomFileDialog)
  protected
    function CreateFileDialog: IFileDialog; override;
    function GetResults: HResult; override;
    function SelectionChange: HResult; override;
  end;

  TFileOpenDialog = class(TCustomFileOpenDialog)
  published
    property ClientGuid;
    property DefaultExtension;
    property DefaultFolder;
    property FavoriteLinks;
    property FileName;
    property FileNameLabel;
    property FileTypes;
    property FileTypeIndex;
    property OkButtonLabel;
    property Options;
    property Title;
    property OnExecute;
    property OnFileOkClick;
    property OnFolderChange;
    property OnFolderChanging;
    property OnSelectionChange;
    property OnShareViolation;
    property OnTypeChange;
  end platform;

{ TFileSaveDialog }

  TCustomFileSaveDialog = class(TCustomFileDialog)
  protected
    function CreateFileDialog: IFileDialog; override;
  end;

  TFileSaveDialog = class(TCustomFileSaveDialog)
  published
    property ClientGuid;
    property DefaultExtension;
    property DefaultFolder;
    property FavoriteLinks;
    property FileName;
    property FileNameLabel;
    property FileTypes;
    property FileTypeIndex;
    property OkButtonLabel;
    property Options;
    property Title;
    property OnExecute;
    property OnFileOkClick;
    property OnFolderChange;
    property OnFolderChanging;
    property OnOverwrite;
    property OnSelectionChange;
    property OnShareViolation;
    property OnTypeChange;
  end platform;

{TNT-WARN TIncludeItemEvent}
  TIncludeItemEventW = procedure (const OFN: TOFNotifyExW; var Include: Boolean) of object;


  
{TNT-WARN TOpenDialog}
  TTntOpenDialog = class(TOpenDialog{TNT-ALLOW TOpenDialog})
  private
    FDefaultExt: WideString;
    FFileName: TWideFileName;
    FFilter: WideString;
    FInitialDir: WideString;
    FTitle: WideString;
    FFiles: TTntStrings;
    FOnIncludeItem: TIncludeItemEventW;
    function GetDefaultExt: WideString;
    procedure SetInheritedDefaultExt(const Value: AnsiString);
    procedure SetDefaultExt(const Value: WideString);
    function GetFileName: TWideFileName;
    procedure SetFileName(const Value: TWideFileName);
    function GetFilter: WideString;
    procedure SetInheritedFilter(const Value: AnsiString);
    procedure SetFilter(const Value: WideString);
    function GetInitialDir: WideString;
    procedure SetInheritedInitialDir(const Value: AnsiString);
    procedure SetInitialDir(const Value: WideString);
    function GetTitle: WideString;
    procedure SetInheritedTitle(const Value: AnsiString);
    procedure SetTitle(const Value: WideString);
    function GetFiles: TTntStrings;
  private
    FProxiedOpenFilenameA: TOpenFilenameA;
  protected
    FAllowDoCanClose: Boolean;
    procedure DefineProperties(Filer: TFiler); override;
    function CanCloseW(var OpenFileName: TOpenFileNameW): Boolean;
    function DoCanClose: Boolean; override;
    procedure GetFileNamesW(var OpenFileName: TOpenFileNameW);
    procedure DoIncludeItem(const OFN: TOFNotifyEx; var Include: Boolean); override;
    procedure WndProc(var Message: TMessage); override;
    function DoExecuteW(Func: Pointer; ParentWnd: HWND): Bool; overload;
    function DoExecuteW(Func: Pointer): Bool; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
    {$IFDEF COMPILER_9_UP}
    function Execute(ParentWnd: HWND): Boolean; override;
    {$ENDIF}
    property Files: TTntStrings read GetFiles;
  published
    property DefaultExt: WideString read GetDefaultExt write SetDefaultExt;
    property FileName: TWideFileName read GetFileName write SetFileName;
    property Filter: WideString read GetFilter write SetFilter;
    property InitialDir: WideString read GetInitialDir write SetInitialDir;
    property Title: WideString read GetTitle write SetTitle;
    property OnIncludeItem: TIncludeItemEventW read FOnIncludeItem write FOnIncludeItem;
  end;

{TNT-WARN TSaveDialog}
  TTntSaveDialog = class(TTntOpenDialog)
  public
    function Execute: Boolean; override;
    {$IFDEF COMPILER_9_UP}
    function Execute(ParentWnd: HWND): Boolean; override;
    {$ENDIF}
  end;


{ TTntCommonDialog }

  TTntCommonDialog = class(TComponent)
  private
    FCtl3D: Boolean;
    FDefWndProc: Pointer;
    FHelpContext: THelpContext;
    FHandle: HWnd;
    FObjectInstance: Pointer;
    FTemplate: PWChar;
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    procedure WMInitDialog(var Message: TWMInitDialog); message WM_INITDIALOG;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
    procedure MainWndProc(var Message: TMessage);
  protected
    procedure DoClose; dynamic;
    procedure DoShow; dynamic;
    procedure WndProc(var Message: TMessage); virtual;
    function MessageHook(var Msg: TMessage): Boolean; virtual;
    function TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool; virtual;
    property Template: PWChar read FTemplate write FTemplate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; virtual; abstract;
    procedure DefaultHandler(var Message); override;
    property Handle: HWnd read FHandle;
  published
    property Ctl3D: Boolean read FCtl3D write FCtl3D default True;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;
  
  TFindReplaceFunc = function(var FindReplace: TFindReplaceW): HWnd stdcall;

  TTntFindDialog = class(TTntCommonDialog)
  private
    FOptions: TFindOptions;
    FPosition: TPoint;
    FFindReplaceFunc: TFindReplaceFunc;
    FRedirector: TWinControl;
    FOnFind: TNotifyEvent;
    FOnReplace: TNotifyEvent;
    FFindHandle: HWnd;
    FFindReplace: TFindReplaceW;
    FFindText: array[0..255] of WChar;
    FReplaceText: array[0..255] of WChar;
    function GetFindText: WideString;
    function GetLeft: Integer;
    function GetPosition: TPoint;
    function GetReplaceText: WideString;
    function GetTop: Integer;
    procedure SetFindText(const Value: WideString);
    procedure SetLeft(Value: Integer);
    procedure SetPosition(const Value: TPoint);
    procedure SetReplaceText(const Value: WideString);
    procedure SetTop(Value: Integer);
    property ReplaceText: WideString read GetReplaceText write SetReplaceText;
    property OnReplace: TNotifyEvent read FOnReplace write FOnReplace;
  protected
    function MessageHook(var Msg: TMessage): Boolean; override;
    procedure Find; dynamic;
    procedure Replace; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CloseDialog;
    function Execute: Boolean; override;
    property Left: Integer read GetLeft write SetLeft;
    property Position: TPoint read GetPosition write SetPosition;
    property Top: Integer read GetTop write SetTop;
  published
    property FindText: WideString read GetFindText write SetFindText;
    property Options: TFindOptions read FOptions write FOptions default [frDown];
    property OnFind: TNotifyEvent read FOnFind write FOnFind;
  end;

{ TTntReplaceDialog }

  TTntReplaceDialog = class(TTntFindDialog)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ReplaceText;
    property OnReplace;
  end;

{ Message dialog }

{TNT-WARN CreateMessageDialog}
function WideCreateMessageDialog(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons): TTntForm;overload;
function WideCreateMessageDialog(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn): TTntForm; overload;

{TNT-WARN MessageDlg}
function WideMessageDlg(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload;
function WideMessageDlg(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload;

{TNT-WARN MessageDlgPos}
function WideMessageDlgPos(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer; overload;
function WideMessageDlgPos(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer; DefaultButton: TMsgDlgBtn): Integer; overload;

{TNT-WARN MessageDlgPosHelp}
function WideMessageDlgPosHelp(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: WideString): Integer; overload;
function WideMessageDlgPosHelp(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: WideString; DefaultButton: TMsgDlgBtn): Integer; overload;

{TNT-WARN ShowMessage}
procedure WideShowMessage(const Msg: WideString);
{TNT-WARN ShowMessageFmt}
procedure WideShowMessageFmt(const Msg: WideString; Params: array of const);
{TNT-WARN ShowMessagePos}
procedure WideShowMessagePos(const Msg: WideString; X, Y: Integer);

{ Input dialog }

{TNT-WARN InputQuery}
function WideInputQuery(const ACaption, APrompt: WideString;
   var Value: WideString): Boolean;
{TNT-WARN InputBox}
function WideInputBox(const ACaption, APrompt, ADefault: WideString): WideString;

{TNT-WARN PromptForFileName}
function WidePromptForFileName(var AFileName: WideString; const AFilter: WideString = '';
  const ADefaultExt: WideString = ''; const ATitle: WideString = '';
  const AInitialDir: WideString = ''; SaveDialog: Boolean = False): Boolean;

function GetModalParentWnd: HWND;

implementation

uses
  Forms, Types, {SysUtils,} Graphics, Consts, Math,
  TntWindows, TntStdCtrls, TntClipBrd, TntExtCtrls,
  {$IFDEF COMPILER_9_UP} WideStrUtils, {$ENDIF} TntWideStrUtils;

resourcestring
  SWindowsVistaRequired = '%s requires Windows Vista or later';
  
var
  CreationControl: TTntCommonDialog = nil;
  HelpMsg: Cardinal;
  FindMsg: Cardinal;
  WndProcPtrAtom: TAtom = 0;

{ Center the given window on the screen }

procedure CenterWindow(Wnd: HWnd);
var
  Rect: TRect;
  Monitor: TMonitor;
begin
  GetWindowRect(Wnd, Rect);
  if Application.MainForm <> nil then
  begin
    if Assigned(Screen.ActiveForm) then
      Monitor := Screen.ActiveForm.Monitor
      else
        Monitor := Application.MainForm.Monitor;
  end
  else
    Monitor := Screen.Monitors[0];
  SetWindowPos(Wnd, 0,
    Monitor.Left + ((Monitor.Width - Rect.Right + Rect.Left) div 2),
    Monitor.Top + ((Monitor.Height - Rect.Bottom + Rect.Top) div 3),
    0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

{ Generic dialog hook. Centers the dialog on the screen in response to
  the WM_INITDIALOG message }

function DialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
    CenterWindow(Wnd);
    CreationControl.FHandle := Wnd;
    CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
      Longint(CreationControl.FObjectInstance)));
    CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
    CreationControl := nil;
  end;
end;

function GetModalParentWnd: HWND;
begin
  {$IFDEF COMPILER_9}
  Result := Application.ActiveFormHandle;
  {$ELSE}
  Result := 0;
  {$ENDIF}
  {$IFDEF COMPILER_10_UP}
  if Application.ModalPopupMode <> pmNone then
  begin
    Result := Application.ActiveFormHandle;
  end;
  {$ENDIF}
  if Result = 0 then begin
    Result := Application.Handle;
  end;
end;

type
{ Vista support }

  TFileDialogWrapper = class(TObject)
  private
    procedure AssignFileTypes;
    procedure AssignOptions;
    procedure OnFileOkEvent(Sender: TObject; var CanClose: Boolean);
    procedure OnFolderChangeEvent(Sender: TObject);
    procedure OnSelectionChangeEvent(Sender: TObject);
    procedure OnTypeChangeEvent(Sender: TObject);
  protected
    FFileDialog: TCustomFileDialog;
    FOpenDialog: TTntOpenDialog;
    function CreateFileDialog: TCustomFileDialog; virtual; abstract;
  public
    constructor Create(OpenDialog: TTntOpenDialog);
    destructor Destroy; override;
    function Execute(ParentWnd: HWND): Boolean;
  end;

  TFileOpenDialogWrapper = class(TFileDialogWrapper)
  private
    procedure OnExecuteEvent(Sender: TObject);
  protected
    function CreateFileDialog: TCustomFileDialog; override;
  end;

  TFileSaveDialogWrapper = class(TFileDialogWrapper)
  protected
    function CreateFileDialog: TCustomFileDialog; override;
  end;

{ TFileDialogWrapper }

constructor TFileDialogWrapper.Create(OpenDialog: TTntOpenDialog);
begin
  inherited Create;
  FOpenDialog := OpenDialog;
  FFileDialog := CreateFileDialog;
end;

destructor TFileDialogWrapper.Destroy;
begin
  FFileDialog.Free;
  inherited;
end;

procedure TFileDialogWrapper.AssignFileTypes;
var
  I, J: Integer;
  FilterStr: WideString;
begin
  FilterStr := FOpenDialog.Filter;
  J := 1;
  I := WideTextPos('|', FilterStr);
  while (I <> 0) do
  begin
    with FFileDialog.Filetypes.Add do
    begin
      DisplayName := Copy(FilterStr, J, I - J);
      J := WideTextPosEx('|', FilterStr, I + 1);

      //if J <> 0 then J := J + (I + 1) - 1;

      if J = 0 then
        J := Length(FilterStr) + 1;

      FileMask := Copy(FilterStr, I + 1, J - I - 1);
      Inc(J);
      I := WideTextPosEx('|', FilterStr, J);
    end;
  end;
end;

procedure TFileDialogWrapper.AssignOptions;
const
  CDialogOptionsMap: array[TOpenOption] of TFileDialogOptions = (
    [] {ofReadOnly}, [fdoOverWritePrompt], [] {ofHideReadOnly},
    [fdoNoChangeDir], [] {ofShowHelp}, [fdoNoValidate], [fdoAllowMultiSelect],
    [fdoStrictFileTypes], [fdoPathMustExist], [fdoFileMustExist],
    [fdoCreatePrompt], [fdoShareAware], [fdoNoReadOnlyReturn],
    [fdoNoTestFileCreate], [] {ofNoNetworkButton}, [] {ofNoLongNames},
    [] {ofOldStyleDialog}, [fdoNoDereferenceLinks], [] {ofEnableIncludeNotify},
    [] {ofEnableSizing}, [fdoDontAddToRecent], [fdoForceShowHidden]);
var
  LOption: TOpenOption;
begin
  for LOption := Low(LOption) to High(LOption) do
    if LOption in FOpenDialog.Options then
      FFileDialog.Options := FFileDialog.Options + CDialogOptionsMap[LOption];
  if ofExNoPlacesBar in FOpenDialog.OptionsEx then
    FFileDialog.Options := FFileDialog.Options + [fdoHidePinnedPlaces];
end;

function TFileDialogWrapper.Execute(ParentWnd: HWND): Boolean;
begin
  with FOpenDialog do
  begin
    FFileDialog.DefaultExtension := DefaultExt;
    FFileDialog.DefaultFolder := InitialDir;
    FFileDialog.FileName := FileName;
    FFileDialog.FileTypeIndex := FilterIndex;
    FFileDialog.Title := Title;
    if Assigned(OnCanClose) then
      FFileDialog.OnFileOkClick := OnFileOkEvent;
    if Assigned(OnFolderChange) then
      FFileDialog.OnFolderChange := OnFolderChangeEvent;
    if Assigned(OnSelectionChange) then
      FFileDialog.OnSelectionChange := OnSelectionChangeEvent;
    if Assigned(OnTypeChange) then
      FFileDialog.OnTypeChange := OnTypeChangeEvent;
  end;
  AssignFileTypes;
  AssignOptions;

  Result := FFileDialog.Execute(ParentWnd);

  if Result then
  begin
    FOpenDialog.FileName := FFileDialog.FileName;
    FOpenDialog.Files.Assign(FFileDialog.Files);
  end;
end;

procedure TFileDialogWrapper.OnFileOkEvent(Sender: TObject; var CanClose: Boolean);
begin
  with FOpenDialog do
  begin
    FileName := FFileDialog.FileName;
    Files.Assign(FFileDialog.Files);
  end;
  FOpenDialog.OnCanClose(FOpenDialog, CanClose);
end;

procedure TFileDialogWrapper.OnFolderChangeEvent(Sender: TObject);
begin
  with FOpenDialog do
  begin
    FileName := FFileDialog.FileName;
    OnFolderChange(FOpenDialog);
  end;
end;

procedure TFileDialogWrapper.OnSelectionChangeEvent(Sender: TObject);
begin
  with FOpenDialog do
  begin
    FileName := FFileDialog.FileName;
    Files.Assign(FFileDialog.Files);
    OnSelectionChange(FOpenDialog);
  end;
end;

procedure TFileDialogWrapper.OnTypeChangeEvent(Sender: TObject);
begin
  with FOpenDialog do
  begin
    FilterIndex := FFileDialog.FileTypeIndex;
    OnTypeChange(FOpenDialog);
  end;
end;

{ TFileOpenDialogWrapper }

function TFileOpenDialogWrapper.CreateFileDialog: TCustomFileDialog;
begin
  Result := TFileOpenDialog.Create(nil);
  Result.OnExecute := OnExecuteEvent;
end;

procedure TFileOpenDialogWrapper.OnExecuteEvent(Sender: TObject);
var
  LOptions: Cardinal;
begin
  if FOpenDialog.ClassName = 'TOpenPictureDialog' then // do not localize
  begin
    FFileDialog.Dialog.GetOptions(LOptions);
    LOptions := LOptions or FOS_FORCEPREVIEWPANEON;
    FFileDialog.Dialog.SetOptions(LOptions);
  end;
end;

{ TFileSaveDialogWrapper }

function TFileSaveDialogWrapper.CreateFileDialog: TCustomFileDialog;
begin
  Result := TFileSaveDialog.Create(nil);
end;


var
  ProxyExecuteDialog: TTntOpenDialog;

function ProxyGetOpenFileNameA(var OpenFile: TOpenFilename): Bool; stdcall;
begin
  ProxyExecuteDialog.FProxiedOpenFilenameA := OpenFile;
  Result := False; { as if user hit "Cancel". }
end;

{ TTntOpenDialog }

constructor TTntOpenDialog.Create(AOwner: TComponent);
begin
  inherited;
  FFiles := TTntStringList.Create;
end;

destructor TTntOpenDialog.Destroy;
begin
  FreeAndNil(FFiles);
  inherited;
end;

procedure TTntOpenDialog.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntOpenDialog.GetDefaultExt: WideString;
begin
  Result := GetSyncedWideString(FDefaultExt, inherited DefaultExt);
end;

procedure TTntOpenDialog.SetInheritedDefaultExt(const Value: AnsiString);
begin
  inherited DefaultExt := Value;
end;

procedure TTntOpenDialog.SetDefaultExt(const Value: WideString);
begin
  SetSyncedWideString(Value, FDefaultExt, inherited DefaultExt, SetInheritedDefaultExt);
end;

function TTntOpenDialog.GetFileName: TWideFileName;
var
  Path: array[0..MAX_PATH] of WideChar;
begin
  if Win32PlatformIsUnicode and NewStyleControls and (Handle <> 0) then begin
    // get filename from handle
    SendMessageW(GetParent(Handle), CDM_GETFILEPATH, SizeOf(Path), Integer(@Path));
    Result := Path;
  end else
    Result := GetSyncedWideString(WideString(FFileName), inherited FileName);
end;

procedure TTntOpenDialog.SetFileName(const Value: TWideFileName);
begin
  FFileName := Value;
  inherited FileName := Value;
end;

function TTntOpenDialog.GetFilter: WideString;
begin
  Result := GetSyncedWideString(FFilter, inherited Filter);
end;

procedure TTntOpenDialog.SetInheritedFilter(const Value: AnsiString);
begin
  inherited Filter := Value;
end;

procedure TTntOpenDialog.SetFilter(const Value: WideString);
begin
  SetSyncedWideString(Value, FFilter, inherited Filter, SetInheritedFilter);
end;

function TTntOpenDialog.GetInitialDir: WideString;
begin
  Result := GetSyncedWideString(FInitialDir, inherited InitialDir);
end;

procedure TTntOpenDialog.SetInheritedInitialDir(const Value: AnsiString);
begin
  inherited InitialDir := Value;
end;

procedure TTntOpenDialog.SetInitialDir(const Value: WideString);

  function RemoveTrailingPathDelimiter(const Value: WideString): WideString;
  var
    L: Integer;
  begin
    // remove trailing path delimiter (except 'C:\')
    L := Length(Value);
    if (L > 1) and WideIsPathDelimiter(Value, L) and not WideIsDelimiter(':', Value, L - 1) then
      Dec(L);
    Result := Copy(Value, 1, L);
  end;

begin
  SetSyncedWideString(RemoveTrailingPathDelimiter(Value), FInitialDir,
    inherited InitialDir, SetInheritedInitialDir);
end;

function TTntOpenDialog.GetTitle: WideString;
begin
  Result := GetSyncedWideString(FTitle, inherited Title)
end;

procedure TTntOpenDialog.SetInheritedTitle(const Value: AnsiString);
begin
  inherited Title := Value;
end;

procedure TTntOpenDialog.SetTitle(const Value: WideString);
begin
  SetSyncedWideString(Value, FTitle, inherited Title, SetInheritedTitle);
end;

function TTntOpenDialog.GetFiles: TTntStrings;
begin
  if (not Win32PlatformIsUnicode) then
    FFiles.Assign(inherited Files);
  Result := FFiles;
end;

function TTntOpenDialog.DoCanClose: Boolean;
begin
  if FAllowDoCanClose then
    Result := inherited DoCanClose
  else
    Result := True;
end;

function TTntOpenDialog.CanCloseW(var OpenFileName: TOpenFileNameW): Boolean;
begin
  GetFileNamesW(OpenFileName);
  FAllowDoCanClose := True;
  try
    Result := DoCanClose;
  finally
    FAllowDoCanClose := False;
  end;
  FFiles.Clear;
  inherited Files.Clear;
end;

procedure TTntOpenDialog.DoIncludeItem(const OFN: TOFNotifyEx; var Include: Boolean);
begin
  // CDN_INCLUDEITEM -> DoIncludeItem() is only be available on Windows 2000 +
  // Therefore, just cast OFN as a TOFNotifyExW, since that's what it really is.
  if Win32PlatformIsUnicode and Assigned(FOnIncludeItem) then
    FOnIncludeItem(TOFNotifyExW(OFN), Include)
end;

procedure TTntOpenDialog.WndProc(var Message: TMessage);
begin
  Message.Result := 0;
  if (Message.Msg = WM_INITDIALOG) and not (ofOldStyleDialog in Options) then begin
    { If not ofOldStyleDialog then DoShow on CDN_INITDONE, not WM_INITDIALOG }
    Exit;
  end;
  if Win32PlatformIsUnicode
  and (Message.Msg = WM_NOTIFY) then begin
    case (POFNotify(Message.LParam)^.hdr.code) of
      CDN_FILEOK:
        if not CanCloseW(POFNotifyW(Message.LParam)^.lpOFN^) then
        begin
          Message.Result := 1;
          SetWindowLong(Handle, DWL_MSGRESULT, Message.Result);
          Exit;
        end;
    end;
  end;
  inherited WndProc(Message);
end;

function TTntOpenDialog.DoExecuteW(Func: Pointer): Bool;
begin
  Result := DoExecuteW(Func, GetModalParentWnd);
end;

function TTntOpenDialog.DoExecuteW(Func: Pointer; ParentWnd: HWND): Bool;
var
  OpenFilename: TOpenFilenameW;

  function GetResNamePtr(var ScopedStringStorage: WideString; lpszName: PAnsiChar): PWideChar;
  // duplicated from TntTrxResourceUtils.pas
  begin
    if Tnt_Is_IntResource(PWideChar(lpszName)) then
      Result := PWideChar(lpszName)
    else begin
      ScopedStringStorage := lpszName;
      Result := PWideChar(ScopedStringStorage);
    end;
  end;

  function AllocFilterStr(const S: WideString): WideString;
  var
    P: PWideChar;
  begin
    Result := '';
    if S <> '' then
    begin
      Result := S + #0#0;  // double null terminators (an additional zero added in case Description/Filter pair not even.)
      P := WStrScan(PWideChar(Result), '|');
      while P <> nil do
      begin
        P^ := #0;
        Inc(P);
        P := WStrScan(P, '|');
      end;
    end;
  end;

var
  FileDialogWrapper: TFileDialogWrapper;
  TempTemplate, TempFilter, TempFilename, TempExt: WideString;
begin
  if (Win32MajorVersion >= 6) {$IFDEF VER185}and UseLatestCommonDialogs{$ENDIF}and (Template = nil) then
  begin
    // This requires Windows Vista or later
    if Func = @GetOpenFileNameW then
      FileDialogWrapper := TFileOpenDialogWrapper.Create(Self)
    else
      FileDialogWrapper := TFileSaveDialogWrapper.Create(Self);

    try
      Result := FileDialogWrapper.Execute(ParentWnd);
      FilterIndex := FileDialogWrapper.FFileDialog.FFileTypeIndex;
    finally
      FileDialogWrapper.Free;
    end;
    Exit;
  end;

  FFiles.Clear;

  // 1. Init inherited dialog defaults.
  // 2. Populate OpenFileName record with ansi defaults
  ProxyExecuteDialog := Self;
  try
    DoExecute(@ProxyGetOpenFileNameA);
  finally
    ProxyExecuteDialog := nil;
  end;

  OpenFileName := TOpenFilenameW(FProxiedOpenFilenameA);

  with OpenFilename do
  begin
    if not IsWindow(hWndOwner) then begin
      hWndOwner := ParentWnd;
    end;
    // Filter (PChar -> PWideChar)
    TempFilter := AllocFilterStr(Filter);
    lpstrFilter := PWideChar(TempFilter);
    // FileName (PChar -> PWideChar)
    SetLength(TempFilename, nMaxFile + 2);
    lpstrFile := PWideChar(TempFilename);
    FillChar(lpstrFile^, (nMaxFile + 2) * SizeOf(WideChar), 0);
    WStrLCopy(lpstrFile, PWideChar(FileName), nMaxFile);
    // InitialDir (PChar -> PWideChar)
    if (InitialDir = '') and ForceCurrentDirectory then
      lpstrInitialDir := '.'
    else
      lpstrInitialDir := PWideChar(InitialDir);
    // Title (PChar -> PWideChar)
    lpstrTitle := PWideChar(Title);
    // DefaultExt (PChar -> PWideChar)
    TempExt := DefaultExt;
    if (TempExt = '') and (Flags and OFN_EXPLORER = 0) then
    begin
      TempExt := WideExtractFileExt(Filename);
      Delete(TempExt, 1, 1);
    end;
    if TempExt <> '' then
      lpstrDefExt := PWideChar(TempExt);
    // resource template (PChar -> PWideChar)
    lpTemplateName := GetResNamePtr(TempTemplate, Template);
    // start modal dialog

    Result := TaskModalDialog(Func, OpenFileName);
    
    if Result then
    begin
      GetFileNamesW(OpenFilename);
      if (Flags and OFN_EXTENSIONDIFFERENT) <> 0 then
        Options := Options + [ofExtensionDifferent]
      else
        Options := Options - [ofExtensionDifferent];
      if (Flags and OFN_READONLY) <> 0 then
        Options := Options + [ofReadOnly]
      else
        Options := Options - [ofReadOnly];
      FilterIndex := nFilterIndex;
    end;
  end;
end;

procedure TTntOpenDialog.GetFileNamesW(var OpenFileName: TOpenFileNameW);
var
  Separator: WideChar;

  procedure ExtractFileNamesW(P: PWideChar);
  var
    DirName, FileName: TWideFileName;
    FileList: TWideStringDynArray;
    i: integer;
  begin
    FileList := ExtractStringsFromStringArray(P, Separator);
    if Length(FileList) = 0 then 
      FFiles.Add('')
    else begin
      DirName := FileList[0];
      if Length(FileList) = 1 then
        FFiles.Add(DirName)
      else begin
        // prepare DirName
        if WideLastChar(DirName) <> WideString(PathDelim) then
          DirName := DirName + PathDelim;
        // add files
        for i := 1 {second item} to High(FileList) do begin
          FileName := FileList[i];
          // prepare FileName
          if (FileName[1] <> PathDelim)
          and ((Length(FileName) <= 3) or (FileName[2] <> DriveDelim) or (FileName[3] <> PathDelim))
          then
            FileName := DirName + FileName;
          // add to list
          FFiles.Add(FileName);
        end;
      end;
    end;
  end;

var
  P: PWideChar;
begin
  Separator := #0;
  if (ofAllowMultiSelect in Options) and
    ((ofOldStyleDialog in Options) or not NewStyleControls) then
    Separator := ' ';
  with OpenFileName do
  begin
    if ofAllowMultiSelect in Options then
    begin
      ExtractFileNamesW(lpstrFile);
      FileName := FFiles[0];
    end else
    begin
      P := lpstrFile;
      FileName := ExtractStringFromStringArray(P, Separator);
      FFiles.Add(FileName);
    end;
  end;

  // Sync inherited Files
  inherited Files.Assign(FFiles);
end;

function TTntOpenDialog.Execute: Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := DoExecute(@GetOpenFileNameA)
  else
    Result := DoExecuteW(@GetOpenFileNameW);
end;

{$IFDEF COMPILER_9_UP}
function TTntOpenDialog.Execute(ParentWnd: HWND): Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := DoExecute(@GetOpenFileNameA, ParentWnd)
  else
    Result := DoExecuteW(@GetOpenFileNameW, ParentWnd);
end;
{$ENDIF}

{ TTntSaveDialog }

function TTntSaveDialog.Execute: Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := DoExecute(@GetSaveFileNameA)
  else
    Result := DoExecuteW(@GetSaveFileNameW);
end;

{$IFDEF COMPILER_9_UP}
function TTntSaveDialog.Execute(ParentWnd: HWND): Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := DoExecute(@GetSaveFileNameA, ParentWnd)
  else
    Result := DoExecuteW(@GetSaveFileNameW, ParentWnd);
end;
{$ENDIF}

{ TTntCommonDialog }

constructor TTntCommonDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCtl3D := True;
{$IFDEF MSWINDOWS}   
  FObjectInstance := Classes.MakeObjectInstance(MainWndProc);
{$ENDIF}
{$IFDEF LINUX}
  FObjectInstance := WinUtils.MakeObjectInstance(MainWndProc);
{$ENDIF}   
end;

destructor TTntCommonDialog.Destroy;
begin
{$IFDEF MSWINDOWS}   
  if FObjectInstance <> nil then Classes.FreeObjectInstance(FObjectInstance);
{$ENDIF}
{$IFDEF LINUX}
  if FObjectInstance <> nil then WinUtils.FreeObjectInstance(FObjectInstance);
{$ENDIF}   
  inherited Destroy;
end;

function TTntCommonDialog.MessageHook(var Msg: TMessage): Boolean;
begin
  Result := False;
  if (Msg.Msg = HelpMsg) and (FHelpContext <> 0) then
  begin
    Application.HelpContext(FHelpContext);
    Result := True;
  end;
end;

procedure TTntCommonDialog.DefaultHandler(var Message);
begin
  if FHandle <> 0 then
    with TMessage(Message) do
      Result := CallWindowProc(FDefWndProc, FHandle, Msg, WParam, LParam)
  else inherited DefaultHandler(Message);
end;

procedure TTntCommonDialog.MainWndProc(var Message: TMessage);
begin
  try
    WndProc(Message);
  except
    Application.HandleException(Self);
  end;
end;

procedure TTntCommonDialog.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

procedure TTntCommonDialog.WMDestroy(var Message: TWMDestroy);
begin
  inherited;
  DoClose;
end;

procedure TTntCommonDialog.WMInitDialog(var Message: TWMInitDialog);
begin
  { Called only by non-explorer style dialogs }
  DoShow;
  { Prevent any further processing }
  Message.Result := 0;
end;

procedure TTntCommonDialog.WMNCDestroy(var Message: TWMNCDestroy);
begin
  inherited;
  FHandle := 0;
end;

function TTntCommonDialog.TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool;
type
  TDialogFunc = function(var DialogData): Bool stdcall;
var
  ActiveWindow: HWnd;
  WindowList: Pointer;
  FPUControlWord: Word;
  FocusState: TFocusState;
begin
  ActiveWindow := GetActiveWindow;
  WindowList := DisableTaskWindows(0);
  FocusState := SaveFocusState;
  try
    Application.HookMainWindow(MessageHook);
    asm
      // Avoid FPU control word change in NETRAP.dll, NETAPI32.dll, etc
      FNSTCW  FPUControlWord
    end;
    try
      CreationControl := Self;
      Result := TDialogFunc(DialogFunc)(DialogData);
    finally
      asm
        FNCLEX
        FLDCW FPUControlWord
      end;
      Application.UnhookMainWindow(MessageHook);
    end;
  finally
    EnableTaskWindows(WindowList);
    SetActiveWindow(ActiveWindow);
    RestoreFocusState(FocusState);
  end;
end;

procedure TTntCommonDialog.DoClose;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TTntCommonDialog.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

{ TRedirectorWindow }
{ A redirector window is used to put the find/replace dialog into the
  ownership chain of a form, but intercept messages that CommDlg.dll sends
  exclusively to the find/replace dialog's owner.  TRedirectorWindow
  creates its hidden window handle as owned by the target form, and the
  find/replace dialog handle is created as owned by the redirector.  The
  redirector wndproc forwards all messages to the find/replace component.
}

type
  TRedirectorWindow = class(TWinControl)
  private
    FFindReplaceDialog: TTntFindDialog;
    FFormHandle: THandle;
    procedure CMRelease(var Message); message CM_Release;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Message: TMessage); override;
  end;

procedure TRedirectorWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_VISIBLE or WS_POPUP;
    WndParent := FFormHandle;
  end;
end;

procedure TRedirectorWindow.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  if (Message.Result = 0) and (Message.Msg <> CM_RELEASE) and
    Assigned(FFindReplaceDialog) then
    Message.Result := Integer(FFindReplaceDialog.MessageHook(Message));
end;

procedure TRedirectorWindow.CMRelease(var Message);
begin
  Free;
end;

{ Find and Replace dialog routines }

function FindReplaceWndProc(Wnd: HWND; Msg, WParam, LParam: Longint): Longint; stdcall;

  function CallDefWndProc: Longint;
  begin
    Result := CallWindowProc(Pointer(GetProp(Wnd,
      MakeIntAtom(WndProcPtrAtom))), Wnd, Msg, WParam, LParam);
  end;

begin
  case Msg of
    WM_DESTROY:
      if Application.DialogHandle = Wnd then Application.DialogHandle := 0;
    WM_NCACTIVATE:
      if WParam <> 0 then
      begin
        if Application.DialogHandle = 0 then Application.DialogHandle := Wnd;
      end else
      begin
        if Application.DialogHandle = Wnd then Application.DialogHandle := 0;
      end;
    WM_NCDESTROY:
      begin
        Result := CallDefWndProc;
        RemoveProp(Wnd, MakeIntAtom(WndProcPtrAtom));
        Exit;
      end;
   end;
   Result := CallDefWndProc;
end;

function FindReplaceDialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := DialogHook(Wnd, Msg, wParam, lParam);
  if Msg = WM_INITDIALOG then
  begin
    with TTntFindDialog(PFindReplace(LParam)^.lCustData) do
      if (Left <> -1) or (Top <> -1) then
        SetWindowPos(Wnd, 0, Left, Top, 0, 0, SWP_NOACTIVATE or
          SWP_NOSIZE or SWP_NOZORDER);
    SetProp(Wnd, MakeIntAtom(WndProcPtrAtom), GetWindowLong(Wnd, GWL_WNDPROC));
    SetWindowLong(Wnd, GWL_WNDPROC, Longint(@FindReplaceWndProc));
    Result := 1;
  end;
end;

const
  FindOptions: array[TFindOption] of DWORD = (
    FR_DOWN, FR_FINDNEXT, FR_HIDEMATCHCASE, FR_HIDEWHOLEWORD,
    FR_HIDEUPDOWN, FR_MATCHCASE, FR_NOMATCHCASE, FR_NOUPDOWN, FR_NOWHOLEWORD,
    FR_REPLACE, FR_REPLACEALL, FR_WHOLEWORD, FR_SHOWHELP);

{ TTntFindDialog }

constructor TTntFindDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := [frDown];
  FPosition.X := -1;
  FPosition.Y := -1;
  with FFindReplace do
  begin
    lStructSize := SizeOf(TFindReplaceW);
    hWndOwner := Application.Handle;
    hInstance := SysInit.HInstance;
    lpstrFindWhat := FFindText;
    wFindWhatLen := SizeOf(FFindText);
    lpstrReplaceWith := FReplaceText;
    wReplaceWithLen := SizeOf(FReplaceText);
    lCustData := Longint(Self);
    lpfnHook := FindReplaceDialogHook;
  end;
  FFindReplaceFunc := @CommDlg.FindTextW;
end;

destructor TTntFindDialog.Destroy;
begin
  if FFindHandle <> 0 then SendMessage(FFindHandle, WM_CLOSE, 0, 0);
  if Assigned(FRedirector) then
    TRedirectorWindow(FRedirector).FFindReplaceDialog := nil;
  FreeAndNil(FRedirector);
  inherited Destroy;
end;

procedure TTntFindDialog.CloseDialog;
begin
  if FFindHandle <> 0 then PostMessage(FFindHandle, WM_CLOSE, 0, 0);
end;

function GetTopWindow(Wnd: THandle; var ReturnVar: THandle):Bool; stdcall;
var
  Test: TWinControl;
begin
  Test := FindControl(Wnd);
  Result := True;
  if Assigned(Test) and (Test is TForm) then
  begin
    ReturnVar := Wnd;
    Result := False;
   end;
end;

function TTntFindDialog.Execute: Boolean;
var
  Option: TFindOption;
begin
  if FFindHandle <> 0 then
  begin
    BringWindowToTop(FFindHandle);
    Result := True;
  end else
  begin
    FFindReplace.Flags := FR_ENABLEHOOK;
    FFindReplace.lpfnHook := FindReplaceDialogHook;
    FRedirector := TRedirectorWindow.Create(nil);
    with TRedirectorWindow(FRedirector) do
    begin
      FFindReplaceDialog := Self;
      EnumThreadWindows(GetCurrentThreadID, @GetTopWindow, LPARAM(@FFormHandle));
    end;
    FFindReplace.hWndOwner := FRedirector.Handle;
    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        FFindReplace.Flags := FFindReplace.Flags or FindOptions[Option];
    if Template <> nil then
    begin
      FFindReplace.Flags := FFindReplace.Flags or FR_ENABLETEMPLATE;
      FFindReplace.lpTemplateName := Template;
    end;
    CreationControl := Self;
    FFindHandle := FFindReplaceFunc(FFindReplace);
    Result := FFindHandle <> 0;
  end;
end;

procedure TTntFindDialog.Find;
begin
  if Assigned(FOnFind) then FOnFind(Self);
end;

function TTntFindDialog.GetFindText: WideString;
begin
  Result := FFindText;
end;

function TTntFindDialog.GetLeft: Integer;
begin
  Result := Position.X;
end;

function TTntFindDialog.GetPosition: TPoint;
var
  Rect: TRect;
begin
  Result := FPosition;
  if FFindHandle <> 0 then
  begin
    GetWindowRect(FFindHandle, Rect);
    Result := Rect.TopLeft;
  end;
end;

function TTntFindDialog.GetReplaceText: WideString;
begin
  Result := FReplaceText;
end;

function TTntFindDialog.GetTop: Integer;
begin
  Result := Position.Y;
end;

function TTntFindDialog.MessageHook(var Msg: TMessage): Boolean;
var
  Option: TFindOption;
  Rect: TRect;
begin
  Result := inherited MessageHook(Msg);
  if not Result then
    if (Msg.Msg = FindMsg) and (Pointer(Msg.LParam) = @FFindReplace) then
    begin
      FOptions := [];
      for Option := Low(Option) to High(Option) do
        if (FFindReplace.Flags and FindOptions[Option]) <> 0 then
          Include(FOptions, Option);
      if (FFindReplace.Flags and FR_FINDNEXT) <> 0 then
        Find
      else
      if (FFindReplace.Flags and (FR_REPLACE or FR_REPLACEALL)) <> 0 then
        Replace
      else
      if (FFindReplace.Flags and FR_DIALOGTERM) <> 0 then
      begin
        GetWindowRect(FFindHandle, Rect);
        FPosition := Rect.TopLeft;
        FFindHandle := 0;
        PostMessage(FRedirector.Handle,CM_RELEASE,0,0); // free redirector later
        FRedirector := nil;
      end;
      Result := True;
    end;
end;

procedure TTntFindDialog.Replace;
begin
  if Assigned(FOnReplace) then FOnReplace(Self);
end;

procedure TTntFindDialog.SetFindText(const Value: WideString);
begin
  //StrLCopy(FFindText, PChar(Value), SizeOf(FFindText) - 1);
  WStrLCopy(FFindText, PWChar(Value), SizeOf(FFindText) - 1);
end;

procedure TTntFindDialog.SetLeft(Value: Integer);
begin
  SetPosition(Point(Value, Top));
end;

procedure TTntFindDialog.SetPosition(const Value: TPoint);
begin
  if (FPosition.X <> Value.X) or (FPosition.Y <> Value.Y) then
  begin
    FPosition := Value;
    if FFindHandle <> 0 then
      SetWindowPos(FFindHandle, 0, Value.X, Value.Y, 0, 0,
        SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
  end;
end;

procedure TTntFindDialog.SetReplaceText(const Value: WideString);
begin
  WStrLCopy(FReplaceText, PWChar(Value), SizeOf(FReplaceText) - 1);
end;

procedure TTntFindDialog.SetTop(Value: Integer);
begin
  SetPosition(Point(Left, Value));
end;

{ TTntReplaceDialog }

constructor TTntReplaceDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFindReplaceFunc := CommDlg.ReplaceTextW;
end;

{ Message dialog }

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of WideChar;
  tm: TTextMetric;
begin
  for I := 0 to 25 do Buffer[I] := WideChar(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := WideChar(I + Ord('a'));
  GetTextMetrics(Canvas.Handle, tm);
  GetTextExtentPointW(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := (Result.X div 26 + 1) div 2;
  Result.Y := tm.tmHeight;
end;

type
  TTntMessageForm = class(TTntForm)
  private
    Message: TTntLabel;
    procedure HelpButtonClick(Sender: TObject);
  protected
    procedure CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function GetFormText: WideString;
  public
    constructor CreateNew(AOwner: TComponent); reintroduce;
  end;

constructor TTntMessageForm.CreateNew(AOwner: TComponent);
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited CreateNew(AOwner);
  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
end;

procedure TTntMessageForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TTntMessageForm.CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = Word('C')) then
  begin
    Beep;
    TntClipboard.AsWideText := GetFormText;
  end;
end;

function TTntMessageForm.GetFormText: WideString;
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
  Result := DividerLine + Caption + sLineBreak + DividerLine + Message.Caption + sLineBreak
          + DividerLine + ButtonCaptions + sLineBreak + DividerLine;
end;

function GetMessageCaption(MsgType: TMsgDlgType): WideString;
begin
  case MsgType of
    mtWarning:      Result := SMsgDlgWarning;
    mtError:        Result := SMsgDlgError;
    mtInformation:  Result := SMsgDlgInformation;
    mtConfirmation: Result := SMsgDlgConfirm;
    mtCustom:       Result := '';
    else
      raise ETntInternalError.Create('Unexpected MsgType in GetMessageCaption.');
  end;
end;

function GetButtonCaption(MsgDlgBtn: TMsgDlgBtn): WideString;
begin
  case MsgDlgBtn of
    mbYes:         Result := SMsgDlgYes;
    mbNo:          Result := SMsgDlgNo;
    mbOK:          Result := SMsgDlgOK;
    mbCancel:      Result := SMsgDlgCancel;
    mbAbort:       Result := SMsgDlgAbort;
    mbRetry:       Result := SMsgDlgRetry;
    mbIgnore:      Result := SMsgDlgIgnore;
    mbAll:         Result := SMsgDlgAll;
    mbNoToAll:     Result := SMsgDlgNoToAll;
    mbYesToAll:    Result := SMsgDlgYesToAll;
    mbHelp:        Result := SMsgDlgHelp;
    else
      raise ETntInternalError.Create('Unexpected MsgDlgBtn in GetButtonCaption.');
  end;
end;

var
  IconIDs: array[TMsgDlgType] of PAnsiChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);
  ButtonNames: array[TMsgDlgBtn] of WideString = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', 'Help');
  ModalResults: array[TMsgDlgBtn] of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
    mrYesToAll, 0);

function WideCreateMessageDialog(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn): TTntForm;
const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 14;
  mcButtonSpacing = 4;
var
  DialogUnits: TPoint;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X, ALeft: Integer;
  B, CancelButton: TMsgDlgBtn;
  IconID: PAnsiChar;
  ATextRect: TRect;
  ThisButtonWidth: integer;
  LButton: TTntButton;
begin
  Result := TTntMessageForm.CreateNew(Application);
  with Result do
  begin
    BorderStyle := bsDialog; // By doing this first, it will work on WINE.
    BiDiMode := Application.BiDiMode;
    Canvas.Font := Font;
    KeyPreview := True;
    Position := poDesigned;
    OnKeyDown := TTntMessageForm(Result).CustomKeyDown;
    DialogUnits := GetAveCharSize(Canvas);
    HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
    VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
    HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
    VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    begin
      if B in Buttons then
      begin
        ATextRect := Rect(0,0,0,0);
        Tnt_DrawTextW(Canvas.Handle,
          PWideChar(GetButtonCaption(B)), -1,
          ATextRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE or
          DrawTextBiDiModeFlagsReadingOnly);
        with ATextRect do ThisButtonWidth := Right - Left + 8;
        if ThisButtonWidth > ButtonWidth then
          ButtonWidth := ThisButtonWidth;
      end;
    end;
    ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
    ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
    SetRect(ATextRect, 0, 0, Screen.Width div 2, 0);
    Tnt_DrawTextW(Canvas.Handle, PWideChar(Msg), Length(Msg) + 1, ATextRect,
      DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK or
      DrawTextBiDiModeFlagsReadingOnly);
    IconID := IconIDs[DlgType];
    IconTextWidth := ATextRect.Right;
    IconTextHeight := ATextRect.Bottom;
    if IconID <> nil then
    begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then IconTextHeight := 32;
    end;
    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount);
    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);
    ClientWidth := Max(IconTextWidth, ButtonGroupWidth) + HorzMargin * 2;
    ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
      VertMargin * 2;
    Left := (Screen.Width div 2) - (Width div 2);
    Top := (Screen.Height div 2) - (Height div 2);
    if DlgType <> mtCustom then
      Caption := GetMessageCaption(DlgType)
    else
      Caption := TntApplication.Title;
    if IconID <> nil then
      with TTntImage.Create(Result) do
      begin
        Name := 'Image';
        Parent := Result;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        SetBounds(HorzMargin, VertMargin, 32, 32);
      end;
    TTntMessageForm(Result).Message := TTntLabel.Create(Result);
    with TTntMessageForm(Result).Message do
    begin
      Name := 'Message';
      Parent := Result;
      WordWrap := True;
      Caption := Msg;
      BoundsRect := ATextRect;
      BiDiMode := Result.BiDiMode;
      ALeft := IconTextWidth - ATextRect.Right + HorzMargin;
      if UseRightToLeftAlignment then
        ALeft := Result.ClientWidth - ALeft - Width;
      SetBounds(ALeft, VertMargin,
        ATextRect.Right, ATextRect.Bottom);
    end;
    if mbCancel in Buttons then CancelButton := mbCancel else
      if mbNo in Buttons then CancelButton := mbNo else
        CancelButton := mbOk;
    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
      begin
        LButton := TTntButton.Create(Result);
        with LButton do
        begin
          Name := ButtonNames[B];
          Parent := Result;
          Caption := GetButtonCaption(B);
          ModalResult := ModalResults[B];
          if B = DefaultButton then
          begin
            Default := True;
            ActiveControl := LButton;
          end;
          if B = CancelButton then
            Cancel := True;
          SetBounds(X, IconTextHeight + VertMargin + VertSpacing,
            ButtonWidth, ButtonHeight);
          Inc(X, ButtonWidth + ButtonSpacing);
          if B = mbHelp then
            OnClick := TTntMessageForm(Result).HelpButtonClick;
        end;
      end;
  end;
end;

function WideCreateMessageDialog(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons): TTntForm;
var
  DefaultButton: TMsgDlgBtn;
begin
  if mbOk in Buttons then DefaultButton := mbOk else
    if mbYes in Buttons then DefaultButton := mbYes else
      DefaultButton := mbRetry;
  Result := WideCreateMessageDialog(Msg, DlgType, Buttons, DefaultButton);
end;

function WideMessageDlg(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer;
begin
  Result := WideMessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, -1, -1, '', DefaultButton);
end;

function WideMessageDlg(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  Result := WideMessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, -1, -1, '');
end;

function WideMessageDlgPos(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer; DefaultButton: TMsgDlgBtn): Integer;
begin
  Result := WideMessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, X, Y, '', DefaultButton);
end;

function WideMessageDlgPos(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;
begin
  Result := WideMessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, X, Y, '');
end;

function _Internal_WideMessageDlgPosHelp(Dlg: TTntForm; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: WideString): Integer;
begin
  with Dlg do
    try
      HelpContext := HelpCtx;
      HelpFile := HelpFileName;
      if X >= 0 then Left := X;
      if Y >= 0 then Top := Y;
      if (Y < 0) and (X < 0) then Position := poScreenCenter;
      Result := ShowModal;
    finally
      Free;
    end;
end;

function WideMessageDlgPosHelp(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: WideString; DefaultButton: TMsgDlgBtn): Integer;
begin
  Result := _Internal_WideMessageDlgPosHelp(
    WideCreateMessageDialog(Msg, DlgType, Buttons, DefaultButton), HelpCtx, X, Y, HelpFileName);
end;

function WideMessageDlgPosHelp(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: WideString): Integer;
begin
  Result := _Internal_WideMessageDlgPosHelp(
    WideCreateMessageDialog(Msg, DlgType, Buttons), HelpCtx, X, Y, HelpFileName);
end;

procedure WideShowMessage(const Msg: WideString);
begin
  WideShowMessagePos(Msg, -1, -1);
end;

procedure WideShowMessageFmt(const Msg: WideString; Params: array of const);
begin
  WideShowMessage(WideFormat(Msg, Params));
end;

procedure WideShowMessagePos(const Msg: WideString; X, Y: Integer);
begin
  WideMessageDlgPos(Msg, mtCustom, [mbOK], 0, X, Y);
end;

{ Input dialog }

function WideInputQuery(const ACaption, APrompt: WideString; var Value: WideString): Boolean;
var
  Form: TTntForm;
  Prompt: TTntLabel;
  Edit: TTntEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TTntForm.Create(Application);
  with Form do begin
    try
      BorderStyle := bsDialog; // By doing this first, it will work on WINE.
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TTntLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TTntEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TTntButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TTntButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15, ButtonWidth,
          ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
  end;
end;

function WideInputBox(const ACaption, APrompt, ADefault: WideString): WideString;
begin
  Result := ADefault;
  WideInputQuery(ACaption, APrompt, Result);
end;

function WidePromptForFileName(var AFileName: WideString; const AFilter: WideString = '';
  const ADefaultExt: WideString = ''; const ATitle: WideString = '';
  const AInitialDir: WideString = ''; SaveDialog: Boolean = False): Boolean;
var
  Dialog: TTntOpenDialog;
begin
  if SaveDialog then
  begin
    Dialog := TTntSaveDialog.Create(nil);
    Dialog.Options := Dialog.Options + [ofOverwritePrompt];
  end
  else
    Dialog := TTntOpenDialog.Create(nil);
  with Dialog do
  try
    Title := ATitle;
    DefaultExt := ADefaultExt;
    if AFilter = '' then
      Filter := SDefaultFilter else
      Filter := AFilter;
    InitialDir := AInitialDir;
    FileName := AFileName;
    Result := Execute;
    if Result then
      AFileName := FileName;
  finally
    Free;
  end;
end;

constructor TFileTypeItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDisplayNameWStr := nil;
  FFileMaskWStr := nil;
end;

destructor TFileTypeItem.Destroy;
begin
  if FDisplayNameWStr <> nil then
    CoTaskMemFree(FDisplayNameWStr);
  if FFileMaskWStr <> nil then
    CoTaskMemFree(FFileMaskWStr);
  inherited;
end;

function TFileTypeItem.GetDisplayNameWStr: LPCWSTR;
var
  Len: Integer;
begin
  if FDisplayNameWStr <> nil then
    CoTaskMemFree(FDisplayNameWStr);
  Len := Length(FDisplayName);
  FDisplayNameWStr := CoTaskMemAlloc((Len * 2) + 2);
  Result := WStrPLCopy(FDisplayNameWStr, WideString(FDisplayName), Len);
end;

function TFileTypeItem.GetDisplayName: string;
begin
  if FDisplayName <> '' then
    Result := FDisplayName
  else
    Result := inherited GetDisplayName;
end;

function TFileTypeItem.GetFileMaskWStr: LPCWSTR;
var
  Len: Integer;
begin
  if FFileMaskWStr <> nil then
    CoTaskMemFree(FFileMaskWStr);
  Len := Length(FFileMask);
  FFileMaskWStr := CoTaskMemAlloc((Len * 2) + 2);
  Result := WStrPLCopy(FFileMaskWStr, FFileMask, Len);
end;

{ TFileDialogFileTypes }

function TFileTypeItems.Add: TFileTypeItem;
begin
  Result := TFileTypeItem(inherited Add);
end;

function TFileTypeItems.FilterSpecArray: TComdlgFilterSpecArray;
var
  I: Integer;
begin
  SetLength(Result, Count);
  for I := 0 to Count - 1 do
  begin
    Result[I].pszName := Items[I].DisplayNameWStr;
    Result[I].pszSpec := Items[I].FileMaskWStr;
  end;
end;

function TFileTypeItems.GetItem(Index: Integer): TFileTypeItem;
begin
  Result := TFileTypeItem(inherited GetItem(Index));
end;

procedure TFileTypeItems.SetItem(Index: Integer; const Value: TFileTypeItem);
begin
  inherited SetItem(Index, Value);
end;

{ TFilePlacesEnumerator }

constructor TFavoriteLinkItemsEnumerator.Create(ACollection: TFavoriteLinkItems);
begin
  inherited Create;
  FIndex := -1;
  FCollection := ACollection;
end;

function TFavoriteLinkItemsEnumerator.GetCurrent: TFavoriteLinkItem;
begin
  Result := FCollection[FIndex];
end;

function TFavoriteLinkItemsEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FCollection.Count - 1;
  if Result then
    Inc(FIndex);
end;

{ TFilePlaceItem }

function TFavoriteLinkItem.GetDisplayName: string;
begin
  if FLocation <> '' then
    Result := FLocation
  else
    Result := inherited GetDisplayName;
end;

{ TFilePlaces }

function TFavoriteLinkItems.Add: TFavoriteLinkItem;
begin
  Result := TFavoriteLinkItem(inherited Add);
end;

function TFavoriteLinkItems.GetEnumerator: TFavoriteLinkItemsEnumerator;
begin
  Result := TFavoriteLinkItemsEnumerator.Create(Self);
end;

function TFavoriteLinkItems.GetItem(Index: Integer): TFavoriteLinkItem;
begin
  Result := TFavoriteLinkItem(inherited GetItem(Index));
end;

procedure TFavoriteLinkItems.SetItem(Index: Integer; const Value: TFavoriteLinkItem);
begin
  inherited SetItem(Index, Value);
end;

{ TFileDialogEvents }

type
  TFileDialogEvents = class(TInterfacedObject, IFileDialogEvents)
  private
    FFileDialog: TCustomFileDialog;
    FRetrieveHandle: Boolean;
  public
    constructor Create(AFileDialog: TCustomFileDialog);
    { IFileDialogEvents }
    function OnFileOk(const pfd: IFileDialog): HResult; stdcall;
    function OnFolderChanging(const pfd: IFileDialog;
      const psiFolder: IShellItem): HResult; stdcall;
    function OnFolderChange(const pfd: IFileDialog): HResult; stdcall;
    function OnSelectionChange(const pfd: IFileDialog): HResult; stdcall;
    function OnShareViolation(const pfd: IFileDialog; const psi: IShellItem;
      out pResponse: DWORD): HResult; stdcall;
    function OnTypeChange(const pfd: IFileDialog): HResult; stdcall;
    function OnOverwrite(const pfd: IFileDialog; const psi: IShellItem;
      out pResponse: DWORD): HResult; stdcall;
  end;

constructor TFileDialogEvents.Create(AFileDialog: TCustomFileDialog);
begin
  FFileDialog := AFileDialog;
  FRetrieveHandle := True;
end;

function TFileDialogEvents.OnFileOk(const pfd: IFileDialog): HResult;
begin
  if Assigned(FFileDialog.OnFileOkClick) then
    Result := FFileDialog.FileOkClick
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnFolderChange(const pfd: IFileDialog): HResult;
begin
  if Assigned(FFileDialog.OnFolderChange) then
    Result := FFileDialog.FolderChange
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnFolderChanging(const pfd: IFileDialog;
  const psiFolder: IShellItem): HResult;
begin
  if Assigned(FFileDialog.OnFolderChanging) then
    Result := FFileDialog.FolderChanging(psiFolder)
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnOverwrite(const pfd: IFileDialog;
  const psi: IShellItem; out pResponse: DWORD): HResult;
begin
  if Assigned(FFileDialog.OnOverwrite) then
    Result := FFileDialog.Overwrite(psi, pResponse)
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnSelectionChange(const pfd: IFileDialog): HResult;
begin
  // OnSelectionChange is called when the dialog is opened, use this
  // to retrieve the window handle if OnTypeChange wasn't triggered.
  if FRetrieveHandle then
  begin
    FFileDialog.GetWindowHandle;
    FRetrieveHandle := False;
  end;

  if Assigned(FFileDialog.OnSelectionChange) then
    Result := FFileDialog.SelectionChange
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnShareViolation(const pfd: IFileDialog;
  const psi: IShellItem; out pResponse: DWORD): HResult;
begin
  if Assigned(FFileDialog.OnShareViolation) then
    Result := FFileDialog.ShareViolation(psi, pResponse)
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnTypeChange(const pfd: IFileDialog): HResult;
var
  i: cardinal;
begin
  // OnTypeChange is supposed to always be called when the dialog is
  // opened. In reality it isn't called if you don't assign any FileTypes.
  // Use this to retrieve the window handle, if it's called.
  if FRetrieveHandle then
  begin
    FFileDialog.GetWindowHandle;
    FRetrieveHandle := False;
  end;

  pfd.GetFileTypeIndex(i);

  // update type index
  FFileDialog.FileTypeIndex := i;

  if Assigned(FFileDialog.OnTypeChange) then
    Result := FFileDialog.TypeChange
  else
    Result := E_NOTIMPL;
end;

{ TCustomFileDialog }

constructor TCustomFileDialog.Create(AOwner: TComponent);
begin
  inherited;
  FFiles := TTntStringList.Create;
  FFileTypeIndex := 1;
  FFileTypes := TFileTypeItems.Create(TFileTypeItem);
  FHandle := 0;
  FOptions := [];
  FFavoriteLinks := TFavoriteLinkItems.Create(TFavoriteLinkItem); //TStringList.Create;
  FShellItem := nil;
  FShellItems := nil;
end;

destructor TCustomFileDialog.Destroy;
begin
  FFiles.Free;
  FFileTypes.Free;
  FFavoriteLinks.Free;
  FShellItem := nil;
  FShellItems := nil;
  inherited;
end;

procedure TCustomFileDialog.DoOnExecute;
begin
  if Assigned(FOnExecute) then
    FOnExecute(Self);
end;

function TCustomFileDialog.DoOnFileOkClick: Boolean;
begin
  Result := True;
  if Assigned(FOnFileOkClick) then
    FOnFileOkClick(Self, Result);
end;

procedure TCustomFileDialog.DoOnFolderChange;
begin
  if Assigned(FOnFolderChange) then
    FOnFolderChange(Self);
end;

function TCustomFileDialog.DoOnFolderChanging: Boolean;
begin
  Result := True;
  if Assigned(FOnFolderChanging) then
    FOnFolderChanging(Self, Result);
end;

procedure TCustomFileDialog.DoOnOverwrite(var Response: TFileDialogOverwriteResponse);
begin
  if Assigned(FOnOverwrite) then
    FOnOverwrite(Self, Response);
end;

procedure TCustomFileDialog.DoOnSelectionChange;
begin
  if Assigned(FOnSelectionChange) then
    FOnSelectionChange(Self);
end;

procedure TCustomFileDialog.DoOnShareViolation(var Response: TFileDialogShareViolationResponse);
begin
  if Assigned(FOnShareViolation) then
    FOnShareViolation(Self, Response);
end;

procedure TCustomFileDialog.DoOnTypeChange;
begin
  if Assigned(FOnTypeChange) then
    FOnTypeChange(Self);
end;

                                                                                           
function TCustomFileDialog.Execute: Boolean;
var
  ParentWnd: HWND;
begin
  {$IFNDEF COMPILER_10_UP}
  ParentWnd := Application.Handle;
  {$ENDIF}
  {$IFDEF COMPILER_10_UP}
  if Application.ModalPopupMode <> pmNone then
  begin
    ParentWnd := Application.ActiveFormHandle;
    if ParentWnd = 0 then
      ParentWnd := Application.Handle;
  end
  else
    ParentWnd := Application.Handle;
  {$ENDIF}

  {if Application.ModalPopupMode <> pmNone then
  begin
    ParentWnd := Application.ActiveFormHandle;
    if ParentWnd = 0 then
      ParentWnd := Application.Handle;
  end
  else
    ParentWnd := Application.Handle;}
  Result := Execute(ParentWnd);
end;

                                                                                           
function TCustomFileDialog.Execute(ParentWnd: HWND): Boolean;
const
  CDialogOptions: array[TFileDialogOption] of DWORD = (
    FOS_OVERWRITEPROMPT, FOS_STRICTFILETYPES, FOS_NOCHANGEDIR,
    FOS_PICKFOLDERS, FOS_FORCEFILESYSTEM, FOS_ALLNONSTORAGEITEMS,
    FOS_NOVALIDATE, FOS_ALLOWMULTISELECT, FOS_PATHMUSTEXIST,
    FOS_FILEMUSTEXIST, FOS_CREATEPROMPT, FOS_SHAREAWARE,
    FOS_NOREADONLYRETURN, FOS_NOTESTFILECREATE, FOS_HIDEMRUPLACES,
    FOS_HIDEPINNEDPLACES, FOS_NODEREFERENCELINKS, FOS_DONTADDTORECENT,
    FOS_FORCESHOWHIDDEN, FOS_DEFAULTNOMINIMODE, FOS_FORCEPREVIEWPANEON);
var
  LWindowList: Pointer;
  LFocusState: TFocusState;
  LPlace: TFavoriteLinkItem;
  LShellItem: IShellItem;
  LAdviseCookie: Cardinal;
  LDialogOptions: Cardinal;
  LDialogEvents: TFileDialogEvents;
  LDialogOption, dp: TFileDialogOption;
  i: Integer;
begin
  if Win32MajorVersion < 6 then
    raise EPlatformVersionException.CreateResFmt(@SWindowsVistaRequired, [ClassName]);

  Result := False;
  FDialog := CreateFileDialog;
  if FDialog <> nil then
    try
      with FDialog do
      begin
        // ClientGuid, DefaultExt, FileName, Title, OkButtonLabel, FileNameLabel
        if FClientGuid <> '' then
          SetClientGuid(StringToGUID(FClientGuid));
        if FDefaultExtension <> '' then
          SetDefaultExtension(PWideChar(FDefaultExtension));
        if FFileName <> '' then
          SetFileName(PWideChar(FFileName));
        if FFileNameLabel <> '' then
          SetFileNameLabel(PWideChar(FFileNameLabel));
        if FOkButtonLabel <> '' then
          SetOkButtonLabel(PWideChar(FOkButtonLabel));
        if FTitle <> '' then
          SetTitle(PWideChar(FTitle));

        // DefaultFolder
        if FDefaultFolder <> '' then
        begin
          if Succeeded(SHCreateItemFromParsingName(PWideChar(FDefaultFolder),
             nil, StringToGUID(SID_IShellItem), LShellItem)) then
            SetFolder(LShellItem);
        end;

        // FileTypes, FileTypeIndex
        if FFileTypes.Count > 0 then
        begin
          FDialog.SetFileTypes(FFileTypes.Count, FFileTypes.FilterSpecArray);
          SetFileTypeIndex(FFileTypeIndex);
        end;

        // Options
        LDialogOptions := 0;
        {for LDialogOption in Options do
          LDialogOptions := LDialogOptions or CDialogOptions[LDialogOption];}
        for dp := Low(TFileDialogOption) to High(TFileDialogOption) do
        begin
          if (dp in Options) then
          begin
            LDialogOption := dp;
            LDialogOptions := LDialogOptions or CDialogOptions[LDialogOption];
          end;  
        end;
        SetOptions(LDialogOptions);

        // Additional Places
        //for LPlace in FFavoriteLinks do
        for i := 0 to FFavoriteLinks.count-1 do
        begin
          LPlace := FFavoriteLinks.Items[i];
          if Succeeded(SHCreateItemFromParsingName(PWideChar(WideString(LPlace.Location)),
             nil, StringToGUID(SID_IShellItem), LShellItem)) then
            AddPlace(LShellItem, FDAP_BOTTOM);
        end;
 
        // Show dialog and get results
        DoOnExecute;
        LWindowList := DisableTaskWindows(ParentWnd);
        LFocusState := SaveFocusState;
        try
          LDialogEvents := TFileDialogEvents.Create(Self);
          Advise(LDialogEvents, LAdviseCookie);
          try
            Result := Succeeded(Show(ParentWnd));
            if Result then
              Result := Succeeded(GetResults);
          finally
            Unadvise(LAdviseCookie);
          end;
        finally
          EnableTaskWindows(LWindowList);
          SetActiveWindow(ParentWnd);
          RestoreFocusState(LFocusState);
        end;
      end;
    finally
      FDialog := nil;
    end;
end;

function TCustomFileDialog.FileOkClick: HResult;
const
  CResults: array[Boolean] of HResult = (S_FALSE, S_OK);
begin
  Result := GetResults;
  if Succeeded(Result) then
    Result := CResults[DoOnFileOkClick];
  Files.Clear;
end;

function TCustomFileDialog.FolderChange: HResult;
begin
  FFileName := '';
  Result := FDialog.GetFolder(FShellItem);
  if Succeeded(Result) then
  begin
    Result := GetItemName(FShellItem, FFileName);
    if Succeeded(Result) then
      DoOnFolderChange;
  end;
  FShellItem := nil;
end;

function TCustomFileDialog.FolderChanging(psiFolder: IShellItem): HResult;
const
  CResults: array[Boolean] of HResult = (S_FALSE, S_OK);
begin
  FFileName := '';
  FShellItem := psiFolder;
  Result := GetItemName(FShellItem, FFileName);
  if Succeeded(Result) then
    Result := CResults[DoOnFolderChanging];
  FShellItem := nil;
end;

                                                                    
function TCustomFileDialog.GetDefaultFolder: WideString;
begin
  Result := FDefaultFolder;
end;

                                                                    
function TCustomFileDialog.GetFileName: TWideFileName;
begin
  Result := FFileName;
end;

function TCustomFileDialog.GetFileNames(Items: IShellItemArray): HResult;
var
  Count: Integer;
  LShellItem: IShellItem;
  LEnumerator: IEnumShellItems;
begin
  Files.Clear;
  Result := Items.EnumItems(LEnumerator);
  if Succeeded(Result) then
  begin
    Result := LEnumerator.Next(1, LShellItem, @Count);
    while Succeeded(Result) and (Count <> 0) do
    begin
      GetItemName(LShellItem, FFileName);
      Files.Add(FFileName);
      Result := LEnumerator.Next(1, LShellItem, @Count);
    end;
    if Files.Count > 0 then
      FFileName := Files[0];
  end;
end;

                                                                    
function TCustomFileDialog.GetFiles: TTntStrings;
begin
  Result := FFiles;
end;

function TCustomFileDialog.GetItemName(Item: IShellItem; var ItemName: TWideFileName): HResult;
var
  pszItemName: PWideChar;
begin
  Result := Item.GetDisplayName(SIGDN_FILESYSPATH, pszItemName);
  if Failed(Result) then
    Result := Item.GetDisplayName(SIGDN_NORMALDISPLAY, pszItemName);
  if Succeeded(Result) then
  try
    ItemName := pszItemName;
  finally
    CoTaskMemFree(pszItemName);
  end;
end;

function TCustomFileDialog.GetResults: HResult;
begin
  Result := FDialog.GetResult(FShellItem);
  if Succeeded(Result) then
  begin
    Result := GetItemName(FShellItem, FFileName);
    FFiles.Clear;
    FFiles.Add(FFileName);
  end;
end;

procedure TCustomFileDialog.GetWindowHandle;
var
  LOleWindow: IOleWindow;
begin
  if Supports(FDialog, IOleWindow, LOleWindow) then
    LOleWindow.GetWindow(FHandle);
end;

function TCustomFileDialog.Overwrite(psiFile: IShellItem; var Response: Cardinal): HResult;
var
  LResponse: TFileDialogOverwriteResponse;
begin
  FFileName := '';
  LResponse := forAccept;
  FShellItem := psiFile;
  Result := GetItemName(FShellItem, FFileName);
  if Succeeded(Result) then
    DoOnOverwrite(LResponse);
  Response := Cardinal(LResponse);
  FShellItem := nil;
end;

function TCustomFileDialog.SelectionChange: HResult;
begin
  FFileName := '';
  Result := FDialog.GetCurrentSelection(FShellItem);
  if Succeeded(Result) then
  begin
    Result := GetItemName(FShellItem, FFileName);
    if Succeeded(Result) then
      DoOnSelectionChange;
  end;
  FShellItem := nil;
end;

procedure TCustomFileDialog.SetClientGuid(const Value: string);
begin
  if Value <> FClientGuid then
  begin
    if Value <> '' then
      StringToGUID(Value);
    FClientGuid := Value;
  end;
end;

                                                                    
procedure TCustomFileDialog.SetDefaultFolder(const Value: WideString);
begin
  if FDefaultFolder <> Value then
    FDefaultFolder := Value;
end;

                                                                    
procedure TCustomFileDialog.SetFileName(const Value: TWideFileName);
begin
  if Value <> FFileName then
    FFileName := Value;
end;

procedure TCustomFileDialog.SetFileTypes(const Value: TFileTypeItems);
begin
  if Value <> nil then
    FFileTypes.Assign(Value);
end;

                                                                    
procedure TCustomFileDialog.SetFavoriteLinks(const Value: TFavoriteLinkItems);
begin
  if Value <> nil then
    FFavoriteLinks.Assign(Value);
end;

function TCustomFileDialog.ShareViolation(psiFile: IShellItem;
  var Response: Cardinal): HResult;
var
  LResponse: TFileDialogShareViolationResponse;
begin
  FFileName := '';
  LResponse := fsrAccept;
  FShellItem := psiFile;
  Result := GetItemName(FShellItem, FFileName);
  if Succeeded(Result) then
    DoOnShareViolation(LResponse);
  Response := Cardinal(LResponse);
  FShellItem := nil;
end;

function TCustomFileDialog.TypeChange: HResult;
begin
  Result := FDialog.GetFileTypeIndex(FFileTypeIndex);
  if Succeeded(Result) then
    DoOnTypeChange;
end;

{ TCustomFileOpenDialog }

function TCustomFileOpenDialog.CreateFileDialog: IFileDialog;
begin
  CoCreateInstance(CLSID_FileOpenDialog, nil, CLSCTX_INPROC_SERVER,
    IFileOpenDialog, Result);
end;

function TCustomFileOpenDialog.GetResults: HResult;
begin
  if not (fdoAllowMultiSelect in Options) then
    Result := inherited GetResults
  else
  begin
    Result := (Dialog as IFileOpenDialog).GetResults(FShellItems);
    if Succeeded(Result) then
      Result := GetFileNames(FShellItems);
  end;
end;

function TCustomFileOpenDialog.SelectionChange: HResult;
begin
  if not (fdoAllowMultiSelect in Options) then
    Result := inherited SelectionChange
  else
  begin
    Result := (Dialog as IFileOpenDialog).GetSelectedItems(FShellItems);
    if Succeeded(Result) then
    begin
      Result := GetFileNames(FShellItems);
      if Succeeded(Result) then
      begin
        Dialog.GetCurrentSelection(FShellItem);
        DoOnSelectionChange;
      end;
      FShellItems := nil;
    end;
  end;
end;

{ TCustomFileSaveDialog }

function TCustomFileSaveDialog.CreateFileDialog: IFileDialog;
begin
  CoCreateInstance(CLSID_FileSaveDialog, nil, CLSCTX_INPROC_SERVER,
    IFileSaveDialog, Result);
end;

{ Initialization and cleanup }

procedure InitGlobals;
var
  AtomText: array[0..31] of Char;
begin
  HelpMsg := RegisterWindowMessage(HelpMsgString);
  FindMsg := RegisterWindowMessage(FindMsgString);
  WndProcPtrAtom := GlobalAddAtom(StrFmt(AtomText,
    'WndProcPtr%.8X%.8X', [HInstance, GetCurrentThreadID]));
end;

initialization
  InitGlobals;
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TTntCommonDialog, TControl);
finalization
  if WndProcPtrAtom <> 0 then GlobalDeleteAtom(WndProcPtrAtom);

{$ENDIF}
end.
