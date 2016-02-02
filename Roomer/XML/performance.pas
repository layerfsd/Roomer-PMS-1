
{****************************************************************************************************************************}
{                                                                                                                            }
{                                                      XML Data Binding                                                      }
{                                                                                                                            }
{         Generated on: 16-3-2014 14:25:01                                                                                   }
{       Generated from: C:\Users\Bjorn\Documents\GitHub\RoomerAPI\roomer-mobile-api\src\main\java\data\xml\performance.xsd   }
{   Settings stored in: C:\Users\Bjorn\Documents\GitHub\RoomerAPI\roomer-mobile-api\src\main\java\data\xml\performance.xdb   }
{                                                                                                                            }
{****************************************************************************************************************************}

unit performance;

interface

uses xmldom, XMLDoc, XMLIntf, Variants, uUtils, System.SysUtils;

type

{ Forward Decls }

  IXMLPerformanceType = interface;
  IXMLDayType = interface;
  IXMLDayType_roomsAndAvailabilities = interface;
  IXMLRoomTypeType = interface;
  IXMLChannelType = interface;
  IXMLChannelTypeList = interface;
  IXMLRoomsAndAvailabilitiesType = interface;

{ IXMLPerformanceType }

  IXMLPerformanceType = interface(IXMLNodeCollection)
    ['{853BE813-38A0-4537-BE72-635A8C75DD97}']
    { Property Accessors }
    function Get_Currency: UnicodeString;
    function Get_EndDate: TDateTime;
    function Get_StartDate: TDateTime;
    function Get_Day(Index: Integer): IXMLDayType;
    procedure Set_Currency(Value: UnicodeString);
    procedure Set_EndDate(Value: TDateTime);
    procedure Set_StartDate(Value: TDateTime);
    { Methods & Properties }
    function Add: IXMLDayType;
    function Insert(const Index: Integer): IXMLDayType;
    property Currency: UnicodeString read Get_Currency write Set_Currency;
    property EndDate: TDateTime read Get_EndDate write Set_EndDate;
    property StartDate: TDateTime read Get_StartDate write Set_StartDate;
    property Day[Index: Integer]: IXMLDayType read Get_Day; default;
  end;

