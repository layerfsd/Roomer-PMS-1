unit uChart;

//******


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, sStatusBar, Vcl.ExtCtrls, AdvChartView, AdvChartViewGDIP, AdvChart,
  sSkinProvider;

type
  TfrmChart = class(TForm)
    AdvGDIPChartView1: TAdvGDIPChartView;
    Panel1: TPanel;
    sStatusBar1: TsStatusBar;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function openChart : boolean;

var
  frmChart: TfrmChart;

implementation

{$R *.dfm}

function openChart : boolean;
begin
  result := false;
  frmChart := TfrmChart.Create(frmChart);
  try
    frmChart.ShowModal;
    if frmChart.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmChart);
  end;
end;


procedure TfrmChart.Button1Click(Sender: TObject);
begin
  AdvGDIPChartView1.Panes[0].XAxis.Size := 100;
  AdvGDIPChartView1.Panes[0].Range.RangeFrom := 0;
  AdvGDIPChartView1.Panes[0].Range.RangeTo := 40;
  AdvGDIPChartView1.Panes[0].Series[0].ChartType := ctXYLine;
  AdvGDIPChartView1.Panes[0].Series[0].XAxis.AutoUnits := false;
  AdvGDIPChartView1.Panes[0].Series[0].XAxis.XYValues := true;
  AdvGDIPChartView1.Panes[0].Series[0].AddSingleXYPoint(5.5, Random(100));
  AdvGDIPChartView1.Panes[0].Series[0].AddSingleXYPoint(8, Random(100));
  AdvGDIPChartView1.Panes[0].Series[0].AddSingleXYPoint(15.1, Random(100));
  AdvGDIPChartView1.Panes[0].Series[0].AddSingleXYPoint(17, Random(100));
  AdvGDIPChartView1.Panes[0].Series[0].AddSingleXYPoint(20, Random(100));
  AdvGDIPChartView1.Panes[0].Series[0].AddSingleXYPoint(22.5, Random(100));
  AdvGDIPChartView1.Panes[0].Series[0].AddSingleXYPoint(26.5, Random(100));
  AdvGDIPChartView1.Panes[0].Series[0].AddSingleXYPoint(28.6, Random(100));
  AdvGDIPChartView1.Panes[0].Series[0].AddSingleXYPoint(36.9, Random(100));
end;

end.
