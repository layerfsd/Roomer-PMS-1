unit uOpenInvoicesNew;

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
  Menus,
  StdCtrls,
  DB,
  HData,
  _Glob,
  ADODB,
  Buttons,
  shellapi,

  cxGridExportLink,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxControls,
  cxContainer,
  cxEdit,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxDBData,
  dxmdaset,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  cxPC,
  cxCheckBox,
  cxLabel,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  cxButtons,
  ExtCtrls, cxPCdxBarPopupMenu, ComCtrls, dxCore, cxDateUtils, cxNavigator

  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCurrencyEdit, kbmMemTable, sPageControl, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit,
  sGroupBox, sCheckBox, sButton, sPanel, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue
  ;

type
  TfrmOpenInvoicesNew = class(TForm)
    PanTop: TsPanel;
    cxPageControl1: TsPageControl;
    btnExecute: TsButton;
    InvoiceLinesDS: TDataSource;
    kbmInvoiceLines_: TkbmMemTable;
    kbmRoomsDate_: TkbmMemTable;
    RoomsDateDS: TDataSource;
    sTabSheet2: TsTabSheet;
    sPanel2: TsPanel;
    btnExcelRoomsDate: TsButton;
    btnReservationRoomsDate: TsButton;
    btnRoomRoomsDate: TsButton;
    grRoomsDate: TcxGrid;
    tvRoomsDate: TcxGridDBTableView;
    lvRoomsDate: TcxGridLevel;
    tvRoomsDateroomReservation: TcxGridDBColumn;
    tvRoomsDateReservation: TcxGridDBColumn;
    tvRoomsDateRoom: TcxGridDBColumn;
    tvRoomsDateRoomType: TcxGridDBColumn;
    tvRoomsDateisNoroom: TcxGridDBColumn;
    tvRoomsDateResFlag: TcxGridDBColumn;
    tvRoomsDatecurrency: TcxGridDBColumn;
    tvRoomsDateTotalRate: TcxGridDBColumn;
    tvRoomsDatediscount: TcxGridDBColumn;
    tvRoomsDateisPercentage: TcxGridDBColumn;
    tvRoomsDateArrival: TcxGridDBColumn;
    tvRoomsDateDeparture: TcxGridDBColumn;
    tvRoomsDateisGroupAccount: TcxGridDBColumn;
    tvRoomsDateRoomRentPaymentInvoice: TcxGridDBColumn;
    tvRoomsDatecustomer: TcxGridDBColumn;
    tvRoomsDateGuestName: TcxGridDBColumn;
    tvRoomsDateunPaidRoomRent: TcxGridDBColumn;
    tvRoomsDateDiscountUnPaidRoomRent: TcxGridDBColumn;
    tvRoomsDateTotalUnpaidRoomRent: TcxGridDBColumn;
    tvRoomsDateReservationName: TcxGridDBColumn;
    kbmGroupInvoiceLines_: TkbmMemTable;
    kbmGroupInvoiceLinesDS: TDataSource;
    tvRoomsDateNameOnInvoice: TcxGridDBColumn;
    tvRoomsDateTotalItems: TcxGridDBColumn;
    tvRoomsDateTotal: TcxGridDBColumn;
    tvRoomsDatestatusDescription: TcxGridDBColumn;
    tvRoomsDateCurrencyRate: TcxGridDBColumn;
    sButton7: TsButton;
    sButton8: TsButton;
    sButton9: TsButton;
    chkShowNull: TsCheckBox;
    gbxSelectDates: TsGroupBox;
    dtedFrom: TsDateEdit;
    dtEdTo: TsDateEdit;
    procedure btnExecuteClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure FormDestroy(Sender : TObject);
    procedure dtEdToPropertiesChange(Sender : TObject);
    procedure dtEdFromPropertiesChange(Sender : TObject);
    procedure btnReservationRoomsDateClick(Sender: TObject);
    procedure kbmRoomsDate_BeforePost(DataSet: TDataSet);
    procedure sButton9Click(Sender: TObject);
    procedure sButton7Click(Sender: TObject);
    procedure sButton8Click(Sender: TObject);
    procedure btnRoomRoomsDateClick(Sender: TObject);
    procedure btnExcelRoomsDateClick(Sender: TObject);
    procedure tvRoomsDateTotalRateGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvRoomsDateTotalItemsGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvRoomsDateTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
  private
    { Private declarations }
    zsDateFrom : string;
    zsDateTo : string;

    zRRInList   : string;
    zRVInList   : string;

    zReservationCount : integer;
    zRoomReservationCount : integer;

    NativeCurrency : string;
    zFirstTime : boolean;

    procedure Execute2(aType : integer);

    function GetRVinList : string;
    function GetRRinList : string;

    procedure AddInvoiceData;

  public
    { Public declarations }
    zReservation : integer;
    zRoomreservation : integer;
    zdtFromDate : Tdate;
    zdtToDate : Tdate;
    zbIncludeRoomRent : boolean;
  end;

