unit uFrmKeyPairSelector;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sEdit, sLabel, sListBox, sButton,
  Vcl.ExtCtrls, sPanel, Vcl.ComCtrls, sListView, uD, uRoomerLanguage, uappGlobal;

type
  TfrmKeyPairSelector = class(TForm)
    sPanel1: TsPanel;
    pnlEditButtons: TsPanel;
    BtnOk: TsButton;
    btnCancel: TsButton;
    sPanel2: TsPanel;
    sLabel1: TsLabel;
    edtFilter: TsEdit;
    lvList: TsListView;
    __btnClear: TsButton;
    procedure lvListDblClick(Sender: TObject);
    procedure lvListCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure lvListColumnClick(Sender: TObject; Column: TListColumn);
    procedure edtFilterChange(Sender: TObject);
    procedure __btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Descending: Boolean;
    SortedColumn: Integer;
  public
    { Public declarations }
    list: TKeyPairList;
    sDefault : String;
    procedure FillList(sDefault : String);
  end;

var
  frmKeyPairSelector: TfrmKeyPairSelector;

function selectFromKeyValuePairs(sCaption, sDefault : String; list : TKeyPairList) : TKeyAndValue;

implementation

{$R *.dfm}

uses uUtils;

function selectFromKeyValuePairs(sCaption, sDefault : String; list : TKeyPairList) : TKeyAndValue;
var cursorWas : SmallInt;
begin
  CursorWas := Screen.Cursor;
  Screen.Cursor := crHourglass; Application.ProcessMessages;
  try
    result := nil;
    frmKeyPairSelector := TfrmKeyPairSelector.Create(nil);
    try
      frmKeyPairSelector.Caption := sCaption;
      frmKeyPairSelector.list := list;
      frmKeyPairSelector.sDefault := sDefault;
      frmKeyPairSelector.FillList(sDefault);
      if frmKeyPairSelector.ShowModal = mrOk then
      begin
        if Assigned(frmKeyPairSelector.lvList.Selected) then
          result := TKeyAndValue(frmKeyPairSelector.lvList.Selected.SubItems.Objects[0]);
      end;
    finally
      freeandnil(frmKeyPairSelector);
    end;
  finally
    Screen.Cursor := CursorWas; Application.ProcessMessages;
  end;
end;

procedure TfrmKeyPairSelector.edtFilterChange(Sender: TObject);
begin
  FillList('');
end;

procedure TfrmKeyPairSelector.FillList(sDefault : String);
var
  I : Integer;
  item, itemDef : TListItem;
  filterActive : Boolean;
begin
  filterActive := trim(edtFilter.Text) <> '';
  itemDef := nil;
  lvList.Items.Clear;
  for I := 0 to list.Count - 1 do
  begin
    if (NOT filterActive) OR
       (pos(Lowercase(edtFilter.Text), Lowercase(list[I].Value + '*' + list[I].Key)) > 0) then
    begin
      item := lvList.Items.Add;
      item.Caption := list[I].Key;
      item.SubItems.AddObject(list[I].Value, list[I]);
      if list[I].Key = sDefault then
        itemDef := item;
    end;
  end;
  lvList.AlphaSort;
  if Assigned(itemDef) then
  begin
    lvList.Selected := itemDef;
    itemDef.MakeVisible(False);
  end;
  if (sDefault <> '') then
    ActiveControl := lvList;
end;

procedure TfrmKeyPairSelector.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmKeyPairSelector.lvListColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index<>SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := False;
  end
  else
    Descending := not Descending;

  TListView(Sender).SortType := stText;
end;

procedure TfrmKeyPairSelector.lvListCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
var
   intItem1,
   intItem2: Integer;
begin
  if SortedColumn = 0 then
  begin
//    try
//      intItem1 := StrToInt(Item1.Caption) ;
//      intItem2 := StrToInt(Item2.Caption) ;
//
//      if intItem1 < intItem2 then
//        Compare := -1
//      else
//      if intItem1 > intItem2 then
//        Compare := 1
//      else // intItem1 = intItem2
//        Compare := 0;
//    except
      Compare := CompareText(Item1.Caption, Item2.Caption);
//    end;
  end
  else
  if SortedColumn <> 0 then
    Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);

  if Descending then Compare := -Compare;
end;

procedure TfrmKeyPairSelector.lvListDblClick(Sender: TObject);
begin
  btnOk.Click;
end;

procedure TfrmKeyPairSelector.__btnClearClick(Sender: TObject);
begin
  edtFilter.Text := '';
end;

end.
