unit uGroupGuests;

interface

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
  , Vcl.StdCtrls
  , Vcl.ExtCtrls
  , Vcl.ComCtrls

  , Data.DB
  , hData

  , kbmMemTable
  , shellApi
  , cmpRoomerDataSet
  , cmpRoomerConnection

  , _glob
  , ug
  , uUtils
  , uappGlobal

  , sPageControl
  , sButton
  , sPanel

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
  , cxGridCustomView
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridBandedTableView
  , cxGridDBBandedTableView
  , cxClasses
  , cxGridLevel
  , cxGrid
  , dxSkinsCore
  , cxGridExportLink


  , dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue

  , dxSkinscxPCPainter, sGroupBox, sEdit, sLabel, sCheckBox, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv,
  dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers,
  dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, Vcl.Menus, dxPSCore, dxPScxCommon, cxPropertiesStore, cxButtonEdit, dxPScxPivotGridLnk,
  dxmdaset, ALHttpClient, ALWininetHttpClient


  ;

type
  TfrmGroupGuests = class(TForm)
    sPanel1: TsPanel;
    panBtn: TsPanel;
    BtnOk: TsButton;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sPanel2: TsPanel;
    lvGuests: TcxGridLevel;
    grGuests: TcxGrid;
    tvGuests: TcxGridDBBandedTableView;
    _kbmGuests: TkbmMemTable;
    kbmGuestsDS: TDataSource;
    _kbmCompare: TkbmMemTable;
    CompareDS: TDataSource;
    rgrShow: TsRadioGroup;
    btnExcel: TsButton;
    sButton1: TsButton;
    btnExpand: TsButton;
    btnCollapse: TsButton;
    btnEdit: TsButton;
    btnOther: TsButton;
    btnClearAddress: TsButton;
    chkCompactView: TsCheckBox;
    tvGuestsId: TcxGridDBBandedColumn;
    tvGuestsPerson: TcxGridDBBandedColumn;
    tvGuestsReservation: TcxGridDBBandedColumn;
    tvGuestsRoomReservation: TcxGridDBBandedColumn;
    tvGuestsPersonsProfilesId: TcxGridDBBandedColumn;
    tvGueststitle: TcxGridDBBandedColumn;
    tvGuestsname: TcxGridDBBandedColumn;
    tvGuestsAddress1: TcxGridDBBandedColumn;
    tvGuestsAddress2: TcxGridDBBandedColumn;
    tvGuestsAddress3: TcxGridDBBandedColumn;
    tvGuestsAddress4: TcxGridDBBandedColumn;
    tvGuestsCountry: TcxGridDBBandedColumn;
    tvGuestsTel1: TcxGridDBBandedColumn;
    tvGuestsTel2: TcxGridDBBandedColumn;
    tvGuestsFax: TcxGridDBBandedColumn;
    tvGuestsEmail: TcxGridDBBandedColumn;
    tvGuestsNationality: TcxGridDBBandedColumn;
    tvGuestsPID: TcxGridDBBandedColumn;
    tvGuestsMainName: TcxGridDBBandedColumn;
    tvGuestsCustomer: TcxGridDBBandedColumn;
    tvGuestsState: TcxGridDBBandedColumn;
    tvGuestsPersonalIdentificationId: TcxGridDBBandedColumn;
    tvGuestsDateOfBirth: TcxGridDBBandedColumn;
    tvGuestsSocialSecurityNumber: TcxGridDBBandedColumn;
    tvGuestsroom: TcxGridDBBandedColumn;
    tvGuestsBreakfast: TcxGridDBBandedColumn;
    tvGuestsrrArrival: TcxGridDBBandedColumn;
    tvGuestsrrDeparture: TcxGridDBBandedColumn;
    tvGuestsnumGuests: TcxGridDBBandedColumn;
    tvGuestsRoomDescription: TcxGridDBBandedColumn;
    tvGuestsStatusText: TcxGridDBBandedColumn;
    tvGuestsroomDetails: TcxGridDBBandedColumn;
    FormStore: TcxPropertiesStore;
    grPrinter: TdxComponentPrinter;
    mnuOther: TPopupMenu;
    mnuiPrint: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    grPrinterLink1: TdxGridReportLink;
    mGuests: TdxMemData;
    mGuestsId: TIntegerField;
    mGuestsPerson: TIntegerField;
    mGuestsReservation: TIntegerField;
    mGuestsRoomReservation: TIntegerField;
    mGuestsPersonsProfilesId: TIntegerField;
    mGueststitle: TWideStringField;
    mGuestsName: TWideStringField;
    mGuestsAddress1: TWideStringField;
    mGuestsAddress2: TWideStringField;
    mGuestsAddress3: TWideStringField;
    mGuestsAddress4: TWideStringField;
    mGuestsCountry: TWideStringField;
    mGueststel1: TWideStringField;
    mGueststel2: TWideStringField;
    mGuestsFax: TWideStringField;
    mGuestsEmail: TWideStringField;
    mGuestsNationality: TWideStringField;
    mGuestsPID: TWideStringField;
    mGuestsMainName: TBooleanField;
    mGuestsCustomer: TWideStringField;
    mGuestsState: TWideStringField;
    mGuestsPersonalIdentificationId: TWideStringField;
    mGuestsDateOfBirth: TDateTimeField;
    mGuestsSocialSecurityNumber: TWideStringField;
    mGuestsRoom: TWideStringField;
    mGuestsBreakfast: TBooleanField;
    mGuestsrrArrival: TDateTimeField;
    mGuestsrrDeparture: TDateTimeField;
    mGuestsnumGuests: TIntegerField;
    mGuestsRoomDescription: TWideStringField;
    mGuestsStatusText: TWideStringField;
    mGuestsroomDetails: TWideStringField;
    mGuestsCompanyName: TStringField;
    mGuestsCompVATNumber: TWideStringField;
    mGuestsCompAddress1: TStringField;
    mGuestsCompAddress2: TWideStringField;
    mGuestsCompZip: TWideStringField;
    mGuestsCompCity: TWideStringField;
    mGuestsCompCountry: TWideStringField;
    mGuestsCompTel: TWideStringField;
    mGuestsCompFax: TWideStringField;
    mGuestsCompEmail: TWideStringField;
    mGuestsRoomType: TWideStringField;
    tvGuestsRoomType: TcxGridDBBandedColumn;
    mCompare: TdxMemData;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    WideStringField6: TWideStringField;
    WideStringField7: TWideStringField;
    WideStringField8: TWideStringField;
    WideStringField9: TWideStringField;
    WideStringField10: TWideStringField;
    WideStringField11: TWideStringField;
    WideStringField12: TWideStringField;
    WideStringField13: TWideStringField;
    BooleanField1: TBooleanField;
    WideStringField14: TWideStringField;
    WideStringField15: TWideStringField;
    WideStringField16: TWideStringField;
    DateTimeField1: TDateTimeField;
    WideStringField17: TWideStringField;
    WideStringField18: TWideStringField;
    BooleanField2: TBooleanField;
    DateTimeField2: TDateTimeField;
    DateTimeField3: TDateTimeField;
    IntegerField6: TIntegerField;
    WideStringField19: TWideStringField;
    WideStringField20: TWideStringField;
    WideStringField21: TWideStringField;
    StringField1: TStringField;
    WideStringField22: TWideStringField;
    StringField2: TStringField;
    WideStringField23: TWideStringField;
    WideStringField24: TWideStringField;
    WideStringField25: TWideStringField;
    WideStringField26: TWideStringField;
    WideStringField27: TWideStringField;
    WideStringField28: TWideStringField;
    WideStringField29: TWideStringField;
    WideStringField30: TWideStringField;
    ALWinInetHTTPClient1: TALWinInetHTTPClient;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure chkCompactViewClick(Sender: TObject);
    procedure rgrShowClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure btnCollapseClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure btnClearAddressClick(Sender: TObject);
    procedure tvGuestsCountryPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvGuestsCountryPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvGuestsNationalityPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvGuestsNationalityPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnEditClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zReservation : integer;
    zRoomreservation : integer;

    procedure getReservation(reservation : integer);
    function  updateSQL(id : integer) : string;
    procedure setView;
    procedure doupdate;
    function CountryValidate(country : string) : boolean;

  public
    { Public declarations }
  end;

