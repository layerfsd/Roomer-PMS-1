unit uStaffMembers2;

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
  , uAppGlobal
  , _glob
  , uUtils
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
  , cmpRoomerConnection
  , dxSkinsCore
  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters
  , dxSkinscxPCPainter
  , cxButtonEdit
  , dxSkinsdxBarPainter
  , dxSkinsdxRibbonPainter
  , cxPropertiesStore
  , dxmdaset
  , dxPScxPivotGridLnk, cxGridBandedTableView, cxGridDBBandedTableView, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

  ;

type
  TfrmStaffMembers2 = class(TForm)
    sPanel1: TsPanel;
    btnOther: TsButton;
    btnClose: TsButton;
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
    grData: TcxGrid;
    lvData: TcxGridLevel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    FormStore: TcxPropertiesStore;
    m_: TkbmMemTable;
    tvData: TcxGridDBBandedTableView;
    tvDataID: TcxGridDBBandedColumn;
    tvDataActive: TcxGridDBBandedColumn;
    tvDataStaffType1: TcxGridDBBandedColumn;
    tvDataStaffType2: TcxGridDBBandedColumn;
    tvDataStaffType3: TcxGridDBBandedColumn;
    tvDataStaffType4: TcxGridDBBandedColumn;
    tvDataInitials: TcxGridDBBandedColumn;
    tvDataPassword: TcxGridDBBandedColumn;
    tvDataName: TcxGridDBBandedColumn;
    tvDataAddress1: TcxGridDBBandedColumn;
    tvDataAddress2: TcxGridDBBandedColumn;
    tvDataAddress3: TcxGridDBBandedColumn;
    tvDataAddress4: TcxGridDBBandedColumn;
    tvDataCountry: TcxGridDBBandedColumn;
    tvDatatel1: TcxGridDBBandedColumn;
    tvDatatel2: TcxGridDBBandedColumn;
    tvDatafax: TcxGridDBBandedColumn;
    tvDataActiveMember: TcxGridDBBandedColumn;
    tvDataStaffType: TcxGridDBBandedColumn;
    tvDataStaffLanguage: TcxGridDBBandedColumn;
    tvDataStaffPID: TcxGridDBBandedColumn;
    tvDataIPAddresses: TcxGridDBBandedColumn;
    tvDataPmsOnly: TcxGridDBBandedColumn;
    tvDataWindowsauth: TcxGridDBBandedColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure tvDataDblClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnOtherClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataInitialsPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataNamePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataStaffTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataStaffType1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataStaffType2PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataStaffType3PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataStaffType4PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure tvDataCountryPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;
    zButtonInsert    : boolean;

    Procedure fillGridFromDataset(iGoto : integer);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    function getPrevCode : string;
    Procedure chkFilter;
    procedure applyFilter;
    procedure doEdit;
  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recStaffMemberHolder;
  end;

function openStaffMembers(act : TActTableAction; var theData : recStaffMemberHolder) : boolean;

var
  frmStaffMembers2: TfrmStaffMembers2;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uStaffEdit2
  , uStaffTypes2
  , ucountries
  , uDImages
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openStaffMembers(act : TActTableAction; var theData : recStaffMemberHolder) : boolean;
begin
  result := false;
  frmStaffMembers2 := TfrmStaffMembers2.Create(frmStaffMembers2);
  try
    frmStaffMembers2.zData := theData;
    frmStaffMembers2.zAct := act;
    frmStaffMembers2.ShowModal;
    if frmStaffMembers2.modalresult = mrOk then
    begin
      theData := frmStaffMembers2.zData;
      result := true;
    end
    else
    begin
      initStaffMemberHolder(theData);
    end;
  finally
    freeandnil(frmStaffMembers2);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmStaffMembers2.fillGridFromDataset(iGoto : integer);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'ID';
  rSet := CreateNewDataSet;
  try
    s := format(select_StaffMembers, [zSortStr]);
    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      LoadKbmMemtableFromDataSetQuiet(m_,rSet,[]);
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

