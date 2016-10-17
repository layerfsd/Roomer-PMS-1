unit uItems2;

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
  , Hdata
  , ug
  , uD
  , uFrmKeyPairSelector
  , RoomerCloudEntities

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
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCalc, cxButtonEdit, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxPropertiesStore, dxmdaset,
  dxPScxPivotGridLnk, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, sCheckBox, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxDropDownEdit, cxCheckBox, cxCalendar, cxCurrencyEdit,
  uCurrencyHandler

  ;

type
  {$SCOPEDENUMS ON}
  TShowItemOfType = (All, BreakfastItems, StockItems, NonStockitems, MinibarItems, ShowAvailability);
  TShowItemOfTypeSet = set of TShowItemOfType;

  TfrmItems2 = class(TForm)
    sPanel1: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
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
    edFilter: TsEdit;
    cLabFilter: TsLabel;
    btnClear: TsSpeedButton;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    dsItems: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_Items: TdxMemData;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    m_ItemsID: TIntegerField;
    m_ItemsActive: TBooleanField;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    m_ItemsItem: TWideStringField;
    m_ItemsMinibarItem: TBooleanField;
    m_ItemsDescription: TWideStringField;
    m_ItemsPrice: TFloatField;
    m_ItemsItemtype: TWideStringField;
    m_ItemsAccountKey: TWideStringField;
    m_ItemsHide: TBooleanField;
    m_ItemsSystemItem: TBooleanField;
    m_ItemsRoomRentitem: TBooleanField;
    m_ItemsReservationItem: TBooleanField;
    m_ItemsCurrency: TWideStringField;
    tvDataItem: TcxGridDBColumn;
    tvDataDescription: TcxGridDBColumn;
    tvDataPrice: TcxGridDBColumn;
    tvDataItemtype: TcxGridDBColumn;
    tvDataAccountKey: TcxGridDBColumn;
    tvDataMinibarItem: TcxGridDBColumn;
    tvDataSystemItem: TcxGridDBColumn;
    tvDataRoomRentitem: TcxGridDBColumn;
    tvDataReservationItem: TcxGridDBColumn;
    tvDataCurrency: TcxGridDBColumn;
    tvDataHide: TcxGridDBColumn;
    btnInsert: TsButton;
    btnEdit: TsButton;
    FormStore: TcxPropertiesStore;
    btnTaxLinks: TsButton;
    chkActive: TsCheckBox;
    m_ItemsBreakfastItem: TBooleanField;
    m_ItemsBookKeepCode: TWideStringField;
    tvDataBookKeepCode: TcxGridDBColumn;
    timFilter: TTimer;
    m_ItemsNumberBase: TWideStringField;
    tvDataNumberBase: TcxGridDBColumn;
    m_ItemsStockItem: TBooleanField;
    tvDataStockItem: TcxGridDBColumn;
    dsprices: TDataSource;
    lvPrices: TcxGridLevel;
    tvPrices: TcxGridDBTableView;
    tvPricesitemID: TcxGridDBColumn;
    tvPricesfromdate: TcxGridDBColumn;
    tvPricesprice: TcxGridDBColumn;
    m_ItemsTotalStock: TIntegerField;
    tvDataTotalStock: TcxGridDBColumn;
    kbmStockItemprices: TkbmMemTable;
    kbmStockitemPricesID: TIntegerField;
    kbmStockitemPricesitemID: TIntegerField;
    kbmStockitemPricesfromdate: TDateTimeField;
    kbmStockitemPricesprice: TFloatField;
    m_Availability: TkbmMemTable;
    m_AvailabilityStockitem: TIntegerField;
    m_AvailabilityInUse: TIntegerField;
    m_AvailabilityUseDate: TDateField;
    m_ItemsAvailableStock: TIntegerField;
    tvDataAvailableStock: TcxGridDBColumn;
    pnlInfo: TsPanel;
    cLabAvailFrom: TsLabel;
    labAvailFrom: TsLabel;
    clabAvailTo: TsLabel;
    labAvailTo: TsLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    m_Availabilityavailable: TIntegerField;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_ItemsBeforeDelete(DataSet: TDataSet);
    procedure m_ItemsBeforeInsert(DataSet: TDataSet);
    procedure m_ItemsBeforePost(DataSet: TDataSet);
    procedure m_ItemsNewRecord(DataSet: TDataSet);
    procedure tvDataDescriptionPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataDblClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
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
    procedure edFilterChange(Sender: TObject);
    procedure tvDataItemtypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataItemPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnInsertClick(Sender: TObject);
    procedure tvDataAccountKeyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnTaxLinksClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure tvDataBookKeepCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure m_ItemsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure timFilterTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tvDataDataControllerDetailExpanding(ADataController: TcxCustomDataController; ARecordIndex: Integer;
      var AAllow: Boolean);
    procedure m_StockitemPricesNewRecord(DataSet: TDataSet);
    procedure m_StockitemPricesBeforePost(DataSet: TDataSet);
    procedure m_StockitemPricesBeforeDelete(DataSet: TDataSet);
    procedure tvDataEditing(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure m_ItemsTotalStockGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure m_ItemsCalcFields(DataSet: TDataSet);
    procedure tvDataAvailableStockCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure kbmStockItempricesAfterPost(DataSet: TDataSet);
    procedure m_ItemsAfterPost(DataSet: TDataSet);
    procedure tvDataPriceCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure GetPriceProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    financeLookupList : TKeyPairList;
    zFirstTime       : boolean;
    FAllowGridEdit   : boolean;
    zFilterOn        : boolean;

    zSortStr         : string;
    FShowItemsOfType: TShowItemOfTypeSet;
    FAvailSet: TRoomerDataset;

    FLocateAfterPost: integer;
    FCurrencyhandler: TCurrencyHandler;

    Procedure fillGridFromDataset(sGoto : string);
    procedure fillHolder;
    Procedure chkFilter;
    procedure applyFilter;
    function AssertCorrectness : Boolean;
    procedure GetSelectedItems(theData: TrecItemHolderList);
    function NumItemsSelected: Integer;
    procedure StopFilter;
    function CopyDatasetToRecItem:recItemHolder;
    procedure SetAllowGridEdit(const Value: boolean);
    function CopyStockItemPricesToRec: recStockItemPricesHolder;
    function CalcStockitemPriceOndate(aItemID: integer; aDate: TDateTime): double;
    procedure SetFilterForDataset(aRSet: TRoomerDataset);
    procedure GetStockitemAvailability;
    function ConstructSQL: string;
    procedure FillStockItemPrices;
  protected
    Lookup : Boolean;
    zData: recItemHolder;
    zAct: TActTableAction;
    /// <summary>
    ///   Add recItemHolders to recItemHolderslist for each price-period of selected stockitem. <br />
    ///  zData is used to determine requested peroid of use
    /// </summary>
    procedure GetStockItemsPerPrice(aDataList: TrecItemHolderList);
    property ShowItemsOfType: TShowItemOfTypeSet read FShowItemsOfType write FShowItemsOfType;
    property AllowGridEdit: boolean read FAllowGridEdit write SetAllowGridEdit;
  end;

function openItems(act : TActTableAction; Lookup : Boolean; var theData : recItemHolder; aShowTypes: TShowItemOfTypeSet=[TShowItemOfType.All]) : boolean;
function openMultipleItems(act : TActTableAction; Lookup : Boolean; theData : TrecItemHolderList; aShowTypes: TShowItemOfTypeSet=[TShowItemOfType.All]) : boolean;
/// <summary>
///   Special version of openitems that allows selection of stockitems, and returning multiple items if th seelcted period
/// involves a pricechange
/// </summary>
function SelectStockItems(ainitRec: recItemHolder; aDataList : TrecItemHolderList) : boolean;

implementation

{$R *.dfm}

uses
  prjConst
  , uSqlDefinitions
  , uItemTypes2
  , uMessageList
  , uAppGlobal
  , uDimages
  , uFrmTaxItemLink
  , uBookKeepingCodes
  , uUtils
  , UITypes
  , uDateUtils
  , DateUtils
  , Math
  ;



//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openItems(act : TActTableAction; Lookup : Boolean; var theData : recItemHolder; aShowTypes: TShowItemOfTypeSet=[TShowItemOfType.All]) : boolean;
var _frmItems2 : TfrmItems2;
begin
  result := false;
  _frmItems2 := TfrmItems2.Create(nil);
  try
    _frmItems2.zData := theData;
    _frmItems2.Lookup := Lookup;
    _frmItems2.zAct := act;
    _frmItems2.ShowItemsOfType := aShowTypes;
    _frmItems2.ShowModal;
    if _frmItems2.modalresult = mrOk then
    begin
      theData := _frmItems2.zData;
      result := true;
    end
    else
    begin
      initItemHolder(theData);
    end;
  finally
    freeandnil(_frmItems2);
    glb.Items.Filtered := False;
  end;
end;

function SelectStockItems(ainitRec: recItemHolder; aDataList : TrecItemHolderList) : boolean;
var frmItems2 : TfrmItems2;
begin
  result := false;
  frmItems2 := TfrmItems2.Create(nil);
  try
    frmItems2.zData := aInitRec;
    frmItems2.Lookup := True;
    frmItems2.zAct := actLookup;
    frmItems2.ShowItemsOfType := [TShowItemOfType.StockItems, TShowItemOfType.ShowAvailability];
    frmItems2.ShowModal;
    if frmItems2.modalresult = mrOk then
    begin
      frmItems2.GetStockItemsPerPrice(aDataList);
      result := true;
    end;
  finally
    freeandnil(frmItems2);
    glb.Items.Filtered := False;
  end;
end;


function openMultipleItems(act : TActTableAction; Lookup : Boolean; theData : TrecItemHolderList; aShowTypes: TShowItemOfTypeSet=[TShowItemOfType.All]) : boolean;
var _frmItems2 : TfrmItems2;
begin
  result := false;
  _frmItems2 := TfrmItems2.Create(nil);
  try
    if theData.Count > 0  then
      _frmItems2.zData := theData[0].recHolder;
    _frmItems2.Lookup := Lookup;
    _frmItems2.zAct := act;
    _frmItems2.ShowItemsOfType := aShowTypes;
    _frmItems2.ShowModal;
    if _frmItems2.modalresult = mrOk then
    begin
      _frmItems2.GetSelectedItems(theData);
      result := true;
    end
    else
    begin
      theData.Clear;
    end;
  finally
    freeandnil(_frmItems2);
    glb.Items.Filtered := False;
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////

function TfrmItems2.NumItemsSelected : Integer;
begin
  result := tvData.Controller.SelectedRecordCount-1;
end;

function TfrmItems2.CopyDatasetToRecItem:recItemHolder;
begin
  Result.ID                    := m_ItemsID.AsInteger;
  Result.Active                := m_ItemsActive.AsBoolean;
  Result.Description           := m_ItemsDescription.AsString;
  Result.Item                  := m_ItemsItem.asString;
  Result.Price                 := m_ItemsPrice.AsFloat;
  Result.Itemtype              := m_ItemsItemtype.AsString;
  Result.AccountKey            := m_ItemsAccountKey.AsString;
  Result.MinibarItem           := m_ItemsMinibarItem.AsBoolean;
  Result.SystemItem            := m_ItemsSystemItem.AsBoolean;
  Result.RoomRentitem          := m_ItemsRoomRentitem.AsBoolean;
  Result.ReservationItem       := m_ItemsReservationItem.AsBoolean;
  Result.Hide                  := m_ItemsHide.AsBoolean;
  Result.Currency              := m_ItemsCurrency.AsString;
  Result.BookKeepCode          := m_ItemsBookKeepCode.AsString;
  Result.NumberBase            := m_ItemsNumberBase.AsString;
  Result.Stockitem             := m_ItemsStockitem.AsBoolean;
  Result.TotalStock            := m_ItemsTotalStock.AsInteger;

  Result.AvailabilityFrom      := zData.AvailabilityFrom;
  Result.AvailabilityTo        := zData.AvailabilityTo;
end;


function TfrmItems2.CopyStockItemPricesToRec: recStockitemPricesHolder;
begin
  Result.ID         := kbmStockitemPricesID.Asinteger;
  Result.ItemID     := kbmStockitemPricesitemID.AsInteger;
  Result.FromDate   := kbmStockitemPricesfromdate.AsDateTime;
  result.price      := kbmStockitemPricesprice.AsFloat;
end;


procedure TfrmItems2.GetSelectedItems(theData : TrecItemHolderList);
var item : TrecItemHolder;
    i : Integer;
begin
  theData.Clear;
  if NumItemsSelected > 0 then
  begin
    m_Items.DisableControls;
    try
      for i:= 0 To tvData.Controller.SelectedRecordCount-1 Do
      begin
        m_Items.RecNo := tvData.Controller.SelectedRecords[I].Index +  1;
          item := TrecItemHolder.Create;
          with item do
          begin
            recHolder := CopyDatasetToRecItem;
            theData.Add(item);
          end;
      end;
    finally
       m_Items.EnableControls;
    end;
    m_Items.First;
  end else
  begin
    item := TrecItemHolder.Create;
    item.recHolder := zData;
    theData.Add(item);
  end;
end;

procedure TfrmItems2.SetFilterForDataset(aRSet: TRoomerDataset);
var
  lFilterExpr: TStringbuilder;
begin
  lFilterExpr := TStringbuilder.Create;
  try
    if chkActive.Checked then
      lFilterExpr.Append('(active=1) ')
    else
      lFilterExpr.Append('(active=0) ');

    if not (TShowItemOfType.All in FShowItemsOfType) then
    begin
      lFilterExpr.Append(' and (');

      if TShowItemOfType.StockItems in FShowItemsOfType then
      begin
        lFilterExpr.Append(' (stockitem=1)');
        lFilterExpr.Append(' or');
      end;

      if TShowItemOfType.NonStockItems in FShowItemsOfType then
      begin
        lFilterExpr.Append(' (stockitem=0)');
        lFilterExpr.Append(' or');
      end;

      if TShowItemOfType.BreakfastItems in FShowItemsOfType then
      begin
        lFilterExpr.Append(' (breakfastitem=1)');
        lFilterExpr.Append(' or');
      end;

      if TShowItemOfType.MinibarItems in FShowItemsOfType then
      begin
        lFilterExpr.Append(' (minibaritem=1)');
        lFilterExpr.Append(' or');
      end;
        // remove last 'Or'
      lFilterExpr.Remove(lFilterExpr.Length-2, 2);
      lFilterExpr.Append(')');
    end;
    aRSet.Filter := lFilterExpr.ToString;
    aRSet.Filtered := aRSet.Filter <> '';
  finally
    lFilterExpr.Free;
  end;

end;

function TfrmItems2.ConstructSQL: string;
const
  cSQL = 'select ' +
         ' i.ID, ' +
         ' i.Item, ' +
         ' i.Active, ' +
         ' i.minibarItem, ' +
         ' i.Description, ' +
         ' i.itemType, ' +
         ' i.AccountKey, ' +
         ' i.Hide, ' +
         ' i.Systemitem, ' +
         ' i.RoomRentItem, ' +
         ' i.ReservationItem, ' +
         ' i.Currency, ' +
         ' i.BookKeepCode, ' +
         ' i.NumberBase, ' +
         ' i.breakfastitem, ' +
         ' i.Stockitem, ' +
         ' s.totalstock as totalstock, 0 as availablestock, ' +
         ' case  '+
         '   when i.stockitem then ' +
         '     (select price ' +
		     '      from stockitemprices sip ' +
         '      where fromdate <= ''%s'' and sip.itemid = i.id ' +
         '      order by fromdate desc limit 1  ' +
         '     ) ' +
         '   else  '+
         '    i.Price '+
         ' end as price '+
          'from items i ' +
         'left outer join stockitems s on i.id=s.itemid';

begin
  if zData.AvailabilityFrom > 0 then
    Result := Format(cSQL, [DateToSqlString(zData.AvailabilityFrom)])
  else
    Result := Format(cSQL, [DateToSqlString(Now())]);
end;

Procedure TfrmItems2.fillGridFromDataset(sGoto : string);
var
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;

  if zSortStr = '' then zSortStr := 'Item';

  rSet := CreateNewDataSet;
  rSet_bySQL(rSet, ConstructSQL);
  try
    rSet.Sort := 'Item';

    SetFilterForDataset(rSet);

    m_Items.Close;
    m_Items.Open;

    rSet.First;
    if NOT rSet.Eof then
    begin
      m_Items.DisableControls;
      try
        if TShowItemOfType.ShowAvailability in FShowItemsOfType then
          GetStockitemAvailability;

        m_Items.LoadFromDataSet(rSet);

        if (sGoto = '') or not m_Items.Locate('item',sGoto,[]) then
          m_Items.First;
      finally
        m_Items.EnableControls;
      end;
    end;
  finally
    rSet.Free;
  end;

end;



procedure TfrmItems2.GetStockitemAvailability;
const
  cSQL = 'select ' +
         ' i.itemid as stockitem, ' +
         ' cast(rrs.usedate as DATE) as usedate,' +
         ' sum(rrs.count) as inUse, ' +
         ' i.totalstock - coalesce(sum(rrs.count), 0) as available  '+
         ' FROM stockitems i  '+
         ' LEFT OUTER JOIN roomreservationstockitems rrs on rrs.stockitem=i.itemid ' +
         '                AND rrs.usedate >= ''%s''  and rrs.usedate < ''%s'' ' +
         '                and rrs.roomreservation <> %d  '+
         'group by i.itemid, rrs.usedate ';
var
  lSQL: string;
  lrSet: TRoomerDataset;
begin
  lSQL := format(cSQL, [DateTOSQLString(zData.AvailabilityFrom), DateToSQLString(zData.AvailabilityTo), zData.RoomReservation]);
  lrSet := CreateNewDataset;
  try
    rSet_bySQL(lrSet, lSQL);

    m_Availability.LoadFromDataSet(lRSet, []);
    m_Availability.Open;
    m_Availability.IndexFieldNames := 'stockitem;usedate';
    m_Availability.First;
  finally
    lrSet.Free;
  end;
end;

procedure TfrmItems2.GetStockItemsPerPrice(aDataList: TrecItemHolderList);
var
  lDateInt: integer;
  lPrevPrice: double;
  lCurrPrice: double;
  lCurrentRecItem: recItemHolder;
  lCurrentDate: TDateTime;
begin
  lPrevPrice := -1;
  lCurrentRecItem := zData;

  for lDateInt := 0 to DaysBetween(zData.AvailabilityFrom, zData.AvailabilityTo) do
  begin
    lCurrentDate := zData.AvailabilityFrom + lDateInt;
    lCurrPrice := CalcStockitemPriceOndate(zData.id, lCurrentDate);
    if not SameValue(lCurrPrice, lPrevPrice) then
    begin // Price changed, end the previous item and add a new recItem
      if aDataList.Count > 0 then
        aDataList[aDataList.Count -1].recHolder.AvailabilityTo := lCurrentDate;

      lCurrentRecItem.Price := lCurrPrice;
      lCurrentRecitem.AvailabilityFrom := lCurrentDate;
      // AvailabilityTo is already set to enddate of requested period

      aDataList.AddrecItem(lCurrentRecItem);
    end;

    lPrevPrice := lCurrPrice;
  end;

end;

procedure TfrmItems2.kbmStockItempricesAfterPost(DataSet: TDataSet);
begin
  if FLocateAfterPost > 0 then
    kbmStockItemprices.Locate('ID', FLocateAfterPost, []);
  FLocateAfterPost := 0;
end;

procedure TfrmItems2.fillHolder;
begin
  zData := CopyDatasetToRecItem;
  if zData.Stockitem then
    zData.Price := CalcStockitemPriceOndate(zData.id, now);
end;

function TfrmItems2.CalcStockitemPriceOndate(aItemID: integer; aDate: TDateTime): double;
var
  lProbeDate: TDateTime;
begin
  result := 0;
  if (aDate > 0) then
    lProbeDate := aDate
  else
    lProbeDate := now;

  kbmStockitemPrices.IndexName := 'kbmStockItempricesIndex1';
  kbmStockitemPrices.First;
  if kbmStockitemPrices.Locate('itemid', aItemId, []) then
  begin
    while not kbmStockItemPrices.EOF and (kbmStockitemPricesitemID.AsInteger = aItemID) and (kbmStockitemPricesfromdate.AsDateTime > lProbeDate) do
      kbmStockitemPrices.Next;
    if not kbmStockitemPrices.EOF then
      Result := kbmStockitemPricesprice.AsFloat;
  end;
end;

procedure TfrmItems2.chkActiveClick(Sender: TObject);
begin
  zFirstTime := false;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  fillGridFromDataset(zData.item);
  zFirstTime := false;
end;

procedure TfrmItems2.chkFilter;
var
  sFilter : string;
  rC1,rc2   : integer;
begin
  sFilter := edFilter.text;
  rc1 := tvData.DataController.RecordCount;
  rc2 := tvData.DataController.FilteredRecordCount;
  zFilterON := rc1 <> rc2;
end;

procedure TfrmItems2.SetAllowGridEdit(const Value: boolean);
begin
  FAllowGridEdit := Value;
  tvData.OptionsData.Editing := FAllowGridEdit;
  tvDataID.Options.Editing := false;
  tvPrices.OptionsData.Editing := FAllowGridEdit;
  tvPrices.OptionsData.Appending := FAllowGridEdit;
  tvPrices.NewItemRow.Visible := FAllowGridEdit;
  tvPrices.OptionsData.Deleting := FAllowGridEdit;

  mnuiAllowGridEdit.Checked := FAllowGridEdit;
  btnDelete.Enabled := FAllowGridEdit;
  btnEdit.Enabled := FAllowGridEdit;
  btnInsert.Enabled := FAllowGridEdit;
end;

procedure TfrmItems2.StopFilter;
begin
  if tvData.DataController.Filter.AutoDataSetFilter then
  begin
    timFilter.Enabled := False;
    m_Items.filtered := False;
    tvData.DataController.Filter.Active := False;
    tvData.DataController.Filter.Changed;
  end else
  begin
    tvData.DataController.Filter.Root.Clear;
    tvData.DataController.Filter.Active := false;
    grData.Invalidate(true);
  end;
end;

procedure TfrmItems2.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    StopFilter;
  end else
  begin
    applyFilter;
  end;
end;

procedure TfrmItems2.applyFilter;
var i : Integer;

    procedure RestartTimer;
    begin
      timFilter.Enabled := False;
      timFilter.Interval := 500;
      timFilter.Interval := 30;
      timFilter.Enabled := True;
    end;
begin
  if tvData.DataController.Filter.AutoDataSetFilter then
  begin
    m_Items.filtered := False;
    RestartTimer;
  end else
  begin
    tvData.DataController.Filter.Options := [fcoCaseInsensitive];
    tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
    tvData.DataController.Filter.Root.Clear;
    for i := 0 to tvData.ColumnCount - 1 do
      if tvData.Columns[i].DataBinding.ValueType = 'String' then
        tvData.DataController.Filter.Root.AddItem(tvData.Columns[i], foLike, '%'+edFilter.Text+'%', '%'+edFilter.Text+'%');
    tvData.DataController.Filter.Active := True;
  end;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmItems2.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  Lookup := False;
  financeLookupList := nil;
  //**
  zFirstTime  := true;
  zAct        := actNone;
  FAvailSet := TRoomerDataSet.Create(self);
  FCurrencyhandler := TCurrencyHandler.Create(g.qNativeCurrency);
end;

procedure TfrmItems2.FormDestroy(Sender: TObject);
begin
  FCurrencyHandler.Free;
end;

procedure TfrmItems2.FormShow(Sender: TObject);
begin
  zFirstTime := true;
  glb.EnableOrDisableTableRefresh('items', False);
//**
  panBtn.Visible := False;
  sbMain.Visible := false;

  chkActive.Checked := True;

  fillGridFromDataset(zData.item);

  fillStockitemPrices;

  sbMain.SimpleText := zSortStr;

  AllowGridEdit := (ZAct <> actLookup);
  panBtn.Visible := (Zact = actLookup);
  sbMain.Visible := (Zact = actLookup);

  chkFilter;
  zFirstTime := false;

  tvData.DataController.DataModeController.GridMode := (ZAct = actLookup);
  tvData.DataController.Filter.AutoDataSetFilter := tvData.DataController.DataModeController.GridMode;
  tvData.DataController.MultiSelect := true;

  tvPrices.DataController.ClearSorting(False);
  tvPricesfromdate.SortOrder := soDescending;
  tvPrices.NewItemRow.Visible := false;

  if (TShowItemOfType.ShowAvailability in FShowItemsOfType) then
  begin
    tvDataAvailableStock.Visible := True;
    pnlInfo.Visible := true;
    labAvailFrom.Caption := DateToStr(zData.AvailabilityFrom);
    labAvailTo.Caption := DateToStr(zData.AvailabilityTo);
  end
  else
    tvDataAvailableStock.Visible := False;

  if (TShowItemOfType.NonStockitems in FShowItemsOfType) then
  begin
    tvDataAvailableStock.Visible := false;
    tvDataStockItem.Visible := false;
    tvDataTotalStock.Visible := false;
  end;

  tvDataTotalStock.Visible := not tvDataAvailableStock.Visible;

  grData.SetFocus;
end;

procedure Tfrmitems2.FillStockItemPrices;
var
  rSet: TRoomerDataset;
begin
  rSet := CreateNewDataSet;
  kbmStockItemprices.DisableControls;
  try
    if hData.rSet_bySQL(rset, 'select * from stockitemprices', true, true) then
    begin
      kbmStockitemPrices.LoadFromDataSet(rSet, []);
      kbmStockItemprices.IndexName := 'kbmStockItempricesIndex1';
    end
    else
      kbmStockItemprices.EmptyTable;

    kbmStockitemPrices.Open;

  finally
    kbmStockItemprices.EnableControls;
    rSet.Free;
  end;
end;

procedure TfrmItems2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;
  glb.EnableOrDisableTableRefresh('items', True);
end;

procedure TfrmItems2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := AssertCorrectness;
end;

procedure TfrmItems2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if m_Items.State in [dsInsert, dsEdit] then
      m_Items.Cancel
    else if kbmStockitemPrices.State in [dsInsert, dsEdit] then
      kbmStockitemPrices.Cancel
    else
      btnCancel.Click;
  end;
end;

procedure TfrmItems2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (ZAct = actLookup) and (ActiveControl <> edFilter) then
  begin
    if key = chr(13) then
      btnOk.click
    else if key = chr(27) then
      btnCancel.click;
  end;
end;


////////////////////////////////////////////////////////////////////////////////////////
// memory table
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmItems2.m_ItemsAfterPost(DataSet: TDataSet);
begin
  if zFirstTime then Exit;

  glb.ForceTableRefresh;
end;

procedure TfrmItems2.m_ItemsBeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
  if hdata.itemExistsInOther(zData.item) then
  begin
    Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['Item', zData.Description]));
    Abort;
    exit;
  end;

  s := '';
  s := s+GetTranslatedText('shDeleteItem')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if (MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrNo) or not Del_Item(zData) then
    abort;
