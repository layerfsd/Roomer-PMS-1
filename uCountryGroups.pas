unit uCountryGroups;
(*

 121207 - checked for ww - OK

*)


interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , Menus
  , ImgList
  , StdCtrls
  , Mask
  , ExtCtrls
  , Grids
  , Buttons
  , shellapi
  , ComCtrls

  , ADODB
  , db
  , DBTables
  , DBCtrls

  , hdata
  , uAppGlobal
  , _glob
  , ug
  , uDImages

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
  , cxContainer
  , cxDBEdit
  , cxGridCardView
  , cxGridDBCardView
  , cxGridCustomLayoutView
  , dxLayoutContainer
  , cxGridLayoutView
  , cxGridDBLayoutView
  , cxSpinEdit
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
  , dxPScxEditorProducers
  , dxPScxExtEditorProducers
  , dxPSCore
  , dxPScxGridLnk
  , dxPScxGridLayoutViewLnk
  , dxPScxCommon


  // TMSSOFRWARE
  , AdvEdit
  , AdvEdBtn


  , PrjConst
  , dxmdaset

  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, sEdit, sButton, sSpeedButton,
  sLabel, sPanel, sStatusBar, dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

  ;

type
  TfrmCountryGroups = class(TForm)
    sbMain: TsStatusBar;
    PanTop: TsPanel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    panBtn: TsPanel;
    BtnOk: TsButton;
    btnCancel: TsButton;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    grData: TcxGrid;
    tvDataCountryGroup: TcxGridDBColumn;
    tvDataGroupName: TcxGridDBColumn;
    tvDataIslGroupName: TcxGridDBColumn;
    tvDataOrderIndex: TcxGridDBColumn;
    btnOther: TsButton;
    labFilterWarning: TsLabel;
    mnuOther: TPopupMenu;
    mnuiAllowGridEdit: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    DS: TDataSource;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    mnuiPrint: TMenuItem;
    m_: TdxMemData;
    m_CountryGroup: TStringField;
    m_GroupName: TStringField;
    m_IslGroupName: TStringField;
    m_OrderIndex: TIntegerField;
    FormStore: TcxPropertiesStore;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    cLabFilter: TsLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure tvDataCountryGroupPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure tvDataCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure btnOtherClick(Sender: TObject);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure mnuiAllowGridEditClick(Sender: TObject);
    procedure mnuiGridToExcelClick(Sender: TObject);
    procedure mnuiGridToHtmlClick(Sender: TObject);
    procedure mnuiGridToTextClick(Sender: TObject);
    procedure mnuiGridToXmlClick(Sender: TObject);
    procedure mnuiPrintClick(Sender: TObject);
    procedure m_AfterPost(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure m_BeforeEdit(DataSet: TDataSet);
    procedure btnClearClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    zFirstTime : boolean;
    zAllowGridEdit : boolean;
    zPostData        : boolean;
    zPostState       : integer;
    zFilterOn : boolean;
    zSortStr  : string;


    Procedure fillGridFromDataset(sGoto : string);
    procedure changeAllowgridEdit;
    procedure fillHolder;
    function getPrevCode : string;

    Procedure chkFilter;
    procedure applyFilter;

  public
    { Public declarations }
    zAct         : TActTableAction;
    zData  : recCountryGroupHolder;
  end;


function CountryGroups(act : TActTableAction; var theData : recCountryGroupHolder ) : boolean;


var
  frmCountryGroups: TfrmCountryGroups;

implementation

uses
    uD
  , uSqlDefinitions
  , UITypes
  ;

{$R *.dfm}



//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function CountryGroups(act : TActTableAction; var theData : recCountryGroupHolder ) : boolean;
begin
  result := false;
  frmCountryGroups := TfrmCountryGroups.Create(frmCountryGroups);
  try
    frmCountryGroups.zData := theData;
    frmCountryGroups.zAct := act;
    frmCountryGroups.ShowModal;
    if frmCountryGroups.modalresult = mrOk then
    begin
      theData := frmCountryGroups.zData;
      result := true;
    end
    else
    begin
      initCountryGroupHolder(theData);
    end;
  finally
    freeandnil(frmCountryGroups)
  end;
end;

function getCountryGroup(ed : TAdvEdit; lab : TLabel) : boolean;
var
  theData : recCountrygroupHolder;
begin
  //*NOT TESTED*//
  initCountryGroupHolder(theData);
  theData.countryGroup := trim(ed.text);
  result := countryGroups(actLookup,theData);

  if trim(theData.countryGroup) = trim(ed.text) then
  begin
    result := false;
    exit;
  end;

  if result and (theData.countryGroup <> ed.text) then
  begin
    ed.text := theData.countryGroup;
    lab.Caption := theData.GroupName;
  end;
end;

function countryGroupValidate(ed : TAdvEdit; lab : TLabel) : boolean;
var
  theData : recCountryGroupHolder;
begin
  //*NOT TESTED*//
  initCountryGroupHolder(theData);
  theData.CountryGroup := trim(ed.Text);
  result := hdata.GET_CountryGroupHolderByGountryGroup(theData);

  if not result then
  begin
    ed.SetFocus;
    lab.Color := clRed;
    lab.caption := GetTranslatedText('shNotF_star');
  end else
  begin
    lab.Color := clBtnFace;
    lab.caption := theData.GroupName;
  end;
end;
//END unit global functions

///////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////

procedure TfrmCountryGroups.fillGridFromDataset(sGoto: string);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'OrderIndex DESC ';

  s := '';
//  s := s+ ' SELECT '+#10;
//  s := s+ '     CountryGroup '+#10;
//  s := s+ '   , GroupName '+#10;
//  s := s+ '   , IslGroupName '+#10;
//  s := s+ '   , OrderIndex '+#10;
//  s := s+ ' FROM '+#10;
//  s := s+ '   CountryGroups '+#10;
//  s := s+ ' ORDER BY '+#10;
//  s := s+ '  '+zSortStr+' ';





  rSet := CreateNewDataSet;
  try
    s := format(select_CountryGroups_fillGridFromDataset, [zSortStr]);
//    CopyToClipboard(s);
//    DebugMessage('select_CountryGroups_fillGridFromDataset'#10#10+s);

    if rSet_bySQL(rSet,s) then
    begin
      if m_.active then m_.Close;
      m_.LoadFromDataSet(rSet);
      if sGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('countryGroup',sGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  zFirstTime := true;
end;


procedure TfrmCountryGroups.fillHolder;
begin
  initCountryGroupHolder(zData);
  zData.CountryGroup := m_.fieldbyname('CountryGroup').asstring;
  zData.GroupName    := m_.fieldbyname('GroupName').asstring;
  zData.islGroupName := m_.fieldbyname('islGroupName').asstring;
  zData.OrderIndex   := m_.fieldbyname('OrderIndex').asInteger;
end;

procedure TfrmCountryGroups.changeAllowgridEdit;
begin
  if zAllowGridEdit then
  begin
    tvDataCountryGroup.Options.Editing := true;
    tvDataGroupName.Options.Editing    := true;
    tvDataislGroupName.Options.Editing := true;
    tvDataOrderIndex.Options.Editing   := true;
    tvData.NewItemRow.Visible := true;
  end else
  begin
    tvDataCountryGroup.Options.Editing := false;
    tvDataGroupName.Options.Editing    := false;
    tvDataislGroupName.Options.Editing := false;
    tvDataOrderIndex.Options.Editing   := false;
    tvData.NewItemRow.Visible := false;
  end;
end;


function TfrmCountryGroups.GetPrevCode : string;
//Copy the cell value from the cell immediately above the focused cell
var
  AItem : TcxGridColumn;
  APrevRecordIndex, ThisRecordIndex : integer;
  ACycleChanged : boolean;
begin
   result := '';

  if tvData.Controller.FocusedRecord is TcxGridGroupRow then
    Exit;

  AItem := tvDataCountryGroup;
  ThisRecordIndex := tvData.Controller.FocusedRecordIndex;
  APrevRecordIndex := tvData.Controller.FindNextRecord(ThisRecordIndex, False, False, ACycleChanged);

  if APrevRecordIndex <> -1 then
  begin
    APrevRecordIndex := tvData.ViewData.Records[APrevRecordIndex].RecordIndex;
    Result := tvData.DataController.Values[APrevRecordIndex, AItem.Index];
  end;
end;


Procedure TfrmCountryGroups.ChkFilter;
var
  sFilter : string;
  rC1,rc2   : integer;
begin
  sFilter := edFilter.text;
  rc1 := tvData.DataController.RecordCount;
  rc2 := tvData.DataController.FilteredRecordCount;

  zFilterON := rc1 <> rc2;

  if zFilterON then
  begin
    labFilterWarning.Visible    := true;
    labFilterWarning.Color      := clMoneyGreen;
    labFilterWarning.Font.Style := [fsBold];                         //-C
//    labFilterWarning.caption    := shFilterOn+' - '+inttostr(rc2)+' '+shRecordsOf+' '+inttostr(rc1)+' '+shAreVisible+' ';;
    labFilterWarning.caption    := format(GetTranslatedText('shFilterOnRecordsOf'), [rc2, rc1]);
  end else
  begin
    labFilterWarning.Visible    := false;
  end;
end;



/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmCountryGroups.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  zFirstTime    := true;
  zAct          := actNone;
  zPostData     := false;
  zPostState    := 0;
end;

procedure TfrmCountryGroups.FormShow(Sender: TObject);
begin
  //**
  panBtn.Visible := False;
  sbMain.Visible := false;

  fillGridFromDataset(zData.CountryGroup);
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

  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmCountryGroups.FormDestroy(Sender: TObject);
begin
  //**
end;

procedure TfrmCountryGroups.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //**
   fillholder;
end;


procedure TfrmCountryGroups.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;
end;

procedure TfrmCountryGroups.FormKeyPress(Sender: TObject; var Key: Char);
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
        btnCancel.Click;
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmCountryGroups.m_AfterPost(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  if zPostState = 0 then
  begin
    fillgridFromDataset(zData.tmp);
    exit;
  end;

  if zPostData then
  begin
    try
      zData.CountryGroup := dataset.fieldbyname('CountryGroup').asstring;
      zData.GroupName    := dataset.fieldbyname('GroupName').asstring;
      zData.islGroupName := dataset.fieldbyname('islGroupName').asstring;
      zData.OrderIndex   := dataset.fieldbyname('OrderIndex').asInteger;

      if zPostState = 1 then
      begin
        if hdata.UPD_countryGroup(zData) then
        begin
          // label1.Caption := 'Update OK';
          glb.ForceTableRefresh;
        end else
        begin
          // label1.Caption := 'Update NOT OK';
        end;
      end else
      if zPostState = 2 then
      begin
        if hdata.ins_Countrygroup(zData) then
        begin
          // label1.Caption := 'Insert OK';
          glb.ForceTableRefresh;
        end else
        begin
          // label1.Caption := 'insert NOT OK';
        end;
      end;
    finally
      zPostData  := false;
      zPostState := 0;
    end;
  end;
end;


procedure TfrmCountryGroups.m_BeforeEdit(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  zData.tmp  := dataset.FieldByName('countryGroup').AsString;
end;

procedure TfrmCountryGroups.m_BeforePost(DataSet: TDataSet);
begin
  if zFirstTime then exit;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    zPostData := true;
    zPostState   := 1;
    glb.ForceTableRefresh;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('CountryGroup').AsString = ''  then
    begin
      m_.DisableControls;
      try
        //showmessage('Countrygroup code is requierd - canceling insert - try again');
		    showmessage(GetTranslatedText('shTx_CountryGroups_CountryGroupsCodeIsRequired'));
        dataset.cancel;
      finally
        m_.EnableControls;
      end;
      zPostData := false;
      zPostState := 0;
      glb.ForceTableRefresh;
      exit;
    end;

    zPostData := true;
    zPostState   := 2;
  end;
end;



procedure TfrmCountryGroups.m_NewRecord(DataSet: TDataSet);
begin
  Dataset.FieldByName('OrderIndex').AsInteger := 0;
end;


////////////////////////////////////////////////////////////////////////////////////////
//  tvFunctions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmCountryGroups.tvDataCountryGroupPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_.fieldbyname('CountryGroup').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
    //errortext := 'Countrygroup code'+' - '+'is required - Use ESC to cancel';
	errortext := GetTranslatedText('shTx_CountryGroups_CountryGroupsRequired');
    exit;
  end;

  if hdata.CountryGroupExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+' - '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit;
  end;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.CountryGroupExistsInOther(currValue) then
    begin
      error := true;
      errortext := displayvalue+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;

procedure TfrmCountryGroups.tvDataCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if zAct = actLookup then
  begin
    btnOk.click;
  end else
  begin
    btnEdit.Click;
  end;
end;


procedure TfrmCountryGroups.tvDataDataControllerSortingChanged(Sender: TObject);
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

///////////////////////////////////////////////////////////////////////////////
//  Filter
///////////////////////////////////////////////////////////////////////////////

procedure TfrmCountryGroups.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmCountryGroups.edFilterChange(Sender: TObject);
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


procedure TfrmCountryGroups.ApplyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataCountryGroup,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataGroupName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataIslGroupName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;

//////////////////////////////////////////////////////////////////////////
//  Buttons
//////////////////////////////////////////////////////////////////////////

procedure TfrmCountryGroups.btnDeleteClick(Sender: TObject);
var
  cNumber : string;
  cDescription : string;
  s : string;

  prevCode : string;
  currCode : string;

begin
  cNumber      := m_.fieldbyname('CountryGroup').asstring;
  cDescription := m_.fieldbyname('GroupName').asstring;

  if hdata.CountryGroupExistsInOther(cNumber) then
  begin
    Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Country group', cDescription]));
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteCountrygroup')+' '+cNumber+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    screen.Cursor := crHourGlass;
    try
      currCode := cNumber;
      prevCode := GetPrevCode;

      if hdata.Del_CountrygroupByCountryGroup(cNumber) then
      begin
        try
          fillGridFromDataset(prevCode);
        except
        end;
      end;
    finally
      screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmCountryGroups.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmCountryGroups.btnCancelClick(Sender: TObject);
begin
  initCountryGroupHolder(zData);
end;

procedure TfrmCountryGroups.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmCountryGroups.btnOtherClick(Sender: TObject);
begin
  //**
end;

////---------------------------------------------------------------------------
/// Menu in other actions
///-----------------------------------------------------------------------------

procedure TfrmCountryGroups.mnuiAllowGridEditClick(Sender: TObject);
begin
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;

procedure TfrmCountryGroups.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmCountryGroups.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmCountryGroups.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmCountryGroups.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

procedure TfrmCountryGroups.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

end.
