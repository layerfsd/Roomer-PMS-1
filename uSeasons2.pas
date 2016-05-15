unit uSeasons2;
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

  , uAppGlobal
  , _glob
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

  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCalendar, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, dxmdaset,
  dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

  ;

type
  TfrmSeasons2 = class(TForm)
    sPanel1: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
    mnuOther: TPopupMenu;
    mnuiPrint: TMenuItem;
    mnuiAllowGridEdit: TMenuItem;
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
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    mPriceCode_: TdxMemData;
    mPriceCode_ID: TIntegerField;
    mPriceCode_pcCode: TWideStringField;
    mPriceCode_pcDescription: TWideStringField;
    mPriceCode_pcRack: TBooleanField;
    mPriceCodeDS_: TDataSource;
    mPriceCode_Active: TBooleanField;
    m_ID: TIntegerField;
    m_Active: TBooleanField;
    m_seStartDate: TDateTimeField;
    m_seEndDate: TDateTimeField;
    m_seDescription: TWideStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    tvDataseStartDate: TcxGridDBColumn;
    tvDataseEndDate: TcxGridDBColumn;
    tvDataseDescription: TcxGridDBColumn;
    btnInsert: TsButton;
    btnEdit: TsButton;
    FormStore: TcxPropertiesStore;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataDblClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnOtherClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataseDescriptionPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnInsertClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    function getPrevCode : string;
    Procedure chkFilter;
    procedure applyFilter;


  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recSeasonHolder;
  end;

function openSeasons(act : TActTableAction; var theData : recSeasonHolder) : boolean;
//function openRoomTypeGroups(act : TActTableAction; var theData : recRoomTypeGroupHolder) : boolean;
//function getRoomTypeGroup(ed : TAdvEdit; lab : TLabel) : boolean;
//function payGroupValidate(ed : TAdvEdit; lab: TLabel) : boolean;

var
  frmSeasons2: TfrmSeasons2;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uCurrencies
  , uDImages
  , uUtils
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openSeasons(act : TActTableAction; var theData : recSeasonHolder) : boolean;
begin
  result := false;
  frmSeasons2 := TfrmSeasons2.Create(frmSeasons2);
  try
    frmSeasons2.zData := theData;
    frmSeasons2.zAct := act;
    frmSeasons2.ShowModal;
    if frmSeasons2.modalresult = mrOk then
    begin
      theData := frmSeasons2.zData;
      result := true;
    end
    else
    begin
      initSeasonHolder(theData);
    end;
  finally
    freeandnil(frmSeasons2);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmSeasons2.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'seStartDate';
  rSet := CreateNewDataSet;
  try
    s := format(select_seasons, [zSortStr]);
    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      m_.First;
    end;
  finally
    freeandnil(rSet);
  end;
end;


procedure TfrmSeasons2.fillHolder;
begin
  initSeasonHolder(zData);
  zData.ID             := m_.FieldByName('ID').AsInteger;
  zData.Active         := m_['Active'];
  zData.seDescription  := m_['seDescription'];
  zData.seStartDate    := m_['seStartDate'];
  zData.seEndDate      := m_['seEndDate'];
end;



procedure TfrmSeasons2.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive.Options.Editing         := true;
    tvDataseDescription.Options.Editing  := true;
    tvDataseStartDate.Options.Editing    := true;
    tvDataseEndDate.Options.Editing      := true;
  end else
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive.Options.Editing         := false;
    tvDataseDescription.Options.Editing  := false;
    tvDataseStartDate.Options.Editing    := false;
    tvDataseEndDate.Options.Editing      := false;
  end;
end;


procedure TfrmSeasons2.chkFilter;
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


procedure TfrmSeasons2.edFilterChange(Sender: TObject);
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

procedure TfrmSeasons2.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataseDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmSeasons2.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmSeasons2.FormShow(Sender: TObject);
begin
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.seDescription);
  zFirstTime := true;
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

procedure TfrmSeasons2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fillHolder;
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmSeasons2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmSeasons2.FormKeyPress(Sender: TObject; var Key: Char);
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


////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////
function TfrmSeasons2.getPrevCode: string;
begin
end;

procedure TfrmSeasons2.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
(*
  if hdata.payTypeExistsInOther(zData.PayType) then
  begin
    Showmessage('payType'+' ' + zData.Description + ' '+GetTranslatedText('shExistsInRelatedData')+' ' + chr(10) + GetTranslatedText('shCanNotDelete')+' ');
    Abort;
    exit;
  end;
*)

  s := '';
  s := s+GetTranslatedText('shDeleteSeason')+' '+zData.seDescription+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_Season(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmSeasons2.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('seDescription').Focused := True;
end;


procedure TfrmSeasons2.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;

  initSeasonHolder(zData);
  zData.ID             := dataset.FieldByName('ID').AsInteger;
  zData.Active         := dataset['Active'];
  zData.seDescription  := dataset['seDescription'];
  zData.seStartDate    := dataset['seStartDate'];
  zData.seEndDate      := dataset['seEndDate'];


  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_season(zData) then
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
    if dataset.FieldByName('seDescription').AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shTx_Seasons2_DescriptionRequired'));
      tvData.GetColumnByFieldName('seDescription').Focused := True;
      abort;
      exit;
    end;
    if ins_season(zData,nID) then
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



procedure TfrmSeasons2.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']          := true;
  dataset['seDescription']   := '';
  dataset['seStartDate']     := date;
  dataset['seEndDate']       := date;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmSeasons2.tvDataFocusedRecordChanged(
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

procedure TfrmSeasons2.tvDataseDescriptionPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('seDescription').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
   // errortext := 'Description '+' - '+'is required - Use ESC to cancel';
	errortext := GetTranslatedText('shTx_Seasons2_DescriptionIsRequired');
    exit;
  end;

  if hdata.seasonDescriptionExist(displayValue) then
  begin
    error := true;
    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;
//
  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.payTypeExistsInOther(currValue) then
    begin
      error := true;
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;

procedure TfrmSeasons2.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


//procedure TfrmRoomTypes2.tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
//var
//  theData : recCurrencyHolder;
//begin
////  fillholder;
////  theData.Currency := zData.Currency;
////  theData.ID := zData.CurrencyID;
////
////
////  currencies(actlookup,theData);
////
////  if theData.Currency <> '' then
////  begin
////    m_.Edit;
////    m_['currency']   := theData.Currency;
////    m_['currencyID'] := theData.ID;
////    m_.Post;
////  end;
//
//end;

procedure TfrmSeasons2.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmSeasons2.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmSeasons2.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmSeasons2.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmSeasons2.btnCancelClick(Sender: TObject);
begin
  initSeasonHolder(zData);
end;

procedure TfrmSeasons2.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmSeasons2.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmSeasons2.btnEditClick(Sender: TObject);
begin
  //**
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('seDescription').Focused := True;
  showmessage(GetTranslatedText('shTx_Seasons2_EditInGrid'));
end;

procedure TfrmSeasons2.btnInsertClick(Sender: TObject);
begin
  //**
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('seDescription').Focused := True;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmSeasons2.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmSeasons2.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmSeasons2.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmSeasons2.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmSeasons2.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmSeasons2.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

