unit uRptDailyRevenues;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sEdit, sButton, Vcl.Buttons, sSpeedButton, sLabel, Vcl.ExtCtrls,
  sPanel, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxTextEdit, cxDropDownEdit, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers,
  dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, dxPSCore, dxPScxCommon, dxmdaset, cxPropertiesStore, Vcl.Menus,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  Vcl.ComCtrls, sStatusBar, sCheckBox, cxCalendar
  , cmpRoomerDataset, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit
  , uRoomerForm, dxSkinsdxStatusBarPainter, dxStatusBar, sGroupBox, sRadioButton, uCurrencyHandler, sSplitter,
  dxPScxPivotGridLnk
  ;

type
  TfrmRptDailyRevenues = class(TfrmBaseRoomerForm)
    pnlHolder: TsPanel;
    m_Payments: TdxMemData;
    dsPayments: TDataSource;
    pnlFilter: TsPanel;
    pnlExportButtons: TsPanel;
    btnExcel: TsButton;
    btnPrintGrid: TsButton;
    gbxSelection: TsGroupBox;
    lblFromDate: TsLabel;
    dtFromDate: TsDateEdit;
    btnRefresh: TsButton;
    lblTodate: TsLabel;
    dtToDate: TsDateEdit;
    rbYesterday: TsRadioButton;
    rbOther: TsRadioButton;
    gridPrinter: TdxComponentPrinter;
    grdPrinterLinkPayments: TdxGridReportLink;
    m_PaymentsDate: TDateField;
    m_Paymentspaytype: TWideStringField;
    m_Paymentsdescription: TWideStringField;
    m_PaymentsTotalAmount: TFloatField;
    dsRevenues: TDataSource;
    m_Revenues: TdxMemData;
    m_RevenuesRevenuedate: TDateField;
    m_Revenuesdescription: TWideStringField;
    m_Revenuesitemtype: TWideStringField;
    m_Revenuesvattype: TWideStringField;
    m_Revenuestotalamount: TFloatField;
    m_Revenuestotalwovat: TFloatField;
    m_Revenuestotalvat: TFloatField;
    pnlLeft: TsPanel;
    pnlRight: TsPanel;
    grDataPayments: TcxGrid;
    tvPayments: TcxGridDBTableView;
    tvPaymentsDate: TcxGridDBColumn;
    tvPaymentspaytype: TcxGridDBColumn;
    tvPaymentsdescription: TcxGridDBColumn;
    tvPaymentsTotalAmount: TcxGridDBColumn;
    tvRevenues: TcxGridDBTableView;
    tvRevenuesdate: TcxGridDBColumn;
    tvRevenuesitemtype: TcxGridDBColumn;
    tvRevenuesdescription: TcxGridDBColumn;
    tvRevenuesvattype: TcxGridDBColumn;
    tvRevenuestotalamount: TcxGridDBColumn;
    tvRevenuestotalwovat: TcxGridDBColumn;
    tvRevenuestotalvat: TcxGridDBColumn;
    lvPayments: TcxGridLevel;
    lvRevenues: TcxGridLevel;
    grDataRevenues: TcxGrid;
    sSplitter1: TsSplitter;
    grdPrinterLinkRevenues: TdxGridReportLink;
    grdPrinterLinkAll: TdxCompositionReportLink;
    sSplitter2: TsSplitter;
    grBalance: TcxGrid;
    tvBalance: TcxGridDBTableView;
    lvBalance: TcxGridLevel;
    m_Balance: TdxMemData;
    m_BalanceRevenueDate: TDateField;
    dsBalance: TDataSource;
    m_Balancetotalrevenues: TFloatField;
    m_Balancetotalpayments: TFloatField;
    tvBalancerevenuedate: TcxGridDBColumn;
    tvBalancetotalrevenues: TcxGridDBColumn;
    tvBalancetotalpayments: TcxGridDBColumn;
    m_Balancebalance: TFloatField;
    tvBalancebalance: TcxGridDBColumn;
    gridPrinterLinkBalance: TdxGridReportLink;
    btnCloseCurrentDay: TsButton;
    procedure btnRefreshClick(Sender: TObject);
    procedure btnPrintGridClick(Sender: TObject);
    procedure rbPresetDateClick(Sender: TObject);
    procedure tvPaymentsTotalAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure m_BalanceCalcFields(DataSet: TDataSet);
    procedure btnExcelClick(Sender: TObject);
    procedure btnCloseCurrentDayClick(Sender: TObject);
  private
    FRefreshingData: Boolean;
    FRecordSet: TRoomerDataSet;
    FCurrencyhandler: TCurrencyHandler;
    procedure ShowError(const aOperation: string);
    procedure UpdateBalanceData;
    procedure SetSummaryDisplayFormat(aView: TcxGridDBTableView; const aFormat: string);
    { Private declarations }
  protected
    procedure DoLoadData; override;
    procedure UpdateControls; override;
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
  end;