function GroupGuests(reservation,roomreservation : integer) : boolean;

var
  frmGroupGuests: TfrmGroupGuests;



implementation

{$R *.dfm}

uses
   uD
   ,uGuestCheckInForm
   ,uEditGuest
   ,uCountries;


function TfrmGroupGuests.CountryValidate(country : string) : boolean;
begin
  result :=  glb.LocateCountry(country);
end;


function GroupGuests(reservation,roomreservation : integer) : boolean;
begin
  result := false;
  frmGroupGuests := TfrmGroupGuests.Create(nil);
  try
    frmGroupGuests.zReservation     := Reservation;
    frmGroupGuests.zRoomreservation := RoomReservation;
    frmGroupGuests.ShowModal;
    if frmGroupGuests.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmGroupGuests);
  end;
  //240627-2569
end;


procedure TfrmGroupGuests.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmGroupGuests.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmGroupGuests.FormShow(Sender: TObject);
begin
  getReservation(zreservation);
  setView;
  rgrShowClick(self);
end;

procedure TfrmGroupGuests.getReservation(reservation: integer);
var
  s : string;
  rSet : TroomerDataset;
begin
  s := '';
  s := s+'SELECT '#10;
  s := s+'   pe.ID '#10;
  s := s+'  ,pe.Person '#10;
  s := s+'  ,pe.Reservation '#10;
  s := s+'  ,pe.RoomReservation '#10;
  s := s+'  ,pe.PersonsProfilesId '#10;
  s := s+'  ,pe.title '#10;
  s := s+'  ,pe.Name '#10;
