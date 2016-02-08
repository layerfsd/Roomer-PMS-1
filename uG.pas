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
  , System.Generics.Collections
  ;


var
  RESERVATION_STATUS : SET OF CHAR;
  I_RESERVATION_STATUS : SET OF BYTE;


type
  TActTableAction = (actNone, actEdit, actInsert, actDelete, actLookup, actCancel, actAutoUpdate, actClone);


  IntegerArray = Array of Integer;
  StringArray = Array of String;
  VariantArray = Array of Variant;

  recConvert = record
    cChar : char;
    iChar : byte;
  end;

  TGroupEntity = class
  private
    FName: String;
    FReservation: integer;
  public
    constructor Create(_Reservation : integer; _Name : String);
    destructor Destroy; override;
    property Reservation : integer read FReservation;
    property Name : String read FName;
  end;

  TGroupEntityList = TObjectList<TGroupEntity>;

  TRoomCell = class
  private
    FRoomStatus : string;
  public
    constructor Create(status : string);
    destructor Destroy; override;
    property Roomstatus : string read FRoomStatus write FRoomStatus;
  end;

  recStatusAttr = record
    backgroundColor : TColor;
    fontColor	      : TColor;
    isBold          : Boolean;
    isItalic        : boolean;
    isUnderline     : boolean;
    isStrikeOut     : boolean;
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
  public
    qConnected : boolean;
    mHelpFile : string;

    qDebug1 : string;

    qLastID : string;
    qCustID : integer;

    qConvertArr : array [0 .. 100] of recConvert;
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

    qWarnCheckInDirtyRoom,
    qWarnWhenOverbooking,
    qWarnMoveRoomToNewRoomtype : Boolean;


    qNativeCurrency : string;
    qCountry : string;
    qBreakFastItem : string;

    qUserLanguage : integer;
    qlstLang : TStringList;

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
    qStatusAttr_Waitinglist          : recStatusAttr;
    qStatusAttr_NoShow               : recStatusAttr;
    qStatusAttr_Blocked              : recStatusAttr;
    qStatusAttr_ArrivingOtherLeaving : recStatusAttr;
    qStatusAttr_Order                : recStatusAttr;
    qStatusAttr_Canceled             : recStatusAttr;  //*HJ 140210
    qStatusAttr_Tmp1                 : recStatusAttr;  //*HJ 140210
    qStatusAttr_Tmp2                 : recStatusAttr;  //*HJ 140210

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

    procedure Help(id : integer);
    constructor Create;
    destructor Destroy; override;
    procedure ProcessAppIni(aMethod : integer; initialRead : Boolean = false);

//    function OpenZipCodes(var code : string) : boolean;

    function openSelectLanguage(var langName,langExt : string; var langId : integer) : boolean;
    function Convert(inn : string) : string;

    procedure initStatusAttrRec(var rec : recStatusAttr);
    procedure initRecHiddenInfo(var rec : recHiddenInfoHolder);
    procedure init_recItemHolder(var rec : recItemHolder);
    procedure initRecDownPayment(var rec: recDownPayment);


    function strToStatusAttr(const aValue : string) : recStatusAttr;
    function StatusAttrToStr(const aValue : recStatusAttr) : string;

    function FillConvertArr(ConvertName : string) : boolean;
    procedure InitConvertArr;

    procedure SetHotelToReportINI(dataname : string);

    procedure SetHotelIndex;
    function GetHotelIndex : integer;


    /// /***********************

    function OpenDownPayment(act : TActTableAction; var rec : recDownPayment) : boolean;
    function OpenCustomers(var act : TActTableAction; var Customer : string) : boolean;
    function OpenMaidActions(act : TActTableAction; var code, Description : string) : boolean;
    function OpenMaidActionsEdit(act : TActTableAction; var code : string) : boolean;

    function OpenResMemo(reservation : integer) : boolean;
    function AddAccommodation(var Persons,rooms,nights : integer; var roomPrice : double) : boolean;
