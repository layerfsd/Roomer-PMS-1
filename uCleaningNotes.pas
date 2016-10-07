unit uCleaningNotes;

interface

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
  , Hdata
  , ug
  , uD
  , uFrmKeyPairSelector
  , RoomerCloudEntities

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

  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCalc, cxButtonEdit, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, dxmdaset,
  dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, sCheckBox, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxDropDownEdit, cxCheckBox, cxCalendar, cxCurrencyEdit,
  uCurrencyHandler
  , uRoomerForm, dxSkinsdxStatusBarPainter, dxStatusBar

  ;

type
  {$SCOPEDENUMS ON}
  TfrmCleaningNotes = class(TfrmBaseRoomerForm)
    sPanel1: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
    mnuOther: TPopupMenu;
    mnuiPrint: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    sbMain: TsStatusBar;
    edFilter: TsEdit;
    cLabFilter: TsLabel;
    btnClear: TsSpeedButton;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    dsCleaningNotes: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_CleaningNotes: TdxMemData;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    m_CleaningNotesID: TIntegerField;
    m_CleaningNotesActive: TBooleanField;
    btnInsert: TsButton;
    btnEdit: TsButton;
    chkActive: TsCheckBox;
    timFilter: TTimer;
    m_CleaningNotesinterval: TIntegerField;
    m_CleaningNotesminimumDays: TIntegerField;
    m_CleaningNotesserviceType: TWideStringField;
    m_CleaningNotesmessage: TWideStringField;
    m_CleaningNotesonceType: TWideStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataactive: TcxGridDBColumn;
    tvDataserviceType: TcxGridDBColumn;
    tvDataonceType: TcxGridDBColumn;
    tvDatainterval: TcxGridDBColumn;
    tvDataminimumDays: TcxGridDBColumn;
    tvDatamessage: TcxGridDBColumn;
    m_CleaningNotesonlyWhenRoomIsDirty: TBooleanField;
    tvDataonlyWhenRoomIsDirty: TcxGridDBColumn;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_CleaningNotesBeforeDelete(DataSet: TDataSet);
    procedure m_CleaningNotesBeforeInsert(DataSet: TDataSet);
    procedure m_CleaningNotesBeforePost(DataSet: TDataSet);
    procedure m_CleaningNotesNewRecord(DataSet: TDataSet);
    procedure tvDataDblClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
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
    procedure tvDataItemPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnInsertClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkActiveClick(Sender: TObject);
    procedure m_CleaningNotesFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure timFilterTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure m_CleaningNotesAfterPost(DataSet: TDataSet);
    procedure tvDataCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure tvDataonceTypeCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure tvDataintervalCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    zFirstTime       : boolean;
    FAllowGridEdit   : boolean;
    zFilterOn        : boolean;

    zSortStr         : string;

    procedure fillHolder;
    Procedure chkFilter;
    procedure applyFilter;
    procedure StopFilter;
    function CopyDatasetToRecCleaningNote:recCleaningNotesHolder;
    procedure SetAllowGridEdit(const Value: boolean);
    procedure SetFilterForDataset(aRSet: TRoomerDataset);
    function ConstructSQL: string;
    procedure SetEditedValuesIn_M_Dataset;
  protected
    Lookup : Boolean;
    zAct: TActTableAction;
    zData: recCleaningNotesHolder;
    /// <summary>
    ///   Add recCleaningNotesHolders to recCleaningNotesHolderslist for each price-period of selected stockitem. <br />
    ///  zData is used to determine requested peroid of use
    /// </summary>
    property AllowGridEdit: boolean read FAllowGridEdit write SetAllowGridEdit;
    procedure LoadData; override;
  end;

function openCleaningNotes(act : TActTableAction; Lookup : Boolean; var theData : recCleaningNotesHolder) : boolean;

implementation

{$R *.dfm}

