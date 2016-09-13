unit uRptHouseKeeping;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, kbmMemTable, cxClasses, cxPropertiesStore, Vcl.StdCtrls, sRadioButton,
  acPNG, sLabel, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, sGroupBox, sButton, Vcl.ExtCtrls, sPanel,
  uDImages, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGridCustomView, cxGrid,
  dxStatusBar, cxGridDBTableView, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, cxTimeEdit, ppParameter, ppDesignLayer, ppCtrls,
  ppBands, ppVar, ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppDB, ppComm, ppRelatv, ppDBPipe, sComboBox, cxTextEdit,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPScxEditorProducers, dxPScxExtEditorProducers, dxSkinsdxBarPainter,
  dxSkinsdxRibbonPainter, dxServerModeData, dxServerModeDBXDataSource, dxPSCore, dxPScxGridLnk, dxPScxGridLayoutViewLnk,
  dxPScxCommon
  ;

type
  TfrmHouseKeepingReport = class(TForm)
    FormStore: TcxPropertiesStore;
    kbmHouseKeepingList: TkbmMemTable;
    HouseKeepingListDS: TDataSource;
    pnlFilter: TsPanel;
    btnRefresh: TsButton;
    pnlExportButtons: TsPanel;
    btnExcel: TsButton;
    dxStatusBar: TdxStatusBar;
    grHouseKeepingList: TcxGrid;
    lvHouseKeepingListLevel1: TcxGridLevel;
    grHouseKeepingListDBTableView1: TcxGridDBTableView;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    plHouseKeepingList: TppDBPipeline;
    rptHouseKeeping: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    rlabFrom: TppLabel;
    rLabHotelName: TppLabel;
    rlabUser: TppLabel;
    rLabTimeCreated: TppLabel;
    ppLine11: TppLine;
    ppDetailBand1: TppDetailBand;
    ppLine2: TppLine;
    ppFooterBand1: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppLabel8: TppLabel;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppParameterList1: TppParameterList;
    btnReport: TsButton;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    kbmHouseKeepingReport: TkbmMemTable;
    dsHouseKeepingReport: TDataSource;
    gbxSelection: TsGroupBox;
    dtDate: TsDateEdit;
    cbxLocations: TsComboBox;
    lblDate: TsLabel;
    lblLocation: TsLabel;
    kbmHouseKeepingListroomtype: TStringField;
    kbmHouseKeepingListfloor: TIntegerField;
    kbmHouseKeepingListnumberofguests: TIntegerField;
    kbmHouseKeepingListexpectedcot: TTimeField;
    kbmHouseKeepingListstatus: TStringField;
    grHouseKeepingListDBTableView1room: TcxGridDBColumn;
    grHouseKeepingListDBTableView1roomtype: TcxGridDBColumn;
    grHouseKeepingListDBTableView1floor: TcxGridDBColumn;
    grHouseKeepingListDBTableView1expectedcot: TcxGridDBColumn;
    grHouseKeepingListDBTableView1status: TcxGridDBColumn;
    kbmHouseKeepingReportroom: TStringField;
    kbmHouseKeepingListroom: TStringField;
    kbmHouseKeepingReportroomtype: TStringField;
    kbmHouseKeepingReportfloor: TIntegerField;
    kbmHouseKeepingReportnumberguests: TIntegerField;
    kbmHouseKeepingReportexpectedcot: TTimeField;
    kbmHouseKeepingReportstatus: TStringField;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel6: TppLabel;
    ppDBText4: TppDBText;
    ppLabel7: TppLabel;
    ppDBText5: TppDBText;
    ppLabel9: TppLabel;
    ppDBText6: TppDBText;
    ppLine1: TppLine;
    kbmHouseKeepingListlocation: TStringField;
    grHouseKeepingListDBTableView1location: TcxGridDBColumn;
    kbmHouseKeepingReportlocation: TStringField;
    grHouseKeepingListDBTableView1numguests: TcxGridDBColumn;
    ppLabel10: TppLabel;
    ppDBText7: TppDBText;
    cxPropertiesStore1: TcxPropertiesStore;
    gridPrinter: TdxComponentPrinter;
    gridPrinterLink1: TdxGridReportLink;
    btnPrintGrid: TsButton;
    cxStyleRepository2: TcxStyleRepository;
    dxGridReportLinkStyleSheet1: TdxGridReportLinkStyleSheet;
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
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure kbmHouseKeepingListAfterScroll(DataSet: TDataSet);
   procedure btnReportClick(Sender: TObject);
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
    procedure btnPrintGridClick(Sender: TObject);
  private
    FRefreshingdata: boolean;
    { Private declarations }
    procedure UpdateControls;
    procedure RefreshData;
    function ConstructSQL: string;
    procedure UpdateLocations;
  protected
    procedure WndProc(var message: TMessage); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  end;


