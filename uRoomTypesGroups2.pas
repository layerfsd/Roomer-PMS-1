unit uRoomTypesGroups2;

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

  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCheckBox, cxButtonEdit, cxSpinEdit, cxCalc, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter,
  cxPropertiesStore, dxmdaset, sCheckBox, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxPScxPivotGridLnk, cxDropDownEdit, cxGridBandedTableView, cxGridDBBandedTableView,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxCurrencyEdit

  ;

type
  TfrmRoomTypesGroups2 = class(TForm)
    sPanel1: TsPanel;
    btnDelete: TsButton;
    btnOther: TsButton;
    btnClose: TsButton;
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
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    m_ID: TIntegerField;
    m_Active: TBooleanField;
    m_Description: TWideStringField;
    m_color: TWideStringField;
    m_Code: TWideStringField;
    m_PriorityRule: TWideStringField;
    m_MaxCount: TIntegerField;
    m_minGuests: TIntegerField;
    m_maxGuests: TIntegerField;
    m_maxChildren: TIntegerField;
    tvDataDescription: TcxGridDBColumn;
    tvDataPriorityRule: TcxGridDBColumn;
    tvDataminGuests: TcxGridDBColumn;
    tvDatamaxGuests: TcxGridDBColumn;
    tvDatamaxChildren: TcxGridDBColumn;
    tvDataMaxCount: TcxGridDBColumn;
    tvDatacolor: TcxGridDBColumn;
    tvDatanumGuests: TcxGridDBColumn;
    tvDataAvailabilityTypes: TcxGridDBColumn;
    tvDatadefAvailability: TcxGridDBColumn;
    tvDatadefStopSale: TcxGridDBColumn;
    tvDatadefRate: TcxGridDBColumn;
    tvDatadefMinStay: TcxGridDBColumn;
    tvDatadefMaxAvailability: TcxGridDBColumn;
    tvDataNonRefundable: TcxGridDBColumn;
    tvDataAutoChargeCreditcards: TcxGridDBColumn;
    tvDataRateExtraBed: TcxGridDBColumn;
    tvDataColumn1: TcxGridDBColumn;
    tvDatasendAvailability: TcxGridDBColumn;
    tvDatasendRate: TcxGridDBColumn;
    tvDatasendStopSell: TcxGridDBColumn;
    tvDatasendMinStay: TcxGridDBColumn;
    tvDataDetailedDescriptionHtml: TcxGridDBColumn;
    tvDataDetailedDescription: TcxGridDBColumn;
    tvDataBreakfastIncluded: TcxGridDBColumn;
    tvDataHalfBoard: TcxGridDBColumn;
    tvDataFullBoard: TcxGridDBColumn;
    btnInsert: TsButton;
    btnEdit: TsButton;
    m_numGuests: TIntegerField;
    m_TopClass: TWideStringField;
    m_AvailabilityTypes: TWideStringField;
    FormStore: TcxPropertiesStore;
    m_defAvailability: TIntegerField;
    m_defStopSale: TBooleanField;
    m_defRate: TFloatField;
    m_defMinStay: TIntegerField;
    m_defMaxAvailability: TIntegerField;
    m_NonRefundable: TBooleanField;
    m_AutoChargeCreditcards: TBooleanField;
    m_RateExtraBed: TFloatField;
    m_PhotoUri: TWideStringField;
    m_sendAvailability: TBooleanField;
    m_sendRate: TBooleanField;
    m_sendStopSell: TBooleanField;
    m_sendMinStay: TBooleanField;
    m_DetailedDescriptionHtml: TWideStringField;
    m_DetailedDescription: TWideStringField;
    m_BreakfastIncluded: TBooleanField;
    m_HalfBoard: TBooleanField;
    m_FullBoard: TBooleanField;
    pnlHolder: TsPanel;
    m_Package: TWideStringField;
    tvDataPackage: TcxGridDBColumn;
    m_OrderIndex: TIntegerField;
    m_connectRateToMasterRate: TBooleanField;
    m_masterRateRateDeviation: TFloatField;
    m_RateDeviationType: TWideStringField;
    m_connectSingleUseRateToMasterRate: TBooleanField;
    m_masterRateSingleUseRateDeviation: TFloatField;
    m_singleUseRateDeviationType: TWideStringField;
    m_connectAvailabilityToMasterRate: TBooleanField;
    m_connectStopSellToMasterRate: TBooleanField;
    m_connectMinStayToMasterRate: TBooleanField;
    m_connectMaxStayToMasterRate: TBooleanField;
    m_connectCOAToMasterRate: TBooleanField;
    m_connectCODToMasterRate: TBooleanField;
    m_connectLOSToMasterRate: TBooleanField;
    tvDataconnectRateToMasterRate: TcxGridDBColumn;
    tvDatamasterRateRateDeviation: TcxGridDBColumn;
    tvDataRateDeviationType: TcxGridDBColumn;
    tvDataconnectSingleUseRateToMasterRate: TcxGridDBColumn;
    tvDatamasterRateSingleUseRateDeviation: TcxGridDBColumn;
    tvDatasingleUseRateDeviationType: TcxGridDBColumn;
    tvDataconnectAvailabilityToMasterRate: TcxGridDBColumn;
    tvDataconnectStopSellToMasterRate: TcxGridDBColumn;
    tvDataconnectMinStayToMasterRate: TcxGridDBColumn;
    tvDataconnectMaxStayToMasterRate: TcxGridDBColumn;
    tvDataconnectCOAToMasterRate: TcxGridDBColumn;
    tvDataconnectCODToMasterRate: TcxGridDBColumn;
    tvDataconnectLOSToMasterRate: TcxGridDBColumn;
    tvDataRecId: TcxGridDBColumn;
    tvDataID: TcxGridDBColumn;
    tvDataActive: TcxGridDBColumn;
    tvDataCode: TcxGridDBColumn;
    tvDataTopClass: TcxGridDBColumn;
    tvDataOrderIndex: TcxGridDBColumn;
    m_RATE_PLAN_TYPE: TWideStringField;
    tvDataRATE_PLAN_TYPE: TcxGridDBColumn;
    m_defMaxStay: TIntegerField;
    m_defClosedToArrival: TBooleanField;
    m_defClosedToDeparture: TBooleanField;
    tvDatadefMaxStay: TcxGridDBColumn;
    tvDatadefClosedToArrival: TcxGridDBColumn;
    tvDatadefClosedToDeparture: TcxGridDBColumn;
    tvDataColumn2: TcxGridDBColumn;
    m_PAYMENTS_REQUIRED: TWideStringField;
    tvDataPAYMENTS_REQUIRED: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure m_BeforeDelete(DataSet: TDataSet);
    procedure m_BeforeInsert(DataSet: TDataSet);
    procedure m_BeforePost(DataSet: TDataSet);
    procedure m_NewRecord(DataSet: TDataSet);
    procedure tvDataDblClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tvDataFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvDataDataControllerFilterChanged(Sender: TObject);
    procedure tvDataDataControllerSortingChanged(Sender: TObject);
    procedure btnOtherClick(Sender: TObject);
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
    procedure btnInsertClick(Sender: TObject);
    procedure tvDataCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tvDataTopClassPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataAvailabilityTypesPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataPriorityRulePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataColumn1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataDetailedDescriptionHtmlPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataDetailedDescriptionPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnCloseClick(Sender: TObject);
    procedure tvDataPackagePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataRATE_PLAN_TYPEPropertiesCloseUp(Sender: TObject);
    procedure m_AfterScroll(DataSet: TDataSet);
    procedure tvDataColumn2PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tvDataPAYMENTS_REQUIREDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure tvDataBreakfastIncludedPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    zFirstTime       : boolean;
    zAllowGridEdit   : boolean;
    zFilterOn        : boolean;
    zSortStr         : string;
    zIsAddRow        : boolean;

    Procedure fillGridFromDataset(iGoto : String);
    procedure fillHolder;
    procedure changeAllowgridEdit;
    Procedure chkFilter;
    procedure applyFilter;
    procedure SetEditedValuesIn_M_Dataset;
    procedure FetchRatePlanTypes;
    procedure FillDataHolderFromDataSet(dataset : TDataSet);
    procedure NotifyDoesNotChangeOTAs;

  public
    { Public declarations }
    zAct   : TActTableAction;
    zData  : recRoomTypeGroupHolder;

    embedded : Boolean;
    EmbedWindowCloseEvent : TNotifyEvent;

    procedure PrepareUserInterface;
    procedure BringWindowToFront;
  end;

