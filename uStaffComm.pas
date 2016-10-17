unit uStaffComm;

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
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxMemo, cxDropDownEdit

  ;

type
  TfrmStaffComm = class(TForm)
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
    btnInsert: TsButton;
    btnEdit: TsButton;
    FormStore: TcxPropertiesStore;
    m_date: TDateField;
    m_lastUpdate: TDateTimeField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDatadate: TcxGridDBColumn;
    tvDatauser: TcxGridDBColumn;
    tvDatanotes: TcxGridDBColumn;
    tvDataaction: TcxGridDBColumn;
    tvDatalastChangeBy: TcxGridDBColumn;
    tvDatalastUpdate: TcxGridDBColumn;
    m_notes: TWideMemoField;
    m_action: TWideStringField;
    m_user: TWideStringField;
    m_lastChangedBy: TWideStringField;
    sLabel1: TsLabel;
    lblDate: TsLabel;
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
    procedure btnTaxLinksClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
  private
    { Private declarations }
    rSet : TRoomerDataSet;
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;

    Lookup : Boolean;
    zSortStr         : string;

    ADate : TDateTime;

    Procedure fillGridFromDataset(sGoto : integer);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;

  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recDayNotesHolder;
  end;

function openDayNotes(ADate : TDateTime; act : TActTableAction; Lookup : Boolean; var theData : recDayNotesHolder) : boolean;

var
  frmStaffComm: TfrmStaffComm;

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
  , uStaffCommunication
  , uMain
  , uFrmStaffNote
  , uUtils
  , UITypes
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openDayNotes(ADate : TDateTime; act : TActTableAction; Lookup : Boolean; var theData : recDayNotesHolder) : boolean;
var _frmStaffComm : TfrmStaffComm;
begin
  result := false;
  _frmStaffComm := TfrmStaffComm.Create(nil);
  try
    _frmStaffComm.zData := theData;
    _frmStaffComm.ADate := ADate;
    _frmStaffComm.lblDate.Caption := DateToStr(ADate);
    _frmStaffComm.Caption := 'Notes for ' + DateToStr(ADate);
    _frmStaffComm.Lookup := Lookup;
    _frmStaffComm.zAct := act;
    _frmStaffComm.ShowModal;
    if _frmStaffComm.modalresult = mrOk then
    begin
      theData := _frmStaffComm.zData;
      result := true;
    end
    else
    begin
      theData.ADate := 0;
      theData.Notes := '';
    end;
  finally
    freeandnil(_frmStaffComm);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmStaffComm.fillGridFromDataset(sGoto : integer);
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'id';
  rSet := frmMain.StaffComm.records;
  rSet.Sort := 'Id';
  try
    rSet.First;
    if NOT rSet.Eof then
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
    rSet.Filter := '';
    rSet.Filtered := False;
  end;
end;

procedure TfrmStaffComm.fillHolder;
begin
  zData.ID                    := m_.FieldByName('ID').AsInteger;
  zData.User                  := m_['user'];
  zData.ADate                 := m_['date'];
  zData.Notes                 := m_['notes'];
  zData.AAction               := m_['action'];
  zData.LastChangedBy         := m_['lastChangedBy'];
  zData.LastUpdate            := m_['lastUpdate'];
end;


//    ID              : integer ;
//    Active          : boolean ;
//    Description     : string  ;
//    Item            : string  ;
//    Price           : double  ;
//    Itemtype        : string  ;
//    AccountKey      : string  ;
//    MinibarItem     : boolean ;
//    SystemItem      : boolean ;
//    RoomRentitem    : boolean ;
//    ReservationItem : boolean ;
//    Hide            :boolean  ;
//    Currency        :string   ;


procedure TfrmStaffComm.changeAllowgridEdit;
begin
  tvDataID.Options.Editing              := false;
  tvDatadate.Options.Editing            := false;
  tvDatauser.Options.Editing            := false;
  tvDatanotes.Options.Editing           := zAllowGridEdit;
  tvDatalastChangeBy.Options.Editing    := false;
  tvDatalastUpdate.Options.Editing      := zAllowGridEdit;
  tvDataaction.Options.Editing          := zAllowGridEdit;
end;


procedure TfrmStaffComm.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.id);
  zFirstTime := false;
end;

procedure TfrmStaffComm.chkFilter;
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


procedure TfrmStaffComm.edFilterChange(Sender: TObject);
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

procedure TfrmStaffComm.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDatanotes,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatauser,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatalastChangeBy,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmStaffComm.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  Lookup := False;
  //**
  zFirstTime  := true;
  zAct        := actNone;
  //sButton1.Visible := True;
end;

procedure TfrmStaffComm.FormShow(Sender: TObject);
begin
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.id);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
//    mnuiAllowGridEdit.Checked := False;
    panBtn.Visible := true;
  end else
  begin