//  s := s+'  ,pe.Surname '#10;
  s := s+'  ,pe.Address1 '#10;
  s := s+'  ,pe.Address2 '#10;
  s := s+'  ,pe.Address3 '#10;
  s := s+'  ,pe.Address4 '#10;
  s := s+'  ,pe.Country '#10;
  s := s+'  ,pe.Tel1 '#10;
  s := s+'  ,pe.Tel2 '#10;
  s := s+'  ,pe.Fax '#10;
  s := s+'  ,pe.Email '#10;
//  s := s+'  ,pe.GuestType '#10;
//  s := s+'  ,pe.Information '#10;
  s := s+'  ,pe.Nationality '#10;
  s := s+'  ,pe.PID '#10;
  s := s+'  ,pe.MainName '#10;
  s := s+'  ,pe.Customer '#10;
//  s := s+'  ,pe.Company '#10;
  s := s+'  ,pe.CompanyName '#10;
  s := s+'  ,pe.CompVATNumber '#10;
  s := s+'  ,pe.CompAddress1 '#10;
  s := s+'  ,pe.CompAddress2 '#10;
  s := s+'  ,pe.CompZip '#10;
  s := s+'  ,pe.CompCity '#10;
  s := s+'  ,pe.CompCountry '#10;
  s := s+'  ,pe.CompTel '#10;
  s := s+'  ,pe.CompFax '#10;
  s := s+'  ,pe.CompEmail '#10;

  //  s := s+'  ,pe.peTmp '#10;
//  s := s+'  ,pe.HallReservation '#10;
//  s := s+'  ,pe.hgrID '#10;
  s := s+'  ,pe.state '#10;
//  s := s+'  ,pe.sourceId '#10;
  s := s+'  ,pe.PersonalIdentificationId '#10;
  s := s+'  ,pe.DateOfBirth '#10;
  s := s+'  ,pe.SocialSecurityNumber '#10;

  s := s+'  ,rr.room '#10;
  s := s+'  ,rr.roomType '#10;
//  s := s+'  ,rr.status '#10;
//  s := s+'  ,rr.groupaccount '#10;
  s := s+'  ,rr.invBreakfast AS Breakfast'#10;
  s := s+'  ,rr.rrArrival '#10;
  s := s+'  ,rr.rrDeparture '#10;
  s := s+'  ,rr.numGuests '#10;
