unit uHouseKeeping;

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
  , Vcl.ComCtrls
  , Vcl.ExtCtrls
  , System.DateUtils
  , Data.DB
  , Vcl.Grids

  , PrjConst
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , cxGridExportLink
  , ug
  , shellapi
  , scripterInit

  , AdvEdit
  , AdvEdBtn
  , PlannerDatePicker
  , _glob
  , uUtils

  , atScript
  , atPascal

  , sPageControl
  , sStatusBar
  , Vcl.Mask
  , sButton
  , sGroupBox
  , sPanel
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sComboBox
  , sLabel

  , ppDB
  , ppDBPipe
  , ppParameter
  , ppBands
  , ppDesignLayer
  , ppReport
  , ppStrtch
  , ppSubRpt
  , ppCtrls
  , ppPrnabl
  , ppClass
  , ppCache
  , ppComm
  , ppRelatv
  , ppProd

  , tmsAdvGridExcel
  , kbmMemTable
  , AdvObj
  , BaseGrid
  , AdvGrid


  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxContainer
  , cxEdit
  , dxSkinsCore
  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters
  , cxStyles
  , dxSkinscxPCPainter
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxNavigator
  , cxDBData
  , cxPropertiesStore
  , cxGridLevel
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxClasses
  , cxGridCustomView
  , cxGrid
  , cxTextEdit
  , cxMaskEdit
  , cxDropDownEdit

  , dxSkinCaramel
  , dxSkinCoffee
  , dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinFoggy, dxSkinLiquidSky, dxSkinWhiteprint,
  AdvUtil

  ;

const WM_LOAD_LIST = WM_USER + 1;

type
  TfrmHouseKeeping = class(TForm)
    LMDSimplePanel1: TsPanel;
    gbxSElectDate: TsGroupBox;
    dtDate: TsDateEdit;
    pageMain: TsPageControl;
    sStatusBar1: TsStatusBar;
    tabActions: TsTabSheet;
    ps: TatPascalScripter;
    DS: TDataSource;
    m_: TkbmMemTable;
    mvar_: TkbmMemTable;
    sButton1: TsButton;
    mvarDS: TDataSource;
    tvVar: TcxGridDBTableView;
    lvVar: TcxGridLevel;
    grVar: TcxGrid;
    tvVarRoom: TcxGridDBColumn;
    tvVarRoomType: TcxGridDBColumn;
    tvVarNumberGuests: TcxGridDBColumn;
    tvVarGuestCount: TcxGridDBColumn;
    tvVarExtraGuest: TcxGridDBColumn;
    tvVarGuestStatus: TcxGridDBColumn;
    tvVarLocation: TcxGridDBColumn;
    tvVarFloor: TcxGridDBColumn;
    tvVarRoomDescription: TcxGridDBColumn;
    tvVarRoomTypeDescription: TcxGridDBColumn;
    tvVarArrival: TcxGridDBColumn;
    tvVarDeparture: TcxGridDBColumn;
    tvVarNotes: TcxGridDBColumn;
    tvVarFirstGuest: TcxGridDBColumn;
    tvVarResName: TcxGridDBColumn;
    tvVarResStatus: TcxGridDBColumn;
    tvVarJobPr: TcxGridDBColumn;
    grVarDBTableView1: TcxGridDBTableView;
    grVarDBTableView1Action: TcxGridDBColumn;
    grVarDBTableView1Description: TcxGridDBColumn;
    grVarDBTableView1Finished: TcxGridDBColumn;
    grVarDBTableView1Note: TcxGridDBColumn;
    sTabSheet1: TsTabSheet;
    grCross: TAdvStringGrid;
    LMDSimplePanel5: TsPanel;
    LMDSpeedButton6: TsButton;
    LMDSpeedButton12: TsButton;
    sPanel1: TsPanel;
    sButton2: TsButton;
    grExcelCross: TAdvGridExcelIO;
    Button1: TsButton;
    rpt: TppReport;
    ppParameterList1: TppParameterList;
    ppMvar: TppDBPipeline;
    ppM: TppDBPipeline;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDBText1: TppDBText;
    ppLabel4: TppLabel;
    rlabDate: TppLabel;
    rLabTimeCreated: TppLabel;
    rlabUser: TppLabel;
    rLabHotelName: TppLabel;
    ppLabel1: TppLabel;
    ppLabel5: TppLabel;
    ppLine1: TppLine;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    rlabLocation: TppLabel;
    rLabGuests: TppLabel;
    rlabNames: TppLabel;
    rlabDates: TppLabel;
    ppLine2: TppLine;
    ppLine4: TppLine;
    rlabJob: TppLabel;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppDetailBand2: TppDetailBand;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppSummaryBand1: TppSummaryBand;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppLabel3: TppLabel;
    ppLabel6: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    rlabdaysfromCheckin: TppLabel;
    rlabDaysUntilCheckout: TppLabel;
    rlabNextCheckin: TppLabel;
    rLabLastCheckout: TppLabel;
    FormStore: TcxPropertiesStore;
    tvVarRoomNotes: TcxGridDBColumn;
    sLabel1: TsLabel;
    labLocations: TsLabel;
    labLocationsList: TsLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LMDSpeedButton6Click(Sender: TObject);
    procedure LMDSpeedButton12Click(Sender: TObject);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }
    MaidActions_: TRoomerDataSet;
    zRoom : string;
    zLocationList : string;


    procedure WndProc(var Message: TMessage); override;
    procedure UpdateAll;
    procedure GetData(insert : boolean);
    procedure CreateCross;
  public
    { Public declarations }
    zDate : Tdate;
  end;

