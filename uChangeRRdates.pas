unit uChangeRRdates;

(*
   121207 - checked for ww
*)


interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , StdCtrls
  , Buttons
  , ExtCtrls

  ,_glob
  , ug
  , uAppGlobal
  , ustringUtils

  , cmpRoomerDataSet
  , cmpRoomerConnection

  , ComCtrls
  , PlannerDatePicker
  , sSkinProvider
  , sLabel
  , sGroupBox
  , sPanel
  , sButton, AdvEdit, AdvEdBtn, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, sEdit, sSpinEdit, acProgressBar

  ;

type
  TfrmChangeRRdates = class(TForm)
    Panel1: TsPanel;
    btnCancel: TsButton;
    sSkinProvider1: TsSkinProvider;
    sPanel1: TsPanel;
    gbrNextRR: TsGroupBox;
    labNextName: TsLabel;
    labNextGuest: TsLabel;
    LMDSimpleLabel3: TsLabel;
    LMDSimpleLabel4: TsLabel;
    LMDSimpleLabel5: TsLabel;
    labNextArrival: TsLabel;
    labNextDeparture: TsLabel;
    labNextStatus: TsLabel;
    labNextDays: TsLabel;
    gbrLastRR: TsGroupBox;
    labLastName: TsLabel;
    labLastGuest: TsLabel;
    LMDSimpleLabel6: TsLabel;
    LMDSimpleLabel7: TsLabel;
    LMDSimpleLabel8: TsLabel;
    LabLastArrival: TsLabel;
    labLastDeparture: TsLabel;
    labLastStatus: TsLabel;
    labLastDays: TsLabel;
    Timer1: TTimer;
    LMDSimplePanel1: TsPanel;
    gbxReservationsDates: TsGroupBox;
    labArrival: TsLabel;
    labDeparture: TsLabel;
    labNights: TsLabel;
    labWeekDayFrom: TsLabel;
    labWeekDayTo: TsLabel;
    labErr: TsLabel;
    sGroupBox1: TsGroupBox;
    Label1: TsLabel;
    sLabel1: TsLabel;
    btnOK: TsButton;
    sButton1: TsButton;
    sLabel2: TsLabel;
    labPart1: TsLabel;
    labPart2: TsLabel;
    dtArrival: TsDateEdit;
    dtDeparture: TsDateEdit;
    edNightCount: TsSpinEdit;
    dtSplitAt: TsDateEdit;
    pbProgress: TsProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure dtArrivalChange(Sender: TObject);
    procedure dtDepartureChange(Sender: TObject);
    procedure dtDepartureDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure dtSplitAtChange(Sender: TObject);
    procedure edNightCountChange(Sender: TObject);
  private
    { Private declarations }

    nextRoomReservation : integer;
    nextReservation     : integer;
    nextName      : string;
    nextGuest     : string;

    nextArrival   : Tdate;
    nextDeparture : Tdate;
    nextDays      : integer;

    nextStatus    : string;


    LastRoomReservation : integer;
    LastReservation     : integer;
    LastName      : string;
    LastGuest     : string;

    LastArrival   : Tdate;
    LastDeparture : Tdate;
    LastDays      : integer;

    LastStatus    : string;

    oldArrival   : TDate;
    oldDeparture : TDate;

    zFirstTime : boolean;

    function FuncGetNightCount : boolean;
    function RV_ChangeRoomDates(Reservation : integer) : boolean;

  public
    { Public declarations }
    zArrival   : Tdate;
    zDeparture : Tdate;

    zReservation     : integer;
    zRoomReservation : integer;

    zNights    : Integer;

    zStartIn   : integer;
    zDate      : Tdate;
    zRoom      : string;

    zCalcPrice : boolean;

    zIsPaid : boolean;

  end;

function RR_ChangeDates(RoomReservation : integer; newArrival, newDeparture : Tdate; PriceMedhod : integer; var isPaid : boolean; trx : Boolean = true) : boolean;

var
  frmChangeRRdates: TfrmChangeRRdates;

implementation

uses
    uD
  , uMain
  , hData
  , uProvideARoom2
  , uSqlDefinitions
  , PrjConst
  , uDImages
  , objNewReservation
  , uDateUtils
  , uRoomerDefinitions
  , uUtils

  ;

