unit uTemplateFiller;

interface

function fillInBookingInformation(booking : Integer; template : String; var Subject: String; filterOutCancels : Boolean = True) : String;

implementation

uses SysUtils,
     Classes,
     StrUtils,
     uUtils,
     uDateUtils,
     PrjConst,
     uD,
     cmpRoomerDataset,
     HData,
     _Glob,
     uStringUtils,
     System.Generics.Collections,
     TypInfo
     ;

type TBookingConfirmationEmailItems = (
          _channelName,
          _channelId,
          _bookingChannelId,
          _bookingRoomerId,
          _bookingArrival,
          _bookingDeparture,
	        _bookingNights,
          _bookingGuestsRoomsPrices,
          _bookingTotalPrice,
          _bookingDatetime,
          _bookingPaymentType,
          _bookingPaymentStatus,
          _bookingPaymentAmount,
          _bookingPaymentCreditCard,
          _currentDatetime,
          _profileGuestName,

          _bookingGuestName,
          _bookingGuestAddress1,
          _bookingGuestAddress2,
          _bookingGuestZip,
          _bookingGuestCity,
          _bookingGuestCountryCode,
          _bookingGuestCountryName,

          _bookingNumberOfGuest,
          _bookingNumberOfRooms,

          _customerId,
          _customerName,
          _customerAddress1,
          _customerAddress2,
          _customerZip,
          _customerCity,
          _customerCountryCode,
          _customerCountryName,

          _salutation,
          _explanatoryLine1,
          _explanatoryLine2,
          _explanatoryLine3,
          _explanatoryLine4,
          _infoChannel,
          _infoChannelId,
          _infoBookingChannelId,
          _infoBookingRoomerId,
          _infoArrival,
          _infoDeparture,
          _infoContactName,
          _infoProfileName,
          _infoRoomsGuestsPrices,
          _infoPayment,
          _infoPaymentType,
          _infoPaymentStatus,
          _infoPaymentAmount,
          _infoPaymentCreditCard,
          _signoffLine1,
          _signoffLine2
          );



const CC_PAYMENT : String = 'CC PAYMENT:';
	    CC_ASSURANCE : String	= 'CC ASSURANCE VERIFICATION:';


function getRoomRow(rSetRoomsDate : TRoomerDataset) : String; forward;
function getPaymentInformation(information : String) : TDictionary<TBookingConfirmationEmailItems, String>; forward;
function GetPaymentInfoFromDict(paymentInformation : TDictionary<TBookingConfirmationEmailItems, String>; Key : TBookingConfirmationEmailItems) : String; forward;

