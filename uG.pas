unit uG;

{$M+}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Forms,
  Controls,
  Graphics,
  IniFiles,
  dialogs,
  Grids,
  AdvGrid,
  ADOdb,
  hData,
  uUtils
  , ComObj
  , MSXML
  , ActiveX
  , Soap.EncdDecd
  , objRoomList2
  //LocOnFly
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , Registry
  , uFileSystemUtils
  , uRegistryServices
  , uRoomerDefinitions
  , System.Generics.Collections, uReservationStateDefinitions
  ;



type
  TActTableAction = (actNone, actEdit, actInsert, actDelete, actLookup, actCancel, actAutoUpdate, actClone);


  IntegerArray = Array of Integer;
  StringArray = Array of String;
  VariantArray = Array of Variant;

  TGroupEntity = class
  private
    FName: String;
    FReservation: integer;
  public
    constructor Create(_Reservation : integer; _Name : String);
    property Reservation : integer read FReservation;
    property Name : String read FName;
  end;

  TGroupEntityList = TObjectList<TGroupEntity>;

  TRoomCell = class
  private
    FRoomStatus : string;
  public
    constructor Create(status : string);
    property Roomstatus : string read FRoomStatus write FRoomStatus;
  end;

  recDownPayment = record
    Reservation     : Integer; //-
    RoomReservation : integer; //-
    Invoice         : integer; // -1

    Quantity    : integer; //-
    Amount      : double ; //Amount
    Description : string ; //Description
    Notes       : string ; //Memo
    PaymentType : string;  //PayType

    PayDate      : TdateTime;
    payGroup     : string ;
    confirmdate  : TdateTime;

    InvoiceBalance : double;

    NotInvoice : Boolean;

  end;


  recHiddenInfoHolder = record
    ID           : integer;
    Notes	       : string;
    DeleteOn	   : TDate;
    ViewLog	     : string;
    Refrence	   : integer;
    RefrenceType : integer;
  end;

  recGridColors = record
    defBackcolor     : string;
    defTitleColor    : string;
    defTitleFont     : string;
  end;




type

  recInvItemLinesAmounts = record
    Price : double;
    Total : double;
    Currency : string;
  end;

  recOldPriceHolder = record
      Price1
    , Price2
    , Price3 : double;
      Price1From
    , Price2From
    , Price3From

    , Price1To
    , Price2To
    , Price3To : TDate;

      discount   : double;
      percentage : boolean;
  end;


  recResDateHolder = record
    Reservation : integer;
    RoomReservation : integer;

    Arrival : TDate;
    Departure : TDate;
    Status : string;
  end;


  TItemTypeInfo = record
    Itemtype, Description : string;
    VATCode : string;
    VATPercentage : double;
    Price : double;
    valueFormula : String;
  end;

  TInvoiceActionRec = record
    Reservation : integer;
    RoomReservation : integer;
    InvoiceNumber : integer;
    ActionDate : TdateTime;
    ActionID : integer;
    Action : string;
    ActionNote : string;
    Staff : string;
  end;




type
  TGlobalApplication = class(Tobject)
  private
    FLock: TRTLCriticalSection;

    // Program folder
    FqProgramPath : string; // Path to Program

    FqHotelIndex : integer;

    FqHotelList : TstringList;

    FqHotelCode : string;
    FqHotelConnstr : string;
    FqHotelConnstr2 : string;
    FqHotelName : string;
    FqRoomCount : integer;
    FqMeetingsRoomCount : integer;

    FqExpDate : TDate;
    FqDiskSerial : string;

    /// /////////////  INI FILE GLOBALS ////////////////

    // [Diretories]
    // [Data]
    FqCommandText : string;

    // [misc]
    FqLangID : integer;
    FqLogLevel : integer;

    // [System]
    FqFieldSep : char;
    FqFieldlistSep : char;

    FqDecSymbol : char;
    FqDigitGroupSymbol : char;

    FqDateSep : char;
    FqTimeSep : char;

    FqDateFormat : string;
    FqTimeFormat : string;
    FqNullDate : string;
    FqInvoiceFormFileISL : string;
    FqInvoiceFormFileERL : string;

    FqHomeComputerName   : string;
    FqHomeExportPOSType  : integer;

    FqInvoicePrinter : string;
    FqReportPrinter : string;

    FqSnPathXML : string;
    FqSnPathCurrentGuestsXML : string;

    FqInPosMonitorUse    : boolean;
    FqInPosMonitorChkSec : integer;

    FqShowSideBar : boolean;
    FqTempPath: string;
    FqApplicationID: string;
    FqAppSecret: string;
    FqAppKey: string;

     FqConfirmMinuteOfTheDay : integer;
     FqConfirmAuto           : boolean;
    FBackupMachine: boolean;


    // END ///////////  INI FILE GLOBALS ////////////////

    procedure InitializeApplicationGlobals;
    function GetAppSecret: string;
    procedure Lock;
    procedure Unlock;
  public
    qConnected : boolean;
    mHelpFile : string;

    qDebug1 : string;

    qLastID : string;
    qCustID : integer;

    qGridsIniFileName : string;

    qPeriodRowHeight : integer;
    qPeriodColWidth : integer;
    qPeriodColCount : integer;
    qOneDayRowHeight : integer;
    qPeriodPrompt : integer;

    qPeriodDateformat1 : string;
    qPeriodDateformat2 : string;

    qComputerName : string;
    qUser : string;
    qUserName : string;
    qUserPID : string;
    qUserType : string;

    qUserPriv1 : Integer;
    qUserPriv2 : Integer;
    qUserPriv3 : Integer;
    qUserPriv4 : Integer;
    qUserPriv5 : Integer;
    qUserAuthValue1 : Integer;
    qUserAuthValue2 : Integer;
    qUserAuthValue3 : Integer;
    qUserAuthValue4 : Integer;
    qUserAuthValue5 : Integer;
    qLocationPerRoomType : Boolean;
    qNumberOfShifts : Integer;
    qDefaultSendCCEmailToHotel : Boolean;
    qRatesManagedByRoomer : Boolean;
    qRestrictWithdrawalWithoutGuarantee : Boolean;
    qExpandRoomRentOnInvoice : Boolean;

    qStayd3pActive : Boolean;

    qWarnCheckInDirtyRoom,
    qWarnWhenOverbooking,
    qWarnMoveRoomToNewRoomtype : Boolean;


    qNativeCurrency : string;
    qCountry : string;
    qBreakFastItem : string;

    qUserLanguage : integer;
    
    qArrivalDateRulesPrice : boolean;
    qBreakfastInclDefault : boolean;

    qPhoneUseItem : string;
    qPaymentItem : string;
    qRoomRentItem : string;
    qDiscountItem : string;
    qStayTaxItem : string;
    qStayTaxPerPerson : Boolean;

    qLocalRoomRent : string;
    qGreenColor : string;
    qPurpleColor : string;
    qFuchsiaColor : string;

    qUseSetUnclean : boolean;

    qNameOrder : integer;
    qNameOrderPeriod : integer;

    qInvPriceGroup : string;

    qShowHint : boolean;

    qAppIniFile : string;

    qLastImportLogID : integer;


    qColorIsTakenBack : Tcolor;
    qColorIsTakenFont : Tcolor;

    qColorOneDayGridBack : TColor;
    qColorOneDayGridFont : TColor;

    qColorOneDayRoomColBack : TColor;
    qColorOneDayRoomColFont : TColor;


    qColorRoomCleanBack      : TColor;
    qColorRoomUncleanBack    : TColor;
    qColorRoomOutOfOrderBack : TColor;
    qColorRoomOther1Back     : TColor;
    qColorRoomOther2Back     : TColor;
    qColorRoomOther3Back     : TColor;
    qColorRoomCleanFont      : TColor;
    qColorRoomUncleanFont    : TColor;
    qColorRoomOutOfOrderFont : TColor;
    qColorRoomOther1Font     : TColor;
    qColorRoomOther2Font     : TColor;
    qColorRoomOther3Font     : TColor;

    qRoomInvoiceRoomRentIndex,
    qRoomInvoicePosItemIndex,
    qGroupInvoiceRoomRentIndex,
    qGroupInvoicePosItemIndex : Integer;


    qStatusAttr_GuestStaying         : recStatusAttr;
    qStatusAttr_GuestLeavingNextDay  : recStatusAttr;
    qStatusAttr_Departing            : recStatusAttr;
    qStatusAttr_Departed             : recStatusAttr;
    qStatusAttr_Allotment            : recStatusAttr;
    qStatusAttr_Option               : recStatusAttr;
    qStatusAttr_NoShow               : recStatusAttr;
    qStatusAttr_Blocked              : recStatusAttr;
    qStatusAttr_ArrivingOtherLeaving : recStatusAttr;
    qStatusAttr_Order                : recStatusAttr;
    qStatusAttr_Canceled             : recStatusAttr;  //*HJ 140210
    qStatusAttr_Tmp1                 : recStatusAttr;  //*HJ 140210
    qStatusAttr_Tmp2                 : recStatusAttr;  //*HJ 140210
    qStatusAttr_WaitingList          : recStatusAttr;

    qRackCustomer : string;

    qWindowsUser     : string;
    qShowUnpaidInGrid : boolean;


    qstart, qstop : longint;

    qLastConfirm : TdateTime;

    oRooms    : TRooms;

    qExcluteWaitingList : boolean;
    qExcluteAllotment   : boolean;
    qExcluteOrder       : boolean;
    qExcluteDeparted    : boolean;
    qExcluteGuest       : boolean;
    qExcluteBlocked     : boolean;
    qExcluteNoshow      : boolean;

    qDynamicRatesActive : Boolean;

    procedure RefreshRoomList;
    constructor Create;
    destructor Destroy; override;
    procedure ProcessAppIni(aMethod : integer; initialRead : Boolean = false);

