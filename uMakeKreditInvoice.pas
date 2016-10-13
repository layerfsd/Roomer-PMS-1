unit uMakeKreditInvoice;

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
  , Vcl.StdCtrls
  , Vcl.ExtCtrls
  , Vcl.ComCtrls

  , shellApi
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , kbmMemTable
  , _glob
  , ug
  , hData
  , uUtils
  , uappGlobal
  , uStringUtils

  , sEdit
  , sMemo
  , sPanel
  , sStatusBar
  , sLabel
  , sButton
  , sCheckBox

  , cxClasses
  , cxPropertiesStore
  , Vcl.Mask
  , sMaskEdit
  , sCustomComboEdit
  , sToolEdit
  , sGroupBox
  , Data.DB

  , dxmdaset
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxStyles
  , dxSkinsCore
  , dxSkinBlack
  , dxSkinBlue
  , dxSkinBlueprint
  , dxSkinCaramel
  , dxSkinCoffee
  , dxSkinDarkRoom
  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinDevExpressStyle
  , dxSkinFoggy
  , dxSkinGlassOceans
  , dxSkinHighContrast
  , dxSkiniMaginary
  , dxSkinLilian
  , dxSkinLiquidSky
  , dxSkinLondonLiquidSky
  , dxSkinMcSkin
  , dxSkinMoneyTwins
  , dxSkinOffice2007Black
  , dxSkinOffice2007Blue
  , dxSkinOffice2007Green
  , dxSkinOffice2007Pink
  , dxSkinOffice2007Silver
  , dxSkinOffice2010Black
  , dxSkinOffice2010Blue
  , dxSkinOffice2010Silver
  , dxSkinOffice2013White
  , dxSkinPumpkin
  , dxSkinSeven
  , dxSkinSevenClassic
  , dxSkinSharp
  , dxSkinSharpPlus
  , dxSkinSilver
  , dxSkinSpringTime
  , dxSkinStardust
  , dxSkinSummer2008
  , dxSkinTheAsphaltWorld
  , dxSkinsDefaultPainters
  , dxSkinValentine
  , dxSkinVS2010
  , dxSkinWhiteprint
  , dxSkinXmas2008Blue
  , dxSkinscxPCPainter
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxEdit
  , cxNavigator
  , cxDBData
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGridLevel
  , cxGridCustomView
  , cxGrid
  , sPageControl, Vcl.Buttons, sSpeedButton
  ;

type
  TfrmMakeKreditInvoice = class(TForm)
    sPanel1: TsPanel;
    FormStore: TcxPropertiesStore;
    sGroupBox2: TsGroupBox;
    edInvoiceNumber: TsEdit;
    chkCreateNew: TsCheckBox;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    kbmInvoiceHeads: TkbmMemTable;
    kbmInvoiceLines: TkbmMemTable;
    InvoiceLinesDS: TDataSource;
    kbmPayments: TkbmMemTable;
    PaymentsDS: TDataSource;
    InvoiceHeadsDS: TDataSource;
    sPanel2: TsPanel;
    btnReservation: TsButton;
    btnPreviewOrginal: TsButton;
    memExtratext: TsMemo;
    sGroupBox1: TsGroupBox;
    sLabel2: TsLabel;
    dtInvoiceDate: TsDateEdit;
    sLabel1: TsLabel;
    dtPayDate: TsDateEdit;
    sGroupBox3: TsGroupBox;
    btnCancelChanges: TsButton;
    __lblCustomer: TsLabel;
    __lblAddress1: TsLabel;
    __lblAddress2: TsLabel;
    __lblAddress3: TsLabel;
    __lblAddress4: TsLabel;
    gbAmounts: TsGroupBox;
    lblTotal: TsLabel;
    __lblTotal: TsLabel;
    __lblPayment: TsLabel;
    lblCurrency: TsLabel;
    __lblCurrency: TsLabel;
    btnClosedThisRoom: TsButton;
    btnClosedThisRes: TsButton;
    lblRefrence: TsLabel;
    __lblRefrence: TsLabel;
    sGroupBox5: TsGroupBox;
    __lblReservationIds: TsLabel;
    __lblEmailAddress: TsLabel;
    sButton1: TsButton;
    btnWithoutRefr: TsButton;
    sSpeedButton1: TsSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure edInvoiceNumberChange(Sender: TObject);
    procedure chkCreateNewClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure btnPreviewOrginalClick(Sender: TObject);
    procedure btnReservationClick(Sender: TObject);
    procedure btnWithoutRefrClick(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }

    zKeditInvoiceNumber : integer;
    zdoRestore    : boolean;
    zEmailAddress : string;

    procedure refresh;
    function saveInvoice : boolean;
    procedure HandleExceptionListFromBookKeepingSystem(invoiceNumber: integer; ErrorList: String);
  public
    { Public declarations }
    zInvoiceNumber : integer;
    zCreateNew : boolean;

  end;

