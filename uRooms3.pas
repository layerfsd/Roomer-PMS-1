unit uRooms3;

interface

//** unit added 2013-02-28 HJ

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
  , Hdata
  , ug
//  , uManageFilesOnServer
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
  , dxmdaset
  , cxButtonEdit
  , cxCalc
  , sComboBox
  , sGroupBox
  , AdvCombo
  , ColCombo
  , Vcl.Mask
  , AdvDropDown
  , AdvMultiColumnDropDown
  , cxContainer
  , cxMaskEdit
  , cxDropDownEdit
  , cxLookupEdit
  , cxDBLookupEdit
  , cxDBExtLookupComboBox
  , cxDBLookupComboBox
  , cxSpinEdit
  , cxCheckBox
  , cxPropertiesStore
  , cxGridBandedTableView
  , cxGridDBBandedTableView

  , dxSkinsCore
  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters
  , dxSkinscxPCPainter
  , dxSkinsdxBarPainter
  , dxSkinsdxRibbonPainter, dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

  ;

type
  TfrmRooms3 = class(TForm)
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
    m_ID: TIntegerField;
    m_Active: TBooleanField;
    m_Room: TWideStringField;
    m_Description: TWideStringField;
    m_RoomType: TWideStringField;
    m_Bath: TBooleanField;
    m_Shower: TBooleanField;
    m_Safe: TBooleanField;
    m_Tv: TBooleanField;
    m_Video: TBooleanField;
    m_Radio: TBooleanField;
    m_Press: TBooleanField;
    m_CDPlayer: TBooleanField;
    m_Telephone: TBooleanField;
    m_Coffee: TBooleanField;
    m_Kitchen: TBooleanField;
    m_Minibar: TBooleanField;
    m_Fridge: TBooleanField;
    m_Hairdryer: TBooleanField;
    m_InternetPlug: TBooleanField;
    m_Fax: TBooleanField;
    m_SqrMeters: TFloatField;
    m_BedSize: TWideStringField;
    m_Equipments: TWideStringField;
    m_Bookable: TBooleanField;
    m_Statistics: TBooleanField;
    m_Status: TWideStringField;
    m_OrderIndex: TIntegerField;
    m_hidden: TBooleanField;
    m_Location: TWideStringField;
    m_Dorm: TWideStringField;
    m_Floor: TIntegerField;
    btnInsert: TsButton;
    btnEdit: TsButton;
    m_useInNationalReport: TBooleanField;
    FormStore: TcxPropertiesStore;
    lvData: TcxGridLevel;
    grData: TcxGrid;
    tvData: TcxGridDBBandedTableView;
    tvDataRecId: TcxGridDBBandedColumn;
    tvDataID: TcxGridDBBandedColumn;
    tvDataActive: TcxGridDBBandedColumn;
    tvDataRoom: TcxGridDBBandedColumn;
    tvDataDescription: TcxGridDBBandedColumn;
    tvDataRoomType: TcxGridDBBandedColumn;
    tvDataBath: TcxGridDBBandedColumn;
    tvDataShower: TcxGridDBBandedColumn;
    tvDataSafe: TcxGridDBBandedColumn;
    tvDataTv: TcxGridDBBandedColumn;
    tvDataVideo: TcxGridDBBandedColumn;
    tvDataRadio: TcxGridDBBandedColumn;
    tvDataCDPlayer: TcxGridDBBandedColumn;
    tvDataTelephone: TcxGridDBBandedColumn;
    tvDataPress: TcxGridDBBandedColumn;
    tvDataCoffee: TcxGridDBBandedColumn;
    tvDataKitchen: TcxGridDBBandedColumn;
    tvDataMinibar: TcxGridDBBandedColumn;
    tvDataFridge: TcxGridDBBandedColumn;
    tvDataHairdryer: TcxGridDBBandedColumn;
    tvDataInternetPlug: TcxGridDBBandedColumn;
    tvDataFax: TcxGridDBBandedColumn;
    tvDataSqrMeters: TcxGridDBBandedColumn;
    tvDataBedSize: TcxGridDBBandedColumn;
    tvDataEquipments: TcxGridDBBandedColumn;
    tvDataBookable: TcxGridDBBandedColumn;
    tvDataStatistics: TcxGridDBBandedColumn;
    tvDataStatus: TcxGridDBBandedColumn;
    tvDataOrderIndex: TcxGridDBBandedColumn;
    tvDatahidden: TcxGridDBBandedColumn;
    tvDataLocation: TcxGridDBBandedColumn;
    tvDataDorm: TcxGridDBBandedColumn;
    tvDataFloor: TcxGridDBBandedColumn;
    tvDatauseInNationalReport: TcxGridDBBandedColumn;
    m_wildcard: TBooleanField;
    tvDatawildcard: TcxGridDBBandedColumn;
    S1: TMenuItem;
    S2: TMenuItem;
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
    procedure tvDataRoomTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataLocationPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnInsertClick(Sender: TObject);
    procedure tvDataRoomPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataRoomTypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure m_AfterScroll(DataSet: TDataSet);
    procedure S1Click(Sender: TObject);
    procedure S2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;

    Procedure fillGridFromDataset(iGoto : integer; sGoto : String = '');
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;


  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recRoomHolder;
  end;