//    function OpenZipCodes(var code : string) : boolean;

    function openSelectLanguage(var langName,langExt : string; var langId : integer) : boolean;

    procedure initStatusAttrRec(var rec : recStatusAttr);
    procedure initRecHiddenInfo(var rec : recHiddenInfoHolder);
    procedure init_recItemHolder(var rec : recItemHolder);
    procedure initRecDownPayment(var rec: recDownPayment);


    function strToStatusAttr(const aValue : string) : recStatusAttr;
    function StatusAttrToStr(const aValue : recStatusAttr) : string;

    procedure SetHotelToReportINI(dataname : string);
    procedure RemoveCurrentSecretKey;

    /// /***********************

    function OpenDownPayment(act : TActTableAction; var rec : recDownPayment) : boolean;

    function OpenResMemo(reservation : integer) : boolean;
    function AddAccommodation(var Persons,rooms,nights : integer; var roomPrice : double) : boolean;
//    function AddDiscount(var DiscountType : integer; var Amount : double) : boolean;


    function OpenRemoveRoom(RoomReservation : integer) : boolean;
    function OpenRemoveReservation(Roomreservation : integer) : boolean;
    function ConfirmAllottedReservation(Reservation : integer) : boolean;


    function TestConnection(var Connstr, strResult : string) : boolean;
    function OpenResProblem(var lst : TstringList) : integer;
    function OpenRoomDateProblem(var lst : TStringlist) : integer;

    function StatusStrToResStatus(statusSTR : string) : TReservationState; deprecated 'Use TReservationsStatus.FromResStatus';
    function ResStatusToStatusStr(ResStatus : TReservationState) : string; deprecated 'Use TReservationState.AsReadableString';

    function OpenChangeRate(var Rate : double; Currency : string) : boolean;

    function openGoToRoomAndDate(var aRoom : string; var aDate : TDate) : boolean;

    function OpenOpenInvoicesNew : boolean;


    function openHiddenInfo(Refrence, RefrenceType : integer): boolean;

    procedure updateCurrentGuestList;
    function ChangeLang(newLangId : integer; doUpdate : boolean=true) : boolean;

    procedure RegisterApplication;


  published
    property qHotelList : TstringList read FqHotelList write FqHotelList;

    property qHotelCode : string read FqHotelCode write FqHotelCode;
    property qHotelName : string read FqHotelName write FqHotelName;
    property qRoomCount : integer read FqRoomCount write FqRoomCount;
    property qMeetingsRoomCount : integer read FqMeetingsRoomCount write FqMeetingsRoomCount;

    property qExpDate : TDate read FqExpDate write FqExpDate;
    property qDiskSerial : string read FqDiskSerial write FqDiskSerial;
    property qHotelConnStr : string read FqHotelConnstr write FqHotelConnstr;
    property qHotelConnStr2 : string read FqHotelConnstr2 write FqHotelConnstr2;

    property qHotelIndex : integer read FqHotelIndex write FqHotelIndex;

    property qProgramPath : string read FqProgramPath write FqProgramPath;
    property qProgramExePath : string read FqTempPath write FqTempPath;

    // **  Values in ini
    property qLangID : integer read FqLangID write FqLangID;
    property qLogLevel : integer read FqLogLevel write FqLogLevel;

    property qApplicationID : string read FqApplicationID write FqApplicationID;
    property qAppKey : string read FqAppKey write FqAppKey;
    property qAppSecret : string read GetAppSecret write FqAppSecret;



    property qCommandText : string read FqCommandText write FqCommandText;

    property qFieldSep : char read FqFieldSep write FqFieldSep;
    property qFieldlistSep : char read FqFieldlistSep write FqFieldlistSep;
    property qDecSymbol : char read FqDecSymbol write FqDecSymbol;
    property qDigitGroupSymbol : char read FqDigitGroupSymbol write FqDigitGroupSymbol;

    property qDateSep : char read FqDateSep write FqDateSep;
    property qTimeSep : char read FqTimeSep write FqTimeSep;
    property qDateFormat : string read FqDateFormat write FqDateFormat;
    property qTimeFormat : string read FqTimeFormat write FqTimeFormat;
    property qNullDate : string read FqNullDate write FqNullDate;

   procedure openResDates(reservation, roomReservation : longInt;
                          room: string;
                          var Arrival, departure: Tdate;
                          startIn: longInt);

    property qInvoiceFormFileISL : string read FqInvoiceFormFileISL write FqInvoiceFormFileISL;
    property qInvoiceFormFileERL : string read FqInvoiceFormFileERL write FqInvoiceFormFileERL;

    property qHomeComputerName   : string  read FqHomeComputerName   write FqHomeComputerName  ;
    property qHomeExportPOSType  : integer read FqHomeExportPOSType  write FqHomeExportPOSType ;

    property qInvoicePrinter : string read FqInvoicePrinter write FqInvoicePrinter;
    property qReportPrinter  : string read FqReportPrinter  write FqReportPrinter;

    property qSnPathXML  : string read FqSnPathXML  write FqSnPathXML;
    property qSnPathCurrentGuestsXML  : string read FqSnPathCurrentGuestsXML  write FqSnPathCurrentGuestsXML;

    property qShowSideBar  : boolean read FqShowSideBar  write FqShowSideBar;

    property BackupMachine  : boolean read FBackupMachine  write FBackupMachine;

    property qInPosMonitorUse     : boolean  read  FqInPosMonitorUse     write  FqInPosMonitorUse    ;
    property qInPosMonitorChkSec  : integer  read  FqInPosMonitorChkSec  write  FqInPosMonitorChkSec ;

    property qConfirmMinuteOfTheDay : integer read FqConfirmMinuteOfTheDay     write  FqConfirmMinuteOfTheDay    ;
    property qConfirmAuto           : boolean read FqConfirmAuto             write FqConfirmAuto;

  end;

var
  G : TGlobalApplication;
  _HHwinHwnd : HWND = 0;


// Create and initialize the singelton TGlobalApplication object "g"
procedure OpenApplication;
// Clear and destroy the singleton TGlobalApplicaiton object "g"
procedure CloseApplication;

//function StatusToString(Status : string) : string;
function GetNameCombination(order : Integer; Customer, Guest : String) : String;

function ResStatusToColor(Status : string; var backColor, fontColor : TColor) : boolean;

function StatusToColor(Status : string; var backColor, fontColor : TColor; var fStyle : TFontStyles) : boolean;

function Status2StatusTextForHints(Status : string) : string;
function Status2StatusText(Status : string) : string;

function CombineNames(sName, sSurname : string) : string;
function InvoiceName(InvoiceType : integer; sName, sSurname : string) : string;

function LeftAlign(s : string; iLen : integer) : string;
function RightAligned(s : string; iNum : integer) : string;

function ResObjToBorder(Status : string; ascIndex, descIndex : integer; var BorderColor : TColor; var Left, Top, Right,Bottom : integer) : boolean;
function RoomRowNumber(aGrid : TAdvStringGrid; const sRoom : string; var lastRow : integer; const sRoomType : String = ''; AddIfNeeded : boolean = false) : integer;
procedure FillTheGrid(Grid : TADVStringGrid; sWith : string; iStartCol, iStartRow : integer);
procedure EmptyStringGrid(Grid : TADVStringGrid);
function GridFloatValueFromString(aValue : String) : double;
function GridCellIntValue(aGrid : TAdvStringGrid; ACol, ARow : integer) : integer;
function GridCellFloatValue(aGrid : TAdvStringGrid; ACol, ARow : integer) : double;
procedure RowDelete(aGrid : TAdvStringGrid);
procedure EmptyRow(aGrid : TAdvStringGrid; iRow : integer);
procedure DeleteRow(aGrid : TAdvStringGrid; iRow : integer);
procedure InsertRows(aGrid : TAdvStringGrid; RowIndex, RCount : integer);
procedure ClearRows(aGrid : TAdvStringGrid; RowIndex, RCount : integer);
procedure AutoSizeColumnsInt(aGrid : TAdvStringGrid);
procedure ClearStringGridRows(Grid : TAdvStringGrid; FromRow, RowCount : Integer);
procedure ClearStringGridFromTo(Grid : TAdvStringGrid; FromRow, FromCol : Integer);



implementation
uses
  uD,
  uRubbishCollectors,
  _glob,
//  ufrmSelHotel,
//  uUDL,
//  uHotelListMissing,
  uResProblem,
  uRoomDateProblem,
  uMaidActions,
  uMaidActionsEdit,
  uChangeRate,
  uGoToRoomAndDate,
  uOpenInvoicesNew,
  uMakereseRvationQuick,
  udayNotes,
  uResMemos,
  uAddAccommodation,
  uHiddenInfo,
  uDownPayment,
  uCancelReservation2,
  uCancelReservation3,
  uChangeRRdates,
  ufrmSelLang,
  PrjConst,
  System.UITypes
  ;