//  s := s+'  ,rr.roomclass '#10;
//  s := s+'  ,rr.package '#10;
  s := s+'  ,(SELECT description from rooms where rooms.room = rr.room) as RoomDescription '#10;
  s := s+'  ,(SELECT Result from dictionary where dictionary.code = rr.status) as StatusText '#10;
  s := s+'  ,concat(room," - ", (SELECT description from rooms where rooms.room = rr.room)," - ",rr.numGuests,". Guests") as roomDetails '#10;

  s := s+' FROM '#10;
  s := s+'  persons pe '#10;
  s := s+'  LEFT JOIN roomreservations rr on pe.roomreservation = rr.roomreservation '#10;
  s := s+' WHERE '#10;
  s := s+'  (pe.Reservation='+_db(reservation)+') '#10;


  if rgrShow.ItemIndex = 1 then
  begin
    s := s+'   and (pe.name <> '+_db('')+') '#10;
    s := s+'   and (pe.name <> '+_db('RoomGuest')+') '#10;
    s := s+'   and (pe.name <> '+_db('MainGuest')+') '#10;
    s := s+'   and (pe.name <> '+_db('Added Guest')+') '#10;
  end;

  s := s+'  ORDER BY ROOM, Mainname desc '#10;

//     copyToClipboard(s);
//     DebugMessage(s);

  rSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet, s, false) then
    begin
      mGuests.disableControls;
      try
        if mGuests.active then mGuests.Close;
        if mCompare.active then mCompare.Close;
        mCompare.open;
        mGuests.open;
        rSet.First;
        mGuests.LoadFromDataSet(rset);
        mGuests.First;
        rSet.First;
        mCompare.LoadFromDataSet(rset);
//      showmessage(inttostr(rSet.RecordCount)+' / '+inttostr(rSet.RecordCount));
        mGuests.First;
      finally
        mGuests.enableControls;
      end;
    end;
  finally
    freeandnil(rset);
  end;
end;


procedure TfrmGroupGuests.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  grPrinterLink1.ReportTitle.Text := caption;
  grPrinter.Preview(true, grPrinterLink1);
end;

procedure TfrmGroupGuests.rgrShowClick(Sender: TObject);
begin
  screen.Cursor := crHourglass;
  try
    doupdate;
    getReservation(zreservation);

    btnCollapse.visible  := rgrShow.ItemIndex = 0; // chkGroup.Checked;
    btnExpand.visible    := rgrShow.ItemIndex = 0;
    tvGuestsroom.Visible := rgrShow.ItemIndex = 1;

    if rgrShow.ItemIndex = 0 then
    begin
      tvGuestsroomDetails.GroupIndex := 1;
      tvGuests.DataController.Groups.FullExpand;
    end else
      tvGuestsroomDetails.GroupIndex := -1;

  finally
    screen.cursor := crdefault;
  end;
end;

function TfrmGroupGuests.updateSQL(id : integer) : string;
var
  s : string;
begin
  s := '';
  s := s+'UPDATE persons '#10;
  s := s+'SET '#10;
//  s := s+'Person = '+_db(mGuests.fieldbyname('Person').asinteger)+' '#10;
//  s := s+',RoomReservation = '+_db(mGuests.fieldbyname('RoomReservation').asinteger)+' '#10;
//  s := s+',Reservation =  '+_db(mGuests.FieldByName('Reservation').asinteger)+' '#10;
  s := s+' PersonsProfilesId =  '+_db(mGuests.FieldByName('PersonsProfilesId').asInteger)+' '#10;
  s := s+',title = '+_db(mGuests.FieldByName('title').asString)+' '#10;
  s := s+',Name =  '+_db(mGuests.FieldByName('Name').asString)+' '#10;
  s := s+',Address1 = '+_db(mGuests.FieldByName('Address1').asString)+' '#10;
  s := s+',Address2 = '+_db(mGuests.FieldByName('Address2').asString)+' '#10;
  s := s+',Address3 = '+_db(mGuests.FieldByName('Address3').asString)+' '#10;
  s := s+',Address4 = '+_db(mGuests.FieldByName('Address4').asString)+' '#10;
  s := s+',Country = '+_db(mGuests.FieldByName('Country').asString)+' '#10;
  s := s+',Tel1 = '+_db(mGuests.FieldByName('Tel1').asString)+' '#10;
  s := s+',Tel2 = '+_db(mGuests.FieldByName('Tel2').asString)+' '#10;
  s := s+',Fax = '+_db(mGuests.FieldByName('Fax').asString)+' '#10;
  s := s+',Email = '+_db(mGuests.FieldByName('Email').asString)+' '#10;
