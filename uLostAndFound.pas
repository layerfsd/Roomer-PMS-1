unit uLostAndFound;

interface

// unit added 2013-02-28 HJ

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
  , Vcl.Buttons
  , Vcl.StdCtrls
  , Vcl.ComCtrls
  , Vcl.Menus
  , Vcl.ExtCtrls
  , Generics.Collections
  , Data.DB
  , shellapi

  , _glob
  , uAppGlobal
  , Hdata
  , ug

  , uManageFilesOnServer
  , kbmMemTable

  , sSkinProvider
  , sSpeedButton
  , sEdit
  , sPageControl
  , sStatusBar
  , sLabel
  , sButton
  , sPanel

  , dxCore
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
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGrid
  , cxTextEdit
  , dxPSGlbl
  , dxPSUtl
  , dxPSEngn
  , dxPrnPg
  , dxBkgnd
  , dxWrap
  , dxPrnDev
  , dxPSCompsProvider
  , dxPSFillPatterns
  , dxPSEdgePatterns
  , dxPSPDFExportCore
  , dxPSPDFExport
  , cxDrawTextUtils
  , dxPSPrVwStd
  , dxPSPrVwAdv
  , dxPSPrVwRibbon
  , dxPScxPageControlProducer
  , dxPScxGridLnk
  , dxPScxGridLayoutViewLnk
  , dxPScxEditorProducers
  , dxPScxExtEditorProducers
  , dxPSCore
  , dxPScxCommon

  , cmpRoomerDataSet
  , cmpRoomerConnection
  , dxSkinsCore

  , dxSkinCaramel
  , dxSkinCoffee
  , dxSkinDarkSide
  , dxSkinTheAsphaltWorld

  , dxSkinsDefaultPainters

  , dxSkinscxPCPainter
  , cxSpinEdit
  , cxButtonEdit
  , dxSkinsdxBarPainter
  , dxSkinsdxRibbonPainter
  , cxPropertiesStore
  , dxmdaset, cxGridBandedTableView, cxGridDBBandedTableView, cxCalendar, cxCheckBox, cxMemo, dxPScxPivotGridLnk, sCheckBox, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp,
  dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue





  ;

type
  TfrmLostAndFound = class(TForm)
    sPanel1: TsPanel;
    mnuOther: TPopupMenu;
    mnuiPrint: TMenuItem;
    mnuiAllowGridEdit: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    sbMain: TsStatusBar;
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    m_ID: TIntegerField;
    FormStore: TcxPropertiesStore;
    m_DateFound: TDateTimeField;
    m_locationDescription: TWideStringField;
    m_returnedNotes: TWideStringField;
    lvData: TcxGridLevel;
    grData: TcxGrid;
    tvData: TcxGridDBBandedTableView;
    tvDataRecId: TcxGridDBBandedColumn;
    tvDataID: TcxGridDBBandedColumn;
    tvDataDateFound: TcxGridDBBandedColumn;
    tvDatalocationDescription: TcxGridDBBandedColumn;
    tvDatareturnedNotes: TcxGridDBBandedColumn;
    m_returnedToOwner: TBooleanField;
    tvDatareturnedToOwner: TcxGridDBBandedColumn;
    btnOther: TsButton;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    m_itemDescription: TWideStringField;
    tvDataitemDescription: TcxGridDBBandedColumn;
    btnPivgrRequestsExcel: TsButton;
    chkActive: TsCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataDescriptionPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataDblClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    Procedure fillGridFromDataset(iGoto : integer);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    procedure applyFilter;

  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recLostAndFoundHolder;
  end;


//  recLostAndFoundHolder = record
//    id                  : integer;
//    DateFound           : TdateTime;
//    itemDescription     : string;
//    locationDescription : string;
//    returnedToOwner     : boolean;
//    returnedNotes       :  string;
//  end;


function openLostAndFound(act : TActTableAction; var theData : recLostAndFoundHolder) : boolean;

var
  frmLostAndFound: TfrmLostAndFound;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  ;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openLostAndFound(act : TActTableAction; var theData : recLostAndFoundHolder) : boolean;
