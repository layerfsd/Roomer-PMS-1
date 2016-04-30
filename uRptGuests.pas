unit uRptGuests;

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
  , Vcl.Buttons
  , Vcl.ExtCtrls
  , Vcl.StdCtrls
  , Vcl.Mask

  , Data.DB

  , shellApi
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , kbmMemTable


  , _glob
  , ug
  , hData
  , uUtils
  , uappGlobal

  , cxGridExportLink
  , cxGraphics
  , cxControls
  , dxStatusBar
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , dxSkinsCore
  , dxSkinCaramel
  , dxSkinCoffee
  , dxSkinDarkSide
  , dxSkinTheAsphaltWorld
  , dxSkinsdxStatusBarPainter
  , dxSkinscxPCPainter

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


  , sSpeedButton
  , sEdit
  , sCheckBox
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sGroupBox
  , sButton
  , sLabel
  , sPanel, cxPropertiesStore, cxMemo, sSpinEdit, cxEditRepositoryItems, cxCheckBox, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  cxGridDBTableView, Vcl.ComCtrls, sPageControl, cxCurrencyEdit
  ;
type
  TfrmRptGuests = class(TForm)
    Panel3: TsPanel;
    __labLocationsList: TsLabel;
    labLocations: TsLabel;
    btnRefresh: TsButton;
    Panel5: TsPanel;
    btnExcel: TsButton;
    btnReport: TsButton;
    dxStatusBar1: TdxStatusBar;
    gbxSelectDates: TsGroupBox;
    LMDSimpleLabel1: TsLabel;
    LMDSimpleLabel2: TsLabel;
    dtDate: TsDateEdit;
    dtDateTo: TsDateEdit;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    FormStore: TcxPropertiesStore;
    chkOneday: TsCheckBox;
    gbxUseStatusOfRooms: TsGroupBox;
    chkExcluteWaitingList: TsCheckBox;
    chkExcluteAlotment: TsCheckBox;
    chkExcluteOrder: TsCheckBox;
    chkExcluteNoShow: TsCheckBox;
    chkExcluteDeparted: TsCheckBox;
    chkExcluteBlocked: TsCheckBox;
    chkExcluteGuest: TsCheckBox;
    chkExcluteCANCELED: TsCheckBox;
    labRecordCount: TsLabel;
    btnReservation: TsButton;
    sButton1: TsButton;
    rgrShow: TsRadioGroup;
    chkGroup: TsCheckBox;
    btnExpand: TsButton;
    btnCollapse: TsButton;
    kbmGuests: TkbmMemTable;
    GuestsDS: TDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    grGuests: TcxGrid;
    tvGuests: TcxGridDBBandedTableView;
    tvGuestsBookingId: TcxGridDBBandedColumn;
    tvGuestsArrival: TcxGridDBBandedColumn;
    tvGuestsDeparture: TcxGridDBBandedColumn;
    tvGuestsroom: TcxGridDBBandedColumn;
    tvGuestsroomtype: TcxGridDBBandedColumn;
    tvGuestsStatusText: TcxGridDBBandedColumn;
    tvGuestsGuestName: TcxGridDBBandedColumn;
    tvGuestsReservationName: TcxGridDBBandedColumn;
    tvGuestsCurrency: TcxGridDBBandedColumn;
    tvGuestsAverageRate: TcxGridDBBandedColumn;
    tvGuestsNumDays: TcxGridDBBandedColumn;
    tvGuestsTotalStayRate: TcxGridDBBandedColumn;
    tvGuestsCurrencyRate: TcxGridDBBandedColumn;
    tvGuestsTotalStayRateNative: TcxGridDBBandedColumn;
    tvGuestsisMain: TcxGridDBBandedColumn;
    tvGuestsBreakfast: TcxGridDBBandedColumn;
    tvGuestsemail: TcxGridDBBandedColumn;
    tvGuestsLocationDescription: TcxGridDBBandedColumn;
    tvGuestsfloor: TcxGridDBBandedColumn;
    tvGuestsRoomDescription: TcxGridDBBandedColumn;
    tvGuestsmarketSegmentDescription: TcxGridDBBandedColumn;
    tvGuestscustomer: TcxGridDBBandedColumn;
    tvGuestsPersonalID: TcxGridDBBandedColumn;
    tvGuestsCustomerName: TcxGridDBBandedColumn;
    tvGuestsRoomCount: TcxGridDBBandedColumn;
    tvGuestsAdults: TcxGridDBBandedColumn;
    tvGuestsChildren: TcxGridDBBandedColumn;
    tvGuestsInfants: TcxGridDBBandedColumn;
    tvGuestsRvGuestCount: TcxGridDBBandedColumn;
    tvGuestsRRGuestCount: TcxGridDBBandedColumn;
    tvGuestschannel: TcxGridDBBandedColumn;
    tvGuestsresInfo: TcxGridDBBandedColumn;
    tvGuestsReservation: TcxGridDBBandedColumn;
    tvGuestsRoomReservation: TcxGridDBBandedColumn;
    lvGuests: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure chkOnedayClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnReservationClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure chkGroupClick(Sender: TObject);
    procedure btnCollapseClick(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure rgrShowClick(Sender: TObject);
    procedure tvGuestsTotalStayRateGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure tvGuestsCurrencyRateGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
  private
    { Private declarations }
     zLocationInString : string;
     zIsOneDay : Boolean;
     zDate : TDate;
     zDatefrom : TDate;
     zDateTo : Tdate;

     zReservationCount : integer;

     procedure showdata;
     function GetInList : string;
     function queryRvlst(DateFrom,DateTo :  Tdate; Flags : string=''  ;customer : string = '') : tstringList;
     function StatusSQL : string;
     procedure ApplyFilter;
    function GetInListSql: string;
    function queryRvlstSql(DateFrom,DateTo :  Tdate; Flags : string=''  ;customer : string = '') : String;
    procedure Moment;
    procedure CreateData;

  public
    { Public declarations }
  end;

var
  frmRptGuests: TfrmRptGuests;

  function RptGuests : boolean;

implementation

{$R *.dfm}

uses
    uD
  , uRoomerLanguage
  , uDImages
  , uReservationProfile
  , uMain;

function RptGuests : boolean;
begin
  result := false;
  frmRptGuests := TfrmRptGuests.Create(frmRptGuests);
  try
    frmRptGuests.ShowModal;
    if frmRptGuests.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmRptGuests);
  end;