//    function AddDiscount(var DiscountType : integer; var Amount : double) : boolean;


    function OpenRemoveRoom(RoomReservation : integer) : boolean;
    function OpenRemoveReservation(Roomreservation : integer) : boolean;
    function ConfirmAllottedReservation(Reservation : integer) : boolean;


    function TestConnection(var Connstr, strResult : string) : boolean;
    function OpenResProblem(var lst : TstringList) : integer;
    function OpenRoomDateProblem(var lst : TstringList) : integer;

    function StatusStrToResStatus(statusSTR : string) : TReservationStatus;
    function ResStatusToStatusStr(ResStatus : TReservationStatus) : string;

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
    property qAppSecret : string read FqAppSecret write FqAppSecret;



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


procedure OpenApplication;
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
function RoomIndex(aGrid : TStringGrid; sRoom : string; var lastRow : integer; sRoomType : String = ''; AddIfNeeded : boolean = false) : integer;
procedure FillTheGrid(Grid : TADVStringGrid; sWith : string; iStartCol, iStartRow : integer);
procedure EmptyStringGrid(Grid : TADVStringGrid);
function GridFloatValueFromString(aValue : String) : double;
function GridCellIntValue(aGrid : TStringGrid; ACol, ARow : integer) : integer;
function GridCellFloatValue(aGrid : TStringGrid; ACol, ARow : integer) : double;
procedure RowDelete(aGrid : TStringGrid);
procedure EmptyRow(aGrid : TStringGrid; iRow : integer);
procedure DeleteRow(aGrid : TStringGrid; iRow : integer);
procedure InsertRows(aGrid : TStringGrid; RowIndex, RCount : integer);
procedure ClearRows(aGrid : TStringGrid; RowIndex, RCount : integer);
procedure AutoSizeColumnsInt(aGrid : TStringGrid);
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
  PrjConst
  ;



//*****************************************************************************
//
//
//*****************************************************************************



//function StatusToString(Status : string) : string;
//var
//  ch : char;
//begin
//  result := '';
//  Status := trim(Status);
//  if length(Status) < 1 then
//    exit;
//  ch := Status[1];
//
//  case ch of
//    '1' :
//      begin
//        result := ctrlGetString('greenColor');
//      end;
//    '2' :
//      begin
//        result := ctrlGetString('PurpleColor');
//      end;
//    '3' :
//      begin
//        result := ctrlGetString('FuchsiaColor');
//      end;
//    'C' :
//      begin
//        result := 'Þrifið';
//      end;
//    'U' :
//      begin
//        result := 'Óþrifið';
//      end;
//    'O' :
//      begin
//        result := 'Bilað';
//      end;
//  end;
//end;
//


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
  cRoomStatus,
  ch : char;
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
  ch : char;
begin
  Status := trim(Status);
  result := false;
  if length(Status) < 1 then
    exit;
  ch := Status[1];

(*

    qStatusAttr_GuestStaying         : recStatusAttr;
    qStatusAttr_GuestLeavingNextDay  : recStatusAttr;
    qStatusAttr_Departing            : recStatusAttr;
    qStatusAttr_Departed             : recStatusAttr;
    qStatusAttr_Allotment            : recStatusAttr;
    qStatusAttr_Waitinglist          : recStatusAttr;
    qStatusAttr_NoShow               : recStatusAttr;
    qStatusAttr_Blocked              : recStatusAttr;
    qStatusAttr_ArrivingOtherLeaving : recStatusAttr;
    qStatusAttr_Order                : recStatusAttr;


*)


  case ch of
    'P' :
      begin
        backColor := g.qStatusAttr_Order.backgroundColor; //clRed;
        fontColor := g.qStatusAttr_Order.fontColor; //clWhite
        result := true;
      end;
    'G' :
      begin
        backColor := g.qStatusAttr_GuestStaying.backgroundColor; //clGreen;
        fontColor := g.qStatusAttr_GuestStaying.fontColor; //clWhite;
        result := true;
      end;
    STATUS_CHECKED_OUT :
      begin
        backColor := g.qStatusAttr_Departed.backgroundColor;
        fontColor := g.qStatusAttr_Departed.fontColor;  //clWhite;
        result := true;
      end;
    'O' :
      begin
        backColor := g.qStatusAttr_Waitinglist.backgroundColor; //clYellow;
        fontColor := g.qStatusAttr_Waitinglist.fontColor; //clBlack;
        result := true;
      end;
    'N' :
      begin
        backColor := g.qStatusAttr_NoShow.backgroundColor; //clRed;
        fontColor := g.qStatusAttr_NoShow.fontColor;//clYellow;
        result := true;
      end;
    'A' :
      begin
        backColor := g.qStatusAttr_Allotment.backgroundColor; //clWhite;
        fontColor := g.qStatusAttr_Allotment.fontColor;   //clRed;
        result := true;
      end;
    'B' :
      begin
        backColor := g.qStatusAttr_Blocked.backgroundColor; //_tinyIntToColor(55);
        fontColor := g.qStatusAttr_Blocked.fontColor;  //_tinyIntToColor(0);
        result := true;
      end;
    'C' :
      begin
        backColor := g.qStatusAttr_Canceled.backgroundColor; //;  //*HJ 140210
        fontColor := g.qStatusAttr_Canceled.fontColor;//;
        result := true;
      end;
    'W' :
      begin
        backColor := g.qStatusAttr_TMP1.backgroundColor; //;  //*HJ 140210
        fontColor := g.qStatusAttr_TMP1.fontColor;//;
        result := true;
      end;
    'Z' :
      begin
        backColor := g.qStatusAttr_TMP2.backgroundColor; //;   //*HJ 140210
        fontColor := g.qStatusAttr_TMP2.fontColor;//;
        result := true;
      end;
    else
      begin
        backColor := g.qStatusAttr_GuestStaying.backgroundColor; //clBlue;
        fontColor := g.qStatusAttr_GuestStaying.fontColor; // clYellow;
      end;
    end;
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
  ch : char;