end;

procedure TfrmItems2.m_ItemsBeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('Item').Focused := True;
end;

procedure TfrmItems2.m_StockitemPricesBeforeDelete(DataSet: TDataSet);
var
  s: string;
  lStockItemData: recStockItemPricesHolder;
begin
  s := '';
  s := s+GetTranslatedText('shDeleteStockItemPrice')+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    lStockItemData := CopyStockItemPricesToRec;
    if not Del_StockItemPrice(lStockItemData) then
      abort;
  end
  else
    abort;
end;

procedure TfrmItems2.m_StockitemPricesBeforePost(DataSet: TDataSet);
var
  lStockItemData: recStockItemPricesHolder;
  lNewID: integer;
begin
  if zFirstTime then exit;

  lStockItemData := CopyStockItemPricesToRec;
  FLocateAfterPost := lStockitemData.ID;
  case Dataset.State of
    dsEdit:   Upd_StockItemprice(lStockItemData);
    dsInsert: if Ins_StockitemPrice(lStockItemData, lnewID) then
              begin
                FLocateAfterPost := lNewID;
                kbmStockitemPricesID.AsInteger := lNewID;
              end
              else
                Abort;
  end;
end;


procedure TfrmItems2.m_ItemsBeforePost(DataSet: TDataSet);
var
 nID : integer;
 oldCode : String;