function openRoomTypeGroups(act : TActTableAction; var theData : recRoomTypeGroupHolder;
        embedPanel : TsPanel = nil;
        WindowCloseEvent : TNotifyEvent = nil) : boolean;

var
  frmRoomTypesGroups2: TfrmRoomTypesGroups2;
  frmRoomTypesGroups2X: TfrmRoomTypesGroups2;

implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uSqlDefinitions
  , uCurrencies
  , uMultiSelection
  , udImages
  , uFrmResources
  , uFrmNotepad
  , uMain
  , uPackages
  , uRoomClassEdit
  , uResourceManagement
  , uDynamicPricing
  , UITypes
  , uActivityLogs

  , ufrmPaymentReqRoomtypeGroup;


//////////////////////////////////////////////////////////////////////////////////////////////
//  unit global functions
//////////////////////////////////////////////////////////////////////////////////////////////

function openRoomTypeGroups(act : TActTableAction; var theData : recRoomTypeGroupHolder; embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil) : boolean;
var _frmRoomTypesGroups2: TfrmRoomTypesGroups2;
begin
  result := false;
  _frmRoomTypesGroups2 := TfrmRoomTypesGroups2.Create(nil);
  try
    _frmRoomTypesGroups2.zData := theData;
    _frmRoomTypesGroups2.zAct := act;
    _frmRoomTypesGroups2.embedded := (act = actNone) AND
                                    (embedPanel <> nil);
    _frmRoomTypesGroups2.EmbedWindowCloseEvent := WindowCloseEvent;
    if _frmRoomTypesGroups2.embedded then
    begin
      _frmRoomTypesGroups2.pnlHolder.parent := embedPanel;
      embedPanel.Update;
      frmRoomTypesGroups2X := _frmRoomTypesGroups2;
    end
    else
    begin
      _frmRoomTypesGroups2.PrepareUserInterface;
      _frmRoomTypesGroups2.ShowModal;
      if _frmRoomTypesGroups2.modalresult = mrOk then
      begin
        theData := _frmRoomTypesGroups2.zData;
        result := true;
      end
      else
      begin
        initRoomTypeGroupHolder(theData);
      end;
    end;
  finally
    if (act <> actNone) OR
      (embedPanel = nil) then
      freeandnil(_frmRoomTypesGroups2);
  end;
end;


///////////////////////////////////////////////////////////////////////
                    { Private declarations }
///////////////////////////////////////////////////////////////////////


Procedure TfrmRoomTypesGroups2.fillGridFromDataset(iGoto : String);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  zFirstTime := true;
  if zSortStr = '' then zSortStr := 'ID';
  rSet := CreateNewDataSet;
  try
    s := format(select_RoomTypesGroups, [zSortStr]);
    CopyToClipboard(s);
