unit uRoomRules;

interface

uses
  Classes,
  windows,
  uAppGlobal,
  SysUtils,
  Controls,
  ADODB,
  hdata,
  _glob,
  ug

  , cmpRoomerDataSet
  , cmpRoomerConnection
  ;

type

  TNumbers = class(TStringlist)
  private
    function GetNumber(idx : integer) : integer;
  public
    function AddNumber(aValue : integer) : integer;
    property Number[idx : integer] : integer read GetNumber;
  published
  end;

  TSelectedRooms = class(Tobject)
  private
    FRoomType, FRoom : string;
    FGuests : integer;
    FFound : boolean;
  public
    constructor Create(RoomType : string; Guests : integer);
    destructor destroy; override;
  published
    property RoomType : string read FRoomType;
    property Room : string read FRoom;
    property Guests : integer read FGuests;
    property Found : boolean read FFound;
  end;

  TFindRoomObject = class(Tobject)
  private
    FSelectedRooms : TList;

    FRoomTypesNeeded : TStrings;
    FNumGuests : TNumbers;
    FdtArrival, FdtDeparture : TDate;

    function GetSelectedRoomsCount : integer;
    function GetSelectedRooms(idx : integer) : TSelectedRooms;

    function FindType(RoomType : string) : integer;
    procedure SelectRooms(Arrival, Departure : TDate);
    // FOnMouseExit : TNotifyEvent;
  public
    constructor Create(RoomTypesNeeded : TStrings; NumGuests : TNumbers);
    destructor destroy; override;
    procedure clear;

    procedure Execute(dtArrival, dtDeparture : TDate);
    property SelectedRoomsCount : integer read GetSelectedRoomsCount;
    property SelectedRooms[idx : integer] : TSelectedRooms read GetSelectedRooms;
  published
    // property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
  end;

function IsInRoomTypes(RoomType, RTAvailable : string) : boolean;

implementation

uses
  Grids
  ,dbTables
  ,ud
  ,uSqlDefinitions
  ;


function IsInRoomTypes(RoomType, RTAvailable : string) : boolean;
var
  sRule : string;
begin
  // --
  result := false;
  sRule := '';
  with glb.RoomTypeRulesSet do
  begin
    first;
    while not eof do
    begin
      if trim(FieldByName('RoomType').asString) = RoomType then
      begin
        sRule := trim(FieldByName('RuleString').asString);
        break;
      end;
      next;
    end;
  end;
  // --
  result := pos(',' + RTAvailable + ',', ',' + sRule + ',') > 0;
end;

{ TNumbers }
function TNumbers.GetNumber(idx : integer) : integer;
begin
  result := strtoint(Strings[idx]);
end;

function TNumbers.AddNumber(aValue : integer) : integer;
begin
  result := Add(inttostr(aValue));
end;

{ TSelectedRooms }
constructor TSelectedRooms.Create(RoomType : string; Guests : integer);
begin
  // --
  inherited Create;
  FRoomType := RoomType;
  FGuests := Guests;
  FFound := false;
end;

destructor TSelectedRooms.destroy;
begin
  // --
  inherited;
end;

constructor TFindRoomObject.Create(RoomTypesNeeded : TStrings; NumGuests : TNumbers);
var
  i : integer;
  SelectedRooms : TSelectedRooms;
begin
  // --
  inherited Create;

  FRoomTypesNeeded := TStringlist.Create;
  FNumGuests := TNumbers.Create;

  FRoomTypesNeeded.Assign(RoomTypesNeeded);
  FNumGuests.Assign(NumGuests);
  FSelectedRooms := TList.Create;

  for i := 0 to FRoomTypesNeeded.count - 1 do
  begin
    SelectedRooms := TSelectedRooms.Create(FRoomTypesNeeded[i], FNumGuests.Number[i]);
    FSelectedRooms.Add(SelectedRooms);
  end;
end;

procedure TFindRoomObject.clear;
var
  i : integer;
begin
  // --
  for i := FSelectedRooms.count - 1 downto 0 do
  begin
    TSelectedRooms(FSelectedRooms[i]).free;
    FSelectedRooms.delete(i);
  end;

  FRoomTypesNeeded.clear;
  FNumGuests.clear;
end;

