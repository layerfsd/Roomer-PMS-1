unit uResProblem;

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
 , ExtCtrls
  , ADODB

  , hdata
  , _glob
  , ug

  , Grids
  , BaseGrid
  , AdvGrid
  , AdvObj

  , cmpRoomerDataSet
  , cmpRoomerConnection
  , uUtils, sMemo, sGroupBox, sButton, sPanel, AdvUtil
  ;

type
  TfrmResProblem = class(TForm)
    LMDSimplePanel1: TsPanel;
    btnOK: TButton;
    btnCancel: TsButton;
    LMDBackPanel1: TsPanel;
    rgrOption2: TsRadioGroup;
    gr: TAdvStringGrid;
    Memo1: TsMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure grGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    { Private declarations }
    procedure GridInit;
    procedure GridFill;

  public
    { Public declarations }
    lst : TStringList;

  end;

var
  frmResProblem: TfrmResProblem;

implementation

{$R *.dfm}

uses
   ud
  , uAppGlobal
  , uSqlDefinitions
  , PrjConst
  , uDImages
  , uRoomerDefinitions
  , uReservationStatusDefinitions
  ;


procedure TfrmResProblem.GridInit;
begin
  gr.ColCount  := 8;
  gr.RowCount  := 2;
  gr.FixedCols := 0;

  gr.Cells[0,0] := 'Herb.';
  gr.Cells[1,0] := 'Teg.';
  gr.Cells[2,0] := 'P�ntunn';
  gr.Cells[3,0] := 'Sta�a';
  gr.Cells[4,0] := 'Koma';
  gr.Cells[5,0] := 'Brottf�r';
  gr.Cells[6,0] := 'S';
  gr.Cells[7,0] := '7';


  gr.ColumnSize.Stretch := true;
  gr.ColumnSize.StretchColumn := 2;
end;


procedure TfrmResProblem.GridFill;
var
  i  : integer;
  iRoomReservation : integer;

  sRoom         : string;
  sRoomType     : string;
  sStatus       : string;
  sStatusText   : string;
  sArrival      : string;
  sDeparture    : string;
  sGuest        : string;
  sCustomerName : string;

  rSet   : TRoomerDataSet;
  rrList : string;

  s      : string;
  dtTemp : TdateTime;
  roomStatus  : string;

begin
  GridInit;
  rSet := CreateNewDataSet;
  try
    rSet.CommandType := cmdText;
    if rSet.Active then rSet.Close;

    iRoomReservation := 0;
    rrList := '';
    for i := 0 to lst.Count-1 do
    begin
      try
        iRoomReservation := strToInt(lst[i]);
      except
        continue;
      end;
      rrList := rrList+inttostr(iRoomReservation)+','
    end;

    if length(rrList) = 0 then exit;
    delete(rrList,length(rrList),1);

//    s := '';
//    s := s+ ' SELECT ';
//    s := s+ '       RoomReservations.RoomReservation ';
//    s := s+ '     , RoomReservations.Room  ';
//    s := s+ '     , RoomReservations.Reservation ';
//    s := s+ '     , RoomReservations.Status ';
//    s := s+ '     , RoomReservations.rrArrival ';
//    s := s+ '     , RoomReservations.rrDeparture ';
//    s := s+ '     , Reservations.Customer ';
//    s := s+ '     , Reservations.Name As CustomerName ';
//    s := s+ ' FROM ';
//    s := s+ '   RoomReservations ';
//    s := s+ '   RIGHT OUTER JOIN ';
//    s := s+ '         Reservations ON RoomReservations.Reservation = Reservations.Reservation ';
//    s := s+ ' WHERE (RoomReservation in ('+rrList+') ) ';

    s := format(select_ResProblem_GridFill, [rrList]);
    // CopyToClipboard(s);
    // DebugMessage(''#10#10+s);
    hData.rSet_bySQL(rSet,s);

    while not rSet.Eof do
    begin
      iRoomReservation := rSet.fieldbyname('Roomreservation').AsInteger;
      sRoom            := rSet.fieldbyname('Room').AsString;
      sRoomType        := hdata.GET_RoomsType_byRoom(sRoom);

      dtTemp           := rSet.fieldbyname('rrArrival').AsDateTime;
      dateTimeToString(sArrival,'dd mmm',dtTemp);

      dtTemp           := rSet.fieldbyname('rrDeparture').AsDateTime;
      dateTimeToString(sDeparture,'dd mmm',dtTemp);

      sGuest           := d.RR_GetFirstGuestName(iRoomReservation);
      sCustomerName    := rSet.fieldbyname('CustomerName').AsString;
      sStatus          := rSet.fieldbyname('status').AsString;
      sStatusText      := TReservationStatus.FromResStatus(sStatus).AsReadableString;
      roomStatus       := d.GET_roomstatus(sRoom);


      gr.cells[0,gr.RowCount-1] := sRoom;
      gr.cells[1,gr.RowCount-1] := sRoomType;
      gr.cells[2,gr.RowCount-1] := sCustomerName+' / '+sGuest;
      gr.cells[3,gr.RowCount-1] := sStatusText;
      gr.cells[4,gr.RowCount-1] := sArrival;
      gr.cells[5,gr.RowCount-1] := sDeparture;
      gr.cells[6,gr.RowCount-1] := sStatus;
      gr.cells[7,gr.RowCount-1] := roomStatus;

      rSet.next;
      if not rSet.eof then gr.AddRow;
    end;

  finally
    freeandnil(rSet);
  end;

  gr.AutoSizeColumns(false,1);
  gr.HideColumn(6);
  gr.HideColumn(7);

//  gr.ColumnSize.Stretch := true;
//  gr.ColumnSize.StretchColumn := 2;

end;


//******************************************************************************
//  FORM
//******************************************************************************

procedure TfrmResProblem.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); 
  PlaceFormOnVisibleMonitor(self);
  lst := TstringList.Create;
  rgroption2.ItemIndex := 0;
end;

procedure TfrmResProblem.FormShow(Sender: TObject);
begin
  //**
  GridFill;
end;


procedure TfrmResProblem.FormDestroy(Sender: TObject);
begin
  //**
  lst.Free;
end;

//******************************************************************************
//  Btn
//******************************************************************************

procedure TfrmResProblem.btnCancelClick(Sender: TObject);
begin
  rgroption2.ItemIndex := 2;
end;

procedure TfrmResProblem.grGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  status : string;
  BColor : Tcolor;
  FColor : Tcolor;
  ascIndex  : integer;
  descIndex : integer;
  roomStatus : string;
begin
   status     := gr.cells[6,arow];
   roomStatus := gr.cells[7,arow];
  descIndex := 0;
  ascIndex := 0;
  if ACol = 0 then
  begin
    Fcolor := clNone;
    BColor := clNone;
    if TReservationstatus.fromResStatus(Status).ToColor(BColor, Fcolor) then
    begin
      ABrush.Color := BColor;
      AFont.Color  := FColor;
    end;
  end;


   if (ACol = 2) then
   begin
     Fcolor := clred;
     BColor := clred;
     if TReservationstatus.fromResStatus(roomStatus).ToColor(BColor, Fcolor) then
     begin
       ABrush.Color := BColor;
       AFont.Color  := FColor;
     end;
   end;

end;

end.
