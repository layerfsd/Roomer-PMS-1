unit uRoomClassEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sMemo, sComboBox, Vcl.Buttons, sSpeedButton,
  sCheckBox, sEdit, sLabel, sGroupBox, Vcl.ComCtrls, sPageControl, sButton, Vcl.ExtCtrls, sPanel,
  hData, cxClasses, cxPropertiesStore;

type
  TFrmRoomClassEdit = class(TForm)
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    pageMain: TsPageControl;
    sTabSheet1: TsTabSheet;
    gbxGuest: TsGroupBox;
    clabInitials: TsLabel;
    edtCode: TsEdit;
    cbxActive: TsCheckBox;
    cbxName: TsGroupBox;
    gbxAddress: TsGroupBox;
    cbxContact: TsGroupBox;
    sTabSheet2: TsTabSheet;
    sGroupBox1: TsGroupBox;
    edtTopClass: TsEdit;
    sLabel2: TsLabel;
    clabPassword: TsLabel;
    edtDescription: TsEdit;
    sLabel4: TsLabel;
    edtDetailedDescriptionHtml: TsMemo;
    sLabel7: TsLabel;
    edtDetailedDescription: TsMemo;
    sSpeedButton6: TsSpeedButton;
    sSpeedButton7: TsSpeedButton;
    sLabel8: TsLabel;
    edtNumGuests: TsEdit;
    sLabel10: TsLabel;
    edtMinGuests: TsEdit;
    sLabel11: TsLabel;
    edtMaxGuests: TsEdit;
    sLabel12: TsLabel;
    edtMaxChildren: TsEdit;
    cbxBreakfastIncluded: TsCheckBox;
    cbxHalfBoard: TsCheckBox;
    cbxFullBoard: TsCheckBox;
    sLabel13: TsLabel;
    edtOrderIndex: TsEdit;
    cbxNonRefundable: TsCheckBox;
    sLabel1: TsLabel;
    edtRateExtraBed: TsEdit;
    sGroupBox2: TsGroupBox;
    cbxsendAvailability: TsCheckBox;
    cbxsendRate: TsCheckBox;
    cbxsendStopSell: TsCheckBox;
    cbxsendMinStay: TsCheckBox;
    sGroupBox3: TsGroupBox;
    sLabel9: TsLabel;
    sLabel14: TsLabel;
    sLabel15: TsLabel;
    sLabel16: TsLabel;
    cbxDefStopSale: TsCheckBox;
    edtdefRate: TsEdit;
    edtdefAvailability: TsEdit;
    edtdefMinStay: TsEdit;
    edtdefMaxAvailability: TsEdit;
    cbxAutoChargeCreditcards: TsCheckBox;
    sLabel3: TsLabel;
    edtPackage: TsEdit;
    sSpeedButton1: TsSpeedButton;
    sTabSheet3: TsTabSheet;
    sGroupBox4: TsGroupBox;
    cbxconnectRateToMasterRate: TsCheckBox;
    edtmasterRateRateDeviation: TsEdit;
    sLabel17: TsLabel;
    sLabel18: TsLabel;
    sLabel19: TsLabel;
    sLabel20: TsLabel;
    sLabel21: TsLabel;
    sPanel1: TsPanel;
    cmbRateDeviationType: TsComboBox;
    cbxconnectSingleUseRateToMasterRate: TsCheckBox;
    edtmasterRateSingleUseRateDeviation: TsEdit;
    cmbsingleUseRateDeviationType: TsComboBox;
    sLabel6: TsLabel;
    cbxconnectAvailabilityToMasterRate: TsCheckBox;
    sLabel22: TsLabel;
    cbxconnectMinStayToMasterRate: TsCheckBox;
    sLabel23: TsLabel;
    cbxconnectMaxStayToMasterRate: TsCheckBox;
    sLabel5: TsLabel;
    sLabel24: TsLabel;
    cbxconnectCOAToMasterRate: TsCheckBox;
    cbxconnectCODToMasterRate: TsCheckBox;
    sLabel25: TsLabel;
    sLabel26: TsLabel;
    cbxconnectLOSToMasterRate: TsCheckBox;
    cbxconnectStopSellToMasterRate: TsCheckBox;
    sLabel27: TsLabel;
    sLabel28: TsLabel;
    edtPriorityRule: TsEdit;
    sSpeedButton2: TsSpeedButton;
    FormStore: TcxPropertiesStore;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton5: TsSpeedButton;
    sSpeedButton8: TsSpeedButton;
    sSpeedButton9: TsSpeedButton;
    sSpeedButton10: TsSpeedButton;
    sButton1: TsButton;
    cbxRatePlanType: TsComboBox;
    sLabel29: TsLabel;
    sLabel30: TsLabel;
    edtdefMaxStay: TsEdit;
    cbxDefClosedToArrival: TsCheckBox;
    cbxDefClosedToDeparture: TsCheckBox;
    edtPrepaidPercentage: TsEdit;
    sLabel31: TsLabel;
    procedure cbxconnectRateToMasterRateValueChanged(Sender: TObject);
    procedure cbxconnectSingleUseRateToMasterRateValueChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sSpeedButton6Click(Sender: TObject);
    procedure sSpeedButton7Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton5Click(Sender: TObject);
    procedure sSpeedButton8Click(Sender: TObject);
    procedure sSpeedButton9Click(Sender: TObject);
    procedure sSpeedButton10Click(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure edtdefRateKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtTopClassChange(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure cbxAutoChargeCreditcardsClick(Sender: TObject);
  private
    { Private declarations }
    zData : recRoomTypeGroupHolder;
    zInsert : Boolean;

    SystemDecimalChar : Char;
    procedure EditsToRecordHolder;
    procedure RecordHolderToEdits;
  public
    { Public declarations }
  end;

var
  FrmRoomClassEdit: TFrmRoomClassEdit;

function openRoomTypeGroupEdit(var theData : recRoomTypeGroupHolder; isInsert : boolean; Rate_Plan_Types : TStrings) : boolean;

implementation

{$R *.dfm}

uses uMultiSelection,
     uAppGlobal,
     uFrmNotepad,
     uPackages,
     uG,
     _Glob,
     udImages,
     uUtils,
     uRoomerLanguage,
     uFrmResources,
     uResourceManagement
     ;

function openRoomTypeGroupEdit(var theData : recRoomTypeGroupHolder; isInsert : boolean; Rate_Plan_Types : TStrings) : boolean;
var
  _FrmRoomClassEdit: TFrmRoomClassEdit;
begin
  result := false;
  _FrmRoomClassEdit := TFrmRoomClassEdit.Create(nil);
  try
    _FrmRoomClassEdit.zData := theData;
    _FrmRoomClassEdit.zInsert := isInsert;
    _FrmRoomClassEdit.cbxRatePlanType.Items.Assign(RATE_PLAN_TYPES);
    _FrmRoomClassEdit.cbxRatePlanType.ItemIndex := _FrmRoomClassEdit.cbxRatePlanType.IndexOf(theData.RATE_PLAN_TYPE);
    _FrmRoomClassEdit.ShowModal;
    if _FrmRoomClassEdit.modalresult = mrOk then
    begin
      _FrmRoomClassEdit.EditsToRecordHolder;
      theData := _FrmRoomClassEdit.zData;
      result := true;
    end
  finally
    freeandnil(_FrmRoomClassEdit);
  end;
end;

procedure TFrmRoomClassEdit.cbxAutoChargeCreditcardsClick(Sender: TObject);
begin
  edtPrepaidPercentage.Enabled := cbxAutoChargeCreditcards.Checked;
end;

procedure TFrmRoomClassEdit.cbxconnectRateToMasterRateValueChanged(Sender: TObject);
begin
  edtmasterRateRateDeviation.enabled := cbxconnectRateToMasterRate.Checked;
  cmbRateDeviationType.enabled := cbxconnectRateToMasterRate.Checked;
end;

procedure TFrmRoomClassEdit.cbxconnectSingleUseRateToMasterRateValueChanged(Sender: TObject);
begin
  edtmasterRateSingleUseRateDeviation.enabled := cbxconnectSingleUseRateToMasterRate.Checked;
  cmbsingleUseRateDeviationType.enabled := cbxconnectSingleUseRateToMasterRate.Checked;
end;

procedure TFrmRoomClassEdit.RecordHolderToEdits;
begin
  pagemain.ActivePageIndex := 0;

  edtCode.Text := zData.Code;
  edtDescription.Text := zData.Description;
  edtDetailedDescription.Lines.Text := zData.DetailedDescription;
  edtPriorityRule.Text := zData.PriorityRule;
  edtnumGuests.Text := inttostr(zData.numGuests);
  edtminGuests.Text := inttostr(zData.minGuests);
  edtmaxGuests.Text := inttostr(zData.maxGuests);
  edtmaxChildren.Text := inttostr(zData.maxChildren);
  cbxBreakfastIncluded.Checked := zData.BreakfastIncluded;
  cbxHalfBoard.Checked := zData.HalfBoard;
  cbxFullBoard.Checked := zData.FullBoard;
  cbxActive.Checked := zData.Active;
  edtDetailedDescriptionHtml.Lines.Text := zData.DetailedDescriptionHtml;
  edtTopClass.Text := zData.TopClass;
  edtdefRate.Text := FloatToStr(zData.defRate);
  edtPrepaidPercentage.Text := FloatToStr(zData.prepaidPercentage);
  edtdefAvailability.Text := inttostr(zData.defAvailability);
  cbxdefStopSale.Checked := zData.defStopSale;
  edtdefMinStay.Text := inttostr(zData.defMinStay);
  edtdefMaxStay.Text := inttostr(zData.defMaxStay);
  cbxDefClosedToArrival.Checked := zData.defClosedToArrival;
  cbxDefClosedToDeparture.Checked := zData.defClosedToDeparture;
  edtdefMaxAvailability.Text := inttostr(zData.defMaxAvailability);
  cbxNonRefundable.Checked := zData.NonRefundable;
  cbxAutoChargeCreditcards.Checked := zData.AutoChargeCreditcards;
  cbxAutoChargeCreditcardsClick(nil);
  edtRateExtraBed.Text := FloatToStr(zData.RateExtraBed);
  cbxsendAvailability.Checked := zData.sendAvailability;
  cbxsendRate.Checked := zData.sendRate;
  cbxsendStopSell.Checked := zData.sendStopSell;
  cbxsendMinStay.Checked := zData.sendMinStay;
  edtpackage.Text := zData.package;
  edtorderIndex.Text := inttostr(zData.orderIndex);
  cbxconnectRateToMasterRate.Checked := zData.connectRateToMasterRate;
  edtmasterRateRateDeviation.Text := FloatToStr(zData.masterRateRateDeviation);
  cmbRateDeviationType.Text := zData.RateDeviationType;
  cbxconnectSingleUseRateToMasterRate.Checked := zData.connectSingleUseRateToMasterRate;
  edtmasterRateSingleUseRateDeviation.Text := FloatToStr(zData.masterRateSingleUseRateDeviation);
  cmbsingleUseRateDeviationType.Text := zData.singleUseRateDeviationType;
  cbxconnectStopSellToMasterRate.Checked := zData.connectStopSellToMasterRate;
  cbxconnectAvailabilityToMasterRate.Checked := zData.connectAvailabilityToMasterRate;
  cbxconnectMinStayToMasterRate.Checked := zData.connectMinStayToMasterRate;
  cbxconnectMaxStayToMasterRate.Checked := zData.connectMaxStayToMasterRate;
  cbxconnectCOAToMasterRate.Checked := zData.connectCOAToMasterRate;
  cbxconnectCODToMasterRate.Checked := zData.connectCODToMasterRate;
  cbxconnectLOSToMasterRate.Checked := zData.connectLOSToMasterRate;
end;

procedure TFrmRoomClassEdit.sButton1Click(Sender: TObject);
var ResourceParameters : TImageResourceParameters;
begin
  ResourceParameters := TImageResourceParameters.Create(540, -1, clWhite);
  StaticResources('Room class Images',
        format(ROOM_CLASS_IMAGES_STATIC_RESOURCE_PATTERN, [edtCode.Text]),
        ACCESS_OPEN, ResourceParameters);
end;

procedure TFrmRoomClassEdit.sSpeedButton10Click(Sender: TObject);
begin
  edtDetailedDescription.Text := '';
end;

procedure TFrmRoomClassEdit.sSpeedButton1Click(Sender: TObject);
var
  theData : recPackageHolder;
begin
  initPackageHolder(thedata);
  theData.package := edtPackage.Text;
  if openPackages(actLookup, theData) AND
     (theData.package <> edtPackage.Text) then
     begin
        edtPackage.Text := theData.package;
     end;
end;

procedure TFrmRoomClassEdit.sSpeedButton2Click(Sender: TObject);
begin
  edtPriorityRule.Text := LookupForDataItem('Room Types',
                    glb.RoomTypesSet,
                    'RoomType',
                    'Description',
                    edtPriorityRule.Text,
                    True,
                    False,
                    'active');

end;

procedure TFrmRoomClassEdit.sSpeedButton3Click(Sender: TObject);
begin
  edtTopClass.Text := LookupForDataItem('Top Class',
                  glb.RoomTypeGroups,
                  'Code',
                  'Description',
                  edtTopClass.Text,
                  False,
                  False,
                  'active');
end;

procedure TFrmRoomClassEdit.sSpeedButton4Click(Sender: TObject);
begin
  edtPackage.Text := '';
end;

procedure TFrmRoomClassEdit.sSpeedButton5Click(Sender: TObject);
begin
  edtTopClass.Text := '';
end;

procedure TFrmRoomClassEdit.sSpeedButton6Click(Sender: TObject);
begin
  edtDetailedDescriptionHtml.Lines.Text := EditText('HTML description of room class ' + zData.Code, edtDetailedDescriptionHtml.Lines.Text);
end;

procedure TFrmRoomClassEdit.sSpeedButton7Click(Sender: TObject);
begin
  edtDetailedDescription.Lines.Text := EditText('Text description of room class ' + zData.Code, edtDetailedDescription.Lines.Text);
end;

procedure TFrmRoomClassEdit.sSpeedButton8Click(Sender: TObject);
begin
  edtPriorityRule.Text := '';
end;

procedure TFrmRoomClassEdit.sSpeedButton9Click(Sender: TObject);
begin
  edtDetailedDescriptionHtml.Text := '';
end;

procedure TFrmRoomClassEdit.EditsToRecordHolder;
begin
  pagemain.ActivePageIndex := 0;

  zData.Code := edtCode.Text;
  zData.Description := edtDescription.Text;
  zData.DetailedDescription := edtDetailedDescription.Lines.Text;
  zData.PriorityRule := edtPriorityRule.Text;
  zData.numGuests := strToInt(edtnumGuests.Text);
  zData.minGuests := strToInt(edtminGuests.Text);
  zData.maxGuests := strToInt(edtmaxGuests.Text);
  zData.maxChildren := strToInt(edtmaxChildren.Text);
  zData.BreakfastIncluded := cbxBreakfastIncluded.Checked;
  zData.HalfBoard := cbxHalfBoard.Checked;
  zData.FullBoard := cbxFullBoard.Checked;
  zData.Active := cbxActive.Checked;
  zData.DetailedDescriptionHtml := edtDetailedDescriptionHtml.Lines.Text;
  zData.TopClass := edtTopClass.Text;
  zData.defRate := _StrToFloat(edtdefRate.Text);
  zData.prepaidPercentage := _StrToFloat(edtPrepaidPercentage.Text);

  zData.defAvailability := strToInt(edtdefAvailability.Text);
  zData.defStopSale := cbxdefStopSale.Checked;
  zData.defMinStay := strToInt(edtdefMinStay.Text);
  zData.defMaxStay := strToInt(edtdefMaxStay.Text);
  zData.defClosedToArrival := cbxDefClosedToArrival.Checked;
  zData.defClosedToDeparture := cbxDefClosedToDeparture.Checked;
  zData.defMaxAvailability := strToInt(edtdefMaxAvailability.Text);
  zData.NonRefundable := cbxNonRefundable.Checked;
  zData.AutoChargeCreditcards := cbxAutoChargeCreditcards.Checked;
  zData.RateExtraBed := _StrToFloat(edtRateExtraBed.Text);
  zData.sendAvailability := cbxsendAvailability.Checked;
  zData.sendRate := cbxsendRate.Checked;
  zData.sendStopSell := cbxsendStopSell.Checked;
  zData.sendMinStay := cbxsendMinStay.Checked;
  zData.package := edtpackage.Text;
  zData.orderIndex := strToInt(edtorderIndex.Text);
  zData.connectRateToMasterRate := cbxconnectRateToMasterRate.Checked;
  zData.masterRateRateDeviation := _StrToFloat(edtmasterRateRateDeviation.Text);
  zData.RateDeviationType := cmbRateDeviationType.Text;
  zData.connectSingleUseRateToMasterRate := cbxconnectSingleUseRateToMasterRate.Checked;
  zData.masterRateSingleUseRateDeviation := _StrToFloat(edtmasterRateSingleUseRateDeviation.Text);
  zData.singleUseRateDeviationType := cmbsingleUseRateDeviationType.Text;
  zData.connectStopSellToMasterRate := cbxconnectStopSellToMasterRate.Checked;
  zData.connectAvailabilityToMasterRate := cbxconnectAvailabilityToMasterRate.Checked;
  zData.connectMinStayToMasterRate := cbxconnectMinStayToMasterRate.Checked;
  zData.connectMaxStayToMasterRate := cbxconnectMaxStayToMasterRate.Checked;
  zData.connectCOAToMasterRate := cbxconnectCOAToMasterRate.Checked;
  zData.connectCODToMasterRate := cbxconnectCODToMasterRate.Checked;
  zData.connectLOSToMasterRate := cbxconnectLOSToMasterRate.Checked;
  zData.RATE_PLAN_TYPE := cbxRatePlanType.Text;
end;


procedure TFrmRoomClassEdit.edtdefRateKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', '-', SystemDecimalChar]) then
    Key := #0
  else if ((Key = SystemDecimalChar) or (Key = '-')) and
          (Pos(Key, TsEdit(Sender).Text) > 0) then
  begin
    Key := #0;
  end
  else if (Key = '-') and
          (TsEdit(Sender).SelStart <> 0) then
  begin
    Key := #0;
  end;
end;

procedure TFrmRoomClassEdit.edtTopClassChange(Sender: TObject);
begin
  btnOk.Enabled := (edtCode.Text <> '') AND
                   (edtTopClass.Text <> '');
end;

procedure TFrmRoomClassEdit.FormCreate(Sender: TObject);
begin
  SystemDecimalChar := SystemDecimalSeparator;
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
end;

procedure TFrmRoomClassEdit.FormShow(Sender: TObject);
begin
  RecordHolderToEdits;
  edtTopClassChange(nil);
end;

end.
