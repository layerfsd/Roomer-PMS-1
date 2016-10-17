unit uConvertGroups;

interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , Menus
  , ImgList
  , StdCtrls
  , Mask
  , ExtCtrls
  , Grids
  , Buttons
  , shellapi
  , ADODB
  , db
  , DBTables
  , DBCtrls
  , ComCtrls

  , uAppGlobal
  , hData
  , _glob
  , ug

  , PrjConst

  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection

  , sEdit
  , sLabel
  , sSpeedButton
  , sButton
  , sCheckBox
  , sPanel
  , sStatusBar

  , dxCore
  , cxGridExportLink
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxStyles
  , dxSkinsCore
  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters
  , dxSkinscxPCPainter
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxEdit
  , cxNavigator
  , cxDBData
  , cxTextEdit
  , dxPSGlbl
  , dxPSUtl
  , dxPSEngn
  , dxPrnPg
  , dxBkgnd
  , dxWrap
  , dxPrnDev
  , dxPSCompsProvider
  , dxPSFillPatterns
  , dxPSEdgePatterns
  , dxPSPDFExportCore
  , dxPSPDFExport
  , cxDrawTextUtils
  , dxPSPrVwStd
  , dxPSPrVwAdv
  , dxPSPrVwRibbon
  , dxPScxPageControlProducer
  , dxPScxGridLnk
  , dxPScxGridLayoutViewLnk
  , dxPScxEditorProducers
  , dxPScxExtEditorProducers
  , dxSkinsdxBarPainter
  , dxSkinsdxRibbonPainter
  , dxPSCore
  , dxPScxCommon
  , dxmdaset
  , cxGridLevel
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxClasses
  , cxGridCustomView
  , cxGrid, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld
  ;

type
  TfrmConvertGroups = class(TForm)
    sbMain: TsStatusBar;
    PanTop: TsPanel;
    btnClose: TsButton;
    labFilterWarning: TsLabel;
    panBtn: TsPanel;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    grData: TcxGrid;
    m_: TdxMemData;
    mnuOther: TPopupMenu;
    mnuiPrint: TMenuItem;
    mnuiAllowGridEdit: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_cgCode: TWideStringField;
    m_cgDescription: TWideStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDatacgCode: TcxGridDBColumn;
    tvDatacgDescription: TcxGridDBColumn;
    btnClear: TsSpeedButton;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnOther: TsButton;
    btnDelete: TsButton;
    btnEdit: TsButton;
    btnInsert: TsButton;
    BtnOk: TsButton;
    btnCancel: TsButton;
    m_Active: TBooleanField;
    m_ID: TIntegerField;
    tvDataActive: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    chkActive: TsCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure edFilterChange(Sender: TObject);
    procedure edFilterClickBtn(Sender: TObject);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataDblClick(Sender: TObject);
    procedure tvDatacgCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure chkActiveClick(Sender: TObject);

  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;
  public
    { Public declarations }
    zAct               : TActTableAction;
    zData              : recConvertGroupHolder;
  end;

function OpenConvertGroups(act : TActTableAction; var theData : recConvertGroupHolder) : boolean;

var
  frmConvertGroups: TfrmConvertGroups;

implementation

uses
   uD
  , uMessageList
  , uSqlDefinitions
  , uDimages
  ;

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function OpenConvertGroups(act : TActTableAction; var theData : recConvertGroupHolder) : boolean;
begin
  result := false;
  frmConvertgroups := TfrmConvertGroups.Create(frmConvertgroups);
  try
    frmConvertgroups.zData := theData;
    frmConvertgroups.zAct := act;
    frmConvertgroups.ShowModal;
    if frmConvertgroups.modalresult = mrOk then
    begin
      theData := frmConvertgroups.zData;
      result := true;
    end
    else
    begin
      initConvertGroupHolder(theData);
    end;
  finally
    freeandnil(frmConvertgroups);
  end;
end;


//END unit global functions


///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////

Procedure TfrmConvertGroups.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
begin
  active := chkActive.Checked;
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'cgCode ';

  s := '';
  rSet := CreateNewDataSet;
  try
    s := format(select_ConvertGroups_fillGridFromDataset , [ord(active),zSortStr]);

    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if sGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('cgCode',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure  TfrmConvertGroups.fillHolder;
begin
  initConvertGroupHolder(zData);
  zData.cgCode                 := m_.fieldbyname('cgCode').asstring;
  zData.cgDescription          := m_.fieldbyname('cgDescription').asstring;
  zData.ID                     := m_.fieldbyname('ID').asInteger;
  zData.Active                 := m_.fieldbyname('Active').asBoolean;
end;

procedure TfrmConvertGroups.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataCgCode.Options.Editing         := true;
    tvDataCgDescription.Options.Editing  := true;
    tvDataActive.Options.Editing         := true;
    tvDataID.Options.Editing             := False;
  end else
  begin
    tvDataCgCode.Options.Editing         := false;
    tvDataCgDescription.Options.Editing  := false;
    tvDataActive.Options.Editing         := False;
    tvDataID.Options.Editing             := False;
  end;
end;


procedure TfrmConvertGroups.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.cgCode);
  zFirstTime := false;
end;

Procedure TfrmConvertGroups.ChkFilter;
var
  sFilter : string;
  rC1,rc2   : integer;
begin
  sFilter := edFilter.text;
  rc1 := tvData.DataController.RecordCount;
  rc2 := tvData.DataController.FilteredRecordCount;

  zFilterON := rc1 <> rc2;

  if zFilterON then
  begin
    labFilterWarning.Visible    := true;
    labFilterWarning.Color      := clMoneyGreen;
    labFilterWarning.Font.Style := [fsBold];                         //-C
