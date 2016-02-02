unit uStaffCommunication;

interface

uses Controls,
     SysUtils,
     Forms,
     cmpRoomerDataSet,
     sPanel,
     acImage
     ;

type
  TStaffCommunication = class
    CommInfoPanel : TsPanel;
  private
    OriginalWidth : Integer;
    OriginalHeight : Integer;
    FNumDayNotes: Integer;
    FDate: TDate;
    procedure pnlInfoClick(Sender: TObject);
    procedure pnlInfoMouseEnter(Sender: TObject);
    procedure pnlInfoMouseLeave(Sender: TObject);
    function ParentAsWinCntrl: TWinControl;
    function GetLeft: Integer;
    function GetTop: Integer;
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure PrepareEvents;
    procedure SetSkinCustomColor(Value: Boolean);
    function FormOfPanel: TForm;
    procedure SetNumDayNotes(const Value: Integer);
    procedure SetDate(const Value: TDate);
    function GenerateHint: String;
    procedure SetHints(Value : String);
  public
    records: TRoomerDataSet;
    constructor Create(pnl : TsPanel);
    destructor Destroy;

    procedure PlaceCorrectly;

    procedure BringToFront;
    procedure DoShine;
    procedure DontShine;

    property Left : Integer read GetLeft write SetLeft;
    property Top : Integer read GetTop write SetTop;
    property Height : Integer read GetHeight write SetHeight;
    property Width : Integer read GetWidth write SetWidth;
    property DayNotes : Integer read FNumDayNotes write SetNumDayNotes;
    property ViewDate : TDate read FDate write SetDate;
    property Hint : String write SetHints;
  end;

implementation

{ TStaffCommunication }

uses uMain,
     uD,
     uDateUtils,
     Graphics,
     uStaffComm,
     uG,
     hData,
     uUtils,
     uAppGlobal
     ;

procedure TStaffCommunication.pnlInfoClick(Sender: TObject);
var theData : recDayNotesHolder;
begin
  InitDayNotes(theData);
  openDayNotes(ViewDate, actNone, false, theData);
  ViewDate := ViewDate;
end;

procedure TStaffCommunication.pnlInfoMouseEnter(Sender: TObject);
begin
  DoShine;
end;

procedure TStaffCommunication.pnlInfoMouseLeave(Sender: TObject);
begin
  DontShine;
end;

const
  BODY_START = '<body bgcolor="#0000FF"><font bgcolor="#0000FF" color="#FFFFFF">';
  BOLD_START = '<b>';
  BOLD_END = '</b>';
  LINE_ITEM = '<p align="%s"><font color="%s" size="%d"><b>%s</b></font></p>';
  BODY_END = '</font></body>';

function TStaffCommunication.GenerateHint : String;
var s : String;
    StaffName : String;
    ChangedByName : String;