function GetCorrectQuotes(sIn : String) : String;
begin
  result := ReplaceString(sIn, '"', '''');
end;

function fillInBookingInformation(booking : Integer; template : String; var Subject: String; filterOutCancels : Boolean = True) : String;
var bookingGuestsRoomsPrices : String;
    totalBookingPrice : Double;

    s : String;
    rSetRoomsDate : TRoomerDataset;
    bookingNights : Integer;
    ChannelId,
    ChannelCode,
    ChannelName,
    Information,
    BookingId,
    Guestname,
    bookingGuestAddress1,
    bookingGuestAddress2,
    bookingGuestZip,
    bookingGuestCity,
    bookingGuestCountryCode,
    bookingGuestCountryName,

    customerId,
    customerName,
    customerAddress1,
    customerAddress2,
    customerZip,
    customerCity,
    customerCountryCode,
    customerCountryName,

    bookingNumberOfGuest,
    bookingNumberOfRooms,

    ContactName,
    Currency : String;

    CreatedAt : TDateTime;
    Arrival,
    Departure : TDate;

    paymentInformation : TDictionary<TBookingConfirmationEmailItems, String>;

    procedure GetGlobals;
    begin
      Currency := rSetRoomsDate['Currency'];

      bookingNights := rSetRoomsDate['NumberOfNights'];

      Information := rSetRoomsDate['Information'];
      ChannelCode := rSetRoomsDate['ChannelCode'];
      ChannelId := rSetRoomsDate['ChannelId'];
      ChannelName := rSetRoomsDate['ChannelName'];
      BookingId := rSetRoomsDate['BookingId'];
      GuestName := rSetRoomsDate['GuestName'];
      ContactName := rSetRoomsDate['ContactName'];
      CreatedAt := rSetRoomsDate['CreatedAt'];

      bookingGuestAddress1 := rSetRoomsDate['GuestAddress1'];
      bookingGuestAddress2 := rSetRoomsDate['GuestAddress2'];
      bookingGuestZip := rSetRoomsDate['GuestZip'];
      bookingGuestCity := rSetRoomsDate['GuestCity'];
      bookingGuestCountryCode := rSetRoomsDate['GuestCountry'];
      bookingGuestCountryName := rSetRoomsDate['GuestCountryName'];

      customerId := rSetRoomsDate['customerCode'];
      customerName := rSetRoomsDate['customerName'];
      customerAddress1 := rSetRoomsDate['customerAddress1'];
      customerAddress2 := rSetRoomsDate['customerAddress2'];
      customerZip := rSetRoomsDate['customerZip'];
      customerCity := rSetRoomsDate['customerCity'];
      customerCountryCode := rSetRoomsDate['customerCountry'];
      customerCountryName := rSetRoomsDate['customerCountryName'];

      bookingNumberOfGuest := rSetRoomsDate['GuestCount'];
      bookingNumberOfRooms := rSetRoomsDate['RoomCount'];


      Arrival := TRUNC(rSetRoomsDate.FieldByName('Arrival').AsDateTime);
      Departure := TRUNC(rSetRoomsDate.FieldByName('Departure').AsDateTime);
    end;

    function GetCorrectedEnumName(enumItem : TBookingConfirmationEmailItems) : String;
    begin
      result := GetEnumName(TypeInfo(TBookingConfirmationEmailItems), INTEGER(enumItem));
      result := copy(result, 2, maxInt);
      result := '${' + result + '}';
    end;

var cancelStr : String;

begin

  CancelStr := 'C';
  if NOT filterOutCancels then
    cancelStr := '!';
  bookingGuestsRoomsPrices := GetCorrectQuotes('<style type="text/css"> .TableResDetails { border: 1px solid black; }</style>')
      + GetCorrectQuotes('<table cellpadding="5" cellspacing="0" class="TableResDetails"><tr><td class="TableResDetails">')
      + getTranslatedText('shTemplate_Room')
      + GetCorrectQuotes('</td><td class="TableResDetails">')
      + getTranslatedText('shTemplate_Guests')
      + GetCorrectQuotes('</td><td class="TableResDetails">')
      + getTranslatedText('shTemplate_Price')
      + GetCorrectQuotes('</td></tr>');

  rSetRoomsDate := CreateNewDataSet;
  try
    s := format(
         'SELECT Reservation, RoomReservation, Arrival, Departure, NumberOfNights, AveragePrice*NumberOfNights AS TotalPrice, AveragePrice, Currency, Room, ' +
         'IF(ISNULL(RoomClass) OR RoomClass='''', RoomType, RoomClass) AS RoomClass, ' +
         'IF(ISNULL(RoomClass) OR RoomClass='''', ' +
         '(SELECT Description FROM roomtypes WHERE RoomType=xxx.RoomType), ' +
         '(SELECT Description FROM roomtypegroups WHERE Code=xxx.RoomClass)) AS RoomDescription, ' +
         'GuestName, ' +

         'GuestCount, ' +
         'RoomCount, ' +

         'GuestAddress1, ' +
         'GuestAddress2, ' +
         'GuestZip, ' +
         'GuestCity, ' +
         'GuestCountry, ' +
         'GuestCountryName, ' +

         'customerCode, ' +
         'customerName, ' +
         'customerAddress1, ' +
         'customerAddress2, ' +
         'customerZip, ' +
         'customerCity, ' +
         'customerCountry, ' +
         'customerCountryName, ' +


         'ContactName, ' +
         'Information, ' +
         'ChannelId, ' +
         'BookingId, ' +
         '(SELECT channelManagerId FROM channels WHERE Id=xxx.channelId) AS ChannelCode, ' +
         '(SELECT name FROM channels WHERE Id=xxx.channelId) AS ChannelName, ' +
         'dtCreated AS CreatedAt ' +
         'FROM ' +
         '( ' +
         'SELECT rd.Reservation, rd.RoomReservation, ' +
         'DATE((SELECT ADate FROM roomsdate rd1 WHERE rd1.RoomReservation=rd.RoomReservation AND (NOT rd1.ResFlag IN (''X'',''%s'',''N'')) ORDER BY ADate LIMIT 1)) AS Arrival, ' +
         'DATE(DATE_ADD((SELECT ADate FROM roomsdate rd1 WHERE rd1.RoomReservation=rd.RoomReservation AND (NOT rd1.ResFlag IN (''X'',''%s'',''N'')) ORDER BY ADate DESC LIMIT 1), INTERVAL 1 DAY)) AS Departure, ' +
         'COUNT(rd.ID) AS NumberOfNights, ' +
//         'SUM(RoomRate) AS TotalPrice, ' +
         '(SUM(RoomRate) + IF(r.Package != '''', ' +
         '                           (SELECT SUM(Number * Price) ' +
         '                            FROM invoicelines ' +
         '                            WHERE RoomReservation = rd.RoomReservation ' +
         '                            AND (ImportSource = r.Package AND r.Package != '''')), 0)) ' +
         '       / COUNT(rd.id) AS AveragePrice, ' +
         'rd.Currency, ' +
         'rd.Room, ' +
         'r.RoomClass, ' +
         'rd.RoomType, ' +
         '(SELECT COUNT(id) FROM persons WHERE Reservation=rd.Reservation AND (NOT ResFlag IN (''X'',''C''))) AS GuestCount, ' +
         '(SELECT COUNT(id) FROM roomreservations WHERE Reservation=rd.Reservation AND (NOT Status IN (''X'',''C''))) AS RoomCount, ' +
         '(SELECT name FROM persons WHERE RoomReservation=rd.RoomReservation AND MainName=1 LIMIT 1) AS GuestName, ' +
         '(SELECT Address1 FROM persons WHERE RoomReservation=rd.RoomReservation AND MainName=1 LIMIT 1) AS GuestAddress1, ' +
         '(SELECT Address2 FROM persons WHERE RoomReservation=rd.RoomReservation AND MainName=1 LIMIT 1) AS GuestAddress2, ' +
         '(SELECT Address3 FROM persons WHERE RoomReservation=rd.RoomReservation AND MainName=1 LIMIT 1) AS GuestZip, ' +
         '(SELECT Address4 FROM persons WHERE RoomReservation=rd.RoomReservation AND MainName=1 LIMIT 1) AS GuestCity, ' +
         '(SELECT Country FROM persons WHERE RoomReservation=rd.RoomReservation AND MainName=1 LIMIT 1) AS GuestCountry, ' +
         '(SELECT CountryName FROM countries WHERE Country=(SELECT Country FROM persons WHERE RoomReservation=rd.RoomReservation AND MainName=1 LIMIT 1) LIMIT 1) AS GuestCountryName, ' +

         '(SELECT Customer FROM reservations WHERE Reservation=rd.Reservation LIMIT 1) AS customerCode, ' +
         '(SELECT Surname FROM customers WHERE Customer=(SELECT Customer FROM reservations WHERE Reservation=rd.Reservation LIMIT 1) LIMIT 1) AS customerName, ' +
         '(SELECT Address1 FROM customers WHERE Customer=(SELECT Customer FROM reservations WHERE Reservation=rd.Reservation LIMIT 1) LIMIT 1) AS customerAddress1, ' +
         '(SELECT Address2 FROM customers WHERE Customer=(SELECT Customer FROM reservations WHERE Reservation=rd.Reservation LIMIT 1) LIMIT 1) AS customerAddress2, ' +
         '(SELECT Address3 FROM customers WHERE Customer=(SELECT Customer FROM reservations WHERE Reservation=rd.Reservation LIMIT 1) LIMIT 1) AS customerZip, ' +
         '(SELECT Address4 FROM customers WHERE Customer=(SELECT Customer FROM reservations WHERE Reservation=rd.Reservation LIMIT 1) LIMIT 1) AS customerCity, ' +
         '(SELECT Country FROM customers WHERE Customer=(SELECT Customer FROM reservations WHERE Reservation=rd.Reservation LIMIT 1) LIMIT 1) AS customerCountry, ' +
         '(SELECT CountryName FROM countries WHERE Country=(SELECT Country FROM customers WHERE Customer=(SELECT Customer FROM reservations WHERE Reservation=rd.Reservation LIMIT 1) LIMIT 1) LIMIT 1) AS customerCountryName, ' +

         '(SELECT Contactname FROM reservations WHERE Reservation=rd.Reservation) AS ContactName, ' +
         '(SELECT Information FROM reservations WHERE Reservation=rd.Reservation) AS Information, ' +
         '(SELECT InvRefrence FROM reservations WHERE Reservation=rd.Reservation) AS BookingId, ' +
         '(SELECT Channel FROM reservations WHERE Reservation=rd.Reservation) AS ChannelId, ' +
         '(SELECT dtCreated FROM reservations WHERE Reservation=rd.Reservation) AS dtCreated ' +
         'FROM roomsdate rd ' +
         '     JOIN roomreservations r ON r.RoomReservation=rd.RoomReservation ' +
         'WHERE rd.Reservation=%d ' +
         'AND (NOT rd.ResFlag IN (''X'',''%s'')) ' +
         'GROUP BY rd.RoomReservation ' +
         ') xxx', [cancelStr, cancelStr, booking, cancelStr]);
    CopyToClipboard(s);

    hData.rSet_bySQL(rSetRoomsDate, s);
    rSetRoomsDate.First;
    GetGlobals;
    totalBookingPrice := 0.00;
    while NOT rSetRoomsDate.Eof do
    begin
      bookingGuestsRoomsPrices := bookingGuestsRoomsPrices + getRoomRow(rSetRoomsDate);
      totalBookingPrice := totalBookingPrice + rSetRoomsDate['TotalPrice'];
      rSetRoomsDate.Next;
    end;
    bookingGuestsRoomsPrices := bookingGuestsRoomsPrices
        + GetCorrectQuotes('<tr><td colspan="2" style="text-align:right;" class="TableResDetails">')
        + getTranslatedText('shTemplate_Total')
        + GetCorrectQuotes('</td><td style="text-align:right;" class="TableResDetails">')
        + Trim(_floattostr(totalBookingPrice, 12, 2))
        + ' '
        + Currency
        + '</td></tr>';
    bookingGuestsRoomsPrices := bookingGuestsRoomsPrices + '</table>';

    paymentInformation := getPaymentInformation(Information);
    try

      result := ReplaceString(template, GetCorrectedEnumName(_channelId), ChannelId);
      result := ReplaceString(result, GetCorrectedEnumName(_channelName), ChannelName);
      result := ReplaceString(result, GetCorrectedEnumName(_bookingChannelId), BookingId);
      result := ReplaceString(result, GetCorrectedEnumName(_bookingRoomerId), inttostr(booking));
      result := ReplaceString(result, GetCorrectedEnumName(_bookingArrival), RoomerDateToString(Arrival));
      result := ReplaceString(result, GetCorrectedEnumName(_bookingDeparture), RoomerDateToString(Departure));
      result := ReplaceString(result, GetCorrectedEnumName(_bookingNights), InttoStr(bookingNights));
      result := ReplaceString(result, GetCorrectedEnumName(_bookingGuestName), ContactName);

      result := ReplaceString(result, GetCorrectedEnumName(_bookingNumberOfGuest), bookingNumberOfGuest);
      result := ReplaceString(result, GetCorrectedEnumName(_bookingNumberOfRooms), bookingNumberOfRooms);

      result := ReplaceString(result, GetCorrectedEnumName(_profileGuestname), GuestName);
      result := ReplaceString(result, GetCorrectedEnumName(_bookingGuestAddress1), bookingGuestAddress1);
      result := ReplaceString(result, GetCorrectedEnumName(_bookingGuestAddress2), bookingGuestAddress2);
      result := ReplaceString(result, GetCorrectedEnumName(_bookingGuestZip), bookingGuestZip);
      result := ReplaceString(result, GetCorrectedEnumName(_bookingGuestCity), bookingGuestCity);
      result := ReplaceString(result, GetCorrectedEnumName(_bookingGuestCountryCode), bookingGuestCountryCode);
      result := ReplaceString(result, GetCorrectedEnumName(_bookingGuestCountryName), bookingGuestCountryName);

      result := ReplaceString(result, GetCorrectedEnumName(_customerId), customerId);
      result := ReplaceString(result, GetCorrectedEnumName(_customerName), customerName);
      result := ReplaceString(result, GetCorrectedEnumName(_customerAddress1), customerAddress1);
      result := ReplaceString(result, GetCorrectedEnumName(_customerAddress2), customerAddress2);
      result := ReplaceString(result, GetCorrectedEnumName(_customerZip), customerZip);
      result := ReplaceString(result, GetCorrectedEnumName(_customerCity), customerCity);
      result := ReplaceString(result, GetCorrectedEnumName(_customerCountryCode), customerCountryCode);
      result := ReplaceString(result, GetCorrectedEnumName(_customerCountryName), customerCountryName);

      result := ReplaceString(result, GetCorrectedEnumName(_bookingGuestsRoomsPrices), bookingGuestsRoomsPrices);
      result := ReplaceString(result, GetCorrectedEnumName(_bookingTotalPrice), Trim(_floattostr(totalBookingPrice, 12, 2)));
      result := ReplaceString(result, GetCorrectedEnumName(_bookingDateTime), RoomerDateTimeToString(CreatedAt));
      result := ReplaceString(result, GetCorrectedEnumName(_bookingPaymentType), GetPaymentInfoFromDict(paymentInformation, _bookingPaymentType));
      result := ReplaceString(result, GetCorrectedEnumName(_bookingPaymentStatus), GetPaymentInfoFromDict(paymentInformation, _bookingPaymentStatus));
      result := ReplaceString(result, GetCorrectedEnumName(_bookingPaymentAmount), GetPaymentInfoFromDict(paymentInformation, _bookingPaymentAmount));
      result := ReplaceString(result, GetCorrectedEnumName(_bookingPaymentCreditCard), GetPaymentInfoFromDict(paymentInformation, _bookingPaymentCreditCard));
      result := ReplaceString(result, GetCorrectedEnumName(_CurrentDateTime), RoomerDateTimeToString(now));

      Subject := ReplaceString(Subject, GetCorrectedEnumName(_channelId), ChannelId);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_channelName), ChannelName);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingChannelId), BookingId);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingRoomerId), inttostr(booking));
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingArrival), RoomerDateToString(Arrival));
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingDeparture), RoomerDateToString(Departure));
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingNights), InttoStr(bookingNights));
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingGuestName), ContactName);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_profileGuestname), GuestName);

      Subject := ReplaceString(Subject, GetCorrectedEnumName(_profileGuestname), GuestName);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingGuestAddress1), bookingGuestAddress1);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingGuestAddress2), bookingGuestAddress2);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingGuestZip), bookingGuestZip);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingGuestCity), bookingGuestCity);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingGuestCountryCode), bookingGuestCountryCode);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingGuestCountryName), bookingGuestCountryName);

      Subject := ReplaceString(Subject, GetCorrectedEnumName(_customerId), customerId);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_customerName), customerName);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_customerAddress1), customerAddress1);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_customerAddress2), customerAddress2);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_customerZip), customerZip);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_customerCity), customerCity);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_customerCountryCode), customerCountryCode);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_customerCountryName), customerCountryName);

      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingNumberOfGuest), bookingNumberOfGuest);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingNumberOfRooms), bookingNumberOfRooms);

      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingGuestsRoomsPrices), bookingGuestsRoomsPrices);
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingTotalPrice), Trim(_floattostr(totalBookingPrice, 12, 2)));
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingDateTime), RoomerDateTimeToString(CreatedAt));
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingPaymentType), GetPaymentInfoFromDict(paymentInformation, _bookingPaymentType));
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingPaymentStatus), GetPaymentInfoFromDict(paymentInformation, _bookingPaymentStatus));
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingPaymentAmount), GetPaymentInfoFromDict(paymentInformation, _bookingPaymentAmount));
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_bookingPaymentCreditCard), GetPaymentInfoFromDict(paymentInformation, _bookingPaymentCreditCard));
      Subject := ReplaceString(Subject, GetCorrectedEnumName(_CurrentDateTime), RoomerDateTimeToString(now));
    finally
      paymentInformation.Free;
    end;
  finally
    FreeAndNil(rSetRoomsDate);
  end;
end;

function getRoomRow(rSetRoomsDate : TRoomerDataset) : String;
begin
  result := GetCorrectQuotes('<tr><td style="vertical-align:top;text-align:left;" class="TableResDetails">')
      + rSetRoomsDate['RoomDescription'] + '</td>'
      + GetCorrectQuotes('<td style="text-align:left;" class="TableResDetails">')
      + rSetRoomsDate['GuestName'] + '<br />'
      + '</td>'
      + GetCorrectQuotes('<td style="vertical-align:top;text-align:right;" class="TableResDetails">')
      + Trim(_floattostr(rSetRoomsDate['TotalPrice'], 12, 2)) + ' ' + rSetRoomsDate['Currency'] + '</td></tr>';
end;

function GetPaymentInfoFromDict(paymentInformation : TDictionary<TBookingConfirmationEmailItems, String>; Key : TBookingConfirmationEmailItems) : String;
begin
  if NOT paymentInformation.TryGetValue(Key, result) then
    result := '';
end;

function getPaymentInformation(information : String) : TDictionary<TBookingConfirmationEmailItems, String>;
var splittedInformation : TStrings;
    status : String;
begin
  result := TDictionary<TBookingConfirmationEmailItems, String>.Create;
  if Trim(information)<>'' then
  begin
    if (POS(CC_PAYMENT, information) > 0) then
    begin
      result.Add(
          _BookingPaymentType,
          GetTranslatedText('shTemplate_CCPayment'));

      splittedInformation := SplitStringToTStrings('|', Copy(information, POS(CC_PAYMENT, information), maxInt));
      try
        while splittedInformation.Count < 5 do splittedInformation.Add('');
        if AnsiEndsStr('SUCCEEDED', trim(splittedInformation[0])) then
        begin
          result.Add(_BookingPaymentStatus, GetTranslatedText('shTemplate_PaymentSuccess'));
        end else
        if AnsiEndsStr('FAILED', trim(splittedInformation[0])) then
        begin
          status := GetTranslatedText('shTemplate_PaymentFail');
          if (splittedInformation.Count > 4) AND
             (splittedInformation[4] <> '') then
               status := status + ' (' + Trim(splittedInformation[4]) + ')';
          result.Add(_BookingPaymentStatus, status);
        end else
        if AnsiEndsStr('FAILED DUE TO TECHNICAL PROBLEM', trim(splittedInformation[0])) then
        begin
          result.Add(_BookingPaymentStatus, GetTranslatedText('shTemplate_TechnicalFailure'));
        end else
        begin
          result.Add(_BookingPAymentStatus, '-');
        end;

        result.Add(_BookingPaymentAmount, Trim(splittedInformation[1]));
        result.Add(_BookingPaymentCreditCard, Trim(splittedInformation[3]));
      finally
        splittedInformation.Free;
      end;
    end else
    if (POS(CC_ASSURANCE, information) > 0) then
    begin
      result.Add(
          _BookingPaymentType,
          GetTranslatedText('shTemplate_Assurance'));

      splittedInformation := SplitStringToTStrings('|', Copy(information, POS(CC_PAYMENT, information), maxInt));
      try
        while splittedInformation.Count < 5 do splittedInformation.Add('');
        if AnsiEndsStr('SUCCEEDED', trim(splittedInformation[0])) then
        begin
          result.Add(_BookingPaymentStatus, GetTranslatedText('shTemplate_PaymentSuccess'));
        end else
        if AnsiEndsStr('FAILED', trim(splittedInformation[0])) then
        begin
          status := GetTranslatedText('shTemplate_PaymentFail');
          if (splittedInformation.Count > 4) AND
             (splittedInformation[4] <> '') then
               status := status + ' (' + Trim(splittedInformation[4]) + ')';
          result.Add(_BookingPaymentStatus, status);
        end else
        if AnsiEndsStr('FAILED DUE TO TECHNICAL PROBLEM', trim(splittedInformation[0])) then
        begin
          result.Add(_BookingPaymentStatus, GetTranslatedText('shTemplate_TechnicalFailure'));
        end else
        begin
          result.Add(_BookingPAymentStatus, '-');
        end;

        result.Add(_BookingPaymentAmount, Trim(splittedInformation[1]));
        result.Add(_BookingPaymentCreditCard, Trim(splittedInformation[3]));
      finally
        splittedInformation.Free;
      end;
    end else
    begin
      result.Add(_BookingPaymentType, '-');
      result.Add(_BookingPaymentStatus, '-');
      result.Add(_BookingPaymentAmount, '-');
      result.Add(_BookingPaymentCreditCard, '-');
    end;
  end else
  begin
    result.Add(_BookingPaymentType, '-');
    result.Add(_BookingPaymentStatus, '-');
    result.Add(_BookingPaymentAmount, '-');
    result.Add(_BookingPaymentCreditCard, '-');
  end;
end;

(*
	public static String fillInHotelBookingInformation(final RoomReservation booking,
			final List<RoomerRoomTypeGroup> roomTypeGroups,
			final String template, final Locale templateLocale, final MessageSource messageSource) {

		StringBuilder bookingGuestsRoomsPrices = new StringBuilder(
				'<style type="text/css"> .TableResDetails { border: 1px solid black; }</style>');
		bookingGuestsRoomsPrices
				.append('<table cellpadding="5" cellspacing="0" class="TableResDetails"><tr><td class="TableResDetails">'
						+ messageSource.getMessage('booking.rooms.table.room', null, new Locale('en', 'US'))
						+ '</td><td class="TableResDetails">'
						+ messageSource.getMessage('booking.rooms.table.guests', null, new Locale('en', 'US'))
						+ '</td><td class="TableResDetails">'
						+ messageSource.getMessage('booking.rooms.table.price', null, new Locale('en', 'US'))
						+ '</td><td class="TableResDetails">'
						+ messageSource.getMessage('booking.rooms.table.commission', null, new Locale('en', 'US'))
						+ '</td><td class="TableResDetails">'
						+ messageSource.getMessage('booking.rooms.table.services', null, new Locale('en', 'US'))
						+ '</td></tr>');

		double totalBookingPrice = 0;
		double totalCommission = 0;
		Set<String> guests = new HashSet<>();
		for (RoomerRoomStay roomStay : booking.getRooms()) {
			bookingGuestsRoomsPrices.append(getHotelRoomRow(roomStay, roomTypeGroups, messageSource));
			totalBookingPrice += roomStay.getTotalStayPrice().doubleValue();
			guests.addAll(roomStay.getRphs());
			if (roomStay.getCommission() != null) {
				totalCommission += roomStay.getCommission().doubleValue();
			}
		}
		bookingGuestsRoomsPrices.append('<tr><td colspan="2" style="text-align:right;" class="TableResDetails">'
				+ messageSource.getMessage('booking.rooms.table.total', null, new Locale('en', 'US'))
				+ '</td><td style="text-align:right;" class="TableResDetails">'
				+ String.format('%1$,.2f', totalBookingPrice)
				+ ' '
				+ booking.getRooms()[0].getCurrency()
				+ '</td><td style="text-align:right;" class="TableResDetails">'
				+ String.format('%1$,.2f', totalCommission)
				+ ' '
				+ booking.getRooms()[0].getCurrency()
				+ '</td></tr>');
		bookingGuestsRoomsPrices.append('<tr><td colspan="2" style="text-align:right;" class="TableResDetails">');
		bookingGuestsRoomsPrices.append(messageSource.getMessage('booking.rooms.table.totalguests', null, new Locale(
				'en', 'US')));
		bookingGuestsRoomsPrices.append('</td><td style="text-align:left;" colspan="3" class="TableResDetails">');
		bookingGuestsRoomsPrices.append(guests.size());
		bookingGuestsRoomsPrices.append('</td></tr>');
		if (ArrayUtils.isNotEmpty(booking.getNotes())) {
			bookingGuestsRoomsPrices.append('<tr><td colspan="2" style="text-align:right;" class="TableResDetails">');
			bookingGuestsRoomsPrices.append(messageSource.getMessage('booking.rooms.table.notes', null,
					new Locale('en', 'US')));
			bookingGuestsRoomsPrices.append('</td><td style="text-align:left;" colspan="3" class="TableResDetails">');
			for (String note : booking.getNotes()) {
				bookingGuestsRoomsPrices.append(note);
				bookingGuestsRoomsPrices.append('<br>');
			}
			bookingGuestsRoomsPrices.append('</td></tr>');
		}
		bookingGuestsRoomsPrices.append('</table>');

		Map<BookingConfirmationEmailItems, String> paymentInformation = getPaymentInformation(booking.getInformation(),
				messageSource);

		return RoomerStringUtils
				.substituteByName(
						template,
						$(BookingConfirmationEmailItems.CHANNEL_ID.getCode(),
								String.valueOf(booking.getChannel().getChannelId())),
						$(BookingConfirmationEmailItems.CHANNEL_NAME.getCode(),
								booking.getChannel().getName()),
						$(BookingConfirmationEmailItems.BOOKING_CHANNEL_ID.getCode(),
								booking.getChannelUniqueId()),
						$(BookingConfirmationEmailItems.BOOKING_ROOMER_ID.getCode(),
								String.valueOf(booking.getReservationId())),
						$(BookingConfirmationEmailItems.BOOKING_ARRIVAL.getCode(),
								DateUtils.dateToSqlString(BookingUtils.getBookingArrivalDate(booking))),
						$(BookingConfirmationEmailItems.BOOKING_DEPARTURE.getCode(),
								DateUtils.dateToSqlString(BookingUtils.getBookingDeparture(booking))),
						$(BookingConfirmationEmailItems.BOOKING_GUEST_NAME.getCode(),
								getFullGuestDetails(booking.getContact())),
						$(BookingConfirmationEmailItems.PROFILE_GUEST_NAME.getCode(),
								getFullGuestDetails(booking.getProfile().asRoomerGuest())),
						$(BookingConfirmationEmailItems.BOOKING_GUESTS_ROOMS_PRICES.getCode(),
								bookingGuestsRoomsPrices.toString()),
						$(BookingConfirmationEmailItems.BOOKING_TOTAL_PRICE.getCode(),
								String.format('%1$,.2f ', totalBookingPrice) +
										booking.getRooms()[0].getCurrency()),
						$(BookingConfirmationEmailItems.BOOKING_DATETIME.getCode(),
								DateUtils.dateToSqlString(booking.getTimeStamp())),
						$(BookingConfirmationEmailItems.BOOKING_PAYMENT_TYPE.getCode(),
								paymentInformation.get(BookingConfirmationEmailItems.BOOKING_PAYMENT_TYPE)),
						$(BookingConfirmationEmailItems.BOOKING_PAYMENT_STATUS.getCode(),
								paymentInformation.get(BookingConfirmationEmailItems.BOOKING_PAYMENT_STATUS)),
						$(BookingConfirmationEmailItems.BOOKING_PAYMENT_AMOUNT.getCode(),
								paymentInformation.get(BookingConfirmationEmailItems.BOOKING_PAYMENT_AMOUNT)),
						$(BookingConfirmationEmailItems.BOOKING_PAYMENT_CREDIT_CARD.getCode(),
								paymentInformation.get(BookingConfirmationEmailItems.BOOKING_PAYMENT_CREDIT_CARD)),
						$(BookingConfirmationEmailItems.CURRENT_DATETIME.getCode(),
								DateUtils.formatDateTime(new Date(System.currentTimeMillis()))));
	}

	private static String getFullGuestDetails(final RoomerGuest guest) {
		StringBuilder builder = new StringBuilder('');
		if (guest != null) {
			if (StringUtils.isNotBlank(guest.getTitle())) {
				builder.append(guest.getTitle());
				builder.append(' ');
			}
			builder.append(guest.getFullname());
			if (StringUtils.isNotBlank(guest.getTelephone())) {
				builder.append('<br>');
				builder.append(guest.getTelephone());
			}
			if (StringUtils.isNotBlank(guest.getEmail())) {
				builder.append('<br>');
				builder.append(guest.getEmail());
			}
			if (StringUtils.isNotBlank(guest.getAddressLine1())) {
				builder.append('<br>');
				builder.append(guest.getAddressLine1());
			}
			if (StringUtils.isNotBlank(guest.getAddressLine2())) {
				builder.append('<br>');
				builder.append(guest.getAddressLine2());
			}
			if (StringUtils.isNotBlank(guest.getPostalCode())) {
				builder.append('<br>');
				builder.append(guest.getPostalCode());
			}
			if (StringUtils.isNotBlank(guest.getCity())) {
				builder.append('<br>');
				builder.append(guest.getCity());
			}
			if (StringUtils.isNotBlank(guest.getCounty())) {
				builder.append('<br>');
				builder.append(guest.getCounty());
			}
			if (StringUtils.isNotBlank(guest.getStateProvince())) {
				builder.append('<br>');
				builder.append(guest.getStateProvince());
			}
			if (StringUtils.isNotBlank(guest.getCountryName())) {
				builder.append('<br>');
				builder.append(guest.getCountryName());
			}
		}
		return builder.toString();
	}

	private static String getHotelRoomRow(final RoomerRoomStay roomStay,
			final List<RoomerRoomTypeGroup> roomTypeGroups, final MessageSource messageSource) {
		StringBuilder result = new StringBuilder();
		result.append('<tr><td style="vertical-align:top;text-align:left;" class="TableResDetails">'
				+ getRoomTypeDescription(roomStay.getRoomRate().getRoomTypeCode(), roomTypeGroups) + '</td>');
		result.append('<td style="text-align:left;" class="TableResDetails">');
		for (RoomerGuest guest : roomStay.getGuests()) {
			result.append(guest.getFullname() + '<br />');
		}
		result.append('</td>');
		result.append('<td style="vertical-align:top;text-align:right;" class="TableResDetails">');
		for (RoomerRate rate : roomStay.getRoomRate().getRate()) {
			result.append(DATE_FORMAT.format(rate.getStartDate()));
			result.append('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
			result.append(String.format('%,.2f %s', rate.getPrice(), roomStay.getCurrency()));
			result.append('<br>');
		}
		result.append('<hr>');
		result.append(messageSource.getMessage('booking.rooms.table.total', null, new Locale('en', 'US')));
		result.append(" ");
		result.append(String.format('%1$,.2f', roomStay.getTotalStayPrice()) + ' ' + roomStay.getCurrency());
		result.append('</td><td style="vertical-align:top;text-align:right;" class="TableResDetails">');
		if (roomStay.getCommission() != null) {
			result.append(String.format('%,.2f %s', roomStay.getCommission(), roomStay.getCurrency()));
		}
		result.append('</td><td style="vertical-align:top;text-align:right;" class="TableResDetails">');
		result.append(StringUtils.join(roomStay.getNotes(), '<br>'));
		result.append('</td></tr>');
		return result.toString();
	}
*)


end.