uses
  prjConst
  , uSqlDefinitions
  , uItemTypes2
  , uMessageList
  , uAppGlobal
  , uDimages
  , uFrmTaxItemLink
  , uBookKeepingCodes
  , uUtils
  , UITypes
  , uDateUtils
  , DateUtils
  , Math
  , uCleaningNotesEdit
  ;

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openCleaningNotes(act : TActTableAction; Lookup : Boolean; var theData : recCleaningNotesHolder) : boolean;
var _frmCleaningNotes : TfrmCleaningNotes;
begin
  result := false;
  _frmCleaningNotes := TfrmCleaningNotes.Create(nil);
  try
    _frmCleaningNotes.zData := theData;
    _frmCleaningNotes.Lookup := Lookup;
    _frmCleaningNotes.zAct := act;
    _frmCleaningNotes.ShowModal;
    if _frmCleaningNotes.modalresult = mrOk then
    begin
      theData := _frmCleaningNotes.zData;
      result := true;
    end
    else
    begin
      initCleaningNoteHolder(theData);
    end;
  finally
    freeandnil(_frmCleaningNotes);
  end;
end;

///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////

function TfrmCleaningNotes.CopyDatasetToRecCleaningNote:recCleaningNotesHolder;
begin
  Result.ID                    := m_CleaningNotesID.AsInteger;
  Result.Active                := m_CleaningNotesActive.AsBoolean;
  Result.onlyWhenRoomIsDirty   := m_CleaningNotesonlyWhenRoomIsDirty.AsBoolean;
  Result.serviceType           := m_CleaningNotesserviceType.AsString;
  Result.onceType              := m_CleaningNotesonceType.asString;
  Result.interval              := m_CleaningNotesinterval.AsInteger;
  Result.minimumDays           := m_CleaningNotesminimumDays.AsInteger;
  Result.smessage              := m_CleaningNotesmessage.AsString;
end;


procedure TfrmCleaningNotes.SetFilterForDataset(aRSet: TRoomerDataset);
var
  lFilterExpr: TStringbuilder;
begin
  lFilterExpr := TStringbuilder.Create;
  try
    if chkActive.Checked then
      lFilterExpr.Append('(active=1) ')
    else
      lFilterExpr.Append('(active=0) ');

    aRSet.Filter := lFilterExpr.ToString;
    aRSet.Filtered := aRSet.Filter <> '';
  finally
    lFilterExpr.Free;
  end;

end;

function TfrmCleaningNotes.ConstructSQL: string;
const
  cSQL = 'select * FROM cleaningnotes';
begin
  Result := cSQL;
end;

Procedure TfrmCleaningNotes.LoadData;
var
  rSet : TRoomerDataSet;
begin
  inherited;

  zFirstTime := true;

  if zSortStr = '' then zSortStr := 'id';

  rSet := CreateNewDataSet;
  rSet_bySQL(rSet, ConstructSQL);
  try
    rSet.Sort := zSortStr;

    SetFilterForDataset(rSet);

    m_CleaningNotes.Close;
    m_CleaningNotes.Open;

    rSet.First;
    if NOT rSet.Eof then
    begin
      m_CleaningNotes.DisableControls;
      try
        m_CleaningNotes.LoadFromDataSet(rSet);
      finally
        m_CleaningNotes.EnableControls;
      end;
    end;
  finally
    rSet.Free;
  end;

end;



procedure TfrmCleaningNotes.fillHolder;
begin
  zData := CopyDatasetToRecCleaningNote;
end;

procedure TfrmCleaningNotes.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;

  RefreshData;

  zFirstTime := false;
end;

procedure TfrmCleaningNotes.chkFilter;
var
  sFilter : string;
  rC1,rc2   : integer;
begin
  sFilter := edFilter.text;
  rc1 := tvData.DataController.RecordCount;
  rc2 := tvData.DataController.FilteredRecordCount;
  zFilterON := rc1 <> rc2;
end;

procedure TfrmCleaningNotes.SetAllowGridEdit(const Value: boolean);
begin
  FAllowGridEdit := Value;

  tvDataID.Options.Editing            := false;
  tvDataactive.Options.Editing        := AllowGridEdit;

  tvDataRecId.Options.Editing         := AllowGridEdit;
  tvDataserviceType.Options.Editing   := AllowGridEdit;
  tvDataonceType.Options.Editing      := AllowGridEdit;
  tvDatainterval.Options.Editing      := AllowGridEdit;
  tvDataminimumDays.Options.Editing   := AllowGridEdit;
  tvDatamessage.Options.Editing       := AllowGridEdit;
