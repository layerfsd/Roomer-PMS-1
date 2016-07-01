unit uRptGuesta;

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
  , sPanel, cxPropertiesStore, cxMemo, sSpinEdit, cxEditRepositoryItems, dxSkinsDefaultPainters
  ;
type
  TfrmRptNotes = class(TForm)
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
    lvNotes: TcxGridLevel;
    grNotes: TcxGrid;
    tvNotes: TcxGridDBBandedTableView;
    kbmNotes: TkbmMemTable;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    NotesDS: TDataSource;
    FormStore: TcxPropertiesStore;
    chkOneday: TsCheckBox;
    tvNotesReservation: TcxGridDBBandedColumn;
    tvNotesGeneralNotes: TcxGridDBBandedColumn;
    tvNotesPaymentNotes: TcxGridDBBandedColumn;
    tvNotescustomer: TcxGridDBBandedColumn;
    tvNotesCustomerName: TcxGridDBBandedColumn;
    tvNotesReservationName: TcxGridDBBandedColumn;
    tvNotesChannel: TcxGridDBBandedColumn;
    tvNotesFirstArrival: TcxGridDBBandedColumn;
    tvNotesLastDeparture: TcxGridDBBandedColumn;
    tvNotesRoomCount: TcxGridDBBandedColumn;
    tvNotesGuestCount: TcxGridDBBandedColumn;
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
    tvNotescontactName: TcxGridDBBandedColumn;
    tvNotescontactEmail: TcxGridDBBandedColumn;
    btnReservation: TsButton;
    sButton1: TsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure chkOnedayClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnReservationClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
     zLocationInString : string;
     zIsOneDay : Boolean;
     zDate : TDate;
     zDatefrom : TDate;
     zDateTo : Tdate;

     zReservationCount : integer;

     procedure showdata;
     function GetRVinList : string;
     function queryRvlst(DateFrom,DateTo :  Tdate; Flags : string=''  ;customer : string = '') : tstringList;
     function StatusSQL : string;
     procedure ApplyFilter;

  public
    { Public declarations }
  end;

var
  frmRptNotes: TfrmRptNotes;

  function RptNotes : boolean;

implementation

{$R *.dfm}

uses
    uD
  , uRoomerLanguage
  , uDImages
  , uReservationProfile
  , uMain;

function RptNotes : boolean;
begin
  result := false;
  frmRptNotes := TfrmRptNotes.Create(frmRptNotes);
  try
    frmRptNotes.ShowModal;
    if frmRptNotes.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmRptNotes);
  end;
end;


function TfrmRptNotes.StatusSQL : string;
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



