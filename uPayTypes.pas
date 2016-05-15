unit uPayTypes;

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
  , cxVariants
  , cxDataUtils
  , cxButtonEdit
  , cxCheckBox


  , PrjConst
  , uD

  , cmpRoomerDataSet
  , cmpRoomerConnection
  , sSkinProvider
  , sButton
  , sLabel
  , sPanel
  , sStatusBar
  , sComboEdit
  , sCheckBox
  , sSpeedButton, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, sEdit, dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue



  ;

type
  TfrmPayTypes = class(TForm)
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
    m_payType: TWideStringField;
    m_PayGroup: TWideStringField;
    m_Description: TWideStringField;
    m_AskCode: TBooleanField;
    m_ptDays: TIntegerField;
    m_doExport: TBooleanField;
    m_payGroupDescription: TWideStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDatapayType: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataPayGroup: TcxGridDBColumn;
    tvDatapayGroupDescription: TcxGridDBColumn;
    tvDataAskCode: TcxGridDBColumn;
    tvDataptDays: TcxGridDBColumn;
    tvDatadoExport: TcxGridDBColumn;
    sLabel1: TsLabel;
    m_ID: TIntegerField;
    m_Active: TBooleanField;
    btnInsert: TsButton;
    btnEdit: TsButton;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    chkActive: TsCheckBox;
    tvDataID: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    FormStore: TcxPropertiesStore;
    m_BookKey: TStringField;
    tvDataBookKey: TcxGridDBColumn;
    m_BookKeepCode: TWideStringField;
    tvDataBookKeepCode: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
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
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure tvDatapayTypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataPayGroupPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure btnClearClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure tvDataBookKeyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvDataBookKeepCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    financePayTypeList : TKeyPairList;
    zFirstTime       : boolean;

    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    Lookup : Boolean;

    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;
  public
    { Public declarations }
    zAct               : TActTableAction;
    zData              : recpayTypeHolder;
  end;

function payType(act : TActTableAction; Lookup : Boolean; var theData : recpayTypeHolder) : boolean;
function getpayType(ed : TsComboEdit; lab : TsLabel) : boolean;
function payTypeValidate(ed : TsComboEdit; lab: TsLabel) : boolean;

var
  frmPayTypes: TfrmPayTypes;

implementation

uses
  uPayGroups
  , uSqlDefinitions
  , uDImages
  , uFrmKeyPairSelector
  , uBookKeepingCodes
  , uUtils
  ;

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function payType(act : TActTableAction; Lookup : Boolean; var theData : recpayTypeHolder) : boolean;
begin
  result := false;
  frmPayTypes := TfrmpayTypes.Create(frmpayTypes);
  try
    frmpayTypes.zData := theData;
    frmpayTypes.Lookup := Lookup;
    frmpayTypes.zAct := act;
    frmpayTypes.ShowModal;
    if frmpayTypes.modalresult = mrOk then
    begin
      theData := frmpayTypes.zData;
      result := true;
    end
    else
    begin
      initpayTypeHolder(theData);
    end;
  finally
    freeandnil(frmpayTypes);
  end;
end;


function getpayType(ed : TsComboEdit; lab : TsLabel) : boolean;
var
  theData : recpayTypeHolder;
begin
  result := false;
  initpayTypeHolder(theData);
  theData.payType := trim(ed.text);
  result := payType(actLookup, true, theData);

  if trim(theData.payType) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (theData.payType <> ed.text) then
  begin
    ed.text := theData.payType;
    lab.Caption := theData.Description;
  end;
end;


function payTypeValidate(ed : TsComboEdit; lab : TsLabel) : boolean;
var
  sValue : string;
  pcCode : string;
  theData : recpayTypeHolder;
begin
  initpayTypeHolder(theData);
  theData.payType := trim(ed.Text);
  result := hdata.GET_payTypeHolder(theData);

  if not result then
  begin
    ed.SetFocus;
    lab.Color := clRed;
    lab.caption := GetTranslatedText('shNotF_star');
  end else
  begin
    lab.Color := clBtnFace;
    lab.caption := theData.Description;
  end;
end;
//END unit global functions

///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////

Procedure TfrmPayTypes.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
  PayType : string;
begin
  active := chkActive.Checked;
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'payType ';
  rSet := CreateNewDataSet;
  try
    s := format(select_PayTypes_fillGridFromDataset_byActive ,[ord(active),zSortStr]);
    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.open;