{ IXMLDayType }

  IXMLDayType = interface(IXMLNode)
    ['{6BCA099F-8FF7-4DBA-8BA4-DE60060E9E2D}']
    { Property Accessors }
    function Get_Adr: Double;
    function Get_Arrivals: Integer;
    function Get_CheckedIn: Integer;
    function Get_Date: TDateTime;
    function Get_Departed: Integer;
    function Get_Departures: Integer;
    function Get_Guests: Integer;
    function Get_MaxRate: Double;
    function Get_MinRate: Double;
    function Get_NoShow: Integer;
    function Get_Occ: Double;
    function Get_Occupied: Integer;
    function Get_Ooo: Integer;
    function Get_RevPar: Double;
    function Get_Revenue: Double;
    function Get_Rooms: Integer;
    function Get_Sold: Integer;
    function Get_TotalDiscounts: Double;
    function Get_RoomsAndAvailabilities: IXMLDayType_roomsAndAvailabilities;
    function Get_Channel: IXMLChannelTypeList;
    procedure Set_Adr(Value: Double);
    procedure Set_Arrivals(Value: Integer);
    procedure Set_CheckedIn(Value: Integer);
    procedure Set_Date(Value: TDateTime);
    procedure Set_Departed(Value: Integer);
    procedure Set_Departures(Value: Integer);
    procedure Set_Guests(Value: Integer);
    procedure Set_MaxRate(Value: Double);
    procedure Set_MinRate(Value: Double);
    procedure Set_NoShow(Value: Integer);
    procedure Set_Occ(Value: Double);
    procedure Set_Occupied(Value: Integer);
    procedure Set_Ooo(Value: Integer);
    procedure Set_RevPar(Value: Double);
    procedure Set_Revenue(Value: Double);
    procedure Set_Rooms(Value: Integer);
    procedure Set_Sold(Value: Integer);
    procedure Set_TotalDiscounts(Value: Double);
    { Methods & Properties }
    property Adr: Double read Get_Adr write Set_Adr;
    property Arrivals: Integer read Get_Arrivals write Set_Arrivals;
    property CheckedIn: Integer read Get_CheckedIn write Set_CheckedIn;
    property Date: TDateTime read Get_Date write Set_Date;
    property Departed: Integer read Get_Departed write Set_Departed;
    property Departures: Integer read Get_Departures write Set_Departures;
    property Guests: Integer read Get_Guests write Set_Guests;
    property MaxRate: Double read Get_MaxRate write Set_MaxRate;
    property MinRate: Double read Get_MinRate write Set_MinRate;
    property NoShow: Integer read Get_NoShow write Set_NoShow;
    property Occ: Double read Get_Occ write Set_Occ;
    property Occupied: Integer read Get_Occupied write Set_Occupied;
    property Ooo: Integer read Get_Ooo write Set_Ooo;
    property RevPar: Double read Get_RevPar write Set_RevPar;
    property Revenue: Double read Get_Revenue write Set_Revenue;
    property Rooms: Integer read Get_Rooms write Set_Rooms;
    property Sold: Integer read Get_Sold write Set_Sold;
    property TotalDiscounts: Double read Get_TotalDiscounts write Set_TotalDiscounts;
    property RoomsAndAvailabilities: IXMLDayType_roomsAndAvailabilities read Get_RoomsAndAvailabilities;
    property Channel: IXMLChannelTypeList read Get_Channel;
  end;

{ IXMLDayType_roomsAndAvailabilities }

  IXMLDayType_roomsAndAvailabilities = interface(IXMLNodeCollection)
    ['{7E57B42B-6868-4686-860D-9CF77C55C94F}']
    { Property Accessors }
    function Get_RoomType(Index: Integer): IXMLRoomTypeType;
    { Methods & Properties }
    function Add: IXMLRoomTypeType;
    function Insert(const Index: Integer): IXMLRoomTypeType;
    property RoomType[Index: Integer]: IXMLRoomTypeType read Get_RoomType; default;
  end;

{ IXMLRoomTypeType }

  IXMLRoomTypeType = interface(IXMLNode)
    ['{64BD3715-600E-4E58-8D1F-D49811C1EA5F}']
    { Property Accessors }
    function Get_Available: Integer;
    function Get_Rate: Double;
    function Get_RoomType: UnicodeString;
    function Get_TotalOccupied: Integer;
    function Get_TotalRooms: Integer;
    procedure Set_Available(Value: Integer);
    procedure Set_Rate(Value: Double);
    procedure Set_RoomType(Value: UnicodeString);
    procedure Set_TotalOccupied(Value: Integer);
    procedure Set_TotalRooms(Value: Integer);
    { Methods & Properties }
    property Available: Integer read Get_Available write Set_Available;
    property Rate: Double read Get_Rate write Set_Rate;
    property RoomType: UnicodeString read Get_RoomType write Set_RoomType;
    property TotalOccupied: Integer read Get_TotalOccupied write Set_TotalOccupied;
    property TotalRooms: Integer read Get_TotalRooms write Set_TotalRooms;
  end;

