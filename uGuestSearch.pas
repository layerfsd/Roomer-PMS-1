unit uGuestSearch;

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
  , Vcl.ExtCtrls
  , Vcl.ComCtrls
  , Vcl.StdCtrls

  , Data.DB
  , uUtils


  , shellapi

  ,cmpRoomerDataSet
  ,cmpRoomerConnection


  , sButton
  , sLabel
  , sComboBox
  , sEdit
  , sGroupBox
  , sStatusBar
  , sPanel
  , sSpinEdit

  , AdvEdit
  , AdvEdBtn
  , PlannerDatePicker

  , cxGridExportLink
  , cxDBData
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGrid
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxStyles
  , dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxPropertiesStore, kbmMemTable, sCheckBox, sListBox, sCheckListBox,
  Vcl.Buttons, sSpeedButton, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

  ;

type
  TfrmGuestSearch = class(TForm)
    sPanel1: TsPanel;
    sStatusBar1: TsStatusBar;
    Query: TsGroupBox;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    grData: TcxGrid;
    edText: TsEdit;
    cbxMedhod: TsComboBox;
    sLabel1: TsLabel;
    gbxDates: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    kbmData: TkbmMemTable;
    kbmDataDS: TDataSource;
    tvDataRoomReservation: TcxGridDBColumn;
    tvDataReservation: TcxGridDBColumn;
    tvDataCountry: TcxGridDBColumn;
    tvDataRoom: TcxGridDBColumn;
    tvDataArrival: TcxGridDBColumn;
    tvDataDeparture: TcxGridDBColumn;
    tvDataStatus: TcxGridDBColumn;
    tvDataCustomer: TcxGridDBColumn;
    tvDataReservationName: TcxGridDBColumn;
    tvDataCustomerName: TcxGridDBColumn;
    chkUseDates: TsCheckBox;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    tvDataGuestName: TcxGridDBColumn;
    btnReservation: TsButton;
    LMDSpeedButton1: TsButton;
    LMDButton1: TsButton;
    sButton1: TsButton;
    btnExecute: TsButton;
    StoreMain: TcxPropertiesStore;
    tvDatareference: TcxGridDBColumn;
    sPanel2: TsPanel;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    sLabel2: TsLabel;
    edLimitTo: TsSpinEdit;
    labRecordCount: TsLabel;
    sGroupBox1: TsGroupBox;
    chkbxFields: TsCheckListBox;
    procedure btnExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtDateFromChange(Sender: TObject);
    procedure chkUseDatesClick(Sender: TObject);
    procedure edLimitToChange(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure btnReservationClick(Sender: TObject);
    procedure LMDSpeedButton1Click(Sender: TObject);
    procedure chkbxFieldsClickCheck(Sender: TObject);
    procedure cbxMedhodChange(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure edFilterClickBtn(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure LMDButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    zLimitFrom : integer;
    zLimitTo   : integer;



    procedure ApplyFilter;
    procedure RunQuery;

  public
    { Public declarations }
     zGoTo : boolean;
     zRoom : string;
     zDateFrom : Tdate;
     zDateTo   : Tdate;


  end;

var
  frmGuestSearch: TfrmGuestSearch;

implementation

{$R *.dfm}

uses
     _Glob
   , hData
   , ud
   , ug
   , uAppGlobal
   , uStringUtils
   , uReservationProfile
   , uGuestProfile2

   , uDImages;

procedure TfrmGuestSearch.btnReservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := Kbmdata.fieldbyname('Reservation').AsInteger;
  iRoomReservation := Kbmdata.fieldbyname('RoomReservation').AsInteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **
  end;
end;

procedure TfrmGuestSearch.cbxMedhodChange(Sender: TObject);
begin
  RunQuery;
end;

procedure TfrmGuestSearch.chkbxFieldsClickCheck(Sender: TObject);
begin
  runquery;
end;

procedure TfrmGuestSearch.chkUseDatesClick(Sender: TObject);
begin
  gbxDates.Visible := chkUseDates.Checked;
  RunQuery;
end;

procedure TfrmGuestSearch.dtDateFromChange(Sender: TObject);
begin
  zDateFrom :=  dtDateFrom.Date;
  zDateTo   := dtDateTo.Date;
end;

procedure TfrmGuestSearch.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataCountry,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataRoom,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataStatus,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataGuestName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataReservationName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataCustomerName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataCustomer,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataCustomer,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

procedure TfrmGuestSearch.edFilterChange(Sender: TObject);
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

procedure TfrmGuestSearch.edFilterClickBtn(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmGuestSearch.edLimitToChange(Sender: TObject);
begin
  zLimitTo := edLimitTo.value;
end;

procedure TfrmGuestSearch.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmGuestSearch.btnExecuteClick(Sender: TObject);
begin
  runQuery;
end;

procedure TfrmGuestSearch.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  dtDateFrom.Date := date;
  dtDateTo.Date := date+1;

  zDateFrom :=  dtDateFrom.Date;
  zDateTo   :=  dtDateTo.Date;

  edLimitTo.Value := 2000;

  zLimitFrom := 0;
  zLimitTo   := edLimitTo.value;

  cbxMedhod.ItemIndex := 0;
  cbxMedhodChange(cbxMedhod);
end;

procedure TfrmGuestSearch.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmGuestSearch.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if key = chr(13) then
    begin
      if activecontrol = edFilter then
      begin
      end else
      begin
        btnExecute.click;
      end;
    end;
end;
procedure TfrmGuestSearch.FormShow(Sender: TObject);
begin
  ActiveControl := edText;
end;

procedure TfrmGuestSearch.LMDButton1Click(Sender: TObject);
begin
  zGoto := true;
  zRoom := Kbmdata.fieldbyname('room').asstring;
  zDateFrom := Kbmdata.fieldbyname('Arrival').asDateTime;
end;

procedure TfrmGuestSearch.LMDSpeedButton1Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  theData : recPersonHolder;
begin
  iReservation := Kbmdata.fieldbyname('Reservation').AsInteger;
  iRoomReservation := Kbmdata.fieldbyname('RoomReservation').AsInteger;

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := '';

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;

procedure TfrmGuestSearch.RunQuery;
var
   s : string;
   rset : TRoomerDataset;

   SearchFor : string;
   Fields    : string;
   i : integer;
   lstFields : TstringLIst;

begin
  edText.Text := trim(edText.text);
  if edText.Text = '' then
    exit;

  lstFields := TstringLIst.Create;
  try
    searchFor :=  edText.Text;

    case cbxMedhod.itemindex of
      0 : searchFor := '%'+searchFor+'%';
      1 : searchFor := searchFor+'%';
      2 : searchFor := '%'+searchFor
    end;


    if (chkbxFields.Checked[0] = false) and
       (chkbxFields.Checked[1] = false) and
       (chkbxFields.Checked[2] = false) then
    begin
      s := s + '  AND (    (`persons`.`Name` LIKE '+quotedStr(SearchFor)+') '#10;
      s := s + '        OR (`reservations`.`Name` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`Address1` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`Address2` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`Address3` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`Address4` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`Country` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`Tel1` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`Tel2` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`Information` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`PMInfo` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`CustomerEmail` LIKE '+quotedStr(SearchFor) + ') '#10;

      s := s + '        OR (`reservations`.`ContactName` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`ContactAddress1` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`ContactAddress2` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`ContactAddress3` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`ContactAddress4` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`ContactCountry` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`ContactPhone` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`ContactPhone2` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`ContactEmail` LIKE '+quotedStr(SearchFor) + ') '#10;

      s := s + '        OR (`customers`.`surName` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`invrefrence` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.`Reservation` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`roomreservations`.`RoomReservation` LIKE '+quotedStr(SearchFor) + ') '#10;
      s := s + '        OR (`reservations`.Customer  = '+quotedStr(edText.text) + ') '#10;
      s := s + '            ) '#10;
    end else
    begin
      if chkbxFields.Checked[0] then
      begin
        lstFields.Add('(`persons`.`Name` LIKE '+quotedStr(SearchFor)+') ');
      end;
      if chkbxFields.Checked[1] then
      begin
        lstFields.Add('(`reservations`.`Name` LIKE '+quotedStr(SearchFor) + ') ');
      end;
      if chkbxFields.Checked[2] then
      begin
        lstFields.Add('(`customers`.`surName` LIKE '+quotedStr(SearchFor) + ') ');
      end;

        if lstFields.Count > 1  then lstFields[1] := ' OR '+lstFields[1];
        if lstFields.Count > 2  then lstFields[2] := ' OR '+lstFields[2];

        s := '  AND ( ';
        for I := 0 to lstFields.Count-1 do s := s+lstFields[i];
        s := s + ' ) '#10;
    end;

    Fields := s;

    s := '';
    s := s+' SELECT '#10;
    s := s+'    `persons`.RoomReservation '#10;
    s := s+' ,  `persons`.Reservation '#10;
    s := s+' ,  `persons`.Country '#10;
    s := s+' ,  `roomreservations`.Room '#10;
    s := s+' ,  `roomreservations`.rrArrival AS Arrival'#10;
    s := s+' ,  `roomreservations`.rrDeparture AS Departure'#10;
    s := s+' ,  `roomreservations`.`Status` '#10;
    s := s+' ,  `reservations`.`invrefrence` AS reference '#10;
    s := s+' ,  `reservations`.Customer '#10;
    s := s+' ,  `persons`.`Name` AS GuestName '#10;
    s := s+' ,  `reservations`.`Name` AS ReservationName '#10;
    s := s+' ,  `customers`.`surName` AS CustomerName '#10;
    s := s+' ,  `customers`.`PID` AS CustomerPID '#10;
    s := s+' FROM '#10;
    s := s+'   persons '#10;
    s := s+'      INNER JOIN `roomreservations` ON `persons`.RoomReservation = `roomreservations`.RoomReservation '#10;
    s := s+'      INNER JOIN `reservations` ON `roomreservations`.Reservation = `reservations`.Reservation '#10;
    s := s+'      INNER JOIN `customers` ON `reservations`.Customer = `customers`.Customer '#10;
    s := s+' WHERE `persons`.RoomReservation > 0 '#10;

    if trim(edText.text) <> '' then
      s := s + fields;

    if chkUseDates.checked  then
       s := s+'  AND ((`roomreservations`.rrArrival >= '+_dateToDbDate(zDateFrom,true)+') AND (`roomreservations`.rrDeparture <= '+_dateToDbDate(zDateTo,true)+')) '#10;

  //  s := s+' ORDER BY `roomreservations`.rrArrival ';


    if zLimitTo <> 0 then
    begin
      s := s+' LIMIT '+_db(zLimitFrom)+', '+_db(zLimitTo)+'; '#10;
    end;

//  uStringUtils.CopyToClipboard(s);
//  showmessage(s);

    rSet := CreateNewDataSet;
    try
      screen.Cursor := crHourGlass;
      kbmData.DisableControls;
      try
        hData.rSet_bySQL(rSet,s);
        if KbmData.Active then KbmData.Close;
        KbmData.open;
        LoadKbmMemtableFromDataSetQuiet(KbmData,rSet,[]);
        KbmData.First;
        labRecordCount.Caption := inttostr(kbmData.recordCount);
      finally
        screen.cursor := crDefault;
        KbmData.EnableControls;
      end;
    finally
      freeandnil(rset);
    end;
  finally
    freeandNil(lstFields);
  end;
end;

procedure TfrmGuestSearch.sButton1Click(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
// uses  cxGridExportLink,   shellapi

  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_SearchGuests';
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

end.
