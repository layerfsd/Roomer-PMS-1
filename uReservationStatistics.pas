unit uReservationStatistics;

interface
uses   uAdo
     , uAdoDataset
     , uAppGlobal
     , Windows
     , SysUtils
     , StdCtrls
     , classes
     , Controls
     , Dialogs
     , dbTables
     , uDB2DateTimeFunctions;

Type

   TReservationType = class( Tobject )
   private
     // --
      FRoomType   : string;
      FAvailableBeds  : integer;
      FOccupiedRooms   : integer;
      FAvailableRooms  : integer;
      FOccupiedBeds   : integer;
   public
     // --
      constructor Create( TheType : string );
      destructor Destroy; override;
   published
     // --
      property RoomType        : string   read FRoomType       write FRoomType;
      property AvailableBeds   : integer  read FAvailableBeds  write FAvailableBeds;
      property OccupiedRooms   : integer  read FOccupiedRooms  write FOccupiedRooms;
      property AvailableRooms  : integer  read FAvailableRooms write FAvailableRooms;
      property OccupiedBeds    : integer  read FOccupiedBeds   write FOccupiedBeds;
   end;


  // --
   TReservationDate = class( Tobject )
   private
     // --
      FADate      : TDate;
      FRoomTypes  : TList;
      function GetCount : integer;
   public
     // --
      constructor Create( TheDate : TDate );
      destructor Destroy; override;

     // --
      procedure Clear;
      procedure AddToDateAndType( aDate : TDate; aType : string; NumBeds, NumRooms : integer );
   published
     // --
      property count : integer read GetCount;
   end;

  // --
   TReservationStatistics = class( Tobject )
   private
     // --
      FFromDate      : TDate;
      FToDate        : TDate;

      FDates         : TList;

      FAdoDataSet    : TRoomerDataSet;
      function GetCount : integer;
      function GetItemFunc( dDate : TDate; sType : string ) : integer;
      function GetItemBedsFunc( dDate : TDate; sType : string ) : integer;
      function GetAvailableBedsFunc( dDate : TDate; sType : string ) : integer;
      function GetAvailableFunc( dDate : TDate; sType : string ) : integer;
      function FindDateAndType( dDate : TDate; sType : string ) : TPoint;
   public
     // --
      constructor Create( FromDate, ToDate : TDate );
      destructor Destroy; override;

     // --
      procedure Clear;
      property Available[ dDate : TDate; sType : string ] : integer read GetAvailableFunc;
      property AvailableBeds[ dDate : TDate; sType : string ] : integer read GetAvailableBedsFunc;
      property Occupied[ dDate : TDate; sType : string ] : integer read GetItemFunc;
      property OccupiedBeds[ dDate : TDate; sType : string ] : integer read GetItemBedsFunc;
   published
     // --
      property Items  : TList read FDates;

      property Count  : integer read GetCount;
   end;

implementation

{ TReservationType }

constructor TReservationType.Create( TheType : string );
begin
  // --
   inherited create;
   FRoomType   := TheType;

   FAvailableBeds  := 0;
   FOccupiedRooms  := 0;
   FAvailableRooms := 0;
   FOccupiedBeds   := 0;
end;

destructor TReservationType.Destroy;
begin
  // --
   inherited destroy;
end;


// ------------

{ TReservationDate }

constructor TReservationDate.Create( TheDate : TDate );
begin
  // --
   inherited create;
   FADate := TheDate;
   FRoomTypes := TList.create;
end;

destructor TReservationDate.Destroy;
begin
  // --
   clear;
   FRoomTypes.free;
   inherited destroy;
end;

procedure TReservationDate.AddToDateAndType( aDate : TDate; aType : string; NumBeds, NumRooms : integer );
var ReservationType : TReservationType;
begin
  // --
   ReservationType := TReservationType.Create( aType );
   ReservationType.FOccupiedRooms := NumRooms;
   ReservationType.FOccupiedBeds  := NumBeds;
   FRoomTypes.Add( ReservationType );
end;

procedure TReservationDate.Clear;
var i : integer;
begin
  // --
   for i := FRoomTypes.count - 1 downto 0 do begin
      TReservationType( FRoomTypes[ i ] ).free;
      FRoomTypes.delete( i );
   end;
end;

function TReservationDate.GetCount : integer;
begin
  // --
   result := FRoomTypes.count;
end;

// ------------


{ TReservationStatistics }

constructor TReservationStatistics.Create( FromDate, ToDate : TDate );
var qry : TQuery;
    ReservationDate : TReservationDate;