begin
  result := '';
  Status := trim(Status);
  if Status = '' then
    exit;

  Status := UpperCase(Status);
  ch := Status[1];

  case ch of
    'P' :
    //  result := 'Ókominn';
	  result := GetTranslatedText('shTx_G_NotArrived');
    'G' :
    //  result := 'Innskráður';
	   result := GetTranslatedText('shTx_G_CheckedIn');
    STATUS_CHECKED_OUT :
    //  result := 'Farinn';
     result := GetTranslatedText('shTx_G_CheckedOut');
	'O' :
    //  result := 'Biðlisti';
	  result := GetTranslatedText('shTx_G_WaitingList');
    'A' :
    //  result := 'Alotment';
	   result := GetTranslatedText('shTx_G_Alotment');
    'N' :
     // result := 'No show';
	  result := GetTranslatedText('shTx_G_NoShow');
    'B' :
     // result := 'Blocked';
	  result := GetTranslatedText('shTx_G_Blocked');
    'C' :
     // result := 'Canceled';
	  result := GetTranslatedText('shTx_G_Canceled');
    'W' :
     // result := 'Other 1';
	  result := GetTranslatedText('shTx_G_Tmp1'); //ATH 2
    'Z' :
     // result := 'Other 2';
	  result := GetTranslatedText('shTx_G_Tmp2');
  end;
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

function BHGYMDstringTodate(aString : string) : TdateTime;
var
  Y, M, d : word;
begin
  Y := strToint(copy(aString, 1, 4));
  M := strToint(copy(aString, 6, 2));
  d := strToint(copy(aString, 9, 2));
  result := enCodeDate(Y, M, d);
end;

function lineDate2Date(linedate : string) : TDate;
var
  sY : string;
  sM : string;
  sD : string;

  Y, M, d : integer;
begin
  result := enCodeDate(2050, 1, 1);
  linedate := trim(linedate);

  if (length(linedate) <> 8) then
    exit;

  sY := copy(linedate, 1, 4);
  try
    Y := strToint(sY);
  except
    exit;
  end;

  sM := copy(linedate, 5, 2);
  try
    M := strToint(sM);
  except
    exit;
  end;

  sD := copy(linedate, 7, 2);
  try
    d := strToint(sD);
  except
    exit;
  end;

  try
    result := enCodeDate(Y, M, d);
  except
    // do nothing
  end;
end;

procedure TGlobalApplication.Help(id : integer);
begin
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
    //Description := 'Downpayment/innágreiðsla';
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
begin
  qProgramPath := GetTempPath + 'Roomer\'; // LocalAppDataPath; // _AddSlash(ExtractFileDir(Application.ExeName));
  qProgramExePath := LocalAppDataPath + 'Roomer\Storage\';
  ForceDirectories(qProgramPath);
  ForceDirectories(qProgramExePath);
  ForceDirectories(qProgramExePath + 'Data');
  qAppIniFile := GetRoomerIniFilename;


