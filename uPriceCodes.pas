unit uPriceCodes;

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

  , hData
  , uAppGlobal
  , _glob
  , ug
  , uD
  , uDImages

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

  , AdvEdit
  , AdvEdBtn

  , PrjConst, cxButtonEdit, cxCheckBox

  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, sEdit, sButton, sSpeedButton,
  sLabel, sPanel, sStatusBar, dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld
  ;

type
  TfrmPriceCodes = class(TForm)
    sbMain: TsStatusBar;
    PanTop: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
    labFilterWarning: TsLabel;
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
    m_ID: TIntegerField;
    m_pcCode: TWideStringField;
    m_pcDescription: TWideStringField;
    m_pcRack: TBooleanField;
    m_pcRackCalc: TFloatField;
    m_pcShowDiscount: TBooleanField;
    m_pcDiscountText: TWideStringField;
    m_pcAutomatic: TBooleanField;
    m_pcLastUpdate: TDateTimeField;
    m_pcDiscountMethod: TIntegerField;
    m_pcDiscountPriceAfter: TFloatField;
    m_pcDiscountDaysAfter: TIntegerField;
    m_Active: TBooleanField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDatapcCode: TcxGridDBColumn;
    tvDatapcDescription: TcxGridDBColumn;
    tvDatapcRack: TcxGridDBColumn;
    tvDatapcRackCalc: TcxGridDBColumn;
    tvDatapcShowDiscount: TcxGridDBColumn;
    tvDatapcDiscountText: TcxGridDBColumn;
    tvDatapcAutomatic: TcxGridDBColumn;
    tvDatapcLastUpdate: TcxGridDBColumn;
    tvDatapcDiscountMethod: TcxGridDBColumn;
    tvDatapcDiscountPriceAfter: TcxGridDBColumn;
    tvDatapcDiscountDaysAfter: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    btnInsert: TsButton;
    btnEdit: TsButton;
    FormStore: TcxPropertiesStore;
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
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure tvDatapcCodePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDatapcRackPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnClearClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
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
    Procedure chkFilter;
    procedure applyFilter;
  public
    { Public declarations }
    zAct               : TActTableAction;
    zData              : recPriceCodeHolder;
  end;

function priceCodes(act : TActTableAction; var theData : recPriceCodeHolder) : boolean;
function getPriceCode(ed : TAdvEdit; lab : TsLabel) : boolean;  overload;
function getPriceCode(ed : TDBEdit; lab : TsLabel) : boolean;  overload;
function getPriceCode(ed : TEdit; lab : TsLabel) : boolean; overload;
function getPriceID(ed : TDBEdit; lab : TsLabel) : boolean;
function priceCodeValidate(ed : TAdvEdit; lab: TsLabel) : boolean;

var
  frmPriceCodes: TfrmPriceCodes;

implementation

uses
   uSqlDefinitions
   ;

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function priceCodes(act : TActTableAction; var theData : recPriceCodeHolder) : boolean;
begin
  result := false;
  frmPriceCodes := TfrmPriceCodes.Create(frmPriceCodes);
  try
    frmPriceCodes.zData := theData;
    frmPriceCodes.zAct := act;
    frmPriceCodes.ShowModal;
    if frmPriceCodes.modalresult = mrOk then
    begin
      theData := frmPriceCodes.zData;
      result := true;
    end
    else
    begin
      initPriceCodeHolder(theData);
    end;
  finally
    freeandnil(frmPriceCodes);
  end;
end;

function getPriceCode(ed : TAdvEdit; lab : TsLabel) : boolean;
var
  theData : recPriceCodeHolder;
begin
  result := false;
  initPriceCodeHolder(theData);
  theData.pcCode := trim(ed.text);
  result := priceCodes(actLookup,theData);

  if trim(theData.pcCode) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (theData.pcCode <> ed.text) then
  begin
    ed.text := theData.pcCode;
    lab.Caption := theData.pcDescription;
  end;
end;


