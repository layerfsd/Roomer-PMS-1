unit uRoomReservationOBJ;
interface

Uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , DB
  , Forms
  , Dialogs
  , Contnrs
  , _glob
  , ug
  , ud
  , ADODB
  , uUtils
  , uDateUtils
  , kbmMemTable
  , cmpRoomerDataSet
  , cmpRoomerConnection
  ;

//******************************************************************************
TYPE

  TRoomReservation = class
  private
    FIdx         : integer;
    FFilter       : string;
    FSortOn       : string;
    function getCount : integer;
  public
    qMT_ : TkbmMemTable;

    constructor Create(Filter, SortOn : string);
    destructor Destroy; override;

    function getFromDB(RoomReservation: integer): integer;
    function getListFromDB(var list :  TStringlist) : integer;
    function getListFromDBViaDates(fromDate, toDate : TDateTime; var rExtraSet : TRoomerDataSet) : integer;
    function Refresh(filter, sortOn : string) : integer;
    function DateOrders(RoomReservation: integer;
                                     Adate: Tdate;
                                     var
                                     Channel,
                                     PaymentInvoice,
                                     AscIndex,
                                     DescIndex: integer;
                                     var
                                     GroupAccount : Boolean;
                                     var
                                     Customer
                                    ,CustomerName
                                    ,GuestName : string
                                     ): integer;


    property Filter : string
        read FFilter
       write FFilter;

    property SortOn : string
        read FSortOn
       write FSortOn;

    property Count : integer
         read getCount;    // read only
  end;

implementation

uses
  hData
  , uSqlDefinitions
  , uRoomerDefinitions;

//******************************************************************************
//*
//*
//*
//------------------------------------------------------------------------------

constructor TRoomReservation.Create(filter, sortOn : string);
begin
  inherited Create;
  FIdx    := 0;
  qMT_    := TkbmMemTable.Create(nil);
  FFilter := filter;
  FSortOn := sortOn;

  if qMt_.Active then qMt_.Close;
  qMt_.FieldDefs.Clear;

  qMt_.FieldDefs.Add('RoomReservation' , ftInteger);
  qMt_.FieldDefs.Add('Room'            , ftString,20);
  qMt_.FieldDefs.Add('Reservation'     , ftInteger);
  qMt_.FieldDefs.Add('Channel'         , ftInteger);
  qMt_.FieldDefs.Add('resFlag'         , ftString,1);
  qMt_.FieldDefs.Add('Arrival'         , ftDate);
  qMt_.FieldDefs.Add('Departure'       , ftDate);
  qMt_.FieldDefs.Add('Customer'        , ftString,30);
  qMt_.FieldDefs.Add('CustomerName'    , ftString,60);
  qMt_.FieldDefs.Add('GuestName'       , ftString,60);
  qMt_.FieldDefs.Add('PaymentInvoice'  , ftInteger);
  qMt_.FieldDefs.Add('GroupAccount'    , ftBoolean);


  qMt_.CreateTable;
  qMt_.Open;

  Refresh(FFilter,FSortOn); // read from database into FroomList
end;

destructor TRoomReservation.Destroy;
begin
  if qMt_.active then qMt_.close;
  FreeAndNil(qMT_);
  inherited Destroy;
end;

function TRoomReservation.getCount: integer;
begin
  result := qMT_.recordCount;
end;


function TRoomReservation.Refresh(filter, sorton : string) : integer;
begin
  result := -1;

  IF (Filter <> FFilter) or (Fidx = 0) then
  begin
    if filter > '' then
    begin
      try
        qMT_.Filter := Filter;
        qMT_.Filtered := true;
      except
      end;
    end else
    begin
      qMT_.Filtered := false;
    end;
  end;

  IF (sortON <> FSortOn) or (Fidx = 0) then
  begin
    if sortOn > '' then
    begin
      try
        qMT_.SortFields := sortON;
        qMT_.Sort([]);
      except
      end;
    end;
  end;

  FFilter := Filter;
  FSortOn := SortOn;
  inc(Fidx);
end;

function TRoomReservation.getFromDB(RoomReservation: integer) : integer;
var
  s    : string;
  rSet : TRoomerDataSet;
  iRoomReservation : integer;
begin
  result := 0;
  s := '';

