unit uFrmPostInvoices;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, sEdit, sLabel, Vcl.ExtCtrls, sPanel, DB;

type
  TFrmPostInvoices = class(TForm)
    sLabel1: TsLabel;
    edtFrom: TsEdit;
    sLabel2: TsLabel;
    edtTo: TsEdit;
    btnProcess: TsButton;
    pnlProcess: TsPanel;
    sLabel3: TsLabel;
    lblInvoice: TsLabel;
    dlgSave: TSaveDialog;
    sLabel4: TsLabel;
    edtInvoiceList: TsEdit;
    procedure btnProcessClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    exportFileTemplate : String;
    procedure Process;
    function GetExportTemplate: String;
    procedure ExportToCSV;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPostInvoices: TFrmPostInvoices;

procedure PostInvoicesToBookKeepingSystem(invoiceList : String);

implementation

{$R *.dfm}

uses ud
    , hData
    , cmpRoomerDataSet
    , uFrmHandleBookKeepingException
    , uRoomerLanguage
    , uAppGlobal
    , uRptBookKeeping
    , uFrmResources
    , uUtils
    , uFileSystemUtils
    , uResourceManagement
    ;

procedure PostInvoicesToBookKeepingSystem(invoiceList : String);
var
  _FrmPostInvoices: TFrmPostInvoices;
begin
  _FrmPostInvoices := TFrmPostInvoices.Create(nil);
  try
    _FrmPostInvoices.edtInvoiceList.Text := invoiceList;
    _FrmPostInvoices.ShowModal;
  finally
    FreeAndNil(_FrmPostInvoices);
  end;
end;

procedure TFrmPostInvoices.btnProcessClick(Sender: TObject);
begin
  edtFrom.Enabled := False;
  edtTo.Enabled := False;
  btnProcess.Enabled := False;
  pnlProcess.Visible := True;
  edtInvoiceList.Enabled := False;

  screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  try
    if exportFileTemplate = '' then
      Process
    else
      ExportToCsv;
  finally
    screen.Cursor := crDefault;
    Application.ProcessMessages;
  end;

  Close;
end;


const FINANCE_QUERY = 'SELECT 1 AS OrderCol, itemNumber, cu.Customer AS CustomerId, cu.PID, cu.Surname AS CustomerName, il.InvoiceNumber AS InvoiceNumber, ' +
                      '       DATE(ih.InvoiceDate) AS InvoiceDate, bc.Code AS AccountNumber, bc.description AS TransactionDescription, ' +
                      '       ROUND(il.TotalWOVat * IF(bc.txStatus=''DEBET'', 1, -1), 2) AS TotalExclusive, bc.txStatus AS SalesTransactionType, bc.bookOnCustomer AS BookOnCustomer, il.ItemID, il.Description AS Text ' +
                      ' ' +
                      'FROM invoicelines il ' +
                      'INNER JOIN currencies c ON c.Currency=il.Currency ' +
                      'INNER JOIN invoiceheads ih ON ih.InvoiceNumber=il.InvoiceNumber ' +
                      'INNER JOIN customers cu ON cu.Customer=ih.Customer ' +
                      'INNER JOIN items it ON it.Item=il.ItemId ' +
                      'INNER JOIN bookkeepingcodes bc ON bc.Code=it.BookKeepCode ' +
                      'INNER JOIN vatcodes vc ON vc.VATCode=il.VATType ' +
                      ' ' +
                      'WHERE ih.InvoiceNumber IN (%s) ' +
                      ' ' +
//                      'GROUP BY il.InvoiceNumber, bc.Code ' +
                      ' ' +
                      'UNION ' +
                      ' ' +
                      'SELECT 1 AS OrderCol, itemNumber, cu.Customer, cu.PID, cu.Surname, il.InvoiceNumber, ' +
                      '       DATE(ih.InvoiceDate) AS ADate1, bc.Code, bc.description, ' +
                      '       ROUND(il.Vat * IF(bc.txStatus=''DEBET'', 1, -1), 2) AS AAmount1, bc.txStatus, bc.bookOnCustomer, il.ItemID, il.Description AS Text ' +
                      ' ' +
                      'FROM invoicelines il ' +
                      'INNER JOIN currencies c ON c.Currency=il.Currency ' +
                      'INNER JOIN invoiceheads ih ON ih.InvoiceNumber=il.InvoiceNumber ' +
                      'INNER JOIN customers cu ON cu.Customer=ih.Customer ' +
                      'INNER JOIN items it ON it.Item=il.ItemId ' +
                      'INNER JOIN vatcodes vc ON vc.VATCode=il.VATType ' +
                      'INNER JOIN bookkeepingcodes bc ON bc.Code=vc.BookKeepCode ' +
                      ' ' +
                      'WHERE ih.InvoiceNumber IN (%s) ' +
                      ' ' +