end;


function TfrmRptGuests.StatusSQL : string;
var
  sFilter : string;
  sRooms   : string;
  i : integer;
begin
  result := '';

  sRooms := '';
  if chkExcluteWaitingList.checked then sRooms       := sRooms+_db('O')+',';
  if chkExcluteOrder.checked then       sRooms       := sRooms+_db('P')+',';
  if chkExcluteGuest.checked then       sRooms       := sRooms+_db('G')+',';
  if chkExcluteDeparted.checked then    sRooms       := sRooms+_db('D')+',';
  if chkExcluteAlotment.checked then    sRooms       := sRooms+_db('A')+',';
  if chkExcluteBlocked.checked then     sRooms       := sRooms+_db('B')+',';
  if chkExcluteNoshow.checked then      sRooms       := sRooms+_db('N')+',';
  if chkExcluteCANCELED.checked then    sRooms       := sRooms+_db('C')+',';


  if length(sRooms) > 0 then
  begin
    delete(sRooms,length(sRooms),1);
    sRooms := '('+sRooms+')';
  end;

  result := sRooms;
end;



procedure TfrmRptGuests.tvGuestsCurrencyRateGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptGuests.tvGuestsTotalStayRateGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(Arecord.Values[tvGuestsCurrency.index]);
end;