var
  frmMakeKreditInvoice: TfrmMakeKreditInvoice;


  function MakeKreditInvoice(number : integer; var createNew : boolean) : boolean;


implementation

{$R *.dfm}

uses
    uD
  , prjConst
  , uRoomerLanguage
  , uDImages
  , uReservationProfile
  , uFinishedInvoices2
  , uInvoice
  , uFrmHandleBookKeepingException
  , uMain
  , RoomerCloudEntities
  ;


function MakeKreditInvoice(number : integer; var createNew : boolean) : boolean;
begin
  result := false;
  frmMakeKreditInvoice := TfrmMakeKreditInvoice.Create(frmMakeKreditInvoice);
  try
    frmMakeKreditInvoice.zInvoiceNumber := number;
    frmMakeKreditInvoice.zCreateNew := createNew;

    frmMakeKreditInvoice.EdInvoiceNumber.text := inttostr(number);
    frmMakeKreditInvoice.chkCreateNew.checked := createNew;

    frmMakeKreditInvoice.ShowModal;
    if frmMakeKreditInvoice.modalresult = mrOk then
    begin
      createNew := frmMakeKreditInvoice.zCreateNew;
      result := true;
    end
  finally
    freeandnil(frmMakeKreditInvoice);
  end;
end;

function TfrmMakeKreditInvoice.saveInvoice : boolean;
var
  ExecutionPlan : TRoomerExecutionPlan;
  s             : string;
  invoiceHeadData  : recInvoiceHeadHolder;
  invoiceLineData  : recInvoiceLineHolder;
  paymentData      : recPaymentHolder;

  sReportDate : string;
  sReportTime : String;

  iAYear, iAMon, iADay: Word;


  procedure createInvoiceHead;
  begin
    zKeditInvoiceNumber := IVH_SetNewID();

    initInvoiceHeadHolderRec(invoiceHeadData);
    invoiceHeadData.InvoiceNumber   := zKeditInvoiceNumber;
    invoiceHeadData.InvoiceDate     := _dateToDbdate(dtInvoicedate.date,false); //
    invoiceHeadData.ihDate          := Now;
    invoiceHeadData.ihInvoiceDate   := dtInvoicedate.date;
    invoiceHeadData.ihPayDate       := dtPayDate.date;
    invoiceHeadData.SplitNumber     := 1;
    invoiceHeadData.ihStaff         := g.qUser;
    invoiceHeadData.Staff         := g.qUser;



    with invoiceHeadData do
    begin
      Reservation           := kbmInvoiceHeads['Reservation'];
      RoomReservation       := kbmInvoiceHeads['RoomReservation'];