{ IXMLChannelType }

  IXMLChannelType = interface(IXMLNode)
    ['{6F6FD7C8-9FD2-4810-9655-0A18FED4E41B}']
    { Property Accessors }
    function Get_Adr: Double;
    function Get_ChannelColor: Integer;
    function Get_ChannelId: Integer;
    function Get_ChannelName: UnicodeString;
    function Get_Guests: Integer;
    function Get_MaxRate: Double;
    function Get_MinRate: Double;
    function Get_Occ: Double;
    function Get_RevPar: Double;
    function Get_Revenue: Double;
    function Get_Rooms: Integer;
    function Get_Sold: Integer;
    function Get_TotalDiscounts: Double;
    procedure Set_Adr(Value: Double);
    procedure Set_ChannelColor(Value: Integer);
    procedure Set_ChannelId(Value: Integer);
    procedure Set_ChannelName(Value: UnicodeString);
    procedure Set_Guests(Value: Integer);
    procedure Set_MaxRate(Value: Double);
    procedure Set_MinRate(Value: Double);
    procedure Set_Occ(Value: Double);
    procedure Set_RevPar(Value: Double);
    procedure Set_Revenue(Value: Double);
    procedure Set_Rooms(Value: Integer);
    procedure Set_Sold(Value: Integer);
    procedure Set_TotalDiscounts(Value: Double);
    { Methods & Properties }
    property Adr: Double read Get_Adr write Set_Adr;
    property ChannelColor: Integer read Get_ChannelColor write Set_ChannelColor;
    property ChannelId: Integer read Get_ChannelId write Set_ChannelId;
    property ChannelName: UnicodeString read Get_ChannelName write Set_ChannelName;
    property Guests: Integer read Get_Guests write Set_Guests;
    property MaxRate: Double read Get_MaxRate write Set_MaxRate;
    property MinRate: Double read Get_MinRate write Set_MinRate;
    property Occ: Double read Get_Occ write Set_Occ;
    property RevPar: Double read Get_RevPar write Set_RevPar;
    property Revenue: Double read Get_Revenue write Set_Revenue;
    property Rooms: Integer read Get_Rooms write Set_Rooms;
    property Sold: Integer read Get_Sold write Set_Sold;
    property TotalDiscounts: Double read Get_TotalDiscounts write Set_TotalDiscounts;
  end;

{ IXMLChannelTypeList }

  IXMLChannelTypeList = interface(IXMLNodeCollection)
    ['{D3492BC1-DCBF-48CD-ABF8-8399CB3C49E1}']
    { Methods & Properties }
    function Add: IXMLChannelType;
    function Insert(const Index: Integer): IXMLChannelType;

    function Get_Item(Index: Integer): IXMLChannelType;
    property Items[Index: Integer]: IXMLChannelType read Get_Item; default;
  end;

{ IXMLRoomsAndAvailabilitiesType }

  IXMLRoomsAndAvailabilitiesType = interface(IXMLNodeCollection)
    ['{BB2D87FE-8D32-4266-A030-AA20A3B8CC7E}']
    { Property Accessors }
    function Get_RoomType(Index: Integer): IXMLRoomTypeType;
    { Methods & Properties }
    function Add: IXMLRoomTypeType;
    function Insert(const Index: Integer): IXMLRoomTypeType;
    property RoomType[Index: Integer]: IXMLRoomTypeType read Get_RoomType; default;
  end;

{ Forward Decls }

  TXMLPerformanceType = class;
  TXMLDayType = class;
  TXMLDayType_roomsAndAvailabilities = class;
  TXMLRoomTypeType = class;
  TXMLChannelType = class;
  TXMLChannelTypeList = class;
  TXMLRoomsAndAvailabilitiesType = class;

