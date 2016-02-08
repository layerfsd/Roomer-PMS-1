unit u2DMatrix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, Vcl.ExtCtrls,
  sPanel,
  Generics.Collections, cmpRoomerDataSet, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  cxClasses, cxPropertiesStore, sComboBox, AdvUtil;

type

  TMatrixType = (mtPaymentAssurance, mtConfirmationEmail, mtHotelEmail);

  TMatrix = class
    XValue, XText, YValue, YText: String;

    RValue: Integer;
    OrigValue: Integer;

    Row, Col: Integer;
  public
    constructor Create(_XValue, _XText, _YValue, _YText: String;
      _RValue: Integer);
    function changed: Boolean;

  end;

  TMatrixList = TObjectList<TMatrix>;

  Tfrm2DMatrix = class(TForm)
    panBtn: TsPanel;
    sPanel1: TsPanel;
    BtnOk: TsButton;
    grdMatrix: TAdvStringGrid;
    pnlHeader: TsPanel;
    sPanel3: TsPanel;
    cbxSelection: TsComboBox;
    StoreMain: TcxPropertiesStore;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMatrixCheckBoxChange(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure grdMatrixCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure grdMatrixGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormDestroy(Sender: TObject);
  private
    matrix: TMatrixList;
    function CountColumns: Integer;
    procedure PrepareGrid;
    function CountRows: Integer;
    function FindInMatrix(ACol, ARow: Integer): Integer;
    procedure PaymentsComboboxSelectionChange(Sender: TObject);
    procedure ReadPaymentAssuranceMatrix(channelManagerCode: String);
    procedure ReadChannelConfirmationEmailMatrix;
    procedure ReadChannelHotelEmailMatrix;
    { Private declarations }
  public
    { Public declarations }
    MatrixType : TMatrixType;
    colNames: TStrings;
    rowNames: TStrings;
    procedure AddItems(const aItems: TStrings);
  end;


procedure EditPaymentAssuranceForChannels;
procedure EditChannelsEmailConfirmationMatrix;
procedure EditChannelsHotelEmailMatrix;

implementation

{$R *.dfm}

uses ud, RoomerCloudEntities;

procedure EditPaymentAssuranceForChannels;
var
  i: Integer;
  selection: TStrings;
  channelManagers: Array_Of_TChannelmanagersEntity;
  frm2DMatrix: Tfrm2DMatrix;
begin
  selection := TStringList.Create;
  channelManagers := d.roomerMainDataSet.Channelmanagers_Entities_FindAll;
  for i := Low(channelManagers) to High(channelManagers) do
    if channelManagers[i].active <> 0 then
      selection.Add(channelManagers[i].code);

  frm2DMatrix := Tfrm2DMatrix.Create(nil);
  try
    frm2DMatrix.cbxSelection.Items.Clear;
    frm2DMatrix.AddItems(selection);
    frm2DMatrix.pnlHeader.Caption := '  Channel Payment Assurance Matrix';
    frm2DMatrix.cbxSelection.OnChange :=
      frm2DMatrix.PaymentsComboboxSelectionChange;
    frm2DMatrix.MatrixType := mtPaymentAssurance;
    frm2DMatrix.ShowModal;
  finally
    FreeAndNil(frm2DMatrix);
    Selection.Free;
  end;
end;

procedure EditChannelsEmailConfirmationMatrix;
var
  selection: TStrings;
  frm2DMatrix: Tfrm2DMatrix;
begin
  selection := TStringList.Create;
  frm2DMatrix := Tfrm2DMatrix.Create(nil);
  try
    frm2DMatrix.cbxSelection.Visible := False; // .Items.Clear;
    frm2DMatrix.AddItems(selection);
    frm2DMatrix.pnlHeader.Caption := '  Confirmation Email Matrix';
    frm2DMatrix.MatrixType := mtConfirmationEmail;
    frm2DMatrix.ReadChannelConfirmationEmailMatrix;
    frm2DMatrix.ShowModal;
  finally
    FreeAndNil(frm2DMatrix);
    Selection.Free;
  end;
end;

procedure EditChannelsHotelEmailMatrix;
var
  selection: TStrings;
  frm2DMatrix: Tfrm2DMatrix;
begin
  selection := TStringList.Create;
  frm2DMatrix := Tfrm2DMatrix.Create(nil);
  try
    frm2DMatrix.cbxSelection.Visible := False; // .Items.Clear;
    frm2DMatrix.AddItems(Selection);
    frm2DMatrix.pnlHeader.Caption := '  Hotel Notification Email Matrix';
    frm2DMatrix.MatrixType := mtHotelEmail;
    frm2DMatrix.ReadChannelHotelEmailMatrix;
    frm2DMatrix.ShowModal;
  finally
    FreeAndNil(frm2DMatrix);
    Selection.Free;
  end;
end;


{ TMatrix }

function TMatrix.changed: Boolean;
begin
  result := RValue <> OrigValue;
end;

constructor TMatrix.Create(_XValue, _XText, _YValue, _YText: String;
  _RValue: Integer);
begin
  inherited Create;
  XValue := _XValue;
  XText := _XText;
  YValue := _YValue;
  YText := _YText;

  RValue := _RValue;
  OrigValue := _RValue;
end;

procedure Tfrm2DMatrix.FormCreate(Sender: TObject);
begin
  colNames := TStringList.Create;
  rowNames := TStringList.Create;
  Matrix := TMatrixList.Create(True);
end;

procedure Tfrm2DMatrix.FormDestroy(Sender: TObject);
begin
 Matrix.Free;
 colNames.Free;
 rowNames.Free;
end;

procedure Tfrm2DMatrix.FormShow(Sender: TObject);
begin
  if cbxSelection.Items.Count > 0 then
  begin
    cbxSelection.ItemIndex := 0;
    PaymentsComboboxSelectionChange(cbxSelection);
  end;
end;

procedure Tfrm2DMatrix.grdMatrixCanEditCell(Sender: TObject;
  ARow, ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := (ARow > 0) AND (ACol > 0);
end;

procedure Tfrm2DMatrix.grdMatrixCheckBoxChange(Sender: TObject;
  ACol, ARow: Integer; State: Boolean);
var
  cbState: Boolean;
  idx: Integer;
begin
  grdMatrix.GetCheckBoxState(ACol, ARow, cbState);
  idx := FindInMatrix(ACol, ARow);
  if idx >= 0 then
  begin
    if cbState then
      matrix[idx].RValue := 1
    else
      matrix[idx].RValue := 0;
    if matrix[idx].changed then
    begin
      if MatrixType = mtPaymentAssurance then
        d.roomerMainDataSet.SystemupdatePaymentAssuranceMatrixItem
          (cbxSelection.Items[cbxSelection.ItemIndex], matrix[idx].XValue,
          matrix[idx].YValue, matrix[idx].RValue)
      else
      if MatrixType = mtConfirmationEmail then
        d.roomerMainDataSet.SystemUpdateConfirmationEmailMatrix
          (matrix[idx].YValue,
           matrix[idx].XValue,
           matrix[idx].RValue)
      else
      if MatrixType = mtHotelEmail then
        d.roomerMainDataSet.SystemUpdateHotelEmailMatrix
          (matrix[idx].YValue,
           matrix[idx].XValue,
           matrix[idx].RValue);

      matrix[idx].OrigValue := matrix[idx].RValue;
    end;
  end;
end;

procedure Tfrm2DMatrix.grdMatrixGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol > 0) then
    HAlign := taCenter;
end;

function Tfrm2DMatrix.FindInMatrix(ACol, ARow: Integer): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to matrix.Count - 1 do
    if (matrix[i].Col = ACol) AND (matrix[i].Row = ARow) then
    begin
      result := i;
      break;
    end;
end;

procedure Tfrm2DMatrix.PrepareGrid;
var
  i, c, r: Integer;
begin
  grdMatrix.ColCount := CountColumns + 1;
  grdMatrix.RowCount := CountRows + 1;

  for i := 0 to matrix.Count - 1 do
  begin
    c := colNames.IndexOf(matrix[i].XValue) + 1;
    r := rowNames.IndexOf(matrix[i].YValue) + 1;
    if grdMatrix.Cells[c, 0] = '' then
      grdMatrix.Cells[c, 0] := matrix[i].XText;
    if grdMatrix.Cells[0, r] = '' then
      grdMatrix.Cells[0, r] := matrix[i].YText;
    grdMatrix.AddCheckBox(c, r, matrix[i].RValue = 1, False);
    matrix[i].Col := c;
    matrix[i].Row := r;
  end;
  grdMatrix.AutoSizeColumns(True);
end;

procedure Tfrm2DMatrix.ReadPaymentAssuranceMatrix(channelManagerCode: String);
var
  res: TRoomerDataset;
  i: Integer;
begin
  matrix.Clear;
  grdMatrix.ClearAll;
  res := d.roomerMainDataSet.ActivateNewDataset
    (d.roomerMainDataSet.SystemGetPaymentAssuranceMatrix(channelManagerCode));
  res.First;
  while not res.Eof do
  begin
    matrix.Add(TMatrix.Create(res['CHANNEL_ID'], res['CHANNEL_NAME'],
      res['ROOM_TYPE_CODE'], res['ROOM_TYPE_NAME'], res['Value']));
    res.Next;
  end;
  colNames.Clear;
  rowNames.Clear;
  PrepareGrid;
end;

procedure Tfrm2DMatrix.ReadChannelConfirmationEmailMatrix;
var
  res: TRoomerDataset;
  i: Integer;
begin
  matrix.Clear;
  grdMatrix.ClearAll;
  res := d.roomerMainDataSet.ActivateNewDataset(d.roomerMainDataSet.SystemGetConfirmationEmailMatrix);
  res.First;
  while not res.Eof do
  begin
    matrix.Add(TMatrix.Create(res['CHANNEL_ID'], res['CHANNEL_NAME'],
      res['CHANNEL_MANAGER_ID'], res['CHANNEL_MANAGER_NAME'], res['Value']));
    res.Next;
  end;
  colNames.Clear;
  rowNames.Clear;
  PrepareGrid;
end;

procedure Tfrm2DMatrix.ReadChannelHotelEmailMatrix;
var
  res: TRoomerDataset;
  i: Integer;
begin
  matrix.Clear;
  grdMatrix.ClearAll;
  res := d.roomerMainDataSet.ActivateNewDataset(d.roomerMainDataSet.SystemGetHotelEmailMatrix);
  res.First;
  while not res.Eof do
  begin
    matrix.Add(TMatrix.Create(res['CHANNEL_ID'], res['CHANNEL_NAME'],
      res['CHANNEL_MANAGER_ID'], res['CHANNEL_MANAGER_NAME'], res['Value']));
    res.Next;
  end;
  colNames.Clear;
  rowNames.Clear;
  PrepareGrid;
end;

procedure Tfrm2DMatrix.PaymentsComboboxSelectionChange(Sender: TObject);
begin
  ReadPaymentAssuranceMatrix(cbxSelection.Items[cbxSelection.ItemIndex]);
end;

procedure Tfrm2DMatrix.AddItems(const aItems: TStrings);
begin
  cbxSelection.Items.AddStrings(aItems);
end;

function Tfrm2DMatrix.CountColumns: Integer;
var
  i: Integer;
  sLast: String;
begin
  sLast := '----------:-)------------';
  for i := 0 to matrix.Count - 1 do
    if colNames.IndexOf(matrix[i].XValue) = -1 then
      colNames.Add(matrix[i].XValue);
  result := colNames.Count;
end;

function Tfrm2DMatrix.CountRows: Integer;
var
  i: Integer;
  sLast: String;
begin
  sLast := '----------:-)------------';
  for i := 0 to matrix.Count - 1 do
    if rowNames.IndexOf(matrix[i].YValue) = -1 then
    begin
      rowNames.Add(matrix[i].YValue);
      sLast := matrix[i].YValue;
    end;
  result := rowNames.Count;
end;

end.
