unit uPhoneRates;

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
  TfrmPhoneRates = class(TForm)
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
    m_Description: TWideStringField;
    sLabel1: TsLabel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnClear: TsSpeedButton;
    edFilter: TsEdit;
    chkActive: TsCheckBox;
    m_ID: TIntegerField;
    FormStore: TcxPropertiesStore;
    m_Identification: TWideStringField;
    m_minimumCost: TFloatField;
    m_minuteRate: TFloatField;
    tvDataRecId: TcxGridDBColumn;
    tvDataIdentification: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataminuteRate: TcxGridDBColumn;
    tvDataminimumCost: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
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
    procedure tvDataPhoneRatePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    zFirstTime       : boolean;

    zAllowGridEdit   : boolean;
    zFilterOn          : boolean;
    zSortStr           : string;

    Procedure fillGridFromDataset(sGoto : Integer);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;
  public
    { Public declarations }
    zAct               : TActTableAction;
    zData              : recPhoneRateHolder;
  end;

function PhoneRate(act : TActTableAction; var theData : recPhoneRateHolder) : boolean;

var
  frmPhoneRates: TfrmPhoneRates;

implementation

uses
   uD
   ,uSqlDefinitions
   , uDImages
  ;

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function PhoneRate(act : TActTableAction; var theData : recPhoneRateHolder) : boolean;
begin
  result := false;
  frmPhoneRates := TfrmPhoneRates.Create(frmPhoneRates);
  try
    frmPhoneRates.zData := theData;
    frmPhoneRates.zAct := act;
    frmPhoneRates.ShowModal;
    if frmPhoneRates.modalresult = mrOk then
    begin
      theData := frmPhoneRates.zData;
      result := true;
    end
    else
    begin
      initPhoneRateHolder(theData);
    end;
  finally
    freeandnil(frmPhoneRates);
  end;
end;

///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////

Procedure TfrmPhoneRates.fillGridFromDataset(sGoto : Integer);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
begin
  active := chkActive.Checked;
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'Identification ';

  rSet := CreateNewDataSet;
  try
    s := format(select_PhoneRates_fillGridFromDataset , [zSortStr]);
    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if sGoto = 0 then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('id',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure  TfrmPhoneRates.fillHolder;
begin
  initPhoneRateHolder(zData);
  zData.Identification  := m_.fieldbyname('Identification').asstring;
  zData.Description     := m_.fieldbyname('Description').asstring;
  zData.minimumCost     := m_['minimumCost'];
  zData.minuteRate      := m_['minuteRate'];
  zData.Id              := m_.fieldbyname('ID').asInteger;
end;

procedure TfrmPhoneRates.changeAllowgridEdit;
begin
  tvDataIdentification.Options.Editing := zAllowGridEdit;
  tvDataDescription.Options.Editing    := zAllowGridEdit;
  tvDataminimumCost.Options.Editing    := zAllowGridEdit;
  tvDataminuteRate.Options.Editing     := zAllowGridEdit;
end;

procedure TfrmPhoneRates.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.id);
  zFirstTime := false;
end;

Procedure TfrmPhoneRates.ChkFilter;
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

procedure TfrmPhoneRates.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fillHolder;
end;

procedure TfrmPhoneRates.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  zFirstTime  := true;
  zAct        := actNone;
end;

procedure TfrmPhoneRates.FormShow(Sender: TObject);
begin
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.id);
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

procedure TfrmPhoneRates.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TfrmPhoneRates.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmPhoneRates.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  //**
  fillHolder;

  s := '';
  s := s+GetTranslatedText('shDeletePhoneRate')+' '+zData.Identification+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    screen.Cursor := crHourGlass;
    try
      if not Del_PhoneRate(zData) then
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


procedure TfrmPhoneRates.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Identification').Focused := True;
end;

procedure TfrmPhoneRates.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;
  nId := 0;

  initPhoneRateHolder(zData);
  if tvData.DataController.DataSource.State <> dsInsert then
    zData.Id             := dataset['id'];
  zData.Identification := dataset['Identification'];
  zData.Description    := dataset['Description'];
  zData.minuteRate     := dataset['minuteRate'];
  zData.minimumCost    := dataset['minimumCost'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_PhoneRate(zData) then
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
    if dataset.FieldByName('Identification').AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shTx_PhoneRates_PhoneRateRequired'));
      tvData.GetColumnByFieldName('Identification').Focused := True;
      abort;
      exit;
    end;

    if ins_PhoneRate(zData,nID) then
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


procedure TfrmPhoneRates.m_NewRecord(DataSet: TDataSet);
begin
  dataset['Identification'] := '';
  dataset['Description'] := '';
  dataset['minimumCost'] := true;
  dataset['minuteRate'] := False;
end;


////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmPhoneRates.tvDataPhoneRatePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Identification').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
  //  errortext := 'PhoneRate code '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_PhoneRates_PhoneRateCodeIsRequired');
    exit;
  end;
end;


procedure TfrmPhoneRates.tvDataDataControllerSortingChanged(Sender: TObject);
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



procedure TfrmPhoneRates.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;

////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmPhoneRates.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmPhoneRates.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataIdentification,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

procedure TfrmPhoneRates.edFilterChange(Sender: TObject);
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

procedure TfrmPhoneRates.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;


procedure TfrmPhoneRates.btnCancelClick(Sender: TObject);
begin
  initPhoneRateHolder(zData);
end;

procedure TfrmPhoneRates.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmPhoneRates.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPhoneRates.btnOtherClick(Sender: TObject);
begin
  //
end;

procedure TfrmPhoneRates.btnDeleteClick(Sender: TObject);
begin
   m_.Delete;
end;


procedure TfrmPhoneRates.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Identification').Focused := True;
  showmessage(GetTranslatedText('shTx_PayGroups_EditInGrid'));
end;

procedure TfrmPhoneRates.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('Identification').Focused := True;
end;

////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmPhoneRates.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;

  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmPhoneRates.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmPhoneRates.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmPhoneRates.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmPhoneRates.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmPhoneRates.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;


end.
