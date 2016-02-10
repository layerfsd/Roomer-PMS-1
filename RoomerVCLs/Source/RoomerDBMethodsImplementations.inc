function TRoomerDataSet.SystemGetDayGrid(fromDate: TDateTime; toDate: TDateTime; resType : String): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + 'pms/business/daygrid?from=' + uDateUtils.dateToSqlString(fromDate) + '&to=' + uDateUtils.dateToSqlString(toDate) + '&resType=' + resType);
  Result := res;
end;


function TRoomerDataSet.SystemGetRoomTypeStatus(fromDate: TDateTime; toDate: TDateTime): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + 'pms/business/roomtypestatus?from=' + uDateUtils.dateToSqlString(fromDate) + '&to=' + uDateUtils.dateToSqlString(toDate));
  Result := res;
end;


function TRoomerDataSet.SystemNextBookingDates(afterDate: TDateTime; ExcludedRooms: String): String;
var res : String;
begin
  res := downloadUrlAsStringUsingPost(  RoomerUri + 'pms/business/nextbookingdates', 'date=' + uDateUtils.dateToSqlString(afterDate) + '&excludedrooms=' + ExcludedRooms);
  Result := res;
end;


function TRoomerDataSet.SystemProcessRates(channelId : integer): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + 'pms/business/processrates?channelId=' + inttostr(channelId));
  Result := res;
end;


function TRoomerDataSet.SystemProcessAvailabilities(plancodeId : integer): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + 'pms/business/processavailabilities?plancodeId=' + inttostr(plancodeId));
  Result := res;
end;


function TRoomerDataSet.SystemFreeQuery(query : String; SetLastAccess : boolean = true): String;
var res, setAccess : String;
begin
  if setLastAccess then
    setAccess := 'true'
  else
    setAccess := 'false';
  res := downloadUrlAsStringUsingPost(  RoomerUri + 'pms/business/query', format('query=%s&%s', [UrlEncode(query), setAccess]), SetLastAccess);
  Result := res;
end;


function TRoomerDataSet.SystemFreeMultipleQuery(datasets : TList<TRoomerDataSet>; queries : TList<String>): String;
var res : String;
  qry : String;
  I : Integer;
  list : TStrings;
begin
  if datasets.Count <> queries.Count then
    raise Exception.Create('Number of Datasets need to be the same as number of queries!');

  qry := '';
  for I := 0 to queries.Count - 1 do
    if qry='' then
      qry := queries[I]
    else
      qry := qry + ROOMER_SPLIT + queries[I];

  res := downloadUrlAsStringUsingPost(  RoomerUri + 'pms/business/multiplequeries', 'queries=' + UrlEncode(qry));

  // 123456789012345678901234567890
  // aa[\ROOMER_SPLIT\]bb
  list := SplitStringToTStrings(ROOMER_SPLIT, res);
  for I := 0 to datasets.Count - 1 do
  begin
    if NOT Assigned(datasets[I]) then
      datasets[I] := CreateNewDataset;
    datasets[I].OpenDataset(list[I]);
  end;

  Result := res;
end;


function TRoomerDataSet.SystemFreeExecute(statement : String): String;
var res : String;
begin
  res := downloadUrlAsStringUsingPost(  RoomerUri + 'pms/business/execute', 'statement=' + UrlEncode(statement));
  Result := res;
end;

function TRoomerDataSet.SystemFreeExecuteAsync(statement : String): String;
begin
  downloadUrlAsStringUsingPostAsync(  RoomerUri + 'pms/business/execute', 'statement=' + UrlEncode(statement));
  Result := '0';
end;

function TRoomerDataSet.SystemFreeExecuteMultiple(statements : TList<String>): String;
var res : String;
  qry : String;
  I : Integer;
begin
  qry := '';
  for I := 0 to statements.Count - 1 do
    if qry='' then
      qry := statements[I]
    else
      qry := qry + '[\ROOMER-SPLIT\]' + statements[I];
  res := downloadUrlAsStringUsingPost(  RoomerUri + 'pms/business/executemultiple', 'statements=' + UrlEncode(qry));
  Result := res;
end;


function TRoomerDataSet.SystemStartTransaction(): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + 'pms/business/starttransaction');
  Result := res;
end;


function TRoomerDataSet.SystemCommitTransaction(): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + 'pms/business/commitransaction');
  Result := res;
end;


function TRoomerDataSet.SystemRollbackTransaction(): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + 'pms/business/rollbacktransaction');
  Result := res;
end;


function TRoomerDataSet.SystemStartGlobalTransaction(txId : String): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + 'pms/business/startglobaltransaction?txid=' + txId);
  Result := res;
end;


function TRoomerDataSet.SystemCommitGlobalTransaction(txId : String): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + 'pms/business/commitglobaltransaction?txid=' + txId);
  Result := res;
end;


function TRoomerDataSet.SystemRollBackGlobalTransaction(txId : String): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + 'pms/business/rollbackglobaltransaction?txid=' + txId);
  Result := res;
end;


function TRoomerDataSet.SystemGetChannelRates(channelId, channelManagerId, planCodeId : integer): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + format('pms/business/getchannelratesfornext400days?channelId=%d&channelManagerId=%d&planCodeId=%d&includeMaster=%s', [channelId,channelManagerId,planCodeId,'true']));
  Result := res;
end;


function TRoomerDataSet.SystemGetChannelRatesMultiple(fromDate : TDateTime; numDays : Integer; channels : String; channelManagerId, planCodeId : integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + format('pms/business/getchannelratesformultiplechannels2340?numDays=%d&fromDate=%s&channels=%s&channelManagerId=%d&planCodeId=%d&includeMaster=%s', [numDays, uDateUtils.dateToSqlString(fromDate), channels,channelManagerId,planCodeId,'true']));
end;

function TRoomerDataSet.SystemGetChannelRates1812(fromDate : TDateTime; numDays : Integer; channel, channelManagerId, planCodeId : integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + format('pms/business/getchannelrates1812?numDays=%d&fromDate=%s&channel=%d&channelManagerId=%d&planCodeId=%d&includeMaster=%s', [numDays, uDateUtils.dateToSqlString(fromDate), channel,channelManagerId,planCodeId,'true']));
end;

function TRoomerDataSet.SystemGetAvailabilities(fromDate : TDateTime; numDays : Integer; channelManagerId, planCodeId : integer): String;
var res : String;
begin
  res := downloadUrlAsString(  RoomerUri + format('pms/business/getavailabilitiesfornextxdays2340?numDays=%d&fromDate=%s&channelManagerId=%d&planCodeId=%d',
          [numDays, uDateUtils.dateToSqlString(fromDate), channelManagerId, planCodeId]));
  Result := res;
end;


function TRoomerDataSet.SystemBuildRoomStatus(ADate : TDateTime; NumDays : integer): String;
var res : String;
      sDate : String;
begin
    sDate := uDateUtils.dateToSqlString(ADate); 
  res := downloadUrlAsString(  RoomerUri + format('pms/business/buildroomstates?startdate=%s&numdays=%d', [sDate,NumDays]));
  Result := res;
end;


function TRoomerDataSet.SystemGetAvailability(channelCode, channelManagerCode : String; Arrival, Departure : TDateTime): String;
begin
    raise Exception.Create('Under construction'); 
end;


function TRoomerDataSet.SystemCreateReservation(channelCode, channelManagerCode, data : String): String;
begin
    raise Exception.Create('Under construction'); 
end;


function TRoomerDataSet.SystemRemoveReservation(reservation : Integer; transaction : Boolean = True; makeCopy : Boolean = true; reason : String = ''; request : String = ''; information : String = ''; cancelType : Integer = 0): String;
begin
  Result := downloadUrlAsStringUsingPost(  format(RoomerUri + 'resapi/booking/remove/reservation2/%d', [reservation]),
              format('transactional=%s&reason=%s&request=%s&information=%s&canceltype=%d&makecopy=%s', [BoolToString(transaction), reason, request, information, cancelType,BoolToString(makeCopy)]));
end;


function TRoomerDataSet.SystemRemoveRoomReservation(roomReservation : Integer; transaction : Boolean = True; makeCopy : Boolean = true; reason : String = ''; request : String = ''; information : String = ''; cancelType : Integer = 0): String;
begin
  Result := downloadUrlAsStringUsingPost(  format(RoomerUri + 'resapi/booking/remove/roomreservation2/%d', [roomReservation]),
         format('transactional=%s&reason=%s&request=%s&information=%s&canceltype=%d&makecopy=%s', [BoolToString(transaction), reason, request, information, cancelType,BoolToString(makeCopy)]));
end;


function TRoomerDataSet.SystemCancelReservation(reservation : Integer; reason : String = ''): String;
begin
  Result := downloadUrlAsStringUsingPost(  format(RoomerUri + 'resapi/booking/cancel/reservation/%d', [reservation]),
              format('reason=%s', [reason]));
end;


function TRoomerDataSet.SystemCancelRoomReservation(roomReservation : Integer; reason : String = ''): String;
begin
  Result := downloadUrlAsStringUsingPost(  format(RoomerUri + 'roomresapi/room/cancel/roomreservation/%d', [roomReservation]),
         format('reason=%s', [reason]));
end;


function TRoomerDataSet.SystemCorrectDoorCodeSettings(roomReservation : Integer): String;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'roomresapi/room/doorcodecorrection/%d', [roomReservation]));
end;


function TRoomerDataSet.SystemAddToDoorCodeSchedules(reservation : Integer): String;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'resapi/booking/addtodoorcodeschedules/%d', [reservation]));
end;


function TRoomerDataSet.SystemIsRoomWithdrawalAllowed(roomReservation : Integer; amount : Double): Boolean;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'roomresapi/room/WithdrawalAllowed/%d?amount=%s', [roomReservation,FloatToDBString(amount)])) = '1';
end;


function TRoomerDataSet.SystemCopyReservation(reservation : Integer; toDate : TDateTime): String;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'resapi/booking/copy/%d?arrival=%s', [reservation,uDateUtils.dateToSqlString(toDate)]));
end;


function TRoomerDataSet.SystemCopyReservationFromHotel(hotelId : String; reservation : Integer; toDate : TDateTime): String;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'resapi/booking/copyfromhotel?sourcehotel=%s&id=%d&arrival=%s', [hotelId,reservation,uDateUtils.dateToSqlString(toDate)]));
end;


function TRoomerDataSet.SystemSetRoomStatusOfReservation(reservation : Integer; toStatus : String): String;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'resapi/booking/status/%d?status=%s', [reservation,toStatus]));
end;


function TRoomerDataSet.SystemMakeAvailabilityDirtyFromRoomReservation(roomReservation : Integer; info : String): String;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'resapi/booking/dirty/roomreservation/%d?extraInfo=%s', [roomReservation, info]));
end;


function TRoomerDataSet.SystemMakeAvailabilityDirtyFromReservation(reservation : Integer; info : String): String;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'resapi/booking/dirty/reservation/%d?extraInfo=%s', [reservation, info]));
end;


function TRoomerDataSet.SystemGetLanguages(): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'system/languages');
end;


function TRoomerDataSet.SystemGetDictionary(id : Integer): String;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'system/dictionary?id=%d', [id]));
end;


function TRoomerDataSet.SystemCorrectRoomClasses(channelId : Integer; roomClasses : String): String;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'pms/channels/correctroomclasses?channelid=%d&roomclasses=%s', [channelId, roomClasses]));
end;


function TRoomerDataSet.SystemChangeAvailability(roomType : String; fromDate, toDate : TDateTime; subtract : Boolean; info : String): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'resapi/booking/changeavailability?extraInfo=' + info, format('roomtype=%s&fromdate=%s&todate=%s&subtract=%s', [roomtype, uDateUtils.dateToSqlString(fromDate), uDateUtils.dateToSqlString(toDate), BoolToString(subtract)]));
end;


function TRoomerDataSet.SystemChangeAvailabilityForRoom(RoomReservation : Integer; subtract : Boolean): String;
var s : String;
begin
  if subtract then s:='true' else s:='false';
  Result := downloadUrlAsString(  RoomerUri + format('roomresapi/room/changeavailabilityforroom?id=%d&reduce=%s', [RoomReservation, s]));
end;


function TRoomerDataSet.SystemMoveRoom(roomReservationId : Integer; newRoom : String): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'roomresapi/room/moveperpost', format('id=%d&room=%s', [roomReservationId, newRoom]));
end;


function TRoomerDataSet.SystemSetRoomStatus(roomReservationId : Integer; newStatus : String): String;
begin
  Result := downloadUrlAsString(  format(RoomerUri + 'roomresapi/room/status?id=%d&status=%s', [roomReservationId, newStatus]));
end;


function TRoomerDataSet.SystemNewReservationId(): Integer;
begin
  Result := strtoint(downloadUrlAsString(  RoomerUri + 'resapi/newreservationid'));
end;


function TRoomerDataSet.SystemNewRoomReservationId(): Integer;
begin
  Result := strtoint(downloadUrlAsString(  RoomerUri + 'resapi/newroomreservationid'));
end;


function TRoomerDataSet.SystemMultipleNewRoomReservationIds(numIds : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'resapi/newroomreservationids/' + inttostr(numIds));
end;


function TRoomerDataSet.SystemNewPersonId(): Integer;
begin
  Result := strtoint(downloadUrlAsString(  RoomerUri + 'resapi/newpersonid'));
end;


function TRoomerDataSet.SystemMultipleNewPersonIds(numIds : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'resapi/newpersonids/' + inttostr(numIds));
end;


function TRoomerDataSet.SystemNewInvoiceNumber(): Integer;
begin
  Result := strtoint(downloadUrlAsString(  RoomerUri + 'resapi/newInvoiceNumber'));
end;


function TRoomerDataSet.SystemMultipleNewInvoiceNumbers(numNumbers : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'resapi/newInvoiceNumbers/' + inttostr(numNumbers));
end;


function TRoomerDataSet.SystemCheckAccountPayBookKeyExists(PayBookKeyValue : String): Boolean;
begin
  Result := downloadUrlAsString(  RoomerUri + 'financekeys/paymenttypeexists/' + PayBookKeyValue) = '1';
end;


function TRoomerDataSet.SystemCheckAccountItemExists(AccountKeyValue : String): Boolean;
begin
  Result := downloadUrlAsString(  RoomerUri + 'financekeys/productexists/' + AccountKeyValue) = '1';
end;


function TRoomerDataSet.SystemCheckAccountCustomerExists(pIdValue : String): Boolean;
begin
  Result := downloadUrlAsString(  RoomerUri + 'financekeys/customerexists/' + pIdValue) = '1';
end;


function TRoomerDataSet.SystemSendInvoiceToBookkeeping(invoiceNumber : Integer): String;
begin
  Result := downloadUrlAsStringUsingPut( RoomerUri + 'financekeys/' + inttostr(invoiceNumber), '', false);
end;


function TRoomerDataSet.SystemSetChannelAvailability(date, roomClass : String; dirty, availability, setAvailability, channelManagerId, planCodeId: Integer; info : String): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'resapi/booking/availability/set?extraInfo=' + info,    format('date=%s&roomClass=%s&dirty=%d&availability=%d&setAvailability=%d&channelManagerId=%d&planCodeId=%d', [date, roomClass, dirty, availability, setAvailability, channelManagerId, planCodeId]));
end;


function TRoomerDataSet.SystemSetMultipleChannelAvailability(date, roomClass : TList<String>; dirty, availability, setAvailability, channelManagerId, planCodeId: TList<Integer>; info : String): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'resapi/booking/availability/setMultiple?extraInfo=' + info,      format('date=%s&roomClass=%s&dirty=%s&availability=%s&setAvailability=%s&channelManagerId=%s&planCodeId=%s', [StringListAsCdl(date), StringListAsCdl(roomClass), IntegerListAsCdl(dirty), IntegerListAsCdl(availability), IntegerListAsCdl(setAvailability), IntegerListAsCdl(channelManagerId), IntegerListAsCdl(planCodeId)]));
end;


function TRoomerDataSet.SystemSetMultipleChannelAvailabilityPerId(id, dirty, availability, setAvailability: TList<Integer>; force : Boolean; info : String): String;
var s : String;
begin
  if force then s := 'true' else s := 'false';
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'resapi/booking/availability/setMultiplePerId?extraInfo=' + info, format('id=%s&dirty=%s&availability=%s&setAvailability=%s&force=%s', [IntegerListAsCdl(id), IntegerListAsCdl(dirty), IntegerListAsCdl(availability), IntegerListAsCdl(setAvailability), s]));
end;


function TRoomerDataSet.SystemGuestVipTypesAdd(Code, Description : String; VipGrade : Integer): Integer;
begin
  Result := StrToInt(downloadUrlAsStringUsingPost(  RoomerUri + 'guestprofilebase/viptypes/add', format('code=%s&description=%s&vipGrade=%d', [Code, Description, VipGrade])));
end;


function TRoomerDataSet.SystemGuestVipTypesUpdate(Id: Integer; Code, Description : String; VipGrade : Integer): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'guestprofilebase/viptypes/update/' + inttostr(Id), format('code=%s&description=%s&vipGrade=%d', [Code, Description, VipGrade]));
end;


function TRoomerDataSet.SystemGuestVipTypesAll(): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guestprofilebase/viptypes/list');
end;


function TRoomerDataSet.SystemGuestVipType(Id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guestprofilebase/viptypes/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestVipTypesDelete(Id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guestprofilebase/viptypes/delete/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestContactTypesAdd(Code, Description : String; SystemType : Integer): Integer;
begin
  Result := StrToInt(downloadUrlAsStringUsingPost(  RoomerUri + 'guestprofilebase/ContactTypes/add', format('code=%s&description=%s&sysType=%d', [Code, Description, SystemType])));
end;


function TRoomerDataSet.SystemGuestContactTypesUpdate(Id: Integer; Code, Description : String; SystemType : Integer): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'guestprofilebase/ContactTypes/update/' + inttostr(Id), format('code=%s&description=%s&sysType=%d', [Code, Description, SystemType]));
end;


function TRoomerDataSet.SystemGuestContactTypesAll(): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guestprofilebase/ContactTypes/list');
end;


function TRoomerDataSet.SystemGuestContactType(Id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guestprofilebase/ContactTypes/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestContactTypesDelete(Id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guestprofilebase/ContactTypes/delete/' + inttostr(id));
end;


function TRoomerDataSet.SystemConstantsPersonContactTypes(): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'system_types/person_contact_types');
end;


function TRoomerDataSet.SystemConstantsGenderTypes(): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'system_types/person_gender_types');
end;


function TRoomerDataSet.SystemConstantsPersonAddressTypes(): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'system_types/person_address_types');
end;


function TRoomerDataSet.SystemConstantsPersonVisitorTypes(): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'system_types/person_visit_types');
end;


function TRoomerDataSet.SystemGuestProfilesList(Filter : String): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'guest/list', format('filter=%s', [Filter]));
end;


function TRoomerDataSet.SystemGuestProfilesEntry(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guest/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestProfilesEntryAdd(active : Integer;
firstName : String;
middleName : String;
lastName : String;
fullName : String;
saluation : String;
gender : Integer;
profession : String;
role : String;
birthday : String;
nationality : Integer;
language : Integer;
passportNumber : String;
personDescription : String;
personNotes : String;
spouseName : String;
children : String;
familyNotes : String;

vipType : Integer;
vipNotification : Integer;
daysBefore : Integer;
hoursBefore : Integer;
minutesBefore : Integer;
guestType : Integer;
industry : Integer;
companyName : String;
department : String;
customer : Integer;

prefRoom : String;
prefLocation : Integer;
prefFloor : Integer;

mailingList : Integer;

itemsNotification : Integer;

notes : String;
notesNotification : Integer;

currency : String;
payType : Integer;
cardNumber : String;
nameOnCard : String;
cardExpireMonth : Integer;
cardExpireYear : Integer;
cvc : String;
billToCustomer : String
): Integer;
begin
  Result := StrToInt(downloadUrlAsStringUsingPost(  RoomerUri + 'guest/add', format('active=%d&firstName=%s&'+'middleName=%s&'+'lastName=%s&'+'fullName=%s&'+'saluation=%s&'+'gender=%d&'+'profession=%s&'+'role=%s&'+'birthday=%s&'+'nationality=%d&'+'language=%d&'+'passportNumber=%s&'+'personDescription=%s&'+'personNotes=%s&'+'spouseName=%s&'+'children=%s&'+'familyNotes=%s&'+'vipType=%d&'+'vipNotification=%d&'+'daysBefore=%d&'+'hoursBefore=%d&'+'minutesBefore=%d&'+'guestType=%d&'+'industry=%d&'+'companyName=%s&'+'department=%s&'+'customer=%d&'+'prefRoom=%s&'+'prefLocation=%d&'+'prefFloor=%d&'+'mailingList=%d&'+'itemsNotification=%d&'+'notes=%s&'+'notesNotification=%d&'+'currency=%s&'+'payType=%d&'+'cardNumber=%s&'+'nameOnCard=%s&'+'cardExpireMonth=%d&'+'cardExpireYear=%d&'+'cvc=%s&+billToCustomer=%s', [active,
firstName,
middleName,
lastName,
fullName,
saluation,
gender,
profession,
role,
birthday,
nationality,
language,
passportNumber,
personDescription,
personNotes,
spouseName,
children,
familyNotes,

vipType,
vipNotification,
daysBefore,
hoursBefore,
minutesBefore,
guestType,
industry,
companyName,
department,
customer,

prefRoom,
prefLocation,
prefFloor,

mailingList,

itemsNotification,

notes,
notesNotification,

currency,
payType,
cardNumber,
nameOnCard,
cardExpireMonth,
cardExpireYear,
cvc,
billToCustomer])));
end;


function TRoomerDataSet.SystemGuestProfilesEntryUpdate(id : Integer;
 active : Integer;
firstName : String;
middleName : String;
lastName : String;
fullName : String;
saluation : String;
gender : Integer;
profession : String;
role : String;
birthday : String;
nationality : Integer;
language : Integer;
passportNumber : String;
personDescription : String;
personNotes : String;
spouseName : String;
children : String;
familyNotes : String;

vipType : Integer;
vipNotification : Integer;
daysBefore : Integer;
hoursBefore : Integer;
minutesBefore : Integer;
guestType : Integer;
industry : Integer;
companyName : String;
department : String;
customer : Integer;

prefRoom : String;
prefLocation : Integer;
prefFloor : Integer;

mailingList : Integer;

itemsNotification : Integer;

notes : String;
notesNotification : Integer;

currency : String;
payType : Integer;
cardNumber : String;
nameOnCard : String;
cardExpireMonth : Integer;
cardExpireYear : Integer;
cvc : String;
billToCustomer : String
): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'guest/add', format('id=%d&active=%d&firstName=%s&'+'middleName=%s&'+'lastName=%s&'+'fullName=%s&'+'saluation=%s&'+'gender=%d&'+'profession=%s&'+'role=%s&'+'birthday=%s&'+'nationality=%d&'+'language=%d&'+'passportNumber=%s&'+'personDescription=%s&'+'personNotes=%s&'+'spouseName=%s&'+'children=%s&'+'familyNotes=%s&'+'vipType=%d&'+'vipNotification=%d&'+'daysBefore=%d&'+'hoursBefore=%d&'+'minutesBefore=%d&'+'guestType=%d&'+'industry=%d&'+'companyName=%s&'+'department=%s&'+'customer=%d&'+'prefRoom=%s&'+'prefLocation=%d&'+'prefFloor=%d&'+'mailingList=%d&'+'itemsNotification=%d&'+'notes=%s&'+'notesNotification=%d&'+'currency=%s&'+'payType=%d&'+'cardNumber=%s&'+'nameOnCard=%s&'+'cardExpireMonth=%d&'+'cardExpireYear=%d&'+'cvc=%s&+billToCustomer=%s', [id,active,
firstName,
middleName,
lastName,
fullName,
saluation,
gender,
profession,
role,
birthday,
nationality,
language,
passportNumber,
personDescription,
personNotes,
spouseName,
children,
familyNotes,

vipType,
vipNotification,
daysBefore,
hoursBefore,
minutesBefore,
guestType,
industry,
companyName,
department,
customer,

prefRoom,
prefLocation,
prefFloor,

mailingList,

itemsNotification,

notes,
notesNotification,

currency,
payType,
cardNumber,
nameOnCard,
cardExpireMonth,
cardExpireYear,
cvc,
billToCustomer]));
end;


function TRoomerDataSet.SystemGuestProfilesChildren(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guest/children/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestProfilesChildDelete(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guest/children/delete/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestProfilesChildAdd(personId : Integer; name : String; childPersonId : Integer = 0): Integer;
begin
  Result := StrToInt(downloadUrlAsStringUsingPost(  RoomerUri + 'guest/children/add', format('personId=%d&name=%s&childPersonId=%d', [personId,name,childPersonId])));
end;


function TRoomerDataSet.SystemGuestProfilesChildUpdate(id : Integer; personId : Integer; name : String; childPersonId : Integer = 0): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'guest/children/update/' + inttostr(id), format('personId=%d&name=%s&childPersonId=%d', [personId,name,childPersonId]));
end;


function TRoomerDataSet.SystemGuestProfilesContacts(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guest/contacts/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestProfilesContactDelete(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guest/contacts/delete/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestProfilesContactAdd(personId, contactTypeId : Integer; description, contactInfo, extraInfo : String): Integer;
begin
  Result := StrToInt(downloadUrlAsStringUsingPost(  RoomerUri + 'guest/contacts/add', format('personId=%d&contactTypeId=%s&description=%s&contactInfo=%s&extraInfo=%s', [personId,contactTypeId,description,contactInfo,extraInfo])));
end;


function TRoomerDataSet.SystemGuestProfilesContactUpdate(id, personId, contactTypeId : Integer; description, contactInfo, extraInfo : String): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'guest/contacts/update/' + inttostr(id), format('personId=%d&contactTypeId=%s&description=%s&contactInfo=%s&extraInfo=%s', [personId,contactTypeId,description,contactInfo,extraInfo]));
end;


function TRoomerDataSet.SystemGuestProfilesAddresses(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guest/addresses/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestProfilesAddressDelete(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guest/addresses/delete/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestProfilesAddressAdd(personId, systemType : Integer; address1, address2, city, zip, state : String; countryId : Integer): Integer;
begin
  Result := StrToInt(downloadUrlAsStringUsingPost(  RoomerUri + 'guest/addresses/add', format('personId=%d&systemType=%d&address1=%s&address2=%s&city=%s%zip=%s&state=%s&countryId=%d', [personId,systemType,address1,address2,city,zip,state,countryId])));
end;


function TRoomerDataSet.SystemGuestProfilesAddressUpdate(id, personId, systemType : Integer; address1, address2, city, zip, state : String; countryId : Integer): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'guest/addresses/update/' + inttostr(id), format('personId=%d&systemType=%d&address1=%s&address2=%s&city=%s%zip=%s&state=%s&countryId=%d', [personId,systemType,address1,address2,city,zip,state,countryId]));
end;


function TRoomerDataSet.SystemGuestProfilesItems(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guest/items/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestProfilesItemDelete(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'guest/items/delete/' + inttostr(id));
end;


function TRoomerDataSet.SystemGuestProfilesItemAdd(personId, itemId, numItems : Integer; notes : String; price : Double): Integer;
begin
  Result := StrToInt(downloadUrlAsStringUsingPost(  RoomerUri + 'guest/items/add', format('personId=%d&itemId=%d&numItems=%d&notes=%s&price=%s', [personId,itemId,numItems,notes,FloatToDBString(price)])));
end;


function TRoomerDataSet.SystemGuestProfilesItemUpdate(id, personId, itemId, numItems : Integer; notes : String; price : Double): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'guest/items/update/' + inttostr(id), format('personId=%d&itemId=%d&numItems=%d&notes=%s&price=%s', [personId,itemId,numItems,notes,FloatToDBString(price)]));
end;


function TRoomerDataSet.SystemFinanceListCustomers(): String;
begin
  Result := Utf8ToString(downloadUrlAsString(  RoomerUri + 'financekeys/customers'));
end;


function TRoomerDataSet.SystemFinanceListProducts(): String;
begin
  Result := Utf8ToString(downloadUrlAsString(  RoomerUri + 'financekeys/products'));
end;


function TRoomerDataSet.SystemFinanceListPaymentTypes(): String;
begin
  Result := Utf8ToString(downloadUrlAsString(  RoomerUri + 'financekeys/paymenttypes'));
end;


function TRoomerDataSet.SystemcheckRuleConflict(id : Integer;
active : Integer;
description : String;
selectedRoomTypes : String;
occupancyLimit : Double;
whichDaysIndex : Integer;
selectedDays : String;
selectedMonths : String;
selectedYears : String;
selectedChannelsIDs : String): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'revenue/splitcheck', format('id=%d&active=%d&description=%s&selectedRoomTypes=%s&occupancyLimit=%s&whichDaysIndex=%d&selectedDays=%s&selectedMonths=%s&selectedYears=%s&selectedChannelsIDs=%s&', 
[id,active,description,selectedRoomTypes,FloatToDBString(occupancyLimit),whichDaysIndex,selectedDays,selectedMonths,selectedYears,selectedChannelsIDs]));
end;


function TRoomerDataSet.SystemSaveSplittedToggleRule(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'revenue/savesplit?id=' + inttostr(id));
end;


function TRoomerDataSet.SystemDeleteToggleRule(id : Integer): String;
begin
  Result := downloadUrlAsString(  RoomerUri + 'revenue/deleterule?id=' + inttostr(id));
end;


    function TRoomerDataSet.SystemListTogglingRules(onlyActive : Boolean): Array_Of_TChanneltogglingrulesEntity;
var entities : Array_Of_TChanneltogglingrulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
      temp : String;
begin
  temp := 'false';
  if onlyActive then
    temp := 'true';
  res := downloadUrlAsString(  RoomerUri + 'revenue/listtogglingrules?onlyActive=' + temp);
  list := processJson(res, 'TChanneltogglingrulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChanneltogglingrulesEntity(list[i]);
  result := entities;
end;


function TRoomerDataSet.SystemChangeRoomNumber(oldNumber, newNumber : String): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'roomsandroomtypes/room/changeNumber', format('old=%s&new=%s', [oldNumber,newNumber]));
end;


function TRoomerDataSet.SystemChangeRoomType(oldType, newType : String): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'roomsandroomtypes/roomtype/changeType', format('old=%s&new=%s', [oldType,newType]));
end;


function TRoomerDataSet.SystemChangeRoomTypeForRoom(room, oldType, newType : String): String;
begin
  Result := downloadUrlAsStringUsingPost(  RoomerUri + 'roomsandroomtypes/room/changeRoomType', format('room=%s&old=%s&new=%s', [room,oldType,newType]));
end;


function TRoomerDataSet.SystemTaxesList(): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'taxes/list');
end;


function TRoomerDataSet.SystemTaxesUnlinkItem(taxId : Integer; item : String): String;
begin
  Result := downloadUrlAsString(RoomerUri + format('taxes/unlinkItem?taxId=%d&item=%s',[taxId,item]));
end;


function TRoomerDataSet.SystemTaxesUnlinkItemId(taxId : Integer; itemId : Integer): String;
begin
  Result := downloadUrlAsString(RoomerUri + format('taxes/unlinkItemId?taxId=%d&itemId=%d',[taxId,itemId]));
end;


function TRoomerDataSet.SystemTaxesLinkItem(taxId : Integer; item : String): String;
begin
  Result := downloadUrlAsString(RoomerUri + format('taxes/linkItem?taxId=%d&item=%s',[taxId,item]));
end;


function TRoomerDataSet.SystemTaxesLinkItemId(taxId : Integer; itemId : Integer): String;
begin
  Result := downloadUrlAsString(RoomerUri + format('taxes/linkItemId?taxId=%d&itemId=%d',[taxId,itemId]));
end;


function TRoomerDataSet.SystemTaxesPerItem(item : String): String;
begin
  Result := downloadUrlAsString(RoomerUri + format('taxes/taxesPerItem?item=%s',[item]));
end;


function TRoomerDataSet.SystemTaxesTaxesAndItems(item : String): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'taxes/itemsAndTaxes');
end;


function TRoomerDataSet.SystemGetStaticResources(): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'resources');
end;


function TRoomerDataSet.SystemGetStaticResourcesFiltered(filter : String): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'resources/filter/' + filter);
end;


