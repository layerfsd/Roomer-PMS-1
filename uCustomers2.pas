unit uCustomers2;

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
  , uAppGlobal
  , uStringUtils
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
  , ud
  , RoomerCloudEntities

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
  , cxCalc
  , dxSkinsdxBarPainter
  , dxSkinsdxRibbonPainter
  , cxPropertiesStore
  , Data.Win.ADODB
  , dxmdaset
  , Vcl.DBCtrls
  , Vcl.Mask
  , sSplitter, dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, sCheckBox, cxMemo




  ;

type
  TfrmCustomers2 = class(TForm)
    sPanel1: TsPanel;
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
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    m_ID: TIntegerField;
    m_Active: TBooleanField;
    m_Customer: TWideStringField;
    m_Surname: TWideStringField;
    m_Name: TWideStringField;
    m_CustomerType: TWideStringField;
    m_Address1: TWideStringField;
    m_Address2: TWideStringField;
    m_Address3: TWideStringField;
    m_Address4: TWideStringField;
    m_Country: TWideStringField;
    m_Tel1: TWideStringField;
    m_Tel2: TWideStringField;
    m_FAX: TWideStringField;
    m_DiscountPercent: TFloatField;
    m_EmailAddress: TWideStringField;
    m_ContactPerson: TWideStringField;
    m_TravelAgency: TBooleanField;
    m_Currency: TWideStringField;
    m_PID: TWideStringField;
    m_dele: TWideStringField;
    m_pcID: TIntegerField;
    m_Homepage: TWideStringField;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    btnInsert: TsButton;
    btnEdit: TsButton;
    sButton1: TsButton;
    m_CountryName: TWideStringField;
    m_CustomerTypeDescription: TWideStringField;
    m_pcCode: TWideStringField;
    sPanel2: TsPanel;
    sPanel3: TsPanel;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataCustomer: TcxGridDBColumn;
    tvDataPID: TcxGridDBColumn;
    tvDataSurname: TcxGridDBColumn;
    tvDataName: TcxGridDBColumn;
    tvDataCustomerType: TcxGridDBColumn;
    tvDataTravelAgency: TcxGridDBColumn;
    tvDataAddress1: TcxGridDBColumn;
    tvDataAddress2: TcxGridDBColumn;
    tvDataAddress3: TcxGridDBColumn;
    tvDataAddress4: TcxGridDBColumn;
    tvDataCountry: TcxGridDBColumn;
    tvDataCountryName: TcxGridDBColumn;
    tvDataTel1: TcxGridDBColumn;
    tvDataTel2: TcxGridDBColumn;
    tvDataFAX: TcxGridDBColumn;
    tvDataEmailAddress: TcxGridDBColumn;
    tvDataHomepage: TcxGridDBColumn;
    tvDataContactPerson: TcxGridDBColumn;
    tvDatapcCode: TcxGridDBColumn;
    tvDataCurrency: TcxGridDBColumn;
    tvDataDiscountPercent: TcxGridDBColumn;
    tvDatadele: TcxGridDBColumn;
    tvDataCustomerTypeDescription: TcxGridDBColumn;
    tvDatapcID: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    lvData: TcxGridLevel;
    sSplitter1: TsSplitter;
    grMemo: TcxGrid;
    tvMemo: TcxGridDBTableView;
    lvMemo: TcxGridLevel;
    sSplitter2: TsSplitter;
    DBMemo1: TDBMemo;
    mMemo_: TdxMemData;
    IntegerField1: TIntegerField;
    BooleanField1: TBooleanField;
    WideStringField1: TWideStringField;
    mMemoDS: TDataSource;
    mMemo_Description: TWideStringField;
    mMemo_Preference: TMemoField;
    tvMemoRecId: TcxGridDBColumn;
    tvMemoID: TcxGridDBColumn;
    tvMemoActive: TcxGridDBColumn;
    tvMemoCustomer: TcxGridDBColumn;
    tvMemoDescription: TcxGridDBColumn;
    tvMemoPreference: TcxGridDBColumn;
    Memo_: TRoomerDataSet;
    DBEdit1: TDBEdit;
    FormStore: TcxPropertiesStore;
    m_staytaxincluted: TBooleanField;
    tvDatastaytaxincluted: TcxGridDBColumn;
    tvDataColumn1: TcxGridDBColumn;
    N4: TMenuItem;
    C2: TMenuItem;
    chkActive: TsCheckBox;
    m_notes: TMemoField;
    tvDatanotes: TcxGridDBColumn;
    m_RatePlanId: TIntegerField;
    tvDataRatePlanId: TcxGridDBColumn;
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
    procedure btnCloseClick(Sender: TObject);
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
    procedure m_AfterScroll(DataSet: TDataSet);
    procedure Memo_NewRecord(DataSet: TDataSet);
    procedure Memo_AfterDelete(DataSet: TDataSet);
    procedure sButton2Click(Sender: TObject);
    procedure Memo_BeforeDelete(DataSet: TDataSet);
    procedure DBEdit1Change(Sender: TObject);
    procedure tvDataPIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tvDataColumn1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure tvDataCustomerPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    financeLookupList : TKeyPairList;
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;
    Lookup : Boolean;

    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    function getPrevCode : string;
    function getPrefrence: boolean;
    Procedure chkFilter;
    procedure applyFilter;
    function AssertCorrectness : Boolean;


  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recCustomerHolder;
  end;

