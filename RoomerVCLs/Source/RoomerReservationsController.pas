unit RoomerReservationsController;

interface

uses System.Generics.Collections, Data.DB, cmpRoomerDataSet, RoomerTableDefinitions
     ;

type

  TRoomerReservationsController = class
    RoomerDataSet : TRoomerDataSet;
  private
    function CreateReservation(list : TList<TReservation>) : TReservation;
    function CreateRoomReservation(Reservation: TReservation): TRoomReservation;
    function CreatePerson(RoomReservation: TRoomReservation): TPerson;
  public
    constructor Create(DataSet : TRoomerDataSet);

    function RetrieveReservationList(FromDate, ToDate : TDateTime) : TList<TReservation>;
    function RetrieveInvoiceList(FromDate, ToDate : TDateTime) : TList<TReservation>;
  end;

implementation

{ TRoomerReservationsController }

constructor TRoomerReservationsController.Create(DataSet: TRoomerDataSet);
begin
  inherited Create;
  RoomerDataSet := DataSet;
end;

function GetNumberOfRecsInt(ds : TRoomerDataSet; fieldName1, fieldName2 : String; fieldValue1 : Integer) : Integer;
var
  Bookmark : TBookmark;
  iLast : Integer;
begin
  result := 0;
  iLast := -9999999;
  Bookmark := ds.GetBookmark;
  try
    while NOT ds.Eof do
    begin
      if (ds[fieldName1] = fieldValue1) then
      begin
        if (ds[fieldName2] <> iLast) then
        begin
          result := result + 1;
          iLast := ds[fieldName2];
        end;
      end
      else
        Break;

      ds.Next;
    end;
  finally
    ds.GotoBookmark(Bookmark);
    ds.FreeBookmark(Bookmark);
  end;
end;

function GetNumberOfRecsStr(ds : TRoomerDataSet; fieldName1, fieldName2 : String; fieldValue1 : String) : Integer;
var
  Bookmark : TBookmark;
  iLast : Integer;
begin
  result := 0;
  iLast := -9999999;
  Bookmark := ds.GetBookmark;
  try
    while NOT ds.Eof do
    begin
      if (ds[fieldName1] = fieldValue1) then
      begin
        if (ds[fieldName2] <> iLast) then
        begin
          result := result + 1;
          iLast := ds[fieldName2];
        end;
      end
      else
        Break;

      ds.Next;
    end;
  finally
    ds.GotoBookmark(Bookmark);
    ds.FreeBookmark(Bookmark);
  end;
end;

function TRoomerReservationsController.RetrieveInvoiceList(FromDate, ToDate: TDateTime): TList<TReservation>;
//var iNumRes,
//    iNumRoomRes,
//    iNumPers,
//    iNumDays : Integer;
//
//    iLastRes,
//    iLastRoomRes,
//    iLastPers,
//    iLastDays : Integer;
//
//    Reservation : TReservation;
//    RoomReservation : TRoomReservation;
//    Person : TPerson;
begin
//  iLastRes := 0;
//  iLastRoomRes := 0;
//  iLastPers := 0;
//  iLastDays := 0;
//
//  RoomerDataSet.ActivateNewDataset(RoomerDataSet.SystemListReservations(FromDate, ToDate));
//  result := TList<TReservation>.Create;
//  RoomerDataSet.First;
//  while NOT RoomerDataSet.Eof do
//  begin
//    if iLastRes <> RoomerDataSet['rReservation'] then
//    begin
//      Reservation := CreateReservation(result);
//      iLastRes := RoomerDataSet['rReservation'];
//
//      if iLastRoomRes <> RoomerDataSet['rrRoomReservation'] then
//      begin
//        RoomReservation := CreateRoomReservation(Reservation);
//        iLastRoomRes := RoomerDataSet['rrRoomReservation'];
//
//        if iLastPers <> RoomerDataSet['pePerson'] then
//        begin
//          Person := CreatePerson(RoomReservation);
//          iLastPers := RoomerDataSet['pePerson'];
//        end;
//      end;
//    end;
//
//    RoomerDataSet.Next;
//  end;
//
//  while NOT RoomerDataSet.Eof do
//  begin
//    iNumRoomRes := GetNumberOfRecsInt(RoomerDataSet, 'Reservation', 'RoomReservation', RoomerDataSet['Reservation']);
//    iNumPers := GetNumberOfRecsInt(RoomerDataSet, 'RoomReservation', 'peId', RoomerDataSet['RoomReservation']);
//    iNumDays := GetNumberOfRecsInt(RoomerDataSet, 'RoomReservation', 'ADate', RoomerDataSet['RoomReservation']);
//
//
//    RoomerDataSet.Next;
//  end;
end;

function TRoomerReservationsController.CreatePerson(RoomReservation : TRoomReservation) : TPerson;
begin
  result := TPerson.Create(
    RoomerDataSet['peID'],
    RoomerDataSet['pePerson'],
    RoomerDataSet['peRoomReservation'],
    RoomerDataSet['peReservation'],
    RoomerDataSet['petitle'],
    RoomerDataSet['peName'],
    RoomerDataSet['peSurname'],
    RoomerDataSet['peAddress1'],
    RoomerDataSet['peAddress2'],
    RoomerDataSet['peAddress3'],
    RoomerDataSet['peAddress4'],
    RoomerDataSet['peCountry'],
    RoomerDataSet['peCompany'],
    RoomerDataSet['peTel1'],
    RoomerDataSet['peTel2'],
    RoomerDataSet['peFax'],
    RoomerDataSet['peEmail'],
    RoomerDataSet['peGuestType'],
    RoomerDataSet['peInformation'],
    RoomerDataSet['pePID'],
    RoomerDataSet['peMainName'],
    RoomerDataSet['peCustomer'],
    RoomerDataSet['pestate'],
    RoomerDataSet['pesourceId']
  );
  RoomReservation.Guests.Add(result);
