unit uPayGroups;

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

  , dxCore
  , cxGridExportLink
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxStyles
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxEdit
  , cxNavigator
  , cxDBData
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGrid
  , cxTextEdit
  , cxContainer
  , cxDBEdit
  , cxGridCardView
  , cxGridDBCardView
  , cxGridCustomLayoutView
  , dxLayoutContainer
  , cxGridLayoutView
  , cxGridDBLayoutView
  , cxSpinEdit
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
  , dxPScxEditorProducers
  , dxPScxExtEditorProducers
  , dxPSCore
  , dxPScxGridLnk
  , dxPScxGridLayoutViewLnk
  , dxPScxCommon
  , dxmdaset
  , cxGridBandedTableView
  , cxGridDBBandedTableView
  , cxCalc

  , AdvEdit
  , AdvEdBtn

  , PrjConst

  , cmpRoomerDataSet
  , cmpRoomerConnection

  , sButton
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sSkinProvider
  , sPanel
  , sComboEdit, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, sCheckBox, sEdit, sSpeedButton, sLabel, sStatusBar,
  dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld
  ;

type
  TfrmPayGroups = class(TForm)
    sbMain: TsStatusBar;
    PanTop: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
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
    m_payGroup: TWideStringField;
    m_Description: TWideStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDatapayGroup: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    sLabel1: TsLabel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnClear: TsSpeedButton;
    edFilter: TsEdit;
    chkActive: TsCheckBox;
    m_Active: TBooleanField;
    tvDataActive: TcxGridDBColumn;
    m_ID: TIntegerField;
    FormStore: TcxPropertiesStore;
    m_Cash: TBooleanField;
    tvDataCash: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure btnOtherClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataDblClick(Sender: TObject);
    procedure tvDatapayGroupPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    zFirstTime       : boolean;

    zAllowGridEdit   : boolean;
    zFilterOn          : boolean;
    zSortStr           : string;

    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;
  public
    { Public declarations }
    zAct               : TActTableAction;
    zData              : recPayGroupHolder;
  end;

function payGroup(act : TActTableAction; var theData : recpayGroupHolder) : boolean;
function getPayGroup(ed : TsComboEdit; lab : TsLabel) : boolean;
function payGroupValidate(ed : TsComboEdit; lab: TsLabel) : boolean;

var
  frmPayGroups: TfrmPayGroups;

implementation

uses
   uD
   ,uSqlDefinitions
   , uDImages
   , uUtils
  ;

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function payGroup(act : TActTableAction; var theData : recPayGroupHolder) : boolean;
begin
  result := false;
  frmPayGroups := TfrmPayGroups.Create(frmPayGroups);
  try
    frmPayGroups.zData := theData;
    frmPayGroups.zAct := act;
    frmPayGroups.ShowModal;
    if frmPayGroups.modalresult = mrOk then
    begin
      theData := frmPayGroups.zData;
      result := true;
    end
    else
    begin
      initPayGroupHolder(theData);
    end;
  finally
    freeandnil(frmPayGroups);
  end;
end;


function getPayGroup(ed : TsComboEdit; lab : TsLabel) : boolean;
var
  theData : recPayGroupHolder;
begin
  initPayGroupHolder(theData);
  theData.payGroup := trim(ed.text);
  result := payGroup(actLookup,theData);

  if trim(theData.payGroup) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (theData.payGroup <> ed.text) then
  begin
    ed.text := theData.payGroup;
    lab.Caption := theData.Description;
  end;
end;


function payGroupValidate(ed : TsComboEdit; lab : TsLabel) : boolean;
var
  sValue : string;
  pcCode : string;
  theData : recPayGroupHolder;
begin
  initPayGroupHolder(theData);
  theData.payGroup := trim(ed.Text);
  result := hdata.GET_payGroupHolder(theData);

  if not result then
  begin
    ed.SetFocus;
    lab.Color := clRed;
    lab.caption := GetTranslatedText('shNotF_star');
  end else
  begin
    lab.Color := clBtnFace;
    lab.caption := theData.Description;
  end;
end;
//END unit global functions


///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////