procedure TfrmStaffMembers2.fillHolder;
begin
  initStaffMemberHolder(zData);
  zData.ID           := m_.FieldByName('ID').AsInteger;
  zData.Active           := m_['Active'];
  zData.Initials         := m_['Initials'];
  zData.Password         := m_['Password'];
  zData.StaffPID         := m_['StaffPID'];
  zData.Name             := m_['Name'];
  zData.Address1         := m_['Address1'];
  zData.Address2         := m_['Address2'];
  zData.Address3         := m_['Address3'];
  zData.Address4         := m_['Address4'];
  zData.Country          := m_['Country'];
  zData.Tel1             := m_['Tel1'];
  zData.Tel2             := m_['Tel2'];
  zData.Fax              := m_['Fax'];
  zData.ActiveMember     := m_['ActiveMember'];
  zData.StaffLanguage    := m_['StaffLanguage'];
  zData.StaffType        := m_['StaffType'];
  zData.StaffType1       := m_['StaffType1'];
  zData.StaffType2       := m_['StaffType2'];
  zData.StaffType3       := m_['StaffType3'];
  zData.StaffType4       := m_['StaffType4'];
  zData.IPAddresses      := m_['IPAddresses'];
  zData.PmsOnly          := m_['PmsOnly'];
  zData.WindowsAuth      := m_['WindowsAuth'];
end;



procedure TfrmStaffMembers2.changeAllowgridEdit;
begin
  tvDataID.Options.Editing             := false;
  tvDataActive       .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataActive.Tag);
  tvDataInitials     .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataInitials     .Tag);
  tvDataPassword     .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataPassword     .Tag);
  tvDataStaffPID     .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataStaffPID     .Tag);
  tvDataName         .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataName         .Tag);
  tvDataAddress1     .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataAddress1     .Tag);
  tvDataAddress2     .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataAddress2     .Tag);
  tvDataAddress3     .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataAddress3     .Tag);
  tvDataAddress4     .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataAddress4     .Tag);
  tvDataCountry      .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataCountry      .Tag);
  tvDataTel1         .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataTel1         .Tag);
  tvDataTel2         .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataTel2         .Tag);
  tvDataFax          .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataFax          .Tag);
  tvDataActiveMember .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataActiveMember .Tag);
  tvDataStaffLanguage.Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataStaffLanguage.Tag);
  tvDataStaffType    .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataStaffType    .Tag);
  tvDataStaffType1   .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataStaffType1   .Tag);
  tvDataStaffType2   .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataStaffType2   .Tag);
  tvDataStaffType3   .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataStaffType3   .Tag);
  tvDataStaffType4   .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataStaffType4   .Tag);
  tvDataIpAddresses  .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataIpAddresses  .Tag);
  tvDataPmsOnly      .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataPmsOnly      .Tag);
  tvDataWindowsAuth  .Options.Editing  := zAllowGridEdit AND glb.AccessAllowed(tvDataWindowsAuth  .Tag);
end;


procedure TfrmStaffMembers2.chkFilter;
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


procedure TfrmStaffMembers2.edFilterChange(Sender: TObject);
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

