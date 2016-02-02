unit objRoomList2;

interface


uses
  Windows,
  Forms,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Contnrs,
  Dialogs,
  NativeXML,
  ADODB,
  hData
  , System.Generics.Collections
  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection
  ;

TYPE

  TRoomItem = class

    FRoom                : string    ;
    FRoomDescription     : string    ;
    FRoomType            : string    ;
    FRoomEquipments      : string    ;
    FBookable            : boolean   ;
    FUseInResStatistics  : boolean   ;
    FStatus              : string    ;
    FOrderIndex          : integer   ;
    Fhidden              : boolean   ;
    FLocation            : string    ;
    FFloor               : integer   ;
    FuseInNationalReport : boolean   ;

    FCleaningNotes       : string    ;
    FMaintenanceNotes    : string    ;
    FLostAndFound        : string    ;
    FReportUser          : string    ;
    FReportUserName      : string    ;
    FStatusDescripton    : String    ;


    function getRoom                : string    ;
    function getRoomDescription     : string    ;
    function getRoomType            : string    ;
    function getRoomEquipments      : string    ;
    function getBookable            : boolean   ;
    function getUseInResStatistics  : boolean   ;
    function getStatus              : string    ;
    function getOrderIndex          : integer   ;
    function gethidden              : boolean   ;
    function getLocation            : string    ;
    function getFloor               : integer   ;
    function getuseInNationalReport : boolean   ;

    procedure SetRoom(Value : string);
    procedure SetRoomDescription(Value : string);
    procedure SetRoomType(Value : string);
    procedure SetRoomEquipments(Value : string);
    procedure SetBookable(Value : boolean);
    procedure SetUseInResStatistics(Value : boolean);
    procedure SetStatus(Value : string);
    procedure SetOrderIndex(Value : integer);
    procedure Sethidden(Value : boolean);
    procedure SetLocation(Value : string);
    procedure SetFloor(Value : integer);
    procedure SetuseInNationalReport(Value : boolean);


  private
    function getCleaningNotes: string;
    function getLostAndFound: string;
    function getMaintenanceNotes: string;
    function getReportUser: string;
    function getReportUserName: string;
    procedure setCleaningNotes(const Value: string);
    procedure setLostAndFound(const Value: string);
    procedure setMaintenanceNotes(const Value: string);
    procedure setReportUser(const Value: string);
    procedure setReportUserName(const Value: string);
    function getStatusDescripton: string;
    procedure setStatusDescripton(const Value: string);
    // **
  public
    constructor Create;
    destructor Destroy; override;

    property Room               : string    read  getRoom                  write setRoom               ;
    property RoomDescription    : string    read  getRoomDescription       write setRoomDescription    ;
    property RoomType           : string    read  getRoomType              write setRoomType           ;
    property RoomEquipments     : string    read  getRoomEquipments        write setRoomEquipments     ;
    property Bookable           : boolean   read  getBookable              write setBookable           ;
    property UseInResStatistics : boolean   read  getUseInResStatistics    write setUseInResStatistics ;
    property Status             : string    read  getStatus                write setStatus             ;
    property OrderIndex         : integer   read  getOrderIndex            write setOrderIndex         ;
    property hidden             : boolean   read  gethidden                write sethidden             ;
    property Location           : string    read  getLocation              write setLocation           ;
    property Floor              : integer   read  getFloor                 write setFloor              ;
    property useInNationalReport: boolean   read  getuseInNationalReport   write setUseInNationalReport;

    property CleaningNotes       : string   read getCleaningNotes          write setCleaningNotes;
    property MaintenanceNotes    : string   read getMaintenanceNotes       write setMaintenanceNotes;
    property LostAndFound        : string   read getLostAndFound           write setLostAndFound ;
    property ReportUser          : string   read getReportUser             write setReportUser ;
    property ReportUserName      : string   read getReportUserName         write setReportUserName ;
    property StatusDescripton    : string   read getStatusDescripton       write setStatusDescripton ;

  end;


