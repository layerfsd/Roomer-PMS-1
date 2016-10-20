unit uSqlDefinitions;

interface
   uses hData, System.SysUtils, _Glob, PrjConst, uRoomerDefinitions, ud, uDateUtils, uUtils, uReservationStateDefinitions;


const HOTEL_PERFORMANCE_QUERY_BETWEEN_DATES = 'SELECT IFNULL(ADate, pdd.date) AS ADate, ' +
         '    IFNULL(RoomsSold / RoomCount * 100, 0.0) AS OCC, ' +
         '    IFNULL(ADR, 0.0) AS ADR, ' +
         '    IFNULL(RevPar, 0.0) AS RevPar, ' +
         '    IFNULL(Revenue, 0.0) AS Revenue, ' +
         '    IFNULL(RoomCount - RoomsSold, (SELECT COUNT(id) FROM rooms r WHERE WildCard = 0 AND Hidden = 0 AND Active = 1 AND Statistics = 1)) AS Availability, ' +
         '    IFNULL(RoomCount, (SELECT COUNT(id) FROM rooms r WHERE WildCard = 0 AND Hidden = 0 AND Active = 1 AND Statistics = 1)) AS RoomCount, ' +
         '    IFNULL(RoomsSold, 0) AS RoomsSold, ' +
         '    IFNULL(OOO, 0) AS OOO ' +
         'FROM predefineddates pdd ' +
         'LEFT JOIN ( ' +
         'SELECT ADate, RoomsSold/RoomCount*100 AS OCC, ' +
         '       ADR, ' +
         '       RevPar, ' +
         '       Revenue, ' +
         '       RoomCount-RoomsSold AS Availability, ' +
         '       RoomCount, ' +
         '       RoomsSold, OOO ' +
         'FROM ( ' +
         'SELECT rd.ADate, SUM(RoomRate * cu.AValue) / rm.RoomCount AS RevPar, ' +
         '       rm.RoomCount, ' +
         '       SUM(RoomRate * cu.AValue) AS Revenue, ' +
         '       AVG(RoomRate * cu.AValue) AS ADR, ' +
         '       COUNT(rd.id) AS RoomsSold, rd1.OOO ' +
         'FROM roomsdate rd ' +
         '     LEFT JOIN rooms ro ON ro.Room = rd.Room ' +
         '     JOIN reservations re ON re.Reservation=rd.Reservation ' +
         '     JOIN (SELECT pdd.date AS ADate, (SELECT COUNT(rd1.id) AS OOO ' +
         '                                      FROM  roomsdate rd1 ' +
         '                                      JOIN reservations r ON r.Reservation = rd1.Reservation AND outOfOrderBlocking = 1 ' +
         '                                      WHERE rd1.ADate=pdd.date AND NOT (rd1.ResFlag IN (''X'',''C'',''N'',''Z'',''O''))) AS OOO ' +
         '		       FROM predefineddates pdd ' +
         '           WHERE (pdd.date >= ''%s'' ' +
         '           AND pdd.date <= ''%s'')) rd1 ON rd1.ADate=rd.ADate, ' +
         '     currencies cu, ' +
         '     (SELECT COUNT(id) AS RoomCount ' +
         '      FROM rooms r ' +
         '      WHERE WildCard=0 AND Hidden=0 AND Active=1  AND Statistics=1 ' +
//Changed HJ 2016-01-11
         // '      WHERE WildCard=0 AND Hidden=0 AND Active=1 ' +

         '     ) rm ' +
         'WHERE (rd.ADate>=''%s'' AND rd.ADate<=''%s'') ' +
         'AND (NOT rd.ResFlag IN (''X'',''C'',''N'',''W'',''Z'',''O'')) ' +
         'AND ((SUBSTR(rd.Room, 1, 1)=''<'')  OR ((NOT ISNULL(ro.Room)) AND ro.WildCard=0 AND ro.Hidden=0 AND ro.Active=1 AND ro.Statistics=1)) ' +
         'AND cu.Currency=rd.Currency ' +
         'AND re.outOfOrderBlocking = 0 ' +
         'GROUP BY rd.ADate) totals ' +

         'UNION ALL ' +

         'SELECT date, 0 AS OCC, ' +
         '       ADR, ' +
         '       0, ' +
         '       0, ' +
         '       RoomCount-RoomsSold AS Availability, ' +
         '       RoomCount, ' +
         '       RoomsSold, 0 AS OOO ' +
         'FROM ( ' +
         'SELECT date, 0 AS RevPar, ' +
         '       rm.RoomCount, ' +
         '       0 AS Revenue, ' +
         '       0 AS ADR, ' +
         '       0 AS RoomsSold ' +
         'FROM predefineddates pdd ' +
         '     LEFT JOIN (SELECT rd.ADate, rd.ResFlag FROM roomsdate rd WHERE (rd.ADate >= ''%s'' ' +
         '        AND rd.ADate <= ''%s'')) ex ON pdd.date = ex.ADate AND (NOT ex.ResFlag IN (''X'' , ''C'', ''N'', ''W'', ''Z'', ''O'')), ' +
         '    (SELECT COUNT(id) AS RoomCount ' +
         '      FROM rooms r ' +
         '      WHERE WildCard=0 AND Hidden=0 AND Active=1 AND Statistics=1' +
         '     ) rm ' +
         'WHERE (pdd.date>=''%s'' AND pdd.date<=''%s'') ' +
         '  AND ISNULL(ex.ADate) ' +
         'GROUP BY pdd.date) totals ' +

         ') xxx ON pdd.date = ADate ' +
         'WHERE pdd.date>=''%s'' AND pdd.date <= ''%s'' ' +
         'ORDER BY ADate';

const GET_ALL_ROOMRESERVATIONS_ARRIVING_ON_SPECIFIED_DATE=
               'SELECT rr.RoomReservation ' +
               'FROM roomreservations rr ' +
               '	 INNER JOIN persons p ON p.RoomReservation=rr.RoomReservation AND MainName ' +
               'WHERE (SELECT ADate FROM roomsdate ' +
               '       WHERE RoomReservation=rr.RoomReservation ' +
               '       AND ResFlag=''P'' ' +
               '       ORDER BY ADate LIMIT 1)=%s ' +
               'ORDER BY SUBSTRING_INDEX(p.Name,'' '',-1), ' +
               '         p.Name ';

const GET_ALL_ROOMRESERVATIONS_ARRIVING_ON_SPECIFIED_DATE_FILTER_RESERVATION_ID=
               'SELECT rr.RoomReservation ' +
               'FROM roomreservations rr ' +
               '	 INNER JOIN persons p ON p.RoomReservation=rr.RoomReservation AND MainName ' +
               'WHERE (SELECT ADate FROM roomsdate ' +
               '       WHERE RoomReservation=rr.RoomReservation ' +
               '       AND ResFlag=''P'' ' +
               '       ORDER BY ADate LIMIT 1)=%s ' +
               'AND rr.Reservation=%d ' +
               'ORDER BY SUBSTRING_INDEX(p.Name,'' '',-1), ' +
               '         p.Name ';

var
// BJORN PUT BACK !!!
  XXXXselect_lstRR_CurrentlyCheckedIn : string =
  ' SELECT '+
  '    roomsdate.ADate '+
  '   , roomsdate.Room '+
  '   , roomsdate.RoomType '+
  '   , roomsdate.RoomReservation '+
  '   , roomsdate.Reservation '+
  '   , roomsdate.ResFlag '+
  '   , roomreservations.Arrival '+
  '   , roomreservations.Departure '+
  ' FROM '+
  '   roomsdate INNER JOIN '+
  '     roomreservations ON roomsdate.RoomReservation = roomreservations.RoomReservation '+
  ' WHERE '+
  '   ((roomsdate.ADate =  %s ) AND (roomsdate.ResFlag = ''G'' )) '+
  ' OR '+
  '   ((roomsdate.ADate =  %s ) AND (roomsdate.ResFlag = ''G'' )'+
  '   AND (roomreservations.Departure =  %s )) ';

  xxxxselect_isRrCurrentlyCheckedIn : string =
  ' SELECT '+
  '     roomsdate.ADate '+
  '   , roomsdate.ResFlag '+
  '   , roomreservations.Departure '+
  ' FROM '+
  '   roomsdate '+
  '     INNER JOIN '+
  '   roomreservations ON roomsdate.RoomReservation = roomreservations.RoomReservation '+
  ' WHERE '+
  '   (roomsdate.RoomReservation =  %d ) '+
  '     AND (roomsdate.ADate =  %s ) '+
  '     AND (roomsdate.ResFlag = ''G'' ) '+
  '   OR '+
  '   (roomsdate.RoomReservation = %d) '+
  '     AND (roomsdate.ADate =  %s ) '+
  '     AND (roomsdate.ResFlag =  ''G'' ) '+
  '     AND (roomreservations.Departure =   %s ) ';




///////// END BJORN PUT BACK !!!


  ///unit objHomeCustomer
  ///1. customer Field nvarchar(15)
  ///TESTD ok
  select_objHomeCustomer_Customer_Get  : string =
  ' SELECT '+#10+
  '     customers.ID '+#10+
  '   , customers.Customer '+#10+
  '   , customers.Surname AS CustomerName '+#10+
  '   , customers.Name AS DisplayName '+#10+
  '   , customers.PID '+#10+
  '   , customers.Address1 '+#10+
  '   , customers.Address2 '+#10+
  '   , customers.Address3 '+#10+
  '   , customers.Address4 '+#10+
  '   , customers.Tel1 '+#10+
  '   , customers.Tel2 '+#10+
  '   , customers.Fax '+#10+
  '   , customers.Country '+#10+
  '   , countries.CountryName '+#10+
  '   , customers.CustomerType AS MarketSegmentCode '+#10+
  '   , customertypes.Description AS MarketSegmentName '+#10+
  '   , customers.DiscountPercent AS DiscountPerc '+#10+
  '   , customers.EmailAddress '+#10+
  '   , customers.Homepage '+#10+
  '   , customers.ContactPerson '+#10+
  '   , customers.TravelAgency AS isTravelAgency '+#10+
  '   , customers.Currency '+#10+
  '   , customers.pcID '+#10+
  '   , tblpricecodes.pcCode '+#10+
  '   , customers.notes '+#10+
  ' FROM '+#10+
  '   customers '+#10+
  '      LEFT OUTER JOIN tblpricecodes ON customers.pcID = tblpricecodes.Id '+#10+
  '      LEFT OUTER JOIN customertypes ON customers.CustomerType = customertypes.CustomerType '+#10+
  '      LEFT OUTER JOIN countries ON customers.Country = countries.country '+#10+
  ' WHERE '+#10+
  '  customers.Customer = %s ' ;


   ///TESTED OK
   select_objRoomList2_FillList : string =
   ' SELECT '#10+
   '   rooms.Room '#10+
   '  ,rooms.Description '#10+
   '  ,rooms.RoomType '#10+
   '  ,rooms.Equipments '#10+
   '  ,rooms.Bookable '#10+
   '  ,rooms.Statistics '#10+
   '  ,rooms.Status '#10+
   '  ,rooms.OrderIndex '#10+
   '  ,rooms.hidden '#10+
   '  ,rooms.Location '#10+
   '  ,rooms.Floor '#10+
   '  ,rooms.useInNationalReport '#10+
   '  ,maintenanceroomnotes.CleaningNotes '#10+
   '  ,maintenanceroomnotes.MaintenanceNotes '#10+
   '  ,maintenanceroomnotes.LostAndFound '#10+
   '  ,staffmembers.Initials AS reportUserInitials '#10+
   '  ,staffmembers.Name AS reportUserName '#10+
   '  ,maintenancecodes.name AS maintenanceDescription '#10+
   ' FROM '+
   '   rooms '#10+
   '   LEFT JOIN maintenanceroomnotes ON maintenanceroomnotes.Room = rooms.Room '#10+
   '   LEFT JOIN maintenancecodes ON maintenancecodes.Code = rooms.Status '#10+
   '   LEFT JOIN staffmembers ON maintenanceroomnotes.StaffIdReported = staffmembers.Id '#10+
   ' ORDER BY '#10+
   '   OrderIndex, Room ' ;

  //TESTED NOT
  select_objRoomRates_GetDayRate : string =
  ' SELECT '#10+
  '     pricetypes.ID '#10+
  '   , pricetypes.pcID '#10+
  '   , pricetypes.Currency '#10+
  '   , pricetypes.RoomType '#10+
  '   , pricetypes.Description '#10+
  '   , pricetypes.seID '#10+
  '   , tblseasons.seStartDate '#10+
  '   , tblseasons.seEndDate '#10+
  '   , tblseasons.seDescription '#10+
  '   , pricetypes.Price1Person '#10+
  '   , pricetypes.Price2Persons '#10+
  '   , pricetypes.Price3Persons '#10+
  '   , pricetypes.Price4Persons '#10+
  '   , pricetypes.Price5Persons '#10+
  '   , pricetypes.Price6Persons '#10+
  '   , pricetypes.PriceExtraPerson '#10+
  ' FROM '#10+
  '   pricetypes '#10+
  '     LEFT OUTER JOIN tblseasons ON pricetypes.seID = tblseasons.ID '#10+
  ' WHERE '#10+
  '       (pricetypes.pcID = %d ) '#10+
  '   AND (pricetypes.Currency =  %s ) '#10+
  '   AND (pricetypes.RoomType =  %s ) '#10+
  '   AND (tblseasons.seStartDate <=  %s ) '#10+
  '   AND (tblseasons.seEndDate >=  %s ) ' ;


    //TESTED OK
    select_objRoomTypeRoomCount_FillList : string =
    ' SELECT '+
    '     COUNT(rooms.Room) AS TypeCount '+
    '   , rooms.RoomType '+
    '   , roomtypes.Description '+
    '   , roomtypes.NumberGuests '+
    '   , roomtypes.RoomTypeGroup '+
    ' FROM '+
    '   rooms '+
    '     INNER JOIN roomtypes ON rooms.RoomType = roomtypes.RoomType '+
    ' GROUP BY '+
    '      rooms.RoomType '+
    '    , roomtypes.Description '+
    '    , roomtypes.NumberGuests '+
    '    , roomtypes.RoomTypeGroup '+
    ' ORDER BY rooms.roomType '  ;



  //TESTED OK
  select_GlobalSettings_LoadStaticTables : string =
  ' SELECT rt.RoomType, rt.NumberGuests FROM roomtypes rt, rooms r '+
  ' WHERE r.bookable<>0 '+
  '  AND r.RoomType = rt.RoomType' ;

  //TESTED NOT

  //TESTED NOT

  //TESTED NOT
  select_CancelReservation3_GetData : string =
  ' SELECT '+
  '     RoomReservation '+
  '   , Room '+
  '   , RoomType '+
  '   , Reservation '+
  '   , Status '+
  '   , rrArrival '+
  '   , rrDeparture '+
  ' FROM '+
  '   roomreservations '+
  ' WHERE '+
  '   (Reservation = %d) '+
  ' ORDER BY room ';


  //TESTED NOT
  select_ControlData_FormCreate : string =
  'SELECT c.* from control c ';

  select_TimeZones_FormCreate : string =
  'SELECT ID, TIME_ZONE, DESCRIPTION FROM home100.TIME_ZONES ORDER BY DESCRIPTION';

  //TESTED NOT
  select_tblInc_All  : string =
  'SELECT * from tblinc ';

  //TESTED OK
  select_ControlData_LoadColors : string =
  ' SELECT '+
  '  ID '+
  '  ,ColorHex  '+
  '  ,Description '+
  ' FROM '+
  ' colors '+
  ' ORDER BY ID DESC ' ;

  //TESTED NOT
  select_ConvertGroups_fillGridFromDataset : string =
  ' SELECT '+
  '    cgCode '+
  '   ,cgDescription '+
  '   ,Active '+
  '   ,ID '+
  ' FROM '+
  '   tblconvertgroups '+
  ' WHERE '+
  '   Active = %d '+
  ' ORDER BY '+
  '  %s ';
//  '  '+zSortStr+' ';

  //TESTED NOT
  select_Converts_fillGridFromDataset : string =
  ' SELECT '+
  '    ID '+
  '   ,cvType '+
  '   ,cvFrom '+
  '   ,cvTo '+
  '   ,active '+
  ' FROM '+
  '   tblconverts '+
  ' WHERE '+
  '   Active = %d '+
  ' ORDER BY '+
  '  %s ';
///  '  '+zSortStr+' ';

  //TESTED NOT
  select_Countries_fillGridFromDataset : string =
  ' SELECT '+
  '     countries.Country '+
  '   , countries.CountryName '+
  '   , countries.IslCountryName '+
  '   , countries.Currency '+
  '   , countries.active '+
  '   , countries.ID '+
  '   , countries.CountryGroup '+
  '   , countries.OrderIndex AS OrderIndex '+
  '   , currencies.ID AS CurrenciesID '+
  '   , currencies.Description AS CurrenciesDescription '+
  '   , countrygroups.GroupName AS countrygroupsGroupName '+
  ' FROM '+
  '   countries '+
  '      LEFT OUTER JOIN currencies ON countries.Currency = currencies.Currency '+
  '      LEFT OUTER JOIN countrygroups ON countries.CountryGroup = countrygroups.CountryGroup '+
  ' WHERE '+
  '   countries.active = %d'+
  ' ORDER BY '+
  '  %s ';
  //'  '+ zSortStr ;

  //TESTED NOT
  select_CountryGroups_fillGridFromDataset : string =
  ' SELECT '+
  '     CountryGroup '+
  '   , GroupName '+
  '   , IslGroupName '+
  '   , OrderIndex '+
  ' FROM '+
  '   countrygroups '+
  ' ORDER BY '+
  '  %s ';

  select_ChannelManager_fillGridFromDataset : string =
  ' SELECT ' +
  ' id, ' +
  ' code, ' +
  ' Description, ' +
  ' adminUsername, ' +
  ' adminPassword, ' +
  ' webserviceURI, ' +
  ' webserviceUsername, ' +
  ' webservicePassword, ' +
  ' webserviceHotelCode, ' +
  ' weserviceRequestor, ' +
  ' active, ' +
  ' sendRate, ' +
  ' sendAvailability, ' +
  ' sendStopSell, ' +
  ' sendMinStay, ' +
  ' maintenanceDays, ' +
  ' directConnection, ' +
  ' CONVERT(channels, CHAR(255)) AS schannels ' +
  ' FROM channelmanagers ' +
  ' ORDER BY '+
  '  %s ';


  select_Currencies_fillGridFromDataset_byActive : string =
  ' SELECT '+
  '    ID '+
  '   ,Currency '+
  '   ,Description '+
  '   ,AValue '+
  '   ,SellValue '+
  '   ,CurrencySign '+
  '   ,Active '+
  '   ,displayFormat '+
  '   ,decimals '+
  ' FROM '+
  '   currencies '+
  ' WHERE '+
  '   Active = %d '+
  ' ORDER BY '+
  '  %s ';

  select_personviptypes_fillGridFromDataset_byActive : string =
  ' SELECT '+
  '    ID '+
  '   ,Code '+
  '   ,Description '+
  '   ,VipGrade '+
  '   ,Active '+
  ' FROM '+
  '   personviptypes '+
  ' WHERE '+
  '   Active = %d '+
  ' ORDER BY '+
  '  %s ';

  select_personContactType_fillGridFromDataset_byActive : string =
  ' SELECT '+
  '    ID '+
  '   ,Code '+
  '   ,Description '+
  '   ,sysType '+
  '   ,Active '+
  ' FROM '+
  '   personcontacttype '+
  ' WHERE '+
  '   Active = %d '+
  ' ORDER BY '+
  '  %s ';


 //TESTED NOT

  //TESTED NOT

   //TESTED NOT
///   '   (invoicelines.InvoiceNumber IN '+zSqlInText+') '+


//////////////////////////////////////////////////////////
///
///
///  CHECKED until here
///
///
///

  //TESTED NOT
  select_DayFinical_GetInvoicelist : string =
  ' SELECT '+
  '     invoiceheads.Reservation '+
  '   , invoiceheads.RoomReservation '+
  '   , invoiceheads.SplitNumber '+
  '   , invoiceheads.InvoiceNumber '+
  '   , invoiceheads.Customer '+
  '   , invoiceheads.Name AS NameOnInvoice '+
  '   , invoiceheads.Address1 '+
  '   , invoiceheads.Address2 '+
  '   , invoiceheads.Address3 '+
  '   , invoiceheads.Total AS ihAmountWithTax '+
  '   , invoiceheads.TotalWOVAT AS ihAmountNoTax '+
  '   , invoiceheads.TotalVAT AS ihAmountTax '+
  '   , invoiceheads.CreditInvoice '+
  '   , invoiceheads.OriginalInvoice '+
  '   , invoiceheads.RoomGuest '+
  '   , invoiceheads.ihInvoiceDate AS InvoiceDate '+
  '   , invoiceheads.ihPayDate AS dueDate '+
  '   , invoiceheads.invRefrence '+
  '   , invoiceheads.TotalStayTax '+
  '   , invoiceheads.TotalStayTaxNights '+
  '   , invoiceheads.ihConfirmDate AS ConfirmedDate '+
  '   , invoiceheads.ihCurrency AS Currency '+
  '   , invoiceheads.ihCurrencyRate AS Rate '+
  '   , invoiceheads.ihStaff AS Staff '+
  '   , customers.Surname AS CustomerName '+
  '   , customers.TravelAgency AS isAgency '+
  '   , customers.CustomerType AS markedSegment '+
  '   , customertypes.Description AS markedSegmentDescription '+
  ' FROM '+
  '   customertypes '+
  '     RIGHT OUTER JOIN customers ON customertypes.CustomerType = customers.CustomerType '+
  '     RIGHT OUTER JOIN invoiceheads ON customers.Customer = invoiceheads.Customer '+
  ' WHERE '+
  '   (invoiceheads.InvoiceNumber IN  %s ) '+ //zSqlInText
  ' ORDER BY '+
  '   invoiceheads.InvoiceNumber ' ;

  //TESTED NOT

  //TESTED NOT
  select_DayFinical_getPayments : string =
  ' SELECT '+
  '     payments.Reservation '+
  '   , payments.RoomReservation '+
  '   , payments.InvoiceNumber '+
  '   , payments.PayDate '+
  '   , payments.Customer '+
  '   , payments.Amount '+
  '   , payments.Currency '+
  '   , payments.CurrencyRate '+
  '   , payments.PayType '+
  '   , invoiceheads.InvoiceDate '+
  '   , paytypes.Description AS PayTypeDescription '+
  '   , paytypes.PayGroup '+
  '   , paygroups.Description AS payGroupDescription '+

  '   , invoiceheads.Name AS NameOnInvoice '+
  '   , invoiceheads.ihConfirmDate '+
  '   , invoiceheads.SplitNumber '+
  '   , invoiceheads.RoomGuest '+
  '   , customers.Surname AS CustomerName '+
  '   , customers.TravelAgency AS isAgency '+
  ' FROM '+
  '   payments '+
  '      LEFT OUTER JOIN customers ON payments.Customer = customers.Customer '+
  '      LEFT OUTER JOIN paytypes ON payments.PayType = paytypes.PayType '+
  '      LEFT OUTER JOIN invoiceheads ON payments.InvoiceNumber = invoiceheads.InvoiceNumber '+
  '      LEFT OUTER JOIN paygroups ON paytypes.PayGroup = paygroups.PayGroup '+
  ' WHERE '+
  '   (payments.InvoiceNumber IN  %s ) '+
  ' ORDER BY '+
  '   payments.InvoiceNumber ' ;
  ///  '   (payments.InvoiceNumber IN '+zSqlInText+') '+


  // TESTED NOT
  select_DayFinical_getPaymentType : string =
  ' SELECT '+
  '      COUNT(payments.InvoiceNumber) AS InvoiceCount '+
  '    , COUNT(payments.Customer) AS CustomerCount '+
  '    , SUM(payments.Amount) AS Amount '+
  '    , payments.PayType '+
  '    , paytypes.Description AS PayTypeDescription '+
  '    , paygroups.PayGroup '+
  ' FROM '+
  '   payments '+
  '      LEFT OUTER JOIN paytypes ON payments.PayType = paytypes.PayType '+
  '      LEFT OUTER JOIN invoiceheads ON payments.InvoiceNumber = invoiceheads.InvoiceNumber '+
  '      LEFT OUTER JOIN paygroups ON paytypes.PayGroup = paygroups.PayGroup '+
  ' WHERE '+
  '   (payments.InvoiceNumber IN  %s ) '+  // zSqlInText
  ' GROUP BY '+
  '     payments.PayType '+
  '   , paytypes.Description '+
  '   , paygroups.PayGroup ' ;


  // TESTED NOT
  select_DayFinical_getPaymentGroup : string =
  ' SELECT '+
  '      COUNT(payments.InvoiceNumber) AS InvoiceCount '+
  '    , SUM(payments.Amount) AS Amount '+
  '    , paygroups.PayGroup '+
  '    , paygroups.Description '+
  ' FROM '+
  '   payments '+
  '      LEFT OUTER JOIN paytypes ON payments.PayType = paytypes.PayType '+
  '      LEFT OUTER JOIN invoiceheads ON payments.InvoiceNumber = invoiceheads.InvoiceNumber '+
  '      LEFT OUTER JOIN paygroups ON paytypes.PayGroup = paygroups.PayGroup '+
  ' WHERE '+
  '   (payments.InvoiceNumber IN  %s ) '+  // zSqlInText
  ' GROUP BY '+
  '    paygroups.PayGroup '+
  '   ,paygroups.Description ' ;

  
  // TESTED NOT
  select_DayNotes_RefreshImPortLog : string =
  ' SELECT '+
  '        Id '+
  '      , DateInsert '+
  '      , ImportTypeID '+
  '      , ImportData '+
  '      , ImportResultID '+
  '      , Reservation '+
  '      , RoomReservation '+
  '      , Customer '+
  '      , DateExport '+
  '      , ItemCount '+
  '      , HotelCode '+
  '      , Staff '+
  '      , RoomNumber '+
  '      , isGroupInvoice '+
  '      , invCustomer '+
  '      , invPersonalID '+
  '      , invCustomerName '+
  '      , invAddress1 '+
  '      , invAddress2 '+
  '      , invAddress3 '+
  '      , invAddress4 '+
  '      , GuestName '+
  '      , SaleRefrence '+
  '      , invoiceNumber '+
  '    FROM '+
  '      tblimportlogs '+
  '    WHERE '+
  '      ( (DateInsert >=  %s ) AND (DateInsert <= %s ) )';

  /// ( (DateInsert >='+_db(dtDateFrom)+ ') AND (DateInsert <='+_db(dtDateTo)+ ') )';


  // TESTED NOT
  select_DayNotes_RefreshRoomStatus : string =
  ' SELECT '+
  '     tblroomstatus.resDate '+
  '   , tblroomstatus.RoomType '+
  '   , roomtypes.Description  '+
  '   , tblroomstatus.available '+
  '   , roomtypes.NumberGuests  '+
  '   , roomtypes.RoomTypeGroup '+
  ' FROM '+
  '   tblroomstatus '+
  '     INNER JOIN '+
  '       roomtypes ON tblroomstatus.RoomType = roomtypes.RoomType '+
  ' WHERE '+
  ' (resDate>= %s ) '+      //_dateToSqlDate(zCurrentDate)
  ' AND (resDate<= %s ) '+  //_dateToSqlDate(zCurrentDate + zDaysToShow - 1)
  ' ORDER BY '+
  '   tblroomstatus.RoomType '+
  '   ,tblroomstatus.resDate ' ;

  
  
  
  //TESTED NOT
  select_DayNotes_RefreshRoomStatus2 : string =
  '   SELECT '+
  '     tblroomstatus.resDate '+
  '   , SUM(tblroomstatus.available) AS Total '+
  '   , roomtypes.RoomTypeGroup '+
  '   , roomtypegroups.Description '+
  ' FROM '+
  '   tblroomstatus '+
  '     INNER JOIN '+
  '       roomtypes ON tblroomstatus.RoomType = roomtypes.RoomType '+
  '     INNER JOIN '+
  '        roomtypegroups ON roomtypes.RoomTypeGroup = roomtypegroups.Code '+
  ' GROUP BY '+
  '     tblroomstatus.resDate '+
  '   , roomtypes.RoomTypeGroup '+
  '   , roomtypegroups.Description '+
  ' HAVING '+
  ' (resDate>= %s ) '+       //_dateToSqlDate(zCurrentDate)
  ' AND (resDate<= %s ) ' ;  //_dateToSqlDate(zCurrentDate + zDaysToShow - 1)


 // TRSTED NOT
 select_RebuildReservationStats_GetRoomReservations : string =
   ' SELECT '#10+
   '     ID '#10+
   '   , RoomReservation '#10+
   '   , Reservation '#10+
   '   , Room '#10+
   '   , RoomType '#10+
   '   , Status As ResStatus'#10+
   '   , rrArrival AS Arrival '#10+
   '   , rrDeparture AS Departure '#10+
   '   , ExpectedTimeOfArrival  '#10+
   '   , ExpectedCheckoutTime '#10+
   '   , RoomRentPaymentInvoice '#10+
   '   , GroupAccount AS isGroupAccount '#10+
   '   , Currency '#10+
   '   , Discount '#10+
   '   , Percentage '#10+
   '   , PriceType '#10+
   '   , RoomPrice1 '#10+
   '   , Price1From '#10+
   '   , Price1To '#10+
   '   , RoomRentPaid1 '#10+
   '   , RoomPrice2 '#10+
   '   , Price2From '#10+
   '   , Price2To '#10+
   '   , RoomRentPaid2 '#10+
   '   , RoomPrice3 '#10+
   '   , Price3From '#10+
   '   , Price3To '#10+
   '   , RoomRentPaid3 '#10+
   '   , invBreakfast AS inclBreakfast '#10+
   '   , useinNationalReport '#10+
   '   , useStayTax '#10+
   ' FROM '#10+
   '   roomreservations '#10+
   ' WHERE '#10+
   '    (RoomReservation in %s ) ';

 

  //TESTED NOT

  //TESTED NOT

  //TESTED NOT

  //TESTED NOT

  //TESTED NOT


  //TESTED NOT
  select_Invoice_CheckCurrencyChange : string =
  ' SELECT '+
  '    RoomReservation '+
  '  , GroupAccount '+
  '  , Reservation '+
  ' FROM '+
  '   roomreservations '+
  ' WHERE '+
  '   (Reservation = %d) AND (InvoiceIndex = %d) AND (GroupAccount <> 0) ' ;

  //TESTED NOT
  select_Invoice_LoadLines1 : string =
  'SELECT * FROM ' + '' + 'invoiceheads' + ''+
  ' where InvoiceNumber = %d ' ;

  //TESTED NOT
  select_Invoice_LoadLines2 : string =
  ' SELECT * FROM invoicelines '+
  ' where InvoiceNumber = %d ' ;

  //TESTED NOT

  //TESTED NOT

  //TESTED NOT
  select_Invoice_GetInvoiceHeader : string =
  ' SELECT '+
  '     Reservation, '+
  '     RoomReservation, '+
  '     InvoiceNumber, '+
  '     Customer, '+
  '     Name, '+
  '     Address1, '+
  '     Address2, '+
  '     Address3, '+
  '     Address4, '+
  '     Country, '+
  '     custPID, '+
  '     invRefrence, '+
  '     InvoiceType '+
  '   FROM '+
  '     invoiceheads '+
  '   WHERE '+
  '      (Reservation = %d) AND (RoomReservation = %d) ' ;

  //TESTED NOT
  select_Invoice_GetReservationHeader :string =
  ' SELECT '+
  '     Reservation, '+
  '     Customer, '+
  '     Name, '+
  '     Address1, '+
  '     Address2, '+
  '     Address3, '+
  '     Address4, '+
  '     Country, '+
  '     custPID,  '+
  '     invRefrence  '+
  '   FROM '+
  '     reservations '+
  '   WHERE '+
  '      (Reservation = %d )  ' ;

  //TESTED NOT
  select_Invoice_actItemToGroupInvoiceExecute : string =
  ' SELECT '+
  '    Reservation '+
  '  , RoomReservation '+
  '  , InvoiceNumber '+
  '  , Total '+
  '  , TotalWOVAT '+
  '  , TotalVAT '+
  '  , ID '+
  ' FROM '+
  '   invoiceheads '+
  '  WHERE '+
  '    (Reservation =%d ) AND (RoomReservation = 0) AND (InvoiceNumber = - 1) ' ;

  //TESTED NOT
  select_Invoice_actItemToRoomInvoiceExecute : string =
  ' SELECT '+
  '    Reservation '+
  '  , RoomReservation '+
  '  , InvoiceNumber '+
  '  , Total '+
  '  , TotalWOVAT '+
  '  , TotalVAT '+
  '  , ID '+
  ' FROM '+
  '   invoiceheads '+
  '  WHERE '+
  '    (Reservation =%d ) AND (RoomReservation = %d) AND (InvoiceNumber = - 1) ' ;

  update_Invoice_actItemToRoomInvoiceExecute : string =
  ' UPDATE invoiceheads Set '+
  '    Total = %s '+
  '  , TotalWOVAT = %s '+
  '  , TotalVAT = %s '+
  '  , ID '+
  '  WHERE '+
  '    (Reservation =%d ) AND (RoomReservation = %d) AND (InvoiceNumber = - 1) ' ;


  ////////////////////////////////////////////////////////


  //TESTED OK
  /// shows if invoice has been exported 
  select_InvoiceList2_RunQuery2 : string =
  ' SELECT '+
  '   COUNT(ID) AS invCount '+
  '    , InvoiceNumber '+
  '    , ActionID '+
  '  FROM '+
  '    tblinvoiceactions '+
  '  GROUP BY InvoiceNumber, ActionID '+
  '  HAVING '+
  '    (InvoiceNumber =  %d ) AND (ActionID=2001) ' ;