begin
  if zFirstTime then exit;
  initItemHolder(zData);

  zData := CopyDatasetToRecItem;

  if tvData.DataController.DataSource.State = dsEdit then
  begin
    oldCode := dataSet.FieldByName('Item').OldValue;
    if oldCode <> zData.Item then
      SetForeignKeyCheckValue(0);
    try
      if UPD_Item(zData) then
      begin
        if oldCode <> zData.Item then
          UpdateItemCode(oldCode, zData.Item);
         glb.ForceTableRefresh;
      end else
      begin
        abort;
        exit;
      end;
    finally
      if oldCode <> zData.Item then
        SetForeignKeyCheckValue(1);
    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if m_ItemsItemtype.AsString = ''  then
    begin
    //  showmessage('Item type is requierd - set value or use [ESC] to cancel ');
	    showmessage(GetTranslatedText('shTx_Items2_ItemTypeRequired'));
      tvData.GetColumnByFieldName('ItemType').Focused := True;
      abort;
      exit;
    end;
    if m_ItemsItem.AsString = ''  then
    begin
    //  showmessage('Item is requierd - set value or use [ESC] to cancel ');
	    showmessage(GetTranslatedText('shTx_Items2_ItemRequired'));
      tvData.GetColumnByFieldName('Item').Focused := True;
      abort;
      exit;
    end;
    if ins_Item(zData,nID) then
      m_ItemsID.AsInteger := nID
    else
      abort;
  end;
