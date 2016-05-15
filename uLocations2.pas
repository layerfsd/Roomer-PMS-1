unit uLocations2;

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
  , uDImages

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
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxButtonEdit, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, dxmdaset,
  dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

 ;

type
  TfrmLocations = class(TForm)
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
    m_ID: TIntegerField;
    m_Active: TBooleanField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    m_Description: TWideStringField;
    tvDataDescription: TcxGridDBColumn;
    m_Location: TWideStringField;
    tvDataLocation: TcxGridDBColumn;
    btnEdit: TsButton;
    btnInsert: TsButton;
    m_ChannelManagerName: TWideStringField;
    tvDataChannelManagerName: TcxGridDBColumn;
    m_channelManager: TIntegerField;
    FormStore: TcxPropertiesStore;
    m_Accountdepartment: TStringField;
    tvDataAccountdepartment: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataDescriptionPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
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
    procedure btnInsertClick(Sender: TObject);
    procedure tvDataChannelManagerNamePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    Procedure fillGridFromDataset(iGoto : integer);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    function getPrevCode : string;
    Procedure chkFilter;
    procedure applyFilter;


  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recLocationHolder;
  end;

function openLocation(act : TActTableAction; var theData : recLocationHolder) : boolean;

var
  frmLocations: TfrmLocations;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uChannelManager
  , uUtils
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openLocation(act : TActTableAction; var theData : recLocationHolder) : boolean;
begin
  result := false;
  frmLocations := TfrmLocations.Create(frmLocations);
  try
    frmLocations.zData := theData;
    frmLocations.zAct := act;
    frmLocations.ShowModal;
    if frmLocations.modalresult = mrOk then
    begin
      theData := frmLocations.zData;
      result := true;
    end
    else
    begin
      initLocationHolder(theData);
    end;
  finally
    freeandnil(frmLocations);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////

Procedure TfrmLocations.fillGridFromDataset(iGoto : integer);
var
  s    : string;
  rSet : TRoomerDataSet;
  i : integer;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'ID';
  rSet := CreateNewDataSet;
  try
    s := format(select_Locations, [zSortStr]);
    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      m_.First;
      rSet.first;
      while not rSet.eof do
      begin
        m_.Edit;
        m_.FieldByName('AccountDepartment').AsString :=  rSet.FieldByName('AccountDepartment').AsString;
        m_.Post;
        m_.Next;
        rSet.Next;
      end;
      m_.first;
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

procedure TfrmLocations.fillHolder;
begin
  initLocationHolder(zData);
  zData.ID           := m_.FieldByName('ID').AsInteger;
  zData.Active       := m_['Active'];
  zData.Location     := m_['Location'];
  zData.Description  := m_['Description'];
  zData.channelManager  := m_['channelManager'];
  zData.channelManagerName  := m_['channelManagerName'];
  zData.AccountDepartment  := m_.FieldByName('AccountDepartment').asstring;
end;



procedure TfrmLocations.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive.Options.Editing         := true;
    tvDataLocation.Options.Editing       := true;
    tvDataDescription.Options.Editing    := true;
  end else
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive.Options.Editing         := false;
    tvDataLocation.Options.Editing       := false;
    tvDataDescription.Options.Editing    := false;
  end;
end;


procedure TfrmLocations.chkFilter;
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


procedure TfrmLocations.edFilterChange(Sender: TObject);
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

procedure TfrmLocations.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmLocations.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmLocations.FormDestroy(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('locations', True);
end;

procedure TfrmLocations.FormShow(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('locations', False);
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.ID);
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

procedure TfrmLocations.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fillHolder;
  glb.EnableOrDisableTableRefresh('locations', True);
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmLocations.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmLocations.FormKeyPress(Sender: TObject; var Key: Char);
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
function TfrmLocations.getPrevCode: string;
begin
end;

procedure TfrmLocations.m_BeforeDelete(DataSet: TDataSet);
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
  s := s+GetTranslatedText('shDeleteLocation')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_location(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmLocations.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Location').Focused := True;
end;


procedure TfrmLocations.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;

  initLocationHolder(zData);
  zData.ID                := dataset.FieldByName('ID').AsInteger;
  zData.Active       := dataset['Active'];
  zData.Location     := dataset['Location'];
  zData.Description  := dataset['Description'];
  zData.AccountDepartment  := dataset['AccountDepartment'];
  zData.channelManager  := dataset['channelManager'];
  zData.channelManagerName  := dataset['channelManagerName'];


  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_Location(zData) then
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
    if dataset.FieldByName('Location').AsString = ''  then
    begin
    //  showmessage('Location is requierd - set value or use [ESC] to cancel ');
	    showmessage(GetTranslatedText('shTx_Locations2_LocationRequired'));
      tvData.GetColumnByFieldName('Location').Focused := True;
      abort;
      exit;
    end;
    if ins_Location(zData, nID) then
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



procedure TfrmLocations.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']             := true;
  dataset['Location']           := '';
  dataset['Description']        := '';
  dataset['AccountDepartment']  := '';
  dataset['channelManager']     := 0;
  dataset['channelManagerName'] := '';

end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmLocations.tvDataDescriptionPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Description').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
   // errortext := 'Description '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_Locations2_DescriptionIsRequired');
    exit;
  end;

  if hdata.RoomrateDescriptionExist(displayValue) then
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

procedure TfrmLocations.tvDataFocusedRecordChanged(
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


procedure TfrmLocations.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


//procedure TfrmLocations2.tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
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

procedure TfrmLocations.tvDataChannelManagerNamePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recChannelManagerHolder;
begin
  fillholder;
  theData.Id := zData.channelManager;
  ChannelManager(actlookup,theData);

  if theData.id > 0 then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['channelManager']   := theData.id;
    m_['channelManagerName']   := theData.Description;
    m_.Post;
  end else
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['channelManager']   := theData.id;
    m_['channelManagerName']   := '';
    m_.Post;
  end;
end;

procedure TfrmLocations.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmLocations.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmLocations.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmLocations.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmLocations.btnCancelClick(Sender: TObject);
begin
  initLocationHolder(zData);
end;

procedure TfrmLocations.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmLocations.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmLocations.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
  //showmessage('Edit in grid');
   showmessage(GetTranslatedText('shTx_Locations2_EditInGrid'));
end;

procedure TfrmLocations.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('Location').Focused := True;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmLocations.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmLocations.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmLocations.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmLocations.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmLocations.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmLocations.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

