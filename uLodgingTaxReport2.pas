unit uLodgingTaxReport2;

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
  StdCtrls,
  ExtCtrls,

  dateUtils,
  Menus,
  shellapi,
  DB,
  ADODB,

  _glob,
  hData,
  ug,
  dxCore,
  cxGridExportLink,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxButtons,
  cxPCdxBarPopupMenu,
  cxGroupBox,
  dxStatusBar,
  cxPC,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxDBData,
  cxClasses,
  cxCustomPivotGrid,
  cxDBPivotGrid,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  cxLabel,
  dxmdaset,
  cxPivotGridCustomDataSet,
  cxPivotGridSummaryDataSet,
  cxRadioGroup,
  cxCurrencyEdit,
  cxCalc,
  cxGridChartView,
  cxGridDBChartView,
  cxNavigator,

  ppVar,
  ppCtrls,
  ppPrnabl,
  ppClass,
  ppBands,
  ppCache,
  ppDB,
  ppDesignLayer,
  ppParameter,
  ppDBPipe,
  ppComm,
  ppRelatv,
  ppProd,
  ppReport,
  ppStrtch,
  ppSubRpt,
  ppPageBreak,
  cxCheckBox,

  //fix wwdbdatetimepicker,
  kbmMemTable, AdvEdit, AdvEdBtn, PlannerDatePicker
  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, dxSkinsdxStatusBarPainter, cxPropertiesStore, sLabel, sGroupBox, sCheckBox, sPanel,
  Vcl.ComCtrls, sPageControl, sButton, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, sStatusBar, sComboBox, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue

  ;