//    debugMessage()
    if rSet_bySQL(rSet,s, false) then
    begin
      if m_.active then m_.Close;
      m_.Open;
      rSet.First;
      while not rSet.Eof do
      begin
        m_.append;
        m_.FieldByName('ID').AsInteger              := rSet.FieldByName('ID').AsInteger               ;
        m_.FieldByName('Active').AsBoolean          := rSet.FieldByName('Active').AsBoolean           ;
        m_.FieldByName('Description').AsString      := rSet.FieldByName('Description').AsString       ;
        m_.FieldByName('color').AsString            := rSet.FieldByName('color').AsString             ;
        m_.FieldByName('Code').AsString             := rSet.FieldByName('Code').AsString              ;
        m_.FieldByName('TopClass').AsString         := rSet.FieldByName('TopClass').AsString          ;
        m_.FieldByName('PriorityRule').AsString     := rSet.FieldByName('PriorityRule').AsString      ;
        m_.FieldByName('MaxCount').AsInteger        := rSet.FieldByName('MaxCount').AsInteger         ;
        m_.FieldByName('numGuests').AsInteger       := rSet.FieldByName('numGuests').AsInteger        ;
        m_.FieldByName('minGuests').AsInteger       := rSet.FieldByName('minGuests').AsInteger        ;
        m_.FieldByName('maxGuests').AsInteger       := rSet.FieldByName('maxGuests').AsInteger        ;
        m_.FieldByName('maxChildren').AsInteger     := rSet.FieldByName('maxChildren').AsInteger      ;
        m_.FieldByName('AvailabilityTypes').AsString:= rSet.FieldByName('AvailabilityTypes').AsString ;
        m_.FieldByName('BreakfastIncluded').AsString:= rSet.FieldByName('BreakfastIncluded').AsString ;
        m_.FieldByName('HalfBoard').AsString:= rSet.FieldByName('HalfBoard').AsString ;
        m_.FieldByName('FullBoard').AsString:= rSet.FieldByName('FullBoard').AsString ;
        m_.FieldByName('defAvailability').AsInteger := rSet.FieldByName('defAvailability').AsInteger  ;
        m_.FieldByName('defStopSale').asBoolean     := rSet.FieldByName('defStopSale').AsBoolean      ;
        m_.FieldByName('defRate').asfloat           := rSet.GetFloatValue(rSet.FieldByName('defRate'))           ;
        m_.FieldByName('defMaxAvailability').AsInteger := rSet.FieldByName('defMaxAvailability').AsInteger  ;
        m_.FieldByName('defMinStay').AsInteger         := rSet.FieldByName('defMinStay').AsInteger  ;
        m_.FieldByName('defMaxStay').AsInteger         := rSet.FieldByName('defMaxStay').AsInteger  ;
        m_.FieldByName('defClosedToArrival').asBoolean     := rSet.FieldByName('defClosedToArrival').AsBoolean      ;
        m_.FieldByName('defClosedToDeparture').asBoolean     := rSet.FieldByName('defClosedToDeparture').AsBoolean      ;
        m_.FieldByName('NonRefundable').asBoolean     := rSet.FieldByName('NonRefundable').AsBoolean      ;
        m_.FieldByName('AutoChargeCreditcards').asBoolean     := rSet.FieldByName('AutoChargeCreditcards').AsBoolean      ;
        m_.FieldByName('RateExtraBed').asfloat           := rSet.GetFloatValue(rSet.FieldByName('RateExtraBed'))          ;
        m_.FieldByName('PhotoUri').AsString     := rSet.FieldByName('PhotoUri').AsString      ;
        m_.FieldByName('sendAvailability').asBoolean     := rSet.FieldByName('sendAvailability').AsBoolean      ;
        m_.FieldByName('sendRate').asBoolean     := rSet.FieldByName('sendRate').AsBoolean      ;
        m_.FieldByName('sendStopSell').asBoolean     := rSet.FieldByName('sendStopSell').AsBoolean      ;
        m_.FieldByName('sendMinStay').asBoolean     := rSet.FieldByName('sendMinStay').AsBoolean      ;
        m_.FieldByName('DetailedDescriptionHtml').asString     := rSet.FieldByName('DetailedDescriptionHtml').AsString      ;
        m_.FieldByName('DetailedDescription').asString     := rSet.FieldByName('DetailedDescription').AsString      ;
        m_.FieldByName('Package').asString     := rSet.FieldByName('Package').AsString      ;
        m_.FieldByName('OrderIndex').asInteger     := rSet.FieldByName('OrderIndex').AsInteger      ;
        m_.FieldByName('PAYMENTS_REQUIRED').asString     := rSet.FieldByName('PAYMENTS_REQUIRED').AsString      ;


        m_['connectRateToMasterRate'] := rSet['connectRateToMasterRate'];
        m_['masterRateRateDeviation'] := rSet['masterRateRateDeviation'];
        m_['RateDeviationType'] := rSet['RateDeviationType'];
        m_['connectSingleUseRateToMasterRate'] := rSet['connectSingleUseRateToMasterRate'];
        m_['masterRateSingleUseRateDeviation'] := rSet['masterRateSingleUseRateDeviation'];
        m_['singleUseRateDeviationType'] := rSet['singleUseRateDeviationType'];
        m_['connectStopSellToMasterRate'] := rSet['connectStopSellToMasterRate'];
        m_['connectAvailabilityToMasterRate'] := rSet['connectAvailabilityToMasterRate'];
        m_['connectMinStayToMasterRate'] := rSet['connectMinStayToMasterRate'];
        m_['connectMaxStayToMasterRate'] := rSet['connectMaxStayToMasterRate'];
        m_['connectCOAToMasterRate'] := rSet['connectCOAToMasterRate'];
        m_['connectCODToMasterRate'] := rSet['connectCODToMasterRate'];
        m_['connectLOSToMasterRate'] := rSet['connectLOSToMasterRate'];
        m_['RATE_PLAN_TYPE'] := rSet['RATE_PLAN_TYPE'];

        m_.Post;
        rSet.Next;
      end;
      if iGoto = '' then
      begin
        m_.First;
      end else
      begin
        try
          m_.Locate('Code',iGoto,[]);
        except
        end;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
end;


