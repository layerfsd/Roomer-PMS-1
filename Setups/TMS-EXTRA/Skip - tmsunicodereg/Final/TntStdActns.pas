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

unit TntStdActns;

{$INCLUDE TntCompilers.inc}

{$IFDEF DELPHI_UNICODE}

interface

uses
  StdActns;

type
  TTntHintAction = THintAction;
  TTntEditAction = TEditAction;
  TTntEditCut = TEditCut;
  TTntEditCopy = TEditCopy;                                                           
  TTntEditPaste = TEditPaste;                                                         
  TTntEditSelectAll = TEditSelectAll;                                                 
  TTntEditUndo = TEditUndo;                                                           
  TTntEditDelete = TEditDelete;                                                       
  TTntWindowAction = TWindowAction;                                                   
  TTntWindowClose = TWindowClose;                                                     
  TTntWindowCascade = TWindowCascade;                                                 
  TTntWindowTileHorizontal = TWindowTileHorizontal;                                   
  TTntWindowTileVertical = TWindowTileVertical;                                       
  TTntWindowMinimizeAll = TWindowMinimizeAll;                                         
  TTntWindowArrange = TWindowArrange;                                                 
  TTntHelpAction = THelpAction;                                                       
  TTntHelpContents = THelpContents;                                                   
  TTntHelpTopicSearch = THelpTopicSearch;                                             
  TTntHelpOnHelp = THelpOnHelp;                                                       
  TTntHelpContextAction = THelpContextAction;                                         
  TTntCommonDialogAction = TCommonDialogAction;                                       
  TTntFileAction = TFileAction;                                                       
  TTntFileOpen = TFileOpen;                                                           
  TTntFileOpenWith = TFileOpenWith;                                                   
  TTntFileSaveAs = TFileSaveAs;                                                       
  TTntFilePrintSetup = TFilePrintSetup;                                               
  TTntFilePageSetup = TFilePageSetup;                                                 
  TTntFileExit = TFileExit;                                                           
  TTntSearchAction = TSearchAction;                                                   
  TTntSearchFind = TSearchFind;                                                       
  TTntSearchReplace = TSearchReplace;                                                 
  TTntSearchFindFirst = TSearchFindFirst;                                             
  TTntSearchFindNext = TSearchFindNext;                                               
  TTntFontEdit = TFontEdit;                                                           
  TTntColorSelect = TColorSelect;                                                     
  TTntPrintDlg = TPrintDlg;                                                           

implementation

{$ENDIF}


{$IFNDEF DELPHI_UNICODE}

interface

uses
  Classes, ActnList, TntActnList, StdActns, TntDialogs, StdCtrls, Forms,
  TntWideStrUtils, TntSysUtils, Windows, TntControls;