function GetNameCombination(order : Integer; Customer, Guest : String) : String;
begin
  case order of
    -1, 0: result := Customer + ', ' + Guest;
    1: result := Guest + ', ' + Customer;
    2: result := Guest;
    3: result := Customer;
  end;
end;

function StatusToColor(Status : string; var backColor, fontColor : TColor; var fStyle : TFontStyles) : boolean;
var
  cRoomStatus : Char;
  Room,
  sRoomStatus : String;
begin
  result := False;
  Room := Status; // TAdvStringGrid(Sender).cells[ACol, ARow];
  if copy(Room, 1, 1) <> '<' then
  begin
    sRoomStatus := g.oRooms.FindRoomStatus(Room);
    if sRoomStatus <> '' then
    begin
      result := True;
      cRoomstatus := sRoomstatus[1];
      backColor := d.colorCodeOfStatus(cRoomStatus);
      case cRoomStatus of
        'C' : begin
//                        TAdvStringGrid(Sender).Canvas.Brush.color := g.qColorRoomCleanBack;
                fontColor := g.qColorRoomCleanFont;
                fStyle := [fsbold];
              end;
        'U' : begin
//                        TAdvStringGrid(Sender).Canvas.Brush.color := g.qColorRoomUnCleanBack;
                fontColor := g.qColorRoomUnCleanFont;
                fStyle := [fsbold];
              end;
        'O' : begin
//                        TAdvStringGrid(Sender).Canvas.Brush.color := g.qColorRoomOutOfOrderBack;
                fontColor := g.qColorRoomOutOfOrderFont;
                fStyle := [fsbold];
              end;
        'R' : begin
                fontColor := clBlack;
                fStyle := [fsbold];
              end;
        'W' : begin
                fontColor := clBlack;
                fStyle := [fsbold];
              end;
        '1' : begin
                backColor := g.qColorRoomOther1Back;
                fontColor := g.qColorRoomOther1Font;
                fStyle := [fsbold];
              end;
        '2' : begin
                backColor := g.qColorRoomOther2Back;
                fontColor := g.qColorRoomOther2Font;
                fStyle := [fsbold];

              end;
        '3' : begin
                backColor := g.qColorRoomOther2Back;;
                fontColor := g.qColorRoomOther3Font;
                fStyle := [fsbold];
              end;

       end;
     end;
  end;
end;

function ResStatusToColor(Status : string; var backColor, fontColor : TColor) : boolean;
var
  state : TReservationState;
  StatusAttr : recStatusAttr;
begin
  State := TReservationState.FromResStatus(Status);
  result := false;
  if length(Status) < 1 then
    exit;

  StatusAttr := state.AsStatusAttribute;
  backColor := StatusAttr.backgroundColor; //clRed;
  fontColor := StatusAttr.fontColor; //clWhite
  result := true;
end;

function Status2StatusTextForHints(Status : string) : string;
var
  ch : char;
begin
  result := '';
  Status := trim(Status);
  if Status = '' then
    exit;

  Status := UpperCase(Status);
  ch := Status[1];

  if ch = 'P' then
	  result := GetTranslatedText('shTx_G_DueToArrive')
  else
    result := Status2StatusText(Status);

end;

function Status2StatusText(Status : string) : string;
var
  state : TReservationState;
begin
  result := '';
  Status := trim(Status);
  if Status = '' then
    exit;

  Status := UpperCase(Status);
  State := TReservationState.FromResStatus(Status);
  result := state.AsStatusText;
end;



{ TGlobalApplication }


function FirstChar(const s : string; DefChr : char) : char;
begin
  result := DefChr;
  if length(s) > 0 then
  begin
    result := s[1];
  end;
end;


procedure TGlobalApplication.RefreshRoomList;
begin
  Lock;
  try
    if oRooms <> nil then
      freeandNil(oRooms);
    oRooms := TRooms.Create(qHotelCode);
  finally
    Unlock;
  end;
end;


procedure TGlobalApplication.initRecDownPayment(var rec: recDownPayment);
begin
  with rec do
  begin
    Reservation     := 0;
    RoomReservation := 0;
    Invoice         := 0;

    Quantity    := 1;
    Amount      := 0.00;
    //Description := 'Downpayment/inn�grei�sla';
    Description := GetTranslatedText('shTx_G_Downpayment');
    Notes       := '';
    PaymentType := '';

    PayDate      := 2;
    payGroup     := '';
    confirmdate  := 2;

    invoiceBalance := 0;

    NotInvoice := False;
  end;
end;

procedure TGlobalApplication.initRecHiddenInfo(var rec: recHiddenInfoHolder);
begin
  with rec do
  begin
    Id := 0;
    Notes := '';
    DeleteOn := 1;
    ViewLog := '';
    Refrence := 0;
    RefrenceType := 0;
  end;
end;



procedure TGlobalApplication.initStatusAttrRec(var rec : recStatusAttr);
begin
  with rec do
  begin
    backgroundColor := clBlack;
    fontColor	      := clBlack;
    isBold          := false;
    isItalic        := false;
    isUnderline     := false;
    isStrikeOut     := false;
  end;
end;



procedure TGlobalApplication.InitializeApplicationGlobals;
var
  theComputerName : array [0 .. 255 + 1] of char;
  itsLength : DWORD;
begin
  Lock;
  try
    // This method should not be called directly from the TGlobalApplication.Create because some of the methods used
    // expect the gloal var "G" to be created

    qProgramPath := GetTempPath + 'Roomer\'; // LocalAppDataPath; // _AddSlash(ExtractFileDir(Application.ExeName));
    qProgramExePath := LocalAppDataPath + 'Roomer\Storage\';
    ForceDirectories(qProgramPath);
    ForceDirectories(qProgramExePath);
    ForceDirectories(qProgramExePath + 'Data');
    qAppIniFile := GetRoomerIniFilename;

    mHelpFile := ExtractFilePath(Paramstr(0)) + '\Help\help01.chm';
    mHelpFile := ExpandFileName(mHelpFile);

    qShowUnpaidInGrid := true;
    qShowHint := true;
    qComputerName := 'NA';
    qUser := '';
    qUserName := '';
    qUserPID := '';
    qUserType := '';
    qUserLanguage := 0;
    qNativeCurrency := '';
    qCountry := '';
    qBreakFastItem := '';

    qHotelIndex := 0;

    qArrivalDateRulesPrice := false;
    qBreakfastInclDefault := false;

    qPhoneUseItem := '';
    qPaymentItem := '';
    qRoomRentItem := '';
    qStayTaxItem := '';
    qStayTaxPerPerson := False;

    qDiscountItem := '';

    qLocalRoomRent := '';
    qGreenColor := '';
    qPurpleColor := '';
    qFuchsiaColor := '';

    qUseSetUnclean := true;

    qNameOrder := 0;
    qNameOrderPeriod := 0;

    qInvPriceGroup := '';

    itsLength := MAX_COMPUTERNAME_LENGTH + 1;

    if (GetComputerName(theComputerName, itsLength)) then
    begin
      qComputerName := trim(string(theComputerName));
    end;

    ProcessAppIni(0, true); // 0=Open 1=CloseGlbApp.SetFasta;

    qGridsIniFileName := qProgramExePath + 'grids.ini';

    qWindowsUser     := _getWindowsUser;

    qColorIsTakenBack := $0099CCFF;
    qColorIsTakenFont := clRed;

    qColorOneDayGridBack := $00DFEFFF;
    qColorOneDayGridFont := clWhite;

    qColorOneDayRoomColBack := $00A8D3FF;
    qColorOneDayRoomColFont := clBlack;



    qColorRoomCleanBack      := clMaroon;
    qColorRoomUncleanBack    := clBlue;
    qColorRoomOutOfOrderBack := clRed;
    qColorRoomOther1Back     := clGreen;
    qColorRoomOther2Back     := clPurple;
    qColorRoomOther3Back     := clFuchsia;

    qColorRoomCleanFont      := clWhite;
    qColorRoomUncleanFont    := clWhite;
    qColorRoomOutOfOrderFont := clWhite;
    qColorRoomOther1Font     := clWhite;
    qColorRoomOther2Font     := clWhite;
    qColorRoomOther3Font     := clWhite;

  finally
    Unlock;
  end;

end;

constructor TGlobalApplication.Create;
begin
  inherited;
  InitializeCriticalSection(FLock);

  FqHotelList := TstringList.Create;
  FBackupMachine := False;
end;

destructor TGlobalApplication.destroy;
begin
  FqHotelList.free;
  oRooms.Free;
  DeleteCriticalSection(Flock);
  inherited;
end;



function TGlobalApplication.TestConnection(var Connstr, strResult : string) : boolean;
var
  dbc : TRoomerConnection;
  i : integer;
  s : string;
  ch : char;
begin
//  strResult := 'Connection failure!';
   strResult := GetTranslatedText('shTx_G_ConnectionFail');

  s := '';
  for i := 1 to length(Connstr) do
  begin
    ch := Connstr[i];
    if ch = '|' then
      ch := ';';
    s := s + ch;
  end;

  Connstr := s;
  dbc := TRoomerConnection.Create(nil);
  try
    dbc.LoginPrompt := false;
    dbc.ConnectionString := Connstr;
    try
      dbc.Open;
      dbc.Close;
      result := true;