type
  TfrmLodgingTaxReport2 = class(TForm)
    pageMain: TsPageControl;
    sheetMain: TsTabSheet;
    dxStatusBar1: TsStatusBar;
    Panel1: TsPanel;
    btnExcelS1: TsButton;
    btnReportS1: TsButton;
    Panel3: TsPanel;
    cxGroupBox1: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    cxGroupBox2: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    mnuFinishedInv : TPopupMenu;
    mnuThisRoom : TMenuItem;
    mnuThisreservation : TMenuItem;
    OpenthisRoom1 : TMenuItem;
    OpenGroupInvoice1 : TMenuItem;
    mInvoiceHeads : TdxMemData;
    mInvoiceHeadsReservation : TIntegerField;
    mInvoiceHeadsCustomer : TWideStringField;
    mInvoiceHeadsName : TWideStringField;
    mInvoiceHeadsTotal : TFloatField;
    mInvoiceHeadsTotalWOVAT : TFloatField;
    mInvoiceHeadsTotalVAT : TFloatField;
    mInvoiceHeadsTotalStayTax : TFloatField;
    mInvoiceHeadsDS : TDataSource;
    tvInvoiceHeads : TcxGridDBTableView;
    lvInvoiceHeads : TcxGridLevel;
    gInvoiceHeads : TcxGrid;
    mInvoiceHeadsRoomReservation : TIntegerField;
    mInvoiceHeadsInvoiceNumber : TIntegerField;
    tvInvoiceHeadsRecId : TcxGridDBColumn;
    tvInvoiceHeadsReservation : TcxGridDBColumn;
    tvInvoiceHeadsRoomReservation : TcxGridDBColumn;
    tvInvoiceHeadsInvoiceNumber : TcxGridDBColumn;
    tvInvoiceHeadsCustomer : TcxGridDBColumn;
    tvInvoiceHeadsName : TcxGridDBColumn;
    tvInvoiceHeadsTotal : TcxGridDBColumn;
    tvInvoiceHeadsTotalWOVAT : TcxGridDBColumn;
    tvInvoiceHeadsTotalVAT : TcxGridDBColumn;
    rptbLodgingtaxList : TppReport;
    dplMinvoiceheads : TppDBPipeline;
    ppParameterList1 : TppParameterList;
    ppDesignLayers1 : TppDesignLayers;
    ppDesignLayer1 : TppDesignLayer;
    ppHeaderBand1 : TppHeaderBand;
    ppDetailBand1 : TppDetailBand;
    ppFooterBand1 : TppFooterBand;
    ppDBText1 : TppDBText;
    ppLabel1 : TppLabel;
    ppLabel3 : TppLabel;
    ppSummaryBand1 : TppSummaryBand;
    ppLabel4 : TppLabel;
    rlabFrom : TppLabel;
    ppLabel6 : TppLabel;
    rLabTo : TppLabel;
    rLabHotelName : TppLabel;
    rLabTimeCreated : TppLabel;
    rlabUser : TppLabel;
    ppLine1 : TppLine;
    ppSystemVariable2 : TppSystemVariable;
    ppLabel2 : TppLabel;
    ppLine3 : TppLine;
    ppLine4 : TppLine;
    ppLine5 : TppLine;
    ppLine6 : TppLine;
    ppLabel5 : TppLabel;
    ppLine7 : TppLine;
    ppLabel7 : TppLabel;
    ppLine8 : TppLine;
    ppLabel8 : TppLabel;
    ppLine9 : TppLine;
    ppLine10 : TppLine;
    rlabttLodgingTax : TppLabel;
    rlabttBilledTax : TppLabel;
    rlabttLodgingNights : TppLabel;
    ppDBText2 : TppDBText;
    ppDBText3 : TppDBText;
    rlabCaption_number : TppLabel;
    ppLine2 : TppLine;
    rlabCaption_date : TppLabel;
    rlabCaption_customer : TppLabel;
    ppDBText4 : TppDBText;
    ppDBText5 : TppDBText;
    ppDBText6 : TppDBText;
    ppDBText7 : TppDBText;
    ppDBText8 : TppDBText;
    ppLine11 : TppLine;
    ppLine12 : TppLine;
    ppDBCalc1 : TppDBCalc;
    ppLabel18 : TppLabel;
    ppLabel19 : TppLabel;
    ppLabel20 : TppLabel;
    ppLabel21 : TppLabel;
    ppLabel22 : TppLabel;
    ppDBCalc2 : TppDBCalc;
    ppDBCalc3 : TppDBCalc;
    ppDBCalc4 : TppDBCalc;
    ppDBCalc5 : TppDBCalc;
    ppDBCalc6 : TppDBCalc;
    ppLabel23 : TppLabel;
    ppLine19 : TppLine;
    ppLine20 : TppLine;
    ppLine22 : TppLine;
    ppLine23 : TppLine;
    ppLine24 : TppLine;
    m: TkbmMemTable;
    chkPageBreak: TsCheckBox;
    ppDBText9: TppDBText;
    ppLabel10: TppLabel;
    StoreMain: TcxPropertiesStore;
    mInvoiceHeadsTotalStayTaxNights: TFloatField;
    tvInvoiceHeadsTotalStayTaxNights: TcxGridDBColumn;
    btnShowReservation: TsButton;
    btnShowGuests: TsButton;
    btnShowInvoice: TsButton;
    mInvoiceHeadstotalStayTaxExcluted: TFloatField;
    tvInvoiceHeadstotalStayTaxExcluted: TcxGridDBColumn;
    mInvoiceHeadsinvoiceDate: TDateTimeField;
    tvInvoiceHeadsinvoiceDate: TcxGridDBColumn;
    tvInvoiceHeadsTotalStayTax: TcxGridDBColumn;
    ppDBText10: TppDBText;
    ppLabel11: TppLabel;
    rlbltotalStayTaxExcluted: TppDBCalc;
    labLocations: TsLabel;
    __labLocationsList: TsLabel;
    mInvoiceHeadsTotalTax: TFloatField;
    tvInvoiceHeadsTotalTax: TcxGridDBColumn;
    procedure FormShow(Sender : TObject);
    procedure btnRefreshClick(Sender : TObject);
    procedure dtDateFromChange(Sender : TObject);
    procedure mRoomsDateCalcFields(DataSet : TDataSet);
    procedure btnShowReservationClick(Sender : TObject);
    procedure btnReportS1Click(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure ppHeaderBand1BeforePrint(Sender : TObject);
    procedure ppSummaryBand1BeforePrint(Sender : TObject);
    procedure tvInvoiceHeadsDblClick(Sender : TObject);
    procedure btnShowGuestsClick(Sender : TObject);
    procedure mnuThisRoomClick(Sender : TObject);
    procedure mnuThisreservationClick(Sender : TObject);
    procedure OpenthisRoom1Click(Sender : TObject);
    procedure OpenGroupInvoice1Click(Sender : TObject);
    procedure btnExcelS1Click(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure tvInvoiceHeadsTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadsTotalWOVATGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadsTotalStayTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadsTotalStayTaxNightsGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure cbxYearCloseUp(Sender: TObject);
    procedure cbxMonthCloseUp(Sender: TObject);
    procedure tvInvoiceHeadsTotalVATGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadstotalStayTaxExclutedGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadsTotalTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zDateFrom : Tdate;
    zDateTo : Tdate;

    zYear : integer;
    zMonth : integer;

    zSetDates : boolean;

    zLocationInString : string;


    ttIncluted : double;
    ttExcluted : double;
    ttNights : integer;

    procedure RefreshAll;
//    procedure sumBilled;
    function getSortField : string;

  public
    { Public declarations }
  end;

var
  frmLodgingTaxReport2 : TfrmLodgingTaxReport2;

implementation

uses
    uD
  , uReservationProfile
  , uFinishedInvoices2
  , uInvoice
  , uGuestProfile2
  , uRptbViewer
  , uSqlDefinitions
  , uAppGlobal
  , uDImages
  , uMain
  ;


{$R *.dfm}

procedure TfrmLodgingTaxReport2.btnExcelS1Click(Sender : TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_LodgingTax';
  try
    ExportGridToExcel(sFilename, gInvoiceHeads, true, true, true,'xls');
    ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
  except
    on e: exception do
    begin
      showMessage('Exporting '+sFilename+' '+e.message);
    end;
  end;
end;

function TfrmLodgingTaxReport2.getSortField : string;
var
  i: Integer;
  AColumn  : TcxGridDBColumn;
  aName : string;
  s : string;
begin
  //
  s := '';
  for i := 0 to tvInvoiceHeads.ColumnCount -1 do
  begin
    aColumn := tvInvoiceHeads.Columns[i];
    aName   := aColumn.DataBinding.FieldName;
    s := aName;
    if aColumn.SortOrder = soNone then
    begin
    end else
    if aColumn.SortOrder = soAscending then
    begin
      s := s+';a';
      result := s;
      exit;
    end else
    if aColumn.SortOrder = soDescending then
    begin
      s := s+';d';
      result := s;
      exit;
    end;
  end;
end;



procedure TfrmLodgingTaxReport2.btnRefreshClick(Sender : TObject);
begin
  RefreshAll;
end;

procedure TfrmLodgingTaxReport2.RefreshAll;
var
  s : string;
  rSet : TRoomerDataSet;
  rCount : integer;
  numGuests : integer;
  sql : string;

  avail_Rooms : integer;
  avail_beds : integer;

  startSQL, stopSQL, elapsedSQL : cardinal;

  startLoop, stopLoop, elapsedLoop : cardinal;

  Reservation : integer;
  RoomReservation : integer;
  InvoiceNumber : integer;
  InvoiceDate : string;
  Customer : string;
  name : string;
  Total : double;
  TotalWOVAT : double;
  TotalVAT : double;
  TotalStayTax : double;
  TotalStayTaxExcluted : double;
  TotalStayTaxNights : integer;
  InvoicedtDate : TdateTime;
  totalTax : double;
  LodgingTaxItem : string;

  inLocation : string;

begin
  inLocation := zLocationInString ;


  ttIncluted := 0.00;
  ttExCluted := 0.00;
  ttNights := 0;

  LodgingTaxItem := ctrlGetString('stayTaxItem'); // 'LODGTAX';

  Sql := '';
sql := sql +    'SELECT '#10;
sql := sql +    '     ih.Reservation '#10;
sql := sql +    '   , ih.RoomReservation '#10;
sql := sql +    '   , ih.InvoiceNumber '#10;
sql := sql +    '   , ih.InvoiceDate '#10;
sql := sql +    '   , ih.Customer '#10;
sql := sql +    '   , ih.Name '#10;
sql := sql +    '   , ih.Total '#10;
sql := sql +    '   , ih.TotalWOVAT '#10;
sql := sql +    '   , ih.TotalVAT '#10;
sql := sql +    '   , ih.TotalStayTax '#10;
sql := sql +    '   , ih.TotalStayTaxNights '#10;
sql := sql +    '   ,(SELECT sum(Total) from invoicelines il where (il.invoicenumber= ih.invoicenumber) and itemID = '+_db(LodgingTaxItem)+') as totalStayTaxExcluted '#10;
sql := sql +    ' FROM '#10;
sql := sql +    '   invoiceheads ih '#10;
sql := sql +    ' WHERE '#10;
sql := sql +    '   (ih.InvoiceNumber > 0) '#10;
sql := sql +    '  AND  (  (ih.InvoiceDate >= %s ) '#10; //_db(zDateFrom)
sql := sql +    '  AND  (ih.InvoiceDate <= %s ) ) '#10;  //_db(zDateTo)
  if inLocation <> '' then
  begin
    sql := sql+'    AND (Location in (%s)) ';
  end;

sql := sql +    ' ORDER BY '#10;
sql := sql +    '   ih.InvoiceNumber ';





  rSet := CreateNewDataSet;
  try
    startSQL := GetTickCount;
    screen.Cursor := crHourGlass;
    mInvoiceHeads.DisableControls;
    try
      s :=  format(sql,[_db(zDateFrom),_db(zDateTo),inLocation]);
      copytoclipboard(s);
      debugmessage(s);

      hData.rSet_bySQL(rSet,s);

      rCount := rSet.RecordCount;
      stopSQL := GetTickCount;
      elapsedSQL := stopSQL - startSQL; // milliseconds
      startLoop := GetTickCount;
      if mInvoiceHeads.Active then
        mInvoiceHeads.Close;

      mInvoiceHeads.open;

      rSet.First;


      while not rSet.Eof do
      begin
        Reservation := rSet.FieldByName('Reservation').Asinteger;
        RoomReservation := rSet.FieldByName('RoomReservation').Asinteger;
        InvoiceNumber := rSet.FieldByName('InvoiceNumber').Asinteger;
        InvoiceDate := rSet.FieldByName('InvoiceDate').AsString;
        Customer := rSet.FieldByName('Customer').Asstring;
        name := rSet.FieldByName('Name').Asstring;

        Total          := LocalFloatValue(rSet.FieldByName('Total').asString);
        TotalWOVAT     := LocalFloatValue(rSet.FieldByName('TotalWOVAT').asString);
        TotalVAT       := LocalFloatValue(rSet.FieldByName('TotalVAT').asString);

        TotalStayTax   := LocalFloatValue(rSet.FieldByName('TotalStayTax').asString);
        TotalStayTaxExcluted   := LocalFloatValue(rSet.FieldByName('TotalStayTaxExcluted').asString);

        TotalStayTaxNights := rSet.FieldByName('TotalStayTaxNights').Asinteger;
        InvoicedtDate := _dbDateTodate(InvoiceDate);

        TotalTax := TotalStayTax+TotalStayTaxExcluted;

        ttIncluted := ttIncluted + TotalStayTax;
        ttExcluted := ttExcluted + TotalStayTaxExcluted;
        ttNights   := ttNights   + TotalStayTaxNights;

        mInvoiceHeads.Append;
        mInvoiceHeads.FieldByName('Reservation').Asinteger := Reservation;
        mInvoiceHeads.FieldByName('RoomReservation').Asinteger := RoomReservation;
        mInvoiceHeads.FieldByName('InvoiceNumber').Asinteger := InvoiceNumber;
        mInvoiceHeads.FieldByName('InvoiceDate').AsDateTime :=InvoicedtDate;
        mInvoiceHeads.FieldByName('Customer').Asstring := Customer;
        mInvoiceHeads.FieldByName('Name').Asstring := name;
        mInvoiceHeads.FieldByName('Total').Asfloat := Total;
        mInvoiceHeads.FieldByName('TotalWOVAT').Asfloat := TotalWOVAT;
        mInvoiceHeads.FieldByName('TotalVAT').Asfloat := TotalVAT;
        mInvoiceHeads.FieldByName('TotalStayTax').Asfloat := TotalStayTax;
        mInvoiceHeads.FieldByName('TotalStayTaxNights').Asfloat := TotalStayTaxNights;
        mInvoiceHeads.FieldByName('totalStayTaxExcluted').Asfloat := TotalStayTaxExcluted;
        mInvoiceHeads.FieldByName('totalStayTaxExcluted').Asfloat := TotalStayTaxExcluted;
        mInvoiceHeads.FieldByName('TotalTax').AsFloat := TotalTax;
        mInvoiceHeads.Post;
        rSet.Next;
      end;

      stopLoop := GetTickCount;
      elapsedLoop := stopLoop - startLoop; // milliseconds
      mInvoiceHeads.First;
    finally
      mInvoiceHeads.EnableControls;
      screen.Cursor := crDefault;
    end;
  finally
    freeandNil(rSet);
  end;
end;

//procedure TfrmLodgingTaxReport2.sumBilled;
//var
//  rSet : TRoomerDataSet;
//
//  s : string;
//  LodgingTaxItem : string;
//
//  InvoiceCount : integer;
//  TotalBilledLodgingTax : double;
//  TotalBilledLodgingTaxWOVAT : double;
//  TotalBilledLodgingTaxVAT : double;
//  TotalBilledLodgingNights : double;  //-96
//  sql : string;
//begin
//
//  ttBilledTax := 0.00;
//  ttBilledNights := 0.00;
//  prBilled := 0.00;
//
//  LodgingTaxItem := ctrlGetString('stayTaxItem'); // 'LODGTAX';
//  InvoiceCount := 0;
//  TotalBilledLodgingTax := 0;
//  TotalBilledLodgingTaxWOVAT := 0;
//  TotalBilledLodgingTaxVAT := 0;
//  TotalBilledLodgingNights := 0.00; //-96
//
//  rSet := CreateNewDataSet;
//  try
//    screen.Cursor := crHourGlass;
//    try
//
//      sql :=
//      ' SELECT '+
//      '      COUNT(invoiceheads.InvoiceNumber) AS InvoiceCount '+
//      '    , invoicelines.ItemID '+
//      '    , SUM(invoicelines.Total) AS TotalBilledLodgingTax '+
//      '    , SUM(invoicelines.TotalWOVat) AS TotalBilledLodgingTaxWOVAT '+
//      '    , SUM(invoicelines.Vat) AS TotalBilledLodgingTaxVAT '+
//      '    , SUM(invoicelines.number) AS TotalBilledLodgingNights '+
//      ' FROM   invoicelines '+
//      '   INNER JOIN invoiceheads ON invoicelines.InvoiceNumber = invoiceheads.InvoiceNumber '+
//      ' WHERE '+
//      ' (  (InvoiceDate >= %s ) '+   //_db(zDateFrom)
//      '  AND  (InvoiceDate <= %s ) '+  //_db(zDateTo)
//      ' AND (invoiceheads.InvoiceNumber > 0)) '+
//      ' GROUP BY '+
//      '    invoicelines.ItemID '+
//      ' HAVING '+
//      '   (invoicelines.ItemID =  %s ) ' ; //_db(LodgingTaxItem)
//
//
//
//      s := format(sql , [_db(zDateFrom),_db(zDateTo),_db(LodgingTaxItem)]);
//      hData.rSet_bySQL(rSet,s);
//
//      if not rSet.Eof then
//      begin
//        InvoiceCount := rSet.FieldByName('InvoiceCount').Asinteger;
//        TotalBilledLodgingTax := LocalFloatValue(rSet.FieldByName('TotalBilledLodgingTax').asString);
//        TotalBilledLodgingTaxWOVAT := LocalFloatValue(rSet.FieldByName('TotalBilledLodgingTaxWOVAT').asString);
//        TotalBilledLodgingTaxVAT := LocalFloatValue(rSet.FieldByName('TotalBilledLodgingTaxVAT').asString);
//        TotalBilledLodgingNights := rSet.FieldByName('TotalBilledLodgingNights').AsFloat;
//      end;
//
//      ttBilledTax := TotalBilledLodgingTax;
//      ttBilledNights := TotalBilledLodgingNights;
//
//      prBilled := 0.00;
//      if ttLodgingTax <> 0 then
//      begin
//        prBilled := (ttBilledTax / ttLodgingTax) * 100;
//      end;
//
//      labttBilledTax.Caption := FloatToStrF(ttBilledTax, ffCurrency, 8, 0);
//      labttBilledNights.Caption := FloatToStrF(ttBilledNights, ffCurrency, 8, 0);  //-96 inttostr(ttBilledNights);
//      labttLodgingTax.Caption := FloatToStrF(ttLodgingTax, ffCurrency, 8, 0);
//      labttLodgingNights.Caption := FloatToStrF(ttNights, ffNumber, 8, 0);
//      labprBilled.Caption := FloatToStrF(prBilled, ffNumber, 4, 2);
//
//    finally
//      screen.Cursor := crDefault;
//    end;
//  finally
//    freeandNil(rSet);
//  end;
//
//end;

procedure TfrmLodgingTaxReport2.tvInvoiceHeadsDblClick(Sender : TObject);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := mInvoiceHeads.FieldByName('InvoiceNumber').Asinteger;
  ViewInvoice2(InvoiceNumber, false, false, false,false, '');
end;

procedure TfrmLodgingTaxReport2.tvInvoiceHeadsTotalGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmLodgingTaxReport2.tvInvoiceHeadstotalStayTaxExclutedGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmLodgingTaxReport2.tvInvoiceHeadsTotalStayTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmLodgingTaxReport2.tvInvoiceHeadsTotalStayTaxNightsGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmLodgingTaxReport2.tvInvoiceHeadsTotalTaxGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmLodgingTaxReport2.tvInvoiceHeadsTotalVATGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
 AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmLodgingTaxReport2.tvInvoiceHeadsTotalWOVATGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmLodgingTaxReport2.cbxMonthCloseUp(Sender: TObject);
var
  y, m, d : word;
  idx : integer;
  lastDay : integer;

begin

  if cbxYear.ItemIndex < 1 then
    exit;
  if cbxMonth.ItemIndex < 1 then
    exit;
  zSetDates := false;
  y := StrToInt(cbxYear.Items[cbxYear.ItemIndex]);
  m := cbxMonth.ItemIndex;

  zDateFrom := encodeDate(y, m, 1);
  lastDay := _DaysPerMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;
end;

procedure TfrmLodgingTaxReport2.cbxYearCloseUp(Sender: TObject);
var
  y, m, d : word;
  idx : integer;
  lastDay : integer;

begin
  if cbxYear.ItemIndex < 1 then
    exit;
  if cbxMonth.ItemIndex < 1 then
    exit;
  zSetDates := false;
  y := StrToInt(cbxYear.Items[cbxYear.ItemIndex]);
  m := cbxMonth.ItemIndex;

  zDateFrom := encodeDate(y, m, 1);
  lastDay := _DaysPerMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;
end;

procedure TfrmLodgingTaxReport2.dtDateFromChange(Sender : TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmLodgingTaxReport2.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
end;

procedure TfrmLodgingTaxReport2.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);
end;

procedure TfrmLodgingTaxReport2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmLodgingTaxReport2.FormShow(Sender : TObject);
var
  y, m, d : word;
  idx : integer;
  lastDay : integer;
  lLocations: TSet_Of_Integer;
begin
  zSetDates := false;

  decodeDate(now, y, m, d);
  zYear := y;
  zMonth := m;
  cbxMonth.ItemIndex := zMonth;

  cbxYear.ItemIndex := cbxYear.Items.IndexOf(inttostr(zYear));

  zDateFrom := encodeDate(y, m, 1);
  lastDay := _DaysPerMonth(y, m);
  zDateTo := encodeDate(y, m, lastDay);
  dtDateFrom.Date := zDateFrom;
  dtDateTo.Date := zDateTo;
  zSetDates := true;

  lLocations := frmmain.FilteredLocations;
  try
  zLocationInString := glb.LocationSQLInString(lLocations);
  finally
    lLocations.Free;
  end;

  if zLocationInString = '' then
  begin
    __labLocationsList.caption := 'All Locations';
  end else
  begin
    __labLocationsList.caption := zLocationInString;
  end;



end;

procedure TfrmLodgingTaxReport2.mRoomsDateCalcFields(DataSet : TDataSet);
var
  dtDate : TdateTime;
  sdate : string;
  y, m, d : word;
  weekNum : word;
begin
  sdate := DataSet.FieldByName('ADate').Asstring;
  dtDate := _dbDateTodate(sdate);
  decodeDate(dtDate, y, m, d);
  weekNum := _weekNum(dtDate);

  DataSet.FieldByName('dtDate').AsDatetime := dtDate;
  DataSet.FieldByName('Year').Asinteger := y;
  DataSet.FieldByName('Month').Asinteger := m;
  DataSet.FieldByName('Day').Asinteger := d;
  DataSet.FieldByName('week').Asinteger := weekNum;
end;

procedure TfrmLodgingTaxReport2.ppHeaderBand1BeforePrint(Sender : TObject);
var
  s : string;
begin
  dateTimeToString(s, 'dd.mm.yyyy', zDateFrom);
  rlabFrom.Caption := s;
  dateTimeToString(s, 'dd.mm.yyyy', zDateTo);
  rlabTo.Caption := s;

  s := g.qHotelName+' - '+__labLocationsList.caption;
  rLabHotelName.Caption := s;

  dateTimeToString(s, 'dd mmm yyyy hh:nn', now);

  s := 'Created : ' + s;
  rLabTimeCreated.Caption := s;

  s := 'User : ' + g.qUser;
  if g.qusername <> '' then
    s := s + ' - ' + g.qusername;
  rlabUser.Caption := s;
end;

procedure TfrmLodgingTaxReport2.ppSummaryBand1BeforePrint(Sender : TObject);
begin
  rlabttBilledTax.Caption     := FloatToStrF(ttExcluted, ffCurrency, 8, 2);
  rlabttLodgingTax.Caption    := FloatToStrF(ttIncluted, ffCurrency, 8, 2);
  rlabttLodgingNights.Caption := inttostr(ttNights);
end;

procedure TfrmLodgingTaxReport2.btnReportS1Click(Sender : TObject);
var
  aReport      : TppReport;
  sFilter      : string;
  s            : string;
  sortfield    : string;
  isDescending : boolean;
  sTmp         : string;
begin
  if mInvoiceHeads.RecordCount = 0 then
    exit;

  sFilter := tvInvoiceHeads.DataController.Filter.FilterText;
  if m.Active then m.Close;
  m.LoadFromDataSet(tvInvoiceHeads.DataController.DataSource.DataSet,[mtcpoStructure]);

//  LoadKbmMemtableFromDataSetQuiet(m,tvInvoiceHeads.DataController.DataSource.DataSet,[mtcpoStructure]);

  m.Filtered := false;

  if sFilter <> '' then
  begin
    m.Filter := sFilter ;
    m.Filtered := true;
    m.First;
  end;

  s := getSortField;
  sortfield := 'invoicenumber';
  isDescending := false;

  if s <> '' then
  begin
    sortfield := _strTokenAt(S,';',0);
    isDescending := (_strTokenAt(S,';',1) = 'd');
  end;

  m.SortFields := sortfield;
  if not isDescending then
  begin
    m.sort([]);
  end else
  begin
    m.sort([mtcoDescending]);
  end;

  ppSummaryBand1.NewPage := chkPageBreak.Checked;

  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
  frmRptbViewer.show;

  screen.Cursor := crHourglass;
  try
    aReport := rptbLodgingtaxList;
    frmRptbViewer.ppViewer1.Reset;
    frmRptbViewer.ppViewer1.Report := aReport;
    frmRptbViewer.ppViewer1.GotoPage(1);
    aReport.PrintToDevices;
  finally
    screen.Cursor := crDefault;
  end;
end;

// -------------------------------------------------------------------------------
//
// Buttons
//
//
// --------------------------------------------------------------------------------

procedure TfrmLodgingTaxReport2.btnShowReservationClick(Sender : TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  if mInvoiceHeads.RecordCount = 0 then
    exit;

  iReservation := mInvoiceHeads.FieldByName('Reservation').Asinteger;
  iRoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;

  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **--
  end;
end;

procedure TfrmLodgingTaxReport2.btnShowGuestsClick(Sender : TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  sName : string;
  theData : recPersonHolder;
begin
  if mInvoiceHeads.RecordCount = 0 then
    exit;

  iReservation := mInvoiceHeads.FieldByName('Reservation').Asinteger;
  iRoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;
  sName := '';

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := sName;
  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;


// *************************

procedure TfrmLodgingTaxReport2.mnuThisreservationClick(Sender : TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  sName : string;
begin
  if mInvoiceHeads.RecordCount = 0 then
    exit;

  iReservation := mInvoiceHeads.FieldByName('Reservation').Asinteger;
  iRoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;

  ShowFinishedInvoices2(itPerReservation, '', iReservation);
end;

procedure TfrmLodgingTaxReport2.mnuThisRoomClick(Sender : TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  sName : string;
begin
  if mInvoiceHeads.RecordCount = 0 then
    exit;

  iReservation := mInvoiceHeads.FieldByName('Reservation').Asinteger;
  iRoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;

  ShowFinishedInvoices2(itPerRoomRes, '', iRoomReservation);
end;

procedure TfrmLodgingTaxReport2.OpenGroupInvoice1Click(Sender : TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  sName : string;
begin
  if mInvoiceHeads.RecordCount = 0 then
    exit;

  iReservation := mInvoiceHeads.FieldByName('Reservation').Asinteger;
  iRoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;
  EditInvoice(iReservation, 0, 0, 0, 0, 0, false, true,false);
end;

procedure TfrmLodgingTaxReport2.OpenthisRoom1Click(Sender : TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  sName : string;
begin
  if mInvoiceHeads.RecordCount = 0 then
    exit;

  iReservation := mInvoiceHeads.FieldByName('Reservation').Asinteger;
  iRoomReservation := mInvoiceHeads.FieldByName('RoomReservation').Asinteger; ;
  EditInvoice(iReservation, iRoomReservation, 0, 0, 0, 0, false, true,false);
end;

// -------------------------------------------------------------------------------
//
// Buttons
//
//
// --------------------------------------------------------------------------------

end.