type
{TNT-WARN THintAction}
  TTntHintAction = class(THintAction{TNT-ALLOW THintAction}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  public
    property Caption: WideString read GetCaption write SetCaption;
  published
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TEditAction}
  TTntEditAction = class(TEditAction{TNT-ALLOW TEditAction}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TEditCut}
  TTntEditCut = class(TEditCut{TNT-ALLOW TEditCut}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TEditCopy}
  TTntEditCopy = class(TEditCopy{TNT-ALLOW TEditCopy}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TEditPaste}
  TTntEditPaste = class(TEditPaste{TNT-ALLOW TEditPaste}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TEditSelectAll}
  TTntEditSelectAll = class(TEditSelectAll{TNT-ALLOW TEditSelectAll}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TEditUndo}
  TTntEditUndo = class(TEditUndo{TNT-ALLOW TEditUndo}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TEditDelete}
  TTntEditDelete = class(TEditDelete{TNT-ALLOW TEditDelete}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TWindowAction}
  TTntWindowAction = class(TWindowAction{TNT-ALLOW TWindowAction}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TWindowClose}
  TTntWindowClose = class(TWindowClose{TNT-ALLOW TWindowClose}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TWindowCascade}
  TTntWindowCascade = class(TWindowCascade{TNT-ALLOW TWindowCascade}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TWindowTileHorizontal}
  TTntWindowTileHorizontal = class(TWindowTileHorizontal{TNT-ALLOW TWindowTileHorizontal}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TWindowTileVertical}
  TTntWindowTileVertical = class(TWindowTileVertical{TNT-ALLOW TWindowTileVertical}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TWindowMinimizeAll}
  TTntWindowMinimizeAll = class(TWindowMinimizeAll{TNT-ALLOW TWindowMinimizeAll}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TWindowArrange}
  TTntWindowArrange = class(TWindowArrange{TNT-ALLOW TWindowArrange}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN THelpAction}
  TTntHelpAction = class(THelpAction{TNT-ALLOW THelpAction}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN THelpContents}
  TTntHelpContents = class(THelpContents{TNT-ALLOW THelpContents}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN THelpTopicSearch}
  TTntHelpTopicSearch = class(THelpTopicSearch{TNT-ALLOW THelpTopicSearch}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN THelpOnHelp}
  TTntHelpOnHelp = class(THelpOnHelp{TNT-ALLOW THelpOnHelp}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN THelpContextAction}
  TTntHelpContextAction = class(THelpContextAction{TNT-ALLOW THelpContextAction}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

  TTntCommonDialogClass = class of TTntCommonDialog;

{TNT-WARN TCommonDialogAction}
  TTntCommonDialogAction = class(TCustomAction{TNT-ALLOW TCommonDialogAction}, ITntAction)
  private
    FExecuteResult: Boolean;
    FOnAccept: TNotifyEvent;
    FOnCancel: TNotifyEvent;
    FBeforeExecute: TNotifyEvent;
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    FDialog: TTntCommonDialog;
    procedure DoAccept;
    procedure DoCancel;
    function GetDialogClass: TTntCommonDialogClass; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetupDialog;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
    property ExecuteResult: Boolean read FExecuteResult;
    property BeforeExecute: TNotifyEvent read FBeforeExecute write FBeforeExecute;
    property OnAccept: TNotifyEvent read FOnAccept write FOnAccept;
    property OnCancel: TNotifyEvent read FOnCancel write FOnCancel;
  public
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TFileAction}
  TTntFileAction = class(TFileAction{TNT-ALLOW TFileAction}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  public
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TFileOpen}
  TTntFileOpen = class(TFileOpen{TNT-ALLOW TFileOpen}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function GetDialog: TTntOpenDialog;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetDialogClass: TCommonDialogClass; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Dialog: TTntOpenDialog read GetDialog;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TFileOpenWith}
  TTntFileOpenWith = class(TFileOpenWith{TNT-ALLOW TFileOpenWith}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function GetDialog: TTntOpenDialog;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetDialogClass: TCommonDialogClass; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Dialog: TTntOpenDialog read GetDialog;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TFileSaveAs}
  TTntFileSaveAs = class(TFileSaveAs{TNT-ALLOW TFileSaveAs}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    function GetDialog: TTntSaveDialog;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetDialogClass: TCommonDialogClass; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Dialog: TTntSaveDialog read GetDialog;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TFilePrintSetup}
  TTntFilePrintSetup = class(TFilePrintSetup{TNT-ALLOW TFilePrintSetup}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

  {$IFDEF COMPILER_7_UP}
{TNT-WARN TFilePageSetup}
  TTntFilePageSetup = class(TFilePageSetup{TNT-ALLOW TFilePageSetup}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;
  {$ENDIF}

{TNT-WARN TFileExit}
  TTntFileExit = class(TFileExit{TNT-ALLOW TFileExit}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TSearchAction}
  TTntSearchAction = class(TTntCommonDialogAction{TNT-ALLOW TSearchAction}, ITntAction)
  protected
    FControl: TCustomEdit;
    FFindFirst: Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure Search(Sender: TObject); virtual;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

{TNT-WARN TSearchFind}
  TTntSearchFind = class(TTntSearchAction{TNT-ALLOW TSearchFind}, ITntAction)
  private
    function GetFindDialog: TTntFindDialog;
  protected
    function GetDialogClass: TTntCommonDialogClass; override;
  published
    property Caption;
    property Dialog: TTntFindDialog read GetFindDialog;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property BeforeExecute;
    property OnAccept;
    property OnCancel;
    property OnHint;
  end;

{TNT-WARN TSearchReplace}
  TTntSearchReplace = class(TTntSearchAction{TNT-ALLOW TSearchReplace}, ITntAction)
  private
    procedure Replace(Sender: TObject);
    function GetReplaceDialog: TTntReplaceDialog;
  protected
    function GetDialogClass: TTntCommonDialogClass; override;
  public
    procedure ExecuteTarget(Target: TObject); override;
  published
    property Caption;
    property Dialog: TTntReplaceDialog read GetReplaceDialog;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property BeforeExecute;
    property OnAccept;
    property OnCancel;
    property OnHint;
  end;

{TNT-WARN TSearchFindFirst}
  TTntSearchFindFirst = class(TTntSearchFind{TNT-ALLOW TSearchFindFirst}, ITntAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

{TNT-WARN TSearchFindNext}
  TTntSearchFindNext = class(TCustomAction{TNT-ALLOW TSearchFindNext}, ITntAction)
  private
    FSearchFind: TTntSearchFind;
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property ImageIndex;
    property SearchFind: TTntSearchFind read FSearchFind write FSearchFind;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property OnHint;
  end;

{TNT-WARN TFontEdit}
  TTntFontEdit = class(TFontEdit{TNT-ALLOW TFontEdit}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TColorSelect}
  TTntColorSelect = class(TColorSelect{TNT-ALLOW TColorSelect}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

{TNT-WARN TPrintDlg}
  TTntPrintDlg = class(TPrintDlg{TNT-ALLOW TPrintDlg}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

procedure TntStdActn_AfterInherited_Assign(Action: TCustomAction{TNT-ALLOW TCustomAction}; Source: TPersistent);

implementation

uses
  Dialogs, TntClasses, SysUtils, Consts;

{TNT-IGNORE-UNIT}

procedure TntStdActn_AfterInherited_Assign(Action: TCustomAction{TNT-ALLOW TCustomAction}; Source: TPersistent);
begin
  TntAction_AfterInherited_Assign(Action, Source);
  // TCommonDialogAction
  if (Action is TCommonDialogAction) and (Source is TCommonDialogAction) then begin
    TCommonDialogAction(Action).BeforeExecute := TCommonDialogAction(Source).BeforeExecute;
    TCommonDialogAction(Action).OnAccept      := TCommonDialogAction(Source).OnAccept;
    TCommonDialogAction(Action).OnCancel      := TCommonDialogAction(Source).OnCancel;
  end;
  // TFileOpen
  if (Action is TFileOpen) and (Source is TFileOpen) then begin
    {$IFDEF COMPILER_7_UP}
    TFileOpen(Action).UseDefaultApp := TFileOpen(Source).UseDefaultApp;
    {$ENDIF}
  end;
  // TFileOpenWith
  if (Action is TFileOpenWith) and (Source is TFileOpenWith) then begin
    TFileOpenWith(Action).FileName  := TFileOpenWith(Source).FileName;
    {$IFDEF COMPILER_7_UP}
    TFileOpenWith(Action).AfterOpen := TFileOpenWith(Source).AfterOpen;
    {$ENDIF}
  end;
  // TSearchFindNext
  if (Action is TSearchFindNext) and (Source is TSearchFindNext) then begin
    TSearchFindNext(Action).SearchFind := TSearchFindNext(Source).SearchFind;
  end;
end;

//-------------------------
//    TNT STD ACTNS
//-------------------------

{ TTntHintAction }

procedure TTntHintAction.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntHintAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntHintAction.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntHintAction.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntHintAction.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntHintAction.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntEditAction }

procedure TTntEditAction.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntEditAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntEditAction.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntEditAction.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntEditAction.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntEditAction.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntEditCut }

procedure TTntEditCut.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntEditCut.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntEditCut.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntEditCut.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntEditCut.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntEditCut.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntEditCopy }

procedure TTntEditCopy.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntEditCopy.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntEditCopy.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntEditCopy.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntEditCopy.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntEditCopy.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntEditPaste }

procedure TTntEditPaste.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntEditPaste.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntEditPaste.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntEditPaste.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntEditPaste.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntEditPaste.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntEditSelectAll }

