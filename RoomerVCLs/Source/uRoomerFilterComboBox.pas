unit uRoomerFilterComboBox;

interface

uses
  System.SysUtils, System.Classes, sComboBox, Vcl.Controls, Vcl.StdCtrls, Windows,
  Messages, System.Generics.Collections;

type
  TRoomerFilterItem = class
    Key : String;
    Line : String;
  end;

  TRoomerFilterComboBox = class(TsComboBox)
  private
    FActive : Boolean;
    FStoredItems: TList<TRoomerFilterItem>;
    procedure FilterItems;
//    procedure StoredItemsChange(Sender: TObject);
    procedure SetStoredItems(const value : TList<TRoomerFilterItem>);
  protected
  public
    FKeys: TStrings;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CNCommand(var AMessage: TWMCommand); message CN_COMMAND;
    procedure Start;
    procedure Stop;
    property active : Boolean read FActive write FActive;
  published
    property StoredItems: TList<TRoomerFilterItem> read FStoredItems write SetStoredItems;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Roomer', [TRoomerFilterComboBox]);
end;

constructor TRoomerFilterComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FActive := False;
  AutoComplete := False;
  FStoredItems := TList<TRoomerFilterItem>.Create;
  FKeys := TStringList.Create;
//  FStoredItems.OnChange := StoredItemsChange;
end;

destructor TRoomerFilterComboBox.Destroy;
begin
  FStoredItems.Clear;
  FStoredItems.Free;
  inherited;
end;

procedure TRoomerFilterComboBox.CNCommand(var AMessage: TWMCommand);
begin
  // we have to process everything from our ancestor
  inherited;
  // if we received the CBN_EDITUPDATE notification
  if FActive AND (AMessage.NotifyCode = CBN_EDITUPDATE) then
  begin
    // fill the items with the matches
    FilterItems;
//    if Length(Text) < 3 then
//      DroppedDown := False;
  end;
end;

procedure TRoomerFilterComboBox.FilterItems;
type
  TSelection = record
    StartPos, EndPos: Integer;
  end;
var
  I: Integer;
  Selection: TSelection;
  sTemp,
  xText: string;
begin
  // store the current combo edit selection
  SendMessage(Handle, CB_GETEDITSEL, WPARAM(@Selection.StartPos), LPARAM(@Selection.EndPos));

  // begin with the items update
  Items.BeginUpdate;
  try
    // if the combo edit is not empty, then clear the items
    // and search through the FStoredItems
    // clear all items
    Items.Clear;
    FKeys.Clear;
    // iterate through all of them
    for I := 0 to FStoredItems.Count - 1 do
    begin
      // check if the current one contains the text in edit
      // if ContainsText(FStoredItems[I], Text) then
      sTemp := FStoredItems[I].Line;
      if ((Text='') OR (Pos(Lowercase(Text), Lowercase(sTemp)) > 0)) AND
         (Items.IndexOf(sTemp) = -1)  then
      begin
        // and if so, then add it to the items
        FKeys.Add(FStoredItems[I].Key);
        Items.AddObject(sTemp, FStoredItems[I]);
      end;
    end;
  finally
    // finish the items update
    Items.EndUpdate;
  end;

  // and restore the last combo edit selection
  xText := Text;
  if (Items <> nil) and (Items.Count > 0) then
  begin
    SendMessage(Handle, CB_SHOWDROPDOWN, Integer(True), 0);
    ItemIndex := 0;
  end
  else
  begin
    SendMessage(Handle, CB_SHOWDROPDOWN, Integer(False), 0);
    ItemIndex := -1;
  end;
  Text := xText;
  SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(Selection.StartPos,
    Selection.EndPos));

  SendMessage(Handle, WM_SETCURSOR, 0, 0);
end;

procedure TRoomerFilterComboBox.Start;
begin
  FActive := True;
end;

procedure TRoomerFilterComboBox.Stop;
begin
  FActive := False;
end;

//procedure TRoomerFilterComboBox.StoredItemsChange(Sender: TObject);
//begin
//  if FActive AND Assigned(FStoredItems) then
//    FilterItems;
//end;

procedure TRoomerFilterComboBox.SetStoredItems(const Value: TList<TRoomerFilterItem>);
var i : Integer;
begin
  FStoredItems.Clear;
  for i := 0 to Value.Count - 1 do
    FStoredItems.Add(Value[i]);

  DroppedDown := False;
  Text:= '';
  ItemIndex := -1;
end;

end.
