unit uReservationStateDefinitions;

interface

uses
  Graphics
  , CLasses
  ;

type
  TReservationState = (
      rsUnKnown,
      rsReservation,
      rsGuests,
      rsDeparted,
      rsReserved,
      rsWaitingList,
      rsAllotment,
      rsNoShow,
      rsBlocked,
      rsCancelled,
      rsTmp1,
      rsAwaitingPayment,
      rsDeleted,
      rsAwaitingPayConfirm,
      rsMixed);

    TReservationStateSet = set of TReservationState;

    TReservationStateHelper = record helper for TReservationState
    public
      // constructor
      /// <summary>
      ///   Create a TReservationState from a single character or status string
      /// </summary>
      class function FromResStatus(const statusChar : char) : TReservationState; overload; static;
      class function FromResStatus(const statusStr : string) : TReservationState; overload; static;
      class function FromItemIndex(aIndex: integer) : TReservationState; static;

      /// <summary>
      ///   Fill a TStrings with translated descriptions in order of enumeration. Can by used to populate a TCombobox
      /// </summary>
      class procedure AsStrings(aItemList: TStrings); static;
      /// <summary>
      ///   Return the itemindex of TReservationState as it would have in the itemlist created by AsStrings
      /// </summary>
      function ToItemIndex: integer;

      /// <summary>
      ///   Return a single character statusstring
      /// </summary>
      function AsStatusChar: Char;
      /// <summary>
      ///   Return the translated displaystring for a ReservationState
      /// </summary>
      function AsReadableString : string;
      /// <summary>
      ///   Return the colors (back and front) set for hotel to be used for displaying reservation data
      /// </summary>
      function ToColor(var backColor, fontColor : TColor) : boolean;
      /// <summary>
      ///   Return wether this state can be set by the user of PMS or only by backend
      /// </summary>
      function IsUserSelectable: boolean;
    end;

    TReservationStateSetHelper = record helper for TReservationStateSet
      /// <summary>
      ///   Returns a string containing a set definition as used in SQL statements, i.e. ('P, 'C')
      /// </summary>
      function AsSQLString: string;
    end;

const
	STATUS_NOT_ARRIVED = 'P';
  STATUS_ARRIVED = 'G';
  STATUS_CHECKED_OUT = 'D';
  STATUS_CANCELLED = 'C';
  STATUS_WAITING_LIST = 'O';
  STATUS_NO_SHOW = 'N';
  STATUS_ALLOTMENT = 'A';
  STATUS_BLOCKED = 'B';
  STATUS_CANCELED = 'C';  //*HJ 140210
  STATUS_TMP1 = 'W';  //*HJ 140210
  STATUS_AWAITING_PAYMENT = 'Z';  //*BG 140304
  STATUS_DELETED = 'X';  //*BG 140304


implementation

uses
    PrjConst
  , SysUtils
  , uG
  , uUtils;


function TReservationStateHelper.AsStatusChar: Char;
const
  cReservationStateChars : Array[TReservationState] of char =
      ('P','P','G','D','P','O','A','N','B','C','W','Z','X', 'Q', 'M');
begin
  Result := cReservationStateChars[Self];
end;


class procedure TReservationStateHelper.AsStrings(aItemList: TStrings);
var
  s: TReservationState;
begin
  aItemList.Clear;
  for s := TReservationState(1) to high(s) do // dont use rsUnkown
    aItemList.Add(s.AsReadableString);
end;

class function TReservationStateHelper.FromItemIndex(aIndex: integer): TReservationState;
begin
  if aIndex = -1 then
    Result := rsUnKnown
  else
    Result := TReservationState(aIndex+1);
end;

class function TReservationStateHelper.FromResStatus(const statusStr: string): TReservationState;
begin
  if statusStr.IsEmpty then
    Result := rsUnKnown
  else
    Result := FromResStatus(statusStr[1]);
end;

function TReservationStateHelper.IsUserSelectable: boolean;
begin
  case Self of
    rsReservation:        result := True;
    rsGuests:             result := True;
    rsDeparted:           result := True;
    rsReserved:           result := True;
    rsWaitingList:         result := True;
    rsAllotment:           result := True;
    rsNoShow:             result := True;
    rsBlocked:            result := False; // only selectable when creating a special type reservation
    rsCancelled:          result := True;
    rsTmp1:               result := True;
    rsAwaitingPayment:    result := False;
    rsDeleted:            result := False;
    rsAwaitingPayConfirm: result := False;
    rsMixed:              result := false;
  else
    Result := false;
  end;

end;