begin
  result := BODY_START +
            '<b>Messages for ' + DateToStr(ViewDate) + '</b><br><br>';
  records.First;
  while NOT records.Eof do
  begin
    s := records['notes'];
    s := ReplaceString(s, #10, '<br>');
    if glb.LocateSpecificRecordAndGetValue('staffmembers', 'Initials', records.FieldByName('user').AsString, 'Name', StaffName) then
      StaffName := records['user'];
    if glb.LocateSpecificRecordAndGetValue('staffmembers', 'Initials', records.FieldByName('lastChangedBy').AsString, 'Name', StaffName) then
      ChangedByName := records['user'];
    result := result +
              Format(LINE_ITEM, ['right', '#FFFFFF', 9, StaffName]) +
              Format(LINE_ITEM, ['right', '#FFFFFF', 9, records['action']]) +
              Format(LINE_ITEM, ['left', '#AAAAAA', 9, 'Last change by ' + ChangedByName + ' at ' + DateTimeToStr(records['lastUpdate']) + '<br>' ]) +
              Format(LINE_ITEM, ['left', '#EEEEEE', 7, s]) +
              '<br><hr>'
              ;

    records.Next;
  end;
  result := result + BODY_END;
end;

procedure TStaffCommunication.SetDate(const Value: TDate);
var Sql : String;
begin
  if Assigned(records) then
    records.Free;
  FDate := Value;
  Sql := format('SELECT * FROM daynotes WHERE date=''%s''', [uDateUtils.DateToSqlString(Value)]);
  try
    records := d.roomerMainDataSet.ActivateNewDataset(d.roomerMainDataSet.SystemFreeQuery(sql));
    DayNotes := records.RecordCount;
    Hint := GenerateHint;
  except
    DayNotes := 0;
  end;
end;

procedure TStaffCommunication.SetHeight(const Value: Integer);
begin
  CommInfoPanel.Height := Value;
end;

procedure TStaffCommunication.SetLeft(const Value: Integer);
begin
  CommInfoPanel.Left := Value;
end;

procedure TStaffCommunication.SetNumDayNotes(const Value: Integer);
begin
  FNumDayNotes := Value;
  DontShine;

//  if Assigned(CommInfoPanel) then
//    CommInfoPanel.Visible := Value > 0;
end;

procedure TStaffCommunication.SetTop(const Value: Integer);
begin
  CommInfoPanel.Top := Value;
end;

procedure TStaffCommunication.SetWidth(const Value: Integer);
begin
  CommInfoPanel.Width := Value;
end;

procedure TStaffCommunication.BringToFront;
begin
  CommInfoPanel.BringToFront;
end;

constructor TStaffCommunication.Create(pnl : TsPanel);
begin
  CommInfoPanel := pnl;
  PrepareEvents;
  OriginalHeight := CommInfoPanel.Height;
  OriginalWidth := CommInfoPanel.Width;
  PlaceCorrectly;
  DayNotes := 0;
  records := nil;
  DontShine;
end;

destructor TStaffCommunication.Destroy;
begin
  FreeAndNil(CommInfoPanel);
end;

function TStaffCommunication.FormOfPanel : TForm;
var obj : TObject;
begin
  obj := CommInfoPanel.Parent;
  while NOT (obj IS TForm) do
  begin
    obj := TWinControl(obj).Parent;
  end;
  result := TForm(obj);
end;

procedure TStaffCommunication.SetHints(Value : String);
var i : Integer;
    form : TForm;
begin
  CommInfoPanel.Hint := Value;
  form := FormOfPanel;
  for i := 0 to form.ComponentCount - 1 do
    if (form.Components[i] IS TControl) AND (TControl(form.Components[i]).Parent = CommInfoPanel) then
    begin
      if form.Components[i] IS TsPanel then
        (form.Components[i] AS TsPanel).Hint := Value
      else
      if form.Components[i] IS TsImage then
        (form.Components[i] AS TsImage).Hint := Value
    end;
end;

procedure TStaffCommunication.SetSkinCustomColor(Value : Boolean);
var i : Integer;
    form : TForm;
begin
  CommInfoPanel.SkinData.CustomColor := Value;
  form := FormOfPanel;
  for i := 0 to form.ComponentCount - 1 do
    if (form.Components[i] IS TControl) AND (TControl(form.Components[i]).Parent = CommInfoPanel) then
    begin
      if form.Components[i] IS TsPanel then
        (form.Components[i] AS TsPanel).SkinData.CustomColor := Value
      else
      if form.Components[i] IS TsImage then
        (form.Components[i] AS TsImage).SkinData.CustomColor := Value
    end;
end;

procedure TStaffCommunication.DontShine;
begin
  if FNumDayNotes > 0 then
    SetSkinCustomColor(True)
  else
    SetSkinCustomColor(False);
end;

procedure TStaffCommunication.DoShine;
begin
  SetSkinCustomColor(False)
end;

function TStaffCommunication.GetHeight: Integer;
begin
  result := CommInfoPanel.Height;
end;

function TStaffCommunication.GetLeft: Integer;
begin
  result := CommInfoPanel.Left;
end;

function TStaffCommunication.GetTop: Integer;
begin
  result := CommInfoPanel.Top;
end;

function TStaffCommunication.GetWidth: Integer;
begin
  result := CommInfoPanel.Width;
end;

function TStaffCommunication.ParentAsWinCntrl : TWinControl;
begin
  result := TWinControl(CommInfoPanel.Parent);
end;

procedure TStaffCommunication.PrepareEvents;
var i : Integer;
    form : TForm;
begin
  CommInfoPanel.OnClick := pnlInfoClick;
  CommInfoPanel.OnMouseEnter := pnlInfoMouseEnter;
  CommInfoPanel.OnMouseLeave := pnlInfoMouseLeave;

  form := FormOfPanel;
  for i := 0 to form.ComponentCount - 1 do
    if (form.Components[i] IS TControl) AND (TControl(form.Components[i]).Parent = CommInfoPanel) then
    begin
      if form.Components[i] IS TsPanel then
      begin
        with form.Components[i] AS TsPanel do
        begin
          OnMouseEnter := pnlInfoMouseEnter;
          OnMouseLeave := pnlInfoMouseLeave;
          OnClick := pnlInfoClick;
        end;
      end else
      if form.Components[i] IS TsImage then
      begin
        with form.Components[i] AS TsImage do
        begin
          OnMouseEnter := pnlInfoMouseEnter;
          OnMouseLeave := pnlInfoMouseLeave;
          OnClick := pnlInfoClick;
        end;
      end;
    end;
end;

procedure TStaffCommunication.PlaceCorrectly;
begin
//  Left := ParentAsWinCntrl.Width - Width;
//  Top := 1; // frmMain.PanMain.Top;
//  BringToFront;
end;

initialization

finalization

end.