//                      'GROUP BY il.InvoiceNumber, bc.Code ' +
                      ' ' +
                      'UNION ' +
                      ' ' +
                      'SELECT 0 AS OrderCol, 0 AS itemNumber, cu.Customer, cu.PID, cu.Surname, pa.InvoiceNumber, ' +
                      '       DATE(pa.PayDate) AS ADate1, bc.Code, bc.description, ' +
//                      '       ROUND(SUM(Amount * IF(bc.txStatus=''DEBET'', 1, -1)), 2) AS AAmount1, bc.txStatus, bc.bookOnCustomer, pa.PayType, pa.Description AS Text ' +
                      '       ROUND(Amount * IF(bc.txStatus=''DEBET'', 1, -1), 2) AS AAmount1, bc.txStatus, bc.bookOnCustomer, pa.PayType, cu.Surname AS Text ' +
                      ' ' +
                      'FROM payments pa ' +
                      'INNER JOIN currencies c ON c.Currency=pa.Currency ' +
                      'INNER JOIN invoiceheads ih ON ih.InvoiceNumber=pa.InvoiceNumber ' +
                      'INNER JOIN customers cu ON cu.Customer=ih.Customer ' +
                      'INNER JOIN paytypes pt ON pt.PayType=pa.PayType ' +
                      'INNER JOIN bookkeepingcodes bc ON bc.Code=pt.BookKeepCode ' +
                      ' ' +
                      'WHERE ih.InvoiceNumber IN (%s) ' +
                      ' ' +
                      'GROUP BY pa.InvoiceNumber, bc.Code ' +
                      'ORDER BY InvoiceNumber, OrderCol, itemNumber ' +
                      '';

procedure TFrmPostInvoices.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  exportFileTemplate := GetExportTemplate;
end;

procedure TFrmPostInvoices.FormShow(Sender: TObject);
begin
  sLabel4.Visible := edtInvoiceList.Text <> '';
  edtInvoiceList.Visible := edtInvoiceList.Text <> '';

  sLabel1.Visible := edtInvoiceList.Text = '';
  sLabel2.Visible := edtInvoiceList.Text = '';
  edtFrom.Visible := edtInvoiceList.Text = '';
  edtTo.Visible := edtInvoiceList.Text = '';
end;

function formatValue(value : Variant; dataType : TFieldType; theFormat : String) : String;
var intValue : Integer;
    floatValue : Double;
    dateValue : TDateTime;
begin
  result := value;
  if TRIM(theFormat) <> '' then
    case dataType of
      ftUnknown,
      ftFixedWideChar,
      ftWideMemo,
      ftMemo,
      ftFmtMemo,
      ftFixedChar,
      ftWideString,
      ftString: begin
                  result := value;
                  if copy(theFormat, 1, 1)='m' then
                  begin
                    result := copy(value, 1, strtoint(copy(theFormat, 2, 5)));
                  end;
                end;

      ftLongWord,
      ftShortint,
      ftByte,
      ftExtended,
      ftSingle,
      ftAutoInc,
      ftSmallint,
      ftLargeint,
      ftInteger,
      ftWord:   begin
                  result := value;
                  intValue := value;
                  if copy(theFormat, 1, 1)='x' then // Multiply and round
                  begin
                    result := inttostr(round(intValue * strtoint(copy(theFormat, 2, 5))));
                  end else
                  begin
                    result := format(theFormat, [intValue]);
                  end;
                end;
      ftBoolean: ;
      ftCurrency,
      ftBCD,
      ftFloat:  begin
                  result := value;
                  floatValue := value;
                  if copy(theFormat, 1, 1)='x' then // Multiply and round
                  begin
                    result := inttostr(round(floatValue * strtoint(copy(theFormat, 2, 5))));
                  end else
                  begin
                    result := format(theFormat, [floatValue]);
                  end;
                end;
      ftTimeStamp,
      ftDate,
      ftTime,
      ftDateTime: begin
                    dateValue := value;
                    result := FormatDateTime(theFormat, dateValue);
                  end;
      ftBytes: ;
      ftVarBytes: ;
      ftBlob: ;
      ftGraphic: ;
      ftParadoxOle: ;
      ftDBaseOle: ;
      ftTypedBinary: ;
      ftCursor: ;
      ftADT: ;
      ftArray: ;
      ftReference: ;
      ftDataSet: ;
      ftOraBlob: ;
      ftOraClob: ;
      ftVariant: ;
      ftInterface: ;
      ftIDispatch: ;
      ftGuid: ;
      ftFMTBcd: ;
      ftOraTimeStamp: ;
      ftOraInterval: ;
      ftConnection: ;
      ftParams: ;
      ftStream: ;
      ftTimeStampOffset: ;
      ftObject: ;
    end;
end;

