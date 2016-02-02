{ Open source project MSHTML Editor 16-04-2012 ver. 4.1 for ocx ver. 2.0 and above

  This editor is build from a DHTML edit OSP from 16-05-1999 found at:
  delphi-dhtmledit@yahoogroups.com
  http://groups.yahoo.com/group/delphi-dhtmledit/files/DHTMLEdit/DHTML.zip
  (look in the file section)                       

  This update editor is created by Kurt Senfer
  "Copyright (C) 2002-2012  Kurt Senfer <KSDhtmlEdit@Gmail.com>"

  The code in this package is released under:
  GNU Lesser General Public License - http://www.gnu.org/licenses/lgpl-2.1.html

  Except fore the original source as it is implemented in the original OSP,
  witch have the same copyright status as found in the original package DHTML.zip.

  I have often, in various mails on the delphi-dhtmledit list, pointed out that
  The DHTMLEdit component is just a wrapper around the MSHTML engine - the
  Wrapper contains coding that enables additional features like:
     Table operations (insert row, insert column, merge cells, and so on).
     Absolute drop mode.
     Source code white space and formatting preservation.
     Custom Editing Glyphs.
     ........


  Replacing DHTMLEdit with the MSHTML engine (or as in this case with the
  KSDhtmlEdit.OCX component) means that you need to code a few features, like
  source code preservation, witch is build in features in DHTMLEdit, yourself.

  I chased to create a wrapper around MSHTML and named it:
  TEmbeddedED ~ Embedded EDitor
  TEmbeddedED implements all the code you need to replace the DHTML Component
  (exept for a few seldom needed features) and it offers a lot of features never
  found in DHTML Edit. The main reason for encapsulating all that code in a
  component is that its easy to update existing editor projects with
  new features (in new versions of KSDhtmlEdit).


  This is a short listing of the main things you have to do in order to skip
  DHTMLEdit in favour of the HMHTML engine in your own DHTMLEdit project.

  - Replace TDHTMLEdit with MSHTML
  - Call the existing DHTMLEditDisplayChanged from a new "OnUpdateUI function"
  - Implement Custom Editing Glyphs
  - Implement IHTMLEditDesigner
  - Implement IHTMLEditHost
  - Implemet code to handle the table stuff
  - Implemet code to handle the position stuff
}


unit RoomerHtmlEditor;
{$I KSED.INC} //Compiler version directives

{.$DEFINE AddictSpell}
{$DEFINE NoBOMShow}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, OleCtrls,
  StdCtrls, Buttons, ComCtrls, Menus, ExtCtrls, FmxUtils, ImgList,
  ToolWin, ActiveX, Db, DbTables,
  {$IFDEF AddictSpell}
     //if you get a compiler error heir out-comment / remove {$DEFINE AddictSpell} above
     ad3Spell, ad3Configuration,
  {$ENDIF}
  {$IFDEF Mshtml_TLB}
     // this compiler directive is out commented {.$DEFINE Mshtml_TLB} in KSED.inc
     // if you want to compile with Mshtml_TLB instead of MSHTML then remove the
     // dot in front of {.$DEFINE Mshtml_TLB}
     MSHTML_TLB,
  {$ELSE}
     MSHTML,
     {$IFDEF OldMSHTML}
        KS_Missing_In_MSHTML,
     {$ENDIF}
  {$ENDIF}
  {$IFDEF KSDHTMLEDLib_TLB}
      // this compiler directive is out commented {.$DEFINE KSDHTMLEDLib_TLB} in KSED.inc
      // if you want to compile with KSDHTMLEDLib_TLB instead of KSDHTMLED_TLB then
      // remove the dot in front of {.$DEFINE KSDHTMLEDLib_TLB}
      // But only if you are sure what you are doing !!
      KSDHTMLEDLib_TLB,
   {$ELSE}
      KSDHTMLED_TLB,
   {$ENDIF}

  KS_Procs,
  {$IFNDEF D2009UP}
      KS_RichEdit,
  {$ENDIF}
  KSEmbeddedEDx, acCoolBar, sToolBar, cxClasses, cxPropertiesStore;

type
  CmdID = TOleEnum;

  TGetInputArg = procedure(Sender: TObject; var pVarIn: OleVariant; var FuncResult: boolean) of object;
  TClearInputArg = procedure(Sender: TObject; var pVarIn: OleVariant) of object;
  TfrmOcxHtmlEditor = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    mnuFile: TMenuItem;
    mnuFileNew: TMenuItem;
    mnuFileOpen: TMenuItem;
    mnuFileSave: TMenuItem;
    mnuFileSaveAs: TMenuItem;
    N2: TMenuItem;
    mnuFilePrint: TMenuItem;
    mnuFilePageSetup: TMenuItem;
    N1: TMenuItem;
    mnuFileExit: TMenuItem;
    mnuInsert: TMenuItem;
    mnuTableInsertTable: TMenuItem;
    mnuInsertImage: TMenuItem;
    PopupMenu1: TPopupMenu;
    mnuEdit: TMenuItem;
    mnuEditDelete: TMenuItem;
    mnuEditCut: TMenuItem;
    mnuEditCopy: TMenuItem;
    mnuEditPaste: TMenuItem;
    mnuInsertHyperlink: TMenuItem;
    N3: TMenuItem;
    mnuEditUndo: TMenuItem;
    mnuEditRedo: TMenuItem;
    N4: TMenuItem;
    mnuEditSelectAll: TMenuItem;
    N5: TMenuItem;
    mnuEditUnlink: TMenuItem;
    mnuTable: TMenuItem;
    mnuTableInsertRow: TMenuItem;
    mnuTableInsertCol: TMenuItem;
    mnuTableInsetCell: TMenuItem;
    mnuTableDeleteRow: TMenuItem;
    mnuTableDeleteCol: TMenuItem;
    mnuTableDeleteCell: TMenuItem;
    N6: TMenuItem;
    mnuTableMergeCells: TMenuItem;
    mnuTableSplitCells: TMenuItem;
    ColorDialog: TColorDialog;
    mnuPosition: TMenuItem;
    mnuPositionAboveText: TMenuItem;
    mnuPositionBringForward: TMenuItem;
    mnuPositionBringtoFront: TMenuItem;
    mnuPositionBelowText: TMenuItem;
    mnuPositionSendtoBack: TMenuItem;
    mnuPositionSendBackward: TMenuItem;
    N7: TMenuItem;
    pmuUndo: TMenuItem;
    pmuRedo: TMenuItem;
    pmuCopy: TMenuItem;
    pmuPaste: TMenuItem;
    pmuCut: TMenuItem;
    pmuDelete: TMenuItem;
    pmuSelectAll: TMenuItem;
    pmuUnlink: TMenuItem;
    pmuHyperlink: TMenuItem;
    mnuPositionMakeAbsolute: TMenuItem;
    N8: TMenuItem;
    mnuFileProperties: TMenuItem;
    mnuHelpAbout: TMenuItem;
    N9: TMenuItem;
    mnuInsertHTML: TMenuItem;
    mnuPositionGridSettings: TMenuItem;
    PageControl1: TPageControl;
    tabEdit: TTabSheet;
    tabHTML: TTabSheet;
    tabPreview: TTabSheet;
    mnuEditRemoveTags: TMenuItem;
    mmoHTML: TMemo;
    CoolBar: TsCoolBar;
    tlb_Edit: TToolBar;
    btnNew: TToolButton;
    btnOpen: TToolButton;
    btnSave: TToolButton;
    ToolButton10: TToolButton;
    btnPrint: TToolButton;
    ToolButton9: TToolButton;
    btnCut: TToolButton;
    btnCopy: TToolButton;
    btnPaste: TToolButton;
    ToolButton1: TToolButton;
    btnUndo: TToolButton;
    btnRedo: TToolButton;
    tlb_Format: TToolBar;
    cmbStyles: TComboBox;
    ToolButton2: TToolButton;
    cmbFontName: TComboBox;
    ToolButton4: TToolButton;
    cmbFontSize: TComboBox;
    ToolButton6: TToolButton;
    btnFGColor: TToolButton;
    btnBGColor: TToolButton;
    ToolButton3: TToolButton;
    btnBold: TToolButton;
    btnItalic: TToolButton;
    btnUnderline: TToolButton;
    ToolButton7: TToolButton;
    btnAlignLeft: TToolButton;
    btnAlignCenter: TToolButton;
    btnAlignRight: TToolButton;
    ToolButton12: TToolButton;
    btnNumberedList: TToolButton;
    btnBulletedList: TToolButton;
    ToolButton15: TToolButton;
    btnIndentLeft: TToolButton;
    btnIndentRight: TToolButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ToolButton11: TToolButton;
    btnInsertTable: TToolButton;
    ToolButton5: TToolButton;
    btnInsertLink: TToolButton;
    ToolButton14: TToolButton;
    btnInsertImage: TToolButton;
    ToolButton17: TToolButton;
    btnFind: TToolButton;
    mnuHelp: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    mnuEditFind: TMenuItem;
    ToolButton8: TToolButton;
    btnMakeAbsolute: TToolButton;
    btnPrevInBrowser: TToolButton;
    ToolButton13: TToolButton;
    ImageList3: TImageList;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    tlb_Table: TToolBar;
    btnTableDelCol: TToolButton;
    btnTableInsCol: TToolButton;
    btnTableInsRow: TToolButton;
    btnTableDelRow: TToolButton;
    btnTableDelCell: TToolButton;
    btnTableInsCell: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    btnTableInTable: TToolButton;
    btnTableMergeCells: TToolButton;
    ToolButton28: TToolButton;
    btnTableTableSplitCells: TToolButton;
    mnuView: TMenuItem;
    mnuToolbar: TMenuItem;
    mnuViewtbl_Table: TMenuItem;
    mnuViewtbl_Edit: TMenuItem;
    mnuViewtbl_Format: TMenuItem;
    btnShowDetails: TToolButton;
    btnBorders: TToolButton;
    btnClearUndoStack: TToolButton;
    mnuPrintpreview: TMenuItem;
    PrintDialog1: TPrintDialog;
    btnFont: TToolButton;
    mnuLockElement: TMenuItem;
    N10: TMenuItem;
    mnuConstrainElement: TMenuItem;
    N15: TMenuItem;
    Edit: TKSEditX;
    N16: TMenuItem;
    mnuFormattablegrid: TMenuItem;
    btnEdit: TToolButton;
    N17: TMenuItem;
    mnuRefresh: TMenuItem;
    Testing1: TMenuItem;
    Assign1: TMenuItem;
    Gotowww1: TMenuItem;
    gotofile1: TMenuItem;
    SetBaseURLbad1: TMenuItem;
    SetBaseURLOK1: TMenuItem;
    KSTestEdit1: TToolButton;
    KSTestPreview: TToolButton;
    KSTestEdit2: TToolButton;
    Navigate1: TMenuItem;
    mnuOCXversion: TMenuItem;
    mnuUpdateUI: TMenuItem;
    mnuDrawsquare: TMenuItem;
    Printwithtemplate1: TMenuItem;
    mnuClassicsel: TMenuItem;
    tabFly: TTabSheet;
    Panel2: TPanel;
    CreateFly: TButton;
    LoadFile: TButton;
    InsImage: TButton;
    DestroyFly: TButton;
    ToolBar3: TsToolBar;
    ToUndo: TToolButton;
    ToolButton18: TToolButton;
    ToRedo: TToolButton;
    Preview: TKSEditX;
    Button1: TButton;
    mnuLinkto: TMenuItem;
    N18: TMenuItem;
    mnuKsxloadfromfile: TMenuItem;
    mnuKsxloadfromDB: TMenuItem;
    mnuhttpstreamingON: TMenuItem;
    mnuhttpstreamingOFF: TMenuItem;
    ksxinsertpicture1: TMenuItem;
    mnuSaveDocToDb: TMenuItem;
    N19: TMenuItem;
    mnuGetcaretposition: TMenuItem;
    mnuRestorecaretposition: TMenuItem;
    mnuDontdragme: TMenuItem;
    N21: TMenuItem;
    mnuLookforPleasedragme: TMenuItem;
    mnuLoadstreamtoDOC: TMenuItem;
    mnuSpelling: TMenuItem;
    mnuSpellSelect: TMenuItem;
    mnuSpellCur: TMenuItem;
    mnuSpellDoc: TMenuItem;
    mnuSpellOption: TMenuItem;
    mnuChecklive: TMenuItem;
    mnuLivecheckArea: TMenuItem;
    mnuGeCelltlist: TMenuItem;
    N22: TMenuItem;
    mnuTableSelCell: TMenuItem;
    mnuTableSelRow: TMenuItem;
    mnuTableSelColumn: TMenuItem;
    mnuTableSelTable: TMenuItem;
    mnuIscellselected: TMenuItem;
    mnuHighlightcells: TMenuItem;
    Create100: TButton;
    TabUniHTML: TTabSheet;
    Pagesetup1: TMenuItem;
    mnuLoadURL: TMenuItem;
    mnuPastepathsabsolute: TMenuItem;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    Button2: TButton;
    TreeView1: TTreeView;
    mnuRawHtml: TMenuItem;
    filestreamingON: TMenuItem;
    filestreamingOFF: TMenuItem;
    N23: TMenuItem;
    DefaultfiledropON: TMenuItem;
    DefaultfiledropOFF: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    WatchElementDeletion1: TMenuItem;
    N24: TMenuItem;
    StopWatching1: TMenuItem;
    Stopwatchingallelements1: TMenuItem;
    ToolButton16: TToolButton;
    btnShowAnchors: TToolButton;
    mnuTatablecells: TMenuItem;
    InsBookM: TMenuItem;
    EditBookM: TMenuItem;
    N25: TMenuItem;
    EditHTML: TMenuItem;
    N26: TMenuItem;
    mnuEditHTML: TMenuItem;
    mnuSpellDlgModal: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    mnuEdittableproperties: TMenuItem;
    mnuEditCellproperties: TMenuItem;
    N29: TMenuItem;
    Format1: TMenuItem;
    Bullets1: TMenuItem;
    Font1: TMenuItem;
    Borders1: TMenuItem;
    Nudgeelement1: TMenuItem;
    Bookmark1: TMenuItem;
    HorizontalRule1: TMenuItem;
    mnuRevisions: TMenuItem;
    mnuShowmarkedRevisions: TMenuItem;
    mnuMarkselectionasRevisions: TMenuItem;
    mnuClearselectedrvisionmarking: TMenuItem;
    Clearallrevisionmarkings1: TMenuItem;
    btnShowPagebrk: TToolButton;
    btnInsertPagebrk: TToolButton;
    btnRemovePagebrk: TToolButton;
    ToolButton22: TToolButton;
    Aboutnewfeatures1: TMenuItem;
    mnuAboutNewfeatures: TMenuItem;
    Testbookmarks1: TMenuItem;
    Watchforaccidentlydeletion1: TMenuItem;
    Managerevisionsmarking1: TMenuItem;
    Managepagebreaks1: TMenuItem;
    Changelanguage1: TMenuItem;
    Download1: TMenuItem;
    N30: TMenuItem;
    SetdocumenttoUnichar1: TMenuItem;
    Setdocumenttoutf81: TMenuItem;
    btnSaveToRoomer: TToolButton;
    ToolButton20: TToolButton;
    S1: TMenuItem;
    N31: TMenuItem;
    FormStore: TcxPropertiesStore;
    procedure EditDisplayChanged(Sender: TObject);
    procedure btnBoldClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnInsertImageClick(Sender: TObject);
    procedure btnItalicClick(Sender: TObject);
    procedure btnUnderlineClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure cmbFontNameChange(Sender: TObject);
    procedure cmbFontSizeChange(Sender: TObject);
    procedure cmbStylesChange(Sender: TObject);
    procedure mnuFileExitClick(Sender: TObject);
    procedure btnInsertTableClick(Sender: TObject);
    procedure mnuEditDeleteClick(Sender: TObject);
    procedure mnuEditCutClick(Sender: TObject);
    procedure mnuEditCopyClick(Sender: TObject);
    procedure mnuEditPasteClick(Sender: TObject);
    procedure btnInsertLinkClick(Sender: TObject);
    procedure btnAlignCenterClick(Sender: TObject);
    procedure btnAlignLeftClick(Sender: TObject);
    procedure btnAlignRightClick(Sender: TObject);
    procedure mnuEditRedoClick(Sender: TObject);
    procedure mnuEditUndoClick(Sender: TObject);
    procedure mnuEditSelectAllClick(Sender: TObject);
    procedure mnuEditUnlinkClick(Sender: TObject);
    procedure mnuTableInsertRowClick(Sender: TObject);
    procedure mnuTableInsertColClick(Sender: TObject);
    procedure mnuTableInsetCellClick(Sender: TObject);
    procedure mnuTableDeleteRowClick(Sender: TObject);
    procedure mnuTableDeleteColClick(Sender: TObject);
    procedure mnuTableDeleteCellClick(Sender: TObject);
    procedure btnFGColorClick(Sender: TObject);
    procedure mnuTableMergeCellsClick(Sender: TObject);
    procedure mnuTableSplitCellsClick(Sender: TObject);
    procedure btnIndentRightClick(Sender: TObject);
    procedure btnIndentLeftClick(Sender: TObject);
    procedure btnBulletedListClick(Sender: TObject);
    procedure btnNumberedListClick(Sender: TObject);
    procedure mnuPositionAboveTextClick(Sender: TObject);
    procedure mnuPositionBringForwardClick(Sender: TObject);
    procedure mnuPositionBringtoFrontClick(Sender: TObject);
    procedure mnuPositionBelowTextClick(Sender: TObject);
    procedure mnuPositionSendtoBackClick(Sender: TObject);
    procedure mnuPositionSendBackwardClick(Sender: TObject);
    procedure btnBGColorClick(Sender: TObject);
    procedure mnuPositionMakeAbsoluteClick(Sender: TObject);
    procedure mnuFilePropertiesClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure mnuHelpAboutClick(Sender: TObject);
    procedure mnuInsertHTMLClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure mnuPositionGridSettingsClick(Sender: TObject);
    procedure mnuFileSaveAsClick(Sender: TObject);
    procedure mnuEditRemoveTagsClick(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure btnPrevInBrowserClick(Sender: TObject);
    procedure mmoHTMLChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnuViewtbl_TableClick(Sender: TObject);
    procedure mnuViewtbl_FormatClick(Sender: TObject);
    procedure mnuViewtbl_EditClick(Sender: TObject);
    procedure EditDocumentComplete(Sender: TObject);
    procedure btnShowDetailsClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    function EditQueryService(const rsid, iid: TGUID; out Obj: IUnknown): HRESULT;
    procedure btnBordersClick(Sender: TObject);
    procedure btnClearUndoStackClick(Sender: TObject);
    procedure tlb_FormatMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure cmbDropDown(Sender: TObject);
    procedure btnJustifyClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure mnuEditClick(Sender: TObject);
    procedure mnuTableClick(Sender: TObject);
    procedure mnuPositionClick(Sender: TObject);
    procedure mnuLockElementClick(Sender: TObject);
    procedure mnuConstrainElementClick(Sender: TObject);
    procedure cmbFontSizeDropDown(Sender: TObject);
    procedure EditShowContextMenu(Sender: TObject; xPos, yPos: Integer);
    procedure EditPostEditorEventNotify(Sender: TObject; pinEvtDispId: Integer; const pIEventObj: IHTMLEventObj; var aResult: HRESULT);
    procedure EditPreHandleEvent(Sender: TObject; inEvtDispId: Integer; const pIEventObj: IHTMLEventObj; var aResult: HRESULT);
    procedure EditInitialize(Sender: TObject; var NewFile: WideString);
    procedure mnuPrintpreviewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuFormattablegridClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure mnuRefreshClick(Sender: TObject);
    procedure Assign1Click(Sender: TObject);
    procedure Gotowww1Click(Sender: TObject);
    procedure SetBaseURLbad1Click(Sender: TObject);
    procedure SetBaseURLOK1Click(Sender: TObject);
    procedure gotofile1Click(Sender: TObject);
    procedure KSTestEdit1Click(Sender: TObject);
    procedure KSTestPreviewClick(Sender: TObject);
    procedure KSTestEdit2Click(Sender: TObject);
    procedure Navigate1Click(Sender: TObject);
    procedure EditGetDLControl(Sender: TObject; var varResult: Integer);
    procedure EditGetHostInfo(Sender: TObject; var dwFlags, dwDoubleClick: Cardinal; var chHostCss, chHostNS: WideString);
    procedure mnuOCXversionClick(Sender: TObject);
    procedure mnuUpdateUIClick(Sender: TObject);
    procedure Testing1Click(Sender: TObject);
    procedure EditTranslateMessageString(Sender: TObject; var MessageString: WideString; out MessageNr: Integer);
    procedure mnuDrawsquareClick(Sender: TObject);
    procedure EditPostHandleEvent(Sender: TObject; inEvtDispId: Integer; const pIEventObj: IHTMLEventObj; var aResult: HRESULT);
    procedure EditShortCut(Sender: TObject; out CmdID: Cardinal; var Cancel: WordBool);
    procedure Printwithtemplate1Click(Sender: TObject);
    procedure mnuClassicselClick(Sender: TObject);
    procedure CreateFlyClick(Sender: TObject);
    procedure InsImageClick(Sender: TObject);
    procedure LoadFileClick(Sender: TObject);
    procedure DestroyFlyClick(Sender: TObject);
    procedure ToUndoClick(Sender: TObject);
    procedure ToRedoClick(Sender: TObject);
    procedure mnuItemClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure mnuLinktoClick(Sender: TObject);
    procedure EditMessage(Sender: TObject; var msg: Cardinal; var wParam, lParam, Result: Integer);
    procedure mnuKsxloadfromDBClick(Sender: TObject);
    procedure mnuKsxloadfromfileClick(Sender: TObject);
    procedure mnuhttpstreamingONClick(Sender: TObject);
    procedure mnuhttpstreamingOFFClick(Sender: TObject);
    procedure EditGetStreamData(Sender: TObject; const Url: WideString; var aStream: IUnknown; var aResult: HRESULT);
    procedure ksxinsertpicture1Click(Sender: TObject);
    procedure mnuGetcaretpositionClick(Sender: TObject);
    procedure mnuRestorecaretpositionClick(Sender: TObject);
    procedure mnuDontdragmeClick(Sender: TObject);
    procedure EditDragAndPaste(Sender: TObject; EventType: Integer; const DataObject: IUnknown);
    procedure mnuLookforPleasedragmeClick(Sender: TObject);
    procedure mnuLoadstreamtoDOCClick(Sender: TObject);
    procedure mnuSaveDocToDbClick(Sender: TObject);
    procedure mnuSpellSelectClick(Sender: TObject);
    procedure mnuSpellCurClick(Sender: TObject);
    procedure mnuSpellDocClick(Sender: TObject);
    procedure mnuSpellOptionClick(Sender: TObject);
    procedure EditSpellEvent(Sender: TObject; EventType: Integer; const aWord: WideString; var InOutVar: WideString; var Result: HRESULT);
    procedure mnuCheckliveClick(Sender: TObject);
    procedure SpellPopClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnuLivecheckAreaClick(Sender: TObject);
    procedure mnuGeCelltlistClick(Sender: TObject);
    procedure mnuTableSelCellClick(Sender: TObject);
    procedure mnuTableSelRowClick(Sender: TObject);
    procedure mnuTableSelColumnClick(Sender: TObject);
    procedure mnuTableSelTableClick(Sender: TObject);
    procedure mnuIscellselectedClick(Sender: TObject);
    procedure mnuHighlightcellsClick(Sender: TObject);
    procedure Create100Click(Sender: TObject);
    procedure EditGetParentWindow(Sender: TObject; var ParentHwnd: Cardinal; var Result: HRESULT);
    procedure Pagesetup1Click(Sender: TObject);
    procedure mnuLoadURLClick(Sender: TObject);
    procedure mnuPastepathsabsoluteClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure mnuRawHtmlClick(Sender: TObject);
    procedure filestreamingONClick(Sender: TObject);
    procedure filestreamingOFFClick(Sender: TObject);
    procedure DefaultfiledropONClick(Sender: TObject);
    procedure DefaultfiledropOFFClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EditWatchElementDelete(Sender: TObject; const Value: WideString);
    procedure WatchElementDeletion1Click(Sender: TObject);
    procedure StopWatching1Click(Sender: TObject);
    procedure Stopwatchingallelements1Click(Sender: TObject);
    procedure btnShowAnchorsClick(Sender: TObject);
    procedure mnuTatablecellsClick(Sender: TObject);
    procedure EditHTMLClick(Sender: TObject);
    procedure mnuEditHTMLClick(Sender: TObject);
    procedure EditBookMClick(Sender: TObject);
    procedure mnuSpellDlgModalClick(Sender: TObject);
    procedure mnuSpellingClick(Sender: TObject);
    procedure mnuEdittablepropertiesClick(Sender: TObject);
    procedure mnuEditCellpropertiesClick(Sender: TObject);
    procedure Font1Click(Sender: TObject);
    procedure Borders1Click(Sender: TObject);
    procedure Bullets1Click(Sender: TObject);
    procedure Nudgeelement1Click(Sender: TObject);
    procedure HorizontalRule1Click(Sender: TObject);
    procedure mnuShowmarkedRevisionsClick(Sender: TObject);
    procedure mnuMarkselectionasRevisionsClick(Sender: TObject);
    procedure mnuClearselectedrvisionmarkingClick(Sender: TObject);
    procedure Clearallrevisionmarkings1Click(Sender: TObject);
    procedure btnShowPagebrkClick(Sender: TObject);
    procedure btnInsertPagebrkClick(Sender: TObject);
    procedure btnRemovePagebrkClick(Sender: TObject);
    procedure mnuAboutNewfeaturesClick(Sender: TObject);
    procedure Testbookmarks1Click(Sender: TObject);
    procedure Watchforaccidentlydeletion1Click(Sender: TObject);
    procedure Managepagebreaks1Click(Sender: TObject);
    procedure Managerevisionsmarking1Click(Sender: TObject);
    procedure mnuRevisionsClick(Sender: TObject);
    procedure Download1Click(Sender: TObject);
    procedure Changelanguage1Click(Sender: TObject);
    procedure CheckHint(Sender: TObject);
    procedure SetUndoHint;
    procedure SetRedoHint;
    procedure SetdocumenttoUnichar1Click(Sender: TObject);
    procedure Setdocumenttoutf81Click(Sender: TObject);
    procedure btnSaveToRoomerClick(Sender: TObject);
  private
    UpdateUI: Boolean;
    Changed: boolean;
    FFocusObject: TComboBox;
    PrintSetUpOK: Boolean;
   // PrintTemplate: string;
   // DefaultIETemplate: Boolean;
   // FPrintSetup: TPrintSetup;
   // DoPrintTime: Boolean;
    SourceView: Boolean;
    TEIgnoreChange: boolean;
    _CurrentDocumentPath: string;
    FCurrentStatusbarElement: IUnknown;
    NoSyncInBrowseModeWarning: Boolean;

    FlyEdit: TKSEditX;

    FDatatype: Integer;
    FSpecialHttpHandling: Boolean;
    FTable: TTable;
    FCaretPosElement: IHTMLElement;
    FCaretPos: TPoint;

    FBlockDragText: boolean;

    {$IFDEF AddictSpell}
       aSpellChecker: TAddictSpell3;
    {$ENDIF}
    
    LastPage: TTabSheet;

    FBom: Integer; // 0 = Ansi, 1 = Utf8, 2 = Unicode

    {$IFNDEF D2009UP}  // from D 2009 and up mmoHTML (TMemo) is Unicode so we don't need a
                       // separate UniHTML (TKSRichEdit) anymore
       UniHTML: TKSRichEdit;
       ALabel: TLabel;
    {$ENDIF}

    FEditHelper: TKSEdit_X;

    function DoPromtRepeated: Integer;
    procedure FlyEditDisplayChanged(Sender: TObject);
    procedure LookForObjects;
    procedure Print(ShowDlg: boolean = True);
    procedure PrintHTMLSource;
    procedure UpdateButtons;
    // function GetPrintLayout: TPrintSetup;
    procedure mnuQueryStatus(cmdID: Cardinal; var amnu: TMenuItem);
    procedure CheckEditButton;
    procedure GetStyles;
    function CheckResult(HR: HResult; AMessage: String; _Preview: boolean = false; FunctionCall: boolean = false): Boolean;
    procedure DrawSquare(Tr: TRect; aHandle: HWND);
    function ActivateTable: Boolean;
    function SaveStreamToDB(aName: String; aStream: IStream): HResult;
    function GetStream(aPath: String; var _Stream: IUnknown): HResult;
    procedure F7Spelling;
    function OpenSpellchecker: Boolean;
    {$IFNDEF AddictSpell}
      procedure NoSpellChecker;
    {$ENDIF}
    function SpellSuggestWords(const aWord: WideString; var Suggestions: WideString): HRESULT;
    function SpellCheckWord(const aWord: WideString; var aCorrection: WideString): HRESULT;

    function GetCurrentCell(var Ov: OleVariant): boolean;
    function ModyFycase(aWord: String): String;
    procedure VisualizeDOMTree(node: IHTMLDOMNode; treeNode:TTreeNode; treeNodes:TTreeNodes);

    function UndoDeleteElement(TagValue: String; WatchID: Integer): Boolean;
    procedure UpdatetbtnShowAnchors;
    procedure UpdatebtnShowPagebrk;

  public
    FWatchedBookMarks: Boolean;
    FWatchedComments: Boolean;
    FShowAnchorGlyphe: Boolean;
    FShowPagebrkGlyphe: Boolean;

    RoomerFilename : String;
    SaveToRoomer : Boolean;
    procedure OpenFile(filename : String);
    procedure SaveFile(filename : String);
  end;




var
  frmOcxHtmlEditor: TfrmOcxHtmlEditor;

function EditLocalHtmlFile(filename : String) : boolean;
function GetInitialDoc: string;

implementation

uses axctrls, Printers, {$IFNDEF D4D5} Variants, {$ENDIF}
     ShellAPI, StdVCL, ComConst, ComObj,
     PrintText, RegisterOCX, RegFuncs, ModalEdOCX, dlgx_grid, uPageProp,
     {$IFDEF SHDocVw_TLB}
        //if you get compile error heir: open KSED.inc and deactivate {$DEFINE SHDocVw_TLB}
        SHDocVw_TLB,
     {$ELSE}
        SHDocVw,
     {$ENDIF}
     {$IFDEF AddictSpell}
        AddToDictionary,
     {$ENDIF}
     KSIeconst, IEDispConst, insHTML, dlgx_Bookmark, dlgx_EditHTML, IniFuncs,
     dlgx_TableCell, dlgx_Styles, dlgx_Bullets, dlgx_Nudge, dlgx_ALink;


{$R *.DFM}

  {$IFNDEF KSEDINC}
     The path to KSED.inc cant be found
     Set the path to KSED.inc in Delphis "Library Path"
     Or this project wont compile correctly
  {$ENDIF}



function EditLocalHtmlFile(filename : String) : boolean;
var _frmOcxHtmlEditor: TfrmOcxHtmlEditor;
begin
  _frmOcxHtmlEditor := TfrmOcxHtmlEditor.Create(nil);
  try
    _frmOcxHtmlEditor.RoomerFilename := filename;
    _frmOcxHtmlEditor.SaveToRoomer := False;
    if FileExists(filename) then
      _frmOcxHtmlEditor.OpenFile(filename)
    else
    begin
      _frmOcxHtmlEditor.btnNew.Click;
      _frmOcxHtmlEditor.Edit.DocumentHTML := GetInitialDoc;
    end;
    _frmOcxHtmlEditor.ShowModal;
    result := _frmOcxHtmlEditor.SaveToRoomer;
  finally
    FreeAndNil(_frmOcxHtmlEditor);
  end;
end;

//------------------------------------------------------------------------------
function Color2HTML(Color: TColor): string;
var
  Step  : Integer;
  Step2 : String;
begin
  //asm int 3 end; //trap
  Step := ColorToRGB(Color);
  Step2 := IntToHex(Step, 6);
  //The result will be BBGGRR but I want it RRGGBB
  Result := '#' + Copy(Step2, 5, 2) + Copy(Step2, 3, 2) + Copy(Step2, 1, 2);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.SetUndoHint;
begin
  //asm int 3 end; //trap
  if btnUndo.enabled
     then btnUndo.Hint := 'Undo ' + edit.CmdGet(IDM_GetLastUndoDesc) + '|btnUndo'
     else btnUndo.Hint := 'Undo' + '|btnUndo';
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.SetRedoHint;
begin
  //asm int 3 end; //trap
  if btnRedo.enabled
     then btnRedo.Hint := 'Redo ' + edit.CmdGet(IDM_GetLastRedoDesc) + '|btnRedo'
     else btnRedo.Hint := 'Redo' + '|btnRedo';
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.CheckHint(Sender: TObject);
var
  S: String;
begin
  //asm int 3 end; //trap

  // this is called from Application.OnHint whenever a hint is about to be shown

  S := GetLongHint(Application.Hint);

  { wee'l only handle hints from the Undo and Redo buttons heir.
    The Undo and Redo buttons hint must be set to Short|btnUndo and Short|btnRedo
    in the Object inspector (where Short can be any text) }

  If S = 'btnUndo'
     then SetUndoHint

  else if S = 'btnRedo'
     then SetRedoHint;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditDisplayChanged(Sender: TObject);
var
  Index: Integer;
  S: WideString;
begin
  //asm int 3 end; //trap

  LookForObjects;

  UpdateButtons;

  //UpdateFontName
  cmbFontName.ItemIndex := Edit.GetFontNameIndex(cmbFontName.Items.Text);

  //UpdateFontSize
  cmbFontSize.ItemIndex := Edit.GetFontSizeIndex(cmbFontSize.Text, S);
  { this is a little more complex because cmbFontSize.Items[7] can be changed to
    any size found in i.e. a style }
  if Length(S) > 0
     then begin
        Index := cmbFontSize.ItemIndex;
        cmbFontSize.Items.Text := S;
        cmbFontSize.ItemIndex := Index;
     end;


  //UpdateStylesBox
  cmbStyles.ItemIndex := Edit.GetStylesIndex(cmbStyles.Items.Text);


  //UpdateStatusLine(Edit.ActualElement);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.UpdateButtons;

  //---------------------------------------
  procedure btnQueryStatus(cmdID: Cardinal; var aButon: TToolButton);
  var
     dwStatus : OLECMDF;
  begin
     //even in browse mode MSHTML will accept certain commands
     //like IDM_BOLD
     if Edit.BrowseMode
        then dwStatus := 0
        else dwStatus := Edit.QueryStatus(cmdID);

     aButon.Enabled := (dwStatus and OLECMDF_ENABLED) <> 0;
     aButon.Down := (dwStatus and OLECMDF_LATCHED) <> 0;
   end;
  //---------------------------------------
begin
  //asm int 3 end; //trap
  if PageControl1.ActivePage = tabEdit
     then begin
        btnQueryStatus(IDM_BOLD, btnBold);
        btnQueryStatus(IDM_ITALIC, btnItalic);
        btnQueryStatus(IDM_UNDERLINE, btnUnderline);

        btnQueryStatus(IDM_CUT, btnCut);
        btnQueryStatus(IDM_COPY, btnCopy);
        btnQueryStatus(IDM_PASTE, btnPaste);

        btnQueryStatus(IDM_INDENT, btnIndentRight);
        btnQueryStatus(IDM_OUTDENT, btnIndentLeft);

        btnQueryStatus(IDM_JUSTIFYLEFT, btnAlignLeft);
        btnQueryStatus(IDM_JUSTIFYCENTER, btnAlignCenter);
        btnQueryStatus(IDM_JUSTIFYRIGHT, btnAlignRight);

         btnQueryStatus(IDM_HYPERLINK, btnInsertLink);
        // doesn't work properly - if cursor is inside a link


        btnQueryStatus(IDM_BACKCOLOR, btnBGColor);
        btnQueryStatus(IDM_FORECOLOR, btnFGColor);
        btnQueryStatus(IDM_FONT, btnFont);
        if btnFont.enabled and
           assigned(Edit.ActualElement) and
           SameText(Edit.ActualElement.Get_tagName, 'FONT')
           then btnFont.Down := true;


        btnQueryStatus(IDM_ABSOLUTE_POSITION, btnMakeAbsolute);
        //btnMakeAbsolute.enabled := true;

        btnQueryStatus(IDM_ORDERLIST, btnNumberedList);
        btnQueryStatus(IDM_UNORDERLIST, btnBulletedList);

        btnQueryStatus(IDM_UNDO, btnUndo);
        btnQueryStatus(IDM_REDO, btnRedo);


       btnQueryStatus(IDM_SHOWZEROBORDERATDESIGNTIME, btnBorders);

       btnQueryStatus(IDM_ClearUndoStack, btnClearUndoStack);

       btnSave.enabled := edit.IsDirty;

        if Coolbar.Bands[2].Visible
           then begin
              //update the table buttons
              if not mnuViewtbl_Table.Enabled
                 then begin
                    btnTableInTable.Enabled := False;
                    btnTableInsRow.Enabled := False;
                    btnTableDelRow.Enabled := False;
                    btnTableInsCol.Enabled := False;
                    btnTableDelCol.Enabled := False;
                    btnTableInsCell.Enabled := False;
                    btnTableDelCell.Enabled := False;
                    btnTableMergeCells.Enabled := False;
                    btnTableTableSplitCells.Enabled := False;
                 end
                 else begin

                    btnQueryStatus(DECMD_INSERTTABLE, btnTableInTable);
                    btnQueryStatus(DECMD_INSERTROW, btnTableInsRow);
                    btnQueryStatus(DECMD_INSERTCOL, btnTableInsCol);
                    btnQueryStatus(DECMD_INSERTCELL, btnTableInsCell);
                    btnQueryStatus(DECMD_DELETEROWS, btnTableDelRow);
                    btnQueryStatus(DECMD_DELETECOLS, btnTableDelCol);
                    btnQueryStatus(DECMD_DELETECELLS, btnTableDelCell);
                    btnQueryStatus(DECMD_MERGECELLS, btnTableMergeCells);
                    btnQueryStatus(DECMD_SPLITCELL, btnTableTableSplitCells);
                 end;
           end;
     end
  else if (PageControl1.ActivePage = tabHTML) {$IFNDEF D2009UP} or
          (PageControl1.ActivePage = TabUniHTML) {$ENDIF}
     then begin
        //mmoHTML
        btnCut.Enabled := mmoHTML.SelLength > 0;
        btnCopy.Enabled := mnuEditCut.Enabled;
        btnPaste.Enabled := true;
        btnPrint.Enabled := true;
        btnUndo.Enabled := mmoHTML.CanUndo;
        //mnuEditRedo.Enabled := false;
     end

  else if PageControl1.ActivePage = tabPreview   //preview tab
     then begin
        btnCopy.Enabled := Preview.Selection;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnBoldClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_BOLD), 'IDM_BOLD');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnOpenClick(Sender: TObject);
