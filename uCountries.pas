unit uCountries;

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

  , hData
  , uAppGlobal
  , _glob
  , ug

  , PrjConst
  , cmpRoomerDataSet
  , cmpRoomerConnection


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
  , cxButtonEdit
  , cxPropertiesStore

  , sLabel
  , sCustomComboEdit
  , uUtils
  , sButton
  , sPanel
  , sEdit
  , sCheckBox
  , sSpeedButton
  , sComboEdit


  , dxSkinsCore
  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters
  , dxSkinscxPCPainter
  , dxSkinsdxBarPainter
  , dxSkinsdxRibbonPainter, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxPScxPivotGridLnk, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue



  ;



type
  TfrmCountries = class(TForm)
    sbMain: TStatusBar;
    PanTop: TsPanel;
    panBtn: TsPanel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
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
    DS: TDataSource;
    grData: TcxGrid;
    lvData: TcxGridLevel;
    tvData: TcxGridDBBandedTableView;
    tvDataCountry: TcxGridDBBandedColumn;
    tvDataCountryName: TcxGridDBBandedColumn;
    tvDataCurrency: TcxGridDBBandedColumn;
    tvDataOrderIndex: TcxGridDBBandedColumn;
    tvDataIslCountryName: TcxGridDBBandedColumn;
    tvDataCountryGroup: TcxGridDBBandedColumn;
    m_: TdxMemData;
    m_CountryName: TWideStringField;
    m_Country: TWideStringField;
    m_islCountryName: TWideStringField;
    m_Currency: TWideStringField;
    m_CountryGroup: TWideStringField;
    m_OrderIndex: TIntegerField;
    tvDataRecId: TcxGridDBBandedColumn;
    m_CurrenciesDescription: TWideStringField;
    m_CountryGroupsGroupName: TWideStringField;
    tvDataCurrenciesDescription: TcxGridDBBandedColumn;
    tvDataCountryGroupsGroupName: TcxGridDBBandedColumn;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    labInfo2: TLabel;
    sPanel1: TsPanel;
    BtnOk: TsButton;
    btnCancel: TsButton;
    FormStore: TcxPropertiesStore;
    m_active: TBooleanField;
    m_ID: TIntegerField;
    tvDataactive: TcxGridDBBandedColumn;
    tvDataID: TcxGridDBBandedColumn;
    chkActive: TsCheckBox;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    pnlHolder: TsPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure tvDataCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure edFilterClickBtn(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataCountryGroupPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataCountryPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure chkActiveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure m_AfterPost(DataSet: TDataSet);

  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zPostData        : boolean;
//    zPostState       : integer;
//    zFilterOn          : boolean;
    zSortStr           : string;

    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    procedure ApplyFilter;
  public
    { Public declarations }
    zAct               : TActTableAction;
    zData              : recCountryHolder;


    embedded : Boolean;
    EmbedWindowCloseEvent : TNotifyEvent;

    procedure PrepareUserInterface;
    procedure BringWindowToFront;
  end;


function Countries(act : TActTableAction; var theData : recCountryHolder; embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil) : boolean;
function getCountry(ed : TsEdit; lab : TsLabel) : boolean; overload;
function getCountry(ed : TsComboEdit; lab : TsLabel) : boolean; overload;
function countryValidate(ed : TsEdit; lab : TsLabel) : boolean; overload;
function countryValidate(ed : TsComboEdit; lab : TsLabel) : boolean; overload;

var
  frmCountries: TfrmCountries;
  frmCountriesX: TfrmCountries;

implementation

uses
  uD
  , uMessageList
  , uCountryGroups
  , uCurrencies
  , uSqlDefinitions
  , uDimages
  , UITypes
  ;

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function Countries(act : TActTableAction; var theData : recCountryHolder; embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil) : boolean;
var _frmCountries: TfrmCountries;
begin
  result := false;
  _frmCountries := TfrmCountries.Create(nil);
  try
    _frmCountries.zData := theData;
    _frmCountries.zAct := act;
    _frmCountries.embedded := (act = actNone) AND
                                    (embedPanel <> nil);
    _frmCountries.EmbedWindowCloseEvent := WindowCloseEvent;
    if _frmCountries.embedded then
    begin
      _frmCountries.pnlHolder.parent := embedPanel;
      embedPanel.Update;
      frmCountriesX := _frmCountries;
    end
    else
    begin
      _frmCountries.PrepareUserInterface;
      _frmCountries.ShowModal;
      if _frmCountries.modalresult = mrOk then
      begin
        theData := _frmCountries.zData;
        result := true;
      end
      else
      begin
        initCountryHolder(theData);
      end;
    end;
  finally
    if (act <> actNone) OR
      (embedPanel = nil) then
      freeandnil(_frmCountries);
  end;
end;

function getCountry(ed : TsEdit; lab : TsLabel) : boolean;
var
  theData : recCountryHolder;
begin
  //*TESTED*//
    initCountryHolder(theData);
    theData.country := trim(ed.text);
    result := countries(actLookup,theData);

    if trim(theData.country) = trim(ed.text) then
    begin
      result := false;
      exit;
    end;

    if result and (theData.country <> ed.text) then
    begin
      ed.text := theData.country;
      lab.Caption := theData.CountryName;
    end;
end;

function getCountry(ed : TsComboEdit; lab : TsLabel) : boolean;
var
  theData : recCountryHolder;
begin
  //*TESTED*//
  initCountryHolder(theData);
  theData.country := trim(ed.text);
  result := countries(actLookup,theData);

  if trim(theData.country) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (theData.country <> ed.text) then
  begin
    ed.text := theData.country;
    lab.Caption := theData.CountryName;
  end;
end;


function countryValidateCode(country : String; lab : TsLabel) : boolean;
var
  sValue : string;
begin
  //*NOT TESTED*//
  result := glb.LocateSpecificRecordAndGetValue('countries', 'Country', country, 'CountryName', sValue);
  if result then
  begin
    lab.Color := clBtnFace;
    lab.caption := sValue;
  end;
end;

function countryValidate(ed : TsEdit; lab : TsLabel) : boolean;
begin
  //*NOT TESTED*//
  Result := countryValidateCode(ed.Text, lab);
  if NOT Result then
  begin
    if ed.Showing then
      ed.SetFocus;
    lab.Color := clRed;
    lab.caption := GetTranslatedText('shNotF_star');
  end;

end;
//END unit global functions

function countryValidate(ed : TsComboEdit; lab : TsLabel) : boolean;
begin
  //*NOT TESTED*//
  Result := countryValidateCode(ed.Text, lab);
  if NOT Result then
  begin
    if ed.Showing then
      ed.SetFocus;
    lab.Color := clRed;
    lab.caption := GetTranslatedText('shNotF_star');
  end;
end;

///////////////////////////////////////////////////////////////////////\\
//                                                                     ||
/////////////////////////////////////////////////////////////////////////

Procedure TfrmCountries.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
begin
  zfirstTime := true;
  active := chkActive.Checked;
  screen.Cursor := crHourGlass;
  m_.DisableControls;
  try
    zFirstTime := true;
    if zSortStr = '' then zSortStr := 'OrderIndex DESC ';

    rSet := CreateNewDataSet;
    try
      s := format(select_Countries_fillGridFromDataset, [ord(active),zSortStr]);
//      DebugMessage(s);
//      copyToClipboard(s);
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
            m_.Locate('Country',sGoto,[]);
          except
          end;
        end;
      end;
    finally
      freeandnil(rSet);
    end;
  finally
    m_.EnableControls;
    screen.Cursor := crDefault;
  end;
  zFirstTime := false;
end;

procedure TfrmCountries.fillHolder;
begin
  initCountryHolder(zData);
  zData.Country                  := m_.fieldbyname('Country').asstring;
  zData.CountryName              := m_.fieldbyname('CountryName').asstring;
  zData.IslCountryName           := m_.fieldbyname('IslCountryName').asstring;
  zData.Currency                 := m_.fieldbyname('Currency').asstring;
  zData.CountryGroup             := m_.fieldbyname('CountryGroup').asstring;
  zData.OrderIndex               := m_.fieldbyname('OrderIndex').asInteger;
  zData.CurrenciesDescription    := m_.fieldbyname('CurrenciesDescription').asstring;
  zData.CountryGroupsGroupName   := m_.fieldbyname('CountryGroupsGroupName').asstring;
  zData.Active                   := m_['Active'];
  zData.ID                       := m_.fieldbyname('ID').asInteger;
end;

procedure TfrmCountries.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive.Options.Editing         := true;
    tvDataCountry.Options.Editing        := true;
    tvDataCountryName.Options.Editing    := true;
    tvDataislCountryName.Options.Editing := true;
    tvDataOrderIndex.Options.Editing     := true;
    tvDataCountryGroup.Options.Editing   := true;
    tvDataCurrency.Options.Editing       := true;

    tvDataCountryGroupsGroupName.Options.Editing := false;
    tvDataCurrenciesDescription.Options.Editing  := false;
  end else
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive.Options.Editing         := false;

    tvDataCountry.Options.Editing        := false;
    tvDataCountryName.Options.Editing    := false;
    tvDataislCountryName.Options.Editing := false;
    tvDataOrderIndex.Options.Editing     := true;

    tvDataCountryGroup.Options.Editing   := true;
    tvDataCurrency.Options.Editing       := true;

    tvDataCountryGroupsGroupName.Options.Editing := false;
    tvDataCurrenciesDescription.Options.Editing  := false;
  end;
end;

procedure TfrmCountries.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.Country);
  zFirstTime := false;