//    SplitNumber           := kbmInvoiceHeads['SplitNumber'];
//    InvoiceNumber         := kbmInvoiceHeads['InvoiceNumber'];
//    InvoiceDate           := kbmInvoiceHeads['InvoiceDate'];
      Customer              := kbmInvoiceHeads['Customer'];
      name                  := kbmInvoiceHeads['name'];
      Address1              := kbmInvoiceHeads['Address1'];
      Address2              := kbmInvoiceHeads['Address2'];
      Address3              := kbmInvoiceHeads['Address3'];
      Address4              := kbmInvoiceHeads['Address4'];
      Country               := kbmInvoiceHeads['Country'];
      Total                 := kbmInvoiceHeads['Total']*-1;
      TotalWOVAT            := kbmInvoiceHeads['TotalWOVAT']*-1;
      TotalVAT              := kbmInvoiceHeads['TotalVAT']*-1;
      TotalBreakFast        := kbmInvoiceHeads['TotalBreakFast']*-1;
      ExtraText             := memExtraText.Text;
      Finished              := kbmInvoiceHeads['Finished'];
      CreditInvoice         := kbmInvoiceHeads['CreditInvoice'];
      OriginalInvoice       := kbmInvoiceHeads['Invoicenumber'];
      InvoiceType           := kbmInvoiceHeads['InvoiceType'];
      ihTmp                 := kbmInvoiceHeads['ihTmp'];
      custPID               := kbmInvoiceHeads['custPID'];
      RoomGuest             := kbmInvoiceHeads['RoomGuest'];
//    ihDate                := kbmInvoiceHeads['ihDate'];
//    ihInvoiceDate         := kbmInvoiceHeads['ihInvoiceDate'];
//    ihConfirmDate         := kbmInvoiceHeads['ihConfirmDate']; Set in initInvoiceHeadHolderRec
//    ihPayDate             := kbmInvoiceHeads['ihPayDate'];
//    ihStaff               := kbmInvoiceHeads['ihStaff']+'/'+g.qUser;
      ihCurrency            := kbmInvoiceHeads['ihCurrency'];
      ihCurrencyRate        := kbmInvoiceHeads['ihCurrencyRate'];
      ReportDate            := sReportdate;
      ReportTime            := sReportTime;
      invRefrence           := kbmInvoiceHeads['invRefrence'];
      TotalStayTax          := kbmInvoiceHeads['TotalStayTax']*-1;
      TotalStayTaxNights    := kbmInvoiceHeads['TotalStayTaxNights']*-1;
      ShowPackage           := kbmInvoiceHeads['ShowPackage'];
      Location              := kbmInvoiceHeads['Location'];
    end;
    s := SQL_INS_InvoiceHead(invoiceHeadData);
//    copyToClipboard(s);
//    debugmessage(s);
    ExecutionPlan.AddExec(SQL_INS_InvoiceHead(invoiceHeadData));
  end;

  procedure createInvoiceLines;
  begin
    initInvoiceLineHolderRec(invoiceLineData);
    invoiceLineData.InvoiceNumber   := zKeditInvoiceNumber;
    invoiceLineData.SplitNumber     := 1; // Var ekki svona í fyrri
    invoiceLineData.confirmDate     := 2;
    invoiceLineData.confirmAmount   := 0.00;

    kbmInvoiceLines.DisableControls;
    try
      with invoiceLineData do
      begin
        while not kbmInvoicelines.eof do
        begin
//        AutoGen              := kbmInvoiceLines['AutoGen'];
          AutoGen :=  _GetCurrentTick;
          Reservation          := kbmInvoiceLines['Reservation'];
          RoomReservation      := kbmInvoiceLines['RoomReservation'];
//          SplitNumber          := kbmInvoiceLines['SplitNumber'];
          ItemNumber           := kbmInvoiceLines['ItemNumber'];
          PurchaseDate         := _DbDateToDate(kbmInvoiceLines['PurchaseDate']);
