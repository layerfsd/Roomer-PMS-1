unit uAvailability;

interface
uses
    Classes
  , windows
  , uAppGlobal
  , ADODB
  , dbTables
  , DB
  , SysUtils
  , dialogs
  , _glob
  , ug
  , ud

  , cmpRoomerDataSet
  , cmpRoomerConnection
  , uUtils
  ;

Type

{$M+}
  TDataCollection = class( TObject )
  private
    FRoomType : string;
    FUsed     : integer;
    FNumber   : integer;
  public
    constructor Create( RoomType : String );
    destructor Destroy; override;
  published
    property RoomType : string    read FRoomType;
    property Used     : integer   read FUsed write FUsed;
    property Number   : integer   read FNumber;
  end;
{$M-}


  TAvailability = class( TObject )
  private
    FDateFrom,
    FDateTo    : TDateTime;

    FData      : TList;

    function GetNumItems : integer;
    function GetDataByType( RoomType : string ) : TDataCollection;
    function GetItems( idx : integer ) : TDataCollection;

    procedure LoadData;

  public
    constructor Create( dtFrom, dtTo : TDateTime );
    destructor Destroy; override;

    procedure Clear;
    function NumAvailable( RoomType : string ) : integer;

    property NumItems : integer read GetNumItems;
    property Items[ idx : integer ] : TDataCollection read GetItems;
    property DataByType[ RoomType : string ] : TDataCollection read GetDataByType;
  end;

procedure InitTypeAvailabilities( dtArrival, dtDeparture : TDateTime );
function GetTypeAvailabilities( sType : string ) : integer;

implementation

uses
    uSqlDefinitions
  , hData
  , uRoomerDefinitions
  , uReservationStateDefinitions
  ;

{ TDataCollection }

constructor TDataCollection.Create(RoomType : String);
begin
   inherited Create;
   FRoomType := RoomType;
end;

destructor TDataCollection.Destroy;
begin
  inherited;
end;


{ TAvailability }

constructor TAvailability.Create( dtFrom, dtTo : TDateTime );
begin
  inherited Create;
  FDateFrom  := dtFrom;
  FDateTo    := dtTo;
  FData      := TList.create;
  LoadData;
end;

destructor TAvailability.Destroy;
begin
  // --
  Clear;
  FData.free;
  // --
  inherited;
end;

procedure TAvailability.Clear;
var
  i : integer;
begin
  // --
  for i := FData.count - 1 downto 0 do
  begin
    TDataCollection( FData[ i ] ).free;
    FData.delete( i );
  end;
end;

function TAvailability.GetNumItems : integer;
begin
  // --
  result := FData.count;
end;

function TAvailability.GetItems(idx : integer) : TDataCollection;
begin
  // --
  result := TDataCollection(FData[idx] );
end;

function TAvailability.GetDataByType( RoomType : string ) : TDataCollection;
var i : integer;
begin
  // --
  result := nil;
  for i := 0 to NumItems - 1 do
  begin
    if Items[i].RoomType = RoomType then
    begin
      result := Items[ i ];
      break;
    end;
  end;
end;

function TAvailability.NumAvailable( RoomType : string ) : integer;
var
  aDataCollection : TDataCollection;
begin
  // --
  result := 0;
  aDataCollection := DataByType[RoomType];
  if aDataCollection = nil then exit;

  result := aDataCollection.FNumber - aDataCollection.FUsed;
end;

procedure TAvailability.LoadData;
var
  rSet : TRoomerDataSet;

  aDataCollection : TDataCollection;
  i               : integer;

  ALastDate,
  ALastRoomType   : string;
  iCount          : integer;

  s : string;
  sql : string;

begin
  // --
  for i := 0 to glb.RoomTypeCount - 1 do
  begin
    aDataCollection := TDataCollection.create(glb.GetRoomType(i));
    aDataCollection.FNumber := glb.GetNumberOfItems(aDataCollection.FRoomType );
    aDataCollection.FUsed := 0;
    FData.add( aDataCollection );
  end;

  rSet := CreateNewDataSet;
  try
    
    rSet.CommandType := cmdText;

    sql:=
    'SELECT RoomType, ADate, ResFlag from roomsdate '+
    ' where (ADate >= %s '+
    '   and ADate < %s )'+
    '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj bætt við
    ' ORDER BY ADate, RoomType ' ;

    s := format(sql , [_DatetoDBDate(FDateFrom,true),_DatetoDBDate(FDateTo,true) ]);
    hData.rSet_bySQL(rSet,s);

    with rSet do
    begin
      first;
      ALastDate := '';
      ALastRoomType := '';
      iCount := 0;
      while not eof do
      begin
        //**zxhj Breytti ekkert hér ?????????
        if ( trim( fieldByName('ResFlag').asString ) <> 'C' )  and
           ( trim( fieldByName( 'ResFlag' ).asString ) <> 'N' ) then
        begin

          // --
          if ( ( ALastDate <> trim( fieldByName( 'ADate' ).asString ) ) or
            ( ALastRoomType <> trim( fieldByName( 'RoomType' ).asString ) ) ) and
              ( ( ALastDate <> '' ) and
                ( ALastRoomType <> '' ) ) then
          begin
            // --
            aDataCollection := DataByType[ALastRoomType];

            if aDataCollection <> nil then
            begin
              if aDataCollection.FUsed < iCount then
                aDataCollection.FUsed := iCount;
            end;

            iCount := 0;
          end;
          // --
          inc(iCount);

          // --
          ALastRoomType := trim( fieldByName( 'RoomType' ).asString );
          ALastDate     := trim( fieldByName( 'ADate' ).asString );
        end;

        // --
        next;
        // --
        if eof then
        begin
          // --
          aDataCollection := DataByType[ALastRoomType];

          if aDataCollection <> nil then
          begin
            if aDataCollection.FUsed < iCount then
              aDataCollection.FUsed := iCount;
          end;
        end;
      end;
    end;

  finally
    freeandnil(rSet);
  end;