{$R *.dfm}


  function RR_ChangeDates(RoomReservation : integer; newArrival, newDeparture : Tdate; PriceMedhod : integer;  var isPaid : boolean; trx : Boolean = true) : boolean;
  var
    lst : tstringlist;

    function foundInList(const lookFor : string) : boolean;
    var
      i : integer;
    begin
      result := false;
      for i := 0 to lst.Count - 1 do
      begin
        if _trimlower(lookFor) = lst[i] then
          result := true;
      end;
    end;

  var
    iNumErrors : integer;

    s : string;

    reservation : integer;

    Room : string;
    RoomType : string;
    status : string;

    Currency : string;

    sNewArrival : string;
    sNewDeparture : string;

    sOldArrival : string;
    sOldDeparture : string;

    NumDays : integer;

    Rset : TRoomerDataSet;

    doIt : boolean;
    ii : integer;

    conflict_RoomReservation : integer;
    sConflict_Roomreservation : string;
    chkDate : Tdate;

    DayCount : integer;
    Processed : integer;
    FirstDate : Tdate;
    LastDate : Tdate;

    rate : double;
    sDate : string;

    guestCount  : integer;
    childCount  : integer;
    infantCount : integer;
    PriceID     : integer;

    priceType : string;

    Discount     : double ;
    isPercentage : boolean;
    showDiscount : boolean;


  rd_ : TRoomerDataSet;
  rec      : recRoomsDateHolder;
  recFirst : recRoomsDateHolder;
  recLast  : recRoomsDateHolder;

  rdCount : integer;
  roomRateTotal : double;
  lstPrices     : TstringList;
  roomRate      : double;
  discountTotal : double;
  avrageRate     : double;
  avrageDiscount : double;
  rateCount      : integer;


  oldArrival : Tdate;
  oldDeparture : Tdate;

  oldDayCount : integer;
  newDayCount : integer;

  paidCount : integer;
  isNoRoom : boolean;
  id : integer;
  temp : String;

  ExePlan : TRoomerExecutionPlan;


  begin
  screen.Cursor := crHourglass;
  lstPrices := TstringList.Create;
  try
    lstPrices.Sorted := true;
    lstPrices.Duplicates := dupIgnore;

    sNewArrival    := _DateToDBDate(newArrival,false);
    sNewDeparture  := _DateToDBDate(newDeparture,false);
    NumDays        := trunc(newDeparture) - trunc(newArrival);


    if NumDays < 1 then
    begin
	    Showmessage(GetTranslatedText('shTx_ChangeRRdates_CheckDates'));
      exit;
    end;

    rd_ := CreateNewDataSet;
    try
      s := '';
      s := s+'SELECT * '#10;
      s := s+'FROM roomsdate '#10;
      s := s+'WHERE '#10;
      s := s+'  (roomreservation = %d) '#10;
      s := s+'   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) ';  //zxhj line added
      s := s+'ORDER BY '#10;
      s := s+'  ADate '#10;
      s := format(s , [RoomReservation]);
      if hData.rSet_bySQL(rd_,s) then
      begin
        rdCount   := 0;
        paidCount := 0;
        while not rd_.eof do
        begin
          inc(RdCount);
          if rd_.FieldByName('paid').asBoolean = true  then inc(PaidCount);

          roomRate := rd_.GetFloatValue(rd_.FieldByName('RoomRate'));
          discount := rd_.GetFloatValue(rd_.FieldByName('Discount'));
          lstPrices.Add(floatTostr(RoomRate)+floatTostr(discount));
          roomRateTotal := roomRateTotal+roomRate;
          discountTotal := discountTotal+discount;
          rd_.Next;
        end;
        avrageRate     := roomRateTotal/rdCount;
        avrageDiscount := discountTotal/rdCount;
        rateCount      := lstPrices.Count;
      end;
    finally
    end;

      Discount     := 0.00;
      isPercentage := true;
      showDiscount := true;

        Rset := CreateNewDataSet;
        try
          s := '';
          s := s+'SELECT rr.*, '#10;
//          s := s+'`roomreservations`.`Room`, '#10;
//          s := s+'`roomreservations`.`Reservation`, '#10;
//          s := s+'`roomreservations`.`Discount`, '#10;
//          s := s+'`roomreservations`.`Status`, '#10;
//          s := s+'`roomreservations`.`Arrival`, '#10;
//          s := s+'`roomreservations`.`Departure`, '#10;
//          s := s+'`roomreservations`.`RoomType`, '#10;
//          s := s+'`roomreservations`.`ID`, '#10;
//          s := s+'`roomreservations`.`numGuests`, '#10;
//          s := s+'`roomreservations`.`priceType`, '#10;
//          s := s+'`roomreservations`.`currency`, '#10;
//          s := s+'`roomreservations`.`numChildren`, '#10;
//          s := s+'`roomreservations`.`numInfants`, '#10;
//          s := s+'`roomreservations`.`AvrageRate`, '#10;
//          s := s+'`roomreservations`.`rrArrival`, '#10;
//          s := s+'`roomreservations`.`rrDeparture`, '#10;
//          s := s+'`roomreservations`.`RateCount` '#10;
          s := s+'(SELECT GROUP_CONCAT(RoomReservation) ' +
                 'FROM roomsdate ' +
                 'WHERE ADate BETWEEN ''%s'' AND ''%s'' ' +
                 'AND Room=rr.Room ' +
                 'AND NOT (ResFlag IN (''X'',''C'')) ' +
                 'AND RoomReservation != %d ' +
                 'GROUP BY Room) AS Conflicts,'#10;
          s := s+'(SELECT GROUP_CONCAT(ADate) ' +
                 'FROM roomsdate ' +
                 'WHERE ADate BETWEEN ''%s'' AND ''%s'' ' +
                 'AND RoomReservation = %d) AS existingDates ';
          s := s+'FROM `roomreservations` rr '#10;
          s := s+'WHERE '#10;
          s := s+'  (rr.roomreservation = %d) '#10;
          s := format(s, [dateToSqlString(newArrival),
                          dateToSqlString(newArrival + NumDays - 1),
                          RoomReservation,
                          dateToSqlString(newArrival),
                          dateToSqlString(newArrival + NumDays - 1),
                          RoomReservation,
                          RoomReservation]);

          if hData.rSet_bySQL(rSet,s) then
          begin
            id               := Rset.fieldbyname('ID').asInteger;
            Room             := trim(Rset.fieldbyname('Room').asString);
            reservation      := Rset.fieldbyname('Reservation').asInteger;
            RoomType         := trim(Rset.fieldbyname('RoomType').asString);
            GuestCount       := Rset.fieldbyname('numGuests').asInteger;
            childCount       := Rset.fieldbyname('numChildren').asInteger;
            infantCount      := Rset.fieldbyname('numInfants').asInteger;
            status           := Rset.fieldbyname('Status').asString;
            PriceType        := trim(Rset.fieldbyname('PriceType').asString);
            PriceId          := hdata.PriceCode_ID(priceType); //
            Currency         := trim(Rset.fieldbyname('Currency').asString);
            oldArrival       := _dbDateToDate(Rset.fieldbyname('Arrival').asString);
            oldDeparture     := _dbDateToDate(Rset.fieldbyname('departure').asString);

            temp := Rset.fieldbyname('Conflicts').asString;
            lst := TStringList.Create;
            if TRIM(temp) <> '' then
              lst.AddStrings(SplitStringToTStrings(',', temp));
            try
              doIt := true;
              isNoRoom := false;