end;


procedure TfrmCountries.edFilterChange(Sender: TObject);
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


procedure TfrmCountries.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataCountry,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataCountryName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataIslCountryName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

///////////////////////////////////////////////////////////////
//  Form actions
///////////////////////////////////////////////////////////////

procedure TfrmCountries.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;

  pnlHolder.Parent := self;
  update;
  if embedded then
    Action := caFree;
  if Assigned(EmbedWindowCloseEvent) then
    EmbedWindowCloseEvent(self);
end;

procedure TfrmCountries.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  zFirstTime  := true;
  zAct        := actNone;

  PrepareUserInterface;
end;




procedure TfrmCountries.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;
end;

procedure TfrmCountries.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if key = chr(13) then
    begin
      if activecontrol = edFilter then
      begin
      end else
      if ZAct = actLookup then
      begin
       btnOk.click;
      end;
    end;

    if key = chr(27) then
    begin
      if activecontrol = edFilter then
      begin
      end else
      if ZAct = actLookup then
      begin
        btnCancel.click;
      end;
    end;
end;

////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////





procedure TfrmCountries.m_AfterPost(DataSet: TDataSet);
begin
  if not m_.ControlsDisabled then
    glb.RefreshTableByName('countries');
end;

procedure TfrmCountries.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.CountryExistsInOther(zData.country) then
  begin
    Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Country', zData.CountryName]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteItem')+' '+zData.CountryName+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_CountryByCountry(zData.Country) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmCountries.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('country').Focused := True;