//      m_.LoadFromDataSet(rSet);
      rSet.first;
      while not rSet.eof do
      begin
        m_.insert;
        m_.fieldbyname('PayType'     ).asstring := rset.fieldbyname('PayType'      ).asstring;
        m_.fieldbyname('Description' ).asstring := rset.fieldbyname('Description'  ).asstring;
        m_.fieldbyname('PayGroup'    ).asstring := rset.fieldbyname('PayGroup'     ).asstring;
        m_.fieldbyname('AskCode'     ).asBoolean := rset.fieldbyname('AskCode'     ).asBoolean;
        m_.fieldbyname('ptDays'      ).asInteger := rset.fieldbyname('ptDays'      ).asInteger;
        m_.fieldbyname('doExport'    ).asBoolean := rset.fieldbyname('doExport'    ).asBoolean;
        m_.fieldbyname('Active'      ).asBoolean := rset.fieldbyname('Active'      ).asBoolean;
        m_.fieldbyname('BookKey'     ).asstring := rset.fieldbyname('BookKey'      ).asstring;
        m_.fieldbyname('BookKeepCode').asstring := rset.fieldbyname('BookKeepCode' ).asstring;
        m_.fieldbyname('ID'          ).asstring := rset.fieldbyname('ID'           ).asstring;
        m_.post;
        rSet.next;
      end;
      if sGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('payType',sGoto,[]);
        except
        end;
      end;
    end;




//    rSet.First;
//    while not rSet.Eof do
//    begin
//      PayType :=  rSet.FieldByName('PayType').asstring;
//      if M_.locate('payType',payType,[]) then
//      begin
//        m_.Edit;
//        m_.FieldByName('BookKey').asString := rSet.FieldByName('BookKey').asString;
//        m_.Post;
//      end;
//
//      rSet.next;
//    end;

  finally
    freeandnil(rSet);
  end;
end;

procedure  TfrmPayTypes.fillHolder;
begin
  initpayTypeHolder(zData);
  zData.ID                  := m_.fieldbyname('ID').asInteger;
  zData.payType             := m_.fieldbyname('payType').asstring;
  zData.Description         := m_.fieldbyname('Description').asstring;
  zData.PayGroup            := m_.fieldbyname('PayGroup').asString;
  zData.BookKey             := m_.fieldbyname('BookKey').asString;
  zData.BookKeepCode        := m_.fieldbyname('BookKeepCode').asString;
  zData.AskCode             := m_['AskCode'];
  zData.ptDays              := m_.fieldbyname('ptDays').asInteger;
  zData.doExport            := m_['doExport'];
  zData.active              := m_['active'];
end;

procedure TfrmPayTypes.changeAllowgridEdit;
begin
  tvDatapayType    .Options.Editing    := zAllowGridEdit;
  tvDataDescription.Options.Editing    := zAllowGridEdit;
  tvDataPayGroup   .Options.Editing    := zAllowGridEdit;
  tvDataBookKey    .Options.Editing    := zAllowGridEdit;
  tvDataBookKeepCode.Options.Editing    := zAllowGridEdit;
  tvDataAskCode    .Options.Editing    := zAllowGridEdit;
  tvDataptDays     .Options.Editing    := zAllowGridEdit;
  tvDatadoExport   .Options.Editing    := zAllowGridEdit;
  tvDataActive     .Options.Editing    := zAllowGridEdit;
end;


procedure TfrmPayTypes.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.payType);
  zFirstTime := false;
end;

Procedure TfrmPayTypes.ChkFilter;
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


procedure TfrmPayTypes.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDatapayType    ,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataPayGroup   ,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataBookKey    ,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataBookKeepCode, foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmPayTypes.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmPayTypes.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  Lookup := False;
  zFirstTime  := true;
  zAct        := actNone;
  financePayTypeList := nil;
end;

procedure TfrmPayTypes.FormShow(Sender: TObject);
begin
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.payType);
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

procedure TfrmPayTypes.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TfrmPayTypes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmPayTypes.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmPayTypes.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;

  if hdata.payTypeExistsInOther(zData.PayType) then
  begin
    Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['payType', zData.Description]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteCurrency')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_payType(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmPayTypes.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('payType').Focused := True;
end;

procedure TfrmPayTypes.m_BeforePost(DataSet: TDataSet);
var
  NewID : integer;