//      strResult := 'Connection successful!';
	   strResult := GetTranslatedText('shTx_G_ConnectionSuccess');
    except
      on e : exception do
      begin
        result := false;
        strResult := e.message;
      end;
    end;
  finally
    if dbc.Connected then
      dbc.Close;
    dbc.free;
  end;
end;

procedure TGlobalApplication.Unlock;
begin
  LeaveCriticalSection(Flock);
end;

function decodeSecret(secret : String) : String;
var res : TBytes;
    i : Integer;

begin
  result := '';
  res := DecodeBase64(secret);
  for i := LOW(res) to HIGH(res) do
    result := result + char(res[i]);
end;

procedure parseXml(xmlStr : String; var key, secret : String);
var
  xml: OLEVariant; // IXMLDOMDocument;
  node, node1: OLEVariant; // IXMLDomNode;
  nodeName : String;
  nodes_row: OLEVariant; // IXMLDomNodeList;
  i, l : Integer;
begin
  key := ''; secret := '';
  Coinitialize(nil);
  xml := CreateOleObject('Microsoft.XMLDOM') as IXMLDOMDocument;
  xml.async := False;
  xml.loadXML(xmlStr);
  xml.SetProperty('SelectionNamespaces', 'xmlns:a="http://www.promoir.nl/roomer/application/registration/2014/04"');
  // xmlns:ns10="http://www.promoir.nl/roomer/application/registration/2014/04"
  nodes_row := xml.selectNodes('/a:ApplicationInstanceRegistrationResponse/a:registrationResponse');
  for i := 0 to nodes_row.length - 1 do
  begin
    node := nodes_row.item(i);
    for l := 0 to node.childNodes.length - 1 do
    begin
      node1 := node.childNodes(l);
      nodeName := node1.nodeName;
      // ns3:key
      // 1234567
      if (copy(nodeName, length(nodeName) - 2, 3) = 'key') then
        key := node1.text
      else if (copy(nodeName, length(nodeName) - 5, 6) = 'secret') then
        secret := decodeSecret(node1.text);
    end;
  end;
end;
procedure TGlobalApplication.RegisterApplication;
var res, key, secret : String;
begin
  try
    qApplicationID := 'ROOMERPMS';
    res := d.roomerMainDataSet.RegisterApplication(
              d.roomerMainDataSet.hotelId,
              d.roomerMainDataSet.username,
              d.roomerMainDataSet.password,
              qApplicationID);
    CopyToClipboard(res);
    if res <> '' then
    begin
      parseXml(res, key, secret);
      qAppSecret := secret;
      qAppKey := Key;

      d.roomerMainDataSet.AppKey := Key;;
      d.roomerMainDataSet.AppSecret := secret;
      d.roomerMainDataSet.ApplicationID := qApplicationID;

      ProcessAppIni(1);
    end;
  except
     // Fow now: Ignore
  end;
end;


// ************************************************ \\
// START init Rec

const
  secAppRegistration = 'AppReg';
  indApplicationID = 'Application_ID';
  indAppKey = 'Application_Key';
  indAppSecret = 'Application_Secret';

procedure TGlobalApplication.RemoveCurrentSecretKey;
var
  AppRegGroup : String;