///  '    (InvoiceNumber = ' + quotedStr(r_.fieldbyname('InvoiceNumber').asstring) + ') AND (ActionID=2001) ' ;


//NOT TESTED
select_InvoicePayment_FillPayGrid : string =
' SELECT '+
'   PayType '+
' FROM '+
'   paytypes ' ;

select_InvoiceSummeryOBJ_InvoiceInfo_GatherPayments : string =
' SELECT '+
'     InvoiceNumber '+
'   , PayDate '+
'   , PayType '+
'   , Amount '+
'   , Description '+
'   , CurrencyRate '+
'   , Currency '+
'   , TypeIndex '+
' FROM '+
'   payments '+
' WHERE '+
'   (InvoiceNumber = %d) ' ;
///    '   (InvoiceNumber = ' + inttoStr(FInvoiceNumber) + ') '+#10 ;


select_LodgingTaxReport2_RefreshAll : string =
' SELECT '+
'     Reservation '+
'   , RoomReservation '+
'   , InvoiceNumber '+
'   , InvoiceDate '+
'   , Customer '+
'   , Name '+
'   , Total '+
'   , TotalWOVAT '+
'   , TotalVAT '+
'   , TotalStayTax '+
'   , TotalStayTaxNights '+
' FROM '+
'   invoiceheads '+
' WHERE '+
'   (InvoiceNumber > 0) '+
'  AND  (  (InvoiceDate >= %s ) '+ //_db(zDateFrom)
'  AND  (InvoiceDate <= %s ) ) '+  //_db(zDateTo)
' ORDER BY '+
'   InvoiceDate ' ;



  //TESTED NOT
  select_MaidList_FormShow : string =
  ' SELECT * FROM tblmaidactions Where MaUse <> 0 ';

  //TESTED NOT
  select_MaidList_RefreshSQL : string =
  ' Select '#10+
  ' * '#10+
  ' FROM '#10+
  '  tblmaidLists '#10+
  ' Where '#10+
  '   mlDate = %s '#10+
  ' ORDER BY '#10+
  ' %s ';

  //TESTED NOT
  select_MaidList_UpdateAll1 : string =
  ' SELECT * FROM tblMaidActions Where MaUse <> 0 ';


  //TESTED NOT
  select_MaidList_UpdateAll2 : string =
  ' SELECT  '+
  '    rooms.Room  '+
  '  , rooms.RoomType  '+
  '  , rooms.Location  '+
  '  , rooms.Status AS RoomStatus '+
  '  , rooms.hidden  '+
  '  , rooms.Floor  '+
  '  , roomtypes.NumberGuests  '+
  '  , rooms.Description AS RoomDescription  '+
  '  , roomtypes.Description AS RoomTypeDescription  '+
  ' FROM  '+
  '   rooms  '+
  '     LEFT OUTER JOIN  '+
  '       roomtypes ON rooms.RoomType = roomtypes.RoomType  '+
  ' ORDER BY Room desc ' ;

  //TESTED NOT
  select_MaidList_UpdateAll3 : string =
  ' SELECT  '+
  '   rrArrival '+
  ' , rrDeparture '+
  ' , Reservation '+
  ' , Status '+

  ' FROM '+
  '   roomreservations '+
  ' WHERE '+
  '   RoomReservation = %d ' ;
//  '   RoomReservation = '+inttostr(RoomReservation)+' '+#10 ;

//TESTED NOT
select_MaidList_MaidList_AfterScroll : string =
' SELECT * '+
' From tblmaidjobs '+
' WHERE (mjRoom = %s ) AND (mjDate = %s ) ' ;
///  ' WHERE (mjRoom ='+quotedStr(zRoom)+') AND (mjDate ='+_dateToSqlDate(zDate)+') '+#10 ;


//TESTED NOT
select_MaidList_UpdateMemTables : string =
' SELECT * '+
' From tblmaidlists '+
' WHERE (mlDate = %s ) ' ;
/// ' WHERE (mlDate ='+_dateToSqlDate(zDate)+') '+#10 ;

//TESTED NOT
select_MaidList_UpdateMemTables2 : string =
' SELECT * '+
' From tblmaidjobs '+
' WHERE (mjDate = %s ) ';
///    ' WHERE (mjDate ='+_dateToSqlDate(zDate)+') '+#10 ;

// TESTED
select_MaidList_CreateCross : string =
' SELECT * '+
' From tblmaidactions '+
' WHERE (maCross<>0) ' ;







/////////////////////////////////////////////////
/////////////////////////////////////////////////

//TESTED NOT
select_OpenInvoicesNew_Execute : string =
' SELECT DISTINCT '#10+
'     Reservation '#10+
'   , RoomReservation '#10+
' FROM '#10+
'   invoicelines '#10+
' WHERE '#10+
' (InvoiceNumber = - 1) '#10+
' ORDER BY '#10+
' Reservation, RoomReservation '#10;

//TESTED NOT
select_OpenInvoicesNew_Execute2 : string =
' SELECT '#10+
'   Name '#10+
' , Total '#10+
' FROM invoiceheads '#10+
' WHERE (InvoiceNumber = -1 )'#10+
'  AND (Reservation = %d )'#10+
'  AND (RoomReservation = %d )'#10;

//TESTED NOT
select_OpenInvoicesNew_Execute3 : string =
' SELECT '#10+
'      Reservation  '#10+
'     ,Arrival  '#10+
'     ,Departure  '#10+
'     ,Status  '#10+
'     ,RoomRentPaymentInvoice  '#10+
'     ,Name  '#10+
' FROM reservations '#10+
'  WHERE '#10+
'    (Reservation = %d ) '#10+    //iReservation
'   AND  (Arrival >= %s ) '#10+   //quotedStr(zsDateFrom)
'   AND  (Arrival <= %s ) '#10 ;  //quotedStr(zsDateTo)

//TESTED NOT
select_OpenInvoicesNew_Execute4 : string =
' SELECT '#10+
'   RoomReservation '#10+
'  ,Room '#10+
'  ,Reservation '#10+
'  ,Status '#10+
'  ,GroupAccount '#10+
'  ,invBreakfast '#10+
'  ,RoomPrice1 '#10+
'  ,Price1From '#10+
'  ,Price1To '#10+
'  ,RoomPrice2 '#10+
'  ,Price2From '#10+
'  ,Price2To '#10+
'  ,RoomPrice3 '#10+
'  ,Price3From '#10+
'  ,Price3To '#10+
'  ,Currency '#10+
'  ,Discount '#10+
'  ,Percentage '#10+
'  ,PriceType '#10+
'  ,Arrival '#10+
'  ,Departure '#10+
'  ,RoomType '#10+
'  ,RoomRentPaid1 '#10+
'  ,RoomRentPaid2 '#10+
'  ,RoomRentPaid3 '#10+
'  ,RoomRentPaymentInvoice '#10+
'  ,rrIsNoRoom '#10+
'  ,rrDeparture '#10+
'  ,rrArrival '#10+
' FROM roomreservations '#10+
'  WHERE '#10+
'    ((Reservation = %d )'#10+   //iReservation
'    AND (RoomReservation = %d ))'#10+ //iRoomReservation
'   AND  (Arrival >= %s ) '#10+  // quotedStr(zsDateFrom)
'   AND  (Arrival <= %s ) '#10 ;  //quotedStr(zsDateTo)


/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

//TESTED NOT
select_PayGroups_fillGridFromDataset : string =
' SELECT '+
'    payGroup '+
'   ,Description '+
'   ,Active '+
'   ,ID '+
' FROM '+
'   paygroups '+
' ORDER BY '+
'  %s ' ;  //zSortStr


select_PayGroups_fillGridFromDataset_byActive : string =
' SELECT '+
'    payGroup '+
'   ,Description '+
'   ,Active '+
'   ,ID '+
' FROM '+
'   paygroups '+
' WHERE '+
'   Active = %d '+
' ORDER BY '+
'  %s ' ;  //zSortStr

select_PhoneRates_fillGridFromDataset : string =
' SELECT * '+
' FROM '+
'   phonerates '+
' ORDER BY '+
'  %s ' ;  //zSortStr


//TESTED NOT
select_PayTypes_fillGridFromDataset : string =
' SELECT '+
'    PayType '+
'   ,Description '+
'   ,PayGroup '+
'   ,AskCode '+
'   ,ptDays '+
'   ,doExport '+
'   ,BookKey '+
'   ,BookKeepCode '+
' FROM paytypes '+
' ORDER BY '+
'  %s ' ;  //zSortStr


select_PayTypes_fillGridFromDataset_byActive : string =
' SELECT '+
'    PayType '+
'   ,Description '+
'   ,PayGroup '+
'   ,AskCode '+
'   ,ptDays '+
'   ,doExport '+
'   ,Active '+
'   ,BookKey '+
'   ,BookKeepCode '+
'   ,ID '+
' FROM paytypes '+
' WHERE '+
'   Active = %d '+
' ORDER BY '+
'  %s ' ;  //zSortStr


//TESTED NOT
select_PriceCodes_fillGridFromDataset : string =
' SELECT '#10+
'  ID '#10+
' ,pcCode '#10+
' ,pcDescription '#10+
' ,pcActive '#10+
' ,pcRack '#10+
' ,pcRackCalc '#10+
' ,pcShowDiscount '#10+
' ,pcDiscountText '#10+
' ,pcAutomatic '#10+
' ,pcLastUpdate '#10+
' ,pcDiscountMethod '#10+
' ,pcDiscountPriceAfter '#10+
' ,pcDiscountDaysAfter '#10+
' ,Active '#10+
' FROM '#10+
'  tblpricecodes '#10+
' ORDER BY '#10+
'  %s ' ;  //zSortStr


select_PriceCodes_fillLoockup : string =
' SELECT '+
'  ID '+
' ,pcCode '+
' ,pcDescription '+
' ,pcRack '+
' ,Active '+
' FROM '+
'   tblpricecodes '+
' ORDER BY '+
'  %s ' ;  //zSortStr


//TESTED NOT
select_PriceOBJ_GetPrices : string =
' SELECT '+
'    ID '+
'  , pcID '+
'  , Currency '+
'  , RoomType '+
'  , Description '+
'  , seID '+
' FROM '+
'  pricetypes '+
' WHERE '+
' (pcId = %d) '+
' AND (Currency =  %s ) '+
' AND (RoomType =  %s ) ' ;

//TESTED NOT
select_ProvideARoom2_MoveToRoomEnh2 : string =
' SELECT '+
'    RoomReservation '+
'  , Reservation '+
'  , Room '+
'  , RoomType '+
'  , Status '+
'  , rrArrival '+
'  , rrDeparture '+
'  , blockMove '+
'  , blockMoveReason '+
' FROM '+
'   roomreservations '+
' WHERE '+
'   RoomReservation = %d ' ;

//TESTED NOT

//TESTED NOT
select_ProvideARoom2_MoveToRoomEnhs : string =
' SELECT '+
'    Room '+
'  , RoomType '+
'  , rrArrival '+
'  , rrDeparture '+
' FROM '+
'   roomreservations '+
' WHERE '+
'   RoomReservation = %d ';

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

//TESTED NOT
select_ReservationProfile_Display : string =
'SELECT * from reservations '+
'where Reservation = %d ';

//TESTED NOT
select_ReservationProfile_UpdateProfile : string =
' SELECT * FROM reservations '+
' WHERE Reservation = %d ' ;


//TESTED NOT
select_ReservationProfile_guestRoomsSQL : string =
'SELECT '+
'     roomreservations.Reservation '+
'   , roomreservations.RoomReservation '+
'   , roomreservations.GroupAccount AS isGroup '+
'   , roomreservations.invBreakfast AS Breakfast '+
'   , roomreservations.rrArrival '+
'   , roomreservations.rrDeparture '+
'   , roomreservations.Room '+
'   , roomreservations.status '+
'   , rooms.Description AS RoomDescription '+
'   , rooms.Equipments '+
'   , roomreservations.rrIsNoRoom AS NoRoomm '+
'   , rooms.RoomType '+
'   , roomtypes.Description AS RoomTypeDescription '+
'   , roomtypes.NumberGuests AS DefNumberGuests '+
'   , rooms.Floor '+
'   , rooms.Location '+
'   , locations.Description AS LocationDescription '+
'   , persons.PersonsProfilesId '+
'   , persons.Name as Mainguest '+
'   , (SELECT count(Person) FROM persons p2 WHERE  p2.RoomReservation = roomreservations.Roomreservation) as GuestCount '+
' FROM '+
'   locations '+
'   RIGHT OUTER JOIN '+
'     rooms ON locations.Location = rooms.Location '+
'   LEFT OUTER JOIN '+
'     roomtypes ON rooms.RoomType = roomtypes.RoomType '+
'   RIGHT OUTER JOIN '+
'     roomreservations ON rooms.Room = roomreservations.Room '+
'   JOIN '+
'     persons ON persons.RoomReservation = roomreservations.RoomReservation AND MainName=1 '+
'   WHERE roomreservations.Reservation =%d '+
'   ORDER BY roomreservations.Room ';



//TESTED NOT
select_ReservationProfile_guestsSQL : string =
' SELECT '+
'      Person '+
'    , PersonsProfilesId '+
'    , RoomReservation '+
'    , Reservation '+
'    , Name As GuestName'+
'    , Address1 '+
'    , Address2 '+
'    , Address3 '+
'    , Address4 '+
'    , PID '+
'    , Country '+
' FROM '+
'   persons '+
' WHERE '+
'  Reservation =%d '+
' ORDER BY Person ';

//TESTED NOT
select_ReservationProfile_allGuestsSQL : string =
' SELECT '+
'     roomreservations.GroupAccount AS isGroup '+
'   , roomreservations.invBreakfast AS Breakfast '+
'   , roomreservations.rrArrival '+
'   , roomreservations.rrDeparture '+
'   , roomreservations.status '+
'   , roomreservations.Room '+
'   , rooms.Description AS RoomDescription '+
'   , rooms.Equipments '+
'   , roomreservations.rrIsNoRoom AS NoRoomm '+
'   , rooms.RoomType '+
'   , roomtypes.Description AS RoomTypeDescription '+
'   , roomtypes.NumberGuests AS DefNumberGuests '+
'   , rooms.Floor '+
'   , rooms.Location '+
'   , locations.Description AS LocationDescription '+
'   , persons.Person '+
'   , persons.PersonsProfilesId '+
'   , persons.RoomReservation '+
'   , persons.Reservation '+
'   , persons.Name AS GuestName '+
'   , persons.Address1 '+
'   , persons.Address2 '+
'   , persons.Address3 '+
'   , persons.Address4 '+
'   , persons.Country '+
'   , persons.PID '+
'   , persons.MainName '+
' FROM '+
'   persons '+
'     LEFT OUTER JOIN '+
'       roomreservations '+
'     LEFT OUTER JOIN '+
'       rooms '+
'     LEFT OUTER JOIN '+
'       locations ON rooms.Location = locations.Location '+
'     LEFT OUTER JOIN '+
'       roomtypes ON rooms.RoomType = roomtypes.RoomType ON roomreservations.Room = rooms.Room ON '+
'       persons.RoomReservation = roomreservations.RoomReservation '+
' WHERE '+
'  persons.Reservation =%d '+  //zReservation
' ORDER BY '+
'   rooms.Room, persons.Person ';

//TESTED NOT


///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////


//NOT TESTED
select_ResGuestList_getRes : string =
' SELECT *'+
' FROM '+
'   reservations '+
' WHERE '+
'   (Reservation =%d) ';

//NOT TESTED
select_ResMemos_FormShow : string =
' SELECT * From reservations '+
' WHERE '+
' Reservation = %d ';

//NOT TESTED
select_ResMemos_FormShow2 : string =
'  SELECT '+
'      RoomReservation '+
'    , Room '+
'    , ID '+
'    , RoomType '+
'    , Status '+
'    , Reservation '+
'    , rrArrival '+
'    , rrDeparture '+
'    , HiddenInfo '+
' FROM '+
'  roomreservations '+
' WHERE (Reservation =%d ) '+
' ORDER BY RoomReservation ';

//NOT TESTED
select_ResPriceChange_Display : string =
'SELECT * from roomreservations '+
'where Reservation = %d '+
'Order by Room ';

//NOT TESTED
select_ResPriceChange_FillRoomTypesBOX : string =
'SELECT RoomType, Description '+
'FROM roomtypes  '+
'ORDER BY RoomType ';

//NOT TESTED
select_ResProblem_GridFill : string =
' SELECT '+
'       roomreservations.RoomReservation '+
'     , roomreservations.Room  '+
'     , roomreservations.Reservation '+
'     , roomreservations.Status '+
'     , roomreservations.rrArrival '+
'     , roomreservations.rrDeparture '+
'     , reservations.Customer '+
'     , reservations.Name As CustomerName '+
' FROM '+
'   roomreservations '+
'   RIGHT OUTER JOIN '+
'         reservations ON roomreservations.Reservation = reservations.Reservation '+
' WHERE (RoomReservation in ( %s ) ) ';  //rrList

//TESTED NOT
select_RoomDateProblem_GridFill : string =
' SELECT '+
'       roomreservations.RoomReservation '+
'     , roomreservations.Room  '+
'     , roomreservations.Reservation '+
'     , roomreservations.Status '+
'     , roomreservations.rrArrival '+
'     , roomreservations.rrDeparture '+
'     , reservations.Customer '+
'     , reservations.Name As CustomerName '+
' FROM '+
'   roomreservations '+
'   RIGHT OUTER JOIN '+
'         reservations ON roomreservations.Reservation = reservations.Reservation '+
' WHERE (RoomReservation in ( %s ) ) '; //('+rrList+')


//////////////////////////////////////////////////
///////////////////////////////////////////////////

//TESTED NOT
select_RoomPrices_FillRoomTypesBOX : string =
'SELECT RoomType, Description,ID '+
'FROM roomtypes  '+
'ORDER BY RoomType ';

//TESTED NOT
select_RoomPrices_FillPriceCodesBOX : string =
'SELECT pcCode, pcDescription,pcRack,ID '+
'FROM tblpricecodes  '+
'ORDER BY pcCode ';

//TESTED NOT
select_RoomPrices_FillCurrenciesBOX : string =
'SELECT currency, Description, ID, active '+
'FROM currencies  '+
'WHERE active <> 0 '+
'ORDER BY currency ';

//TESTED NOT
select_RoomPrices_FillSeasonsBOX : string =
'SELECT * '+
'FROM tblseasons  '+
'ORDER BY seStartDate ';

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

//NOT TESTED
select_RoomProfile_DisplayGuests : string =
' SELECT Person, Name, Surname, Country from persons '+
' where Reservation = %d '+
'  and RoomReservation = %d '+
' order by person';

//NOT TESTED
select_RoomProfile_Display : string =
'SELECT  '+
'  rr.RoomReservation        as RR_RoomReservation '+
', rr.Room                   as RR_Room '+
', rr.Reservation            as RR_Reservation '+
', rr.Status                 as RR_Status '+
', rr.GroupAccount           as RR_GroupAccount '+
', rr.invBreakfast           as RR_invBreakfast '+
', rr.RoomPrice1             as RR_RoomPrice1 '+
', rr.Price1From             as RR_Price1From '+
', rr.Price1To               as RR_Price1To '+
', rr.RoomPrice2             as RR_RoomPrice2 '+
', rr.Price2From             as RR_Price2From '+
', rr.Price2To               as RR_Price2To '+
', rr.RoomPrice3             as RR_RoomPrice3 '+
', rr.Price3From             as RR_Price3From '+
', rr.Price3To               as RR_Price3To '+
', rr.Currency               as RR_Currency '+
', rr.Discount               as RR_Discount '+
', rr.Percentage             as RR_Percentage '+
', rr.PriceType              as RR_PriceType '+
', rr.Arrival                as RR_Arrival '+
', rr.Departure              as RR_Departure '+
', rr.ExpectedTimeOfArrival  as RR_ExpectedTimeOfArrival'+
', rr.ExpectedCheckoutTimes as RR_ExpectedCheckoutTime '+
', rr.RoomType               as RR_RoomType '+
', rr.PMInfo                 as RR_PMInfo '+
', rr.HiddenInfo             as RR_HiddenInfo '+
', rr.RoomRentPaid1          as RR_RoomRentPaid1 '+
', rr.RoomRentPaid2          as RR_RoomRentPaid2 '+
', rr.RoomRentPaid3          as RR_RoomRentPaid3 '+
', rr.RoomRentPaymentInvoice as RR_RoomRentPaymentInvoice '+
', rr.rrDescription          as RR_rrDescription '+
', rr.HallRes                as RR_HallRes'+
', rr.useInNationalReport    as RR_UseInNationalReport'+
', r.Reservation             as R_Reservation '+
', r.Arrival                 as R_Arrival '+
', r.Departure               as R_Departure '+
', r.Customer                as R_Customer '+
', r.Name                    as R_Name '+
', r.Address1                as R_Address1 '+
', r.Address2                as R_Address2 '+
', r.Address3                as R_Address3 '+
', r.Address4                as R_Address4 '+
', r.Country                 as R_Country '+
', r.Tel1                    as R_Tel1 '+
', r.Tel2                    as R_Tel2 '+
', r.Fax                     as R_Fax '+
', r.Status                  as R_Status '+
', r.ReservationDate         as R_ReservationDate '+
', r.Staff                   as R_Staff '+
', r.Information             as R_Information '+
', r.PMInfo                  as R_PMInfo '+
', r.HiddenInfo              as R_HiddenInfo '+
', r.RoomRentPaid1           as R_RoomRentPaid1 '+
', r.RoomRentPaid2           as R_RoomRentPaid2 '+
', r.RoomRentPaid3           as R_RoomRentPaid3 '+
', r.RoomRentPaymentInvoice  as R_RoomRentPaymentInvoice '+
', r.ContactName             as R_ContactName '+
', r.ContactPhone            as R_ContactPhone '+
', r.ContactPhone2           as R_ContactPhone2 '+
', r.ContactFax              as R_ContactFax '+
', r.ContactEmail            as R_ContactEmail '+
', r.ContactAddress1         as R_ContactAddress1 '+
', r.ContactAddress2         as R_ContactAddress2 '+
', r.ContactAddress3         as R_ContactAddress3 '+
', r.ContactAddress4         as R_ContactAddress4 '+
', r.ContactCountry          as R_ContactCountry '+
', r.InputSource             as R_InputSource '+
', r.WebConfirmed            as R_WebConfirmed '+
', r.SrcRequest              as R_SrcRequest '+
'  FROM roomreservations rr, '+
'       reservations r '+
'WHERE rr.Reservation = %d '+
'  AND rr.RoomReservation = %d '+
'  AND r.Reservation = rr.Reservation';

//NOT TESTED
select_RoomProfile_UpdateProfile : string =
'SELECT count(*) as ResCount from reservations '+
'where Reservation = %d ';

//NOT TESTED
select_RoomProfile_UpdateProfile2 : string =
' SELECT Room FROM roomreservations '+
' WHERE Reservation = %d ';  //FReservation

//NOT TESTED
select_RoomProfile_GetInvoiceInfo : string =
'SELECT InvBreakfast, GroupAccount from roomreservations '+
'where Reservation = %d '+
'  and RoomReservation = %d ';
///  'where Reservation = ' + inttostr(FReservation)+
///  '  and RoomReservation = ' + inttostr(FRoomReservation);


////////////////////////////////////////////////////////////////////////////////


select_RoomReservationOBJ_RoomReservation_getFromDB : string =
'   SELECT '+
'       roomreservations.RoomReservation '+
'     , roomreservations.Room  '+
'     , roomreservations.Reservation '+
'     , roomreservations.Status '+
'     , roomreservations.rrArrival '+
'     , roomreservations.rrDeparture '+
'     , reservations.Customer '+
'     , reservations.Channel '+
'     , reservations.Name As CustomerName '+
'     , (SELECT COUNT(id) FROM persons p WHERE p.RoomReservation=roomreservations.RoomReservation) AS NumGuests '+
' FROM '+
'   roomreservations '+
'   RIGHT OUTER JOIN '+
'         reservations ON roomreservations.Reservation = reservations.Reservation ';

select_RoomReservationOBJ_RoomReservation_getListFromDB : string =
' SELECT '+
'       roomreservations.RoomReservation '+
'     , roomreservations.Room  '+
'     , roomreservations.Reservation '+
'     , roomreservations.Status '+
'     , roomreservations.rrArrival '+
'     , roomreservations.rrDeparture '+
'     , reservations.Customer '+
'     , reservations.Channel '+
'     , reservations.Name As CustomerName '+
'     , persons.name As GuestName '+
' FROM '+
'   roomreservations '+
'   RIGHT OUTER JOIN '+
'         reservations ON roomreservations.Reservation = reservations.Reservation '+
'   LEFT OUTER JOIN persons ON roomreservations.roomreservation = persons.roomreservation '+
' WHERE (roomreservations.RoomReservation in ( %s ) ) '+
'GROUP BY roomreservations.RoomReservation'; // rrList

select_RoomReservationOBJ_RoomReservation_getListFromDBViaDates : string =
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
'  WHERE ( ADate >= ''%s'' ) '+
'   AND (ADate < ''%s'' ) '+
'  ORDER BY RoomReservation '+
' ) ) '+
'GROUP BY roomreservations.RoomReservation'; // rrList





///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////


//NOT TESTED
select_RoomTypesEdit_LoadColors : string =
' SELECT '+
'  ID '+
'  ,ColorHex  '+
'  ,Description '+
' FROM '+
' colors '+
' ORDER BY ID DESC ';

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


//TESTED NOT



//TESTED NOT





select_TelDevices_openTelDevices : string =
' SELECT * FROM teldevices '+
' ORDER BY Device ';


select_telLog_refresh : string =
' SELECT '+
'     ID '+
'   , LogDateTime '+
'   , CallStart '+
'   , ConnectedTime '+
'   , RingTime '+
'   , Caller '+
'   , Direction '+
'   , CalledNumber '+
'   , DialledNumber '+
'   , Account '+
'   , IsInternal '+
'   , CallId '+
'   , Continuation '+
'   , Party1Device '+
'   , Party1Name '+
'   , Party2Device '+
'   , Party2Name '+
'   , HoldTime '+
'   , ParkTime '+
'   , AuthValid '+
'   , AuthCode '+
'   , UserCharged '+
'   , CallCharge '+
'   , Currency '+
'   , AmountAtLastUserChange '+
'   , CallUnits '+
'   , UnitsAtLastUserChange '+
'   , CostPerUnit '+
'   , MarkUp '+
'   , ExternalTargetingCause '+
'   , ExternalTargeterId '+
'   , ExternalTargetedNumber '+
'   , Room '+
'   , Reservation '+
'   , RoomReservation '+
'   , InvoiceNumber '+
'   , PriceRule '+
'   , PriceGroup '+
'   , minutePrice '+
'   , startPrice '+
'   , chargedTime '+
'   , ChargedAmount '+
'   , ImportRefrence '+
'   , RecordSource '+
'   , ConnectedTimeSec '+
'   , Description '+

' FROM '+
'   telLog '+
' WHERE '+
'     ((Callstart >=%s ) '+   // _DateToDBDate(zDateFrom, true)
'     AND (Callstart <=%s )) '+  //_DateToDBDate(zDateTo+1, true)
' ORDER BY '+
'   CallStart ';

///      '     ((Callstart >=' + _DateToDBDate(zDateFrom, true) + ' ) '+
///      '     AND (Callstart <=' + _DateToDBDate(zDateTo+1, true) + ' )) '+



/////////////////// UNIT D ///////////////////////////

  select_qryGetCustomers : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' customers '+
  ' ORDER BY %s ';
  /// s := s + 'ORDER BY ' + Orderstr + ' '+#10;

  select_CustomerExist : string =
  ' SELECT '+
  ' Customer '+
  ' FROM '+
  ' customers '+
  ' WHERE '+
  ' Customer = %s  ';