function openRooms(act : TActTableAction; var theData : recRoomHolder) : boolean;

var
  frmRooms3: TfrmRooms3;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uRoomTypes2
  , uLocations2
  , uDimages
  , uUtils
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openRooms(act : TActTableAction; var theData : recRoomHolder) : boolean;
begin
  result := false;
  frmRooms3 := TfrmRooms3.Create(frmRooms3);
  try
    frmRooms3.zData := theData;
    frmRooms3.zAct := act;
    frmRooms3.ShowModal;
    if frmRooms3.modalresult = mrOk then
    begin
      theData := frmRooms3.zData;
      result := true;
    end
    else
    begin
      initRoomHolder(theData);
    end;
  finally
    freeandnil(frmRooms3);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmRooms3.fillGridFromDataset(iGoto : integer; sGoto : String = '');
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'Room';
  rSet := CreateNewDataSet;
  try
    s := format(select_Rooms, [zSortStr]);
    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if (iGoto = 0) AND  (sGoto = '') then
      begin
        m_.First;
      end else
      begin
        try
          if sGoto <> '' then
            m_.Locate('Room',sGoto,[])
          else
            m_.Locate('ID',iGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure TfrmRooms3.fillHolder;
begin
  initRoomHolder(zData);
  zData.ID                        := m_.FieldByName('ID').AsInteger;
  zData.Active                    := m_['Active'];
  zData.description               := m_['description'];
  zData.Room                      := m_['Room'];
  zData.RoomType                  := m_['RoomType'];
  zData.location                  := m_['location'];
  zData.wildcard                  := m_['wildcard'];
  zData.Bath                      := m_['Bath'];
  zData.Shower                    := m_['Shower'];
  zData.Safe                      := m_['Safe'];
  zData.TV                        := m_['TV'];
  zData.Video                     := m_['Video'];
  zData.Radio                     := m_['Radio'];
  zData.CDPlayer                  := m_['CDPlayer'];
  zData.Telephone                 := m_['Telephone'];
  zData.Press                     := m_['Press'];
  zData.Coffee                    := m_['Coffee'];
  zData.Kitchen                   := m_['Kitchen'];
  zData.Minibar                   := m_['Minibar'];
  zData.Fridge                    := m_['Fridge'];
  zData.Hairdryer                 := m_['Hairdryer'];
  zData.InternetPlug              := m_['InternetPlug'];
  zData.Fax                       := m_['Fax'];
  zData.SqrMeters                 := m_['SqrMeters'];
  zData.BedSize                   := m_['BedSize'];
  zData.Equipments                := m_['Equipments'];
  zData.Bookable                  := m_['Bookable'];
  zData.useInNationalReport       := m_['useInNationalReport'];
  zData.Statistics                := m_['Statistics'];
  zData.Status                    := m_['Status'];
  zData.OrderIndex                := m_['OrderIndex'];
  zData.hidden                    := m_['hidden'];
  zData.Floor                     := m_['Floor'];
  zData.Dorm                      := m_['Dorm'];
end;


procedure TfrmRooms3.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive             .Options.Editing         := true;
    tvDatadescription        .Options.Editing         := true;
    tvDataRoom               .Options.Editing         := true;
    tvDataRoomType           .Options.Editing         := true;
    tvDatalocation           .Options.Editing         := NOT g.qLocationPerRoomType;
    tvDatawildcard           .Options.Editing         := true;
    tvDataBath               .Options.Editing         := true;
    tvDataShower             .Options.Editing         := true;
    tvDataSafe               .Options.Editing         := true;
    tvDataTV                 .Options.Editing         := true;
    tvDataVideo              .Options.Editing         := true;
    tvDataRadio              .Options.Editing         := true;
    tvDataCDPlayer           .Options.Editing         := true;
    tvDataTelephone          .Options.Editing         := true;
    tvDataPress              .Options.Editing         := true;
    tvDataCoffee             .Options.Editing         := true;
    tvDataKitchen            .Options.Editing         := true;
    tvDataMinibar            .Options.Editing         := true;
    tvDataFridge             .Options.Editing         := true;
    tvDataHairdryer          .Options.Editing         := true;
    tvDataInternetPlug       .Options.Editing         := true;
    tvDataFax                .Options.Editing         := true;
    tvDataSqrMeters          .Options.Editing         := true;
    tvDataBedSize            .Options.Editing         := true;
    tvDataEquipments         .Options.Editing         := true;
    tvDataBookable           .Options.Editing         := true;
    tvDataStatistics         .Options.Editing         := true;
    tvDataStatus             .Options.Editing         := true;
    tvDataOrderIndex         .Options.Editing         := true;
    tvDatahidden             .Options.Editing         := true;
    tvDataFloor              .Options.Editing         := true;
    tvDataDorm               .Options.Editing         := true;
    tvDatauseInNationalReport.Options.Editing         := true;


  end else
  begin
    tvDataID.Options.Editing             := false;
    tvDataActive             .Options.Editing         := false;
    tvDatadescription        .Options.Editing         := false;
    tvDataRoom               .Options.Editing         := false;
    tvDataRoomType           .Options.Editing         := false;
    tvDatalocation           .Options.Editing         := false;
    tvDatawildcard           .Options.Editing         := false;
    tvDataBath               .Options.Editing         := false;
    tvDataShower             .Options.Editing         := false;
    tvDataSafe               .Options.Editing         := false;
    tvDataTV                 .Options.Editing         := false;
    tvDataVideo              .Options.Editing         := false;
    tvDataRadio              .Options.Editing         := false;
    tvDataCDPlayer           .Options.Editing         := false;
    tvDataTelephone          .Options.Editing         := false;
    tvDataPress              .Options.Editing         := false;
    tvDataCoffee             .Options.Editing         := false;
    tvDataKitchen            .Options.Editing         := false;
    tvDataMinibar            .Options.Editing         := false;
    tvDataFridge             .Options.Editing         := false;
    tvDataHairdryer          .Options.Editing         := false;
    tvDataInternetPlug       .Options.Editing         := false;
    tvDataFax                .Options.Editing         := false;
    tvDataSqrMeters          .Options.Editing         := false;
    tvDataBedSize            .Options.Editing         := false;
    tvDataEquipments         .Options.Editing         := false;
    tvDataBookable           .Options.Editing         := false;
    tvDataStatistics         .Options.Editing         := false;
    tvDataStatus             .Options.Editing         := false;
    tvDataOrderIndex         .Options.Editing         := false;
    tvDatahidden             .Options.Editing         := false;
    tvDataFloor              .Options.Editing         := false;
    tvDataDorm               .Options.Editing         := false;
    tvDatauseInNationalReport.Options.Editing         := false;
  end;
end;


procedure TfrmRooms3.chkFilter;
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


procedure TfrmRooms3.edFilterChange(Sender: TObject);
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

procedure TfrmRooms3.applyFilter;
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

procedure TfrmRooms3.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
end;

procedure TfrmRooms3.FormDestroy(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('rooms', True);
end;

procedure TfrmRooms3.FormShow(Sender: TObject);
begin
  glb.EnableOrDisableTableRefresh('rooms', False);
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  zFirstTime := true;


  if ZAct = actLookup then
  begin
    fillGridFromDataset(zData.ID, zData.Room);
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end else
  begin
    fillGridFromDataset(0, '');
    mnuiAllowGridEdit.Checked := true;
    sbMain.Visible := true;
  end;
  sbMain.SimpleText := zSortStr;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmRooms3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  glb.EnableOrDisableTableRefresh('rooms', True);
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmRooms3.FormKeyPress(Sender: TObject; var Key: Char);
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
procedure TfrmRooms3.m_AfterScroll(DataSet: TDataSet);
begin
  if (NOT dataset.Eof) AND (NOT dataset.FieldByName('wildcard').IsNull) then
  begin
    zData.ID           := dataset.FieldByName('ID').AsInteger;
    zData.Active       := dataset['Active'];
    zData.description  := dataset['description'];
    zData.Room         := dataset['Room'];
    zData.RoomType     := dataset['RoomType'];
    zData.location     := dataset['location'];
    zData.wildcard     := dataset['wildcard'];
    zData.Bath         := dataset['Bath'];
    zData.Shower       := dataset['Shower'];
    zData.Safe         := dataset['Safe'];
    zData.TV           := dataset['TV'];
    zData.Video        := dataset['Video'];
    zData.Radio        := dataset['Radio'];
    zData.CDPlayer     := dataset['CDPlayer'];
    zData.Telephone    := dataset['Telephone'];
    zData.Press        := dataset['Press'];
    zData.Coffee       := dataset['Coffee'];
    zData.Kitchen      := dataset['Kitchen'];
    zData.Minibar      := dataset['Minibar'];
    zData.Fridge       := dataset['Fridge'];
    zData.Hairdryer    := dataset['Hairdryer'];
    zData.InternetPlug := dataset['InternetPlug'];
    zData.Fax          := dataset['Fax'];
    zData.SqrMeters    := dataset['SqrMeters'];
    zData.BedSize      := dataset['BedSize'];
    zData.Equipments   := dataset['Equipments'];
    zData.Bookable     := dataset['Bookable'];
    zData.Statistics   := dataset['Statistics'];
    zData.Status       := dataset['Status'];
    zData.OrderIndex   := dataset['OrderIndex'];
    zData.hidden       := dataset['hidden'];
    zData.Floor        := dataset.FieldByName('Floor').AsInteger;
    zData.Dorm         := dataset['Dorm'];
    zData.useInNationalReport    := dataset['useInNationalReport'];
  end;
end;

procedure TfrmRooms3.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.roomExistsInOther(zData.room) then
  begin
    Showmessage('Room'+' ' + zData.Room + ' '+GetTranslatedText('shExistsInRelatedData')+' ' + chr(10) + GetTranslatedText('shCanNotDelete')+' ');
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteRoom')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_Room(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;

end;

procedure TfrmRooms3.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Room').Focused := True;
end;


procedure TfrmRooms3.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
  OldRoomNumber, OldType : string;
  s : string;

  bChangedRoomTypes : Boolean;
  oldCode : String;
begin
  if zFirstTime then exit;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    oldType := dataset.FieldByName('RoomType').OldValue;
    OldRoomNumber := dataset.FieldByName('Room').OldValue;
  end;
  initRoomHolder(zData);
  bChangedRoomTypes := False;
  zData.ID           := dataset.FieldByName('ID').AsInteger;
  zData.Active       := dataset['Active'];
  zData.description  := dataset['description'];
  zData.Room         := dataset['Room'];
  zData.RoomType     := dataset['RoomType'];
  zData.location     := dataset['location'];
  zData.wildcard     := dataset['wildcard'];
  zData.Bath         := dataset['Bath'];
  zData.Shower       := dataset['Shower'];
  zData.Safe         := dataset['Safe'];
  zData.TV           := dataset['TV'];
  zData.Video        := dataset['Video'];
  zData.Radio        := dataset['Radio'];
  zData.CDPlayer     := dataset['CDPlayer'];
  zData.Telephone    := dataset['Telephone'];
  zData.Press        := dataset['Press'];
  zData.Coffee       := dataset['Coffee'];
  zData.Kitchen      := dataset['Kitchen'];
  zData.Minibar      := dataset['Minibar'];
  zData.Fridge       := dataset['Fridge'];
  zData.Hairdryer    := dataset['Hairdryer'];
  zData.InternetPlug := dataset['InternetPlug'];
  zData.Fax          := dataset['Fax'];
  zData.SqrMeters    := dataset['SqrMeters'];
  zData.BedSize      := dataset['BedSize'];
  zData.Equipments   := dataset['Equipments'];
  zData.Bookable     := dataset['Bookable'];
  zData.Statistics   := dataset['Statistics'];
  zData.Status       := dataset['Status'];
  zData.OrderIndex   := dataset['OrderIndex'];
  zData.hidden       := dataset['hidden'];
  zData.Floor        := dataset.FieldByName('Floor').AsInteger;
  zData.Dorm         := dataset['Dorm'];
  zData.useInNationalReport    := dataset['useInNationalReport'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if (oldType <> '') AND (oldType <> zData.RoomType) then
    begin
      s := 'Change roomtype for room '+zData.room+' from '+oldType+' to '+zData.roomType;
      if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
         bChangedRoomTypes := True
      else
      begin
        m_.cancel;
        exit;
      end;
    end;


    if (OldRoomNumber <> '') AND (OldRoomNumber <> zData.Room) then
    begin
      s := 'Change room from number '+OldRoomNumber+' to '+zData.room;
      if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        if glb.KeyAlreadyExistsInAnotherRecord('rooms', 'Room', zData.Room, zData.id) then
        begin
          showmessage(GetTranslatedText('shTx_Rooms3_RoomAlreadyExists'));
          tvData.GetColumnByFieldName('Room').Focused := True;
          abort;
          exit;
        end;
        screen.Cursor := crHourGlass;
        try
          d.roomerMainDataSet.SystemChangeRoomNumber(OldRoomNumber, zData.room);
        finally
          screen.Cursor := crDefault;
        end;
      end else
      begin
        m_.cancel;
        exit;
      end;
    end;

    if UPD_room(zData) then
    begin
      if bChangedRoomTypes then
         d.roomermainDataSet.SystemChangeRoomTypeForRoom(zData.Room, oldType, zData.roomType);
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;

  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('Room').AsString = ''  then
    begin
    // showmessage('Room is requierd - set value or use [ESC] to cancel ');
	  showmessage(GetTranslatedText('shTx_Room2_RoomRequired'));
      tvData.GetColumnByFieldName('Room').Focused := True;
      abort;
      exit;
    end;
    if glb.LocateSpecificRecord('rooms', 'Room', dataset.FieldByName('Room').AsString)  then
    begin
 	    showmessage(GetTranslatedText('shTx_Rooms3_RoomAlreadyExists'));
      tvData.GetColumnByFieldName('Room').Focused := True;
      abort;
      exit;
    end;
    if ins_room(zData,nID) then
    begin
     //
    end else
    begin
      abort;
      exit;
    end;
  end;
end;


procedure TfrmRooms3.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
   dataset['Active']      := true ;
   dataset['description'] := '' ;
   dataset['Room']        := '';
   dataset['RoomType']    := '' ;
   dataset['location']    := '' ;
   dataset['wildcard']    := false  ;
   dataset['Bath']        := false  ;
   dataset['Shower']      := false  ;
   dataset['Safe']        := false ;
   dataset['TV']          := false ;
   dataset['Video']       := false ;
   dataset['Radio']       := false ;
   dataset['CDPlayer']    := false ;
   dataset['Telephone']   := false ;
   dataset['Press']       := false ;
   dataset['Coffee']      := false ;
   dataset['Kitchen']     := false ;
   dataset['Minibar']     := false ;
   dataset['Fridge']      := false ;
   dataset['Hairdryer']   := false ;
   dataset['InternetPlug']:= false ;
   dataset['Fax']         := false ;
   dataset['SqrMeters']   := 0    ;
   dataset['BedSize']     := 'T'  ;
   dataset['Equipments']  := ''   ;
   dataset['Bookable']    := true ;
   dataset['Statistics']  := true ;
   dataset['Status']      := 'C'  ;
   dataset['OrderIndex']  := 0    ;
   dataset['hidden']      := false;
   dataset['Floor']       := 1    ;
   dataset['Dorm']        := ''   ;
   dataset['useInNationalReport'] := 1;
end;

procedure TfrmRooms3.S1Click(Sender: TObject);
begin
  d.SetAllClean;
end;

procedure TfrmRooms3.S2Click(Sender: TObject);
begin
  d.SetAllUnClean;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmRooms3.tvDataDescriptionPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Description').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
  //  errortext := 'Description '+' - '+'is required - Use ESC to cancel';
	  errortext := GetTranslatedText('shTx_Room2_DescriptionIsRequired');
    exit;
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
  end;

end;

procedure TfrmRooms3.tvDataLocationPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
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

procedure TfrmRooms3.tvDataRoomPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('Room').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    errortext := 'Room '+' - '+'is required - Use ESC to cancel';
//	  errortext := GetTranslatedText('shTx_Currencies_CodeIsRequired');
    exit;
  end;

  if hdata.RoomExist(displayValue) then
  begin
    error := true;
    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
    errortext := displayvalue + ' ' + GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;

//  if tvData.DataController.DataSource.State = dsEdit then
//  begin
//    if hdata.roomExistsInOther(currValue) then
//    begin
//      error := true;
//      // errortext := displayvalue+'Eldra gildi fannst í tengdri færslu ekki hægt að breyta - Notið 'ESC-hnappin til að hætta við';
//      errortext := displayvalue+GetTranslatedText('shOldValueUsedInRelatedDataC');
//      exit;
//    end;
//  end;
end;


procedure TfrmRooms3.tvDataRoomTypePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
  s : string;
  room : string;
begin
  currValue := m_.fieldbyname('roomType').asstring;
  room := m_.fieldbyname('room').asstring;

  error := false;
  if trim(displayValue) = trim(currValue) then
  begin
    s := 'Change roomtype for room '+currValue+' from '+currValue+' to '+displayValue;
    if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
    end else
    begin
      error := true;
      errortext := 'Use ESC to cancel';
      exit;
    end;
  end;
end;



procedure TfrmRooms3.tvDataRoomTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recRoomTypeHolder;
begin
  initRoomTypeHolder(theData);

  if m_.RecordCount = 0 then
  begin
    initRoomHolder(zData);
  end else
  begin
    fillholder;
  end;

  theData.RoomType := zData.RoomType;
  openRoomTypes(actlookup,theData);
  if theData.roomType <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
    m_['RoomType']   := theData.RoomType;
    m_['Location']   := theData.location;
  end;
end;



procedure TfrmRooms3.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////



procedure TfrmRooms3.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmRooms3.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmRooms3.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmRooms3.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmRooms3.btnCancelClick(Sender: TObject);
begin
  initRoomHolder(zData);
end;

procedure TfrmRooms3.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRooms3.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmRooms3.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
  //showmessage('Edit in grid');
  showmessage(GetTranslatedText('shTx_Room2_EditInGrid'));
end;

procedure TfrmRooms3.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('room').Focused := True;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmRooms3.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmRooms3.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmRooms3.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmRooms3.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmRooms3.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmRooms3.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