//////////////////////////////////////////////////////////////////////////////
//  TRoomItem
//
//
//////////////////////////////////////////////////////////////////////////////



  TRoomItemsList = TList<TRoomItem>;

  //////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  /////////////////////////////////////////////////////////////////////////////////////

  TRooms = class
  private
    FXmlFileName : string;

    FRoomCount : integer;
    FRoomList : TRoomItemsList;

    FHotelcode       : string    ;

    function getRoomCount : integer;
    procedure FillList(var RoomCount : integer);
    procedure Clear;

  public
    constructor Create(aHotelCode : string);
    destructor Destroy; override;

    property XmlFileName : string read FXmlFileName write FXmlFileName;

    property Hotelcode      : string    read FHotelcode      write FHotelcode;

    function FindRoomFromRoomNumber(RoomNumber : string; StartAt: integer = 0; caseSensitive: Boolean = false) : integer;
    function FindRoomStatus(RoomNumber: string): string;


    property RoomItemsList : TRoomItemsList read FRoomList write FRoomList;
    property RoomCount : integer read getRoomCount;


  end;




implementation

uses //uDSp
  ug
  , _glob
  , uD
  , uAppGlobal
  , uSqlDefinitions
  ;



//////////////////////////////////////////////////////////////////////////////
//  TRoomItem
//
//
//////////////////////////////////////////////////////////////////////////////

constructor  TRoomItem.Create;
begin
  FCleaningNotes       := '';
  FMaintenanceNotes    := '';
  FLostAndFound        := '';
  FReportUser          := '';
  FReportUserName      := '';
  FStatusDescripton    := '';
end;

destructor TRoomItem.Destroy;
begin
  inherited;
end;



function TRoomItem.getBookable: boolean;
begin
  result := FBookable
end;

function TRoomItem.getCleaningNotes: string;
begin
  result := FCleaningNotes;
end;

function TRoomItem.getFloor: integer;
begin
  result := FFloor
end;

function TRoomItem.getHidden: boolean;
begin
  result := FHidden
end;

function TRoomItem.getLocation: string;
begin
  result := FLocation
end;

function TRoomItem.getLostAndFound: string;
begin
  result := FLostAndFound;
end;

function TRoomItem.getMaintenanceNotes: string;
begin
  result := FMaintenanceNotes;
end;

function TRoomItem.getOrderIndex: integer;
begin
  result := FOrderIndex
end;

function TRoomItem.getReportUser: string;
begin
  result := FReportUser;
end;

function TRoomItem.getReportUserName: string;
begin
  result := FReportUserName;
end;

function TRoomItem.getRoom: string;
begin
  result := FRoom
end;

function TRoomItem.getRoomDescription: string;
begin
  result := FRoomDescription
end;

function TRoomItem.getRoomEquipments: string;
begin
  result := FRoomEquipments
end;

function TRoomItem.getRoomType: string;
begin
  result := FRoomType
end;

function TRoomItem.getStatus: string;
begin
  result := FStatus
end;

function TRoomItem.getStatusDescripton: string;
begin
  result := FStatusDescripton;
end;

function TRoomItem.getUseInNationalReport: boolean;
begin
  result := FUseInNationalReport
end;

function TRoomItem.getUseInResStatistics: boolean;
begin
  result := FUseInResStatistics
end;



////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////


procedure TRoomItem.SetBookable(Value: boolean);
begin
  FBookable := value;
end;

procedure TRoomItem.setCleaningNotes(const Value: string);
begin
  FCleaningNotes := Value;
end;

procedure TRoomItem.SetFloor(Value: integer);
begin
  FFloor := value
end;

procedure TRoomItem.SetHidden(Value: boolean);
begin
  FHidden := value
end;

procedure TRoomItem.SetLocation(Value: string);
begin
  FLocation := value
end;

procedure TRoomItem.setLostAndFound(const Value: string);
begin
  FLostAndFound := Value;
end;

procedure TRoomItem.setMaintenanceNotes(const Value: string);
begin
  FMaintenanceNotes := Value;
end;