function TRoomerDataSet.SystemDeleteStaticResource(id : Integer): String;
begin
  Result := DeleteAsString(activeRoomerDataSet.roomerClient, RoomerUri + 'resources/' + inttostr(id));
end;


function TRoomerDataSet.SystemAddStaticResource(keyString, originalName, uri, access : String): String;
begin
  Result := downloadUrlAsStringUsingPost(RoomerUri + 'resources', 
              format('keyString=%s&originalName=%s&uri=%s&access=%s', [keyString, originalName, uri, access]));
end;


function TRoomerDataSet.SystemUpdateStaticResource(id : Integer; keyString, originalName, uri, access : String): String;
begin
  Result := downloadUrlAsStringUsingPut(RoomerUri + 'resources/' + inttostr(id), 
              format('keyString=%s&originalName=%s&uri=%s&access=%s', [keyString, originalName, uri, access]));
end;


function TRoomerDataSet.SystemGetPaymentAssuranceMatrix(channelManagerCode : String): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'pms/channels/paymentAssuranceMatrix?' + 
              format('channelManagerCode=%s', [channelManagerCode]));
end;

function TRoomerDataSet.SystemUpdatePaymentAssuranceMatrixItem(channelManagerCode, channelCode, roomTypeCode : String; value : Integer): String;
begin
  Result := downloadUrlAsStringUsingPost(RoomerUri + 'pms/channels/paymentAssuranceMatrix?', 
              format('channelManagerCode=%s&channelCode=%s&roomTypeCode=%s&value=%d', [channelManagerCode, channelCode, roomTypeCode, value]));
end;


function TRoomerDataSet.SystemGetConfirmationEmailMatrix(): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'pms/channels/confirmationEmailMatrix');
end;

function TRoomerDataSet.SystemUpdateConfirmationEmailMatrix(channelManagerCode, channelCode : String; value : Integer): String;
begin
  Result := downloadUrlAsStringUsingPost(RoomerUri + 'pms/channels/confirmationEmailMatrix?', 
              format('channelManagerCode=%s&channelCode=%s&value=%d', [channelManagerCode, channelCode, value]));
end;


function TRoomerDataSet.SystemGetHotelEmailMatrix(): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'pms/channels/hotelEmailMatrix');
end;

function TRoomerDataSet.SystemUpdateHotelEmailMatrix(channelManagerCode, channelCode : String; value : Integer): String;
begin
  Result := downloadUrlAsStringUsingPost(RoomerUri + 'pms/channels/hotelEmailMatrix?', 
              format('channelManagerCode=%s&channelCode=%s&value=%d', [channelManagerCode, channelCode, value]));
end;


function TRoomerDataSet.SystempackagesList(packageCode : String; currency : String = ''): String;
begin
  Result := downloadUrlAsStringUsingPost(RoomerUri + 'roompackages/list', 
              format('hotelId=%s&packageCode=%s&currency=%s', [activeRoomerDataSet.hotelId, packageCode, currency]));
end;


function TRoomerDataSet.SystempackagesRemove(packageCode : String; roomReservation, roomReservationAlias : Integer; restorePrice : Boolean = False; splitNumber : Integer = 0; invoiceNumber : Integer = -1): String;
var strRestore : String;begin
  if restorePrice then strRestore := 'true' else strRestore := 'false';
  Result := downloadUrlAsStringUsingPost(RoomerUri + 'roompackages/remove', 
              format('hotelId=%s&packageCode=%s&roomReservation=%d&roomReservationAlias=%d&splitNumber=%d&invoiceNumber=%d&restorePrice=%s', [activeRoomerDataSet.hotelId, packageCode, roomReservation, roomReservationAlias, splitNumber, invoiceNumber, strRestore]));
end;


function TRoomerDataSet.SystempackagesAdd(packageCode : String; roomReservation, roomReservationAlias : Integer; rate : Double = 0; currency : String = ''; splitNumber : Integer = 0; invoiceNumber : Integer = -1): String;
var sRate : String;
begin
  if Rate > 0 then
    sRate := ''
  else
    sRate := '_';
  Result := downloadUrlAsStringUsingPost(RoomerUri + 'roompackages/add',
              format('hotelId=%s&packageCode=%s&roomReservation=%d&roomReservationAlias=%d&splitNumber=%d&invoiceNumber=%d&%srate=%s&currency=%s', [activeRoomerDataSet.hotelId, packageCode, roomReservation, roomReservationAlias, splitNumber, invoiceNumber, sRate, FloatToDBString(rate), currency]));
end;


function TRoomerDataSet.SystempackagesRecalcInvoice(roomReservation, roomReservationAlias : Integer; splitNumber : Integer = 0; invoiceNumber : Integer = -1): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'roompackages/recalcinvoice?' + 
              format('hotelId=%s&roomReservation=%d&roomReservationAlias=%d&splitNumber=%d&invoiceNumber=%d', [activeRoomerDataSet.hotelId, roomReservation, roomReservationAlias, splitNumber, invoiceNumber]));
end;


function TRoomerDataSet.SystempackagesRecalcInvoiceHeader(roomReservation, roomReservationAlias : Integer; splitNumber : Integer = 0; invoiceNumber : Integer = -1): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'roompackages/recalcinvoiceheader?' + 
              format('hotelId=%s&roomReservation=%d&roomReservationAlias=%d&splitNumber=%d&invoiceNumber=%d', [activeRoomerDataSet.hotelId, roomReservation, roomReservationAlias, splitNumber, invoiceNumber]));
end;


function TRoomerDataSet.SystempackagesCreateHeaderIfNotExists(roomReservation, roomReservationAlias : Integer; splitNumber : Integer = 0; invoiceNumber : Integer = -1): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'roompackages/createheaderifnotexists?' + 
              format('hotelId=%s&roomReservation=%d&roomReservationAlias=%d&splitNumber=%d&invoiceNumber=%d', [activeRoomerDataSet.hotelId, roomReservation, roomReservationAlias, splitNumber, invoiceNumber]));
end;


function TRoomerDataSet.SystemListReservations(fromDate, toDate : TDateTime): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'resapi/reservations?' + 
              format('fromDate=%s&toDate=%d', [uDateUtils.dateToSqlString(fromDate), uDateUtils.dateToSqlString(toDate)]));
end;


function TRoomerDataSet.SystemListInvoicesOfReservations(fromDate, toDate : TDateTime): String;
begin
  Result := downloadUrlAsString(RoomerUri + 'resapi/invoices?' + 
              format('fromDate=%s&toDate=%d', [uDateUtils.dateToSqlString(fromDate), uDateUtils.dateToSqlString(toDate)]));
end;


// ******************************* Cancellationdetails **********************************

function TRoomerDataSet.Cancellationdetails_Entities_FindAll(): Array_Of_TCancellationdetailsEntity;
var entities : Array_Of_TCancellationdetailsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'cancellationdetails/findAll');
  list := processJson(res, 'TCancellationdetailsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCancellationdetailsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Cancellationdetails_Entities_GetById(id: Integer): TCancellationdetailsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'cancellationdetails/' + inttostr(id));
  list := processJson(res, 'TCancellationdetailsEntity');
  result := TCancellationdetailsEntity(list[0]);
  
end;

function TRoomerDataSet.Cancellationdetails_Entities_GetBySql(sql: String): Array_Of_TCancellationdetailsEntity;
var entities : Array_Of_TCancellationdetailsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'cancellationdetails/getSql?sql=' + sql);
  list := processJson(res, 'TCancellationdetailsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCancellationdetailsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Cancellationdetails_Entities_GetListByWhere(where: String): Array_Of_TCancellationdetailsEntity;
var entities : Array_Of_TCancellationdetailsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'cancellationdetails/getListByWhere?where=' + where);
  list := processJson(res, 'TCancellationdetailsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCancellationdetailsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Cancellationdetails_Entities_GetEntityByWhere(where: String): TCancellationdetailsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'cancellationdetails/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TCancellationdetailsEntity');
  result := TCancellationdetailsEntity(list[0]);
  
end;

function TRoomerDataSet.Cancellationdetails_Entities_SaveEntity(entity: TCancellationdetailsEntity): TCancellationdetailsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'cancellationdetails'), entity.json);
  result := TCancellationdetailsEntity(processJson(src, 'TCancellationdetailsEntity')[0]);
  
end;

function TRoomerDataSet.Cancellationdetails_Entities_UpdateEntity(entity: TCancellationdetailsEntity): TCancellationdetailsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'cancellationdetails/' + inttostr(entity.Id)), entity.json);
  result := TCancellationdetailsEntity(processJson(src, 'TCancellationdetailsEntity')[0]);
  
end;

procedure TRoomerDataSet.Cancellationdetails_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'cancellationdetails/' + inttostr(id)));
  
end;

function TRoomerDataSet.Cancellationdetails_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'cancellationdetails');
end;

function TRoomerDataSet.Cancellationdetails_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'cancellationdetails/' + inttostr(id));
end;

function TRoomerDataSet.Cancellationdetails_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'cancellationdetails/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Cancellationdetails_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'cancellationdetails/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Cancellationdetails_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'cancellationdetails/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Cancellationdetails_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'cancellationdetails/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Cancellationdetails_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'cancellationdetails/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Cancellationdetails_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'cancellationdetails/execute', 'sql=' + sql);
end;


// ******************************* Channelclassrelations **********************************

function TRoomerDataSet.Channelclassrelations_Entities_FindAll(): Array_Of_TChannelclassrelationsEntity;
var entities : Array_Of_TChannelclassrelationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelclassrelations/findAll');
  list := processJson(res, 'TChannelclassrelationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelclassrelationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelclassrelations_Entities_GetById(id: Integer): TChannelclassrelationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelclassrelations/' + inttostr(id));
  list := processJson(res, 'TChannelclassrelationsEntity');
  result := TChannelclassrelationsEntity(list[0]);
  
end;

function TRoomerDataSet.Channelclassrelations_Entities_GetBySql(sql: String): Array_Of_TChannelclassrelationsEntity;
var entities : Array_Of_TChannelclassrelationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelclassrelations/getSql?sql=' + sql);
  list := processJson(res, 'TChannelclassrelationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelclassrelationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelclassrelations_Entities_GetListByWhere(where: String): Array_Of_TChannelclassrelationsEntity;
var entities : Array_Of_TChannelclassrelationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelclassrelations/getListByWhere?where=' + where);
  list := processJson(res, 'TChannelclassrelationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelclassrelationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelclassrelations_Entities_GetEntityByWhere(where: String): TChannelclassrelationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelclassrelations/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TChannelclassrelationsEntity');
  result := TChannelclassrelationsEntity(list[0]);
  
end;

function TRoomerDataSet.Channelclassrelations_Entities_SaveEntity(entity: TChannelclassrelationsEntity): TChannelclassrelationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channelclassrelations'), entity.json);
  result := TChannelclassrelationsEntity(processJson(src, 'TChannelclassrelationsEntity')[0]);
  
end;

function TRoomerDataSet.Channelclassrelations_Entities_UpdateEntity(entity: TChannelclassrelationsEntity): TChannelclassrelationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channelclassrelations/' + inttostr(entity.Id)), entity.json);
  result := TChannelclassrelationsEntity(processJson(src, 'TChannelclassrelationsEntity')[0]);
  
end;

procedure TRoomerDataSet.Channelclassrelations_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'channelclassrelations/' + inttostr(id)));
  
end;

function TRoomerDataSet.Channelclassrelations_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelclassrelations');
end;

function TRoomerDataSet.Channelclassrelations_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelclassrelations/' + inttostr(id));
end;

function TRoomerDataSet.Channelclassrelations_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'channelclassrelations/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Channelclassrelations_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channelclassrelations/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Channelclassrelations_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelclassrelations/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Channelclassrelations_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelclassrelations/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Channelclassrelations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelclassrelations/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Channelclassrelations_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channelclassrelations/execute', 'sql=' + sql);
end;


// ******************************* Channelmanagers **********************************

function TRoomerDataSet.Channelmanagers_Entities_FindAll(): Array_Of_TChannelmanagersEntity;
var entities : Array_Of_TChannelmanagersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelmanagers/findAll');
  list := processJson(res, 'TChannelmanagersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelmanagersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelmanagers_Entities_GetById(id: Integer): TChannelmanagersEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelmanagers/' + inttostr(id));
  list := processJson(res, 'TChannelmanagersEntity');
  result := TChannelmanagersEntity(list[0]);
  
end;

function TRoomerDataSet.Channelmanagers_Entities_GetBySql(sql: String): Array_Of_TChannelmanagersEntity;
var entities : Array_Of_TChannelmanagersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelmanagers/getSql?sql=' + sql);
  list := processJson(res, 'TChannelmanagersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelmanagersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelmanagers_Entities_GetListByWhere(where: String): Array_Of_TChannelmanagersEntity;
var entities : Array_Of_TChannelmanagersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelmanagers/getListByWhere?where=' + where);
  list := processJson(res, 'TChannelmanagersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelmanagersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelmanagers_Entities_GetEntityByWhere(where: String): TChannelmanagersEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelmanagers/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TChannelmanagersEntity');
  result := TChannelmanagersEntity(list[0]);
  
end;

function TRoomerDataSet.Channelmanagers_Entities_SaveEntity(entity: TChannelmanagersEntity): TChannelmanagersEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channelmanagers'), entity.json);
  result := TChannelmanagersEntity(processJson(src, 'TChannelmanagersEntity')[0]);
  
end;

function TRoomerDataSet.Channelmanagers_Entities_UpdateEntity(entity: TChannelmanagersEntity): TChannelmanagersEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channelmanagers/' + inttostr(entity.Id)), entity.json);
  result := TChannelmanagersEntity(processJson(src, 'TChannelmanagersEntity')[0]);
  
end;

procedure TRoomerDataSet.Channelmanagers_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'channelmanagers/' + inttostr(id)));
  
end;

function TRoomerDataSet.Channelmanagers_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelmanagers');
end;

function TRoomerDataSet.Channelmanagers_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelmanagers/' + inttostr(id));
end;

function TRoomerDataSet.Channelmanagers_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'channelmanagers/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Channelmanagers_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channelmanagers/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Channelmanagers_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelmanagers/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Channelmanagers_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelmanagers/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Channelmanagers_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelmanagers/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Channelmanagers_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channelmanagers/execute', 'sql=' + sql);
end;


// ******************************* Channelplancodes **********************************

function TRoomerDataSet.Channelplancodes_Entities_FindAll(): Array_Of_TChannelplancodesEntity;
var entities : Array_Of_TChannelplancodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelplancodes/findAll');
  list := processJson(res, 'TChannelplancodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelplancodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelplancodes_Entities_GetById(id: Integer): TChannelplancodesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelplancodes/' + inttostr(id));
  list := processJson(res, 'TChannelplancodesEntity');
  result := TChannelplancodesEntity(list[0]);
  
end;

function TRoomerDataSet.Channelplancodes_Entities_GetBySql(sql: String): Array_Of_TChannelplancodesEntity;
var entities : Array_Of_TChannelplancodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelplancodes/getSql?sql=' + sql);
  list := processJson(res, 'TChannelplancodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelplancodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelplancodes_Entities_GetListByWhere(where: String): Array_Of_TChannelplancodesEntity;
var entities : Array_Of_TChannelplancodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelplancodes/getListByWhere?where=' + where);
  list := processJson(res, 'TChannelplancodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelplancodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelplancodes_Entities_GetEntityByWhere(where: String): TChannelplancodesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelplancodes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TChannelplancodesEntity');
  result := TChannelplancodesEntity(list[0]);
  
end;

function TRoomerDataSet.Channelplancodes_Entities_SaveEntity(entity: TChannelplancodesEntity): TChannelplancodesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channelplancodes'), entity.json);
  result := TChannelplancodesEntity(processJson(src, 'TChannelplancodesEntity')[0]);
  
end;

function TRoomerDataSet.Channelplancodes_Entities_UpdateEntity(entity: TChannelplancodesEntity): TChannelplancodesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channelplancodes/' + inttostr(entity.Id)), entity.json);
  result := TChannelplancodesEntity(processJson(src, 'TChannelplancodesEntity')[0]);
  
end;

procedure TRoomerDataSet.Channelplancodes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'channelplancodes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Channelplancodes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelplancodes');
end;

function TRoomerDataSet.Channelplancodes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelplancodes/' + inttostr(id));
end;

function TRoomerDataSet.Channelplancodes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'channelplancodes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Channelplancodes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channelplancodes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Channelplancodes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelplancodes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Channelplancodes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelplancodes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Channelplancodes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelplancodes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Channelplancodes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channelplancodes/execute', 'sql=' + sql);
end;


// ******************************* Channelrates **********************************

function TRoomerDataSet.Channelrates_Entities_FindAll(): Array_Of_TChannelratesEntity;
var entities : Array_Of_TChannelratesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelrates/findAll');
  list := processJson(res, 'TChannelratesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelratesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelrates_Entities_GetById(id: Integer): TChannelratesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelrates/' + inttostr(id));
  list := processJson(res, 'TChannelratesEntity');
  result := TChannelratesEntity(list[0]);
  
end;

function TRoomerDataSet.Channelrates_Entities_GetBySql(sql: String): Array_Of_TChannelratesEntity;
var entities : Array_Of_TChannelratesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelrates/getSql?sql=' + sql);
  list := processJson(res, 'TChannelratesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelratesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelrates_Entities_GetListByWhere(where: String): Array_Of_TChannelratesEntity;
var entities : Array_Of_TChannelratesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelrates/getListByWhere?where=' + where);
  list := processJson(res, 'TChannelratesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelratesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelrates_Entities_GetEntityByWhere(where: String): TChannelratesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelrates/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TChannelratesEntity');
  result := TChannelratesEntity(list[0]);
  
end;

function TRoomerDataSet.Channelrates_Entities_SaveEntity(entity: TChannelratesEntity): TChannelratesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channelrates'), entity.json);
  result := TChannelratesEntity(processJson(src, 'TChannelratesEntity')[0]);
  
end;

function TRoomerDataSet.Channelrates_Entities_UpdateEntity(entity: TChannelratesEntity): TChannelratesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channelrates/' + inttostr(entity.Id)), entity.json);
  result := TChannelratesEntity(processJson(src, 'TChannelratesEntity')[0]);
  
end;

procedure TRoomerDataSet.Channelrates_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'channelrates/' + inttostr(id)));
  
end;

function TRoomerDataSet.Channelrates_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelrates');
end;

function TRoomerDataSet.Channelrates_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelrates/' + inttostr(id));
end;

function TRoomerDataSet.Channelrates_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'channelrates/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Channelrates_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channelrates/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Channelrates_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelrates/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Channelrates_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelrates/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Channelrates_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelrates/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Channelrates_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channelrates/execute', 'sql=' + sql);
end;


// ******************************* Channelratesavailabilities **********************************

function TRoomerDataSet.Channelratesavailabilities_Entities_FindAll(): Array_Of_TChannelratesavailabilitiesEntity;
var entities : Array_Of_TChannelratesavailabilitiesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelratesavailabilities/findAll');
  list := processJson(res, 'TChannelratesavailabilitiesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelratesavailabilitiesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelratesavailabilities_Entities_GetById(id: Integer): TChannelratesavailabilitiesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelratesavailabilities/' + inttostr(id));
  list := processJson(res, 'TChannelratesavailabilitiesEntity');
  result := TChannelratesavailabilitiesEntity(list[0]);
  
end;

function TRoomerDataSet.Channelratesavailabilities_Entities_GetBySql(sql: String): Array_Of_TChannelratesavailabilitiesEntity;
var entities : Array_Of_TChannelratesavailabilitiesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelratesavailabilities/getSql?sql=' + sql);
  list := processJson(res, 'TChannelratesavailabilitiesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelratesavailabilitiesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelratesavailabilities_Entities_GetListByWhere(where: String): Array_Of_TChannelratesavailabilitiesEntity;
var entities : Array_Of_TChannelratesavailabilitiesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelratesavailabilities/getListByWhere?where=' + where);
  list := processJson(res, 'TChannelratesavailabilitiesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelratesavailabilitiesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channelratesavailabilities_Entities_GetEntityByWhere(where: String): TChannelratesavailabilitiesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channelratesavailabilities/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TChannelratesavailabilitiesEntity');
  result := TChannelratesavailabilitiesEntity(list[0]);
  
end;

function TRoomerDataSet.Channelratesavailabilities_Entities_SaveEntity(entity: TChannelratesavailabilitiesEntity): TChannelratesavailabilitiesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channelratesavailabilities'), entity.json);
  result := TChannelratesavailabilitiesEntity(processJson(src, 'TChannelratesavailabilitiesEntity')[0]);
  
end;

function TRoomerDataSet.Channelratesavailabilities_Entities_UpdateEntity(entity: TChannelratesavailabilitiesEntity): TChannelratesavailabilitiesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channelratesavailabilities/' + inttostr(entity.Id)), entity.json);
  result := TChannelratesavailabilitiesEntity(processJson(src, 'TChannelratesavailabilitiesEntity')[0]);
  
end;

procedure TRoomerDataSet.Channelratesavailabilities_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'channelratesavailabilities/' + inttostr(id)));
  
end;

function TRoomerDataSet.Channelratesavailabilities_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelratesavailabilities');
end;

function TRoomerDataSet.Channelratesavailabilities_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelratesavailabilities/' + inttostr(id));
end;

function TRoomerDataSet.Channelratesavailabilities_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'channelratesavailabilities/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Channelratesavailabilities_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channelratesavailabilities/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Channelratesavailabilities_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelratesavailabilities/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Channelratesavailabilities_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelratesavailabilities/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Channelratesavailabilities_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channelratesavailabilities/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Channelratesavailabilities_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channelratesavailabilities/execute', 'sql=' + sql);
end;


// ******************************* Channels **********************************

function TRoomerDataSet.Channels_Entities_FindAll(): Array_Of_TChannelsEntity;
var entities : Array_Of_TChannelsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channels/findAll');
  list := processJson(res, 'TChannelsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channels_Entities_GetById(id: Integer): TChannelsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channels/' + inttostr(id));
  list := processJson(res, 'TChannelsEntity');
  result := TChannelsEntity(list[0]);
  
end;

function TRoomerDataSet.Channels_Entities_GetBySql(sql: String): Array_Of_TChannelsEntity;
var entities : Array_Of_TChannelsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channels/getSql?sql=' + sql);
  list := processJson(res, 'TChannelsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channels_Entities_GetListByWhere(where: String): Array_Of_TChannelsEntity;
var entities : Array_Of_TChannelsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channels/getListByWhere?where=' + where);
  list := processJson(res, 'TChannelsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChannelsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channels_Entities_GetEntityByWhere(where: String): TChannelsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channels/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TChannelsEntity');
  result := TChannelsEntity(list[0]);
  
end;

function TRoomerDataSet.Channels_Entities_SaveEntity(entity: TChannelsEntity): TChannelsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channels'), entity.json);
  result := TChannelsEntity(processJson(src, 'TChannelsEntity')[0]);
  
end;

function TRoomerDataSet.Channels_Entities_UpdateEntity(entity: TChannelsEntity): TChannelsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channels/' + inttostr(entity.Id)), entity.json);
  result := TChannelsEntity(processJson(src, 'TChannelsEntity')[0]);
  
end;

procedure TRoomerDataSet.Channels_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'channels/' + inttostr(id)));
  
end;

function TRoomerDataSet.Channels_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channels');
end;

function TRoomerDataSet.Channels_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channels/' + inttostr(id));
end;

function TRoomerDataSet.Channels_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'channels/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Channels_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channels/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Channels_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channels/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Channels_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channels/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Channels_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channels/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Channels_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channels/execute', 'sql=' + sql);
end;


// ******************************* Channeltogglingrules **********************************

function TRoomerDataSet.Channeltogglingrules_Entities_FindAll(): Array_Of_TChanneltogglingrulesEntity;
var entities : Array_Of_TChanneltogglingrulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channeltogglingrules/findAll');
  list := processJson(res, 'TChanneltogglingrulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChanneltogglingrulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channeltogglingrules_Entities_GetById(id: Integer): TChanneltogglingrulesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channeltogglingrules/' + inttostr(id));
  list := processJson(res, 'TChanneltogglingrulesEntity');
  result := TChanneltogglingrulesEntity(list[0]);
  
end;

function TRoomerDataSet.Channeltogglingrules_Entities_GetBySql(sql: String): Array_Of_TChanneltogglingrulesEntity;
var entities : Array_Of_TChanneltogglingrulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channeltogglingrules/getSql?sql=' + sql);
  list := processJson(res, 'TChanneltogglingrulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChanneltogglingrulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channeltogglingrules_Entities_GetListByWhere(where: String): Array_Of_TChanneltogglingrulesEntity;
var entities : Array_Of_TChanneltogglingrulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channeltogglingrules/getListByWhere?where=' + where);
  list := processJson(res, 'TChanneltogglingrulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChanneltogglingrulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channeltogglingrules_Entities_GetEntityByWhere(where: String): TChanneltogglingrulesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channeltogglingrules/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TChanneltogglingrulesEntity');
  result := TChanneltogglingrulesEntity(list[0]);
  
end;

function TRoomerDataSet.Channeltogglingrules_Entities_SaveEntity(entity: TChanneltogglingrulesEntity): TChanneltogglingrulesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channeltogglingrules'), entity.json);
  result := TChanneltogglingrulesEntity(processJson(src, 'TChanneltogglingrulesEntity')[0]);
  
end;

function TRoomerDataSet.Channeltogglingrules_Entities_UpdateEntity(entity: TChanneltogglingrulesEntity): TChanneltogglingrulesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channeltogglingrules/' + inttostr(entity.Id)), entity.json);
  result := TChanneltogglingrulesEntity(processJson(src, 'TChanneltogglingrulesEntity')[0]);
  
end;

procedure TRoomerDataSet.Channeltogglingrules_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'channeltogglingrules/' + inttostr(id)));
  
end;

function TRoomerDataSet.Channeltogglingrules_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channeltogglingrules');
end;

function TRoomerDataSet.Channeltogglingrules_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channeltogglingrules/' + inttostr(id));
end;

function TRoomerDataSet.Channeltogglingrules_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'channeltogglingrules/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Channeltogglingrules_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channeltogglingrules/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Channeltogglingrules_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channeltogglingrules/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Channeltogglingrules_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channeltogglingrules/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Channeltogglingrules_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channeltogglingrules/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Channeltogglingrules_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channeltogglingrules/execute', 'sql=' + sql);
end;


// ******************************* Channeltogglingrulessplit **********************************

function TRoomerDataSet.Channeltogglingrulessplit_Entities_FindAll(): Array_Of_TChanneltogglingrulessplitEntity;
var entities : Array_Of_TChanneltogglingrulessplitEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channeltogglingrulessplit/findAll');
  list := processJson(res, 'TChanneltogglingrulessplitEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChanneltogglingrulessplitEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channeltogglingrulessplit_Entities_GetById(id: Integer): TChanneltogglingrulessplitEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channeltogglingrulessplit/' + inttostr(id));
  list := processJson(res, 'TChanneltogglingrulessplitEntity');
  result := TChanneltogglingrulessplitEntity(list[0]);
  
end;

function TRoomerDataSet.Channeltogglingrulessplit_Entities_GetBySql(sql: String): Array_Of_TChanneltogglingrulessplitEntity;
var entities : Array_Of_TChanneltogglingrulessplitEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channeltogglingrulessplit/getSql?sql=' + sql);
  list := processJson(res, 'TChanneltogglingrulessplitEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChanneltogglingrulessplitEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channeltogglingrulessplit_Entities_GetListByWhere(where: String): Array_Of_TChanneltogglingrulessplitEntity;
var entities : Array_Of_TChanneltogglingrulessplitEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channeltogglingrulessplit/getListByWhere?where=' + where);
  list := processJson(res, 'TChanneltogglingrulessplitEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TChanneltogglingrulessplitEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Channeltogglingrulessplit_Entities_GetEntityByWhere(where: String): TChanneltogglingrulessplitEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'channeltogglingrulessplit/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TChanneltogglingrulessplitEntity');
  result := TChanneltogglingrulessplitEntity(list[0]);
  
end;

function TRoomerDataSet.Channeltogglingrulessplit_Entities_SaveEntity(entity: TChanneltogglingrulessplitEntity): TChanneltogglingrulessplitEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channeltogglingrulessplit'), entity.json);
  result := TChanneltogglingrulessplitEntity(processJson(src, 'TChanneltogglingrulessplitEntity')[0]);
  
end;

function TRoomerDataSet.Channeltogglingrulessplit_Entities_UpdateEntity(entity: TChanneltogglingrulessplitEntity): TChanneltogglingrulessplitEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'channeltogglingrulessplit/' + inttostr(entity.Id)), entity.json);
  result := TChanneltogglingrulessplitEntity(processJson(src, 'TChanneltogglingrulessplitEntity')[0]);
  
end;

procedure TRoomerDataSet.Channeltogglingrulessplit_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'channeltogglingrulessplit/' + inttostr(id)));
  
end;

function TRoomerDataSet.Channeltogglingrulessplit_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channeltogglingrulessplit');
end;

function TRoomerDataSet.Channeltogglingrulessplit_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channeltogglingrulessplit/' + inttostr(id));
end;

function TRoomerDataSet.Channeltogglingrulessplit_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'channeltogglingrulessplit/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Channeltogglingrulessplit_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channeltogglingrulessplit/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Channeltogglingrulessplit_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channeltogglingrulessplit/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Channeltogglingrulessplit_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channeltogglingrulessplit/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Channeltogglingrulessplit_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'channeltogglingrulessplit/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Channeltogglingrulessplit_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'channeltogglingrulessplit/execute', 'sql=' + sql);
end;


// ******************************* Colors **********************************

function TRoomerDataSet.Colors_Entities_FindAll(): Array_Of_TColorsEntity;
var entities : Array_Of_TColorsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'colors/findAll');
  list := processJson(res, 'TColorsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TColorsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Colors_Entities_GetById(id: Integer): TColorsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'colors/' + inttostr(id));
  list := processJson(res, 'TColorsEntity');
  result := TColorsEntity(list[0]);
  
end;

function TRoomerDataSet.Colors_Entities_GetBySql(sql: String): Array_Of_TColorsEntity;
var entities : Array_Of_TColorsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'colors/getSql?sql=' + sql);
  list := processJson(res, 'TColorsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TColorsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Colors_Entities_GetListByWhere(where: String): Array_Of_TColorsEntity;
var entities : Array_Of_TColorsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'colors/getListByWhere?where=' + where);
  list := processJson(res, 'TColorsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TColorsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Colors_Entities_GetEntityByWhere(where: String): TColorsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'colors/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TColorsEntity');
  result := TColorsEntity(list[0]);
  
end;

function TRoomerDataSet.Colors_Entities_SaveEntity(entity: TColorsEntity): TColorsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'colors'), entity.json);
  result := TColorsEntity(processJson(src, 'TColorsEntity')[0]);
  
end;

function TRoomerDataSet.Colors_Entities_UpdateEntity(entity: TColorsEntity): TColorsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'colors/' + inttostr(entity.Id)), entity.json);
  result := TColorsEntity(processJson(src, 'TColorsEntity')[0]);
  
end;

procedure TRoomerDataSet.Colors_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'colors/' + inttostr(id)));
  
end;

function TRoomerDataSet.Colors_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'colors');
end;

function TRoomerDataSet.Colors_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'colors/' + inttostr(id));
end;

function TRoomerDataSet.Colors_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'colors/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Colors_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'colors/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Colors_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'colors/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Colors_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'colors/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Colors_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'colors/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Colors_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'colors/execute', 'sql=' + sql);
end;


// ******************************* Control **********************************

function TRoomerDataSet.Control_Entities_FindAll(): Array_Of_TControlEntity;
var entities : Array_Of_TControlEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'control/findAll');
  list := processJson(res, 'TControlEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TControlEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Control_Entities_GetById(id: Integer): TControlEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'control/' + inttostr(id));
  list := processJson(res, 'TControlEntity');
  result := TControlEntity(list[0]);
  
end;

function TRoomerDataSet.Control_Entities_GetBySql(sql: String): Array_Of_TControlEntity;
var entities : Array_Of_TControlEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'control/getSql?sql=' + sql);
  list := processJson(res, 'TControlEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TControlEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Control_Entities_GetListByWhere(where: String): Array_Of_TControlEntity;
var entities : Array_Of_TControlEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'control/getListByWhere?where=' + where);
  list := processJson(res, 'TControlEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TControlEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Control_Entities_GetEntityByWhere(where: String): TControlEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'control/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TControlEntity');
  result := TControlEntity(list[0]);
  
end;

function TRoomerDataSet.Control_Entities_SaveEntity(entity: TControlEntity): TControlEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'control'), entity.json);
  result := TControlEntity(processJson(src, 'TControlEntity')[0]);
  
