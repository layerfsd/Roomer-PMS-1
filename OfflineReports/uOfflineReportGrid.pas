unit uOfflineReportGrid;

interface

uses
  Classes, WIndows,

  AdvUtil, Vcl.StdCtrls, sButton, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.Forms, Vcl.Controls, Vcl.ExtCtrls, sPanel
  ;

type
  TOfflineReportFile = class(TObject)
  private
    FPath: string;
    FGeneratedAt: TDateTime;
    FReportName: string;
  public
    constructor CreateFromPath(const aPath: string);
    property Path: string read FPath;
    property ReportName: string read FReportName;
    property GeneratedAt: TDateTime read FGeneratedAt;
  end;

  TfrmOfflineReports = class(TForm)
    pnlMain: TsPanel;
    pnlButtons: TsPanel;
    pnlTop: TsPanel;
    btnClose: TsButton;
    agrReports: TAdvStringGrid;
    btnOpenReport: TsButton;
    procedure FormShow(Sender: TObject);
    procedure btnOpenReportClick(Sender: TObject);
    procedure agrReportsDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormCreate(Sender: TObject);
  private
    FFileList: TStringlist;
    FOffline: boolean;
    FUpdatingControls: boolean;
    procedure UpdateGridHeader;
    procedure UpdateGrid;
    procedure UpdateControls;
    procedure UpdateFileList;
    procedure OpenReport(const aPath: string);
    procedure SetOffline(const Value: boolean);
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property RoomerOffline: boolean read FOffline write SetOffline;
  end;

const
  cshTx_OfflineReports_OfflineMessage = 'shTx_OflineReports_OfflineMessage';
  cshTx_OfflineReports_NameHeader     = 'shTx_OflineReports_NameHeader';
  cshTx_OfflineReports_DateGenHeader  = 'shTx_OflineReports_DateGenHeader';


implementation

uses
  IOUtils,
  SysUtils,
  Types,
  VCL.Graphics,
  ShellAPI,
  uDateUtils,
  uAppGlobal,
  Math,
  PrjConst
  ;

{$R *.dfm}

const
  cTopPanelColor: array[boolean] of TColor = (clBtnFace, clRed);
  cTopPanelCaption: array[Boolean] of string = ('', 'shTx_OflineReports_OfflineMessage');

function SortByDateDesc(List: TStringList; Index1, Index2: Integer): Integer;
var
  l1, l2: TOfflineReportFile;
begin
  l1 := TOfflineReportFile(List.Objects[Index1]);
  l2 := TOfflineReportFile(List.Objects[Index2]);
  Result := - CompareStr(DateTimeToComparableString(l1.GeneratedAt), DateTimeToComparableString(l2.GeneratedAt));
end;

procedure TfrmOfflineReports.UpdateGrid;
var
  i: integer;
  d: TDateTime;
begin
  UpdateFileList;

  with agrReports do
  begin
    BeginUpdate;
    try
      RowCount := FFileList.Count+1;

      UpdateGridHeader;

      for i := 0 to FFilelist.count-1 do
      begin
        Cells[0, i+1] := TOfflineReportFile(FFilelist.Objects[i]).ReportName;
        d := TOfflineReportFile(FFilelist.Objects[i]).GeneratedAt;
        if d = 0 then
          Cells[1,i+1] := '<Unknown>'
        else
          Cells[1, i+1] := FormatDateTime(FormatSettings.ShortDateFormat, d) + ' ' +
                         FormatDateTime('['+ FormatSettings.ShortTimeFormat + ']', d)
      end;

      AutoSizeColumns(False);
      AutoSizeRows(False);

    finally
      EndUpdate;
    end;
  end;
end;

procedure TfrmOfflineReports.UpdateGridHeader;
begin
  with agrReports do
  begin
    Cells[0,0] := GetTranslatedText(cshTx_OfflineReports_NameHeader);
    Cells[1,0] := GetTranslatedText(cshTx_OfflineReports_DateGenHeader);
  end;

end;

procedure TfrmOfflineReports.agrReportsDblClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  if InRange(aRow, 1, FFileList.count) then
    OpenReport(FFileList[aRow-1]);
end;

procedure TfrmOfflineReports.btnOpenReportClick(Sender: TObject);
begin
  if InRange(agrReports.Row, 1, FFileList.Count) then
    OpenReport(FFileList[agrReports.Row-1]);
end;

procedure TfrmOfflineReports.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
end;

constructor TfrmOfflineReports.Create(aOwner: TComponent);
begin
  inherited;
  FFileList := TStringlist.Create;
  FFileList.OwnsObjects := True;
end;

destructor TfrmOfflineReports.Destroy;
begin
  FFilelist.Free;
  inherited;
end;

procedure TfrmOfflineReports.FormShow(Sender: TObject);
begin
  UpdateGrid;
end;

procedure TfrmOfflineReports.OpenReport(const aPath: string);
begin
  ShellExecute(Handle, 'OPEN', PChar(aPath), nil, nil, sw_shownormal);
end;

procedure TfrmOfflineReports.SetOffline(const Value: boolean);
begin
  FOffline := Value;
  UpdateControls;
end;

procedure TfrmOfflineReports.UpdateControls;
begin
  if not FUpdatingControls then
  try
    FUpdatingControls := True;

    pnlTop.Color := cTopPanelColor[FOffline];
    pnlTop.Caption := GetTranslatedText(cTopPanelCaption[FOffLine]);

    UpdateGrid;
  finally
    FUpdatingControls := False;
  end;
end;

procedure TfrmOfflineReports.UpdateFileList;
var
  lFile: string;
begin
  FFileList.BeginUpdate;
  try

    FFileList.Clear;

    for lFile in TDirectory.GetFiles(glb.GetOfflinereportLocation, '*.PDF') do
      FFileList.AddObject(lFile, TOfflineReportFile.CreateFromPath(lFile));

    FFileList.CustomSort(SortByDateDesc);
  finally
    FFileList.EndUpdate;
  end;
end;


{ TOfflineReportFile }

constructor TOfflineReportFile.CreateFromPath(const aPath: string);
var
  lFile: string;
  lHyphenPos: integer;
begin
  inherited Create;
  FPath := aPath;

  lFile := ChangeFileExt(ExtractFileName(aPath), '') ;
  lHyphenPos := Pos('-', lFile);
  FReportName := Copy(lFile, 1, lHyphenPos-1);
  try
    FGeneratedAt := DateTimeFromYYMMDD( Copy(lFile, lHyphenPos+1));
  except
    FGeneratedAt := 0;
  end;
end;

end.
