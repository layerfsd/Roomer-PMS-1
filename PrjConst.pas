unit PrjConst;

interface

uses System.Generics.Collections, System.Generics.Defaults, SysUtils
  ;

resourcestring
  SVersion = 'Version ';
  SDatabase = 'Database ';

  //uMain
  sh0070 = 'Version';
  sh0080 = 'Ver';


function GetTranslatedText(nameOfConstant : String) : String;
procedure GenerateTranslateTextTableForConstants;
procedure GenerateTranslateTextTableForAllForms;

implementation

uses uAppGlobal,
  uProvideARoom2,

  uRoomerLanguage,
//  uInvoiceInfo,
  uInvoice,
  uReservationProfile,
  uInvoicePayment,
  uControlData,
  uFinishedInvoices2,
//  uRoomStatus,
  uCreditPrompt,
//  uInvoiceCompress,
  uInvoiceList,
  uConverts,
  ufrmSelLang,
//  uHotelListMissing,
  uMaidActions,
  uMaidActionsEdit,
  uInvoiceSummeryOBJ,
//  uMakeReservation,
  uRoomDateProblem,
  uResProblem,
//  uStatisticsForcast,
  uDayFinical,
  uConvertGroups,
  uInvoiceList2,
//  uRptCustomer,
  uDayNotes,
  uChangeRRdates,
  uChangeRate,
  uOpenInvoicesNew,
  uResMemos,
  uHomeDate,
  uAllotmentToRes,
  uGoToRoomAndDate,
  uHiddenInfo,
  uDownPayment,
  uFrmChannelTogglingRules,
  uLodgingTaxReport2,
  uCancelReservation3,
  uCancelReservation2,
  uNationalReport3,
  uAddAccommodation,
  uCountries,
  uPayGroups,
  uPriceCodes,
  uGuestProfile2,
  uPayTypes,
  uCountryGroups,
  uVatCodes,
  uRebuildReservationStats,
  uMakeReservationQuick,
  uSplashRoomer,
  RoomerLoginForm,
  uAboutRoomer,
  uManageFilesOnServer,
  uChannelAvailabilityManager,
  ueditRoomPrice,
  uRoomCleanMaintenanceStatus,
  uRates,
  uSeasons2,
  uRoomRates,
  uRoomTypesGroups2,
  uRoomTypes2,
  uPackageItems,
  uRooms3,
  uCustomers2,
  uStaffEdit2,
  uStaffMembers2,
  uCustomerEdit2,
  uChannels,
//  uSystemTriggers,
//  uCreatePassword,
//  uSystemServers,
//  uSystemActions,
//  uChannelRates,
  uStaffTypes2,
  uItems2,
  uItemTypes2,
  uLocations2,
  uCurrencies,
  uChannelManager,
  uCommunicationTest,
  uHouseKeeping,
//  uTableEditForm,
  uRptResStats,
  uGuestSearch,
//  uRptResDates,
  uMultiSelection,
  uPersonviptypes,
  uPersoncontacttype,
  ufrmKeyPairSelector,
  uFrmResources,
  uAssignPayment,
  ufDownPayments,
  uTaxes,
  uFrmMessagesTemplates,
  uFrmNotepad,
  uRptResInvoices,
  uRptTotallist,
  uRptCustInvoices,
  uFrmRBEContainer,
  uFrmRbePreferences,
  urptManagment,
  uFrmHandleBookKeepingException,
  uRoomClassEdit,
  urptReservations,
  uFrmPostInvoices,
  urptBreakfastGuests,
  uGuestCheckInForm,
  uRptNotes,
//  uRptGuests,

  uReservationHintHolder,
  uEmbOccupancyView,
  uembPeriodView,
  uFrmRateQuery,

  uRptTurnoverAndPayments,
  uRptResStatsRooms,

  uRptReservationsCust,

  uEmailingDialog,
  uMakeKreditInvoice,

  uGuestProfiles,
  uGuestPortfolioEdit,

  uBookKeepingCodes,

  uFrmEditEmailProperties,

  uRptBookkeeping,
  uReservationEmailingDialog,
  uFrmReservationCancellationDialog,

  uRptCashier,

  uPhoneRates,
  uGroupGuests,

  uEmailExcelSheet,
//  uInvoice2015,
  uInvoiceLineEdit,
  uFrmMergePortfolios,
  uStaffComm,
  uFrmCheckOut,
  uFrmStaffNote,
  uFrmMessageViewer,
  uInvoiceCompare,
  uFrmAlertEdit,
  uFrmAlertDialog,
  uAlertEditPanel,
  uFrmCustomerDepartmentEdit

  , uRptDepartures
  , uRptStockItems
  , ufrmPaymentReqRoomtypeGroup

  , uOfflineReportGrid
  , uHotelStatusOfflineReport
  , uHotelArrivalsOfflineReport
  , uRptArrivals
  , uFrmRoomReservationCancellationDialog
  , uCleaningNotes
  , uCleaningNotesEdit
  ;


Type
  TCustomEqualityComparer = class(TEqualityComparer<string>)
  public
    function Equals(const Left, Right: string): Boolean; override;
    function GetHashCode(const Value: string): Integer; override;
  end;

const PRE_KEY_NAME = 'PrjConst.Constants.';