end;

function TRoomerDataSet.Control_Entities_UpdateEntity(entity: TControlEntity): TControlEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'control/' + inttostr(entity.Id)), entity.json);
  result := TControlEntity(processJson(src, 'TControlEntity')[0]);
  
end;

procedure TRoomerDataSet.Control_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'control/' + inttostr(id)));
  
end;

function TRoomerDataSet.Control_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'control');
end;

function TRoomerDataSet.Control_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'control/' + inttostr(id));
end;

function TRoomerDataSet.Control_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'control/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Control_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'control/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Control_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'control/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Control_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'control/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Control_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'control/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Control_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'control/execute', 'sql=' + sql);
end;


// ******************************* Countries **********************************

function TRoomerDataSet.Countries_Entities_FindAll(): Array_Of_TCountriesEntity;
var entities : Array_Of_TCountriesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'countries/findAll');
  list := processJson(res, 'TCountriesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCountriesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Countries_Entities_GetById(id: Integer): TCountriesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'countries/' + inttostr(id));
  list := processJson(res, 'TCountriesEntity');
  result := TCountriesEntity(list[0]);
  
end;

function TRoomerDataSet.Countries_Entities_GetBySql(sql: String): Array_Of_TCountriesEntity;
var entities : Array_Of_TCountriesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'countries/getSql?sql=' + sql);
  list := processJson(res, 'TCountriesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCountriesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Countries_Entities_GetListByWhere(where: String): Array_Of_TCountriesEntity;
var entities : Array_Of_TCountriesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'countries/getListByWhere?where=' + where);
  list := processJson(res, 'TCountriesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCountriesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Countries_Entities_GetEntityByWhere(where: String): TCountriesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'countries/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TCountriesEntity');
  result := TCountriesEntity(list[0]);
  
end;

function TRoomerDataSet.Countries_Entities_SaveEntity(entity: TCountriesEntity): TCountriesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'countries'), entity.json);
  result := TCountriesEntity(processJson(src, 'TCountriesEntity')[0]);
  
end;

function TRoomerDataSet.Countries_Entities_UpdateEntity(entity: TCountriesEntity): TCountriesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'countries/' + inttostr(entity.Id)), entity.json);
  result := TCountriesEntity(processJson(src, 'TCountriesEntity')[0]);
  
end;

procedure TRoomerDataSet.Countries_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'countries/' + inttostr(id)));
  
end;

function TRoomerDataSet.Countries_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'countries');
end;

function TRoomerDataSet.Countries_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'countries/' + inttostr(id));
end;

function TRoomerDataSet.Countries_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'countries/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Countries_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'countries/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Countries_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'countries/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Countries_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'countries/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Countries_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'countries/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Countries_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'countries/execute', 'sql=' + sql);
end;


// ******************************* Countrygroups **********************************

function TRoomerDataSet.Countrygroups_Entities_FindAll(): Array_Of_TCountrygroupsEntity;
var entities : Array_Of_TCountrygroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'countrygroups/findAll');
  list := processJson(res, 'TCountrygroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCountrygroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Countrygroups_Entities_GetById(id: Integer): TCountrygroupsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'countrygroups/' + inttostr(id));
  list := processJson(res, 'TCountrygroupsEntity');
  result := TCountrygroupsEntity(list[0]);
  
end;

function TRoomerDataSet.Countrygroups_Entities_GetBySql(sql: String): Array_Of_TCountrygroupsEntity;
var entities : Array_Of_TCountrygroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'countrygroups/getSql?sql=' + sql);
  list := processJson(res, 'TCountrygroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCountrygroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Countrygroups_Entities_GetListByWhere(where: String): Array_Of_TCountrygroupsEntity;
var entities : Array_Of_TCountrygroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'countrygroups/getListByWhere?where=' + where);
  list := processJson(res, 'TCountrygroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCountrygroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Countrygroups_Entities_GetEntityByWhere(where: String): TCountrygroupsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'countrygroups/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TCountrygroupsEntity');
  result := TCountrygroupsEntity(list[0]);
  
end;

function TRoomerDataSet.Countrygroups_Entities_SaveEntity(entity: TCountrygroupsEntity): TCountrygroupsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'countrygroups'), entity.json);
  result := TCountrygroupsEntity(processJson(src, 'TCountrygroupsEntity')[0]);
  
end;

function TRoomerDataSet.Countrygroups_Entities_UpdateEntity(entity: TCountrygroupsEntity): TCountrygroupsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'countrygroups/' + inttostr(entity.Id)), entity.json);
  result := TCountrygroupsEntity(processJson(src, 'TCountrygroupsEntity')[0]);
  
end;

procedure TRoomerDataSet.Countrygroups_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'countrygroups/' + inttostr(id)));
  
end;

function TRoomerDataSet.Countrygroups_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'countrygroups');
end;

function TRoomerDataSet.Countrygroups_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'countrygroups/' + inttostr(id));
end;

function TRoomerDataSet.Countrygroups_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'countrygroups/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Countrygroups_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'countrygroups/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Countrygroups_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'countrygroups/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Countrygroups_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'countrygroups/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Countrygroups_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'countrygroups/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Countrygroups_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'countrygroups/execute', 'sql=' + sql);
end;


// ******************************* Currencies **********************************

function TRoomerDataSet.Currencies_Entities_FindAll(): Array_Of_TCurrenciesEntity;
var entities : Array_Of_TCurrenciesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'currencies/findAll');
  list := processJson(res, 'TCurrenciesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCurrenciesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Currencies_Entities_GetById(id: Integer): TCurrenciesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'currencies/' + inttostr(id));
  list := processJson(res, 'TCurrenciesEntity');
  result := TCurrenciesEntity(list[0]);
  
end;

function TRoomerDataSet.Currencies_Entities_GetBySql(sql: String): Array_Of_TCurrenciesEntity;
var entities : Array_Of_TCurrenciesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'currencies/getSql?sql=' + sql);
  list := processJson(res, 'TCurrenciesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCurrenciesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Currencies_Entities_GetListByWhere(where: String): Array_Of_TCurrenciesEntity;
var entities : Array_Of_TCurrenciesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'currencies/getListByWhere?where=' + where);
  list := processJson(res, 'TCurrenciesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCurrenciesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Currencies_Entities_GetEntityByWhere(where: String): TCurrenciesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'currencies/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TCurrenciesEntity');
  result := TCurrenciesEntity(list[0]);
  
end;

function TRoomerDataSet.Currencies_Entities_SaveEntity(entity: TCurrenciesEntity): TCurrenciesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'currencies'), entity.json);
  result := TCurrenciesEntity(processJson(src, 'TCurrenciesEntity')[0]);
  
end;

function TRoomerDataSet.Currencies_Entities_UpdateEntity(entity: TCurrenciesEntity): TCurrenciesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'currencies/' + inttostr(entity.Id)), entity.json);
  result := TCurrenciesEntity(processJson(src, 'TCurrenciesEntity')[0]);
  
end;

procedure TRoomerDataSet.Currencies_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'currencies/' + inttostr(id)));
  
end;

function TRoomerDataSet.Currencies_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'currencies');
end;

function TRoomerDataSet.Currencies_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'currencies/' + inttostr(id));
end;

function TRoomerDataSet.Currencies_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'currencies/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Currencies_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'currencies/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Currencies_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'currencies/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Currencies_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'currencies/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Currencies_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'currencies/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Currencies_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'currencies/execute', 'sql=' + sql);
end;


// ******************************* Customerpreferences **********************************

function TRoomerDataSet.Customerpreferences_Entities_FindAll(): Array_Of_TCustomerpreferencesEntity;
var entities : Array_Of_TCustomerpreferencesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customerpreferences/findAll');
  list := processJson(res, 'TCustomerpreferencesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCustomerpreferencesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Customerpreferences_Entities_GetById(id: Integer): TCustomerpreferencesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customerpreferences/' + inttostr(id));
  list := processJson(res, 'TCustomerpreferencesEntity');
  result := TCustomerpreferencesEntity(list[0]);
  
end;

function TRoomerDataSet.Customerpreferences_Entities_GetBySql(sql: String): Array_Of_TCustomerpreferencesEntity;
var entities : Array_Of_TCustomerpreferencesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customerpreferences/getSql?sql=' + sql);
  list := processJson(res, 'TCustomerpreferencesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCustomerpreferencesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Customerpreferences_Entities_GetListByWhere(where: String): Array_Of_TCustomerpreferencesEntity;
var entities : Array_Of_TCustomerpreferencesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customerpreferences/getListByWhere?where=' + where);
  list := processJson(res, 'TCustomerpreferencesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCustomerpreferencesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Customerpreferences_Entities_GetEntityByWhere(where: String): TCustomerpreferencesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customerpreferences/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TCustomerpreferencesEntity');
  result := TCustomerpreferencesEntity(list[0]);
  
end;

function TRoomerDataSet.Customerpreferences_Entities_SaveEntity(entity: TCustomerpreferencesEntity): TCustomerpreferencesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'customerpreferences'), entity.json);
  result := TCustomerpreferencesEntity(processJson(src, 'TCustomerpreferencesEntity')[0]);
  
end;

function TRoomerDataSet.Customerpreferences_Entities_UpdateEntity(entity: TCustomerpreferencesEntity): TCustomerpreferencesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'customerpreferences/' + inttostr(entity.Id)), entity.json);
  result := TCustomerpreferencesEntity(processJson(src, 'TCustomerpreferencesEntity')[0]);
  
end;

procedure TRoomerDataSet.Customerpreferences_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'customerpreferences/' + inttostr(id)));
  
end;

function TRoomerDataSet.Customerpreferences_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customerpreferences');
end;

function TRoomerDataSet.Customerpreferences_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customerpreferences/' + inttostr(id));
end;

function TRoomerDataSet.Customerpreferences_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'customerpreferences/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Customerpreferences_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'customerpreferences/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Customerpreferences_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customerpreferences/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Customerpreferences_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customerpreferences/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Customerpreferences_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customerpreferences/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Customerpreferences_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'customerpreferences/execute', 'sql=' + sql);
end;


// ******************************* Customers **********************************

function TRoomerDataSet.Customers_Entities_FindAll(): Array_Of_TCustomersEntity;
var entities : Array_Of_TCustomersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customers/findAll');
  list := processJson(res, 'TCustomersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCustomersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Customers_Entities_GetById(id: Integer): TCustomersEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customers/' + inttostr(id));
  list := processJson(res, 'TCustomersEntity');
  result := TCustomersEntity(list[0]);
  
end;

function TRoomerDataSet.Customers_Entities_GetBySql(sql: String): Array_Of_TCustomersEntity;
var entities : Array_Of_TCustomersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customers/getSql?sql=' + sql);
  list := processJson(res, 'TCustomersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCustomersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Customers_Entities_GetListByWhere(where: String): Array_Of_TCustomersEntity;
var entities : Array_Of_TCustomersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customers/getListByWhere?where=' + where);
  list := processJson(res, 'TCustomersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCustomersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Customers_Entities_GetEntityByWhere(where: String): TCustomersEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customers/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TCustomersEntity');
  result := TCustomersEntity(list[0]);
  
end;

function TRoomerDataSet.Customers_Entities_SaveEntity(entity: TCustomersEntity): TCustomersEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'customers'), entity.json);
  result := TCustomersEntity(processJson(src, 'TCustomersEntity')[0]);
  
end;

function TRoomerDataSet.Customers_Entities_UpdateEntity(entity: TCustomersEntity): TCustomersEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'customers/' + inttostr(entity.Id)), entity.json);
  result := TCustomersEntity(processJson(src, 'TCustomersEntity')[0]);
  
end;

procedure TRoomerDataSet.Customers_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'customers/' + inttostr(id)));
  
end;

function TRoomerDataSet.Customers_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customers');
end;

function TRoomerDataSet.Customers_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customers/' + inttostr(id));
end;

function TRoomerDataSet.Customers_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'customers/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Customers_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'customers/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Customers_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customers/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Customers_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customers/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Customers_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customers/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Customers_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'customers/execute', 'sql=' + sql);
end;


// ******************************* Customertypes **********************************

function TRoomerDataSet.Customertypes_Entities_FindAll(): Array_Of_TCustomertypesEntity;
var entities : Array_Of_TCustomertypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customertypes/findAll');
  list := processJson(res, 'TCustomertypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCustomertypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Customertypes_Entities_GetById(id: Integer): TCustomertypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customertypes/' + inttostr(id));
  list := processJson(res, 'TCustomertypesEntity');
  result := TCustomertypesEntity(list[0]);
  
end;

function TRoomerDataSet.Customertypes_Entities_GetBySql(sql: String): Array_Of_TCustomertypesEntity;
var entities : Array_Of_TCustomertypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customertypes/getSql?sql=' + sql);
  list := processJson(res, 'TCustomertypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCustomertypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Customertypes_Entities_GetListByWhere(where: String): Array_Of_TCustomertypesEntity;
var entities : Array_Of_TCustomertypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customertypes/getListByWhere?where=' + where);
  list := processJson(res, 'TCustomertypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TCustomertypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Customertypes_Entities_GetEntityByWhere(where: String): TCustomertypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'customertypes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TCustomertypesEntity');
  result := TCustomertypesEntity(list[0]);
  
end;

function TRoomerDataSet.Customertypes_Entities_SaveEntity(entity: TCustomertypesEntity): TCustomertypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'customertypes'), entity.json);
  result := TCustomertypesEntity(processJson(src, 'TCustomertypesEntity')[0]);
  
end;

function TRoomerDataSet.Customertypes_Entities_UpdateEntity(entity: TCustomertypesEntity): TCustomertypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'customertypes/' + inttostr(entity.Id)), entity.json);
  result := TCustomertypesEntity(processJson(src, 'TCustomertypesEntity')[0]);
  
end;

procedure TRoomerDataSet.Customertypes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'customertypes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Customertypes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customertypes');
end;

function TRoomerDataSet.Customertypes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customertypes/' + inttostr(id));
end;

function TRoomerDataSet.Customertypes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'customertypes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Customertypes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'customertypes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Customertypes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customertypes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Customertypes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customertypes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Customertypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'customertypes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Customertypes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'customertypes/execute', 'sql=' + sql);
end;


// ******************************* Dictionary **********************************

function TRoomerDataSet.Dictionary_Entities_FindAll(): Array_Of_TDictionaryEntity;
var entities : Array_Of_TDictionaryEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'dictionary/findAll');
  list := processJson(res, 'TDictionaryEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TDictionaryEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Dictionary_Entities_GetById(id: Integer): TDictionaryEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'dictionary/' + inttostr(id));
  list := processJson(res, 'TDictionaryEntity');
  result := TDictionaryEntity(list[0]);
  
end;

function TRoomerDataSet.Dictionary_Entities_GetBySql(sql: String): Array_Of_TDictionaryEntity;
var entities : Array_Of_TDictionaryEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'dictionary/getSql?sql=' + sql);
  list := processJson(res, 'TDictionaryEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TDictionaryEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Dictionary_Entities_GetListByWhere(where: String): Array_Of_TDictionaryEntity;
var entities : Array_Of_TDictionaryEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'dictionary/getListByWhere?where=' + where);
  list := processJson(res, 'TDictionaryEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TDictionaryEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Dictionary_Entities_GetEntityByWhere(where: String): TDictionaryEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'dictionary/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TDictionaryEntity');
  result := TDictionaryEntity(list[0]);
  
end;

function TRoomerDataSet.Dictionary_Entities_SaveEntity(entity: TDictionaryEntity): TDictionaryEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'dictionary'), entity.json);
  result := TDictionaryEntity(processJson(src, 'TDictionaryEntity')[0]);
  
end;

function TRoomerDataSet.Dictionary_Entities_UpdateEntity(entity: TDictionaryEntity): TDictionaryEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'dictionary/' + inttostr(entity.Id)), entity.json);
  result := TDictionaryEntity(processJson(src, 'TDictionaryEntity')[0]);
  
end;

procedure TRoomerDataSet.Dictionary_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'dictionary/' + inttostr(id)));
  
end;

function TRoomerDataSet.Dictionary_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'dictionary');
end;

function TRoomerDataSet.Dictionary_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'dictionary/' + inttostr(id));
end;

function TRoomerDataSet.Dictionary_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'dictionary/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Dictionary_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'dictionary/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Dictionary_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'dictionary/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Dictionary_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'dictionary/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Dictionary_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'dictionary/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Dictionary_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'dictionary/execute', 'sql=' + sql);
end;


// ******************************* Facilityactiontypes **********************************

function TRoomerDataSet.Facilityactiontypes_Entities_FindAll(): Array_Of_TFacilityactiontypesEntity;
var entities : Array_Of_TFacilityactiontypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'facilityactiontypes/findAll');
  list := processJson(res, 'TFacilityactiontypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TFacilityactiontypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Facilityactiontypes_Entities_GetById(id: Integer): TFacilityactiontypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'facilityactiontypes/' + inttostr(id));
  list := processJson(res, 'TFacilityactiontypesEntity');
  result := TFacilityactiontypesEntity(list[0]);
  
end;

function TRoomerDataSet.Facilityactiontypes_Entities_GetBySql(sql: String): Array_Of_TFacilityactiontypesEntity;
var entities : Array_Of_TFacilityactiontypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'facilityactiontypes/getSql?sql=' + sql);
  list := processJson(res, 'TFacilityactiontypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TFacilityactiontypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Facilityactiontypes_Entities_GetListByWhere(where: String): Array_Of_TFacilityactiontypesEntity;
var entities : Array_Of_TFacilityactiontypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'facilityactiontypes/getListByWhere?where=' + where);
  list := processJson(res, 'TFacilityactiontypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TFacilityactiontypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Facilityactiontypes_Entities_GetEntityByWhere(where: String): TFacilityactiontypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'facilityactiontypes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TFacilityactiontypesEntity');
  result := TFacilityactiontypesEntity(list[0]);
  
end;

function TRoomerDataSet.Facilityactiontypes_Entities_SaveEntity(entity: TFacilityactiontypesEntity): TFacilityactiontypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'facilityactiontypes'), entity.json);
  result := TFacilityactiontypesEntity(processJson(src, 'TFacilityactiontypesEntity')[0]);
  
end;

function TRoomerDataSet.Facilityactiontypes_Entities_UpdateEntity(entity: TFacilityactiontypesEntity): TFacilityactiontypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'facilityactiontypes/' + inttostr(entity.Id)), entity.json);
  result := TFacilityactiontypesEntity(processJson(src, 'TFacilityactiontypesEntity')[0]);
  
end;

procedure TRoomerDataSet.Facilityactiontypes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'facilityactiontypes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Facilityactiontypes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'facilityactiontypes');
end;

function TRoomerDataSet.Facilityactiontypes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'facilityactiontypes/' + inttostr(id));
end;

function TRoomerDataSet.Facilityactiontypes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'facilityactiontypes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Facilityactiontypes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'facilityactiontypes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Facilityactiontypes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'facilityactiontypes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Facilityactiontypes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'facilityactiontypes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Facilityactiontypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'facilityactiontypes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Facilityactiontypes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'facilityactiontypes/execute', 'sql=' + sql);
end;


// ******************************* Fakenames **********************************

function TRoomerDataSet.Fakenames_Entities_FindAll(): Array_Of_TFakenamesEntity;
var entities : Array_Of_TFakenamesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'fakenames/findAll');
  list := processJson(res, 'TFakenamesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TFakenamesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Fakenames_Entities_GetById(id: Integer): TFakenamesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'fakenames/' + inttostr(id));
  list := processJson(res, 'TFakenamesEntity');
  result := TFakenamesEntity(list[0]);
  
end;

function TRoomerDataSet.Fakenames_Entities_GetBySql(sql: String): Array_Of_TFakenamesEntity;
var entities : Array_Of_TFakenamesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'fakenames/getSql?sql=' + sql);
  list := processJson(res, 'TFakenamesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TFakenamesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Fakenames_Entities_GetListByWhere(where: String): Array_Of_TFakenamesEntity;
var entities : Array_Of_TFakenamesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'fakenames/getListByWhere?where=' + where);
  list := processJson(res, 'TFakenamesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TFakenamesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Fakenames_Entities_GetEntityByWhere(where: String): TFakenamesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'fakenames/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TFakenamesEntity');
  result := TFakenamesEntity(list[0]);
  
end;

function TRoomerDataSet.Fakenames_Entities_SaveEntity(entity: TFakenamesEntity): TFakenamesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'fakenames'), entity.json);
  result := TFakenamesEntity(processJson(src, 'TFakenamesEntity')[0]);
  
end;

function TRoomerDataSet.Fakenames_Entities_UpdateEntity(entity: TFakenamesEntity): TFakenamesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'fakenames/' + inttostr(entity.Id)), entity.json);
  result := TFakenamesEntity(processJson(src, 'TFakenamesEntity')[0]);
  
end;

procedure TRoomerDataSet.Fakenames_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'fakenames/' + inttostr(id)));
  
end;

function TRoomerDataSet.Fakenames_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'fakenames');
end;

function TRoomerDataSet.Fakenames_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'fakenames/' + inttostr(id));
end;

function TRoomerDataSet.Fakenames_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'fakenames/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Fakenames_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'fakenames/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Fakenames_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'fakenames/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Fakenames_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'fakenames/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Fakenames_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'fakenames/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Fakenames_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'fakenames/execute', 'sql=' + sql);
end;


// ******************************* Hotelconfigurations **********************************

function TRoomerDataSet.Hotelconfigurations_Entities_FindAll(): Array_Of_THotelconfigurationsEntity;
var entities : Array_Of_THotelconfigurationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelconfigurations/findAll');
  list := processJson(res, 'THotelconfigurationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THotelconfigurationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hotelconfigurations_Entities_GetById(id: Integer): THotelconfigurationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelconfigurations/' + inttostr(id));
  list := processJson(res, 'THotelconfigurationsEntity');
  result := THotelconfigurationsEntity(list[0]);
  
end;

function TRoomerDataSet.Hotelconfigurations_Entities_GetBySql(sql: String): Array_Of_THotelconfigurationsEntity;
var entities : Array_Of_THotelconfigurationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelconfigurations/getSql?sql=' + sql);
  list := processJson(res, 'THotelconfigurationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THotelconfigurationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hotelconfigurations_Entities_GetListByWhere(where: String): Array_Of_THotelconfigurationsEntity;
var entities : Array_Of_THotelconfigurationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelconfigurations/getListByWhere?where=' + where);
  list := processJson(res, 'THotelconfigurationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THotelconfigurationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hotelconfigurations_Entities_GetEntityByWhere(where: String): THotelconfigurationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelconfigurations/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'THotelconfigurationsEntity');
  result := THotelconfigurationsEntity(list[0]);
  
end;

function TRoomerDataSet.Hotelconfigurations_Entities_SaveEntity(entity: THotelconfigurationsEntity): THotelconfigurationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'hotelconfigurations'), entity.json);
  result := THotelconfigurationsEntity(processJson(src, 'THotelconfigurationsEntity')[0]);
  
end;

function TRoomerDataSet.Hotelconfigurations_Entities_UpdateEntity(entity: THotelconfigurationsEntity): THotelconfigurationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'hotelconfigurations/' + inttostr(entity.Id)), entity.json);
  result := THotelconfigurationsEntity(processJson(src, 'THotelconfigurationsEntity')[0]);
  
end;

procedure TRoomerDataSet.Hotelconfigurations_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'hotelconfigurations/' + inttostr(id)));
  
end;

function TRoomerDataSet.Hotelconfigurations_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelconfigurations');
end;

function TRoomerDataSet.Hotelconfigurations_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelconfigurations/' + inttostr(id));
end;

function TRoomerDataSet.Hotelconfigurations_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'hotelconfigurations/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Hotelconfigurations_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'hotelconfigurations/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Hotelconfigurations_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelconfigurations/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Hotelconfigurations_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelconfigurations/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Hotelconfigurations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelconfigurations/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Hotelconfigurations_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'hotelconfigurations/execute', 'sql=' + sql);
end;


// ******************************* Hotelcontacts **********************************

function TRoomerDataSet.Hotelcontacts_Entities_FindAll(): Array_Of_THotelcontactsEntity;
var entities : Array_Of_THotelcontactsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelcontacts/findAll');
  list := processJson(res, 'THotelcontactsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THotelcontactsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hotelcontacts_Entities_GetById(id: Integer): THotelcontactsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelcontacts/' + inttostr(id));
  list := processJson(res, 'THotelcontactsEntity');
  result := THotelcontactsEntity(list[0]);
  
end;

function TRoomerDataSet.Hotelcontacts_Entities_GetBySql(sql: String): Array_Of_THotelcontactsEntity;
var entities : Array_Of_THotelcontactsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelcontacts/getSql?sql=' + sql);
  list := processJson(res, 'THotelcontactsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THotelcontactsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hotelcontacts_Entities_GetListByWhere(where: String): Array_Of_THotelcontactsEntity;
var entities : Array_Of_THotelcontactsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelcontacts/getListByWhere?where=' + where);
  list := processJson(res, 'THotelcontactsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THotelcontactsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hotelcontacts_Entities_GetEntityByWhere(where: String): THotelcontactsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelcontacts/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'THotelcontactsEntity');
  result := THotelcontactsEntity(list[0]);
  
end;

function TRoomerDataSet.Hotelcontacts_Entities_SaveEntity(entity: THotelcontactsEntity): THotelcontactsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'hotelcontacts'), entity.json);
  result := THotelcontactsEntity(processJson(src, 'THotelcontactsEntity')[0]);
  
end;

function TRoomerDataSet.Hotelcontacts_Entities_UpdateEntity(entity: THotelcontactsEntity): THotelcontactsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'hotelcontacts/' + inttostr(entity.Id)), entity.json);
  result := THotelcontactsEntity(processJson(src, 'THotelcontactsEntity')[0]);
  
end;

procedure TRoomerDataSet.Hotelcontacts_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'hotelcontacts/' + inttostr(id)));
  
end;

function TRoomerDataSet.Hotelcontacts_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelcontacts');
end;

function TRoomerDataSet.Hotelcontacts_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelcontacts/' + inttostr(id));
end;

function TRoomerDataSet.Hotelcontacts_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'hotelcontacts/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Hotelcontacts_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'hotelcontacts/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Hotelcontacts_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelcontacts/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Hotelcontacts_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelcontacts/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Hotelcontacts_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelcontacts/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Hotelcontacts_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'hotelcontacts/execute', 'sql=' + sql);
end;


// ******************************* Hotelcounters **********************************

function TRoomerDataSet.Hotelcounters_Entities_FindAll(): Array_Of_THotelcountersEntity;
var entities : Array_Of_THotelcountersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelcounters/findAll');
  list := processJson(res, 'THotelcountersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THotelcountersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hotelcounters_Entities_GetById(id: Integer): THotelcountersEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelcounters/' + inttostr(id));
  list := processJson(res, 'THotelcountersEntity');
  result := THotelcountersEntity(list[0]);
  
end;

function TRoomerDataSet.Hotelcounters_Entities_GetBySql(sql: String): Array_Of_THotelcountersEntity;
var entities : Array_Of_THotelcountersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelcounters/getSql?sql=' + sql);
  list := processJson(res, 'THotelcountersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THotelcountersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hotelcounters_Entities_GetListByWhere(where: String): Array_Of_THotelcountersEntity;
var entities : Array_Of_THotelcountersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelcounters/getListByWhere?where=' + where);
  list := processJson(res, 'THotelcountersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THotelcountersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hotelcounters_Entities_GetEntityByWhere(where: String): THotelcountersEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hotelcounters/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'THotelcountersEntity');
  result := THotelcountersEntity(list[0]);
  
end;

function TRoomerDataSet.Hotelcounters_Entities_SaveEntity(entity: THotelcountersEntity): THotelcountersEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'hotelcounters'), entity.json);
  result := THotelcountersEntity(processJson(src, 'THotelcountersEntity')[0]);
  
end;

function TRoomerDataSet.Hotelcounters_Entities_UpdateEntity(entity: THotelcountersEntity): THotelcountersEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'hotelcounters/' + inttostr(entity.Id)), entity.json);
  result := THotelcountersEntity(processJson(src, 'THotelcountersEntity')[0]);
  
end;

procedure TRoomerDataSet.Hotelcounters_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'hotelcounters/' + inttostr(id)));
  
end;

function TRoomerDataSet.Hotelcounters_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelcounters');
end;

function TRoomerDataSet.Hotelcounters_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelcounters/' + inttostr(id));
end;

function TRoomerDataSet.Hotelcounters_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'hotelcounters/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Hotelcounters_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'hotelcounters/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Hotelcounters_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelcounters/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Hotelcounters_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelcounters/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Hotelcounters_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hotelcounters/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Hotelcounters_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'hotelcounters/execute', 'sql=' + sql);
end;


// ******************************* Hoteltasks **********************************

function TRoomerDataSet.Hoteltasks_Entities_FindAll(): Array_Of_THoteltasksEntity;
var entities : Array_Of_THoteltasksEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hoteltasks/findAll');
  list := processJson(res, 'THoteltasksEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THoteltasksEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hoteltasks_Entities_GetById(id: Integer): THoteltasksEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hoteltasks/' + inttostr(id));
  list := processJson(res, 'THoteltasksEntity');
  result := THoteltasksEntity(list[0]);
  
end;

function TRoomerDataSet.Hoteltasks_Entities_GetBySql(sql: String): Array_Of_THoteltasksEntity;
var entities : Array_Of_THoteltasksEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hoteltasks/getSql?sql=' + sql);
  list := processJson(res, 'THoteltasksEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THoteltasksEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hoteltasks_Entities_GetListByWhere(where: String): Array_Of_THoteltasksEntity;
var entities : Array_Of_THoteltasksEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hoteltasks/getListByWhere?where=' + where);
  list := processJson(res, 'THoteltasksEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := THoteltasksEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Hoteltasks_Entities_GetEntityByWhere(where: String): THoteltasksEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'hoteltasks/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'THoteltasksEntity');
  result := THoteltasksEntity(list[0]);
  
end;

function TRoomerDataSet.Hoteltasks_Entities_SaveEntity(entity: THoteltasksEntity): THoteltasksEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'hoteltasks'), entity.json);
  result := THoteltasksEntity(processJson(src, 'THoteltasksEntity')[0]);
  
end;

function TRoomerDataSet.Hoteltasks_Entities_UpdateEntity(entity: THoteltasksEntity): THoteltasksEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'hoteltasks/' + inttostr(entity.Id)), entity.json);
  result := THoteltasksEntity(processJson(src, 'THoteltasksEntity')[0]);
  
end;

procedure TRoomerDataSet.Hoteltasks_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'hoteltasks/' + inttostr(id)));
  
end;

function TRoomerDataSet.Hoteltasks_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hoteltasks');
end;

function TRoomerDataSet.Hoteltasks_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hoteltasks/' + inttostr(id));
end;

function TRoomerDataSet.Hoteltasks_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'hoteltasks/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Hoteltasks_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'hoteltasks/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Hoteltasks_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hoteltasks/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Hoteltasks_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hoteltasks/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Hoteltasks_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'hoteltasks/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Hoteltasks_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'hoteltasks/execute', 'sql=' + sql);
end;


// ******************************* Idreferences **********************************

function TRoomerDataSet.Idreferences_Entities_FindAll(): Array_Of_TIdreferencesEntity;
var entities : Array_Of_TIdreferencesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'idreferences/findAll');
  list := processJson(res, 'TIdreferencesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TIdreferencesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Idreferences_Entities_GetById(id: Integer): TIdreferencesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'idreferences/' + inttostr(id));
  list := processJson(res, 'TIdreferencesEntity');
  result := TIdreferencesEntity(list[0]);
  
end;

function TRoomerDataSet.Idreferences_Entities_GetBySql(sql: String): Array_Of_TIdreferencesEntity;
var entities : Array_Of_TIdreferencesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'idreferences/getSql?sql=' + sql);
  list := processJson(res, 'TIdreferencesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TIdreferencesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Idreferences_Entities_GetListByWhere(where: String): Array_Of_TIdreferencesEntity;
var entities : Array_Of_TIdreferencesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'idreferences/getListByWhere?where=' + where);
  list := processJson(res, 'TIdreferencesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TIdreferencesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Idreferences_Entities_GetEntityByWhere(where: String): TIdreferencesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'idreferences/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TIdreferencesEntity');
  result := TIdreferencesEntity(list[0]);
  
end;

function TRoomerDataSet.Idreferences_Entities_SaveEntity(entity: TIdreferencesEntity): TIdreferencesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'idreferences'), entity.json);
  result := TIdreferencesEntity(processJson(src, 'TIdreferencesEntity')[0]);
  