//  s := s+ '   xSELECT ';
//  s := s+ '       RoomReservations.RoomReservation ';
//  s := s+ '     , RoomReservations.Room  ';
//  s := s+ '     , RoomReservations.Reservation ';
//  s := s+ '     , RoomReservations.Status ';
//  s := s+ '     , RoomReservations.rrArrival ';
//  s := s+ '     , RoomReservations.rrDeparture ';
//  s := s+ '     , Reservations.Customer ';
//  s := s+ '     , Reservations.Name As CustomerName ';
//  s := s+ ' FROM ';
//  s := s+ '   RoomReservations ';
//  s := s+ '   RIGHT OUTER JOIN ';
//  s := s+ '         Reservations ON RoomReservations.Reservation = Reservations.Reservation ';


  rSet := CreateNewDataSet;
  try
    s := format(select_RoomReservationOBJ_RoomReservation_getFromDB, []);
    // CopyToClipboard(s);
    // DebugMessage(''#10#10+s);
    hData.rSet_bySQL(rSet,s );
    if not rSet.Eof then
    begin
      result := 0;
      while not rSet.Eof do
      begin
        inc(result);
        qMt_.append;
        qMt_.ClearFields;
        iRoomReservation := rSet.FieldByName('RoomReservation').asInteger;
        qMt_.FieldByName( 'RoomReservation' ).asInteger  :=  iRoomReservation ;
        qMt_.FieldByName( 'Room'            ).asString   := rSet.FieldByName('Room').asString  ;
        qMt_.FieldByName( 'Reservation'     ).asInteger  := rSet.FieldByName('Reservation').asInteger  ;
        qMt_.FieldByName( 'PaymentInvoice'  ).asInteger  := rSet.FieldByName('PaymentInvoice').asInteger  ;
        qMt_.FieldByName( 'GroupAccount'    ).asBoolean  := rSet.FieldByName('GroupAccount').asBoolean  ;
        qMt_.FieldByName( 'resFlag'         ).asString   := rSet.FieldByName('Status').asString  ;
        qMt_.FieldByName( 'Arrival'         ).asDateTime := rSet.FieldByName('rrArrival').asDateTime;
        qMt_.FieldByName( 'Departure'       ).asDateTime := rSet.FieldByName('rrDeparture').asDateTime;
        qMt_.FieldByName( 'Customer'        ).asString   := rSet.FieldByName('Customer').asString;
        qMt_.FieldByName( 'Channel'         ).asInteger  := rSet.FieldByName('Channel').asInteger;
        qMt_.FieldByName( 'CustomerName'    ).asString   := rSet.FieldByName('CustomerName').asString;
        qMt_.FieldByName( 'GuestName'       ).asString   := D.RR_GetFirstGuestName(iRoomReservation);;
        qMt_.Post;
        rSet.Next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;
  refresh(FFilter,FSortOn);
end;


function TRoomReservation.getListFromDB(var list :  TStringlist) : integer;
var
  RoomReservation   : integer ;
  s    : string;
  rSet : TRoomerDataSet;
  i    : integer;
  rrList : string;
begin
  RoomReservation := 0;
  result := 0;
  rSet := CreateNewDataSet;
  try
    rrList := '';
    for i := 0 to list.Count-1 do
    begin
      try
        RoomReservation := strToInt(list[i]);
      except
        continue;
      end;
      rrList := rrList+inttostr(RoomReservation)+','
    end;

    if length(rrList) = 0 then exit;
    delete(rrList,length(rrList),1);