procedure OriginalConstants;
begin
  constants.Add('SVersion', 'Version ');
  constants.Add('sDatabase', 'Database ');

  //uMain
  constants.Add('sh0070', 'Version');
  constants.Add('sh0080', 'Ver');
  constants.Add('shWrongLoginAttempts', 'Wrong username or password - %d attempts.');
  constants.Add('shStillWorkingInInvoice',
                    'You still are working on an invoice!' + #13#13 +
                    'Please finish working on the current invoice before proceeding.');
  constants.Add('sh1004', 'Quit ROOMER?');
  constants.Add('sh1007', 'Can not access from Guest view');
  constants.Add('sh1008', 'Can not access from period view');
  constants.Add('sh1010', 'Room status is Checked-in');
  constants.Add('shCheckInGroupOfRoom', 'Check in the group that this room [%s] belongs to?');
  constants.Add('shCheckOutGroupOfRoom', 'Check Out the group that this room [%s] belongs to?');
  constants.Add('shChangeStateOfFullReservation', 'Change state of all rooms of reservation [%d] into [%s]?');
  constants.Add('shChangeStateReservationFailedSomeROoms',  'Changing the state of the reservation failed for some rooms.' + #10 +
                                                            'Check individual states in the reservation profile.');
  constants.Add('sh1013', 'Room status is blocked and check in or check out is not possible');
  constants.Add('sh1014', 'Room status is checked-out');
  constants.Add('sh1015', 'Room status is reserved (not checked-in)');
  constants.Add('sh1016', 'Room status is overbooked');
  constants.Add('sh1017', 'Room status is reserved');
  constants.Add('sh1018', 'Room status is allotment');
  constants.Add('sh1019', 'Room status is no-show');
  constants.Add('sh1020', 'Room status is Chanceled');
  constants.Add('sh1021', 'Room status is Tmp1');
  constants.Add('sh1022', 'Room status is Tmp2');
  constants.Add('shCheckOutSelectedRoom', 'Check-out room %s?');
  constants.Add('shCannotCheckoutRoom', '%s - Can not check-out room %s.');
  constants.Add('shStatusIsNoShowFirstChange', 'Status is NO-show.' + #13#13 + 'You need to change the status first.');
  constants.Add('sh1080', 'error - rooms Grid');
  constants.Add('sh1081', 'error - no-Rooms-grid');
  
  constants.Add('sh1091', 'error raised, with message');
  constants.Add('sh1092a', 'The program to execute'); 
  
  constants.Add('sh1092b', 'not found');
  constants.Add('sh1045', 'Invoice: <b>Not made or unknown</b>.');
  constants.Add('sh1046', 'Invoice: <b>Compressed lines - Unknown</b>.');
  constants.Add('shOneDayGetReservationRoom', '%s / Reservation: %s (%d rooms) / %s');
  constants.Add('shRooms', 'Rooms');
  constants.Add('shMainFormStatisticsRooms', 'Rooms');
  constants.Add('shRoom', 'Room');
  constants.Add('shCheckRoom', 'Check in room %s');
  constants.Add('shType', 'Type');
  constants.Add('shGuestReservation', 'Guest/reservation');
  constants.Add('shArrival', 'Arrival');
  constants.Add('shDeparture', 'Departure');
  constants.Add('shRoomInformation', 'Room information');
  constants.Add('shBookingIdText', 'Channel Booking Id');
  constants.Add('shRoomNotAssignedYet', 'This reservation has not been assigned a room yet');
  constants.Add('shWAITINGLIST', 'WAITINGLIST');
  //constants.Add('shALOTMENT', 'ALOTMENT');
  constants.Add('shALOTMENT', 'ALLOTMENT');
  constants.Add('shNOSHOW', 'NO-SHOW');
  constants.Add('shBLOCKED', 'BLOCKED');

  constants.Add('shCanceled', 'CANCELED'); //*HJ 140206
  constants.Add('shTMP1', 'TMP1'); //*HJ 140206
  constants.Add('shTMP2', 'TMP2'); //*HJ 140206

  constants.Add('shTelephone', 'Telephone');
  constants.Add('shFax', 'Fax');
  constants.Add('shPrice', 'Price');
  constants.Add('shPriceAfterDiscount', 'Price after discount');
  constants.Add('shDiscount', 'Discount');
  constants.Add('shInvoice', 'Invoice');
  constants.Add('shRoomMemo', 'Room Memo');
  constants.Add('shPaymentInfo', 'Payment info');
//  constants.Add('shRefrence', 'Refrence');
  constants.Add('shRefrence', 'Reference');
  constants.Add('shReserved', 'Reserved : ');
  constants.Add('shResMemo', 'Res Memo');
  constants.Add('shToOneDay', 'To one day');
  constants.Add('shHideText', 'Hide text');
  constants.Add('shShowText', 'Show text');
  constants.Add('shCreated', 'Created');
  constants.Add('shUser', 'User');
  constants.Add('shGroups', 'Groups');
  constants.Add('shArriving', 'Arriving');
  constants.Add('shDeparting', 'Departing');
  constants.Add('shPasswordNoMatch', 'Passwords Don''t match');
  constants.Add('shAll', 'All');
  //Login
  constants.Add('shDaysLeft', 'Days left');
  // TfrmMakeReservationQuick
  constants.Add('shNotF_star', '** not found **');
  constants.Add('shNotF_upph', ' not found !!');
  constants.Add('shPriceFor', 'price for ');
  constants.Add('shAndCurrency', 'and Currency ');
  constants.Add('shAndPersonVipType', 'and Person VIP Type ');
  constants.Add('shAndPersonContactType', 'and Person Contact Type ');
  // uCountryGroups;
  constants.Add('shDeleteCountrygroup', 'Delete countrygroup');
  constants.Add('shDeleteChannelManager', 'Delete channel manager');
  constants.Add('shDeleteConvertItem', 'Delete convert item');
  constants.Add('shDeleteCountry', 'Delete country');
  constants.Add('shDeleteCurrency', 'Delete currency');
  constants.Add('shDeletePersonVipType', 'Delete Person VIP Type');
  constants.Add('shDeletePersonContactType', 'Delete Person Contact Type');

  constants.Add('shDeletePhoneRate', 'Delete Phone rate');
  constants.Add('shDeletepaygroup', 'Delete paygroup');
  constants.Add('shDeletepayType', 'Delete paytype');
  constants.Add('shDeleteRateRule', 'Delete Rate rule');
  constants.Add('shDeleteRoomRate', 'Delete Room rate');
  constants.Add('shDeleteRoomClass', 'Delete Room class');
  constants.Add('shDeleteSeason', 'Delete season');
  constants.Add('shDeleteItemtype', 'Delete item type');
  constants.Add('shDeleteItem', 'Delete item');
  constants.Add('shDeleteSelectedLine', 'Delete selected line');
  constants.Add('shDeleteLocation', 'Delete location');
  constants.Add('shDeleteRoom', 'Delete Room');
  constants.Add('shDeleteMarketSegment', 'Delete marketsegment');
  constants.Add('shDeleteCustomer', 'Delete customer');
  constants.Add('shDeleteStaffType', 'Delete stafftype');
  constants.Add('shDeleteStaffMember', 'Delete staffMember');
  constants.Add('shDeleteChannel', 'Delete channel');
  constants.Add('shDeleteSystemServers', 'Delete SystemServer');
  constants.Add('shDeleteSystemAction', 'Delete SystemAction');
  constants.Add('shDeleteSystemTrigger', 'Delete SystemTrigger');
  constants.Add('shDeletePackage', 'Delete Package');
  constants.Add('shDeletePackageItem', 'Delete Package item');
  constants.Add('shDeletePerson', 'Delete Person');
  constants.Add('shDeleteVATCode', 'Delete VAT Code');
  constants.Add('shDeleteBookKeepingCode', 'Delete book-keeping code');
  constants.Add('shDeleteDynamicPriceRule', 'Delete the selected dynamic price rule?');
  //
  constants.Add('shFilterOnRecordsOf', 'Filter on - %d records of %d are visible');
  constants.Add('shEnterTextToFilterGrid', 'Enter text to filter grid');
  constants.Add('shFilter', 'Filter : ');
  constants.Add('shClear', 'Clear');
  constants.Add('shExistsInRelatedData', 'exists in related data');
  constants.Add('shCanNotDelete', 'can not delete');
  constants.Add('shExistsInRelatedDataCannotDelete', '%s %s exists in related data' + #10 + 'Cannot delete!');
  constants.Add('shContinue', 'Continue ?');
  constants.Add('shNewValueExistInAnotherRecor', 'New value exist in another record. Use [ESC] to cancel');
  constants.Add('shOldValueUsedInRelatedDataC', ' Old value used in related data can not change - Use [ESC] to cancel');
end;

procedure AddConstants_1;
begin
  constants.Add('shTx_AuthNeeded', '  Authentication needed...  ');
  constants.Add('shTx_Available', 'Available');
  constants.Add('shTx_ChannelAvailable', 'Channel');
  constants.Add('shTx_Class', 'Class');
  constants.Add('shTx_Authenticating', '  Authenticating...  ');
  constants.Add('shTx_AuthSuccess', '  Authentication successful  ');
  constants.Add('shTx_Taken', 'Taken');
  constants.Add('shTx_NoRm', 'NoRm');
  constants.Add('shTx_Free', 'Free');
  constants.Add('shTx_Netto', 'Netto');
  constants.Add('shTx_Cancelled', 'Cancel');
  constants.Add('shTx_NoFilterActive', 'No filter is currently active.');
  constants.Add('shTx_SearchAndFilterActive', 'Search for ''%s'' AND filter currently active.');
  constants.Add('shTx_SearchActive', 'Search for ''%s'' currently active.');
  constants.Add('shTx_FilterActive', 'Filter is currently active.');
  constants.Add('shTx_FreeRoomsFilterActive', 'Filter on Rooms that are free for the next %d currently active.');
  constants.Add('shTx_Location', 'Location');
  constants.Add('shTx_Description', 'Description');
  constants.Add('shTx_Floor', 'Floor');
  constants.Add('shTx_NumGuests', 'Num guests');
  constants.Add('shTx_ReportedBy', 'Reported by');
  constants.Add('shTx_CleaningNotes', 'Cleaning notes');
 // constants.Add('shTx_MaintenanceNotes', 'Mainteance notes');
  constants.Add('shTx_MaintenanceNotes', 'Maintenance notes');
  constants.Add('shTx_LostAndFount', 'Lost and found');
  constants.Add('shTx_Equipment', 'Equipment');
  constants.Add('shTx_Status', 'Status');
  constants.Add('shTx_PerNight', '/night');
  constants.Add('shTx_ReceivedVia', 'Received via');
  constants.Add('shTx_ManuallyEnteredReservation', 'Manually entered reservation');
  constants.Add('shTx_GroupAccount', 'Group account');
  constants.Add('shTx_Note', 'NOTE');
  constants.Add('shTx_UnpaidItemsOnInv', 'Unpaid items on invoice!');
  constants.Add('shTx_NoUnpaidItemsOnInv', 'No unpaid items on invoice');
  constants.Add('shTx_ReservationIdNotFound', 'Reservation %d not found. Please call Roomer support and provide this reservation number.!');
  constants.Add('shTx_UnderDevelopment', 'Under development');
  constants.Add('shTx_SaveToCurrencytable', 'Save to currencytable ' + chr(10) + 'Note : This will have effect on all ' + chr(10) + 'unBooked invoices ');
  constants.Add('shTx_CurrencyUpdateError', 'Error updating currency rate');
  constants.Add('shTx_CancelReservation2_RoomDescriptionAll', 'Room: [%s] %s. - Type: [%s] %s. - Location: %s');
  constants.Add('shTx_CancelReservation2_GuestArrivalDeparture', 'Arrival: %s, Departure: %s');
  constants.Add('shTx_CancelReservation3_RemovingAllRooms', 'Removing ALL rooms from reservation');
  constants.Add('shTx_CancelReservation3_RemovingXRoomsOfYReservedRooms', 'Removing %d rooms of %d reserved rooms');
  constants.Add('shTx_ChannelAvailabilityManager_IncorrectAvailability', 'Incorrect availability');
  constants.Add('shTx_ChannelAvailabilityManager_EnterValidAvailability', 'Please enter a valid availability value');
  constants.Add('shTx_ChannelAvailabilityManager_CurrentRates', 'Current rates on ');
  constants.Add('shTx_ChannelAvailabilityManager_AllRoomTypes', 'All Room Types');
  constants.Add('shTx_ChannelAvailabilityManager_AllPlanCodes', 'All Plan Codes');
  constants.Add('shTx_ChannelAvailabilityManager_Availability', 'Availability');
  constants.Add('shTx_ChannelAvailabilityManager_BulkAvailabilityUpdate', 'Bulk availability update');
  constants.Add('shTx_ChannelAvailabilityManager_Rate', 'Rate');
  constants.Add('shTx_ChannelAvailabilityManager_BulkRateUpdate', 'Bulk rate update');
  constants.Add('shTx_ChannelAvailabilityManager_Availability2', 'AVAILABILITY');
  constants.Add('shTx_ChannelAvailabilityManager_Rates', 'RATES');
  constants.Add('shTx_ChannelAvailabilityManager_OnlineManagement', 'ONLINE MANAGEMENT');
  constants.Add('shTx_ChannelAvailabilityManager_ChangesContinue', 'All changes will be lost. Continue?');
  constants.Add('shTx_ChannelAvailabilityManager_ConfirmRemoveRates', 'NOTE: This will initiate removal of all current rates for the selected channel manager.'#13''#10''#13''#10'Afterwards rates will be re-read for all classes.'#13''#10''#13''#10' Continue?');
  constants.Add('shTx_ChannelAvailabilityManager_EnterValidValue', 'Please enter a valid availability value');
  constants.Add('shTx_ChannelAvailabilityManager_RoomAvailability', '%sAvailability: %s%d%s rooms.</font></font></body>');
//  constants.Add('shTx_ChannelManager_DescriptionRequired', 'Description is requierd - canceling insert - try again');
  constants.Add('shTx_ChannelManager_DescriptionRequired', 'Description is required - canceling insert - try again');
//  constants.Add('shTx_ChannelManager_CodeRequired', 'Code is requierd - canceling insert - try again');
  constants.Add('shTx_ChannelManager_CodeRequired', 'Code is required - canceling insert - try again');
  constants.Add('shTx_ChannelManager_DescriptionError', 'Description');
  constants.Add('shTx_ChannelManager_DescriptionError2', 'is required - Use ESC to cancel');
  constants.Add('shTx_ChannelManager_EditInGrid', 'edit in grid');
  constants.Add('shTx_Channels_UpdateNotOk', 'UPDATE NOT OK');
//  constants.Add('shTx_Channels_ChannelRequired', 'Channel is requierd - set value or use [ESC] to cancel ');
  constants.Add('shTx_Channels_ChannelRequired', 'Channel is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_CommunicationTest_DayGuests', 'Current Day Guests ');
  constants.Add('shTx_CommunicationTest_CustomerList', 'Full Customer list ');
 // constants.Add('shTx_ControlData_NoAccount', 'Formskrá reiknings fannst ekki'#10'undir liðnum Reikningur er reitur '#10'til að staðsetja skránna '#10'Upphafsnafn (default name) hennar '#10'er islInvoice.fr3 ');
  constants.Add('shTx_ControlData_NoAccount', 'Invoice Form not found'#10'in default location '#10'To locate the file '#10'Its default name '#10'is islInvoice.fr3 ');
 // constants.Add('shTx_ControlData_Tax', 'Ath:  Það er ekki búið að skilgreina vörunúmer gistináttaskatts !');
  constants.Add('shTx_ControlData_Tax', 'Note: Overnight tax code has not been specified');
 // constants.Add('shTx_ControlData_Indent', 'Veldu undirlið %s');
  constants.Add('shTx_ControlData_Indent', 'Select subitem %s');
 // constants.Add('shTx_ControlData_NotAForm', '%s er ekki Formskrá (*.fr3) ');
  constants.Add('shTx_ControlData_NotAForm', '%s is not a form (*.fr3) ');
  constants.Add('shTx_ConvertGroups_CodeIsRequiredUseEsc', 'cgCode code - is required - Use ESC to cancel');
 // constants.Add('shTx_ConvertGroups_CodeRequired', 'cgCode code is requierd - canceling insert - try again');
  constants.Add('shTx_ConvertGroups_CodeRequired', 'cgCode code is required - canceling insert - try again');
  constants.Add('shTx_ConvertGroups_NewData', 'Use editrow to add new data');
  constants.Add('shTx_ConvertGroups_EditData', 'Use editrow to edit data');
  constants.Add('shTx_Converts_TypeRequired', 'Convert Type - is required - Use ESC to cancel');
  constants.Add('shTx_Countries_CodeRequired', 'Country code is required - canceling insert - try again');
  constants.Add('shTx_Countries_CountryCodeIsRequired', 'Country code is required - Use ESC to cancel');

  constants.Add('shTx_Currencies_Required', 'Currency required - set value or use [ESC] to cancel ');
  constants.Add('shTx_Currencies_CodeIsRequired', 'Currency code - is required - Use ESC to cancel');
  constants.Add('shTx_Currencies_RateCannotBeZeroCancel', 'Rate can not be 0 - Use ESC to cancel');
  constants.Add('shTx_Currencies_EditInGrid', 'Edit in grid');

  constants.Add('shTx_PersonVipType_Required', 'Peron VIP Type required - set value or use [ESC] to cancel ');
  constants.Add('shTx_PersonVipType_CodeIsRequired', 'Person VIP Type code - is required - Use ESC to cancel');
  constants.Add('shTx_PersonVipType_EditInGrid', 'Edit in grid');

  constants.Add('shTx_PersonContactType_Required', 'Peron Contact Type required - set value or use [ESC] to cancel ');
  constants.Add('shTx_PersonContactType_CodeIsRequired', 'Person Contact Type code - is required - Use ESC to cancel');
  constants.Add('shTx_PersonContactType_EditInGrid', 'Edit in grid');

  constants.Add('shTx_Roomtypes2_RoomTypeAlreadyExists', 'This room type already exists');
  constants.Add('shTx_Rooms3_RoomAlreadyExists', 'This room already exists');
  constants.Add('shTx_RoomtypeGroups_RoomTypeGroupAlreadyExists', 'This room class already exists');

  constants.Add('shTx_CustomerEdit2_CustomerRequired', 'Customer is required');
  constants.Add('shTx_CustomerEdit2_CustomerTypeRequired', 'Customer type is required');
  constants.Add('shTx_CustomerEdit2_CustomerCountryRequired', 'Customer country is required');
  constants.Add('shTx_CustomerEdit2_CustomerCurrencyRequired', 'Customer payment currency is required');
  constants.Add('shTx_CustomerEdit2_CustomerPriceCoceRequired', 'Customer Rate code is required');

  constants.Add('shTx_CustomerEdit2_CustomerExists', 'This customer exists ');
  constants.Add('shTx_CustomerEdit2_NameRequired', 'Name is required');
 // constants.Add('shTx_Customers2_Required', 'Customer requierd - set value or use [ESC] to cancel ');
  constants.Add('shTx_Customers2_Required', 'Customer required - set value or use [ESC] to cancel ');
  constants.Add('shTx_Customers2_InsertNotOk', 'INSERT NOT OK');
 // constants.Add('shTx_CustomerTypes_RegistrationFilter', 'Nýskráning er utan síu og sést því ekki');
  constants.Add('shTx_CustomerTypes_RegistrationFilter', 'Registration filtered and cannot be seen');
 // constants.Add('shTx_CustomerTypes_DeleteCatagory', 'Eyða Viðskiptaaðilaflokk ');
  constants.Add('shTx_CustomerTypes_DeleteCatagory', 'Delete customer group');
 // constants.Add('shTx_CustomerTypes_AreYouSure', 'ertu viss ??');
  constants.Add('shTx_CustomerTypes_AreYouSure', 'Are you sure ??');
  constants.Add('shTx_CustomerTypes2_Description', 'Description ');
 // constants.Add('shTx_CustomerTypes2_Required', 'is requierd - Use ESC to cancel');
  constants.Add('shTx_CustomerTypes2_Required', 'is required - Use ESC to cancel');
 // constants.Add('shTx_CustomerTypes2_CustomerTypeRequired', 'CustomerType is requierd - set value or use [ESC] to cancel ');
  constants.Add('shTx_CustomerTypes2_CustomerTypeRequired', 'CustomerType is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_CustomerTypes2_Code', 'Code ');
  constants.Add('shTx_CustomerTypes2_EditInGrid', 'Edit in grid');
  constants.Add('shTx_D_UnableToSaveExceptionMessage', 'Problem: Unable to save the tmpInvoiveLines !' + #13#13 +
                                       'The following exception occurred:' + #13#13 +
                                       '%s' + #13#13 +
                                       'Please write this message down or' + #13 +
                                       'call support with this dialog open!');
  constants.Add('shTx_D_UnpaidGroup', 'There are unpaid items on Group-invoice - resolve first');
  constants.Add('shTx_D_UnpaidRoom', 'There are unpaid items on room-invoice  - resolve first');
 // constants.Add('shTx_D_MaidActionsUnavailable', 'Taflan MaidActions ekki til staðar ');
  constants.Add('shTx_D_MaidActionsUnavailable', 'The table MaidActions is not available ');
 // constants.Add('shTx_D_TableUsingCannotDelete', 'Tegndar töflur nota %s. Ekki er því unnt að eyða.');
  constants.Add('shTx_D_TableUsingCannotDelete', 'Related tables use %s. Cannot delete');
 // constants.Add('shTx_D_RoomBeingUsedInReservations', 'Herbergi %s er notað í %d pöntunum. ' + #10 + 'Það er því ekki hægt að eyða því');
  constants.Add('shTx_D_RoomBeingUsedInReservations', 'Room %s Is booked in %d reservation. ' + #10 + 'cannot be deleted');
  constants.Add('shTx_D_CurrencyCancel', 'All rooms in Reservation must use same curency -  Canceling!');
  constants.Add('shTx_D_DeleteRoom', 'Delete room from reservation ?');
 // constants.Add('shTx_D_Cancel', 'Bókaðir reikningar eru á þessari pöntunn - Viltu hætta við ?');
  constants.Add('shTx_D_Cancel', 'Invoices have been booked for this reservation - Do you want to cancel ?');
 // constants.Add('shTx_D_InvoicesInDeletedBooking', 'Reikningar á eyddri bókun %s' + #10 +
 //                                       'Skrifið niður ef það á að gera kreditreikninga ');
  constants.Add('shTx_D_InvoicesInDeletedBooking', 'Invoices in deleted booking %s' + #10 +
                                        'Write down the numbers if creating credit invoice '); 
 // constants.Add('shTx_D_OrderConfirm', 'Villtu örugglega setja þetta þessa herbergjapöntunn utan herbergja ?');
  constants.Add('shTx_D_OrderConfirm', 'Are you sure you want this room reservation outside of the rooms?');
 // constants.Add('shTx_D_AllRoomsToNoRoom', 'Viltu örugglega setja ÖLL herbergi pöntunnar ' + #10 +
 //                                       'utan herbergja ?');
  constants.Add('shTx_D_AllRoomsToNoRoom', 'Are You sure you want ALL room reservations' + #10 +
                                        'outside of room?');
 // constants.Add('shTx_D_FolderNotFound', 'Mappan %s fannst ekki.' + #10 +
 //                                       'Skráin verður vistuð í %s');
    constants.Add('shTx_D_FolderNotFound', 'Folder not found' + #10 +
                                        'The file will be saved in %s');
 // constants.Add('shTx_D_PathChange', 'Skráin verður vistuð í %s');
  constants.Add('shTx_D_PathChange', 'File will be saved in %s');
 // constants.Add('shTx_D_AccountReadContinue', 'Það er þegar búið að útlesa reikning %s %d sinnum.' + #10 +
 //                                       'Halda áfram með útlestur ??');
  constants.Add('shTx_D_AccountReadContinue', 'When the account %s has been read %d times.' + #10 +
                                        'Continue reading ??');										
  constants.Add('shTx_D_CheckoutXDaysAgo', 'Should have checked out %d days ago');
  constants.Add('shTx_D_CheckoutYesterday', 'Should have checked out yesterday ');
  constants.Add('shTx_D_LeavesToday', 'Leaves today');
  constants.Add('shTx_D_LeavesTomorrow', 'Leaves tomorrow');
  constants.Add('shTx_D_LeavesAfterXDays', 'Leaves after %d days');
  constants.Add('shTx_D_CheckedIn', 'Guest is Checked in ');
  //constants.Add('shTx_D_AddedNoLogin', 'Added without loggin in');
  constants.Add('shTx_D_AddedNoLogin', 'Added without logging in');
  constants.Add('shTx_D_CheckDates', 'Check dates - 0 days ');
  constants.Add('shTx_D_SomeErrors', ' Some errors ');
  constants.Add('shTx_D_Total', ' total ');
//  constants.Add('shTx_D_OnlyChangeDeparture', 'ATH Aðeins er hægt að breyta brottfarardegi ');
  constants.Add('shTx_D_OnlyChangeDeparture', 'note: Only checkout date can be changed ');
  constants.Add('shTx_D_InvoicesBooked', 'Invoices have been booked for this reservation - Cancel the deletion?');
  constants.Add('shTx_D_InvoicesBookedNumbersWriteDown', 'Invoices have been booked for this reservation' + #10 +
                                          'Numbers : %s' + #10 +
                                          'Write down the numbers if they need to be credited ');
  constants.Add('shTx_D_DeleteAll', 'Delete all rooms in reservation ?');
 // constants.Add('shTx_D_RoomAlreadyCheckedin', 'Herbergi %s er þegar innskráð.');
  constants.Add('shTx_D_RoomAlreadyCheckedin', 'Room %s is already checked in.');
  constants.Add('shTx_DayFinical_NoInvoices', 'There are no unconfirmed invoices');
  constants.Add('shTx_DayFinical_NoInvoicesForFromToDate', 'There are no invoices for %s - %s');
  constants.Add('shTx_DayFinical_NoConfirmedInvoicesFor', 'There are no confirmed invoices for %s');
  constants.Add('shTx_DayFinical_NoInvoices2', 'There is no Confirmed invoices');
  constants.Add('shTx_DayFinical_InvoiceConfirmed', 'Invoiced has been confirmed - unconfirm now!');
 // constants.Add('shTx_DayFinical_NoUnconfirmedInvoices', 'There is no unConfirmed invoices'); - breytti 'C' i 'c'
  constants.Add('shTx_DayFinical_NoUnconfirmedInvoices', 'There is no unconfirmed invoices');
  constants.Add('shTx_DayFinical_InvoiceNotConfirmed', 'Invoiced not confirmed - confirm now!');
  constants.Add('shTx_DayFinical_Unconfirm', 'Un-confirm NOW');
  constants.Add('shTx_DayFinical_Confirm', 'Confirm NOW');
  constants.Add('shTx_DayFinical_CashInvoice', 'This is is a cash invoice');
  constants.Add('shTx_DayFinical_GroupInvoice', 'This is a group invoice');
  
 (* constants.Add('shTx_DayStats_RoomRental', 'Óreikningsfærð Herbergjaleiga ');
  constants.Add('shTx_DayStats_Discount', 'Afsláttur ');
  constants.Add('shTx_DayStats_Total', 'Samtals ');
  constants.Add('shTx_DayStats_File', 'Skráin ');
  constants.Add('shTx_DayStats_NotFound', ' fannst ekki ');
  constants.Add('shTx_DayStats_CreateTable', 'Búa til töflur');
  constants.Add('shTx_DayStats_ErrorDeleted', 'Villa - Delete');
  constants.Add('shTx_DayStats_GetUninvoicedRoom', 'Sækja óreikningsfærða heibergjaleigu ');
  constants.Add('shTx_DayStats_GetUninvoicedGoods', 'Sækja óreikningsfærðar vörur ');
  constants.Add('shTx_DayStats_UninvoicedGroupGoods', 'Sækja óreikningsfærðar vörur á hópreikningum');
  constants.Add('shTx_DayStats_GetInvoicedAccounts', 'Sækja Reikningsfært af herbergja reikningum');
  constants.Add('shTx_DayStats_Error1', 'Villa 1');
  constants.Add('shTx_DayStats_Error2', 'Villa 2');
  constants.Add('shTx_DayStats_Error3', 'Villa 3');
  constants.Add('shTx_DayStats_Error4', 'Villa 4');
  constants.Add('shTx_DayStats_NumberOfBookings', 'Fjöldi pantana ');
  constants.Add('shTx_DayStats_GroupInvoice', ' Reikningsfært á hópreikningi ');
  constants.Add('shTx_DayStats_RoomRent', 'Herbergjaleiga');
  constants.Add('shTx_DayStats_DiscountRoomRent', 'Afsláttur af herbergjaleigu ');
  constants.Add('shTx_DayStats_TotalRoomRent', 'Samtals Herbergjaleiga');
  constants.Add('shTx_DayStats_Products', 'Vörur ');
  constants.Add('shTx_DayStats_TotalSales', 'Samtals Velta ');
  constants.Add('shTx_DayStats_CalcF', 'Reikn.f  ');
  constants.Add('shTx_DayStats_CalcF2', 'Óreikn.f '); *)
  
  constants.Add('shTx_DayStats_RoomRental', 'Uninvoiced Room Rental ');
  constants.Add('shTx_DayStats_Discount', 'Discount ');
  constants.Add('shTx_DayStats_Total', 'Total ');
  constants.Add('shTx_DayStats_File', 'File ');
  constants.Add('shTx_DayStats_NotFound', ' Not found ');
  constants.Add('shTx_DayStats_CreateTable', 'Create table');
  constants.Add('shTx_DayStats_ErrorDeleted', 'Error - deleted');
  constants.Add('shTx_DayStats_GetUninvoicedRoom', 'Get uninvoiced room rental ');
  constants.Add('shTx_DayStats_GetUninvoicedGoods', 'Get uninvoiced goods ');
  constants.Add('shTx_DayStats_UninvoicedGroupGoods', 'Get uninvoiced goods in group');
  constants.Add('shTx_DayStats_GetInvoicedAccounts', 'Get invoiced accounts');
  constants.Add('shTx_DayStats_Error1', 'Error 1');
  constants.Add('shTx_DayStats_Error2', 'Error 2');
  constants.Add('shTx_DayStats_Error3', 'Error 3');
  constants.Add('shTx_DayStats_Error4', 'Error 4');
  constants.Add('shTx_DayStats_NumberOfBookings', 'Number of bookings ');
  constants.Add('shTx_DayStats_GroupInvoice', ' Invoiced on group invoice ');
  constants.Add('shTx_DayStats_RoomRent', 'Room rent');
  constants.Add('shTx_DayStats_DiscountRoomRent', 'Discount of room rental ');
  constants.Add('shTx_DayStats_TotalRoomRent', 'Total room rental');
  constants.Add('shTx_DayStats_Products', 'Products ');
  constants.Add('shTx_DayStats_TotalSales', 'Total Sales ');
  constants.Add('shTx_DayStats_CalcF', 'calc.f  ');
  constants.Add('shTx_DayStats_CalcF2', 'calc.f ');
  
  constants.Add('shTx_FinishedInvoices2_NoFinishedInvoices', 'No finished invoices found for your selection');
  constants.Add('shTx_FinishedInvoices2_Product', 'Product');
  constants.Add('shTx_FinishedInvoices2_Description', 'Description');
  constants.Add('shTx_FinishedInvoices2_Number', 'Number');
  constants.Add('shTx_FinishedInvoices2_Value', 'Value');
  constants.Add('shTx_FinishedInvoices2_Total', 'Total');
  constants.Add('shTx_FinishedInvoices2_Category', 'Category');
  constants.Add('shTx_FinishedInvoices2_Amount', 'Amount');
  constants.Add('shTx_FinishedInvoices2_VAT', 'VAT');
  constants.Add('shTx_FinishedInvoices2_Date', 'Date');
  constants.Add('shTx_FinishedInvoices2_FileNotFound', 'File %s not found ');
  constants.Add('shTx_FinishedInvoices2_NoChange', 'This account will be recreated - no change is made to older account');
  constants.Add('shTx_FormCustomInvoicesMD_AllCustomers', 'All Customers');
  constants.Add('shTx_FormCustomInvoicesMD_SelectCustomer', 'Select Customer');
  constants.Add('shTx_FormCustomInvoicesMD_OneDayDate', 'One Day - select date');
  constants.Add('shTx_FormCustomInvoicesMD_PeriodDate', 'Period - select dates');
  constants.Add('shTx_FormCustomInvoicesMD_WrongDate', 'Wrong date selection');

 (* constants.Add('shTx_G_NotArrived', 'Ókominn');
  constants.Add('shTx_G_CheckedIn', 'Innskráður');
  constants.Add('shTx_G_CheckedOut', 'Farinn');
  constants.Add('shTx_G_WaitingList', 'Biðlisti'); *)

  constants.Add('shTx_G_DueToArrive', 'Due to arrive');
  constants.Add('shTx_G_NotArrived', 'Not Arrived');
  constants.Add('shTx_G_CheckedIn', 'Checked In');
  constants.Add('shTx_G_CheckedOut', 'Checked Out');
  constants.Add('shTx_G_Alotment', 'Allotment');
  constants.Add('shTx_G_NoShow', 'No show');
  constants.Add('shTx_G_Blocked', 'Blocked');
  constants.Add('shTx_G_DepartingToday', 'Due to check out');
  constants.Add('shTx_G_Cancelled', 'Cancelled');
  constants.Add('shTx_G_WaitingList', 'Optional Booking');
  constants.Add('shTx_G_WaitingListNonOptional', 'Waiting list');

 // constants.Add('shTx_G_Downpayment', 'Downpayment/innágreiðsla');
  constants.Add('shTx_G_Downpayment', 'Downpayment');
  constants.Add('shTx_G_ConnectionFail', 'Connection failure!');
  constants.Add('shTx_G_ConnectionSuccess', 'Connection successful!');
  constants.Add('shTx_G_DeleteRooms', 'Delete selected rooms from reservation ?' + #10 +
                                          'Rooms : %s');
  constants.Add('shTx_G_Reservation', 'Reservation');
  constants.Add('shTx_G_Guest', 'Guest');
  constants.Add('shTx_G_Departed', 'Departed');
  constants.Add('shTx_G_Reserved', 'Reserved');
  constants.Add('shTx_G_Departing', 'Departing');
  constants.Add('shTx_G_Canceled', 'Canceled'); //*HJ 140206
  constants.Add('shTx_G_Tmp1', 'Tmp1'); //*HJ 140206
  constants.Add('shTx_G_AwaitingPayment', 'Awaiting Payment'); //*HJ 140206
  constants.Add('shTx_G_Deleted', 'Deleted'); //*HJ 140206
  constants.Add('shTx_G_AwaitingPayConfirm', 'Awaiting Payment Confirmation'); //*HJ 140206
  constants.Add('shTx_G_Mixed', 'Mixed'); //*HJ 140206

  constants.Add('shTx_GotoRoomAndDate_RoomNotFound', 'RoomReservation not Found');
  constants.Add('shTx_GotoRoomAndDate_ReservationNotFound', 'Reservation not Found');
  constants.Add('shTx_GotoRoomAndDate_CashNoRoom', 'Cash invoice - No Room');
  constants.Add('shTx_GotoRoomAndDate_InvoiceNotFound', 'Invoice not found');
end;

procedure AddConstants_2;
begin
  constants.Add('shTx_GuestProfile2_SplitRoom', 'split room to new reservation');
  constants.Add('shTx_GuestProfile2_UnableToSplitRoom', 'Problem: Unable to split room to new reservation ' + #13#13 +
                                'The following exception occurred:' + #13#13 +
                                '%s' + #13#13 +
                                'Please write this message down or' + #13 +
                                'call support with this dialog open!');
  constants.Add('shTx_GuestProfile2_NameChange', 'Reservation Name changed - sure ?');
  constants.Add('shTx_GuestProfile2_RoomsInReservation', '%d rooms in this reservation with total %d guests');
  constants.Add('shTx_GuestProfile2_RoomNoWithGuests', 'Room no. %s with %d guests');
  constants.Add('shTx_GuestProfile2_NotesForRoom', 'Notes for room no. %s');
  constants.Add('shTx_GuestProfile2_Person', 'Person');
 // constants.Add('shTx_GuestProfile2_NameRequired', 'Person name requierd - set value or use [ESC] to cancel ');
  constants.Add('shTx_GuestProfile2_NameRequired', 'Person name required - set value or use [ESC] to cancel ');
  constants.Add('shTx_GuestProfile2_EditInGrid', 'edit in grid');
  constants.Add('shTx_GuestProfile2_ReservationSame', 'Reservation target can not be same reservation');
  constants.Add('shTx_GuestProfile2_ReservationNotFound', 'Reservation target not found');
  constants.Add('shTx_GuestProfile2_MoveReservationNewResNewCust', 'Move this room to another reservation ' + #10 +
                                'New Reservation : %s' + #10 +
                                'New Customer : %s');
  constants.Add('shTx_GuestProfile2_ChangeRoom', 'Change room to another reservation');
  constants.Add('shTx_GuestProfile2_ProblemChange', 'Problem: Move room to another reservation' + #13#13 +
                                'The following exception occurred:' + #13#13 +
                                '%s' + #13#13 +
                                'Please write this message down or' + #13 +
                                'call support with this dialog open!');
  constants.Add('shTx_GuestProfile2_NoRooms', 'No Rooms is in reservation %d');
  constants.Add('shTx_HiddenInfo_CreateNew', 'Create New ?');
  constants.Add('shTx_HiddenInfo_SaveChanges', 'Save changes ?');
  constants.Add('shTx_HouseKeeping_Created', 'Create at : %s');
  constants.Add('shTx_HouseKeeping_User', 'User : %s');

  constants.Add('shTx_HouseKeeping_Code_O', 'Out of order');
  constants.Add('shTx_HouseKeeping_Code_M', 'Maintenance Needed');
  constants.Add('shTx_HouseKeeping_Code_S', 'Clean but needs maintenance');
  constants.Add('shTx_HouseKeeping_Code_F', 'Maintenance in progress');
  constants.Add('shTx_HouseKeeping_Code_W', 'Being Cleaned');
  constants.Add('shTx_HouseKeeping_Code_U', 'Not Clean');
  constants.Add('shTx_HouseKeeping_Code_R', 'Ready For Inspection');
  constants.Add('shTx_HouseKeeping_Code_C', 'Clean');
  constants.Add('shTx_HouseKeeping_Code_L', 'Wait For Checkout');
  constants.Add('shTx_HouseKeeping_Code_D', 'Do Not Disturb');
  constants.Add('shTx_HouseKeeping_Code_', 'Unknown status');

  constants.Add('shTx_HouseKeeping_NumberOfGuests', ' %d guests.');
  constants.Add('shTx_HouseKeeping_GuestWaitingForGuestToDepart', 'Wait for guest to depart.');
  constants.Add('shTx_HouseKeeping_GuestDepartedNewArrival', 'Guests departed, new arrival.');
  constants.Add('shTx_HouseKeeping_GuestDepartedNoNewArrival', 'Guests departed, No arrival.');
  constants.Add('shTx_HouseKeeping_GuestLeavesToday', 'Guests Leaves today, new arrival.');
  constants.Add('shTx_HouseKeeping_LeavesTomorrow', 'which leaves tomorrow. ');
  constants.Add('shTx_HouseKeeping_StayingForDays', 'staying for %d days.');
  constants.Add('shTx_HouseKeeping_ArrivesToday', 'Guest arrives today.');
  constants.Add('shTx_HouseKeeping_TodayNoArrival', 'Guest leaves today. No arrival. ');
  constants.Add('shTx_HouseKeeping_GuestTomorrow', 'Guest leaves tomorrow. ');
  constants.Add('shTx_HouseKeeping_CheckinNever', ' - Next Checkin unknown. ');
  constants.Add('shTx_HouseKeeping_NextTomorrow', ' - Next Tomorrow. ');
  constants.Add('shTx_HouseKeeping_CheckinAfterDays', ' - Next Checkin after %d days.');
  constants.Add('shTx_HouseKeeping_RoomUnoccupied', 'Room is and stays unoccupied.');
  constants.Add('shTx_HouseKeeping_OccupiedXDays', 'Occupied. Guest stays for %d more days.');
  constants.Add('shTx_HouseKeeping_Beds', 'Beds');
  constants.Add('shTx_HouseKeeping_CleaningSuspended', 'Suspend cleaning!');
  constants.Add('shTx_HouseKeeping_FullCleaning', 'Prepare for new guests');
  constants.Add('shTx_HouseKeeping_FullCleaningAdditionalBed', 'Prepare for new guests. Add extra bed.');
  constants.Add('shTx_HouseKeeping_DailyCleaning', '50% - Daily Cleaning.');
  constants.Add('shTx_HouseKeeping_DailyCleaningPlusBeds', '50% - Daily Cleaning + Beds.');
  constants.Add('shTx_HouseKeeping_SpecialRequirements', 'Special Requirements');
  constants.Add('shTx_HouseKeeping_RoomStatusDate', 'Room Status - Date : %s');

  constants.Add('shTx_Housekeepinglist_Departure', 'Departure');
  constants.Add('shTx_Housekeepinglist_Arriving', 'Arriving');
  constants.Add('shTx_Housekeepinglist_StayOver', 'Stayover');

  constants.Add('shTx_Invoice_SaveInvoice', 'Save invoice and room price changes?');
  constants.Add('shTx_Invoice_SaveChanges', 'Save invoice changes?');
  constants.Add('shTx_Invoice_NotANumber', '%s is not a number');
  constants.Add('shTx_Invoice_InvoiceNumber', 'Invoice number %s not found');
  constants.Add('shTx_Invoice_CreditInvoice', 'This is a credit invoice');
 // constants.Add('shTx_Invoice_Value_Unchangeable', 'Gildi [%s] eru meðhöndluð af kerfinu og því ekki hægt að breyta ');
  constants.Add('shTx_Invoice_Value_Unchangeable', 'Value [%s] is handled by the system and cannot be changed');
  constants.Add('shTx_Invoice_NotAllowed', 'You are not allowed to use the System''s Payment code directly');
  constants.Add('shTx_Invoice_UnableToSaveInvoiceMessage', 'Problem: Unable to save the invoice!' + #13#13 +
                                             'While saving invoice the following exception occurred:' + #13#13 +
                                             '%s' + #13#13 +
                                             'Please write this message down or' + #13 +
                                             'call support with this dialog open!');
  constants.Add('shTx_Invoice_UnableSavePaymentsMessage', 'Problem: Unable to save the Payments !' + #13#13 +
                                             'While saving payments the following exception occurred:' + #13#13 +
                                             '%s' + #13#13 +
                                             'Please write this message down or' + #13 +
                                             'call support with this dialog open!');
  constants.Add('shTx_Invoice_PaymentTotalInvoice', 'Payment needs to total to the same amount as the total invoice');
  constants.Add('shTx_Invoice_CreatingInvoice', 'Creating Invoice ');
  constants.Add('shTx_Invoice_OpenInvoiceAfterPrintCredit', 'Open a new invoice with the original amounts' + #10 +
                                             'when finished printing credit invoice ?');
  constants.Add('shTx_Invoice_GroupInvoice', 'This is a Group invoice');
  constants.Add('shTx_Invoice_RoomInvoice', 'Cannot move the item to the same room invoice.');
  constants.Add('shTx_Invoice_RoomrentToGroupAndSaveChanges', 'Move roomrent to Group invoice ' + #10 +
                                             'and save other changes ?');
  constants.Add('shTx_Invoice_RoomrentToRoomAndSaveChanges', 'Move roomrent to Room invoice ' + #10 +
                                             'and save other changes ?');
 // constants.Add('shTx_Invoice_ReferenceNumberNotFound', 'Tilvísunarnúmer %d fannst ekki ');
  constants.Add('shTx_Invoice_ReferenceNumberNotFound', 'Reference number %d not found ');
  constants.Add('shTx_Invoice_Nights', 'Nights.');
  constants.Add('shTx_Invoice_SaveChanges2', 'Save changes');
  constants.Add('shTx_Invoice_PPNotAllowed', 'Print and pay not allowed while performing price changes');
  constants.Add('shTx_Invoice_CurrencyDifferent', 'Customer''s currency is different from currency of this invoice.');
  constants.Add('shTx_Invoice_PrintAndPay', 'Print and pay not allowed when in price changes');
  constants.Add('shTx_Invoice_DeleteItem', 'Delete item ');
  constants.Add('shTx_Invoice_DeleteSelectedItems', 'Delete selected items ');
  constants.Add('shTx_Invoice_SetTemp', 'Set room to temp ');
  constants.Add('shTx_Invoice_SaleNotSelected', 'Sale item not selected !');
  constants.Add('shTx_Invoice_TakeItemFromInvoice', 'Take [%s] from invoice?');
  constants.Add('shTx_Invoice_CanNotDelete', 'System item can not delete ');
  constants.Add('shTx_InvoiceUnableToSave', 'We are unable to save the invoice. Select [Retry] to try again or [Cancel] '
            + #13 + 'to temporarily stop the work with this invoice');

  constants.Add('shTx_Invoice_BlankLine', 'Blank Line');
  constants.Add('shTx_Invoice_ErrorInTotal', 'Error in total %s');
  constants.Add('shTx_Invoice_MoveItemToGroupInvoice', 'Move item %s: %s' + #10 +
                                             'to group invoice? ');
  constants.Add('shTx_Invoice_MoveSelectedItemsToGroupInvoice', 'Move selected items to group invoice? ');
  constants.Add('shTx_Invoice_MoveItemToRoomInvoice', 'Move item %s: %s' + #10 +
                                             'to room %s? ');
  constants.Add('shTx_Invoice_FailedGroupInvoice', 'Moving to group invoice failed - Cancel ' + #10 +
                                             'Error : %s');
											 
  constants.Add('shTx_Invoice_EmptyInvoice', 'Empty invoiceline');
  constants.Add('shTx_Invoice_CompressionNotReversibleMessage',
                                             'Compressing the room rental lines is not reversible.' + #13#13 +
                                             'After compressing the lines, you will need to manage the prices' + #13 +
                                             'and all related issues manually without the system interfering.' + #13#13 +
                                             'Please confirm by clicking [Yes] or [Cancel] the process.');
											 
 (* constants.Add('shTx_InvoiceList2_BookingNumber', 'Númer bókunnar er tala');
  constants.Add('shTx_InvoiceList2_CashAccount', 'Þetta er staðgreiðslureikningur');
  constants.Add('shTx_InvoiceList2_GroupInvoice', 'Þetta er hópreikningur');
  constants.Add('shTx_InvoiceList2_NotRoomInvoice', 'Þessi reikninguer er ekki herbergjareikningur'); *)

  constants.Add('shTx_InvoiceList2_BookingNumber', 'Booking Number is a number');
  constants.Add('shTx_InvoiceList2_CashAccount', 'This is a cash invoice');
  constants.Add('shTx_InvoiceList2_GroupInvoice', 'This is a group invoice');
  constants.Add('shTx_InvoiceList2_NotRoomInvoice', 'This invoice is not the Room invoice');
  constants.Add('shTx_InvoiceList2_NoRoomFound', 'No room found');

  constants.Add('shTx_InvoicePayment_DownPayment', 'Down payment');
  constants.Add('shTx_InvoicePayment_InvoicePayment', 'Invoice Payment');
  constants.Add('shTx_InvoicePayment_ConfirmCode', 'Confirm code');
  constants.Add('shTx_InvoicePayment_Code', 'Code :');
  constants.Add('shTx_InvoicePayment_ExceedsInvoice', 'Payments exceed total invoice?!');
  constants.Add('shTx_Items2_ItemTypeRequired', 'Item type is required - set value or use [ESC] to cancel ');
//  constants.Add('shTx_Items2_ItemRequired', 'Item is requierd - set value or use [ESC] to cancel ');
  constants.Add('shTx_Items2_ItemRequired', 'Item is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_Items2_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_Items2_ItemCodeIsRequired', 'Item code - is required - Use ESC to cancel');
  constants.Add('shTx_Items2_Required', 'is required - Use ESC to cancel');
  constants.Add('shTx_Items2_EditInGrid', 'Edit in grid');
  constants.Add('shTx_Items2_Item', 'Item');
  constants.Add('shTx_ItemsTypes2_UpdateNotOk', 'UPDATE NOT OK');
 // constants.Add('shTx_ItemsTypes2_ItemTypeRequired', 'ItemType is requierd - set value or use [ESC] to cancel ');
 constants.Add('shTx_ItemsTypes2_ItemTypeRequired', 'ItemType is required - set value or use [ESC] to cancel ');
 // constants.Add('shTx_ItemsTypes2_VATCodeRequired', 'VAT code is requierd - set value or use [ESC] to cancel ');
 constants.Add('shTx_ItemsTypes2_VATCodeRequired', 'VAT code is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_ItemsTypes2_InsertNotOK', 'INSERT NOT OK');
  constants.Add('shTx_ItemsTypes2_Description', 'Description ');
  constants.Add('shTx_ItemsTypes2_Required', 'is required - Use ESC to cancel');
  constants.Add('shTx_ItemsTypes2_ItemCode', 'Item code ');
  constants.Add('shTx_ItemsTypes2_VATCode', 'VAT code ');
  constants.Add('shTx_ItemsTypes2_EditInGrid', 'Edit in grid');
 constants.Add('shTx_Locations2_LocationRequired', 'Location is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_Locations2_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_Locations2_EditInGrid', 'Edit in grid');


  constants.Add('shTx_MaidActions_RegisterNotFound', 'Registration outside of filer, not found');
  constants.Add('shTx_MaidActions_DeleteMaidAction', 'Delete Maid Action %s: %s' + #10 +
                                              'Are You Sure ?');
  constants.Add('shTx_MaidActionsEdit_CodeMaidAction', 'Maid Action Code mude be specified');
  constants.Add('shTx_MainActionsEdit_MaidActionAvailable', 'Maid Action Available - Try Again');
  constants.Add('shTx_MainActionsEdit_NameMaid', 'Maid Action Name must be specified.');
  
  constants.Add('shTx_Main_AutoLoggedOff', '  Automatically logged off due to inactivity.');
  constants.Add('shTx_Main_Downloading', 'Downloading...');
  constants.Add('shTx_Main_Ready', 'Ready.');
  constants.Add('shTx_Main_LoggedOut', '  User logged out.');
  constants.Add('shTx_Main_DepricatedFunction', 'Depricated function. Please open Room Profile to change settings.');
  constants.Add('shTx_Main_ForcedLogout', '  Server forced logout.');
  constants.Add('shTx_Main_LogginAgain', '  Please try logging in again in a few seconds...');
  constants.Add('shTx_Main_ReservationCancelled', 'Reservation Canceled');
  constants.Add('shTx_MakeBlockReservation_PriceFor', 'price for ');
  constants.Add('shTx_MakeBlockReservation_Currency', ' and Currency ');
  constants.Add('shTx_MakeBlockReservation_NotFound', ' not found !!');
  constants.Add('shTx_MakeBlockReservation_NotFound2', '** Not Found **');
  constants.Add('shTx_MakeReservationBH_PriceFor', 'Price for ');
end;

procedure AddConstants_3;
begin
  constants.Add('shTx_QuickReservation_NewReservationQuick', 'New Reservation - Quick Mode');
  constants.Add('shTx_QuickReservation_NewReservation', 'New Reservation');
  constants.Add('shTx_ManageFiles_Delete', 'Do you want to delete file "%s"?');
  constants.Add('shTx_ManageFiles_UnableToUpload', 'Unable to upload file "%s"');
  constants.Add('shTx_ManageFiles_RetrieveList', 'Please first retrieve the list of files to be worked with (ReadFileList)');
  constants.Add('shTx_NationalReport_Created', 'Created : ');
  constants.Add('shTx_NationalReport_User', 'User : ');
  constants.Add('shTx_NationalReport_ChangeNationalityFromTo', 'Change nationality of all guests ' + #10 +
                                      ' from %s to %s ' + #10 +
                                      'Confirm ?');
  constants.Add('shTx_NationalReport_NoChangeCountry', 'Not able to change country');
  constants.Add('shTx_OpenInvoiceNew_NotValidNumber', 'Not Valid Reservation Number');
  constants.Add('shTx_OpenInvoiceNew_Group', 'Group');
  constants.Add('shTx_OpenInvoiceNew_CashInvoice', 'This is a cash invoice');
  constants.Add('shTx_OpenInvoiceNew_CashInvoice2', 'This is cash invoice - not related to any reservation');
  constants.Add('shTx_OpenInvoiceNew_Guest', 'Guest');
  constants.Add('shTx_OpenInvoiceNew_NotArrived', 'Not Arrived');
  constants.Add('shTx_OpenInvoiceNew_Departed', 'Departed');
  constants.Add('shTx_OpenInvoiceNew_NoShow', 'No Show');
  constants.Add('shTx_OpenInvoiceNew_Allotment', 'Allotment');
  constants.Add('shTx_OpenInvoiceNew_WaitingList', 'Waitinglist');
  constants.Add('shTx_OpenInvoiceNew_Blocked', 'Blocked');
  constants.Add('shTx_OpenInvoiceNew_Unknown', 'Unknown');
  constants.Add('shTx_PackagedItems_UpdateNotOK', 'UPDATE NOT OK');
  constants.Add('shTx_PackagedItems_DescriptionRequired', 'Description is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_PackagedItems_ItemRequired', 'Item is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_PackagedItems_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_PackagedItems_ItemIsRequired', 'Item - is required - Use ESC to cancel');
  constants.Add('shTx_Packages_PackageRequired', 'Package is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_Packages_Package', 'Package');
  constants.Add('shTx_Packages_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_Packages_PackageCodeIsRequired', 'Package code - is required - Use ESC to cancel ');
  constants.Add('shTx_Packages_Exists', 'exists in Items table ');
  constants.Add('shTx_ReservationProfile_MustBeOver1Day', 'Number of days must be atleast 1 day - Check the dates ! ');
  constants.Add('shTx_ReservationProfile_CopyHidden', 'Copy to hidden :');
  constants.Add('shTx_ReservationProfile_ChangeNationalityConfirmation',
                                     //   'Breyta þjóðerni allra gesta pöntunnar ' + #10 +
									 'Change nationality of all guests ' + #10 +
                                     //   ' from %s to %s.' + #10#10 +
									 ' From %s to %s.' + #10#10 +
                                     //   'Ertu viss ?');
									  'Confirm ?');
//  constants.Add('shTx_ReservationProfile_NationalityChangeFailed', 'Ekki tókst að breyta landi');
  constants.Add('shTx_ReservationProfile_NationalityChangeFailed', 'Changing nationality failed');
  constants.Add('shTx_ReservationProfile_Outdated', 'OutDated');
  constants.Add('shTx_ReservationProfile_ChangeAllRooms', 'Change all rooms to ');
  constants.Add('shTx_ReservationProfile_BreakfastInc', 'Breakfast included ?');
  constants.Add('shTx_ReservationProfile_BreakfastNotInc', 'Breakfast NOT included ?');
  constants.Add('shTx_ReservationProfile_Included', 'Included');
  constants.Add('shTx_ReservationProfile_NotIncluded', 'Not included');
  constants.Add('shTx_ReservationProfile_GroupAccount', 'Group Account ?');
  constants.Add('shTx_ReservationProfile_RoomAccount', 'Room Account ?');
  constants.Add('shTx_ReservationProfile_NotArrived', 'Not arrived');
  constants.Add('shTx_ReservationProfile_CheckedIn', 'Checked in');
  constants.Add('shTx_ReservationProfile_Departed', 'Departed');
  constants.Add('shTx_ReservationProfile_WaitingList', 'Waitinglist');
  constants.Add('shTx_ReservationProfile_Allotment', 'Allotment');
  constants.Add('shTx_ReservationProfile_NoShow', 'No-show');
  constants.Add('shTx_ReservationProfile_Blocked', 'Blocked');
  constants.Add('shTx_ReservationProfile_canceled', 'Canceled');
  constants.Add('shTx_ReservationProfile_Tmp1', 'Other 1');
  constants.Add('shTx_ReservationProfile_Tmp2', 'Other 2');
  constants.Add('shTx_ReservationProfile_ChangeStatus', 'Change status on all room reservations in %s?' + #10);
  constants.Add('shTx_ReservationProfile_MoreThanOneRoomUseForm', 'More than one room in Reservation ' + #10 +
                                          'Use RoomReservation Form - for each room to change ');
  constants.Add('shTx_ReservationProfile_AddRoomError', 'Add Room error : %s');

  constants.Add('shTx_FrmReservationprofile_ReservationNumber', 'Reservation number');
  constants.Add('shTx_FrmReservationprofile_Status', 'State');
  constants.Add('shTx_FrmReservationprofile_ChangeStatus', 'Change State');
  constants.Add('shTx_FrmReservationprofile_Balance', 'Balance');
  constants.Add('shTx_FrmReservationprofile_CreatedBy', 'Created by');

  constants.Add('shTx_FrmReservationprofile_BlockMoveReasonCaption', 'Reason for blocking the move of room ');
  constants.Add('shTx_FrmReservationprofile_PerNight', 'per night');
  constants.Add('shTx_FrmReservationprofile_UpdateExclBreakfast', 'The number of guest and/or nights has changed. Update the number of breakfasts in the invoice?');
  constants.Add('shFailedUpdateBreakfastCount', 'Failed to update number of breakfasts. Please review the relevant invoicelines.');
  constants.Add('shTx_AccountType_GroupAccount', 'Group Account');
  constants.Add('shTx_AccountType_RoomAccount', 'Room Account');

  constants.Add('shTx_RoomPricesEdit_RoomType', 'Room Type must be specified');
  constants.Add('shTx_RoomPricesEdit_PriceTime', 'Price range must be specified');
  constants.Add('shTx_RoomPricesEdit_Invoice', 'Invoice must be specified');
  constants.Add('shTx_RoomPricesEdit_NamePrice', 'Price description is required');
  constants.Add('shTx_RoomPricesEdit_Prices', 'Prices are ready');
  constants.Add('shTx_RoomPricesEdit_Error', 'Error');
  constants.Add('shTx_RoomPricesEdit_PriceGroup', 'Price Group must be specified');

  constants.Add('shTx_RoomRates_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_RoomRates_EditInGrid', 'edit in grid');
  constants.Add('shTx_StaffMembers2_StaffMember', 'Staffmember');
//  constants.Add('shTx_StaffMembers2_InitialsRequired', 'Initials are requierd - set value or use [ESC] to cancel ');
  constants.Add('shTx_StaffMembers2_InitialsRequired', 'Initials are required - set value or use [ESC] to cancel ');
  constants.Add('shTx_StaffMembers2_InitialIsRequired', 'Initial - is required - Use ESC to cancel');
  constants.Add('shTx_StaffMembers2_NameIsRequired', 'Name - is required - Use ESC to cancel');
 // constants.Add('shTx_Room2_RoomRequired', 'Room is requierd - set value or use [ESC] to cancel ');
  constants.Add('shTx_Room2_RoomRequired', 'Room is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_Room2_UpdateNotOK', 'UPDATE NOT OK');
  constants.Add('shTx_Room2_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_Room2_EditInGrid', 'edit in grid');
  constants.Add('shTx_SystemActions_UpdateNotOK', 'UPDATE NOT OK');
  constants.Add('shTx_SystemActions_DescriptionRequired', 'Descriprion is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_SystemActions_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_SystemActions_EditInGrid', 'edit in grid');
  constants.Add('shTx_Rates_DescriptionRequired', 'Description is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_Rates_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_Rates_DefaultForCurrenyAlreadyExists', 'Default for %s already exists - Use [ESC] to abandon changes');
  constants.Add('shTx_Rates_CurrencyIsRequired', 'Currency - is required');
  constants.Add('shTx_Rates_DefaultExistsAbandonChanges', 'Default for %s already exists - abandoning changes');
  constants.Add('shTx_Rates_EditInGrid', 'edit in grid');
end;

procedure AddConstants_4;
begin
  constants.Add('shTx_RoomTypeGroups2_RoomclassRequired', 'Room class code is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_RoomTypeGroups2_RoomClassIsRequired', 'Room class - is required - Use ESC to cancel');
  constants.Add('shTx_RoomTypeGroups2_EditInGrid', 'edit in grid');
  constants.Add('shTx_PriceCodes_Pricecode', 'Pricecode');
  constants.Add('shTx_PriceCodes_PriceRequired', 'Pricecode required - set value or use [ESC] to cancel ');
  constants.Add('shTx_PriceCodes_CodeIsRequired', 'Code - is required - Use ESC to cancel');
  constants.Add('shTx_PriceCodes_RackRate', 'There can only be one rackrate - Use [ESC] to abandon changes');
  constants.Add('shTx_PriceCodes_EditInGrid', 'edit in grid');
  constants.Add('shTx_TelLog_OneDay', 'One Day - select date');
  constants.Add('shTx_TelLog_Period', 'Period - select dates');
  constants.Add('shTx_TelLog_ComingSoon', 'Coming Soon');
  constants.Add('shTx_TelLog_WrongDate', 'Wrong date selection');
  constants.Add('shTx_RoomProfile_Customer', 'Customer : %s');
  constants.Add('shTx_RoomProfile_NumberDoesntExist', 'This reservation number does not exists ');
  constants.Add('shTx_RoomProfile_RoomStatusChangedChangeAllReservation', 'Room status changed to %s.' + #13#13 +
                                        'Change the whole reservation?');
  constants.Add('shTx_RoomProfile_SameSettingsToAllReservation', 'Would you like to assign the same settings to all the rooms' + #10 +
                                        'in this reservation ?');
  constants.Add('shTx_ChangeRRdates_CheckDates', 'Check dates - 0 days ');
  constants.Add('shTx_ChangeRRdates_SomeErrors', ' Some errors ');
  constants.Add('shTx_ChangeRRdates_Total', ' total ');

  constants.Add('shTx_ChangeRRdates_ErrorSameDate', 'Error - checkin and checkout dates are the same');
  constants.Add('shTx_ChangeRRdates_CheckinAfterCheckout', 'Error checkin is after checkout');
  constants.Add('shTx_ChangeRRdates_BookingOverlap', 'WARNING : Bookings overlap ');
  constants.Add('shTx_ChangeRRdates_PaidInvoicesReviewAfterChange', 'This reservation has paid invoices.' + #10 +
                                        'After changing dates - review prices');

   constants.Add('shTx_ChangeRRdates_RoomDatesChangeAll', 'Not all room dates ' + #10 +
                                                'comply with date of booking' + #10 +
                                                '- Do you want to change them all ? ' + #10#10 +
                                                'If you choose no the dates will change only' + #10 +
                                                'for rooms that have a date booked');
  constants.Add('shTx_ChangeRRdates_MustBe1Day', 'Number of dates must be atleast one day! - Check the Dates ! ');
  constants.Add('shTx_StatisticsForecast_DataPreperation', 'Data preparation started');
  constants.Add('shTx_StatisticsForecast_RoomResRetrieved', 'RoomReservation retrieved');
  constants.Add('shTx_StatisticsForecast_RoomResUpdated', 'RoomReservation ResultData updated');
  constants.Add('shTx_StatisticsForecast_GetUnBilled', 'Get unbilled goods ');
  constants.Add('shTx_StatisticsForecast_UnbilledRerieved', 'Unbilled goods retrieved');
 // constants.Add('shTx_ResGuestList_FileNotFound', 'Skráin %s fannst ekki ');
  constants.Add('shTx_ResGuestList_FileNotFound', 'File %s not found ');
//  constants.Add('shTx_RptCustomer_FileNotFound', 'Skráin %s fannst ekki!');
  constants.Add('shTx_RptCustomer_FileNotFound', 'File %s not found!');
  constants.Add('shTx_RoomTypes_RoomTypeIsRequired', 'RoomType - is required - Use ESC to cancel');
  constants.Add('shTx_RoomTypes_RoomTypeRequired', 'RoomType is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_RoomTypes_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_RoomTypes_ComingSoon', 'Coming Soon');
  constants.Add('shTx_RoomTypes_EditInGrid', 'edit in grid');
  constants.Add('shTx_SystemServers_UpdateOK', 'UPDATE OK');
  constants.Add('shTx_SystemServers_DescriptionRequired', 'Descriprion is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_SystemServers_InsertNotOK', 'INSERT NOT OK');
  constants.Add('shTx_SystemServers_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_SystemServers_EditInGrid', 'edit in grid');
  constants.Add('shTx_SystemTriggers_UpdateNotOK', 'UPDATE NOT OK');
  constants.Add('shTx_SystemTriggers_DescriptionRequired', 'Descriprion is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_SystemTriggers_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_SystemTriggers_InsertNotOK', 'INSERT NOT OK');
  constants.Add('shTx_SystemTriggers_EditInGrid', 'edit in grid');
  constants.Add('shTx_PayTypes_PayTypeCodeIsRequired', 'payType code - is required - Use ESC to cancel');
  constants.Add('shTx_PayTypes_PayTypeRequired', 'Paytype Code required - set value or use [ESC] to cancel ');
  constants.Add('shTx_PayTypes_PayGroupRequired', 'Paygroup Code required - set value or use [ESC] to cancel ');
  constants.Add('shTx_PhoneRates_PhoneRateRequired', 'Phone rate Identification required - set value or use [ESC] to cancel ');
  constants.Add('shTx_PayTypes_EditInGrid', 'edit in grid');

  constants.Add('shTx_CountryGroups_CountryGroupsCodeIsRequired', 'CountryGroups code - is required - Use ESC to cancel');
  constants.Add('shTx_CountryGroups_CountryGroupsRequired', 'CountryGroups Code required - set value or use [ESC] to cancel ');


  constants.Add('shTx_ProvideARoom_RoomCheckedin', 'Room Status is: Guest Checked in.' + #13#13 + 'Do you want to move guest?');
  constants.Add('shTx_ProvideARoom_RoomCheckedout', 'Room Status is: Guest has Checked out.' + #13#13 + 'Do you want to move guest?');
  constants.Add('shTx_ProvideARoom_Hairdryer', 'hairdryer ');
  constants.Add('shTx_ProvideARoom_Iron', 'iron ');
  constants.Add('shTx_ProvideARoom_CoffeeMachines', 'coffee Machines ');
  constants.Add('shTx_ProvideARoom_CoffeeMachine', 'coffee Machine ');
  constants.Add('shTx_ProvideARoom_Fridges', 'fridges ');
  constants.Add('shTx_ProvideARoom_Fridge', 'fridge ');
  constants.Add('shTx_ProvideARoom_Minibars', 'minibars ');
  constants.Add('shTx_ProvideARoom_Minibar', 'minibar ');
  constants.Add('shTx_ProvideARoom_Kitchens', 'kitchens ');
  constants.Add('shTx_ProvideARoom_Kitchen', 'kitchen ');
  constants.Add('shTx_ProvideARoom_InternetPlugs', 'internet plugs ');
  constants.Add('shTx_ProvideARoom_InternetPlug', 'internet p ');
  constants.Add('shTx_ProvideARoom_Faxs', 'faxs ');
  constants.Add('shTx_ProvideARoom_Fax', 'fax ');
  constants.Add('shTx_ProvideARoom_Phone', 'phone ');
  constants.Add('shTx_ProvideARoom_CDPlayer', 'CD Player ');
  constants.Add('shTx_ProvideARoom_Radios', 'radios ');
  constants.Add('shTx_ProvideARoom_Radio', 'radio ');
  constants.Add('shTx_ProvideARoom_VCRs', 'VCRs ');
  constants.Add('shTx_ProvideARoom_VCR', 'VCR ');
  constants.Add('shTx_ProvideARoom_TVs', 'TVs ');
  constants.Add('shTx_ProvideARoom_TV', 'TV ');
  constants.Add('shTx_ProvideARoom_Safe', 'safe ');
  constants.Add('shTx_ProvideARoom_Shower', 'shower ');
  constants.Add('shTx_ProvideARoom_Baths', 'baths ');
  constants.Add('shTx_ProvideARoom_Bath', 'bath ');
  constants.Add('shTx_ProvideARoom_RoomWithout', 'Room without');
  constants.Add('shTx_ProvideARoom_RoomWith', 'Room with');
  
  constants.Add('shTx_StaffTypes2_UpdateNotOK', 'UPDATE NOT OK');
  constants.Add('shTx_StaffTypes2_InsertNotOK', 'INSERT NOT OK');
  constants.Add('shTx_StaffTypes2_StaffTypeRequired', 'StaffType is requierd - set value or use [ESC] to cancel ');
  constants.Add('shTx_StaffTypes2_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_StaffTypes2_TypeIsRequired', 'Type - is required - Use ESC to cancel');
  constants.Add('shTx_VATCodes_VATCode', 'VatCode');
  constants.Add('shTx_VATCodes_UpdateNotOK', 'UPDATE NOT OK');
  constants.Add('shTx_VATCodes_InsertNotOK', 'INSERT NOT OK');
  constants.Add('shTx_VATCodes_VATCodeRequired', 'VatCode Code required - set value or use [ESC] to cancel ');
  constants.Add('shTx_VATCodes_VATCodeCodeIsRequired', 'VatCode code is required - Use ESC to cancel');
  // constants.Add('shTx_Seasons2_DescriptionRequired', 'Descriprion is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_Seasons2_DescriptionRequired', 'Description is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_Seasons2_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
  constants.Add('shTx_Seasons2_EditInGrid', 'edit in grid');
  constants.Add('shTx_PayGroups_PayGroup', 'Paygroup');
  constants.Add('shTx_PayGroups_PayGroupRequired', 'PayGroup required - set value or use [ESC] to cancel ');
  constants.Add('shTx_PayGroups_PayGroupCodeIsRequired', 'payGroup code - is required - Use ESC to cancel');
  constants.Add('shTx_PhoneRates_PhoneRateCodeIsRequired', 'Phone rates Identification - is required - Use ESC to cancel');
  constants.Add('shTx_PayGroups_EditInGrid', 'edit in grid');
  constants.Add('shTx_RateRules_DescriptionRequired', 'Descriprion is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_RateRules_InsertNotOK', 'INSERT NOT OK');
  constants.Add('shTx_RateRules_DescriptionIsRequired', 'Description - is required - Use ESC to cancel');
 // constants.Add('shTx_Rooms_FilterActive', ' Sía virk!!! ');
	constants.Add('shTx_Rooms_FilterActive', ' Filer Active!!! ');
 // constants.Add('shTx_Rooms_Transactions', ' færslur af ');
    constants.Add('shTx_Rooms_Transactions', ' Transactions ');
 // constants.Add('shTx_Rooms_Visible', ' eru sýnilegar ');
    constants.Add('shTx_Rooms_Visible', ' Visible ');
  constants.Add('shTx_Rooms_DeleteRoom', 'Delete room "');
  constants.Add('shTx_Rooms_Confirm', 'Confirm ?');
end;

procedure AddConstants_5;
begin
  constants.Add('shTx_RoomTypesEdit_NotFound', ' Not Found !!');
(*  constants.Add('shTx_RoomTypesEdit_RoomType', 'Herbergistegund ');
  constants.Add('shTx_RoomTypesEdit_Available', ' er til');
  constants.Add('shTx_RoomTypesEdit_Not2RoomTypes', 'Ekki er leyfilegt að hafa tvö herbergistegundir');
  constants.Add('shTx_RoomTypesEdit_Same', 'með sama heiti');
  constants.Add('shTx_RoomTypesEdit_DefineRoomType', 'Það verður að skilgreina herbergjaflokk');
  constants.Add('shTx_RoomTypesEdit_DefineDescription', 'Það verður að skilgreina lýsingu herbergjaflokk');
  constants.Add('shTx_RoomTypesEdit_DefinePrice', 'Það verður að skilgreina verðflokk herbergjaflokks');
  constants.Add('shTx_RoomTypesEdit_DefineType', 'Það verður að skilgreina tegund herbergjaflokks');
  constants.Add('shTx_RoomEdit_Room', 'herbergi ');
  constants.Add('shTx_RoomEdit_Available', ' er til');
  constants.Add('shTx_RoomEdit_No2Rooms', 'Ekki er leyfilegt að hafa tvö herbergi');
  constants.Add('shTx_RoomEdit_SameNumber', 'með sama númeri');
  constants.Add('shTx_RoomEdit_DefineRoomType', 'Það verður að skilgreina herbergjaflokk');
  constants.Add('shTx_RoomEdit_DefineLocation', 'Það verður að skilgreina staðsetningu');
  constants.Add('shTx_RoomEdit_Describe', 'Það verður að skrá lýsingu');
  constants.Add('shTx_RoomEdit_NotFound', ' Finnst ekki !!');
  constants.Add('shTx_RoomDateProblem_NotArrived', 'Ekki kominn');
  constants.Add('shTx_RoomDateProblem_Guest', 'Gestur');
  constants.Add('shTx_RoomDateProblem_Gone', 'Farinn');
  constants.Add('shTx_RoomDateProblem_OverBooked', 'Yfirbókunn'); *)
  
  constants.Add('shTx_RoomTypesEdit_RoomType', 'Room Type ');
  constants.Add('shTx_RoomTypesEdit_Available', ' Available');
  constants.Add('shTx_RoomTypesEdit_Not2RoomTypes', 'Cannot have two room types');
  constants.Add('shTx_RoomTypesEdit_Same', 'with the same name');
  constants.Add('shTx_RoomTypesEdit_DefineRoomType', 'Room type needs to be specified');
  constants.Add('shTx_RoomTypesEdit_DefineDescription', 'Room types description must be specified');
  constants.Add('shTx_RoomTypesEdit_DefinePrice', 'Room types price must be specified');
  constants.Add('shTx_RoomTypesEdit_DefineType', 'Room Types class must be specified');
  constants.Add('shTx_RoomEdit_Room', 'Room ');
  constants.Add('shTx_RoomEdit_Available', ' Available');
  constants.Add('shTx_RoomEdit_No2Rooms', 'Cannot have two rooms');
  constants.Add('shTx_RoomEdit_SameNumber', 'with the same number');
  constants.Add('shTx_RoomEdit_DefineRoomType', 'Room type needs to be specified');
  constants.Add('shTx_RoomEdit_DefineLocation', 'Location needs to be specified');
  constants.Add('shTx_RoomEdit_Describe', 'Description needed');
  constants.Add('shTx_RoomEdit_NotFound', ' Not Found !!');
  constants.Add('shTx_RoomDateProblem_NotArrived', 'Not Arrived');
  constants.Add('shTx_RoomDateProblem_Guest', 'Guest');
  constants.Add('shTx_RoomDateProblem_Gone', 'Gone');
  constants.Add('shTx_RoomDateProblem_OverBooked', 'Over booked');
  
  constants.Add('shTx_RoomDateProblem_NoShow', 'No Show');
  constants.Add('shTx_RoomDateProblem_Allotment', 'Allotment');
  constants.Add('shTx_StaffEdit2_InitialsRequired', 'Initials are required');
  constants.Add('shTx_StaffEdit2_InitialExists', 'This already initial exists ');
  constants.Add('shTx_StaffEdit2_NameRequired', 'Name is required');
  constants.Add('shTx_StaffEdit2_RightsRequired', 'Set access rights of this staffmember');
  constants.Add('shTx_StaffEdit2_LanguageRequired', 'Language is required');

 (* constants.Add('shTx_ResProblem_NotArrived', 'Ekki kominn');
  constants.Add('shTx_ResProblem_Guest', 'Gestur');
  constants.Add('shTx_ResProblem_Gone', 'Farinn');
  constants.Add('shTx_ResProblem_OverBooked', 'Yfirbókunn'); *)
  
  constants.Add('shTx_ResProblem_NotArrived', 'Not Arrived');
  constants.Add('shTx_ResProblem_Guest', 'Guest');
  constants.Add('shTx_ResProblem_Gone', 'Gone');
  constants.Add('shTx_ResProblem_OverBooked', 'Optional booking');
  constants.Add('shTx_ResProblem_WaitingListNonOptional', 'Waiting list');

  constants.Add('shTx_ResProblem_NoShow', 'No Show');
  constants.Add('shTx_ResProblem_Allotment', 'Allotment');
  constants.Add('shTx_ResProblem_Blocked', 'Blocked');
  constants.Add('shTx_uResMemos_MoveToHidden', 'Move to hidden :');
  constants.Add('shTx_uResMemos_CopyToHidden', 'Copy to hidden :');
 // constants.Add('shTx_TelPriceGroups_FilterActive', 'Sía virk!!! ');
  constants.Add('shTx_TelPriceGroups_FilterActive', 'Filter Active!!! ');
  constants.Add('shTx_TelPriceGroups_PhonePrice', 'Phonecall prices');
 // constants.Add('shTx_TelPriceGroups_RegistrationFilter', 'Nýskráning er utan síu og sést því ekki');
  constants.Add('shTx_TelPriceGroups_RegistrationFilter', 'Registration filtered and cannot be seen');
  constants.Add('shTx_TelPriceGroups_DeletePricecode', 'Delete pricecode %s ?');
  constants.Add('shTx_TelPriceRules_FilterActive', 'Filter Active!!! ');
  constants.Add('shTx_TelPriceRules_PhonePrice', 'Phonecall prices');
  constants.Add('shTx_TelPriceRules_RegistrationFilter', 'Registration filtered and cannot be seen');
  constants.Add('shTx_TelPriceRules_DeletePricecode', 'Delete pricecode ?');
  constants.Add('shTx_UDL_SelectServer', 'Select Server');
  constants.Add('shTx_UDL_ServerAndDataBase', 'Select at least a Server and a Database!');
  constants.Add('shTx_UDL_ConnectionSuccess', 'Connection successful!');


  constants.Add('shTx_RoomTypesGroups_FilterActive', 'Filter Active!!! ');
  constants.Add('shTx_RoomTypesGroups_Transactions', ' Transactions ');
  constants.Add('shTx_RoomTypesGroups_Visible', ' Visible ');
  constants.Add('shTx_RoomTypesGroups_RoomtypeGroups', 'Roomtype groups');
  constants.Add('shTx_RoomTypesGroups_DeleteRoomtype', 'Delete Room Type ');
  constants.Add('shTx_RoomTypesGroups_AreYouSure', 'Are You sure ??');
  constants.Add('shTx_RoomTypes_FilterActive', ' Filter Active!!! ');
  constants.Add('shTx_RoomTypes_Transactions', ' Transactions ');
  constants.Add('shTx_RoomTypes_Roomtypes', 'Room types');
  constants.Add('shTx_RoomTypes_DeleteRoomtype', 'Delete Room Type ');
  constants.Add('shTx_RoomTypes_AreYouSure', 'Are You sure ??');
  constants.Add('shTx_seasons_FilterActive', ' Filter Active!!! ');
  constants.Add('shTx_seasons_Transactions', ' Transactions ');
  constants.Add('shTx_seasons_Visible', ' Visible ');
  constants.Add('shTx_seasons_PriceRange', 'Price Range');

  constants.Add('shTx_TelPriceRulesEdit_Passed', 'Passed ');
  constants.Add('shTx_TelPriceRulesEdit_NotValid', 'Not Valid');
  constants.Add('shTx_TelPriceRulesEdit_CodeRequired', 'Code is required field');
  constants.Add('shTx_TelPriceRulesEdit_PriceCodeExists', 'Price code exists - try again');
  constants.Add('shTx_TelPriceRulesEdit_DescriptionRequired', 'Description is required field');
  constants.Add('shTx_TelPriceRulesEdit_NotFound', ' Not found !');
  constants.Add('shTx_AboutRoomer_CopyPMSVersion', 'Roomer PMS Version number has been copied to the clipboard');
  constants.Add('shTx_AboutRoomer_NewVersionAvailable', 'There is a new version of ROOMER available (%s).' + #13 +
                                    'ROOMER needs to be updated.' + #13#13 +
                                    'Click [OK] to perform the update now.' + #13 +
                                    'Click [Later] to do this later');
  constants.Add('shTx_AboutRoomer_NewVersionAvailableExpired', 'There is a new version of ROOMER available (%s).' + #13 +
                                    'You have already ignored the update %d times, but ROOMER needs to be immediately updated.' + #13#13 +
                                    'Click [OK] to start the update.');
  constants.Add('shTx_AboutRoomer_NewVersionAvailableExpireWarning', 'There is a new version of ROOMER available (%s).' + #13 +
                                    'You have already ignored the update %d times! You will only get %d more possibilities to ignore.' + #13 +
                                    'After that ROOMER will stop working on the old version.' + #13#13 +
                                    'Click [OK] to start the update.' + #13 +
                                    'Click [Later] to update later');
  constants.Add('shTx_AboutRoomer_NewVersionAvailableUpdateLater', 'Update Later');
  constants.Add('shTx_AboutRoomer_NewVersionAvailableUpdateNow', 'Update Now');

  constants.Add('shTx_Utils_EnterLogin', 'Please enter a login.');
  constants.Add('shTx_Utils_MustEnterPassword', 'Password can''t be empty.You must enter a password.');
  constants.Add('shTx_Utils_CannotClipboard', 'Cannot set clipboard');


  constants.Add('shTx_PayTypesEdit_PayTypeAvailable', 'Pay Type Available - Try Again');
  constants.Add('shTx_PayTypesEdit_DefinePayType', 'Pay Type needs to be specified');
  constants.Add('shTx_PayTypesEdit_DefinePayGroup', 'Pay Type Payment catagory needs to be specified');
  constants.Add('shTx_PayTypesEdit_NotFound', ' Not Found !!');
  constants.Add('shTx_RoomTypesGroupsEdit_RoomType', 'Room Type ');
  constants.Add('shTx_RoomTypesGroupsEdit_Available', ' Availble');
  constants.Add('shTx_RoomTypesGroupsEdit_Not2RoomTypes', 'Cannot have two room types');
  constants.Add('shTx_RoomTypesGroupsEdit_Same', 'with the same name');
  constants.Add('shTx_RoomTypesGroupsEdit_DefineRoomTypeGroup', 'Room catagory must be specified');
  constants.Add('shTx_RoomTypesGroupsEdit_DefineDescription', 'Room catagory Description must be specified');
  constants.Add('shTx_PricesEdit_DateAvailable', 'Date is Available - Try Again');
  constants.Add('shTx_PricesEdit_SpecifyDay', 'Day needs to be specified');
  constants.Add('shTx_SeasonsEdit_DatesAvailable', 'Period with these dates is available - Try Again');
  constants.Add('shTx_SeasonsEdit_SpecifySeason', 'Time Period needs to be specified');

  constants.Add('shTx_TelPriceGroupsEdit_CodeRequired', 'Code is required field');
  constants.Add('shTx_TelPriceGroupsEdit_PriceCodeExists', 'Price code exists - try again');
  constants.Add('shTx_TelPriceGroupsEdit_DescriptionRequired', 'Description is required field');
  constants.Add('shTx_RoomsNotFound_ComingSoon', 'Coming Soon');
end;

procedure AddConstants_CLang; // Baettu vid thennan ad vild
begin
  constants.Add('dayStr1', 'Sunday;Monday;Tuesday;Wednesday;Thursday;Friday;Saturday');
end;

procedure AddConstants_SystemConstants;
var i : Integer;
begin
  for i := 1 to 12 do
  begin
    constants.Add('shSystem_Months_Short_' + inttostr(i), FormatSettings.ShortMonthNames[i]);
    constants.Add('shSystem_Months_Long_' + inttostr(i), FormatSettings.LongMonthNames[i]);
  end;

  for i := 1 to 7 do
  begin
    constants.Add('shSystem_Days_Short_' + inttostr(i), FormatSettings.ShortDayNames[i]);
    constants.Add('shSystem_Days_Long_' + inttostr(i), FormatSettings.LongDayNames[i]);
  end;

  constants.Add('shSystem_Date_Format_Long', FormatSettings.LongDateFormat);
  constants.Add('shSystem_Date_Format_Short', FormatSettings.ShortDateFormat);

  constants.Add('shSystem_Date_Separator', FormatSettings.DateSeparator);
  constants.Add('shSystem_Time_Separator', FormatSettings.TimeSeparator);
end;

procedure AddConstants_NewUIConstants;
begin
  constants.Add('shUI_Check_In', 'Check in');
  constants.Add('shUI_Check_Out', 'Check out');
  constants.Add('shUI_Open_Invoice', 'Open invoice');
  constants.Add('shUI_Reservation_Details', 'Reservation details');
  constants.Add('shUI_Rate_Plan', 'Rate plan');
  constants.Add('shUI_Notes', 'Notes');

  constants.Add('shUI_Occupancy', 'Occupancy');
  constants.Add('shUI_Availability', 'Availability');
  constants.Add('shUI_RevPar', 'RevPar');
  constants.Add('shUI_RoomRevenue', 'Room Revenue');
  constants.Add('shUI_RoomsSold', 'Rooms sold');
  constants.Add('shUI_BestAverageRate', 'BAR');
  constants.Add('shUI_OOO', 'Out-of-order');
  constants.Add('shUI_AverageDailyRate', 'ADR');

  constants.Add('shUI_RoomRentInvoice', 'Room-rent Invoice : ');
  constants.Add('shUI_RoomInvoices', 'Room Invoice : ');

  constants.Add('shUI_CreditCardGuarantee', 'CREDIT-CARD GUARANTEE');
  constants.Add('shUI_NoGuarantee', 'NO PAYMENT GUARANTEE');
  constants.Add('shUI_DownpaymentGuarantee', 'USE DOWN-PAYMENTS');

  constants.Add('shUI_NotAvailable', 'N/A');
  constants.Add('shUI_OnGroupInvoice', '[Group Invoice]');

  constants.Add('shUI_InvoiceCaption', 'INVOICE');
  constants.Add('shUI_CreditInvoiceCaption', 'CREDIT INVOICE');

  constants.Add('shUI_ValueCopiedToClipboard', 'Value has been copied to clipboard.');
  constants.Add('shUI_CheckInDialog', 'Show details dialog during check-in.');
  constants.Add('shTx_CheckIn_PaymentGuarantee_Downpayment', 'Down payment as guarantee.');

  constants.Add('shTx_ClearWindowsCacheAndClose', 'This will clear the statuses of the Roomer windows.'#10'After the clearing of the cache then Roomer will shut down.'#10'Afterwards, please start Roomer again.');

  constants.Add('shUI_AmountOverAllowedWithdrawalLimit', 'Unable to add item to Invoice'#13'Total invoice exceeds the maximum withdrawal limit of this room');

  constants.Add('shUI_GuestCouldNotBeFound', 'The guest could not be found.');

  constants.Add('shUI_GuestDetailsDialog', 'Guest details');

  constants.Add('shUI_NameCannotBeEmpty', 'Name cannot be empty');
  constants.Add('shUI_NewReservationConfirmationEmail', 'New reservation confirmation');
  constants.Add('shUI_CancelReservationConfirmationEmail', 'Cancelled reservation confirmation');

  constants.Add('shTemplate_Room', 'Room');
  constants.Add('shTemplate_Guests', 'Guests');
  constants.Add('shTemplate_Price', 'Price');
  constants.Add('shTemplate_Total', 'Total');
  constants.Add('shTemplate_CCPayment', 'Payment');
  constants.Add('shTemplate_Assurance', 'Payment');
  constants.Add('shTemplate_PaymentFail', 'Failed');
  constants.Add('shTemplate_PaymentSuccess', 'Successful');
  constants.Add('shTemplate_TechnicalFailure', 'Technical failure');

  constants.Add('shUI_Filename', 'Filename');
  constants.Add('shUI_Subject', 'Subject');
  constants.Add('shUI_User', 'User');
  constants.Add('shUI_DateTime', 'Date/Time');
  constants.Add('shUI_RenameFile', 'Rename');

  constants.Add('shUI_BookKeepReortCustomerID', 'Customer Id');
  constants.Add('shUI_BookKeepReortCustomerName', 'Customer Name');
  constants.Add('shUI_BookKeepReortInvoice', 'Invoice');
  constants.Add('shUI_BookKeepReortDate', 'Date');
  constants.Add('shUI_BookKeepReortAccount', 'Account');
  constants.Add('shUI_BookKeepReortDescription', 'Description');
  constants.Add('shUI_BookKeepReortDebet', 'Debet');
  constants.Add('shUI_BookKeepReortCredit', 'Credit');
  constants.Add('shUI_BookKeepReortTotal', 'TOTAL:');
  constants.Add('shUI_BookKeepReortSubtotal', 'Subtotal:');

  constants.Add('shUI_Reports_DOWNPAYMENT', 'Down payment');
  constants.Add('shUI_Reports_ÖÖSALE', 'Invoices');
  constants.Add('shUI_Reports_PAYMENT', 'Payment');
  constants.Add('shUI_Reports_ÖÖSALEITEMS', 'Item sales');

  constants.Add('shUI_Reports_Action', 'Action');
  constants.Add('shUI_Reports_Staff', 'Staff');
  constants.Add('shUI_Reports_Invoice', 'Invoice');
  constants.Add('shUI_Reports_Date', 'Date & time');
  constants.Add('shUI_Reports_Room', 'Room');
  constants.Add('shUI_Reports_BookingId', 'Booking Id');
  constants.Add('shUI_Reports_ResId', 'Res Id');
  constants.Add('shUI_Reports_Name', 'Name');
  constants.Add('shUI_Reports_CustomerName', 'Customer');
  constants.Add('shUI_Reports_GuestName', 'Guest');
  constants.Add('shUI_Reports_Description', 'Description');
  constants.Add('shUI_Reports_Total', 'Total');
  constants.Add('shUI_Reports_PaymentType', 'Payment type');
  constants.Add('shUI_Reports_MultipleRooms', '[Multiple rooms]');
  constants.Add('shUI_Reports_CashInvoice', '[Cash Invoice]');
  constants.Add('shUI_Reports_ALL', 'All');
  constants.Add('shUI_Reports_CashierReportFor', 'Cashier Report for');
  constants.Add('shUI_Reports_Balance', 'Balance');
  constants.Add('shUI_Reports_SelectAtLeastOneUser', 'Please select at least 1 user.');
  constants.Add('shUI_Reports_InvoicePayments', 'Invoice payments');
  constants.Add('shUI_Reports_DownPayments', 'Down payments');

  constants.Add('shUI_Reports_CashReport', 'Cash report');

  constants.Add('shUI_Reports_InvoiceTypeCash', 'Cash');
  constants.Add('shUI_Reports_InvoiceTypeGroup', 'Group');
  constants.Add('shUI_Reports_InvoiceTypeRoom', 'Room');

  constants.Add('shUI_Reports_CashierLineTypeSale', 'Closed invoices :');
  constants.Add('shUI_Reports_CashierLineTypeSaleItems', 'Items sale :');
  constants.Add('shUI_Reports_CashierLineTypeInvPayments', 'Invoice Payments :');
  constants.Add('shUI_Reports_CashierLineTypeDownPayments', 'Down Payments :');

  constants.Add('shUI_Reports_NoCashierReportsForThatDay', 'No cashier functions to report for this date.');

  constants.Add('shUI_ChannelManager_AvailPublishWarning', 'Roomer will instantly publish these availability changes and send them to the channels in question.');
  constants.Add('shUI_ChannelManager_RatesPublishWarning', 'Roomer will instantly publish these rate and/or restriction changes and send them to the channels in question.');
  constants.Add('shUI_ChannelManager_OkOrCancel', 'Click [Ok] to continue, otherwise [Cancel]');

  constants.Add('shUI_General_SELECT', 'Select');

  constants.Add('shUI_Reports_UsersInReport', 'Users in report: ');
  constants.Add('shUI_Reports_UserInReport', 'User in report: ');
  constants.Add('shUI_Reports_ShiftInReport', 'Shift: ');

  constants.Add('shUI_Checkout_GroupHeader', 'GROUP-INVOICE BALANCE (%d rooms)');
  constants.Add('shUI_Checkout_RoomHeader', 'ROOM-INVOICE BALANCE (room %s)');
end;

procedure AddConstants_6; // Baettu vid thennan ad vild
begin
  constants.Add('shTx_RptResStat_NameForDatalayoutMissing', 'The layout name is required to continue');
  constants.Add('shTx_GotoRoomAndDate_RefNotFound', 'Booking reference not found');
  constants.Add('shDeleteChannelPlanCode', 'Delete channel plan code');
  constants.Add('shTx_ChannelPlanCodes_UpdateNotOK', 'UPDATE NOT OK');
  constants.Add('shTx_ChannelPlanCodes_InsertNotOK', 'INSERT NOT OK');
  constants.Add('shTx_ChannelPlanCodes_CodeRequired', 'Code is required - set value or use [ESC] to cancel ');
  constants.Add('shTx_ChannelPlanCodes_CodeIsRequired', 'Code is required - Use ESC to cancel');

  constants.Add('shTx_ChannelAvailabilityManager_NoRoomTypeGroupsDefined', 'No Room Classes defined');
  constants.Add('shTx_ChannelAvailabilityManager_NoChannelManagersDefined', 'No Channel managers defined');
  constants.Add('shTx_ChannelAvailabilityManager_NoPlanCodesDefined', 'No Plan Codes defined');

  constants.Add('shTx_ResEngine_Organization', 'Organization');

  constants.Add('shTx_ChannelAvailabilityManager_ForceUpdateRates1', 'This will overwrite rates for all room classes for all dates!');
  constants.Add('shTx_ChannelAvailabilityManager_ForceUpdateAvailability1', 'This will overwrite availability for all room classes for all dates!');
  constants.Add('shTx_ChannelAvailabilityManager_ForceUpdate2', 'Normally it is enough to simply `Publish` the changes you make in this window.');
  constants.Add('shTx_ChannelAvailabilityManager_ForceUpdate3', 'Are you sure you want to continue?');

  constants.Add('shTx_FrmMain_OutOfOrder', 'OUT OF ORDER');

  constants.Add('shTx_FrmMakeReservationQuick_OutOfOrderDescription', 'Description :');
  constants.Add('shTx_FrmMakeReservationQuick_OutOfOrderStartDate', 'Start date :');
  constants.Add('shTx_FrmMakeReservationQuick_OutOfOrderEndDate', 'End date :');

  constants.Add('MainGuestConstant_Version_1', 'Main guest');
  constants.Add('MainGuestConstant_Version_2', 'Guest name');
  constants.Add('Dialog_Do_Not_Show_Again', 'Do not show this again');

  constants.Add('shTx_FrmMain_ChannelAvailabilityClassesHintHeader', '<b><font color="#0000ff">AVAILABILITY</font></b><hr>');
  constants.Add('shTx_FrmMain_StopSale', 'Stop');
  constants.Add('shTx_FrmMain_StopSaleActiveOnOneOrMoreChannels', '<br><b><font color="#ff0000">STOP SALE</font></b> active on one or more channels.<br>');
  constants.Add('shTx_FrmMain_RoomsAvailableFromChannels', '<b><font color="%s">%d</font></b> rooms<br>');
  constants.Add('shTx_FrmMain_NoRoomsAvailableFromChannels', '<font color="#ff0000"><b>WARNING</b></font> <b>NO</b> rooms available for channels<br>');
  constants.Add('shTx_FrmMain_RoomClassNotAvailableOnChannels', '<font color="#ff0000"><b>This room class is not shared on booking engines</b></font><br>');
  constants.Add('shTx_FrmMain_AutoAvailabilityOnChannels', '<font color="#00ff00">Live updates on booking channels</font></b><br>');
  constants.Add('shTx_FrmMain_WarningIncorrectAvailability', '<font color="#ff0000"><b>WARNING:</font><font color="#0000BB"> INCORRECT AVAILABILITY</font></b><br>');
  constants.Add('shTx_FrmMain_ChannelMaxAvailability', '<b><font color="%s">%d</font></b> rooms maximum<br>');

  constants.Add('shTx_FrmMain_ChannelMaxAvailUpdateFailed', 'Channel MAX availability update failed.');
  constants.Add('shTx_FrmMain_ChannelChangedMaxAvail', 'Changed Max availabilty for %s on channels to %d');
  constants.Add('shTx_FrmMain_WrongValueEntered', 'Wrong value entered');
  constants.Add('shTx_FrmMain_ChannelAvailUpdateFailed', 'Channel availability update failed.');
  constants.Add('shTx_FrmMain_ChannelChangedAvail', 'Availabilty for %s on channels set to %d');
  constants.Add('shTx_FrmMain_GuestAndRoomNumberBeingMoved', 'Moving guest ''%s'' from room %s');

  constants.Add('shTx_ChannelAvailabilityManager_RoomAvailabilityFetched', 'Availability is <font color="#ff0000"><b>being fetched</b></font>...');

  constants.Add('shTx_FrmMain_CopiedReservationToClipboard', 'Reservation %d copied to the clipboard');
  constants.Add('shTx_FrmMain_CopiedRoomReservationToClipboard', 'Reservation %d copied to the clipboard');
  constants.Add('shTx_FrmMain_PastedReservationFromClipboard', 'Reservation %d has been pasted into the NO-ROOM area');
  constants.Add('shTx_FrmMain_NoCopiedReservationFoundInClipboard', 'Reservation %d has been pasted into the NO-ROOM area');

  constants.Add('shTx_FrmMain_ChannelRoomType', 'Channel roomtype');

  constants.Add('shTx_FrmMain_UserCannotMoveTheRoomReservation', 'This room reservation has been blocked from moving - You are unable to move the guest to a different room.'#13#13 +
               'If it is absolutely necessary to move this room reservation for a different room, then you will need to open'#13'the reservation profile and change the "Block Move" status to false.');


  constants.Add('shTx_FrmChannelTogglingRules_ConfirmRemove', 'Do you really want to remove the selected rule: ');
  constants.Add('shTx_FrmChannelTogglingRules_NewRule', '<New Rule>');
  constants.Add('shTx_FrmChannelTogglingRules_Editing', 'Editing...');
  constants.Add('shTx_FrmChannelTogglingRules_Viewing', 'Viewing...');

  constants.Add('shTx_AllotmentToRes_InvalidAllotment', 'This is not a valid Allotment');

  constants.Add('shTx_uInvoice_ItemWithIncorrectItemType', 'Item %s has a unknown Item Type: %s');
  constants.Add('shTx_uInvoice_ItemTypeWithIncorrectVAT', 'Item type %s has a unknown VAT number: %s');

  constants.Add('shTx_RoomResProfile_PackageAlreadyExists_Remove', 'This room already has a package assigned.' + #10 + 'Remove the package?');
  constants.Add('shTx_RoomResProfile_NoPAckageForGroupInvoice', 'It is not possible to add a Package to a Group-invoice');

  constants.Add('shTxProvideRoom_Short', 'Room');
  constants.Add('shTxProvideRoom_Description', 'Description');
  constants.Add('shTxProvideRoom_Type', 'Type');
  constants.Add('shTxProvideRoom_TypeDescription', 'Type description');
  constants.Add('shTxProvideRoom_NumRooms', 'Num');
  constants.Add('shTxProvideRoom_Utilities', 'Utilities');
  constants.Add('shTxProvideRoom_Location', 'Location');
  constants.Add('shTxProvideRoom_Floor', 'Floor');

  constants.Add('shTxProvideRoom_Bath', 'ba');    // Bath
  constants.Add('shTxProvideRoom_Shower', 'Sh');    // Shower
  constants.Add('shTxProvideRoom_Safe', 'Sf');    // Safe
  constants.Add('shTxProvideRoom_Television', 'Tv');    // Television
  constants.Add('shTxProvideRoom_Video', 'Vi');    // Video
  constants.Add('shTxProvideRoom_Radio', 'Ra');    // Radio
  constants.Add('shTxProvideRoom_CDPlayer', 'CD');    // CDPlayer
  constants.Add('shTxProvideRoom_Telephone', 'Tp');    // Telephone
  constants.Add('shTxProvideRoom_Fax', 'Fx');    // Fax
  constants.Add('shTxProvideRoom_NetPlug', 'Ne');    // NetPlug
  constants.Add('shTxProvideRoom_Kitchen', 'ki');    // Kitchen
  constants.Add('shTxProvideRoom_Minibar', 'Mb');    // Minibar
  constants.Add('shTxProvideRoom_Fridge', 'Fr');    // Fridge
  constants.Add('shTxProvideRoom_Coffemachine', 'Co');    // Coffemachine
  constants.Add('shTxProvideRoom_ClothingPress', 'Pr');    // ClothingPress
  constants.Add('shTxProvideRoom_Hairdryer', 'Hd');    // Hairdryer
  constants.Add('shTxProvideRoom_Status1', 'Status'); // Status1
  constants.Add('shTxProvideRoom_Status', 'Status '); // Status

  constants.Add('shTxInvoice_Form_Header_Item', 'Item');
  constants.Add('shTxInvoice_Form_Header_Text', 'Text');
  constants.Add('shTxInvoice_Form_Header_Number', 'Number');
  constants.Add('shTxInvoice_Form_Header_UnitPrice', 'Unit Price');
  constants.Add('shTxInvoice_Form_Header_Total', 'Total');
  constants.Add('shTxInvoice_Form_Header_Reference', 'Reference');
  constants.Add('shTxInvoice_Form_Header_Source', 'Source');
  constants.Add('shTxInvoice_Form_Header_Package', 'Package');
  constants.Add('shTxInvoice_Form_Header_Guests', 'Guests');
  constants.Add('shTxInvoice_Form_Header_Confirmdate', 'Confirmdate');
  constants.Add('shTxInvoice_Form_Header_ConfirmAmount', 'ConfirmAmount');
  constants.Add('shTxInvoice_Form_Header_Vat', 'Vat');
  constants.Add('shTxInvoice_Form_Header_Alias', 'Alias');

  constants.Add('shTxLookAndFeel', 'Look && Feel');
  constants.Add('shTx_Refresh_Local_Data_Cache', 'This will clear and refresh the local data-cache. Are you sure you want to continue?');

  constants.Add('shTxEmailInvoice', 'Email invoice');

  constants.Add('shTxReservationHasNoContactEmailAddress', 'Unable to send email confirmation.'#10'This reservation does not have any contact email address attached to it.');
  constants.Add('shTxConfirmationEmailHasBeenSent', 'Booking confirmation email has been sent.');
  constants.Add('shTxCancellationEmailHasBeenSent', 'Cancellation confirmation email has been sent.');

  constants.Add('shTxExtraBedInvoiceText', 'Extra bed');

  constants.Add('shTxRoomerReRegisterPMS', 'ROOMER PMS has re-registered itself with the ROOMER backend.');

  constants.Add('shTxThisConfirmAllottedBooking', 'This will change the full booking into a confirmed reservation.' + #10#10 + 'Do you want to continue?');
  constants.Add('shTx_CloseFinancialDay', 'This will close the current day for revenues and payments?' + #10#10 + 'Do you want to continue?');
  constants.Add('shTx_CurrentFinancialDay',  'Current financial day: ');
end;

procedure AddConstants_7; // Baettu vid thennan ad vild
begin
  constants.Add('shTx_RptTurnoverPayments_ReportPerType', 'Report per product type');
  constants.Add('shTx_RptTurnoverPayments_ReportPerItem', 'Report per product');
  constants.Add('shTx_RptTurnoverPayments_NoConfirmedReports', 'No previously confirmed reports were selected.');

  constants.Add('shTx_FrmMain_UnassignedItemsButton', 'Unassigned Rooms (%d)');

  constants.Add('shTx_Various_DifferentRoomType', 'You are moving a booking of room type %s to a room of type %s.' + #10#10 +
                'Are you sure you want to continue?');

  constants.Add('shTx_Various_RoomNotClean', 'You are checking guest in to room %s which has not been cleaned.' + #10#10 +
                'Are you sure you want to continue?');
  constants.Add('shTx_Various_WouldCreateOverbooking', 'This would cause an overbooking for the following room type(s):' + #10#10);
  constants.Add('shTx_Various_AreYoySureYouWantToContinue', 'Are you sure you want to continue?');

  constants.Add('shTx_FinanceForecast_DoYouWantToConvertLayoutToNewVersion', 'The selected report is saved in an older format.' + #10 +
                'Do you want to convert it to the new format now?' + #10#10 +
                'Note: The report will not work correctly until you accept and convert the report to the newer format.' + #10 +
                'After conversion though, the report will not work correctly in the older version of ROOMER PMS.');

  constants.Add('shTx_Invoice_WarningWhenMovingCityTax',
                'PLEASE NOTE:' + #13#13 +
                'By moving the city-tax item to a different invoice you will disconnect it from the room-stay.' + #13 +
                'This simply means that if you will later change the booking nights and/or prices then you' + #13 +
                'will need to manually change the city-tax' + #13#13 +
                'Do you want to continue anyway?');

  constants.Add('shTx_frmReservationExtras_AddedMoreThenAvailableInPeriod',
                'The Extra(s) [%s] do not have enough available stock for the whole reservation period: '+ #13 +
                'Do you want to continue anyway?');
  constants.Add('shDeleteDayClosingTime', 'Delete DayClosingtime');
  constants.Add('shRoomerFormBusyStateIdle', 'Ready');
  constants.Add('shRoomerFormBusyStateLoadingData', 'Loading data...');
  constants.Add('shRoomerFormBusyStatePrinting', 'Printing ...');

  constants.Add('shServiceTypeNeeded', 'Please provide the service type.');
  constants.Add('shOnceTypeNeeded', 'Please provide the once type.');

  constants.Add('shChangesToRomClassDoNotChangeTheBookingSiteOTA', 'Please NOTE:'#13'Changing these settings does not affect the settings in the OTA (booking site).'#13'You will need to apply these settings there yourself, manually.');

  constants.Add('shCleaningNotesIntervalLabel', 'Days interval:');
  constants.Add('shCleaningNotesOnceLabel', 'Day in question:');

  constants.Add('shTx_D_SaveToSpecifiedInvoiceIndex', 'Saved invoice as number %d');

  constants.Add('shTx_MandatoryFields_City', 'City');
  constants.Add('shTx_MandatoryFields_Country', 'Country of origin');
  constants.Add('shTx_MandatoryFields_FirstName', 'First name');
  constants.Add('shTx_MandatoryFields_Surname', 'Surname');
  constants.Add('shTx_MandatoryFields_Market', 'Visitation type (Leisure/Business)');
  constants.Add('shTx_MandatoryFields_Nationality', 'Nationality');
  constants.Add('shTx_MandatoryFields_Guarantee', 'Guarantee');

end;

procedure AddConstants_OfflineReports;
begin
  constants.Add(cshTx_OfflineReports_NameHeader, 'Report name');
  constants.Add(cshTx_OfflineReports_DateGenHeader, 'Date Generated');
  constants.Add(cshTx_OfflineReports_OfflineMessage,   'No connection with Roomer, working offline');

  constants.Add(cshTx_HotelStatusOfflineReport_Name, 'Hotel Status Report');
  constants.Add(cshTx_HotelArrivalsOfflineReport_Name, 'Hotel Arrivals Report');
end;

procedure prepareConstants;
begin
  constants := TDictionary<String, String>.Create(TCustomEqualityComparer.Create());

  OriginalConstants;
  AddConstants_1;
  AddConstants_2;
  AddConstants_3;
  AddConstants_4;
  AddConstants_5;
  AddConstants_CLang;
  AddConstants_6;
  AddConstants_7;
  AddConstants_OfflineReports;

  AddConstants_SystemConstants;
  AddConstants_NewUIConstants;
end;

function GetTranslatedText(nameOfConstant : String) : String;
begin
  result := RoomerLanguage.GetTranslatedText(nameOfConstant);
end;

procedure GenerateTranslateTextTableForConstants;
var Key,
    rubbish : String;
begin
  RoomerLanguage.ActivateDBLanguageCollection;
  try
    for Key in constants.Keys do
      rubbish := GetTranslatedText(Key);
    RoomerLanguage.SubmitDBLanguageCollection;
  finally
    RoomerLanguage.DeactivateDBLanguageCollection;
  end;
end;

procedure GenerateTranslateTextTableForAllForms;
begin
  frmProvideARoom2 := TfrmProvideARoom2.Create(nil); frmProvideARoom2.Free; frmProvideARoom2 := nil;
  frmMultiSelection := TfrmMultiSelection.Create(nil); frmMultiSelection.Free; frmMultiSelection := nil;
//  frmInvoiceInfo := TfrmInvoiceInfo.Create(nil); frmInvoiceInfo.Free; frmInvoiceInfo := nil;
  frmInvoice := TfrmInvoice.Create(nil); frmInvoice.Free; frmInvoice := nil;
  frmReservationProfile := TfrmReservationProfile.Create(nil); frmReservationProfile.Free; frmReservationProfile := nil;
//frmSplash := TfrmSplash.Create(nil); frmSplash.Free; frmSplash := nil;
  frmInvoicePayment := TfrmInvoicePayment.Create(nil); frmInvoicePayment.Free; frmInvoicePayment := nil;
  frmControlData := TfrmControlData.Create(nil); frmControlData.Free; frmControlData := nil;
  frmFinishedInvoices2 := TfrmFinishedInvoices2.Create(nil); frmFinishedInvoices2.Free; frmFinishedInvoices2 := nil;
  frmCreditPrompt := TfrmCreditPrompt.Create(nil); frmCreditPrompt.Free; frmCreditPrompt := nil;
//  frmInvoiceCompress := TfrmInvoiceCompress.Create(nil); frmInvoiceCompress.Free; frmInvoiceCompress := nil;
  frmInvoiceList := TfrmInvoiceList.Create(nil); frmInvoiceList.Free; frmInvoiceList := nil;
  frmConverts := TfrmConverts.Create(nil); frmConverts.Free; frmConverts := nil;
  frmSelLang := TfrmSelLang.Create(nil); frmSelLang.Free; frmSelLang := nil;
//frmUDL := TfrmUDL.Create(nil); frmUDL.Free; frmUDL := nil;
//frmHotelListMissing := TfrmHotelListMissing.Create(nil); frmHotelListMissing.Free; frmHotelListMissing := nil;
  frmMaidActions := TfrmMaidActions.Create(nil); frmMaidActions.Free; frmMaidActions := nil;
  frmMaidActionsEdit := TfrmMaidActionsEdit.Create(nil); frmMaidActionsEdit.Free; frmMaidActionsEdit := nil;
// Empty?  frmMakeReservation := TfrmMakeReservation.Create(nil); frmMakeReservation.Free; frmMakeReservation := nil;
  frmRoomDateProblem := TfrmRoomDateProblem.Create(nil); frmRoomDateProblem.Free; frmRoomDateProblem := nil;
  frmResProblem := TfrmResProblem.Create(nil); frmResProblem.Free; frmResProblem := nil;
//  frmStatisticsForcast := TfrmStatisticsForcast.Create(nil); frmStatisticsForcast.Free; frmStatisticsForcast := nil;
  frmDayFinical := TfrmDayFinical.Create(nil); frmDayFinical.Free; frmDayFinical := nil;
  frmConvertGroups := TfrmConvertGroups.Create(nil); frmConvertGroups.Free; frmConvertGroups := nil;
  frmInvoiceList2 := TfrmInvoiceList2.Create(nil); frmInvoiceList2.Free; frmInvoiceList2 := nil;
//  frmRptCustomer := TfrmRptCustomer.Create(nil); frmRptCustomer.Free; frmRptCustomer := nil;
//frmDayNotes := TfrmDayNotes.Create(nil); frmDayNotes.Free; frmDayNotes := nil;
  frmChangeRRdates := TfrmChangeRRdates.Create(nil); frmChangeRRdates.Free; frmChangeRRdates := nil;
  frmChangeRate := TfrmChangeRate.Create(nil); frmChangeRate.Free; frmChangeRate := nil;
  frmOpenInvoicesNew := TfrmOpenInvoicesNew.Create(nil); frmOpenInvoicesNew.Free; frmOpenInvoicesNew := nil;
  frmResMemos := TfrmResMemos.Create(nil); frmResMemos.Free; frmResMemos := nil;
//  frmSelHotel := TfrmSelHotel.Create(nil); frmSelHotel.Free; frmSelHotel := nil;
  frmHomedate := TfrmHomedate.Create(nil); frmHomedate.Free; frmHomedate := nil;
//  frmGoToRoomandDate := TfrmGoToRoomandDate.Create(nil); frmGoToRoomandDate.Free; frmGoToRoomandDate := nil;
  frmHiddenInfo := TfrmHiddenInfo.Create(nil); frmHiddenInfo.Free; frmHiddenInfo := nil;
  frmDownPayment := TfrmDownPayment.Create(nil); frmDownPayment.Free; frmDownPayment := nil;
  frmLodgingTaxReport2 := TfrmLodgingTaxReport2.Create(nil); frmLodgingTaxReport2.Free; frmLodgingTaxReport2 := nil;
  frmCancelReservation3 := TfrmCancelReservation3.Create(nil); frmCancelReservation3.Free; frmCancelReservation3 := nil;
  frmCancelReservation2 := TfrmCancelReservation2.Create(nil); frmCancelReservation2.Free; frmCancelReservation2 := nil;
  frmNationalReport3 := TfrmNationalReport3.Create(nil); frmNationalReport3.Free; frmNationalReport3 := nil;
  frmAddAccommodation := TfrmAddAccommodation.Create(nil); frmAddAccommodation.Free; frmAddAccommodation := nil;
  frmCountries := TfrmCountries.Create(nil); frmCountries.Free; frmCountries := nil;
  frmPayGroups := TfrmPayGroups.Create(nil); frmPayGroups.Free; frmPayGroups := nil;
  frmPriceCodes := TfrmPriceCodes.Create(nil); frmPriceCodes.Free; frmPriceCodes := nil;
  frmGuestProfile2 := TfrmGuestProfile2.Create(nil); frmGuestProfile2.Free; frmGuestProfile2 := nil;
  frmPayTypes := TfrmPayTypes.Create(nil); frmPayTypes.Free; frmPayTypes := nil;
  frmCountryGroups := TfrmCountryGroups.Create(nil); frmCountryGroups.Free; frmCountryGroups := nil;
  frmVatCodes := TfrmVatCodes.Create(nil); frmVatCodes.Free; frmVatCodes := nil;
  frmRebuildReservationStats := TfrmRebuildReservationStats.Create(nil); frmRebuildReservationStats.Free; frmRebuildReservationStats := nil;
  frmMakeReservationQuick := TfrmMakeReservationQuick.Create(nil); frmMakeReservationQuick.Free; frmMakeReservationQuick := nil;
  TfrmRoomerSplash.Create(nil).Free;

  // No need for global variable
  //  frmRoomerLoginForm := TfrmRoomerLoginForm.Create(nil); frmRoomerLoginForm.Free; frmRoomerLoginForm := nil;
  TfrmRoomerLoginForm.Create(nil).Free;

  frmAboutRoomer := TfrmAboutRoomer.Create(nil); frmAboutRoomer.Free; frmAboutRoomer := nil;
  frmManageFilesOnServer := TfrmManageFilesOnServer.Create(nil); frmManageFilesOnServer.Free; frmManageFilesOnServer := nil;
  frmChannelAvailabilityManager := TfrmChannelAvailabilityManager.Create(nil); frmChannelAvailabilityManager.Free; frmChannelAvailabilityManager := nil;
  frmEditRoomPrice := TfrmEditRoomPrice.Create(nil); frmEditRoomPrice.Free; frmEditRoomPrice := nil;
  frmRoomCleanMaintenanceStatus := TfrmRoomCleanMaintenanceStatus.Create(nil); frmRoomCleanMaintenanceStatus.Free; frmRoomCleanMaintenanceStatus := nil;
  frmRates := TfrmRates.Create(nil); frmRates.Free; frmRates := nil;
  frmSeasons2 := TfrmSeasons2.Create(nil); frmSeasons2.Free; frmSeasons2 := nil;
  frmRoomRates := TfrmRoomRates.Create(nil); frmRoomRates.Free; frmRoomRates := nil;
  frmRoomTypesGroups2 := TfrmRoomTypesGroups2.Create(nil); frmRoomTypesGroups2.Free; frmRoomTypesGroups2 := nil;
  frmRoomTypes2 := TfrmRoomTypes2.Create(nil); frmRoomTypes2.Free; frmRoomTypes2 := nil;
  frmPackageItems := TfrmPackageItems.Create(nil); frmPackageItems.Free; frmPackageItems := nil;
  frmRooms3 := TfrmRooms3.Create(nil); frmRooms3.Free; frmRooms3 := nil;
  frmCustomers2 := TfrmCustomers2.Create(nil); frmCustomers2.Free; frmCustomers2 := nil;
  TfrmStaffEdit2.Create(nil).Free;
  frmStaffMembers2 := TfrmStaffMembers2.Create(nil); frmStaffMembers2.Free; frmStaffMembers2 := nil;
  frmCustomerEdit2 := TfrmCustomerEdit2.Create(nil); frmCustomerEdit2.Free; frmCustomerEdit2 := nil;
  frmChannels := TfrmChannels.Create(nil); frmChannels.Free; frmChannels := nil;
//  frmSystemTriggers := TfrmSystemTriggers.Create(nil); frmSystemTriggers.Free; frmSystemTriggers := nil;
//  frmCreatePassword := TfrmCreatePassword.Create(nil); frmCreatePassword.Free; frmCreatePassword := nil;
//  frmSystemServers := TfrmSystemServers.Create(nil); frmSystemServers.Free; frmSystemServers := nil;
//  frmSystemActions := TfrmSystemActions.Create(nil); frmSystemActions.Free; frmSystemActions := nil;
  frmStaffTypes2 := TfrmStaffTypes2.Create(nil); frmStaffTypes2.Free; frmStaffTypes2 := nil;
  TfrmItems2.Create(nil).Free;
  frmItemTypes2 := TfrmItemTypes2.Create(nil); frmItemTypes2.Free; frmItemTypes2 := nil;
  frmLocations := TfrmLocations.Create(nil); frmLocations.Free; frmLocations := nil;
  frmCurrencies := TfrmCurrencies.Create(nil); frmCurrencies.Free; frmCurrencies := nil;
//  frmInvoicePayment2 := TfrmInvoicePayment2.Create(nil); frmInvoicePayment2.Free; frmInvoicePayment2 := nil;
  frmChannelManager := TfrmChannelManager.Create(nil); frmChannelManager.Free; frmChannelManager := nil;
  frmCommunicationTest := TfrmCommunicationTest.Create(nil); frmCommunicationTest.Free; frmCommunicationTest := nil;
  frmHouseKeeping := TfrmHouseKeeping.Create(nil); frmHouseKeeping.Free; frmHouseKeeping := nil;
//  frmTableEditForm := TfrmTableEditForm.Create(nil); frmTableEditForm.Free; frmTableEditForm := nil;
  frmRptResStats := TfrmRptResStats.Create(nil); frmRptResStats.Free; frmRptResStats := nil;
  frmGuestSearch := TfrmGuestSearch.Create(nil); frmGuestSearch.Free; frmGuestSearch := nil;
//  frmRptResDates := TfrmRptResDates.Create(nil); frmRptResDates.Free; frmRptResDates := nil;
  frmChannelTogglingRules := TfrmChannelTogglingRules.Create(nil); frmChannelTogglingRules.Free; frmChannelTogglingRules := nil;
  frmAllotmentToRes := TfrmAllotmentToRes.Create(nil); frmAllotmentToRes.Free; frmAllotmentToRes := nil;
  frmPersonviptypes := TfrmPersonviptypes.Create(nil); frmPersonviptypes.Free; frmPersonviptypes := nil;
  frmPersonContactType := TfrmPersonContactType.Create(nil); frmPersonContactType.Free; frmPersonContactType := nil;
  frmKeyPairSelector := TfrmKeyPairSelector.Create(nil); frmKeyPairSelector.Free; frmKeyPairSelector := nil;
  frmResources := TfrmResources.Create(nil); frmResources.Free; frmResources := nil;
  frmAssignPayment := TfrmAssignPayment.Create(nil); frmAssignPayment.Free; frmAssignPayment := nil;
  frmRptDownPayments := TfrmRptDownPayments.Create(nil); frmRptDownPayments.Free; frmRptDownPayments := nil;
  frmTaxes := TfrmTaxes.Create(nil); frmTaxes.Free; frmTaxes := nil;

  TFrmMessagesTemplates.Create(nil).Free;

  FrmNotepad := TFrmNotepad.Create(nil); FrmNotepad.Free; FrmNotepad := nil;
  frmRptResInvoices := TfrmRptResInvoices.Create(nil); frmRptResInvoices.Free; frmRptResInvoices := nil;
  frmRptTotallist := TfrmRptTotallist.Create(nil); frmRptTotallist.Free; frmRptTotallist := nil;
  frmRptCustInvoices := TfrmRptCustInvoices.Create(nil); frmRptCustInvoices.Free; frmRptCustInvoices := nil;
  FrmRBEContainer := TFrmRBEContainer.Create(nil); FrmRBEContainer.Free; FrmRBEContainer := nil;
  frmRbePreferences := TfrmRbePreferences.Create(nil); frmRbePreferences.Free; frmRbePreferences := nil;
  frmRptManagment := TfrmRptManagment.Create(nil); frmRptManagment.Free; frmRptManagment := nil;

  FrmHandleBookKeepingException := TFrmHandleBookKeepingException.Create(nil); FrmHandleBookKeepingException.Free; FrmHandleBookKeepingException := nil;
  FrmRoomClassEdit := TFrmRoomClassEdit.Create(nil); FrmRoomClassEdit.Free; FrmRoomClassEdit := nil;

  frmRptReservations := TfrmRptReservations.Create(nil); frmRptReservations.Free; frmRptReservations := nil;
  FrmPostInvoices := TFrmPostInvoices.Create(nil); FrmPostInvoices.Free; FrmPostInvoices := nil;
  frmRptBreakfastGuests := TfrmRptBreakfastGuests.Create(nil); frmRptBreakfastGuests.Free; frmRptBreakfastGuests := nil;
  frmGuestCheckInForm := TfrmGuestCheckInForm.Create(nil); frmGuestCheckInForm.Free; frmGuestCheckInForm := nil;

  frmRptNotes := TfrmRptNotes.Create(nil); frmRptNotes.Free; frmRptNotes := nil;
//  frmRptGuests := TfrmRptGuests.Create(nil); frmRptGuests.Free; frmRptGuests := nil;
  frmRptReservationsCust := TfrmRptReservationsCust.Create(nil); frmRptReservationsCust.Free; frmRptReservationsCust := nil;

  frmGuestProfiles := TfrmGuestProfiles.Create(nil); frmGuestProfiles.Free; frmGuestProfiles := nil;
  frmGuestPortfolio := TfrmGuestPortfolio.Create(nil); frmGuestPortfolio.Free; frmGuestPortfolio := nil;


  frmRptTurnoverAndPayments := TfrmRptTurnoverAndPayments.Create(nil); frmRptTurnoverAndPayments.Free; frmRptTurnoverAndPayments := nil;
  frmRptResStatsRooms := TfrmRptResStatsRooms.Create(nil); frmRptResStatsRooms.Free; frmRptResStatsRooms := nil;

  frmEmailingDialog := TfrmEmailingDialog.Create(nil); frmEmailingDialog.Free; frmEmailingDialog := nil;

  frmMakeKreditInvoice := TfrmMakeKreditInvoice.Create(nil); frmMakeKreditInvoice.Free; frmMakeKreditInvoice := nil;

  frmBookKeepingCodes := TfrmBookKeepingCodes.Create(nil); frmBookKeepingCodes.Free; frmBookKeepingCodes := nil;

  FrmEditEmailProperties := TFrmEditEmailProperties.Create(nil); FrmEditEmailProperties.Free; FrmEditEmailProperties := nil;

  frmRptBookkeeping := TfrmRptBookkeeping.Create(nil); frmRptBookkeeping.Free; frmRptBookkeeping := nil;
  FrmReservationEmailingDialog := TFrmReservationEmailingDialog.Create(nil); FrmReservationEmailingDialog.Free; FrmReservationEmailingDialog := nil;
  FrmReservationCancellationDialog := TFrmReservationCancellationDialog.Create(nil); FrmReservationCancellationDialog.Free; FrmReservationCancellationDialog := nil;
  frmRptCashier := TfrmRptCashier.Create(nil); frmRptCashier.Free; frmRptCashier := nil;

  frmPhoneRates := TfrmPhoneRates.Create(nil); frmPhoneRates.Free; frmPhoneRates := nil;
  frmGroupGuests := TfrmGroupGuests.Create(nil); frmGroupGuests.Free; frmGroupGuests := nil;

  FrmEmailExcelSheet := TFrmEmailExcelSheet.Create(nil); FrmEmailExcelSheet.Free; FrmEmailExcelSheet := nil;

  frmRptTurnoverAndPayments := TfrmRptTurnoverAndPayments.Create(nil); frmRptTurnoverAndPayments.Free; frmRptTurnoverAndPayments := nil;
  FrmInvoiceLineEdit := TFrmInvoiceLineEdit.Create(nil); FrmInvoiceLineEdit.Free; FrmInvoiceLineEdit := nil;
  frmMergePortfolios := TfrmMergePortfolios.Create(nil); frmMergePortfolios.Free; frmMergePortfolios := nil;
  frmStaffComm := TfrmStaffComm.Create(nil); frmStaffComm.Free; frmStaffComm := nil;
  FrmCheckOut := TFrmCheckOut.Create(nil); FrmCheckOut.Free; FrmCheckOut := nil;
  FrmStaffNote := TFrmStaffNote.Create(nil); FrmStaffNote.Free; FrmStaffNote := nil;
  FrmMessageViewer := TFrmMessageViewer.Create(nil); FrmMessageViewer.Free; FrmMessageViewer := nil;
  frmInvoiceCompare := TfrmInvoiceCompare.Create(nil); frmInvoiceCompare.Free; frmInvoiceCompare := nil;
  FrmAlertEdit := TFrmAlertEdit.Create(nil); FrmAlertEdit.Free; FrmAlertEdit := nil;
  FrmAlertDialog := TFrmAlertDialog.Create(nil); FrmAlertDialog.Free; FrmAlertDialog := nil;
  FrmAlertPanel := TFrmAlertPanel.Create(nil); FrmAlertPanel.Free; FrmAlertPanel := nil;
  FrmCustomerDepartmentEdit := TFrmCustomerDepartmentEdit.Create(nil); FrmCustomerDepartmentEdit.Free; FrmCustomerDepartmentEdit := nil;

  FrmReservationHintHolder := TFrmReservationHintHolder.Create(nil);
  RoomerLanguage.TranslateThisForm(FrmReservationHintHolder);
  FrmReservationHintHolder.Free; FrmReservationHintHolder := nil;

  embOccupancyView := TembOccupancyView.Create(nil);
  RoomerLanguage.TranslateThisForm(embOccupancyView);
  embOccupancyView.Free; embOccupancyView := nil;

  embPeriodView := TembPeriodView.Create(nil);
  RoomerLanguage.TranslateThisForm(embPeriodView);
  embPeriodView.Free; embPeriodView := nil;

  FrmRateQuery := TFrmRateQuery.Create(nil);
  RoomerLanguage.TranslateThisForm(FrmRateQuery);
  FrmRateQuery.Free; FrmRateQuery := nil;

  TfrmOfflineReports.Create(nil).Free;

  TfrmArrivalsReport.Create(nil).Free;

  TFrmRoomReservationCancellationDialog.Create(nil).Free;

  TfrmDeparturesReport.Create(nil).Free;
  TfrmRptStockItems.Create(nil).Free;
  TfrmPaymentReqRoomtypeGroup.Create(nil).Free;

  TfrmCleaningNotes.Create(nil).Free;
  TfrmCleaningNotesEdit.Create(nil).Free;


end;

///////////////////////////////////////////////////////////////////////////////////////
///
///

function TCustomEqualityComparer.Equals(const Left, Right: string): Boolean;
begin
  Result := SameText(Left, Right);
end;

function TCustomEqualityComparer.GetHashCode(const Value: string): Integer;
var s: string;
begin
  s := UpperCase(Value);
  Result := BobJenkinsHash(s[1], Length(s) * SizeOf(s[1]), 0);
end;


initialization
  prepareConstants;

finalization
  constants.Free;

end.


