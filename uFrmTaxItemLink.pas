unit uFrmTaxItemLink;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, sPanel, sSplitter,
  sLabel, Vcl.Grids, Vcl.DBGrids, cmpRoomerDataSet, uD, Data.DB, hData, uG, Vcl.ComCtrls, AdvListV, DBAdvLst, Data.Win.ADODB;

type
  TFrmTaxItemLink = class(TForm)
    Panel1: TsPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    grLinkFrom: TDBGrid;
    lblHeader: TsLabel;
    sSplitter1: TsSplitter;
    sPanel3: TsPanel;
    dsFrom: TDataSource;
    dsTo: TDataSource;
    ADODataSet1: TADODataSet;
    sPanel4: TsPanel;
    lvSelect: TDBAdvListView;
    sPanel5: TsPanel;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FromAfterScroll(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    LinkTableSql,
    FromTableSql,
    ToTableSql : String;


    LinkFromTable, LinkFromFields, LinkFromLinkField : String;
    LinkToTable, LinkToFields, LinkToLinkField : String;
    LinkTable, LinkFromField, LinkToField : String;

    FromTable : TRoomerDataSet;
    ToTable : TRoomerDataSet;
    LinkageTable : TRoomerDataSet;
    function CheckIfSelected(FromDataSet, ToDataSet: TDataSet): Boolean;
    function GetTableInfo(sql: String): TRoomerDataSet;
  public
    { Public declarations }
  end;

var
  FrmTaxItemLink: TFrmTaxItemLink;

procedure LinkTables(LinkFromTable, LinkFromFields, LinkFromLinkField : String;
                     LinkToTable, LinkToFields, LinkToLinkField : String;
                     LinkTable, LinkFromField, LinkToField : String);

implementation

{$R *.dfm}

uses
   uStringUtils
   ;

resourcestring
  SELECT_FROM_LINK_TABLE = 'SELECT id AS _linkField, %s, %s FROM %s WHERE HO' +
  'TEL_ID=''%s'' AND NOT ISNULL(ITEM_ID) AND NOT ISNULL(TAX_ID)';
  SELECT_FROM_FROMTABLE = 'SELECT %s AS _linkField, %s FROM %s';
  SELECT_FROM_TOTABLE = 'SELECT %s AS _linkField, %s FROM %s WHERE HOTEL_ID=' +
  '''%s''';

procedure LinkTables(LinkFromTable, LinkFromFields, LinkFromLinkField : String;
                     LinkToTable, LinkToFields, LinkToLinkField : String;
                     LinkTable, LinkFromField, LinkToField : String);
begin
  FrmTaxItemLink := TFrmTaxItemLink.Create(nil);
  try
    FrmTaxItemLink.LinkFromTable := LinkFromTable;
    FrmTaxItemLink.LinkFromFields := LinkFromFields;
    FrmTaxItemLink.LinkFromLinkField :=LinkFromLinkField;

    FrmTaxItemLink.LinkToTable := LinkToTable;
    FrmTaxItemLink.LinkToFields := LinkToFields;
    FrmTaxItemLink.LinkToLinkField := LinkToLinkField;

    FrmTaxItemLink.LinkTable := LinkTable;
    FrmTaxItemLink.LinkFromField := LinkFromField;
    FrmTaxItemLink.LinkToField := LinkToField;

    FrmTaxItemLink.ShowModal;
  finally
    FreeAndNil(FrmTaxItemLink);
  end;
end;

procedure TFrmTaxItemLink.FromAfterScroll(DataSet: TDataSet);
var i : Integer;
begin
  for i := 0 to lvSelect.Items.Count - 1 do
    lvSelect.Items[i].Checked := False;
  ToTable.First;
  for i := 0 to lvSelect.Items.Count - 1 do
  begin
    lvSelect.Items[i].Checked := CheckIfSelected(DataSet, ToTable);
    ToTable.Next;
  end;
end;

function TFrmTaxItemLink.CheckIfSelected(FromDataSet: TDataSet; ToDataSet: TDataSet) : Boolean;
begin
  result := False;
  LinkageTable.First;
  while (NOT LinkageTable.Eof) do // AND (NOT LinkageTable.Bof) do
  begin
    if (LinkageTable[LinkFromField] = FromDataSet['_linkField']) AND (LinkageTable[LinkToField] = ToDataSet['_linkField']) then
    begin
      result := True;
      Break;
    end;
    LinkageTable.Next;
  end;
end;

procedure TFrmTaxItemLink.BitBtn1Click(Sender: TObject);
var i : Integer;
    plan : TRoomerExecutionPlan;
    savedLocation : TListItem;
begin
  lvSelect.BeginUpdate;
  savedLocation := lvSelect.Selected;
  try
    plan := d.roomerMainDataSet.CreateExecutionPlan;
    plan.AddExec(format('DELETE FROM %s WHERE %s=%s AND HOTEL_ID=''%s''', [LinkTable, LinkFromField, FromTable['_linkField'], d.roomerMainDataSet.hotelId]));
    ToTable.First;
    for i := 0 to lvSelect.Items.Count - 1 do
    begin
      if lvSelect.Items[i].Checked then
      begin
        // lvSelect.Selected := lvSelect.Items[i];
//        ToTable.RecNo := i;
        plan.AddExec(format('INSERT INTO %s (%s,%s,HOTEL_ID) VALUES (%s,%s,''%s'');',
             [LinkTable, LinkFromField, LinkToField,
              FromTable['_linkField'], ToTable['_linkField'], d.roomerMainDataSet.hotelId]));
      end;
      ToTable.Next;
    end;
    plan.Execute(ptExec, True);
  finally
    lvSelect.Selected := savedLocation;
    lvSelect.EndUpdate;
  end;
  FreeAndNil(LinkageTable);
  LinkageTable := GetTableInfo(LinkTableSql);

end;

procedure TFrmTaxItemLink.FormShow(Sender: TObject);
var sql : String;
    temp : TStrings;
    i : Integer;

    fld : TListViewField;
    lc : TListColumn;
begin
  LinkTableSql := Format(SELECT_FROM_LINK_TABLE, [LinkFromField, LinkToField, LinkTable, d.roomerMainDataSet.hotelId]);
  FromTableSql := Format(SELECT_FROM_FROMTABLE, [LinkFromLinkField, LinkFromFields, LinkFromTable]);
  ToTableSql := Format(SELECT_FROM_TOTABLE, [LinkToLinkField, LinkToFields, LinkToTable, d.roomerMainDataSet.hotelId]);

  FromTable := GetTableInfo(FromTableSql);
  ToTable := GetTableInfo(ToTableSql);
  LinkageTable := GetTableInfo(LinkTableSql);

  temp := SplitStringToTStrings(',', LinkToFields);
  for i := 0 to temp.Count - 1 do
  begin
    lc := lvSelect.Columns.Add;
    lc.Caption := temp[i];
    lc.Width := -1;

    fld := lvSelect.Fields.Add;
    fld.FieldName := temp[i];
    fld.Title := temp[i];
  end;
  lvSelect.DataSource := dsTo;

  dsFrom.DataSet := FromTable;
  dsTo.DataSet := ToTable;

  dsFrom.DataSet.Active := True;
  dsTo.DataSet.Active := True;

  grLinkFrom.Fields[0].Visible := false;

  Application.ProcessMessages;
  for i := 0 to lvSelect.Columns.Count - 1 do
  begin
    lvSelect.Columns[i].Width := -1; //LVSCW_AUTOSIZE_USEHEADER;
  end;

  FromTable.AfterScroll := FromAfterScroll;

  FromTable.First;
  if NOT FromTable.Eof then
     FromAfterScroll(FromTable);
end;

function TFrmTaxItemLink.GetTableInfo(sql : String) : TRoomerDataSet;
begin
  result := CreateNewDataSet;
  rSet_bySQL(result,sql);
end;

end.
