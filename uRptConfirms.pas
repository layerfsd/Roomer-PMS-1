unit uRptConfirms;

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
  , Vcl.ExtCtrls
  , Vcl.Mask
  , Vcl.StdCtrls
  , Vcl.ComCtrls
  , Data.DB
  , shellapi

  , cmpRoomerDataSet
  , cmpRoomerConnection

  , uUtils
  , kbmMemTable
  , _glob
  , ug
  , hData
  , prjConst

  , ustringUtils

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
  , cxNavigator
  , cxDBData
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGrid

  , sPageControl
  , sStatusBar
  , sButton
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sCheckBox
  , sLabel
  , sGroupBox
  , sPanel

  , dxSkinsCore
  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters
  , dxSkinscxPCPainter
  , cxCurrencyEdit
  , cxPropertiesStore, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxCheckBox




  ;

type
  TfrmrptConfirms = class(TForm)
    sPanel1: TsPanel;
    gbxSelectDates: TsGroupBox;
    labDateFrom: TsLabel;
    labDateTo: TsLabel;
    chkOneday: TsCheckBox;
    dtDate: TsDateEdit;
    dtDateTo: TsDateEdit;
    btnRefresh: TsButton;
    btnExit: TsButton;
    pageMain: TsPageControl;
    tabConfirms: TsTabSheet;
    sPanel2: TsPanel;
    kbmConfirms_: TkbmMemTable;
    ConfirmsDS: TDataSource;
    tvConfirms: TcxGridDBTableView;
    lvConfirms: TcxGridLevel;
    grConfirms: TcxGrid;
    FormStore: TcxPropertiesStore;
    tvConfirmsConfirmDate: TcxGridDBColumn;
    tvConfirmsTurnover: TcxGridDBColumn;
    tvConfirmsPayments: TcxGridDBColumn;
    tvConfirmsDiff: TcxGridDBColumn;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    sPanel3: TsPanel;
    btnExcelTurnover: TsButton;
    tvConfirmsselected: TcxGridDBColumn;
    cxButton4: TsButton;
    cxButton1: TsButton;
    cxButton3: TsButton;
    procedure chkOnedayClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvConfirmsTurnoverGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure btnExcelTurnoverClick(Sender: TObject);
    procedure kbmConfirms_NewRecord(DataSet: TDataSet);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure dtDateCloseUp(Sender: TObject);
  private
    { Private declarations }
    zIsOneDay : boolean;
    zFirstTime : boolean;
    procedure getAll(ClearData : boolean);

  public
    { Public declarations }
    zConfirmedDate   : TdateTime;
    zsConfirmedDates   : string;

  end;

function OpenRptConfirms(var confirmdate : TdateTime;  var sConfirmedDates : string) : boolean;

var
  frmrptConfirms: TfrmrptConfirms;

implementation

{$R *.dfm}

uses uD, uDImages;


function OpenRptConfirms(var confirmdate : TdateTime; var sConfirmedDates : string) : boolean;
begin
  result := false;
  frmrptConfirms := TfrmrptConfirms.Create(frmrptConfirms);
  try
    frmrptConfirms.zConfirmedDate := confirmdate;
    frmrptConfirms.zsConfirmedDates :=  sConfirmedDates;
    frmrptConfirms.ShowModal;
    if frmrptConfirms.modalresult = mrOk then
    begin
      confirmdate := frmrptConfirms.zConfirmedDate;
      sConfirmedDates := frmrptConfirms.zsConfirmedDates;
      result := true;
    end
    else
    begin
      confirmdate := 2;
      sConfirmedDates := _dbDateAndTime(2);
    end;
  finally
    freeandnil(frmrptConfirms);
  end;
end;

procedure TfrmrptConfirms.btnExcelTurnoverClick(Sender: TObject);
var
  sFilename: string;
  s: string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Confirms';
  ExportGridToExcel(sFilename, grConfirms, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil,
    sw_shownormal);
end;

procedure TfrmrptConfirms.BtnOkClick(Sender: TObject);
begin
  if kbmConfirms_.RecordCount > 0 then
  begin
    zconfirmedDate := kbmConfirms_.fieldbyname('confirmdate').AsDateTime;
  end;

 zsConfirmedDates := '';
 if kbmConfirms_.RecordCount > 0 then
 begin
    kbmConfirms_.DisableControls;
    try
      kbmConfirms_.first;
      while not kbmConfirms_.eof do
      begin
        if kbmConfirms_['Selected'] = true then
        begin
          zsConfirmedDates := zsConfirmedDates+_dbDateAndTime(kbmConfirms_['confirmdate'])+',';
        end;
        kbmConfirms_.next;
      end;

    if zsConfirmedDates = '' then
    begin
      zsConfirmedDates := _dbDateAndTime(zconfirmedDate)
    end else
    begin
      delete(zsConfirmedDates,length(zsConfirmedDates),1);
    end;
    finally
      kbmConfirms_.EnableControls
    end;

 end;
 debugmessage(zsConfirmedDates);

end;

procedure TfrmrptConfirms.btnRefreshClick(Sender: TObject);
begin
  getAll(true);
end;

procedure TfrmrptConfirms.chkOnedayClick(Sender: TObject);
begin
  zIsOneDay := chkOneday.Checked;

  dtDateTo.Visible := not zIsOneDay;
  labDateTo.Visible := not zIsOneDay;
  if zIsOneDay then
  begin
    labDateFrom.caption := 'Date :';
  end else
  begin
    labDateFrom.caption := 'Date from :';
  end;
end;

