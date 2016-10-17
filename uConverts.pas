unit uConverts;

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

  , sCheckBox
  , sSpeedButton
  , sEdit
  , sButton

  , uUtils

  , PrjConst
  , cxButtonEdit

  , cmpRoomerDataSet
  , cmpRoomerConnection

  , cxGridExportLink
  , dxCore
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
  , cxGrid

  , sLabel
  , sPanel
  , sStatusBar, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

  ;

type
  TfrmConverts = class(TForm)
    sbMain: TsStatusBar;
    PanTop: TsPanel;
    labFilterWarning: TsLabel;
    panBtn: TsPanel;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
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
    m_cvType: TWideStringField;
    m_cvFrom: TWideStringField;
    m_cvTo: TWideStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDatacvType: TcxGridDBColumn;
    tvDatacvFrom: TcxGridDBColumn;
    tvDatacvTo: TcxGridDBColumn;
    m_ID: TIntegerField;
    tvDataID: TcxGridDBColumn;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    btnOther: TsButton;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    chkActive: TsCheckBox;
    btnClose: TsButton;
    btnCancel: TsButton;
    BtnOk: TsButton;
    m_Active: TBooleanField;
    tvDataActive: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDatacvTypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataDblClick(Sender: TObject);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure edFilterClickBtn(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure tvDatacvTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure chkActiveClick(Sender: TObject);
    procedure m_BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn          : boolean;
    zSortStr           : string;

    Procedure fillGridFromDataset(iGoto : integer);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;
  public
    { Public declarations }
    zAct               : TActTableAction;
    zData              : recConvertHolder;
  end;

function OpenConverts(act : TActTableAction; var theData : recConvertHolder) : boolean;


var
  frmConverts: TfrmConverts;

implementation

uses
    uD
  , uSqlDefinitions
  , uMessageList
  , uConvertGroups
  , uDImages;


{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function OpenConverts(act : TActTableAction; var theData : recConvertHolder) : boolean;
begin
  result := false;
  frmConverts := TfrmConverts.Create(frmConverts);
  try
    frmConverts.zData := theData;
    frmConverts.zAct := act;
    frmConverts.ShowModal;
    if frmConverts.modalresult = mrOk then
    begin
      theData := frmConverts.zData;
      result := true;
    end
    else
    begin
      initConvertHolder(theData);
    end;
  finally
    freeandnil(frmConverts);
  end;
end;
//END unit global functions


///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////

Procedure TfrmConverts.fillGridFromDataset(iGoto : integer);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
begin
  active := chkActive.Checked;

  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'cvType ';

  rSet := CreateNewDataSet;
  try
    s := format(select_Converts_fillGridFromDataset , [ord(active),zSortStr]);

    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if iGoto = 0 then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('ID',iGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure  TfrmConverts.fillHolder;
begin
  initConvertHolder(zData);
  zData.cvID       := m_.fieldbyname('Id').asInteger;
  zData.cvType     := m_.fieldbyname('cvType').asstring;
  zData.cvFrom     := m_.fieldbyname('cvFrom').asString;
  zData.cvTo       := m_.fieldbyname('cvTo').asString;
  zData.active     := m_['Active'];
end;


procedure TfrmConverts.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing        := false;
    tvDataCvType.Options.Editing    := true;
    tvDataCvFrom.Options.Editing    := true;
    tvDataCvTo.Options.Editing      := true;
    tvDataActive.Options.Editing    := true;
  end else
  begin
    tvDataID.Options.Editing        := false;
    tvDataCvType.Options.Editing    := false;
    tvDataCvFrom.Options.Editing    := false;
    tvDataCvTo.Options.Editing      := false;
    tvDataActive.Options.Editing    := false;
  end;
end;


procedure TfrmConverts.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.cvID);
  zFirstTime := false;
end;

Procedure TfrmConverts.ChkFilter;
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
//    labFilterWarning.caption    := shFilterOn+' - '+inttostr(rc2)+' '+shRecordsOf+' '+inttostr(rc1)+' '+shAreVisible+' ';;
    labFilterWarning.caption    := format(GetTranslatedText('shFilterOnRecordsOf'), [rc2, rc1]);
  end else
  begin
    labFilterWarning.Visible    := false;
  end;
end;


procedure TfrmConverts.edFilterChange(Sender: TObject);
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

procedure TfrmConverts.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDatacvType,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatacvFrom,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatacvTo,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmConverts.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmConverts.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
   glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  zFirstTime  := true;
  zAct        := actNone;
end;


procedure TfrmConverts.FormShow(Sender: TObject);
begin
  panBtn.Visible := False;
  sbMain.Visible := false;
  btnClose.Visible := False;

  fillGridFromDataset(zData.cvID);
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


procedure TfrmConverts.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmConverts.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;

  s := '';
  s := s+GetTranslatedText('shDeleteItem')+' '+zData.cvType+', From '+zData.cvFrom+' to '+zData.cvTo+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not DEL_convert(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmConverts.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('cvType').Focused := True;
end;

procedure TfrmConverts.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;
  initConvertHolder(zData);
  zData.cvID                := dataset.FieldByName('ID').AsInteger;
  zData.cvType              := dataset['cvType'];
  zData.Active              := dataset['Active'];
  zData.cvFrom              := dataset['cvFrom'];
  zData.cvTo                := dataset['cvTo'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_Convert(zData) then
    begin
       glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end
  else
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('cvFrom').AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shTx_Items2_ItemRequired'));
      tvData.GetColumnByFieldName('cvFrom').Focused := True;
      abort;
      exit;
    end;
    if ins_Convert(zData) then
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

procedure TfrmConverts.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']     := true;
  dataset['cvFrom']     := '';
  dataset['cvTo']       := '';
  dataset['cvType']     := '';
end;


////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmConverts.tvDatacvTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recConvertGroupHolder;
begin
  fillholder;
  theData.cgCode := zData.cvType;
  OpenConvertGroups(actlookup,theData);

  if theData.cgCode <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['cvType'] := theData.cgCode;
  end;
end;

procedure TfrmConverts.tvDatacvTypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('cvType').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    //errortext := 'Convert Type '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_Converts_TypeRequired');
    exit;
  end;
end;

procedure TfrmConverts.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end else
  begin
    btnedit.click
  end;
end;

procedure TfrmConverts.tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
end;

////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmConverts.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmConverts.tvDataDataControllerSortingChanged(Sender: TObject);
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

procedure TfrmConverts.edFilterClickBtn(Sender: TObject);
begin
  edFilter.Text := '';
end;

//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////

procedure TfrmConverts.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;


procedure TfrmConverts.btnCancelClick(Sender: TObject);
begin
  initConvertHolder(zData);
end;

procedure TfrmConverts.btnCloseClick(Sender: TObject);
begin
  fillHolder;
end;


procedure TfrmConverts.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('cvType').Focused := True;
end;


procedure TfrmConverts.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('cgDescription').Focused := True;
  showmessage(GetTranslatedText('shTx_Items2_EditInGrid'));
end;


procedure TfrmConverts.btnDeleteClick(Sender: TObject);
var
  s : string;

  prevCode : integer;
  currCode : integer;

begin
  fillHolder;
  s := '';
  s := s+GetTranslatedText('shDeleteConvertItem')+' '+zData.cvFrom+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    screen.Cursor := crHourGlass;
    try
      currCode := zData.cvId;
//      prevCode := GetPrevCode;

      if Del_Convert(zData) then
      begin
        try
          fillGridFromDataset(prevCode);
        except
        end;
      end;
    finally
      screen.Cursor := crDefault;
    end;
  end;
end;


////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmConverts.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;

  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmConverts.mnuiGridToExcelClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramExePath + caption;
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
  //  To export ot xlsx form then use this
  //  ExportGridToXLSX(sFilename, grData, true, true, true);
  //  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil, sw_shownormal);
end;

procedure TfrmConverts.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmConverts.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramExePath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmConverts.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramExePath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;


procedure TfrmConverts.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;


end.