//          InvoiceNumber        := kbmInvoiceLines['InvoiceNumber'];
          ItemID               := kbmInvoiceLines['ItemID'];
          Number               := kbmInvoiceLines['Number'];
          Description          := kbmInvoiceLines['Description'];
          Price                := kbmInvoiceLines['Price']*-1;
          VATType              := kbmInvoiceLines['VATType'];
          Total                := kbmInvoiceLines['Total']*-1;
          TotalWOVAT           := kbmInvoiceLines['TotalWOVAT']*-1;
          VAT                  := kbmInvoiceLines['VAT']*-1;
          AutoGenerated        := kbmInvoiceLines['AutoGenerated'];
          CurrencyRate         := kbmInvoiceLines['CurrencyRate'];
          Currency             := kbmInvoiceLines['Currency'];
          ReportDate           := 2;
          ReportTime           := sReportTime;
          Persons              := kbmInvoiceLines['Persons'];
          Nights               := kbmInvoiceLines['Nights'];
          BreakfastPrice       := kbmInvoiceLines['BreakfastPrice'];
          Ayear                := iAyear;
          Amon                 := iAmon;
          Aday                 := iAday;
          ilTmp                := kbmInvoiceLines.fieldbyname('ilTmp').asstring;
//          ilID                 := kbmInvoiceLines['ilID'];
          ilAccountKey         := kbmInvoiceLines['ilAccountKey'];
          ItemCurrency         := kbmInvoiceLines['ItemCurrency'];
          ItemCurrencyRate     := kbmInvoiceLines['ItemCurrencyRate'];
          Discount             := kbmInvoiceLines['Discount']*-1;
          Discount_isPrecent   := kbmInvoiceLines['Discount_isPrecent'];
          ImportRefrence       := kbmInvoiceLines['ImportRefrence'];
          ImportSource         := kbmInvoiceLines['ImportSource'];
          IsPackage            := kbmInvoiceLines['IsPackage'];
          InvoiceIndex         := kbmInvoiceLines['InvoiceIndex'];


//   confirmDate   := kbmInvoiceLines['confirmDate'];
//   confirmAmount := kbmInvoiceLines['confirmAmount'];
//   ItemAdded     := kbmInvoiceLines['ItemAdded'];


          RoomreservationAlias := kbmInvoiceLines['RoomreservationAlias'];
          s := SQL_INS_InvoiceLine(invoiceLineData);
//        copyToClipboard(s);
//        debugmessage(s);
          ExecutionPlan.AddExec(S);
          kbmInvoicelines.next;
        end;
      end;
    finally
      kbmInvoiceLines.EnableControls
    end;
  end;

  procedure createPayments;
  begin
    initPaymentHolderRec(paymentData);
    PaymentData.InvoiceNumber   := zKeditInvoiceNumber;
    PaymentData.confirmDate     := 2;
    PaymentData.PayDate         := _dateToDbdate(dtInvoicedate.date,false);

    kbmPayments.DisableControls;
    try
      with PaymentData do
      begin
        while not kbmPayments.eof do
        begin
          Reservation        := kbmPayments['Reservation'];
          RoomReservation    := kbmPayments['RoomReservation'];
          Person             := kbmPayments['Person'];
          AutoGen            := _GetCurrentTick;
          TypeIndex          := kbmPayments['TypeIndex'];
          InvoiceNumber      := zKeditInvoiceNumber;
          PayDate            := _dateToDbdate(dtInvoicedate.date,false);
          Customer           := kbmPayments['Customer'];
          PayType            := kbmPayments['PayType'];
          Amount             := kbmPayments['Amount']*-1;
          Description        := kbmPayments['Description'];
          CurrencyRate       := kbmPayments['CurrencyRate'];
          Currency           := kbmPayments['Currency'];

          ReportDate         := sReportdate;
          ReportTime         := sReportDate;
          Ayear              := iAyear;
          Amon               := iAmon;
          Aday               := iAday;

          pmTmp              := kbmPayments['pmTmp'];
//          confirmDate        := kbmInvoiceLines['confirmDate'];
          Notes              := kbmPayments['notes'];