end;

function TRoomerDataSet.Idreferences_Entities_UpdateEntity(entity: TIdreferencesEntity): TIdreferencesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'idreferences/' + inttostr(entity.Id)), entity.json);
  result := TIdreferencesEntity(processJson(src, 'TIdreferencesEntity')[0]);
  
end;

procedure TRoomerDataSet.Idreferences_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'idreferences/' + inttostr(id)));
  
end;

function TRoomerDataSet.Idreferences_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'idreferences');
end;

function TRoomerDataSet.Idreferences_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'idreferences/' + inttostr(id));
end;

function TRoomerDataSet.Idreferences_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'idreferences/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Idreferences_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'idreferences/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Idreferences_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'idreferences/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Idreferences_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'idreferences/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Idreferences_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'idreferences/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Idreferences_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'idreferences/execute', 'sql=' + sql);
end;


// ******************************* Industries **********************************

function TRoomerDataSet.Industries_Entities_FindAll(): Array_Of_TIndustriesEntity;
var entities : Array_Of_TIndustriesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'industries/findAll');
  list := processJson(res, 'TIndustriesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TIndustriesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Industries_Entities_GetById(id: Integer): TIndustriesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'industries/' + inttostr(id));
  list := processJson(res, 'TIndustriesEntity');
  result := TIndustriesEntity(list[0]);
  
end;

function TRoomerDataSet.Industries_Entities_GetBySql(sql: String): Array_Of_TIndustriesEntity;
var entities : Array_Of_TIndustriesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'industries/getSql?sql=' + sql);
  list := processJson(res, 'TIndustriesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TIndustriesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Industries_Entities_GetListByWhere(where: String): Array_Of_TIndustriesEntity;
var entities : Array_Of_TIndustriesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'industries/getListByWhere?where=' + where);
  list := processJson(res, 'TIndustriesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TIndustriesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Industries_Entities_GetEntityByWhere(where: String): TIndustriesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'industries/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TIndustriesEntity');
  result := TIndustriesEntity(list[0]);
  
end;

function TRoomerDataSet.Industries_Entities_SaveEntity(entity: TIndustriesEntity): TIndustriesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'industries'), entity.json);
  result := TIndustriesEntity(processJson(src, 'TIndustriesEntity')[0]);
  
end;

function TRoomerDataSet.Industries_Entities_UpdateEntity(entity: TIndustriesEntity): TIndustriesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'industries/' + inttostr(entity.Id)), entity.json);
  result := TIndustriesEntity(processJson(src, 'TIndustriesEntity')[0]);
  
end;

procedure TRoomerDataSet.Industries_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'industries/' + inttostr(id)));
  
end;

function TRoomerDataSet.Industries_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'industries');
end;

function TRoomerDataSet.Industries_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'industries/' + inttostr(id));
end;

function TRoomerDataSet.Industries_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'industries/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Industries_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'industries/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Industries_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'industries/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Industries_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'industries/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Industries_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'industries/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Industries_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'industries/execute', 'sql=' + sql);
end;


// ******************************* Invoiceheads **********************************

function TRoomerDataSet.Invoiceheads_Entities_FindAll(): Array_Of_TInvoiceheadsEntity;
var entities : Array_Of_TInvoiceheadsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoiceheads/findAll');
  list := processJson(res, 'TInvoiceheadsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TInvoiceheadsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Invoiceheads_Entities_GetById(id: Integer): TInvoiceheadsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoiceheads/' + inttostr(id));
  list := processJson(res, 'TInvoiceheadsEntity');
  result := TInvoiceheadsEntity(list[0]);
  
end;

function TRoomerDataSet.Invoiceheads_Entities_GetBySql(sql: String): Array_Of_TInvoiceheadsEntity;
var entities : Array_Of_TInvoiceheadsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoiceheads/getSql?sql=' + sql);
  list := processJson(res, 'TInvoiceheadsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TInvoiceheadsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Invoiceheads_Entities_GetListByWhere(where: String): Array_Of_TInvoiceheadsEntity;
var entities : Array_Of_TInvoiceheadsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoiceheads/getListByWhere?where=' + where);
  list := processJson(res, 'TInvoiceheadsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TInvoiceheadsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Invoiceheads_Entities_GetEntityByWhere(where: String): TInvoiceheadsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoiceheads/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TInvoiceheadsEntity');
  result := TInvoiceheadsEntity(list[0]);
  
end;

function TRoomerDataSet.Invoiceheads_Entities_SaveEntity(entity: TInvoiceheadsEntity): TInvoiceheadsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'invoiceheads'), entity.json);
  result := TInvoiceheadsEntity(processJson(src, 'TInvoiceheadsEntity')[0]);
  
end;

function TRoomerDataSet.Invoiceheads_Entities_UpdateEntity(entity: TInvoiceheadsEntity): TInvoiceheadsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'invoiceheads/' + inttostr(entity.Id)), entity.json);
  result := TInvoiceheadsEntity(processJson(src, 'TInvoiceheadsEntity')[0]);
  
end;

procedure TRoomerDataSet.Invoiceheads_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'invoiceheads/' + inttostr(id)));
  
end;

function TRoomerDataSet.Invoiceheads_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoiceheads');
end;

function TRoomerDataSet.Invoiceheads_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoiceheads/' + inttostr(id));
end;

function TRoomerDataSet.Invoiceheads_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'invoiceheads/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Invoiceheads_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'invoiceheads/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Invoiceheads_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoiceheads/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Invoiceheads_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoiceheads/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Invoiceheads_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoiceheads/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Invoiceheads_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'invoiceheads/execute', 'sql=' + sql);
end;


// ******************************* Invoicelines **********************************

function TRoomerDataSet.Invoicelines_Entities_FindAll(): Array_Of_TInvoicelinesEntity;
var entities : Array_Of_TInvoicelinesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoicelines/findAll');
  list := processJson(res, 'TInvoicelinesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TInvoicelinesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Invoicelines_Entities_GetById(id: Integer): TInvoicelinesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoicelines/' + inttostr(id));
  list := processJson(res, 'TInvoicelinesEntity');
  result := TInvoicelinesEntity(list[0]);
  
end;

function TRoomerDataSet.Invoicelines_Entities_GetBySql(sql: String): Array_Of_TInvoicelinesEntity;
var entities : Array_Of_TInvoicelinesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoicelines/getSql?sql=' + sql);
  list := processJson(res, 'TInvoicelinesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TInvoicelinesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Invoicelines_Entities_GetListByWhere(where: String): Array_Of_TInvoicelinesEntity;
var entities : Array_Of_TInvoicelinesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoicelines/getListByWhere?where=' + where);
  list := processJson(res, 'TInvoicelinesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TInvoicelinesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Invoicelines_Entities_GetEntityByWhere(where: String): TInvoicelinesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoicelines/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TInvoicelinesEntity');
  result := TInvoicelinesEntity(list[0]);
  
end;

function TRoomerDataSet.Invoicelines_Entities_SaveEntity(entity: TInvoicelinesEntity): TInvoicelinesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'invoicelines'), entity.json);
  result := TInvoicelinesEntity(processJson(src, 'TInvoicelinesEntity')[0]);
  
end;

function TRoomerDataSet.Invoicelines_Entities_UpdateEntity(entity: TInvoicelinesEntity): TInvoicelinesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'invoicelines/' + inttostr(entity.Id)), entity.json);
  result := TInvoicelinesEntity(processJson(src, 'TInvoicelinesEntity')[0]);
  
end;

procedure TRoomerDataSet.Invoicelines_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'invoicelines/' + inttostr(id)));
  
end;

function TRoomerDataSet.Invoicelines_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoicelines');
end;

function TRoomerDataSet.Invoicelines_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoicelines/' + inttostr(id));
end;

function TRoomerDataSet.Invoicelines_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'invoicelines/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Invoicelines_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'invoicelines/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Invoicelines_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoicelines/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Invoicelines_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoicelines/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Invoicelines_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoicelines/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Invoicelines_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'invoicelines/execute', 'sql=' + sql);
end;


// ******************************* Invoicelinestmp **********************************

function TRoomerDataSet.Invoicelinestmp_Entities_FindAll(): Array_Of_TInvoicelinestmpEntity;
var entities : Array_Of_TInvoicelinestmpEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoicelinestmp/findAll');
  list := processJson(res, 'TInvoicelinestmpEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TInvoicelinestmpEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Invoicelinestmp_Entities_GetById(id: Integer): TInvoicelinestmpEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoicelinestmp/' + inttostr(id));
  list := processJson(res, 'TInvoicelinestmpEntity');
  result := TInvoicelinestmpEntity(list[0]);
  
end;

function TRoomerDataSet.Invoicelinestmp_Entities_GetBySql(sql: String): Array_Of_TInvoicelinestmpEntity;
var entities : Array_Of_TInvoicelinestmpEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoicelinestmp/getSql?sql=' + sql);
  list := processJson(res, 'TInvoicelinestmpEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TInvoicelinestmpEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Invoicelinestmp_Entities_GetListByWhere(where: String): Array_Of_TInvoicelinestmpEntity;
var entities : Array_Of_TInvoicelinestmpEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoicelinestmp/getListByWhere?where=' + where);
  list := processJson(res, 'TInvoicelinestmpEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TInvoicelinestmpEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Invoicelinestmp_Entities_GetEntityByWhere(where: String): TInvoicelinestmpEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'invoicelinestmp/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TInvoicelinestmpEntity');
  result := TInvoicelinestmpEntity(list[0]);
  
end;

function TRoomerDataSet.Invoicelinestmp_Entities_SaveEntity(entity: TInvoicelinestmpEntity): TInvoicelinestmpEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'invoicelinestmp'), entity.json);
  result := TInvoicelinestmpEntity(processJson(src, 'TInvoicelinestmpEntity')[0]);
  
end;

function TRoomerDataSet.Invoicelinestmp_Entities_UpdateEntity(entity: TInvoicelinestmpEntity): TInvoicelinestmpEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'invoicelinestmp/' + inttostr(entity.Id)), entity.json);
  result := TInvoicelinestmpEntity(processJson(src, 'TInvoicelinestmpEntity')[0]);
  
end;

procedure TRoomerDataSet.Invoicelinestmp_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'invoicelinestmp/' + inttostr(id)));
  
end;

function TRoomerDataSet.Invoicelinestmp_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoicelinestmp');
end;

function TRoomerDataSet.Invoicelinestmp_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoicelinestmp/' + inttostr(id));
end;

function TRoomerDataSet.Invoicelinestmp_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'invoicelinestmp/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Invoicelinestmp_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'invoicelinestmp/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Invoicelinestmp_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoicelinestmp/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Invoicelinestmp_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoicelinestmp/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Invoicelinestmp_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'invoicelinestmp/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Invoicelinestmp_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'invoicelinestmp/execute', 'sql=' + sql);
end;


// ******************************* Items **********************************

function TRoomerDataSet.Items_Entities_FindAll(): Array_Of_TItemsEntity;
var entities : Array_Of_TItemsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'items/findAll');
  list := processJson(res, 'TItemsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TItemsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Items_Entities_GetById(id: Integer): TItemsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'items/' + inttostr(id));
  list := processJson(res, 'TItemsEntity');
  result := TItemsEntity(list[0]);
  
end;

function TRoomerDataSet.Items_Entities_GetBySql(sql: String): Array_Of_TItemsEntity;
var entities : Array_Of_TItemsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'items/getSql?sql=' + sql);
  list := processJson(res, 'TItemsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TItemsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Items_Entities_GetListByWhere(where: String): Array_Of_TItemsEntity;
var entities : Array_Of_TItemsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'items/getListByWhere?where=' + where);
  list := processJson(res, 'TItemsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TItemsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Items_Entities_GetEntityByWhere(where: String): TItemsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'items/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TItemsEntity');
  result := TItemsEntity(list[0]);
  
end;

function TRoomerDataSet.Items_Entities_SaveEntity(entity: TItemsEntity): TItemsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'items'), entity.json);
  result := TItemsEntity(processJson(src, 'TItemsEntity')[0]);
  
end;

function TRoomerDataSet.Items_Entities_UpdateEntity(entity: TItemsEntity): TItemsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'items/' + inttostr(entity.Id)), entity.json);
  result := TItemsEntity(processJson(src, 'TItemsEntity')[0]);
  
end;

procedure TRoomerDataSet.Items_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'items/' + inttostr(id)));
  
end;

function TRoomerDataSet.Items_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'items');
end;

function TRoomerDataSet.Items_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'items/' + inttostr(id));
end;

function TRoomerDataSet.Items_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'items/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Items_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'items/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Items_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'items/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Items_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'items/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Items_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'items/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Items_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'items/execute', 'sql=' + sql);
end;


// ******************************* Itemtypes **********************************

function TRoomerDataSet.Itemtypes_Entities_FindAll(): Array_Of_TItemtypesEntity;
var entities : Array_Of_TItemtypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'itemtypes/findAll');
  list := processJson(res, 'TItemtypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TItemtypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Itemtypes_Entities_GetById(id: Integer): TItemtypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'itemtypes/' + inttostr(id));
  list := processJson(res, 'TItemtypesEntity');
  result := TItemtypesEntity(list[0]);
  
end;

function TRoomerDataSet.Itemtypes_Entities_GetBySql(sql: String): Array_Of_TItemtypesEntity;
var entities : Array_Of_TItemtypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'itemtypes/getSql?sql=' + sql);
  list := processJson(res, 'TItemtypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TItemtypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Itemtypes_Entities_GetListByWhere(where: String): Array_Of_TItemtypesEntity;
var entities : Array_Of_TItemtypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'itemtypes/getListByWhere?where=' + where);
  list := processJson(res, 'TItemtypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TItemtypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Itemtypes_Entities_GetEntityByWhere(where: String): TItemtypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'itemtypes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TItemtypesEntity');
  result := TItemtypesEntity(list[0]);
  
end;

function TRoomerDataSet.Itemtypes_Entities_SaveEntity(entity: TItemtypesEntity): TItemtypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'itemtypes'), entity.json);
  result := TItemtypesEntity(processJson(src, 'TItemtypesEntity')[0]);
  
end;

function TRoomerDataSet.Itemtypes_Entities_UpdateEntity(entity: TItemtypesEntity): TItemtypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'itemtypes/' + inttostr(entity.Id)), entity.json);
  result := TItemtypesEntity(processJson(src, 'TItemtypesEntity')[0]);
  
end;

procedure TRoomerDataSet.Itemtypes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'itemtypes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Itemtypes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'itemtypes');
end;

function TRoomerDataSet.Itemtypes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'itemtypes/' + inttostr(id));
end;

function TRoomerDataSet.Itemtypes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'itemtypes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Itemtypes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'itemtypes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Itemtypes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'itemtypes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Itemtypes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'itemtypes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Itemtypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'itemtypes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Itemtypes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'itemtypes/execute', 'sql=' + sql);
end;


// ******************************* Locations **********************************

function TRoomerDataSet.Locations_Entities_FindAll(): Array_Of_TLocationsEntity;
var entities : Array_Of_TLocationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'locations/findAll');
  list := processJson(res, 'TLocationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TLocationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Locations_Entities_GetById(id: Integer): TLocationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'locations/' + inttostr(id));
  list := processJson(res, 'TLocationsEntity');
  result := TLocationsEntity(list[0]);
  
end;

function TRoomerDataSet.Locations_Entities_GetBySql(sql: String): Array_Of_TLocationsEntity;
var entities : Array_Of_TLocationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'locations/getSql?sql=' + sql);
  list := processJson(res, 'TLocationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TLocationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Locations_Entities_GetListByWhere(where: String): Array_Of_TLocationsEntity;
var entities : Array_Of_TLocationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'locations/getListByWhere?where=' + where);
  list := processJson(res, 'TLocationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TLocationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Locations_Entities_GetEntityByWhere(where: String): TLocationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'locations/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TLocationsEntity');
  result := TLocationsEntity(list[0]);
  
end;

function TRoomerDataSet.Locations_Entities_SaveEntity(entity: TLocationsEntity): TLocationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'locations'), entity.json);
  result := TLocationsEntity(processJson(src, 'TLocationsEntity')[0]);
  
end;

function TRoomerDataSet.Locations_Entities_UpdateEntity(entity: TLocationsEntity): TLocationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'locations/' + inttostr(entity.Id)), entity.json);
  result := TLocationsEntity(processJson(src, 'TLocationsEntity')[0]);
  
end;

procedure TRoomerDataSet.Locations_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'locations/' + inttostr(id)));
  
end;

function TRoomerDataSet.Locations_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'locations');
end;

function TRoomerDataSet.Locations_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'locations/' + inttostr(id));
end;

function TRoomerDataSet.Locations_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'locations/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Locations_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'locations/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Locations_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'locations/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Locations_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'locations/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Locations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'locations/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Locations_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'locations/execute', 'sql=' + sql);
end;


// ******************************* Maintenancecodes **********************************

function TRoomerDataSet.Maintenancecodes_Entities_FindAll(): Array_Of_TMaintenancecodesEntity;
var entities : Array_Of_TMaintenancecodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'maintenancecodes/findAll');
  list := processJson(res, 'TMaintenancecodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TMaintenancecodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Maintenancecodes_Entities_GetById(id: Integer): TMaintenancecodesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'maintenancecodes/' + inttostr(id));
  list := processJson(res, 'TMaintenancecodesEntity');
  result := TMaintenancecodesEntity(list[0]);
  
end;

function TRoomerDataSet.Maintenancecodes_Entities_GetBySql(sql: String): Array_Of_TMaintenancecodesEntity;
var entities : Array_Of_TMaintenancecodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'maintenancecodes/getSql?sql=' + sql);
  list := processJson(res, 'TMaintenancecodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TMaintenancecodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Maintenancecodes_Entities_GetListByWhere(where: String): Array_Of_TMaintenancecodesEntity;
var entities : Array_Of_TMaintenancecodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'maintenancecodes/getListByWhere?where=' + where);
  list := processJson(res, 'TMaintenancecodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TMaintenancecodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Maintenancecodes_Entities_GetEntityByWhere(where: String): TMaintenancecodesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'maintenancecodes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TMaintenancecodesEntity');
  result := TMaintenancecodesEntity(list[0]);
  
end;

function TRoomerDataSet.Maintenancecodes_Entities_SaveEntity(entity: TMaintenancecodesEntity): TMaintenancecodesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'maintenancecodes'), entity.json);
  result := TMaintenancecodesEntity(processJson(src, 'TMaintenancecodesEntity')[0]);
  
end;

function TRoomerDataSet.Maintenancecodes_Entities_UpdateEntity(entity: TMaintenancecodesEntity): TMaintenancecodesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'maintenancecodes/' + inttostr(entity.Id)), entity.json);
  result := TMaintenancecodesEntity(processJson(src, 'TMaintenancecodesEntity')[0]);
  
end;

procedure TRoomerDataSet.Maintenancecodes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'maintenancecodes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Maintenancecodes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'maintenancecodes');
end;

function TRoomerDataSet.Maintenancecodes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'maintenancecodes/' + inttostr(id));
end;

function TRoomerDataSet.Maintenancecodes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'maintenancecodes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Maintenancecodes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'maintenancecodes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Maintenancecodes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'maintenancecodes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Maintenancecodes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'maintenancecodes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Maintenancecodes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'maintenancecodes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Maintenancecodes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'maintenancecodes/execute', 'sql=' + sql);
end;


// ******************************* Maintenanceroomnotes **********************************

function TRoomerDataSet.Maintenanceroomnotes_Entities_FindAll(): Array_Of_TMaintenanceroomnotesEntity;
var entities : Array_Of_TMaintenanceroomnotesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'maintenanceroomnotes/findAll');
  list := processJson(res, 'TMaintenanceroomnotesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TMaintenanceroomnotesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Maintenanceroomnotes_Entities_GetById(id: Integer): TMaintenanceroomnotesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'maintenanceroomnotes/' + inttostr(id));
  list := processJson(res, 'TMaintenanceroomnotesEntity');
  result := TMaintenanceroomnotesEntity(list[0]);
  
end;

function TRoomerDataSet.Maintenanceroomnotes_Entities_GetBySql(sql: String): Array_Of_TMaintenanceroomnotesEntity;
var entities : Array_Of_TMaintenanceroomnotesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'maintenanceroomnotes/getSql?sql=' + sql);
  list := processJson(res, 'TMaintenanceroomnotesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TMaintenanceroomnotesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Maintenanceroomnotes_Entities_GetListByWhere(where: String): Array_Of_TMaintenanceroomnotesEntity;
var entities : Array_Of_TMaintenanceroomnotesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'maintenanceroomnotes/getListByWhere?where=' + where);
  list := processJson(res, 'TMaintenanceroomnotesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TMaintenanceroomnotesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Maintenanceroomnotes_Entities_GetEntityByWhere(where: String): TMaintenanceroomnotesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'maintenanceroomnotes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TMaintenanceroomnotesEntity');
  result := TMaintenanceroomnotesEntity(list[0]);
  
end;

function TRoomerDataSet.Maintenanceroomnotes_Entities_SaveEntity(entity: TMaintenanceroomnotesEntity): TMaintenanceroomnotesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'maintenanceroomnotes'), entity.json);
  result := TMaintenanceroomnotesEntity(processJson(src, 'TMaintenanceroomnotesEntity')[0]);
  
end;

function TRoomerDataSet.Maintenanceroomnotes_Entities_UpdateEntity(entity: TMaintenanceroomnotesEntity): TMaintenanceroomnotesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'maintenanceroomnotes/' + inttostr(entity.Id)), entity.json);
  result := TMaintenanceroomnotesEntity(processJson(src, 'TMaintenanceroomnotesEntity')[0]);
  
end;

procedure TRoomerDataSet.Maintenanceroomnotes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'maintenanceroomnotes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Maintenanceroomnotes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'maintenanceroomnotes');
end;

function TRoomerDataSet.Maintenanceroomnotes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'maintenanceroomnotes/' + inttostr(id));
end;

function TRoomerDataSet.Maintenanceroomnotes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'maintenanceroomnotes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Maintenanceroomnotes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'maintenanceroomnotes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Maintenanceroomnotes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'maintenanceroomnotes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Maintenanceroomnotes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'maintenanceroomnotes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Maintenanceroomnotes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'maintenanceroomnotes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Maintenanceroomnotes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'maintenanceroomnotes/execute', 'sql=' + sql);
end;


// ******************************* Packageclasses **********************************

function TRoomerDataSet.Packageclasses_Entities_FindAll(): Array_Of_TPackageclassesEntity;
var entities : Array_Of_TPackageclassesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageclasses/findAll');
  list := processJson(res, 'TPackageclassesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackageclassesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packageclasses_Entities_GetById(id: Integer): TPackageclassesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageclasses/' + inttostr(id));
  list := processJson(res, 'TPackageclassesEntity');
  result := TPackageclassesEntity(list[0]);
  
end;

function TRoomerDataSet.Packageclasses_Entities_GetBySql(sql: String): Array_Of_TPackageclassesEntity;
var entities : Array_Of_TPackageclassesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageclasses/getSql?sql=' + sql);
  list := processJson(res, 'TPackageclassesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackageclassesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packageclasses_Entities_GetListByWhere(where: String): Array_Of_TPackageclassesEntity;
var entities : Array_Of_TPackageclassesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageclasses/getListByWhere?where=' + where);
  list := processJson(res, 'TPackageclassesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackageclassesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packageclasses_Entities_GetEntityByWhere(where: String): TPackageclassesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageclasses/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPackageclassesEntity');
  result := TPackageclassesEntity(list[0]);
  
end;

function TRoomerDataSet.Packageclasses_Entities_SaveEntity(entity: TPackageclassesEntity): TPackageclassesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'packageclasses'), entity.json);
  result := TPackageclassesEntity(processJson(src, 'TPackageclassesEntity')[0]);
  
end;

function TRoomerDataSet.Packageclasses_Entities_UpdateEntity(entity: TPackageclassesEntity): TPackageclassesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'packageclasses/' + inttostr(entity.Id)), entity.json);
  result := TPackageclassesEntity(processJson(src, 'TPackageclassesEntity')[0]);
  
end;

procedure TRoomerDataSet.Packageclasses_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'packageclasses/' + inttostr(id)));
  
end;

function TRoomerDataSet.Packageclasses_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageclasses');
end;

function TRoomerDataSet.Packageclasses_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageclasses/' + inttostr(id));
end;

function TRoomerDataSet.Packageclasses_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'packageclasses/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Packageclasses_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'packageclasses/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Packageclasses_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageclasses/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Packageclasses_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageclasses/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Packageclasses_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageclasses/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Packageclasses_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'packageclasses/execute', 'sql=' + sql);
end;


// ******************************* Packageitems **********************************

function TRoomerDataSet.Packageitems_Entities_FindAll(): Array_Of_TPackageitemsEntity;
var entities : Array_Of_TPackageitemsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageitems/findAll');
  list := processJson(res, 'TPackageitemsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackageitemsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packageitems_Entities_GetById(id: Integer): TPackageitemsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageitems/' + inttostr(id));
  list := processJson(res, 'TPackageitemsEntity');
  result := TPackageitemsEntity(list[0]);
  
end;

function TRoomerDataSet.Packageitems_Entities_GetBySql(sql: String): Array_Of_TPackageitemsEntity;
var entities : Array_Of_TPackageitemsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageitems/getSql?sql=' + sql);
  list := processJson(res, 'TPackageitemsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackageitemsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packageitems_Entities_GetListByWhere(where: String): Array_Of_TPackageitemsEntity;
var entities : Array_Of_TPackageitemsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageitems/getListByWhere?where=' + where);
  list := processJson(res, 'TPackageitemsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackageitemsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packageitems_Entities_GetEntityByWhere(where: String): TPackageitemsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageitems/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPackageitemsEntity');
  result := TPackageitemsEntity(list[0]);
  
end;

function TRoomerDataSet.Packageitems_Entities_SaveEntity(entity: TPackageitemsEntity): TPackageitemsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'packageitems'), entity.json);
  result := TPackageitemsEntity(processJson(src, 'TPackageitemsEntity')[0]);
  
end;

function TRoomerDataSet.Packageitems_Entities_UpdateEntity(entity: TPackageitemsEntity): TPackageitemsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'packageitems/' + inttostr(entity.Id)), entity.json);
  result := TPackageitemsEntity(processJson(src, 'TPackageitemsEntity')[0]);
  
end;

procedure TRoomerDataSet.Packageitems_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'packageitems/' + inttostr(id)));
  
end;

function TRoomerDataSet.Packageitems_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageitems');
end;

function TRoomerDataSet.Packageitems_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageitems/' + inttostr(id));
end;

function TRoomerDataSet.Packageitems_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'packageitems/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Packageitems_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'packageitems/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Packageitems_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageitems/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Packageitems_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageitems/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Packageitems_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageitems/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Packageitems_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'packageitems/execute', 'sql=' + sql);
end;


// ******************************* Packages **********************************

function TRoomerDataSet.Packages_Entities_FindAll(): Array_Of_TPackagesEntity;
var entities : Array_Of_TPackagesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packages/findAll');
  list := processJson(res, 'TPackagesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackagesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packages_Entities_GetById(id: Integer): TPackagesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packages/' + inttostr(id));
  list := processJson(res, 'TPackagesEntity');
  result := TPackagesEntity(list[0]);
  
end;

function TRoomerDataSet.Packages_Entities_GetBySql(sql: String): Array_Of_TPackagesEntity;
var entities : Array_Of_TPackagesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packages/getSql?sql=' + sql);
  list := processJson(res, 'TPackagesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackagesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packages_Entities_GetListByWhere(where: String): Array_Of_TPackagesEntity;
var entities : Array_Of_TPackagesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packages/getListByWhere?where=' + where);
  list := processJson(res, 'TPackagesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackagesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packages_Entities_GetEntityByWhere(where: String): TPackagesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packages/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPackagesEntity');
  result := TPackagesEntity(list[0]);
  
end;

function TRoomerDataSet.Packages_Entities_SaveEntity(entity: TPackagesEntity): TPackagesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'packages'), entity.json);
  result := TPackagesEntity(processJson(src, 'TPackagesEntity')[0]);
  
end;

function TRoomerDataSet.Packages_Entities_UpdateEntity(entity: TPackagesEntity): TPackagesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'packages/' + inttostr(entity.Id)), entity.json);
  result := TPackagesEntity(processJson(src, 'TPackagesEntity')[0]);
  
end;

procedure TRoomerDataSet.Packages_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'packages/' + inttostr(id)));
  
end;

function TRoomerDataSet.Packages_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packages');
end;

function TRoomerDataSet.Packages_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packages/' + inttostr(id));
end;

function TRoomerDataSet.Packages_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'packages/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Packages_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'packages/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Packages_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packages/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Packages_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packages/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Packages_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packages/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Packages_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'packages/execute', 'sql=' + sql);
end;


// ******************************* Packageusage **********************************

function TRoomerDataSet.Packageusage_Entities_FindAll(): Array_Of_TPackageusageEntity;
var entities : Array_Of_TPackageusageEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageusage/findAll');
  list := processJson(res, 'TPackageusageEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackageusageEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packageusage_Entities_GetById(id: Integer): TPackageusageEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageusage/' + inttostr(id));
  list := processJson(res, 'TPackageusageEntity');
  result := TPackageusageEntity(list[0]);
  
end;

function TRoomerDataSet.Packageusage_Entities_GetBySql(sql: String): Array_Of_TPackageusageEntity;
var entities : Array_Of_TPackageusageEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageusage/getSql?sql=' + sql);
  list := processJson(res, 'TPackageusageEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackageusageEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packageusage_Entities_GetListByWhere(where: String): Array_Of_TPackageusageEntity;
var entities : Array_Of_TPackageusageEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageusage/getListByWhere?where=' + where);
  list := processJson(res, 'TPackageusageEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPackageusageEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Packageusage_Entities_GetEntityByWhere(where: String): TPackageusageEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'packageusage/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPackageusageEntity');
  result := TPackageusageEntity(list[0]);
  
end;

function TRoomerDataSet.Packageusage_Entities_SaveEntity(entity: TPackageusageEntity): TPackageusageEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'packageusage'), entity.json);
  result := TPackageusageEntity(processJson(src, 'TPackageusageEntity')[0]);
  
end;

function TRoomerDataSet.Packageusage_Entities_UpdateEntity(entity: TPackageusageEntity): TPackageusageEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'packageusage/' + inttostr(entity.Id)), entity.json);
  result := TPackageusageEntity(processJson(src, 'TPackageusageEntity')[0]);
  
end;

procedure TRoomerDataSet.Packageusage_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'packageusage/' + inttostr(id)));
  
end;

function TRoomerDataSet.Packageusage_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageusage');
end;

function TRoomerDataSet.Packageusage_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageusage/' + inttostr(id));
end;

function TRoomerDataSet.Packageusage_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'packageusage/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Packageusage_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'packageusage/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Packageusage_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageusage/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Packageusage_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageusage/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Packageusage_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'packageusage/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Packageusage_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'packageusage/execute', 'sql=' + sql);
end;


// ******************************* Paygroups **********************************

function TRoomerDataSet.Paygroups_Entities_FindAll(): Array_Of_TPaygroupsEntity;
var entities : Array_Of_TPaygroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'paygroups/findAll');
  list := processJson(res, 'TPaygroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPaygroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Paygroups_Entities_GetById(id: Integer): TPaygroupsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'paygroups/' + inttostr(id));
  list := processJson(res, 'TPaygroupsEntity');
  result := TPaygroupsEntity(list[0]);
  
end;

function TRoomerDataSet.Paygroups_Entities_GetBySql(sql: String): Array_Of_TPaygroupsEntity;
var entities : Array_Of_TPaygroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'paygroups/getSql?sql=' + sql);
  list := processJson(res, 'TPaygroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPaygroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Paygroups_Entities_GetListByWhere(where: String): Array_Of_TPaygroupsEntity;
var entities : Array_Of_TPaygroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'paygroups/getListByWhere?where=' + where);
  list := processJson(res, 'TPaygroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPaygroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Paygroups_Entities_GetEntityByWhere(where: String): TPaygroupsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'paygroups/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPaygroupsEntity');
  result := TPaygroupsEntity(list[0]);
  
end;

function TRoomerDataSet.Paygroups_Entities_SaveEntity(entity: TPaygroupsEntity): TPaygroupsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'paygroups'), entity.json);
  result := TPaygroupsEntity(processJson(src, 'TPaygroupsEntity')[0]);
  