procedure TfrmRptNotes.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRptNotes.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_rptNotes';
  ExportGridToExcel(sFilename, grNotes, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptNotes.btnRefreshClick(Sender: TObject);
begin
  showdata;
end;

procedure TfrmRptNotes.btnReservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := KbmNotes.fieldbyname('Reservation').AsInteger;
  iRoomReservation := 0;

  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **
  end;
  g.openresMemo(iReservation);

end;

procedure TfrmRptNotes.chkOnedayClick(Sender: TObject);
begin
  zIsOneDay := chkOneday.Checked;
  dtDateTo.Visible := not zIsOneDay;
end;


procedure TfrmRptNotes.ApplyFilter;
begin
    tvNotes.DataController.Filter.Options := [fcoCaseInsensitive];
    tvNotes.DataController.Filter.Root.BoolOperatorKind := fboOr;
    tvNotes.DataController.Filter.Root.Clear;
    tvNotes.DataController.Filter.Root.AddItem(tvNotesReservationName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvNotes.DataController.Filter.Root.AddItem(tvNotesGeneralNotes,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvNotes.DataController.Filter.Root.AddItem(tvNotesPaymentNotes,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvNotes.DataController.Filter.Root.AddItem(tvNotescustomer,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvNotes.DataController.Filter.Root.AddItem(tvNotesCustomerName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvNotes.DataController.Filter.Root.AddItem(tvNotesChannel,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvNotes.DataController.Filter.Root.AddItem(tvNotesReservation,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvNotes.DataController.Filter.Root.AddItem(tvNotescontactName,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
    tvNotes.DataController.Filter.Root.AddItem(tvNotescontactEmail,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');

    tvNotes.DataController.Filter.Active := True;
end;


procedure TfrmRptNotes.edFilterChange(Sender: TObject);
begin
    if edFilter.Text = '' then
    begin
      tvNotes.DataController.Filter.Root.Clear;
      tvNotes.DataController.Filter.Active := false;
    end else
    begin
      applyFilter;
    end;
end;

procedure TfrmRptNotes.FormCreate(Sender: TObject);
begin

  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmRptNotes.FormShow(Sender: TObject);
begin
  _restoreForm(frmRptNotes);
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

  showdata;
end;


  function TfrmRptNotes.queryRvlst(DateFrom,DateTo :  Tdate; Flags : string=''  ;customer : string = '') : tstringList;
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
      sql := sql +'    rd.Reservation'#10;
      sql := sql +'  FROM'#10;
      sql := sql +'    roomsdate rd '#10;
      sql := sql +'  WHERE'#10;
      sql := sql +'        (rd.ADate >=  %s ) AND (rd.ADate <=  %s ) AND (rd.ResFlag in '+Flags+')'#10;
      sql := sql +'  ORDER BY rd.Reservation';

      s := format(sql , [_DateToDbDate(DateFrom,true),_DateToDbDate(DateTo,true)]);
//      copyToClipboard(s);
//      DebugMessage(s);

      if hData.rSet_bySQL(rSet,s) then
    	begin
        while not Rset.Eof do
        begin
          ListItem := Rset.fieldbyname('Reservation').asInteger;
          result.Add(inttostr(listItem));
          Rset.Next;
        end;
      end;
    finally
      freeandnil(Rset);
    end;
  end;



function TfrmRptNotes.GetRVinList : string;
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


procedure TfrmRptNotes.sButton1Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := KbmNotes.fieldbyname('Reservation').AsInteger;
  iRoomReservation := 0;
  g.openresMemo(iReservation);
end;

procedure TfrmRptNotes.showdata;
var
  s : string;

  rset1,
  rset2,
  rset3 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;

  rvList : string;

begin

  screen.Cursor := crHourglass;
  try
    ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try
      rvList := GetRVinList;
      s := '';
      s := s+'SELECT '#10;
      s := s+'   rv.Reservation '#10;
      s := s+'  ,rv.information  as GeneralNotes '#10;
      s := s+'  ,rv.PMInfo  as PaymentNotes '#10;
      s := s+'  ,rv.customer '#10;
      s := s+'  ,rv.ContactName '#10;
      s := s+'  ,rv.ContactEmail '#10;
      s := s+'  ,(SELECT customers.surName from customers WHERE customers.customer = rv.customer) as CustomerName '#10;
      s := s+'  ,rv.Name as ReservationName '#10;
      s := s+'  ,(Select channels.name from channels where channels.id = rv.channel) as Channel '#10;
      s := s+'  ,(SELECT Min(roomreservations.rrArrival) from roomreservations WHERE roomreservations.reservation = rv.Reservation) as FirstArrival '#10;
      s := s+'  ,(SELECT Max(roomreservations.rrdeparture) from roomreservations WHERE roomreservations.reservation = rv.Reservation) as LastDeparture '#10;
      s := s+'  ,(SELECT count(roomreservations.id) from roomreservations WHERE roomreservations.reservation = rv.Reservation) as RoomCount '#10;
      s := s+'  ,(SELECT count(persons.id) from persons WHERE persons.reservation = rv.Reservation) as GuestCount '#10;
      s := s+'FROM '#10;
      s := s+'  reservations rv '#10;
      s := s+' WHERE '#10;
      s := s+'  (rv.reservation in '+Rvlist+') '#10;
      s := s+'  and ((rv.information > '+_db('')+') OR (rv.PMInfo > '+_db('')+')) '#10;
      s := s+'ORDER by (SELECT Min(roomreservations.rrArrival) from roomreservations WHERE roomreservations.reservation = rv.Reservation) '#10;

//       copyToClipboard(s);
//       DebugMessage(s);
      ExecutionPlan.AddQuery(s);

      kbmNotes.disableControls;
      try
        ExecutionPlan.Execute(ptQuery);

        rset1 := ExecutionPlan.Results[0];
        if kbmNotes.active then kbmNotes.Close;
        kbmNotes.open;
        kbmNotes.LoadFromDataSet(rset1, []);
        kbmNotes.First;
      finally
        kbmNotes.enableControls;
      end;
    finally
      freeandnil(ExecutionPlan);
    end;
  finally
    screen.Cursor := crDefault;
  end;

end;

end.