begin
  if zFirstTime then exit;

  newId := 0;

  initpayTypeHolder(zData);
  zData.payType      := dataset.fieldbyname('payType').asstring;
  zData.Description  := dataset.fieldbyname('Description').asstring;
  zData.PayGroup     := dataset.fieldbyname('PayGroup').asString;
  zData.BookKey      := dataset.fieldbyname('BookKey').asString;
  zData.BookKeepCode := dataset.fieldbyname('BookKeepCode').asString;
  zData.AskCode      := dataset['AskCode'];
  zData.active       := dataset['active'];
  zData.ptDays       := dataset.fieldbyname('ptDays').asInteger;
  zData.doExport     := dataset['doExport'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_payType(zData) then
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

    if dataset.FieldByName('payType').AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shTx_PayTypes_PayTypeRequired'));
      tvData.GetColumnByFieldName('payType').Focused := True;
      abort;
      exit;
    end;

    if dataset.FieldByName('payGroup').AsString = ''  then
    begin
  	  showmessage(GetTranslatedText('shTx_PayTypes_PayGroupRequired'));
      tvData.GetColumnByFieldName('payGroup').Focused := True;
      abort;
      exit;
    end;

    if ins_payType(zData, newID) then
    begin
      m_.FieldByName('ID').AsInteger := newID;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;

procedure TfrmPayTypes.m_NewRecord(DataSet: TDataSet);
begin
  dataset.fieldbyname('payType').asString := '';
  dataset.fieldbyname('Description').asString := '';
  dataset.fieldbyname('payGroup').asString := '';
  dataset.fieldbyname('BookKey').asString := '';
  dataset.fieldbyname('BookKeepCode').asString := '';
  dataset.fieldbyname('payGroupDescription').asString := '';
  dataset.fieldbyname('ptDays').asInteger   := 0;
  dataset['AskCode']  := false;
  dataset['doExport'] := true;
  dataset['Active'] := true;
  dataset.fieldbyname('ID').asInteger   := 0;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmPayTypes.tvDatapayTypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('payType').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
   // errortext := 'payType code '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_PayTypes_PayTypeCodeIsRequired');
    exit;
  end;

  if hdata.payTypeExist(displayValue) then
  begin
    error := true;
    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

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


procedure TfrmPayTypes.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end else
  begin
    btnedit.click
  end;
end;

procedure TfrmPayTypes.tvDataPayGroupPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recPayGroupHolder;
begin
  fillholder;
  theData.payGroup := zData.PayGroup;
  payGroup(actlookup,theData);
  tvdata.DataController.Edit;
  tvdata.DataController.SetEditValue(tvData.Controller.FocusedColumnIndex+1,thedata.payGroup,evsValue);
//  tvdata.DataController.post;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmPayTypes.tvDataBookKeepCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var s : String;
begin
  s := '';
  if NOT m_.Eof then
    s := m_['BookKeepCode'];
  s := BookKeepingCodes(actLookUp, s);
  if s <> '' then
  begin
    m_.Edit;
    m_['BookKeepCode'] := s;
    m_.Post;
  end;
end;

procedure TfrmPayTypes.tvDataBookKeyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  PayBookKeyValue : string;
  keyValue : TKeyAndValue;
begin
  if NOT assigned(financePayTypeList) then
    financePayTypeList := d.RetrieveFinancesKeypair(FKP_PAYTYPES);

  payBookKeyValue := m_.fieldbyname('bookKey').AsString;
  keyValue := selectFromKeyValuePairs('Payment types', payBookKeyValue, financePayTypeList);
  if Assigned(keyValue) then
  begin
    m_.Edit;
    m_.fieldbyname('bookKey').AsString := keyValue.Key;
    m_.Post;
  end else
  begin
    //NotOK
  end;
//  if d.roomerMainDataSet.SystemCheckAccountPayBookKeyExists(PayBookKeyValue) then
//  begin
//    //OK
//  end else
//  begin
//    //NotOK
//  end;
end;

//procedure TfrmPayTypes.tvDataBookKeyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
//var
//  PayBookKeyValue : string;
//  keyValue : TKeyAndValue;
//begin
//  if NOT assigned(financePayTypeList) then
//    financePayTypeList := d.RetrieveFinancesKeypair(FKP_PAYTYPES);
//
//  payBookKeyValue := m_.fieldbyname('bookKey').AsString;
//  keyValue := selectFromKeyValuePairs('Payment types', payBookKeyValue, financePayTypeList);
//  if Assigned(keyValue) then
//  begin
//    m_.Edit;
//    m_.fieldbyname('bookKey').AsString := keyValue.Key;
//    m_.Post;
//  end else
//  begin
//    //NotOK
//  end;
////  if d.roomerMainDataSet.SystemCheckAccountPayBookKeyExists(PayBookKeyValue) then
////  begin
////    //OK
////  end else
////  begin
////    //NotOK
////  end;
//end;


procedure TfrmPayTypes.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmPayTypes.tvDataDataControllerSortingChanged(Sender: TObject);
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

procedure TfrmPayTypes.edFilterChange(Sender: TObject);
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

procedure TfrmPayTypes.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmPayTypes.btnCancelClick(Sender: TObject);
begin
  initpayTypeHolder(zData);
end;

procedure TfrmPayTypes.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmPayTypes.btnOtherClick(Sender: TObject);
begin
  //
end;

procedure TfrmPayTypes.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('payyType').Focused := True;
  showmessage(GetTranslatedText('shTx_PayTypes_EditInGrid'));
end;

procedure TfrmPayTypes.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('payType').Focused := True;
end;

procedure TfrmPayTypes.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmPayTypes.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;

  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmPayTypes.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmPayTypes.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmPayTypes.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmPayTypes.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmPayTypes.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;


end.

