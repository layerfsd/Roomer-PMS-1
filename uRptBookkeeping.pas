unit uRptBookkeeping;

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
  , math


  , kbmMemTable
  ,cmpRoomerDataSet
  ,cmpRoomerConnection

  , _glob
  , ug
  , hData
  , uUtils
  , uAppGlobal


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
  , dxSkinsCore, cxStyles, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxCalc, cxCurrencyEdit,
  cxPropertiesStore, AdvChartPaneEditor, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGridDBTableView, cxGrid, Vcl.ComCtrls,
  sPageControl, sStatusBar, sCheckBox, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, sLabel, dxmdaset, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  AdvUtil

  ;

type
  TfrmRptBookkeeping = class(TForm)
    Panel3: TsPanel;
    cxGroupBox2: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    btnRefresh: TsButton;
    gbxSelectDates: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    sStatusBar1: TsStatusBar;
    kbmStat: TdxMemData;
    StatDS: TDataSource;
    pageMain: TsPageControl;
    tabStatGrid: TsTabSheet;
    sPanel1: TsPanel;
    btnGuestsExcel: TsButton;
    sButton1: TsButton;
    FormStore: TcxPropertiesStore;
    sLabel1: TsLabel;
    cbxQuery: TsComboBox;
    kbmStatCustomerId: TWideStringField;
    kbmStatCustomerName: TWideStringField;
    kbmStatInvoiceNumber: TIntegerField;
    kbmStatInvoiceDate: TDateField;
    kbmStatAccountNumber: TWideStringField;
    kbmStatTransactionDescription: TWideStringField;
    kbmStatTotalExclusive: TFloatField;
    kbmStatVat: TFloatField;
    grReport: TAdvStringGrid;
    cbIncludeTotals: TsCheckBox;
    dlgSave: TFileSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtDateFromChange(Sender: TObject);
    procedure cbxMonthCloseUp(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnGuestsExcelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxQueryCloseUp(Sender: TObject);
    procedure grReportGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure grReportGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure sButton1Click(Sender: TObject);
  private
    { Private declarations }

    bookingDataSet : TRoomerDataset;

    zDateFrom : Tdate;
    zDateTo   : Tdate;
    zYear     : integer;
    zMonth    : integer;
    zSetDates : boolean;


    procedure ShowData;
  public
    { Public declarations }
  end;

function RptBookkeeping : boolean;

var
  frmRptBookkeeping: TfrmRptBookkeeping;

implementation

{$R *.dfm}

uses
  uD,
  uRoomerLanguage,
  uDimages,
  uFrmResources,
  uDateUtils,
  PrjConst,
  uGridUtils;

CONST FINANCE_QUERY = 'SELECT cu.Customer AS CustomerId, cu.Surname AS CustomerName, ' +
                      'il.InvoiceNumber AS InvoiceNumber, ' +
                      'DATE(ih.InvoiceDate) AS InvoiceDate, ' +
                      'bc.Code AS AccountNumber, ' +
                      'bc.description AS TransactionDescription, ' +
                      'ROUND(SUM(il.TotalWOVat), 2) AS TotalExclusive, ' +
                      'bc.txStatus AS SalesTransactionType, ' +
                      'bc.bookOnCustomer AS BookOnCustomer ' +
                      'FROM invoicelines il ' +
                      'INNER JOIN currencies c ON c.Currency=il.Currency ' +
                      'INNER JOIN invoiceheads ih ON ih.InvoiceNumber=il.InvoiceNumber ' +
                      'INNER JOIN customers cu ON cu.Customer=ih.Customer ' +
                      'INNER JOIN items it ON it.Item=il.ItemId ' +
                      'INNER JOIN bookkeepingcodes bc ON bc.Code=it.BookKeepCode ' +
                      'INNER JOIN vatcodes vc ON vc.VATCode=il.VATType ' +
                      'WHERE ih.InvoiceDate >= ''[FromDate]'' AND ih.InvoiceDate <= ''[ToDate]'' ' +
                      'AND ih.InvoiceNumber > 0 ' +
                      'GROUP BY il.InvoiceNumber, bc.Code ' +

                      'UNION ' +

                      'SELECT cu.Customer, cu.Surname, ' +
                      'il.InvoiceNumber, ' +
                      'DATE(ih.InvoiceDate) AS ADate1, ' +
                      'bc.Code, ' +
                      'bc.description, ' +
                      'ROUND(SUM(il.Vat), 2) AS AAmount1, ' +
                      'bc.txStatus, ' +
                      'bc.bookOnCustomer ' +
                      'FROM invoicelines il ' +
                      'INNER JOIN currencies c ON c.Currency=il.Currency ' +
                      'INNER JOIN invoiceheads ih ON ih.InvoiceNumber=il.InvoiceNumber ' +
                      'INNER JOIN customers cu ON cu.Customer=ih.Customer ' +
                      'INNER JOIN items it ON it.Item=il.ItemId ' +
                      'INNER JOIN vatcodes vc ON vc.VATCode=il.VATType ' +
                      'INNER JOIN bookkeepingcodes bc ON bc.Code=vc.BookKeepCode ' +
                      'WHERE ih.InvoiceDate >= ''[FromDate]'' AND ih.InvoiceDate <= ''[ToDate]'' ' +
                      'AND ih.InvoiceNumber > 0 ' +
                      'GROUP BY il.InvoiceNumber, bc.Code ' +

                      'UNION ' +

                      'SELECT cu.Customer, cu.Surname, ' +
                      'pa.InvoiceNumber, ' +
                      'DATE(pa.PayDate) AS ADate1, ' +
                      'bc.Code, ' +
                      'bc.description, ' +
                      'ROUND(SUM(Amount), 2) AS AAmount1, ' +
                      'bc.txStatus, ' +
                      'bc.bookOnCustomer ' +
                      'FROM payments pa ' +
                      'INNER JOIN currencies c ON c.Currency=pa.Currency ' +
                      'INNER JOIN invoiceheads ih ON ih.InvoiceNumber=pa.InvoiceNumber ' +
                      'INNER JOIN customers cu ON cu.Customer=ih.Customer ' +
                      'INNER JOIN paytypes pt ON pt.PayType=pa.PayType ' +
                      'INNER JOIN bookkeepingcodes bc ON bc.Code=pt.BookKeepCode ' +
                      'WHERE ih.InvoiceDate >= ''[FromDate]'' AND ih.InvoiceDate <= ''[ToDate]'' ' +
                      'AND ih.InvoiceNumber > 0 ' +
                      'GROUP BY pa.InvoiceNumber, bc.Code ' +

                      'ORDER BY InvoiceNumber, AccountNumber';

function RptBookkeeping : boolean;
begin
  result := false;
  frmRptBookkeeping := TfrmRptBookkeeping.Create(frmRptBookkeeping);
  try
    frmRptBookkeeping.ShowModal;
    if frmRptBookkeeping.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmRptBookkeeping);
  end;