{ TXMLPerformanceType }

  TXMLPerformanceType = class(TXMLNodeCollection, IXMLPerformanceType)
  protected
    { IXMLPerformanceType }
    function Get_Currency: UnicodeString;
    function Get_EndDate: TDateTime;
    function Get_StartDate: TDateTime;
    function Get_Day(Index: Integer): IXMLDayType;
    procedure Set_Currency(Value: UnicodeString);
    procedure Set_EndDate(Value: TDateTime);
    procedure Set_StartDate(Value: TDateTime);
    function Add: IXMLDayType;
    function Insert(const Index: Integer): IXMLDayType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDayType }

  TXMLDayType = class(TXMLNode, IXMLDayType)
  private
    FChannel: IXMLChannelTypeList;
  protected
    { IXMLDayType }
    function Get_Adr: Double;
    function Get_Arrivals: Integer;
    function Get_CheckedIn: Integer;
    function Get_Date: TDateTime;
    function Get_Departed: Integer;
    function Get_Departures: Integer;
    function Get_Guests: Integer;
    function Get_MaxRate: Double;
    function Get_MinRate: Double;
    function Get_NoShow: Integer;
    function Get_Occ: Double;
    function Get_Occupied: Integer;
    function Get_Ooo: Integer;
    function Get_RevPar: Double;
    function Get_Revenue: Double;
    function Get_Rooms: Integer;
    function Get_Sold: Integer;
    function Get_TotalDiscounts: Double;
    function Get_RoomsAndAvailabilities: IXMLDayType_roomsAndAvailabilities;
    function Get_Channel: IXMLChannelTypeList;
    procedure Set_Adr(Value: Double);
    procedure Set_Arrivals(Value: Integer);
    procedure Set_CheckedIn(Value: Integer);
    procedure Set_Date(Value: TDateTime);
    procedure Set_Departed(Value: Integer);
    procedure Set_Departures(Value: Integer);
    procedure Set_Guests(Value: Integer);
    procedure Set_MaxRate(Value: Double);
    procedure Set_MinRate(Value: Double);
    procedure Set_NoShow(Value: Integer);
    procedure Set_Occ(Value: Double);
    procedure Set_Occupied(Value: Integer);
    procedure Set_Ooo(Value: Integer);
    procedure Set_RevPar(Value: Double);
    procedure Set_Revenue(Value: Double);
    procedure Set_Rooms(Value: Integer);
    procedure Set_Sold(Value: Integer);
    procedure Set_TotalDiscounts(Value: Double);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDayType_roomsAndAvailabilities }

  TXMLDayType_roomsAndAvailabilities = class(TXMLNodeCollection, IXMLDayType_roomsAndAvailabilities)
  protected
    { IXMLDayType_roomsAndAvailabilities }
    function Get_RoomType(Index: Integer): IXMLRoomTypeType;
    function Add: IXMLRoomTypeType;
    function Insert(const Index: Integer): IXMLRoomTypeType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRoomTypeType }

  TXMLRoomTypeType = class(TXMLNode, IXMLRoomTypeType)
  protected
    { IXMLRoomTypeType }
    function Get_Available: Integer;
    function Get_Rate: Double;
    function Get_RoomType: UnicodeString;
    function Get_TotalOccupied: Integer;
    function Get_TotalRooms: Integer;
    procedure Set_Available(Value: Integer);
    procedure Set_Rate(Value: Double);
    procedure Set_RoomType(Value: UnicodeString);
    procedure Set_TotalOccupied(Value: Integer);
    procedure Set_TotalRooms(Value: Integer);
  end;

{ TXMLChannelType }

  TXMLChannelType = class(TXMLNode, IXMLChannelType)
  protected
    { IXMLChannelType }
    function Get_Adr: Double;
    function Get_ChannelColor: Integer;
    function Get_ChannelId: Integer;
    function Get_ChannelName: UnicodeString;
    function Get_Guests: Integer;
    function Get_MaxRate: Double;
    function Get_MinRate: Double;
    function Get_Occ: Double;
    function Get_RevPar: Double;
    function Get_Revenue: Double;
    function Get_Rooms: Integer;
    function Get_Sold: Integer;
    function Get_TotalDiscounts: Double;
    procedure Set_Adr(Value: Double);
    procedure Set_ChannelColor(Value: Integer);
    procedure Set_ChannelId(Value: Integer);
    procedure Set_ChannelName(Value: UnicodeString);
    procedure Set_Guests(Value: Integer);
    procedure Set_MaxRate(Value: Double);
    procedure Set_MinRate(Value: Double);
    procedure Set_Occ(Value: Double);
    procedure Set_RevPar(Value: Double);
    procedure Set_Revenue(Value: Double);
    procedure Set_Rooms(Value: Integer);
    procedure Set_Sold(Value: Integer);
    procedure Set_TotalDiscounts(Value: Double);
  end;