//  s := s+',GuestType = '+_db(mGuests.FieldByName('GuestType').asString)+' '#10;
//  s := s+',Information = '+_db(mGuests.FieldByName('Information').asString)+' '#10;
  s := s+',Nationality = '+_db(mGuests.FieldByName('Nationality').asString)+' '#10;
  s := s+',PID = '+_db(mGuests.FieldByName('PID').asString)+' '#10;
  s := s+',MainName = '+_db(mGuests.FieldByName('MainName').asBoolean)+' '#10;

//  s := s+',Customer = '+_db(mGuests.FieldByName('Customer').asString)+' '#10;
//  s := s+',Company = '+_db(mGuests.FieldByName('Company').asString)+' '#10;
  s := s+',CompanyName = '+_db(mGuests.FieldByName('CompanyName').asString)+' '#10;
  s := s+',CompVATNumber = '+_db(mGuests.FieldByName('CompVATNumber').asString)+' '#10;
  s := s+',CompAddress1 = '+_db(mGuests.FieldByName('CompAddress1').asString)+' '#10;
  s := s+',CompAddress2 = '+_db(mGuests.FieldByName('CompAddress2').asString)+' '#10;
  s := s+',CompZip = '+_db(mGuests.FieldByName('CompZip').asString)+' '#10;
  s := s+',CompCity = '+_db(mGuests.FieldByName('CompCity').asString)+' '#10;
  s := s+',CompCountry = '+_db(mGuests.FieldByName('CompCountry').asString)+' '#10;
  s := s+',CompTel = '+_db(mGuests.FieldByName('CompTel').asString)+' '#10;
  s := s+',CompFax = '+_db(mGuests.FieldByName('CompFax').asString)+' '#10;
  s := s+',CompEmail = '+_db(mGuests.FieldByName('CompEmail').asString)+' '#10;
//  s := s+',peTmp = '+_db(mGuests.FieldByName('peTmp').asString)+' '#10;
//  s := s+',ID = '+_db(mGuests.FieldByName('ID').asInteger)+' '#10;
  s := s+',state = '+_db(mGuests.FieldByName('state').asString)+' '#10;
//  s := s+',sourceId = '+_db(mGuests.FieldByName('sourceId').asString)+' '#10;
  s := s+',PersonalIdentificationId = '+_db(mGuests.FieldByName('PersonalIdentificationId').asString)+' '#10;
  s := s+',DateOfBirth = '+_db(mGuests.FieldByName('DateOfBirth').asDateTime)+' '#10;
  s := s+',SocialSecurityNumber = '+_db(mGuests.FieldByName('SocialSecurityNumber').asString)+' '#10;
  s := s+'WHERE '#10;
  s := s+'  ID = '+_db(id)+' ';
//  copyToClipboard(s);
//  debugMessage(s);
  result := s;
end;


procedure TfrmGroupGuests.btnClearAddressClick(Sender: TObject);
begin
  if not mGuests.eof then
  begin
    mGuests.edit;
    mGuests.FieldByName('Address1').AsString := '';
    mGuests.FieldByName('Address2').AsString := '';
    mGuests.FieldByName('Address3').AsString := '';
    mGuests.FieldByName('Address4').AsString := '';
    mGuests.post;
  end;
end;

procedure TfrmGroupGuests.btnCollapseClick(Sender: TObject);
begin
  tvGuests.DataController.Groups.FullCollapse;
end;

procedure TfrmGroupGuests.btnEditClick(Sender: TObject);
var
  PersonRec : recPersonHolder;