end;

procedure TfrmRptBookkeeping.ShowData;
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


procedure TfrmRptBookkeeping.btnGuestsExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_BookKeepData' + '.xls';
//  ExportGridToExcel(sFilename, grStat {grGroupInvoiceSums}, true, true, true);
  if SaveAsExcelFile(grReport, sFilename) then
    ShellExecute(Handle, 'OPEN', PChar(sFilename), nil, nil, sw_shownormal);
end;


procedure TfrmRptBookkeeping.btnRefreshClick(Sender: TObject);
var Strings : TStrings;
//    Subject,
    s : String;

    subTotalDebet,
    subTotalCredit,
    totalDebet,
    totalCredit : Double;

    lastInvoice : Integer;

    procedure SubTotal;
    begin
      if NOT cbIncludeTotals.Checked then exit;

      grReport.RowCount := grReport.RowCount + 1;
      grReport.Cells[6, grReport.RowCount - 1] := '============';
      grReport.Cells[7, grReport.RowCount - 1] := '============';

      grReport.RowCount := grReport.RowCount + 1;
      grReport.Cells[5, grReport.RowCount - 1] := GetTranslatedText('shUI_BookKeepReortSubtotal');
      grReport.Cells[6, grReport.RowCount - 1] := trim(_floattostr(subTotalDebet, 12, 2));
      grReport.Cells[7, grReport.RowCount - 1] := trim(_floattostr(subTotalCredit, 12, 2));

      subTotalDebet := 0.00;
      subTotalCredit := 0.00;
      lastInvoice := bookingDataSet['InvoiceNumber'];
      grReport.RowCount := grReport.RowCount + 1;
    end;
    procedure Total;
    begin
      if NOT cbIncludeTotals.Checked then exit;
      grReport.RowCount := grReport.RowCount + 1;
      grReport.Cells[6, grReport.RowCount - 1] := '============';
      grReport.Cells[7, grReport.RowCount - 1] := '============';

      grReport.RowCount := grReport.RowCount + 1;
      grReport.Cells[5, grReport.RowCount - 1] := GetTranslatedText('shUI_BookKeepReortTotal');
      grReport.Cells[6, grReport.RowCount - 1] := trim(_floattostr(totalDebet, 12, 2));
      grReport.Cells[7, grReport.RowCount - 1] := trim(_floattostr(totalCredit, 12, 2));
    end;