//              for ii := trunc(newArrival) to trunc(newArrival) + NumDays - 1 do
//              begin
//                chkDate := ii;
//                if d.isDay_Occupied(chkDate, Room, conflict_RoomReservation) then
//                begin
//                  if conflict_RoomReservation <> RoomReservation then
//                  begin
//                    sConflict_Roomreservation := inttostr(conflict_RoomReservation);
//                    if not foundInList(sConflict_Roomreservation) then
//                      lst.Add(sConflict_Roomreservation);
//                    doIt := false;
//                  end;
//                end;
//              end;

              if lst.Count > 0 then
              begin
                case g.OpenRoomDateProblem(lst) of
                  0 :
                    begin
                      Room := '';
                      isNoRoom := true;
                      doIt := true;
                    end;
                  1 :
                    begin
                      for ii := 0 to lst.Count - 1 do
                      begin
                        conflict_RoomReservation := strToInt(lst[ii]);
                        MoveToRoomEnh2(conflict_RoomReservation, '');
                      end;
                      doIt := true;
                    end;
                  2 :
                    begin
                      doIt := false;
                    end;
                end;
              end;
            finally
              lst.Free;
            end;

            if doIt then
            begin
              iNumErrors := 0;

              temp := Rset.fieldbyname('existingDates').asString;
              lst := TStringList.Create;
              if TRIM(temp) <> '' then
                lst.AddStrings(SplitStringToTStrings(',', temp));

              exePlan := d.roomerMainDataSet.CreateExecutionPlan;
              try
                if trx then rSet.SystemStartTransaction;
                if (status <> 'O') and (status <> 'N') then
                begin
//                  temp := format('(RR_ChangeDates 1) Change dates for Reservation=%d, RoomReservation=%d, Room=%s, RoomType=%s, FROM ArrDate=%s, DepDate=%s',
//                                 [Reservation, RoomReservation, Room, RoomType, DateToSqlString(oldArrival), DateToSqlString(oldDeparture)]);
                  d.roomerMainDataSet.SystemChangeAvailabilityForRoom(RoomReservation, false); //
                end;

                try
                  exePlan.AddExec('UPDATE roomsdate SET ResFlag =' + _db(STATUS_DELETED) + ' WHERE RoomReservation = ' + inttostr(RoomReservation));
