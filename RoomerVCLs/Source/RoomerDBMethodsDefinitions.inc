    function SystemGetDayGrid(fromDate: TDateTime; toDate: TDateTime; resType : String): String;

    function SystemGetRoomTypeStatus(fromDate: TDateTime; toDate: TDateTime): String;

    function SystemNextBookingDates(afterDate: TDateTime; ExcludedRooms: String): String;

    function SystemProcessRates(channelId : integer): String;

    function SystemProcessAvailabilities(plancodeId : integer): String;

    function SystemFreeQuery(query : String; SetLastAccess : boolean = true): String;

    function SystemFreeMultipleQuery(datasets : TList<TRoomerDataSet>; queries : TList<String>): String;

    function SystemFreeExecute(statement : String): String;

    function SystemFreeExecuteAsync(statement : String): String;

    function SystemFreeExecuteMultiple(statements : TList<String>): String;

    function SystemStartTransaction(): String;

    function SystemCommitTransaction(): String;

    function SystemRollbackTransaction(): String;

    function SystemStartGlobalTransaction(txId : String): String;

    function SystemCommitGlobalTransaction(txId : String): String;

    function SystemRollBackGlobalTransaction(txId : String): String;

    function SystemGetChannelRates(channelId, channelManagerId, planCodeId : integer): String;

    function SystemGetChannelRatesMultiple(fromDate : TDateTime; numDays : Integer; channels : String; channelManagerId, planCodeId : integer): String;

    function SystemGetChannelRates1812(fromDate : TDateTime; numDays : Integer; channel, channelManagerId, planCodeId : integer): String;

    function SystemGetAvailabilities(fromDate : TDateTime; numDays : Integer; channelManagerId, planCodeId : integer): String;

    function SystemBuildRoomStatus(ADate : TDateTime; NumDays : integer): String;

    function SystemGetAvailability(channelCode, channelManagerCode : String; Arrival, Departure : TDateTime): String;

    function SystemCreateReservation(channelCode, channelManagerCode, data : String): String;

    function SystemRemoveReservation(reservation : Integer; transaction : Boolean = True; makeCopy : Boolean = true; reason : String = ''; request : String = ''; information : String = ''; cancelType : Integer = 0): String;

    function SystemRemoveRoomReservation(roomReservation : Integer; transaction : Boolean = True; makeCopy : Boolean = true; reason : String = ''; request : String = ''; information : String = ''; cancelType : Integer = 0): String;

    function SystemCopyReservation(reservation : Integer; toDate : TDateTime): String;

    function SystemCopyReservationFromHotel(hotelId : String; reservation : Integer; toDate : TDateTime): String;

    function SystemMakeAvailabilityDirtyFromRoomReservation(roomReservation : Integer; info : String): String;

    function SystemMakeAvailabilityDirtyFromReservation(reservation : Integer; info : String): String;

    function SystemGetLanguages(): String;

    function SystemGetDictionary(id : Integer): String;

    function SystemCorrectRoomClasses(channelId : Integer; roomClasses : String): String;

    function SystemChangeAvailability(roomType : String; fromDate, toDate : TDateTime; subtract : Boolean; info : String): String;

    function SystemChangeAvailabilityForRoom(RoomReservation : Integer; subtract : Boolean): String;

    function SystemMoveRoom(roomReservationId : Integer; newRoom : String): String;

    function SystemSetRoomStatus(roomReservationId : Integer; newStatus : String): String;

    function SystemSetRoomStatusOfReservation(reservation : Integer; toStatus : String): String;

    function SystemNewReservationId(): Integer;

    function SystemNewRoomReservationId(): Integer;

    function SystemMultipleNewRoomReservationIds(numIds : Integer): String;

    function SystemNewPersonId(): Integer;

    function SystemMultipleNewPersonIds(numIds : Integer): String;

    function SystemNewInvoiceNumber(): Integer;

    function SystemMultipleNewInvoiceNumbers(numNumbers : Integer): String;

    function SystemCheckAccountPayBookKeyExists(PayBookKeyValue : String): Boolean;

    function SystemCheckAccountItemExists(AccountKeyValue : String): Boolean;

    function SystemCheckAccountCustomerExists(pIdValue : String): Boolean;

    function SystemSendInvoiceToBookkeeping(invoiceNumber : Integer): String;

    function SystemSetChannelAvailability(date, roomClass : String; dirty, availability, setAvailability, channelManagerId, planCodeId: Integer; info : String): String;

    function SystemSetMultipleChannelAvailability(date, roomClass : TList<String>; dirty, availability, setAvailability, channelManagerId, planCodeId: TList<Integer>; info : String): String;

    function SystemSetMultipleChannelAvailabilityPerId(id, dirty, availability, setAvailability: TList<Integer>; force : Boolean; info : String): String;

    function SystemGuestVipTypesAll(): String;

    function SystemGuestVipType(id : Integer): String;

    function SystemGuestVipTypesAdd(Code, Description : String; VipGrade : Integer): Integer;

    function SystemGuestVipTypesUpdate(id : Integer; Code, Description : String; VipGrade : Integer): String;

    function SystemGuestVipTypesDelete(id : Integer): String;

    function SystemGuestContactTypesAll(): String;

    function SystemGuestContactType(id : Integer): String;

    function SystemGuestContactTypesAdd(Code, Description : String; SystemType : Integer): Integer;

    function SystemGuestContactTypesUpdate(id : Integer; Code, Description : String; SystemType : Integer): String;

    function SystemGuestContactTypesDelete(id : Integer): String;

    function SystemConstantsPersonContactTypes(): String;

    function SystemConstantsGenderTypes(): String;

    function SystemConstantsPersonAddressTypes(): String;

    function SystemConstantsPersonVisitorTypes(): String;

    function SystemFinanceListCustomers(): String;

    function SystemFinanceListProducts(): String;

    function SystemFinanceListPaymentTypes(): String;

    function SystemGuestProfilesList(Filter : String): String;

    function SystemGuestProfilesEntry(id : Integer): String;

    function SystemGuestProfilesEntryAdd(active : Integer;
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

    function SystemGuestProfilesEntryUpdate(id : Integer;
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

    function SystemGuestProfilesChildren(id : Integer): String;

    function SystemGuestProfilesChildDelete(id : Integer): String;

    function SystemGuestProfilesChildAdd(personId : Integer; name : String; childPersonId : Integer = 0): Integer;

    function SystemGuestProfilesChildUpdate(id : Integer; personId : Integer; name : String; childPersonId : Integer = 0): String;

    function SystemGuestProfilesContacts(id : Integer): String;

    function SystemGuestProfilesContactDelete(id : Integer): String;

    function SystemGuestProfilesContactAdd(personId, contactTypeId : Integer; description, contactInfo, extraInfo : String): Integer;

    function SystemGuestProfilesContactUpdate(id, personId, contactTypeId : Integer; description, contactInfo, extraInfo : String): String;

    function SystemGuestProfilesAddresses(id : Integer): String;

    function SystemGuestProfilesAddressDelete(id : Integer): String;

    function SystemGuestProfilesAddressAdd(personId, systemType : Integer; address1, address2, city, zip, state : String; countryId : Integer): Integer;

    function SystemGuestProfilesAddressUpdate(id, personId, systemType : Integer; address1, address2, city, zip, state : String; countryId : Integer): String;

    function SystemGuestProfilesItems(id : Integer): String;

    function SystemGuestProfilesItemDelete(id : Integer): String;

    function SystemGuestProfilesItemAdd(personId, itemId, numItems : Integer; notes : String; price : Double): Integer;

    function SystemGuestProfilesItemUpdate(id, personId, itemId, numItems : Integer; notes : String; price : Double): String;

    function SystemcheckRuleConflict(id : Integer;
active : Integer;
description : String;
selectedRoomTypes : String;
occupancyLimit : Double;
whichDaysIndex : Integer;
selectedDays : String;
selectedMonths : String;
selectedYears : String;
selectedChannelsIDs : String): String;

    function SystemSaveSplittedToggleRule(id : Integer): String;

    function SystemDeleteToggleRule(id : Integer): String;

    function SystemListTogglingRules(onlyActive : Boolean): Array_Of_TChanneltogglingrulesEntity;

    function SystemChangeRoomNumber(oldNumber, newNumber : String): String;

    function SystemChangeRoomType(oldType, newType : String): String;

    function SystemChangeRoomTypeForRoom(room, oldType, newType : String): String;

    function SystemTaxesList(): String;

    function SystemTaxesUnlinkItem(taxId : Integer; item : String): String;

    function SystemTaxesUnlinkItemId(taxId : Integer; itemId : Integer): String;

    function SystemTaxesLinkItem(taxId : Integer; item : String): String;

    function SystemTaxesLinkItemId(taxId : Integer; itemId : Integer): String;

    function SystemTaxesPerItem(item : String): String;

    function SystemTaxesTaxesAndItems(item : String): String;

    function SystemGetStaticResources(): String;

    function SystemGetStaticResourcesFiltered(filter : String): String;

    function SystemDeleteStaticResource(id : Integer): String;

    function SystemAddStaticResource(keyString, originalName, uri, access : String): String;

    function SystemUpdateStaticResource(id : Integer; keyString, originalName, uri, access : String): String;

    function SystemGetPaymentAssuranceMatrix(channelManagerCode : String): String;

    function SystemUpdatePaymentAssuranceMatrixItem(channelManagerCode, channelCode, roomTypeCode : String; value : Integer): String;

    function SystemGetConfirmationEmailMatrix(): String;

    function SystemUpdateConfirmationEmailMatrix(channelManagerCode, channelCode : String; value : Integer): String;

    function SystemGetHotelEmailMatrix(): String;

    function SystemUpdateHotelEmailMatrix(channelManagerCode, channelCode : String; value : Integer): String;

    function SystemCancelReservation(reservation : Integer; reason : String = ''): String;

    function SystemCancelRoomReservation(roomReservation : Integer; reason : String = ''): String;

    function SystemCorrectDoorCodeSettings(roomReservation : Integer): String;

    function SystemAddToDoorCodeSchedules(reservation : Integer): String;

    function SystemIsRoomWithdrawalAllowed(roomReservation : Integer; amount : Double): Boolean;

    function SystempackagesList(packageCode : String; currency : String = ''): String;

    function SystempackagesRemove(packageCode : String; roomReservation, roomReservationAlias : Integer; restorePrice : Boolean = False; splitNumber : Integer = 0; invoiceNumber : Integer = -1): String;

    function SystempackagesAdd(packageCode : String; roomReservation, roomReservationAlias : Integer; rate : Double = 0; currency : String = ''; splitNumber : Integer = 0; invoiceNumber : Integer = -1): String;

    function SystempackagesRecalcInvoice(roomReservation, roomReservationAlias : Integer; splitNumber : Integer = 0; invoiceNumber : Integer = -1): String;

    function SystempackagesRecalcInvoiceHeader(roomReservation, roomReservationAlias : Integer; splitNumber : Integer = 0; invoiceNumber : Integer = -1): String;

    function SystempackagesCreateHeaderIfNotExists(roomReservation, roomReservationAlias : Integer; splitNumber : Integer = 0; invoiceNumber : Integer = -1): String;

    function SystemListReservations(fromDate, toDate : TDateTime): String;

    function SystemListInvoicesOfReservations(fromDate, toDate : TDateTime): String;

    // ******************** Delphi Methods of Java Entities for table 'cancellationdetails' ******************
    function Cancellationdetails_Entities_FindAll(): Array_Of_TCancellationdetailsEntity;
    function Cancellationdetails_Entities_GetById(id: Integer): TCancellationdetailsEntity;
    function Cancellationdetails_Entities_GetBySql(sql: String): Array_Of_TCancellationdetailsEntity;
    function Cancellationdetails_Entities_GetEntityByWhere(where: String): TCancellationdetailsEntity;
    function Cancellationdetails_Entities_GetListByWhere(where: String): Array_Of_TCancellationdetailsEntity;
    function Cancellationdetails_Entities_SaveEntity(entity: TCancellationdetailsEntity): TCancellationdetailsEntity;
    function Cancellationdetails_Entities_UpdateEntity(entity: TCancellationdetailsEntity): TCancellationdetailsEntity;
    procedure Cancellationdetails_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'cancellationdetails' ******************
    function Cancellationdetails_DataSets_FindAll(): String;
    function Cancellationdetails_DataSets_GetById(id: Integer): String;
    function Cancellationdetails_DataSets_Delete(id: Integer): String;
    function Cancellationdetails_DataSets_GetBySql(sql: String): String;
    function Cancellationdetails_DataSets_GetEntityByWhere(where: String): String;
    function Cancellationdetails_DataSets_GetListByWhere(where: String): String;
    function Cancellationdetails_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Cancellationdetails_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'channelclassrelations' ******************
    function Channelclassrelations_Entities_FindAll(): Array_Of_TChannelclassrelationsEntity;
    function Channelclassrelations_Entities_GetById(id: Integer): TChannelclassrelationsEntity;
    function Channelclassrelations_Entities_GetBySql(sql: String): Array_Of_TChannelclassrelationsEntity;
    function Channelclassrelations_Entities_GetEntityByWhere(where: String): TChannelclassrelationsEntity;
    function Channelclassrelations_Entities_GetListByWhere(where: String): Array_Of_TChannelclassrelationsEntity;
    function Channelclassrelations_Entities_SaveEntity(entity: TChannelclassrelationsEntity): TChannelclassrelationsEntity;
    function Channelclassrelations_Entities_UpdateEntity(entity: TChannelclassrelationsEntity): TChannelclassrelationsEntity;
    procedure Channelclassrelations_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'channelclassrelations' ******************
    function Channelclassrelations_DataSets_FindAll(): String;
    function Channelclassrelations_DataSets_GetById(id: Integer): String;
    function Channelclassrelations_DataSets_Delete(id: Integer): String;
    function Channelclassrelations_DataSets_GetBySql(sql: String): String;
    function Channelclassrelations_DataSets_GetEntityByWhere(where: String): String;
    function Channelclassrelations_DataSets_GetListByWhere(where: String): String;
    function Channelclassrelations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Channelclassrelations_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'channelmanagers' ******************
    function Channelmanagers_Entities_FindAll(): Array_Of_TChannelmanagersEntity;
    function Channelmanagers_Entities_GetById(id: Integer): TChannelmanagersEntity;
    function Channelmanagers_Entities_GetBySql(sql: String): Array_Of_TChannelmanagersEntity;
    function Channelmanagers_Entities_GetEntityByWhere(where: String): TChannelmanagersEntity;
    function Channelmanagers_Entities_GetListByWhere(where: String): Array_Of_TChannelmanagersEntity;
    function Channelmanagers_Entities_SaveEntity(entity: TChannelmanagersEntity): TChannelmanagersEntity;
    function Channelmanagers_Entities_UpdateEntity(entity: TChannelmanagersEntity): TChannelmanagersEntity;
    procedure Channelmanagers_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'channelmanagers' ******************
    function Channelmanagers_DataSets_FindAll(): String;
    function Channelmanagers_DataSets_GetById(id: Integer): String;
    function Channelmanagers_DataSets_Delete(id: Integer): String;
    function Channelmanagers_DataSets_GetBySql(sql: String): String;
    function Channelmanagers_DataSets_GetEntityByWhere(where: String): String;
    function Channelmanagers_DataSets_GetListByWhere(where: String): String;
    function Channelmanagers_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Channelmanagers_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'channelplancodes' ******************
    function Channelplancodes_Entities_FindAll(): Array_Of_TChannelplancodesEntity;
    function Channelplancodes_Entities_GetById(id: Integer): TChannelplancodesEntity;
    function Channelplancodes_Entities_GetBySql(sql: String): Array_Of_TChannelplancodesEntity;
    function Channelplancodes_Entities_GetEntityByWhere(where: String): TChannelplancodesEntity;
    function Channelplancodes_Entities_GetListByWhere(where: String): Array_Of_TChannelplancodesEntity;
    function Channelplancodes_Entities_SaveEntity(entity: TChannelplancodesEntity): TChannelplancodesEntity;
    function Channelplancodes_Entities_UpdateEntity(entity: TChannelplancodesEntity): TChannelplancodesEntity;
    procedure Channelplancodes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'channelplancodes' ******************
    function Channelplancodes_DataSets_FindAll(): String;
    function Channelplancodes_DataSets_GetById(id: Integer): String;
    function Channelplancodes_DataSets_Delete(id: Integer): String;
    function Channelplancodes_DataSets_GetBySql(sql: String): String;
    function Channelplancodes_DataSets_GetEntityByWhere(where: String): String;
    function Channelplancodes_DataSets_GetListByWhere(where: String): String;
    function Channelplancodes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Channelplancodes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'channelrates' ******************
    function Channelrates_Entities_FindAll(): Array_Of_TChannelratesEntity;
    function Channelrates_Entities_GetById(id: Integer): TChannelratesEntity;
    function Channelrates_Entities_GetBySql(sql: String): Array_Of_TChannelratesEntity;
    function Channelrates_Entities_GetEntityByWhere(where: String): TChannelratesEntity;
    function Channelrates_Entities_GetListByWhere(where: String): Array_Of_TChannelratesEntity;
    function Channelrates_Entities_SaveEntity(entity: TChannelratesEntity): TChannelratesEntity;
    function Channelrates_Entities_UpdateEntity(entity: TChannelratesEntity): TChannelratesEntity;
    procedure Channelrates_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'channelrates' ******************
    function Channelrates_DataSets_FindAll(): String;
    function Channelrates_DataSets_GetById(id: Integer): String;
    function Channelrates_DataSets_Delete(id: Integer): String;
    function Channelrates_DataSets_GetBySql(sql: String): String;
    function Channelrates_DataSets_GetEntityByWhere(where: String): String;
    function Channelrates_DataSets_GetListByWhere(where: String): String;
    function Channelrates_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Channelrates_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'channelratesavailabilities' ******************
    function Channelratesavailabilities_Entities_FindAll(): Array_Of_TChannelratesavailabilitiesEntity;
    function Channelratesavailabilities_Entities_GetById(id: Integer): TChannelratesavailabilitiesEntity;
    function Channelratesavailabilities_Entities_GetBySql(sql: String): Array_Of_TChannelratesavailabilitiesEntity;
    function Channelratesavailabilities_Entities_GetEntityByWhere(where: String): TChannelratesavailabilitiesEntity;
    function Channelratesavailabilities_Entities_GetListByWhere(where: String): Array_Of_TChannelratesavailabilitiesEntity;
    function Channelratesavailabilities_Entities_SaveEntity(entity: TChannelratesavailabilitiesEntity): TChannelratesavailabilitiesEntity;
    function Channelratesavailabilities_Entities_UpdateEntity(entity: TChannelratesavailabilitiesEntity): TChannelratesavailabilitiesEntity;
    procedure Channelratesavailabilities_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'channelratesavailabilities' ******************
    function Channelratesavailabilities_DataSets_FindAll(): String;
    function Channelratesavailabilities_DataSets_GetById(id: Integer): String;
    function Channelratesavailabilities_DataSets_Delete(id: Integer): String;
    function Channelratesavailabilities_DataSets_GetBySql(sql: String): String;
    function Channelratesavailabilities_DataSets_GetEntityByWhere(where: String): String;
    function Channelratesavailabilities_DataSets_GetListByWhere(where: String): String;
    function Channelratesavailabilities_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Channelratesavailabilities_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'channels' ******************
    function Channels_Entities_FindAll(): Array_Of_TChannelsEntity;
    function Channels_Entities_GetById(id: Integer): TChannelsEntity;
    function Channels_Entities_GetBySql(sql: String): Array_Of_TChannelsEntity;
    function Channels_Entities_GetEntityByWhere(where: String): TChannelsEntity;
    function Channels_Entities_GetListByWhere(where: String): Array_Of_TChannelsEntity;
    function Channels_Entities_SaveEntity(entity: TChannelsEntity): TChannelsEntity;
    function Channels_Entities_UpdateEntity(entity: TChannelsEntity): TChannelsEntity;
    procedure Channels_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'channels' ******************
    function Channels_DataSets_FindAll(): String;
    function Channels_DataSets_GetById(id: Integer): String;
    function Channels_DataSets_Delete(id: Integer): String;
    function Channels_DataSets_GetBySql(sql: String): String;
    function Channels_DataSets_GetEntityByWhere(where: String): String;
    function Channels_DataSets_GetListByWhere(where: String): String;
    function Channels_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Channels_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'channeltogglingrules' ******************
    function Channeltogglingrules_Entities_FindAll(): Array_Of_TChanneltogglingrulesEntity;
    function Channeltogglingrules_Entities_GetById(id: Integer): TChanneltogglingrulesEntity;
    function Channeltogglingrules_Entities_GetBySql(sql: String): Array_Of_TChanneltogglingrulesEntity;
    function Channeltogglingrules_Entities_GetEntityByWhere(where: String): TChanneltogglingrulesEntity;
    function Channeltogglingrules_Entities_GetListByWhere(where: String): Array_Of_TChanneltogglingrulesEntity;
    function Channeltogglingrules_Entities_SaveEntity(entity: TChanneltogglingrulesEntity): TChanneltogglingrulesEntity;
    function Channeltogglingrules_Entities_UpdateEntity(entity: TChanneltogglingrulesEntity): TChanneltogglingrulesEntity;
    procedure Channeltogglingrules_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'channeltogglingrules' ******************
    function Channeltogglingrules_DataSets_FindAll(): String;
    function Channeltogglingrules_DataSets_GetById(id: Integer): String;
    function Channeltogglingrules_DataSets_Delete(id: Integer): String;
    function Channeltogglingrules_DataSets_GetBySql(sql: String): String;
    function Channeltogglingrules_DataSets_GetEntityByWhere(where: String): String;
    function Channeltogglingrules_DataSets_GetListByWhere(where: String): String;
    function Channeltogglingrules_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Channeltogglingrules_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'channeltogglingrulessplit' ******************
    function Channeltogglingrulessplit_Entities_FindAll(): Array_Of_TChanneltogglingrulessplitEntity;
    function Channeltogglingrulessplit_Entities_GetById(id: Integer): TChanneltogglingrulessplitEntity;
    function Channeltogglingrulessplit_Entities_GetBySql(sql: String): Array_Of_TChanneltogglingrulessplitEntity;
    function Channeltogglingrulessplit_Entities_GetEntityByWhere(where: String): TChanneltogglingrulessplitEntity;
    function Channeltogglingrulessplit_Entities_GetListByWhere(where: String): Array_Of_TChanneltogglingrulessplitEntity;
    function Channeltogglingrulessplit_Entities_SaveEntity(entity: TChanneltogglingrulessplitEntity): TChanneltogglingrulessplitEntity;
    function Channeltogglingrulessplit_Entities_UpdateEntity(entity: TChanneltogglingrulessplitEntity): TChanneltogglingrulessplitEntity;
    procedure Channeltogglingrulessplit_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'channeltogglingrulessplit' ******************
    function Channeltogglingrulessplit_DataSets_FindAll(): String;
    function Channeltogglingrulessplit_DataSets_GetById(id: Integer): String;
    function Channeltogglingrulessplit_DataSets_Delete(id: Integer): String;
    function Channeltogglingrulessplit_DataSets_GetBySql(sql: String): String;
    function Channeltogglingrulessplit_DataSets_GetEntityByWhere(where: String): String;
    function Channeltogglingrulessplit_DataSets_GetListByWhere(where: String): String;
    function Channeltogglingrulessplit_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Channeltogglingrulessplit_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'colors' ******************
    function Colors_Entities_FindAll(): Array_Of_TColorsEntity;
    function Colors_Entities_GetById(id: Integer): TColorsEntity;
    function Colors_Entities_GetBySql(sql: String): Array_Of_TColorsEntity;
    function Colors_Entities_GetEntityByWhere(where: String): TColorsEntity;
    function Colors_Entities_GetListByWhere(where: String): Array_Of_TColorsEntity;
    function Colors_Entities_SaveEntity(entity: TColorsEntity): TColorsEntity;
    function Colors_Entities_UpdateEntity(entity: TColorsEntity): TColorsEntity;
    procedure Colors_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'colors' ******************
    function Colors_DataSets_FindAll(): String;
    function Colors_DataSets_GetById(id: Integer): String;
    function Colors_DataSets_Delete(id: Integer): String;
    function Colors_DataSets_GetBySql(sql: String): String;
    function Colors_DataSets_GetEntityByWhere(where: String): String;
    function Colors_DataSets_GetListByWhere(where: String): String;
    function Colors_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Colors_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'control' ******************
    function Control_Entities_FindAll(): Array_Of_TControlEntity;
    function Control_Entities_GetById(id: Integer): TControlEntity;
    function Control_Entities_GetBySql(sql: String): Array_Of_TControlEntity;
    function Control_Entities_GetEntityByWhere(where: String): TControlEntity;
    function Control_Entities_GetListByWhere(where: String): Array_Of_TControlEntity;
    function Control_Entities_SaveEntity(entity: TControlEntity): TControlEntity;
    function Control_Entities_UpdateEntity(entity: TControlEntity): TControlEntity;
    procedure Control_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'control' ******************
    function Control_DataSets_FindAll(): String;
    function Control_DataSets_GetById(id: Integer): String;
    function Control_DataSets_Delete(id: Integer): String;
    function Control_DataSets_GetBySql(sql: String): String;
    function Control_DataSets_GetEntityByWhere(where: String): String;
    function Control_DataSets_GetListByWhere(where: String): String;
    function Control_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Control_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'countries' ******************
    function Countries_Entities_FindAll(): Array_Of_TCountriesEntity;
    function Countries_Entities_GetById(id: Integer): TCountriesEntity;
    function Countries_Entities_GetBySql(sql: String): Array_Of_TCountriesEntity;
    function Countries_Entities_GetEntityByWhere(where: String): TCountriesEntity;
    function Countries_Entities_GetListByWhere(where: String): Array_Of_TCountriesEntity;
    function Countries_Entities_SaveEntity(entity: TCountriesEntity): TCountriesEntity;
    function Countries_Entities_UpdateEntity(entity: TCountriesEntity): TCountriesEntity;
    procedure Countries_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'countries' ******************
    function Countries_DataSets_FindAll(): String;
    function Countries_DataSets_GetById(id: Integer): String;
    function Countries_DataSets_Delete(id: Integer): String;
    function Countries_DataSets_GetBySql(sql: String): String;
    function Countries_DataSets_GetEntityByWhere(where: String): String;
    function Countries_DataSets_GetListByWhere(where: String): String;
    function Countries_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Countries_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'countrygroups' ******************
    function Countrygroups_Entities_FindAll(): Array_Of_TCountrygroupsEntity;
    function Countrygroups_Entities_GetById(id: Integer): TCountrygroupsEntity;
    function Countrygroups_Entities_GetBySql(sql: String): Array_Of_TCountrygroupsEntity;
    function Countrygroups_Entities_GetEntityByWhere(where: String): TCountrygroupsEntity;
    function Countrygroups_Entities_GetListByWhere(where: String): Array_Of_TCountrygroupsEntity;
    function Countrygroups_Entities_SaveEntity(entity: TCountrygroupsEntity): TCountrygroupsEntity;
    function Countrygroups_Entities_UpdateEntity(entity: TCountrygroupsEntity): TCountrygroupsEntity;
    procedure Countrygroups_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'countrygroups' ******************
    function Countrygroups_DataSets_FindAll(): String;
    function Countrygroups_DataSets_GetById(id: Integer): String;
    function Countrygroups_DataSets_Delete(id: Integer): String;
    function Countrygroups_DataSets_GetBySql(sql: String): String;
    function Countrygroups_DataSets_GetEntityByWhere(where: String): String;
    function Countrygroups_DataSets_GetListByWhere(where: String): String;
    function Countrygroups_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Countrygroups_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'currencies' ******************
    function Currencies_Entities_FindAll(): Array_Of_TCurrenciesEntity;
    function Currencies_Entities_GetById(id: Integer): TCurrenciesEntity;
    function Currencies_Entities_GetBySql(sql: String): Array_Of_TCurrenciesEntity;
    function Currencies_Entities_GetEntityByWhere(where: String): TCurrenciesEntity;
    function Currencies_Entities_GetListByWhere(where: String): Array_Of_TCurrenciesEntity;
    function Currencies_Entities_SaveEntity(entity: TCurrenciesEntity): TCurrenciesEntity;
    function Currencies_Entities_UpdateEntity(entity: TCurrenciesEntity): TCurrenciesEntity;
    procedure Currencies_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'currencies' ******************
    function Currencies_DataSets_FindAll(): String;
    function Currencies_DataSets_GetById(id: Integer): String;
    function Currencies_DataSets_Delete(id: Integer): String;
    function Currencies_DataSets_GetBySql(sql: String): String;
    function Currencies_DataSets_GetEntityByWhere(where: String): String;
    function Currencies_DataSets_GetListByWhere(where: String): String;
    function Currencies_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Currencies_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'customerpreferences' ******************
    function Customerpreferences_Entities_FindAll(): Array_Of_TCustomerpreferencesEntity;
    function Customerpreferences_Entities_GetById(id: Integer): TCustomerpreferencesEntity;
    function Customerpreferences_Entities_GetBySql(sql: String): Array_Of_TCustomerpreferencesEntity;
    function Customerpreferences_Entities_GetEntityByWhere(where: String): TCustomerpreferencesEntity;
    function Customerpreferences_Entities_GetListByWhere(where: String): Array_Of_TCustomerpreferencesEntity;
    function Customerpreferences_Entities_SaveEntity(entity: TCustomerpreferencesEntity): TCustomerpreferencesEntity;
    function Customerpreferences_Entities_UpdateEntity(entity: TCustomerpreferencesEntity): TCustomerpreferencesEntity;
    procedure Customerpreferences_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'customerpreferences' ******************
    function Customerpreferences_DataSets_FindAll(): String;
    function Customerpreferences_DataSets_GetById(id: Integer): String;
    function Customerpreferences_DataSets_Delete(id: Integer): String;
    function Customerpreferences_DataSets_GetBySql(sql: String): String;
    function Customerpreferences_DataSets_GetEntityByWhere(where: String): String;
    function Customerpreferences_DataSets_GetListByWhere(where: String): String;
    function Customerpreferences_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Customerpreferences_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'customers' ******************
    function Customers_Entities_FindAll(): Array_Of_TCustomersEntity;
    function Customers_Entities_GetById(id: Integer): TCustomersEntity;
    function Customers_Entities_GetBySql(sql: String): Array_Of_TCustomersEntity;
    function Customers_Entities_GetEntityByWhere(where: String): TCustomersEntity;
    function Customers_Entities_GetListByWhere(where: String): Array_Of_TCustomersEntity;
    function Customers_Entities_SaveEntity(entity: TCustomersEntity): TCustomersEntity;
    function Customers_Entities_UpdateEntity(entity: TCustomersEntity): TCustomersEntity;
    procedure Customers_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'customers' ******************
    function Customers_DataSets_FindAll(): String;
    function Customers_DataSets_GetById(id: Integer): String;
    function Customers_DataSets_Delete(id: Integer): String;
    function Customers_DataSets_GetBySql(sql: String): String;
    function Customers_DataSets_GetEntityByWhere(where: String): String;
    function Customers_DataSets_GetListByWhere(where: String): String;
    function Customers_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Customers_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'customertypes' ******************
    function Customertypes_Entities_FindAll(): Array_Of_TCustomertypesEntity;
    function Customertypes_Entities_GetById(id: Integer): TCustomertypesEntity;
    function Customertypes_Entities_GetBySql(sql: String): Array_Of_TCustomertypesEntity;
    function Customertypes_Entities_GetEntityByWhere(where: String): TCustomertypesEntity;
    function Customertypes_Entities_GetListByWhere(where: String): Array_Of_TCustomertypesEntity;
    function Customertypes_Entities_SaveEntity(entity: TCustomertypesEntity): TCustomertypesEntity;
    function Customertypes_Entities_UpdateEntity(entity: TCustomertypesEntity): TCustomertypesEntity;
    procedure Customertypes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'customertypes' ******************
    function Customertypes_DataSets_FindAll(): String;
    function Customertypes_DataSets_GetById(id: Integer): String;
    function Customertypes_DataSets_Delete(id: Integer): String;
    function Customertypes_DataSets_GetBySql(sql: String): String;
    function Customertypes_DataSets_GetEntityByWhere(where: String): String;
    function Customertypes_DataSets_GetListByWhere(where: String): String;
    function Customertypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Customertypes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'dictionary' ******************
    function Dictionary_Entities_FindAll(): Array_Of_TDictionaryEntity;
    function Dictionary_Entities_GetById(id: Integer): TDictionaryEntity;
    function Dictionary_Entities_GetBySql(sql: String): Array_Of_TDictionaryEntity;
    function Dictionary_Entities_GetEntityByWhere(where: String): TDictionaryEntity;
    function Dictionary_Entities_GetListByWhere(where: String): Array_Of_TDictionaryEntity;
    function Dictionary_Entities_SaveEntity(entity: TDictionaryEntity): TDictionaryEntity;
    function Dictionary_Entities_UpdateEntity(entity: TDictionaryEntity): TDictionaryEntity;
    procedure Dictionary_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'dictionary' ******************
    function Dictionary_DataSets_FindAll(): String;
    function Dictionary_DataSets_GetById(id: Integer): String;
    function Dictionary_DataSets_Delete(id: Integer): String;
    function Dictionary_DataSets_GetBySql(sql: String): String;
    function Dictionary_DataSets_GetEntityByWhere(where: String): String;
    function Dictionary_DataSets_GetListByWhere(where: String): String;
    function Dictionary_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Dictionary_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'facilityactiontypes' ******************
    function Facilityactiontypes_Entities_FindAll(): Array_Of_TFacilityactiontypesEntity;
    function Facilityactiontypes_Entities_GetById(id: Integer): TFacilityactiontypesEntity;
    function Facilityactiontypes_Entities_GetBySql(sql: String): Array_Of_TFacilityactiontypesEntity;
    function Facilityactiontypes_Entities_GetEntityByWhere(where: String): TFacilityactiontypesEntity;
    function Facilityactiontypes_Entities_GetListByWhere(where: String): Array_Of_TFacilityactiontypesEntity;
    function Facilityactiontypes_Entities_SaveEntity(entity: TFacilityactiontypesEntity): TFacilityactiontypesEntity;
    function Facilityactiontypes_Entities_UpdateEntity(entity: TFacilityactiontypesEntity): TFacilityactiontypesEntity;
    procedure Facilityactiontypes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'facilityactiontypes' ******************
    function Facilityactiontypes_DataSets_FindAll(): String;
    function Facilityactiontypes_DataSets_GetById(id: Integer): String;
    function Facilityactiontypes_DataSets_Delete(id: Integer): String;
    function Facilityactiontypes_DataSets_GetBySql(sql: String): String;
    function Facilityactiontypes_DataSets_GetEntityByWhere(where: String): String;
    function Facilityactiontypes_DataSets_GetListByWhere(where: String): String;
    function Facilityactiontypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Facilityactiontypes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'fakenames' ******************
    function Fakenames_Entities_FindAll(): Array_Of_TFakenamesEntity;
    function Fakenames_Entities_GetById(id: Integer): TFakenamesEntity;
    function Fakenames_Entities_GetBySql(sql: String): Array_Of_TFakenamesEntity;
    function Fakenames_Entities_GetEntityByWhere(where: String): TFakenamesEntity;
    function Fakenames_Entities_GetListByWhere(where: String): Array_Of_TFakenamesEntity;
    function Fakenames_Entities_SaveEntity(entity: TFakenamesEntity): TFakenamesEntity;
    function Fakenames_Entities_UpdateEntity(entity: TFakenamesEntity): TFakenamesEntity;
    procedure Fakenames_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'fakenames' ******************
    function Fakenames_DataSets_FindAll(): String;
    function Fakenames_DataSets_GetById(id: Integer): String;
    function Fakenames_DataSets_Delete(id: Integer): String;
    function Fakenames_DataSets_GetBySql(sql: String): String;
    function Fakenames_DataSets_GetEntityByWhere(where: String): String;
    function Fakenames_DataSets_GetListByWhere(where: String): String;
    function Fakenames_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Fakenames_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'hotelconfigurations' ******************
    function Hotelconfigurations_Entities_FindAll(): Array_Of_THotelconfigurationsEntity;
    function Hotelconfigurations_Entities_GetById(id: Integer): THotelconfigurationsEntity;
    function Hotelconfigurations_Entities_GetBySql(sql: String): Array_Of_THotelconfigurationsEntity;
    function Hotelconfigurations_Entities_GetEntityByWhere(where: String): THotelconfigurationsEntity;
    function Hotelconfigurations_Entities_GetListByWhere(where: String): Array_Of_THotelconfigurationsEntity;
    function Hotelconfigurations_Entities_SaveEntity(entity: THotelconfigurationsEntity): THotelconfigurationsEntity;
    function Hotelconfigurations_Entities_UpdateEntity(entity: THotelconfigurationsEntity): THotelconfigurationsEntity;
    procedure Hotelconfigurations_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'hotelconfigurations' ******************
    function Hotelconfigurations_DataSets_FindAll(): String;
    function Hotelconfigurations_DataSets_GetById(id: Integer): String;
    function Hotelconfigurations_DataSets_Delete(id: Integer): String;
    function Hotelconfigurations_DataSets_GetBySql(sql: String): String;
    function Hotelconfigurations_DataSets_GetEntityByWhere(where: String): String;
    function Hotelconfigurations_DataSets_GetListByWhere(where: String): String;
    function Hotelconfigurations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Hotelconfigurations_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'hotelcontacts' ******************
    function Hotelcontacts_Entities_FindAll(): Array_Of_THotelcontactsEntity;
    function Hotelcontacts_Entities_GetById(id: Integer): THotelcontactsEntity;
    function Hotelcontacts_Entities_GetBySql(sql: String): Array_Of_THotelcontactsEntity;
    function Hotelcontacts_Entities_GetEntityByWhere(where: String): THotelcontactsEntity;
    function Hotelcontacts_Entities_GetListByWhere(where: String): Array_Of_THotelcontactsEntity;
    function Hotelcontacts_Entities_SaveEntity(entity: THotelcontactsEntity): THotelcontactsEntity;
    function Hotelcontacts_Entities_UpdateEntity(entity: THotelcontactsEntity): THotelcontactsEntity;
    procedure Hotelcontacts_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'hotelcontacts' ******************
    function Hotelcontacts_DataSets_FindAll(): String;
    function Hotelcontacts_DataSets_GetById(id: Integer): String;
    function Hotelcontacts_DataSets_Delete(id: Integer): String;
    function Hotelcontacts_DataSets_GetBySql(sql: String): String;
    function Hotelcontacts_DataSets_GetEntityByWhere(where: String): String;
    function Hotelcontacts_DataSets_GetListByWhere(where: String): String;
    function Hotelcontacts_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Hotelcontacts_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'hotelcounters' ******************
    function Hotelcounters_Entities_FindAll(): Array_Of_THotelcountersEntity;
    function Hotelcounters_Entities_GetById(id: Integer): THotelcountersEntity;
    function Hotelcounters_Entities_GetBySql(sql: String): Array_Of_THotelcountersEntity;
    function Hotelcounters_Entities_GetEntityByWhere(where: String): THotelcountersEntity;
    function Hotelcounters_Entities_GetListByWhere(where: String): Array_Of_THotelcountersEntity;
    function Hotelcounters_Entities_SaveEntity(entity: THotelcountersEntity): THotelcountersEntity;
    function Hotelcounters_Entities_UpdateEntity(entity: THotelcountersEntity): THotelcountersEntity;
    procedure Hotelcounters_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'hotelcounters' ******************
    function Hotelcounters_DataSets_FindAll(): String;
    function Hotelcounters_DataSets_GetById(id: Integer): String;
    function Hotelcounters_DataSets_Delete(id: Integer): String;
    function Hotelcounters_DataSets_GetBySql(sql: String): String;
    function Hotelcounters_DataSets_GetEntityByWhere(where: String): String;
    function Hotelcounters_DataSets_GetListByWhere(where: String): String;
    function Hotelcounters_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Hotelcounters_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'hoteltasks' ******************
    function Hoteltasks_Entities_FindAll(): Array_Of_THoteltasksEntity;
    function Hoteltasks_Entities_GetById(id: Integer): THoteltasksEntity;
    function Hoteltasks_Entities_GetBySql(sql: String): Array_Of_THoteltasksEntity;
    function Hoteltasks_Entities_GetEntityByWhere(where: String): THoteltasksEntity;
    function Hoteltasks_Entities_GetListByWhere(where: String): Array_Of_THoteltasksEntity;
    function Hoteltasks_Entities_SaveEntity(entity: THoteltasksEntity): THoteltasksEntity;
    function Hoteltasks_Entities_UpdateEntity(entity: THoteltasksEntity): THoteltasksEntity;
    procedure Hoteltasks_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'hoteltasks' ******************
    function Hoteltasks_DataSets_FindAll(): String;
    function Hoteltasks_DataSets_GetById(id: Integer): String;
    function Hoteltasks_DataSets_Delete(id: Integer): String;
    function Hoteltasks_DataSets_GetBySql(sql: String): String;
    function Hoteltasks_DataSets_GetEntityByWhere(where: String): String;
    function Hoteltasks_DataSets_GetListByWhere(where: String): String;
    function Hoteltasks_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Hoteltasks_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'idreferences' ******************
    function Idreferences_Entities_FindAll(): Array_Of_TIdreferencesEntity;
    function Idreferences_Entities_GetById(id: Integer): TIdreferencesEntity;
    function Idreferences_Entities_GetBySql(sql: String): Array_Of_TIdreferencesEntity;
    function Idreferences_Entities_GetEntityByWhere(where: String): TIdreferencesEntity;
    function Idreferences_Entities_GetListByWhere(where: String): Array_Of_TIdreferencesEntity;
    function Idreferences_Entities_SaveEntity(entity: TIdreferencesEntity): TIdreferencesEntity;
    function Idreferences_Entities_UpdateEntity(entity: TIdreferencesEntity): TIdreferencesEntity;
    procedure Idreferences_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'idreferences' ******************
    function Idreferences_DataSets_FindAll(): String;
    function Idreferences_DataSets_GetById(id: Integer): String;
    function Idreferences_DataSets_Delete(id: Integer): String;
    function Idreferences_DataSets_GetBySql(sql: String): String;
    function Idreferences_DataSets_GetEntityByWhere(where: String): String;
    function Idreferences_DataSets_GetListByWhere(where: String): String;
    function Idreferences_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Idreferences_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'industries' ******************
    function Industries_Entities_FindAll(): Array_Of_TIndustriesEntity;
    function Industries_Entities_GetById(id: Integer): TIndustriesEntity;
    function Industries_Entities_GetBySql(sql: String): Array_Of_TIndustriesEntity;
    function Industries_Entities_GetEntityByWhere(where: String): TIndustriesEntity;
    function Industries_Entities_GetListByWhere(where: String): Array_Of_TIndustriesEntity;
    function Industries_Entities_SaveEntity(entity: TIndustriesEntity): TIndustriesEntity;
    function Industries_Entities_UpdateEntity(entity: TIndustriesEntity): TIndustriesEntity;
    procedure Industries_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'industries' ******************
    function Industries_DataSets_FindAll(): String;
    function Industries_DataSets_GetById(id: Integer): String;
    function Industries_DataSets_Delete(id: Integer): String;
    function Industries_DataSets_GetBySql(sql: String): String;
    function Industries_DataSets_GetEntityByWhere(where: String): String;
    function Industries_DataSets_GetListByWhere(where: String): String;
    function Industries_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Industries_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'invoiceheads' ******************
    function Invoiceheads_Entities_FindAll(): Array_Of_TInvoiceheadsEntity;
    function Invoiceheads_Entities_GetById(id: Integer): TInvoiceheadsEntity;
    function Invoiceheads_Entities_GetBySql(sql: String): Array_Of_TInvoiceheadsEntity;
    function Invoiceheads_Entities_GetEntityByWhere(where: String): TInvoiceheadsEntity;
    function Invoiceheads_Entities_GetListByWhere(where: String): Array_Of_TInvoiceheadsEntity;
    function Invoiceheads_Entities_SaveEntity(entity: TInvoiceheadsEntity): TInvoiceheadsEntity;
    function Invoiceheads_Entities_UpdateEntity(entity: TInvoiceheadsEntity): TInvoiceheadsEntity;
    procedure Invoiceheads_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'invoiceheads' ******************
    function Invoiceheads_DataSets_FindAll(): String;
    function Invoiceheads_DataSets_GetById(id: Integer): String;
    function Invoiceheads_DataSets_Delete(id: Integer): String;
    function Invoiceheads_DataSets_GetBySql(sql: String): String;
    function Invoiceheads_DataSets_GetEntityByWhere(where: String): String;
    function Invoiceheads_DataSets_GetListByWhere(where: String): String;
    function Invoiceheads_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Invoiceheads_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'invoicelines' ******************
    function Invoicelines_Entities_FindAll(): Array_Of_TInvoicelinesEntity;
    function Invoicelines_Entities_GetById(id: Integer): TInvoicelinesEntity;
    function Invoicelines_Entities_GetBySql(sql: String): Array_Of_TInvoicelinesEntity;
    function Invoicelines_Entities_GetEntityByWhere(where: String): TInvoicelinesEntity;
    function Invoicelines_Entities_GetListByWhere(where: String): Array_Of_TInvoicelinesEntity;
    function Invoicelines_Entities_SaveEntity(entity: TInvoicelinesEntity): TInvoicelinesEntity;
    function Invoicelines_Entities_UpdateEntity(entity: TInvoicelinesEntity): TInvoicelinesEntity;
    procedure Invoicelines_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'invoicelines' ******************
    function Invoicelines_DataSets_FindAll(): String;
    function Invoicelines_DataSets_GetById(id: Integer): String;
    function Invoicelines_DataSets_Delete(id: Integer): String;
    function Invoicelines_DataSets_GetBySql(sql: String): String;
    function Invoicelines_DataSets_GetEntityByWhere(where: String): String;
    function Invoicelines_DataSets_GetListByWhere(where: String): String;
    function Invoicelines_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Invoicelines_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'invoicelinestmp' ******************
    function Invoicelinestmp_Entities_FindAll(): Array_Of_TInvoicelinestmpEntity;
    function Invoicelinestmp_Entities_GetById(id: Integer): TInvoicelinestmpEntity;
    function Invoicelinestmp_Entities_GetBySql(sql: String): Array_Of_TInvoicelinestmpEntity;
    function Invoicelinestmp_Entities_GetEntityByWhere(where: String): TInvoicelinestmpEntity;
    function Invoicelinestmp_Entities_GetListByWhere(where: String): Array_Of_TInvoicelinestmpEntity;
    function Invoicelinestmp_Entities_SaveEntity(entity: TInvoicelinestmpEntity): TInvoicelinestmpEntity;
    function Invoicelinestmp_Entities_UpdateEntity(entity: TInvoicelinestmpEntity): TInvoicelinestmpEntity;
    procedure Invoicelinestmp_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'invoicelinestmp' ******************
    function Invoicelinestmp_DataSets_FindAll(): String;
    function Invoicelinestmp_DataSets_GetById(id: Integer): String;
    function Invoicelinestmp_DataSets_Delete(id: Integer): String;
    function Invoicelinestmp_DataSets_GetBySql(sql: String): String;
    function Invoicelinestmp_DataSets_GetEntityByWhere(where: String): String;
    function Invoicelinestmp_DataSets_GetListByWhere(where: String): String;
    function Invoicelinestmp_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Invoicelinestmp_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'items' ******************
    function Items_Entities_FindAll(): Array_Of_TItemsEntity;
    function Items_Entities_GetById(id: Integer): TItemsEntity;
    function Items_Entities_GetBySql(sql: String): Array_Of_TItemsEntity;
    function Items_Entities_GetEntityByWhere(where: String): TItemsEntity;
    function Items_Entities_GetListByWhere(where: String): Array_Of_TItemsEntity;
    function Items_Entities_SaveEntity(entity: TItemsEntity): TItemsEntity;
    function Items_Entities_UpdateEntity(entity: TItemsEntity): TItemsEntity;
    procedure Items_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'items' ******************
    function Items_DataSets_FindAll(): String;
    function Items_DataSets_GetById(id: Integer): String;
    function Items_DataSets_Delete(id: Integer): String;
    function Items_DataSets_GetBySql(sql: String): String;
    function Items_DataSets_GetEntityByWhere(where: String): String;
    function Items_DataSets_GetListByWhere(where: String): String;
    function Items_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Items_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'itemtypes' ******************
    function Itemtypes_Entities_FindAll(): Array_Of_TItemtypesEntity;
    function Itemtypes_Entities_GetById(id: Integer): TItemtypesEntity;
    function Itemtypes_Entities_GetBySql(sql: String): Array_Of_TItemtypesEntity;
    function Itemtypes_Entities_GetEntityByWhere(where: String): TItemtypesEntity;
    function Itemtypes_Entities_GetListByWhere(where: String): Array_Of_TItemtypesEntity;
    function Itemtypes_Entities_SaveEntity(entity: TItemtypesEntity): TItemtypesEntity;
    function Itemtypes_Entities_UpdateEntity(entity: TItemtypesEntity): TItemtypesEntity;
    procedure Itemtypes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'itemtypes' ******************
    function Itemtypes_DataSets_FindAll(): String;
    function Itemtypes_DataSets_GetById(id: Integer): String;
    function Itemtypes_DataSets_Delete(id: Integer): String;
    function Itemtypes_DataSets_GetBySql(sql: String): String;
    function Itemtypes_DataSets_GetEntityByWhere(where: String): String;
    function Itemtypes_DataSets_GetListByWhere(where: String): String;
    function Itemtypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Itemtypes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'locations' ******************
    function Locations_Entities_FindAll(): Array_Of_TLocationsEntity;
    function Locations_Entities_GetById(id: Integer): TLocationsEntity;
    function Locations_Entities_GetBySql(sql: String): Array_Of_TLocationsEntity;
    function Locations_Entities_GetEntityByWhere(where: String): TLocationsEntity;
    function Locations_Entities_GetListByWhere(where: String): Array_Of_TLocationsEntity;
    function Locations_Entities_SaveEntity(entity: TLocationsEntity): TLocationsEntity;
    function Locations_Entities_UpdateEntity(entity: TLocationsEntity): TLocationsEntity;
    procedure Locations_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'locations' ******************
    function Locations_DataSets_FindAll(): String;
    function Locations_DataSets_GetById(id: Integer): String;
    function Locations_DataSets_Delete(id: Integer): String;
    function Locations_DataSets_GetBySql(sql: String): String;
    function Locations_DataSets_GetEntityByWhere(where: String): String;
    function Locations_DataSets_GetListByWhere(where: String): String;
    function Locations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Locations_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'maintenancecodes' ******************
    function Maintenancecodes_Entities_FindAll(): Array_Of_TMaintenancecodesEntity;
    function Maintenancecodes_Entities_GetById(id: Integer): TMaintenancecodesEntity;
    function Maintenancecodes_Entities_GetBySql(sql: String): Array_Of_TMaintenancecodesEntity;
    function Maintenancecodes_Entities_GetEntityByWhere(where: String): TMaintenancecodesEntity;
    function Maintenancecodes_Entities_GetListByWhere(where: String): Array_Of_TMaintenancecodesEntity;
    function Maintenancecodes_Entities_SaveEntity(entity: TMaintenancecodesEntity): TMaintenancecodesEntity;
    function Maintenancecodes_Entities_UpdateEntity(entity: TMaintenancecodesEntity): TMaintenancecodesEntity;
    procedure Maintenancecodes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'maintenancecodes' ******************
    function Maintenancecodes_DataSets_FindAll(): String;
    function Maintenancecodes_DataSets_GetById(id: Integer): String;
    function Maintenancecodes_DataSets_Delete(id: Integer): String;
    function Maintenancecodes_DataSets_GetBySql(sql: String): String;
    function Maintenancecodes_DataSets_GetEntityByWhere(where: String): String;
    function Maintenancecodes_DataSets_GetListByWhere(where: String): String;
    function Maintenancecodes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Maintenancecodes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'maintenanceroomnotes' ******************
    function Maintenanceroomnotes_Entities_FindAll(): Array_Of_TMaintenanceroomnotesEntity;
    function Maintenanceroomnotes_Entities_GetById(id: Integer): TMaintenanceroomnotesEntity;
    function Maintenanceroomnotes_Entities_GetBySql(sql: String): Array_Of_TMaintenanceroomnotesEntity;
    function Maintenanceroomnotes_Entities_GetEntityByWhere(where: String): TMaintenanceroomnotesEntity;
    function Maintenanceroomnotes_Entities_GetListByWhere(where: String): Array_Of_TMaintenanceroomnotesEntity;
    function Maintenanceroomnotes_Entities_SaveEntity(entity: TMaintenanceroomnotesEntity): TMaintenanceroomnotesEntity;
    function Maintenanceroomnotes_Entities_UpdateEntity(entity: TMaintenanceroomnotesEntity): TMaintenanceroomnotesEntity;
    procedure Maintenanceroomnotes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'maintenanceroomnotes' ******************
    function Maintenanceroomnotes_DataSets_FindAll(): String;
    function Maintenanceroomnotes_DataSets_GetById(id: Integer): String;
    function Maintenanceroomnotes_DataSets_Delete(id: Integer): String;
    function Maintenanceroomnotes_DataSets_GetBySql(sql: String): String;
    function Maintenanceroomnotes_DataSets_GetEntityByWhere(where: String): String;
    function Maintenanceroomnotes_DataSets_GetListByWhere(where: String): String;
    function Maintenanceroomnotes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Maintenanceroomnotes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'packageclasses' ******************
    function Packageclasses_Entities_FindAll(): Array_Of_TPackageclassesEntity;
    function Packageclasses_Entities_GetById(id: Integer): TPackageclassesEntity;
    function Packageclasses_Entities_GetBySql(sql: String): Array_Of_TPackageclassesEntity;
    function Packageclasses_Entities_GetEntityByWhere(where: String): TPackageclassesEntity;
    function Packageclasses_Entities_GetListByWhere(where: String): Array_Of_TPackageclassesEntity;
    function Packageclasses_Entities_SaveEntity(entity: TPackageclassesEntity): TPackageclassesEntity;
    function Packageclasses_Entities_UpdateEntity(entity: TPackageclassesEntity): TPackageclassesEntity;
    procedure Packageclasses_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'packageclasses' ******************
    function Packageclasses_DataSets_FindAll(): String;
    function Packageclasses_DataSets_GetById(id: Integer): String;
    function Packageclasses_DataSets_Delete(id: Integer): String;
    function Packageclasses_DataSets_GetBySql(sql: String): String;
    function Packageclasses_DataSets_GetEntityByWhere(where: String): String;
    function Packageclasses_DataSets_GetListByWhere(where: String): String;
    function Packageclasses_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Packageclasses_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'packageitems' ******************
    function Packageitems_Entities_FindAll(): Array_Of_TPackageitemsEntity;
    function Packageitems_Entities_GetById(id: Integer): TPackageitemsEntity;
    function Packageitems_Entities_GetBySql(sql: String): Array_Of_TPackageitemsEntity;
    function Packageitems_Entities_GetEntityByWhere(where: String): TPackageitemsEntity;
    function Packageitems_Entities_GetListByWhere(where: String): Array_Of_TPackageitemsEntity;
    function Packageitems_Entities_SaveEntity(entity: TPackageitemsEntity): TPackageitemsEntity;
    function Packageitems_Entities_UpdateEntity(entity: TPackageitemsEntity): TPackageitemsEntity;
    procedure Packageitems_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'packageitems' ******************
    function Packageitems_DataSets_FindAll(): String;
    function Packageitems_DataSets_GetById(id: Integer): String;
    function Packageitems_DataSets_Delete(id: Integer): String;
    function Packageitems_DataSets_GetBySql(sql: String): String;
    function Packageitems_DataSets_GetEntityByWhere(where: String): String;
    function Packageitems_DataSets_GetListByWhere(where: String): String;
    function Packageitems_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Packageitems_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'packages' ******************
    function Packages_Entities_FindAll(): Array_Of_TPackagesEntity;
    function Packages_Entities_GetById(id: Integer): TPackagesEntity;
    function Packages_Entities_GetBySql(sql: String): Array_Of_TPackagesEntity;
    function Packages_Entities_GetEntityByWhere(where: String): TPackagesEntity;
    function Packages_Entities_GetListByWhere(where: String): Array_Of_TPackagesEntity;
    function Packages_Entities_SaveEntity(entity: TPackagesEntity): TPackagesEntity;
    function Packages_Entities_UpdateEntity(entity: TPackagesEntity): TPackagesEntity;
    procedure Packages_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'packages' ******************
    function Packages_DataSets_FindAll(): String;
    function Packages_DataSets_GetById(id: Integer): String;
    function Packages_DataSets_Delete(id: Integer): String;
    function Packages_DataSets_GetBySql(sql: String): String;
    function Packages_DataSets_GetEntityByWhere(where: String): String;
    function Packages_DataSets_GetListByWhere(where: String): String;
    function Packages_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Packages_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'packageusage' ******************
    function Packageusage_Entities_FindAll(): Array_Of_TPackageusageEntity;
    function Packageusage_Entities_GetById(id: Integer): TPackageusageEntity;
    function Packageusage_Entities_GetBySql(sql: String): Array_Of_TPackageusageEntity;
    function Packageusage_Entities_GetEntityByWhere(where: String): TPackageusageEntity;
    function Packageusage_Entities_GetListByWhere(where: String): Array_Of_TPackageusageEntity;
    function Packageusage_Entities_SaveEntity(entity: TPackageusageEntity): TPackageusageEntity;
    function Packageusage_Entities_UpdateEntity(entity: TPackageusageEntity): TPackageusageEntity;
    procedure Packageusage_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'packageusage' ******************
    function Packageusage_DataSets_FindAll(): String;
    function Packageusage_DataSets_GetById(id: Integer): String;
    function Packageusage_DataSets_Delete(id: Integer): String;
    function Packageusage_DataSets_GetBySql(sql: String): String;
    function Packageusage_DataSets_GetEntityByWhere(where: String): String;
    function Packageusage_DataSets_GetListByWhere(where: String): String;
    function Packageusage_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Packageusage_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'paygroups' ******************
    function Paygroups_Entities_FindAll(): Array_Of_TPaygroupsEntity;
    function Paygroups_Entities_GetById(id: Integer): TPaygroupsEntity;
    function Paygroups_Entities_GetBySql(sql: String): Array_Of_TPaygroupsEntity;
    function Paygroups_Entities_GetEntityByWhere(where: String): TPaygroupsEntity;
    function Paygroups_Entities_GetListByWhere(where: String): Array_Of_TPaygroupsEntity;
    function Paygroups_Entities_SaveEntity(entity: TPaygroupsEntity): TPaygroupsEntity;
    function Paygroups_Entities_UpdateEntity(entity: TPaygroupsEntity): TPaygroupsEntity;
    procedure Paygroups_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'paygroups' ******************
    function Paygroups_DataSets_FindAll(): String;
    function Paygroups_DataSets_GetById(id: Integer): String;
    function Paygroups_DataSets_Delete(id: Integer): String;
    function Paygroups_DataSets_GetBySql(sql: String): String;
    function Paygroups_DataSets_GetEntityByWhere(where: String): String;
    function Paygroups_DataSets_GetListByWhere(where: String): String;
    function Paygroups_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Paygroups_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'payments' ******************
    function Payments_Entities_FindAll(): Array_Of_TPaymentsEntity;
    function Payments_Entities_GetById(id: Integer): TPaymentsEntity;
    function Payments_Entities_GetBySql(sql: String): Array_Of_TPaymentsEntity;
    function Payments_Entities_GetEntityByWhere(where: String): TPaymentsEntity;
    function Payments_Entities_GetListByWhere(where: String): Array_Of_TPaymentsEntity;
    function Payments_Entities_SaveEntity(entity: TPaymentsEntity): TPaymentsEntity;
    function Payments_Entities_UpdateEntity(entity: TPaymentsEntity): TPaymentsEntity;
    procedure Payments_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'payments' ******************
    function Payments_DataSets_FindAll(): String;
    function Payments_DataSets_GetById(id: Integer): String;
    function Payments_DataSets_Delete(id: Integer): String;
    function Payments_DataSets_GetBySql(sql: String): String;
    function Payments_DataSets_GetEntityByWhere(where: String): String;
    function Payments_DataSets_GetListByWhere(where: String): String;
    function Payments_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Payments_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'paytypes' ******************
    function Paytypes_Entities_FindAll(): Array_Of_TPaytypesEntity;
    function Paytypes_Entities_GetById(id: Integer): TPaytypesEntity;
    function Paytypes_Entities_GetBySql(sql: String): Array_Of_TPaytypesEntity;
    function Paytypes_Entities_GetEntityByWhere(where: String): TPaytypesEntity;
    function Paytypes_Entities_GetListByWhere(where: String): Array_Of_TPaytypesEntity;
    function Paytypes_Entities_SaveEntity(entity: TPaytypesEntity): TPaytypesEntity;
    function Paytypes_Entities_UpdateEntity(entity: TPaytypesEntity): TPaytypesEntity;
    procedure Paytypes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'paytypes' ******************
    function Paytypes_DataSets_FindAll(): String;
    function Paytypes_DataSets_GetById(id: Integer): String;
    function Paytypes_DataSets_Delete(id: Integer): String;
    function Paytypes_DataSets_GetBySql(sql: String): String;
    function Paytypes_DataSets_GetEntityByWhere(where: String): String;
    function Paytypes_DataSets_GetListByWhere(where: String): String;
    function Paytypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Paytypes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'person' ******************
    function Person_Entities_FindAll(): Array_Of_TPersonEntity;
    function Person_Entities_GetById(id: Integer): TPersonEntity;
    function Person_Entities_GetBySql(sql: String): Array_Of_TPersonEntity;
    function Person_Entities_GetEntityByWhere(where: String): TPersonEntity;
    function Person_Entities_GetListByWhere(where: String): Array_Of_TPersonEntity;
    function Person_Entities_SaveEntity(entity: TPersonEntity): TPersonEntity;
    function Person_Entities_UpdateEntity(entity: TPersonEntity): TPersonEntity;
    procedure Person_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'person' ******************
    function Person_DataSets_FindAll(): String;
    function Person_DataSets_GetById(id: Integer): String;
    function Person_DataSets_Delete(id: Integer): String;
    function Person_DataSets_GetBySql(sql: String): String;
    function Person_DataSets_GetEntityByWhere(where: String): String;
    function Person_DataSets_GetListByWhere(where: String): String;
    function Person_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Person_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'personaddress' ******************
    function Personaddress_Entities_FindAll(): Array_Of_TPersonaddressEntity;
    function Personaddress_Entities_GetById(id: Integer): TPersonaddressEntity;
    function Personaddress_Entities_GetBySql(sql: String): Array_Of_TPersonaddressEntity;
    function Personaddress_Entities_GetEntityByWhere(where: String): TPersonaddressEntity;
    function Personaddress_Entities_GetListByWhere(where: String): Array_Of_TPersonaddressEntity;
    function Personaddress_Entities_SaveEntity(entity: TPersonaddressEntity): TPersonaddressEntity;
    function Personaddress_Entities_UpdateEntity(entity: TPersonaddressEntity): TPersonaddressEntity;
    procedure Personaddress_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'personaddress' ******************
    function Personaddress_DataSets_FindAll(): String;
    function Personaddress_DataSets_GetById(id: Integer): String;
    function Personaddress_DataSets_Delete(id: Integer): String;
    function Personaddress_DataSets_GetBySql(sql: String): String;
    function Personaddress_DataSets_GetEntityByWhere(where: String): String;
    function Personaddress_DataSets_GetListByWhere(where: String): String;
    function Personaddress_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Personaddress_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'personchildren' ******************
    function Personchildren_Entities_FindAll(): Array_Of_TPersonchildrenEntity;
    function Personchildren_Entities_GetById(id: Integer): TPersonchildrenEntity;
    function Personchildren_Entities_GetBySql(sql: String): Array_Of_TPersonchildrenEntity;
    function Personchildren_Entities_GetEntityByWhere(where: String): TPersonchildrenEntity;
    function Personchildren_Entities_GetListByWhere(where: String): Array_Of_TPersonchildrenEntity;
    function Personchildren_Entities_SaveEntity(entity: TPersonchildrenEntity): TPersonchildrenEntity;
    function Personchildren_Entities_UpdateEntity(entity: TPersonchildrenEntity): TPersonchildrenEntity;
    procedure Personchildren_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'personchildren' ******************
    function Personchildren_DataSets_FindAll(): String;
    function Personchildren_DataSets_GetById(id: Integer): String;
    function Personchildren_DataSets_Delete(id: Integer): String;
    function Personchildren_DataSets_GetBySql(sql: String): String;
    function Personchildren_DataSets_GetEntityByWhere(where: String): String;
    function Personchildren_DataSets_GetListByWhere(where: String): String;
    function Personchildren_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Personchildren_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'personcontact' ******************
    function Personcontact_Entities_FindAll(): Array_Of_TPersoncontactEntity;
    function Personcontact_Entities_GetById(id: Integer): TPersoncontactEntity;
    function Personcontact_Entities_GetBySql(sql: String): Array_Of_TPersoncontactEntity;
    function Personcontact_Entities_GetEntityByWhere(where: String): TPersoncontactEntity;
    function Personcontact_Entities_GetListByWhere(where: String): Array_Of_TPersoncontactEntity;
    function Personcontact_Entities_SaveEntity(entity: TPersoncontactEntity): TPersoncontactEntity;
    function Personcontact_Entities_UpdateEntity(entity: TPersoncontactEntity): TPersoncontactEntity;
    procedure Personcontact_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'personcontact' ******************
    function Personcontact_DataSets_FindAll(): String;
    function Personcontact_DataSets_GetById(id: Integer): String;
    function Personcontact_DataSets_Delete(id: Integer): String;
    function Personcontact_DataSets_GetBySql(sql: String): String;
    function Personcontact_DataSets_GetEntityByWhere(where: String): String;
    function Personcontact_DataSets_GetListByWhere(where: String): String;
    function Personcontact_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Personcontact_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'personcontacttype' ******************
    function Personcontacttype_Entities_FindAll(): Array_Of_TPersoncontacttypeEntity;
    function Personcontacttype_Entities_GetById(id: Integer): TPersoncontacttypeEntity;
    function Personcontacttype_Entities_GetBySql(sql: String): Array_Of_TPersoncontacttypeEntity;
    function Personcontacttype_Entities_GetEntityByWhere(where: String): TPersoncontacttypeEntity;
    function Personcontacttype_Entities_GetListByWhere(where: String): Array_Of_TPersoncontacttypeEntity;
    function Personcontacttype_Entities_SaveEntity(entity: TPersoncontacttypeEntity): TPersoncontacttypeEntity;
    function Personcontacttype_Entities_UpdateEntity(entity: TPersoncontacttypeEntity): TPersoncontacttypeEntity;
    procedure Personcontacttype_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'personcontacttype' ******************
    function Personcontacttype_DataSets_FindAll(): String;
    function Personcontacttype_DataSets_GetById(id: Integer): String;
    function Personcontacttype_DataSets_Delete(id: Integer): String;
    function Personcontacttype_DataSets_GetBySql(sql: String): String;
    function Personcontacttype_DataSets_GetEntityByWhere(where: String): String;
    function Personcontacttype_DataSets_GetListByWhere(where: String): String;
    function Personcontacttype_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Personcontacttype_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'personitems' ******************
    function Personitems_Entities_FindAll(): Array_Of_TPersonitemsEntity;
    function Personitems_Entities_GetById(id: Integer): TPersonitemsEntity;
    function Personitems_Entities_GetBySql(sql: String): Array_Of_TPersonitemsEntity;
    function Personitems_Entities_GetEntityByWhere(where: String): TPersonitemsEntity;
    function Personitems_Entities_GetListByWhere(where: String): Array_Of_TPersonitemsEntity;
    function Personitems_Entities_SaveEntity(entity: TPersonitemsEntity): TPersonitemsEntity;
    function Personitems_Entities_UpdateEntity(entity: TPersonitemsEntity): TPersonitemsEntity;
    procedure Personitems_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'personitems' ******************
    function Personitems_DataSets_FindAll(): String;
    function Personitems_DataSets_GetById(id: Integer): String;
    function Personitems_DataSets_Delete(id: Integer): String;
    function Personitems_DataSets_GetBySql(sql: String): String;
    function Personitems_DataSets_GetEntityByWhere(where: String): String;
    function Personitems_DataSets_GetListByWhere(where: String): String;
    function Personitems_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Personitems_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'personprofile' ******************
    function Personprofile_Entities_FindAll(): Array_Of_TPersonprofileEntity;
    function Personprofile_Entities_GetById(id: Integer): TPersonprofileEntity;
    function Personprofile_Entities_GetBySql(sql: String): Array_Of_TPersonprofileEntity;
    function Personprofile_Entities_GetEntityByWhere(where: String): TPersonprofileEntity;
    function Personprofile_Entities_GetListByWhere(where: String): Array_Of_TPersonprofileEntity;
    function Personprofile_Entities_SaveEntity(entity: TPersonprofileEntity): TPersonprofileEntity;
    function Personprofile_Entities_UpdateEntity(entity: TPersonprofileEntity): TPersonprofileEntity;
    procedure Personprofile_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'personprofile' ******************
    function Personprofile_DataSets_FindAll(): String;
    function Personprofile_DataSets_GetById(id: Integer): String;
    function Personprofile_DataSets_Delete(id: Integer): String;
    function Personprofile_DataSets_GetBySql(sql: String): String;
    function Personprofile_DataSets_GetEntityByWhere(where: String): String;
    function Personprofile_DataSets_GetListByWhere(where: String): String;
    function Personprofile_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Personprofile_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'persons' ******************
    function Persons_Entities_FindAll(): Array_Of_TPersonsEntity;
    function Persons_Entities_GetById(id: Integer): TPersonsEntity;
    function Persons_Entities_GetBySql(sql: String): Array_Of_TPersonsEntity;
    function Persons_Entities_GetEntityByWhere(where: String): TPersonsEntity;
    function Persons_Entities_GetListByWhere(where: String): Array_Of_TPersonsEntity;
    function Persons_Entities_SaveEntity(entity: TPersonsEntity): TPersonsEntity;
    function Persons_Entities_UpdateEntity(entity: TPersonsEntity): TPersonsEntity;
    procedure Persons_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'persons' ******************
    function Persons_DataSets_FindAll(): String;
    function Persons_DataSets_GetById(id: Integer): String;
    function Persons_DataSets_Delete(id: Integer): String;
    function Persons_DataSets_GetBySql(sql: String): String;
    function Persons_DataSets_GetEntityByWhere(where: String): String;
    function Persons_DataSets_GetListByWhere(where: String): String;
    function Persons_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Persons_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'personviptypes' ******************
    function Personviptypes_Entities_FindAll(): Array_Of_TPersonviptypesEntity;
    function Personviptypes_Entities_GetById(id: Integer): TPersonviptypesEntity;
    function Personviptypes_Entities_GetBySql(sql: String): Array_Of_TPersonviptypesEntity;
    function Personviptypes_Entities_GetEntityByWhere(where: String): TPersonviptypesEntity;
    function Personviptypes_Entities_GetListByWhere(where: String): Array_Of_TPersonviptypesEntity;
    function Personviptypes_Entities_SaveEntity(entity: TPersonviptypesEntity): TPersonviptypesEntity;
    function Personviptypes_Entities_UpdateEntity(entity: TPersonviptypesEntity): TPersonviptypesEntity;
    procedure Personviptypes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'personviptypes' ******************
    function Personviptypes_DataSets_FindAll(): String;
    function Personviptypes_DataSets_GetById(id: Integer): String;
    function Personviptypes_DataSets_Delete(id: Integer): String;
    function Personviptypes_DataSets_GetBySql(sql: String): String;
    function Personviptypes_DataSets_GetEntityByWhere(where: String): String;
    function Personviptypes_DataSets_GetListByWhere(where: String): String;
    function Personviptypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Personviptypes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'predefineddates' ******************
    function Predefineddates_Entities_FindAll(): Array_Of_TPredefineddatesEntity;
    function Predefineddates_Entities_GetById(id: Integer): TPredefineddatesEntity;
    function Predefineddates_Entities_GetBySql(sql: String): Array_Of_TPredefineddatesEntity;
    function Predefineddates_Entities_GetEntityByWhere(where: String): TPredefineddatesEntity;
    function Predefineddates_Entities_GetListByWhere(where: String): Array_Of_TPredefineddatesEntity;
    function Predefineddates_Entities_SaveEntity(entity: TPredefineddatesEntity): TPredefineddatesEntity;
    function Predefineddates_Entities_UpdateEntity(entity: TPredefineddatesEntity): TPredefineddatesEntity;
    procedure Predefineddates_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'predefineddates' ******************
    function Predefineddates_DataSets_FindAll(): String;
    function Predefineddates_DataSets_GetById(id: Integer): String;
    function Predefineddates_DataSets_Delete(id: Integer): String;
    function Predefineddates_DataSets_GetBySql(sql: String): String;
    function Predefineddates_DataSets_GetEntityByWhere(where: String): String;
    function Predefineddates_DataSets_GetListByWhere(where: String): String;
    function Predefineddates_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Predefineddates_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'pricerules' ******************
    function Pricerules_Entities_FindAll(): Array_Of_TPricerulesEntity;
    function Pricerules_Entities_GetById(id: Integer): TPricerulesEntity;
    function Pricerules_Entities_GetBySql(sql: String): Array_Of_TPricerulesEntity;
    function Pricerules_Entities_GetEntityByWhere(where: String): TPricerulesEntity;
    function Pricerules_Entities_GetListByWhere(where: String): Array_Of_TPricerulesEntity;
    function Pricerules_Entities_SaveEntity(entity: TPricerulesEntity): TPricerulesEntity;
    function Pricerules_Entities_UpdateEntity(entity: TPricerulesEntity): TPricerulesEntity;
    procedure Pricerules_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'pricerules' ******************
    function Pricerules_DataSets_FindAll(): String;
    function Pricerules_DataSets_GetById(id: Integer): String;
    function Pricerules_DataSets_Delete(id: Integer): String;
    function Pricerules_DataSets_GetBySql(sql: String): String;
    function Pricerules_DataSets_GetEntityByWhere(where: String): String;
    function Pricerules_DataSets_GetListByWhere(where: String): String;
    function Pricerules_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Pricerules_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'pricerulespackages' ******************
    function Pricerulespackages_Entities_FindAll(): Array_Of_TPricerulespackagesEntity;
    function Pricerulespackages_Entities_GetById(id: Integer): TPricerulespackagesEntity;
    function Pricerulespackages_Entities_GetBySql(sql: String): Array_Of_TPricerulespackagesEntity;
    function Pricerulespackages_Entities_GetEntityByWhere(where: String): TPricerulespackagesEntity;
    function Pricerulespackages_Entities_GetListByWhere(where: String): Array_Of_TPricerulespackagesEntity;
    function Pricerulespackages_Entities_SaveEntity(entity: TPricerulespackagesEntity): TPricerulespackagesEntity;
    function Pricerulespackages_Entities_UpdateEntity(entity: TPricerulespackagesEntity): TPricerulespackagesEntity;
    procedure Pricerulespackages_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'pricerulespackages' ******************
    function Pricerulespackages_DataSets_FindAll(): String;
    function Pricerulespackages_DataSets_GetById(id: Integer): String;
    function Pricerulespackages_DataSets_Delete(id: Integer): String;
    function Pricerulespackages_DataSets_GetBySql(sql: String): String;
    function Pricerulespackages_DataSets_GetEntityByWhere(where: String): String;
    function Pricerulespackages_DataSets_GetListByWhere(where: String): String;
    function Pricerulespackages_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Pricerulespackages_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'pricetypes' ******************
    function Pricetypes_Entities_FindAll(): Array_Of_TPricetypesEntity;
    function Pricetypes_Entities_GetById(id: Integer): TPricetypesEntity;
    function Pricetypes_Entities_GetBySql(sql: String): Array_Of_TPricetypesEntity;
    function Pricetypes_Entities_GetEntityByWhere(where: String): TPricetypesEntity;
    function Pricetypes_Entities_GetListByWhere(where: String): Array_Of_TPricetypesEntity;
    function Pricetypes_Entities_SaveEntity(entity: TPricetypesEntity): TPricetypesEntity;
    function Pricetypes_Entities_UpdateEntity(entity: TPricetypesEntity): TPricetypesEntity;
    procedure Pricetypes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'pricetypes' ******************
    function Pricetypes_DataSets_FindAll(): String;
    function Pricetypes_DataSets_GetById(id: Integer): String;
    function Pricetypes_DataSets_Delete(id: Integer): String;
    function Pricetypes_DataSets_GetBySql(sql: String): String;
    function Pricetypes_DataSets_GetEntityByWhere(where: String): String;
    function Pricetypes_DataSets_GetListByWhere(where: String): String;
    function Pricetypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Pricetypes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'propertiesstore' ******************
    function Propertiesstore_Entities_FindAll(): Array_Of_TPropertiesstoreEntity;
    function Propertiesstore_Entities_GetById(id: Integer): TPropertiesstoreEntity;
    function Propertiesstore_Entities_GetBySql(sql: String): Array_Of_TPropertiesstoreEntity;
    function Propertiesstore_Entities_GetEntityByWhere(where: String): TPropertiesstoreEntity;
    function Propertiesstore_Entities_GetListByWhere(where: String): Array_Of_TPropertiesstoreEntity;
    function Propertiesstore_Entities_SaveEntity(entity: TPropertiesstoreEntity): TPropertiesstoreEntity;
    function Propertiesstore_Entities_UpdateEntity(entity: TPropertiesstoreEntity): TPropertiesstoreEntity;
    procedure Propertiesstore_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'propertiesstore' ******************
    function Propertiesstore_DataSets_FindAll(): String;
    function Propertiesstore_DataSets_GetById(id: Integer): String;
    function Propertiesstore_DataSets_Delete(id: Integer): String;
    function Propertiesstore_DataSets_GetBySql(sql: String): String;
    function Propertiesstore_DataSets_GetEntityByWhere(where: String): String;
    function Propertiesstore_DataSets_GetListByWhere(where: String): String;
    function Propertiesstore_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Propertiesstore_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'rates' ******************
    function Rates_Entities_FindAll(): Array_Of_TRatesEntity;
    function Rates_Entities_GetById(id: Integer): TRatesEntity;
    function Rates_Entities_GetBySql(sql: String): Array_Of_TRatesEntity;
    function Rates_Entities_GetEntityByWhere(where: String): TRatesEntity;
    function Rates_Entities_GetListByWhere(where: String): Array_Of_TRatesEntity;
    function Rates_Entities_SaveEntity(entity: TRatesEntity): TRatesEntity;
    function Rates_Entities_UpdateEntity(entity: TRatesEntity): TRatesEntity;
    procedure Rates_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'rates' ******************
    function Rates_DataSets_FindAll(): String;
    function Rates_DataSets_GetById(id: Integer): String;
    function Rates_DataSets_Delete(id: Integer): String;
    function Rates_DataSets_GetBySql(sql: String): String;
    function Rates_DataSets_GetEntityByWhere(where: String): String;
    function Rates_DataSets_GetListByWhere(where: String): String;
    function Rates_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Rates_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'reservations' ******************
    function Reservations_Entities_FindAll(): Array_Of_TReservationsEntity;
    function Reservations_Entities_GetById(id: Integer): TReservationsEntity;
    function Reservations_Entities_GetBySql(sql: String): Array_Of_TReservationsEntity;
    function Reservations_Entities_GetEntityByWhere(where: String): TReservationsEntity;
    function Reservations_Entities_GetListByWhere(where: String): Array_Of_TReservationsEntity;
    function Reservations_Entities_SaveEntity(entity: TReservationsEntity): TReservationsEntity;
    function Reservations_Entities_UpdateEntity(entity: TReservationsEntity): TReservationsEntity;
    procedure Reservations_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'reservations' ******************
    function Reservations_DataSets_FindAll(): String;
    function Reservations_DataSets_GetById(id: Integer): String;
    function Reservations_DataSets_Delete(id: Integer): String;
    function Reservations_DataSets_GetBySql(sql: String): String;
    function Reservations_DataSets_GetEntityByWhere(where: String): String;
    function Reservations_DataSets_GetListByWhere(where: String): String;
    function Reservations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Reservations_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'roomamenities' ******************
    function Roomamenities_Entities_FindAll(): Array_Of_TRoomamenitiesEntity;
    function Roomamenities_Entities_GetById(id: Integer): TRoomamenitiesEntity;
    function Roomamenities_Entities_GetBySql(sql: String): Array_Of_TRoomamenitiesEntity;
    function Roomamenities_Entities_GetEntityByWhere(where: String): TRoomamenitiesEntity;
    function Roomamenities_Entities_GetListByWhere(where: String): Array_Of_TRoomamenitiesEntity;
    function Roomamenities_Entities_SaveEntity(entity: TRoomamenitiesEntity): TRoomamenitiesEntity;
    function Roomamenities_Entities_UpdateEntity(entity: TRoomamenitiesEntity): TRoomamenitiesEntity;
    procedure Roomamenities_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'roomamenities' ******************
    function Roomamenities_DataSets_FindAll(): String;
    function Roomamenities_DataSets_GetById(id: Integer): String;
    function Roomamenities_DataSets_Delete(id: Integer): String;
    function Roomamenities_DataSets_GetBySql(sql: String): String;
    function Roomamenities_DataSets_GetEntityByWhere(where: String): String;
    function Roomamenities_DataSets_GetListByWhere(where: String): String;
    function Roomamenities_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Roomamenities_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'roomermessages' ******************
    function Roomermessages_Entities_FindAll(): Array_Of_TRoomermessagesEntity;
    function Roomermessages_Entities_GetById(id: Integer): TRoomermessagesEntity;
    function Roomermessages_Entities_GetBySql(sql: String): Array_Of_TRoomermessagesEntity;
    function Roomermessages_Entities_GetEntityByWhere(where: String): TRoomermessagesEntity;
    function Roomermessages_Entities_GetListByWhere(where: String): Array_Of_TRoomermessagesEntity;
    function Roomermessages_Entities_SaveEntity(entity: TRoomermessagesEntity): TRoomermessagesEntity;
    function Roomermessages_Entities_UpdateEntity(entity: TRoomermessagesEntity): TRoomermessagesEntity;
    procedure Roomermessages_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'roomermessages' ******************
    function Roomermessages_DataSets_FindAll(): String;
    function Roomermessages_DataSets_GetById(id: Integer): String;
    function Roomermessages_DataSets_Delete(id: Integer): String;
    function Roomermessages_DataSets_GetBySql(sql: String): String;
    function Roomermessages_DataSets_GetEntityByWhere(where: String): String;
    function Roomermessages_DataSets_GetListByWhere(where: String): String;
    function Roomermessages_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Roomermessages_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'roomrates' ******************
    function Roomrates_Entities_FindAll(): Array_Of_TRoomratesEntity;
    function Roomrates_Entities_GetById(id: Integer): TRoomratesEntity;
    function Roomrates_Entities_GetBySql(sql: String): Array_Of_TRoomratesEntity;
    function Roomrates_Entities_GetEntityByWhere(where: String): TRoomratesEntity;
    function Roomrates_Entities_GetListByWhere(where: String): Array_Of_TRoomratesEntity;
    function Roomrates_Entities_SaveEntity(entity: TRoomratesEntity): TRoomratesEntity;
    function Roomrates_Entities_UpdateEntity(entity: TRoomratesEntity): TRoomratesEntity;
    procedure Roomrates_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'roomrates' ******************
    function Roomrates_DataSets_FindAll(): String;
    function Roomrates_DataSets_GetById(id: Integer): String;
    function Roomrates_DataSets_Delete(id: Integer): String;
    function Roomrates_DataSets_GetBySql(sql: String): String;
    function Roomrates_DataSets_GetEntityByWhere(where: String): String;
    function Roomrates_DataSets_GetListByWhere(where: String): String;
    function Roomrates_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Roomrates_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'roomreservations' ******************
    function Roomreservations_Entities_FindAll(): Array_Of_TRoomreservationsEntity;
    function Roomreservations_Entities_GetById(id: Integer): TRoomreservationsEntity;
    function Roomreservations_Entities_GetBySql(sql: String): Array_Of_TRoomreservationsEntity;
    function Roomreservations_Entities_GetEntityByWhere(where: String): TRoomreservationsEntity;
    function Roomreservations_Entities_GetListByWhere(where: String): Array_Of_TRoomreservationsEntity;
    function Roomreservations_Entities_SaveEntity(entity: TRoomreservationsEntity): TRoomreservationsEntity;
    function Roomreservations_Entities_UpdateEntity(entity: TRoomreservationsEntity): TRoomreservationsEntity;
    procedure Roomreservations_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'roomreservations' ******************
    function Roomreservations_DataSets_FindAll(): String;
    function Roomreservations_DataSets_GetById(id: Integer): String;
    function Roomreservations_DataSets_Delete(id: Integer): String;
    function Roomreservations_DataSets_GetBySql(sql: String): String;
    function Roomreservations_DataSets_GetEntityByWhere(where: String): String;
    function Roomreservations_DataSets_GetListByWhere(where: String): String;
    function Roomreservations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Roomreservations_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'roomroomamenities' ******************
    function Roomroomamenities_Entities_FindAll(): Array_Of_TRoomroomamenitiesEntity;
    function Roomroomamenities_Entities_GetById(id: Integer): TRoomroomamenitiesEntity;
    function Roomroomamenities_Entities_GetBySql(sql: String): Array_Of_TRoomroomamenitiesEntity;
    function Roomroomamenities_Entities_GetEntityByWhere(where: String): TRoomroomamenitiesEntity;
    function Roomroomamenities_Entities_GetListByWhere(where: String): Array_Of_TRoomroomamenitiesEntity;
    function Roomroomamenities_Entities_SaveEntity(entity: TRoomroomamenitiesEntity): TRoomroomamenitiesEntity;
    function Roomroomamenities_Entities_UpdateEntity(entity: TRoomroomamenitiesEntity): TRoomroomamenitiesEntity;
    procedure Roomroomamenities_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'roomroomamenities' ******************
    function Roomroomamenities_DataSets_FindAll(): String;
    function Roomroomamenities_DataSets_GetById(id: Integer): String;
    function Roomroomamenities_DataSets_Delete(id: Integer): String;
    function Roomroomamenities_DataSets_GetBySql(sql: String): String;
    function Roomroomamenities_DataSets_GetEntityByWhere(where: String): String;
    function Roomroomamenities_DataSets_GetListByWhere(where: String): String;
    function Roomroomamenities_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Roomroomamenities_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'rooms' ******************
    function Rooms_Entities_FindAll(): Array_Of_TRoomsEntity;
    function Rooms_Entities_GetById(id: Integer): TRoomsEntity;
    function Rooms_Entities_GetBySql(sql: String): Array_Of_TRoomsEntity;
    function Rooms_Entities_GetEntityByWhere(where: String): TRoomsEntity;
    function Rooms_Entities_GetListByWhere(where: String): Array_Of_TRoomsEntity;
    function Rooms_Entities_SaveEntity(entity: TRoomsEntity): TRoomsEntity;
    function Rooms_Entities_UpdateEntity(entity: TRoomsEntity): TRoomsEntity;
    procedure Rooms_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'rooms' ******************
    function Rooms_DataSets_FindAll(): String;
    function Rooms_DataSets_GetById(id: Integer): String;
    function Rooms_DataSets_Delete(id: Integer): String;
    function Rooms_DataSets_GetBySql(sql: String): String;
    function Rooms_DataSets_GetEntityByWhere(where: String): String;
    function Rooms_DataSets_GetListByWhere(where: String): String;
    function Rooms_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Rooms_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'roomsdate' ******************
    function Roomsdate_Entities_FindAll(): Array_Of_TRoomsdateEntity;
    function Roomsdate_Entities_GetById(id: Integer): TRoomsdateEntity;
    function Roomsdate_Entities_GetBySql(sql: String): Array_Of_TRoomsdateEntity;
    function Roomsdate_Entities_GetEntityByWhere(where: String): TRoomsdateEntity;
    function Roomsdate_Entities_GetListByWhere(where: String): Array_Of_TRoomsdateEntity;
    function Roomsdate_Entities_SaveEntity(entity: TRoomsdateEntity): TRoomsdateEntity;
    function Roomsdate_Entities_UpdateEntity(entity: TRoomsdateEntity): TRoomsdateEntity;
    procedure Roomsdate_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'roomsdate' ******************
    function Roomsdate_DataSets_FindAll(): String;
    function Roomsdate_DataSets_GetById(id: Integer): String;
    function Roomsdate_DataSets_Delete(id: Integer): String;
    function Roomsdate_DataSets_GetBySql(sql: String): String;
    function Roomsdate_DataSets_GetEntityByWhere(where: String): String;
    function Roomsdate_DataSets_GetListByWhere(where: String): String;
    function Roomsdate_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Roomsdate_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'roomsdatetemp' ******************
    function Roomsdatetemp_Entities_FindAll(): Array_Of_TRoomsdatetempEntity;
    function Roomsdatetemp_Entities_GetById(id: Integer): TRoomsdatetempEntity;
    function Roomsdatetemp_Entities_GetBySql(sql: String): Array_Of_TRoomsdatetempEntity;
    function Roomsdatetemp_Entities_GetEntityByWhere(where: String): TRoomsdatetempEntity;
    function Roomsdatetemp_Entities_GetListByWhere(where: String): Array_Of_TRoomsdatetempEntity;
    function Roomsdatetemp_Entities_SaveEntity(entity: TRoomsdatetempEntity): TRoomsdatetempEntity;
    function Roomsdatetemp_Entities_UpdateEntity(entity: TRoomsdatetempEntity): TRoomsdatetempEntity;
    procedure Roomsdatetemp_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'roomsdatetemp' ******************
    function Roomsdatetemp_DataSets_FindAll(): String;
    function Roomsdatetemp_DataSets_GetById(id: Integer): String;
    function Roomsdatetemp_DataSets_Delete(id: Integer): String;
    function Roomsdatetemp_DataSets_GetBySql(sql: String): String;
    function Roomsdatetemp_DataSets_GetEntityByWhere(where: String): String;
    function Roomsdatetemp_DataSets_GetListByWhere(where: String): String;
    function Roomsdatetemp_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Roomsdatetemp_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'roomtypegroups' ******************
    function Roomtypegroups_Entities_FindAll(): Array_Of_TRoomtypegroupsEntity;
    function Roomtypegroups_Entities_GetById(id: Integer): TRoomtypegroupsEntity;
    function Roomtypegroups_Entities_GetBySql(sql: String): Array_Of_TRoomtypegroupsEntity;
    function Roomtypegroups_Entities_GetEntityByWhere(where: String): TRoomtypegroupsEntity;
    function Roomtypegroups_Entities_GetListByWhere(where: String): Array_Of_TRoomtypegroupsEntity;
    function Roomtypegroups_Entities_SaveEntity(entity: TRoomtypegroupsEntity): TRoomtypegroupsEntity;
    function Roomtypegroups_Entities_UpdateEntity(entity: TRoomtypegroupsEntity): TRoomtypegroupsEntity;
    procedure Roomtypegroups_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'roomtypegroups' ******************
    function Roomtypegroups_DataSets_FindAll(): String;
    function Roomtypegroups_DataSets_GetById(id: Integer): String;
    function Roomtypegroups_DataSets_Delete(id: Integer): String;
    function Roomtypegroups_DataSets_GetBySql(sql: String): String;
    function Roomtypegroups_DataSets_GetEntityByWhere(where: String): String;
    function Roomtypegroups_DataSets_GetListByWhere(where: String): String;
    function Roomtypegroups_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Roomtypegroups_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'roomtyperules' ******************
    function Roomtyperules_Entities_FindAll(): Array_Of_TRoomtyperulesEntity;
    function Roomtyperules_Entities_GetById(id: Integer): TRoomtyperulesEntity;
    function Roomtyperules_Entities_GetBySql(sql: String): Array_Of_TRoomtyperulesEntity;
    function Roomtyperules_Entities_GetEntityByWhere(where: String): TRoomtyperulesEntity;
    function Roomtyperules_Entities_GetListByWhere(where: String): Array_Of_TRoomtyperulesEntity;
    function Roomtyperules_Entities_SaveEntity(entity: TRoomtyperulesEntity): TRoomtyperulesEntity;
    function Roomtyperules_Entities_UpdateEntity(entity: TRoomtyperulesEntity): TRoomtyperulesEntity;
    procedure Roomtyperules_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'roomtyperules' ******************
    function Roomtyperules_DataSets_FindAll(): String;
    function Roomtyperules_DataSets_GetById(id: Integer): String;
    function Roomtyperules_DataSets_Delete(id: Integer): String;
    function Roomtyperules_DataSets_GetBySql(sql: String): String;
    function Roomtyperules_DataSets_GetEntityByWhere(where: String): String;
    function Roomtyperules_DataSets_GetListByWhere(where: String): String;
    function Roomtyperules_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Roomtyperules_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'roomtypes' ******************
    function Roomtypes_Entities_FindAll(): Array_Of_TRoomtypesEntity;
    function Roomtypes_Entities_GetById(id: Integer): TRoomtypesEntity;
    function Roomtypes_Entities_GetBySql(sql: String): Array_Of_TRoomtypesEntity;
    function Roomtypes_Entities_GetEntityByWhere(where: String): TRoomtypesEntity;
    function Roomtypes_Entities_GetListByWhere(where: String): Array_Of_TRoomtypesEntity;
    function Roomtypes_Entities_SaveEntity(entity: TRoomtypesEntity): TRoomtypesEntity;
    function Roomtypes_Entities_UpdateEntity(entity: TRoomtypesEntity): TRoomtypesEntity;
    procedure Roomtypes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'roomtypes' ******************
    function Roomtypes_DataSets_FindAll(): String;
    function Roomtypes_DataSets_GetById(id: Integer): String;
    function Roomtypes_DataSets_Delete(id: Integer): String;
    function Roomtypes_DataSets_GetBySql(sql: String): String;
    function Roomtypes_DataSets_GetEntityByWhere(where: String): String;
    function Roomtypes_DataSets_GetListByWhere(where: String): String;
    function Roomtypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Roomtypes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'staffmembers' ******************
    function Staffmembers_Entities_FindAll(): Array_Of_TStaffmembersEntity;
    function Staffmembers_Entities_GetById(id: Integer): TStaffmembersEntity;
    function Staffmembers_Entities_GetBySql(sql: String): Array_Of_TStaffmembersEntity;
    function Staffmembers_Entities_GetEntityByWhere(where: String): TStaffmembersEntity;
    function Staffmembers_Entities_GetListByWhere(where: String): Array_Of_TStaffmembersEntity;
    function Staffmembers_Entities_SaveEntity(entity: TStaffmembersEntity): TStaffmembersEntity;
    function Staffmembers_Entities_UpdateEntity(entity: TStaffmembersEntity): TStaffmembersEntity;
    procedure Staffmembers_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'staffmembers' ******************
    function Staffmembers_DataSets_FindAll(): String;
    function Staffmembers_DataSets_GetById(id: Integer): String;
    function Staffmembers_DataSets_Delete(id: Integer): String;
    function Staffmembers_DataSets_GetBySql(sql: String): String;
    function Staffmembers_DataSets_GetEntityByWhere(where: String): String;
    function Staffmembers_DataSets_GetListByWhere(where: String): String;
    function Staffmembers_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Staffmembers_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'stafftypes' ******************
    function Stafftypes_Entities_FindAll(): Array_Of_TStafftypesEntity;
    function Stafftypes_Entities_GetById(id: Integer): TStafftypesEntity;
    function Stafftypes_Entities_GetBySql(sql: String): Array_Of_TStafftypesEntity;
    function Stafftypes_Entities_GetEntityByWhere(where: String): TStafftypesEntity;
    function Stafftypes_Entities_GetListByWhere(where: String): Array_Of_TStafftypesEntity;
    function Stafftypes_Entities_SaveEntity(entity: TStafftypesEntity): TStafftypesEntity;
    function Stafftypes_Entities_UpdateEntity(entity: TStafftypesEntity): TStafftypesEntity;
    procedure Stafftypes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'stafftypes' ******************
    function Stafftypes_DataSets_FindAll(): String;
    function Stafftypes_DataSets_GetById(id: Integer): String;
    function Stafftypes_DataSets_Delete(id: Integer): String;
    function Stafftypes_DataSets_GetBySql(sql: String): String;
    function Stafftypes_DataSets_GetEntityByWhere(where: String): String;
    function Stafftypes_DataSets_GetListByWhere(where: String): String;
    function Stafftypes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Stafftypes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'systemactions' ******************
    function Systemactions_Entities_FindAll(): Array_Of_TSystemactionsEntity;
    function Systemactions_Entities_GetById(id: Integer): TSystemactionsEntity;
    function Systemactions_Entities_GetBySql(sql: String): Array_Of_TSystemactionsEntity;
    function Systemactions_Entities_GetEntityByWhere(where: String): TSystemactionsEntity;
    function Systemactions_Entities_GetListByWhere(where: String): Array_Of_TSystemactionsEntity;
    function Systemactions_Entities_SaveEntity(entity: TSystemactionsEntity): TSystemactionsEntity;
    function Systemactions_Entities_UpdateEntity(entity: TSystemactionsEntity): TSystemactionsEntity;
    procedure Systemactions_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'systemactions' ******************
    function Systemactions_DataSets_FindAll(): String;
    function Systemactions_DataSets_GetById(id: Integer): String;
    function Systemactions_DataSets_Delete(id: Integer): String;
    function Systemactions_DataSets_GetBySql(sql: String): String;
    function Systemactions_DataSets_GetEntityByWhere(where: String): String;
    function Systemactions_DataSets_GetListByWhere(where: String): String;
    function Systemactions_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Systemactions_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'systemservers' ******************
    function Systemservers_Entities_FindAll(): Array_Of_TSystemserversEntity;
    function Systemservers_Entities_GetById(id: Integer): TSystemserversEntity;
    function Systemservers_Entities_GetBySql(sql: String): Array_Of_TSystemserversEntity;
    function Systemservers_Entities_GetEntityByWhere(where: String): TSystemserversEntity;
    function Systemservers_Entities_GetListByWhere(where: String): Array_Of_TSystemserversEntity;
    function Systemservers_Entities_SaveEntity(entity: TSystemserversEntity): TSystemserversEntity;
    function Systemservers_Entities_UpdateEntity(entity: TSystemserversEntity): TSystemserversEntity;
    procedure Systemservers_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'systemservers' ******************
    function Systemservers_DataSets_FindAll(): String;
    function Systemservers_DataSets_GetById(id: Integer): String;
    function Systemservers_DataSets_Delete(id: Integer): String;
    function Systemservers_DataSets_GetBySql(sql: String): String;
    function Systemservers_DataSets_GetEntityByWhere(where: String): String;
    function Systemservers_DataSets_GetListByWhere(where: String): String;
    function Systemservers_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Systemservers_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'systemtriggers' ******************
    function Systemtriggers_Entities_FindAll(): Array_Of_TSystemtriggersEntity;
    function Systemtriggers_Entities_GetById(id: Integer): TSystemtriggersEntity;
    function Systemtriggers_Entities_GetBySql(sql: String): Array_Of_TSystemtriggersEntity;
    function Systemtriggers_Entities_GetEntityByWhere(where: String): TSystemtriggersEntity;
    function Systemtriggers_Entities_GetListByWhere(where: String): Array_Of_TSystemtriggersEntity;
    function Systemtriggers_Entities_SaveEntity(entity: TSystemtriggersEntity): TSystemtriggersEntity;
    function Systemtriggers_Entities_UpdateEntity(entity: TSystemtriggersEntity): TSystemtriggersEntity;
    procedure Systemtriggers_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'systemtriggers' ******************
    function Systemtriggers_DataSets_FindAll(): String;
    function Systemtriggers_DataSets_GetById(id: Integer): String;
    function Systemtriggers_DataSets_Delete(id: Integer): String;
    function Systemtriggers_DataSets_GetBySql(sql: String): String;
    function Systemtriggers_DataSets_GetEntityByWhere(where: String): String;
    function Systemtriggers_DataSets_GetListByWhere(where: String): String;
    function Systemtriggers_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Systemtriggers_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblconvertgroups' ******************
    function Tblconvertgroups_Entities_FindAll(): Array_Of_TTblconvertgroupsEntity;
    function Tblconvertgroups_Entities_GetById(id: Integer): TTblconvertgroupsEntity;
    function Tblconvertgroups_Entities_GetBySql(sql: String): Array_Of_TTblconvertgroupsEntity;
    function Tblconvertgroups_Entities_GetEntityByWhere(where: String): TTblconvertgroupsEntity;
    function Tblconvertgroups_Entities_GetListByWhere(where: String): Array_Of_TTblconvertgroupsEntity;
    function Tblconvertgroups_Entities_SaveEntity(entity: TTblconvertgroupsEntity): TTblconvertgroupsEntity;
    function Tblconvertgroups_Entities_UpdateEntity(entity: TTblconvertgroupsEntity): TTblconvertgroupsEntity;
    procedure Tblconvertgroups_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblconvertgroups' ******************
    function Tblconvertgroups_DataSets_FindAll(): String;
    function Tblconvertgroups_DataSets_GetById(id: Integer): String;
    function Tblconvertgroups_DataSets_Delete(id: Integer): String;
    function Tblconvertgroups_DataSets_GetBySql(sql: String): String;
    function Tblconvertgroups_DataSets_GetEntityByWhere(where: String): String;
    function Tblconvertgroups_DataSets_GetListByWhere(where: String): String;
    function Tblconvertgroups_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblconvertgroups_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblconverts' ******************
    function Tblconverts_Entities_FindAll(): Array_Of_TTblconvertsEntity;
    function Tblconverts_Entities_GetById(id: Integer): TTblconvertsEntity;
    function Tblconverts_Entities_GetBySql(sql: String): Array_Of_TTblconvertsEntity;
    function Tblconverts_Entities_GetEntityByWhere(where: String): TTblconvertsEntity;
    function Tblconverts_Entities_GetListByWhere(where: String): Array_Of_TTblconvertsEntity;
    function Tblconverts_Entities_SaveEntity(entity: TTblconvertsEntity): TTblconvertsEntity;
    function Tblconverts_Entities_UpdateEntity(entity: TTblconvertsEntity): TTblconvertsEntity;
    procedure Tblconverts_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblconverts' ******************
    function Tblconverts_DataSets_FindAll(): String;
    function Tblconverts_DataSets_GetById(id: Integer): String;
    function Tblconverts_DataSets_Delete(id: Integer): String;
    function Tblconverts_DataSets_GetBySql(sql: String): String;
    function Tblconverts_DataSets_GetEntityByWhere(where: String): String;
    function Tblconverts_DataSets_GetListByWhere(where: String): String;
    function Tblconverts_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblconverts_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tbldelpersons' ******************
    function Tbldelpersons_Entities_FindAll(): Array_Of_TTbldelpersonsEntity;
    function Tbldelpersons_Entities_GetById(id: Integer): TTbldelpersonsEntity;
    function Tbldelpersons_Entities_GetBySql(sql: String): Array_Of_TTbldelpersonsEntity;
    function Tbldelpersons_Entities_GetEntityByWhere(where: String): TTbldelpersonsEntity;
    function Tbldelpersons_Entities_GetListByWhere(where: String): Array_Of_TTbldelpersonsEntity;
    function Tbldelpersons_Entities_SaveEntity(entity: TTbldelpersonsEntity): TTbldelpersonsEntity;
    function Tbldelpersons_Entities_UpdateEntity(entity: TTbldelpersonsEntity): TTbldelpersonsEntity;
    procedure Tbldelpersons_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tbldelpersons' ******************
    function Tbldelpersons_DataSets_FindAll(): String;
    function Tbldelpersons_DataSets_GetById(id: Integer): String;
    function Tbldelpersons_DataSets_Delete(id: Integer): String;
    function Tbldelpersons_DataSets_GetBySql(sql: String): String;
    function Tbldelpersons_DataSets_GetEntityByWhere(where: String): String;
    function Tbldelpersons_DataSets_GetListByWhere(where: String): String;
    function Tbldelpersons_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tbldelpersons_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tbldelreservations' ******************
    function Tbldelreservations_Entities_FindAll(): Array_Of_TTbldelreservationsEntity;
    function Tbldelreservations_Entities_GetById(id: Integer): TTbldelreservationsEntity;
    function Tbldelreservations_Entities_GetBySql(sql: String): Array_Of_TTbldelreservationsEntity;
    function Tbldelreservations_Entities_GetEntityByWhere(where: String): TTbldelreservationsEntity;
    function Tbldelreservations_Entities_GetListByWhere(where: String): Array_Of_TTbldelreservationsEntity;
    function Tbldelreservations_Entities_SaveEntity(entity: TTbldelreservationsEntity): TTbldelreservationsEntity;
    function Tbldelreservations_Entities_UpdateEntity(entity: TTbldelreservationsEntity): TTbldelreservationsEntity;
    procedure Tbldelreservations_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tbldelreservations' ******************
    function Tbldelreservations_DataSets_FindAll(): String;
    function Tbldelreservations_DataSets_GetById(id: Integer): String;
    function Tbldelreservations_DataSets_Delete(id: Integer): String;
    function Tbldelreservations_DataSets_GetBySql(sql: String): String;
    function Tbldelreservations_DataSets_GetEntityByWhere(where: String): String;
    function Tbldelreservations_DataSets_GetListByWhere(where: String): String;
    function Tbldelreservations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tbldelreservations_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tbldelroomreservations' ******************
    function Tbldelroomreservations_Entities_FindAll(): Array_Of_TTbldelroomreservationsEntity;
    function Tbldelroomreservations_Entities_GetById(id: Integer): TTbldelroomreservationsEntity;
    function Tbldelroomreservations_Entities_GetBySql(sql: String): Array_Of_TTbldelroomreservationsEntity;
    function Tbldelroomreservations_Entities_GetEntityByWhere(where: String): TTbldelroomreservationsEntity;
    function Tbldelroomreservations_Entities_GetListByWhere(where: String): Array_Of_TTbldelroomreservationsEntity;
    function Tbldelroomreservations_Entities_SaveEntity(entity: TTbldelroomreservationsEntity): TTbldelroomreservationsEntity;
    function Tbldelroomreservations_Entities_UpdateEntity(entity: TTbldelroomreservationsEntity): TTbldelroomreservationsEntity;
    procedure Tbldelroomreservations_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tbldelroomreservations' ******************
    function Tbldelroomreservations_DataSets_FindAll(): String;
    function Tbldelroomreservations_DataSets_GetById(id: Integer): String;
    function Tbldelroomreservations_DataSets_Delete(id: Integer): String;
    function Tbldelroomreservations_DataSets_GetBySql(sql: String): String;
    function Tbldelroomreservations_DataSets_GetEntityByWhere(where: String): String;
    function Tbldelroomreservations_DataSets_GetListByWhere(where: String): String;
    function Tbldelroomreservations_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tbldelroomreservations_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblhiddeninfo' ******************
    function Tblhiddeninfo_Entities_FindAll(): Array_Of_TTblhiddeninfoEntity;
    function Tblhiddeninfo_Entities_GetById(id: Integer): TTblhiddeninfoEntity;
    function Tblhiddeninfo_Entities_GetBySql(sql: String): Array_Of_TTblhiddeninfoEntity;
    function Tblhiddeninfo_Entities_GetEntityByWhere(where: String): TTblhiddeninfoEntity;
    function Tblhiddeninfo_Entities_GetListByWhere(where: String): Array_Of_TTblhiddeninfoEntity;
    function Tblhiddeninfo_Entities_SaveEntity(entity: TTblhiddeninfoEntity): TTblhiddeninfoEntity;
    function Tblhiddeninfo_Entities_UpdateEntity(entity: TTblhiddeninfoEntity): TTblhiddeninfoEntity;
    procedure Tblhiddeninfo_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblhiddeninfo' ******************
    function Tblhiddeninfo_DataSets_FindAll(): String;
    function Tblhiddeninfo_DataSets_GetById(id: Integer): String;
    function Tblhiddeninfo_DataSets_Delete(id: Integer): String;
    function Tblhiddeninfo_DataSets_GetBySql(sql: String): String;
    function Tblhiddeninfo_DataSets_GetEntityByWhere(where: String): String;
    function Tblhiddeninfo_DataSets_GetListByWhere(where: String): String;
    function Tblhiddeninfo_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblhiddeninfo_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblimportlogs' ******************
    function Tblimportlogs_Entities_FindAll(): Array_Of_TTblimportlogsEntity;
    function Tblimportlogs_Entities_GetById(id: Integer): TTblimportlogsEntity;
    function Tblimportlogs_Entities_GetBySql(sql: String): Array_Of_TTblimportlogsEntity;
    function Tblimportlogs_Entities_GetEntityByWhere(where: String): TTblimportlogsEntity;
    function Tblimportlogs_Entities_GetListByWhere(where: String): Array_Of_TTblimportlogsEntity;
    function Tblimportlogs_Entities_SaveEntity(entity: TTblimportlogsEntity): TTblimportlogsEntity;
    function Tblimportlogs_Entities_UpdateEntity(entity: TTblimportlogsEntity): TTblimportlogsEntity;
    procedure Tblimportlogs_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblimportlogs' ******************
    function Tblimportlogs_DataSets_FindAll(): String;
    function Tblimportlogs_DataSets_GetById(id: Integer): String;
    function Tblimportlogs_DataSets_Delete(id: Integer): String;
    function Tblimportlogs_DataSets_GetBySql(sql: String): String;
    function Tblimportlogs_DataSets_GetEntityByWhere(where: String): String;
    function Tblimportlogs_DataSets_GetListByWhere(where: String): String;
    function Tblimportlogs_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblimportlogs_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblinc' ******************
    function Tblinc_Entities_FindAll(): Array_Of_TTblincEntity;
    function Tblinc_Entities_GetById(id: Integer): TTblincEntity;
    function Tblinc_Entities_GetBySql(sql: String): Array_Of_TTblincEntity;
    function Tblinc_Entities_GetEntityByWhere(where: String): TTblincEntity;
    function Tblinc_Entities_GetListByWhere(where: String): Array_Of_TTblincEntity;
    function Tblinc_Entities_SaveEntity(entity: TTblincEntity): TTblincEntity;
    function Tblinc_Entities_UpdateEntity(entity: TTblincEntity): TTblincEntity;
    procedure Tblinc_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblinc' ******************
    function Tblinc_DataSets_FindAll(): String;
    function Tblinc_DataSets_GetById(id: Integer): String;
    function Tblinc_DataSets_Delete(id: Integer): String;
    function Tblinc_DataSets_GetBySql(sql: String): String;
    function Tblinc_DataSets_GetEntityByWhere(where: String): String;
    function Tblinc_DataSets_GetListByWhere(where: String): String;
    function Tblinc_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblinc_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblinvoiceactions' ******************
    function Tblinvoiceactions_Entities_FindAll(): Array_Of_TTblinvoiceactionsEntity;
    function Tblinvoiceactions_Entities_GetById(id: Integer): TTblinvoiceactionsEntity;
    function Tblinvoiceactions_Entities_GetBySql(sql: String): Array_Of_TTblinvoiceactionsEntity;
    function Tblinvoiceactions_Entities_GetEntityByWhere(where: String): TTblinvoiceactionsEntity;
    function Tblinvoiceactions_Entities_GetListByWhere(where: String): Array_Of_TTblinvoiceactionsEntity;
    function Tblinvoiceactions_Entities_SaveEntity(entity: TTblinvoiceactionsEntity): TTblinvoiceactionsEntity;
    function Tblinvoiceactions_Entities_UpdateEntity(entity: TTblinvoiceactionsEntity): TTblinvoiceactionsEntity;
    procedure Tblinvoiceactions_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblinvoiceactions' ******************
    function Tblinvoiceactions_DataSets_FindAll(): String;
    function Tblinvoiceactions_DataSets_GetById(id: Integer): String;
    function Tblinvoiceactions_DataSets_Delete(id: Integer): String;
    function Tblinvoiceactions_DataSets_GetBySql(sql: String): String;
    function Tblinvoiceactions_DataSets_GetEntityByWhere(where: String): String;
    function Tblinvoiceactions_DataSets_GetListByWhere(where: String): String;
    function Tblinvoiceactions_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblinvoiceactions_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblmaidactions' ******************
    function Tblmaidactions_Entities_FindAll(): Array_Of_TTblmaidactionsEntity;
    function Tblmaidactions_Entities_GetById(id: Integer): TTblmaidactionsEntity;
    function Tblmaidactions_Entities_GetBySql(sql: String): Array_Of_TTblmaidactionsEntity;
    function Tblmaidactions_Entities_GetEntityByWhere(where: String): TTblmaidactionsEntity;
    function Tblmaidactions_Entities_GetListByWhere(where: String): Array_Of_TTblmaidactionsEntity;
    function Tblmaidactions_Entities_SaveEntity(entity: TTblmaidactionsEntity): TTblmaidactionsEntity;
    function Tblmaidactions_Entities_UpdateEntity(entity: TTblmaidactionsEntity): TTblmaidactionsEntity;
    procedure Tblmaidactions_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblmaidactions' ******************
    function Tblmaidactions_DataSets_FindAll(): String;
    function Tblmaidactions_DataSets_GetById(id: Integer): String;
    function Tblmaidactions_DataSets_Delete(id: Integer): String;
    function Tblmaidactions_DataSets_GetBySql(sql: String): String;
    function Tblmaidactions_DataSets_GetEntityByWhere(where: String): String;
    function Tblmaidactions_DataSets_GetListByWhere(where: String): String;
    function Tblmaidactions_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblmaidactions_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblmaidjobs' ******************
    function Tblmaidjobs_Entities_FindAll(): Array_Of_TTblmaidjobsEntity;
    function Tblmaidjobs_Entities_GetById(id: Integer): TTblmaidjobsEntity;
    function Tblmaidjobs_Entities_GetBySql(sql: String): Array_Of_TTblmaidjobsEntity;
    function Tblmaidjobs_Entities_GetEntityByWhere(where: String): TTblmaidjobsEntity;
    function Tblmaidjobs_Entities_GetListByWhere(where: String): Array_Of_TTblmaidjobsEntity;
    function Tblmaidjobs_Entities_SaveEntity(entity: TTblmaidjobsEntity): TTblmaidjobsEntity;
    function Tblmaidjobs_Entities_UpdateEntity(entity: TTblmaidjobsEntity): TTblmaidjobsEntity;
    procedure Tblmaidjobs_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblmaidjobs' ******************
    function Tblmaidjobs_DataSets_FindAll(): String;
    function Tblmaidjobs_DataSets_GetById(id: Integer): String;
    function Tblmaidjobs_DataSets_Delete(id: Integer): String;
    function Tblmaidjobs_DataSets_GetBySql(sql: String): String;
    function Tblmaidjobs_DataSets_GetEntityByWhere(where: String): String;
    function Tblmaidjobs_DataSets_GetListByWhere(where: String): String;
    function Tblmaidjobs_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblmaidjobs_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblmaidlists' ******************
    function Tblmaidlists_Entities_FindAll(): Array_Of_TTblmaidlistsEntity;
    function Tblmaidlists_Entities_GetById(id: Integer): TTblmaidlistsEntity;
    function Tblmaidlists_Entities_GetBySql(sql: String): Array_Of_TTblmaidlistsEntity;
    function Tblmaidlists_Entities_GetEntityByWhere(where: String): TTblmaidlistsEntity;
    function Tblmaidlists_Entities_GetListByWhere(where: String): Array_Of_TTblmaidlistsEntity;
    function Tblmaidlists_Entities_SaveEntity(entity: TTblmaidlistsEntity): TTblmaidlistsEntity;
    function Tblmaidlists_Entities_UpdateEntity(entity: TTblmaidlistsEntity): TTblmaidlistsEntity;
    procedure Tblmaidlists_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblmaidlists' ******************
    function Tblmaidlists_DataSets_FindAll(): String;
    function Tblmaidlists_DataSets_GetById(id: Integer): String;
    function Tblmaidlists_DataSets_Delete(id: Integer): String;
    function Tblmaidlists_DataSets_GetBySql(sql: String): String;
    function Tblmaidlists_DataSets_GetEntityByWhere(where: String): String;
    function Tblmaidlists_DataSets_GetListByWhere(where: String): String;
    function Tblmaidlists_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblmaidlists_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblpoxexport' ******************
    function Tblpoxexport_Entities_FindAll(): Array_Of_TTblpoxexportEntity;
    function Tblpoxexport_Entities_GetById(id: Integer): TTblpoxexportEntity;
    function Tblpoxexport_Entities_GetBySql(sql: String): Array_Of_TTblpoxexportEntity;
    function Tblpoxexport_Entities_GetEntityByWhere(where: String): TTblpoxexportEntity;
    function Tblpoxexport_Entities_GetListByWhere(where: String): Array_Of_TTblpoxexportEntity;
    function Tblpoxexport_Entities_SaveEntity(entity: TTblpoxexportEntity): TTblpoxexportEntity;
    function Tblpoxexport_Entities_UpdateEntity(entity: TTblpoxexportEntity): TTblpoxexportEntity;
    procedure Tblpoxexport_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblpoxexport' ******************
    function Tblpoxexport_DataSets_FindAll(): String;
    function Tblpoxexport_DataSets_GetById(id: Integer): String;
    function Tblpoxexport_DataSets_Delete(id: Integer): String;
    function Tblpoxexport_DataSets_GetBySql(sql: String): String;
    function Tblpoxexport_DataSets_GetEntityByWhere(where: String): String;
    function Tblpoxexport_DataSets_GetListByWhere(where: String): String;
    function Tblpoxexport_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblpoxexport_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblpricecodes' ******************
    function Tblpricecodes_Entities_FindAll(): Array_Of_TTblpricecodesEntity;
    function Tblpricecodes_Entities_GetById(id: Integer): TTblpricecodesEntity;
    function Tblpricecodes_Entities_GetBySql(sql: String): Array_Of_TTblpricecodesEntity;
    function Tblpricecodes_Entities_GetEntityByWhere(where: String): TTblpricecodesEntity;
    function Tblpricecodes_Entities_GetListByWhere(where: String): Array_Of_TTblpricecodesEntity;
    function Tblpricecodes_Entities_SaveEntity(entity: TTblpricecodesEntity): TTblpricecodesEntity;
    function Tblpricecodes_Entities_UpdateEntity(entity: TTblpricecodesEntity): TTblpricecodesEntity;
    procedure Tblpricecodes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblpricecodes' ******************
    function Tblpricecodes_DataSets_FindAll(): String;
    function Tblpricecodes_DataSets_GetById(id: Integer): String;
    function Tblpricecodes_DataSets_Delete(id: Integer): String;
    function Tblpricecodes_DataSets_GetBySql(sql: String): String;
    function Tblpricecodes_DataSets_GetEntityByWhere(where: String): String;
    function Tblpricecodes_DataSets_GetListByWhere(where: String): String;
    function Tblpricecodes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblpricecodes_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblroomstatus' ******************
    function Tblroomstatus_Entities_FindAll(): Array_Of_TTblroomstatusEntity;
    function Tblroomstatus_Entities_GetById(id: Integer): TTblroomstatusEntity;
    function Tblroomstatus_Entities_GetBySql(sql: String): Array_Of_TTblroomstatusEntity;
    function Tblroomstatus_Entities_GetEntityByWhere(where: String): TTblroomstatusEntity;
    function Tblroomstatus_Entities_GetListByWhere(where: String): Array_Of_TTblroomstatusEntity;
    function Tblroomstatus_Entities_SaveEntity(entity: TTblroomstatusEntity): TTblroomstatusEntity;
    function Tblroomstatus_Entities_UpdateEntity(entity: TTblroomstatusEntity): TTblroomstatusEntity;
    procedure Tblroomstatus_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblroomstatus' ******************
    function Tblroomstatus_DataSets_FindAll(): String;
    function Tblroomstatus_DataSets_GetById(id: Integer): String;
    function Tblroomstatus_DataSets_Delete(id: Integer): String;
    function Tblroomstatus_DataSets_GetBySql(sql: String): String;
    function Tblroomstatus_DataSets_GetEntityByWhere(where: String): String;
    function Tblroomstatus_DataSets_GetListByWhere(where: String): String;
    function Tblroomstatus_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblroomstatus_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tblseasons' ******************
    function Tblseasons_Entities_FindAll(): Array_Of_TTblseasonsEntity;
    function Tblseasons_Entities_GetById(id: Integer): TTblseasonsEntity;
    function Tblseasons_Entities_GetBySql(sql: String): Array_Of_TTblseasonsEntity;
    function Tblseasons_Entities_GetEntityByWhere(where: String): TTblseasonsEntity;
    function Tblseasons_Entities_GetListByWhere(where: String): Array_Of_TTblseasonsEntity;
    function Tblseasons_Entities_SaveEntity(entity: TTblseasonsEntity): TTblseasonsEntity;
    function Tblseasons_Entities_UpdateEntity(entity: TTblseasonsEntity): TTblseasonsEntity;
    procedure Tblseasons_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tblseasons' ******************
    function Tblseasons_DataSets_FindAll(): String;
    function Tblseasons_DataSets_GetById(id: Integer): String;
    function Tblseasons_DataSets_Delete(id: Integer): String;
    function Tblseasons_DataSets_GetBySql(sql: String): String;
    function Tblseasons_DataSets_GetEntityByWhere(where: String): String;
    function Tblseasons_DataSets_GetListByWhere(where: String): String;
    function Tblseasons_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tblseasons_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'teldevices' ******************
    function Teldevices_Entities_FindAll(): Array_Of_TTeldevicesEntity;
    function Teldevices_Entities_GetById(id: Integer): TTeldevicesEntity;
    function Teldevices_Entities_GetBySql(sql: String): Array_Of_TTeldevicesEntity;
    function Teldevices_Entities_GetEntityByWhere(where: String): TTeldevicesEntity;
    function Teldevices_Entities_GetListByWhere(where: String): Array_Of_TTeldevicesEntity;
    function Teldevices_Entities_SaveEntity(entity: TTeldevicesEntity): TTeldevicesEntity;
    function Teldevices_Entities_UpdateEntity(entity: TTeldevicesEntity): TTeldevicesEntity;
    procedure Teldevices_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'teldevices' ******************
    function Teldevices_DataSets_FindAll(): String;
    function Teldevices_DataSets_GetById(id: Integer): String;
    function Teldevices_DataSets_Delete(id: Integer): String;
    function Teldevices_DataSets_GetBySql(sql: String): String;
    function Teldevices_DataSets_GetEntityByWhere(where: String): String;
    function Teldevices_DataSets_GetListByWhere(where: String): String;
    function Teldevices_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Teldevices_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'tellog' ******************
    function Tellog_Entities_FindAll(): Array_Of_TTellogEntity;
    function Tellog_Entities_GetById(id: Integer): TTellogEntity;
    function Tellog_Entities_GetBySql(sql: String): Array_Of_TTellogEntity;
    function Tellog_Entities_GetEntityByWhere(where: String): TTellogEntity;
    function Tellog_Entities_GetListByWhere(where: String): Array_Of_TTellogEntity;
    function Tellog_Entities_SaveEntity(entity: TTellogEntity): TTellogEntity;
    function Tellog_Entities_UpdateEntity(entity: TTellogEntity): TTellogEntity;
    procedure Tellog_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'tellog' ******************
    function Tellog_DataSets_FindAll(): String;
    function Tellog_DataSets_GetById(id: Integer): String;
    function Tellog_DataSets_Delete(id: Integer): String;
    function Tellog_DataSets_GetBySql(sql: String): String;
    function Tellog_DataSets_GetEntityByWhere(where: String): String;
    function Tellog_DataSets_GetListByWhere(where: String): String;
    function Tellog_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Tellog_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'telpricegroups' ******************
    function Telpricegroups_Entities_FindAll(): Array_Of_TTelpricegroupsEntity;
    function Telpricegroups_Entities_GetById(id: Integer): TTelpricegroupsEntity;
    function Telpricegroups_Entities_GetBySql(sql: String): Array_Of_TTelpricegroupsEntity;
    function Telpricegroups_Entities_GetEntityByWhere(where: String): TTelpricegroupsEntity;
    function Telpricegroups_Entities_GetListByWhere(where: String): Array_Of_TTelpricegroupsEntity;
    function Telpricegroups_Entities_SaveEntity(entity: TTelpricegroupsEntity): TTelpricegroupsEntity;
    function Telpricegroups_Entities_UpdateEntity(entity: TTelpricegroupsEntity): TTelpricegroupsEntity;
    procedure Telpricegroups_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'telpricegroups' ******************
    function Telpricegroups_DataSets_FindAll(): String;
    function Telpricegroups_DataSets_GetById(id: Integer): String;
    function Telpricegroups_DataSets_Delete(id: Integer): String;
    function Telpricegroups_DataSets_GetBySql(sql: String): String;
    function Telpricegroups_DataSets_GetEntityByWhere(where: String): String;
    function Telpricegroups_DataSets_GetListByWhere(where: String): String;
    function Telpricegroups_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Telpricegroups_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'telpricerules' ******************
    function Telpricerules_Entities_FindAll(): Array_Of_TTelpricerulesEntity;
    function Telpricerules_Entities_GetById(id: Integer): TTelpricerulesEntity;
    function Telpricerules_Entities_GetBySql(sql: String): Array_Of_TTelpricerulesEntity;
    function Telpricerules_Entities_GetEntityByWhere(where: String): TTelpricerulesEntity;
    function Telpricerules_Entities_GetListByWhere(where: String): Array_Of_TTelpricerulesEntity;
    function Telpricerules_Entities_SaveEntity(entity: TTelpricerulesEntity): TTelpricerulesEntity;
    function Telpricerules_Entities_UpdateEntity(entity: TTelpricerulesEntity): TTelpricerulesEntity;
    procedure Telpricerules_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'telpricerules' ******************
    function Telpricerules_DataSets_FindAll(): String;
    function Telpricerules_DataSets_GetById(id: Integer): String;
    function Telpricerules_DataSets_Delete(id: Integer): String;
    function Telpricerules_DataSets_GetBySql(sql: String): String;
    function Telpricerules_DataSets_GetEntityByWhere(where: String): String;
    function Telpricerules_DataSets_GetListByWhere(where: String): String;
    function Telpricerules_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Telpricerules_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'ttmp' ******************
    function Ttmp_Entities_FindAll(): Array_Of_TTtmpEntity;
    function Ttmp_Entities_GetById(id: Integer): TTtmpEntity;
    function Ttmp_Entities_GetBySql(sql: String): Array_Of_TTtmpEntity;
    function Ttmp_Entities_GetEntityByWhere(where: String): TTtmpEntity;
    function Ttmp_Entities_GetListByWhere(where: String): Array_Of_TTtmpEntity;
    function Ttmp_Entities_SaveEntity(entity: TTtmpEntity): TTtmpEntity;
    function Ttmp_Entities_UpdateEntity(entity: TTtmpEntity): TTtmpEntity;
    procedure Ttmp_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'ttmp' ******************
    function Ttmp_DataSets_FindAll(): String;
    function Ttmp_DataSets_GetById(id: Integer): String;
    function Ttmp_DataSets_Delete(id: Integer): String;
    function Ttmp_DataSets_GetBySql(sql: String): String;
    function Ttmp_DataSets_GetEntityByWhere(where: String): String;
    function Ttmp_DataSets_GetListByWhere(where: String): String;
    function Ttmp_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Ttmp_DataSets_ExecuteSql(sql: String): String;

    // ******************** Delphi Methods of Java Entities for table 'vatcodes' ******************
    function Vatcodes_Entities_FindAll(): Array_Of_TVatcodesEntity;
    function Vatcodes_Entities_GetById(id: Integer): TVatcodesEntity;
    function Vatcodes_Entities_GetBySql(sql: String): Array_Of_TVatcodesEntity;
    function Vatcodes_Entities_GetEntityByWhere(where: String): TVatcodesEntity;
    function Vatcodes_Entities_GetListByWhere(where: String): Array_Of_TVatcodesEntity;
    function Vatcodes_Entities_SaveEntity(entity: TVatcodesEntity): TVatcodesEntity;
    function Vatcodes_Entities_UpdateEntity(entity: TVatcodesEntity): TVatcodesEntity;
    procedure Vatcodes_Entities_Delete(id: Integer);

    // ******************** Returned Strings are MS ResultSet XMLs for table 'vatcodes' ******************
    function Vatcodes_DataSets_FindAll(): String;
    function Vatcodes_DataSets_GetById(id: Integer): String;
    function Vatcodes_DataSets_Delete(id: Integer): String;
    function Vatcodes_DataSets_GetBySql(sql: String): String;
    function Vatcodes_DataSets_GetEntityByWhere(where: String): String;
    function Vatcodes_DataSets_GetListByWhere(where: String): String;
    function Vatcodes_DataSets_GetValueOfFieldsFromWhereClause(fields : String; where: String): String;
    function Vatcodes_DataSets_ExecuteSql(sql: String): String;