//    s := '';
//    s := s+ ' xSELECT '+#10;
//    s := s+ '       RoomReservations.RoomReservation ';
//    s := s+ '     , RoomReservations.Room  ';
//    s := s+ '     , RoomReservations.Reservation ';
//    s := s+ '     , RoomReservations.Status ';
//    s := s+ '     , RoomReservations.rrArrival ';
//    s := s+ '     , RoomReservations.rrDeparture ';
//    s := s+ '     , Reservations.Customer ';
//    s := s+ '     , Reservations.Name As CustomerName ';
//    s := s+ ' FROM ';
//    s := s+ '   RoomReservations ';
//    s := s+ '   RIGHT OUTER JOIN ';
//    s := s+ '         Reservations ON RoomReservations.Reservation = Reservations.Reservation ';
//    s := s+ ' WHERE (RoomReservation in ('+rrList+') ) ';

      s := format(select_RoomReservationOBJ_RoomReservation_getListFromDB , [rrList]);
      // CopyToClipboard(s);
      // DebugMessage(''#10#10+s);
      hData.rSet_bySQL(rSet,s );

     if not rSet.Eof then
     begin
       while not rSet.Eof do
       begin
         inc(result);
         qMt_.append;
         qMt_.ClearFields;
         RoomReservation := rSet.FieldByName('RoomReservation').asInteger;
         qMt_.FieldByName( 'RoomReservation' ).asInteger  := RoomReservation  ;
         qMt_.FieldByName( 'Room'            ).asString   := rSet.FieldByName('Room').asString  ;
         qMt_.FieldByName( 'Reservation'     ).asInteger  := rSet.FieldByName('Reservation').asInteger  ;
         qMt_.FieldByName( 'Channel'         ).asInteger  := rSet.FieldByName('Channel').asInteger  ;
         qMt_.FieldByName( 'PaymentInvoice'  ).asInteger  := rSet.FieldByName('PaymentInvoice').asInteger  ;
         qMt_.FieldByName( 'GroupAccount'    ).asBoolean  := rSet.FieldByName('GroupAccount').asBoolean  ;
         qMt_.FieldByName( 'resFlag'         ).asString   := rSet.FieldByName('Status').asString  ;
         qMt_.FieldByName( 'Arrival'         ).asDateTime := rSet.FieldByName('rrArrival').asDateTime;
         qMt_.FieldByName( 'Departure'       ).asDateTime := rSet.FieldByName('rrDeparture').asDateTime;
         qMt_.FieldByName( 'Customer'        ).asString   := rSet.FieldByName('Customer').asString;
         qMt_.FieldByName( 'CustomerName'    ).asString   := rSet.FieldByName('CustomerName').asString;
         qMt_.FieldByName( 'GuestName'       ).asString   := rSet.FieldByName('GuestName').asString;
         qMt_.Post;
         rSet.Next;
       end;
     end;
   finally
    freeandnil(rSet);
  end;

  refresh(FFilter,FSortOn);
end;

function TRoomReservation.getListFromDBViaDates(fromDate, toDate : TDateTime; var rExtraSet : TRoomerDataSet) : integer;
var
  RoomReservation   : integer ;
  s    : string;
  rSet : TRoomerDataSet;
  sql : string;
  exePlan : TRoomerExecutionPlan;