var
  aFile: Widestring;
begin
  //asm int 3 end; //trap
  CheckResult(Edit.LoadFile(aFile, true), 'LoadFile', false, true);
  //this command actually returns the loaded file path
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnSaveClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.SaveFile, 'SaveFile', false, true);
end;
procedure TfrmOcxHtmlEditor.btnSaveToRoomerClick(Sender: TObject);
begin
  SaveFile(RoomerFilename);
  Close;
end;

//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnInsertImageClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_IMAGE), 'IDM_IMAGE');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnItalicClick(Sender: TObject);
begin
  CheckResult(Edit.CmdSet(IDM_Italic), 'IDM_Italic');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnUnderlineClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_Underline), 'IDM_Underline');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnFindClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_FIND), 'IDM_FIND');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.cmbFontNameChange(Sender: TObject);
begin
  //asm int 3 end; //trap
  if not TEIgnoreChange
     then CheckResult(Edit.CmdSet_S(IDM_FONTNAME, cmbFontName.Text), 'IDM_FONTNAME');

  CheckResult(Edit.SetFocusToDoc, 'SetFocusToDoc', false, true);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.cmbFontSizeChange(Sender: TObject);
begin
  //asm int 3 end; //trap
  if not TEIgnoreChange
     then CheckResult(Edit.CmdSet_I(IDM_FONTSIZE, cmbFontSize.ItemIndex + 1), 'IDM_FONTSIZE');

  CheckResult(Edit.SetFocusToDoc, 'SetFocusToDoc', false, true);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.cmbStylesChange(Sender: TObject);
begin
  //asm int 3 end; //trap
  if not TEIgnoreChange
     then CheckResult(Edit.SetStyle(cmbStyles.Text), 'SetStyle');

  CheckResult(Edit.SetFocusToDoc, 'SetFocusToDoc', false, true);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.cmbDropDown(Sender: TObject);
begin
  //asm int 3 end; //trap
  FFocusObject := Sender as TComboBox;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.cmbFontSizeDropDown(Sender: TObject);
var
  I: Integer;
  S: String;
begin
  //asm int 3 end; //trap
  //don't show anything than font size 1 to 7 in the drop down box
  For I := cmbFontSize.Items.Count -1  downto 0 do
     begin
        //ALL std. font size looks like this: '2  (10 pt)'
        S := copy(cmbFontSize.Items[I], 1, 4);
        if (Length(S) < 4) or
           (pos(S[1], '1234567') = 0) or
           (Copy(S, 2, 3) <> '  (')
           then cmbFontSize.Items.Delete(I)
     end;

  FFocusObject := Sender as TComboBox;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.tlb_FormatMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  //asm int 3 end; //trap
  if (not assigned(FFocusObject)) or
     (FFocusObject.DroppedDown)
     then exit;

  //now the box isn't dropped down
  //if the mouse leaves the object, then shift focus back to Edit

  if (Y < FFocusObject.Left) or
     (X > FFocusObject.Top) or
     (Y > FFocusObject.Left + FFocusObject.Width) or
     (X < FFocusObject.Top - FFocusObject.Height)
     then begin
        CheckResult(Edit.SetFocusToDoc, 'SetFocusToDoc', false, true);
        FFocusObject := nil;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuFileExitClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  Close;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuQueryStatus(cmdID: Cardinal; var amnu: TMenuItem);
var
  dwStatus : OLECMDF;
begin
  //asm int 3 end; //trap
  dwStatus := Edit.QueryStatus(cmdID);
  amnu.Enabled := (dwStatus and OLECMDF_ENABLED) <> 0;
  amnu.Checked := (dwStatus and OLECMDF_LATCHED) <> 0;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableClick(Sender: TObject);
          //prepare Table menu before it drops down
var
  DummyOv: OleVariant;
  SelOK: Boolean;
  NumCells: Integer;
begin
  //asm int 3 end; //trap
  if PageControl1.ActivePage = tabFly
     then mnuItemClick(Sender)
     else begin
        mnuQueryStatus(DECMD_INSERTTABLE, mnuTableInsertTable);
        mnuQueryStatus(DECMD_INSERTROW, mnuTableInsertRow);
        mnuQueryStatus(DECMD_INSERTCOL, mnuTableInsertCol);
        mnuQueryStatus(DECMD_INSERTCELL, mnuTableInsetCell);
        mnuQueryStatus(DECMD_DELETEROWS, mnuTableDeleteRow);
        mnuQueryStatus(DECMD_DELETECOLS, mnuTableDeleteCol);
        mnuQueryStatus(DECMD_DELETECELLS, mnuTableDeleteCell);
        mnuQueryStatus(DECMD_MERGECELLS, mnuTableMergeCells);
        mnuQueryStatus(DECMD_SPLITCELL, mnuTableSplitCells);
        mnuQueryStatus(IDM_FormatTableGrid, mnuFormattablegrid);
        mnuQueryStatus(IDM_BlockSelTableCells, mnuClassicsel);
        mnuQueryStatus(IDM_HighlSelTableCells, mnuHighlightcells);
        mnuQueryStatus(IDM_TabIntoTableCells, mnuTatablecells);

        mnuEdittableproperties.Enabled := mnuTableDeleteCell.enabled;
        mnuEditCellproperties.Enabled := mnuTableDeleteCell.enabled;

        mnuGeCelltlist.Enabled := false;
        SelOK := false;

        if mnuClassicsel.enabled
           then begin
              NumCells := Edit.CmdGet(IDM_Num_CELLS_Highlight);
              mnuGeCelltlist.Enabled := NumCells > 0;

              SelOK := (NumCells = 1) and
                       GetCurrentCell(DummyOv);
           end;

        mnuTableSelCell.Enabled := SelOK;
        mnuTableSelRow.Enabled := SelOK;
        mnuTableSelColumn.Enabled := SelOK;
        mnuIscellselected.Enabled := SelOK;
        mnuTableSelTable.Enabled := mnuGeCelltlist.Enabled;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnInsertTableClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  DoDlg_TableCell_InsertTable(Edit); //insert a table in the Editor

(* Old code
  frmTable := TfrmTable.Create(self);
  try
     if frmTable.ShowModal = mrOK
        then begin
           { IDM_INSERTTABLE is called with a 7 param safe array
             0 =  Number of rows
             1 =  Number of columns
             2 =  Table width in %
             3 =  Table tag attributes
             4 =  Cell tag attributes
             5 =  Table caption
             6 =  Wrap text in cells }

           ov := VarArrayCreate([0, 6], varVariant);
           ov[0] := StrToInt(frmTable.edRows.Text);
           ov[1] := StrToInt(frmTable.edCols.Text);
           ov[2] := frmTable.edWidth.Text + '%';
           ov[3] := 'Border=' + frmTable.edTBorder.text +       // Table Attributes
                    ' cellPadding=' + frmTable.edPad.text +
                    ' cellSpacing=' + frmTable.edSpace.Text;
           ov[4] := 'bgColor=' + frmTable.cmbTableBGColor.text; // Cell Attributes
           ov[5] := frmTable.edCaption.text;
           ov[6] := frmTable.chkWrap.checked;

           CheckResult(Edit.CmdSet(DECMD_INSERTTABLE, ov), 'DECMD_INSERTTABLE');
        end;
  finally
     frmTable.Free;
  end;
  *)
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuFormattablegridClick(Sender: TObject);
var
  ov: OleVariant;
