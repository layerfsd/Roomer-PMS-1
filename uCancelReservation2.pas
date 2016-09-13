unit uCancelReservation2;

(*

 121207 - checked for ww - OK

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
  DB,
  StdCtrls,
  ADODB,

  hData,
  _Glob,
  ug,
  uAppGlobal,


  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxmdaset,
  cxLabel,
  cxButtons,
  cxMaskEdit,
  cxDropDownEdit,
  cxTextEdit,
  cxMemo,
  cxGroupBox

  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, Vcl.Buttons, sLabel, sPanel, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

  ;

type
  TfrmCancelReservation2 = class(TForm)
    Panel1: TsPanel;
    panBottom: TsPanel;
    mRooms : TdxMemData;
    cxGroupBox1 : TcxGroupBox;
    memReason : TcxMemo;
    cxGroupBox2 : TcxGroupBox;
    cbxReason : TcxComboBox;
    cxLabel1: TsLabel;
    cxLabel2: TsLabel;
    cxLabel3: TsLabel;
    cxLabel4: TsLabel;
    labRoomInfo: TsLabel;
    labCustomerInfo: TsLabel;
    labGuestInfo: TsLabel;
    labdateInfo: TsLabel;
    cxLabel5: TsLabel;
    labResStatus: TsLabel;
    sPanel1: TsPanel;
    BitBtn1: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }

    procedure GetInfo;

  public
    { Public declarations }
    zRoomReservation : integer;
    zRoomInfo : string;
    zGuestInfo : string;
    zCustomerInfo : string;
    zDateInfo : string;
    zResStatus : string;

    zReason : string;
    zInformation : string;
    zType : integer;
  end;

var
  frmCancelReservation2 : TfrmCancelReservation2;

implementation

uses
  uD,
  uUtils,
  uRoomerLanguage,
  PrjConst,
  uDimages
  ;
{$R *.dfm}


procedure TfrmCancelReservation2.btnOKClick(Sender: TObject);
begin
  zReason          := cbxReason.Properties.Items[cbxReason.itemindex];
  zType            := cbxReason.itemindex;
  zInformation     := memReason.Text;
end;

procedure TfrmCancelReservation2.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  zRoomReservation := 0;
  zReason          := '';
  zInformation     := '';
  zType            := -1;
end;

procedure TfrmCancelReservation2.FormShow(Sender : TObject);
begin
  cbxReason.ItemIndex := 0;
  GetInfo;
end;

procedure TfrmCancelReservation2.GetInfo;
var
  roomRec      : recRoomInfo;
  customerRec  : recCustomerHolderEX;
  room         : string;
  customer     : string;
  Arrival, Departure : TDate;
begin
  //
  zRoomInfo := '';
  zGuestInfo := '';
  zCustomerInfo := '';
  zDateInfo := '';

  zGuestInfo := d.RR_GetAllGuestNames(zRoomReservation, true, true);

  room    := d.RR_GetRoomNr(zRoomReservation);
  roomRec := Room_GetRec(room);

  zRoomInfo := format(GetTranslatedText('shTx_CancelReservation2_RoomDescriptionAll'),
                  [roomRec.Room, roomRec.Description, roomRec.RoomType, roomRec.RoomTypeDescription, roomRec.LocationDescription]);

  customer := RR_GetCustomer(zRoomReservation);
  customerRec := Customer_GetHolder(customer);

  zCustomerInfo := CustomerRec.CustomerName+' kt: '+CustomerRec.PID;

  Arrival := d.RR_GetArrivalDate(zRoomReservation);
  Departure := d.RR_GetDepartureDate(zRoomReservation);
  zDateInfo := format(GetTranslatedText('shTx_CancelReservation2_GuestArrivalDeparture'),
                  [dateTostr(Arrival), dateToStr(Departure)]);

  zResStatus := GetArrivalText(zRoomreservation);

  labRoomInfo.Caption     := zRoomInfo;
  labGuestInfo.Caption    := zGuestInfo;
  labCustomerInfo.Caption := zCustomerInfo;
  labdateInfo.Caption     := zDateInfo;
  labResStatus.Caption    := zResStatus;
end;




end.