//          if ((typeindex = 1) and (chkShowdownPayments.checked)) or (typeindex = 0) then
//          begin
              s := SQL_INS_Payment(paymentData);
              ExecutionPlan.AddExec(S);
//          end;
          kbmPayments.next;
        end;
      end;
    finally
      kbmPayments.EnableControls
    end;
  end;

begin
  sReportDate := '';
  sReportTime  := '';
  decodedate(dtInvoiceDate.date, iAYear, iAMon, iADay);

  result := true;
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    try
      ExecutionPlan.BeginTransaction;
      //**
      createInvoiceHead;
      createInvoiceLines;
      createPayments;

      if ExecutionPlan.Execute(ptExec, False, True) then
      begin
         ExecutionPlan.CommitTransaction
      end else
      begin
        raise Exception.Create(ExecutionPlan.ExecException);
      end;
    except
      on e: exception do
      begin
        ExecutionPlan.RollbackTransaction;
        showMessage('Error on create Kreditinvoice : '+e.message);
        result := false;
      end;
    end;
  finally
    freeandNil(ExecutionPlan);
  end;
end;

procedure TfrmMakeKreditInvoice.HandleExceptionListFromBookKeepingSystem(invoiceNumber: integer; ErrorList: String);
begin
  HandleFinanceBookKeepingExceptions(invoiceNumber, ErrorList);
end;

procedure TfrmMakeKreditInvoice.BtnOkClick(Sender: TObject);
var
  OrginalInvoice : integer;
  Reservation : integer;
  RoomReservation : integer;
  hasPackage : Boolean;
  SelectedInvoiceIndex : Integer;
  Showpackage : boolean;
  EmailAddress : string;

  remoteResult : string;

begin
  zdoRestore      := chkCreateNew.Checked;
  OrginalInvoice  := kbmInvoiceheads['invoicenumber'];
  RoomReservation := kbmInvoiceheads['roomreservation'];
  Reservation     := kbmInvoiceheads['reservation'];
  ShowPackage     := kbmInvoiceHeads['ShowPackage'];

  if saveInvoice then
  begin

    if dkAutoTransfer then
    begin
      remoteResult := d.roomerMainDataSet.SystemSendInvoiceToBookkeeping(zKeditInvoiceNumber);
      if remoteResult <> '' then
      begin
        HandleExceptionListFromBookKeepingSystem(zKeditInvoiceNumber, remoteResult);
      end;
    end;
    ViewInvoice2(zKeditInvoiceNumber, true, false, true, ShowPackage, EmailAddress);
    if zdoRestore then
    begin
      SelectedInvoiceIndex := 0;
      d.copyInvoiceToInvoiceLinesTmp(OrginalInvoice, true, hasPackage, SelectedInvoiceIndex);
      EditInvoice(Reservation, Roomreservation, 0, SelectedInvoiceIndex, 0, 0, false,false,false,NOT hasPackage);
    end;
  end else
  begin
  end;
end;

procedure TfrmMakeKreditInvoice.btnPreviewOrginalClick(Sender: TObject);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := zInvoicenumber;
  ViewInvoice2(InvoiceNumber, false, false, false,false, '');
end;

procedure TfrmMakeKreditInvoice.btnReservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation     := kbmInvoiceHeads['Reservation'];
  iRoomReservation := kbmInvoiceHeads['RoomReservation'];;

  if iReservation = 0 then
  begin
	  showmessage(GetTranslatedText('shTx_InvoiceList2_CashAccount'));
    exit;
  end;
  if EditReservation(iReservation, iRoomReservation) then
  begin
    // **
  end;
end;

procedure TfrmMakeKreditInvoice.chkCreateNewClick(Sender: TObject);
begin
  zCreateNew := chkCreateNew.checked;
end;

procedure TfrmMakeKreditInvoice.edInvoiceNumberChange(Sender: TObject);
begin
//  if edInvoiceNumber.text = '' then edInvoiceNumber.text := '0';
  try
    zInvoiceNumber := strToInt(edInvoiceNumber.text);
    btnWithoutRefr.Visible := zInvoicenumber < 1;
  Except
  end;