/// <summary>
///   Global access point for showing the arrival report form, If Modalresult is OK then True is returned
/// </summary>
function ShowHouseKeepingReport(aDate: TDateTime): boolean;

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
  , hData
  , uAlerts
  , uProvideARoom2
  , uGuestCheckInForm
  , uInvoice
  , uReservationProfile
  , uRptbViewer
  , _Glob;

const
  cSQL = 'select * from '#10+
    '(select '#10+
	  'r.room,      '#10+
    'r.roomtype,   '#10+
    'r.floor,      '#10+
    'l.description as location,    '#10+
    '(select count(*) from persons p where p.roomreservation = rr.RoomReservation)  + rr.numChildren + rr.numInfants as NumGuests, '#10+
//    'max(rr.arrival), '#10+
//    'min(rr.departure), '#10+
    'max(rr.ExpectedCheckOutTime) as expectedCOT, '#10+
 //   'min(rr.ExpectedTimeOfArrival), '#10+
    ' case '#10+
		'   when (departure = {probedate}) then {departure} '#10+
    '   when (arrival < {probedate} and departure > {probedate}) then {stayover}  '#10+
	  ' end as Status '#10+
    'from '#10+
	  'rooms r '#10+
    '  JOIN roomtypes rt on rt.roomtype=r.roomtype '#10+
	  '  JOIN roomsdate rd on rd.room = r.room and rd.resFlag  not in (''C'', ''D'') and rd.aDate between date_sub({probedate}, interval 1 day) and {probedate}  '#10+
    '  JOIN roomreservations rr on rd.roomreservation=rr.roomreservation '#10+
    '  JOIN locations l on l.Location=r.location '#10+
    ' group by room, roomtype, floor, numberguests '#10+
    ' order by floor, room) x '#10+
    ' where not status is null ';


  WM_REFRESH_DATA = WM_User + 53;


function ShowHouseKeepingReport(aDate: TDateTime):  boolean;
var
  frm: TfrmHouseKeepingReport;
begin
  frm := TfrmHouseKeepingReport.Create(nil);
  try
    frm.dtDate.Date := aDate;
    frm.ShowModal;
    Result := (frm.modalresult = mrOk);
  finally
    frm.Free;
  end;
end;