procedure TRoomItem.SetOrderIndex(Value: integer);
begin
  FOrderIndex := value
end;

procedure TRoomItem.setReportUser(const Value: string);
begin
  FReportUser := Value;
end;

procedure TRoomItem.setReportUserName(const Value: string);
begin
  FReportUserName := Value;
end;

procedure TRoomItem.SetRoom(Value: string);
begin
  FRoom := value
end;

procedure TRoomItem.SetRoomDescription(Value: string);
begin
  FRoomDescription := value
end;

procedure TRoomItem.SetRoomEquipments(Value: string);
begin
  FRoomEquipments := value
end;

procedure TRoomItem.SetRoomType(Value: string);
begin
  FRoomType := value
end;

procedure TRoomItem.SetStatus(Value: string);
begin
  FStatus := value
end;

procedure TRoomItem.setStatusDescripton(const Value: string);
begin
  FStatusDescripton := Value;
end;

procedure TRoomItem.SetUseInNationalReport(Value: boolean);
begin
  FUseInNationalReport := value
end;

procedure TRoomItem.SetUseInResStatistics(Value: boolean);
begin
  FUseInResStatistics := value
end;


//////////////////////////////////////////////////////////////////////
//{ TPosSale }
//
//
//////////////////////////////////////////////////////////////////////
constructor TRooms.Create(aHotelCode : string);
begin
  inherited Create;

  try
    FRoomList := TRoomItemsList.Create;
  Except
    //TODO Loga
  end;

  FHotelCode := aHotelCode;
  FRoomCount := 0;

  try
    FillList(FRoomCount);
  Except
    // logga
  end;

end;

destructor TRooms.Destroy;
begin
  Clear;
  freeandnil(FRoomList);
  inherited;
end;

procedure TRooms.Clear;
var i: Integer;
begin
  for i := 0 to FRoomList.Count - 1 do
    FRoomList[i].Free;
  FRoomList.Clear;
end;

procedure TRooms.FillList(var RoomCount: integer);
var
  RoomItem : TRoomItem;

  s : string;
  rSet : TRoomerDataSet;

  Room                : string  ;
  RoomDescription     : string  ;
  RoomType            : string  ;
  RoomEquipments      : string  ;
  Bookable            : boolean ;
  useInResStatistics  : boolean ;
  Status              : string  ;
  OrderIndex          : integer ;
  hidden              : boolean ;
  Location            : string  ;
  Floor               : integer ;
  useInNationalReport : boolean ;

  maintNotes : TRoomerDataSet;
  maintCodes : TRoomerDataSet;
  maintStaff : TRoomerDataSet;

begin
//   s := s+' SELECT '+#10;
//   s := s+'   TOP (100) PERCENT '+#10;
//   s := s+'   Room '+#10;
//   s := s+'  ,Description '+#10;
//   s := s+'  ,RoomType '+#10;
//   s := s+'  ,Equipments '+#10;
//   s := s+'  ,Bookable '+#10;
//   s := s+'  ,[Statistics] '+#10;
//   s := s+'  ,Status '+#10;
//   s := s+'  ,OrderIndex '+#10;
//   s := s+'  ,hidden '+#10;
//   s := s+'  ,Location '+#10;
//   s := s+'  ,Floor '+#10;
//   s := s+'  ,useInNationalReport '+#10;
//   s := s+' FROM '+#10;
//   s := s+'   Rooms '+#10;
//   s := s+' ORDER BY '+#10;
//   s := s+'   OrderIndex '+#10;
//   s := s+'   ,Room '+#10;
  Clear;

  glb.ForceTableRefresh;

// BHG
    maintNotes := glb.GetDataSetFromDictionary('maintenanceroomnotes');
    maintCodes := glb.GetDataSetFromDictionary('maintenancecodes');
    maintStaff := glb.GetDataSetFromDictionary('staffmembers');
//  s := format(select_objRoomList2_FillList,[]);
//
//  rSet := CreateNewDataSet;
    rSet := glb.RoomsSet;