procedure TTntEditSelectAll.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntEditSelectAll.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntEditSelectAll.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntEditSelectAll.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntEditSelectAll.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntEditSelectAll.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntEditUndo }

procedure TTntEditUndo.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntEditUndo.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntEditUndo.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntEditUndo.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntEditUndo.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntEditUndo.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntEditDelete }

procedure TTntEditDelete.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntEditDelete.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntEditDelete.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntEditDelete.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntEditDelete.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntEditDelete.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

procedure TTntEditDelete.UpdateTarget(Target: TObject);
begin
  Enabled := True;
end;

procedure TTntEditDelete.ExecuteTarget(Target: TObject);
begin
  if GetControl(Target).SelLength = 0 then
    GetControl(Target).SelLength := 1;
  GetControl(Target).ClearSelection
end;

{ TTntWindowAction }

procedure TTntWindowAction.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntWindowAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntWindowAction.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntWindowAction.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntWindowAction.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntWindowAction.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntWindowClose }

procedure TTntWindowClose.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntWindowClose.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntWindowClose.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntWindowClose.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntWindowClose.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntWindowClose.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntWindowCascade }

procedure TTntWindowCascade.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntWindowCascade.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntWindowCascade.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntWindowCascade.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntWindowCascade.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntWindowCascade.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntWindowTileHorizontal }

procedure TTntWindowTileHorizontal.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntWindowTileHorizontal.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntWindowTileHorizontal.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntWindowTileHorizontal.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntWindowTileHorizontal.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntWindowTileHorizontal.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntWindowTileVertical }

procedure TTntWindowTileVertical.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntWindowTileVertical.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntWindowTileVertical.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntWindowTileVertical.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntWindowTileVertical.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntWindowTileVertical.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntWindowMinimizeAll }

procedure TTntWindowMinimizeAll.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntWindowMinimizeAll.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntWindowMinimizeAll.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntWindowMinimizeAll.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntWindowMinimizeAll.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntWindowMinimizeAll.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntWindowArrange }

procedure TTntWindowArrange.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntWindowArrange.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntWindowArrange.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntWindowArrange.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntWindowArrange.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntWindowArrange.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntHelpAction }

procedure TTntHelpAction.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntHelpAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntHelpAction.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntHelpAction.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntHelpAction.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntHelpAction.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntHelpContents }

procedure TTntHelpContents.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntHelpContents.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntHelpContents.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntHelpContents.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntHelpContents.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntHelpContents.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntHelpTopicSearch }

procedure TTntHelpTopicSearch.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntHelpTopicSearch.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntHelpTopicSearch.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntHelpTopicSearch.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntHelpTopicSearch.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntHelpTopicSearch.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntHelpOnHelp }

procedure TTntHelpOnHelp.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntHelpOnHelp.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntHelpOnHelp.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntHelpOnHelp.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntHelpOnHelp.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntHelpOnHelp.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntHelpContextAction }

procedure TTntHelpContextAction.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntHelpContextAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntHelpContextAction.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntHelpContextAction.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntHelpContextAction.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntHelpContextAction.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntCommonDialogAction }

procedure TTntCommonDialogAction.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

constructor TTntCommonDialogAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetupDialog;
  DisableIfNoHandler := False;
  Enabled := True;