function openCustomers(act : TActTableAction; Lookup : Boolean; var theData : recCustomerHolder) : boolean;

var
  frmCustomers2: TfrmCustomers2;

implementation

{$R *.dfm}

uses
  prjConst
  , uSqlDefinitions
  , uUtils
  , uCustomerEdit2
  , uFrmKeyPairSelector
  , uFrmResources
  , uGuestPortfolioEdit
  , uCustomerDepartments
  , uResourceManagement
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openCustomers(act : TActTableAction; Lookup : Boolean; var theData : recCustomerHolder) : boolean;
begin
  result := false;
  frmCustomers2 := TfrmCustomers2.Create(frmCustomers2);
  try
    frmCustomers2.zData := theData;
    frmCustomers2.Lookup := Lookup;
    frmCustomers2.zAct := act;
    frmCustomers2.ShowModal;
    if frmCustomers2.modalresult = mrOk then
    begin
      theData := frmCustomers2.zData;
      result := true;
    end
    else
    begin
      initCustomerHolder(theData);
    end;
  finally
    freeandnil(frmCustomers2);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////




Procedure TfrmCustomers2.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
  cust : string;
begin
  m_.DisableControls;
  active := chkActive.Checked;
  screen.Cursor := crHourGlass;
  try
    zFirstTime := true;
    if zSortStr = '' then zSortStr := 'customer';
    rSet := CreateNewDataSet;
    try
      s := format(select_CustomerPlus_byActive, [ord(active),zSortStr]);
//    copyToClipboard(s);
//    DebugMessage('-- 10 Invoiceheads'#10#10+s);


      if rSet_bySQL(rSet,s) then
      begin
        if m_.active then m_.Close;
        m_.LoadFromDataSet(rSet);
        rSet.First;
        while not rSet.eof do
        begin
          if rSet.FieldByName('notes').AsString <> '' then
          begin
            cust := rSet.FieldByName('customer').AsString;
            if m_.Locate('customer',cust,[]) then
            begin
              m_.edit;
              m_['notes'] := rSet['notes'];
              m_.post;
            end;
          end;
          rSet.Next;
        end;

        if sGoto = '' then
        begin
          m_.First;
        end else
        begin
          try
            m_.Locate('customer',sGoto,[]);
          except
          end;
        end;
      end;
    finally
      freeandnil(rSet);
    end;
  finally
    m_.EnableControls;
    screen.Cursor := crDEFAULT;
  end;
end;