procedure TFrmPostInvoices.ExportToCSV;
var lines, fld : TStringList;
    line, SubjectTemplate, newLine : String;
    i : Integer;

    HeadersLine, Header, FldName, Value, AFormat : String;

    rSet : TRoomerDataSet;
    sql : String;
    field : TField;
    CurrValue : String;

    filename : String;

    function getValue(FldName : String) : Variant;
    var i : Integer;
        s : String;
        flds : TStringList;
        field : TField;
    begin
      result := '';
      s := copy(FldName, 2, length(FldName) - 2);
      flds := Split(s, ';');
      try
        for i := 0 to flds.Count - 1 do
        begin
          field := rSet.FindField(flds[i]);
          if NOT Assigned(field) then
            result := result + flds[i]
          else
            result := result + rSet[flds[i]]
        end;
      finally
        flds.Free;
      end;
    end;

var firstRound : Boolean;
    s : String;
    RoomerResourceManagement : TRoomerResourceManagement;
begin
  if dlgSave.Execute then
  begin
    if edtInvoiceList.Text = '' then
    begin
      s := '';
      for i := StrToIntDef(edtFrom.Text, 0) to StrToIntDef(edtTo.Text, 0) do
        if s = '' then
          s := inttostr(i)
        else
          s := s + ',' + inttostr(i);
        edtInvoiceList.Text := s;
    end;

    filename := dlgSave.FileName;

    sql := format(FINANCE_QUERY, [
                  edtInvoiceList.Text,
                  edtInvoiceList.Text,
                  edtInvoiceList.Text
                  ]);
    rSet := CreateNewDataSet;
    rSet_bySQL(rSet, sql);
    rSet.First;
    if not rSet.Eof then
    begin
      lines := TStringList.Create;
      try
        RoomerResourceManagement := TRoomerResourceManagement.Create(ANY_FILE, ACCESS_RESTRICTED);
        try
          exportFileTemplate := RoomerResourceManagement.DownloadResourceByName(exportFileTemplate, SubjectTemplate);
        finally
          RoomerResourceManagement.Free;
        end;
        lines.LoadFromFile(exportFileTemplate);
        line := lines[0];
      finally
        lines.free;
      end;

      lines := Split(line, '|');
      firstRound := True;
      try
        while NOT rSet.Eof do
        begin
          newLine := '';
          if firstRound then
            HeadersLine := '';
          for i := 0 to lines.Count - 1 do
          begin
            fld := Split(lines[i], ',');
            Value := '';
            AFormat := '';
            Header := fld[0];
            FldName := fld[1];
            if fld.Count > 2 then
              Value := fld[2];
            if fld.Count > 3 then
              AFormat := fld[3];

            field := rSet.FindField(fldName);
            if NOT Assigned(field) then
            begin
              if copy(fldName, 1, 1) = '{' then
                CurrValue := formatValue(getValue(FldName), ftString, AFormat)
              else
                CurrValue := Value;
            end else
              CurrValue := formatValue(field.Value, field.DataType, AFormat);
            if newLine = '' then
              newLine := CurrValue
            else
              newLine := newLine + ';' + CurrValue;

            if firstRound then
            begin
              if HeadersLine = '' then
                HeadersLine := HeadersLine + Header
              else
                HeadersLine := HeadersLine + ';' + Header;
            end;
          end;
          if firstRound AND ((NOT FileExists(filename)) OR (GetFileSize(filename) < 10)) then
              AddToTextFile(filename, HeadersLine);
          firstRound := False;
          AddToTextFile(filename, newLine);
          rSet.Next;
        end;
      finally
        lines.free;
      end;
    end;
  end;
end;

function TFrmPostInvoices.GetExportTemplate : String;
var rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  rSet_bySQL(rSet, 'SELECT InvoiceExportFilename FROM hotelconfigurations LIMIT 1');
  rSet.First;
  if NOT rSet.Eof then
  begin
    result := rSet['InvoiceExportFilename'];

  end else
    result := '';
end;

procedure TFrmPostInvoices.Process;
var rSet : TRoomerDataSet;
    remoteResult : String;
    invNumber : Integer;
begin
  rSet := CreateNewDataSet;
  rSet_bySQL(rSet, format('SELECT * FROM invoiceheads WHERE InvoiceNumber >= %s AND InvoiceNumber <= %s', [edtFrom.Text, edtTo.Text]));
  rSet.First;
  while NOT rSet.Eof do
  begin
    invNumber := rSet['InvoiceNumber'];
    lblInvoice.Caption := 'Invoice ' + inttostr(invNumber);
    Application.processmessages;

    remoteResult := d.roomerMainDataSet.SystemSendInvoiceToBookkeeping(invNumber);
    if remoteResult <> '' then
    begin
      HandleFinanceBookKeepingExceptions(invNumber, remoteResult);
    end;
    rSet.Next;
  end;
  lblInvoice.Caption := 'FINISHED!';
  Application.processmessages;
  Close;
end;

end.