end;


procedure TfrmCountries.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;
  initCountryHolder(zData);
  zData.ID                  := dataset.FieldByName('ID').AsInteger;
  zData.Country             := dataset['country'];
  zData.CountryName         := dataset['CountryName'];
  zData.IslCountryName      := dataset['IslCountryName'];
  zData.Currency            := dataset['Currency'];
  zData.CountryGroup        := dataset['CountryGroup'];
  zData.OrderIndex          := dataset['OrderIndex'];
  zData.Active              := dataset['Active'];

  if Dataset.State = dsEdit then
  begin
    if not UPD_country(zData) then
      abort;
  end;
  if Dataset.State = dsInsert then
  begin
    if dataset.FieldByName('Country').AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shTx_Countries_CodeRequired'));
      tvData.GetColumnByFieldName('country').Focused := True;
      abort;
    end
    else if ins_Country(zData,nID) then
      m_.FieldByName('ID').AsInteger := nID
    else
      abort;
  end;
end;

procedure TfrmCountries.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']              := true;
  dataset['Country']             := '';
  dataset['CountryName']         := '';
  dataset['IslCountryName']      := '';
  dataset['Currency']            := '';
  dataset['CountryGroup']        := '';
  dataset['OrderIndex']          := 0;
end;

procedure TfrmCountries.PrepareUserInterface;
begin
  panBtn.Visible := False;
  sbMain.Visible := false;
  btnClose.Visible := False;

  fillGridFromDataset(zData.Country);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end else
  begin
    mnuiAllowGridEdit.Checked := true;
    btnClose.Visible := embedded;
    sbMain.Visible := true;
  end;

  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  zFirstTime := false;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmCountries.tvDataCountryPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('country').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    //errortext := 'Country code'+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_Countries_CountryCodeIsRequired');
    exit;
  end;

  if hdata.CountryExists(displayValue) then
  begin
    error := true;
    //errortext := displayvalue+'N�tt gildi er til � annari f�rslu. Noti� ESC-hnappin til a� h�tta vi�';
    errortext := displayvalue+' - '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit;
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.CountryExistsInOther(currValue) then
    begin
      error := true;
      // errortext := displayvalue+'Eldra gildi fannst � tengdri f�rslu ekki h�gt a� breyta - Noti� 'ESC-hnappin til a� h�tta vi�';
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;


