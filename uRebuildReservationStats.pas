unit uRebuildReservationStats;

interface

uses
    Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes

  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.Menus
  , Vcl.ComCtrls
  , Vcl.StdCtrls
  , shellApi

  , Data.DB
  , Data.Win.ADODB
  , Vcl.ExtCtrls

  , _Glob
  , hData
  , uG

  , cxGridExportLink

  , cxGraphics
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxControls
  , cxContainer
  , cxEdit
  , cxStyles
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxNavigator
  , cxDBData
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGrid
  , dxmdaset
  , cxProgressBar
  , dxStatusBar
  , cxButtons, kbmMemTable, kbmMemSQL

  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter
  ;

type
  TfrmRebuildReservationStats = class(TForm)
    dxStatusBar1: TdxStatusBar;
    dxStatusBar1Container1: TdxStatusBarContainerControl;
    barProcess: TcxProgressBar;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRebuildReservationStats: TfrmRebuildReservationStats;

implementation

{$R *.dfm}

uses
  uD
 ,uSqlDefinitions
;



function DateRangeIndex(aDate,dateFrom,DateTo : TdateTime) : integer;
var
  index1 : integer;
  index2 : integer;
begin
  result := -1;
  index1 := trunc(aDate)-trunc(dateFrom);
  index2 := trunc(dateTo)-trunc(aDate);
  if (index1 >= 0) and (index2 >0) then
  begin
    result := index1;
  end;
end;


procedure TfrmRebuildReservationStats.Button1Click(Sender: TObject);
var
  s : string;
  value : double;
  roomreservation : integer;
  ok : boolean;

  begTick   : integer;
  finTick   : integer;
  resTick   : integer;

  recCount : integer;
  currency : string;
  RoomRentUnBilled : double;

  lstRates : TstringList;

  Arrival   : TDateTime;
  Departure : TDateTime;

  rrDateCount : integer;

  dateFrom : TDateTime;
  dateTo   : TDateTime;

  Price1From : TdateTime;
  Price1To   : TdateTime;

  Price2From : TdateTime;
  Price2To   : TdateTime;

  Price3From : TdateTime;
  Price3To   : TdateTime;

  roomRate1  : double;
  roomrate2  : double;
  roomrate3  : double;

  i: Integer;

  aDate : Tdate;
  paid : boolean;

  daysPaid  : integer;
  priceCode : string;

  isPercentage : boolean;
  Discount     : double ;
  showDiscount : boolean;

  rSet : TRoomerDataSet;
  ii : integer;

begin
  s := '';
//  s := s+' SELECT '+#10;
//  s := s+'     RoomReservation '+#10;
//  s := s+'   , Reservation '+#10;
//  s := s+'   , rrArrival '+#10;
//  s := s+'   , rrDeparture '+#10;
//  s := s+'   , Currency '+#10;
//  s := s+'   , Discount '+#10;
//  s := s+'   , Percentage '+#10;
//  s := s+'   , PriceType '+#10;
//  s := s+'   , RoomPrice1 '+#10;
//  s := s+'   , Price1From '+#10;
//  s := s+'   , Price1To '+#10;
//  s := s+'   , RoomRentPaid1 '+#10;
//  s := s+'   , RoomPrice2 '+#10;
//  s := s+'   , Price2From '+#10;
//  s := s+'   , Price2To '+#10;
//  s := s+'   , RoomRentPaid2 '+#10;
//  s := s+'   , RoomPrice3 '+#10;
//  s := s+'   , Price3From '+#10;
//  s := s+'   , Price3To '+#10;
//  s := s+'   , RoomRentPaid3 '+#10;
//  s := s+' FROM '+#10;
//  s := s+'   RoomReservations '+#10;
//  s := s+' ORDER BY '+#10;
//  s := s+'   RoomReservation desc '+#10;
  screen.Cursor := crHourGlass;
  try
      d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + 'pms/business/home_to_roomer_roomsdate');