begin
  result := false;
  frmLostAndFound := TfrmLostAndFound.Create(frmLostAndFound);
  try
    frmLostAndFound.zData := theData;
    frmLostAndFound.zAct := act;
    frmLostAndFound.ShowModal;
    if frmLostAndFound.modalresult = mrOk then
    begin
      theData := frmLostAndFound.zData;
      result := true;
    end
    else
    begin
      initLostAndFoundHolder(theData);
    end;
  finally
    freeandnil(frmLostAndFound);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmLostAndFound.fillGridFromDataset(iGoto : integer);
var
  s    : string;
  rSet : TRoomerDataSet;
  sql : string;
  active : boolean;
begin
  sql := '';
  sql := sql+'SELECT '#10;
  sql := sql+'  ID '#10;
  sql := sql+'  ,dateFound '#10;
  sql := sql+'  ,itemDescription '#10;
  sql := sql+'  ,locationDescription '#10;
  sql := sql+'  ,returnedToOwner '#10;
  sql := sql+'  ,returnedNotes '#10;
  sql := sql+'FROM lostandfound '#10;
  sql := sql+' WHERE '#10;
  sql := sql+'  returnedToOwner <> %d '#10;
  sql := sql+'  ORDER by %s '#10;


  active := chkActive.Checked;
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'ID';
  rSet := CreateNewDataSet;
  try
    s := format(sql, [ord(active), zSortStr]);
    if rSet_bySQL(rSet,s,true) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if iGoto = 0 then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('ID',iGoto,[]);
        except
        end;
      end;
    end else
    begin
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure TfrmLostAndFound.fillHolder;
begin
  initLostAndFoundHolder(zData);
  zData.ID           := m_.FieldByName('ID').AsInteger;
  zData.DateFound            := m_['DateFound']  ;
  zData.itemDescription      := m_['itemDescription']  ;
  zData.locationDescription  := m_['locationDescription']  ;
  zData.returnedToOwner      := m_['returnedToOwner']  ;
  zData.returnedNotes        := m_['returnedNotes']  ;
end;

procedure TfrmLostAndFound.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataID.Options.Editing       := false;
    tvDataDateFound           .Options.Editing   := true;
    tvDataitemDescription     .Options.Editing   := true;
    tvDatalocationDescription .Options.Editing   := true;
    tvDatareturnedToOwner     .Options.Editing   := true;
    tvDatareturnedNotes       .Options.Editing   := true;
  end else
  begin
    tvDataID.Options.Editing             := false;
    tvDataDateFound           .Options.Editing   := false;
    tvDataitemDescription     .Options.Editing   := false;
    tvDatalocationDescription .Options.Editing   := false;
    tvDatareturnedToOwner     .Options.Editing   := false;
    tvDatareturnedNotes       .Options.Editing   := false;
  end;
end;




procedure TfrmLostAndFound.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.id);
  zFirstTime := false;
end;

procedure TfrmLostAndFound.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    tvData.DataController.Filter.Root.Clear;
    tvData.DataController.Filter.Active := false;
  end else
  begin
    applyFilter;
  end;
end;

procedure TfrmLostAndFound.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataitemDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatalocationDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDatareturnedNotes,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmLostAndFound.FormCreate(Sender: TObject);
begin
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;
end;

procedure TfrmLostAndFound.FormShow(Sender: TObject);
begin
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.ID);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end else
  begin
    mnuiAllowGridEdit.Checked := true;
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  zFirstTime := false;
end;

procedure TfrmLostAndFound.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
end;

procedure TfrmLostAndFound.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;
end;

procedure TfrmLostAndFound.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ZAct = actLookup then
  begin
    if key = chr(13) then
    begin
      if activecontrol = edFilter then
      begin
      end else
      begin
        btnOk.click;
      end;
    end;

    if key = chr(27) then
    begin
      if activecontrol = edFilter then
      begin
      end else
      begin
        btnCancel.click;
      end;
    end;
  end;
end;


////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmLostAndFound.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
(*
  if hdata.payTypeExistsInOther(zData.PayType,d.qConnection,g.qLogLevel,g.qProgramPath) then
  begin
    Showmessage('payType'+' ' + zData.Description + ' '+GetTranslatedText('shExistsInRelatedData')+' ' + chr(10) + GetTranslatedText('shCanNotDelete')+' ');
    Abort;
    exit;
  end;
*)

  s := '';
  s := s+'Delete'+' '+zData.itemDescription+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_Lostandfound(zData) then
    begin
      abort;
    end
  end else
  begin
    abort
  end;