//                  d.RemoveRoomsDate(RoomReservation);

                  for ii := trunc(newArrival) to trunc(newArrival) + NumDays - 1 do
                  begin
                    sDate := _dateToDBDate(ii,false);
                    if rateCount = 1 then  //same rate all days 5 11 4 12 3 13 2 14 1 15 0 16 -1
                    begin
                      rd_.First;
                        initRoomsDateHolderRec(rec);
                        rec.ADate := sDate;
                        if room = '' then
                        begin
                          room := '<'+inttostr(roomreservation)+'>';
                          isNoRoom := true;
                        end;
                        rec.Room            := room;
                        rec.isNoRoom        := isNoRoom;
                        rec.RoomType        := roomType;
                        rec.RoomReservation := roomReservation;
                        rec.ResFlag         := status;
                        rec.Reservation     := reservation;
                        rec.PriceCode       := PriceType;
                        rec.RoomRate        := rd_.GetFloatValue(rd_.FieldByName('RoomRate'));
                        rec.Discount        := rd_.GetFloatValue(rd_.FieldByName('Discount'));
                        rec.isPercentage    := rd_.FieldByName('isPercentage').AsBoolean;
                        rec.showDiscount    := rd_.FieldByName('showDiscount').AsBoolean;
                        if paidCount > 0 then
                        begin
                          rec.Paid := true;
                          dec(paidCount);
                        end else
                        begin
                          rec.Paid := false;
                        end;
                        rec.Currency := rd_.FieldByName('Currency').AsString;

  //                      if rd_ExistsByRRandDate(roomReservation,sDate) then
                        if lst.IndexOf(sDate) >= 0 then
                        begin
  //                        updateRdResFlagByRRandDate(roomreservation,sDate,status, {BHG Added!} true,rec.Paid);
                          s :=     ' UPDATE roomsdate ' + #10;
                          s := s + ' SET ' + #10;
                          s := s + '     resFlag  = ' + _db(Status) + ' ' + #10;
                          s := s + '     , Room  = ' + _db(Room) + ' ' + #10;
                          if rec.Paid then
                            s := s + '     , Paid  = 1' + #10
                          else
                            s := s + '     , Paid  = 0' + #10;
                          s := s + ' WHERE ' + #10;
                          s := s + '       (roomreservation= ' + _db(RoomReservation) + ') and (Adate=' + _db(sDate) + ') ' + #10;
                          exePlan.AddExec(s);
                        end else
                        begin
                          exePlan.AddExec(hdata.SQL_INS_RoomsDate(rec));
  //                        if hdata.SQL_INS_RoomsDate(rec) then
  //                        begin
  //                        end;
                        end;
                    end else
                    begin
                       rd_.First;
                       initRoomsDateHolderRec(rec);
                       rec.ADate := sDate;
                       if room = '' then
                       begin
                         room := '<'+inttostr(roomreservation)+'>';
                         isNoRoom := true;
                       end;
                       rec.Room            := room;
                       rec.isNoRoom        := isNoRoom;
                       rec.RoomType        := roomType;
                       rec.RoomReservation := roomReservation;
                       rec.ResFlag         := status;
                       rec.Reservation     := reservation;
                       rec.PriceCode       := PriceType;
                       rec.RoomRate        := avrageRate;
                       rec.Discount        := avrageDiscount;
                       rec.isPercentage    := rd_.FieldByName('isPercentage').AsBoolean;
                       rec.showDiscount    := rd_.FieldByName('showDiscount').AsBoolean;
                       if paidCount > 0 then
                       begin
                         rec.Paid := true;
                         dec(paidCount);
                       end else
                       begin
                         rec.Paid := false;
                       end;
                       rec.Currency := rd_.FieldByName('Currency').AsString;

  //                    if rd_ExistsByRRandDate(roomReservation,sDate) then
                       if lst.IndexOf(sDate) >= 0 then
                       begin
  //                        updateRdResFlagByRRandDate(roomreservation,sDate,status);
                          s :=     ' UPDATE roomsdate ' + #10;
                          s := s + ' SET ' + #10;
                          s := s + '     resFlag  = ' + _db(Status) + ' ' + #10;
                          s := s + '     , Room  = ' + _db(Room) + ' ' + #10;
                          s := s + ' WHERE ' + #10;
                          s := s + '       (roomreservation= ' + _db(RoomReservation) + ') and (Adate=' + _db(sDate) + ') ' + #10;
                          exePlan.AddExec(s);
                       end else
                       begin
                          exePlan.AddExec(hdata.SQL_INS_RoomsDate(rec));
  //                       if hdata.INS_RoomsDate(rec) then
  //                       begin
  //                       end;
                      end;
                    end;
                  end;
                  exePlan.Execute(ptExec, false, false);
                  if (status <> 'O') and (status <> 'N') then
                  begin
    //                temp := format('(RR_ChangeDates 1) Change dates for Reservation=%d, RoomReservation=%d, Room=%s, RoomType=%s, FROM ArrDate=%s, DepDate=%s',
    //                               [Reservation, RoomReservation, Room, RoomType, DateToSqlString(oldArrival), DateToSqlString(oldDeparture)]);
    //                d.roomerMainDataSet.SystemChangeAvailability(RoomType, oldArrival, oldDeparture-1, false, temp); //
    //                temp := format('(RR_ChangeDates 2) Change dates for Reservation=%d, RoomReservation=%d, Room=%s, RoomType=%s, TO ArrDate=%s, DepDate=%s',
    //                               [Reservation, RoomReservation, Room, RoomType, DateToSqlString(newArrival), DateToSqlString(newDeparture)]);
    //                d.roomerMainDataSet.SystemChangeAvailability(RoomType, newArrival, newDeparture-1, true, temp); //
                      d.roomerMainDataSet.SystemChangeAvailabilityForRoom(RoomReservation, true); //
                  end;
                  if trx then rSet.SystemCommitTransaction;
                except
                  if trx then rSet.SystemRollbackTransaction;
                  raise;
                end;
              finally
                FreeAndNil(exePlan);
              end;

              if iNumErrors > 0 then
              begin
                s := '';
              //  s := s + ' Some errors ' + #10;
              //  s := s + inttostr(iNumErrors) + ' total ' + #10 + #10;
                s := s + GetTranslatedText('shTx_ChangeRRdates_SomeErrors') + #10;
                s := s + inttostr(iNumErrors) + GetTranslatedText('shTx_ChangeRRdates_Total') + #10 + #10;
                MessageDlg(s, mtWarning, [mbOK], 0);
              end else
              begin
                Rset.edit;
                Rset.fieldbyname('Room').asString := Room;
                Rset.fieldbyname('Arrival').asString := sNewArrival;
                Rset.fieldbyname('Departure').asString := sNewDeparture;
                Rset.fieldbyname('rrDeparture').asDateTime := newDeparture;
                Rset.fieldbyname('rrArrival').asDateTime := newArrival;
                Rset.Post;
              end;

              d.roomerMainDataSet.SystemCorrectDoorCodeSettings(RoomReservation);
            end;
          end;
      finally
        freeandnil(Rset);
      end;
    result := doIt;
    finally
      freeandNil(lstPrices);
      screen.Cursor := crDefault;
    end;
  end;