end;

function TRoomerDataSet.Paygroups_Entities_UpdateEntity(entity: TPaygroupsEntity): TPaygroupsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'paygroups/' + inttostr(entity.Id)), entity.json);
  result := TPaygroupsEntity(processJson(src, 'TPaygroupsEntity')[0]);
  
end;

procedure TRoomerDataSet.Paygroups_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'paygroups/' + inttostr(id)));
  
end;

function TRoomerDataSet.Paygroups_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'paygroups');
end;

function TRoomerDataSet.Paygroups_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'paygroups/' + inttostr(id));
end;

function TRoomerDataSet.Paygroups_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'paygroups/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Paygroups_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'paygroups/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Paygroups_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'paygroups/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Paygroups_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'paygroups/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Paygroups_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'paygroups/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Paygroups_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'paygroups/execute', 'sql=' + sql);
end;


// ******************************* Payments **********************************

function TRoomerDataSet.Payments_Entities_FindAll(): Array_Of_TPaymentsEntity;
var entities : Array_Of_TPaymentsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'payments/findAll');
  list := processJson(res, 'TPaymentsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPaymentsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Payments_Entities_GetById(id: Integer): TPaymentsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'payments/' + inttostr(id));
  list := processJson(res, 'TPaymentsEntity');
  result := TPaymentsEntity(list[0]);
  
end;

function TRoomerDataSet.Payments_Entities_GetBySql(sql: String): Array_Of_TPaymentsEntity;
var entities : Array_Of_TPaymentsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'payments/getSql?sql=' + sql);
  list := processJson(res, 'TPaymentsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPaymentsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Payments_Entities_GetListByWhere(where: String): Array_Of_TPaymentsEntity;
var entities : Array_Of_TPaymentsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'payments/getListByWhere?where=' + where);
  list := processJson(res, 'TPaymentsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPaymentsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Payments_Entities_GetEntityByWhere(where: String): TPaymentsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'payments/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPaymentsEntity');
  result := TPaymentsEntity(list[0]);
  
end;

function TRoomerDataSet.Payments_Entities_SaveEntity(entity: TPaymentsEntity): TPaymentsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'payments'), entity.json);
  result := TPaymentsEntity(processJson(src, 'TPaymentsEntity')[0]);
  
end;

function TRoomerDataSet.Payments_Entities_UpdateEntity(entity: TPaymentsEntity): TPaymentsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'payments/' + inttostr(entity.Id)), entity.json);
  result := TPaymentsEntity(processJson(src, 'TPaymentsEntity')[0]);
  
end;

procedure TRoomerDataSet.Payments_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'payments/' + inttostr(id)));
  
end;

function TRoomerDataSet.Payments_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'payments');
end;

function TRoomerDataSet.Payments_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'payments/' + inttostr(id));
end;

function TRoomerDataSet.Payments_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'payments/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Payments_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'payments/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Payments_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'payments/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Payments_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'payments/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Payments_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'payments/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Payments_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'payments/execute', 'sql=' + sql);
end;


// ******************************* Paytypes **********************************

function TRoomerDataSet.Paytypes_Entities_FindAll(): Array_Of_TPaytypesEntity;
var entities : Array_Of_TPaytypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'paytypes/findAll');
  list := processJson(res, 'TPaytypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPaytypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Paytypes_Entities_GetById(id: Integer): TPaytypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'paytypes/' + inttostr(id));
  list := processJson(res, 'TPaytypesEntity');
  result := TPaytypesEntity(list[0]);
  
end;

function TRoomerDataSet.Paytypes_Entities_GetBySql(sql: String): Array_Of_TPaytypesEntity;
var entities : Array_Of_TPaytypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'paytypes/getSql?sql=' + sql);
  list := processJson(res, 'TPaytypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPaytypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Paytypes_Entities_GetListByWhere(where: String): Array_Of_TPaytypesEntity;
var entities : Array_Of_TPaytypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'paytypes/getListByWhere?where=' + where);
  list := processJson(res, 'TPaytypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPaytypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Paytypes_Entities_GetEntityByWhere(where: String): TPaytypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'paytypes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPaytypesEntity');
  result := TPaytypesEntity(list[0]);
  
end;

function TRoomerDataSet.Paytypes_Entities_SaveEntity(entity: TPaytypesEntity): TPaytypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'paytypes'), entity.json);
  result := TPaytypesEntity(processJson(src, 'TPaytypesEntity')[0]);
  
end;

function TRoomerDataSet.Paytypes_Entities_UpdateEntity(entity: TPaytypesEntity): TPaytypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'paytypes/' + inttostr(entity.Id)), entity.json);
  result := TPaytypesEntity(processJson(src, 'TPaytypesEntity')[0]);
  
end;

procedure TRoomerDataSet.Paytypes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'paytypes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Paytypes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'paytypes');
end;

function TRoomerDataSet.Paytypes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'paytypes/' + inttostr(id));
end;

function TRoomerDataSet.Paytypes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'paytypes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Paytypes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'paytypes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Paytypes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'paytypes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Paytypes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'paytypes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Paytypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'paytypes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Paytypes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'paytypes/execute', 'sql=' + sql);
end;


// ******************************* Person **********************************

function TRoomerDataSet.Person_Entities_FindAll(): Array_Of_TPersonEntity;
var entities : Array_Of_TPersonEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'person/findAll');
  list := processJson(res, 'TPersonEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Person_Entities_GetById(id: Integer): TPersonEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'person/' + inttostr(id));
  list := processJson(res, 'TPersonEntity');
  result := TPersonEntity(list[0]);
  
end;

function TRoomerDataSet.Person_Entities_GetBySql(sql: String): Array_Of_TPersonEntity;
var entities : Array_Of_TPersonEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'person/getSql?sql=' + sql);
  list := processJson(res, 'TPersonEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Person_Entities_GetListByWhere(where: String): Array_Of_TPersonEntity;
var entities : Array_Of_TPersonEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'person/getListByWhere?where=' + where);
  list := processJson(res, 'TPersonEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Person_Entities_GetEntityByWhere(where: String): TPersonEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'person/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPersonEntity');
  result := TPersonEntity(list[0]);
  
end;

function TRoomerDataSet.Person_Entities_SaveEntity(entity: TPersonEntity): TPersonEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'person'), entity.json);
  result := TPersonEntity(processJson(src, 'TPersonEntity')[0]);
  
end;

function TRoomerDataSet.Person_Entities_UpdateEntity(entity: TPersonEntity): TPersonEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'person/' + inttostr(entity.Id)), entity.json);
  result := TPersonEntity(processJson(src, 'TPersonEntity')[0]);
  
end;

procedure TRoomerDataSet.Person_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'person/' + inttostr(id)));
  
end;

function TRoomerDataSet.Person_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'person');
end;

function TRoomerDataSet.Person_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'person/' + inttostr(id));
end;

function TRoomerDataSet.Person_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'person/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Person_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'person/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Person_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'person/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Person_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'person/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Person_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'person/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Person_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'person/execute', 'sql=' + sql);
end;


// ******************************* Personaddress **********************************

function TRoomerDataSet.Personaddress_Entities_FindAll(): Array_Of_TPersonaddressEntity;
var entities : Array_Of_TPersonaddressEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personaddress/findAll');
  list := processJson(res, 'TPersonaddressEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonaddressEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personaddress_Entities_GetById(id: Integer): TPersonaddressEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personaddress/' + inttostr(id));
  list := processJson(res, 'TPersonaddressEntity');
  result := TPersonaddressEntity(list[0]);
  
end;

function TRoomerDataSet.Personaddress_Entities_GetBySql(sql: String): Array_Of_TPersonaddressEntity;
var entities : Array_Of_TPersonaddressEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personaddress/getSql?sql=' + sql);
  list := processJson(res, 'TPersonaddressEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonaddressEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personaddress_Entities_GetListByWhere(where: String): Array_Of_TPersonaddressEntity;
var entities : Array_Of_TPersonaddressEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personaddress/getListByWhere?where=' + where);
  list := processJson(res, 'TPersonaddressEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonaddressEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personaddress_Entities_GetEntityByWhere(where: String): TPersonaddressEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personaddress/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPersonaddressEntity');
  result := TPersonaddressEntity(list[0]);
  
end;

function TRoomerDataSet.Personaddress_Entities_SaveEntity(entity: TPersonaddressEntity): TPersonaddressEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personaddress'), entity.json);
  result := TPersonaddressEntity(processJson(src, 'TPersonaddressEntity')[0]);
  
end;

function TRoomerDataSet.Personaddress_Entities_UpdateEntity(entity: TPersonaddressEntity): TPersonaddressEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personaddress/' + inttostr(entity.Id)), entity.json);
  result := TPersonaddressEntity(processJson(src, 'TPersonaddressEntity')[0]);
  
end;

procedure TRoomerDataSet.Personaddress_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'personaddress/' + inttostr(id)));
  
end;

function TRoomerDataSet.Personaddress_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personaddress');
end;

function TRoomerDataSet.Personaddress_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personaddress/' + inttostr(id));
end;

function TRoomerDataSet.Personaddress_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'personaddress/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Personaddress_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personaddress/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Personaddress_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personaddress/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Personaddress_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personaddress/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Personaddress_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personaddress/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Personaddress_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personaddress/execute', 'sql=' + sql);
end;


// ******************************* Personchildren **********************************

function TRoomerDataSet.Personchildren_Entities_FindAll(): Array_Of_TPersonchildrenEntity;
var entities : Array_Of_TPersonchildrenEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personchildren/findAll');
  list := processJson(res, 'TPersonchildrenEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonchildrenEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personchildren_Entities_GetById(id: Integer): TPersonchildrenEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personchildren/' + inttostr(id));
  list := processJson(res, 'TPersonchildrenEntity');
  result := TPersonchildrenEntity(list[0]);
  
end;

function TRoomerDataSet.Personchildren_Entities_GetBySql(sql: String): Array_Of_TPersonchildrenEntity;
var entities : Array_Of_TPersonchildrenEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personchildren/getSql?sql=' + sql);
  list := processJson(res, 'TPersonchildrenEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonchildrenEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personchildren_Entities_GetListByWhere(where: String): Array_Of_TPersonchildrenEntity;
var entities : Array_Of_TPersonchildrenEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personchildren/getListByWhere?where=' + where);
  list := processJson(res, 'TPersonchildrenEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonchildrenEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personchildren_Entities_GetEntityByWhere(where: String): TPersonchildrenEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personchildren/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPersonchildrenEntity');
  result := TPersonchildrenEntity(list[0]);
  
end;

function TRoomerDataSet.Personchildren_Entities_SaveEntity(entity: TPersonchildrenEntity): TPersonchildrenEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personchildren'), entity.json);
  result := TPersonchildrenEntity(processJson(src, 'TPersonchildrenEntity')[0]);
  
end;

function TRoomerDataSet.Personchildren_Entities_UpdateEntity(entity: TPersonchildrenEntity): TPersonchildrenEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personchildren/' + inttostr(entity.Id)), entity.json);
  result := TPersonchildrenEntity(processJson(src, 'TPersonchildrenEntity')[0]);
  
end;

procedure TRoomerDataSet.Personchildren_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'personchildren/' + inttostr(id)));
  
end;

function TRoomerDataSet.Personchildren_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personchildren');
end;

function TRoomerDataSet.Personchildren_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personchildren/' + inttostr(id));
end;

function TRoomerDataSet.Personchildren_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'personchildren/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Personchildren_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personchildren/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Personchildren_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personchildren/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Personchildren_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personchildren/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Personchildren_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personchildren/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Personchildren_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personchildren/execute', 'sql=' + sql);
end;


// ******************************* Personcontact **********************************

function TRoomerDataSet.Personcontact_Entities_FindAll(): Array_Of_TPersoncontactEntity;
var entities : Array_Of_TPersoncontactEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personcontact/findAll');
  list := processJson(res, 'TPersoncontactEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersoncontactEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personcontact_Entities_GetById(id: Integer): TPersoncontactEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personcontact/' + inttostr(id));
  list := processJson(res, 'TPersoncontactEntity');
  result := TPersoncontactEntity(list[0]);
  
end;

function TRoomerDataSet.Personcontact_Entities_GetBySql(sql: String): Array_Of_TPersoncontactEntity;
var entities : Array_Of_TPersoncontactEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personcontact/getSql?sql=' + sql);
  list := processJson(res, 'TPersoncontactEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersoncontactEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personcontact_Entities_GetListByWhere(where: String): Array_Of_TPersoncontactEntity;
var entities : Array_Of_TPersoncontactEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personcontact/getListByWhere?where=' + where);
  list := processJson(res, 'TPersoncontactEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersoncontactEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personcontact_Entities_GetEntityByWhere(where: String): TPersoncontactEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personcontact/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPersoncontactEntity');
  result := TPersoncontactEntity(list[0]);
  
end;

function TRoomerDataSet.Personcontact_Entities_SaveEntity(entity: TPersoncontactEntity): TPersoncontactEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personcontact'), entity.json);
  result := TPersoncontactEntity(processJson(src, 'TPersoncontactEntity')[0]);
  
end;

function TRoomerDataSet.Personcontact_Entities_UpdateEntity(entity: TPersoncontactEntity): TPersoncontactEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personcontact/' + inttostr(entity.Id)), entity.json);
  result := TPersoncontactEntity(processJson(src, 'TPersoncontactEntity')[0]);
  
end;

procedure TRoomerDataSet.Personcontact_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'personcontact/' + inttostr(id)));
  
end;

function TRoomerDataSet.Personcontact_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personcontact');
end;

function TRoomerDataSet.Personcontact_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personcontact/' + inttostr(id));
end;

function TRoomerDataSet.Personcontact_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'personcontact/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Personcontact_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personcontact/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Personcontact_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personcontact/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Personcontact_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personcontact/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Personcontact_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personcontact/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Personcontact_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personcontact/execute', 'sql=' + sql);
end;


// ******************************* Personcontacttype **********************************

function TRoomerDataSet.Personcontacttype_Entities_FindAll(): Array_Of_TPersoncontacttypeEntity;
var entities : Array_Of_TPersoncontacttypeEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personcontacttype/findAll');
  list := processJson(res, 'TPersoncontacttypeEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersoncontacttypeEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personcontacttype_Entities_GetById(id: Integer): TPersoncontacttypeEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personcontacttype/' + inttostr(id));
  list := processJson(res, 'TPersoncontacttypeEntity');
  result := TPersoncontacttypeEntity(list[0]);
  
end;

function TRoomerDataSet.Personcontacttype_Entities_GetBySql(sql: String): Array_Of_TPersoncontacttypeEntity;
var entities : Array_Of_TPersoncontacttypeEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personcontacttype/getSql?sql=' + sql);
  list := processJson(res, 'TPersoncontacttypeEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersoncontacttypeEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personcontacttype_Entities_GetListByWhere(where: String): Array_Of_TPersoncontacttypeEntity;
var entities : Array_Of_TPersoncontacttypeEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personcontacttype/getListByWhere?where=' + where);
  list := processJson(res, 'TPersoncontacttypeEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersoncontacttypeEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personcontacttype_Entities_GetEntityByWhere(where: String): TPersoncontacttypeEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personcontacttype/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPersoncontacttypeEntity');
  result := TPersoncontacttypeEntity(list[0]);
  
end;

function TRoomerDataSet.Personcontacttype_Entities_SaveEntity(entity: TPersoncontacttypeEntity): TPersoncontacttypeEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personcontacttype'), entity.json);
  result := TPersoncontacttypeEntity(processJson(src, 'TPersoncontacttypeEntity')[0]);
  
end;

function TRoomerDataSet.Personcontacttype_Entities_UpdateEntity(entity: TPersoncontacttypeEntity): TPersoncontacttypeEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personcontacttype/' + inttostr(entity.Id)), entity.json);
  result := TPersoncontacttypeEntity(processJson(src, 'TPersoncontacttypeEntity')[0]);
  
end;

procedure TRoomerDataSet.Personcontacttype_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'personcontacttype/' + inttostr(id)));
  
end;

function TRoomerDataSet.Personcontacttype_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personcontacttype');
end;

function TRoomerDataSet.Personcontacttype_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personcontacttype/' + inttostr(id));
end;

function TRoomerDataSet.Personcontacttype_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'personcontacttype/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Personcontacttype_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personcontacttype/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Personcontacttype_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personcontacttype/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Personcontacttype_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personcontacttype/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Personcontacttype_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personcontacttype/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Personcontacttype_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personcontacttype/execute', 'sql=' + sql);
end;


// ******************************* Personitems **********************************

function TRoomerDataSet.Personitems_Entities_FindAll(): Array_Of_TPersonitemsEntity;
var entities : Array_Of_TPersonitemsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personitems/findAll');
  list := processJson(res, 'TPersonitemsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonitemsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personitems_Entities_GetById(id: Integer): TPersonitemsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personitems/' + inttostr(id));
  list := processJson(res, 'TPersonitemsEntity');
  result := TPersonitemsEntity(list[0]);
  
end;

function TRoomerDataSet.Personitems_Entities_GetBySql(sql: String): Array_Of_TPersonitemsEntity;
var entities : Array_Of_TPersonitemsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personitems/getSql?sql=' + sql);
  list := processJson(res, 'TPersonitemsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonitemsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personitems_Entities_GetListByWhere(where: String): Array_Of_TPersonitemsEntity;
var entities : Array_Of_TPersonitemsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personitems/getListByWhere?where=' + where);
  list := processJson(res, 'TPersonitemsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonitemsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personitems_Entities_GetEntityByWhere(where: String): TPersonitemsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personitems/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPersonitemsEntity');
  result := TPersonitemsEntity(list[0]);
  
end;

function TRoomerDataSet.Personitems_Entities_SaveEntity(entity: TPersonitemsEntity): TPersonitemsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personitems'), entity.json);
  result := TPersonitemsEntity(processJson(src, 'TPersonitemsEntity')[0]);
  
end;

function TRoomerDataSet.Personitems_Entities_UpdateEntity(entity: TPersonitemsEntity): TPersonitemsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personitems/' + inttostr(entity.Id)), entity.json);
  result := TPersonitemsEntity(processJson(src, 'TPersonitemsEntity')[0]);
  
end;

procedure TRoomerDataSet.Personitems_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'personitems/' + inttostr(id)));
  
end;

function TRoomerDataSet.Personitems_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personitems');
end;

function TRoomerDataSet.Personitems_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personitems/' + inttostr(id));
end;

function TRoomerDataSet.Personitems_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'personitems/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Personitems_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personitems/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Personitems_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personitems/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Personitems_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personitems/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Personitems_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personitems/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Personitems_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personitems/execute', 'sql=' + sql);
end;


// ******************************* Personprofile **********************************

function TRoomerDataSet.Personprofile_Entities_FindAll(): Array_Of_TPersonprofileEntity;
var entities : Array_Of_TPersonprofileEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personprofile/findAll');
  list := processJson(res, 'TPersonprofileEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonprofileEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personprofile_Entities_GetById(id: Integer): TPersonprofileEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personprofile/' + inttostr(id));
  list := processJson(res, 'TPersonprofileEntity');
  result := TPersonprofileEntity(list[0]);
  
end;

function TRoomerDataSet.Personprofile_Entities_GetBySql(sql: String): Array_Of_TPersonprofileEntity;
var entities : Array_Of_TPersonprofileEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personprofile/getSql?sql=' + sql);
  list := processJson(res, 'TPersonprofileEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonprofileEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personprofile_Entities_GetListByWhere(where: String): Array_Of_TPersonprofileEntity;
var entities : Array_Of_TPersonprofileEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personprofile/getListByWhere?where=' + where);
  list := processJson(res, 'TPersonprofileEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonprofileEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personprofile_Entities_GetEntityByWhere(where: String): TPersonprofileEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personprofile/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPersonprofileEntity');
  result := TPersonprofileEntity(list[0]);
  
end;

function TRoomerDataSet.Personprofile_Entities_SaveEntity(entity: TPersonprofileEntity): TPersonprofileEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personprofile'), entity.json);
  result := TPersonprofileEntity(processJson(src, 'TPersonprofileEntity')[0]);
  
end;

function TRoomerDataSet.Personprofile_Entities_UpdateEntity(entity: TPersonprofileEntity): TPersonprofileEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personprofile/' + inttostr(entity.Id)), entity.json);
  result := TPersonprofileEntity(processJson(src, 'TPersonprofileEntity')[0]);
  
end;

procedure TRoomerDataSet.Personprofile_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'personprofile/' + inttostr(id)));
  
end;

function TRoomerDataSet.Personprofile_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personprofile');
end;

function TRoomerDataSet.Personprofile_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personprofile/' + inttostr(id));
end;

function TRoomerDataSet.Personprofile_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'personprofile/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Personprofile_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personprofile/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Personprofile_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personprofile/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Personprofile_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personprofile/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Personprofile_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personprofile/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Personprofile_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personprofile/execute', 'sql=' + sql);
end;


// ******************************* Persons **********************************

function TRoomerDataSet.Persons_Entities_FindAll(): Array_Of_TPersonsEntity;
var entities : Array_Of_TPersonsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'persons/findAll');
  list := processJson(res, 'TPersonsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Persons_Entities_GetById(id: Integer): TPersonsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'persons/' + inttostr(id));
  list := processJson(res, 'TPersonsEntity');
  result := TPersonsEntity(list[0]);
  
end;

function TRoomerDataSet.Persons_Entities_GetBySql(sql: String): Array_Of_TPersonsEntity;
var entities : Array_Of_TPersonsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'persons/getSql?sql=' + sql);
  list := processJson(res, 'TPersonsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Persons_Entities_GetListByWhere(where: String): Array_Of_TPersonsEntity;
var entities : Array_Of_TPersonsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'persons/getListByWhere?where=' + where);
  list := processJson(res, 'TPersonsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Persons_Entities_GetEntityByWhere(where: String): TPersonsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'persons/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPersonsEntity');
  result := TPersonsEntity(list[0]);
  
end;

function TRoomerDataSet.Persons_Entities_SaveEntity(entity: TPersonsEntity): TPersonsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'persons'), entity.json);
  result := TPersonsEntity(processJson(src, 'TPersonsEntity')[0]);
  
end;

function TRoomerDataSet.Persons_Entities_UpdateEntity(entity: TPersonsEntity): TPersonsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'persons/' + inttostr(entity.Id)), entity.json);
  result := TPersonsEntity(processJson(src, 'TPersonsEntity')[0]);
  
end;

procedure TRoomerDataSet.Persons_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'persons/' + inttostr(id)));
  
end;

function TRoomerDataSet.Persons_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'persons');
end;

function TRoomerDataSet.Persons_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'persons/' + inttostr(id));
end;

function TRoomerDataSet.Persons_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'persons/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Persons_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'persons/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Persons_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'persons/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Persons_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'persons/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Persons_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'persons/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Persons_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'persons/execute', 'sql=' + sql);
end;


// ******************************* Personviptypes **********************************

function TRoomerDataSet.Personviptypes_Entities_FindAll(): Array_Of_TPersonviptypesEntity;
var entities : Array_Of_TPersonviptypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personviptypes/findAll');
  list := processJson(res, 'TPersonviptypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonviptypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personviptypes_Entities_GetById(id: Integer): TPersonviptypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personviptypes/' + inttostr(id));
  list := processJson(res, 'TPersonviptypesEntity');
  result := TPersonviptypesEntity(list[0]);
  
end;

function TRoomerDataSet.Personviptypes_Entities_GetBySql(sql: String): Array_Of_TPersonviptypesEntity;
var entities : Array_Of_TPersonviptypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personviptypes/getSql?sql=' + sql);
  list := processJson(res, 'TPersonviptypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonviptypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personviptypes_Entities_GetListByWhere(where: String): Array_Of_TPersonviptypesEntity;
var entities : Array_Of_TPersonviptypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personviptypes/getListByWhere?where=' + where);
  list := processJson(res, 'TPersonviptypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPersonviptypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Personviptypes_Entities_GetEntityByWhere(where: String): TPersonviptypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'personviptypes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPersonviptypesEntity');
  result := TPersonviptypesEntity(list[0]);
  
end;

function TRoomerDataSet.Personviptypes_Entities_SaveEntity(entity: TPersonviptypesEntity): TPersonviptypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personviptypes'), entity.json);
  result := TPersonviptypesEntity(processJson(src, 'TPersonviptypesEntity')[0]);
  
end;

function TRoomerDataSet.Personviptypes_Entities_UpdateEntity(entity: TPersonviptypesEntity): TPersonviptypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'personviptypes/' + inttostr(entity.Id)), entity.json);
  result := TPersonviptypesEntity(processJson(src, 'TPersonviptypesEntity')[0]);
  
end;

procedure TRoomerDataSet.Personviptypes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'personviptypes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Personviptypes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personviptypes');
end;

function TRoomerDataSet.Personviptypes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personviptypes/' + inttostr(id));
end;

function TRoomerDataSet.Personviptypes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'personviptypes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Personviptypes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personviptypes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Personviptypes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personviptypes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Personviptypes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personviptypes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Personviptypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'personviptypes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Personviptypes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'personviptypes/execute', 'sql=' + sql);
end;


// ******************************* Predefineddates **********************************

function TRoomerDataSet.Predefineddates_Entities_FindAll(): Array_Of_TPredefineddatesEntity;
var entities : Array_Of_TPredefineddatesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'predefineddates/findAll');
  list := processJson(res, 'TPredefineddatesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPredefineddatesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Predefineddates_Entities_GetById(id: Integer): TPredefineddatesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'predefineddates/' + inttostr(id));
  list := processJson(res, 'TPredefineddatesEntity');
  result := TPredefineddatesEntity(list[0]);
  
end;

function TRoomerDataSet.Predefineddates_Entities_GetBySql(sql: String): Array_Of_TPredefineddatesEntity;
var entities : Array_Of_TPredefineddatesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'predefineddates/getSql?sql=' + sql);
  list := processJson(res, 'TPredefineddatesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPredefineddatesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Predefineddates_Entities_GetListByWhere(where: String): Array_Of_TPredefineddatesEntity;
var entities : Array_Of_TPredefineddatesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'predefineddates/getListByWhere?where=' + where);
  list := processJson(res, 'TPredefineddatesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPredefineddatesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Predefineddates_Entities_GetEntityByWhere(where: String): TPredefineddatesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'predefineddates/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPredefineddatesEntity');
  result := TPredefineddatesEntity(list[0]);
  
end;

function TRoomerDataSet.Predefineddates_Entities_SaveEntity(entity: TPredefineddatesEntity): TPredefineddatesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'predefineddates'), entity.json);
  result := TPredefineddatesEntity(processJson(src, 'TPredefineddatesEntity')[0]);
  
end;

function TRoomerDataSet.Predefineddates_Entities_UpdateEntity(entity: TPredefineddatesEntity): TPredefineddatesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'predefineddates/' + inttostr(entity.Id)), entity.json);
  result := TPredefineddatesEntity(processJson(src, 'TPredefineddatesEntity')[0]);
  
end;

procedure TRoomerDataSet.Predefineddates_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'predefineddates/' + inttostr(id)));
  
end;

function TRoomerDataSet.Predefineddates_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'predefineddates');
end;

function TRoomerDataSet.Predefineddates_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'predefineddates/' + inttostr(id));
end;

function TRoomerDataSet.Predefineddates_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'predefineddates/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Predefineddates_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'predefineddates/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Predefineddates_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'predefineddates/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Predefineddates_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'predefineddates/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Predefineddates_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'predefineddates/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Predefineddates_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'predefineddates/execute', 'sql=' + sql);
end;


// ******************************* Pricerules **********************************

function TRoomerDataSet.Pricerules_Entities_FindAll(): Array_Of_TPricerulesEntity;
var entities : Array_Of_TPricerulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricerules/findAll');
  list := processJson(res, 'TPricerulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPricerulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Pricerules_Entities_GetById(id: Integer): TPricerulesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricerules/' + inttostr(id));
  list := processJson(res, 'TPricerulesEntity');
  result := TPricerulesEntity(list[0]);
  
end;

function TRoomerDataSet.Pricerules_Entities_GetBySql(sql: String): Array_Of_TPricerulesEntity;
var entities : Array_Of_TPricerulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricerules/getSql?sql=' + sql);
  list := processJson(res, 'TPricerulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPricerulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Pricerules_Entities_GetListByWhere(where: String): Array_Of_TPricerulesEntity;
var entities : Array_Of_TPricerulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricerules/getListByWhere?where=' + where);
  list := processJson(res, 'TPricerulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPricerulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Pricerules_Entities_GetEntityByWhere(where: String): TPricerulesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricerules/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPricerulesEntity');
  result := TPricerulesEntity(list[0]);
  
end;

function TRoomerDataSet.Pricerules_Entities_SaveEntity(entity: TPricerulesEntity): TPricerulesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'pricerules'), entity.json);
  result := TPricerulesEntity(processJson(src, 'TPricerulesEntity')[0]);
  
end;

function TRoomerDataSet.Pricerules_Entities_UpdateEntity(entity: TPricerulesEntity): TPricerulesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'pricerules/' + inttostr(entity.Id)), entity.json);
  result := TPricerulesEntity(processJson(src, 'TPricerulesEntity')[0]);
  
end;

procedure TRoomerDataSet.Pricerules_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'pricerules/' + inttostr(id)));
  
end;

function TRoomerDataSet.Pricerules_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricerules');
end;

function TRoomerDataSet.Pricerules_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricerules/' + inttostr(id));
end;

function TRoomerDataSet.Pricerules_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'pricerules/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Pricerules_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'pricerules/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Pricerules_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricerules/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Pricerules_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricerules/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Pricerules_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricerules/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Pricerules_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'pricerules/execute', 'sql=' + sql);
end;


// ******************************* Pricerulespackages **********************************

function TRoomerDataSet.Pricerulespackages_Entities_FindAll(): Array_Of_TPricerulespackagesEntity;
var entities : Array_Of_TPricerulespackagesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricerulespackages/findAll');
  list := processJson(res, 'TPricerulespackagesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPricerulespackagesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Pricerulespackages_Entities_GetById(id: Integer): TPricerulespackagesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricerulespackages/' + inttostr(id));
  list := processJson(res, 'TPricerulespackagesEntity');
  result := TPricerulespackagesEntity(list[0]);
  
end;

function TRoomerDataSet.Pricerulespackages_Entities_GetBySql(sql: String): Array_Of_TPricerulespackagesEntity;
var entities : Array_Of_TPricerulespackagesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricerulespackages/getSql?sql=' + sql);
  list := processJson(res, 'TPricerulespackagesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPricerulespackagesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Pricerulespackages_Entities_GetListByWhere(where: String): Array_Of_TPricerulespackagesEntity;
var entities : Array_Of_TPricerulespackagesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricerulespackages/getListByWhere?where=' + where);
  list := processJson(res, 'TPricerulespackagesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPricerulespackagesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Pricerulespackages_Entities_GetEntityByWhere(where: String): TPricerulespackagesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricerulespackages/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPricerulespackagesEntity');
  result := TPricerulespackagesEntity(list[0]);
  
end;

function TRoomerDataSet.Pricerulespackages_Entities_SaveEntity(entity: TPricerulespackagesEntity): TPricerulespackagesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'pricerulespackages'), entity.json);
  result := TPricerulespackagesEntity(processJson(src, 'TPricerulespackagesEntity')[0]);
  
end;

function TRoomerDataSet.Pricerulespackages_Entities_UpdateEntity(entity: TPricerulespackagesEntity): TPricerulespackagesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'pricerulespackages/' + inttostr(entity.Id)), entity.json);
  result := TPricerulespackagesEntity(processJson(src, 'TPricerulespackagesEntity')[0]);
  
end;

procedure TRoomerDataSet.Pricerulespackages_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'pricerulespackages/' + inttostr(id)));
  
end;

function TRoomerDataSet.Pricerulespackages_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricerulespackages');
end;

function TRoomerDataSet.Pricerulespackages_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricerulespackages/' + inttostr(id));
end;

function TRoomerDataSet.Pricerulespackages_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'pricerulespackages/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Pricerulespackages_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'pricerulespackages/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Pricerulespackages_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricerulespackages/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Pricerulespackages_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricerulespackages/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Pricerulespackages_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricerulespackages/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Pricerulespackages_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'pricerulespackages/execute', 'sql=' + sql);
end;