procedure TfrmRoomTypesGroups2.fillHolder;
begin
  initRoomTypeGroupHolder(zData);
  zData.ID            := m_.FieldByName('ID').AsInteger;
  zData.Active        := m_['Active'];
  zData.Description   := m_['Description'];
  zData.color         := m_['color'];
  zData.Code          := m_['Code'];
  zData.TopClass      := m_['TopClass'];
  zData.numGuests     := m_['numGuests'];
  zData.PriorityRule  := m_['PriorityRule'];
  zData.MaxCount      := m_['MaxCount'];
  zData.minGuests     := m_['minGuests'];
  zData.maxGuests     := m_['maxGuests'];
  zData.maxChildren   := m_['maxChildren'];
  zData.AvailabilityTypes := m_['AvailabilityTypes'];
  zData.BreakfastIncluded := m_['BreakfastIncluded'];
  zData.HalfBoard := m_['HalfBoard'];
  zData.FullBoard := m_['FullBoard'];
  zData.defAvailability := m_['defAvailability'];
  zData.defStopSale := m_['defStopSale'];
  zData.defRate := m_.FieldByName('defRate').asFloat;
  zData.defMaxAvailability := m_['defMaxAvailability'];
  zData.defMinStay := m_['defMinStay'];
  zData.defMaxStay := m_['defMaxStay'];
  zData.defClosedToArrival := m_['defClosedToArrival'];
  zData.defClosedToDeparture := m_['defClosedToDeparture'];
  zData.NonRefundable := m_['NonRefundable'];
  zData.AutoChargeCreditcards := m_['AutoChargeCreditcards'];
  zData.RateExtraBed := m_['RateExtraBed'];
  zData.PhotoUri := m_['PhotoUri'];
  zData.sendAvailability := m_['sendAvailability'];
  zData.sendRate := m_['sendRate'];
  zData.sendStopSell := m_['sendStopSell'];
  zData.sendMinStay := m_['sendMinStay'];
  zData.DetailedDescriptionHtml := m_['DetailedDescriptionHtml'];
  zData.DetailedDescription := m_['DetailedDescription'];
  zData.Package := m_['Package'];
  zData.OrderIndex := m_['OrderIndex'];
  zData.connectRateToMasterRate := m_['connectRateToMasterRate'];
  zData.masterRateRateDeviation := m_['masterRateRateDeviation'];
  zData.RateDeviationType := m_['RateDeviationType'];
  zData.connectSingleUseRateToMasterRate := m_['connectSingleUseRateToMasterRate'];
  zData.masterRateSingleUseRateDeviation := m_['masterRateSingleUseRateDeviation'];
  zData.singleUseRateDeviationType := m_['singleUseRateDeviationType'];
  zData.connectStopSellToMasterRate := m_['connectStopSellToMasterRate'];
  zData.connectAvailabilityToMasterRate := m_['connectAvailabilityToMasterRate'];
  zData.connectMinStayToMasterRate := m_['connectMinStayToMasterRate'];
  zData.connectMaxStayToMasterRate := m_['connectMaxStayToMasterRate'];
  zData.connectCOAToMasterRate := m_['connectCOAToMasterRate'];
  zData.connectCODToMasterRate := m_['connectCODToMasterRate'];
  zData.connectLOSToMasterRate := m_['connectLOSToMasterRate'];
  zData.RATE_PLAN_TYPE := m_['RATE_PLAN_TYPE'];

end;



procedure TfrmRoomTypesGroups2.changeAllowgridEdit;
begin
    tvDataID.Options.Editing             := false;
    tvDataRATE_PLAN_TYPE.Options.Editing         := zAllowGridEdit;

    tvDataRecId.Options.Editing         := zAllowGridEdit;
    tvDataActive.Options.Editing         := zAllowGridEdit;
    tvDataCode.Options.Editing         := zAllowGridEdit;
    tvDataDescription.Options.Editing         := zAllowGridEdit;
    tvDataPriorityRule.Options.Editing         := zAllowGridEdit;
    tvDataminGuests.Options.Editing         := zAllowGridEdit;
    tvDatamaxGuests.Options.Editing         := zAllowGridEdit;
    tvDatamaxChildren.Options.Editing         := zAllowGridEdit;
    tvDataMaxCount.Options.Editing         := zAllowGridEdit;
    tvDatacolor.Options.Editing         := zAllowGridEdit;
    tvDatanumGuests.Options.Editing         := zAllowGridEdit;
    tvDataTopClass.Options.Editing         := zAllowGridEdit;
    tvDataAvailabilityTypes.Options.Editing         := zAllowGridEdit;
    tvDatadefAvailability.Options.Editing         := zAllowGridEdit;
    tvDatadefStopSale.Options.Editing         := zAllowGridEdit;
    tvDatadefRate.Options.Editing         := zAllowGridEdit;
    tvDatadefMinStay.Options.Editing         := zAllowGridEdit;
    tvDatadefMaxStay.Options.Editing         := zAllowGridEdit;
    tvDatadefClosedToArrival.Options.Editing         := zAllowGridEdit;
    tvDatadefClosedToDeparture.Options.Editing         := zAllowGridEdit;
    tvDatadefMaxAvailability.Options.Editing         := zAllowGridEdit;
    tvDataNonRefundable.Options.Editing         := zAllowGridEdit;
    tvDataAutoChargeCreditcards.Options.Editing         := zAllowGridEdit;
    tvDataRateExtraBed.Options.Editing         := zAllowGridEdit;
//    tvDataPhotoUri.Options.Editing         := zAllowGridEdit;
    tvDataColumn1.Options.Editing         := zAllowGridEdit;
    tvDatasendAvailability.Options.Editing         := zAllowGridEdit;
    tvDatasendRate.Options.Editing         := zAllowGridEdit;
    tvDatasendStopSell.Options.Editing         := zAllowGridEdit;
    tvDatasendMinStay.Options.Editing         := zAllowGridEdit;
    tvDataDetailedDescriptionHtml.Options.Editing         := zAllowGridEdit;
    tvDataDetailedDescription.Options.Editing         := zAllowGridEdit;
    tvDataBreakfastIncluded.Options.Editing         := zAllowGridEdit;
    tvDataHalfBoard.Options.Editing         := zAllowGridEdit;
    tvDataFullBoard.Options.Editing         := zAllowGridEdit;
    tvDataPackage.Options.Editing         := zAllowGridEdit;
    tvDataOrderIndex.Options.Editing         := zAllowGridEdit;
    tvDataconnectRateToMasterRate.Options.Editing         := zAllowGridEdit;
    tvDatamasterRateRateDeviation.Options.Editing         := zAllowGridEdit;
    tvDataRateDeviationType.Options.Editing         := zAllowGridEdit;
    tvDataconnectSingleUseRateToMasterRate.Options.Editing         := zAllowGridEdit;
    tvDatamasterRateSingleUseRateDeviation.Options.Editing         := zAllowGridEdit;
    tvDatasingleUseRateDeviationType.Options.Editing         := zAllowGridEdit;
    tvDataconnectStopSellToMasterRate.Options.Editing         := zAllowGridEdit;
    tvDataconnectAvailabilityToMasterRate.Options.Editing         := zAllowGridEdit;
    tvDataconnectMinStayToMasterRate.Options.Editing         := zAllowGridEdit;
    tvDataconnectMaxStayToMasterRate.Options.Editing         := zAllowGridEdit;
    tvDataconnectCOAToMasterRate.Options.Editing         := zAllowGridEdit;
    tvDataconnectCODToMasterRate.Options.Editing         := zAllowGridEdit;
    tvDataconnectLOSToMasterRate.Options.Editing         := zAllowGridEdit;
end;


procedure TfrmRoomTypesGroups2.chkFilter;
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
  end else
  begin
  end;
end;


procedure TfrmRoomTypesGroups2.edFilterChange(Sender: TObject);
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

procedure TfrmRoomTypesGroups2.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataDescription,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


/////////////////////////////////////////////////////////////
// Form actions
/////////////////////////////////////////////////////////////