//  qComputerName    := _getComputerNetName;
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

end;

constructor TGlobalApplication.Create;
begin
  inherited;
  FqHotelList := TstringList.Create;
  FqHotelIndex := 0;
  FBackupMachine := False;
  qlstLang := TStringList.create;
  qlstLang.Add('English|ntv');
  qlstLang.Add('Íslenska|ISL');
  qlstLang.Add('Dutch|NL');
  InitializeApplicationGlobals;
end;

destructor TGlobalApplication.destroy;
begin
  FqHotelList.free;
  freeandNil(qlstLang);
  /// ---
  inherited;
end;


function TGlobalApplication.TestConnection(var Connstr, strResult : string) : boolean;
var
  dbc : TRoomerConnection;
  i : integer;
  s : string;
  ch : char;
begin
  result := false;
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
  xml: IXMLDOMDocument;
  node, node1: IXMLDomNode;
  nodeName : String;
  nodes_row, nodes_se: IXMLDomNodeList;
  i, l : Integer;
begin
  key := ''; secret := '';
  Coinitialize(nil);
  xml := CreateOleObject('Microsoft.XMLDOM') as IXMLDOMDocument;
  xml.async := False;
  xml.loadXML(xmlStr);
  nodes_row := xml.selectNodes('/ns9:ApplicationInstanceRegistrationResponse/ns9:registrationResponse');
  for i := 0 to nodes_row.length - 1 do
  begin
    node := nodes_row.item[i];
    for l := 0 to node.childNodes.length - 1 do
    begin
      node1 := node.childNodes[l];
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

procedure TGlobalApplication.ProcessAppIni(aMethod : integer; initialRead : Boolean = false);
const
  secAppRegistration = 'AppReg';
  indApplicationID = 'Application_ID';
  indAppKey = 'Application_Key';
  indAppSecret = 'Application_Secret';

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
  openResult : Boolean;
  AppRegGroup : String;
begin
//  reg := TRoomerRegistryIniFile.Create('RoomerLocalSettings_' + g.qHotelCode + '.ini');
  reg := TRoomerRegistryIniFile.Create('RoomerLocalSettings.ini');
  reg.RegIniFile.RootKey := HKEY_CURRENT_USER;
  if (aMethod = 1) OR reg.RegIniFile.KeyExists(GetHotelIniFilename(True)) then
  begin
    reg.Free;
    reg := TRoomerRegistryIniFile.Create(GetHotelIniFilename);
  end;

  AppRegGroup := secAppRegistration;
  if Assigned(d) AND Assigned(d.roomerMainDataSet) AND (d.roomerMainDataSet.OpenApiUri <> '') then
     AppRegGroup := d.roomerMainDataSet.OpenApiUri;

  try
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

            SetHotelIndex;
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

function TGlobalApplication.GetHotelIndex : integer;
//var
//  sIniName : string;
begin
  result := 0;
//  sIniName := ChangeFileExt(PAramstr(0), '.ini');
//  with Tinifile.Create(sIniName) do
//    try
//      result := ReadInteger('Login', 'lastHotel', 0);
//    finally
//      free;
//    end;
end;

procedure TGlobalApplication.SetHotelIndex;
//var
//  sIniName : string;
begin
//  sIniName := ChangeFileExt(PAramstr(0), '.ini');
//  with Tinifile.Create(sIniName) do
//    try
//      WriteInteger('Login', 'lastHotel', G.qHotelIndex);
//    finally
//      free;
//    end;
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


//function TGlobalApplication.ChangeLang(newLangId : integer; doUpdate : boolean=true) : boolean;
//var
//  Line    : string;
//  langExt : string;
//begin
//  result := false;
//  if newLangId > qLstLang.count-1 then newLangId := 0;
//  if NewLangId = g.qUserLanguage then exit;
//  result := true;
//
//  line := qlstLang[NewLangId];
//  LangExt  := _StrTokenAt(line,'|',1);
//
//  g.qUserLanguage := newlangID;
//
//  if doUpdate then
//  begin
//    d.UpdateUsersLanguage(g.qUser, g.qUserLanguage);
//  end;
//
//end;

function TGlobalApplication.ChangeLang(newLangId : integer; doUpdate : boolean=true) : boolean;
var
  Line    : string;
  langExt : string;
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
var
  i : integer;