begin
  //asm int 3 end; //trap
  ov := VarArrayCreate([0, 7], varVariant);
  ov[0] := '3pt';
  ov[3] := '1.5pt';
  ov[6] := '0';
  ov[7] := '4';
  CheckResult( Edit.CmdSet(IDM_FormatTableGrid, ov), 'IDM_FormatTableGrid');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditDeleteClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_DELETE), 'IDM_DELETE');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditCutClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_CUT), 'IDM_CUT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditCopyClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_COPY), 'IDM_COPY');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditPasteClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_PASTE), 'IDM_PASTE');
end;
//------------------------------------------------------------------------------
function NotALink(aElement: IhtmlElement): boolean;
begin

  //go up to the A-tag, but break if the BODY tag comes by
  while (aElement.tagName <> 'A') and (aElement.tagName <> 'BODY') do
     aElement := aElement.parentElement;

  result := aElement.tagname <> 'A';
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnInsertLinkClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  PageControl1.SetFocus; //ensures highlighting of the selected text
  DoDlg_LinkInfo(FEditHelper);
  Edit.SetFocusToDoc;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnAlignCenterClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_JUSTIFYCENTER), 'IDM_JUSTIFYCENTER');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnAlignLeftClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_JUSTIFYLEFT), 'IDM_JUSTIFYLEFT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnAlignRightClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_JUSTIFYRIGHT), 'IDM_JUSTIFYRIGHT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnJustifyClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  if (Edit.QueryStatus(IDM_JUSTIFYFULL) and OLECMDF_LATCHED) <> 0
     then CheckResult(Edit.CmdSet(IDM_JUSTIFYNONE), 'IDM_JUSTIFYNONE')
     else CheckResult(Edit.CmdSet(IDM_JUSTIFYFULL), 'IDM_JUSTIFYFULL');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditClick(Sender: TObject);
//prepare Edit menu before it drops down
var
  I: Integer;
begin
  //asm int 3 end; //trap

  for I := 0 to mnuEdit.Count -1 do
     mnuEdit.Items[I].Enabled := false;

  if PageControl1.ActivePage = tabEdit
     then begin
        mnuEditUndo.Enabled := btnUndo.Enabled;
        mnuEditRedo.Enabled := btnRedo.Enabled;
        mnuEditCut.Enabled := btnCut.Enabled; //Edit.Selection;
        mnuEditCopy.Enabled := btnCopy.Enabled; //Edit.Selection;
        mnuEditPaste.Enabled := btnPaste.Enabled;
        mnuEditDelete.Enabled := true;
        mnuEditSelectAll.Enabled := true;
        mnuEditFind.Enabled := true;
        mnuEditUnlink.Enabled := Edit.QueryEnabled(IDM_UNLINK);
        mnuRefresh.Enabled := true;
     end

  else if PageControl1.ActivePage = tabHTML
     then begin
        //mmoHTML
        mnuEditUndo.Enabled := mmoHTML.CanUndo;
        mnuEditCut.Enabled := mmoHTML.SelLength > 0;
        mnuEditCopy.Enabled := mnuEditCut.Enabled;
        mnuEditPaste.Enabled := true;
        mnuEditDelete.Enabled := true;
        mnuEditSelectAll.Enabled := true;
     end

  {$IFNDEF D2009UP}
  else if (PageControl1.ActivePage = tabUniHTML) and
           assigned(UniHTML)
     then begin
        //UniHTML
        mnuEditUndo.Enabled := UniHTML.CanUndo;
        mnuEditCut.Enabled := UniHTML.SelLength > 0;
        mnuEditCopy.Enabled := mnuEditCut.Enabled;
        mnuEditPaste.Enabled := true;
        mnuEditDelete.Enabled := true;
        mnuEditSelectAll.Enabled := true;
     end
  {$ENDIF}

  else if PageControl1.ActivePage = tabFly
     then exit

  else begin   //preview tab
     mnuEditCopy.Enabled := Preview.Selection;
     mnuEditSelectAll.Enabled := true;
  end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditRedoClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_REDO), 'IDM_REDO')
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditUndoClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_UNDO), 'IDM_UNDO');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditSelectAllClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_SELECTALL), 'IDM_SELECTALL');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditUnlinkClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_UNLINK), 'IDM_UNLINK');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableInsertRowClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_INSERTROW), 'DECMD_INSERTROW');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableInsertColClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_INSERTCOL), 'DECMD_INSERTCOL');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableInsetCellClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_INSERTCELL), 'DECMD_INSERTCELL');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableDeleteRowClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_DELETEROWS), 'DECMD_DELETEROWS');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableDeleteColClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_DELETECOLS), 'DECMD_DELETECOLS');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableDeleteCellClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_DELETECELLS), 'DECMD_DELETECELLS');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnFGColorClick(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap

  if ColorDialog.Execute then
  begin
    Ov := Color2HTML(ColorDialog.Color);
    CheckResult(Edit.CmdSet(IDM_FORECOLOR, Ov), 'IDM_FORECOLOR');
  end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableMergeCellsClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_MERGECELLS), 'DECMD_MERGECELLS');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableSplitCellsClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_SPLITCELL), 'DECMD_SPLITCELL');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnIndentRightClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_INDENT), 'IDM_INDENT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnIndentLeftClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_OUTDENT), 'IDM_OUTDENT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnBulletedListClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_UNORDERLIST), 'IDM_UNORDERLIST');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnNumberedListClick(Sender: TObject);
begin
  CheckResult(Edit.CmdSet(IDM_ORDERLIST), 'IDM_ORDERLIST');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPositionAboveTextClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_BRING_ABOVE_TEXT), 'DECMD_BRING_ABOVE_TEXT'); // Set Z-INDEX to 100
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPositionBringForwardClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_BRING_FORWARD), 'DECMD_BRING_FORWARD'); //increment Z-INDEX by one, skip from -99 to 99
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPositionBringtoFrontClick(Sender: TObject);
begin
   // Set Z-INDEX to 1 higher that any other Z-INDEX on page, min 100
  CheckResult(Edit.CmdSet(DECMD_BRING_TO_FRONT), 'DECMD_BRING_TO_FRONT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPositionBelowTextClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  //SendbehindHTMLstream
  CheckResult(Edit.CmdSet(DECMD_SEND_BELOW_TEXT), 'DECMD_SEND_BELOW_TEXT'); // Set Z-INDEX to -100
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPositionSendtoBackClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  // Set Z-INDEX to 1 lower that any other Z-INDEX on page, min -100
  CheckResult(Edit.CmdSet(DECMD_SEND_TO_BACK), 'DECMD_SEND_TO_BACK');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPositionSendBackwardClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  //decrement Z-INDEX by one, skip from 99 to -99
  CheckResult(Edit.CmdSet(DECMD_SEND_BACKWARD), 'DECMD_SEND_BACKWARD');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuLockElementClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(DECMD_LOCK_ELEMENT), 'DECMD_LOCK_ELEMENT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuConstrainElementClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_CONSTRAIN), 'IDM_CONSTRAIN');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnBGColorClick(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  if ColorDialog.Execute then
  begin
    Ov := Color2HTML(ColorDialog.Color);
    CheckResult(Edit.CmdSet(IDM_BACKCOLOR, Ov), 'IDM_BACKCOLOR');
  end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnFontClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_FONT), 'IDM_FONT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPositionClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  if PageControl1.ActivePage = tabFly
     then mnuItemClick(Sender)
     else begin
        mnuPositionMakeAbsolute.Enabled := btnMakeAbsolute.Enabled;
        mnuPositionMakeAbsolute.checked := btnMakeAbsolute.Down;

        if mnuPositionMakeAbsolute.checked
           then mnuQueryStatus(DECMD_LOCK_ELEMENT, mnuLockElement)
           else begin
              mnuLockElement.Enabled := false;
              mnuLockElement.Checked := false;
           end;

        mnuQueryStatus(IDM_CONSTRAIN, mnuConstrainElement);
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPositionMakeAbsoluteClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_ABSOLUTE_POSITION), 'IDM_ABSOLUTE_POSITION');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuFilePropertiesClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  PageControl1.SetFocus; //ensures highlighting of the selected text
  if DoDlg_PageProp(Edit)
     then Caption := Application.Title + ' [' + Edit.DOM.Title + ']';
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnPrintClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  Print(False);  //show no dialog
end;
//------------------------------------------------------------------------------
(*
function TfrmMain.GetPrintLayout: TPrintSetup;
begin
  //asm int 3 end; //trap
  If PrintSetUpOK
     then begin
        result := FPrintSetup;
        exit;
     end;

  If PrintSetUpOK
     then begin
        result := FPrintSetup;
        exit;
     end;

  PrintSetUpOK := true;

  { SetPrintTemplate is called with a 8 item string array of type TPrintSetup:

    TemplatePath: string;
    FPageInf: integer; //0 = default MSHTML template, 1 = inches, or 2 = mm
    //this measures is inches -> mm / 25,4 => inches or mm
    FHeaderFormat: string;
    FooterFormat: string;
    Margin_Top: string;
    Margin_Bottom: string;
    Margin_Left: string;
    Margin_Right: string;
    Orientation: string;

    if TemplatePath is set the rest of the array can be empty and the template in
    TemplatePath is used as print basis

    if TemplatePath is empty the IE-build-in template is used as print basis

    if FPageInf = 0 the rest of the array can be empty and the values set in the
    IE print setup dialog is used for printing

    if FPageInf = 1 then all margins is in inches
    if FPageInf = 2 then all margins is mm

    if an error is encountered then read the property LastError }

  FPrintSetup[0] := PrintTemplate;
  if Length(PrintTemplate) = 0
     then begin
        //no external template
        FPrintSetup[1] := '0';
        if not DefaultIETemplate
           then begin
              //we don't want to use IE's build in page setup
              FPrintSetup[1] := '1'; //Margins is in inches
              FPrintSetup[2] := '';  //empty header

              if DoPrintTime
                 then FPrintSetup[3] := ',  &d : &t&bSide &p af &P'  //footer format
                 else FPrintSetup[3] := '&bSide &p af &P';

              FPrintSetup[4] :=  '1.25984'; //Margin_Top
              FPrintSetup[5] :=  '0.59055'; //Margin_Bottom
              FPrintSetup[6] :=  '0.80709'; //Margin_Left
              FPrintSetup[7] :=  '1.37795'; //Margin_Right
              FPrintSetup[8] :=  '1';       //orientation, 1 = portrait
           end;
     end;

  result := FPrintSetup;
end;
*)
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPrintpreviewClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  if not mnuPrintpreview.enabled
     then exit;

  if PageControl1.ActivePage = tabPreview
     then Preview.PrintPreview(EmptyParam)

  else if PageControl1.ActivePage = tabEdit
     then CheckResult(Edit.PrintPreview(EmptyParam), 'PrintPreview', false, true);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.PrintHTMLSource;
var
  Buffer: PChar;
  Size: Integer;
  Prn: PrnRec;
  SelLength: Integer;
  aText: WideString;
  {$IFNDEF D2009UP}
     PrintUni: Boolean;
  {$ENDIF}
begin
  //asm int 3 end; //trap

  if (PageControl1.ActivePage = tabHTML)
     then begin
        SelLength := mmoHTML.SelLength;
     {$IFNDEF D2009UP}
        PrintUni := false;
     end
     else begin
        if not assigned(UniHTML)
           then exit;

        //unicode edit
        SelLength := UniHTML.SelLength;
        PrintUni := True;
     {$ENDIF}
     end;

  if SelLength > 0
     then begin
        PrintDialog1.Options := [poSelection];
        PrintDialog1.PrintRange := prSelection;
     end
     else PrintDialog1.Options := [];

  if PrintDialog1.Execute
     then begin // determine the range the user wants to print
        prn.headerText := 'Just Testing';
        prn.headerFontName := 'Times New Roman';
        prn.headerFontSize := 14;
        prn.headerFontStyle := [fsUnderline, fsBold];
        prn.pageNumber := 1;
        Prn.bodyFontName := 'Arial';
        Prn.bodyFontSize := 10;
        Prn.bodyFontStyle := [];
        Prn.footerFontName := 'Times New Roman';
        Prn.footerFontSize := 8;
        Prn.footerFontStyle := [fsItalic];
        Prn.inchesInLeftMargin := 1.0;
        Prn.inchesInRightMargin := 1.0;
        Prn.inchesInTopMargin := 0.5;
        Prn.inchesInBottomMargin := 0.5;
        Prn.lineSpacing := 1.5;
        Prn.paperWidth := 8.5;
        Prn.paperHeight := 11.0;

        Printer.BeginDoc;
        try
           if PrintDialog1.PrintRange = prAllPages
              then begin
                 {$IFNDEF D2009UP}
                 if PrintUni
                    then PrintWideString(Prn, PWideChar(UniHTML.Text))
                    else {$ENDIF} PrintString(Prn, PChar(mmoHTML.Text));
              end

           else if PrintDialog1.PrintRange = prSelection
              then begin
                 Buffer := nil; //avoid warning
                 Size := 0;     //avoid warning
                 try
                    {$IFNDEF D2009UP}
                    if PrintUni
                       then begin
                          aText := UniHTML.SelText;
                          PrintWideString(Prn, aText);
                       end
                       else begin
                          {$ENDIF}
                          Size := SelLength +1;
                          GetMem(Buffer, Size);
                          mmoHTML.GetSelTextBuf(Buffer, Size);
                          PrintString(Prn, Buffer);
                       {$IFNDEF D2009UP}
                       end;
                       {$ENDIF}

                 finally
                    FreeMem(Buffer, Size);
                 end;
              end;
         finally
           Printer.EndDoc;
         end;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Print(ShowDlg: boolean = True);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  Ov := ShowDlg;

  if (PageControl1.ActivePage = tabHTML) {$IFNDEF D2009UP} or
     (PageControl1.ActivePage = tabUniHTML) {$ENDIF}
     then PrintHTMLSource

  else if PageControl1.ActivePage = tabPreview  //print from preview
     then CheckResult(Preview.PrintDocument(Ov), 'Preview.PrintDocument', true)

  else CheckResult(Edit.PrintDocument(Ov), 'PrintDocument', false, true);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuHelpAboutClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  ShowMessage('KS MSHTML Editor version: ' + GetFileInformation(ParamStr(0), 'FileVersion') + DblCrLf +
    'Need MS IE 5.5 or higher' + DblCrLf +
    'This HTML Editor (OcxDHTML.exe) and the' + CrLf +
    'core edit Engine (KsDHTMLEDLib.ocx) can' + CrLf +
    'be used freely according to' + CrLf +
    'GNU Lesser General Public License' + CrLf +
    'http://www.gnu.org/copyleft/lgpl.html' + DblCrLf +
    'The Delphi source that compiled OcxDHTML.exe and' + CrLf +
    'the edit engine KsDHTMLEDLib.ocx can be downloaded' + CrLf +
    'from http://tech.groups.yahoo.com/group/KSDhtmlEdit/' + DblCrLf +
    'More that twenty languages can be live spellchecked' + CrLf +
    'in the editor - See the menu "Spelling"' + DblCrLf +
    'Copyright (C) 2012 Kurt Senfer'+ CrLf +
    'e-mail: KSDhtmlEdit@gmail.com');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuOCXversionClick(Sender: TObject);
var
  aDllPath: String;
  Ov: OleVariant;
begin
  //asm int 3 end; //trap

  //aDllPath := ReadRegString(HKEY_CLASSES_ROOT, 'CLSID\'+ OCXGuid+'\InProcServer32', '');
  { Above wont work correctly by SxS activation of OCX
    New command IDM_Get_Module_Path will always work correctly }
        
  Ov := Edit.CmdGet(IDM_Get_Module_Path);
  aDllPath := Ov;

  KSMessageI('Version:' + #9 + GetFileInformation(aDllPath, 'FileVersion') + CrLf +
             'File date:' + #9 + GetFileDateTime(aDllPath)+ CrLf +
             'Path:' + #9 + ShortFileNameToLFN(aDllPath) ,
             'KSDHTMLEDLib OCX', handle);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuInsertHTMLClick(Sender: TObject);
var
  ovSelection: OleVariant;
  ovTextRange: OleVariant;
begin
  //asm int 3 end; //trap
  PageControl1.SetFocus; //ensures highlighting of the selected text
  frmInsertHTML := TfrmInsertHTML.Create(Self);
  try
     if frmInsertHTML.ShowModal = mrOK
        then begin
           //this demonstrates that KsDHTMLEDLib supports IDispatch calls

           // get the IE selection object
           ovSelection := Edit.OleObject.Document.selection;

           // create a TextRange from the current selection
           ovTextRange := ovSelection.createRange;

           // paste our html into the range
           ovTextRange.pasteHTML(frmInsertHTML.InsHTML.Lines.Text);
     end;
  finally
     frmInsertHTML.free;
  end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnNewClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.NewDocument, 'NewDocument', false, true);

  If Coolbar.Bands[2].Visible
     then Coolbar.Bands[2].Visible:= False;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPositionGridSettingsClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  PageControl1.SetFocus; //ensures highlighting of the selected text
  DoDlg_Grid(Edit);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuFileSaveAsClick(Sender: TObject);
var
  aFile: String;
  hr: HResult;
begin
  //asm int 3 end; //trap
  hr := Edit.SaveFileAs(aFile);
  if hr <> OLE_E_PROMPTSAVECANCELLED
     then CheckResult(hr, '', false, true);
end;
//------------------------------------------------------------------------------
function DetectUnicodeChar(Source: PwideChar): boolean;
var
  i: Cardinal;
begin
  //asm int 3 end; //trap

  Result := false;

  if Source = ''
     then Exit;

  for I := 0 to Length(Source) do
     if Cardinal(Source[i]) > $FF
        then begin
           result := true;
           break;
        end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
  //---------------------------------------------------------
  procedure SetDocumentHTML(NewDocumentHTML: {$IFDEF D2009UP} String {$Else} WideString {$ENDIF}; Ansi: Boolean);
  var
     TmpBool: Boolean;
  begin
     //avoid dialog asking to save a dirty document
     TmpBool := Edit.SkipDirtyCheck;

     if not TmpBool
        then Edit.SkipDirtyCheck := true;   //don't ask for save on a dirty document

     Edit.CmdSet(IDM_Keep_DocPath); //keep current DocPath with new DocumentHTML - if any
     Edit.CmdSet(IDM_Keep_BaseURL); //keep current BaseURL with new DocumentHTML - if any

     if Ansi
        then begin
           Edit.CmdSet(IDM_SourceView_Type); //default -> ANSI
           If (FBom = 2) and
              (IDYES <> KSQuestion('Loading a Unicoded document from an Ansi editor' + cRlF+
                                   'probably results in a wrecked document.' + DblCrLf +
                                   'Do you wish to continue',
                                   'Loading document from text edit'))
              then begin
                 Edit.IsDirty := true; // IsDirty is always false after loading a
                                       // document through DocumentHTML
                 Edit.SkipDirtyCheck := TmpBool;
                 exit;
              end;
        end
        else begin
           if (FBom = 0) and // no need to do anything if original document is Unicode or UTF-8
              DetectUnicodeChar(PWideChar(NewDocumentHTML)) // NewDocumentHTML is from a Unicode edit but we
              then begin                                    // don't need to do anything unless there actually
                 FBom := 2;                                 // is a Unicode character in the text

                 {$IFNDEF NoBOMShow}
                    // wee now need to add the new BOM-2 to NewDocumentHTML
                    NewDocumentHTML := GetBOMString(FBom) + NewDocumentHTML;
                 {$ENDIF}
             end;
         end;

        {$IFDEF NoBOMShow}
           Edit.DocumentHTML := GetBOMString(FBom) + NewDocumentHTML; //set new text but keep old BaseURL
        {$Else}
           Edit.DocumentHTML := NewDocumentHTML; //set new text but keep old BaseURL
        {$ENDIF}

        Edit.IsDirty := true; // IsDirty is always false after loading a
                              // document through DocumentHTML
        Edit.SkipDirtyCheck := TmpBool;
  end;
  //---------------------------------------------------------
begin
  //asm int 3 end; //trap

  LastPage := PageControl1.ActivePage;

  if (PageControl1.ActivePage = tabHTML) and // Changing from Ansi Source HTML - and
      mmoHTML.Modified                       // also Unicode in D 2009 and up
     then SetDocumentHTML(mmoHTML.Text, {$IFDEF D2009UP} false {Unicode} {$Else} True {ANSI} {$ENDIF})

  {$IFNDEF D2009UP}  // from D 2009 and up mmoHTML (TMemo) is Unicode so we don't need a
                     // separate UniHTML (TKSRichEdit) anymore
  else if (PageControl1.ActivePage = tabUniHTML) and //changing from Unicoded Source HTML
      assigned(UniHTML) and
      UniHTML.Modified
     then SetDocumentHTML(UniHTML.Text, false {= Not ANSI})
  {$ENDIF}
  
  else if PageControl1.ActivePage = tabPreview  //Changing from preview
     then CheckResult(PreView.AssignDocument, 'PreView.AssignDocument', true); //Clear old contenet from preview browser

  //else tlb_Format.Visible := False; //changing from WYSIWYG
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnPrevInBrowserClick(Sender: TObject);
var//14/05/99 RuudK - Not perfect yet, saveas called twice...
  Directory : string;
  ovFileName: OleVariant;