var
  frmOpenInvoicesNew : TfrmOpenInvoicesNew;

implementation

uses
    uD
  , uReservationProfile
  , uFinishedInvoices2
  , uInvoice
  , uG
  , uAppGlobal
  , uSqlDefinitions
  , uGuestProfile2
  , PrjConst
  , uDImages
  , uRoomerDefinitions
  ;
{$R *.dfm}

procedure TfrmOpenInvoicesNew.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  // **
  zReservation := 0;
  zRoomreservation := 0;
  zdtFromDate := date - 100;
  zdtToDate := date+1;

  dtEdFrom.date := zdtFromDate;
  dtEdTo.date := zdtToDate;

  zbIncludeRoomRent := false;

end;

procedure TfrmOpenInvoicesNew.FormShow(Sender : TObject);
begin
  // **
  NativeCurrency := ctrlGetString('NativeCurrency');
  Execute2(0);
end;


procedure TfrmOpenInvoicesNew.FormDestroy(Sender : TObject);
begin
  // **
end;

procedure TfrmOpenInvoicesNew.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  // **
end;
// ******************************************************************************

procedure TfrmOpenInvoicesNew.btnReservationRoomsDateClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := kbmRoomsDate_.FieldByName('Reservation').AsInteger;
  iRoomReservation := kbmRoomsDate_.FieldByName('RoomReservation').AsInteger;

  if iReservation = 0 then
  begin
	  showmessage(GetTranslatedText('shTx_OpenInvoiceNew_CashInvoice'));
    exit;
  end;
  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **
  end;
end;

procedure TfrmOpenInvoicesNew.btnRoomRoomsDateClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  theData : recPersonHolder;
begin
  iReservation := KbmRoomsDate_.fieldbyname('Reservation').AsInteger;
  iRoomReservation := KbmRoomsDate_.fieldbyname('RoomReservation').AsInteger;

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := '';

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;