begin
  // --
   inherited create;
   FFromDate := FromDate;
   FToDate   := ToDate;
   FDates    := TList.create;
   qry := TQuery.create( nil );
   try

      //SQL 400 Select StatisticsRoomTypes
      qry.sql.clear;
      qry.sql.Add( 'select * from ' + glb.SQLQuote + 'StatisticsRoomTypes' + glb.SQLQuote1 );
      qry.sql.Add( 'where ADate >= ''' + MyDateToDBStr( FromDate ) + '''' );
      qry.sql.Add( '  and ADate <  ''' + MyDateToDBStr( ToDate   ) + '''' );
     // ShowMessage( qry.sql.text );
      FAdoDataSet := glb.AppAdo.Execute( qry );
      with FAdoDataSet do begin
         first;
         while not eof do begin
            ReservationDate := TReservationDate.Create( MyDBStrToDate( FAdoDataSet.FieldByName( 'ADate' ).AsString ) );
            ReservationDate.AddToDateAndType( MyDBStrToDate( FAdoDataSet.FieldByName( 'ADate' ).AsString ),
                                              FAdoDataSet.FieldByName( 'RoomType' ).AsString,
                                              FAdoDataSet.FieldByName( 'NumBeds' ).AsInteger,
                                              FAdoDataSet.FieldByName( 'NumRooms' ).AsInteger
                                            );

            FDates.add( ReservationDate );
            next;
         end;
      end;
   finally
      qry.free;
      if Assigned( FAdoDataSet ) then begin
         FAdoDataSet.free;
         FAdoDataSet := nil;
      end;
   end;
end;

destructor TReservationStatistics.Destroy;
begin
  // --
   clear;
   FDates.free;
   inherited destroy;
end;

procedure TReservationStatistics.Clear;
var i : integer;
begin
  // --
   for i := FDates.count - 1 downto 0 do begin
      TReservationDate( FDates[ i ] ).free;
      FDates.delete( i );
   end;
end;

function TReservationStatistics.GetCount : integer;
begin
  // --
   result := FDates.count;
end;

function TReservationStatistics.FindDateAndType( dDate : TDate; sType : string ) : TPoint;
var i, l : integer;
    aPoint : TPoint;
begin
  // --
   aPoint.X := -1;
   aPoint.Y := -1;
   for i := 0 to count - 1 do
      if TReservationDate( FDates[ i ] ).FADate = dDate then begin
         for l := 0 to TReservationDate( FDates[ i ] ).count - 1 do begin
             if TReservationType( TReservationDate( FDates[ i ] ).FRoomTypes[ l ] ).FRoomType = sType then begin
                aPoint.X := i;
                aPoint.Y := l;
                Break;
             end;
         end;
         if aPoint.X <> -1 then
            break;
      end;
   result := aPoint;
end;

function TReservationStatistics.GetItemFunc( dDate : TDate; sType : string ) : integer;
var i, l : integer;
    aPoint : TPoint;
begin
  //--
   aPoint := FindDateAndType( dDate, sType );
   if aPoint.X <> -1 then
      result := 0
   else begin
      i := aPoint.X;
      l := aPoint.Y;
      result := TReservationType( TReservationDate( FDates[ i ] ).FRoomTypes[ l ] ).FOccupiedRooms;
   end;
end;

function TReservationStatistics.GetItemBedsFunc( dDate : TDate; sType : string ) : integer;
var i, l : integer;
    aPoint : TPoint;
begin
  //--
   aPoint := FindDateAndType( dDate, sType );
   if aPoint.X <> -1 then
      result := 0
   else begin
      i := aPoint.X;
      l := aPoint.Y;
      result := TReservationType( TReservationDate( FDates[ i ] ).FRoomTypes[ l ] ).FOccupiedBeds;
   end;
end;

function TReservationStatistics.GetAvailableFunc( dDate : TDate; sType : string ) : integer;
var i, l : integer;
    aPoint : TPoint;
begin
  //--

   aPoint := FindDateAndType( dDate, sType );
   if aPoint.X = -1 then
      result := glb.RoomTypes[ sType ]
   else begin
      i := aPoint.X;
      l := aPoint.Y;
      result := glb.RoomTypes[ TReservationType( TReservationDate( FDates[ i ] ).FRoomTypes[ l ] ).FRoomType ] -
                TReservationType( TReservationDate( FDates[ i ] ).FRoomTypes[ l ] ).FOccupiedRooms;
   end;
end;

function TReservationStatistics.GetAvailableBedsFunc( dDate : TDate; sType : string ) : integer;
var i, l : integer;
    aPoint : TPoint;
begin
  //--
   aPoint := FindDateAndType( dDate, sType );
   if aPoint.X = -1 then
      result := glb.RoomTypesNumGuestsTotal[ sType ]
   else begin
      i := aPoint.X;
      l := aPoint.Y;
      result := glb.RoomTypesNumGuestsTotal[ TReservationType( TReservationDate( FDates[ i ] ).FRoomTypes[ l ] ).FRoomType ] -
                                             TReservationType( TReservationDate( FDates[ i ] ).FRoomTypes[ l ] ).FOccupiedBeds;
   end;
end;



end.