end;

procedure TfrmMakeKreditInvoice.FormCreate(Sender: TObject);
begin
  //**
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmMakeKreditInvoice.FormShow(Sender: TObject);
begin
  _restoreForm(self);
  btnCancelChanges.Visible := False;

  __lblCustomer.Visible := False;
  __lblAddress1.Visible := False;
  __lblAddress2.Visible := False;
  __lblAddress3.Visible := False;
  __lblAddress4.Visible := False;
  __lblEmailAddress.Visible := False;

  __lblRefrence.Visible := False;
  lblRefrence.Visible := False;

  gbAmounts.Visible := False;

  btnClosedThisRes.Visible := False;
  btnClosedThisRoom.Visible := False;

  btnPreviewOrginal.Enabled := False;
  btnReservation.Enabled := False;

  refresh;
end;

procedure TfrmMakeKreditInvoice.refresh;
var
  s    : string;
  rset1,
  rset2,
  rset3,
  rset4 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;
  Amount : double;
begin
  zEmailAddress := '';

  dtInvoiceDate.date := Date;
  dtPayDate.date := Date;


  if zInvoicenumber > -1 then
  begin
    ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
    try
      s := '';
      s := 'SELECT * FROM invoiceheads WHERE invoicenumber ='+_db(zInvoicenumber)+' ';
      ExecutionPlan.AddQuery(s);
      s := 'SELECT * FROM invoicelines WHERE invoicenumber ='+_db(zInvoicenumber)+' ORDER BY itemNumber ';
      ExecutionPlan.AddQuery(s);
      s := 'SELECT * FROM payments WHERE invoicenumber ='+_db(zInvoicenumber)+' ORDER BY Paydate ';
      ExecutionPlan.AddQuery(s);

      s := '';
      s := s+ 'Select ';
      s := s+ '  rv.ContactEmail ';
      s := s+ 'From ';
      s := s+ '  invoiceheads ih ';
      s := s+ '  Inner Join reservations rv ON ih.reservation = rv.reservation ';
      s := s+ 'WHERE ';
      s := s+ '  ih.invoicenumber = '+_db(zInvoicenumber)+' ';
      ExecutionPlan.AddQuery(s);

      screen.Cursor := crHourGlass;
      kbmInvoiceheads.DisableControls;
      kbmInvoiceheads.EnableControls;
      kbmPayments.EnableControls;
      try
        ExecutionPlan.Execute(ptQuery);

        rSet1 := ExecutionPlan.Results[0];
        if kbmInvoiceheads.Active then kbmInvoiceheads.Close;
        kbmInvoiceheads.open;
        kbmInvoiceheads.LoadFromDataSet(rSet1,[]);
//      LoadKbmMemtableFromDataSetQuiet(kbmInvoiceheads,rSet1,[]);

        rSet2 := ExecutionPlan.Results[1];
        if kbmInvoiceLines.Active then kbmInvoiceLines.Close;
        kbmInvoiceLines.open;
        kbmInvoiceLines.LoadFromDataSet(rSet2,[]);

        rSet3 := ExecutionPlan.Results[2];
        if kbmPayments.Active then kbmPayments.Close;
        kbmPayments.open;
        kbmPayments.LoadFromDataSet(rSet3,[]);

        rSet4 := ExecutionPlan.Results[3];

        if not rset1.eof then
        begin
          if kbmInvoiceHeads.FieldByName('Splitnumber').asinteger = 1 then
          begin
            showmessage('This is a CreditInvoice');
            zInvoicenumber := 0;
            edInvoicenumber.Text := '0';
            btnOk.Enabled := false;
          end else
          begin
            btnOk.Enabled := true;
          end;
        end else
        begin
          btnOk.Enabled := false;
          if zInvoicenumber > 0 then showmessage('invoice not found');
          edInvoiceNumber.SetFocus;
        end;

        if zInvoicenumber > 0 then
        begin
          if not rSet4.eof then zEmailAddress := rSet4.fieldbyname('ContactEmail').asstring;