var
  frmHouseKeeping: TfrmHouseKeeping;

implementation

{$R *.dfm}

uses
    uD
  , uSqlDefinitions
  , uRptbViewer
  , uAppGlobal
  , hData
  , uDImages
  , uMain;


procedure TfrmHouseKeeping.FormDestroy(Sender: TObject);
begin
  freeandNil(MaidActions_);
end;

procedure TfrmHouseKeeping.FormShow(Sender: TObject);
begin
  zLocationList := '';
  zLocationList := glb.LocationSQLInString(frmmain.FilteredLocations);

  if zLocationList = '' then
  begin
    labLocationsList.caption := 'All Locations';
  end else
  begin
    labLocationsList.caption := zLocationList;
  end;


  postmessage(handle, WM_LOAD_LIST, 0, 0);
end;

procedure TfrmHouseKeeping.sButton1Click(Sender: TObject);
begin
  UpdateAll;
end;

procedure TfrmHouseKeeping.sButton2Click(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToExcel(sFilename, grVar, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
  //  To export ot xlsx form then use this
  //  ExportGridToXLSX(sFilename, grData, true, true, true);
  //  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil, sw_shownormal);
end;

procedure TfrmHouseKeeping.sButton4Click(Sender: TObject);
begin
  //**
end;

procedure TfrmHouseKeeping.GetData(insert : boolean);
var
  lst : TstringList;
  Room                : string;
  RoomType            : string;
  NumberGuests        : integer;
  GuestCount          : integer;
  ExtraGuest          : integer;
  GuestStatus         : string;
  StayDay             : integer;
  CheckIn             : integer;
  CheckOut            : integer;
  WeekDay             : integer;
  WeekEnd             : boolean;
  Location            : String;
  Floor               : Integer;
  Hidden              : boolean;
  RoomStatus          : string;
  RoomDescription     : string;
  RoomTypeDescription : string;
  Arrival             : Tdate;
  Departure           : Tdate;

  LastCheckOutDate    : Tdate;
  LastCheckOut        : Integer;

  NextCheckInDate     : Tdate;
  NextCheckIn         : integer;

  RoomReservation    : integer;
  Reservation        : integer;


  FirstGuest    : string;
  ResName       : string;


  ok : boolean;

begin
  lst := Tstringlist.Create;
  try
    Room                 :=  mVar_.FieldByName('Room').AsString                   ;
    RoomDescription      :=  mVar_.FieldByName('RoomDescription').AsString        ;
    RoomType             :=  mVar_.FieldByName('RoomType').AsString             ;
    RoomTypeDescription  :=  mVar_.FieldByName('RoomTypeDescription').AsString  ;
    Location             :=  mVar_.FieldByName('Location').AsString             ;
    Floor                :=  mVar_.FieldByName('Floor').AsInteger               ;
    Hidden               :=  mVar_.FieldByName('hidden').AsBoolean            ;
    RoomStatus           :=  mVar_.FieldByName('RoomStatus').AsString           ;
    NumberGuests         :=  mVar_.FieldByName('NumberGuests').AsInteger        ;
    GuestCount           :=  mVar_.FieldByName('GuestCount').AsInteger          ;
    ExtraGuest           :=  mVar_.FieldByName('ExtraGuest').AsInteger          ;
    Arrival              :=  mVar_.FieldByName('Arrival').AsDateTime            ;
    Departure            :=  mVar_.FieldByName('Departure').AsDateTime          ;
    GuestStatus          :=  mVar_.FieldByName('GuestStatus').AsString          ;
    CheckIn              :=  mVar_.FieldByName('CheckIn').AsInteger             ;
    CheckOut             :=  mVar_.FieldByName('CheckOut').AsInteger            ;
    StayDay              :=  mVar_.FieldByName('StayDay').AsInteger             ;
    LastCheckOutDate     :=  mVar_.FieldByName('LastCheckOutDate').AsDateTime   ;
    LastCheckOut         :=  mVar_.FieldByName('LastCheckOut').AsInteger        ;
    NextCheckInDate      :=  mVar_.FieldByName('NextCheckInDate').AsDateTime    ;
    NextCheckIn          :=  mVar_.FieldByName('NextCheckIn').AsInteger         ;
    Reservation          :=  mVar_.FieldByName('Reservation').AsInteger         ;
    RoomReservation      :=  mVar_.FieldByName('RoomReservation').AsInteger     ;
    Weekday              :=  mVar_.FieldByName('WeekDay').AsInteger             ;
    WeekEnd              :=  mVar_.FieldByName('WeekEnd').AsBoolean           ;
    FirstGuest           :=  mVar_.FieldByName('FirstGuest').AsString           ;
    ResName              :=  mVar_.FieldByName('ResName').AsString              ;

    MaidActions_.First;
    While Not MaidActions_.Eof do
    begin
      lst.Clear;
      lst.Add('function isOK : boolean;         ');
      lst.Add('begin                            ');
      lst.Add('  result :=                                              ');
      lst.Add(MaidActions_.fieldbyname('maRule').AsString);
      lst.Add('end;');

//      source.Text := lst.text;

      ps.AddConstant('Room',Room);
      ps.AddConstant('RoomDescription',RoomDescription      );
      ps.AddConstant('RoomType',RoomType             );
      ps.AddConstant('RoomTypeDescription',RoomTypeDescription  );
      ps.AddConstant('Location',Location             );
      ps.AddConstant('Floor',Floor                );
      ps.AddConstant('Hidden',Hidden               );
      ps.AddConstant('RoomStatus',RoomStatus           );
      ps.AddConstant('NumberGuests',NumberGuests         );
      ps.AddConstant('GuestCount',GuestCount           );
      ps.AddConstant('ExtraGuest',ExtraGuest           );
      ps.AddConstant('Arrival',Arrival              );
      ps.AddConstant('Departure',Departure            );
      ps.AddConstant('GuestStatus',GuestStatus          );
      ps.AddConstant('CheckIn',CheckIn              );
      ps.AddConstant('CheckOut',CheckOut             );
      ps.AddConstant('StayDay',StayDay              );
      ps.AddConstant('LastCheckOutDate',LastCheckOutDate     );
      ps.AddConstant('LastCheckOut',LastCheckOut         );
      ps.AddConstant('NextCheckInDate',NextCheckInDate      );
      ps.AddConstant('NextCheckIn',NextCheckIn          );
      ps.AddConstant('Reservation',Reservation          );
      ps.AddConstant('RoomReservation',RoomReservation      );
      ps.AddConstant('Weekday',Weekday              );
      ps.AddConstant('WeekEnd',WeekEnd              );
      ps.AddConstant('FirstGuest',FirstGuest           );
      ps.AddConstant('ResName',ResName              );
      ps.SourceCode.Text := lst.text;
      try
        ok := ps.ExecuteSubroutine('isOK');
      except
        ok := false;
      end;

      if ok then
      begin
        if insert then
        begin
          M_.Insert;
          M_.FieldByName('aDate').AsDateTime := zDate;
          M_.FieldByName('Room').AsString := Room;
          M_.FieldByName('Action').AsString := MaidActions_.fieldbyname('maAction').AsString;
          M_.FieldByName('Description').AsString := MaidActions_.fieldbyname('maDescription').AsString;
//          M_.FieldByName('RoomNotes').AsString := MaidActions_.fieldbyname('RoomNotes').AsString;
          M_.post;
        end;
      end;
      MaidActions_.Next;
    end;
  finally
    freeandnil(lst);
  end;
end;


procedure TfrmHouseKeeping.LMDSpeedButton12Click(Sender: TObject);
var
  sFileName : string;
begin
  sFileName := g.qProgramPath+'MaidsCross.html';
  grCross.SaveToHTML(sFileName,true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename), nil, nil, sw_shownormal);
end;

procedure TfrmHouseKeeping.LMDSpeedButton6Click(Sender: TObject);
var
  sFileName : string;
begin
  sFileName := g.qProgramPath+'MaidsCross.xls';
  grExcelCross.XLSExport(sFileName);
  ShellExecute(Handle, 'OPEN', PChar(sFilename), nil, nil, sw_shownormal);
end;

procedure TfrmHouseKeeping.ppDetailBand1BeforePrint(Sender: TObject);
var
  guests : integer;
  extra  : integer;
  floor  : integer;
  FirstGuest : string;
  ResName    : string;

  Arrival   : TDateTime;
  Departure : TDateTime;

  stayDay : integer;
  totaldays : integer;

  JobPr : string;
  ResStatus : string;

 checkin            : integer   ;
 checkout           : integer   ;
 lastCheckOutDate   : TdateTime ;
 LastCheckOut       : integer   ;
 NextCheckIndate    : TdateTime ;
 NextCheckin        : Integer   ;

begin
  Arrival := now;
  Departure := now;
  stayDay := 0;
  totalDays := 0;
  checkin := 0;
  checkout := 0;
  lastCheckOutDate := now;
  lastCheckOut := 0;
  NextCheckIndate := now;
  NextCheckIn := 0;
  try
    Guests := mvar_.fieldbyname('GuestCount').asInteger;
  Except
    Guests := 0;
  end;

  try
    Extra  := mvar_.fieldbyname('extraGuest').asInteger;
  Except
    Extra  := 0;
  end;

  try
    floor  := mvar_.fieldbyname('floor').asInteger;
  Except
    floor  := 0;
  end;

  try
    FirstGuest :=  mvar_.fieldbyname('FirstGuest').asstring;
  Except
  end;

  try
    ResName :=  mvar_.fieldbyname('Resname').asstring;
  Except
  end;

  try
    Arrival   := mVar_.FieldByName('Arrival').asdateTime;
    Departure := mVar_.FieldByName('Departure').asdateTime;

    stayDay := mvar_.fieldbyname('stayDay').asInteger;
    totaldays := trunc(Departure)-trunc(arrival);
  Except
  end;

  JobPr       :=  mvar_.fieldbyname('jobPr').asstring;
  ResStatus   :=  mvar_.fieldbyname('ResStatus').asstring;

 try
   checkin            := mVar_.fieldbyname('checkin'         ).asinteger   ;
   checkout           := mVar_.fieldbyname('checkout'        ).asinteger   ;
   lastCheckOutDate   := mVar_.fieldbyname('lastCheckOutDate').asdateTime ;
   LastCheckOut       := mVar_.fieldbyname('LastCheckOut'    ).asInteger   ;
   NextCheckIndate    := mVar_.fieldbyname('NextCheckIndate' ).asdateTime ;
   NextCheckin        := mVar_.fieldbyname('NextCheckin'     ).asInteger   ;
 Except
 end;

 rlabLocation.caption := mvar_.fieldbyname('location').asstring +' on floor '+inttostr(floor);
 rlabGuests.caption   := 'Guests : '+inttostr(guests) +' Extra :'+inttostr(extra);
 rlabNames.Caption    := FirstGuest+ ' / '+ResName;
 rlabDates.Caption    := 'Arrival :'+dateToStr(arrival)+'  Departure :'+dateTostr(departure)+'  Day '+inttostr(StayDay)+' of '+inttostr(totaldays);
 rlabJob.Caption      := jobPr+' - '+ResStatus;

 rlabdaysfromCheckin.Caption   := inttostr(checkin);
 rlabDaysUntilCheckout.Caption := inttostr(checkout);
 rlabNextCheckin.caption       := dateTostr(LastCheckOutDate)+' '+inttostr(LastCheckOut)+' days';
 rlabLastCheckOut.caption      := dateTostr(NextCheckIndate)+' '+inttostr(NextCheckin)+' days';;

end;

procedure TfrmHouseKeeping.ppHeaderBand1BeforePrint(Sender: TObject);
var
  s : string;
begin
  dateTimeToString(s,'dd mmm yyyy',dtDate.Date);
  rLabDate.Caption := s;

  s := g.qHotelName;

//  if cbxLocations.ItemIndex > 0 then
//  begin
//    s := s+ ' - '+cbxLocations.Items[cbxLocations.ItemIndex];
//  end;

  rLabHotelName.Caption := s;

  dateTimeToString(s, 'dd mmm yyyy hh:nn', now);

 // s := 'Created : ' + s;
  s := format(GetTranslatedText('shTx_HouseKeeping_Created'), [s]);
  rLabTimeCreated.Caption := s;

 // s := 'User : ' + g.qUser;
   s := format(GetTranslatedText('shTx_HouseKeeping_User'), [g.qUser]);
  if g.qusername <> '' then
    s := s + ' - ' + g.qusername;
  rlabUser.Caption := s;
end;

procedure TfrmHouseKeeping.UpdateAll;
var
  s                   : string;
  rRooms              : TRoomerDataSet;
  rRR                 : TRoomerDataSet;

  Room                : string;
  aDate               : Tdate;
  RoomType            : string;
  NumberGuests        : integer;
  GuestCount          : integer;
  ExtraGuest          : integer;
  GuestStatus         : string;
  StayDay             : integer;
  CheckIn             : integer;
  CheckOut            : integer;
  WeekDay             : integer;
  WeekEnd             : boolean;
  Location            : String;
  Floor               : Integer;
  Hidden              : boolean;
  RoomStatus          : string;
  RoomDescription     : string;
  RoomTypeDescription : string;
  Arrival             : Tdate;
  Departure           : Tdate;

  LastCheckOutDate    : Tdate;
  LastCheckOut        : Integer;

  NextCheckInDate     : Tdate;
  NextCheckIn         : integer;

  RoomReservation    : integer;
  Reservation        : integer;

  NextRoomReservation  : integer;
  LastRoomReservation  : integer;

  FirstGuest    : string;
  ResName       : string;

  ResStatus     : string;
  JobPr         : string;

  lst : TstringList;

  i : integer;
  ss : string;

  ok : boolean;

  selLocation : string;
  roomNotes : string;



begin

  selLocation := '';

  if zLocationList <> ''  then
  begin
    selLocation := '('+zLocationList+')';
  end;



  Arrival     := 1;
  Departure   := 1;
  Reservation := 0;

  if mVar_.active then mVar_.close;
  mVar_.Open;

  if m_.active then m_.close;
  m_.Open;

  m_.DisableControls;
  mVar_.DisableControls;
  screen.Cursor := crHourGlass;
  try
    rRooms := CreateNewDataSet;
    try
      s := '';
      s := s+' SELECT  '#10;
      s := s+'    rooms.Room  '#10;
      s := s+'  , rooms.RoomType  '#10;
      s := s+'  , rooms.Location  '#10;
      s := s+'  , rooms.Status AS RoomStatus '#10;
      s := s+'  , rooms.hidden  '#10;
      s := s+'  , rooms.Floor  '#10;
      s := s+'  , roomtypes.NumberGuests  '#10;
      s := s+'  , rooms.Description AS RoomDescription  '#10;
      s := s+'  , roomtypes.Description AS RoomTypeDescription  '#10;
      s := s+' FROM  '#10;
      s := s+'   rooms  '#10;
      s := s+'     LEFT OUTER JOIN  '#10;
      s := s+'       roomtypes ON rooms.RoomType = roomtypes.RoomType  '#10;

      if sellocation <> '' then
      begin
        s := s+' WHERE  '#10;
        s := s+'    (roomtypes.location in '+sellocation+') OR (rooms.location in '+sellocation+') '#10;
      end;
      s := s+' ORDER BY Room desc ' ;

        s := format(s , []);
        hData.rSet_bySQL(rRooms,s);
        rRooms.First;
        While not rRooms.Eof do
        begin
          aDate               := dtDate.Date;
          Room                := rRooms.fieldbyname('Room').asString                ;
          RoomDescription     := rRooms.fieldbyname('RoomDescription').asString     ;
          RoomType            := rRooms.fieldbyname('RoomType').asString            ;
          RoomTypeDescription := rRooms.fieldbyname('RoomTypeDescription').asString ;
          Location            := rRooms.fieldbyname('Location').asString            ;
          Floor               := rRooms.fieldbyname('Floor').asInteger              ;
          Hidden              := rRooms['hidden']           ;
          RoomStatus          := rRooms.fieldbyname('RoomStatus').asString          ;
          NumberGuests        := rRooms.fieldbyname('NumberGuests').asInteger       ;

          WeekDay             := DayOfTheWeek(aDate);
          WeekEnd             := (WeekDay=6) or (weekday=7);

          RoomReservation      := 0;
          ResStatus            := '';
          JobPR                := '';

          Arrival     := 1;
          Departure   := 1;
          Reservation := 0;
          GuestStatus := 'N';
          GuestCount  := 0;
          ExtraGuest  := 0;
          CheckIn     := -1;
          CheckOut    := -1;
          StayDay     := -1;
          FirstGuest  := '';
          ResName     := '';
          roomNotes    := '';

          if d.isDay_Occupied(aDate, Room, RoomReservation ) then
          begin
            rRR := CreateNewDataSet;
            try
              s := '';
              s := s+'SELECT '#10;
              s := s+'  `roomreservations`.`RoomReservation`, '#10;
              s := s+'  `roomreservations`.`Reservation`, '#10;
              s := s+'  `roomreservations`.`Room`, '#10;
              s := s+'  `roomreservations`.`Status` AS `ResStatus`, '#10;
              s := s+'  `roomreservations`.`rrDeparture`, '#10;
              s := s+'  `roomreservations`.`rrArrival`, '#10;
              s := s+'  `roomreservations`.`hiddenInfo`, '#10;
              s := s+'  `rooms`.`Description` AS `RoomDecriprion`, '#10;
              s := s+'  `rooms`.`RoomType`, '#10;
              s := s+'  `rooms`.`Location`, '#10;
              s := s+'  `rooms`.`Status`, '#10;
              s := s+'  `rooms`.`hidden`, '#10;
              s := s+'  `rooms`.`Floor`, '#10;
              s := s+'  `roomtypes`.`Description` AS `RoomTypeDescription`, '#10;
              s := s+'  `roomtypes`.`NumberGuests`, '#10;
              s := s+'    `reservations`.`Name` AS ReservationName, '#10;
              s := s+'   (SELECT count(ID) FROM persons WHERE persons.roomreservation=roomreservations.roomreservation) AS GuestCount, '#10;
              s := s+'   (SELECT persons.Name FROM persons WHERE RoomReservation = %d LIMIT 1) AS FirstGuestName '#10;
              s := s+'FROM '#10;
              s := s+'  `roomreservations` '#10;
              s := s+'  INNER JOIN `rooms` ON (`roomreservations`.`Room` = `rooms`.`Room`) '#10;
              s := s+'  INNER JOIN `roomtypes` ON (`rooms`.`RoomType` = `roomtypes`.`RoomType`) '#10;
              s := s+'  INNER JOIN `reservations` ON (`roomreservations`.`Reservation` = `reservations`.`Reservation`) '#10;
              s := s+'WHERE '#10;
              s := s+'  `roomreservations`.`RoomReservation` = %d '#10;

              s := format(s , [RoomReservation,RoomReservation]);
              if hData.rSet_bySQL(rRR,s) then
              begin
                Arrival     := rRR.fieldbyname('rrArrival').asDateTime;
                Departure   := rRR.fieldbyname('rrDeparture').asDateTime;
                Reservation := rRR.fieldbyname('Reservation').asInteger;
                GuestStatus := rRR.fieldbyname('Status').asString;

                GuestCount  := rRR.fieldbyname('GuestCount').asInteger;
                ExtraGuest  := GuestCount-NumberGuests;
                StayDay     := (Trunc(aDate)-Trunc(Arrival))+1;

                Checkin     := (Trunc(aDate)-Trunc(Arrival));
                CheckOut    := (Trunc(Departure)-Trunc(aDate));

                FirstGuest    := rRR.fieldbyname('FirstGuestName').asString;
                ResName       := rRR.fieldbyname('ReservationName').asString;
                RoomNotes    := rRR.fieldbyname('HiddenInfo').asString;

              end;
            finally
              freeandNil(rRR);
            end;
          end;

          LastRoomReservation := d.LastRoomReservatiaon(Room, Roomreservation, aDate);

          //**zxhj fin in d but not tested
          NextRoomReservation := d.NextRoomReservatiaon(Room, Roomreservation, aDate);

          LastCheckOutDate    := d.RR_GetDepartureDate(LastRoomreservation);
          LastCheckOut        := (Trunc(aDate)-Trunc(LastCheckOutDate));

          NextCheckInDate     := d.GetRoomReservatiaonArrival(NextRoomreservation);
          NextCheckIn         := (Trunc(NextCheckInDate)-Trunc(aDate));


          if (StayDay = 1) and (LastCheckout = 0) then
          begin
			      ResStatus            := GetTranslatedText('shTx_HouseKeeping_GuestLeavesToday');
            JobPR                := '100%';

            if CheckOut = 1 then
              ResStatus := ResStatus+' '+GetTranslatedText('shTx_HouseKeeping_LeavesTomorrow')
            else
              ResStatus := ResStatus+' '+format(GetTranslatedText('shTx_HouseKeeping_StayingForDays'), [CheckOut]);
          end else

          if (StayDay = 1) and (LastCheckout <> 0) then
          begin
            ResStatus            := GetTranslatedText('shTx_HouseKeeping_ArrivesToday');
            JobPR                := 'NB!';

            if CheckOut = 1 then
              ResStatus := ResStatus+' '+GetTranslatedText('shTx_HouseKeeping_LeavesTomorrow')
            else
              ResStatus := ResStatus+' '+format(GetTranslatedText('shTx_HouseKeeping_StayingForDays'), [CheckOut]);
          end else

          if (CheckOut = 0) and (NextCheckin <> 0) then
          begin
            ResStatus            := GetTranslatedText('shTx_HouseKeeping_TodayNoArrival');
            JobPR                := '100%';
          end else
          if (CheckOut = 1) and (NextCheckin <> 0) then
          begin
            ResStatus            := GetTranslatedText('shTx_HouseKeeping_GuestTomorrow');
            JobPR                := '50%';
          end else

          if (GuestStatus = 'N') and (LastCheckOut = 0) then
          begin
            ss := '';
            if NextCheckin < 0 then ss := GetTranslatedText('shTx_HouseKeeping_CheckinNever') else
              if NextCheckin = 1 then ss := GetTranslatedText('shTx_HouseKeeping_NextTomorrow') else
                if NextCheckin > 0 then ss := format(GetTranslatedText('shTx_HouseKeeping_CheckinAfterDays'), [NextCheckin]);

            ResStatus            := GetTranslatedText('shTx_HouseKeeping_TodayNoArrival')+' '+ss;
            JobPR                := '100%';
          end else
          if (GuestStatus = 'N') and (NextCheckin <> 0) then
          begin
            ss := '';
            if NextCheckin < 0 then ss := GetTranslatedText('shTx_HouseKeeping_CheckinNever') else
              if NextCheckin = 1 then ss := GetTranslatedText('shTx_HouseKeeping_NextTomorrow') else
                if NextCheckin > 0 then ss := format(GetTranslatedText('shTx_HouseKeeping_CheckinAfterDays'), [NextCheckin]);

            ResStatus            := GetTranslatedText('shTx_HouseKeeping_RoomUnoccupied')+' '+ss;
            JobPR                := '0%';
          end else
          if (StayDay > 1) and (Checkout > 1) then
          begin
            ss := '';
            ResStatus            := format(GetTranslatedText('shTx_HouseKeeping_OccupiedXDays'), [Checkout]);
            JobPR                := '50%';
            if ((StayDay-1) mod 4) = 0 then JobPr := JobPr + '+' + GetTranslatedText('shTx_HouseKeeping_Beds');
          end;

          if mVar_.Locate('Room',Room,[]) then
          begin
            mVar_.Edit;
          end else
          begin
            mVar_.Insert;
          end;

          mVar_.FieldByName('aDate').AsDateTime             :=  aDate                 ;
          mVar_.FieldByName('Room').AsString                 :=  Room                  ;
          zRoom := Room;
          mVar_.FieldByName('RoomDescription').AsString      :=  RoomDescription       ;
          mVar_.FieldByName('RoomType').AsString             :=  RoomType              ;
          mVar_.FieldByName('RoomTypeDescription').AsString  :=  RoomTypeDescription   ;
          mVar_.FieldByName('Location').AsString             :=  Location              ;
          mVar_.FieldByName('Floor').AsInteger               :=  Floor                 ;
          mVar_.FieldByName('hidden').AsBoolean              :=  Hidden                ;
          mVar_.FieldByName('RoomStatus').AsString           :=  RoomStatus            ;
          mVar_.FieldByName('NumberGuests').AsInteger        :=  NumberGuests          ;

          mVar_.FieldByName('GuestCount').AsInteger          := GuestCount ;
          mVar_.FieldByName('ExtraGuest').AsInteger          := ExtraGuest ;
          mVar_.FieldByName('Arrival').AsDateTime            := Arrival ;
          mVar_.FieldByName('Departure').AsDateTime          := Departure;

          mVar_.FieldByName('GuestStatus').AsString          := GuestStatus ;

          mVar_.FieldByName('CheckIn').AsInteger             := CheckIn;
          mVar_.FieldByName('CheckOut').AsInteger            := CheckOut;

          mVar_.FieldByName('StayDay').AsInteger             := StayDay;
          mVar_.FieldByName('LastCheckOutDate').AsDateTime   := LastCheckOutDate;
          mVar_.FieldByName('LastCheckOut').AsInteger        := LastCheckOut;

          mVar_.FieldByName('NextCheckInDate').AsDateTime    := NextCheckInDate;
          mVar_.FieldByName('NextCheckIn').AsInteger         := NextCheckIn;

          mVar_.FieldByName('Reservation').AsInteger         := Reservation;
          mVar_.FieldByName('RoomReservation').AsInteger     := RoomReservation;

          mVar_.FieldByName('WeekDay').AsInteger             := Weekday;
          mVar_.FieldByName('WeekEnd').AsBoolean             := WeekEnd;

          mVar_.FieldByName('FirstGuest').AsString           := FirstGuest ;
          mVar_.FieldByName('ResName').AsString              := ResName    ;

          mVar_.FieldByName('ResStatus').AsString            := ResStatus;
          mVar_.FieldByName('JobPr').AsString                := JobPr;

          mVar_.FieldByName('NextRoomReservation').AsInteger :=  NextRoomReservation;
          mVar_.FieldByName('LastRoomReservation').AsInteger :=  LastRoomReservation;
          mVar_.FieldByName('LastUpdate').AsDateTime         :=  now;
          mVar_.FieldByName('RoomNotes').AsString         :=  RoomNotes;

      //      m_.FieldByName('Notes').AsString                 :=  Notes;
          mVar_.Post;

          GetData(true);
          rRooms.next;
        end;
        mVar_.First;
      finally
        freeandnil(rRooms);
      end;
  finally
    mVar_.EnableControls;
    m_.EnableControls;
    screen.Cursor := crDefault;
  end;
  CreateCross;
end;


procedure TfrmHouseKeeping.WndProc(var Message: TMessage);
var
  s : string;
begin
  if Message.Msg = WM_LOAD_LIST then
  begin
    dtDate.Date := zDate;
    s := format(select_MaidList_UpdateAll1 , []);
    MaidActions_:= CreateNewDataSet;
    hData.rSet_bySQL(MaidActions_,s);
  end else
  begin
    inherited;
  end;
end;

/////////////////////////////////////////////////////////////////////////////////

procedure TfrmHouseKeeping.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  //**
end;

procedure TfrmHouseKeeping.Button1Click(Sender: TObject);
var
  aReport : TppReport;
begin
  //**
  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
  frmRptbViewer.show;

  screen.Cursor := crHourglass;
  try
    aReport := rpt;
    frmRptbViewer.ppViewer1.Reset;
    frmRptbViewer.ppViewer1.Report := aReport;
    frmRptbViewer.ppViewer1.GotoPage(1);
    aReport.PrintToDevices;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmHouseKeeping.CreateCross;
var
  lstHeader : TstringList;

  procedure GetHeders;
  var
    line : string;
    s : string;
  begin
      lstHeader.Clear;
      MaidActions_.first;
      while not MaidActions_.eof do
      begin
        line := MaidActions_.fieldbyname('maAction').asstring;
        lstHeader.Add(line);
        MaidActions_.Next;
      end;
  end;

  function GetHIndex(sHeader : string) : integer;
  var
    i : integer;
    s : string;
  begin
    result := -1;
    sHeader := _trimlower(sHeader);

    for i := 0 to lstHeader.Count-1 do
    begin
      s := _trimlower(lstHeader[i]);
      if sHeader = s then
      begin
        result := i;
      end;
    end;
  end;

var
  i          : integer;
  room       : string;
  resStatus  : string;
  guestCount : integer;
  index      : integer;
  hIndex     : integer;

  action    : string;

  ic : string;

  sExtra : string;
  Note  : string;
  RoomType : string;
  RoomNotes : string;

begin
  m_.DisableControls;
  mVar_.DisableControls;
  screen.Cursor := crHourGlass;
  try
    lstHeader := TstringList.Create;
    try
      GrCross.ClearNormalCells;
      GrCross.RowCount := 2;
      GrCross.ColCount := 6;

      GetHeders;

      for i := 0 to LstHeader.Count-1 do
      begin
        grCross.Cells[i+4,0] := lstHeader[i];
        grCross.AddColumn;
      end;

      //grCross.cells[grCross.colcount-1,0] := 'Special Requirements';
      //grCross.cells[2,0] := 'Room Status - Date :'+dateTostr(dtDate.date);
	    grCross.cells[grCross.colcount-2,0] := GetTranslatedText('shTx_HouseKeeping_SpecialRequirements');
	    grCross.cells[grCross.colcount-1,0] := 'Room Notes';
      grCross.cells[2,0] := format(GetTranslatedText('shTx_HouseKeeping_RoomStatusDate'), [dateTostr(dtDate.date)]);
      grCross.cells[3,0] := 'Guests';

      mVar_.First;
      index := 1;
      while not mVar_.Eof do
      begin
        room       :=  mVar_.fieldbyname('room').asString;
        resStatus  :=  mVar_.fieldbyname('resStatus').asString;
        roomType   :=  mVar_.fieldbyname('RoomType').asString;
        roomNotes  :=  mVar_.fieldbyname('RoomNotes').asString;
        guestCount :=  mVar_.fieldbyname('GuestCount').asInteger;

        grCross.cells[0,index] := Room;
        grCross.cells[1,index] := RoomType;
        grCross.cells[2,index] := resStatus;
        grCross.cells[3,index] := inttostr(GuestCount);
        grCross.AddRow;

        m_.Filter := '(Room='+_db(room)+')';
        m_.Filtered := true;
        ic := inttostr(m_.recordCount);
        sExtra := '';
        m_.First;
        Note := '';
        while not m_.eof do
        begin
          action := m_.fieldbyname('Action').asstring;

          if trim(m_.fieldbyname('Note').asstring) > '' then
          begin
            note := note+m_.fieldbyname('Note').asstring+' | ';
          end;

          hIndex := GetHIndex(action)+4;

          if Hindex > 1 then
          begin
            grCross.cells[Hindex,index] := 'X';
          end;
          m_.Next;
        end;

        if Note <> '' then
        begin
          sExtra := trim(sExtra);
          grCross.cells[grCross.colcount-2,index] := sExtra;
        end;

        if roomNotes <> '' then
        begin
          roomNotes := trim(roomNotes);
          grCross.cells[grCross.colcount-1,index] := roomNotes;
        end;

        inc(index);
        mVar_.Next;
      end;

      grCross.RemoveRows(grCross.RowCount-1,1);
      grCross.AutoSizeColumns(true,1);
      finally
        freeandNil(lstHeader);
      end;
      m_.Filtered := false;
      mVar_.First;
  finally
    mVar_.EnableControls;
    m_.EnableControls;
    screen.Cursor := crDefault;
  end;
end;

end.