begin
(*
  zLangId   := cbxSelLang.itemindex;
  line := g.qlstLang[zLangId];
  zLangName := _StrTokenAt(line,'|',0);
  zLangExt  := _StrTokenAt(line,'|',1);
*)

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

//      ChangeLang(LangId);

      (*

      if langID <> g.qUserLanguage then
      begin
        LocalizerOnFly.SwitchToExt(langExt);
        g.qUserLanguage := langID;
        d.UpdateUsersLanguage(g.qUser, g.qUserLanguage);
        d.OpenStaffMembersQuery(d.zStaffMembersSortField, d.zStaffMembersSortDir);
      end;
      *)


    end;
  finally
    freeandnil(frmSelLang);
  end;
end;




/// start - Open and Close Application;
procedure OpenApplication;
var
  theComputerName : array [0 .. 255 + 1] of char;
  itsLength : DWORD;
begin
  // --
  G := TGlobalApplication.Create;

  G.mHelpFile := ExtractFilePath(Paramstr(0)) + '\Help\help01.chm';
  G.mHelpFile := ExpandFileName(G.mHelpFile);

  // if not FileExists(g.mHelpFile) then
  // ShowMessage('Help file not found'#13+g.mHelpFile);
  // g.openSelectHotel;

  G.qShowUnpaidInGrid := true;
  G.qShowHint := true;
  G.qComputerName := 'NA';
  G.qUser := '';
  G.qUserName := '';
  G.qUserPID := '';
  G.qUserType := '';
  G.qUserLanguage := 0;
  G.qNativeCurrency := '';
  G.qCountry := '';
  G.qBreakFastItem := '';


  G.qArrivalDateRulesPrice := false;
  G.qBreakfastInclDefault := false;

  G.qPhoneUseItem := '';
  G.qPaymentItem := '';
  G.qRoomRentItem := '';
  g.qStayTaxItem := '';
  g.qStayTaxPerPerson := False;

  G.qDiscountItem := '';

  G.qLocalRoomRent := '';
  G.qGreenColor := '';
  G.qPurpleColor := '';
  G.qFuchsiaColor := '';

  G.qUseSetUnclean := true;

  G.qNameOrder := 0;
  G.qNameOrderPeriod := 0;

  G.qInvPriceGroup := '';

  itsLength := MAX_COMPUTERNAME_LENGTH + 1;

  if (GetComputerName(theComputerName, itsLength)) then
  begin
    G.qComputerName := trim(string(theComputerName));
  end;

  G.ProcessAppIni(0, true); // 0=Open 1=CloseGlbApp.SetFasta;

  // g.qLastID := '0';
  // g.qCustID := -1;

  G.qGridsIniFileName := G.qProgramExePath + 'grids.ini';

end;

procedure CloseApplication;
begin
  // --
  G.ProcessAppIni(1); // 0=Open 1=CloseGlbApp.SetFasta;
  G.free;
end;
/// end - Open and Close Application;

procedure TGlobalApplication.InitConvertArr;
var
  r : integer;
begin
  for r := 0 to 100 do
  begin
    qConvertArr[r].cChar := chr(0);
    qConvertArr[r].iChar := 0;
  end;
end;

function TGlobalApplication.FillConvertArr(ConvertName : string) : boolean;

  function LoadConvert : boolean;
  var
    tmpLst1 : TstringList;
    cvFileName : string;
    i : integer;
    line : string;

    index : integer;
    ok1, ok2 : boolean;

    sTmp : string;

    sChar : string;
    iChar : integer;
    cChar : char;
  begin
    result := false;
    iChar := 0;
    cChar := #0;

    tmpLst1 := TstringList.Create;
    try
      cvFileName := qProgramExePath + ConvertName + '.ctb';
      if FileExists(cvFileName) then
      begin
        tmpLst1.LoadFromFile(cvFileName);
        index := - 1;

        for i := 0 to tmpLst1.Count - 1 do
        begin
          ok1 := false;
          ok2 := false;
          line := tmpLst1[i];
          sChar := _strTokenAt(line, '|', 0);
          sTmp := _strTokenAt(line, '|', 1);

          if length(sChar) = 1 then
          begin
            cChar := sChar[1];
            ok1 := true;
          end;

          if _isInteger(sTmp) then
          begin
            iChar := strToint(sTmp);
            if i < 255 then
            begin
              ok2 := true;
            end;
          end;

          if ok1 and ok2 then
          begin
            inc(index);
            qConvertArr[index].cChar := cChar;
            qConvertArr[index].iChar := iChar;
          end;
        end;

        result := qConvertArr[1].cChar <> #0;

      end;
    finally
      tmpLst1.free;
    end;
  end;