procedure TfrmRoomTypesGroups2.FormCreate(Sender: TObject);
begin
  embedded := False;
  EmbedWindowCloseEvent := nil;
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  //**
  zFirstTime  := true;
  zAct        := actNone;
  zisAddrow   := false;

  PrepareUserInterface;
end;

procedure TfrmRoomTypesGroups2.FetchRatePlanTypes;
var rSet : TRoomerDataset;
begin
  (tvDataRATE_PLAN_TYPE.Properties AS TcxComboBoxProperties).Items.Clear;
  rSet := CreateNewDataset;
  try
    if rSet_bySQL(rSet,'SELECT * FROM home100.RATE_PLAN_TYPES ORDER BY SORT_INDEX', false) then
    begin
      rSet.First;
      while NOT rSet.Eof do
      begin
        (tvDataRATE_PLAN_TYPE.Properties AS TcxComboBoxProperties).Items.Add(rSet['CODE']);
        rSet.Next;
      end;
    end;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure TfrmRoomTypesGroups2.PrepareUserInterface;
begin
//**
  tvDatasendAvailability.Visible := NOT frmMain.RBEMode;
  tvDatasendRate.Visible := NOT frmMain.RBEMode;
  tvDatasendStopSell.Visible := NOT frmMain.RBEMode;
  tvDatasendMinStay.Visible := NOT frmMain.RBEMode;

  panBtn.Visible := False;
  sbMain.Visible := false;
  btnClose.Visible := False;

  FetchRatePlanTypes;
  fillGridFromDataset(zData.Code);
  zFirstTime := true;
  sbMain.SimpleText := zSortStr;

  if ZAct = actLookup then
  begin
    mnuiAllowGridEdit.Checked := false;
    panBtn.Visible := true;
  end else
  begin
    mnuiAllowGridEdit.Checked := false;
    btnClose.Visible := embedded;
    sbMain.Visible := true;
  end;
  //-C
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
  chkFilter;
  zFirstTime := false;
end;

procedure TfrmRoomTypesGroups2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tvdata.DataController.DataSet.State = dsInsert then
  begin
    tvdata.DataController.Post;
  end;
  if tvdata.DataController.DataSet.State = dsEdit then
  begin
    tvdata.DataController.Post;
  end;

  pnlHolder.Parent := self;
  update;
  if embedded then
    Action := caFree;
  if Assigned(EmbedWindowCloseEvent) then
    EmbedWindowCloseEvent(self);
end;

procedure TfrmRoomTypesGroups2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;

end;

procedure TfrmRoomTypesGroups2.FormKeyPress(Sender: TObject; var Key: Char);
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


procedure TfrmRoomTypesGroups2.FillDataHolderFromDataSet(dataset : TDataSet);
begin
  if (NOT dataset.Eof) then
  begin
    zData.ID                := dataset.FieldByName('ID').AsInteger;
    zData.Active            := dataset['Active'];
    zData.Description       := dataset['Description'];
    zData.color             := dataset['color'];
    zData.Code              := dataset['Code'];
    zData.TopClass          := dataset['TopClass'];
    zData.PriorityRule      := dataset['PriorityRule'];
    zData.MaxCount          := dataset['MaxCount'];
    zData.numGuests         := dataset['numGuests'];
    zData.minGuests         := dataset['minGuests'];
    zData.maxGuests         := dataset['maxGuests'];
    zData.maxChildren       := dataset['maxChildren'];
    zData.AvailabilityTypes := dataset['AvailabilityTypes'];
    zData.BreakfastIncluded := dataset['BreakfastIncluded'];
    zData.HalfBoard         := dataset['HalfBoard'];
    zData.FullBoard         := dataset['FullBoard'];
    zData.defAvailability   := dataset['defAvailability'];
    zData.defStopSale       := dataset['defStopSale'];
    zData.defRate           := dataset.FieldByName('defRate').asfloat;
    zData.defMaxAvailability := m_['defMaxAvailability'];
    zData.defMinStay         := m_['defMinStay'];
    zData.defMaxStay         := m_['defMaxStay'];
    zData.defClosedToArrival         := m_['defClosedToArrival'];
    zData.defClosedToDeparture         := m_['defClosedToDeparture'];
    zData.NonRefundable         := m_['NonRefundable'];
    zData.AutoChargeCreditcards         := m_['AutoChargeCreditcards'];
    zData.RateExtraBed         := m_['RateExtraBed'];
    zData.PhotoUri         := m_['PhotoUri'];
    zData.sendAvailability := m_['sendAvailability'];
    zData.sendRate := m_['sendRate'];
    zData.sendStopSell := m_['sendStopSell'];
    zData.sendMinStay := m_['sendMinStay'];
    zData.DetailedDescriptionHtml := m_['DetailedDescriptionHtml'];
    zData.DetailedDescription := m_['DetailedDescription'];
    zData.Package := m_['Package'];
    zData.OrderIndex := m_['OrderIndex'];

    zData.connectRateToMasterRate := m_['connectRateToMasterRate'];
    zData.masterRateRateDeviation := m_['masterRateRateDeviation'];
    zData.RateDeviationType := m_['RateDeviationType'];
    zData.connectSingleUseRateToMasterRate := m_['connectSingleUseRateToMasterRate'];
    zData.masterRateSingleUseRateDeviation := m_['masterRateSingleUseRateDeviation'];
    zData.singleUseRateDeviationType := m_['singleUseRateDeviationType'];
    zData.connectStopSellToMasterRate := m_['connectStopSellToMasterRate'];
    zData.connectAvailabilityToMasterRate := m_['connectAvailabilityToMasterRate'];
    zData.connectMinStayToMasterRate := m_['connectMinStayToMasterRate'];
    zData.connectMaxStayToMasterRate := m_['connectMaxStayToMasterRate'];
    zData.connectCOAToMasterRate := m_['connectCOAToMasterRate'];
    zData.connectCODToMasterRate := m_['connectCODToMasterRate'];
    zData.connectLOSToMasterRate := m_['connectLOSToMasterRate'];
    zData.RATE_PLAN_TYPE := m_['RATE_PLAN_TYPE'];
//    zData.prepaidPercentage := m_['prepaidPercentage'];
  end;
end;

procedure TfrmRoomTypesGroups2.m_AfterScroll(DataSet: TDataSet);
begin
  if (m_.State = dsInsert) OR
     (m_.State = dsEdit) then exit;

  FillDataHolderFromDataSet(DataSet);
