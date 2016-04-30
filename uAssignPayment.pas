unit uAssignPayment;

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
  , Vcl.Buttons
  , Vcl.StdCtrls
  , Vcl.ComCtrls
  , Vcl.ExtCtrls
  , Vcl.Menus

  , hdata
  ,_glob
  ,ug
  , uAppglobal
  ,ustringUtils
  ,uSqlDefinitions

  ,cmpRoomerDataSet
  ,cmpRoomerConnection

  , sSpeedButton
  , sEdit
  , sLabel
  , sComboBox
  , sButton
  , sPageControl
  , sGroupBox
  , sPanel
  , sStatusBar
  , sMemo

  , cxGraphics
  , cxLookAndFeels
  , cxLookAndFeelPainters, cxClasses, cxPropertiesStore, Vcl.Mask, sMaskEdit, sCustomComboEdit, sCurrEdit

  ;

type
  TfrmAssignPayment = class(TForm)
    sPanel1: TsPanel;
    sGroupBox2: TsGroupBox;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    btnSetToGroupAccount: TsButton;
    sGroupBox1: TsGroupBox;
    cbxRoomSelect: TsComboBox;
    sTabSheet2: TsTabSheet;
    sGroupBox3: TsGroupBox;
    sLabel1: TsLabel;
    edSetToGroupReservation: TsEdit;
    btnCkeckReservation: TsSpeedButton;
    sGroupBox4: TsGroupBox;
    sLabel2: TsLabel;
    btnCheckRoomReservation: TsSpeedButton;
    edSetToRoomReservation: TsEdit;
    clabReservation: TsLabel;
    clabCustomer: TsLabel;
    clabArrivalDeparture: TsLabel;
    clabRoom: TsLabel;
    clabPaymentType: TsLabel;
    clabDate: TsLabel;
    clabAmount: TsLabel;
    clabdescription: TsLabel;
    clabNotes: TsLabel;
    edNotes: TsMemo;
    edDescription: TsEdit;
    labReservation: TsLabel;
    labCustomer: TsLabel;
    labArrivalDeparture: TsLabel;
    labDate: TsLabel;
    labRoom: TsLabel;
    labCheckReservation: TsLabel;
    labCheckRoomReservation: TsLabel;
    btnExceuteAssingToroom: TsButton;
    btnExecuteRoomReservation: TsButton;
    btnExecureReservation: TsButton;
    Panel1: TsPanel;
    cbxPaymentType: TsComboBox;
    edAmount: TsCalcEdit;
    FormStore: TcxPropertiesStore;
    sButton1: TsButton;
    sButton2: TsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSetToGroupAccountClick(Sender: TObject);
    procedure btnCkeckReservationClick(Sender: TObject);
    procedure btnCheckRoomReservationClick(Sender: TObject);
    procedure btnExceuteAssingToroomClick(Sender: TObject);
    procedure btnExecuteRoomReservationClick(Sender: TObject);
    procedure btnExecureReservationClick(Sender: TObject);
    procedure cbxRoomSelectCloseUp(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    zReservation : integer;
    zRoomreservation  : integer;
    zInvoicenumber : integer;
    zIsGroupInvoice : boolean;
    zGroupAvailable : boolean;

    rec : recPaymentHolder;

    zPaymentID : integer;
  public
    { Public declarations }
  end;

function OpenAssignPayment(PaymentID : integer) : boolean;

var
  frmAssignPayment: TfrmAssignPayment;

implementation

{$R *.dfm}

uses
  uD,
  uActivityLogs,
  uRoomerLanguage
  , uUtils
  ;



function OpenAssignPayment(paymentID : integer) : boolean;
begin
  result := false;
  frmAssignPayment := TfrmAssignPayment.Create(frmAssignPayment);
  try
    frmAssignPayment.zPaymentID := PaymentID;
    frmAssignPayment.ShowModal;
    if frmAssignPayment.modalresult = mrOk then
    begin
      result := true;
    end else
    begin

    end;
  finally
    freeandnil(frmAssignPayment);
  end;
end;



procedure TfrmAssignPayment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**



end;

procedure TfrmAssignPayment.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmAssignPayment.FormDestroy(Sender: TObject);
begin
  //**
end;

procedure TfrmAssignPayment.FormShow(Sender: TObject);
var
  rSet : TRoomerDataset;
  s : string;
  sTmp : string;
  i,p : integer;
  payType : string;
  itemIndex : integer;

begin

  rSet := CreateNewDataSet;
  try
    cbxPaymentType.clear;
		s := '';
    s := s+'Select paytype,description,paygroup From paytypes where (active=true) and PayGroup <> '+_db(g.qInvPriceGroup)+' order by paygroup ';
    if rSet_bySQL(rSet,s) then
    begin
      while not rSet.Eof do
      begin
        cbxPaymentType.items.add(rSet.fieldbyname('Paytype').AsString+' - '+rSet.fieldbyname('description').AsString);
        rSet.Next;
      end;
    end;
  finally
    freeandnil(rSet);
  end;


  initPaymentHolderRec(rec);




  rSet := CreateNewDataSet;
  try
    s := '';
    s := s+' SELECT '#10;
    s := s+'    pm.Reservation '#10;
    s := s+'   ,pm.RoomReservation '#10;
    s := s+'   ,pm.Person '#10;
    s := s+'   ,pm.TypeIndex '#10;
    s := s+'   ,pm.InvoiceNumber '#10;
    s := s+'   ,date(pm.PayDate) AS payDate '#10;
    s := s+'   ,pm.Customer '#10;
    s := s+'   ,pm.PayType '#10;
    s := s+'   ,pm.Amount '#10;
    s := s+'   ,pm.Description '#10;
    s := s+'   ,pm.CurrencyRate '#10;
    s := s+'   ,pm.Currency '#10;
    s := s+'   ,pm.confirmDate '#10;
    s := s+'   ,pm.Notes '#10;
    s := s+'   ,pm.dtCreated '#10;
    s := s+'   ,pm.id '#10;
    s := s+'   ,rv.name AS ReservationName '#10;
    s := s+'   ,rv.channel '#10;
    s := s+'   ,rv.invRefrence AS Refrence '#10;
    s := s+'   ,rr.rrArrival AS Arrival '#10;
    s := s+'   ,rr.rrDeparture AS Departure '#10;
    s := s+'   ,rr.room '#10;
    s := s+'   ,chnl.Name AS ChannelName '#10;
    s := s+'   ,cust.surname AS CustomerName '#10;
    s := s+' FROM '#10;
    s := s+'    payments pm '#10;
    s := s+'     LEFT OUTER JOIN reservations rv ON pm.reservation = rv.reservation '#10;
    s := s+'     LEFT OUTER JOIN roomreservations rr ON pm.roomreservation = rr.roomreservation '#10;
    s := s+'     LEFT OUTER JOIN channels chnl ON rv.channel = chnl.id '#10;
    s := s+'     LEFT OUTER JOIN customers cust ON pm.customer = cust.Customer '#10;
    s := s+'WHERE pm.id='+_db(zPaymentId)+' ';

    if rSet_bySQL(rSet,s) then
    begin
      rSet.First;
      if not rSet.eof then
      begin
        rec.ID := zPaymentId;
        rec.Reservation   := rSet.FieldByName('reservation').AsInteger;
        rec.RoomReservation   := rSet.FieldByName('roomreservation').AsInteger;
        rec.Person        := rSet.FieldByName('Person').AsInteger;
        rec.TypeIndex     := rSet.FieldByName('TypeIndex').AsInteger;
        rec.InvoiceNumber := rSet.FieldByName('InvoiceNumber').AsInteger;
        rec.PayDate       := rSet.FieldByName('PayDate').AsString;
        rec.Customer      := rSet.FieldByName('Customer').AsString;
        rec.PayType       := rSet.FieldByName('PayType').AsString;
        rec.Amount        := rSet.GetFloatValue(rSet.FieldByName('Amount'));
        rec.Description   := rSet.FieldByName('Description').AsString;
        rec.CurrencyRate  := rSet.GetFloatValue(rSet.FieldByName('CurrencyRate'));
        rec.Currency      := rSet.FieldByName('Currency').AsString;
        rec.confirmDate   := rSet.FieldByName('confirmDate').AsDateTime;  //  '1900-01-01 00:00:00'
        rec.Notes         := rSet.FieldByName('Notes').AsString;
        rec.dtCreated     := rSet.FieldByName('dtCreated').AsDateTime;

        labRoom.caption := rSet.FieldByName('Room').AsString;
        labCustomer.Caption := rSet.FieldByName('customer').asstring+' - '+rSet.FieldByName('customername').asstring;
        labReservation.Caption := rSet.FieldByName('reservationName').asstring;
        labArrivalDeparture.Caption := dateToStr(rSet.FieldByName('Arrival').asdatetime)+' - '+dateToStr(rSet.FieldByName('Departure').asdatetime);
        labRoom.Caption := rSet.FieldByName('Room').asString;
        labDate.Caption := datetimeTostr(rSet.FieldByName('dtCreated').asDateTime);
        edAmount.Value := rSet.GetFloatValue(rSet.FieldByName('Amount'));

        itemIndex := -1;
        for i  := 0 to cbxPaymentType.items.count-1 do
        begin
          sTmp := cbxPaymentType.items[i];
          p := pos(' - ',sTmp);
          paytype := _trimlower(copy(sTmp,1,p));
          if _trimLower(rec.payType) = payType then itemindex := i;
        end;
        cbxPaymentType.Itemindex := itemindex;
        edDescription.Text := rSet.FieldByName('description').asString;
        edNotes.Text := rSet.FieldByName('Notes').Text;
      end;
    end;
  finally
    freeandnil(rSet);
  end;

  zIsGroupInvoice := rec.RoomReservation=0;
  zGroupAvailable := false;

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s+' SELECT '#10;
    s := s+'    roomReservation '#10;
    s := s+'   ,GroupAccount'#10;
    s := s+' FROM '#10;
    s := s+'   roomreservations '#10;
    s := s+' WHERE '#10;
    s := s+'   (reservation = '+_db(rec.reservation)+') and (Groupaccount=1) ';

    if rSet_bySQL(rSet,s) then
    begin
      if not rSet.eof then
      begin
        zGroupAvailable := true;

      end;
      cbxRoomSelect.ItemIndex := 0;
    end;
  finally
    freeandnil(rSet);
  end;

  btnSetToGroupAccount.enabled := (zIsGroupInvoice=false);

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s+' SELECT '#10;
    s := s+'      rr.roomReservation '#10;
    s := s+'    , rr.room '#10;
    s := s+'   ,'+format(Get_mainGuestname,['pe','pe','rr','GuestName'])+#10;
    s := s+' FROM '#10;
    s := s+'   roomreservations rr '#10;
    s := s+' WHERE '#10;
    s := s+'   (rr.reservation= '+_db(rec.Reservation)+') '#10;
    if labRoom.caption <> '' then
    begin
      s := s+'  AND (rr.room <> '+_db(labRoom.caption)+') ';
    end;

    if rSet_bySQL(rSet,s) then
    begin
      cbxRoomSelect.Clear;
      cbxRoomSelect.items.add('None');
      rSet.First;
      while not rSet.eof do
      begin
        cbxRoomSelect.Items.Add(rSet.FieldByName('room').asstring+' - '+rSet.FieldByName('Guestname').asstring);
        rSet.Next;
      end;
      cbxRoomSelect.ItemIndex := 0;
      cbxRoomSelect.visible := cbxRoomSelect.Items.Count > 2;
    end;
  finally
    freeandnil(rSet);
  end;

  sPageControl1.ActivePageIndex := 0;
  if (cbxRoomSelect.visible=false) and (btnSetToGroupAccount.visible=false) then
  begin
    sTabSheet1.TabVisible := false;
    sPageControl1.ActivePageIndex := 1;
  end;




end;


procedure TfrmAssignPayment.btnCkeckReservationClick(Sender: TObject);
var
  rSet : TRoomerDataset;
  s : string;
  SetToGroupReservation : integer;

begin
  SetToGroupReservation := strToInt(edSetToGroupReservation.Text);

  btnExecureReservation.Enabled := false;
  labCheckReservation.caption := '-';

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s+' SELECT '#10;
    s := s+'    rv.Reservation '#10;
    s := s+'   ,rv.Customer '#10;
    s := s+'   ,rv.name AS ReservationName '#10;
    s := s+'   ,rv.channel '#10;
    s := s+'   ,rv.arrival '#10;
    s := s+'   ,rv.departure '#10;
    s := s+'   ,chnl.Name AS ChannelName '#10;
    s := s+'   ,cust.surname AS CustomerName '#10;
    s := s+' FROM '#10;
    s := s+'    Reservations rv '#10;
    s := s+'     LEFT OUTER JOIN channels chnl ON rv.channel = chnl.id '#10;
    s := s+'     LEFT OUTER JOIN customers cust ON rv.customer = cust.Customer '#10;
    s := s+'WHERE rv.Reservation='+_db(SetToGroupReservation)+' ';

    if rSet_bySQL(rSet,s) then
    begin
      s := '';
      s := s+' Customer : '+rset.FieldByName('Customer').AsString+'  '+rset.FieldByName('reservationName').AsString+' '#10;
      s := s+' Reservation : '+rset.FieldByName('reservationName').AsString+' '#10;
      s := s+' Arrival : '+rset.FieldByName('Arrival').AsString+'   Departure : '+rset.FieldByName('Departure').AsString+' '#10;
      labCheckReservation.caption := s;
      btnExecureReservation.Enabled := true;
    end else
    begin
      labCheckReservation.caption := 'Reservation not found';
    end;
  finally
    freeandnil(rSet);
  end;

end;

procedure TfrmAssignPayment.btnExecuteRoomReservationClick(Sender: TObject);
var
  rSet : TRoomerDataset;
  newReservation     : integer;
  newRoomreservation : integer;
  s : string;
  p : integer;
  payType : string;
begin
  p := pos(' - ',cbxPaymentType.items[cbxPaymentType.itemIndex]);
  paytype := trim(copy(cbxPaymentType.items[cbxPaymentType.itemIndex],1,p));

  newRoomReservation := strToInt(edSetToRoomReservation.text);
  newReservation := -1;

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s+' SELECT '#10;
    s := s+'    Reservation '#10;
    s := s+' FROM '#10;
    s := s+'    roomreservations '#10;
    s := s+'WHERE RoomReservation='+_db(newRoomReservation)+' ';

    if rSet_bySQL(rSet,s) then
    begin
      newReservation := rSet.FieldByName('reservation').asInteger;
    end;
  finally
    freeandnil(rSet);
  end;

  if MessageDlg('Set payment to '#10#10+labCheckRoomReservation.caption, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if newRoomReservation <> 0 then
    begin
      s := '';
      s := s+' UPDATE payments '+#10;
      s := s+' SET '+#10;
      s := s+'     roomreservation  ='+_db(newroomreservation)+' '+#10;
      s := s+'     ,reservation  ='+_db(newReservation)+' '+#10;
      s := s+'     ,description  ='+_db(edDescription.text)+' '+#10;
      s := s+'     ,notes  ='+_db(edNotes.Text)+' '+#10;
      s := s+'     ,amount  ='+_db(edAmount.value)+' '+#10;
      s := s+'     ,PayType  ='+_db(payType)+' '+#10;
      s := s+' WHERE '+#10;
      s := s+'       (ID = '+_db(rec.id)+') '+#10;
      if cmd_bySQL(s) then
      begin
        try
              AddInvoiceActivityLog(g.quser
                                   ,newroomreservation
                                   ,newReservation
                                   ,1
                                   ,CHANGE_PAYMENT
                                   ,payType
                                   ,edAmount.value
                                   ,-1
                                   ,edDescription.text);
        Except
        end;
        modalresult := mrOK;
      end;
    end;
  end;
end;


procedure TfrmAssignPayment.btnCheckRoomReservationClick(Sender: TObject);
var
  rSet : TRoomerDataset;
  s : string;
  SetToRoomReservation : integer;

begin
  SetToRoomReservation := strToInt(edSetToRoomReservation.Text);

  btnExecuteRoomReservation.Enabled := false;
  labCheckRoomReservation.caption := '-';


  rSet := CreateNewDataSet;
  try
    s := '';
    s := s+' SELECT '#10;
    s := s+'    rr.roomReservation '#10;
    s := s+'   ,rr.Reservation '#10;
    s := s+'   ,rr.rrArrival AS Arrival '#10;
    s := s+'   ,rr.rrDeparture AS Departure '#10;
    s := s+'   ,rr.room '#10;
    s := s+'   ,rr.GroupAccount '#10;
    s := s+'   ,rv.Customer '#10;
    s := s+'   ,rv.name AS ReservationName '#10;
    s := s+'   ,rv.channel '#10;
    s := s+'   ,rv.invRefrence AS Refrence '#10;
    s := s+'   ,chnl.Name AS ChannelName '#10;
    s := s+'   ,cust.surname AS CustomerName '#10;
    s := s+'   ,'+format(Get_mainGuestname,['pe','pe','rr','GuestName'])+#10;
//    s := s+'   ,(Select Name from persons pe where (pe.roomreservation = rr.roomreservation) and (mainName=1)) AS GuestName '#10;
    s := s+' FROM '#10;
    s := s+'    RoomReservations rr '#10;
    s := s+'     LEFT OUTER JOIN reservations rv ON rv.reservation = rr.reservation '#10;
    s := s+'     LEFT OUTER JOIN channels chnl ON rv.channel = chnl.id '#10;
    s := s+'     LEFT OUTER JOIN customers cust ON rv.customer = cust.Customer '#10;
    s := s+'WHERE rr.roomReservation='+_db(SetToRoomReservation)+' ';

    if rSet_bySQL(rSet,s) then
    begin
      s := '';
      s := s+' Customer : '+rset.FieldByName('Customer').AsString+'  '+rset.FieldByName('reservationName').AsString+' '#10;
      s := s+' Guest : '+rset.FieldByName('GuestName').AsString+' '#10;
      s := s+' Reservation : '+rset.FieldByName('reservationName').AsString+' '#10;
      s := s+' Room : '+rSet.FieldByName('room').AsString+' - Arrival : '+dateToStr(rset.FieldByName('Arrival').AsDateTime)+'   Departure : '+dateToStr(rset.FieldByName('Departure').AsDateTime)+' '#10;
      labCheckRoomReservation.caption := s;
      btnExecuteRoomReservation.Enabled := true;
    end else
    begin
      labCheckRoomReservation.caption := 'RoomReservation not found';
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure TfrmAssignPayment.btnSetToGroupAccountClick(Sender: TObject);
var
  s : string;
  p : integer;
  payType : string;
begin
  p := pos(' - ',cbxPaymentType.items[cbxPaymentType.itemIndex]);
  paytype := trim(copy(cbxPaymentType.items[cbxPaymentType.itemIndex],1,p));


  if MessageDlg('Set payment to groupinvoice', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    s := '';
    s := s+' UPDATE payments '+#10;
    s := s+' SET '+#10;
    s := s+'     roomreservation  = 0 '+#10;
    s := s+'     ,description  ='+_db(edDescription.text)+' '+#10;
    s := s+'     ,notes  ='+_db(edNotes.text)+' '+#10;
    s := s+'     ,amount  ='+_db(edAmount.value)+' '+#10;
    s := s+'     ,PayType  ='+_db(payType)+' '+#10;
    s := s+' WHERE '+#10;
    s := s+'       (ID = '+_db(rec.id)+') '+#10;
    if cmd_bySQL(s) then
    begin
      modalresult := mrOK;
//**log** update payment
        try
              AddInvoiceActivityLog(g.quser
                                   ,0
                                   ,rec.Reservation
                                   ,1
                                   ,CHANGE_PAYMENT
                                   ,payType
                                   ,edAmount.value
                                   ,-1
                                   ,'Set payment to Groupinvoice : ' +edDescription.text);
        Except
        end;

    end;
  end;
end;




procedure TfrmAssignPayment.cbxRoomSelectCloseUp(Sender: TObject);
begin
  btnExceuteAssingToRoom.enabled := cbxRoomSelect.ItemIndex > 0;
end;

procedure TfrmAssignPayment.btnExceuteAssingToroomClick(Sender: TObject);
var
  s : string;
  rSet : TRoomerDataSet;
  roomreservation : integer;
  room : string;

  sTmp : string;
  p : integer;
  payType : string;
begin
  p := pos(' - ',cbxPaymentType.items[cbxPaymentType.itemIndex]);
  paytype := trim(copy(cbxPaymentType.items[cbxPaymentType.itemIndex],1,p));


  sTmp := cbxRoomselect.Items[cbxRoomselect.Itemindex];
  p := pos(' - ',sTmp);
  room := trim(copy(sTmp,1,p));

  roomreservation := 0;

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s+' SELECT '#10;
    s := s+'    rr.RoomReservation '#10;
    s := s+' FROM '#10;
    s := s+'   roomreservations rr '#10;
    s := s+' WHERE '#10;
    s := s+'   (rr.room = '+_db(room)+') and (rr.reservation='+_db(rec.reservation)+'  ) ';

    if rSet_bySQL(rSet,s) then
    begin
      if not rSet.eof then
      begin
        roomreservation := rSet.FieldByName('roomreservation').AsInteger;
      end;
    end;
  finally
    freeandnil(rSet);
  end;


  if MessageDlg('Set payment to '+room, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if roomreservation <> 0 then
    begin
      s := '';
      s := s+' UPDATE payments '+#10;
      s := s+' SET '+#10;
      s := s+'      roomreservation  ='+_db(roomreservation)+' '+#10;
      s := s+'     ,description  ='+_db(edDescription.text)+' '+#10;
      s := s+'     ,notes  ='+_db(edNotes.text)+' '+#10;
      s := s+'     ,amount  ='+_db(edAmount.value)+' '+#10;
      s := s+'     ,PayType  ='+_db(payType)+' '+#10;
      s := s+' WHERE '+#10;
      s := s+'       (ID = '+_db(rec.id)+') '+#10;
      if cmd_bySQL(s) then
      begin
        modalresult := mrOK;
        try
              AddInvoiceActivityLog(g.quser
                                   ,roomreservation
                                   ,rec.Reservation
                                   ,1
                                   ,CHANGE_PAYMENT
                                   ,payType
                                   ,edAmount.value
                                   ,-1
                                   ,'Set payment to Room : ' +edDescription.text);
        Except
        end;
      end;
    end;
  end;
end;


procedure TfrmAssignPayment.btnExecureReservationClick(Sender: TObject);
var
  newReservation     : integer;
  newRoomreservation : integer;
  s : string;
  p : integer;
  payType : string;
begin
  p := pos(' - ',cbxPaymentType.items[cbxPaymentType.itemIndex]);
  paytype := trim(copy(cbxPaymentType.items[cbxPaymentType.itemIndex],1,p));

  newReservation := strToInt(edSetToGroupReservation.text);
  newRoomReservation := 0;

  if MessageDlg('Set payment to '#10#10+labCheckReservation.caption, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if newReservation <> 0 then
    begin
      s := '';
      s := s+' UPDATE payments '+#10;
      s := s+' SET '+#10;
      s := s+'     roomreservation  ='+_db(newroomreservation)+' '+#10;
      s := s+'     ,reservation  ='+_db(newReservation)+' '+#10;
      s := s+'     ,description  ='+_db(edDescription.text)+' '+#10;
      s := s+'     ,notes  ='+_db(edNotes.text)+' '+#10;
      s := s+'     ,amount  ='+_db(edAmount.value)+' '+#10;
      s := s+'     ,PayType  ='+_db(payType)+' '+#10;
      s := s+' WHERE '+#10;
      s := s+'       (ID = '+_db(rec.id)+') '+#10;
      if cmd_bySQL(s) then
      begin
        modalresult := mrOK;
        try
              AddInvoiceActivityLog(g.quser
                                   ,newroomreservation
                                   ,newReservation
                                   ,1
                                   ,CHANGE_PAYMENT
                                   ,payType
                                   ,edAmount.value
                                   ,-1
                                   ,edDescription.text);
        Except
        end;
      end;
    end;
  end;
end;

procedure TfrmAssignPayment.btnOKClick(Sender: TObject);
var
  s : string;
  p : integer;
  payType : string;
begin
  p := pos(' - ',cbxPaymentType.items[cbxPaymentType.itemIndex]);
  paytype := trim(copy(cbxPaymentType.items[cbxPaymentType.itemIndex],1,p));

  s := '';
  s := s+' UPDATE payments '+#10;
  s := s+' SET '+#10;
  s := s+'      description  ='+_db(edDescription.text)+' '+#10;
  s := s+'     ,notes  ='+_db(edNotes.text)+' '+#10;
  s := s+'     ,amount  ='+_db(edAmount.value)+' '+#10;
  s := s+'     ,PayType  ='+_db(payType)+' '+#10;
  s := s+' WHERE '+#10;
  s := s+'       (ID = '+_db(rec.id)+') '+#10;
  if cmd_bySQL(s) then
  begin

        try
              AddInvoiceActivityLog(g.quser
                                   ,rec.Reservation
                                   ,rec.RoomReservation
                                   ,1
                                   ,CHANGE_PAYMENT
                                   ,payType
                                   ,edAmount.value
                                   ,-1
                                   ,edDescription.text);
        Except
        end;
  end;
end;


end.