function TReservationStateHelper.AsReadableString : string;
begin
  case Self of
    rsReservation:        result := GetTranslatedText('shTx_G_Reservation');
    rsGuests:             result := GetTranslatedText('shTx_G_CheckedIn');
    rsDeparted:           result := GetTranslatedText('shTx_G_Departed');
    rsReserved:           result := GetTranslatedText('shTx_G_Reserved');
    rsWaitingList:         result := GetTranslatedText('shTx_G_Overbooked');
    rsAllotment:           result := GetTranslatedText('shTx_G_Alotment');
    rsNoShow:             result := GetTranslatedText('shTx_G_NoShow');
    rsBlocked:            result := GetTranslatedText('shTx_G_Blocked');
    rsCancelled:          result := GetTranslatedText('shTx_G_Canceled');
    rsTmp1:               result := GetTranslatedText('shTx_G_Tmp1');
    rsAwaitingPayment:    result := GetTranslatedText('shTx_G_AwaitingPayment');
    rsDeleted:            result := GetTranslatedText('shTx_G_Deleted');
    rsAwaitingPayConfirm: result := GetTranslatedText('shTx_G_AwaitingPayConfirm');
    rsMixed:              result := GetTranslatedText('shTx_G_Mixed');
  else
    Result := '';
  end;
end;


class function TReservationStateHelper.FromResStatus(const statusChar : char) : TReservationState;
begin
  case UpperCase(statusChar)[1] of
    'P': result := rsReservation;
    'G': result := rsGuests;
    'D': result := rsDeparted;
    'R': result := rsReserved;
    'O': result := rsWaitingList;
    'A': result := rsAllotment;
    'N': result := rsNoShow;
    'B': result := rsBlocked;
    'C': result := rsCancelled;
    'W': result := rsTmp1;
    'Z': result := rsAwaitingPayment;
    'Q': result := rsAwaitingPayConfirm;
  else
    result := rsUnKnown;
  end;
end;


function TReservationStateHelper.ToColor(var backColor, fontColor : TColor) : boolean;
begin
  result := false;
  case Self of
    rsReservation :
      begin
        backColor := g.qStatusAttr_Order.backgroundColor; //clRed;
        fontColor := g.qStatusAttr_Order.fontColor; //clWhite
        result := true;
      end;
    rsGuests :
      begin
        backColor := g.qStatusAttr_GuestStaying.backgroundColor; //clGreen;
        fontColor := g.qStatusAttr_GuestStaying.fontColor; //clWhite;
        result := true;
      end;
    rsDeparted :
      begin
        backColor := g.qStatusAttr_Departed.backgroundColor;
        fontColor := g.qStatusAttr_Departed.fontColor;  //clWhite;
        result := true;
      end;
    rsWaitingList :
      begin
        backColor := g.qStatusAttr_Waitinglist.backgroundColor; //clYellow;
        fontColor := g.qStatusAttr_Waitinglist.fontColor; //clBlack;
        result := true;
      end;
    rsNoShow :
      begin
        backColor := g.qStatusAttr_NoShow.backgroundColor; //clRed;
        fontColor := g.qStatusAttr_NoShow.fontColor;//clYellow;
        result := true;
      end;
    rsAllotment :
      begin
        backColor := g.qStatusAttr_Allotment.backgroundColor; //clWhite;
        fontColor := g.qStatusAttr_Allotment.fontColor;   //clRed;
        result := true;
      end;
    rsBlocked :
      begin
        backColor := g.qStatusAttr_Blocked.backgroundColor; //_tinyIntToColor(55);
        fontColor := g.qStatusAttr_Blocked.fontColor;  //_tinyIntToColor(0);
        result := true;
      end;
    rsCancelled :
      begin
        backColor := g.qStatusAttr_Canceled.backgroundColor; //;  //*HJ 140210
        fontColor := g.qStatusAttr_Canceled.fontColor;//;
        result := true;
      end;
    rsTmp1:
      begin
        backColor := g.qStatusAttr_TMP1.backgroundColor; //;  //*HJ 140210
        fontColor := g.qStatusAttr_TMP1.fontColor;//;
        result := true;
      end;
    rsAwaitingPayment :
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


function TReservationStateHelper.ToItemIndex: integer;
begin
  if Self = rsUnknown then
    Result := -1
  else
    Result := ord(Self)-1;
end;

{ TReservationStateSetHelper }

function TReservationStateSetHelper.AsSQLString: string;
var
  lStr: TStringList;
  stat: TReservationState;
begin
  lStr := TStringlist.Create;
  try
    for stat in Self do
      lStr.Add(Quotedstr( stat.AsStatusChar));

    lStr.Delimiter := ',';
    Result := '(' + lStr.DelimitedText +')';
  finally
    lStr.Free;
  end;
end;

end.