end;

function TRoomerReservationsController.CreateRoomReservation(Reservation : TReservation) : TRoomReservation;
begin
  result := TRoomReservation.Create(
    RoomerDataSet['rrID'],
    RoomerDataSet['rrRoomReservation'],
    RoomerDataSet['rrRoom'],
    RoomerDataSet['rrReservation'],
    RoomerDataSet['rrStatus'],
    RoomerDataSet['rrGroupAccount'],
    RoomerDataSet['rrinvBreakfast'],
    RoomerDataSet['rrCurrency'],
    RoomerDataSet['rrDiscount'],
    RoomerDataSet['rrPercentage'],
    RoomerDataSet['rrPriceType'],
    RoomerDataSet['rrArrival'],
    RoomerDataSet['rrDeparture'],
    RoomerDataSet['rrRoomType'],
    RoomerDataSet['rrPMInfo'],
    RoomerDataSet['rrHiddenInfo'],
    RoomerDataSet['rrRoomRentPaymentInvoice'],
    RoomerDataSet['rrHallres'],
    RoomerDataSet['rrrrDescription'],
    RoomerDataSet['rrrrIsNoRoom'],
    RoomerDataSet['rrrrDeparture'],
    RoomerDataSet['rrrrArrival'],
    RoomerDataSet['rrrrRoomTypeAlias'],
    RoomerDataSet['rrrrRoomAlias'],
    RoomerDataSet['rruseStayTax'],
    RoomerDataSet['rruseinNationalReport'],
    RoomerDataSet['rrnumGuests'],
    RoomerDataSet['rrnumChildren'],
    RoomerDataSet['rrnumInfants'],
    RoomerDataSet['rrAvrageRate'],
    RoomerDataSet['rrRateCount'],
    RoomerDataSet['rrdtCreated'],
    RoomerDataSet['rrRoomClass'],
    RoomerDataSet['rrcolorId'],
    RoomerDataSet['rrratePlanCode'],
    RoomerDataSet['rrpercentageDeposit'],
    RoomerDataSet['rrfixedDeposit'],
    RoomerDataSet['rrdepositsInfo'],
    RoomerDataSet['rrpenaltiesInfo'],
    RoomerDataSet['rrcheckoutEventProcessed'],
    RoomerDataSet['rrCOMMISSION'],
    RoomerDataSet['rrCOMMISSION_CURRENCY'],
    RoomerDataSet['rrCHANNEL_ROOM_RES_ID'],
    RoomerDataSet['rrPackage'],
    RoomerDataSet['rrblockMove'],
    RoomerDataSet['rrCodedColor']
  );
  Reservation.Rooms.Add(result);
end;

function TRoomerReservationsController.CreateReservation(list : TList<TReservation>) : TReservation;
begin
  result := TReservation.Create(
          RoomerDataSet['rID'],
          RoomerDataSet['rReservation'],
          RoomerDataSet['rCustomer'],
          RoomerDataSet['rName'],
          RoomerDataSet['rAddress1'],
          RoomerDataSet['rAddress2'],
          RoomerDataSet['rAddress3'],
          RoomerDataSet['rAddress4'],
          RoomerDataSet['rCountry'],
          RoomerDataSet['rTel1'],
          RoomerDataSet['rTel2'],
          RoomerDataSet['rFax'],
          RoomerDataSet['rStatus'],
          RoomerDataSet['rReservationDate'],
          RoomerDataSet['rStaff'],
          RoomerDataSet['rInformation'],
          RoomerDataSet['rPMInfo'],
          RoomerDataSet['rHiddenInfo'],
          RoomerDataSet['rRoomRentPaid1'],
          RoomerDataSet['rRoomRentPaid2'],
          RoomerDataSet['rRoomRentPaid3'],
          RoomerDataSet['rRoomRentPaymentInvoice'],
          RoomerDataSet['rContactName'],
          RoomerDataSet['rContactPhone'],
          RoomerDataSet['rContactPhone2'],
          RoomerDataSet['rContactFax'],
          RoomerDataSet['rContactAddress1'],
          RoomerDataSet['rContactAddress2'],
          RoomerDataSet['rContactAddress3'],
          RoomerDataSet['rContactAddress4'],
          RoomerDataSet['rContactCountry'],
          RoomerDataSet['rContactEmail'],
          RoomerDataSet.FieldByName('rinputsource').AsString[1],
          RoomerDataSet.FieldByName('rwebconfirmed').AsString[1],
          RoomerDataSet['rarrivaltime'],
          RoomerDataSet['rsrcrequest'],
          RoomerDataSet['rCustPID'],
          RoomerDataSet['rinvRefrence'],
          RoomerDataSet['rmarketSegment'],
          RoomerDataSet['rCustomerEmail'],
          RoomerDataSet['rCustomerWebsite'],
          RoomerDataSet['ruseStayTax'],
          RoomerDataSet['rchannel'],
          RoomerDataSet['reventsProcessed'],
          RoomerDataSet['ralteredReservation'],
          RoomerDataSet['rexternalIds'],
          RoomerDataSet['rdtCreated'],
          RoomerDataSet['rnotificationRead'],
          RoomerDataSet['routOfOrderBlocking']);
  list.Add(result);
end;

function TRoomerReservationsController.RetrieveReservationList(FromDate, ToDate: TDateTime): TList<TReservation>;
begin
  RoomerDataSet.ActivateNewDataset(RoomerDataSet.SystemListInvoicesOfReservations(FromDate, ToDate));
  result := TList<TReservation>.Create;
end;

end.