begin
  result := 0;
  exePlan := d.roomerMainDataSet.CreateExecutionPlan;
  try

      sql :=
      ' SELECT '+
      '       roomreservations.RoomReservation '+
      '     , roomreservations.Room  '+
      '     , roomreservations.Reservation '+
      '     , roomreservations.Status '+
      '     , roomreservations.rrArrival '+
      '     , roomreservations.rrDeparture '+
      '     , roomreservations.RoomRentPaymentInvoice AS PaymentInvoice '+
      '     , roomreservations.GroupAccount '+
      '     , reservations.Customer '+
      '     , reservations.Channel '+
      '     , reservations.Name As CustomerName '+
      '     , persons.name As GuestName '+
      ' FROM '+
      '   roomreservations '+
      '   RIGHT OUTER JOIN '+
      '         reservations ON roomreservations.Reservation = reservations.Reservation '+
      '   LEFT OUTER JOIN persons ON roomreservations.roomreservation = persons.roomreservation '+
      ' WHERE (roomreservations.RoomReservation in ( SELECT DISTINCT '+
      '    RoomReservation '+
      '  FROM  roomsdate '+
      '  WHERE (( ADate >= ''%s'' ) '+
      '   AND (ADate < ''%s'' )) '+
      '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj line added
      '  ORDER BY RoomReservation '+
      ' ) ) '+
      'GROUP BY roomreservations.RoomReservation'; // rrList

      s := format(sql,[uDateUtils.dateToSqlString(fromDate), uDateUtils.dateToSqlString(toDate)]);

      exePlan.AddQuery(s);

      if Assigned(rExtraSet) then
      begin
        s := 'SELECT ADate, ' +
             '    Room, ' +
             '    RoomType, ' +
             '    RoomReservation, ' +
             '    Reservation, ' +
             '    ResFlag, ' +
             '    Information, ' +
             '    OutOfOrderBlocking, ' +
             '    BlockMove, ' +
             '    BlockMoveReason, ' +
             '    TotalPayment, ' +
             '    TotalNoRent, ' +
             '    (IF(CityTaxIncl, 0, ' +
             ' 	  IF(taxPercentage, taxBaseAmount * taxAmount / 100, taxAmount) * ' +
             ' 		  IF(taxRoomNight, 1, ' +
             ' 			  IF(taxGuest, NumGuests, ' +
             ' 			    IF(taxGuestNight, NumGuests /  NumNights, ' +
             ' 				    IF(taxBooking, 1 / NumNights, 1 ) '+
             '              ) ' +
             '            ) ' +
             '          ) ' +
             ' 	      ) / CurrencyRate) * numNights AS totalTaxes, ' +
             '    CityTaxInCl, ' +
             '    taxAmount, ' +
             '    taxPercentage, ' +
             '    taxRetaxable, ' +
             '    taxRoomNight, ' +
             '    taxGuestNight, ' +
             '    taxGuest, ' +
             '    taxBooking, ' +
             '    taxNettoAmountBased, ' +
             '    taxBaseAmount, ' +
             '    TotalRent, ' +
             '    Guarantee, ' +
             '    InvoiceIndex, ' +
             '    Invoices, ' +
             '    RoomClass, ' +
             '    Fax, ' +
             '    BookingId, ' +
             '    PMInfo, ' +
             '    Tel2, ' +
             '    Tel1, ' +
             '    NumGuests, ' +
             '    MainName, ' +
             '    Price, ' +
             '    Discount, ' +
             '    Percentage, ' +
             '    PriceType, ' +
             '    Currency, ' +
             '    CurrencyRate, ' +
             '    ItemsOnInvoice ' +
             ' ' +
             'FROM ( ' +

             'SELECT ';
        s := s + ' ADate ';
        s := s + ',rd.Room  ';
        s := s + ',rd.RoomType ';
        s := s + ',rd.RoomReservation ';
        s := s + ',rd.Reservation ';
        s := s + ',ResFlag ';
        s := s + ', rv.Information ';
        s := s + ', rv.OutOfOrderBlocking ';
        s := s + ', rr.BlockMove ';
        s := s + ', rr.BlockMoveReason ';
        s := s + ', cur.AValue AS CurrencyRate ';
        s := s + ', (SELECT SUM(pa.Amount) AS Total FROM payments pa WHERE (pa.Amount <> 0) AND (pa.InvoiceNumber = - 1) AND (pa.RoomReservation = rd.roomReservation)) AS TotalPayment ';
        s := s + ', ( ';
        s := s + ' SELECT ';
        s := s + ' SUM(il.Total) ';
        s := s + '   FROM ';
        s := s + '  invoicelines il ';
        s := s + '   WHERE ';
        s := s + ' (il.Total <> 0) AND (il.InvoiceNumber = -1) AND (il.RoomReservation = rd.roomReservation )) ';
        s := s + '  AS TotalNoRent, ';
        s := s + '      to_bool(IF(tax.INCL_EXCL=''INCLUDED'' OR ' +
			       '(tax.INCL_EXCL=''PER_CUSTOMER'' AND cu.StayTaxIncluted), 1, 0)) AS CityTaxInCl, ' +
			       'tax.AMOUNT AS taxAmount, ' +
			       'to_bool(IF(tax.TAX_TYPE=''FIXED_AMOUNT'', 0, 1)) AS taxPercentage, ' +
			       'to_bool(IF(tax.RETAXABLE=''FALSE'', 0, 1)) AS taxRetaxable, ' +
			       'to_bool(IF(tax.TAX_BASE=''ROOM_NIGHT'', 1, 0)) AS taxRoomNight, ' +
			       'to_bool(IF(tax.TAX_BASE=''GUEST_NIGHT'', 1, 0)) AS taxGuestNight, ' +
			       'to_bool(IF(tax.TAX_BASE=''GUEST'', 1, 0)) AS taxGuest, ' +
			       'to_bool(IF(tax.TAX_BASE=''BOOKING'', 1, 0)) AS taxBooking, ' +
			       'to_bool(IF(tax.NETTO_AMOUNT_BASED=''FALSE'', 0, 1)) AS taxNettoAmountBased, ' +
			       'IF(tax.NETTO_AMOUNT_BASED=''FALSE'', RoomRate, RoomRate / (1 + vc.VATPercentage/100)) AS taxBaseAmount, ' +
			       '(SELECT COUNT(ID) FROM roomsdate rd1 WHERE rd1.ResFlag =rd.ResFlag AND (rd1.RoomReservation = rd.roomReservation)) AS NumNights, ';
        s := s + ' ';
        s := s + ' ( ';
        s := s + ' SELECT ';
        s := s + ' SUM((rd1.RoomRate - IF(rd1.isPercentage, rd1.RoomRate * rd1.Discount / 100, rd1.Discount)) * cu1.AValue * ABS(rd1.Paid-1)) ';
        s := s + '   FROM ';
        s := s + '  roomsdate rd1 ';
        s := s + '  INNER JOIN currencies cu1 ON cu1.Currency=rd1.Currency ';
        s := s + '   WHERE ';
        s := s + ' (NOT rd1.ResFlag IN (''X'',''C'',''W'',''Z'')) AND (rd1.RoomReservation = rd.roomReservation )) ';
        s := s + '  AS TotalRent ';

        s := s + ', rr.PaymentGuaranteeType AS Guarantee ';
        s := s + ', rr.InvoiceIndex AS InvoiceIndex ';
        s := s + ', (SELECT DISTINCT GROUP_CONCAT(InvoiceNumber) FROM invoiceheads WHERE RoomReservation=rd.RoomReservation AND InvoiceNumber>0 GROUP BY RoomReservation) AS Invoices ';
        s := s + ', rr.RoomClass AS RoomClass ';
        s := s + ', rv.Fax ';
        s := s + ', rv.invRefrence AS BookingId ';
        s := s + ', rv.Tel2 ';
        s := s + ', rv.Tel1 ';
        s := s + ', (SELECT count(id) FROM persons WHERE roomreservation=rd.roomreservation LIMIT 1) AS NumGuests ';
        s := s + ', (SELECT IF(ISNULL((SELECT Name FROM persons WHERE MainName=True AND roomreservation=rd.roomreservation LIMIT 1)), ';
        s := s + '          (SELECT Name FROM persons WHERE roomreservation=rd.roomreservation ORDER BY person DESC LIMIT 1), ';
        s := s + '          (SELECT Name FROM persons WHERE MainName=True AND roomreservation=rd.roomreservation LIMIT 1))) AS MainName ';
        s := s + ', rv.PMInfo ';
        s := s + ', rr.AvrageRate AS Price ';
        s := s + ', rr.Discount AS Discount ';
        s := s + ', rr.Percentage AS Percentage ';
        s := s + ', rr.PriceType AS PriceType ';
        s := s + ', rd.Currency AS Currency ';
        s := s + ', (SELECT id FROM invoicelines WHERE InvoiceNumber=-1 AND roomreservation=rd.roomreservation LIMIT 1) AS ItemsOnInvoice ';
        s := s + '  FROM ';
        s := s + ' roomsdate rd ';
        s := s + '        JOIN currencies cur ON cur.Currency=rd.Currency ' +
             'JOIN roomreservations rr ON rr.RoomReservation = rd.RoomReservation ' +
             'JOIN reservations rv ON rv.Reservation = rd.Reservation ' +
             'JOIN customers cu ON cu.Customer=rv.Customer ' +
             'JOIN control co ' +
             'JOIN items i ON i.Item=co.RoomRentItem ' +
             'JOIN itemtypes it ON it.ItemType=i.ItemType ' +
             'JOIN vatcodes vc ON vc.VATCode=it.VATCode ' +
             'JOIN home100.TAXES tax ON HOTEL_ID = co.CompanyID ' +
             'AND VALID_FROM <= rd.ADate ' +
             'AND VALID_TO >= rd.ADate ';

        s := s + '  WHERE (( ADate >= ' + _DatetoDBDate(fromDate, true) + ' ) ';
        s := s + '   AND (ADate < ' + _DatetoDBDate(toDate, true) + ' )) ';
        s := s + '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '; //**zxhj line added
        s := s + '   AND (ISNULL((SELECT id FROM rooms WHERE room=rd.room LIMIT 1)) OR (NOT (SELECT hidden FROM rooms WHERE room=rd.room LIMIT 1))) ';

        s := s + '  ORDER BY RoomReservation';
        s := s + ') xxx';

        {$ifdef DEBUG}
        CopyToClipboard(s);
        {$endif}
        exePlan.AddQuery(s);
      end;

      if NOT exePlan.Execute(ptQuery) then
         raise Exception.Create('Unable to retrieve from Roomer platform: ' + exePlan.ExecException);

      if Assigned(rExtraSet) then
      begin
        // Resultset are owned by execeutionplan, cannot just copy the link because executionplan is freed at the end of this method
        //        FreeAndNil(rExtraSet);
        //        rExtraSet := exePlan.Results[1]
        rExtraSet.Recordset := exePlan.Results[1].CloneToRecordset;
        rExtraSet.First;
      end;

     rSet := exePlan.Results[0];
     rSet.First;

     if not rSet.Eof then
     begin
       while not rSet.Eof do
       begin
         inc(result);
         qMt_.append;
         qMt_.ClearFields;
         RoomReservation := rSet.FieldByName('RoomReservation').asInteger;
         qMt_.FieldByName( 'RoomReservation' ).asInteger  := RoomReservation  ;
         qMt_.FieldByName( 'Room'            ).asString   := rSet.FieldByName('Room').asString  ;
         qMt_.FieldByName( 'Reservation'     ).asInteger  := rSet.FieldByName('Reservation').asInteger  ;
         qMt_.FieldByName( 'Channel'         ).asInteger  := rSet.FieldByName('Channel').asInteger  ;
         qMt_.FieldByName( 'PaymentInvoice'  ).asInteger  := rSet.FieldByName('PaymentInvoice').asInteger  ;
         qMt_.FieldByName( 'GroupAccount'    ).asBoolean  := rSet.FieldByName('GroupAccount').asBoolean  ;
         qMt_.FieldByName( 'resFlag'         ).asString   := rSet.FieldByName('Status').asString  ;
         qMt_.FieldByName( 'Arrival'         ).asDateTime := rSet.FieldByName('rrArrival').asDateTime;
         qMt_.FieldByName( 'Departure'       ).asDateTime := rSet.FieldByName('rrDeparture').asDateTime;
         qMt_.FieldByName( 'Customer'        ).asString   := rSet.FieldByName('Customer').asString;
         qMt_.FieldByName( 'CustomerName'    ).asString   := rSet.FieldByName('CustomerName').asString;
         qMt_.FieldByName( 'GuestName'       ).asString   := rSet.FieldByName('GuestName').asString;
         qMt_.Post;
         rSet.Next;
       end;
     end;
  finally
    exePlan.Free;
  end;

  refresh(FFilter,FSortOn);