end;

procedure TfrmCleaningNotes.StopFilter;
begin
  if tvData.DataController.Filter.AutoDataSetFilter then
  begin
    timFilter.Enabled := False;
    m_CleaningNotes.filtered := False;
    tvData.DataController.Filter.Active := False;
    tvData.DataController.Filter.Changed;
  end else
  begin
    tvData.DataController.Filter.Root.Clear;
    tvData.DataController.Filter.Active := false;
    grData.Invalidate(true);
  end;
end;

procedure TfrmCleaningNotes.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    StopFilter;
  end else
  begin
    applyFilter;
  end;
end;

procedure TfrmCleaningNotes.applyFilter;
var i : Integer;

    procedure RestartTimer;
    begin
      timFilter.Enabled := False;
      timFilter.Interval := 500;
      timFilter.Interval := 30;
      timFilter.Enabled := True;
    end;
begin
  if tvData.DataController.Filter.AutoDataSetFilter then
  begin
    m_CleaningNotes.filtered := False;
    RestartTimer;
  end else
  begin
    tvData.DataController.Filter.Options := [fcoCaseInsensitive];
    tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
    tvData.DataController.Filter.Root.Clear;
    for i := 0 to tvData.ColumnCount - 1 do
      if tvData.Columns[i].DataBinding.ValueType = 'String' then
        tvData.DataController.Filter.Root.AddItem(tvData.Columns[i], foLike, '%'+edFilter.Text+'%', '%'+edFilter.Text+'%');
    tvData.DataController.Filter.Active := True;
  end;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmCleaningNotes.FormCreate(Sender: TObject);
begin
  Lookup := False;
  //**
  zFirstTime  := true;
  zAct        := actNone;
end;

procedure TfrmCleaningNotes.FormShow(Sender: TObject);
begin
  zFirstTime := true;
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  chkActive.Checked := True;

  sbMain.SimpleText := zSortStr;

  AllowGridEdit := False; // (ZAct <> actLookup);
  panBtn.Visible := (Zact = actLookup);
  sbMain.Visible := (Zact = actLookup);
  tvData.OptionsData.Editing := FAllowGridEdit;

  chkFilter;
  zFirstTime := false;

  tvData.DataController.DataModeController.GridMode := (ZAct = actLookup);
  tvData.DataController.Filter.AutoDataSetFilter := tvData.DataController.DataModeController.GridMode;
  tvData.DataController.MultiSelect := true;

  grData.SetFocus;
end;

procedure TfrmCleaningNotes.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmCleaningNotes.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
end;

procedure TfrmCleaningNotes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if m_CleaningNotes.State in [dsInsert, dsEdit] then
      m_CleaningNotes.Cancel
    else
      btnCancel.Click;
  end;
end;

procedure TfrmCleaningNotes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (ZAct = actLookup) and (ActiveControl <> edFilter) then
  begin
    if key = chr(13) then
      btnOk.click
    else if key = chr(27) then
      btnCancel.click;
  end;
end;


////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmCleaningNotes.m_CleaningNotesAfterPost(DataSet: TDataSet);
begin
  if zFirstTime then Exit;

  RoomerMessages.RefreshLists;
  glb.RefreshTablesWhenNeeded;
end;

procedure TfrmCleaningNotes.m_CleaningNotesBeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  s := '';
  s := s+GetTranslatedText('shDeleteItem')+' '+zData.smessage+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if (MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrNo) or not Del_CleaningNote(zData) then
    abort;
end;

procedure TfrmCleaningNotes.m_CleaningNotesBeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('serviceType').Focused := True;
end;

procedure TfrmCleaningNotes.m_CleaningNotesBeforePost(DataSet: TDataSet);
var
 nID : integer;
