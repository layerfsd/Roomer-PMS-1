unit uBookKeepingCodes;

interface

// unit added 2013-02-28 HJ

uses
    Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.Buttons
  , Vcl.StdCtrls
  , Vcl.ComCtrls
  , Vcl.Menus
  , Vcl.ExtCtrls
  , Generics.Collections
  , Data.DB
  , shellapi
  , _glob
  , uAppGlobal
  , Hdata
  , ug
  , uManageFilesOnServer
  , kbmMemTable

  , sSkinProvider
  , sSpeedButton
  , sEdit
  , sPageControl
  , sStatusBar
  , sLabel
  , sButton
  , sPanel

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
  , dxPSCore
  , dxPScxCommon

  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCheckBox, cxButtonEdit, cxSpinEdit, cxCalc, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter,
  cxPropertiesStore, dxmdaset, sCheckBox, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxPScxPivotGridLnk, cxDropDownEdit, cxGridBandedTableView, cxGridDBBandedTableView

  ;

type
  TfrmBookKeepingCodes = class(TForm)
    sPanel1: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
    sbMain: TsStatusBar;
    edFilter: TsEdit;
    cLabFilter: TsLabel;
    btnClear: TsSpeedButton;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    m_ID: TIntegerField;
    btnInsert: TsButton;
    btnEdit: TsButton;
    FormStore: TcxPropertiesStore;
    chkActive: TsCheckBox;
    pnlHolder: TsPanel;
    m_code: TStringField;
    m_description: TStringField;
    m_txStatus: TStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDatacode: TcxGridDBColumn;
    tvDatadescription: TcxGridDBColumn;
    __tvDatatxStatus: TcxGridDBColumn;
    mnuOther: TPopupMenu;
    mnuiPrint: TMenuItem;
    mnuiAllowGridEdit: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    m_bookOnCustomer: TBooleanField;
    tvDatabookOnCustomer: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataDblClick(Sender: TObject);
    procedure tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure m_AfterScroll(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    Procedure fillGridFromDataset(const sGoto : String);
    Procedure chkFilter;
    procedure applyFilter;
    procedure NoGridEdit;
    procedure SetEditOnOff(setOn: Boolean);


  public
    { Public declarations }
    zAct   : TActTableAction;
    GlobalRecordSet : TRoomerDataSet;
    sGoto : String;
    SelectedCode : String;
  end;

function BookKeepingCodes(act : TActTableAction;const sGoto : String = '') : String;

var
  frmBookKeepingCodes: TfrmBookKeepingCodes;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uCurrencies
  , uMultiSelection
  , udImages
  , uFrmResources
  , uFrmNotepad
  , uMain
  , uPackages
  , uGuestPortfolioEdit
  , UITypes
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function BookKeepingCodes(act : TActTableAction; const sGoto : String = '') : String;
var _frmBookKeepingCodes: TfrmBookKeepingCodes;
begin
  result := '';
  _frmBookKeepingCodes := TfrmBookKeepingCodes.Create(nil);
  try
    _frmBookKeepingCodes.zAct := act;
    _frmBookKeepingCodes.sGoto := sGoto;
    _frmBookKeepingCodes.ShowModal;

      if _frmBookKeepingCodes.modalresult = mrOk then
        result := _frmBookKeepingCodes.SelectedCode
      else
        result := '';
  finally
    freeandnil(_frmBookKeepingCodes);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmBookKeepingCodes.fillGridFromDataset(const sGoto : String);
var
  s    : string;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'ID';
  GlobalRecordSet := CreateNewDataSet;
  s := 'SELECT * FROM bookkeepingcodes ORDER BY code';
  if rSet_bySQL(GlobalRecordSet,s) then
  begin
    if m_.active then m_.Close;
    m_.LoadFromDataSet(GlobalRecordSet);
    m_.Open;
    if sGoto = '' then
    begin
      m_.First;
    end else
    begin
      try
        m_.Locate('code',sGoto,[]);
      except
      end;
    end;
  end;
  btnEditClick(nil);
  if zAct = actLookup then
    mnuiAllowGridEditClick(mnuiAllowGridEdit);
  zFirstTime := false;
end;

procedure TfrmBookKeepingCodes.chkFilter;
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


procedure TfrmBookKeepingCodes.edFilterChange(Sender: TObject);
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

procedure TfrmBookKeepingCodes.applyFilter;
var i : Integer;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  for i := 0 to tvData.ColumnCount - 1 do
    if tvData.Columns[i].DataBinding.ValueType = 'String' then
      tvData.DataController.Filter.Root.AddItem(tvData.Columns[i],foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

procedure TfrmBookKeepingCodes.NoGridEdit;
var i : Integer;
begin
  for i := 0 to tvData.ColumnCount - 1 do
    tvData.Columns[i].Options.Editing := False;
end;

/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmBookKeepingCodes.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmBookKeepingCodes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tvdata.DataController.DataSet.State in [dsInsert, dsEdit] then
    tvdata.DataController.Post;

  update;
  freeandnil(GlobalRecordSet);
  glb.RefreshTableByName('bookkeepingcodes');
end;

procedure TfrmBookKeepingCodes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmBookKeepingCodes.FormKeyPress(Sender: TObject; var Key: Char);
begin
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


procedure TfrmBookKeepingCodes.FormShow(Sender: TObject);
begin
  fillGridFromDataset(sGoto);
  NoGridEdit;
end;

////////////////////////////////////////////////////////////////////////////////////////
// memory table

procedure TfrmBookKeepingCodes.m_AfterScroll(DataSet: TDataSet);
begin
  if NOT m_.Eof then
    SelectedCode := m_['code'];
end;

procedure TfrmBookKeepingCodes.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  s := '';
  s := s+GetTranslatedText('shDeleteBookKeepingCode')+' '+DataSet['code'] + ',' + DataSet['description']+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    hData.cmd_bySQL('DELETE FROM bookkeepingcodes WHERE ID=' + inttostr(Dataset['ID']))
  else
    abort
end;

procedure TfrmBookKeepingCodes.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('code').Focused := True;
end;


procedure TfrmBookKeepingCodes.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if DataSet['code'] <> SelectedCode then
    begin
      d.roomerMainDataSet.DoCommand(format(
              'UPDATE items SET BookKeepCode=''%s'' WHERE BookKeepCode=''%s''',
              [DataSet['code'], SelectedCode]));
      d.roomerMainDataSet.DoCommand(format(
              'UPDATE paytypes SET BookKeepCode=''%s'' WHERE BookKeepCode=''%s''',
              [DataSet['code'], SelectedCode]));
      d.roomerMainDataSet.DoCommand(format(
              'UPDATE vatcodes SET BookKeepCode=''%s'' WHERE BookKeepCode=''%s''',
              [DataSet['code'], SelectedCode]));
    end;
    if d.roomerMainDataSet.DoCommand(format(
            'UPDATE bookkeepingcodes SET code=''%s'', description=''%s'', txStatus=''%s'', bookOnCustomer=%d WHERE code=''%s''',
            [DataSet['code'], DataSet['description'], DataSet['txStatus'], ABS(ORD(DataSet.FieldByName('bookOnCustomer').AsBoolean)), SelectedCode])) >= 0 then
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
    if dataset.FieldByName('code').AsString = ''  then
    begin
    //  showmessage('Location is requierd - set value or use [ESC] to cancel ');
	    showmessage(GetTranslatedText('shTx_Locations2_LocationRequired'));
      tvData.GetColumnByFieldName('Location').Focused := True;
      abort;
      exit;
    end;
    nId := d.roomerMainDataSet.DoCommand(format(
            'INSERT INTO bookkeepingcodes (code,description,txStatus,bookOnCustomer) VALUES(''%s'',''%s'',''%s'',%d)',
            [DataSet['code'], DataSet['description'], DataSet['txStatus'], ABS(ORD(DataSet.FieldByName('bookOnCustomer').AsBoolean))]));

    if nID >= 0 then
    begin
      m_.fieldbyname('ID').AsInteger := nID;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;

procedure TfrmBookKeepingCodes.m_NewRecord(DataSet: TDataSet);
begin
  dataset['code']         := '';
  dataset['description']  := '';
  dataset['txStatus']     := 'CREDIT';
  dataset['bookOnCustomer']     := false;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmBookKeepingCodes.tvDataFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
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

procedure TfrmBookKeepingCodes.tvDataDblClick(Sender: TObject);
begin
  if not mnuiAllowGridEdit.Checked then
  begin
    if ZAct = actLookup then
    begin
      btnOK.Click
    end;
  end;

end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


procedure TfrmBookKeepingCodes.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmBookKeepingCodes.tvDataDataControllerSortingChanged(Sender: TObject);
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

//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////


procedure TfrmBookKeepingCodes.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmBookKeepingCodes.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;


procedure TfrmBookKeepingCodes.SetEditOnOff(setOn : Boolean);
begin
  tvDataID.Options.Editing             := setOn;
  tvDataCode.Options.Editing           := setOn;
  tvDataDescription.Options.Editing    := setOn;
  __tvDatatxStatus.Options.Editing       := setOn;
  tvDatabookOnCustomer.Options.Editing := setOn;
end;

procedure TfrmBookKeepingCodes.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  SetEditOnOff(mnuiAllowGridEdit.Checked);
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
  if Assigned(Sender) then
    showmessage(GetTranslatedText('shTx_Items2_EditInGrid'));
end;

procedure TfrmBookKeepingCodes.btnInsertClick(Sender: TObject);
begin
  if NOT m_.Active then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('code').Focused := True;
  mnuiAllowGridEdit.Checked := true;
  SetEditOnOff(mnuiAllowGridEdit.Checked);
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmBookKeepingCodes.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmBookKeepingCodes.mnuiAllowGridEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  SetEditOnOff(mnuiAllowGridEdit.Checked);
end;

procedure TfrmBookKeepingCodes.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmBookKeepingCodes.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmBookKeepingCodes.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmBookKeepingCodes.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