procedure TfrmHouseKeepingReport.btnExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_HouseKeepingList';
  ExportGridToExcel(sFilename, grHouseKeepingList, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmHouseKeepingReport.btnRefreshClick(Sender: TObject);
begin
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmHouseKeepingReport.btnReportClick(Sender: TObject);
begin

  kbmHouseKeepingReport.LoadFromDataSet(kbmHouseKeepingList, []);

  if frmRptbViewer <> nil then
    freeandNil(frmRptbViewer);
  frmRptbViewer := TfrmRptbViewer.Create(frmRptbViewer);
  try
    screen.Cursor := crHourglass;
    try
      frmRptbViewer.ppViewer1.Reset;
      frmRptbViewer.ppViewer1.Report := rptHouseKeeping;
      frmRptbViewer.ppViewer1.GotoPage(1);
      rptHouseKeeping.PrintToDevices;
    finally
      screen.Cursor := crDefault;
    end;

    frmRptbViewer.showmodal;

  finally
    FreeAndNil(frmRptbViewer);
  end;
end;

function TfrmHouseKeepingReport.ConstructSQL: string;
begin
  Result := ReplaceString(cSQL, '{probedate}', _db(dtDate.Date));
  Result := ReplaceString(Result, '{departure}', _db(GetTranslatedText('shTx_Housekeepinglist_Departure')));
  Result := ReplaceString(Result, '{stayover}', _db(GetTranslatedText('shTx_Housekeepinglist_Stayover')));
  if cbxLocations.ItemIndex >= 0 then
    Result := Result + ' AND location = ' + _db(cbxLocations.Text);
  CopyToClipboard(Result);
end;

constructor TfrmHouseKeepingReport.Create(aOwner: TComponent);
begin
  inherited;
end;

destructor TfrmHouseKeepingReport.Destroy;
begin
  inherited;
end;

procedure TfrmHouseKeepingReport.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmHouseKeepingReport.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmHouseKeepingReport.FormShow(Sender: TObject);
begin
  UpdateControls;
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
end;


procedure TfrmHouseKeepingReport.kbmHouseKeepingListAfterScroll(DataSet: TDataSet);
begin
  UpdateControls;
end;


procedure TfrmHouseKeepingReport.ppHeaderBand1BeforePrint(Sender: TObject);
var
  s : string;
begin

  rlabFrom.Caption := DateToStr(dtDate.Date);

  s := g.qHotelName;
  rLabHotelName.Caption := s;

  s := DateTimeToStr(now);
  s := GetTranslatedText('shTx_NationalReport_Created') + s;
  rLabTimeCreated.Caption := s;

  s := GetTranslatedText('shTx_NationalReport_User') + g.qUser;
  if g.qusername <> '' then
    s := s + ' - ' + g.qusername;
  rlabUser.Caption := s;
end;

procedure TfrmHouseKeepingReport.RefreshData;
var
  s    : string;
  rset1: TRoomerDataset;
begin
  if NOT btnRefresh.Enabled then exit;

  btnRefresh.Enabled := False;
  Screen.Cursor := crHourglass;
  try

    kbmHouseKeepingList.DisableControls;
    try
      FRefreshingdata := True; // UpdateControls still called when updating dataset, despite DisableControls
      rSet1 := CreateNewDataSet;
      try
        s := ConstructSQL;

        hData.rSet_bySQL(rSet1, s, false);
        rSet1.First;
        if not kbmHouseKeepingList.Active then
          kbmHouseKeepingList.Open;
        LoadKbmMemtableFromDataSetQuiet(kbmHouseKeepingList,rSet1,[]);
      finally
        FreeAndNil(rSet1);
      end;

      kbmHouseKeepingList.First;

    finally
      FRefreshingdata := False;
      kbmHouseKeepingList.EnableControls;
    end;
  finally
    btnRefresh.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;


procedure TfrmHouseKeepingReport.btnPrintGridClick(Sender: TObject);
var
  lTitle: string;
begin
  lTitle := Format('%s - %s %s', [Caption, dtDate.Text, cbxLocations.Text]);
  gridPrinter.PrintTitle := lTitle;
  gridPrinterLink1.ReportTitle.Text := lTitle;
  gridPrinter.Print(True, nil, gridPrinterLink1);
end;

procedure TfrmHouseKeepingReport.UpdateControls;

begin
  if FRefreshingData then
    Exit;

  UpdateLocations;
end;

procedure TfrmHouseKeepingReport.UpdateLocations;
var
  lCurrentSelection: string;
begin

  lCurrentSelection := '';
  if cbxLocations.ItemIndex >= 0 then
    lCurrentSelection := cbxLocations.Text;

  cbxLocations.Clear;

  glb.Locations.First;
  while not glb.Locations.Eof do
  begin
    cbxLocations.Items.Add(glb.Locations['Description']);
    glb.Locations.Next;
  end;

  if lCurrentSelection.IsEmpty then
    cbxLocations.ItemIndex := -1
  else
    cbxLocations.ItemIndex := cbxLocations.Items.IndexOf(lCurrentSelection);
end;

procedure TfrmHouseKeepingReport.WndProc(var message: TMessage);
begin
  if message.Msg = WM_REFRESH_DATA then
    RefreshData;
  inherited WndProc(message);
end;

end.