procedure TfrmCustomers2.fillHolder;
begin
  initCustomerHolder(zData);
  zData.ID                       := m_.FieldByName('ID').AsInteger;
  zData.Active                   := m_['Active'];
  zData.Customer                 := m_['Customer'];
  zData.Surname                  := m_['Surname'];
  zData.Name                     := m_['Name'];
  zData.PID                      := m_['PID'];
  zData.CustomerType             := m_['CustomerType'];
  zData.Address1                 := m_['Address1'];
  zData.Address2                 := m_['Address2'];
  zData.Address3                 := m_['Address3'];
  zData.Address4                 := m_['Address4'];
  zData.Country                  := m_['Country'];
  zData.Tel1                     := m_['Tel1'];
  zData.Tel2                     := m_['Tel2'];
  zData.Fax                      := m_['Fax'];
  zData.DiscountPercent          := m_['DiscountPercent'];
  zData.EmailAddress             := m_['EmailAddress'];
  zData.ContactPerson            := m_['ContactPerson'];
  zData.TravelAgency             := m_['TravelAgency'];
  zData.Currency                 := m_['Currency'];
  zData.dele                     := m_['dele'];
  zData.pcID                     := m_['pcID'];
  zData.Homepage                 := m_['Homepage'];
  zData.CountryName              := m_['CountryName'];
  zdata.CustomerTypeDescription  := m_['CustomerTypeDescription'];
  zData.pcCode                   := m_['pcCode'];
  zData.stayTaxIncluted          := m_['stayTaxIncluted'];
  zData.notes                    := m_.fieldbyname('notes').AsString;;
  zData.RatePlanId               := m_['RatePlanId'];

end;



procedure TfrmCustomers2.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive         .Options.Editing         := true;
    tvDataCustomer       .Options.Editing         := false;
    tvDataSurname        .Options.Editing         := true;
    tvDataName           .Options.Editing         := true;
    tvDataPID            .Options.Editing         := true;
    tvDataCustomerType   .Options.Editing         := false;
    tvDataAddress1       .Options.Editing         := true;
    tvDataAddress2       .Options.Editing         := true;
    tvDataAddress3       .Options.Editing         := true;
    tvDataAddress4       .Options.Editing         := true;
    tvDataCountry        .Options.Editing         := false;
    tvDataTel1           .Options.Editing         := true;
    tvDataTel2           .Options.Editing         := true;
    tvDataFax            .Options.Editing         := true;
    tvDataDiscountPercent.Options.Editing         := true;
    tvDataEmailAddress   .Options.Editing         := true;
    tvDataContactPerson  .Options.Editing         := true;
    tvDataTravelAgency   .Options.Editing         := true;
    tvDataCurrency       .Options.Editing         := false;
    tvDatadele           .Options.Editing         := false;
    tvDatapcID           .Options.Editing         := false;
    tvDataHomepage       .Options.Editing         := true;
    tvDataCountryName               .Options.Editing         := false;
    tvDataCustomerTypeDescription   .Options.Editing         := false;
    tvDatapcCode                    .Options.Editing         := false;
    tvDataStayTaxIncluted           .Options.Editing         := true;
  end else
  begin
    tvDataID.Options.Editing                      := false;
    tvDataActive         .Options.Editing         := false;
    tvDataCustomer       .Options.Editing         := false;
    tvDataSurname        .Options.Editing         := false;
    tvDataName           .Options.Editing         := false;
    tvDataPID            .Options.Editing         := false;
    tvDataCustomerType   .Options.Editing         := false;
    tvDataAddress1       .Options.Editing         := false;
    tvDataAddress2       .Options.Editing         := false;
    tvDataAddress3       .Options.Editing         := false;
    tvDataAddress4       .Options.Editing         := false;
    tvDataCountry        .Options.Editing         := false;
    tvDataTel1           .Options.Editing         := false;
    tvDataTel2           .Options.Editing         := false;
    tvDataFax            .Options.Editing         := false;
    tvDataDiscountPercent.Options.Editing         := false;
    tvDataEmailAddress   .Options.Editing         := false;
    tvDataContactPerson  .Options.Editing         := false;
    tvDataTravelAgency   .Options.Editing         := false;
    tvDataCurrency       .Options.Editing         := false;
    tvDatadele           .Options.Editing         := false;
    tvDatapcID           .Options.Editing         := false;
    tvDataHomepage       .Options.Editing         := false;
    tvDataCountryName               .Options.Editing  := false;
    tvDataCustomerTypeDescription   .Options.Editing  := false;
    tvDatapcCode                    .Options.Editing  := false;
    tvDataStayTaxIncluted .Options.Editing  := true;
  end;