procedure TfrmrptConfirms.cxButton1Click(Sender: TObject);
begin
  kbmConfirms_.DisableControls;
  try
    kbmConfirms_.first;
    while not kbmConfirms_.eof do
    begin
      kbmConfirms_.Edit;
      kbmConfirms_['Selected'] := true;
      kbmConfirms_.post;
      kbmConfirms_.next;
    end;
    kbmConfirms_.first;
  finally
    kbmConfirms_.EnableControls
  end;
end;


procedure TfrmrptConfirms.cxButton3Click(Sender: TObject);
begin
  kbmConfirms_.DisableControls;
  try
    kbmConfirms_.first;
    while not kbmConfirms_.eof do
    begin
      kbmConfirms_.Edit;
      kbmConfirms_['Selected'] := false;
      kbmConfirms_.post;
      kbmConfirms_.next;
    end;
    kbmConfirms_.first;
  finally
    kbmConfirms_.EnableControls
  end;
end;

procedure TfrmrptConfirms.cxButton4Click(Sender: TObject);
begin
  kbmConfirms_.edit;
  kbmConfirms_.FieldByName('Selected').asboolean := not kbmConfirms_.FieldByName('Selected').asboolean;
  kbmConfirms_.post;
end;

procedure TfrmrptConfirms.dtDateCloseUp(Sender: TObject);
begin
  getAll(true);
end;

procedure TfrmrptConfirms.FormCreate(Sender: TObject);
begin

  dtDate.date       := date - 14;
  dtDateTo.date     := date;
  zIsOneDay         := chkOneday.Checked;
  dtDateTo.Visible  := not zIsOneDay;
  labDateTo.Visible := not zIsOneDay;

  if zIsOneDay then
  begin
    labDateFrom.caption := 'Date :';
  end else
  begin
    labDateFrom.caption := 'Date from :';
  end;

end;



procedure TfrmrptConfirms.FormShow(Sender: TObject);
begin
  getAll(true);
end;

procedure TfrmrptConfirms.getAll(ClearData : boolean);
var
  s    : string;
  rset1,
  rset2 : TRoomerDataset;

  ExecutionPlan : TRoomerExecutionPlan;

  startTick : integer;
  stopTick  : integer;
  SQLms     : integer;


  dateFrom : Tdate;
  dateTo   : TDate;

begin
  screen.Cursor := crHourGlass;
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    zFirstTime := true;
    startTick := GetTickCount;


    if zIsOneDay then
    begin
      dateFrom := dtdate.date;
      dateTo   := dtdate.date+1;
    end else
    begin
      dateFrom := dtdate.date;
      dateTo   := dtdateTo.date+1;
    end;


//    s := '';
//    s := s+ ' SELECT '#10;
//    s := s+ '     tp.confirmdate '#10;
//    s := s+ '   , IF(tp.datatype=1,SUM(tp.Amount),0) AS Turnover '#10;
//    s := s+ '   , IF(tp.datatype=2,SUM(tp.Amount),0) AS payments '#10;
//    s := s+ ' FROM '#10;
//    s := s+ '   turnoverandpayments tp '#10;
//    s := s+ ' WHERE '#10;
//    s := s+ '   (tp.confirmDate >='+_dbdateandtime(dateFrom)+') AND (tp.confirmDate <'+_dbdateandtime(dateTo)+') '#10;
//    s := s+ ' GROUP BY '#10;
//    s := s+ '   tp.confirmdate '#10;
//    s := s+ '  ,tp.DataType '#10;

//469

    s := s+ ' SELECT confirmdate '#10;
    s := s+ '    , SUM(Turnover) AS Turnover '#10;
    s := s+ '    , SUM(payments) AS payments '#10;
    s := s+ '    , (SUM(Turnover) - SUM(payments)) AS diff '#10;
    s := s+ ' FROM ( '#10;
    s := s+ ' SELECT  '#10;
    s := s+ '      tp.confirmdate '#10;
    s := s+ '    , IF(tp.datatype=1,SUM(tp.Amount),0) AS Turnover '#10;
    s := s+ '    , IF(tp.datatype=2,SUM(tp.Amount),0) AS payments '#10;
    s := s+ '  FROM '#10;
    s := s+ '    turnoverandpayments tp '#10;
    s := s+ '  WHERE '#10;
    s := s+ '   (tp.confirmDate >='+_dbdateandtime(dateFrom)+') AND (tp.confirmDate <'+_dbdateandtime(dateTo)+') '#10;
    s := s+ ' GROUP BY '#10;
    s := s+ '    tp.confirmdate '#10;
    s := s+ '    ,tp.DataType '#10;
    s := s+ ' ) tmp '#10;
    s := s+ ' GROUP BY confirmDate '#10;
    s := s+ ' ORDER BY confirmdate DESC ';
//    copyToClipboard(s);
//    DebugMessage(s);
    ExecutionPlan.AddQuery(s);

    //  //////////////////// Execute!

    kbmConfirms_.DisableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      rSet1 := ExecutionPlan.Results[0];
      if kbmConfirms_.Active then kbmConfirms_.Close;
      kbmConfirms_.open;
      kbmConfirms_.LoadFromDataSet(rSet1,[]);
      // LoadKbmMemtableFromDataSetQuiet(kbmConfirms_,rSet1,[]);
      kbmConfirms_.First;
      btnOk.Enabled := (rSet1.RecordCount > 0);
    finally
      kbmConfirms_.EnableControls;
    end;
    stopTick         := GetTickCount;
    SQLms            := stopTick - startTick;
  finally
    ExecutionPlan.Free;
    screen.Cursor := crDefault;
  end;
  //pg001.ApplyBestFit;
end;



procedure TfrmrptConfirms.kbmConfirms_NewRecord(DataSet: TDataSet);
begin
  dataset.FieldByName('Selected').AsBoolean := false;
end;

procedure TfrmrptConfirms.tvConfirmsTurnoverGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

end.