begin
  AppRegGroup := secAppRegistration;
  if Assigned(d) AND Assigned(d.roomerMainDataSet) AND (d.roomerMainDataSet.OpenApiUri <> '') then
     AppRegGroup := d.roomerMainDataSet.OpenApiUri;
  DeleteRegistryLocation('Software\Roomer\PMS\' + GetHotelIniFilename + '\' + AppRegGroup);
  RegisterApplication;
end;

procedure TGlobalApplication.ProcessAppIni(aMethod : integer; initialRead : Boolean = false);
const
  secDiretories = 'Diretories';
  indLocalDataPath = 'Localdata_path';
  indGlobalDataPath = 'Networkdata_path';
  indTemplateDataPath = 'Template_path';

  indComputerName  = 'ComputerName';
  indPosExportType = 'ExportPosType';

  secMisc = 'misc';
  indLangID = 'Language_index';
  indShowSideBar = 'ShowSideBar';
  indBackupMaschine = 'BackupMaschine';
  indlogLevel = 'LogLevel';

  secSystem = 'System';
  indFieldSep = 'FieldSep';
  indFieldlistSep = 'FieldlistSep';
  indDecSymbol = 'DecSymbol';
  indDigitGroupSymbol = 'DigitGroupSymbo';

  indDateSep = 'DateSep';
  indTimeSep = 'TimeSep';
  indDateFormat = 'DateFormat';
  indTimeFormat = 'TimeFormat';
  indNullDate = 'NullDate';
  indinPosMonitorUse     = 'Use_Incoming_Monitor';
  indinPosMonitorChkSec  = 'Seconds_Incoming_monitor';

  secDATA = 'Data';
  indCommandtext = 'CommandText';

  secReports = 'Reports';
  indInvoicePrinter = 'Invoice Printer';
  indReportPrinter = 'Reports Pinter';

  indInvoiceFormFileERL = 'InvoiceFormERL';
  indInvoiceFormFileISL = 'InvoiceFormISL';

  indSnPathXML = 'POS_export_folder';
  indSnPathCurrentGuestsXML = 'POS_CurrentGuests_folder';

  indConfirmMinuteOfTheDay = 'Confirm_Minute_of_the_day';
  indConfirmAuto = 'ConfirmAuto';

var
  reg        : TRoomerRegistryIniFile;
  AppRegGroup : String;
begin
//  reg := TRoomerRegistryIniFile.Create('RoomerLocalSettings_' + g.qHotelCode + '.ini');
  reg := TRoomerRegistryIniFile.Create('RoomerLocalSettings.ini');
  try
    reg.RegIniFile.RootKey := HKEY_CURRENT_USER;
    if (aMethod = 1) OR reg.RegIniFile.KeyExists(GetHotelIniFilename(True)) then
    begin
      FreeAndNil(reg);
      reg := TRoomerRegistryIniFile.Create(GetHotelIniFilename);
    end;

    AppRegGroup := secAppRegistration;
    if Assigned(d) AND Assigned(d.roomerMainDataSet) AND (d.roomerMainDataSet.OpenApiUri <> '') then
       AppRegGroup := d.roomerMainDataSet.OpenApiUri;

    case aMethod of
      0 : // Read
          with reg do
          begin
            if NOT initialRead then
            begin
              // [AppRegistration]
              qApplicationID := ReadString(AppRegGroup, indApplicationID, '');
              qAppKey := ReadString(AppRegGroup, indAppKey, '');
              qAppSecret := ReadString(AppRegGroup, indAppSecret, '');
            end else
            begin
              qAppKey := '';
              qAppSecret := '';
            end;

//            d.roomerMainDataSet.ApplicationID := qApplicationID;
//            d.roomerMainDataSet.AppSecret := qAppSecret;
//            d.roomerMainDataSet.AppKey := qAppKey;

            // [misc]
            FBackupMachine := ReadBool(secMisc, indBackupMaschine, false);
            qLangID := ReadInteger(secMisc, indLangID, 0);
            qShowSideBar := ReadBool(secMisc, indShowSideBar, false);
            qLogLevel := ReadInteger(secMisc, indLogLevel, 0);

            // [FileWatch]
            qFieldSep := FirstChar(Readstring(secSystem, indFieldSep, ';'), ';');
            qFieldlistSep := FirstChar(Readstring(secSystem, indFieldlistSep, '|'), '|');
            qDecSymbol := FirstChar(Readstring(secSystem, indDecSymbol, ','), ',');
            qDigitGroupSymbol := FirstChar(Readstring(secSystem, indDigitGroupSymbol, '.'), '.');
            qDateSep := FirstChar(Readstring(secSystem, indDateSep, '.'), '.');
            qTimeSep := FirstChar(Readstring(secSystem, indTimeSep, ':'), ':');

            qDateFormat := Readstring(secSystem, indDateFormat, 'dd.mm.yy');
            qTimeFormat := Readstring(secSystem, indTimeFormat, 'hh:nn:ss');
            qNullDate := Readstring(secSystem, indNullDate, DateToStr(0));

            qHomeComputerName   := Readstring(secSystem , indComputerName, qComputerName+'_'+qHotelCode);
            qHomeExportPOSType  := ReadInteger(secSystem, indPosExportType, peExportNot);

            qInvoicePrinter := Readstring(secReports, indInvoicePrinter, '');
            qReportPrinter  := Readstring(secReports, indReportPrinter, '');

            qSnPathXML  := Readstring(secSystem, indSnPathXML, qProgrampath);
            qSnPathCurrentGuestsXML  := Readstring(secSystem, indSnPathCurrentGuestsXML, qSnPathXML);

            qinPosMonitorUse    := ReadBool(secSystem, indinPosMonitorUse   , false);
            qinPosMonitorChkSec := ReadInteger(secSystem, indinPosMonitorChkSec, 15);

            qInvoiceFormFileISL := Readstring(secReports, indInvoiceFormFileISL, _AddSlash(G.qProgramPath) + 'islInvoice.fr3');
            qInvoiceFormFileERL := Readstring(secReports, indInvoiceFormFileERL, _AddSlash(G.qProgramPath) + 'erlInvoice.fr3');

            qConfirmMinuteOfTheDay := ReadInteger(secSystem,indConfirmMinuteOfTheDay,0);
            qConfirmAuto := ReadBool(secSystem,indConfirmAuto,false);

          end;

      1 : // Write
          with reg do
          begin
            if NOT initialRead then
            begin
              // [AppRegistration]
              WriteString(AppRegGroup, indApplicationID, qApplicationID);
              WriteString(AppRegGroup, indAppKey, qAppKey);
              WriteString(AppRegGroup, indAppSecret, qAppSecret);
            end;

            // [misc]
            WriteBool(secMisc, indBackupMaschine, FBackupMachine);
            WriteInteger(secMisc, indLangID, qLangID);
            WriteInteger(secMisc, indLogLevel, qLogLevel);
            WriteBool(secMisc, indShowSideBar, qShowSideBar);

            // [Data]
//            Writestring(secDATA, indCommandtext, qCommandText);

            // [System]
            Writestring(secSystem, indFieldSep, qFieldSep);
            Writestring(secSystem, indFieldlistSep, qFieldlistSep);
            Writestring(secSystem, indDecSymbol, qDecSymbol);
            Writestring(secSystem, indDigitGroupSymbol, qDigitGroupSymbol);

            Writestring(secSystem, indDateSep, qDateSep);
            Writestring(secSystem, indTimeSep, qTimeSep);
            Writestring(secSystem, indDateFormat, qDateFormat);
            Writestring(secSystem, indTimeFormat, qTimeFormat);

            if qNullDate = '' then
              qNullDate := DateToStr(0);
            Writestring(secSystem, indNullDate, qNullDate);

            Writestring(secSystem , indComputerName, qHomeComputerName );
            WriteInteger(secSystem, indPosExportType,qHomeExportPOSType);

            WriteBool(secSystem, indinPosMonitorUse      ,qinPosMonitorUse    );
            WriteInteger(secSystem, indinPosMonitorChkSec,qinPosMonitorChkSec );

            Writestring(secReports, indInvoicePrinter, qInvoicePrinter);
            Writestring(secReports, indReportPrinter, qReportPrinter);

            Writestring(secSystem, indSnPathXML, qSnPathXML);
            Writestring(secSystem, indSnPathCurrentGuestsXML, qSnPathCurrentGuestsXML);

            Writestring(secReports, indInvoiceFormFileISL, qInvoiceFormFileISL);
            Writestring(secReports, indInvoiceFormFileERL, qInvoiceFormFileERL);

            writeInteger(secSystem,indConfirmMinuteOfTheDay,qConfirmMinuteOfTheDay);
            WriteBool(secSystem,indConfirmAuto,qConfirmAuto);
          end;
    end;
  finally
    reg.Free;
  end;
end;

procedure TGlobalApplication.SetHotelToReportINI(dataname : string);
var
  Fname : string;
begin
  Fname := ExtractFilePath(PAramstr(0)) + 'data.udl';
  _create_UDLFile(Fname, qCommandText);

  with TRoomerRegistryIniFile.Create('Connect.ini') do
    try
      // Setja defaults
      WriteInteger(dataname, 'Local', 1);
      Writestring(dataname, 'Connection', 'File Name=data.udl');
      Writestring(dataname, 'BoolFalse', '0');
      Writestring(dataname, 'BoolTrue', '1');
      Writestring(dataname, 'Type', 'SQL7');
      Writestring(dataname, 'ConCat', '&');
      Writestring(dataname, 'Distinct', 'Distinct');
      Writestring(dataname, 'DateDiff', 'DATEDIFF');
      Writestring(dataname, 'CDate', 'CDATE');
      Writestring(dataname, 'SubStr', 'SUBSTRING');
      Writestring('DBRelated', 'DefaultMachine', dataname);
      Writestring('DBRelated', 'DataList', dataname);
      Writestring('DBRelated', 'DataNames', 'Hotel1');
    finally
      free;
    end;
end;

function TGlobalApplication.GetAppSecret: string;
begin
  if FqAppSecret = ''  then
    RegisterApplication;

  Result := FqAppSecret;
end;

procedure TGlobalApplication.openResDates(reservation, roomReservation
  : longInt; room: string; var Arrival, departure: Tdate; startIn: longInt);
begin
  Application.CreateForm(TfrmChangeRRdates, frmChangeRRdates);
  try
    frmChangeRRdates.zReservation := reservation;
    frmChangeRRdates.zRoomReservation := roomReservation;
    frmChangeRRdates.zStartIn := startIn;
    frmChangeRRdates.zRoom := room;
    frmChangeRRdates.zArrival := Arrival;
    frmChangeRRdates.zDeparture := departure;

    frmChangeRRdates.ShowModal;
    if frmChangeRRdates.ModalResult = mrOK then
    begin
      Arrival := frmChangeRRdates.zArrival;
      departure := frmChangeRRdates.zDeparture;

    end;
  finally
    frmChangeRRdates.free;
  end;
end;



function TGlobalApplication.OpenOpenInvoicesNew : boolean;
begin
  result := false;

  Application.CreateForm(TfrmOpenInvoicesNew, frmOpenInvoicesNew);
//  frmOpenInvoicesNew := TfrmOpenInvoicesNew.Create(Application);
  try
    // frmHotelInfo.zCode := Code;
    frmOpenInvoicesNew.ShowModal;
    if frmOpenInvoicesNew.modalresult = mrOk then
    begin
      result := true;
      // Code := frmZipCodes.zCode;
    end
    else
    begin
      // Code := '';
    end;
  finally
    frmOpenInvoicesNew.Free;
  end;

end;

function TGlobalApplication.ChangeLang(newLangId : integer; doUpdate : boolean=true) : boolean;
begin
  result := false;
  if NewLangId = g.qUserLanguage then exit;
  result := true;

  g.qUserLanguage := newlangID;

  if doUpdate then
  begin
    d.UpdateUsersLanguage(g.qUser, g.qUserLanguage);
  end;

end;

function TGlobalApplication.openSelectLanguage(var langName,langExt : string; var langId : integer) : boolean;
begin

  result := false;
  Application.CreateForm(TfrmSelLang, frmSelLang);
  try
    frmSelLang.zLangId   := langId;
    frmSelLang.zLangName := langName;
    frmSelLang.zLangExt  := '';
    frmSelLang.ShowModal;

    if frmSelLang.modalResult = mrOK then
    begin
      langName := frmSelLang.zLangName;
      langExt  := frmSelLang.zLangExt;
      langId   := frmSelLang.zLangID;
    end;
  finally
    freeandnil(frmSelLang);
  end;
end;




/// start - Open and Close Application;
procedure OpenApplication;
begin
  // --
  G := TGlobalApplication.Create;
  G.InitializeApplicationGlobals;
end;


procedure CloseApplication;
begin
  // --
  G.ProcessAppIni(1); // 0=Open 1=CloseGlbApp.SetFasta;
  G.free;
end;
/// end - Open and Close Application;

Procedure TGlobalApplication.updateCurrentGuestlist;
begin
  if frmDayNotes.pageMain.ActivePage = frmDayNotes.tabCurrentGuests then
  begin
    frmDayNotes.GetCurrentGuests(date);
  end;


  if ctrlGetInteger('AccountType') = 3 then
  begin
    d.GetCurrentGuestsXML;
  end;
end;

/// //////////////////////////////////////////////////
/// //////////////////////////////////////////////////


function TGlobalApplication.OpenDownPayment(act : TActTableAction; var rec : recDownPayment) : boolean;
begin
  result := false;
  frmDownPayment := TfrmDownPayment.Create(frmDownPayment);
  try
    frmDownPayment.rec.Reservation     :=  rec.Reservation     ;
    frmDownPayment.rec.RoomReservation :=  rec.RoomReservation ;
    frmDownPayment.rec.Invoice         :=  rec.Invoice         ;
    frmDownPayment.rec.Quantity        :=  rec.Quantity        ;
    frmDownPayment.rec.Amount          :=  rec.Amount          ;
    frmDownPayment.rec.Description     :=  rec.Description     ;
    frmDownPayment.rec.Notes           :=  rec.Notes           ;
    frmDownPayment.rec.PaymentType     :=  rec.PaymentType     ;
    frmDownPayment.rec.confirmdate     :=  rec.confirmdate     ;
    frmDownPayment.rec.payGroup        :=  rec.payGroup        ;
    frmDownPayment.rec.payDate         :=  rec.payDate         ;
    frmDownPayment.rec.InvoiceBalance  :=  rec.InvoiceBalance  ;
    frmDownPayment.rec.NotInvoice      :=  rec.NotInvoice      ;


    frmDownPayment.ShowModal;
    if frmDownPayment.modalresult = mrOk then
    begin
      rec.Reservation     :=  frmDownPayment.rec.Reservation       ;
      rec.RoomReservation :=  frmDownPayment.rec.RoomReservation   ;
      rec.Invoice         :=  frmDownPayment.rec.Invoice           ;
      rec.Quantity        :=  frmDownPayment.rec.Quantity          ;
      rec.Amount          :=  frmDownPayment.rec.Amount            ;
      rec.Description     :=  frmDownPayment.rec.Description       ;
      rec.Notes           :=  frmDownPayment.rec.Notes             ;
      rec.PaymentType     :=  frmDownPayment.rec.PaymentType       ;
      rec.payGroup        :=  frmDownPayment.rec.payGroup          ;
      rec.confirmdate     :=  frmDownPayment.rec.confirmdate       ;
      rec.PayDate         :=  frmDownPayment.rec.paydate           ;
      rec.InvoiceBalance         := frmDownPayment.rec.InvoiceBalance  ;

      result := true;
    end
    else
    begin
      initRecDownPayment(rec);
    end;
  finally
    freeandNil(frmDownPayment);
  end;
end;

function TGlobalApplication.OpenRemoveRoom(Roomreservation : integer) : boolean;
var
  CancelStaff : string;
  CancelReason  : string;
  CancelInformation : string;
  CancelType : integer;
begin
  result := false;
  frmCancelReservation2 := TfrmCancelReservation2.Create(frmCancelReservation2);
  try
    frmCancelReservation2.zRoomreservation := Roomreservation            ;

    frmCancelReservation2.ShowModal;
    if frmCancelReservation2.modalresult = mrOk then
    begin
      CancelStaff        := g.qUser;
      CancelReason       := frmCancelReservation2.zReason;
      CancelInformation  := frmCancelReservation2.zInformation;
      CancelType         := frmCancelReservation2.zType;
      d.RemoveRoomReservation(RoomReservation,CancelStaff,cancelreason,CancelInformation,CancelType,true, true, true);
      result := true;
    end
  finally
    frmCancelReservation2.free;
    frmCancelReservation2 := nil;
  end;
end;

function TGlobalApplication.ConfirmAllottedReservation(Reservation : integer) : boolean;
var s : String;
begin
  Result := false;
  if MessageDlg(GetTranslatedText('shTxThisConfirmAllottedBooking'), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  s := format('UPDATE reservations r ' +
       '       JOIN roomreservations rr ON rr.Reservation=r.Reservation ' +
       '       JOIN roomsdate rd ON rd.RoomReservation=rr.RoomReservation, ' +
       '       (SELECT ''P'' AS status, ''A'' AS Alotments, ''O'' AS Waitinglists, ''B'' AS Blockings) AS _status ' +
       'SET r.Status=_status.status, ' +
       '    rr.Status=_status.status, ' +
       '    rd.ResFlag=_status.status ' +
       'WHERE r.Reservation=%d ' +
//       'AND r.Status IN (_status.Alotments, _status.WaitingLists, _status.Blockings) ' +
//       'AND rr.Status IN (_status.Alotments, _status.WaitingLists, _status.Blockings) ' +
       'AND rd.ResFlag IN (_status.Alotments, _status.WaitingLists, _status.Blockings)', [Reservation]);

  Result := (d.roomerMainDataSet.DoCommand(s) > 0);
end;

function TGlobalApplication.OpenRemoveReservation(RoomReservation : integer) : boolean;
var
  CancelStaff : string;
  CancelReason  : string;
  CancelInformation : string;
  CancelType : integer;
  i : integer;
  lstRoomReservations : TstringList;
  reservation : integer;

begin
  screen.Cursor := crHourglass;
  try
    result := false;
    lstRoomReservations := Tstringlist.Create;
    try
      frmCancelReservation3 := TfrmCancelReservation3.Create(frmCancelReservation3);
      try
        frmCancelReservation3.zRoomreservation := RoomReservation            ;
        frmCancelReservation3.ShowModal;
        if frmCancelReservation3.modalresult = mrOk then
        begin
          CancelStaff        := g.qUser;
          CancelReason       := frmCancelReservation3.zReason;
          CancelInformation  := frmCancelReservation3.zInformation;
          CancelType         := frmCancelReservation3.zType;
          Reservation        := frmCancelReservation3.zReservation;

          if frmCancelReservation3.zAll then
          begin
            d.RemoveReservation(Reservation,CancelStaff,CancelReason,CancelInformation,CancelType);
          end else
          begin
           // if MessageDlg('Delete selected rooms from reservation ?'+chr(10)+'Rooms : '+frmCancelReservation3.zRooms, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
			      if MessageDlg(format(GetTranslatedText('shTx_G_DeleteRooms'), [frmCancelReservation3.zRooms]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
              _strTokenToStrings(frmCancelReservation3.zRoomReservations,';',lstRoomreservations);
              for i :=  0 to LstRoomReservations.Count - 1 do
              begin
                roomReservation := strToInt(lstRoomReservations[i]);
                d.RemoveRoomReservation(RoomReservation,CancelStaff,cancelreason,CancelInformation,CancelType,true, true, false);
              end;
            end;
          end;
          result := true;
        end
      finally
        frmCancelReservation3.free;
        frmCancelReservation3 := nil;
      end;
    finally
      freeandNil(lstRoomreservations);
    end;
  finally
    screen.Cursor := crDefault;
  end;
end;


function TGlobalApplication.AddAccommodation(var Persons,rooms,nights : integer; var roomPrice : double) : boolean;
begin
  result := false;
  frmAddAccommodation := TfrmAddAccommodation.Create(nil);
  try
    frmAddAccommodation.zPersons   :=  Persons;
    frmAddAccommodation.zRooms     :=  Rooms;
    frmAddAccommodation.zNights    :=  Nights;
    frmAddAccommodation.zRoomPrice :=  roomPrice;

    frmAddAccommodation.ShowModal;
    if frmAddAccommodation.modalresult = mrOk then
    begin
      result := true;
      Persons   := frmAddAccommodation.zPersons   ;
      Rooms     := frmAddAccommodation.zRooms     ;
      Nights    := frmAddAccommodation.zNights    ;
      roomPrice := frmAddAccommodation.zRoomPrice ;
    end
    else
    begin
    end;
  finally
    frmAddAccommodation.free;
    frmAddAccommodation := nil;
  end;
end;

function TGlobalApplication.OpenResMemo(reservation : integer) : boolean;
begin
  result := false;
  frmResMemos := TfrmResMemos.Create(frmResMemos);
  try
    frmResMemos.zReservation   :=  reservation;

    frmResMemos.ShowModal;
    if frmResMemos.modalresult = mrOk then
    begin
      result := true;
    end
    else
    begin
//       Customer := '';
    end;
  finally
    frmResMemos.free;
    frmResMemos := nil;
  end;
end;



function TGlobalApplication.openHiddenInfo(Refrence, RefrenceType : integer): boolean;
begin
  frmHiddenInfo := TfrmHiddenInfo.Create(frmHiddenInfo);
  try
    frmHiddenInfo.zRefrence := Refrence;
    frmHiddenInfo.zRefrenceType := RefrenceType;
    frmHiddenInfo.ShowModal;
    if frmHiddenInfo.modalresult = mrOK then
    begin
      result := true;
    end
    else
    begin
      result := false; // but who cares
    end;
  finally
    frmHiddenInfo.free;
    frmHiddenInfo := nil;
  end;
end;

function TGlobalApplication.strToStatusAttr(const aValue : string) : recStatusAttr;
var
  sTmp : string;

begin
  initStatusAttrRec(result);

  sTmp := _StrTokenAt(aValue,';',0);
  if sTmp <> '' then
  begin
    try
      result.backgroundColor := stringToColor(sTmp);
    except
    end;
  end;


  sTmp := _StrTokenAt(aValue,';',1);
  if sTmp <> '' then
  begin
    try
      result.fontColor := stringToColor(sTmp);
    except
    end;
  end;


  sTmp := _StrTokenAt(aValue,';',2);
  if sTmp <> '' then
  begin
    try
      result.isBold := strTobool(sTmp);
    except
    end;
  end;


  sTmp := _StrTokenAt(aValue,';',3);
  if sTmp <> '' then
  begin
    try
      result.isItalic := strTobool(sTmp);
    except
    end;
  end;


  sTmp := _StrTokenAt(aValue,';',4);
  if sTmp <> '' then
  begin
    try
      result.isUnderline := strTobool(sTmp);
    except
    end;
  end;

  sTmp := _StrTokenAt(aValue,';',5);
  if sTmp <> '' then
  begin
    try
      result.isStrikeOut := strTobool(sTmp);
    except
    end;
  end;
end;



function TGlobalApplication.StatusAttrToStr(const aValue : recStatusAttr) : string;
var
  s : string;
begin
  s := '';
  s := s+colorToString(aValue.backgroundColor)+';';
  s := s+colorToString(aValue.fontColor)+';';
  s := s+boolToStr(aValue.isBold)+';';
  s := s+boolToStr(aValue.isItalic)+';';
  s := s+boolToStr(aValue.isUnderline)+';';
  s := s+boolToStr(aValue.isStrikeOut)+';';
  result := s;
end;

// **
function TGlobalApplication.OpenResProblem(var lst : TstringList) : integer;
begin
  frmResProblem := TfrmResProblem.Create(frmResProblem);
  try
    frmResProblem.lst.Assign(lst);
    frmResProblem.ShowModal;
    if frmResProblem.modalresult = mrOk then
    begin
      result := frmResProblem.rgrOption2.ItemIndex;
    end
    else
    begin
      result := frmResProblem.rgrOption2.ItemIndex;
    end;
  finally
    frmResProblem.free;
    frmResProblem := nil;
  end;
end;

function TGlobalApplication.OpenRoomDateProblem(var lst : Tstringlist) : integer;
begin
  frmRoomDateProblem := TfrmRoomDateProblem.Create(frmRoomDateProblem);
  try
    frmRoomDateProblem.lst.Assign(lst);
    frmRoomDateProblem.ShowModal;
    if frmRoomDateProblem.modalresult = mrOk then
    begin
      result := frmRoomDateProblem.rgrOption.ItemIndex;
    end
    else
    begin
      result := frmRoomDateProblem.rgrOption.ItemIndex;
    end;
  finally
    frmRoomDateProblem.free;
    frmRoomDateProblem := nil;
  end;
end;


function TGlobalApplication.OpenChangeRate(var Rate : double; Currency : string) : boolean;
begin
  result := false;

  frmChangeRate := TfrmChangeRate.Create(frmChangeRate);
  try
    frmChangeRate.zRate := Rate;
    frmChangeRate.zCurrency := Currency;
    frmChangeRate.ShowModal;
    Rate := frmChangeRate.zRate;
    if frmChangeRate.modalresult = mrOk then
    begin
      result := true;
    end;
  finally
    frmChangeRate.free;
    frmChangeRate := nil;
  end;
end;


procedure TGlobalApplication.init_recItemHolder(var rec : recItemHolder);
begin
  with rec do
  begin
    Item := '';
    Description :='';
    Price := 0.00;
    Itemtype := '';
    AccountKey := '';
    Hide := false;
    SystemItem := false;
    RoomRentitem := false;
    ReservationItem := false;
    Currency := '';
  end;
end;


procedure TGlobalApplication.Lock;
begin
  EnterCriticalSection(FLock);
end;

function TGlobalApplication.openGoToRoomAndDate(var aRoom : string; var aDate : TDate) : boolean;
begin
  result := false;
  frmGoToRoomAndDate := TfrmGoToRoomAndDate.Create(frmGoToRoomAndDate);
  try
    frmGoToRoomAndDate.zDate := aDate;
    frmGoToRoomAndDate.zRoom := aRoom;

    frmGoToRoomAndDate.ShowModal;
    if frmGoToRoomAndDate.modalresult = mrOk then
    begin
      aRoom := frmGoToRoomAndDate.zRoom;
      aDate := frmGoToRoomAndDate.zDate;
      result := true;
    end
    else
    begin
      aRoom := '';
      aDate := Date;
    end;
  finally
    frmGoToRoomAndDate.free;
    frmGoToRoomAndDate := nil;
  end;
end;

function TGlobalApplication.StatusStrToResStatus(statusSTR : string) : TReservationState;
begin
//  result := rsUnKnown;
//  statusSTR := trim(statusSTR);
  result := TReservationState.FromResStatus(statusStr);
//  if statusSTR = 'P' then
//    result := rsReservation
//  else if statusSTR = 'G' then
//    result := rsGuests
//  else if statusSTR = STATUS_CHECKED_OUT then
//    result := rsDeparted
//  else if statusSTR = 'R' then
//    result := rsReserved
//  else if statusSTR = 'O' then
//    result := rsOptionalBooking
//  else if statusSTR = 'A' then
//    result := rsAlotment
//  else if statusSTR = 'N' then
//    result := rsNoShow
//  else if statusSTR = 'B' then
//    result := rsBlocked
//  else if statusSTR = 'C' then
//    result := rsCancelled
//  else if statusSTR = 'W' then  //*HJ 140206
//    result := rsTmp1
//  else if statusSTR = 'Z' then   //*HJ 140206
//    result := rsAwaitingPayment
end;

function TGlobalApplication.ResStatusToStatusStr(ResStatus : TReservationState) : string;
begin
  Result := ResStatus.AsReadableString;
//  result := '';
//  (* if ResStatus = rsReservations then result := 'Reservation';
//  if ResStatus = rsGuests then result := 'Guest';
//  if ResStatus = rsDeparted then result := 'Departed';
//  if ResStatus = rsReserved then result := 'Reserved';
//  if ResStatus = rsOverbooked then result := 'Overbooked';
//  if ResStatus = rsAlotment then result := 'Allotment';
//  if ResStatus = rsNoShow then result := 'NoShow';
//  if ResStatus = rsBlocked then result := 'Blocked';
//  if ResStatus = rsDeparting then result := 'Departing';
//  if ResStatus = rsCurrent then result := 'Current'; *)
//  if ResStatus = rsReservation then result := GetTranslatedText('shTx_G_Reservation');
//  if ResStatus = rsGuests then result := GetTranslatedText('shTx_G_Guest');
//  if ResStatus = rsDeparted then result := GetTranslatedText('shTx_G_Departed');
//  if ResStatus = rsReserved then result := GetTranslatedText('shTx_G_Reserved');
//  if ResStatus = rsWaitingList then result := GetTranslatedText('shTx_G_Overbooked');
//  if ResStatus = rsAllotment then result := GetTranslatedText('shTx_G_Alotment');
//  if ResStatus = rsNoShow then result := GetTranslatedText('shTx_G_NoShow');
//  if ResStatus = rsBlocked then result := GetTranslatedText('shTx_G_Blocked');
//  if ResStatus = rsCancelled then result := GetTranslatedText('shTx_G_Canceled'); //*HJ 140206
//  if ResStatus = rsTmp1 then result := GetTranslatedText('shTx_G_Tmp1');  //*HJ 140206
//  if ResStatus = rsAwaitingPayment then result := GetTranslatedText('shTx_G_aWaitingPayment'); //*HJ 140206
end;



function ResObjToBorder(Status : string; ascIndex, descIndex : integer; var BorderColor : TColor; var Left, Top, Right,
  Bottom : integer) : boolean;

var
  ch : char;
begin
  Status := trim(Status);
  result := false;
  if length(Status) < 1 then
    exit;
  ch := Status[1];

  if (ascIndex = 0) and (descIndex = 0) then
  begin
    Left := 1;
    Top := 1;
    Right := 1;
    Bottom := 1;
  end
  else if ascIndex = 0 then
  begin
    Left := 1;
    Top := 1;
    Right := 1;
    Bottom := 1;
  end
  else if descIndex = 0 then
  begin
    Left := 1;
    Top := 1;
    Right := 1;
    Bottom := 1;
  end
  else
  begin
    Left := 1;
    Top := 1;
    Right := 1;
    Bottom := 1;
  end;

  case ch of
    'P' :
      begin
        // BackColor := clRed;
        BorderColor := clWhite;
        result := true;
      end;
    'G' :
      begin
        // backColor := clGreen;
        BorderColor := clWhite;
        result := true;
      end;
    STATUS_CHECKED_OUT :
      begin
        // backColor := clTeal;
        BorderColor := clWhite;
        result := true;
      end;
    'O' :
      begin
        // backColor := clYellow;
        BorderColor := clBlack;
        result := true;
      end;
    'L' :
      begin
        // backColor := clYellow;
        BorderColor := clBlack;
        result := true;
      end;
    'N' :
      begin
        // backColor := clRed;
        BorderColor := clYellow;
        result := true;
      end;
    'A' :
      begin
        // backColor := clWhite;
        BorderColor := clRed;
        result := true;
      end;
    'B' :
      begin
        // backColor := clWhite;
        BorderColor := clWhite;
        result := true;
      end;
    'C' :
      begin
        // backColor := clWhite;
        BorderColor := clWhite;
        result := true;
      end;
    'Z' :
      begin
        // backColor := clWhite;
        BorderColor := clWhite;
        result := true;
      end;
    'W' :
      begin
        // backColor := clWhite;
        BorderColor := clWhite;
        result := true;
      end;

    else
      begin
        BorderColor := clBlue;
        // fontColor := clYellow;
        result := true;
      end;
    end;
end;

procedure ClearStringGridRows(Grid : TAdvStringGrid; FromRow, RowCount : Integer);
begin
//  for iRow := FromRow to FromRow + RowCount - 1 do
//     for iCol := 0 to Grid.ColCount - 1 do
//      if Grid.Objects[iCol, iRow] IS TRoomCell then
//        try
//          TRoomCell(Grid.Objects[iCol, iRow]).Free;
//          Grid.Objects[iCol, iRow] := nil;
//        Except end;
//
  grid.ClearRows(FromRow, RowCount);
end;

procedure ClearStringGridFromTo(Grid : TAdvStringGrid; FromRow, FromCol : Integer);
//var iRow, iCol : integer;
begin
//  for iRow := FromRow to Grid.RowCount - 1 do
//    for iCol := FromCol to Grid.ColCount - 1 do
//      if Grid.Objects[iCol, iRow] IS TRoomCell then
//        try
//          TRoomCell(Grid.Objects[iCol, iRow]).Free;
//          Grid.Objects[iCol, iRow] := nil;
//        Except end;
end;



procedure FillTheGrid(Grid : TADVStringGrid; sWith : string; iStartCol, iStartRow : integer);
var
  i, l : integer;
begin
  // --
  ClearStringGridFromTo(Grid, iStartRow, iStartCol);
  for l := iStartRow to Grid.RowCount - 1 do
  begin
    for i := iStartCol to Grid.ColCount - 1 do
    begin
      Grid.Cells[i, l] := sWith;
    end;
  end;
end;

procedure EmptyStringGrid(Grid : TADVStringGrid);
var
  i, l : integer;
begin
  for l := 1 to Grid.RowCount - 1 do
  begin
    for i := 0 to Grid.ColCount - 1 do
    begin
      Grid.Cells[i, l] := '';
    end;
  end;
  Grid.RowCount := 2;
  Grid.FixedRows := 1;
end;

/// <summary>
///   Locate the row in the grid where sRoom is located, determined by the roomnumber in column 0 and return the rownumber. <br />
///  If the room is not found and AddIfNEeded is true than the lastrow of the grid will be set to room and roomtype, <br />
///  if a new room is added to the grid, lastrow will be increased
/// </summary>
function RoomRowNumber(aGrid : TAdvStringGrid; const sRoom : string; var lastRow : integer; const sRoomType : String = ''; AddIfNeeded : boolean = false) : integer;
var
  i : integer;
begin
  // --
  result := - 1;
  for i := 1 to aGrid.RowCount - 1 do
  begin
    if aGrid.Cells[0, i] = sRoom then
    begin
      result := i;
      break;
    end;
  end;
  if AddIfNeeded then
    if result = -1 then
    begin
      inc(lastRow);
      aGrid.RowCount := lastRow; // aGrid.RowCount + 1;
      i := aGrid.RowCount - 1;
      aGrid.Cells[0, i] := sRoom;
      aGrid.Cells[1, i] := sRoomType;
      result := i;
    end;
end;

function DateToStrByType(dtDate : TdateTime) : string;
begin
  result := _DateToDBDate(dtDate,true)
end;



function CombineNames(sName, sSurname : string) : string;
begin
  sName := trim(sName);
  sSurname := trim(sSurname);

  if sName = '' then
  begin
    result := sSurname;
    exit;
  end;

  if sSurname = '' then
  begin
    result := sName;
    exit;
  end;

  result := sSurname + ', ' + sName;
end;

function InvoiceName(InvoiceType : integer; sName, sSurname : string) : string;
begin
  sName := trim(sName);
  sSurname := trim(sSurname);

  if InvoiceType = 0 then
  begin
    result := sSurname;
    exit;
  end;
  result := sName;
end;


function RightAligned(s : string; iNum : integer) : string;
var
  i : integer;
begin
  for i := 1 to iNum - length(s) do
    s := ' ' + s;
  result := s;
end;

function GridCellIntValue(aGrid : TAdvStringGrid; ACol, ARow : integer) : integer;
var
  s : string;
begin
  // --
  result := 0;
  s := trim(aGrid.Cells[ACol, ARow]);
  if s='' then exit;

  try
    result := Trunc(_StrToFloat(s));
  except
    result := 0;
  end;
end;

function GridFloatValueFromString(aValue : String) : double;
var
  s : string;
begin
  // --
  result := 0.00;
  s := trim(aValue);
  if s='' then exit;

  try
    result := _StrToFloat(s);
  except
    result := 0.00;
  end;
end;

function GridCellFloatValue(aGrid : TAdvStringGrid; ACol, ARow : integer) : double;
begin
  // --
  result := GridFloatValueFromString(aGrid.Cells[ACol, ARow]);
end;

procedure CutRange(aGrid : TAdvStringGrid);
var
  r1, c1, r2, c2, r, c : integer;

  list : TstringList;
  flist : TstringList;
begin
  c1 := aGrid.Selection.Left;
  r1 := aGrid.Selection.Top;
  c2 := aGrid.Selection.Right;
  r2 := aGrid.Selection.Bottom;

  if not ((c1 >= 0) and (r1 >= 0) and (c2 >= c1) and (r2 >= r1)) then
    exit;

  list := TstringList.Create;
  flist := TstringList.Create;

  for r := r1 to r2 do
  begin
    flist.Clear;
    for c := c1 to c2 do
    begin
      flist.append(aGrid.Cells[c, r]);
      aGrid.Cells[c, r] := '';
    end;
    list.append(flist.commatext);
  end;

  CopyToClipboard(list.text);
  flist.free;
  list.free;
end;

procedure PasteRange(aGrid : TAdvStringGrid);
var
  r1, c1, r2, c2, r, c, i, j : integer;

  list, flist : TstringList;
begin
  if not ClipboardHasFormat(CF_TEXT) then
    exit;

  if not ((aGrid.col >= 0) and (aGrid.row >= 0)) then
    exit;

  list := TstringList.Create;
  flist := TstringList.Create;
  list.text := ClipboardText;

  if list.Count > 0 then
  begin
    c1 := aGrid.col;
    r1 := aGrid.row;
    flist.commatext := list[0];
    c2 := c1 + flist.Count - 1;
    r2 := r1 + list.Count - 1;

    if c2 > (aGrid.ColCount - 1) then
      aGrid.ColCount := c2 + 1;
    if r2 > (aGrid.RowCount - 1) then
      aGrid.RowCount := r2 + 1;
    j := 0;

    for r := r1 to r2 do
    begin
      flist.commatext := list[j];
      i := 0;
      for c := c1 to c2 do
      begin
        aGrid.Cells[c, r] := flist[i];
        inc(i);
      end;
      inc(j);
    end;
  end;
  flist.free;
  list.free;
  AutoSizeColumnsInt(aGrid);
end;

procedure EmptyRow(aGrid : TAdvStringGrid; iRow : integer);
var
  i : integer;
begin
  if aGrid.HasCheckBox(0, iRow) then
    aGrid.RemoveCheckBox(0, iRow);
  for i := 0 to aGrid.ColCount - 1 do
  begin
    aGrid.Cells[i, iRow] := '';
    aGrid.Objects[i, iRow] := nil;
  end;
end;

procedure DeleteRow(aGrid : TAdvStringGrid; iRow : integer);
var
  i, l : integer;
begin
  EmptyRow(aGrid, iRow);
  if (iRow = 1) and (aGrid.RowCount = 2) then
  begin
  end
  else
  begin
    for i := iRow + 1 to aGrid.RowCount - 1 do
    begin
      for l := 0 to aGrid.ColCount - 1 do
      begin
        aGrid.Cells[l, i - 1] := aGrid.Cells[l, i];
        aGrid.Objects[l, i - 1] := aGrid.Objects[l, i];
      end;
    end;
    aGrid.RowCount := aGrid.RowCount - 1;
  end;
end;

procedure RowDelete(aGrid : TAdvStringGrid);
var
  ARow : integer;
begin
  with aGrid do
  begin
    ARow := row;
    if RowCount > 2 then
    begin
      DeleteRow(aGrid, row);
      if ARow < RowCount then
        row := ARow;
    end;
  end;
end;

procedure ClearRect(aGrid : TAdvStringGrid; aCol1, aRow1, aCol2, aRow2 : integer);
var
  i, j : integer;
begin
  for j := aRow1 to aRow2 do
  begin
    for i := aCol1 to aCol2 do
    begin
      if (aGrid.Cells[i, j] <> '') then
        aGrid.Cells[i, j] := '';
    end;
  end;
end;

procedure ClearRows(aGrid : TAdvStringGrid; RowIndex, RCount : integer);
begin
  if (aGrid.RowCount > 0) and (aGrid.ColCount > 0) and (RCount > 0) then
    ClearRect(aGrid, 0, RowIndex, aGrid.ColCount - 1, RowIndex + RCount - 1);
end;

procedure InsertRows(aGrid : TAdvStringGrid; RowIndex, RCount : integer);
var
  i : integer;
begin
  aGrid.RowCount := aGrid.RowCount + RCount;

  for i := aGrid.RowCount - 1 downto (RowIndex + RCount) do
    aGrid.Rows[i] := aGrid.Rows[i - RCount];

  ClearRows(aGrid, RowIndex, RCount);
end;

procedure AutoSizeColumnsInt(aGrid : TAdvStringGrid);
var
  i, j, w0, w : integer;
begin
  for j := 0 to aGrid.ColCount - 1 do
  begin
    w0 := aGrid.DefaultColWidth;
    for i := 0 to aGrid.RowCount - 1 do
    begin
      w := aGrid.Canvas.TextWidth(aGrid.Cells[j, i]);
      if w > w0 then
        w0 := w;
    end;
    aGrid.colwidths[j] := w0;
  end;
end;

function CollectStrings(stl : TStrings) : string;
var
  i : integer;
begin
  result := '';
  for i := 0 to stl.Count - 1 do
  begin
    if i = 0 then
      result := stl[i]
    else
      result := result + #13 + stl[i];
  end;
end;

function BoolToStr(bBool : boolean) : string;
begin
  if bBool then
    result := '1'
  else
    result := '0';
end;

function LeftAlign(s : string; iLen : integer) : string;
var
  i : integer;
begin
  s := trim(s);
  for i := 1 to iLen do
    s := s + ' ';
  if length(s) > iLen then
    s := copy(s, 1, iLen);
  result := s;
end;




function RecSetIsEmpty(resSet : TRoomerDataSet) : boolean;
begin
  result := false;
  try
    resSet.first;
    if resSet.EOF then
      result := true;
  except
    result := true;
  end;
end;

procedure BreakDownString(s : string; stl : TstringList; cDelim : char);
var
  i : integer;
begin
  // --
  stl.Clear;
  for i := 0 to _strTokenCount(s, cDelim)-1 do
    stl.add(trim(_strTokenAT(s, cDelim,i)));
end;

function SQLDateQStr(aDate : TdateTime) : string;
var
  s : string;
begin
  datetimetostring(s, 'mm/dd/yyyy', aDate);
  result := QuotedStr(s);
end;

{ TRoomCell }

constructor TRoomCell.Create(status : string);
begin
  inherited Create;
  FRoomStatus := status;
end;



{ TGroupEntity }

constructor TGroupEntity.Create(_Reservation: integer; _Name: String);
begin
  inherited Create;
  FReservation := _Reservation;
  FName := _Name;
end;


initialization

end.