///    s := s + 'Customer = ' + quotedstr(sCustomer) + '  '+#10;

  select_CustomerExistPID : string =
  'SELECT '+
  'PID '+
  'FROM '+
  'customers '+
  'WHERE '+
  'PID = %s  ' ;

  select_GetCustomerPCID : string =
  ' SELECT '+
  ' PcId '+
  ' FROM '+
  ' customers '+
  ' WHERE '+
  ' Customer = %s  ' ;
  ///s := s + 'Customer = ' + quotedstr(sCustomer) + '  '+#10;

  select_GetCustomerPID : string =
  ' SELECT '+
  ' PId '+
  ' FROM '+
  ' customers '+
  ' WHERE '+
  ' Customer = %s  ';
  ///s := s + 'Customer = ' + quotedstr(sCustomer) + '  '+#10;

  select_GetCustomerCurrency : string =
  ' SELECT '+
  ' Currency '+
  ' FROM '+
  ' customers '+
  ' WHERE '+
  ' Customer = %s  ';
  ///s := s + 'Customer = ' + quotedstr(sCustomer) + '  '+#10;


  select_CustomerExistsInOther1 : string =
  ' SELECT Customer FROM invoiceheads '+
  ' WHERE (Customer =  %s ) ';
  ///s := s + ' WHERE (Customer = ' + quotedstr(custNumber) + ') '+#10;

  select_CustomerExistsInOther2 : string =
  ' SELECT Customer FROM reservations '+
  ' WHERE (Customer =  %s ) ';
  ///s := s + ' WHERE (Customer = ' + quotedstr(custNumber) + ') '+#10;


  select_CustomerExistsInOther3 : string =
  ' SELECT Customer FROM payments '+
  ' WHERE (Customer =  %s ) ';
  ///s := s + ' WHERE (Customer = ' + quotedstr(custNumber) + ') '+#10;

  select_CustomerExists : string =
  ' SELECT Customer FROM customers '+
  ' WHERE (Customer =  %s ) ';

  select_CustomerTypeExists : string =
  ' SELECT CustomerType FROM customerTypes '+
  ' WHERE (CustomerType =  %s ) ';


  select_qryGetMaidActions : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' tblmaidactions '+
  ' ORDER BY %s ' ;
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;


  select_MaidActionExist : string =
  ' SELECT '+
  ' maAction '+
  ' FROM '+
  ' tblmaidactions '+
  ' WHERE '+
  ' maAction = %s  ' ;
  ///s := s + 'maAction = ' + quotedstr(sCode) + '  '+#10;


  select_qryGetCustomerPreferences : string =
    ' SELECT '+
    ' * '+
    ' FROM '+
    ' customerpreferences '+
    ' WHERE Customer= %s ' ;
    ///s := s + 'WHERE Customer=' + quotedstr(customer) + ' '+#10;


  select_qryGetTelPriceGroups : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' telpricegroups '+
  ' ORDER BY %s ' ;
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;


  select_GET_telPriceGroupsName_byCode : string =
  'SELECT ID, Description '+
  'FROM telpricegroups  '+
  'WHERE  '+
  '(Code =  %s ) ' ;
  ///s := s + '(Code =' + _db(code) + ') '+#10;


  select_PriceGroupExist : string =
  ' SELECT '+
  ' Code '+
  ' FROM '+
  ' telpricegroups '+
  ' WHERE '+
  ' Code = %s  ' ;


  select_qryGetTelPriceRules : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' telpricerules '+
  ' ORDER BY %s ' ;
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;


  select_GET_telPriceRulesName_byCode : string =
  'SELECT tprName '+
  'FROM telpricerules  '+
  'WHERE  '+
  '(Code =  %s ) ' ;
  ///s := s + '(Code =' + _db(code) + ') '+#10;


  select_PriceRuleExist : string =
  ' SELECT '+
  ' CODE '+
  ' FROM '+
  ' telpricerules '+
  ' WHERE '+
  ' Code = %s  ' ;
  ///s := s + 'Code = ' + _db(code) + '  '+#10;



  select_qryGetTblInc : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' tblinc ' ;
  ///s := s + 'tblinc '+#10;


  select_getTblINC_nextCustomerNumber : string =
  'SELECT '+
  'Custlast, CustLength, CustFill,ID '+
  'FROM '+
  'tblinc ';


  select_getTblINC_Last : string =
  ' SELECT '+
  ' Custlast '+
  ' FROM '+
  ' tblinc ' ;


  select_getTblINC_Length : string =
  ' SELECT '+
  ' custLength '+
  ' FROM '+
  ' tblinc ' ;


  select_getTblINC_Fill : string =
  ' SELECT '+
  ' custFill '+
  ' FROM '+
  ' tblinc ' ;

  select_qryGetCustomerTypes : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' customertypes '+
  ' ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;


  ///s := s + '(CustomerType =' + quotedstr(CustomerType) + ') '+#10;


  select_CustomerTypeExist : string =
  ' SELECT '+
  ' CustomerType '+
  ' FROM '+
  ' customertypes '+
  ' WHERE '+
  ' CustomerType = %s  ';
  ///s := s + 'CustomerType = ' + quotedstr(sCustomerType) + '  '+#10;


  select_CustomerTypeExistsInOther : string =
  ' SELECT CustomerType FROM customers '+
  ' WHERE (CustomerType =  %s ) ';
  ///s := s + ' WHERE (CustomerType = ' + quotedstr(sCustomerType) + ') '+#10;



  select_qryGetRooms : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' rooms '+
  ' ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;



  select_GET_RoomsDescription_byRoom : string =
  ' SELECT Description '+
  ' FROM rooms  '+
  ' WHERE  '+
  ' (Room =  %s ) ';
  ///s := s + '(Room =' + quotedstr(sRoom) + ') '+#10;


  select_RoomExists : string =
  ' SELECT Room '+
  ' FROM rooms  '+
  ' WHERE  '+
  ' (Room =  %s ) ';
  ///s := s + '(Room =' + quotedstr(sRoom) + ') '+#10;


  select_RoomExists_InRoomReservation : string =
  ' SELECT Room '+
  ' FROM roomreservations  '+
  ' WHERE  '+
  ' (Room = %s ) ';
  ///s := s + '(Room =' + quotedstr(sRoom) + ') '+#10;






  select_GET_roomstatus : string =
  ' SELECT status '+
  ' FROM rooms  '+
  ' WHERE  '+
  ' (Room =  %s ) ';
  ///s := s + '(Room =' + quotedstr(sRoom) + ') '+#10;



  select_qryGetroomtypegroups : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' roomtypegroups '+
  ' ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;




  select_qryGetRoomTypes : string =
  'SELECT '+
  '* '+
  'FROM '+
  'roomtypes '+
  'ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;


  select_GET_RoomTypeGroupDescription_byRoomTypeGroup : string =
  ' SELECT Description '+
  ' FROM roomtypegroups  '+
  ' WHERE  '+
  ' (Code =  %s ) ';
  ///s := s + '(Code =' + quotedstr(sRoomTypeGroup) + ') '+#10;


  select_GET_RoomTypeDescription_byRoomType : string =
  ' SELECT Description '+
  ' FROM roomtypes  '+
  ' WHERE  '+
  ' (RoomType =  %s ) ';
  ///s := s + '(RoomType =' + quotedstr(sRoomType) + ') '+#10;


  select_GET_RoomTypeNumberGuests_byRoomType : string =
  ' SELECT NumberGuests '+
  ' FROM roomtypes  '+
  ' WHERE  '+
  ' (RoomType =  %s ) ';
  ///s := s + '(RoomType =' + quotedstr(sRoomType) + ') '+#10;

  select_RoomTypeExistsInRooms : string =
  ' SELECT RoomType FROM rooms '+
  ' WHERE (RoomType = %s ) ';
  ///s := s + ' WHERE (RoomType = ' + quotedstr(sRoomType) + ') '+#10;


  select_customerTypeExistsINCustomers : string =
  ' SELECT customerType FROM customers '+
  ' WHERE (customertype = %s ) ';



  select_RoomTypeExistsInRoomRates : string =
  ' SELECT RoomTypeID FROM roomrates '+
  ' WHERE (RoomTypeID = %d ) ';


  select_RoomTypeExistsInOther2 : string =
  ' SELECT roomtype FROM pricetypes '+
  ' WHERE (RoomType =  %s ) ';
  ///s := s + ' WHERE (RoomType = ' + quotedstr(sRoomType) + ') '+#10;



  select_RoomTypeGroupExistsInOther : string =
  ' SELECT RoomTypeGroup FROM roomtypes '+
  ' WHERE (RoomTypeGroup =  %s ) ';
  ///s := s + ' WHERE (RoomTypeGroup = ' + quotedstr(sRoomTypeGroup) + ') '+#10;



  select_RoomTypeExists : string =
  ' SELECT RoomType FROM roomtypes '+
  ' WHERE (RoomType =  %s ) ';
  ///s := s + ' WHERE (RoomType = ' + quotedstr(sRoomType) + ') '+#10;



  select_RoomTypeGroupExists : string =
  ' SELECT code FROM roomtypegroups '+
  ' WHERE (code =  %s ) ';
  ///s := s + ' WHERE (code = ' + quotedstr(sRoomTypeGroup) + ') '+#10;

  select_getRoomText : string =
  ' SELECT * '+
  ' FROM rooms '+
  ' WHERE '+
  ' room =  %s ';

  select_qryGetViewRooms : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' wrooms '+
  ' ORDER BY %s ';
    ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;

  select_qryGetLocations : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' locations '+
  ' ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;

  select_GET_LocationDescription_byLocation : string =
  ' SELECT Description '+
  ' FROM locations  '+
  ' WHERE  '+
  ' (Location =  %s ) ';
  ///s := s + '(Location =' + quotedstr(sLocation) + ') '+#10;



  select_GET_Location_byLocationDescription : string =
  ' SELECT Location,Description '+
  ' FROM locations  '+
  ' WHERE  '+
  ' (Description =  %s ) ';
  ///s := s + ' (Description =' + quotedstr(sDescription) + ') '+#10;

  select_LocationExists : string =
  ' SELECT Location FROM locations '+
  ' WHERE (Location =  %s ) ';
  ///s := s + ' WHERE (Location = ' + quotedstr(sLocation) + ') '+#10;

  select_LocationExistsInOther : string =
  ' SELECT Location FROM rooms '+
  ' WHERE (Location =  %s ) ';
  ///s := s + ' WHERE (Location = ' + quotedstr(sLocation) + ') '+#10;


///  s := s + '   ((roomsdate.ADate = ' + _DateToDBDate(adate,true) + ') AND (roomsdate.ResFlag = ' + quotedstr('G')
///  s := s + '   ((roomsdate.ADate = ' + _DateToDBDate(adate - 1,true) + ') AND (roomsdate.ResFlag = ' + quotedstr('G')
///  s := s + '   AND (roomreservations.Departure = ' + _DateToDBDate(adate,true) + ')) '+#10;



///  s := s + '   (roomsdate.RoomReservation = '+inttostr(RoomReservation)+') '+#10;
///  s := s + '     AND (roomsdate.ADate = ' + _DateToDBDate(adate,true) + ') '+#10;
///  s := s + '     AND (roomsdate.ResFlag = ' + quotedstr('G')+ ') '+#10;
///  s := s + '   (roomsdate.RoomReservation = '+inttostr(RoomReservation)+') '+#10;
///  s := s + '     AND (roomsdate.ADate = ' + _DateToDBDate(adate-1,true) + ') '+#10;
///  s := s + '     AND (roomsdate.ResFlag = ' + quotedstr('G')+ ') '+#10;
///  s := s + '     AND (roomreservations.Departure =  ' + _DateToDBDate(adate,true) + ') '+#10;


  select_isResCurrentlyCheckedIn : string =
  ' SELECT RoomReservation '+
  ' FROM roomreservations '+
  ' WHERE (Reservation = %d) ';
  ///s := s + ' WHERE (Reservation = '+inttostr(reservation)+') '+#10;

  select_PayTypes_isExport : string =
  ' SELECT doExport FROM paytypes '+
  ' WHERE (PayType =  %s ) ';
  ///s := s + ' WHERE (PayType = ' + quotedstr(sPaytype) + ') '+#10;

  select_invoice_isExport : string =
  ' SELECT '+
  '     payments.InvoiceNumber '+
  '   , payments.PayType '+
  '   , paytypes.doExport '+
  ' FROM '+
  '    payments '+
  '       INNER JOIN paytypes ON payments.PayType = paytypes.PayType '+
  ' WHERE '+
  '    (paytypes.doExport = 0) AND (payments.InvoiceNumber = %d ) ';
  ///s := s+ '    (paytypes.doExport = 0) AND (payments.InvoiceNumber = '+_db(invoiceNo)+') '+#10;


  select_qryGetItemTypes : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' itemtypes '+
  ' ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;


  select_GET_ItemTypeDescription_byItemType : string =
  'SELECT Description '+
  'FROM itemtypes  '+
  'WHERE  '+
  '(ItemType =  %s ) ';
  ///s := s + '(ItemType =' + quotedstr(sItemType) + ') '+#10;

  select_ItemTypeExists : string =
  ' SELECT Itemtype FROM itemtypes '+
  ' WHERE (ItemType =  %s ) ';
  ///s := s + ' WHERE (ItemType = ' + quotedstr(sItemType) + ') '+#10;

  select_ItemTypeExistsInOther : string =
  ' SELECT ItemType FROM items '+
  ' WHERE (ItemType =  %s ) ';
  ///s := s + ' WHERE (ItemType = ' + quotedstr(sItemType) + ') '+#10;

  select_qryGetItems : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' items '+
  ' ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;

  select_Item_Get_AccountKey : string =
  ' SELECT AccountKey '+
  ' FROM items  '+
  ' WHERE  '+
  ' (Item =  %s ) ';
  ///s := s + '(Item =' + quotedstr(sItem) + ') '+#10;

  select_Item_ExistsInOther : string =
  ' SELECT BreakFastItem FROM control '+
  ' WHERE (BreakFastItem =  %s ) ';
  ///s := s + ' WHERE (BreakFastItem = ' + quotedstr(sItem) + ') '+#10;

  select_Item_ExistsInOther2 : string =
  ' SELECT RoomRentItem FROM control '+
  ' WHERE (RoomRentItem =  %s ) ';
  ///s := s + ' WHERE (RoomRentItem = ' + quotedstr(sItem) + ') '+#10;


    select_Item_ExistsInOther3 : string =
    ' SELECT PaymentItem FROM control '+
    ' WHERE (PaymentItem =  %s ) ';
    ///s := s + ' WHERE (PaymentItem = ' + quotedstr(sItem) + ') '+#10;


    select_Item_ExistsInOther4 : string =
    ' SELECT PhoneUseItem FROM control '+
    ' WHERE (PhoneUseItem =  %s ) ';
    ///s := s + ' WHERE (PhoneUseItem = ' + quotedstr(sItem) + ') '+#10;


    select_Item_ExistsInOther5 : string =
    ' SELECT DiscountItem FROM control '+
    ' WHERE (DiscountItem =  %s ) ';
    ///s := s + ' WHERE (DiscountItem = ' + quotedstr(sItem) + ') '+#10;

    select_Item_ExistsInOther6 : string =

    ' SELECT ItemId FROM invoicelines '+
    ' WHERE (ItemID =  %s ) ';
    ///s := s + ' WHERE (ItemID = ' + quotedstr(sItem) + ') '+#10;

    select_Item_Get_Data : string =
    ' SELECT '+
    '    items.Item '+
    '   , items.Description AS ItemDescription '+
    '   , items.Price '+
    '   , items.Itemtype '+
    '   , itemtypes.Description AS ItemTypeDescription '+
    '   , itemtypes.VATCode '+
    '   , vatcodes.Description AS VATcodeDescription '+
    '   , vatcodes.VATPercentage '+
    '   , vatcodes.valueFormula '+
    '   , items.AccountKey '+
    '   , itemtypes.AccItemLink '+
    ' FROM '+
    '   items '+
    '      INNER JOIN itemtypes ON items.Itemtype = itemtypes.Itemtype '+
    '      INNER JOIN vatcodes ON itemtypes.VATCode = vatcodes.VATCode '+
    '  WHERE '+
    '  items.item = %s ';
    ///s := s+ '  items.item = '+_db(aItem)+' '+#10;

  select_qryGetRoomTypeRules : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' roomtyperules '+
  ' ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;

  select_GET_RoomTypeRuleString_byRoomType : string =
  ' SELECT RuleString '+
  ' FROM roomtyperules  '+
  ' WHERE  '+
  ' (RoomType =  %s ) ';
  ///s := s + '(RoomType =' + quotedstr(sRoomType) + ') '+#10;

  select_RoomTypeRuleExists : string =
  ' SELECT RoomType FROM roomtyperules '+
  ' WHERE (RoomType =  %s ) ';
  ///s := s + ' WHERE (RoomType = ' + quotedstr(sRoomType) + ') '+#10;

  select_RoomTypeRuleExistsInOther : string =
  ' SELECT Roomtype FROM [Roomtypes] '+
  ' WHERE (Roomtype = %s )';


  select_Get_LastRoomPriceID_1 : string =
  ' SELECT '+
  ' ID '+
  ' FROM '+
  ' pricetypes '+
  ' ORDER BY ID DESC ';


  select_getPrice_1 : string =
  ' SELECT '+
  '  ID '+
  ' , Price1Person '+
  ' , Price2Persons '+
  ' , Price3Persons '+
  ' , Price4Persons '+
  ' , Price5Persons '+
  ' , PriceExtraPerson '+
  ' , PcID '+
  ' , RoomType '+
  ' , Currency '+
  '  FROM '+
  '  pricetypes '+
  '  WHERE '+
  '  Id = %d ';

  select_getPrice_2 : string =
  ' SELECT '+
  '  ID '+
  ', Price1Person '+
  ', Price2Persons '+
  ', Price3Persons '+
  ', Price4Persons '+
  ', Price5Persons '+
  ', PriceExtraPerson '+
  ' FROM '+
  ' pricetypes '+
  ' WHERE '+
  ' Id = %d ';

  select_getRackPriceID_1 : string =
  ' SELECT '+
  ' pcID, '+
  ' seID, '+
  ' ID, '+
  ' RoomType, '+
  ' Currency, '+
  ' Description '+
  ' FROM '+
  ' pricetypes '+
  ' WHERE ' + #10+
  ' (seID = %d) AND '+
  ' (RoomType =  %s ) AND '+
  ' (Currency =  %s ) ';
  /// s := s + '(seID = ' + inttostr(seasonId) + ') AND '+#10;
  /// s := s + '(RoomType = ' + quotedstr(RoomType) + ') AND '+#10;
  /// s := s + '(Currency = ' + quotedstr(Currency) + ') '+#10;

  select_qryGetSeasons : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' tblseasons '+
  ' ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;

  select_SeasonExists_byID : string =
  ' SELECT ID '+
  ' FROM tblseasons  '+
  ' WHERE  '+
  ' (Id =  %d ) ';
  ///s := s + '(Id =' + inttostr(seasonId) + ') '+#10;

  select_GET_SeasonsDescription_bySeasonID : string =
  ' SELECT seDescription '+
  ' FROM tblseasons  '+
  ' WHERE  '+
  ' (Id =%d ) ' ;
  ///s := s + '(Id =' + inttostr(seasonId) + ') '+#10;

  select_GET_SeasonsId_byDescription : string =
  ' SELECT ID '+
  ' FROM tblseasons  '+
  ' WHERE  '+
  ' (seDescription = %s ) ' ;
  ///s := s + '(seDescription =' + quotedstr(seDescription) + ') ' ;

  select_GET_SeasonsDates_bySeasonID : string =
  ' SELECT '+
  ' seStartDate, '+
  ' seEndDate '+
  ' FROM tblseasons  '+
  ' WHERE  '+
  ' (Id = %d ) ';
  ///s := s + '(Id =' + inttostr(seasonId) + ') '+#10;

  select_all_bySeasonID : string =
  ' SELECT '+
  ' seStartDate, '+
  ' seEndDate '+
  ' FROM tblseasons  '+
  ' WHERE  '+
  ' (Id = %d ) ';


  select_SeasonExist : string =
  ' SELECT '+
  ' seStartDate, seEndDate '+
  ' FROM '+
  ' tblseasons '+
  ' WHERE '+
  ' (seStartDate =  %s ) AND  (seEndDate =  %s ) ';
  ///s := s + '(seStartDate = ' + _DateToDBDate(aDateFrom,true) + ') AND  (seEndDate = ' + _DateToDBDate(aDateTo,true) + ') '+#10;

  select_SeasonCount : string =
  ' SELECT '+
  ' seStartDate, seEndDate '+
  ' FROM '+
  ' tblseasons '+
  ' WHERE '+
  ' (seStartDate <=  %s ) AND  (seEndDate >=  %s ) ';
  ///s := s + '(seStartDate <= ' + _DateToDBDate(adate,true) + ') AND  (seEndDate >= ' + _DateToDBDate(adate,true) + ') '+#10;

  select_FindSeasonID : string =
  'SELECT '+
  '  seStartDate '+
  ' ,seEndDate '+
  ' ,ID '+
  'FROM '+
  'tblseasons '+
  'WHERE '+
  '(seStartDate <=  %s ) AND  (seEndDate >=  %s ) ';
  ///s := s + '(seStartDate <= ' + _DateToDBDate(adate,true) + ') AND  (seEndDate >= ' + _DateToDBDate(adate,true) + ') '+#10;


    select_InvoiceLinesTmp_exists : string =
    ' SELECT '+
    ' RoomReservation '+
    ' FROM '+
    ' invoicelinestmp '+
    ' WHERE '+
    ' RoomReservation= %d ';
    ///s := s + 'RoomReservation=' + inttostr(iRoomReservation) + ' '+#10;

    select_doLogin : string =
    ' SELECT '+
    '  sm.Initials '+
    ' ,sm.Name '+
    ' ,sm.password '+
    ' ,sm.stafftype '+
    ' ,sm.staffPID '+
    ' ,sm.StaffLanguage '+
    ' ,co.CompanyName '+
    ' , (SELECT ExpandedRoomStayOnInvoice FROM hotelconfigurations LIMIT 1) ExpandedRoomStayOnInvoice '+

    ' , (SELECT RoomInvoiceRoomRentIndex FROM hotelconfigurations LIMIT 1) RoomInvoiceRoomRentIndex '+
    ' , (SELECT RoomInvoicePosItemIndex FROM hotelconfigurations LIMIT 1) RoomInvoicePosItemIndex '+
    ' , (SELECT GroupInvoiceRoomRentIndex FROM hotelconfigurations LIMIT 1) GroupInvoiceRoomRentIndex '+
    ' , (SELECT GroupInvoicePosItemIndex FROM hotelconfigurations LIMIT 1) GroupInvoicePosItemIndex '+

    ' , (SELECT DynamicRatesActive FROM hotelconfigurations LIMIT 1) DynamicRatesActive '+

    ' , (SELECT RestrictWithdrawalToGuarantee FROM hotelconfigurations LIMIT 1) RestrictWithdrawalToGuarantee '+
    ' , (SELECT LocationPerRoomType FROM hotelconfigurations LIMIT 1) LocationPerRoomType '+
    ' , (SELECT NumberOfShifts FROM hotelconfigurations LIMIT 1) NumberOfShifts '+

    ' , (SELECT WarnCheckInDirtyRoom FROM hotelconfigurations LIMIT 1) WarnCheckInDirtyRoom '+
    ' , (SELECT WarnWhenOverbooking FROM hotelconfigurations LIMIT 1) WarnWhenOverbooking '+
    ' , (SELECT WarnMoveRoomToNewRoomtype FROM hotelconfigurations LIMIT 1) WarnMoveRoomToNewRoomtype '+

    ' , (SELECT DefaultSendCCEmailToHotel FROM hotelconfigurations LIMIT 1) DefaultSendCCEmailToHotel '+
    ' , (SELECT RatesManagedByRoomer FROM hotelconfigurations LIMIT 1) RatesManagedByRoomer '+
    ' , (SELECT AccessPrivilidges FROM stafftypes WHERE StaffType=sm.StaffType) Priv1 '+
    ' , (SELECT AccessPrivilidges FROM stafftypes WHERE StaffType=sm.StaffType1) Priv2 '+
    ' , (SELECT AccessPrivilidges FROM stafftypes WHERE StaffType=sm.StaffType2) Priv3 '+
    ' , (SELECT AccessPrivilidges FROM stafftypes WHERE StaffType=sm.StaffType3) Priv4 '+
    ' , (SELECT AccessPrivilidges FROM stafftypes WHERE StaffType=sm.StaffType4) Priv5 '+
    ' , (SELECT AuthValue FROM stafftypes WHERE StaffType=sm.StaffType) AuthValue1 '+
    ' , (SELECT AuthValue FROM stafftypes WHERE StaffType=sm.StaffType1) AuthValue2 '+
    ' , (SELECT AuthValue FROM stafftypes WHERE StaffType=sm.StaffType2) AuthValue3 '+
    ' , (SELECT AuthValue FROM stafftypes WHERE StaffType=sm.StaffType3) AuthValue4 '+
    ' , (SELECT AuthValue FROM stafftypes WHERE StaffType=sm.StaffType4) AuthValue5 '+
    ' , IFNULL((SELECT id FROM home100.hotelservices WHERE service=''3P'' AND active=1 AND hotelId=SUBSTR(DATABASE(), 9, 5)), 0) AS stays3PId '+
    'FROM staffmembers sm, control co '+
    'WHERE '+
    '(Initials =  %s ) ';
    ///s := s + '(Initials = ' + quotedstr(login) + ') '+#10;





  select_GetOLDRoomPrices : string =
  ' SELECT '+
  '     Room  '+
  '   , RoomPrice1 '+
  '   , RoomPrice2 '+
  '   , RoomPrice3 '+
  '   , Price1From '+
  '   , Price2From '+
  '   , Price3From '+
  '   , Price1To '+
  '   , Price2To '+
  '   , Price3To '+
  '   , discount '+
  '   , percentage '+
  '  FROM '+
  '   roomreservations '+
  ' WHERE RoomReservation = %d ';

  select_GetRoomReservatiaonArrival : string =
  ' SELECT rrArrival '+
  ' FROM roomreservations  '+
  ' WHERE Roomreservation = %d ';
  ///s := s + ' WHERE Roomreservation =' + inttostr(RoomReservation) + ' '+#10;



  ///  s := s + '       (ADate > ' + quotedstr(sDate) + ')'+#10;
///  s := s + '   AND (Room = ' + quotedstr(Room) + ')'+#10;
///  s := s + '   AND (RoomReservation <> ' + inttostr(RoomReservation) + ') '+#10;
///  s := s + ' ORDER BY Adate '+#10;

  select_LastRoomReservatiaon : string =
  ' SELECT '+
  '     Room '+
  '   , RoomReservation '+
  '   , Reservation '+
  '   , ADate '+
  ' FROM '+
  '   roomsdate '+
  ' WHERE '+
  '       (ADate <=  %s )'+
  '   AND (Room =  %s )'+
  '   AND (RoomReservation <> %d) '+
  ' '+
  ' ORDER BY '+
  '     ADATE DESC' +
  ' LIMIT 1 ' +
  '';
///  s := s + '       (ADate <= ' + quotedstr(sDate) + ')'+#10;
///  s := s + '   AND (Room = ' + quotedstr(Room) + ')'+#10;
///  s := s + '   AND (RoomReservation <> ' + inttostr(RoomReservation) + ') '+#10;


  select_GetFirstRoomReservation : string =
  ' SELECT RoomReservation '+
  ' FROM roomreservations '+
  ' WHERE Reservation = %d '+
  ' ORDER By RoomReservation ';

  select_isAllRRSameCurrency : string =
  ' SELECT Currency '+
  ' FROM roomreservations '+
  ' WHERE Reservation = %d ';

  select_GetBreakfastIncluted : string =
  ' SELECT InvBreakfast FROM roomreservations '+
  ' WHERE Reservation = %d '+
  ' AND RoomReservation = %d ';

  select_GetGroupAccount : string =
  ' SELECT GroupAccount FROM roomreservations '+
  ' WHERE Reservation = %d '+
  ' AND RoomReservation = %d ';

/// ' WHERE Reservation = ' + inttostr(reservation)+
///  ' AND RoomReservation = ' + inttostr(RoomReservation);



///    s := s + '        (ADate = ' + _DateToDBDate(dtDate,true) + ') '+#10;
///    s := s + '    AND (Room = ' + quotedstr(Room) + ') '+#10;

  select_ChangeResDates : string =
  ' SELECT '+
  '   Arrival '+
  ' , Departure '+
  ' , ID '+
  ' FROM '+
  '   reservations '+
  ' WHERE '+
  '   (Reservation = %d) ';
  ///s := s + '   (Reservation = ' + inttostr(reservation) + ') '+#10;

  select_isAllDatesSameInRes : string =
  ' SELECT Arrival, departure FROM roomreservations '+
  ' WHERE Reservation = %d ';

  select_RemoveRoomReservation : string =
  ' SELECT '+
  ' Invoicenumber '+
  '   FROM '+
  '     invoiceheads '+
  ' WHERE '+
  '   (RoomReservation = %d ) and (InvoiceNumber <> -1) ';
/// s := s + '   (RoomReservation = ' + inttostr(RoomReservation) + ') and (InvoiceNumber <> -1) '+#10;


  select_SetAsNoRoomEnh : string =
  ' SELECT '+
  '    Roomreservation '+
  '  , Reservation '+
  ' FROM '+
  '   roomreservations '+
  '  WHERE '+
  ' Reservation = %d ';

  select_GetCustomerFromRes : string =
  '  SELECT ' +
  '     customer ' +
  '    ,reservation '+
  '  FROM ' +
  '    reservations '+
  '  WHERE ' +
  '   (Reservation= %d ) ' ;

  select_GetInvoiceCurrency : string =
  ' SELECT '+
  '    InvoiceNumber '+
  '   , ItemNumber '+
  '   , Currency '+
  ' FROM '+
  '   invoicelines '+
  ' WHERE '+
  '   (invoiceNumber = %d ) LIMIT 1';
  ///s := s + '   (invoiceNumber = ' +_db(invoiceNumber) + ') '+#10;

  select_GetInvoiceCurrencyAndReservationIds : string =
  ' SELECT '+
  '    InvoiceNumber '+
  '   , Reservation '+
  '   , RoomReservation '+
  '   , (SELECT Room FROM roomsdate WHERE RoomReservation=invoicelines.RoomReservation AND NOT ResFlag IN (''X'',''C'') LIMIT 1) AS Room '+
  '   , ItemNumber '+
  '   , Currency '+
  ' FROM '+
  '   invoicelines '+
  ' WHERE '+
  '   (invoiceNumber = %d ) LIMIT 1';

  select_GetInvoiceCurrencyAndRate : string =
  ' SELECT '+
  '     InvoiceNumber '+
  '   , ItemNumber '+
  '   , Currency '+
  '   , ItemID '+
  '   , CurrencyRate '+
  ' FROM '+
  '   invoicelines '+
  ' WHERE '+
  '  (invoicenumber=  %d ) ';
  ///s := s + '  (invoicenumber='+_Db(Invoicenumber)+') '+#10;

  select_isRoomCheckedIN : string =
  '  SELECT '+
  '     RoomReservation '+
  '   , ResFlag '+
  ' FROM '+
  '    roomsdate '+
  ' WHERE '+
  '        (RoomReservation = %d ) '+
  '        AND (ResFlag = ''G'' ) ';
///  s := s + '        (RoomReservation = ' + inttostr(iRoomReservation) + ' ) '+#10;
///  s := s + '        AND (ResFlag = ' + quotedstr('G') + ' ) '+#10;


  select_GetCustomerPreferences : string =
  'select * from customerpreferences '+
  'where Customer = %s ';

  select_GetCustomerName : string =
  ' SELECT '+
  '   SurName  '+
  ' FROM '+
  '   customers '+
  ' WHERE '+
  '   customer = %s ';
  ///s := s + '   customer =' + quotedstr(Customer) + ' '+#10;

  select_GetRoomStatus : string =
  ' SELECT '+
  '   status '+
  ' FROM '+
  '   rooms '+
  ' WHERE '+
  '   room= %s ';
  ///s := s + '   room=' + quotedstr(Room) + ' '+#10;

  select_AskApproval : string =
  ' SELECT  '+
  '  AskCode '+
  ' FROM  '+
  '  paytypes '+
  ' WHERE  '+
  '  PayType = %s ';
///  s := s + '  PayType =' + quotedstr(PayType) + ' '+#10;

  select_GetRoomTypeSize : string =
  ' SELECT  '+
  '   NumberGuests '+
  ' FROM  '+
  '   roomtypes  '+
  ' WHERE  '+
  '  RoomType= %s  ';
///  s := s + '  RoomType=' + quotedstr(RoomType) + '  '+#10;

  select_VATDescription : string =
  ' SELECT '+
  '   description '+
  ' FROM '+
  '   vatcodes '+
  ' WHERE '+
  '  VatCode= %s ';
///  s := s + '  VatCode=' + quotedstr(code) + ' '+#10;

  select_VATPercentage : string =
  ' SELECT '+
  '   VATPercentage '+
  ' FROM '+
  '   vatcodes '+
  ' WHERE '+
  '  VatCode= %s ';
///  s := s + '  VatCode=' + quotedstr(code) + ' '+#10;

  select_Item_Get_Type : string =
  ' SELECT '+
  '   ItemType  '+
  ' FROM '+
  '   items '+
  ' WHERE '+
  '   Item= %s ';
  ///s := s + '   Item=' + quotedstr(Item) + ' '+#10;

  select_Item_Get_ItemTypeInfo : string =
  ' SELECT '+
  '   items.Item,  '+
  '   itemtypes.Itemtype, '+
  '   itemtypes.Description, '+
  '   itemtypes.VATCode '+
  ' FROM '+
  '   items '+
  '      INNER JOIN itemtypes ON items.Itemtype = itemtypes.Itemtype '+
  '  WHERE (items.Item =  %s ) ';
  ///s := s + '  WHERE (items.Item = ' + quotedstr(Item) + ') '+#10;

  select_StaffExists : string =
  ' SELECT '+
  '   Initals '+
  ' FROM '+
  '   staffmembers '+
  ' WHERE '+
  '  Initals= %s ';
  ///s := s + '  Initals=' + quotedstr(Staff) + ' '+#10;

  select_CustomerTypeName : string =
  ' SELECT '+
  '   Description '+
  ' FROM '+
  '   customertypes '+
  ' WHERE '+
  ' Customertype= %s ';
  ///s := s + ' Customertype=' + quotedstr(CustomerTypeCode) + ' '+#10;

  select_SetInvoiceOrginalRef : string =
  ' SELECT '+
  '     RoomReservation '+
  '   , OriginalInvoice '+
  '   , ID '+
  ' FROM '+
  '   invoiceheads '+
  ' WHERE '+
  '   (InvoiceNumber = %d ) '+
  ' AND  (RoomReservation =%d ) ';

///  s := s + '   (InvoiceNumber =' + inttostr(Invoice) + ' ) '+#10;
///  s := s + ' AND  (RoomReservation =' + inttostr(RoomReservation) + ' ) '+#10;


    select_PriceExistsByCodes : string =
    ' SELECT '+
    ' pcCode, '+
    ' seDescription, '+
    ' RoomType, '+
    ' Currency '+
    ' FROM '+
    ' viewroomprices1 '+
    ' WHERE '+
    ' (pcCode =  %s ) AND '+
    ' (seDescription =  %s ) AND '+
    ' (RoomType =  %s ) AND '+
    ' (Currency =  %s ) ';