function getPriceCode(ed : TDBEdit; lab : TsLabel) : boolean;
var
  theData : recPriceCodeHolder;
begin
  result := false;
  initPriceCodeHolder(theData);
  theData.pcCode := trim(ed.text);
  result := priceCodes(actLookup,theData);

  if trim(theData.pcCode) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (theData.pcCode <> ed.text) then
  begin
    ed.text := theData.pcCode;
    lab.Caption := theData.pcDescription;
  end;
end;


function getPriceCode(ed : TEdit; lab : TsLabel) : boolean;
var
  theData : recPriceCodeHolder;
begin
  result := false;
  initPriceCodeHolder(theData);
  theData.pcCode := trim(ed.text);
  result := priceCodes(actLookup,theData);

  if trim(theData.pcCode) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (theData.pcCode <> ed.text) then
  begin
    ed.text := theData.pcCode;
    lab.Caption := theData.pcDescription;
  end;
end;


function getPriceID(ed : TDBEdit; lab : TsLabel) : boolean;
var
  theData : recPriceCodeHolder;
  ID : integer;
begin
  try
    Id := strToInt(ed.Text);
  Except
    id := priceCode_RackID();
  end;
  result := false;
  initPriceCodeHolder(theData);
  theData.ID := id;
  result := priceCodes(actLookup,theData);

  if theData.id = id then
  begin
    result := false;
    exit;
  end;

  if result and (theData.Id <> id) then
  begin
    ed.text := inttostr(theData.Id);
    lab.Caption := theData.pcDescription;
  end;
end;


function priceCodeValidate(ed : TAdvEdit; lab : TsLabel) : boolean;
var
  sValue : string;
  pcCode : string;
  theData : recPriceCodeHolder;
begin
  initPriceCodeHolder(theData);
  theData.pcCode := trim(ed.Text);
  result := hdata.GET_priceCodeHolder(theData);
  if not result then
  begin
    ed.SetFocus;
    lab.Color := clRed;
    lab.caption := GetTranslatedText('shNotF_star');
  end else
  begin
    lab.Color := clBtnFace;
    lab.caption := theData.pcDescription;
  end;
end;
//END unit global functions

///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////


Procedure TfrmPriceCodes.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'pcCode ';

