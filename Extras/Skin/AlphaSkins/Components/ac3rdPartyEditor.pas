unit ac3rdPartyEditor;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, Menus, ExtCtrls,
  {$IFDEF DELPHI6UP} Variants, {$ENDIF}
  sBitBtn, ComCtrls, sListView, sSkinManager, sSkinProvider, sSpeedButton, sPanel, sConst, sCheckListBox, sCheckBox, sLabel, sListBox;


type
  TForm3rdPartyEditor = class(TForm)
    sListView1: TsListView;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsSpeedButton;
    sBitBtn3: TsSpeedButton;
    sSkinProvider1: TsSkinProvider;
    PopupMenu1: TPopupMenu;
    Addnew1: TMenuItem;
    Delete1: TMenuItem;
    Defaultsettings1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton5: TsSpeedButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    sSpeedButton6: TsSpeedButton;
    sPanel1: TsPanel;
    sListBox1: TsListBox;
    sPanel2: TsPanel;
    sListBox2: TsCheckListBox;
    Edit1: TMenuItem;
    sCheckBox1: TsCheckBox;
    sSpeedButton2: TsSpeedButton;
    procedure sBitBtn2Click(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sBitBtn3Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sListView1Change(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure sListBox1Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure sSpeedButton5Click(Sender: TObject);
    procedure sSpeedButton6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sListView1DblClick(Sender: TObject);
  public
    Lists: TStringLists;
    Cmp: TComponent;
    procedure UpdateNames;
    procedure Populate(ControlRepaint: boolean = True);
    procedure SelectCtrls(TypeIndex: integer);
  end;


var
  Form3rdPartyEditor: TForm3rdPartyEditor;


const
{$IFDEF ALITE}
  acLiteCtrls: array [0..17] of string = ('TBitBtn', 'TButton', 'TCategoryButtons', 'TCheckBox', 'TCheckListBox', 'TColorBox', 'TComboBox',
                'TComboBoxEx', 'TDrawGrid', 'TEdit', 'TFileListBox', 'TGridPanel', 'TGroupBox', 'TGroupButton',
                'THotKey', 'TListView', 'TMemo', 'TPage');
{$ENDIF}

// Arrary of predefined ctrls
  acCtrlsArray: array [0..14] of string = (
// 0. Std. VCL
    'TEdit=Edit'                  + s_0D0A +
    'TMemo=Edit'                  + s_0D0A +
    'TMaskEdit=Edit'              + s_0D0A +
    'TSpinEdit=Edit'              + s_0D0A +
    'TLabeledEdit=Edit'           + s_0D0A +
    'THotKey=Edit'                + s_0D0A +
    'TListBox=Edit'               + s_0D0A +
    'TCheckListBox=Edit'          + s_0D0A +
    'TRichEdit=Edit'              + s_0D0A +
    'TSpinEdit=Edit'              + s_0D0A +
    'TDateTimePicker=Edit'        + s_0D0A +
    'TStringGrid=Grid'            + s_0D0A +
    'TDrawGrid=Grid'              + s_0D0A +
    'TValueListEditor=Grid'       + s_0D0A +
    'TTreeView=TreeView'          + s_0D0A +
    'TCategoryButtons=Edit'       + s_0D0A +
    'TSpinButton=UpDownBtn'       + s_0D0A +
    'TListView=ListView'          + s_0D0A +
    'TScrollBar=ScrollBar'        + s_0D0A +
    'TStaticText=StaticText'      + s_0D0A +
{.$IFNDEF ALITE}
    'TPanel=Panel'                + s_0D0A +
    'TPage=Panel'                 + s_0D0A +
    'TGridPanel=Panel'            + s_0D0A +
    'TButton=Button'              + s_0D0A +
    'TFileListBox=Edit'           + s_0D0A +
    'TBitBtn=BitBtn'              + s_0D0A +
    'TCheckBox=CheckBox'          + s_0D0A +
    'TRadioButton=CheckBox'       + s_0D0A +
    'TGroupButton=CheckBox'       + s_0D0A +
    'TGroupBox=GroupBox'          + s_0D0A +
    'TRadioGroup=GroupBox'        + s_0D0A +
    'TComboBox=ComboBox'          + s_0D0A +
    'TComboBoxEx=ComboBox'        + s_0D0A +
    'TColorBox=ComboBox'          + s_0D0A +
    'TPageControl=PageControl'    + s_0D0A +
    'TTabControl=TabControl'      + s_0D0A +
    'TTabbedNotebook=TabControl'  + s_0D0A +
    'TTabPage=Panel'              + s_0D0A +
    'TToolBar=ToolBar'            + s_0D0A +
{$IFDEF ADDWEBBROWSER}
    'TWebBrowser=WebBrowser'      + s_0D0A +
{$ENDIF}
{.$ENDIF}
    'TStatusBar=StatusBar'        + s_0D0A +
    'TScrollBox=ScrollControl'    + s_0D0A +
    'TUpDown=UpDownBtn'           + s_0D0A +
    'TSpeedButton=SpeedButton',

// 1. Std. DB-aware
    'TDBListBox=Edit'             + s_0D0A +
    'TDBMemo=Edit'                + s_0D0A +
    'TDBNavigator=Panel'          + s_0D0A +
    'TDBLookupListBox=Edit'       + s_0D0A +
    'TDBRichEdit=Edit'            + s_0D0A +
    'TDBCtrlGrid=Edit'            + s_0D0A +
    'TDBEdit=Edit'                + s_0D0A +
    'TDBRadioGroup=GroupBox'      + s_0D0A +
    'TDBCtrlPanel=Panel'          + s_0D0A +
    'TDBCheckBox=CheckBox'        + s_0D0A +
    'TDBGrid=Grid'                + s_0D0A +
    'TNavButton=SpeedButton'      + s_0D0A +
    'TDBTreeView=TreeView'        + s_0D0A +
    'TDBComboBox=ComboBox'        + s_0D0A +
    'TDBLookupComboBox=WWEdit',

// 2. TNT Controls
    'TTntEdit=Edit'               + s_0D0A +
    'TTntMemo=Edit'               + s_0D0A +
    'TTntListBox=Edit'            + s_0D0A +
    'TTntCheckListBox=Edit'       + s_0D0A +
    'TTntRichEdit=Edit'           + s_0D0A +
    'TTntDBEdit=Edit'             + s_0D0A +
    'TTntDBMemo=Edit'             + s_0D0A +
    'TTntDBRichEdit=Edit'         + s_0D0A +
    'TTntPanel=Panel'             + s_0D0A +
    'TTntButton=Button'           + s_0D0A +
    'TTntButton=Button'           + s_0D0A +
    'TTntBitBtn=BitBtn'           + s_0D0A +
    'TTntCheckBox=CheckBox'       + s_0D0A +
    'TTntRadioButton=CheckBox'    + s_0D0A +
    'TTntDBCheckBox=CheckBox'     + s_0D0A +
    'TTntDBRadioButton=CheckBox'  + s_0D0A +
    'TTntGroupButton=CheckBox'    + s_0D0A +
    'TTntGroupBox=GroupBox'       + s_0D0A +
    'TTntRadioGroup=GroupBox'     + s_0D0A +
    'TTntDBRadioGroup=GroupBox'   + s_0D0A +
    'TTntStringGrid=Grid'         + s_0D0A +
    'TTntDrawGrid=Grid'           + s_0D0A +
    'TTntDBGrid=Grid'             + s_0D0A +
    'TTntTreeView=TreeView'       + s_0D0A +
    'TTntComboBox=ComboBox'       + s_0D0A +
    'TTntDBComboBox=ComboBox'     + s_0D0A +
    'TTntListView=ListView'       + s_0D0A +
    'TTntSpeedButton=SpeedButton',

// 3. Woll2Woll
    'TwwDBGrid=Grid'                   + s_0D0A +
    'TwwRadioGroup=GroupBox'           + s_0D0A +
    'TwwDBComboBox=wwEdit'             + s_0D0A +
    'TwwDBEdit=wwEdit'                 + s_0D0A +
    'TwwDBEichEdit=wwEdit'             + s_0D0A +
    'TwwDBCustomCombo=wwEdit'          + s_0D0A +
    'TwwTempKeyCombo=ComboBox'         + s_0D0A +
    'TwwIncrementalSearch=Edit'        + s_0D0A +
    'TwwRecordViewPanel=ScrollControl' + s_0D0A +
    'TwwDataInspector=ScrollControl'   + s_0D0A +
    'TwwKeyCombo=ComboBox'             + s_0D0A +
    'TwwPopupGrid=Grid'                + s_0D0A +
    'TwwDBLookupCombo=Edit'            + s_0D0A +
    'TwwDBLookupComboDlg=Edit'         + s_0D0A +
    'TwwDBCustomLookupCombo=wwEdit',
// 4. Virtual controls
    'TVirtualStringTree=VirtualTree'           + s_0D0A +
    'TVirtualStringTreeDB=VirtualTree'         + s_0D0A +
    'TEasyListview=VirtualTree'                + s_0D0A +
    'TVirtualExplorerListview=VirtualTree'     + s_0D0A +
    'TVirtualExplorerTreeview=VirtualTree'     + s_0D0A +
    'TVirtualExplorerTree=VirtualTree'         + s_0D0A +
    'TVirtualExplorerEasyListview=VirtualTree' + s_0D0A +
    'TVirtualDrawTree=VirtualTree',
// 5. EhLib
    'TDBGridEh=GridEh'           + s_0D0A +
    'TDBVertGridEh=GridEh'       + s_0D0A +
    'TSizeGripPanelEh=ScrollBar' + s_0D0A +
    'TControlScrollBarEh=ScrollBar',
// 6. FastReport & QuickReport
    'TfrxPreviewWorkspace=Edit'  + s_0D0A +
    'TfrxScrollBox=Edit'         + s_0D0A +
    'TQRPreview=NativePaint'     + s_0D0A +
    'TStatusBar=StatusBar'       + s_0D0A +
    'TSpeedButton=SpeedButton'   + s_0D0A +
    'TPanel=Panel'               + s_0D0A +
    'TButton=Button'             + s_0D0A +
    'TToolBar=ToolBar'           + s_0D0A +
    'TfrxTBPanel=Panel',
// 7. RxLib
    'TRxDBGrid=Grid',
// 8. Jvcl
    'TJvCharMap=Edit'              + s_0D0A +
    'TJvImagesViewer=Edit'         + s_0D0A +
    'TJvImageListViewer=Edit'      + s_0D0A +
    'TJvOwnerDrawViewer=Edit'      + s_0D0A +
    'TJvDBRichEdit=Edit'           + s_0D0A +
    'TJvDBLookupList=Edit'         + s_0D0A +
    'TJvDBMaskEdit=Edit'           + s_0D0A +
    'TJvDBSearchEdit=Edit'         + s_0D0A +
    'TJvDBFindEdit=Edit'           + s_0D0A +
    'TJvValidateEdit=Edit'         + s_0D0A +
    'TJvEditor=Edit'               + s_0D0A +
    'TJvHLEditor=Edit'             + s_0D0A +
    'TJvWideEditor=Edit'           + s_0D0A +
    'TJvWideHLEditor=Edit'         + s_0D0A +
    'TJvEdit=Edit'                 + s_0D0A +
    'TJvMemo=Edit'                 + s_0D0A +
    'TJvRichEdit=Edit'             + s_0D0A +
    'TJvMaskEdit=Edit'             + s_0D0A +
    'TJvCheckedMaskEdit=Edit'      + s_0D0A +
    'TJvHotKey=Edit'               + s_0D0A +
    'TJvIPAddress=Edit'            + s_0D0A +
    'TJvgListBoxt'                 + s_0D0A +
    'TJvgCheckListBox=Edit'        + s_0D0A +
    'TJvgAskListBox=Edit'          + s_0D0A +
    'TJvCSVEdit=Edit'              + s_0D0A +
    'TJvListBox=Edit'              + s_0D0A +
    'TJvCheckListBox=Edit'         + s_0D0A +
    'TJvTextListBox=Edit'          + s_0D0A +
    'TJvxCheckListBox=Edit'        + s_0D0A +
    'TJvImageListBoxdit'           + s_0D0A +
    'TJvComboListBox=Edit'         + s_0D0A +
    'TJvHTListBox=Edit'            + s_0D0A +
    'TJvUninstallListBox=Edit'     + s_0D0A +
    'TJvFileListBox=Edit'          + s_0D0A +
    'TJvDirectoryListBox=Edit'     + s_0D0A +

    'TJvControlPanelButton=Button' + s_0D0A +
    'TJvStartMenuButton=Button'    + s_0D0A +
    'TJvRecentMenuButton'          + s_0D0A +
    'TJvFavoritesButton=Button'    + s_0D0A +
    'TJvHTButton=Button'           + s_0D0A +

    'TJvBitBtn=BitBtn'             + s_0D0A +
    'TJvImgBtn=BitBtn'             + s_0D0A +

    'TJvDBCheckBox=CheckBox'       + s_0D0A +
    'TJvCheckBox=CheckBox'         + s_0D0A +
    'TJvRadioButton=CheckBox'      + s_0D0A +
    'TGroupButton=CheckBox'        + s_0D0A +
    'TJvCheckBox=CheckBox'         + s_0D0A +
                                  
    'TJvRadioGroup=GroupBox'       + s_0D0A +
    'TJvGroupBox=GroupBox'         + s_0D0A +
                                  
    'TJvGroupBox=ListView'         + s_0D0A +
    'TJvPanel=Panel'               + s_0D0A +
                                  
    'TJvDBGrid=Grid'               + s_0D0A +
    'TJvDBUltimGrid=Grid'          + s_0D0A +
    'TJvgStringGrid=Grid'          + s_0D0A +
    'TJvDrawGrid=Grid'             + s_0D0A +
    'TJvStringGrid=Grid'           + s_0D0A +
                                  
    'TJvCheckTreeView=TreeView'    + s_0D0A +
    'TJvDBTreeView=TreeView'       + s_0D0A +
    'TJvJanTreeView=TreeView'      + s_0D0A +
    'TJvPageListTreeView=TreeView' + s_0D0A +
    'TJvSettingsTreeView=TreeView' + s_0D0A +
    'TJvTreeView=TreeView'         + s_0D0A +
    'TJvRegistryTreeView=TreeView' + s_0D0A +

    'TJvDBComboBox=ComboBox'       + s_0D0A +
    'TJvDBSearchComboBox=ComboBox' + s_0D0A +
    'TJvDBIndexCombo=ComboBox'     + s_0D0A +
    'TJvCSVComboBox=ComboBox'      + s_0D0A +
    'TJvComboBox=ComboBox'         + s_0D0A +
    'TJvHTComboBox=ComboBox'       + s_0D0A +
    'TJvUninstallComboBox=ComboBox'+ s_0D0A +

    'TJvPageControl=PageControl'   + s_0D0A +

    'TJvTabControl=TabControl'     + s_0D0A +

    'TJvDBGridFooter=StatusBar'    + s_0D0A +
    'TJvStatusBar=StatusBar'       + s_0D0A +

    'TJvScrollBox=ScrollControl'   + s_0D0A +

    'TJvUpDown=UpDownBtn'          + s_0D0A +
    'TJvDomainUpDown=UpDownBtn'    + s_0D0A +

    'TJvScrollBar=TScrollBar',
// 9. TMS Edits
    'TAdvStringGrid=Grid'           + s_0D0A +
    'TDBAdvGrid=Grid'               + s_0D0A +
    'TDBLUEdit=Edit'                + s_0D0A +
    'TAdvSpinEdit=Edit'             + s_0D0A +
    'TAdvLUEdit=Edit'               + s_0D0A +
    'TAdvEditBtn=Edit'              + s_0D0A +
    'TUnitAdvEditBtn=Edit'          + s_0D0A +
    'TAdvFileNameEdit=Edit'         + s_0D0A +
    'TAdvDirectoryEdit=Edit'        + s_0D0A +
    'TDBAdvLUEdit=Edit'             + s_0D0A +
    'TDBAdvSpinEdit=Edit'           + s_0D0A +
    'TDBAdvEdit=Edit'               + s_0D0A +
    'TDBAdvMaskEdit=Edit'           + s_0D0A +
    'TEditBtn=Edit'                 + s_0D0A +
    'TUnitEditBtn=Edit'             + s_0D0A +
    'TMoneyEdit=Edit'               + s_0D0A +
    'TDBMoneyEdit=Edit'             + s_0D0A +
    'TMaskEditEx=Edit'              + s_0D0A +
    'TEditListBox=Edit'             + s_0D0A +
    'TAdvEdit=Edit'                 + s_0D0A +
    'TAdvMaskEdit=Edit'             + s_0D0A +
    'TLUEdit=Edit'                  + s_0D0A +
    'TDBAdvEditBtn=Edit'            + s_0D0A +
    'TAdvMoneyEdit=Edit'            + s_0D0A +
    'TDBAdvMoneyEdit=Edit'          + s_0D0A +
    'THTMListBox=Edit'              + s_0D0A +
    'THTMLCheckList=Edit'           + s_0D0A +
    'TParamListBox=Edit'            + s_0D0A +
    'TParamCheckList=Edit'          + s_0D0A +
    'THTMLTreeview=TreeView'        + s_0D0A +
    'TParamTreeview=TreeView'       + s_0D0A +
    'TDBLUCombo=ComboBox'           + s_0D0A +
    'TAdvComboBox=ComboBox'         + s_0D0A +
    'TAdvListView=ListView'         + s_0D0A +
    'TLUCombo=ComboBox'             + s_0D0A +
    'TAdvDBLookupComboBox=ComboBox' + s_0D0A +
    'TAdvTreeComboBox=ComboBox'     + s_0D0A +
    'THTMLComboBox=ComboBox'        + s_0D0A +
    'TCheckListEdit=wwEdit',
// 10. SynEdits
    'TSynEdit=Edit'                 + s_0D0A +
    'TSynMemo=Edit'                 + s_0D0A +
    'TDBSynEdit=Edit',
// 11. mxEdits
    '',
// 12. RichViews
    'TRichView=Grid'                + s_0D0A +
    'TRVPrintPreview=Edit'          + s_0D0A +
    'TSRVPageScroll=Edit'           + s_0D0A +
    'TRVSpinEdit=Edit'              + s_0D0A +
    'TDBRichViewEdit=Grid'          + s_0D0A +
    'TRichViewEdit=Grid'            + s_0D0A +
    'TDBRichView=Grid',
// 13. Raize
    'TRzTreeView=TreeView'          + s_0D0A +
    'TRzEdit=Edit'                  + s_0D0A +
    'TRzHotKeyEdit=Edit'            + s_0D0A +
    'TRzMaskEdit=Edit'              + s_0D0A +
    'TRzNumericEdit=Edit'           + s_0D0A +
    'TRzExpandEdit=Edit'            + s_0D0A +
    'TRzMemo=Edit'                  + s_0D0A +
    'TRzListBox=Edit'               + s_0D0A +
    'TRzRankListBox=Edit'           + s_0D0A +
    'TRzTabbedListBox=Edit'         + s_0D0A +
    'TRzCheckList=Edit'             + s_0D0A +
    'TRzEditListBox=Edit'           + s_0D0A +
    'TRzCheckTree=TreeView'         + s_0D0A +
    'TRzRichEdit=Edit'              + s_0D0A +
    'TRzShellTree=TreeView'         + s_0D0A +
    'TRzGroupBox=GroupBox'          + s_0D0A +
    'TRzListView=ListView'          + s_0D0A +
    'TRzShellList=ListView'         + s_0D0A +
    'TRzPanel=Panel'                + s_0D0A +
    'TRzComboBox=ComboBox'          + s_0D0A +
    'TRzImageComboBox=ComboBox'     + s_0D0A +
    'TRzMRUComboBox=ComboBox'       + s_0D0A +
    'TRzShellCombo=ComboBox'        + s_0D0A +
    'TRzDateTimeEdit=wwEdit',
// 14. ImageEn
    'TImageEnView=Edit'               + s_0D0A +
    'TImageEnFolderMView=NativePaint' + s_0D0A +
    'ImageEn=Edit'
  );


implementation

{$R *.dfm}

uses sDefaults, ac3dNewClass, acntUtils, IniFiles, sStoreUtils;


procedure TForm3rdPartyEditor.Populate(ControlRepaint: boolean = True);
var
  i, j: integer;
begin
  if ControlRepaint then
    sListView1.Items.BeginUpdate;

  sListView1.Items.Clear;
  for j := 0 to Length(Lists) - 1 do
    for i := 0 to Lists[j].Count - 1 do
      if (Lists[j][i] <> s_Space) then begin
        sListView1.Items.Add;
        sListView1.Items[sListView1.Items.Count - 1].Caption := Lists[j][i];
        sListView1.Items[sListView1.Items.Count - 1].SubItems.Add(acThirdCaptions[j]);
        sListView1.Items[sListView1.Items.Count - 1].ImageIndex := j;
      end;

  if ControlRepaint then begin
    sListView1.Items.EndUpdate;
    RedrawWindow(sListView1.Handle, nil, 0, RDW_UPDATENOW or RDW_ERASE or RDW_INVALIDATE);
  end;
end;


procedure TForm3rdPartyEditor.sBitBtn2Click(Sender: TObject);
begin
  FormNewThirdClass := TFormNewThirdClass.Create(Application);
  FormNewThirdClass.sEdit1.Text := 'T';
  FormNewThirdClass.ShowModal;
  if FormNewThirdClass.ModalResult = mrOk then begin
    Lists[FormNewThirdClass.sComboBox1.ItemIndex].Add(FormNewThirdClass.sEdit1.Text);
    UpdateNames;
    Populate;
  end;
  FreeAndNil(FormNewThirdClass);
end;


procedure TForm3rdPartyEditor.sBitBtn1Click(Sender: TObject);
begin
  Close
end;


procedure TForm3rdPartyEditor.FormShow(Sender: TObject);
begin
  sListView1.Columns[1].Width := 150;
end;


procedure TForm3rdPartyEditor.sBitBtn3Click(Sender: TObject);
var
  i, j: integer;
{$IFDEF DELPHI6UP}
  LastIndex: integer;
{$ENDIF}
begin
{$IFDEF DELPHI6UP}
  LastIndex := sListView1.ItemIndex;
{$ENDIF}
  sListView1.Items.BeginUpdate;
  for i := 0 to sListView1.Items.Count - 1 do
    if sListView1.Items[i].Selected then begin
      j := 0;
      while j < Lists[sListView1.Items[i].ImageIndex].Count do
        if Lists[sListView1.Items[i].ImageIndex][j] = sListView1.Items[i].Caption then begin
          Lists[sListView1.Items[i].ImageIndex].Delete(j);
          if Lists[sListView1.Items[i].ImageIndex].Count = 0 then
            Lists[sListView1.Items[i].ImageIndex].Text := s_Space;
        end
        else
          inc(j);

    end;

  sListView1.Items.EndUpdate;
  UpdateNames;
  Populate;
{$IFDEF DELPHI6UP}
  if LastIndex > sListView1.Items.Count - 1 then
    sListView1.ItemIndex := sListView1.Items.Count - 1
  else
    sListView1.ItemIndex := LastIndex;
{$ENDIF}
end;


procedure TForm3rdPartyEditor.sCheckBox1Click(Sender: TObject);
var
  i: integer;
begin
  sListBox2.Items.BeginUpdate;
  for i := 0 to sListBox2.Items.Count - 1 do
    if sListBox2.ItemEnabled[i] then
      sListBox2.Checked[i] := TsCheckBox(Sender).Checked;

  sListBox2.Items.EndUpdate;
end;


procedure TForm3rdPartyEditor.sSpeedButton1Click(Sender: TObject);
var
  j, Ndx: integer;
begin
  FormNewThirdClass := TFormNewThirdClass.Create(Application);
  Ndx := {$IFDEF DELPHI6UP}sListView1.ItemIndex{$ELSE}sListView1.Selected.Index{$ENDIF};
  FormNewThirdClass.sEdit1.Text := sListView1.Items[Ndx].Caption;
  FormNewThirdClass.sComboBox1.ItemIndex := FormNewThirdClass.sComboBox1.IndexOf(sListView1.Items[Ndx].SubItems[0]);
  FormNewThirdClass.Caption := 'Edit';
  FormNewThirdClass.ShowModal;
  if FormNewThirdClass.ModalResult = mrOk then begin
    j := 0;
    while j < Lists[sListView1.Items[Ndx].ImageIndex].Count do
      if Lists[sListView1.Items[Ndx].ImageIndex][j] = sListView1.Items[Ndx].Caption then
        Lists[sListView1.Items[Ndx].ImageIndex].Delete(j)
      else
        inc(j);

    Lists[FormNewThirdClass.sComboBox1.ItemIndex].Add(FormNewThirdClass.sEdit1.Text);
    UpdateNames;
    Populate;
  end;
  FreeAndNil(FormNewThirdClass);
end;


procedure TForm3rdPartyEditor.sListView1Change(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  sSpeedButton1.Enabled := {$IFDEF DELPHI6UP}(sListView1.ItemIndex >= 0) and {$ENDIF}(sListView1.Selected <> nil);
  Delete1.Enabled := sSpeedButton1.Enabled;
  sBitBtn3.Enabled := sSpeedButton1.Enabled;
  Edit1.Enabled := sSpeedButton1.Enabled;
  sSpeedButton6.Enabled := sListView1.Items.Count > 0;
end;


type
  TAccessListbox = class(TsCheckListBox);

procedure TForm3rdPartyEditor.sListBox1Click(Sender: TObject);

  procedure ShowSupportedControls;
  var
    sl: TStringList;
    i, j{$IFDEF ALITE}, d, c{$ENDIF}: integer;
    s1, s2: string;
  begin
    sListBox2.Sorted := False;
    sListBox2.SkinData.BeginUpdate;
    sListBox2.Items.BeginUpdate;
    sListBox2.Items.Clear;
    sl := TStringList.Create;
    sl.Text := acCtrlsArray[sListBox1.ItemIndex];
    for i := 0 to sl.Count - 1 do begin
      s1 := acntUtils.ExtractWord(1, sl[i], ['=']); // Name of type
      s2 := acntUtils.ExtractWord(2, sl[i], ['=']); // Rule of skinning
      // Add new value
      for j := 0 to Length(acThirdCaptions) - 1 do
        if acThirdCaptions[j] = s2 then begin
{$IFDEF ALITE}
          d := 1;
          for c := 0 to Length(acLiteCtrls) - 1 do 
            if s1 = acLiteCtrls[c] then
              // Type was found
              d := 0;

          sListBox2.Items.AddObject(s1, TObject(d));
{$ELSE}
          sListBox2.Items.Add(s1);
{$ENDIF}
          Break;
        end;
    end;
    sListBox2.Items.EndUpdate;
    sListBox2.Items.BeginUpdate;
    sListBox2.Sorted := True;
    for i := 0 to sListBox2.Items.Count - 1 do
{$IFDEF ALITE}
      if (sListBox1.ItemIndex <> 0) or (TAccessListbox(sListBox2).GetItemData(i) = 1) then
        sListBox2.ItemEnabled[i] := False
      else
{$ENDIF}
        sListBox2.Checked[i] := True;

    sl.Free;
    sListBox2.Items.EndUpdate;
    sListBox2.SkinData.EndUpdate;
  end;

begin
  ShowSupportedControls;
  sSpeedButton2.Enabled := {$IFNDEF ALITE}sListBox1.ItemIndex >= 0{$ELSE}sListBox1.ItemIndex = 0{$ENDIF};
  SelectCtrls(sListBox1.ItemIndex);
end;


procedure TForm3rdPartyEditor.sSpeedButton2Click(Sender: TObject);
var
  sl: TStringList;
  i, j, l: integer;
  s1, s2: string;
begin
  sl := TStringList.Create;
  sl.Text := acCtrlsArray[sListBox1.ItemIndex];
  for i := 0 to sl.Count - 1 do begin
    s1 := acntUtils.ExtractWord(1, sl[i], ['=']); // Name of type
    s2 := acntUtils.ExtractWord(2, sl[i], ['=']); // Rule of skinning
    // Add new value
    for j := 0 to Length(acThirdCaptions) - 1 do
      if acThirdCaptions[j] = s2 then begin
        l := sListBox2.Items.IndexOf(s1);
        // If found and checked
        if (l > -1) and (sListBox2.Checked[l]) then
          if Lists[j].Text = s_Space + s_0D0A then
            Lists[j].Text := s1
          else
            // If not added yet
            if Lists[j].IndexOf(s1) < 0 then
              Lists[j].Add(s1);

        Break;
      end
  end;
  sl.Free;
  UpdateNames;
  Populate;
  SelectCtrls(sListBox1.ItemIndex);
end;


procedure TForm3rdPartyEditor.sListView1ColumnClick(Sender: TObject; Column: TListColumn);
begin
  if Column.Index = 0 then
    sListView1.SortType := stText
  else
    sListView1.SortType := stData;

  Populate;
end;


procedure TForm3rdPartyEditor.sListView1DblClick(Sender: TObject);
begin
  if sSpeedButton1.Enabled then
    sSpeedButton1.Click;
end;


procedure TForm3rdPartyEditor.SelectCtrls(TypeIndex: integer);
var
  sl: TStringList;
  i, j: integer;
  s1: string;
begin
  sl := TStringList.Create;
  sl.Text := acCtrlsArray[TypeIndex];
  for j := 0 to sListView1.Items.Count - 1 do
    sListView1.Items[j].Selected := False;

  for i := 0 to sl.Count - 1 do begin
    s1 := acntUtils.ExtractWord(1, sl[i], ['=']); // Name of type
    // Search
    for j := 0 to sListView1.Items.Count - 1 do
      if sListView1.Items[j].Caption = s1 then begin
        sListView1.Items[j].Selected := True;
        Break;
      end;
  end;
  sl.Free;
end;


const
  s_ThirdParty = 'ThirdParty';


procedure TForm3rdPartyEditor.sSpeedButton4Click(Sender: TObject);
var
  i, j: integer;
  iFile: TMeminiFile;
  s1, s2: string;
begin
  if SaveDialog1.Execute then begin
    iFile := TMeminiFile.Create(SaveDialog1.FileName);
    for j := 0 to Length(Lists) - 1 do
      for i := 0 to Lists[j].Count - 1 do
        if (Lists[j][i] <> s_Space) then begin
          s1 := Lists[j][i];
          s2 := acThirdCaptions[j];
          WriteIniStr(s_ThirdParty, s1, s2, iFile);
        end;

    iFile.UpdateFile;
    iFile.Free;
  end;
end;


procedure TForm3rdPartyEditor.sSpeedButton5Click(Sender: TObject);
var
  i, j: integer;
  s1, s2: string;
  sl: TStringList;
  iFile: TMeminiFile;
begin
  if OpenDialog1.Execute then begin
    iFile := TMeminiFile.Create(OpenDialog1.FileName);
    for j := 0 to Length(Lists) - 1 do
      Lists[j].Clear;

    sl := TStringList.Create;
    iFile.ReadSection(s_ThirdParty, sl);
    for i := 0 to sl.Count - 1 do begin
      s1 := sl[i];
      s2 := ReadIniString(s_ThirdParty, s1, iFile);
      for j := 0 to Length(acThirdCaptions) - 1 do
        if acThirdCaptions[j] = s2 then begin
          Lists[j].Add(s1);
          Break;
        end;
    end;
    iFile.Free;
  end;
  UpdateNames;
  Populate;
end;


procedure TForm3rdPartyEditor.sSpeedButton6Click(Sender: TObject);
var
  j: integer;
begin
  for j := 0 to Length(Lists) - 1 do
    Lists[j].Clear;

  Populate;
end;


procedure TForm3rdPartyEditor.FormCreate(Sender: TObject);
{$IFDEF ALITE}
var
  s: string;
  i: integer;
{$ENDIF}
begin
{$IFDEF ALITE}
  sBitBtn2.Enabled      := False;
  Addnew1.Enabled       := False;
  sBitBtn2.Hint         := 'Feature is not available for the Lite Edition package';
  sSpeedButton4.Enabled := False;
  sSpeedButton4.Hint    := sBitBtn2.Hint;
  sSpeedButton5.Enabled := False;
  sSpeedButton5.Hint    := sBitBtn2.Hint;

  s := acLiteCtrls[0];
  for i := 1 to Length(acLiteCtrls) - 1 do
    s := s + ', ' + acLiteCtrls[i];

  ShowMessage('List of supported standard controls for the Lite Edition is limited by these types of skinning : ' + s_0D0A + s);
{$ENDIF}
end;


procedure TForm3rdPartyEditor.Edit1Click(Sender: TObject);
begin
  sSpeedButton1.Click;
end;


procedure TForm3rdPartyEditor.UpdateNames;
begin
  if Cmp is TsSkinManager then
    UpdateThirdNames(TsSkinManager(Cmp))
  else
    UpdateProviderThirdNames(TsSkinProvider(Cmp))
end;

end.