end;

destructor TTntCommonDialogAction.Destroy;
begin
  if Assigned(FDialog) then
    FDialog.RemoveFreeNotification(Self);
  inherited;
end;

procedure TTntCommonDialogAction.DoAccept;
begin
  if Assigned(FOnAccept) then FOnAccept(Self);
end;

procedure TTntCommonDialogAction.DoCancel;
begin
  if Assigned(FOnCancel) then FOnCancel(Self);
end;

procedure TTntCommonDialogAction.ExecuteTarget(Target: TObject);
begin
  FExecuteResult := False;
  if Assigned(FDialog) then
  begin
    if Assigned(FBeforeExecute) then
      FBeforeExecute(Self);
    FExecuteResult := FDialog.Execute;
    if FExecuteResult then
      DoAccept
    else
      DoCancel;
  end;
end;

function TTntCommonDialogAction.GetDialogClass: TTntCommonDialogClass;
begin
  Result := nil;
end;

function TTntCommonDialogAction.Handlestarget(Target: TObject): Boolean;
begin
  Result := True;
end;

procedure TTntCommonDialogAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if not (csDestroying in ComponentState) and (Operation = opRemove) and
     (AComponent = FDialog) then
    SetupDialog;
end;

procedure TTntCommonDialogAction.SetupDialog;
var
  DialogClass: TTntCommonDialogClass;
begin
  DialogClass := GetDialogClass;
  if Assigned(DialogClass) then
  begin
    FDialog := DialogClass.Create(Self);
    FDialog.Name := Copy(DialogClass.ClassName, 2, Length(DialogClass.ClassName));
    FDialog.SetSubComponent(True);
    FDialog.FreeNotification(Self);
  end;
end;

procedure TTntCommonDialogAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntCommonDialogAction.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntCommonDialogAction.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntCommonDialogAction.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntCommonDialogAction.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntFileAction }

procedure TTntFileAction.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntFileAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntFileAction.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntFileAction.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntFileAction.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntFileAction.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntFileOpen }

procedure TTntFileOpen.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntFileOpen.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntFileOpen.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntFileOpen.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntFileOpen.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntFileOpen.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

function TTntFileOpen.GetDialog: TTntOpenDialog;
begin
  Result := inherited Dialog as TTntOpenDialog;
end;

function TTntFileOpen.GetDialogClass: TCommonDialogClass;
begin
  Result := TTntOpenDialog;
end;

{ TTntFileOpenWith }

procedure TTntFileOpenWith.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntFileOpenWith.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntFileOpenWith.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntFileOpenWith.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntFileOpenWith.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntFileOpenWith.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

function TTntFileOpenWith.GetDialog: TTntOpenDialog;
begin
  Result := inherited Dialog as TTntOpenDialog;
end;

function TTntFileOpenWith.GetDialogClass: TCommonDialogClass;
begin
  Result := TTntOpenDialog;
end;

{ TTntFileSaveAs }

procedure TTntFileSaveAs.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntFileSaveAs.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntFileSaveAs.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntFileSaveAs.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntFileSaveAs.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntFileSaveAs.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

function TTntFileSaveAs.GetDialog: TTntSaveDialog;
begin
  Result := TOpenDialog(inherited Dialog) as TTntSaveDialog;
end;

function TTntFileSaveAs.GetDialogClass: TCommonDialogClass;
begin
  Result := TTntSaveDialog;
end;

{ TTntFilePrintSetup }

procedure TTntFilePrintSetup.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntFilePrintSetup.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntFilePrintSetup.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntFilePrintSetup.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntFilePrintSetup.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntFilePrintSetup.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

 {$IFDEF COMPILER_7_UP}

{ TTntFilePageSetup }

procedure TTntFilePageSetup.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntFilePageSetup.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntFilePageSetup.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntFilePageSetup.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntFilePageSetup.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntFilePageSetup.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;
 {$ENDIF}

