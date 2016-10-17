unit uDayClosingTimes;

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
  ;

type
  TfrmDayClosingTimes = class(TForm)
    pnlHolder: TsPanel;
    sPanel2: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
    btnNew: TsButton;
    btnEdit: TsButton;
    sbMain: TsStatusBar;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    mnuOther: TPopupMenu;
    mnuiPrint: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    FormStore: TcxPropertiesStore;
    m_: TdxMemData;
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_day: TDateField;
    m_ClosingTime: TDateTimeField;
    tvDataDay: TcxGridDBColumn;
    tvDataClosingTime: TcxGridDBColumn;
    edtLastDate: TsDateEdit;
    lbStartFrom: TsLabel;
    btnRefresh: TsButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure edtLastDateChange(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    FUpdatingGrid: Boolean;
    FRecordSet: TRoomerDataSet;
    procedure fillGridFromDataset;
    procedure ShowError(const aOperation: string);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
  end;


procedure EditDayClosingTimes;

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
  , uDayClosingTimesAPICaller
  , uD;

procedure EditDayClosingTimes;
begin
  with TfrmDayClosingTimes.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;


procedure TfrmDayClosingTimes.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmDayClosingTimes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FRecordSet := nil;
end;

procedure TfrmDayClosingTimes.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmDayClosingTimes.btnEditClick(Sender: TObject);
begin
  m_.Edit;
end;

procedure TfrmDayClosingTimes.btnNewClick(Sender: TObject);
begin
  m_.Insert;
end;

procedure TfrmDayClosingTimes.BtnOkClick(Sender: TObject);
begin
  if tvdata.DataController.DataSet.State in [dsInsert, dsEdit] then
    tvdata.DataController.Post;
end;

procedure TfrmDayClosingTimes.btnRefreshClick(Sender: TObject);
begin
  FillGridFromdataset;
end;

constructor TfrmDayClosingTimes.Create(Owner: TComponent);
begin
  FRecordSet := d.roomerMainDataSet.CreateNewDataset;
  inherited;
end;

destructor TfrmDayClosingTimes.Destroy;
begin
  inherited;
  FRecordSet.Free;
end;

procedure TfrmDayClosingTimes.edtLastDateChange(Sender: TObject);
begin
  fillGridFromDataset;
end;

procedure TfrmDayClosingTimes.fillGridFromDataset;
var
  lCaller: TDayClosingTimesAPICaller;
begin
  if ComponentRunning(Self) then
  begin
    FUpdatingGrid := true;
    m_.DisableControls;
    try
      lCaller := TDayClosingTimesAPICaller.Create;
      try
        if lCaller.GetDayClosingTimesAsDataset(FRecordSet, edtLastDate.Date.AddYears(-1), edtLastDate.Date+1) then
        begin
          if m_.active then m_.Close;
          m_.LoadFromDataSet(FRecordSet);
          m_.Open;
        end
        else
          ShowError('reading of DayClosing timestamps');
      finally
        lCaller.Free;
      end;
    finally
      m_.EnableControls;
      FUpdatingGrid := False;
    end;
  end;
end;

procedure TfrmDayClosingTimes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;
end;

procedure TfrmDayClosingTimes.FormShow(Sender: TObject);
begin
  fillGridFromDataset;
  grData.SetFocus;
end;

procedure TfrmDayClosingTimes.mnuiGridToExcelClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmDayClosingTimes.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmDayClosingTimes.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmDayClosingTimes.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmDayClosingTimes.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmDayClosingTimes.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
  lCaller: TDayClosingTimesAPICaller;
begin
  if FUpdatingGrid then exit;

  s := '';
  s := s+GetTranslatedText('shDeleteDayClosingTime')+' '+m_day.AsString;
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Abort
  else
  begin

    lCaller := TDayClosingTimesAPICaller.Create;
    try
      if not lCaller.DeleteDayClosingTime(Dataset['day']) then
        ShowError('delete of DayClosing Timestamp');
//        Abort;
    finally
      lCaller.Free;
    end;
  end;
end;

procedure TfrmDayClosingTimes.m_BeforeInsert(DataSet: TDataSet);
begin
  if FUpdatingGrid then exit;
  tvData.GetColumnByFieldName('day').Focused := True;
end;

procedure TfrmDayClosingTimes.m_BeforePost(DataSet: TDataSet);
var
  lCaller: TDayClosingTimesAPICaller;
begin
  if FUpdatingGrid then exit;

  lCaller := TDayClosingTimesAPICaller.Create;
  try
    if tvData.DataController.DataSource.State = dsEdit then
    begin
      if not lCaller.UpdateDayClosingTime(Dataset['day'], Dataset['closingtimestamp']) then
        ShowError('update of DayCLosing Timestamp');
//        Abort;
    end
    else if tvData.DataController.DataSource.State = dsInsert then
      if not lCaller.InsertDayClosingTime(Dataset['day'], Dataset['closingtimestamp']) then
        ShowError('insert of DayCLosing Timestamp. Cannot enter multiple closing times for the same day');
//        Abort;
  finally
    lCaller.Free;
  end;
end;

procedure TfrmDayClosingTimes.m_NewRecord(DataSet: TDataSet);
begin
  if Now().Hour < 8 then
    dataset['Day'] := TDateTime.Yesterday
  else
    dataset['Day'] := TDateTime.Today;
  dataset['closingtimestamp'] := Now();
end;

procedure TfrmDayClosingTimes.ShowError(const aOperation: string);
begin
  raise Exception.CreateFmt('Error occured during %s.'+ #10 + 'Operation is cancelled', [aOperation]);
end;

end.