begin
  initPersonHolder(personRec);
  PersonRec.name     := mGuests['name'   ];
  PersonRec.Address1 := mGuests['Address1'];
  PersonRec.Address2 := mGuests['Address2'];
  PersonRec.Address3 := mGuests['Address3'];
  PersonRec.Address4 := mGuests['Address4'];

  PersonRec.title      := mGuests.FieldByName('title').AsString        ;
  PersonRec.Nationality:= mGuests.FieldByName('Nationality').AsString  ;
  PersonRec.DateOfBirth:= mGuests.FieldByName('DateOfBirth').AsDateTime;

  PersonRec.PersonalIdentificationId := mGuests.FieldByName('PersonalIdentificationId').AsString ;
  PersonRec.SocialSecurityNumber     := mGuests.FieldByName('SocialSecurityNumber').AsString     ;
  PersonRec.Country                  := mGuests.FieldByName('Country').AsString                  ;
  PersonRec.Tel1                     := mGuests.FieldByName('tel1').AsString                     ;
  PersonRec.Tel2                     := mGuests.FieldByName('tel2').AsString                     ;
  PersonRec.Email                    := mGuests.FieldByName('Email').AsString                    ;

  PersonRec.CompanyName     :=   mGuests.FieldByName('CompanyName').AsString     ;
  PersonRec.CompVATNumber   :=   mGuests.FieldByName('CompVATNumber').AsString   ;
  PersonRec.CompTel         :=   mGuests.FieldByName('CompTel').AsString         ;
  PersonRec.CompFax         :=   mGuests.FieldByName('CompFax').AsString         ;
  PersonRec.CompEmail       :=   mGuests.FieldByName('CompEmail').AsString       ;
  PersonRec.CompAddress1    :=   mGuests.FieldByName('CompAddress1').AsString    ;
  PersonRec.CompAddress2    :=   mGuests.FieldByName('CompAddress2').AsString    ;
  PersonRec.CompZip         :=   mGuests.FieldByName('CompZip').AsString         ;
  PersonRec.CompCity        :=   mGuests.FieldByName('CompCity').AsString        ;
  PersonRec.CompCountry     :=   mGuests.FieldByName('CompCountry').AsString     ;

  if OpenEditPerson(personRec) then
  begin
    mGuests.Edit;
    mGuests.FieldByName('name').AsString     :=  PersonRec.name;
    mGuests.FieldByName('Address1').AsString :=  PersonRec.Address1;
    mGuests.FieldByName('Address2').AsString :=  PersonRec.Address2;
    mGuests.FieldByName('Address3').AsString :=  PersonRec.Address3;
    mGuests.FieldByName('Address4').AsString :=  PersonRec.Address4;

    mGuests.FieldByName('title').AsString        :=  PersonRec.title;
    mGuests.FieldByName('Nationality').AsString  := PersonRec.Nationality;
    mGuests.FieldByName('DateOfBirth').AsDateTime:= PersonRec.DateOfBirth;

    mGuests.FieldByName('PersonalIdentificationId').AsString  := PersonRec.PersonalIdentificationId;
    mGuests.FieldByName('SocialSecurityNumber').AsString      := PersonRec.SocialSecurityNumber;
    mGuests.FieldByName('Country').AsString                   := PersonRec.Country;
    mGuests.FieldByName('tel1').AsString                      := PersonRec.Tel1;
    mGuests.FieldByName('tel2').AsString                      := PersonRec.Tel2;
    mGuests.FieldByName('Email').AsString                     := PersonRec.Email;

    mGuests.FieldByName('CompanyName'  ).AsString    := PersonRec.CompanyName     ;
    mGuests.FieldByName('CompVATNumber').AsString    := PersonRec.CompVATNumber   ;
    mGuests.FieldByName('CompTel'      ).AsString    := PersonRec.CompTel         ;
    mGuests.FieldByName('CompFax'      ).AsString    := PersonRec.CompFax         ;
    mGuests.FieldByName('CompEmail'    ).AsString    := PersonRec.CompEmail       ;
    mGuests.FieldByName('CompAddress1' ).AsString    := PersonRec.CompAddress1    ;
    mGuests.FieldByName('CompAddress2' ).AsString    := PersonRec.CompAddress2    ;
    mGuests.FieldByName('CompZip'      ).AsString    := PersonRec.CompZip         ;
    mGuests.FieldByName('CompCity'     ).AsString    := PersonRec.CompCity        ;
    mGuests.FieldByName('CompCountry'  ).AsString    := PersonRec.CompCountry     ;
    mGuests.post;
  end else
  begin
    //
  end;




end;