begin
  //asm int 3 end; //trap
  ovFileName := _CurrentDocumentPath; //DHTMLEdit.CurrentDocumentPath;
  if ovFileName = '' then
  begin
    if MessageDlg('The document has not been saved yet. Save now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      MessageDlg('Saving the document to disk.', mtInformation,
        [mbOk], 0);
      btnSaveClick(Sender);
      FmxUtils.ExecuteFile(ovFileName, '', Directory, SW_SHOW);
    end;
    if MessageDlg('The document has not been saved yet. Save now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  end;
  if Changed = True then
  begin
    if MessageDlg('The content has been changed. Save now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      MessageDlg('Saving the document to disk.', mtInformation,
        [mbOk], 0);
      btnSaveClick(Sender);
      FmxUtils.ExecuteFile(ovFileName, '', Directory, SW_SHOW);
    end;
    if MessageDlg('The content has been changed. Save now?',
      mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  end;
  if Changed = False then
  begin
    FmxUtils.ExecuteFile(ovFileName, '', Directory, SW_SHOW);
  end;
  mmoHTML.Modified := False;
  Changed := False;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mmoHTMLChange(Sender: TObject);
begin
  //asm int 3 end; //trap
  Changed:=True;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.FormCreate(Sender: TObject);
begin
  //asm int 3 end; //trap

  Caption := Application.Title + ' [No Title]';
  PrintSetUpOK := false;

  if FileExists(ExtractFilePath(ParamStr(0)) + 'KS.SpcDeb')
     then begin
        KSTestEdit1.visible := true;
        KSTestEdit2.visible := true;
        KSTestPreview.visible := true;
        Create100.visible := true;
     end;

  CheckResult(Edit.CmdSet_B(IDM_NOFIXUPURLSONPASTE, true), 'IDM_NOFIXUPURLSONPASTE');

  FSpecialHttpHandling := false;

  FBlockDragText := false;

  FShowAnchorGlyphe := False;
  FWatchedBookMarks := False;
  FWatchedComments := False;

  {$IFDEF AddictSpell}
     aSpellChecker := TAddictSpell3.create(self);
  {$ELSE}
     mnuSpelling.Enabled := false;
  {$ENDIF}

  {$IFNDEF D2009UP} // from D 2009 and up mmoHTML (TMemo) is Unicode so we don't need a
                    // separate UniHTML (TKSRichEdit) anymore
  if UnicodeSupported
     then begin
        UniHTML := TKSRichEdit.create(Self);
        UniHTML.parent := TabUniHTML;
        UniHTML.align := alClient;
     end
     else begin
        ALabel := TLabel.Create(Self);
        with ALabel do
           begin
              parent := TabUniHTML;
              font.Color := ClRed;
              font.Size := 14;
              top := TabUniHTML.top + 20;
              left := TabUniHTML.left + 20;
              AutoSize := true;
              Caption := 'Unicode Rich Edit is not supported on this PC';
           end;
     end;
 {$ELSE}
   // we are on D 2009 or up
    PageControl1.Pages[2].TabVisible := False; // hide the UniHTML Tab
 {$ENDIF}

  // FIX 11.11.11  -  Because there might be assigned a start-up document in TfrmMain.EditInitialize
  // we risk to have created FEditHelper inside TfrmMain.EditDocumentComplete
  if not assigned(FEditHelper)
     then begin
       FEditHelper := TKSEdit_X.create(Edit);
       FEditHelper.OnDisplayChanged := EditDisplayChanged;
       FEditHelper.ShowRevisions(mnuShowmarkedRevisions.Checked);
     end;

  Edit.SnapToGrid := GetKHIniBoolean('KH', 'Snap');
  Edit.SnapToGridX := GetKHIniInteger('KH', 'SnapX', Edit.SnapToGridX);
  Edit.SnapToGridY := GetKHIniInteger('KH', 'SnapY', Edit.SnapToGridY);

  Application.OnHint := CheckHint; // CheckHint is called whenever a hint is about to be shown

  NoSyncInBrowseModeWarning := true;

(*
  if not FileExists('OcxDHTML.deb')
     then begin
        Testing1.visible := false;
        Aboutnewfeatures1.visible := false;
     end;
*)
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuViewtbl_TableClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  mnuViewtbl_Table.Checked:= not mnuViewtbl_Table.Checked;
  if mnuViewtbl_Table.Checked
     then Coolbar.Bands[2].Visible:= True;

  if mnuViewtbl_Table.Checked = False
     then Coolbar.Bands[2].Visible:= False;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuViewtbl_FormatClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  mnuViewtbl_Format.Checked:= not mnuViewtbl_Format.Checked;
  if mnuViewtbl_Format.Checked
     then Coolbar.Bands[1].Visible:= True;

  if mnuViewtbl_Format.Checked = False
     then Coolbar.Bands[1].Visible:= False;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuViewtbl_EditClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  mnuViewtbl_Edit.Checked:= not mnuViewtbl_Edit.Checked;
  if mnuViewtbl_Edit.Checked
     then Coolbar.Bands[0].Visible:= True;

  if mnuViewtbl_Edit.Checked = False
     then Coolbar.Bands[0].Visible:= False;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.LookForObjects;
begin
  //asm int 3 end; //trap
  //tags('TABLE'); //collection of all tables - if any

  {
  if (Edit.DOM <> nil) and
     ((Edit.DOM.all.tags('TABLE') as IHTMLElementCollection).length > 0)
     then mnuViewtbl_Table.Enabled:= True
     else mnuViewtbl_Table.Enabled:= False;
 }
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditRemoveTagsClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_RemoveFormat), '');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.PageControl1Change(Sender: TObject);
var
  SelStart: Integer;
  SelEnd: Integer;
  CurLine: Integer;
  CurTop: Integer;
  S: String;
  WS: WideString;

   //---------------------------------------
   procedure EnableAllButtons(Enable: Boolean);
   var
     I: Integer;
   begin
     for I := 0 to tlb_Edit.ButtonCount -1 do
        tlb_Edit.Buttons[I].Enabled := Enable;

     for I := 0 to tlb_Format.ButtonCount -1 do
        tlb_Format.Buttons[I].Enabled := Enable;

     for I := 0 to tlb_Table.ButtonCount -1 do
        tlb_Table.Buttons[I].Enabled := Enable;
   end;
   //---------------------------------------
   function GetSelectedDocumentHTML(UniCode: Boolean; var _SelStart, _SelEnd: Integer): Widestring;
   var
     NumChar: Integer;
   begin
     { A Unicoded editor like TKS_RichEdit based on (RICHED20.DLL) use a single
       Cr character at line ends while Ansi editors (like TMemo) uses both a Cr and Lf
       character at line ends.
       KSDhtmlEdit need to know if lenends are one or two bytes long in order to sync
       the cursor/Selection probberly - thus wee need thte IDM_SourceView_Typ command.

       You might be using a Unicode editor that has two bytes lineendings and
       from D 2009 and up TMemo is Unocode - and it uses both Cr + Lf at line ends.
       In both cases CmdSet_B(IDM_SourceView_Type, true / false) is not (no longer) needed }

     {$IFNDEF D2009UP}
     if UniCode
        then Edit.CmdSet_B(IDM_SourceView_Type, true) //Unicode source view
        else {$ENDIF} Edit.CmdSet(IDM_SourceView_Type); //default -> ANSI source view

     result :=  Edit.SelectedDocumentHTML(_SelStart, _SelEnd);

     {$IFDEF NoBOMShow}
        ExtractBOMString(result, FBom);

        case FBom of
           1: NumChar := 3; //we have delete 3 BOM chars
           2: NumChar := 1; { we have delete 1 BOM char
                              Unicode this is bad and the html source is most
                              likely wrecked if loaded back from HTML view }
           else NumChar := 0;
        end;

        //adjust sel start / end
        Dec(_SelStart, NumChar);
        Dec(_SelEnd, NumChar);
     {$ELSE}
        ReadBOM(result, FBom);
     {$ENDIF}
  end;
  //---------------------------------------
  procedure CheckSyncEnabled(var SelStart, SelEnd: Integer; SynDoc: boolean);
  begin
     if Edit.BrowseMode
        then begin
           if (SelStart <> SelEnd) and // there is a selection
              NoSyncInBrowseModeWarning
              then begin
                 NoSyncInBrowseModeWarning := true;
                 if SynDoc
                    then KsmessageI('Syncronisation of selection' + CrLf +
                         'with selection in source can' + CrLf +
                         'only be done in Edit mode');
              end;

           SelStart := 0;
           SelEnd := 0;
        end
        else NoSyncInBrowseModeWarning := false;
     end;
  //---------------------------------------
  procedure SetSyncDOC(Ws: WideString; _SelStart, _SelEnd: Integer);
  var
     Hr: HResult;
  begin
     CheckSyncEnabled(_SelStart, _SelEnd, true);

     {$IFDEF NoBOMShow}
        case FBom of
           1: begin
                 inc(_SelStart, 3); //compensate for missing BOM
                 inc(_SelEnd, 3);
              end;
           2: begin
                 inc(_SelStart);
                 inc(_SelEnd);
              end;
        end;

        Hr := Edit.SyncDOC(GetBOMString(FBom) + WS, _SelStart, _SelEnd);
     {$Else}
        Hr := Edit.SyncDOC(WS, _SelStart, _SelEnd);
     {$ENDIF}

     if not Edit.BrowseMode
        then CheckResult(Hr, 'Edit.SyncDOC', false, true);
  end;
  //---------------------------------------
begin
  //asm int 3 end; //trap

  //change to WYSIWYG
  if PageControl1.ActivePage = tabEdit
     then begin
        EnableAllButtons(true); //Enable all buttons
        mnuPrintpreview.enabled := true;

        tlb_Format.Visible := True;

        if SourceView  //we have been viewing the Source HTML - now sync the selection
           then begin
              if LastPage = tabHTML
                 then begin
                    //Sync Ansi edit - and from D 2009 up also Unicode edit

                    {$IFNDEF D2009UP}
                    Edit.CmdSet(IDM_SourceView_Type); //default -> ANSI source view
                    {$ENDIF}
                    
                    SelEnd := mmoHTML.SelStart + mmoHTML.SelLength;
                    SelStart := mmoHTML.SelStart;
                    SetSyncDOC(mmoHTML.Text, SelStart, SelEnd);
                 {$IFNDEF D2009UP}
                 end
                 else begin
                    //Sync Unicode edit
                    if not assigned(UniHTML)
                       then exit;

                    Edit.CmdSet_B(IDM_SourceView_Type, True); //Unicode source view

                    SelStart := uniHTML.SelStart;
                    SelEnd := uniHTML.SelEnd;
                    SetSyncDOC(UniHTML.Text, SelStart, SelEnd);
                    {$ENDIF}
                 end;

              SourceView := false;
           end;

        CheckResult(Edit.SetFocusToDoc, 'SetFocusToDoc', false, true);
        exit;
     end;

  EnableAllButtons(false); //UnEnable all buttons

  if (PageControl1.ActivePage = tabHTML) {$IFNDEF D2009UP} or
     (PageControl1.ActivePage = tabUniHTML) {$ENDIF}
     then begin
        //change view to Source HTML
        if PageControl1.ActivePage = tabHTML
           then begin
              if Edit.BrowseMode
                 then begin
                    SelStart := 0;
                    SelEnd := 0;
                 end;

              WS := GetSelectedDocumentHTML(false, SelStart, SelEnd);

              mnuPrintpreview.enabled := false;
              { put the HTML source in the memo and place the cursor or selection
                at the same pos in memo as in the WYSIWYG }

              mmoHTML.Text := WS;

              CheckSyncEnabled(SelStart, SelEnd, false);

              mmoHTML.Selstart := SelStart;
              mmoHTML.SelLength := SelEnd - SelStart;
              mmoHTML.SetFocus; //or the highlighted text might not show
              mmoHTML.ReadOnly := Edit.BrowseMode;

              //Scroll line with cursor to mid screen
              CurLine := SendMessage(mmoHTML.Handle, EM_LINEFROMCHAR, mmoHTML.SelStart, 0);
              CurTop := SendMessage(mmoHTML.Handle, EM_GETFIRSTVISIBLELINE, 0, 0);
              SendMessage(mmoHTML.Handle, EM_LINESCROLL, 0, -((CurTop - CurLine) div 2));
           end;

        {$IFNDEF D2009UP}
        //change view to Unicode Source HTML
        if (PageControl1.ActivePage = tabUniHTML) and
           assigned(UniHTML)
           then begin
              WS := GetSelectedDocumentHTML(True, SelStart, SelEnd);

              mnuPrintpreview.enabled := false;
              { put the HTML source in the Unicode memo and place the cursor or
                selection at the same pos in memo as in the WYSIWYG }

              UniHTML.Text := Ws;

              CheckSyncEnabled(SelStart, SelEnd, false);

              UniHTML.Selstart := SelStart;
              UniHTML.SelEnd := SelEnd;
              UniHTML.ReadOnly := Edit.BrowseMode;

              //Scroll line with cursor to mid screen
              CurLine := UniHTML.perform(EM_LINEFROMCHAR, UniHTML.SelStart, 0);
              CurTop := UniHTML.perform(EM_GETFIRSTVISIBLELINE, 0, 0);
              UniHTML.perform(EM_LINESCROLL, 0, -((CurTop - CurLine) div 2));
           end;
        {$ENDIF}

        SourceView := true;
        exit;
     end;


  //Change to preview
  if (PageControl1.ActivePage = tabPreview)
     then begin
        mnuPrintpreview.enabled := true;

        S := Edit.BaseUrl;
        if length(S) > 0
           then Preview.CmdSet_S(IDM_New_BaseURL, Edit.BaseUrl);

        if pos('ksx:', LowerCase(Edit.CurrentDocumentPath)) = 1
           then begin
              //load the current doc to Preview via the ksx protocol
              FDatatype := 5;
              Preview.go('ksx:dummy.htm');
           end
           else Preview.DocumentHTML := Edit.DocumentHTML;
     end;
end;
//-----------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.GetStyles;
begin
  //asm int 3 end; //trap
  cmbStyles.Items.Clear;
  TEIgnoreChange := True;

  //Get internal and external styles
  cmbStyles.Items.Text := Edit.GetAllStyles;

  TEIgnoreChange := False;
end;
//-----------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditDocumentComplete(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  if not Edit.BrowseMode
     then GetStyles;

  Caption := Application.Title + ' [' + Edit.DocumentTitle + ']';

  //these commands are not remembered across documents
  OV := true;
  CheckResult(Edit.CmdSet(IDM_LIVERESIZE, OV), 'IDM_LIVERESIZE');
  CheckResult(Edit.CmdSet(IDM_2D_POSITION, OV),'IDM_2D_POSITION');


  // FIX 11.11.11  -  Because there might be assigned a start-up document in TfrmMain.EditInitialize
  // we risk arriving heir before we have created FEditHelper in TfrmMain.EditDocumentComplete
  if not assigned(FEditHelper)
     then begin
       FEditHelper := TKSEdit_X.create(Edit);
       FEditHelper.OnDisplayChanged := EditDisplayChanged;
       FEditHelper.ShowRevisions(mnuShowmarkedRevisions.Checked);
     end;

  FEditHelper.InitializeDom;
     
  {$IFDEF AddictSpell}
     { Empty the dictionary that contains words added when the user
       clicked the spell dialogs Spell_IgnoreAll_btn or Spell_ChangeAll_btn

       These words are typically only med to be used in the current document
       and thus when we load a new document we'll want to drop those words }

     if assigned(aSpellChecker)
        then aSpellChecker.InternalCustom.RemoveAll;
  {$ENDIF}
end;
//-----------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditShowContextMenu(Sender: TObject; xPos, yPos: Integer);
begin
  //asm int 3 end; //trap
  { we could manage the popup menu heir, but as we consume the ONCONTEXTMENU
    event in the EditDesigners PreHandleEvent we never get heir anymore }

  PopUpMenu1.Popup(xPos, yPos);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnShowDetailsClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  Edit.ShowDetails := not Edit.ShowDetails;
  btnShowDetails.Down := Edit.ShowDetails;
  if Edit.ShowDetails
     then btnShowDetails.Hint := 'Hide glyphs'
     else btnShowDetails.Hint := 'Show glyphs';
end;
//------------------------------------------------------------------------------
function TfrmOcxHtmlEditor.EditQueryService(const rsid, iid: TGUID; out Obj: IUnknown): HRESULT;
begin
  //asm int 3 end; //trap
  { skeleton - just in case we want to experiment }

  Obj := nil;
  result := E_NOINTERFACE;
end;
//------------------------------------------------------------------------------
var
  Borders: boolean = false;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnBordersClick(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  Borders := not Borders;
  btnBorders.Down := Borders;
  ov := Borders;
  CheckResult(Edit.CmdSet(IDM_SHOWZEROBORDERATDESIGNTIME, ov), '');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnClearUndoStackClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_ClearUndoStack), '');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditPostEditorEventNotify(Sender: TObject; pinEvtDispId: Integer; const pIEventObj: IHTMLEventObj; var aResult: HRESULT);
var
  aIHTMLElement: IHTMLElement;
begin
  //asm int 3 end; //trap
  //every event comes heir after its done
  aResult := S_FALSE;

  aIHTMLElement := pIEventObj.Get_srcElement;

  if aIHTMLElement <> nil
     then begin
        if FCurrentStatusbarElement = aIHTMLElement as IUnknown
           then exit //no need to write aIHTMLElement.OuterHTML to status-bar by each move
           else FCurrentStatusbarElement := aIHTMLElement as IUnknown;

        if SameText(aIHTMLElement.tagName, 'BODY')
           then Statusbar1.Panels[0].Text:= 'Document.Body'
           else Statusbar1.Panels[0].Text:= aIHTMLElement.OuterHTML;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditPreHandleEvent(Sender: TObject; inEvtDispId: Integer; const pIEventObj: IHTMLEventObj; var aResult: HRESULT);
var
  P: tagPOINT;
  aDisplays: IDisplayServices;
  InsertAt: Integer;
  Ov: OleVariant;

  //------------------------
  function GetElementFromMousePos(var Pt: Tpoint): IHTMLElement;
  begin
     GetCursorPos(Pt);

     // Pt is in screen coordinate, change it to MSHTML window coordinate
     Windows.ScreenToClient(Edit.GetMSHTMLwinHandle, Pt);

     result := Edit.DOM.elementFromPoint(Pt.x, Pt.y);
  end;
  //------------------------
  procedure addOneSuggestion(NewWord, OldWord: widestring; aTag: Integer);
  var
     NewItem: TMenuItem;
  begin
     if length(NewWord) = 0  //in rear cases there can be empty words
        then exit;

     NewItem := TMenuItem.Create(Self);
     NewItem.Tag := 4710 + aTag;
     NewItem.Caption := NewWord;
     //NewItem.AutoHotkeys := maManual;

     if NewWord <> '-'
        then begin
           //because the caption may be changed - an & is inserted we need
           //to store a copy of the original suggestion word
           if aTag = 5
              then NewItem.hint := OldWord
              else NewItem.hint := NewWord;

           NewItem.OnClick := SpellPopClick;

           //add OnDrawItem and draw words as i.e. bold
        end;

     PopUpMenu1.Items.Insert(InsertAt, NewItem);
     inc(InsertAt);
  end;
  //---------------------------
  procedure addSpellingSuggestions(aRecord: OleVariant);
  var
     Words: TStringList;
     I: Integer;
     aType: Integer;
  begin
     InsertAt := 0;
     aType := aRecord[0];

     case aType of
        2: addOneSuggestion('Delete word', '', 2);
        3: addOneSuggestion('Delete space', '', 3);
        1, 4:
           begin
              addOneSuggestion('Add word to dictionary', aRecord[1], 5);
              addOneSuggestion('Edit word, then add to dictionary', aRecord[1], 6);

              Words := TStringList.Create;
              try
                 {$IFDEF AddictSpell}
                    { all spell checking components must have a call to suggest a list
                      of words.
                      Return suggestion a as CrLf separated list of words in Words}

                    aSpellChecker.Suggest(aRecord[1], Words);
                 {$ENDIF}

                 if (Words.Count > 0) and (Length(trim(Words[0])) = 0)
                    then Words.Delete(0);  //sometimes the first line is empty

                 if Words.Count > 0
                    then begin
                       //insert all suggestions
                       for I := 0 to Words.Count -1 do
                          addOneSuggestion(Words[I], '', aType);

                       { add additional menus like:
                          Add to dictionary
                          Ignore all
                          ..   }
                    end
                    else begin
                       addOneSuggestion('(no spelling suggestions)', '', 0);
                       PopUpMenu1.Items.Items[InsertAt-1].enabled := false;
                    end;


              finally
                 Words.free;
              end;
           end;

        else exit;
     end;

     //insert separation line
     addOneSuggestion('-', '', 0);
  end;
  //---------------------------

var
  aElement: IHTMLElement;
  ABookMGlyph: Boolean;
  noGlyph: Boolean;
  Pt2: Tpoint;
begin
  //asm int 3 end; //trap
  aResult := S_FALSE;

  if PageControl1.ActivePage <> tabEdit
     then exit;

     
  //every event comes heir before it is handled - return S_OK consumes the event
  case inEvtDispId of
     DISPID_HTMLELEMENTEVENTS_ONCONTEXTMENU:
        begin
           aresult := S_OK;

           //get click position
           P.X :=  pIEventObj.ScreenX;
           P.Y :=  pIEventObj.ScreenY;

           //transform click position to a screen pos
           aDisplays := Edit.DOM as IDisplayServices;
           aDisplays.TransformPoint(P, COORD_SYSTEM_CONTAINER, COORD_SYSTEM_GLOBAL, nil);


           aElement := GetElementFromMousePos(Pt2);

           ABookMGlyph := FEditHelper.IsBookMarkGlyphAttached(aElement);

           noGlyph := not ABookMGlyph;

           pmuUndo.Enabled := btnUndo.Enabled;
           pmuRedo.Enabled := btnRedo.Enabled;
           pmuCut.Enabled := NoGlyph and Edit.Selection;
           pmuCopy.Enabled := NoGlyph  and Edit.Selection;
           pmuPaste.Enabled := NoGlyph;
           pmuDelete.Enabled := true;
           pmuSelectAll.visible := NoGlyph;
           pmuHyperlink.visible := NoGlyph and NotALink(aElement) and Edit.Selection;

           EditBookM.visible := ABookMGlyph;
           InsBookM.Enabled := NoGlyph;

           EditHTML.visible := Edit.ActualRangeIsText;

           pmuUnlink.Enabled := Edit.QueryEnabled(IDM_UNLINK);

           //drop any old spelling suggestions
           while (PopUpMenu1.Items.Items[0].Tag >= 4710) and
                 (PopUpMenu1.Items.Items[0].Tag <=  4716) do
              PopUpMenu1.Items.Delete(0);

           if Edit.QueryEnabled(IDM_Get_Spell_Error)
              then begin
                 Ov := Edit.CmdGet(IDM_Get_Spell_ErrorEX);

                 { If something goes totally wrong -> normally only if the
                   command ID is unknown or no spell-checker is active.
                   Lets do an test anyway }
                 if (@Ov <> nil) and
                    ((TVariantArg(Ov).VT = VT_VARIANT or VT_ARRAY))
                    then begin
                       { OV:
                         ov[0] = record type: 0=empty, 1=word, 2=duplicated, 3=dblspaces, 4=hypernated
                         ov[1] = misspelled word
                              // mshtml coordinates of misspelled words bounding rect
                         ov[2] = left
                         ov[3] = top
                         ov[4] = right
                         ov[5] = bottom }

                       //prepare pop up menu
                       addSpellingSuggestions(Ov);

                       //pop up menu is set to just below the word
                       p.x := ov[2];
                       p.Y := ov[5];

                       //now convert to mshtml coordinates to screen coordinates
                       windows.ClientToScreen(Edit.GetMSHTMLwinHandle, TPoint(P));
                    end;
              end;


           PopUpMenu1.Popup(P.X, P.Y);
        end;
  end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.SpellPopClick(Sender: TObject);
var
  OV: OleVariant;
  TagId: Integer;
  {$IFDEF AddictSpell}
     aWord: String;
  {$ENDIF}     
begin
  //asm int 3 end; //trap
  Ov := (Sender as TMenuItem).hint;
  TagId := (Sender as TMenuItem).tag;

  case TagId of
     4710: exit; //do nothing
     4711: Ov := (Sender as TMenuItem).hint;  //change word
     4712, 4713: Ov := '';                    //delete word or dbl space

     4714: begin
              KsMessageI('You need to change hyphenated words manually');
              exit;
           end;

     4715: begin
              //add word to dictionary

              {$IFDEF AddictSpell}
                 aSpellChecker.ActiveCustomDictionary.AddIgnore(ModyFycase(Ov));
                 edit.CmdSet(IDM_Recheck_Spell_Error);
              {$ELSE}
                 NoSpellChecker;
              {$ENDIF}

              exit;
           end;

     4716: begin
              //Edit word before adding it to dictionary

              {$IFDEF AddictSpell}
                 if Edit.QueryEnabled(IDM_Get_Spell_Error)
                    then aWord := Edit.CmdGet(IDM_Get_Spell_Error)
                    else aWord := '';

                 PageControl1.SetFocus; //ensures highlighting of the selected text
                 if (DoDlg_AddWord(aWord, Edit) = mrOK) and
                    (Length(aWord) > 0)
                    then begin
                       aSpellChecker.ActiveCustomDictionary.AddIgnore(aWord);
                       edit.CmdSet(IDM_Recheck_Spell_Error);
                    end;
              {$ELSE}
                 NoSpellChecker;
              {$ENDIF}

              exit;
           end;
  end;

  if Edit.QueryEnabled(IDM_Spell_Replace)
     then CheckResult(edit.CmdSet(IDM_Spell_Replace, Ov), 'IDM_Spell_Replace')
     else KsMessageW('Failed to replace word');
