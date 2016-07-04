unit uReservationStatusDefinitions;

interface

type
  TReservationStatus = (
      rsUnKnown, 
      rsReservations, 
      rsGuests, 
      rsDeparting, 
      rsDeparted, 
      rsReserved, 
      rsOverbooked, 
      rsAll, 
      rsCurrent, 
      rsAlotment, 
      rsNoShow,
      rsBlocked, 
      rsCanceled, 
      rsTmp1, 
      rsTmp2,
      rsDeleted); 

    TReservationStatusHelper = record helper for TReservationStatus
    public
      function StatusChar: Char;
      function FromResStatus(statusSTR : string) : TReservationStatus;
      function AsReadableString : string;
      function ToColor(var backColor, fontColor : TColor) : boolean;
    end;


const
  RESERVATION_STATUS_STRING = 'PGDCONABCWZX';


	I_STATUS_NOT_ARRIVED : Integer = 0;
  I_STATUS_ARRIVED : Integer = 1;
  I_STATUS_CHECKED_OUT : Integer = 2;
  I_STATUS_CANCELLED : Integer = 3;
  I_STATUS_WAITING_LIST : Integer = 4;
  I_STATUS_NO_SHOW : Integer = 5;
  I_STATUS_ALLOTMENT : Integer = 6;
  I_STATUS_BLOCKED : Integer = 7;
  I_STATUS_CHANCELED : Integer = 8; //*HJ 140210
  I_STATUS_TMP1 : Integer = 9; //*HJ 140210
  I_STATUS_AWAITING_PAYMENT : Integer = 10; //*HJ 140210
  I_STATUS_DELETED : Integer = 11; //*HJ 140210


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

function TReservationStatusHelper.StatusChar: Char;
const
  cReservationStatusChars : Array[TReservationStatus] of char =
      ('P','P','G','G','D','P','O','P','G','A','N','B','C','W','Z','X');
begin
  Result := cReservationStatusChars[Self]; 
end;


function TReservationStatusHelper.AsReadableString : string;
begin
  case Self of
    rsReservations: result := GetTranslatedText('shTx_G_Reservation');
    rsGuests:       result := GetTranslatedText('shTx_G_Guest');
    rsDeparted:     result := GetTranslatedText('shTx_G_Departed');
    rsReserved:     result := GetTranslatedText('shTx_G_Reserved');
    rsOverbooked:   result := GetTranslatedText('shTx_G_Overbooked');
    rsAlotment:     result := GetTranslatedText('shTx_G_Alotment');
    rsNoShow:       result := GetTranslatedText('shTx_G_NoShow');
    rsBlocked:      result := GetTranslatedText('shTx_G_Blocked');
    rsDeparting:    result := GetTranslatedText('shTx_G_Departing');
    rsCurrent:      result := GetTranslatedText('shTx_G_Current');
    rsCanceled:     result := GetTranslatedText('shTx_G_Canceled'); //*HJ 140206
    rsTmp1:         result := GetTranslatedText('shTx_G_Tmp1');  //*HJ 140206
    rsTmp2:         result := GetTranslatedText('shTx_G_Tmp2'); //*HJ 140206
  else
    Result := '';
  end;
end;

function TReservationStatusHelper.FromResStatus(statusSTR : string) : TReservationStatus;
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


function TReservationStatusHelper.ToColor(var backColor, fontColor : TColor) : boolean;
begin
  result := false;
  case Self of
    rsReservations :
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
    rsOverbooked :
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
    rsAlotment :
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
    rsCanceled :
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
    rsTmp2 :
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


end.