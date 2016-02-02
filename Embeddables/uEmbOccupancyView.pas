unit uEmbOccupancyView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.ExtCtrls, sPanel,
  uD, HData, PrjConst, cmpRoomerDataSet, uSqlDefinitions, uDateUtils, uUtils, uRoomerLanguage, uAppGlobal;

type

  TOccupancyViewType = (ovtDefault, ovtAdvanced);

  TembOccupancyView = class(TForm)
    pnlEmbeddable: TsPanel;
    grdOccupancy: TAdvStringGrid;
    procedure grdOccupancyGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
  private
    fromDate, toDate: TDateTime;
    FOccupancyViewType: TOccupancyViewType;
    procedure TranslateAll;
    procedure RefreshStats;
    procedure SetOccupancyViewType(const Value: TOccupancyViewType);
    function GetOriginalParentHeight: Integer;
    procedure SetOriginalParentHeight(const Value: Integer);
    { Private declarations }
  protected
    FOriginalParentHeight : Integer;
  public
    { Public declarations }
    procedure InitEmbededOccupancyView(prnt : TWinControl);
    procedure Release;

    procedure ShowOccupancy(fromDate, toDate : TDateTime); overload;

    procedure SetCellWidth(ACol, AWidth : Integer);

    procedure Reset;
    property OccupancyViewType : TOccupancyViewType read FOccupancyViewType write SetOccupancyViewType;
    property OriginalParentHeight : Integer read GetOriginalParentHeight write SetOriginalParentHeight;
  end;

var
  embOccupancyView: TembOccupancyView;

implementation

{$R *.dfm}

{ TembOccupancyView }

procedure TembOccupancyView.SetCellWidth(ACol, AWidth: Integer);
begin
  grdOccupancy.ColWidths[ACol] := AWidth;
end;

procedure TembOccupancyView.SetOccupancyViewType(const Value: TOccupancyViewType);
begin
  if FOccupancyViewType <> Value then
  begin
    FOccupancyViewType := Value;
    if FOccupancyViewType = ovtDefault then
      pnlEmbeddable.Parent.Height := FOriginalParentHeight
    else
      pnlEmbeddable.Parent.Height := 200;

    RefreshStats;
    TranslateAll;
  end;
end;

procedure TembOccupancyView.SetOriginalParentHeight(const Value: Integer);
begin
  FOriginalParentHeight := Value;
end;

procedure TembOccupancyView.ShowOccupancy(fromDate, toDate: TDateTime);
begin
  self.FromDate := fromDate;
  self.ToDate := toDate;

  grdOccupancy.BeginUpdate;
  try
    grdOccupancy.ColCount := trunc(toDate) - trunc(fromDate) + 1;
    grdOccupancy.FixedCols := 1;
    RefreshStats;
    TranslateAll;
    grdOccupancy.Show;
  finally
    grdOccupancy.EndUpdate;
  end;
end;

procedure TembOccupancyView.RefreshStats;
var
  OCC, ADR, REVPAR, Revenue, BAR : Double;
  RoomsSold, RoomCount, Availability, OOO : Integer;
  s : String;
  rSet : TRoomerDataSet;
  col : Integer;
begin
    s := format(HOTEL_PERFORMANCE_QUERY_BETWEEN_DATES,
         [
          dateToSqlString(FromDate),
          dateToSqlString(ToDate),

          dateToSqlString(FromDate),
          dateToSqlString(ToDate),

          dateToSqlString(FromDate),
          dateToSqlString(ToDate)
         ]);

//    copytoclipboard(s);
//    debugmessage(s);

    grdOccupancy.RowCount := 3 + (4 * ABS(ORD(OccupancyViewType = ovtAdvanced)));
    grdOccupancy.ColCount := trunc(toDate) - trunc(fromDate) + 2;
    rSet := CreateNewDataSet;
    try
        hData.rSet_bySQL(rSet, s);
        rSet.First;
        col := 0;
        while NOT rSet.EOF do
        begin
          inc(col);

          OCC := rSet['OCC'];
          REVPAR := rSet['RevPar'];
          Availability := rSet['Availability'];
          OOO := rSet['OOO'];

          grdOccupancy.Cells[col,0] := formatFloat('#,##0.00 %', OCC);
          grdOccupancy.Cells[col,1] := inttostr(Availability - OOO);
          grdOccupancy.Cells[col,2] := formatFloat('#,##0.00', REVPAR);

          if OccupancyViewType = ovtAdvanced then
          begin
            Revenue := rSet['Revenue'];
            RoomsSold := rSet['RoomsSold'];
            ADR := rSet['ADR'];
            BAR := 0.00;

            grdOccupancy.Cells[col,3] := formatFloat('#,##0.00', Revenue);
            grdOccupancy.Cells[col,4] := inttostr(RoomsSold);
//            grdOccupancy.Cells[col,5] := formatFloat('#,##0.00', BAR);
            grdOccupancy.Cells[col,5] := inttostr(OOO);
            grdOccupancy.Cells[col,6] := formatFloat('#,##0.00', ADR);
          end;

          rSet.Next;
        end;
    finally
      freeAndNil(rSet);
    end;

end;


procedure TembOccupancyView.TranslateAll;
begin
  grdOccupancy.Cells[0,0] := GetTranslatedText('shUI_Occupancy');
  grdOccupancy.Cells[0,1] := GetTranslatedText('shUI_Availability');
  grdOccupancy.Cells[0,2] := GetTranslatedText('shUI_RevPar');

  if OccupancyViewType = ovtAdvanced then
  begin
    grdOccupancy.Cells[0,3] := GetTranslatedText('shUI_RoomRevenue');
    grdOccupancy.Cells[0,4] := GetTranslatedText('shUI_RoomsSold');
//    grdOccupancy.Cells[0,5] := GetTranslatedText('shUI_BestAverageRate');
    grdOccupancy.Cells[0,5] := GetTranslatedText('shUI_OOO');
    grdOccupancy.Cells[0,6] := GetTranslatedText('shUI_AverageDailyRate');
  end;

end;


function TembOccupancyView.GetOriginalParentHeight: Integer;
begin
  result := FOriginalParentHeight;
end;

procedure TembOccupancyView.grdOccupancyGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol > 0 then
    HAlign := taCenter;
end;

procedure TembOccupancyView.InitEmbededOccupancyView(prnt: TWinControl);
begin
  grdOccupancy.Hide;
  pnlEmbeddable.Parent := prnt;
  grdOccupancy.RowHeights[0] := 25;
  grdOccupancy.RowHeights[1] := grdOccupancy.RowHeights[0];
  grdOccupancy.RowHeights[2] := grdOccupancy.RowHeights[0];

  FOriginalParentHeight := prnt.Height;
  FOccupancyViewType := ovtDefault;
end;

procedure TembOccupancyView.Release;
begin
  grdOccupancy.Hide;
  pnlEmbeddable.Parent := self;
end;

procedure TembOccupancyView.Reset;
begin
  if FOccupancyViewType <> ovtDefault then
    OccupancyViewType := ovtDefault;
end;

end.
