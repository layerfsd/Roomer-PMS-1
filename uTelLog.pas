unit uTelLog;

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
  , ADODB
  , DB
  , dxmdaset
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxContainer
  , cxEdit
  , Menus
  , cxCheckBox
  , StdCtrls
  , cxButtons
  , cxGroupBox
  , ExtCtrls
  , ComCtrls

  , hdata
  , _glob
  , ug

  , cxPCdxBarPopupMenu
  , cxStyles
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxDBData
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGrid
  , cxGridExportLink
  , shellapi
  , cxPC
  , dxStatusBar
  , cxNavigator
  , AdvEdit
  , AdvEdBtn
  , PlannerDatePicker, cxLabel

  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter, dxSkinscxPCPainter, sStatusBar, sButton, sCheckBox, sLabel, sGroupBox, sPanel,
  PlannerCal, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit

  ;

type
  TFrmTelLog = class(TForm)
    TelLogDS : TDataSource;
    mTelLog : TdxMemData;
    Panel1: TsPanel;
    cxGroupBox1: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    cxLabel1: TsLabel;
    labTo: TsLabel;
    chkOneDay: TsCheckBox;
    dxStatusBar1: TsStatusBar;
    mTelLogID : TIntegerField;
    mTelLogLogDateTime : TDateTimeField;
    mTelLogCallId : TIntegerField;
    mTelLogCallStart : TDateTimeField;
    mTelLogConnectedTime : TStringField;
    mTelLogRingTime : TIntegerField;
    mTelLogCaller : TStringField;
    mTelLogDirection : TStringField;
    mTelLogCalledNumber : TStringField;
    mTelLogDialledNumber : TStringField;
    mTelLogAccount : TStringField;
    mTelLogContinuation : TBooleanField;
    mTelLogParty1Device : TStringField;
    mTelLogParty1Name : TStringField;
    mTelLogParty2Device : TStringField;
    mTelLogParty2Name : TStringField;
    mTelLogHoldTime : TIntegerField;
    mTelLogParkTime : TIntegerField;
    mTelLogRoom : TStringField;
    mTelLogReservation : TIntegerField;
    mTelLogRoomReservation : TIntegerField;
    mTelLogPriceRule : TStringField;
    mTelLogPriceGroup : TStringField;
    mTelLogminutePrice : TFloatField;
    mTelLogstartPrice : TFloatField;
    mTelLogchargedTime : TIntegerField;
    mTelLogChargedAmount : TFloatField;
    mTelLogImportRefrence : TStringField;
    mTelLogisInternal: TBooleanField;
    mTelLogAuthCode: TStringField;
    mTelLogUserCharged: TStringField;
    mTelLogCallCharge: TFloatField;
    mTelLogCurrency: TStringField;
    mTelLogAmountAtLastUserChange: TFloatField;
    mTelLogCallUnits: TIntegerField;
    mTelLogUnitsAtLastUserChange: TIntegerField;
    mTelLogCostPerUnit: TIntegerField;
    mTelLogMarkUp: TIntegerField;
    mTelLogExternalTargetingCause: TStringField;
    mTelLogExternalTargeterId: TStringField;
    mTelLogExternalTargetedNumber: TStringField;
    mTelLogRecordSource: TStringField;
    mTelLogConnectedTimeSec: TIntegerField;
    mTelLogAuthValid: TBooleanField;
    mTelLogInvoiceNumber: TIntegerField;
    mTelLogDescription: TStringField;
    btnRrShowReservation: TsButton;
    cxButton4: TsButton;
    cxButton2: TsButton;
    btnExcel: TsButton;
    btnRefresh: TsButton;
    btnExit: TsButton;
    mnuFinishedInv: TPopupMenu;
    mnuThisRoom: TMenuItem;
    mnuThisreservation: TMenuItem;
    OpenthisRoom1: TMenuItem;
    OpenGroupInvoice1: TMenuItem;
    Grid: TcxGrid;
    tvTelLog: TcxGridDBTableView;
    tvTelLogRecId: TcxGridDBColumn;
    tvTelLogID: TcxGridDBColumn;
    tvTelLogCallStart: TcxGridDBColumn;
    tvTelLogConnectedTimeSec: TcxGridDBColumn;
    tvTelLogConnectedTime: TcxGridDBColumn;
    tvTelLogRingTime: TcxGridDBColumn;
    tvTelLogCaller: TcxGridDBColumn;
    tvTelLogDirection: TcxGridDBColumn;
    tvTelLogisInternal: TcxGridDBColumn;
    tvTelLogCalledNumber: TcxGridDBColumn;
    tvTelLogDialledNumber: TcxGridDBColumn;
    tvTelLogAccount: TcxGridDBColumn;
    tvTelLogCallId: TcxGridDBColumn;
    tvTelLogContinuation: TcxGridDBColumn;
    tvTelLogParty1Device: TcxGridDBColumn;
    tvTelLogParty1Name: TcxGridDBColumn;
    tvTelLogParty2Device: TcxGridDBColumn;
    tvTelLogParty2Name: TcxGridDBColumn;
    tvTelLogHoldTime: TcxGridDBColumn;
    tvTelLogParkTime: TcxGridDBColumn;
    tvTelLogAuthValid: TcxGridDBColumn;
    tvTelLogAuthCode: TcxGridDBColumn;
    tvTelLogUserCharged: TcxGridDBColumn;
    tvTelLogCallCharge: TcxGridDBColumn;
    tvTelLogCurrency: TcxGridDBColumn;
    tvTelLogAmountAtLastUserChange: TcxGridDBColumn;
    tvTelLogCallUnits: TcxGridDBColumn;
    tvTelLogUnitsAtLastUserChange: TcxGridDBColumn;
    tvTelLogCostPerUnit: TcxGridDBColumn;
    tvTelLogMarkUp: TcxGridDBColumn;
    tvTelLogExternalTargetingCause: TcxGridDBColumn;
    tvTelLogExternalTargeterId: TcxGridDBColumn;
    tvTelLogExternalTargetedNumber: TcxGridDBColumn;
    tvTelLogRoom: TcxGridDBColumn;
    tvTelLogDescription: TcxGridDBColumn;
    tvTelLogReservation: TcxGridDBColumn;
    tvTelLogRoomReservation: TcxGridDBColumn;
    tvTelLogInvoiceNumber: TcxGridDBColumn;
    tvTelLogPriceRule: TcxGridDBColumn;
    tvTelLogPriceGroup: TcxGridDBColumn;
    tvTelLogminutePrice: TcxGridDBColumn;
    tvTelLogstartPrice: TcxGridDBColumn;
    tvTelLogchargedTime: TcxGridDBColumn;
    tvTelLogChargedAmount: TcxGridDBColumn;
    tvTelLogImportRefrence: TcxGridDBColumn;
    tvTelLogRecordSource: TcxGridDBColumn;
    tvTelLogLogDateTime: TcxGridDBColumn;
    lvTelLog: TcxGridLevel;
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure dtDateFromChange(Sender : TObject);
    procedure dtDateToChange(Sender : TObject);
    procedure chkOneDayPropertiesChange(Sender : TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnRrShowReservationClick(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure mnuThisRoomClick(Sender: TObject);
    procedure mnuThisreservationClick(Sender: TObject);
    procedure OpenthisRoom1Click(Sender: TObject);
    procedure OpenGroupInvoice1Click(Sender: TObject);
  private
    { Private declarations }
    procedure refresh;
    procedure updateControles;
  public
    { Public declarations }
    zDateFrom : Tdate;
    zDateTo : Tdate;
  end;

var
  FrmTelLog : TFrmTelLog;

implementation

uses
   uReservationProfile
  ,uGuestProfile2
  ,uFinishedInvoices2
  ,uInvoice
  , uAppGlobal
  , uD
  , uSqlDefinitions
  , PrjConst
  , uDImages;
{$R *.dfm}

procedure TFrmTelLog.updateControles;
begin
  if chkOneDay.Checked then
  begin
 //   chkOneDay.Caption := 'One Day - select date';
	chkOneDay.Caption := GetTranslatedText('shTx_TelLog_OneDay');
    dtDateTo.Visible := false;
    labTo.Visible := false;
    dtDateTo.Date := dtDateFrom.Date;
  end
  else
  begin
 //   chkOneDay.Caption := 'Period - select dates';
	chkOneDay.Caption := GetTranslatedText('shTx_TelLog_Period');
    dtDateTo.Visible := true;
    labTo.Visible := true;
  end;
end;

procedure TFrmTelLog.chkOneDayPropertiesChange(Sender : TObject);
begin
  updateControles;
end;

procedure TFrmTelLog.cxButton4Click(Sender: TObject);
var
  iReservation     : Integer;
  iRoomReservation : Integer;
  sName            : string;
  theData : recPersonHolder;
begin
  sName := '';
  iReservation := mTelLog.FieldByName('Reservation').AsInteger;
  iRoomReservation := mTelLog.FieldByName('RoomReservation').AsInteger;

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := sName;
  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;

procedure TFrmTelLog.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_GustGuestlist';
  ExportGridToExcel(sFilename, Grid, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TFrmTelLog.btnExitClick(Sender: TObject);
begin
  close;
end;

procedure TFrmTelLog.btnRefreshClick(Sender: TObject);
begin
  Refresh;
end;

procedure TFrmTelLog.btnRrShowReservationClick(Sender: TObject);
var
  iReservation : Integer;
  iRoomReservation : Integer;
begin

  iReservation := mTelLog.FieldByName('Reservation').AsInteger;
  iRoomReservation :=mTelLog.FieldByName('RoomReservation').AsInteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **--
  end;
end;

procedure TFrmTelLog.dtDateFromChange(Sender : TObject);
begin
  if chkOneDay.Checked then
  begin
    dtDateTo.Date := dtDateFrom.Date;
  end;

  zDateFrom := dtDateFrom.Date;
  zDateTo := dtDateTo.Date;
end;

procedure TFrmTelLog.dtDateToChange(Sender : TObject);
begin
  zDateFrom := dtDateFrom.Date;
  zDateTo := dtDateTo.Date;
end;

procedure TFrmTelLog.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  // **
end;

procedure TFrmTelLog.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  // **
end;

procedure TFrmTelLog.FormDestroy(Sender : TObject);
begin
  // **
end;

procedure TFrmTelLog.FormShow(Sender : TObject);
begin
  dtDateFrom.Date := Date - 1;
  dtDateTo.Date := Date - 1;
  updateControles;
end;

procedure TFrmTelLog.mnuThisreservationClick(Sender: TObject);
var
  iReservation : Integer;
  iRoomReservation : Integer;
begin
  iReservation := mTelLog.FieldByName('Reservation').AsInteger;
  iRoomReservation := mTelLog.FieldByName('RoomReservation').AsInteger;
  ShowFinishedInvoices2(itPerReservation, '', iReservation);
end;

procedure TFrmTelLog.mnuThisRoomClick(Sender: TObject);
var
  iReservation : Integer;
  iRoomReservation : Integer;
begin
  iReservation := mTelLog.FieldByName('Reservation').AsInteger;
  iRoomReservation := mTelLog.FieldByName('RoomReservation').AsInteger;
  ShowFinishedInvoices2(itPerRoomRes, '', iRoomReservation);
end;

procedure TFrmTelLog.OpenGroupInvoice1Click(Sender: TObject);
var
  iReservation : Integer;
  iRoomReservation : Integer;
  Arrival : Tdate;
  Departure : Tdate;
begin
  Arrival := Date;
  Departure := Date;
  iReservation := mTelLog.FieldByName('Reservation').AsInteger;
  iRoomReservation := mTelLog.FieldByName('RoomReservation').AsInteger;
  EditInvoice(iReservation, 0, 0, 0, 0, false, true,false);
end;

procedure TFrmTelLog.OpenthisRoom1Click(Sender: TObject);
var
  iReservation : Integer;
  iRoomReservation : Integer;
  Arrival : Tdate;
  Departure : Tdate;
begin
  Arrival := Date;
  Departure := Date;
  iReservation := mTelLog.FieldByName('Reservation').AsInteger;
  iRoomReservation := mTelLog.FieldByName('RoomReservation').AsInteger;
  EditInvoice(iReservation, iRoomReservation, 0, 0, 0, false, true,false);
end;

procedure TFrmTelLog.refresh;
var
  rSet : TRoomerDataSet;
  s : string;
  count : integer;

  ID                     : integer  ;
  LogDateTime	           : TdateTime; //smalldatetime
  CallStart              : TdateTime; //smalldatetime  //
  ConnectedTime	         : string   ; //char(8)  HH:MM:SS
  RingTime               : integer  ; //int
  Caller	               : string   ; //nvarchar(50)
  Direction	             : string   ; //char(1)
  CalledNumber           : string   ; //nvarchar(100)
  DialledNumber	         : string   ; //nvarchar(100)
  Account	               : string   ; //nvarchar(50)
  IsInternal             : boolean  ; //bit
  CallId                 : integer  ; //int
  Continuation           : boolean  ; //bit
  Party1Device           : string   ; //nvarchar(20)
  Party1Name             : string   ; //nvarchar(50)
  Party2Device           : string   ; //nvarchar(20)
  Party2Name             : string   ; //nvarchar(50)
  HoldTime               : integer  ; //int
  ParkTime               : integer  ; //int
  RecordSource           : string   ; //*********        nvarchar(50)
  AuthValid              : boolean  ;
  AuthCode               : string   ; //********* nvarchar(50)
  UserCharged            : string   ; //********* nvarchar(50)
  CallCharge             : double   ;
  Currency               : string   ; //********* nvarchar(10)
  AmountAtLastUserChange : double   ;
  CallUnits              : integer  ;
  UnitsAtLastUserChange  : integer  ;
  CostPerUnit            : integer  ;
  MarkUp                 : integer  ;
  ExternalTargetingCause : string   ; //********* nvarchar(20)
  ExternalTargeterId     : string   ; //********* nvarchar(50)
  ExternalTargetedNumber : string   ; //********* nvarchar(50)
  ConnectedTimeSec       : integer  ;
  Room	                 : string   ;    //nvarchar(15)
  Reservation            : integer  ;   //int
  RoomReservation	       : integer  ;   //int
  InvoiceNumber	         : integer  ;   //int
  PriceRule	             : string   ;    //nvarchar(15)
  PriceGroup             : string   ;    //nvarchar(15)
  minutePrice            : double   ;    //float
  startPrice             : double   ;    //float
  chargedTime	           : integer  ;    //int
  ChargedAmount	         : double   ;    //float
  ImportRefrence         : string   ;    //nvarchar(15)
  Description            : string   ;    //nvarchar(15)


begin

  if zDateTo > zDateTo then
  begin
  	showmessage(GetTranslatedText('shTx_TelLog_WrongDate'));
    exit;
  end;
  screen.Cursor := crHourglass;
  try
    rSet := CreateNewDataSet;
    try
      s := '';
      s := s + ' SELECT '+chr(10);
      s := s + '   TOP (100) PERCENT '+chr(10);
      s := s + '     ID '+chr(10);
      s := s + '   , LogDateTime '+chr(10);
      s := s + '   , CallStart '+chr(10);
      s := s + '   , ConnectedTime '+chr(10);
      s := s + '   , RingTime '+chr(10);
      s := s + '   , Caller '+chr(10);
      s := s + '   , Direction '+chr(10);
      s := s + '   , CalledNumber '+chr(10);
      s := s + '   , DialledNumber '+chr(10);
      s := s + '   , Account '+chr(10);
      s := s + '   , IsInternal '+chr(10);
      s := s + '   , CallId '+chr(10);
      s := s + '   , Continuation '+chr(10);
      s := s + '   , Party1Device '+chr(10);
      s := s + '   , Party1Name '+chr(10);
      s := s + '   , Party2Device '+chr(10);
      s := s + '   , Party2Name '+chr(10);
      s := s + '   , HoldTime '+chr(10);
      s := s + '   , ParkTime '+chr(10);
      s := s + '   , AuthValid '+chr(10);
      s := s + '   , AuthCode '+chr(10);
      s := s + '   , UserCharged '+chr(10);
      s := s + '   , CallCharge '+chr(10);
      s := s + '   , Currency '+chr(10);
      s := s + '   , AmountAtLastUserChange '+chr(10);
      s := s + '   , CallUnits '+chr(10);
      s := s + '   , UnitsAtLastUserChange '+chr(10);
      s := s + '   , CostPerUnit '+chr(10);
      s := s + '   , MarkUp '+chr(10);
      s := s + '   , ExternalTargetingCause '+chr(10);
      s := s + '   , ExternalTargeterId '+chr(10);
      s := s + '   , ExternalTargetedNumber '+chr(10);
      s := s + '   , Room '+chr(10);
      s := s + '   , Reservation '+chr(10);
      s := s + '   , RoomReservation '+chr(10);
      s := s + '   , InvoiceNumber '+chr(10);
      s := s + '   , PriceRule '+chr(10);
      s := s + '   , PriceGroup '+chr(10);
      s := s + '   , minutePrice '+chr(10);
      s := s + '   , startPrice '+chr(10);
      s := s + '   , chargedTime '+chr(10);
      s := s + '   , ChargedAmount '+chr(10);
      s := s + '   , ImportRefrence '+chr(10);
      s := s + '   , RecordSource '+chr(10);
      s := s + '   , ConnectedTimeSec '+chr(10);
      s := s + '   , Description '+chr(10);
      s := s + ' FROM '+chr(10);
      s := s + '   tellog '+chr(10);
      s := s + ' WHERE '+chr(10);
      s := s + '     ((Callstart >=' + _DateToDBDate(zDateFrom, true) + ' ) ';
      s := s + '     AND (Callstart <=' + _DateToDBDate(zDateTo+1, true) + ' )) ';
      s := s + ' ORDER BY '+chr(10);
      s := s + '   CallStart '+chr(10);

      s := format(select_telLog_refresh , [_DateToDBDate(zDateFrom, true),_DateToDBDate(zDateTo+1, true) ]);
      // CopyToClipboard(s);
      // DebugMessage(''#10#10+s);
      hData.rSet_bySQL(rSet,s);

      count := 0;

      mTelLog.close;
      mTelLog.open;

      mTellog.DisableControls;
      screen.Cursor := crHourGlass;
      try
        while not rSet.Eof do
        begin
          ID                    := rSet.fieldbyname('ID').asinteger  ;
          LogDateTime	          := rSet.fieldbyname('LogDateTime').asdateTime ;
          CallStart             := rSet.fieldbyname('CallStart').asdateTime ;
          ConnectedTime	        := rSet.fieldbyname('ConnectedTime').asstring   ;
          RingTime              := rSet.fieldbyname('RingTime').asinteger  ;
          Caller	              := rSet.fieldbyname('Caller').asstring   ;
          Direction	            := rSet.fieldbyname('Direction').asstring   ;
          CalledNumber          := rSet.fieldbyname('CalledNumber').asstring   ;
          DialledNumber	        := rSet.fieldbyname('DialledNumber').asstring   ;
          Account	              := rSet.fieldbyname('Account').asstring   ;
          IsInternal            := rSet.fieldbyname('IsInternal').AsInteger=1;
          CallId                := rSet.fieldbyname('CallId').asinteger  ;
          Continuation          := rSet.fieldbyname('Continuation').AsInteger=1 ;
          Party1Device          := rSet.fieldbyname('Party1Device').asstring   ;
          Party1Name            := rSet.fieldbyname('Party1Name').asstring   ;
          Party2Device          := rSet.fieldbyname('Party2Device').asstring   ;
          Party2Name            := rSet.fieldbyname('Party2Name').asstring   ;
          HoldTime              := rSet.fieldbyname('HoldTime').asinteger  ;
          ParkTime              := rSet.fieldbyname('ParkTime').asinteger  ;
          RecordSource          := rSet.fieldbyname('RecordSource').asstring   ;
          AuthValid             := rSet.fieldbyname('AuthValid').AsInteger=1  ;
          AuthCode              := rSet.fieldbyname('AuthCode').asstring   ;
          UserCharged           := rSet.fieldbyname('UserCharged').asstring   ;
          CallCharge            := LocalFloatValue(rSet.fieldbyname('CallCharge').asString)    ;
          Currency              := rSet.fieldbyname('Currency').asstring   ;
          AmountAtLastUserChange:= LocalFloatValue(rSet.fieldbyname('AmountAtLastUserChange').asString)    ;
          CallUnits             := rSet.fieldbyname('CallUnits').asinteger  ;
          UnitsAtLastUserChange := rSet.fieldbyname('UnitsAtLastUserChange').asinteger  ;
          CostPerUnit           := rSet.fieldbyname('CostPerUnit').asinteger  ;
          MarkUp                := rSet.fieldbyname('MarkUp').asinteger  ;
          ExternalTargetingCause:= rSet.fieldbyname('ExternalTargetingCause').asstring   ;
          ExternalTargeterId    := rSet.fieldbyname('ExternalTargeterId').asstring   ;
          ExternalTargetedNumber:= rSet.fieldbyname('ExternalTargetedNumber').asstring   ;
          ConnectedTimeSec      := rSet.fieldbyname('ConnectedTimeSec').asinteger  ;
          Room	                := rSet.fieldbyname('Room').asstring   ;
          Reservation           := rSet.fieldbyname('Reservation').asinteger  ;
          RoomReservation	      := rSet.fieldbyname('RoomReservation').asinteger  ;
          InvoiceNumber	        := rSet.fieldbyname('InvoiceNumber').asinteger  ;
          PriceRule	            := rSet.fieldbyname('PriceRule').asstring   ;
          PriceGroup            := rSet.fieldbyname('PriceGroup').asstring   ;
          minutePrice           := LocalFloatValue(rSet.fieldbyname('minutePrice').asString)    ;
          startPrice            := LocalFloatValue(rSet.fieldbyname('startPrice').asString)    ;
          chargedTime	          := rSet.fieldbyname('chargedTime').asinteger  ;
          ChargedAmount	        := LocalFloatValue(rSet.fieldbyname('ChargedAmount').asString)    ;
          ImportRefrence        := rSet.fieldbyname('ImportRefrence').asstring   ;
          Description           := rSet.fieldbyname('Description').asstring   ;

          mTelLog.append;
          mTelLog.fieldbyname('ID').asinteger                      := ID                    ;
          mTelLog.fieldbyname('LogDateTime').asdateTime            := LogDateTime	          ;
          mTelLog.fieldbyname('CallStart').asdateTime              := CallStart             ;
          mTelLog.fieldbyname('ConnectedTime').asstring            := ConnectedTime	        ;
          mTelLog.fieldbyname('RingTime').asinteger                := RingTime              ;
          mTelLog.fieldbyname('Caller').asstring                   := Caller	              ;
          mTelLog.fieldbyname('Direction').asstring                := Direction	            ;
          mTelLog.fieldbyname('CalledNumber').asstring             := CalledNumber          ;
          mTelLog.fieldbyname('DialledNumber').asstring            := DialledNumber	        ;
          mTelLog.fieldbyname('Account').asstring                  := Account	              ;
          mTelLog.fieldbyname('IsInternal').asboolean              := IsInternal            ;
          mTelLog.fieldbyname('CallId').asinteger                  := CallId                ;
          mTelLog.fieldbyname('Continuation').asboolean            := Continuation          ;
          mTelLog.fieldbyname('Party1Device').asstring             := Party1Device          ;
          mTelLog.fieldbyname('Party1Name').asstring               := Party1Name            ;
          mTelLog.fieldbyname('Party2Device').asstring             := Party2Device          ;
          mTelLog.fieldbyname('Party2Name').asstring               := Party2Name            ;
          mTelLog.fieldbyname('HoldTime').asinteger                := HoldTime              ;
          mTelLog.fieldbyname('ParkTime').asinteger                := ParkTime              ;
          mTelLog.fieldbyname('RecordSource').asstring             := RecordSource          ;
          mTelLog.fieldbyname('AuthValid').asboolean               := AuthValid             ;
          mTelLog.fieldbyname('AuthCode').asstring                 := AuthCode              ;
          mTelLog.fieldbyname('UserCharged').asstring              := UserCharged           ;
          mTelLog.fieldbyname('CallCharge').asFloat                := CallCharge            ;
          mTelLog.fieldbyname('Currency').asstring                 := Currency              ;
          mTelLog.fieldbyname('AmountAtLastUserChange').asFloat    := AmountAtLastUserChange;
          mTelLog.fieldbyname('CallUnits').asinteger               := CallUnits             ;
          mTelLog.fieldbyname('UnitsAtLastUserChange').asinteger   := UnitsAtLastUserChange ;
          mTelLog.fieldbyname('CostPerUnit').asinteger             := CostPerUnit           ;
          mTelLog.fieldbyname('MarkUp').asinteger                  := MarkUp                ;
          mTelLog.fieldbyname('ExternalTargetingCause').asstring   := ExternalTargetingCause;
          mTelLog.fieldbyname('ExternalTargeterId').asstring       := ExternalTargeterId    ;
          mTelLog.fieldbyname('ExternalTargetedNumber').asstring   := ExternalTargetedNumber;
          mTelLog.fieldbyname('ConnectedTimeSec').asinteger        := ConnectedTimeSec      ;
          mTelLog.fieldbyname('Room').asstring                     := Room	                ;
          mTelLog.fieldbyname('Reservation').asinteger             := Reservation           ;
          mTelLog.fieldbyname('RoomReservation').asinteger         := RoomReservation	      ;
          mTelLog.fieldbyname('InvoiceNumber').asinteger           := InvoiceNumber  	      ;
          mTelLog.fieldbyname('PriceRule').asstring                := PriceRule	            ;
          mTelLog.fieldbyname('PriceGroup').asstring               := PriceGroup            ;
          mTelLog.fieldbyname('minutePrice').asFloat               := minutePrice           ;
          mTelLog.fieldbyname('startPrice').asFloat                := startPrice            ;
          mTelLog.fieldbyname('chargedTime').asinteger             := chargedTime	          ;
          mTelLog.fieldbyname('ChargedAmount').asFloat             := ChargedAmount	        ;
          mTelLog.fieldbyname('ImportRefrence').asstring           := ImportRefrence        ;
          mTelLog.fieldbyname('Description').asstring              := Description        ;
          mTelLog.Post;

          rSet.Next
        end;
      finally
        screen.Cursor := crDefault;
        mTellog.EnableControls;
      end;

    finally
      freeandnil(rSet);
    end;
  finally
    screen.Cursor := crDefault;
  end;

end;

end.