end;



procedure TfrmItems2.m_ItemsCalcFields(DataSet: TDataSet);
var
  lMaxUsage: integer;
begin
  if (TShowItemOfType.ShowAvailability in FShowItemsOfType) then
  begin
    m_Availability.DisableControls;
    try
      if m_Availability.Locate('stockitem', m_ItemsID.Asinteger, []) then
      begin
        lMaxusage := 0;
        while not m_Availability.eof and (m_AvailabilityStockitem.AsInteger = m_ItemsID.AsInteger) and (m_AvailabilityUseDate.AsDateTime <= zData.AvailabilityTo) do
        begin
          lMaxUsage := max(lMaxUsage, m_AvailabilityInUse.AsInteger);
          m_Availability.Next;
        end;

        m_ItemsAvailableStock.AsInteger:= (m_ItemsTotalStock.AsInteger - lMaxusage);

      end
      else
        m_ItemsAvailableStock.Clear;

    finally
      m_Availability.EnableControls;
    end;
  end;
end;

procedure TfrmItems2.m_ItemsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  if tvData.DataController.Filter.AutoDataSetFilter AND (edFilter.Text <> '') then
    Accept := pos(Lowercase(edFilter.Text), LowerCase(dataset['Description'])) > 0;
end;

procedure TfrmItems2.m_ItemsNewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']          := true;
  dataset['Description']     := '';
  dataset['Item']            := '';
  dataset['Price']           := 0;
  dataset['Itemtype']        := '';
  dataset['AccountKey']      := '';
  dataset['MinibarItem']     := false ;
  dataset['SystemItem']      := false ;
  dataset['RoomRentitem']    := false ;
  dataset['ReservationItem'] := false ;
  dataset['Hide']            := false ;
  dataset['Currency']        := ctrlGetString('NativeCurrency'); // nvarchar(5); //
  dataset['BookKeepCode']    := ''; // nvarchar(5); //
  dataset['NumberBase']      := 'USER_EDIT'; // nvarchar(5); //
  dataset['StocKitem']       := false;
  dataset['TotalStock']      := 0;
