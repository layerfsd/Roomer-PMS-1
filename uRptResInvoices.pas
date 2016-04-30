unit uRptResInvoices;

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
  , Data.DB
  , Vcl.StdCtrls
  , Vcl.Mask
  , shellapi


  , kbmMemTable
  ,cmpRoomerDataSet
  ,cmpRoomerConnection

  , _glob
  , ug
  , hData
  , uUtils


  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sButton
  , sComboBox
  , sGroupBox
  , Vcl.ExtCtrls
  , sPanel

  , cxGridExportLink
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxCurrencyEdit, dxmdaset, Vcl.ComCtrls, sPageControl, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, AdvEdit, AdvEdBtn, dxStatusBar, sSplitter, Vcl.Buttons, sSpeedButton, sEdit,
  sLabel, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

  ;

type
  TfrmRptResInvoices = class(TForm)
    Panel3: TsPanel;
    cxGroupBox2: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    gbxSelectDates: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    dxStatusBar1: TdxStatusBar;
    sPanel1: TsPanel;
    splitLeft: TsSplitter;
    tabsMain: TsPageControl;
    tabFinishedInvoices: TsTabSheet;
    tabOpenInvoices: TsTabSheet;
    Panel5: TsPanel;
    btnGuestsExcel: TsButton;
    tvTotal: TcxGridDBTableView;
    lvTotal: TcxGridLevel;
    grTotal: TcxGrid;
    kbmTotal: TkbmMemTable;
    sPanel2: TsPanel;
    TotalDS: TDataSource;
    sPanel3: TsPanel;
    sButton4: TsButton;
    mInvoiceHeads: TdxMemData;
    mInvoiceHeadsInvoiceNumber: TIntegerField;
    mInvoiceHeadsSplitNumber: TIntegerField;
    mInvoiceHeadsInvoiceDate: TDateField;
    mInvoiceHeadsdueDate: TDateField;
    mInvoiceHeadsReservation: TIntegerField;
    mInvoiceHeadsRoomReservation: TIntegerField;
    mInvoiceHeadsCustomer: TStringField;
    mInvoiceHeadsNameOnInvoice: TStringField;
    mInvoiceHeadsAddress1: TStringField;
    mInvoiceHeadsAddress2: TStringField;
    mInvoiceHeadsAddress3: TStringField;
    mInvoiceHeadsAmountWithTax: TFloatField;
    mInvoiceHeadsAmountNoTax: TFloatField;
    mInvoiceHeadsinvRefrence: TStringField;
    mInvoiceHeadsAmountTax: TFloatField;
    mInvoiceHeadsCreditInvoice: TIntegerField;
    mInvoiceHeadsOriginalInvoice: TIntegerField;
    mInvoiceHeadsRoomGuest: TStringField;
    mInvoiceHeadsPayTypes: TStringField;
    mInvoiceHeadsPayGroups: TStringField;
    mInvoiceHeadsPayTypeDescription: TStringField;
    mInvoiceHeadspayGroupDescription: TStringField;
    mInvoiceLines: TdxMemData;
    mInvoiceLinesInvoiceNumber: TIntegerField;
    mInvoiceLinesItem: TStringField;
    mInvoiceLinesQuantity: TFloatField;
    mInvoiceLinesDescription: TStringField;
    mInvoiceLinesPrice: TFloatField;
    mInvoiceLinesVatType: TStringField;
    mInvoiceLinesAmountWithTax: TFloatField;
    mInvoiceLinesAmountNoTax: TFloatField;
    mInvoiceLinesAmountTax: TFloatField;
    mInvoiceLinesCurrency: TStringField;
    mInvoiceLinesCurrencyRate: TFloatField;
    mInvoiceLinesImportRefrence: TStringField;
    mInvoiceLinesImportSource: TStringField;
    mInvoiceLinespurchaseDate: TDateField;
    mInvoiceHeadsDS: TDataSource;
    mInvoiceLinesDS: TDataSource;
    Grid: TcxGrid;
    tvInvoiceHeads: TcxGridDBTableView;
    tvInvoiceHeadsRecId: TcxGridDBColumn;
    tvInvoiceHeadsInvoiceNumber: TcxGridDBColumn;
    tvInvoiceHeadsInvoiceDate: TcxGridDBColumn;
    tvInvoiceHeadsCustomer: TcxGridDBColumn;
    tvInvoiceHeadsNameOnInvoice: TcxGridDBColumn;
    tvInvoiceHeadsAmountWithTax: TcxGridDBColumn;
    tvInvoiceHeadsAmountNoTax: TcxGridDBColumn;
    tvInvoiceHeadsAmountTax: TcxGridDBColumn;
    tvInvoiceHeadsPayTypes: TcxGridDBColumn;
    tvInvoiceHeadsPayTypeDescription: TcxGridDBColumn;
    tvInvoiceHeadsPayGroups: TcxGridDBColumn;
    tvInvoiceHeadspayGroupDescription: TcxGridDBColumn;
    tvInvoiceHeadsAddress1: TcxGridDBColumn;
    tvInvoiceHeadsAddress2: TcxGridDBColumn;
    tvInvoiceHeadsAddress3: TcxGridDBColumn;
    tvInvoiceHeadsRoomGuest: TcxGridDBColumn;
    tvInvoiceHeadsinvRefrence: TcxGridDBColumn;
    tvInvoiceHeadsdueDate: TcxGridDBColumn;
    tvInvoiceHeadsCreditInvoice: TcxGridDBColumn;
    tvInvoiceHeadsOriginalInvoice: TcxGridDBColumn;
    tvInvoiceHeadsReservation: TcxGridDBColumn;
    tvInvoiceHeadsRoomReservation: TcxGridDBColumn;
    tvInvoiceHeadsSplitNumber: TcxGridDBColumn;
    tvInvoiceLines: TcxGridDBTableView;
    tvInvoiceLinesRecId: TcxGridDBColumn;
    tvInvoiceLinesInvoiceNumber: TcxGridDBColumn;
    tvInvoiceLinesItem: TcxGridDBColumn;
    tvInvoiceLinesDescription: TcxGridDBColumn;
    tvInvoiceLinesQuantity: TcxGridDBColumn;
    tvInvoiceLinesPrice: TcxGridDBColumn;
    tvInvoiceLinesAmountWithTax: TcxGridDBColumn;
    tvInvoiceLinesAmountNoTax: TcxGridDBColumn;
    tvInvoiceLinesAmountTax: TcxGridDBColumn;
    tvInvoiceLinesCurrency: TcxGridDBColumn;
    tvInvoiceLinesCurrencyRate: TcxGridDBColumn;
    tvInvoiceLinespurchaseDate: TcxGridDBColumn;
    tvInvoiceLinesImportRefrence: TcxGridDBColumn;
    tvInvoiceLinesImportSource: TcxGridDBColumn;
    tvInvoiceLinesVatType: TcxGridDBColumn;
    lvInvoiceHeads: TcxGridLevel;
    lvInvoiceLines: TcxGridLevel;
    btnToExcel: TsButton;
    btnShowReservation: TsButton;
    btnInvoiceInvoicelines: TsButton;
    btnExpandAll: TsButton;
    btnCollapseAll: TsButton;
    kbmItems: TkbmMemTable;
    ItemsDS: TDataSource;
    grItems: TcxGrid;
    tvItems: TcxGridDBTableView;
    lvItems: TcxGridLevel;
    tvItemsAmount: TcxGridDBColumn;
    tvItemsLines: TcxGridDBColumn;
    tvItemsItems: TcxGridDBColumn;
    tvItemsItemNumber: TcxGridDBColumn;
    tvItemsDescription: TcxGridDBColumn;
    btnGetData: TsButton;
    tvTotalroomCount: TcxGridDBColumn;
    tvTotaltotalDays: TcxGridDBColumn;
    tvTotalDaysPaid: TcxGridDBColumn;
    tvTotalDaysUnPaid: TcxGridDBColumn;
    tvTotalreservation: TcxGridDBColumn;
    tvTotalFirstArrival: TcxGridDBColumn;
    tvTotalLastDeparture: TcxGridDBColumn;
    tvTotalCustomer: TcxGridDBColumn;
    tvTotalreservationName: TcxGridDBColumn;
    tvTotalRoomInvoicecount: TcxGridDBColumn;
    tvTotalGroupInvoiceCount: TcxGridDBColumn;
    tvTotalnumPersons: TcxGridDBColumn;
    tvTotalCustomerName: TcxGridDBColumn;
    sTabSheet1: TsTabSheet;
    sPanel4: TsPanel;
    sButton2: TsButton;
    sButton3: TsButton;
    brtGroupInvoice: TsButton;
    kbmOpenInvoices: TkbmMemTable;
    OpenInvoicesDS: TDataSource;
    tvOpenInvoices: TcxGridDBTableView;
    lvOpenInvoices: TcxGridLevel;
    grOpenInvoices: TcxGrid;
    tvOpenInvoicesRoomreservation: TcxGridDBColumn;
    tvOpenInvoicesReservation: TcxGridDBColumn;
    tvOpenInvoicesarrival: TcxGridDBColumn;
    tvOpenInvoicesDeparture: TcxGridDBColumn;
    tvOpenInvoicesRoom: TcxGridDBColumn;
    tvOpenInvoicesstatus: TcxGridDBColumn;
    sButton5: TsButton;
    tvOpenInvoicesisGroup: TcxGridDBColumn;
    tvOpenInvoicescurrency: TcxGridDBColumn;
    tvOpenInvoicescustomer: TcxGridDBColumn;
    tvOpenInvoicescustomerName: TcxGridDBColumn;
    tvOpenInvoicesitemAmount: TcxGridDBColumn;
    tvOpenInvoicesunPaidRentNights: TcxGridDBColumn;
    tvOpenInvoicesGuestCount: TcxGridDBColumn;
    tvOpenInvoicesunPaidRoomRent: TcxGridDBColumn;
    tvOpenInvoicesDiscountUnPaidRoomRent: TcxGridDBColumn;
    tvOpenInvoicesTotalUnpaidRoomRent: TcxGridDBColumn;
    sButton6: TsButton;
    sButton7: TsButton;
    tvOpenInvoicestheReservation: TcxGridDBColumn;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    tvOpenInvoicesMainGuest: TcxGridDBColumn;
    tvOpenInvoicesRoomType: TcxGridDBColumn;
    tvOpenInvoicesroomclass: TcxGridDBColumn;
    tvOpenInvoicesinvRefrence: TcxGridDBColumn;
    tvOpenInvoicesinformation: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtDateFromChange(Sender: TObject);
    procedure cbxMonthCloseUp(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnGuestsExcelClick(Sender: TObject);
    procedure splitLeftDblClick(Sender: TObject);
    procedure tvTotalTotalAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure edFilterChange(Sender: TObject);
    procedure edFilterClickBtn(Sender: TObject);
    procedure tvTotalCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure tvTotalCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnToExcelClick(Sender: TObject);
    procedure btnShowReservationClick(Sender: TObject);
    procedure btnInvoiceInvoicelinesClick(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure btnGetDataClick(Sender: TObject);
    procedure brtGroupInvoiceClick(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure tabsMainPageChanging(Sender: TObject; NewPage: TsTabSheet; var AllowChange: Boolean);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure btnExpandAllClick(Sender: TObject);
    procedure btnCollapseAllClick(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
    procedure sButton7Click(Sender: TObject);
    procedure tvOpenInvoicesCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }

    zDateFrom : Tdate;
    zDateTo   : Tdate;
    zYear     : integer;
    zMonth    : integer;
    zSetDates : boolean;

    procedure GetPaymentsTypes(rSet : TRoomerDataSet; invoiceNumber : integer; var PayTypes, PayTypeDescription, payGroups, payGroupDescription : string);
    procedure getCustInvoices(invoicelist:string);
    procedure getUnpaidByCustomer(customer:string);
    procedure ApplyFilter;
    procedure ShowData;
    function GetInvoicelist(customer : string) : string;
    function GetUnpaidlist(customer : string) : string;
    procedure showdata2;
    function inString : string;
    procedure getTotal;
    procedure openRoomInvoice;
    procedure openGroupInvoice;

  public
    { Public declarations }
  end;

function RptResInvoices : boolean;

var
  frmRptResInvoices: TfrmRptResInvoices;

implementation

{$R *.dfm}

uses
  uD,
  uReservationProfile,
  uFinishedInvoices2,
  uInvoice,
  uGuestProfile2,
  uCustomers2,
  uAppGlobal,
  uRoomerLanguage,
  PrjConst
  , uDImages;

function RptResInvoices : boolean;
begin
  result := false;
  frmRptResInvoices := TfrmRptResInvoices.Create(frmRptResInvoices);
  try
    frmRptResInvoices.ShowModal;
    if frmRptResInvoices.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmRptResInvoices);
  end;
end;


procedure TfrmRptResInvoices.ShowData;
var
  y, m, d : word;
  idx : integer;
  lastDay : integer;
begin

  decodeDate(now, y, m, d);
  zYear := y;
  zMonth := m;
  cbxMonth.ItemIndex := zMonth;

  cbxYear.ItemIndex := cbxYear.Items.IndexOf(inttostr(zYear));
//  idx := zYear - 2010;
//  if (idx < cbxYear.Items.Count - 1) and (idx > 0) then
//  begin
//    cbxYear.ItemIndex := idx;
//  end;

  zDateFrom := encodeDate(y, m, 1);
  lastDay := _DaysPerMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;
end;


procedure TfrmRptResInvoices.splitLeftDblClick(Sender: TObject);
begin
  if (spanel1.width < 30) then spanel1.width := 400 else spanel1.width := 20;
  Invalidate;
  Update;
end;

procedure TfrmRptResInvoices.tabsMainPageChanging(Sender: TObject; NewPage: TsTabSheet; var AllowChange: Boolean);
var
  customer : string;
begin
  if newPage = sTabSheet1 then
  begin
    customer := kbmTotal.FieldByName('customer').asstring;
    getUnpaidByCustomer(customer);
  end;
end;

procedure TfrmRptResInvoices.tvOpenInvoicesCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  isGroup : boolean;
begin
  isGroup := kbmOpenInvoices.FieldByName('isGroup').AsBoolean;
  if isGroup then
  begin
    openGroupinvoice;
  end else
  begin
    openRoomInvoice;
  end;
end;

procedure TfrmRptResInvoices.tvTotalCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  customer : string;
begin
  showdata2;
  if tabsmain.ActivePageIndex = 2 then
  begin
    customer := kbmTotal.FieldByName('customer').asstring;
    getUnpaidByCustomer(customer);
  end;
end;

procedure TfrmRptResInvoices.tvTotalCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  customer : string;
begin
  showdata2;
  if tabsmain.ActivePageIndex = 2 then
  begin
    customer := kbmTotal.FieldByName('customer').asstring;
    getUnpaidByCustomer(customer);
  end;
end;

procedure TfrmRptResInvoices.showdata2;
var
  customer : string;
  invoicelist : string;
begin
  kbmItems.Close;
  kbmItems.open;

  mInvoiceheads.Close;
  mInvoiceheads.open;

  mInvoiceLines.Close;
  mInvoiceLines.open;

  kbmOpenInvoices.Close;
  kbmOpenInvoices.Open;

  customer := kbmTotal.FieldByName('customer').asString;
  invoicelist := GetInvoicelist(customer);
  getCustInvoices(invoicelist);
end;


procedure TfrmRptResInvoices.tvTotalTotalAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptResInvoices.brtGroupInvoiceClick(Sender: TObject);
var
  Reservation : integer;
  RoomReservation : integer;
begin
  Reservation := kbmOpeninvoices.FieldByName('Reservation').AsInteger;
  RoomReservation := kbmOpenInvoices.FieldByName('RoomReservation').AsInteger;
  EditInvoice(Reservation, 0, 0, 0, 0, 0, false, true,false);
end;


procedure TfrmRptResInvoices.openGroupInvoice;
var
  Reservation : integer;
  RoomReservation : integer;
begin
  Reservation := kbmOpeninvoices.FieldByName('Reservation').AsInteger;
  RoomReservation := kbmOpenInvoices.FieldByName('RoomReservation').AsInteger;
  EditInvoice(Reservation, 0, 0, 0, 0, 0, false, true,false);
end;



procedure TfrmRptResInvoices.btnCollapseAllClick(Sender: TObject);
begin
  tvInvoiceHeads.ViewData.Collapse(true);
end;

procedure TfrmRptResInvoices.btnExpandAllClick(Sender: TObject);
begin
  tvInvoiceHeads.ViewData.Expand(True);
end;

procedure TfrmRptResInvoices.btnGuestsExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  if kbmTotal.RecordCount = 0 then exit;
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_reservations';
  ExportGridToExcel(sFilename, grTotal {grGroupInvoiceSums}, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptResInvoices.btnInvoiceInvoicelinesClick(Sender: TObject);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := mInvoiceHeads.fieldbyname('InvoiceNumber').AsInteger;
  ViewInvoice2(InvoiceNumber, false, false, false,false, '');
end;

function TfrmRptResInvoices.inString : string;
var
  s : string;
begin
  s := '';
  s := s+'     SELECT '#10;
  s := s+'       r2.roomreservation '#10;
  s := s+'     FROM '#10;
  s := s+'       roomsdate d2 '#10;
  s := s+'       INNER JOIN roomreservations r2 ON r2.roomreservation = d2.roomreservation '#10;
  s := s+'     WHERE '#10;
  s := s+'           (r2.arrival >= '+_dateToSqlDate(zDateFrom)+') '#10;
  s := s+'       AND (r2.arrival <= '+_dateToSqlDate(zDateTO)+') '#10;
  s := s+'       AND ((d2.resFlag) <> '+_db('C')+' and (d2.resFlag <> '+_db('X')+')) '#10;
  result := s;
end;


procedure TfrmRptResInvoices.btnRefreshClick(Sender: TObject);
begin
  getTotal;
end;

procedure TfrmRptResInvoices.GetTotal;
var
  s      : string;
  rset1 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;
  inst : string;
  tmpCustomer : string;
  customer : string;

  roomCount  : integer;
  totalDays  : integer;
  daysPaid   : integer;
  daysUnpaid : integer;

  FirstArrival : Tdate;
  LastDeparture  : TDate;

  CustomerName : string;

  roomInvoiceCount : integer;
  groupInvoiceCount : integer;
  numPersons : integer;

  procedure insertTotal;
  begin
    kbmTotal.insert;
    kbmTotal.fieldbyname('Customer').asstring          :=  tmpCustomer          ;
    kbmTotal.fieldbyname('CustomerName').asstring      :=  CustomerName         ;
    kbmTotal.fieldbyname('roomCount').AsInteger        :=  roomCount            ;
    kbmTotal.fieldbyname('roomInvoiceCount').AsInteger :=  roomInvoiceCount     ;
    kbmTotal.fieldbyname('groupInvoiceCount').AsInteger:=  groupInvoiceCount    ;
    kbmTotal.fieldbyname('numPersons').AsInteger       :=  numPersons           ;
    kbmTotal.fieldbyname('firstArrival').AsDateTime    :=  firstArrival         ;
    kbmTotal.fieldbyname('lastDeparture').AsDateTime   :=  lastDeparture        ;
    kbmTotal.post;
  end;


begin

  kbmItems.Close;
  kbmItems.open;

  mInvoiceheads.Close;
  mInvoiceheads.open;

  mInvoiceLines.Close;
  mInvoiceLines.open;

  kbmOpenInvoices.Close;
  kbmOpenInvoices.Open;


  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    s := '';
    s := s+'SELECT '#10;
    s := s+'   count(rr.roomreservation) AS roomCount '#10;
  //  s := s+'  ,(SELECT count(adate) from roomsdate WHERE roomsdate.reservation = rv.reservation) AS totalDays '#10;
  //  s := s+'  ,(SELECT count(adate) from roomsdate WHERE (roomsdate.reservation = rv.reservation) and (paid=1)) AS DaysPaid '#10;
  //  s := s+'  ,(SELECT count(adate) from roomsdate WHERE (roomsdate.reservation = rv.reservation) and (paid=0)) AS DaysUnPaid '#10;
    s := s+'  ,rv.reservation '#10;
    s := s+'  ,min(rr.rrarrival) AS firstArrival '#10;
    s := s+'  ,min(rr.rrdeparture) AS lastDeparture '#10;
    s := s+'  ,rv.customer AS Customer'#10;
    s := s+'  ,cu.surName AS CustomerName '#10;
    s := s+'  ,rv.name AS reservationName '#10;
    s := s+'  ,(SELECT count(id) FROM invoiceheads ih WHERE (ih.invoicenumber>0) and (ih.reservation = rv.reservation) and (ih.roomreservation<>0)) AS RoomInvoicecount '#10;
    s := s+'  ,(SELECT count(id) FROM invoiceheads ih WHERE (ih.invoicenumber>0) and (ih.reservation = rv.reservation) and (ih.roomreservation=0)) AS GroupInvoicecount '#10;
    s := s+'  ,(SELECT count(person) FROM persons pe WHERE pe.reservation = rr.reservation) AS numPersons '#10;
    s := s+'FROM '#10;
    s := s+'  roomreservations rr '#10;
    s := s+'  INNER JOIN reservations rv ON rv.reservation = rr.reservation '#10;
    s := s+'  INNER JOIN customers cu ON cu.customer = rv.customer '#10;
    s := s+'WHERE '#10;
    s := s+'  rr.roomreservation IN ( '+instring+')  '#10;
    s := s+' GROUP BY '#10;
    s := s+'  rv.reservation '#10;
    s := s+' ORDER BY '#10;
    s := s+'  rv.customer '#10;

//    copytoclipboard(s);
//    debugmessage(s);


    ExecutionPlan.AddQuery(s);

    screen.Cursor := crHourGlass;
    kbmTotal.DisableControls;
    try
      if ExecutionPlan.Execute(ptQuery) then
      begin
        rSet1 := ExecutionPlan.Results[0];

        if kbmTotal.Active then kbmTotal.Close;
        kbmTotal.open;

        roomCount         := 0;
        roomInvoiceCount  := 0;
        groupInvoiceCount := 0;
        numPersons        := 0;

        rSet1.First;
        tmpcustomer   := rSet1.fieldbyname('Customer').AsString;
        firstArrival  := rSet1.fieldbyname('FirstArrival').AsDateTime;
        lastDeparture := rSet1.fieldbyname('lastDeparture').AsDateTime;
        CustomerName := rSet1.FieldByName('customerName').asstring;
         while not rSet1.eof do
        begin
          Customer := rSet1.fieldbyname('customer').AsString;
//          customerName := rSet1.fieldbyname('customerName').AsString;
          if tmpCustomer = customer then
          begin
            roomCount         := roomCount        + rSet1.fieldbyname('roomCount').AsInteger;
            roomInvoiceCount  := roomInvoiceCount + rSet1.fieldbyname('roomInvoiceCount').AsInteger;
            groupInvoiceCount := groupInvoiceCount+ rSet1.fieldbyname('groupInvoiceCount').AsInteger;
            numPersons        := numPersons       + rSet1.fieldbyname('numPersons').AsInteger;
            CustomerName := rSet1.FieldByName('customerName').asstring;
            if firstArrival > rSet1.fieldbyname('FirstArrival').AsDateTime then
              firstArrival := rSet1.fieldbyname('FirstArrival').asDateTime;
            if LastDeparture < rSet1.fieldbyname('lastDeparture').AsDateTime then
              lastDeparture := rSet1.fieldbyname('lastDeparture').asDateTime;
          end else
          begin
            insertTotal;
            roomCount         := rSet1.fieldbyname('roomCount').AsInteger;
            roomInvoiceCount  := rSet1.fieldbyname('roomInvoiceCount').AsInteger;
            groupInvoiceCount := rSet1.fieldbyname('groupInvoiceCount').AsInteger;
            numPersons        := rSet1.fieldbyname('numPersons').AsInteger;

            tmpcustomer := rSet1.fieldbyname('customer').AsString;
            customerName := rSet1.fieldbyname('customerName').AsString;
          end;

          rSet1.Next;

          if rSet1.eof then
          begin
            insertTotal;
          end;
        end;
  //    kbmTotal.LoadFromDataSet(rSet1,[]);
        kbmTotal.SortFields := 'Customer';
        kbmTotal.sort([]);
        kbmTotal.First;
      end;
    finally
      screen.cursor := crDefault;
      kbmTotal.EnableControls;
    end;
  finally
    ExecutionPlan.Free;
  end;
end;


procedure TfrmRptResInvoices.btnShowReservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := mInvoiceHeads.fieldbyname('Reservation').asinteger;
  iRoomReservation := mInvoiceHeads.fieldbyname('RoomReservation').asinteger;

  if (ireservation=0) and (iroomreservation=0) then exit;


  if EditReservation(iReservation, iRoomReservation) then
  begin
  end;
end;

procedure TfrmRptResInvoices.btnToExcelClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  if mInvoiceheads.RecordCount=0 then exit;

  tvInvoiceHeads.ViewData.Collapse(true);
  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_CustInvoices';
  ExportGridToExcel(sFilename, grid, false, True, True);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptResInvoices.getUnpaidByCustomer(customer:string);
var
  rset1 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;
  s : string;
begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
 s := '';

    s := s+' SELECT '#10;
    s := s+'     rr.roomreservation '#10;
    s := s+'   , rr.reservation '#10;
    s := s+'   , rr.rrarrival AS Arrival '#10;
    s := s+'   , rr.rrdeparture AS Departure '#10;
    s := s+'   , rr.Status '#10;
    s := s+'   , rr.room '#10;
    s := s+'   , rr.groupaccount AS isGroup '#10;
    s := s+'   , rr.currency '#10;
    s := s+'   , cu.customer '#10;
    s := s+'   , rv.invRefrence '#10;
    s := s+'   , rr.roomtype '#10;
    s := s+'   , rr.roomclass '#10;
    s := s+'   , rv.information '#10;
    s := s+'   , cu.surName AS customerName '#10;
    s := s+'   , concat(rv.reservation,'+_db(' - ')+',rv.name)  AS theReservation '#10;
    s := s+'   , (SELECT sum(Total) from invoicelines where (invoicelines.roomreservation = rr.roomreservation)) AS itemAmount '#10;
    s := s+'   , (SELECT count(ID) FROM roomsdate WHERE (roomsdate.roomreservation=rr.roomreservation) AND (paid=0) AND (roomsdate.ResFlag <> '+_db('X')+' )) AS unPaidRentNights '#10;
    s := s+'   , (SELECT count(ID) FROM persons WHERE persons.roomreservation=rr.roomreservation) AS GuestCount '#10;
    s := s+'   , (SELECT name FROM persons WHERE persons.mainname=1 and persons.roomreservation=rr.roomreservation limit 1) AS Mainguest '#10;
    s := s+'   , (SELECT SUM(RoomRate) FROM roomsdate WHERE (roomsdate.roomreservation=rr.roomreservation) AND (roomsdate.paid=0) AND (roomsdate.ResFlag <>'+_db('X')+' )) AS unPaidRoomRent '#10;
    s := s+'   , (SELECT SUM(IF(isPercentage, RoomRate*Discount/100, Discount)) FROM roomsdate WHERE (roomsdate.roomreservation=rr.roomreservation) AND (roomsdate.paid=0) AND (roomsdate.ResFlag <> '+_db('X')+' ))  AS DiscountUnPaidRoomRent '#10;
    s := s+'   , ((SELECT SUM(RoomRate) FROM roomsdate WHERE (roomsdate.roomreservation=rr.roomreservation) AND (roomsdate.paid=0) and (roomsdate.ResFlag <> '+_db('X')+' )) '#10;
    s := s+'          - (SELECT SUM(IF(isPercentage, RoomRate*Discount/100, Discount)) FROM roomsdate WHERE (roomsdate.roomreservation=rr.roomreservation) AND (roomsdate.paid=0) AND (roomsdate.ResFlag <> '+_db('X')+' ))) AS TotalUnpaidRoomRent '#10;
    s := s+'      FROM '#10;
    s := s+'        roomsdate rd '#10;
    s := s+'        INNER JOIN roomreservations rr ON rr.roomreservation = rd.roomreservation '#10;
    s := s+'        INNER JOIN reservations rv ON rv.reservation = rr.reservation '#10;
    s := s+'        INNER JOIN customers cu ON cu.customer = rv.customer '#10;
    s := s+'      WHERE '#10;
    s := s+'           (rr.arrival >= '+_dateToSqlDate(zDateFrom)+') '#10;
    s := s+'       AND (rr.arrival <= '+_dateToSqlDate(zDateTO)+') '#10;
    s := s+'       AND ((rd.resFlag) <> '+_db('C')+' and (rd.resFlag <> '+_db('X')+')) '#10;
    s := s+'       AND rd.paid = 0 '#10;
    s := s+'       AND cu.customer = '+_db(customer)+' '#10;
    s := s+'  GROUP BY roomreservation desc '#10;

//   copytoclipboard(s);
//   debugmessage(s);

    ExecutionPlan.AddQuery(s);
    screen.Cursor := crHourGlass;

    kbmOpenInvoices.DisableControls;
    try
      if ExecutionPlan.Execute(ptQuery) then
      begin
        rSet1 := ExecutionPlan.Results[0];

        if kbmOpenInvoices.Active then kbmOpenInvoices.Close;
        kbmOpenInvoices.open;
        LoadKbmMemtableFromDataSetQuiet(kbmOpenInvoices,rSet1,[]);

        kbmOpenInvoices.SortFields := 'arrival;room';
        kbmOpenInvoices.sort([]);
        kbmOpenInvoices.First;


      end;
    finally
      kbmOpenInvoices.enableControls;
      screen.Cursor := crDefault;
      tvOpenInvoices.ViewData.Expand(true);
    end;
  finally
    ExecutionPlan.Free;
  end;
end;


function TfrmRptResInvoices.GetInvoicelist(customer : string) : string;
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
  invoicelist : string;

  lst : Tstringlist;

begin
  lst := TstringList.Create;
  try
    invoicelist := '';
    ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try
      startTick := GetTickCount;

      s := s+'SELECT '#10;
      s := s+'  ih.invoicenumber '#10;
      s := s+'FROM '#10;
      s := s+'  invoiceheads ih '#10;
      s := s+'WHERE '#10;
      s := s+'  ih.roomreservation IN ( '+instring+')  '#10;
      s := s+'   AND (invoicenumber > 0) '#10;
      s := s+'   AND (customer = '+_db(customer)+') '#10;

//      copytoclipboard(s);
//      debugmessage(s);

      ExecutionPlan.AddQuery(s);
      //////////////////// Execute!

      screen.Cursor := crHourGlass;
      kbmTotal.DisableControls;
      try
        ExecutionPlan.Execute(ptQuery);

        //////////////////// RoomsDate
        rSet1 := ExecutionPlan.Results[0];

        while not rset1.Eof  do
        begin
          invoicelist := invoicelist+rset1.FieldByName('invoicenumber').AsString+',';
          rset1.Next;
        end;
        if length(invoicelist) > 1 then
        begin
          delete(invoicelist,length(invoicelist),1)
        end;

      finally
        screen.cursor := crDefault;
        kbmTotal.EnableControls;
      end;
      stopTick         := GetTickCount;
      SQLms            := stopTick - startTick;
    finally
      ExecutionPlan.Free;
    end;
  finally
    freeandnil(lst)
  end;
  result := invoicelist;
end;



function TfrmRptResInvoices.GetUnpaidlist(customer : string) : string;
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
  invoicelist : string;

  lst : Tstringlist;

begin
  lst := TstringList.Create;
  try
    invoicelist := '';
    ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try
      startTick := GetTickCount;

      s := s+'SELECT '#10;
      s := s+'  ih.invoicenumber '#10;
      s := s+'FROM '#10;
      s := s+'  invoiceheads ih '#10;
      s := s+'WHERE '#10;
      s := s+'  ih.roomreservation IN ( '+instring+')  '#10;
      s := s+'   AND (invoicenumber > 0) '#10;
      s := s+'   AND (customer = '+_db(customer)+') '#10;

//      copytoclipboard(s);
//      debugmessage(s);

      ExecutionPlan.AddQuery(s);
      //////////////////// Execute!

      screen.Cursor := crHourGlass;
      kbmTotal.DisableControls;
      try
        ExecutionPlan.Execute(ptQuery);

        //////////////////// RoomsDate
        rSet1 := ExecutionPlan.Results[0];

        while not rset1.Eof  do
        begin
          invoicelist := invoicelist+rset1.FieldByName('invoicenumber').AsString+',';
          rset1.Next;
        end;
        if length(invoicelist) > 1 then
        begin
          delete(invoicelist,length(invoicelist),1)
        end;

      finally
        screen.cursor := crDefault;
        kbmTotal.EnableControls;
      end;
      stopTick         := GetTickCount;
      SQLms            := stopTick - startTick;
    finally
      ExecutionPlan.Free;
    end;
  finally
    freeandnil(lst)
  end;
  result := invoicelist;
end;





procedure TfrmRptResInvoices.cbxMonthCloseUp(Sender: TObject);
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

procedure TfrmRptResInvoices.dtDateFromChange(Sender: TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmRptResInvoices.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    tvTotal.DataController.Filter.Root.Clear;
    tvTotal.DataController.Filter.Active := false;
  end else
  begin
    applyFilter;
  end;

end;

procedure TfrmRptResInvoices.edFilterClickBtn(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRptResInvoices.ApplyFilter;
begin
  tvTotal.DataController.Filter.Options := [fcoCaseInsensitive];
  tvTotal.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvTotal.DataController.Filter.Root.Clear;
  tvTotal.DataController.Filter.Root.AddItem(tvTotalCustomer,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvTotal.DataController.Filter.Root.AddItem(tvTotalCustomername,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvTotal.DataController.Filter.Active := True;
end;


procedure TfrmRptResInvoices.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**
end;

procedure TfrmRptResInvoices.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);
end;

procedure TfrmRptResInvoices.FormShow(Sender: TObject);
begin
  //**
  tabsMain.ActivePageIndex := 0;
  showdata;
  getTotal;
end;


procedure TfrmRptResInvoices.GetPaymentsTypes(rSet : TRoomerDataSet; invoiceNumber : integer; var PayTypes, PayTypeDescription, payGroups, payGroupDescription : string);
var
  s : string;
  PayType : string;
  PayGroup : string;
  bookmark : TBookmark;

  lstPayType             : TstringList;
  lstPayTypeDescription  : TstringList;
  lstPayGroup            : TstringList;
  lstPayGroupDescription : TstringList;

  i : integer;

begin
  PayTypes  := '';
  PayGroups := '';

  lstPayType             := TstringList.Create;
  lstPayTypeDescription  := TstringList.Create;
  lstPayGroup            := TstringList.Create;
  lstPayGroupDescription := TstringList.Create;

  lstPayType.Sorted     := true;
  lstPayType.Duplicates := dupIgnore;

  lstPayTypeDescription.Sorted     := true;
  lstPayTypeDescription.Duplicates := dupIgnore;

  lstPayGroup.Sorted     := true;
  lstPayGroup.Duplicates := dupIgnore;

  lstPayGroupDescription.Sorted     := true;
  lstPayGroupDescription.Duplicates := dupIgnore;

   try
    bookmark := rSet.GetBookmark;
    try
      while (not rSet.eof) AND
            (rSet.FieldByName('InvoiceNumber').asinteger = invoiceNumber) do
      begin
        PayType             := rSet.FieldByName('PayType').AsString;
        payTypeDescription  := rSet.FieldByName('PayTypeDescription').AsString;
        PayGroup            := rSet.FieldByName('PayGroup').AsString;
        PayGroupDescription := rSet.FieldByName('PayGroupDescription').AsString;

        lstPayType.Add(PayType);
        lstPayTypeDescription.Add(payTypeDescription);
        lstPayGroup.Add(PayGroup);
        lstPayGroupDescription.Add(PayGroupDescription);

        rSet.next;
      end;
    finally
      rSet.GotoBookmark(bookmark);
      rSet.FreeBookmark(bookmark);
    end;

    PayTypes := '';
    for i := 0  to lstPayType.Count-1 do
    begin
      PayTypes  := PayTypes+lstPayType[i]+',';
    end;

    payTypeDescription := '';
    for i := 0  to lstpayTypeDescription.Count-1 do
    begin
      payTypeDescription  := payTypeDescription+lstpayTypeDescription[i]+',';
    end;

    PayGroups := '';
    for i := 0  to lstPayGroup.Count-1 do
    begin
      PayGroups  := PayGroups+lstPayGroup[i]+',';
    end;

    PayGroupDescription := '';
    for i := 0  to lstPayGroupDescription.Count-1 do
    begin
      PayGroupDescription  := PayGroupDescription+lstPayGroupDescription[i]+',';
    end;

  finally
    freeandnil(lstPayType);
    freeandnil(lstPayTypeDescription);
    freeandnil(lstPayGroup);
    freeandnil(lstPayGroupDescription);
  end;

  if payTypes <> '' then delete(payTypes,length(payTypes),1);
  if payGroups <> '' then delete(payGroups,length(payGroups),1);
  if payTypeDescription <> '' then delete(payTypeDescription,length(payTypeDescription),1);
  if PayGroupDescription <> '' then delete(PayGroupDescription,length(PayGroupDescription),1);


  if pos(',',payGroups) > 0 then PayGroupDescription := 'Miscellaneous';
  if pos(',',payTypes)  > 0 then PayTypeDescription := 'Miscellaneous';
end;


procedure TfrmRptResInvoices.btnGetDataClick(Sender: TObject);
begin
  showdata2;
end;

procedure TfrmRptResInvoices.sButton2Click(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  if kbmOpenInvoices.RecordCount = 0 then Exit;

  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_resopenInvoices';
  ExportGridToExcel(sFilename, grOpenInvoices, false, True, True);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptResInvoices.sButton3Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := kbmOpenInvoices.fieldbyname('Reservation').asinteger;
  iRoomReservation := kbmOpenInvoices.fieldbyname('RoomReservation').asinteger;

  if (ireservation=0) and (iroomreservation=0) then exit;


  if EditReservation(iReservation, iRoomReservation) then
  begin
  end;
end;

procedure TfrmRptResInvoices.sButton4Click(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  if kbmItems.RecordCount = 0 then Exit;

  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_CustInvoicItems';
  ExportGridToExcel(sFilename, grItems, false, True, True);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptResInvoices.openRoomInvoice;
var
  Reservation : integer;
  RoomReservation : integer;
  Arrival : Tdate;
  Departure : Tdate;
begin
  Reservation := kbmOpenInvoices.FieldByName('Reservation').AsInteger;
  RoomReservation := kbmOpenInvoices.FieldByName('RoomReservation').AsInteger;
  Arrival := kbmOpenInvoices.FieldByName('Arrival').AsDateTime;
  Departure := kbmOpenInvoices.FieldByName('departure').AsDateTime;
  EditInvoice(Reservation, RoomReservation, 0, 0, 0, 0, false, true,false);
end;


procedure TfrmRptResInvoices.sButton5Click(Sender: TObject);
var
  Reservation : integer;
  RoomReservation : integer;
  Arrival : Tdate;
  Departure : Tdate;
begin
  Reservation := kbmOpenInvoices.FieldByName('Reservation').AsInteger;
  RoomReservation := kbmOpenInvoices.FieldByName('RoomReservation').AsInteger;
  Arrival := kbmOpenInvoices.FieldByName('Arrival').AsDateTime;
  Departure := kbmOpenInvoices.FieldByName('departure').AsDateTime;
  EditInvoice(Reservation, RoomReservation, 0, 0, 0, 0, false, true,false);
end;

procedure TfrmRptResInvoices.sButton6Click(Sender: TObject);
begin
  tvOpenInvoices.ViewData.Expand(true);
end;

procedure TfrmRptResInvoices.sButton7Click(Sender: TObject);
begin
  tvOpenInvoices.ViewData.Collapse(true);
end;

procedure TfrmRptResInvoices.getCustInvoices(invoicelist:string);
var
  rSet  : TRoomerDataSet;
  rset2 : TRoomerDataSet;
  ExecutionPlan : TRoomerExecutionPlan;
  s     : string;
  count : integer;

  InvoiceNumber     : integer ;
  SplitNumber       : integer ;
  InvoiceDate       : TDate   ;
  dueDate           : Tdate   ;
  Reservation       : integer ;
  RoomReservation   : integer ;
  NameOnInvoice     : string  ;
  Address1          : string  ;
  Address2          : string  ;
  Address3          : string  ;
  ihAmountWithTax   : double  ;
  ihAmountNoTax     : double  ;
  ihAmountTax       : double  ;
  CreditInvoice     : integer ;
  OriginalInvoice   : integer ;
  RoomGuest         : string  ;
  invRefrence       : string  ;

  Item              : string  ;
  Quantity          : double ;      //-96
  Description       : string  ;
  Price             : double  ;
  VATType           : String  ;
  ilAmountWithTax   : double  ;
  ilAmountNoTax     : double  ;
  ilAmountTax       : double  ;
  Currency          : string  ;
  CurrencyRate      : double  ;
  ImportRefrence    : string  ;
  ImportSource      : string  ;
  customer          : string  ;
  lastInvoiceNumber : integer;

  PayTypes : string;
  payTypeDescription : string;
  PayGroups : string;
  PayGroupDescription : string;

begin
  if invoicelist = '' then Exit;


  if zDateTo > zDateTo then
  begin
	  showmessage (GetTranslatedText('shTx_FormCustomInvoicesMD_WrongDate'));
    exit;
  end;

  screen.Cursor := crHourglass;
  mInvoiceHeads.DisableControls;
  mInvoiceLines.DisableControls;
  try
     ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try
      s := '';
      s := s+ '   SELECT '#10;
      s := s+ '     invoiceheads.Reservation '#10;
      s := s+ '   , invoiceheads.RoomReservation '#10;
      s := s+ '   , invoiceheads.SplitNumber '#10;
      s := s+ '   , invoiceheads.InvoiceNumber '#10;
      s := s+ '   , invoiceheads.Customer '#10;
      s := s+ '   , invoiceheads.Name As NameOnInvoice'#10;
      s := s+ '   , invoiceheads.Address1 '#10;
      s := s+ '   , invoiceheads.Address2 '#10;
      s := s+ '   , invoiceheads.Address3 '#10;
      s := s+ '   , invoiceheads.Total as ihAmountWithTax '#10;
      s := s+ '   , invoiceheads.TotalWOVAT as ihAmountNoTax '#10;
      s := s+ '   , invoiceheads.TotalVAT as ihAmountTax '#10;
      s := s+ '   , invoiceheads.CreditInvoice '#10;
      s := s+ '   , invoiceheads.OriginalInvoice '#10;
      s := s+ '   , invoiceheads.RoomGuest '#10;
      s := s+ '   , invoiceheads.ihInvoiceDate as InvoiceDate'#10;
      s := s+ '   , invoiceheads.ihPayDate as dueDate'#10;
      s := s+ '   , invoiceheads.invRefrence '#10;
      s := s+ '   , invoicelines.PurchaseDate '#10;
      s := s+ '   , invoicelines.ItemID as Item'#10;
      s := s+ '   , invoicelines.Number as Quantity'#10;
      s := s+ '   , invoicelines.Description '#10;
      s := s+ '   , invoicelines.Price '#10;
      s := s+ '   , invoicelines.VATType '#10;
      s := s+ '   , invoicelines.Total AS ilAmountWithTax '#10;
      s := s+ '   , invoicelines.TotalWOVat AS ilAmountNoTax '#10;
      s := s+ '   , invoicelines.Vat as ilAmountTax'#10;
      s := s+ '   , invoicelines.Currency '#10;
      s := s+ '   , invoicelines.CurrencyRate '#10;
      s := s+ '   , invoicelines.ImportRefrence '#10;
      s := s+ '   , invoicelines.ImportSource '#10;
      s := s+ '   , payments.description AS paymentsdescription '#10;
      s := s+ '   , payments.paytype '#10;
      s := s+ '   , paytypes.description as paytypedescription '#10;
      s := s+ '   , paytypes.paygroup '#10;
      s := s+ '   , paygroups.description as paygroupdescription '#10;

      s := s+ ' FROM '#10;
      s := s+ '  invoicelines '#10;
      s := s+ '     INNER JOIN invoiceheads ON invoicelines.InvoiceNumber = invoiceheads.InvoiceNumber '#10;
      s := s+ '     INNER JOIN payments on payments.invoicenumber = invoiceheads.invoicenumber '#10;
      s := s+ '     INNER JOIN paytypes on paytypes.paytype = payments.paytype '#10;
      s := s+ '     INNER JOIN paygroups on paytypes.paygroup = paygroups.paygroup '#10;
      s := s+ ' WHERE '#10;
      s := s+ ' invoiceheads.invoicenumber in ('+invoicelist+') '#10;

//      s := s+ '  (invoiceheads.InvoiceNumber > 0) ';
//      s := s+ ' AND (invoiceheads.ihInvoiceDate >= '+_DatetoDBDate(zDateFrom,true)+') ';
//      s := s+ ' AND (invoiceheads.ihInvoiceDate <= '+_DatetoDBDate(zDateTo,true)+') ';
//
//      s := s+ ' AND (invoiceheads.Customer = '+_db(Customer)+') ';


      s := s+ ' ORDER BY '#10;
      s := s+ '  invoiceheads.InvoiceNumber '#10;

//      copytoclipboard(s);
//      debugmessage(s);

      count :=0;

      ExecutionPlan.AddQuery(s);
     //////////////////// Execute!
      s := '';
      s := s+'SELECT '#10;
      s := s+'   sum(il.total) AS Amount '#10;
      s := s+'  ,count(il.id) AS LineCount '#10;
      s := s+'  ,sum(il.number) AS Items '#10;
      s := s+'  ,il.itemID AS ItemNumber '#10;
      s := s+'  ,it.description '#10;
      s := s+'FROM '#10;
      s := s+'  invoicelines il '#10;
      s := s+'  LEFT JOIN items it ON il.itemID = it.Item '#10;
      s := s+'WHERE (invoicenumber in ('+invoicelist+')) '#10;
      s := s+'GROUP BY '#10;
      s := s+'  il.ItemId  '#10;

      ExecutionPlan.AddQuery(s);
//      copytoclipboard(s);
//      debugmessage(s);

      ExecutionPlan.Execute(ptQuery);
      //////////////////// RoomsDate
      rSet := ExecutionPlan.Results[0];

      mInvoiceHeads.close;
      mInvoiceHeads.open;

      mInvoiceLines.close;
      mInvoiceLines.open;

      lastInvoiceNumber := -1;

      rSet.First;
      while not rSet.Eof do
      begin
        inc(count);

        InvoiceNumber     :=  rSet.FieldByName('InvoiceNumber').asinteger ;

        if invoiceNumber <> lastInvoiceNumber then
        begin
          lastInvoiceNumber := Invoicenumber;

          SplitNumber       :=  rSet.FieldByName('SplitNumber').asinteger ;
          InvoiceDate       :=  rSet.FieldByName('InvoiceDate').asDateTime   ;
          dueDate           :=  rSet.FieldByName('dueDate').asDateTime   ;
          Reservation       :=  rSet.FieldByName('Reservation').asinteger ;
          RoomReservation   :=  rSet.FieldByName('RoomReservation').asinteger ;
          NameOnInvoice     :=  rSet.FieldByName('NameOnInvoice').asstring  ;
          Customer          :=  rSet.FieldByName('Customer').asstring  ;
          Address1          :=  rSet.FieldByName('Address1').asstring  ;
          Address2          :=  rSet.FieldByName('Address2').asstring  ;
          Address3          :=  rSet.FieldByName('Address3').asstring  ;
          ihAmountWithTax   :=  LocalFloatValue(rSet.FieldByName('ihAmountWithTax').asString)  ;
          ihAmountNoTax     :=  LocalFloatValue(rSet.FieldByName('ihAmountNoTax').asString)  ;
          ihAmountTax       :=  LocalFloatValue(rSet.FieldByName('ihAmountTax').asString)  ;
          CreditInvoice     :=  rSet.FieldByName('CreditInvoice').asinteger ;
          OriginalInvoice   :=  rSet.FieldByName('OriginalInvoice').asinteger ;
          RoomGuest         :=  rSet.FieldByName('RoomGuest').asstring  ;
          invRefrence       :=  rSet.FieldByName('invRefrence').asstring  ;

          GetPaymentsTypes(rSet,
                           invoiceNumber
                         , PayTypes
                         , PayTypeDescription
                         , payGroups
                         , payGroupDescription

                           );


          mInvoiceHeads.Insert;
             mInvoiceHeads.FieldByName('InvoiceNumber').AsLargeInt  :=  InvoiceNumber  ;
             mInvoiceHeads.FieldByName('SplitNumber').asinteger    :=  SplitNumber    ;
             mInvoiceHeads.FieldByName('InvoiceDate').asDateTime   :=  InvoiceDate    ;
             mInvoiceHeads.FieldByName('dueDate').asDateTime       :=  dueDate        ;
             mInvoiceHeads.FieldByName('Reservation').AsLargeInt    :=  Reservation    ;
             mInvoiceHeads.FieldByName('RoomReservation').AsLargeInt:=  RoomReservation;
             mInvoiceHeads.FieldByName('Customer').asstring        :=  Customer       ;
             mInvoiceHeads.FieldByName('NameOnInvoice').asstring   :=  NameOnInvoice  ;
             mInvoiceHeads.FieldByName('Address1').asstring        :=  Address1       ;
             mInvoiceHeads.FieldByName('Address2').asstring        :=  Address2       ;
             mInvoiceHeads.FieldByName('Address3').asstring        :=  Address3       ;
             mInvoiceHeads.FieldByName('AmountWithTax').asFloat  :=  ihAmountWithTax;
             mInvoiceHeads.FieldByName('AmountNoTax').asFloat    :=  ihAmountNoTax  ;
             mInvoiceHeads.FieldByName('AmountTax').asFloat      :=  ihAmountTax    ;
             mInvoiceHeads.FieldByName('CreditInvoice').asinteger  :=  CreditInvoice  ;
             mInvoiceHeads.FieldByName('OriginalInvoice').asinteger:=  OriginalInvoice;
             mInvoiceHeads.FieldByName('RoomGuest').asstring       :=  RoomGuest      ;
             mInvoiceHeads.FieldByName('invRefrence').asstring     :=  invRefrence    ;
             mInvoiceHeads.FieldByName('PayTypes').asstring     := PayTypes  ;
             mInvoiceHeads.FieldByName('PayTypeDescription').asstring     := PayTypeDescription  ;
             mInvoiceHeads.FieldByName('payGroups').asstring     := payGroups  ;
             mInvoiceHeads.FieldByName('payGroupDescription').asstring     := payGroupDescription  ;
          mInvoiceHeads.Post;
        end;


        Item              :=  rSet.FieldByName('Item').asstring  ;
        Quantity          :=  rSet.GetFloatValue(rSet.FieldByName('Quantity')) ; //-96
        Description       :=  rSet.FieldByName('Description').asstring  ;
        Price             :=  rSet.GetFloatValue(rSet.FieldByName('Price'))  ;
        VATType           :=  rSet.FieldByName('VATType').asString  ;
        ilAmountWithTax   :=  LocalFloatValue(rSet.FieldByName('ilAmountWithTax').asString)  ;
        ilAmountNoTax     :=  LocalFloatValue(rSet.FieldByName('ilAmountNoTax').asString)  ;
        ilAmountTax       :=  LocalFloatValue(rSet.FieldByName('ilAmountTax').asString)  ;
        Currency          :=  rSet.FieldByName('Currency').asstring  ;
        CurrencyRate      :=  LocalFloatValue(rSet.FieldByName('CurrencyRate').asString)  ;
        ImportRefrence    :=  rSet.FieldByName('ImportRefrence').asstring  ;
        ImportSource      :=  rSet.FieldByName('ImportSource').asstring  ;


        mInvoiceLines.Insert;
        mInvoiceLines.FieldByName('InvoiceNumber').asinteger  :=  InvoiceNumber  ;
        mInvoiceLines.FieldByName('Item').asstring               :=    Item;
        mInvoiceLines.FieldByName('Quantity').asFloat          :=    Quantity;
        mInvoiceLines.FieldByName('Description').asstring        :=    Description;
        mInvoiceLines.FieldByName('Price').asFloat               :=    Price;
        mInvoiceLines.FieldByName('VATType').asString            :=    VATType;
        mInvoiceLines.FieldByName('AmountWithTax').asFloat     :=    ilAmountWithTax;
        mInvoiceLines.FieldByName('AmountNoTax').asFloat       :=    ilAmountNoTax;
        mInvoiceLines.FieldByName('AmountTax').asFloat         :=    ilAmountTax;
        mInvoiceLines.FieldByName('Currency').asstring           :=    Currency;
        mInvoiceLines.FieldByName('CurrencyRate').asFloat        :=    CurrencyRate;
        mInvoiceLines.FieldByName('ImportRefrence').asstring     :=    ImportRefrence;
        mInvoiceLines.FieldByName('ImportSource').asstring       :=    ImportSource;
        mInvoiceLines.Post;
        rSet.Next
      end;

      rSet2 := ExecutionPlan.Results[1];

      if kbmItems.Active then kbmItems.Close;
      kbmItems.open;
      LoadKbmMemtableFromDataSetQuiet(kbmItems,rSet2,[]);

      kbmItems.SortFields := 'Amount';
      kbmItems.sort([mtcoDescending]);
      kbmItems.First;



    finally
       ExecutionPlan.Free;
    end;
  finally
    screen.cursor := crDefault;
    mInvoiceHeads.enableControls;
    mInvoiceLines.enableControls;
  end;

end;


end.