{ TTntFileExit }

procedure TTntFileExit.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntFileExit.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntFileExit.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntFileExit.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntFileExit.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntFileExit.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

function SearchEdit(EditControl: TCustomEdit; const SearchString: WideString;
  Options: TFindOptions; FindFirst: Boolean = False): Boolean;
var
  {Buffer,} P: PWideChar;
  buf: WideString;
  Size: Word;
  SearchOptions: TStringSearchOptions;
begin
  Result := False;
  if (Length(SearchString) = 0) then Exit;
  Size := EditControl.GetTextLen;
  if (Size = 0) then Exit;
  //Buffer := WStrAlloc(Size + 1);
  try
    SearchOptions := [];
    if frDown in Options then
      Include(SearchOptions, soDown);
    if frMatchCase in Options then
      Include(SearchOptions, soMatchCase);
    if frWholeWord in Options then
      Include(SearchOptions, soWholeWord);
    //EditControl.GetTextBuf(Buffer, Size + 1);

    //Buffer := WStrAlloc(GetWindowTextLengthW(EditControl.Handle) + 1);

    {SetLength(Buf, GetWindowTextLengthW(EditControl.Handle) + 1);
    GetWindowTextW(EditControl.Handle, PWideChar(Buf), Length(Buf));
    SetLength(Buf, Length(Buf) - 1); }
    Buf := TntControl_GetText(EditControl);

    if (EditControl.ClassName = 'TTntRichEdit') then   // FF: RichEdit
      Buf := TntAdjustLineBreaks(Buf, tlbsCR);
      
    //Buffer := PWideChar(Buf);
    if FindFirst then
      P := SearchBuf(PWideChar(Buf), Length(Buf), 0, EditControl.SelLength,
             SearchString, SearchOptions)
    else
      P := SearchBuf(PWideChar(Buf), Length(Buf), EditControl.SelStart, EditControl.SelLength,
             SearchString, SearchOptions);
    if P <> nil then
    begin
      EditControl.SelStart := P - PWideChar(Buf);
      EditControl.SelLength := Length(SearchString);
      Result := True;
    end;
  finally
    //WStrDispose(Buffer);
  end;
end;

{ TTntSearchAction }

constructor TTntSearchAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TTntFindDialog(FDialog).OnFind := Search;
  FFindFirst := False;
end;

destructor TTntSearchAction.Destroy;
begin
  if Assigned(FControl) then
    FControl.RemoveFreeNotification(Self);
  inherited;
end;

procedure TTntSearchAction.ExecuteTarget(Target: TObject);
begin
  FControl := TCustomEdit(Target);
  if Assigned(FControl) then
    FControl.FreeNotification(Self);
  inherited ExecuteTarget(Target);
end;

function TTntSearchAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := Screen.ActiveControl is TCustomEdit;
  if not Result then
    Enabled := False;
end;

procedure TTntSearchAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then
    FControl := nil;
end;

procedure TTntSearchAction.Search(Sender: TObject);
begin
  // FControl gets set in ExecuteTarget
  if Assigned(FControl) then
    if not SearchEdit(FControl, TTntFindDialog(FDialog).FindText,
       TTntFindDialog(FDialog).Options, FFindFirst) then
{$IFNDEF COMPILER_9_UP}
      WideShowMessage(Tnt_WideFormat(STextNotFound, [TTntFindDialog(FDialog).FindText]));
{$ELSE}
      WideShowMessage(WideFormat(STextNotFound, [TTntFindDialog(FDialog).FindText]));
{$ENDIF}
end;

procedure TTntSearchAction.UpdateTarget(Target: TObject);
begin
  Enabled := Target is TCustomEdit and (TCustomEdit(Target).GetTextLen > 0);
end;

{ TTntSearchFind }

function TTntSearchFind.GetDialogClass: TTntCommonDialogClass;
begin
  Result := TTntFindDialog;
end;

function TTntSearchFind.GetFindDialog: TTntFindDialog;
begin
  Result := TTntFindDialog(FDialog);