end;

procedure TfrmItems2.m_ItemsTotalStockGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not m_ItemsStockItem.AsBoolean then
    Text := ''
  else
    Text := m_ItemsTotalStock.asString;
end;

procedure TfrmItems2.m_StockitemPricesNewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  kbmStockitemPricesitemID.AsInteger:= m_ItemsID.AsInteger;
  kbmStockitemPricesfromdate.AsDateTime := trunc(now);
end;

procedure TfrmItems2.btnTaxLinksClick(Sender: TObject);
begin
  LinkTables('items', 'item,Description', 'ID',
                     'home100.TAXES', 'Description,Tax_Type,Amount,Tax_Base', 'ID',
                     'home100.ITEm_ItemsTAXES', 'ITEm_ItemsID', 'TAX_ID');
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmItems2.tvDataDescriptionPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  currValue := m_ItemsDescription.asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
  	errortext := GetTranslatedText('shTx_Items2_DescriptionIsRequired');
    exit;
  end;

  if hdata.RoomrateDescriptionExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;
//
  if tvData.DataController.DataSource.State = dsEdit then
  begin
    if hdata.payTypeExistsInOther(currValue) then
    begin
      error := true;
      errortext := displayvalue+' - '+GetTranslatedText('shOldValueUsedInRelatedDataC');
      exit;
    end;
  end;