procedure TfrmGroupGuests.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_GoupGuests';
  ExportGridToExcel(sFilename, grGuests, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmGroupGuests.btnExpandClick(Sender: TObject);
begin
  tvGuests.DataController.Groups.FullExpand;
end;

procedure TfrmGroupGuests.BtnOkClick(Sender: TObject);
begin
  doUpdate;
end;

procedure TfrmGroupGuests.chkCompactViewClick(Sender: TObject);
begin
  setView;
end;

procedure TfrmGroupGuests.sButton1Click(Sender: TObject);
var
  iReservation : integer;
begin
  iReservation := mGuests.fieldbyname('Reservation').AsInteger;
  g.openresMemo(iReservation);
end;

procedure TfrmGroupGuests.setView;
begin
    // main
    tvGuestsroom.Visible := true;
    tvGueststitle.Visible := true;
    tvGuestsname.Visible := true;
    tvGuestsMainName.Visible := true;

    tvGuestsRoomDescription.Visible := not  chkCompactView.Checked;
    tvGuestsRoomtype.Visible := not  chkCompactView.Checked;
    tvGuestsrrArrival.Visible := not  chkCompactView.Checked;
    tvGuestsrrDeparture.Visible := not  chkCompactView.Checked;
    tvGuestsnumGuests.Visible := not  chkCompactView.Checked;
    tvGuestsStatusText.Visible := not  chkCompactView.Checked;
    tvGuestsBreakfast.Visible := not  chkCompactView.Checked;

    //Contact
    tvGuests.Bands[1].Visible := not  chkCompactView.Checked;
    tvGuestsTel1.Visible  := not  chkCompactView.Checked;
    tvGuestsTel2.Visible  := not  chkCompactView.Checked;
    tvGuestsFax.Visible   := not  chkCompactView.Checked;
    tvGuestsEmail.Visible := not  chkCompactView.Checked;

    //Address
    tvGuests.Bands[2].Visible := not  chkCompactView.Checked;
    tvGuestsAddress1.Visible    := not  chkCompactView.Checked;
    tvGuestsAddress2.Visible    := not  chkCompactView.Checked;
    tvGuestsAddress3.Visible    := not  chkCompactView.Checked;
    tvGuestsAddress4.Visible    := not  chkCompactView.Checked;
    tvGuestsState.Visible       := not  chkCompactView.Checked;
    tvGuestsCountry.Visible     := not  chkCompactView.Checked;
    tvGuestsNationality.Visible := not  chkCompactView.Checked;


    //Other
    tvGuests.Bands[3].Visible := not  chkCompactView.Checked;
    tvGuestsCustomer.Visible                 := not  chkCompactView.Checked;
    tvGuestsPID.Visible                      := not  chkCompactView.Checked;
    tvGuestsDateOfBirth.Visible              := not  chkCompactView.Checked;
    tvGuestsPersonalIdentificationId.Visible := not  chkCompactView.Checked;
    tvGuestsSocialSecurityNumber.Visible     := not  chkCompactView.Checked;
    tvGuests.applyBestFit;

    btnClearAddress.visible :=  not  chkCompactView.Checked;
end;


procedure TfrmGroupGuests.tvGuestsCountryPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recCountryHolder;
begin
  theData.country := mGuests.fieldbyname('Country').asstring;
  Countries(actlookup,theData);
  if theData.country <> '' then
  begin
    if tvGuests.DataController.DataSource.State <> dsInsert then mGuests.Edit;
    mGuests.FieldByName('Country').asstring   := theData.country;
    mGuests.post;
  end;
end;

procedure TfrmGroupGuests.tvGuestsCountryPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  error := not countryValidate(DisplayValue);
end;

procedure TfrmGroupGuests.tvGuestsNationalityPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recCountryHolder;
begin
  theData.country := mGuests.fieldbyname('Nationality').asstring;
  Countries(actlookup,theData);
  if theData.country <> '' then
  begin
    if tvGuests.DataController.DataSource.State <> dsInsert then mGuests.Edit;
    mGuests.FieldByName('Nationality').asstring   := theData.country;
    mGuests.post;
  end;
end;

procedure TfrmGroupGuests.tvGuestsNationalityPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  error := not countryValidate(DisplayValue);
end;

procedure TfrmGroupGuests.doupdate;
var
  s : string;
  diff : boolean;
  ExecutionPlan: TRoomerExecutionPlan;
begin
  if tvGuests.DataController.DataSet.State = dsInActive then
    Exit;

  if tvGuests.DataController.DataSet.State = dsEdit then
    tvGuests.DataController.Post;

  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    ExecutionPlan.BeginTransaction;
    try
      mGuests.DisableControls;
      try
        mGuests.First;
        mCompare.First;
        s := '';
        while not mGuests.eof do
        begin
          diff := false;
          if mGuests.FieldByName('title').AsString                    <> mCompare.FieldByName('title').AsString then diff := true;
          if mGuests.FieldByName('Name').AsString                     <> mCompare.FieldByName('Name').AsString then diff := true;
          if mGuests.FieldByName('Address1').AsString                 <> mCompare.FieldByName('Address1').AsString then diff := true;
          if mGuests.FieldByName('Address2').AsString                 <> mCompare.FieldByName('Address1').AsString then diff := true;
          if mGuests.FieldByName('Address3').AsString                 <> mCompare.FieldByName('Address1').AsString then diff := true;
          if mGuests.FieldByName('Address4').AsString                 <> mCompare.FieldByName('Address1').AsString then diff := true;
          if mGuests.FieldByName('Country').AsString                  <> mCompare.FieldByName('Country').AsString then diff := true;
          if mGuests.FieldByName('Tel1').AsString                     <> mCompare.FieldByName('Tel1').AsString then diff := true;
          if mGuests.FieldByName('Tel2').AsString                     <> mCompare.FieldByName('Tel2').AsString then diff := true;
          if mGuests.FieldByName('Fax').AsString                      <> mCompare.FieldByName('Fax').AsString then diff := true;
          if mGuests.FieldByName('Email').AsString                    <> mCompare.FieldByName('Email').AsString then diff := true;
          if mGuests.FieldByName('Nationality').AsString              <> mCompare.FieldByName('Nationality').AsString then diff := true;
          if mGuests.FieldByName('PersonalIdentificationId').AsString <> mCompare.FieldByName('PersonalIdentificationId').AsString then diff := true;
          if mGuests.FieldByName('DateOfBirth').AsString              <> mCompare.FieldByName('DateOfBirth').AsString then diff := true;
          if mGuests.FieldByName('SocialSecurityNumber').AsString     <> mCompare.FieldByName('SocialSecurityNumber').AsString then diff := true;
          if mGuests.FieldByName('State').AsString                    <> mCompare.FieldByName('State').AsString then diff := true;

          if mGuests.FieldByName('CompanyName'  ).AsString      <> mCompare.FieldByName('CompanyName'  ).AsString then diff := true;
          if mGuests.FieldByName('CompVATNumber').AsString      <> mCompare.FieldByName('CompVATNumber').AsString then diff := true;
          if mGuests.FieldByName('CompTel'      ).AsString      <> mCompare.FieldByName('CompTel'      ).AsString then diff := true;
          if mGuests.FieldByName('CompFax'      ).AsString      <> mCompare.FieldByName('CompFax'      ).AsString then diff := true;
          if mGuests.FieldByName('CompEmail'    ).AsString      <> mCompare.FieldByName('CompEmail'    ).AsString then diff := true;
          if mGuests.FieldByName('CompAddress1' ).AsString      <> mCompare.FieldByName('CompAddress1' ).AsString then diff := true;
          if mGuests.FieldByName('CompAddress2' ).AsString      <> mCompare.FieldByName('CompAddress2' ).AsString then diff := true;
          if mGuests.FieldByName('CompZip'      ).AsString      <> mCompare.FieldByName('CompZip'      ).AsString then diff := true;
          if mGuests.FieldByName('CompCity'     ).AsString      <> mCompare.FieldByName('CompCity'     ).AsString then diff := true;
          if mGuests.FieldByName('CompCountry'  ).AsString      <> mCompare.FieldByName('CompCountry'  ).AsString then diff := true;

          if diff then
          begin
            s := updateSQL(mGuests.FieldByName('ID').AsInteger);
            ExecutionPlan.AddExec(s);
          end;
          mGuests.Next;
          mCompare.Next;
        end;
      finally
        mGuests.EnableControls;
        tvGuests.applyBestFit;
      end;
      if ExecutionPlan.Execute(ptExec, False, True) then
      begin
         ExecutionPlan.CommitTransaction
      end else
      begin
        raise Exception.Create(ExecutionPlan.ExecException);
      end;
    except
      on e: exception do
      begin
        ExecutionPlan.RollbackTransaction;
        showMessage('Error on Updating Person : '+e.message);
      end;
    end;
  finally
    freeandNil(ExecutionPlan);
  end;
//  slabel1.Caption := s;
end;




procedure TfrmGroupGuests.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grGuests, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmGroupGuests.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grGuests, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmGroupGuests.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grGuests, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;



end.