//  s := '';
//  s := s+ ' SELECT '+#10;
//  s := s+ '  ID '+#10;
//  s := s+ ' ,pcCode '+#10;
//  s := s+ ' ,pcDescription '+#10;
//  s := s+ ' ,pcActive '+#10;
//  s := s+ ' ,pcRack '+#10;
//  s := s+ ' ,pcRackCalc '+#10;
//  s := s+ ' ,pcShowDiscount '+#10;
//  s := s+ ' ,pcDiscountText '+#10;
//  s := s+ ' ,pcAutomatic '+#10;
//  s := s+ ' ,pcLastUpdate '+#10;
//  s := s+ ' ,pcDiscountMethod '+#10;
//  s := s+ ' ,pcDiscountPriceAfter '+#10;
//  s := s+ ' ,pcDiscountDaysAfter '+#10;
//  s := s+ ' ,Active '+#10;
//  s := s+ ' FROM '+#10;
//  s := s+ '   tblPriceCodes '+#10;
//  s := s+ ' ORDER BY '+#10;
//  s := s+ '  '+zSortStr+' ';

  rSet := CreateNewDataSet;
  try
    s := format(select_PriceCodes_fillGridFromDataset , [zSortStr]);
	 //	CopyToClipboard(s);
   // DebugMessage(''#10#10+s);

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
          m_.Locate('pcCode',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure  TfrmPriceCodes.fillHolder;
begin
  if m_.RecordCount = 0 then exit;
  initPriceCodeHolder(zData);
  zData.ID	                  := m_.FieldByName('ID').asinteger;
  zData.pcCode                := m_['pcCode'];
  zData.pcDescription         := m_['pcDescription'];
  zData.pcRack                := m_['pcRack'];
  zData.pcRackCalc            := LocalFloatValue(m_['pcRackCalc'])           ;
  zData.pcShowDiscount        := m_['pcShowDiscount'];
  zData.pcDiscountText        := m_['pcDiscountText'];
  zData.pcAutomatic           := m_['pcAutomatic'];
  zData.pcLastUpdate          := m_['pcLastUpdate'];
  zData.pcDiscountMethod      := m_.FieldByName('pcDiscountMethod').asinteger;
  zData.pcDiscountPriceAfter  := LocalFloatValue(m_['pcDiscountPriceAfter']);
  zData.pcDiscountDaysAfter   := m_.FieldByName('pcDiscountDaysAfter').asinteger;
  zData.Active                := m_['Active'];
end;

procedure TfrmPriceCodes.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID	                .Options.Editing  := true;
    tvDatapcCode              .Options.Editing  := true;
    tvDatapcDescription       .Options.Editing  := true;
    tvDatapcRack              .Options.Editing  := true;
    tvDatapcRackCalc          .Options.Editing  := true;
    tvDatapcShowDiscount      .Options.Editing  := true;
    tvDatapcDiscountText      .Options.Editing  := true;
    tvDatapcAutomatic         .Options.Editing  := true;
    tvDatapcLastUpdate        .Options.Editing  := true;
    tvDatapcDiscountMethod    .Options.Editing  := true;
    tvDatapcDiscountPriceAfter.Options.Editing  := true;
    tvDatapcDiscountDaysAfter .Options.Editing  := true;
    tvDataActive              .Options.Editing  := true;
  end else
  begin
    tvDataID	                .Options.Editing  := false;
    tvDatapcCode              .Options.Editing  := false;
    tvDatapcDescription       .Options.Editing  := false;
    tvDatapcRack              .Options.Editing  := false;
    tvDatapcRackCalc          .Options.Editing  := false;
    tvDatapcShowDiscount      .Options.Editing  := false;
    tvDatapcDiscountText      .Options.Editing  := false;
    tvDatapcAutomatic         .Options.Editing  := false;
    tvDatapcLastUpdate        .Options.Editing  := false;
    tvDatapcDiscountMethod    .Options.Editing  := false;
    tvDatapcDiscountPriceAfter.Options.Editing  := false;
    tvDatapcDiscountDaysAfter .Options.Editing  := false;
    tvDataActive              .Options.Editing  := false;
  end;
end;


Procedure TfrmPriceCodes.ChkFilter;
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
    labFilterWarning.Visible    := true;
    labFilterWarning.Color      := clMoneyGreen;
    labFilterWarning.Font.Style := [fsBold];                         //-C
//    labFilterWarning.caption    := shFilterOn+' - '+inttostr(rc2)+' '+shRecordsOf+' '+inttostr(rc1)+' '+shAreVisible+' ';;
    labFilterWarning.caption    := format(GetTranslatedText('shFilterOnRecordsOf'), [rc2, rc1]);
  end else
  begin
    labFilterWarning.Visible    := false;
  end;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmPriceCodes.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmPriceCodes.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmPriceCodes.FormShow(Sender: TObject);
begin
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.pcCode);
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