end;

procedure TfrmItems2.tvDataEditing(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; var AAllow: Boolean);
begin
  with Sender.DataController do
  begin
    if (aItem.Index = tvDataPrice.index) then
      // Don't allow dirct price editing of stockitems
    begin
      aAllow := (Values[FocusedRecordIndex, tvDataStockItem.Index] = False);
      if not aAllow then // open detail view
        tvData.ViewData.Records[tvData.DataController.FocusedRecordIndex].Expand(True);

    end
    else if (aItem.Index = tvDataTotalStock.index) then
      // Only allow totalstock editing when stockitem
      aAllow := (Values[FocusedRecordIndex, tvDataStockItem.Index] = True)
    else
      aAllow := True;
  end;
end;

procedure TfrmItems2.tvDataItemPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  CurrValue : string;
begin
  DisplayValue := TRIM(DisplayValue);
  currValue := m_Items.fieldbyname('Item').asstring;

  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
	  errortext := GetTranslatedText('shTx_Items2_ItemCodeIsRequired');
    exit;
  end;

  if hdata.itemExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;
end;

procedure TfrmItems2.tvDataItemtypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recItemTypeHolder;
begin
  fillholder;
  theData.Itemtype := zData.Itemtype;
  openItemTypes(actlookup,theData);

  if theData.Itemtype <> '' then
  begin
    if tvData.DataController.DataSource.State <> dsInsert then m_Items.Edit;
    m_ItemsItemType.AsString := theData.itemType;
  end;
