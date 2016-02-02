unit uFrmChannelCopyFrom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, sCheckBox, sComboBox, sLabel, sPanel,
  sListBox, sGroupBox, sButton, cmpRoomerDataSet, System.Generics.Collections, sScrollBox;

type

  TIntValue = class
    value : Integer;
  public
    constructor create(_value : Integer);
  end;

  TValueType = (vtPrice,
                vtAvailability,
                vtMinStay,
                vtMaxStay,
                vtClosedOnArrival,
                vtClosedOnDeparture,
                vtStop,
                vtLengthOfStayArrivalDateBased,
                vtSingleUsePrice);


  TChannelValueEnity = class
    ValueType : TValueType;
    ADate : TDateTime;
    roomClassID : Integer;
    value : Variant;
  public
    constructor create(_ValueType : TValueType;
                       _ADate : TDateTime;
                       _roomClassID : Integer;
                       _value : Variant);
  end;



  TFrmChannelCopyFrom = class(TForm)
    sPanel1: TsPanel;
    lblChannel: TsLabel;
    cbxSourceChannel: TsComboBox;
    pnlParameters: TsPanel;
    Label3: TsLabel;
    dtBulkFrom: TsDateEdit;
    Label4: TsLabel;
    dtBulkTo: TsDateEdit;
    sGroupBox1: TsGroupBox;
    cbxRestrictions: TsCheckBox;
    cbxAvailabilities: TsCheckBox;
    cbxRate: TsCheckBox;
    grpRoomClasses: TsGroupBox;
    sPanel3: TsPanel;
    BtnOk: TsButton;
    btnCancel: TsButton;
    sbRoomClasses: TsScrollBox;
    cbxRoomClass_: TsCheckBox;
    sLabel1: TsLabel;
    cbxDestChannel: TsComboBox;
    procedure FormCreate(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure cbxSourceChannelChange(Sender: TObject);
    procedure cbxRateClick(Sender: TObject);
    procedure dtBulkFromAcceptDate(Sender: TObject; var aDate: TDateTime; var CanAccept: Boolean);
    procedure cbxRoomClass_Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtBulkToCloseUp(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure ListChannels;
    procedure ListRoomClasses(channel: Integer);
    procedure RemoveRoomClassList;
    procedure AddRoomClassToList(chClassRel: TRoomerDataSet);
    procedure CheckOkButton;
    function AnyRoomClassSelected: Boolean;
    function GetRoomClassList: String;
    procedure BuildResultList;
    function LocateChannelManagerByChannelId(chId: Integer): Boolean;
    { Private declarations }
  public
    { Public declarations }
    toChannel,
    planId,
    channelManager : Integer;
    directConnection : Boolean;

    copyPerformed : Boolean;
    channelManagers : TRoomerDataset;
  end;

var
  FrmChannelCopyFrom: TFrmChannelCopyFrom;

var ValueList : TList<TChannelValueEnity>;

function CopyChannelSettings(var _toChannel : Integer; _channelManager, _planId : Integer) : Boolean;

implementation

{$R *.dfm}

uses uAppGlobal
    , uD
    , hData
    , uDateUtils
    , uStringUtils
    ;

function CopyChannelSettings(var _toChannel : Integer; _channelManager, _planId : Integer) : Boolean;
var
  _FrmChannelCopyFrom: TFrmChannelCopyFrom;
begin
  _FrmChannelCopyFrom := TFrmChannelCopyFrom.Create(nil);
  try
    _FrmChannelCopyFrom.toChannel := _toChannel;
    _FrmChannelCopyFrom.channelManager := _channelManager;
    _FrmChannelCopyFrom.planId := _planId;

    _FrmChannelCopyFrom.ShowModal;
    result := _FrmChannelCopyFrom.copyPerformed;
    _toChannel := _FrmChannelCopyFrom.toChannel;
  finally
    _FrmChannelCopyFrom.Free;
  end;
end;

function TFrmChannelCopyFrom.GetRoomClassList : String;
var i : Integer;
begin
  result := '';
  for i := ComponentCount - 1 downto 0 do
    if Components[i] IS TsCheckBox then                  // 1234567890123
      if copy((Components[i] AS TsCheckBox).Name, 1, 13) = 'cbxRoomClass_' then
        if (Components[i] AS TsCheckBox).Checked then
        begin
          if result = '' then
            result := inttostr((Components[i] AS TsCheckBox).Tag)
          else
            result := result + ',' + inttostr((Components[i] AS TsCheckBox).Tag);
        end;
end;


procedure TFrmChannelCopyFrom.BtnOkClick(Sender: TObject);
begin
  BuildResultList;
  toChannel := TIntValue(cbxDestChannel.Items.Objects[cbxDestChannel.ItemIndex]).value;
  CopyPerformed := True;
  Close;
end;

procedure TFrmChannelCopyFrom.BuildResultList;
var roomClassList : String;
    rSet : TRoomerDataSet;
begin
  roomClassList := GetRoomClassList;
  rSet := createNewDataSet;
  rSet_bySQL(rSet,
             format('SELECT ' +
                    'cr1.date, ' +
                    'cr1.roomClassId, ' +
                    'cr1.price, ' +
                    'cr1.availability, ' +
                    'cr1.minStay, ' +
                    'cr1.maxStay, ' +
                    'cr1.closedOnArrival, ' +
                    'cr1.closedOnDeparture, ' +
                    'cr1.stop, ' +
                    'cr1.lengthOfStayArrivalDateBased, ' +
                    'cr1.singleUsePrice ' +
                    'FROM channelrates cr, ' +
                    '	 (SELECT * FROM channelrates ' +
                    '      WHERE channelId=%d ' +
                    '      AND (roomClassId IN (%s)) AND (date>=''%s'' AND date<=''%s'')) cr1 ' +
                    'WHERE cr.channelId=%d ' +
                    'AND (cr.date>=''%s'' AND cr.date<=''%s'') ' +
                    'AND cr.channelManager=%d ' +
                    'AND cr.planCodeId=%d ' +
                    'AND (cr.roomClassId IN (%s)) ' +
                    'AND cr1.roomClassId=cr.roomClassID ' +
                    'AND cr1.date=cr.date ' +
                    'AND cr1.planCodeId=cr.planCodeId',
                    [TIntValue(cbxSourceChannel.Items.Objects[cbxSourceChannel.ItemIndex]).value,
                     roomClassList, uDateUtils.dateToSqlString(dtBulkFrom.Date), uDateUtils.dateToSqlString(dtBulkTo.Date),
                     toChannel, uDateUtils.dateToSqlString(dtBulkFrom.Date), uDateUtils.dateToSqlString(dtBulkTo.Date),
                     channelManager, planId,
                     roomClassList]));

  ValueList := TList<TChannelValueEnity>.Create;
  rSet.First;
  while NOT rSet.Eof do
  begin
    if cbxRate.Checked then
      ValueList.Add(TChannelValueEnity.create(vtPrice, rSet['date'], rSet['roomClassId'], rSet['price']));

    if cbxAvailabilities.Checked then
      ValueList.Add(TChannelValueEnity.create(vtAvailability, rSet['date'], rSet['roomClassId'], rSet['availability']));

    if cbxRestrictions.Checked then
    begin
      ValueList.Add(TChannelValueEnity.create(vtMinStay, rSet['date'], rSet['roomClassId'], rSet['minStay']));
      ValueList.Add(TChannelValueEnity.create(vtMaxStay, rSet['date'], rSet['roomClassId'], rSet['maxStay']));
      ValueList.Add(TChannelValueEnity.create(vtClosedOnArrival, rSet['date'], rSet['roomClassId'], rSet['closedOnArrival']));
      ValueList.Add(TChannelValueEnity.create(vtClosedOnDeparture, rSet['date'], rSet['roomClassId'], rSet['closedOnDeparture']));
      ValueList.Add(TChannelValueEnity.create(vtStop, rSet['date'], rSet['roomClassId'], rSet['stop']));
      ValueList.Add(TChannelValueEnity.create(vtLengthOfStayArrivalDateBased, rSet['date'], rSet['roomClassId'], rSet['lengthOfStayArrivalDateBased']));
      ValueList.Add(TChannelValueEnity.create(vtSingleUsePrice, rSet['date'], rSet['roomClassId'], rSet['singleUsePrice']));
    end;

    rSet.Next;
  end;

end;

procedure TFrmChannelCopyFrom.cbxSourceChannelChange(Sender: TObject);
begin
  if (cbxSourceChannel.ItemIndex < 0) OR
     (cbxDestChannel.ItemIndex < 0) then
       exit;

  pnlParameters.Visible := assigned(cbxSourceChannel.Items.Objects[cbxSourceChannel.ItemIndex]) AND
                           assigned(cbxDestChannel.Items.Objects[cbxDestChannel.ItemIndex]) AND
                           (TIntValue(cbxSourceChannel.Items.Objects[cbxSourceChannel.ItemIndex]).value <>
                             TIntValue(cbxDestChannel.Items.Objects[cbxDestChannel.ItemIndex]).value);
  if pnlParameters.Visible then
  begin
    cbxRate.Checked := False;
    cbxAvailabilities.Checked := False;
    cbxRestrictions.Checked := False;
    toChannel := TIntValue(cbxDestChannel.Items.Objects[cbxDestChannel.ItemIndex]).value;
    if LocateChannelManagerByChannelId(toChannel) then
    begin
      channelManager := channelManagers['id'];
      directConnection := channelManagers['directConnection'];
    end;
    cbxAvailabilities.Visible := directConnection;
    ListRoomClasses(TIntValue(cbxSourceChannel.Items.Objects[cbxSourceChannel.ItemIndex]).value);
  end;
end;

procedure TFrmChannelCopyFrom.cbxRateClick(Sender: TObject);
begin
  CheckOkButton;
end;

procedure TFrmChannelCopyFrom.cbxRoomClass_Click(Sender: TObject);
begin
  CheckOkButton;
end;

procedure TFrmChannelCopyFrom.CheckOkButton;
begin
  BtnOk.Enabled := AnyRoomClassSelected AND
        (cbxRate.Checked OR cbxAvailabilities.Checked OR cbxRestrictions.Checked) AND
        ((Trunc(dtBulkFrom.Date) < Trunc(dtBulkTo.Date)) AND (Trunc(dtBulkFrom.Date) >= Trunc(Now)));
end;

procedure TFrmChannelCopyFrom.dtBulkFromAcceptDate(Sender: TObject; var aDate: TDateTime; var CanAccept: Boolean);
begin
  CheckOkButton;
end;

procedure TFrmChannelCopyFrom.dtBulkToCloseUp(Sender: TObject);
begin
  CheckOkButton;
end;

function TFrmChannelCopyFrom.AnyRoomClassSelected : Boolean;
var i : Integer;
begin
  result := False;
  for i := ComponentCount - 1 downto 0 do
    if Components[i] IS TsCheckBox then                  // 1234567890123
      if copy((Components[i] AS TsCheckBox).Name, 1, 13) = 'cbxRoomClass_' then
        if (Components[i] AS TsCheckBox).Checked then
        begin
          result := True;
          Break;
        end;
end;


procedure TFrmChannelCopyFrom.RemoveRoomClassList;
var i : Integer;
begin
  for i := ComponentCount - 1 downto 0 do
    if Components[i] IS TsCheckBox then                  // 1234567890123
      if copy((Components[i] AS TsCheckBox).Name, 1, 13) = 'cbxRoomClass_' then
        (Components[i] AS TsCheckBox).Free;
end;

procedure TFrmChannelCopyFrom.AddRoomClassToList(chClassRel : TRoomerDataSet);
var i : Integer;
    box : TsCheckBox;
begin
  if glb.LocateSpecificRecord('roomtypegroups', 'id', chClassRel.fieldByName('roomClassId').AsInteger) then
    if glb.RoomTypeGroups['Active'] then
    begin
      box := TsCheckBox.Create(self);
      box.ParentFont := False;
      box.Parent := sbRoomClasses;
      box.Align := alTop;
      box.Top := 1000;
      box.Tag := chClassRel['roomClassId'];
      box.Name := 'cbxRoomClass_' + inttostr(chClassRel['roomClassId']);
      box.Caption := format('[%s] %s', [glb.RoomTypeGroups['Code'], glb.RoomTypeGroups['Description']]);
      box.OnClick := cbxRoomClass_Click;
    end;
end;

procedure TFrmChannelCopyFrom.ListRoomClasses(channel : Integer);
var chClassRel : TRoomerDataSet;
begin
  RemoveRoomClassList;
  chClassRel := createNewDataSet;
  rSet_bySQL(chClassRel,
             format('SELECT * FROM channelclassrelations cr WHERE cr.channelId=%d ' +
                    'AND NOT ISNULL((SELECT id FROM channelclassrelations cr1 WHERE cr1.channelId=%d AND cr1.roomClassId=cr.roomClassId))',
                    [channel, toChannel]));
  chClassRel.First;
  while NOT chClassRel.Eof do
  begin
    AddRoomClassToList(chClassRel);
    chClassRel.Next;
  end;
end;

procedure TFrmChannelCopyFrom.FormCreate(Sender: TObject);
begin
  copyPerformed := False;
  channelManagers := createNewDataSet;
  rSet_bySQL(channelManagers, 'SELECT * FROM channelmanagers WHERE active');
end;

procedure TFrmChannelCopyFrom.FormDestroy(Sender: TObject);
begin
  RemoveRoomClassList;
end;

procedure TFrmChannelCopyFrom.FormShow(Sender: TObject);
begin
  ListChannels;
end;

function TFrmChannelCopyFrom.LocateChannelManagerByChannelId(chId : Integer) : Boolean;
begin
  result := False;
  channelManagers.First;
  while (NOT channelManagers.Eof) do
  begin
    if SplitStringToTStrings(',', channelManagers['channels']).IndexOf(inttostr(chId)) >= 0 then
    begin
      result := True;
      Break;
    end;
    channelManagers.Next;
  end;
end;


procedure TFrmChannelCopyFrom.ListChannels;
begin
  cbxSourceChannel.Clear;
  cbxSourceChannel.Items.AddObject('...', nil);
  cbxDestChannel.Clear;
  cbxDestChannel.Items.AddObject('...', nil);
  glb.ChannelsSet.First;
  while NOT glb.ChannelsSet.Eof do
  begin
    if glb.ChannelsSet['active'] then // AND (glb.ChannelsSet['id'] <> toChannel) then
    begin

      cbxSourceChannel.Items.AddObject(format('[%s] %s', [glb.ChannelsSet['channelManagerId'], glb.ChannelsSet['name']]),
                                 TIntValue.Create(glb.ChannelsSet['id']));

      if LocateChannelManagerByChannelId(glb.ChannelsSet['id']) then
      begin
        if channelManager = channelManagers['id'] then
          cbxDestChannel.Items.AddObject(format('[%s] %s', [glb.ChannelsSet['channelManagerId'], glb.ChannelsSet['name']]),
                                   TIntValue.Create(glb.ChannelsSet['id']));
      end;
    end;
    glb.ChannelsSet.Next;
  end;
end;

{ TIntValue }

constructor TIntValue.create(_value: Integer);
begin
  inherited Create;
  value := _value;
end;

{ TChannelValueEnity }

constructor TChannelValueEnity.create(_ValueType: TValueType; _ADate: TDateTime; _roomClassID: Integer; _value: Variant);
begin
  ValueType := _ValueType;
  ADate := _Adate;
  roomClassID := _roomClassID;
  value := _value;
end;

initialization

   ValueList := nil;

finalization
   if assigned(ValueList) then
   begin
      ValueList.Clear;
      ValueList.Free;
   end;

end.
