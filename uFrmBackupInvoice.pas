unit uFrmBackupInvoice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uInvoice, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, asgprint,
  System.UITypes, Printers, AdvUtil;

type
  TFrmBackupInvoice = class(TForm)
    sgInvoice: TAdvStringGrid;
    AdvGridPrintSettings: TAdvGridPrintSettingsDialog;
    PrinterSetupDialog: TPrinterSetupDialog;
    procedure FormCreate(Sender: TObject);
    procedure sgInvoiceGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure sgInvoiceGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure sgInvoiceGetCellBorder(Sender: TObject; ARow, ACol: Integer; APen: TPen; var Borders: TCellBorders);
    procedure sgInvoiceGetCellBorderProp(Sender: TObject; ARow, ACol: Integer; LeftPen, TopPen, RightPen, BottomPen: TPen);
    procedure sgInvoiceGetCellPrintBorder(Sender: TObject; ARow, ACol: Integer; APen: TPen; var Borders: TCellBorders);
    procedure sgInvoiceGetCellPrintColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    { Private declarations }
    linesStartRow : Integer;
    linesEndRow : Integer;
    totalsRow : Integer;
    paymentRow : Integer;
    GridInfoReady : Boolean;
    procedure ListInvoiceLines;
    procedure IncrementLineStart;
    procedure IncrementLineEnd;
    procedure PrepareInvoiceHeader;
    procedure ListTotals;
    procedure ListTaxes;
    procedure IncrementGridRows;
    procedure ListPayments;
  public
    { Public declarations }
    frmInvoice : TfrmInvoice;
    TotalPayments : Double;
    stlPaySelections : TStringlist;
    days : Integer;
    proforma : Boolean;

    procedure PrepareInvoice;
    procedure Print;
  end;

var
  FrmBackupInvoice: TFrmBackupInvoice;

procedure PrintBackupInvoice(_frmInvoice : TfrmInvoice;
                             _TotalPayments : Double = 0.00;
                             _stlPaySelections : TStringlist = nil;
                             _days : Integer = 0;
                             _proforma : Boolean = True);

implementation

{$R *.dfm}

uses
      ud
    , PrjConst
    , hData
    , uAppGlobal
    , _Glob
    ;

procedure PrintBackupInvoice(_frmInvoice : TfrmInvoice;
                             _TotalPayments : Double = 0.00;
                             _stlPaySelections : TStringlist = nil;
                             _days : Integer = 0;
                             _proforma : Boolean = True);
var
  _FrmBackupInvoice: TFrmBackupInvoice;
begin
  _FrmBackupInvoice := TFrmBackupInvoice.Create(nil);
  try
    _FrmBackupInvoice.Left := Screen.Width + 100;
    _FrmBackupInvoice.frmInvoice := _frmInvoice;
    _FrmBackupInvoice.TotalPayments := _TotalPayments;
    _FrmBackupInvoice.stlPaySelections := _stlPaySelections;
    _FrmBackupInvoice.days := _days;
    _FrmBackupInvoice.proforma := _proforma;
    _FrmBackupInvoice.PrepareInvoice;
    _FrmBackupInvoice.Show;
    _FrmBackupInvoice.Print;
    _FrmBackupInvoice.Close;
  finally
    FreeAndNil(_FrmBackupInvoice);
  end;
end;

{ TFrmBackupInvoice }

procedure TFrmBackupInvoice.IncrementGridRows;
begin
  sgInvoice.RowCount := sgInvoice.RowCount + 1;
end;

procedure TFrmBackupInvoice.IncrementLineStart;
begin
  inc(linesStartRow);
  sgInvoice.RowCount := linesStartRow + 1;
end;

procedure TFrmBackupInvoice.FormCreate(Sender: TObject);
begin
  GridInfoReady := False;
end;

procedure TFrmBackupInvoice.IncrementLineEnd;
begin
  inc(linesEndRow);
  sgInvoice.RowCount := linesEndRow + 1;
end;

procedure TFrmBackupInvoice.ListInvoiceLines;
var i : Integer;
begin
  for i := 1 to frmInvoice.agrLines.RowCount - 1 do
  begin
    sgInvoice.Cells[0, linesEndRow] := frmInvoice.agrLines.Cells[0, i];
    sgInvoice.Cells[1, linesEndRow] := frmInvoice.agrLines.Cells[1, i];
    sgInvoice.Cells[2, linesEndRow] := frmInvoice.agrLines.Cells[2, i];
    sgInvoice.Cells[3, linesEndRow] := frmInvoice.agrLines.Cells[3, i];
    sgInvoice.Cells[4, linesEndRow] := frmInvoice.agrLines.Cells[4, i];
    IncrementLineEnd;
  end;