{ TXMLChannelTypeList }

  TXMLChannelTypeList = class(TXMLNodeCollection, IXMLChannelTypeList)
  protected
    { IXMLChannelTypeList }
    function Add: IXMLChannelType;
    function Insert(const Index: Integer): IXMLChannelType;

    function Get_Item(Index: Integer): IXMLChannelType;
  end;

{ TXMLRoomsAndAvailabilitiesType }

  TXMLRoomsAndAvailabilitiesType = class(TXMLNodeCollection, IXMLRoomsAndAvailabilitiesType)
  protected
    { IXMLRoomsAndAvailabilitiesType }
    function Get_RoomType(Index: Integer): IXMLRoomTypeType;
    function Add: IXMLRoomTypeType;
    function Insert(const Index: Integer): IXMLRoomTypeType;
  public
    procedure AfterConstruction; override;
  end;

{ Global Functions }

function Getperformance(Doc: IXMLDocument): IXMLPerformanceType;
function Loadperformance(const FileName: string): IXMLPerformanceType;
function Newperformance: IXMLPerformanceType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getperformance(Doc: IXMLDocument): IXMLPerformanceType;
begin
  Result := Doc.GetDocBinding('performance', TXMLPerformanceType, TargetNamespace) as IXMLPerformanceType;
end;

function Loadperformance(const FileName: string): IXMLPerformanceType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('performance', TXMLPerformanceType, TargetNamespace) as IXMLPerformanceType;
end;

function Newperformance: IXMLPerformanceType;
begin
  Result := NewXMLDocument.GetDocBinding('performance', TXMLPerformanceType, TargetNamespace) as IXMLPerformanceType;
end;

{ TXMLPerformanceType }

procedure TXMLPerformanceType.AfterConstruction;
begin
  RegisterChildNode('day', TXMLDayType);
  ItemTag := 'day';
  ItemInterface := IXMLDayType;
  inherited;
end;

function TXMLPerformanceType.Get_Currency: UnicodeString;
begin
  Result := AttributeNodes['currency'].Text;
end;

procedure TXMLPerformanceType.Set_Currency(Value: UnicodeString);
begin
  SetAttribute('currency', Value);
end;

function TXMLPerformanceType.Get_EndDate: TDateTime;
begin
  Result := VarToDateTime(AttributeNodes['endDate'].NodeValue);
end;

procedure TXMLPerformanceType.Set_EndDate(Value: TDateTime);
begin
  SetAttribute('endDate', Value);
end;

function TXMLPerformanceType.Get_StartDate: TDateTime;
begin
  Result := VarToDateTime(AttributeNodes['startDate'].NodeValue);
end;

procedure TXMLPerformanceType.Set_StartDate(Value: TDateTime);
begin
  SetAttribute('startDate', Value);
end;

function TXMLPerformanceType.Get_Day(Index: Integer): IXMLDayType;
begin
  Result := List[Index] as IXMLDayType;
end;

function TXMLPerformanceType.Add: IXMLDayType;
begin
  Result := AddItem(-1) as IXMLDayType;
end;

function TXMLPerformanceType.Insert(const Index: Integer): IXMLDayType;
begin
  Result := AddItem(Index) as IXMLDayType;
end;

{ TXMLDayType }

procedure TXMLDayType.AfterConstruction;
begin
  RegisterChildNode('roomsAndAvailabilities', TXMLDayType_roomsAndAvailabilities);
  RegisterChildNode('channel', TXMLChannelType);
  FChannel := CreateCollection(TXMLChannelTypeList, IXMLChannelType, 'channel') as IXMLChannelTypeList;
  inherited;
