unit uRptbViewer;

interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , ppViewr
  , ppTypes
  , ppReport
  , Mask
  , ppForms
  , ppPrvDlg
  , ppUtils
  , StdCtrls
  , ExtCtrls
  , Buttons
  , ComCtrls, sSpeedButton, sPageControl, sLabel, sPanel, cxClasses, cxPropertiesStore
  ;

type
  TfrmRptbViewer = class(TForm)
    Panel1: TsPanel;
    StatusBar1 : TStatusBar;
    PageControl1: TsPageControl;
    TabSheet1: TsTabSheet;
    TabSheet2: TsTabSheet;
    pnlPreviewBar: TsPanel;
    spbPreviewPrint: TsSpeedButton;
    spbPreviewWhole: TsSpeedButton;
    spbPreviewFirst: TsSpeedButton;
    spbPreviewPrior: TsSpeedButton;
    spbPreviewNext: TsSpeedButton;
    spbPreviewLast: TsSpeedButton;
    spbPreviewWidth: TsSpeedButton;
    spbPreview100Percent: TsSpeedButton;
    Bevel1 : TBevel;
    mskPreviewPercentage : TMaskEdit;
    mskPreviewPage : TMaskEdit;
    pnlCancelButton: TsPanel;
    spbPreviewCancel: TsSpeedButton;
    ppViewer1 : TppViewer;
    status: TsLabel;
    FormStore: TcxPropertiesStore;
    procedure spbPreviewPrintClick(Sender : TObject);
    procedure spbPreviewWholeClick(Sender : TObject);
    procedure spbPreviewWidthClick(Sender: TObject);
    procedure spbPreview100PercentClick(Sender: TObject);
    procedure spbPreviewFirstClick(Sender: TObject);
    procedure spbPreviewPriorClick(Sender: TObject);
    procedure spbPreviewNextClick(Sender: TObject);
    procedure spbPreviewLastClick(Sender: TObject);
    procedure mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
    procedure mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
    procedure spbPreviewCancelClick(Sender: TObject);
    procedure ppViewer1PageChange(Sender: TObject);
    procedure ppViewer1PrintStateChange(Sender: TObject);
    procedure ppViewer1StatusChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    function GetReport: TppReport;
    procedure SetReport(const Value: TppReport);
    { Private declarations }
  public
    { Public declarations }
    property Report: TppReport read GetReport write SetReport;
  end;


var
  frmRptbViewer : TfrmRptbViewer;

implementation

{$R *.dfm}

procedure TfrmRptbViewer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (ppViewer1.Report <> nil) and ppViewer1.Report.Printing then
    ppViewer1.Cancel;
end;

procedure TfrmRptbViewer.FormCreate(Sender: TObject);
begin
  ppViewer1.Reset;
end;

function TfrmRptbViewer.GetReport: TppReport;
begin
  Result := ppViewer1.Report as TppReport;
end;

procedure TfrmRptbViewer.mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
var
  liPage: Longint;
begin

  if (Key = #13) then
    begin
      liPage := StrToInt(mskPreviewPage.Text);

      ppViewer1.GotoPage(liPage);
    end; {if, carriage return pressed}

end; {procedure, mskPreviewPageKeyPress}

procedure TfrmRptbViewer.mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
var
  liPercentage: Integer;
begin
  if (Key = #13) then
    begin
      liPercentage := StrToIntDef(mskPreviewPercentage.Text, 100);

      ppViewer1.ZoomPercentage := liPercentage;

      spbPreviewWhole.Down := False;
      spbPreviewWidth.Down := False;
      spbPreview100Percent.Down := False;

      mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
    end; {if, carriage return pressed}

end; procedure TfrmRptbViewer.ppViewer1PageChange(Sender: TObject);
begin
  mskPreviewPage.Text := IntToStr(ppViewer1.AbsolutePageNo);
  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
end;

procedure TfrmRptbViewer.ppViewer1PrintStateChange(Sender: TObject);
var
  lPosition: TPoint;
begin

  if ppViewer1.Busy then
    begin
      mskPreviewPercentage.Enabled := False;
      mskPreviewPage.Enabled := False;

//      pnlPreviewBar.Cursor := crHourGlass;
//      statusbar1.Cursor := crHourGlass;
//      screen.Cursor := crHourGlass;
//      spbPreviewCancel.Cursor := crArrow;

      spbPreviewCancel.Enabled := True;
    end
  else
    begin
      mskPreviewPercentage.Enabled := True;
      mskPreviewPage.Enabled := True;

      pnlPreviewBar.Cursor := crDefault;
      ppViewer1.Cursor := crDefault;
      Statusbar1.Cursor := crDefault;
      spbPreviewCancel.Cursor := crDefault;

      spbPreviewCancel.Enabled := False;
    end;

  {this code will force the cursor to update}
  GetCursorPos(lPosition);
  SetCursorPos(lPosition.X, lPosition.Y);

end; procedure TfrmRptbViewer.ppViewer1StatusChange(Sender: TObject);
begin
  Status.Caption := ppViewer1.Status;
end;

procedure TfrmRptbViewer.SetReport(const Value: TppReport);
begin
  if assigned(ppViewer1.Report) and ppViewer1.Report.Printing then
    ppViewer1.Cancel;

  ppViewer1.Report := Value;
  ppViewer1.Reset;
  ppViewer1.GotoPage(1);
  ppViewer1.Report.PrintToDevices;
end;

{procedure, ppViewer1PrintStateChange}

{procedure, mskPreviewPercentageKeyPress}

procedure TfrmRptbViewer.spbPreview100PercentClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zs100Percent;
  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
  pnlPreviewBar.SetFocus;
end;

procedure TfrmRptbViewer.spbPreviewCancelClick(Sender: TObject);
begin
  if ppViewer1.Report.Printing then
    ppViewer1.Cancel;
end;

procedure TfrmRptbViewer.spbPreviewFirstClick(Sender: TObject);
begin
  ppViewer1.FirstPage;
end;

procedure TfrmRptbViewer.spbPreviewLastClick(Sender: TObject);
begin
  ppViewer1.LastPage;
end;

procedure TfrmRptbViewer.spbPreviewNextClick(Sender: TObject);
begin
  ppViewer1.NextPage;
end;

procedure TfrmRptbViewer.spbPreviewPrintClick(Sender : TObject);
begin
  ppViewer1.Print;
end;

procedure TfrmRptbViewer.spbPreviewPriorClick(Sender: TObject);
begin
  ppViewer1.PriorPage;
end;

procedure TfrmRptbViewer.spbPreviewWholeClick(Sender : TObject);
begin
  ppViewer1.ZoomSetting := zsWholePage;
  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
  pnlPreviewBar.SetFocus;
end;

procedure TfrmRptbViewer.spbPreviewWidthClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zsPageWidth;
  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
  pnlPreviewBar.SetFocus;
end;

initialization

finalization
  FreeAndNil(frmRptbViewer);

end.
