unit uInvoiceList;

interface

uses  Windows
    , Messages
    , SysUtils
    , Classes
    , Graphics
    , Controls
    , Forms
    , Dialogs
    , ComCtrls
    , StdCtrls
    , Buttons
    , ExtCtrls
    //FIX wwdbdatetimepicker
    , DB
    , ImgList
    , ADODB
    , DbTables
    , variants
    , _Glob
    , ug
    , uUtils

    , shellapi
    , cxGridExportLink
    , cxGraphics
    , cxControls
    , cxLookAndFeels
    , cxLookAndFeelPainters
    , cxStyles
    , cxCustomData
    , cxFilter
    , cxData
    , cxDataStorage
    , cxEdit
    , cxDBData
    , cxGridCustomTableView
    , cxGridTableView
    , cxGridDBTableView
    , dxmdaset
    , cxGridLevel
    , cxClasses
    , cxGridCustomView
    , cxGrid
    , cxNavigator
    , AdvEdit
    , AdvEdBtn
    , PlannerDatePicker
    , hData
    , cmpRoomerDataSet
    , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxPropertiesStore, sButton, sPageControl, sEdit, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sTooledit, sRadioButton, sLabel, sPanel, sSpeedButton, cxGridBandedTableView, cxGridDBBandedTableView, kbmMemTable, cxCurrencyEdit, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

    ;

type
  TfrmInvoiceList = class(TForm)
    Panel2: TsPanel;
    Panel3: TsPanel;
    RadioButton1: TsRadioButton;
    RadioButton2: TsRadioButton;
    dtFrom: TsDateEdit;
    dtTo: TsDateEdit;
    lblToDate: TsLabel;
    edtInvoiceFrom: TsEdit;
    edtInvoiceTo: TsEdit;
    lblToInvoice: TsLabel;
    RadioButton3: TsRadioButton;
    edtInvoice: TsEdit;
    M_ds: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    StoreMain: TcxPropertiesStore;
    sButton1: TsButton;
    grInvoices: TcxGrid;
    lvInvoices: TcxGridLevel;
    sPanel1: TsPanel;
    btnExcelTurnover: TsButton;
    sButton2: TsButton;
    tvInvoices: TcxGridDBBandedTableView;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    m2_: TkbmMemTable;
    tvInvoicesReservation: TcxGridDBBandedColumn;
    tvInvoicesRoomReservation: TcxGridDBBandedColumn;
    tvInvoicesInvoiceNumber: TcxGridDBBandedColumn;
    tvInvoicesInvoicedate: TcxGridDBBandedColumn;
    tvInvoicesCustomer: TcxGridDBBandedColumn;
    tvInvoicesNameOnInvoice: TcxGridDBBandedColumn;
    tvInvoicesAmount: TcxGridDBBandedColumn;
    tvInvoicesCreditInvoice: TcxGridDBBandedColumn;
    tvInvoicesOriginalInvoice: TcxGridDBBandedColumn;
    tvInvoicesihCurrency: TcxGridDBBandedColumn;
    tvInvoicesihCurrencyRate: TcxGridDBBandedColumn;
    tvInvoicesinvRefrence: TcxGridDBBandedColumn;
    tvInvoicesRoomGuest: TcxGridDBBandedColumn;
    sButton3: TsButton;
    btnInvoiceListReservation: TsButton;
    procedure RadioButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure tvInvoicesAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure FormShow(Sender: TObject);
    procedure getInvoice;
    procedure tvInvoicesCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnExcelTurnoverClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure btnInvoiceListReservationClick(Sender: TObject);
  private
    { Private declarations }
    procedure refresh;
    procedure ApplyFilter;
  public
    { Public declarations }
  end;

var
  frmInvoiceList: TfrmInvoiceList;

implementation

uses
   uFinishedInvoices2
  , uD
  , uSqlDefinitions
  , uAppGlobal
  , uDImages
  , uReservationProfile
  ;

{$R *.DFM}


const
  vWidth  : integer   = 8;
  vDec    : integer   = 2;

procedure TfrmInvoiceList.FormShow(Sender: TObject);
begin
  refresh;
end;

procedure TfrmInvoiceList.RadioButton1Click(Sender: TObject);
begin
  // -- Date edits
   dtFrom.enabled         := RadioButton1.checked;
   dtTo.enabled           := RadioButton1.checked;
   lblToDate.enabled      := RadioButton1.checked;

  // -- Invoice edits
   edtInvoiceFrom.enabled := RadioButton2.checked;
   edtInvoiceTo.enabled   := RadioButton2.checked;
   lblToInvoice.enabled   := RadioButton2.checked;

  // -- Invoice Specific
   edtInvoice.enabled     := RadioButton3.checked;
end;

procedure TfrmInvoiceList.sButton1Click(Sender: TObject);
begin
  refresh;
end;

procedure TfrmInvoiceList.refresh;
var
  rSet : TRoomerDataSet;
  s    : string;

  Number       : integer;
  NameOnInvoice : string;
  InvoiceDate  : Tdate;
  sDate        : string;
  Link         : integer;
  Amount       : Double;

  CreditInvoice  : integer;
  OriginalInvoice : integer;

  InvoiceFrom   : integer;
  InvoiceTo     : integer;
  Invoicenumber : integer;



  medhod : integer;