//  try
//    hData.rSet_bySQL(rSet,s);
    Rset.First;
    While not rSet.Eof do
    begin
      Room                 := Rset.fieldbyname('Room').asString;
      RoomDescription      := Rset.fieldbyname('Description').asString;
      RoomType             := Rset.fieldbyname('RoomType').asString;
      RoomEquipments       := Rset.fieldbyname('Equipments').asString;
      Location             := Rset.fieldbyname('Location').asString;
      Floor                := Rset.fieldbyname('Floor').asInteger;
      Bookable             := Rset['Bookable'];
      useinResStatistics   := Rset['Statistics'];
      hidden               := Rset['hidden'];
      useInNationalReport  := Rset['useInNationalReport'];
      Status               := Rset.fieldbyname('Status').asString;
      OrderIndex           := Rset.fieldbyname('OrderIndex').asInteger;

      if not hidden then
      begin
        RoomItem := TRoomItem.Create;
        try
          if glb.LocateSpecificRecord('maintenancecodes', 'Code', Status) then
          begin
            glb.LocateSpecificRecord('maintenanceroomnotes', 'Room', Room);
            glb.LocateSpecificRecord('staffmembers', 'id', maintNotes.FieldByName('StaffIdReported').AsString);
            RoomItem.SetRoom(Room);
  //          RoomItem.FRoom := Room;
            RoomItem.SetRoomDescription(RoomDescription);
            RoomItem.SetRoomType(RoomType);
            RoomItem.SetRoomEquipments(RoomEquipments);
            RoomItem.SetBookable(Bookable);
            RoomItem.SetUseInResStatistics(UseInResStatistics);
            RoomItem.SetStatus(Status);
            RoomItem.SetOrderIndex(OrderIndex);
            RoomItem.Sethidden(hidden);
            RoomItem.SetLocation(Location);
            RoomItem.SetFloor(Floor);
            RoomItem.SetUseInNationalReport(UseInNationalReport);

            if NOT maintNotes.Eof then
            begin
              RoomItem.CleaningNotes := maintNotes['CleaningNotes'];
              RoomItem.MaintenanceNotes := maintNotes['MaintenanceNotes'];
              RoomItem.LostAndFound := maintNotes['LostAndFound'];
            end;
            if NOT maintStaff.Eof then
            begin
              RoomItem.ReportUser := maintStaff['Initials'];
              RoomItem.ReportUserName := maintStaff['Name'];
            end;

            if NOT maintCodes.Eof then
              RoomItem.StatusDescripton := maintCodes['name'];

            FRoomList.Add(RoomItem);
          end;
        except
          // logga
        end;
      end;
      rSet.Next;
    end;
    RoomCount := FRoomList.Count;
//  finally
//    freeandNil(rSet);
//  end;
// BHG
end;

function TRooms.FindRoomFromRoomNumber(RoomNumber: string; StartAt: integer = 0; caseSensitive: Boolean = false): integer;
var
  i : integer;
  Room : string;
begin
  result := -1;
  if StartAt > FRoomList.Count-1 then exit;

  if not caseSensitive then
  begin
    RoomNumber := ansiLowercase(RoomNumber);
  end;

  for i := startAt to FRoomList.Count -1 do
  begin
    Room := FRoomList[i].FRoom;

    if not caseSensitive then
    begin
      Room := ansiLowercase(room);
    end;

    if RoomNumber = room then
    begin
      result := i;
      Break;
    end;
  end;
end;

function TRooms.FindRoomStatus(RoomNumber: string): string;
var
  i : integer;
  Room : string;
begin
  if Application.Terminated then exit;

  result := '';

  RoomNumber := ansiLowercase(RoomNumber);

  if Assigned(FRoomList) then
    for i := 0 to FRoomList.Count -1 do
    begin
      Room := FRoomList[i].FRoom;
      Room := ansiLowercase(room);

      if RoomNumber = room then
      begin
        result := FRoomList[i].FStatus;
        Break;
      end;
    end;
end;


function TRooms.getRoomCount: integer;
begin
  result := FRoomList.Count;
end;

end.