procedure TfrmCountries.tvDataCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
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

procedure TfrmCountries.tvDataCountryGroupPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recCountryGroupHolder;
begin
  countryGroups(actlookup,theData);
  if theData.CountryGroup <> '' then
  begin
    zPostData := true;
    m_.Edit;
    m_.FieldByName('CountryGroup').asString := theData.CountryGroup;
    m_.FieldByName('CountryGroupsGroupName').AsString := theData.GroupName;
    m_.Post;
  end;
end;


procedure TfrmCountries.tvDataCurrencyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recCurrencyHolder;
begin
  fillholder;
  theData.Currency := zData.Currency;
  theData.Description := zData.CurrenciesDescription;
  currencies(actlookup,theData);
  if theData.Currency <> '' then
  begin
    zPostData := true;
    m_.Edit;
    m_.FieldByName('currency').asString := theData.Currency;
    m_.FieldByName('CurrenciesDescription').AsString := theData.Description;
    m_.Post;
  end;
end;

procedure TfrmCountries.tvDataDataControllerSortingChanged(Sender: TObject);
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

//**************************************************************************
//  Filter
//***************************************************************************

procedure TfrmCountries.edFilterClickBtn(Sender: TObject);
begin
  edFilter.Text := '';
end;



//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////

procedure TfrmCountries.BtnOkClick(Sender: TObject);
begin
  //
  fillHolder;
end;


procedure TfrmCountries.BringWindowToFront;
begin
  pnlHolder.BringToFront;
end;

procedure TfrmCountries.btnCancelClick(Sender: TObject);
begin
  initCountryHolder(zData);
end;

procedure TfrmCountries.btnCloseClick(Sender: TObject);
begin
  if embedded then
    Close;
end;

procedure TfrmCountries.btnDeleteClick(Sender: TObject);
begin
  m_.delete;
end;

procedure TfrmCountries.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Countryname').Focused := True;
  showmessage(GetTranslatedText('shTx_Items2_EditInGrid'));
end;

procedure TfrmCountries.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('country').Focused := True;
end;


////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmCountries.mnuiAllowGridEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmCountries.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmCountries.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmCountries.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmCountries.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmCountries.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

end.