end;


procedure TfrmCustomers2.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.Customer);
  zFirstTime := false;
end;

procedure TfrmCustomers2.chkFilter;
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



procedure TfrmCustomers2.edFilterChange(Sender: TObject);
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

procedure TfrmCustomers2.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataSurName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataCustomer,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataCountryName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataPID,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataAddress1,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataAddress2,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataAddress3,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataAddress4,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataTel1,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataTel2,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataFax,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataEmailAddress,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataContactPerson,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataHomepage,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmCustomers2.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  Lookup := False;
  d.roomerMainDataSet.AssignPropertiesToDataSet(Memo_);
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmCustomers2.FormDestroy(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('customers', True);
end;

procedure TfrmCustomers2.FormShow(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('customers', False);
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.customer);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end else
  begin
    mnuiAllowGridEdit.Checked := false;
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  getPrefrence;
  zFirstTime := false;
end;

procedure TfrmCustomers2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  glb.EnableOrDisableTableRefresh('customers', True);
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmCustomers2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := AssertCorrectness;
end;

procedure TfrmCustomers2.FormKeyPress(Sender: TObject; var Key: Char);
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
function TfrmCustomers2.getPrevCode: string;
begin
end;

procedure TfrmCustomers2.Memo_AfterDelete(DataSet: TDataSet);
begin
  //showmessage('Deleted');
end;

procedure TfrmCustomers2.Memo_BeforeDelete(DataSet: TDataSet);
var
  s : string;
  id : integer;
begin
  Id := memo_.FieldByName('ID').asinteger;

  s := '';
  s := s + ' DELETE '+chr(10);
  s := s + '   FROM customerpreferences '+chr(10);
  s := s + ' WHERE  '+chr(10);
  s := s + '   (ID =' + _db(ID) + ') ';
  if cmd_bySQL(s) then
  begin
  end;
  dataset.Cancel;
end;

procedure TfrmCustomers2.Memo_NewRecord(DataSet: TDataSet);
begin
  dataset.FieldByName('customer').AsString := m_.FieldByName('customer').AsString;
  dataset.FieldByName('Active').AsBoolean := true;
  Dataset.FieldByName('Description').AsString := DateToStr(date)+'['+g.qUser+']';
end;

function TfrmCustomers2.getPrefrence: boolean;
var
  s : string;
  customer : string;
begin
  result := true;
  try
    if (mMemoDs.State = dsEdit) or (mMemoDs.State = dsInsert) then Memo_.Post;
    customer := m_.FieldByName('customer').AsString;
    s := 'SELECT * FROM customerpreferences WHERE customer = '+_db(customer)+' ORDER BY ID DESC ';
    if Memo_.Active then Memo_.Close;
    Memo_.CommandText := s;
    Memo_.CommandType := cmdText;
    Memo_.open;
  Except
    result := false;
  end;
end;




procedure TfrmCustomers2.m_AfterScroll(DataSet: TDataSet);
begin
//  if zFirstTime then exit;
//  getPrefrence;
end;

procedure TfrmCustomers2.DBEdit1Change(Sender: TObject);
begin
  if zFirstTime then exit;
  getPrefrence;
end;



procedure TfrmCustomers2.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;

  if hdata.CustomerExistsInOther(zData.Customer,zData.id) then
  begin
    Showmessage('Customer'+' ' + zData.Surname + ' '+GetTranslatedText('shExistsInRelatedData')+' ' + chr(10) + GetTranslatedText('shCanNotDelete')+' ');
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteCustomer')+' '+zData.surName+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_Customer(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmCustomers2.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Customer').Focused := True;
end;

procedure TfrmCustomers2.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
  oldCustCode : String;