end;
//------------------------------------------------------------------------------
function GetInitialDoc: string;
begin
  result := #$EF + #$BB + #$BF  +  //this is the UTF-8 BOM marker
            '<html><head><meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">' + #13 +
            '	<title>Thank you booking at our hotel</title>' + #13 +
            '	</head><body><div style="text-align: right;">' + #13 +
            '		<big style="font-weight: bold; color: rgb(51, 51, 255);">' + #13 +
            '			<big><big>Hotel Roomer</big></big></big><br>' + #13 +
            '				<small>Bosscheweg 107<br>5282 WV<br>Boxtel<br>Tel: +31 85 273 6150<br>date/time: ${currentDatetime}<br>---' + #13 +
            '					<br>Booking date: ${bookingDatetime}<br>Hotel Booking id: ${bookingRoomerId}</small><br></div>' + #13 +
            '					<big>Dear ${bookingGuestName},<br>' + #13 +
            '						<br>' + #13 +
            '						Thank you for your booking at Hotel Roomer.<br>' + #13 +
            '						<br>' + #13 +
            '						You will be arriving on the ${bookingArrival} and departing on ${bookingDeparture}.<br>' + #13 +
            '						Your booking ID: ${bookingRoomerId}<br>' + #13 +
            '						<br>' + #13 +
            '						Booking details:<br>' + #13 +
            '						<br>' + #13 +
            '						<br>' + #13 +
            '						${bookingGuestsRoomsPrices}<br>' + #13 +
            '						<br>' + #13 +
            '						Price and payment details:<br>' + #13 +
            '						<br>' + #13 +
            '						Total price: ${bookingTotalPrice}<br>' + #13 +
            '						Booking payment type: ${bookingPaymentType}<br>' + #13 +
            '						Payment status: ${bookingPaymentStatus}<br>' + #13 +
            '						Amount paid: ${bookingPaymentAmount}<br>' + #13 +
            '						Credit card: ${bookingPaymentCreditCard}<br>' + #13 +
            '						<br>' + #13 +
            '						We look forward to be of service to you and wish you a pleasant stay at our hotel.<br>' + #13 +
            '						<br>' + #13 +
            '						<big style="color: rgb(51, 51, 255); font-weight: bold;">' + #13 +
            '							Hotel Roomer</big>' + #13 +
            '							<br><small>Staff</small></big>' + #13 +
            '								<br>' + #13 +
            '								</body>' + #13 +
            '								</html>' + #13;


