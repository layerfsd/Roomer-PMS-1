unit uColorSelector;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics,uAppGlobal,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  Vcl.StdCtrls, sButton, cmpRoomerDataSet;

type

  TRoomerColor = class
    FId : Integer;
    FValue : integer;
    FDescription : String;
  public
    constructor Create(id, value : Integer; description : String);
  end;

  TfrmColorSelector = class(TForm)
    gridColors: TAdvStringGrid;
    sPanel1: TsPanel;
    btnCancel: TsButton;
    btnOk: TsButton;
    sButton1: TsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridColorsCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
    procedure gridColorsGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure gridColorsDblClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    { Private declarations }
    colors : TList<TRoomerColor>;
    procedure GetColors;
    procedure DisplayColors;
  public
    { Public declarations }
    selectedColorIndex : Integer;
    selectedColorValue : Integer;
    procedure SeekColorId(id : Integer);
  end;

var
  frmColorSelector: TfrmColorSelector;

function OpenColorSelectionDialog(var colorId, colorValue : Integer) : Integer;

implementation

{$R *.dfm}

uses ud, uRoomerLanguage, uDImages;

function OpenColorSelectionDialog(var colorId, colorValue : Integer) : Integer;
begin
  result := mrCancel;
  frmColorSelector := TfrmColorSelector.Create(Application.MainForm);
  try
    frmColorSelector.selectedColorIndex := colorId;
    frmColorSelector.selectedColorValue := colorValue;
    frmColorSelector.ShowModal;
    result := frmColorSelector.modalresult;
    if result = mrOk then
    begin
      colorId := frmColorSelector.selectedColorIndex;
      colorValue := frmColorSelector.selectedColorValue;
    end else
    if result = mrAbort then
    begin
      colorId := -1;
      colorValue := -1;
    end;
  finally
    freeandnil(frmColorSelector);
  end;
end;

procedure TfrmColorSelector.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  colors.Clear;
  freeAndNil(colors);
end;

procedure TfrmColorSelector.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
end;

procedure TfrmColorSelector.FormShow(Sender: TObject);
begin
  GetColors;
  DisplayColors;
end;

procedure TfrmColorSelector.GetColors;
var ASet : TRoomerDataSet;
begin
  colors := TList<TRoomerColor>.Create;
  ASet := d.roomerMainDataSet.ActivateNewDataset(
          d.roomerMainDataSet.SystemFreeQuery('SELECT * FROM colors WHERE Active'));
  ASet.First;
  while NOT ASet.Eof do
  begin
    colors.Add(TRoomerColor.Create(ASet['ID'], StringToColor(ASet['ColorHex']), ASet['Description']));
    ASet.Next;
  end;
end;

procedure TfrmColorSelector.gridColorsCanEditCell(Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := False;
end;

procedure TfrmColorSelector.gridColorsDblClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  if ARow > 0 then
    btnOk.Click;
end;

procedure TfrmColorSelector.gridColorsGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (ACol = 0) AND (ARow > 0) then
    if Assigned(gridColors.Objects[1, ARow]) then
      ABrush.Color := TRoomerColor(gridColors.Objects[1, ARow]).FValue;
end;

procedure TfrmColorSelector.btnOkClick(Sender: TObject);
begin
  if gridColors.Row > 1 then
  begin
    selectedColorIndex := TRoomerColor(gridColors.Objects[1, gridColors.Row]).FId;
    selectedColorValue := TRoomerColor(gridColors.Objects[1, gridColors.Row]).FValue;
  end;
end;

procedure TfrmColorSelector.SeekColorId(id: Integer);
var
  i: Integer;
begin
  if id > 0 then
    for i := 0 to colors.Count - 1 do
      if colors[i].FId = id then
      begin
        gridColors.ScrollInView(1, i + 1);
        gridColors.ActiveCellShow := True;
        gridColors.Row := i + 1;
      end;
end;

procedure TfrmColorSelector.DisplayColors;
var i : Integer;
begin
  gridColors.RowCount := colors.Count + 1;
  for i := 0 to colors.Count - 1 do
  begin
    gridColors.Objects[1, i + 1] := colors[i];
    gridColors.Cells[1, i + 1] := colors[i].FDescription;
  end;
end;



{ TRoomerColor }

constructor TRoomerColor.Create(id, value: Integer; description: String);
begin
  FId := id;
  FValue := value;
  FDescription := description;
end;

end.
