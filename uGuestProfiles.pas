unit uGuestProfiles;

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
  TfrmGuestProfiles = class(TForm)
    sPanel1: TsPanel;
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
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    m_ID: TIntegerField;
    FormStore: TcxPropertiesStore;
    chkActive: TsCheckBox;
    pnlHolder: TsPanel;
    m_Title: TStringField;
    m_Firstname: TStringField;
    m_Lastname: TStringField;
    m_CustomerCode: TStringField;
    m_CompanyName: TStringField;
    m_City: TStringField;
    m_Country: TStringField;
    m_MaleFemale: TStringField;
    m_Nationality: TStringField;
    m_DateOfBirth: TDateField;
    m_PassportNumber: TStringField;
    m_PassportExpiry: TDateField;
    m_SpouseName: TStringField;
    m_SpouseBirthdate: TDateField;
    m_CarLicensePlate: TStringField;
    m_ContactPerson: TStringField;
    m_Profession: TStringField;
    m_Address1: TStringField;
    m_Address2: TStringField;
    m_Zip: TStringField;
    m_TelLandLine: TStringField;
    m_TelMobile: TStringField;
    m_Email: TStringField;
    m_Website: TStringField;
    m_Twitter: TStringField;
    m_LinkedIn: TStringField;
    m_State: TStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataMaleFemale: TcxGridDBColumn;
    tvDataTitle: TcxGridDBColumn;
    tvDataFirstname: TcxGridDBColumn;
    tvDataLastname: TcxGridDBColumn;
    tvDataProfession: TcxGridDBColumn;
    tvDataNationality: TcxGridDBColumn;
    tvDataDateOfBirth: TcxGridDBColumn;
    tvDataPassportNumber: TcxGridDBColumn;
    tvDataPassportExpiry: TcxGridDBColumn;
    tvDataAddress1: TcxGridDBColumn;
    tvDataAddress2: TcxGridDBColumn;
    tvDataZip: TcxGridDBColumn;
    tvDataCity: TcxGridDBColumn;
    tvDataState: TcxGridDBColumn;
    tvDataCountry: TcxGridDBColumn;
    tvDataTelLandLine: TcxGridDBColumn;
    tvDataTelMobile: TcxGridDBColumn;
    tvDataEmail: TcxGridDBColumn;
    tvDataWebsite: TcxGridDBColumn;
    tvDataTwitter: TcxGridDBColumn;
    tvDataLinkedIn: TcxGridDBColumn;
    tvDataSpouseName: TcxGridDBColumn;
    tvDataContactPerson: TcxGridDBColumn;
    tvDataSpouseBirthdate: TcxGridDBColumn;
    tvDataCustomerCode: TcxGridDBColumn;
    tvDataCompanyName: TcxGridDBColumn;
    tvDataCarLicensePlate: TcxGridDBColumn;
    m_SocialSecurityNumber: TStringField;
    m_FacebookLink: TStringField;
    m_TripadvisorAccount: TStringField;
    m_CompVATNumber: TStringField;
    m_CompFax: TStringField;
    tvDataSocialSecurityNumber: TcxGridDBColumn;
    tvDataFacebookLink: TcxGridDBColumn;
    tvDataTripadvisorAccount: TcxGridDBColumn;
    tvDataCompVATNumber: TcxGridDBColumn;
    tvDataCompFax: TcxGridDBColumn;
    tvData_SELECTED_ROW_: TcxGridDBColumn;
    m__SELECTED_ROW_: TBooleanField;
    sPanel2: TsPanel;
    btnOther: TsButton;
    btnMerge: TsButton;
    btnDelete: TsButton;
    btnEdit: TsButton;
    btnInsert: TsButton;
    N1: TMenuItem;
    mnuOnlyDuplicates: TMenuItem;
    mnuOnlyDuplicateTelNums: TMenuItem;
    mnuOnlyDuplicateEmails: TMenuItem;
    timFilter: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure tvDataDblClick(Sender: TObject);
    procedure tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnOtherClick(Sender: TObject);
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
    procedure tvDataDetailedDescriptionPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure m_AfterScroll(DataSet: TDataSet);
    procedure tvData_SELECTED_ROW_PropertiesEditValueChanged(Sender: TObject);
    procedure btnMergeClick(Sender: TObject);
    procedure mnuOnlyDuplicatesClick(Sender: TObject);
    procedure mnuOnlyDuplicateTelNumsClick(Sender: TObject);
    procedure mnuOnlyDuplicateEmailsClick(Sender: TObject);
    procedure timFilterTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    Procedure fillGridFromDataset(iGoto : Integer);
    Procedure chkFilter;
    procedure applyFilter;
    procedure NoGridEdit;
    function NumItemsSelected: Integer;
    procedure SelectNoItems;
    procedure LocateSelectedId(var id1, id2: Integer);
    procedure StartFilterTimer;
    procedure StopFilterTimer;


  public
    { Public declarations }
    zAct   : TActTableAction;
    GlobalRecordSet : TRoomerDataSet;
    iGoto : Integer;
    SeletcedPerson : Integer;
  end;