end;

procedure TFrmBackupInvoice.PrepareInvoiceHeader;
var
  i: integer;
begin
  // Start header
  linesStartRow := 0;
  sgInvoice.RowCount := linesStartRow + 1;
  sgInvoice.Cells[0, linesStartRow] := frmInvoice.edtName.Text + ' (' + frmInvoice.edtCustomer.Text + ')';
  sgInvoice.Cells[3, linesStartRow] := ctrlGetString('CompanyName'); IncrementLineStart;

  sgInvoice.Cells[0, linesStartRow] := frmInvoice.edtAddress1.Text;
  sgInvoice.Cells[3, linesStartRow] := ctrlGetString('Address1'); IncrementLineStart;

  sgInvoice.Cells[0, linesStartRow] := frmInvoice.edtAddress2.Text;
  sgInvoice.Cells[3, linesStartRow] := ctrlGetString('Address2'); IncrementLineStart;

  sgInvoice.Cells[0, linesStartRow] := frmInvoice.edtAddress3.Text;
  sgInvoice.Cells[3, linesStartRow] := ctrlGetString('Address3'); IncrementLineStart;

  sgInvoice.Cells[0, linesStartRow] := frmInvoice.edtAddress4.Text;
  sgInvoice.Cells[3, linesStartRow] := ctrlGetString('Address4'); IncrementLineStart;

//  sgInvoice.Cells[0, linesStartRow] := frmInvoice.edt.Text;
  sgInvoice.Cells[3, linesStartRow] := ctrlGetString('Country'); IncrementLineStart;

  for i := 0 to linesStartRow do
  begin
    sgInvoice.MergeCells(0, i, 2, 1);
    sgInvoice.MergeCells(3, i, 2, 1);
  end;
  sgInvoice.Cells[0, linesStartRow] := StringOfChar('_', 2000);
  sgInvoice.MergeCells(0, linesStartRow, 5, 1); IncrementLineStart;

end;

procedure TFrmBackupInvoice.Print;
begin
  sgInvoice.PrintSettings.FitToPage := fpAlways;
  sgInvoice.PrintSettings.Orientation := poPortrait; // poLandscape; // initialize to default poLandscape
//  if AdvGridPrintSettings.Execute then
//  begin
    Printer.Orientation := sgInvoice.PrintSettings.Orientation;
    if PrinterSetupDialog.Execute then
    begin
      sgInvoice.PrintSettings.Orientation := Printer.Orientation;
      sgInvoice.Print;
    end;
//  end;
end;

procedure TFrmBackupInvoice.sgInvoiceGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ARow >= linesStartRow-1) AND
     (ACol IN [2, 3, 4]) then
       HAlign := taRightJustify;
end;

procedure TFrmBackupInvoice.sgInvoiceGetCellBorder(Sender: TObject; ARow, ACol: Integer; APen: TPen; var Borders: TCellBorders);
begin
  Borders := [];
  APen.Color := sgInvoice.Color;
  APen.Width := 0;
end;

procedure TFrmBackupInvoice.sgInvoiceGetCellBorderProp(Sender: TObject; ARow, ACol: Integer; LeftPen, TopPen, RightPen, BottomPen: TPen);
begin
  LeftPen.Color := sgInvoice.Color;
  LeftPen.Width := 0;
  TopPen.Color := sgInvoice.Color;
  TopPen.Width := 0;
  RightPen.Color := sgInvoice.Color;
  RightPen.Width := 0;
  BottomPen.Color := sgInvoice.Color;
  BottomPen.Width := 0;
end;

procedure TFrmBackupInvoice.sgInvoiceGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (ARow >= linesStartRow) AND
     (ACol >= 4) then
        AFont.Style := [fsBold];

end;

procedure TFrmBackupInvoice.sgInvoiceGetCellPrintBorder(Sender: TObject; ARow, ACol: Integer; APen: TPen; var Borders: TCellBorders);
begin
  APen.Width := 0;
  APen.Color := clWhite;
  Borders := [];
end;