end;

procedure TfrmItems2.tvDataPriceCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if tvData.Datacontroller.Values[aviewinfo.gridrecord.index, tvDataStockItem.Index] then
    aCanvas.Font.Color := clLtGray;
end;

procedure TfrmItems2.GetPriceProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  AProperties := FCurrencyHandler.GetcxEditProperties;
end;

procedure TfrmItems2.tvDataDblClick(Sender: TObject);
begin
  if ZAct = actLookup then
  begin
    btnOK.Click
  end;
end;


////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////

procedure TfrmItems2.timFilterTimer(Sender: TObject);
begin
  timFilter.Enabled := False;
  m_Items.filtered := True;
  tvData.DataController.Filter.Refresh;
end;

procedure TfrmItems2.tvDataAccountKeyPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  AccountKeyValue : string;
  keyValue : TKeyAndValue;
begin
  if NOT assigned(financeLookupList) then
    financeLookupList := d.RetrieveFinancesKeypair(FKP_PRODUCTS);

  AccountKeyValue := m_ItemsAccountKey.asString;
  keyValue := selectFromKeyValuePairs('Products', AccountKeyValue, financeLookupList);
  if Assigned(keyValue) then
  begin
    m_Items.Edit;
    try
      m_ItemsAccountKey.AsString := keyValue.Key;
      m_Items.Post;
    except
      m_Items.Cancel;
      raise;
    end;
  end;