procedure TfrmStaffMembers2.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataName     ,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataInitials ,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataStaffPId ,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataAddress1 ,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataAddress2 ,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataAddress3 ,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataAddress4 ,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatatel1     ,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatatel2     ,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatafax      ,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataStaffType,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataStaffType1,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataStaffType2,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataStaffType3,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataStaffType4,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmStaffMembers2.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmStaffMembers2.FormDestroy(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('staffmembers', True);
end;

procedure TfrmStaffMembers2.FormShow(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('staffmembers', False);
//**
  zButtonInsert := false;
  panBtn.Visible := False;
  sbMain.Visible := false;
  btnClose.Visible := False;

  fillGridFromDataset(zData.ID);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end else
  begin
    m_.First;
    mnuiAllowGridEdit.Checked := false;
    btnClose.Visible := true;
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmStaffMembers2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  glb.EnableOrDisableTableRefresh('staffmembers', True);
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmStaffMembers2.FormKeyPress(Sender: TObject; var Key: Char);
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
function TfrmStaffMembers2.getPrevCode: string;
begin
end;



////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////


procedure TfrmStaffMembers2.tvDataFocusedRecordChanged(
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


procedure TfrmStaffMembers2.tvDataInitialsPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_['Initials'];

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
   //errortext := 'Initial '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_StaffMembers2_InitialIsRequired');
    exit;
  end;

  if hdata.staffMemberExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.InitialsExistsInOther(currValue) then
    begin
      error := true;
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;


procedure TfrmStaffMembers2.tvDataNamePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Name').asstring;
  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
 //   errortext := 'Name '+' - '+'is required - Use ESC to cancel';
	errortext := GetTranslatedText('shTx_StaffMembers2_NameIsRequired');
    exit;
  end;
end;

procedure TfrmStaffMembers2.tvDataStaffType1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recStaffTypeHolder;
begin
//fillholder;
  theData.StaffType := zData.StaffType1;
  openStaffTypes(actlookup,theData);
  if theData.StaffType <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['Stafftype1'] := theData.StaffType;
//    m_.Post;



  end;
end;

procedure TfrmStaffMembers2.tvDataStaffType2PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recStaffTypeHolder;
begin
//fillholder;
  theData.StaffType := zData.StaffType2;
  openStaffTypes(actlookup,theData);
  if theData.StaffType <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['Stafftype2'] := theData.StaffType;
//    m_.Post;
  end;
end;

procedure TfrmStaffMembers2.tvDataStaffType3PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recStaffTypeHolder;
begin
//fillholder;
  theData.StaffType := zData.StaffType3;
  openStaffTypes(actlookup,theData);
  if theData.StaffType <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['Stafftype3'] := theData.StaffType;
//    m_.Post;
  end;
end;

procedure TfrmStaffMembers2.tvDataStaffType4PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recStaffTypeHolder;
begin
//fillholder;
  theData.StaffType := zData.StaffType4;
  openStaffTypes(actlookup,theData);
  if theData.StaffType <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['Stafftype4'] := theData.StaffType;
//    m_.Post;
  end;
end;

procedure TfrmStaffMembers2.tvDataStaffTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recStaffTypeHolder;
begin
//fillholder;
  theData.StaffType := zData.StaffType;
  openStaffTypes(actlookup,theData);
  if theData.StaffType <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['Stafftype'] := theData.StaffType;
//  m_.Post;
  end;
end;

procedure TfrmStaffMembers2.tvDataDblClick(Sender: TObject);
var
  Allow : boolean;
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
        doEdit
      end;
    end;
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmStaffMembers2.tvDataCountryPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recCountryHolder;
begin
  theData.Country := zData.Country;
  countries(actlookup,theData);
  if theData.Country <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['country'] := theData.Country;
//    m_.Post;
  end;
end;

procedure TfrmStaffMembers2.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmStaffMembers2.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmStaffMembers2.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmStaffMembers2.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmStaffMembers2.btnCancelClick(Sender: TObject);
begin
  initStaffMemberHolder(zData);
end;

procedure TfrmStaffMembers2.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmStaffMembers2.btnCloseClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmStaffMembers2.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmStaffMembers2.btnEditClick(Sender: TObject);
begin
  doedit;
end;

procedure TfrmStaffMembers2.doEdit;
begin
  fillHolder;
  if openStaffMemberEdit(zData,false) then
  begin
      m_.edit;
       m_['Active']       :=  zData.Active         ;
       m_['ActiveMember'] :=  zData.Active         ;
       m_['Initials']     :=  zData.Initials       ;
       m_['Password']     :=  zData.Password       ;
       m_['StaffPID']     :=  zData.StaffPID       ;
       m_['Name']         :=  zData.Name           ;
       m_['Address1']     :=  zData.Address1       ;
       m_['Address2']     :=  zData.Address2       ;
       m_['Address3']     :=  zData.Address3       ;
       m_['Address4']     :=  zData.Address4       ;
       m_['Country']      :=  zData.Country        ;
       m_['Tel1']         :=  zData.Tel1           ;
       m_['Tel2']         :=  zData.Tel2           ;
       m_['Fax']          :=  zData.Fax            ;
       m_['StaffLanguage']:=  zData.StaffLanguage  ;
       m_['StaffType']    :=  zData.StaffType      ;
       m_['StaffType1']   :=  zData.StaffType1     ;
       m_['StaffType2']   :=  zData.StaffType2     ;
       m_['StaffType3']   :=  zData.StaffType3     ;
       m_['StaffType4']   :=  zData.StaffType4     ;
       m_['IPAddresses']  :=  zData.IPAddresses    ;
       m_['PmsOnly']      :=  zData.PmsOnly        ;
       m_['WindowsAuth']  :=  zData.WindowsAuth    ;
      m_.Post;
  end;
end;


procedure TfrmStaffMembers2.btnInsertClick(Sender: TObject);
begin
  zButtonInsert := true;
  initStaffMemberHolder(zData);
  if openStaffMemberEdit(zData,true) then
  begin
      m_.insert;
       m_['Active']       :=  zData.Active         ;
       m_['ActiveMember'] :=  zData.Active         ;
       m_['Initials']     :=  zData.Initials       ;
       m_['Password']     :=  zData.Password       ;
       m_['StaffPID']     :=  zData.StaffPID       ;
       m_['Name']         :=  zData.Name           ;
       m_['Address1']     :=  zData.Address1       ;
       m_['Address2']     :=  zData.Address2       ;
       m_['Address3']     :=  zData.Address3       ;
       m_['Address4']     :=  zData.Address4       ;
       m_['Country']      :=  zData.Country        ;
       m_['Tel1']         :=  zData.Tel1           ;
       m_['Tel2']         :=  zData.Tel2           ;
       m_['Fax']          :=  zData.Fax            ;
       m_['StaffLanguage']:=  zData.StaffLanguage  ;
       m_['StaffType']    :=  zData.StaffType      ;
       m_['StaffType1']   :=  zData.StaffType1     ;
       m_['StaffType2']   :=  zData.StaffType2     ;
       m_['StaffType3']   :=  zData.StaffType3     ;
       m_['StaffType4']   :=  zData.StaffType4     ;
       m_['IPAddresses']  :=  zData.IPAddresses    ;
       m_['PmsOnly']      :=  zData.PmsOnly        ;
       m_['WindowsAuth']  :=  zData.WindowsAuth    ;
      m_.Post;
  end;
  fillHolder;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmStaffMembers2.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmStaffMembers2.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmStaffMembers2.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.InitialsExistsInOther(zData.Initials) then
  begin
   // Showmessage('Staffmember'+' ' + zData.Name + ' '+GetTranslatedText('shExistsInRelatedData')+' ' + chr(10) + GetTranslatedText('shCanNotDelete')+' ');
	  Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['StaffMember', zData.Name]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteStaffMember')+' '+zData.Name+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_StaffMember(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmStaffMembers2.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Initials').Focused := True;
end;

procedure TfrmStaffMembers2.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;

  if Not zButtonInsert then
  begin
    initStaffMemberHolder(zData);
    zData.ID           := dataset.FieldByName('ID').AsInteger;
    zData.Active       := dataset['Active'];
    zData.Initials     := dataset['Initials'];
    zData.Password     := dataset['Password'];
    zData.StaffPID     := dataset['StaffPID'];
    zData.Name         := dataset['Name'];
    zData.Address1     := dataset['Address1'];
    zData.Address2     := dataset['Address2'];
    zData.Address3     := dataset['Address3'];
    zData.Address4     := dataset['Address4'];
    zData.Country      := dataset['Country'];
    zData.Tel1         := dataset['Tel1'];
    zData.Tel2         := dataset['Tel2'];
    zData.Fax          := dataset['Fax'];
    zData.ActiveMember := dataset['ActiveMember'];
    zData.StaffLanguage:= dataset['StaffLanguage'];
    zData.StaffType    := dataset['StaffType'];
    zData.StaffType1   := dataset['StaffType1'];
    zData.StaffType2   := dataset['StaffType2'];
    zData.StaffType3   := dataset['StaffType3'];
    zData.StaffType4   := dataset['StaffType4'];
    zData.IPAddresses  := dataset['IPAddresses'];
    zData.PmsOnly      := dataset['PmsOnly'];
    zData.WindowsAuth  := dataset['WindowsAuth'];
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_StaffMember(zData) then
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
    if Not zButtonInsert then
    begin
      if dataset.FieldByName('initials').AsString = ''  then
      begin
       // showmessage('Initials is requierd - set value or use [ESC] to cancel ');
		    showmessage(GetTranslatedText('shTx_StaffMembers2_InitialsRequired'));
        tvData.GetColumnByFieldName('Initials').Focused := True;
        abort;
        exit;
      end;
    end;

    if ins_StaffMember(zData,nID) then
    begin
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
  zButtonInsert := false;
end;

procedure TfrmStaffMembers2.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;

  dataset['Active']  := true;
  dataset['Initials']  := '';
  dataset['Password']  := '';
  dataset['StaffPID']  := '';
  dataset['Name']  := '';
  dataset['Address1']  := '';
  dataset['Address2']  := '';
  dataset['Address3']  := '';
  dataset['Address4']  := '';
  dataset['Country']  := '';
  dataset['Tel1']  := '';
  dataset['Tel2']  := '';
  dataset['Fax']  := '';
  dataset['ActiveMember']  := true;
  dataset['StaffLanguage']  := 0;
  dataset['StaffType']  := '';
  dataset['StaffType1']  := '';
  dataset['StaffType2']  := '';
  dataset['StaffType3']  := '';
  dataset['StaffType4']  := '';
  dataset['IPAddresses'] := '';
  dataset['PmsOnly']     := false;
  dataSet['WindowsAuth'] := false;
end;

procedure TfrmStaffMembers2.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmStaffMembers2.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmStaffMembers2.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmStaffMembers2.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