///   s := s + '(pcCode = ' + quotedstr(pcCode) + ') AND '+#10;
///    s := s + '(seDescription = ' + quotedstr(seDescription) + ') AND '+#10;
///    s := s + '(RoomType = ' + quotedstr(RoomType) + ') AND '+#10;
///    s := s + '(Currency = ' + quotedstr(Currency) + ') '+#10;

    select_PriceExistsByCodesAndCurrency : string =
    ' SELECT '+
    '   pcCode, '+
    '   Currency '+
    ' FROM '+
    '   viewroomprices1 '+
    ' WHERE '+
    '   (pcCode =  %s ) AND '+
    '   (Currency =  %s ) ' ;
    ///    sql := format(D_PriceExistsByCodesAndCurrency,'RACK','EUR')
    ///    s := s + '(pcCode = ' + quotedstr(pcCode) + ') AND '+#10;
    ///    s := s + '(Currency = ' + quotedstr(Currency) + ') '+#10;


  select_imPortLog_getLastID : string =
  ' SELECT '+
  '    ID '+
  '  FROM '+
  '  tblimportlogs '+
  '  WHERE '+
  '  importResultID <> 10010 ' +
  ' LIMIT 1 ' +
  '';

    select_imPortLog_InvoiceNumber  : string =
    '  SELECT '+
    '    ID '+
    '    ,invoiceNumber '+
    '  FROM '+
    '  tblpoxexport LIMIT 1 '
;

   select_inDateRange : string =
   ' SELECT '+
   '   ID '+
   ' ,  seStartDate '+
   ' ,  seEndDate '+
   ' FROM '+
   '   tblseasons '+
   ' WHERE '+
      '  ID= %d ';
      ///s := s + '  ID=' + inttostr(seasonId) + ' '+#10;

  select_RoomsTypeCount : string =
  ' SELECT DISTINCT ROOMTYPE'+
  ' FROM rooms ';

  select_RoomsTypeCount2 : string =
  ' SELECT DISTINCT ROOMTYPE'+
  ' FROM rooms '+
  ' WHERE  '+
  ' (bookable <> 0) ';


    ///s := s + '   (InvoiceNumber = ' + inttostr(Invoice) + ') '+#10;

      select_isUnPaid : string =
      ' SELECT'+
      '     RoomReservation'+
      '   , InvoiceNumber'+
      '   , Total'+
      ' FROM'+
      '    invoicelines'+
      ' WHERE'+
      '   (Total > 0) AND (InvoiceNumber = - 1) AND (RoomReservation = %d )'+
      ' LIMIT 1';

      select_isUnPaidRes : string =
      ' SELECT'+
      '     RoomReservation'+
      '   , InvoiceNumber'+
      '   , Total'+
      ' FROM'+
      '    invoicelines'+
      ' WHERE'+
      '   (Total > 0) AND (InvoiceNumber = - 1) AND (RoomReservation = 0 ) and (Reservation = %d )'+
      ' LIMIT 1';



      ///s := s + '   (Total > 0) AND (InvoiceNumber = - 1) AND (RoomReservation = ' + inttostr(RoomReservation) + ')'+#10;

    select_GetRoomReservation : string =
    '  SELECT ' +
    '     room ' +
    '    ,roomReservation '+
    '    ,reservation '+
    '  FROM ' +
    '    roomreservations ' +
    '  WHERE ' +
    '        (Reservation= %d) ' +
    '   And   (Room=  %s ) ' ;

///    s := s + '        (Reservation=' + inttostr(reservation) + ') ' + #10;
///    s := s + '   And   (Room=' + quotedstr(Room) + ') ' + #10;


select_getRoomTypeFromRR : string =
      ' SELECT RoomType'+
      ' FROM roomreservations '+
      ' WHERE  '+
      ' (RoomReservation = %d ) ';


      select_getCountryGroupNameFromCountry : string =
      ' SELECT '+
      '     countries.Country '+
      '   , countrygroups.GroupName '+
      ' FROM '+
      '    countries LEFT OUTER JOIN '+
      '      countrygroups ON countries.CountryGroup = countrygroups.CountryGroup '+
      ' WHERE '+
      '   (countries.Country =  %s ) ';
      ///s := s + '   (countries.Country = ' + quotedstr(Country) + ') '+#10;

      select_getCountryFromReservation : string =
      ' SELECT '+
      '     Country '+
      ' FROM '+
      '  reservations '+
      ' WHERE '+
      '   (Reservation =  %d ) ';
      ///s := s + '   (Reservation = ' + inttostr(reservation) + ') '+#10;

      select_getCountryGroupFromCountry : string =
      ' SELECT '+
      '     countries.Country '+
      '   , countries.CountryGroup '+
      ' FROM '+
      '   countries '+
      ' WHERE '+
      '   (countries.Country =  %s ) ';
      ///s := s + '   (countries.Country = ' + quotedstr(Country) + ') '+#10;


      select_getLocationFromRoom : string =
      ' SELECT '+
      '     rooms.Location '+
      ' FROM '+
      '   rooms '+
      ' WHERE '+
      '   (Room =  %s ) ';
      ///s := s + '   (Room = ' + quotedstr(Room) + ') '+#10;

      select_getFloorFromRoom : string =
      ' SELECT '+
      '     rooms.Floor '+
      ' FROM '+
      '   rooms '+
      ' WHERE '+
      '   (Room =  %s ) ';
      ///s := s + '   (Room = ' + quotedstr(Room) + ') '+#10;


      select_getinStatisticsFromRoom : string =
      ' SELECT '+
      '  ,rooms.Statistics '+
      ' FROM '+
      '   rooms '+
      ' WHERE '+
      '   (Room =  %s ) ';
      ///s := s + '   (Room = ' + quotedstr(Room) + ') '+#10;

    select_reservationCount : string =
    ' SELECT Reservation '+
    ' FROM reservations  '+
    ' WHERE  '+
    ' (Reservation = %d ) ';
    ///s := s + '(Reservation =' + inttostr(reservation) + ') '+#10;

      select_isKredit : string =
      ' SELECT '+
      '   SplitNumber '+
      ' FROM invoiceheads '+
      ' WHERE InvoiceNumber = %d ';
      ///s := s + ' WHERE InvoiceNumber = ' + inttostr(InvoiceNumber) + ' '+#10;



      select_InvoiceToStolpiTilbod : string =
      ' SELECT * '+
      ' FROM A/R Invoice Header '+
      ' WHERE 1=2 ';

      select_InvoiceToStolpiTilbod2 : string =
      ' SELECT * '+
      ' FROM A/R Invoice Detail '+
      ' WHERE 1=2 ';



      select_Next_OccupiedDate : string =
      ' SELECT '+
      '     ADate '+
      '   , Room '+
      '   , RoomType '+
      ' FROM '+
      '   roomsdate '+
      ' WHERE '+
      '   (Room =  %s ) AND (ADate >  %s ) '+
      '  ORDER BY ADATE ' +
     ' LIMIT 1 ' +
    '';
///      s := s + '   (Room = ' + quotedstr(Room) + ') AND (ADate > ' + _dateToDBDate(FromDate,true) + ') '+#10;

      select_IH_GetRefrence : string =
      ' SELECT '+
      '     Reservation '+
      '   , RoomReservation '+
      '   , InvoiceNumber '+
      '   , invRefrence '+
      ' FROM '+
      '   invoiceheads '+
      ' WHERE '+
      '   (Reservation = %d)  and (RoomReservation = %d)  and (InvoiceNumber = %d) ';
      ///s := s + '   (Reservation = '+_db(reservation)+')  and (RoomReservation = '+_db(roomReservation)+')  and (InvoiceNumber = '+_db(invoicenumber)+') '+#10;

  select_hiddenInfo_Exists : string =
  ' SELECT '+
  '       ID  '+
  '     , Refrence  '+
  '     , RefrenceType  '+
  '   FROM  '+
  '     tblhiddeninfo  '+
  '   WHERE     (Refrence = %s) AND (RefrenceType = %s) ';
  ///s := s+'   WHERE     (Refrence = '+_db(Refrence)+') AND (RefrenceType = '+_db(RefrenceType)+') '+#10;


  select_hiddenInfo_getData : string =
  ' SELECT '+
  '     ID '+
  '   , Notes '+
  '   , ViewLog '+
  '   , DeleteOn '+
  '   , Refrence '+
  '   , RefrenceType '+
  ' FROM '+
  '   tblhiddeninfo '+
  ' WHERE (ID = %d) ';

    select_IH_getPaymentsTypes : string =
    ' SELECT '+
    '     invoiceheads.InvoiceNumber '+
    '   , payments.Description '+
    '   , payments.PayType '+
    '   , paytypes.Description AS PayTypeDescription '+
    '   , paytypes.PayGroup '+
    '   , paygroups.Description AS PayGroupDescription '+
    ' FROM '+
    '   paytypes '+
    '      INNER JOIN payments ON paytypes.PayType = payments.PayType '+
    '      INNER JOIN paygroups ON paytypes.PayGroup = paygroups.PayGroup '+
    '      RIGHT OUTER JOIN invoiceheads ON payments.InvoiceNumber = invoiceheads.InvoiceNumber '+
    ' WHERE '+
    '   (invoiceheads.InvoiceNumber =  %d ) ';
    ///s := s+ '   (invoiceheads.InvoiceNumber = '+_db(InvoiceNumber)+') '+#10;


    select_IA_ActionCount : string =
    ' SELECT '+
    '   COUNT(ID) AS invCount '+
    '    , InvoiceNumber '+
    '    , ActionID '+
    '  FROM '+
    '    tblinvoiceactions '+
    '  GROUP BY InvoiceNumber, ActionID '+
    '  HAVING '+
    '    (InvoiceNumber = %d) AND (ActionID=1001) ';

    select_ctrlGetGlobalValues : string =
    ' SELECT * '+
    'FROM control  ';

    select_ChkCompany : string =
    ' SELECT '+
    '    CompanyID '+
    '  , CompanyName '+
    'FROM control ';

    select_GetInvoicePrinterMethod : string =
    'SELECT InvoicePrinterMethod FROM control ';

    select_ctrlSetInteger : string =
    'SELECT %s,ID '+
    'FROM control  ';
//    'SELECT ' + aField + ' '+

    select_ctrlSetString : string =
    'SELECT %s, ID '+
    'FROM control  ';
//    'SELECT ' + aField + ' '+




    select_RR_Upd_FirstGuestName : string =
    'SELECT * '+
    'FROM persons '+
    'WHERE RoomReservation = %d ';
//    'WHERE RoomReservation = ' + inttostr(iRoomReservation);

    select_RR_GetNumberOfRooms : string =
    ' SELECT count(RoomReservation) AS Cnt FROM roomreservations '+
    ' WHERE Reservation = %d ';

//    ' WHERE Reservation = ' + inttostr(iReservation);

    select_RR_GetGuestCount : string =
    ' SELECT count(Person) AS Cnt FROM persons'+
    ' WHERE  RoomReservation = %d ';
//    ' WHERE  RoomReservation = ' + inttostr(iRoomReservation);

      select_RR_GetRoomNr : string =
      'SELECT Room FROM roomreservations'+
      ' WHERE RoomReservation = %d ';
//      ' WHERE RoomReservation = ' + inttostr(iRoomReservation);

    select_RR_GetArrivalDate : string =
    'SELECT rrArrival FROM roomreservations'+
    ' WHERE RoomReservation = %d ';
//    ' WHERE RoomReservation = ' + inttostr(iRoomReservation);

    select_RR_GetDepartureDate : string =
    'SELECT rrDeparture FROM roomreservations'+
    ' WHERE RoomReservation = %d ';
//    ' WHERE RoomReservation = ' + inttostr(iRoomReservation);

    select_RR_getDates : string =
    ' SELECT '+
    '   Reservation '+
    ' , Status '+
    ' , rrArrival '+
    ' , rrDeparture '+
    ' FROM roomreservations '+
    ' WHERE RoomReservation = %d ';
    ///s := s + ' WHERE RoomReservation = ' + inttostr(iRoomReservation) + ' '+#10;

    select_RV_getDates : string =
    ' SELECT '+
    '   Reservation '+
    ' ,  Arrival '+
    ' ,  Departure '+
    ' FROM reservations '+
    ' WHERE Reservation = %d ';
    ///s := s + ' WHERE Reservation = ' + _db(iReservation) + ' '+#10;

    select_RR_GetReservationName : string =
    ' SELECT '+
    '   reservations.Name '+
    ' FROM  reservations '+
    '           INNER JOIN '+
    '              roomreservations ON reservations.Reservation = roomreservations.Reservation '+
    ' WHERE '+
    '   (roomreservations.RoomReservation = %d ) ';
    ///s := s + '   (roomreservations.RoomReservation = ' + inttostr(iRoomReservation) + ' ) '+#10;

    select_RR_GetMemoText : string =
    'SELECT '+
    '   Hiddeninfo '+
    '  ,PMInfo '+
    '  , ID '+
    'FROM roomreservations  '+
    'WHERE  '+
    '(RoomReservation = %d) ';
    ///s := s + '(RoomReservation =' + inttostr(iRoomReservation) + ') '+#10;

      select_RR_GetFirstGuestName : string =
      ' SELECT '+
      '   Name '+
      ' FROM '+
      '   persons '+
      ' WHERE RoomReservation = %d ';

      select_RR_GetAllGuestNames : string =
      ' SELECT '+
      '   Name '+
      ' FROM '+
      '   persons '+
      ' WHERE RoomReservation = %d ';

      select_RR_GetLastGuestID : string =
      ' SELECT '+
      '   Person '+
      ' FROM '+
      '   persons '+
      ' WHERE RoomReservation = %d '+
      ' ORDER BY Person ';

      select_RR_GetFirstGuestCountry : string =
      ' SELECT '+
      '   Country '+
      ' FROM '+
      '   persons '+
      ' WHERE RoomReservation = %d ';

      select_RR_GetFirstGuestType : string =
      ' SELECT '+
      '   GuestType '+
      ' FROM '+
      '   persons '+
      ' WHERE RoomReservation = %d ';

      select_RR_GetStatus : string =
      'SELECT status '+
      'FROM roomreservations '+
      'WHERE RoomReservation = %d ';

      select_RR_GetIsGroopAccount : string =
      'SELECT GroupAccount '+
      'FROM roomreservations '+
      'WHERE RoomReservation = %d ';

///      s := s + '   (RoomReservation = '+_dbInt(RoomReservation)+') '+#10;

/// s := s + '   (Reservation = '+_dbInt(Reservation)+') '+#10;


  select_RV_getMemos : string =
  ' SELECT '+
  '     information '+
  '   , PmInfo '+
  ' FROM '+
  '   reservations '+
  ' WHERE '+
  '   (Reservation = %d) ' +
    ' LIMIT 1 ' +
    '';
      ///s := s + '   (Reservation = '+_dbInt(Reservation)+') '+#10;

      select_INV_FirstDayAndRoom : string =
      'SELECT '+
      '    InvoiceNumber '+
      '  , Reservation '+
      '  , RoomReservation '+
      ' FROM '+
      '  invoiceheads '+
      ' WHERE '+
      '  (InvoiceNumber = %d) '
   + ' LIMIT 1 '
    ;
      ///s := s + '  (InvoiceNumber = '+_dbInt(invoiceNumber)+') '+#10;

//      s := s + '        (ADate >= '+_DateToDbDate(DateFrom,true)+')'+#10;
///      s := s + '    AND (ADate <= '+_DateToDbDate(DateTo,true)+')'+#10;


      select_RRlst_Departure : string =
      '  SELECT'+
      '    DISTINCT'+
      '    RoomReservation'+
      '  FROM'+
      '    roomreservations'+
      '  WHERE'+
      '        (Departure >=  %s )'+
      '    AND (Departure <=  %s )'+
      '  ORDER BY RoomReservation';
///      s := s + '        (Departure >= '+_DateToDbDate(DateFrom,true)+')'+#10;
///      s := s + '    AND (Departure <= '+_DateToDbDate(DateTo,true)+')'+#10;

      select_RRlst_DepartureNationalReport : string =
      '  SELECT'+
      '    DISTINCT'+
      '    RoomReservation'+
      '  FROM'+
      '    roomreservations'+
      '  WHERE'+
      '        (Departure >=  %s )'+
      '    AND (Departure <=  %s )'+
      '    AND (useInNationalReport =  %s ) '+
      '  ORDER BY RoomReservation' ;
///      s := s + '        (Departure >= '+_DateToDbDate(DateFrom,true)+')'+#10+#10;
///      s := s + '    AND (Departure <= '+_DateToDbDate(DateTo,true)+')'+#10+#10;
///      s := s + '    AND (useInNationalReport = '+_db(true)+')'+#10+#10;



      select_RRlst_Arrival : string =
      '  SELECT'+
      '    DISTINCT'+
      '    RoomReservation'+
      '  FROM'+
      '    roomreservations'+
      '  WHERE'+
      '        (Arrival >=  %s )'+
      '    AND (Arrival <=  %s )'+
      '  ORDER BY RoomReservation';


///      s := s + '        (ADate >= '+_DateToDbDate(DateFrom,true)+')'+#10;
///      s := s + '    AND (ADate <= '+_DateToDbDate(DateTo,true)+')'+#10;


///      s := s + '        (Arrival >= '+_DateToDbDate(DateFrom,true)+')'+#10;
///      s := s + '    AND (Arrival <= '+_DateToDbDate(DateTo,true)+')'+#10;


      select_Rvlst_Departure : string =
      '  SELECT'+
      '    DISTINCT'+
      '    Reservation'+
      '  FROM'+
      '    reservations'+
      '  WHERE'+
      '        (Departure >=  %s )'+
      '    AND (Departure <=  %s )'+
      '  ORDER BY Reservation';
///      s := s + '        (Departure >= '+_DateToDbDate(DateFrom,true)+')'+#10;
///      s := s + '    AND (Departure <= '+_DateToDbDate(DateTo,true)+')'+#10;


      select_IH_Upd_UnPaid_RR : string =
      ' SELECT'+
      '     RoomReservation'+
      '   , InvoiceNumber'+
      '   , Total'+
      ' FROM'+
      '    invoiceheads'+
      ' WHERE'+
      '   (Total > 0) AND (InvoiceNumber = - 1) AND (RoomReservation =  %s )';

    select_BreakFastInclutedCount : string =
    ' SELECT '+
    '   COUNT(invBreakfast) AS cnt '+
    ' FROM '+
    '   roomreservations '+
    ' WHERE '+
    '   (Reservation = %d) AND (invBreakfast <> 0) ';
    ///s := s+'   (Reservation = '+_db(Reservation)+') AND (invBreakfast = 1) '+#10;

    select_GroupAccountCount : string =
    ' SELECT '+
    '   COUNT(GroupAccount) AS cnt '+
    ' FROM '+
    '   roomreservations '+
    ' WHERE '+
    '   (Reservation = %d) AND (GroupAccount <> 0) ';
    ///s := s+'   (Reservation = '+_db(Reservation)+') AND (GroupAccount = 1) '+#10;

      select_rrGetDiscount : string =
      ' SELECT '+
      '     RoomReservation '+
      '   , Discount '+
      '   , Percentage '+
      ' FROM roomreservations '+
      ' WHERE (RoomReservation = %d) ';
      ///s := s+' WHERE (RoomReservation = '+_db(roomreservation)+') '+#10;

      select_rrEditDiscount : string =
      ' SELECT '+
      '     RoomReservation '+
      '   , Discount '+
      '   , Percentage '+
      '   , ID '+
      ' FROM roomreservations '+
      ' WHERE (RoomReservation =  %s ) ';
      ///s := s+' WHERE (RoomReservation = '+_db(roomreservation)+') '+#10;


  select_UpdateStatusSimple1 : string =
  ' SELECT Room,roomtype,arrival,departure,status,roomreservation FROM roomreservations '+
  ' WHERE Reservation = %d ';
  ///s := s + ' WHERE Reservation = ' + inttostr(reservation) + ' '+#10;

  select_UpdateStatusSimple2 : string =
  ' SELECT Room,roomtype,arrival,departure,status FROM roomreservations '+
  ' WHERE RoomReservation = %d ';
  ///s := s + ' WHERE RoomReservation = ' + inttostr(RoomReservation) + ' '+#10;

    select_SetAsNoRoom : string =
    ' SELECT '+
    '    RoomReservation '+
    '  , Room '+
    '  , RoomType '+
    ' FROM '+
    '   roomreservations '+
    ' WHERE '+
    '   RoomReservation = %d ';
    /// s := s + '   RoomReservation = ' + inttostr(RoomReservation) + ' '+#10;

    select_MoveRoom : string =
    ' SELECT '+
    '    RoomReservation '+
    '  , Room '+
    '  , RoomType '+
    ' FROM '+
    '   roomreservations '+
    ' WHERE '+
    '   RoomReservation = %d ';
    ///s := s + '   RoomReservation = ' + inttostr(RoomReservation) + ' '+#10;

        select_ChangeRrDates : string =
        ' SELECT * '+
        ' FROM '+
        '   roomreservations '+
        ' WHERE '+
        '   (RoomReservation = %d ) ';
        ///s := s + '   (RoomReservation = ' + inttostr(RoomReservation) + ') '+#10;

      select_RemoveReservation : string =
      ' SELECT '+
      ' Invoicenumber '+
      '   FROM '+
      '     invoiceheads '+
      ' WHERE '+
      '   (Reservation = %d ) and (InvoiceNumber <> -1) ';
      ///s := s + '   (Reservation = ' + inttostr(iReservation) + ') and (InvoiceNumber <> -1) '+#10;

        select_CheckInGuest : string =
        ' SELECT '+
        '     Room '+
        '   , Arrival '+
        '   , Departure '+
        '   , RoomType '+
        '   , Status '+
        ' FROM '+
        '   roomreservations '+
        ' WHERE '+
        '   RoomReservation = %d  ';




////////////////////////////////////////////////////////////////////
/// SW Stolpi connection
////////////////////////////////////////////////////////////////////
/// SW Stolpi connection
////////////////////////////////////////////////////////////////////
/// SW Stolpi connection
////////////////////////////////////////////////////////////////////
/// SW Stolpi connection
////////////////////////////////////////////////////////////////////
/// SW Stolpi connection
////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///
///
///
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

select_ctrlGetString: string =
'SELECT %s '#10+  //' + aField + '
'FROM control  ';

select_ctrlGetFloat: string =
'SELECT %s '#10+  //' + aField + '
'FROM control  ';

select_ctrlGetInteger : string =
'SELECT %s '#10+  //' + aField + '
'FROM control  ';

select_ctrlGetBoolean : string =
'SELECT %s '#10+  //' + aField + '
'FROM control  ';

select_Item_Exists : string =
' SELECT Item FROM items '#10+
' WHERE (Item = %s) ';  //' + quotedstr(sItem) + '

select_ItemType_Exists : string =
' SELECT ItemType FROM [ItemTypes] '#10+
' WHERE (ItemType = %s) ';  //' + _db(sItemType) + '


select_ItemPlus_Get_Data : string =
' SELECT '#10+
'    items.Item '#10+
'   , items.Description '#10+
'   , items.Price '#10+
'   , items.Itemtype '#10+
'   , Itemtypes.Description AS ItemTypeDescription '#10+
'   , Itemtypes.VATCode '#10+
'   , VATCodes.Description AS VATcodeDescription '#10+
'   , VATCodes.VATPercentage '#10+
'   , VATCodes.valueFormula '#10+
'   , items.AccountKey '#10+
'   , Itemtypes.AccItemLink '#10+
' FROM '#10+
'   items '#10+
'      INNER JOIN Itemtypes ON items.Itemtype = Itemtypes.Itemtype '#10+
'      INNER JOIN VATCodes ON Itemtypes.VATCode = VATCodes.VATCode '#10+
'  WHERE '#10+
'  items.item = %s ';  //' + _db(aItem) + '

select_GetFirstCurrency : string =
'SELECT Currency '#10+
'FROM roomreservations '#10+
'WHERE Reservation = %d '#10+  //' + inttostr(iReservation)
'ORDER By RoomReservation ';

select_NumberOfInvoiceLines : string =
' SELECT count(ItemId) AS Cnt FROM Invoicelines '#10+
' WHERE Reservation = %d '#10+  //' + inttostr(iReservation)
' AND RoomReservation = %d '#10+  //' + inttostr(iRoomReservation)
' AND SplitNumber = %d ';  //' + inttostr(iSplitNumber)

select_NumberOfInvoiceLinesWithInvoiceIndex : string =
' SELECT count(ItemId) AS Cnt FROM Invoicelines '#10+
' WHERE Reservation = %d '#10+  //' + inttostr(iReservation)
' AND RoomReservation = %d '#10+  //' + inttostr(iRoomReservation)
' AND SplitNumber = %d '#10+  //' + inttostr(iSplitNumber)
' AND InvoiceIndex = %d ';  //' + inttostr(InvoiceNumber)

select_RR_GetNumberGroupInvoices : string =
' SELECT count(RoomReservation) AS Cnt FROM roomreservations '#10+
' WHERE (Reservation = %d)'#10+  //' + inttostr(iReservation) + '
' AND (GroupAccount <> 0 )';

select_RV_Exists : string =
'SELECT Reservation FROM reservations '+
'WHERE Reservation =%d ' +  //' + _db(iReservation) + '
    ' LIMIT 1 ' +
    '';

select_RV_GetResInfo : string =
' SELECT '#10+
'   Reservation '#10+
'   , ReservationDate '#10+
'   , Staff '#10+
' FROM '#10+
'   Reservations '#10+
' WHERE '#10+
'   Reservation =%d ';  //' + _db(iReservation) + '

select_GetReservationRRList : string =
' SELECT '#10+
'    RoomReservation '#10+
'   ,Reservation '#10+
'   ,Status '#10+
' FROM '#10+
'   roomreservations '#10+
' WHERE '#10+
' Reservation = %d ';

select_RV_useStayTax : string =
'SELECT '+
' useStayTax FROM reservations '+
'WHERE Reservation =%d '  //' + _db(iReservation) + '
   + ' LIMIT 1 '
    ;

update_RV_useStayTax : string =
'UPDATE reservations SET useStayTax=(NOT useStayTax) '+
'WHERE Reservation =%d ';

select_RR_Exists  : string =
'SELECT '+
'RoomReservation FROM roomreservations '+
'WHERE RoomReservation =%d '  //' + _db(iRoomReservation) + '
   + ' LIMIT 1 '
    ;

select_RR_GetCustomer : string =
' SELECT '#10+
'     Reservations.Reservation '#10+
'   , Reservations.Customer '#10+
'   , roomreservations.RoomReservation '#10+
' FROM '#10+
'   Reservations '#10+
'      RIGHT OUTER JOIN '#10+
'   roomreservations ON Reservations.Reservation = roomreservations.Reservation '#10+
' WHERE '#10+
'   (RoomReservation = %d ) ';  //' + inttostr(iRoomReservation) + '

select_RR_GetReservation : string =
' SELECT '#10+
'   Reservation '#10+
' FROM  roomreservations '#10+
' WHERE '#10+
'   (RoomReservation = %d ) ';  //' + inttostr(iRoomReservation) + '

select_RR_GetRoomNumber : string =
' SELECT '#10+
'   Room '#10+
' FROM  roomreservations '#10+
' WHERE '#10+
'   (RoomReservation = %d ) ';  //' + inttostr(iRoomReservation) + '

select_RR_GetDeparting : string =
' SELECT '#10+
'    roomsdate.Room '#10+
'  , roomsdate.RoomReservation '#10+
'  , roomsdate.ADate '#10+
'  , roomsdate.ResFlag '#10+
'  , roomreservations.Departure '#10+
' FROM '#10+
'  roomsdate '#10+
'     INNER JOIN '#10+
'       roomreservations ON roomsdate.RoomReservation = roomreservations.RoomReservation '#10+
' WHERE '#10+
'    (roomsdate.Room = %s) '#10+  //' + _dbStr(Room) + '
' AND (roomsdate.ADate = %s) '#10+  //' + _dateToDBdate(ADate - 1, true) + '
' AND (roomsdate.ResFlag = ''G'') '#10+
' AND (RoomReservations.Departure = %s) '  //' + _dateToDBdate(ADate, true) + '
   + ' LIMIT 1 '
    ;



select_RR_GetFirstGuestNameFast : string =
' SELECT '#10+
'   Name '#10+
' FROM '#10+
'   persons '#10+
' WHERE RoomReservation = %d ';  //' + inttostr(iRoomReservation)

select_DraftInv_exists : string =
' SELECT '#10+
'   RoomReservation '#10+
' , SplitNumber '#10+
' , Invoicenumber '#10+
' , Finished '#10+
'   FROM [invoiceHeads] '#10+
' WHERE '#10+
'   RoomReservation = %s '#10+  //' + inttostr(RoomReservation) + '
'   and SplitNumber = 0 '#10+ // roomInvoice
'   and InvoiceNumber = -1 '#10+
'   and Finished = 0 ';

select_DraftInvGroup_exists : string =
' SELECT '#10+
'   RoomReservation '#10+
' , Reservation '#10+
' , SplitNumber '#10+
' , Invoicenumber '#10+
' , Finished '#10+
'   FROM [invoiceHeads] '#10+
' WHERE '#10+
'   Reservation = %d '#10+  //' + inttostr(Reservation) + '
'   and RoomReservation = 0 '#10+ // roomInvoice
'   and SplitNumber = 0 '#10+ // roomInvoice
'   and InvoiceNumber = -1 '#10+
'   and Finished = 0 ';

select_GetRate : string =
' SELECT  '#10+
'    sellValue '#10+
'  , AValue '#10+
' FROM  '#10+
'  currencies '#10+
' WHERE  '#10+
'   Currency=%s ';  //' + quotedstr(Currency) + '

select_RR_GetCurrency : string =
'SELECT Currency FROM roomreservations'#10+
' WHERE RoomReservation = %d ';  //' + inttostr(iRoomReservation)

select_DraftInv_Create : string =
' SELECT '#10+
'   Customer '#10+
'  ,Name '#10+
'  ,CustPid '#10+
' ,Address1 '#10+
' ,Address2 '#10+
' ,Address3 '#10+
' ,Address4 '#10+
' ,Country '#10+
' FROM [Reservations] '#10+
' WHERE Reservation = %d ';  //' + inttostr(Reservation)

select_DraftInv_Create2 : string =
' SELECT '#10+
'   currency '#10+
' FROM [RoomReservations] '#10+
' WHERE RoomReservation = %d ';  //' + inttostr(RoomReservation)

select_DraftInv_RRUpdateAmounts : string =
' SELECT '#10+
'     Reservation '#10+
'   , RoomReservation '#10+
'   , SplitNumber '#10+
'   , Total '#10+
'   , TotalWOVat '#10+
'   , Vat '#10+
'   , InvoiceNumber '#10+
' FROM '#10+
'   InvoiceLines '#10+
' WHERE '#10+
'   (RoomReservation = %d ) AND (InvoiceNumber = - 1) ';  //' + _db(RoomReservation) + '

select_Customer_Exists : string =
'SELECT '#10+
'Customer '#10+
'FROM '#10+
'Customers '#10+
'WHERE '#10+
'Customer = %s  ';  //' + _db(Customer) + '

select_PriceCodes_GETRack : string =
'SELECT '#10+
'  pcRack, '#10+
'  ID '#10+
'FROM '#10+
'  tblPriceCodes '#10+
'WHERE '#10+
'  pcRack <> 0';

select_CustomerTypes_GetDefault : string =
'SELECT ' +
'  customerType '#10+
'FROM '#10+
'  customertypes '#10+
'ORDER BY '#10+
'  Priority DESC '
   + ' LIMIT 1 '
    ;

select_Country_GetDefault : string =
'SELECT '+
'  Country '#10+
'FROM '#10+
'  countries '#10+
'ORDER BY '#10+
'  OrderIndex DESC'
   + ' LIMIT 1 '
    ;

select_Item_GetDescription : string =
'SELECT Description '#10+
'FROM items  '#10+
'WHERE  '#10+
'(Item =%s) ';  //' + _db(Item) + '

select_Item_GetPrice : string =
' SELECT '#10+
'    Price '#10+
' FROM '#10+
'  items '#10+
' WHERE '#10+
'  Item=%s ';  //' + quotedstr(Item) + '