begin
  if zFirstTime then exit;

  initCustomerHolder(zData);
  zData.ID                    := dataset.FieldByName('ID').AsInteger;
  zData.Active                := dataset['Active'];
  zData.Customer              := dataset['Customer'];
  zData.Surname               := dataset['Surname'];
  zData.Name                  := dataset['Name'];
  zData.PID                   := dataset['PID'];
  zData.CustomerType          := dataset['CustomerType'];
  zData.Address1              := dataset['Address1'];
  zData.Address2              := dataset['Address2'];
  zData.Address3              := dataset['Address3'];
  zData.Address4              := dataset['Address4'];
  zData.Country               := dataset['Country'];
  zData.Tel1                  := dataset['Tel1'];
  zData.Tel2                  := dataset['Tel2'];
  zData.Fax                   := dataset['Fax'];
  zData.DiscountPercent       := dataset['DiscountPercent'];
  zData.EmailAddress          := dataset['EmailAddress'];
  zData.ContactPerson         := dataset['ContactPerson'];
  zData.TravelAgency          := dataset['TravelAgency'];
  zData.Currency              := dataset['Currency'];
  zData.dele                  := dataset['dele'];
  zData.pcID                  := dataset['pcID'];
  zData.Homepage              := dataset['Homepage'];
  zData.CountryName              := dataset['CountryName'];
  zdata.CustomerTypeDescription  := dataset['CustomerTypeDescription'];
  zData.pcCode                   := dataset['pcCode'];
  zData.stayTaxIncluted          := dataset['stayTaxIncluted'];
  zdata.notes                    := dataset.fieldbyname('notes').AsString;
  zData.RatePlanId            := dataset['RatePlanId'];


  if tvData.DataController.DataSource.State = dsEdit then
  begin
    oldCustCode := dataSet.FieldByName('Customer').OldValue;
    if oldCustCode <> zData.Customer then
      SetForeignKeyCheckValue(0);
    try
      if UPD_Customer(zData) then
      begin
        CustomerDepartments.CustomerId := zData.ID;
        CustomerDepartments.PostChanges;
        if oldCustCode <> zData.Customer then
          UpdateCustomerCode(oldCustCode, zData.Customer);
        glb.ForceTableRefresh;
      end else
      begin
        abort;
        exit;
      end;
    finally
      if oldCustCode <> zData.Customer then
        SetForeignKeyCheckValue(1);
    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('Customer').AsString = ''  then
    begin
      //showmessage('Customer is requierd - set value or use [ESC] to cancel ');
	    showmessage(GetTranslatedText('shTx_Customers2_Required'));
      tvData.GetColumnByFieldName('Customer').Focused := True;
      abort;
      exit;
    end;
    if glb.LocateSpecificRecord('customers', 'Customer', dataset.FieldByName('Customer').AsString)  then
    begin
	   showmessage(GetTranslatedText('shTx_CustomerEdit2_CustomerExists'));
      tvData.GetColumnByFieldName('Customer').Focused := True;
      abort;
      exit;
    end;
    if ins_Customer(zData,nID) then
    begin
      m_.FieldByName('ID').AsInteger := nID;
      CustomerDepartments.CustomerId := nID;
      CustomerDepartments.PostChanges;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;



procedure TfrmCustomers2.m_NewRecord(DataSet: TDataSet);
begin

  if zFirstTime then exit;
  dataset['Active']         := true;
  dataset['Customer']       :='';
  dataset['Surname']         :='';
  dataset['Name']            :='';
  dataset['PID']             :='';
  dataset['CustomerType']    :='';
  dataset['Address1']        :='';
  dataset['Address2']        :='';
  dataset['Address3']        :='';
  dataset['Address4']        :='';
  dataset['Country']         :='';
  dataset['Tel1']            :='';
  dataset['Tel2']            :='';
  dataset['Fax']             :='';
  dataset['DiscountPercent'] :=0 ;
  dataset['EmailAddress']    :='';
  dataset['ContactPerson']   :='';
  dataset['TravelAgency']    :=false;
  dataset['Currency']        :='';
  dataset['dele']            :='';
  dataset['pcID']            :=0;
  dataset['Homepage']        :='';
  dataset['notes']        :='';
  dataset['CountryName']              :='';
  dataset['CustomerTypeDescription']  :='';
  dataset['pcCode']                   :='';
  dataset['stayTaxIncluted']          :=ctrlGetBoolean('stayTaxIncluted');
  dataset['RatePlanId']          := 0;