function GuestProfiles(act : TActTableAction; iGoto : Integer = -1) : integer;

var
  frmGuestProfiles: TfrmGuestProfiles;

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
  , uFrmMergePortfolios
  , UITYpes
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function GuestProfiles(act : TActTableAction; iGoto : Integer = -1) : integer;
var _frmGuestProfiles: TfrmGuestProfiles;
begin
  _frmGuestProfiles := TfrmGuestProfiles.Create(nil);
  try
    _frmGuestProfiles.zAct := act;
    _frmGuestProfiles.iGoto := iGoto;
    _frmGuestProfiles.ShowModal;

      if _frmGuestProfiles.modalresult = mrOk then
        result := _frmGuestProfiles.SeletcedPerson
      else
        result := -1;
  finally
    freeandnil(_frmGuestProfiles);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmGuestProfiles.fillGridFromDataset(iGoto : Integer);
var
  s    : string;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'ID';
  if Assigned(GlobalRecordSet) then
    FreeAndNil(GlobalRecordSet);
  GlobalRecordSet := CreateNewDataSet;

  if mnuOnlyDuplicates.Checked then
    s := 'SELECT pf.* FROM personprofiles pf ' +
         'WHERE (SELECT COUNT(p.id) FROM personprofiles p WHERE p.Firstname=pf.Firstname AND p.Lastname=pf.Lastname) > 1 ' +
         'ORDER BY pf.Firstname, pf.Lastname '
  else
  if mnuOnlyDuplicateTelNums.Checked then
    s := 'SELECT pf.* FROM personprofiles pf ' +
         'WHERE (SELECT COUNT(p.id) FROM personprofiles p WHERE CONCAT(p.TelMobile, p.TelLandline)!='''' AND (p.TelMobile=pf.TelMobile OR p.TelLandLine=pf.TelLandLine)) > 1 ' +
         'ORDER BY pf.TelMobile, pf.TelLandline '
  else
  if mnuOnlyDuplicateEmails.Checked then
    s := 'SELECT pf.* FROM personprofiles pf ' +
         'WHERE (SELECT COUNT(p.id) FROM personprofiles p WHERE p.Email!='''' AND p.Email=pf.Email) > 1 ' +
         'ORDER BY pf.Email '
  else
    s := 'SELECT pf.* FROM personprofiles pf';
  if rSet_bySQL(GlobalRecordSet,s) then
  begin
    if m_.active then m_.Close;
    m_.LoadFromDataSet(GlobalRecordSet);
    m_.Open;
    if iGoto = -1 then
    begin
      m_.First;
      SelectNoItems;
    end else
    begin
      try
        m_.Locate('ID',iGoto,[]);
      except
      end;
    end;
  end;
end;

procedure TfrmGuestProfiles.chkFilter;
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


procedure TfrmGuestProfiles.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    tvData.DataController.Filter.Root.Clear;
    tvData.DataController.Filter.Active := false;
    StopFilterTimer;
  end else
    StartFilterTimer;
end;

procedure TfrmGuestProfiles.StartFilterTimer;
begin
  timFilter.Enabled := False;
  timFilter.Interval := 1000;
  timFilter.Interval := 750;
  timFilter.Enabled := True;
end;

procedure TfrmGuestProfiles.StopFilterTimer;
begin
  timFilter.Enabled := False;
end;

procedure TfrmGuestProfiles.applyFilter;
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

procedure TfrmGuestProfiles.timFilterTimer(Sender: TObject);
begin
  applyFilter;
  StopFilterTimer;
end;

procedure TfrmGuestProfiles.NoGridEdit;
var i : Integer;
begin
  tvData_SELECTED_ROW_.Options.Editing := True;
  tvData.Columns[0].Options.Editing := True;
  for i := 1 to tvData.ColumnCount - 1 do
    tvData.Columns[i].Options.Editing := False;
end;

/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmGuestProfiles.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
  GlobalRecordSet := nil;
end;

procedure TfrmGuestProfiles.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;

  update;
  freeandnil(GlobalRecordSet);
  glb.RefreshTableByName('personprofiles');
end;

procedure TfrmGuestProfiles.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;
end;

procedure TfrmGuestProfiles.FormKeyPress(Sender: TObject; var Key: Char);
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


procedure TfrmGuestProfiles.FormShow(Sender: TObject);
begin
  fillGridFromDataset(iGoto);
  NoGridEdit;
  btnMerge.Enabled := False;
end;

////////////////////////////////////////////////////////////////////////////////////////
// memory table

procedure TfrmGuestProfiles.m_AfterScroll(DataSet: TDataSet);
begin
  if NOT m_.Eof then
    SeletcedPerson := m_['ID'];
end;