select_RV_GuestCount : string =
' SELECT count(Person) AS Cnt FROM persons'#10+
' WHERE Reservation = %d ';  //' + inttostr(iReservation)

select_RR_GuestCount : string =
' SELECT count(Person) AS Cnt FROM persons'#10+
' WHERE RoomReservation = %d ';  //' + inttostr(iRoomReservation)

select_RV_RoomCount : string =
' SELECT count(Reservation) AS Cnt FROM roomreservations'#10+
' WHERE Reservation = %d ';  //' + inttostr(iReservation)

select_RV_NoRoomCount : string =
' SELECT '#10+
'   COUNT(Room) AS CNT '#10+
' FROM '#10+
'   roomreservations '#10+
' WHERE (Reservation = %d) '#10+  //' + inttostr(iReservation) + '
' AND (SUBSTRING(Room, 1, 1) = ''<'') ';

select_RV_ClosedInvoiceCount : string =
' SELECT count(InvoiceNumber) AS Cnt FROM invoiceheads '#10+
' WHERE '#10+
'  (Reservation = %d) '#10+  //' + _db(iReservation) + '
' AND (InvoiceNumber > 0) ';

select_RV_ClosedInvoiceLineCount : string =
' SELECT count(ItemId) AS Cnt FROM invoicelines '#10+
' WHERE '#10+
'  (Reservation = %d) '#10+  //' + _db(iReservation) + '
' AND (InvoiceNumber > 0) ';

select_RV_ClosedInvoiceAmount : string =
' SELECT '#10+
'   SUM(Total) AS Amount '#10+
' FROM '#10+
'   invoicelines '#10+
' WHERE '#10+
'   (Reservation = %d) AND (InvoiceNumber > 0) ';  //' + _db(iReservation) + '

select_RV_openInvoiceRentCount : string =
' SELECT * from control';

select_RV_openInvoiceRentAmount : string =
' SELECT * from control';

select_RV_closedInvoiceRentCount  : string =
' SELECT * from control';

select_RV_closedInvoiceRentAmount : string =
' SELECT * from control';

select_RV_closedInvoiceItemCount : string =
' SELECT * from control';

select_RV_closedInvoiceItemAmount : string =
' SELECT * from control';

select_RV_openInvoiceItemCount : string =
' SELECT * from control';

select_RV_openInvoiceItemAmount : string =
' SELECT * from control';

select_RR_unpaidRoomRent : string =
' SELECT '#10+
'     RoomReservation '#10+
'   , Reservation '#10+
'   , GroupAccount '#10+
'   , RoomPrice1 '#10+
'   , Price1From '#10+
'   , Price1To '#10+
'   , RoomPrice2 '#10+
'   , Price2From '#10+
'   , Price2To '#10+
'   , RoomPrice3 '#10+
'   , Price3From '#10+
'   , Price3To '#10+
'   , Currency '#10+
'   , Discount '#10+
'   , Percentage '#10+
'   , PriceType '#10+
'   , RoomRentPaid1 '#10+
'   , RoomRentPaid2 '#10+
'   , RoomRentPaid3 '#10+
'   , RoomRentPaymentInvoice '#10+
' FROM '#10+
'   roomreservations '#10+
' WHERE '#10+
'   (RoomReservation =%d) ';  //' + _db(iRoomReservation) + '

select_Room_GetRec : string =
' SELECT '#10+
'    Rooms.Room '#10+
'  , Rooms.Description '#10+
'  , Rooms.RoomType '#10+
'  , Rooms.Bath '#10+
'  , Rooms.Shower '#10+
'  , Rooms.Safe '#10+
'  , Rooms.TV '#10+
'  , Rooms.Video '#10+
'  , Rooms.Radio '#10+
'  , Rooms.CDPlayer '#10+
'  , Rooms.Telephone '#10+
'  , Rooms.Press '#10+
'  , Rooms.Coffee '#10+
'  , Rooms.Kitchen '#10+
'  , Rooms.Minibar '#10+
'  , Rooms.Fridge '#10+
'  , Rooms.Hairdryer '#10+
'  , Rooms.InternetPlug '#10+
'  , Rooms.Fax '#10+
'  , Rooms.SqrMeters '#10+
'  , Rooms.BedSize '#10+
'  , Rooms.Equipments '#10+
'  , Rooms.Bookable '#10+
'  , Rooms.Statistics '#10+
'  , Rooms.Status '#10+
'  , Rooms.OrderIndex '#10+
'  , Rooms.hidden '#10+
'  , Rooms.Location '#10+
'  , Rooms.Floor '#10+
'  , Rooms.ID '#10+
'  , Rooms.Dorm '#10+
'  , RoomTypes.Description AS RoomTypeDescription '#10+
'  , RoomTypes.RoomTypeGroup '#10+
'  , RoomTypes.NumberGuests AS RoomTypeNumberGuests '#10+
'  , roomtypegroups.Description AS RoomTypeGroupDescription '#10+
'  , Locations.Description AS LocationDescription '#10+
'  , RoomTypes.NumberGuests '#10+
' FROM '#10+
'  locations RIGHT OUTER JOIN '#10+
'     rooms ON locations.Location =  rooms.Location LEFT OUTER JOIN '#10+
'    roomtypegroups RIGHT OUTER JOIN '#10+
'    roomtypes ON roomtypegroups.Code = roomtypes.RoomType ON  rooms.RoomType = roomtypes.RoomType '#10+
' WHERE '#10+
'   rooms.Room =%s ';  //'+_db(room)+'

select_Customer_GetHolder : string =
' SELECT '#10+
'     Customers.Customer '#10+
'   , Customers.Surname AS CustomerName '#10+
'   , Customers.Name AS DisplayName '#10+
'   , Customers.PID '#10+
'   , Customers.Address1 '#10+
'   , Customers.Address2 '#10+
'   , Customers.Address3 '#10+
'   , Customers.Address4 '#10+
'   , Customers.Tel1 '#10+
'   , Customers.Tel2 '#10+
'   , Customers.Fax '#10+
'   , Customers.Country '#10+
'   , countries.CountryName '#10+
'   , Customers.CustomerType AS MarketSegmentCode '#10+
'   , CustomerTypes.Description AS MarketSegmentName '#10+
'   , Customers.DiscountPercent AS DiscountPerc '#10+
'   , Customers.EmailAddress '#10+
'   , Customers.Homepage '#10+
'   , Customers.ContactPerson '#10+
'   , Customers.TravelAgency AS isTravelAgency '#10+
'   , Customers.Currency '#10+
'   , Customers.pcID '#10+
'   , Customers.stayTaxIncluted '#10+
'   , Customers.notes '#10+
'   , Customers.RatePlanId '#10+
'   , tblPriceCodes.pcCode '#10+
' FROM '#10+
'   customers '#10+
'      LEFT OUTER JOIN tblPriceCodes ON customers.pcID = tblPriceCodes.Id '#10+
'      LEFT OUTER JOIN CustomerTypes ON customers.CustomerType = CustomerTypes.CustomerType '#10+
'      LEFT OUTER JOIN countries ON customers.Country = countries.Country '#10+
' WHERE '#10+
'  customers.Customer =%s ';  //'+_db(customer)+'


select_CustomerPlus : string =
' SELECT '#10+
'     Customers.Customer '#10+
'   , Customers.Surname '#10+
'   , Customers.Name '#10+
'   , Customers.PID '#10+
'   , Customers.Address1 '#10+
'   , Customers.Address2 '#10+
'   , Customers.Address3 '#10+
'   , Customers.Address4 '#10+
'   , Customers.Tel1 '#10+
'   , Customers.Tel2 '#10+
'   , Customers.Fax '#10+
'   , Customers.Country '#10+
'   , countries.CountryName '#10+
'   , Customers.CustomerType '#10+
'   , CustomerTypes.Description AS CustomerTypeDescription '#10+
'   , Customers.DiscountPercent '#10+
'   , Customers.EmailAddress '#10+
'   , Customers.Homepage '#10+
'   , Customers.ContactPerson '#10+
'   , Customers.TravelAgency '#10+
'   , Customers.Currency '#10+
'   , Customers.pcID '#10+
'   , Customers.dele '#10+
'   , Customers.ID '#10+
'   , Customers.Active '#10+
'   , Customers.stayTaxIncluted '#10+
'   , Customers.notes '#10+
'   , Customers.RatePlanId '#10+
'   , tblPriceCodes.pcCode '#10+
' FROM '#10+
'   customers '#10+
'      LEFT OUTER JOIN tblPriceCodes ON customers.pcID = tblPriceCodes.Id '#10+
'      LEFT OUTER JOIN CustomerTypes ON customers.CustomerType = CustomerTypes.CustomerType '#10+
'      LEFT OUTER JOIN countries ON customers.Country = countries.Country ';

select_CustomerPlus_byActive : string =
' SELECT '#10+
'     customers.Customer '#10+
'   , customers.Surname '#10+
'   , customers.Name '#10+
'   , customers.PID '#10+
'   , customers.Address1 '#10+
'   , customers.Address2 '#10+
'   , customers.Address3 '#10+
'   , customers.Address4 '#10+
'   , customers.Tel1 '#10+
'   , customers.Tel2 '#10+
'   , customers.Fax '#10+
'   , customers.Country '#10+
'   , countries.CountryName '#10+
'   , customers.CustomerType '#10+
'   , customertypes.Description AS CustomerTypeDescription '#10+
'   , customers.DiscountPercent '#10+
'   , customers.EmailAddress '#10+
'   , customers.Homepage '#10+
'   , customers.ContactPerson '#10+
'   , customers.TravelAgency '#10+
'   , customers.Currency '#10+
'   , customers.pcID '#10+
'   , customers.dele '#10+
'   , customers.ID '#10+
'   , customers.Active '#10+
'   , customers.stayTaxIncluted '#10+
'   , tblpricecodes.pcCode '#10+
'   , customers.notes '#10+
'   , customers.RatePlanId '#10+
' FROM '#10+
'   customers '#10+
'      LEFT OUTER JOIN tblpricecodes ON customers.pcID = tblpricecodes.Id '#10+
'      LEFT OUTER JOIN customertypes ON customers.customertype = customertypes.CustomerType '#10+
'      LEFT OUTER JOIN countries ON customers.Country = countries.Country '#10+
' WHERE '#10+
'   customers.Active = %d '#10+
' ORDER BY '#10+
'  %s ';




select_GetAttivalText : string =
' SELECT  '#10+
'   rrArrival '#10+
' , rrDeparture '#10+
' , Reservation '#10+
' , Status '#10+
' FROM '#10+
'   roomreservations '#10+
' WHERE '#10+
'   RoomReservation = %d ';  //'+inttostr(RoomReservation)+'

select_GetTelRoomInfo : string =
'SELECT '#10+
'   Device '#10+
'  ,Room '#10+
'  ,Description '#10+
'  ,doCharge '#10+
'FROM telDevices '#10+
'WHERE device = %s ';  //' + quotedStr(device)

select_FillLstTelPriceMasks : string =
' SELECT '#10+
'     TelPriceRules.Code '#10+
'   , TelPriceRules.Description AS RuleDescription '#10+
'   , TelPriceRules.Mask '#10+
'   , TelPriceRules.tpgCode '#10+
'   , TelPriceRules.displayOrder '#10+
'   , TelPriceRules.doUse '#10+
'   , TelPriceGroups.Price '#10+
'   , TelPriceGroups.Description AS PriceDescription '#10+
' FROM '#10+
'   TelPriceRules '#10+
'     LEFT OUTER JOIN TelPriceGroups ON TelPriceRules.tpgCode = TelPriceGroups.Code '#10+
' WHERE '#10+
'   (TelPriceRules.doUse = 1) '#10+
' ORDER BY '#10+
'   TelPriceRules.displayOrder ';

select_GET_CountryGroupHolderByGountryGroup : string =
' SELECT '#10+
'   CountryGroup '#10+
'  , GroupName '#10+
'  , IslGroupName '#10+
'  , OrderIndex '#10+
' FROM '#10+
'   countrygroups '#10+
' WHERE '#10+
'  (CountryGroup = %s) ';  //N'+quotedstr(getItem)+'

select_GET_ChannelManagerHolderById : string =
' SELECT * FROM '#10+
'   channelmanagers '#10+
' WHERE '#10+
'  (Id = %d) ';  //N'+quotedstr(getItem)+'

select_GET_CountryGroupDefault : string =
' SELECT '+
'   CountryGroup '#10+
' FROM '#10+
'   countrygroups '#10+
' ORDER BY orderIndex DESC '
   + ' LIMIT 1 '
    ;

select_CountryGroupExistsInOther : string =
' SELECT CountryGroup FROM [Countries] '#10+
' WHERE (CountryGroup = %s) ';  //' + quotedstr(sCountryGroup) + '

select_CountryGroupExist : string =
' SELECT CountryGroup FROM [CountryGroups] '#10+
' WHERE (CountryGroup = %s) ';  //' + quotedstr(sCode) + '

select_GET_CountryHolderByCountry : string =
' SELECT '#10+
'     countries.Country '#10+
'   , countries.CountryName '#10+
'   , countries.IslCountryName '#10+
'   , countries.Currency '#10+
'   , countries.CountryGroup '#10+
'   , countries.OrderIndex '#10+
'   , countries.Active '#10+
'   , countries.ID '#10+
'   , currencies.Description AS CurrenciesDescription '#10+
'   , countrygroups.GroupName AS countrygroupsGroupName '#10+
' FROM '#10+
'   countries '#10+
'      LEFT OUTER JOIN currencies ON countries.Currency = currencies.Currency '#10+
'      LEFT OUTER JOIN countrygroups ON countries.CountryGroup = countrygroups.CountryGroup '#10+
' WHERE '#10+
'  (Country = %s) '#10+  //N'+quotedstr(getItem)+'
' ORDER BY Country';


select_GET_CountryName : string =
' SELECT '#10+
'   CountryName '#10+
' FROM '#10+
'   countries '#10+
' WHERE '#10+
'  (Country = %s) ';  //N'+quotedstr(sCode)+'

select_GET_CountryCurrency : string =
' SELECT '#10+
'   Currency '#10+
' FROM '#10+
'   countries '#10+
' WHERE '#10+
'  (Country = %s) ';  //N'+quotedstr(sCode)+'

select_CountryExistsInOther : string =
' SELECT Country FROM [customers] '#10+
' WHERE (Country = %s) ';  //' + quotedstr(sCountry) + '

select_CountryExistsInOther2 : string =
' SELECT Country FROM [invoiceheads] '#10+
' WHERE (Country = %s) ';  //' + quotedstr(sCountry) + '

select_CountryExistsInOther3 : string =
' SELECT Country FROM [persons] '#10+
' WHERE (Country = %s) ';  //' + quotedstr(sCountry) + '

select_CountryExistsInOther4 : string =
' SELECT Country FROM [staffMembers] '#10+
' WHERE (Country = %s) ';  //' + quotedstr(sCountry) + '

select_CountryExistsInOther5 : string =
' SELECT Country FROM [staffMembers] '#10+
' WHERE (Country = %s) ';  //' + quotedstr(sCountry) + '

select_CountryExistsInOther6 : string =
' SELECT Country FROM [reservations] '#10+
' WHERE (Country = %s) ';  //' + quotedstr(sCountry) + '

select_CountryExists : string =
' SELECT Country FROM [Countries] '#10+
' WHERE (Country = %s) ';  //' + quotedstr(sCode) + '

select_GET_CurrencyHolderByCurrency : string =
' SELECT '#10+
'    Currency '#10+
'   ,ID '#10+
'   ,Description '#10+
'   ,AValue '#10+
'   ,DisplayFormat '#10+
'   ,Decimals '#10+
'   ,CurrencySign'#10+
'   ,SellValue '#10+
'   ,Active '#10+
' FROM '#10+
'   currencies '#10+
' WHERE '#10+
'  (currency = %s) ';  //N'+quotedstr(getItem)+'

select_currencyExistsInOther  : string =
' SELECT NativeCurrency FROM [control] '#10+
' WHERE (NativeCurrency = %s) ';  //' + quotedstr(sCurrency) + '

select_currencyExistsInOther1  : string =
' SELECT Currency FROM [Countries] '#10+
' WHERE (Currency = %s) ';  //' + quotedstr(sCurrency) + '

select_currencyExistsInOther2  : string =
' SELECT Currency FROM [Customers] '#10+
' WHERE (Currency = %s) ';  //' + quotedstr(sCurrency) + '

select_currencyExistsInOther3  : string =
' SELECT Currency FROM [PriceTypes] '#10+
' WHERE (Currency = %s) ';  //' + quotedstr(sCurrency) + '

select_currencyExistsInOther4  : string =
' SELECT Currency FROM [invoicelines] '#10+
' WHERE (Currency = %s) ';  //' + quotedstr(sCurrency) + '

select_currencyExistsInOther5  : string =
' SELECT Currency FROM [Payments] '#10+
' WHERE (Currency = %s) ';  //' + quotedstr(sCurrency) + '

select_currencyExistsInOther6  : string =
' SELECT Currency FROM [RoomReservations] '#10+
' WHERE (Currency = %s) ';  //' + quotedstr(sCurrency) + '


select_CurrencyExist : string =
'SELECT '#10+
'Currency '#10+
'FROM '#10+
'Currencies '#10+
'WHERE '#10+
'Currency = %s  ';  //' + quotedstr(sCurrency) + '


select_CurrencySwUpdateHomeRates  : string =
' SELECT '#10+
'    Currency '#10+
'   ,Description '#10+
'   ,AValue '#10+
' FROM '#10+
'   currencies '#10+
' ORDER BY '#10+
'   currency ';


select_CurrencySwUpdateHomeRates2  : string =
' SELECT '#10+
'     t_RateValues.sNumber '#10+
'   , t_RateValues.dRateCost '#10+
'   , t_RateValues.dRateSalesCost '#10+
'   , t_RateValues.dTollCost '#10+
' FROM '#10+
'   t_RateValues '#10+
' WHERE '#10+
'   (((t_RateValues.sNumber)=%s)) ';  //' + quotedstr(Currency) + '


select_invoiceList_ConfirmGroup : string =
' SELECT '#10+
'   InvoiceNumber '#10+
' FROM '#10+
'   InvoiceHeads '#10+
' WHERE '#10+
'       (InvoiceNumber > 0) '#10+
'    AND (ihConfirmDate = %s)';  //'+_DateTimeToDbDate(confirmDate,true)+'


select_GET_ConvertHolder : string =
' SELECT '#10+
'    ID '#10+
'   ,cvType '#10+
'   ,cvFrom '#10+
'   ,cvTo '#10+
' FROM tblconverts '#10+
' WHERE '#10+
'   ID = %d ';  //'+inttostr(getItem)+'

select_convertExist : string =
'SELECT '#10+
'svFrom '#10+
'FROM '#10+
'tblconverts '#10+
'WHERE '#10+
'svFrom = %s ';  //' + _db(sFrom) + '

select_convertGetLastID : string =
'SELECT '#10+
' ID '#10+
'FROM '#10+
' tblconverts';

select_doconvert : string =
'SELECT '#10+
'  cvType '#10+
' ,cvTo '#10+
' ,cvFrom '#10+
' ,Active '#10+
'FROM '#10+
'  tblconverts '#10+
'WHERE '#10+
'(cvFrom=%s)  AND (cvType=%s) ';  //'+_db(sHomeValue)+'  //'+_db(sType)+'

select_GET_convertGroupHolder : string =
' SELECT '#10+
'    cgCode '#10+
'   ,cgDescription '#10+
'   ,ID '#10+
'   ,Active '#10+
' FROM '#10+
'   tblConvertGroups '#10+
' WHERE '#10+
'  (cgCode = %s) ';  //N'+quotedstr(getItem)+'

select_convertGroupExistsInOther : string =
' SELECT cvType FROM [tblconverts] '#10+
' WHERE (cvType = %s) ';  //' + quotedstr(sCode) + '

select_convertGroupExists : string =
'SELECT '#10+
' cgCode '#10+
'FROM '#10+
' tblConvertGroups'#10+
'WHERE '#10+
'cgCode = %s  ';  //' + quotedstr(sCode) + '

select_GET_PayTypeHolder : string =
' SELECT '#10+
'    PayType '#10+
'   ,Description '#10+
'   ,PayGroup '#10+
'   ,AskCode '#10+
'   ,ptDays '#10+
'   ,doExport '#10+
'   ,Active '#10+
'   ,ID '#10+
'   ,BookKey '#10+
' FROM Paytypes '#10+
' WHERE '#10+
'  (PayType = %s) ';  //N'+quotedstr(getItem)+'

select_PayTypeExistsInOther : string =
' SELECT PayType FROM [Payments] '#10+
' WHERE (PayType = %s) ';  //' + quotedstr(sCode) + '

select_PayTypeExist : string =
' SELECT '#10+
'   PayType '#10+
' FROM '#10+
'   PayTypes '#10+
' WHERE '#10+
'   PayType = %s ';  //' + _db(sCode) + '

select_GET_PayGroupHolder : string =
' SELECT '#10+
'    PayGroup '#10+
'   ,Description '#10+
'   ,active '#10+
'   ,ID '#10+
' FROM '#10+
'   PayGroups '#10+
' WHERE '#10+
'  (PayGroup = %s) ';  //N'+quotedstr(getItem)+'

select_PayGroupExistsInOther : string =
' SELECT payGroup FROM Paytypes '#10+
' WHERE (payGroup = %s) ';  //' + quotedstr(sCode) + '

select_PayGroupExist : string =
'SELECT '#10+
'  payGroup '#10+
'FROM '#10+
'  payGroups '#10+
'WHERE '#10+
'  payGroup = %s ';  //' + _db(sCode) + '

select_GET_VatCodeHolder : string =
' SELECT '#10+
'    vatCode '#10+
'   ,Description '#10+
'   ,VATPercentage '#10+
'   ,valueFormula '#10+
'   ,BookKeepCode '#10+
' FROM '#10+
'   vatcodes '#10+
' WHERE '#10+
'  (VATCode = %s) ';  //N'+quotedstr(getItem)+'

select_VatCodeExistsInOther : string =
' SELECT VatCode FROM [Itemtypes] '#10+
' WHERE (VatCode = %s) ';  //' + quotedstr(sCode) + '

select_VatCodeExist : string =
'SELECT '#10+
'  VATCode '#10+
'FROM '#10+
'  VATcodes '#10+
'WHERE '#10+
'  VATCode = %s ';  //' + _db(sCode) + '

select_GET_PriceCodeRackID : string =
'SELECT '#10+
'  pcRack '#10+
'  ,ID '#10+
'FROM '#10+
'  tblPriceCodes '#10+
'WHERE '#10+
'  pcRack <> 0 '; //true


select_GET_PriceCodeHolder  : string =
' SELECT '#10+
'  ID '#10+
' ,pcCode '#10+
' ,pcDescription '#10+
' ,pcActive '#10+
' ,pcRack '#10+
' ,pcRackCalc '#10+
' ,pcShowDiscount '#10+
' ,pcDiscountText '#10+
' ,pcAutomatic '#10+
' ,pcLastUpdate '#10+
' ,pcDiscountMethod '#10+
' ,pcDiscountPriceAfter '#10+
' ,pcDiscountDaysAfter '#10+
' ,Active '#10+
' FROM '#10+
'   tblPriceCodes '#10+
' WHERE '#10+
'  (pcCode = %s )'; //'+quotedStr(theData.pcCode)+')

select_PriceCodeExist : string =
'SELECT '#10+
'  pcCode '#10+
'FROM '#10+
'  tblPriceCodes '#10+
'WHERE '#10+
'  pcCode = %s ';  //' + _db(code) + '

select_PriceCode_Code : string =
'SELECT pcCode '#10+
'FROM tblPriceCodes  '#10+
'WHERE  '#10+
'(Id =%d) ';  //' + inttostr(Id) + '

select_PriceCode_ID : string =
'SELECT '#10+
'  Id '#10+
'  ,pcCode '#10+
'FROM '#10+
'  tblPriceCodes '#10+
'WHERE '#10+
'  pcCode=%s ';  //' + quotedstr(pcCode) + '


select_PriceCode_Rack : string =
'SELECT '#10+
'pcRack, '#10+
'pcCode '#10+
'FROM '#10+
'tblPriceCodes '#10+
'WHERE '#10+
'pcRack <> 0 ';


select_priceCode_RackID : string =
'SELECT '#10+
'   pcRack '#10+
'  ,ID '#10+
'FROM '#10+
'  tblPriceCodes '#10+
'WHERE '#10+
'  pcRack <> 0 ';

select_PriceCode_Description : string =
'SELECT pcDescription '#10+
'FROM tblPriceCodes  '#10+
'WHERE  '#10+
'(Id =%d) ';  //' + inttostr(ID) + '


select_PriceCode_isRack : string =
'SELECT '#10+
'pcRack, '#10+
'pcCode '#10+
'FROM '#10+
'tblPriceCodes '#10+
'WHERE '#10+
'pcCode = %s ';  //' + quotedstr(pcCode) + '

select_activePriceTypesExists : string =
' SELECT PcCode FROM viewroomprices1 WHERE PcCode =%s ';  //' + quotedstr(sPriceType)+'

select_RoomTypes_CreateList : string =
' SELECT '#10+
'  RoomType '#10+
' FROM '#10+
'   roomtypes '#10+
' ORDER BY roomType ';

select_RoomStatus_GetLastDate  : string =
' SELECT '+
'   resDate '#10+
' FROM '#10+
'   tblRoomStatus '#10+
' ORDER BY '#10+
'   resDate DESC '
   + ' LIMIT 1 '
    ;


select_InvoiceExists : string =
' SELECT '#10+
'   InvoiceNumber '#10+
' FROM InvoiceHeads '#10+
' WHERE InvoiceNumber = %d';  //' + inttostr(InvoiceNumber) + '

//select_RV_SetNewID : string =
//' SELECT LastReservation, ID FROM [control] ';
//
//select_PE_SetNewID : string =
//' SELECT LastPerson,ID FROM [control]';

select_IVH_SetNewID : string =
' SELECT LastInvoice,ID FROM [control] ';

select_IVH_GetLastID : string =
' SELECT LastInvoice,ID FROM [control]';

select_IVH_RestoreID : string =
'SELECT LastInvoice,ID FROM [control] ';


select_RV_GetLastID : string =
'SELECT LastReservation,ID FROM [control] ';


//select_RR_SetNewID : string =
//'SELECT LastRoomRes,ID FROM [control] ';


select_GET_RoomsType_byRoom : string =
'SELECT RoomType,ID '#10+
'FROM  rooms  '#10+
'WHERE  '#10+
'(Room =%s) ';  //' + quotedstr(sRoom) + '

select_GET_useInNationalReport_byRoom : string =
'SELECT useInNationalReport,ID '#10+
'FROM  rooms  '#10+
'WHERE  '#10+
'(Room =%s) ';  //' + quotedstr(sRoom) + '

select_GET_NumberOfGuestsbyRoom : string =
' SELECT '#10+
'    rooms.Room '#10+
' ,  rooms.ID '#10+
' , roomtypes.RoomType '#10+
' , roomtypes.NumberGuests '#10+
' , roomtypes.ID '#10+
' FROM '#10+
'    rooms LEFT OUTER JOIN '#10+
'   roomtypes ON  rooms.RoomType = roomtypes.RoomType '#10+
' WHERE '#10+
'(Room =%s) ';  //' + quotedstr(sRoom) + '

select_GetPriceType : string =
' SELECT '#10+
'   PriceType '#10+
' FROM '#10+
'   roomtypes '#10+
' WHERE '#10+
'  RoomType =%s ';  //' + quotedstr(RoomType) + '



select_roomreservations_by_roomreservation : string =
' SELECT * FROM roomreservations WHERE RoomReservation = %d ';


select_ctrl_CompanyInfo : string =
'  SELECT '#10+
'      CompanyID '#10+
'    , CompanyName '#10+
'    , Address1 '#10+
'    , Address2 '#10+
'    , Address3 '#10+
'    , Address4 '#10+
'    , Country '#10+
'    , Fax '#10+
'    , Telephone1 '#10+
'    , TelePhone2 '#10+
'    , CompanyEmail '#10+
'    , CompanyHomePage '#10+
'    , CompanyPId '#10+
'    , CompanyVATno '#10+
'    , CompanyBankInfo '#10+
'  FROM '#10+
'    control ';


select_ctrl_invTxtInfo : string =
'  SELECT '#10+
'     invTxtHeadDebit '#10+
'    ,invTxtHeadKredit '#10+
'    ,invTxtHeadInfoNumber '#10+
'    ,invTxtHeadInfoDate '#10+
'    ,invTxtHeadInfoCustomerNo '#10+
'    ,invTxtHeadInfoGjalddagi '#10+
'    ,invTxtHeadInfoEindagi '#10+
'    ,invTxtHeadInfoLocalCurrency '#10+
'    ,invTxtHeadInfoCurrency '#10+
'    ,invTxtHeadInfoCurrencyRate '#10+
'    ,invTxtHeadInfoReservation '#10+
'    ,invTxtHeadInfoCreditInvoice '#10+
'    ,invTxtHeadInfoOrginalInfo '#10+
'    ,invTxtHeadInfoGuest '#10+
'    ,invTxtHeadInfoRoom '#10+
'    ,invTxtLinesItemNo '#10+
'    ,invTxtLinesItemText '#10+
'    ,invTxtLinesItemCount '#10+
'    ,invTxtLinesItemPrice '#10+
'    ,invTxtLinesItemAmount '#10+
'    ,invTxtLinesItemTotal '#10+
'    ,invTxtExtra1 '#10+
'    ,invTxtExtra2 '#10+
'    ,invTxtFooterLine1 '#10+
'    ,invTxtFooterLine2 '#10+
'    ,invTxtFooterLine3 '#10+
'    ,invTxtFooterLine4 '#10+
'    ,invTxtPaymentListHead '#10+
'    ,invTxtPaymentListCode '#10+
'    ,invTxtPaymentListAmount '#10+
'    ,invTxtPaymentListDate '#10+
'    ,invTxtPaymentListTotal '#10+
'    ,invTxtPaymentLineHead '#10+
'    ,invTxtPaymentLineSeperator '#10+
'    ,invTxtVATListHead '#10+
'    ,invTxtVATListDescription '#10+
'    ,invTxtVATListwoVAT '#10+
'    ,invTxtVATListwVAT '#10+
'    ,invTxtVATListVATpr '#10+
'    ,invTxtVATListVATAmount '#10+
'    ,invTxtVATListTotal '#10+
'    ,invTxtVATLineHead '#10+
'    ,invTxtVATLineSeperator '#10+
'    ,invTxtTotalwoVAT '#10+
'    ,invTxtTotalVATAmount '#10+
'    ,invTxtTotalTotal '#10+
'    ,invTxtCompanyName '#10+
'    ,invTxtCompanyAddress '#10+
'    ,invTxtCompanyTel1 '#10+
'    ,invTxtCompanyTel2 '#10+
'    ,invTxtCompanyFax '#10+
'    ,invTxtCompanyEmail '#10+
'    ,invTxtCompanyHomePage '#10+
'    ,invTxtCompanyPID '#10+
'    ,invTxtCompanyBankInfo '#10+
'    ,invTxtCompanyVATId '#10+
'    ,invTxtOriginal '#10+
'    ,invTxtCopy '#10+
'    ,ivhTxtTotalStayTax '#10+
'    ,ivhTxtTotalStayTaxNights '#10+
'    ,invTxtPaymentListDescription '#10+
'    ,invTxtHeadPrePaid '#10+
'    ,invTxtHeadBalance '#10+



'  FROM '#10+
'    control ';


select_invoiceHead_customerInfo : string =
'  SELECT '#10+
'      InvoiceNumber '#10+
'    , Customer '#10+
'    , Name '#10+
'    , Address1 '#10+
'    , Address2 '#10+
'    , Address3 '#10+
'    , Address4 '#10+
'    , Country '#10+
'    , RoomGuest '#10+
'    , custPID '#10+
'    , showPackage '#10+
'  FROM '#10+
'    InvoiceHeads '#10+
'  WHERE '#10+
'    (InvoiceNumber = %d) ';
//	@InvoiceNumber int