end;

{ TTntSearchReplace }

procedure TTntSearchReplace.ExecuteTarget(Target: TObject);
begin
  inherited ExecuteTarget(Target);
  TTntReplaceDialog(FDialog).OnReplace := Replace;
end;

function TTntSearchReplace.GetDialogClass: TTntCommonDialogClass;
begin
  Result := TTntReplaceDialog;
end;

function TTntSearchReplace.GetReplaceDialog: TTntReplaceDialog;
begin
  Result := TTntReplaceDialog(FDialog);
end;

procedure TTntSearchReplace.Replace(Sender: TObject);
var
  Found: Boolean;
  FoundCount: Integer;
begin
  // FControl gets set in ExecuteTarget
  Found := False;
  FoundCount := 0;
  if Assigned(FControl) then
    with Sender as TTntReplaceDialog do
    begin
      if (Length(FControl.SelText) > 0) and
         (not (frReplaceAll in Dialog.Options) and
         (WideCompareText(FControl.SelText, FindText) = 0) or
         (frReplaceAll in Dialog.Options) and (FControl.SelText = FindText)) then
      begin
        //FControl.SelText := ReplaceText;
        Tnt_ReplaceSelection(FControl, ReplaceText);
        SearchEdit(FControl, Dialog.FindText, Dialog.Options, FFindFirst);
        if not (frReplaceAll in Dialog.Options) then exit;
      end;
      repeat
        Found := SearchEdit(FControl, Dialog.FindText, Dialog.Options, FFindFirst);
        if Found then
        begin
          //FControl.SelText := ReplaceText;
          Tnt_ReplaceSelection(FControl, ReplaceText);
          Inc(FoundCount);
        end;
      until not Found or not (frReplaceAll in Dialog.Options);
    end;
  if not Found and (FoundCount = 0) then
{$IFNDEF COMPILER_9_UP}
    WideShowMessage(Tnt_WideFormat(STextNotFound, [Dialog.FindText]));
{$ELSE}
    WideShowMessage(WideFormat(STextNotFound, [Dialog.FindText]));
{$ENDIF}    
end;

{ TTntSearchFindFirst }

constructor TTntSearchFindFirst.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFindFirst := True;
end;

{ TTntSearchFindNext }

procedure TTntSearchFindNext.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

constructor TTntSearchFindNext.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DisableIfNoHandler := False;
end;

procedure TTntSearchFindNext.ExecuteTarget(Target: TObject);
begin
  FSearchFind.FControl := TCustomEdit(Target);
  if not Assigned(FSearchFind) then exit;
  FSearchFind.Search(Target);
end;

function TTntSearchFindNext.HandlesTarget(Target: TObject): Boolean;
begin
  Result := Assigned(FSearchFind) and FSearchFind.Enabled and
    (Length(TTntFindDialog(FSearchFind.Dialog).FindText) <> 0);
  Enabled := Result;
end;

procedure TTntSearchFindNext.UpdateTarget(Target: TObject);
begin
  if Assigned(FSearchFind) then
    Enabled := FSearchFind.Enabled and (Length(TTntFindDialog(FSearchFind.Dialog).FindText) <> 0)
  else
    Enabled := False;
end;

procedure TTntSearchFindNext.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntSearchFindNext.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntSearchFindNext.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntSearchFindNext.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntSearchFindNext.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntFontEdit }

procedure TTntFontEdit.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntFontEdit.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntFontEdit.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntFontEdit.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntFontEdit.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntFontEdit.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntColorSelect }

procedure TTntColorSelect.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntColorSelect.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntColorSelect.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntColorSelect.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntColorSelect.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntColorSelect.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntPrintDlg }

procedure TTntPrintDlg.Assign(Source: TPersistent);
begin
  inherited;
  TntStdActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntPrintDlg.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntPrintDlg.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntPrintDlg.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntPrintDlg.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntPrintDlg.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{$ENDIF}

end.
