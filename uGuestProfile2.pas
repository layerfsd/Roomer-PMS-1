unit uGuestProfile2;

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
  , ustringUtils

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
  , cxCustomPivotGrid



  , AdvEdit
  , AdvEdBtn

  , PrjConst

  , cmpRoomerDataSet
  , cmpRoomerConnection

  , sLabel
  , sCustomComboEdit
  , sComboBoxes
  , sComboEdit, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, cxMemo, sSplitter, sEdit, cxMaskEdit, cxButtonEdit,
  sCheckBox, sGroupBox, sButton, sPanel, sStatusBar, sSpeedButton, sSpinEdit, dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxEditRepositoryItems

  ;

type
  TfrmGuestProfile2 = class(TForm)
    sbMain: TsStatusBar;
    PanTop: TsPanel;
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
    sPanel1: TsPanel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    btnOther: TsButton;
    sPanel3: TsPanel;
    sPanel4: TsPanel;
    sPanel2: TsPanel;
    sButton1: TsButton;
    grbReservation: TsGroupBox;
    m_Person: TIntegerField;
    m_RoomReservation: TIntegerField;
    m_Reservation: TIntegerField;
    m_Name: TWideStringField;
    m_Surname: TWideStringField;
    m_Address1: TWideStringField;
    m_Address2: TWideStringField;
    m_Address3: TWideStringField;
    m_Address4: TWideStringField;
    m_Country: TWideStringField;
    m_Company: TWideStringField;
    m_GuestType: TWideStringField;
    m_Information: TMemoField;
    m_PID: TWideStringField;
    m_MainName: TBooleanField;
    m_Customer: TWideStringField;
    m_ID: TIntegerField;
    tvDataRecId: TcxGridDBColumn;
    tvDataPerson: TcxGridDBColumn;
    tvDataRoomReservation: TcxGridDBColumn;
    tvDataReservation: TcxGridDBColumn;
    tvDataName: TcxGridDBColumn;
    tvDataSurname: TcxGridDBColumn;
    tvDataAddress1: TcxGridDBColumn;
    tvDataAddress2: TcxGridDBColumn;
    tvDataAddress3: TcxGridDBColumn;
    tvDataAddress4: TcxGridDBColumn;
    tvDataCountry: TcxGridDBColumn;
    tvDataCompany: TcxGridDBColumn;
    tvDataGuestType: TcxGridDBColumn;
    tvDataInformation: TcxGridDBColumn;
    tvDataPID: TcxGridDBColumn;
    tvDataMainName: TcxGridDBColumn;
    tvDataCustomer: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    edSurName: TsEdit;
    sGroupBox1: TsGroupBox;
    memRoomNotes: TcxMemo;
    sSplitter1: TsSplitter;
    sGroupBox2: TsGroupBox;
    cxDBMemo1: TcxDBMemo;
    btnClearAddress: TsButton;
    labroom: TsLabel;
    labres: TsLabel;
    Label61: TsLabel;
    chkUseInNationalReport: TsCheckBox;
    sGroupBox3: TsGroupBox;
    sGroupBox4: TsGroupBox;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sGroupBox6: TsGroupBox;
    Label12: TsLabel;
    edrrDescription: TsEdit;
    btnGetCurrency: TsButton;
    edNewRoomRes: TsSpinEdit;
    StoreMain: TcxPropertiesStore;
    m_tel2: TWideStringField;
    m_Fax: TWideStringField;
    m_Email: TWideStringField;
    tvDatatel2: TcxGridDBColumn;
    tvDataFax: TcxGridDBColumn;
    tvDataEmail: TcxGridDBColumn;
    m_tel1: TWideStringField;
    tvDatatel1: TcxGridDBColumn;
    labResNumbers: TsLabel;
    Panel1: TsPanel;
    sButton2: TsButton;
    sButton3: TsButton;
    edNewReservation: TsEdit;
    btnConfirmNewReservation: TsSpeedButton;
    sLabel3: TsLabel;
    chkBlockMove: TsCheckBox;
    m_PersonsProfilesId: TIntegerField;
    tvDataPersonsProfilesId: TcxGridDBColumn;
    erGrid: TcxEditRepository;
    eriProfile: TcxEditRepositoryButtonItem;
    tvBtnSelectProfile: TcxGridDBColumn;
    tvBtnEdCurrProfile: TcxGridDBColumn;
    tvBtnNewProfile: TcxGridDBColumn;
    eriBtnSelectProfileVisable: TcxEditRepositoryButtonItem;
    eriBtnSelectProfileNotVisable: TcxEditRepositoryButtonItem;
    eriBtnNewProfileVisible: TcxEditRepositoryButtonItem;
    eriBtnNewProfileNotVisible: TcxEditRepositoryButtonItem;
    eriBtnEdCurrProfileNotVisible: TcxEditRepositoryButtonItem;
    eriBtnEdCurrProfileVisible: TcxEditRepositoryButtonItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnOtherClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure m_AfterPost(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sButton1Click(Sender: TObject);
    procedure btnClearAddressClick(Sender: TObject);
    procedure btnGetCurrencyClick(Sender: TObject);
    procedure edNewReservationPropertiesChange(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure btnConfirmNewReservationClick(Sender: TObject);
    procedure tvDataPersonsProfilesIdPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure sButton6Click(Sender: TObject);
    procedure tvSeLlistPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvBtnEdCurrPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvBtnNewProfilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvBtnSelectProfileGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvDataFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure tvBtnEdCurrProfileGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvBtnNewProfileGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvDataCountryPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    SettingMainName : Boolean;
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    zUseInNationalReport : boolean;
    zBlockMove : boolean;
    rrData : recRoomReservationHolder;


    zRoomReservation  : integer;
    zReservation      : integer;
    zCompany          : string ;
    zGuestType        : string ;
    zCustomer         : string ;
    zSurname          : string ;
    zCountry          : string ;

    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    procedure CorrectCurrentGuest(iGoto: Integer);
  public
    { Public declarations }
    zAct               : TActTableAction;
    zData              : recPersonHolder;
  end;

function openGuestProfile(act : TActTableAction; var theData : recPersonHolder) : boolean;


var
  frmGuestProfile2: TfrmGuestProfile2;

implementation

uses
    uD
  , uSqlDefinitions
  , uMain
  , uDayNotes
  , uDImages
  , uGuestProfiles
  , uGuestPortfolioEdit
  , uRoomerDefinitions
  , uReservationStateDefinitions
  , uCountries
  , uAlerts
  , uUtils
  ;

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openGuestProfile(act : TActTableAction; var theData : recPersonHolder) : boolean;
var
  rr : integer;
begin
  result := true;
  frmGuestProfile2 := TfrmGuestProfile2.Create(frmGuestProfile2);
  try
    frmGuestProfile2.zData := theData;
    frmGuestProfile2.zAct := act;
    frmGuestProfile2.ShowModal;
    theData := frmGuestProfile2.zData;
    if d.isGroup(thedata.RoomReservation) then
      rr := 0
    else
      rr := thedata.RoomReservation;
    d.roomerMainDataSet.SystempackagesRecalcInvoice(rr, thedata.RoomReservation);
  finally
    freeandnil(frmGuestProfile2);
  end;
end;

//END unit global functions


///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////

Procedure TfrmGuestProfile2.fillGridFromDataset(sGoto : string);
var
  s    : string;
  rSet : TRoomerDataSet;
  active : boolean;
begin

  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'MainName DESC, Name ASC ';
  rSet := CreateNewDataSet;
  try
		s := format(select_Persons_byReservation, [zData.RoomReservation,zSortStr]);
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
            m_.Locate('Person',sGoto,[]);
          except
          end;
        end;
     end;
  finally
    freeandnil(rSet);
  end;
end;


//    Person           : integer;
//    RoomReservation  : integer;
//    Reservation      : integer;
//    name             : string ;
//    Surname          : string ;
//    Address1         : string ;
//    Address2         : string ;
//    Address3         : string ;
//    Address4         : string ;
//    Country          : string ;
//    Company          : string ;
//    GuestType        : string ;
//    Information      : string ;
//    PID              : string ;
//    MainName         : boolean;
//    Customer         : string ;


procedure  TfrmGuestProfile2.fillHolder;
begin
  initPersonHolder(zData);
  zData.ID                     := m_.fieldbyname('ID'             ).asinteger;
  zData.Person                 := m_.fieldbyname('Person'         ).asinteger;
  zData.RoomReservation        := m_.fieldbyname('RoomReservation').asinteger;
  zData.Reservation            := m_.fieldbyname('Reservation'    ).asinteger;
  zData.name                   := m_.fieldbyname('name'           ).asstring ;
  zData.Surname                := m_.fieldbyname('Surname'        ).asstring ;
  zData.Address1               := m_.fieldbyname('Address1'       ).asstring ;
  zData.Address2               := m_.fieldbyname('Address2'       ).asstring ;
  zData.Address3               := m_.fieldbyname('Address3'       ).asstring ;
  zData.Address4               := m_.fieldbyname('Address4'       ).asstring ;
  zData.Country                := m_.fieldbyname('Country'        ).asstring ;
  zData.Company                := m_.fieldbyname('Company'        ).asstring ;
  zData.GuestType              := m_.fieldbyname('GuestType'      ).asstring ;
  zData.Information            := m_.fieldbyname('Information'    ).asstring ;
  zData.PID                    := m_.fieldbyname('PID'            ).asstring ;
  zData.MainName               := m_.fieldbyname('MainName'       ).asboolean;
  zData.Customer               := m_.fieldbyname('Customer'       ).asstring ;
  zData.tel1                   := m_.fieldbyname('tel1'       ).asstring ;
  zData.tel2                   := m_.fieldbyname('tel2'       ).asstring ;
  zData.fax                    := m_.fieldbyname('fax'       ).asstring ;
  zData.email                  := m_.fieldbyname('email'       ).asstring ;

end;


procedure TfrmGuestProfile2.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataPerson         .Options.Editing       := false;
    tvDataRoomReservation.Options.Editing       := false;
    tvDataReservation    .Options.Editing       := false;
    tvDataname           .Options.Editing       := true ;
    tvDataSurname        .Options.Editing       := true ;
    tvDataAddress1       .Options.Editing       := true ;
    tvDataAddress2       .Options.Editing       := true ;
    tvDataAddress3       .Options.Editing       := true ;
    tvDataAddress4       .Options.Editing       := true ;
    tvDataCountry        .Options.Editing       := true ;
    tvDataCompany        .Options.Editing       := true ;
    tvDataGuestType      .Options.Editing       := true ;
    tvDataInformation    .Options.Editing       := true ;
    tvDataPID            .Options.Editing       := true ;
    tvDataMainName       .Options.Editing       := true ;
    tvDataTel1           .Options.Editing       := true ;
    tvDataTel2           .Options.Editing       := true ;
    tvDataFax            .Options.Editing       := true ;
    tvDataEmail          .Options.Editing       := true ;
  end else
  begin
    tvDataPerson         .Options.Editing       :=false ;
    tvDataRoomReservation.Options.Editing       :=false ;
    tvDataReservation    .Options.Editing       :=false ;
    tvDataname           .Options.Editing       :=false ;
    tvDataSurname        .Options.Editing       :=false ;
    tvDataAddress1       .Options.Editing       :=false ;
    tvDataAddress2       .Options.Editing       :=false ;
    tvDataAddress3       .Options.Editing       :=false ;
    tvDataAddress4       .Options.Editing       :=false ;
    tvDataCountry        .Options.Editing       :=false ;
    tvDataCompany        .Options.Editing       :=false ;
    tvDataGuestType      .Options.Editing       :=false ;
    tvDataInformation    .Options.Editing       :=false ;
    tvDataPID            .Options.Editing       :=false ;
    tvDataMainName       .Options.Editing       :=false ;
    tvDataTel1           .Options.Editing       :=false ;
    tvDataTel2           .Options.Editing       :=false ;
    tvDataFax            .Options.Editing       :=false ;
    tvDataEmail          .Options.Editing       :=false ;
  end;
end;


procedure TfrmGuestProfile2.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.Name);
  zFirstTime := false;
end;



procedure TfrmGuestProfile2.edNewReservationPropertiesChange(Sender: TObject);
begin
end;

/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmGuestProfile2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ResName : string;
  s : string;
begin
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;

  resName := edSurName.Text;
  if trim(resName) <> trim(zSurName) then
  begin
 //   if MessageDlg('Reservation Name changed - sure ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
	if MessageDlg(GetTranslatedText('shTx_GuestProfile2_NameChange'), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      d.RV_Upd_Name(zReservation, resName);
      frmMain.refreshGrid
    end;
  end;

  d.RR_Upd_MemoTexts(zRoomReservation, memRoomNotes.text);

  if (chkUseInNationalReport.checked <> zUseInNationalReport) OR
     (chkBlockMove.checked <> zBlockMove) then
  begin
    s := '';
    s := s + 'UPDATE roomreservations ';
    s := s + ' SET ';
    s := s + 'useInNationalReport = ' + _db(chkUseInNationalreport.checked);
    s := s + ', blockMove = ' + _db(chkBlockMove.checked);
    s := s + ' WHERE ';
    s := s + '  RoomReservation = ' + _db(zRoomReservation);
    if not cmd_bySQL(s) then
    begin
    end;
  end;
end;

procedure TfrmGuestProfile2.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  zFirstTime  := true;
  zAct        := actNone;
  SettingMainName := False;
//  D.LoadTcxGridColumnOrder(self, grData);
end;

procedure TfrmGuestProfile2.FormShow(Sender: TObject);
var
  sMemText       : string;
  roomNumber     : string;
  ResGuestCount  : integer;
  RoomGuestCount : integer;
  RoomsCount     : integer;
begin
  fillGridFromDataset(zData.Name);

  //Values trhat are same for all guests
  zRoomReservation  := m_.fieldbyname('RoomReservation').asinteger  ;
  zReservation      := m_.fieldbyname('Reservation').asinteger      ;
  zCompany          := m_.fieldbyname('Company').asString           ;
  zGuestType        := m_.fieldbyname('GuestType').asString         ;
  zCustomer         := m_.fieldbyname('Customer').asString          ;
  zSurname          := m_.fieldbyname('surName').asString          ;
  zCountry          := m_.fieldbyname('Country').asString          ;
  edSurName.text := zSurName;

  sbMain.SimpleText := zSortStr;

  rrData := SP_GET_RoomReservation(zRoomReservation);

  memRoomNotes.Text              := rrData.HiddenInfo;
  roomNumber                     := rrData.Room;
  chkUseInNationalReport.Checked := rrData.UseInNationalReport;
  chkBlockMove.Checked := rrData.BlockMove;
  zUseInNationalReport           := chkUseInNationalReport.Checked;
  zBlockMove := chkBlockMove.Checked;

//  if d.RR_GetMemoText(zRoomReservation, sMemText) then
//  begin
//    memRoomNotes.Text := sMemText;
//  end;

  ResGuestCount  := RV_GuestCount(zReservation);
  RoomGuestCount := d.RR_GetGuestCount(zRoomReservation);
  roomsCount     := d.RR_GetNumberOfRooms(zReservation);

  labres.caption := format(GetTranslatedText('shTx_GuestProfile2_RoomsInReservation'), [RoomsCount, ResGuestCount]);

  //labroom.caption    := 'Room no. ' + roomNumber + ' with '+ inttostr(RoomGuestCount) + ' guests';
  //sGroupBox1.Caption := 'Notes for room no. ' + roomNumber;
  labroom.caption    := format(GetTranslatedText('shTx_GuestProfile2_RoomNoWithGuests'), [roomNumber, RoomGuestCount]);
  sGroupBox1.Caption := format(GetTranslatedText('shTx_GuestProfile2_NotesForRoom'), [roomNumber]);

  mnuiAllowGridEdit.Checked := true;
//  btnClose.Visible := true;
  sbMain.Visible := true;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  zFirstTime := false;

  labresnumbers.caption := inttostr(zReservation)+' / '+inttostr(zRoomReservation);

  ShowAlertsForReservation(0, zRoomReservation, atOPEN_RESERVATION);

end;

procedure TfrmGuestProfile2.FormDestroy(Sender: TObject);
begin
//  D.SaveTcxGridColumnOrder(self, grData);
  //
end;

procedure TfrmGuestProfile2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmGuestProfile2.FormKeyPress(Sender: TObject; var Key: Char);
begin
end;


////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////
procedure TfrmGuestProfile2.m_AfterPost(DataSet: TDataSet);
var
  Bookmark: TBookmark;
  AnyMainName : Boolean;
begin
  if SettingMainName then exit;

  SettingMainName := True;
  try
    Bookmark := m_.GetBookmark; { Allocate memory and assign a value }
    m_.DisableControls; { Turn off display of records in data controls }
    try
      AnyMainName := False;
      m_.First; { Go to first record in table }
      while not m_.Eof do {Iterate through each record in table }
      begin
        { Do your processing here }
        AnyMainName := m_['MainName'];
        if AnyMainName then
          Break;

        m_.Next;
      end;
      if NOT AnyMainName then
      begin
        m_.First;
        m_.Edit;
        m_['MainName'] := True;
        m_.Post;
      end;
    finally
      m_.GotoBookmark(Bookmark);
      m_.EnableControls; { Turn on display of records in data controls, if necessary }
    end;
  finally
    SettingMainName := False;
  end;
end;


procedure TfrmGuestProfile2.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  //**
  fillHolder;

  if hdata.PersonExistsInOther(zData.Person) then
  begin
	  Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Person', zData.Name]));
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeletePerson')+' '+zData.name+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    screen.Cursor := crHourGlass;
    try
      if not Del_Person(zData) then
      begin
        abort
      end;
    finally
      screen.Cursor := crDefault;
    end;
  end else
  begin
    abort;
  end;
end;

procedure TfrmGuestProfile2.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if dataset.Eof then exit;
  if zFirstTime then exit;
  nId := 0;

  initPersonHolder(zData);
  zData.ID                   := dataset.FieldByName('ID').AsInteger;
  zData.Person               := dataset['Person'         ];
  zData.RoomReservation      := dataset['RoomReservation'];
  zData.Reservation          := dataset['Reservation'    ];
  zData.name                 := dataset['name'           ];
  zData.Surname              := dataset['Surname'        ];
  zData.Address1             := dataset['Address1'       ];
  zData.Address2             := dataset['Address2'       ];
  zData.Address3             := dataset['Address3'       ];
  zData.Address4             := dataset['Address4'       ];
  zData.Country              := dataset['Country'        ];
  zData.Company              := dataset['Company'        ];
  zData.GuestType            := dataset['GuestType'      ];
  zData.Information          := dataset['Information'    ];
  zData.PID                  := dataset['PID'            ];
  zData.MainName             := dataset['MainName'       ];
  zData.Customer             := dataset['Customer'       ];
  zData.tel1                 := dataset['Tel1'       ];
  zData.tel2                 := dataset['Tel2'       ];
  zData.Fax                  := dataset['Fax'       ];
  zData.Email                := dataset['Email'       ];
  zData.PersonsProfilesId    := dataset['PersonsProfilesId'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_Person(zData) then
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
    if dataset.FieldByName('name').AsString = ''  then
    begin
	    showmessage(GetTranslatedText('shTx_GuestProfile2_NameRequired'));

      tvData.GetColumnByFieldName('name').Focused := True;
      abort;
      exit;
    end;

    if ins_Person(zData,nID) then
    begin
      m_.FieldByName('ID').AsInteger := nID;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;

procedure TfrmGuestProfile2.m_NewRecord(DataSet: TDataSet);
begin
  if dataset.Eof then exit;

  if zFirstTime then exit;
  dataset['Person'         ] := PE_SetNewID();
  dataset['RoomReservation'] := zRoomReservation;
  dataset['Reservation'    ] := zReservation;
  dataset['name'           ] := '';
  dataset['Surname'        ] := zSurName;
  dataset['Address1'       ] := '';
  dataset['Address2'       ] := '';
  dataset['Address3'       ] := '';
  dataset['Address4'       ] := '';
  dataset['Country'        ] := zCountry;
  dataset['Company'        ] := zCompany;
  dataset['GuestType'      ] := zGuestType;
  dataset['Information'    ] := '';
  dataset['PID'            ] := '';
  dataset['MainName'       ] := false;
  dataset['Customer'       ] := zCustomer;
  dataset['Tel1'           ] := '';
  dataset['Tel2'           ] := '';
  dataset['Fax'            ] := '';
  dataset['Email'          ] := '';

  dataset['PersonsProfilesId'] := 0;

  dataset.Edit;
  dataset['name'           ] := 'Added guest';
  dataset.Post;
end;

procedure TfrmGuestProfile2.sButton1Click(Sender: TObject);
var
  sMemText,s : string;
begin
  if g.openresMemo(zReservation) then
  begin
    if d.RR_GetMemoText(zRoomReservation, sMemText) then
    begin
      memRoomNotes.Text := sMemText;
    end;
  end;
end;

procedure TfrmGuestProfile2.sButton2Click(Sender: TObject);
begin
  fillHolder;
end;


procedure TfrmGuestProfile2.sButton6Click(Sender: TObject);
begin
end;

////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////


procedure TfrmGuestProfile2.CorrectCurrentGuest(iGoto : Integer);
var s1, s2, s3 : String;
begin
  m_.Edit;

  m_['PersonsProfilesId'] := iGoto;

  glb.LocateSpecificRecordAndGetValue('personprofiles', 'ID', inttostr(iGoto), 'Firstname', s1);
  glb.LocateSpecificRecordAndGetValue('personprofiles', 'ID', inttostr(iGoto), 'Lastname', s2);
  s3 := trim(s1 + ' ' + s2);
  m_['Name'] := s3;

  m_['Address1'] := glb.PersonProfiles['Address1'];
  m_['Address2'] := glb.PersonProfiles['Address2'];
  m_['Address3'] := glb.PersonProfiles['Zip'];
  m_['Address4'] := glb.PersonProfiles['City'];
  m_['Country'] := glb.PersonProfiles['Country'];
  m_['Tel1'] := glb.PersonProfiles['TelLandLine'];
  m_['Tel2'] := glb.PersonProfiles['TelMobile'];
  m_['Email'] := glb.PersonProfiles['Email'];
  m_['Information'] := glb.PersonProfiles['Information'];

  m_.Post;
end;

procedure TfrmGuestProfile2.tvDataPersonsProfilesIdPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
end;



////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

//  if NOT m_.Eof then
//  begin
////    inc(iiii);
//    rgrPersonsProfile.Properties.Buttons[0].Visible := m_['MainName'];
//    rgrPersonsProfile.Properties.Buttons[1].Visible := m_['PersonsProfilesId'] > 0;
//    rgrPersonsProfile.Properties.Buttons[2].Visible := m_['MainName'] AND (m_['PersonsProfilesId'] <= 0);
//    rgrPersonsProfile.Properties.Buttons[0].Enabled := m_['MainName'];
//    rgrPersonsProfile.Properties.Buttons[1].Enabled := m_['PersonsProfilesId'] > 0;
//    rgrPersonsProfile.Properties.Buttons[2].Enabled := m_['MainName'] AND (m_['PersonsProfilesId'] <= 0);
////    label1.Caption := inttostr(iiii)+' / '+inttostr(aRecord.Index);
////     label2.Caption := booltostr(isMainName)+' - '+inttostr(PersonsProfilesId);
//  end;


//      isMainname := Arecord.Values[tvDataMainName.index];
//      PersonsProfilesId := Arecord.Values[tvDataPersonsProfilesId.index];


procedure TfrmGuestProfile2.tvBtnSelectProfileGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
var
  isMainName : boolean;
begin
  if zfirsttime then exit;
  if arecord.Index >=0  then
  begin
    try
      isMainname := Arecord.Values[tvDataMainName.index];
      if isMainName then
      begin
        AProperties :=  eriBtnSelectProfileVisable.Properties;
      end else
      begin
        AProperties :=  eriBtnSelectProfileNotVisable.Properties
      end;
    except
    end;
  end;
end;


procedure TfrmGuestProfile2.tvBtnEdCurrProfileGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
var
  PersonsProfilesId : integer;
  isMainName : boolean;
begin
  if zfirsttime then exit;
  if arecord.Index >=0  then
  begin
    try
      PersonsProfilesId := Arecord.Values[tvDataPersonsProfilesId.index] ;
      isMainname := Arecord.Values[tvDataMainName.index];
      if (isMainName) AND (PersonsProfilesId > 0) then
      begin
        AProperties :=  eriBtnEdCurrProfileVisible.Properties;
      end else
      begin
        AProperties :=  eriBtnEdCurrProfileNotVisible.Properties
      end;
    except
    end;
  end;
end;


procedure TfrmGuestProfile2.tvBtnNewProfileGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
var
  PersonsProfilesId : integer;
  isMainName : boolean;
begin
  if zfirsttime then exit;
  if arecord.Index >=0  then
  begin
    try
      PersonsProfilesId := Arecord.Values[tvDataPersonsProfilesId.index];
      isMainname := Arecord.Values[tvDataMainName.index];
      if (isMainName) AND (PersonsProfilesId <= 0) then
      begin
        AProperties :=  eriBtnNewProfileVisible.Properties;
      end else
      begin
        AProperties :=  eriBtnNewProfileNotVisible.Properties
      end;
    except
    end;
  end;
end;

procedure TfrmGuestProfile2.tvSeLlistPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  iGoTo : integer;
  s : string;
begin
  iGoto := -1;
  if m_['PersonsProfilesId'] > 0 then
    iGoto := m_['PersonsProfilesId'];

  iGoto := GuestProfiles(actLookup, iGoto);
  if iGoto > 0 then
  begin
    s := format('UPDATE persons pe, ' +
                'personprofiles pp ' +
                'SET PersonsProfilesId=pp.Id, ' +
                'pe.title = pp.title, ' +
                'pe.Name = TRIM(CONCAT(pp.FirstName, '' '', pp.LastName)), ' +
                'pe.Address1 = pp.Address1, ' +
                'pe.Address2 = pp.Address2, ' +
                'pe.Address3 = pp.Zip, ' +
                'pe.Address4 = pp.City, ' +
                'pe.Country = pp.Country, ' +
                'pe.Tel1 = pp.TelLandLine, ' +
                'pe.Tel2 = pp.TelMobile, ' +
                'pe.Fax = pp.TelFax, ' +
                'pe.Email = pp.Email, ' +
                'pe.Information = pp.Information, ' +
                'pe.Nationality = pp.Nationality, ' +
                'pe.Customer = pp.CustomerCode, ' +
                'pe.Surname = pp.CompanyName, ' +
                'pe.CompanyName = pp.CompanyName, ' +
                'pe.CompAddress1 = pp.CompAddress1, ' +
                'pe.CompAddress2 = pp.CompAddress2, ' +
                'pe.CompZip = pp.CompZip, ' +
                'pe.CompCity = pp.CompCity, ' +
                'pe.CompCountry = pp.CompCountry, ' +
                'pe.CompTel = pp.CompTel, ' +
                'pe.CompEmail = pp.CompEmail, ' +
                'pe.state = pp.state, ' +
                'pe.DateOfBirth = pp.DateOfBirth ' +
                'WHERE pp.Id=%d AND ' +
                'pe.MainName=1 AND pe.Reservation=%d AND pe.RoomReservation=%d',
                [
                  iGoto,
                  m_.FieldByName('Reservation').asinteger,
                  m_.FieldByName('RoomReservation').asinteger
                ]);
    d.roomerMainDataSet.DoCommand(s);
    CorrectCurrentGuest(iGoto);
  end;
end;

procedure TfrmGuestProfile2.tvBtnEdCurrPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  iGoTo : integer;
begin
    iGoto := -1;
    if m_['PersonsProfilesId'] > 0 then
      iGoto := m_['PersonsProfilesId'];
    if OpenGuestPortfolioEdit(glb.PersonProfiles, iGoto, false) then
    begin
      CorrectCurrentGuest(iGoto);
    end;
end;

procedure TfrmGuestProfile2.tvBtnNewProfilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  iGoto : integer;
begin
  iGoto := CreateNewGuest(glb.PersonProfiles, m_['Person']);
  if iGoto > 0 then
  begin
    CorrectCurrentGuest(iGoto);
  end;
end;

procedure TfrmGuestProfile2.tvDataCountryPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recCountryHolder;
  s : string;
begin

  theData.Country := m_.fieldbyname('Country').AsString;
  if Countries(actLookup,theData) then
  begin
    if m_.fieldbyname('Country').AsString <> thedata.Country then
    begin
      if m_.FieldByName('mainname').AsBoolean = true then
      begin
        s := '';
        s := s+'Change All gests countries to '+' '+thedata.Country+' '+chr(10);
        s := s+'If No then only this guest will be changed '+chr(10);
        s := s+GetTranslatedText('shContinue');
        if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          m_.first;
          while not m_.Eof do
          begin
            m_.Edit;
            m_.fieldbyname('Country').AsString := thedata.Country;
            m_.Post;
            m_.next;
          end;
          m_.First;
        end else
        begin
          m_.Edit;
          m_.fieldbyname('Country').AsString := thedata.Country;
          m_.Post;
        end;
      end else
      begin
        m_.Edit;
        m_.fieldbyname('Country').AsString := thedata.Country;
        m_.Post;
      end;
    end;
  end;
end;



//var
//  theData : recRoomTypeGroupHolder;
//begin
//  fillholder;
//  theData.Code := zData.RoomTypeGroup;
////  theData.ID := zData. CurrencyID;
//
//  openRoomTypeGroups(actlookup,theData);
//
//  if theData.code <> '' then
//  begin
//    if tvData.DataController.DataSource.State <> dsInsert then m_.Edit;
//    m_['RoomTypeGroup']   := theData.code;
////    m_['currencyID'] := theData.ID;
//  end;
//end;

procedure TfrmGuestProfile2.tvDataDataControllerSortingChanged(Sender: TObject);
var
  i : integer;
  s : string;
  serval : boolean;
begin
  s := '';
  serval := false;
  for i :=  0 to tvData.SortedItemCount - 1 do
  begin
    if TcxGridDBColumn(tvData.SortedItems[I]).DataBinding.FieldName = '' then continue;

    if serval then s := s+', ';
    s := s+TcxGridDBColumn(tvData.SortedItems[I]).DataBinding.FieldName;
    serval := true;
    if tvData.SortedItems[i].SortOrder = soDescending then
    s := s + ' DESC';
  end;
  zSortStr := s;
  sbMain.SimpleText := s;
end;



procedure TfrmGuestProfile2.tvDataFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  //tvData.Invalidate();
end;

//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////

procedure TfrmGuestProfile2.btnCancelClick(Sender: TObject);
begin
  initPersonHolder(zData);
end;

procedure TfrmGuestProfile2.btnOtherClick(Sender: TObject);
begin
  //
end;

procedure TfrmGuestProfile2.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  grData.SetFocus;
  m_.Insert;
  tvData.GetColumnByFieldName('Person').Focused := True;

end;

procedure TfrmGuestProfile2.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Person').Focused := True;
  showmessage(GetTranslatedText('shTx_GuestProfile2_EditInGrid'));
end;

procedure TfrmGuestProfile2.btnGetCurrencyClick(Sender: TObject);
var
  s : string;
  newReservation : integer;
  ExecutionPlan : TRoomerExecutionPlan;
  reservationData : recReservationHolder;

  NewResName : string;
  rSet : TRoomerDataset;

begin
  newReservation := edNewRoomRes.Value;
  reservationData := SP_GET_Reservation(newReservation);

  if newReservation = zReservation then
  begin
  	showmessage(GetTranslatedText('shTx_GuestProfile2_ReservationSame'));
    exit
  end;

  if reservationData.Reservation = 0 then
  begin
  	showmessage(GetTranslatedText('shTx_GuestProfile2_ReservationNotFound'));
    exit
  end;
  NewResName := reservationData.name;

  s := '';
  //s := s+'Move this room to another reservation '#13#10;
  //s := s+'New Reservation : '+reservationData.name+#13#10;
  //s := s+'New Customer : '+reservationData.Customer+#13#10;
  s := format(GetTranslatedText('shTx_GuestProfile2_MoveReservationNewResNewCust'),
              [reservationData.name,reservationData.Customer]);

  if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrNO then
  begin
    exit;
  end;

  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    try
      ExecutionPlan.BeginTransaction;

      s := '';
      s := s + 'Update roomreservations '+#10;
      s := s + 'Set Reservation = ' + _db(newReservation)+#10;
      s := s + ' where RoomReservation = ' + _db(zRoomReservation)+#10;;
      ExecutionPlan.AddExec(s);

      s := '';
      s := s + 'Update roomsdate '+#10;
      s := s + 'Set Reservation = ' + _db(newReservation)+#10;
      s := s + ' where (RoomReservation = ' + _db(zRoomReservation)+') '+#10;;
      s := s + '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) ';       //**zxhj line added

      ExecutionPlan.AddExec(s);

      s := '';
      s := s + ' Update invoiceheads '+#10;
      s := s + 'Set Reservation = ' + _db(newReservation)+#10;
      s := s + ' where RoomReservation = ' + inttostr(zRoomReservation);
      ExecutionPlan.AddExec(s);

      s := '';
      s := s + ' Update invoicelines '+#10;
      s := s + 'Set Reservation = ' + _db(newReservation)+#10;
      s := s + ' where RoomReservation = ' + _db(zRoomReservation);
      ExecutionPlan.AddExec(s);

      s := '';
      s := s + 'Update persons '+#10;
      s := s + 'Set Reservation = ' + _db(newReservation)+#10;
      s := s + ',SurName = ' + _db(newResName)+#10;
      s := s + ' where RoomReservation = ' + _db(zRoomReservation);
      ExecutionPlan.AddExec(s);

      if ExecutionPlan.Execute(ptExec, False, True) then
        ExecutionPlan.CommitTransaction
      else
        raise Exception.Create(ExecutionPlan.ExecException);

    Except
      on e : Exception do
      begin
       // frmDayNotes.xDoLog('Change room to another reservation', e.message);
		    frmDayNotes.xDoLog(GetTranslatedText('shTx_GuestProfile2_ChangeRoom'), e.message);
       // MessageDlg('Problem: Change room to another reservation '+#13#13 + 'The following Error came up:' + #13#13 +
       //     e.message + #13#13 + 'Please write this message down or' + #13 + 'call support with this dialog open!', mtError, [mbOK], 0);
		    MessageDlg(format(GetTranslatedText('shTx_GuestProfile2_ProblemChange'), [e.message]), mtError, [mbOK], 0);
        raise ;
      end;
    end;
  finally
    freeandNil(ExecutionPlan)
  end;

  rSet := CreateNewDataSet;
  try
    s := 'SELECT reservation FROM roomreservations WHERE reservation = '+_db(zReservation)+' LIMIT 1';
    if not hData.rSet_bySQL(rSet,s) then
    begin
//	   showmessage(format(GetTranslatedText('shTx_GuestProfile2_NoRooms'), [zReservation]));

     if not Del_ReservationByreservation(zreservation) then
     begin
       showmessage('Could not clear empty reservation');
     end else
     begin
  //     showmessage(format(GetTranslatedText('shTx_GuestProfile2_NoRooms'), [zReservation]));
     end;

    end;
  finally
    freeandnil(rset);
  end;

end;

procedure TfrmGuestProfile2.btnConfirmNewReservationClick(Sender: TObject);
var
  reservationData : recReservationHolder;
  newReservation  : integer;
  s : string;
  ExecutionPlan : TRoomerExecutionPlan;
  rSet : TRoomerDataset;

begin
  rSet := CreateNewDataSet;
  try
    s := 'SELECT reservation FROM roomreservations WHERE reservation = '+_db(zReservation)+' ';
    hData.rSet_bySQL(rSet,s);
    if rSet.RecordCount < 2 then
    begin
      showmessage('There are only '+inttostr(rSet.RecordCount)+' rooms in this reservation - Cancelled');
      Exit;
    end else
    begin
    end;
  finally
    freeandnil(rSet);
  end;

  btnConfirmNewReservation.Enabled := false;

  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    try
      reservationData := SP_GET_Reservation(zReservation);
      newReservation := hData.RV_SetNewID();
      reservationData.Reservation := NewReservation;
      reservationData.name     := edNewReservation.text;

      ExecutionPlan.BeginTransaction;
      ExecutionPlan.AddExec(SQL_INS_Reservation(reservationData));

      s := '';
      s := s + ' UPDATE roomreservations '+#10;
      s := s + ' SET '+#10;
      s := s + '   Reservation = ' + _db(newReservation) + ' '+#10;
      s := s + ' WHERE '+#10;
      s := s + '   (RoomReservation = ' + _db(zRoomReservation) + ')'+#10;
      ExecutionPlan.AddExec(s);

      s := '';
      s := s + ' UPDATE invoiceheads '+#10;
      s := s + ' SET '+#10;
      s := s + '   Reservation = ' + _db(newReservation) + ' '+#10;
      s := s + ' WHERE '+#10;
      s := s + '   (RoomReservation = ' + _db(zRoomReservation) + ') '+#10;
      ExecutionPlan.AddExec(s);

      s := '';
      s := s + ' UPDATE invoicelines '+#10;
      s := s + ' SET '+#10;
      s := s + '   Reservation = ' + _db(newReservation) + ' '+#10;
      s := s + ' WHERE '+#10;
      s := s + '   (RoomReservation = ' + _db(zRoomReservation) + ') '+#10;
      ExecutionPlan.AddExec(s);


      s := '';
      s := s + ' UPDATE persons '+#10;
      s := s + ' SET '+#10;
      s := s + '    Reservation = ' + _db(newReservation) + ' '+#10;
      s := s + '   ,SurName = ' + _db(edNewReservation.text) + ' '+#10;
      s := s + ' WHERE '+#10;
      s := s + '   (RoomReservation = ' + _db(zRoomReservation) + ') '+#10;
      ExecutionPlan.AddExec(s);


      s := '';
      s := s + ' UPDATE roomsdate '+#10;
      s := s + ' SET '+#10;
      s := s + '   Reservation = ' + _db(newReservation) + ' '+#10;
      s := s + ' WHERE '+#10;
      s := s + '   (RoomReservation = ' + _db(zRoomReservation) + ') '+#10;
      s := s + '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '; //**zxhj line added
      ExecutionPlan.AddExec(s);
      if ExecutionPlan.Execute(ptExec, False, True) then
        ExecutionPlan.CommitTransaction
      else
        raise Exception.Create(ExecutionPlan.ExecException);


    Except
      on e : Exception do
      begin
	 (* frmDayNotes.xDoLog('split room to new reservation', e.message);
        MessageDlg('Problem: Unable to split room to new reservation '+#13#13 + 'The following Error came up:' + #13#13 +
            e.message + #13#13 + 'Please write this message down or' + #13 + 'call support with this dialog open!', mtError, [mbOK], 0); *)
        frmDayNotes.xDoLog(GetTranslatedText('shTx_GuestProfile2_SplitRoom'), e.message);
        MessageDlg(format(GetTranslatedText('shTx_GuestProfile2_UnableToSplitRoom'), [e.message]), mtError, [mbOK], 0);
        raise ;
      end;
    end;
  finally
    freeandNil(ExecutionPlan)
  end;
  // check if any invoices has been made
end;

procedure TfrmGuestProfile2.btnClearAddressClick(Sender: TObject);
begin
  if (m_.State <> dsEdit) or (m_.State <> dsInsert) then
  begin
    m_.edit;
  end;
  m_.fieldbyname('Address1').asstring := '';
  m_.fieldbyname('Address2').asstring := '';
  m_.fieldbyname('Address3').asstring := '';
  m_.fieldbyname('Address4').asstring := '';
end;

procedure TfrmGuestProfile2.btnDeleteClick(Sender: TObject);
begin
  if m_.RecordCount = 1 then exit;
  if m_['MainName'] = true then exit;
  m_.Delete;
end;


////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmGuestProfile2.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;

  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmGuestProfile2.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmGuestProfile2.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmGuestProfile2.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmGuestProfile2.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmGuestProfile2.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;


end.


