unit uGoToRoomAndDate;

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
  Vcl.Mask,
  sMaskEdit,
  sCustomComboEdit,
  sTooledit,
  Vcl.StdCtrls,
  sComboBox,
  sEdit,
  sLabel,
  sGroupBox,
  sButton,
  Vcl.ExtCtrls,
  sPanel;

type
  TfrmGoToRoomandDate = class(TForm)
    Panel1: TsPanel;
    cxButton1: TsButton;
    btnCancel: TsButton;
    gbxFind: TsGroupBox;
    labErr: TsLabel;
    edRefrence: TsEdit;
    cbxRefrenceType: TsComboBox;
    gbxGoto: TsGroupBox;
    cxLabel1: TsLabel;
    cxLabel2: TsLabel;
    edRoom: TsEdit;
    dtDate: TsDateEdit;
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure cxButton1Click(Sender : TObject);
    procedure btnGetRoomAndDateClick(Sender : TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    okClose : boolean;
  public
    { Public declarations }
    zDate : Tdate;
    zRoom : string;
  end;

var
  frmGoToRoomandDate : TfrmGoToRoomandDate;

implementation

uses uD, uAppGlobal, PrjConst, uDImages, uUtils;

{$R *.dfm}

procedure TfrmGoToRoomandDate.btnGetRoomAndDateClick(Sender : TObject);
begin
  // **
end;

procedure TfrmGoToRoomandDate.cxButton1Click(Sender : TObject);
var
  aDate       : TDate;
  aRoom       : String;
  refrence    : string;
  invoiceType : integer;
  iRefrence   : integer;
begin
  aRoom := '';
  refrence := edRefrence.text;

  if refrence <> '' then
  begin
    case cbxRefrenceType.itemindex of
       0 : // RoomReservation
        begin
          try
            iRefrence := strToInt(refrence);
          Except
            iRefrence := 0
          end;

          aDate := d.RR_FirstDayAndRoom(iRefrence,aRoom);
          if aDate = 1 then
          begin
          //labErr.caption := 'RoomReservation not Found';
			      labErr.caption := GetTranslatedText('shTx_GotoRoomAndDate_RoomNotFound');
            okClose := false;
          end else
          begin
            edRoom.Text := aRoom;
            dtDate.Date := aDate;
          end;
        end;
      1 :
        begin
          try
            iRefrence := strToInt(refrence);
          Except
            iRefrence := 0
          end;

          aDate := d.RV_FirstDayAndRoom(iRefrence,aRoom);
          if aDate = 1 then
          begin
         //   labErr.caption := 'Reservation not Found';
		      	labErr.caption := GetTranslatedText('shTx_GotoRoomAndDate_ReservationNotFound');
            okClose := false;
          end else
          begin
            edRoom.Text := aRoom;
            dtDate.Date := aDate;
          end;
        end;
      2 :
        begin
          try
            iRefrence := strToInt(refrence);
          Except
            iRefrence := 0
          end;

          aDate := d.INV_FirstDayAndRoom(iRefrence,aRoom, invoiceType);
          if aDate = 1 then
          begin
            if invoiceType = 3 then
            begin
              //  labErr.caption := 'Cash invoice - No Room';
			        labErr.caption := GetTranslatedText('shTx_GotoRoomAndDate_CashNoRoom');
            end else
            begin
              //  labErr.caption := 'Invoice not found';
			        labErr.caption := GetTranslatedText('shTx_GotoRoomAndDate_InvoiceNotFound');
            end;
            okClose := false;
          end else
          begin
            edRoom.Text := aRoom;
            dtDate.Date := aDate;
          end;
        end;
      3 :
        begin
          aDate := d.ref_FirstDayAndRoom(refrence,aRoom);
          if aDate = 1 then
          begin
  		      labErr.caption := GetTranslatedText('shTx_GotoRoomAndDate_RefNotFound');
            okClose := false;
          end else
          begin
            edRoom.Text := aRoom;
            dtDate.Date := aDate;
          end;
        end;
    end;
  end;
  zRoom := edRoom.Text;
  zDate := dtDate.Date;
end;

procedure TfrmGoToRoomandDate.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  canClose := okClose;
  okClose := true;
end;

procedure TfrmGoToRoomandDate.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  okClose := true;
  zDate := Date;
  zRoom := '';
end;

procedure TfrmGoToRoomandDate.FormShow(Sender : TObject);
begin
  edRoom.Text := zRoom;
  dtDate.Date := zDate;
end;

end.