function TfrmChangeRRdates.FuncGetNightCount : boolean;

var
  iNights        : integer;
  iDayOfWeekFrom : integer;
  iDayOfWeekTo   : integer;
begin

  labErr.caption := '';
  labErr.Font.Color := clBlack;
  labErr.Color := clBtnface;

  btnOK.Enabled := true;


  try
    iNights :=  trunc(dtDeparture.date ) - trunc(dtArrival.date);
  except
    iNights := 0;
    raise Exception.create( 'iNights Err');
  end;

  edNightCount.Value := iNights;

  iDayOfWeekFrom := DayOfWeek(dtArrival.date);
  iDayOfWeekTo   := DayOfWeek(dtDeparture.date);

  labWeekDayFrom.caption := _strTokenAt(GetTranslatedText('dayStr1'),';',iDayOfWeekFrom-1);
  labWeekDayTo.caption   := _strTokenAt(GetTranslatedText('dayStr1'),';',iDayOfWeekTo-1);

  if iNights = 0 then
  begin
    labErr.Font.Color := clRed;
    labErr.Color := clYellow;

  //  labErr.Caption := 'Villa : Komu- og brottfarardagur sá sami ';
	  labErr.Caption := GetTranslatedText('shTx_ChangeRRdates_ErrorSameDate');
    btnOK.Enabled := false;
  end;

  if iNights < 0 then
  begin
    labErr.Font.Color := clRed;
    labErr.Color := clYellow;

   // labErr.Caption := 'Villa : Komudagur á eftir og brottfarardegi ';
     labErr.Caption := GetTranslatedText('shTx_ChangeRRdates_CheckinAfterCheckout');
    btnOK.Enabled := false;
  end;

  gbrNextRR.color := clBtnFace;
  if dtDeparture.date > nextArrival then
  begin
    labErr.Font.Color := clBlack;
    labErr.Color := clYellow;

    gbrNextRR.color := clRed;
  //  labErr.Caption := 'Aðvörun : Bókanir skarast ';
	 labErr.Caption := GetTranslatedText('shTx_ChangeRRdates_BookingOverlap');
  end;


  gbrLastRR.color := clBtnFace;
  if dtArrival.date < LastDeparture then
  begin
    labErr.Font.Color := clBlack;
    labErr.Color := clYellow;

    gbrLastRR.color := clRed;
   // labErr.Caption := 'Aðvörun : Bókanir skarast ';
	labErr.Caption := GetTranslatedText('shTx_ChangeRRdates_BookingOverlap');
  end;
end;


procedure TfrmChangeRRdates.FormCreate(Sender: TObject);
begin
  zFirstTime := true;
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  //**
  zCalcPrice := false;
end;

procedure TfrmChangeRRdates.FormShow(Sender: TObject);
var
  resInfo : recResDateHolder;
begin
  oldArrival   := zArrival;
  oldDeparture := zDeparture;

  nextArrival    := zDeparture+10; // init to save zone
  LastDeparture  := zArrival-10;   // init to save zone

  dtArrival.Date   := zArrival  ;
  dtDeparture.Date := zDeparture;
  dtSplitAt.date   := zArrival+1;
  if dtSplitAt.date = dtDeparture.Date then sGroupBox1.Enabled := false;

  zIspaid := false;

  zRoom := '';
  if zRoomReservation > 0 then
  begin
    zRoom := RR_GetRoomNumber(zRoomReservation);

    if rd_Ispaid(zRoomReservation) then
    begin
	    showmessage(GetTranslatedText('shTx_ChangeRRdates_PaidInvoicesReviewAfterChange'));
      zIsPaid := true;
    end;
  end;

  NextRoomReservation  := d.NextRoomReservatiaon(zRoom, zRoomreservation, zArrival+1);

  if NextRoomReservation > 1 then
  begin
    resInfo := d.RR_getDates(NextRoomReservation);

    nextReservation := resInfo.Reservation;
    nextArrival     := resInfo.Arrival;
    nextDeparture   := resInfo.Departure;
    nextStatus      := resInfo.Status;

    nextName        := d.RR_GetReservationName(NextRoomReservation);
    nextGuest       := d.RR_GetFirstGuestName(NextRoomReservation);

    nextDays        := 0;
  end else
  begin
    nextReservation := 0;
    nextArrival     := zArrival+700;
    nextDeparture   := zDeparture+700;
    nextStatus      := 'No Reservation';
    nextDays        := 0;
    nextname        := '';
    nextGuest       := '';
  end;

  labNextArrival.Caption   := dateTostr(nextArrival);
  labNextDeparture.Caption := dateTostr(nextDeparture);
  labNextStatus.Caption    := NextStatus;
  labNextDays.caption      := inttostr(nextDays);
  labNextname.Caption      := NextName;
  labNextGuest.Caption     := NextGuest;


  //****************************************************************************

  LastRoomReservation  := d.LastRoomReservatiaon(zRoom, zRoomreservation, zArrival+1);

  if LastRoomReservation > 1 then
  begin
    resInfo := d.RR_getDates(LastRoomReservation);

    LastReservation := resInfo.Reservation;
    LastArrival     := resInfo.Arrival;
    LastDeparture   := resInfo.Departure;
    LastStatus      := resInfo.Status;

    LastName        := d.RR_GetReservationName(LastRoomReservation);
    lastGuest       := d.RR_GetFirstGuestName(LastRoomReservation);

    LastDays        := 0;
  end else
  begin
    LastReservation := 0;
    LastArrival     := zArrival-700;
    LastDeparture   := zDeparture-700;
    LastStatus      := 'No Reservation';
    LastDays        := 0;
    lastname        := '';
    LastGuest       := '';
  end;

  labLastArrival.Caption   := dateTostr(LastArrival);
  labLastDeparture.Caption := dateTostr(LastDeparture);
  labLastStatus.Caption    := lastStatus;
  labLastDays.caption      := inttostr(LastDays);
  labLastname.Caption      := LastName;
  labLastGuest.Caption     := LastGuest;


  case self.zStartIn of
    1 : ActiveControl := dtArrival;
    2 : ActiveControl := dtDeparture;
    3 : ActiveControl := edNightCount;
  end;

  zFirstTime := false;