end;


function isNoRoom(s : string) : boolean;
begin
  result := false;
  if length(s) < 1 then exit;
  result := copy(trim(s),1,1) = '<';
end;

procedure InitTypeAvailabilities( dtArrival, dtDeparture : TDateTime );
var
  i    : integer;
  rSet      : TRoomerDataSet;
  sLastRoom : string;

  function CheckNonRooms(SType : string ) : integer;
  var
    i,
    l,
    iMax : integer;
  begin
    // --
    iMax := 0;
    for i := trunc( dtArrival ) to trunc( dtDeparture ) - 1 do
    begin
      rSet.Filtered := false;
      rSet.Filter := 'RoomType=' + quotedStr( sType ) + ' and ' +
                           'ADate=' + _DateToDBDate( i ,true );
      rSet.Filtered := true;
      try
        with rSet do
        begin
          l := 0;
          first;
          while not eof do
          begin
            //**zxhj  breytti ekki hér
            if ((trim( fieldByName( 'ResFlag' ).asString ) <> 'N') and (trim( fieldByName( 'ResFlag' ).asString ) <> 'N')) then inc( l );
            next;
          end;
          if l > iMax then iMax := l;
        end;
      finally
        rSet.Filtered := false;
      end;
    end;
    result := iMax;
  end;

var
  s : string;
  sql : string;
begin
  // Öll herbergin
  glb.InitAvailability;

  rSet := CreateNewDataSet;
  try
    
    rSet.CommandType := cmdText;

    sql:=
    'SELECT Room, RoomType, ADate, ResFlag from roomsdate '+
    ' WHERE (ADate >= %s '+
    '   and ADate < %s) '+
    '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj bætti við
    ' ORDER BY Room, ADate, RoomType ' ;

    s := format(sql, [_DatetoDBDate(dtArrival,true),_DatetoDBDate(dtDeparture,true)]);
    hData.rSet_bySQL(rSet,s);

    sLastRoom := '<None Yet>';

    with rSet do
    begin
      first;
      while not eof do
      begin
        if trim( fieldByName( 'ResFlag' ).asString ) <> 'N' then
        if copy( trim( fieldByName( 'Room' ).asString ), 1, 1 ) <> '<' then
        begin
          if sLastRoom <> trim( fieldByName( 'Room' ).asString ) then
          begin
            sLastRoom := trim( fieldByName( 'Room' ).asString );

            glb.NumAvailType.Values[ trim( fieldByName( 'RoomType' ).asString ) ] :=
                 inttostr(strtointdef(glb.NumAvailType.Values[trim(fieldByName('RoomType').asString)],0)-1);

          end;
        end;
        next;
      end;
    end;

//    //<Roomsdate>SELECT
//    s := '';
//    s := s+ 'select Room, RoomType, ADate, ResFlag from [RoomsDate]' ;
//    s := s+ ' where ADate >= ' + _DatetoDBDate(dtArrival,true) ;
//    s := s+ '   and ADate < ' + _DatetoDBDate(dtDeparture,true) ;
//    s := s+ '   and Room >= ' + QuotedStr( '<' ) ;
//    s := s+ '   and Room < ' + QuotedStr( '>' ) ;
//    s := s+ ' ORDER BY Room, ADate, RoomType' ;
//
//    s := format(select_InitTypeAvailabilities2 , [_DatetoDBDate(dtArrival,true),_DatetoDBDate(dtDeparture,true)]);
//    CopyToClipboard(s);
//    DebugMessage('select_InitTypeAvailabilities2'#10#10+s);
//    hData.rSet_bySQL(rSet,s);


    for i := 0 to glb.NumAvailType.count - 1 do
    begin
      glb.NumAvailType.Values[ glb.NumAvailType.Names[ i ] ] :=
          inttostr(strtointdef(glb.NumAvailType.Values[glb.NumAvailType.Names[i]],0)-
      CheckNonRooms(glb.NumAvailType.Names[i]));
    end;
  finally
    freeandnil(rSet);
  end;
end;

function GetTypeAvailabilities( sType : string ) : integer;
begin
  result := strtointdef(glb.NumAvailType.Values[ sType ], 0 );
end;

end.