destructor TFindRoomObject.destroy;
begin
  // --
  clear;
  FSelectedRooms.free;
  FRoomTypesNeeded.free;
  FNumGuests.free;

  inherited;
end;

var
  agrRooms : TStringGrid;

function TFindRoomObject.FindType(RoomType : string) : integer;
var
  i, l : integer;
  sSearch, sRule : string;

  Found : boolean;
begin
  // --
  result := - 1;
  sRule := RoomType;
  with glb.RoomTypeRulesSet do
  begin
    first;
    while not eof do
    begin
      if trim(FieldByName('RoomType').asString) = RoomType then
      begin
        sRule := trim(FieldByName('RuleString').asString);
        break;
      end;
      next;
    end;
  end;

  // --
  for l := 0 to _strTokenCount(sRule, ',')-1 do
  begin
    sSearch := trim(_strTokenAT(sRule, ',', l));
    Found := false;
    for i := 1 to agrRooms.RowCount - 1 do
    begin
      if agrRooms.Cells[1, i] = sSearch then
      begin
        Found := true;
        result := i;
        break;
      end;
    end;
    if Found then
      break;
  end;
end;

function RoomIndex(aGrid : TStringGrid; sRoom : string) : integer;
var
  i : integer;
begin
  // --
  result := - 1;
  for i := 1 to aGrid.RowCount - 1 do
  begin
    if aGrid.Cells[0, i] = sRoom then
    begin
      result := i;
      break;
    end;
  end;
end;

procedure TFindRoomObject.SelectRooms(Arrival, Departure : TDate);
var
  rSet : TRoomerDataSet;

  i : integer;
  ii : integer;

  DateFrom : TDate;
  DateTo : TDate;
  s : string;
begin
  DateFrom := Arrival;
  DateTo := Departure;

  agrRooms := TStringGrid.Create(nil);
  try
    agrRooms.ColCount := 3;
    rSet := CreateNewDataSet;
    try
//      s := '';
//      s := s + 'Select Room, RoomType, ADate, ResFlag from [RoomsDate] ';
//      s := s + ' where ADate >= ' + _DateToDBDate(DateFrom, true);
//      s := s + '   and ADate < ' + _DateToDBDate(DateTo, true);
//      s := s + '   and ( Room  < ' + QuotedStr('<');
//      s := s + '         or Room  > ' + QuotedStr('>') + ')';

      s := format(RoomRules_FindRoomObject_SELECTRooms , []);
      // clipboard.AsText := s;
      // showmessage(''#10#10+s);
      hData.rSet_bySQL(rSet,s);

      glb.FillRoomAndTypeGrid(agrRooms);

      with rSet do
      begin
        first;
        while not eof do
        begin
          if trim(FieldByName('Resflag').asString) <> 'N' then
          begin
            ii := RoomIndex(agrRooms, FieldByName('Room').asString);
            if ii <> - 1 then
            begin
              agrRooms.Row := ii;
              agrRooms.Cells[0, ii] := '';
              RowDelete(agrRooms);
            end;
          end;
          next;
        end;
      end;

      for i := 0 to FRoomTypesNeeded.count - 1 do
      begin
        ii := FindType(FRoomTypesNeeded[i]);
        if ii > 0 then
        begin
          TSelectedRooms(FSelectedRooms[i]).FRoom := agrRooms.Cells[0, ii];
          TSelectedRooms(FSelectedRooms[i]).FRoomType := agrRooms.Cells[1, ii];
          TSelectedRooms(FSelectedRooms[i]).FFound := true;
          DeleteRow(agrRooms, ii);
        end;
      end;
    finally
      freeandnil(rSet);
    end;
  finally
    agrRooms.free;
  end;
end;

procedure TFindRoomObject.Execute(dtArrival, dtDeparture : TDate);
begin
  FdtArrival := dtArrival;
  FdtDeparture := dtDeparture;
  SelectRooms(dtArrival, dtDeparture);
end;

function TFindRoomObject.GetSelectedRoomsCount : integer;
begin
  result := FSelectedRooms.count;
end;

function TFindRoomObject.GetSelectedRooms(idx : integer) : TSelectedRooms;
begin
  result := TSelectedRooms(FSelectedRooms[idx]);
end;

end.