end;

procedure TfrmItems2.tvDataAvailableStockCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsEmpty(aViewInfo.Value) or VarIsNull(aViewInfo.Value) or (VarAsType( AViewInfo.Value, varInteger) < 1) then
    aCanvas.Brush.Color := clRed;
end;

procedure TfrmItems2.tvDataBookKeepCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var s : String;
begin
  s := '';
  if NOT m_Items.Eof then
    s := m_ItemsBookKeepCode.AsString;
  s := BookKeepingCodes(actLookUp, s);
  if s <> '' then
  begin
    m_Items.Edit;
    try
      m_ItemsBookKeepCode.AsString := s;
      m_Items.Post;
    except
      m_Items.Cancel;
      raise;
    end;
  end;
end;

procedure TfrmItems2.tvDataDataControllerDetailExpanding(ADataController: TcxCustomDataController;
  ARecordIndex: Integer; var AAllow: Boolean);
begin
  // Only allow when a stockitem
  aAllow := aDataController.Values[aRecordindex, tvDataStockItem.Index];
  if aAllow and (m_Items.State in [dsInsert, dsEdit]) then
    m_Items.Post;
end;

procedure TfrmItems2.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;

procedure TfrmItems2.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmItems2.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmItems2.btnCancelClick(Sender: TObject);
begin
  initItemHolder(zData);
end;

procedure TfrmItems2.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

function TfrmItems2.AssertCorrectness : Boolean;
var config : Array_Of_THotelconfigurationsEntity;
    answer : Integer;
    i: integer;
begin

  result := true;
  if Lookup then
    exit;

  config := d.roomerMainDataSet.Hotelconfigurations_Entities_FindAll;
  try
    if config[0].forceExternalProductIdCorrectness = 1 then
    begin
      m_Items.DisableControls;
      try
        screen.Cursor := crHourglass;
        m_Items.First;
        if NOT m_Items.Eof then
          if NOT assigned(financeLookupList) then
            financeLookupList := d.RetrieveFinancesKeypair(FKP_PRODUCTS);
        while NOT m_Items.Eof do
        begin
          if ((m_ItemsAccountKey.AsString = '') OR NOT d.KeyExists(financeLookupList, m_ItemsAccountKey.AsString)) and (m_ItemsActive.AsBoolean) then
          begin
            answer := MessageDlg(format('Product %s (%s) needs to have an account key for bookkeeping.', [m_ItemsItem.AsString, m_ItemsDescription.AsString]), mtWarning, [mbOk, mbIgnore, mbCancel], 0, mbOk);
            if answer = mrCancel then
            begin
              result := True;
              exit;
            end else
            if answer = mrOk then
            begin
              result := False;
              exit;
            end;
          end;
          m_Items.Next;
        end;
      finally
        screen.Cursor := crDefault;
        m_Items.EnableControls;
      end;
    end;
  finally
    for i := 0 to length(config)-1 do
      config[i].Free;
  end;
end;


procedure TfrmItems2.btnDeleteClick(Sender: TObject);
begin
  m_Items.Delete;
end;

procedure TfrmItems2.btnEditClick(Sender: TObject);
begin
  AllowGridEdit := True;
  grData.SetFocus;
  tvData.GetColumnByFieldName('Description').Focused := True;
 // showmessage('Edit in grid');
  showmessage(GetTranslatedText('shTx_Items2_EditInGrid'));
end;

procedure TfrmItems2.btnInsertClick(Sender: TObject);
begin
  AllowGridEdit := True;

  if m_Items.Active = false then m_Items.Open;
  grData.SetFocus;
  m_Items.Insert;
  tvData.GetColumnByFieldName('Item').Focused := True;
end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmItems2.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  AllowGridEdit := not mnuiAllowGridEdit.Checked;
end;


procedure TfrmItems2.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmItems2.mnuiGridToExcelClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmItems2.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmItems2.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmItems2.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