procedure TfrmGuestProfiles.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin

  s := '';
  s := s+GetTranslatedText('shDeletePerson')+' '+DataSet['Lastname'] + ',' + DataSet['Firstname']+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    hData.cmd_bySQL('DELETE FROM personprofiles WHERE ID=' + inttostr(Dataset['ID']))
  else
    abort
end;

procedure TfrmGuestProfiles.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('code').Focused := True;
end;



////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmGuestProfiles.tvDataFocusedRecordChanged(
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

procedure TfrmGuestProfiles.SelectNoItems;
var id : Integer;
begin
  if m_.Eof then Exit;

  id := m_['id'];
  m_.First;
  m_.DisableControls;
  try
    while NOT m_.Eof do
    begin
      m_.Edit;
      m_['_SELECTED_ROW_'] := False;
      m_.Post;
      m_.Next;
    end;
  finally
    m_.EnableControls;
  end;
  m_.Locate('ID',id,[]);
end;

function TfrmGuestProfiles.NumItemsSelected : Integer;
var id : Integer;
begin

  id := m_['id'];
  result := 0;
  m_.DisableControls;
  try
    m_.First;
    while NOT m_.Eof do
    begin
      if m_['_SELECTED_ROW_'] then
        inc(result);
      m_.Next;
    end;
  finally
    m_.EnableControls;
  end;
  m_.Locate('id',id,[]);
end;

procedure TfrmGuestProfiles.LocateSelectedId(var id1, id2 : Integer);
var id, iFnd : Integer;
begin
  iFnd := 0;
  id := m_['id'];
  m_.First;
  m_.DisableControls;
  try
    while NOT m_.Eof do
    begin
      if m_['_SELECTED_ROW_'] then
      begin
        if iFnd = 0 then
          id1 := m_['id']
        else
          id2 := m_['id'];
        inc(iFnd);
        if iFnd = 2 then
          Break;
      end;
      m_.Next;
    end;
  finally
    m_.EnableControls;
  end;
  m_.Locate('ID',id,[]);
end;

procedure TfrmGuestProfiles.tvData_SELECTED_ROW_PropertiesEditValueChanged(
  Sender: TObject);
begin
    btnMerge.Enabled := True;
end;

procedure TfrmGuestProfiles.tvDataDblClick(Sender: TObject);
begin
  if not zAllowGridEdit then
  begin
    if ZAct = actLookup then
    begin
      btnOK.Click
    end else
    begin
      if glb.AccessAllowed(BtnEdit.HelpContext) then
      begin
        btnEdit.Click;
      end;
    end;
  end;

end;


procedure TfrmGuestProfiles.tvDataDetailedDescriptionPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
end;

////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


procedure TfrmGuestProfiles.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmGuestProfiles.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmGuestProfiles.btnOtherClick(Sender: TObject);
begin
  //**
end;


procedure TfrmGuestProfiles.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmGuestProfiles.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmGuestProfiles.btnEditClick(Sender: TObject);
begin
  OpenGuestPortfolioEdit(GlobalRecordSet, m_['ID']);
  glb.LocateId(GlobalRecordSet, m_['ID']);
  if NOT GlobalRecordSet.Eof then
    glb.LoadCurrentRecordFromDataSet(m_, GlobalRecordSet, false);
end;

procedure TfrmGuestProfiles.btnInsertClick(Sender: TObject);
var id : Integer;
begin
  id := CreateNewGuest(GlobalRecordSet);
  if id > 0 then
  begin
    glb.LocateId(GlobalRecordSet, id);
    glb.LoadCurrentRecordFromDataSet(m_, GlobalRecordSet, true);
  end;
end;

procedure TfrmGuestProfiles.btnMergeClick(Sender: TObject);
var id1, id2 : Integer;
begin
  if NumItemsSelected > 1 then
  begin
    LocateSelectedId(id1, id2);
    MergeGuestPortfolios(GlobalRecordSet, id1, id2);
    SelectNoItems;
    btnMerge.Enabled := False; //NumItemsSelected > 1;
    fillGridFromDataset(id1);
    SelectNoItems;
  end;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmGuestProfiles.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmGuestProfiles.mnuOnlyDuplicatesClick(Sender: TObject);
begin
  mnuOnlyDuplicates.Checked := NOT mnuOnlyDuplicates.Checked;
  fillGridFromDataset(-1);
end;

procedure TfrmGuestProfiles.mnuOnlyDuplicateEmailsClick(Sender: TObject);
begin
  mnuOnlyDuplicateEmails.Checked := NOT mnuOnlyDuplicateEmails.Checked;
  fillGridFromDataset(-1);
end;

procedure TfrmGuestProfiles.mnuOnlyDuplicateTelNumsClick(Sender: TObject);
begin
  mnuOnlyDuplicateTelNums.Checked := NOT mnuOnlyDuplicateTelNums.Checked;
  fillGridFromDataset(-1);
end;

procedure TfrmGuestProfiles.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmGuestProfiles.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmGuestProfiles.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmGuestProfiles.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