//    mnuiAllowGridEdit.Checked := true;
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;

end;

procedure TfrmStaffComm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  glb.EnableOrDisableTableRefresh('items', True);
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmStaffComm.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmStaffComm.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;

  s := '';
  s := s+GetTranslatedText('shDeleteSelectedLine')+#10#10+zData.Notes+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    d.roomerMainDataSet.DoCommand('DELETE FROM daynotes WHERE ID=' + inttostr(dataSet['ID']));
  end else
  begin
    abort
  end;
end;

procedure TfrmStaffComm.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('date').Focused := True;
end;


procedure TfrmStaffComm.m_BeforePost(DataSet: TDataSet);
var
 nID : integer;
begin
  if zFirstTime then exit;
  initDayNotes(zData);
  zData.ID                    := dataset.FieldByName('ID').AsInteger;
  zData.User                  := dataset['user'];
  zData.ADate                 := dataset['date'];
  zData.Notes                 := dataset['notes'];
  zData.AAction               := dataset['action'];
  zData.LastChangedBy         := dataset['lastChangedBy'];
  zData.LastUpdate            := dataset['lastUpdate'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if NOT UPD_DayNotes(zData) then
    begin
      abort;
      exit;
    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if INS_DayNotes(zData,nID) then
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



procedure TfrmStaffComm.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;

  dataset.FieldByName('ID').AsInteger;
  dataset['user']            := d.roomerMainDataSet.username;
  dataset['date']            := ADate;
  dataset['notes']           := '';
  dataset['action']          := 'NO_ACTION_NEEDED';
  dataset['lastChangedBy']   := d.roomerMainDataSet.username;
  dataset['lastUpdate']      := now;

end;

procedure TfrmStaffComm.btnTaxLinksClick(Sender: TObject);
begin
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmStaffComm.tvDataDescriptionPropertiesValidate(Sender: TObject;
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
	errortext := GetTranslatedText('shTx_StaffComm_DescriptionIsRequired');
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

procedure TfrmStaffComm.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
    btnOK.Click
  else
    btnEdit.Click;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmStaffComm.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmStaffComm.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmStaffComm.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmStaffComm.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmStaffComm.btnCancelClick(Sender: TObject);
begin
  initDayNotes(zData);
end;

procedure TfrmStaffComm.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmStaffComm.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmStaffComm.btnEditClick(Sender: TObject);
begin
  initDayNotes(zData);
  zData.ID                    := m_.FieldByName('ID').AsInteger;
  zData.User                  := m_['user'];
  zData.ADate                 := m_['date'];
  zData.Notes                 := m_['notes'];
  zData.AAction               := m_['action'];
  zData.LastChangedBy         := m_['lastChangedBy'];
  zData.LastUpdate            := m_['lastUpdate'];

  if EditDayNote(zData.ADate, zData.User, zData.LastUpdate, zData.AAction, zData.Notes) then
  begin
    m_.Edit;
    m_['notes'] := zData.Notes;
    m_['action'] := zData.AAction;
    m_.Post;
  end;

//  mnuiAllowGridEdit.Checked := true;
//  zAllowGridEdit := mnuiAllowGridEdit.Checked;
//  changeAllowGridEdit;
//  grData.SetFocus;
//  tvData.GetColumnByFieldName('Description').Focused := True;
//  showmessage(GetTranslatedText('shTx_StaffComm_EditInGrid'));
end;

procedure TfrmStaffComm.btnInsertClick(Sender: TObject);
begin
//  mnuiAllowGridEdit.Checked := true;
//  zAllowGridEdit := mnuiAllowGridEdit.Checked;
//  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
//  tvData.GetColumnByFieldName('Item').Focused := True;
  m_['user'] := d.roomerMainDataSet.username;
  m_['date'] := ADate;
  m_['notes'] := '';
  m_['action'] := 'NO_ACTION_NEEDED';
  m_['lastChangedBy'] := d.roomerMainDataSet.username;
  m_['lastUpdate'] := Now;

  initDayNotes(zData);
  zData.ID                    := 0;
  zData.User                  := m_['user'];
  zData.ADate                 := m_['date'];
  zData.Notes                 := m_['notes'];
  zData.AAction               := m_['action'];
  zData.LastChangedBy         := m_['lastChangedBy'];
  zData.LastUpdate            := m_['lastUpdate'];

  if EditDayNote(zData.ADate, zData.User, zData.LastUpdate, zData.AAction, zData.Notes) then
  begin
    m_['notes'] := zData.Notes;
    m_['action'] := zData.AAction;
    m_.Post;
  end else
    m_.Cancel;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmStaffComm.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmStaffComm.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmStaffComm.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmStaffComm.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmStaffComm.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmStaffComm.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