end;



function TRoomReservation.DateOrders(RoomReservation: integer;
                                     Adate: Tdate;
                                     var
                                     Channel,
                                     PaymentInvoice,
                                     AscIndex,
                                     DescIndex: integer;
                                     var
                                     GroupAccount : Boolean;
                                     var
                                     Customer
                                    ,CustomerName
                                    ,GuestName : string
                                     ): integer;
var
  Arrival       : Tdate;
  Departure     : Tdate;
begin
  result := 0;
  ascIndex  := -1;
  descIndex := -1;
//  Filter := 'RoomReservation='+inttostr(RoomReservation);

  if qMT_.Locate('RoomReservation',RoomReservation,[]) then
  begin
    Arrival      := qMt_.FieldByName('Arrival').asDateTime;
    Departure    := qMt_.FieldByName('Departure').asDateTime;
    Channel      := qMt_.FieldByName('Channel').asInteger;
    PaymentInvoice:= qMt_.FieldByName('PaymentInvoice').asInteger;
    GroupAccount := qMt_.FieldByName('GroupAccount').asBoolean;

    AscIndex     := Trunc((ADate - Arrival));
    DescIndex    := Trunc((Departure - Adate)-1);
    Customer     := qMt_.FieldByName('Customer').asString;
    customerName := qMt_.FieldByName('CustomerName').asString;
    GuestName    := qMt_.FieldByName('GuestName').asString;
  end;
end;


end.



