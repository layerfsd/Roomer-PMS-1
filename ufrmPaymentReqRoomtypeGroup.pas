unit ufrmPaymentReqRoomtypeGroup;

interface

uses
  VCL.Forms,
  sSpeedButton, sLabel, Vcl.ExtCtrls, sPanel, cxCheckBox, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers,
  dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxCalc, Vcl.Menus, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxPropertiesStore, dxmdaset, dxPSCore, dxPScxCommon, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, Vcl.StdCtrls, sButton, Vcl.ComCtrls, sStatusBar, sEdit, Vcl.Buttons, Vcl.Controls, System.Classes, dxPScxPivotGridLnk;

type
  TfrmPaymentReqRoomtypeGroup = class(TForm)
    pnlHolder: TsPanel;
    sPanel1: TsPanel;
    cLabFilter: TsLabel;
    btnClear: TsSpeedButton;
    edFilter: TsEdit;
    sbMain: TsStatusBar;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    DS: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    m_: TdxMemData;
    FormStore: TcxPropertiesStore;
    m_ChannelmanagerID: TStringField;
    m_Name: TStringField;
    m_PaymentRequired: TBooleanField;
    m_PrepaidPercentage: TFloatField;
    tvDataRecId: TcxGridDBColumn;
    tvDataChannelmanagerID: TcxGridDBColumn;
    tvDataName: TcxGridDBColumn;
    tvDataPaymentRequired: TcxGridDBColumn;
    tvDataPrepaidPercentage: TcxGridDBColumn;
    m_Active: TBooleanField;
    mnuOther: TPopupMenu;
    mnuiPrint: TMenuItem;
    mnuiAllowGridEdit: TMenuItem;
    N2: TMenuItem;
    Export1: TMenuItem;
    mnuiGridToExcel: TMenuItem;
    mnuiGridToHtml: TMenuItem;
    mnuiGridToText: TMenuItem;
    mnuiGridToXml: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure tvDataPrepaidPercentagePropertiesValidate(Sender: TObject; var DisplayValue: Variant;
      var ErrorText: TCaption; var Error: Boolean);
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FRoomtypeGroup: string;
    procedure fillGridFromDataset(const iGoto: String);
    procedure applyFilter;
    procedure UpdatePaymentRequirements;
  public
    { Public declarations }
    constructor CreateForGroup(const aRoomTypeGroup: string); overload;
  end;


function EditPaymentRequirements(const aRoomTypeGroup: string): boolean;

implementation

{$R *.dfm}

uses
  Windows
  , Variants
  , SysUtils
  , uSqlDefinitions
  , uAppGlobal
  , uG
  , cmpRoomerDataset
  , uD
  , uUtils
  , _Glob, hData;

function EditPaymentRequirements(const aRoomTypeGroup: string): boolean;
var
  frm: TfrmPaymentReqRoomtypeGroup;
begin
  frm := TfrmPaymentReqRoomtypeGroup.CreateForGroup(aRoomTypeGroup);
  try
    Result := frm.ShowModal = mrOk;
  finally
    frm.Free;
  end;

end;

procedure TfrmPaymentReqRoomtypeGroup.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmPaymentReqRoomtypeGroup.BtnOkClick(Sender: TObject);
begin
  UpdatePaymentRequirements;
  ModalResult := mrOk;
end;

constructor TfrmPaymentReqRoomtypeGroup.CreateForGroup(const aRoomTypeGroup: string);
begin
  inherited Create(nil);
  FRoomtypeGroup := aRoomTypeGroup;
  Caption := Caption + ' '+ FRoomTypeGroup;
end;

procedure TfrmPaymentReqRoomtypeGroup.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmPaymentReqRoomtypeGroup.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;
end;

procedure TfrmPaymentReqRoomtypeGroup.FormShow(Sender: TObject);
begin
  fillGridFromDataset('');
end;

procedure TfrmPaymentReqRoomtypeGroup.tvDataPrepaidPercentagePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  Error := not VarInRange(DisplayValue, 0, 100);
end;

procedure TfrmPaymentReqRoomtypeGroup.UpdatePaymentRequirements;
var
  sql: string;
  lExec: TRoomerExecutionPlan;
begin
  if m_.State in [dsEdit, dsInsert] then
    m_.Post;

  lExec := d.roomerMainDataset.CreateExecutionPlan;
  try

    sql := Format(delete_PaymentRequirementsForRoomTypeGroup, [_db(FRoomtypeGroup)]);
    lExec.AddExec(sql);

    m_.First;
    while not m_.Eof do
    begin
      if m_PaymentRequired.AsBoolean and (m_PrepaidPercentage.AsFloat > 0) then
      begin
        sql := Format(Insert_PaymentRequirementsForRoomtypeGroup, [_db(d.roomerMainDataSet.hotelId),
                                                                   _db(m_ChannelmanagerID.AsString),
                                                                   _db(FRoomtypeGroup),
                                                                   _db(m_PrepaidPercentage.AsFloat)]);
        lExec.AddExec(sql);
      end;
      m_.Next;
    end;

    if not lExec.Execute(ptExec, True, True) then
      raise Exception.Create(lExec.ExecException);

  finally
    lExec.Free;
  end;
end;

procedure TfrmPaymentReqRoomtypeGroup.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    tvData.DataController.Filter.Root.Clear;
    tvData.DataController.Filter.Active := false;
  end
  else
    applyFilter;

end;

procedure TfrmPaymentReqRoomtypeGroup.applyFilter;
begin
  tvData.DataController.Filter.Options := [fcoCaseInsensitive];
  tvData.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvData.DataController.Filter.Root.Clear;
  tvData.DataController.Filter.Root.AddItem(tvDataName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Root.AddItem(tvDataChannelmanagerID,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvData.DataController.Filter.Active := True;
end;


procedure TfrmPaymentReqRoomtypeGroup.fillGridFromDataset(const iGoto : String);
var
  s    : string;
  rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    s := format(select_PaymentRequirementForRoomTypeGroup, [_db(FRoomTypeGroup)]);
    CopyToClipboard(s);

    if rSet_bySQL(rSet,s, false) then
    begin
      m_.Close;
      m_.Open;

      rSet.first;
      while not rSet.Eof do
      begin
        m_.Append;
        try
          m_ChannelmanagerID.AsString := rset.FieldByName('ChannelmanagerId').ASstring;
          m_Name.AsString := rset.FieldByName('Name').ASstring;
          m_PaymentRequired.AsBoolean := rset.FieldByName('Payment_Required').Asboolean;
          m_PrepaidPercentage.AsFloat := rset.FieldByName('Prepaid_Percentage').AsFloat;
          m_.Post;
        except
          m_.Cancel;
          raise;
        end;
        rSet.Next;
      end;

      if iGoto = '' then
        m_.First
      else
        try
          m_.Locate('ChannelmanagerId',iGoto,[]);
        except
        end;
    end;
  finally
    rSet.Free;
  end;
end;

end.
