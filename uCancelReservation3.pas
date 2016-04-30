unit uCancelReservation3;

(*

 121207 - checked for ww - OK
 130206 - Jóel
          Breytti textum sjá excel skjal
*)


interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  Menus,
  StdCtrls,
  DB,
  ug,
  ADODB,

  hData,
  _Glob,

  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxDBData,
  dxmdaset,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  cxLabel,
  cxButtons,
  cxMaskEdit,
  cxDropDownEdit,
  cxTextEdit,
  cxMemo,
  cxGroupBox,
  cxNavigator

  , uUtils
  , uAppGlobal
  , cmpRoomerDataSet, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, Vcl.Buttons, sButton, sLabel, sComboBox, sMemo, sGroupBox, sPanel, dxSkinCaramel, dxSkinCoffee,
  dxSkinTheAsphaltWorld
  ;

type
  TfrmCancelReservation3 = class(TForm)
    Panel1: TsPanel;
    panBottom: TsPanel;
    mRooms : TdxMemData;
    cxGroupBox1: TsGroupBox;
    memReason: TsMemo;
    cxGroupBox2: TsGroupBox;
    cbxReason: TsComboBox;
    cxLabel2: TsLabel;
    labCustomerInfo: TsLabel;
    Panel2: TsPanel;
    tvRooms: TcxGridDBTableView;
    lvRooms: TcxGridLevel;
    gRooms: TcxGrid;
    mRoomsDS: TDataSource;
    mRoomsRoom: TWideStringField;
    mRoomsRoomType: TWideStringField;
    mRoomsGuests: TWideStringField;
    mRoomsArrival: TDateTimeField;
    mRoomsDeparture: TDateTimeField;
    tvRoomsRecId: TcxGridDBColumn;
    tvRoomsRoom: TcxGridDBColumn;
    tvRoomsRoomType: TcxGridDBColumn;
    tvRoomsGuests: TcxGridDBColumn;
    tvRoomsArrival: TcxGridDBColumn;
    tvRoomsDeparture: TcxGridDBColumn;
    mRoomsStatus: TWideStringField;
    tvRoomsStatus: TcxGridDBColumn;
    labRoomInfo: TsLabel;
    mRoomsSelect: TBooleanField;
    tvRoomsSelect: TcxGridDBColumn;
    panSelect: TsPanel;
    cxButton1: TsButton;
    cxButton3: TsButton;
    mRoomsRoomReservation: TIntegerField;
    cxButton4: TsButton;
    sPanel1: TsPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure mRoomsAfterEdit(DataSet: TDataSet);
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }

    roomCount   : integer;
    selectCount : integer;

    procedure GetInfo;
    procedure GetData;
    procedure updateSelectCaption;

  public
    { Public declarations }
    zRoomReservation : integer;
    zReservation : integer;

    zRoomInfo : string;
    zCustomerInfo : string;

    zReason : string;
    zInformation : string;
    zType : integer;
    zRoomReservations : string;
    zRooms : string;
    zAll : boolean;
  end;

var
  frmCancelReservation3 : TfrmCancelReservation3;

implementation

uses
  uSqlDefinitions
  ,uRoomerLanguage
  ,uD
  ,PrjConst
  ,uDimages
  ;
{$R *.dfm}


procedure TfrmCancelReservation3.updateSelectCaption;
begin
//  if selectCount = mRooms.RecordCount then zInformation := 'Removing ALL rooms from reservation' else zInformation := 'Removing '+inttostr(selectCount)+' rooms of '+inttostr(roomCount)+' rooms ';
  if selectCount = mRooms.RecordCount then
    zInformation := GetTranslatedText('shTx_CancelReservation3_RemovingAllRooms')
  else
    zInformation := format(GetTranslatedText('shTx_CancelReservation3_RemovingXRoomsOfYReservedRooms'), [selectCount, roomCount]);
  labRoomInfo.caption := zInformation;
end;


procedure TfrmCancelReservation3.GetData;
var
  rSet : TRoomerDataSet;
  Room : string;
  RoomType : string;
  Guests : string;
  Status : string;
  Arrival, Departure : TDate;
  s : string;
begin
  rSet := CreateNewDataSet;
  try
    
    rSet.CommandType := cmdText;

    s := '';
    s := s+ ' SELECT ';
    s := s+ '     RoomReservation ';
    s := s+ '   , Room ';
    s := s+ '   , RoomType ';
    s := s+ '   , Reservation ';
    s := s+ '   , Status ';
    s := s+ '   , rrArrival ';
    s := s+ '   , rrDeparture ';
    s := s+ ' FROM ';
    s := s+ '   roomreservations ';
    s := s+ ' WHERE ';
    s := s+ '   (Reservation = '+_db(zReservation)+') ';
    s := s+ ' ORDER BY room ';

    s := format(select_CancelReservation3_GetData , [zReservation]);
