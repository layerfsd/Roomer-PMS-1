unit uRubbishCollectors;

interface

uses
    uG
    , System.Generics.Collections
    , SysUtils
    ;

var
   RoomCellCollection : TList<TRoomCell>;

procedure InitRoomCells;
procedure ClearRoomCells;

implementation

procedure InitRoomCells;
begin
  RoomCellCollection := TList<TRoomCell>.Create;
end;

procedure ClearRoomCells;
var i : Integer;
begin
  for i := 0 to RoomCellCollection.Count - 1 do
    RoomCellCollection[i].Free;
  RoomCellCollection.Clear;
end;

initialization
  InitRoomCells;

finalization
  ClearRoomCells;
  FreeAndNil(RoomCellCollection);

end.
