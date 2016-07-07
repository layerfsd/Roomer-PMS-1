unit uRptStockItems;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter,
  cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxTimeEdit, Vcl.Menus, ppParameter, ppDesignLayer, ppVar, ppBands, ppCtrls, ppPrnabl, ppClass, ppCache, ppProd,
  ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, cxClasses, kbmMemTable, cxPropertiesStore, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, dxStatusBar, Vcl.StdCtrls,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, sRadioButton, sGroupBox, sButton, Vcl.ExtCtrls, sPanel,
  cxGridBandedTableView, cxGridDBBandedTableView, cxCalc, cxTextEdit, cxCalendar;

type
  TfrmRptStockItems = class(TForm)
    pnlFilter: TsPanel;
    btnRefresh: TsButton;
    gbxSelectDates: TsGroupBox;
    rbToday: TsRadioButton;
    rbTomorrow: TsRadioButton;
    rbManualRange: TsRadioButton;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    pnlExportButtons: TsPanel;
    btnExcel: TsButton;
    btnProfile: TsButton;
    btnReport: TsButton;
    dxStatusBar: TdxStatusBar;
    grStockItems: TcxGrid;
    lvStockitemsLevel1: TcxGridLevel;
    FormStore: TcxPropertiesStore;
    kbmStockItems: TkbmMemTable;
    dsStockitems: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    plStockItems: TppDBPipeline;
    rptStockitems: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppLine1: TppLine;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    rlabFrom: TppLabel;
    rLabTo: TppLabel;
    ppLabel6: TppLabel;
    rLabHotelName: TppLabel;
    rlabUser: TppLabel;
    rLabTimeCreated: TppLabel;
    ppLine11: TppLine;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppLabel8: TppLabel;
    ppLine2: TppLine;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppParameterList1: TppParameterList;
    kbmStockitemsReport: TkbmMemTable;
    dsStockitemsReport: TDataSource;
    grStockItemsDBTableView1: TcxGridDBTableView;
    kbmStockItemsRoom: TStringField;
    kbmStockItemsGuestname: TStringField;
    kbmStockItemsReservation: TIntegerField;
    kbmStockItemsCompany: TStringField;
    kbmStockItemsStockitem: TStringField;
    kbmStockItemsCount: TIntegerField;
    kbmStockItemsReservedFrom: TDateField;
    kbmStockItemsReservedTo: TDateField;
    grStockItemsDBTableView1Room: TcxGridDBColumn;
    grStockItemsDBTableView1Guestname: TcxGridDBColumn;
    grStockItemsDBTableView1Reservation: TcxGridDBColumn;
    grStockItemsDBTableView1Company: TcxGridDBColumn;
    grStockItemsDBTableView1Count: TcxGridDBColumn;
    grStockItemsDBTableView1ReservedFrom: TcxGridDBColumn;
    grStockItemsDBTableView1ReservedTo: TcxGridDBColumn;
    btnInvoice: TsButton;
    pmnuInvoiceMenu: TPopupMenu;
    mnuRoomInvoice: TMenuItem;
    mnuGroupInvoice: TMenuItem;
    kbmStockItemsRoomReservation: TIntegerField;
    kbmStockItemsDescription: TStringField;
    grStockItemsDBTableView1Description: TcxGridDBColumn;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel7: TppLabel;
    ppDBText4: TppDBText;
    ppLabel9: TppLabel;
    ppDBText5: TppDBText;
    ppLabel10: TppLabel;
    ppDBText6: TppDBText;
    ppLabel11: TppLabel;
    ppDBText7: TppDBText;
    ppLabel12: TppLabel;
    ppDBText8: TppDBText;
    procedure mnuGroupInvoiceClick(Sender: TObject);
    procedure mnuRoomInvoiceClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure dtDateFromCloseUp(Sender: TObject);
    procedure dtDateToCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grArrivalsListDBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure grArrivalsListDBTableView1ExpectedTimeOfArrivalGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure kbmStockItemsAfterScroll(DataSet: TDataSet);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure rbRadioButtonClick(Sender: TObject);
  private
    FRefreshingdata: boolean;
    procedure RefreshData;
    procedure SetManualDates(aFrom, aTo: TDate);
    procedure UpdateControls;
  protected
    procedure WndProc(var message: TMessage); override;
    { Private declarations }
  public
  end;

/// <summary>
///   Global access point for showing the StockItemsreport form, If Modalresult is OK then True is returned
/// </summary>
function ShowStockItemsReport: boolean;

implementation

{$R *.dfm}

uses
    uRoomerLanguage
  , uAppGlobal
  , uG
  , uUtils
  , cxGridExportLink
  , ShellApi
  , cmpRoomerDataset
  , uD
  , PrjConst
  , uReservationProfile
  , uRptbViewer
  , uInvoice
  , uOpenAPICaller;

const
  WM_REFRESH_DATA = WM_User + 51;


function ShowStockItemsReport: boolean;
var
  frm: TfrmRptStockItems;
begin
  frm := TfrmRptStockItems.Create(nil);
  try
    frm.ShowModal;
    Result := (frm.modalresult = mrOk);
  finally
    frm.Free;
  end;
end;