end;

procedure TfrmLostAndFound.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('dateFound').Focused := True;
end;


procedure TfrmLostAndFound.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
begin
  if zFirstTime then exit;

  initLostAndFoundHolder(zData);
  zData.ID            := dataset.FieldByName('ID').AsInteger;
  zData.DateFound            := dataset['DateFound'];
  zData.itemDescription      := dataset['itemDescription'];
  zData.locationDescription  := dataset['locationDescription'];
  zData.returnedToOwner      := dataset['returnedToOwner'];
  zData.returnedNotes        := dataset['returnedNotes'];

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if UPD_lostandFound(zData) then
    begin
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('itemDescription').AsString = ''  then
    begin
      showmessage('Description is requierd - set value or use [ESC] to cancel ');
	  //  showmessage(GetTranslatedText('shTx_Locations2_LocationRequired'));
      tvData.GetColumnByFieldName('itemDescription').Focused := True;
      abort;
      exit;
    end;
    if ins_LostandFound(zData, nID) then
    begin
      m_.fieldbyname('ID').AsInteger := nID;
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;


procedure TfrmLostAndFound.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['DateFound']           := now    ;
  dataset['itemDescription']     := ''     ;
  dataset['locationDescription'] := ''     ;
  dataset['returnedToOwner']     := false  ;
  dataset['returnedNotes']       := ''     ;
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmLostAndFound.tvDataDescriptionPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
//var
//  CurrValue : string;
begin
//  currValue := m_.fieldbyname('Description').asstring;
//
//  error := false;
//  if trim(displayValue) = '' then
//  begin
//    error := true;
//  //  errortext := 'Description '+' - '+'is required - Use ESC to cancel';
//	  errortext := GetTranslatedText('shTx_SystemServers_DescriptionIsRequired');
//    exit;
//  end;
//
//  if hdata.RoomrateDescriptionExist(displayValue,d.qConnection,g.qLogLevel,g.qProgramPath) then
//  begin
//    error := true;
//    //errortext := displayvalue+'Nýtt gildi er til í annari færslu. Notið ESC-hnappin til að hætta við';
//    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
//    exit
//  end;
////
//  if tvData.DataController.DataSource.State = dsEdit then
//  begin
//    if hdata.payTypeExistsInOther(currValue,d.qConnection,g.qLogLevel,g.qProgramPath) then
//    begin
//      error := true;
//      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
//      exit;
//    end;
//  end;
end;

procedure TfrmLostAndFound.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


procedure TfrmLostAndFound.tvDataDataControllerSortingChanged(Sender: TObject);
var
  i : integer;
  s : string;
  serval : boolean;
begin
  s := '';
  serval := false;
  for i :=  0 to tvData.SortedItemCount - 1 do
  begin
    if serval then s := s+', ';
    s := s+TcxGridDBColumn(tvData.SortedItems[I]).DataBinding.FieldName;
    serval := true;
    if tvData.SortedItems[i].SortOrder = soDescending then
    s := s + ' DESC';
  end;
  zSortStr := s;
  sbMain.SimpleText := s;
end;

//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////


procedure TfrmLostAndFound.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmLostAndFound.btnCancelClick(Sender: TObject);
begin
  initLostAndFoundHolder(zData);
end;

procedure TfrmLostAndFound.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmLostAndFound.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmLostAndFound.btnEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  tvData.GetColumnByFieldName('itemDescription').Focused := True;
  //showmessage('edit in grid');
  showmessage(GetTranslatedText('shTx_SystemServers_EditInGrid'));
end;

procedure TfrmLostAndFound.btnInsertClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := true;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  if m_.Active = false then m_.Open;
  m_.Insert;
  tvData.GetColumnByFieldName('itemDescription').Focused := True;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmLostAndFound.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmLostAndFound.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmLostAndFound.mnuiGridToExcelClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
  //  To export ot xlsx form then use this
  //  ExportGridToXLSX(sFilename, grData, true, true, true);
  //  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xlsx'), nil, nil, sw_shownormal);
end;

procedure TfrmLostAndFound.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmLostAndFound.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmLostAndFound.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