begin
  invoiceFrom   := strtointdef(edtInvoiceFrom.text,0);
  invoiceTo     := strtointdef(edtInvoiceTo.text,0);
  invoicenumber := strtointdef(edtInvoice.text,0);

  medhod := 0;
  if RadioButton1.checked then
  begin
    medHod := 1;
  end;
  if RadioButton2.checked then
  begin
   medHod := 2;
  end;
  if RadioButton3.checked then
  begin
    medHod := 3;
  end;

  screen.Cursor := crHourGlass;
  rSet := CreateNewDataset;
  try
    s := '';
    s := s+ 'SELECT '+#10;
    s := s+ '  Reservation '+#10;
    s := s+ ', RoomReservation '+#10;
    s := s+ ', InvoiceNumber '+#10;
    s := s+ ', date(InvoiceDate) AS Invoicedate'+#10;
    s := s+ ', Customer '+#10;
    s := s+ ', Name AS NameOnInvoice '+#10;
    s := s+ ', Total AS Amount '+#10;
    s := s+ ', CreditInvoice '+#10;
    s := s+ ', OriginalInvoice '+#10;
    s := s+ ', RoomGuest '+#10;
    s := s+ ', ihCurrency '+#10;
    s := s+ ', ihCurrencyRate '+#10;
    s := s+ ', invRefrence '+#10;
    s := s+ 'FROM invoiceheads '+#10;
    if medhod = 1 then
    begin
      s := s+ ' where (InvoiceDate >= '+_DateToDBDate(dtFrom.Date,true)+') '+#10;      //_DateToDBDate(dtFrom.Date,true) ;
      s := s+ '   and (InvoiceDate <= '+_DateToDBDate(dtTo.Date,true)+') '+#10;      //_DateToDBDate(dtTo.Date,true) ;
      s := s+ '   and (InvoiceNumber > 0) '+#10;
      s := s+ 'Order By InvoiceDate DESC '+#10;
    end else
    if medHod = 2 then
    begin
      s := s+ ' where (InvoiceNumber >= '+_db(InvoiceFrom)+') '+#10; // inttostr( strtointdef( edtInvoiceFrom.text, 0 ) ) ;
      s := s+ '   and (InvoiceNumber <= '+_db(invoiceTo)+') '+#10;  // inttostr( strtointdef( edtInvoiceTo.text, 0 ) ) ;
      s := s+ 'Order By InvoiceNumber DESC '+#10;
    end else
    if medHod = 3 then
    begin
      s := s+ ' where InvoiceNumber = ('+_db(invoicenumber)+') '+#10; //+ inttostr( strtointdef( edtInvoice.text, 0 ) ) ;
    end;

//    copyToClipBoard(s);
//    DebugMessage(s);

    if hData.rSet_bySQL(rSet,s) then
    begin
      m2_.DisableControls;
      try
        if m2_.active then m2_.Close;
        m2_.open;
        LoadKbmMemtableFromDataSetQuiet(m2_,rset,[]);
        m2_.First;
      finally
        m2_.EnableControls;
      end;
    end;
  finally
    freeandnil(rSet);
    screen.Cursor := crDefault;
  end;
end;



procedure TfrmInvoiceList.sButton2Click(Sender: TObject);
begin
  getinvoice;
end;

procedure TfrmInvoiceList.sButton3Click(Sender: TObject);
var
  InvoiceNumber : integer;
begin
  screen.cursor := crHourglass;
  try
   if M2_.RecordCount > 0 then
   begin
     invoiceNumber := M2_.FieldByName('invoicenumber').AsInteger;
     ViewInvoice2(InvoiceNumber,false,false,false,false, '');
   end;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmInvoiceList.getInvoice;
var
  InvoiceNumber : integer;
begin
  screen.cursor := crHourglass;
  try
   if M2_.RecordCount > 0 then
   begin
     invoiceNumber := M2_.FieldByName('invoicenumber').AsInteger;
     ViewInvoice2(InvoiceNumber,false,false,false,false, '');
   end;
  finally
    screen.Cursor := crDefault;
  end;
end;


procedure TfrmInvoiceList.tvInvoicesAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmInvoiceList.tvInvoicesCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  getInvoice;
end;

procedure TfrmInvoiceList.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmInvoiceList.btnExcelTurnoverClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Invoicelistsimple';
  ExportGridToExcel(sFilename, grInvoices, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmInvoiceList.btnInvoiceListReservationClick(Sender: TObject);
var
  iReservation: integer;
  iRoomReservation: integer;
begin
  iReservation := m2_.FieldByName('Reservation').asinteger;
  iRoomReservation := m2_.FieldByName('roomReservation').asinteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
  end;
end;

procedure TfrmInvoiceList.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    tvInvoices.DataController.Filter.Root.Clear;
    tvInvoices.DataController.Filter.Active := false;
  end else
  begin
    applyFilter;
  end;
end;

procedure TfrmInvoiceList.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
   glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  // --
  dtFrom.date := trunc( now )-3;
  dtTo.date := trunc( now );
end;


procedure TfrmInvoiceList.ApplyFilter;
begin
  tvInvoices.DataController.Filter.Options := [fcoCaseInsensitive];
  tvInvoices.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvInvoices.DataController.Filter.Root.Clear;
  tvInvoices.DataController.Filter.Root.AddItem(tvInvoicesihCurrency,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvInvoices.DataController.Filter.Root.AddItem(tvInvoicesNameOnInvoice,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoices.DataController.Filter.Root.AddItem(tvInvoicesRoomGuest,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoices.DataController.Filter.Root.AddItem(tvInvoicesCustomer,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoices.DataController.Filter.Root.AddItem(tvInvoicesinvrefrence,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoices.DataController.Filter.Active := True;
end;



end.