end;

procedure TfrmCustomers2.sButton2Click(Sender: TObject);
begin
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////


procedure TfrmCustomers2.tvDataFocusedRecordChanged(
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


procedure TfrmCustomers2.tvDataPIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  pIdValue : string;
  keyValue : TKeyAndValue;
begin
  if NOT assigned(financeLookupList) then
    financeLookupList := d.RetrieveFinancesKeypair(FKP_CUSTOMERS);

  pIdValue := m_.FieldByName('PId').AsString;
  keyValue := selectFromKeyValuePairs('Payment types', pIdValue, financeLookupList);
  if Assigned(keyValue) then
  begin
    m_.Edit;
    m_.fieldbyname('pId').AsString := keyValue.Key;
    m_.Post;
  end else
  begin
    //NotOK
  end;
end;

procedure TfrmCustomers2.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end else
  begin
    btnEdit.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmCustomers2.tvDataColumn1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  StaticResources('Customer Resources',
        format(CUSTOMER_DOCUMENTS_STATIC_RESOURCE_PATTERN, [m_['Customer']]),
        ACCESS_RESTRICTED);
end;

procedure TfrmCustomers2.tvDataCustomerPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DisplayValue := TRIM(DisplayValue);
end;

procedure TfrmCustomers2.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmCustomers2.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmCustomers2.BtnOkClick(Sender: TObject);
begin
  fillHolder;
   glb.ForceTableRefresh;
end;

procedure TfrmCustomers2.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmCustomers2.C2Click(Sender: TObject);
begin
  if NOT m_.Eof then
    CreateNewGuest(glb.PersonProfiles, -1, m_['Customer']);
end;

procedure TfrmCustomers2.btnCancelClick(Sender: TObject);
begin
  initCustomerHolder(zData);
end;

procedure TfrmCustomers2.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmCustomers2.btnCloseClick(Sender: TObject);
begin
  fillHolder;
  if (mMemoDs.State = dsEdit) or (mMemoDs.State = dsInsert) then Memo_.Post;
end;

function TfrmCustomers2.AssertCorrectness : Boolean;
var config : Array_Of_THotelconfigurationsEntity;
    answer : Integer;
begin
  result := true;
  if Lookup then
    exit;
  try
    config := d.roomerMainDataSet.Hotelconfigurations_Entities_FindAll;
    if config[0].forceExternalProductIdCorrectness = 1 then
    begin
      screen.Cursor := crHourGlass;
      m_.DisableControls;
      try
        m_.First;
        if NOT m_.Eof then
          if NOT assigned(financeLookupList) then
            financeLookupList := d.RetrieveFinancesKeypair(FKP_CUSTOMERS);
        while NOT m_.Eof do
        begin
          if (m_['PID'] = '') OR NOT d.KeyExists(financeLookupList, m_['PID']) then
          begin
            answer := MessageDlg(format('Customer %s (%s %s) needs to have a Personal Id for bookkeeping.', [m_['Customer'], m_['Name'], m_['Surname']]), mtWarning, [mbOk, mbIgnore, mbCancel], 0, mbOk);
            if answer = mrCancel then
            begin
              result := True;
              exit;
            end else
            if answer = mrOk then
            begin
              result := False;
              exit;
            end;
          end;
          m_.Next;
        end;
      finally
         screen.Cursor := crDefault;
         m_.EnableControls;
      end;
    end;
  except
  end;
end;


procedure TfrmCustomers2.btnDeleteClick(Sender: TObject);
begin
  glb.ForceTableRefresh;
  m_.Delete;
end;

procedure TfrmCustomers2.btnEditClick(Sender: TObject);
begin
  glb.ForceTableRefresh;
  fillHolder;
  if NOT assigned(financeLookupList) then
    financeLookupList := d.RetrieveFinancesKeypair(FKP_CUSTOMERS);
  GetCustomerDepartments(zData.ID, True);
  if openCustomerEdit(zData,false, financeLookupList) then
  begin
      m_.edit;
      m_['Active']         :=  zData.Active            ;
      m_['Customer']       :=  zData.Customer          ;
      m_['Surname']        :=  zData.Surname           ;
      m_['Name']           :=  zData.Name              ;
      m_['PID']            :=  zData.PID               ;
      m_['CustomerType']   :=  zData.CustomerType      ;
      m_['Address1']       :=  zData.Address1          ;
      m_['Address2']       :=  zData.Address2          ;
      m_['Address3']       :=  zData.Address3          ;
      m_['Address4']       :=  zData.Address4          ;
      m_['Country']        :=  zData.Country           ;
      m_['Tel1']           :=  zData.Tel1              ;
      m_['Tel2']           :=  zData.Tel2              ;
      m_['Fax']            :=  zData.Fax               ;
      m_['DiscountPercent']:=  zData.DiscountPercent   ;
      m_['EmailAddress']   :=  zData.EmailAddress      ;
      m_['ContactPerson']  :=  zData.ContactPerson     ;
      m_['TravelAgency']   :=  zData.TravelAgency      ;
      m_['Currency']       :=  zData.Currency          ;
      m_['Homepage']       :=  zData.Homepage          ;
      m_.FieldByName('notes').asstring          :=  zData.notes;
      m_['CountryName']              := zData.CountryName;
      m_['CustomerTypeDescription']  := zData.CustomerTypeDescription;
      m_['pcCode']                   := zData.pcCode;
      m_['pcID']                     :=  zData.pcID;
      m_['stayTaxIncluted']          :=  zData.stayTaxIncluted;
      m_['RatePlanId']          :=  zData.RatePlanId;
      m_.post;
  end;

end;

procedure TfrmCustomers2.btnInsertClick(Sender: TObject);
begin
  glb.ForceTableRefresh;
  if not m_.active then m_.open;
  initCustomerHolder(zData);
  GetCustomerDepartments(0, True);
  if openCustomerEdit(zData,true) then
  begin
      m_.Insert;
      m_['Active']         :=  zData.Active            ;
      m_['Customer']       :=  zData.Customer          ;
      m_['Surname']        :=  zData.Surname           ;
      m_['Name']           :=  zData.Name              ;
      m_['PID']            :=  zData.PID               ;
      m_['CustomerType']   :=  zData.CustomerType      ;
      m_['Address1']       :=  zData.Address1          ;
      m_['Address2']       :=  zData.Address2          ;
      m_['Address3']       :=  zData.Address3          ;
      m_['Address4']       :=  zData.Address4          ;
      m_['Country']        :=  zData.Country           ;
      m_['Tel1']           :=  zData.Tel1              ;
      m_['Tel2']           :=  zData.Tel2              ;
      m_['Fax']            :=  zData.Fax               ;
      m_['DiscountPercent']:=  zData.DiscountPercent   ;
      m_['EmailAddress']   :=  zData.EmailAddress      ;
      m_['ContactPerson']  :=  zData.ContactPerson     ;
      m_['TravelAgency']   :=  zData.TravelAgency      ;
      m_['Currency']       :=  zData.Currency          ;
      m_['Homepage']       :=  zData.Homepage          ;
      m_.FieldByName('notes').asstring          :=  zData.notes;
      m_['CountryName']              := zData.CountryName;
      m_['CustomerTypeDescription']  := zData.CustomerTypeDescription;
      m_['pcCode']                   := zData.pcCode;
      m_['pcID']                     := zData.pcID;
      m_['stayTaxIncluted']          :=  zData.stayTaxIncluted;
      m_['RatePlanId']          :=  zData.RatePlanId;
      m_.Post;
  end;
  if m_.RecordCount > 0 then fillHolder else initCustomerHolder(zData);

end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmCustomers2.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmCustomers2.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmCustomers2.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmCustomers2.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmCustomers2.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmCustomers2.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

