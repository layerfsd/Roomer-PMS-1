unit RoomerReservationDefinitions;

interface

uses Vcl.Graphics;

const
	STATUS_NOT_ARRIVED = 'P';
  STATUS_ARRIVED = 'G';
  STATUS_CHECKED_OUT = 'D';
  STATUS_CANCELLED = 'C';
  STATUS_WAITING_LIST = 'O';
  STATUS_NO_SHOW = 'N';
  STATUS_ALLOTMENT = 'A';
  STATUS_BLOCKED = 'B';
  STATUS_CANCELED = 'C';
  STATUS_TMP1 = 'W';
  STATUS_AWAITING_PAYMENT = 'Z';
  STATUS_DELETED = 'X';


type

  TRoomerColorSettings = record
    Color : TColor;
    FontColor : TColor;
    FontSize : Integer;
    FontStyle : TFontStyle;
  end;

  TRoomerResStatusType = (rrst_Not_Arrived,
                          rrst_Arrived,
                          rrst_Checked_Out,
                          rrst_Cancelled,
                          rrst_Waiting_List,
                          rrst_No_Show,
                          rrst_Allotment,
                          rrst_Blocking,
                          rrst_Tmp1,
                          rrst_Awaiting_Payment,
                          rrst_Deleted);

  ArrayRoomerResStatusTypeOfColorSettings = Array [rrst_Not_Arrived..rrst_Deleted] OF TRoomerColorSettings;

const
  StatusTypeCount = HIGH(TRoomerResStatusType);


implementation

end.
