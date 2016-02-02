unit objRoomTypeRoomCount;

interface


uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Contnrs,
  Dialogs,
  NativeXML,
  ADODB
  , System.Generics.Collections
  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection
  ;

TYPE

  TRoomTypeItem = class

    FRoomTypeCount       : integer   ;
    FRoomType            : string    ;
    FDescription         : string    ;
    FGuestCount          : integer   ;
    FRoomTypeGroup       : string    ;

    function getRoomTypeCount       : integer   ;
    function getRoomType            : string    ;
    function getDescription         : string    ;
    function getGuestCount          : integer   ;
    function getRoomTypeGroup       : string    ;

    procedure SetRoomTypeCount(Value : integer);
    procedure SetRoomType(Value : string);
    procedure SetDescription(Value : string);
    procedure SetGuestCount(Value : integer);
    procedure SetRoomTypeGroup(Value: string);

  private
    // **
  public
    constructor Create;
    destructor Destroy; override;

    property RoomTypeCount      : integer   read  getRoomTypeCount         write setRoomTypeCount ;
    property RoomType           : string    read  getRoomType              write setRoomType      ;
    property Description        : string    read  getDescription           write setDescription   ;
    property GuestCount         : integer   read  getGuestCount            write setGuestCount    ;
    property RoomTypeGroup      : string    read  getRoomTypeGroup         write setRoomTypeGroup ;
  end;


//////////////////////////////////////////////////////////////////////////////
//  TRoomItem
//
//
//////////////////////////////////////////////////////////////////////////////



  TRoomTypeList = TList<TRoomTypeItem>;

  //////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  /////////////////////////////////////////////////////////////////////////////////////

  TRoomTypeRoomCount = class
  private
    FXmlFileName : string;

    FRoomCount : integer;
    FRoomTypeList : TRoomTypeList;

    FHotelcode    : string ;

    function getRoomTypeCount : integer;
    procedure FillList;
    procedure ClearList;

  public
    constructor Create(HotelCode : string);
    destructor Destroy; override;

    property XmlFileName : string read FXmlFileName write FXmlFileName;

    property Hotelcode      : string    read FHotelcode      write FHotelcode;

    function FindRoomTypeCount(RoomType : string; StartAt : integer; caseSensitive : Boolean = false) : integer;

    property RoomTypeList : TRoomTypeList read FRoomTypeList write FRoomTypeList;
    property RoomTypeCount : integer read getRoomTypeCount;
  end;




implementation

uses //uDSp
  ug
  ,_glob
  ,hdata
  ,uD
  ,uSqlDefinitions
  , uMain
  ;



//////////////////////////////////////////////////////////////////////////////
//  TRoomTypeItem
//
//
//////////////////////////////////////////////////////////////////////////////

constructor  TRoomTypeItem.Create;
begin
  //**
end;

destructor TRoomTypeItem.Destroy;
begin
  inherited;
end;

function TRoomTypeItem.getRoomTypeCount          : integer   ;
begin
  result := FRoomTypeCount
end;


function TRoomTypeItem.getRoomType            : string    ;
begin
  result := FRoomType
end;

function TRoomTypeItem.getDescription         : string    ;
begin
  result := FDescription
end;

function TRoomTypeItem.getGuestCount          : integer   ;
begin
  result := FGuestCount
end;

function TRoomTypeItem.getRoomTypeGroup       : string    ;
begin
  result := FRoomTypeGroup
end;


procedure TRoomTypeItem.SetRoomTypeCount(Value : integer);
begin
  FRoomTypeCount := value
end;

procedure TRoomTypeItem.SetRoomType(Value: string);
begin
  FRoomType := value
end;

procedure TRoomTypeItem.SetDescription(Value : string);
begin
  FDescription := value
end;

procedure TRoomTypeItem.SetGuestCount(Value : integer);
begin
  FGuestCount := value
end;

procedure TRoomTypeItem.SetRoomTypeGroup(Value: string);
begin
  FRoomTypeGroup := value
end;