//    CopyToClipboard(s);
//    DebugMessage('select_CancelReservation3_GetData'#10#10+s);
    hData.rSet_bySQL(rSet,s);

    if mRooms.Active then mRooms.close;
    mRooms.Open;

    while not rSet.Eof do
    begin
      Arrival    := rSet.fieldbyname('rrArrival').asDateTime;
      Departure  := rSet.fieldbyname('rrDeparture').asDateTime;
      Room       := rSet.fieldbyname('room').asString;
      RoomType   := rSet.fieldbyname('roomType').asString;
      Status     := rSet.fieldbyname('Status').asString;
      Status     := _StatusToText(status);
      Guests     := d.RR_GetAllGuestNames(zRoomReservation, true, true);

      mRooms.Append;
      mRooms.FieldByName('Arrival').AsDateTime   := Arrival;
      mRooms.FieldByName('Departure').AsDateTime := Departure;
      mRooms.FieldByName('Room').AsWideString        := Room;
      mRooms.FieldByName('RoomType').AsWideString    := RoomType;
      mRooms.FieldByName('Status').AsWideString      := Status;
      mRooms.FieldByName('Guests').AsWideString      := Guests;
      mRooms.FieldByName('RoomReservation').AsInteger := rSet.FieldByName('roomreservation').AsInteger;;
      mRooms.FieldByName('Select').AsBoolean     := true;

      mRooms.Post;

      rSet.Next
    end;

    roomCount := mRooms.recordCount;
    selectCount := roomCount;
    updateSelectCaption;
  finally
    freeandNil(rSet);
  end;

end;


procedure TfrmCancelReservation3.btnOKClick(Sender: TObject);
begin
  zReason          := cbxReason.Items[cbxReason.itemindex];
  zType            := cbxReason.itemindex;
  zInformation     := memReason.Text;
  zAll := false;
  if selectCount = mRooms.RecordCount then zAll := true;

  if mRoomsDS.State = dsEdit then mRooms.Post;

  zRoomReservations := '';
  zRooms :=  '';

  mRooms.First;
  while not mRooms.eof do
  begin
    if mRooms.fieldbyname('Select').asBoolean then
    begin
      zRoomreservations := zRoomReservations+mRooms.FieldByName('RoomReservation').AsString+';';
      zRooms := zRooms+mRooms.FieldByName('Room').AsString+',';
    end;
    mRooms.Next;
  end;
  if zRoomReservations <> '' then delete(zRoomReservations,length(zroomReservations),1);
  if zRooms <> '' then delete(zRooms,length(zrooms),1);
end;

procedure TfrmCancelReservation3.cxButton1Click(Sender: TObject);
begin
  mRooms.First;
  while not mrooms.Eof do
  begin
    mRooms.Edit;
    mRooms.FieldByName('Select').AsBoolean := true;
    mRooms.Next;
  end;

  mRooms.First;


  roomCount   := mRooms.recordCount;
  selectCount := roomCount;
  updateSelectCaption;
end;

procedure TfrmCancelReservation3.cxButton3Click(Sender: TObject);
begin
  mRooms.First;
  while not mrooms.Eof do
  begin
    mRooms.Edit;
    mRooms.FieldByName('Select').AsBoolean := false;
    mRooms.Next;
  end;

  mRooms.First;

  roomCount := mRooms.recordCount;
  selectCount := 0;
  updateSelectCaption;
end;

procedure TfrmCancelReservation3.cxButton4Click(Sender: TObject);
begin
  tvRooms.OptionsData.Editing := true;
  tvRoomsselect.visible := true;
  cxButton1.Visible := true;
  cxButton3.Visible := true;


  mRooms.First;
  while not mrooms.Eof do
  begin
    mRooms.Edit;
    mRooms.FieldByName('Select').AsBoolean := false;
    mRooms.Next;
  end;
  mRooms.First;

  roomCount := mRooms.recordCount;
  selectCount := 0;
  updateSelectCaption;


end;

procedure TfrmCancelReservation3.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  zRoomReservation  := 0;
  zReason           := '';
  zInformation      := '';
  zRooms            := '';
  zRoomReservations := '';
  zType             := -1;
  zAll := true;
end;

procedure TfrmCancelReservation3.FormShow(Sender : TObject);
begin
  cbxReason.ItemIndex := 0;
  zReservation := RR_GetReservation(zRoomReservation);
  GetInfo;
  GetData;
end;

procedure TfrmCancelReservation3.GetInfo;
var
  customerRec  : recCustomerHolderEX;
  customer     : string;
begin
  zRoomInfo := GetTranslatedText('shTx_CancelReservation3_RemovingAllRooms');
  zCustomerInfo := '';
  customer := RR_GetCustomer(zRoomReservation);
  customerRec := Customer_GetHolder(customer);
  zCustomerInfo := CustomerRec.CustomerName+' id: '+CustomerRec.PID;
  labRoomInfo.Caption     := zRoomInfo;
  labCustomerInfo.Caption := zCustomerInfo;
end;


procedure TfrmCancelReservation3.mRoomsAfterEdit(DataSet: TDataSet);
var
  status : boolean;
begin
  status := mRooms['Select'];
  if status then dec(selectCount) else inc(selectCount);
  updateSelectCaption;
end;

end.
