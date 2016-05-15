unit uRptCustInvoices;

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
  , cxLookAndFeelPainters
  , dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinsdxStatusBarPainter, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxCurrencyEdit, dxmdaset, Vcl.ComCtrls, sPageControl, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, AdvEdit, AdvEdBtn, dxStatusBar, sSplitter, Vcl.Buttons, sSpeedButton, sEdit, sLabel, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue
  ;

type
  TfrmRptCustInvoices = class(TForm)
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
    tvTotalCustomer: TcxGridDBColumn;
    tvTotalTotalAmount: TcxGridDBColumn;
    tvTotalInvoiceCount: TcxGridDBColumn;
    tvTotalCustomerName: TcxGridDBColumn;
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
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
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
    procedure btnClearClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    zDateFrom : Tdate;
    zDateTo   : Tdate;
    zYear     : integer;
    zMonth    : integer;
    zSetDates : boolean;

    procedure GetPaymentsTypes(rSet : TRoomerDataSet; invoiceNumber : integer; var PayTypes, PayTypeDescription, payGroups, payGroupDescription : string);
    procedure getCustInvoices(invoicelist:string);
    procedure ApplyFilter;
    procedure ShowData;
    function GetInvoicelist(customer : string) : string;
    procedure showdata2;
    procedure refresh;
  public
    { Public declarations }
  end;

function RptCustInvoices : boolean;

var
  frmRptCustInvoices: TfrmRptCustInvoices;

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
  PrjConst,
  uRoomerLanguage

  , uDImages;

function RptCustInvoices : boolean;
begin
  result := false;
  frmRptCustInvoices := TfrmRptCustInvoices.Create(frmRptCustInvoices);
  try
    frmRptCustInvoices.ShowModal;
    if frmRptCustInvoices.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmRptCustInvoices);
  end;
end;


procedure TfrmRptCustInvoices.ShowData;
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


procedure TfrmRptCustInvoices.splitLeftDblClick(Sender: TObject);
begin
  if (spanel1.width < 30) then spanel1.width := 400 else spanel1.width := 20;
  Invalidate;
  Update;
end;

procedure TfrmRptCustInvoices.tvTotalCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  showdata2;
end;

procedure TfrmRptCustInvoices.tvTotalCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  //**
end;

procedure TfrmRptCustInvoices.showdata2;
var
  customer : string;
  invoicelist : string;
begin
  customer := kbmTotal.FieldByName('customer').asString;
  invoicelist := GetInvoicelist(customer);
  getCustInvoices(invoicelist);
end;


procedure TfrmRptCustInvoices.tvTotalTotalAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmRptCustInvoices.btnClearClick(Sender: TObject);
begin
  edfilter.text := '';
end;

procedure TfrmRptCustInvoices.btnGuestsExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  if kbmTotal.RecordCount = 0 then exit;

  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_CustomerInvoices';
  ExportGridToExcel(sFilename, grTotal {grGroupInvoiceSums}, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptCustInvoices.btnInvoiceInvoicelinesClick(Sender: TObject);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := mInvoiceHeads.fieldbyname('InvoiceNumber').AsInteger;
  ViewInvoice2(InvoiceNumber, false, false, false,false, '');
end;

procedure TfrmRptCustInvoices.btnRefreshClick(Sender: TObject);
begin
  refresh;
end;

procedure TfrmRptCustInvoices.refresh;
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
begin
    mInvoiceHeads.Close;
    mInvoiceHeads.open;

    kbmItems.Close;
    kbmItems.open;

    ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try
    startTick := GetTickCount;
//
    s := s+'SELECT '#10;
    s := s+'   sum(ih.total) AS TotalAmount '#10;
    s := s+'  ,count(ih.id) AS InvoiceCount '#10;
    s := s+'  ,ih.customer '#10;
    s := s+'  , cust.surName AS CustomerName '#10;
//    s := s+'  ,group_concat(ih.invoicenumber) AS invoicelist '#10;
    s := s+'FROM '#10;
    s := s+'  invoiceheads ih '#10;
    s := s+'   LEFT JOIN customers cust ON ih.customer = cust.customer '#10;
    s := s+'WHERE (invoicenumber > 0) '#10;
    s := s+'   AND (InvoiceDate >= '+_dateToSqlDate(zDateFrom)+') '#10;
    s := s+'   AND (InvoiceDate <= '+_dateToSqlDate(zDateTO)+') '#10;
    s := s+'GROUP BY '#10;
    s := s+'  Customer '#10;

//    copytoclipboard(s);
//    debugmessage(s);

    ExecutionPlan.AddQuery(s);
    //////////////////// Execute!

    screen.Cursor := crHourGlass;
    kbmTotal.DisableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      //////////////////// RoomsDate
      rSet1 := ExecutionPlan.Results[0];

      if kbmTotal.Active then kbmTotal.Close;
      kbmTotal.open;
      LoadKbmMemtableFromDataSetQuiet(kbmTotal,rSet1,[]);

      kbmTotal.SortFields := 'TotalAmount';
      kbmTotal.sort([mtcoDescending]);
      kbmTotal.First;
    finally
      screen.cursor := crDefault;
      if kbmtotal.RecordCount > 0 then showdata2;

      kbmTotal.EnableControls;
    end;

    stopTick         := GetTickCount;
    SQLms            := stopTick - startTick;
//    sLabTime.Caption := inttostr(SQLms);
  finally
    ExecutionPlan.Free;
  end;
end;


procedure TfrmRptCustInvoices.btnShowReservationClick(Sender: TObject);
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

procedure TfrmRptCustInvoices.btnToExcelClick(Sender: TObject);
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

function TfrmRptCustInvoices.GetInvoicelist(customer : string) : string;
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
      s := s+'WHERE (invoicenumber > 0) '#10;
      s := s+'   AND (InvoiceDate >= '+_dateToSqlDate(zDateFrom)+') '#10;
      s := s+'   AND (InvoiceDate <= '+_dateToSqlDate(zDateTO)+') '#10;
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


procedure TfrmRptCustInvoices.cbxMonthCloseUp(Sender: TObject);
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

procedure TfrmRptCustInvoices.dtDateFromChange(Sender: TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmRptCustInvoices.edFilterChange(Sender: TObject);
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

procedure TfrmRptCustInvoices.edFilterClickBtn(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRptCustInvoices.ApplyFilter;
begin
  tvTotal.DataController.Filter.Options := [fcoCaseInsensitive];
  tvTotal.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvTotal.DataController.Filter.Root.Clear;
  tvTotal.DataController.Filter.Root.AddItem(tvTotalCustomer,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvTotal.DataController.Filter.Root.AddItem(tvTotalCustomername,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvTotal.DataController.Filter.Active := True;
end;


procedure TfrmRptCustInvoices.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**
end;

procedure TfrmRptCustInvoices.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);
end;

procedure TfrmRptCustInvoices.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmRptCustInvoices.FormShow(Sender: TObject);
begin
  //**
  showdata;
  refresh;
end;


procedure TfrmRptCustInvoices.GetPaymentsTypes(rSet : TRoomerDataSet; invoiceNumber : integer; var PayTypes, PayTypeDescription, payGroups, payGroupDescription : string);
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


procedure TfrmRptCustInvoices.btnGetDataClick(Sender: TObject);
begin
  showdata2;
end;

procedure TfrmRptCustInvoices.sButton4Click(Sender: TObject);
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

procedure TfrmRptCustInvoices.getCustInvoices(invoicelist:string);
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