Procedure TfrmPayGroups.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
begin
  active := chkActive.Checked;
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'payGroup ';

  rSet := CreateNewDataSet;
  try
    s := format(select_Paygroups_fillGridFromDataset_byActive , [ord(active),zSortStr]);
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
          m_.Locate('payGroup',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure  TfrmPayGroups.fillHolder;
begin
  initPayGroupHolder(zData);
  zData.payGroup        := m_.fieldbyname('payGroup').asstring;
  zData.Description     := m_.fieldbyname('Description').asstring;
  zData.active          := m_['Active'];
  zData.Cash            := m_['Cash'];
  zData.Id      := m_.fieldbyname('ID').asInteger;
end;

procedure TfrmPayGroups.changeAllowgridEdit;
begin
  tvDataPayGroup.Options.Editing       := zAllowGridEdit;
  tvDataDescription.Options.Editing    := zAllowGridEdit;
  tvDataActive.Options.Editing    := zAllowGridEdit;
  tvDataCash.Options.Editing    := zAllowGridEdit;
end;

procedure TfrmPayGroups.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.payGroup);
  zFirstTime := false;
end;

Procedure TfrmPayGroups.ChkFilter;
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
  end else
  begin
  end;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmPayGroups.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fillHolder;
end;

procedure TfrmPayGroups.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  zFirstTime  := true;
  zAct        := actNone;
end;

procedure TfrmPayGroups.FormShow(Sender: TObject);
begin
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.payGroup);
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end else
  begin
    mnuiAllowGridEdit.Checked := true;
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmPayGroups.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TfrmPayGroups.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmPayGroups.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmPayGroups.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  //**
  fillHolder;

  if hdata.PaygroupExistsInOther(zData.payGroup) then
  begin
	  Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Paygroup', zData.Description]));
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeletePayGroup')+' '+zData.payGroup+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    screen.Cursor := crHourGlass;
    try
      if not Del_Paygroup(zData) then
      begin
        abort
      end;
    finally
      screen.Cursor := crDefault;
    end;
  end else
  begin
    abort;
  end;
end;


procedure TfrmPayGroups.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('payGroup').Focused := True;
end;

procedure TfrmPayGroups.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;
  nId := 0;

  initPayGroupHolder(zData);
  zData.payGroup      := dataset['payGroup'];
  zData.Description   := dataset['Description'];
  zData.active        := dataset['Active'];
  zData.Cash          := dataset['Cash'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_Paygroup(zData) then
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
    if dataset.FieldByName('PayGroup').AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shTx_PayGroups_PayGroupRequired'));
      tvData.GetColumnByFieldName('PayGroup').Focused := True;
      abort;
      exit;
    end;

    if ins_PayGroup(zData,nID) then
    begin
      m_.FieldByName('ID').AsInteger := nID;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;


procedure TfrmPayGroups.m_NewRecord(DataSet: TDataSet);
begin
  dataset['payGroup'] := '';
  dataset['Description'] := '';
  dataset['Active'] := true;
  dataset['Cash'] := False;
end;


////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmPayGroups.tvDatapayGroupPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('payGroup').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
  //  errortext := 'payGroup code '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_PayGroups_PayGroupCodeIsRequired');
    exit;
  end;

  if hdata.payGroupExist(displayValue) then
  begin
    error := true;
    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
    errortext := displayvalue+' '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.payGroupExistsInOther(currValue) then
    begin
      error := true;
      // errortext := displayvalue+'Eldra gildi fannst í tengdri færslu ekki hægt að breyta - Notið 'ESC-hnappin til að hætta við';
      errortext := displayvalue+' '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;


procedure TfrmPayGroups.tvDataDataControllerSortingChanged(Sender: TObject);
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



procedure TfrmPayGroups.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;

////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmPayGroups.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmPayGroups.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataPayGroup,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

procedure TfrmPayGroups.edFilterChange(Sender: TObject);
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

//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////

procedure TfrmPayGroups.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;


procedure TfrmPayGroups.btnCancelClick(Sender: TObject);
begin
  initPayGroupHolder(zData);
end;

procedure TfrmPayGroups.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmPayGroups.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPayGroups.btnOtherClick(Sender: TObject);
begin
  //
end;

procedure TfrmPayGroups.btnDeleteClick(Sender: TObject);
begin
   m_.Delete;
end;


procedure TfrmPayGroups.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('payGroup').Focused := True;
  showmessage(GetTranslatedText('shTx_PayGroups_EditInGrid'));
end;

procedure TfrmPayGroups.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('payGroup').Focused := True;
end;

////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmPayGroups.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;

  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmPayGroups.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmPayGroups.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmPayGroups.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmPayGroups.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmPayGroups.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;


end.