//     labFilterWarning.caption    := shFilterOn+' - '+inttostr(rc2)+' '+shRecordsOf+' '+inttostr(rc1)+' '+shAreVisible+' ';;
    labFilterWarning.caption    := format(GetTranslatedText('shFilterOnRecordsOf'), [rc2, rc1]);
  end else
  begin
    labFilterWarning.Visible    := false;
  end;
end;

procedure TfrmConvertGroups.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    tvData.DataController.Filter.Root.Clear;
    tvData.DataController.Filter.Active := false;
  end else
  begin
    applyFilter;
  end;
end;

procedure TfrmConvertGroups.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataCgCode,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataCgDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;




/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmConvertGroups.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmConvertGroups.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
   glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  zFirstTime  := true;
  zAct        := actNone;
  zisAddRow   := false;
end;

procedure TfrmConvertGroups.FormShow(Sender: TObject);
begin
  panBtn.Visible := False;
  sbMain.Visible := false;
  btnClose.Visible := False;

  fillGridFromDataset(zData.cgCode);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end else
  begin
    mnuiAllowGridEdit.Checked := true;
    btnClose.Visible := true;
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmConvertGroups.FormDestroy(Sender: TObject);
begin
  //
end;


procedure TfrmConvertGroups.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //*NOT TESTED*//
  if ZAct = actLookup then
  begin
    if key = chr(13) then
    begin
      if activecontrol = edFilter then
      begin
      end else
      begin
        btnOk.click;
      end;
    end;

    if key = chr(27) then
    begin
      if activecontrol = edFilter then
      begin
      end else
      begin
        btnCancel.click;
      end;
    end;
  end;
end;


////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmConvertGroups.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.convertGroupExistsInOther(zData.cgCode) then
  begin
    Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['ConvertGroup', zData.cgDescription]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteItem')+' '+zData.cgDescription+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not DEL_convertGroup(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;


procedure TfrmConvertGroups.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('cgCode').Focused := True;
end;

procedure TfrmConvertGroups.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;
  initConvertGroupHolder(zData);
  zData.ID                  := dataset.FieldByName('ID').AsInteger;
  zData.cgCode              := dataset['cgCode'];
  zData.Active              := dataset['Active'];
  zData.cgDescription       := dataset['cgDescription'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_ConvertGroup(zData) then
    begin
       glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('cgCode').AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shTx_Items2_ItemRequired'));
      tvData.GetColumnByFieldName('cgCode').Focused := True;
      abort;
      exit;
    end;
    if ins_Convertgroup(zData) then
    begin
      m_.FieldByName('ID').AsInteger := nID;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
  glb.ForceTableRefresh;
end;

procedure TfrmConvertGroups.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']          := true;
  dataset['cgDescription']     := '';
  dataset['cgCode']          := '';
end;

////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmConvertGroups.tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if AFocusedRecord = nil then
  begin
    zIsAddrow := true;
  end else
  begin
    zIsAddrow := false;
  end;
end;


procedure TfrmConvertGroups.tvDatacgCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('cgCode').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    //errortext := 'cgCode code '+' - '+'is required - Use ESC to cancel';
	errortext := GetTranslatedText('shTx_ConvertGroups_CodeIsRequiredUseEsc');
    exit;
  end;

  if hdata.convertGroupExists(displayValue) then
  begin
    error := true;
    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
    errortext := displayvalue+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.convertGroupExistsInOther(currValue) then
    begin
      error := true;
      // errortext := displayvalue+'Eldra gildi fannst í tengdri færslu ekki hægt að breyta - Notið 'ESC-hnappin til að hætta við';
      errortext := displayvalue+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;


procedure TfrmConvertGroups.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end else
  begin
    btnedit.click
  end;
end;

////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


procedure TfrmConvertGroups.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmConvertGroups.tvDataDataControllerSortingChanged(Sender: TObject);
var
  i : integer;
  s : string;
  serval : boolean;
begin
  s := '';
  serval := false;
  for i :=  0 to tvData.SortedItemCount - 1 do
  begin
    if serval then s := s+', ';
    s := s+TcxGridDBColumn(tvData.SortedItems[I]).DataBinding.FieldName;
    serval := true;
    if tvData.SortedItems[i].SortOrder = soDescending then
    s := s + ' DESC';
  end;
  zSortStr := s;
  sbMain.SimpleText := s;
end;

procedure TfrmConvertGroups.edFilterClickBtn(Sender: TObject);
begin
  edFilter.Text := '';
end;





//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////

procedure TfrmConvertGroups.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;


procedure TfrmConvertGroups.btnCancelClick(Sender: TObject);
begin
  initConvertGroupHolder(zData);
end;

procedure TfrmConvertGroups.btnCloseClick(Sender: TObject);
begin
  if m_.recordCount > 0 then fillHolder;
end;

procedure TfrmConvertGroups.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConvertGroups.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('cgCode').Focused := True;
end;

procedure TfrmConvertGroups.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('cgDescription').Focused := True;
  showmessage(GetTranslatedText('shTx_Items2_EditInGrid'));
end;

procedure TfrmConvertGroups.btnDeleteClick(Sender: TObject);
begin
  m_.delete    ;
end;


////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmConvertGroups.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;

  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmConvertGroups.mnuiGridToExcelClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
  //  To export ot xlsx form then use this
  //  ExportGridToXLSX(sFilename, grData, true, true, true);
  //  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil, sw_shownormal);
end;

procedure TfrmConvertGroups.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmConvertGroups.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmConvertGroups.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmConvertGroups.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;


end.
