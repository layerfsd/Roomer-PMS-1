unit uFrmChannelTogglingRules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sRadioButton, sListBox,
  sCheckListBox, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, sEdit,
  sLabel,uAppglobal,
  Vcl.ComCtrls, sPageControl, Vcl.ExtCtrls, sPanel, udImages, sButton, uD,
  cmpRoomerDataSet, RoomerCloudEntities, sComboBox, Vcl.CheckLst, uStringUtils,
  uRoomerLanguage, sCheckBox, TFlatButtonUnit;

type

  TDateValue = class
    value: TDate;
  public
    constructor Create(_value: TDate);
  end;

  TfrmChannelTogglingRules = class(TForm)
    pnlList: TsPanel;
    sPanel2: TsPanel;
    sPanel3: TsPanel;
    sPanel4: TsPanel;
    sPageControl1: TsPageControl;
    tabType: TsTabSheet;
    sPanel13: TsPanel;
    sLabel5: TsLabel;
    sPanel6: TsPanel;
    lbRules: TsListBox;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    pnlEditButtons: TsPanel;
    BtnOk: TsButton;
    btnCancel: TsButton;
    lblRuleDescription: TsLabel;
    btnUp: TsButton;
    btnDown: TsButton;
    sPanel1: TsPanel;
    pnlDescriptHolder: TsPanel;
    edtDescription: TsEdit;
    sPanel5: TsPanel;
    sLabel1: TsLabel;
    clRoomTypes: TsCheckListBox;
    sLabel3: TsLabel;
    clWhichDays: TsCheckListBox;
    clDays: TsCheckListBox;
    sPanel8: TsPanel;
    sLabel4: TsLabel;
    clMonthsTimeOfYear: TsCheckListBox;
    clYears: TsCheckListBox;
    sPanel7: TsPanel;
    sLabel2: TsLabel;
    pnlOccupancyHolder: TsPanel;
    edtOccupancy: TsEdit;
    sPanel9: TsPanel;
    sLabel6: TsLabel;
    clWhichChannels: TsCheckListBox;
    sPanel10: TsPanel;
    lblDaysBefore: TsLabel;
    pnlWindowHolder: TsPanel;
    edtWindow: TsEdit;
    cbxAnyNumberOfDays: TsCheckBox;
    sPanel12: TsPanel;
    procedure FormShow(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure clWhichDaysClickCheck(Sender: TObject);
    procedure clRoomTypesClickCheck(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure lbRulesClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDescriptionChange(Sender: TObject);
    procedure edtOccupancyChange(Sender: TObject);
    procedure cbxAnyNumberOfDaysClick(Sender: TObject);
  private
    { Private declarations }
    rulesList: Array_Of_TChanneltogglingrulesEntity;
    channelList: Array_Of_TChannelsEntity;
    roomClassList: Array_Of_TRoomtypegroupsEntity;
    editingId: Integer;

    descriptionFormat: String;

    procedure WriteDescription;
    procedure SetEdit(_on: Boolean);
    procedure LoadList;
    procedure PrepareWidgets;
    procedure ChannelsAndRoomClasses;
    procedure ClearAllCheckBoxes(cl: TsCheckListBox);
    procedure processDescriptionLabel;
    function getSelectedRoomTypes: String;
    function getSelectedDays: String;
    function getSelectedWhichDays: String;
    function getSelectedTimeOfYear: String;
    function getSelectedYears: String;
    function getSelectedChannels: String;
    function getSelectedRoomTypeCodes: String;
    function getSelectedWhichDaysIndex: Integer;
    function getSelectedDaysCodes: String;
    function getSelectedTimeOfYearCodes: String;
    function getSelectedYearCodes: String;
    function getSelectedChannelCodes: String;
    procedure ShowListOfRules;
    function getRule(id: Integer; entity: TChanneltogglingrulesEntity)
      : TChanneltogglingrulesEntity;
    function gatherEntity: TChanneltogglingrulesEntity;
    procedure EmptyEdits;
    procedure SetButtonActiveStatus;
    function SelectedTogglingRule: TChanneltogglingrulesEntity;
    procedure SetItemPriority(Item: TChanneltogglingrulesEntity;
      priority: Integer);
    procedure DeleteX(var A: Array_Of_TChanneltogglingrulesEntity;
      const Index: Cardinal);
    procedure ClearList;
  public
    { Public declarations }
  end;

var
  frmChannelTogglingRules: TfrmChannelTogglingRules;

procedure ShowCheannelTogglingRules;

implementation

uses uUtils, PrjConst, _Glob;

resourcestring
  UNKNOWN_INFO = '???';

const
  COLOR_WRONG_INPUT: Integer = clRed;

{$R *.dfm}
  { TfrmChannelTogglingRules }

procedure TfrmChannelTogglingRules.btnCancelClick(Sender: TObject);
begin
  editingId := -1;
  lbRules.ItemIndex := -1;
  lbRulesClick(lbRules);
  SetEdit(editingId <> -1);
end;

procedure TfrmChannelTogglingRules.btnDeleteClick(Sender: TObject);
var
  currentItem: TChanneltogglingrulesEntity;
begin
  currentItem := SelectedTogglingRule;
  if MessageDLG(GetTranslatedText('shTx_FrmChannelTogglingRules_ConfirmRemove')
    + currentItem.description, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    d.roomerMainDataSet.DoCommand
      ('DELETE FROM channeltogglingrulessplit WHERE ruleId=' +
      inttostr(currentItem.id));
    d.roomerMainDataSet.Channeltogglingrules_DataSets_Delete(currentItem.id);
    // d.roomerMainDataSet.SystemDeleteToggleRule(currentItem.id);
    DeleteX(rulesList, lbRules.ItemIndex);
    ShowListOfRules;
  end;
end;

procedure TfrmChannelTogglingRules.DeleteX
  (var A: Array_Of_TChanneltogglingrulesEntity; const Index: Cardinal);
var
  ALength: Cardinal;
  i: Cardinal;
begin
  ALength := Length(A);
  Assert(ALength > 0);
  Assert(Index < ALength);
  for i := Index + 1 to ALength - 1 do
    A[i - 1] := A[i];
  SetLength(A, ALength - 1);
end;

procedure TfrmChannelTogglingRules.edtDescriptionChange(Sender: TObject);
begin
  processDescriptionLabel;
end;

procedure TfrmChannelTogglingRules.edtOccupancyChange(Sender: TObject);
begin
  processDescriptionLabel;
end;

procedure TfrmChannelTogglingRules.btnDownClick(Sender: TObject);
var
  currentItem, otherItem: TChanneltogglingrulesEntity;
  i, iCurrPriority, iOtherPriority, iCurrIndex: Integer;
begin
  currentItem := SelectedTogglingRule;
  iCurrIndex := lbRules.ItemIndex;
  otherItem := TChanneltogglingrulesEntity
    (lbRules.Items.Objects[iCurrIndex + 1]);
  iCurrPriority := currentItem.priority;
  iOtherPriority := otherItem.priority;
  SetItemPriority(otherItem, iCurrPriority);
  SetItemPriority(currentItem, iOtherPriority);
  lbRules.Items.Move(iCurrIndex, iCurrIndex + 1);
  lbRules.ItemIndex := iCurrIndex + 1;
end;

function TfrmChannelTogglingRules.SelectedTogglingRule
  : TChanneltogglingrulesEntity;
begin
  result := nil;
  if lbRules.ItemIndex >= 0 then
    result := TChanneltogglingrulesEntity
      (lbRules.Items.Objects[lbRules.ItemIndex]);
end;

procedure TfrmChannelTogglingRules.btnEditClick(Sender: TObject);
begin
  editingId := lbRules.ItemIndex;
  SetEdit(editingId <> -1);
  ActiveControl := edtDescription;
end;

procedure TfrmChannelTogglingRules.btnInsertClick(Sender: TObject);
begin
  editingId := -2;
  EmptyEdits;
  processDescriptionLabel;
  BtnOk.Enabled := False;
  SetButtonActiveStatus;
  lblRuleDescription.Visible := lbRules.ItemIndex >= 0;
  // lbRulesClick(lbRules);
  SetEdit(editingId <> -1);
  edtDescription.Text := '';
  // GetTranslatedText('shTx_FrmChannelTogglingRules_NewRule');
  ActiveControl := edtDescription;
end;

procedure TfrmChannelTogglingRules.EmptyEdits;
begin
  ClearAllCheckBoxes(clRoomTypes);
  ClearAllCheckBoxes(clDays);
  ClearAllCheckBoxes(clMonthsTimeOfYear);
  ClearAllCheckBoxes(clYears);
  ClearAllCheckBoxes(clWhichChannels);
  ClearAllCheckBoxes(clWhichDays);

  edtDescription.Text := '';
  edtOccupancy.Text := '';
  edtWindow.Text := '';
end;

procedure TfrmChannelTogglingRules.BtnOkClick(Sender: TObject);
var
  splitResult: String;
  splits: TStrings;
  i: Integer;
  conflictedRules: String;
  savedEntity: TChanneltogglingrulesEntity;
  rule: TChanneltogglingrulesEntity;
  iCurrIndex: Integer;
begin
  if editingId = -2 then
  begin
    splitResult := d.roomerMainDataSet.SystemcheckRuleConflict(-1, 1,
      edtDescription.Text, getSelectedRoomTypeCodes,
      _StrToFloat(edtOccupancy.Text), getSelectedWhichDaysIndex,
      getSelectedDaysCodes, getSelectedTimeOfYearCodes, getSelectedYearCodes,
      getSelectedChannelCodes);
    rule := gatherEntity;
    if Length(rulesList) > 0 then
      rule.setPriority(rulesList[High(rulesList)].priority + 1)
    else
      rule.setPriority(1);
    savedEntity := d.roomerMainDataSet.
      Channeltogglingrules_Entities_SaveEntity(rule);
    SetLength(rulesList, Length(rulesList) + 1);
    iCurrIndex := High(rulesList);
    rulesList[High(rulesList)] := savedEntity;
    ShowListOfRules;
  end
  else
  begin
    rule := TChanneltogglingrulesEntity(lbRules.Items.Objects[editingId]);
    savedEntity := TChanneltogglingrulesEntity.Create;
    savedEntity.setId(rule.id);
    savedEntity.setActive(rule.Active);
    savedEntity.setPriority(rule.priority);
    savedEntity.setDescription(edtDescription.Text);
    savedEntity.setSelectedRoomTypeIDs(getSelectedRoomTypeCodes);
    savedEntity.setOccupancyLimit(_StrToFloat(edtOccupancy.Text));
    savedEntity.setWhichDaysIndex(getSelectedWhichDaysIndex);
    savedEntity.setSelectedDays(getSelectedDaysCodes);
    savedEntity.setSelectedMonths(getSelectedTimeOfYearCodes);
    savedEntity.setSelectedYears(getSelectedYearCodes);
    savedEntity.setSelectedChannelsIDs(getSelectedChannelCodes);
    savedEntity.setWindow(StrToIntDef(edtWindow.Text, 0));
    splitResult := d.roomerMainDataSet.SystemcheckRuleConflict(savedEntity.id,
      1, edtDescription.Text, getSelectedRoomTypeCodes,
      _StrToFloat(edtOccupancy.Text), getSelectedWhichDaysIndex,
      getSelectedDaysCodes, getSelectedTimeOfYearCodes, getSelectedYearCodes,
      getSelectedChannelCodes);
    lbRules.Items.Objects[editingId] := savedEntity;
    lbRules.Items[editingId] := savedEntity.description;
    iCurrIndex := editingId;
    d.roomerMainDataSet.Channeltogglingrules_Entities_UpdateEntity(savedEntity);
  end;

  if splitResult <> '' then
  begin
    splits := SplitStringToTStrings(',', splitResult);
    try
      conflictedRules := '';
      for i := 0 to splits.Count - 1 do
      begin
        rule := getRule(StrToInt(splits[i]), savedEntity);
        if Assigned(rule) AND (rule.id <> savedEntity.id) then
        begin
          if conflictedRules = '' then
            conflictedRules := '   - ' + getRule(StrToInt(splits[i]), savedEntity)
              .description
          else
            conflictedRules := conflictedRules + #13 + '   - ' +
              getRule(StrToInt(splits[i]), savedEntity).description;
        end;
      end;
    finally
      splits.Free;
    end;
    if conflictedRules <> '' then
      MessageDLG('This rule conflicts with the rules below.' + #13 +
        'If you want this rule to override one or all of these rules,' + #13 +
        'please move this rule up in the list.' + #13#13 + conflictedRules +
        #13, mtWarning, [mbOk], 0);
  end;
  d.roomerMainDataSet.SystemSaveSplittedToggleRule(savedEntity.id);
  editingId := 0;
  SetEdit(False);
end;

procedure TfrmChannelTogglingRules.btnUpClick(Sender: TObject);
var
  currentItem, otherItem: TChanneltogglingrulesEntity;
  i, iCurrPriority, iOtherPriority, iCurrIndex: Integer;
begin
  currentItem := SelectedTogglingRule;
  iCurrIndex := lbRules.ItemIndex;
  otherItem := TChanneltogglingrulesEntity
    (lbRules.Items.Objects[iCurrIndex - 1]);
  iCurrPriority := currentItem.priority;
  iOtherPriority := otherItem.priority;
  SetItemPriority(otherItem, iCurrPriority);
  SetItemPriority(currentItem, iOtherPriority);
  lbRules.Items.Move(iCurrIndex, iCurrIndex - 1);
  lbRules.ItemIndex := iCurrIndex - 1;
end;

procedure TfrmChannelTogglingRules.cbxAnyNumberOfDaysClick(Sender: TObject);
begin
  edtWindow.enabled := NOT cbxAnyNumberOfDays.Checked;
  if NOT edtWindow.enabled then
    edtWindow.Text := '0';
end;

procedure TfrmChannelTogglingRules.SetItemPriority
  (Item: TChanneltogglingrulesEntity; priority: Integer);
begin
  Item.priority := priority;
  d.roomerMainDataSet.Channeltogglingrules_Entities_UpdateEntity(Item);
end;

function TfrmChannelTogglingRules.gatherEntity: TChanneltogglingrulesEntity;
begin
  result := TChanneltogglingrulesEntity.Create;
  result.setDescription(edtDescription.Text);
  result.setSelectedRoomTypeIDs(getSelectedRoomTypeCodes);
  result.setOccupancyLimit(_StrToFloat(edtOccupancy.Text));
  result.setWhichDaysIndex(getSelectedWhichDaysIndex);
  result.setSelectedDays(getSelectedDaysCodes);
  result.setSelectedMonths(getSelectedTimeOfYearCodes);
  result.setSelectedYears(getSelectedYearCodes);
  result.setSelectedChannelsIDs(getSelectedChannelCodes);
  result.setWindow(StrToIntDef(edtWindow.Text, 0));
  result.setActive(1);
  result.setId(-1);
end;

function TfrmChannelTogglingRules.getRule(id: Integer;
  entity: TChanneltogglingrulesEntity): TChanneltogglingrulesEntity;
var
  i: Integer;
begin
  result := nil;
  for i := LOW(rulesList) to HIGH(rulesList) do
    if rulesList[i].id = id then
    begin
      if entity.priority >= rulesList[i].priority then
      begin
        result := rulesList[i];
        Break;
      end;
    end;

end;

function TfrmChannelTogglingRules.getSelectedChannelCodes: String;
var
  i: Integer;
begin
  result := '';
  for i := 0 to clWhichChannels.Count - 1 do
    if clWhichChannels.Checked[i] then
      if i > 4 then
      begin
        if result = '' then
          result := inttostr
            (TChannelsEntity(clWhichChannels.Items.Objects[i]).id)
        else
          result := result + ',' +
            inttostr(TChannelsEntity(clWhichChannels.Items.Objects[i]).id);
      end
      else
      begin
        if result = '' then
          result := inttostr((i + 1) * -1)
        else
          result := result + ',' + inttostr((i + 1) * -1);
      end;
end;

function TfrmChannelTogglingRules.getSelectedYearCodes: String;
var
  i: Integer;
begin
  result := '';
  for i := 0 to clYears.Count - 1 do
    if clYears.Checked[i] then
      if result = '' then
        result := clYears.Items[i]
      else
        result := result + ',' + clYears.Items[i];
end;

function TfrmChannelTogglingRules.getSelectedTimeOfYearCodes: String;
var
  i: Integer;
begin
  result := '';
  for i := 0 to clMonthsTimeOfYear.Count - 1 do
    if clMonthsTimeOfYear.Checked[i] then
      if result = '' then
        result := inttostr(i + 1)
      else
        result := result + ',' + inttostr(i + 1);
end;

function TfrmChannelTogglingRules.getSelectedDaysCodes: String;
var
  i: Integer;
begin
  result := '';
  for i := 0 to clDays.Count - 1 do
    if clDays.Checked[i] then
      if result = '' then
        result := inttostr(i + 1)
      else
        result := result + ',' + inttostr(i + 1);
end;

function TfrmChannelTogglingRules.getSelectedWhichDaysIndex: Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to clWhichDays.Count - 1 do
    if clWhichDays.Checked[i] then
    begin
      result := i;
      Break;
    end;
end;

function TfrmChannelTogglingRules.getSelectedRoomTypeCodes: String;
var
  i: Integer;
begin
  result := '';
  for i := 0 to clRoomTypes.Items.Count - 1 do
    if clRoomTypes.Checked[i] then
      if result = '' then
        result := inttostr
          (TRoomtypegroupsEntity(clRoomTypes.Items.Objects[i]).id)
      else
        result := result + ',' +
          inttostr(TRoomtypegroupsEntity(clRoomTypes.Items.Objects[i]).id);
end;

procedure TfrmChannelTogglingRules.ClearAllCheckBoxes(cl: TsCheckListBox);
var
  i: Integer;
begin
  for i := 0 to cl.Items.Count - 1 do
    cl.Checked[i] := False;
end;

procedure TfrmChannelTogglingRules.clRoomTypesClickCheck(Sender: TObject);
begin
  TsCheckListBox(Sender).OnClickCheck := nil;
  try
    if (TsCheckListBox(Sender).Items[TsCheckListBox(Sender).ItemIndex] = '---')
    then
    begin
      TsCheckListBox(Sender).Checked[TsCheckListBox(Sender).ItemIndex] := False;
      exit;
    end;
  finally
    TsCheckListBox(Sender).OnClickCheck := clRoomTypesClickCheck;
  end;
  processDescriptionLabel;
end;

procedure TfrmChannelTogglingRules.clWhichDaysClickCheck(Sender: TObject);
var
  idx, i: Integer;
begin

  TsCheckListBox(Sender).OnClickCheck := nil;
  try
    if (TsCheckListBox(Sender).Items[TsCheckListBox(Sender).ItemIndex] = '---')
    then
    begin
      TsCheckListBox(Sender).Checked[TsCheckListBox(Sender).ItemIndex] := False;
      exit;
    end;
    idx := TsCheckListBox(Sender).ItemIndex;
    for i := 0 to TsCheckListBox(Sender).Items.Count - 1 do
      if idx <> i then
        TsCheckListBox(Sender).Checked[i] := False;
  finally
    TsCheckListBox(Sender).OnClickCheck := clWhichDaysClickCheck;
  end;

  processDescriptionLabel;
end;

procedure TfrmChannelTogglingRules.processDescriptionLabel;
begin
  try
    lblRuleDescription.Caption := format(descriptionFormat,
      [edtWindow.Text, getSelectedRoomTypes, edtOccupancy.Text, '%', getSelectedWhichDays,
      getSelectedDays, getSelectedTimeOfYear, getSelectedYears,
      getSelectedChannels]);
    lblRuleDescription.Visible := True;
  except
    lblRuleDescription.Visible := False;
  end;
  if (editingId <> -1) AND (edtDescription.Text = '') then
    pnlDescriptHolder.Color := COLOR_WRONG_INPUT
  else
    pnlDescriptHolder.Color := clBtnFace;
  if (editingId <> -1) AND (StrToIntDef(edtOccupancy.Text, -1) = -1) then
    pnlOccupancyHolder.Color := COLOR_WRONG_INPUT
  else
    pnlOccupancyHolder.Color := clBtnFace; // sPanel1.Color;
  if (editingId <> -1) AND (StrToIntDef(edtWindow.Text, -1) = -1) then
    pnlWindowHolder.Color := COLOR_WRONG_INPUT
  else
    pnlWindowHolder.Color := clBtnFace; // sPanel1.Color;
  BtnOk.Enabled := (Trim(edtDescription.Text) <> '') AND
    (getSelectedRoomTypes <> UNKNOWN_INFO) AND
    (getSelectedWhichDays <> UNKNOWN_INFO) AND
    (getSelectedTimeOfYear <> UNKNOWN_INFO) AND
    (getSelectedDays <> UNKNOWN_INFO) AND (getSelectedYears <> UNKNOWN_INFO) AND
    (getSelectedChannels <> UNKNOWN_INFO) AND
    (NOT(pnlWindowHolder.Color = COLOR_WRONG_INPUT)) AND
    (NOT(pnlDescriptHolder.Color = COLOR_WRONG_INPUT)) AND
    (NOT(pnlOccupancyHolder.Color = COLOR_WRONG_INPUT));
end;

function TfrmChannelTogglingRules.getSelectedRoomTypes: String;
var
  i: Integer;
begin
  result := UNKNOWN_INFO;
  for i := 0 to clRoomTypes.Count - 1 do
    if clRoomTypes.Checked[i] then
      if result = UNKNOWN_INFO then
        result := TRoomtypegroupsEntity(clRoomTypes.Items.Objects[i])
          .description
      else
        result := result + ', ' + TRoomtypegroupsEntity
          (clRoomTypes.Items.Objects[i]).description;
end;

function TfrmChannelTogglingRules.getSelectedChannels: String;
var
  i: Integer;
begin
  result := UNKNOWN_INFO;
  for i := 0 to clWhichChannels.Count - 1 do
    if clWhichChannels.Checked[i] then
      if i > 4 then
      begin
        if result = UNKNOWN_INFO then
          result := TChannelsEntity(clWhichChannels.Items.Objects[i]).name
        else
          result := result + ', ' + TChannelsEntity
            (clWhichChannels.Items.Objects[i]).name;
      end
      else
      begin
        if result = UNKNOWN_INFO then
          result := clWhichChannels.Items[i]
        else
          result := result + ', ' + clWhichChannels.Items[i];
      end;
end;

function TfrmChannelTogglingRules.getSelectedDays: String;
var
  i: Integer;
begin
  result := UNKNOWN_INFO;
  for i := 0 to clDays.Count - 1 do
    if clDays.Checked[i] then
      if result = UNKNOWN_INFO then
        result := clDays.Items[i]
      else
        result := result + ', ' + clDays.Items[i];
end;

function TfrmChannelTogglingRules.getSelectedTimeOfYear: String;
var
  i: Integer;
begin
  result := UNKNOWN_INFO;
  for i := 0 to clMonthsTimeOfYear.Count - 1 do
    if clMonthsTimeOfYear.Checked[i] then
      if result = UNKNOWN_INFO then
        result := clMonthsTimeOfYear.Items[i]
      else
        result := result + ', ' + clMonthsTimeOfYear.Items[i];
end;

function TfrmChannelTogglingRules.getSelectedYears: String;
var
  i: Integer;
begin
  result := UNKNOWN_INFO;
  for i := 0 to clYears.Count - 1 do
    if clYears.Checked[i] then
      if result = UNKNOWN_INFO then
        result := clYears.Items[i]
      else
        result := result + ' and ' + clYears.Items[i];
end;

procedure TfrmChannelTogglingRules.SetButtonActiveStatus;
var
  i: Integer;
begin
  btnInsert.Enabled := True;
  i := lbRules.ItemIndex;
  btnEdit.Enabled := i >= 0;
  btnDelete.Enabled := i >= 0;
  btnUp.Enabled := i > 0;
  btnDown.Enabled := i < lbRules.Items.Count - 1;
end;

procedure TfrmChannelTogglingRules.lbRulesClick(Sender: TObject);
var
  list: TStrings;
  i: Integer;
  rule: TChanneltogglingrulesEntity;
begin
  EmptyEdits;
  BtnOk.Enabled := False;
  SetButtonActiveStatus;
  lblRuleDescription.Visible := lbRules.ItemIndex >= 0;
  if lbRules.ItemIndex < 0 then
    exit;

  rule := TChanneltogglingrulesEntity(lbRules.Items.Objects[lbRules.ItemIndex]);
  edtDescription.Text := rule.description;
  edtOccupancy.Text := FloatToStr(rule.occupancyLimit);
  edtWindow.Text := inttostr(rule.window);
  cbxAnyNumberOfDays.Checked := rule.window = 0;
  cbxAnyNumberOfDaysClick(nil);


  list := SplitStringToTStrings(',', rule.selectedRoomTypeIds);
  try
    for i := 0 to clRoomTypes.Items.Count - 1 do
      clRoomTypes.Checked[i] :=
        list.IndexOf(inttostr(TRoomtypegroupsEntity(clRoomTypes.Items.Objects[i])
        .id)) > -1;
  finally
    list.Free;
  end;

  list := SplitStringToTStrings(',', rule.selectedChannelsIds);
  try
    for i := 0 to clWhichChannels.Items.Count - 1 do
      if i < 5 then
        clWhichChannels.Checked[i] := list.IndexOf(inttostr((i + 1) * -1)) > -1
      else
        clWhichChannels.Checked[i] :=
          list.IndexOf(inttostr(TChannelsEntity(clWhichChannels.Items.Objects[i])
          .id)) > -1;

  finally
    list.Free;
  end;
  clWhichDays.Checked[rule.whichDaysIndex] := True;

  list := SplitStringToTStrings(',', rule.selectedDays);
  try
    for i := 0 to clDays.Items.Count - 1 do
      clDays.Checked[i] := list.IndexOf(inttostr(i + 1)) > -1;
  finally
    list.Free;
  end;

  list := SplitStringToTStrings(',', rule.selectedMonths);
  try
    for i := 0 to clMonthsTimeOfYear.Items.Count - 1 do
      clMonthsTimeOfYear.Checked[i] := list.IndexOf(inttostr(i + 1)) > -1;
  finally
    list.Free;
  end;

  list := SplitStringToTStrings(',', rule.selectedYears);
  try
    for i := 0 to clYears.Items.Count - 1 do
      clYears.Checked[i] := list.IndexOf(clYears.Items[i]) > -1;
  finally
    list.Free;
  end;

  processDescriptionLabel;
end;

function TfrmChannelTogglingRules.getSelectedWhichDays: String;
var
  i: Integer;
begin
  result := UNKNOWN_INFO;
  for i := 0 to clWhichDays.Count - 1 do
    if clWhichDays.Checked[i] then
    begin
      result := clWhichDays.Items[i];
      Break;
    end;
end;

procedure TfrmChannelTogglingRules.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ClearList;
end;

procedure TfrmChannelTogglingRules.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  PrepareWidgets;
end;

procedure TfrmChannelTogglingRules.FormShow(Sender: TObject);
begin
  // If occupancy for <RoomTypes> is above <Occupancy>% for <WhichDays> <days> of <WhichPart(s)OfTheYear> <Year(s)> then turn off <Selected> channels.
  editingId := -1;
  SetEdit(False);
  descriptionFormat := lblRuleDescription.Caption;
  ChannelsAndRoomClasses;
  LoadList;
end;

procedure TfrmChannelTogglingRules.PrepareWidgets;
begin
end;

procedure TfrmChannelTogglingRules.WriteDescription;
begin
  //
end;

procedure TfrmChannelTogglingRules.SetEdit(_on: Boolean);
begin
  lblRuleDescription.Visible := _on OR (lbRules.ItemIndex >= 0);
  pnlList.Enabled := NOT _on;
  tabType.Enabled := _on;
  pnlEditButtons.Enabled := _on;
  if _on then
    tabType.Caption := GetTranslatedText('shTx_FrmChannelTogglingRules_Editing')
  else
    tabType.Caption := GetTranslatedText
      ('shTx_FrmChannelTogglingRules_Viewing');

  clRoomTypes.Enabled := _on;
  clDays.Enabled := _on;
  clMonthsTimeOfYear.Enabled := _on;
  clYears.Enabled := _on;
  clWhichChannels.Enabled := _on;
  clWhichDays.Enabled := _on;

  edtDescription.Enabled := _on;
  edtOccupancy.Enabled := _on;
  edtWindow.Enabled := _on;


  btnCancel.Enabled := _on;
  BtnOk.Enabled := _on;
  if _on AND (editingId <> -2) then
    lbRulesClick(lbRules);
end;

procedure TfrmChannelTogglingRules.ChannelsAndRoomClasses;
var
  i: Integer;
begin
  channelList := d.roomerMainDataSet.Channels_Entities_GetListByWhere
    ('active=1');
  roomClassList := d.roomerMainDataSet.Roomtypegroups_Entities_FindAll;

  clYears.Items.Clear;
  clYears.Items.Add(inttostr(Year(now)));
  clYears.Items.Add(inttostr(Year(now) + 1));

  for i := clWhichChannels.Items.Count - 1 downto 5 do
  begin
    clWhichChannels.Items.Delete(i);
  end;
  for i := LOW(channelList) to HIGH(channelList) do
  begin
    clWhichChannels.Items.AddObject(channelList[i].name, channelList[i]);
  end;

  clRoomTypes.Items.Clear;
  for i := LOW(roomClassList) to HIGH(roomClassList) do
  begin
    clRoomTypes.Items.AddObject(roomClassList[i].Code, roomClassList[i]);
  end;

end;

procedure TfrmChannelTogglingRules.ClearList;
var
  i: Integer;
begin
  if Assigned(rulesList) then
  begin
    for i := LOW(rulesList) to HIGH(rulesList) do
      rulesList[i].Free;
  end;
end;

procedure TfrmChannelTogglingRules.LoadList;
var
  i: Integer;
begin
  ClearList;
  rulesList := d.roomerMainDataSet.SystemListTogglingRules(False);
  // .Channeltogglingrules_Entities_FindAll;
  ShowListOfRules;
end;

procedure TfrmChannelTogglingRules.ShowListOfRules;
var
  i: Integer;
begin
  lbRules.Items.Clear;
  for i := LOW(rulesList) to HIGH(rulesList) do
    lbRules.Items.AddObject(rulesList[i].description, rulesList[i]);
  lbRulesClick(lbRules);
end;

procedure ShowCheannelTogglingRules;
begin
  frmChannelTogglingRules := TfrmChannelTogglingRules.Create(nil);
  try
    frmChannelTogglingRules.ShowModal;
  finally
    freeAndNil(frmChannelTogglingRules);
  end;
end;

{ TDateValue }

constructor TDateValue.Create(_value: TDate);
begin
  value := _value;
end;

end.