end;

procedure TfrmChangeRRdates.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**
end;

procedure TfrmChangeRRdates.FormDestroy(Sender: TObject);
begin
  //**
end;

procedure TfrmChangeRRdates.btnOKClick(Sender: TObject);
var
  isPaid : boolean;
  rr,rrAlias : integer;

begin
  //**
  zArrival   := dtArrival.Date;
  zDeparture := dtDeparture.Date;

  if MessageDLG('Change room dates ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if (OldArrival <> zArrival) or (OldDeparture <> zDeparture) then
    begin
      if zRoomReservation = 0 then
      begin
        if not RV_ChangeRoomDates(zReservation) then
        begin
          zArrival   := 1;
          zDeparture := 1;
        end;
      end else
      begin
        isPaid := false;
        if not RR_ChangeDates(zRoomReservation, zArrival, zDeparture,0,isPaid) then
        begin
          zArrival   := 1;
          zDeparture := 1;
        end else
        begin
          if d.isGroup(zRoomReservation) then rr := 0 else rr := zRoomReservation;
          d.roomerMainDataSet.SystempackagesRecalcInvoice(rr, zRoomReservation);
          if ispaid then
          begin
            //
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmChangeRRdates.btnCancelClick(Sender: TObject);
begin
  //**
  zArrival   := 1;
  zDeparture := 1;
end;

procedure TfrmChangeRRdates.dtArrivalChange(Sender: TObject);
begin
  FuncGetNightCount;
end;

procedure TfrmChangeRRdates.dtDepartureChange(Sender: TObject);
begin
  FuncGetNightCount;
end;

procedure TfrmChangeRRdates.dtDepartureDblClick(Sender: TObject);
begin
  dtDeparture.Date := dtArrival.Date+1;
end;


procedure TfrmChangeRRdates.dtSplitAtChange(Sender: TObject);
begin
  if zFirstTime then exit;

  if dtSplitAt.date < zArrival+1  then dtSplitAt.date := zArrival+1;
  if dtSplitAt.date > zDeparture-1  then dtSplitAt.date := zDeparture-1;
end;

function TfrmChangeRRdates.RV_ChangeRoomDates(Reservation : integer) : boolean;
var
  bAll: Boolean;
  noOfRooms: Integer;
  S: string;
  Numdays: Integer;
  rSet   : TRoomerDataSet;
  roomReservation: integer;
  changeCount : integer;

  dateHolder : recResDateHolder;
  isPaid : boolean;
  rr,
  iCount : integer;

begin
  bAll := true;

  changeCount := 0;
  noOfRooms := d.RR_GetNumberOfRooms(Reservation);

  dateHolder := d.RV_getDates(Reservation);

  if noOfRooms > 1 then
  begin
    if not d.isAllDatesSameInRes(Reservation) then
    begin
    (*  S := S + 'Ekki allar dagsetningar herbergja eru í ' + #10;
      S := S + 'samræmi við dagsetninu pöntunar ' + #10;
      S := S + '- viltu breyta þeim öllum ? ' + #10 + #10;
      S := S + 'Veljir þú "nei" [NO] þá breytast dagsetningar aðeins ' + #10;
      S := S + 'hjá þeim herbergjum sem hafa dagsetningu pöntunnar ' + #10; *)
	    S := GetTranslatedText('shTx_ChangeRRdates_RoomDatesChangeAll') + #10;
      bAll := MessageDlg(S, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    end;
  end;

  rSet := CreateNewDataSet;
  try
    S := '';
    S := select_ReservationProfile_RegulateRoomDates(bAll);
    if NOT bAll then
      S := format(S, [Reservation, _DateToDBDate(dateHolder.Arrival, true),
                      _DateToDBDate(dateHolder.Departure, true)])
    else
      S := format(S, [Reservation]);

    rSet.SystemStartTransaction;
    try
      hData.rSet_bySQL(rSet, S);

      Numdays := trunc(dtDeparture.Date) - trunc(dtArrival.Date);

      if Numdays < 1 then
      begin
        showmessage(GetTranslatedText('shTx_ChangeRRdates_MustBe1Day'));

      end
      else
      begin
        screen.Cursor := crHourGlass;
        try
          iCount := 0;
          rSet.First;
          while not rSet.Eof do
          begin
            inc(iCount);
            rSet.Next;
          end;

          pbProgress.Max := iCount * 2;
          pbProgress.Position := 0;
          pbProgress.Visible := True;
          iCount := 0;
          pbProgress.Update;

          rSet.First;
          while not rSet.Eof do
          begin
            roomReservation := rSet.fieldbyname('RoomReservation').asinteger;

            if d.isGroup(roomreservation) then rr := 0 else rr := roomreservation;

            changeCount := changeCount+1;
            isPaid := false;
            RR_ChangeDates(roomReservation, dtArrival.Date,dtDeparture.Date,0,isPaid, false);

            inc(iCount);
            pbProgress.Position := iCount;
            pbProgress.Update;
            rSet.Next;
          end;

          rSet.First;
          while not rSet.Eof do
          begin
            roomReservation := rSet.fieldbyname('RoomReservation').asinteger;
            if rSet['Groupaccount'] then rr := 0 else rr := roomreservation;
//            if d.isGroup(roomreservation) then rr := 0 else rr := roomreservation;

            d.roomerMainDataSet.SystempackagesRecalcInvoice(rr, roomReservation);

            inc(iCount);
            pbProgress.Position := iCount;
            pbProgress.Update;
            rSet.Next;
          end;
        finally
          screen.Cursor := crDefault;
        end;
      end;
      rSet.SystemCommitTransaction;
    except
      rSet.SystemRollbackTransaction;
      raise;
    end;
  finally
    freeAndNil(rSet);
  end;

  if changeCount > 0 then
  begin
    result := true;
    zArrival   := dtArrival.Date;
    zDeparture := dtDeparture.Date;
  end;

  BringToFront;
end;



procedure TfrmChangeRRdates.sButton1Click(Sender: TObject);
var
  rSet : TRoomerDataSet;


  Arrival1   : TdateTime;
  Departure1 : TdateTime;

  Arrival2   : TdateTime;
  Departure2 : TdateTime;

  roomHolder : recRoomReservationHolder;

  firstHolder  : recRoomReservationHolder;

  lstRoomPrices : TstringList;
  lstR : TstringList;

  newRrId : integer;
  s : string;

  ExecutionPlan : TRoomerExecutionPlan;
  sDate     : string;
  iDayCount : integer;
  ii : integer;
  personData : RecPersonHolder;
  package : string;
  rr : integer;

begin
  //**
  if MessageDLG('Split reservation at '+datetostr(dtSplitAt.date), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    roomHolder   := SP_GET_RoomReservation(zRoomReservation);
    firstHolder  := roomHolder;
    package := roomHolder.package;


    Arrival1   := zArrival;
    departure1 := dtSplitAt.Date;
    Arrival2   := dtSplitAt.Date;
    departure2 := zDeparture;

    ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try
      ExecutionPlan.BeginTransaction;
      try

        newRRid := RR_SetNewID();
        firstholder.RoomReservation := newRRid;
        firstholder.Arrival     := _dateToDBdate(arrival1, false);
        firstholder.Departure   := _dateToDBdate(departure1, false); ;
        firstholder.rrArrival   := arrival1;
        firstholder.rrDeparture := departure1;


        Rset := CreateNewDataSet;
        try
          s := '';
          s := s+' SELECT '#10;
          s := s+'  AVG(RoomRate) AS avrageRate '#10;
          s := s+'  ,count(distinct RoomRate) AS rateCount '#10;
          s := s+' FROM  '#10;
          s := s+'   roomsdate '#10;
          s := s+' WHERE (ADate >= %s '#10;
          s := s+'  and ADate < %s) '#10;
          s := s+' AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '#10;
          s := s+' AND (roomreservation = '+_db(roomholder.RoomReservation)+') '#10;
          s := format(s, [_DatetoDBDate(Arrival1,true),_DatetoDBDate(Departure1,true)]);

          if hData.rSet_bySQL(rSet,s) then
          begin
            firstholder.avrageRate  := rSet.GetFloatValue(rSet.FieldByName('avrageRate'));
            firstholder.rateCount   := rSet.FieldByName('rateCount').asInteger;
          end;
         finally
           freeandnil(Rset);
         end;

         s := SQL_INS_RoomReservation(firstHolder);
  //       copyToClipboard(s);
  //       DebugMessage('invoicelines '#10#10+s);
         ExecutionPlan.AddExec(s);



        roomHolder.Arrival     := _dateToDBdate(arrival2, false);
        roomHolder.Departure   := _dateToDBdate(departure2, false); ;
        roomHolder.rrArrival   := arrival2;
        roomHolder.rrDeparture := departure2;


        Rset := CreateNewDataSet;
        try
          s := '';
          s := s+' SELECT '#10;
          s := s+'  AVG(RoomRate) AS avrageRate '#10;
          s := s+'  ,count(distinct RoomRate) AS rateCount '#10;
          s := s+' FROM  '#10;
          s := s+'   roomsdate '#10;
          s := s+' WHERE (ADate >= %s '#10;
          s := s+'  and ADate < %s) '#10;
          s := s+' AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '#10;
          s := s+' AND (roomreservation = '+_db(roomholder.RoomReservation)+') '#10;
          s := format(s, [_DatetoDBDate(Arrival2,true),_DatetoDBDate(Departure2,true)]);

          if hData.rSet_bySQL(rSet,s) then
          begin
            roomHolder.avrageRate  := rSet.GetFloatValue(rSet.FieldByName('avrageRate'));
            roomHolder.rateCount   := rSet.FieldByName('rateCount').asInteger;
          end;
         finally
           freeandnil(Rset);
         end;

         s := '';
         s := s+' UPDATE roomreservations ';
         s := s+' SET ';
         s := s+'  Arrival = '+_DB(arrival2)+' ';
         s := s+' ,Departure = '+_DB(departure2)+' ';
         s := s+' ,rrArrival = '+_db(Arrival2)+' ';
         s := s+' ,rrDeparture = '+_db(departure2)+' ';
         s := s+' ,avrageRate = '+_db(roomHolder.avrageRate)+' ';
         s := s+' ,rateCount = '+_db(roomHolder.rateCount)+' ';

         s := s+' WHERE ';
         s := s+'   (roomreservation='+_db(roomholder.RoomReservation)+') ';
  //       copyToClipboard(s);
  //       DebugMessage('invoicelines '#10#10+s);
         ExecutionPlan.AddExec(s);

         iDayCount := trunc(Departure1) - trunc(Arrival1);
         for ii := trunc(Arrival1) to trunc(Arrival1) + iDayCount - 1 do
         begin
           sDate := _DateToDBDate(ii, false);
           s := '';
           s := s+' UPDATE roomsdate ';
           s := s+' SET ';
           s := s+' roomreservation = '+_db(newRRid)+' ';
           s := s+' WHERE ';
           s := s+'   (Adate = '+_db(sDate)+') ';
           s := s+'  AND (roomreservation='+_db(roomholder.RoomReservation)+') ';

  //         copyToClipboard(s);
  //         DebugMessage(s);
           ExecutionPlan.AddExec(s);
         end;

        Rset := CreateNewDataSet;
         try
          s := '';
          s := s+' SELECT '#10;
          s := s+'  * '#10;
          s := s+' FROM  '#10;
          s := s+'   persons '#10;
          s := s+' WHERE '#10;
          s := s+' (roomreservation = '+_db(roomholder.RoomReservation)+') '#10;

          if hData.rSet_bySQL(rSet,s) then
          begin
            while not rSet.eof do
            begin
              initPersonHolder(personData);
              personData.Person          := rSet.FieldByName('person').AsInteger;
              personData.RoomReservation := newRRid;
              personData.Reservation     := rSet.FieldByName('Reservation').AsInteger;
              personData.name            := rSet.FieldByName('name').AsString;
              personData.Surname         := rSet.FieldByName('Surname').AsString;
              personData.Address1        := rSet.FieldByName('Address1').AsString;
              personData.Address2        := rSet.FieldByName('Address2').AsString;
              personData.Address3        := rSet.FieldByName('Address3').AsString;
              personData.Address4        := rSet.FieldByName('Address4').AsString;
              personData.Country         := rSet.FieldByName('Country').AsString;
              personData.Company         := rSet.FieldByName('Company').AsString;
              personData.GuestType       := rSet.FieldByName('GuestType').AsString;
              personData.Information     := rSet.FieldByName('Information').AsString;
              personData.PID             := rSet.FieldByName('PID').AsString;
              personData.MainName        := rSet.FieldByName('MainName').AsBoolean;
              personData.Customer        := rSet.FieldByName('Customer').AsString;
              personData.peTmp           := rSet.FieldByName('peTmp').AsString;
              s := SQL_INS_Person(personData);
  //            copyToClipboard(s);
  //            DebugMessage('invoicelines '#10#10+s);
              ExecutionPlan.AddExec(s);
              rSet.Next;
            end;
          end;

        finally
           freeandnil(Rset);
        end;


        if ExecutionPlan.Execute(ptExec, False, True) then
            ExecutionPlan.CommitTransaction
         else
          raise Exception.Create(ExecutionPlan.ExecException);

        if package <> '' then
        begin
          if d.isGroup(Zroomreservation) then rr := 0 else rr := Zroomreservation;


//          d.roomerMainDataSet.SystempackagesAdd(package, rr, newRRid, roomHolder.avrageRate);
          d.roomerMainDataSet.SystempackagesRecalcInvoice(rr, zRoomReservation);
        end;


      except
        on e: exception do
        begin
            ExecutionPlan.RollbackTransaction;
            showMessage('Splitting reservation: ' + e.message);
        end;
      end;
    finally
      freeandNil(ExecutionPlan);
    end;
  end;
end;

procedure TfrmChangeRRdates.edNightCountChange(Sender: TObject);
var
  iDayOfWeekFrom : integer;
  iDayOfWeekTo   : integer;
  s              : string;
begin
  zDate   :=  dtArrival.date + edNightCount.Value;
  zNights :=  edNightCount.Value;
  dateTimeToString(s,'dd.mm.yyyy',zdate);

  iDayOfWeekFrom := DayOfWeek(dtArrival.date);
  iDayOfWeekTo   := DayOfWeek(zDate);

  labWeekDayFrom.caption := _strTokenAt(GetTranslatedText('dayStr1'),';',iDayOfWeekFrom-1);
  labWeekDayTo.caption := _strTokenAt(GetTranslatedText('dayStr1'),';',iDayOfWeekTo-1);

  dtDeparture.Date := zDate;
end;

procedure TfrmChangeRRdates.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled := false;
  close;
end;

end.