begin
  if zFirstTime then exit;
  initCleaningNoteHolder(zData);

  zData := CopyDatasetToRecCleaningNote;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_CleaningNote(zData) then
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
    if m_CleaningNotesserviceType.AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shServiceTypeNeeded'));
      tvData.GetColumnByFieldName('serviceType').Focused := True;
      abort;
      exit;
    end;
    if m_CleaningNotesonceType.AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shOnceTypeNeeded'));
      tvData.GetColumnByFieldName('onceType').Focused := True;
      abort;
      exit;
    end;
    if ins_CleaningNote(zData,nID) then
      m_CleaningNotesID.AsInteger := nID
    else
      abort;
  end;
end;



procedure TfrmCleaningNotes.m_CleaningNotesFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  if tvData.DataController.Filter.AutoDataSetFilter AND (edFilter.Text <> '') then
    Accept := pos(Lowercase(edFilter.Text), LowerCase(dataset['Description'])) > 0;
end;

procedure TfrmCleaningNotes.m_CleaningNotesNewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']          := true;
  dataset['serviceType']     := 'INTERVAL';
  dataset['onceType']            := 'CHECK_IN_DAY';
  dataset['interval']        := 3;
  dataset['minimumDays']        := 3;
  dataset['message']      := '';
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmCleaningNotes.tvDataItemPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DisplayValue := TRIM(DisplayValue);

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
	  errortext := GetTranslatedText('shTx_Items2_ItemCodeIsRequired');
    exit;
  end;

  if hdata.itemExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;
end;

procedure TfrmCleaningNotes.tvDataonceTypeCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  with TcxGridDBTableView(Sender).DataController do
    if  AViewInfo.GridRecord.Values[tvDataserviceType.Index] = 'INTERVAL' then
      aCanvas.Font.Color := aCanvas.Brush.Color;
end;

procedure TfrmCleaningNotes.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


procedure TfrmCleaningNotes.tvDataintervalCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  with TcxGridDBTableView(Sender).DataController do
    if AViewInfo.GridRecord.Values[tvDataserviceType.Index] = 'ONCE' then
      if NOT ((AViewInfo.GridRecord.Values[tvDataonceType.Index] = 'XTH_DAY') OR
              (AViewInfo.GridRecord.Values[tvDataonceType.Index] = 'X_DAYS_AFTER_CHECK_OUT')) then
        aCanvas.Font.Color := aCanvas.Brush.Color;
end;

////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmCleaningNotes.timFilterTimer(Sender: TObject);
begin
  timFilter.Enabled := False;
  m_CleaningNotes.filtered := True;
  tvData.DataController.Filter.Refresh;
end;

procedure TfrmCleaningNotes.tvDataCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  btnEdit.Click;
end;

procedure TfrmCleaningNotes.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmCleaningNotes.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmCleaningNotes.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmCleaningNotes.btnCancelClick(Sender: TObject);
begin
  initCleaningNoteHolder(zData);
end;

procedure TfrmCleaningNotes.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmCleaningNotes.btnDeleteClick(Sender: TObject);
begin
  m_CleaningNotes.Delete;
end;

procedure TfrmCleaningNotes.btnEditClick(Sender: TObject);
begin
  fillHolder;
  if openCleaningNotesEdit(zData, false) then
  begin
      m_CleaningNotes.edit;
      SetEditedValuesIn_M_Dataset;
      m_CleaningNotes.Post;
  end;
end;

procedure TfrmCleaningNotes.SetEditedValuesIn_M_Dataset;
begin
  m_CleaningNotes['Active']       := zData.active;
  m_CleaningNotes['onlyWhenRoomIsDirty'] := zData.onlyWhenRoomIsDirty;
  m_CleaningNotes['serviceType']  := zData.serviceType;
  m_CleaningNotes['onceType']     := zData.onceType;
  m_CleaningNotes['interval']     := zData.interval;
  m_CleaningNotes['minimumDays']  := zData.minimumDays;
  m_CleaningNotes['message']      := zData.smessage;
end;


procedure TfrmCleaningNotes.btnInsertClick(Sender: TObject);
begin
  fillHolder;
  if openCleaningNotesEdit(zData, true) then
  begin
      m_CleaningNotes.insert;
      SetEditedValuesIn_M_Dataset;
      m_CleaningNotes.Post;
  end;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmCleaningNotes.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmCleaningNotes.mnuiGridToExcelClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmCleaningNotes.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmCleaningNotes.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmCleaningNotes.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