procedure TfrmOpenInvoicesNew.btnExcelRoomsDateClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_OpenInvoices';
  ExportGridToExcel(sFilename, grRoomsDate, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmOpenInvoicesNew.btnExecuteClick(Sender: TObject);
begin
  Execute2(0);
end;

procedure TfrmOpenInvoicesNew.dtEdFromPropertiesChange(Sender : TObject);
begin
  zdtFromDate := dtEdFrom.date;
  zsDateFrom := _DateToDBDate(dtEdFrom.date, false);

end;

procedure TfrmOpenInvoicesNew.dtEdToPropertiesChange(Sender : TObject);
begin
  zdtToDate := dtEdTo.date;
  zsDateTo := _DateToDBDate(dtEdTo.date, false);
end;

function TfrmOpenInvoicesNew.GetRRinList : string;
var
  s      : string;
  rrList : TstringList;
  i      : integer;
  dateFrom, DateTo : Tdate;
begin
  dateFrom := dtEdFrom.Date;
  dateTo   := dtEdTo.Date;

  result := '';
  rrList := d.RRlst_FromToUnpaid(DateFrom, DateTo);
  try
    s := '';
    for i := 0 to rrList.Count - 1 do
    begin
      s := s+rrList[i]+',';
    end;
    if length(s) > 0 then
    begin
      delete(s,length(s),1);
      s := '('+s+')';
      result := s;
    end;
    zRoomReservationCount := rrList.count;
  finally
    freeandNil(rrList);
  end;
  result := s;
end;

function TfrmOpenInvoicesNew.GetRVinList : string;
var
  s      : string;
  rvList : TstringList;
  i      : integer;
  dateFrom, DateTo : Tdate;

begin
  dateFrom := dtEdFrom.Date;
  dateTo   := dtEdTo.Date;

  result := '';
  rvList := d.RVlst_FromTo(DateFrom, DateTo);
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
end;


procedure TfrmOpenInvoicesNew.kbmRoomsDate_BeforePost(DataSet: TDataSet);

var
  nativeCurrency : string;
  rate : double;
  currency : string;

  nativerate : double;
  currencyRate : double;
  TotalItems   : double;

begin
  if not zFirsttime then exit;

  nativeCurrency := ctrlGetString('NativeCurrency');
  currency := dataset.FieldByName('currency').asstring;
  TotalItems := Dataset.FieldByName('TotalItems').AsFloat;

  if TotalItems = 0 then
  if currency <> nativeCurrency then
  begin
    rate := GetRate(Currency);
    currencyrate  := dataset.FieldByName('Totalrate').asFloat;
    nativeRate    := currencyRate*rate;
    dataset.FieldByName('Totalrate').AsFloat := nativerate;
    Dataset.FieldByName('Total').AsFloat := nativerate;
  end else
  begin
    Dataset.FieldByName('Total').AsFloat := Dataset.FieldByName('TotalRate').AsFloat+TotalItems;
  end;

end;


procedure TfrmOpenInvoicesNew.sButton7Click(Sender: TObject);
var
  Reservation : integer;
  RoomReservation : integer;
begin
  Reservation := kbmRoomsDate_.FieldByName('Reservation').AsInteger;

  EditInvoice(Reservation, 0, 0, 0, 0, 0, false, true,false);
end;

procedure TfrmOpenInvoicesNew.sButton8Click(Sender: TObject);
var
  Reservation : integer;
  RoomReservation : integer;
  Arrival : Tdate;
  Departure : Tdate;
begin
  Reservation := kbmRoomsDate_.FieldByName('Reservation').AsInteger;
  RoomReservation := kbmRoomsDate_.FieldByName('RoomReservation').AsInteger;
  EditInvoice(Reservation, RoomReservation, 0, 0, 0, 0, false, true,false);
end;

procedure TfrmOpenInvoicesNew.sButton9Click(Sender: TObject);
var
  Reservation : integer;
  RoomReservation : integer;
  s : string;
begin
  s := 'if yes then the selected unpaid invoice '#10;
  s := s+ 'will not show again in this list '#10;

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    RoomReservation := kbmRoomsDate_.FieldByName('RoomReservation').AsInteger;
    d.RR_ExcluteFromOpenInvoices(RoomReservation);
  end;


end;

procedure TfrmOpenInvoicesNew.tvRoomsDateTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmOpenInvoicesNew.tvRoomsDateTotalItemsGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmOpenInvoicesNew.tvRoomsDateTotalRateGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmOpenInvoicesNew.Execute2(aType : integer);
var
  rSet1 : TRoomerDataSet;
  rSet2 : TRoomerDataSet;
  rSet3 : TRoomerDataSet;

  ExecutionPlan : TRoomerExecutionPlan;

  s : string;
  sqlStr : string;

  procedure init;
  begin
  end;

var
  tickCountStart : longint;
  tickCountEnd : longint;
  ms : longInt;

begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    screen.Cursor  := crHourGlass;
    kbmInvoicelines_.DisableControls;
    kbmRoomsdate_.DisableControls;
    try
      zFirstTime := true;

      zRVInList := GetRVinList;
      zRRInList := GetRRinList;

      s := '';
      sqlStr := '';



      if not chkShownull.checked then
      begin
        s := s+' SELECT * FROM ( ';
      end;

      s := s+' SELECT '#10;
      s := s+'   rd.roomReservation '#10;
      s := s+' , rd.Reservation '#10;
      s := s+' , rd.Room '#10;
      s := s+' , rd.RoomType '#10;
      s := s+' , rd.isNoroom '#10;
      s := s+' , rd.ResFlag '#10;
      s := s+' , rd.currency '#10;
      s := s+' , rd.discount '#10;
      s := s+' , rd.isPercentage '#10;
      s := s+' , sum(rd.roomrate) as TotalRate '#10;
      s := s+' , rd.paid '#10;
      s := s+ ', rr.rrArrival as Arrival'#10;
      s := s+ ', rr.rrDeparture as Departure'#10;
      s := s+ ', rr.GroupAccount as isGroupAccount '#10;
      s := s+ ', rr.RoomRentPaymentInvoice '#10;
      s := s+ ', rv.Customer '#10;
      s := s+' , rv.name as ReservationName'#10;
      s := s+' , (SELECT name FROM persons WHERE persons.roomreservation=rd.roomreservation LIMIT 1) AS GuestName '#10;
      s := s+' , (SELECT count(ID) FROM persons WHERE persons.roomreservation=rr.roomreservation) AS GuestCount '#10;
      //**zxhj changed
      s := s+' , (SELECT SUM(RoomRate) FROM roomsdate WHERE (roomsdate.roomreservation=rr.roomreservation) AND (roomsdate.paid=0) and (roomsdate.ResFlag not in('+_db(STATUS_DELETED)+','+_db(STATUS_DELETED)+') ) ) AS unPaidRoomRent '#10;

      s := s+' , (SELECT SUM(IF(isPercentage, RoomRate*Discount/100, Discount)) FROM roomsdate WHERE roomsdate.roomreservation=rr.roomreservation AND roomsdate.paid=0)  AS DiscountUnPaidRoomRent '#10;

      //**zxhj changed
      s := s+' , ((SELECT SUM(RoomRate) FROM roomsdate WHERE (roomsdate.roomreservation=rr.roomreservation) AND (roomsdate.paid=0) AND (roomsdate.ResFlag not in ('+_db(STATUS_DELETED)+','+_db(STATUS_CANCELED)+') )  ) '#10;
      s := s+'      - (SELECT SUM(IF(isPercentage, RoomRate*Discount/100, Discount)) FROM roomsdate WHERE (roomsdate.roomreservation=rr.roomreservation) AND (roomsdate.paid=0) AND (roomsdate.ResFlag <> '+_db(STATUS_DELETED)+' )  )) AS TotalUnpaidRoomRent '#10;
      s := s+', (SELECT curr.AValue from currencies curr  WHERE curr.Currency = rd.Currency) AS CurrencyRate '#10;
      s := s+', (SELECT di.result from dictionary di  WHERE di.code = rd.Resflag) AS statusDescription '#10;
      s := s+' FROM '#10;
      s := s+'   roomsdate rd '#10;
      s := s+' INNER JOIN '#10;
      s := s+'   roomreservations rr ON rd.roomreservation = rr.roomreservation '#10;
      s := s+' INNER JOIN '#10;
      s := s+'   reservations rv ON rd.reservation = rv.reservation '#10;
      s := s+' WHERE '#10;
      s := s+'   (rd.roomreservation in '+zRRinlist+') '#10;  //**zxhj breytti ekki hér því er tekið í rrList
      s := s+'   AND (rr.RoomRentPaymentInvoice > -999 ) '#10;
      s := s+' GROUP BY '#10;
      s := s+'     rd.roomreservation '#10;
      s := s+'   , rd.Room '#10;
      s := s+'   , rd.RoomType '#10;
      s := s+'   , rd.resflag '#10;
      s := s+'   , rd.currency '#10;
      s := s+'   , rd.paid '#10;
      s := s+' ORDER BY roomReservation '#10;

      if not chkShownull.checked then
      begin
        s := s+' ) tmp '#10;
        s := s+'WHERE TotalRate <> 0 '#10;
      end;
      ExecutionPlan.AddQuery(s);

      sqlStr := s;

      s := '';

      if not chkShownull.checked then
      begin
        s := s+' SELECT * FROM ( ';
      end;

      s := s+' SELECT '#10;
      s := s+'   il.Reservation '#10;
      s := s+' , il.RoomReservation '#10;
      s := s+' , rr.rrArrival as Arrival '#10;
      s := s+' , rr.rrDeparture as Departure '#10;
      s := s+' , rr.GroupAccount as isGroupAccount '#10;
      s := s+' , rr.RoomRentPaymentInvoice '#10;
      s := s+' , rr.Status '#10;
      s := s+' , rr.Currency '#10;
      s := s+' , rv.Customer '#10;
      s := s+' , rr.Room '#10;
      s := s+' , rr.RoomType '#10;
      s := s+' , rr.rrIsNoRoom '#10;
      s := s+' , rv.name AS ReservationName '#10;
      s := s+' , sum(il.total) as Amount '#10;
      s := s+' , (SELECT name FROM persons WHERE persons.roomreservation=il.roomreservation LIMIT 1) AS GuestName '#10;
      s := s+' , (SELECT count(ID) FROM persons WHERE persons.roomreservation=il.roomreservation) AS GuestCount '#10;
      s := s+' , (SELECT curr.AValue from currencies curr  WHERE curr.Currency = rr.Currency) AS CurrencyRate '#10;
      s := s+' , (SELECT di.result from dictionary di  WHERE di.code = rr.Status) AS statusDescription '#10;
      s := s+' FROM '#10;
      s := s+'   invoicelines il '#10;
      s := s+' INNER JOIN '#10;
      s := s+'   roomreservations rr ON il.roomreservation = rr.roomreservation '#10;
      s := s+' INNER JOIN '#10;
      s := s+'   reservations rv ON il.reservation = rv.reservation '#10;
      s := s+' WHERE '#10;
      s := s+'   il.reservation in '+zRVinlist+' AND (il.invoicenumber=-1) AND (il.roomreservation <> 0) AND (rr.RoomRentpaymentInvoice > -999) '#10;
      s := s+' GROUP BY '#10;
      s := s+'   il.roomreservation '#10;
      s := s+' ORDER BY roomReservation '#10;

      if not chkShownull.checked then
      begin
        s := s+' ) tmp '#10;
        s := s+'WHERE Amount <> 0 '#10;
      end;

      sqlStr := #10+#10+sqlStr+s;

      ExecutionPlan.AddQuery(s);

      s := '';
      if not chkShownull.checked then
      begin
        s := s+' SELECT * FROM ( ';
      end;

      s := s+' SELECT '#10;
      s := s+'   il.Reservation '#10;
      s := s+' , il.RoomReservation '#10;
      s := s+' , il.itemID '#10;
      s := s+' , Date(rv.Arrival) as dtArrival'#10;
      s := s+' , Date(rv.Departure) as dtDeparture'#10;
      s := s+' , rv.Customer '#10;
      s := s+' , rv.name AS ReservationName'#10;
      s := s+'  ,sum(il.total) as Amount '#10;
      s := s+' FROM '#10;
      s := s+'   invoicelines il '#10;
      s := s+' INNER JOIN '#10;
      s := s+'   reservations rv ON il.reservation = rv.reservation '#10;
      s := s+' WHERE '#10;
      s := s+'   (il.itemID <> '+_db(g.qRoomRentItem)+') AND (il.invoicenumber=-1) AND (roomreservation=0) '#10;
      s := s+' GROUP BY '#10;
      s := s+'   il.reservation '#10;
      s := s+' ORDER BY Reservation '#10;

      if not chkShownull.checked then
      begin
        s := s+' ) tmp '#10;
        s := s+'WHERE Amount <> 0 '#10;
      end;

      sqlStr := #10+#10+sqlStr+s;
      debugmessage(sqlstr);
      copytoclipboard(sqlstr);


      ExecutionPlan.AddQuery(s);

      ExecutionPlan.Execute(ptQuery);

      rSet1 := ExecutionPlan.Results[0];
      rSet2 := ExecutionPlan.Results[1];
      rSet3 := ExecutionPlan.Results[2];

      if kbmRoomsdate_.Active then kbmRoomsDate_.Close;
      kbmRoomsdate_.open;
      LoadKbmMemtableFromDataSetQuiet(kbmRoomsdate_,rSet1,[]);
      kbmRoomsdate_.First;
      kbmRoomsdate_.SortFields := 'Roomreservation';
      kbmRoomsdate_.Sort([]);
      kbmRoomsdate_.first;

      if kbmInvoicelines_.Active then kbmInvoicelines_.Close;
      kbmInvoicelines_.open;
      LoadKbmMemtableFromDataSetQuiet(kbmInvoicelines_,rSet2,[]);
      kbmInvoicelines_.SortFields := 'Roomreservation';
      kbmInvoicelines_.Sort([]);
      kbmInvoicelines_.First;

      if kbmGroupInvoicelines_.Active then kbmGroupInvoicelines_.Close;
      kbmGroupInvoicelines_.open;
      LoadKbmMemtableFromDataSetQuiet(kbmGroupInvoicelines_,rSet3,[]);
      kbmGroupInvoicelines_.SortFields := 'reservation';
      kbmGroupInvoicelines_.Sort([]);
      kbmGroupInvoicelines_.First;

      zFirstTime := true;
    finally
      kbmInvoicelines_.EnableControls;
      kbmRoomsdate_.EnableControls;
      screen.Cursor := crDefault;
    end;

    AddInvoiceData;
    tvRoomsDate.ApplyBestFit();

  finally
    ExecutionPlan.Free;
  end;
end;


procedure TfrmOpenInvoicesNew.AddInvoiceData;
var
  RoomReservation         : integer;
  Reservation             : Integer ;
  Room                    : String  ;
  RoomType                : String  ;
  isNoroom                : Boolean ;
  ResFlag                 : String  ;
  currency                : String  ;
  discount                : double  ;
  isPercentage            : Boolean ;
  TotalRate               : double    ;
  Arrival                 : TDateTime ;
  Departure               : TDateTime ;
  GroupAccount            : Boolean   ;
  RoomRentPaymentInvoice  : Integer ;
  Customer                : String  ;
  ReservationName         : String  ;
  GuestName               : String  ;
  unPaidRoomRent          : double  ;
  DiscountUnPaidRoomRent  : double  ;
  TotalUnpaidRoomRent     : double  ;
  CurrencyRate            : double  ;
  statusDescription       : String  ;
  TotalItems              : double  ;
  nativeCurrency : string;

begin
  kbmInvoicelines_.DisableControls;
  kbmRoomsDate_.DisableControls;
  screen.Cursor := crHourGlass;
  try

    kbmInvoicelines_.SortFields := 'RoomReservation';
    kbmInvoicelines_.Sort([]);

    kbmInvoicelines_.First;
    while not kbmInvoicelines_.eof do
    begin
      Room                    := kbmInvoicelines_.FieldByName('Room').AsString;
      RoomType                := kbmInvoicelines_.FieldByName('RoomType').AsString;
      isNoroom                := kbmInvoicelines_.FieldByName('isNoroom').AsBoolean;
      ResFlag                 := kbmInvoicelines_.FieldByName('Status').AsString;
      currency                := kbmInvoicelines_.FieldByName('Currency').AsString;
      discount                := 0;
      isPercentage            := false;
      Arrival                 := kbmInvoicelines_.FieldByName('Arrival').AsDateTime;
      Departure               := kbmInvoicelines_.FieldByName('Departure').AsDateTime;
      GroupAccount            := kbmInvoicelines_.FieldByName('isGroupAccount').AsBoolean;
      RoomRentPaymentInvoice  := kbmInvoicelines_.FieldByName('RoomRentPaymentInvoice').AsInteger;
      Customer                := kbmInvoicelines_.FieldByName('Customer').AsString;
      ReservationName         := kbmInvoicelines_.FieldByName('ReservationName').AsString;;
      GuestName               := kbmInvoicelines_.FieldByName('GuestName').AsString;
      unPaidRoomRent          := 0;
      DiscountUnPaidRoomRent  := 0;
      TotalUnpaidRoomRent     := 0;
      TotalRate               := 0;

      RoomReservation   := kbmInvoicelines_.FieldByName('RoomReservation').AsInteger;
      Reservation       := kbmInvoicelines_.FieldByName('Reservation').AsInteger;
      TotalItems        := kbmInvoiceLines_.FieldByName('Amount').asfloat;
      CurrencyRate      := kbmInvoiceLines_.FieldByName('CurrencyRate').asfloat;
      statusDescription := kbmInvoiceLines_.FieldByName('statusDescription').asString;

      if kbmRoomsDate_.Locate('roomReservation',RoomReservation,[]) then
      begin
        kbmRoomsDate_.Edit;
        kbmRoomsDate_.FieldByName('TotalItems').AsFloat := TotalItems;
        kbmRoomsDate_.FieldByName('Total').AsFloat := TotalItems+kbmRoomsDate_.FieldByName('TotalRate').AsFloat;
        kbmRoomsDate_.post;
      end else
      begin
        kbmRoomsDate_.insert;
        kbmRoomsDate_.FieldByName('roomReservation').AsInteger        :=  RoomReservation           ;
        kbmRoomsDate_.FieldByName('Reservation').AsInteger            :=  Reservation               ;
        kbmRoomsDate_.FieldByName('Room').AsString                    :=  Room                      ;
        kbmRoomsDate_.FieldByName('RoomType').AsString                :=  RoomType                  ;
        kbmRoomsDate_.FieldByName('isNoroom').AsBoolean               :=  isNoroom                  ;
        kbmRoomsDate_.FieldByName('ResFlag').AsString                 :=  ResFlag                   ;
        kbmRoomsDate_.FieldByName('currency').AsString                :=  currency                  ;
        kbmRoomsDate_.FieldByName('discount').AsFloat                 :=  discount                  ;
        kbmRoomsDate_.FieldByName('isPercentage').AsBoolean           :=  isPercentage              ;
        kbmRoomsDate_.FieldByName('TotalRate').AsFloat                :=  TotalRate                 ;
        kbmRoomsDate_.FieldByName('Arrival').AsDateTime               :=  Arrival                   ;
        kbmRoomsDate_.FieldByName('Departure').AsDateTime             :=  Departure                 ;
        kbmRoomsDate_.FieldByName('isGroupAccount').AsBoolean         :=  GroupAccount              ;
        kbmRoomsDate_.FieldByName('RoomRentPaymentInvoice').AsInteger :=  RoomRentPaymentInvoice    ;
        kbmRoomsDate_.FieldByName('Customer').AsString                :=  Customer                  ;
        kbmRoomsDate_.FieldByName('ReservationName').AsString         :=  ReservationName           ;
        kbmRoomsDate_.FieldByName('GuestName').AsString               :=  GuestName                 ;
        kbmRoomsDate_.FieldByName('unPaidRoomRent').AsFloat           :=  unPaidRoomRent            ;
        kbmRoomsDate_.FieldByName('DiscountUnPaidRoomRent').AsFloat   :=  DiscountUnPaidRoomRent    ;
        kbmRoomsDate_.FieldByName('TotalUnpaidRoomRent').AsFloat      :=  TotalUnpaidRoomRent       ;
        kbmRoomsDate_.FieldByName('CurrencyRate').AsFloat             :=  CurrencyRate              ;
        kbmRoomsDate_.FieldByName('statusDescription').AsString       :=  statusDescription         ;
        kbmRoomsDate_.FieldByName('TotalItems').AsFloat               :=  TotalItems                ;
        kbmRoomsDate_.post;
      end;
      kbmInvoicelines_.next;
    end;

    nativeCurrency := ctrlGetString('NativeCurrency');

    kbmGroupInvoiceLines_.SortFields := 'RoomReservation';
    kbmGroupInvoiceLines_.Sort([]);

    kbmGroupInvoiceLines_.First;
    while not kbmGroupInvoiceLines_.eof do
    begin
     ResFlag                 := 'X';
     Arrival                 := kbmGroupInvoiceLines_.FieldByName('dtArrival').AsDateTime;
     Departure               := kbmGroupInvoiceLines_.FieldByName('dtDeparture').AsDateTime;
     GroupAccount            := true;
     RoomRentPaymentInvoice  := 0;
     Customer                := kbmGroupInvoiceLines_.FieldByName('Customer').AsString;
     ReservationName         := kbmGroupInvoiceLines_.FieldByName('ReservationName').AsString;;
     GuestName               := 'Group';
     unPaidRoomRent          := 0;
     DiscountUnPaidRoomRent  := 0;
     TotalUnpaidRoomRent     := 0;

     RoomReservation   := kbmGroupInvoiceLines_.FieldByName('RoomReservation').AsInteger;
     Reservation       := kbmGroupInvoiceLines_.FieldByName('Reservation').AsInteger;
     TotalItems        := kbmGroupInvoiceLines_.FieldByName('Amount').asfloat;
     CurrencyRate      := kbmGroupInvoiceLines_.FieldByName('CurrencyRate').asfloat;
     statusDescription := 'MISC';

      kbmRoomsDate_.insert;
      kbmRoomsDate_.FieldByName('roomReservation').AsInteger        :=  RoomReservation           ;
      kbmRoomsDate_.FieldByName('Reservation').AsInteger            :=  Reservation               ;
      kbmRoomsDate_.FieldByName('Room').AsString                    :=  '<Group>'                 ;
      kbmRoomsDate_.FieldByName('RoomType').AsString                :=  '<Group>'                 ;
      kbmRoomsDate_.FieldByName('isNoroom').AsBoolean               :=  false                     ;
      kbmRoomsDate_.FieldByName('ResFlag').AsString                 :=  ResFlag                   ;
      kbmRoomsDate_.FieldByName('currency').AsString                :=  nativeCurrency            ;
      kbmRoomsDate_.FieldByName('discount').AsFloat                 :=  0                         ;
      kbmRoomsDate_.FieldByName('isPercentage').AsBoolean           :=  true                      ;
      kbmRoomsDate_.FieldByName('TotalRate').AsFloat                :=  0                         ;
      kbmRoomsDate_.FieldByName('Arrival').AsDateTime               :=  Arrival                   ;
      kbmRoomsDate_.FieldByName('Departure').AsDateTime             :=  Departure                 ;
      kbmRoomsDate_.FieldByName('isGroupAccount').AsBoolean         :=  GroupAccount              ;
      kbmRoomsDate_.FieldByName('RoomRentPaymentInvoice').AsInteger :=  RoomRentPaymentInvoice    ;
      kbmRoomsDate_.FieldByName('Customer').AsString                :=  Customer                  ;
      kbmRoomsDate_.FieldByName('ReservationName').AsString         :=  ReservationName  ;
      kbmRoomsDate_.FieldByName('GuestName').AsString               :=  GuestName                 ;
      kbmRoomsDate_.FieldByName('unPaidRoomRent').AsFloat           :=  unPaidRoomRent            ;
      kbmRoomsDate_.FieldByName('DiscountUnPaidRoomRent').AsFloat   :=  DiscountUnPaidRoomRent    ;
      kbmRoomsDate_.FieldByName('TotalUnpaidRoomRent').AsFloat      :=  TotalUnpaidRoomRent       ;
      kbmRoomsDate_.FieldByName('CurrencyRate').AsFloat             :=  CurrencyRate              ;
      kbmRoomsDate_.FieldByName('statusDescription').AsString       :=  statusDescription         ;
      kbmRoomsDate_.FieldByName('TotalItems').AsFloat               :=  TotalItems                ;
      kbmRoomsDate_.post;

      kbmGroupInvoiceLines_.next;
    end;

  finally
    kbmRoomsDate_.EnableControls;
    kbmInvoicelines_.EnableControls;
    screen.Cursor := crDefault;
  end;
end;



end.