end;

function TXMLDayType.Get_Adr: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['adr'].NodeValue);
end;

procedure TXMLDayType.Set_Adr(Value: Double);
begin
  SetAttribute('adr', Value);
end;

function TXMLDayType.Get_Arrivals: Integer;
begin
  Result := AttributeNodes['arrivals'].NodeValue;
end;

procedure TXMLDayType.Set_Arrivals(Value: Integer);
begin
  SetAttribute('arrivals', Value);
end;

function TXMLDayType.Get_CheckedIn: Integer;
begin
  Result := AttributeNodes['checkedIn'].NodeValue;
end;

procedure TXMLDayType.Set_CheckedIn(Value: Integer);
begin
  SetAttribute('checkedIn', Value);
end;

function TXMLDayType.Get_Date: TDateTime;
begin
  Result := VarToDateTime(AttributeNodes['date'].NodeValue);
end;

procedure TXMLDayType.Set_Date(Value: TDateTime);
begin
  SetAttribute('date', Value);
end;

function TXMLDayType.Get_Departed: Integer;
begin
  Result := AttributeNodes['departed'].NodeValue;
end;

procedure TXMLDayType.Set_Departed(Value: Integer);
begin
  SetAttribute('departed', Value);
end;

function TXMLDayType.Get_Departures: Integer;
begin
  Result := AttributeNodes['departures'].NodeValue;
end;

procedure TXMLDayType.Set_Departures(Value: Integer);
begin
  SetAttribute('departures', Value);
end;

function TXMLDayType.Get_Guests: Integer;
begin
  Result := AttributeNodes['guests'].NodeValue;
end;

procedure TXMLDayType.Set_Guests(Value: Integer);
begin
  SetAttribute('guests', Value);
end;

function TXMLDayType.Get_MaxRate: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['maxRate'].NodeValue);
end;

procedure TXMLDayType.Set_MaxRate(Value: Double);
begin
  SetAttribute('maxRate', Value);
end;

function TXMLDayType.Get_MinRate: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['minRate'].NodeValue);
end;

procedure TXMLDayType.Set_MinRate(Value: Double);
begin
  SetAttribute('minRate', Value);
end;

function TXMLDayType.Get_NoShow: Integer;
begin
  Result := AttributeNodes['noShow'].NodeValue;
end;

procedure TXMLDayType.Set_NoShow(Value: Integer);
begin
  SetAttribute('noShow', Value);
end;

function TXMLDayType.Get_Occ: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['occ'].NodeValue);
end;

procedure TXMLDayType.Set_Occ(Value: Double);
begin
  SetAttribute('occ', Value);
end;

function TXMLDayType.Get_Occupied: Integer;
begin
  Result := AttributeNodes['occupied'].NodeValue;
end;

procedure TXMLDayType.Set_Occupied(Value: Integer);
begin
  SetAttribute('occupied', Value);
end;

function TXMLDayType.Get_Ooo: Integer;
begin
  Result := AttributeNodes['ooo'].NodeValue;
end;

procedure TXMLDayType.Set_Ooo(Value: Integer);
begin
  SetAttribute('ooo', Value);
end;

function TXMLDayType.Get_RevPar: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['revPar'].NodeValue);
end;

procedure TXMLDayType.Set_RevPar(Value: Double);
begin
  SetAttribute('revPar', Value);
end;

function TXMLDayType.Get_Revenue: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['revenue'].NodeValue);
end;

procedure TXMLDayType.Set_Revenue(Value: Double);
begin
  SetAttribute('revenue', Value);
end;

function TXMLDayType.Get_Rooms: Integer;
begin
  Result := AttributeNodes['rooms'].NodeValue;
end;

procedure TXMLDayType.Set_Rooms(Value: Integer);
begin
  SetAttribute('rooms', Value);