select_ivh_otherInfo : string =
'  SELECT '#10+
'      InvoiceNumber '#10+
'    , Reservation '#10+
'    , RoomReservation '#10+
'    , SplitNumber '#10+
'    , InvoiceDate '#10+
'    , Total '#10+
'    , TotalWOVAT '#10+
'    , TotalVAT '#10+
'    , TotalBreakFast '#10+
'    , ExtraText '#10+
'    , Finished '#10+
'    , CreditInvoice '#10+
'    , OriginalInvoice '#10+
'    , ihStaff '#10+
'    , ihPayDate '#10+
'    , invRefrence '#10+
'    , TotalStayTax '#10+
'    , TotalStayTaxNights '#10+
'    , ShowPackage '#10+
'    , Location '#10+
' '#10+
'   FROM '#10+
'     InvoiceHeads '#10+
'   WHERE '#10+
'     (InvoiceNumber = %d) ';

//	@InvoiceNumber int


//	@InvoiceNumber int


select_get_prepaid : string =
'      SELECT '#10+
'         InvoiceNumber '#10+
'       , Amount '#10+
'       , TypeIndex '#10+
'      FROM '#10+
'        Payments '#10+
'      WHERE '#10+
'       (InvoiceNumber = %d) ';




select_Reservation : string =
'  SELECT '#10+
' Reservation '#10+
',Arrival '#10+
',Departure '#10+
',Customer '#10+
',Name '#10+
',Address1 '#10+
',Address2 '#10+
',Address3 '#10+
',Address4 '#10+
',Country '#10+
',Tel1 '#10+
',Tel2 '#10+
',Fax '#10+
',Status '#10+
',ReservationDate '#10+
',Staff '#10+
',Information '#10+
',PMInfo '#10+
',HiddenInfo '#10+
',RoomRentPaid1 '#10+
',RoomRentPaid2 '#10+
',RoomRentPaid3 '#10+
',RoomRentPaymentInvoice '#10+
',ContactName '#10+
',ContactPhone '#10+
',ContactPhone2 '#10+
',ContactFax '#10+
',ContactEmail '#10+
',ContactAddress1 '#10+
',ContactAddress2 '#10+
',ContactAddress3 '#10+
',ContactAddress4 '#10+
',ContactCountry '#10+
',inputsource '#10+
',webconfirmed '#10+
',arrivaltime '#10+
',srcrequest '#10+
',rvTmp '#10+
',ID '#10+
',CustPID '#10+
',invRefrence '#10+
',marketSegment '#10+
',CustomerEmail '#10+
',CustomerWebsite '#10+
',useStayTax '#10+
',Channel '#10+
',outOfOrderBlocking '#10+
'FROM '#10+
' [Reservations] '#10+
'WHERE '#10+
' Reservation = %d ';
//	@Reservation int

select_RoomReservation : string =
'  SELECT '#10+
'     ID '#10+
'    ,RoomReservation '#10+
'    ,Room '#10+
'    ,Reservation '#10+
'    ,Status '#10+
'    ,GroupAccount '#10+
'    ,invBreakfast '#10+
'    ,RoomPrice1 '#10+
'    ,Price1From '#10+
'    ,Price1To '#10+
'    ,RoomPrice2 '#10+
'    ,Price2From '#10+
'    ,Price2To '#10+
'    ,RoomPrice3 '#10+
'    ,Price3From '#10+
'    ,Price3To '#10+
'    ,Currency '#10+
'    ,Discount '#10+
'    ,Percentage '#10+
'    ,PriceType '#10+
'    ,Arrival '#10+
'    ,Departure '#10+
'    ,RoomType '#10+
'    ,PMInfo '#10+
'    ,HiddenInfo '#10+
'    ,RoomRentPaid1 '#10+
'    ,RoomRentPaid2 '#10+
'    ,RoomRentPaid3 '#10+
'    ,RoomRentPaymentInvoice '#10+
'    ,Hallres '#10+
'    ,rrTmp '#10+
'    ,rrDescription '#10+
'    ,rrArrival '#10+
'    ,rrDeparture '#10+
'    ,rrIsNoRoom '#10+
'    ,rrRoomAlias '#10+
'    ,rrRoomTypeAlias '#10+
'    ,useStayTax '#10+
'    ,useInNationalReport '#10+
'    ,blockMove '#10+
'    ,blockMoveReason '#10+
'    ,numGuests '#10+
'    ,numChildren '#10+
'    ,numInfants, AvrageRate, rateCount,package '#10+
'    ,ExpectedTimeOfArrival '#10+
'    ,ExpectedCheckoutTime'#10+
'  FROM '#10+
'    [RoomReservations] '#10+
'  WHERE '#10+
'    RoomReservation = %d ';

//@RoomReservation int



select_inv_PaymentsByPeriod : string =
'  SELECT '#10+
'     invoiceheads.Reservation '#10+
'    ,invoiceheads.RoomReservation '#10+
'    ,invoiceheads.InvoiceNumber '#10+
'    ,invoiceheads.InvoiceDate '#10+
'    ,invoiceheads.Customer '#10+
'    ,invoiceheads.Name '#10+
'    ,invoiceheads.CreditInvoice '#10+
'    ,invoiceheads.Total '#10+
'    ,invoiceheads.TotalWOVAT '#10+
'    ,invoiceheads.TotalVAT '#10+
'    ,payments.PayType '#10+
'    ,payments.Amount '#10+
'    ,payments.Description AS pmDescription '#10+
'    ,payments.Currency '#10+
'    ,payments.CurrencyRate '#10+
'    ,customers.Surname '#10+
'    ,customers.Name AS custName '#10+
'    ,customers.CustomerType '#10+
'    ,customers.TravelAgency '#10+
'    ,paytypes.Description AS ptDescription '#10+
'    ,paytypes.PayGroup '#10+
'    ,paygroups.Description AS pgDescription '#10+
'  FROM '#10+
'    paytypes LEFT OUTER JOIN '#10+
'        paygroups ON paytypes.PayGroup = paygroups.Description RIGHT OUTER JOIN '#10+
'           payments ON paytypes.PayType = payments.PayType RIGHT OUTER JOIN '#10+
'              customers RIGHT OUTER JOIN '#10+
'                 invoiceheads ON customers.Customer = invoiceheads.Customer ON '#10+
'                   payments.InvoiceNumber = invoiceheads.InvoiceNumber '#10+
'  WHERE '#10+
'    (invoiceheads.InvoiceNumber <> - 1) AND '#10+
'    (invoiceheads.InvoiceDate > %s ) AND '#10+
'    (invoiceheads.InvoiceDate < %s ) '#10+
'  ORDER BY '#10+
'    invoiceheads.InvoiceDate ';

//    @DateFrom  nvarChar(10),
//    @DateTo nvarchar(10) AS


select_inv_paymentsByPeriod_payGroup : string =
'  SELECT '#10+
'     invoiceheads.Reservation '#10+
'    ,invoiceheads.RoomReservation '#10+
'    ,invoiceheads.InvoiceNumber '#10+
'    ,invoiceheads.InvoiceDate '#10+
'    ,invoiceheads.Customer '#10+
'    ,invoiceheads.Name '#10+
'    ,invoiceheads.CreditInvoice '#10+
'    ,invoiceheads.Total '#10+
'    ,invoiceheads.TotalWOVAT '#10+
'    ,invoiceheads.TotalVAT '#10+
'    ,payments.PayType '#10+
'    ,payments.Amount '#10+
'    ,payments.Description AS pmDescription '#10+
'    ,payments.Currency '#10+
'    ,payments.CurrencyRate '#10+
'    ,customers.Surname '#10+
'    ,customers.Name AS custName '#10+
'    ,customers.CustomerType '#10+
'    ,customers.TravelAgency '#10+
'    ,paytypes.Description AS ptDescription '#10+
'    ,paytypes.PayGroup '#10+
'    ,paygroups.Description AS pgDescription '#10+
'  FROM '#10+
'    paytypes LEFT OUTER JOIN '#10+
'        paygroups ON paytypes.PayGroup = paygroups.Description RIGHT OUTER JOIN '#10+
'           payments ON paytypes.PayType = payments.PayType RIGHT OUTER JOIN '#10+
'              customers RIGHT OUTER JOIN '#10+
'                 invoiceheads ON customers.Customer = invoiceheads.Customer ON '#10+
'                   payments.InvoiceNumber = invoiceheads.InvoiceNumber '#10+
'  WHERE '#10+
'    (invoiceheads.InvoiceNumber <> - 1) AND '#10+
'    (paytypes.PayGroup = %s) AND '#10+
'    (invoiceheads.InvoiceDate > %s ) AND '#10+
'    (invoiceheads.InvoiceDate < %s ) '#10+
'  ORDER BY '#10+
'    invoiceheads.Customer ';
//@DateFrom  nvarChar(10),
//@DateTo nvarchar(10),
//@PayGroup nvarchar(5)


select_inv_res_InvoiceList_byPeriod : string =
'  SELECT '#10+
'    ,invoiceheads.Reservation '#10+
'    ,invoiceheads.RoomReservation '#10+
'    ,invoiceheads.InvoiceNumber '#10+
'    ,invoiceheads.InvoiceDate '#10+
'    ,invoiceheads.Customer '#10+
'    ,invoiceheads.Name '#10+
'    ,invoiceheads.Total '#10+
'    ,invoiceheads.TotalWOVAT '#10+
'    ,invoiceheads.TotalVAT '#10+
'    ,reservations.Arrival '#10+
'    ,reservations.Departure '#10+
'  FROM '#10+
'    invoiceheads LEFT OUTER JOIN '#10+
'       reservations ON invoiceheads.Reservation = reservations.Reservation '#10+
'  WHERE '#10+
'     (invoiceheads.InvoiceNumber <> - 1) AND '#10+
'     (invoiceheads.InvoiceDate > %s ) AND '#10+
'     (invoiceheads.InvoiceDate < %s ) '#10+
'  ORDER BY invoiceheads.InvoiceDate ';
// @DateFrom  nvarChar(10),
// @DateTo nvarchar(10)


select_wInvPayments_GroupCustomer_byPayGroup : string =
'  SELECT '#10+
'    Customer, '#10+
'    Surname, '#10+
'    Custname, '#10+
'    PayGroup, '#10+
'    SUM(Total) AS Total, '#10+
'    COUNT(InvoiceNumber) AS ItemCount '#10+
'  FROM '#10+
'    w_Sale_Invoice_payments_per_date '#10+
'  WHERE '#10+
'    (payGroup = %s) AND '#10+
'    (InvoiceDate > %s ) AND '#10+
'    (InvoiceDate < %s ) '#10+
'  GROUP BY '#10+
'    PayGroup '#10+
'   ,Customer '#10+
'   ,Surname '#10+
'   ,custName ';
//  @DateFrom  nvarChar(10),
//  @DateTo nvarchar(10),
//  @PayGroup nvarchar(5)


select_wInvPayments_GroupPayTypes : string =
'  SELECT '#10+
'    PayType, '#10+
'    ptDescription, '#10+
'    PayGroup, '#10+
'    SUM(Amount) AS Total, '#10+
'    COUNT(InvoiceNumber) AS ItemCount '#10+
'  FROM '#10+
'    w_Sale_Invoice_payments_per_date '#10+
'  WHERE '#10+
'    (InvoiceDate > %s ) AND '#10+
'    (InvoiceDate < %s ) '#10+
'  GROUP BY '#10+
'    PayGroup, '#10+
'    PayType, '#10+
'    ptDescription ';
//@DateFrom  nvarChar(10),
//@DateTo nvarchar(10)


select_wInvS_ItemSaleByPeriod : string =
'  SELECT '#10+
'    ItemID, '#10+
'    ItemDescription, '#10+
'    SUM(ItemTotal) AS Total, '#10+
'    SUM(ItemWOVAT) AS TotalWOVAT, '#10+
'    SUM(ItemVAT) AS TotalVAT, '#10+
'    COUNT(Reservation) AS ItemCount '#10+
'  FROM '#10+
'    w_InvoiceSales '#10+
'  WHERE '#10+
'    (InvoiceDate > %s ) AND '#10+
'    (InvoiceDate < %s ) '#10+
'  GROUP BY '#10+
'    ItemID, '#10+
'    ItemDescription ';

//    @DateFrom  nvarChar(10),
//    @DateTo nvarchar(10)


select_GuestsInfoByRoomReservation : string =
'  SELECT '#10+
'      Persons.Person '#10+
'    , Persons.RoomReservation '#10+
'    , Persons.Name AS GuestName '#10+
'    , roomreservations.Room '#10+
'    , roomreservations.Reservation '#10+
'    , roomreservations.Status '#10+
'    , roomreservations.GroupAccount '#10+
'    , roomreservations.invBreakfast '#10+
'    , Reservations.Customer '#10+
'    , Reservations.Name AS ReservationName '#10+
'    , roomreservations.RoomType '#10+
'    , roomtypes.Description AS RoomTypeDescription '#10+
'    ,  rooms.Description AS RoomDescription '#10+
'    ,  rooms.Location '#10+
'    ,  rooms.Floor '#10+
'    , Persons.Country '#10+
'    , roomreservations.rrArrival '#10+
'    , roomreservations.rrDeparture '#10+
'    , countries.CountryName '#10+
'    , customers.Surname AS CustomerName '#10+
'    , customers.PID AS CustomerPID '#10+
'  FROM '#10+
'    Persons '#10+
'    INNER JOIN '#10+
'      roomreservations ON Persons.RoomReservation = roomreservations.RoomReservation '#10+
'    LEFT OUTER JOIN '#10+
'      countries ON Persons.Country = countries.Country '#10+
'    LEFT OUTER JOIN '#10+
'       rooms ON roomreservations.Room =  rooms.Room '#10+
'    LEFT OUTER JOIN '#10+
'      roomtypes ON roomreservations.RoomType = roomtypes.RoomType '#10+
'    LEFT OUTER JOIN '#10+
'      Reservations ON roomreservations.Reservation = Reservations.Reservation '#10+
'    LEFT OUTER JOIN '#10+
'     customers ON Reservations.Customer = customers.Customer '#10+
'  WHERE '#10+
'     (Persons.RoomReservation = %d) '#10+
'  ORDER BY '#10+
'     roomreservations.Room, Persons.Person ';
// @RoomReservation int


select_InvoicesByReservation_UnpaidItems : string =
'  SELECT '#10+
'      InvoiceHeads.Reservation '#10+
'    , InvoiceHeads.InvoiceNumber '#10+
'    , InvoiceHeads.Total '#10+
'    , InvoiceHeads.InvoiceDate '#10+
'    , Reservations.Arrival '#10+
'    , Reservations.Departure '#10+
'  FROM '#10+
'     InvoiceHeads '#10+
'       INNER JOIN '#10+
'     Reservations ON InvoiceHeads.Reservation = Reservations.Reservation '#10+
'  WHERE '#10+
'        (InvoiceHeads.Reservation = %d) '#10+
'    AND (InvoiceHeads.RoomReservation = 0) '#10+
'    AND (InvoiceHeads.InvoiceNumber = - 1) '#10+
'    AND (InvoiceHeads.Total > 0) ';
// @Reservation int


select_Item_ByItem : string =
'SELECT '#10+
'     ID '#10+
'    ,Active '#10+
'    ,Description '#10+
'    ,Item '#10+
'    ,Price '#10+
'    ,Itemtype '#10+
'    ,AccountKey '#10+
'    ,MinibarItem '#10+
'    ,BreakfastItem '#10+
'    ,SystemItem '#10+
'    ,RoomRentitem '#10+
'    ,ReservationItem '#10+
'    ,Hide '#10+
'    ,Currency '#10+
'    ,BookKeepCode '#10+
'    ,NumberBase '#10+
'    ,Stockitem'#10+
'    ,s.TotalStock'#10+
'  FROM '#10+
'    items '#10+
'    LEFT OUTER JOIN stockitems s on s.itemid=items.ID '#10+
'  WHERE '#10+
'    item = %d ';


select_location_ByLocation : string =
'SELECT '#10+
'     locations.ID '#10+
'    ,locations.Active '#10+
'    ,locations.Description '#10+
'    ,locations.location '#10+
'    ,locations.Accountdepartment '#10+
'    ,locations.channelManager '#10+
'    ,channelmanagers.Description AS channelManagerName '#10+
'  FROM '#10+
'    locations '#10+
'    LEFT JOIN channelmanagers ON channelmanagers.id=locations.channelManager '#10+
'  WHERE '#10+
'    location = %s ';

select_customerType_ByCustomerType : string =
'SELECT '#10+
'     ID '#10+
'    ,Active '#10+
'    ,Description '#10+
'    ,customerType '#10+
'    ,Priority '#10+
'  FROM '#10+
'    [customertypes] '#10+
'  WHERE '#10+
'    customertype = %d ';

select_staffType_ByStaffType : string =
'SELECT '#10+
'     ID '#10+
'    ,Active '#10+
'    ,Description '#10+
'    ,staffType '#10+
'    ,AccessPrivilidges '#10+
'    ,AuthValue '#10+
'  FROM '#10+
'    [stafftypes] '#10+
'  WHERE '#10+
'    stafftype = %d ';


select_customer_ByCustomer : string =
'SELECT '#10+
'     ID '#10+
'    ,Active '#10+
'    ,Customer '#10+
'  FROM '#10+
'    [customers] '#10+
'  WHERE '#10+
'    customer = %d ';



select_ItemType_ByItemType : string =
'  SELECT '#10+
'     [ItemType] '#10+
'    ,[Description] '#10+
'    ,[VATCode] '#10+
'    ,[AccItemLink] '#10+
'    ,[ID] '#10+
'    ,[Active] '#10+
'  FROM '#10+
'    [ItemTypes] '#10+
'  WHERE '#10+
'    [ItemType] = %d ';

// @ItemType varchar(20)


select_PERSON : string =
'  SELECT '#10+
'     [Person] '#10+
'    ,[RoomReservation] '#10+
'    ,[Reservation] '#10+
'    ,[Name] '#10+
'    ,[Surname] '#10+
'    ,[Address1] '#10+
'    ,[Address2] '#10+
'    ,[Address3] '#10+
'    ,[Address4] '#10+
'    ,[Country] '#10+
'    ,[Company] '#10+
'    , [GuestType] '#10+
'    ,[Information] '#10+
'    ,[PID] '#10+
'    ,[MainName] '#10+
'    ,[Customer] '#10+
'    ,[peTmp] '#10+
'    ,[hgrID] '#10+
'    ,[HallReservation] '#10+
'    ,[Tel1] '#10+
'    ,[Tel2] '#10+
'    ,[Fax] '#10+
'    ,[Email] '#10+
'  FROM '#10+
'    [Persons] '#10+
'  WHERE '#10+
'    Person = %d ';
//	@Person int

select_Person_By_roomreservation : string =
'  SELECT '#10+
'     [Person] '#10+
'    ,[RoomReservation] '#10+
'    ,[Reservation] '#10+
'    ,[Name] '#10+
'    ,[Surname] '#10+
'    ,[Address1] '#10+
'    ,[Address2] '#10+
'    ,[Address3] '#10+
'    ,[Address4] '#10+
'    ,[Country] '#10+
'    ,[Company] '#10+
'    ,[GuestType] '#10+
'    ,[Information] '#10+
'    ,[PID] '#10+
'    ,[MainName] '#10+
'    ,[Customer] '#10+
'    ,[peTmp] '#10+
'    ,[hgrID] '#10+
'    ,[HallReservation] '#10+
'    ,[Tel1] '#10+
'    ,[Tel2] '#10+
'    ,[Fax] '#10+
'    ,[Email] '#10+
'  FROM [Persons] '#10+
'    WHERE roomreservation = %d ';

//	@roomreservation int



//@aDate nvarchar(10)




select_RateRules_fillGridFromDataset : string =
' SELECT '#10+
'     ID '#10+
'   , Description '#10+
'   , Active '#10+
'   , ApplyToDates '#10+
'   , ApplyToSeasons '#10+
'   , ApplyToRoomTypes '#10+
'   , ApplyToRoomGroups '#10+
'   , ApplyToRooms '#10+
'   , Rules '#10+
' FROM '#10+
'   pricerules '#10+
' ORDER BY '#10+
'   %s '#10;


select_RoomRates_fillGridFromDataset : string =
' SELECT '#10+
'   ID '#10+
'  ,PriceCodeID '#10+
'  ,RateID '#10+
'  ,SeasonID '#10+
'  ,RoomTypeID '#10+
'  ,CurrencyID '#10+
'  ,Active '#10+
'  ,DateFrom '#10+
'  ,DateTo '#10+
'  ,Description '#10+
'  ,DateCreated '#10+
'  ,LastModified '#10+
' FROM '#10+
'   roomrates '#10+
' ORDER BY '#10+
'   %s ';


select_Rates_fillGridFromDataset : string =
' SELECT '#10+
'   ID '#10+
'  ,Active '#10+
'  ,currency '#10+
'  ,Description '#10+
'  ,Rate1Person '#10+
'  ,Rate2Persons '#10+
'  ,Rate3Persons '#10+
'  ,Rate4Persons '#10+
'  ,Rate5Persons '#10+
'  ,Rate6Persons '#10+
'  ,RateExtraPerson '#10+
'  ,RateExtraChildren '#10+
'  ,RateExtraInfant '#10+
'  ,isDefault '#10+
' FROM '#10+
'   rates '#10+
' ORDER BY '#10+
'   %s ';

select_Taxes_fillGridFromDataset : string =
' SELECT '#10+
'   ID '#10+
'  ,Hotel_Id '#10+
'  ,Description '#10+
'  ,Tax_Type '#10+
'  ,Tax_Base '#10+
'  ,Time_Due '#10+
'  ,Retaxable '#10+
'  ,TaxChildren  '#10+
'  ,Amount '#10+
'  ,Booking_Item_Id '#10+
'  ,(SELECT Item FROM items WHERE id=Booking_Item_Id) AS Booking_Item '#10+
'  ,INCL_EXCL '#10+
'  ,NETTO_AMOUNT_BASED '#10+
'  ,VALUE_FORMULA '#10 +
'  ,VALID_FROM '#10 +
'  ,VALID_TO '#10 +
'  ,ROUND_VALUE '#10 +
' FROM '#10+
'   home100.TAXES WHERE HOTEL_ID=(SELECT CompanyID FROM control LIMIT 1) COLLATE utf8_general_ci '#10+
' ORDER BY '#10+
'   %s ';

select_Taxes_fillGridFromDataset2 : string =
' SELECT '#10+
'   ID '#10+
'  ,Hotel_Id '#10+
'  ,Description '#10+
'  ,Tax_Type '#10+
'  ,Tax_Base '#10+
'  ,Time_Due '#10+
'  ,Retaxable '#10+
'  ,TaxChildren  '#10+
'  ,Amount '#10+
'  ,Booking_Item_Id '#10+
'  ,(SELECT Item FROM items WHERE id=Booking_Item_Id) AS Booking_Item '#10+
'  ,INCL_EXCL '#10+
'  ,NETTO_AMOUNT_BASED '#10+
'  ,VALUE_FORMULA '#10 +
'  ,VALID_FROM '#10 +
'  ,VALID_TO '#10 +
'  ,ROUND_VALUE '#10 +
' FROM '#10+
'   home100.taxes WHERE HOTEL_ID=(SELECT CompanyID FROM control LIMIT 1) COLLATE utf8_general_ci '#10+
' ORDER BY '#10+
'   %s ';


select_Taxes_fillGridFromDataset_current : string =
' SELECT '#10+
'   ID '#10+
'  ,Hotel_Id '#10+
'  ,Description '#10+
'  ,Tax_Type '#10+
'  ,Tax_Base '#10+
'  ,Time_Due '#10+
'  ,Retaxable '#10+
'  ,TaxChildren  '#10+
'  ,Amount '#10+
'  ,Booking_Item_Id '#10+
'  ,(SELECT Item FROM items WHERE id=Booking_Item_Id) AS Booking_Item '#10+
'  ,INCL_EXCL '#10+
'  ,NETTO_AMOUNT_BASED '#10+
'  ,VALUE_FORMULA '#10 +
'  ,VALID_FROM '#10 +
'  ,VALID_TO '#10 +
'  ,ROUND_VALUE '#10 +
' FROM '#10+
'   home100.taxes '#10+
' WHERE '#10+
'    HOTEL_ID=(SELECT CompanyID FROM control LIMIT 1) and (Valid_from <= CURDATE() and Valid_to >= CURDATE()) '#10+
' COLLATE utf8_general_ci '#10+
' ORDER BY '#10+
'   %s ';


select_Rates_fillGridFromDataset_byCurrency : string =
' SELECT '#10+
'   ID '#10+
'  ,Active '#10+
'  ,currency '#10+
'  ,Description '#10+
'  ,Rate1Person '#10+
'  ,Rate2Persons '#10+
'  ,Rate3Persons '#10+
'  ,Rate4Persons '#10+
'  ,Rate5Persons '#10+
'  ,Rate6Persons '#10+
'  ,RateExtraPerson '#10+
'  ,RateExtraChildren '#10+
'  ,RateExtraInfant '#10+
'  ,isDefault '#10+
' FROM '#10+
'   rates '#10+
' WHERE '#10+
'   currency = %s '#10+
' ORDER BY '#10+
'   %s ';


select_wRoomRates : string =
' SELECT '#10+
'   ID '#10+
'  ,PriceCodeID '#10+
'  ,pcCode '#10+
'  ,pcRack '#10+
'  ,CurrencyID '#10+
'  ,Currency '#10+
'  ,SeasonID '#10+
'  ,seStartDate '#10+
'  ,seEndDate '#10+
'  ,seDescription '#10+
'  ,RoomTypeID '#10+
'  ,RoomType '#10+
'  ,NumberGuests '#10+
'  ,RateID '#10+
'  ,RateCurrency '#10+
'  ,Rate1Person '#10+
'  ,Rate2Persons '#10+
'  ,Rate3Persons '#10+
'  ,Rate4Persons '#10+
'  ,Rate5Persons '#10+
'  ,Rate6Persons '#10+
'  ,RateExtraPerson '#10+
'  ,RateExtraChildren '#10+
'  ,RateExtraInfant '#10+
'  ,DateCreated '#10+
'  ,LastModified '#10+
'  ,Description '#10+
'  ,Active '#10+
'  ,DateFrom '#10+
'  ,DateTo '#10+
' FROM '#10+
'   wroomrates '#10+
' ORDER BY '#10+
'   %s ';

select_wRoomRates_justActive : string =
' SELECT '#10+
'   ID '#10+
'  ,PriceCodeID '#10+
'  ,pcCode '#10+
'  ,pcRack '#10+
'  ,CurrencyID '#10+
'  ,Currency '#10+
'  ,SeasonID '#10+
'  ,seStartDate '#10+
'  ,seEndDate '#10+
'  ,seDescription '#10+
'  ,RoomTypeID '#10+
'  ,RoomType '#10+
'  ,NumberGuests '#10+
'  ,RateID '#10+
'  ,RateCurrency '#10+
'  ,Rate1Person '#10+
'  ,Rate2Persons '#10+
'  ,Rate3Persons '#10+
'  ,Rate4Persons '#10+
'  ,Rate5Persons '#10+
'  ,Rate6Persons '#10+
'  ,RateExtraPerson '#10+
'  ,RateExtraChildren '#10+
'  ,RateExtraInfant '#10+
'  ,DateCreated '#10+
'  ,LastModified '#10+
'  ,Description '#10+
'  ,Active '#10+
'  ,DateFrom '#10+
'  ,DateTo '#10+
' FROM '#10+
'   wroomrates '#10+
' WHERE  '#10+
'  (active =  %d ) '#10+
' ORDER BY '#10+
'   %s ';


select_roomTypes : string =
'SELECT '#10+
'  ID '#10+
' ,RoomType '#10+
' ,Description '#10+
' ,NumberGuests '#10+
' ,PriceType '#10+
' ,Webable '#10+
' ,RoomTypeGroup '#10+
' ,color '#10+
' ,Active '#10+
' ,PriorityRule '#10+
' ,location '#10+
' FROM '#10+
'  roomtypes '#10+
' ORDER BY '#10+
'  %s ';


select_ItemTypes : string =
'SELECT '#10+
'  ID '#10+
' ,Active '#10+
' ,Itemtype '#10+
' ,Description '#10+
' ,VATCode '#10+
' ,AccItemLink '#10+
' FROM '#10+
'  itemtypes '#10+
' ORDER BY '#10+
'  %s ';


select_Items : string =
'SELECT '#10+
'  ID '#10+
' ,Active '#10+
' ,Description '#10+
' ,Item '#10+
' ,Price '#10+
' ,Itemtype '#10+
' ,AccountKey '#10+
' ,Hide '#10+
' ,MinibarItem '#10+
' ,SystemItem '#10+
' ,RoomRentitem '#10+
' ,ReservationItem '#10+
' ,BreakfastItem '#10+
' ,Currency '#10+
' FROM '#10+
'  items '#10+
' WHERE '#10+
'  active = %d '#10+
' ORDER BY '#10+
'  %s ';



select_roomTypesGroups : string =
'SELECT '#10+
'  ID '#10+
' ,Code '#10+
' ,TopClass '#10+
' ,Description '#10+
' ,PriorityRule '#10+
' ,MaxCount '#10+
' ,numGuests '#10+
' ,minGuests '#10+
' ,maxGuests '#10+
' ,maxChildren '#10+
' ,color '#10+
' ,AvailabilityTypes '#10+
' ,BreakfastIncluded '#10+
' ,HalfBoard '#10+
' ,FullBoard '#10+
' ,Active '#10+
' ,defRate '#10+
' ,defAvailability '#10+
' ,defMaxAvailability '#10+
' ,defMinStay '#10+
' ,defMaxStay '#10+
' ,defClosedToArrival '#10+
' ,defClosedToDeparture '#10+
' ,defStopSale '#10+
' ,NonRefundable '#10+
' ,AutoChargeCreditcards '#10+
' ,RateExtraBed '#10+
' ,PhotoUri '#10+
' ,sendAvailability '#10+
' ,sendRate '#10+
' ,sendStopSell '#10+
' ,sendMinStay '#10+
' ,DetailedDescriptionHtml '#10+
' ,DetailedDescription '#10+
' ,Package '#10+
' ,OrderIndex '#10+
' ,connectRateToMasterRate '#10+
' ,masterRateRateDeviation '#10+
' ,RateDeviationType '#10+
' ,connectSingleUseRateToMasterRate '#10+
' ,masterRateSingleUseRateDeviation '#10+
' ,singleUseRateDeviationType '#10+
' ,connectStopSellToMasterRate '#10+
' ,connectAvailabilityToMasterRate '#10+
' ,connectMinStayToMasterRate '#10+
' ,connectMaxStayToMasterRate '#10+
' ,connectCOAToMasterRate '#10+
' ,connectCODToMasterRate '#10+
' ,connectLOSToMasterRate '#10+
' ,RATE_PLAN_TYPE '#10+
' ,prepaidPercentage '#10+
' , (SELECT GROUP_CONCAT(DISTINCT CHANNEL_ID) FROM home100.PAYMENT_REQUIREMENT_MATRIX WHERE HOTEL_ID=(SELECT CompanyID FROM control LIMIT 1) AND ROOM_TYPE_GROUP_CODE=roomtypegroups.Code) AS PAYMENTS_REQUIRED '#10+
' FROM '#10+
'   roomtypegroups '#10+
' ORDER BY '#10+
'   %s ';

select_PaymentRequirementForRoomTypeGroup : string =
' SELECT '#10 +
'  channelManagerId '#10 +
'  ,name '#10 +
' , PAYMENT_REQUIRED '#10 +
' , PREPAID_PERCENTAGE '#10 +
' FROM channels' +
' LEFT OUTER JOIN home100.PAYMENT_REQUIREMENT_MATRIX '#10 +
'   ON channelmanagerid=CHANNEL_ID and HOTEL_ID=(SELECT CompanyID FROM control LIMIT 1) AND ROOM_TYPE_GROUP_CODE=%s '#10 +
' where active  '#10 +
' ORDER BY channelManagerId'#10;

delete_PaymentRequirementsForRoomTypeGroup: string =
' DELETE '#10 +
' FROM home100.PAYMENT_REQUIREMENT_MATRIX '#10 +
' WHERE HOTEL_ID=(SELECT CompanyID FROM control LIMIT 1) AND ROOM_TYPE_GROUP_CODE=%s ';

insert_PaymentRequirementsForRoomTypeGroup: string =
' INSERT INTO home100.PAYMENT_REQUIREMENT_MATRIX '#10 +
'     (HOTEL_ID, CHANNEL_ID, ROOM_TYPE_GROUP_CODE, PAYMENT_REQUIRED, PREPAID_PERCENTAGE) '#10 +
'      VALUES (%s, %s, %s, 1, %s)';

