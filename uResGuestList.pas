unit uResGuestList;


interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  shellapi,
  StdCtrls,
  //wwdbdatetimepicker,
  Grids,
  BaseGrid,
  AdvGrid,
  ComCtrls,
  DB,
  ADODB,
  Buttons,
  Mask,
  ExtCtrls,
  ImgList,


  _Glob,
  ug,
  hdata,


  AdvSpin,

  kbmMemTable,


  frxClass,
  frxADOComponents,
  frxDBSet,
  frxExportImage,
  frxExportRTF,
  frxExportHTML,
  frxExportPDF,
  frxDesgn,

  DBGrids,
  DBCtrls,

  cxGridExportLink,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxDBData,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  cxPC,
  cxPCdxBarPopupMenu,
  cxNavigator

  //ath Wwdatsrc

  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxPropertiesStore, sMemo, sGroupBox, sCheckBox, sButton, sSpeedButton, sPageControl, sLabel,
  sPanel, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld


  ;

type
  TfrmResGuestList = class(TForm)
    LMDStatusBar1: TStatusBar;
    LMDSimplePanel1: TsPanel;
    R_ : TRoomerDataSet;
    DS_: TDataSource;
    m_ : TkbmMemTable;
    ImageList1 : TImageList;
    rpt : TfrxReport;
    rptDesign : TfrxDesigner;
    frxPDFExport1 : TfrxPDFExport;
    frxHTMLExport1 : TfrxHTMLExport;
    frxRTFExport1 : TfrxRTFExport;
    frxJPEGExport1 : TfrxJPEGExport;
    rptDs1 : TfrxDBDataset;
    rptDSHead : TfrxDBDataset;
    mHead_ : TkbmMemTable;
    PageControl1: TsPageControl;
    TabSheet1: TsTabSheet;
    LMDSimplePanel2: TsPanel;
    btnRefresh: TsButton;
    LMDSpeedButton3: TsButton;
    LMDSpeedButton4: TsButton;
    LMDSpeedButton5: TsButton;
    mResCustomer : TkbmMemTable;
    rptDSResCustomer : TfrxDBDataset;
    Label1: TsLabel;
    Panel1: TsPanel;
    GroupBox1: TsGroupBox;
    edCustomerNo: TsLabel;
    edCustPID: TsLabel;
    edName: TsLabel;
    edAddress1: TsLabel;
    edAddress2: TsLabel;
    edAddress3: TsLabel;
    edCountry: TsLabel;
    edTel1: TsLabel;
    Label2: TsLabel;
    Label3: TsLabel;
    Label4: TsLabel;
    Label5: TsLabel;
    Label6: TsLabel;
    Label7: TsLabel;
    Label8: TsLabel;
    Label9: TsLabel;
    Label10: TsLabel;
    edTel2: TsLabel;
    Label11: TsLabel;
    edFax: TsLabel;
    GroupBox2: TsGroupBox;
    Label12: TsLabel;
    Label13: TsLabel;
    Label14: TsLabel;
    Label15: TsLabel;
    Label17: TsLabel;
    edContact: TsLabel;
    edContactPhone: TsLabel;
    edContactFax: TsLabel;
    edContactEmail: TsLabel;
    GroupBox3: TsGroupBox;
    memResInfo: TsMemo;
    GroupBox4: TsGroupBox;
    memPaymentInfo: TsMemo;
    chkShowAllGuests: TsCheckBox;
    Label16: TsLabel;
    edArrival: TsLabel;
    Label18: TsLabel;
    edDeparture: TsLabel;
    Label19: TsLabel;
    edReservationDate: TsLabel;
    edStaff: TsLabel;
    Label20: TsLabel;
    edCountryName: TsLabel;
    cxPageControl1 : TcxPageControl;
    cxGrid1 : TcxGrid;
    cxGrid1DBTableView1 : TcxGridDBTableView;
    cxGrid1DBTableView1Room : TcxGridDBColumn;
    cxGrid1DBTableView1RoomType : TcxGridDBColumn;
    cxGrid1DBTableView1RoomTypeDescription : TcxGridDBColumn;
    cxGrid1DBTableView1GuestName : TcxGridDBColumn;
    cxGrid1DBTableView1Address1 : TcxGridDBColumn;
    cxGrid1DBTableView1Address2 : TcxGridDBColumn;
    cxGrid1DBTableView1Address3 : TcxGridDBColumn;
    cxGrid1DBTableView1Country : TcxGridDBColumn;
    cxGrid1DBTableView1CountryName : TcxGridDBColumn;
    cxGrid1DBTableView1CountryGroup : TcxGridDBColumn;
    cxGrid1DBTableView1GroupName : TcxGridDBColumn;
    cxGrid1DBTableView1Arrival : TcxGridDBColumn;
    cxGrid1DBTableView1Departure : TcxGridDBColumn;
    cxGrid1DBTableView1RoomStatus : TcxGridDBColumn;
    cxGrid1DBTableView1StatusText : TcxGridDBColumn;
    cxGrid1DBTableView1PersionalID : TcxGridDBColumn;
    cxGrid1DBTableView1Floor : TcxGridDBColumn;
    cxGrid1DBTableView1Location : TcxGridDBColumn;
    cxGrid1DBTableView1LocationDescription : TcxGridDBColumn;
    cxGrid1DBTableView1Information : TcxGridDBColumn;
    cxGrid1DBTableView1isMainName : TcxGridDBColumn;
    cxGrid1DBTableView1isNoRoom : TcxGridDBColumn;
    cxGrid1DBTableView1Reservation : TcxGridDBColumn;
    cxGrid1DBTableView1GuestType : TcxGridDBColumn;
    cxGrid1DBTableView1RoomReservation : TcxGridDBColumn;
    cxGrid1DBTableView1inStatistics : TcxGridDBColumn;
    cxGrid1DBTableView1Person : TcxGridDBColumn;
    cxGrid1Level1 : TcxGridLevel;
    edReservation: TsLabel;
    FormStore: TcxPropertiesStore;
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure btnRefreshClick(Sender : TObject);
    procedure LMDSpeedButton3Click(Sender : TObject);
    procedure LMDSpeedButton4Click(Sender : TObject);
    procedure LMDSpeedButton5Click(Sender : TObject);
    procedure LMDSpeedButton9Click(Sender : TObject);
    procedure LMDSpeedButton10Click(Sender : TObject);
    procedure chkShowAllGuestsClick(Sender : TObject);
    procedure cxGrid1DBTableView1DblClick(Sender : TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure ClearAll;
    procedure Refresh;
    procedure updateHeadInfo;
    function getRes(reservation : Integer) : boolean;
  public
    { Public declarations }
    zDateFrom : Tdate;
    zDateTo : Tdate;

    zReservation : Integer;
    zRoomReservation : Integer;

    zCustomer : string;
    zShowAllGuests : boolean;
  end;

var
  frmResGuestList : TfrmResGuestList;

implementation

uses
  uReservationProfile
  , uGuestProfile2
  , uD
  , uFinishedInvoices2
  , uSqlDefinitions
  , uFileDependencyManager
  , uAppGlobal
  , PrjConst
  , uDImages;
{$R *.dfm}

function SetFloatFormat(Decimals : Integer; ShowCurrency : boolean) : string;
var
  s : string;
  sDecimals : string;
begin
  sDecimals := inttostr(Decimals);
  if ShowCurrency then
    s := 'm'
  else
    s := 'n';
  result := '%.' + sDecimals + s
end;

function FloatToCellStr(aNumber : Double; Format : string; commaToDot : boolean) : string;
var
  i : Integer;
  s : string;
begin
  s := '0';

  if Format = '' then
  begin
    s := floatTostr(aNumber);
  end
  else
  begin
    s := formatFloat(Format, aNumber);
  end;

  if commaToDot then
  begin
    for i := 1 to length(s) do
    begin
      if s[i] = '.' then
        s[i] := SystemDecimalSeparator
      else if s[i] = ',' then
        s[i] := '.'
    end;
  end;
  result := s;
end;

// ******************************************************************************

procedure TfrmResGuestList.updateHeadInfo;
begin
  mHead_.edit;
  mHead_.FieldByName('HotelName').AsString := ctrlGetString('CompanyName');
  mHead_.FieldByName('DateFrom').AsDateTime := Date;
  mHead_.FieldByName('DateTo').AsDateTime := Date;
  mHead_.Post;
end;


procedure TfrmResGuestList.FormCreate(Sender : TObject);
var
  i : Integer;
begin
  RoomerLanguage.TranslateThisForm(self);
  zReservation := - 1;
  zCustomer := '';
  zShowAllGuests := false;
end;

procedure TfrmResGuestList.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmResGuestList.FormShow(Sender : TObject);
begin
  edReservation.Caption := inttostr(zReservation);
  chkShowAllGuests.checked := zShowAllGuests;

  if mHead_.Active then
    mHead_.Close;
  mHead_.Open;

  mHead_.Insert;
  mHead_.FieldByName('HotelName').AsString := ctrlGetString('CompanyName');
  mHead_.FieldByName('DateFrom').AsDateTime := Date;
  mHead_.FieldByName('DateTo').AsDateTime := Date;
  mHead_.Post;

  Refresh;
end;

procedure TfrmResGuestList.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  // **
end;

function TfrmResGuestList.getRes(reservation : Integer) : boolean;
var
  rSet : TRoomerDataSet;
  s : string;
begin
  result := false;

  if mResCustomer.Active then
    mResCustomer.Close;
  mResCustomer.Open;

  rSet := CreateNewDataSet;
  try
    
    rSet.CommandType := cmdText;

//    s := '';
//    s := s + ' SELECT *';
//    s := s + ' FROM ';
//    s := s + '   reservations ';
//    s := s + ' WHERE ';
//    s := s + '   (Reservation = ' + inttostr(reservation) + ') ';

    s := format(select_ResGuestList_getRes , [reservation]);

    hData.rSet_bySQL(rSet,s);
    rSet.First;
    if not rSet.Eof then
    begin
      mResCustomer.edit;
      mResCustomer.FieldByName('Name').AsString := rSet.FieldByName('Name').AsString;
      mResCustomer.FieldByName('Address1').AsString := rSet.FieldByName('Address1').AsString;
      mResCustomer.FieldByName('Address2').AsString := rSet.FieldByName('Address2').AsString;
      mResCustomer.FieldByName('Address3').AsString := rSet.FieldByName('Address3').AsString;
      mResCustomer.FieldByName('Country').AsString := rSet.FieldByName('Country').AsString;
      //**NOT TESTED**//
      mResCustomer.FieldByName('CountryName').AsString := glb.GetCountryName(rSet.FieldByName('Country').AsString);
      mResCustomer.FieldByName('Tel1').AsString := rSet.FieldByName('Tel1').AsString;
      mResCustomer.FieldByName('Tel2').AsString := rSet.FieldByName('Tel2').AsString;
      mResCustomer.FieldByName('Fax').AsString := rSet.FieldByName('Fax').AsString;
      mResCustomer.FieldByName('ReservationDate').AsDateTime := _DBDateToDate((rSet.FieldByName('ReservationDate').AsString));
      mResCustomer.FieldByName('Contact').AsString := rSet.FieldByName('ContactName').AsString;
      mResCustomer.FieldByName('ContactPhone').AsString := rSet.FieldByName('ContactPhone').AsString;
      mResCustomer.FieldByName('ContactFax').AsString := rSet.FieldByName('ContactFax').AsString;
      mResCustomer.FieldByName('ContactEmail').AsString := rSet.FieldByName('ContactEmail').AsString;
      mResCustomer.FieldByName('Staff').AsString := rSet.FieldByName('Staff').AsString;
      mResCustomer.FieldByName('ResInfo').AsString := rSet.FieldByName('Information').AsString;
      mResCustomer.FieldByName('PaymentInfo').AsString := rSet.FieldByName('PMInfo').AsString;
      mResCustomer.FieldByName('HiddenInfo').AsString := rSet.FieldByName('HiddenInfo').AsString;
      mResCustomer.FieldByName('CustomerNo').AsString := rSet.FieldByName('Customer').AsString;
      mResCustomer.FieldByName('CustPID').AsString := rSet.FieldByName('CustPID').AsString;
      mResCustomer.FieldByName('Arrival').AsDateTime := _DBDateToDate((rSet.FieldByName('Arrival').AsString));
      mResCustomer.FieldByName('Departure').AsDateTime := _DBDateToDate((rSet.FieldByName('Departure').AsString));
      mResCustomer.Post;

      edName.caption := mResCustomer.FieldByName('Name').AsString;
      edAddress1.caption := mResCustomer.FieldByName('Address1').AsString;
      edAddress2.caption := mResCustomer.FieldByName('Address2').AsString;
      edAddress3.caption := mResCustomer.FieldByName('Address3').AsString;
      edCountry.caption := mResCustomer.FieldByName('Country').AsString;
      edCountryName.caption := mResCustomer.FieldByName('CountryName').AsString;
      edTel1.caption := mResCustomer.FieldByName('Tel1').AsString;
      edTel2.caption := mResCustomer.FieldByName('Tel2').AsString;
      edFax.caption := mResCustomer.FieldByName('Fax').AsString;
      edReservationDate.caption := dateTostr(mResCustomer.FieldByName('ReservationDate').AsDateTime);
      edContact.caption := mResCustomer.FieldByName('Contact').AsString;
      edContactPhone.caption := mResCustomer.FieldByName('ContactPhone').AsString;
      edContactFax.caption := mResCustomer.FieldByName('ContactFax').AsString;
      edContactEmail.caption := mResCustomer.FieldByName('ContactEmail').AsString;
      edStaff.caption := mResCustomer.FieldByName('Staff').AsString;
      memResInfo.text := mResCustomer.FieldByName('ResInfo').AsString;
      memPaymentInfo.text := mResCustomer.FieldByName('PaymentInfo').AsString;
      edCustomerNo.caption := mResCustomer.FieldByName('CustomerNo').AsString;
      edCustPID.caption := mResCustomer.FieldByName('CustPID').AsString;
      edArrival.caption := dateTostr(mResCustomer.FieldByName('Arrival').AsDateTime);
      edDeparture.caption := dateTostr(mResCustomer.FieldByName('Departure').AsDateTime);

    end;
  finally
    freeandNil(rSet);
  end;
end;

procedure TfrmResGuestList.Refresh;
var
  s : string;

  Person : Integer;
  Room : string;
  RoomType : string;
  RoomReservation : Integer;
  reservation : Integer;
  RoomStatus : string;
  Arrival : TdateTime;
  Departure : TdateTime;
  GuestType : string;
  Country : string;
  CountryName : string;
  CountryGroup : string;
  GroupName : string;
  inStatistics : boolean;
  Location : string;
  LocationDescription : string;
  RoomTypeDescription : string;

  GuestName : string;
  Address1 : string;
  Address2 : string;
  Address3 : string;
  Information : string;
  PersionalID : string;
  isMainNAme : boolean;
  isNoRoom : boolean;
  Floor : Integer;

begin
  screen.Cursor := crSQLwait;
  try

    if m_.Active then
      m_.Close;

//    s := '';
//    s := s + ' SELECT  ' + chr(10);
//    s := s + '    Persons.Person  ' + chr(10);
//    s := s + '  , Persons.Reservation  ' + chr(10);
//    s := s + '  , Persons.Name  As GuestName ' + chr(10);
//    s := s + '  , Persons.Address1  ' + chr(10);
//    s := s + '  , Persons.Address2  ' + chr(10);
//    s := s + '  , Persons.Address3  ' + chr(10);
//    s := s + '  , Persons.Country  ' + chr(10);
//    s := s + '  , Persons.GuestType  ' + chr(10);
//    s := s + '  , Persons.Information  ' + chr(10);
//    s := s + '  , Persons.PID  ' + chr(10);
//    s := s + '  , Persons.MainName As isMainName ' + chr(10);
//    s := s + '  , Persons.RoomReservation  ' + chr(10);
//    s := s + '  , RoomReservations.Room  ' + chr(10);
//    s := s + '  , RoomReservations.RoomType  ' + chr(10);
//    s := s + '  , RoomReservations.Status As RoomStatus ' + chr(10);
//    s := s + '  , RoomReservations.rrArrival  ' + chr(10);
//    s := s + '  , RoomReservations.rrDeparture  ' + chr(10);
//    s := s + '  , RoomReservations.rrIsNoRoom  ' + chr(10);
//    s := s + ' FROM  ' + chr(10);
//    s := s + '   Persons  ' + chr(10);
//    s := s + '     LEFT OUTER JOIN  ' + chr(10);
//    s := s + '        RoomReservations ON Persons.RoomReservation = RoomReservations.RoomReservation  ' + chr(10);
//    s := s + ' WHERE  ' + chr(10);
//    s := s + '   (Persons.Reservation = ' + inttostr(zReservation) + ')  ' + chr(10);
//    if not zShowAllGuests then
//    begin
//      s := s + '  AND (name <> ' + quotedstr('RoomGuest') + ') ';
//    end;
//    s := s + ' ORDER BY  ' + chr(10);
//    s := s + '   RoomReservations.Room, Persons.Person  ' + chr(10);

    s :=  select_ResGuestList_Refresh(zShowAllGuests);
    s := format(s , [zReservation]);
    // CopyToClipboard(s);
    // DebugMessage(''#10#10+s);
    hData.rSet_bySQL(r_,s);

    m_.Open;
    R_.First;
    while not R_.Eof do
    begin
      Room := R_.FieldByName('Room').AsString;
      RoomType := R_.FieldByName('RoomType').AsString;
      RoomReservation := R_.FieldByName('RoomReservation').Asinteger;
      reservation := R_.FieldByName('Reservation').Asinteger;
      RoomStatus := R_.FieldByName('RoomStatus').AsString;
      Arrival := R_.FieldByName('rrArrival').AsDateTime;
      Departure := R_.FieldByName('rrDeparture').AsDateTime;
      GuestType := R_.FieldByName('GuestType').AsString;
      Country := R_.FieldByName('Country').AsString;
      Person := R_.FieldByName('Person').Asinteger;
      //**NOT TESTED**//
      if glb.LocateCountry(Country) then
      begin
        CountryName :=  glb.Countries['CountryName']; // GET_CountryName(country); //d.GET_CountryName_byCountry(Country);
        CountryGroup := glb.Countries['CountryGroup']; // d.getCountryGroupFromCountry(Country);
        glb.LocateCountryGroup(CountryGroup);
        GroupName := glb.CountryGroups['GroupName']; // d.getCountryGroupNameFromCountry(Country);
      end;
      if glb.LocateRoom(Room) then
      begin
        inStatistics := glb.RoomsSet['Statistics']; // glb.GetRoomStatistics(Room); // d.getinStatisticsFromRoom(Room);
        Location := glb.RoomsSet['Location']; // d.getLocationFromRoom(Room);
        Floor := glb.RoomsSet['Floor']; // d.getFloorFromRoom(Room);
      end;

      if glb.LocateLocation(Location) then
        LocationDescription := glb.Locations['Description']; // d.GET_LocationDescription_byLocation(Location);


      RoomTypeDescription := glb.GetRoomTypeDescription(RoomType); //// d.GET_RoomTypeDescription_byRoomType(RoomType);

      GuestName := R_.FieldByName('GuestName').AsString;
      Address1 := R_.FieldByName('Address1').AsString;
      Address2 := R_.FieldByName('Address2').AsString;
      Address3 := R_.FieldByName('Address3').AsString;
      Information := R_.FieldByName('Information').AsString;
      PersionalID := R_.FieldByName('PID').AsString;
      isMainNAme := R_['isMainName'];
      isNoRoom := R_['rrIsNoRoom'];

      zCustomer := d.GetCustomerFromRes(zReservation);

      m_.Append;
      m_.FieldByName('Room').AsString := Room;
      m_.FieldByName('RoomType').AsString := RoomType;
      m_.FieldByName('RoomReservation').Asinteger := RoomReservation;
      m_.FieldByName('Reservation').Asinteger := reservation;
      m_.FieldByName('RoomStatus').AsString := RoomStatus;
      m_.FieldByName('Arrival').AsDateTime := Arrival;
      m_.FieldByName('Departure').AsDateTime := Departure;
      m_.FieldByName('GuestType').AsString := GuestType;
      m_.FieldByName('Country').AsString := Country;
      m_.FieldByName('CountryName').AsString := CountryName;
      m_.FieldByName('CountryGroup').AsString := CountryGroup;
      m_.FieldByName('GroupName').AsString := GroupName;
      m_.FieldByName('inStatistics').Asboolean := inStatistics;
      m_.FieldByName('Location').AsString := Location;
      m_.FieldByName('LocationDescription').AsString := LocationDescription;
      m_.FieldByName('RoomTypeDescription').AsString := RoomTypeDescription;
      m_.FieldByName('Person').Asinteger := Person;

      m_.FieldByName('GuestName').AsString := GuestName;
      m_.FieldByName('Address1').AsString := Address1;
      m_.FieldByName('Address2').AsString := Address2;
      m_.FieldByName('Address3').AsString := Address3;
      m_.FieldByName('Information').AsString := Information;
      m_.FieldByName('PersionalID').AsString := PersionalID;
      m_.FieldByName('isMainName').Asboolean := isMainNAme;
      m_.FieldByName('isNoRoom').Asboolean := isNoRoom;
      m_.FieldByName('Floor').Asinteger := Floor;

      m_.Post;
      R_.next;
    end;

    m_.First;

    getRes(zReservation);
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmResGuestList.btnRefreshClick(Sender : TObject);
begin
  Refresh;
end;

procedure TfrmResGuestList.LMDSpeedButton3Click(Sender : TObject);
var
  sFilename : string;
  s : string;
begin
  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_ReservationGuestList';
  ExportGridToExcel(sFilename, cxGrid1, True, True, True);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmResGuestList.LMDSpeedButton4Click(Sender : TObject);
var
  FileName : string;

begin
  // **+
  updateHeadInfo;

  FileName := FileDependencyManager.getGuestListReportFilePath;

  if not fileExists(FileName) then
  begin
	  showmessage(format(GetTranslatedText('shTx_ResGuestList_FileNotFound'), [FileName]));
    exit;
  end;
  rpt.LoadFromFile(FileName);

  rpt.PrintOptions.Printer := 'Default';

  if g.qReportPrinter <> '' then
  begin
    rpt.PrintOptions.Printer := g.qReportPrinter;
  end;
  rpt.ShowReport(false);
end;

procedure TfrmResGuestList.LMDSpeedButton5Click(Sender : TObject);
var
  FileName : string;
begin
  // **+
  updateHeadInfo;

  FileName := FileDependencymanager.getGuestListReportFilePath;

  if not fileExists(FileName) then
  begin
	  showmessage(format(GetTranslatedText('shTx_ResGuestList_FileNotFound'), [FileName]));
    exit;
  end;
  rpt.LoadFromFile(FileName);
  rpt.DesignReport(True);
end;

procedure TfrmResGuestList.LMDSpeedButton9Click(Sender : TObject);
var
  FileName : string;
begin
  updateHeadInfo;

  FileName := FileDependencymanager.getCustomerStayReportFilePath;

  if not fileExists(FileName) then
  begin
	  showmessage(format(GetTranslatedText('shTx_ResGuestList_FileNotFound'), [FileName]));
    exit;
  end;
  rpt.LoadFromFile(FileName);

  rpt.PrintOptions.Printer := 'Default';

  if g.qReportPrinter <> '' then
  begin
    rpt.PrintOptions.Printer := g.qReportPrinter;
  end;
  rpt.ShowReport(false);
end;

procedure TfrmResGuestList.LMDSpeedButton10Click(Sender : TObject);
var
  FileName : string;
begin
  updateHeadInfo;

  FileName := FileDependencymanager.getCustomerStayReportFilePath;

  if not fileExists(FileName) then
  begin
	  showmessage(format(GetTranslatedText('shTx_ResGuestList_FileNotFound'), [FileName]));
    exit;
  end;
  rpt.LoadFromFile(FileName);
  rpt.DesignReport(True);
end;

procedure TfrmResGuestList.chkShowAllGuestsClick(Sender : TObject);
begin
  zShowAllGuests := not zShowAllGuests;
  Refresh;

end;

procedure TfrmResGuestList.ClearAll;
begin
  // **
  if m_.Active then
    m_.Close;
  edName.caption := '';
  edAddress1.caption := '';
  edAddress2.caption := '';
  edAddress3.caption := '';
  edCountry.caption := '';
  edCountryName.caption := '';
  edTel1.caption := '';
  edTel2.caption := '';
  edFax.caption := '';
  edReservationDate.caption := '';
  edContact.caption := '';
  edContactPhone.caption := '';
  edContactFax.caption := '';
  edContactEmail.caption := '';
  edStaff.caption := '';
  memResInfo.text := '';
  memPaymentInfo.text := '';
  edCustomerNo.caption := '';
  edCustPID.caption := '';
  edArrival.caption := '';
  edDeparture.caption := '';
end;

procedure TfrmResGuestList.cxGrid1DBTableView1DblClick(Sender : TObject);
var
  GuestName : string;
  tmp : Integer;
  theData : recPersonHolder;
begin
  zRoomReservation := m_.FieldByName('RoomReservation').Asinteger;
  GuestName := m_.FieldByName('GuestName').AsString;

  initPersonHolder(theData);
  theData.Reservation := zReservation;
  theData.RoomReservation := zRoomReservation;
  theData.name := guestName;

  if openGuestProfile(actNone,theData) then
  begin
    tmp := m_.FieldByName('person').Asinteger;
    Refresh;
    m_.First;
    m_.Locate('person', tmp, []);
  end;

end;

end.
