unit uRoomTypes2;

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
  , uUtils

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
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxSpinEdit, cxButtonEdit, cxColorComboBox, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter,
  cxPropertiesStore, dxmdaset, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxPScxPivotGridLnk, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

  ;

type
  TfrmRoomTypes2 = class(TForm)
    sPanel1: TsPanel;
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
    m_RoomType: TWideStringField;
    m_Description: TWideStringField;
    m_NumberGuests: TIntegerField;
    m_PriceType: TWideStringField;
    m_Webable: TBooleanField;
    m_RoomTypeGroup: TWideStringField;
    m_color: TWideStringField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    tvDataRoomType: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataNumberGuests: TcxGridDBColumn;
    tvDataPriceType: TcxGridDBColumn;
    tvDataWebable: TcxGridDBColumn;
    tvDataRoomTypeGroup: TcxGridDBColumn;
    tvDatacolor: TcxGridDBColumn;
    btnInsert: TsButton;
    btnEdit: TsButton;
    m_PriorityRule: TWideStringField;
    tvDataPriorityRule: TcxGridDBColumn;
    F1: TMenuItem;
    FormStore: TcxPropertiesStore;
    sPanel2: TsPanel;
    pnlHolder: TsPanel;
    m_location: TStringField;
    tvDatalocation: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
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
    procedure tvDataRoomTypeGroupPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnInsertClick(Sender: TObject);
    procedure tvDatacolorPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDatacolorPropertiesEditValueChanged(Sender: TObject);
    procedure tvDataRoomTypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure F1Click(Sender: TObject);
    procedure m_AfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tvDatalocationPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    Procedure fillGridFromDataset(iGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;
  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recRoomTypeHolder;

    embedded : Boolean;
    EmbedWindowCloseEvent : TNotifyEvent;

    procedure PrepareUserInterface;
    procedure BringWindowToFront;
  end;

function openRoomTypes(act : TActTableAction; var theData : recRoomTypeHolder; embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil) : boolean;

var
  frmRoomTypes2: TfrmRoomTypes2;
  frmRoomTypes2X: TfrmRoomTypes2;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uRoomTypesGroups2
  , uDImages
  , uMain
  , uLocations2
  , UITypes
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openRoomTypes(act : TActTableAction; var theData : recRoomTypeHolder; embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil) : boolean;
var
  _frmRoomTypes2: TfrmRoomTypes2;
begin
  result := false;
  _frmRoomTypes2 := TfrmRoomTypes2.Create(nil);
  try
    _frmRoomTypes2.zData := theData;
    _frmRoomTypes2.zAct := act;
    _frmRoomTypes2.embedded := (act = actNone) AND
                                    (embedPanel <> nil);
    _frmRoomTypes2.EmbedWindowCloseEvent := WindowCloseEvent;
    if _frmRoomTypes2.embedded then
    begin
      _frmRoomTypes2.pnlHolder.parent := embedPanel;
      embedPanel.Update;
      frmRoomTypes2X := _frmRoomTypes2;
    end
    else
    begin
      _frmRoomTypes2.PrepareUserInterface;
      if act = actLookup then
        _frmRoomTypes2.ActiveControl := _frmRoomTypes2.BtnOk;
      _frmRoomTypes2.ShowModal;
      if _frmRoomTypes2.modalresult = mrOk then
      begin
        theData := _frmRoomTypes2.zData;
        result := true;
      end
      else
      begin
        initRoomTypeHolder(theData);
      end;
    end;
  finally
    if (act <> actNone) OR
      (embedPanel = nil) then
      freeandnil(_frmRoomTypes2);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmRoomTypes2.fillGridFromDataset(iGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'RoomType';
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomTypes, [zSortStr]);

//    copytoclipboard(s);
//    debugmessage(s);
    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.Open;

//ID
//RoomType
//Description
//NumberGuests
//PriceType
//Webable
//RoomTypeGroup
//color
//Active
//PriorityRule
//location




      while not rset.Eof do
      begin
        m_.insert;
        m_.fieldbyname('ID').AsInteger := rSet.fieldbyname('ID').AsInteger;
        m_.fieldbyname('RoomType').AsString := rSet.fieldbyname('RoomType').AsString;
        m_.fieldbyname('Description').AsString := rSet.fieldbyname('Description').AsString;
        m_.fieldbyname('NumberGuests').AsInteger := rSet.fieldbyname('NumberGuests').AsInteger;
        m_.fieldbyname('PriceType').AsString := rSet.fieldbyname('PriceType').AsString;
        m_.fieldbyname('Webable').AsBoolean := rSet.fieldbyname('Webable').AsBoolean;
        m_.fieldbyname('RoomTypeGroup').AsString := rSet.fieldbyname('RoomTypeGroup').AsString;
        m_.fieldbyname('color').AsString := rSet.fieldbyname('color').AsString;
        m_.fieldbyname('Active').AsBoolean := rSet.fieldbyname('Active').AsBoolean;
        m_.fieldbyname('PriorityRule').AsString := rSet.fieldbyname('PriorityRule').AsString;
        m_.fieldbyname('location').AsString := rSet.fieldbyname('location').AsString;
        m_.post;
        rSet.Next;
      end;
//        m_.First;
//      m_.LoadFromDataSet(rSet);

      if iGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('RoomType',iGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure TfrmRoomTypes2.fillHolder;
begin
  initRoomTypeHolder(zData);
  zData.ID           := m_.FieldByName('ID').AsInteger;
  zData.Active       := m_['Active'];
  zData.RoomType     := m_['RoomType'];
  zData.Description  := m_['Description'];
  zData.NumberGuests := m_['NumberGuests'];
  zData.PriceType    := m_['PriceType'];
  zData.Webable      := m_['Webable'];
  zData.RoomTypeGroup:= m_['RoomTypeGroup'];
  zData.color        := m_['color'];
  zData.PriorityRule := m_['PriorityRule'];
  zData.location     := m_['Location'];
end;



procedure TfrmRoomTypes2.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive.Options.Editing         := true;
    tvDataRoomType.Options.Editing       := true;
    tvDataDescription.Options.Editing    := true;
    tvDataNumberGuests.Options.Editing   := true;
    tvDataPriceType.Options.Editing      := true;
    tvDataWebable.Options.Editing        := true;
    tvDataRoomTypeGroup.Options.Editing  := true;
    tvDatacolor.Options.Editing          := true;
    tvDataPriorityRule.Options.Editing   := true;
    tvDataLocation.Options.Editing   := g.qLocationPerRoomType;
  end else
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive.Options.Editing         := false;
    tvDataRoomType.Options.Editing       := false;
    tvDataDescription.Options.Editing    := false;
    tvDataNumberGuests.Options.Editing   := false;
    tvDataPriceType.Options.Editing      := false;
    tvDataWebable.Options.Editing        := false;
    tvDataRoomTypeGroup.Options.Editing  := false;
    tvDatacolor.Options.Editing          := false;
    tvDataPriorityRule.Options.Editing   := false;
    tvDataLocation.Options.Editing   := false;
  end;
end;


procedure TfrmRoomTypes2.chkFilter;
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


procedure TfrmRoomTypes2.edFilterChange(Sender: TObject);
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

procedure TfrmRoomTypes2.F1Click(Sender: TObject);
begin
  screen.Cursor := crHourGlass;
  try
    FixRoomTypes;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmRoomTypes2.applyFilter;
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

procedure TfrmRoomTypes2.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;

  PrepareUserInterface;
end;

procedure TfrmRoomTypes2.FormDestroy(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('roomtypes', True);
end;

procedure TfrmRoomTypes2.PrepareUserInterface;
begin
//**
  tvDataPriorityRule.Visible := NOT frmMain.RBEMode;

  panBtn.Visible := False;
  sbMain.Visible := false;
  btnClose.Visible := False;

  fillGridFromDataset(zData.roomType);
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
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmRoomTypes2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  glb.EnableOrDisableTableRefresh('roomtypes', True);
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

procedure TfrmRoomTypes2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;
end;

procedure TfrmRoomTypes2.FormKeyPress(Sender: TObject; var Key: Char);
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


procedure TfrmRoomTypes2.FormShow(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('roomtypes', False);
  tvDataLocation.Visible := g.qLocationPerRoomType;
end;

////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmRoomTypes2.m_AfterScroll(DataSet: TDataSet);
begin
  if (NOT dataset.Eof) AND (NOT dataset.FieldByName('Active').IsNull) then
  begin
  initRoomTypeHolder(zData);
  zData.ID           := dataset.FieldByName('ID').AsInteger;
  zData.Active       := dataset['Active'];
  zData.RoomType     := dataset['RoomType'];
  zData.Description  := dataset['Description'];
  zData.NumberGuests := dataset['NumberGuests'];
  zData.PriceType    := dataset['PriceType'];
  zData.Webable      := dataset['Webable'];
  zData.RoomTypeGroup:= dataset['RoomTypeGroup'];
  zData.color        := dataset['color'];
  zData.PriorityRule := dataset['PriorityRule'];
  zData.location     := dataset['Location'];
  end;
end;

procedure TfrmRoomTypes2.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;

  if hdata.RoomTypeExistsInOther(zData.RoomType,zData.ID) then
  begin
	  Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['RoomType', zData.Description]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteRoomRate')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_RoomType(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmRoomTypes2.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('RoomType').Focused := True;
end;

procedure TfrmRoomTypes2.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
  OldRoomType : String;
  OldLocation : string;
  oldCode, oldGroup : String;
begin
  if zFirstTime then exit;

  OldRoomType := zData.RoomType;
  OldLocation := zData.Location;

  initRoomTypeHolder(zData);
  zData.ID           := dataset.FieldByName('ID').AsInteger;
  zData.Active       := dataset['Active'];
  zData.RoomType     := dataset['RoomType'];
  zData.Description  := dataset['Description'];
  zData.NumberGuests := dataset['NumberGuests'];
  zData.PriceType    := dataset['PriceType'];
  zData.Webable      := dataset['Webable'];
  zData.RoomTypeGroup:= dataset['RoomTypeGroup'];
  zData.color        := dataset['color'];
  zData.PriorityRule := dataset['PriorityRule'];
  zData.location     := dataset['Location'];


  if tvData.DataController.DataSource.State = dsEdit then
  begin
//    if (OldRoomType <> '') AND (OldRoomType <> zData.RoomType) then
//    begin
//      s := 'Change room type from '+OldRoomType+' to '+zData.RoomType;
//      if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//      begin
//        if glb.KeyAlreadyExistsInAnotherRecord('roomtypes', 'RoomType', zData.RoomType, zData.id) then
//        begin
//          showmessage(GetTranslatedText('shTx_Roomtypes2_RoomTypeAlreadyExists'));
//          tvData.GetColumnByFieldName('RoomType').Focused := True;
//          abort;
//          exit;
//        end;
//        screen.Cursor := crHourGlass;
//        try
//          d.roomerMainDataSet.SystemChangeRoomType(OldRoomType, zData.RoomType);
//        finally
//          screen.Cursor := crDefault;
//        end;
//
//
//      end else
//      begin
//        m_.cancel;
//        exit;
//      end;
//    end;

   if (OldLocation <> zData.Location) then
      UPD_roomLocation(zData.RoomType, zData.location);


    oldGroup := dataSet.FieldByName('RoomTypeGroup').OldValue;
    oldCode := dataSet.FieldByName('RoomType').OldValue;
    if oldCode <> zData.RoomType then
      SetForeignKeyCheckValue(0);
    try
      if UPD_roomType(zData) then
      begin
        if oldCode <> zData.RoomType then
          UpdateRoomTypeCode(oldCode, zData.RoomType);
        if oldGroup <> zData.RoomTypeGroup then
          Set2RoomTypeGroupDity(oldGroup, zData.RoomTypeGroup);
  //       if (OldLocation <> zData.Location) then
  //          UPD_roomLocation(zData.RoomType, zData.location);
         glb.ForceTableRefresh;
      end else
      begin
        abort;
        exit;
      end;
    finally
      if oldCode <> zData.RoomType then
        SetForeignKeyCheckValue(1);
    end;
  end;

  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('RoomType').AsString = ''  then
    begin
 	    showmessage(GetTranslatedText('shTx_RoomTypes_RoomTypeRequired'));
      tvData.GetColumnByFieldName('RoomType').Focused := True;
      abort;
      exit;
    end;
    if glb.LocateSpecificRecord('roomtypes', 'RoomType', dataset.FieldByName('RoomType').AsString)  then
    begin
	    showmessage(GetTranslatedText('shTx_Roomtypes2_RoomTypeAlreadyExists'));
      tvData.GetColumnByFieldName('RoomType').Focused := True;
      abort;
      exit;
    end;
    if ins_roomType(zData,nID) then
    begin
      // m_.Edit;
      m_.fieldbyname('ID').AsInteger := nID;
      // m_.Post;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;



procedure TfrmRoomTypes2.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']        := true;
  dataset['RoomType']      := '';
  dataset['Description']   := '';
  dataset['NumberGuests']  := 2 ;
  dataset['PriceType']     := '';
  dataset['Webable']       := true;
  dataset['RoomTypeGroup'] := '';
  dataset['color']         := '';
  dataset['PriorityRule']  := '';
  dataset['Location']  := '';
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmRoomTypes2.tvDataDescriptionPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Description').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
 //   errortext := 'Description '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_RoomTypes_DescriptionIsRequired');
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

procedure TfrmRoomTypes2.tvDataFocusedRecordChanged(
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

procedure TfrmRoomTypes2.tvDatalocationPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recLocationHolder;
begin
  fillholder;
  theData.location := zData.location;
  openLocation(actlookup,theData);

  if theData.location <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['Location']   := theData.location;
    m_.Post;
  end;
end;

procedure TfrmRoomTypes2.tvDataRoomTypeGroupPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recRoomTypeGroupHolder;
begin
  fillholder;
  theData.Code := zData.RoomTypeGroup;
//  theData.ID := zData. CurrencyID;

  openRoomTypeGroups(actlookup,theData);

  if theData.code <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['RoomTypeGroup']   := theData.code;
//    m_['currencyID'] := theData.ID;
  end;
end;

procedure TfrmRoomTypes2.tvDataRoomTypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
//var
//  CurrValue : string;
//  currID : integer;
begin
//  currValue := m_.fieldbyname('RoomType').asstring;
//  currID    := m_.fieldbyname('ID').asInteger;
//
//  error := false;
//  if trim(displayValue) = '' then
//  begin
//    error := true;
//	  errortext := GetTranslatedText('shTx_RoomTypes_RoomTypeIsRequired');
//    exit;
//  end;
//
//  if hdata.RoomTypeExist(displayValue) then
//  begin
//    error := true;
//    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
//    exit
//  end;
//
//  if tvData.DataController.DataSource.State = dsEdit then
//  begin
//    if hdata.RoomTypeExistsInOther(currValue,currID) then
//    begin
//      error := true;
//      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
//      exit;
//    end;
//  end;
end;

procedure TfrmRoomTypes2.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmRoomTypes2.tvDatacolorPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     showmessage(GetTranslatedText('shTx_RoomTypes_ComingSoon'));
end;

procedure TfrmRoomTypes2.tvDatacolorPropertiesEditValueChanged(Sender: TObject);
begin
  with TcxButtonEdit(sender) do
  begin
    style.Color := clRed;
    style.TextColor := clYellow;
  end;
end;

procedure TfrmRoomTypes2.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmRoomTypes2.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmRoomTypes2.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmRoomTypes2.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmRoomTypes2.BringWindowToFront;
begin
  pnlHolder.BringToFront;
end;

procedure TfrmRoomTypes2.btnCancelClick(Sender: TObject);
begin
  initRoomTypeHolder(zData);
end;

procedure TfrmRoomTypes2.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRoomTypes2.btnCloseClick(Sender: TObject);
begin
  if embedded then
    Close;
end;

procedure TfrmRoomTypes2.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmRoomTypes2.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
  showmessage(GetTranslatedText('shTx_RoomTypes_EditInGrid'));
end;

procedure TfrmRoomTypes2.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('RoomType').Focused := True;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmRoomTypes2.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmRoomTypes2.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmRoomTypes2.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmRoomTypes2.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmRoomTypes2.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmRoomTypes2.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