select_Seasons : string =
'SELECT '#10+
'  ID '#10+
' ,seStartDate '#10+
' ,seEndDate '#10+
' ,seDescription '#10+
' ,Active '#10+
' FROM '#10+
'   tblseasons '#10+
' ORDER BY '#10+
'   %s ';

select_Locations : string =
'SELECT '#10+
'     locations.ID '#10+
'    ,locations.Active '#10+
'    ,locations.Description '#10+
'    ,locations.location '#10+
'    ,locations.AccountDepartment '#10+
'    ,locations.channelManager '#10+
'    ,channelmanagers.Description AS channelManagerName '#10+
' FROM '#10+
'    locations '#10+
'    LEFT JOIN channelmanagers ON channelmanagers.id=locations.channelManager '#10+
' ORDER BY '#10+
'   %s ';


select_Rooms : string =
'SELECT '#10+
'  ID '#10+
' ,Active '#10+
' ,Room '#10+
' ,Description '#10+
' ,wildcard '#10+
' ,RoomType '#10+
' ,Bath '#10+
' ,Shower '#10+
' ,Safe '#10+
' ,TV '#10+
' ,Video '#10+
' ,Radio '#10+
' ,CDPlayer '#10+
' ,Telephone '#10+
' ,Press '#10+
' ,Coffee '#10+
' ,Kitchen '#10+
' ,Minibar '#10+
' ,Fridge '#10+
' ,Hairdryer '#10+
' ,InternetPlug '#10+
' ,Fax '#10+
' ,SqrMeters '#10+
' ,BedSize '#10+
' ,Equipments '#10+
' ,Bookable '#10+
' ,Statistics '#10+
' ,Status '#10+
' ,OrderIndex '#10+
' ,hidden '#10+
' ,Location '#10+
' ,Floor '#10+
' ,Dorm '#10+
' ,useInNationalReport '#10+
' FROM '#10+
'   rooms '#10+
' ORDER BY '#10+
'   %s ';


select_customerTypes : string =
'SELECT '#10+
'  ID '#10+
' ,Active '#10+
' ,CustomerType '#10+
' ,Description '#10+
' ,Priority '#10+
' FROM '#10+
'   customertypes '#10+
' ORDER BY '#10+
'   %s ';

select_staffTypes : string =
'SELECT '#10+
'  ID '#10+
' ,Active '#10+
' ,staffType '#10+
' ,Description '#10+
' ,AccessPrivilidges '#10+
' ,AuthValue '#10+
' FROM '#10+
'   stafftypes '#10+
' ORDER BY '#10+
'   %s ';



  select_qryGetStaffTypes : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' stafftypes '+
  ' ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;

  select_GET_StaffTypeDescription_byStaffType : string =
  ' SELECT Description '+
  ' FROM stafftypes  '+
  ' WHERE  '+
  ' (StaffType =  %s ) ';
  ///s := s + '(StaffType =' + quotedstr(sStaffType) + ') '+#10;

  select_StaffTypeExist : string =
  ' SELECT '+
  ' StaffType '+
  ' FROM '+
  ' stafftypes '+
  ' WHERE '+
  ' StaffType = %s  ';
  ///s := s + 'StaffType = ' + quotedstr(sStaffType) + '  '+#10;

  select_StaffTypeExistsInOther : string =
  ' SELECT StaffType FROM staffmembers '+
  ' WHERE (StaffType =  %s ) ';
  ///s := s + ' WHERE (StaffType = ' + quotedstr(sStaffType) + ') '+#10;

  select_qryGetStaffMembers : string =
  ' SELECT '+
  ' * '+
  ' FROM '+
  ' staffmembers '+
  ' ORDER BY %s ';
  ///s := s + 'ORDER BY ' + Orderstr + ' '+#10;

  select_GET_StaffMemberName_byInitials : string =
  ' SELECT Name '+
  ' FROM staffmembers  '+
  ' WHERE  '+
  ' (Initials =  %s ) ';
  ///s := s + '(Initials =' + quotedstr(sInitials) + ') '+#10;

  select_GET_StaffMemberPID_byInitials : string =
  ' SELECT StaffPID '+
  ' FROM staffmembers  '+
  ' WHERE  '+
  ' (Initials =  %s ) ';
  ///s := s + '(Initials =' + quotedstr(sInitials) + ') '+#10;

  select_StaffMemberExists : string =
  ' SELECT '+
  ' Initials '+
  ' FROM '+
  ' staffmembers '+
  ' WHERE '+
  ' Initials = %s  ';
  ///s := s + 'Initials = ' + quotedstr(sStaffMember) + '  '+#10;

  select_StaffMemberExistsInOther : string =
  ' SELECT Staff FROM reservations '+
  ' WHERE (staff =  %s ) ';
  ///s := s + ' WHERE (staff = ' + quotedstr(sStaffMember) + ') '+#10;



  select_StaffMembers : string =
  ' SELECT '+
  ' ID '#10+
  ' ,Active '#10+
  ' ,Initials '#10+
  ' ,Password '#10+
  ' ,StaffPID '#10+
  ' ,Name '#10+
  ' ,Address1 '#10+
  ' ,Address2 '#10+
  ' ,Address3 '#10+
  ' ,Address4 '#10+
  ' ,Country '#10+
  ' ,Tel1 '#10+
  ' ,Tel2 '#10+
  ' ,Fax '#10+
  ' ,ActiveMember '#10+
  ' ,StaffLanguage '#10+
  ' ,StaffType '#10+
  ' ,StaffType1 '#10+
  ' ,StaffType2 '#10+
  ' ,StaffType3 '#10+
  ' ,StaffType4 '#10+
  ' ,IPAddresses '#10+
  ' ,PmsOnly '#10+
  ' ,WindowsAuth '#10+
  ' FROM '+
  ' staffmembers '+
  ' ORDER BY %s ';




select_customers : string =
'SELECT '#10+
'  ID '#10+
' ,Active '#10+
' ,Customer '#10+
' ,Surname '#10+
' ,Name '#10+
' ,CustomerType '#10+
' ,Address1 '#10+
' ,Address2 '#10+
' ,Address3 '#10+
' ,Address4 '#10+
' ,Country '#10+
' ,Tel1 '#10+
' ,Tel2 '#10+
' ,Fax '#10+
' ,DiscountPercent '#10+
' ,EmailAddress '#10+
' ,ContactPerson '#10+
' ,TravelAgency '#10+
' ,Currency '#10+
' ,PID '#10+
' ,dele '#10+
' ,pcID '#10+
' ,Homepage '#10+
' ,notes '#10+
' FROM '#10+
'   customers '#10+
' ORDER BY '#10+
'   %s ';


  select_ChannelExists : string =
  ' SELECT '+
  ' channelManagerId '+
  ' FROM '+
  ' channels '+
  ' WHERE '+
  ' channelManagerId = %s  ';


select_channels : string = 'SELECT id, name, active, channelmanagerid, ' +
       'minalotment, defaultavailability, defaultpricepp, ' +
       'marketsegment, currencyid, managedbychannelmanager, CHANNEL_ARRANGES_PAYMENT, ' +
       'defaultchannel, push, customerid, color, ' +
       'rateroundingtype, compensationpercentage, hotelsbookingengine, directConnection, currency, ' +
//       'CAST(Wroomclasses AS CHAR(10000)) AS roomClasses, activePlanCode, ratesExcludingTaxes ' +
       'Wroomclasses AS roomClasses, activePlanCode, ratesExcludingTaxes ' +
'FROM ' +
'( ' +
'SELECT ch.id , ch.name, ch.active, ch.channelmanagerid, ' +
       'ch.minalotment, ch.defaultavailability, ch.defaultpricepp, ' +
       'ch.marketsegment, ch.currencyid, ch.managedbychannelmanager, ch.CHANNEL_ARRANGES_PAYMENT, ' +
       'ch.defaultchannel, ch.push, ch.customerid, ch.color, ' +
       'ch.rateroundingtype, ch.compensationpercentage, ch.hotelsbookingengine, ch.directConnection, cu.currency, ch.activePlanCode, ch.ratesExcludingTaxes, ' +
       'concat('''',(select group_concat(code) from roomtypegroups where id in (select roomclassid from channelclassrelations where channelid=ch.id))) as Wroomclasses ' +
'FROM channels ch ' +
'     INNER JOIN currencies cu ON ch.currencyid = cu.id ' +
'ORDER BY ' +
' %s ' +
') tmp';
//'SELECT '#10+
//'  `channels`.`id`,'#10+
//'  `channels`.`name`,'#10+
//'  `channels`.`active`,'#10+
//'  `channels`.`channelManagerId`,'#10+
//'  `channels`.`minAlotment`,'#10+
//'  `channels`.`defaultAvailability`,'#10+
//'  `channels`.`defaultPricePP`,'#10+
//'  `channels`.`marketSegment`,'#10+
//'  `channels`.`currencyId`,'#10+
//'  `channels`.`managedByChannelManager`,'#10+
//'  `channels`.`defaultChannel`,'#10+
//'  `channels`.`push`,'#10+
//'  `channels`.`customerId`,'#10+
//'  `channels`.`color`,'#10+
//'  `channels`.`rateRoundingType`,'#10+
//'  `channels`.`compensationPercentage`,'#10+
//'  `channels`.`hotelsBookingEngine`,'#10+
//'  `currencies`.`Currency`,'#10+
//'  CONCAT('''',(SELECT GROUP_CONCAT(CODE) FROM roomtypegroups WHERE id IN (SELECT roomClassId FROM channelclassrelations WHERE channelId=channels.id))) AS roomClasses ' +
//'FROM'#10+
//'  `channels`'#10+
//'  INNER JOIN `currencies` ON (`channels`.`currencyId` = `currencies`.`ID`)'#10+
//' ORDER BY '#10+
//'   %s ';


select_systemServers : string =
'SELECT '#10+
'  `id`, '#10+
'  `active`, '#10+
'  `description`, '#10+
'  `server`, '#10+
'  `port`, '#10+
'  `username`, '#10+
'  `password`, '#10+
'  `authenticate`, '#10+
'  `ssl` '#10+
'FROM '#10+
'  `systemservers` '#10+
' ORDER BY '#10+
'   %s ';

select_systemActions : string =
'SELECT '#10+
' `systemactions`.`id`, '#10+
' `systemactions`.`description`, '#10+
' `systemactions`.`type`, '#10+
' `systemactions`.`active`, '#10+
' `systemactions`.`systemserver`, '#10+
' `systemactions`.`recipient`, '#10+
' `systemactions`.`sender`, '#10+
//' `systemactions`.`subject`, '#10+
//' `systemactions`.`content`, '#10+
' `systemactions`.`richcontent`, '#10+
' `systemactions`.`contentfile` '#10+
'FROM `systemactions` '#10+
' ORDER BY '#10+
'   %s ';

select_systemActionsEX : string =
'SELECT '#10+
'  `systemactions`.`id`, '#10+
'  `systemactions`.`description`, '#10+
'  `systemactions`.`type`, '#10+
'  `systemactions`.`active`, '#10+
'  `systemactions`.`systemserver`, '#10+
'  `systemactions`.`recipient`, '#10+
'  `systemactions`.`sender`, '#10+
//'  `systemactions`.`subject`, '#10+
//'  `systemactions`.`content`, '#10+
//'  `systemactions`.`richcontent`, '#10+
//'  `systemactions`.`contentfile`, '#10+
'  `systemservers`.`server` '#10+
'FROM '#10+
'  `systemactions` '#10+
'  INNER JOIN `systemservers` ON (`systemactions`.`systemserver` = `systemservers`.`id`) '#10+
' ORDER BY '#10+
'   %s ';

get_systemActions2_byID : string =
'SELECT '#10+
'  `systemactions`.`id`, '#10+
'  `systemactions`.`subject`, '#10+
'  `systemactions`.`content`, '#10+
'  `systemactions`.`richcontent`, '#10+
'  `systemactions`.`contentfile` '#10+
'FROM '#10+
'  `systemactions` '#10+
' WHERE '#10+
'  ID = %d ';

select_systemTriggers : string =
'SELECT '#10+
' `systemtriggers`.`id`, '#10+
' `systemtriggers`.`type`, '#10+
' `systemtriggers`.`active`, '#10+
' `systemtriggers`.`description`, '#10+
' `systemtriggers`.`systemaction` '#10+
' FROM `systemtriggers` '#10+
' ORDER BY '#10+
'   %s ';


select_systemTriggersEX : string =
'SELECT '#10+
'  `systemtriggers`.`id`, '#10+
'  `systemtriggers`.`type`, '#10+
'  `systemtriggers`.`active`, '#10+
'  `systemtriggers`.`description`, '#10+
'  `systemtriggers`.`systemaction`, '#10+
'  `systemactions`.`description` AS `actiondescription` '#10+
'FROM '#10+
'  `systemtriggers` '#10+
'  INNER JOIN `systemactions` ON (`systemtriggers`.`systemaction` = `systemactions`.`id`) '#10+
' ORDER BY '#10+
'   %s ';


select_Packages : string =
' SELECT '#10+
'   `packages`.`id`, '#10+
'   `packages`.`Description`, '#10+
'   `packages`.`package`, '#10+
'   `packages`.`showItemsOnInvoice`, '#10+
'   `packages`.`Active`, '#10+
'   `packages`.`CurrencyID`, '#10+
'   `packages`.`invoiceText`, '#10+
'   `currencies`.`Currency` '#10+
' FROM '#10+
'   `packages` '#10+
'   INNER JOIN `currencies` ON (`packages`.`CurrencyID` = `currencies`.`ID`) '#10+
' ORDER BY '#10+
'  %s ';


select_PackageItems : string =
' SELECT '#10+
'   `packageitems`.`id`, '#10+
'   `packageitems`.`description`, '#10+
'   `packageitems`.`packageId`, '#10+
'   `packageitems`.`itemId`, '#10+
'   `packageitems`.`numItems`, '#10+
'   `packageitems`.`unitPrice`, '#10+
'   `items`.`Item`, '#10+
'   `items`.`Description` AS `itemDescription`, '#10+
'   `items`.`Price` AS `itemPrice` '#10+
' FROM '#10+
'   `packageitems` '#10+
'   INNER JOIN `items` ON (`packageitems`.`itemId` = `items`.`ID`) ';


select_PackageItems_byPackageID : string =
' SELECT '#10+
'   `packageitems`.`id`, '#10+
'   `packageitems`.`description`, '#10+
'   `packageitems`.`packageId`, '#10+
'   `packageitems`.`itemId`, '#10+
'   `packageitems`.`numItems`, '#10+
'   `packageitems`.`unitPrice`, '#10+
'   `packageitems`.`numItemsMethod`, '#10+
'   `packageitems`.`IncludedInRate`, '#10+
'   `packageitems`.`valueFormula`, '#10+
'   `packageitems`.`unitPriceVatFormula`, '#10+
'   `items`.`Item`, '#10+
'   `items`.`Description` AS `itemDescription`, '#10+
'   `items`.`Price` AS `itemPrice` '#10+
' FROM '#10+
'   `packageitems` '#10+
'   INNER JOIN `items` ON (`packageitems`.`itemId` = `items`.`ID`) '#10+
' WHERE packageId = %d ';

select_Persons_byReservation : string =
'SELECT * '#10 +
//'`persons`.`ID`, '#10+
//'`persons`.`PID`, '#10+
//'`persons`.`Person`, '#10+
//'`persons`.`RoomReservation`, '#10+
//'`persons`.`Reservation`, '#10+
//'`persons`.`Name`, '#10+
//'`persons`.`Surname`, '#10+
//'`persons`.`Address1`, '#10+
//'`persons`.`Address2`, '#10+
//'`persons`.`Address3`, '#10+
//'`persons`.`Address4`, '#10+
//'`persons`.`Country`, '#10+
//'`persons`.`Company`, '#10+
//'`persons`.`GuestType`, '#10+
//'`persons`.`Information`, '#10+
//'`persons`.`MainName`, '#10+
////'`persons`.`peTmp`, '#10+
////'`persons`.`HallReservation`, '#10+
////'`persons`.`hgrID`, '#10+
//'`persons`.`Customer`, '#10+
//'`persons`.`Tel1`, '#10+
//'`persons`.`Tel2`, '#10+
//'`persons`.`Fax`, '#10+
//'`persons`.`Email` '#10+

'FROM '#10+
'  `persons` '#10+
'WHERE '#10+
'  `persons`.`RoomReservation` = %d '#10+
' ORDER BY '#10+
'  %s ';



Get_mainGuestname : string = ' (Select Name from persons %s where (%s.roomreservation = %s.roomreservation) and (mainName=1)) AS %s ';









(*

*)

    ///	<summary>
    ///	  <para>
    ///	    Format parameters
    ///	  </para>
    ///	  <para>
    ///	    1. %s �= sqlStringDate '2010-12-31'
    ///	  </para>
    ///	</summary>
    ///	<param name="occRooms">
    ///	  List of occupied  rooms to use in sql 'IN' clause
    ///	</param>
    ///	<returns>
    ///	  SQL SELEST commans
    ///	</returns>
function GetListOfRoomReservationsPerDepartureDate : string;
function GetListOfRoomReservationsPerArrivalDate : string;
function GetListOfRoomReservationsFromToDate : string;


function select_GuestsSearch_RunQuery2(getAll : boolean; DateSelMedhod : integer) : string;
function Select_Invoice_LoadInvoice3(iRoomReservation : integer) : string;
function Select_Invoice_LoadInvoice3_WithInvoiceIndex(iRoomReservation, iReservation, InvoiceIndex : integer; Customer : String; FakeGroup : Boolean) : string;
function select_InvoiceList_BitBtn2Click(Medhod : integer) : string;
function select_Main_refreshGuestList : string;
function select_NationalReport3_getRoomInfo(location : string) : string;
function select_ProvideARoom2_Display(orStr, Roomtype : string) : string;
function select_ReservationProfile_RegulateRoomDates(bAll : boolean) : string;
function select_ResGuestList_Refresh(ShowAllGuests : boolean) : string;
function select_RptCustomer_ReiknByCust2(isOneDay : boolean) : string;
function select_RptCustomer_AllCustInReikn2(isOneDay : boolean) : string;
function select_RptCustomerStay_Refresh1(iDateMark : integer) : string;


function select_qryGetinvoicelinesTmp(iRoomReservation : integer) : string;
function select_OpenInvoiceinvoicelines(reservation,roomreservation : integer) : string;
function select_NameOnOpenInvoice(reservation,roomreservation : integer) : string;
function select_SnertaExportCustomers(CustNO : string) : string;
function select_SnertaExportRooms(room : string) : string;
function select_RRlst_DepartureNationalReportByLocation(location : string ) : string;
function select_GetRackPrices(priceCodeID,RackPriceID : integer) : string;
function select_Convert(Direction : integer) : string;
function select_FinishedInvoices2_Display(itType : TInvoiceTypes) : string;
function GetRoomTypeAvailabilitySql(FromDate, ToDate : TDate) : String;

function SELECT_DYNAMIC_RATES(chManCode, channelCode, RoomClass : String) : String;


implementation

function SELECT_DYNAMIC_RATES(chManCode, channelCode, RoomClass : String) : String;
begin
  result := 'SELECT dpr.*, rtg.Description AS Rate_Name, cm.Description AS ChannelManagerName, ch.Name AS ChannelName ' +
      'FROM home100.DYNAMIC_PRICING_RULES dpr ' +
      'JOIN roomtypegroups rtg ON rtg.code=dpr.ROOMTYPEGROUP_CODE ' +
      'JOIN channels ch ON ch.channelManagerId=dpr.CHANNEL_ID ' +
      'JOIN channelmanagers cm ON cm.code=dpr.CHANNEL_MANAGER_ID ' +
      format('WHERE HOTEL_ID = ''%s'' ', [d.roomerMainDataSet.hotelId]) +
      format('AND END_DATE_RANGE > %s ', [_db(dateToSqlString(now))]) +
      iif(TRIM(chManCode) = '', '', format('AND CHANNEL_MANAGER_ID = ''%s'' ', [chManCode])) +
      iif(TRIM(channelCode) = '', '', format('AND CHANNEL_ID = ''%s'' ', [channelCode]))+
      iif(TRIM(RoomClass) = '', '', format('AND ROOMTYPEGROUP_CODE = ''%s'' ', [RoomClass])) +
      'ORDER BY START_DATE_RANGE';
end;

function GetListOfRoomReservationsPerDepartureDate : string;
begin
  result :=
      '  SELECT'+
      '    DISTINCT'+
      '    RoomReservation'+
      '  FROM'+
      '    roomreservations'+
      '  WHERE'+
      '        (Departure >=  %s )'+
      '    AND (Departure <=  %s )'+
      '    AND (status <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj
      '    AND (status <> '+_db(STATUS_CANCELED)+' ) '+ //**zxhj

      '  ORDER BY RoomReservation';
end;

function GetListOfRoomReservationsFromToDate : string;
begin
  result :=
      '  SELECT'+
      '    DISTINCT'+
      '    RoomReservation'+
      '  FROM'+
      '    roomsdate'+
      '  WHERE'+
      '        (ADate >=  %s )'+
      '    AND (ADate <=  %s )'+
      '   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj line added
      '   AND (ResFlag <> '+_db(STATUS_CANCELED)+' ) '+ //**zxhj line added

      '  ORDER BY RoomReservation';
end;

function GetListOfRoomReservationsPerArrivalDate : string;
begin
  result :=
      '  SELECT'+
      '    DISTINCT'+
      '    RoomReservation'+
      '  FROM'+
      '    roomreservations'+
      '  WHERE'+
      '        (Arrival >=  %s )'+
      '    AND (Arrival <=  %s )'+
      '    AND (status <> '+_db(STATUS_DELETED)+' ) '+ //**zxhj
      '    AND (status <> '+_db(STATUS_CANCELED)+' ) '+ //**zxhj

      '  ORDER BY RoomReservation';
end;

//TESTED OK

//TESTED NOT
function select_FinishedInvoices2_Display(itType : TInvoiceTypes) : string;
var
  s : string;
begin
  s := '';
  s := s+'SELECT * from invoiceheads ';
  s := s+' where InvoiceNumber <> -1 ' ;
  case itType of
    itPerCustomer    : s := s+ 'and Customer =  %s ';       //s1 QuotedStr(zCustomer) ;
    itPerRoomRes     : s := s+ 'and RoomReservation = %s '; //d2 inttoStr(zRoomRes) ;
    itPerReservation : s := s+ 'and Reservation = %s';      //d3 inttoStr(zReservation) ;
  end;
  result := s;
end;



//TESTET OK
function select_GuestsSearch_RunQuery2(getAll : boolean; DateSelMedhod : integer) : string;
var
  s : string;