// ******************************* Pricetypes **********************************

function TRoomerDataSet.Pricetypes_Entities_FindAll(): Array_Of_TPricetypesEntity;
var entities : Array_Of_TPricetypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricetypes/findAll');
  list := processJson(res, 'TPricetypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPricetypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Pricetypes_Entities_GetById(id: Integer): TPricetypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricetypes/' + inttostr(id));
  list := processJson(res, 'TPricetypesEntity');
  result := TPricetypesEntity(list[0]);
  
end;

function TRoomerDataSet.Pricetypes_Entities_GetBySql(sql: String): Array_Of_TPricetypesEntity;
var entities : Array_Of_TPricetypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricetypes/getSql?sql=' + sql);
  list := processJson(res, 'TPricetypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPricetypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Pricetypes_Entities_GetListByWhere(where: String): Array_Of_TPricetypesEntity;
var entities : Array_Of_TPricetypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricetypes/getListByWhere?where=' + where);
  list := processJson(res, 'TPricetypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPricetypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Pricetypes_Entities_GetEntityByWhere(where: String): TPricetypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'pricetypes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPricetypesEntity');
  result := TPricetypesEntity(list[0]);
  
end;

function TRoomerDataSet.Pricetypes_Entities_SaveEntity(entity: TPricetypesEntity): TPricetypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'pricetypes'), entity.json);
  result := TPricetypesEntity(processJson(src, 'TPricetypesEntity')[0]);
  
end;

function TRoomerDataSet.Pricetypes_Entities_UpdateEntity(entity: TPricetypesEntity): TPricetypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'pricetypes/' + inttostr(entity.Id)), entity.json);
  result := TPricetypesEntity(processJson(src, 'TPricetypesEntity')[0]);
  
end;

procedure TRoomerDataSet.Pricetypes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'pricetypes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Pricetypes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricetypes');
end;

function TRoomerDataSet.Pricetypes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricetypes/' + inttostr(id));
end;

function TRoomerDataSet.Pricetypes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'pricetypes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Pricetypes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'pricetypes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Pricetypes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricetypes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Pricetypes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricetypes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Pricetypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'pricetypes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Pricetypes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'pricetypes/execute', 'sql=' + sql);
end;


// ******************************* Propertiesstore **********************************

function TRoomerDataSet.Propertiesstore_Entities_FindAll(): Array_Of_TPropertiesstoreEntity;
var entities : Array_Of_TPropertiesstoreEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'propertiesstore/findAll');
  list := processJson(res, 'TPropertiesstoreEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPropertiesstoreEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Propertiesstore_Entities_GetById(id: Integer): TPropertiesstoreEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'propertiesstore/' + inttostr(id));
  list := processJson(res, 'TPropertiesstoreEntity');
  result := TPropertiesstoreEntity(list[0]);
  
end;

function TRoomerDataSet.Propertiesstore_Entities_GetBySql(sql: String): Array_Of_TPropertiesstoreEntity;
var entities : Array_Of_TPropertiesstoreEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'propertiesstore/getSql?sql=' + sql);
  list := processJson(res, 'TPropertiesstoreEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPropertiesstoreEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Propertiesstore_Entities_GetListByWhere(where: String): Array_Of_TPropertiesstoreEntity;
var entities : Array_Of_TPropertiesstoreEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'propertiesstore/getListByWhere?where=' + where);
  list := processJson(res, 'TPropertiesstoreEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TPropertiesstoreEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Propertiesstore_Entities_GetEntityByWhere(where: String): TPropertiesstoreEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'propertiesstore/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TPropertiesstoreEntity');
  result := TPropertiesstoreEntity(list[0]);
  
end;

function TRoomerDataSet.Propertiesstore_Entities_SaveEntity(entity: TPropertiesstoreEntity): TPropertiesstoreEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'propertiesstore'), entity.json);
  result := TPropertiesstoreEntity(processJson(src, 'TPropertiesstoreEntity')[0]);
  
end;

function TRoomerDataSet.Propertiesstore_Entities_UpdateEntity(entity: TPropertiesstoreEntity): TPropertiesstoreEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'propertiesstore/' + inttostr(entity.Id)), entity.json);
  result := TPropertiesstoreEntity(processJson(src, 'TPropertiesstoreEntity')[0]);
  
end;

procedure TRoomerDataSet.Propertiesstore_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'propertiesstore/' + inttostr(id)));
  
end;

function TRoomerDataSet.Propertiesstore_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'propertiesstore');
end;

function TRoomerDataSet.Propertiesstore_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'propertiesstore/' + inttostr(id));
end;

function TRoomerDataSet.Propertiesstore_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'propertiesstore/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Propertiesstore_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'propertiesstore/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Propertiesstore_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'propertiesstore/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Propertiesstore_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'propertiesstore/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Propertiesstore_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'propertiesstore/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Propertiesstore_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'propertiesstore/execute', 'sql=' + sql);
end;


// ******************************* Rates **********************************

function TRoomerDataSet.Rates_Entities_FindAll(): Array_Of_TRatesEntity;
var entities : Array_Of_TRatesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'rates/findAll');
  list := processJson(res, 'TRatesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRatesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Rates_Entities_GetById(id: Integer): TRatesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'rates/' + inttostr(id));
  list := processJson(res, 'TRatesEntity');
  result := TRatesEntity(list[0]);
  
end;

function TRoomerDataSet.Rates_Entities_GetBySql(sql: String): Array_Of_TRatesEntity;
var entities : Array_Of_TRatesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'rates/getSql?sql=' + sql);
  list := processJson(res, 'TRatesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRatesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Rates_Entities_GetListByWhere(where: String): Array_Of_TRatesEntity;
var entities : Array_Of_TRatesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'rates/getListByWhere?where=' + where);
  list := processJson(res, 'TRatesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRatesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Rates_Entities_GetEntityByWhere(where: String): TRatesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'rates/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRatesEntity');
  result := TRatesEntity(list[0]);
  
end;

function TRoomerDataSet.Rates_Entities_SaveEntity(entity: TRatesEntity): TRatesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'rates'), entity.json);
  result := TRatesEntity(processJson(src, 'TRatesEntity')[0]);
  
end;

function TRoomerDataSet.Rates_Entities_UpdateEntity(entity: TRatesEntity): TRatesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'rates/' + inttostr(entity.Id)), entity.json);
  result := TRatesEntity(processJson(src, 'TRatesEntity')[0]);
  
end;

procedure TRoomerDataSet.Rates_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'rates/' + inttostr(id)));
  
end;

function TRoomerDataSet.Rates_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'rates');
end;

function TRoomerDataSet.Rates_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'rates/' + inttostr(id));
end;

function TRoomerDataSet.Rates_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'rates/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Rates_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'rates/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Rates_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'rates/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Rates_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'rates/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Rates_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'rates/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Rates_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'rates/execute', 'sql=' + sql);
end;


// ******************************* Reservations **********************************

function TRoomerDataSet.Reservations_Entities_FindAll(): Array_Of_TReservationsEntity;
var entities : Array_Of_TReservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'reservations/findAll');
  list := processJson(res, 'TReservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TReservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Reservations_Entities_GetById(id: Integer): TReservationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'reservations/' + inttostr(id));
  list := processJson(res, 'TReservationsEntity');
  result := TReservationsEntity(list[0]);
  
end;

function TRoomerDataSet.Reservations_Entities_GetBySql(sql: String): Array_Of_TReservationsEntity;
var entities : Array_Of_TReservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'reservations/getSql?sql=' + sql);
  list := processJson(res, 'TReservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TReservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Reservations_Entities_GetListByWhere(where: String): Array_Of_TReservationsEntity;
var entities : Array_Of_TReservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'reservations/getListByWhere?where=' + where);
  list := processJson(res, 'TReservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TReservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Reservations_Entities_GetEntityByWhere(where: String): TReservationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'reservations/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TReservationsEntity');
  result := TReservationsEntity(list[0]);
  
end;

function TRoomerDataSet.Reservations_Entities_SaveEntity(entity: TReservationsEntity): TReservationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'reservations'), entity.json);
  result := TReservationsEntity(processJson(src, 'TReservationsEntity')[0]);
  
end;

function TRoomerDataSet.Reservations_Entities_UpdateEntity(entity: TReservationsEntity): TReservationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'reservations/' + inttostr(entity.Id)), entity.json);
  result := TReservationsEntity(processJson(src, 'TReservationsEntity')[0]);
  
end;

procedure TRoomerDataSet.Reservations_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'reservations/' + inttostr(id)));
  
end;

function TRoomerDataSet.Reservations_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'reservations');
end;

function TRoomerDataSet.Reservations_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'reservations/' + inttostr(id));
end;

function TRoomerDataSet.Reservations_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'reservations/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Reservations_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'reservations/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Reservations_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'reservations/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Reservations_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'reservations/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Reservations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'reservations/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Reservations_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'reservations/execute', 'sql=' + sql);
end;


// ******************************* Roomamenities **********************************

function TRoomerDataSet.Roomamenities_Entities_FindAll(): Array_Of_TRoomamenitiesEntity;
var entities : Array_Of_TRoomamenitiesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomamenities/findAll');
  list := processJson(res, 'TRoomamenitiesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomamenitiesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomamenities_Entities_GetById(id: Integer): TRoomamenitiesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomamenities/' + inttostr(id));
  list := processJson(res, 'TRoomamenitiesEntity');
  result := TRoomamenitiesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomamenities_Entities_GetBySql(sql: String): Array_Of_TRoomamenitiesEntity;
var entities : Array_Of_TRoomamenitiesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomamenities/getSql?sql=' + sql);
  list := processJson(res, 'TRoomamenitiesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomamenitiesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomamenities_Entities_GetListByWhere(where: String): Array_Of_TRoomamenitiesEntity;
var entities : Array_Of_TRoomamenitiesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomamenities/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomamenitiesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomamenitiesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomamenities_Entities_GetEntityByWhere(where: String): TRoomamenitiesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomamenities/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomamenitiesEntity');
  result := TRoomamenitiesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomamenities_Entities_SaveEntity(entity: TRoomamenitiesEntity): TRoomamenitiesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomamenities'), entity.json);
  result := TRoomamenitiesEntity(processJson(src, 'TRoomamenitiesEntity')[0]);
  
end;

function TRoomerDataSet.Roomamenities_Entities_UpdateEntity(entity: TRoomamenitiesEntity): TRoomamenitiesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomamenities/' + inttostr(entity.Id)), entity.json);
  result := TRoomamenitiesEntity(processJson(src, 'TRoomamenitiesEntity')[0]);
  
end;

procedure TRoomerDataSet.Roomamenities_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'roomamenities/' + inttostr(id)));
  
end;

function TRoomerDataSet.Roomamenities_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomamenities');
end;

function TRoomerDataSet.Roomamenities_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomamenities/' + inttostr(id));
end;

function TRoomerDataSet.Roomamenities_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'roomamenities/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Roomamenities_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomamenities/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Roomamenities_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomamenities/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Roomamenities_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomamenities/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Roomamenities_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomamenities/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Roomamenities_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomamenities/execute', 'sql=' + sql);
end;


// ******************************* Roomermessages **********************************

function TRoomerDataSet.Roomermessages_Entities_FindAll(): Array_Of_TRoomermessagesEntity;
var entities : Array_Of_TRoomermessagesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomermessages/findAll');
  list := processJson(res, 'TRoomermessagesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomermessagesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomermessages_Entities_GetById(id: Integer): TRoomermessagesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomermessages/' + inttostr(id));
  list := processJson(res, 'TRoomermessagesEntity');
  result := TRoomermessagesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomermessages_Entities_GetBySql(sql: String): Array_Of_TRoomermessagesEntity;
var entities : Array_Of_TRoomermessagesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomermessages/getSql?sql=' + sql);
  list := processJson(res, 'TRoomermessagesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomermessagesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomermessages_Entities_GetListByWhere(where: String): Array_Of_TRoomermessagesEntity;
var entities : Array_Of_TRoomermessagesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomermessages/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomermessagesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomermessagesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomermessages_Entities_GetEntityByWhere(where: String): TRoomermessagesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomermessages/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomermessagesEntity');
  result := TRoomermessagesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomermessages_Entities_SaveEntity(entity: TRoomermessagesEntity): TRoomermessagesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomermessages'), entity.json);
  result := TRoomermessagesEntity(processJson(src, 'TRoomermessagesEntity')[0]);
  
end;

function TRoomerDataSet.Roomermessages_Entities_UpdateEntity(entity: TRoomermessagesEntity): TRoomermessagesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomermessages/' + inttostr(entity.Id)), entity.json);
  result := TRoomermessagesEntity(processJson(src, 'TRoomermessagesEntity')[0]);
  
end;

procedure TRoomerDataSet.Roomermessages_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'roomermessages/' + inttostr(id)));
  
end;

function TRoomerDataSet.Roomermessages_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomermessages');
end;

function TRoomerDataSet.Roomermessages_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomermessages/' + inttostr(id));
end;

function TRoomerDataSet.Roomermessages_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'roomermessages/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Roomermessages_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomermessages/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Roomermessages_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomermessages/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Roomermessages_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomermessages/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Roomermessages_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomermessages/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Roomermessages_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomermessages/execute', 'sql=' + sql);
end;


// ******************************* Roomrates **********************************

function TRoomerDataSet.Roomrates_Entities_FindAll(): Array_Of_TRoomratesEntity;
var entities : Array_Of_TRoomratesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomrates/findAll');
  list := processJson(res, 'TRoomratesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomratesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomrates_Entities_GetById(id: Integer): TRoomratesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomrates/' + inttostr(id));
  list := processJson(res, 'TRoomratesEntity');
  result := TRoomratesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomrates_Entities_GetBySql(sql: String): Array_Of_TRoomratesEntity;
var entities : Array_Of_TRoomratesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomrates/getSql?sql=' + sql);
  list := processJson(res, 'TRoomratesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomratesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomrates_Entities_GetListByWhere(where: String): Array_Of_TRoomratesEntity;
var entities : Array_Of_TRoomratesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomrates/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomratesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomratesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomrates_Entities_GetEntityByWhere(where: String): TRoomratesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomrates/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomratesEntity');
  result := TRoomratesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomrates_Entities_SaveEntity(entity: TRoomratesEntity): TRoomratesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomrates'), entity.json);
  result := TRoomratesEntity(processJson(src, 'TRoomratesEntity')[0]);
  
end;

function TRoomerDataSet.Roomrates_Entities_UpdateEntity(entity: TRoomratesEntity): TRoomratesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomrates/' + inttostr(entity.Id)), entity.json);
  result := TRoomratesEntity(processJson(src, 'TRoomratesEntity')[0]);
  
end;

procedure TRoomerDataSet.Roomrates_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'roomrates/' + inttostr(id)));
  
end;

function TRoomerDataSet.Roomrates_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomrates');
end;

function TRoomerDataSet.Roomrates_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomrates/' + inttostr(id));
end;

function TRoomerDataSet.Roomrates_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'roomrates/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Roomrates_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomrates/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Roomrates_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomrates/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Roomrates_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomrates/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Roomrates_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomrates/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Roomrates_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomrates/execute', 'sql=' + sql);
end;


// ******************************* Roomreservations **********************************

function TRoomerDataSet.Roomreservations_Entities_FindAll(): Array_Of_TRoomreservationsEntity;
var entities : Array_Of_TRoomreservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomreservations/findAll');
  list := processJson(res, 'TRoomreservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomreservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomreservations_Entities_GetById(id: Integer): TRoomreservationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomreservations/' + inttostr(id));
  list := processJson(res, 'TRoomreservationsEntity');
  result := TRoomreservationsEntity(list[0]);
  
end;

function TRoomerDataSet.Roomreservations_Entities_GetBySql(sql: String): Array_Of_TRoomreservationsEntity;
var entities : Array_Of_TRoomreservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomreservations/getSql?sql=' + sql);
  list := processJson(res, 'TRoomreservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomreservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomreservations_Entities_GetListByWhere(where: String): Array_Of_TRoomreservationsEntity;
var entities : Array_Of_TRoomreservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomreservations/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomreservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomreservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomreservations_Entities_GetEntityByWhere(where: String): TRoomreservationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomreservations/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomreservationsEntity');
  result := TRoomreservationsEntity(list[0]);
  
end;

function TRoomerDataSet.Roomreservations_Entities_SaveEntity(entity: TRoomreservationsEntity): TRoomreservationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomreservations'), entity.json);
  result := TRoomreservationsEntity(processJson(src, 'TRoomreservationsEntity')[0]);
  
end;

function TRoomerDataSet.Roomreservations_Entities_UpdateEntity(entity: TRoomreservationsEntity): TRoomreservationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomreservations/' + inttostr(entity.Id)), entity.json);
  result := TRoomreservationsEntity(processJson(src, 'TRoomreservationsEntity')[0]);
  
end;

procedure TRoomerDataSet.Roomreservations_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'roomreservations/' + inttostr(id)));
  
end;

function TRoomerDataSet.Roomreservations_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomreservations');
end;

function TRoomerDataSet.Roomreservations_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomreservations/' + inttostr(id));
end;

function TRoomerDataSet.Roomreservations_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'roomreservations/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Roomreservations_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomreservations/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Roomreservations_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomreservations/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Roomreservations_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomreservations/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Roomreservations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomreservations/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Roomreservations_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomreservations/execute', 'sql=' + sql);
end;


// ******************************* Roomroomamenities **********************************

function TRoomerDataSet.Roomroomamenities_Entities_FindAll(): Array_Of_TRoomroomamenitiesEntity;
var entities : Array_Of_TRoomroomamenitiesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomroomamenities/findAll');
  list := processJson(res, 'TRoomroomamenitiesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomroomamenitiesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomroomamenities_Entities_GetById(id: Integer): TRoomroomamenitiesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomroomamenities/' + inttostr(id));
  list := processJson(res, 'TRoomroomamenitiesEntity');
  result := TRoomroomamenitiesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomroomamenities_Entities_GetBySql(sql: String): Array_Of_TRoomroomamenitiesEntity;
var entities : Array_Of_TRoomroomamenitiesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomroomamenities/getSql?sql=' + sql);
  list := processJson(res, 'TRoomroomamenitiesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomroomamenitiesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomroomamenities_Entities_GetListByWhere(where: String): Array_Of_TRoomroomamenitiesEntity;
var entities : Array_Of_TRoomroomamenitiesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomroomamenities/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomroomamenitiesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomroomamenitiesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomroomamenities_Entities_GetEntityByWhere(where: String): TRoomroomamenitiesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomroomamenities/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomroomamenitiesEntity');
  result := TRoomroomamenitiesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomroomamenities_Entities_SaveEntity(entity: TRoomroomamenitiesEntity): TRoomroomamenitiesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomroomamenities'), entity.json);
  result := TRoomroomamenitiesEntity(processJson(src, 'TRoomroomamenitiesEntity')[0]);
  
end;

function TRoomerDataSet.Roomroomamenities_Entities_UpdateEntity(entity: TRoomroomamenitiesEntity): TRoomroomamenitiesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomroomamenities/' + inttostr(entity.Id)), entity.json);
  result := TRoomroomamenitiesEntity(processJson(src, 'TRoomroomamenitiesEntity')[0]);
  
end;

procedure TRoomerDataSet.Roomroomamenities_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'roomroomamenities/' + inttostr(id)));
  
end;

function TRoomerDataSet.Roomroomamenities_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomroomamenities');
end;

function TRoomerDataSet.Roomroomamenities_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomroomamenities/' + inttostr(id));
end;

function TRoomerDataSet.Roomroomamenities_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'roomroomamenities/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Roomroomamenities_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomroomamenities/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Roomroomamenities_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomroomamenities/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Roomroomamenities_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomroomamenities/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Roomroomamenities_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomroomamenities/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Roomroomamenities_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomroomamenities/execute', 'sql=' + sql);
end;


// ******************************* Rooms **********************************

function TRoomerDataSet.Rooms_Entities_FindAll(): Array_Of_TRoomsEntity;
var entities : Array_Of_TRoomsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'rooms/findAll');
  list := processJson(res, 'TRoomsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Rooms_Entities_GetById(id: Integer): TRoomsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'rooms/' + inttostr(id));
  list := processJson(res, 'TRoomsEntity');
  result := TRoomsEntity(list[0]);
  
end;

function TRoomerDataSet.Rooms_Entities_GetBySql(sql: String): Array_Of_TRoomsEntity;
var entities : Array_Of_TRoomsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'rooms/getSql?sql=' + sql);
  list := processJson(res, 'TRoomsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Rooms_Entities_GetListByWhere(where: String): Array_Of_TRoomsEntity;
var entities : Array_Of_TRoomsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'rooms/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Rooms_Entities_GetEntityByWhere(where: String): TRoomsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'rooms/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomsEntity');
  result := TRoomsEntity(list[0]);
  
end;

function TRoomerDataSet.Rooms_Entities_SaveEntity(entity: TRoomsEntity): TRoomsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'rooms'), entity.json);
  result := TRoomsEntity(processJson(src, 'TRoomsEntity')[0]);
  
end;

function TRoomerDataSet.Rooms_Entities_UpdateEntity(entity: TRoomsEntity): TRoomsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'rooms/' + inttostr(entity.Id)), entity.json);
  result := TRoomsEntity(processJson(src, 'TRoomsEntity')[0]);
  
end;

procedure TRoomerDataSet.Rooms_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'rooms/' + inttostr(id)));
  
end;

function TRoomerDataSet.Rooms_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'rooms');
end;

function TRoomerDataSet.Rooms_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'rooms/' + inttostr(id));
end;

function TRoomerDataSet.Rooms_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'rooms/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Rooms_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'rooms/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Rooms_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'rooms/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Rooms_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'rooms/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Rooms_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'rooms/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Rooms_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'rooms/execute', 'sql=' + sql);
end;


// ******************************* Roomsdate **********************************

function TRoomerDataSet.Roomsdate_Entities_FindAll(): Array_Of_TRoomsdateEntity;
var entities : Array_Of_TRoomsdateEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomsdate/findAll');
  list := processJson(res, 'TRoomsdateEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomsdateEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomsdate_Entities_GetById(id: Integer): TRoomsdateEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomsdate/' + inttostr(id));
  list := processJson(res, 'TRoomsdateEntity');
  result := TRoomsdateEntity(list[0]);
  
end;

function TRoomerDataSet.Roomsdate_Entities_GetBySql(sql: String): Array_Of_TRoomsdateEntity;
var entities : Array_Of_TRoomsdateEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomsdate/getSql?sql=' + sql);
  list := processJson(res, 'TRoomsdateEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomsdateEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomsdate_Entities_GetListByWhere(where: String): Array_Of_TRoomsdateEntity;
var entities : Array_Of_TRoomsdateEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomsdate/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomsdateEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomsdateEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomsdate_Entities_GetEntityByWhere(where: String): TRoomsdateEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomsdate/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomsdateEntity');
  result := TRoomsdateEntity(list[0]);
  
end;

function TRoomerDataSet.Roomsdate_Entities_SaveEntity(entity: TRoomsdateEntity): TRoomsdateEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomsdate'), entity.json);
  result := TRoomsdateEntity(processJson(src, 'TRoomsdateEntity')[0]);
  
end;

function TRoomerDataSet.Roomsdate_Entities_UpdateEntity(entity: TRoomsdateEntity): TRoomsdateEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomsdate/' + inttostr(entity.Id)), entity.json);
  result := TRoomsdateEntity(processJson(src, 'TRoomsdateEntity')[0]);
  
end;

procedure TRoomerDataSet.Roomsdate_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'roomsdate/' + inttostr(id)));
  
end;

function TRoomerDataSet.Roomsdate_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomsdate');
end;

function TRoomerDataSet.Roomsdate_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomsdate/' + inttostr(id));
end;

function TRoomerDataSet.Roomsdate_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'roomsdate/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Roomsdate_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomsdate/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Roomsdate_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomsdate/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Roomsdate_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomsdate/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Roomsdate_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomsdate/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Roomsdate_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomsdate/execute', 'sql=' + sql);
end;


// ******************************* Roomsdatetemp **********************************

function TRoomerDataSet.Roomsdatetemp_Entities_FindAll(): Array_Of_TRoomsdatetempEntity;
var entities : Array_Of_TRoomsdatetempEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomsdatetemp/findAll');
  list := processJson(res, 'TRoomsdatetempEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomsdatetempEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomsdatetemp_Entities_GetById(id: Integer): TRoomsdatetempEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomsdatetemp/' + inttostr(id));
  list := processJson(res, 'TRoomsdatetempEntity');
  result := TRoomsdatetempEntity(list[0]);
  
end;

function TRoomerDataSet.Roomsdatetemp_Entities_GetBySql(sql: String): Array_Of_TRoomsdatetempEntity;
var entities : Array_Of_TRoomsdatetempEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomsdatetemp/getSql?sql=' + sql);
  list := processJson(res, 'TRoomsdatetempEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomsdatetempEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomsdatetemp_Entities_GetListByWhere(where: String): Array_Of_TRoomsdatetempEntity;
var entities : Array_Of_TRoomsdatetempEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomsdatetemp/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomsdatetempEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomsdatetempEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomsdatetemp_Entities_GetEntityByWhere(where: String): TRoomsdatetempEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomsdatetemp/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomsdatetempEntity');
  result := TRoomsdatetempEntity(list[0]);
  
end;

function TRoomerDataSet.Roomsdatetemp_Entities_SaveEntity(entity: TRoomsdatetempEntity): TRoomsdatetempEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomsdatetemp'), entity.json);
  result := TRoomsdatetempEntity(processJson(src, 'TRoomsdatetempEntity')[0]);
  
end;

function TRoomerDataSet.Roomsdatetemp_Entities_UpdateEntity(entity: TRoomsdatetempEntity): TRoomsdatetempEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomsdatetemp/' + inttostr(entity.Id)), entity.json);
  result := TRoomsdatetempEntity(processJson(src, 'TRoomsdatetempEntity')[0]);
  
end;

procedure TRoomerDataSet.Roomsdatetemp_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'roomsdatetemp/' + inttostr(id)));
  
end;

function TRoomerDataSet.Roomsdatetemp_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomsdatetemp');
end;

function TRoomerDataSet.Roomsdatetemp_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomsdatetemp/' + inttostr(id));
end;

function TRoomerDataSet.Roomsdatetemp_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'roomsdatetemp/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Roomsdatetemp_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomsdatetemp/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Roomsdatetemp_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomsdatetemp/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Roomsdatetemp_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomsdatetemp/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Roomsdatetemp_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomsdatetemp/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Roomsdatetemp_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomsdatetemp/execute', 'sql=' + sql);
end;


// ******************************* Roomtypegroups **********************************

function TRoomerDataSet.Roomtypegroups_Entities_FindAll(): Array_Of_TRoomtypegroupsEntity;
var entities : Array_Of_TRoomtypegroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtypegroups/findAll');
  list := processJson(res, 'TRoomtypegroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomtypegroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomtypegroups_Entities_GetById(id: Integer): TRoomtypegroupsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtypegroups/' + inttostr(id));
  list := processJson(res, 'TRoomtypegroupsEntity');
  result := TRoomtypegroupsEntity(list[0]);
  
end;

function TRoomerDataSet.Roomtypegroups_Entities_GetBySql(sql: String): Array_Of_TRoomtypegroupsEntity;
var entities : Array_Of_TRoomtypegroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtypegroups/getSql?sql=' + sql);
  list := processJson(res, 'TRoomtypegroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomtypegroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomtypegroups_Entities_GetListByWhere(where: String): Array_Of_TRoomtypegroupsEntity;
var entities : Array_Of_TRoomtypegroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtypegroups/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomtypegroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomtypegroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomtypegroups_Entities_GetEntityByWhere(where: String): TRoomtypegroupsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtypegroups/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomtypegroupsEntity');
  result := TRoomtypegroupsEntity(list[0]);
  
end;

function TRoomerDataSet.Roomtypegroups_Entities_SaveEntity(entity: TRoomtypegroupsEntity): TRoomtypegroupsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomtypegroups'), entity.json);
  result := TRoomtypegroupsEntity(processJson(src, 'TRoomtypegroupsEntity')[0]);
  
end;

function TRoomerDataSet.Roomtypegroups_Entities_UpdateEntity(entity: TRoomtypegroupsEntity): TRoomtypegroupsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomtypegroups/' + inttostr(entity.Id)), entity.json);
  result := TRoomtypegroupsEntity(processJson(src, 'TRoomtypegroupsEntity')[0]);
  
end;

procedure TRoomerDataSet.Roomtypegroups_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'roomtypegroups/' + inttostr(id)));
  
end;

function TRoomerDataSet.Roomtypegroups_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtypegroups');
end;

function TRoomerDataSet.Roomtypegroups_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtypegroups/' + inttostr(id));
end;

function TRoomerDataSet.Roomtypegroups_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'roomtypegroups/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Roomtypegroups_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomtypegroups/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Roomtypegroups_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtypegroups/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Roomtypegroups_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtypegroups/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Roomtypegroups_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtypegroups/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Roomtypegroups_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomtypegroups/execute', 'sql=' + sql);
end;


// ******************************* Roomtyperules **********************************

function TRoomerDataSet.Roomtyperules_Entities_FindAll(): Array_Of_TRoomtyperulesEntity;
var entities : Array_Of_TRoomtyperulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtyperules/findAll');
  list := processJson(res, 'TRoomtyperulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomtyperulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomtyperules_Entities_GetById(id: Integer): TRoomtyperulesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtyperules/' + inttostr(id));
  list := processJson(res, 'TRoomtyperulesEntity');
  result := TRoomtyperulesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomtyperules_Entities_GetBySql(sql: String): Array_Of_TRoomtyperulesEntity;
var entities : Array_Of_TRoomtyperulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtyperules/getSql?sql=' + sql);
  list := processJson(res, 'TRoomtyperulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomtyperulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomtyperules_Entities_GetListByWhere(where: String): Array_Of_TRoomtyperulesEntity;
var entities : Array_Of_TRoomtyperulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtyperules/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomtyperulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomtyperulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomtyperules_Entities_GetEntityByWhere(where: String): TRoomtyperulesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtyperules/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomtyperulesEntity');
  result := TRoomtyperulesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomtyperules_Entities_SaveEntity(entity: TRoomtyperulesEntity): TRoomtyperulesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomtyperules'), entity.json);
  result := TRoomtyperulesEntity(processJson(src, 'TRoomtyperulesEntity')[0]);
  
end;

function TRoomerDataSet.Roomtyperules_Entities_UpdateEntity(entity: TRoomtyperulesEntity): TRoomtyperulesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomtyperules/' + inttostr(entity.Id)), entity.json);
  result := TRoomtyperulesEntity(processJson(src, 'TRoomtyperulesEntity')[0]);
  
end;

procedure TRoomerDataSet.Roomtyperules_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'roomtyperules/' + inttostr(id)));
  
end;

function TRoomerDataSet.Roomtyperules_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtyperules');
end;

function TRoomerDataSet.Roomtyperules_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtyperules/' + inttostr(id));
end;

function TRoomerDataSet.Roomtyperules_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'roomtyperules/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Roomtyperules_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomtyperules/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Roomtyperules_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtyperules/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Roomtyperules_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtyperules/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Roomtyperules_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtyperules/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Roomtyperules_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomtyperules/execute', 'sql=' + sql);
end;


// ******************************* Roomtypes **********************************

function TRoomerDataSet.Roomtypes_Entities_FindAll(): Array_Of_TRoomtypesEntity;
var entities : Array_Of_TRoomtypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtypes/findAll');
  list := processJson(res, 'TRoomtypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomtypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomtypes_Entities_GetById(id: Integer): TRoomtypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtypes/' + inttostr(id));
  list := processJson(res, 'TRoomtypesEntity');
  result := TRoomtypesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomtypes_Entities_GetBySql(sql: String): Array_Of_TRoomtypesEntity;
var entities : Array_Of_TRoomtypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtypes/getSql?sql=' + sql);
  list := processJson(res, 'TRoomtypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomtypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomtypes_Entities_GetListByWhere(where: String): Array_Of_TRoomtypesEntity;
var entities : Array_Of_TRoomtypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtypes/getListByWhere?where=' + where);
  list := processJson(res, 'TRoomtypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TRoomtypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Roomtypes_Entities_GetEntityByWhere(where: String): TRoomtypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'roomtypes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TRoomtypesEntity');
  result := TRoomtypesEntity(list[0]);
  
end;

function TRoomerDataSet.Roomtypes_Entities_SaveEntity(entity: TRoomtypesEntity): TRoomtypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomtypes'), entity.json);
  result := TRoomtypesEntity(processJson(src, 'TRoomtypesEntity')[0]);
  
end;

function TRoomerDataSet.Roomtypes_Entities_UpdateEntity(entity: TRoomtypesEntity): TRoomtypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'roomtypes/' + inttostr(entity.Id)), entity.json);
  result := TRoomtypesEntity(processJson(src, 'TRoomtypesEntity')[0]);
  
