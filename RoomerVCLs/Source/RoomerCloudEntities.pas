unit RoomerCloudEntities;

interface

uses System.SysUtils, System.Classes;

type
  TCancellationdetailsEntity = class(TPersistent)
  private
    Fid: Integer; 
    FRoomReservation: Integer; 
    FReservation: Integer; 
    FRoomType: String; 
    FCancelDate: TTimeStamp; 
    FCancelStaff: String; 
    FCancelReason: String; 
    FCancelRequest: String; 
    FCancelInformation: String; 
    FCancelType: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setRoomType(RoomType: String); 
    procedure setCancelDate(CancelDate: TTimeStamp); 
    procedure setCancelStaff(CancelStaff: String); 
    procedure setCancelReason(CancelReason: String); 
    procedure setCancelRequest(CancelRequest: String); 
    procedure setCancelInformation(CancelInformation: String); 
    procedure setCancelType(CancelType: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Reservation : Integer read FReservation write FReservation;
    property RoomType : String read FRoomType write FRoomType;
    property CancelDate : TTimeStamp read FCancelDate write FCancelDate;
    property CancelStaff : String read FCancelStaff write FCancelStaff;
    property CancelReason : String read FCancelReason write FCancelReason;
    property CancelRequest : String read FCancelRequest write FCancelRequest;
    property CancelInformation : String read FCancelInformation write FCancelInformation;
    property CancelType : Integer read FCancelType write FCancelType;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TCancellationdetailsEntity = Array Of TCancellationdetailsEntity;

  TChannelclassrelationsEntity = class(TPersistent)
  private
    Fid: Integer; 
    FchannelId: Integer; 
    FroomclassId: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setChannelId(channelId: Integer); 
    procedure setRoomclassId(roomclassId: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property channelId : Integer read FchannelId write FchannelId;
    property roomclassId : Integer read FroomclassId write FroomclassId;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TChannelclassrelationsEntity = Array Of TChannelclassrelationsEntity;

  TChannelmanagersEntity = class(TPersistent)
  private
    Fid: Integer; 
    Factive: Byte; 
    Fcode: String; 
    FDescription: String; 
    FadminUsername: String; 
    FadminPassword: String; 
    FwebserviceURI: String; 
    FwebserviceUsername: String; 
    FwebservicePassword: String; 
    FwebserviceHotelCode: String; 
    FweserviceRequestor: String; 
    Fchannels: String; 
    FsendRate: Byte; 
    FsendAvailability: Byte; 
    FsendStopSell: Byte; 
    FsendMinStay: Byte; 
    FmaintenanceDays: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setActive(active: Byte); 
    procedure setCode(code: String); 
    procedure setDescription(Description: String); 
    procedure setAdminUsername(adminUsername: String); 
    procedure setAdminPassword(adminPassword: String); 
    procedure setWebserviceURI(webserviceURI: String); 
    procedure setWebserviceUsername(webserviceUsername: String); 
    procedure setWebservicePassword(webservicePassword: String); 
    procedure setWebserviceHotelCode(webserviceHotelCode: String); 
    procedure setWeserviceRequestor(weserviceRequestor: String); 
    procedure setChannels(channels: String); 
    procedure setSendRate(sendRate: Byte); 
    procedure setSendAvailability(sendAvailability: Byte); 
    procedure setSendStopSell(sendStopSell: Byte); 
    procedure setSendMinStay(sendMinStay: Byte); 
    procedure setMaintenanceDays(maintenanceDays: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property active : Byte read Factive write Factive;
    property code : String read Fcode write Fcode;
    property Description : String read FDescription write FDescription;
    property adminUsername : String read FadminUsername write FadminUsername;
    property adminPassword : String read FadminPassword write FadminPassword;
    property webserviceURI : String read FwebserviceURI write FwebserviceURI;
    property webserviceUsername : String read FwebserviceUsername write FwebserviceUsername;
    property webservicePassword : String read FwebservicePassword write FwebservicePassword;
    property webserviceHotelCode : String read FwebserviceHotelCode write FwebserviceHotelCode;
    property weserviceRequestor : String read FweserviceRequestor write FweserviceRequestor;
    property channels : String read Fchannels write Fchannels;
    property sendRate : Byte read FsendRate write FsendRate;
    property sendAvailability : Byte read FsendAvailability write FsendAvailability;
    property sendStopSell : Byte read FsendStopSell write FsendStopSell;
    property sendMinStay : Byte read FsendMinStay write FsendMinStay;
    property maintenanceDays : Integer read FmaintenanceDays write FmaintenanceDays;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TChannelmanagersEntity = Array Of TChannelmanagersEntity;

  TChannelplancodesEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fcode: String; 
    Fdescription: String; 
    Factive: Byte; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setCode(code: String); 
    procedure setDescription(description: String); 
    procedure setActive(active: Byte); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property code : String read Fcode write Fcode;
    property description : String read Fdescription write Fdescription;
    property active : Byte read Factive write Factive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TChannelplancodesEntity = Array Of TChannelplancodesEntity;

  TChannelratesEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fdate: TTimeStamp; 
    Fprice: Double; 
    Fdirty: Byte; 
    Fminstay: Integer; 
    Fstop: Byte; 
    FchannelManager: Integer; 
    FchannelId: Integer; 
    FroomClassId: Integer; 
    FplanCodeId: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setDate(date: TTimeStamp); 
    procedure setPrice(price: Double); 
    procedure setDirty(dirty: Byte); 
    procedure setMinstay(minstay: Integer); 
    procedure setStop(stop: Byte); 
    procedure setChannelManager(channelManager: Integer); 
    procedure setChannelId(channelId: Integer); 
    procedure setRoomClassId(roomClassId: Integer); 
    procedure setPlanCodeId(planCodeId: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property date : TTimeStamp read Fdate write Fdate;
    property price : Double read Fprice write Fprice;
    property dirty : Byte read Fdirty write Fdirty;
    property minstay : Integer read Fminstay write Fminstay;
    property stop : Byte read Fstop write Fstop;
    property channelManager : Integer read FchannelManager write FchannelManager;
    property channelId : Integer read FchannelId write FchannelId;
    property roomClassId : Integer read FroomClassId write FroomClassId;
    property planCodeId : Integer read FplanCodeId write FplanCodeId;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TChannelratesEntity = Array Of TChannelratesEntity;

  TChannelratesavailabilitiesEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fdate: TTimeStamp; 
    Favailability: Integer; 
    Fdirty: Byte; 
    FroomClassId: Integer; 
    FplanCodeID: Integer; 
    FchannelManagerId: Integer; 
    FsetAvailability: Integer; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setDate(date: TTimeStamp); 
    procedure setAvailability(availability: Integer); 
    procedure setDirty(dirty: Byte); 
    procedure setRoomClassId(roomClassId: Integer); 
    procedure setPlanCodeID(planCodeID: Integer); 
    procedure setChannelManagerId(channelManagerId: Integer); 
    procedure set_SetAvailability(setAvailability: Integer); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property date : TTimeStamp read Fdate write Fdate;
    property availability : Integer read Favailability write Favailability;
    property dirty : Byte read Fdirty write Fdirty;
    property roomClassId : Integer read FroomClassId write FroomClassId;
    property planCodeID : Integer read FplanCodeID write FplanCodeID;
    property channelManagerId : Integer read FchannelManagerId write FchannelManagerId;
    property set_Availability : Integer read FsetAvailability write FsetAvailability;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TChannelratesavailabilitiesEntity = Array Of TChannelratesavailabilitiesEntity;

  TChannelsEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fname: String; 
    Factive: Byte; 
    FchannelManagerId: String; 
    FminAlotment: Integer; 
    FdefaultAvailability: Integer; 
    FdefaultPricePp: Double; 
    FmarketSegment: String; 
    FcurrencyId: Integer; 
    FmanagedByChannelManager: Byte; 
    FdefaultChannel: Byte; 
    Fpush: Byte; 
    FcustomerId: Integer; 
    Fcolor: String; 
    FrateRoundingType: Integer; 
    FcompensationPercentage: Double; 
    FhotelsBookingEngine: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setName(name: String); 
    procedure setActive(active: Byte); 
    procedure setChannelManagerId(channelManagerId: String); 
    procedure setMinAlotment(minAlotment: Integer); 
    procedure setDefaultAvailability(defaultAvailability: Integer); 
    procedure setDefaultPricePp(defaultPricePp: Double); 
    procedure setMarketSegment(marketSegment: String); 
    procedure setCurrencyId(currencyId: Integer); 
    procedure setManagedByChannelManager(managedByChannelManager: Byte); 
    procedure setDefaultChannel(defaultChannel: Byte); 
    procedure setPush(push: Byte); 
    procedure setCustomerId(customerId: Integer); 
    procedure setColor(color: String); 
    procedure setRateRoundingType(rateRoundingType: Integer); 
    procedure setCompensationPercentage(compensationPercentage: Double); 
    procedure setHotelsBookingEngine(hotelsBookingEngine: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property name : String read Fname write Fname;
    property active : Byte read Factive write Factive;
    property channelManagerId : String read FchannelManagerId write FchannelManagerId;
    property minAlotment : Integer read FminAlotment write FminAlotment;
    property defaultAvailability : Integer read FdefaultAvailability write FdefaultAvailability;
    property defaultPricePp : Double read FdefaultPricePp write FdefaultPricePp;
    property marketSegment : String read FmarketSegment write FmarketSegment;
    property currencyId : Integer read FcurrencyId write FcurrencyId;
    property managedByChannelManager : Byte read FmanagedByChannelManager write FmanagedByChannelManager;
    property defaultChannel : Byte read FdefaultChannel write FdefaultChannel;
    property push : Byte read Fpush write Fpush;
    property customerId : Integer read FcustomerId write FcustomerId;
    property color : String read Fcolor write Fcolor;
    property rateRoundingType : Integer read FrateRoundingType write FrateRoundingType;
    property compensationPercentage : Double read FcompensationPercentage write FcompensationPercentage;
    property hotelsBookingEngine : Byte read FhotelsBookingEngine write FhotelsBookingEngine;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TChannelsEntity = Array Of TChannelsEntity;

  TChanneltogglingrulesEntity = class(TPersistent)
  private
    Fid: Integer; 
    Factive: Byte; 
    Fdescription: String; 
    FselectedRoomTypeIds: String; 
    FoccupancyLimit: Double; 
    FwhichDaysIndex: Integer; 
    FselectedDays: String; 
    FselectedMonths: String; 
    FselectedYears: String; 
    FselectedChannelsIds: String; 
    Fpriority: Integer; 
    Fwindow: Integer;
    Fjson: String;
  public
    procedure setId(id: Integer); 
    procedure setActive(active: Byte); 
    procedure setDescription(description: String); 
    procedure setSelectedRoomTypeIds(selectedRoomTypeIds: String); 
    procedure setOccupancyLimit(occupancyLimit: Double); 
    procedure setWhichDaysIndex(whichDaysIndex: Integer); 
    procedure setSelectedDays(selectedDays: String); 
    procedure setSelectedMonths(selectedMonths: String); 
    procedure setSelectedYears(selectedYears: String); 
    procedure setSelectedChannelsIds(selectedChannelsIds: String); 
    procedure setPriority(priority: Integer);
    procedure setWindow(window: Integer);
    procedure setJson(json: String);
  published
    property id : Integer read Fid write Fid;
    property active : Byte read Factive write Factive;
    property description : String read Fdescription write Fdescription;
    property selectedRoomTypeIds : String read FselectedRoomTypeIds write FselectedRoomTypeIds;
    property occupancyLimit : Double read FoccupancyLimit write FoccupancyLimit;
    property whichDaysIndex : Integer read FwhichDaysIndex write FwhichDaysIndex;
    property selectedDays : String read FselectedDays write FselectedDays;
    property selectedMonths : String read FselectedMonths write FselectedMonths;
    property selectedYears : String read FselectedYears write FselectedYears;
    property selectedChannelsIds : String read FselectedChannelsIds write FselectedChannelsIds;
    property priority : Integer read Fpriority write Fpriority;
    property window : Integer read Fwindow write Fwindow;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TChanneltogglingrulesEntity = Array Of TChanneltogglingrulesEntity;

  TChanneltogglingrulessplitEntity = class(TPersistent)
  private
    Fid: Integer; 
    FruleId: Integer; 
    FstayDate: TDateTime; 
    FroomClassId: Integer; 
    FoccupancyLevel: Double; 
    FchannelId: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setRuleId(ruleId: Integer); 
    procedure setStayDate(stayDate: TDateTime); 
    procedure setRoomClassId(roomClassId: Integer); 
    procedure setOccupancyLevel(occupancyLevel: Double); 
    procedure setChannelId(channelId: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property ruleId : Integer read FruleId write FruleId;
    property stayDate : TDateTime read FstayDate write FstayDate;
    property roomClassId : Integer read FroomClassId write FroomClassId;
    property occupancyLevel : Double read FoccupancyLevel write FoccupancyLevel;
    property channelId : Integer read FchannelId write FchannelId;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TChanneltogglingrulessplitEntity = Array Of TChanneltogglingrulessplitEntity;

  TColorsEntity = class(TPersistent)
  private
    FID: Integer; 
    FColorHex: String; 
    FDescription: String; 
    FDisplayOrder: Integer; 
    FActive: Byte; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setColorHex(ColorHex: String); 
    procedure setDescription(Description: String); 
    procedure setDisplayOrder(DisplayOrder: Integer); 
    procedure setActive(Active: Byte); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property ColorHex : String read FColorHex write FColorHex;
    property Description : String read FDescription write FDescription;
    property DisplayOrder : Integer read FDisplayOrder write FDisplayOrder;
    property Active : Byte read FActive write FActive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TColorsEntity = Array Of TColorsEntity;

  TControlEntity = class(TPersistent)
  private
    FCompanyID: String; 
    FCompanyName: String; 
    FAddress1: String; 
    FAddress2: String; 
    FAddress3: String; 
    FAddress4: String; 
    FCountry: String; 
    FFax: String; 
    FTelephone1: String; 
    FTelephone2: String; 
    FLastInvoice: Integer; 
    FLastReservation: Integer; 
    FLastPerson: Integer; 
    FLastRoomRes: Integer; 
    FMailHost: String; 
    FSmtpHost: String; 
    FEmailAddress: String; 
    FMailUser: String; 
    FMailPassword: String; 
    FMailMachineName: String; 
    FMailActive: Byte; 
    FWakeupMachineName: String; 
    FBreakFastItem: String; 
    FRoomRentItem: String; 
    FPaymentItem: String; 
    FPhoneUseItem: String; 
    FNativeCurrency: String; 
    FDiscountItem: String; 
    FBreakfastInclDefault: Byte; 
    FArrivalDateRulesPrice: Byte; 
    FLocalBreakfast: String; 
    FLocalTotal: String; 
    FLocalTotalPrice: String; 
    FLocalCurrencyRate: String; 
    FLocalRoomRent: String; 
    FLocalInvoice: String; 
    FLocalVAT: String; 
    FLocalCreditInvoice: String; 
    FGreenColor: String; 
    FPurpleColor: String; 
    FFuchsiaColor: String; 
    FReportDir: String; 
    FgrandRowheight: Integer; 
    FFiveDayDateformat2: String; 
    FFiveDayDateformat1: String; 
    FFiveDayPrompt: Integer; 
    FFiveDayRowHeight: Integer; 
    FFiveDayColWidth: Integer; 
    FFiveDayColCount: Integer; 
    FFiveDayFontSize: Integer; 
    FFiveDayFontName: String; 
    FInvoicePrinterMethod: Byte; 
    FCompanyBankInfo: String; 
    FCompanyVATNo: String; 
    FCompanyPID: String; 
    FCompanyHomePage: String; 
    FCompanyEmail: String; 
    FinvTxtCompanyVATId: String; 
    FinvTxtCompanyBankInfo: String; 
    FinvTxtCompanyPID: String; 
    FinvTxtCompanyHomePage: String; 
    FinvTxtCompanyEmail: String; 
    FinvTxtCompanyFax: String; 
    FinvTxtCompanyTel2: String; 
    FinvTxtCompanyTel1: String; 
    FinvTxtCompanyAddress: String; 
    FinvTxtCompanyName: String; 
    FinvTxtTotalTotal: String; 
    FinvTxtTotalVATAmount: String; 
    FinvTxtTotalwoVAT: String; 
    FinvTxtVATLineSeperator: String; 
    FinvTxtVATLineHead: String; 
    FinvTxtVATListTotal: String; 
    FinvTxtVATListVATAmount: String; 
    FinvTxtVATListVATpr: String; 
    FinvTxtVATListwVAT: String; 
    FinvTxtVATListwoVAT: String; 
    FinvTxtVATListDescription: String; 
    FinvTxtVATListHead: String; 
    FinvTxtPaymentLineSeperator: String; 
    FinvTxtPaymentLineHead: String; 
    FinvTxtPaymentListTotal: String; 
    FinvTxtPaymentListDate: String; 
    FinvTxtPaymentListAmount: String; 
    FinvTxtPaymentListCode: String; 
    FinvTxtPaymentListHead: String; 
    FinvTxtFooterLine4: String; 
    FinvTxtFooterLine3: String; 
    FinvTxtFooterLine2: String; 
    FinvTxtFooterLine1: String; 
    FinvTxtExtra2: String; 
    FinvTxtExtra1: String; 
    FinvTxtLinesItemTotal: String; 
    FinvTxtLinesItemAmount: String; 
    FinvTxtLinesItemPrice: String; 
    FinvTxtLinesItemCount: String; 
    FinvTxtLinesItemText: String; 
    FinvTxtLinesItemNo: String; 
    FinvTxtHeadInfoRoom: String; 
    FinvTxtHeadInfoGuest: String; 
    FinvTxtHeadInfoOrginalInfo: String; 
    FinvTxtHeadInfoCreditInvoice: String; 
    FinvTxtHeadInfoReservation: String; 
    FinvTxtHeadInfoCurrencyRate: String; 
    FinvTxtHeadInfoCurrency: String; 
    FinvTxtHeadInfoLocalCurrency: String; 
    FinvTxtHeadInfoEindagi: String; 
    FinvTxtHeadInfoGjalddagi: String; 
    FinvTxtHeadInfoCustomerNo: String; 
    FinvTxtHeadInfoDate: String; 
    FinvTxtHeadInfoNumber: String; 
    FinvTxtHeadKredit: String; 
    FinvTxtHeadDebit: String; 
    FNameOrder: Integer; 
    FinvEmailAddress: String; 
    FinvEmailDefaultPath: String; 
    FinvEmailExportNotPrintable: Byte; 
    FinvEmailFilename: String; 
    FinvEmailFromCompany: String; 
    FinvEmailFromMail: String; 
    FinvEmailFromName: String; 
    FinvEmailILines: String; 
    FinvEmailLogin: String; 
    FinvEmailPassword: String; 
    FinvEmailSignature: String; 
    FinvEmailSMTPhost: String; 
    FinvEmailSmtpPort: String; 
    FinvEmaiSubject: String; 
    FemailSMPTMailServer: String; 
    FemailSMPTport: Integer; 
    FemailSMPTuseLogin: Byte; 
    FemailSMPTUserName: String; 
    FemailSMPTPassword: String; 
    FemailSMPTThreaded: Byte; 
    FemailSMPTThreadPriority: Integer; 
    FemailSMPTWaitThread: Byte; 
    FemailSMPTTimeOut: Integer; 
    FemailContentcharset: String; 
    FemailContentType: Integer; 
    FemailSaveToFile: Byte; 
    FemailAgent: String; 
    FemailFromaddress: String; 
    FemailFromName: String; 
    FemailFromOrganization: String; 
    FemailFromReplayAddress: String; 
    FemailLogPath: String; 
    FsysDBbuild: Integer; 
    FSysDBSubVersion: Integer; 
    FsysDBversion: Integer; 
    FswINVhBatchNumber: Integer; 
    FswINVhINvoiceOrgin: Integer; 
    FswINVhInvoiceType: Integer; 
    FswCustsCurrCode: String; 
    FswCustiPriceType: Integer; 
    FswCustlDeliveryTermsFK: Integer; 
    FswCustCreditTerms: Integer; 
    FswCustiLanguage: Integer; 
    FswCustSalesPersonID: Integer; 
    FswCustiAccountFK: Integer; 
    FswCustGLnumberID: Integer; 
    FswCustCompanyID: Integer; 
    FAccountType: Integer; 
    FxmlDoExport: Byte; 
    FxmlPathinvoice: String; 
    FuseSetUnclean: Byte; 
    FnatSettings1: String; 
    FnatSettings2: String; 
    FnatSettings3: String; 
    FXmlDoExportInLocalCurrency: Byte; 
    FsnPath: String; 
    FSnFieldSeparator: String; 
    FinvPriceGroup: String; 
    FNameOrderPeriod: Integer; 
    FsnPathXML: String; 
    FstayTaxItem: String; 
    FuseStayTax: Byte; 
    FsnXMLencoding: String; 
    Fcolor01: String; 
    Fcolor02: String; 
    Fcolor03: String; 
    Fcolor04: String; 
    Fcolor05: String; 
    Fcolor06: String; 
    Fcolor07: String; 
    Fcolor08: String; 
    Fcolor09: String; 
    Fcolor10: String; 
    FStatusAttrGuestStaying: String; 
    FStatusAttrGuestLeavingNextDay: String; 
    FStatusAttrDeparted: String; 
    FStatusAttrAllotment: String; 
    FStatusAttrWaitinglist: String; 
    FStatusAttrNoShow: String; 
    FStatusAttrBlocked: String; 
    FStatusAttrDeparting: String; 
    FStatusAttrArrivingOtherLeaving: String; 
    FStatusAttrOrder: String; 
    FRackCustomer: String; 
    FinvTxtOriginal: String; 
    FinvTxtCopy: String; 
    FStayTaxIncluted: Byte; 
    FivhTxtTotalStayTax: String; 
    FivhTxtTotalStayTaxNights: String; 
    FcallType: Integer; 
    FcallLogInternal: Byte; 
    FcallMinSec: Integer; 
    FcallStartPrice: Double; 
    FcallMinUnits: Integer; 
    FcallMinPrice: Double; 
    FID: Integer; 
    FChannelManagerUsername: String; 
    FChannelManagerPassword: String; 
    FChannelManagerHotelCode: String; 
    FChannelManagerAdmin: String; 
    FChannelManagerAdminPassword: String; 
    FSessionTimeoutSeconds: Integer; 
    FbedChangeInterval: Integer; 
    FDefaultChannelId: Integer; 
    FDefaultChannelManager: Integer; 
    FExcluteWaitingList: Byte; 
    FExcluteAllotment: Byte; 
    FExcluteOrder: Byte; 
    FExcluteDeparted: Byte; 
    FExcluteGuest: Byte; 
    FExcluteNoshow: Byte; 
    FExcluteBlocked: Byte; 
    FlastUpdate: TTimeStamp; 
    FStatusAttrcanceled: String; 
    FStatusAttrTmp1: String; 
    FStatusAttrTmp2: String; 
    Fjson: String; 
  public
    procedure setCompanyID(CompanyID: String); 
    procedure setCompanyName(CompanyName: String); 
    procedure setAddress1(Address1: String); 
    procedure setAddress2(Address2: String); 
    procedure setAddress3(Address3: String); 
    procedure setAddress4(Address4: String); 
    procedure setCountry(Country: String); 
    procedure setFax(Fax: String); 
    procedure setTelephone1(Telephone1: String); 
    procedure setTelephone2(Telephone2: String); 
    procedure setLastInvoice(LastInvoice: Integer); 
    procedure setLastReservation(LastReservation: Integer); 
    procedure setLastPerson(LastPerson: Integer); 
    procedure setLastRoomRes(LastRoomRes: Integer); 
    procedure setMailHost(MailHost: String); 
    procedure setSmtpHost(SmtpHost: String); 
    procedure setEmailAddress(EmailAddress: String); 
    procedure setMailUser(MailUser: String); 
    procedure setMailPassword(MailPassword: String); 
    procedure setMailMachineName(MailMachineName: String); 
    procedure setMailActive(MailActive: Byte); 
    procedure setWakeupMachineName(WakeupMachineName: String); 
    procedure setBreakFastItem(BreakFastItem: String); 
    procedure setRoomRentItem(RoomRentItem: String); 
    procedure setPaymentItem(PaymentItem: String); 
    procedure setPhoneUseItem(PhoneUseItem: String); 
    procedure setNativeCurrency(NativeCurrency: String); 
    procedure setDiscountItem(DiscountItem: String); 
    procedure setBreakfastInclDefault(BreakfastInclDefault: Byte); 
    procedure setArrivalDateRulesPrice(ArrivalDateRulesPrice: Byte); 
    procedure setLocalBreakfast(LocalBreakfast: String); 
    procedure setLocalTotal(LocalTotal: String); 
    procedure setLocalTotalPrice(LocalTotalPrice: String); 
    procedure setLocalCurrencyRate(LocalCurrencyRate: String); 
    procedure setLocalRoomRent(LocalRoomRent: String); 
    procedure setLocalInvoice(LocalInvoice: String); 
    procedure setLocalVAT(LocalVAT: String); 
    procedure setLocalCreditInvoice(LocalCreditInvoice: String); 
    procedure setGreenColor(GreenColor: String); 
    procedure setPurpleColor(PurpleColor: String); 
    procedure setFuchsiaColor(FuchsiaColor: String); 
    procedure setReportDir(ReportDir: String); 
    procedure setGrandRowheight(grandRowheight: Integer); 
    procedure setFiveDayDateformat2(FiveDayDateformat2: String); 
    procedure setFiveDayDateformat1(FiveDayDateformat1: String); 
    procedure setFiveDayPrompt(FiveDayPrompt: Integer); 
    procedure setFiveDayRowHeight(FiveDayRowHeight: Integer); 
    procedure setFiveDayColWidth(FiveDayColWidth: Integer); 
    procedure setFiveDayColCount(FiveDayColCount: Integer); 
    procedure setFiveDayFontSize(FiveDayFontSize: Integer); 
    procedure setFiveDayFontName(FiveDayFontName: String); 
    procedure setInvoicePrinterMethod(InvoicePrinterMethod: Byte); 
    procedure setCompanyBankInfo(CompanyBankInfo: String); 
    procedure setCompanyVATNo(CompanyVATNo: String); 
    procedure setCompanyPID(CompanyPID: String); 
    procedure setCompanyHomePage(CompanyHomePage: String); 
    procedure setCompanyEmail(CompanyEmail: String); 
    procedure setInvTxtCompanyVATId(invTxtCompanyVATId: String); 
    procedure setInvTxtCompanyBankInfo(invTxtCompanyBankInfo: String); 
    procedure setInvTxtCompanyPID(invTxtCompanyPID: String); 
    procedure setInvTxtCompanyHomePage(invTxtCompanyHomePage: String); 
    procedure setInvTxtCompanyEmail(invTxtCompanyEmail: String); 
    procedure setInvTxtCompanyFax(invTxtCompanyFax: String); 
    procedure setInvTxtCompanyTel2(invTxtCompanyTel2: String); 
    procedure setInvTxtCompanyTel1(invTxtCompanyTel1: String); 
    procedure setInvTxtCompanyAddress(invTxtCompanyAddress: String); 
    procedure setInvTxtCompanyName(invTxtCompanyName: String); 
    procedure setInvTxtTotalTotal(invTxtTotalTotal: String); 
    procedure setInvTxtTotalVATAmount(invTxtTotalVATAmount: String); 
    procedure setInvTxtTotalwoVAT(invTxtTotalwoVAT: String); 
    procedure setInvTxtVATLineSeperator(invTxtVATLineSeperator: String); 
    procedure setInvTxtVATLineHead(invTxtVATLineHead: String); 
    procedure setInvTxtVATListTotal(invTxtVATListTotal: String); 
    procedure setInvTxtVATListVATAmount(invTxtVATListVATAmount: String); 
    procedure setInvTxtVATListVATpr(invTxtVATListVATpr: String); 
    procedure setInvTxtVATListwVAT(invTxtVATListwVAT: String); 
    procedure setInvTxtVATListwoVAT(invTxtVATListwoVAT: String); 
    procedure setInvTxtVATListDescription(invTxtVATListDescription: String); 
    procedure setInvTxtVATListHead(invTxtVATListHead: String); 
    procedure setInvTxtPaymentLineSeperator(invTxtPaymentLineSeperator: String); 
    procedure setInvTxtPaymentLineHead(invTxtPaymentLineHead: String); 
    procedure setInvTxtPaymentListTotal(invTxtPaymentListTotal: String); 
    procedure setInvTxtPaymentListDate(invTxtPaymentListDate: String); 
    procedure setInvTxtPaymentListAmount(invTxtPaymentListAmount: String); 
    procedure setInvTxtPaymentListCode(invTxtPaymentListCode: String); 
    procedure setInvTxtPaymentListHead(invTxtPaymentListHead: String); 
    procedure setInvTxtFooterLine4(invTxtFooterLine4: String); 
    procedure setInvTxtFooterLine3(invTxtFooterLine3: String); 
    procedure setInvTxtFooterLine2(invTxtFooterLine2: String); 
    procedure setInvTxtFooterLine1(invTxtFooterLine1: String); 
    procedure setInvTxtExtra2(invTxtExtra2: String); 
    procedure setInvTxtExtra1(invTxtExtra1: String); 
    procedure setInvTxtLinesItemTotal(invTxtLinesItemTotal: String); 
    procedure setInvTxtLinesItemAmount(invTxtLinesItemAmount: String); 
    procedure setInvTxtLinesItemPrice(invTxtLinesItemPrice: String); 
    procedure setInvTxtLinesItemCount(invTxtLinesItemCount: String); 
    procedure setInvTxtLinesItemText(invTxtLinesItemText: String); 
    procedure setInvTxtLinesItemNo(invTxtLinesItemNo: String); 
    procedure setInvTxtHeadInfoRoom(invTxtHeadInfoRoom: String); 
    procedure setInvTxtHeadInfoGuest(invTxtHeadInfoGuest: String); 
    procedure setInvTxtHeadInfoOrginalInfo(invTxtHeadInfoOrginalInfo: String); 
    procedure setInvTxtHeadInfoCreditInvoice(invTxtHeadInfoCreditInvoice: String); 
    procedure setInvTxtHeadInfoReservation(invTxtHeadInfoReservation: String); 
    procedure setInvTxtHeadInfoCurrencyRate(invTxtHeadInfoCurrencyRate: String); 
    procedure setInvTxtHeadInfoCurrency(invTxtHeadInfoCurrency: String); 
    procedure setInvTxtHeadInfoLocalCurrency(invTxtHeadInfoLocalCurrency: String); 
    procedure setInvTxtHeadInfoEindagi(invTxtHeadInfoEindagi: String); 
    procedure setInvTxtHeadInfoGjalddagi(invTxtHeadInfoGjalddagi: String); 
    procedure setInvTxtHeadInfoCustomerNo(invTxtHeadInfoCustomerNo: String); 
    procedure setInvTxtHeadInfoDate(invTxtHeadInfoDate: String); 
    procedure setInvTxtHeadInfoNumber(invTxtHeadInfoNumber: String); 
    procedure setInvTxtHeadKredit(invTxtHeadKredit: String); 
    procedure setInvTxtHeadDebit(invTxtHeadDebit: String); 
    procedure setNameOrder(NameOrder: Integer); 
    procedure setInvEmailAddress(invEmailAddress: String); 
    procedure setInvEmailDefaultPath(invEmailDefaultPath: String); 
    procedure setInvEmailExportNotPrintable(invEmailExportNotPrintable: Byte); 
    procedure setInvEmailFilename(invEmailFilename: String); 
    procedure setInvEmailFromCompany(invEmailFromCompany: String); 
    procedure setInvEmailFromMail(invEmailFromMail: String); 
    procedure setInvEmailFromName(invEmailFromName: String); 
    procedure setInvEmailILines(invEmailILines: String); 
    procedure setInvEmailLogin(invEmailLogin: String); 
    procedure setInvEmailPassword(invEmailPassword: String); 
    procedure setInvEmailSignature(invEmailSignature: String); 
    procedure setInvEmailSMTPhost(invEmailSMTPhost: String); 
    procedure setInvEmailSmtpPort(invEmailSmtpPort: String); 
    procedure setInvEmaiSubject(invEmaiSubject: String); 
    procedure setEmailSMPTMailServer(emailSMPTMailServer: String); 
    procedure setEmailSMPTport(emailSMPTport: Integer); 
    procedure setEmailSMPTuseLogin(emailSMPTuseLogin: Byte); 
    procedure setEmailSMPTUserName(emailSMPTUserName: String); 
    procedure setEmailSMPTPassword(emailSMPTPassword: String); 
    procedure setEmailSMPTThreaded(emailSMPTThreaded: Byte); 
    procedure setEmailSMPTThreadPriority(emailSMPTThreadPriority: Integer); 
    procedure setEmailSMPTWaitThread(emailSMPTWaitThread: Byte); 
    procedure setEmailSMPTTimeOut(emailSMPTTimeOut: Integer); 
    procedure setEmailContentcharset(emailContentcharset: String); 
    procedure setEmailContentType(emailContentType: Integer); 
    procedure setEmailSaveToFile(emailSaveToFile: Byte); 
    procedure setEmailAgent(emailAgent: String); 
    procedure setEmailFromaddress(emailFromaddress: String); 
    procedure setEmailFromName(emailFromName: String); 
    procedure setEmailFromOrganization(emailFromOrganization: String); 
    procedure setEmailFromReplayAddress(emailFromReplayAddress: String); 
    procedure setEmailLogPath(emailLogPath: String); 
    procedure setSysDBbuild(sysDBbuild: Integer); 
    procedure setSysDBSubVersion(SysDBSubVersion: Integer); 
    procedure setSysDBversion(sysDBversion: Integer); 
    procedure setSwINVhBatchNumber(swINVhBatchNumber: Integer); 
    procedure setSwINVhINvoiceOrgin(swINVhINvoiceOrgin: Integer); 
    procedure setSwINVhInvoiceType(swINVhInvoiceType: Integer); 
    procedure setSwCustsCurrCode(swCustsCurrCode: String); 
    procedure setSwCustiPriceType(swCustiPriceType: Integer); 
    procedure setSwCustlDeliveryTermsFK(swCustlDeliveryTermsFK: Integer); 
    procedure setSwCustCreditTerms(swCustCreditTerms: Integer); 
    procedure setSwCustiLanguage(swCustiLanguage: Integer); 
    procedure setSwCustSalesPersonID(swCustSalesPersonID: Integer); 
    procedure setSwCustiAccountFK(swCustiAccountFK: Integer); 
    procedure setSwCustGLnumberID(swCustGLnumberID: Integer); 
    procedure setSwCustCompanyID(swCustCompanyID: Integer); 
    procedure setAccountType(AccountType: Integer); 
    procedure setXmlDoExport(xmlDoExport: Byte); 
    procedure setXmlPathinvoice(xmlPathinvoice: String); 
    procedure setUseSetUnclean(useSetUnclean: Byte); 
    procedure setNatSettings1(natSettings1: String); 
    procedure setNatSettings2(natSettings2: String); 
    procedure setNatSettings3(natSettings3: String); 
    procedure setXmlDoExportInLocalCurrency(XmlDoExportInLocalCurrency: Byte); 
    procedure setSnPath(snPath: String); 
    procedure setSnFieldSeparator(SnFieldSeparator: String); 
    procedure setInvPriceGroup(invPriceGroup: String); 
    procedure setNameOrderPeriod(NameOrderPeriod: Integer); 
    procedure setSnPathXML(snPathXML: String); 
    procedure setStayTaxItem(stayTaxItem: String); 
    procedure setUseStayTax(useStayTax: Byte); 
    procedure setSnXMLencoding(snXMLencoding: String); 
    procedure setColor01(color01: String); 
    procedure setColor02(color02: String); 
    procedure setColor03(color03: String); 
    procedure setColor04(color04: String); 
    procedure setColor05(color05: String); 
    procedure setColor06(color06: String); 
    procedure setColor07(color07: String); 
    procedure setColor08(color08: String); 
    procedure setColor09(color09: String); 
    procedure setColor10(color10: String); 
    procedure setStatusAttrGuestStaying(StatusAttrGuestStaying: String); 
    procedure setStatusAttrGuestLeavingNextDay(StatusAttrGuestLeavingNextDay: String); 
    procedure setStatusAttrDeparted(StatusAttrDeparted: String); 
    procedure setStatusAttrAllotment(StatusAttrAllotment: String); 
    procedure setStatusAttrWaitinglist(StatusAttrWaitinglist: String); 
    procedure setStatusAttrNoShow(StatusAttrNoShow: String); 
    procedure setStatusAttrBlocked(StatusAttrBlocked: String); 
    procedure setStatusAttrDeparting(StatusAttrDeparting: String); 
    procedure setStatusAttrArrivingOtherLeaving(StatusAttrArrivingOtherLeaving: String); 
    procedure setStatusAttrOrder(StatusAttrOrder: String); 
    procedure setRackCustomer(RackCustomer: String); 
    procedure setInvTxtOriginal(invTxtOriginal: String); 
    procedure setInvTxtCopy(invTxtCopy: String); 
    procedure setStayTaxIncluted(StayTaxIncluted: Byte); 
    procedure setIvhTxtTotalStayTax(ivhTxtTotalStayTax: String); 
    procedure setIvhTxtTotalStayTaxNights(ivhTxtTotalStayTaxNights: String); 
    procedure setCallType(callType: Integer); 
    procedure setCallLogInternal(callLogInternal: Byte); 
    procedure setCallMinSec(callMinSec: Integer); 
    procedure setCallStartPrice(callStartPrice: Double); 
    procedure setCallMinUnits(callMinUnits: Integer); 
    procedure setCallMinPrice(callMinPrice: Double); 
    procedure setID(ID: Integer); 
    procedure setChannelManagerUsername(ChannelManagerUsername: String); 
    procedure setChannelManagerPassword(ChannelManagerPassword: String); 
    procedure setChannelManagerHotelCode(ChannelManagerHotelCode: String); 
    procedure setChannelManagerAdmin(ChannelManagerAdmin: String); 
    procedure setChannelManagerAdminPassword(ChannelManagerAdminPassword: String); 
    procedure setSessionTimeoutSeconds(SessionTimeoutSeconds: Integer); 
    procedure setBedChangeInterval(bedChangeInterval: Integer); 
    procedure setDefaultChannelId(DefaultChannelId: Integer); 
    procedure setDefaultChannelManager(DefaultChannelManager: Integer); 
    procedure setExcluteWaitingList(ExcluteWaitingList: Byte); 
    procedure setExcluteAllotment(ExcluteAllotment: Byte); 
    procedure setExcluteOrder(ExcluteOrder: Byte); 
    procedure setExcluteDeparted(ExcluteDeparted: Byte); 
    procedure setExcluteGuest(ExcluteGuest: Byte); 
    procedure setExcluteNoshow(ExcluteNoshow: Byte); 
    procedure setExcluteBlocked(ExcluteBlocked: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setStatusAttrcanceled(StatusAttrcanceled: String); 
    procedure setStatusAttrTmp1(StatusAttrTmp1: String); 
    procedure setStatusAttrTmp2(StatusAttrTmp2: String); 
    procedure setJson(json: String); 
  published
    property CompanyID : String read FCompanyID write FCompanyID;
    property CompanyName : String read FCompanyName write FCompanyName;
    property Address1 : String read FAddress1 write FAddress1;
    property Address2 : String read FAddress2 write FAddress2;
    property Address3 : String read FAddress3 write FAddress3;
    property Address4 : String read FAddress4 write FAddress4;
    property Country : String read FCountry write FCountry;
    property Fax : String read FFax write FFax;
    property Telephone1 : String read FTelephone1 write FTelephone1;
    property Telephone2 : String read FTelephone2 write FTelephone2;
    property LastInvoice : Integer read FLastInvoice write FLastInvoice;
    property LastReservation : Integer read FLastReservation write FLastReservation;
    property LastPerson : Integer read FLastPerson write FLastPerson;
    property LastRoomRes : Integer read FLastRoomRes write FLastRoomRes;
    property MailHost : String read FMailHost write FMailHost;
    property SmtpHost : String read FSmtpHost write FSmtpHost;
    property EmailAddress : String read FEmailAddress write FEmailAddress;
    property MailUser : String read FMailUser write FMailUser;
    property MailPassword : String read FMailPassword write FMailPassword;
    property MailMachineName : String read FMailMachineName write FMailMachineName;
    property MailActive : Byte read FMailActive write FMailActive;
    property WakeupMachineName : String read FWakeupMachineName write FWakeupMachineName;
    property BreakFastItem : String read FBreakFastItem write FBreakFastItem;
    property RoomRentItem : String read FRoomRentItem write FRoomRentItem;
    property PaymentItem : String read FPaymentItem write FPaymentItem;
    property PhoneUseItem : String read FPhoneUseItem write FPhoneUseItem;
    property NativeCurrency : String read FNativeCurrency write FNativeCurrency;
    property DiscountItem : String read FDiscountItem write FDiscountItem;
    property BreakfastInclDefault : Byte read FBreakfastInclDefault write FBreakfastInclDefault;
    property ArrivalDateRulesPrice : Byte read FArrivalDateRulesPrice write FArrivalDateRulesPrice;
    property LocalBreakfast : String read FLocalBreakfast write FLocalBreakfast;
    property LocalTotal : String read FLocalTotal write FLocalTotal;
    property LocalTotalPrice : String read FLocalTotalPrice write FLocalTotalPrice;
    property LocalCurrencyRate : String read FLocalCurrencyRate write FLocalCurrencyRate;
    property LocalRoomRent : String read FLocalRoomRent write FLocalRoomRent;
    property LocalInvoice : String read FLocalInvoice write FLocalInvoice;
    property LocalVAT : String read FLocalVAT write FLocalVAT;
    property LocalCreditInvoice : String read FLocalCreditInvoice write FLocalCreditInvoice;
    property GreenColor : String read FGreenColor write FGreenColor;
    property PurpleColor : String read FPurpleColor write FPurpleColor;
    property FuchsiaColor : String read FFuchsiaColor write FFuchsiaColor;
    property ReportDir : String read FReportDir write FReportDir;
    property grandRowheight : Integer read FgrandRowheight write FgrandRowheight;
    property FiveDayDateformat2 : String read FFiveDayDateformat2 write FFiveDayDateformat2;
    property FiveDayDateformat1 : String read FFiveDayDateformat1 write FFiveDayDateformat1;
    property FiveDayPrompt : Integer read FFiveDayPrompt write FFiveDayPrompt;
    property FiveDayRowHeight : Integer read FFiveDayRowHeight write FFiveDayRowHeight;
    property FiveDayColWidth : Integer read FFiveDayColWidth write FFiveDayColWidth;
    property FiveDayColCount : Integer read FFiveDayColCount write FFiveDayColCount;
    property FiveDayFontSize : Integer read FFiveDayFontSize write FFiveDayFontSize;
    property FiveDayFontName : String read FFiveDayFontName write FFiveDayFontName;
    property InvoicePrinterMethod : Byte read FInvoicePrinterMethod write FInvoicePrinterMethod;
    property CompanyBankInfo : String read FCompanyBankInfo write FCompanyBankInfo;
    property CompanyVATNo : String read FCompanyVATNo write FCompanyVATNo;
    property CompanyPID : String read FCompanyPID write FCompanyPID;
    property CompanyHomePage : String read FCompanyHomePage write FCompanyHomePage;
    property CompanyEmail : String read FCompanyEmail write FCompanyEmail;
    property invTxtCompanyVATId : String read FinvTxtCompanyVATId write FinvTxtCompanyVATId;
    property invTxtCompanyBankInfo : String read FinvTxtCompanyBankInfo write FinvTxtCompanyBankInfo;
    property invTxtCompanyPID : String read FinvTxtCompanyPID write FinvTxtCompanyPID;
    property invTxtCompanyHomePage : String read FinvTxtCompanyHomePage write FinvTxtCompanyHomePage;
    property invTxtCompanyEmail : String read FinvTxtCompanyEmail write FinvTxtCompanyEmail;
    property invTxtCompanyFax : String read FinvTxtCompanyFax write FinvTxtCompanyFax;
    property invTxtCompanyTel2 : String read FinvTxtCompanyTel2 write FinvTxtCompanyTel2;
    property invTxtCompanyTel1 : String read FinvTxtCompanyTel1 write FinvTxtCompanyTel1;
    property invTxtCompanyAddress : String read FinvTxtCompanyAddress write FinvTxtCompanyAddress;
    property invTxtCompanyName : String read FinvTxtCompanyName write FinvTxtCompanyName;
    property invTxtTotalTotal : String read FinvTxtTotalTotal write FinvTxtTotalTotal;
    property invTxtTotalVATAmount : String read FinvTxtTotalVATAmount write FinvTxtTotalVATAmount;
    property invTxtTotalwoVAT : String read FinvTxtTotalwoVAT write FinvTxtTotalwoVAT;
    property invTxtVATLineSeperator : String read FinvTxtVATLineSeperator write FinvTxtVATLineSeperator;
    property invTxtVATLineHead : String read FinvTxtVATLineHead write FinvTxtVATLineHead;
    property invTxtVATListTotal : String read FinvTxtVATListTotal write FinvTxtVATListTotal;
    property invTxtVATListVATAmount : String read FinvTxtVATListVATAmount write FinvTxtVATListVATAmount;
    property invTxtVATListVATpr : String read FinvTxtVATListVATpr write FinvTxtVATListVATpr;
    property invTxtVATListwVAT : String read FinvTxtVATListwVAT write FinvTxtVATListwVAT;
    property invTxtVATListwoVAT : String read FinvTxtVATListwoVAT write FinvTxtVATListwoVAT;
    property invTxtVATListDescription : String read FinvTxtVATListDescription write FinvTxtVATListDescription;
    property invTxtVATListHead : String read FinvTxtVATListHead write FinvTxtVATListHead;
    property invTxtPaymentLineSeperator : String read FinvTxtPaymentLineSeperator write FinvTxtPaymentLineSeperator;
    property invTxtPaymentLineHead : String read FinvTxtPaymentLineHead write FinvTxtPaymentLineHead;
    property invTxtPaymentListTotal : String read FinvTxtPaymentListTotal write FinvTxtPaymentListTotal;
    property invTxtPaymentListDate : String read FinvTxtPaymentListDate write FinvTxtPaymentListDate;
    property invTxtPaymentListAmount : String read FinvTxtPaymentListAmount write FinvTxtPaymentListAmount;
    property invTxtPaymentListCode : String read FinvTxtPaymentListCode write FinvTxtPaymentListCode;
    property invTxtPaymentListHead : String read FinvTxtPaymentListHead write FinvTxtPaymentListHead;
    property invTxtFooterLine4 : String read FinvTxtFooterLine4 write FinvTxtFooterLine4;
    property invTxtFooterLine3 : String read FinvTxtFooterLine3 write FinvTxtFooterLine3;
    property invTxtFooterLine2 : String read FinvTxtFooterLine2 write FinvTxtFooterLine2;
    property invTxtFooterLine1 : String read FinvTxtFooterLine1 write FinvTxtFooterLine1;
    property invTxtExtra2 : String read FinvTxtExtra2 write FinvTxtExtra2;
    property invTxtExtra1 : String read FinvTxtExtra1 write FinvTxtExtra1;
    property invTxtLinesItemTotal : String read FinvTxtLinesItemTotal write FinvTxtLinesItemTotal;
    property invTxtLinesItemAmount : String read FinvTxtLinesItemAmount write FinvTxtLinesItemAmount;
    property invTxtLinesItemPrice : String read FinvTxtLinesItemPrice write FinvTxtLinesItemPrice;
    property invTxtLinesItemCount : String read FinvTxtLinesItemCount write FinvTxtLinesItemCount;
    property invTxtLinesItemText : String read FinvTxtLinesItemText write FinvTxtLinesItemText;
    property invTxtLinesItemNo : String read FinvTxtLinesItemNo write FinvTxtLinesItemNo;
    property invTxtHeadInfoRoom : String read FinvTxtHeadInfoRoom write FinvTxtHeadInfoRoom;
    property invTxtHeadInfoGuest : String read FinvTxtHeadInfoGuest write FinvTxtHeadInfoGuest;
    property invTxtHeadInfoOrginalInfo : String read FinvTxtHeadInfoOrginalInfo write FinvTxtHeadInfoOrginalInfo;
    property invTxtHeadInfoCreditInvoice : String read FinvTxtHeadInfoCreditInvoice write FinvTxtHeadInfoCreditInvoice;
    property invTxtHeadInfoReservation : String read FinvTxtHeadInfoReservation write FinvTxtHeadInfoReservation;
    property invTxtHeadInfoCurrencyRate : String read FinvTxtHeadInfoCurrencyRate write FinvTxtHeadInfoCurrencyRate;
    property invTxtHeadInfoCurrency : String read FinvTxtHeadInfoCurrency write FinvTxtHeadInfoCurrency;
    property invTxtHeadInfoLocalCurrency : String read FinvTxtHeadInfoLocalCurrency write FinvTxtHeadInfoLocalCurrency;
    property invTxtHeadInfoEindagi : String read FinvTxtHeadInfoEindagi write FinvTxtHeadInfoEindagi;
    property invTxtHeadInfoGjalddagi : String read FinvTxtHeadInfoGjalddagi write FinvTxtHeadInfoGjalddagi;
    property invTxtHeadInfoCustomerNo : String read FinvTxtHeadInfoCustomerNo write FinvTxtHeadInfoCustomerNo;
    property invTxtHeadInfoDate : String read FinvTxtHeadInfoDate write FinvTxtHeadInfoDate;
    property invTxtHeadInfoNumber : String read FinvTxtHeadInfoNumber write FinvTxtHeadInfoNumber;
    property invTxtHeadKredit : String read FinvTxtHeadKredit write FinvTxtHeadKredit;
    property invTxtHeadDebit : String read FinvTxtHeadDebit write FinvTxtHeadDebit;
    property NameOrder : Integer read FNameOrder write FNameOrder;
    property invEmailAddress : String read FinvEmailAddress write FinvEmailAddress;
    property invEmailDefaultPath : String read FinvEmailDefaultPath write FinvEmailDefaultPath;
    property invEmailExportNotPrintable : Byte read FinvEmailExportNotPrintable write FinvEmailExportNotPrintable;
    property invEmailFilename : String read FinvEmailFilename write FinvEmailFilename;
    property invEmailFromCompany : String read FinvEmailFromCompany write FinvEmailFromCompany;
    property invEmailFromMail : String read FinvEmailFromMail write FinvEmailFromMail;
    property invEmailFromName : String read FinvEmailFromName write FinvEmailFromName;
    property invEmailILines : String read FinvEmailILines write FinvEmailILines;
    property invEmailLogin : String read FinvEmailLogin write FinvEmailLogin;
    property invEmailPassword : String read FinvEmailPassword write FinvEmailPassword;
    property invEmailSignature : String read FinvEmailSignature write FinvEmailSignature;
    property invEmailSMTPhost : String read FinvEmailSMTPhost write FinvEmailSMTPhost;
    property invEmailSmtpPort : String read FinvEmailSmtpPort write FinvEmailSmtpPort;
    property invEmaiSubject : String read FinvEmaiSubject write FinvEmaiSubject;
    property emailSMPTMailServer : String read FemailSMPTMailServer write FemailSMPTMailServer;
    property emailSMPTport : Integer read FemailSMPTport write FemailSMPTport;
    property emailSMPTuseLogin : Byte read FemailSMPTuseLogin write FemailSMPTuseLogin;
    property emailSMPTUserName : String read FemailSMPTUserName write FemailSMPTUserName;
    property emailSMPTPassword : String read FemailSMPTPassword write FemailSMPTPassword;
    property emailSMPTThreaded : Byte read FemailSMPTThreaded write FemailSMPTThreaded;
    property emailSMPTThreadPriority : Integer read FemailSMPTThreadPriority write FemailSMPTThreadPriority;
    property emailSMPTWaitThread : Byte read FemailSMPTWaitThread write FemailSMPTWaitThread;
    property emailSMPTTimeOut : Integer read FemailSMPTTimeOut write FemailSMPTTimeOut;
    property emailContentcharset : String read FemailContentcharset write FemailContentcharset;
    property emailContentType : Integer read FemailContentType write FemailContentType;
    property emailSaveToFile : Byte read FemailSaveToFile write FemailSaveToFile;
    property emailAgent : String read FemailAgent write FemailAgent;
    property emailFromaddress : String read FemailFromaddress write FemailFromaddress;
    property emailFromName : String read FemailFromName write FemailFromName;
    property emailFromOrganization : String read FemailFromOrganization write FemailFromOrganization;
    property emailFromReplayAddress : String read FemailFromReplayAddress write FemailFromReplayAddress;
    property emailLogPath : String read FemailLogPath write FemailLogPath;
    property sysDBbuild : Integer read FsysDBbuild write FsysDBbuild;
    property SysDBSubVersion : Integer read FSysDBSubVersion write FSysDBSubVersion;
    property sysDBversion : Integer read FsysDBversion write FsysDBversion;
    property swINVhBatchNumber : Integer read FswINVhBatchNumber write FswINVhBatchNumber;
    property swINVhINvoiceOrgin : Integer read FswINVhINvoiceOrgin write FswINVhINvoiceOrgin;
    property swINVhInvoiceType : Integer read FswINVhInvoiceType write FswINVhInvoiceType;
    property swCustsCurrCode : String read FswCustsCurrCode write FswCustsCurrCode;
    property swCustiPriceType : Integer read FswCustiPriceType write FswCustiPriceType;
    property swCustlDeliveryTermsFK : Integer read FswCustlDeliveryTermsFK write FswCustlDeliveryTermsFK;
    property swCustCreditTerms : Integer read FswCustCreditTerms write FswCustCreditTerms;
    property swCustiLanguage : Integer read FswCustiLanguage write FswCustiLanguage;
    property swCustSalesPersonID : Integer read FswCustSalesPersonID write FswCustSalesPersonID;
    property swCustiAccountFK : Integer read FswCustiAccountFK write FswCustiAccountFK;
    property swCustGLnumberID : Integer read FswCustGLnumberID write FswCustGLnumberID;
    property swCustCompanyID : Integer read FswCustCompanyID write FswCustCompanyID;
    property AccountType : Integer read FAccountType write FAccountType;
    property xmlDoExport : Byte read FxmlDoExport write FxmlDoExport;
    property xmlPathinvoice : String read FxmlPathinvoice write FxmlPathinvoice;
    property useSetUnclean : Byte read FuseSetUnclean write FuseSetUnclean;
    property natSettings1 : String read FnatSettings1 write FnatSettings1;
    property natSettings2 : String read FnatSettings2 write FnatSettings2;
    property natSettings3 : String read FnatSettings3 write FnatSettings3;
    property XmlDoExportInLocalCurrency : Byte read FXmlDoExportInLocalCurrency write FXmlDoExportInLocalCurrency;
    property snPath : String read FsnPath write FsnPath;
    property SnFieldSeparator : String read FSnFieldSeparator write FSnFieldSeparator;
    property invPriceGroup : String read FinvPriceGroup write FinvPriceGroup;
    property NameOrderPeriod : Integer read FNameOrderPeriod write FNameOrderPeriod;
    property snPathXML : String read FsnPathXML write FsnPathXML;
    property stayTaxItem : String read FstayTaxItem write FstayTaxItem;
    property useStayTax : Byte read FuseStayTax write FuseStayTax;
    property snXMLencoding : String read FsnXMLencoding write FsnXMLencoding;
    property color01 : String read Fcolor01 write Fcolor01;
    property color02 : String read Fcolor02 write Fcolor02;
    property color03 : String read Fcolor03 write Fcolor03;
    property color04 : String read Fcolor04 write Fcolor04;
    property color05 : String read Fcolor05 write Fcolor05;
    property color06 : String read Fcolor06 write Fcolor06;
    property color07 : String read Fcolor07 write Fcolor07;
    property color08 : String read Fcolor08 write Fcolor08;
    property color09 : String read Fcolor09 write Fcolor09;
    property color10 : String read Fcolor10 write Fcolor10;
    property StatusAttrGuestStaying : String read FStatusAttrGuestStaying write FStatusAttrGuestStaying;
    property StatusAttrGuestLeavingNextDay : String read FStatusAttrGuestLeavingNextDay write FStatusAttrGuestLeavingNextDay;
    property StatusAttrDeparted : String read FStatusAttrDeparted write FStatusAttrDeparted;
    property StatusAttrAllotment : String read FStatusAttrAllotment write FStatusAttrAllotment;
    property StatusAttrWaitinglist : String read FStatusAttrWaitinglist write FStatusAttrWaitinglist;
    property StatusAttrNoShow : String read FStatusAttrNoShow write FStatusAttrNoShow;
    property StatusAttrBlocked : String read FStatusAttrBlocked write FStatusAttrBlocked;
    property StatusAttrDeparting : String read FStatusAttrDeparting write FStatusAttrDeparting;
    property StatusAttrArrivingOtherLeaving : String read FStatusAttrArrivingOtherLeaving write FStatusAttrArrivingOtherLeaving;
    property StatusAttrOrder : String read FStatusAttrOrder write FStatusAttrOrder;
    property RackCustomer : String read FRackCustomer write FRackCustomer;
    property invTxtOriginal : String read FinvTxtOriginal write FinvTxtOriginal;
    property invTxtCopy : String read FinvTxtCopy write FinvTxtCopy;
    property StayTaxIncluted : Byte read FStayTaxIncluted write FStayTaxIncluted;
    property ivhTxtTotalStayTax : String read FivhTxtTotalStayTax write FivhTxtTotalStayTax;
    property ivhTxtTotalStayTaxNights : String read FivhTxtTotalStayTaxNights write FivhTxtTotalStayTaxNights;
    property callType : Integer read FcallType write FcallType;
    property callLogInternal : Byte read FcallLogInternal write FcallLogInternal;
    property callMinSec : Integer read FcallMinSec write FcallMinSec;
    property callStartPrice : Double read FcallStartPrice write FcallStartPrice;
    property callMinUnits : Integer read FcallMinUnits write FcallMinUnits;
    property callMinPrice : Double read FcallMinPrice write FcallMinPrice;
    property ID : Integer read FID write FID;
    property ChannelManagerUsername : String read FChannelManagerUsername write FChannelManagerUsername;
    property ChannelManagerPassword : String read FChannelManagerPassword write FChannelManagerPassword;
    property ChannelManagerHotelCode : String read FChannelManagerHotelCode write FChannelManagerHotelCode;
    property ChannelManagerAdmin : String read FChannelManagerAdmin write FChannelManagerAdmin;
    property ChannelManagerAdminPassword : String read FChannelManagerAdminPassword write FChannelManagerAdminPassword;
    property SessionTimeoutSeconds : Integer read FSessionTimeoutSeconds write FSessionTimeoutSeconds;
    property bedChangeInterval : Integer read FbedChangeInterval write FbedChangeInterval;
    property DefaultChannelId : Integer read FDefaultChannelId write FDefaultChannelId;
    property DefaultChannelManager : Integer read FDefaultChannelManager write FDefaultChannelManager;
    property ExcluteWaitingList : Byte read FExcluteWaitingList write FExcluteWaitingList;
    property ExcluteAllotment : Byte read FExcluteAllotment write FExcluteAllotment;
    property ExcluteOrder : Byte read FExcluteOrder write FExcluteOrder;
    property ExcluteDeparted : Byte read FExcluteDeparted write FExcluteDeparted;
    property ExcluteGuest : Byte read FExcluteGuest write FExcluteGuest;
    property ExcluteNoshow : Byte read FExcluteNoshow write FExcluteNoshow;
    property ExcluteBlocked : Byte read FExcluteBlocked write FExcluteBlocked;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property StatusAttrcanceled : String read FStatusAttrcanceled write FStatusAttrcanceled;
    property StatusAttrTmp1 : String read FStatusAttrTmp1 write FStatusAttrTmp1;
    property StatusAttrTmp2 : String read FStatusAttrTmp2 write FStatusAttrTmp2;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TControlEntity = Array Of TControlEntity;

  TCountriesEntity = class(TPersistent)
  private
    FCountry: String; 
    FCountryName: String; 
    FCurrency: String; 
    FCountryGroup: String; 
    FOrderIndex: Integer; 
    FIslCountryName: String; 
    FID: Integer; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setCountry(Country: String); 
    procedure setCountryName(CountryName: String); 
    procedure setCurrency(Currency: String); 
    procedure setCountryGroup(CountryGroup: String); 
    procedure setOrderIndex(OrderIndex: Integer); 
    procedure setIslCountryName(IslCountryName: String); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property Country : String read FCountry write FCountry;
    property CountryName : String read FCountryName write FCountryName;
    property Currency : String read FCurrency write FCurrency;
    property CountryGroup : String read FCountryGroup write FCountryGroup;
    property OrderIndex : Integer read FOrderIndex write FOrderIndex;
    property IslCountryName : String read FIslCountryName write FIslCountryName;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TCountriesEntity = Array Of TCountriesEntity;

  TCountrygroupsEntity = class(TPersistent)
  private
    FCountryGroup: String; 
    FGroupName: String; 
    FIslGroupName: String; 
    FOrderIndex: Integer; 
    FID: Integer; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setCountryGroup(CountryGroup: String); 
    procedure setGroupName(GroupName: String); 
    procedure setIslGroupName(IslGroupName: String); 
    procedure setOrderIndex(OrderIndex: Integer); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property CountryGroup : String read FCountryGroup write FCountryGroup;
    property GroupName : String read FGroupName write FGroupName;
    property IslGroupName : String read FIslGroupName write FIslGroupName;
    property OrderIndex : Integer read FOrderIndex write FOrderIndex;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TCountrygroupsEntity = Array Of TCountrygroupsEntity;

  TCurrenciesEntity = class(TPersistent)
  private
    FCurrency: String; 
    FDescription: String; 
    FAValue: Double; 
    FSellValue: Double; 
    FID: Integer; 
    FActive: Byte; 
    FCurrencySign: String; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setCurrency(Currency: String); 
    procedure setDescription(Description: String); 
    procedure setAValue(AValue: Double); 
    procedure setSellValue(SellValue: Double); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setCurrencySign(CurrencySign: String); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property Currency : String read FCurrency write FCurrency;
    property Description : String read FDescription write FDescription;
    property AValue : Double read FAValue write FAValue;
    property SellValue : Double read FSellValue write FSellValue;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property CurrencySign : String read FCurrencySign write FCurrencySign;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TCurrenciesEntity = Array Of TCurrenciesEntity;

  TCustomerpersonsEntity = class(TPersistent)
  private
    Fid: Integer; 
    FcustomerId: Integer; 
    FpersonId: Integer; 
    FpersonCode: String; 
    FauthKey: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setCustomerId(customerId: Integer); 
    procedure setPersonId(personId: Integer); 
    procedure setPersonCode(personCode: String); 
    procedure setAuthKey(authKey: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property customerId : Integer read FcustomerId write FcustomerId;
    property personId : Integer read FpersonId write FpersonId;
    property personCode : String read FpersonCode write FpersonCode;
    property authKey : String read FauthKey write FauthKey;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TCustomerpersonsEntity = Array Of TCustomerpersonsEntity;

  TCustomerpreferencesEntity = class(TPersistent)
  private
    FCustomer: String; 
    FDescription: String; 
    FPreference: String; 
    FID: Integer; 
    FActive: Byte; 
    Fjson: String; 
  public
    procedure setCustomer(Customer: String); 
    procedure setDescription(Description: String); 
    procedure setPreference(Preference: String); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setJson(json: String); 
  published
    property Customer : String read FCustomer write FCustomer;
    property Description : String read FDescription write FDescription;
    property Preference : String read FPreference write FPreference;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TCustomerpreferencesEntity = Array Of TCustomerpreferencesEntity;

  TCustomersEntity = class(TPersistent)
  private
    FCustomer: String; 
    FSurname: String; 
    FName: String; 
    FCustomerType: String; 
    FAddress1: String; 
    FAddress2: String; 
    FAddress3: String; 
    FAddress4: String; 
    FCountry: String; 
    FTel1: String; 
    FTel2: String; 
    FFax: String; 
    FDiscountPercent: Double; 
    FEmailAddress: String; 
    FContactPerson: String; 
    FTravelAgency: Byte; 
    FCurrency: String; 
    FPID: String; 
    Fdele: String; 
    FpcID: Integer; 
    FHomepage: String; 
    FID: Integer; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    FmarketSegment: String; 
    Fjson: String; 
  public
    procedure setCustomer(Customer: String); 
    procedure setSurname(Surname: String); 
    procedure setName(Name: String); 
    procedure setCustomerType(CustomerType: String); 
    procedure setAddress1(Address1: String); 
    procedure setAddress2(Address2: String); 
    procedure setAddress3(Address3: String); 
    procedure setAddress4(Address4: String); 
    procedure setCountry(Country: String); 
    procedure setTel1(Tel1: String); 
    procedure setTel2(Tel2: String); 
    procedure setFax(Fax: String); 
    procedure setDiscountPercent(DiscountPercent: Double); 
    procedure setEmailAddress(EmailAddress: String); 
    procedure setContactPerson(ContactPerson: String); 
    procedure setTravelAgency(TravelAgency: Byte); 
    procedure setCurrency(Currency: String); 
    procedure setPID(PID: String); 
    procedure setDele(dele: String); 
    procedure setPcID(pcID: Integer); 
    procedure setHomepage(Homepage: String); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setMarketSegment(marketSegment: String); 
    procedure setJson(json: String); 
  published
    property Customer : String read FCustomer write FCustomer;
    property Surname : String read FSurname write FSurname;
    property Name : String read FName write FName;
    property CustomerType : String read FCustomerType write FCustomerType;
    property Address1 : String read FAddress1 write FAddress1;
    property Address2 : String read FAddress2 write FAddress2;
    property Address3 : String read FAddress3 write FAddress3;
    property Address4 : String read FAddress4 write FAddress4;
    property Country : String read FCountry write FCountry;
    property Tel1 : String read FTel1 write FTel1;
    property Tel2 : String read FTel2 write FTel2;
    property Fax : String read FFax write FFax;
    property DiscountPercent : Double read FDiscountPercent write FDiscountPercent;
    property EmailAddress : String read FEmailAddress write FEmailAddress;
    property ContactPerson : String read FContactPerson write FContactPerson;
    property TravelAgency : Byte read FTravelAgency write FTravelAgency;
    property Currency : String read FCurrency write FCurrency;
    property PID : String read FPID write FPID;
    property dele : String read Fdele write Fdele;
    property pcID : Integer read FpcID write FpcID;
    property Homepage : String read FHomepage write FHomepage;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property marketSegment : String read FmarketSegment write FmarketSegment;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TCustomersEntity = Array Of TCustomersEntity;

  TCustomertypesEntity = class(TPersistent)
  private
    FCustomerType: String; 
    FDescription: String; 
    FPriority: Integer;
    FID: Integer; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setCustomerType(CustomerType: String); 
    procedure setDescription(Description: String); 
    procedure setPriority(Priority: Integer); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property CustomerType : String read FCustomerType write FCustomerType;
    property Description : String read FDescription write FDescription;
    property Priority : Integer read FPriority write FPriority;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TCustomertypesEntity = Array Of TCustomertypesEntity;

  TDictionaryEntity = class(TPersistent)
  private
    FID: Integer; 
    FCode: String; 
    FResult: String; 
    FLangId: Integer; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setCode(Code: String); 
    procedure setResult(Result: String);
    procedure setLangId(LangId: Integer); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property Code : String read FCode write FCode;
    property Result : String read FResult write FResult;
    property LangId : Integer read FLangId write FLangId;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TDictionaryEntity = Array Of TDictionaryEntity;

  TFacilityactiontypesEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fcode: String; 
    Fdescription: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setCode(code: String); 
    procedure setDescription(description: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property code : String read Fcode write Fcode;
    property description : String read Fdescription write Fdescription;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TFacilityactiontypesEntity = Array Of TFacilityactiontypesEntity;

  TFakenamesEntity = class(TPersistent)
  private
    FID: Integer; 
    Fgender: String;
    Ftitle: String; 
    Fgivenname: String; 
    Fsurname: String; 
    Fstreetaddress: String; 
    Fcity: String; 
    Fstate: String; 
    Fzipcode: String; 
    Fcountry: String; 
    Fcountryfull: String; 
    Femailaddress: String; 
    Ftelephonenumber: String; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setGender(gender: String); 
    procedure setTitle(title: String); 
    procedure setGivenname(givenname: String); 
    procedure setSurname(surname: String); 
    procedure setStreetaddress(streetaddress: String); 
    procedure setCity(city: String); 
    procedure setState(state: String); 
    procedure setZipcode(zipcode: String); 
    procedure setCountry(country: String); 
    procedure setCountryfull(countryfull: String); 
    procedure setEmailaddress(emailaddress: String); 
    procedure setTelephonenumber(telephonenumber: String); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property gender : String read Fgender write Fgender;
    property title : String read Ftitle write Ftitle;
    property givenname : String read Fgivenname write Fgivenname;
    property surname : String read Fsurname write Fsurname;
    property streetaddress : String read Fstreetaddress write Fstreetaddress;
    property city : String read Fcity write Fcity;
    property state : String read Fstate write Fstate;
    property zipcode : String read Fzipcode write Fzipcode;
    property country : String read Fcountry write Fcountry;
    property countryfull : String read Fcountryfull write Fcountryfull;
    property emailaddress : String read Femailaddress write Femailaddress;
    property telephonenumber : String read Ftelephonenumber write Ftelephonenumber;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TFakenamesEntity = Array Of TFakenamesEntity;

  THotelconfigurationsEntity = class(TPersistent)
  private
    Fid: Integer; 
    FforceExternalCustomerIdCorrectness: Byte; 
    FforceExternalProductIdCorrectness: Byte; 
    FforceExternalPaymentTypeIdCorrectness: Byte; 
    FexpensiveChannelsLevelFrom: Double; 
    FspringStarts: String; 
    FsummerStarts: String; 
    FautumnStarts: String; 
    FwinterStarts: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setForceExternalCustomerIdCorrectness(forceExternalCustomerIdCorrectness: Byte); 
    procedure setForceExternalProductIdCorrectness(forceExternalProductIdCorrectness: Byte); 
    procedure setForceExternalPaymentTypeIdCorrectness(forceExternalPaymentTypeIdCorrectness: Byte); 
    procedure setExpensiveChannelsLevelFrom(expensiveChannelsLevelFrom: Double); 
    procedure setSpringStarts(springStarts: String); 
    procedure setSummerStarts(summerStarts: String); 
    procedure setAutumnStarts(autumnStarts: String); 
    procedure setWinterStarts(winterStarts: String); 
    procedure setJson(json: String);
  published
    property id : Integer read Fid write Fid;
    property forceExternalCustomerIdCorrectness : Byte read FforceExternalCustomerIdCorrectness write FforceExternalCustomerIdCorrectness;
    property forceExternalProductIdCorrectness : Byte read FforceExternalProductIdCorrectness write FforceExternalProductIdCorrectness;
    property forceExternalPaymentTypeIdCorrectness : Byte read FforceExternalPaymentTypeIdCorrectness write FforceExternalPaymentTypeIdCorrectness;
    property expensiveChannelsLevelFrom : Double read FexpensiveChannelsLevelFrom write FexpensiveChannelsLevelFrom;
    property springStarts : String read FspringStarts write FspringStarts;
    property summerStarts : String read FsummerStarts write FsummerStarts;
    property autumnStarts : String read FautumnStarts write FautumnStarts;
    property winterStarts : String read FwinterStarts write FwinterStarts;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_THotelconfigurationsEntity = Array Of THotelconfigurationsEntity;

  THotelcontactsEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fcode: String; 
    Fdescription: String; 
    FcontactData: String; 
    FcontactType: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setCode(code: String); 
    procedure setDescription(description: String); 
    procedure setContactData(contactData: String); 
    procedure setContactType(contactType: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property code : String read Fcode write Fcode;
    property description : String read Fdescription write Fdescription;
    property contactData : String read FcontactData write FcontactData;
    property contactType : Integer read FcontactType write FcontactType;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_THotelcontactsEntity = Array Of THotelcontactsEntity;

  THotelcountersEntity = class(TPersistent)
  private
    Fid: Integer; 
    FlastReservation: Integer; 
    FlastRoomReservation: Integer; 
    FlastInvoiceNumber: Integer; 
    FlastInvoiceProcessed: Integer; 
    FlastPersonNumber: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setLastReservation(lastReservation: Integer); 
    procedure setLastRoomReservation(lastRoomReservation: Integer); 
    procedure setLastInvoiceNumber(lastInvoiceNumber: Integer); 
    procedure setLastInvoiceProcessed(lastInvoiceProcessed: Integer); 
    procedure setLastPersonNumber(lastPersonNumber: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property lastReservation : Integer read FlastReservation write FlastReservation;
    property lastRoomReservation : Integer read FlastRoomReservation write FlastRoomReservation;
    property lastInvoiceNumber : Integer read FlastInvoiceNumber write FlastInvoiceNumber;
    property lastInvoiceProcessed : Integer read FlastInvoiceProcessed write FlastInvoiceProcessed;
    property lastPersonNumber : Integer read FlastPersonNumber write FlastPersonNumber;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_THotelcountersEntity = Array Of THotelcountersEntity;

  THoteltasksEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fdate: TTimeStamp; 
    Froomstatus: Byte; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setDate(date: TTimeStamp); 
    procedure setRoomstatus(roomstatus: Byte); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property date : TTimeStamp read Fdate write Fdate;
    property roomstatus : Byte read Froomstatus write Froomstatus;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_THoteltasksEntity = Array Of THoteltasksEntity;

  TIdreferencesEntity = class(TPersistent)
  private
    Fid: Integer; 
    FBreakfastPackageClassId: Integer; 
    FBreakfastItemId: Integer; 
    FRoomRentItemId: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setBreakfastPackageClassId(BreakfastPackageClassId: Integer); 
    procedure setBreakfastItemId(BreakfastItemId: Integer); 
    procedure setRoomRentItemId(RoomRentItemId: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property BreakfastPackageClassId : Integer read FBreakfastPackageClassId write FBreakfastPackageClassId;
    property BreakfastItemId : Integer read FBreakfastItemId write FBreakfastItemId;
    property RoomRentItemId : Integer read FRoomRentItemId write FRoomRentItemId;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TIdreferencesEntity = Array Of TIdreferencesEntity;

  TIndustriesEntity = class(TPersistent)
  private
    Fid: Integer; 
    FlanguageFormType: String; 
    FlanguageCompName: String; 
    FextraIdentity: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setLanguageFormType(languageFormType: String); 
    procedure setLanguageCompName(languageCompName: String); 
    procedure setExtraIdentity(extraIdentity: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property languageFormType : String read FlanguageFormType write FlanguageFormType;
    property languageCompName : String read FlanguageCompName write FlanguageCompName;
    property extraIdentity : String read FextraIdentity write FextraIdentity;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TIndustriesEntity = Array Of TIndustriesEntity;

  TInvoiceheadsEntity = class(TPersistent)
  private
    FReservation: Integer; 
    FRoomReservation: Integer; 
    FSplitNumber: Integer; 
    FInvoiceNumber: Integer;
    FInvoiceDate: String; 
    FCustomer: String; 
    FName: String; 
    FAddress1: String; 
    FAddress2: String; 
    FAddress3: String; 
    FAddress4: String; 
    FCountry: String; 
    FTotal: Double; 
    FTotalWOVAT: Double; 
    FTotalVAT: Double; 
    FTotalBreakFast: Double; 
    FExtraText: String; 
    FFinished: Byte; 
    FReportDate: String; 
    FReportTime: String; 
    FCreditInvoice: Integer; 
    FOriginalInvoice: Integer; 
    FInvoiceType: Integer; 
    FihTmp: String; 
    FID: Integer; 
    FcustPID: String; 
    FRoomGuest: String; 
    FihDate: TTimeStamp; 
    FihStaff: String; 
    FihPayDate: TTimeStamp; 
    FihConfirmDate: TTimeStamp; 
    FihInvoiceDate: TTimeStamp; 
    FihCurrency: String; 
    FihCurrencyRate: Double; 
    FinvRefrence: String; 
    FTotalStayTax: Double; 
    FTotalStayTaxNights: Integer; 
    Fjson: String;
  public
    procedure setReservation(Reservation: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setSplitNumber(SplitNumber: Integer); 
    procedure setInvoiceNumber(InvoiceNumber: Integer); 
    procedure setInvoiceDate(InvoiceDate: String); 
    procedure setCustomer(Customer: String); 
    procedure setName(Name: String); 
    procedure setAddress1(Address1: String); 
    procedure setAddress2(Address2: String); 
    procedure setAddress3(Address3: String); 
    procedure setAddress4(Address4: String); 
    procedure setCountry(Country: String); 
    procedure setTotal(Total: Double); 
    procedure setTotalWOVAT(TotalWOVAT: Double); 
    procedure setTotalVAT(TotalVAT: Double); 
    procedure setTotalBreakFast(TotalBreakFast: Double); 
    procedure setExtraText(ExtraText: String); 
    procedure setFinished(Finished: Byte); 
    procedure setReportDate(ReportDate: String); 
    procedure setReportTime(ReportTime: String); 
    procedure setCreditInvoice(CreditInvoice: Integer); 
    procedure setOriginalInvoice(OriginalInvoice: Integer); 
    procedure setInvoiceType(InvoiceType: Integer); 
    procedure setIhTmp(ihTmp: String); 
    procedure setID(ID: Integer); 
    procedure setCustPID(custPID: String); 
    procedure setRoomGuest(RoomGuest: String); 
    procedure setIhDate(ihDate: TTimeStamp); 
    procedure setIhStaff(ihStaff: String); 
    procedure setIhPayDate(ihPayDate: TTimeStamp); 
    procedure setIhConfirmDate(ihConfirmDate: TTimeStamp); 
    procedure setIhInvoiceDate(ihInvoiceDate: TTimeStamp); 
    procedure setIhCurrency(ihCurrency: String);
    procedure setIhCurrencyRate(ihCurrencyRate: Double); 
    procedure setInvRefrence(invRefrence: String); 
    procedure setTotalStayTax(TotalStayTax: Double); 
    procedure setTotalStayTaxNights(TotalStayTaxNights: Integer); 
    procedure setJson(json: String); 
  published
    property Reservation : Integer read FReservation write FReservation;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property SplitNumber : Integer read FSplitNumber write FSplitNumber;
    property InvoiceNumber : Integer read FInvoiceNumber write FInvoiceNumber;
    property InvoiceDate : String read FInvoiceDate write FInvoiceDate;
    property Customer : String read FCustomer write FCustomer;
    property Name : String read FName write FName;
    property Address1 : String read FAddress1 write FAddress1;
    property Address2 : String read FAddress2 write FAddress2;
    property Address3 : String read FAddress3 write FAddress3;
    property Address4 : String read FAddress4 write FAddress4;
    property Country : String read FCountry write FCountry;
    property Total : Double read FTotal write FTotal;
    property TotalWOVAT : Double read FTotalWOVAT write FTotalWOVAT;
    property TotalVAT : Double read FTotalVAT write FTotalVAT;
    property TotalBreakFast : Double read FTotalBreakFast write FTotalBreakFast;
    property ExtraText : String read FExtraText write FExtraText;
    property Finished : Byte read FFinished write FFinished;
    property ReportDate : String read FReportDate write FReportDate;
    property ReportTime : String read FReportTime write FReportTime;
    property CreditInvoice : Integer read FCreditInvoice write FCreditInvoice;
    property OriginalInvoice : Integer read FOriginalInvoice write FOriginalInvoice;
    property InvoiceType : Integer read FInvoiceType write FInvoiceType;
    property ihTmp : String read FihTmp write FihTmp;
    property ID : Integer read FID write FID;
    property custPID : String read FcustPID write FcustPID;
    property RoomGuest : String read FRoomGuest write FRoomGuest;
    property ihDate : TTimeStamp read FihDate write FihDate;
    property ihStaff : String read FihStaff write FihStaff;
    property ihPayDate : TTimeStamp read FihPayDate write FihPayDate;
    property ihConfirmDate : TTimeStamp read FihConfirmDate write FihConfirmDate;
    property ihInvoiceDate : TTimeStamp read FihInvoiceDate write FihInvoiceDate;
    property ihCurrency : String read FihCurrency write FihCurrency;
    property ihCurrencyRate : Double read FihCurrencyRate write FihCurrencyRate;
    property invRefrence : String read FinvRefrence write FinvRefrence;
    property TotalStayTax : Double read FTotalStayTax write FTotalStayTax;
    property TotalStayTaxNights : Integer read FTotalStayTaxNights write FTotalStayTaxNights;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TInvoiceheadsEntity = Array Of TInvoiceheadsEntity;

  TInvoicelinesEntity = class(TPersistent)
  private
    FAutoGen: String; 
    FReservation: Integer; 
    FRoomReservation: Integer; 
    FSplitNumber: Integer; 
    FItemNumber: Integer; 
    FPurchaseDate: String; 
    FInvoiceNumber: Integer; 
    FItemID: String; 
    FNumber: Integer; 
    FDescription: String; 
    FPrice: Double; 
    FVATType: String; 
    FTotal: Double; 
    FTotalWOVat: Double; 
    FVat: Double; 
    FAutoGenerated: Byte; 
    FCurrencyRate: Double; 
    FCurrency: String; 
    FReportDate: String;
    FReportTime: String; 
    FPersons: Integer; 
    FNights: Integer; 
    FBreakfastPrice: Double; 
    FAyear: Integer; 
    FAmon: Integer; 
    FAday: Integer; 
    FilTmp: String; 
    FID: Integer; 
    FilAccountKey: String; 
    FItemCurrency: String; 
    FItemCurrencyRate: Double; 
    FDiscount: Double; 
    FDiscountisprecent: Byte; 
    FImportRefrence: String; 
    FImportSource: String; 
    FisPackage: Byte; 
    Fjson: String; 
  public
    procedure setAutoGen(AutoGen: String); 
    procedure setReservation(Reservation: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setSplitNumber(SplitNumber: Integer); 
    procedure setItemNumber(ItemNumber: Integer); 
    procedure setPurchaseDate(PurchaseDate: String); 
    procedure setInvoiceNumber(InvoiceNumber: Integer); 
    procedure setItemID(ItemID: String); 
    procedure setNumber(Number: Integer); 
    procedure setDescription(Description: String); 
    procedure setPrice(Price: Double); 
    procedure setVATType(VATType: String); 
    procedure setTotal(Total: Double); 
    procedure setTotalWOVat(TotalWOVat: Double); 
    procedure setVat(Vat: Double);
    procedure setAutoGenerated(AutoGenerated: Byte); 
    procedure setCurrencyRate(CurrencyRate: Double); 
    procedure setCurrency(Currency: String); 
    procedure setReportDate(ReportDate: String); 
    procedure setReportTime(ReportTime: String); 
    procedure setPersons(Persons: Integer); 
    procedure setNights(Nights: Integer); 
    procedure setBreakfastPrice(BreakfastPrice: Double); 
    procedure setAyear(Ayear: Integer); 
    procedure setAmon(Amon: Integer); 
    procedure setAday(Aday: Integer); 
    procedure setIlTmp(ilTmp: String); 
    procedure setID(ID: Integer); 
    procedure setIlAccountKey(ilAccountKey: String); 
    procedure setItemCurrency(ItemCurrency: String); 
    procedure setItemCurrencyRate(ItemCurrencyRate: Double); 
    procedure setDiscount(Discount: Double); 
    procedure setDiscountisprecent(Discountisprecent: Byte); 
    procedure setImportRefrence(ImportRefrence: String); 
    procedure setImportSource(ImportSource: String); 
    procedure setIsPackage(isPackage: Byte); 
    procedure setJson(json: String); 
  published
    property AutoGen : String read FAutoGen write FAutoGen;
    property Reservation : Integer read FReservation write FReservation;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property SplitNumber : Integer read FSplitNumber write FSplitNumber;
    property ItemNumber : Integer read FItemNumber write FItemNumber;
    property PurchaseDate : String read FPurchaseDate write FPurchaseDate;
    property InvoiceNumber : Integer read FInvoiceNumber write FInvoiceNumber;
    property ItemID : String read FItemID write FItemID;
    property Number : Integer read FNumber write FNumber;
    property Description : String read FDescription write FDescription;
    property Price : Double read FPrice write FPrice;
    property VATType : String read FVATType write FVATType;
    property Total : Double read FTotal write FTotal;
    property TotalWOVat : Double read FTotalWOVat write FTotalWOVat;
    property Vat : Double read FVat write FVat;
    property AutoGenerated : Byte read FAutoGenerated write FAutoGenerated;
    property CurrencyRate : Double read FCurrencyRate write FCurrencyRate;
    property Currency : String read FCurrency write FCurrency;
    property ReportDate : String read FReportDate write FReportDate;
    property ReportTime : String read FReportTime write FReportTime;
    property Persons : Integer read FPersons write FPersons;
    property Nights : Integer read FNights write FNights;
    property BreakfastPrice : Double read FBreakfastPrice write FBreakfastPrice;
    property Ayear : Integer read FAyear write FAyear;
    property Amon : Integer read FAmon write FAmon;
    property Aday : Integer read FAday write FAday;
    property ilTmp : String read FilTmp write FilTmp;
    property ID : Integer read FID write FID;
    property ilAccountKey : String read FilAccountKey write FilAccountKey;
    property ItemCurrency : String read FItemCurrency write FItemCurrency;
    property ItemCurrencyRate : Double read FItemCurrencyRate write FItemCurrencyRate;
    property Discount : Double read FDiscount write FDiscount;
    property Discountisprecent : Byte read FDiscountisprecent write FDiscountisprecent;
    property ImportRefrence : String read FImportRefrence write FImportRefrence;
    property ImportSource : String read FImportSource write FImportSource;
    property isPackage : Byte read FisPackage write FisPackage;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TInvoicelinesEntity = Array Of TInvoicelinesEntity;

  TInvoicelinestmpEntity = class(TPersistent)
  private
    FID: Integer; 
    FReservation: Integer; 
    FRoomReservation: Integer; 
    FSplitNumber: Integer; 
    FItemNumber: Integer; 
    FPurchaseDate: TTimeStamp; 
    FInvoiceNumber: Integer; 
    FItemID: String; 
    FNumber: Integer; 
    FDescription: String; 
    FPrice: Double; 
    FVATType: String; 
    FTotal: Double; 
    FTotalWOVat: Double; 
    FVat: Double; 
    FCurrencyRate: Double; 
    FCurrency: String; 
    FPersons: Integer; 
    FNights: Integer; 
    FBreakfastPrice: Double; 
    FdateCreated: TTimeStamp; 
    FilAccountKey: String; 
    FItemCurrency: String; 
    FDiscount: Double; 
    FDiscountisprecent: Byte; 
    FimportRefrence: String; 
    FImportSource: String; 
    FtmpType: Integer; 
    FtmpData: String; 
    FisPackage: Byte; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setSplitNumber(SplitNumber: Integer); 
    procedure setItemNumber(ItemNumber: Integer); 
    procedure setPurchaseDate(PurchaseDate: TTimeStamp); 
    procedure setInvoiceNumber(InvoiceNumber: Integer); 
    procedure setItemID(ItemID: String); 
    procedure setNumber(Number: Integer); 
    procedure setDescription(Description: String); 
    procedure setPrice(Price: Double); 
    procedure setVATType(VATType: String); 
    procedure setTotal(Total: Double); 
    procedure setTotalWOVat(TotalWOVat: Double); 
    procedure setVat(Vat: Double); 
    procedure setCurrencyRate(CurrencyRate: Double); 
    procedure setCurrency(Currency: String); 
    procedure setPersons(Persons: Integer); 
    procedure setNights(Nights: Integer); 
    procedure setBreakfastPrice(BreakfastPrice: Double); 
    procedure setDateCreated(dateCreated: TTimeStamp); 
    procedure setIlAccountKey(ilAccountKey: String); 
    procedure setItemCurrency(ItemCurrency: String); 
    procedure setDiscount(Discount: Double); 
    procedure setDiscountisprecent(Discountisprecent: Byte); 
    procedure setImportRefrence(importRefrence: String); 
    procedure setImportSource(ImportSource: String); 
    procedure setTmpType(tmpType: Integer); 
    procedure setTmpData(tmpData: String); 
    procedure setIsPackage(isPackage: Byte); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property Reservation : Integer read FReservation write FReservation;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property SplitNumber : Integer read FSplitNumber write FSplitNumber;
    property ItemNumber : Integer read FItemNumber write FItemNumber;
    property PurchaseDate : TTimeStamp read FPurchaseDate write FPurchaseDate;
    property InvoiceNumber : Integer read FInvoiceNumber write FInvoiceNumber;
    property ItemID : String read FItemID write FItemID;
    property Number : Integer read FNumber write FNumber;
    property Description : String read FDescription write FDescription;
    property Price : Double read FPrice write FPrice;
    property VATType : String read FVATType write FVATType;
    property Total : Double read FTotal write FTotal;
    property TotalWOVat : Double read FTotalWOVat write FTotalWOVat;
    property Vat : Double read FVat write FVat;
    property CurrencyRate : Double read FCurrencyRate write FCurrencyRate;
    property Currency : String read FCurrency write FCurrency;
    property Persons : Integer read FPersons write FPersons;
    property Nights : Integer read FNights write FNights;
    property BreakfastPrice : Double read FBreakfastPrice write FBreakfastPrice;
    property dateCreated : TTimeStamp read FdateCreated write FdateCreated;
    property ilAccountKey : String read FilAccountKey write FilAccountKey;
    property ItemCurrency : String read FItemCurrency write FItemCurrency;
    property Discount : Double read FDiscount write FDiscount;
    property Discountisprecent : Byte read FDiscountisprecent write FDiscountisprecent;
    property importRefrence : String read FimportRefrence write FimportRefrence;
    property ImportSource : String read FImportSource write FImportSource;
    property tmpType : Integer read FtmpType write FtmpType;
    property tmpData : String read FtmpData write FtmpData;
    property isPackage : Byte read FisPackage write FisPackage;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TInvoicelinestmpEntity = Array Of TInvoicelinestmpEntity;

  TItemsEntity = class(TPersistent)
  private
    FID: Integer; 
    FItem: String; 
    FActive: Byte; 
    FMinibarItem: Byte; 
    FDescription: String; 
    FPrice: Double; 
    FItemtype: String; 
    FAccountKey: String; 
    FHide: Byte; 
    FSystemItem: Byte; 
    FRoomRentitem: Byte; 
    FReservationItem: Byte; 
    FCurrency: String; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setItem(Item: String); 
    procedure setActive(Active: Byte); 
    procedure setMinibarItem(MinibarItem: Byte); 
    procedure setDescription(Description: String); 
    procedure setPrice(Price: Double); 
    procedure setItemtype(Itemtype: String); 
    procedure setAccountKey(AccountKey: String); 
    procedure setHide(Hide: Byte); 
    procedure setSystemItem(SystemItem: Byte); 
    procedure setRoomRentitem(RoomRentitem: Byte); 
    procedure setReservationItem(ReservationItem: Byte); 
    procedure setCurrency(Currency: String); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property Item : String read FItem write FItem;
    property Active : Byte read FActive write FActive;
    property MinibarItem : Byte read FMinibarItem write FMinibarItem;
    property Description : String read FDescription write FDescription;
    property Price : Double read FPrice write FPrice;
    property Itemtype : String read FItemtype write FItemtype;
    property AccountKey : String read FAccountKey write FAccountKey;
    property Hide : Byte read FHide write FHide;
    property SystemItem : Byte read FSystemItem write FSystemItem;
    property RoomRentitem : Byte read FRoomRentitem write FRoomRentitem;
    property ReservationItem : Byte read FReservationItem write FReservationItem;
    property Currency : String read FCurrency write FCurrency;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TItemsEntity = Array Of TItemsEntity;

  TItemtypesEntity = class(TPersistent)
  private
    FItemtype: String; 
    FDescription: String; 
    FVATCode: String; 
    FAccItemLink: String; 
    FID: Integer; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setItemtype(Itemtype: String); 
    procedure setDescription(Description: String); 
    procedure setVATCode(VATCode: String); 
    procedure setAccItemLink(AccItemLink: String); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property Itemtype : String read FItemtype write FItemtype;
    property Description : String read FDescription write FDescription;
    property VATCode : String read FVATCode write FVATCode;
    property AccItemLink : String read FAccItemLink write FAccItemLink;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TItemtypesEntity = Array Of TItemtypesEntity;

  TLocationsEntity = class(TPersistent)
  private
    FLocation: String; 
    FDescription: String; 
    FID: Integer; 
    FActive: Byte; 
    FChannelManager: Integer; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setLocation(Location: String); 
    procedure setDescription(Description: String); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setChannelManager(ChannelManager: Integer); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property Location : String read FLocation write FLocation;
    property Description : String read FDescription write FDescription;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property ChannelManager : Integer read FChannelManager write FChannelManager;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TLocationsEntity = Array Of TLocationsEntity;

  TMaintenancecodesEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fname: String; 
    Fcode: String; 
    Fcolor: String; 
    FselectionOrder: Integer; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setName(name: String); 
    procedure setCode(code: String); 
    procedure setColor(color: String); 
    procedure setSelectionOrder(selectionOrder: Integer); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property name : String read Fname write Fname;
    property code : String read Fcode write Fcode;
    property color : String read Fcolor write Fcolor;
    property selectionOrder : Integer read FselectionOrder write FselectionOrder;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TMaintenancecodesEntity = Array Of TMaintenancecodesEntity;

  TMaintenanceroomnotesEntity = class(TPersistent)
  private
    Fid: Integer; 
    FRoom: String; 
    FDateAndTime: TDateTime; 
    FActive: Byte; 
    FCleaningNotes: String; 
    FMaintenanceNotes: String; 
    FLostAndFound: String; 
    FstaffIdReported: Integer; 
    FstaffIdFixed: Integer; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setRoom(Room: String); 
    procedure setDateAndTime(DateAndTime: TDateTime); 
    procedure setActive(Active: Byte); 
    procedure setCleaningNotes(CleaningNotes: String); 
    procedure setMaintenanceNotes(MaintenanceNotes: String); 
    procedure setLostAndFound(LostAndFound: String); 
    procedure setStaffIdReported(staffIdReported: Integer); 
    procedure setStaffIdFixed(staffIdFixed: Integer); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property Room : String read FRoom write FRoom;
    property DateAndTime : TDateTime read FDateAndTime write FDateAndTime;
    property Active : Byte read FActive write FActive;
    property CleaningNotes : String read FCleaningNotes write FCleaningNotes;
    property MaintenanceNotes : String read FMaintenanceNotes write FMaintenanceNotes;
    property LostAndFound : String read FLostAndFound write FLostAndFound;
    property staffIdReported : Integer read FstaffIdReported write FstaffIdReported;
    property staffIdFixed : Integer read FstaffIdFixed write FstaffIdFixed;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TMaintenanceroomnotesEntity = Array Of TMaintenanceroomnotesEntity;

  TPackageclassesEntity = class(TPersistent)
  private
    Fid: Integer; 
    FDescription: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setDescription(Description: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property Description : String read FDescription write FDescription;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPackageclassesEntity = Array Of TPackageclassesEntity;

  TPackageitemsEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fdescription: String; 
    FpackageId: Integer; 
    FitemId: Integer; 
    FnumItems: Double; 
    FunitPrice: Double; 
    FnumItemsMethod: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setDescription(description: String); 
    procedure setPackageId(packageId: Integer); 
    procedure setItemId(itemId: Integer); 
    procedure setNumItems(numItems: Double); 
    procedure setUnitPrice(unitPrice: Double); 
    procedure setNumItemsMethod(numItemsMethod: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property description : String read Fdescription write Fdescription;
    property packageId : Integer read FpackageId write FpackageId;
    property itemId : Integer read FitemId write FitemId;
    property numItems : Double read FnumItems write FnumItems;
    property unitPrice : Double read FunitPrice write FunitPrice;
    property numItemsMethod : Integer read FnumItemsMethod write FnumItemsMethod;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPackageitemsEntity = Array Of TPackageitemsEntity;

  TPackagesEntity = class(TPersistent)
  private
    Fid: Integer; 
    FDescription: String; 
    FCode: String; 
    FshowItemsOnInvoice: Byte; 
    FActive: Byte; 
    FCurrencyID: Integer; 
    FlastUpdate: TTimeStamp; 
    FPackageClassId: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setDescription(Description: String); 
    procedure setCode(Code: String); 
    procedure setShowItemsOnInvoice(showItemsOnInvoice: Byte); 
    procedure setActive(Active: Byte); 
    procedure setCurrencyID(CurrencyID: Integer); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setPackageClassId(PackageClassId: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property Description : String read FDescription write FDescription;
    property Code : String read FCode write FCode;
    property showItemsOnInvoice : Byte read FshowItemsOnInvoice write FshowItemsOnInvoice;
    property Active : Byte read FActive write FActive;
    property CurrencyID : Integer read FCurrencyID write FCurrencyID;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property PackageClassId : Integer read FPackageClassId write FPackageClassId;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPackagesEntity = Array Of TPackagesEntity;

  TPackageusageEntity = class(TPersistent)
  private
    Fid: Integer; 
    FPackageId: Integer; 
    FRoomReservation: Integer; 
    FEventDate: TTimeStamp; 
    FPurchased: Byte; 
    FAlreadyAttended: Byte; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setPackageId(PackageId: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setEventDate(EventDate: TTimeStamp); 
    procedure setPurchased(Purchased: Byte); 
    procedure setAlreadyAttended(AlreadyAttended: Byte); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property PackageId : Integer read FPackageId write FPackageId;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property EventDate : TTimeStamp read FEventDate write FEventDate;
    property Purchased : Byte read FPurchased write FPurchased;
    property AlreadyAttended : Byte read FAlreadyAttended write FAlreadyAttended;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPackageusageEntity = Array Of TPackageusageEntity;

  TPaygroupsEntity = class(TPersistent)
  private
    FPayGroup: String; 
    FDescription: String; 
    FID: Integer; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setPayGroup(PayGroup: String); 
    procedure setDescription(Description: String); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property PayGroup : String read FPayGroup write FPayGroup;
    property Description : String read FDescription write FDescription;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPaygroupsEntity = Array Of TPaygroupsEntity;

  TPaymentsEntity = class(TPersistent)
  private
    FReservation: Integer; 
    FRoomReservation: Integer; 
    FPerson: Integer; 
    FAutoGen: String; 
    FTypeIndex: Integer; 
    FInvoiceNumber: Integer; 
    FPayDate: String; 
    FCustomer: String; 
    FPayType: String; 
    FAmount: Double; 
    FDescription: String; 
    FCurrencyRate: Double; 
    FCurrency: String; 
    FReportDate: String; 
    FReportTime: String; 
    FAyear: Integer; 
    FAmon: Integer; 
    FAday: Integer; 
    FpmTmp: String; 
    FID: Integer; 
    Fjson: String; 
  public
    procedure setReservation(Reservation: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setPerson(Person: Integer); 
    procedure setAutoGen(AutoGen: String); 
    procedure setTypeIndex(TypeIndex: Integer); 
    procedure setInvoiceNumber(InvoiceNumber: Integer); 
    procedure setPayDate(PayDate: String); 
    procedure setCustomer(Customer: String); 
    procedure setPayType(PayType: String); 
    procedure setAmount(Amount: Double); 
    procedure setDescription(Description: String); 
    procedure setCurrencyRate(CurrencyRate: Double); 
    procedure setCurrency(Currency: String); 
    procedure setReportDate(ReportDate: String); 
    procedure setReportTime(ReportTime: String); 
    procedure setAyear(Ayear: Integer); 
    procedure setAmon(Amon: Integer); 
    procedure setAday(Aday: Integer); 
    procedure setPmTmp(pmTmp: String); 
    procedure setID(ID: Integer); 
    procedure setJson(json: String); 
  published
    property Reservation : Integer read FReservation write FReservation;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Person : Integer read FPerson write FPerson;
    property AutoGen : String read FAutoGen write FAutoGen;
    property TypeIndex : Integer read FTypeIndex write FTypeIndex;
    property InvoiceNumber : Integer read FInvoiceNumber write FInvoiceNumber;
    property PayDate : String read FPayDate write FPayDate;
    property Customer : String read FCustomer write FCustomer;
    property PayType : String read FPayType write FPayType;
    property Amount : Double read FAmount write FAmount;
    property Description : String read FDescription write FDescription;
    property CurrencyRate : Double read FCurrencyRate write FCurrencyRate;
    property Currency : String read FCurrency write FCurrency;
    property ReportDate : String read FReportDate write FReportDate;
    property ReportTime : String read FReportTime write FReportTime;
    property Ayear : Integer read FAyear write FAyear;
    property Amon : Integer read FAmon write FAmon;
    property Aday : Integer read FAday write FAday;
    property pmTmp : String read FpmTmp write FpmTmp;
    property ID : Integer read FID write FID;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPaymentsEntity = Array Of TPaymentsEntity;

  TPaytypesEntity = class(TPersistent)
  private
    FPayType: String; 
    FDescription: String; 
    FPayGroup: String; 
    FAskCode: Byte; 
    FptDays: Integer; 
    FdoExport: Byte; 
    FID: Integer; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    FBookKey: String; 
    Fjson: String; 
  public
    procedure setPayType(PayType: String); 
    procedure setDescription(Description: String); 
    procedure setPayGroup(PayGroup: String); 
    procedure setAskCode(AskCode: Byte); 
    procedure setPtDays(ptDays: Integer); 
    procedure setDoExport(doExport: Byte); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setBookKey(BookKey: String); 
    procedure setJson(json: String); 
  published
    property PayType : String read FPayType write FPayType;
    property Description : String read FDescription write FDescription;
    property PayGroup : String read FPayGroup write FPayGroup;
    property AskCode : Byte read FAskCode write FAskCode;
    property ptDays : Integer read FptDays write FptDays;
    property doExport : Byte read FdoExport write FdoExport;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property BookKey : String read FBookKey write FBookKey;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPaytypesEntity = Array Of TPaytypesEntity;

  TPersonEntity = class(TPersistent)
  private
    Fid: Integer; 
    Factive: Byte; 
    FfirstName: String; 
    FmiddleName: String; 
    FlastName: String; 
    FfullName: String; 
    Fsalutation: String; 
    Fgender: Integer; 
    Fprofession: String; 
    Frole: String; 
    Fbirthday: TDateTime; 
    Fnationality: Integer; 
    Flanguage: Integer; 
    FpassportNumber: String; 
    FpersonDescription: String; 
    FpersonNotes: String; 
    FspouseName: String; 
    Fchildren: String; 
    FfamilyNotes: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setActive(active: Byte); 
    procedure setFirstName(firstName: String); 
    procedure setMiddleName(middleName: String); 
    procedure setLastName(lastName: String); 
    procedure setFullName(fullName: String); 
    procedure setSalutation(salutation: String); 
    procedure setGender(gender: Integer); 
    procedure setProfession(profession: String); 
    procedure setRole(role: String); 
    procedure setBirthday(birthday: TDateTime); 
    procedure setNationality(nationality: Integer); 
    procedure setLanguage(language: Integer); 
    procedure setPassportNumber(passportNumber: String); 
    procedure setPersonDescription(personDescription: String); 
    procedure setPersonNotes(personNotes: String); 
    procedure setSpouseName(spouseName: String); 
    procedure setChildren(children: String); 
    procedure setFamilyNotes(familyNotes: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property active : Byte read Factive write Factive;
    property firstName : String read FfirstName write FfirstName;
    property middleName : String read FmiddleName write FmiddleName;
    property lastName : String read FlastName write FlastName;
    property fullName : String read FfullName write FfullName;
    property salutation : String read Fsalutation write Fsalutation;
    property gender : Integer read Fgender write Fgender;
    property profession : String read Fprofession write Fprofession;
    property role : String read Frole write Frole;
    property birthday : TDateTime read Fbirthday write Fbirthday;
    property nationality : Integer read Fnationality write Fnationality;
    property language : Integer read Flanguage write Flanguage;
    property passportNumber : String read FpassportNumber write FpassportNumber;
    property personDescription : String read FpersonDescription write FpersonDescription;
    property personNotes : String read FpersonNotes write FpersonNotes;
    property spouseName : String read FspouseName write FspouseName;
    property children : String read Fchildren write Fchildren;
    property familyNotes : String read FfamilyNotes write FfamilyNotes;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPersonEntity = Array Of TPersonEntity;

  TPersonaddressEntity = class(TPersistent)
  private
    Fid: Integer; 
    FpersonId: Integer; 
    FsysType: Integer; 
    Faddress1: String; 
    Faddress2: String; 
    Fcity: String; 
    Fzip: String; 
    Fstate: String; 
    FcountryId: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setPersonId(personId: Integer); 
    procedure setSysType(sysType: Integer); 
    procedure setAddress1(address1: String); 
    procedure setAddress2(address2: String); 
    procedure setCity(city: String); 
    procedure setZip(zip: String); 
    procedure setState(state: String); 
    procedure setCountryId(countryId: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property personId : Integer read FpersonId write FpersonId;
    property sysType : Integer read FsysType write FsysType;
    property address1 : String read Faddress1 write Faddress1;
    property address2 : String read Faddress2 write Faddress2;
    property city : String read Fcity write Fcity;
    property zip : String read Fzip write Fzip;
    property state : String read Fstate write Fstate;
    property countryId : Integer read FcountryId write FcountryId;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPersonaddressEntity = Array Of TPersonaddressEntity;

  TPersonchildrenEntity = class(TPersistent)
  private
    Fid: Integer; 
    FpersonId: Integer; 
    Fname: String; 
    FchildPersonId: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setPersonId(personId: Integer); 
    procedure setName(name: String); 
    procedure setChildPersonId(childPersonId: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property personId : Integer read FpersonId write FpersonId;
    property name : String read Fname write Fname;
    property childPersonId : Integer read FchildPersonId write FchildPersonId;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPersonchildrenEntity = Array Of TPersonchildrenEntity;

  TPersoncontactEntity = class(TPersistent)
  private
    Fid: Integer; 
    FpersonId: Integer; 
    FcontactType: Integer; 
    Fdescription: String; 
    FcontactInfo: String; 
    FextraInfo: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setPersonId(personId: Integer); 
    procedure setContactType(contactType: Integer); 
    procedure setDescription(description: String); 
    procedure setContactInfo(contactInfo: String); 
    procedure setExtraInfo(extraInfo: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property personId : Integer read FpersonId write FpersonId;
    property contactType : Integer read FcontactType write FcontactType;
    property description : String read Fdescription write Fdescription;
    property contactInfo : String read FcontactInfo write FcontactInfo;
    property extraInfo : String read FextraInfo write FextraInfo;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPersoncontactEntity = Array Of TPersoncontactEntity;

  TPersoncontacttypeEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fcode: String; 
    Fdescription: String; 
    FsysType: Integer; 
    FActive: Byte; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setCode(code: String); 
    procedure setDescription(description: String); 
    procedure setSysType(sysType: Integer); 
    procedure setActive(Active: Byte); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property code : String read Fcode write Fcode;
    property description : String read Fdescription write Fdescription;
    property sysType : Integer read FsysType write FsysType;
    property Active : Byte read FActive write FActive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPersoncontacttypeEntity = Array Of TPersoncontacttypeEntity;

  TPersonitemsEntity = class(TPersistent)
  private
    Fid: Integer; 
    FpersonId: Integer; 
    FitemId: Integer; 
    FnumItems: Integer; 
    Fnotes: String; 
    Fprice: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setPersonId(personId: Integer); 
    procedure setItemId(itemId: Integer); 
    procedure setNumItems(numItems: Integer); 
    procedure setNotes(notes: String); 
    procedure setPrice(price: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property personId : Integer read FpersonId write FpersonId;
    property itemId : Integer read FitemId write FitemId;
    property numItems : Integer read FnumItems write FnumItems;
    property notes : String read Fnotes write Fnotes;
    property price : String read Fprice write Fprice;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPersonitemsEntity = Array Of TPersonitemsEntity;

  TPersonprofileEntity = class(TPersistent)
  private
    Fid: Integer; 
    FpersonId: Integer; 
    FvipType: Integer; 
    FvipNotification: Integer; 
    FdaysBefore: Integer; 
    FhoursBefore: Integer; 
    FminutesBefore: Integer; 
    FguestType: Integer; 
    Findustry: Integer; 
    FcompanyName: String; 
    Fdepartment: String; 
    Fcustomer: Integer; 
    FprefRoom: String; 
    FprefLocation: Integer; 
    FprefFloor: Integer; 
    FmailingList: Byte; 
    FitemsNotification: Integer; 
    Fnotes: String; 
    FnotesNotification: Integer; 
    Fcurrency: String; 
    FpayType: Integer; 
    FpayCardNumber: String; 
    FpayNameOnCard: String; 
    FpayExpireMonth: Integer; 
    FpayExpireYear: Integer; 
    FpayCVC: String; 
    FpayBillTo: String; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setPersonId(personId: Integer); 
    procedure setVipType(vipType: Integer); 
    procedure setVipNotification(vipNotification: Integer); 
    procedure setDaysBefore(daysBefore: Integer); 
    procedure setHoursBefore(hoursBefore: Integer); 
    procedure setMinutesBefore(minutesBefore: Integer); 
    procedure setGuestType(guestType: Integer); 
    procedure setIndustry(industry: Integer); 
    procedure setCompanyName(companyName: String); 
    procedure setDepartment(department: String); 
    procedure setCustomer(customer: Integer); 
    procedure setPrefRoom(prefRoom: String); 
    procedure setPrefLocation(prefLocation: Integer); 
    procedure setPrefFloor(prefFloor: Integer); 
    procedure setMailingList(mailingList: Byte); 
    procedure setItemsNotification(itemsNotification: Integer); 
    procedure setNotes(notes: String); 
    procedure setNotesNotification(notesNotification: Integer); 
    procedure setCurrency(currency: String); 
    procedure setPayType(payType: Integer); 
    procedure setPayCardNumber(payCardNumber: String); 
    procedure setPayNameOnCard(payNameOnCard: String); 
    procedure setPayExpireMonth(payExpireMonth: Integer); 
    procedure setPayExpireYear(payExpireYear: Integer); 
    procedure setPayCVC(payCVC: String); 
    procedure setPayBillTo(payBillTo: String); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property personId : Integer read FpersonId write FpersonId;
    property vipType : Integer read FvipType write FvipType;
    property vipNotification : Integer read FvipNotification write FvipNotification;
    property daysBefore : Integer read FdaysBefore write FdaysBefore;
    property hoursBefore : Integer read FhoursBefore write FhoursBefore;
    property minutesBefore : Integer read FminutesBefore write FminutesBefore;
    property guestType : Integer read FguestType write FguestType;
    property industry : Integer read Findustry write Findustry;
    property companyName : String read FcompanyName write FcompanyName;
    property department : String read Fdepartment write Fdepartment;
    property customer : Integer read Fcustomer write Fcustomer;
    property prefRoom : String read FprefRoom write FprefRoom;
    property prefLocation : Integer read FprefLocation write FprefLocation;
    property prefFloor : Integer read FprefFloor write FprefFloor;
    property mailingList : Byte read FmailingList write FmailingList;
    property itemsNotification : Integer read FitemsNotification write FitemsNotification;
    property notes : String read Fnotes write Fnotes;
    property notesNotification : Integer read FnotesNotification write FnotesNotification;
    property currency : String read Fcurrency write Fcurrency;
    property payType : Integer read FpayType write FpayType;
    property payCardNumber : String read FpayCardNumber write FpayCardNumber;
    property payNameOnCard : String read FpayNameOnCard write FpayNameOnCard;
    property payExpireMonth : Integer read FpayExpireMonth write FpayExpireMonth;
    property payExpireYear : Integer read FpayExpireYear write FpayExpireYear;
    property payCVC : String read FpayCVC write FpayCVC;
    property payBillTo : String read FpayBillTo write FpayBillTo;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPersonprofileEntity = Array Of TPersonprofileEntity;

  TPersonsEntity = class(TPersistent)
  private
    FPerson: Integer; 
    FRoomReservation: Integer; 
    FReservation: Integer; 
    Ftitle: String; 
    FName: String; 
    FSurname: String; 
    FAddress1: String; 
    FAddress2: String; 
    FAddress3: String; 
    FAddress4: String; 
    FCountry: String; 
    FCompany: String; 
    FTel1: String; 
    FTel2: String; 
    FFax: String; 
    FEmail: String; 
    FGuestType: String; 
    FInformation: String; 
    FPID: String; 
    FMainName: Byte; 
    FCustomer: String; 
    FpeTmp: String; 
    FID: Integer; 
    FHallReservation: Integer; 
    FhgrID: Integer; 
    Fstate: String; 
    FsourceId: String; 
    Fjson: String; 
  public
    procedure setPerson(Person: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setTitle(title: String); 
    procedure setName(Name: String); 
    procedure setSurname(Surname: String); 
    procedure setAddress1(Address1: String); 
    procedure setAddress2(Address2: String); 
    procedure setAddress3(Address3: String); 
    procedure setAddress4(Address4: String); 
    procedure setCountry(Country: String); 
    procedure setCompany(Company: String); 
    procedure setTel1(Tel1: String); 
    procedure setTel2(Tel2: String); 
    procedure setFax(Fax: String); 
    procedure setEmail(Email: String); 
    procedure setGuestType(GuestType: String); 
    procedure setInformation(Information: String); 
    procedure setPID(PID: String); 
    procedure setMainName(MainName: Byte); 
    procedure setCustomer(Customer: String); 
    procedure setPeTmp(peTmp: String); 
    procedure setID(ID: Integer); 
    procedure setHallReservation(HallReservation: Integer); 
    procedure setHgrID(hgrID: Integer); 
    procedure setState(state: String); 
    procedure setSourceId(sourceId: String); 
    procedure setJson(json: String); 
  published
    property Person : Integer read FPerson write FPerson;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Reservation : Integer read FReservation write FReservation;
    property title : String read Ftitle write Ftitle;
    property Name : String read FName write FName;
    property Surname : String read FSurname write FSurname;
    property Address1 : String read FAddress1 write FAddress1;
    property Address2 : String read FAddress2 write FAddress2;
    property Address3 : String read FAddress3 write FAddress3;
    property Address4 : String read FAddress4 write FAddress4;
    property Country : String read FCountry write FCountry;
    property Company : String read FCompany write FCompany;
    property Tel1 : String read FTel1 write FTel1;
    property Tel2 : String read FTel2 write FTel2;
    property Fax : String read FFax write FFax;
    property Email : String read FEmail write FEmail;
    property GuestType : String read FGuestType write FGuestType;
    property Information : String read FInformation write FInformation;
    property PID : String read FPID write FPID;
    property MainName : Byte read FMainName write FMainName;
    property Customer : String read FCustomer write FCustomer;
    property peTmp : String read FpeTmp write FpeTmp;
    property ID : Integer read FID write FID;
    property HallReservation : Integer read FHallReservation write FHallReservation;
    property hgrID : Integer read FhgrID write FhgrID;
    property state : String read Fstate write Fstate;
    property sourceId : String read FsourceId write FsourceId;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPersonsEntity = Array Of TPersonsEntity;

  TPersonviptypesEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fcode: String; 
    Fdescription: String; 
    FvipGrade: Integer; 
    FActive: Byte; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setCode(code: String); 
    procedure setDescription(description: String); 
    procedure setVipGrade(vipGrade: Integer); 
    procedure setActive(Active: Byte); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property code : String read Fcode write Fcode;
    property description : String read Fdescription write Fdescription;
    property vipGrade : Integer read FvipGrade write FvipGrade;
    property Active : Byte read FActive write FActive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPersonviptypesEntity = Array Of TPersonviptypesEntity;

  TPredefineddatesEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setDate(date: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property date : TTimeStamp read Fdate write Fdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPredefineddatesEntity = Array Of TPredefineddatesEntity;

  TPricerulesEntity = class(TPersistent)
  private
    FID: Integer; 
    FDescription: String; 
    FActive: Byte; 
    FApplyToDates: String; 
    FApplyToSeasons: String; 
    FApplyToRoomTypes: String; 
    FApplyToRoomGroups: String; 
    FApplyToRooms: String; 
    FRules: String; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setDescription(Description: String); 
    procedure setActive(Active: Byte); 
    procedure setApplyToDates(ApplyToDates: String); 
    procedure setApplyToSeasons(ApplyToSeasons: String); 
    procedure setApplyToRoomTypes(ApplyToRoomTypes: String); 
    procedure setApplyToRoomGroups(ApplyToRoomGroups: String); 
    procedure setApplyToRooms(ApplyToRooms: String); 
    procedure setRules(Rules: String); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property Description : String read FDescription write FDescription;
    property Active : Byte read FActive write FActive;
    property ApplyToDates : String read FApplyToDates write FApplyToDates;
    property ApplyToSeasons : String read FApplyToSeasons write FApplyToSeasons;
    property ApplyToRoomTypes : String read FApplyToRoomTypes write FApplyToRoomTypes;
    property ApplyToRoomGroups : String read FApplyToRoomGroups write FApplyToRoomGroups;
    property ApplyToRooms : String read FApplyToRooms write FApplyToRooms;
    property Rules : String read FRules write FRules;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPricerulesEntity = Array Of TPricerulesEntity;

  TPricerulespackagesEntity = class(TPersistent)
  private
    Fid: Integer; 
    FpriceRuleId: Integer; 
    FpackageId: Integer; 
    FnumPackages: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setPriceRuleId(priceRuleId: Integer); 
    procedure setPackageId(packageId: Integer); 
    procedure setNumPackages(numPackages: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property priceRuleId : Integer read FpriceRuleId write FpriceRuleId;
    property packageId : Integer read FpackageId write FpackageId;
    property numPackages : Integer read FnumPackages write FnumPackages;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPricerulespackagesEntity = Array Of TPricerulespackagesEntity;

  TPricetypesEntity = class(TPersistent)
  private
    FCurrency: String; 
    FDescription: String; 
    FPrice2Persons: Double; 
    FPrice1Person: Double; 
    FPriceExtraPerson: Double; 
    FRoomType: String; 
    FID: Integer; 
    FPrice3Persons: Double; 
    FPrice4Persons: Double; 
    FPrice5Persons: Double; 
    FPrice6Persons: Double; 
    FseID: Integer; 
    FpcID: Integer; 
    FRoundType: Integer; 
    FRoundStartAt: Integer; 
    FPriceType: String; 
    FActive: Byte; 
    Fjson: String; 
  public
    procedure setCurrency(Currency: String); 
    procedure setDescription(Description: String); 
    procedure setPrice2Persons(Price2Persons: Double); 
    procedure setPrice1Person(Price1Person: Double); 
    procedure setPriceExtraPerson(PriceExtraPerson: Double); 
    procedure setRoomType(RoomType: String); 
    procedure setID(ID: Integer); 
    procedure setPrice3Persons(Price3Persons: Double); 
    procedure setPrice4Persons(Price4Persons: Double); 
    procedure setPrice5Persons(Price5Persons: Double); 
    procedure setPrice6Persons(Price6Persons: Double); 
    procedure setSeID(seID: Integer); 
    procedure setPcID(pcID: Integer); 
    procedure setRoundType(RoundType: Integer); 
    procedure setRoundStartAt(RoundStartAt: Integer); 
    procedure setPriceType(PriceType: String); 
    procedure setActive(Active: Byte); 
    procedure setJson(json: String); 
  published
    property Currency : String read FCurrency write FCurrency;
    property Description : String read FDescription write FDescription;
    property Price2Persons : Double read FPrice2Persons write FPrice2Persons;
    property Price1Person : Double read FPrice1Person write FPrice1Person;
    property PriceExtraPerson : Double read FPriceExtraPerson write FPriceExtraPerson;
    property RoomType : String read FRoomType write FRoomType;
    property ID : Integer read FID write FID;
    property Price3Persons : Double read FPrice3Persons write FPrice3Persons;
    property Price4Persons : Double read FPrice4Persons write FPrice4Persons;
    property Price5Persons : Double read FPrice5Persons write FPrice5Persons;
    property Price6Persons : Double read FPrice6Persons write FPrice6Persons;
    property seID : Integer read FseID write FseID;
    property pcID : Integer read FpcID write FpcID;
    property RoundType : Integer read FRoundType write FRoundType;
    property RoundStartAt : Integer read FRoundStartAt write FRoundStartAt;
    property PriceType : String read FPriceType write FPriceType;
    property Active : Byte read FActive write FActive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPricetypesEntity = Array Of TPricetypesEntity;

  TPromocodesEntity = class(TPersistent)
  private
    Fid: Integer; 
    FpromoCode: String; 
    FvalidThrough: TDateTime; 
    FcreateDate: TDateTime; 
    FstaffId: Integer; 
    FvalidityPeriodFrom: TDateTime; 
    FvalidityPeriodThrough: TDateTime; 
    Fpercentage: Double; 
    Famount: Double; 
    FamountPerRoom: Double; 
    FmaxAmount: Double; 
    FroomTypes: String; 
    FroomClasses: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setPromoCode(promoCode: String); 
    procedure setValidThrough(validThrough: TDateTime); 
    procedure setCreateDate(createDate: TDateTime); 
    procedure setStaffId(staffId: Integer); 
    procedure setValidityPeriodFrom(validityPeriodFrom: TDateTime); 
    procedure setValidityPeriodThrough(validityPeriodThrough: TDateTime); 
    procedure setPercentage(percentage: Double); 
    procedure setAmount(amount: Double); 
    procedure setAmountPerRoom(amountPerRoom: Double); 
    procedure setMaxAmount(maxAmount: Double); 
    procedure setRoomTypes(roomTypes: String); 
    procedure setRoomClasses(roomClasses: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property promoCode : String read FpromoCode write FpromoCode;
    property validThrough : TDateTime read FvalidThrough write FvalidThrough;
    property createDate : TDateTime read FcreateDate write FcreateDate;
    property staffId : Integer read FstaffId write FstaffId;
    property validityPeriodFrom : TDateTime read FvalidityPeriodFrom write FvalidityPeriodFrom;
    property validityPeriodThrough : TDateTime read FvalidityPeriodThrough write FvalidityPeriodThrough;
    property percentage : Double read Fpercentage write Fpercentage;
    property amount : Double read Famount write Famount;
    property amountPerRoom : Double read FamountPerRoom write FamountPerRoom;
    property maxAmount : Double read FmaxAmount write FmaxAmount;
    property roomTypes : String read FroomTypes write FroomTypes;
    property roomClasses : String read FroomClasses write FroomClasses;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPromocodesEntity = Array Of TPromocodesEntity;

  TPropertiesstoreEntity = class(TPersistent)
  private
    FID: Integer; 
    FDescription: String; 
    FAccessLevel: Integer; 
    FAccessOwner: String; 
    FFormName: String; 
    FStoreType: String; 
    FStoreName: String; 
    FTextContainer1: String; 
    FTextContainer2: String; 
    FStringContainer1: String; 
    FStringContainer2: String; 
    FStringContainer3: String; 
    FActive: Byte; 
    FisDefault: Byte; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setDescription(Description: String); 
    procedure setAccessLevel(AccessLevel: Integer); 
    procedure setAccessOwner(AccessOwner: String); 
    procedure setFormName(FormName: String); 
    procedure setStoreType(StoreType: String); 
    procedure setStoreName(StoreName: String); 
    procedure setTextContainer1(TextContainer1: String); 
    procedure setTextContainer2(TextContainer2: String); 
    procedure setStringContainer1(StringContainer1: String); 
    procedure setStringContainer2(StringContainer2: String); 
    procedure setStringContainer3(StringContainer3: String); 
    procedure setActive(Active: Byte); 
    procedure setIsDefault(isDefault: Byte); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property Description : String read FDescription write FDescription;
    property AccessLevel : Integer read FAccessLevel write FAccessLevel;
    property AccessOwner : String read FAccessOwner write FAccessOwner;
    property FormName : String read FFormName write FFormName;
    property StoreType : String read FStoreType write FStoreType;
    property StoreName : String read FStoreName write FStoreName;
    property TextContainer1 : String read FTextContainer1 write FTextContainer1;
    property TextContainer2 : String read FTextContainer2 write FTextContainer2;
    property StringContainer1 : String read FStringContainer1 write FStringContainer1;
    property StringContainer2 : String read FStringContainer2 write FStringContainer2;
    property StringContainer3 : String read FStringContainer3 write FStringContainer3;
    property Active : Byte read FActive write FActive;
    property isDefault : Byte read FisDefault write FisDefault;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TPropertiesstoreEntity = Array Of TPropertiesstoreEntity;

  TRatesEntity = class(TPersistent)
  private
    FID: Integer; 
    FActive: Byte; 
    FCurrency: String; 
    FRate1Person: Double; 
    FRate2Persons: Double; 
    FRate3Persons: Double; 
    FRate4Persons: Double; 
    FRate5Persons: Double; 
    FRate6Persons: Double; 
    FRateExtraPerson: Double; 
    FRateExtraChildren: Double; 
    FRateExtraInfant: Double; 
    FDateCreated: TTimeStamp; 
    FLastModified: TTimeStamp; 
    FDescription: String; 
    FisDefault: Byte; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setCurrency(Currency: String); 
    procedure setRate1Person(Rate1Person: Double); 
    procedure setRate2Persons(Rate2Persons: Double); 
    procedure setRate3Persons(Rate3Persons: Double); 
    procedure setRate4Persons(Rate4Persons: Double); 
    procedure setRate5Persons(Rate5Persons: Double); 
    procedure setRate6Persons(Rate6Persons: Double); 
    procedure setRateExtraPerson(RateExtraPerson: Double); 
    procedure setRateExtraChildren(RateExtraChildren: Double); 
    procedure setRateExtraInfant(RateExtraInfant: Double); 
    procedure setDateCreated(DateCreated: TTimeStamp); 
    procedure setLastModified(LastModified: TTimeStamp); 
    procedure setDescription(Description: String); 
    procedure setIsDefault(isDefault: Byte); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property Currency : String read FCurrency write FCurrency;
    property Rate1Person : Double read FRate1Person write FRate1Person;
    property Rate2Persons : Double read FRate2Persons write FRate2Persons;
    property Rate3Persons : Double read FRate3Persons write FRate3Persons;
    property Rate4Persons : Double read FRate4Persons write FRate4Persons;
    property Rate5Persons : Double read FRate5Persons write FRate5Persons;
    property Rate6Persons : Double read FRate6Persons write FRate6Persons;
    property RateExtraPerson : Double read FRateExtraPerson write FRateExtraPerson;
    property RateExtraChildren : Double read FRateExtraChildren write FRateExtraChildren;
    property RateExtraInfant : Double read FRateExtraInfant write FRateExtraInfant;
    property DateCreated : TTimeStamp read FDateCreated write FDateCreated;
    property LastModified : TTimeStamp read FLastModified write FLastModified;
    property Description : String read FDescription write FDescription;
    property isDefault : Byte read FisDefault write FisDefault;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRatesEntity = Array Of TRatesEntity;

  TReservationsEntity = class(TPersistent)
  private
    FReservation: Integer; 
    FArrival: String; 
    FDeparture: String; 
    FCustomer: String; 
    FName: String; 
    FAddress1: String; 
    FAddress2: String; 
    FAddress3: String; 
    FAddress4: String; 
    FCountry: String; 
    FTel1: String; 
    FTel2: String; 
    FFax: String; 
    FStatus: String; 
    FReservationDate: String; 
    FStaff: String; 
    FInformation: String; 
    FPMInfo: String; 
    FHiddenInfo: String; 
    FRoomRentPaid1: Double; 
    FRoomRentPaid2: Double; 
    FRoomRentPaid3: Double; 
    FRoomRentPaymentInvoice: Integer; 
    FContactName: String; 
    FContactPhone: String; 
    FContactPhone2: String; 
    FContactFax: String; 
    FContactAddress1: String; 
    FContactAddress2: String; 
    FContactAddress3: String; 
    FContactAddress4: String; 
    FContactCountry: String; 
    FContactEmail: String; 
    Finputsource: String; 
    Fwebconfirmed: String; 
    Farrivaltime: String; 
    Fsrcrequest: String; 
    FrvTmp: String; 
    FID: Integer; 
    FCustPID: String; 
    FinvRefrence: String; 
    FmarketSegment: String; 
    FCustomerEmail: String; 
    FCustomerWebsite: String; 
    FuseStayTax: Byte; 
    Fchannel: Integer; 
    FeventsProcessed: Byte; 
    FalteredReservation: Byte; 
    FexternalIds: String; 
    FdtCreated: TTimeStamp; 
    Fjson: String; 
  public
    procedure setReservation(Reservation: Integer); 
    procedure setArrival(Arrival: String); 
    procedure setDeparture(Departure: String); 
    procedure setCustomer(Customer: String); 
    procedure setName(Name: String); 
    procedure setAddress1(Address1: String); 
    procedure setAddress2(Address2: String); 
    procedure setAddress3(Address3: String); 
    procedure setAddress4(Address4: String); 
    procedure setCountry(Country: String); 
    procedure setTel1(Tel1: String); 
    procedure setTel2(Tel2: String); 
    procedure setFax(Fax: String); 
    procedure setStatus(Status: String); 
    procedure setReservationDate(ReservationDate: String); 
    procedure setStaff(Staff: String); 
    procedure setInformation(Information: String); 
    procedure setPMInfo(PMInfo: String); 
    procedure setHiddenInfo(HiddenInfo: String); 
    procedure setRoomRentPaid1(RoomRentPaid1: Double); 
    procedure setRoomRentPaid2(RoomRentPaid2: Double); 
    procedure setRoomRentPaid3(RoomRentPaid3: Double); 
    procedure setRoomRentPaymentInvoice(RoomRentPaymentInvoice: Integer); 
    procedure setContactName(ContactName: String); 
    procedure setContactPhone(ContactPhone: String); 
    procedure setContactPhone2(ContactPhone2: String); 
    procedure setContactFax(ContactFax: String); 
    procedure setContactAddress1(ContactAddress1: String); 
    procedure setContactAddress2(ContactAddress2: String); 
    procedure setContactAddress3(ContactAddress3: String); 
    procedure setContactAddress4(ContactAddress4: String); 
    procedure setContactCountry(ContactCountry: String); 
    procedure setContactEmail(ContactEmail: String); 
    procedure setInputsource(inputsource: String); 
    procedure setWebconfirmed(webconfirmed: String); 
    procedure setArrivaltime(arrivaltime: String); 
    procedure setSrcrequest(srcrequest: String); 
    procedure setRvTmp(rvTmp: String); 
    procedure setID(ID: Integer); 
    procedure setCustPID(CustPID: String); 
    procedure setInvRefrence(invRefrence: String); 
    procedure setMarketSegment(marketSegment: String); 
    procedure setCustomerEmail(CustomerEmail: String); 
    procedure setCustomerWebsite(CustomerWebsite: String); 
    procedure setUseStayTax(useStayTax: Byte); 
    procedure setChannel(channel: Integer); 
    procedure setEventsProcessed(eventsProcessed: Byte); 
    procedure setAlteredReservation(alteredReservation: Byte); 
    procedure setExternalIds(externalIds: String); 
    procedure setDtCreated(dtCreated: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property Reservation : Integer read FReservation write FReservation;
    property Arrival : String read FArrival write FArrival;
    property Departure : String read FDeparture write FDeparture;
    property Customer : String read FCustomer write FCustomer;
    property Name : String read FName write FName;
    property Address1 : String read FAddress1 write FAddress1;
    property Address2 : String read FAddress2 write FAddress2;
    property Address3 : String read FAddress3 write FAddress3;
    property Address4 : String read FAddress4 write FAddress4;
    property Country : String read FCountry write FCountry;
    property Tel1 : String read FTel1 write FTel1;
    property Tel2 : String read FTel2 write FTel2;
    property Fax : String read FFax write FFax;
    property Status : String read FStatus write FStatus;
    property ReservationDate : String read FReservationDate write FReservationDate;
    property Staff : String read FStaff write FStaff;
    property Information : String read FInformation write FInformation;
    property PMInfo : String read FPMInfo write FPMInfo;
    property HiddenInfo : String read FHiddenInfo write FHiddenInfo;
    property RoomRentPaid1 : Double read FRoomRentPaid1 write FRoomRentPaid1;
    property RoomRentPaid2 : Double read FRoomRentPaid2 write FRoomRentPaid2;
    property RoomRentPaid3 : Double read FRoomRentPaid3 write FRoomRentPaid3;
    property RoomRentPaymentInvoice : Integer read FRoomRentPaymentInvoice write FRoomRentPaymentInvoice;
    property ContactName : String read FContactName write FContactName;
    property ContactPhone : String read FContactPhone write FContactPhone;
    property ContactPhone2 : String read FContactPhone2 write FContactPhone2;
    property ContactFax : String read FContactFax write FContactFax;
    property ContactAddress1 : String read FContactAddress1 write FContactAddress1;
    property ContactAddress2 : String read FContactAddress2 write FContactAddress2;
    property ContactAddress3 : String read FContactAddress3 write FContactAddress3;
    property ContactAddress4 : String read FContactAddress4 write FContactAddress4;
    property ContactCountry : String read FContactCountry write FContactCountry;
    property ContactEmail : String read FContactEmail write FContactEmail;
    property inputsource : String read Finputsource write Finputsource;
    property webconfirmed : String read Fwebconfirmed write Fwebconfirmed;
    property arrivaltime : String read Farrivaltime write Farrivaltime;
    property srcrequest : String read Fsrcrequest write Fsrcrequest;
    property rvTmp : String read FrvTmp write FrvTmp;
    property ID : Integer read FID write FID;
    property CustPID : String read FCustPID write FCustPID;
    property invRefrence : String read FinvRefrence write FinvRefrence;
    property marketSegment : String read FmarketSegment write FmarketSegment;
    property CustomerEmail : String read FCustomerEmail write FCustomerEmail;
    property CustomerWebsite : String read FCustomerWebsite write FCustomerWebsite;
    property useStayTax : Byte read FuseStayTax write FuseStayTax;
    property channel : Integer read Fchannel write Fchannel;
    property eventsProcessed : Byte read FeventsProcessed write FeventsProcessed;
    property alteredReservation : Byte read FalteredReservation write FalteredReservation;
    property externalIds : String read FexternalIds write FexternalIds;
    property dtCreated : TTimeStamp read FdtCreated write FdtCreated;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TReservationsEntity = Array Of TReservationsEntity;

  TRoomamenitiesEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fcode: String; 
    Fdescription: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setCode(code: String); 
    procedure setDescription(description: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property code : String read Fcode write Fcode;
    property description : String read Fdescription write Fdescription;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomamenitiesEntity = Array Of TRoomamenitiesEntity;

  TRoomermessagesEntity = class(TPersistent)
  private
    Fid: Integer; 
    FCreated: TTimeStamp; 
    FOriginalId: Integer; 
    FSenderId: Integer; 
    FRecipientId: Integer; 
    FRead: Integer; 
    FSubject: String; 
    FMessageText: String; 
    FMessageFormat: Integer; 
    FAttachedFiles: String; 
    FExtraData: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setCreated(Created: TTimeStamp); 
    procedure setOriginalId(OriginalId: Integer); 
    procedure setSenderId(SenderId: Integer); 
    procedure setRecipientId(RecipientId: Integer); 
    procedure setRead(Read: Integer); 
    procedure setSubject(Subject: String); 
    procedure setMessageText(MessageText: String); 
    procedure setMessageFormat(MessageFormat: Integer); 
    procedure setAttachedFiles(AttachedFiles: String); 
    procedure setExtraData(ExtraData: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property Created : TTimeStamp read FCreated write FCreated;
    property OriginalId : Integer read FOriginalId write FOriginalId;
    property SenderId : Integer read FSenderId write FSenderId;
    property RecipientId : Integer read FRecipientId write FRecipientId;
    property Read : Integer read FRead write FRead;
    property Subject : String read FSubject write FSubject;
    property MessageText : String read FMessageText write FMessageText;
    property MessageFormat : Integer read FMessageFormat write FMessageFormat;
    property AttachedFiles : String read FAttachedFiles write FAttachedFiles;
    property ExtraData : String read FExtraData write FExtraData;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomermessagesEntity = Array Of TRoomermessagesEntity;

  TRoomratesEntity = class(TPersistent)
  private
    FID: Integer; 
    FPriceCodeID: Integer; 
    FRateID: Integer; 
    FSeasonID: Integer; 
    FRoomTypeID: Integer; 
    FCurrencyID: Integer; 
    FActive: Byte; 
    FDateFrom: TTimeStamp; 
    FDateTo: TTimeStamp; 
    FDescription: String; 
    FDateCreated: TTimeStamp; 
    FLastModified: TTimeStamp; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setPriceCodeID(PriceCodeID: Integer); 
    procedure setRateID(RateID: Integer); 
    procedure setSeasonID(SeasonID: Integer); 
    procedure setRoomTypeID(RoomTypeID: Integer); 
    procedure setCurrencyID(CurrencyID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setDateFrom(DateFrom: TTimeStamp); 
    procedure setDateTo(DateTo: TTimeStamp); 
    procedure setDescription(Description: String); 
    procedure setDateCreated(DateCreated: TTimeStamp); 
    procedure setLastModified(LastModified: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property PriceCodeID : Integer read FPriceCodeID write FPriceCodeID;
    property RateID : Integer read FRateID write FRateID;
    property SeasonID : Integer read FSeasonID write FSeasonID;
    property RoomTypeID : Integer read FRoomTypeID write FRoomTypeID;
    property CurrencyID : Integer read FCurrencyID write FCurrencyID;
    property Active : Byte read FActive write FActive;
    property DateFrom : TTimeStamp read FDateFrom write FDateFrom;
    property DateTo : TTimeStamp read FDateTo write FDateTo;
    property Description : String read FDescription write FDescription;
    property DateCreated : TTimeStamp read FDateCreated write FDateCreated;
    property LastModified : TTimeStamp read FLastModified write FLastModified;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomratesEntity = Array Of TRoomratesEntity;

  TRoomreservationsEntity = class(TPersistent)
  private
    FRoomReservation: Integer; 
    FRoom: String; 
    FReservation: Integer; 
    FStatus: String; 
    FGroupAccount: Byte; 
    FinvBreakfast: Byte; 
    FRoomPrice1: Double; 
    FPrice1From: String; 
    FPrice1To: String; 
    FRoomPrice2: Double; 
    FPrice2From: String; 
    FPrice2To: String; 
    FRoomPrice3: Double; 
    FPrice3From: String; 
    FPrice3To: String; 
    FCurrency: String; 
    FDiscount: Double; 
    FPercentage: Byte; 
    FPriceType: String; 
    FArrival: String; 
    FDeparture: String; 
    FRoomType: String; 
    FPMInfo: String; 
    FHiddenInfo: String; 
    FRoomRentPaid1: Double; 
    FRoomRentPaid2: Double; 
    FRoomRentPaid3: Double; 
    FRoomRentPaymentInvoice: Integer; 
    FHallres: Integer; 
    FrrTmp: String; 
    FID: Integer; 
    FrrDescription: String; 
    FrrIsNoRoom: Byte; 
    FrrDeparture: TTimeStamp; 
    FrrArrival: TTimeStamp; 
    FrrRoomTypeAlias: String; 
    FrrRoomAlias: String; 
    FuseStayTax: Byte; 
    FuseinNationalReport: Byte; 
    FnumGuests: Integer; 
    FnumChildren: Integer; 
    FnumInfants: Integer; 
    FAvrageRate: String; 
    FRateCount: Integer; 
    FdtCreated: TTimeStamp; 
    FRoomClass: String; 
    FcolorId: Integer; 
    FratePlanCode: String; 
    FpercentageDeposit: Double; 
    FfixedDeposit: Double; 
    FdepositsInfo: String; 
    FpenaltiesInfo: String; 
    FcheckoutEventProcessed: Byte; 
    Fjson: String; 
  public
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setRoom(Room: String); 
    procedure setReservation(Reservation: Integer); 
    procedure setStatus(Status: String); 
    procedure setGroupAccount(GroupAccount: Byte); 
    procedure setInvBreakfast(invBreakfast: Byte); 
    procedure setRoomPrice1(RoomPrice1: Double); 
    procedure setPrice1From(Price1From: String); 
    procedure setPrice1To(Price1To: String); 
    procedure setRoomPrice2(RoomPrice2: Double); 
    procedure setPrice2From(Price2From: String); 
    procedure setPrice2To(Price2To: String); 
    procedure setRoomPrice3(RoomPrice3: Double); 
    procedure setPrice3From(Price3From: String); 
    procedure setPrice3To(Price3To: String); 
    procedure setCurrency(Currency: String); 
    procedure setDiscount(Discount: Double); 
    procedure setPercentage(Percentage: Byte); 
    procedure setPriceType(PriceType: String); 
    procedure setArrival(Arrival: String); 
    procedure setDeparture(Departure: String); 
    procedure setRoomType(RoomType: String); 
    procedure setPMInfo(PMInfo: String); 
    procedure setHiddenInfo(HiddenInfo: String); 
    procedure setRoomRentPaid1(RoomRentPaid1: Double); 
    procedure setRoomRentPaid2(RoomRentPaid2: Double); 
    procedure setRoomRentPaid3(RoomRentPaid3: Double); 
    procedure setRoomRentPaymentInvoice(RoomRentPaymentInvoice: Integer); 
    procedure setHallres(Hallres: Integer); 
    procedure setRrTmp(rrTmp: String); 
    procedure setID(ID: Integer); 
    procedure setRrDescription(rrDescription: String); 
    procedure setRrIsNoRoom(rrIsNoRoom: Byte); 
    procedure setRrDeparture(rrDeparture: TTimeStamp); 
    procedure setRrArrival(rrArrival: TTimeStamp); 
    procedure setRrRoomTypeAlias(rrRoomTypeAlias: String); 
    procedure setRrRoomAlias(rrRoomAlias: String); 
    procedure setUseStayTax(useStayTax: Byte); 
    procedure setUseinNationalReport(useinNationalReport: Byte); 
    procedure setNumGuests(numGuests: Integer); 
    procedure setNumChildren(numChildren: Integer); 
    procedure setNumInfants(numInfants: Integer); 
    procedure setAvrageRate(AvrageRate: String); 
    procedure setRateCount(RateCount: Integer); 
    procedure setDtCreated(dtCreated: TTimeStamp); 
    procedure setRoomClass(RoomClass: String); 
    procedure setColorId(colorId: Integer); 
    procedure setRatePlanCode(ratePlanCode: String); 
    procedure setPercentageDeposit(percentageDeposit: Double); 
    procedure setFixedDeposit(fixedDeposit: Double); 
    procedure setDepositsInfo(depositsInfo: String); 
    procedure setPenaltiesInfo(penaltiesInfo: String); 
    procedure setCheckoutEventProcessed(checkoutEventProcessed: Byte); 
    procedure setJson(json: String); 
  published
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Room : String read FRoom write FRoom;
    property Reservation : Integer read FReservation write FReservation;
    property Status : String read FStatus write FStatus;
    property GroupAccount : Byte read FGroupAccount write FGroupAccount;
    property invBreakfast : Byte read FinvBreakfast write FinvBreakfast;
    property RoomPrice1 : Double read FRoomPrice1 write FRoomPrice1;
    property Price1From : String read FPrice1From write FPrice1From;
    property Price1To : String read FPrice1To write FPrice1To;
    property RoomPrice2 : Double read FRoomPrice2 write FRoomPrice2;
    property Price2From : String read FPrice2From write FPrice2From;
    property Price2To : String read FPrice2To write FPrice2To;
    property RoomPrice3 : Double read FRoomPrice3 write FRoomPrice3;
    property Price3From : String read FPrice3From write FPrice3From;
    property Price3To : String read FPrice3To write FPrice3To;
    property Currency : String read FCurrency write FCurrency;
    property Discount : Double read FDiscount write FDiscount;
    property Percentage : Byte read FPercentage write FPercentage;
    property PriceType : String read FPriceType write FPriceType;
    property Arrival : String read FArrival write FArrival;
    property Departure : String read FDeparture write FDeparture;
    property RoomType : String read FRoomType write FRoomType;
    property PMInfo : String read FPMInfo write FPMInfo;
    property HiddenInfo : String read FHiddenInfo write FHiddenInfo;
    property RoomRentPaid1 : Double read FRoomRentPaid1 write FRoomRentPaid1;
    property RoomRentPaid2 : Double read FRoomRentPaid2 write FRoomRentPaid2;
    property RoomRentPaid3 : Double read FRoomRentPaid3 write FRoomRentPaid3;
    property RoomRentPaymentInvoice : Integer read FRoomRentPaymentInvoice write FRoomRentPaymentInvoice;
    property Hallres : Integer read FHallres write FHallres;
    property rrTmp : String read FrrTmp write FrrTmp;
    property ID : Integer read FID write FID;
    property rrDescription : String read FrrDescription write FrrDescription;
    property rrIsNoRoom : Byte read FrrIsNoRoom write FrrIsNoRoom;
    property rrDeparture : TTimeStamp read FrrDeparture write FrrDeparture;
    property rrArrival : TTimeStamp read FrrArrival write FrrArrival;
    property rrRoomTypeAlias : String read FrrRoomTypeAlias write FrrRoomTypeAlias;
    property rrRoomAlias : String read FrrRoomAlias write FrrRoomAlias;
    property useStayTax : Byte read FuseStayTax write FuseStayTax;
    property useinNationalReport : Byte read FuseinNationalReport write FuseinNationalReport;
    property numGuests : Integer read FnumGuests write FnumGuests;
    property numChildren : Integer read FnumChildren write FnumChildren;
    property numInfants : Integer read FnumInfants write FnumInfants;
    property AvrageRate : String read FAvrageRate write FAvrageRate;
    property RateCount : Integer read FRateCount write FRateCount;
    property dtCreated : TTimeStamp read FdtCreated write FdtCreated;
    property RoomClass : String read FRoomClass write FRoomClass;
    property colorId : Integer read FcolorId write FcolorId;
    property ratePlanCode : String read FratePlanCode write FratePlanCode;
    property percentageDeposit : Double read FpercentageDeposit write FpercentageDeposit;
    property fixedDeposit : Double read FfixedDeposit write FfixedDeposit;
    property depositsInfo : String read FdepositsInfo write FdepositsInfo;
    property penaltiesInfo : String read FpenaltiesInfo write FpenaltiesInfo;
    property checkoutEventProcessed : Byte read FcheckoutEventProcessed write FcheckoutEventProcessed;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomreservationsEntity = Array Of TRoomreservationsEntity;

  TRoomroomamenitiesEntity = class(TPersistent)
  private
    Fid: Integer; 
    FroomId: Integer; 
    Froomamenity: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setRoomId(roomId: Integer); 
    procedure setRoomamenity(roomamenity: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property roomId : Integer read FroomId write FroomId;
    property roomamenity : Integer read Froomamenity write Froomamenity;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomroomamenitiesEntity = Array Of TRoomroomamenitiesEntity;

  TRoomsEntity = class(TPersistent)
  private
    FRoom: String; 
    FDescription: String; 
    FDetailedDescription: String; 
    FRoomType: String; 
    Fwildcard: Byte; 
    FBath: Byte; 
    FShower: Byte; 
    FSafe: Byte; 
    FTV: Byte; 
    FVideo: Byte; 
    FRadio: Byte; 
    FCDPlayer: Byte; 
    FTelephone: Byte; 
    FPress: Byte; 
    FCoffee: Byte; 
    FKitchen: Byte; 
    FMinibar: Byte; 
    FFridge: Byte; 
    FHairdryer: Byte; 
    FInternetPlug: Byte; 
    FFax: Byte; 
    FSqrMeters: Double; 
    FBedSize: String; 
    FEquipments: String; 
    FBookable: Byte; 
    FStatistics: Byte; 
    FStatus: String; 
    FOrderIndex: Integer; 
    Fhidden: Byte; 
    FLocation: String; 
    FFloor: Integer; 
    FID: Integer; 
    FDorm: String; 
    FuseInNationalReport: Byte; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setRoom(Room: String); 
    procedure setDescription(Description: String); 
    procedure setDetailedDescription(DetailedDescription: String); 
    procedure setRoomType(RoomType: String); 
    procedure setWildcard(wildcard: Byte); 
    procedure setBath(Bath: Byte); 
    procedure setShower(Shower: Byte); 
    procedure setSafe(Safe: Byte); 
    procedure setTV(TV: Byte); 
    procedure setVideo(Video: Byte); 
    procedure setRadio(Radio: Byte); 
    procedure setCDPlayer(CDPlayer: Byte); 
    procedure setTelephone(Telephone: Byte); 
    procedure setPress(Press: Byte); 
    procedure setCoffee(Coffee: Byte); 
    procedure setKitchen(Kitchen: Byte); 
    procedure setMinibar(Minibar: Byte); 
    procedure setFridge(Fridge: Byte); 
    procedure setHairdryer(Hairdryer: Byte); 
    procedure setInternetPlug(InternetPlug: Byte); 
    procedure setFax(Fax: Byte); 
    procedure setSqrMeters(SqrMeters: Double); 
    procedure setBedSize(BedSize: String); 
    procedure setEquipments(Equipments: String); 
    procedure setBookable(Bookable: Byte); 
    procedure setStatistics(Statistics: Byte); 
    procedure setStatus(Status: String); 
    procedure setOrderIndex(OrderIndex: Integer); 
    procedure setHidden(hidden: Byte); 
    procedure setLocation(Location: String); 
    procedure setFloor(Floor: Integer); 
    procedure setID(ID: Integer); 
    procedure setDorm(Dorm: String); 
    procedure setUseInNationalReport(useInNationalReport: Byte); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property Room : String read FRoom write FRoom;
    property Description : String read FDescription write FDescription;
    property DetailedDescription : String read FDetailedDescription write FDetailedDescription;
    property RoomType : String read FRoomType write FRoomType;
    property wildcard : Byte read Fwildcard write Fwildcard;
    property Bath : Byte read FBath write FBath;
    property Shower : Byte read FShower write FShower;
    property Safe : Byte read FSafe write FSafe;
    property TV : Byte read FTV write FTV;
    property Video : Byte read FVideo write FVideo;
    property Radio : Byte read FRadio write FRadio;
    property CDPlayer : Byte read FCDPlayer write FCDPlayer;
    property Telephone : Byte read FTelephone write FTelephone;
    property Press : Byte read FPress write FPress;
    property Coffee : Byte read FCoffee write FCoffee;
    property Kitchen : Byte read FKitchen write FKitchen;
    property Minibar : Byte read FMinibar write FMinibar;
    property Fridge : Byte read FFridge write FFridge;
    property Hairdryer : Byte read FHairdryer write FHairdryer;
    property InternetPlug : Byte read FInternetPlug write FInternetPlug;
    property Fax : Byte read FFax write FFax;
    property SqrMeters : Double read FSqrMeters write FSqrMeters;
    property BedSize : String read FBedSize write FBedSize;
    property Equipments : String read FEquipments write FEquipments;
    property Bookable : Byte read FBookable write FBookable;
    property Statistics : Byte read FStatistics write FStatistics;
    property Status : String read FStatus write FStatus;
    property OrderIndex : Integer read FOrderIndex write FOrderIndex;
    property hidden : Byte read Fhidden write Fhidden;
    property Location : String read FLocation write FLocation;
    property Floor : Integer read FFloor write FFloor;
    property ID : Integer read FID write FID;
    property Dorm : String read FDorm write FDorm;
    property useInNationalReport : Byte read FuseInNationalReport write FuseInNationalReport;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomsEntity = Array Of TRoomsEntity;

  TRoomsdateEntity = class(TPersistent)
  private
    FADate: String; 
    FRoom: String; 
    FRoomType: String; 
    FRoomReservation: Integer; 
    FReservation: Integer; 
    FResFlag: String; 
    FrdTmp: String; 
    Fupdated: Byte; 
    FisNoRoom: Byte; 
    FID: Integer; 
    FRoomRentBilled: Double; 
    FRoomRentUnBilled: Double; 
    FRoomDiscountBilled: Double; 
    FRoomDiscountUnBilled: Double; 
    FItemsBilled: Double; 
    FItemsUnbilled: Double; 
    FTaxesBilled: Double; 
    FTaxesUnbilled: Double; 
    FPriceCode: String; 
    FRoomRate: Double; 
    FCurrency: String; 
    FDiscount: Double; 
    FisPercentage: Byte; 
    FshowDiscount: Byte; 
    FPaid: Byte; 
    Fjson: String; 
  public
    procedure setADate(ADate: String); 
    procedure setRoom(Room: String); 
    procedure setRoomType(RoomType: String); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setResFlag(ResFlag: String); 
    procedure setRdTmp(rdTmp: String); 
    procedure setUpdated(updated: Byte); 
    procedure setIsNoRoom(isNoRoom: Byte); 
    procedure setID(ID: Integer); 
    procedure setRoomRentBilled(RoomRentBilled: Double); 
    procedure setRoomRentUnBilled(RoomRentUnBilled: Double); 
    procedure setRoomDiscountBilled(RoomDiscountBilled: Double); 
    procedure setRoomDiscountUnBilled(RoomDiscountUnBilled: Double); 
    procedure setItemsBilled(ItemsBilled: Double); 
    procedure setItemsUnbilled(ItemsUnbilled: Double); 
    procedure setTaxesBilled(TaxesBilled: Double); 
    procedure setTaxesUnbilled(TaxesUnbilled: Double); 
    procedure setPriceCode(PriceCode: String); 
    procedure setRoomRate(RoomRate: Double); 
    procedure setCurrency(Currency: String); 
    procedure setDiscount(Discount: Double); 
    procedure setIsPercentage(isPercentage: Byte); 
    procedure setShowDiscount(showDiscount: Byte); 
    procedure setPaid(Paid: Byte); 
    procedure setJson(json: String); 
  published
    property ADate : String read FADate write FADate;
    property Room : String read FRoom write FRoom;
    property RoomType : String read FRoomType write FRoomType;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Reservation : Integer read FReservation write FReservation;
    property ResFlag : String read FResFlag write FResFlag;
    property rdTmp : String read FrdTmp write FrdTmp;
    property updated : Byte read Fupdated write Fupdated;
    property isNoRoom : Byte read FisNoRoom write FisNoRoom;
    property ID : Integer read FID write FID;
    property RoomRentBilled : Double read FRoomRentBilled write FRoomRentBilled;
    property RoomRentUnBilled : Double read FRoomRentUnBilled write FRoomRentUnBilled;
    property RoomDiscountBilled : Double read FRoomDiscountBilled write FRoomDiscountBilled;
    property RoomDiscountUnBilled : Double read FRoomDiscountUnBilled write FRoomDiscountUnBilled;
    property ItemsBilled : Double read FItemsBilled write FItemsBilled;
    property ItemsUnbilled : Double read FItemsUnbilled write FItemsUnbilled;
    property TaxesBilled : Double read FTaxesBilled write FTaxesBilled;
    property TaxesUnbilled : Double read FTaxesUnbilled write FTaxesUnbilled;
    property PriceCode : String read FPriceCode write FPriceCode;
    property RoomRate : Double read FRoomRate write FRoomRate;
    property Currency : String read FCurrency write FCurrency;
    property Discount : Double read FDiscount write FDiscount;
    property isPercentage : Byte read FisPercentage write FisPercentage;
    property showDiscount : Byte read FshowDiscount write FshowDiscount;
    property Paid : Byte read FPaid write FPaid;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomsdateEntity = Array Of TRoomsdateEntity;

  TRoomsdatetempEntity = class(TPersistent)
  private
    FADate: String; 
    FRoom: String; 
    FRoomType: String; 
    FRoomReservation: Integer; 
    FReservation: Integer; 
    FresFlag: String; 
    FID: Integer; 
    Fjson: String; 
  public
    procedure setADate(ADate: String); 
    procedure setRoom(Room: String); 
    procedure setRoomType(RoomType: String); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setResFlag(resFlag: String); 
    procedure setID(ID: Integer); 
    procedure setJson(json: String); 
  published
    property ADate : String read FADate write FADate;
    property Room : String read FRoom write FRoom;
    property RoomType : String read FRoomType write FRoomType;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Reservation : Integer read FReservation write FReservation;
    property resFlag : String read FresFlag write FresFlag;
    property ID : Integer read FID write FID;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomsdatetempEntity = Array Of TRoomsdatetempEntity;

  TRoomtypegroupsEntity = class(TPersistent)
  private
    FCode: String; 
    FDescription: String; 
    FDetailedDescription: String; 
    FPriorityRule: String;
    FnumGuests: Integer; 
    FMaxCount: Integer; 
    FminGuests: Integer; 
    FmaxGuests: Integer; 
    FmaxChildren: Integer; 
    Fcolor: String; 
    FID: Integer; 
    FActive: Byte; 
    FDetailedDescriptionHtml: String; 
    FlastUpdate: TTimeStamp; 
    FTopClass: String; 
    FAvailabilityTypes: String; 
    FdefRate: String; 
    FdefAvailability: Integer; 
    FdefStopSale: Byte; 
    FdefMinStay: Integer; 
    FdefMaxAvailability: Integer; 
    FNonRefundable: Byte; 
    FAutoChargeCreditcards: Byte; 
    FRateExtraBed: String; 
    FPhotoUri: String; 
    Fjson: String; 
  public
    procedure setCode(Code: String); 
    procedure setDescription(Description: String); 
    procedure setDetailedDescription(DetailedDescription: String); 
    procedure setPriorityRule(PriorityRule: String); 
    procedure setNumGuests(numGuests: Integer); 
    procedure setMaxCount(MaxCount: Integer); 
    procedure setMinGuests(minGuests: Integer); 
    procedure setMaxGuests(maxGuests: Integer); 
    procedure setMaxChildren(maxChildren: Integer); 
    procedure setColor(color: String); 
    procedure setID(ID: Integer);
    procedure setActive(Active: Byte); 
    procedure setDetailedDescriptionHtml(DetailedDescriptionHtml: String); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setTopClass(TopClass: String); 
    procedure setAvailabilityTypes(AvailabilityTypes: String); 
    procedure setDefRate(defRate: String); 
    procedure setDefAvailability(defAvailability: Integer); 
    procedure setDefStopSale(defStopSale: Byte); 
    procedure setDefMinStay(defMinStay: Integer); 
    procedure setDefMaxAvailability(defMaxAvailability: Integer); 
    procedure setNonRefundable(NonRefundable: Byte); 
    procedure setAutoChargeCreditcards(AutoChargeCreditcards: Byte); 
    procedure setRateExtraBed(RateExtraBed: String); 
    procedure setPhotoUri(PhotoUri: String); 
    procedure setJson(json: String); 
  published
    property Code : String read FCode write FCode;
    property Description : String read FDescription write FDescription;
    property DetailedDescription : String read FDetailedDescription write FDetailedDescription;
    property PriorityRule : String read FPriorityRule write FPriorityRule;
    property numGuests : Integer read FnumGuests write FnumGuests;
    property MaxCount : Integer read FMaxCount write FMaxCount;
    property minGuests : Integer read FminGuests write FminGuests;
    property maxGuests : Integer read FmaxGuests write FmaxGuests;
    property maxChildren : Integer read FmaxChildren write FmaxChildren;
    property color : String read Fcolor write Fcolor;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property DetailedDescriptionHtml : String read FDetailedDescriptionHtml write FDetailedDescriptionHtml;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property TopClass : String read FTopClass write FTopClass;
    property AvailabilityTypes : String read FAvailabilityTypes write FAvailabilityTypes;
    property defRate : String read FdefRate write FdefRate;
    property defAvailability : Integer read FdefAvailability write FdefAvailability;
    property defStopSale : Byte read FdefStopSale write FdefStopSale;
    property defMinStay : Integer read FdefMinStay write FdefMinStay;
    property defMaxAvailability : Integer read FdefMaxAvailability write FdefMaxAvailability;
    property NonRefundable : Byte read FNonRefundable write FNonRefundable;
    property AutoChargeCreditcards : Byte read FAutoChargeCreditcards write FAutoChargeCreditcards;
    property RateExtraBed : String read FRateExtraBed write FRateExtraBed;
    property PhotoUri : String read FPhotoUri write FPhotoUri;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomtypegroupsEntity = Array Of TRoomtypegroupsEntity;

  TRoomtyperulesEntity = class(TPersistent)
  private
    FRoomType: String; 
    FRuleString: String; 
    FID: Integer; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setRoomType(RoomType: String); 
    procedure setRuleString(RuleString: String); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property RoomType : String read FRoomType write FRoomType;
    property RuleString : String read FRuleString write FRuleString;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomtyperulesEntity = Array Of TRoomtyperulesEntity;

  TRoomtypesEntity = class(TPersistent)
  private
    FRoomType: String; 
    FDescription: String; 
    FDetailedDescription: String; 
    FNumberGuests: Integer; 
    FPriceType: String; 
    FWebable: Byte; 
    FRoomTypeGroup: String; 
    Fcolor: String; 
    FID: Integer; 
    FActive: Byte; 
    FPriorityRule: String; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setRoomType(RoomType: String); 
    procedure setDescription(Description: String); 
    procedure setDetailedDescription(DetailedDescription: String); 
    procedure setNumberGuests(NumberGuests: Integer); 
    procedure setPriceType(PriceType: String); 
    procedure setWebable(Webable: Byte); 
    procedure setRoomTypeGroup(RoomTypeGroup: String); 
    procedure setColor(color: String); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setPriorityRule(PriorityRule: String); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property RoomType : String read FRoomType write FRoomType;
    property Description : String read FDescription write FDescription;
    property DetailedDescription : String read FDetailedDescription write FDetailedDescription;
    property NumberGuests : Integer read FNumberGuests write FNumberGuests;
    property PriceType : String read FPriceType write FPriceType;
    property Webable : Byte read FWebable write FWebable;
    property RoomTypeGroup : String read FRoomTypeGroup write FRoomTypeGroup;
    property color : String read Fcolor write Fcolor;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property PriorityRule : String read FPriorityRule write FPriorityRule;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TRoomtypesEntity = Array Of TRoomtypesEntity;

  TStaffmembersEntity = class(TPersistent)
  private
    FInitials: String; 
    FPassword: String; 
    FName: String; 
    FAddress1: String; 
    FAddress2: String; 
    FAddress3: String; 
    FAddress4: String; 
    FCountry: String; 
    FTel1: String; 
    FTel2: String; 
    FFax: String; 
    FActiveMember: Byte; 
    FStaffType: String; 
    FStaffLanguage: Integer; 
    FStaffPID: String; 
    FID: Integer; 
    FActive: Byte; 
    FStaffType1: String;
    FStaffType2: String; 
    FStaffType3: String; 
    FStaffType4: String; 
    FWindowsAuth: Byte; 
    FPmsOnly: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setInitials(Initials: String); 
    procedure setPassword(Password: String); 
    procedure setName(Name: String); 
    procedure setAddress1(Address1: String); 
    procedure setAddress2(Address2: String); 
    procedure setAddress3(Address3: String); 
    procedure setAddress4(Address4: String); 
    procedure setCountry(Country: String); 
    procedure setTel1(Tel1: String); 
    procedure setTel2(Tel2: String); 
    procedure setFax(Fax: String); 
    procedure setActiveMember(ActiveMember: Byte); 
    procedure setStaffType(StaffType: String); 
    procedure setStaffLanguage(StaffLanguage: Integer); 
    procedure setStaffPID(StaffPID: String); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setStaffType1(StaffType1: String); 
    procedure setStaffType2(StaffType2: String); 
    procedure setStaffType3(StaffType3: String); 
    procedure setStaffType4(StaffType4: String); 
    procedure setWindowsAuth(WindowsAuth: Byte); 
    procedure setPmsOnly(PmsOnly: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property Initials : String read FInitials write FInitials;
    property Password : String read FPassword write FPassword;
    property Name : String read FName write FName;
    property Address1 : String read FAddress1 write FAddress1;
    property Address2 : String read FAddress2 write FAddress2;
    property Address3 : String read FAddress3 write FAddress3;
    property Address4 : String read FAddress4 write FAddress4;
    property Country : String read FCountry write FCountry;
    property Tel1 : String read FTel1 write FTel1;
    property Tel2 : String read FTel2 write FTel2;
    property Fax : String read FFax write FFax;
    property ActiveMember : Byte read FActiveMember write FActiveMember;
    property StaffType : String read FStaffType write FStaffType;
    property StaffLanguage : Integer read FStaffLanguage write FStaffLanguage;
    property StaffPID : String read FStaffPID write FStaffPID;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property StaffType1 : String read FStaffType1 write FStaffType1;
    property StaffType2 : String read FStaffType2 write FStaffType2;
    property StaffType3 : String read FStaffType3 write FStaffType3;
    property StaffType4 : String read FStaffType4 write FStaffType4;
    property WindowsAuth : Byte read FWindowsAuth write FWindowsAuth;
    property PmsOnly : Byte read FPmsOnly write FPmsOnly;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TStaffmembersEntity = Array Of TStaffmembersEntity;

  TStafftypesEntity = class(TPersistent)
  private
    FStaffType: String; 
    FDescription: String; 
    FAccessPrivilidges: Integer; 
    FID: Integer;
    FActive: Byte; 
    Fjson: String; 
  public
    procedure setStaffType(StaffType: String); 
    procedure setDescription(Description: String); 
    procedure setAccessPrivilidges(AccessPrivilidges: Integer); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setJson(json: String); 
  published
    property StaffType : String read FStaffType write FStaffType;
    property Description : String read FDescription write FDescription;
    property AccessPrivilidges : Integer read FAccessPrivilidges write FAccessPrivilidges;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TStafftypesEntity = Array Of TStafftypesEntity;

  TSystemactionsEntity = class(TPersistent)
  private
    Fid: Integer; 
    Fdescription: String; 
    Ftype: Integer; 
    Factive: Byte; 
    Fsystemserver: Integer; 
    Frecipient: String; 
    Fsender: String; 
    Fsubject: String; 
    Fcontent: String; 
    Frichcontent: Byte; 
    Fcontentfile: String; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setDescription(description: String); 
    procedure setType(_type: Integer); 
    procedure setActive(active: Byte); 
    procedure setSystemserver(systemserver: Integer); 
    procedure setRecipient(recipient: String); 
    procedure setSender(sender: String); 
    procedure setSubject(subject: String); 
    procedure setContent(content: String); 
    procedure setRichcontent(richcontent: Byte); 
    procedure setContentfile(contentfile: String); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property description : String read Fdescription write Fdescription;
    property _type : Integer read Ftype write Ftype;
    property active : Byte read Factive write Factive;
    property systemserver : Integer read Fsystemserver write Fsystemserver;
    property recipient : String read Frecipient write Frecipient;
    property sender : String read Fsender write Fsender;
    property subject : String read Fsubject write Fsubject;
    property content : String read Fcontent write Fcontent;
    property richcontent : Byte read Frichcontent write Frichcontent;
    property contentfile : String read Fcontentfile write Fcontentfile;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TSystemactionsEntity = Array Of TSystemactionsEntity;

  TSystemserversEntity = class(TPersistent)
  private
    Fid: Integer; 
    Factive: Byte; 
    Fdescription: String; 
    Fserver: String;
    Fport: Integer; 
    Fusername: String; 
    Fpassword: String; 
    Fauthenticate: Byte; 
    Fssl: Byte; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setActive(active: Byte); 
    procedure setDescription(description: String); 
    procedure setServer(server: String); 
    procedure setPort(port: Integer); 
    procedure setUsername(username: String); 
    procedure setPassword(password: String); 
    procedure setAuthenticate(authenticate: Byte); 
    procedure setSsl(ssl: Byte); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property active : Byte read Factive write Factive;
    property description : String read Fdescription write Fdescription;
    property server : String read Fserver write Fserver;
    property port : Integer read Fport write Fport;
    property username : String read Fusername write Fusername;
    property password : String read Fpassword write Fpassword;
    property authenticate : Byte read Fauthenticate write Fauthenticate;
    property ssl : Byte read Fssl write Fssl;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TSystemserversEntity = Array Of TSystemserversEntity;

  TSystemtriggersEntity = class(TPersistent)
  private
    Fid: Integer;
    Ftype: Integer; 
    Factive: Byte; 
    Fdescription: String; 
    Fsystemaction: Integer; 
    Fjson: String; 
  public
    procedure setId(id: Integer); 
    procedure setType(_type: Integer); 
    procedure setActive(active: Byte); 
    procedure setDescription(description: String); 
    procedure setSystemaction(systemaction: Integer); 
    procedure setJson(json: String); 
  published
    property id : Integer read Fid write Fid;
    property _type : Integer read Ftype write Ftype;
    property active : Byte read Factive write Factive;
    property description : String read Fdescription write Fdescription;
    property systemaction : Integer read Fsystemaction write Fsystemaction;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TSystemtriggersEntity = Array Of TSystemtriggersEntity;

  TTblconvertgroupsEntity = class(TPersistent)
  private
    FcgCode: String; 
    FcgDescription: String; 
    FID: Integer; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setCgCode(cgCode: String); 
    procedure setCgDescription(cgDescription: String); 
    procedure setID(ID: Integer);
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property cgCode : String read FcgCode write FcgCode;
    property cgDescription : String read FcgDescription write FcgDescription;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblconvertgroupsEntity = Array Of TTblconvertgroupsEntity;

  TTblconvertsEntity = class(TPersistent)
  private
    FID: Integer; 
    FcvType: String; 
    FcvFrom: String; 
    FcvTo: String; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setCvType(cvType: String); 
    procedure setCvFrom(cvFrom: String); 
    procedure setCvTo(cvTo: String); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property cvType : String read FcvType write FcvType;
    property cvFrom : String read FcvFrom write FcvFrom;
    property cvTo : String read FcvTo write FcvTo;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblconvertsEntity = Array Of TTblconvertsEntity;

  TTbldelpersonsEntity = class(TPersistent)
  private
    FID: Integer; 
    FPerson: Integer; 
    FRoomReservation: Integer; 
    FReservation: Integer; 
    FName: String; 
    FSurname: String; 
    FAddress1: String; 
    FAddress2: String; 
    FAddress3: String; 
    FAddress4: String; 
    FCountry: String; 
    FCompany: String; 
    FGuestType: String; 
    FInformation: String; 
    FPID: String; 
    FMainName: Byte; 
    FCustomer: String; 
    FpeTmp: String; 
    FpeID: Integer; 
    FhgrID: Integer; 
    FHallReservation: Integer; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setPerson(Person: Integer);
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setName(Name: String); 
    procedure setSurname(Surname: String); 
    procedure setAddress1(Address1: String); 
    procedure setAddress2(Address2: String); 
    procedure setAddress3(Address3: String); 
    procedure setAddress4(Address4: String); 
    procedure setCountry(Country: String); 
    procedure setCompany(Company: String); 
    procedure setGuestType(GuestType: String); 
    procedure setInformation(Information: String); 
    procedure setPID(PID: String); 
    procedure setMainName(MainName: Byte); 
    procedure setCustomer(Customer: String); 
    procedure setPeTmp(peTmp: String); 
    procedure setPeID(peID: Integer); 
    procedure setHgrID(hgrID: Integer); 
    procedure setHallReservation(HallReservation: Integer); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property Person : Integer read FPerson write FPerson;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Reservation : Integer read FReservation write FReservation;
    property Name : String read FName write FName;
    property Surname : String read FSurname write FSurname;
    property Address1 : String read FAddress1 write FAddress1;
    property Address2 : String read FAddress2 write FAddress2;
    property Address3 : String read FAddress3 write FAddress3;
    property Address4 : String read FAddress4 write FAddress4;
    property Country : String read FCountry write FCountry;
    property Company : String read FCompany write FCompany;
    property GuestType : String read FGuestType write FGuestType;
    property Information : String read FInformation write FInformation;
    property PID : String read FPID write FPID;
    property MainName : Byte read FMainName write FMainName;
    property Customer : String read FCustomer write FCustomer;
    property peTmp : String read FpeTmp write FpeTmp;
    property peID : Integer read FpeID write FpeID;
    property hgrID : Integer read FhgrID write FhgrID;
    property HallReservation : Integer read FHallReservation write FHallReservation;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTbldelpersonsEntity = Array Of TTbldelpersonsEntity;

  TTbldelreservationsEntity = class(TPersistent)
  private
    FID: Integer; 
    FReservation: Integer; 
    FArrival: String; 
    FDeparture: String; 
    FCustomer: String; 
    FName: String; 
    FAddress1: String; 
    FAddress2: String; 
    FAddress3: String; 
    FAddress4: String; 
    FCountry: String; 
    FTel1: String; 
    FTel2: String; 
    FFax: String; 
    FStatus: String; 
    FReservationDate: String; 
    FStaff: String; 
    FInformation: String; 
    FPMInfo: String; 
    FHiddenInfo: String; 
    FRoomRentPaid1: Double; 
    FRoomRentPaid2: Double; 
    FRoomRentPaid3: Double; 
    FRoomRentPaymentInvoice: Integer; 
    FContactName: String; 
    FContactPhone: String; 
    FContactFax: String; 
    FContactEmail: String; 
    Finputsource: String; 
    Fwebconfirmed: String; 
    Farrivaltime: String; 
    Fsrcrequest: String; 
    FrvTmp: String; 
    FrvID: Integer; 
    FCustPID: String; 
    FinvRefrence: String; 
    FmarketSegment: String; 
    FCustomerEmail: String; 
    FCustomerWebsite: String; 
    FuseStayTax: Byte; 
    FChannel: Integer; 
    FeventsProcessed: Byte; 
    FalteredReservation: Byte; 
    FexternalIds: String; 
    FdtCreated: TTimeStamp; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setArrival(Arrival: String); 
    procedure setDeparture(Departure: String); 
    procedure setCustomer(Customer: String); 
    procedure setName(Name: String); 
    procedure setAddress1(Address1: String); 
    procedure setAddress2(Address2: String); 
    procedure setAddress3(Address3: String); 
    procedure setAddress4(Address4: String); 
    procedure setCountry(Country: String); 
    procedure setTel1(Tel1: String); 
    procedure setTel2(Tel2: String); 
    procedure setFax(Fax: String); 
    procedure setStatus(Status: String); 
    procedure setReservationDate(ReservationDate: String); 
    procedure setStaff(Staff: String); 
    procedure setInformation(Information: String); 
    procedure setPMInfo(PMInfo: String); 
    procedure setHiddenInfo(HiddenInfo: String); 
    procedure setRoomRentPaid1(RoomRentPaid1: Double); 
    procedure setRoomRentPaid2(RoomRentPaid2: Double); 
    procedure setRoomRentPaid3(RoomRentPaid3: Double); 
    procedure setRoomRentPaymentInvoice(RoomRentPaymentInvoice: Integer); 
    procedure setContactName(ContactName: String); 
    procedure setContactPhone(ContactPhone: String); 
    procedure setContactFax(ContactFax: String); 
    procedure setContactEmail(ContactEmail: String); 
    procedure setInputsource(inputsource: String); 
    procedure setWebconfirmed(webconfirmed: String); 
    procedure setArrivaltime(arrivaltime: String); 
    procedure setSrcrequest(srcrequest: String); 
    procedure setRvTmp(rvTmp: String); 
    procedure setRvID(rvID: Integer); 
    procedure setCustPID(CustPID: String); 
    procedure setInvRefrence(invRefrence: String); 
    procedure setMarketSegment(marketSegment: String); 
    procedure setCustomerEmail(CustomerEmail: String); 
    procedure setCustomerWebsite(CustomerWebsite: String); 
    procedure setUseStayTax(useStayTax: Byte); 
    procedure setChannel(Channel: Integer); 
    procedure setEventsProcessed(eventsProcessed: Byte); 
    procedure setAlteredReservation(alteredReservation: Byte); 
    procedure setExternalIds(externalIds: String); 
    procedure setDtCreated(dtCreated: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property Reservation : Integer read FReservation write FReservation;
    property Arrival : String read FArrival write FArrival;
    property Departure : String read FDeparture write FDeparture;
    property Customer : String read FCustomer write FCustomer;
    property Name : String read FName write FName;
    property Address1 : String read FAddress1 write FAddress1;
    property Address2 : String read FAddress2 write FAddress2;
    property Address3 : String read FAddress3 write FAddress3;
    property Address4 : String read FAddress4 write FAddress4;
    property Country : String read FCountry write FCountry;
    property Tel1 : String read FTel1 write FTel1;
    property Tel2 : String read FTel2 write FTel2;
    property Fax : String read FFax write FFax;
    property Status : String read FStatus write FStatus;
    property ReservationDate : String read FReservationDate write FReservationDate;
    property Staff : String read FStaff write FStaff;
    property Information : String read FInformation write FInformation;
    property PMInfo : String read FPMInfo write FPMInfo;
    property HiddenInfo : String read FHiddenInfo write FHiddenInfo;
    property RoomRentPaid1 : Double read FRoomRentPaid1 write FRoomRentPaid1;
    property RoomRentPaid2 : Double read FRoomRentPaid2 write FRoomRentPaid2;
    property RoomRentPaid3 : Double read FRoomRentPaid3 write FRoomRentPaid3;
    property RoomRentPaymentInvoice : Integer read FRoomRentPaymentInvoice write FRoomRentPaymentInvoice;
    property ContactName : String read FContactName write FContactName;
    property ContactPhone : String read FContactPhone write FContactPhone;
    property ContactFax : String read FContactFax write FContactFax;
    property ContactEmail : String read FContactEmail write FContactEmail;
    property inputsource : String read Finputsource write Finputsource;
    property webconfirmed : String read Fwebconfirmed write Fwebconfirmed;
    property arrivaltime : String read Farrivaltime write Farrivaltime;
    property srcrequest : String read Fsrcrequest write Fsrcrequest;
    property rvTmp : String read FrvTmp write FrvTmp;
    property rvID : Integer read FrvID write FrvID;
    property CustPID : String read FCustPID write FCustPID;
    property invRefrence : String read FinvRefrence write FinvRefrence;
    property marketSegment : String read FmarketSegment write FmarketSegment;
    property CustomerEmail : String read FCustomerEmail write FCustomerEmail;
    property CustomerWebsite : String read FCustomerWebsite write FCustomerWebsite;
    property useStayTax : Byte read FuseStayTax write FuseStayTax;
    property Channel : Integer read FChannel write FChannel;
    property eventsProcessed : Byte read FeventsProcessed write FeventsProcessed;
    property alteredReservation : Byte read FalteredReservation write FalteredReservation;
    property externalIds : String read FexternalIds write FexternalIds;
    property dtCreated : TTimeStamp read FdtCreated write FdtCreated;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTbldelreservationsEntity = Array Of TTbldelreservationsEntity;

  TTbldelroomreservationsEntity = class(TPersistent)
  private
    FID: Integer; 
    FrrID: Integer; 
    FRoomReservation: Integer; 
    FRoom: String; 
    FReservation: Integer; 
    FStatus: String; 
    FGroupAccount: Byte; 
    FinvBreakfast: Byte; 
    FRoomPrice1: Double; 
    FPrice1From: String; 
    FPrice1To: String; 
    FRoomPrice2: Double; 
    FPrice2From: String; 
    FPrice2To: String; 
    FRoomPrice3: Double; 
    FPrice3From: String; 
    FPrice3To: String; 
    FCurrency: String; 
    FDiscount: Double; 
    FPercentage: Byte; 
    FPriceType: String; 
    FArrival: String; 
    FDeparture: String; 
    FRoomType: String; 
    FPMInfo: String; 
    FHiddenInfo: String; 
    FRoomRentPaid1: Double; 
    FRoomRentPaid2: Double; 
    FRoomRentPaid3: Double; 
    FRoomRentPaymentInvoice: Integer; 
    FHallres: Integer; 
    FrrTmp: String; 
    FrrDescription: String; 
    FrrArrival: TTimeStamp; 
    FrrDeparture: TTimeStamp; 
    FrrIsNoRoom: Byte; 
    FrrRoomAlias: String; 
    FrrRoomTypeAlias: String; 
    FuseStayTax: Byte; 
    FCancelDate: TTimeStamp; 
    FCancelStaff: String; 
    FCancelReason: String; 
    FCancelRequest: String; 
    FCancelInformation: String; 
    FCancelType: Integer; 
    FuseInNationalReport: Byte; 
    FnumGuests: Integer; 
    FnumChildren: Integer; 
    FnumInfants: Integer; 
    FAvrageRate: String; 
    FRateCount: Integer; 
    FdtCreated: TTimeStamp; 
    FRoomClass: String; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setRrID(rrID: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setRoom(Room: String); 
    procedure setReservation(Reservation: Integer); 
    procedure setStatus(Status: String); 
    procedure setGroupAccount(GroupAccount: Byte); 
    procedure setInvBreakfast(invBreakfast: Byte); 
    procedure setRoomPrice1(RoomPrice1: Double); 
    procedure setPrice1From(Price1From: String); 
    procedure setPrice1To(Price1To: String); 
    procedure setRoomPrice2(RoomPrice2: Double); 
    procedure setPrice2From(Price2From: String); 
    procedure setPrice2To(Price2To: String); 
    procedure setRoomPrice3(RoomPrice3: Double); 
    procedure setPrice3From(Price3From: String); 
    procedure setPrice3To(Price3To: String); 
    procedure setCurrency(Currency: String); 
    procedure setDiscount(Discount: Double); 
    procedure setPercentage(Percentage: Byte); 
    procedure setPriceType(PriceType: String); 
    procedure setArrival(Arrival: String); 
    procedure setDeparture(Departure: String); 
    procedure setRoomType(RoomType: String); 
    procedure setPMInfo(PMInfo: String); 
    procedure setHiddenInfo(HiddenInfo: String); 
    procedure setRoomRentPaid1(RoomRentPaid1: Double); 
    procedure setRoomRentPaid2(RoomRentPaid2: Double); 
    procedure setRoomRentPaid3(RoomRentPaid3: Double); 
    procedure setRoomRentPaymentInvoice(RoomRentPaymentInvoice: Integer); 
    procedure setHallres(Hallres: Integer); 
    procedure setRrTmp(rrTmp: String); 
    procedure setRrDescription(rrDescription: String); 
    procedure setRrArrival(rrArrival: TTimeStamp); 
    procedure setRrDeparture(rrDeparture: TTimeStamp); 
    procedure setRrIsNoRoom(rrIsNoRoom: Byte); 
    procedure setRrRoomAlias(rrRoomAlias: String); 
    procedure setRrRoomTypeAlias(rrRoomTypeAlias: String); 
    procedure setUseStayTax(useStayTax: Byte); 
    procedure setCancelDate(CancelDate: TTimeStamp); 
    procedure setCancelStaff(CancelStaff: String); 
    procedure setCancelReason(CancelReason: String); 
    procedure setCancelRequest(CancelRequest: String); 
    procedure setCancelInformation(CancelInformation: String); 
    procedure setCancelType(CancelType: Integer); 
    procedure setUseInNationalReport(useInNationalReport: Byte); 
    procedure setNumGuests(numGuests: Integer); 
    procedure setNumChildren(numChildren: Integer); 
    procedure setNumInfants(numInfants: Integer); 
    procedure setAvrageRate(AvrageRate: String); 
    procedure setRateCount(RateCount: Integer); 
    procedure setDtCreated(dtCreated: TTimeStamp); 
    procedure setRoomClass(RoomClass: String); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property rrID : Integer read FrrID write FrrID;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Room : String read FRoom write FRoom;
    property Reservation : Integer read FReservation write FReservation;
    property Status : String read FStatus write FStatus;
    property GroupAccount : Byte read FGroupAccount write FGroupAccount;
    property invBreakfast : Byte read FinvBreakfast write FinvBreakfast;
    property RoomPrice1 : Double read FRoomPrice1 write FRoomPrice1;
    property Price1From : String read FPrice1From write FPrice1From;
    property Price1To : String read FPrice1To write FPrice1To;
    property RoomPrice2 : Double read FRoomPrice2 write FRoomPrice2;
    property Price2From : String read FPrice2From write FPrice2From;
    property Price2To : String read FPrice2To write FPrice2To;
    property RoomPrice3 : Double read FRoomPrice3 write FRoomPrice3;
    property Price3From : String read FPrice3From write FPrice3From;
    property Price3To : String read FPrice3To write FPrice3To;
    property Currency : String read FCurrency write FCurrency;
    property Discount : Double read FDiscount write FDiscount;
    property Percentage : Byte read FPercentage write FPercentage;
    property PriceType : String read FPriceType write FPriceType;
    property Arrival : String read FArrival write FArrival;
    property Departure : String read FDeparture write FDeparture;
    property RoomType : String read FRoomType write FRoomType;
    property PMInfo : String read FPMInfo write FPMInfo;
    property HiddenInfo : String read FHiddenInfo write FHiddenInfo;
    property RoomRentPaid1 : Double read FRoomRentPaid1 write FRoomRentPaid1;
    property RoomRentPaid2 : Double read FRoomRentPaid2 write FRoomRentPaid2;
    property RoomRentPaid3 : Double read FRoomRentPaid3 write FRoomRentPaid3;
    property RoomRentPaymentInvoice : Integer read FRoomRentPaymentInvoice write FRoomRentPaymentInvoice;
    property Hallres : Integer read FHallres write FHallres;
    property rrTmp : String read FrrTmp write FrrTmp;
    property rrDescription : String read FrrDescription write FrrDescription;
    property rrArrival : TTimeStamp read FrrArrival write FrrArrival;
    property rrDeparture : TTimeStamp read FrrDeparture write FrrDeparture;
    property rrIsNoRoom : Byte read FrrIsNoRoom write FrrIsNoRoom;
    property rrRoomAlias : String read FrrRoomAlias write FrrRoomAlias;
    property rrRoomTypeAlias : String read FrrRoomTypeAlias write FrrRoomTypeAlias;
    property useStayTax : Byte read FuseStayTax write FuseStayTax;
    property CancelDate : TTimeStamp read FCancelDate write FCancelDate;
    property CancelStaff : String read FCancelStaff write FCancelStaff;
    property CancelReason : String read FCancelReason write FCancelReason;
    property CancelRequest : String read FCancelRequest write FCancelRequest;
    property CancelInformation : String read FCancelInformation write FCancelInformation;
    property CancelType : Integer read FCancelType write FCancelType;
    property useInNationalReport : Byte read FuseInNationalReport write FuseInNationalReport;
    property numGuests : Integer read FnumGuests write FnumGuests;
    property numChildren : Integer read FnumChildren write FnumChildren;
    property numInfants : Integer read FnumInfants write FnumInfants;
    property AvrageRate : String read FAvrageRate write FAvrageRate;
    property RateCount : Integer read FRateCount write FRateCount;
    property dtCreated : TTimeStamp read FdtCreated write FdtCreated;
    property RoomClass : String read FRoomClass write FRoomClass;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTbldelroomreservationsEntity = Array Of TTbldelroomreservationsEntity;

  TTblhiddeninfoEntity = class(TPersistent)
  private
    FID: Integer; 
    FNotes: String; 
    FDeleteOn: TTimeStamp; 
    FViewLog: String; 
    FRefrence: Integer; 
    FRefrenceType: Integer; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setNotes(Notes: String); 
    procedure setDeleteOn(DeleteOn: TTimeStamp); 
    procedure setViewLog(ViewLog: String); 
    procedure setRefrence(Refrence: Integer); 
    procedure setRefrenceType(RefrenceType: Integer); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property Notes : String read FNotes write FNotes;
    property DeleteOn : TTimeStamp read FDeleteOn write FDeleteOn;
    property ViewLog : String read FViewLog write FViewLog;
    property Refrence : Integer read FRefrence write FRefrence;
    property RefrenceType : Integer read FRefrenceType write FRefrenceType;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblhiddeninfoEntity = Array Of TTblhiddeninfoEntity;

  TTblimportlogsEntity = class(TPersistent)
  private
    FId: Integer; 
    FDateInsert: TTimeStamp; 
    FDateExport: TTimeStamp; 
    FImportTypeID: Integer; 
    FImportData: String; 
    FImportResultID: Integer; 
    FReservation: Integer; 
    FRoomReservation: Integer; 
    FCustomer: String; 
    FItemCount: Integer; 
    FHotelCode: String; 
    FStaff: String; 
    FRoomNumber: String; 
    FisGroupInvoice: Byte; 
    FinvCustomer: String; 
    FinvPersonalID: String; 
    FinvCustomerName: String; 
    FinvAddress1: String; 
    FinvAddress2: String; 
    FinvAddress3: String; 
    FinvAddress4: String; 
    FGuestName: String; 
    FSaleRefrence: String; 
    FinvoiceNumber: Integer; 
    Fjson: String; 
  public
    procedure setId(Id: Integer); 
    procedure setDateInsert(DateInsert: TTimeStamp); 
    procedure setDateExport(DateExport: TTimeStamp); 
    procedure setImportTypeID(ImportTypeID: Integer); 
    procedure setImportData(ImportData: String); 
    procedure setImportResultID(ImportResultID: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setCustomer(Customer: String); 
    procedure setItemCount(ItemCount: Integer); 
    procedure setHotelCode(HotelCode: String); 
    procedure setStaff(Staff: String); 
    procedure setRoomNumber(RoomNumber: String); 
    procedure setIsGroupInvoice(isGroupInvoice: Byte); 
    procedure setInvCustomer(invCustomer: String); 
    procedure setInvPersonalID(invPersonalID: String); 
    procedure setInvCustomerName(invCustomerName: String); 
    procedure setInvAddress1(invAddress1: String); 
    procedure setInvAddress2(invAddress2: String); 
    procedure setInvAddress3(invAddress3: String); 
    procedure setInvAddress4(invAddress4: String); 
    procedure setGuestName(GuestName: String); 
    procedure setSaleRefrence(SaleRefrence: String); 
    procedure setInvoiceNumber(invoiceNumber: Integer); 
    procedure setJson(json: String); 
  published
    property Id : Integer read FId write FId;
    property DateInsert : TTimeStamp read FDateInsert write FDateInsert;
    property DateExport : TTimeStamp read FDateExport write FDateExport;
    property ImportTypeID : Integer read FImportTypeID write FImportTypeID;
    property ImportData : String read FImportData write FImportData;
    property ImportResultID : Integer read FImportResultID write FImportResultID;
    property Reservation : Integer read FReservation write FReservation;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Customer : String read FCustomer write FCustomer;
    property ItemCount : Integer read FItemCount write FItemCount;
    property HotelCode : String read FHotelCode write FHotelCode;
    property Staff : String read FStaff write FStaff;
    property RoomNumber : String read FRoomNumber write FRoomNumber;
    property isGroupInvoice : Byte read FisGroupInvoice write FisGroupInvoice;
    property invCustomer : String read FinvCustomer write FinvCustomer;
    property invPersonalID : String read FinvPersonalID write FinvPersonalID;
    property invCustomerName : String read FinvCustomerName write FinvCustomerName;
    property invAddress1 : String read FinvAddress1 write FinvAddress1;
    property invAddress2 : String read FinvAddress2 write FinvAddress2;
    property invAddress3 : String read FinvAddress3 write FinvAddress3;
    property invAddress4 : String read FinvAddress4 write FinvAddress4;
    property GuestName : String read FGuestName write FGuestName;
    property SaleRefrence : String read FSaleRefrence write FSaleRefrence;
    property invoiceNumber : Integer read FinvoiceNumber write FinvoiceNumber;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblimportlogsEntity = Array Of TTblimportlogsEntity;

  TTblincEntity = class(TPersistent)
  private
    FCustlast: Integer; 
    FCustLength: Integer; 
    FCustFill: String; 
    FID: Integer; 
    Fjson: String; 
  public
    procedure setCustlast(Custlast: Integer); 
    procedure setCustLength(CustLength: Integer); 
    procedure setCustFill(CustFill: String); 
    procedure setID(ID: Integer); 
    procedure setJson(json: String); 
  published
    property Custlast : Integer read FCustlast write FCustlast;
    property CustLength : Integer read FCustLength write FCustLength;
    property CustFill : String read FCustFill write FCustFill;
    property ID : Integer read FID write FID;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblincEntity = Array Of TTblincEntity;

  TTblinvoiceactionsEntity = class(TPersistent)
  private
    FID: Integer; 
    FReservation: Integer; 
    FRoomReservation: Integer; 
    FInvoiceNumber: Integer; 
    FActionDate: TTimeStamp; 
    FActionID: Integer; 
    FAction: String; 
    FActionNote: String; 
    FStaff: String; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setInvoiceNumber(InvoiceNumber: Integer); 
    procedure setActionDate(ActionDate: TTimeStamp); 
    procedure setActionID(ActionID: Integer); 
    procedure setAction(Action: String); 
    procedure setActionNote(ActionNote: String); 
    procedure setStaff(Staff: String); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property Reservation : Integer read FReservation write FReservation;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property InvoiceNumber : Integer read FInvoiceNumber write FInvoiceNumber;
    property ActionDate : TTimeStamp read FActionDate write FActionDate;
    property ActionID : Integer read FActionID write FActionID;
    property Action : String read FAction write FAction;
    property ActionNote : String read FActionNote write FActionNote;
    property Staff : String read FStaff write FStaff;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblinvoiceactionsEntity = Array Of TTblinvoiceactionsEntity;

  TTblmaidactionsEntity = class(TPersistent)
  private
    FID: Integer; 
    FmaAction: String; 
    FmaDescription: String; 
    FmaRule: String; 
    FmaUse: Byte; 
    FmaCross: Byte; 
    FActive: Byte; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setMaAction(maAction: String); 
    procedure setMaDescription(maDescription: String); 
    procedure setMaRule(maRule: String); 
    procedure setMaUse(maUse: Byte); 
    procedure setMaCross(maCross: Byte); 
    procedure setActive(Active: Byte); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property maAction : String read FmaAction write FmaAction;
    property maDescription : String read FmaDescription write FmaDescription;
    property maRule : String read FmaRule write FmaRule;
    property maUse : Byte read FmaUse write FmaUse;
    property maCross : Byte read FmaCross write FmaCross;
    property Active : Byte read FActive write FActive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblmaidactionsEntity = Array Of TTblmaidactionsEntity;

  TTblmaidjobsEntity = class(TPersistent)
  private
    FID: Integer; 
    FmjDate: TTimeStamp; 
    FmjRoom: String; 
    FmjAction: String; 
    FmjDescription: String; 
    FmjFinished: Byte; 
    FmjNote: String; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setMjDate(mjDate: TTimeStamp); 
    procedure setMjRoom(mjRoom: String); 
    procedure setMjAction(mjAction: String); 
    procedure setMjDescription(mjDescription: String); 
    procedure setMjFinished(mjFinished: Byte); 
    procedure setMjNote(mjNote: String); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property mjDate : TTimeStamp read FmjDate write FmjDate;
    property mjRoom : String read FmjRoom write FmjRoom;
    property mjAction : String read FmjAction write FmjAction;
    property mjDescription : String read FmjDescription write FmjDescription;
    property mjFinished : Byte read FmjFinished write FmjFinished;
    property mjNote : String read FmjNote write FmjNote;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblmaidjobsEntity = Array Of TTblmaidjobsEntity;

  TTblmaidlistsEntity = class(TPersistent)
  private
    FmlDate: TTimeStamp; 
    FRoom: String; 
    FRoomType: String; 
    FNumberGuests: Integer; 
    FGuestCount: Integer; 
    FExtraGuest: Integer; 
    FGuestStatus: String; 
    FStayDay: Integer; 
    FCheckIn: Integer; 
    FCheckOut: Integer; 
    FWeekDay: Integer; 
    FWeekEnd: Byte; 
    FLocation: String; 
    FFloor: Integer; 
    FHidden: Byte; 
    FRoomStatus: String; 
    FRoomDescription: String; 
    FRoomTypeDescription: String; 
    FArrival: TTimeStamp; 
    FDeparture: TTimeStamp; 
    FLastCheckOutDate: TTimeStamp; 
    FLastCheckOut: Integer; 
    FNextCheckInDate: TTimeStamp; 
    FNextCheckIn: Integer; 
    FRoomReservation: Integer; 
    FReservation: Integer; 
    FNextRoomReservation: Integer; 
    FLastRoomReservation: Integer; 
    FLastUpdate: TTimeStamp; 
    FNotes: String; 
    FFirstGuest: String; 
    FResName: String; 
    FResStatus: String; 
    FJobPr: String; 
    FID: Integer; 
    Fjson: String; 
  public
    procedure setMlDate(mlDate: TTimeStamp); 
    procedure setRoom(Room: String); 
    procedure setRoomType(RoomType: String); 
    procedure setNumberGuests(NumberGuests: Integer); 
    procedure setGuestCount(GuestCount: Integer); 
    procedure setExtraGuest(ExtraGuest: Integer); 
    procedure setGuestStatus(GuestStatus: String); 
    procedure setStayDay(StayDay: Integer); 
    procedure setCheckIn(CheckIn: Integer); 
    procedure setCheckOut(CheckOut: Integer); 
    procedure setWeekDay(WeekDay: Integer); 
    procedure setWeekEnd(WeekEnd: Byte); 
    procedure setLocation(Location: String); 
    procedure setFloor(Floor: Integer); 
    procedure setHidden(Hidden: Byte); 
    procedure setRoomStatus(RoomStatus: String); 
    procedure setRoomDescription(RoomDescription: String); 
    procedure setRoomTypeDescription(RoomTypeDescription: String); 
    procedure setArrival(Arrival: TTimeStamp); 
    procedure setDeparture(Departure: TTimeStamp); 
    procedure setLastCheckOutDate(LastCheckOutDate: TTimeStamp); 
    procedure setLastCheckOut(LastCheckOut: Integer); 
    procedure setNextCheckInDate(NextCheckInDate: TTimeStamp); 
    procedure setNextCheckIn(NextCheckIn: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setNextRoomReservation(NextRoomReservation: Integer); 
    procedure setLastRoomReservation(LastRoomReservation: Integer); 
    procedure setLastUpdate(LastUpdate: TTimeStamp); 
    procedure setNotes(Notes: String); 
    procedure setFirstGuest(FirstGuest: String); 
    procedure setResName(ResName: String); 
    procedure setResStatus(ResStatus: String); 
    procedure setJobPr(JobPr: String); 
    procedure setID(ID: Integer); 
    procedure setJson(json: String); 
  published
    property mlDate : TTimeStamp read FmlDate write FmlDate;
    property Room : String read FRoom write FRoom;
    property RoomType : String read FRoomType write FRoomType;
    property NumberGuests : Integer read FNumberGuests write FNumberGuests;
    property GuestCount : Integer read FGuestCount write FGuestCount;
    property ExtraGuest : Integer read FExtraGuest write FExtraGuest;
    property GuestStatus : String read FGuestStatus write FGuestStatus;
    property StayDay : Integer read FStayDay write FStayDay;
    property CheckIn : Integer read FCheckIn write FCheckIn;
    property CheckOut : Integer read FCheckOut write FCheckOut;
    property WeekDay : Integer read FWeekDay write FWeekDay;
    property WeekEnd : Byte read FWeekEnd write FWeekEnd;
    property Location : String read FLocation write FLocation;
    property Floor : Integer read FFloor write FFloor;
    property Hidden : Byte read FHidden write FHidden;
    property RoomStatus : String read FRoomStatus write FRoomStatus;
    property RoomDescription : String read FRoomDescription write FRoomDescription;
    property RoomTypeDescription : String read FRoomTypeDescription write FRoomTypeDescription;
    property Arrival : TTimeStamp read FArrival write FArrival;
    property Departure : TTimeStamp read FDeparture write FDeparture;
    property LastCheckOutDate : TTimeStamp read FLastCheckOutDate write FLastCheckOutDate;
    property LastCheckOut : Integer read FLastCheckOut write FLastCheckOut;
    property NextCheckInDate : TTimeStamp read FNextCheckInDate write FNextCheckInDate;
    property NextCheckIn : Integer read FNextCheckIn write FNextCheckIn;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Reservation : Integer read FReservation write FReservation;
    property NextRoomReservation : Integer read FNextRoomReservation write FNextRoomReservation;
    property LastRoomReservation : Integer read FLastRoomReservation write FLastRoomReservation;
    property LastUpdate : TTimeStamp read FLastUpdate write FLastUpdate;
    property Notes : String read FNotes write FNotes;
    property FirstGuest : String read FFirstGuest write FFirstGuest;
    property ResName : String read FResName write FResName;
    property ResStatus : String read FResStatus write FResStatus;
    property JobPr : String read FJobPr write FJobPr;
    property ID : Integer read FID write FID;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblmaidlistsEntity = Array Of TTblmaidlistsEntity;

  TTblpoxexportEntity = class(TPersistent)
  private
    FID: Integer; 
    FInvoiceNumber: Integer; 
    FReservation: Integer; 
    FRoomReservation: Integer; 
    FInsertDate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setInvoiceNumber(InvoiceNumber: Integer); 
    procedure setReservation(Reservation: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setInsertDate(InsertDate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property InvoiceNumber : Integer read FInvoiceNumber write FInvoiceNumber;
    property Reservation : Integer read FReservation write FReservation;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property InsertDate : TTimeStamp read FInsertDate write FInsertDate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblpoxexportEntity = Array Of TTblpoxexportEntity;

  TTblpricecodesEntity = class(TPersistent)
  private
    FID: Integer; 
    FpcCode: String; 
    FpcDescription: String; 
    FpcActive: Byte; 
    FpcRack: Byte; 
    FpcRackCalc: Double; 
    FpcShowDiscount: Byte; 
    FpcDiscountText: String; 
    FpcAutomatic: Byte; 
    FpcLastUpdate: TTimeStamp; 
    FpcDiscountDaysAfter: Integer; 
    FpcDiscountPriceAfter: Double; 
    FpcDiscountMethod: Byte; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setPcCode(pcCode: String); 
    procedure setPcDescription(pcDescription: String); 
    procedure setPcActive(pcActive: Byte); 
    procedure setPcRack(pcRack: Byte); 
    procedure setPcRackCalc(pcRackCalc: Double); 
    procedure setPcShowDiscount(pcShowDiscount: Byte); 
    procedure setPcDiscountText(pcDiscountText: String); 
    procedure setPcAutomatic(pcAutomatic: Byte); 
    procedure setPcLastUpdate(pcLastUpdate: TTimeStamp); 
    procedure setPcDiscountDaysAfter(pcDiscountDaysAfter: Integer); 
    procedure setPcDiscountPriceAfter(pcDiscountPriceAfter: Double); 
    procedure setPcDiscountMethod(pcDiscountMethod: Byte); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property pcCode : String read FpcCode write FpcCode;
    property pcDescription : String read FpcDescription write FpcDescription;
    property pcActive : Byte read FpcActive write FpcActive;
    property pcRack : Byte read FpcRack write FpcRack;
    property pcRackCalc : Double read FpcRackCalc write FpcRackCalc;
    property pcShowDiscount : Byte read FpcShowDiscount write FpcShowDiscount;
    property pcDiscountText : String read FpcDiscountText write FpcDiscountText;
    property pcAutomatic : Byte read FpcAutomatic write FpcAutomatic;
    property pcLastUpdate : TTimeStamp read FpcLastUpdate write FpcLastUpdate;
    property pcDiscountDaysAfter : Integer read FpcDiscountDaysAfter write FpcDiscountDaysAfter;
    property pcDiscountPriceAfter : Double read FpcDiscountPriceAfter write FpcDiscountPriceAfter;
    property pcDiscountMethod : Byte read FpcDiscountMethod write FpcDiscountMethod;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblpricecodesEntity = Array Of TTblpricecodesEntity;

  TTblroomstatusEntity = class(TPersistent)
  private
    FresDate: TTimeStamp; 
    FRoomType: String; 
    Favailable: Integer; 
    FID: Integer; 
    Fjson: String; 
  public
    procedure setResDate(resDate: TTimeStamp); 
    procedure setRoomType(RoomType: String); 
    procedure setAvailable(available: Integer); 
    procedure setID(ID: Integer); 
    procedure setJson(json: String); 
  published
    property resDate : TTimeStamp read FresDate write FresDate;
    property RoomType : String read FRoomType write FRoomType;
    property available : Integer read Favailable write Favailable;
    property ID : Integer read FID write FID;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblroomstatusEntity = Array Of TTblroomstatusEntity;

  TTblseasonsEntity = class(TPersistent)
  private
    FID: Integer; 
    FseStartDate: TTimeStamp; 
    FseEndDate: TTimeStamp; 
    FseDescription: String; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setSeStartDate(seStartDate: TTimeStamp); 
    procedure setSeEndDate(seEndDate: TTimeStamp); 
    procedure setSeDescription(seDescription: String); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property seStartDate : TTimeStamp read FseStartDate write FseStartDate;
    property seEndDate : TTimeStamp read FseEndDate write FseEndDate;
    property seDescription : String read FseDescription write FseDescription;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTblseasonsEntity = Array Of TTblseasonsEntity;

  TTeldevicesEntity = class(TPersistent)
  private
    FDevice: String; 
    FDescription: String; 
    FRoom: String; 
    FdoCharge: Byte; 
    FID: Integer; 
    FActive: Byte; 
    Fjson: String; 
  public
    procedure setDevice(Device: String); 
    procedure setDescription(Description: String); 
    procedure setRoom(Room: String); 
    procedure setDoCharge(doCharge: Byte); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setJson(json: String); 
  published
    property Device : String read FDevice write FDevice;
    property Description : String read FDescription write FDescription;
    property Room : String read FRoom write FRoom;
    property doCharge : Byte read FdoCharge write FdoCharge;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTeldevicesEntity = Array Of TTeldevicesEntity;

  TTellogEntity = class(TPersistent)
  private
    FID: Integer; 
    FLogDateTime: TTimeStamp; 
    FCallId: Integer; 
    FCallStart: TTimeStamp; 
    FConnectedTime: String; 
    FRingTime: Integer; 
    FCaller: String; 
    FDirection: String; 
    FIsExternal: Byte; 
    FCalledNumber: String; 
    FDialledNumber: String; 
    FAccount: String; 
    FContinuation: Byte; 
    FParty1Device: String; 
    FParty1Name: String; 
    FParty2Device: String; 
    FParty2Name: String; 
    FHoldTime: Integer; 
    FParkTime: Integer; 
    FRoom: String; 
    FReservation: Integer; 
    FRoomReservation: Integer; 
    FInvoiceNumber: Integer; 
    FPriceRule: String; 
    FPriceGroup: String; 
    FminutePrice: Double; 
    FstartPrice: Double; 
    FchargedTime: Integer; 
    FChargedAmount: Double; 
    FImportRefrence: String; 
    FIsInternal: Byte; 
    FDescription: String; 
    FAuthValid: Byte; 
    FAuthCode: String; 
    FUserCharged: String; 
    FCallCharge: Double; 
    FCurrency: String; 
    FAmountAtLastUserChange: Double; 
    FCallUnits: Integer; 
    FUnitsAtLastUserChange: Integer; 
    FCostPerUnit: Integer; 
    FMarkUp: Integer; 
    FExternalTargetingCause: String; 
    FExternalTargeterId: String; 
    FExternalTargetedNumber: String; 
    FRecordSource: String; 
    FConnectedTimeSec: Integer; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setLogDateTime(LogDateTime: TTimeStamp); 
    procedure setCallId(CallId: Integer); 
    procedure setCallStart(CallStart: TTimeStamp); 
    procedure setConnectedTime(ConnectedTime: String); 
    procedure setRingTime(RingTime: Integer); 
    procedure setCaller(Caller: String); 
    procedure setDirection(Direction: String); 
    procedure setIsExternal(IsExternal: Byte); 
    procedure setCalledNumber(CalledNumber: String); 
    procedure setDialledNumber(DialledNumber: String); 
    procedure setAccount(Account: String); 
    procedure setContinuation(Continuation: Byte); 
    procedure setParty1Device(Party1Device: String); 
    procedure setParty1Name(Party1Name: String); 
    procedure setParty2Device(Party2Device: String); 
    procedure setParty2Name(Party2Name: String); 
    procedure setHoldTime(HoldTime: Integer); 
    procedure setParkTime(ParkTime: Integer); 
    procedure setRoom(Room: String); 
    procedure setReservation(Reservation: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setInvoiceNumber(InvoiceNumber: Integer); 
    procedure setPriceRule(PriceRule: String); 
    procedure setPriceGroup(PriceGroup: String); 
    procedure setMinutePrice(minutePrice: Double); 
    procedure setStartPrice(startPrice: Double); 
    procedure setChargedTime(chargedTime: Integer); 
    procedure setChargedAmount(ChargedAmount: Double); 
    procedure setImportRefrence(ImportRefrence: String); 
    procedure setIsInternal(IsInternal: Byte); 
    procedure setDescription(Description: String); 
    procedure setAuthValid(AuthValid: Byte); 
    procedure setAuthCode(AuthCode: String); 
    procedure setUserCharged(UserCharged: String); 
    procedure setCallCharge(CallCharge: Double); 
    procedure setCurrency(Currency: String); 
    procedure setAmountAtLastUserChange(AmountAtLastUserChange: Double); 
    procedure setCallUnits(CallUnits: Integer); 
    procedure setUnitsAtLastUserChange(UnitsAtLastUserChange: Integer); 
    procedure setCostPerUnit(CostPerUnit: Integer); 
    procedure setMarkUp(MarkUp: Integer); 
    procedure setExternalTargetingCause(ExternalTargetingCause: String); 
    procedure setExternalTargeterId(ExternalTargeterId: String); 
    procedure setExternalTargetedNumber(ExternalTargetedNumber: String); 
    procedure setRecordSource(RecordSource: String); 
    procedure setConnectedTimeSec(ConnectedTimeSec: Integer); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property LogDateTime : TTimeStamp read FLogDateTime write FLogDateTime;
    property CallId : Integer read FCallId write FCallId;
    property CallStart : TTimeStamp read FCallStart write FCallStart;
    property ConnectedTime : String read FConnectedTime write FConnectedTime;
    property RingTime : Integer read FRingTime write FRingTime;
    property Caller : String read FCaller write FCaller;
    property Direction : String read FDirection write FDirection;
    property IsExternal : Byte read FIsExternal write FIsExternal;
    property CalledNumber : String read FCalledNumber write FCalledNumber;
    property DialledNumber : String read FDialledNumber write FDialledNumber;
    property Account : String read FAccount write FAccount;
    property Continuation : Byte read FContinuation write FContinuation;
    property Party1Device : String read FParty1Device write FParty1Device;
    property Party1Name : String read FParty1Name write FParty1Name;
    property Party2Device : String read FParty2Device write FParty2Device;
    property Party2Name : String read FParty2Name write FParty2Name;
    property HoldTime : Integer read FHoldTime write FHoldTime;
    property ParkTime : Integer read FParkTime write FParkTime;
    property Room : String read FRoom write FRoom;
    property Reservation : Integer read FReservation write FReservation;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property InvoiceNumber : Integer read FInvoiceNumber write FInvoiceNumber;
    property PriceRule : String read FPriceRule write FPriceRule;
    property PriceGroup : String read FPriceGroup write FPriceGroup;
    property minutePrice : Double read FminutePrice write FminutePrice;
    property startPrice : Double read FstartPrice write FstartPrice;
    property chargedTime : Integer read FchargedTime write FchargedTime;
    property ChargedAmount : Double read FChargedAmount write FChargedAmount;
    property ImportRefrence : String read FImportRefrence write FImportRefrence;
    property IsInternal : Byte read FIsInternal write FIsInternal;
    property Description : String read FDescription write FDescription;
    property AuthValid : Byte read FAuthValid write FAuthValid;
    property AuthCode : String read FAuthCode write FAuthCode;
    property UserCharged : String read FUserCharged write FUserCharged;
    property CallCharge : Double read FCallCharge write FCallCharge;
    property Currency : String read FCurrency write FCurrency;
    property AmountAtLastUserChange : Double read FAmountAtLastUserChange write FAmountAtLastUserChange;
    property CallUnits : Integer read FCallUnits write FCallUnits;
    property UnitsAtLastUserChange : Integer read FUnitsAtLastUserChange write FUnitsAtLastUserChange;
    property CostPerUnit : Integer read FCostPerUnit write FCostPerUnit;
    property MarkUp : Integer read FMarkUp write FMarkUp;
    property ExternalTargetingCause : String read FExternalTargetingCause write FExternalTargetingCause;
    property ExternalTargeterId : String read FExternalTargeterId write FExternalTargeterId;
    property ExternalTargetedNumber : String read FExternalTargetedNumber write FExternalTargetedNumber;
    property RecordSource : String read FRecordSource write FRecordSource;
    property ConnectedTimeSec : Integer read FConnectedTimeSec write FConnectedTimeSec;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTellogEntity = Array Of TTellogEntity;

  TTelpricegroupsEntity = class(TPersistent)
  private
    FtpgCode: String; 
    FtpgDescription: String; 
    FtpgPrice: Double; 
    FCode: String; 
    FDescription: String; 
    FPrice: Double; 
    FdoUse: Byte; 
    FID: Integer; 
    FActive: Byte; 
    Fjson: String; 
  public
    procedure setTpgCode(tpgCode: String); 
    procedure setTpgDescription(tpgDescription: String); 
    procedure setTpgPrice(tpgPrice: Double); 
    procedure setCode(Code: String); 
    procedure setDescription(Description: String); 
    procedure setPrice(Price: Double); 
    procedure setDoUse(doUse: Byte); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setJson(json: String); 
  published
    property tpgCode : String read FtpgCode write FtpgCode;
    property tpgDescription : String read FtpgDescription write FtpgDescription;
    property tpgPrice : Double read FtpgPrice write FtpgPrice;
    property Code : String read FCode write FCode;
    property Description : String read FDescription write FDescription;
    property Price : Double read FPrice write FPrice;
    property doUse : Byte read FdoUse write FdoUse;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTelpricegroupsEntity = Array Of TTelpricegroupsEntity;

  TTelpricerulesEntity = class(TPersistent)
  private
    FAutogen: String; 
    FtprName: String; 
    FtprMask: String; 
    FtprTpgCode: String; 
    FtprOrder: Integer; 
    FCode: String; 
    FDescription: String; 
    FMask: String; 
    FtpgCode: String; 
    FdisplayOrder: Integer; 
    FdoUse: Byte; 
    FID: Integer; 
    FActive: Byte; 
    Fjson: String; 
  public
    procedure setAutogen(Autogen: String); 
    procedure setTprName(tprName: String); 
    procedure setTprMask(tprMask: String); 
    procedure setTprTpgCode(tprTpgCode: String); 
    procedure setTprOrder(tprOrder: Integer); 
    procedure setCode(Code: String); 
    procedure setDescription(Description: String); 
    procedure setMask(Mask: String); 
    procedure setTpgCode(tpgCode: String); 
    procedure setDisplayOrder(displayOrder: Integer); 
    procedure setDoUse(doUse: Byte); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setJson(json: String); 
  published
    property Autogen : String read FAutogen write FAutogen;
    property tprName : String read FtprName write FtprName;
    property tprMask : String read FtprMask write FtprMask;
    property tprTpgCode : String read FtprTpgCode write FtprTpgCode;
    property tprOrder : Integer read FtprOrder write FtprOrder;
    property Code : String read FCode write FCode;
    property Description : String read FDescription write FDescription;
    property Mask : String read FMask write FMask;
    property tpgCode : String read FtpgCode write FtpgCode;
    property displayOrder : Integer read FdisplayOrder write FdisplayOrder;
    property doUse : Byte read FdoUse write FdoUse;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTelpricerulesEntity = Array Of TTelpricerulesEntity;

  TTestnamesEntity = class(TPersistent)
  private
    Fnumber: Integer; 
    Fgender: String; 
    Ftitle: String; 
    Fgivenname: String; 
    Fsurname: String; 
    Fstreetaddress: String; 
    Fcity: String; 
    Fstate: String; 
    Fzipcode: String; 
    Fcountry: String; 
    Fcountryfull: String; 
    Femailaddress: String; 
    Ftelephonenumber: String; 
    Fnationalid: String; 
    Fjson: String; 
  public
    procedure setNumber(number: Integer); 
    procedure setGender(gender: String); 
    procedure setTitle(title: String); 
    procedure setGivenname(givenname: String); 
    procedure setSurname(surname: String); 
    procedure setStreetaddress(streetaddress: String); 
    procedure setCity(city: String); 
    procedure setState(state: String); 
    procedure setZipcode(zipcode: String); 
    procedure setCountry(country: String); 
    procedure setCountryfull(countryfull: String); 
    procedure setEmailaddress(emailaddress: String); 
    procedure setTelephonenumber(telephonenumber: String); 
    procedure setNationalid(nationalid: String); 
    procedure setJson(json: String); 
  published
    property number : Integer read Fnumber write Fnumber;
    property gender : String read Fgender write Fgender;
    property title : String read Ftitle write Ftitle;
    property givenname : String read Fgivenname write Fgivenname;
    property surname : String read Fsurname write Fsurname;
    property streetaddress : String read Fstreetaddress write Fstreetaddress;
    property city : String read Fcity write Fcity;
    property state : String read Fstate write Fstate;
    property zipcode : String read Fzipcode write Fzipcode;
    property country : String read Fcountry write Fcountry;
    property countryfull : String read Fcountryfull write Fcountryfull;
    property emailaddress : String read Femailaddress write Femailaddress;
    property telephonenumber : String read Ftelephonenumber write Ftelephonenumber;
    property nationalid : String read Fnationalid write Fnationalid;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTestnamesEntity = Array Of TTestnamesEntity;

  TTtmpEntity = class(TPersistent)
  private
    FReservation: Integer; 
    FRoomReservation: Integer; 
    FRoom: String; 
    FRoomType: String; 
    FaDate: TTimeStamp; 
    FResStatus: String; 
    FRRAmountNo: Double; 
    FRRDiscAmountNo: Double; 
    FRRAmountYES: Double; 
    FRRDiscAmountYES: Double; 
    FGoodsAmountYes: Double; 
    FGoodsAmountNo: Double; 
    FRoomAmount: Double; 
    FDayIndex: Integer; 
    FRRTotalNo: Double; 
    FRRTotalYes: Double; 
    FRRTotal: Double; 
    FGoodsTotal: Double; 
    FYesTotal: Double; 
    FNoTotal: Double; 
    FTotal: Double; 
    FWeekNo: Integer; 
    FDayNo: Integer; 
    FMonthNo: Integer; 
    FYearNo: Integer; 
    FWeekDay: Integer; 
    FID: Integer; 
    Fjson: String; 
  public
    procedure setReservation(Reservation: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setRoom(Room: String); 
    procedure setRoomType(RoomType: String); 
    procedure setADate(aDate: TTimeStamp); 
    procedure setResStatus(ResStatus: String); 
    procedure setRRAmountNo(RRAmountNo: Double); 
    procedure setRRDiscAmountNo(RRDiscAmountNo: Double); 
    procedure setRRAmountYES(RRAmountYES: Double); 
    procedure setRRDiscAmountYES(RRDiscAmountYES: Double); 
    procedure setGoodsAmountYes(GoodsAmountYes: Double); 
    procedure setGoodsAmountNo(GoodsAmountNo: Double); 
    procedure setRoomAmount(RoomAmount: Double); 
    procedure setDayIndex(DayIndex: Integer); 
    procedure setRRTotalNo(RRTotalNo: Double); 
    procedure setRRTotalYes(RRTotalYes: Double); 
    procedure setRRTotal(RRTotal: Double); 
    procedure setGoodsTotal(GoodsTotal: Double); 
    procedure setYesTotal(YesTotal: Double); 
    procedure setNoTotal(NoTotal: Double); 
    procedure setTotal(Total: Double); 
    procedure setWeekNo(WeekNo: Integer); 
    procedure setDayNo(DayNo: Integer); 
    procedure setMonthNo(MonthNo: Integer); 
    procedure setYearNo(YearNo: Integer); 
    procedure setWeekDay(WeekDay: Integer); 
    procedure setID(ID: Integer); 
    procedure setJson(json: String); 
  published
    property Reservation : Integer read FReservation write FReservation;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property Room : String read FRoom write FRoom;
    property RoomType : String read FRoomType write FRoomType;
    property aDate : TTimeStamp read FaDate write FaDate;
    property ResStatus : String read FResStatus write FResStatus;
    property RRAmountNo : Double read FRRAmountNo write FRRAmountNo;
    property RRDiscAmountNo : Double read FRRDiscAmountNo write FRRDiscAmountNo;
    property RRAmountYES : Double read FRRAmountYES write FRRAmountYES;
    property RRDiscAmountYES : Double read FRRDiscAmountYES write FRRDiscAmountYES;
    property GoodsAmountYes : Double read FGoodsAmountYes write FGoodsAmountYes;
    property GoodsAmountNo : Double read FGoodsAmountNo write FGoodsAmountNo;
    property RoomAmount : Double read FRoomAmount write FRoomAmount;
    property DayIndex : Integer read FDayIndex write FDayIndex;
    property RRTotalNo : Double read FRRTotalNo write FRRTotalNo;
    property RRTotalYes : Double read FRRTotalYes write FRRTotalYes;
    property RRTotal : Double read FRRTotal write FRRTotal;
    property GoodsTotal : Double read FGoodsTotal write FGoodsTotal;
    property YesTotal : Double read FYesTotal write FYesTotal;
    property NoTotal : Double read FNoTotal write FNoTotal;
    property Total : Double read FTotal write FTotal;
    property WeekNo : Integer read FWeekNo write FWeekNo;
    property DayNo : Integer read FDayNo write FDayNo;
    property MonthNo : Integer read FMonthNo write FMonthNo;
    property YearNo : Integer read FYearNo write FYearNo;
    property WeekDay : Integer read FWeekDay write FWeekDay;
    property ID : Integer read FID write FID;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TTtmpEntity = Array Of TTtmpEntity;

  TVatcodesEntity = class(TPersistent)
  private
    FVATCode: String; 
    FDescription: String; 
    FVATPercentage: Double; 
    FID: Integer; 
    FActive: Byte; 
    FlastUpdate: TTimeStamp; 
    Fjson: String; 
  public
    procedure setVATCode(VATCode: String); 
    procedure setDescription(Description: String); 
    procedure setVATPercentage(VATPercentage: Double); 
    procedure setID(ID: Integer); 
    procedure setActive(Active: Byte); 
    procedure setLastUpdate(lastUpdate: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property VATCode : String read FVATCode write FVATCode;
    property Description : String read FDescription write FDescription;
    property VATPercentage : Double read FVATPercentage write FVATPercentage;
    property ID : Integer read FID write FID;
    property Active : Byte read FActive write FActive;
    property lastUpdate : TTimeStamp read FlastUpdate write FlastUpdate;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TVatcodesEntity = Array Of TVatcodesEntity;

  TViewroomprices1Entity = class(TPersistent)
  private
    FID: Integer; 
    FseID: Integer; 
    FpcID: Integer; 
    FRoomType: String; 
    FCurrency: String; 
    FDescription: String; 
    FPrice1Person: Double; 
    FPrice2Persons: Double; 
    FPrice3Persons: Double; 
    FPrice4Persons: Double; 
    FPrice5Persons: Double; 
    FPrice6Persons: Double; 
    FPriceExtraPerson: Double; 
    FpcCode: String; 
    FpcDescription: String; 
    FpcActive: Byte; 
    FpcRack: Byte; 
    FpcRackCalc: Double; 
    FpcShowDiscount: Byte; 
    FpcDiscountText: String; 
    FpcAutomatic: Byte; 
    FseStartDate: TTimeStamp; 
    FseEndDate: TTimeStamp; 
    FseDescription: String; 
    FNumberGuests: Integer; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setSeID(seID: Integer); 
    procedure setPcID(pcID: Integer); 
    procedure setRoomType(RoomType: String); 
    procedure setCurrency(Currency: String); 
    procedure setDescription(Description: String); 
    procedure setPrice1Person(Price1Person: Double); 
    procedure setPrice2Persons(Price2Persons: Double); 
    procedure setPrice3Persons(Price3Persons: Double); 
    procedure setPrice4Persons(Price4Persons: Double); 
    procedure setPrice5Persons(Price5Persons: Double); 
    procedure setPrice6Persons(Price6Persons: Double); 
    procedure setPriceExtraPerson(PriceExtraPerson: Double); 
    procedure setPcCode(pcCode: String); 
    procedure setPcDescription(pcDescription: String); 
    procedure setPcActive(pcActive: Byte); 
    procedure setPcRack(pcRack: Byte); 
    procedure setPcRackCalc(pcRackCalc: Double); 
    procedure setPcShowDiscount(pcShowDiscount: Byte); 
    procedure setPcDiscountText(pcDiscountText: String); 
    procedure setPcAutomatic(pcAutomatic: Byte); 
    procedure setSeStartDate(seStartDate: TTimeStamp); 
    procedure setSeEndDate(seEndDate: TTimeStamp); 
    procedure setSeDescription(seDescription: String); 
    procedure setNumberGuests(NumberGuests: Integer); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property seID : Integer read FseID write FseID;
    property pcID : Integer read FpcID write FpcID;
    property RoomType : String read FRoomType write FRoomType;
    property Currency : String read FCurrency write FCurrency;
    property Description : String read FDescription write FDescription;
    property Price1Person : Double read FPrice1Person write FPrice1Person;
    property Price2Persons : Double read FPrice2Persons write FPrice2Persons;
    property Price3Persons : Double read FPrice3Persons write FPrice3Persons;
    property Price4Persons : Double read FPrice4Persons write FPrice4Persons;
    property Price5Persons : Double read FPrice5Persons write FPrice5Persons;
    property Price6Persons : Double read FPrice6Persons write FPrice6Persons;
    property PriceExtraPerson : Double read FPriceExtraPerson write FPriceExtraPerson;
    property pcCode : String read FpcCode write FpcCode;
    property pcDescription : String read FpcDescription write FpcDescription;
    property pcActive : Byte read FpcActive write FpcActive;
    property pcRack : Byte read FpcRack write FpcRack;
    property pcRackCalc : Double read FpcRackCalc write FpcRackCalc;
    property pcShowDiscount : Byte read FpcShowDiscount write FpcShowDiscount;
    property pcDiscountText : String read FpcDiscountText write FpcDiscountText;
    property pcAutomatic : Byte read FpcAutomatic write FpcAutomatic;
    property seStartDate : TTimeStamp read FseStartDate write FseStartDate;
    property seEndDate : TTimeStamp read FseEndDate write FseEndDate;
    property seDescription : String read FseDescription write FseDescription;
    property NumberGuests : Integer read FNumberGuests write FNumberGuests;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TViewroomprices1Entity = Array Of TViewroomprices1Entity;

  TW_sale_invoice_payments_per_dateEntity = class(TPersistent)
  private
    FReservation: Integer; 
    FRoomReservation: Integer; 
    FInvoiceNumber: Integer; 
    FInvoiceDate: String; 
    FCustomer: String; 
    FName: String; 
    FCreditInvoice: Integer; 
    FPayType: String; 
    FAmount: Double; 
    FpmDescription: String; 
    FCurrency: String; 
    FCurrencyRate: Double; 
    FAyear: Integer; 
    FAmon: Integer; 
    FAday: Integer; 
    FTotal: Double; 
    FTotalWOVAT: Double; 
    FTotalVAT: Double; 
    FSurname: String; 
    FcustName: String; 
    FCustomerType: String; 
    FTravelAgency: Byte; 
    FptDescription: String; 
    FPayGroup: String; 
    FpgDescription: String; 
    FPID: String; 
    Fjson: String; 
  public
    procedure setReservation(Reservation: Integer); 
    procedure setRoomReservation(RoomReservation: Integer); 
    procedure setInvoiceNumber(InvoiceNumber: Integer); 
    procedure setInvoiceDate(InvoiceDate: String); 
    procedure setCustomer(Customer: String); 
    procedure setName(Name: String); 
    procedure setCreditInvoice(CreditInvoice: Integer); 
    procedure setPayType(PayType: String); 
    procedure setAmount(Amount: Double); 
    procedure setPmDescription(pmDescription: String); 
    procedure setCurrency(Currency: String); 
    procedure setCurrencyRate(CurrencyRate: Double); 
    procedure setAyear(Ayear: Integer); 
    procedure setAmon(Amon: Integer); 
    procedure setAday(Aday: Integer); 
    procedure setTotal(Total: Double); 
    procedure setTotalWOVAT(TotalWOVAT: Double); 
    procedure setTotalVAT(TotalVAT: Double); 
    procedure setSurname(Surname: String); 
    procedure setCustName(custName: String); 
    procedure setCustomerType(CustomerType: String); 
    procedure setTravelAgency(TravelAgency: Byte); 
    procedure setPtDescription(ptDescription: String); 
    procedure setPayGroup(PayGroup: String); 
    procedure setPgDescription(pgDescription: String); 
    procedure setPID(PID: String); 
    procedure setJson(json: String); 
  published
    property Reservation : Integer read FReservation write FReservation;
    property RoomReservation : Integer read FRoomReservation write FRoomReservation;
    property InvoiceNumber : Integer read FInvoiceNumber write FInvoiceNumber;
    property InvoiceDate : String read FInvoiceDate write FInvoiceDate;
    property Customer : String read FCustomer write FCustomer;
    property Name : String read FName write FName;
    property CreditInvoice : Integer read FCreditInvoice write FCreditInvoice;
    property PayType : String read FPayType write FPayType;
    property Amount : Double read FAmount write FAmount;
    property pmDescription : String read FpmDescription write FpmDescription;
    property Currency : String read FCurrency write FCurrency;
    property CurrencyRate : Double read FCurrencyRate write FCurrencyRate;
    property Ayear : Integer read FAyear write FAyear;
    property Amon : Integer read FAmon write FAmon;
    property Aday : Integer read FAday write FAday;
    property Total : Double read FTotal write FTotal;
    property TotalWOVAT : Double read FTotalWOVAT write FTotalWOVAT;
    property TotalVAT : Double read FTotalVAT write FTotalVAT;
    property Surname : String read FSurname write FSurname;
    property custName : String read FcustName write FcustName;
    property CustomerType : String read FCustomerType write FCustomerType;
    property TravelAgency : Byte read FTravelAgency write FTravelAgency;
    property ptDescription : String read FptDescription write FptDescription;
    property PayGroup : String read FPayGroup write FPayGroup;
    property pgDescription : String read FpgDescription write FpgDescription;
    property PID : String read FPID write FPID;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TW_sale_invoice_payments_per_dateEntity = Array Of TW_sale_invoice_payments_per_dateEntity;

  TWroominfoEntity = class(TPersistent)
  private
    FRoom: String; 
    FDescription: String; 
    FDetailedDescription: String; 
    FRoomType: String; 
    FBath: Byte; 
    FShower: Byte; 
    FSafe: Byte; 
    FTV: Byte; 
    FVideo: Byte; 
    FRadio: Byte; 
    FCDPlayer: Byte; 
    FTelephone: Byte; 
    FPress: Byte; 
    FCoffee: Byte; 
    FKitchen: Byte; 
    FMinibar: Byte; 
    FFridge: Byte; 
    FHairdryer: Byte; 
    FInternetPlug: Byte; 
    FFax: Byte; 
    FSqrMeters: Double; 
    FBedSize: String; 
    FEquipments: String; 
    FBookable: Byte; 
    FStatistics: Byte; 
    FStatus: String; 
    FOrderIndex: Integer; 
    Fhidden: Byte; 
    FLocation: String; 
    FFloor: Integer; 
    FID: Integer; 
    FDorm: String; 
    FuseInNationalReport: Byte; 
    FActive: Byte; 
    FLocationDescription: String; 
    FRoomTypeDescription: String; 
    FNumberGuests: Integer; 
    FRoomTypeGroup: String; 
    FRoomTypeGroupDescription: String; 
    Fjson: String; 
  public
    procedure setRoom(Room: String); 
    procedure setDescription(Description: String); 
    procedure setDetailedDescription(DetailedDescription: String); 
    procedure setRoomType(RoomType: String); 
    procedure setBath(Bath: Byte); 
    procedure setShower(Shower: Byte); 
    procedure setSafe(Safe: Byte); 
    procedure setTV(TV: Byte); 
    procedure setVideo(Video: Byte); 
    procedure setRadio(Radio: Byte); 
    procedure setCDPlayer(CDPlayer: Byte); 
    procedure setTelephone(Telephone: Byte); 
    procedure setPress(Press: Byte); 
    procedure setCoffee(Coffee: Byte); 
    procedure setKitchen(Kitchen: Byte); 
    procedure setMinibar(Minibar: Byte); 
    procedure setFridge(Fridge: Byte); 
    procedure setHairdryer(Hairdryer: Byte); 
    procedure setInternetPlug(InternetPlug: Byte); 
    procedure setFax(Fax: Byte); 
    procedure setSqrMeters(SqrMeters: Double); 
    procedure setBedSize(BedSize: String); 
    procedure setEquipments(Equipments: String); 
    procedure setBookable(Bookable: Byte); 
    procedure setStatistics(Statistics: Byte); 
    procedure setStatus(Status: String); 
    procedure setOrderIndex(OrderIndex: Integer); 
    procedure setHidden(hidden: Byte); 
    procedure setLocation(Location: String); 
    procedure setFloor(Floor: Integer); 
    procedure setID(ID: Integer); 
    procedure setDorm(Dorm: String); 
    procedure setUseInNationalReport(useInNationalReport: Byte); 
    procedure setActive(Active: Byte); 
    procedure setLocationDescription(LocationDescription: String); 
    procedure setRoomTypeDescription(RoomTypeDescription: String); 
    procedure setNumberGuests(NumberGuests: Integer); 
    procedure setRoomTypeGroup(RoomTypeGroup: String); 
    procedure setRoomTypeGroupDescription(RoomTypeGroupDescription: String); 
    procedure setJson(json: String); 
  published
    property Room : String read FRoom write FRoom;
    property Description : String read FDescription write FDescription;
    property DetailedDescription : String read FDetailedDescription write FDetailedDescription;
    property RoomType : String read FRoomType write FRoomType;
    property Bath : Byte read FBath write FBath;
    property Shower : Byte read FShower write FShower;
    property Safe : Byte read FSafe write FSafe;
    property TV : Byte read FTV write FTV;
    property Video : Byte read FVideo write FVideo;
    property Radio : Byte read FRadio write FRadio;
    property CDPlayer : Byte read FCDPlayer write FCDPlayer;
    property Telephone : Byte read FTelephone write FTelephone;
    property Press : Byte read FPress write FPress;
    property Coffee : Byte read FCoffee write FCoffee;
    property Kitchen : Byte read FKitchen write FKitchen;
    property Minibar : Byte read FMinibar write FMinibar;
    property Fridge : Byte read FFridge write FFridge;
    property Hairdryer : Byte read FHairdryer write FHairdryer;
    property InternetPlug : Byte read FInternetPlug write FInternetPlug;
    property Fax : Byte read FFax write FFax;
    property SqrMeters : Double read FSqrMeters write FSqrMeters;
    property BedSize : String read FBedSize write FBedSize;
    property Equipments : String read FEquipments write FEquipments;
    property Bookable : Byte read FBookable write FBookable;
    property Statistics : Byte read FStatistics write FStatistics;
    property Status : String read FStatus write FStatus;
    property OrderIndex : Integer read FOrderIndex write FOrderIndex;
    property hidden : Byte read Fhidden write Fhidden;
    property Location : String read FLocation write FLocation;
    property Floor : Integer read FFloor write FFloor;
    property ID : Integer read FID write FID;
    property Dorm : String read FDorm write FDorm;
    property useInNationalReport : Byte read FuseInNationalReport write FuseInNationalReport;
    property Active : Byte read FActive write FActive;
    property LocationDescription : String read FLocationDescription write FLocationDescription;
    property RoomTypeDescription : String read FRoomTypeDescription write FRoomTypeDescription;
    property NumberGuests : Integer read FNumberGuests write FNumberGuests;
    property RoomTypeGroup : String read FRoomTypeGroup write FRoomTypeGroup;
    property RoomTypeGroupDescription : String read FRoomTypeGroupDescription write FRoomTypeGroupDescription;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TWroominfoEntity = Array Of TWroominfoEntity;

  TWroomratesEntity = class(TPersistent)
  private
    FID: Integer; 
    FPriceCodeID: Integer; 
    FpcCode: String; 
    FpcRack: Byte; 
    FCurrencyID: Integer; 
    FCurrency: String; 
    FSeasonID: Integer; 
    FseStartDate: TTimeStamp; 
    FseEndDate: TTimeStamp; 
    FseDescription: String; 
    FRoomTypeID: Integer; 
    FRoomType: String; 
    FNumberGuests: Integer; 
    FRateID: Integer; 
    FRateCurrency: String; 
    FRate1Person: Double; 
    FRate2Persons: Double; 
    FRate3Persons: Double; 
    FRate4Persons: Double; 
    FRate5Persons: Double; 
    FRate6Persons: Double; 
    FRateExtraPerson: Double; 
    FRateExtraChildren: Double; 
    FRateExtraInfant: Double; 
    FrateDescription: String; 
    FActive: Byte; 
    FDateFrom: TTimeStamp; 
    FDateTo: TTimeStamp; 
    FDescription: String; 
    FDateCreated: TTimeStamp; 
    FLastModified: TTimeStamp; 
    Fjson: String; 
  public
    procedure setID(ID: Integer); 
    procedure setPriceCodeID(PriceCodeID: Integer); 
    procedure setPcCode(pcCode: String); 
    procedure setPcRack(pcRack: Byte); 
    procedure setCurrencyID(CurrencyID: Integer); 
    procedure setCurrency(Currency: String); 
    procedure setSeasonID(SeasonID: Integer); 
    procedure setSeStartDate(seStartDate: TTimeStamp); 
    procedure setSeEndDate(seEndDate: TTimeStamp); 
    procedure setSeDescription(seDescription: String); 
    procedure setRoomTypeID(RoomTypeID: Integer); 
    procedure setRoomType(RoomType: String); 
    procedure setNumberGuests(NumberGuests: Integer); 
    procedure setRateID(RateID: Integer); 
    procedure setRateCurrency(RateCurrency: String); 
    procedure setRate1Person(Rate1Person: Double); 
    procedure setRate2Persons(Rate2Persons: Double); 
    procedure setRate3Persons(Rate3Persons: Double); 
    procedure setRate4Persons(Rate4Persons: Double); 
    procedure setRate5Persons(Rate5Persons: Double); 
    procedure setRate6Persons(Rate6Persons: Double); 
    procedure setRateExtraPerson(RateExtraPerson: Double); 
    procedure setRateExtraChildren(RateExtraChildren: Double); 
    procedure setRateExtraInfant(RateExtraInfant: Double); 
    procedure setRateDescription(rateDescription: String); 
    procedure setActive(Active: Byte); 
    procedure setDateFrom(DateFrom: TTimeStamp); 
    procedure setDateTo(DateTo: TTimeStamp); 
    procedure setDescription(Description: String); 
    procedure setDateCreated(DateCreated: TTimeStamp); 
    procedure setLastModified(LastModified: TTimeStamp); 
    procedure setJson(json: String); 
  published
    property ID : Integer read FID write FID;
    property PriceCodeID : Integer read FPriceCodeID write FPriceCodeID;
    property pcCode : String read FpcCode write FpcCode;
    property pcRack : Byte read FpcRack write FpcRack;
    property CurrencyID : Integer read FCurrencyID write FCurrencyID;
    property Currency : String read FCurrency write FCurrency;
    property SeasonID : Integer read FSeasonID write FSeasonID;
    property seStartDate : TTimeStamp read FseStartDate write FseStartDate;
    property seEndDate : TTimeStamp read FseEndDate write FseEndDate;
    property seDescription : String read FseDescription write FseDescription;
    property RoomTypeID : Integer read FRoomTypeID write FRoomTypeID;
    property RoomType : String read FRoomType write FRoomType;
    property NumberGuests : Integer read FNumberGuests write FNumberGuests;
    property RateID : Integer read FRateID write FRateID;
    property RateCurrency : String read FRateCurrency write FRateCurrency;
    property Rate1Person : Double read FRate1Person write FRate1Person;
    property Rate2Persons : Double read FRate2Persons write FRate2Persons;
    property Rate3Persons : Double read FRate3Persons write FRate3Persons;
    property Rate4Persons : Double read FRate4Persons write FRate4Persons;
    property Rate5Persons : Double read FRate5Persons write FRate5Persons;
    property Rate6Persons : Double read FRate6Persons write FRate6Persons;
    property RateExtraPerson : Double read FRateExtraPerson write FRateExtraPerson;
    property RateExtraChildren : Double read FRateExtraChildren write FRateExtraChildren;
    property RateExtraInfant : Double read FRateExtraInfant write FRateExtraInfant;
    property rateDescription : String read FrateDescription write FrateDescription;
    property Active : Byte read FActive write FActive;
    property DateFrom : TTimeStamp read FDateFrom write FDateFrom;
    property DateTo : TTimeStamp read FDateTo write FDateTo;
    property Description : String read FDescription write FDescription;
    property DateCreated : TTimeStamp read FDateCreated write FDateCreated;
    property LastModified : TTimeStamp read FLastModified write FLastModified;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TWroomratesEntity = Array Of TWroomratesEntity;

  TWroomsEntity = class(TPersistent)
  private
    FRoom: String; 
    FroDescription: String; 
    FRoomType: String; 
    FrtRoomtypeDescription: String; 
    FNumberGuests: Integer; 
    FFloor: Integer; 
    Frldescription: String; 
    FStatus: String; 
    FBath: Byte; 
    FShower: Byte; 
    FSafe: Byte; 
    FTV: Byte; 
    FVideo: Byte; 
    FRadio: Byte; 
    FCDPlayer: Byte; 
    FTelephone: Byte; 
    FPress: Byte; 
    FCoffee: Byte; 
    FKitchen: Byte; 
    FMinibar: Byte; 
    FFridge: Byte; 
    FHairdryer: Byte; 
    FInternetPlug: Byte; 
    FFax: Byte; 
    FSqrMeters: Double; 
    FBedSize: String; 
    FEquipments: String; 
    Fjson: String; 
  public
    procedure setRoom(Room: String); 
    procedure setRoDescription(roDescription: String); 
    procedure setRoomType(RoomType: String); 
    procedure setRtRoomtypeDescription(rtRoomtypeDescription: String); 
    procedure setNumberGuests(NumberGuests: Integer); 
    procedure setFloor(Floor: Integer); 
    procedure setRldescription(rldescription: String); 
    procedure setStatus(Status: String); 
    procedure setBath(Bath: Byte); 
    procedure setShower(Shower: Byte); 
    procedure setSafe(Safe: Byte); 
    procedure setTV(TV: Byte); 
    procedure setVideo(Video: Byte); 
    procedure setRadio(Radio: Byte); 
    procedure setCDPlayer(CDPlayer: Byte); 
    procedure setTelephone(Telephone: Byte); 
    procedure setPress(Press: Byte); 
    procedure setCoffee(Coffee: Byte); 
    procedure setKitchen(Kitchen: Byte); 
    procedure setMinibar(Minibar: Byte); 
    procedure setFridge(Fridge: Byte); 
    procedure setHairdryer(Hairdryer: Byte); 
    procedure setInternetPlug(InternetPlug: Byte); 
    procedure setFax(Fax: Byte); 
    procedure setSqrMeters(SqrMeters: Double); 
    procedure setBedSize(BedSize: String); 
    procedure setEquipments(Equipments: String); 
    procedure setJson(json: String); 
  published
    property Room : String read FRoom write FRoom;
    property roDescription : String read FroDescription write FroDescription;
    property RoomType : String read FRoomType write FRoomType;
    property rtRoomtypeDescription : String read FrtRoomtypeDescription write FrtRoomtypeDescription;
    property NumberGuests : Integer read FNumberGuests write FNumberGuests;
    property Floor : Integer read FFloor write FFloor;
    property rldescription : String read Frldescription write Frldescription;
    property Status : String read FStatus write FStatus;
    property Bath : Byte read FBath write FBath;
    property Shower : Byte read FShower write FShower;
    property Safe : Byte read FSafe write FSafe;
    property TV : Byte read FTV write FTV;
    property Video : Byte read FVideo write FVideo;
    property Radio : Byte read FRadio write FRadio;
    property CDPlayer : Byte read FCDPlayer write FCDPlayer;
    property Telephone : Byte read FTelephone write FTelephone;
    property Press : Byte read FPress write FPress;
    property Coffee : Byte read FCoffee write FCoffee;
    property Kitchen : Byte read FKitchen write FKitchen;
    property Minibar : Byte read FMinibar write FMinibar;
    property Fridge : Byte read FFridge write FFridge;
    property Hairdryer : Byte read FHairdryer write FHairdryer;
    property InternetPlug : Byte read FInternetPlug write FInternetPlug;
    property Fax : Byte read FFax write FFax;
    property SqrMeters : Double read FSqrMeters write FSqrMeters;
    property BedSize : String read FBedSize write FBedSize;
    property Equipments : String read FEquipments write FEquipments;
    property json : String read Fjson write Fjson;
  end;
  Array_Of_TWroomsEntity = Array Of TWroomsEntity;

implementation

// ****************************************** TCancellationdetailsEntity **************************************************

procedure TCancellationdetailsEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TCancellationdetailsEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TCancellationdetailsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TCancellationdetailsEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TCancellationdetailsEntity.setCancelDate(CancelDate: TTimeStamp);
begin
  self.CancelDate := CancelDate;
end;
procedure TCancellationdetailsEntity.setCancelStaff(CancelStaff: String);
begin
  self.CancelStaff := CancelStaff;
end;
procedure TCancellationdetailsEntity.setCancelReason(CancelReason: String);
begin
  self.CancelReason := CancelReason;
end;
procedure TCancellationdetailsEntity.setCancelRequest(CancelRequest: String);
begin
  self.CancelRequest := CancelRequest;
end;
procedure TCancellationdetailsEntity.setCancelInformation(CancelInformation: String);
begin
  self.CancelInformation := CancelInformation;
end;
procedure TCancellationdetailsEntity.setCancelType(CancelType: Integer);
begin
  self.CancelType := CancelType;
end;
procedure TCancellationdetailsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TChannelclassrelationsEntity **************************************************

procedure TChannelclassrelationsEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TChannelclassrelationsEntity.setChannelId(channelId: Integer);
begin
  self.channelId := channelId;
end;
procedure TChannelclassrelationsEntity.setRoomclassId(roomclassId: Integer);
begin
  self.roomclassId := roomclassId;
end;
procedure TChannelclassrelationsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TChannelmanagersEntity **************************************************

procedure TChannelmanagersEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TChannelmanagersEntity.setActive(active: Byte);
begin
  self.active := active;
end;
procedure TChannelmanagersEntity.setCode(code: String);
begin
  self.code := code;
end;
procedure TChannelmanagersEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TChannelmanagersEntity.setAdminUsername(adminUsername: String);
begin
  self.adminUsername := adminUsername;
end;
procedure TChannelmanagersEntity.setAdminPassword(adminPassword: String);
begin
  self.adminPassword := adminPassword;
end;
procedure TChannelmanagersEntity.setWebserviceURI(webserviceURI: String);
begin
  self.webserviceURI := webserviceURI;
end;
procedure TChannelmanagersEntity.setWebserviceUsername(webserviceUsername: String);
begin
  self.webserviceUsername := webserviceUsername;
end;
procedure TChannelmanagersEntity.setWebservicePassword(webservicePassword: String);
begin
  self.webservicePassword := webservicePassword;
end;
procedure TChannelmanagersEntity.setWebserviceHotelCode(webserviceHotelCode: String);
begin
  self.webserviceHotelCode := webserviceHotelCode;
end;
procedure TChannelmanagersEntity.setWeserviceRequestor(weserviceRequestor: String);
begin
  self.weserviceRequestor := weserviceRequestor;
end;
procedure TChannelmanagersEntity.setChannels(channels: String);
begin
  self.channels := channels;
end;
procedure TChannelmanagersEntity.setSendRate(sendRate: Byte);
begin
  self.sendRate := sendRate;
end;
procedure TChannelmanagersEntity.setSendAvailability(sendAvailability: Byte);
begin
  self.sendAvailability := sendAvailability;
end;
procedure TChannelmanagersEntity.setSendStopSell(sendStopSell: Byte);
begin
  self.sendStopSell := sendStopSell;
end;
procedure TChannelmanagersEntity.setSendMinStay(sendMinStay: Byte);
begin
  self.sendMinStay := sendMinStay;
end;
procedure TChannelmanagersEntity.setMaintenanceDays(maintenanceDays: Integer);
begin
  self.maintenanceDays := maintenanceDays;
end;
procedure TChannelmanagersEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TChannelplancodesEntity **************************************************

procedure TChannelplancodesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TChannelplancodesEntity.setCode(code: String);
begin
  self.code := code;
end;
procedure TChannelplancodesEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TChannelplancodesEntity.setActive(active: Byte);
begin
  self.active := active;
end;
procedure TChannelplancodesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TChannelratesEntity **************************************************

procedure TChannelratesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TChannelratesEntity.setDate(date: TTimeStamp);
begin
  self.date := date;
end;
procedure TChannelratesEntity.setPrice(price: Double);
begin
  self.price := price;
end;
procedure TChannelratesEntity.setDirty(dirty: Byte);
begin
  self.dirty := dirty;
end;
procedure TChannelratesEntity.setMinstay(minstay: Integer);
begin
  self.minstay := minstay;
end;
procedure TChannelratesEntity.setStop(stop: Byte);
begin
  self.stop := stop;
end;
procedure TChannelratesEntity.setChannelManager(channelManager: Integer);
begin
  self.channelManager := channelManager;
end;
procedure TChannelratesEntity.setChannelId(channelId: Integer);
begin
  self.channelId := channelId;
end;
procedure TChannelratesEntity.setRoomClassId(roomClassId: Integer);
begin
  self.roomClassId := roomClassId;
end;
procedure TChannelratesEntity.setPlanCodeId(planCodeId: Integer);
begin
  self.planCodeId := planCodeId;
end;
procedure TChannelratesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TChannelratesavailabilitiesEntity **************************************************

procedure TChannelratesavailabilitiesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TChannelratesavailabilitiesEntity.setDate(date: TTimeStamp);
begin
  self.date := date;
end;
procedure TChannelratesavailabilitiesEntity.setAvailability(availability: Integer);
begin
  self.availability := availability;
end;
procedure TChannelratesavailabilitiesEntity.setDirty(dirty: Byte);
begin
  self.dirty := dirty;
end;
procedure TChannelratesavailabilitiesEntity.setRoomClassId(roomClassId: Integer);
begin
  self.roomClassId := roomClassId;
end;
procedure TChannelratesavailabilitiesEntity.setPlanCodeID(planCodeID: Integer);
begin
  self.planCodeID := planCodeID;
end;
procedure TChannelratesavailabilitiesEntity.setChannelManagerId(channelManagerId: Integer);
begin
  self.channelManagerId := channelManagerId;
end;
procedure TChannelratesavailabilitiesEntity.set_SetAvailability(setAvailability: Integer);
begin
  self.FsetAvailability := setAvailability;
end;
procedure TChannelratesavailabilitiesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TChannelratesavailabilitiesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TChannelsEntity **************************************************

procedure TChannelsEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TChannelsEntity.setName(name: String);
begin
  self.name := name;
end;
procedure TChannelsEntity.setActive(active: Byte);
begin
  self.active := active;
end;
procedure TChannelsEntity.setChannelManagerId(channelManagerId: String);
begin
  self.channelManagerId := channelManagerId;
end;
procedure TChannelsEntity.setMinAlotment(minAlotment: Integer);
begin
  self.minAlotment := minAlotment;
end;
procedure TChannelsEntity.setDefaultAvailability(defaultAvailability: Integer);
begin
  self.defaultAvailability := defaultAvailability;
end;
procedure TChannelsEntity.setDefaultPricePp(defaultPricePp: Double);
begin
  self.defaultPricePp := defaultPricePp;
end;
procedure TChannelsEntity.setMarketSegment(marketSegment: String);
begin
  self.marketSegment := marketSegment;
end;
procedure TChannelsEntity.setCurrencyId(currencyId: Integer);
begin
  self.currencyId := currencyId;
end;
procedure TChannelsEntity.setManagedByChannelManager(managedByChannelManager: Byte);
begin
  self.managedByChannelManager := managedByChannelManager;
end;
procedure TChannelsEntity.setDefaultChannel(defaultChannel: Byte);
begin
  self.defaultChannel := defaultChannel;
end;
procedure TChannelsEntity.setPush(push: Byte);
begin
  self.push := push;
end;
procedure TChannelsEntity.setCustomerId(customerId: Integer);
begin
  self.customerId := customerId;
end;
procedure TChannelsEntity.setColor(color: String);
begin
  self.color := color;
end;
procedure TChannelsEntity.setRateRoundingType(rateRoundingType: Integer);
begin
  self.rateRoundingType := rateRoundingType;
end;
procedure TChannelsEntity.setCompensationPercentage(compensationPercentage: Double);
begin
  self.compensationPercentage := compensationPercentage;
end;
procedure TChannelsEntity.setHotelsBookingEngine(hotelsBookingEngine: Byte);
begin
  self.hotelsBookingEngine := hotelsBookingEngine;
end;
procedure TChannelsEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TChannelsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TChanneltogglingrulesEntity **************************************************

procedure TChanneltogglingrulesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TChanneltogglingrulesEntity.setActive(active: Byte);
begin
  self.active := active;
end;
procedure TChanneltogglingrulesEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TChanneltogglingrulesEntity.setSelectedRoomTypeIds(selectedRoomTypeIds: String);
begin
  self.selectedRoomTypeIds := selectedRoomTypeIds;
end;
procedure TChanneltogglingrulesEntity.setOccupancyLimit(occupancyLimit: Double);
begin
  self.occupancyLimit := occupancyLimit;
end;
procedure TChanneltogglingrulesEntity.setWhichDaysIndex(whichDaysIndex: Integer);
begin
  self.whichDaysIndex := whichDaysIndex;
end;
procedure TChanneltogglingrulesEntity.setSelectedDays(selectedDays: String);
begin
  self.selectedDays := selectedDays;
end;
procedure TChanneltogglingrulesEntity.setSelectedMonths(selectedMonths: String);
begin
  self.selectedMonths := selectedMonths;
end;
procedure TChanneltogglingrulesEntity.setSelectedYears(selectedYears: String);
begin
  self.selectedYears := selectedYears;
end;
procedure TChanneltogglingrulesEntity.setSelectedChannelsIds(selectedChannelsIds: String);
begin
  self.selectedChannelsIds := selectedChannelsIds;
end;
procedure TChanneltogglingrulesEntity.setPriority(priority: Integer);
begin
  self.priority := priority;
end;
procedure TChanneltogglingrulesEntity.setWindow(window: Integer);
begin
  self.window := window;
end;
procedure TChanneltogglingrulesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TChanneltogglingrulessplitEntity **************************************************

procedure TChanneltogglingrulessplitEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TChanneltogglingrulessplitEntity.setRuleId(ruleId: Integer);
begin
  self.ruleId := ruleId;
end;
procedure TChanneltogglingrulessplitEntity.setStayDate(stayDate: TDateTime);
begin
  self.stayDate := stayDate;
end;
procedure TChanneltogglingrulessplitEntity.setRoomClassId(roomClassId: Integer);
begin
  self.roomClassId := roomClassId;
end;
procedure TChanneltogglingrulessplitEntity.setOccupancyLevel(occupancyLevel: Double);
begin
  self.occupancyLevel := occupancyLevel;
end;
procedure TChanneltogglingrulessplitEntity.setChannelId(channelId: Integer);
begin
  self.channelId := channelId;
end;
procedure TChanneltogglingrulessplitEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TColorsEntity **************************************************

procedure TColorsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TColorsEntity.setColorHex(ColorHex: String);
begin
  self.ColorHex := ColorHex;
end;
procedure TColorsEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TColorsEntity.setDisplayOrder(DisplayOrder: Integer);
begin
  self.DisplayOrder := DisplayOrder;
end;
procedure TColorsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TColorsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TControlEntity **************************************************

procedure TControlEntity.setCompanyID(CompanyID: String);
begin
  self.CompanyID := CompanyID;
end;
procedure TControlEntity.setCompanyName(CompanyName: String);
begin
  self.CompanyName := CompanyName;
end;
procedure TControlEntity.setAddress1(Address1: String);
begin
  self.Address1 := Address1;
end;
procedure TControlEntity.setAddress2(Address2: String);
begin
  self.Address2 := Address2;
end;
procedure TControlEntity.setAddress3(Address3: String);
begin
  self.Address3 := Address3;
end;
procedure TControlEntity.setAddress4(Address4: String);
begin
  self.Address4 := Address4;
end;
procedure TControlEntity.setCountry(Country: String);
begin
  self.Country := Country;
end;
procedure TControlEntity.setFax(Fax: String);
begin
  self.Fax := Fax;
end;
procedure TControlEntity.setTelephone1(Telephone1: String);
begin
  self.Telephone1 := Telephone1;
end;
procedure TControlEntity.setTelephone2(Telephone2: String);
begin
  self.Telephone2 := Telephone2;
end;
procedure TControlEntity.setLastInvoice(LastInvoice: Integer);
begin
  self.LastInvoice := LastInvoice;
end;
procedure TControlEntity.setLastReservation(LastReservation: Integer);
begin
  self.LastReservation := LastReservation;
end;
procedure TControlEntity.setLastPerson(LastPerson: Integer);
begin
  self.LastPerson := LastPerson;
end;
procedure TControlEntity.setLastRoomRes(LastRoomRes: Integer);
begin
  self.LastRoomRes := LastRoomRes;
end;
procedure TControlEntity.setMailHost(MailHost: String);
begin
  self.MailHost := MailHost;
end;
procedure TControlEntity.setSmtpHost(SmtpHost: String);
begin
  self.SmtpHost := SmtpHost;
end;
procedure TControlEntity.setEmailAddress(EmailAddress: String);
begin
  self.EmailAddress := EmailAddress;
end;
procedure TControlEntity.setMailUser(MailUser: String);
begin
  self.MailUser := MailUser;
end;
procedure TControlEntity.setMailPassword(MailPassword: String);
begin
  self.MailPassword := MailPassword;
end;
procedure TControlEntity.setMailMachineName(MailMachineName: String);
begin
  self.MailMachineName := MailMachineName;
end;
procedure TControlEntity.setMailActive(MailActive: Byte);
begin
  self.MailActive := MailActive;
end;
procedure TControlEntity.setWakeupMachineName(WakeupMachineName: String);
begin
  self.WakeupMachineName := WakeupMachineName;
end;
procedure TControlEntity.setBreakFastItem(BreakFastItem: String);
begin
  self.BreakFastItem := BreakFastItem;
end;
procedure TControlEntity.setRoomRentItem(RoomRentItem: String);
begin
  self.RoomRentItem := RoomRentItem;
end;
procedure TControlEntity.setPaymentItem(PaymentItem: String);
begin
  self.PaymentItem := PaymentItem;
end;
procedure TControlEntity.setPhoneUseItem(PhoneUseItem: String);
begin
  self.PhoneUseItem := PhoneUseItem;
end;
procedure TControlEntity.setNativeCurrency(NativeCurrency: String);
begin
  self.NativeCurrency := NativeCurrency;
end;
procedure TControlEntity.setDiscountItem(DiscountItem: String);
begin
  self.DiscountItem := DiscountItem;
end;
procedure TControlEntity.setBreakfastInclDefault(BreakfastInclDefault: Byte);
begin
  self.BreakfastInclDefault := BreakfastInclDefault;
end;
procedure TControlEntity.setArrivalDateRulesPrice(ArrivalDateRulesPrice: Byte);
begin
  self.ArrivalDateRulesPrice := ArrivalDateRulesPrice;
end;
procedure TControlEntity.setLocalBreakfast(LocalBreakfast: String);
begin
  self.LocalBreakfast := LocalBreakfast;
end;
procedure TControlEntity.setLocalTotal(LocalTotal: String);
begin
  self.LocalTotal := LocalTotal;
end;
procedure TControlEntity.setLocalTotalPrice(LocalTotalPrice: String);
begin
  self.LocalTotalPrice := LocalTotalPrice;
end;
procedure TControlEntity.setLocalCurrencyRate(LocalCurrencyRate: String);
begin
  self.LocalCurrencyRate := LocalCurrencyRate;
end;
procedure TControlEntity.setLocalRoomRent(LocalRoomRent: String);
begin
  self.LocalRoomRent := LocalRoomRent;
end;
procedure TControlEntity.setLocalInvoice(LocalInvoice: String);
begin
  self.LocalInvoice := LocalInvoice;
end;
procedure TControlEntity.setLocalVAT(LocalVAT: String);
begin
  self.LocalVAT := LocalVAT;
end;
procedure TControlEntity.setLocalCreditInvoice(LocalCreditInvoice: String);
begin
  self.LocalCreditInvoice := LocalCreditInvoice;
end;
procedure TControlEntity.setGreenColor(GreenColor: String);
begin
  self.GreenColor := GreenColor;
end;
procedure TControlEntity.setPurpleColor(PurpleColor: String);
begin
  self.PurpleColor := PurpleColor;
end;
procedure TControlEntity.setFuchsiaColor(FuchsiaColor: String);
begin
  self.FuchsiaColor := FuchsiaColor;
end;
procedure TControlEntity.setReportDir(ReportDir: String);
begin
  self.ReportDir := ReportDir;
end;
procedure TControlEntity.setGrandRowheight(grandRowheight: Integer);
begin
  self.grandRowheight := grandRowheight;
end;
procedure TControlEntity.setFiveDayDateformat2(FiveDayDateformat2: String);
begin
  self.FiveDayDateformat2 := FiveDayDateformat2;
end;
procedure TControlEntity.setFiveDayDateformat1(FiveDayDateformat1: String);
begin
  self.FiveDayDateformat1 := FiveDayDateformat1;
end;
procedure TControlEntity.setFiveDayPrompt(FiveDayPrompt: Integer);
begin
  self.FiveDayPrompt := FiveDayPrompt;
end;
procedure TControlEntity.setFiveDayRowHeight(FiveDayRowHeight: Integer);
begin
  self.FiveDayRowHeight := FiveDayRowHeight;
end;
procedure TControlEntity.setFiveDayColWidth(FiveDayColWidth: Integer);
begin
  self.FiveDayColWidth := FiveDayColWidth;
end;
procedure TControlEntity.setFiveDayColCount(FiveDayColCount: Integer);
begin
  self.FiveDayColCount := FiveDayColCount;
end;
procedure TControlEntity.setFiveDayFontSize(FiveDayFontSize: Integer);
begin
  self.FiveDayFontSize := FiveDayFontSize;
end;
procedure TControlEntity.setFiveDayFontName(FiveDayFontName: String);
begin
  self.FiveDayFontName := FiveDayFontName;
end;
procedure TControlEntity.setInvoicePrinterMethod(InvoicePrinterMethod: Byte);
begin
  self.InvoicePrinterMethod := InvoicePrinterMethod;
end;
procedure TControlEntity.setCompanyBankInfo(CompanyBankInfo: String);
begin
  self.CompanyBankInfo := CompanyBankInfo;
end;
procedure TControlEntity.setCompanyVATNo(CompanyVATNo: String);
begin
  self.CompanyVATNo := CompanyVATNo;
end;
procedure TControlEntity.setCompanyPID(CompanyPID: String);
begin
  self.CompanyPID := CompanyPID;
end;
procedure TControlEntity.setCompanyHomePage(CompanyHomePage: String);
begin
  self.CompanyHomePage := CompanyHomePage;
end;
procedure TControlEntity.setCompanyEmail(CompanyEmail: String);
begin
  self.CompanyEmail := CompanyEmail;
end;
procedure TControlEntity.setInvTxtCompanyVATId(invTxtCompanyVATId: String);
begin
  self.invTxtCompanyVATId := invTxtCompanyVATId;
end;
procedure TControlEntity.setInvTxtCompanyBankInfo(invTxtCompanyBankInfo: String);
begin
  self.invTxtCompanyBankInfo := invTxtCompanyBankInfo;
end;
procedure TControlEntity.setInvTxtCompanyPID(invTxtCompanyPID: String);
begin
  self.invTxtCompanyPID := invTxtCompanyPID;
end;
procedure TControlEntity.setInvTxtCompanyHomePage(invTxtCompanyHomePage: String);
begin
  self.invTxtCompanyHomePage := invTxtCompanyHomePage;
end;
procedure TControlEntity.setInvTxtCompanyEmail(invTxtCompanyEmail: String);
begin
  self.invTxtCompanyEmail := invTxtCompanyEmail;
end;
procedure TControlEntity.setInvTxtCompanyFax(invTxtCompanyFax: String);
begin
  self.invTxtCompanyFax := invTxtCompanyFax;
end;
procedure TControlEntity.setInvTxtCompanyTel2(invTxtCompanyTel2: String);
begin
  self.invTxtCompanyTel2 := invTxtCompanyTel2;
end;
procedure TControlEntity.setInvTxtCompanyTel1(invTxtCompanyTel1: String);
begin
  self.invTxtCompanyTel1 := invTxtCompanyTel1;
end;
procedure TControlEntity.setInvTxtCompanyAddress(invTxtCompanyAddress: String);
begin
  self.invTxtCompanyAddress := invTxtCompanyAddress;
end;
procedure TControlEntity.setInvTxtCompanyName(invTxtCompanyName: String);
begin
  self.invTxtCompanyName := invTxtCompanyName;
end;
procedure TControlEntity.setInvTxtTotalTotal(invTxtTotalTotal: String);
begin
  self.invTxtTotalTotal := invTxtTotalTotal;
end;
procedure TControlEntity.setInvTxtTotalVATAmount(invTxtTotalVATAmount: String);
begin
  self.invTxtTotalVATAmount := invTxtTotalVATAmount;
end;
procedure TControlEntity.setInvTxtTotalwoVAT(invTxtTotalwoVAT: String);
begin
  self.invTxtTotalwoVAT := invTxtTotalwoVAT;
end;
procedure TControlEntity.setInvTxtVATLineSeperator(invTxtVATLineSeperator: String);
begin
  self.invTxtVATLineSeperator := invTxtVATLineSeperator;
end;
procedure TControlEntity.setInvTxtVATLineHead(invTxtVATLineHead: String);
begin
  self.invTxtVATLineHead := invTxtVATLineHead;
end;
procedure TControlEntity.setInvTxtVATListTotal(invTxtVATListTotal: String);
begin
  self.invTxtVATListTotal := invTxtVATListTotal;
end;
procedure TControlEntity.setInvTxtVATListVATAmount(invTxtVATListVATAmount: String);
begin
  self.invTxtVATListVATAmount := invTxtVATListVATAmount;
end;
procedure TControlEntity.setInvTxtVATListVATpr(invTxtVATListVATpr: String);
begin
  self.invTxtVATListVATpr := invTxtVATListVATpr;
end;
procedure TControlEntity.setInvTxtVATListwVAT(invTxtVATListwVAT: String);
begin
  self.invTxtVATListwVAT := invTxtVATListwVAT;
end;
procedure TControlEntity.setInvTxtVATListwoVAT(invTxtVATListwoVAT: String);
begin
  self.invTxtVATListwoVAT := invTxtVATListwoVAT;
end;
procedure TControlEntity.setInvTxtVATListDescription(invTxtVATListDescription: String);
begin
  self.invTxtVATListDescription := invTxtVATListDescription;
end;
procedure TControlEntity.setInvTxtVATListHead(invTxtVATListHead: String);
begin
  self.invTxtVATListHead := invTxtVATListHead;
end;
procedure TControlEntity.setInvTxtPaymentLineSeperator(invTxtPaymentLineSeperator: String);
begin
  self.invTxtPaymentLineSeperator := invTxtPaymentLineSeperator;
end;
procedure TControlEntity.setInvTxtPaymentLineHead(invTxtPaymentLineHead: String);
begin
  self.invTxtPaymentLineHead := invTxtPaymentLineHead;
end;
procedure TControlEntity.setInvTxtPaymentListTotal(invTxtPaymentListTotal: String);
begin
  self.invTxtPaymentListTotal := invTxtPaymentListTotal;
end;
procedure TControlEntity.setInvTxtPaymentListDate(invTxtPaymentListDate: String);
begin
  self.invTxtPaymentListDate := invTxtPaymentListDate;
end;
procedure TControlEntity.setInvTxtPaymentListAmount(invTxtPaymentListAmount: String);
begin
  self.invTxtPaymentListAmount := invTxtPaymentListAmount;
end;
procedure TControlEntity.setInvTxtPaymentListCode(invTxtPaymentListCode: String);
begin
  self.invTxtPaymentListCode := invTxtPaymentListCode;
end;
procedure TControlEntity.setInvTxtPaymentListHead(invTxtPaymentListHead: String);
begin
  self.invTxtPaymentListHead := invTxtPaymentListHead;
end;
procedure TControlEntity.setInvTxtFooterLine4(invTxtFooterLine4: String);
begin
  self.invTxtFooterLine4 := invTxtFooterLine4;
end;
procedure TControlEntity.setInvTxtFooterLine3(invTxtFooterLine3: String);
begin
  self.invTxtFooterLine3 := invTxtFooterLine3;
end;
procedure TControlEntity.setInvTxtFooterLine2(invTxtFooterLine2: String);
begin
  self.invTxtFooterLine2 := invTxtFooterLine2;
end;
procedure TControlEntity.setInvTxtFooterLine1(invTxtFooterLine1: String);
begin
  self.invTxtFooterLine1 := invTxtFooterLine1;
end;
procedure TControlEntity.setInvTxtExtra2(invTxtExtra2: String);
begin
  self.invTxtExtra2 := invTxtExtra2;
end;
procedure TControlEntity.setInvTxtExtra1(invTxtExtra1: String);
begin
  self.invTxtExtra1 := invTxtExtra1;
end;
procedure TControlEntity.setInvTxtLinesItemTotal(invTxtLinesItemTotal: String);
begin
  self.invTxtLinesItemTotal := invTxtLinesItemTotal;
end;
procedure TControlEntity.setInvTxtLinesItemAmount(invTxtLinesItemAmount: String);
begin
  self.invTxtLinesItemAmount := invTxtLinesItemAmount;
end;
procedure TControlEntity.setInvTxtLinesItemPrice(invTxtLinesItemPrice: String);
begin
  self.invTxtLinesItemPrice := invTxtLinesItemPrice;
end;
procedure TControlEntity.setInvTxtLinesItemCount(invTxtLinesItemCount: String);
begin
  self.invTxtLinesItemCount := invTxtLinesItemCount;
end;
procedure TControlEntity.setInvTxtLinesItemText(invTxtLinesItemText: String);
begin
  self.invTxtLinesItemText := invTxtLinesItemText;
end;
procedure TControlEntity.setInvTxtLinesItemNo(invTxtLinesItemNo: String);
begin
  self.invTxtLinesItemNo := invTxtLinesItemNo;
end;
procedure TControlEntity.setInvTxtHeadInfoRoom(invTxtHeadInfoRoom: String);
begin
  self.invTxtHeadInfoRoom := invTxtHeadInfoRoom;
end;
procedure TControlEntity.setInvTxtHeadInfoGuest(invTxtHeadInfoGuest: String);
begin
  self.invTxtHeadInfoGuest := invTxtHeadInfoGuest;
end;
procedure TControlEntity.setInvTxtHeadInfoOrginalInfo(invTxtHeadInfoOrginalInfo: String);
begin
  self.invTxtHeadInfoOrginalInfo := invTxtHeadInfoOrginalInfo;
end;
procedure TControlEntity.setInvTxtHeadInfoCreditInvoice(invTxtHeadInfoCreditInvoice: String);
begin
  self.invTxtHeadInfoCreditInvoice := invTxtHeadInfoCreditInvoice;
end;
procedure TControlEntity.setInvTxtHeadInfoReservation(invTxtHeadInfoReservation: String);
begin
  self.invTxtHeadInfoReservation := invTxtHeadInfoReservation;
end;
procedure TControlEntity.setInvTxtHeadInfoCurrencyRate(invTxtHeadInfoCurrencyRate: String);
begin
  self.invTxtHeadInfoCurrencyRate := invTxtHeadInfoCurrencyRate;
end;
procedure TControlEntity.setInvTxtHeadInfoCurrency(invTxtHeadInfoCurrency: String);
begin
  self.invTxtHeadInfoCurrency := invTxtHeadInfoCurrency;
end;
procedure TControlEntity.setInvTxtHeadInfoLocalCurrency(invTxtHeadInfoLocalCurrency: String);
begin
  self.invTxtHeadInfoLocalCurrency := invTxtHeadInfoLocalCurrency;
end;
procedure TControlEntity.setInvTxtHeadInfoEindagi(invTxtHeadInfoEindagi: String);
begin
  self.invTxtHeadInfoEindagi := invTxtHeadInfoEindagi;
end;
procedure TControlEntity.setInvTxtHeadInfoGjalddagi(invTxtHeadInfoGjalddagi: String);
begin
  self.invTxtHeadInfoGjalddagi := invTxtHeadInfoGjalddagi;
end;
procedure TControlEntity.setInvTxtHeadInfoCustomerNo(invTxtHeadInfoCustomerNo: String);
begin
  self.invTxtHeadInfoCustomerNo := invTxtHeadInfoCustomerNo;
end;
procedure TControlEntity.setInvTxtHeadInfoDate(invTxtHeadInfoDate: String);
begin
  self.invTxtHeadInfoDate := invTxtHeadInfoDate;
end;
procedure TControlEntity.setInvTxtHeadInfoNumber(invTxtHeadInfoNumber: String);
begin
  self.invTxtHeadInfoNumber := invTxtHeadInfoNumber;
end;
procedure TControlEntity.setInvTxtHeadKredit(invTxtHeadKredit: String);
begin
  self.invTxtHeadKredit := invTxtHeadKredit;
end;
procedure TControlEntity.setInvTxtHeadDebit(invTxtHeadDebit: String);
begin
  self.invTxtHeadDebit := invTxtHeadDebit;
end;
procedure TControlEntity.setNameOrder(NameOrder: Integer);
begin
  self.NameOrder := NameOrder;
end;
procedure TControlEntity.setInvEmailAddress(invEmailAddress: String);
begin
  self.invEmailAddress := invEmailAddress;
end;
procedure TControlEntity.setInvEmailDefaultPath(invEmailDefaultPath: String);
begin
  self.invEmailDefaultPath := invEmailDefaultPath;
end;
procedure TControlEntity.setInvEmailExportNotPrintable(invEmailExportNotPrintable: Byte);
begin
  self.invEmailExportNotPrintable := invEmailExportNotPrintable;
end;
procedure TControlEntity.setInvEmailFilename(invEmailFilename: String);
begin
  self.invEmailFilename := invEmailFilename;
end;
procedure TControlEntity.setInvEmailFromCompany(invEmailFromCompany: String);
begin
  self.invEmailFromCompany := invEmailFromCompany;
end;
procedure TControlEntity.setInvEmailFromMail(invEmailFromMail: String);
begin
  self.invEmailFromMail := invEmailFromMail;
end;
procedure TControlEntity.setInvEmailFromName(invEmailFromName: String);
begin
  self.invEmailFromName := invEmailFromName;
end;
procedure TControlEntity.setInvEmailILines(invEmailILines: String);
begin
  self.invEmailILines := invEmailILines;
end;
procedure TControlEntity.setInvEmailLogin(invEmailLogin: String);
begin
  self.invEmailLogin := invEmailLogin;
end;
procedure TControlEntity.setInvEmailPassword(invEmailPassword: String);
begin
  self.invEmailPassword := invEmailPassword;
end;
procedure TControlEntity.setInvEmailSignature(invEmailSignature: String);
begin
  self.invEmailSignature := invEmailSignature;
end;
procedure TControlEntity.setInvEmailSMTPhost(invEmailSMTPhost: String);
begin
  self.invEmailSMTPhost := invEmailSMTPhost;
end;
procedure TControlEntity.setInvEmailSmtpPort(invEmailSmtpPort: String);
begin
  self.invEmailSmtpPort := invEmailSmtpPort;
end;
procedure TControlEntity.setInvEmaiSubject(invEmaiSubject: String);
begin
  self.invEmaiSubject := invEmaiSubject;
end;
procedure TControlEntity.setEmailSMPTMailServer(emailSMPTMailServer: String);
begin
  self.emailSMPTMailServer := emailSMPTMailServer;
end;
procedure TControlEntity.setEmailSMPTport(emailSMPTport: Integer);
begin
  self.emailSMPTport := emailSMPTport;
end;
procedure TControlEntity.setEmailSMPTuseLogin(emailSMPTuseLogin: Byte);
begin
  self.emailSMPTuseLogin := emailSMPTuseLogin;
end;
procedure TControlEntity.setEmailSMPTUserName(emailSMPTUserName: String);
begin
  self.emailSMPTUserName := emailSMPTUserName;
end;
procedure TControlEntity.setEmailSMPTPassword(emailSMPTPassword: String);
begin
  self.emailSMPTPassword := emailSMPTPassword;
end;
procedure TControlEntity.setEmailSMPTThreaded(emailSMPTThreaded: Byte);
begin
  self.emailSMPTThreaded := emailSMPTThreaded;
end;
procedure TControlEntity.setEmailSMPTThreadPriority(emailSMPTThreadPriority: Integer);
begin
  self.emailSMPTThreadPriority := emailSMPTThreadPriority;
end;
procedure TControlEntity.setEmailSMPTWaitThread(emailSMPTWaitThread: Byte);
begin
  self.emailSMPTWaitThread := emailSMPTWaitThread;
end;
procedure TControlEntity.setEmailSMPTTimeOut(emailSMPTTimeOut: Integer);
begin
  self.emailSMPTTimeOut := emailSMPTTimeOut;
end;
procedure TControlEntity.setEmailContentcharset(emailContentcharset: String);
begin
  self.emailContentcharset := emailContentcharset;
end;
procedure TControlEntity.setEmailContentType(emailContentType: Integer);
begin
  self.emailContentType := emailContentType;
end;
procedure TControlEntity.setEmailSaveToFile(emailSaveToFile: Byte);
begin
  self.emailSaveToFile := emailSaveToFile;
end;
procedure TControlEntity.setEmailAgent(emailAgent: String);
begin
  self.emailAgent := emailAgent;
end;
procedure TControlEntity.setEmailFromaddress(emailFromaddress: String);
begin
  self.emailFromaddress := emailFromaddress;
end;
procedure TControlEntity.setEmailFromName(emailFromName: String);
begin
  self.emailFromName := emailFromName;
end;
procedure TControlEntity.setEmailFromOrganization(emailFromOrganization: String);
begin
  self.emailFromOrganization := emailFromOrganization;
end;
procedure TControlEntity.setEmailFromReplayAddress(emailFromReplayAddress: String);
begin
  self.emailFromReplayAddress := emailFromReplayAddress;
end;
procedure TControlEntity.setEmailLogPath(emailLogPath: String);
begin
  self.emailLogPath := emailLogPath;
end;
procedure TControlEntity.setSysDBbuild(sysDBbuild: Integer);
begin
  self.sysDBbuild := sysDBbuild;
end;
procedure TControlEntity.setSysDBSubVersion(SysDBSubVersion: Integer);
begin
  self.SysDBSubVersion := SysDBSubVersion;
end;
procedure TControlEntity.setSysDBversion(sysDBversion: Integer);
begin
  self.sysDBversion := sysDBversion;
end;
procedure TControlEntity.setSwINVhBatchNumber(swINVhBatchNumber: Integer);
begin
  self.swINVhBatchNumber := swINVhBatchNumber;
end;
procedure TControlEntity.setSwINVhINvoiceOrgin(swINVhINvoiceOrgin: Integer);
begin
  self.swINVhINvoiceOrgin := swINVhINvoiceOrgin;
end;
procedure TControlEntity.setSwINVhInvoiceType(swINVhInvoiceType: Integer);
begin
  self.swINVhInvoiceType := swINVhInvoiceType;
end;
procedure TControlEntity.setSwCustsCurrCode(swCustsCurrCode: String);
begin
  self.swCustsCurrCode := swCustsCurrCode;
end;
procedure TControlEntity.setSwCustiPriceType(swCustiPriceType: Integer);
begin
  self.swCustiPriceType := swCustiPriceType;
end;
procedure TControlEntity.setSwCustlDeliveryTermsFK(swCustlDeliveryTermsFK: Integer);
begin
  self.swCustlDeliveryTermsFK := swCustlDeliveryTermsFK;
end;
procedure TControlEntity.setSwCustCreditTerms(swCustCreditTerms: Integer);
begin
  self.swCustCreditTerms := swCustCreditTerms;
end;
procedure TControlEntity.setSwCustiLanguage(swCustiLanguage: Integer);
begin
  self.swCustiLanguage := swCustiLanguage;
end;
procedure TControlEntity.setSwCustSalesPersonID(swCustSalesPersonID: Integer);
begin
  self.swCustSalesPersonID := swCustSalesPersonID;
end;
procedure TControlEntity.setSwCustiAccountFK(swCustiAccountFK: Integer);
begin
  self.swCustiAccountFK := swCustiAccountFK;
end;
procedure TControlEntity.setSwCustGLnumberID(swCustGLnumberID: Integer);
begin
  self.swCustGLnumberID := swCustGLnumberID;
end;
procedure TControlEntity.setSwCustCompanyID(swCustCompanyID: Integer);
begin
  self.swCustCompanyID := swCustCompanyID;
end;
procedure TControlEntity.setAccountType(AccountType: Integer);
begin
  self.AccountType := AccountType;
end;
procedure TControlEntity.setXmlDoExport(xmlDoExport: Byte);
begin
  self.xmlDoExport := xmlDoExport;
end;
procedure TControlEntity.setXmlPathinvoice(xmlPathinvoice: String);
begin
  self.xmlPathinvoice := xmlPathinvoice;
end;
procedure TControlEntity.setUseSetUnclean(useSetUnclean: Byte);
begin
  self.useSetUnclean := useSetUnclean;
end;
procedure TControlEntity.setNatSettings1(natSettings1: String);
begin
  self.natSettings1 := natSettings1;
end;
procedure TControlEntity.setNatSettings2(natSettings2: String);
begin
  self.natSettings2 := natSettings2;
end;
procedure TControlEntity.setNatSettings3(natSettings3: String);
begin
  self.natSettings3 := natSettings3;
end;
procedure TControlEntity.setXmlDoExportInLocalCurrency(XmlDoExportInLocalCurrency: Byte);
begin
  self.XmlDoExportInLocalCurrency := XmlDoExportInLocalCurrency;
end;
procedure TControlEntity.setSnPath(snPath: String);
begin
  self.snPath := snPath;
end;
procedure TControlEntity.setSnFieldSeparator(SnFieldSeparator: String);
begin
  self.SnFieldSeparator := SnFieldSeparator;
end;
procedure TControlEntity.setInvPriceGroup(invPriceGroup: String);
begin
  self.invPriceGroup := invPriceGroup;
end;
procedure TControlEntity.setNameOrderPeriod(NameOrderPeriod: Integer);
begin
  self.NameOrderPeriod := NameOrderPeriod;
end;
procedure TControlEntity.setSnPathXML(snPathXML: String);
begin
  self.snPathXML := snPathXML;
end;
procedure TControlEntity.setStayTaxItem(stayTaxItem: String);
begin
  self.stayTaxItem := stayTaxItem;
end;
procedure TControlEntity.setUseStayTax(useStayTax: Byte);
begin
  self.useStayTax := useStayTax;
end;
procedure TControlEntity.setSnXMLencoding(snXMLencoding: String);
begin
  self.snXMLencoding := snXMLencoding;
end;
procedure TControlEntity.setColor01(color01: String);
begin
  self.color01 := color01;
end;
procedure TControlEntity.setColor02(color02: String);
begin
  self.color02 := color02;
end;
procedure TControlEntity.setColor03(color03: String);
begin
  self.color03 := color03;
end;
procedure TControlEntity.setColor04(color04: String);
begin
  self.color04 := color04;
end;
procedure TControlEntity.setColor05(color05: String);
begin
  self.color05 := color05;
end;
procedure TControlEntity.setColor06(color06: String);
begin
  self.color06 := color06;
end;
procedure TControlEntity.setColor07(color07: String);
begin
  self.color07 := color07;
end;
procedure TControlEntity.setColor08(color08: String);
begin
  self.color08 := color08;
end;
procedure TControlEntity.setColor09(color09: String);
begin
  self.color09 := color09;
end;
procedure TControlEntity.setColor10(color10: String);
begin
  self.color10 := color10;
end;
procedure TControlEntity.setStatusAttrGuestStaying(StatusAttrGuestStaying: String);
begin
  self.StatusAttrGuestStaying := StatusAttrGuestStaying;
end;
procedure TControlEntity.setStatusAttrGuestLeavingNextDay(StatusAttrGuestLeavingNextDay: String);
begin
  self.StatusAttrGuestLeavingNextDay := StatusAttrGuestLeavingNextDay;
end;
procedure TControlEntity.setStatusAttrDeparted(StatusAttrDeparted: String);
begin
  self.StatusAttrDeparted := StatusAttrDeparted;
end;
procedure TControlEntity.setStatusAttrAllotment(StatusAttrAllotment: String);
begin
  self.StatusAttrAllotment := StatusAttrAllotment;
end;
procedure TControlEntity.setStatusAttrWaitinglist(StatusAttrWaitinglist: String);
begin
  self.StatusAttrWaitinglist := StatusAttrWaitinglist;
end;
procedure TControlEntity.setStatusAttrNoShow(StatusAttrNoShow: String);
begin
  self.StatusAttrNoShow := StatusAttrNoShow;
end;
procedure TControlEntity.setStatusAttrBlocked(StatusAttrBlocked: String);
begin
  self.StatusAttrBlocked := StatusAttrBlocked;
end;
procedure TControlEntity.setStatusAttrDeparting(StatusAttrDeparting: String);
begin
  self.StatusAttrDeparting := StatusAttrDeparting;
end;
procedure TControlEntity.setStatusAttrArrivingOtherLeaving(StatusAttrArrivingOtherLeaving: String);
begin
  self.StatusAttrArrivingOtherLeaving := StatusAttrArrivingOtherLeaving;
end;
procedure TControlEntity.setStatusAttrOrder(StatusAttrOrder: String);
begin
  self.StatusAttrOrder := StatusAttrOrder;
end;
procedure TControlEntity.setRackCustomer(RackCustomer: String);
begin
  self.RackCustomer := RackCustomer;
end;
procedure TControlEntity.setInvTxtOriginal(invTxtOriginal: String);
begin
  self.invTxtOriginal := invTxtOriginal;
end;
procedure TControlEntity.setInvTxtCopy(invTxtCopy: String);
begin
  self.invTxtCopy := invTxtCopy;
end;
procedure TControlEntity.setStayTaxIncluted(StayTaxIncluted: Byte);
begin
  self.StayTaxIncluted := StayTaxIncluted;
end;
procedure TControlEntity.setIvhTxtTotalStayTax(ivhTxtTotalStayTax: String);
begin
  self.ivhTxtTotalStayTax := ivhTxtTotalStayTax;
end;
procedure TControlEntity.setIvhTxtTotalStayTaxNights(ivhTxtTotalStayTaxNights: String);
begin
  self.ivhTxtTotalStayTaxNights := ivhTxtTotalStayTaxNights;
end;
procedure TControlEntity.setCallType(callType: Integer);
begin
  self.callType := callType;
end;
procedure TControlEntity.setCallLogInternal(callLogInternal: Byte);
begin
  self.callLogInternal := callLogInternal;
end;
procedure TControlEntity.setCallMinSec(callMinSec: Integer);
begin
  self.callMinSec := callMinSec;
end;
procedure TControlEntity.setCallStartPrice(callStartPrice: Double);
begin
  self.callStartPrice := callStartPrice;
end;
procedure TControlEntity.setCallMinUnits(callMinUnits: Integer);
begin
  self.callMinUnits := callMinUnits;
end;
procedure TControlEntity.setCallMinPrice(callMinPrice: Double);
begin
  self.callMinPrice := callMinPrice;
end;
procedure TControlEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TControlEntity.setChannelManagerUsername(ChannelManagerUsername: String);
begin
  self.ChannelManagerUsername := ChannelManagerUsername;
end;
procedure TControlEntity.setChannelManagerPassword(ChannelManagerPassword: String);
begin
  self.ChannelManagerPassword := ChannelManagerPassword;
end;
procedure TControlEntity.setChannelManagerHotelCode(ChannelManagerHotelCode: String);
begin
  self.ChannelManagerHotelCode := ChannelManagerHotelCode;
end;
procedure TControlEntity.setChannelManagerAdmin(ChannelManagerAdmin: String);
begin
  self.ChannelManagerAdmin := ChannelManagerAdmin;
end;
procedure TControlEntity.setChannelManagerAdminPassword(ChannelManagerAdminPassword: String);
begin
  self.ChannelManagerAdminPassword := ChannelManagerAdminPassword;
end;
procedure TControlEntity.setSessionTimeoutSeconds(SessionTimeoutSeconds: Integer);
begin
  self.SessionTimeoutSeconds := SessionTimeoutSeconds;
end;
procedure TControlEntity.setBedChangeInterval(bedChangeInterval: Integer);
begin
  self.bedChangeInterval := bedChangeInterval;
end;
procedure TControlEntity.setDefaultChannelId(DefaultChannelId: Integer);
begin
  self.DefaultChannelId := DefaultChannelId;
end;
procedure TControlEntity.setDefaultChannelManager(DefaultChannelManager: Integer);
begin
  self.DefaultChannelManager := DefaultChannelManager;
end;
procedure TControlEntity.setExcluteWaitingList(ExcluteWaitingList: Byte);
begin
  self.ExcluteWaitingList := ExcluteWaitingList;
end;
procedure TControlEntity.setExcluteAllotment(ExcluteAllotment: Byte);
begin
  self.ExcluteAllotment := ExcluteAllotment;
end;
procedure TControlEntity.setExcluteOrder(ExcluteOrder: Byte);
begin
  self.ExcluteOrder := ExcluteOrder;
end;
procedure TControlEntity.setExcluteDeparted(ExcluteDeparted: Byte);
begin
  self.ExcluteDeparted := ExcluteDeparted;
end;
procedure TControlEntity.setExcluteGuest(ExcluteGuest: Byte);
begin
  self.ExcluteGuest := ExcluteGuest;
end;
procedure TControlEntity.setExcluteNoshow(ExcluteNoshow: Byte);
begin
  self.ExcluteNoshow := ExcluteNoshow;
end;
procedure TControlEntity.setExcluteBlocked(ExcluteBlocked: Byte);
begin
  self.ExcluteBlocked := ExcluteBlocked;
end;
procedure TControlEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TControlEntity.setStatusAttrcanceled(StatusAttrcanceled: String);
begin
  self.StatusAttrcanceled := StatusAttrcanceled;
end;
procedure TControlEntity.setStatusAttrTmp1(StatusAttrTmp1: String);
begin
  self.StatusAttrTmp1 := StatusAttrTmp1;
end;
procedure TControlEntity.setStatusAttrTmp2(StatusAttrTmp2: String);
begin
  self.StatusAttrTmp2 := StatusAttrTmp2;
end;
procedure TControlEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TCountriesEntity **************************************************

procedure TCountriesEntity.setCountry(Country: String);
begin
  self.Country := Country;
end;
procedure TCountriesEntity.setCountryName(CountryName: String);
begin
  self.CountryName := CountryName;
end;
procedure TCountriesEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TCountriesEntity.setCountryGroup(CountryGroup: String);
begin
  self.CountryGroup := CountryGroup;
end;
procedure TCountriesEntity.setOrderIndex(OrderIndex: Integer);
begin
  self.OrderIndex := OrderIndex;
end;
procedure TCountriesEntity.setIslCountryName(IslCountryName: String);
begin
  self.IslCountryName := IslCountryName;
end;
procedure TCountriesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TCountriesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TCountriesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TCountriesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TCountrygroupsEntity **************************************************

procedure TCountrygroupsEntity.setCountryGroup(CountryGroup: String);
begin
  self.CountryGroup := CountryGroup;
end;
procedure TCountrygroupsEntity.setGroupName(GroupName: String);
begin
  self.GroupName := GroupName;
end;
procedure TCountrygroupsEntity.setIslGroupName(IslGroupName: String);
begin
  self.IslGroupName := IslGroupName;
end;
procedure TCountrygroupsEntity.setOrderIndex(OrderIndex: Integer);
begin
  self.OrderIndex := OrderIndex;
end;
procedure TCountrygroupsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TCountrygroupsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TCountrygroupsEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TCountrygroupsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TCurrenciesEntity **************************************************

procedure TCurrenciesEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TCurrenciesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TCurrenciesEntity.setAValue(AValue: Double);
begin
  self.AValue := AValue;
end;
procedure TCurrenciesEntity.setSellValue(SellValue: Double);
begin
  self.SellValue := SellValue;
end;
procedure TCurrenciesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TCurrenciesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TCurrenciesEntity.setCurrencySign(CurrencySign: String);
begin
  self.CurrencySign := CurrencySign;
end;
procedure TCurrenciesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TCurrenciesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TCustomerpersonsEntity **************************************************

procedure TCustomerpersonsEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TCustomerpersonsEntity.setCustomerId(customerId: Integer);
begin
  self.customerId := customerId;
end;
procedure TCustomerpersonsEntity.setPersonId(personId: Integer);
begin
  self.personId := personId;
end;
procedure TCustomerpersonsEntity.setPersonCode(personCode: String);
begin
  self.personCode := personCode;
end;
procedure TCustomerpersonsEntity.setAuthKey(authKey: String);
begin
  self.authKey := authKey;
end;
procedure TCustomerpersonsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TCustomerpreferencesEntity **************************************************

procedure TCustomerpreferencesEntity.setCustomer(Customer: String);
begin
  self.Customer := Customer;
end;
procedure TCustomerpreferencesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TCustomerpreferencesEntity.setPreference(Preference: String);
begin
  self.Preference := Preference;
end;
procedure TCustomerpreferencesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TCustomerpreferencesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TCustomerpreferencesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TCustomersEntity **************************************************

procedure TCustomersEntity.setCustomer(Customer: String);
begin
  self.Customer := Customer;
end;
procedure TCustomersEntity.setSurname(Surname: String);
begin
  self.Surname := Surname;
end;
procedure TCustomersEntity.setName(Name: String);
begin
  self.Name := Name;
end;
procedure TCustomersEntity.setCustomerType(CustomerType: String);
begin
  self.CustomerType := CustomerType;
end;
procedure TCustomersEntity.setAddress1(Address1: String);
begin
  self.Address1 := Address1;
end;
procedure TCustomersEntity.setAddress2(Address2: String);
begin
  self.Address2 := Address2;
end;
procedure TCustomersEntity.setAddress3(Address3: String);
begin
  self.Address3 := Address3;
end;
procedure TCustomersEntity.setAddress4(Address4: String);
begin
  self.Address4 := Address4;
end;
procedure TCustomersEntity.setCountry(Country: String);
begin
  self.Country := Country;
end;
procedure TCustomersEntity.setTel1(Tel1: String);
begin
  self.Tel1 := Tel1;
end;
procedure TCustomersEntity.setTel2(Tel2: String);
begin
  self.Tel2 := Tel2;
end;
procedure TCustomersEntity.setFax(Fax: String);
begin
  self.Fax := Fax;
end;
procedure TCustomersEntity.setDiscountPercent(DiscountPercent: Double);
begin
  self.DiscountPercent := DiscountPercent;
end;
procedure TCustomersEntity.setEmailAddress(EmailAddress: String);
begin
  self.EmailAddress := EmailAddress;
end;
procedure TCustomersEntity.setContactPerson(ContactPerson: String);
begin
  self.ContactPerson := ContactPerson;
end;
procedure TCustomersEntity.setTravelAgency(TravelAgency: Byte);
begin
  self.TravelAgency := TravelAgency;
end;
procedure TCustomersEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TCustomersEntity.setPID(PID: String);
begin
  self.PID := PID;
end;
procedure TCustomersEntity.setDele(dele: String);
begin
  self.dele := dele;
end;
procedure TCustomersEntity.setPcID(pcID: Integer);
begin
  self.pcID := pcID;
end;
procedure TCustomersEntity.setHomepage(Homepage: String);
begin
  self.Homepage := Homepage;
end;
procedure TCustomersEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TCustomersEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TCustomersEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TCustomersEntity.setMarketSegment(marketSegment: String);
begin
  self.marketSegment := marketSegment;
end;
procedure TCustomersEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TCustomertypesEntity **************************************************

procedure TCustomertypesEntity.setCustomerType(CustomerType: String);
begin
  self.CustomerType := CustomerType;
end;
procedure TCustomertypesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TCustomertypesEntity.setPriority(Priority: Integer);
begin
  self.Priority := Priority;
end;
procedure TCustomertypesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TCustomertypesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TCustomertypesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TCustomertypesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TDictionaryEntity **************************************************

procedure TDictionaryEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TDictionaryEntity.setCode(Code: String);
begin
  self.Code := Code;
end;
procedure TDictionaryEntity.setResult(Result: String);
begin
  self.Result := Result;
end;
procedure TDictionaryEntity.setLangId(LangId: Integer);
begin
  self.LangId := LangId;
end;
procedure TDictionaryEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TFacilityactiontypesEntity **************************************************

procedure TFacilityactiontypesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TFacilityactiontypesEntity.setCode(code: String);
begin
  self.code := code;
end;
procedure TFacilityactiontypesEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TFacilityactiontypesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TFakenamesEntity **************************************************

procedure TFakenamesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TFakenamesEntity.setGender(gender: String);
begin
  self.gender := gender;
end;
procedure TFakenamesEntity.setTitle(title: String);
begin
  self.title := title;
end;
procedure TFakenamesEntity.setGivenname(givenname: String);
begin
  self.givenname := givenname;
end;
procedure TFakenamesEntity.setSurname(surname: String);
begin
  self.surname := surname;
end;
procedure TFakenamesEntity.setStreetaddress(streetaddress: String);
begin
  self.streetaddress := streetaddress;
end;
procedure TFakenamesEntity.setCity(city: String);
begin
  self.city := city;
end;
procedure TFakenamesEntity.setState(state: String);
begin
  self.state := state;
end;
procedure TFakenamesEntity.setZipcode(zipcode: String);
begin
  self.zipcode := zipcode;
end;
procedure TFakenamesEntity.setCountry(country: String);
begin
  self.country := country;
end;
procedure TFakenamesEntity.setCountryfull(countryfull: String);
begin
  self.countryfull := countryfull;
end;
procedure TFakenamesEntity.setEmailaddress(emailaddress: String);
begin
  self.emailaddress := emailaddress;
end;
procedure TFakenamesEntity.setTelephonenumber(telephonenumber: String);
begin
  self.telephonenumber := telephonenumber;
end;
procedure TFakenamesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** THotelconfigurationsEntity **************************************************

procedure THotelconfigurationsEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure THotelconfigurationsEntity.setForceExternalCustomerIdCorrectness(forceExternalCustomerIdCorrectness: Byte);
begin
  self.forceExternalCustomerIdCorrectness := forceExternalCustomerIdCorrectness;
end;
procedure THotelconfigurationsEntity.setForceExternalProductIdCorrectness(forceExternalProductIdCorrectness: Byte);
begin
  self.forceExternalProductIdCorrectness := forceExternalProductIdCorrectness;
end;
procedure THotelconfigurationsEntity.setForceExternalPaymentTypeIdCorrectness(forceExternalPaymentTypeIdCorrectness: Byte);
begin
  self.forceExternalPaymentTypeIdCorrectness := forceExternalPaymentTypeIdCorrectness;
end;
procedure THotelconfigurationsEntity.setExpensiveChannelsLevelFrom(expensiveChannelsLevelFrom: Double);
begin
  self.expensiveChannelsLevelFrom := expensiveChannelsLevelFrom;
end;
procedure THotelconfigurationsEntity.setSpringStarts(springStarts: String);
begin
  self.springStarts := springStarts;
end;
procedure THotelconfigurationsEntity.setSummerStarts(summerStarts: String);
begin
  self.summerStarts := summerStarts;
end;
procedure THotelconfigurationsEntity.setAutumnStarts(autumnStarts: String);
begin
  self.autumnStarts := autumnStarts;
end;
procedure THotelconfigurationsEntity.setWinterStarts(winterStarts: String);
begin
  self.winterStarts := winterStarts;
end;
procedure THotelconfigurationsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** THotelcontactsEntity **************************************************

procedure THotelcontactsEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure THotelcontactsEntity.setCode(code: String);
begin
  self.code := code;
end;
procedure THotelcontactsEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure THotelcontactsEntity.setContactData(contactData: String);
begin
  self.contactData := contactData;
end;
procedure THotelcontactsEntity.setContactType(contactType: Integer);
begin
  self.contactType := contactType;
end;
procedure THotelcontactsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** THotelcountersEntity **************************************************

procedure THotelcountersEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure THotelcountersEntity.setLastReservation(lastReservation: Integer);
begin
  self.lastReservation := lastReservation;
end;
procedure THotelcountersEntity.setLastRoomReservation(lastRoomReservation: Integer);
begin
  self.lastRoomReservation := lastRoomReservation;
end;
procedure THotelcountersEntity.setLastInvoiceNumber(lastInvoiceNumber: Integer);
begin
  self.lastInvoiceNumber := lastInvoiceNumber;
end;
procedure THotelcountersEntity.setLastInvoiceProcessed(lastInvoiceProcessed: Integer);
begin
  self.lastInvoiceProcessed := lastInvoiceProcessed;
end;
procedure THotelcountersEntity.setLastPersonNumber(lastPersonNumber: Integer);
begin
  self.lastPersonNumber := lastPersonNumber;
end;
procedure THotelcountersEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** THoteltasksEntity **************************************************

procedure THoteltasksEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure THoteltasksEntity.setDate(date: TTimeStamp);
begin
  self.date := date;
end;
procedure THoteltasksEntity.setRoomstatus(roomstatus: Byte);
begin
  self.roomstatus := roomstatus;
end;
procedure THoteltasksEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TIdreferencesEntity **************************************************

procedure TIdreferencesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TIdreferencesEntity.setBreakfastPackageClassId(BreakfastPackageClassId: Integer);
begin
  self.BreakfastPackageClassId := BreakfastPackageClassId;
end;
procedure TIdreferencesEntity.setBreakfastItemId(BreakfastItemId: Integer);
begin
  self.BreakfastItemId := BreakfastItemId;
end;
procedure TIdreferencesEntity.setRoomRentItemId(RoomRentItemId: Integer);
begin
  self.RoomRentItemId := RoomRentItemId;
end;
procedure TIdreferencesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TIndustriesEntity **************************************************

procedure TIndustriesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TIndustriesEntity.setLanguageFormType(languageFormType: String);
begin
  self.languageFormType := languageFormType;
end;
procedure TIndustriesEntity.setLanguageCompName(languageCompName: String);
begin
  self.languageCompName := languageCompName;
end;
procedure TIndustriesEntity.setExtraIdentity(extraIdentity: String);
begin
  self.extraIdentity := extraIdentity;
end;
procedure TIndustriesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TInvoiceheadsEntity **************************************************

procedure TInvoiceheadsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TInvoiceheadsEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TInvoiceheadsEntity.setSplitNumber(SplitNumber: Integer);
begin
  self.SplitNumber := SplitNumber;
end;
procedure TInvoiceheadsEntity.setInvoiceNumber(InvoiceNumber: Integer);
begin
  self.InvoiceNumber := InvoiceNumber;
end;
procedure TInvoiceheadsEntity.setInvoiceDate(InvoiceDate: String);
begin
  self.InvoiceDate := InvoiceDate;
end;
procedure TInvoiceheadsEntity.setCustomer(Customer: String);
begin
  self.Customer := Customer;
end;
procedure TInvoiceheadsEntity.setName(Name: String);
begin
  self.Name := Name;
end;
procedure TInvoiceheadsEntity.setAddress1(Address1: String);
begin
  self.Address1 := Address1;
end;
procedure TInvoiceheadsEntity.setAddress2(Address2: String);
begin
  self.Address2 := Address2;
end;
procedure TInvoiceheadsEntity.setAddress3(Address3: String);
begin
  self.Address3 := Address3;
end;
procedure TInvoiceheadsEntity.setAddress4(Address4: String);
begin
  self.Address4 := Address4;
end;
procedure TInvoiceheadsEntity.setCountry(Country: String);
begin
  self.Country := Country;
end;
procedure TInvoiceheadsEntity.setTotal(Total: Double);
begin
  self.Total := Total;
end;
procedure TInvoiceheadsEntity.setTotalWOVAT(TotalWOVAT: Double);
begin
  self.TotalWOVAT := TotalWOVAT;
end;
procedure TInvoiceheadsEntity.setTotalVAT(TotalVAT: Double);
begin
  self.TotalVAT := TotalVAT;
end;
procedure TInvoiceheadsEntity.setTotalBreakFast(TotalBreakFast: Double);
begin
  self.TotalBreakFast := TotalBreakFast;
end;
procedure TInvoiceheadsEntity.setExtraText(ExtraText: String);
begin
  self.ExtraText := ExtraText;
end;
procedure TInvoiceheadsEntity.setFinished(Finished: Byte);
begin
  self.Finished := Finished;
end;
procedure TInvoiceheadsEntity.setReportDate(ReportDate: String);
begin
  self.ReportDate := ReportDate;
end;
procedure TInvoiceheadsEntity.setReportTime(ReportTime: String);
begin
  self.ReportTime := ReportTime;
end;
procedure TInvoiceheadsEntity.setCreditInvoice(CreditInvoice: Integer);
begin
  self.CreditInvoice := CreditInvoice;
end;
procedure TInvoiceheadsEntity.setOriginalInvoice(OriginalInvoice: Integer);
begin
  self.OriginalInvoice := OriginalInvoice;
end;
procedure TInvoiceheadsEntity.setInvoiceType(InvoiceType: Integer);
begin
  self.InvoiceType := InvoiceType;
end;
procedure TInvoiceheadsEntity.setIhTmp(ihTmp: String);
begin
  self.ihTmp := ihTmp;
end;
procedure TInvoiceheadsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TInvoiceheadsEntity.setCustPID(custPID: String);
begin
  self.custPID := custPID;
end;
procedure TInvoiceheadsEntity.setRoomGuest(RoomGuest: String);
begin
  self.RoomGuest := RoomGuest;
end;
procedure TInvoiceheadsEntity.setIhDate(ihDate: TTimeStamp);
begin
  self.ihDate := ihDate;
end;
procedure TInvoiceheadsEntity.setIhStaff(ihStaff: String);
begin
  self.ihStaff := ihStaff;
end;
procedure TInvoiceheadsEntity.setIhPayDate(ihPayDate: TTimeStamp);
begin
  self.ihPayDate := ihPayDate;
end;
procedure TInvoiceheadsEntity.setIhConfirmDate(ihConfirmDate: TTimeStamp);
begin
  self.ihConfirmDate := ihConfirmDate;
end;
procedure TInvoiceheadsEntity.setIhInvoiceDate(ihInvoiceDate: TTimeStamp);
begin
  self.ihInvoiceDate := ihInvoiceDate;
end;
procedure TInvoiceheadsEntity.setIhCurrency(ihCurrency: String);
begin
  self.ihCurrency := ihCurrency;
end;
procedure TInvoiceheadsEntity.setIhCurrencyRate(ihCurrencyRate: Double);
begin
  self.ihCurrencyRate := ihCurrencyRate;
end;
procedure TInvoiceheadsEntity.setInvRefrence(invRefrence: String);
begin
  self.invRefrence := invRefrence;
end;
procedure TInvoiceheadsEntity.setTotalStayTax(TotalStayTax: Double);
begin
  self.TotalStayTax := TotalStayTax;
end;
procedure TInvoiceheadsEntity.setTotalStayTaxNights(TotalStayTaxNights: Integer);
begin
  self.TotalStayTaxNights := TotalStayTaxNights;
end;
procedure TInvoiceheadsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TInvoicelinesEntity **************************************************

procedure TInvoicelinesEntity.setAutoGen(AutoGen: String);
begin
  self.AutoGen := AutoGen;
end;
procedure TInvoicelinesEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TInvoicelinesEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TInvoicelinesEntity.setSplitNumber(SplitNumber: Integer);
begin
  self.SplitNumber := SplitNumber;
end;
procedure TInvoicelinesEntity.setItemNumber(ItemNumber: Integer);
begin
  self.ItemNumber := ItemNumber;
end;
procedure TInvoicelinesEntity.setPurchaseDate(PurchaseDate: String);
begin
  self.PurchaseDate := PurchaseDate;
end;
procedure TInvoicelinesEntity.setInvoiceNumber(InvoiceNumber: Integer);
begin
  self.InvoiceNumber := InvoiceNumber;
end;
procedure TInvoicelinesEntity.setItemID(ItemID: String);
begin
  self.ItemID := ItemID;
end;
procedure TInvoicelinesEntity.setNumber(Number: Integer);
begin
  self.Number := Number;
end;
procedure TInvoicelinesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TInvoicelinesEntity.setPrice(Price: Double);
begin
  self.Price := Price;
end;
procedure TInvoicelinesEntity.setVATType(VATType: String);
begin
  self.VATType := VATType;
end;
procedure TInvoicelinesEntity.setTotal(Total: Double);
begin
  self.Total := Total;
end;
procedure TInvoicelinesEntity.setTotalWOVat(TotalWOVat: Double);
begin
  self.TotalWOVat := TotalWOVat;
end;
procedure TInvoicelinesEntity.setVat(Vat: Double);
begin
  self.Vat := Vat;
end;
procedure TInvoicelinesEntity.setAutoGenerated(AutoGenerated: Byte);
begin
  self.AutoGenerated := AutoGenerated;
end;
procedure TInvoicelinesEntity.setCurrencyRate(CurrencyRate: Double);
begin
  self.CurrencyRate := CurrencyRate;
end;
procedure TInvoicelinesEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TInvoicelinesEntity.setReportDate(ReportDate: String);
begin
  self.ReportDate := ReportDate;
end;
procedure TInvoicelinesEntity.setReportTime(ReportTime: String);
begin
  self.ReportTime := ReportTime;
end;
procedure TInvoicelinesEntity.setPersons(Persons: Integer);
begin
  self.Persons := Persons;
end;
procedure TInvoicelinesEntity.setNights(Nights: Integer);
begin
  self.Nights := Nights;
end;
procedure TInvoicelinesEntity.setBreakfastPrice(BreakfastPrice: Double);
begin
  self.BreakfastPrice := BreakfastPrice;
end;
procedure TInvoicelinesEntity.setAyear(Ayear: Integer);
begin
  self.Ayear := Ayear;
end;
procedure TInvoicelinesEntity.setAmon(Amon: Integer);
begin
  self.Amon := Amon;
end;
procedure TInvoicelinesEntity.setAday(Aday: Integer);
begin
  self.Aday := Aday;
end;
procedure TInvoicelinesEntity.setIlTmp(ilTmp: String);
begin
  self.ilTmp := ilTmp;
end;
procedure TInvoicelinesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TInvoicelinesEntity.setIlAccountKey(ilAccountKey: String);
begin
  self.ilAccountKey := ilAccountKey;
end;
procedure TInvoicelinesEntity.setItemCurrency(ItemCurrency: String);
begin
  self.ItemCurrency := ItemCurrency;
end;
procedure TInvoicelinesEntity.setItemCurrencyRate(ItemCurrencyRate: Double);
begin
  self.ItemCurrencyRate := ItemCurrencyRate;
end;
procedure TInvoicelinesEntity.setDiscount(Discount: Double);
begin
  self.Discount := Discount;
end;
procedure TInvoicelinesEntity.setDiscountisprecent(Discountisprecent: Byte);
begin
  self.Discountisprecent := Discountisprecent;
end;
procedure TInvoicelinesEntity.setImportRefrence(ImportRefrence: String);
begin
  self.ImportRefrence := ImportRefrence;
end;
procedure TInvoicelinesEntity.setImportSource(ImportSource: String);
begin
  self.ImportSource := ImportSource;
end;
procedure TInvoicelinesEntity.setIsPackage(isPackage: Byte);
begin
  self.isPackage := isPackage;
end;
procedure TInvoicelinesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TInvoicelinestmpEntity **************************************************

procedure TInvoicelinestmpEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TInvoicelinestmpEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TInvoicelinestmpEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TInvoicelinestmpEntity.setSplitNumber(SplitNumber: Integer);
begin
  self.SplitNumber := SplitNumber;
end;
procedure TInvoicelinestmpEntity.setItemNumber(ItemNumber: Integer);
begin
  self.ItemNumber := ItemNumber;
end;
procedure TInvoicelinestmpEntity.setPurchaseDate(PurchaseDate: TTimeStamp);
begin
  self.PurchaseDate := PurchaseDate;
end;
procedure TInvoicelinestmpEntity.setInvoiceNumber(InvoiceNumber: Integer);
begin
  self.InvoiceNumber := InvoiceNumber;
end;
procedure TInvoicelinestmpEntity.setItemID(ItemID: String);
begin
  self.ItemID := ItemID;
end;
procedure TInvoicelinestmpEntity.setNumber(Number: Integer);
begin
  self.Number := Number;
end;
procedure TInvoicelinestmpEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TInvoicelinestmpEntity.setPrice(Price: Double);
begin
  self.Price := Price;
end;
procedure TInvoicelinestmpEntity.setVATType(VATType: String);
begin
  self.VATType := VATType;
end;
procedure TInvoicelinestmpEntity.setTotal(Total: Double);
begin
  self.Total := Total;
end;
procedure TInvoicelinestmpEntity.setTotalWOVat(TotalWOVat: Double);
begin
  self.TotalWOVat := TotalWOVat;
end;
procedure TInvoicelinestmpEntity.setVat(Vat: Double);
begin
  self.Vat := Vat;
end;
procedure TInvoicelinestmpEntity.setCurrencyRate(CurrencyRate: Double);
begin
  self.CurrencyRate := CurrencyRate;
end;
procedure TInvoicelinestmpEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TInvoicelinestmpEntity.setPersons(Persons: Integer);
begin
  self.Persons := Persons;
end;
procedure TInvoicelinestmpEntity.setNights(Nights: Integer);
begin
  self.Nights := Nights;
end;
procedure TInvoicelinestmpEntity.setBreakfastPrice(BreakfastPrice: Double);
begin
  self.BreakfastPrice := BreakfastPrice;
end;
procedure TInvoicelinestmpEntity.setDateCreated(dateCreated: TTimeStamp);
begin
  self.dateCreated := dateCreated;
end;
procedure TInvoicelinestmpEntity.setIlAccountKey(ilAccountKey: String);
begin
  self.ilAccountKey := ilAccountKey;
end;
procedure TInvoicelinestmpEntity.setItemCurrency(ItemCurrency: String);
begin
  self.ItemCurrency := ItemCurrency;
end;
procedure TInvoicelinestmpEntity.setDiscount(Discount: Double);
begin
  self.Discount := Discount;
end;
procedure TInvoicelinestmpEntity.setDiscountisprecent(Discountisprecent: Byte);
begin
  self.Discountisprecent := Discountisprecent;
end;
procedure TInvoicelinestmpEntity.setImportRefrence(importRefrence: String);
begin
  self.importRefrence := importRefrence;
end;
procedure TInvoicelinestmpEntity.setImportSource(ImportSource: String);
begin
  self.ImportSource := ImportSource;
end;
procedure TInvoicelinestmpEntity.setTmpType(tmpType: Integer);
begin
  self.tmpType := tmpType;
end;
procedure TInvoicelinestmpEntity.setTmpData(tmpData: String);
begin
  self.tmpData := tmpData;
end;
procedure TInvoicelinestmpEntity.setIsPackage(isPackage: Byte);
begin
  self.isPackage := isPackage;
end;
procedure TInvoicelinestmpEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TItemsEntity **************************************************

procedure TItemsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TItemsEntity.setItem(Item: String);
begin
  self.Item := Item;
end;
procedure TItemsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TItemsEntity.setMinibarItem(MinibarItem: Byte);
begin
  self.MinibarItem := MinibarItem;
end;
procedure TItemsEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TItemsEntity.setPrice(Price: Double);
begin
  self.Price := Price;
end;
procedure TItemsEntity.setItemtype(Itemtype: String);
begin
  self.Itemtype := Itemtype;
end;
procedure TItemsEntity.setAccountKey(AccountKey: String);
begin
  self.AccountKey := AccountKey;
end;
procedure TItemsEntity.setHide(Hide: Byte);
begin
  self.Hide := Hide;
end;
procedure TItemsEntity.setSystemItem(SystemItem: Byte);
begin
  self.SystemItem := SystemItem;
end;
procedure TItemsEntity.setRoomRentitem(RoomRentitem: Byte);
begin
  self.RoomRentitem := RoomRentitem;
end;
procedure TItemsEntity.setReservationItem(ReservationItem: Byte);
begin
  self.ReservationItem := ReservationItem;
end;
procedure TItemsEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TItemsEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TItemsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TItemtypesEntity **************************************************

procedure TItemtypesEntity.setItemtype(Itemtype: String);
begin
  self.Itemtype := Itemtype;
end;
procedure TItemtypesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TItemtypesEntity.setVATCode(VATCode: String);
begin
  self.VATCode := VATCode;
end;
procedure TItemtypesEntity.setAccItemLink(AccItemLink: String);
begin
  self.AccItemLink := AccItemLink;
end;
procedure TItemtypesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TItemtypesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TItemtypesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TItemtypesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TLocationsEntity **************************************************

procedure TLocationsEntity.setLocation(Location: String);
begin
  self.Location := Location;
end;
procedure TLocationsEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TLocationsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TLocationsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TLocationsEntity.setChannelManager(ChannelManager: Integer);
begin
  self.ChannelManager := ChannelManager;
end;
procedure TLocationsEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TLocationsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TMaintenancecodesEntity **************************************************

procedure TMaintenancecodesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TMaintenancecodesEntity.setName(name: String);
begin
  self.name := name;
end;
procedure TMaintenancecodesEntity.setCode(code: String);
begin
  self.code := code;
end;
procedure TMaintenancecodesEntity.setColor(color: String);
begin
  self.color := color;
end;
procedure TMaintenancecodesEntity.setSelectionOrder(selectionOrder: Integer);
begin
  self.selectionOrder := selectionOrder;
end;
procedure TMaintenancecodesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TMaintenancecodesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TMaintenanceroomnotesEntity **************************************************

procedure TMaintenanceroomnotesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TMaintenanceroomnotesEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TMaintenanceroomnotesEntity.setDateAndTime(DateAndTime: TDateTime);
begin
  self.DateAndTime := DateAndTime;
end;
procedure TMaintenanceroomnotesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TMaintenanceroomnotesEntity.setCleaningNotes(CleaningNotes: String);
begin
  self.CleaningNotes := CleaningNotes;
end;
procedure TMaintenanceroomnotesEntity.setMaintenanceNotes(MaintenanceNotes: String);
begin
  self.MaintenanceNotes := MaintenanceNotes;
end;
procedure TMaintenanceroomnotesEntity.setLostAndFound(LostAndFound: String);
begin
  self.LostAndFound := LostAndFound;
end;
procedure TMaintenanceroomnotesEntity.setStaffIdReported(staffIdReported: Integer);
begin
  self.staffIdReported := staffIdReported;
end;
procedure TMaintenanceroomnotesEntity.setStaffIdFixed(staffIdFixed: Integer);
begin
  self.staffIdFixed := staffIdFixed;
end;
procedure TMaintenanceroomnotesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TMaintenanceroomnotesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPackageclassesEntity **************************************************

procedure TPackageclassesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPackageclassesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TPackageclassesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPackageitemsEntity **************************************************

procedure TPackageitemsEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPackageitemsEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TPackageitemsEntity.setPackageId(packageId: Integer);
begin
  self.packageId := packageId;
end;
procedure TPackageitemsEntity.setItemId(itemId: Integer);
begin
  self.itemId := itemId;
end;
procedure TPackageitemsEntity.setNumItems(numItems: Double);
begin
  self.numItems := numItems;
end;
procedure TPackageitemsEntity.setUnitPrice(unitPrice: Double);
begin
  self.unitPrice := unitPrice;
end;
procedure TPackageitemsEntity.setNumItemsMethod(numItemsMethod: Integer);
begin
  self.numItemsMethod := numItemsMethod;
end;
procedure TPackageitemsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPackagesEntity **************************************************

procedure TPackagesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPackagesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TPackagesEntity.setCode(Code: String);
begin
  self.Code := Code;
end;
procedure TPackagesEntity.setShowItemsOnInvoice(showItemsOnInvoice: Byte);
begin
  self.showItemsOnInvoice := showItemsOnInvoice;
end;
procedure TPackagesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TPackagesEntity.setCurrencyID(CurrencyID: Integer);
begin
  self.CurrencyID := CurrencyID;
end;
procedure TPackagesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TPackagesEntity.setPackageClassId(PackageClassId: Integer);
begin
  self.PackageClassId := PackageClassId;
end;
procedure TPackagesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPackageusageEntity **************************************************

procedure TPackageusageEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPackageusageEntity.setPackageId(PackageId: Integer);
begin
  self.PackageId := PackageId;
end;
procedure TPackageusageEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TPackageusageEntity.setEventDate(EventDate: TTimeStamp);
begin
  self.EventDate := EventDate;
end;
procedure TPackageusageEntity.setPurchased(Purchased: Byte);
begin
  self.Purchased := Purchased;
end;
procedure TPackageusageEntity.setAlreadyAttended(AlreadyAttended: Byte);
begin
  self.AlreadyAttended := AlreadyAttended;
end;
procedure TPackageusageEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPaygroupsEntity **************************************************

procedure TPaygroupsEntity.setPayGroup(PayGroup: String);
begin
  self.PayGroup := PayGroup;
end;
procedure TPaygroupsEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TPaygroupsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TPaygroupsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TPaygroupsEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TPaygroupsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPaymentsEntity **************************************************

procedure TPaymentsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TPaymentsEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TPaymentsEntity.setPerson(Person: Integer);
begin
  self.Person := Person;
end;
procedure TPaymentsEntity.setAutoGen(AutoGen: String);
begin
  self.AutoGen := AutoGen;
end;
procedure TPaymentsEntity.setTypeIndex(TypeIndex: Integer);
begin
  self.TypeIndex := TypeIndex;
end;
procedure TPaymentsEntity.setInvoiceNumber(InvoiceNumber: Integer);
begin
  self.InvoiceNumber := InvoiceNumber;
end;
procedure TPaymentsEntity.setPayDate(PayDate: String);
begin
  self.PayDate := PayDate;
end;
procedure TPaymentsEntity.setCustomer(Customer: String);
begin
  self.Customer := Customer;
end;
procedure TPaymentsEntity.setPayType(PayType: String);
begin
  self.PayType := PayType;
end;
procedure TPaymentsEntity.setAmount(Amount: Double);
begin
  self.Amount := Amount;
end;
procedure TPaymentsEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TPaymentsEntity.setCurrencyRate(CurrencyRate: Double);
begin
  self.CurrencyRate := CurrencyRate;
end;
procedure TPaymentsEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TPaymentsEntity.setReportDate(ReportDate: String);
begin
  self.ReportDate := ReportDate;
end;
procedure TPaymentsEntity.setReportTime(ReportTime: String);
begin
  self.ReportTime := ReportTime;
end;
procedure TPaymentsEntity.setAyear(Ayear: Integer);
begin
  self.Ayear := Ayear;
end;
procedure TPaymentsEntity.setAmon(Amon: Integer);
begin
  self.Amon := Amon;
end;
procedure TPaymentsEntity.setAday(Aday: Integer);
begin
  self.Aday := Aday;
end;
procedure TPaymentsEntity.setPmTmp(pmTmp: String);
begin
  self.pmTmp := pmTmp;
end;
procedure TPaymentsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TPaymentsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPaytypesEntity **************************************************

procedure TPaytypesEntity.setPayType(PayType: String);
begin
  self.PayType := PayType;
end;
procedure TPaytypesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TPaytypesEntity.setPayGroup(PayGroup: String);
begin
  self.PayGroup := PayGroup;
end;
procedure TPaytypesEntity.setAskCode(AskCode: Byte);
begin
  self.AskCode := AskCode;
end;
procedure TPaytypesEntity.setPtDays(ptDays: Integer);
begin
  self.ptDays := ptDays;
end;
procedure TPaytypesEntity.setDoExport(doExport: Byte);
begin
  self.doExport := doExport;
end;
procedure TPaytypesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TPaytypesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TPaytypesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TPaytypesEntity.setBookKey(BookKey: String);
begin
  self.BookKey := BookKey;
end;
procedure TPaytypesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPersonEntity **************************************************

procedure TPersonEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPersonEntity.setActive(active: Byte);
begin
  self.active := active;
end;
procedure TPersonEntity.setFirstName(firstName: String);
begin
  self.firstName := firstName;
end;
procedure TPersonEntity.setMiddleName(middleName: String);
begin
  self.middleName := middleName;
end;
procedure TPersonEntity.setLastName(lastName: String);
begin
  self.lastName := lastName;
end;
procedure TPersonEntity.setFullName(fullName: String);
begin
  self.fullName := fullName;
end;
procedure TPersonEntity.setSalutation(salutation: String);
begin
  self.salutation := salutation;
end;
procedure TPersonEntity.setGender(gender: Integer);
begin
  self.gender := gender;
end;
procedure TPersonEntity.setProfession(profession: String);
begin
  self.profession := profession;
end;
procedure TPersonEntity.setRole(role: String);
begin
  self.role := role;
end;
procedure TPersonEntity.setBirthday(birthday: TDateTime);
begin
  self.birthday := birthday;
end;
procedure TPersonEntity.setNationality(nationality: Integer);
begin
  self.nationality := nationality;
end;
procedure TPersonEntity.setLanguage(language: Integer);
begin
  self.language := language;
end;
procedure TPersonEntity.setPassportNumber(passportNumber: String);
begin
  self.passportNumber := passportNumber;
end;
procedure TPersonEntity.setPersonDescription(personDescription: String);
begin
  self.personDescription := personDescription;
end;
procedure TPersonEntity.setPersonNotes(personNotes: String);
begin
  self.personNotes := personNotes;
end;
procedure TPersonEntity.setSpouseName(spouseName: String);
begin
  self.spouseName := spouseName;
end;
procedure TPersonEntity.setChildren(children: String);
begin
  self.children := children;
end;
procedure TPersonEntity.setFamilyNotes(familyNotes: String);
begin
  self.familyNotes := familyNotes;
end;
procedure TPersonEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPersonaddressEntity **************************************************

procedure TPersonaddressEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPersonaddressEntity.setPersonId(personId: Integer);
begin
  self.personId := personId;
end;
procedure TPersonaddressEntity.setSysType(sysType: Integer);
begin
  self.sysType := sysType;
end;
procedure TPersonaddressEntity.setAddress1(address1: String);
begin
  self.address1 := address1;
end;
procedure TPersonaddressEntity.setAddress2(address2: String);
begin
  self.address2 := address2;
end;
procedure TPersonaddressEntity.setCity(city: String);
begin
  self.city := city;
end;
procedure TPersonaddressEntity.setZip(zip: String);
begin
  self.zip := zip;
end;
procedure TPersonaddressEntity.setState(state: String);
begin
  self.state := state;
end;
procedure TPersonaddressEntity.setCountryId(countryId: Integer);
begin
  self.countryId := countryId;
end;
procedure TPersonaddressEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPersonchildrenEntity **************************************************

procedure TPersonchildrenEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPersonchildrenEntity.setPersonId(personId: Integer);
begin
  self.personId := personId;
end;
procedure TPersonchildrenEntity.setName(name: String);
begin
  self.name := name;
end;
procedure TPersonchildrenEntity.setChildPersonId(childPersonId: Integer);
begin
  self.childPersonId := childPersonId;
end;
procedure TPersonchildrenEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPersoncontactEntity **************************************************

procedure TPersoncontactEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPersoncontactEntity.setPersonId(personId: Integer);
begin
  self.personId := personId;
end;
procedure TPersoncontactEntity.setContactType(contactType: Integer);
begin
  self.contactType := contactType;
end;
procedure TPersoncontactEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TPersoncontactEntity.setContactInfo(contactInfo: String);
begin
  self.contactInfo := contactInfo;
end;
procedure TPersoncontactEntity.setExtraInfo(extraInfo: String);
begin
  self.extraInfo := extraInfo;
end;
procedure TPersoncontactEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPersoncontacttypeEntity **************************************************

procedure TPersoncontacttypeEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPersoncontacttypeEntity.setCode(code: String);
begin
  self.code := code;
end;
procedure TPersoncontacttypeEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TPersoncontacttypeEntity.setSysType(sysType: Integer);
begin
  self.sysType := sysType;
end;
procedure TPersoncontacttypeEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TPersoncontacttypeEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPersonitemsEntity **************************************************

procedure TPersonitemsEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPersonitemsEntity.setPersonId(personId: Integer);
begin
  self.personId := personId;
end;
procedure TPersonitemsEntity.setItemId(itemId: Integer);
begin
  self.itemId := itemId;
end;
procedure TPersonitemsEntity.setNumItems(numItems: Integer);
begin
  self.numItems := numItems;
end;
procedure TPersonitemsEntity.setNotes(notes: String);
begin
  self.notes := notes;
end;
procedure TPersonitemsEntity.setPrice(price: String);
begin
  self.price := price;
end;
procedure TPersonitemsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPersonprofileEntity **************************************************

procedure TPersonprofileEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPersonprofileEntity.setPersonId(personId: Integer);
begin
  self.personId := personId;
end;
procedure TPersonprofileEntity.setVipType(vipType: Integer);
begin
  self.vipType := vipType;
end;
procedure TPersonprofileEntity.setVipNotification(vipNotification: Integer);
begin
  self.vipNotification := vipNotification;
end;
procedure TPersonprofileEntity.setDaysBefore(daysBefore: Integer);
begin
  self.daysBefore := daysBefore;
end;
procedure TPersonprofileEntity.setHoursBefore(hoursBefore: Integer);
begin
  self.hoursBefore := hoursBefore;
end;
procedure TPersonprofileEntity.setMinutesBefore(minutesBefore: Integer);
begin
  self.minutesBefore := minutesBefore;
end;
procedure TPersonprofileEntity.setGuestType(guestType: Integer);
begin
  self.guestType := guestType;
end;
procedure TPersonprofileEntity.setIndustry(industry: Integer);
begin
  self.industry := industry;
end;
procedure TPersonprofileEntity.setCompanyName(companyName: String);
begin
  self.companyName := companyName;
end;
procedure TPersonprofileEntity.setDepartment(department: String);
begin
  self.department := department;
end;
procedure TPersonprofileEntity.setCustomer(customer: Integer);
begin
  self.customer := customer;
end;
procedure TPersonprofileEntity.setPrefRoom(prefRoom: String);
begin
  self.prefRoom := prefRoom;
end;
procedure TPersonprofileEntity.setPrefLocation(prefLocation: Integer);
begin
  self.prefLocation := prefLocation;
end;
procedure TPersonprofileEntity.setPrefFloor(prefFloor: Integer);
begin
  self.prefFloor := prefFloor;
end;
procedure TPersonprofileEntity.setMailingList(mailingList: Byte);
begin
  self.mailingList := mailingList;
end;
procedure TPersonprofileEntity.setItemsNotification(itemsNotification: Integer);
begin
  self.itemsNotification := itemsNotification;
end;
procedure TPersonprofileEntity.setNotes(notes: String);
begin
  self.notes := notes;
end;
procedure TPersonprofileEntity.setNotesNotification(notesNotification: Integer);
begin
  self.notesNotification := notesNotification;
end;
procedure TPersonprofileEntity.setCurrency(currency: String);
begin
  self.currency := currency;
end;
procedure TPersonprofileEntity.setPayType(payType: Integer);
begin
  self.payType := payType;
end;
procedure TPersonprofileEntity.setPayCardNumber(payCardNumber: String);
begin
  self.payCardNumber := payCardNumber;
end;
procedure TPersonprofileEntity.setPayNameOnCard(payNameOnCard: String);
begin
  self.payNameOnCard := payNameOnCard;
end;
procedure TPersonprofileEntity.setPayExpireMonth(payExpireMonth: Integer);
begin
  self.payExpireMonth := payExpireMonth;
end;
procedure TPersonprofileEntity.setPayExpireYear(payExpireYear: Integer);
begin
  self.payExpireYear := payExpireYear;
end;
procedure TPersonprofileEntity.setPayCVC(payCVC: String);
begin
  self.payCVC := payCVC;
end;
procedure TPersonprofileEntity.setPayBillTo(payBillTo: String);
begin
  self.payBillTo := payBillTo;
end;
procedure TPersonprofileEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TPersonprofileEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPersonsEntity **************************************************

procedure TPersonsEntity.setPerson(Person: Integer);
begin
  self.Person := Person;
end;
procedure TPersonsEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TPersonsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TPersonsEntity.setTitle(title: String);
begin
  self.title := title;
end;
procedure TPersonsEntity.setName(Name: String);
begin
  self.Name := Name;
end;
procedure TPersonsEntity.setSurname(Surname: String);
begin
  self.Surname := Surname;
end;
procedure TPersonsEntity.setAddress1(Address1: String);
begin
  self.Address1 := Address1;
end;
procedure TPersonsEntity.setAddress2(Address2: String);
begin
  self.Address2 := Address2;
end;
procedure TPersonsEntity.setAddress3(Address3: String);
begin
  self.Address3 := Address3;
end;
procedure TPersonsEntity.setAddress4(Address4: String);
begin
  self.Address4 := Address4;
end;
procedure TPersonsEntity.setCountry(Country: String);
begin
  self.Country := Country;
end;
procedure TPersonsEntity.setCompany(Company: String);
begin
  self.Company := Company;
end;
procedure TPersonsEntity.setTel1(Tel1: String);
begin
  self.Tel1 := Tel1;
end;
procedure TPersonsEntity.setTel2(Tel2: String);
begin
  self.Tel2 := Tel2;
end;
procedure TPersonsEntity.setFax(Fax: String);
begin
  self.Fax := Fax;
end;
procedure TPersonsEntity.setEmail(Email: String);
begin
  self.Email := Email;
end;
procedure TPersonsEntity.setGuestType(GuestType: String);
begin
  self.GuestType := GuestType;
end;
procedure TPersonsEntity.setInformation(Information: String);
begin
  self.Information := Information;
end;
procedure TPersonsEntity.setPID(PID: String);
begin
  self.PID := PID;
end;
procedure TPersonsEntity.setMainName(MainName: Byte);
begin
  self.MainName := MainName;
end;
procedure TPersonsEntity.setCustomer(Customer: String);
begin
  self.Customer := Customer;
end;
procedure TPersonsEntity.setPeTmp(peTmp: String);
begin
  self.peTmp := peTmp;
end;
procedure TPersonsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TPersonsEntity.setHallReservation(HallReservation: Integer);
begin
  self.HallReservation := HallReservation;
end;
procedure TPersonsEntity.setHgrID(hgrID: Integer);
begin
  self.hgrID := hgrID;
end;
procedure TPersonsEntity.setState(state: String);
begin
  self.state := state;
end;
procedure TPersonsEntity.setSourceId(sourceId: String);
begin
  self.sourceId := sourceId;
end;
procedure TPersonsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPersonviptypesEntity **************************************************

procedure TPersonviptypesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPersonviptypesEntity.setCode(code: String);
begin
  self.code := code;
end;
procedure TPersonviptypesEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TPersonviptypesEntity.setVipGrade(vipGrade: Integer);
begin
  self.vipGrade := vipGrade;
end;
procedure TPersonviptypesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TPersonviptypesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPredefineddatesEntity **************************************************

procedure TPredefineddatesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPredefineddatesEntity.setDate(date: TTimeStamp);
begin
  self.date := date;
end;
procedure TPredefineddatesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPricerulesEntity **************************************************

procedure TPricerulesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TPricerulesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TPricerulesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TPricerulesEntity.setApplyToDates(ApplyToDates: String);
begin
  self.ApplyToDates := ApplyToDates;
end;
procedure TPricerulesEntity.setApplyToSeasons(ApplyToSeasons: String);
begin
  self.ApplyToSeasons := ApplyToSeasons;
end;
procedure TPricerulesEntity.setApplyToRoomTypes(ApplyToRoomTypes: String);
begin
  self.ApplyToRoomTypes := ApplyToRoomTypes;
end;
procedure TPricerulesEntity.setApplyToRoomGroups(ApplyToRoomGroups: String);
begin
  self.ApplyToRoomGroups := ApplyToRoomGroups;
end;
procedure TPricerulesEntity.setApplyToRooms(ApplyToRooms: String);
begin
  self.ApplyToRooms := ApplyToRooms;
end;
procedure TPricerulesEntity.setRules(Rules: String);
begin
  self.Rules := Rules;
end;
procedure TPricerulesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPricerulespackagesEntity **************************************************

procedure TPricerulespackagesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPricerulespackagesEntity.setPriceRuleId(priceRuleId: Integer);
begin
  self.priceRuleId := priceRuleId;
end;
procedure TPricerulespackagesEntity.setPackageId(packageId: Integer);
begin
  self.packageId := packageId;
end;
procedure TPricerulespackagesEntity.setNumPackages(numPackages: Integer);
begin
  self.numPackages := numPackages;
end;
procedure TPricerulespackagesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPricetypesEntity **************************************************

procedure TPricetypesEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TPricetypesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TPricetypesEntity.setPrice2Persons(Price2Persons: Double);
begin
  self.Price2Persons := Price2Persons;
end;
procedure TPricetypesEntity.setPrice1Person(Price1Person: Double);
begin
  self.Price1Person := Price1Person;
end;
procedure TPricetypesEntity.setPriceExtraPerson(PriceExtraPerson: Double);
begin
  self.PriceExtraPerson := PriceExtraPerson;
end;
procedure TPricetypesEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TPricetypesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TPricetypesEntity.setPrice3Persons(Price3Persons: Double);
begin
  self.Price3Persons := Price3Persons;
end;
procedure TPricetypesEntity.setPrice4Persons(Price4Persons: Double);
begin
  self.Price4Persons := Price4Persons;
end;
procedure TPricetypesEntity.setPrice5Persons(Price5Persons: Double);
begin
  self.Price5Persons := Price5Persons;
end;
procedure TPricetypesEntity.setPrice6Persons(Price6Persons: Double);
begin
  self.Price6Persons := Price6Persons;
end;
procedure TPricetypesEntity.setSeID(seID: Integer);
begin
  self.seID := seID;
end;
procedure TPricetypesEntity.setPcID(pcID: Integer);
begin
  self.pcID := pcID;
end;
procedure TPricetypesEntity.setRoundType(RoundType: Integer);
begin
  self.RoundType := RoundType;
end;
procedure TPricetypesEntity.setRoundStartAt(RoundStartAt: Integer);
begin
  self.RoundStartAt := RoundStartAt;
end;
procedure TPricetypesEntity.setPriceType(PriceType: String);
begin
  self.PriceType := PriceType;
end;
procedure TPricetypesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TPricetypesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPromocodesEntity **************************************************

procedure TPromocodesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TPromocodesEntity.setPromoCode(promoCode: String);
begin
  self.promoCode := promoCode;
end;
procedure TPromocodesEntity.setValidThrough(validThrough: TDateTime);
begin
  self.validThrough := validThrough;
end;
procedure TPromocodesEntity.setCreateDate(createDate: TDateTime);
begin
  self.createDate := createDate;
end;
procedure TPromocodesEntity.setStaffId(staffId: Integer);
begin
  self.staffId := staffId;
end;
procedure TPromocodesEntity.setValidityPeriodFrom(validityPeriodFrom: TDateTime);
begin
  self.validityPeriodFrom := validityPeriodFrom;
end;
procedure TPromocodesEntity.setValidityPeriodThrough(validityPeriodThrough: TDateTime);
begin
  self.validityPeriodThrough := validityPeriodThrough;
end;
procedure TPromocodesEntity.setPercentage(percentage: Double);
begin
  self.percentage := percentage;
end;
procedure TPromocodesEntity.setAmount(amount: Double);
begin
  self.amount := amount;
end;
procedure TPromocodesEntity.setAmountPerRoom(amountPerRoom: Double);
begin
  self.amountPerRoom := amountPerRoom;
end;
procedure TPromocodesEntity.setMaxAmount(maxAmount: Double);
begin
  self.maxAmount := maxAmount;
end;
procedure TPromocodesEntity.setRoomTypes(roomTypes: String);
begin
  self.roomTypes := roomTypes;
end;
procedure TPromocodesEntity.setRoomClasses(roomClasses: String);
begin
  self.roomClasses := roomClasses;
end;
procedure TPromocodesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TPropertiesstoreEntity **************************************************

procedure TPropertiesstoreEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TPropertiesstoreEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TPropertiesstoreEntity.setAccessLevel(AccessLevel: Integer);
begin
  self.AccessLevel := AccessLevel;
end;
procedure TPropertiesstoreEntity.setAccessOwner(AccessOwner: String);
begin
  self.AccessOwner := AccessOwner;
end;
procedure TPropertiesstoreEntity.setFormName(FormName: String);
begin
  self.FormName := FormName;
end;
procedure TPropertiesstoreEntity.setStoreType(StoreType: String);
begin
  self.StoreType := StoreType;
end;
procedure TPropertiesstoreEntity.setStoreName(StoreName: String);
begin
  self.StoreName := StoreName;
end;
procedure TPropertiesstoreEntity.setTextContainer1(TextContainer1: String);
begin
  self.TextContainer1 := TextContainer1;
end;
procedure TPropertiesstoreEntity.setTextContainer2(TextContainer2: String);
begin
  self.TextContainer2 := TextContainer2;
end;
procedure TPropertiesstoreEntity.setStringContainer1(StringContainer1: String);
begin
  self.StringContainer1 := StringContainer1;
end;
procedure TPropertiesstoreEntity.setStringContainer2(StringContainer2: String);
begin
  self.StringContainer2 := StringContainer2;
end;
procedure TPropertiesstoreEntity.setStringContainer3(StringContainer3: String);
begin
  self.StringContainer3 := StringContainer3;
end;
procedure TPropertiesstoreEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TPropertiesstoreEntity.setIsDefault(isDefault: Byte);
begin
  self.isDefault := isDefault;
end;
procedure TPropertiesstoreEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRatesEntity **************************************************

procedure TRatesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TRatesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TRatesEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TRatesEntity.setRate1Person(Rate1Person: Double);
begin
  self.Rate1Person := Rate1Person;
end;
procedure TRatesEntity.setRate2Persons(Rate2Persons: Double);
begin
  self.Rate2Persons := Rate2Persons;
end;
procedure TRatesEntity.setRate3Persons(Rate3Persons: Double);
begin
  self.Rate3Persons := Rate3Persons;
end;
procedure TRatesEntity.setRate4Persons(Rate4Persons: Double);
begin
  self.Rate4Persons := Rate4Persons;
end;
procedure TRatesEntity.setRate5Persons(Rate5Persons: Double);
begin
  self.Rate5Persons := Rate5Persons;
end;
procedure TRatesEntity.setRate6Persons(Rate6Persons: Double);
begin
  self.Rate6Persons := Rate6Persons;
end;
procedure TRatesEntity.setRateExtraPerson(RateExtraPerson: Double);
begin
  self.RateExtraPerson := RateExtraPerson;
end;
procedure TRatesEntity.setRateExtraChildren(RateExtraChildren: Double);
begin
  self.RateExtraChildren := RateExtraChildren;
end;
procedure TRatesEntity.setRateExtraInfant(RateExtraInfant: Double);
begin
  self.RateExtraInfant := RateExtraInfant;
end;
procedure TRatesEntity.setDateCreated(DateCreated: TTimeStamp);
begin
  self.DateCreated := DateCreated;
end;
procedure TRatesEntity.setLastModified(LastModified: TTimeStamp);
begin
  self.LastModified := LastModified;
end;
procedure TRatesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TRatesEntity.setIsDefault(isDefault: Byte);
begin
  self.isDefault := isDefault;
end;
procedure TRatesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TReservationsEntity **************************************************

procedure TReservationsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TReservationsEntity.setArrival(Arrival: String);
begin
  self.Arrival := Arrival;
end;
procedure TReservationsEntity.setDeparture(Departure: String);
begin
  self.Departure := Departure;
end;
procedure TReservationsEntity.setCustomer(Customer: String);
begin
  self.Customer := Customer;
end;
procedure TReservationsEntity.setName(Name: String);
begin
  self.Name := Name;
end;
procedure TReservationsEntity.setAddress1(Address1: String);
begin
  self.Address1 := Address1;
end;
procedure TReservationsEntity.setAddress2(Address2: String);
begin
  self.Address2 := Address2;
end;
procedure TReservationsEntity.setAddress3(Address3: String);
begin
  self.Address3 := Address3;
end;
procedure TReservationsEntity.setAddress4(Address4: String);
begin
  self.Address4 := Address4;
end;
procedure TReservationsEntity.setCountry(Country: String);
begin
  self.Country := Country;
end;
procedure TReservationsEntity.setTel1(Tel1: String);
begin
  self.Tel1 := Tel1;
end;
procedure TReservationsEntity.setTel2(Tel2: String);
begin
  self.Tel2 := Tel2;
end;
procedure TReservationsEntity.setFax(Fax: String);
begin
  self.Fax := Fax;
end;
procedure TReservationsEntity.setStatus(Status: String);
begin
  self.Status := Status;
end;
procedure TReservationsEntity.setReservationDate(ReservationDate: String);
begin
  self.ReservationDate := ReservationDate;
end;
procedure TReservationsEntity.setStaff(Staff: String);
begin
  self.Staff := Staff;
end;
procedure TReservationsEntity.setInformation(Information: String);
begin
  self.Information := Information;
end;
procedure TReservationsEntity.setPMInfo(PMInfo: String);
begin
  self.PMInfo := PMInfo;
end;
procedure TReservationsEntity.setHiddenInfo(HiddenInfo: String);
begin
  self.HiddenInfo := HiddenInfo;
end;
procedure TReservationsEntity.setRoomRentPaid1(RoomRentPaid1: Double);
begin
  self.RoomRentPaid1 := RoomRentPaid1;
end;
procedure TReservationsEntity.setRoomRentPaid2(RoomRentPaid2: Double);
begin
  self.RoomRentPaid2 := RoomRentPaid2;
end;
procedure TReservationsEntity.setRoomRentPaid3(RoomRentPaid3: Double);
begin
  self.RoomRentPaid3 := RoomRentPaid3;
end;
procedure TReservationsEntity.setRoomRentPaymentInvoice(RoomRentPaymentInvoice: Integer);
begin
  self.RoomRentPaymentInvoice := RoomRentPaymentInvoice;
end;
procedure TReservationsEntity.setContactName(ContactName: String);
begin
  self.ContactName := ContactName;
end;
procedure TReservationsEntity.setContactPhone(ContactPhone: String);
begin
  self.ContactPhone := ContactPhone;
end;
procedure TReservationsEntity.setContactPhone2(ContactPhone2: String);
begin
  self.ContactPhone2 := ContactPhone2;
end;
procedure TReservationsEntity.setContactFax(ContactFax: String);
begin
  self.ContactFax := ContactFax;
end;
procedure TReservationsEntity.setContactAddress1(ContactAddress1: String);
begin
  self.ContactAddress1 := ContactAddress1;
end;
procedure TReservationsEntity.setContactAddress2(ContactAddress2: String);
begin
  self.ContactAddress2 := ContactAddress2;
end;
procedure TReservationsEntity.setContactAddress3(ContactAddress3: String);
begin
  self.ContactAddress3 := ContactAddress3;
end;
procedure TReservationsEntity.setContactAddress4(ContactAddress4: String);
begin
  self.ContactAddress4 := ContactAddress4;
end;
procedure TReservationsEntity.setContactCountry(ContactCountry: String);
begin
  self.ContactCountry := ContactCountry;
end;
procedure TReservationsEntity.setContactEmail(ContactEmail: String);
begin
  self.ContactEmail := ContactEmail;
end;
procedure TReservationsEntity.setInputsource(inputsource: String);
begin
  self.inputsource := inputsource;
end;
procedure TReservationsEntity.setWebconfirmed(webconfirmed: String);
begin
  self.webconfirmed := webconfirmed;
end;
procedure TReservationsEntity.setArrivaltime(arrivaltime: String);
begin
  self.arrivaltime := arrivaltime;
end;
procedure TReservationsEntity.setSrcrequest(srcrequest: String);
begin
  self.srcrequest := srcrequest;
end;
procedure TReservationsEntity.setRvTmp(rvTmp: String);
begin
  self.rvTmp := rvTmp;
end;
procedure TReservationsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TReservationsEntity.setCustPID(CustPID: String);
begin
  self.CustPID := CustPID;
end;
procedure TReservationsEntity.setInvRefrence(invRefrence: String);
begin
  self.invRefrence := invRefrence;
end;
procedure TReservationsEntity.setMarketSegment(marketSegment: String);
begin
  self.marketSegment := marketSegment;
end;
procedure TReservationsEntity.setCustomerEmail(CustomerEmail: String);
begin
  self.CustomerEmail := CustomerEmail;
end;
procedure TReservationsEntity.setCustomerWebsite(CustomerWebsite: String);
begin
  self.CustomerWebsite := CustomerWebsite;
end;
procedure TReservationsEntity.setUseStayTax(useStayTax: Byte);
begin
  self.useStayTax := useStayTax;
end;
procedure TReservationsEntity.setChannel(channel: Integer);
begin
  self.channel := channel;
end;
procedure TReservationsEntity.setEventsProcessed(eventsProcessed: Byte);
begin
  self.eventsProcessed := eventsProcessed;
end;
procedure TReservationsEntity.setAlteredReservation(alteredReservation: Byte);
begin
  self.alteredReservation := alteredReservation;
end;
procedure TReservationsEntity.setExternalIds(externalIds: String);
begin
  self.externalIds := externalIds;
end;
procedure TReservationsEntity.setDtCreated(dtCreated: TTimeStamp);
begin
  self.dtCreated := dtCreated;
end;
procedure TReservationsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomamenitiesEntity **************************************************

procedure TRoomamenitiesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TRoomamenitiesEntity.setCode(code: String);
begin
  self.code := code;
end;
procedure TRoomamenitiesEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TRoomamenitiesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomermessagesEntity **************************************************

procedure TRoomermessagesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TRoomermessagesEntity.setCreated(Created: TTimeStamp);
begin
  self.Created := Created;
end;
procedure TRoomermessagesEntity.setOriginalId(OriginalId: Integer);
begin
  self.OriginalId := OriginalId;
end;
procedure TRoomermessagesEntity.setSenderId(SenderId: Integer);
begin
  self.SenderId := SenderId;
end;
procedure TRoomermessagesEntity.setRecipientId(RecipientId: Integer);
begin
  self.RecipientId := RecipientId;
end;
procedure TRoomermessagesEntity.setRead(Read: Integer);
begin
  self.Read := Read;
end;
procedure TRoomermessagesEntity.setSubject(Subject: String);
begin
  self.Subject := Subject;
end;
procedure TRoomermessagesEntity.setMessageText(MessageText: String);
begin
  self.MessageText := MessageText;
end;
procedure TRoomermessagesEntity.setMessageFormat(MessageFormat: Integer);
begin
  self.MessageFormat := MessageFormat;
end;
procedure TRoomermessagesEntity.setAttachedFiles(AttachedFiles: String);
begin
  self.AttachedFiles := AttachedFiles;
end;
procedure TRoomermessagesEntity.setExtraData(ExtraData: String);
begin
  self.ExtraData := ExtraData;
end;
procedure TRoomermessagesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomratesEntity **************************************************

procedure TRoomratesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TRoomratesEntity.setPriceCodeID(PriceCodeID: Integer);
begin
  self.PriceCodeID := PriceCodeID;
end;
procedure TRoomratesEntity.setRateID(RateID: Integer);
begin
  self.RateID := RateID;
end;
procedure TRoomratesEntity.setSeasonID(SeasonID: Integer);
begin
  self.SeasonID := SeasonID;
end;
procedure TRoomratesEntity.setRoomTypeID(RoomTypeID: Integer);
begin
  self.RoomTypeID := RoomTypeID;
end;
procedure TRoomratesEntity.setCurrencyID(CurrencyID: Integer);
begin
  self.CurrencyID := CurrencyID;
end;
procedure TRoomratesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TRoomratesEntity.setDateFrom(DateFrom: TTimeStamp);
begin
  self.DateFrom := DateFrom;
end;
procedure TRoomratesEntity.setDateTo(DateTo: TTimeStamp);
begin
  self.DateTo := DateTo;
end;
procedure TRoomratesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TRoomratesEntity.setDateCreated(DateCreated: TTimeStamp);
begin
  self.DateCreated := DateCreated;
end;
procedure TRoomratesEntity.setLastModified(LastModified: TTimeStamp);
begin
  self.LastModified := LastModified;
end;
procedure TRoomratesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomreservationsEntity **************************************************

procedure TRoomreservationsEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TRoomreservationsEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TRoomreservationsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TRoomreservationsEntity.setStatus(Status: String);
begin
  self.Status := Status;
end;
procedure TRoomreservationsEntity.setGroupAccount(GroupAccount: Byte);
begin
  self.GroupAccount := GroupAccount;
end;
procedure TRoomreservationsEntity.setInvBreakfast(invBreakfast: Byte);
begin
  self.invBreakfast := invBreakfast;
end;
procedure TRoomreservationsEntity.setRoomPrice1(RoomPrice1: Double);
begin
  self.RoomPrice1 := RoomPrice1;
end;
procedure TRoomreservationsEntity.setPrice1From(Price1From: String);
begin
  self.Price1From := Price1From;
end;
procedure TRoomreservationsEntity.setPrice1To(Price1To: String);
begin
  self.Price1To := Price1To;
end;
procedure TRoomreservationsEntity.setRoomPrice2(RoomPrice2: Double);
begin
  self.RoomPrice2 := RoomPrice2;
end;
procedure TRoomreservationsEntity.setPrice2From(Price2From: String);
begin
  self.Price2From := Price2From;
end;
procedure TRoomreservationsEntity.setPrice2To(Price2To: String);
begin
  self.Price2To := Price2To;
end;
procedure TRoomreservationsEntity.setRoomPrice3(RoomPrice3: Double);
begin
  self.RoomPrice3 := RoomPrice3;
end;
procedure TRoomreservationsEntity.setPrice3From(Price3From: String);
begin
  self.Price3From := Price3From;
end;
procedure TRoomreservationsEntity.setPrice3To(Price3To: String);
begin
  self.Price3To := Price3To;
end;
procedure TRoomreservationsEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TRoomreservationsEntity.setDiscount(Discount: Double);
begin
  self.Discount := Discount;
end;
procedure TRoomreservationsEntity.setPercentage(Percentage: Byte);
begin
  self.Percentage := Percentage;
end;
procedure TRoomreservationsEntity.setPriceType(PriceType: String);
begin
  self.PriceType := PriceType;
end;
procedure TRoomreservationsEntity.setArrival(Arrival: String);
begin
  self.Arrival := Arrival;
end;
procedure TRoomreservationsEntity.setDeparture(Departure: String);
begin
  self.Departure := Departure;
end;
procedure TRoomreservationsEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TRoomreservationsEntity.setPMInfo(PMInfo: String);
begin
  self.PMInfo := PMInfo;
end;
procedure TRoomreservationsEntity.setHiddenInfo(HiddenInfo: String);
begin
  self.HiddenInfo := HiddenInfo;
end;
procedure TRoomreservationsEntity.setRoomRentPaid1(RoomRentPaid1: Double);
begin
  self.RoomRentPaid1 := RoomRentPaid1;
end;
procedure TRoomreservationsEntity.setRoomRentPaid2(RoomRentPaid2: Double);
begin
  self.RoomRentPaid2 := RoomRentPaid2;
end;
procedure TRoomreservationsEntity.setRoomRentPaid3(RoomRentPaid3: Double);
begin
  self.RoomRentPaid3 := RoomRentPaid3;
end;
procedure TRoomreservationsEntity.setRoomRentPaymentInvoice(RoomRentPaymentInvoice: Integer);
begin
  self.RoomRentPaymentInvoice := RoomRentPaymentInvoice;
end;
procedure TRoomreservationsEntity.setHallres(Hallres: Integer);
begin
  self.Hallres := Hallres;
end;
procedure TRoomreservationsEntity.setRrTmp(rrTmp: String);
begin
  self.rrTmp := rrTmp;
end;
procedure TRoomreservationsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TRoomreservationsEntity.setRrDescription(rrDescription: String);
begin
  self.rrDescription := rrDescription;
end;
procedure TRoomreservationsEntity.setRrIsNoRoom(rrIsNoRoom: Byte);
begin
  self.rrIsNoRoom := rrIsNoRoom;
end;
procedure TRoomreservationsEntity.setRrDeparture(rrDeparture: TTimeStamp);
begin
  self.rrDeparture := rrDeparture;
end;
procedure TRoomreservationsEntity.setRrArrival(rrArrival: TTimeStamp);
begin
  self.rrArrival := rrArrival;
end;
procedure TRoomreservationsEntity.setRrRoomTypeAlias(rrRoomTypeAlias: String);
begin
  self.rrRoomTypeAlias := rrRoomTypeAlias;
end;
procedure TRoomreservationsEntity.setRrRoomAlias(rrRoomAlias: String);
begin
  self.rrRoomAlias := rrRoomAlias;
end;
procedure TRoomreservationsEntity.setUseStayTax(useStayTax: Byte);
begin
  self.useStayTax := useStayTax;
end;
procedure TRoomreservationsEntity.setUseinNationalReport(useinNationalReport: Byte);
begin
  self.useinNationalReport := useinNationalReport;
end;
procedure TRoomreservationsEntity.setNumGuests(numGuests: Integer);
begin
  self.numGuests := numGuests;
end;
procedure TRoomreservationsEntity.setNumChildren(numChildren: Integer);
begin
  self.numChildren := numChildren;
end;
procedure TRoomreservationsEntity.setNumInfants(numInfants: Integer);
begin
  self.numInfants := numInfants;
end;
procedure TRoomreservationsEntity.setAvrageRate(AvrageRate: String);
begin
  self.AvrageRate := AvrageRate;
end;
procedure TRoomreservationsEntity.setRateCount(RateCount: Integer);
begin
  self.RateCount := RateCount;
end;
procedure TRoomreservationsEntity.setDtCreated(dtCreated: TTimeStamp);
begin
  self.dtCreated := dtCreated;
end;
procedure TRoomreservationsEntity.setRoomClass(RoomClass: String);
begin
  self.RoomClass := RoomClass;
end;
procedure TRoomreservationsEntity.setColorId(colorId: Integer);
begin
  self.colorId := colorId;
end;
procedure TRoomreservationsEntity.setRatePlanCode(ratePlanCode: String);
begin
  self.ratePlanCode := ratePlanCode;
end;
procedure TRoomreservationsEntity.setPercentageDeposit(percentageDeposit: Double);
begin
  self.percentageDeposit := percentageDeposit;
end;
procedure TRoomreservationsEntity.setFixedDeposit(fixedDeposit: Double);
begin
  self.fixedDeposit := fixedDeposit;
end;
procedure TRoomreservationsEntity.setDepositsInfo(depositsInfo: String);
begin
  self.depositsInfo := depositsInfo;
end;
procedure TRoomreservationsEntity.setPenaltiesInfo(penaltiesInfo: String);
begin
  self.penaltiesInfo := penaltiesInfo;
end;
procedure TRoomreservationsEntity.setCheckoutEventProcessed(checkoutEventProcessed: Byte);
begin
  self.checkoutEventProcessed := checkoutEventProcessed;
end;
procedure TRoomreservationsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomroomamenitiesEntity **************************************************

procedure TRoomroomamenitiesEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TRoomroomamenitiesEntity.setRoomId(roomId: Integer);
begin
  self.roomId := roomId;
end;
procedure TRoomroomamenitiesEntity.setRoomamenity(roomamenity: Integer);
begin
  self.roomamenity := roomamenity;
end;
procedure TRoomroomamenitiesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomsEntity **************************************************

procedure TRoomsEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TRoomsEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TRoomsEntity.setDetailedDescription(DetailedDescription: String);
begin
  self.DetailedDescription := DetailedDescription;
end;
procedure TRoomsEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TRoomsEntity.setWildcard(wildcard: Byte);
begin
  self.wildcard := wildcard;
end;
procedure TRoomsEntity.setBath(Bath: Byte);
begin
  self.Bath := Bath;
end;
procedure TRoomsEntity.setShower(Shower: Byte);
begin
  self.Shower := Shower;
end;
procedure TRoomsEntity.setSafe(Safe: Byte);
begin
  self.Safe := Safe;
end;
procedure TRoomsEntity.setTV(TV: Byte);
begin
  self.TV := TV;
end;
procedure TRoomsEntity.setVideo(Video: Byte);
begin
  self.Video := Video;
end;
procedure TRoomsEntity.setRadio(Radio: Byte);
begin
  self.Radio := Radio;
end;
procedure TRoomsEntity.setCDPlayer(CDPlayer: Byte);
begin
  self.CDPlayer := CDPlayer;
end;
procedure TRoomsEntity.setTelephone(Telephone: Byte);
begin
  self.Telephone := Telephone;
end;
procedure TRoomsEntity.setPress(Press: Byte);
begin
  self.Press := Press;
end;
procedure TRoomsEntity.setCoffee(Coffee: Byte);
begin
  self.Coffee := Coffee;
end;
procedure TRoomsEntity.setKitchen(Kitchen: Byte);
begin
  self.Kitchen := Kitchen;
end;
procedure TRoomsEntity.setMinibar(Minibar: Byte);
begin
  self.Minibar := Minibar;
end;
procedure TRoomsEntity.setFridge(Fridge: Byte);
begin
  self.Fridge := Fridge;
end;
procedure TRoomsEntity.setHairdryer(Hairdryer: Byte);
begin
  self.Hairdryer := Hairdryer;
end;
procedure TRoomsEntity.setInternetPlug(InternetPlug: Byte);
begin
  self.InternetPlug := InternetPlug;
end;
procedure TRoomsEntity.setFax(Fax: Byte);
begin
  self.Fax := Fax;
end;
procedure TRoomsEntity.setSqrMeters(SqrMeters: Double);
begin
  self.SqrMeters := SqrMeters;
end;
procedure TRoomsEntity.setBedSize(BedSize: String);
begin
  self.BedSize := BedSize;
end;
procedure TRoomsEntity.setEquipments(Equipments: String);
begin
  self.Equipments := Equipments;
end;
procedure TRoomsEntity.setBookable(Bookable: Byte);
begin
  self.Bookable := Bookable;
end;
procedure TRoomsEntity.setStatistics(Statistics: Byte);
begin
  self.Statistics := Statistics;
end;
procedure TRoomsEntity.setStatus(Status: String);
begin
  self.Status := Status;
end;
procedure TRoomsEntity.setOrderIndex(OrderIndex: Integer);
begin
  self.OrderIndex := OrderIndex;
end;
procedure TRoomsEntity.setHidden(hidden: Byte);
begin
  self.hidden := hidden;
end;
procedure TRoomsEntity.setLocation(Location: String);
begin
  self.Location := Location;
end;
procedure TRoomsEntity.setFloor(Floor: Integer);
begin
  self.Floor := Floor;
end;
procedure TRoomsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TRoomsEntity.setDorm(Dorm: String);
begin
  self.Dorm := Dorm;
end;
procedure TRoomsEntity.setUseInNationalReport(useInNationalReport: Byte);
begin
  self.useInNationalReport := useInNationalReport;
end;
procedure TRoomsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TRoomsEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TRoomsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomsdateEntity **************************************************

procedure TRoomsdateEntity.setADate(ADate: String);
begin
  self.ADate := ADate;
end;
procedure TRoomsdateEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TRoomsdateEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TRoomsdateEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TRoomsdateEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TRoomsdateEntity.setResFlag(ResFlag: String);
begin
  self.ResFlag := ResFlag;
end;
procedure TRoomsdateEntity.setRdTmp(rdTmp: String);
begin
  self.rdTmp := rdTmp;
end;
procedure TRoomsdateEntity.setUpdated(updated: Byte);
begin
  self.updated := updated;
end;
procedure TRoomsdateEntity.setIsNoRoom(isNoRoom: Byte);
begin
  self.isNoRoom := isNoRoom;
end;
procedure TRoomsdateEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TRoomsdateEntity.setRoomRentBilled(RoomRentBilled: Double);
begin
  self.RoomRentBilled := RoomRentBilled;
end;
procedure TRoomsdateEntity.setRoomRentUnBilled(RoomRentUnBilled: Double);
begin
  self.RoomRentUnBilled := RoomRentUnBilled;
end;
procedure TRoomsdateEntity.setRoomDiscountBilled(RoomDiscountBilled: Double);
begin
  self.RoomDiscountBilled := RoomDiscountBilled;
end;
procedure TRoomsdateEntity.setRoomDiscountUnBilled(RoomDiscountUnBilled: Double);
begin
  self.RoomDiscountUnBilled := RoomDiscountUnBilled;
end;
procedure TRoomsdateEntity.setItemsBilled(ItemsBilled: Double);
begin
  self.ItemsBilled := ItemsBilled;
end;
procedure TRoomsdateEntity.setItemsUnbilled(ItemsUnbilled: Double);
begin
  self.ItemsUnbilled := ItemsUnbilled;
end;
procedure TRoomsdateEntity.setTaxesBilled(TaxesBilled: Double);
begin
  self.TaxesBilled := TaxesBilled;
end;
procedure TRoomsdateEntity.setTaxesUnbilled(TaxesUnbilled: Double);
begin
  self.TaxesUnbilled := TaxesUnbilled;
end;
procedure TRoomsdateEntity.setPriceCode(PriceCode: String);
begin
  self.PriceCode := PriceCode;
end;
procedure TRoomsdateEntity.setRoomRate(RoomRate: Double);
begin
  self.RoomRate := RoomRate;
end;
procedure TRoomsdateEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TRoomsdateEntity.setDiscount(Discount: Double);
begin
  self.Discount := Discount;
end;
procedure TRoomsdateEntity.setIsPercentage(isPercentage: Byte);
begin
  self.isPercentage := isPercentage;
end;
procedure TRoomsdateEntity.setShowDiscount(showDiscount: Byte);
begin
  self.showDiscount := showDiscount;
end;
procedure TRoomsdateEntity.setPaid(Paid: Byte);
begin
  self.Paid := Paid;
end;
procedure TRoomsdateEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomsdatetempEntity **************************************************

procedure TRoomsdatetempEntity.setADate(ADate: String);
begin
  self.ADate := ADate;
end;
procedure TRoomsdatetempEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TRoomsdatetempEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TRoomsdatetempEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TRoomsdatetempEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TRoomsdatetempEntity.setResFlag(resFlag: String);
begin
  self.resFlag := resFlag;
end;
procedure TRoomsdatetempEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TRoomsdatetempEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomtypegroupsEntity **************************************************

procedure TRoomtypegroupsEntity.setCode(Code: String);
begin
  self.Code := Code;
end;
procedure TRoomtypegroupsEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TRoomtypegroupsEntity.setDetailedDescription(DetailedDescription: String);
begin
  self.DetailedDescription := DetailedDescription;
end;
procedure TRoomtypegroupsEntity.setPriorityRule(PriorityRule: String);
begin
  self.PriorityRule := PriorityRule;
end;
procedure TRoomtypegroupsEntity.setNumGuests(numGuests: Integer);
begin
  self.numGuests := numGuests;
end;
procedure TRoomtypegroupsEntity.setMaxCount(MaxCount: Integer);
begin
  self.MaxCount := MaxCount;
end;
procedure TRoomtypegroupsEntity.setMinGuests(minGuests: Integer);
begin
  self.minGuests := minGuests;
end;
procedure TRoomtypegroupsEntity.setMaxGuests(maxGuests: Integer);
begin
  self.maxGuests := maxGuests;
end;
procedure TRoomtypegroupsEntity.setMaxChildren(maxChildren: Integer);
begin
  self.maxChildren := maxChildren;
end;
procedure TRoomtypegroupsEntity.setColor(color: String);
begin
  self.color := color;
end;
procedure TRoomtypegroupsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TRoomtypegroupsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TRoomtypegroupsEntity.setDetailedDescriptionHtml(DetailedDescriptionHtml: String);
begin
  self.DetailedDescriptionHtml := DetailedDescriptionHtml;
end;
procedure TRoomtypegroupsEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TRoomtypegroupsEntity.setTopClass(TopClass: String);
begin
  self.TopClass := TopClass;
end;
procedure TRoomtypegroupsEntity.setAvailabilityTypes(AvailabilityTypes: String);
begin
  self.AvailabilityTypes := AvailabilityTypes;
end;
procedure TRoomtypegroupsEntity.setDefRate(defRate: String);
begin
  self.defRate := defRate;
end;
procedure TRoomtypegroupsEntity.setDefAvailability(defAvailability: Integer);
begin
  self.defAvailability := defAvailability;
end;
procedure TRoomtypegroupsEntity.setDefStopSale(defStopSale: Byte);
begin
  self.defStopSale := defStopSale;
end;
procedure TRoomtypegroupsEntity.setDefMinStay(defMinStay: Integer);
begin
  self.defMinStay := defMinStay;
end;
procedure TRoomtypegroupsEntity.setDefMaxAvailability(defMaxAvailability: Integer);
begin
  self.defMaxAvailability := defMaxAvailability;
end;
procedure TRoomtypegroupsEntity.setNonRefundable(NonRefundable: Byte);
begin
  self.NonRefundable := NonRefundable;
end;
procedure TRoomtypegroupsEntity.setAutoChargeCreditcards(AutoChargeCreditcards: Byte);
begin
  self.AutoChargeCreditcards := AutoChargeCreditcards;
end;
procedure TRoomtypegroupsEntity.setRateExtraBed(RateExtraBed: String);
begin
  self.RateExtraBed := RateExtraBed;
end;
procedure TRoomtypegroupsEntity.setPhotoUri(PhotoUri: String);
begin
  self.PhotoUri := PhotoUri;
end;
procedure TRoomtypegroupsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomtyperulesEntity **************************************************

procedure TRoomtyperulesEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TRoomtyperulesEntity.setRuleString(RuleString: String);
begin
  self.RuleString := RuleString;
end;
procedure TRoomtyperulesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TRoomtyperulesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TRoomtyperulesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TRoomtyperulesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TRoomtypesEntity **************************************************

procedure TRoomtypesEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TRoomtypesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TRoomtypesEntity.setDetailedDescription(DetailedDescription: String);
begin
  self.DetailedDescription := DetailedDescription;
end;
procedure TRoomtypesEntity.setNumberGuests(NumberGuests: Integer);
begin
  self.NumberGuests := NumberGuests;
end;
procedure TRoomtypesEntity.setPriceType(PriceType: String);
begin
  self.PriceType := PriceType;
end;
procedure TRoomtypesEntity.setWebable(Webable: Byte);
begin
  self.Webable := Webable;
end;
procedure TRoomtypesEntity.setRoomTypeGroup(RoomTypeGroup: String);
begin
  self.RoomTypeGroup := RoomTypeGroup;
end;
procedure TRoomtypesEntity.setColor(color: String);
begin
  self.color := color;
end;
procedure TRoomtypesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TRoomtypesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TRoomtypesEntity.setPriorityRule(PriorityRule: String);
begin
  self.PriorityRule := PriorityRule;
end;
procedure TRoomtypesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TRoomtypesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TStaffmembersEntity **************************************************

procedure TStaffmembersEntity.setInitials(Initials: String);
begin
  self.Initials := Initials;
end;
procedure TStaffmembersEntity.setPassword(Password: String);
begin
  self.Password := Password;
end;
procedure TStaffmembersEntity.setName(Name: String);
begin
  self.Name := Name;
end;
procedure TStaffmembersEntity.setAddress1(Address1: String);
begin
  self.Address1 := Address1;
end;
procedure TStaffmembersEntity.setAddress2(Address2: String);
begin
  self.Address2 := Address2;
end;
procedure TStaffmembersEntity.setAddress3(Address3: String);
begin
  self.Address3 := Address3;
end;
procedure TStaffmembersEntity.setAddress4(Address4: String);
begin
  self.Address4 := Address4;
end;
procedure TStaffmembersEntity.setCountry(Country: String);
begin
  self.Country := Country;
end;
procedure TStaffmembersEntity.setTel1(Tel1: String);
begin
  self.Tel1 := Tel1;
end;
procedure TStaffmembersEntity.setTel2(Tel2: String);
begin
  self.Tel2 := Tel2;
end;
procedure TStaffmembersEntity.setFax(Fax: String);
begin
  self.Fax := Fax;
end;
procedure TStaffmembersEntity.setActiveMember(ActiveMember: Byte);
begin
  self.ActiveMember := ActiveMember;
end;
procedure TStaffmembersEntity.setStaffType(StaffType: String);
begin
  self.StaffType := StaffType;
end;
procedure TStaffmembersEntity.setStaffLanguage(StaffLanguage: Integer);
begin
  self.StaffLanguage := StaffLanguage;
end;
procedure TStaffmembersEntity.setStaffPID(StaffPID: String);
begin
  self.StaffPID := StaffPID;
end;
procedure TStaffmembersEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TStaffmembersEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TStaffmembersEntity.setStaffType1(StaffType1: String);
begin
  self.StaffType1 := StaffType1;
end;
procedure TStaffmembersEntity.setStaffType2(StaffType2: String);
begin
  self.StaffType2 := StaffType2;
end;
procedure TStaffmembersEntity.setStaffType3(StaffType3: String);
begin
  self.StaffType3 := StaffType3;
end;
procedure TStaffmembersEntity.setStaffType4(StaffType4: String);
begin
  self.StaffType4 := StaffType4;
end;
procedure TStaffmembersEntity.setWindowsAuth(WindowsAuth: Byte);
begin
  self.WindowsAuth := WindowsAuth;
end;
procedure TStaffmembersEntity.setPmsOnly(PmsOnly: Byte);
begin
  self.PmsOnly := PmsOnly;
end;
procedure TStaffmembersEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TStaffmembersEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TStafftypesEntity **************************************************

procedure TStafftypesEntity.setStaffType(StaffType: String);
begin
  self.StaffType := StaffType;
end;
procedure TStafftypesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TStafftypesEntity.setAccessPrivilidges(AccessPrivilidges: Integer);
begin
  self.AccessPrivilidges := AccessPrivilidges;
end;
procedure TStafftypesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TStafftypesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TStafftypesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TSystemactionsEntity **************************************************

procedure TSystemactionsEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TSystemactionsEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TSystemactionsEntity.setType(_type: Integer);
begin
  self._type := _type;
end;
procedure TSystemactionsEntity.setActive(active: Byte);
begin
  self.active := active;
end;
procedure TSystemactionsEntity.setSystemserver(systemserver: Integer);
begin
  self.systemserver := systemserver;
end;
procedure TSystemactionsEntity.setRecipient(recipient: String);
begin
  self.recipient := recipient;
end;
procedure TSystemactionsEntity.setSender(sender: String);
begin
  self.sender := sender;
end;
procedure TSystemactionsEntity.setSubject(subject: String);
begin
  self.subject := subject;
end;
procedure TSystemactionsEntity.setContent(content: String);
begin
  self.content := content;
end;
procedure TSystemactionsEntity.setRichcontent(richcontent: Byte);
begin
  self.richcontent := richcontent;
end;
procedure TSystemactionsEntity.setContentfile(contentfile: String);
begin
  self.contentfile := contentfile;
end;
procedure TSystemactionsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TSystemserversEntity **************************************************

procedure TSystemserversEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TSystemserversEntity.setActive(active: Byte);
begin
  self.active := active;
end;
procedure TSystemserversEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TSystemserversEntity.setServer(server: String);
begin
  self.server := server;
end;
procedure TSystemserversEntity.setPort(port: Integer);
begin
  self.port := port;
end;
procedure TSystemserversEntity.setUsername(username: String);
begin
  self.username := username;
end;
procedure TSystemserversEntity.setPassword(password: String);
begin
  self.password := password;
end;
procedure TSystemserversEntity.setAuthenticate(authenticate: Byte);
begin
  self.authenticate := authenticate;
end;
procedure TSystemserversEntity.setSsl(ssl: Byte);
begin
  self.ssl := ssl;
end;
procedure TSystemserversEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TSystemtriggersEntity **************************************************

procedure TSystemtriggersEntity.setId(id: Integer);
begin
  self.id := id;
end;
procedure TSystemtriggersEntity.setType(_type: Integer);
begin
  self._type := _type;
end;
procedure TSystemtriggersEntity.setActive(active: Byte);
begin
  self.active := active;
end;
procedure TSystemtriggersEntity.setDescription(description: String);
begin
  self.description := description;
end;
procedure TSystemtriggersEntity.setSystemaction(systemaction: Integer);
begin
  self.systemaction := systemaction;
end;
procedure TSystemtriggersEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblconvertgroupsEntity **************************************************

procedure TTblconvertgroupsEntity.setCgCode(cgCode: String);
begin
  self.cgCode := cgCode;
end;
procedure TTblconvertgroupsEntity.setCgDescription(cgDescription: String);
begin
  self.cgDescription := cgDescription;
end;
procedure TTblconvertgroupsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblconvertgroupsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TTblconvertgroupsEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TTblconvertgroupsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblconvertsEntity **************************************************

procedure TTblconvertsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblconvertsEntity.setCvType(cvType: String);
begin
  self.cvType := cvType;
end;
procedure TTblconvertsEntity.setCvFrom(cvFrom: String);
begin
  self.cvFrom := cvFrom;
end;
procedure TTblconvertsEntity.setCvTo(cvTo: String);
begin
  self.cvTo := cvTo;
end;
procedure TTblconvertsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TTblconvertsEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TTblconvertsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTbldelpersonsEntity **************************************************

procedure TTbldelpersonsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTbldelpersonsEntity.setPerson(Person: Integer);
begin
  self.Person := Person;
end;
procedure TTbldelpersonsEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TTbldelpersonsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TTbldelpersonsEntity.setName(Name: String);
begin
  self.Name := Name;
end;
procedure TTbldelpersonsEntity.setSurname(Surname: String);
begin
  self.Surname := Surname;
end;
procedure TTbldelpersonsEntity.setAddress1(Address1: String);
begin
  self.Address1 := Address1;
end;
procedure TTbldelpersonsEntity.setAddress2(Address2: String);
begin
  self.Address2 := Address2;
end;
procedure TTbldelpersonsEntity.setAddress3(Address3: String);
begin
  self.Address3 := Address3;
end;
procedure TTbldelpersonsEntity.setAddress4(Address4: String);
begin
  self.Address4 := Address4;
end;
procedure TTbldelpersonsEntity.setCountry(Country: String);
begin
  self.Country := Country;
end;
procedure TTbldelpersonsEntity.setCompany(Company: String);
begin
  self.Company := Company;
end;
procedure TTbldelpersonsEntity.setGuestType(GuestType: String);
begin
  self.GuestType := GuestType;
end;
procedure TTbldelpersonsEntity.setInformation(Information: String);
begin
  self.Information := Information;
end;
procedure TTbldelpersonsEntity.setPID(PID: String);
begin
  self.PID := PID;
end;
procedure TTbldelpersonsEntity.setMainName(MainName: Byte);
begin
  self.MainName := MainName;
end;
procedure TTbldelpersonsEntity.setCustomer(Customer: String);
begin
  self.Customer := Customer;
end;
procedure TTbldelpersonsEntity.setPeTmp(peTmp: String);
begin
  self.peTmp := peTmp;
end;
procedure TTbldelpersonsEntity.setPeID(peID: Integer);
begin
  self.peID := peID;
end;
procedure TTbldelpersonsEntity.setHgrID(hgrID: Integer);
begin
  self.hgrID := hgrID;
end;
procedure TTbldelpersonsEntity.setHallReservation(HallReservation: Integer);
begin
  self.HallReservation := HallReservation;
end;
procedure TTbldelpersonsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTbldelreservationsEntity **************************************************

procedure TTbldelreservationsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTbldelreservationsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TTbldelreservationsEntity.setArrival(Arrival: String);
begin
  self.Arrival := Arrival;
end;
procedure TTbldelreservationsEntity.setDeparture(Departure: String);
begin
  self.Departure := Departure;
end;
procedure TTbldelreservationsEntity.setCustomer(Customer: String);
begin
  self.Customer := Customer;
end;
procedure TTbldelreservationsEntity.setName(Name: String);
begin
  self.Name := Name;
end;
procedure TTbldelreservationsEntity.setAddress1(Address1: String);
begin
  self.Address1 := Address1;
end;
procedure TTbldelreservationsEntity.setAddress2(Address2: String);
begin
  self.Address2 := Address2;
end;
procedure TTbldelreservationsEntity.setAddress3(Address3: String);
begin
  self.Address3 := Address3;
end;
procedure TTbldelreservationsEntity.setAddress4(Address4: String);
begin
  self.Address4 := Address4;
end;
procedure TTbldelreservationsEntity.setCountry(Country: String);
begin
  self.Country := Country;
end;
procedure TTbldelreservationsEntity.setTel1(Tel1: String);
begin
  self.Tel1 := Tel1;
end;
procedure TTbldelreservationsEntity.setTel2(Tel2: String);
begin
  self.Tel2 := Tel2;
end;
procedure TTbldelreservationsEntity.setFax(Fax: String);
begin
  self.Fax := Fax;
end;
procedure TTbldelreservationsEntity.setStatus(Status: String);
begin
  self.Status := Status;
end;
procedure TTbldelreservationsEntity.setReservationDate(ReservationDate: String);
begin
  self.ReservationDate := ReservationDate;
end;
procedure TTbldelreservationsEntity.setStaff(Staff: String);
begin
  self.Staff := Staff;
end;
procedure TTbldelreservationsEntity.setInformation(Information: String);
begin
  self.Information := Information;
end;
procedure TTbldelreservationsEntity.setPMInfo(PMInfo: String);
begin
  self.PMInfo := PMInfo;
end;
procedure TTbldelreservationsEntity.setHiddenInfo(HiddenInfo: String);
begin
  self.HiddenInfo := HiddenInfo;
end;
procedure TTbldelreservationsEntity.setRoomRentPaid1(RoomRentPaid1: Double);
begin
  self.RoomRentPaid1 := RoomRentPaid1;
end;
procedure TTbldelreservationsEntity.setRoomRentPaid2(RoomRentPaid2: Double);
begin
  self.RoomRentPaid2 := RoomRentPaid2;
end;
procedure TTbldelreservationsEntity.setRoomRentPaid3(RoomRentPaid3: Double);
begin
  self.RoomRentPaid3 := RoomRentPaid3;
end;
procedure TTbldelreservationsEntity.setRoomRentPaymentInvoice(RoomRentPaymentInvoice: Integer);
begin
  self.RoomRentPaymentInvoice := RoomRentPaymentInvoice;
end;
procedure TTbldelreservationsEntity.setContactName(ContactName: String);
begin
  self.ContactName := ContactName;
end;
procedure TTbldelreservationsEntity.setContactPhone(ContactPhone: String);
begin
  self.ContactPhone := ContactPhone;
end;
procedure TTbldelreservationsEntity.setContactFax(ContactFax: String);
begin
  self.ContactFax := ContactFax;
end;
procedure TTbldelreservationsEntity.setContactEmail(ContactEmail: String);
begin
  self.ContactEmail := ContactEmail;
end;
procedure TTbldelreservationsEntity.setInputsource(inputsource: String);
begin
  self.inputsource := inputsource;
end;
procedure TTbldelreservationsEntity.setWebconfirmed(webconfirmed: String);
begin
  self.webconfirmed := webconfirmed;
end;
procedure TTbldelreservationsEntity.setArrivaltime(arrivaltime: String);
begin
  self.arrivaltime := arrivaltime;
end;
procedure TTbldelreservationsEntity.setSrcrequest(srcrequest: String);
begin
  self.srcrequest := srcrequest;
end;
procedure TTbldelreservationsEntity.setRvTmp(rvTmp: String);
begin
  self.rvTmp := rvTmp;
end;
procedure TTbldelreservationsEntity.setRvID(rvID: Integer);
begin
  self.rvID := rvID;
end;
procedure TTbldelreservationsEntity.setCustPID(CustPID: String);
begin
  self.CustPID := CustPID;
end;
procedure TTbldelreservationsEntity.setInvRefrence(invRefrence: String);
begin
  self.invRefrence := invRefrence;
end;
procedure TTbldelreservationsEntity.setMarketSegment(marketSegment: String);
begin
  self.marketSegment := marketSegment;
end;
procedure TTbldelreservationsEntity.setCustomerEmail(CustomerEmail: String);
begin
  self.CustomerEmail := CustomerEmail;
end;
procedure TTbldelreservationsEntity.setCustomerWebsite(CustomerWebsite: String);
begin
  self.CustomerWebsite := CustomerWebsite;
end;
procedure TTbldelreservationsEntity.setUseStayTax(useStayTax: Byte);
begin
  self.useStayTax := useStayTax;
end;
procedure TTbldelreservationsEntity.setChannel(Channel: Integer);
begin
  self.Channel := Channel;
end;
procedure TTbldelreservationsEntity.setEventsProcessed(eventsProcessed: Byte);
begin
  self.eventsProcessed := eventsProcessed;
end;
procedure TTbldelreservationsEntity.setAlteredReservation(alteredReservation: Byte);
begin
  self.alteredReservation := alteredReservation;
end;
procedure TTbldelreservationsEntity.setExternalIds(externalIds: String);
begin
  self.externalIds := externalIds;
end;
procedure TTbldelreservationsEntity.setDtCreated(dtCreated: TTimeStamp);
begin
  self.dtCreated := dtCreated;
end;
procedure TTbldelreservationsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTbldelroomreservationsEntity **************************************************

procedure TTbldelroomreservationsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTbldelroomreservationsEntity.setRrID(rrID: Integer);
begin
  self.rrID := rrID;
end;
procedure TTbldelroomreservationsEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TTbldelroomreservationsEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TTbldelroomreservationsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TTbldelroomreservationsEntity.setStatus(Status: String);
begin
  self.Status := Status;
end;
procedure TTbldelroomreservationsEntity.setGroupAccount(GroupAccount: Byte);
begin
  self.GroupAccount := GroupAccount;
end;
procedure TTbldelroomreservationsEntity.setInvBreakfast(invBreakfast: Byte);
begin
  self.invBreakfast := invBreakfast;
end;
procedure TTbldelroomreservationsEntity.setRoomPrice1(RoomPrice1: Double);
begin
  self.RoomPrice1 := RoomPrice1;
end;
procedure TTbldelroomreservationsEntity.setPrice1From(Price1From: String);
begin
  self.Price1From := Price1From;
end;
procedure TTbldelroomreservationsEntity.setPrice1To(Price1To: String);
begin
  self.Price1To := Price1To;
end;
procedure TTbldelroomreservationsEntity.setRoomPrice2(RoomPrice2: Double);
begin
  self.RoomPrice2 := RoomPrice2;
end;
procedure TTbldelroomreservationsEntity.setPrice2From(Price2From: String);
begin
  self.Price2From := Price2From;
end;
procedure TTbldelroomreservationsEntity.setPrice2To(Price2To: String);
begin
  self.Price2To := Price2To;
end;
procedure TTbldelroomreservationsEntity.setRoomPrice3(RoomPrice3: Double);
begin
  self.RoomPrice3 := RoomPrice3;
end;
procedure TTbldelroomreservationsEntity.setPrice3From(Price3From: String);
begin
  self.Price3From := Price3From;
end;
procedure TTbldelroomreservationsEntity.setPrice3To(Price3To: String);
begin
  self.Price3To := Price3To;
end;
procedure TTbldelroomreservationsEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TTbldelroomreservationsEntity.setDiscount(Discount: Double);
begin
  self.Discount := Discount;
end;
procedure TTbldelroomreservationsEntity.setPercentage(Percentage: Byte);
begin
  self.Percentage := Percentage;
end;
procedure TTbldelroomreservationsEntity.setPriceType(PriceType: String);
begin
  self.PriceType := PriceType;
end;
procedure TTbldelroomreservationsEntity.setArrival(Arrival: String);
begin
  self.Arrival := Arrival;
end;
procedure TTbldelroomreservationsEntity.setDeparture(Departure: String);
begin
  self.Departure := Departure;
end;
procedure TTbldelroomreservationsEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TTbldelroomreservationsEntity.setPMInfo(PMInfo: String);
begin
  self.PMInfo := PMInfo;
end;
procedure TTbldelroomreservationsEntity.setHiddenInfo(HiddenInfo: String);
begin
  self.HiddenInfo := HiddenInfo;
end;
procedure TTbldelroomreservationsEntity.setRoomRentPaid1(RoomRentPaid1: Double);
begin
  self.RoomRentPaid1 := RoomRentPaid1;
end;
procedure TTbldelroomreservationsEntity.setRoomRentPaid2(RoomRentPaid2: Double);
begin
  self.RoomRentPaid2 := RoomRentPaid2;
end;
procedure TTbldelroomreservationsEntity.setRoomRentPaid3(RoomRentPaid3: Double);
begin
  self.RoomRentPaid3 := RoomRentPaid3;
end;
procedure TTbldelroomreservationsEntity.setRoomRentPaymentInvoice(RoomRentPaymentInvoice: Integer);
begin
  self.RoomRentPaymentInvoice := RoomRentPaymentInvoice;
end;
procedure TTbldelroomreservationsEntity.setHallres(Hallres: Integer);
begin
  self.Hallres := Hallres;
end;
procedure TTbldelroomreservationsEntity.setRrTmp(rrTmp: String);
begin
  self.rrTmp := rrTmp;
end;
procedure TTbldelroomreservationsEntity.setRrDescription(rrDescription: String);
begin
  self.rrDescription := rrDescription;
end;
procedure TTbldelroomreservationsEntity.setRrArrival(rrArrival: TTimeStamp);
begin
  self.rrArrival := rrArrival;
end;
procedure TTbldelroomreservationsEntity.setRrDeparture(rrDeparture: TTimeStamp);
begin
  self.rrDeparture := rrDeparture;
end;
procedure TTbldelroomreservationsEntity.setRrIsNoRoom(rrIsNoRoom: Byte);
begin
  self.rrIsNoRoom := rrIsNoRoom;
end;
procedure TTbldelroomreservationsEntity.setRrRoomAlias(rrRoomAlias: String);
begin
  self.rrRoomAlias := rrRoomAlias;
end;
procedure TTbldelroomreservationsEntity.setRrRoomTypeAlias(rrRoomTypeAlias: String);
begin
  self.rrRoomTypeAlias := rrRoomTypeAlias;
end;
procedure TTbldelroomreservationsEntity.setUseStayTax(useStayTax: Byte);
begin
  self.useStayTax := useStayTax;
end;
procedure TTbldelroomreservationsEntity.setCancelDate(CancelDate: TTimeStamp);
begin
  self.CancelDate := CancelDate;
end;
procedure TTbldelroomreservationsEntity.setCancelStaff(CancelStaff: String);
begin
  self.CancelStaff := CancelStaff;
end;
procedure TTbldelroomreservationsEntity.setCancelReason(CancelReason: String);
begin
  self.CancelReason := CancelReason;
end;
procedure TTbldelroomreservationsEntity.setCancelRequest(CancelRequest: String);
begin
  self.CancelRequest := CancelRequest;
end;
procedure TTbldelroomreservationsEntity.setCancelInformation(CancelInformation: String);
begin
  self.CancelInformation := CancelInformation;
end;
procedure TTbldelroomreservationsEntity.setCancelType(CancelType: Integer);
begin
  self.CancelType := CancelType;
end;
procedure TTbldelroomreservationsEntity.setUseInNationalReport(useInNationalReport: Byte);
begin
  self.useInNationalReport := useInNationalReport;
end;
procedure TTbldelroomreservationsEntity.setNumGuests(numGuests: Integer);
begin
  self.numGuests := numGuests;
end;
procedure TTbldelroomreservationsEntity.setNumChildren(numChildren: Integer);
begin
  self.numChildren := numChildren;
end;
procedure TTbldelroomreservationsEntity.setNumInfants(numInfants: Integer);
begin
  self.numInfants := numInfants;
end;
procedure TTbldelroomreservationsEntity.setAvrageRate(AvrageRate: String);
begin
  self.AvrageRate := AvrageRate;
end;
procedure TTbldelroomreservationsEntity.setRateCount(RateCount: Integer);
begin
  self.RateCount := RateCount;
end;
procedure TTbldelroomreservationsEntity.setDtCreated(dtCreated: TTimeStamp);
begin
  self.dtCreated := dtCreated;
end;
procedure TTbldelroomreservationsEntity.setRoomClass(RoomClass: String);
begin
  self.RoomClass := RoomClass;
end;
procedure TTbldelroomreservationsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblhiddeninfoEntity **************************************************

procedure TTblhiddeninfoEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblhiddeninfoEntity.setNotes(Notes: String);
begin
  self.Notes := Notes;
end;
procedure TTblhiddeninfoEntity.setDeleteOn(DeleteOn: TTimeStamp);
begin
  self.DeleteOn := DeleteOn;
end;
procedure TTblhiddeninfoEntity.setViewLog(ViewLog: String);
begin
  self.ViewLog := ViewLog;
end;
procedure TTblhiddeninfoEntity.setRefrence(Refrence: Integer);
begin
  self.Refrence := Refrence;
end;
procedure TTblhiddeninfoEntity.setRefrenceType(RefrenceType: Integer);
begin
  self.RefrenceType := RefrenceType;
end;
procedure TTblhiddeninfoEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblimportlogsEntity **************************************************

procedure TTblimportlogsEntity.setId(Id: Integer);
begin
  self.Id := Id;
end;
procedure TTblimportlogsEntity.setDateInsert(DateInsert: TTimeStamp);
begin
  self.DateInsert := DateInsert;
end;
procedure TTblimportlogsEntity.setDateExport(DateExport: TTimeStamp);
begin
  self.DateExport := DateExport;
end;
procedure TTblimportlogsEntity.setImportTypeID(ImportTypeID: Integer);
begin
  self.ImportTypeID := ImportTypeID;
end;
procedure TTblimportlogsEntity.setImportData(ImportData: String);
begin
  self.ImportData := ImportData;
end;
procedure TTblimportlogsEntity.setImportResultID(ImportResultID: Integer);
begin
  self.ImportResultID := ImportResultID;
end;
procedure TTblimportlogsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TTblimportlogsEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TTblimportlogsEntity.setCustomer(Customer: String);
begin
  self.Customer := Customer;
end;
procedure TTblimportlogsEntity.setItemCount(ItemCount: Integer);
begin
  self.ItemCount := ItemCount;
end;
procedure TTblimportlogsEntity.setHotelCode(HotelCode: String);
begin
  self.HotelCode := HotelCode;
end;
procedure TTblimportlogsEntity.setStaff(Staff: String);
begin
  self.Staff := Staff;
end;
procedure TTblimportlogsEntity.setRoomNumber(RoomNumber: String);
begin
  self.RoomNumber := RoomNumber;
end;
procedure TTblimportlogsEntity.setIsGroupInvoice(isGroupInvoice: Byte);
begin
  self.isGroupInvoice := isGroupInvoice;
end;
procedure TTblimportlogsEntity.setInvCustomer(invCustomer: String);
begin
  self.invCustomer := invCustomer;
end;
procedure TTblimportlogsEntity.setInvPersonalID(invPersonalID: String);
begin
  self.invPersonalID := invPersonalID;
end;
procedure TTblimportlogsEntity.setInvCustomerName(invCustomerName: String);
begin
  self.invCustomerName := invCustomerName;
end;
procedure TTblimportlogsEntity.setInvAddress1(invAddress1: String);
begin
  self.invAddress1 := invAddress1;
end;
procedure TTblimportlogsEntity.setInvAddress2(invAddress2: String);
begin
  self.invAddress2 := invAddress2;
end;
procedure TTblimportlogsEntity.setInvAddress3(invAddress3: String);
begin
  self.invAddress3 := invAddress3;
end;
procedure TTblimportlogsEntity.setInvAddress4(invAddress4: String);
begin
  self.invAddress4 := invAddress4;
end;
procedure TTblimportlogsEntity.setGuestName(GuestName: String);
begin
  self.GuestName := GuestName;
end;
procedure TTblimportlogsEntity.setSaleRefrence(SaleRefrence: String);
begin
  self.SaleRefrence := SaleRefrence;
end;
procedure TTblimportlogsEntity.setInvoiceNumber(invoiceNumber: Integer);
begin
  self.invoiceNumber := invoiceNumber;
end;
procedure TTblimportlogsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblincEntity **************************************************

procedure TTblincEntity.setCustlast(Custlast: Integer);
begin
  self.Custlast := Custlast;
end;
procedure TTblincEntity.setCustLength(CustLength: Integer);
begin
  self.CustLength := CustLength;
end;
procedure TTblincEntity.setCustFill(CustFill: String);
begin
  self.CustFill := CustFill;
end;
procedure TTblincEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblincEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblinvoiceactionsEntity **************************************************

procedure TTblinvoiceactionsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblinvoiceactionsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TTblinvoiceactionsEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TTblinvoiceactionsEntity.setInvoiceNumber(InvoiceNumber: Integer);
begin
  self.InvoiceNumber := InvoiceNumber;
end;
procedure TTblinvoiceactionsEntity.setActionDate(ActionDate: TTimeStamp);
begin
  self.ActionDate := ActionDate;
end;
procedure TTblinvoiceactionsEntity.setActionID(ActionID: Integer);
begin
  self.ActionID := ActionID;
end;
procedure TTblinvoiceactionsEntity.setAction(Action: String);
begin
  self.Action := Action;
end;
procedure TTblinvoiceactionsEntity.setActionNote(ActionNote: String);
begin
  self.ActionNote := ActionNote;
end;
procedure TTblinvoiceactionsEntity.setStaff(Staff: String);
begin
  self.Staff := Staff;
end;
procedure TTblinvoiceactionsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblmaidactionsEntity **************************************************

procedure TTblmaidactionsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblmaidactionsEntity.setMaAction(maAction: String);
begin
  self.maAction := maAction;
end;
procedure TTblmaidactionsEntity.setMaDescription(maDescription: String);
begin
  self.maDescription := maDescription;
end;
procedure TTblmaidactionsEntity.setMaRule(maRule: String);
begin
  self.maRule := maRule;
end;
procedure TTblmaidactionsEntity.setMaUse(maUse: Byte);
begin
  self.maUse := maUse;
end;
procedure TTblmaidactionsEntity.setMaCross(maCross: Byte);
begin
  self.maCross := maCross;
end;
procedure TTblmaidactionsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TTblmaidactionsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblmaidjobsEntity **************************************************

procedure TTblmaidjobsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblmaidjobsEntity.setMjDate(mjDate: TTimeStamp);
begin
  self.mjDate := mjDate;
end;
procedure TTblmaidjobsEntity.setMjRoom(mjRoom: String);
begin
  self.mjRoom := mjRoom;
end;
procedure TTblmaidjobsEntity.setMjAction(mjAction: String);
begin
  self.mjAction := mjAction;
end;
procedure TTblmaidjobsEntity.setMjDescription(mjDescription: String);
begin
  self.mjDescription := mjDescription;
end;
procedure TTblmaidjobsEntity.setMjFinished(mjFinished: Byte);
begin
  self.mjFinished := mjFinished;
end;
procedure TTblmaidjobsEntity.setMjNote(mjNote: String);
begin
  self.mjNote := mjNote;
end;
procedure TTblmaidjobsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblmaidlistsEntity **************************************************

procedure TTblmaidlistsEntity.setMlDate(mlDate: TTimeStamp);
begin
  self.mlDate := mlDate;
end;
procedure TTblmaidlistsEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TTblmaidlistsEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TTblmaidlistsEntity.setNumberGuests(NumberGuests: Integer);
begin
  self.NumberGuests := NumberGuests;
end;
procedure TTblmaidlistsEntity.setGuestCount(GuestCount: Integer);
begin
  self.GuestCount := GuestCount;
end;
procedure TTblmaidlistsEntity.setExtraGuest(ExtraGuest: Integer);
begin
  self.ExtraGuest := ExtraGuest;
end;
procedure TTblmaidlistsEntity.setGuestStatus(GuestStatus: String);
begin
  self.GuestStatus := GuestStatus;
end;
procedure TTblmaidlistsEntity.setStayDay(StayDay: Integer);
begin
  self.StayDay := StayDay;
end;
procedure TTblmaidlistsEntity.setCheckIn(CheckIn: Integer);
begin
  self.CheckIn := CheckIn;
end;
procedure TTblmaidlistsEntity.setCheckOut(CheckOut: Integer);
begin
  self.CheckOut := CheckOut;
end;
procedure TTblmaidlistsEntity.setWeekDay(WeekDay: Integer);
begin
  self.WeekDay := WeekDay;
end;
procedure TTblmaidlistsEntity.setWeekEnd(WeekEnd: Byte);
begin
  self.WeekEnd := WeekEnd;
end;
procedure TTblmaidlistsEntity.setLocation(Location: String);
begin
  self.Location := Location;
end;
procedure TTblmaidlistsEntity.setFloor(Floor: Integer);
begin
  self.Floor := Floor;
end;
procedure TTblmaidlistsEntity.setHidden(Hidden: Byte);
begin
  self.Hidden := Hidden;
end;
procedure TTblmaidlistsEntity.setRoomStatus(RoomStatus: String);
begin
  self.RoomStatus := RoomStatus;
end;
procedure TTblmaidlistsEntity.setRoomDescription(RoomDescription: String);
begin
  self.RoomDescription := RoomDescription;
end;
procedure TTblmaidlistsEntity.setRoomTypeDescription(RoomTypeDescription: String);
begin
  self.RoomTypeDescription := RoomTypeDescription;
end;
procedure TTblmaidlistsEntity.setArrival(Arrival: TTimeStamp);
begin
  self.Arrival := Arrival;
end;
procedure TTblmaidlistsEntity.setDeparture(Departure: TTimeStamp);
begin
  self.Departure := Departure;
end;
procedure TTblmaidlistsEntity.setLastCheckOutDate(LastCheckOutDate: TTimeStamp);
begin
  self.LastCheckOutDate := LastCheckOutDate;
end;
procedure TTblmaidlistsEntity.setLastCheckOut(LastCheckOut: Integer);
begin
  self.LastCheckOut := LastCheckOut;
end;
procedure TTblmaidlistsEntity.setNextCheckInDate(NextCheckInDate: TTimeStamp);
begin
  self.NextCheckInDate := NextCheckInDate;
end;
procedure TTblmaidlistsEntity.setNextCheckIn(NextCheckIn: Integer);
begin
  self.NextCheckIn := NextCheckIn;
end;
procedure TTblmaidlistsEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TTblmaidlistsEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TTblmaidlistsEntity.setNextRoomReservation(NextRoomReservation: Integer);
begin
  self.NextRoomReservation := NextRoomReservation;
end;
procedure TTblmaidlistsEntity.setLastRoomReservation(LastRoomReservation: Integer);
begin
  self.LastRoomReservation := LastRoomReservation;
end;
procedure TTblmaidlistsEntity.setLastUpdate(LastUpdate: TTimeStamp);
begin
  self.LastUpdate := LastUpdate;
end;
procedure TTblmaidlistsEntity.setNotes(Notes: String);
begin
  self.Notes := Notes;
end;
procedure TTblmaidlistsEntity.setFirstGuest(FirstGuest: String);
begin
  self.FirstGuest := FirstGuest;
end;
procedure TTblmaidlistsEntity.setResName(ResName: String);
begin
  self.ResName := ResName;
end;
procedure TTblmaidlistsEntity.setResStatus(ResStatus: String);
begin
  self.ResStatus := ResStatus;
end;
procedure TTblmaidlistsEntity.setJobPr(JobPr: String);
begin
  self.JobPr := JobPr;
end;
procedure TTblmaidlistsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblmaidlistsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblpoxexportEntity **************************************************

procedure TTblpoxexportEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblpoxexportEntity.setInvoiceNumber(InvoiceNumber: Integer);
begin
  self.InvoiceNumber := InvoiceNumber;
end;
procedure TTblpoxexportEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TTblpoxexportEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TTblpoxexportEntity.setInsertDate(InsertDate: TTimeStamp);
begin
  self.InsertDate := InsertDate;
end;
procedure TTblpoxexportEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblpricecodesEntity **************************************************

procedure TTblpricecodesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblpricecodesEntity.setPcCode(pcCode: String);
begin
  self.pcCode := pcCode;
end;
procedure TTblpricecodesEntity.setPcDescription(pcDescription: String);
begin
  self.pcDescription := pcDescription;
end;
procedure TTblpricecodesEntity.setPcActive(pcActive: Byte);
begin
  self.pcActive := pcActive;
end;
procedure TTblpricecodesEntity.setPcRack(pcRack: Byte);
begin
  self.pcRack := pcRack;
end;
procedure TTblpricecodesEntity.setPcRackCalc(pcRackCalc: Double);
begin
  self.pcRackCalc := pcRackCalc;
end;
procedure TTblpricecodesEntity.setPcShowDiscount(pcShowDiscount: Byte);
begin
  self.pcShowDiscount := pcShowDiscount;
end;
procedure TTblpricecodesEntity.setPcDiscountText(pcDiscountText: String);
begin
  self.pcDiscountText := pcDiscountText;
end;
procedure TTblpricecodesEntity.setPcAutomatic(pcAutomatic: Byte);
begin
  self.pcAutomatic := pcAutomatic;
end;
procedure TTblpricecodesEntity.setPcLastUpdate(pcLastUpdate: TTimeStamp);
begin
  self.pcLastUpdate := pcLastUpdate;
end;
procedure TTblpricecodesEntity.setPcDiscountDaysAfter(pcDiscountDaysAfter: Integer);
begin
  self.pcDiscountDaysAfter := pcDiscountDaysAfter;
end;
procedure TTblpricecodesEntity.setPcDiscountPriceAfter(pcDiscountPriceAfter: Double);
begin
  self.pcDiscountPriceAfter := pcDiscountPriceAfter;
end;
procedure TTblpricecodesEntity.setPcDiscountMethod(pcDiscountMethod: Byte);
begin
  self.pcDiscountMethod := pcDiscountMethod;
end;
procedure TTblpricecodesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TTblpricecodesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TTblpricecodesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblroomstatusEntity **************************************************

procedure TTblroomstatusEntity.setResDate(resDate: TTimeStamp);
begin
  self.resDate := resDate;
end;
procedure TTblroomstatusEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TTblroomstatusEntity.setAvailable(available: Integer);
begin
  self.available := available;
end;
procedure TTblroomstatusEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblroomstatusEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTblseasonsEntity **************************************************

procedure TTblseasonsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTblseasonsEntity.setSeStartDate(seStartDate: TTimeStamp);
begin
  self.seStartDate := seStartDate;
end;
procedure TTblseasonsEntity.setSeEndDate(seEndDate: TTimeStamp);
begin
  self.seEndDate := seEndDate;
end;
procedure TTblseasonsEntity.setSeDescription(seDescription: String);
begin
  self.seDescription := seDescription;
end;
procedure TTblseasonsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TTblseasonsEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TTblseasonsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTeldevicesEntity **************************************************

procedure TTeldevicesEntity.setDevice(Device: String);
begin
  self.Device := Device;
end;
procedure TTeldevicesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TTeldevicesEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TTeldevicesEntity.setDoCharge(doCharge: Byte);
begin
  self.doCharge := doCharge;
end;
procedure TTeldevicesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTeldevicesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TTeldevicesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTellogEntity **************************************************

procedure TTellogEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTellogEntity.setLogDateTime(LogDateTime: TTimeStamp);
begin
  self.LogDateTime := LogDateTime;
end;
procedure TTellogEntity.setCallId(CallId: Integer);
begin
  self.CallId := CallId;
end;
procedure TTellogEntity.setCallStart(CallStart: TTimeStamp);
begin
  self.CallStart := CallStart;
end;
procedure TTellogEntity.setConnectedTime(ConnectedTime: String);
begin
  self.ConnectedTime := ConnectedTime;
end;
procedure TTellogEntity.setRingTime(RingTime: Integer);
begin
  self.RingTime := RingTime;
end;
procedure TTellogEntity.setCaller(Caller: String);
begin
  self.Caller := Caller;
end;
procedure TTellogEntity.setDirection(Direction: String);
begin
  self.Direction := Direction;
end;
procedure TTellogEntity.setIsExternal(IsExternal: Byte);
begin
  self.IsExternal := IsExternal;
end;
procedure TTellogEntity.setCalledNumber(CalledNumber: String);
begin
  self.CalledNumber := CalledNumber;
end;
procedure TTellogEntity.setDialledNumber(DialledNumber: String);
begin
  self.DialledNumber := DialledNumber;
end;
procedure TTellogEntity.setAccount(Account: String);
begin
  self.Account := Account;
end;
procedure TTellogEntity.setContinuation(Continuation: Byte);
begin
  self.Continuation := Continuation;
end;
procedure TTellogEntity.setParty1Device(Party1Device: String);
begin
  self.Party1Device := Party1Device;
end;
procedure TTellogEntity.setParty1Name(Party1Name: String);
begin
  self.Party1Name := Party1Name;
end;
procedure TTellogEntity.setParty2Device(Party2Device: String);
begin
  self.Party2Device := Party2Device;
end;
procedure TTellogEntity.setParty2Name(Party2Name: String);
begin
  self.Party2Name := Party2Name;
end;
procedure TTellogEntity.setHoldTime(HoldTime: Integer);
begin
  self.HoldTime := HoldTime;
end;
procedure TTellogEntity.setParkTime(ParkTime: Integer);
begin
  self.ParkTime := ParkTime;
end;
procedure TTellogEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TTellogEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TTellogEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TTellogEntity.setInvoiceNumber(InvoiceNumber: Integer);
begin
  self.InvoiceNumber := InvoiceNumber;
end;
procedure TTellogEntity.setPriceRule(PriceRule: String);
begin
  self.PriceRule := PriceRule;
end;
procedure TTellogEntity.setPriceGroup(PriceGroup: String);
begin
  self.PriceGroup := PriceGroup;
end;
procedure TTellogEntity.setMinutePrice(minutePrice: Double);
begin
  self.minutePrice := minutePrice;
end;
procedure TTellogEntity.setStartPrice(startPrice: Double);
begin
  self.startPrice := startPrice;
end;
procedure TTellogEntity.setChargedTime(chargedTime: Integer);
begin
  self.chargedTime := chargedTime;
end;
procedure TTellogEntity.setChargedAmount(ChargedAmount: Double);
begin
  self.ChargedAmount := ChargedAmount;
end;
procedure TTellogEntity.setImportRefrence(ImportRefrence: String);
begin
  self.ImportRefrence := ImportRefrence;
end;
procedure TTellogEntity.setIsInternal(IsInternal: Byte);
begin
  self.IsInternal := IsInternal;
end;
procedure TTellogEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TTellogEntity.setAuthValid(AuthValid: Byte);
begin
  self.AuthValid := AuthValid;
end;
procedure TTellogEntity.setAuthCode(AuthCode: String);
begin
  self.AuthCode := AuthCode;
end;
procedure TTellogEntity.setUserCharged(UserCharged: String);
begin
  self.UserCharged := UserCharged;
end;
procedure TTellogEntity.setCallCharge(CallCharge: Double);
begin
  self.CallCharge := CallCharge;
end;
procedure TTellogEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TTellogEntity.setAmountAtLastUserChange(AmountAtLastUserChange: Double);
begin
  self.AmountAtLastUserChange := AmountAtLastUserChange;
end;
procedure TTellogEntity.setCallUnits(CallUnits: Integer);
begin
  self.CallUnits := CallUnits;
end;
procedure TTellogEntity.setUnitsAtLastUserChange(UnitsAtLastUserChange: Integer);
begin
  self.UnitsAtLastUserChange := UnitsAtLastUserChange;
end;
procedure TTellogEntity.setCostPerUnit(CostPerUnit: Integer);
begin
  self.CostPerUnit := CostPerUnit;
end;
procedure TTellogEntity.setMarkUp(MarkUp: Integer);
begin
  self.MarkUp := MarkUp;
end;
procedure TTellogEntity.setExternalTargetingCause(ExternalTargetingCause: String);
begin
  self.ExternalTargetingCause := ExternalTargetingCause;
end;
procedure TTellogEntity.setExternalTargeterId(ExternalTargeterId: String);
begin
  self.ExternalTargeterId := ExternalTargeterId;
end;
procedure TTellogEntity.setExternalTargetedNumber(ExternalTargetedNumber: String);
begin
  self.ExternalTargetedNumber := ExternalTargetedNumber;
end;
procedure TTellogEntity.setRecordSource(RecordSource: String);
begin
  self.RecordSource := RecordSource;
end;
procedure TTellogEntity.setConnectedTimeSec(ConnectedTimeSec: Integer);
begin
  self.ConnectedTimeSec := ConnectedTimeSec;
end;
procedure TTellogEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTelpricegroupsEntity **************************************************

procedure TTelpricegroupsEntity.setTpgCode(tpgCode: String);
begin
  self.tpgCode := tpgCode;
end;
procedure TTelpricegroupsEntity.setTpgDescription(tpgDescription: String);
begin
  self.tpgDescription := tpgDescription;
end;
procedure TTelpricegroupsEntity.setTpgPrice(tpgPrice: Double);
begin
  self.tpgPrice := tpgPrice;
end;
procedure TTelpricegroupsEntity.setCode(Code: String);
begin
  self.Code := Code;
end;
procedure TTelpricegroupsEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TTelpricegroupsEntity.setPrice(Price: Double);
begin
  self.Price := Price;
end;
procedure TTelpricegroupsEntity.setDoUse(doUse: Byte);
begin
  self.doUse := doUse;
end;
procedure TTelpricegroupsEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTelpricegroupsEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TTelpricegroupsEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTelpricerulesEntity **************************************************

procedure TTelpricerulesEntity.setAutogen(Autogen: String);
begin
  self.Autogen := Autogen;
end;
procedure TTelpricerulesEntity.setTprName(tprName: String);
begin
  self.tprName := tprName;
end;
procedure TTelpricerulesEntity.setTprMask(tprMask: String);
begin
  self.tprMask := tprMask;
end;
procedure TTelpricerulesEntity.setTprTpgCode(tprTpgCode: String);
begin
  self.tprTpgCode := tprTpgCode;
end;
procedure TTelpricerulesEntity.setTprOrder(tprOrder: Integer);
begin
  self.tprOrder := tprOrder;
end;
procedure TTelpricerulesEntity.setCode(Code: String);
begin
  self.Code := Code;
end;
procedure TTelpricerulesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TTelpricerulesEntity.setMask(Mask: String);
begin
  self.Mask := Mask;
end;
procedure TTelpricerulesEntity.setTpgCode(tpgCode: String);
begin
  self.tpgCode := tpgCode;
end;
procedure TTelpricerulesEntity.setDisplayOrder(displayOrder: Integer);
begin
  self.displayOrder := displayOrder;
end;
procedure TTelpricerulesEntity.setDoUse(doUse: Byte);
begin
  self.doUse := doUse;
end;
procedure TTelpricerulesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTelpricerulesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TTelpricerulesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTestnamesEntity **************************************************

procedure TTestnamesEntity.setNumber(number: Integer);
begin
  self.number := number;
end;
procedure TTestnamesEntity.setGender(gender: String);
begin
  self.gender := gender;
end;
procedure TTestnamesEntity.setTitle(title: String);
begin
  self.title := title;
end;
procedure TTestnamesEntity.setGivenname(givenname: String);
begin
  self.givenname := givenname;
end;
procedure TTestnamesEntity.setSurname(surname: String);
begin
  self.surname := surname;
end;
procedure TTestnamesEntity.setStreetaddress(streetaddress: String);
begin
  self.streetaddress := streetaddress;
end;
procedure TTestnamesEntity.setCity(city: String);
begin
  self.city := city;
end;
procedure TTestnamesEntity.setState(state: String);
begin
  self.state := state;
end;
procedure TTestnamesEntity.setZipcode(zipcode: String);
begin
  self.zipcode := zipcode;
end;
procedure TTestnamesEntity.setCountry(country: String);
begin
  self.country := country;
end;
procedure TTestnamesEntity.setCountryfull(countryfull: String);
begin
  self.countryfull := countryfull;
end;
procedure TTestnamesEntity.setEmailaddress(emailaddress: String);
begin
  self.emailaddress := emailaddress;
end;
procedure TTestnamesEntity.setTelephonenumber(telephonenumber: String);
begin
  self.telephonenumber := telephonenumber;
end;
procedure TTestnamesEntity.setNationalid(nationalid: String);
begin
  self.nationalid := nationalid;
end;
procedure TTestnamesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TTtmpEntity **************************************************

procedure TTtmpEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TTtmpEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TTtmpEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TTtmpEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TTtmpEntity.setADate(aDate: TTimeStamp);
begin
  self.aDate := aDate;
end;
procedure TTtmpEntity.setResStatus(ResStatus: String);
begin
  self.ResStatus := ResStatus;
end;
procedure TTtmpEntity.setRRAmountNo(RRAmountNo: Double);
begin
  self.RRAmountNo := RRAmountNo;
end;
procedure TTtmpEntity.setRRDiscAmountNo(RRDiscAmountNo: Double);
begin
  self.RRDiscAmountNo := RRDiscAmountNo;
end;
procedure TTtmpEntity.setRRAmountYES(RRAmountYES: Double);
begin
  self.RRAmountYES := RRAmountYES;
end;
procedure TTtmpEntity.setRRDiscAmountYES(RRDiscAmountYES: Double);
begin
  self.RRDiscAmountYES := RRDiscAmountYES;
end;
procedure TTtmpEntity.setGoodsAmountYes(GoodsAmountYes: Double);
begin
  self.GoodsAmountYes := GoodsAmountYes;
end;
procedure TTtmpEntity.setGoodsAmountNo(GoodsAmountNo: Double);
begin
  self.GoodsAmountNo := GoodsAmountNo;
end;
procedure TTtmpEntity.setRoomAmount(RoomAmount: Double);
begin
  self.RoomAmount := RoomAmount;
end;
procedure TTtmpEntity.setDayIndex(DayIndex: Integer);
begin
  self.DayIndex := DayIndex;
end;
procedure TTtmpEntity.setRRTotalNo(RRTotalNo: Double);
begin
  self.RRTotalNo := RRTotalNo;
end;
procedure TTtmpEntity.setRRTotalYes(RRTotalYes: Double);
begin
  self.RRTotalYes := RRTotalYes;
end;
procedure TTtmpEntity.setRRTotal(RRTotal: Double);
begin
  self.RRTotal := RRTotal;
end;
procedure TTtmpEntity.setGoodsTotal(GoodsTotal: Double);
begin
  self.GoodsTotal := GoodsTotal;
end;
procedure TTtmpEntity.setYesTotal(YesTotal: Double);
begin
  self.YesTotal := YesTotal;
end;
procedure TTtmpEntity.setNoTotal(NoTotal: Double);
begin
  self.NoTotal := NoTotal;
end;
procedure TTtmpEntity.setTotal(Total: Double);
begin
  self.Total := Total;
end;
procedure TTtmpEntity.setWeekNo(WeekNo: Integer);
begin
  self.WeekNo := WeekNo;
end;
procedure TTtmpEntity.setDayNo(DayNo: Integer);
begin
  self.DayNo := DayNo;
end;
procedure TTtmpEntity.setMonthNo(MonthNo: Integer);
begin
  self.MonthNo := MonthNo;
end;
procedure TTtmpEntity.setYearNo(YearNo: Integer);
begin
  self.YearNo := YearNo;
end;
procedure TTtmpEntity.setWeekDay(WeekDay: Integer);
begin
  self.WeekDay := WeekDay;
end;
procedure TTtmpEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TTtmpEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TVatcodesEntity **************************************************

procedure TVatcodesEntity.setVATCode(VATCode: String);
begin
  self.VATCode := VATCode;
end;
procedure TVatcodesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TVatcodesEntity.setVATPercentage(VATPercentage: Double);
begin
  self.VATPercentage := VATPercentage;
end;
procedure TVatcodesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TVatcodesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TVatcodesEntity.setLastUpdate(lastUpdate: TTimeStamp);
begin
  self.lastUpdate := lastUpdate;
end;
procedure TVatcodesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TViewroomprices1Entity **************************************************

procedure TViewroomprices1Entity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TViewroomprices1Entity.setSeID(seID: Integer);
begin
  self.seID := seID;
end;
procedure TViewroomprices1Entity.setPcID(pcID: Integer);
begin
  self.pcID := pcID;
end;
procedure TViewroomprices1Entity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TViewroomprices1Entity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TViewroomprices1Entity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TViewroomprices1Entity.setPrice1Person(Price1Person: Double);
begin
  self.Price1Person := Price1Person;
end;
procedure TViewroomprices1Entity.setPrice2Persons(Price2Persons: Double);
begin
  self.Price2Persons := Price2Persons;
end;
procedure TViewroomprices1Entity.setPrice3Persons(Price3Persons: Double);
begin
  self.Price3Persons := Price3Persons;
end;
procedure TViewroomprices1Entity.setPrice4Persons(Price4Persons: Double);
begin
  self.Price4Persons := Price4Persons;
end;
procedure TViewroomprices1Entity.setPrice5Persons(Price5Persons: Double);
begin
  self.Price5Persons := Price5Persons;
end;
procedure TViewroomprices1Entity.setPrice6Persons(Price6Persons: Double);
begin
  self.Price6Persons := Price6Persons;
end;
procedure TViewroomprices1Entity.setPriceExtraPerson(PriceExtraPerson: Double);
begin
  self.PriceExtraPerson := PriceExtraPerson;
end;
procedure TViewroomprices1Entity.setPcCode(pcCode: String);
begin
  self.pcCode := pcCode;
end;
procedure TViewroomprices1Entity.setPcDescription(pcDescription: String);
begin
  self.pcDescription := pcDescription;
end;
procedure TViewroomprices1Entity.setPcActive(pcActive: Byte);
begin
  self.pcActive := pcActive;
end;
procedure TViewroomprices1Entity.setPcRack(pcRack: Byte);
begin
  self.pcRack := pcRack;
end;
procedure TViewroomprices1Entity.setPcRackCalc(pcRackCalc: Double);
begin
  self.pcRackCalc := pcRackCalc;
end;
procedure TViewroomprices1Entity.setPcShowDiscount(pcShowDiscount: Byte);
begin
  self.pcShowDiscount := pcShowDiscount;
end;
procedure TViewroomprices1Entity.setPcDiscountText(pcDiscountText: String);
begin
  self.pcDiscountText := pcDiscountText;
end;
procedure TViewroomprices1Entity.setPcAutomatic(pcAutomatic: Byte);
begin
  self.pcAutomatic := pcAutomatic;
end;
procedure TViewroomprices1Entity.setSeStartDate(seStartDate: TTimeStamp);
begin
  self.seStartDate := seStartDate;
end;
procedure TViewroomprices1Entity.setSeEndDate(seEndDate: TTimeStamp);
begin
  self.seEndDate := seEndDate;
end;
procedure TViewroomprices1Entity.setSeDescription(seDescription: String);
begin
  self.seDescription := seDescription;
end;
procedure TViewroomprices1Entity.setNumberGuests(NumberGuests: Integer);
begin
  self.NumberGuests := NumberGuests;
end;
procedure TViewroomprices1Entity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TW_sale_invoice_payments_per_dateEntity **************************************************

procedure TW_sale_invoice_payments_per_dateEntity.setReservation(Reservation: Integer);
begin
  self.Reservation := Reservation;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setRoomReservation(RoomReservation: Integer);
begin
  self.RoomReservation := RoomReservation;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setInvoiceNumber(InvoiceNumber: Integer);
begin
  self.InvoiceNumber := InvoiceNumber;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setInvoiceDate(InvoiceDate: String);
begin
  self.InvoiceDate := InvoiceDate;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setCustomer(Customer: String);
begin
  self.Customer := Customer;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setName(Name: String);
begin
  self.Name := Name;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setCreditInvoice(CreditInvoice: Integer);
begin
  self.CreditInvoice := CreditInvoice;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setPayType(PayType: String);
begin
  self.PayType := PayType;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setAmount(Amount: Double);
begin
  self.Amount := Amount;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setPmDescription(pmDescription: String);
begin
  self.pmDescription := pmDescription;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setCurrencyRate(CurrencyRate: Double);
begin
  self.CurrencyRate := CurrencyRate;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setAyear(Ayear: Integer);
begin
  self.Ayear := Ayear;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setAmon(Amon: Integer);
begin
  self.Amon := Amon;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setAday(Aday: Integer);
begin
  self.Aday := Aday;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setTotal(Total: Double);
begin
  self.Total := Total;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setTotalWOVAT(TotalWOVAT: Double);
begin
  self.TotalWOVAT := TotalWOVAT;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setTotalVAT(TotalVAT: Double);
begin
  self.TotalVAT := TotalVAT;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setSurname(Surname: String);
begin
  self.Surname := Surname;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setCustName(custName: String);
begin
  self.custName := custName;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setCustomerType(CustomerType: String);
begin
  self.CustomerType := CustomerType;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setTravelAgency(TravelAgency: Byte);
begin
  self.TravelAgency := TravelAgency;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setPtDescription(ptDescription: String);
begin
  self.ptDescription := ptDescription;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setPayGroup(PayGroup: String);
begin
  self.PayGroup := PayGroup;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setPgDescription(pgDescription: String);
begin
  self.pgDescription := pgDescription;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setPID(PID: String);
begin
  self.PID := PID;
end;
procedure TW_sale_invoice_payments_per_dateEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TWroominfoEntity **************************************************

procedure TWroominfoEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TWroominfoEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TWroominfoEntity.setDetailedDescription(DetailedDescription: String);
begin
  self.DetailedDescription := DetailedDescription;
end;
procedure TWroominfoEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TWroominfoEntity.setBath(Bath: Byte);
begin
  self.Bath := Bath;
end;
procedure TWroominfoEntity.setShower(Shower: Byte);
begin
  self.Shower := Shower;
end;
procedure TWroominfoEntity.setSafe(Safe: Byte);
begin
  self.Safe := Safe;
end;
procedure TWroominfoEntity.setTV(TV: Byte);
begin
  self.TV := TV;
end;
procedure TWroominfoEntity.setVideo(Video: Byte);
begin
  self.Video := Video;
end;
procedure TWroominfoEntity.setRadio(Radio: Byte);
begin
  self.Radio := Radio;
end;
procedure TWroominfoEntity.setCDPlayer(CDPlayer: Byte);
begin
  self.CDPlayer := CDPlayer;
end;
procedure TWroominfoEntity.setTelephone(Telephone: Byte);
begin
  self.Telephone := Telephone;
end;
procedure TWroominfoEntity.setPress(Press: Byte);
begin
  self.Press := Press;
end;
procedure TWroominfoEntity.setCoffee(Coffee: Byte);
begin
  self.Coffee := Coffee;
end;
procedure TWroominfoEntity.setKitchen(Kitchen: Byte);
begin
  self.Kitchen := Kitchen;
end;
procedure TWroominfoEntity.setMinibar(Minibar: Byte);
begin
  self.Minibar := Minibar;
end;
procedure TWroominfoEntity.setFridge(Fridge: Byte);
begin
  self.Fridge := Fridge;
end;
procedure TWroominfoEntity.setHairdryer(Hairdryer: Byte);
begin
  self.Hairdryer := Hairdryer;
end;
procedure TWroominfoEntity.setInternetPlug(InternetPlug: Byte);
begin
  self.InternetPlug := InternetPlug;
end;
procedure TWroominfoEntity.setFax(Fax: Byte);
begin
  self.Fax := Fax;
end;
procedure TWroominfoEntity.setSqrMeters(SqrMeters: Double);
begin
  self.SqrMeters := SqrMeters;
end;
procedure TWroominfoEntity.setBedSize(BedSize: String);
begin
  self.BedSize := BedSize;
end;
procedure TWroominfoEntity.setEquipments(Equipments: String);
begin
  self.Equipments := Equipments;
end;
procedure TWroominfoEntity.setBookable(Bookable: Byte);
begin
  self.Bookable := Bookable;
end;
procedure TWroominfoEntity.setStatistics(Statistics: Byte);
begin
  self.Statistics := Statistics;
end;
procedure TWroominfoEntity.setStatus(Status: String);
begin
  self.Status := Status;
end;
procedure TWroominfoEntity.setOrderIndex(OrderIndex: Integer);
begin
  self.OrderIndex := OrderIndex;
end;
procedure TWroominfoEntity.setHidden(hidden: Byte);
begin
  self.hidden := hidden;
end;
procedure TWroominfoEntity.setLocation(Location: String);
begin
  self.Location := Location;
end;
procedure TWroominfoEntity.setFloor(Floor: Integer);
begin
  self.Floor := Floor;
end;
procedure TWroominfoEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TWroominfoEntity.setDorm(Dorm: String);
begin
  self.Dorm := Dorm;
end;
procedure TWroominfoEntity.setUseInNationalReport(useInNationalReport: Byte);
begin
  self.useInNationalReport := useInNationalReport;
end;
procedure TWroominfoEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TWroominfoEntity.setLocationDescription(LocationDescription: String);
begin
  self.LocationDescription := LocationDescription;
end;
procedure TWroominfoEntity.setRoomTypeDescription(RoomTypeDescription: String);
begin
  self.RoomTypeDescription := RoomTypeDescription;
end;
procedure TWroominfoEntity.setNumberGuests(NumberGuests: Integer);
begin
  self.NumberGuests := NumberGuests;
end;
procedure TWroominfoEntity.setRoomTypeGroup(RoomTypeGroup: String);
begin
  self.RoomTypeGroup := RoomTypeGroup;
end;
procedure TWroominfoEntity.setRoomTypeGroupDescription(RoomTypeGroupDescription: String);
begin
  self.RoomTypeGroupDescription := RoomTypeGroupDescription;
end;
procedure TWroominfoEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TWroomratesEntity **************************************************

procedure TWroomratesEntity.setID(ID: Integer);
begin
  self.ID := ID;
end;
procedure TWroomratesEntity.setPriceCodeID(PriceCodeID: Integer);
begin
  self.PriceCodeID := PriceCodeID;
end;
procedure TWroomratesEntity.setPcCode(pcCode: String);
begin
  self.pcCode := pcCode;
end;
procedure TWroomratesEntity.setPcRack(pcRack: Byte);
begin
  self.pcRack := pcRack;
end;
procedure TWroomratesEntity.setCurrencyID(CurrencyID: Integer);
begin
  self.CurrencyID := CurrencyID;
end;
procedure TWroomratesEntity.setCurrency(Currency: String);
begin
  self.Currency := Currency;
end;
procedure TWroomratesEntity.setSeasonID(SeasonID: Integer);
begin
  self.SeasonID := SeasonID;
end;
procedure TWroomratesEntity.setSeStartDate(seStartDate: TTimeStamp);
begin
  self.seStartDate := seStartDate;
end;
procedure TWroomratesEntity.setSeEndDate(seEndDate: TTimeStamp);
begin
  self.seEndDate := seEndDate;
end;
procedure TWroomratesEntity.setSeDescription(seDescription: String);
begin
  self.seDescription := seDescription;
end;
procedure TWroomratesEntity.setRoomTypeID(RoomTypeID: Integer);
begin
  self.RoomTypeID := RoomTypeID;
end;
procedure TWroomratesEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TWroomratesEntity.setNumberGuests(NumberGuests: Integer);
begin
  self.NumberGuests := NumberGuests;
end;
procedure TWroomratesEntity.setRateID(RateID: Integer);
begin
  self.RateID := RateID;
end;
procedure TWroomratesEntity.setRateCurrency(RateCurrency: String);
begin
  self.RateCurrency := RateCurrency;
end;
procedure TWroomratesEntity.setRate1Person(Rate1Person: Double);
begin
  self.Rate1Person := Rate1Person;
end;
procedure TWroomratesEntity.setRate2Persons(Rate2Persons: Double);
begin
  self.Rate2Persons := Rate2Persons;
end;
procedure TWroomratesEntity.setRate3Persons(Rate3Persons: Double);
begin
  self.Rate3Persons := Rate3Persons;
end;
procedure TWroomratesEntity.setRate4Persons(Rate4Persons: Double);
begin
  self.Rate4Persons := Rate4Persons;
end;
procedure TWroomratesEntity.setRate5Persons(Rate5Persons: Double);
begin
  self.Rate5Persons := Rate5Persons;
end;
procedure TWroomratesEntity.setRate6Persons(Rate6Persons: Double);
begin
  self.Rate6Persons := Rate6Persons;
end;
procedure TWroomratesEntity.setRateExtraPerson(RateExtraPerson: Double);
begin
  self.RateExtraPerson := RateExtraPerson;
end;
procedure TWroomratesEntity.setRateExtraChildren(RateExtraChildren: Double);
begin
  self.RateExtraChildren := RateExtraChildren;
end;
procedure TWroomratesEntity.setRateExtraInfant(RateExtraInfant: Double);
begin
  self.RateExtraInfant := RateExtraInfant;
end;
procedure TWroomratesEntity.setRateDescription(rateDescription: String);
begin
  self.rateDescription := rateDescription;
end;
procedure TWroomratesEntity.setActive(Active: Byte);
begin
  self.Active := Active;
end;
procedure TWroomratesEntity.setDateFrom(DateFrom: TTimeStamp);
begin
  self.DateFrom := DateFrom;
end;
procedure TWroomratesEntity.setDateTo(DateTo: TTimeStamp);
begin
  self.DateTo := DateTo;
end;
procedure TWroomratesEntity.setDescription(Description: String);
begin
  self.Description := Description;
end;
procedure TWroomratesEntity.setDateCreated(DateCreated: TTimeStamp);
begin
  self.DateCreated := DateCreated;
end;
procedure TWroomratesEntity.setLastModified(LastModified: TTimeStamp);
begin
  self.LastModified := LastModified;
end;
procedure TWroomratesEntity.setJson(json: String);
begin
  self.json := json;
end;

// ****************************************** TWroomsEntity **************************************************

procedure TWroomsEntity.setRoom(Room: String);
begin
  self.Room := Room;
end;
procedure TWroomsEntity.setRoDescription(roDescription: String);
begin
  self.roDescription := roDescription;
end;
procedure TWroomsEntity.setRoomType(RoomType: String);
begin
  self.RoomType := RoomType;
end;
procedure TWroomsEntity.setRtRoomtypeDescription(rtRoomtypeDescription: String);
begin
  self.rtRoomtypeDescription := rtRoomtypeDescription;
end;
procedure TWroomsEntity.setNumberGuests(NumberGuests: Integer);
begin
  self.NumberGuests := NumberGuests;
end;
procedure TWroomsEntity.setFloor(Floor: Integer);
begin
  self.Floor := Floor;
end;
procedure TWroomsEntity.setRldescription(rldescription: String);
begin
  self.rldescription := rldescription;
end;
procedure TWroomsEntity.setStatus(Status: String);
begin
  self.Status := Status;
end;
procedure TWroomsEntity.setBath(Bath: Byte);
begin
  self.Bath := Bath;
end;
procedure TWroomsEntity.setShower(Shower: Byte);
begin
  self.Shower := Shower;
end;
procedure TWroomsEntity.setSafe(Safe: Byte);
begin
  self.Safe := Safe;
end;
procedure TWroomsEntity.setTV(TV: Byte);
begin
  self.TV := TV;
end;
procedure TWroomsEntity.setVideo(Video: Byte);
begin
  self.Video := Video;
end;
procedure TWroomsEntity.setRadio(Radio: Byte);
begin
  self.Radio := Radio;
end;
procedure TWroomsEntity.setCDPlayer(CDPlayer: Byte);
begin
  self.CDPlayer := CDPlayer;
end;
procedure TWroomsEntity.setTelephone(Telephone: Byte);
begin
  self.Telephone := Telephone;
end;
procedure TWroomsEntity.setPress(Press: Byte);
begin
  self.Press := Press;
end;
procedure TWroomsEntity.setCoffee(Coffee: Byte);
begin
  self.Coffee := Coffee;
end;
procedure TWroomsEntity.setKitchen(Kitchen: Byte);
begin
  self.Kitchen := Kitchen;
end;
procedure TWroomsEntity.setMinibar(Minibar: Byte);
begin
  self.Minibar := Minibar;
end;
procedure TWroomsEntity.setFridge(Fridge: Byte);
begin
  self.Fridge := Fridge;
end;
procedure TWroomsEntity.setHairdryer(Hairdryer: Byte);
begin
  self.Hairdryer := Hairdryer;
end;
procedure TWroomsEntity.setInternetPlug(InternetPlug: Byte);
begin
  self.InternetPlug := InternetPlug;
end;
procedure TWroomsEntity.setFax(Fax: Byte);
begin
  self.Fax := Fax;
end;
procedure TWroomsEntity.setSqrMeters(SqrMeters: Double);
begin
  self.SqrMeters := SqrMeters;
end;
procedure TWroomsEntity.setBedSize(BedSize: String);
begin
  self.BedSize := BedSize;
end;
procedure TWroomsEntity.setEquipments(Equipments: String);
begin
  self.Equipments := Equipments;
end;
procedure TWroomsEntity.setJson(json: String);
begin
  self.json := json;
end;

initialization

RegisterClasses([TCancellationdetailsEntity,
TChannelclassrelationsEntity,
TChannelmanagersEntity,
TChannelplancodesEntity,
TChannelratesEntity,
TChannelratesavailabilitiesEntity,
TChannelsEntity,
TChanneltogglingrulesEntity,
TChanneltogglingrulessplitEntity,
TColorsEntity,
TControlEntity,
TCountriesEntity,
TCountrygroupsEntity,
TCurrenciesEntity,
TCustomerpersonsEntity,
TCustomerpreferencesEntity,
TCustomersEntity,
TCustomertypesEntity,
TDictionaryEntity,
TFacilityactiontypesEntity,
TFakenamesEntity,
THotelconfigurationsEntity,
THotelcontactsEntity,
THotelcountersEntity,
THoteltasksEntity,
TIdreferencesEntity,
TIndustriesEntity,
TInvoiceheadsEntity,
TInvoicelinesEntity,
TInvoicelinestmpEntity,
TItemsEntity,
TItemtypesEntity,
TLocationsEntity,
TMaintenancecodesEntity,
TMaintenanceroomnotesEntity,
TPackageclassesEntity,
TPackageitemsEntity,
TPackagesEntity,
TPackageusageEntity,
TPaygroupsEntity,
TPaymentsEntity,
TPaytypesEntity,
TPersonEntity,
TPersonaddressEntity,
TPersonchildrenEntity,
TPersoncontactEntity,
TPersoncontacttypeEntity,
TPersonitemsEntity,
TPersonprofileEntity,
TPersonsEntity,
TPersonviptypesEntity,
TPredefineddatesEntity,
TPricerulesEntity,
TPricerulespackagesEntity,
TPricetypesEntity,
TPromocodesEntity,
TPropertiesstoreEntity,
TRatesEntity,
TReservationsEntity,
TRoomamenitiesEntity,
TRoomermessagesEntity,
TRoomratesEntity,
TRoomreservationsEntity,
TRoomroomamenitiesEntity,
TRoomsEntity,
TRoomsdateEntity,
TRoomsdatetempEntity,
TRoomtypegroupsEntity,
TRoomtyperulesEntity,
TRoomtypesEntity,
TStaffmembersEntity,
TStafftypesEntity,
TSystemactionsEntity,
TSystemserversEntity,
TSystemtriggersEntity,
TTblconvertgroupsEntity,
TTblconvertsEntity,
TTbldelpersonsEntity,
TTbldelreservationsEntity,
TTbldelroomreservationsEntity,
TTblhiddeninfoEntity,
TTblimportlogsEntity,
TTblincEntity,
TTblinvoiceactionsEntity,
TTblmaidactionsEntity,
TTblmaidjobsEntity,
TTblmaidlistsEntity,
TTblpoxexportEntity,
TTblpricecodesEntity,
TTblroomstatusEntity,
TTblseasonsEntity,
TTeldevicesEntity,
TTellogEntity,
TTelpricegroupsEntity,
TTelpricerulesEntity,
TTestnamesEntity,
TTtmpEntity,
TVatcodesEntity,
TViewroomprices1Entity,
TW_sale_invoice_payments_per_dateEntity,
TWroominfoEntity,
TWroomratesEntity,
TWroomsEntity]);

End.