procedure TFrmBackupInvoice.sgInvoiceGetCellPrintColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  ABrush.Color := clWhite;
  if ARow = linesStartRow-1 then
    AFont.Style := [fsBold, fsUnderline];
end;

procedure TFrmBackupInvoice.ListTotals;
begin
  IncrementGridRows;
  sgInvoice.Cells[0, sgInvoice.RowCount - 1] := StringOfChar('_', 2000);
  sgInvoice.MergeCells(0, sgInvoice.RowCount - 1, 5, 1);

  totalsRow := sgInvoice.RowCount;
  IncrementGridRows;
  sgInvoice.Cells[3, totalsRow] := frmInvoice.clabTotalwoVAT.Caption;
  sgInvoice.Cells[4, totalsRow] := frmInvoice.edtTotal.Text;
  IncrementGridRows;

  sgInvoice.Cells[3, totalsRow + 1] := frmInvoice.clavVAT.Caption;
  sgInvoice.Cells[4, totalsRow + 1] := frmInvoice.edtVat.Text;
  IncrementGridRows;

  sgInvoice.Cells[3, totalsRow + 2] := frmInvoice.clabInvoiceTotal.Caption;
  sgInvoice.Cells[4, totalsRow + 2] := frmInvoice.edtInvoiceTotal.Text;
  IncrementGridRows;

  sgInvoice.Cells[3, totalsRow + 3] := frmInvoice.clabDownpayments.Caption;
  sgInvoice.Cells[4, totalsRow + 3] := frmInvoice.edtDownPayments.Text;
  IncrementGridRows;

  sgInvoice.Cells[3, totalsRow + 4] := frmInvoice.clabBalance.Caption;
  sgInvoice.Cells[4, totalsRow + 4] := frmInvoice.edtBalance.Text;
  IncrementGridRows;
end;

procedure TFrmBackupInvoice.ListTaxes;
begin

end;

procedure TFrmBackupInvoice.ListPayments;
var
  i: integer;
  pmCode, pmDesc: string;
  pmLine : Integer;
  pmAmount: Double;

begin
  if NOT Proforma then
  begin
    paymentRow := sgInvoice.RowCount;
    pmLine := paymentRow;
    IncrementGridRows;
    sgInvoice.Cells[2, paymentRow] := 'Payments';
    IncrementGridRows;
    for i := 0 to stlPaySelections.Count - 1 do
    begin
      pmCode := trim(_strTokenAt(stlPaySelections[i], '|', 0));
      try
        pmAmount := _strToFloat(trim(_strTokenAt(stlPaySelections[i], '|', 1)));
      except
        pmAmount := 0;
      end;

      inc(pmLine);
      if glb.LocateSpecificRecordAndGetValue('paytypes', 'PayType', pmCode, 'Description', pmDesc) then
         sgInvoice.Cells[2, pmLine] := pmDesc
      else
         sgInvoice.Cells[2, pmLine] := pmCode;
      sgInvoice.Cells[3, pmLine] := trim(_FloatToStr(pmAmount, 9, 2));
      IncrementGridRows;
    end;
  end;
end;


procedure TFrmBackupInvoice.PrepareInvoice;
begin
  sgInvoice.ClearAll;
  sgInvoice.ColCount := 5;
  sgInvoice.ColWidths[0] := 150;
  sgInvoice.ColWidths[1] := 300;
  sgInvoice.ColWidths[2] := 100;
  sgInvoice.ColWidths[3] := 100;
  sgInvoice.ColWidths[4] := 100;

  PrepareInvoiceHeader;

  // Start Lines
  sgInvoice.Cells[0, linesStartRow] := frmInvoice.agrLines.Cells[0,0]; // 'Item';
  sgInvoice.Cells[1, linesStartRow] := frmInvoice.agrLines.Cells[1,0]; // 'Text';
  sgInvoice.Cells[2, linesStartRow] := frmInvoice.agrLines.Cells[2,0]; // 'Number';
  sgInvoice.Cells[3, linesStartRow] := frmInvoice.agrLines.Cells[3,0]; // 'Unit Price';
  sgInvoice.Cells[4, linesStartRow] := frmInvoice.agrLines.Cells[4,0]; // 'Total';

  IncrementLineStart;
  linesEndRow := linesStartRow;

  ListInvoiceLines;

  ListTotals;
  ListTaxes;

  ListPayments;

  GridInfoReady := True;
  sgInvoice.Invalidate;
end;

end.