end;

procedure TRoomerDataSet.Roomtypes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'roomtypes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Roomtypes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtypes');
end;

function TRoomerDataSet.Roomtypes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtypes/' + inttostr(id));
end;

function TRoomerDataSet.Roomtypes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'roomtypes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Roomtypes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomtypes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Roomtypes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtypes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Roomtypes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtypes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Roomtypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'roomtypes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Roomtypes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'roomtypes/execute', 'sql=' + sql);
end;


// ******************************* Staffmembers **********************************

function TRoomerDataSet.Staffmembers_Entities_FindAll(): Array_Of_TStaffmembersEntity;
var entities : Array_Of_TStaffmembersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'staffmembers/findAll');
  list := processJson(res, 'TStaffmembersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TStaffmembersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Staffmembers_Entities_GetById(id: Integer): TStaffmembersEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'staffmembers/' + inttostr(id));
  list := processJson(res, 'TStaffmembersEntity');
  result := TStaffmembersEntity(list[0]);
  
end;

function TRoomerDataSet.Staffmembers_Entities_GetBySql(sql: String): Array_Of_TStaffmembersEntity;
var entities : Array_Of_TStaffmembersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'staffmembers/getSql?sql=' + sql);
  list := processJson(res, 'TStaffmembersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TStaffmembersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Staffmembers_Entities_GetListByWhere(where: String): Array_Of_TStaffmembersEntity;
var entities : Array_Of_TStaffmembersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'staffmembers/getListByWhere?where=' + where);
  list := processJson(res, 'TStaffmembersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TStaffmembersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Staffmembers_Entities_GetEntityByWhere(where: String): TStaffmembersEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'staffmembers/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TStaffmembersEntity');
  result := TStaffmembersEntity(list[0]);
  
end;

function TRoomerDataSet.Staffmembers_Entities_SaveEntity(entity: TStaffmembersEntity): TStaffmembersEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'staffmembers'), entity.json);
  result := TStaffmembersEntity(processJson(src, 'TStaffmembersEntity')[0]);
  
end;

function TRoomerDataSet.Staffmembers_Entities_UpdateEntity(entity: TStaffmembersEntity): TStaffmembersEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'staffmembers/' + inttostr(entity.Id)), entity.json);
  result := TStaffmembersEntity(processJson(src, 'TStaffmembersEntity')[0]);
  
end;

procedure TRoomerDataSet.Staffmembers_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'staffmembers/' + inttostr(id)));
  
end;

function TRoomerDataSet.Staffmembers_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'staffmembers');
end;

function TRoomerDataSet.Staffmembers_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'staffmembers/' + inttostr(id));
end;

function TRoomerDataSet.Staffmembers_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'staffmembers/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Staffmembers_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'staffmembers/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Staffmembers_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'staffmembers/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Staffmembers_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'staffmembers/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Staffmembers_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'staffmembers/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Staffmembers_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'staffmembers/execute', 'sql=' + sql);
end;


// ******************************* Stafftypes **********************************

function TRoomerDataSet.Stafftypes_Entities_FindAll(): Array_Of_TStafftypesEntity;
var entities : Array_Of_TStafftypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'stafftypes/findAll');
  list := processJson(res, 'TStafftypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TStafftypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Stafftypes_Entities_GetById(id: Integer): TStafftypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'stafftypes/' + inttostr(id));
  list := processJson(res, 'TStafftypesEntity');
  result := TStafftypesEntity(list[0]);
  
end;

function TRoomerDataSet.Stafftypes_Entities_GetBySql(sql: String): Array_Of_TStafftypesEntity;
var entities : Array_Of_TStafftypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'stafftypes/getSql?sql=' + sql);
  list := processJson(res, 'TStafftypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TStafftypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Stafftypes_Entities_GetListByWhere(where: String): Array_Of_TStafftypesEntity;
var entities : Array_Of_TStafftypesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'stafftypes/getListByWhere?where=' + where);
  list := processJson(res, 'TStafftypesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TStafftypesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Stafftypes_Entities_GetEntityByWhere(where: String): TStafftypesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'stafftypes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TStafftypesEntity');
  result := TStafftypesEntity(list[0]);
  
end;

function TRoomerDataSet.Stafftypes_Entities_SaveEntity(entity: TStafftypesEntity): TStafftypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'stafftypes'), entity.json);
  result := TStafftypesEntity(processJson(src, 'TStafftypesEntity')[0]);
  
end;

function TRoomerDataSet.Stafftypes_Entities_UpdateEntity(entity: TStafftypesEntity): TStafftypesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'stafftypes/' + inttostr(entity.Id)), entity.json);
  result := TStafftypesEntity(processJson(src, 'TStafftypesEntity')[0]);
  
end;

procedure TRoomerDataSet.Stafftypes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'stafftypes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Stafftypes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'stafftypes');
end;

function TRoomerDataSet.Stafftypes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'stafftypes/' + inttostr(id));
end;

function TRoomerDataSet.Stafftypes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'stafftypes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Stafftypes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'stafftypes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Stafftypes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'stafftypes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Stafftypes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'stafftypes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Stafftypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'stafftypes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Stafftypes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'stafftypes/execute', 'sql=' + sql);
end;


// ******************************* Systemactions **********************************

function TRoomerDataSet.Systemactions_Entities_FindAll(): Array_Of_TSystemactionsEntity;
var entities : Array_Of_TSystemactionsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemactions/findAll');
  list := processJson(res, 'TSystemactionsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TSystemactionsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Systemactions_Entities_GetById(id: Integer): TSystemactionsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemactions/' + inttostr(id));
  list := processJson(res, 'TSystemactionsEntity');
  result := TSystemactionsEntity(list[0]);
  
end;

function TRoomerDataSet.Systemactions_Entities_GetBySql(sql: String): Array_Of_TSystemactionsEntity;
var entities : Array_Of_TSystemactionsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemactions/getSql?sql=' + sql);
  list := processJson(res, 'TSystemactionsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TSystemactionsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Systemactions_Entities_GetListByWhere(where: String): Array_Of_TSystemactionsEntity;
var entities : Array_Of_TSystemactionsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemactions/getListByWhere?where=' + where);
  list := processJson(res, 'TSystemactionsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TSystemactionsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Systemactions_Entities_GetEntityByWhere(where: String): TSystemactionsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemactions/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TSystemactionsEntity');
  result := TSystemactionsEntity(list[0]);
  
end;

function TRoomerDataSet.Systemactions_Entities_SaveEntity(entity: TSystemactionsEntity): TSystemactionsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'systemactions'), entity.json);
  result := TSystemactionsEntity(processJson(src, 'TSystemactionsEntity')[0]);
  
end;

function TRoomerDataSet.Systemactions_Entities_UpdateEntity(entity: TSystemactionsEntity): TSystemactionsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'systemactions/' + inttostr(entity.Id)), entity.json);
  result := TSystemactionsEntity(processJson(src, 'TSystemactionsEntity')[0]);
  
end;

procedure TRoomerDataSet.Systemactions_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'systemactions/' + inttostr(id)));
  
end;

function TRoomerDataSet.Systemactions_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemactions');
end;

function TRoomerDataSet.Systemactions_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemactions/' + inttostr(id));
end;

function TRoomerDataSet.Systemactions_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'systemactions/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Systemactions_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'systemactions/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Systemactions_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemactions/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Systemactions_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemactions/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Systemactions_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemactions/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Systemactions_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'systemactions/execute', 'sql=' + sql);
end;


// ******************************* Systemservers **********************************

function TRoomerDataSet.Systemservers_Entities_FindAll(): Array_Of_TSystemserversEntity;
var entities : Array_Of_TSystemserversEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemservers/findAll');
  list := processJson(res, 'TSystemserversEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TSystemserversEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Systemservers_Entities_GetById(id: Integer): TSystemserversEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemservers/' + inttostr(id));
  list := processJson(res, 'TSystemserversEntity');
  result := TSystemserversEntity(list[0]);
  
end;

function TRoomerDataSet.Systemservers_Entities_GetBySql(sql: String): Array_Of_TSystemserversEntity;
var entities : Array_Of_TSystemserversEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemservers/getSql?sql=' + sql);
  list := processJson(res, 'TSystemserversEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TSystemserversEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Systemservers_Entities_GetListByWhere(where: String): Array_Of_TSystemserversEntity;
var entities : Array_Of_TSystemserversEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemservers/getListByWhere?where=' + where);
  list := processJson(res, 'TSystemserversEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TSystemserversEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Systemservers_Entities_GetEntityByWhere(where: String): TSystemserversEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemservers/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TSystemserversEntity');
  result := TSystemserversEntity(list[0]);
  
end;

function TRoomerDataSet.Systemservers_Entities_SaveEntity(entity: TSystemserversEntity): TSystemserversEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'systemservers'), entity.json);
  result := TSystemserversEntity(processJson(src, 'TSystemserversEntity')[0]);
  
end;

function TRoomerDataSet.Systemservers_Entities_UpdateEntity(entity: TSystemserversEntity): TSystemserversEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'systemservers/' + inttostr(entity.Id)), entity.json);
  result := TSystemserversEntity(processJson(src, 'TSystemserversEntity')[0]);
  
end;

procedure TRoomerDataSet.Systemservers_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'systemservers/' + inttostr(id)));
  
end;

function TRoomerDataSet.Systemservers_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemservers');
end;

function TRoomerDataSet.Systemservers_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemservers/' + inttostr(id));
end;

function TRoomerDataSet.Systemservers_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'systemservers/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Systemservers_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'systemservers/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Systemservers_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemservers/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Systemservers_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemservers/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Systemservers_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemservers/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Systemservers_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'systemservers/execute', 'sql=' + sql);
end;


// ******************************* Systemtriggers **********************************

function TRoomerDataSet.Systemtriggers_Entities_FindAll(): Array_Of_TSystemtriggersEntity;
var entities : Array_Of_TSystemtriggersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemtriggers/findAll');
  list := processJson(res, 'TSystemtriggersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TSystemtriggersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Systemtriggers_Entities_GetById(id: Integer): TSystemtriggersEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemtriggers/' + inttostr(id));
  list := processJson(res, 'TSystemtriggersEntity');
  result := TSystemtriggersEntity(list[0]);
  
end;

function TRoomerDataSet.Systemtriggers_Entities_GetBySql(sql: String): Array_Of_TSystemtriggersEntity;
var entities : Array_Of_TSystemtriggersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemtriggers/getSql?sql=' + sql);
  list := processJson(res, 'TSystemtriggersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TSystemtriggersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Systemtriggers_Entities_GetListByWhere(where: String): Array_Of_TSystemtriggersEntity;
var entities : Array_Of_TSystemtriggersEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemtriggers/getListByWhere?where=' + where);
  list := processJson(res, 'TSystemtriggersEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TSystemtriggersEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Systemtriggers_Entities_GetEntityByWhere(where: String): TSystemtriggersEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'systemtriggers/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TSystemtriggersEntity');
  result := TSystemtriggersEntity(list[0]);
  
end;

function TRoomerDataSet.Systemtriggers_Entities_SaveEntity(entity: TSystemtriggersEntity): TSystemtriggersEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'systemtriggers'), entity.json);
  result := TSystemtriggersEntity(processJson(src, 'TSystemtriggersEntity')[0]);
  
end;

function TRoomerDataSet.Systemtriggers_Entities_UpdateEntity(entity: TSystemtriggersEntity): TSystemtriggersEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'systemtriggers/' + inttostr(entity.Id)), entity.json);
  result := TSystemtriggersEntity(processJson(src, 'TSystemtriggersEntity')[0]);
  
end;

procedure TRoomerDataSet.Systemtriggers_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'systemtriggers/' + inttostr(id)));
  
end;

function TRoomerDataSet.Systemtriggers_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemtriggers');
end;

function TRoomerDataSet.Systemtriggers_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemtriggers/' + inttostr(id));
end;

function TRoomerDataSet.Systemtriggers_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'systemtriggers/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Systemtriggers_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'systemtriggers/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Systemtriggers_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemtriggers/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Systemtriggers_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemtriggers/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Systemtriggers_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'systemtriggers/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Systemtriggers_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'systemtriggers/execute', 'sql=' + sql);
end;


// ******************************* Tblconvertgroups **********************************

function TRoomerDataSet.Tblconvertgroups_Entities_FindAll(): Array_Of_TTblconvertgroupsEntity;
var entities : Array_Of_TTblconvertgroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblconvertgroups/findAll');
  list := processJson(res, 'TTblconvertgroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblconvertgroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblconvertgroups_Entities_GetById(id: Integer): TTblconvertgroupsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblconvertgroups/' + inttostr(id));
  list := processJson(res, 'TTblconvertgroupsEntity');
  result := TTblconvertgroupsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblconvertgroups_Entities_GetBySql(sql: String): Array_Of_TTblconvertgroupsEntity;
