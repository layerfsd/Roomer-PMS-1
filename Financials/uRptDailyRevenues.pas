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
  , uRoomerForm, dxSkinsdxStatusBarPainter, dxStatusBar, sGroupBox, sRadioButton, uCurrencyHandler, sSplitter
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
    rbToday: TsRadioButton;
    rbOther: TsRadioButton;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyle14: TcxStyle;
    dxGridReportLinkStyleSheet1: TdxGridReportLinkStyleSheet;
    gridPrinter: TdxComponentPrinter;
    grdPrinterLinkPayments: TdxGridReportLink;
    m_PaymentsDate: TDateField;
    m_Paymentspaytype: TWideStringField;
    m_Paymentsdescription: TWideStringField;
    m_PaymentsTotalAmount: TFloatField;
    cxStyle1: TcxStyle;
    dsRevenues: TDataSource;
    m_Revenues: TdxMemData;
    m_Revenuesdate: TDateField;
    m_Revenuesdescription: TWideStringField;
    m_Revenuesitemtype: TWideStringField;
    m_Revenuesvattype: TWideStringField;
    m_Revenuestotalamount: TFloatField;
    m_Revenuestotalwovat: TFloatField;
    m_Revenuestotalvat: TFloatField;
    pnlLeft: TsPanel;
    pnlRight: TsPanel;
    pnlBottom: TsPanel;
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
    procedure btnRefreshClick(Sender: TObject);
    procedure btnPrintGridClick(Sender: TObject);
    procedure rbPresetDateClick(Sender: TObject);
    procedure tvPaymentsTotalAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
  private
    FRefreshingData: Boolean;
    FRecordSet: TRoomerDataSet;
    FCurrencyhandler: TCurrencyHandler;
    procedure ShowError(const aOperation: string);
    { Private declarations }
  protected
    procedure LoadData; override;
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
  ;

procedure ShowDailyRevenuesReport;
begin
  with TfrmRptDailyRevenues.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
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

constructor TfrmRptDailyRevenues.Create(Owner: TComponent);
begin
  FRecordSet := d.roomerMainDataSet.CreateNewDataset;
  FCurrencyhandler := TCurrencyHandler.Create(g.qNativeCurrency);
  inherited;

  tvPaymentsTotalAmount.Summary.FooterFormat := FCurrencyhandler.GetcxEditProperties.DisplayFormat;
  tvPaymentsTotalAmount.Summary.GroupFooterFormat := FCurrencyhandler.GetcxEditProperties.DisplayFormat;

  tvRevenuestotalamount.Summary.FooterFormat := FCurrencyhandler.GetcxEditProperties.DisplayFormat;
  tvRevenuestotalwovat.Summary.FooterFormat := FCurrencyhandler.GetcxEditProperties.DisplayFormat;
  tvRevenuestotalvat.Summary.FooterFormat := FCurrencyhandler.GetcxEditProperties.DisplayFormat;
  tvRevenuestotalamount.Summary.GroupFooterFormat := FCurrencyhandler.GetcxEditProperties.DisplayFormat;
  tvRevenuestotalwovat.Summary.GroupFooterFormat := FCurrencyhandler.GetcxEditProperties.DisplayFormat;
  tvRevenuestotalvat.Summary.GroupFooterFormat := FCurrencyhandler.GetcxEditProperties.DisplayFormat;
end;

destructor TfrmRptDailyRevenues.Destroy;
begin
  inherited;
  FRecordSet.Free;
  FCurrencyhandler.Free;
end;

procedure TfrmRptDailyRevenues.LoadData;
var
  lCaller: TFinancialReportsAPICaller;
begin
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
          if m_Payments.active then m_Payments.Close;
          m_Payments.LoadFromDataSet(FRecordSet);
          m_Payments.Open;
        end
        else
          ShowError('reading of DailyRevenuesReport payment data');

        if lCaller.GetRevenuesReportAsDataset(FRecordSet, dtFromDate.Date, dtToDate.Date) then
        begin
          if m_Revenues.active then m_Revenues.Close;
          m_Revenues.LoadFromDataSet(FRecordSet);
          m_Revenues.Open;
        end
        else
          ShowError('reading of DailyRevenuesReport revenues data');

      finally
        lCaller.Free;
      end;
    finally
      m_Payments.EnableControls;
      m_Revenues.EnableControls;
      FRefreshingData := False;
    end;
  end;
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

  if rbToday.Checked then
  begin
    dtFromDate.Date := TDateTime.Today;
    dtTodate.Date := TDateTime.Today;
  end;

  if rbYesterday.Checked then
  begin
    dtFromDate.Date := TDateTime.Yesterday;
    dtTodate.Date := TDateTime.Yesterday;
  end;
end;

end.