end;

procedure TfrmRoomTypesGroups2.m_BeforeDelete(DataSet: TDataSet);
var
  s : string;
begin
  fillHolder;
(*
  if hdata.payTypeExistsInOther(zData.PayType) then
  begin
    Showmessage('payType'+' ' + zData.Description + ' '+GetTranslatedText('shExistsInRelatedData')+' ' + chr(10) + GetTranslatedText('shCanNotDelete')+' ');
    Abort;
    exit;
  end;
*)

  s := '';
  s := s+GetTranslatedText('shDeleteRoomClass')+' '+zData.Description+' '+chr(10);
  s := s+GetTranslatedText('shContinue');

  if MessageDlg(s,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not Del_RoomTypeGroup(zData) then
    begin
      abort;
      exit;
    end;
    glb.LogChanges(DataSet, 'roomtypegroups', DELETE_RECORD, '');
  end else
  begin
    abort
  end;
end;

procedure TfrmRoomTypesGroups2.m_BeforeInsert(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  tvData.GetColumnByFieldName('code').Focused := True;
end;
procedure TfrmRoomTypesGroups2.m_BeforePost(DataSet: TDataSet);
var
  nID : integer;
  OldCode, oldTop : String;
begin
  if zFirstTime then exit;

  OldCode := zData.Code;
  initRoomTypeGroupHolder(zData);
  FillDataHolderFromDataSet(DataSet);

  if tvData.DataController.DataSource.State = dsEdit then
  begin
//    d.roomerMainDataSet.SystemStartTransaction;
//    try
//      if OldCode <> zData.Code then
//        if glb.KeyAlreadyExistsInAnotherRecord('roomtypegroups', 'Code', zData.Code, zData.id) then
//        begin
//          showmessage(GetTranslatedText('shTx_RoomtypeGroups_RoomTypeGroupAlreadyExists'));
//          tvData.GetColumnByFieldName('Code').Focused := True;
//          abort;
//          exit;
//        end;
      glb.LogChanges(DataSet, 'roomtypegroups', CHANGE_FIELD, '');
      oldTop := dataSet.FieldByName('TopClass').OldValue;
      oldCode := dataSet.FieldByName('Code').OldValue;
      if oldCode <> zData.Code then
        SetForeignKeyCheckValue(0);
      try
      if UPD_roomTypeGroup(zData) then
      begin
//        if OldCode <> zData.Code then
//          CorrectRoomTypeGroups(OldCode, zData.Code);
//        d.roomerMainDataSet.SystemCommitTransaction;
        glb.LogChanges(DataSet, 'roomtypegroups', CHANGE_FIELD, '');
        if oldCode <> zData.Code then
          UpdateRoomTypeGroupCode(oldCode, zData.Code);
        if oldTop <> zData.TopClass then
          Set2RoomTypeGroupDity(oldTop, zData.TopClass);
        glb.ForceTableRefresh;
      end else
      begin
        abort;
        exit;
      end;
      finally
        if oldCode <> zData.Code then
          SetForeignKeyCheckValue(1);
      end;
//    except
//      d.roomerMainDataSet.SystemRollbackTransaction;
//    end;
  end;
  if tvData.DataController.DataSource.State = dsInsert then
  begin
    if dataset.FieldByName('Code').AsString = ''  then
    begin
  	  showmessage(GetTranslatedText('shTx_RoomTypeGroups2_RoomclassRequired'));
      tvData.GetColumnByFieldName('code').Focused := True;
      abort;
      exit;
    end;
    if glb.LocateSpecificRecord('roomtypegroups', 'Code', dataset.FieldByName('Code').AsString)  then
    begin
	    showmessage(GetTranslatedText('shTx_RoomtypeGroups_RoomTypeGroupAlreadyExists'));
      tvData.GetColumnByFieldName('Code').Focused := True;
      abort;
      exit;
    end;
    if ins_roomTypeGroup(zData,nID) then
    begin
      m_.fieldByName('ID').AsInteger := nID;
      glb.LogChanges(DataSet, 'roomtypegroups', ADD_RECORD, '');
      glb.ForceTableRefresh;
    end else
    begin
      abort;
      exit;
    end;
  end;
end;

procedure TfrmRoomTypesGroups2.m_NewRecord(DataSet: TDataSet);
begin
  if zFirstTime then exit;
  dataset['Active']        := true;
  dataset['Description']   := '';
  dataset['color']         := '';
  dataset['Code']          := '';
  dataset['TopClass']      := '';
  dataset['PriorityRule']  := '';
  dataset['MaxCount']      := 0;
  dataset['numGuests']     := 2;
  dataset['minGuests']     := 0;
  dataset['maxGuests']     := 2;
  dataset['maxChildren']   := 1;
  dataset['AvailabilityTypes'] := '';
  dataset['BreakfastIncluded'] := False;
  dataset['HalfBoard'] := False;
  dataset['FullBoard'] := False;
  dataset['defRate']         := 0.00;
  dataset['defAvailability'] := 0;
  dataset['defStopSale']     := false;
  dataset['defMaxAvailability'] := 0;
  dataset['defMinStay']         := 0;
  dataset['defMaxStay']         := 0;
  dataset['defClosedToArrival']         := False;
  dataset['defClosedToDeparture']         := False;
  dataset['NonRefundable'] := False;
  dataset['AutoChargeCreditcards'] := False;
  dataset['RateExtraBed'] := 0.00;
  dataset['PhotoUri'] := '';
  dataset['sendAvailability'] := true;
  dataset['sendRate'] := true;
  dataset['sendStopSell'] := true;
  dataset['sendMinStay'] := true;
  dataset['DetailedDescriptionHtml'] := '';
  dataset['DetailedDescription'] := '';
  dataset['Package'] := '';
  dataset['OrderIndex'] := 0;
  dataset['connectRateToMasterRate'] := false;
  dataset['masterRateRateDeviation'] := 0.00;
  dataset['RateDeviationType'] := 'PERCENTAGE';
  dataset['connectSingleUseRateToMasterRate'] := false;
  dataset['masterRateSingleUseRateDeviation'] := 0.00;
  dataset['singleUseRateDeviationType'] := 'PERCENTAGE';
  dataset['connectStopSellToMasterRate'] := false;
  dataset['connectAvailabilityToMasterRate'] := false;
  dataset['connectMinStayToMasterRate'] := false;
  dataset['connectMaxStayToMasterRate'] := false;
  dataset['connectCOAToMasterRate'] := false;
  dataset['connectCODToMasterRate'] := false;
  dataset['connectLOSToMasterRate'] := false;
  dataset['RATE_PLAN_TYPE'] := 'STANDARD';
end;

////////////////////////////////////////////////////////////////////////////////////////
//  table View Functions
////////////////////////////////////////////////////////////////////////////////////////

procedure TfrmRoomTypesGroups2.tvDataFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if AFocusedRecord = nil then
  begin
    zIsAddrow := true;
  end else
  begin
    zIsAddrow := false;
  end;
end;

procedure TfrmRoomTypesGroups2.tvDataPackagePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  theData : recPackageHolder;
begin
  initPackageHolder(thedata);
  theData.package := m_.FieldByName('Package').AsString;
  if openPackages(actLookup,theData) AND
     (theData.package <> m_.FieldByName('Package').AsString) then
     begin
        m_.Edit;
        m_['Package'] := theData.package;
        m_['defRate'] := GetPackagetPrice(theData.package, '(SELECT NativeCurrency FROM control LIMIT 1)');
        m_.Post;
     end;
end;

procedure TfrmRoomTypesGroups2.tvDataPAYMENTS_REQUIREDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if EditPaymentRequirements(m_Code.AsString) then
    fillGridFromDataset(m_Code.AsString);
end;

procedure TfrmRoomTypesGroups2.tvDataPriorityRulePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  LookupForDataItem('Room Types',
                    glb.RoomTypesSet,
                    'RoomType',
                    'Description',
                    m_['PriorityRule'],
                    True,
                    False,
                    'active',
                    m_,
                    'PriorityRule');
end;

procedure TfrmRoomTypesGroups2.tvDataRATE_PLAN_TYPEPropertiesCloseUp(Sender: TObject);
begin
  if NOT m_.Eof then
  begin
    m_.Edit;
    m_['RATE_PLAN_TYPE'] := (tvDataRATE_PLAN_TYPE.Properties AS TcxComboBoxProperties).Items[TcxComboBox(Sender).ItemIndex];
    m_.Post;
  end;
end;

procedure TfrmRoomTypesGroups2.tvDataTopClassPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  LookupForDataItem('Top Class',
                  glb.RoomTypeGroups,
                  'Code',
                  'Description',
                  m_['TopClass'],
                  False,
                  False,
                  'active',
                  m_,
                  'TopClass');
end;

procedure TfrmRoomTypesGroups2.tvDataDblClick(Sender: TObject);
begin
  if not zAllowGridEdit then
  begin
    if ZAct = actLookup then
    begin
      btnOK.Click
    end else
    begin
      if glb.AccessAllowed(BtnEdit.HelpContext) then
      begin
        btnEdit.Click;
      end;
    end;
  end;

end;


procedure TfrmRoomTypesGroups2.tvDataDetailedDescriptionHtmlPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var s : String;
begin
  s := EditText('HTML description of room class ' + m_['Code'], m_['DetailedDescriptionHtml']);
  m_.Edit;
  m_['DetailedDescriptionHtml'] := s;
  m_.Post;
end;

procedure TfrmRoomTypesGroups2.tvDataDetailedDescriptionPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var s : String;
begin
  s := EditText('Text description of room class ' + m_['Code'], m_['DetailedDescription']);
  m_.Edit;
  m_['DetailedDescription'] := s;
  m_.Post;
end;

////////////////////////////////////////////////////////////////////////////
//  Filter
/////////////////////////////////////////////////////////////////////////////


procedure TfrmRoomTypesGroups2.tvDataAvailabilityTypesPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  LookupForDataItem('Room Types',
                    glb.RoomTypesSet,
                    'RoomType',
                    'Description',
                    m_['AvailabilityTypes'],
                    True,
                    False,
                    'active',
                    m_,
                    'AvailabilityTypes');

end;

procedure TfrmRoomTypesGroups2.NotifyDoesNotChangeOTAs;
begin
  MessageDlg(GetTranslatedText('shChangesToRomClassDoNotChangeTheBookingSiteOTA'), mtWarning, [mbOk], 0);
end;

procedure TfrmRoomTypesGroups2.tvDataBreakfastIncludedPropertiesEditValueChanged(Sender: TObject);
begin
  NotifyDoesNotChangeOTAs;
end;

procedure TfrmRoomTypesGroups2.tvDataCodePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  error := false;
  if trim(displayValue) = '' then
  begin
    error := true;
  	errortext := GetTranslatedText('shTx_RoomTypeGroups2_RoomClassIsRequired');
    exit;
  end;

  if hdata.RoomTypeGroupExist(displayValue) then
  begin
    error := true;
    errortext := displayvalue+'  '+GetTranslatedText('shNewValueExistInAnotherRecor');
    exit
  end;
end;

procedure TfrmRoomTypesGroups2.tvDataColumn1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var ResourceParameters : TImageResourceParameters;
begin
  ResourceParameters := TImageResourceParameters.Create(540, -1, clWhite);
  StaticResources('Room class Images',
        format(ROOM_CLASS_IMAGES_STATIC_RESOURCE_PATTERN, [m_['Code']]),
        ACCESS_OPEN, ResourceParameters);
end;

procedure TfrmRoomTypesGroups2.tvDataColumn2PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  openDynamicRates(actNone, '', '', m_['Code'])
end;

procedure TfrmRoomTypesGroups2.tvDataDataControllerFilterChanged(Sender: TObject);
begin
  chkFilter;
end;


procedure TfrmRoomTypesGroups2.tvDataDataControllerSortingChanged(Sender: TObject);
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


procedure TfrmRoomTypesGroups2.BtnOkClick(Sender: TObject);
begin
  fillHolder;
end;

procedure TfrmRoomTypesGroups2.btnOtherClick(Sender: TObject);
begin
  //**
end;

procedure TfrmRoomTypesGroups2.BringWindowToFront;
begin
  pnlHolder.BringToFront;
end;

procedure TfrmRoomTypesGroups2.btnCancelClick(Sender: TObject);
begin
  initRoomTypeGroupHolder(zData);
end;

procedure TfrmRoomTypesGroups2.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmRoomTypesGroups2.btnCloseClick(Sender: TObject);
begin
  if embedded then
    Close;
end;

procedure TfrmRoomTypesGroups2.btnDeleteClick(Sender: TObject);
begin
  m_.Delete;
end;

procedure TfrmRoomTypesGroups2.SetEditedValuesIn_M_Dataset;
begin
  m_['Active']        := zData.active;
  m_['Description']   := zData.Description;
  m_['color']         := zData.color;
  m_['Code']          := zData.Code;
  m_['TopClass']      := zData.TopClass;
  m_['PriorityRule']  := zData.PriorityRule;
  m_['MaxCount']      := zData.MaxCount;
  m_['numGuests']     := zData.numGuests;
  m_['minGuests']     := zData.minGuests;
  m_['maxGuests']     := zData.maxGuests;
  m_['maxChildren']   := zData.maxChildren;
  m_['AvailabilityTypes'] := zData.AvailabilityTypes;
  m_['BreakfastIncluded'] := zData.BreakfastIncluded;
  m_['HalfBoard'] := zData.HalfBoard;
  m_['FullBoard'] := zData.FullBoard;
  m_['defRate']         := zData.defRate;
  m_['defAvailability'] := zData.defAvailability;
  m_['defStopSale']     := zData.defStopSale;
  m_['defMaxAvailability'] := zData.defMaxAvailability;
  m_['defMinStay']         := zData.defMinStay;
  m_['defMaxStay']         := zData.defMaxStay;
  m_['defClosedToArrival']         := zData.defClosedToArrival;
  m_['defClosedToDeparture']         := zData.defClosedToDeparture;
  m_['NonRefundable'] := zData.NonRefundable;
  m_['AutoChargeCreditcards'] := zData.AutoChargeCreditcards;
  m_['RateExtraBed'] := zData.RateExtraBed;
  m_['PhotoUri'] := zData.PhotoUri;
  m_['sendAvailability'] := zData.sendAvailability;
  m_['sendRate'] := zData.sendRate;
  m_['sendStopSell'] := zData.sendStopSell;
  m_['sendMinStay'] := zData.sendMinStay;
  m_['DetailedDescriptionHtml'] := zData.DetailedDescriptionHtml;
  m_['DetailedDescription'] := zData.DetailedDescription;
  m_['Package'] := zData.Package;
  m_['OrderIndex'] := zData.OrderIndex;
  m_['connectRateToMasterRate'] := zData.connectRateToMasterRate;
  m_['masterRateRateDeviation'] := zData.masterRateRateDeviation;
  m_['RateDeviationType'] := zData.RateDeviationType;
  m_['connectSingleUseRateToMasterRate'] := zData.connectSingleUseRateToMasterRate;
  m_['masterRateSingleUseRateDeviation'] := zData.masterRateSingleUseRateDeviation;
  m_['singleUseRateDeviationType'] := zData.singleUseRateDeviationType;
  m_['connectStopSellToMasterRate'] := zData.connectStopSellToMasterRate;
  m_['connectAvailabilityToMasterRate'] := zData.connectAvailabilityToMasterRate;
  m_['connectMinStayToMasterRate'] := zData.connectMinStayToMasterRate;
  m_['connectMaxStayToMasterRate'] := zData.connectMaxStayToMasterRate;
  m_['connectCOAToMasterRate'] := zData.connectCOAToMasterRate;
  m_['connectCODToMasterRate'] := zData.connectCODToMasterRate;
  m_['connectLOSToMasterRate'] := zData.connectLOSToMasterRate;
  m_['RATE_PLAN_TYPE'] := zData.RATE_PLAN_TYPE;
//  m_['prepaidPercentage'] := zData.prepaidPercentage;
end;

procedure TfrmRoomTypesGroups2.btnEditClick(Sender: TObject);
begin
//  mnuiAllowGridEdit.Checked := true;
//  zAllowGridEdit := mnuiAllowGridEdit.Checked;
//  changeAllowGridEdit;
//  grData.SetFocus;
//  tvData.GetColumnByFieldName('Description').Focused := True;
//  showmessage(GetTranslatedText('shTx_RoomTypeGroups2_EditInGrid'));
  fillHolder;
  if openRoomTypeGroupEdit(zData, true, (tvDataRATE_PLAN_TYPE.Properties AS TcxComboBoxProperties).Items) then
  begin
      m_.edit;
      SetEditedValuesIn_M_Dataset;
      m_.Post;
      fillGridFromDataset(m_Code.AsString);
  end;

end;

procedure TfrmRoomTypesGroups2.btnInsertClick(Sender: TObject);
begin
//  mnuiAllowGridEdit.Checked := true;
//  zAllowGridEdit := mnuiAllowGridEdit.Checked;
//  changeAllowGridEdit;
//  if m_.Active = false then m_.Open;
//  grData.SetFocus;
//  m_.Insert;
//  tvData.GetColumnByFieldName('Code').Focused := True;
  initRoomTypeGroupHolder(zData);
  if openRoomTypeGroupEdit(zData, true, (tvDataRATE_PLAN_TYPE.Properties AS TcxComboBoxProperties).Items) then
  begin
      m_.insert;
      SetEditedValuesIn_M_Dataset;
      m_.Post;
  end;
  fillHolder;

end;

//---------------------------------------------------------------------------
// Menu in other actions
//-----------------------------------------------------------------------------

procedure TfrmRoomTypesGroups2.mnuiAllowGridEditClick(Sender: TObject);
begin
  if zFirstTime then exit;
  mnuiAllowGridEdit.Checked := not mnuiAllowGridEdit.Checked;
  zAllowGridEdit := mnuiAllowGridEdit.Checked;
  changeAllowGridEdit;
end;


procedure TfrmRoomTypesGroups2.mnuiPrintClick(Sender: TObject);
begin
  grPrinter.PrintTitle := caption;
  prLink_grData.ReportTitle.Text := caption;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmRoomTypesGroups2.mnuiGridToExcelClick(Sender: TObject);
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

procedure TfrmRoomTypesGroups2.mnuiGridToHtmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToHtml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.html'), nil, nil, sw_shownormal);
end;

procedure TfrmRoomTypesGroups2.mnuiGridToTextClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToText(sFilename, grData, true, true,';','','','txt');
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.txt'), nil, nil, sw_shownormal);
end;

procedure TfrmRoomTypesGroups2.mnuiGridToXmlClick(Sender: TObject);
var
  sFilename : string;
begin
  sFilename := g.qProgramPath + caption;
  ExportGridToXml(sFilename, grData, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xml'), nil, nil, sw_shownormal);
end;

end.