var entities : Array_Of_TTblconvertgroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblconvertgroups/getSql?sql=' + sql);
  list := processJson(res, 'TTblconvertgroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblconvertgroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblconvertgroups_Entities_GetListByWhere(where: String): Array_Of_TTblconvertgroupsEntity;
var entities : Array_Of_TTblconvertgroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblconvertgroups/getListByWhere?where=' + where);
  list := processJson(res, 'TTblconvertgroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblconvertgroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblconvertgroups_Entities_GetEntityByWhere(where: String): TTblconvertgroupsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblconvertgroups/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblconvertgroupsEntity');
  result := TTblconvertgroupsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblconvertgroups_Entities_SaveEntity(entity: TTblconvertgroupsEntity): TTblconvertgroupsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblconvertgroups'), entity.json);
  result := TTblconvertgroupsEntity(processJson(src, 'TTblconvertgroupsEntity')[0]);
  
end;

function TRoomerDataSet.Tblconvertgroups_Entities_UpdateEntity(entity: TTblconvertgroupsEntity): TTblconvertgroupsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblconvertgroups/' + inttostr(entity.Id)), entity.json);
  result := TTblconvertgroupsEntity(processJson(src, 'TTblconvertgroupsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblconvertgroups_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblconvertgroups/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblconvertgroups_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblconvertgroups');
end;

function TRoomerDataSet.Tblconvertgroups_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblconvertgroups/' + inttostr(id));
end;

function TRoomerDataSet.Tblconvertgroups_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblconvertgroups/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblconvertgroups_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblconvertgroups/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblconvertgroups_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblconvertgroups/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblconvertgroups_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblconvertgroups/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblconvertgroups_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblconvertgroups/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblconvertgroups_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblconvertgroups/execute', 'sql=' + sql);
end;


// ******************************* Tblconverts **********************************

function TRoomerDataSet.Tblconverts_Entities_FindAll(): Array_Of_TTblconvertsEntity;
var entities : Array_Of_TTblconvertsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblconverts/findAll');
  list := processJson(res, 'TTblconvertsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblconvertsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblconverts_Entities_GetById(id: Integer): TTblconvertsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblconverts/' + inttostr(id));
  list := processJson(res, 'TTblconvertsEntity');
  result := TTblconvertsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblconverts_Entities_GetBySql(sql: String): Array_Of_TTblconvertsEntity;
var entities : Array_Of_TTblconvertsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblconverts/getSql?sql=' + sql);
  list := processJson(res, 'TTblconvertsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblconvertsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblconverts_Entities_GetListByWhere(where: String): Array_Of_TTblconvertsEntity;
var entities : Array_Of_TTblconvertsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblconverts/getListByWhere?where=' + where);
  list := processJson(res, 'TTblconvertsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblconvertsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblconverts_Entities_GetEntityByWhere(where: String): TTblconvertsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblconverts/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblconvertsEntity');
  result := TTblconvertsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblconverts_Entities_SaveEntity(entity: TTblconvertsEntity): TTblconvertsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblconverts'), entity.json);
  result := TTblconvertsEntity(processJson(src, 'TTblconvertsEntity')[0]);
  
end;

function TRoomerDataSet.Tblconverts_Entities_UpdateEntity(entity: TTblconvertsEntity): TTblconvertsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblconverts/' + inttostr(entity.Id)), entity.json);
  result := TTblconvertsEntity(processJson(src, 'TTblconvertsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblconverts_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblconverts/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblconverts_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblconverts');
end;

function TRoomerDataSet.Tblconverts_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblconverts/' + inttostr(id));
end;

function TRoomerDataSet.Tblconverts_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblconverts/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblconverts_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblconverts/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblconverts_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblconverts/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblconverts_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblconverts/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblconverts_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblconverts/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblconverts_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblconverts/execute', 'sql=' + sql);
end;


// ******************************* Tbldelpersons **********************************

function TRoomerDataSet.Tbldelpersons_Entities_FindAll(): Array_Of_TTbldelpersonsEntity;
var entities : Array_Of_TTbldelpersonsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelpersons/findAll');
  list := processJson(res, 'TTbldelpersonsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTbldelpersonsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tbldelpersons_Entities_GetById(id: Integer): TTbldelpersonsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelpersons/' + inttostr(id));
  list := processJson(res, 'TTbldelpersonsEntity');
  result := TTbldelpersonsEntity(list[0]);
  
end;

function TRoomerDataSet.Tbldelpersons_Entities_GetBySql(sql: String): Array_Of_TTbldelpersonsEntity;
var entities : Array_Of_TTbldelpersonsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelpersons/getSql?sql=' + sql);
  list := processJson(res, 'TTbldelpersonsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTbldelpersonsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tbldelpersons_Entities_GetListByWhere(where: String): Array_Of_TTbldelpersonsEntity;
var entities : Array_Of_TTbldelpersonsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelpersons/getListByWhere?where=' + where);
  list := processJson(res, 'TTbldelpersonsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTbldelpersonsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tbldelpersons_Entities_GetEntityByWhere(where: String): TTbldelpersonsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelpersons/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTbldelpersonsEntity');
  result := TTbldelpersonsEntity(list[0]);
  
end;

function TRoomerDataSet.Tbldelpersons_Entities_SaveEntity(entity: TTbldelpersonsEntity): TTbldelpersonsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tbldelpersons'), entity.json);
  result := TTbldelpersonsEntity(processJson(src, 'TTbldelpersonsEntity')[0]);
  
end;

function TRoomerDataSet.Tbldelpersons_Entities_UpdateEntity(entity: TTbldelpersonsEntity): TTbldelpersonsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tbldelpersons/' + inttostr(entity.Id)), entity.json);
  result := TTbldelpersonsEntity(processJson(src, 'TTbldelpersonsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tbldelpersons_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tbldelpersons/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tbldelpersons_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelpersons');
end;

function TRoomerDataSet.Tbldelpersons_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelpersons/' + inttostr(id));
end;

function TRoomerDataSet.Tbldelpersons_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tbldelpersons/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tbldelpersons_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tbldelpersons/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tbldelpersons_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelpersons/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tbldelpersons_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelpersons/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tbldelpersons_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelpersons/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tbldelpersons_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tbldelpersons/execute', 'sql=' + sql);
end;


// ******************************* Tbldelreservations **********************************

function TRoomerDataSet.Tbldelreservations_Entities_FindAll(): Array_Of_TTbldelreservationsEntity;
var entities : Array_Of_TTbldelreservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelreservations/findAll');
  list := processJson(res, 'TTbldelreservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTbldelreservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tbldelreservations_Entities_GetById(id: Integer): TTbldelreservationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelreservations/' + inttostr(id));
  list := processJson(res, 'TTbldelreservationsEntity');
  result := TTbldelreservationsEntity(list[0]);
  
end;

function TRoomerDataSet.Tbldelreservations_Entities_GetBySql(sql: String): Array_Of_TTbldelreservationsEntity;
var entities : Array_Of_TTbldelreservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelreservations/getSql?sql=' + sql);
  list := processJson(res, 'TTbldelreservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTbldelreservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tbldelreservations_Entities_GetListByWhere(where: String): Array_Of_TTbldelreservationsEntity;
var entities : Array_Of_TTbldelreservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelreservations/getListByWhere?where=' + where);
  list := processJson(res, 'TTbldelreservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTbldelreservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tbldelreservations_Entities_GetEntityByWhere(where: String): TTbldelreservationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelreservations/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTbldelreservationsEntity');
  result := TTbldelreservationsEntity(list[0]);
  
end;

function TRoomerDataSet.Tbldelreservations_Entities_SaveEntity(entity: TTbldelreservationsEntity): TTbldelreservationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tbldelreservations'), entity.json);
  result := TTbldelreservationsEntity(processJson(src, 'TTbldelreservationsEntity')[0]);
  
end;

function TRoomerDataSet.Tbldelreservations_Entities_UpdateEntity(entity: TTbldelreservationsEntity): TTbldelreservationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tbldelreservations/' + inttostr(entity.Id)), entity.json);
  result := TTbldelreservationsEntity(processJson(src, 'TTbldelreservationsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tbldelreservations_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tbldelreservations/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tbldelreservations_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelreservations');
end;

function TRoomerDataSet.Tbldelreservations_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelreservations/' + inttostr(id));
end;

function TRoomerDataSet.Tbldelreservations_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tbldelreservations/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tbldelreservations_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tbldelreservations/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tbldelreservations_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelreservations/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tbldelreservations_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelreservations/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tbldelreservations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelreservations/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tbldelreservations_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tbldelreservations/execute', 'sql=' + sql);
end;


// ******************************* Tbldelroomreservations **********************************

function TRoomerDataSet.Tbldelroomreservations_Entities_FindAll(): Array_Of_TTbldelroomreservationsEntity;
var entities : Array_Of_TTbldelroomreservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelroomreservations/findAll');
  list := processJson(res, 'TTbldelroomreservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTbldelroomreservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tbldelroomreservations_Entities_GetById(id: Integer): TTbldelroomreservationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelroomreservations/' + inttostr(id));
  list := processJson(res, 'TTbldelroomreservationsEntity');
  result := TTbldelroomreservationsEntity(list[0]);
  
end;

function TRoomerDataSet.Tbldelroomreservations_Entities_GetBySql(sql: String): Array_Of_TTbldelroomreservationsEntity;
var entities : Array_Of_TTbldelroomreservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelroomreservations/getSql?sql=' + sql);
  list := processJson(res, 'TTbldelroomreservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTbldelroomreservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tbldelroomreservations_Entities_GetListByWhere(where: String): Array_Of_TTbldelroomreservationsEntity;
var entities : Array_Of_TTbldelroomreservationsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelroomreservations/getListByWhere?where=' + where);
  list := processJson(res, 'TTbldelroomreservationsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTbldelroomreservationsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tbldelroomreservations_Entities_GetEntityByWhere(where: String): TTbldelroomreservationsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tbldelroomreservations/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTbldelroomreservationsEntity');
  result := TTbldelroomreservationsEntity(list[0]);
  
end;

function TRoomerDataSet.Tbldelroomreservations_Entities_SaveEntity(entity: TTbldelroomreservationsEntity): TTbldelroomreservationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tbldelroomreservations'), entity.json);
  result := TTbldelroomreservationsEntity(processJson(src, 'TTbldelroomreservationsEntity')[0]);
  
end;

function TRoomerDataSet.Tbldelroomreservations_Entities_UpdateEntity(entity: TTbldelroomreservationsEntity): TTbldelroomreservationsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tbldelroomreservations/' + inttostr(entity.Id)), entity.json);
  result := TTbldelroomreservationsEntity(processJson(src, 'TTbldelroomreservationsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tbldelroomreservations_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tbldelroomreservations/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tbldelroomreservations_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelroomreservations');
end;

function TRoomerDataSet.Tbldelroomreservations_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelroomreservations/' + inttostr(id));
end;

function TRoomerDataSet.Tbldelroomreservations_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tbldelroomreservations/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tbldelroomreservations_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tbldelroomreservations/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tbldelroomreservations_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelroomreservations/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tbldelroomreservations_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelroomreservations/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tbldelroomreservations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tbldelroomreservations/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tbldelroomreservations_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tbldelroomreservations/execute', 'sql=' + sql);
end;


// ******************************* Tblhiddeninfo **********************************

function TRoomerDataSet.Tblhiddeninfo_Entities_FindAll(): Array_Of_TTblhiddeninfoEntity;
var entities : Array_Of_TTblhiddeninfoEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblhiddeninfo/findAll');
  list := processJson(res, 'TTblhiddeninfoEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblhiddeninfoEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblhiddeninfo_Entities_GetById(id: Integer): TTblhiddeninfoEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblhiddeninfo/' + inttostr(id));
  list := processJson(res, 'TTblhiddeninfoEntity');
  result := TTblhiddeninfoEntity(list[0]);
  
end;

function TRoomerDataSet.Tblhiddeninfo_Entities_GetBySql(sql: String): Array_Of_TTblhiddeninfoEntity;
var entities : Array_Of_TTblhiddeninfoEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblhiddeninfo/getSql?sql=' + sql);
  list := processJson(res, 'TTblhiddeninfoEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblhiddeninfoEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblhiddeninfo_Entities_GetListByWhere(where: String): Array_Of_TTblhiddeninfoEntity;
var entities : Array_Of_TTblhiddeninfoEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblhiddeninfo/getListByWhere?where=' + where);
  list := processJson(res, 'TTblhiddeninfoEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblhiddeninfoEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblhiddeninfo_Entities_GetEntityByWhere(where: String): TTblhiddeninfoEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblhiddeninfo/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblhiddeninfoEntity');
  result := TTblhiddeninfoEntity(list[0]);
  
end;

function TRoomerDataSet.Tblhiddeninfo_Entities_SaveEntity(entity: TTblhiddeninfoEntity): TTblhiddeninfoEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblhiddeninfo'), entity.json);
  result := TTblhiddeninfoEntity(processJson(src, 'TTblhiddeninfoEntity')[0]);
  
end;

function TRoomerDataSet.Tblhiddeninfo_Entities_UpdateEntity(entity: TTblhiddeninfoEntity): TTblhiddeninfoEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblhiddeninfo/' + inttostr(entity.Id)), entity.json);
  result := TTblhiddeninfoEntity(processJson(src, 'TTblhiddeninfoEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblhiddeninfo_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblhiddeninfo/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblhiddeninfo_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblhiddeninfo');
end;

function TRoomerDataSet.Tblhiddeninfo_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblhiddeninfo/' + inttostr(id));
end;

function TRoomerDataSet.Tblhiddeninfo_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblhiddeninfo/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblhiddeninfo_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblhiddeninfo/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblhiddeninfo_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblhiddeninfo/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblhiddeninfo_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblhiddeninfo/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblhiddeninfo_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblhiddeninfo/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblhiddeninfo_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblhiddeninfo/execute', 'sql=' + sql);
end;


// ******************************* Tblimportlogs **********************************

function TRoomerDataSet.Tblimportlogs_Entities_FindAll(): Array_Of_TTblimportlogsEntity;
var entities : Array_Of_TTblimportlogsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblimportlogs/findAll');
  list := processJson(res, 'TTblimportlogsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblimportlogsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblimportlogs_Entities_GetById(id: Integer): TTblimportlogsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblimportlogs/' + inttostr(id));
  list := processJson(res, 'TTblimportlogsEntity');
  result := TTblimportlogsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblimportlogs_Entities_GetBySql(sql: String): Array_Of_TTblimportlogsEntity;
var entities : Array_Of_TTblimportlogsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblimportlogs/getSql?sql=' + sql);
  list := processJson(res, 'TTblimportlogsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblimportlogsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblimportlogs_Entities_GetListByWhere(where: String): Array_Of_TTblimportlogsEntity;
var entities : Array_Of_TTblimportlogsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblimportlogs/getListByWhere?where=' + where);
  list := processJson(res, 'TTblimportlogsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblimportlogsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblimportlogs_Entities_GetEntityByWhere(where: String): TTblimportlogsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblimportlogs/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblimportlogsEntity');
  result := TTblimportlogsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblimportlogs_Entities_SaveEntity(entity: TTblimportlogsEntity): TTblimportlogsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblimportlogs'), entity.json);
  result := TTblimportlogsEntity(processJson(src, 'TTblimportlogsEntity')[0]);
  
end;

function TRoomerDataSet.Tblimportlogs_Entities_UpdateEntity(entity: TTblimportlogsEntity): TTblimportlogsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblimportlogs/' + inttostr(entity.Id)), entity.json);
  result := TTblimportlogsEntity(processJson(src, 'TTblimportlogsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblimportlogs_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblimportlogs/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblimportlogs_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblimportlogs');
end;

function TRoomerDataSet.Tblimportlogs_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblimportlogs/' + inttostr(id));
end;

function TRoomerDataSet.Tblimportlogs_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblimportlogs/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblimportlogs_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblimportlogs/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblimportlogs_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblimportlogs/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblimportlogs_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblimportlogs/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblimportlogs_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblimportlogs/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblimportlogs_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblimportlogs/execute', 'sql=' + sql);
end;


// ******************************* Tblinc **********************************

function TRoomerDataSet.Tblinc_Entities_FindAll(): Array_Of_TTblincEntity;
var entities : Array_Of_TTblincEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblinc/findAll');
  list := processJson(res, 'TTblincEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblincEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblinc_Entities_GetById(id: Integer): TTblincEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblinc/' + inttostr(id));
  list := processJson(res, 'TTblincEntity');
  result := TTblincEntity(list[0]);
  
end;

function TRoomerDataSet.Tblinc_Entities_GetBySql(sql: String): Array_Of_TTblincEntity;
var entities : Array_Of_TTblincEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblinc/getSql?sql=' + sql);
  list := processJson(res, 'TTblincEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblincEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblinc_Entities_GetListByWhere(where: String): Array_Of_TTblincEntity;
var entities : Array_Of_TTblincEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblinc/getListByWhere?where=' + where);
  list := processJson(res, 'TTblincEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblincEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblinc_Entities_GetEntityByWhere(where: String): TTblincEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblinc/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblincEntity');
  result := TTblincEntity(list[0]);
  
end;

function TRoomerDataSet.Tblinc_Entities_SaveEntity(entity: TTblincEntity): TTblincEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblinc'), entity.json);
  result := TTblincEntity(processJson(src, 'TTblincEntity')[0]);
  
end;

function TRoomerDataSet.Tblinc_Entities_UpdateEntity(entity: TTblincEntity): TTblincEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblinc/' + inttostr(entity.Id)), entity.json);
  result := TTblincEntity(processJson(src, 'TTblincEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblinc_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblinc/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblinc_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblinc');
end;

function TRoomerDataSet.Tblinc_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblinc/' + inttostr(id));
end;

function TRoomerDataSet.Tblinc_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblinc/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblinc_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblinc/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblinc_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblinc/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblinc_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblinc/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblinc_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblinc/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblinc_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblinc/execute', 'sql=' + sql);
end;


// ******************************* Tblinvoiceactions **********************************

function TRoomerDataSet.Tblinvoiceactions_Entities_FindAll(): Array_Of_TTblinvoiceactionsEntity;
var entities : Array_Of_TTblinvoiceactionsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblinvoiceactions/findAll');
  list := processJson(res, 'TTblinvoiceactionsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblinvoiceactionsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblinvoiceactions_Entities_GetById(id: Integer): TTblinvoiceactionsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblinvoiceactions/' + inttostr(id));
  list := processJson(res, 'TTblinvoiceactionsEntity');
  result := TTblinvoiceactionsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblinvoiceactions_Entities_GetBySql(sql: String): Array_Of_TTblinvoiceactionsEntity;
var entities : Array_Of_TTblinvoiceactionsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblinvoiceactions/getSql?sql=' + sql);
  list := processJson(res, 'TTblinvoiceactionsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblinvoiceactionsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblinvoiceactions_Entities_GetListByWhere(where: String): Array_Of_TTblinvoiceactionsEntity;
var entities : Array_Of_TTblinvoiceactionsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblinvoiceactions/getListByWhere?where=' + where);
  list := processJson(res, 'TTblinvoiceactionsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblinvoiceactionsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblinvoiceactions_Entities_GetEntityByWhere(where: String): TTblinvoiceactionsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblinvoiceactions/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblinvoiceactionsEntity');
  result := TTblinvoiceactionsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblinvoiceactions_Entities_SaveEntity(entity: TTblinvoiceactionsEntity): TTblinvoiceactionsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblinvoiceactions'), entity.json);
  result := TTblinvoiceactionsEntity(processJson(src, 'TTblinvoiceactionsEntity')[0]);
  
end;

function TRoomerDataSet.Tblinvoiceactions_Entities_UpdateEntity(entity: TTblinvoiceactionsEntity): TTblinvoiceactionsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblinvoiceactions/' + inttostr(entity.Id)), entity.json);
  result := TTblinvoiceactionsEntity(processJson(src, 'TTblinvoiceactionsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblinvoiceactions_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblinvoiceactions/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblinvoiceactions_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblinvoiceactions');
end;

function TRoomerDataSet.Tblinvoiceactions_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblinvoiceactions/' + inttostr(id));
end;

function TRoomerDataSet.Tblinvoiceactions_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblinvoiceactions/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblinvoiceactions_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblinvoiceactions/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblinvoiceactions_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblinvoiceactions/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblinvoiceactions_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblinvoiceactions/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblinvoiceactions_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblinvoiceactions/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblinvoiceactions_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblinvoiceactions/execute', 'sql=' + sql);
end;


// ******************************* Tblmaidactions **********************************

function TRoomerDataSet.Tblmaidactions_Entities_FindAll(): Array_Of_TTblmaidactionsEntity;
var entities : Array_Of_TTblmaidactionsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidactions/findAll');
  list := processJson(res, 'TTblmaidactionsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblmaidactionsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblmaidactions_Entities_GetById(id: Integer): TTblmaidactionsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidactions/' + inttostr(id));
  list := processJson(res, 'TTblmaidactionsEntity');
  result := TTblmaidactionsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblmaidactions_Entities_GetBySql(sql: String): Array_Of_TTblmaidactionsEntity;
var entities : Array_Of_TTblmaidactionsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidactions/getSql?sql=' + sql);
  list := processJson(res, 'TTblmaidactionsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblmaidactionsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblmaidactions_Entities_GetListByWhere(where: String): Array_Of_TTblmaidactionsEntity;
var entities : Array_Of_TTblmaidactionsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidactions/getListByWhere?where=' + where);
  list := processJson(res, 'TTblmaidactionsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblmaidactionsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblmaidactions_Entities_GetEntityByWhere(where: String): TTblmaidactionsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidactions/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblmaidactionsEntity');
  result := TTblmaidactionsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblmaidactions_Entities_SaveEntity(entity: TTblmaidactionsEntity): TTblmaidactionsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblmaidactions'), entity.json);
  result := TTblmaidactionsEntity(processJson(src, 'TTblmaidactionsEntity')[0]);
  
end;

function TRoomerDataSet.Tblmaidactions_Entities_UpdateEntity(entity: TTblmaidactionsEntity): TTblmaidactionsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblmaidactions/' + inttostr(entity.Id)), entity.json);
  result := TTblmaidactionsEntity(processJson(src, 'TTblmaidactionsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblmaidactions_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblmaidactions/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblmaidactions_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidactions');
end;

function TRoomerDataSet.Tblmaidactions_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidactions/' + inttostr(id));
end;

function TRoomerDataSet.Tblmaidactions_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblmaidactions/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblmaidactions_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblmaidactions/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblmaidactions_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidactions/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblmaidactions_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidactions/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblmaidactions_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidactions/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblmaidactions_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblmaidactions/execute', 'sql=' + sql);
end;


// ******************************* Tblmaidjobs **********************************

function TRoomerDataSet.Tblmaidjobs_Entities_FindAll(): Array_Of_TTblmaidjobsEntity;
var entities : Array_Of_TTblmaidjobsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidjobs/findAll');
  list := processJson(res, 'TTblmaidjobsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblmaidjobsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblmaidjobs_Entities_GetById(id: Integer): TTblmaidjobsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidjobs/' + inttostr(id));
  list := processJson(res, 'TTblmaidjobsEntity');
  result := TTblmaidjobsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblmaidjobs_Entities_GetBySql(sql: String): Array_Of_TTblmaidjobsEntity;
var entities : Array_Of_TTblmaidjobsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidjobs/getSql?sql=' + sql);
  list := processJson(res, 'TTblmaidjobsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblmaidjobsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblmaidjobs_Entities_GetListByWhere(where: String): Array_Of_TTblmaidjobsEntity;
var entities : Array_Of_TTblmaidjobsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidjobs/getListByWhere?where=' + where);
  list := processJson(res, 'TTblmaidjobsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblmaidjobsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblmaidjobs_Entities_GetEntityByWhere(where: String): TTblmaidjobsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidjobs/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblmaidjobsEntity');
  result := TTblmaidjobsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblmaidjobs_Entities_SaveEntity(entity: TTblmaidjobsEntity): TTblmaidjobsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblmaidjobs'), entity.json);
  result := TTblmaidjobsEntity(processJson(src, 'TTblmaidjobsEntity')[0]);
  
end;

function TRoomerDataSet.Tblmaidjobs_Entities_UpdateEntity(entity: TTblmaidjobsEntity): TTblmaidjobsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblmaidjobs/' + inttostr(entity.Id)), entity.json);
  result := TTblmaidjobsEntity(processJson(src, 'TTblmaidjobsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblmaidjobs_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblmaidjobs/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblmaidjobs_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidjobs');
end;

function TRoomerDataSet.Tblmaidjobs_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidjobs/' + inttostr(id));
end;

function TRoomerDataSet.Tblmaidjobs_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblmaidjobs/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblmaidjobs_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblmaidjobs/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblmaidjobs_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidjobs/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblmaidjobs_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidjobs/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblmaidjobs_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidjobs/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblmaidjobs_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblmaidjobs/execute', 'sql=' + sql);
end;


// ******************************* Tblmaidlists **********************************

function TRoomerDataSet.Tblmaidlists_Entities_FindAll(): Array_Of_TTblmaidlistsEntity;
var entities : Array_Of_TTblmaidlistsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidlists/findAll');
  list := processJson(res, 'TTblmaidlistsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblmaidlistsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblmaidlists_Entities_GetById(id: Integer): TTblmaidlistsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidlists/' + inttostr(id));
  list := processJson(res, 'TTblmaidlistsEntity');
  result := TTblmaidlistsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblmaidlists_Entities_GetBySql(sql: String): Array_Of_TTblmaidlistsEntity;
var entities : Array_Of_TTblmaidlistsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidlists/getSql?sql=' + sql);
  list := processJson(res, 'TTblmaidlistsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblmaidlistsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblmaidlists_Entities_GetListByWhere(where: String): Array_Of_TTblmaidlistsEntity;
var entities : Array_Of_TTblmaidlistsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidlists/getListByWhere?where=' + where);
  list := processJson(res, 'TTblmaidlistsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblmaidlistsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblmaidlists_Entities_GetEntityByWhere(where: String): TTblmaidlistsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblmaidlists/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblmaidlistsEntity');
  result := TTblmaidlistsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblmaidlists_Entities_SaveEntity(entity: TTblmaidlistsEntity): TTblmaidlistsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblmaidlists'), entity.json);
  result := TTblmaidlistsEntity(processJson(src, 'TTblmaidlistsEntity')[0]);
  
end;

function TRoomerDataSet.Tblmaidlists_Entities_UpdateEntity(entity: TTblmaidlistsEntity): TTblmaidlistsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblmaidlists/' + inttostr(entity.Id)), entity.json);
  result := TTblmaidlistsEntity(processJson(src, 'TTblmaidlistsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblmaidlists_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblmaidlists/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblmaidlists_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidlists');
end;

function TRoomerDataSet.Tblmaidlists_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidlists/' + inttostr(id));
end;

function TRoomerDataSet.Tblmaidlists_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblmaidlists/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblmaidlists_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblmaidlists/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblmaidlists_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidlists/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblmaidlists_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidlists/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblmaidlists_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblmaidlists/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblmaidlists_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblmaidlists/execute', 'sql=' + sql);
end;


// ******************************* Tblpoxexport **********************************

function TRoomerDataSet.Tblpoxexport_Entities_FindAll(): Array_Of_TTblpoxexportEntity;
var entities : Array_Of_TTblpoxexportEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblpoxexport/findAll');
  list := processJson(res, 'TTblpoxexportEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblpoxexportEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblpoxexport_Entities_GetById(id: Integer): TTblpoxexportEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblpoxexport/' + inttostr(id));
  list := processJson(res, 'TTblpoxexportEntity');
  result := TTblpoxexportEntity(list[0]);
  
end;

function TRoomerDataSet.Tblpoxexport_Entities_GetBySql(sql: String): Array_Of_TTblpoxexportEntity;
var entities : Array_Of_TTblpoxexportEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblpoxexport/getSql?sql=' + sql);
  list := processJson(res, 'TTblpoxexportEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblpoxexportEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblpoxexport_Entities_GetListByWhere(where: String): Array_Of_TTblpoxexportEntity;
var entities : Array_Of_TTblpoxexportEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblpoxexport/getListByWhere?where=' + where);
  list := processJson(res, 'TTblpoxexportEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblpoxexportEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblpoxexport_Entities_GetEntityByWhere(where: String): TTblpoxexportEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblpoxexport/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblpoxexportEntity');
  result := TTblpoxexportEntity(list[0]);
  
end;

function TRoomerDataSet.Tblpoxexport_Entities_SaveEntity(entity: TTblpoxexportEntity): TTblpoxexportEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblpoxexport'), entity.json);
  result := TTblpoxexportEntity(processJson(src, 'TTblpoxexportEntity')[0]);
  
end;

function TRoomerDataSet.Tblpoxexport_Entities_UpdateEntity(entity: TTblpoxexportEntity): TTblpoxexportEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblpoxexport/' + inttostr(entity.Id)), entity.json);
  result := TTblpoxexportEntity(processJson(src, 'TTblpoxexportEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblpoxexport_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblpoxexport/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblpoxexport_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblpoxexport');
end;

function TRoomerDataSet.Tblpoxexport_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblpoxexport/' + inttostr(id));
end;

function TRoomerDataSet.Tblpoxexport_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblpoxexport/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblpoxexport_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblpoxexport/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblpoxexport_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblpoxexport/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblpoxexport_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblpoxexport/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblpoxexport_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblpoxexport/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblpoxexport_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblpoxexport/execute', 'sql=' + sql);
end;


// ******************************* Tblpricecodes **********************************

function TRoomerDataSet.Tblpricecodes_Entities_FindAll(): Array_Of_TTblpricecodesEntity;
var entities : Array_Of_TTblpricecodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblpricecodes/findAll');
  list := processJson(res, 'TTblpricecodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblpricecodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblpricecodes_Entities_GetById(id: Integer): TTblpricecodesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblpricecodes/' + inttostr(id));
  list := processJson(res, 'TTblpricecodesEntity');
  result := TTblpricecodesEntity(list[0]);
  
end;

function TRoomerDataSet.Tblpricecodes_Entities_GetBySql(sql: String): Array_Of_TTblpricecodesEntity;
var entities : Array_Of_TTblpricecodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblpricecodes/getSql?sql=' + sql);
  list := processJson(res, 'TTblpricecodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblpricecodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblpricecodes_Entities_GetListByWhere(where: String): Array_Of_TTblpricecodesEntity;
var entities : Array_Of_TTblpricecodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblpricecodes/getListByWhere?where=' + where);
  list := processJson(res, 'TTblpricecodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblpricecodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblpricecodes_Entities_GetEntityByWhere(where: String): TTblpricecodesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblpricecodes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblpricecodesEntity');
  result := TTblpricecodesEntity(list[0]);
  
end;

function TRoomerDataSet.Tblpricecodes_Entities_SaveEntity(entity: TTblpricecodesEntity): TTblpricecodesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblpricecodes'), entity.json);
  result := TTblpricecodesEntity(processJson(src, 'TTblpricecodesEntity')[0]);
  
end;

function TRoomerDataSet.Tblpricecodes_Entities_UpdateEntity(entity: TTblpricecodesEntity): TTblpricecodesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblpricecodes/' + inttostr(entity.Id)), entity.json);
  result := TTblpricecodesEntity(processJson(src, 'TTblpricecodesEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblpricecodes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblpricecodes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblpricecodes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblpricecodes');
end;

function TRoomerDataSet.Tblpricecodes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblpricecodes/' + inttostr(id));
end;

function TRoomerDataSet.Tblpricecodes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblpricecodes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblpricecodes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblpricecodes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblpricecodes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblpricecodes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblpricecodes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblpricecodes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblpricecodes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblpricecodes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblpricecodes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblpricecodes/execute', 'sql=' + sql);
end;


// ******************************* Tblroomstatus **********************************

function TRoomerDataSet.Tblroomstatus_Entities_FindAll(): Array_Of_TTblroomstatusEntity;
var entities : Array_Of_TTblroomstatusEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblroomstatus/findAll');
  list := processJson(res, 'TTblroomstatusEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblroomstatusEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblroomstatus_Entities_GetById(id: Integer): TTblroomstatusEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblroomstatus/' + inttostr(id));
  list := processJson(res, 'TTblroomstatusEntity');
  result := TTblroomstatusEntity(list[0]);
  
end;

function TRoomerDataSet.Tblroomstatus_Entities_GetBySql(sql: String): Array_Of_TTblroomstatusEntity;
var entities : Array_Of_TTblroomstatusEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblroomstatus/getSql?sql=' + sql);
  list := processJson(res, 'TTblroomstatusEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblroomstatusEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblroomstatus_Entities_GetListByWhere(where: String): Array_Of_TTblroomstatusEntity;
var entities : Array_Of_TTblroomstatusEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblroomstatus/getListByWhere?where=' + where);
  list := processJson(res, 'TTblroomstatusEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblroomstatusEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblroomstatus_Entities_GetEntityByWhere(where: String): TTblroomstatusEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblroomstatus/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblroomstatusEntity');
  result := TTblroomstatusEntity(list[0]);
  
end;

function TRoomerDataSet.Tblroomstatus_Entities_SaveEntity(entity: TTblroomstatusEntity): TTblroomstatusEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblroomstatus'), entity.json);
  result := TTblroomstatusEntity(processJson(src, 'TTblroomstatusEntity')[0]);
  
end;

function TRoomerDataSet.Tblroomstatus_Entities_UpdateEntity(entity: TTblroomstatusEntity): TTblroomstatusEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblroomstatus/' + inttostr(entity.Id)), entity.json);
  result := TTblroomstatusEntity(processJson(src, 'TTblroomstatusEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblroomstatus_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblroomstatus/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblroomstatus_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblroomstatus');
end;

function TRoomerDataSet.Tblroomstatus_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblroomstatus/' + inttostr(id));
end;

function TRoomerDataSet.Tblroomstatus_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblroomstatus/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblroomstatus_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblroomstatus/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblroomstatus_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblroomstatus/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblroomstatus_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblroomstatus/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblroomstatus_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblroomstatus/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblroomstatus_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblroomstatus/execute', 'sql=' + sql);
end;


// ******************************* Tblseasons **********************************

function TRoomerDataSet.Tblseasons_Entities_FindAll(): Array_Of_TTblseasonsEntity;
var entities : Array_Of_TTblseasonsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblseasons/findAll');
  list := processJson(res, 'TTblseasonsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblseasonsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblseasons_Entities_GetById(id: Integer): TTblseasonsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblseasons/' + inttostr(id));
  list := processJson(res, 'TTblseasonsEntity');
  result := TTblseasonsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblseasons_Entities_GetBySql(sql: String): Array_Of_TTblseasonsEntity;
var entities : Array_Of_TTblseasonsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblseasons/getSql?sql=' + sql);
  list := processJson(res, 'TTblseasonsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblseasonsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblseasons_Entities_GetListByWhere(where: String): Array_Of_TTblseasonsEntity;
var entities : Array_Of_TTblseasonsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblseasons/getListByWhere?where=' + where);
  list := processJson(res, 'TTblseasonsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTblseasonsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tblseasons_Entities_GetEntityByWhere(where: String): TTblseasonsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tblseasons/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTblseasonsEntity');
  result := TTblseasonsEntity(list[0]);
  
end;

function TRoomerDataSet.Tblseasons_Entities_SaveEntity(entity: TTblseasonsEntity): TTblseasonsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblseasons'), entity.json);
  result := TTblseasonsEntity(processJson(src, 'TTblseasonsEntity')[0]);
  
end;

function TRoomerDataSet.Tblseasons_Entities_UpdateEntity(entity: TTblseasonsEntity): TTblseasonsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tblseasons/' + inttostr(entity.Id)), entity.json);
  result := TTblseasonsEntity(processJson(src, 'TTblseasonsEntity')[0]);
  
end;

procedure TRoomerDataSet.Tblseasons_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tblseasons/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tblseasons_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblseasons');
end;

function TRoomerDataSet.Tblseasons_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblseasons/' + inttostr(id));
end;

function TRoomerDataSet.Tblseasons_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tblseasons/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tblseasons_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblseasons/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tblseasons_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblseasons/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tblseasons_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblseasons/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tblseasons_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tblseasons/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tblseasons_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tblseasons/execute', 'sql=' + sql);
end;


// ******************************* Teldevices **********************************

function TRoomerDataSet.Teldevices_Entities_FindAll(): Array_Of_TTeldevicesEntity;
var entities : Array_Of_TTeldevicesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'teldevices/findAll');
  list := processJson(res, 'TTeldevicesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTeldevicesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Teldevices_Entities_GetById(id: Integer): TTeldevicesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'teldevices/' + inttostr(id));
  list := processJson(res, 'TTeldevicesEntity');
  result := TTeldevicesEntity(list[0]);
  
end;

function TRoomerDataSet.Teldevices_Entities_GetBySql(sql: String): Array_Of_TTeldevicesEntity;
var entities : Array_Of_TTeldevicesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'teldevices/getSql?sql=' + sql);
  list := processJson(res, 'TTeldevicesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTeldevicesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Teldevices_Entities_GetListByWhere(where: String): Array_Of_TTeldevicesEntity;
var entities : Array_Of_TTeldevicesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'teldevices/getListByWhere?where=' + where);
  list := processJson(res, 'TTeldevicesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTeldevicesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Teldevices_Entities_GetEntityByWhere(where: String): TTeldevicesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'teldevices/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTeldevicesEntity');
  result := TTeldevicesEntity(list[0]);
  
end;

function TRoomerDataSet.Teldevices_Entities_SaveEntity(entity: TTeldevicesEntity): TTeldevicesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'teldevices'), entity.json);
  result := TTeldevicesEntity(processJson(src, 'TTeldevicesEntity')[0]);
  
end;

function TRoomerDataSet.Teldevices_Entities_UpdateEntity(entity: TTeldevicesEntity): TTeldevicesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'teldevices/' + inttostr(entity.Id)), entity.json);
  result := TTeldevicesEntity(processJson(src, 'TTeldevicesEntity')[0]);
  
end;

procedure TRoomerDataSet.Teldevices_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'teldevices/' + inttostr(id)));
  
end;

function TRoomerDataSet.Teldevices_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'teldevices');
end;

function TRoomerDataSet.Teldevices_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'teldevices/' + inttostr(id));
end;

function TRoomerDataSet.Teldevices_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'teldevices/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Teldevices_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'teldevices/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Teldevices_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'teldevices/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Teldevices_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'teldevices/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Teldevices_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'teldevices/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Teldevices_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'teldevices/execute', 'sql=' + sql);
end;


// ******************************* Tellog **********************************

function TRoomerDataSet.Tellog_Entities_FindAll(): Array_Of_TTellogEntity;
var entities : Array_Of_TTellogEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tellog/findAll');
  list := processJson(res, 'TTellogEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTellogEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tellog_Entities_GetById(id: Integer): TTellogEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tellog/' + inttostr(id));
  list := processJson(res, 'TTellogEntity');
  result := TTellogEntity(list[0]);
  
end;

function TRoomerDataSet.Tellog_Entities_GetBySql(sql: String): Array_Of_TTellogEntity;
var entities : Array_Of_TTellogEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tellog/getSql?sql=' + sql);
  list := processJson(res, 'TTellogEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTellogEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tellog_Entities_GetListByWhere(where: String): Array_Of_TTellogEntity;
var entities : Array_Of_TTellogEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tellog/getListByWhere?where=' + where);
  list := processJson(res, 'TTellogEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTellogEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Tellog_Entities_GetEntityByWhere(where: String): TTellogEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'tellog/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTellogEntity');
  result := TTellogEntity(list[0]);
  
end;

function TRoomerDataSet.Tellog_Entities_SaveEntity(entity: TTellogEntity): TTellogEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tellog'), entity.json);
  result := TTellogEntity(processJson(src, 'TTellogEntity')[0]);
  
end;

function TRoomerDataSet.Tellog_Entities_UpdateEntity(entity: TTellogEntity): TTellogEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'tellog/' + inttostr(entity.Id)), entity.json);
  result := TTellogEntity(processJson(src, 'TTellogEntity')[0]);
  
end;

procedure TRoomerDataSet.Tellog_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'tellog/' + inttostr(id)));
  
end;

function TRoomerDataSet.Tellog_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tellog');
end;

function TRoomerDataSet.Tellog_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tellog/' + inttostr(id));
end;

function TRoomerDataSet.Tellog_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'tellog/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Tellog_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tellog/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Tellog_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tellog/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Tellog_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tellog/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Tellog_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'tellog/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Tellog_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'tellog/execute', 'sql=' + sql);
end;


// ******************************* Telpricegroups **********************************

function TRoomerDataSet.Telpricegroups_Entities_FindAll(): Array_Of_TTelpricegroupsEntity;
var entities : Array_Of_TTelpricegroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'telpricegroups/findAll');
  list := processJson(res, 'TTelpricegroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTelpricegroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Telpricegroups_Entities_GetById(id: Integer): TTelpricegroupsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'telpricegroups/' + inttostr(id));
  list := processJson(res, 'TTelpricegroupsEntity');
  result := TTelpricegroupsEntity(list[0]);
  
end;

function TRoomerDataSet.Telpricegroups_Entities_GetBySql(sql: String): Array_Of_TTelpricegroupsEntity;
var entities : Array_Of_TTelpricegroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'telpricegroups/getSql?sql=' + sql);
  list := processJson(res, 'TTelpricegroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTelpricegroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Telpricegroups_Entities_GetListByWhere(where: String): Array_Of_TTelpricegroupsEntity;
var entities : Array_Of_TTelpricegroupsEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'telpricegroups/getListByWhere?where=' + where);
  list := processJson(res, 'TTelpricegroupsEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTelpricegroupsEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Telpricegroups_Entities_GetEntityByWhere(where: String): TTelpricegroupsEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'telpricegroups/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTelpricegroupsEntity');
  result := TTelpricegroupsEntity(list[0]);
  
end;

function TRoomerDataSet.Telpricegroups_Entities_SaveEntity(entity: TTelpricegroupsEntity): TTelpricegroupsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'telpricegroups'), entity.json);
  result := TTelpricegroupsEntity(processJson(src, 'TTelpricegroupsEntity')[0]);
  
end;

function TRoomerDataSet.Telpricegroups_Entities_UpdateEntity(entity: TTelpricegroupsEntity): TTelpricegroupsEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'telpricegroups/' + inttostr(entity.Id)), entity.json);
  result := TTelpricegroupsEntity(processJson(src, 'TTelpricegroupsEntity')[0]);
  
end;

procedure TRoomerDataSet.Telpricegroups_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'telpricegroups/' + inttostr(id)));
  
end;

function TRoomerDataSet.Telpricegroups_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'telpricegroups');
end;

function TRoomerDataSet.Telpricegroups_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'telpricegroups/' + inttostr(id));
end;

function TRoomerDataSet.Telpricegroups_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'telpricegroups/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Telpricegroups_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'telpricegroups/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Telpricegroups_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'telpricegroups/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Telpricegroups_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'telpricegroups/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Telpricegroups_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'telpricegroups/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Telpricegroups_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'telpricegroups/execute', 'sql=' + sql);
end;


// ******************************* Telpricerules **********************************

function TRoomerDataSet.Telpricerules_Entities_FindAll(): Array_Of_TTelpricerulesEntity;
var entities : Array_Of_TTelpricerulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'telpricerules/findAll');
  list := processJson(res, 'TTelpricerulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTelpricerulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Telpricerules_Entities_GetById(id: Integer): TTelpricerulesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'telpricerules/' + inttostr(id));
  list := processJson(res, 'TTelpricerulesEntity');
  result := TTelpricerulesEntity(list[0]);
  
end;

function TRoomerDataSet.Telpricerules_Entities_GetBySql(sql: String): Array_Of_TTelpricerulesEntity;
var entities : Array_Of_TTelpricerulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'telpricerules/getSql?sql=' + sql);
  list := processJson(res, 'TTelpricerulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTelpricerulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Telpricerules_Entities_GetListByWhere(where: String): Array_Of_TTelpricerulesEntity;
var entities : Array_Of_TTelpricerulesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'telpricerules/getListByWhere?where=' + where);
  list := processJson(res, 'TTelpricerulesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTelpricerulesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Telpricerules_Entities_GetEntityByWhere(where: String): TTelpricerulesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'telpricerules/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTelpricerulesEntity');
  result := TTelpricerulesEntity(list[0]);
  
end;

function TRoomerDataSet.Telpricerules_Entities_SaveEntity(entity: TTelpricerulesEntity): TTelpricerulesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'telpricerules'), entity.json);
  result := TTelpricerulesEntity(processJson(src, 'TTelpricerulesEntity')[0]);
  
end;

function TRoomerDataSet.Telpricerules_Entities_UpdateEntity(entity: TTelpricerulesEntity): TTelpricerulesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'telpricerules/' + inttostr(entity.Id)), entity.json);
  result := TTelpricerulesEntity(processJson(src, 'TTelpricerulesEntity')[0]);
  
end;

procedure TRoomerDataSet.Telpricerules_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'telpricerules/' + inttostr(id)));
  
end;

function TRoomerDataSet.Telpricerules_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'telpricerules');
end;

function TRoomerDataSet.Telpricerules_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'telpricerules/' + inttostr(id));
end;

function TRoomerDataSet.Telpricerules_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'telpricerules/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Telpricerules_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'telpricerules/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Telpricerules_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'telpricerules/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Telpricerules_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'telpricerules/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Telpricerules_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'telpricerules/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Telpricerules_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'telpricerules/execute', 'sql=' + sql);
end;


// ******************************* Ttmp **********************************

function TRoomerDataSet.Ttmp_Entities_FindAll(): Array_Of_TTtmpEntity;
var entities : Array_Of_TTtmpEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'ttmp/findAll');
  list := processJson(res, 'TTtmpEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTtmpEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Ttmp_Entities_GetById(id: Integer): TTtmpEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'ttmp/' + inttostr(id));
  list := processJson(res, 'TTtmpEntity');
  result := TTtmpEntity(list[0]);
  
end;

function TRoomerDataSet.Ttmp_Entities_GetBySql(sql: String): Array_Of_TTtmpEntity;
var entities : Array_Of_TTtmpEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'ttmp/getSql?sql=' + sql);
  list := processJson(res, 'TTtmpEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTtmpEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Ttmp_Entities_GetListByWhere(where: String): Array_Of_TTtmpEntity;
var entities : Array_Of_TTtmpEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'ttmp/getListByWhere?where=' + where);
  list := processJson(res, 'TTtmpEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TTtmpEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Ttmp_Entities_GetEntityByWhere(where: String): TTtmpEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'ttmp/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TTtmpEntity');
  result := TTtmpEntity(list[0]);
  
end;

function TRoomerDataSet.Ttmp_Entities_SaveEntity(entity: TTtmpEntity): TTtmpEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'ttmp'), entity.json);
  result := TTtmpEntity(processJson(src, 'TTtmpEntity')[0]);
  
end;

function TRoomerDataSet.Ttmp_Entities_UpdateEntity(entity: TTtmpEntity): TTtmpEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'ttmp/' + inttostr(entity.Id)), entity.json);
  result := TTtmpEntity(processJson(src, 'TTtmpEntity')[0]);
  
end;

procedure TRoomerDataSet.Ttmp_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'ttmp/' + inttostr(id)));
  
end;

function TRoomerDataSet.Ttmp_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'ttmp');
end;

function TRoomerDataSet.Ttmp_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'ttmp/' + inttostr(id));
end;

function TRoomerDataSet.Ttmp_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'ttmp/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Ttmp_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'ttmp/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Ttmp_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'ttmp/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Ttmp_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'ttmp/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Ttmp_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'ttmp/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Ttmp_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'ttmp/execute', 'sql=' + sql);
end;


// ******************************* Vatcodes **********************************

function TRoomerDataSet.Vatcodes_Entities_FindAll(): Array_Of_TVatcodesEntity;
var entities : Array_Of_TVatcodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'vatcodes/findAll');
  list := processJson(res, 'TVatcodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TVatcodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Vatcodes_Entities_GetById(id: Integer): TVatcodesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'vatcodes/' + inttostr(id));
  list := processJson(res, 'TVatcodesEntity');
  result := TVatcodesEntity(list[0]);
  
end;

function TRoomerDataSet.Vatcodes_Entities_GetBySql(sql: String): Array_Of_TVatcodesEntity;
var entities : Array_Of_TVatcodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'vatcodes/getSql?sql=' + sql);
  list := processJson(res, 'TVatcodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TVatcodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Vatcodes_Entities_GetListByWhere(where: String): Array_Of_TVatcodesEntity;
var entities : Array_Of_TVatcodesEntity;
    List : TList<TPersistent>;
    i : Integer;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'vatcodes/getListByWhere?where=' + where);
  list := processJson(res, 'TVatcodesEntity');
  SetLength(entities, list.Count);
  for i := 0 to list.Count - 1 do
    entities[i] := TVatcodesEntity(list[i]);
  result := entities;
end;

function TRoomerDataSet.Vatcodes_Entities_GetEntityByWhere(where: String): TVatcodesEntity;
var List : TList<TPersistent>;
    res : String;
begin
  res := downloadUrlAsString(  FRoomerEntitiesUri + 'vatcodes/createGetEntityByWhere?where=' + where);
  list := processJson(res, 'TVatcodesEntity');
  result := TVatcodesEntity(list[0]);
  
end;

function TRoomerDataSet.Vatcodes_Entities_SaveEntity(entity: TVatcodesEntity): TVatcodesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PostAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'vatcodes'), entity.json);
  result := TVatcodesEntity(processJson(src, 'TVatcodesEntity')[0]);
  
end;

function TRoomerDataSet.Vatcodes_Entities_UpdateEntity(entity: TVatcodesEntity): TVatcodesEntity;
var src : String;
begin
  UnMarshal(entity);
  src := PutAsJSON(roomerClient, AnsiString(FRoomerEntitiesUri + 'vatcodes/' + inttostr(entity.Id)), entity.json);
  result := TVatcodesEntity(processJson(src, 'TVatcodesEntity')[0]);
  
end;

procedure TRoomerDataSet.Vatcodes_Entities_Delete(id: Integer);
begin
  AddAuthenticationHeaders(roomerClient);
  roomerClient.Delete(AnsiString(FRoomerEntitiesUri + 'vatcodes/' + inttostr(id)));
  
end;

function TRoomerDataSet.Vatcodes_DataSets_FindAll(): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'vatcodes');
end;

function TRoomerDataSet.Vatcodes_DataSets_GetById(id: Integer): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'vatcodes/' + inttostr(id));
end;

function TRoomerDataSet.Vatcodes_DataSets_Delete(id: Integer): String;
begin
  AddAuthenticationHeaders(roomerClient);
  {$IFNDEF USE_INDY}result :=  String({$ENDIF}roomerClient.Delete(AnsiString(FRoomerDatasetsUri + 'vatcodes/' + inttostr(id))){$IFNDEF USE_INDY}){$ENDIF};
end;

function TRoomerDataSet.Vatcodes_DataSets_GetBySql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'vatcodes/getSql', 'sql=' + sql);
end;

function TRoomerDataSet.Vatcodes_DataSets_GetListByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'vatcodes/getListByWhere?where=' + where);
end;

function TRoomerDataSet.Vatcodes_DataSets_GetEntityByWhere(where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'vatcodes/getEntityByWhere?where=' + where);
end;

function TRoomerDataSet.Vatcodes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
begin
  result := downloadUrlAsString(  FRoomerDatasetsUri + 'vatcodes/getValueOfFieldsFromWhereClause?fields=' + fields + '&where=' + where);
end;

function TRoomerDataSet.Vatcodes_DataSets_ExecuteSql(sql: String): String;
begin
  result := downloadUrlAsStringUsingPost(  FRoomerDatasetsUri + 'vatcodes/execute', 'sql=' + sql);
end;