procedure ShowDailyRevenuesReport;

implementation

{$R *.dfm}

uses
  uDateTimeHelper
  , DateUtils
  , uAppGlobal
  , uUtils
  , hData
  , cxGridExportLink
  , ShellAPI
  , UITypes
  , uG
  , PrjConst
  , _Glob
  , uD
  , uFinancialReportsAPICaller
  , cxEditRepositoryItems
  , Math
  , uDayClosingTimesAPICaller;

procedure ShowDailyRevenuesReport;
begin
  with TfrmRptDailyRevenues.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmRptDailyRevenues.btnCloseCurrentDayClick(Sender: TObject);
var
  lCaller: TDayClosingTimesAPICaller;
begin
  lCaller := TDayClosingTimesAPICaller.Create;
  try
    lCaller.CloseRunningDayGuarded;
  finally
    lCaller.Free;
  end;
end;

procedure TfrmRptDailyRevenues.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Payments';
  ExportGridToExcel(sFilename, grDataPayments, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);

  sFilename := g.qProgramPath + s + '_Revenues';
  ExportGridToExcel(sFilename, grDataRevenues, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);

  sFilename := g.qProgramPath + s + '_Balance';
  ExportGridToExcel(sFilename, grBalance, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptDailyRevenues.btnPrintGridClick(Sender: TObject);
var
  lTitle: string;
begin
  lTitle := Format('%s - %s to %s', [Caption, dtFromDate.Text, dtToDate.Text]);
  gridPrinter.PrintTitle := lTitle;
  grdPrinterLinkAll.ReportTitle.Text := lTitle;
  gridPrinter.Print(True, nil, grdPrinterLinkAll);
end;

procedure TfrmRptDailyRevenues.btnRefreshClick(Sender: TObject);
begin
  RefreshData;
end;

procedure TfrmRptDailyRevenues.SetSummaryDisplayFormat(aView: TcxGridDBTableView; const aFormat: string);
var
  i: integer;
begin
  for i := 0 to aView.ColumnCount-1 do
    with aView.Columns[i].Summary do
    begin
      if FooterKind <> skNone then
        FooterFormat := aFormat;
      if GroupFooterKind <> skNone then
        GroupFooterFormat := aFormat;
    end;
end;

constructor TfrmRptDailyRevenues.Create(Owner: TComponent);
begin
  FRecordSet := d.roomerMainDataSet.CreateNewDataset;
  FCurrencyhandler := TCurrencyHandler.Create(g.qNativeCurrency);
  inherited;

  SetSummaryDisplayFormat(tvPayments, FCurrencyhandler.GetcxEditProperties.DisplayFormat);
  SetSummaryDisplayFormat(tvRevenues, FCurrencyhandler.GetcxEditProperties.DisplayFormat);
  SetSummaryDisplayFormat(tvBalance, FCurrencyhandler.GetcxEditProperties.DisplayFormat);
end;

destructor TfrmRptDailyRevenues.Destroy;
begin
  inherited;
  FRecordSet.Free;
  FCurrencyhandler.Free;
end;

procedure TfrmRptDailyRevenues.DoLoadData;
var
  lCaller: TFinancialReportsAPICaller;
begin
  inherited;

  if ComponentRunning(Self) then
  begin
    FRefreshingData := true;
    m_Payments.DisableControls;
    m_Revenues.DisableControls;
    try
      lCaller := TFinancialReportsAPICaller.Create;
      try
        if lCaller.GetPaymentsReportAsDataset(FRecordSet, dtFromDate.Date, dtToDate.Date) then
        begin
          m_Payments.CopyFromDataSet(FRecordSet);
          m_Payments.Open;
        end
        else
          ShowError('reading of DailyRevenuesReport payment data');

        if lCaller.GetRevenuesReportAsDataset(FRecordSet, dtFromDate.Date, dtToDate.Date) then
        begin
          m_Revenues.CopyFromDataSet(FRecordSet);
          m_Revenues.Open;
        end
        else
          ShowError('reading of DailyRevenuesReport revenues data');

        if lCaller.GetRoomrentReportAsDataset(FRecordSet, dtFromDate.Date, dtToDate.Date) then
        begin
          // Append roomrent revenue records
          m_Revenues.LoadFromDataSet(FRecordSet);
          m_Revenues.Open;
        end
        else
          ShowError('reading of DailyRevenuesReport roomrent data');

        UpdateBalanceData;

        m_Payments.First;
        m_Revenues.First;
        m_Balance.First;

      finally
        lCaller.Free;
      end;
    finally
      m_Payments.EnableControls;
      m_Revenues.EnableControls;
      FRefreshingData := False;
    end;

    tvPayments.DataController.Groups.FullExpand;
    tvRevenues.DataController.Groups.FullExpand;
    tvBalance.DataController.Groups.FullExpand;

  end;
end;

procedure TfrmRptDailyRevenues.UpdateBalanceData;
var
  bmRevenues: TBookmark;
  bmPayments: TBookmark;
  lCurrentDate: TDate;
  lTotRev: Double;
  lTotPay: Double;
begin
  m_Balance.DisableControls;
  m_Revenues.DisableControls;
  m_Payments.DisableControls;
  try
    bmPayments := m_Payments.Bookmark;
    bmRevenues := m_Revenues.Bookmark;
    m_balance.Close;
    m_Balance.Open;

    m_Payments.SortedField := 'Date';
    m_Revenues.SortedField := 'RevenueDate';
    m_Payments.First;
    m_Revenues.First;
    while not m_Payments.Eof or not m_Revenues.Eof do
    begin
      if m_Payments.Eof then
        lCurrentDate := m_Revenues.fieldbyname('Revenuedate').AsDateTime
      else if m_Revenues.Eof then
        lCurrentDate := m_Payments.fieldbyname('Date').AsDateTime
      else
        lCurrentDate := Min(m_Payments.fieldbyname('Date').AsDateTime, m_Revenues.fieldbyname('Revenuedate').AsDateTime);

      lTotRev := 0;
      while not m_Revenues.Eof and (m_Revenues.fieldbyname('RevenueDate').AsDateTime = lCurrentDate) do
      begin
        lTotRev := lTotRev + m_Revenues.fieldbyname('TotalAmount').AsFloat;
        m_Revenues.Next;
      end;

      lTotPay := 0;
      while not m_Payments.Eof and (m_Payments.fieldbyname('Date').AsDateTime = lCurrentDate) do
      begin
        lTotPay := lTotPay + m_Payments.fieldbyname('TotalAmount').AsFloat;
        m_Payments.Next;
      end;

      m_Balance.Append;
      try
        m_BalanceRevenueDate.AsDateTime := lCurrentDate;
        m_Balancetotalrevenues.AsFloat := lTotRev;
        m_Balancetotalpayments.AsFloat := lTotPay;
        m_Balance.Post;
      except
        m_balance.Cancel;
        raise;
      end;

    end;



  finally
    if m_Payments.BookmarkValid(bmPayments) then
      m_Payments.Bookmark := bmPayments;

    if m_Revenues.BookmarkValid(bmRevenues) then
      m_Revenues.Bookmark := bmRevenues;

    m_Balance.EnableControls;
    m_Revenues.EnableControls;
    m_Payments.EnableControls;
  end;
end;


procedure TfrmRptDailyRevenues.m_BalanceCalcFields(DataSet: TDataSet);
begin
  inherited;
  m_Balancebalance.AsFloat := m_Balancetotalrevenues.AsFloat - m_Balancetotalpayments.AsFloat;
end;

procedure TfrmRptDailyRevenues.rbPresetDateClick(Sender: TObject);
begin
  inherited;
  UpdateControls;
end;

procedure TfrmRptDailyRevenues.ShowError(const aOperation: string);
begin
  raise Exception.CreateFmt('Error occured during %s.'+ #10 + 'Operation is cancelled', [aOperation]);
end;

procedure TfrmRptDailyRevenues.tvPaymentsTotalAmountGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
  inherited;
  AProperties := FCurrencyhandler.GetcxEditProperties;
end;

procedure TfrmRptDailyRevenues.UpdateControls;
begin
  if FRefreshingData then
    Exit;

  inherited;

  dtFromDate.Enabled := rbOther.Checked;
  dtToDate.Enabled := rbOther.Checked;

  if rbYesterday.Checked then
  begin
    dtFromDate.Date := TDateTime.Yesterday;
    dtTodate.Date := TDateTime.Yesterday;
  end;
end;

end.
