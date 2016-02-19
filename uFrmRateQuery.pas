unit uFrmRateQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Forms,
  System.Generics.Collections, cmpRoomerDataset, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.StdCtrls, sButton, sRadioButton, Vcl.Controls, sComboBox, sEdit,
  sSpinEdit, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, sLabel,
  uRoomerLanguage, uAppGlobal,
  Vcl.ExtCtrls, sPanel, sComboEdit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, AdvUtil, Vcl.Samples.Spin;

const WM_SET_DATE_FROM_MAIN = WM_User + 31;

type

  TRateEntity = class
    RateCode: String;
    Description: String;
    Rate: Double;
    FAvailability : Integer;
  private
    procedure SetAvailability(const Value: Integer);
  public
    constructor Create(_RateCode, _Description: String; _Rate: Double; _Availability : Integer);
    destructor Destroy; override;

    procedure AddRateAndAvailability(_Rate : Double; _Availability : Integer);
    property Availability : Integer read FAvailability write SetAvailability;
  end;

  TRateEntityList = TObjectList<TRateEntity>;

  TRoomTypeEntity = class
    RoomType: String;
    Description: String;
    FRates: TRateEntityList;
  public
    constructor Create(_RoomType, _Description: String);
    destructor Destroy; override;

    function RateIndex(Rate: String): Integer;

    property Rates: TRateEntityList read FRates;
  end;

  TRoomTypeEntityList = TObjectList<TRoomTypeEntity>;

  TFrmRateQuery = class(TForm)
    pnlHolder: TPanel;
    pnlTop: TPanel;
    lblArrival: TLabel;
    sLabel1: TLabel;
    edNights: TSpinEdit;
    sLabel2: TLabel;
    sComboBox1: TComboBox;
    sLabel3: TLabel;
    sLabel4: TLabel;
    sSpinEdit1: TSpinEdit;
    sLabel5: TLabel;
    sSpinEdit2: TSpinEdit;
    sLabel6: TLabel;
    sSpinEdit3: TSpinEdit;
    sSpinEdit4: TSpinEdit;
    sLabel7: TLabel;
    sLabel8: TLabel;
    rbTotal: TRadioButton;
    rbAverage: TRadioButton;
    btnRefresh: TButton;
    grdRates: TAdvStringGrid;
    timRefresh: TTimer;
    sLabel9: TLabel;
    cbxChannels: TComboBox;
    dtArrival: TcxDateEdit;
    dtDeparture: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure timRefreshTimer(Sender: TObject);
    procedure grdRatesGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure cbxChannelsChange(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure edNightsDownClick(Sender: TObject);
    procedure edNightsUpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rbTotalClick(Sender: TObject);
    procedure grdRatesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure dtArrivalPropertiesCloseUp(Sender: TObject);
    procedure dtDeparturePropertiesCloseUp(Sender: TObject);
    procedure edNightsChange(Sender: TObject);
  private
    { Private declarations }
    RatesSet: TRoomerDataSet;
    RoomTypes: TRoomTypeEntityList;
    FBeingViewed: Boolean;
    FShowDateFrom: TDateTime;
    FShowDateTo: TDateTime;
    procedure GetData(ADateFrom, ADateTo: TDateTime);
    procedure CollectRatesForSelectedChannel(ChannelCode: String);
    function RoomTypeIndex(RoomType: String): Integer;
    procedure DisplayData;
    function RateIndexInGrid(Rate: String): Integer;
    procedure SetShowDates(const aFrom, aTo: TDateTime);
    procedure CollectChannels;
    function RateIndexByRoomType(RoomTypeIndex: Integer; Rate : String): Integer;
    procedure ClearGrid;
    procedure ClearRates;
    procedure ArrivalDateChange;
    procedure DepartureDateChange;
    procedure SetDateEditColors(dt: TcxDateEdit);
  public
    { Public declarations }
    property BeingViewed: Boolean read FBeingViewed write FBeingViewed;
    procedure ShowRatesForDate(ADate: TDateTime);

    procedure WndProc(var message : TMessage); override;

    property ShowDateFrom: TDateTime read FShowDateFrom write FShowDateFrom;
    property ShowDateTo: TDateTime read FShowDateTo write FShowDateTo;
  end;

var
  FrmRateQuery: TFrmRateQuery;

implementation

{$R *.dfm}

uses uDImages, uD, uDateUtils, hData, uMain;

const WM_REFRESH_ARRIVAL_DATE = WM_User + 32;
      WM_REFRESH_DEPARTURE_DATE = WM_User + 33;


{ TRoomTypeEntity }

constructor TRoomTypeEntity.Create(_RoomType, _Description: String);
begin
  RoomType := _RoomType;
  Description := _Description;
  FRates := TRateEntityList.Create(True);
end;

destructor TRoomTypeEntity.Destroy;
begin
  FRates.Free;
  inherited;
end;

function TRoomTypeEntity.RateIndex(Rate: String): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to FRates.Count - 1 do
    if FRates[i].RateCode = Rate then
    begin
      result := i;
      Break;
    end;
end;

{ TRateEntity }

procedure TRateEntity.AddRateAndAvailability(_Rate: Double; _Availability: Integer);
begin
  Rate := Rate + _Rate;
  Availability := _Availability;
end;

constructor TRateEntity.Create(_RateCode, _Description: String; _Rate: Double; _Availability : Integer);
begin
  RateCode := _RateCode;
  Description := _Description;
  Rate := _Rate;
  FAvailability := _availability;
end;

destructor TRateEntity.Destroy;
begin

end;

procedure TRateEntity.SetAvailability(const Value: Integer);
begin
  if Value < FAvailability then
    FAvailability := Value;
end;

procedure TFrmRateQuery.FormCreate(Sender: TObject);
begin
  RatesSet := CreateNewDataSet;
  FBeingViewed := False;
  RoomTypes := TRoomTypeEntityList.Create(True);
  ClearGrid;
end;

procedure TFrmRateQuery.FormDestroy(Sender: TObject);
begin
  ClearRates;
  FreeAndNil(RoomTypes)
end;

procedure TFrmRateQuery.GetData(ADateFrom, ADateTo: TDateTime);
var
  s, sDateFrom, sDateTo: String;
begin
  Screen.Cursor := crHourglass;
  try
    sDateFrom := dateToSqlString(ADateFrom);
    sDateTo := dateToSqlString(ADateTo);
    s := 'SELECT crId, crDate, Rate, stop, minStay, ' +
          '       IF(availability=-1, ' +
          '          ((SELECT COUNT(id) FROM rooms WHERE active AND RoomType=rtRoomType AND NOT Hidden) - ' +
          '          (SELECT COUNT(id) FROM roomsdate WHERE RoomType=rtRoomType AND Adate=crDate AND (NOT ResFlag IN (''X'',''C'',''B'',''Q'',''Z'',''N'')))), ' +
          '          availability) AS availability, ' +
          ' ' +
          '       rtId, rtRoomType, rtDescription, ' +
          '	   rtgId, rtgCode, rtgTopClass, rtgDescription, ' +
          '       chId, chCode, chName, ' +
          '       cmId, cmCode, cmDescription ' +
          'FROM ' +
          '( ' +
          'SELECT cr.Id AS crId, cr.Date as crDate, cr.Price AS Rate, cr.stop, cr.minStay, ' +
          '       (SELECT availability FROM channelratesavailabilities ' +
          '        WHERE roomClassId=(SELECT id FROM roomtypegroups WHERE Code=rtg.TopClass LIMIT 1) ' +
          '       AND date=cr.date AND planCodeId=cr.planCodeId AND channelManagerId=cm.Id) AS availability, ' +
          '       rt.Id AS rtId, rt.RoomType AS rtRoomType, rt.Description AS rtDescription, ' +
          '	   rtg.Id AS rtgId, rtg.Code AS rtgCode, rtg.TopClass AS rtgTopClass, rtg.Description AS rtgDescription, ' +
          '       ch.id AS chId, ch.channelManagerId AS chCode, ch.name AS chName, ' +
          '       cm.Id AS cmId, cm.Code AS cmCode, cm.Description AS cmDescription ' +
          'FROM channelrates cr, ' +
          '     roomtypegroups rtg, ' +
          '     roomtypes rt, ' +
          '	 channels ch, ' +
          '     channelmanagers cm ' +
          ' ' +
          'WHERE cr.roomClassId = rtg.Id ' +
          'AND ch.Id=cr.channelId ' +
          'AND rt.Active ' +
          'AND rtg.Active ' +
          'AND ch.Active ' +
          'AND cm.Active ' +
          'AND cm.Id=cr.ChannelManager ' +
          'AND rt.RoomTypeGroup=rtg.TopClass ' +
  //        '-- AND FIND_IN_SET(rt.RoomType, rtg.PriorityRule) ' +
          'AND (cr.date >= ''' + sDateFrom + ''' AND cr.date <= ''' + sDateTo + ''') ' +
          ') q1 ' +
          ' ' +
          'UNION ' +
          ' ' +
          'SELECT * FROM ( ' +
          'SELECT 0 AS crId, pdd.Date as crDate, ' +
          '       IF(rt.NumberGuests=1, r.Rate1Person, ' +
          '         IF(rt.NumberGuests=2, r.Rate2Persons, ' +
          '           IF(rt.NumberGuests=3, r.Rate3Persons, ' +
          '             IF(rt.NumberGuests=4, r.Rate4Persons, ' +
          '               IF(rt.NumberGuests=5, r.Rate5Persons, ' +
          '                 IF(rt.NumberGuests=6, r.Rate6Persons, ' +
          '                      IF(r.Rate6Persons>0, r.Rate6Persons + ((rt.NumberGuests-6) * r.RateExtraPerson), ' +
          '                      IF(r.Rate5Persons>0, r.Rate5Persons + ((rt.NumberGuests-5) * r.RateExtraPerson), ' +
          '                      IF(r.Rate4Persons>0, r.Rate4Persons + ((rt.NumberGuests-4) * r.RateExtraPerson), ' +
          '                      IF(r.Rate3Persons>0, r.Rate3Persons + ((rt.NumberGuests-3) * r.RateExtraPerson), ' +
          '                      IF(r.Rate2Persons>0, r.Rate2Persons + ((rt.NumberGuests-2) * r.RateExtraPerson), ' +
          '                      IF(r.Rate1Person>0, r.Rate1Person + ((rt.NumberGuests-1) * r.RateExtraPerson), ' +
          '								rt.NumberGuests * r.RateExtraPerson)))))))))))) AS Rate, ' +
          '          0 AS stop, 1 AS minStay, ' +
          '       ((SELECT COUNT(id) FROM rooms WHERE active AND RoomType=rt.RoomType AND NOT Hidden) - ' +
          '	    (SELECT COUNT(id) FROM roomsdate WHERE RoomType=rt.RoomType AND Adate=pdd.Date AND (NOT ResFlag IN (''X'',''C'',''B'',''Q'',''Z'',''N'')))) AS availability, ' +
          '	   rt.Id AS rtId, rt.RoomType AS rtRoomType, rt.Description AS rtDescription, ' +
          '	   0 AS rtgId, pcCode AS rtgCode, pcCode AS rtgTopClass, pc.pcDescription AS rtgDescription, ' +
          '       0 AS chId,  (SELECT companyID FROM control LIMIT 1) AS chCode, (SELECT companyName FROM control LIMIT 1) AS chName, ' +
          '       0 AS cmId, (SELECT companyID FROM control LIMIT 1) AS cmCode, (SELECT companyName FROM control LIMIT 1) AS cmDescription ' +
          ' ' +
          'FROM roomrates rr, ' +
          '     rates r, ' +
          '     roomtypes rt, ' +
          '     tblpricecodes pc, ' +
          '     predefineddates pdd ' +
          'WHERE (pdd.Date>=''' + sDateFrom + ''' AND pdd.Date<=''' + sDateTo + ''') ' +
          'AND pc.Active ' +
          'AND r.Active ' +
          'AND rr.Active ' +
          'AND rt.Active ' +
          'AND pc.Id=rr.PriceCodeId ' +
          'AND rt.Id=rr.RoomTypeId ' +
          'AND r.Id=rr.RateID ' +
          'AND (rr.DateFrom<=pdd.Date AND pdd.Date<=rr.DateTo) ' +
          ' ' +
          'GROUP BY crDate, chCode, rtId ' +
          ') q ' +
          ' ' +
          'ORDER BY crDate, chCode, rtgId, rtRoomType ';


    if Assigned(RatesSet) then
      FreeAndNil(RatesSet);

    RatesSet := CreateNewDataSet;
    if rSet_bySQL(RatesSet, s) then
    begin
      CollectChannels;
      if cbxChannels.ItemIndex >= 0 then
        CollectRatesForSelectedChannel(cbxChannels.Items[cbxChannels.ItemIndex]);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmRateQuery.cbxChannelsChange(Sender: TObject);
begin
  CollectRatesForSelectedChannel(cbxChannels.Items[cbxChannels.ItemIndex]);
  DisplayData;
  pnlHolder.Update;
end;

procedure TFrmRateQuery.CollectChannels;
var
  CurrentChannel, activeChannel: String;
  index: Integer;
begin
  activeChannel := '';
  if cbxChannels.Items.Count > 0 then
    activeChannel := cbxChannels.Items[cbxChannels.ItemIndex];
  cbxChannels.OnChange := nil;
  try
    RatesSet.First;
    while NOT RatesSet.EOF do
    begin
      CurrentChannel := RatesSet['chCode'];
      if cbxChannels.Items.IndexOf(CurrentChannel) = -1 then
        cbxChannels.Items.Add(CurrentChannel);
      RatesSet.Next;
    end;
    if cbxChannels.Items.Count > 0 then
    begin
      index := 0;
      if activeChannel <> '' then
        index := cbxChannels.Items.IndexOf(activeChannel);
      cbxChannels.ItemIndex := index;
    end;
  finally
    cbxChannels.OnChange := cbxChannelsChange;
  end;
end;

procedure TFrmRateQuery.grdRatesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var theRate : TRateEntity;
    sValue, sAvail : String;
    SavedAlign: word;
begin
  if (ACol > 0) AND (ARow>0) AND
     (Assigned(grdRates.Objects[ACol, ARow])) AND
     (grdRates.Objects[ACol, ARow] IS TRateEntity) AND
     (Round((grdRates.Objects[ACol, ARow] AS TRateEntity).Rate) > 0) then
  begin
    theRate := grdRates.Objects[ACol, ARow] AS TRateEntity;
    if rbTotal.Checked then
      sValue := Trim(FloatToStrF(theRate.Rate, ffNumber, 12, 2))
    else
      sValue := Trim(FloatToStrF(theRate.Rate / edNights.Value, ffNumber, 12, 2));

    sAvail := inttostr(theRate.Availability);

    with grdRates.Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := frmMain.sSkinManager1.GetGlobalColor;
      Font.Color := frmMain.sSkinManager1.GetGlobalFontColor;
      Font.Style := [fsBold];
      if gdSelected in State then
      begin
        Brush.Color := frmMain.sSkinManager1.GetGlobalFontColor;
        Font.Color := frmMain.sSkinManager1.GetGlobalColor;
      end;
      FillRect(Rect);
      SavedAlign := SetTextAlign(Handle, TA_RIGHT);
      TextRect(Rect, Rect.Right - 4, Rect.Top + 2, sValue);

      Font.size := 7;
      Rect.Width := 35;
      Font.Style := [];
      TextRect(Rect, Rect.Right - 4, Rect.Top + 2, sAvail + ' X');

      SetTextAlign(Handle, SavedAlign);
//      Rect.Top := Rect.Bottom - 4;
//      Brush.Color := clBlack;
//      FillRect(Rect);
      exit;
    end;

  end else
    inherited;

end;

procedure TFrmRateQuery.grdRatesGetCellColor(Sender: TObject;
  ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (ARow > 0) AND (ACol > 0) then
    if NOT Assigned(grdRates.Objects[ACol, ARow]) OR
    ((Assigned(grdRates.Objects[ACol, ARow])) AND
     (grdRates.Objects[ACol, ARow] IS TRateEntity) AND
     (Round((grdRates.Objects[ACol, ARow] AS TRateEntity).Rate) = 0)) then
    begin
      ABrush.Color := frmMain.sSkinManager1.GetGlobalColor;
//      ABrush.Pen.Color := frmMain.sSkinManager1.GetGlobalFontColor;
      ABrush.Style := bsFDiagonal;
    end;
end;

function TFrmRateQuery.RoomTypeIndex(RoomType: String): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to RoomTypes.Count - 1 do
    if RoomTypes[i].RoomType = RoomType then
    begin
      result := i;
      Break;
    end;
end;

function TFrmRateQuery.RateIndexByRoomType(RoomTypeIndex: Integer; Rate : String): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to RoomTypes[RoomTypeIndex].Rates.Count - 1 do
    if RoomTypes[RoomTypeIndex].Rates[i].RateCode = Rate then
    begin
      result := i;
      Break;
    end;
end;

procedure TFrmRateQuery.btnRefreshClick(Sender: TObject);
begin
  setShowDates(dtArrival.Date, dtDeparture.Date - 1);
end;

procedure TFrmRateQuery.CollectRatesForSelectedChannel(ChannelCode: String);
var
  CurrentRoomType: String;
  index, RateIndex: Integer;
begin
  ClearRates;
  RatesSet.First;
  while NOT RatesSet.EOF do
  begin
    if RatesSet['chCode'] = ChannelCode then
    begin
      CurrentRoomType := RatesSet['rtRoomType'];
      if RoomTypeIndex(CurrentRoomType) = -1 then
      begin
        RoomTypes.Add(TRoomTypeEntity.Create(CurrentRoomType,
          RatesSet['rtDescription']));
      end;
    end;
    RatesSet.Next;
  end;

  RatesSet.First;
  while NOT RatesSet.EOF do
  begin
    if RatesSet['chCode'] = ChannelCode then
    begin
      CurrentRoomType := RatesSet['rtRoomType'];
      index := RoomTypeIndex(CurrentRoomType);
      if index > -1 then
      begin
        RateIndex := RateIndexByRoomType(index, RatesSet['rtgCode']);
        if RateIndex = -1 then
          RoomTypes[index].Rates.Add(TRateEntity.Create(RatesSet['rtgCode'],
            RatesSet['rtgDescription'], RatesSet['Rate'], RatesSet['availability']))
        else
          RoomTypes[index].Rates[RateIndex].AddRateAndAvailability(RatesSet['Rate'], RatesSet['availability']);
      end;
    end;
    RatesSet.Next;
  end;
end;

function TFrmRateQuery.RateIndexInGrid(Rate: String): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 1 to grdRates.RowCount - 1 do
  begin
    if grdRates.Cells[0, i] = Rate then
    begin
      result := i;
      Break;
    end;
  end;
end;

procedure TFrmRateQuery.DisplayData;
var
  i, l, index: Integer;
  sValue : String;
begin
  grdRates.BeginUpdate;
  try
    ClearGrid;
    grdRates.ColCount := RoomTypes.Count + 1;
    grdRates.RowCount := 1;
    for i := 0 to RoomTypes.Count - 1 do
    begin
      grdRates.Cells[i + 1, 0] := RoomTypes[i].RoomType;
      for l := 0 to RoomTypes[i].Rates.Count - 1 do
      begin
        index := RateIndexInGrid(RoomTypes[i].Rates[l].RateCode);
        if index = -1 then
        begin
          grdRates.RowCount := grdRates.RowCount + 1;
          index := grdRates.RowCount - 1;
          grdRates.Cells[0, index] := RoomTypes[i].Rates[l].RateCode;
        end;
        grdRates.Objects[i + 1, index] := RoomTypes[i].Rates[l];
      end;
    end;
  finally
    grdRates.EndUpdate;
  end;
end;

procedure TFrmRateQuery.ArrivalDateChange;
begin
  if dtArrival.Date > dtDeparture.Date then
    dtDeparture.Date := dtArrival.Date + edNights.Value;

  edNights.Value := Trunc(dtDeparture.Date) - Trunc(dtArrival.Date);
end;

procedure TFrmRateQuery.dtArrivalPropertiesCloseUp(Sender: TObject);
begin
  postMessage(Handle, WM_REFRESH_ARRIVAL_DATE, 0, 0);
end;

procedure TFrmRateQuery.dtDeparturePropertiesCloseUp(Sender: TObject);
begin
  postMessage(Handle, WM_REFRESH_DEPARTURE_DATE, 0, 0);
end;

procedure TFrmRateQuery.DepartureDateChange;
begin
  edNights.Value := Trunc(dtDeparture.Date) - Trunc(dtArrival.Date);
end;

procedure TFrmRateQuery.edNightsChange(Sender: TObject);
var dtA, dtD : TDateTime;
begin
  dtA := dtArrival.Date;
  dtD := dtDeparture.Date;
  dtD := dtA + edNights.Value;
  dtDeparture.Date := dtD;
  dtArrival.Date := dtA;
end;

procedure TFrmRateQuery.edNightsDownClick(Sender: TObject);
var dtA, dtD : TDateTime;
begin
  dtA := dtArrival.Date;
  dtD := dtDeparture.Date;
  edNights.Value := edNights.Value - 1;
  dtD := dtA + edNights.Value;
  if dtD <= dtA then
    dtA := dtD - 1;
  dtDeparture.Date := dtD;
  dtArrival.Date := dtA;
  edNights.Value := Trunc(dtDeparture.Date) - Trunc(dtArrival.Date);
end;

procedure TFrmRateQuery.edNightsUpClick(Sender: TObject);
begin
  edNights.Value := edNights.Value + 1;
  dtDeparture.Date := dtArrival.Date + edNights.Value;
end;

procedure TFrmRateQuery.SetDateEditColors(dt : TcxDateEdit);
begin
  with dt do begin
    Style.Color := frmMain.sSkinManager1.GetActiveEditColor;
    Style.TextColor := frmMain.sSkinManager1.GetActiveEditFontColor;

    StyleDisabled.Color := frmMain.sSkinManager1.GetActiveEditColor;
    StyleDisabled.TextColor := frmMain.sSkinManager1.GetHighLightFontColor(true);

    StyleFocused.Color := frmMain.sSkinManager1.GetHighLightColor(false);
    StyleFocused.TextColor := frmMain.sSkinManager1.GetHighLightFontColor(false);

    StyleHot.Color := frmMain.sSkinManager1.GetActiveEditColor;
    StyleHot.TextColor := frmMain.sSkinManager1.GetActiveEditFontColor;
  end;
end;

procedure TFrmRateQuery.SetShowDates(const aFrom, aTo: TDateTime);
begin
  SetDateEditColors(dtArrival);
  SetDateEditColors(dtDeparture);

  FShowDateFrom := AFrom;
  FShowDateTo := ATo;

  dtArrival.Date := AFrom;
  dtDeparture.Date := ATo + 1;

  edNights.Value := Trunc(dtDeparture.Date) - Trunc(dtArrival.Date);

  timRefresh.Enabled := True;
end;

procedure TFrmRateQuery.ShowRatesForDate(ADate: TDateTime);
begin
  setShowDates(ADate, ADate);
end;

procedure TFrmRateQuery.rbTotalClick(Sender: TObject);
begin
  DisplayData;
  pnlHolder.Update;
end;

procedure TFrmRateQuery.ClearRates;
begin
  RoomTypes.Clear;
end;

procedure TFrmRateQuery.ClearGrid;
begin
  grdRates.ClearAll;
  grdRates.RowCount := 1;
  grdRates.ColCount := 1;
  Application.ProcessMessages;
end;

procedure TFrmRateQuery.timRefreshTimer(Sender: TObject);
begin
  timRefresh.Enabled := False;
  GetData(FShowDateFrom, FShowDateTo);
  DisplayData;
  pnlHolder.Update;
end;

procedure TFrmRateQuery.WndProc(var message: TMessage);
begin
  if message.Msg = WM_REFRESH_ARRIVAL_DATE then
    ArrivalDateChange
  else
  if message.Msg = WM_REFRESH_DEPARTURE_DATE then
    DepartureDateChange
  else
  if message.Msg = WM_SET_DATE_FROM_MAIN then
    ShowRatesForDate(message.LParam);

  inherited WndProc(message);
end;

end.