end;

function TXMLDayType.Get_Sold: Integer;
begin
  Result := AttributeNodes['sold'].NodeValue;
end;

procedure TXMLDayType.Set_Sold(Value: Integer);
begin
  SetAttribute('sold', Value);
end;

function TXMLDayType.Get_TotalDiscounts: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['totalDiscounts'].NodeValue);
end;

procedure TXMLDayType.Set_TotalDiscounts(Value: Double);
begin
  SetAttribute('totalDiscounts', Value);
end;

function TXMLDayType.Get_RoomsAndAvailabilities: IXMLDayType_roomsAndAvailabilities;
begin
  Result := ChildNodes['roomsAndAvailabilities'] as IXMLDayType_roomsAndAvailabilities;
end;

function TXMLDayType.Get_Channel: IXMLChannelTypeList;
begin
  Result := FChannel;
end;

{ TXMLDayType_roomsAndAvailabilities }

procedure TXMLDayType_roomsAndAvailabilities.AfterConstruction;
begin
  RegisterChildNode('roomType', TXMLRoomTypeType);
  ItemTag := 'roomType';
  ItemInterface := IXMLRoomTypeType;
  inherited;
end;

function TXMLDayType_roomsAndAvailabilities.Get_RoomType(Index: Integer): IXMLRoomTypeType;
begin
  Result := List[Index] as IXMLRoomTypeType;
end;

function TXMLDayType_roomsAndAvailabilities.Add: IXMLRoomTypeType;
begin
  Result := AddItem(-1) as IXMLRoomTypeType;
end;

function TXMLDayType_roomsAndAvailabilities.Insert(const Index: Integer): IXMLRoomTypeType;
begin
  Result := AddItem(Index) as IXMLRoomTypeType;
end;

{ TXMLRoomTypeType }

function TXMLRoomTypeType.Get_Available: Integer;
begin
  Result := AttributeNodes['available'].NodeValue;
end;

procedure TXMLRoomTypeType.Set_Available(Value: Integer);
begin
  SetAttribute('available', Value);
end;

function TXMLRoomTypeType.Get_Rate: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['rate'].NodeValue);
end;

procedure TXMLRoomTypeType.Set_Rate(Value: Double);
begin
  SetAttribute('rate', Value);
end;

function TXMLRoomTypeType.Get_RoomType: UnicodeString;
begin
  Result := AttributeNodes['roomType'].Text;
end;

procedure TXMLRoomTypeType.Set_RoomType(Value: UnicodeString);
begin
  SetAttribute('roomType', Value);
end;

function TXMLRoomTypeType.Get_TotalOccupied: Integer;
begin
  Result := AttributeNodes['totalOccupied'].NodeValue;
end;

procedure TXMLRoomTypeType.Set_TotalOccupied(Value: Integer);
begin
  SetAttribute('totalOccupied', Value);
end;

function TXMLRoomTypeType.Get_TotalRooms: Integer;
begin
  Result := AttributeNodes['totalRooms'].NodeValue;
end;

procedure TXMLRoomTypeType.Set_TotalRooms(Value: Integer);
begin
  SetAttribute('totalRooms', Value);
end;

{ TXMLChannelType }

function TXMLChannelType.Get_Adr: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['adr'].NodeValue);
end;

procedure TXMLChannelType.Set_Adr(Value: Double);
begin
  SetAttribute('adr', Value);
end;

function TXMLChannelType.Get_ChannelColor: Integer;
begin
  Result := AttributeNodes['channelColor'].NodeValue;
end;

procedure TXMLChannelType.Set_ChannelColor(Value: Integer);
begin
  SetAttribute('channelColor', Value);
end;

function TXMLChannelType.Get_ChannelId: Integer;
begin
  Result := AttributeNodes['channelId'].NodeValue;
end;

