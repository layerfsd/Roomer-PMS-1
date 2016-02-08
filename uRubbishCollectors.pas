unit uRubbishCollectors;

interface

uses
    uG
    , System.Generics.Collections
    , SysUtils
    ;

var
   RoomCellCollection : TObjectList<TRoomCell>;

procedure InitRoomCells;
procedure ClearRoomCells;

implementation

procedure InitRoomCells;
begin
  RoomCellCollection := TObjectList<TRoomCell>.Create(True);
end;

procedure ClearRoomCells;
var i : Integer;
begin
  RoomCellCollection.Clear;
end;

initialization
  InitRoomCells;

finalization
  ClearRoomCells;
  FreeAndNil(RoomCellCollection);

end.