procedure TfrmRptGuests.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRptGuests.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_rptGuests';
  ExportGridToExcel(sFilename, grGuests, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptGuests.btnExpandClick(Sender: TObject);
begin
  tvGuests.DataController.Groups.FullExpand;
end;

procedure TfrmRptGuests.btnRefreshClick(Sender: TObject);
begin
  showdata;
end;

procedure TfrmRptGuests.btnReservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := KbmGuests.fieldbyname('Reservation').AsInteger;
  iRoomReservation := 0;

  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **
  end;
  g.openresMemo(iReservation);

end;

procedure TfrmRptGuests.chkGroupClick(Sender: TObject);
begin
   screen.Cursor := crHourglass;
   try
     btnCollapse.visible := chkGroup.Checked;
     btnExpand.visible := chkGroup.Checked;
     tvGuestsresInfo.visible := chkGroup.Checked;
     if chkGroup.Checked then
     begin
       tvGuestsresInfo.GroupIndex := 1;
       tvGuests.DataController.Groups.FullExpand;
     end else
     begin
       tvGuestsresInfo.GroupIndex := -1;
     end;
   finally
     screen.cursor := crdefault;
   end;
end;

procedure TfrmRptGuests.chkOnedayClick(Sender: TObject);
begin
  zIsOneDay := chkOneday.Checked;
  dtDateTo.Visible := not zIsOneDay;
end;


procedure TfrmRptGuests.ApplyFilter;
begin
  tvGuests.DataController.Filter.Options := [fcoCaseInsensitive];
  tvGuests.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvGuests.DataController.Filter.Root.Clear;
  tvGuests.DataController.Filter.Root.AddItem(tvGuestsReservationName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvGuests.DataController.Filter.Root.AddItem(tvGuestsGuestName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvGuests.DataController.Filter.Root.AddItem(tvGuestsEmail,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvGuests.DataController.Filter.Root.AddItem(tvGuestsRoomDescription,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvGuests.DataController.Filter.Root.AddItem(tvGuestsPersonalID,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvGuests.DataController.Filter.Root.AddItem(tvGuestsCustomer,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvGuests.DataController.Filter.Root.AddItem(tvGuestsCustomerName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvGuests.DataController.Filter.Root.AddItem(tvGuestsChannel,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvGuests.DataController.Filter.Active := True;
end;


procedure TfrmRptGuests.edFilterChange(Sender: TObject);
begin
    if edFilter.Text = '' then
    begin
      tvGuests.DataController.Filter.Root.Clear;
      tvGuests.DataController.Filter.Active := false;
    end else
    begin
      applyFilter;
    end;
end;

procedure TfrmRptGuests.FormCreate(Sender: TObject);
begin

  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmRptGuests.CreateData;
begin
    tvGuestsTotalStayRateNative.Caption := tvGuestsTotalStayRateNative.Caption + ' ' + g.qNativeCurrency;
//  kbmGuests.FieldDefs.Clear;
//  kbmGuests.FieldDefs.Add('RoomReservation', ftInteger);
//  kbmGuests.FieldDefs.Add('Reservation', ftInteger);
//  kbmGuests.FieldDefs.Add('ReservationName', ftWideString, 60);
//  kbmGuests.FieldDefs.Add('Arrival', ftDate);
//  kbmGuests.FieldDefs.Add('Departure', ftDate);
//  kbmGuests.FieldDefs.Add('Room', ftWideString, 20);
//  kbmGuests.FieldDefs.Add('RoomType', ftWideString, 20);
//  kbmGuests.FieldDefs.Add('Status', ftString, 5);
//  kbmGuests.FieldDefs.Add('Breakfast', ftBoolean);
//  kbmGuests.FieldDefs.Add('RoomDescription', ftWideString, 60);
//  kbmGuests.FieldDefs.Add('Location', ftWideString, 30);
//  kbmGuests.FieldDefs.Add('Floor', ftInteger);
//  kbmGuests.FieldDefs.Add('Equipments', ftWideString, 80);
//  kbmGuests.FieldDefs.Add('LocationDescription', ftWideString, 60);
//  kbmGuests.FieldDefs.Add('GroupAccount', ftBoolean);
//  kbmGuests.FieldDefs.Add('marketSegment', ftString, 15);
//  kbmGuests.FieldDefs.Add('marketSegmentDescription', ftWideString, 60);
//  kbmGuests.FieldDefs.Add('Email', ftWideString, 200);
//  kbmGuests.FieldDefs.Add('Customer', ftWideString, 30);
//  kbmGuests.FieldDefs.Add('CustomerName', ftWideString, 60);
//  kbmGuests.FieldDefs.Add('PersonalID', ftString, 15);
//  kbmGuests.FieldDefs.Add('Statustext', ftWideString, 50);
//  kbmGuests.FieldDefs.Add('resInfo', ftWideString, 120);
//  kbmGuests.FieldDefs.Add('roomCount', ftInteger);
//  kbmGuests.FieldDefs.Add('RvGuestCount', ftInteger);
//  kbmGuests.FieldDefs.Add('RRGuestCount', ftInteger);
//  kbmGuests.FieldDefs.Add('GuestName', ftWideString, 150);
//  kbmGuests.FieldDefs.Add('isMain', ftBoolean);
//  kbmGuests.FieldDefs.Add('Channel', ftWideString, 50);
//  kbmGuests.FieldDefs.Add('Adults', ftInteger);
//  kbmGuests.FieldDefs.Add('Children', ftInteger);
//  kbmGuests.FieldDefs.Add('Infants', ftInteger);
//  kbmGuests.FieldDefs.Add('AverageRate', ftFloat);
//  kbmGuests.FieldDefs.Add('TotalStayRate', ftFloat);
//  kbmGuests.FieldDefs.Add('Currency', ftWideString, 5);
//  kbmGuests.FieldDefs.Add('CurrencyRate', ftFloat);
end;

procedure TfrmRptGuests.FormShow(Sender: TObject);
begin
  _restoreForm(frmRptGuests);
  zLocationInString := glb.LocationSQLInString(frmmain.FilteredLocations);

  if zLocationInString = '' then
  begin
    __labLocationsList.caption := 'All Locations';
  end else
  begin
    __labLocationsList.caption := zLocationInString;
  end;

  dtDate.date := date;
  dtDateTo.date := date;
  zIsOneDay := chkOneday.Checked;
  dtDateTo.Visible := not zIsOneDay;

  CreateData;
  showdata;
end;

  function TfrmRptGuests.queryRvlstSql(DateFrom,DateTo :  Tdate; Flags : string=''  ;customer : string = '') : String;
  var
    sql      : string;
  begin
    sql := '';
    sql := sql +'  SELECT'#10;
    sql := sql +'    DISTINCT'#10;
    sql := sql +'    rd.RoomReservation'#10;
    sql := sql +'  FROM'#10;
    sql := sql +'    roomsdate rd '#10;
    sql := sql +'  WHERE'#10;
    sql := sql +'        (rd.ADate >=  %s ) AND (rd.ADate <=  %s ) AND (rd.ResFlag in '+Flags+')'#10;
    sql := sql +'  ORDER BY rd.RoomReservation';

    result := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);
  end;


  function TfrmRptGuests.queryRvlst(DateFrom,DateTo :  Tdate; Flags : string=''  ;customer : string = '') : tstringList;
  var
    s        : string;
    Rset     : TRoomerDataSet;
    listItem : integer;
    sql      : string;
  begin
    result := tstringList.Create;

    Rset := CreateNewDataSet;
    try
      sql := '';
      sql := sql +'  SELECT'#10;
      sql := sql +'    DISTINCT'#10;
      sql := sql +'    rd.RoomReservation'#10;
      sql := sql +'  FROM'#10;
      sql := sql +'    roomsdate rd '#10;
      sql := sql +'  WHERE'#10;
      sql := sql +'        (rd.ADate >=  %s ) AND (rd.ADate <=  %s ) AND (rd.ResFlag in '+Flags+')'#10;
      sql := sql +'  ORDER BY rd.RoomReservation';

      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);
//      copyToClipboard(s);
//      DebugMessage(s);

      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          ListItem := Rset.fieldbyname('RoomReservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;



procedure TfrmRptGuests.rgrShowClick(Sender: TObject);
begin
  showdata;
end;

function TfrmRptGuests.GetInListSql : string;
var
  s      : string;
  rvList : TstringList;
  i      : integer;
  dateTo : Tdate;
  inStr : string;
begin
  result := '';
  zDateFrom := dtdate.Date;
  zDateTo := dtDateTo.Date;

  if zIsOneDay then zDateTo := ZdateFrom;


  instr := StatusSQL;
  dateTo := zdateTo; // +1;
  result := queryRvlstSql(zDateFrom, dateTo, instr );
end;

function TfrmRptGuests.GetInList : string;
var
  s      : string;
  rvList : TstringList;
  i      : integer;
  dateTo : Tdate;
  inStr : string;
begin
  result := '';
  zDateFrom := dtdate.Date;
  zDateTo := dtDateTo.Date;

  if zIsOneDay then zDateTo := ZdateFrom;


  instr := StatusSQL;
  dateTo := zdateTo; // +1;
  rvList := queryRvlst(zDateFrom, dateTo, instr );

  try
    s := '';
    for i := 0 to rvList.Count - 1 do
    begin
      if rvList[i] <> '0' then
        s := s+rvList[i]+',';
    end;
    if length(s) > 0 then
    begin
      delete(s,length(s),1);
      s := '('+s+')';
      result := s;
    end;
    zReservationCount := rvList.count;
  finally
    freeandNil(rvList);
  end;
  result := s;

  if result = '' then
    result := '(-1)';
end;


procedure TfrmRptGuests.sButton1Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := KbmGuests.fieldbyname('Reservation').AsInteger;
  iRoomReservation := 0;
  g.openresMemo(iReservation);
end;

procedure TfrmRptGuests.btnCollapseClick(Sender: TObject);
begin
   tvGuests.DataController.Groups.FullCollapse;
end;

procedure TfrmRptGuests.Moment;
begin
  Application.ProcessMessages;
  Sleep(20);
end;

procedure TfrmRptGuests.showdata;
var
  s : string;

  rset1 : TRoomerDataset;

  rrList : string;

begin

  screen.Cursor := crHourglass;
  try
    if kbmGuests.active then kbmGuests.Close;
    kbmGuests.open;

    rSet1 := CreateNewDataSet;
    try
      rrList := GetInListSql;
      s := '';
      s := s+'SELECT '#10;
      s := s+' rr.RoomReservation '#10;
      s := s+'  , rv.Reservation '#10;
      s := s+'  , SUBSTR(rv.InvRefrence, 1, 30) AS BookingId '#10;
      s := s+'  , rv.Name AS ReservationName '#10;
      s := s+'  , rr.rrArrival as Arrival '#10;
      s := s+'  , rr.rrDeparture as Departure '#10;
      s := s+'  , rr.numGuests AS Adults '#10;
      s := s+'  , rr.numChildren AS Children '#10;
      s := s+'  , rr.numInfants AS Infants '#10;
      s := s+'  , rr.AvrageRate AS AverageRate '#10;
      s := s+'  , to_int(DATEDIFF(rr.rrDeparture,rr.rrArrival)) as NumDays '#10;
      s := s+'  , DATEDIFF(rr.rrDeparture,rr.rrArrival) * rr.AvrageRate as TotalStayRate '#10;
      s := s+'  , DATEDIFF(rr.rrDeparture,rr.rrArrival) * rr.AvrageRate * c.AValue as TotalStayRateNative '#10;
      s := s+'  , rr.Currency as Currency '#10;
      s := s+'  , c.AValue AS CurrencyRate '#10;
      s := s+'  , rr.room '#10;
      s := s+'  , rr.roomtype '#10;
      s := s+'  , rr.Status '#10;
      s := s+'  , rr.invBreakfast AS Breakfast '#10;
      s := s+'  , Concat((SELECT Description from rooms where rr.room = rooms.room),'+_Db('  ')+',(SELECT Equipments from rooms where rr.room = rooms.room)) as RoomDescription '#10;
      s := s+'  , (SELECT location from rooms where rr.room = rooms.room) as location '#10;
      s := s+'  , (SELECT Floor from rooms where rr.room = rooms.room) as floor '#10;
      s := s+'  , (SELECT Equipments from rooms where rr.room = rooms.room) as Equipments '#10;
//20 Equipments
      s := s+'  , (SELECT Description from locations where locations.location = (SELECT location from rooms where rr.room = rooms.room)) as LocationDescription '#10;
      s := s+'  , rr.GroupAccount '#10;
      s := s+'  , rv.marketSegment '#10;
      s := s+'  , (SELECT Description from customertypes where customertypes.CustomerType = rv.marketSegment) as marketSegmentDescription '#10;
      s := s+'  , pers.email '#10;
      s := s+'  , cust.customer '#10;
      s := s+'  , cust.surname as CustomerName '#10;
      s := s+'  , cust.PID as PersonalID '#10;
      s := s+'  , (SELECT di.result FROM dictionary di WHERE di.Code = rr.status) AS StatusText '#10;
      s := s+'  ,  concat(rv.reservation,'+_Db('  ')+',rv.name,'+_Db('  ')+',(SELECT count(id) FROM persons pe WHERE pe.reservation = rv.reservation),'+_Db(' Guests in ')+',(SELECT count(id) FROM roomreservations  WHERE roomreservations.reservation = rv.reservation) ,'+_db(' Rooms.')+') as resInfo '#10;
      s := s+'  , (SELECT count(id) FROM roomreservations  WHERE roomreservations.reservation = rv.reservation) As RoomCount '#10;
      s := s+'  , (SELECT count(id) FROM persons pe WHERE pe.reservation = rv.reservation) As RvGuestCount '#10;
      s := s+'  , (SELECT count(id) FROM persons pe WHERE pe.roomreservation = rr.roomreservation) AS RRGuestCount '#10;
      s := s+'  , pers.name as GuestName '#10;
      s := s+'  , pers.mainName as isMain '#10;
      s := s+'  , (Select channels.name from channels where rv.channel = channels.id) as Channel '#10;
      s := s+' FROM '#10;
      s := s+'   persons pers '#10;
      s := s+'   INNER JOIN roomreservations rr on pers.roomreservation = rr.roomreservation '#10;
      s := s+'   inner JOIN  reservations rv ON  rr.reservation = rv.reservation '#10;
      s := s+'   INNER JOIN currencies c on c.Currency = rr.Currency '#10;
      s := s+'   inner JOIN  customers cust ON  cust.customer = rv.customer '#10;
      s := s+' WHERE '#10;
      s := s+ '   (rr.RoomReservation in ('+rrList+') ) '#10;

      if rgrShow.ItemIndex = 1 then
      begin
        s := s+'   and (pers.name <> '+_db('')+') '#10;
        s := s+'   and (pers.name <> '+_db('RoomGuest')+') '#10;
        s := s+'   and (pers.name <> '+_db('MainGuest')+') '#10;
        s := s+'   and (pers.name <> '+_db('Added Guest')+') '#10;
      end;

      if rgrShow.ItemIndex = 2 then
      begin
        s := s+'   and (pers.mainName = 1 ) '#10;
      end;

      s := s+' ORDER BY '#10;
      s := s+'   rv.reservation, rr.room '#10;

//      copyToClipboard(s);
//      DebugMessage(s);

      if hData.rSet_bySQL(rSet1, s, false) then
      begin
        kbmGuests.disableControls;
        try
          if kbmGuests.active then kbmGuests.Close;
          kbmGuests.open;
//          rSet1.First;
//          while not rSet1.Eof do
//          begin
//            kbmGuests.Append;
//            kbmGuests.FieldByName('RoomReservation').AsInteger := rSet1.FieldByName('RoomReservation').AsInteger;
//            kbmGuests.FieldByName('Reservation').AsInteger := rSet1.FieldByName('Reservation').AsInteger;
//            kbmGuests.FieldByName('ReservationName').AsString := rSet1.FieldByName('ReservationName').AsString;
//            kbmGuests.FieldByName('Arrival').AsDateTime := rSet1.FieldByName('Arrival').AsDateTime;
//            kbmGuests.FieldByName('Departure').AsDateTime := rSet1.FieldByName('Departure').AsDateTime;
//            kbmGuests.FieldByName('Room').AsString := rSet1.FieldByName('Room').AsString;
//            kbmGuests.FieldByName('RoomType').AsString := rSet1.FieldByName('RoomType').AsString;
//            kbmGuests.FieldByName('Status').AsString := rSet1.FieldByName('Status').AsString;
//            kbmGuests.FieldByName('Breakfast').AsBoolean := rSet1.FieldByName('Breakfast').AsBoolean;
//            kbmGuests.FieldByName('RoomDescription').AsString := rSet1.FieldByName('RoomDescription').AsString;
//            kbmGuests.FieldByName('Location').AsString := rSet1.FieldByName('Location').AsString;
//            kbmGuests.FieldByName('Floor').AsInteger := rSet1.FieldByName('Floor').AsInteger;
//            kbmGuests.FieldByName('LocationDescription').AsString := rSet1.FieldByName('LocationDescription').AsString;
//            kbmGuests.FieldByName('GroupAccount').AsBoolean := rSet1.FieldByName('GroupAccount').AsBoolean;
//            kbmGuests.FieldByName('marketSegment').AsString := rSet1.FieldByName('marketSegment').AsString;
//            kbmGuests.FieldByName('marketSegmentDescription').AsString := rSet1.FieldByName('marketSegmentDescription').AsString;
//            kbmGuests.FieldByName('Email').AsString := rSet1.FieldByName('Email').AsString;
//            kbmGuests.FieldByName('Customer').AsString := rSet1.FieldByName('Customer').AsString;
//            kbmGuests.FieldByName('CustomerName').AsString := rSet1.FieldByName('CustomerName').AsString;
//            kbmGuests.FieldByName('PersonalID').AsString := rSet1.FieldByName('PersonalID').AsString;
//            kbmGuests.FieldByName('Statustext').AsString := rSet1.FieldByName('Statustext').AsString;
//            kbmGuests.FieldByName('resInfo').AsString := rSet1.FieldByName('resInfo').AsString;
//            kbmGuests.FieldByName('roomCount').AsInteger := rSet1.FieldByName('roomCount').AsInteger;
//            kbmGuests.FieldByName('RvGuestCount').AsInteger := rSet1.FieldByName('RvGuestCount').AsInteger;
//            kbmGuests.FieldByName('RRGuestCount').AsInteger := rSet1.FieldByName('RRGuestCount').AsInteger;
//            kbmGuests.FieldByName('GuestName').AsString := rSet1.FieldByName('GuestName').AsString;
//            kbmGuests.FieldByName('isMain').AsBoolean := rSet1.FieldByName('isMain').AsBoolean;
//            kbmGuests.FieldByName('Channel').AsString := rSet1.FieldByName('Channel').AsString;
//            kbmGuests.FieldByName('Adults').AsInteger := rSet1.FieldByName('Adults').AsInteger;
//            kbmGuests.FieldByName('Children').AsInteger := rSet1.FieldByName('Children').AsInteger;
//            kbmGuests.FieldByName('Infants').AsInteger := rSet1.FieldByName('Infants').AsInteger;
//            kbmGuests.FieldByName('AverageRate').AsFloat := rSet1.FieldByName('AverageRate').AsFloat;
//            kbmGuests.FieldByName('TotalStayRate').AsFloat := rSet1.FieldByName('TotalStayRate').AsFloat;
//            kbmGuests.FieldByName('Currency').AsString := rSet1.FieldByName('Currency').AsString;
//            kbmGuests.FieldByName('CurrencyRate').AsFloat := rSet1.FieldByName('CurrencyRate').AsFloat;
//            kbmGuests.Post;
//
//            rSet1.Next;
//          end;

//          kbmGuests.LoadFromDataSet(rset1, [mtcpoStructure]);

          LoadKbmMemtableFromDataSetQuiet(kbmGuests, rset1, []);
          kbmGuests.First;
        finally
          kbmGuests.enableControls;
        end;
      end;
    finally
      freeandnil(rSet1);
    end;
  finally
    screen.Cursor := crDefault;
  end;

end;



end.