procedure TXMLChannelType.Set_ChannelId(Value: Integer);
begin
  SetAttribute('channelId', Value);
end;

function TXMLChannelType.Get_ChannelName: UnicodeString;
begin
  Result := AttributeNodes['channelName'].Text;
end;

procedure TXMLChannelType.Set_ChannelName(Value: UnicodeString);
begin
  SetAttribute('channelName', Value);
end;

function TXMLChannelType.Get_Guests: Integer;
begin
  Result := AttributeNodes['guests'].NodeValue;
end;

procedure TXMLChannelType.Set_Guests(Value: Integer);
begin
  SetAttribute('guests', Value);
end;

function TXMLChannelType.Get_MaxRate: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['maxRate'].NodeValue);
end;

procedure TXMLChannelType.Set_MaxRate(Value: Double);
begin
  SetAttribute('maxRate', Value);
end;

function TXMLChannelType.Get_MinRate: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['minRate'].NodeValue);
end;

procedure TXMLChannelType.Set_MinRate(Value: Double);
begin
  SetAttribute('minRate', Value);
end;

function TXMLChannelType.Get_Occ: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['occ'].NodeValue);
end;

procedure TXMLChannelType.Set_Occ(Value: Double);
begin
  SetAttribute('occ', Value);
end;

function TXMLChannelType.Get_RevPar: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['revPar'].NodeValue);
end;

procedure TXMLChannelType.Set_RevPar(Value: Double);
begin
  SetAttribute('revPar', Value);
end;

function TXMLChannelType.Get_Revenue: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['revenue'].NodeValue);
end;

procedure TXMLChannelType.Set_Revenue(Value: Double);
begin
  SetAttribute('revenue', Value);
end;

function TXMLChannelType.Get_Rooms: Integer;
begin
  Result := AttributeNodes['rooms'].NodeValue;
end;

procedure TXMLChannelType.Set_Rooms(Value: Integer);
begin
  SetAttribute('rooms', Value);
end;

function TXMLChannelType.Get_Sold: Integer;
begin
  Result := AttributeNodes['sold'].NodeValue;
end;

procedure TXMLChannelType.Set_Sold(Value: Integer);
begin
  SetAttribute('sold', Value);
end;

function TXMLChannelType.Get_TotalDiscounts: Double;
begin
  Result := RoomerStrToFloat(AttributeNodes['totalDiscounts'].NodeValue);
end;

procedure TXMLChannelType.Set_TotalDiscounts(Value: Double);
begin
  SetAttribute('totalDiscounts', Value);
end;

{ TXMLChannelTypeList }

function TXMLChannelTypeList.Add: IXMLChannelType;
begin
  Result := AddItem(-1) as IXMLChannelType;
end;

function TXMLChannelTypeList.Insert(const Index: Integer): IXMLChannelType;
begin
  Result := AddItem(Index) as IXMLChannelType;
end;

function TXMLChannelTypeList.Get_Item(Index: Integer): IXMLChannelType;
begin
  Result := List[Index] as IXMLChannelType;
end;

{ TXMLRoomsAndAvailabilitiesType }

procedure TXMLRoomsAndAvailabilitiesType.AfterConstruction;
begin
  RegisterChildNode('roomType', TXMLRoomTypeType);
  ItemTag := 'roomType';
  ItemInterface := IXMLRoomTypeType;
  inherited;
end;

function TXMLRoomsAndAvailabilitiesType.Get_RoomType(Index: Integer): IXMLRoomTypeType;
begin
  Result := List[Index] as IXMLRoomTypeType;
end;

function TXMLRoomsAndAvailabilitiesType.Add: IXMLRoomTypeType;
begin
  Result := AddItem(-1) as IXMLRoomTypeType;
end;

function TXMLRoomsAndAvailabilitiesType.Insert(const Index: Integer): IXMLRoomTypeType;
begin
  Result := AddItem(Index) as IXMLRoomTypeType;
end;

end.