begin
//  if cbxQuery.ItemIndex < 0 then exit;

  grReport.ClearRows(1, grReport.RowCount - 1);
  grReport.RowCount := 1;

  subTotalDebet := 0.00;
  subTotalCredit := 0.00;
  totalDebet := 0.00;
  totalCredit := 0.00;
  lastInvoice := 0;

  grReport.ColWidths[0] := 100;
  grReport.ColWidths[1] := 200;
  grReport.ColWidths[2] := 100;
  grReport.ColWidths[3] := 100;
  grReport.ColWidths[4] := 150;
  grReport.ColWidths[5] := 200;
  grReport.ColWidths[6] := 100;
  grReport.ColWidths[7] := 100;

  screen.Cursor := crHourGlass;
  try
    try
    Strings := TStringList.Create;
    try
//      Strings.LoadFromFile(DownloadResourceByName(HOTEL_SQL_RESOURCE, cbxQuery.Items[cbxQuery.ItemIndex], Subject));
      Strings.Text := FINANCE_QUERY;
      s := StringReplace(Strings.Text, '[FromDate]', DateToSqlString(dtDateFrom.Date), [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, '[ToDate]', DateToSqlString(dtDateTo.Date), [rfReplaceAll, rfIgnoreCase]);
      CopyToClipboard(s);
      if hData.rSet_bySQL(bookingDataSet, s) then
      begin
        bookingDataSet.First;
        if NOT bookingDataSet.Eof then
          lastInvoice := bookingDataSet['InvoiceNumber'];
        while NOT bookingDataSet.Eof do
        begin
          if (lastInvoice <> bookingDataSet['InvoiceNumber']) then
          begin
            SubTotal;
          end;


          grReport.RowCount := grReport.RowCount + 1;
          grReport.Cells[0, grReport.RowCount - 1] := bookingDataSet['CustomerId'];
          grReport.Cells[1, grReport.RowCount - 1] := bookingDataSet['CustomerName'];
          grReport.Cells[2, grReport.RowCount - 1] := bookingDataSet['InvoiceNumber'];
          grReport.Cells[3, grReport.RowCount - 1] := DateToSqlString(bookingDataSet['InvoiceDate']);
          grReport.Cells[4, grReport.RowCount - 1] := bookingDataSet['AccountNumber'];
          grReport.Cells[5, grReport.RowCount - 1] := bookingDataSet['TransactionDescription'];
          if bookingDataSet['SalesTransactionType'] = 'DEBET' then
          begin
            subTotalDebet := subTotalDebet + bookingDataSet['TotalExclusive'];
            totalDebet := totalDebet + bookingDataSet['TotalExclusive'];
            grReport.Cells[6, grReport.RowCount - 1] := trim(_floattostr(bookingDataSet['TotalExclusive'], 12, 2))
          end else
          begin
            subTotalCredit := subTotalCredit + bookingDataSet['TotalExclusive'];
            totalCredit := totalCredit + bookingDataSet['TotalExclusive'];
            grReport.Cells[7, grReport.RowCount - 1] := trim(_floattostr(bookingDataSet['TotalExclusive'], 12, 2));
          end;

          bookingDataSet.Next;
        end;
        SubTotal;
        Total;
      end;
    finally
      Strings.Free;
    end;
    finally
    end;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmRptBookkeeping.cbxMonthCloseUp(Sender: TObject);
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

procedure TfrmRptBookkeeping.cbxQueryCloseUp(Sender: TObject);
begin
//  btnRefresh.Enabled := cbxQuery.ItemIndex >= 0;
end;

procedure TfrmRptBookkeeping.dtDateFromChange(Sender: TObject);
begin
  if zSetDates then
  begin
    zDateFrom := dtDateFrom.Date;
    zDateTo := dtDateTo.Date;

    cbxYear.ItemIndex := 0;
    cbxMonth.ItemIndex := 0;
  end;
end;

procedure TfrmRptBookkeeping.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**
end;

procedure TfrmRptBookkeeping.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  glb.fillListWithMonthsLong(cbxMonth.Items, 1);
  glb.fillListWithYears(cbxYear.Items, 1, False);
  bookingDataSet := CreateNewDataset;
//  cbxQuery.Items.Clear;
//  cbxQuery.Items.AddStrings(StaticResourceList(HOTEL_SQL_RESOURCE));

  grReport.RowCount := 1;
  grReport.ColCount := 8;

  grReport.Cells[0, 0] := GetTranslatedText('shUI_BookKeepReortCustomerID');
  grReport.Cells[1, 0] := GetTranslatedText('shUI_BookKeepReortCustomerID');
  grReport.Cells[2, 0] := GetTranslatedText('shUI_BookKeepReortInvoice');
  grReport.Cells[3, 0] := GetTranslatedText('shUI_BookKeepReortDate');
  grReport.Cells[4, 0] := GetTranslatedText('shUI_BookKeepReortAccount');
  grReport.Cells[5, 0] := GetTranslatedText('shUI_BookKeepReortDescription');
  grReport.Cells[6, 0] := GetTranslatedText('shUI_BookKeepReortDebet');
  grReport.Cells[7, 0] := GetTranslatedText('shUI_BookKeepReortCredit');

end;

procedure TfrmRptBookkeeping.FormDestroy(Sender: TObject);
begin
  FreeAndNil(bookingDataSet);
end;

procedure TfrmRptBookkeeping.FormShow(Sender: TObject);
begin
  //**
  _restoreForm(frmRptBookkeeping);
  showdata;
//  btnRefresh.Enabled := False;
end;

procedure TfrmRptBookkeeping.grReportGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol IN [6,7] then
    HAlign := taRightJustify;
end;

procedure TfrmRptBookkeeping.grReportGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if ARow = 0 then
    ABrush.Color := clSilver;
end;

procedure TfrmRptBookkeeping.sButton1Click(Sender: TObject);
var Strings : TStringList;
    s : String;
    i, j : Integer;
begin
  //
   if dlgSave.Execute then
   begin
     Strings := TStringList.Create;
     try
       for j := 0 to grReport.RowCount - 1 do
       begin
         s := '';
         for i := 0 to grReport.ColCount - 1 do
         begin
           if s = '' then
             s := grReport.Cells[i, j]
           else
             s := s + Strings.Delimiter + grReport.Cells[i, j];
         end;
         Strings.Add(s);
       end;
       Strings.SaveToFile(dlgSave.FileName);
       ShellExecute(Handle, 'OPEN', PChar(dlgSave.FileName), nil, nil, sw_shownormal);
     finally
       Strings.Free;
     end;
   end;
end;

end.