//////////////////////////////////////////////////////////////////////
//
//
//////////////////////////////////////////////////////////////////////
constructor TRoomTypeRoomCount.Create(HotelCode : string);
begin
  inherited Create;

  try
    FRoomTypeList := TRoomTypeList.Create;
  Except
    //TODO Loga
  end;

  FHotelCode := HotelCode;

  FRoomCount := 0;

  try
    FillList;
  Except
    // logga
  end;

end;

destructor TRoomTypeRoomCount.Destroy;
begin
  ClearList;
  freeandnil(FRoomTypeList);
  inherited;
end;

procedure TRoomTypeRoomCount.ClearList;
var i : integer;
begin
  for i := 0 to FRoomTypeList.Count - 1 do
  begin
    TRoomTypeItem(FRoomTypeList[i]).free;
  end;
  FRoomTypeList.Clear;
end;

procedure TRoomTypeRoomCount.FillList;
var
  RoomTypeItem : TRoomTypeItem;
  s : string;
  rSet : TRoomerDataSet;

  TypeCount : Integer;
  RoomType : string;
  Description : string;
  NumberGuests : integer;
  RoomTypeGroup : string;

begin
  ClearList;
  if frmMain.OfflineMode then
    exit;

  rSet := CreateNewDataSet;
  try
    s := '';
//    s := s+ ' SELECT '+#10;
//    s := s+ '     COUNT(Rooms.Room) AS TypeCount '+#10;
//    s := s+ '   , Rooms.RoomType '+#10;
//    s := s+ '   , RoomTypes.Description '+#10;
//    s := s+ '   , RoomTypes.NumberGuests '+#10;
//    s := s+ '   , RoomTypes.RoomTypeGroup '+#10;
//    s := s+ ' FROM '+#10;
//    s := s+ '   Rooms '+#10;
//    s := s+ '     INNER JOIN RoomTypes ON Rooms.RoomType = RoomTypes.RoomType '+#10;
//    s := s+ ' GROUP BY '+#10;
//    s := s+ '      Rooms.RoomType '+#10;
//    s := s+ '    , RoomTypes.Description '+#10;
//    s := s+ '    , RoomTypes.NumberGuests '+#10;
//    s := s+ '    , RoomTypes.RoomTypeGroup '+#10;
//    s := s+ ' ORDER BY Rooms.roomType '+#10;


    s := format(select_objRoomTypeRoomCount_FillList,[]);
//    CopyToClipboard(s);
//    DebugMessage('select_objRoomTypeRoomCount_FillList'#10#10+s);
    hData.rSet_bySQL(rSet,s);

    Rset.First;
    While not rSet.Eof do
    begin
      TypeCount            := Rset.fieldbyname('TypeCount').asInteger;
      RoomType             := Rset.fieldbyname('RoomType').asString;
      Description          := Rset.fieldbyname('Description').asString;
      NumberGuests         := Rset.fieldbyname('NumberGuests').asInteger;
      RoomTypeGroup        := Rset.fieldbyname('RoomTypeGroup').asString;

      RoomTypeItem := TRoomTypeItem.Create;
      try
        RoomTypeItem.SetRoomTypeCount(TypeCount);
        RoomTypeItem.SetRoomType(RoomType);
        RoomTypeItem.SetDescription(Description);
        RoomTypeItem.SetGuestCount(NumberGuests);
        RoomTypeItem.SetRoomTypeGroup(RoomTypeGroup);
        FRoomTypeList.Add(RoomTypeItem);
      except
         // logga
      end;
      rSet.Next;
    end;
  finally
    freeandNil(rSet);
  end;
end;


function TRoomTypeRoomCount.FindRoomTypeCount(RoomType : string; StartAt : integer; caseSensitive : Boolean = false) : integer;
var
  i : integer;
  aType : string;
begin
  result := 0;

  RoomType := ansiUppercase(RoomType);

  for i := 0 to FRoomTypeList.Count -1 do
  begin
    aType := FRoomTypeList[i].FRoomType;
    aType := ansiUpperCase(aType);

    if RoomType = aType then
    begin
      result := FRoomTypeList[i].RoomTypeCount;
      Break;
    end;
  end;
end;



function TRoomTypeRoomCount.getRoomTypeCount: integer;
begin
  result := FRoomTypeList.Count;
end;

end.
