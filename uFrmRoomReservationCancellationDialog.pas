unit uFrmRoomReservationCancellationDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sLabel, sCheckBox, sMemo, sButton, Vcl.ExtCtrls, sPanel, cxClasses, cxPropertiesStore;

type
  TFrmRoomReservationCancellationDialog = class(TForm)
    sLabel1: TsLabel;
    lblResName: TsLabel;
    sLabel3: TsLabel;
    lblContact: TsLabel;
    sLabel5: TsLabel;
    lblArrival: TsLabel;
    sLabel7: TsLabel;
    lblDeparture: TsLabel;
    sLabel9: TsLabel;
    lblRooms: TsLabel;
    sLabel11: TsLabel;
    lblGuests: TsLabel;
    sPanel1: TsPanel;
    sButton1: TsButton;
    sButton2: TsButton;
    sLabel2: TsLabel;
    mmoReason: TsMemo;
    FormStore: TcxPropertiesStore;
    sLabel4: TsLabel;
    lblGuest: TsLabel;
    sLabel8: TsLabel;
    lblRoom: TsLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ShowReservation;
    { Private declarations }
  public
    { Public declarations }
    RoomReservation : Integer;
  end;

var
  FrmRoomReservationCancellationDialog: TFrmRoomReservationCancellationDialog;

function CancelRoomBookingDialog(RoomReservation : Integer) : Boolean;

implementation

{$R *.dfm}

uses cmpRoomerDataSet,
     uRoomerLanguage,
     uAppGlobal,
     uD,
     hData,
     uUtils
     ;


function CancelRoomBookingDialog(RoomReservation : Integer) : Boolean;
var
  _FrmRoomReservationCancellationDialog: TFrmRoomReservationCancellationDialog;
begin
  result := False;
  _FrmRoomReservationCancellationDialog := TFrmRoomReservationCancellationDialog.Create(nil);
  try
    _FrmRoomReservationCancellationDialog.RoomReservation := RoomReservation;
    if _FrmRoomReservationCancellationDialog.ShowModal = mrOK then
    begin
      d.roomerMainDataSet.SystemCancelRoomReservation(RoomReservation, Format('User %s changed state of room to cancelled on %s',
        [d.roomerMainDataSet.userName, DateTimeToStr(now)]) + #13 + ReplaceString(_FrmRoomReservationCancellationDialog.mmoReason.Text, '''','\'''));
//      if _FrmRoomReservationCancellationDialog.sCheckBox1.Checked then
//        SendCancellationConfirmation(RoomReservation);
      result := True;
    end;
  finally
    FreeAndNil(_FrmRoomReservationCancellationDialog);
  end;
end;
procedure TFrmRoomReservationCancellationDialog.ShowReservation;
var rSet : TRoomerDataset;
    sql : String;
begin
  rSet := CreateNewDataset;
  sql := format(
           'SELECT r.Name, r.ContactName, p.Name AS GuestName, ' +
           'DATE(rr.Arrival) AS Arrival, ' +
           'DATE(rr.Departure) AS Departure, ' +
           '(SELECT COUNT(id) FROM roomreservations r1 WHERE r1.Reservation=r.Reservation) AS NumRooms, ' +
           '(SELECT COUNT(id) FROM persons pe WHERE pe.Reservation=r.Reservation) AS NumGuests, ' +
           '(SELECT COUNT(id) FROM persons pe WHERE pe.RoomReservation=rr.RoomReservation) AS NumGuestsInRoom, ' +
           '(SELECT Room FROM roomsdate rd WHERE rd.RoomReservation=rr.RoomReservation AND (NOT ResFlag IN (''X'',''C'')) LIMIT 1) AS Room ' +
           'FROM reservations r ' +
           'INNER JOIN roomreservations rr ON rr.Reservation=r.Reservation ' +
           'INNER JOIN persons p ON p.MainName=1 AND p.RoomReservation=rr.RoomReservation ' +
           'WHERE rr.RoomReservation = %d ',
           [RoomReservation]
         );

  CopyToClipboard(sql);
  if hData.rSet_bySQL(rSet, sql) then
  begin
    lblRoom.Caption := rSet['Room'];
    lblGuest.Caption := rSet['GuestName'];
    lblResName.Caption := rSet['Name'];
    lblContact.Caption := rSet['ContactName'];
    lblArrival.Caption := DateToStr(rSet['Arrival']);
    lblDeparture.Caption := DateToStr(rSet['Departure']);
    lblRooms.Caption := inttostr(rSet['NumRooms']);
    lblGuests.Caption := inttostr(rSet['NumGuests']);
  end;
end;

procedure TFrmRoomReservationCancellationDialog.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
end;

procedure TFrmRoomReservationCancellationDialog.FormShow(Sender: TObject);
begin
  ShowReservation;
end;

end.