procedure TfrmPriceCodes.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TfrmPriceCodes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmPriceCodes.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmPriceCodes.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.vatCodeExistsInOther(zData.pcCode) then
  begin
	  Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Pricecode', zData.pcDescription]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteCurrency')+' '+zData.pcDescription+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_priceCode(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmPriceCodes.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('pcCode').Focused := True;
end;

procedure TfrmPriceCodes.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;

  initPriceCodeHolder(zData);
  zData.pcCode                    := dataset['pcCode'];
  zData.pcDescription             := dataset['pcDescription'];
  zData.pcRack                    := dataset['pcRack'];
  zData.pcRackCalc                := LocalFloatValue(dataset['pcRackCalc']);
  zData.pcShowDiscount            := dataset['pcShowDiscount'];
  zData.pcDiscountText            := dataset['pcDiscountText'];
  zData.pcAutomatic               := dataset['pcAutomatic'];
  zData.pcLastUpdate              := dataset['pcLastUpdate'];
  zData.pcDiscountMethod          := dataset.FieldByName('pcDiscountMethod').asinteger;
  zData.pcDiscountPriceAfter      := LocalFloatValue(dataset['pcDiscountPriceAfter']);
  zData.pcDiscountDaysAfter       := dataset.FieldByName('pcDiscountDaysAfter').asinteger;
  zData.Active                    := dataset['Active'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_priceCode(zData) then
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

    if dataset['pcCode'] = ''  then
    begin
	    showmessage(GetTranslatedText('shTx_PriceCodes_PriceRequired'));
      tvData.GetColumnByFieldName('pcCode').Focused := True;
      abort;
      exit;
    end;

    if ins_priceCode(zData,nID) then
    begin
      dataset.fieldbyname('ID').asInteger := nID;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;

procedure TfrmPriceCodes.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  m_['pcCode']                    := '';
  m_['pcDescription']             := '';
  m_['pcRack']                    := False;
  m_['pcRackCalc']                := 1;
  m_['pcShowDiscount']            := false;
  m_['pcDiscountText']            := '';
  m_['pcAutomatic']               := true;
  m_['pcLastUpdate']              := now;
  m_['pcDiscountMethod']          := 1;
  m_['pcDiscountPriceAfter']      := 0;
  m_['pcDiscountDaysAfter']       := 0;
  m_['Active']                    := true;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmPriceCodes.tvDatapcCodePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('pcCode').AsString;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
   // errortext := 'Code '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_PriceCodes_CodeIsRequired');
    exit;
  end;

  if hdata.vatCodeExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.vatCodeExistsInOther(currValue) then
    begin
      error := true;
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;

end;


procedure TfrmPriceCodes.tvDatapcRackPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  rackID : integer;
  currID : integer;
begin
  if TcxCheckBox (Sender).Checked then
  begin
    currID := m_.FieldByName('ID').AsInteger;
    rackID := priceCode_RackID();
    if (rackId = -1) or (rackId = currID) then
    begin
      //do nothing
    end else
    begin
      if (rackId > 0) then
      begin
        error := true;
      //  errortext:= 'There can only be one rackrate - Use [ESC] to abandon changes';
		errortext:= GetTranslatedText('shTx_PriceCodes_RackRate');
        exit
      end;
    end;

//    if hData.rateDefaultExist(Currency,true) then
//    begin
//      error := true;
//      errortext:= 'Default for '+currency+' already exists - Use [ESC] to abandon changes';
//      exit
//    end;
  end;
end;

procedure TfrmPriceCodes.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;

procedure TfrmPriceCodes.tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
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


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmPriceCodes.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmPriceCodes.tvDataDataControllerSortingChanged(Sender: TObject);
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

procedure TfrmPriceCodes.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDatapcCode    ,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatapcDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

procedure TfrmPriceCodes.edFilterChange(Sender: TObject);
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

procedure TfrmPriceCodes.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmPriceCodes.btnCancelClick(Sender: TObject);
begin
  initPriceCodeHolder(zData);
end;

procedure TfrmPriceCodes.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmPriceCodes.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPriceCodes.btnOtherClick(Sender: TObject);
begin
  //
end;

procedure TfrmPriceCodes.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;


procedure TfrmPriceCodes.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('pcCode').Focused := True;
  showmessage(GetTranslatedText('shTx_PriceCodes_EditInGrid'));
end;

procedure TfrmPriceCodes.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  m_.Insert;
  grData.SetFocus;
  tvData.GetColumnByFieldName('pcCode').Focused := True;
end;

////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmPriceCodes.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;

  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmPriceCodes.mnuiGridToExcelClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath+caption;
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
  //  To export ot xlsx form then use this
  //  ExportGridToXLSX(sFilename, grData, true, true, true);
  //  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil, sw_shownormal);
end;

procedure TfrmPriceCodes.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmPriceCodes.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmPriceCodes.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmPriceCodes.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;


end.