procedure TfrmRptStockItems.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_StockitemsList';
  ExportGridToExcel(sFilename, grStockItems, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmRptStockItems.btnProfileClick(Sender: TObject);
begin
  if EditReservation(kbmStockItemsReservation.Asinteger, kbmStockItemsRoomReservation.AsInteger) then
    postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmRptStockItems.btnRefreshClick(Sender: TObject);
begin
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmRptStockItems.btnReportClick(Sender: TObject);
begin

  kbmStockItemsReport.LoadFromDataSet(kbmStockItems, []);

  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
  try
    screen.Cursor := crHourglass;
    try
      frmRptbViewer.ppViewer1.Reset;
      frmRptbViewer.ppViewer1.Report := rptStockitems;
      frmRptbViewer.ppViewer1.GotoPage(1);
      rptStockItems.PrintToDevices;
    finally
      screen.Cursor := crDefault;
    end;

    frmRptbViewer.showmodal;

  finally
    FreeAndNil(frmRptbViewer);
  end;
end;

procedure TfrmRptStockItems.dtDateFromCloseUp(Sender: TObject);
begin
 if dtDateFrom.Date > dtDateTo.Date then
   dtDateTo.Date := dtDateFrom.Date;
end;

procedure TfrmRptStockItems.dtDateToCloseUp(Sender: TObject);
begin
 if dtDateFrom.Date > dtDateTo.Date then
   dtDateFrom.Date := dtDateTo.Date;
end;

procedure TfrmRptStockItems.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);

end;

procedure TfrmRptStockItems.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmRptStockItems.FormShow(Sender: TObject);
begin
  UpdateControls;
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmRptStockItems.grArrivalsListDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  btnProfile.Click;
end;

procedure TfrmRptStockItems.grArrivalsListDBTableView1ExpectedTimeOfArrivalGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
var
  lTime: TDateTime;
begin
  if not aText.IsEmpty and TryStrToTime(aText, lTime) then
    DateTimeToString(aText, FormatSettings.ShortTimeFormat, StrTodateTime(aText));

end;

procedure TfrmRptStockItems.kbmStockItemsAfterScroll(DataSet: TDataSet);
begin
  UpdateControls;
end;

procedure TfrmRptStockItems.ppHeaderBand1BeforePrint(Sender: TObject);
var
  s : string;
begin

  rlabFrom.Caption := DateToStr(dtDateFrom.Date);
  rlabTo.Caption := DateToStr(dtDateTo.Date);

  s := g.qHotelName;
  rLabHotelName.Caption := s;

  s := DateTimeToStr(now);
  // s := 'Created : ' + s;
  s := GetTranslatedText('shTx_NationalReport_Created') + s;
  rLabTimeCreated.Caption := s;

  // s := 'User : ' + g.qUser;
  s := GetTranslatedText('shTx_NationalReport_User') + g.qUser;
  if g.qusername <> '' then
    s := s + ' - ' + g.qusername;
  rlabUser.Caption := s;
end;

procedure TfrmRptStockItems.rbRadioButtonClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TfrmRptStockItems.RefreshData;
var
  lCaller: TInventoriesOpenAPICaller;
  rset1: TRoomerDataset;
begin
  if NOT btnRefresh.Enabled then exit;

  btnRefresh.Enabled := False;
  Screen.Cursor := crHourglass;
  try

    kbmStockitems.DisableControls;
    try
      FRefreshingdata := True; // UpdateControls still called when updating dataset, despite DisableControls
      rSet1 := CreateNewDataSet;
      try

        lCaller := TInventoriesOpenAPICaller.Create;
        try
          lCaller.CallStockitemsAsDataset(rSet1, false, 0, 0, True, dtDateFrom.date, dtDateTo.Date);
        finally
          lCaller.Free;
        end;

        rSet1.First;
        if not kbmStockItems.Active then
          kbmStockItems.Open;
        LoadKbmMemtableFromDataSetQuiet(kbmStockitems,rSet1,[]);
      finally
        FreeAndNil(rSet1);
      end;

      kbmStockitems.First;

    finally
      FRefreshingdata := False;
      kbmStockItems.EnableControls;
    end;
  finally
    btnRefresh.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmRptStockItems.SetManualDates(aFrom, aTo: TDate);
begin
  dtDateFrom.Date := aFrom;
  dtDateTo.Date := aTo;
end;

procedure TfrmRptStockItems.UpdateControls;
var
  lDataAvailable: boolean;
begin
  if FRefreshingData then
    Exit;

  dtDateFrom.Enabled := rbManualRange.Checked;
  dtDateTo.Enabled := rbManualRange.Checked;

  if rbToday.Checked then
    SetManualDates(Now, now)
  else if rbTomorrow.Checked then
    SetManualDates(Now+1, Now+1);

  lDataAvailable := kbmStockitems.Active and not kbmStockitems.IsEmpty;
  btnProfile.Enabled := lDataAvailable;
  btnInvoice.Enabled := lDataAvailable;
  btnReport.Enabled := lDataAvailable;
  btnExcel.Enabled := lDataAvailable;
end;

procedure TfrmRptStockItems.WndProc(var message: TMessage);
begin
  if message.Msg = WM_REFRESH_DATA then
    RefreshData;
  inherited WndProc(message);
end;

procedure TfrmRptStockItems.mnuRoomInvoiceClick(Sender: TObject);
begin
  EditInvoice(kbmStockItemsReservation.AsInteger, kbmStockItemsRoomReservation.AsInteger, 0, 0, 0, 0, false, true,false);
end;

procedure TfrmRptStockItems.mnuGroupInvoiceClick(Sender: TObject);
begin
  EditInvoice(kbmStockItemsReservation.AsInteger, 0, 0, 0, 0, 0, false, true,false);
end;

end.