//  '<HTML><HEAD>' +
//       {you can either leave out the UTF-8 BOM marker or the following line but not both
//        - or else the unicode Hindi text wont display correctly. }
//
//       //'<META http-equiv=Content-Type content="text/html; charset=utf-8">' +
//       '</HEAD><BODY text=#000000 bgColor=yellow>' +
//       '<p>This is a custom initialization document with a bit of <B>Hindi</B> text:</p>' +
//       '<p></p>'+
//       '<!-- the following line is an UTF8 coded string of Hindi -->' +
//       '<p>मैं काँच खा सकता हूँ, मुझे उस से कोई पीडा नहीं होती</p>' +
//       '<p></p>'+
//       '<p></p>'+
//       '<p>(Remove the file OcxDHTML.xxx to get an empty startup-document instead. '+
//       'The custom document is just a hard coded gimmick inside the demo projects TfrmMain.EditInitialize procedure)</p>'+
//       '</BODY></HTML>';

  { you can load a similar "NewDocument" by replacing:
     Edit.NewDocument with
     Edit.DocumentHTML := GetInitialDoc;  }
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditInitialize(Sender: TObject; var NewFile: WideString);
begin
  //asm int 3 end; //trap
  { return the name of a file you want to open at startup
    i.e.: NewFile := Paramstr(1);
    or:   NewFile := 'V:\KHDev\KnowHow\000-304.htm';

    or:  NewFile := 'Empty' to start editing with a "nerly emty" document.

    do other initialization }

  CheckEditButton;


  Edit.CmdSet_B(IDM_LIVERESIZE, true);
  Edit.CmdSet_B(IDM_2D_POSITION, true);
 // Edit.CmdSet_B(IDM_BlockSelTableCells, true);

  Edit.CmdSet_B(IDM_NOFIXUPURLSONPASTE, true);
  Edit.CmdSet_B(IDM_AUTOURLDETECT_MODE, false);
  Edit.CmdSet_B(IDM_TabIntoTableCells, true);

  Edit.cmdset_S(IDM_Set_CellHiglight, 'Red:yellow');
  //Edit.CmdSet_B(IDM_PrematureShortCut, True);
       
  if FileExists(ChangeFileext(Paramstr(0), '.xxx'))
     then begin
        //load a custom initialization
        NewFile := 'InitDoc=' + GetInitialDoc;
     end
     else begin
        //or load a command line supplied file
        NewFile := Paramstr(1);
     end;

  //or load a "near empty" initial document
  //NewFile := 'Empty';

  TEIgnoreChange := True;
  cmbFontName.Items.text := Edit.GetFonts;
  TEIgnoreChange := False;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //asm int 3 end; //trap
  if Edit.EndCurrentDoc(true) = E_ABORT  //EndCurrentDoc({Cancel is possible})
     then Action := caNone;

  Ftable.free; //just in case
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.CheckEditButton;
begin
  //asm int 3 end; //trap
  if Edit.BrowseMode
     then begin
        btnEdit.ImageIndex := 19;
        btnEdit.Down := false;
        btnEdit.Hint := 'Browse mode';
     end
     else begin
        btnEdit.ImageIndex := 20;
        btnEdit.Down := true;
        btnEdit.Hint := 'Edit mode';
        GetStyles;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnEditClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  Edit.BrowseMode := not Edit.BrowseMode;
  CheckEditButton;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuRefreshClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_REFRESH), '');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Assign1Click(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  Ov := 'About:Blank';
  Edit.OleObject.Navigate2(Ov);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Gotowww1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.Go('http://www.msn.com/'), '', false, true);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.SetBaseURLbad1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  edit.BaseUrl := 'D:\test\';
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.SetBaseURLOK1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  edit.BaseUrl := Edit.CurrentDocumentPath;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.gotofile1Click(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  Ov := 'V:\KHDev\KnowHow\Kvalitet\html\000-304.htm';
  if not FileExists(Ov)
     then MessageDlg('File not found:' + #13+#10 + Ov + #13+#10 +
                     'You need to insert an existing file-path into the code'
                     , mtError, [mbOK], 0)
     else CheckResult(Edit.Go(Ov), '', false, true);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditGetDLControl(Sender: TObject; var varResult: Integer);
begin
  //asm int 3 end; //trap
  if UpdateUI
     then VarResult := VarResult and ($10 xor $FFFFFFFF) //DLCTL_DLIMAGES
     else VarResult := VarResult or $10;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditGetHostInfo(Sender: TObject; var dwFlags,
  dwDoubleClick: Cardinal; var chHostCss, chHostNS: WideString);
var
  iFileHandle: Integer;
  iFileLength: Integer;
  TmpString: String;
begin
  //asm int 3 end; //trap
  if UpdateUI
     then begin

        //first set a global style sheet

                   // NB !!! -> insert path to your own style sheet file
        iFileHandle := FileOpen('V:\KHDev\KnowHow\Kvalitet\Kvalsys.css', fmOpenRead);
        if iFileHandle > 0
           then begin
              try
                 iFileLength := FileSeek(iFileHandle, 0, 2);
                 FileSeek(iFileHandle, 0, 0);
                 SetLength(TmpString, iFileLength);
                 FileRead(iFileHandle, TmpString[1], iFileLength);

                 chHostCss := TmpString;
              finally
                  FileClose(iFileHandle);
              end;
           end;


        //next set all MSHTML scroll bars to flat

        dwFlags := dwFlags or $80; //DOCHOSTUIFLAG_FLAT_SCROLLBAR
     end
     else dwFlags := dwFlags and ($80 xor $FFFFFFFF);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.KSTestEdit1Click(Sender: TObject);
begin
  //asm int 3 end; //trap

  edit.generator := '';
  exit;

  //only used by KS for testing
  CheckResult(edit.CmdSet_S(KS_TEST, 'Edit1'), '');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.KSTestPreviewClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  
  //only used by KS for testing
  Preview.CmdSet_S(KS_TEST, 'Preview');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.KSTestEdit2Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  //only used by KS for testing
  CheckResult(edit.CmdSet_S(KS_TEST, 'Edit2'), '');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Navigate1Click(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  Ov := 'http://www.msn.com/'; 
  Edit.OleObject.Navigate2(Ov);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuUpdateUIClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  UpdateUI := not UpdateUI;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Testing1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  if PageControl1.ActivePage = tabFly
     then mnuItemClick(Sender)
     else mnuUpdateUI.Checked := UpdateUI;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditTranslateMessageString(Sender: TObject; var MessageString: WideString; out MessageNr: Integer);
begin
  //asm int 3 end; //trap
  { you'll fin a list of messages and the corresponding unique ID (MessageNr)
    in OCX documentation.txt

    If MessageNr = 0 the message is an windows generated message and you have
    to do a translation based on the actual error string }

  { NB if you return an empty string in MessageString the messagebox wont
    show up, and a click on the OK or Yes button is simulated }

  case MessageNr of
     7: begin
           MessageString := 'Document has changed.' +#13+#10+#13+#10+ 'Save changes ?';
//           //we'll change it a bit
//           MessageString := 'This pies of crap has been changed :-(' +
//                             #13+#10+#13+#10+
//                             'Do you really want to save it ?' + DblCrLf +
//                             '( If you want to change this message - look' + CrLf +
//                             '  up TfrmMain.EditTranslateMessageString  )';
        end;


      //further "translations
      // .....
      //......

     end;
 
end;
//------------------------------------------------------------------------------
function TfrmOcxHtmlEditor.CheckResult(HR: HResult; AMessage: String; _Preview: boolean = false; FunctionCall: boolean = false): Boolean;
var
  ErrMessage: WideString;
  ErrNumber: Integer;
  ErrIDNr: Integer;
  S: String;
begin
  //asm int 3 end; //trap
  result := SOK(HR);

  if result or
     (Edit.DebugMode and (not FunctionCall)) //the error has already been shown by KSDhtmledit
     then exit;

  ErrNumber := GetHResultError(HR);

  if ErrNumber > 0 //a custom error
     then begin
        //you can translate the original "error message" string
        if _Preview
           then begin
              ErrMessage := Preview.LastError; //the original English string
              ErrIDNr := Preview.LastErrID;    //unique ID for error message - see
           end
           else begin
              ErrMessage := Edit.LastError;
              ErrIDNr := Edit.LastErrID;
           end;

        //call the same translation procedure as KSDhtmledit does
        EditTranslateMessageString(Self, ErrMessage, ErrIDNr);

        ErrMessage := ErrMessage + DblCrLf +
                     'KSDhtmlEdit Error: $' + IntToHex(ErrNumber, 6);
     end
     else begin
        //not a custom error
        S := SysErrorMessage(HR);
        if S = '' //must be an OleError
           then FmtStr(S, SOleError, [HR]);
        ErrMessage := S;
     end;

  KSMessageE('Command failed:' + CrLf +
              AMessage +DblCrLf +
             'Errror message:' + CrLf +
              ErrMessage,
              'MSHTML Editor', handle);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuDrawsquareClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  mnuDrawsquare.checked := not mnuDrawsquare.checked;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.DrawSquare(Tr: TRect; aHandle: HWND);
var
  DC: HDC;
  Pen: hPen;
begin
  //asm int 3 end; //trap
  //draw a square

  DC := GetDC(aHandle);
  try
     Pen := CreatePen(PS_DOT, 0, ColorToRGB(clGreen));
     try
        SelectObject(DC, Pen);
        SetROP2(DC, R2_NOTXORPEN);
        RectAngle(DC, Tr.Left, Tr.Top, Tr.Right, Tr.Bottom);
     finally
        DeleteObject(Pen);
     end;
  finally
     ReleaseDC(aHandle, DC);
  end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditPostHandleEvent(Sender: TObject; inEvtDispId: Integer; const pIEventObj: IHTMLEventObj;
                                       var aResult: HRESULT);
var
  Pt: Tpoint;
  Pt_: Tpoint;
  aElement: IHTMLElement;
  _Element: IHTMLElement;
  MSHTMLwin: HWND;
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  aResult := S_FALSE;


  case inEvtDispId of

     DISPID_HTMLELEMENTEVENTS_ONCLICK:
        begin
           if not mnuDrawsquare.checked
              then exit;

           MSHTMLwin := Edit.GetMSHTMLwinHandle;

           //Get IHTMLElement below cursor

     // version 1 - the hard way
           GetCursorPos(Pt);   //mouse point in screen coordinates
           Windows.ScreenToClient(MSHTMLwin, Pt); //convert to client coordinates

           //This will also give us the mouse point in client coordinates
           Pt_.x := pIEventObj.x;
           Pt_.Y := pIEventObj.y;
                 //just a test
                 if (Pt.x <> Pt_.x) or (Pt.y <> Pt_.y)
                       { NB! if you move the mouse and click it at the same time you can
                         end up having a beep }
                       then beep;

           //finally get the element
           aElement := Edit.DOM.elementFromPoint(Pt.x, Pt.y);



     // version 2 - a very simple way
           _Element := Edit.ActualElement;
                    //just a test
                    if (aElement as IUnknown) <> (_Element as IUnknown)
                       { NB! if you click the body Edit.ActualElement is always
                         the nearest visible element while elementFromPoint
                         returns the BODY tag }
                       then begin
                          //beep;
                       end;


     // version 3 - another simple way
           _Element := pIEventObj.srcElement;
                    //just a test
                    if (aElement as IUnknown) <> (_Element as IUnknown)
                       { NB! if you move the mouse and click it at the same time you can
                         end up having a beep }
                       then beep;


           //Get the Trect surrounding the element
           if SOK(Edit.GetElementRect(aElement, Ov, false {return MSHTML-window coordinates}))
              then begin
                 { Draw a square around the element.
                   At second click the square is erased again }
                 DrawSquare(Variant2TRect(Ov), MSHTMLwin);
              end;
        end;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditShortCut(Sender: TObject; out CmdID: Cardinal; var Cancel: WordBool);
begin
  //asm int 3 end; //trap
   { This is the place to grab any shortcut or key combination's we don't want 
     MSHTML to handle, or call functions that MSHTML cant do directly.

     Look up further information in "OCX documentation.txt" }

  Cancel := true;

  case CmdID of
     { we want the following commands to do something special or
       something MSHTML cant do directly }
       
     //IDM_FIND:         btnFindClick(Self);        //Ctrl + f
     IDM_NEW_TOPLEVELWINDOW:  btnNewClick(Self);  //Ctrl + n
     IDM_OPEN:         btnOpenClick(Self);        //Ctrl + o
     IDM_PRINT:        btnPrintClick(Self);       //Ctrl + p
     IDM_REMOVEPARAFORMAT:    mnuPrintpreviewClick(Self); //Ctrl + q
     IDM_SAVE:         btnSaveClick(Self);        //Ctrl + s
     IDM_CHANGEFONT:   btnFontClick(Self);
     //IDM_DELETE:       Cancel := false; {NOP}     //Delete key pressed
     //IDM_DELETEWORD:   Cancel := false; {NOP}     //Crrl + Delete key pressed
     
     0: begin
           { this is an untranslated shortcut 
             i.e. one of the following key combinations 
             Ctrl + d, g, h, j, m, r, t
             Crtl + Shift + d, e, g, h, j, k, l, m, o, q, r, s, t, x, y  }

           Cancel := false; //or we'll kill all key input

           if GetAsyncKeyState(VK_CONTROL) <> 0
              then begin
                  if GetAsyncKeyState(68) <> 0 
                    then begin
                       // Control + d was pressed

                       if (btnBold.Enabled and btnItalic.Enabled) and
                          (btnBold.down = btnItalic.down)
                          then begin
                             //both Bold and Italic is enabled and in sync

                             Edit.CmdSet(IDM_BOLD);
                             Edit.CmdSet(IDM_Italic);

                             Cancel := true; //tell mshtml to skip this keystroke
                          end;
                    end;
              end;

           { Heir you can handle a Alt + .. keykombinations before its
             treated as a hot key on i.e. a menu }

           (*
           if GetAsyncKeyState(VK_MENU) <> 0
              then begin
                  if GetAsyncKeyState(70) <> 0
                    then begin
                       // Alt + f was pressed
                      
                       Cancel := true; //Don't activate the File menu
                    end;
              end;
            *)
        end;


     else Cancel := false;
  end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Printwithtemplate1Click(Sender: TObject);
var
  Ov: olevariant;
begin
  //asm int 3 end; //trap
  { SetPrintTemplate is called with a 8 item string array of type TPrintSetup:

    TemplatePath: string;
    FPageInf: integer; //0 = default MSHTML template, 1 = inches, or 2 = mm
                       //this measures is inches -> mm / 25,4 => inches or mm
    FHeaderFormat: string;
    FooterFormat: string;

        in FHeaderFormat and FooterFormat we can insert IE's own page setup codes,
        but we can also add DOC (as the first tree characters) to get the document
        name (without path) or in stead of &u (the default IE-code) witch prints
        the full document path

    Margin_Top: string;
    Margin_Bottom: string;
    Margin_Left: string;
    Margin_Right: string;
    Orientation: string;

    if TemplatePath is set the rest of the array can be empty and the template in
    TemplatePath is used as print basis

    if TemplatePath is empty the IE-build-in template is used as print basis

    if FPageInf = 0 the rest of the array can be empty, and the values set in the
    IE print setup dialog is used for printing

    if FPageInf = 1 then all margins is in inches
    if FPageInf = 2 then all margins is mm

    if an error is encountered then read the property LastError }



           ov := VarArrayCreate([0, 8], varVariant);
           ov[0] := ''; //TemplatePath
           ov[1] := 2;  //FPageInf
           ov[2] := 'Dette er hovedet'; //FHeaderFormat
           ov[3] := 'Dette er bunden'; //FooterFormat
           ov[4] := '50';//Margin_Top
           ov[5] := '70'; //Margin_Bottom
           ov[6] := '25';//Margin_Left
           ov[7] := '25'; //Margin_Right
           ov[8] := '2';//'Portrait';//Orientation

  CheckResult(edit.PrintPreview(Ov), 'PrintPreview', false, true);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuClassicselClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  { IDM_BlockSelTableCells turns on a selection mode that i designed to match
    a "classic way" of selection table cells like its found in FrontPage or Word

    In defaul mode each cell, witch is dragged over, is heighlighteding }

  CheckResult(Edit.CmdSet_B(IDM_BlockSelTableCells, not mnuClassicsel.checked), 'IDM_BlockSelTableCells');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTatablecellsClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  { IDM_TabIntoTableCells turns on a TAB- mode where tabbing into table cells
    is enabled like its found in FrontPage or Word

    In default mode Tabbing only selects a Table and doesn't jump into its cells }

  CheckResult(Edit.CmdSet_B(IDM_TabIntoTableCells, not mnuClassicsel.checked), 'IDM_TabIntoTableCells');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuHighlightcellsClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  { IDM_HighlSelTableCells turns on a selection mode where selected cells is
    highlighted }

  CheckResult(Edit.CmdSet_B(IDM_HighlSelTableCells, not mnuHighlightcells.checked), 'IDM_HighlSelTableCells');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.CreateFlyClick(Sender: TObject);
//var
 // Ov: OleVariant;
begin
  //asm int 3 end; //trap

  FlyEdit := TKSEditX.Create(self);
  if assigned(FlyEdit)
     then begin
        FlyEdit.Parent := tabFly;

        FlyEdit.Align := alClient;

        //attach event handler
        FlyEdit.OnDisplayChanged := FlyEditDisplayChanged;

        FlyEdit.BrowseMode := false; //set edit-mode

        if SOK(FlyEdit.CmdSet(IDM_initialize))//, Ov))
           then begin
              LoadFile.Enabled := true;
              InsImage.Enabled := true;
              DestroyFly.Enabled := true;
           end;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Create100Click(Sender: TObject);
var
  Ov: OleVariant;
  I: Integer;
begin
  //asm int 3 end; //trap

  // just to test that dynamically created instances of KsDhtmlEdit doesn't
  // throw errors anymore

  if assigned(FlyEdit)
     then DestroyFlyClick(self);

  for I := 0 to 100 do
     begin

       FlyEdit := TKSEditX.Create(self);
       if assigned(FlyEdit)
           then begin
              FlyEdit.Parent := tabFly;
              FlyEdit.Align := alClient;

              //attach event handler
              FlyEdit.OnDisplayChanged := FlyEditDisplayChanged;

              FlyEdit.BrowseMode := false; //set edit-mode

              if SOK(FlyEdit.CmdSet(IDM_initialize, Ov))
                 then begin
                    LoadFile.Enabled := true;
                    InsImage.Enabled := true;
                    DestroyFly.Enabled := true;
                 end
                 else break;
           end
           else break;

           KsWait(10);
           DestroyFlyClick(self);
     end;

  if I = 101
     then ksMessageI('Finished')
     else ksMessageI('Error');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.FlyEditDisplayChanged(Sender: TObject);
begin
  //asm int 3 end; //trap
  if PageControl1.ActivePage = tabFly
     then begin
        ToUndo.Enabled := (FlyEdit.QueryStatus(IDM_UNDO) and OLECMDF_ENABLED) <> 0;
        ToRedo.Enabled := (FlyEdit.QueryStatus(IDM_REDO) and OLECMDF_ENABLED) <> 0;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.InsImageClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(FlyEdit.CmdSet(IDM_IMAGE), 'IDM_IMAGE');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.LoadFileClick(Sender: TObject);
var
  aFile: Widestring;
begin
  //asm int 3 end; //trap

  CheckResult(FlyEdit.LoadFile(aFile, true), 'LoadFile', false, true);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.DestroyFlyClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  if assigned(FlyEdit)
     then begin
        LoadFile.Enabled := False;
        InsImage.Enabled := False;
        DestroyFly.Enabled := False;
        ToUndo.Enabled := False;
        ToRedo.Enabled := False;

        FlyEdit.Parent := nil; //really not needed

        FlyEdit.Free;
        FlyEdit := nil;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.ToUndoClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(FlyEdit.CmdSet(IDM_UNDO), 'IDM_UNDO');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.ToRedoClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(FlyEdit.CmdSet(IDM_REDO), 'IDM_REDO')
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuItemClick(Sender: TObject);
var
  I: Integer;
  aMenuItem: TMenuItem;
begin
  //asm int 3 end; //trap
  aMenuItem := Sender as TMenuItem;

  if PageControl1.ActivePage = tabFly
     then begin
        for I := 0 to aMenuItem.Count-1 do
           aMenuItem.Items[I].Enabled := False;
      end
      else begin
        for I := 0 to aMenuItem.Count-1 do
           aMenuItem.Items[I].Enabled := true;
      end;;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuLinktoClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  ShellExecute(Application.Handle, 'open',
    'http://groups.yahoo.com/group/KSDhtmlEdit/', nil, nil, 0);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Download1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  ShellExecute(Application.Handle, 'open',
    'http://www.addictivesoftware.com/dicts.htm', nil, nil, 0);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Button1Click(Sender: TObject);
begin
  //asm int 3 end; //trap

  FrmModal := TFrmModal.Create(self);
  FrmModal.Height := 456;
  FrmModal.Width := 528;

  try
     if FrmModal.ShowModal = mrOK
        then KsMessageI('Modal success', '', handle)
        else KSMessageW('Modal cancel', '', handle);
  finally
     FrmModal.Free;
     FrmModal := nil;
  end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditMessage(Sender: TObject; var msg: Cardinal;
                               var wParam, lParam, Result: Integer);
begin
  //asm int 3 end; //trap

  { Heir we can block VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN, VK_TAB and VK_ESCAPE from
    being handled inside mshtml }


  if (msg = WM_KEYDOWN) or (msg = WM_KEYUP)
     then begin
        { if wParam = VK_RIGHT
            then Result := 1; }

        // Work-around: various F-keys does not reach the menus
        if (PageControl1.ActivePage = tabEdit) and
           (wParam = VK_F7)
           then begin
              F7Spelling;
              Result := 1;
           end;
     end;

  { If you for some reason wants keys to be treated as hot-keys before they
    are handled by the editor - do this:

     if msg = WM_GETDLGCODE
        then Result := 0;
   }
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuKsxloadfromfileClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  FDatatype := 1; //we use 1 to identify a file load
  CheckResult(Edit.go('ksx:page1.htm'), 'Load Doc from stream', false, true);
  // the path to page1.htm is added in "procedure TfrmMain.EditGetStreamData"
end;
//------------------------------------------------------------------------------
function TfrmOcxHtmlEditor.ActivateTable: Boolean;
begin
  //asm int 3 end; //trap
  result := true;
  if assigned(FTable)
     then exit
     else FTable := TTable.Create(nil);

  if assigned(FTable)
     then begin
       //get the path to our test-data
       FTable.DatabaseName := ExtractFilePath(Application.ExeName) +  'TestData\';

       FTable.TableName := 'testprogram.db';
       FTable.active := true;
     end
     else begin
        KSMessageE('Could not open table: ' + CrLf + FTable.DatabaseName, '', handle);
        result := false;
        exit;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuKsxloadfromDBClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  { there is two ways to load a steam into Edit.DOM:
    - navigate to a specific handled protocol (ksx, http or file)
    - load a stream trough IDM_Set_Doc_Stream -> see: TfrmMain.mnuLoadstreamtoDOCClick }

  if not ActivateTable
     then exit;

  FDatatype := 2; //we use 2 to identify a database load
  CheckResult(Edit.go('ksx:page1.htm'), 'Load doc from DB', false, true);
  // the path to testprogram.db (contains page1.htm) is handled in "function TfrmMain.ActivateTable: Boolean"
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuLoadstreamtoDOCClick(Sender: TObject);
var
  aFileName: String;
  aIStream: IUnknown;
  aResult: HRESULT;
  OvIn: OleVariant;
  OvOut: OleVariant;
begin
  //asm int 3 end; //trap

  { there is two ways to load a steam into Edit.DOM:
    - load a stream trough IDM_Set_Doc_Stream 
    - navigate to a specific handled protocol (ksx, http or file) -> see: TfrmMain.mnuNSloadfromDBClick }

  //get our test-page (page1.htm) as a stream
  aFileName := ExtractFilePath(Application.ExeName) +  'TestData\page1.htm';
  aResult := GetStream(aFileName, aIStream);

  if SOK(aResult)
     then begin
        edit.BaseUrl := ExtractFilePath(aFileName);

        OvIn := aIStream;
        OvOut := 'http';
        FSpecialHttpHandling := true;  //a signal to EditGetStreamData
        FDatatype := 1; //we use 1 to identify a file load
        CheckResult(Edit.Exec(IDM_Set_Doc_Stream, OvIn, OvOut), 'IDM_Set_Doc_Stream');
        FSpecialHttpHandling := false;
     end
     else KSMessageE('Bad filename: '+CrLf + aFileName);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.SaveFile(filename: String);
begin
  CheckResult(Edit.SaveFileAs(filename), 'SaveFile', false, true);
  SaveToRoomer := True;
end;

function TfrmOcxHtmlEditor.SaveStreamToDB(aName: String; aStream: IStream): HResult;
begin
  //asm int 3 end; //trap

  Result := S_False;

  if not ActivateTable  // open testprogram.db making it ready for storing the document
     then exit; //error

  //save data to our DB
  if FTable.Locate('Url', aName, [locaseinsensitive])
     then begin
     //TO DO:
     //add a warning before overwrite existing data

        if assigned(aStream)   //we do have data-stream
           then begin
              FTable.edit;
              TBlobField(FTable.FieldByName('Content')).LoadFromStream(TOleStream.Create(aStream));
              FTable.post;
              Result := S_OK;
           end;
     end
     else begin
        FTable.edit;
        FTable.AppendRecord([aName]);
        FTable.edit;
        TBlobField(FTable.FieldByName('Content')).LoadFromStream(TOleStream.Create(aStream));
        FTable.post;
        Result := S_OK;
     end;
end;
//------------------------------------------------------------------------------
function TfrmOcxHtmlEditor.GetStream(aPath: String; var _Stream: IUnknown): HResult;
var
  OvIn: OleVariant;
  OvOut: OleVariant;
begin
  //asm int 3 end; //trap
  //get file from (FTP, Gopher, or HTTP) URL

  OvIn := aPath;
  result := Edit.Exec(IDM_Get_Stream, OvIn, OvOut);

  if CheckResult(result, 'IDM_Get_Stream')
     then _Stream := OvOut;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditGetStreamData(Sender: TObject; const Url: WideString; var aStream: IUnknown; var aResult: HRESULT);
var
  aFileName: String;
  aPath: String;
  Strm: IStream;
  Ov: OleVariant;
  //FileStream: TFileStream;
begin
  //asm int 3 end; //trap

  { we'll come heir when a ksx: (or eventually http) document is loaded,
    refreshed or Browsemode is turned on / off (when such a document is loaded) }

  aResult := S_False;

  if pos('http:', lowerCase(URL)) = 1
     then begin
        if FSpecialHttpHandling
           then begin
             // FSpecialHttpHandling := false; //clear the flag
              aFileName := AfterLastToken(URL, ':');
              aFileName := ExtractFilePath(Application.ExeName) +  'TestData\' + aFileName;
              aResult := GetStream(aFileName, aStream);
           end
           else begin
              aResult := GetStream(URL, aStream);
              if SOK(aResult)
                 then KsMessageI('Now reading:' + crLf + URL, '', handle);
           end;
        exit;
     end;

 if pos('file:', lowerCase(URL)) = 1
  then begin
     aFileName := copy(URL, 8, Length(URL));
     if pos('/', aFileName) = 1
        then delete(aFileName, 1, 1);

     if FileExists(aFileName)
        then begin
           aResult := S_OK; //just return S_OK and KSDhtmlEdit will load the file

           (* or load the file and return it as a IStream

                   //create an IStream we can fill with data and return
           If SFail(CreateStreamOnHGlobal(0, True{DeleteOnRelease}, Strm))
              then exit;

           FileStream := TFileStream.Create(aFileName, fmOpenRead);

           try
              TOleStream.Create(Strm).CopyFrom(FileStream, 0{copy everything});
              aStream := Strm as IUnknown;
              aresult := S_OK;
           finally
              FileStream.Free;
           end;
          *)
        end;

      exit;
  end;


  aFileName := AfterLastToken(URL, ':');

  case FDataType of
     1: begin //a file load request

           aFileName := ExtractFilePath(Application.ExeName) +  'TestData\' + aFileName;
           aResult := GetStream(aFileName, aStream);

           (*
           //Alternative you can do this:

           //create an IStream we can fill with data and return
           If SFail(CreateStreamOnHGlobal(0, True{DeleteOnRelease}, Strm))
              then exit;

           if not FileExists(aFileName)
              then begin
                 KSMessageE('File not found:' + CrLf + aFileName);
                 exit; //error
              end;

           FileStream := TFileStream.Create(aFileName, fmOpenRead);

           try
              TOleStream.Create(Strm).CopyFrom(FileStream, 0{copy everything});
              aStream := Strm as IUnknown;
              aresult := S_OK;
           finally
              FileStream.Free;
           end;
           *)
        end;

        
     2: begin //a DB load request
           if not ActivateTable
              then exit; //error

           If SFail(CreateStreamOnHGlobal(0, True{DeleteOnRelease}, Strm))
              then exit;

           if FTable.Locate('Url', aFileName, [locaseinsensitive])
              then begin
                 TBlobField(FTable.FieldByName('Content')).SaveToStream(TOleStream.Create(Strm));
                 aStream := Strm as IUnknown;
                 aresult := S_OK;
              end
              else begin
                 KSMessageE('Url: '+ aFileName+ CrLf +'not found in table', '', handle);
                 exit; //error
              end;
        end;

     4: begin //refresh a new picture from file
           if not ActivateTable
              then exit; //error

           //if aFileName = something
           //  .. .. .. .. .. 
           // we always just insert the same picture in this demo app 
                        
           aPath := ExtractFilePath(Application.ExeName) +  'TestData\' + 'dancer.gif';
           aResult := getstream(aPath, aStream);

           if SOK(aResult)
              then begin
                  //add the new stream to our DB also
                  aresult := SaveStreamToDB(aFileName, aStream as IStream);

                  //as we now can get the picture from DB
                  FDatatype := 2;
              end;
        end;

     5: begin //Load current document to preview
           if not SameText(aFileName, 'dummy.htm')
              then KSMessageE('Unknown "DataType" request', '', handle)
              else begin
                 {$IFDEF DXE2UP}
                          // EmptyParam is not a Var any longer but a function result
                    aResult := Edit.Exec(IDM_Get_Doc_Stream, POlevariant(Nil)^, Ov);
                 {$ELSE}
                    aResult := Edit.Exec(IDM_Get_Doc_Stream, EmptyParam, Ov);
                 {$ENDIF}

                 if SOK(aResult)
                    then begin
                       aStream :=  IUnknown(Ov) as Istream;
                       FDataType := 2; //we load the rest from DB
                    end;
              end;
        end;
        
     else
        KSMessageE('Unknown "DataType" request', '', handle);
        exit; //error
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuhttpstreamingONClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet_B(IDM_Http_Streaming, true), 'IDM_Http_Streaming ON');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuhttpstreamingOFFClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet_B(IDM_Http_Streaming, false), 'IDM_Http_Streaming OFF');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuSaveDocToDbClick(Sender: TObject);
var
  OV: OleVariant;
  HR: HResult;
  aFileName: String;
begin
  //asm int 3 end; //trap

  {$IFDEF DXE2UP}
            // EmptyParam is not a var any longer but a function result
      HR := Edit.Exec(IDM_Get_Doc_Stream, POlevariant(Nil)^, Ov);
  {$ELSE}
     HR := Edit.Exec(IDM_Get_Doc_Stream, EmptyParam, Ov);
  {$ENDIF}

  if not CheckResult(HR, 'IDM_Get_Doc_Stream')
     then exit;

  aFileName := AfterLastToken(Edit.CurFileName, ':'); //drop ksx protocol - if any

  Hr := SaveStreamToDB(aFileName, IUnknown(Ov) as Istream);
  if SOK(Hr)
     then Edit.IsDirty := false;  // document has been saved

  CheckResult(HR, 'Save DOC Stream To DB');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.ksxinsertpicture1Click(Sender: TObject);
var
  aElement: IHTMLElement;
begin
  //asm int 3 end; //trap

  { adding a new picture with a relative address (no path in the src-filename)
    we'll cause EditStreamData to be called in order to get a stream that contains
    the new picture when it is needed }

  FDatatype := 4; //we use 4 to identify a request for a new picture from file

  { Because the picture is not yet saved to DB we need a way to grape it from file
    again when it is needed.
    FDatatype := 4

    If we also saved the picture to DB at this point we could use
    FDatatype := 2 instead }

  CheckResult(Edit.CreateElement(TAGID_IMG, aElement, nil, 'src=LitleMan'), 'Insert picture');
  // the actual loading and inserting of the img is handled in "procedure TfrmMain.EditGetStreamData"
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuGetcaretpositionClick(Sender: TObject);
var
  aPoint: OleVariant;
begin
  //asm int 3 end; //trap

  if not CheckResult(Edit.GetCarretPos(aPoint, FCaretPosElement), 'Getcaretposition')
     then begin
        FCaretPosElement := nil;
        exit;
     end;

  FCaretPos := Variant2TPoint(aPoint);

  MessageDlg('Current Caret position:'+ DblCrLf +
             'Y -> ' + IntToStr(FCaretPos.Y) + CrLf +
             'X -> ' + IntToStr(FCaretPos.X) + DblCrLf +
             'Current Element HTML:'+ DblCrLf +
             Trim(FCaretPosElement.OuterHtml), mtInformation, [mbOK], 0);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuRestorecaretpositionClick(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap

  if FCaretPosElement = nil
     then begin
        MessageDlg('You need to get a caret position first' + CrLf +
                   '( Menu: Get Caret position )', mtError, [mbOK], 0);

        exit;
      end;

  //clear any selection just to avoid confusion
  Edit.DOM.Selection.clear;

  //restore previous caret pos.
  Ov := TPoint2Variant(FCaretPos);
  CheckResult(Edit.SetCarretPos(Ov, FCaretPosElement), 'Restorecaretposition');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditDragAndPaste(Sender: TObject; EventType: Integer; const DataObject: IUnknown);
const
  DntDrag = 'dont drag me';
  PlsDrag = 'please drag me';
//var
  //aIDataObject: IDataObject;

  //-------------------------------------------
  procedure DragLeave;
  begin
     { an "empty" event to notify that the mouse was moved out of the
       editor window }

     FBlockDragText := false;
  end;
  //-------------------------------------------
  procedure DragOver;
  begin
     // only details available

     // This event occurs on each mouse movement

     if FBlockDragText                                     //block
        then CheckResult(edit.CmdSet_I(IDM_Drag_SetEffect, 0), 'SetEffect');
  end;
  //-------------------------------------------
  procedure DragEnter;
  var
     pInVar: OleVariant;
     Ovres: OleVariant;
     S: String;
  begin
     // dataObject and details available

     { This event occurs:
       1) at the beginning of a drag inside the KSDhtmlEdit window
       2) when the cursor enters the KSDhtmlEdit window

       The dragged content can be acquired trough the helper function
       IDM_Drag_GetHTMLfragment in several formats:

       CF_TEXT        -> ANSI text
       CF_UNICODETEXT -> UNICODE text
       CF_HTML        -> HTML code
       CF_RTF         -> RTF coded text

       Get all supported formats trough IDM_Drag_EnumFormats }

     FBlockDragText := false;

     if mnuDontdragme.checked
        then begin
           //can we get drag content as text ?
           if (Edit.QueryStatus(IDM_Drag_TextAvailable) and OLECMDF_ENABLED) <> 0
              then begin
                 pInVar := CF_TEXT;
                 if CheckResult(edit.Exec(IDM_Drag_GetHTML, pInVar, Ovres), 'IDM_Drag_GetHTML')
                    then S := Ovres
                    else S := '';

                 FBlockDragText := pos(DntDrag, LowerCase(S)) > 0;
              end
              else {NOP} ;{ we are probably dragging a single
                            site selectable element (like an image or a table)
                            Only CF_HTML and CF_RTF is Available in this case }
        end;

  end;
  //-------------------------------------------
  function KnownPathType(URL: String): Boolean;
  const
     Paths = 'file:http:https:';
  var
     S: String;
  begin
     S := LowerCase(copy(Url, 1, pos(':', url)));
     result := pos(s, Paths) > 0;
  end;
  //-------------------------------------------
  procedure CheckDragPaste;
  const
    msStuff = 'urn:schemas-microsoft-com:';
     //'?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office"';

    SFrag = '<!--StartFragment-->';  //the actual HTML-fragment is stored on the
    EFrag = '<!--EndFragment-->';    //clipbord sorounded by two comments

  var
     MArkSserv: IMarkupServices;
     MkStart: IMarkupPointer;
     MkFinish: IMarkupPointer;
     MarkCont: IMarkupContainer;

     FragmentDOC: IHTMLDocument2; //temporary DOM object
     aCollection: IHTMLElementCollection;
     aElement: IHTMLElement;
    // aMetaElement: IHTMLMetaElement;
     aImgElement: IHTMLImgElement;
     Ws: WideString;
     HTMLout: wideString;
     SourceURL:  String;
     aURL:  String;

     I, I2, I3: Integer;
     pInVar: OleVariant;
     Ov: OleVariant;
     Changed: Boolean;
     S: String;
     ElementRemoved: boolean;
  begin

     { Create a new temporary IHTMLDocument2 via IMarkupServices.ParseString
       from the HTML-document found on the clipboard.

       Its also possible to request just the actual pasted-HTML fragment
       trough a call to Ws := edit.CmdGet(IDM_Drag_GetHTML);
       Althoug it may be more cumbersome to work with a string than a DOM

       Th function calls IDM_Drag_GetData, IDM_Drag_GetHTML and IDM_Drag_GetSourceUR
       is just convience helper functions  - you can also access the clipbord
       data directly trugh the supplyed DataObject (DataObject as IDataObject).

       NB ! you can only read data from the DataObject. Any changed HTML you want
       to be pasted must be send to edit trug a IDM_Drag_SetHTML call.

       Internally edit waits for mshtml to ask for the clipbord data and then
       pass it a temporary IDataobject containing your changed HTML. mshtml
       then reads "your data" and paste it. }


     MArkSserv := Edit.DOM as IMarkupServices;
     try
        pInVar := CF_HtmlDoc;
        if CheckResult(edit.Exec(IDM_Drag_GetData, pInVar, Ov), 'IDM_Drag_GetHTML')
           then WS := Ov
           else exit;

        //ParseString needs a pair of temporary MarkupPointers
        MArkSserv.CreateMarkupPointer(MkStart);
        MArkSserv.CreateMarkupPointer(MkFinish);

        {$IFDEF OldMSHTML}
           MArkSserv.ParseString(word(WS[1]), 0, MarkCont, MkStart, MkFinish);
        {$ELSE}
           MArkSserv.ParseString(PwideString(WS), 0, MarkCont, MkStart, MkFinish);
        {$ENDIF}

        //get our temp IHTMLDocument from our new IMarkupContainer
        MarkCont.QueryInterface(IID_IHTMLDocument, FragmentDOC);
     except
        KsMessageE('Bad  HTML document received in procedure EditDragAndPaste');
        exit;
     end;



    { The to be pasted HTML-fragment is now contained in the body of FragmentDOC
      starting after the marker element <!--StartFragment --> and ending
      before the marker element <!--EndFragment -->

      If the HTML-fragment is changed during this procedure wee need to extract
      the resulting fragment from FragmentDOC.Body.innerHTML, drop anything
      up to the end of '<!--StartFragment -->' and after the beginning of
      '<!--EndFragment -->'.

      The resulting string must then be send back to the edit compnent trugh a
      call to edit.CmdSet(IDM_Drag_SetHTML,...

      After wich the returned HTML-fragment will be pasted to the editor content }


     Changed := false;


     //check if we need to change relative image-paths to absolute paths ?
     if mnuPastepathsabsolute.Checked  //paste absolute filepath as relative (is checked)
        then begin
           //get all images from FragmentDOC
           aCollection :=  FragmentDOC.images;

           if aCollection.length > 0  //we do have images in FragmentDOC
              then begin
                 //See if we can get SourceURL from our drop / paste source
                 SourceURL := edit.CmdGet(IDM_Drag_GetSourceURL);

                 if length(SourceURL) > 0  //we do have a source URL
                    then begin
                       //strip of file name from SourceURL
                       SourceURL := StringReplace(SourceURL, '\', '/', [rfReplaceAll]);
                       I3 := LastChar(SourceURL, '/');
                       delete(SourceURL, I3 +1, length(SourceURL));


                       for i := 0 to aCollection.length - 1 do
                          begin
                             aImgElement := aCollection.item(i, 0) as IHTMLImgElement;

                             if not assigned(aImgElement)
                                then continue;

                             { We cant use a IHTMLImgElement's href property because
                               mshtml returns a reconstructed full path and it may
                               very well be wrong.

                               But OuterHtml will always contain the scr in a
                               fixed format like src="......"  }

                             aURL := (aImgElement as IHTMLElement).OuterHtml;

                             //drop anything up to start of the source URL
                             Delete(aURL, 1, pos('src="', aURL) + length('src="') -1);

                             //find end of URL and drop rest
                             Delete(aURL, pos('"', aURL), length(aURL));

                             //now we have isolated the IMG's source URL

                             //is the source URL relative ?
                             if not KnownPathType(aURL)
                                then begin
                                   //we got a relative IMG path - fix it

                                   GetAbsolutePath(SourceURL, aURL);
                                   Ov := aURL;

                                   //change the src attribute to absolute path
                                   (aImgElement as IHTMLElement).setAttribute('src', Ov, 0);
                                   Changed := true;

                                   { It's also be possible to download the source-IMG
                                     to a local destination and set the IMG-scr accordingly }
                                end;
                          end;
                    end;
              end;
        end;


     //Clean the messy HTML coming fro a Word drag or paste ?
     if mnuRawHtml.Checked
        then begin
           if not changed     //if the HTML hasn't been changed so far -> get a snap shoot
              then HTMLout := FragmentDOC.body.InnerHtml; //we'll use it later


           aCollection := FragmentDOC.body.all as IHTMLElementCollection;

           { It might be necessary to repeat because we might skip over some
             tags because the DOM is restructured when we delete a tag   }

           ElementRemoved := true; //enable us to step into the loop

           //Repeat as long as a tag was removed during the loop
           while ElementRemoved do
              begin
                ElementRemoved := false;

                 for i :=  aCollection.length - 1 downto 0 do
                    begin
                       aElement := aCollection.item(i, 0) as IHTMLElement;

                       if not assigned(aElement)
                          then continue;

                       S := aElement.outerHTML;

                      //drop obscure MS tags
                      if pos(msStuff {'xml:namespace'}, S) > 0
                          then begin
                             ElementRemoved := true;
                             (aElement as IHTMLDomNode).removeNode(false{RemoveChilds});
                             continue;
                          end;

                      if SameText(aElement.tagname, 'SPAN')
                          then begin
                             //drop empty SPAN tags
                             if length(trim(aElement.innertext)) = 0
                                then begin
                                   ElementRemoved := true;
                                   (aElement as IHTMLDomNode).removeNode(false{RemoveChilds});
                                   continue;
                                end;
                          end;

                    //drop styles stating with mso-
                    I2 := pos('mso-', string(aElement.style.cssText));
                    if I2 > 0
                       then aElement.style.cssText := copy(aElement.style.cssText, 1, I2);


                    //add code for any further stuff to get ride of heir

                 end;
           end;

        if (not changed)   //compare previous snapshot to current content
           then Changed := HTMLout <> FragmentDOC.body.InnerHtml;
     end;


     //the following code will just need to work on the actual HTML string
     HTMLout := FragmentDOC.body.InnerHtml;


     // do we need to watch out for a sentence containing 'please drag me' ?
     // but only during a drag operation
     if mnuLookforPleasedragme.Checked and
        (EventType = KS_DragDrop)
        then begin
           //do we have the sentence 'please drag me' inside the current drag text ?
           I := pos(PlsDrag, String(HTMLout));
           if I > 0
              then begin
                 //change 'please drag me' to 'dont drag me'
                 Delete(HTMLout, I, length(PlsDrag));
                 Insert(DntDrag, HTMLout, I);
                 Changed := true;

                 MessageDlg('The sentence "please drag me" was found in the' + crlf +
                            'dragged text and changed to "dont drag me".'
                            , mtInformation, [mbOK], 0);

                 if not mnuDontdragme.checked
                    then mnuDontdragmeClick(Self);
              end;
        end;


     { If the original HTML-fragment is changed we need to return it to edit
       trough a call to IDM_Drag_SetHTML.
       The HTML to return is whats found between the two marker-tags <!--StartFragment-->
       and <!--EndFragment--> in the FragmentDOC DOM.}

     if Changed
        then begin
           I := pos(SFrag, String(HTMLout)); //find start of <!--StartFragment-->
           if I > 0
              then begin
                 Inc(I, length(SFrag)); //find end of <!--StartFragment-->

                 I2 := pos(EFrag, String(HTMLout)) - I; //find start of <!--EndFragment-->
                 if (I > 0) and (I2 > 0)
                    then begin
                       //both fragment borders found -> cut out the actual HTML-fragment
                       Ov := copy(HTMLout, I, I2);

                       //send the resulting HTML-fragment back to edit
                       CheckResult(edit.CmdSet(IDM_Drag_SetHTML, Ov), 'IDM_Drag_SetHTML');
                       exit;
                    end
              end;

           //at least one fragment marker is missing because our code above have deleted it !!!
           KSMessageE('Missing fragment border(s)');
        end;
  end;
  //-------------------------------------------
  procedure HandleDroppedFiles;
  var
     StgMedium: TStgMedium;
     FormatEtc: TFormatEtc;
     hr: HRESULT;
     S, S1: String;
     aDataObject: IDataobject;
     nFiles: integer;
     I: Integer;
     FFileName: array[0..MAX_PATH] of Char;
  begin

     if DataObject = nil
        then exit; //something is rotten

     aDataObject := DataObject as IDataobject;

     if aDataObject = nil
        then exit; //should newer happen

     with FormatEtc do
        begin
           cfFormat := CF_HDROP;
           ptd      := nil;
           dwAspect := DVASPECT_CONTENT;
           lindex   := -1;
           tymed    := TYMED_HGLOBAL;
        end;

     hr := aDataObject.GetData(FormatEtc, StgMedium);
        if Failed(hr)
           then Exit; //should newer happen

     S := '';

     try
        //retrieve names and number of dropped files
        nFiles := DragQueryFile(StgMedium.hGlobal, $FFFFFFFF, nil, 0);

        for i := 0 to nFiles - 1 do
           begin
              // Read list dropped files
              DragQueryFile(StgMedium.hGlobal, i, FFileName , SizeOf(FFilename));
              S := S + FFileName + CrLf;
           end;
     finally
        ReleaseStgMedium(StgMedium);
     end;

     S1 := 'File';

     if nFiles > 1
        then S1 := S1 + 's ';

     KSMessageI(S1 + 'dropped:' + DblCrLf + S);
  end;
  //-------------------------------------------
  procedure DragDropAndpaste;
  var
     S: String;
  begin
     // dataObject and details available

     // This event occurs just before KSDhtmlEdit handles a drop action

     S := edit.CmdGet(IDM_Drag_EnumFormats);

     if pos(cCF_HDROP, S) > 0
        then begin
          HandleDroppedFiles;
          exit;
        end;

     if pos(cCF_HTML, S) = 0
        then exit;     //nothing to do if its not a paste HTML operation

     CheckDragPaste;
  end;
  //-------------------------------------------
begin
  //asm int 3 end; //trap

  //we come heir by every mouse movement during a drag operation !!!
  if not (mnuPastepathsabsolute.Checked or
          mnuLookforPleasedragme.Checked or
          mnuDontdragme.checked or
          mnuRawHtml.Checked)
     then begin
        if FBlockDragText
           then FBlockDragText := false;
       // exit;
     end;

  case EventType of
     KS_DragEnter:  DragEnter;
     KS_DragOver:   DragOver;
     KS_DragLeave:  DragLeave;
     KS_DragDrop:   DragDropAndpaste;
     KS_Paste:      DragDropAndpaste;
  end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuDontdragmeClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  mnuDontdragme.checked := not mnuDontdragme.checked;

  if mnuDontdragme.checked
     then begin
        MessageDlg('Any selection that contains the sentence:'+ DblCrLf +
                   'dont drag me'+ DblCrLf +
                   'cant be dragged now', mtInformation, [mbOK], 0);
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuLookforPleasedragmeClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  mnuLookforPleasedragme.Checked := not mnuLookforPleasedragme.Checked;

  if mnuLookforPleasedragme.Checked
     then begin
        MessageDlg('If the sentence "please drag me" is fund inside dragged text'+ crlf +
                   'the sentence is changed to "dont drag me", and the menu:' +CrLf+
                   '"Testing -> Dont drag me" is checked ON', mtInformation, [mbOK], 0);
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuRawHtmlClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  mnuRawHtml.Checked := not mnuRawHtml.Checked;

  if mnuRawHtml.Checked
     then begin
        MessageDlg('Any pasted HTML is stripped to its bare bone now.' + CrLf +
                   'Especially HTML pasted from MS Word is filled with a lot of' + CrLf +
                   'annoying and unnecessary formating and tags - all this will be filtered out'
                   , mtInformation, [mbOK], 0);
     end;

end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuPastepathsabsoluteClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  mnuPastepathsabsolute.Checked := not mnuPastepathsabsolute.Checked;

  if mnuPastepathsabsolute.Checked
     then begin
        MessageDlg('Any IMG-href fond inside a dragged or pasted content is checked now.' + CrLf +
                   'If a relative path is found it is changed to an absolute path.' + CrLf +
                   'As result the picture is shown in stead of a "Read X" placeholder.'
                   , mtInformation, [mbOK], 0);
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.F7Spelling;
begin
  //asm int 3 end; //trap

  { the commands IDM_Check_Spell, IDM_Check_Spell_Sel, IDM_Check_Spell_Cur and
    IDM_Check_Spell_Doc can be used with or without a boolean parameter.
    True or no param causes an internal spelling dialog box to be used
    False blocks the internal dialog box }

  if OpenSpellchecker               //param = true -> use internal spell dialog
     then CheckResult(edit.CmdSet(IDM_Check_Spell_Auto), 'IDM_Check_Spell')
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuSpellSelectClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  if OpenSpellchecker               //no param -> use internal spell dialog
     then CheckResult(edit.CmdSet(IDM_Check_Spell_Sel), 'IDM_Check_Spell_Sel');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuSpellCurClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  if OpenSpellchecker
     then CheckResult(edit.CmdSet(IDM_Check_Spell_FromCur), 'IDM_Check_Spell_FromCur')
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuSpellDocClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  if OpenSpellchecker
     then CheckResult(edit.CmdSet(IDM_Check_Spell_Doc), 'IDM_Check_Spell_Doc')
end;
//------------------------------------------------------------------------------
{$IFNDEF AddictSpell}
procedure TfrmOcxHtmlEditor.NoSpellChecker;
begin
  //asm int 3 end; //trap
  KSMessageE('No spell-checker component available', '', handle);
end;
{$ENDIF}
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.OpenFile(filename: String);
var WFilename : WideString;
begin
  WFilename := filename;
  CheckResult(Edit.LoadFile(WFilename, false), 'LoadFile', false, true);
end;

function TfrmOcxHtmlEditor.OpenSpellchecker: Boolean;
begin
  //asm int 3 end; //trap
  {$IFDEF AddictSpell}
     result := assigned(aSpellChecker);
  {$ELSE}
     result := false;
     NoSpellChecker;
  {$ENDIF}
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuSpellOptionClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  {$IFDEF AddictSpell}
     if OpenSpellchecker
        then aSpellChecker.Setup;
  {$ELSE}
     NoSpellChecker;
  {$ENDIF}
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Changelanguage1Click(Sender: TObject);
begin
  ShowMessage('First you''ll need a relevant dictionary.' + CrLf +
              'Click the menu "Download language dictionaries"' + CrLf +
              'and download the appropriate dictionaries.' + DblCrLf +
              'Then click the menu "Options" and in the' + CrLf +
              'dialog box click "Locate Dictionaries.' + DblCrLf +
              'At last check the dictionaries currently to be active');
end;
//------------------------------------------------------------------------------
function TfrmOcxHtmlEditor.SpellCheckWord(const aWord: WideString; var aCorrection: WideString): HRESULT;
{$IFDEF AddictSpell}
var
  Acor: String;
  I: Integer;
{$ENDIF}
begin
  //asm int 3 end; //trap

  {possible result values:
   S_OK              : accept word / skip word
   Spell_ReplaceWord : a misspelled word -> aCorrection = a replacement word
   Spell_EndCheck    : close the spell parser
   anny other return values - i.e. S_False - will act as Spell_EndCheck }


  {$IFDEF AddictSpell}
     { all spell checking components must have a call to check a
       single word }

     result := KsHresult(aSpellChecker.WordAcceptable(aWord));

     if Sfail(Result)
        then begin
           { if we dont use KSDhtml's internal spell checking dialog we'll
             call our own custom dialog heir and:
               eventually use the command IDM_Spell_Replace to replace the current
               (misspelled) word with another

             Return S_OK to let KSDhtmlEdit go to the next word.

             return Spell_EndCheck to close down the spell checker parser engine }

           //result := Spell_EndCheck;
           //exit;



           { French and maybe other languages may have mid word characters that
             really are word breaks like ' (apostrophe) in the French word
             l'activit� (the activity).

             Split the current aWord, according to witchever rules the current
             languages imposes, and return the the two words in aCorrection and
             return Spell_SplitWord as result. I.e. l'activit� -> l activit�

             You can check for "mid word ssplitters" either befor you check aWord
             or when the spell checker dosen't know the word - depending on which
             method is the most efficient fore the actual language. }


            { TextPrimaryLanguage is very Addict specific but other spell checkers
              may have similar features.

              aSpellChecker.TextPrimaryLanguage returns the Locale ID (LCID) of
              the currently most used main dictionaries (the dictionary that
              most words are found in if several dictionaries are loaded) }

           case aSpellChecker.TextPrimaryLanguage of

              1036: {LCID of French}
                 begin
                    I := pos('''', aWord);
                    if I > 0
                       then begin
                          aCorrection :=  copy(aWord, 1 ,I -1) + ' ' + copy(aWord, I + 1, Length(aWord));

                          result := Spell_SplitWord;
                          exit;
                       end;
                 end;

           end; //case


           { Some spell checking components have a call to check
             if a word can be automatically changed }

           if aSpellChecker.WordHasCorrection(aWord, aCor)
              then begin
                 //Addict doesn't support wide strings
                 aCorrection := aCor;
                 result := Spell_ReplaceWord;  //we have one ore more corrections
              end
        end;
  {$ELSE}
     result := S_False;
  {$ENDIF}
end;
//------------------------------------------------------------------------------
function TfrmOcxHtmlEditor.SpellSuggestWords(const aWord: WideString; var Suggestions: WideString): HRESULT;
{$IFDEF AddictSpell}
var
  Words: TStringList;
{$ENDIF}
begin
  //asm int 3 end; //trap

  { this will only get called if the KSDhtmlEdit internal spell checker
    dialog is used }

  {$IFDEF AddictSpell}
     Words := TStringList.Create;
     try
        { all spell checking components must have a call to suggest a list
          of words.
          Return suggestion a as CrLf separated list of words in Suggestions}

        aSpellChecker.Suggest(aWord, Words);
        Suggestions := Words.Text;
        if Length(Suggestions) > 0
           then result := S_OK
           else result := S_false;

     finally
        Words.free;
     end;
  {$ELSE}
     result := S_False;
  {$ENDIF}
end;
//------------------------------------------------------------------------------
function TfrmOcxHtmlEditor.DoPromtRepeated: Integer;
begin
  //asm int 3 end; //trap
  {$IFDEF AddictSpell}
     if (soRepeated in aSpellChecker.Configuration.SpellOptions)
        then result := PromtRepeated
        else result := 0;
  {$ELSE}
     result := PromtRepeated;
  {$ENDIF}
end;
//------------------------------------------------------------------------------
{$IFDEF AddictSpell}
  type
     TModific = (NA, InitCaps, InitCapsOrUpcase);
{$ENDIF}
//------------------------------------------------------------------------------
function TfrmOcxHtmlEditor.ModyFycase(aWord: String): String;
var
  aRes: Integer;
  {$IFDEF AddictSpell}
    InitUpCase: Boolean;
{$ENDIF}
begin
  //asm int 3 end; //trap

  result := aWord;
  if (Length(aWord) = 0) or
     (AnsiLowerCase(aWord) = aWord) //no uppercase letters at all
     then exit;

  // typically we just need to change a upper case leading letter to lower case
  aWord[1] := AnsiLowerCase(Result[1])[1];

  {$IFDEF AddictSpell}
     //do we just have an initial upper case character ?
     InitUpCase := aWord = AnsiLowerCase(aWord);

     //This is a Addict specific solution
     case TModific(aSpellChecker.AllowedCases) of
        InitCaps:
           begin
              if InitUpCase  //convert leading uppercase letter to lower case
                 then begin
                    Result := aWord;
                    exit;
                 end;
           end;

        InitCapsOrUpcase:
           begin
              if AnsiUppercase(Result) = Result //word in all upper case ?
                 then begin
                    Result := AnsiLowerCase(Result); //convert word to lower case
                    exit;
                 end
                 else begin
                    if InitUpCase  //convert leading uppercase letter to lower case
                       then begin
                          Result := aWord;
                          exit;
                       end;
                  end;
           end;
     end; //case
  {$ENDIF}

  //if we come heir we have word that contains more that a leading uppercase character
  aRes := KSQuestion('Add word case-sensitive: ' + DblCrLf +  result, 'Spell checking', MB_ICONQUESTION or MB_YESNOCANCEL);
  case aRes of
     IDCANCEL:
        begin
           result := ''; //return an empty string
           exit;
        end;

     IDYES: {NOP};
     IDNO:  result := AnsiLowerCase(aWord);
  end;

end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditSpellEvent(Sender: TObject; EventType: Integer; const aWord: WideString; var InOutVar: WideString; var Result: HRESULT);
{$IFDEF AddictSpell}
var
  aMsg: String;
{$ENDIF}
begin
  //asm int 3 end; //trap

  {$IFNDEF AddictSpell}
     NoSpellChecker;
     result := S_False;
     exit;
  {$ELSE}
     if assigned(aSpellChecker)
        then result := S_OK
        else begin
           result := S_False;
           exit;
        end;

     case EventType of
        Spell_SuggestWords: result := SpellSuggestWords(aWord, InOutVar);
                                      //return suggestions in InOutVar

        Spell_CheckWord: result := SpellCheckWord(aWord, InOutVar);
                                   //can return a a word correction word in InOutVar

        Spell_StartCheck: result := S_OK or          //show dialog when and if needed
                                    DoPromtRepeated;   //prompt for repeated words
                             //or ShowDialogNow;     //show dialog at once
                             //or NoInternalDialog   //dont use the internal dialog

        Spell_ManualChange:
           begin
              //returning S_OK will block the internal message box
              result := S_False;
           end;

        Spell_Finish, Spell_Cancel_btn:
           begin
              result := S_OK;
              if EventType = Spell_Finish
                 then begin
                    { since we return S_OK the internal message is blocked and
                      we can show our own message }
                    KSMessageI('Nothing more to spell check', '', handle);
                 end;
           end;

        Spell_Finish_FrCur: result := S_OK; { return S_OK to end spell checking
                                              without any mesg box }

        Spell_Finish_Sel, Spell_Finish_Word:
           begin
              if EventType = Spell_Finish_Sel
                 then aMsg := 'End of selection reached.'
                 else aMsg := 'Word checked.';

              if IDYES = KSQuestion(aMsg + CrLf+ 'Check rest of document', 'Spell checking', MB_ICONINFORMATION or MB_YESNO)
                 then result := Spell_Continue_Check
                 else result := S_OK; //S_OK = show no internal end message box
           end;

        Spell_Options_btn:
           begin
              //Spell checker should have some kind of a setup dialog
              aSpellChecker.Setup;
           end;

        Spell_AddWord_Btn:
           begin
              { Spell checkers may have the ability to learn new correctly spelled
                words acros sections [ActiveCustomDictionary] }
              aSpellChecker.ActiveCustomDictionary.AddIgnore(ModyFycase(aWord));
           end;

        Spell_Change_btn:
           begin
              //Spell checkers may have the ability to learn from frequent errors
              aSpellChecker.LearnSuggestion(aWord, InOutVar);
           end;

        Spell_Help_btn: KSMessageI('The spell dialog Help button was clicked');

        Spell_IgnoreAll_btn:
           begin
              { Spell checkers may have the ability to learn new words to ignore
                ONLY in the current session [InternalCustom]}
              aSpellChecker.InternalCustom.AddIgnore(ModyFycase(aWord));
           end;

        Spell_ChangeAll_btn:
           begin
              { Spell checkers may have the ability to learn new words to
                auto correct ONLY in the current session [InternalCustom]}
              aSpellChecker.InternalCustom.AddAutoCorrect(aWord, InOutVar);
              //also learn frequent errors
              aSpellChecker.LearnSuggestion(aWord, InOutVar);
           end;

        Spell_AddAutoCorrect_btn:
           begin
              { The addict spell checkers has the ability to learn new words to
                auto correct across sections [ActiveCustomDictionary].
                If you dont have addict you may not want the Auto-Correct button
                in the spell dialog - Check below at Spell_DlgButtons}

              aSpellChecker.ActiveCustomDictionary.AddAutoCorrect(aWord, InOutVar);
              //also learn frequent errors
              aSpellChecker.LearnSuggestion(aWord, InOutVar);
           end;

        Spell_Undo_btn:
           begin
              //this gives you a chance to react on a Undo-button-click

              Result := S_OK; //proceed with a normal Undo action
            { Result := Spell_KeepUndoBtn; the same as S_OK but the Undo button
                                           stays enabled even if the current undo-stack
                                           is empty after the Undo-action.

              Result := S_False; or any other value -> skip the internal Undo-action

              If You collect a stack of words from Spell_AddWord, Spell_Change_btn,
              Spell_IgnoreAll_btn, Spell_ChangeAll_btn and Spell_AddAutoCorrect_btn
              you can now give the user a chance to remove a "wrongly" added word
              from a custom dictionary.

              If you use Addict you can do the fooling to remove a wrong word:

                 //add to current session
                 aSpellChecker.InternalCustom.RemoveIgnore(aWord);
                 aSpellChecker.InternalCustom.RemoveAutoCorrect(aWord);

                 //add across sessions
                 aSpellChecker.ActiveCustomDictionary.RemoveIgnore(aWord);
                 aSpellChecker.ActiveCustomDictionary.RemoveAutoCorrect(aWord);
             }
           end;

        Spell_DlgButtons:
           begin
             //result := S_OK; //all buttons
             result := Optionsbtn or Addbtn or AutoCorrbtn or
                       ChangAllBtn or IgnoreAllBtn; // no Help button
           end;

        else result := S_False;

     end; //case
  {$ENDIF}
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditGetParentWindow(Sender: TObject; var ParentHwnd: Cardinal; var Result: HRESULT);
begin
  //asm int 3 end; //trap

  result := S_OK;
  ParentHwnd := Self.handle;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuCheckliveClick(Sender: TObject);
{$IFDEF AddictSpell}
var
  hr: Hresult;
  Bol: Boolean;
{$ENDIF}
begin
  //asm int 3 end; //trap

  if not OpenSpellchecker
     then exit;

  {$IFDEF AddictSpell}
     Bol := not mnuChecklive.Checked;
     HR := Edit.CmdSet_B(IDM_Check_Spell_Live, bol);
     //NB - it'll take a few seconds before we come back to this point
     if SOK(HR)
        then mnuChecklive.Checked := bol
        else begin
           if bol
              then CheckResult(HR, 'IDM_Check_Spell_Live - On')
              else CheckResult(HR, 'IDM_Check_Spell_Live - Off');
        end;
  {$ENDIF}
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.FormDestroy(Sender: TObject);
begin
  //asm int 3 end; //trap
  //must be heir or we can get into problem during a checker session

  {$IFDEF AddictSpell}
     aSpellChecker.free;
  {$ENDIF}

  WriteKHIniInteger('KH', 'SnapX', Edit.SnapToGridX);
  WriteKHIniInteger('KH', 'SnapY', Edit.SnapToGridY);
  WriteKHIniBoolean('KH', 'Snap', Edit.SnapToGrid);

  FEditHelper.free;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuLivecheckAreaClick(Sender: TObject);
var
  tempTextRang: IHTMLTxtRange;
  Ov: OleVariant;
begin
  //asm int 3 end; //trap

  if not mnuChecklive.Checked
     then begin
        KSMessageE('Live checking not active');
        exit;
     end;

  if not supports(Edit.DOM.Selection.createRange, IHTMLTxtRange, tempTextRang)
     then begin
        KSMessageE('Bad selection');
        exit;
     end;

  Ov := tempTextRang;
  CheckResult(Edit.CmdSet(IDM_Live_Spell_Range, Ov), 'IDM_Live_Spell_Range');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuGeCelltlistClick(Sender: TObject);
var
  OV: OleVariant;
  IList: IInterfaceList; //dont make this global - It'll only contain a snapshot
                         //of currently selected cells
  S: String;
begin
  //asm int 3 end; //trap

 IList := TInterfaceList.Create;
  { For a programming languages that doesn't have a build in implementation of
    "TInterfaceList" you can get one by calling CmdGet(IDM_Get_InterfaceList)

    IList := IUnknown(Edit.CmdGet(IDM_Get_InterfaceList)) as IInterfaceList;
  }

  try
     Ov := IList as IUnknown;
     //let KSDhtmlEdit fill the IInterfaceList
     if SOK(Edit.Exec(IDM_Get_Sel_Cells, OV))
        then begin
           if IList.count = 0
              then S := 'No table cell selected'
              else begin
                 if IList.count = 1
                    then S := '1 cell selected' + DblCrLf +'The'
                    else S := IntToStr(IList.count) + ' cells selected' + DblCrLf + 'The first';

                 S := S + ' cell''s OuterHtml:' + crLf +
                          (IList[0] as IHTMLElement).OuterHTML;
              end;
        end
        else S := 'IDM_Get_Sel_Cells failed';
  finally
     IList := nil; //not really necessary - Delphi does it automatically
  end;

  KsMessageI(S);
end;
//------------------------------------------------------------------------------
function GetParentElemetType(aTag: IHTMLElement; aType: string; var ParentElement: IHTMLElement): boolean;
{ Walk up the element chain and return the first found element with
  tag type = aType in ParentElement

  returns true if the wanted tag is found.}
begin
  //asm int 3 end; //trap
  result := false;

  ParentElement := aTag;  //initialize loop

  if assigned(ParentElement)
     then begin
        while (not AnsiSameText(ParentElement.tagName, aType)) and  //break if wanted type found
              (not SameText(ParentElement.tagName, 'BODY')) do       //break if BODY found
           begin
              ParentElement := ParentElement.parentElement;         //get the parent element
              if not assigned(ParentElement)
                 then exit;
           end;

        result := AnsiSameText(ParentElement.tagName, aType);
     end;
end;
//------------------------------------------------------------------------------
function TfrmOcxHtmlEditor.GetCurrentCell(var Ov: OleVariant): boolean;
var
  aElement: IHTMLElement;
begin
  //asm int 3 end; //trap
  result := GetParentElemetType(Edit.ActualElement, 'TD', aElement) or
            GetParentElemetType(Edit.ActualElement, 'TH', aElement);

  if result
     then Ov := aElement;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableSelCellClick(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  if GetCurrentCell(Ov)
     then CheckResult(Edit.CmdSet(IDM_CELLSELECT, Ov), 'IDM_CELLSELECT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableSelRowClick(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  if GetCurrentCell(Ov)
     then CheckResult(Edit.CmdSet(IDM_ROWSELECT, Ov), 'IDM_ROWSELECT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableSelColumnClick(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap
  if GetCurrentCell(Ov)
     then CheckResult(Edit.CmdSet(IDM_COLUMNSELECT, Ov), 'IDM_COLUMNSELECT');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuTableSelTableClick(Sender: TObject);
var
  Ov: OleVariant;
  aElement: IHTMLElement;
  IList: IInterfaceList;
begin
  //asm int 3 end; //trap
  IList := TInterfaceList.Create;
  try
     Ov := IList as IUnknown;
     if SOK(Edit.Exec(IDM_Get_Sel_Cells, Ov))
        then begin
           if GetParentElemetType(IList[0] as IHTMLElement, 'TABLE', aElement)
              then begin
                 Ov := aElement;
                 CheckResult(Edit.CmdSet(IDM_TABLESELECT, Ov), 'IDM_TABLESELECT');
              end;
        end;
  finally
     IList := nil; //not really necessary - Delphi does it automatically
  end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuIscellselectedClick(Sender: TObject);
var
  Ov: OleVariant;
  Ov2: OleVariant;
  IsSel: Boolean;
  HR: Hresult;
  S: String;
begin
  //asm int 3 end; //trap

  IsSel := False; //avoid warning
  if GetCurrentCell(Ov)
     then begin
        Hr := Edit.Exec(IDM_Is_CELL_SELECTED, Ov, Ov2);
        if sFail(Hr)
           then begin
              CheckResult(Hr, 'IDM_Is_CELL_SELECTED');
              exit;
           end
           else IsSel := Ov2;
     end;

  if IsSel
     then S := 'Yes'
     else S := 'No';

 KsMessageI(S);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Pagesetup1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet(IDM_PAGESETUP), 'IDM_PAGESETUP');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuLoadURLClick(Sender: TObject);
var
  aUrl: string;
begin
  //asm int 3 end; //trap
  aUrl := InputBox('HTML Editor', 'Load URL', 'http://');

  if (length(aUrl) = 0) or (aUrl = 'http://')
     then exit; //no input

  CheckResult(Edit.LoadUrl(aUrl), 'LoadUrlD');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.VisualizeDOMTree(node: IHTMLDOMNode; treeNode:TTreeNode; treeNodes:TTreeNodes);
var
  i: Integer;
  myTreeNode: TTreeNode;
  IDomcoll: IHTMLDOMChildrenCollection;
  ChildNode: IHTMLDOMNode;
  I2: Integer;
begin
  //asm int 3 end; //trap
  myTreeNode:= treeNodes.AddChild(treeNode, node.nodeName);

  IDomcoll := node.childNodes as IHTMLDOMChildrenCollection;

  for i:= 0 to IDomcoll.length-1 do
     begin
        ChildNode:= IDomcoll.item(I) as IHTMLDOMNode;

        if ChildNode.nodeType = 1
           then begin
              //Element node - 1
              VisualizeDOMTree(ChildNode, myTreeNode, treeNodes);
           end
           else begin
              //Text node - 3

              // Its odd but expanding a node containing a text string longer
              // than 259 causes problems

              if Length(ChildNode.nodeValue) + length(myTreeNode.Text) > 258 // + a space = 259
                 then begin
                    I2 := 258 - length(myTreeNode.Text);

                    myTreeNode.Text := myTreeNode.Text + ' ' + Copy(ChildNode.nodeValue, 1, I2);
                 end
                 else myTreeNode.Text := myTreeNode.Text + ' ' + ChildNode.nodeValue;
           end;
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Button3Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  TreeView1.Items.clear;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Button2Click(Sender: TObject);
var
  i: Integer;
  iDisp: IDispatch;
  IDomcoll: IHTMLDOMChildrenCollection;
  Node: IHTMLDOMNode;
begin
  //asm int 3 end; //trap
  iDisp := (edit.DOM as IHTMLDocument3).childNodes;

  IDomcoll := IDisp as IHTMLDOMChildrenCollection;

  for i:= 0 to IDomcoll.length-1 do
     begin
        Node:= IDomcoll.item(I) as IHTMLDOMNode;

        if Node.nodeType = 1
           then begin
              //Element node - 1
              VisualizeDOMTree(Node, nil, TreeView1.Items);
           end
           else begin
              //Text node - 3
              //NB NB this should never happen

              TreeView1.Items.AddChild(nil, Node.nodeName + ' ' + Node.nodeValue);
           end;
     end;

  TreeView1.visible := false;  //speed up expanding operation
  TreeView1.FullExpand;
  TreeView1.visible := true;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.filestreamingONClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet_B(IDM_File_Streaming, true), 'IDM_File_Streaming ON');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.filestreamingOFFClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet_B(IDM_File_Streaming, false), 'IDM_File_Streaming OFF');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.DefaultfiledropONClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet_B(IDM_Drag_DefaultEffect, true), 'IDM_Drag_DefaultEffect ON');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.DefaultfiledropOFFClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  CheckResult(Edit.CmdSet_B(IDM_Drag_DefaultEffect, false), 'IDM_Drag_DefaultEffect OFF');
end;
//------------------------------------------------------------------------------
function TfrmOcxHtmlEditor.UndoDeleteElement(TagValue: String; WatchID: Integer): Boolean;
var
  LoverTagVal: string;
  //BookMarkType: Integer;
  S: String;
  Icons: Word;
begin
  //asm int 3 end; //trap

  // aDoc := (Sender as TEmbeddedED).DOM;

  //result := false; //no UNDO

  LoverTagVal := LoWerCase(TagValue);


  Icons := 0; //avoid warning

  case WatchID of
     20: //ID = empty link-element
      begin
         S := 'A hidden (empty) link-element has just been deleted !';
         Icons := MB_ICONWARNING or MB_YESNO;
      end;

     21, //ID = pop-bookmark
     24: //ID = named bookmark
        begin
           S := 'A hidden SYSTEM CRITICAL bookmark has just been deleted !' + crLf +
                'Some functionality may break if the bookmark is missing.';
           Icons := MB_ICONERROR or MB_YESNO;
        end;

     25: //ID = Comment
      begin
         S := 'A Comment-element has just been deleted !';
         Icons := MB_ICONWARNING or MB_YESNO;
      end;
  end;

  S := S +  DblCrLf + TagValue + DblCrLf + 'Undo deleting ?';

  result := IDYES = KSQuestion(S, 'FActualAppName', Icons, Edit.GetMSHTMLwinHandle);

  if result
     then Edit.CmdSet(IDM_UNDO);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditWatchElementDelete(Sender: TObject; const Value: WideString);
var
  allElements: String;
  S: String;
  WatchID: Integer;
begin
  //asm int 3 end; //trap
  allElements := Value; // Value may contain several lines containing each one element

  while length(allElements) > 0 do
     begin
        S := SplitAtTokenStr(allElements, CrLf); //get one line

        //each line contains: WatchID tagId <element content> (separated by spaces)

        WatchID := StrToInt(SplitAtToken(S, ' ')); //get WatchID
        //ptagId := StrToInt(SplitAtToken(S, ' '));  //get tagId   (unused in this case)


      //  bookmarks are possibly marked with ID = 20 to 22



        if UndoDeleteElement(S, WatchID)
           then exit; // user chosed to UNDO deletion
     end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.WatchElementDeletion1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  FEditHelper.WatchElementDeletion(FWatchedBookMarks);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.StopWatching1Click(Sender: TObject);
begin
  //asm int 3 end; //trap

  FEditHelper.StopWatchingBookmarks;
  FWatchedBookMarks := false;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Stopwatchingallelements1Click(Sender: TObject);
var
  Ov: OleVariant;
begin
  //asm int 3 end; //trap

  Ov := ' ' ; //release any kind of watched elements
  if SFail(Edit.Exec(IDM_ReleaseWatchDelete, ov))
     then KSMessageI('No elements to be Release for Watch Delete found');

  FWatchedBookMarks := false;
  FWatchedComments := false;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.UpdatetbtnShowAnchors;
begin
  //asm int 3 end; //trap

  btnShowAnchors.Down := FShowAnchorGlyphe;

  if FShowAnchorGlyphe
     then btnShowAnchors.Hint := 'Hide bookmark-glyphs'
     else btnShowAnchors.Hint := 'Show bookmark-glyphs';
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.UpdatebtnShowPagebrk;
begin
  //asm int 3 end; //trap

  btnShowPagebrk.Down := FShowPagebrkGlyphe;

  if btnShowPagebrk.Down
     then btnShowPagebrk.Hint := 'Hide pagebreak-glyphs'
     else btnShowPagebrk.Hint := 'Show pagebreak-glyphs';
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnShowAnchorsClick(Sender: TObject);
//var
 // aCollection: IHTMLElementCollection;
 // aAnchor: IHTMLAnchorElement;
 // I: Integer;
 // Ov: OleVariant;
 // Ov2: OleVariant;
begin
  //asm int 3 end; //trap

  { This will check all bookmarks in the document ( an A tag without a link )
    and attach a *binary behaviour to the element which shows a glyph at the
    bookmarks position in the document.

    The general bookmark glyph is a round orange ball, but if a bookmark has
    its ClassName set to 'pop' another type of glyph is shown instead.

    * My binary behaviour (as its implemented inside KSDhtmlEdit.OCX) is based on
      TInterfacedObject, IElementBehavior, IElementBehaviorLayout and IHTMLPainterEventInfo.
      Aditionally the object also implements IDispatchEx to enable creation of
      new properties on the object, and also enabling communication with the object.

      Instead of keeping long lists identifying every created binary behaviour
      new properties is created (via IDispatchEx) on each object enabling storage
      of  information like the behaviour type/name and data forcing special
      "behaviours" of the binary behaviour.

      Now its possible to ask each and every object in the DOM if its implement
      IDispatchEx and if so - then asks fore its name and if its an object we
      want to deal with we can go on asking for other properties we have set
      previously.

      My implementation of binary behaviour also implements a self-destruction
      command which is always carried out just before the DOM is closed - in case
      the behaviour isn't already removed at that time. The mechanism ensures
      that parentless binary objects doesn't clutter up the memory even if the
      DOM closes down accidently. Only if the core mshtml engine crashes totally
      we can end up with small amount of memory not freed properly.

      Note if you select a bookmark glyph you can delete the bookmark itself by
      hitting the Delete key.

      Check TfrmMain.EditPreHandleEvent to see how a currently selected Glyph
      (Binary behaviour) is communicated with trough IDispatchEX.
    }

  // actual code moved to KSEmbeddedEDx.pas


  FShowAnchorGlyphe := not FShowAnchorGlyphe;

  FEditHelper.ShowBookmarks(FShowAnchorGlyphe);
  UpdatetbtnShowAnchors;

  if FShowAnchorGlyphe and
     (not FEditHelper.IsShowBookmarks)
     then KsMessageI('No bookmarks to show');



 (* old code
  aCollection := (Edit.DOM.Body as IHTMLElement2).getElementsByTagName('A');

  if FShowAnchorGlyphe  //remove all bookmark glyphs
     then begin
        for I := 0 to aCollection.length - 1 do
           begin
              aAnchor := aCollection.item(i, null) as IHTMLAnchorElement;

              if length(aAnchor.href) = 0
                 then begin
                    //this is a bookmark
                    Ov := aAnchor;
                    Edit.CmdSet(IDM_HideGlyphe, Ov);  //hid glyph - if any
                end;
            end;

        FShowAnchorGlyphe := false;
     end
     else begin
        //add glyph's to all bookmarks
        FShowAnchorGlyphe := false;

        for I := 0 to aCollection.length - 1 do
           begin
              aAnchor := aCollection.item(i, null) as IHTMLAnchorElement;

              if length(aAnchor.href) = 0
                 then begin
                    //this is a bookmark

                    {$IFDEF ChangedClassname}
                      if sameText((aAnchor as IHTMLElement)._ClassName, 'pop')
                    {$ELSE}
                      if sameText((aAnchor as IHTMLElement).ClassName, 'pop')
                    {$ENDIF}
                    //this shows how different types of bookmarks can be indicated by different glyph's
                       then OV2 := 3 //show Inject gif
                       else OV2 := 1; // show ball gif

                    Ov := aAnchor;
                    if SOK(Edit.Exec(IDM_ShowGlyphe, Ov, Ov2))
                       then begin
                          FShowAnchorGlyphe := true;  // gif attached successfully
                          KSWait(1); // make room for MSHTML to display new Glyph
                       end;
                end;
            end;

           if not FShowAnchorGlyphe
              then KSMessageI('The document contains no bookmark');
        end;

   UpdatetbtnShowAnchors;
   *)
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditHTMLClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  mnuEditHTMLClick(Self);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditHTMLClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  PageControl1.SetFocus; //ensures highlighting of the selected text
  DoDlg_InsertHTML(Edit);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.EditBookMClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  PageControl1.SetFocus; //ensures highlighting of the selected text
  DoDlg_Bookmark(Edit, self);
  FEditHelper.ShowBookmarks(true);
end;
//------------------------------------------------------------------------------
function IS_WinVerMinXP: Boolean;
var
  OS: TOSVersionInfo;
begin
  //asm int 3 end; //trap

  ZeroMemory(@OS, SizeOf(OS));
  OS.dwOSVersionInfoSize := SizeOf(OS);
  GetVersionEx(OS);

  Result := OS.dwPlatformId = VER_PLATFORM_WIN32_NT;
  if not result
     then exit;

  result := OS.dwMajorVersion > 5; // vista or above

  if not result
     then result := (OS.dwMajorVersion = 5) and // Win2K = Major 5 and Minor 0
                    (OS.dwMinorVersion = 1)     // XP    = Major 5 and Minor 1
end;
//------------------------------------------------------------------------------
type
  // Function ObjectFromLresult as implemented in Oleacc.dll on XP and higher
  TObjectFromLResult = function(LRESULT: lResult; const REFIID: TIID; WPARAM: wParam; out pvObject): HRESULT; stdcall;

function GetDocFromHWND(aHwnd: HWND; var aDOC: IHTMLDocument2): boolean;
var
  hModule: HINST;
  dwResult: DWORD;
  WM_HTML_Msg: DWORD;
  ObjectFromLresult: TObjectFromLresult;
  aErrMessage: String;
  aHR: HRESULT;
begin
  //asm int 3 end; //trap

  // this function is written with full error detection and can off cause be greatly simplified

  Result := False;

  if not IS_WinVerMinXP
     then begin
        KSMessageE('ObjectFromLresult needs XP or higher');
        exit;
     end;


  WM_HTML_Msg := RegisterWindowMessage('WM_HTML_GETOBJECT');
  if not Boolean(WM_HTML_Msg)
     then begin
        KSMessageE('RegisterWindowMessage failed');
        exit;
     end;

  hModule := LoadLibrary('Oleacc.dll');
  if hModule = 0
     then begin
        KSMessageE(GetLastErrorStr);
        exit;
     end;

  try
     @ObjectFromLresult := GetProcAddress(hModule, 'ObjectFromLresult');
     if @ObjectFromLresult = nil
        then begin
           KSMessageE(GetLastErrorStr);
           exit;
        end;
                                                               // timeout = 1 sec.
      SendMessageTimeOut(aHwnd, WM_HTML_Msg, 0, 0, SMTO_ABORTIFHUNG, 1000, dwResult);
      if boolean(dwResult)
        then begin
           aHR := ObjectFromLresult(dwResult, IHTMLDocument2, 0, aDOC);
           Result := SOK(aHR);

           if not result
              then begin
                 aErrMessage := SysErrorMessage(aHR);

                 if aErrMessage = '' //must be an OleError
                    then FmtStr(aErrMessage, SOleError, [aHR]);

                 KSmessageE(aErrMessage);
              end;
        end
        else KSMessageE(GetLastErrorStr);
    finally
      FreeLibrary(hModule);
    end;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuSpellDlgModalClick(Sender: TObject);
var
  Latched: boolean;
begin
  //asm int 3 end; //trap

  Latched := not edit.QueryLatched(IDM_Spell_Dlg_Modal);
  mnuSpellDlgModal.checked := Latched;

  Edit.CmdSet_B(IDM_Spell_Dlg_Modal, Latched);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuSpellingClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  //Update status of mnuSpellDlgModal
   mnuQueryStatus(IDM_Spell_Dlg_Modal, mnuSpellDlgModal);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEdittablepropertiesClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  DoDlg_TableCell_Table(Edit);  //Edit table properties
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuEditCellpropertiesClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  DoDlg_TableCell_Cell(Edit);  //Edit table cell properties
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Font1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
 // PageControl1.SetFocus; //ensures highlighting of the selected text

  if S_OK =  Edit.CmdSet(IDM_KEEPSELECTION)
  then beep;;
 
  Edit.CmdSet(IDM_FONT);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Borders1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  PageControl1.SetFocus; //ensures highlighting of the selected text
  DoDlg_styles(Edit);

  Edit.SetFocusToDoc;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Bullets1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  PageControl1.SetFocus; //ensures highlighting of the selected text
  DoDlg_Bullets(Edit);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Nudgeelement1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  DoDlg_nudge(Edit);  //reposition the current element
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.HorizontalRule1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  Edit.CmdSet(IDM_HORIZONTALLINE);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuShowmarkedRevisionsClick(Sender: TObject);
var
  TurnOn: Boolean;
begin
  //asm int 3 end; //trap

  TurnOn := not FEditHelper.IsShowRevisions;

  FEditHelper.ShowRevisions(TurnOn);

  if TurnOn and
     (not FEditHelper.IsShowRevisions)
     then KSMessageI('No revisions to show');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuMarkselectionasRevisionsClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  FEditHelper.MarkselectionasRevision;
  FEditHelper.ShowRevisions(true);
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuClearselectedrvisionmarkingClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  FEditHelper.ClearSelectedRevisionMark;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Clearallrevisionmarkings1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  FEditHelper.ClearAllRevisionMarkings;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnShowPagebrkClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  FShowPagebrkGlyphe := not FShowPagebrkGlyphe;

  FEditHelper.ShowPageBrks(FShowPagebrkGlyphe);
  UpdatebtnShowPagebrk;

  if FShowPagebrkGlyphe and
     (not FEditHelper.IsShowPageBrks)
     then KsMessageI('No page-breaks to show');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnInsertPagebrkClick(Sender: TObject);
begin
  //asm int 3 end; //trap

  (* a page-Break can only be inserted on a 'P' or 'DIV' element
    it works by setting the elements ClassName := 'page'

    Aditionally we need either an external css or an embedded style definition

    P.page { page-break-after: always}
    DIV.page { page-break-after: always;}

   page-break-after causes the printer process to add a new page after the P or DIV tag

   If no external style sheet definition is found its added directly to the document
  *)

  FEditHelper.InsertPageBrk;

  if not FEditHelper.IsShowPageBrks
     then FEditHelper.ShowPageBrks(true); //show all page breaks
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.btnRemovePagebrkClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  FEditHelper.DeleteGlyph;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuAboutNewfeaturesClick(Sender: TObject);
begin
  ExecuteDefaultOpen('rtf', 'New features.rtf');
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Testbookmarks1Click(Sender: TObject);
begin
  //asm int 3 end; //trap

  FDatatype := 1; //we use 1 to identify a file load
  CheckResult(Edit.go('ksx:page1.htm'), 'Load Doc from stream', false, true);
  // the path to page1.htm is added in "procedure TfrmMain.EditGetStreamData"

  ksWait(10); // give the document a chance to finish loading

  FEditHelper.ShowBookmarks(true);

  FShowAnchorGlyphe := true;
  UpdatetbtnShowAnchors;

  FShowPagebrkGlyphe := false;
  UpdatebtnShowPagebrk;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Watchforaccidentlydeletion1Click(Sender: TObject);
begin
  //asm int 3 end; //trap

  FDatatype := 1; //we use 1 to identify a file load
  CheckResult(Edit.go('ksx:page1.htm'), 'Load Doc from stream', false, true);
  // the path to page1.htm is added in "procedure TfrmMain.EditGetStreamData"

  ksWait(10); // give the document a chance to finish loading

  FEditHelper.WatchElementDeletion(FWatchedBookMarks, true {silent});

  FShowAnchorGlyphe := false;
  UpdatetbtnShowAnchors;

  FShowPagebrkGlyphe := false;
  UpdatebtnShowPagebrk;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Managepagebreaks1Click(Sender: TObject);
begin
  //asm int 3 end; //trap

  FDatatype := 1; //we use 1 to identify a file load
  CheckResult(Edit.go('ksx:page1.htm'), 'Load Doc from stream', false, true);
  // the path to page1.htm is added in "procedure TfrmMain.EditGetStreamData"

  ksWait(10); // give the document a chance to finish loading

  FEditHelper.ShowPageBrks(true);

  FShowAnchorGlyphe := false;
  UpdatetbtnShowAnchors;

  FShowPagebrkGlyphe := true;
  UpdatebtnShowPagebrk;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Managerevisionsmarking1Click(Sender: TObject);
begin
  //asm int 3 end; //trap

  FDatatype := 1; //we use 1 to identify a file load
  CheckResult(Edit.go('ksx:page2.htm'), 'Load Doc from stream', false, true);
  // the path to page2.htm is added in "procedure TfrmMain.EditGetStreamData"

  ksWait(10); // give the document a chance to finish loading

  FEditHelper.ShowRevisions(true);

  FShowAnchorGlyphe := false;
  UpdatetbtnShowAnchors;

  FShowPagebrkGlyphe := false;
  UpdatebtnShowPagebrk;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.mnuRevisionsClick(Sender: TObject);
begin
  //asm int 3 end; //trap
  mnuShowmarkedRevisions.Checked := FEditHelper.IsShowRevisions;
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.SetdocumenttoUnichar1Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  Edit.DOM.charset := 'unicode';
end;
//------------------------------------------------------------------------------
procedure TfrmOcxHtmlEditor.Setdocumenttoutf81Click(Sender: TObject);
begin
  //asm int 3 end; //trap
  Edit.DOM.charset := 'utf-8'
end;
//------------------------------------------------------------------------------

end.


