unit ufDownPayments;

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

  , Vcl.ComCtrls
  , Vcl.StdCtrls
  , Vcl.Mask
  , Vcl.Buttons
  , Vcl.ExtCtrls

  , Data.DB
  , shellapi

  ,hData
  ,_glob
  ,ug
  ,uUtils

  ,cmpRoomerDataSet
  ,cmpRoomerConnection


  , kbmMemTable


  , sEdit
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sButton
  , sComboBox
  , sGroupBox
  , sSpeedButton
  , sLabel
  , sPanel
  , sPageControl

  , dxCore
  , cxGridExportLink
  , cxStyles
  , dxSkinscxPCPainter
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxEdit
  , cxNavigator
  , cxDBData
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGrid
  , dxStatusBar

  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , dxSkinsCore

  , ppClass
  , ppClasUt
  , ppBands
  , ppCtrls
  , ppDB, ppVar
  , ppPrnabl
  , ppCache
  , ppDesignLayer
  , ppParameter
  , ppProd
  , ppReport
  , ppComm
  , ppRelatv
  , ppDBPipe
  , sCheckBox

  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters
  , dxSkinsdxStatusBarPainter

  , cxCurrencyEdit
  , cxPropertiesStore, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue


  ;



type
  TfrmRptDownPayments = class(TForm)
    dxStatusBar1: TdxStatusBar;
    Panel3: TsPanel;
    cLabFilter: TsLabel;
    btnClear: TsSpeedButton;
    cxGroupBox2: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    gbxSelectDates: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    edFilter: TsEdit;
    pageMain: TsPageControl;
    sTabSheet1: TsTabSheet;
    kbmPayments_: TkbmMemTable;
    grPayments: TcxGrid;
    tvPayments: TcxGridDBTableView;
    lvPayments: TcxGridLevel;
    kbmPaymentsDS: TDataSource;
    Panel5: TsPanel;
    btnGuestsExcel: TsButton;
    brnGuestsReservation: TsButton;
    btnGuestsRoom: TsButton;
    tvPaymentsReservation: TcxGridDBColumn;
    tvPaymentsRoomReservation: TcxGridDBColumn;
    tvPaymentsPerson: TcxGridDBColumn;
    tvPaymentsTypeIndex: TcxGridDBColumn;
    tvPaymentsInvoiceNumber: TcxGridDBColumn;
    tvPaymentsPayDate: TcxGridDBColumn;
    tvPaymentsCustomer: TcxGridDBColumn;
    tvPaymentsPayType: TcxGridDBColumn;
    tvPaymentsAmount: TcxGridDBColumn;
    tvPaymentsDescription: TcxGridDBColumn;
    tvPaymentsCurrencyRate: TcxGridDBColumn;
    tvPaymentsCurrency: TcxGridDBColumn;
    tvPaymentsconfirmDate: TcxGridDBColumn;
    tvPaymentsNotes: TcxGridDBColumn;
    tvPaymentsdtCreated: TcxGridDBColumn;
    rgrInvoiced: TsRadioGroup;
    tvPaymentsarrival: TcxGridDBColumn;
    tvPaymentsdeparture: TcxGridDBColumn;
    tvPaymentsReservationName: TcxGridDBColumn;
    tvPaymentschannelName: TcxGridDBColumn;
    tvPaymentsroom: TcxGridDBColumn;
    tvPaymentsRefrence: TcxGridDBColumn;
    tvPaymentsCustomerName: TcxGridDBColumn;
    sButton2: TsButton;
    btnEdit: TsButton;
    tvPaymentsID: TcxGridDBColumn;
    rgrConfirmed: TsRadioGroup;
    FormStore: TcxPropertiesStore;
    ppDBPipeline1: TppDBPipeline;
    ppReport2: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppLabel5: TppLabel;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText3: TppDBText;
    ppLabel6: TppLabel;
    pplDates: TppLabel;
    ppc: TppLabel;
    pplFilterProperties: TppLabel;
    rLabHotelName: TppLabel;
    rlabUser: TppLabel;
    rLabTimeCreated: TppLabel;
    ppLabel8: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLine1: TppLine;
    ppLine2: TppLine;
    sButton3: TsButton;
    kbmReport_: TkbmMemTable;
    ReportDS: TDataSource;
    ppSum: TppDBCalc;
    ppcLabTotal: TppLabel;
    ppSummaryBand1: TppSummaryBand;
    ppLabel7: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLine3: TppLine;
    ppReport1: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppDetailBand2: TppDetailBand;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppLabel21: TppLabel;
    ppFooterBand2: TppFooterBand;
    ppLabel22: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppSummaryBand2: TppSummaryBand;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLabel23: TppLabel;
    ppDBCalc1: TppDBCalc;
    ppLine6: TppLine;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppParameterList2: TppParameterList;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppDBCalc2: TppDBCalc;
    sCheckBox1: TsCheckBox;
    sButton1: TsButton;
    procedure btnRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure dtDateFromChange(Sender: TObject);
    procedure cbxMonthCloseUp(Sender: TObject);
    procedure btnGuestsExcelClick(Sender: TObject);
    procedure brnGuestsReservationClick(Sender: TObject);
    procedure btnGuestsRoomClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure kbmPayments_AfterScroll(DataSet: TDataSet);
    procedure rgrInvoicedClick(Sender: TObject);
    procedure tvPaymentsAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure ppReport2InitializeParameters(Sender: TObject; var aCancel: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zDateFrom : Tdate;
    zDateTo   : Tdate;
    zYear     : integer;
    zMonth    : integer;
    zSetDates : boolean;


//    zLocation : string;

    lstReservations : TstringList;
    lstRoomReservations : TstringList;

    zRoomReservationsList : string;
    isFirstTime : boolean;

    procedure ShowData;
    Procedure fillLocationsChkBox;
    procedure GetData;
    function getSortField: string;

  public
    { Public declarations }
    zRoom : string;
    zArrival : TDateTime;
  end;

function OpenRptDownPayments : boolean;

var
  frmRptDownPayments: TfrmRptDownPayments;

implementation

{$R *.dfm}

uses
  uD
  , uReservationProfile
  , uFinishedInvoices2
  , uInvoice
  , uRptbViewer
  , uStringUtils
  , uAppGlobal
  , uCountries
  , uSqlDefinitions
  , uGuestProfile2
  , PrjConst
  , uAssignPayment

  , uDImages;


procedure AddGroupToReport(aBreakName: String; aDataPipeline: TppDataPipeline;   aReport: TppCustomReport);
var
  lGroup: TppGroup;
  lGroupBand: TppGroupBand;

begin
  {add group to report}
  lGroup := TppGroup(ppComponentCreate(aReport, TppGroup));

  lGroup.Report := aReport;

  lGroup.BreakName    :=  aBreakName;
  lGroup.DataPipeline :=  aDataPipeline;

  {add group header and footer bands }
  lGroupBand := TppGroupBand(ppComponentCreate(aReport, TppGroupHeaderBand));
  lGroupBand.Group := lGroup;

  lGroupBand := TppGroupBand(ppComponentCreate(aReport, TppGroupFooterBand));
  lGroupBand.Group := lGroup;


end; {procedure, AddGroupToReport}


function OpenRptDownPayments : boolean;
begin
  result := false;
  frmRptDownPayments := TfrmRptDownPayments.Create(frmRptDownPayments);
  try
    frmRptDownPayments.ShowModal;
    if frmRptDownPayments.modalresult = mrOk then
    begin
      result := true;
    end
    else
    begin

    end;
  finally
    freeandnil(frmRptDownPayments);
  end;
end;


procedure TfrmRptDownPayments.cbxMonthCloseUp(Sender: TObject);
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

procedure TfrmRptDownPayments.dtDateFromChange(Sender: TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

Procedure TfrmRptDownPayments.fillLocationsChkBox;
var
  s    : string;
  rSet : TRoomerDataSet;
begin
//  rSet := CreateNewDataSet;
//  try
//    s:=
//    'SELECT '#10+
//    '     locations.ID '#10+
//    '    ,locations.Active '#10+
//    '    ,locations.Description '#10+
//    '    ,locations.location '#10+
//    '    ,locations.channelManager '#10+
//    '    ,channelmanagers.Description AS channelManagerName '#10+
//    ' FROM '#10+
//    '    locations '#10+
//    '    LEFT JOIN channelmanagers ON channelmanagers.id=locations.channelManager '#10+
//    ' ORDER BY '#10+
//    '   %s ';
//
//    s := format(s, ['Location']);
//    if rSet_bySQL(rSet,s) then
//    begin
//      rSet.First;
//      while not rSet.eof do
//      begin
//        cbxLocations.Items.Add(rSet.FieldByName('Description').asstring);
//        rSet.next;
//      end;
//    end;
//  finally
//    freeandnil(rSet);
//  end;
end;




procedure TfrmRptDownPayments.ppReport2InitializeParameters(Sender: TObject; var aCancel: Boolean);
begin
//  aReport.Groups[0].

end;

procedure TfrmRptDownPayments.brnGuestsReservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := kbmPayments_.FieldByName('Reservation').AsInteger;
  iRoomReservation := 0;

  if EditReservation(iReservation, iRoomReservation) then
  begin

  end;
end;

procedure TfrmRptDownPayments.btnGuestsExcelClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_DownPayments';
  ExportGridToExcel(sFilename, grPayments, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptDownPayments.btnGuestsRoomClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  theData : recPersonHolder;
begin
  iReservation := kbmPayments_.FieldByName('Reservation').AsInteger;
  iRoomReservation := KbmPayments_.fieldbyname('RoomReservation').AsInteger;

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := '';

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;

procedure TfrmRptDownPayments.btnRefreshClick(Sender: TObject);
begin
  //**
  getData;
end;

procedure TfrmRptDownPayments.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  freeandNil(lstReservations);
  freeandNil(lstRoomReservations);
end;

procedure TfrmRptDownPayments.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);

  PageMain.ActivePageIndex := 0;

  lstReservations := TstringList.Create;
  lstRoomReservations := TstringList.Create;

  lstReservations.Sorted := true;
  lstReservations.Duplicates := dupIgnore;
  lstRoomReservations.Sorted := true;
  lstRoomReservations.Duplicates := dupIgnore;

  isfIrstTime := true;
end;

procedure TfrmRptDownPayments.FormDestroy(Sender: TObject);
begin
  //**
end;

procedure TfrmRptDownPayments.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmRptDownPayments.FormShow(Sender: TObject);
begin
  ShowData;
  getData;
end;

procedure TfrmRptDownPayments.ShowData;
var
  y, m, d : word;
  idx : integer;
  lastDay : integer;
begin
  zSetDates := false;

  decodeDate(now, y, m, d);
  zYear := y;
  zMonth := m;
  cbxMonth.ItemIndex := zMonth;

  cbxYear.ItemIndex := cbxYear.Items.IndexOf(inttostr(zYear));
//  idx := zYear - 2010;
  if (idx < cbxYear.Items.Count - 1) and (idx > 0) then
  begin
    cbxYear.ItemIndex := idx;
  end;

  zDateFrom := encodeDate(y, m, 1);
  lastDay := _DaysPerMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;

//  btnHagstofaReport.Enabled := true;

  //**
//  zLocation := '';
//  fillLocationsChkBox;
//  cbxLocations.ItemIndex := 0;
  zRoomReservationsList := '';
  isFirstTime := false;
end;


procedure TfrmRptDownPayments.tvPaymentsAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptDownPayments.GetData;
var
  s    : string;
  rset1,
  rset2,
  rset3 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;

  startTick : integer;
  stopTick  : integer;
  SQLms     : integer;

  statusIn : string;

  dtTmp : TdateTime;

  rvList : string;

begin
  kbmPayments_.DisableControls;
  try
    ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try

      startTick := GetTickCount;
      s := '';
      s := s+' SELECT '#10;
      s := s+'    pm.Reservation '#10;
      s := s+'   ,pm.RoomReservation '#10;
      s := s+'   ,pm.Person '#10;
      s := s+'   ,pm.TypeIndex '#10;
      s := s+'   ,pm.InvoiceNumber '#10;
      s := s+'   ,date(pm.PayDate) AS payDate '#10;
      s := s+'   ,pm.Customer '#10;
      s := s+'   ,pm.PayType '#10;
      s := s+'   ,pm.Amount '#10;
      s := s+'   ,pm.Description '#10;
      s := s+'   ,pm.CurrencyRate '#10;
      s := s+'   ,pm.Currency '#10;
      s := s+'   ,pm.confirmDate '#10;
      s := s+'   ,pm.Notes '#10;
      s := s+'   ,pm.dtCreated '#10;
      s := s+'   ,pm.id '#10;
      s := s+'   ,rv.name AS ReservationName '#10;
      s := s+'   ,rv.channel '#10;
      s := s+'   ,rv.invRefrence AS Refrence '#10;
      s := s+'   ,if(pm.roomreservation=0,date(rv.Arrival),rr.rrArrival) AS Arrival '#10;
      s := s+'   ,if(pm.roomreservation=0,date(rv.Departure),rr.rrDeparture) AS Departure '#10;
      s := s+'   ,rr.room '#10;
      s := s+'   ,chnl.Name AS ChannelName '#10;
      s := s+'   ,cust.surname AS CustomerName '#10;
      s := s+' FROM '#10;
      s := s+'    payments pm '#10;
      s := s+'     LEFT OUTER JOIN reservations rv ON pm.reservation = rv.reservation '#10;
      s := s+'     LEFT OUTER JOIN roomreservations rr ON pm.roomreservation = rr.roomreservation '#10;
      s := s+'     LEFT OUTER JOIN channels chnl ON rv.channel = chnl.id '#10;
      s := s+'     LEFT OUTER JOIN customers cust ON pm.customer = cust.Customer '#10;
      s := s+' WHERE '#10;
      s := s+'   pm.TypeIndex=1 '#10;
      s := s+  '   AND ((pm.dtCreated >=  %s ) AND (pm.dtCreated <=  %s ))'#10;

      case rgrInvoiced.ItemIndex of
        0 : begin end;
        1 : begin
              s:= s+' AND (pm.invoicenumber > 0) '#10;
            end;
        2 : begin
              s:= s+' AND (pm.invoicenumber = -1) '#10;
             end;
      end;

      case rgrConfirmed.ItemIndex of
        0 : begin end;
        1 : begin
              s:= s+' AND (pm.confirmdate > date('+_db('1900-01-01 00:00')+')) '#10;
            end;
        2 : begin
              s:= s+' AND (pm.confirmdate = date('+_db('1900-01-01 00:00')+')) '#10;
             end;
      end;

      s := s+' ORDER BY '#10;
      s := s+'   pm.dtCreated DESC '#10;

      s := format(s , [_Db(zDateFrom),_Db(zDateTo)]);

//    copyToClipboard(s);
//    DebugMessage('');

      ExecutionPlan.AddQuery(s);

      screen.Cursor := crHourGlass;
      kbmPayments_.DisableControls;
      try
        ExecutionPlan.Execute(ptQuery);

        //////////////////// RoomsDate

        rSet1 := ExecutionPlan.Results[0];

        if kbmPayments_.Active then kbmPayments_.Close;
        kbmPayments_.open;
        LoadKbmMemtableFromDataSetQuiet(kbmPayments_,rSet1,[]);
        kbmPayments_.First;

      finally
        screen.cursor := crDefault;
        kbmPAyments_.EnableControls;
      end;

      stopTick         := GetTickCount;
      SQLms            := stopTick - startTick;
  //    sLabTime.Caption := inttostr(SQLms);
    finally
      ExecutionPlan.Free;
    end;

  finally
    kbmPayments_.enableControls;
  end;
   tvPayments.ApplyBestFit;
end;


procedure TfrmRptDownPayments.kbmPayments_AfterScroll(DataSet: TDataSet);
begin
  btnEdit.Enabled :=  dataset.FieldByName('invoicenumber').asinteger = -1;
end;

procedure TfrmRptDownPayments.ppHeaderBand1BeforePrint(Sender: TObject);
var
  s : string;
begin
  pplDates.Caption :=     'From : '+dateToStr(dtDateFrom.date)+'  To : '+dateToStr(dtDateTo.date);
  pplFilterProperties.caption :=  'Invoiced : '+rgrInvoiced.Items[rgrInvoiced.Itemindex]+'  -  Confirmed : '+rgrConfirmed.Items[rgrConfirmed.Itemindex];


  s := g.qHotelName;

//  if cbxLocations.ItemIndex > 0 then
//  begin
//    s := s+ ' - '+cbxLocations.Items[cbxLocations.ItemIndex];
//  end;

  rLabHotelName.Caption := s;

  dateTimeToString(s, 'c', now);

 // s := 'Created : ' + s;
  s := GetTranslatedText('shTx_NationalReport_Created') + s;
  rLabTimeCreated.Caption := s;

 // s := 'User : ' + g.qUser;
   s := GetTranslatedText('shTx_NationalReport_User') + g.qUser;
  if g.qusername <> '' then
    s := s + ' - ' + g.qusername;
  rlabUser.Caption := s;
end;

procedure TfrmRptDownPayments.rgrInvoicedClick(Sender: TObject);
begin
   getData;
end;

procedure TfrmRptDownPayments.sButton1Click(Sender: TObject);
var
  iRoomReservation : integer;
  iReservation : integer;
begin

  iReservation  := kbmPayments_.fieldbyname('Reservation').AsInteger;
  iRoomReservation := 0;
  if not kbmPayments_.Locate('Reservation',ireservation,[]) then
  begin
    showmessage('No room found');
//    showmessage(GetTranslatedText('shTx_InvoiceList2_NotRoomInvoice'));
    sButton1.ModalResult := mrNone;
    exit;
  end;
  zRoom    := kbmPayments_.fieldbyname('room').Asstring;
  zArrival := kbmPayments_.fieldbyname('Arrival').AsDateTime;
end;

procedure TfrmRptDownPayments.sButton2Click(Sender: TObject);
var
  InvoiceNumber : Integer;
  iRoomReservation : integer;
  iReservation     : integer;

  Arrival   : Tdate;
  Departure : Tdate;

begin
  InvoiceNumber := kbmPayments_.FieldByName('InvoiceNumber').AsInteger;
  if invoicenumber > 0  then
  begin
    ViewInvoice2(InvoiceNumber, false, false, false,false, '');
  end else
  begin
    iRoomReservation := 0;
    iReservation := 0;
    Arrival := Date;
    Departure := Date;
    iReservation := kbmPayments_.FieldByName('Reservation').AsInteger;
    iRoomReservation := kbmPayments_.FieldByName('RoomReservation').AsInteger;
    EditInvoice(iReservation, iRoomReservation, 0, 0, 0, 0, false, true,false);
  end;
end;

function TfrmRptDownPayments.getSortField: string;
var
  i: integer;
  AColumn: TcxGridDBColumn;
  aName: string;
  s: string;
begin
  //
  s := '';
  for i := 0 to tvPayments.ColumnCount - 1 do
  begin
    AColumn := tvPayments.Columns[i];
    aName := AColumn.DataBinding.FieldName;
    s := aName;
    if AColumn.SortOrder = soNone then
    begin
    end
    else if AColumn.SortOrder = soAscending then
    begin
      s := s + ';a';
      result := s;
      exit;
    end
    else if AColumn.SortOrder = soDescending then
    begin
      s := s + ';d';
      result := s;
      exit;
    end;
  end;
end;


procedure TfrmRptDownPayments.sButton3Click(Sender: TObject);
var
  sFilter : string;
  sortField : string;
  isDescending : boolean;
  s : string;
  aReport   : TppReport;


begin
//  rptbGroups.Groups[0].NewPage := chkNewPage.Checked;

  if kbmPayments_.RecordCount = 0 then
    exit;

  sFilter := tvPayments.DataController.Filter.FilterText;
  if kbmReport_.active then
    kbmReport_.Close;
  kbmReport_.LoadFromDataSet(tvPayments.DataController.DataSource.DataSet,[mtcpoStructure]);

  kbmReport_.Filtered := false;

  if sFilter <> '' then
  begin
    kbmReport_.Filter := sFilter;
    kbmReport_.Filtered := true;
    kbmReport_.first;
  end;

  if sCheckBox1.checked then s := 'Paytype;a' else s := getSortField;
  isDescending := false;

  if s <> '' then
  begin
    sortField := _strTokenAT(s, ';', 0);
    isDescending := (_strTokenAT(s, ';', 1) = 'd');
  end;

  kbmReport_.SortFields := sortField;
  if not isDescending then
  begin
    kbmReport_.Sort([]);
  end
  else
  begin
    kbmReport_.Sort([mtcoDescending]);
  end;

  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
  frmRptbViewer.Show;

  Screen.Cursor := crHourglass;
  try
    if sCheckBox1.checked then aReport := ppReport1 else aReport := ppReport2;
    frmRptbViewer.ppViewer1.Reset;
    frmRptbViewer.ppViewer1.Report := aReport;
    frmRptbViewer.ppViewer1.GotoPage(1);
    aReport.PrintToDevices;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmRptDownPayments.btnEditClick(Sender: TObject);
var
  Reservation,RoomReservation,invoicenumber : integer;
  paymentID : integer;
begin
  //***
  paymentID := kbmPayments_.FieldByName('id').AsInteger;
  if OpenAssignPayment(paymentID) then
  begin
    getData;
    kbmPayments_.Locate('id',paymentId,[]);
  end;

end;

end.
