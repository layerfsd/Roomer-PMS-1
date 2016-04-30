unit uCommunicationTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sMemo, Vcl.ExtCtrls, sPanel, sButton, sLabel, sSplitter;

type
  TfrmCommunicationTest = class(TForm)
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    timTest: TTimer;
    lblTestsStopped: TsLabel;
    sPanel3: TsPanel;
    sPanel4: TsPanel;
    mmoLogs: TsMemo;
    sButton1: TsButton;
    sPanel5: TsPanel;
    sSplitter1: TsSplitter;
    sPanel6: TsPanel;
    sButton2: TsButton;
    mmoTop: TsMemo;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    btnStopStart: TsButton;
    btnClose: TsButton;
    procedure btnStopStartClick(Sender: TObject);
    procedure timTestTimer(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
  private
    { Private declarations }
    TopListTinyTable : TStringList;
    TopListBiggerTable : TStringList;
    LoopCounter : Integer;
    procedure AddToTop(value: integer; text : String; whichList : integer);
    function ShouldAddToTop(value: integer; list : TStringList): Boolean;
  public
    { Public declarations }
  end;

var
  frmCommunicationTest: TfrmCommunicationTest;

procedure CommunicationTest;

implementation

{$R *.dfm}

uses uD
     , uUtils
     , cmpRoomerDataSet,
     uStringUtils,
     uAppGlobal,
     PrjConst,
     uDImages

     ;

var
  StrTinyTable, StrBiggerTable : String;

procedure CommunicationTest;
begin
  frmCommunicationTest := TfrmCommunicationTest.Create(nil);
  try
    frmCommunicationTest.ShowModal;
  finally
    FreeAndNil(frmCommunicationTest);
  end;
end;

procedure TfrmCommunicationTest.btnStopStartClick(Sender: TObject);
begin
  LoopCounter := 0;
  if TsButton(Sender).Tag=0 then
  begin
    lblTestsStopped.Visible := False;
    TsButton(Sender).Tag := 1;
    TsButton(Sender).Caption := 'Stop';
    mmoLogs.Text := '';
  end else
  begin
    TsButton(Sender).Tag := 0;
    TsButton(Sender).Caption := 'Start';
  end;
  timTest.Enabled := (TsButton(Sender).Tag=1);
end;

procedure TfrmCommunicationTest.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  StrTinyTable := 'Tiny table '; // GetTranslatedText('shTx_CommunicationTest_DayGuests');
  StrBiggerTable := 'Bigger table '; // GetTranslatedText('shTx_CommunicationTest_CustomerList');
  TopListTinyTable := TStringList.Create;
  TopListBiggerTable := TStringList.Create;
end;

procedure TfrmCommunicationTest.FormDestroy(Sender: TObject);
begin
  TopListTinyTable.Free;
  TopListBiggerTable.Free;
end;

procedure TfrmCommunicationTest.sButton1Click(Sender: TObject);
begin
  uStringUtils.ClipboardCopy(mmoLogs.Text);
end;

procedure TfrmCommunicationTest.sButton2Click(Sender: TObject);
begin
  uStringUtils.ClipboardCopy(mmoTop.Text);
end;

procedure TfrmCommunicationTest.timTestTimer(Sender: TObject);
var tickCountStart : longint;
    tickCountEnd : longint;
    rSet : TRoomerDataSet;
begin
  timTest.Enabled := False;
  try
    inc(LoopCounter);
    if LoopCounter > 50 then
    begin
      lblTestsStopped.Visible := True;
      btnStopStartClick(btnStopStart);
      exit;
    end;

    tickCountStart := GetTickCount;

    rSet := d.roomerMainDataSet.ActivateNewDataset(
              d.roomerMainDataSet.SystemFreeQuery('SELECT * FROM predefineddates LIMIT 4000')); // SystemGetDayGrid(now, now + 1, 'rsAll'));

    tickCountEnd := GetTickCount;
    mmoLogs.Lines.BeginUpdate;
    try
      mmoLogs.Lines.Insert(0, StrTinyTable + inttostr(tickCountEnd - tickCountStart) + ' ms' );
      AddToTop(tickCountEnd - tickCountStart, StrTinyTable, 0);

      tickCountStart := GetTickCount;

      rSet := d.roomerMainDataSet.ActivateNewDataset(
                d.roomerMainDataSet.SystemFreeQuery('SELECT d.*, CONCAT(d.extraIdentity, ''-'', d.text) AS conText1, CONCAT(d.formType, ''-'', d.compname, ''-'', d.extraIdentity, ''-'', d.text) AS conText2  FROM home100.dictionary d LIMIT 4000'));

      tickCountEnd := GetTickCount;
      mmoLogs.Lines.Insert(0, StrBiggerTable + inttostr(tickCountEnd - tickCountStart) + ' ms' );
      AddToTop(tickCountEnd - tickCountStart, StrBiggerTable, 1);
    finally
      mmoLogs.Lines.EndUpdate;
      btnStopStart.Caption := format('[%d/50]', [LoopCounter]);
    end;

  finally
    timTest.Enabled := (btnStopStart.Tag=1);
  end;
end;

function TfrmCommunicationTest.ShouldAddToTop(value : integer; list : TStringList) : Boolean;
var s : String;
    I: Integer;
    sValues : TStrings;
begin
  if list.Count < 10 then
  begin
    result := true;
    exit;
  end;

  result := false;
  for I := 0 to list.Count - 1 do
  begin
    sValues := SplitStringToTStrings('|', list[I]);
    try
      if StrToInt(sValues[0]) < value then
      begin
        result := true;
        break;
      end;
    finally
      sValues.Free;
    end;
  end;
end;

function AddLeadingZeroes(const aNumber, Length : integer) : string;
begin
   result := Format('%.*d', [Length, aNumber]) ;
end;

procedure TfrmCommunicationTest.AddToTop(value : integer; text : String; whichList : integer);
var I: Integer;
    sValues : TStringList;
    list : TStringlist;
begin
  if whichList = 0 then
    list := TopListTinyTable
  else
    list := TopListBiggerTable;
  if ShouldAddToTop(value, list) then
  begin
    list.Add(AddLeadingZeroes(value, 7) + '|' + text + ' ms');
    list.Sort;
    if list.Count > 10 then
      list.Delete(0);
    mmoTop.Lines.BeginUpdate;
    sValues := TStringlist.Create;
    try
      mmoTop.Lines.Clear;

      for I := 0 to TopListTinyTable.Count - 1 do
      begin
        SplitStringToTStrings('|', TopListTinyTable[I], sValues);
        mmoTop.Lines.Insert(0, sValues[1] + ' ' + inttostr(strtoint(sValues[0])));
      end;
      for I := 0 to TopListBiggerTable.Count - 1 do
      begin
        SplitStringToTStrings('|', TopListBiggerTable[I], sValues);
        mmoTop.Lines.Insert(0, sValues[1] + ' ' + inttostr(strtoint(sValues[0])));
      end;
    finally
      mmoTop.Lines.EndUpdate;
      sValues.Free;
    end;
    mmoTop.Update;
  end;
end;

end.