begin
  result := false;
  InitConvertArr;
  if trim(ConvertName) <> '' then
  begin
    result := LoadConvert;
  end;
end;

function TGlobalApplication.Convert(inn : string) : string;
var
  i : integer;
  ch : char;
  r : integer;
  cChar : char;
  iChar : integer;
begin

  if qConvertArr[1].cChar = #0 then
  begin
    result := inn;
    exit;
    // Convert arr empty do nothing;
  end;

  result := '';
  for i := 1 to length(inn) do
  begin
    ch := inn[i];
    r := - 1;
    repeat
      inc(r);
      cChar := qConvertArr[r].cChar;
      iChar := qConvertArr[r].iChar;
    until (cChar = ch) or (cChar = chr(0)) or (r = 100);

    if cChar = ch then
    begin
      ch := chr(iChar);
    end;

    result := result + ch;
  end;
end;

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



function TGlobalApplication.OpenCustomers(var act : TActTableAction; var Customer : string) : boolean;
begin
  result := true;
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
  if MessageDlg(GetTranslatedText('shTxThisConfirmAllottedBooking'), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;

  s := format('UPDATE reservations r ' +
       '       JOIN roomreservations rr ON rr.Reservation=r.Reservation ' +
       '       JOIN roomsdate rd ON rd.RoomReservation=rr.RoomReservation, ' +
       '       (SELECT ''P'' AS status, ''A'' AS oldStatus) AS _status ' +
       'SET r.Status=_status.status, ' +
       '    rr.Status=_status.status, ' +
       '    rd.ResFlag=_status.status ' +
       'WHERE r.Reservation=%d ' +
       'AND r.Status=_status.oldStatus ' +
       'AND rr.Status=_status.oldStatus ' +
       'AND rd.ResFlag=_status.oldStatus', [Reservation]);

  d.roomerMainDataSet.DoCommand(s);
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
  result := false;
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


function TGlobalApplication.OpenMaidActions(act : TActTableAction; var code, Description : string) : boolean;
begin

  result := false;
  frmMaidActions := TfrmMaidActions.Create(frmMaidActions);
  try
    frmMaidActions.zCode := code;
    frmMaidActions.zAct := act;

    frmMaidActions.ShowModal;
    if frmMaidActions.modalresult = mrOk then
    begin
      code := frmMaidActions.zCode;
      Description := frmMaidActions.zDescription;
      result := true;
    end
    else
    begin
      code := '';
    end;
  finally
    frmMaidActions.free;
    frmMaidActions := nil;
  end;
end;

function TGlobalApplication.OpenMaidActionsEdit(act : TActTableAction; var code : string) : boolean;
begin
  result := false;
  frmMaidActionsEdit := TfrmMaidActionsEdit.Create(frmMaidActionsEdit);
  try
    frmMaidActionsEdit.zAct := act;
    frmMaidActionsEdit.ShowModal;
    if frmMaidActionsEdit.modalresult = mrOk then
    begin
      code := frmMaidActionsEdit.zCode;
      result := true;
    end
    else
    begin
      code := frmMaidActionsEdit.zCode;
    end;
  finally
    frmMaidActionsEdit.free;
    frmMaidActionsEdit := nil;
  end;
end;



function TGlobalApplication.strToStatusAttr(const aValue : string) : recStatusAttr;
var
  s : string;

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
  result := - 1;
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

function TGlobalApplication.OpenRoomDateProblem(var lst : TstringList) : integer;
begin
  result := - 1;
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

function TGlobalApplication.StatusStrToResStatus(statusSTR : string) : TReservationStatus;
begin
  result := rsUnKnown;
  statusSTR := trim(statusSTR);
  if statusSTR = 'P' then
    result := rsReservations
  else if statusSTR = 'G' then
    result := rsGuests
  else if statusSTR = STATUS_CHECKED_OUT then
    result := rsDeparted
  else if statusSTR = 'R' then
    result := rsReserved
  else if statusSTR = 'O' then
    result := rsOverbooked
  else if statusSTR = 'A' then
    result := rsAlotment
  else if statusSTR = 'N' then
    result := rsNoShow
  else if statusSTR = 'B' then
    result := rsBlocked
  else if statusSTR = 'C' then
    result := rsCanceled
  else if statusSTR = 'W' then  //*HJ 140206
    result := rsTmp1
  else if statusSTR = 'Z' then   //*HJ 140206
    result := rsTmp2



end;

function TGlobalApplication.ResStatusToStatusStr(ResStatus : TReservationStatus) : string;
begin
  result := '';
  (* if ResStatus = rsReservations then result := 'Reservation';
  if ResStatus = rsGuests then result := 'Guest';
  if ResStatus = rsDeparted then result := 'Departed';
  if ResStatus = rsReserved then result := 'Reserved';
  if ResStatus = rsOverbooked then result := 'Overbooked';
  if ResStatus = rsAlotment then result := 'Allotment';
  if ResStatus = rsNoShow then result := 'NoShow';
  if ResStatus = rsBlocked then result := 'Blocked';
  if ResStatus = rsDeparting then result := 'Departing';
  if ResStatus = rsCurrent then result := 'Current'; *)
  if ResStatus = rsReservations then result := GetTranslatedText('shTx_G_Reservation');
  if ResStatus = rsGuests then result := GetTranslatedText('shTx_G_Guest');
  if ResStatus = rsDeparted then result := GetTranslatedText('shTx_G_Departed');
  if ResStatus = rsReserved then result := GetTranslatedText('shTx_G_Reserved');
  if ResStatus = rsOverbooked then result := GetTranslatedText('shTx_G_Overbooked');
  if ResStatus = rsAlotment then result := GetTranslatedText('shTx_G_Alotment');
  if ResStatus = rsNoShow then result := GetTranslatedText('shTx_G_NoShow');
  if ResStatus = rsBlocked then result := GetTranslatedText('shTx_G_Blocked');
  if ResStatus = rsDeparting then result := GetTranslatedText('shTx_G_Departing');
  if ResStatus = rsCurrent then result := GetTranslatedText('shTx_G_Current');
  if ResStatus = rsCanceled then result := GetTranslatedText('shTx_G_Canceled'); //*HJ 140206
  if ResStatus = rsTmp1 then result := GetTranslatedText('shTx_G_Tmp1');  //*HJ 140206
  if ResStatus = rsTmp2 then result := GetTranslatedText('shTx_G_Tmp2'); //*HJ 140206
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
var iRow, iCol : integer;
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

function RoomIndex(aGrid : TStringGrid; sRoom : string; var lastRow : integer; sRoomType : String = ''; AddIfNeeded : boolean = false) : integer;
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

function GridCellIntValue(aGrid : TStringGrid; ACol, ARow : integer) : integer;
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

function GridCellFloatValue(aGrid : TStringGrid; ACol, ARow : integer) : double;
begin
  // --
  result := GridFloatValueFromString(aGrid.Cells[ACol, ARow]);
end;

procedure CutRange(aGrid : TStringGrid);
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

procedure PasteRange(aGrid : TStringGrid);
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

procedure EmptyRow(aGrid : TStringGrid; iRow : integer);
var
  i : integer;
begin
  aGrid.Objects[0, iRow] := nil;
  for i := 0 to aGrid.ColCount - 1 do
    aGrid.Cells[i, iRow] := '';
end;

procedure DeleteRow(aGrid : TStringGrid; iRow : integer);
var
  i : integer;
begin
  EmptyRow(aGrid, iRow);
  if (iRow = 1) and (aGrid.RowCount = 2) then
  begin
  end
  else
  begin
    for i := iRow + 1 to aGrid.RowCount - 1 do
    begin
      aGrid.Rows[i - 1] := aGrid.Rows[i];
      aGrid.Objects[0, i-1] := aGrid.Objects[0, i];
    end;
    aGrid.RowCount := aGrid.RowCount - 1;
  end;
end;

procedure RowDelete(aGrid : TStringGrid);
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

procedure ClearRect(aGrid : TStringGrid; aCol1, aRow1, aCol2, aRow2 : integer);
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

procedure ClearRows(aGrid : TStringGrid; RowIndex, RCount : integer);
begin
  if (aGrid.RowCount > 0) and (aGrid.ColCount > 0) and (RCount > 0) then
    ClearRect(aGrid, 0, RowIndex, aGrid.ColCount - 1, RowIndex + RCount - 1);
end;

procedure InsertRows(aGrid : TStringGrid; RowIndex, RCount : integer);
var
  i : integer;
begin
  aGrid.RowCount := aGrid.RowCount + RCount;

  for i := aGrid.RowCount - 1 downto (RowIndex + RCount) do
    aGrid.Rows[i] := aGrid.Rows[i - RCount];

  ClearRows(aGrid, RowIndex, RCount);
end;

procedure AutoSizeColumnsInt(aGrid : TStringGrid);
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

procedure myDecodeDate(aDate : TdateTime; var year, Month, Day : word);
begin
  // --
  DecodeDate(aDate, year, Month, Day);

  // -- Y2K fix !
  if year > 2020 then
    year := year - 100
  else if year < 21 then
    year := 2000 + year
  else if year < 1900 then
    year := 1900 + year;
end;

function myFileDateToDateTime(iTime : integer) : TdateTime;
var
  Y, M, d, h, mi, s, ms : word;
begin
  result := FileDateToDateTime(iTime);
  myDecodeDate(result, Y, M, d);
  DecodeTime(result, h, mi, s, ms);
  result := EncodeDate(Y, M, d) + EncodeTime(h, mi, s, ms);
end;

function myDateToStr(dt : TdateTime) : string;
var
  Y, M, d, h, mi, s, ms : word;
begin
  myDecodeDate(dt, Y, M, d);
  DecodeTime(dt, h, mi, s, ms);
  dt := EncodeDate(Y, M, d);
  result := DateToStr(dt);
end;

function myStrToDate(str : string) : TdateTime;
var
  Y, M, d : word;
begin
  result := StrToDate(str);
  myDecodeDate(result, Y, M, d);

  result := EncodeDate(Y, M, d);
end;

function myDateTimeToStr(dt : TdateTime) : string;
var
  Y, M, d, h, mi, s, ms : word;
begin
  // -- Y2K fix !
  //
  myDecodeDate(dt, Y, M, d);
  DecodeTime(dt, h, mi, s, ms);

  dt := EncodeDate(Y, M, d) + EncodeTime(h, mi, s, ms);

  result := DateToStr(dt);
end;

function myStrToDateTime(str : string) : TdateTime;
var
  Y, M, d, h, mi, s, ms : word;
begin
  // -- Y2K fix !
  //
  result := StrToDate(str);
  myDecodeDate(result, Y, M, d);
  DecodeTime(result, h, mi, s, ms);

  result := EncodeDate(Y, M, d) + EncodeTime(h, mi, s, ms);
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
  RoomCellCollection.Add(Self);
end;

destructor TRoomCell.Destroy;
begin
  inherited Destroy;
end;


{ TGroupEntity }

constructor TGroupEntity.Create(_Reservation: integer; _Name: String);
begin
  inherited Create;
  FReservation := _Reservation;
  FName := _Name;
end;

destructor TGroupEntity.Destroy;
begin
  inherited;
end;


initialization

   RESERVATION_STATUS := [
    STATUS_NOT_ARRIVED,
    STATUS_ARRIVED,
    STATUS_CHECKED_OUT,
    STATUS_CANCELLED,
    STATUS_WAITING_LIST,
    STATUS_NO_SHOW,
    STATUS_ALLOTMENT,
    STATUS_BLOCKED,
    STATUS_CANCELED,
    STATUS_TMP1,
    STATUS_AWAITING_PAYMENT,
    STATUS_DELETED
    ];

   I_RESERVATION_STATUS := [
    I_STATUS_NOT_ARRIVED,
    I_STATUS_ARRIVED,
    I_STATUS_CHECKED_OUT,
    I_STATUS_CANCELLED,
    I_STATUS_WAITING_LIST,
    I_STATUS_NO_SHOW,
    I_STATUS_ALLOTMENT,
    I_STATUS_BLOCKED,
    I_STATUS_CHANCELED,
    I_STATUS_TMP1,
    I_STATUS_AWAITING_PAYMENT,
    I_STATUS_DELETED
    ];

end.





