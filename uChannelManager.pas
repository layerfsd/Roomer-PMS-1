unit uChannelManager;
(*

 121207 - checked for ww - OK

*)


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
  , ComCtrls

  , ADODB
  , db
  , DBTables
  , DBCtrls

  , hdata
  , uAppGlobal
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


  // TMSSOFRWARE
  , AdvEdit
  , AdvEdBtn


  , PrjConst

  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection

  , sButton
  , sPanel
  , sMaskEdit
  , sCustomComboEdit
  , sComboEdit
  , sLabel

  , dxSkinsCore
  , dxSkinsDefaultPainters
  , cxButtonEdit
  , dxSkinsdxBarPainter
  , dxSkinsdxRibbonPainter
  , cxPropertiesStore

  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinscxPCPainter, dxmdaset, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, sSpeedButton, sEdit, cxMaskEdit, dxPScxPivotGridLnk

  ;

type
  TfrmChannelManager = class(TForm)
    sbMain: TStatusBar;
    PanTop: TsPanel;
    panBtn: TsPanel;
    BtnOk: TsButton;
    btnCancel: TsButton;
    btnClose: TsButton;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    grData: TcxGrid;
    btnOther: TsButton;
    mnuOther: TPopupMenu;
    mnuiAllowGridEdit: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    DS: TDataSource;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    mnuiPrint: TMenuItem;
    m_: TdxMemData;
    m_Description: TWideStringField;
    m_webserviceUsername: TWideStringField;
    m_webservicePassword: TWideStringField;
    m_webserviceHotelCode: TWideStringField;
    m_weserviceRequestor: TWideStringField;
    m_adminUsername: TWideStringField;
    m_adminPassword: TWideStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDatawebserviceUsername: TcxGridDBColumn;
    tvDatawebservicePassword: TcxGridDBColumn;
    tvDatawebserviceHotelCode: TcxGridDBColumn;
    tvDataweserviceRequestor: TcxGridDBColumn;
    tvDataadminUsername: TcxGridDBColumn;
    tvDataadminPassword: TcxGridDBColumn;
    m_Id: TIntegerField;
    tvDataId: TcxGridDBColumn;
    StoreMain: TcxPropertiesStore;
    m_code: TWideStringField;
    tvDatacode: TcxGridDBColumn;
    m_channels: TWideMemoField;
    tvDatachannels: TcxGridDBColumn;
    m_webserviceURI: TWideStringField;
    tvDatawebserviceURI: TcxGridDBColumn;
    m_active: TBooleanField;
    m_sendRate: TBooleanField;
    m_sendAvailability: TBooleanField;
    m_sendStopSell: TBooleanField;
    m_sendMinStay: TBooleanField;
    tvDataactive: TcxGridDBColumn;
    tvDatasendRate: TcxGridDBColumn;
    tvDatasendAvailability: TcxGridDBColumn;
    tvDatasendStopSell: TcxGridDBColumn;
    tvDatasendMinStay: TcxGridDBColumn;
    labChannelManager: TsLabel;
    m_maintenanceDays: TIntegerField;
    tvDatamaintenanceDays: TcxGridDBColumn;
    Button1: TsButton;
    Button2: TsButton;
    Button3: TsButton;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    m_directConnection: TBooleanField;
    tvDatadirectConnection: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure edFilterClickBtn(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataChannelManagerPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure tvDataCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure btnOtherClick(Sender: TObject);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure m_AfterPost(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure m_BeforeEdit(DataSet: TDataSet);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure tvDatachannelsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnClearClick(Sender: TObject);

  private
    { Private declarations }
    zFirstTime : boolean;
    zAllowGridEdit : boolean;
    zPostData        : boolean;
    zPostState       : integer;
    zFilterOn : boolean;
    zSortStr  : string;


    Procedure fillGridFromDataset(sGoto : string);
    procedure changeAllowgridEdit;
    procedure fillHolder;
    function getPrevCode : string;

    Procedure chkFilter;
    procedure applyFilter;

  public
    { Public declarations }
    zAct         : TActTableAction;
    zData  : recChannelManagerHolder;
  end;


function ChannelManager(act : TActTableAction; var theData : recChannelManagerHolder ) : boolean;
function getChannelManager(ed : TsComboEdit; lab : TsLabel) : boolean;
function channelManagerValidate(ed : TsComboEdit; lab : TsLabel) : boolean;


var
  frmChannelManager: TfrmChannelManager;

implementation

uses
    uD
  , uMultiSelection
  , uSqlDefinitions
  , uDImages
  , u2dMatrix
  ;

{$R *.dfm}



//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function ChannelManager(act : TActTableAction; var theData : recChannelManagerHolder ) : boolean;
begin
  result := false;
  frmChannelManager := TfrmChannelManager.Create(frmChannelManager);
  try
    frmChannelManager.zData := theData;
    frmChannelManager.zAct := act;
    frmChannelManager.ShowModal;
    if frmChannelManager.modalresult = mrOk then
    begin
      theData := frmChannelManager.zData;
      result := true;
    end
    else
    begin
      initChannelManagerHolder(theData);
    end;
  finally
    freeandnil(frmChannelManager)
  end;
end;

function getChannelManager(ed : TsComboEdit; lab : TsLabel) : boolean;
var
  theData : recChannelManagerHolder;
begin
  //*NOT TESTED*//
  result := false;
  initChannelManagerHolder(theData);
  theData.Id := strtointdef(trim(ed.text), 1);
  result := ChannelManager(actLookup,theData);

  if inttostr(theData.Id) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (inttostr(theData.Id) <> ed.text) then
  begin
    ed.text := inttostr(theData.Id);
    lab.Caption := thedata.Code+' - '+thedata.Description;
  end;
end;

function channelManagerValidate(ed : TsComboEdit; lab : TsLabel) : boolean;
var
  sValue : string;
  pcCode : string;
  theData : recChannelManagerHolder;
begin
  //*NOT TESTED*//
  initChannelManagerHolder(theData);
  theData.Id := strtointdef(trim(ed.Text), 1);
  result := hdata.GET_ChannelManagerHolderById(theData);

  try
    if not result then
    begin
      try ed.SetFocus; except end;
      lab.Color := clRed;
      lab.caption := GetTranslatedText('shNotF_star');
    end else
    begin
      lab.Color := clBtnFace;
      lab.Caption := thedata.Code+' - '+thedata.Description;
    end;
  except

  end;
end;
//END unit global functions

///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////

procedure TfrmChannelManager.fillGridFromDataset(sGoto: string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'Id ';

  rSet := CreateNewDataSet;
  try
    s := format(select_ChannelManager_fillGridFromDataset, [zSortStr]);
//    CopyToClipboard(s);
//    DebugMessage('select_ChannelManager_fillGridFromDataset'#10#10+s);

    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if sGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('Id',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  zFirstTime := true;
end;


procedure TfrmChannelManager.fillHolder;
begin
  initChannelManagerHolder(zData);
  zData.Id := m_.fieldbyname('ID').asInteger;
  zData.Code    := m_.fieldbyname('code').asstring;
  zData.Description    := m_.fieldbyname('Description').asstring;
  zData.serviceUsername := m_.fieldbyname('webserviceUsername').asstring;
  zData.webserviceURI := m_.fieldbyname('webserviceURI').asstring;
  zData.servicePassword := m_.fieldbyname('webservicePassword').asstring;
  zData.webserviceHotelCode := m_.fieldbyname('webserviceHotelCode').asstring;
  zData.serviceRequestorID := m_.fieldbyname('weserviceRequestor').asstring;

  zData.active := m_.fieldbyname('active').asBoolean;
  zData.sendRate := m_.fieldbyname('sendRate').asBoolean;
  zData.sendAvailability := m_.fieldbyname('sendAvailability').asBoolean;
  zData.sendStopSell := m_.fieldbyname('sendStopSell').asBoolean;
  zData.sendMinStay := m_.fieldbyname('sendMinStay').asBoolean;
  zData.maintenanceDays := m_.fieldbyname('maintenanceDays').asInteger;
  zData.directConnection := m_.fieldbyname('directConnection').asBoolean;

  zData.portalAdminUsername := m_.fieldbyname('adminUsername').asstring;
  zData.portalAdminPassword := m_.fieldbyname('adminPassword').asstring;
  zData.channels := m_.fieldbyname('channels').asstring;
end;

procedure TfrmChannelManager.changeAllowgridEdit;
begin
  tvDataRecId.Options.Editing := zAllowGridEdit;
  tvDataDescription.Options.Editing := zAllowGridEdit;
  tvDatawebserviceUsername.Options.Editing := zAllowGridEdit;
  tvDatawebservicePassword.Options.Editing := zAllowGridEdit;
  tvDatawebserviceURI.Options.Editing := zAllowGridEdit;
  tvDatawebserviceHotelCode.Options.Editing := zAllowGridEdit;
  tvDataweserviceRequestor.Options.Editing := zAllowGridEdit;
  tvDataadminUsername.Options.Editing := zAllowGridEdit;
  tvDataadminPassword.Options.Editing := zAllowGridEdit;
  tvDatachannels.Options.Editing := zAllowGridEdit;
  tvDataactive.Options.Editing := zAllowGridEdit;
  tvDatasendRate.Options.Editing := zAllowGridEdit;
  tvDatasendAvailability.Options.Editing := zAllowGridEdit;
  tvDatasendStopSell.Options.Editing := zAllowGridEdit;
  tvDatasendMinStay.Options.Editing := zAllowGridEdit;
  tvDatamaintenanceDays.Options.Editing := zAllowGridEdit;
  tvDatadirectConnection.Options.Editing := zAllowGridEdit;
end;


function TfrmChannelManager.GetPrevCode : string;
//Copy the cell value from the cell immediately above the focused cell
var
  AItem : TcxGridColumn;
  APrevRecordIndex, ThisRecordIndex : integer;
  ACycleChanged : boolean;
begin
   result := '';

  if tvData.Controller.FocusedRecord is TcxGridGroupRow then
    Exit;

  AItem := tvDataRecId;
  ThisRecordIndex := tvData.Controller.FocusedRecordIndex;
  APrevRecordIndex := tvData.Controller.FindNextRecord(ThisRecordIndex, False, False, ACycleChanged);

  if APrevRecordIndex <> -1 then
  begin
    APrevRecordIndex := tvData.ViewData.Records[APrevRecordIndex].RecordIndex;
    Result := tvData.DataController.Values[APrevRecordIndex, AItem.Index];
  end;
end;


Procedure TfrmChannelManager.ChkFilter;
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

procedure TfrmChannelManager.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  zFirstTime    := true;
  zAct          := actNone;
  zPostData     := false;
  zPostState    := 0;
end;

procedure TfrmChannelManager.FormShow(Sender: TObject);
begin
  //**
  panBtn.Visible := False;
  sbMain.Visible := false;
  btnClose.Visible := False;

  fillGridFromDataset(inttostr(zData.Id));
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

  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmChannelManager.FormDestroy(Sender: TObject);
begin
  //**
end;

procedure TfrmChannelManager.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //**
end;


procedure TfrmChannelManager.FormKeyPress(Sender: TObject; var Key: Char);
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
        btnCancel.Click;
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmChannelManager.m_AfterPost(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  if zPostState = 0 then
  begin
    fillgridFromDataset(zData.tmp);
    exit;
  end;

  if zPostData then
  begin
    try
      zData.Id := dataset.fieldbyname('ID').asInteger;
      zData.Code    := dataset.fieldbyname('code').asstring;
      zData.Description    := dataset.fieldbyname('Description').asstring;
      zData.serviceUsername := dataset.fieldbyname('webserviceUsername').asstring;
      zData.servicePassword := dataset.fieldbyname('webservicePassword').asstring;
      zData.webserviceURI := dataset.fieldbyname('webserviceURI').asstring;
      zData.webserviceHotelCode := dataset.fieldbyname('webserviceHotelCode').asstring;
      zData.serviceRequestorID := dataset.fieldbyname('weserviceRequestor').asstring;

      zData.active := dataset.fieldbyname('active').asBoolean;
      zData.sendRate := dataset.fieldbyname('sendRate').asBoolean;
      zData.sendAvailability := dataset.fieldbyname('sendAvailability').asBoolean;
      zData.sendStopSell := dataset.fieldbyname('sendStopSell').asBoolean;
      zData.sendMinStay := dataset.fieldbyname('sendMinStay').asBoolean;
      zData.maintenanceDays := dataset.fieldbyname('maintenanceDays').asInteger;
      zData.directConnection := dataset.fieldbyname('directConnection').asBoolean;

      zData.portalAdminUsername := dataset.fieldbyname('adminUsername').asstring;
      zData.portalAdminPassword := dataset.fieldbyname('adminPassword').asstring;
      zData.channels := dataset.fieldbyname('channels').asstring;

      if zPostState = 1 then
      begin
        if hdata.UPD_CHannelManager(zData) then
        begin
          // label1.Caption := 'Update OK';
          glb.ForceTableRefresh;
        end else
        begin
          // label1.Caption := 'Update NOT OK';
        end;
      end else
      if zPostState = 2 then
      begin
        if hdata.ins_ChannelManager(zData) then
        begin
          // label1.Caption := 'Insert OK';
          glb.ForceTableRefresh;
        end else
        begin
          // label1.Caption := 'insert NOT OK';
        end;
      end;
    finally
      zPostData  := false;
      zPostState := 0;
    end;
  end;
end;


procedure TfrmChannelManager.m_BeforeEdit(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  zData.tmp  := dataset.FieldByName('Id').AsString;
end;

procedure TfrmChannelManager.m_BeforePost(DataSet: TDataSet);
begin
  if zFirstTime then exit;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    zPostData := true;
    zPostState   := 1;

  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('Description').AsString = ''  then
    begin
      m_.DisableControls;
      try
        showmessage('Description is requierd - canceling insert - try again');
        dataset.cancel;
      finally
        m_.EnableControls;
      end;
      zPostData := false;
      zPostState := 0;
      exit;
    end;
    if dataset.FieldByName('code').AsString = ''  then
    begin
      m_.DisableControls;
      try
        showmessage('Code is requierd - canceling insert - try again');
        dataset.cancel;
      finally
        m_.EnableControls;
      end;
      zPostData := false;
      zPostState := 0;
      exit;
    end;

    zPostData := true;
    zPostState   := 2;
  end;
end;



procedure TfrmChannelManager.m_NewRecord(DataSet: TDataSet);
begin
end;


////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmChannelManager.tvDataChannelManagerPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Description').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    errortext := 'Description'+' - '+'is required - Use ESC to cancel';
    exit;
  end;
end;

procedure TfrmChannelManager.tvDatachannelsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  LookupForDataItem('Channels',
                    glb.ChannelsSet,
                    'id',
                    'name',
                    m_['channels'],
                    True,
                    True,
                    'active',
                    m_,
                    'channels');
end;

procedure TfrmChannelManager.tvDataCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if zAct = actLookup then
  begin
    btnOk.click;
  end else
  begin
    btnEdit.Click;
  end;
end;


procedure TfrmChannelManager.tvDataDataControllerSortingChanged(Sender: TObject);
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

///////////////////////////////////////////////////////////////////////////////
//  Filter
///////////////////////////////////////////////////////////////////////////////

procedure TfrmChannelManager.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmChannelManager.edFilterClickBtn(Sender: TObject);
begin
  edFilter.Text := '';
end;


procedure TfrmChannelManager.edFilterChange(Sender: TObject);
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


procedure TfrmChannelManager.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatawebserviceUsername,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatawebserviceHotelCode,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataadminUsername,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////

procedure TfrmChannelManager.btnDeleteClick(Sender: TObject);
var
  cNumber : string;
  cDescription : string;
  s : string;

  prevCode : string;
  currCode : string;

begin
  cNumber      := m_.fieldbyname('Id').asstring;
  cDescription := m_.fieldbyname('Description').asstring;

  s := '';
  s := s+GetTranslatedText('shDeleteChannelManager')+' '+cNumber+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    screen.Cursor := crHourGlass;
    try
      currCode := cNumber;
      prevCode := GetPrevCode;

      if hdata.Del_ChannelManagerByID(m_.fieldbyname('Id').asinteger) then
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

procedure TfrmChannelManager.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
  showmessage('edit in grid');
end;

procedure TfrmChannelManager.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('Description').Focused := True;
end;

procedure TfrmChannelManager.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmChannelManager.btnCancelClick(Sender: TObject);
begin
  initChannelManagerHolder(zData);
end;

procedure TfrmChannelManager.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmChannelManager.btnCloseClick(Sender: TObject);
begin
   if m_.State IN [dsEdit, dsInsert] then
     m_.post;
  fillHolder;
end;

procedure TfrmChannelManager.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmChannelManager.Button1Click(Sender: TObject);
begin
    EditPaymentAssuranceForChannels;
end;

procedure TfrmChannelManager.Button2Click(Sender: TObject);
begin
    EditChannelsEmailConfirmationMatrix;
end;

procedure TfrmChannelManager.Button3Click(Sender: TObject);
begin
  EditChannelsHotelEmailMatrix;
end;

////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmChannelManager.mnuiAllowGridEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmChannelManager.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmChannelManager.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmChannelManager.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmChannelManager.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmChannelManager.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

end.
