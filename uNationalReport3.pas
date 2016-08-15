unit uNationalReport3;

interface

uses
   Windows
  ,Messages
  ,SysUtils
  ,Variants
  , Classes
  ,Graphics
  ,Controls
  ,Forms
  ,Dialogs
  ,StdCtrls
  ,ExtCtrls
  ,shellapi
  ,DB
  ,Vcl.ComCtrls
  ,ADODB

  ,dateUtils
  ,Menus
  ,hData
  ,_glob
  ,ug

  ,cmpRoomerDataSet
  ,cmpRoomerConnection



  ,kbmMemTable
  ,PlannerDatePicker

  ,sGroupBox
  ,sPageControl
  ,sPanel
  ,sLabel

  , cxGridExportLink
  ,dxmdaset

  ,dxSkinsCore, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxCalc, cxLabel, dxSkinsdxStatusBarPainter, cxPropertiesStore, ppDB, ppDBPipe, ppParameter, ppDesignLayer, ppCtrls,
  ppBands, ppVar, ppPrnabl, ppClass, ppCache, ppComm, ppRelatv, ppProd, ppReport, sEdit, sSpinEdit, sComboBox, AdvEdit, AdvEdBtn,
  dxStatusBar, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, sButton,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue
  ;

type
  TfrmNationalReport3 = class(TForm)
    pageMain: TsPageControl;
    dxStatusBar1 : TdxStatusBar;
    Panel3: TsPanel;
    cxGroupBox1: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    cxGroupBox2: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    Panel4: TsPanel;
    Panel8: TsPanel;
    Bevel2 : TBevel;
    labcReservations: TsLabel;
    labcRoomReservations: TsLabel;
    labReservations: TsLabel;
    labRoomreservations: TsLabel;
    sheetNationalStatistics1: TsTabSheet;
    Panel2: TsPanel;
    tvNationalStatistics1: TcxGridDBTableView;
    levNationalStatistics1: TcxGridLevel;
    grNationalStatistics1: TcxGrid;
    mHagstofa1: TdxMemData;
    mHagstofa1Country: TWideStringField;
    mHagstofa1CountryName: TWideStringField;
    mHagstofa1Nights: TIntegerField;
    mHagstofa1CountryGroup: TWideStringField;
    mHagstofa1GroupName: TWideStringField;
    mHagstofaDS: TDataSource;
    tvNationalStatistics1RecId: TcxGridDBColumn;
    tvHagstofa1Country: TcxGridDBColumn;
    tvHagstofa1CountryName: TcxGridDBColumn;
    tvNationalStatistics1Nights: TcxGridDBColumn;
    tvNationalStatistics1CountryGroup: TcxGridDBColumn;
    tvNationalStatistics1GroupName: TcxGridDBColumn;
    cxLabel1: TsLabel;
    labGuestNights: TsLabel;
    mHagstofa1Precent: TFloatField;
    tvNationalStatistics1Precent: TcxGridDBColumn;
    mNationalStatistics: TdxMemData;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    IntegerField1: TIntegerField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    FloatField1: TFloatField;
    IntegerField2: TIntegerField;
    tvNationalStatistics1Guests: TcxGridDBColumn;
    mHagstofa1PrecentGuests: TFloatField;
    tvNationalStatistics1PrecentGuests: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    mnuThisRoom: TMenuItem;
    MenuItem1: TMenuItem;
    OpenthisRoom1: TMenuItem;
    MenuItem2: TMenuItem;
    btnNationalStatisticsExcel: TsButton;
    btnNationalStatisticsReport: TsButton;
    cxLabel2: TsLabel;
    labNights: TsLabel;
    Bevel3: TBevel;
    cxLabel4: TsLabel;
    cxLabel5: TsLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    cxLabel10: TsLabel;
    labDays: TsLabel;
    cxTabSheet1: TsTabSheet;
    Panel5: TsPanel;
    btnGuestsExcel: TsButton;
    brnGuestsReservation: TsButton;
    mAllGuests: TdxMemData;
    mAllGuests2DS: TDataSource;
    mAllGuestsReservation: TIntegerField;
    mAllGuestsRoomReservation: TIntegerField;
    mAllGuestsGuestName: TWideStringField;
    mAllGuestsPerson: TIntegerField;
    mAllGuestsStatus: TWideStringField;
    mAllGuestsGroupAccount: TBooleanField;
    mAllGuestsArrival: TDateTimeField;
    mAllGuestsDeparture: TDateTimeField;
    mAllGuestsNoRoom: TBooleanField;
    tvAllGuests: TcxGridDBTableView;
    lvAllGuests: TcxGridLevel;
    grAllGuests: TcxGrid;
    mAllGuestsReservationCountry: TWideStringField;
    tvAllGuestsRecId: TcxGridDBColumn;
    tvAllGuestsReservation: TcxGridDBColumn;
    tvAllGuestsRoomReservation: TcxGridDBColumn;
    tvAllGuestsGuestName: TcxGridDBColumn;
    tvAllGuestsPerson: TcxGridDBColumn;
    tvAllGuestsStatus: TcxGridDBColumn;
    tvAllGuestsGroupAccount: TcxGridDBColumn;
    tvAllGuestsArrival: TcxGridDBColumn;
    tvAllGuestsDeparture: TcxGridDBColumn;
    tvAllGuestsNoRoom: TcxGridDBColumn;
    tvAllGuestsReservationCountry: TcxGridDBColumn;
    mAllGuestsGuestsCountry: TWideStringField;
    mAllGuestsGuestCountryName: TWideStringField;
    mAllGuestsGuestGroupName: TWideStringField;
    tvAllGuestsGuestsCountry: TcxGridDBColumn;
    tvAllGuestsGuestCountryName: TcxGridDBColumn;
    tvAllGuestsGuestGroupName: TcxGridDBColumn;
    mAllGuestsReservationsName: TWideStringField;
    tvAllGuestsReservationsName: TcxGridDBColumn;
    mAllGuestsResInfo: TStringField;
    tvAllGuestsResInfo: TcxGridDBColumn;
    mAllGuestsRoom: TWideStringField;
    mAllGuestsRoomType: TWideStringField;
    tvAllGuestsRoom: TcxGridDBColumn;
    tvAllGuestsRoomType: TcxGridDBColumn;
    btnExpandAll: TsButton;
    btnCollapseAll: TsButton;
    m: TkbmMemTable;
    rptbHagstofa: TppReport;
    ppDBPipeline1: TppDBPipeline;
    mDS: TDataSource;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDBText2: TppDBText;
    ppDBText1: TppDBText;
    ppDBText3: TppDBText;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    rlabFrom: TppLabel;
    rLabTo: TppLabel;
    ppLabel6: TppLabel;
    rLabHotelName: TppLabel;
    rlabUser: TppLabel;
    rLabTimeCreated: TppLabel;
    ppSummaryBand1: TppSummaryBand;
    ppLabel7: TppLabel;
    labGuestCount: TppLabel;
    ppLabel9: TppLabel;
    labNightCount: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel8: TppLabel;
    labReservationCount: TppLabel;
    labRoomReservationCount: TppLabel;
    labRoomCount: TppLabel;
    labBedCount: TppLabel;
    labDayCount: TppLabel;
    ppLine11: TppLine;
    labReservationsCaption: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    labTotalRoomCount: TppLabel;
    ppLabel17: TppLabel;
    labTotalBedCount: TppLabel;
    ppLabel19: TppLabel;
    ppLine12: TppLine;
    ppLabel16: TppLabel;
    ppLabel18: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    cxButton1: TsButton;
    cxLabel8: TsLabel;
    cxLabel6: TsLabel;
    labRooms: TsLabel;
    labBeds: TsLabel;
    mHagstofa1orderIndex: TIntegerField;
    mHagstofa1ReservationCount: TIntegerField;
    tvNationalStatistics1orderIndex: TcxGridDBColumn;
    tvNationalStatistics1ReservationCount: TcxGridDBColumn;
    mHagstofa1RoomReservationCount: TIntegerField;
    tvNationalStatistics1RoomReservationCount: TcxGridDBColumn;
    edPrivate: TsSpinEdit;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    edConfress: TsSpinEdit;
    sLabel3: TsLabel;
    edBuisiness: TsSpinEdit;
    sLabel4: TsLabel;
    LabTotalVisitType: TsLabel;
    sLabel6: TsLabel;
    ppLabel22: TppLabel;
    rlabPrivate: TppLabel;
    ppLabel24: TppLabel;
    rLabConfress: TppLabel;
    ppLabel26: TppLabel;
    rLabBusiness: TppLabel;
    ppShape1: TppShape;
    ppLabel23: TppLabel;
    FormStore: TcxPropertiesStore;
    labLocations: TsLabel;
    labLocationsList: TsLabel;
    procedure FormShow(Sender : TObject);
    procedure cbxMonthPropertiesCloseUp(Sender : TObject);
    procedure btnRefreshClick(Sender : TObject);
    procedure dtDateFromChange(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure btnExitClick(Sender: TObject);
    procedure btnGuestsExcelClick(Sender: TObject);
    procedure brnGuestsReservationClick(Sender: TObject);
    procedure btnNationalStatisticsExcelClick(Sender: TObject);
    procedure btnExpandAllClick(Sender: TObject);
    procedure btnCollapseAllClick(Sender: TObject);
    procedure btnNationalStatisticsReportClick(Sender: TObject);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure ppSummaryBand1BeforePrint(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure edPrivateChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zDateFrom : Tdate;
    zDateTo   : Tdate;
    zYear     : integer;
    zMonth    : integer;
    zSetDates : boolean;

    lstReservations : TstringList;
    lstRoomReservations : TstringList;

    zRoomReservationsList : string;

    isFirstTime : boolean;

    zReservationCount : integer;
    zRoomReservationCount : integer;

    zGuestCount : integer;
    zNightCount : integer;
    zRoomCount  : integer;
    zBedCount   : integer;
    zDayCount   : integer;

    zLocationList : string;

    procedure getGuests;
    procedure getAllGuests;
    procedure getResCount;

    procedure updateSums;
    function getRoomReservationsList : string;
    procedure getRoomInfo;
    procedure ShowData;

  public
    { Public declarations }
  end;

var
  frmNationalReport3 : TfrmNationalReport3;

implementation

uses
    UITypes
  , uD
  , uReservationProfile
  , uFinishedInvoices2
  , uInvoice
  , uRptbViewer
  , uStringUtils
  , uAppGlobal
  , uCountries
  , uSqlDefinitions
  , PrjConst
  , uDImages
  , uUtils
  , uMain;
{$R *.dfm}


function TfrmNationalReport3.getRoomReservationsList : string;
var
  s      : string;
  rrList : TstringList;
  i      : integer;
begin
  rrList := d.RRlst_DepartureNationalReportByLocation(zDateFrom, zDateTo,zLocationList);
  try
    s := '';
    for i := 0 to rrList.Count - 1 do
    begin
      s := s+rrList[i]+',';
    end;
    if length(s) > 0 then
    begin
      delete(s,length(s),1);
      s := '('+s+')'
    end else
    begin
      s := '(-1)'
    end;

    zRoomReservationCount := rrList.count;
    updateSums;
  finally
    freeandNil(rrList);
  end;
  result := s;
end;

procedure TfrmNationalReport3.ppHeaderBand1BeforePrint(Sender: TObject);
var
  s : string;
begin
  dateTimeToString(s, 'dd.mm.yyyy', zDateFrom);
  rlabFrom.Caption := s;
  dateTimeToString(s, 'dd.mm.yyyy', zDateTo);
  rlabTo.Caption := s;

  s := g.qHotelName;
  rLabHotelName.Caption := s;

  dateTimeToString(s, 'dd mmm yyyy hh:nn', now);

 // s := 'Created : ' + s;
  s := GetTranslatedText('shTx_NationalReport_Created') + s;
  rLabTimeCreated.Caption := s;

 // s := 'User : ' + g.qUser;
   s := GetTranslatedText('shTx_NationalReport_User') + g.qUser;
  if g.qusername <> '' then
    s := s + ' - ' + g.qusername;
  rlabUser.Caption := s;
end;

procedure TfrmNationalReport3.ppSummaryBand1BeforePrint(Sender: TObject);
var
  totalBedCount  : integer;
  totalRoomCount : integer;

begin

  labReservationCount.caption          :=  inttostr(zReservationCount) ;
  labRoomReservationCount.caption      :=  inttostr(zRoomReservationCount) ;
  labGuestCount.caption                :=  inttostr(zGuestCount) ;
  labNightCount.caption                :=  inttostr(zNightCount) ;
  labRoomCount.caption                 :=  inttostr(zRoomCount) ;
  labBedCount.caption                  :=  inttostr(zBedCount) ;
  labDayCount.caption                  :=  inttostr(zDayCount) ;

  totalBedCount  := zBedCount*zDayCount;
  totalRoomCount := zRoomCount*zDayCount;

  labTotalBedCount.Caption := inttostr(totalBedCount);
  labTotalRoomCount.Caption := inttostr(totalRoomCount);

  try
    rLabPrivate.caption := inttostr(edPrivate.Value);
    rLabConfress.caption := inttostr(edConfress.Value);
    rLabBusiness.caption := inttostr(edBuisiness.Value);
  Except
    rLabBusiness.caption := '0';
    rLabConfress.caption := '0';
    rLabPrivate.caption  := '0';
  end;
end;

procedure TfrmNationalReport3.getRoomInfo;
var
  s : string;
  rSet : TRoomerDataSet;
begin
  s := '';
  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try
      s := '';
      s := s + ' SELECT '#10;
      s := s + '     COUNT(rooms.Room) AS RoomCount '#10;
      s := s + '   , SUM(roomtypes.NumberGuests) AS BedCount '#10;
      s := s + ' FROM '#10;
      s := s + '    rooms '#10;
      s := s + '     INNER JOIN '#10;
      s := s + '       roomtypes ON  rooms.RoomType = roomtypes.RoomType '#10;
      s := s + ' WHERE '#10;
      s := s + '  ( '#10;
      s := s + '      (rooms.Bookable = 1) '#10;
      s := s + '  AND (rooms.useInNationalReport = 1) '#10;
      s := s + '  AND (rooms.wildcard = 0 AND rooms.Statistics = 1 AND rooms.Active = 1) '#10;
      if zLocationList <> '' then
      begin
        s := s + '  AND (rooms.Location in ('+zLocationList+') ) '#10;
      end;
      s := s+' ) '#10;


      hData.rSet_bySQL(rSet,s);
      if not rSet.Eof then
      begin
        zRoomCount := rSet.FieldByName('RoomCount').asInteger;
        try
          zBedCount := rSet.FieldByName('BedCount').asInteger;
        except
          zBedCount := 0;
        end;
        updateSums;
      end;

    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;

end;

procedure TfrmNationalReport3.btnCollapseAllClick(Sender: TObject);
begin
tvAllGuests.DataController.Groups.FullCollapse;
end;

procedure TfrmNationalReport3.btnExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmNationalReport3.btnExpandAllClick(Sender: TObject);
begin
  //**
  tvAllGuests.DataController.Groups.FullExpand;
end;

procedure TfrmNationalReport3.btnRefreshClick(Sender : TObject);
begin
  getGuests;
  getAllGuests;
end;



procedure TfrmNationalReport3.getGuests;
var
  s : string;
  rSet : TRoomerDataSet;


  totalNights : integer;
  totalGuests : integer;

  precent : double;
  precentGuests : double;

  country : string;
  countryName : string;
  GuestNights   : integer;
  CountryGroup  : string;
  GroupName     : string;
  GuestCount        : integer;

  ReservationCount : integer;
  RoomReservationCount : integer;

  OrderIndex : integer;

begin
  zDayCount := (trunc(zDateTo)-trunc(zDateFrom))+1;
  updateSums;
  zRoomReservationsList := getRoomReservationsList;
  getRoomInfo;

  tvHagstofa1Country.Visible := true;
  tvHagstofa1CountryName.Visible := true;
//  cvHagstofa1Chart.Categories.DataBinding.FieldName := 'CountryName';
  btnNationalStatisticsReport.Enabled := true;

  s :=

  'SELECT '#10+
  'countries.Country, '#10+
  'countries.CountryName, '#10+
  'countries.CountryGroup, '#10+
  'countries.OrderIndex, '#10+
  'countrygroups.GroupName, '#10+
  'COUNT(DISTINCT persons.RoomReservation) AS RoomReservationCount, '#10+
  'COUNT(persons.ID) AS GuestNights, '#10+
  'COUNT(DISTINCT persons.ID) AS GuestCount, '#10+
  'COUNT(DISTINCT persons.Reservation) AS ReservationCount '#10+
  'FROM '#10+
  '  countries '#10+
  '    INNER JOIN countrygroups ON countries.countrygroup = countrygroups.CountryGroup '#10+
  '    INNER JOIN persons ON countries.country = persons.country '#10+
  '    INNER JOIN reservations ON persons.Reservation = reservations.Reservation '#10+
  '    INNER JOIN roomsdate ON persons.RoomReservation = roomsdate.RoomReservation '#10+
  ///ERROR Corrected
//  '    INNER JOIN rooms on (rooms.room=roomsdate.room and rooms.wildcard=0 and rooms.active=1) '#10+
  ' WHERE '#10+
  '   (persons.RoomReservation IN %s )'#10+
  '      AND (((Resflag in (''G'',''P'',''D'',''O'',''A'')) AND (SUBSTR(roomsdate.room, 1, 1) != ''<'')) OR ((Resflag in (''G'',''D'')) AND (SUBSTR(roomsdate.room, 1, 1) = ''<''))) '#10+
  '      AND (SUBSTR(roomsdate.room, 1, 1) = ''<'' OR NOT ISNULL((SELECT 1 FROM rooms r WHERE r.room=roomsdate.room and r.wildcard=0 and r.active=1 and statistics=1 and hidden=0 LIMIT 1))) '#10+
  ' GROUP BY '#10+
  '   countries.OrderIndex, '#10+
  '   countries.Country, '#10+
  '   countries.CountryName, '#10+
  '   countries.CountryGroup, '#10+
  '   countrygroups.GroupName '#10+
  ' ORDER BY orderIndex DESC ';



//  'SELECT '#10+
//  'countries.Country, '#10+
//  'countries.CountryName, '#10+
//  'countries.CountryGroup, '#10+
//  'countries.OrderIndex, '#10+
//  'countrygroups.GroupName, '#10+
//  'COUNT(DISTINCT persons.RoomReservation) AS RoomReservationCount, '#10+
//  'COUNT(persons.ID) AS GuestNights, '#10+
//  'COUNT(DISTINCT persons.ID) AS GuestCount, '#10+
//  'COUNT(DISTINCT persons.Reservation) AS ReservationCount '#10+
//  'FROM '#10+
//  '  countries '#10+
//  '    INNER JOIN countrygroups ON countries.countrygroup = countrygroups.CountryGroup '#10+
//  '    INNER JOIN persons ON countries.country = persons.country '#10+
//  '    INNER JOIN reservations ON persons.Reservation = reservations.Reservation '#10+
//  '    INNER JOIN roomsdate ON persons.RoomReservation = roomsdate.RoomReservation '#10+
//  ' WHERE '#10+
//  '   (persons.RoomReservation IN %s )'#10+
//  '      AND (((Resflag in (''G'',''P'',''D'',''O'',''A'')) AND roomsdate.isNoRoom=0) OR ((Resflag in (''G'',''D'')) AND roomsdate.isNoRoom<>0)) '#10+
//  ' GROUP BY '#10+
//  '   countries.OrderIndex, '#10+
//  '   countries.Country, '#10+
//  '   countries.CountryName, '#10+
//  '   countries.CountryGroup, '#10+
//  '   countrygroups.GroupName '#10+
//  ' ORDER BY orderIndex DESC ';




  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try
      s := format(s, [zRoomReservationsList]);

      hData.rSet_bySQL(rSet,s);
      if mNationalStatistics.Active then mNationalStatistics.Close;
      mNationalStatistics.open;
      mNationalStatistics.LoadFromDataSet(rSet);
      mNationalStatistics.First;

      rSet.First;
      if mHagstofa1.Active then mHagstofa1.Close;
      mHagstofa1.Open;

      mHagstofa1.DisableControls;
      try
        totalnights := 0;
        totalGuests := 0;
        while not rSet.Eof do
        begin
          country              := rSet.FieldByName('Country').AsString;
          countryName          := rSet.FieldByName('CountryName').AsString;
          RoomReservationCount := rSet.FieldByName('RoomReservationCount').AsInteger;
          ReservationCount     := rSet.FieldByName('ReservationCount').AsInteger;
          CountryGroup         := rSet.FieldByName('CountryGroup').AsString;
          GroupName            := rSet.FieldByName('GroupName').AsString;
          GuestCount           := rSEt.FieldByName('GuestCount').AsInteger;;
          GuestNights          := rSEt.FieldByName('GuestNights').AsInteger;
          Orderindex           := rSEt.FieldByName('orderIndex').AsInteger;

          totalNights := TotalNights+Guestnights;
          totalGuests := TotalGuests+guestCount;

          mHagstofa1.Append;
          mHagstofa1.fieldbyname('country').AsString               :=  country;
          mHagstofa1.fieldbyname('countryName').AsString           :=  countryName;
          mHagstofa1.fieldbyname('RoomReservationCount').AsInteger :=  RoomReservationCount;
          mHagstofa1.fieldbyname('ReservationCount').AsInteger     :=  ReservationCount;
          mHagstofa1.fieldbyname('CountryGroup').AsString          :=  CountryGroup;
          mHagstofa1.fieldbyname('GroupName').AsString             :=  GroupName;
          mHagstofa1.fieldbyname('Guests').AsInteger               :=  GuestCount;
          mHagstofa1.fieldbyname('Nights').AsInteger               :=  GuestNights;
          mHagstofa1.FieldByName('OrderIndex').AsInteger           :=  OrderIndex;
          mHagstofa1.post;
          rSet.Next;
        end;

        mHagstofa1.First;
        while not mHagstofa1.Eof do
        begin
          Precent          := 0.00;
          PrecentGuests   := 0.00;


          GuestNights := mHagstofa1.fieldbyname('Nights').AsInteger;
          if totalNights > 0 then
          begin
            precent := (GuestNights/totalNights)*100;
          end;

          GuestCount := mHagstofa1.fieldbyname('Guests').AsInteger;
          if totalGuests > 0 then
          begin
            precentGuests := (GuestCount/totalGuests)*100;
          end;

          mHagstofa1.edit;
          mHagstofa1.FieldByName('precent').AsFloat        :=  precent;
          mHagstofa1.FieldByName('precentGuests').AsFloat  :=  precentGuests;
          mHagstofa1.Post;

          mHagstofa1.next;
        end;

        mHagstofa1.first;
        zGuestCount := totalGuests;
        zNightCount := totalNights;
        updateSums;
      finally
        mHagstofa1.EnableControls;
        screen.Cursor := crDefault;
      end;
    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;




  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
  finally
    freeandNil(rSet);
  end;
end;





procedure TfrmNationalReport3.getAllGuests;
var
  s         : string;
  rSet      : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    mAllGuests.DisableControls;

    s :=
    ' SELECT '#10+
    '     roomreservations.Reservation '#10+
    '   , roomreservations.RoomReservation '#10+
    '   , reservations.Customer '#10+
    '   , persons.Name AS GuestName '#10+
    '   , persons.Person '#10+
    '   , persons.Country AS GuestsCountry'#10+
    '   , countries.CountryName AS GuestCountryName '#10+
    '   , countrygroups.GroupName AS GuestGroupName '#10+#10+
    '   , roomreservations.Room '#10+
    '   , roomreservations.RoomType '#10+
    '   , roomreservations.Status '#10+
    '   , roomreservations.GroupAccount '#10+
    '   , roomreservations.rrArrival As Arrival'#10+
    '   , roomreservations.rrDeparture As Departure'#10+
    '   , roomreservations.rrIsNoRoom as NoRoom'#10+
    '   , reservations.Name AS ReservationsName '#10+
    '   , reservations.Country AS ReservationCountry '#10+
    ' FROM '#10+
    '   countries '#10+
    '     RIGHT OUTER JOIN '#10+
    '       persons ON countries.Country = persons.Country '#10+
    '     LEFT OUTER JOIN '#10+
    '       countrygroups ON countries.CountryGroup = countrygroups.CountryGroup '#10+
    '     RIGHT OUTER JOIN '#10+
    '       roomreservations ON persons.RoomReservation = roomreservations.RoomReservation '#10+
    '     INNER JOIN rooms ro ON roomreservations.room=ro.room and ro.wildcard=0 and ro.active=1  '#10 +
    '     RIGHT OUTER JOIN '#10+
    '       reservations ON roomreservations.Reservation = reservations.Reservation '#10+
    ' WHERE '#10+
    '        ( roomreservations.RoomReservation in  %s ) '+  //zRoomReservationsLis#10+
    '      AND (((roomreservations.Status in (''G'',''P'',''D'',''O'',''A'')) AND Left(roomreservations.Room,1) <> ''<'') OR ((roomreservations.Status in (''G'',''D'')) AND Left(roomreservations.Room,1) = ''<'')) '#10+
    ' ORDER BY '#10+
    '   reservations.Reservation ';


    try

      s := format(s , [zRoomReservationsList]);

      hData.rSet_bySQL(rSet,s);

      if not mAllGuests.Active then mAllGuests.Close;
      mAllGuests.open;
      mAllGuests.LoadFromDataSet(rSet);
      mAllGuests.First;
      while Not mAllGuests.eof do
      begin
        mAllGuests.Edit;
        mAllGuests.FieldByName('ResInfo').AsString :=
           inttostr(mAllGuests.FieldByName('Reservation').AsInteger)+' | '+
           mAllGuests.FieldByName('ReservationCountry').AsString+' | '+
           mAllGuests.FieldByName('ReservationsName').AsString;

        mAllGuests.Post;
        mAllGuests.next;
      end;
      mAllGuests.First;


    finally
      mAllGuests.EnableControls;
      tvAllGuests.DataController.Groups.FullExpand;
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;
  getResCount;
end;


procedure TfrmNationalReport3.getResCount;
var
  s         : string;
  rSet      : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    screen.Cursor := crHourGlass;
    try

      s :=
      ' SELECT DISTINCT '#10+
      '     roomreservations.Reservation '#10+
      ' FROM '#10+
      '   roomreservations '#10+
      ' WHERE '#10+
      '     ( roomreservations.RoomReservation in  %s ) '+  //zRoomReservationsLis#10+
      '      AND (((roomreservations.Status in (''G'',''P'',''D'',''O'',''A'')) AND Left(roomreservations.Room,1) <> ''<'') OR ((roomreservations.Status in (''G'',''D'')) AND Left(roomreservations.Room,1) = ''<'')) ';

      s := format(s , [zRoomReservationsList]);
      hData.rSet_bySQL(rSet,s);
      zReservationCount := rSet.RecordCount;
      updateSums;
    finally
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;
end;


procedure TfrmNationalReport3.cbxMonthPropertiesCloseUp(Sender : TObject);
var
  y, m : word;
  lastDay : integer;

begin

  if cbxYear.ItemIndex < 1 then
    exit;
  if cbxMonth.ItemIndex < 1 then
    exit;
  zSetDates := false;
  y := StrToInt(cbxYear.Items[cbxYear.ItemIndex]);
//  y := cbxYear.ItemIndex + 2010;
  m := cbxMonth.ItemIndex;

  zDateFrom := encodeDate(y, m, 1);
  lastDay := _DaysPerMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;
end;


procedure TfrmNationalReport3.btnGuestsExcelClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_HagstofaGuests';
  ExportGridToExcel(sFilename, grAllGuests, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmNationalReport3.btnNationalStatisticsExcelClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Hagstofa';
  ExportGridToExcel(sFilename, grNationalStatistics1, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmNationalReport3.btnNationalStatisticsReportClick(Sender: TObject);
var
  CountryGroup : string;
  GroupName : string;
  OrderIndex : integer;
  aReport   : TppReport;
  Guests : integer;
  Nights : integer;

  countryName : string;
  country     : string;


begin
  if m.active then m.Close;
  m.Open;

  mHagstofa1.DisableControls;
  try
    mHagStofa1.First;
    while not mHagstofa1.eof do
    begin
      GroupName  := '';

      countryGroup := mHagstofa1.FieldByName('CountryGroup').AsString;
      guests       := mHagstofa1.FieldByName('Guests').AsInteger;
      Nights       := mHagstofa1.FieldByName('Nights').AsInteger;
      GroupName    := mHagstofa1.FieldByName('GroupName').AsString;
      OrderIndex   := mHagstofa1.FieldByName('OrderIndex').AsInteger;
      Country      := mHagstofa1.fieldbyname('country').AsString;
      CountryName  := mHagstofa1.fieldbyname('countryName').AsString;

      m.append;
        m.FieldByName('countryGroup').AsString := countryGroup;
        m.FieldByName('GroupName').AsString    := GroupName;
        m.FieldByName('OrderIndex').AsInteger  := OrderIndex;
        m.FieldByName('Guests').AsInteger      := Guests;
        m.FieldByName('Nights').AsInteger      := Nights;
        m.FieldByName('country').AsString      := country;
        m.FieldByName('CountryName').AsString  := CountryName;
      m.Post;
      mHagstofa1.Next;
    end;
  finally
    mHagstofa1.EnableControls;
  end;

  m.SortFields := 'orderindex';
  m.Sort([mtcoDescending]);

  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
  frmRptbViewer.show;

  screen.Cursor := crHourglass;
  try
    aReport := rptbHagstofa;
    frmRptbViewer.ppViewer1.Reset;
    frmRptbViewer.ppViewer1.Report := aReport;
    frmRptbViewer.ppViewer1.GotoPage(1);
    aReport.PrintToDevices;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmNationalReport3.brnGuestsReservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
   iReservation := mAllGuests.FieldByName('Reservation').AsInteger;
  iRoomReservation := mAllGuests.FieldByName('RoomReservation').AsInteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin

  end;
end;

procedure TfrmNationalReport3.dtDateFromChange(Sender : TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmNationalReport3.edPrivateChange(Sender: TObject);
var
  i : integer;
begin
  i := 0;
  try
    i := edPrivate.Value+edBuisiness.value+edConfress.value;
  Except
  end;

  LabTotalVisitType.caption := inttostr(i);
end;

procedure TfrmNationalReport3.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  freeandNil(lstReservations);
  freeandNil(lstRoomReservations);
end;

procedure TfrmNationalReport3.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);

  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);

  PageMain.ActivePageIndex := 0;
  lstReservations := TstringList.Create;
  lstRoomReservations := TstringList.Create;

  lstReservations.Sorted := true;
  lstReservations.Duplicates := dupIgnore;
  lstRoomReservations.Sorted := true;
  lstRoomReservations.Duplicates := dupIgnore;

  zReservationCount := 0;
  zRoomReservationCount := 0;
  zGuestCount := 0;
  zNightCount := 0;

  zRoomCount  := 0;
  zBedCount   := 0;
  zDayCount   := 0;

  isfIrstTime := true;
end;


procedure TfrmNationalReport3.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmNationalReport3.updateSums;
begin
  labReservations.Caption := inttostr(zReservationCount);
  labRoomReservations.Caption := inttostr(zRoomReservationCount);

  labGuestNights.Caption := inttostr(zGuestCount);
  labNights.Caption := inttostr(zNightCount);

  labRooms.Caption := inttostr(zRoomCount);
  labBeds.Caption := inttostr(zBedCount);
  labDays.Caption := inttostr(zDayCount)

end;


procedure TfrmNationalReport3.FormShow(Sender : TObject);
begin
  ShowData;
end;

procedure TfrmNationalReport3.ShowData;
var
  y, m, d : word;
  lastDay : integer;
  lLocations: TSet_Of_Integer;
begin
  zSetDates := false;

  decodeDate(now, y, m, d);
  zYear := y;
  zMonth := m;
  cbxMonth.ItemIndex := zMonth;

  cbxYear.ItemIndex := cbxYear.Items.IndexOf(inttostr(zYear));

  zDateFrom := encodeDate(y, m, 1);
  lastDay := _DaysPerMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;

  btnNationalStatisticsReport.Enabled := true;

  //**
  zLocationList := '';
  zRoomReservationsList := '';

  lLocations := frmmain.FilteredLocations;
  try
  zLocationList := glb.LocationSQLInString(lLocations);
  finally
    lLocations.Free;
  end;

  if zLocationList = '' then
  begin
    labLocationsList.caption := 'All Locations';
  end else
  begin
    labLocationsList.caption := zLocationList;
  end;

  isFirstTime := false;
end;

procedure TfrmNationalReport3.cxButton1Click(Sender: TObject);
var
  iReservation : integer;

  oldCountry : string;
  oldCountryName : string;

  newCountry     : string;

  S : string;
  countryHolder : recCountryHolder;

begin
  //TESTED// lev3 ok
  iReservation := mAllGuests.FieldByName('Reservation').AsInteger;

  oldCountry :=   d.getCountryFromReservation(ireservation);

  countryHolder.Country := oldCountry;
  GET_countryHolderByCountry(countryHolder);
  oldCountryName := countryHolder.CountryName;

  S := oldCountry;
  if Countries(actLookup, countryHolder) then
  begin
	  S := format(GetTranslatedText('shTx_NationalReport_ChangeNationalityFromTo'),
              [oldCountryName, countryHolder.CountryName]);

    if MessageDlg(S, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      newCountry := countryHolder.Country ;
      if not d.ChangeCountry(newCountry, iReservation, 0, 0, 2) then
      begin
        showmessage(GetTranslatedText('shTx_NationalReport_NoChangeCountry'));
      end;
    end else
    begin
      getGuests;
      getAllGuests;
      if mAllGuests.Locate('Reservation',iReservation,[]) then
      begin
      end;
    end;
  end;
end;


end.