//    rSet := CreateNewDataSet;
//    try
//      s := format(select_RebuildReservationStats_Button1Click , []);
//      rSet_bySQL(rSet,s);
//      recCount := rSet.RecordCount;
//      barProcess.Properties.Max := recCount;;
//      barProcess.Position := 0;
//
//      rSet.First;
//      while not rSet.eof do
//      begin
//        barProcess.Position :=  barProcess.Position + 1;
//        inc(ii);
//        roomReservation := rSet.FieldByName('roomreservation').asInteger;
//
//        arrival     := rSet.FieldByName('rrarrival').asDateTime;
//        departure   := rSet.FieldByName('rrdeparture').asDateTime;
//        rrDateCount := trunc(departure)-trunc(arrival);
//
//        roomRate1  := LocalFloatValue(rSet.FieldByName('RoomPrice1').asString);
//        roomrate2  := LocalFloatValue(rSet.FieldByName('RoomPrice2').asString);
//        roomrate3  := LocalFloatValue(rSet.FieldByName('RoomPrice3').asString);
//
//        Price1From := _dbDateToDate(rSet.FieldByName('Price1From').asString);
//        Price1To   := _dbDateToDate(rSet.FieldByName('Price1To').asString);
//
//        Price2From := _dbDateToDate(rSet.FieldByName('Price2From').asString);
//        Price2To   := _dbDateToDate(rSet.FieldByName('Price2To').asString);
//
//        Price3From := _dbDateToDate(rSet.FieldByName('Price3From').asString);
//        Price3To   := _dbDateToDate(rSet.FieldByName('Price3To').asString);
//
//        Currency := rSet.FieldByName('Currency').asString;
//
//
//        daysPaid     := rSet.FieldByName('RoomRentPaid1').asInteger+
//                        rSet.FieldByName('RoomRentPaid2').asInteger+
//                        rSet.FieldByName('RoomRentPaid3').asInteger;
//
//        priceCode    := rSet.FieldByName('PriceType').asString;
//        isPercentage := rSet['Percentage'];
//        discount     := LocalFloatValue(rSet.FieldByName('discount').asString);
//        showDiscount := true;
//
//        Value := RoomRate1;
//        aDate := trunc(Arrival);
//        for i := 1 to rrDateCount do
//        begin
//          if DateRangeIndex(aDate,price1From,price1To) >= 0 then
//          begin
//            value := RoomRate1;
//          end else
//          if DateRangeIndex(aDate,price2From,price2To) >= 0 then
//          begin
//            value := RoomRate2;
//          end else
//          if DateRangeIndex(aDate,price3From,price3To) >= 0 then
//          begin
//            value := RoomRate3;
//          end;
//
//          paid := (daysPaid >= i);
//          s := '';
//          s := s+' UPDATE '+#10;
//          s := s+'    roomsdate '+#10;
//          s := s+'    SET '+#10;
//          s := s+'       RoomRate = '+_db(value)+' '+#10;
//          s := s+'      ,Currency = '+_db(currency)+' '+#10;
//          s := s+'      ,paid = '+_db(paid)+' '+#10;
//          s := s+'      ,priceCode = '+_db(priceCode)+' '+#10;
//          s := s+'      ,isPercentage = '+_db(isPercentage)+' '+#10;
//          s := s+'      ,Discount = '+_db(Discount)+' '+#10;
//          s := s+'      ,showDiscount = '+_db(showDiscount)+' '+#10;
//          s := s+'  WHERE '+#10;
//          s := s+'    (RoomReservation = '+_db(roomreservation)+') '+#10;
//          s := s+'  AND (aDate = '+_glob._dateToDBDate(aDate,true)+')'+#10;
//          ok := cmd_bySQL(s);
//          aDate := aDate+1;
//        end;
//        rSet.Next;
//      end;
//      finTick   := GetTicKcount;
//    finally
//      freeandNil(rSet);
//    end;
//      finTick   := GetTicKcount;
     showmessage('Finished')
  finally
    screen.Cursor := crDefault;
  end;
end;


end.