begin
  s := ''+#10;
  s := s+' SELECT DISTINCT '+#10;
  s := s+'     persons.Name AS GuestName  '+#10;
  s := s+'   , roomreservations.rrArrival  '+#10;
  s := s+'   , roomreservations.rrDeparture  '+#10;
  s := s+'   , roomreservations.Status  '+#10;
  s := s+'   , roomreservations.Room '+#10;
  s := s+'   , persons.Address1  '+#10;
  s := s+'   , persons.Address2  '+#10;
  s := s+'   , persons.Address3  '+#10;
  s := s+'   , persons.Country  '+#10;
  s := s+'   , persons.PID  '+#10;
  s := s+'   , persons.RoomReservation  '+#10;
  s := s+'   , persons.Reservation  '+#10;
  s := s+'   , reservations.Name AS resName  '+#10;
  s := s+' FROM  '+#10;
  s := s+'   reservations  '+#10;
  s := s+'      LEFT OUTER JOIN roomreservations ON reservations.Reservation = roomreservations.Reservation  '+#10;
  s := s+'       RIGHT OUTER JOIN persons ON roomreservations.RoomReservation = persons.RoomReservation  '+#10;
  s := s+' WHERE '+#10;
  if   DateSelMedhod = 0 then
  begin
    s := s+'    (RoomReservations.rrArrival <= %s ) '+#10;  //'+_DateToDBDate(zdtFrom,true)++#10;
    s := s+'    AND  (RoomReservations.rrDeparture >= %s ) '+#10; //'+_DateToDBDate(zdtFrom,true)++#10;
  end else
  if DateSelMedhod = 1 then
  begin
    s := s+'    (RoomReservations.rrDeparture >= %s ) '+#10; //'+_DateToDBDate(zdtFrom,true)+'
  end else
  if DateSelMedhod = 2 then
  begin
     s := s+'    (RoomReservations.rrDeparture <= %s ) '+#10;//'+_DateToDBDate(zdtFrom,true)+'
  end else
  begin
    s := s+'    (RoomReservations.arrival > ''2000-01-01'' ) '+#10;
  end;
  if not GetAll then
  begin
    s := s+'    AND (persons.Name <> '''' ) '+#10;             //quotedStr('')+' ) ';
    s := s+'    AND (persons.Name <> ''RoomGuest'' ) '+#10;    //quotedStr('RoomGuest')+' ) ';
    s := s+'    AND (persons.Name <> ''' + GetTranslatedText('MainGuestConstant_Version_1') + ''' ) '+#10;    //quotedStr('MainGuest')+' ) ';
    s := s+'    AND (persons.Name <> ''' + GetTranslatedText('MainGuestConstant_Version_2') + ''' ) '+#10;    //quotedStr('MainGuest')+' ) ';
    s := s+'    AND (persons.Name <> ''-'' ) '+#10;            //quotedStr('-')+' ) ';
    s := s+'    AND (persons.Name <> '' -'' ) '+#10;           //quotedStr(' -')+' ) ';
  end;

  result := s;
end;


//TESTED OK
function Select_Invoice_LoadInvoice3(iRoomReservation : integer) : string;
var
  s : string;
begin
  s := '';
  s := s+' SELECT '+#10;
  s := s+' rr.RoomReservation, '+#10;
  s := s+' rr.Room, '+#10;
  s := s+' rr.Reservation, '+#10;
  s := s+' rr.Status, '+#10;
  s := s+' rr.GroupAccount, '+#10;
  s := s+' rr.invBreakfast, '+#10;
  s := s+' rr.RoomPrice1, '+#10;
  s := s+' rr.Price1From, '+#10;
  s := s+' rr.Price1To, '+#10;
  s := s+' rr.RoomPrice2, '+#10;
  s := s+' rr.Price2From, '+#10;
  s := s+' rr.Price2To, '+#10;
  s := s+' rr.RoomPrice3, '+#10;
  s := s+' rr.Price3From, '+#10;
  s := s+' rr.Price3To, '+#10;
  s := s+' rr.Currency, '+#10;
  s := s+' rr.Discount, '+#10;
  s := s+' rr.Percentage, '+#10;
  s := s+' rr.PriceType, '+#10;
  s := s+' rr.Arrival, '+#10;
  s := s+' rr.Departure, '+#10;
  s := s+' rr.RoomType, '+#10;
  s := s+' rr.PMInfo, '+#10;
  s := s+' rr.HiddenInfo, '+#10;
  s := s+' rr.RoomRentPaid1, '+#10;
  s := s+' rr.RoomRentPaid2, '+#10;
  s := s+' rr.RoomRentPaid3, '+#10;
  s := s+' rr.RoomRentPaymentInvoice, '+#10;
  s := s+' rr.Hallres, '+#10;
  s := s+' rr.rrTmp, '+#10;
  s := s+' rr.ID, '+#10;
  s := s+' rr.rrDescription, '+#10;
  s := s+' rr.rrIsNoRoom, '+#10;
  s := s+' rr.rrDeparture, '+#10;
  s := s+' rr.rrArrival, '+#10;
  s := s+' rr.rrRoomTypeAlias, '+#10;
  s := s+' rr.rrRoomAlias, '+#10;
  s := s+' rr.useStayTax, '+#10;
  s := s+' rr.useinNationalReport, '+#10;
  s := s+' (SELECT COUNT(id) FROM persons WHERE RoomReservation=rr.RoomReservation) AS numGuests, '+#10;
//  s := s+' rr.numGuests, '+#10;
  s := s+' rr.numChildren, '+#10;
  s := s+' rr.numInfants, '+#10;
  s := s+' rr.AvrageRate, '+#10;
  s := s+' rr.RateCount, '+#10;
  s := s+' rr.dtCreated, '+#10;
  s := s+' rr.RoomClass, '+#10;
  s := s+' rr.colorId, '+#10;
  s := s+' rr.ratePlanCode, '+#10;
  s := s+' rr.percentageDeposit, '+#10;
  s := s+' rr.fixedDeposit, '+#10;
  s := s+' rr.depositsInfo, '+#10;
  s := s+' rr.penaltiesInfo, '+#10;
  s := s+' rr.checkoutEventProcessed, '+#10;
  s := s+' rr.COMMISSION, '+#10;
  s := s+' rr.COMMISSION_CURRENCY, '+#10;
  s := s+' rr.CHANNEL_ROOM_RES_ID, '+#10;
  s := s+' rr.Package, '+#10;
  s := s+' rr.blockMove, '+#10;
  s := s+' rr.PaymentGuaranteeType, '+#10;
  s := s+' rr.CCMaskedCreditCard, '+#10;
  s := s+' rr.CCExpiry, '+#10;
  s := s+' rr.CCNameOnCard, '+#10;
  s := s+' rr.CCCardType, '+#10;
  s := s+' rr.ManualChannelId, '+#10;
  s := s+' rr.InvoiceIndex, '+#10;
  s := s+' rr.ExpectedTimeOfArrival, '+#10;
  s := s+' rr.ExpectedCheckOutTime, '+#10;
  s := s+' rr.blockMoveReason, '+#10;

  s := s+' (SELECT ContactEmail FROM reservations WHERE reservations.Reservation=rr.Reservation) AS ContactEmail, '+#10;

  s := s+' r.Description AS RoomDescription, '+#10;
  s := s+' rt.Description AS RoomTypeDescription, '+#10;


//  s := s+' (SELECT COUNT(id) FROM persons WHERE %s=roomreservations.%s) AS numTaxGuests '+#10;
  if iRoomReservation = 0 then   //FRoomReservation = 0  // GroupInvoice
  begin
    s := s+' (SELECT COUNT(id) FROM persons WHERE %s=rr.%s) AS numTaxGuests '+#10;
  end else
  begin
    s := s+' (SELECT COUNT(id) FROM persons WHERE %s=rr.%s) AS numTaxGuests '+#10;
  end;

  s := s+'  FROM '+#10;
  s := s+'     roomreservations rr '+#10;
  s := s+'  JOIN (SELECT DISTINCT RoomReservation FROM roomsdate WHERE RoomReservation=%d OR PaidBy=%d) RoomReses ON rr.RoomReservation = RoomReses.RoomReservation ';
  s := s+'  LEFT OUTER JOIN ' +#10;
  s := s+'    roomtypes rt ON rt.RoomType = rr.RoomType ' +#10;
  s := s+'  LEFT OUTER JOIN ' +#10;
  s := s+'    rooms r ON r.Room = rr.room ' +#10;
  s := s+'  WHERE ' +#10;
  if iRoomReservation = 0 then   //FRoomReservation = 0  // GroupInvoice
  begin
    S := Format(S, ['Reservation','Reservation']) + ' Reservation=%d '+#10;    // inttostr(publicReservation) + ' '+chr(10);
  end else
  begin
    S := Format(S, ['RoomReservation', 'RoomReservation']) + ' RoomReservation=%d '+#10  //inttostr(FRoomReservation)+chr(10);
  end;
  result := s;
end;

function Select_Invoice_LoadInvoice3_WithInvoiceIndex(iRoomReservation, iReservation, InvoiceIndex : integer; Customer : String; FakeGroup : Boolean) : string;
var
  s : string;
begin
  s := '';
  s := s+' SELECT '+#10;
  s := s+' rr.RoomReservation, '+#10; //
  s := s+' rr.Room, '+#10; //
  s := s+' rr.Status, '+#10; //
  s := s+' rr.GroupAccount, '+#10; //
  s := s+' rr.invBreakfast, '+#10;
  s := s+' rr.Discount, '+#10; //
  s := s+' rr.Percentage, '+#10; //
  s := s+' rr.PriceType, '+#10; //
  s := s+' rr.RoomType, '+#10; //
  s := s+' rr.rrDescription, '+#10; //
  s := s+' rr.rrDeparture, '+#10; //
  s := s+' rr.rrArrival, '+#10; //
  s := s+' (SELECT COUNT(id) FROM persons WHERE RoomReservation=rr.RoomReservation) AS numGuests, '+#10; //
  s := s+' rr.numChildren, '+#10; //
  s := s+' rr.numInfants, '+#10; //
  s := s+' rr.AvrageRate, '+#10; //
  s := s+' rr.RateCount, '+#10; //
  s := s+' rr.Package, '+#10; //

  s := s+'(SELECT GROUP_CONCAT(DISTINCT Email SEPARATOR '';'') ' +
         ' FROM (SELECT Email FROM persons WHERE EMail <>'''' AND %s=%d ' +
         ' UNION ALL ' +
         ' SELECT EmailAddress FROM customers WHERE EmailAddress<>'''' AND Customer=%s ' +
         ' UNION ALL ' +
         ' SELECT ContactEmail FROM reservations WHERE ContactEmail <>'''' AND Reservation=%d ' +
         ' UNION ALL ' +
         ' SELECT CustomerEmail FROM reservations WHERE CustomerEmail <>'''' AND Reservation=%d ' +
         ' ) xxx) AS ContactEmail,'; //
  s := s+' (SELECT Email FROM persons p WHERE p.RoomReservation=rr.RoomReservation AND p.MainName=1 LIMIT 1) AS GuestEmail, '+#10; //

  s := s+' r.Description AS RoomDescription, '+#10; //
  s := s+' rt.Description AS RoomTypeDescription, '+#10; //

  if iRoomReservation = 0 then   //FRoomReservation = 0  // GroupInvoice
  begin
    s := format(s, ['Reservation', iReservation, _db(Customer), iReservation, iReservation]);
    s := s+' (SELECT COUNT(id) FROM persons WHERE %s=rr.%s) AS numTaxGuests '+#10;
  end else
  begin
    s := format(s, ['RoomReservation', iRoomReservation, _db(Customer), iReservation, iReservation]);
    s := s+' (SELECT COUNT(id) FROM persons WHERE %s=rr.%s) AS numTaxGuests '+#10;
  end;

  s := s+'  FROM '+#10;
  s := s+'     roomreservations rr '+#10;
  s := s+'  LEFT OUTER JOIN ' +#10;
  s := s+'    roomtypes rt ON rt.RoomType = rr.RoomType ' +#10;
  s := s+'  LEFT OUTER JOIN ' +#10;
  s := s+'    rooms r ON r.Room = rr.room ' +#10;
  s := s+'  WHERE ' +#10;
  if iRoomReservation = 0 then   //FRoomReservation = 0  // GroupInvoice
  begin
    if InvoiceIndex <> -1 then
      s := Format(s, ['Reservation','Reservation']) + ' Reservation=%d AND InvoiceIndex=' + inttostr(InvoiceIndex) + ' ' +#10
    else
      s := Format(s, ['Reservation','Reservation']) + ' Reservation=%d ' +#10;
    if NOT FakeGroup then
      s := s + ' AND rr.GroupAccount=1 ';
  end else
  begin
    S := Format(S, ['RoomReservation', 'RoomReservation']) +
         ' RoomReservation IN (SELECT rd.RoomReservation ' +
         ' FROM roomsdate rd JOIN roomreservations rr ON rr.RoomReservation=rd.RoomReservation ' +
         ' WHERE (ResFlag NOT IN (''X'',''C'')) AND (rr.GroupAccount = 0 AND (PaidBy=%d OR (rd.RoomReservation=%d AND PaidBy=0))) ' +
         IIF(InvoiceIndex <> -1, ' AND rr.InvoiceIndex = ' + inttostr(InvoiceIndex), '') + ') ' + #13;
  end;
  result := s;
end;

//TESTED OK
function select_InvoiceList_BitBtn2Click(Medhod : integer) : string;
var
  s : string;
begin
  s := '';
  s := s+' SELECT * from invoiceheads '+#10;
  if medhod = 1 then
  begin
    s := s+ ' where InvoiceDate >= %s '+#10;      //_DateToDBDate(dtFrom.Date,true) ;
    s := s+ '   and InvoiceDate <= %s '+#10;      //_DateToDBDate(dtTo.Date,true) ;
    s := s+ '   and InvoiceNumber > 0'+#10;
    s := s+ 'Order By InvoiceDate'+#10;
  end else
  if medHod = 2 then
  begin
    s := s+ ' where InvoiceNumber >= %d '+#10; // inttostr( strtointdef( edtInvoiceFrom.text, 0 ) ) ;
    s := s+ '   and InvoiceNumber <= %d '+#10;  // inttostr( strtointdef( edtInvoiceTo.text, 0 ) ) ;
    s := s+ 'Order By InvoiceNumber'+#10;
  end else
  if medHod = 3 then
  begin
    s := s+ ' where InvoiceNumber = %d '+#10; //+ inttostr( strtointdef( edtInvoice.text, 0 ) ) ;
  end;
  result := s;
end;



  //TESTED OK
  function select_Main_refreshGuestList : string;
  var
    s : string;
  begin

    s := s+' SELECT '#10;
    s := s+'     roomreservations.RoomReservation '#10;
    s := s+'   , roomreservations.rrArrival as ArrivalDate '#10;
    s := s+'   , roomreservations.rrDeparture as DepartureDate '#10;
    s := s+'   , to_int(DATEDIFF(roomreservations.rrDeparture,roomreservations.rrArrival)) as NumDays '#10;
    s := s+'   , roomreservations.Room '#10;
    s := s+'   , roomreservations.Status '#10;
    s := s+'   , roomreservations.invBreakfast AS Breakfast '#10;
    s := s+'   , roomreservations.rrIsNoRoom As NoRoom '#10;
    s := s+'   , roomreservations.GroupAccount '#10;
    s := s+'   , roomreservations.AvrageRate AS AverageRate '#10;
    s := s+'   , roomreservations.Currency AS Currency '#10;
    s := s+'   , roomreservations.numGuests AS NumGuests '#10;
    s := s+'   , roomreservations.numChildren AS NumChildren '#10;
    s := s+'   , roomreservations.numInfants AS NumInfants '#10;
    s := s+'   , reservations.Name AS ReservationName '#10;
    s := s+'   , reservations.Reservation '#10;
    s := s+'   , reservations.marketSegment '#10;
    s := s+'   , reservations.CustomerEmail AS Email '#10;
    s := s+'   , reservations.CustomerWebsite AS WebSite '#10;
    s := s+'   , rooms.RoomType '#10;
    s := s+'   , rooms.Description AS RoomDescription'#10;
    s := s+'   , rooms.Bookable '#10;
    s := s+'   , Statistics '#10;
    s := s+'   , rooms.hidden '#10;
    s := s+'   , rooms.Location '#10;
    s := s+'   , rooms.Floor '#10;
    s := s+'   , rooms.Equipments '#10;
    s := s+'   , locations.description AS LocationDescription '#10;
    s := s+'   , customers.Customer '#10;
    s := s+'   , customers.Surname AS CustomerName '#10;
    s := s+'   , customers.PID AS PersonalID '#10;
    s := s+'   , customertypes.Description AS marketSegmentDescription '#10;
    s := s+'   , (SELECT count(id) FROM roomreservations rr WHERE rr.reservation = reservations.reservation) As RoomCount '#10;
    s := s+'   , (SELECT count(id) FROM persons pe WHERE pe.reservation = reservations.reservation) As RvGuestCount '#10;
    s := s+'   , (SELECT count(id) FROM persons pe WHERE pe.roomreservation = roomreservations.roomreservation) AS RRGuestCount '#10;
    s := s+'   , (SELECT pe.`Name` FROM persons pe WHERE pe.roomreservation = roomreservations.roomreservation ORDER BY pe.MainName DESC, pe.Person LIMIT 1) As MainGuests  '#10;
    s := s+'   , (SELECT di.`result` FROM dictionary di WHERE di.`Code` = roomreservations.`status`) AS StatusText  '#10;
    s := s+' FROM '#10;
    s := s+'   customertypes '#10;
    s := s+'   RIGHT OUTER JOIN '#10;
    s := s+'     reservations ON customertypes.CustomerType = reservations.marketSegment '#10;
    s := s+'   LEFT OUTER JOIN '#10;
    s := s+'     customers ON reservations.Customer = customers.Customer '#10;
    s := s+'   RIGHT OUTER JOIN '#10;
    s := s+'      rooms '#10;
    s := s+'   LEFT OUTER JOIN '#10;
    s := s+'     locations ON  rooms.Location = locations.Location '#10;
    s := s+'   RIGHT OUTER JOIN '#10;
    s := s+'     roomreservations ON  rooms.Room = roomreservations.Room ON reservations.Reservation = roomreservations.Reservation '#10;
    s := s+' WHERE '#10;
    s := s+ '   (roomreservations.RoomReservation in %s ) '#10; //zRoomReservationList

    s := s+' ORDER BY '#10;
    //@hj breytti h�r
    s := s+'   reservations.Reservation, roomreservations.Room '#10;
    result := s;
  end;


  //TESTED OK
  function select_NationalReport3_getRoomInfo(location : string) : string;
  var
    s : string;
  begin
    s := '';
    s := s+' SELECT '#10;
    s := s+'     COUNT(rooms.Room) AS RoomCount '#10;
    s := s+'   , SUM(roomtypes.NumberGuests) AS BedCount '#10;
    s := s+' FROM '#10;
    s := s+'    rooms '#10;
    s := s+'     INNER JOIN '#10;
    s := s+'       roomtypes ON  rooms.RoomType = roomtypes.RoomType '#10;
    s := s+' WHERE '#10;
    s := s+'  ( '#10;
    s := s+'      (rooms.Bookable = 1) '#10;
    s := s+'  AND (rooms.useInNationalReport = 1) '#10;
    if Location <> '' then
    begin
      s := s + '  AND (rooms.Location = %s ) '#10; //'+quotedStr(zLocation)+'
    end;
    s := s+' ) '#10;
    result := s;
  end;



    //TESTED OK
    function select_ProvideARoom2_Display(orStr, Roomtype : string) : string;
    var
      s : string;
    begin
      s:= s+' SELECT '#10;
      s:= s+'       rooms.Room '#10;
      s:= s+'    ,  rooms.Description AS RoomDescription '#10;
      s:= s+'    , roomtypes.Description AS RoomTypeDescription '#10;
      s:= s+'    , roomtypes.NumberGuests '#10;
      s:= s+'    , locations.Description AS LocationDescription '#10;
      s:= s+'    ,  rooms.RoomType '#10;
      s:= s+'    ,  rooms.SqrMeters '#10;
      s:= s+'    ,  rooms.BedSize '#10;
      s:= s+'    ,  rooms.Equipments '#10;
      s:= s+'    ,  rooms.Bookable '#10;
      s:= s+'    ,  maintenancecodes.name as Status '#10;
      s:= s+'    ,  rooms.OrderIndex '#10;
      s:= s+'    ,  rooms.hidden '#10;
      s:= s+'    ,  rooms.Location '#10;
      s:= s+'    ,  rooms.Floor '#10;
      s:= s+'    ,  rooms.Bath '#10;
      s:= s+'    ,  rooms.Shower '#10;
      s:= s+'    ,  rooms.Safe '#10;
      s:= s+'    ,  rooms.TV '#10;
      s:= s+'    ,  rooms.Video '#10;
      s:= s+'    ,  rooms.Radio '#10;
      s:= s+'    ,  rooms.CDPlayer '#10;
      s:= s+'    ,  rooms.Telephone '#10;
      s:= s+'    ,  rooms.Press '#10;
      s:= s+'    ,  rooms.Coffee '#10;
      s:= s+'    ,  rooms.Kitchen '#10;
      s:= s+'    ,  rooms.Minibar '#10;
      s:= s+'    ,  rooms.Fridge '#10;
      s:= s+'    ,  rooms.Hairdryer '#10;
      s:= s+'    ,  rooms.InternetPlug '#10;
      s:= s+'    ,  rooms.Fax '#10;
      s:= s+'  FROM  '#10;
      s:= s+'     rooms  '#10;
      s:= s+'      LEFT OUTER JOIN locations ON  rooms.Location = locations.Location '#10;
      s:= s+'      LEFT OUTER JOIN roomtypes ON  rooms.RoomType = roomtypes.RoomType '#10;
      s:= s+'      LEFT OUTER JOIN maintenancecodes ON  rooms.status = maintenancecodes.code '#10;
      s:= s+'  WHERE '#10;
      s:= s+'    (hidden = 0) '#10;
      s:= s+' AND (rooms.Room <>  %s ) '#10; //quotedstr(zRoom)

      if orStr <> '' then
        s := s+  orStr + ' '+chr(10);

      if roomType <> '' then
        s := s + '    AND (rooms.RoomType = %s ) '#10;  //quotedstr(roomType)

        s := s + ' ORDER BY rooms.Room '#10;
  //    s := s + ' ORDER BY maintenancecodes.selectionOrder, rooms.Room '#10;

      result := s;

    end;


(*
    //Create function  skip for now
    function ReservationsModel_Execute : string =
    'SELECT  '+
    ' rv.Customer '+
    ' , rv.Reservation '+
    ' , rv.Name '+
    ' , rv.Arrival '+
    ' , rv.Departure '+
    ' , rv.InputSource '+
    ' , rv.WebConfirmed '+
    ' , rr.Arrival as RoomArrival '+
    ' , rr.Departure as RoomDeparture '+
    ' , rr.room as rrRoom '+
    ' , rv.ReservationDate '+
    ' , rv.Staff '+
    ' , rv.Information as rvInformation '+
    ' , rv.Tel1 '+
    ' , rv.Tel2 '+
    ' , rv.Fax '+
    ' , rv.PMInfo as rvPMInfo '+
    ' , rv.HiddenInfo as rvHiddenInfo '+
    ' , rd.ADate '+
    ' , rd.Room '+
    ' , rd.RoomType '+
    ' , rr.Status '+
    ' , rr.RoomReservation '+
    ' , rr.Currency '+
    ' , rr.RoomPrice1 '+
    ' , rr.Discount '+
    ' , rr.Percentage '+
    ' , rr.PriceType '+
    ' , rr.HallRes AS rrHallRes '+
    ' , rr.PMInfo as rrPMInfo '+
    ' , rr.HiddenInfo as rrHiddenInfo '+
    ' , rr.RoomRentPaymentInvoice '+
    ' , pe.Person '+
    ' , pe.Surname '+
    ' , pe.Name as peName '+
    ' , pe.Address1 '+
    ' , pe.Address2 '+
    ' , pe.Address3 '+
    ' , pe.Address4 '+
    ' , pe.Country '+
    ' , pe.GuestType '+
    ' , pe.Information '+
    '      , ( '+
    ' SELECT TOP (1) '+
    '      ih.Total '+
    '  FROM '+
    '     invoiceheads ih '+
    '  WHERE '+
    '    (Total > 0) AND (ih.InvoiceNumber = - 1) AND (ih.RoomReservation = rr.roomReservation) '+
    '    ) as TotalNoRent '+
    '  FROM '+
    '       reservations rv '+
    '     ,  roomsdate rd '+
    '     , roomreservations rr '+
    '     , persons pe '+
    '  WHERE '+
    ' (';
///
///    if _FromDate + 1 = _ToDate then
///    begin
///      s := s + '       rd.ADate = ' + _DateToDBDate(_FromDate,true)+chr(10)
///    end
///    else
///    begin
///      s := s + '       ( rd.ADate >= ' + _DateToDBDate(_FromDate,true)+chr(10);
///      s := s + '   and   rd.ADate <  ' + _DateToDBDate(_ToDate,true) + ')'+chr(10);
///    end;
///    s := s + '   or  ( rr.Departure = ' + _DateToDBDate(_ToDate - 1,true) + ')'+chr(10);
///    s := s + ' )'+chr(10);
///
///    case _ReservationState of
///      rsUnKnown :
///        ;
///      rsReservations :
///        s := s + ' and   rr.Status = ''P'''+chr(10);
///      rsGuests :
///        s := s + ' and   rr.Status = ''G'''+chr(10);
///      rsDeparted :
///        s := s + ' and   rr.Status = ''D'''+chr(10);
///      rsReserved :
///        s := s + ' and   rr.Status = ''R'''+chr(10);
///      rsOverbooked :
///        s := s + ' and   rr.Status = ''O'''+chr(10);
///      rsAlotment :
///        s := s + ' and   rr.Status = ''A'''+chr(10);
///      rsNoShow :
///        s := s + ' and   rr.Status = ''N'''+chr(10);
///      rsBlocked :
///        s := s + ' and   rr.Status = ''B'''+chr(10);
///      rsAll :
///        ;
///      rsCurrent :
///        begin
///          s := s + ' and ( '+chr(10);
///          s := s + '       rr.Status = ''P'''+chr(10);
///          s := s + '  or   rr.Status = ''G'''+chr(10);
///          s := s + '     ) '+chr(10);
///        end;
///    end;
///
///    s := s + ' and   rv.Reservation = rr.Reservation'+chr(10);
///    s := s + ' and   rd.RoomReservation = rr.RoomReservation'+chr(10);
///    s := s + ' and   rr.RoomReservation = pe.RoomReservation'+chr(10);
///    s := s + ' order by rv.Reservation, rr.RoomReservation, pe.person'+chr(10);

*)
    //NOT Tested
    function select_ReservationProfile_RegulateRoomDates(bAll : boolean) : string;
    var
      s : string;
    begin
      s := '';
      s := s+' SELECT * FROM roomreservations '#10;
      s := s+' WHERE Reservation = %d '#10;
      if not bAll then
      begin
        S := S + '   AND Arrival = %s '#10;      //_DateToDBDate(zInitDateFrom, true)
        S := S + '   AND Departure = %s '#10;   //_DateToDBDate(zInitDateTo, true);
      end;
      result := s;
    end;


///' WHERE Reservation = ' + inttostr(zReservation);


    //TESTED NOT
    function select_ResGuestList_Refresh(ShowAllGuests : boolean) : string;
    var
      s : string;
    begin
      s := ' SELECT  '#10;
      s := s+'    persons.Person  '#10;
      s := s+'  , persons.Reservation  '#10;
      s := s+'  , persons.Name  As GuestName '#10;
      s := s+'  , persons.Address1  '#10;
      s := s+'  , persons.Address2  '#10;
      s := s+'  , persons.Address3  '#10;
      s := s+'  , persons.Country  '#10;
      s := s+'  , persons.GuestType  '#10;
      s := s+'  , persons.Information  '#10;
      s := s+'  , persons.PID  '#10;
      s := s+'  , persons.MainName As isMainName '#10;
      s := s+'  , persons.RoomReservation  '#10;
      s := s+'  , roomreservations.Room  '#10;
      s := s+'  , roomreservations.RoomType  '#10;
      s := s+'  , roomreservations.Status As  roomstatus '#10;
      s := s+'  , roomreservations.rrArrival  '#10;
      s := s+'  , roomreservations.rrDeparture  '#10;
      s := s+'  , roomreservations.rrIsNoRoom  '#10;
      s := s+' FROM  '#10;
      s := s+'   persons  '#10;
      s := s+'     LEFT OUTER JOIN  '#10;
      s := s+'        roomreservations ON persons.RoomReservation = roomreservations.RoomReservation  '#10;
      s := s+' WHERE  '#10;
      s := s+'   (persons.Reservation = %d)  '#10;// inttostr(zReservation#10;
      if not ShowAllGuests then
      begin
        s := s + '  AND (name <> ''RoomGuest'') '#10;
      end;
      s := s + ' ORDER BY  '#10;
      s := s + '   roomreservations.Room, persons.Person  '#10;

      result := s;
    end;



  //Tested NOT
  function select_RptCustomer_AllCustInReikn2(isOneDay : boolean) : string;
  var
    s : string;
  begin
    s := s+' SELECT '#10;
    s := s+'      Customer, '#10;
    s := s+'      SurName, '#10;
    s := s+'      PID, '#10;
    s := s+'      PayGroup, '#10;
    s := s+'      SUM(Total) AS Total, '#10;
    s := s+'      COUNT(InvoiceNumber) AS ItemCount '#10;
    s := s+'   FROM '#10;
    s := s+'      w_sale_invoice_payments_per_date '#10;
    s := s+'    WHERE '#10;
    s := s+'      (payGroup =  %s ) AND '#10; //quotedStr(zPgReikn)
    if isOneDay then
    begin
      s := s + '      (InvoiceDate = %s ) '#10; //quotedStr(zDatefrom)
    end else
    begin
      s := s + '    (  (InvoiceDate >= %s ) '#10;     // quotedStr(zDatefrom)
      s := s + '  AND  (InvoiceDate <= %s ) ) '#10;   // quotedStr(zDateTo)
    end;
    s := s+'   GROUP BY '#10;
    s := s+'      PayGroup '#10;
    s := s+'     ,Customer '#10;
    s := s+'     ,PID '#10;
    s := s+'     ,SurName ';
    result := s;
  end;

function select_RptCustomer_ReiknByCust2(isOneDay : boolean) : string;
var
  s : string;
begin
  s := '';
	s := s+' SELECT '#10;
	s := s+'   invoiceheads.Reservation '#10;
	s := s+' , invoiceheads.RoomReservation '#10;
	s := s+' , invoiceheads.InvoiceNumber '#10;
	s := s+' , invoiceheads.InvoiceDate '#10;
	s := s+' , invoiceheads.Customer '#10;
	s := s+' , invoiceheads.Name AS invName'#10;
	s := s+' , invoiceheads.CreditInvoice '#10;
	s := s+' , payments.PayType '#10;
	s := s+' , payments.Amount '#10;
	s := s+' , payments.Description AS pmDescription '#10;
	s := s+' , payments.Currency '#10;
	s := s+' , payments.CurrencyRate '#10;
	s := s+' , payments.Ayear '#10;
	s := s+' , payments.Amon '#10;
	s := s+' , payments.Aday '#10;
	s := s+' , invoiceheads.Total '#10;
	s := s+' , invoiceheads.TotalWOVAT '#10;
	s := s+' , invoiceheads.TotalVAT '#10;
	s := s+' , paytypes.Description AS ptDescription '#10;
	s := s+' , paytypes.PayGroup '#10;
	s := s+' , paygroups.Description AS pgDescription '#10;
	s := s+' FROM '#10;
	s := s+'   paytypes '#10;
	s := s+'      LEFT OUTER JOIN '#10;
	s := s+'         paygroups ON paytypes.PayGroup = paygroups.Description '#10;
	s := s+'      RIGHT OUTER JOIN '#10;
	s := s+'         payments ON paytypes.PayType = payments.PayType '#10;
	s := s+'      RIGHT OUTER JOIN '#10;
	s := s+'         invoiceheads ON payments.InvoiceNumber = invoiceheads.InvoiceNumber '#10;
	s := s+' WHERE '#10;
	s := s+'        (invoiceheads.InvoiceNumber <> - 1) '#10;
	if isOneDay then
	begin
	    s := s + '  AND (InvoiceDate = %s ) '#10;  //quotedStr(zDatefrom)
	end else
	begin
	  s := s + '  AND  (  (InvoiceDate >= %s ) '#10;  //quotedStr(zDatefrom)
	  s := s + '  AND  (InvoiceDate <= %s ) ) '#10;   //quotedStr(zDateTo)
	end;
	s := s + '    AND (paytypes.PayGroup = %s ) '#10;  //quotedStr(zPgReikn)
	s := s + '    AND (invoiceheads.Customer = %s) '#10;  //quotedStr(zCustomer)
	s := s + ' ORDER BY '#10;
	s := s + '    invoiceheads.InvoiceDate ';
  result := s;
end;


function select_RptCustomerStay_Refresh1(iDateMark : integer) : string;
var
  s : string;
begin
  s:= s+' SELECT '#10;
  s:= s+'     roomreservations.Room '#10;
  s:= s+'   , roomreservations.RoomType '#10;
  s:= s+'   , roomreservations.RoomReservation '#10;
  s:= s+'   , roomreservations.Reservation '#10;
  s:= s+'   , roomreservations.Status '#10;
  s:= s+'   , roomreservations.rrArrival AS Arrival '#10;
  s:= s+'   , roomreservations.rrDeparture AS Departure '#10;
  s:= s+'   , reservations.Customer '#10;
  s:= s+'   , reservations.invRefrence AS ResRefrence '#10;
  s:= s+'   , reservations.Name AS ReservationName '#10;
  s:= s+'   , customers.Surname AS CustomerName '#10;
  s:= s+'   , persons.name AS personName '#10;
  s:= s+'   , (SELECT count(person) FROM persons WHERE roomreservation = roomreservations.roomreservation) AS numPersons '#10;
  s:= s+' FROM '#10;
  s:= s+'   customers '#10;
  s:= s+'     RIGHT OUTER JOIN '#10;
  s:= s+'       reservations ON customers.Customer = reservations.Customer '#10;
  s:= s+'         RIGHT OUTER JOIN '#10;
  s:= s+'            roomreservations ON reservations.Reservation = roomreservations.Reservation '#10;
  s:= s+'     LEFT OUTER JOIN persons ON persons.roomreservation = roomreservations.roomreservation '#10;
  s:= s+' WHERE '#10;
  s:= s+'      (reservations.Customer =  %s ) '#10;
  if iDateMark = 0 then
  begin
    s := s + '     AND (roomreservations.rrArrival >= %s ) ';  //_DateToDBDate(zDateFrom, true)
    s := s + '     AND (roomreservations.rrArrival <= %s ) ';  //_DateToDBDate(zDateTo, true)
  end else
  if iDateMark = 1 then
  begin
    s := s + '     AND (roomreservations.rrDeparture >= %s ) ';  //_DateToDBDate(zDateFrom, true)
    s := s + '     AND (roomreservations.rrDeparture <= %s ) ';  //_DateToDBDate(zDateTo, true)
  end;
  s := s + ' GROUP BY roomreservations.reservation, roomreservations.roomreservation ';
  s := s + ' ORDER BY roomreservations.Reservation, room, rrArrival ';
  result := s;
end;


  //TESTED NOT
  function select_qryGetinvoicelinesTmp(iRoomReservation : integer) : string;
  var
    s : string;
  begin
    s := s+' SELECT '#10;
    s:= s+' * '#10;
    s:= s+' FROM '#10;
    s:= s+' invoicelinestmp '#10;
    if iRoomReservation <> - 1 then
    begin
      s := s + 'WHERE '+#10;
      s := s + 'RoomReservation= %d '#10; //inttostr(iRoomReservation)
    end;
    s := s + 'ORDER BY %s  '+#10; //Orderstr
    result := s
  end;

  //TESTED NOT
  function select_OpenInvoiceinvoicelines(reservation,roomreservation : integer) : string;
  var
    s : string;
  begin
    s := s+' SELECT '#10;
    s := s+' COUNT(*) (*AS InvCount '#10;
    s := s+' FROM invoicelines  '#10;
    s := s+' WHERE (InvoiceNumber = -1) '#10;
    if reservation > 0 then
      s := s + ' AND (Reservation = %d ) '+#10; //' + inttostr(reservation) + '
    if RoomReservation > 0 then
      s := s + ' AND (RoomReservation = %d ) '+#10;  //' + inttostr(RoomReservation) + '
    result := s;
  end;

  //TESTED NOT
	function select_NameOnOpenInvoice(reservation,roomreservation : integer) : string;
  var
    s : string;
  begin
    s := s+' SELECT '#10;
    s := s+' Name '#10;
    s := s+' FROM invoiceheads  '#10;
    s := s+' WHERE (InvoiceNumber = -1) '#10;
    if reservation > 0 then
      s := s + ' AND (Reservation = %d ) '+#10;

    if RoomReservation > 0 then
      s := s + ' AND (RoomReservation = %d ) '+#10;
    result := s;
  end;

  //TESTED NOT


  //TESTED NOT
	function select_SnertaExportCustomers(CustNO : string) : string;
  var
    s : string;
  begin
    s := s+' SELECT '#10;
    s := s+' * '#10;
    s := s+' FROM '#10;
    s := s+' customers ';
    if custNo <> '' then
    begin
      s := s + ' WHERE '+#10;
      s := s + ' Customer =%s '+#10;  //quotedstr(custNo)
    end;
    s := s + ' ORDER BY customer '+#10;
    result := s;
  end;

  //TESTED NOT
  function select_SnertaExportRooms(room : string) : string;
  var
    s : string;
  begin
    s := s+' SELECT '#10;
    s := s+' * '#10;
    s := s+' FROM '#10;
    s := s+'  rooms '#10;
    if Room <> '' then
    begin
      s := s + ' WHERE '+#10;
      s := s + ' Room = %s '+#10;  //quotedstr(Room)
    end;
    s := s + ' ORDER BY Room '+#10;
    result := s;
  end;

  //TESTED NOT
  function select_RRlst_DepartureNationalReportByLocation(location : string ) : string;
  var
    s : string;
  begin
    s := s+'  SELECT'#10;
    s := s+'    DISTINCT'#10;
    s := s+'    RoomReservation'#10;
    s := s+'  FROM'#10;
    s := s+'    roomreservations'#10;
    if Location <> '' then
    begin
      s := s + ' INNER JOIN '+#10;
      s := s + '    rooms ON roomreservations.Room =  rooms.Room '+#10;
      s := s + ' INNER JOIN '+#10;
      s := s + '   locations ON  rooms.Location = locations.Location '+#10;
    end;
    s := s + '  WHERE'+#10;
    s := s + '        (Departure >= %s )'+#10;  //'+_DateToDbDate(DateFrom,true)+'
    s := s + '    AND (Departure <= %s )'+#10;  //'+_DateToDbDate(DateTo,true)+'
    s := s + '    AND (roomreservations.useInNationalReport = 1 )'+#10;  //'+_db(true)+'
    if Location <> '' then
    begin
      s := s + ' AND (locations.Location = %s ) '+#10;  //'+quotedstr(Location)+'
    end;
    s := s + '  ORDER BY RoomReservation'+#10;
    result := s;
  end;


function select_GetRackPrices(priceCodeID,RackPriceID : integer) : string;
var
  s : string;
begin
  s := '';
  s := s + 'SELECT '+#10;
  s := s + '* '#10;
  s := s + 'FROM '#10;
  s := s + '  viewroomprices1 '#10;
  s := s + 'WHERE  '#10;
  s := s + '( (Id > -1) '#10; // just to start then AND sequance
  s := s + ' AND (pcID=%d) '#10;  //' + inttostr(RackPriceID) + '
  s := s + ' AND (RoomType=%s) '#10;  //' + quotedstr(RoomType) + '
  s := s + ' AND (Currency=%s) '#10; //' + quotedstr(Currency) + '
  if priceCodeID <> RackPriceID then
  begin
    s := s + ' AND (seID=%d) '#10;    //' + inttostr(seasonId) + '
  end;
  s := s + ' ) ';

  result := s;
end;


function select_Convert(Direction : integer) : string;
var
  s : string;
begin
  s := '';
  s := s + 'SELECT '+#10;
  s := s + 'cvType, cvFrom, cvTo '+#10;
  s := s + 'FROM '+#10;
  s := s + 'tblconverts '+#10;
  s := s + 'WHERE '+#10;
  if Direction = cToHome then
    s := s + '(cvType = %s) AND (cvTo = %s) '+#10;  //' + _db(sType) + '  //' + _db(sValue) + '
  if Direction = cHomeTo then
    s := s + '(cvType = %S) AND (cvFrom = %S) ';  //' + _db(sType) + ' ' + _db(sValue) + '

  result := s;
end;

function GetRoomTypeAvailabilitySql(FromDate, ToDate : TDate) : String;
var s : String;
begin
  s := 'SELECT RoomType, NumRooms - IFNULL(NumTaken, 0) AS NumAvailable ' +
       'FROM ( ' +
       'SELECT rt.RoomType, COUNT(r.id) AS NumRooms, ' +
       '		(SELECT COUNT(id) AS Num FROM roomsdate ' +
       '		 WHERE ADate >= %s AND ADate <= %s ' +
       '         AND RoomType=rt.RoomType ' +
       '         AND (NOT ResFlag IN (''C'',''X'',''D'',''N'')) ' +
       '         GROUP BY ADate, RoomType ' +
       '         ORDER BY Num DESC ' +
       '         LIMIT 1) AS NumTaken ' +
       'FROM roomtypes rt ' +
       '     JOIN rooms r ON r.RoomType=rt.RoomType AND r.Active=1 ' +
       'GROUP BY rt.RoomType ' +
       ') xxx';
  result := format(s, [_db(uDateUtils.dateToSqlString(FromDate)), _db(uDateUtils.dateToSqlString(ToDate))]);
end;

end.