//          dtInvoiceDate.date := kbmInvoiceheads.FieldByName('ihInvoicedate').AsDateTime;
//          dtPayDate.date := kbmInvoiceheads.FieldByName('ihPayDate').AsDateTime;

          __lblCustomer.Caption := kbmInvoiceheads.FieldByName('Customer').AsString+'  '+kbmInvoiceheads.FieldByName('Name').AsString;
          __lblAddress1.Caption := kbmInvoiceheads.FieldByName('Address1').AsString;
          __lblAddress2.Caption := kbmInvoiceheads.FieldByName('Address2').AsString;
          __lblAddress3.Caption := kbmInvoiceheads.FieldByName('Address3').AsString;
          __lblAddress4.Caption := kbmInvoiceheads.FieldByName('Address4').AsString;
          __lblEmailAddress.Caption := zEmailAddress;

          __lblRefrence.Caption := kbmInvoiceheads.FieldByName('invRefrence').AsString;

          Amount := kbmInvoiceheads.FieldByName('Total').AsFloat;
          __lblTotal.caption    := _floattostr(amount,8,2);

          __lblPayment.Caption  := kbmPayments.FieldByName('Description').AsString;
          __lblCurrency.Caption := kbmPayments.FieldByName('Currency').AsString;
          __lblReservationIds.Caption := kbmPayments.FieldByName('roomReservation').AsString+'/'+kbmPayments.FieldByName('Reservation').AsString;

          __lblCustomer.Visible := True;
          __lblAddress1.Visible := True;
          __lblAddress2.Visible := True;
          __lblAddress3.Visible := True;
          __lblAddress4.Visible := True;
          __lblEmailAddress.Visible := True;

          __lblRefrence.Visible := True;
          lblRefrence.Visible := True;

          gbAmounts.Visible := True;

          btnPreviewOrginal.Enabled := True;
          btnReservation.Enabled := kbmPayments.FieldByName('roomReservation').AsInteger > 0;

        end;

      finally
        screen.cursor := crDefault;
        kbmInvoiceheads.EnableControls;
        kbmInvoiceLines.EnableControls;
        kbmPayments.EnableControls;
      end;

      kbmInvoiceheads.first;
      kbmInvoiceLines.first;
      kbmPayments.first;

      if zInvoicenumber > 0 then
      begin
        memExtratext.Text  := kbmInvoiceHeads.fieldbyname('Extratext').AsString;
//        dtInvoicedate.date :=kbmInvoiceHeads.fieldbyname('ihInvoiceDate').asDateTime;
//        dtPayDate.date     :=kbmInvoiceHeads.fieldbyname('ihInvoiceDate').asDateTime; //Ath could be ? set from kbmInvoiceHeads.fieldbyname('ihPayDate').asDateTime;
       end;
    finally
      ExecutionPlan.Free;
    end;
  end;
end;

procedure TfrmMakeKreditInvoice.sButton1Click(Sender: TObject);
begin
  refresh;
end;

procedure TfrmMakeKreditInvoice.sSpeedButton1Click(Sender: TObject);
begin
  dtInvoiceDate.date := kbmInvoiceheads.FieldByName('ihInvoicedate').AsDateTime;
  dtPayDate.date := kbmInvoiceheads.FieldByName('ihPayDate').AsDateTime;
end;

procedure TfrmMakeKreditInvoice.btnWithoutRefrClick(Sender: TObject);
begin
   //**
EditInvoice(0, // Reservation,
      0, // RoomReservation,
      1, // SplitNumber : integer;
      0, // InvoiceIndex
      0, // Arrival,
      0, // Departure : TDate;
      true, // bCredit,
      true // aModal : boolean
      , false);

end;

end.
