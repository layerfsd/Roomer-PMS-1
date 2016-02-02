unit uTestData;

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
  , Vcl.ComCtrls
  , Vcl.ExtCtrls
  , Vcl.StdCtrls
  , Data.DB
  , Vcl.Mask
  , Vcl.Menus
  , Vcl.DBCtrls

  , ug
  , hData
  , uStringUtils
  , _glob
  , uAppglobal
  , kbmMemTable
  , kbmMemCSVStreamFormat

  , cmpRoomerDataSet
  , cmpRoomerConnection

  , objNewReservation
  , objRoomRates

  , acProgressBar
  , sPageControl
  , sStatusBar
  , sPanel
  , sButton
  , sEdit
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sLabel
  , sGroupBox

  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxStyles
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxEdit
  , cxNavigator
  , cxMemo
  , cxDBData
  , cxGridLevel
  , cxGridBandedTableView
  , cxGridDBBandedTableView
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxClasses
  , cxGridCustomView
  , cxGrid
  , cxContainer
  , cxTextEdit
  , cxMaskEdit
  , cxButtonEdit

  , dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  sMemo, AdvEdit, AdvEdBtn

  ;

type
  TfrmTestData = class(TForm)
    panMainTop: TsPanel;
    sStatusBar1: TsStatusBar;
    pgMain: TsPageControl;
    sheetUpdateNames: TsTabSheet;
    sheetChangeDates: TsTabSheet;
    btnExit: TsButton;
    sPanel1: TsPanel;
    sButton3: TsButton;
    sButton2: TsButton;
    grFakeNames: TcxGrid;
    tvFakeNames: TcxGridDBTableView;
    cxGridDBTableView3: TcxGridDBTableView;
    cxGridDBColumn60: TcxGridDBColumn;
    cxGridDBColumn61: TcxGridDBColumn;
    cxGridDBColumn62: TcxGridDBColumn;
    cxGridDBColumn63: TcxGridDBColumn;
    cxGridDBColumn64: TcxGridDBColumn;
    cxGridDBColumn65: TcxGridDBColumn;
    cxGridDBColumn66: TcxGridDBColumn;
    cxGridDBColumn67: TcxGridDBColumn;
    cxGridDBColumn68: TcxGridDBColumn;
    cxGridDBColumn69: TcxGridDBColumn;
    cxGridDBColumn70: TcxGridDBColumn;
    cxGridDBColumn71: TcxGridDBColumn;
    cxGridDBBandedTableView1: TcxGridDBBandedTableView;
    lvFakeNames: TcxGridLevel;
    Label4: TsLabel;
    edImportfile: TsFilenameEdit;
    tvFakeNamesgender: TcxGridDBColumn;
    tvFakeNamestitle: TcxGridDBColumn;
    tvFakeNamesgivenname: TcxGridDBColumn;
    tvFakeNamessurname: TcxGridDBColumn;
    tvFakeNamesstreetaddress: TcxGridDBColumn;
    tvFakeNamesCity: TcxGridDBColumn;
    tvFakeNamesstate: TcxGridDBColumn;
    tvFakeNameszipcode: TcxGridDBColumn;
    tvFakeNamesCountry: TcxGridDBColumn;
    tvFakeNamesemailaddress: TcxGridDBColumn;
    tvFakeNamestelephonenumber: TcxGridDBColumn;
    edCountry: TcxButtonEdit;
    labCountryName: TsLabel;
    edFilter: TAdvEditBtn;
    sGroupBox1: TsGroupBox;
    edReservation: TsEdit;
    sLabel1: TsLabel;
    sButton1: TsButton;
    sLabel2: TsLabel;
    kbmRwavReservations: TkbmMemTable;
    RwavGuestsDS: TDataSource;
    RwavReservationsDS: TDataSource;
    kbmBookingcom: TkbmMemTable;
    kbmBookingComRes: TkbmMemTable;
    DataSource2: TDataSource;
    kbmMemTable1: TkbmMemTable;
    DataSource1: TDataSource;
    sTabSheet5: TsTabSheet;
    sPanel6: TsPanel;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    DBMemo2: TDBMemo;
    TabSheet6: TTabSheet;
    DBMemo1: TDBMemo;
    TabSheet7: TTabSheet;
    DBMemo3: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edContactName: TEdit;
    edRoomCount: TEdit;
    Label10: TLabel;
    edTotalprice: TEdit;
    edAddress: TEdit;
    edContactTel: TEdit;
    edContactEmail: TEdit;
    edOrderdate: TEdit;
    edRefr: TEdit;
    edNationality: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    grReservations: TcxGrid;
    tvReservations: TcxGridDBTableView;
    tvReservationsrefr: TcxGridDBColumn;
    tvReservationscontactName: TcxGridDBColumn;
    tvReservationsroomcount: TcxGridDBColumn;
    tvReservationsAddress: TcxGridDBColumn;
    tvReservationscontacttel: TcxGridDBColumn;
    tvReservationscontactEmail: TcxGridDBColumn;
    tvReservationsorderdate: TcxGridDBColumn;
    lvReservations: TcxGridLevel;
    TabSheet5: TTabSheet;
    TabSheet4: TTabSheet;
    Memo2: TMemo;
    kbmCSVStreamFormat1: TkbmCSVStreamFormat;
    kbmRoomRes: TkbmMemTable;
    kbmReservations: TkbmMemTable;
    kbmReservationsDS: TDataSource;
    PopupMenu1: TPopupMenu;
    P1: TMenuItem;
    kbmRoomResDS: TDataSource;
    sPanel7: TsPanel;
    grRooms: TcxGrid;
    tvRooms: TcxGridDBTableView;
    tvRoomsRefr: TcxGridDBColumn;
    tvRoomsRoomSerial: TcxGridDBColumn;
    tvRoomsGuestName: TcxGridDBColumn;
    tvRoomsCheckin: TcxGridDBColumn;
    tvRoomsCheckout: TcxGridDBColumn;
    tvRoomsRoomtype: TcxGridDBColumn;
    tvRoomsNumberOfPersons: TcxGridDBColumn;
    tvRoomsCostsPerNight: TcxGridDBColumn;
    tvRoomsStatus: TcxGridDBColumn;
    tvRoomsSmoking_preference: TcxGridDBColumn;
    tvRoomsCancellation_Policy: TcxGridDBColumn;
    tvRoomsMeal_Plan: TcxGridDBColumn;
    tvRoomsArrival: TcxGridDBColumn;
    tvRoomsDeparture: TcxGridDBColumn;
    tvRoomsNumberofnights: TcxGridDBColumn;
    tvRoomsTotalCosts: TcxGridDBColumn;
    tvRoomsDeposit_Policy: TcxGridDBColumn;
    tvRoomsGuestsRemarks: TcxGridDBColumn;
    lvRooms: TcxGridLevel;
    btnGetRoomTypes: TsButton;
    tvRoomMap: TcxGridDBTableView;
    lvRoomMap: TcxGridLevel;
    grRoomMap: TcxGrid;
    kbmRoomMap: TkbmMemTable;
    kbmRoomMapDS: TDataSource;
    tvRoomMapBRoom: TcxGridDBColumn;
    tvRoomMapHRoom: TcxGridDBColumn;
    labCustomer: TsLabel;
    edCustomer: TsEdit;
    labRackCustomerName: TsLabel;
    labCurrency: TsLabel;
    edCurrency: TsEdit;
    labCurrencyname: TsLabel;
    sProgressBar2: TsProgressBar;
    edResFileName: TsFilenameEdit;
    btnInsertToRoomer: TsButton;
    procedure sButton1Click(Sender: TObject);
    procedure edResFileNameAfterDialog(Sender: TObject; var Name: string; var Action: Boolean);
    procedure kbmReservationsAfterScroll(DataSet: TDataSet);
    procedure kbmRoomResAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGetRoomTypesClick(Sender: TObject);
    procedure btnInsertToRoomerClick(Sender: TObject);
    procedure edCustomerDblClick(Sender: TObject);
    procedure edCurrencyDblClick(Sender: TObject);
  private
    zFirstTime : boolean;
    procedure fixRefr;
    { Private declarations }    procedure ApplyFilter;
  public
    { Public declarations }
  end;

var
  frmTestData: TfrmTestData;

implementation

{$R *.dfm}

uses
     uCountries
   , ud
   , uDayNotes
   , uCustomers2
   , uCurrencies

   , uDImages;

procedure TfrmTestData.edCustomerDblClick(Sender: TObject);
var
  theData : recCustomerHolder;
  s : string;
begin
  theData.Customer := trim(edCustomer.text);
  if OpenCustomers(actLookup, true, theData) then
  begin
    s := theData.Customer;
    if (s <> '') and (s <> trim(edCustomer.text)) then
    begin
      edCustomer.text := s;
    end;
  end;
end;

procedure TfrmTestData.edResFileNameAfterDialog(Sender: TObject; var Name: string; var Action: Boolean);
var
  resFilename  : string;
  roomFilename : string;
  p : integer;
  resOK,roomOK : boolean;
begin
  zFirsttime := true;
  screen.Cursor := crHourGlass;
  try
    resOK  := false;
    roomOK := false;
    if fileexists(name) then
    begin
       kbmReservations.close;
       kbmRoomRes.close;

       kbmReservations.open;
       kbmRoomRes.open;
       resFilename := lowercase(name);
       try
         kbmReservations.LoadFromFile(resFilename);
         resOK := true;
       Except
         resOK := false;
       end;
       if kbmReservations.recordcount > 0 then
       begin
         p := pos('_res.csv',resfilename);
         roomFilename := '';

         if p > 0 then
         begin
           roomFilename := copy(resfilename,1,p-1)+'_room.csv';
           if fileexists(roomfileName) then
           begin
             try
               kbmRoomRes.LoadFromFile(roomFilename);
               roomOk := true;
             Except
               roomOK := false;
             end;
           end;
         end;
       end;
    end;

    if (resOK=false) or (roomOk = false)  then
    begin
       showmessage('Can not load files');
    end else
    begin
      fixRefr;
      zFirsttime := false;
      kbmReservations.First;
    end;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmTestData.FormCreate(Sender: TObject);
begin
  zfirstTime := true;
end;

procedure TfrmTestData.FormShow(Sender: TObject);
begin
  zFirstTime := true;
end;

procedure TfrmTestData.kbmReservationsAfterScroll(DataSet: TDataSet);
begin
  if zFirsttime  then exit;
  edContactName.Text  := kbmReservations.FieldByName('contactName').AsString;
  edRoomCount.text    := inttostr(kbmReservations.FieldByName('roomcount').AsInteger);
  edAddress.text      := kbmReservations.FieldByName('Address').AsString;
  edContactTel.text   := kbmReservations.FieldByName('contacttel').AsString;
  edContactEmail.text := kbmReservations.FieldByName('contactEmail').AsString;
  edorderDate.text    := kbmReservations.FieldByName('orderdate').AsString;
  edrefr.text         := kbmReservations.FieldByName('refr').AsString;
  edNationality.text  := kbmReservations.FieldByName('Nationality').AsString;
end;

procedure TfrmTestData.kbmRoomResAfterScroll(DataSet: TDataSet);
var
  refr : string;
begin
  if zFirsttime  then exit;
  try
    refr := kbmRoomres.FieldByName('refr').AsString;
    kbmReservations.locate('refr',refr,[]);
  except
  end;
end;


procedure TfrmTestData.btnInsertToRoomerClick(Sender: TObject);
var
  i : integer;

  oNewReservation : TNewReservation;
  oSelectedRoomItem : TnewRoomReservationItem;

  idprenota : integer;
  id_client : integer;    //Gestur
  id_apartment : string;  //Room


  Arrival : Tdate;
  Departure : Tdate;

  //***
  sTmp : string;
  discount : double;
  dayDiscount : double;


  RackCustomer : string;
  Customer : string;

  aRoom        : string;
  aGuestCount  : integer;
  aAvragePrice : double;

  sRoomprices : string;
  lstRoomPrices : TstringList;
  lstR : TstringList;

  Price      : double;
  TotalPrice : double;


  avrPrice     : double;
  avrDiscount  : double;
  rateCount    : integer;

  aMainGuestName   : string;
  aInfantCount     : integer;
  aChildrenCount   : integer;
  aPriceCode       : string;

  dateCount : integer;


  rateItem         : TRateItem;

  rateRoomNumber   : string;
  rateDate         : Tdate;
  rate             : double;
  ratePriceCode    : string;
  rateDiscount     : double;
  rateIsPercentage : boolean;
  rateShowDiscount : boolean;
  rateIsPaid       : boolean;

  roomreservation : integer;

  countryName  : string;
  countryCode : string;

  totalRate : double;
  paid : double;

  Res   : integer;
  rooms : integer;

  room     : string;
  roomType : string;

  GuestCount       : integer;
  AvragePrice      : double;
  AvrageDiscount   : double;
  ChildrenCount    : integer;
  infantCount      : integer;
  PriceCode        : string;
  isPercentage     : boolean;
  mainGuestName    : string;
  ii : integer;

  oo : integer;
  p : integer;

  Address1 : string;
  Address2 : string;
  Address3 : string;
  Address4 : string;

  refr : string;
  mainGuest : string;

  address : string;
  currency : string;

  contactName  : string;
  contactTel   : string;
  contactEmail : string;

  fs : TFormatSettings;

  paymentinfo : string;
  generalInfo : string;
  roomInfo    : string;
  remarks     : string;


begin
  //**
  zFirstTime := true;
  kbmRoomRes.DisableControls;
  kbmReservations.DisableControls;
  kbmRoomMap.DisableControls;
  try

    Customer := trim(edCustomer.Text);
    if customer = '' then
    begin
      showmessage('Select the Booking.com customer');
      edCustomer.SetFocus;
      exit;
    end;

    sProgressBar2.Max := kbmReservations.recordcount;
    sProgressBar2.Position := 0;

    kbmReservations.First;
    kbmRoomRes.First;

    kbmReservations.SortFields := 'Refr';
//  kbmReservations_.SortOptions :=  [mtcoDescending];
    kbmReservations.Sort([]);
    kbmReservations.first;

    kbmRoomRes.SortFields := 'Refr;roomserial';
//  kbmReservations_.SortOptions :=  [mtcoDescending];
    kbmRoomRes.Sort([]);
    kbmRoomRes.first;

    frmdayNotes.memLog.Clear;
    frmdayNotes.memLog.Lines.Add('---'+Caption+'-----');
    frmdayNotes.memLog.Lines.Add('');

    oo := 0;
    while not kbmReservations.Eof {and (oo < 20)} do
    begin
      inc(oo);
      sProgressBar2.Position := sProgressBar2.Position+1;
      try
        paymentInfo := '';
        generalInfo := '';

        kbmRoomres.filtered := false;
        aInfantCount     := 0;
        aChildrenCount   := 0;

        refr     := kbmReservations.FieldByName('refr').AsString;
        kbmRoomres.Filter := '(refr='+refr+')';
        kbmRoomres.filtered := true;
        kbmRoomres.first;

        mainGuest := kbmRoomres.fieldbyname('GuestName').asstring;
        address   := kbmReservations.FieldByName('Address').asstring;

        address1  := _glob._strTokenAt(address,',',0);
        address2  := _glob._strTokenAt(address,',',1);
        address3  := _glob._strTokenAt(address,',',2);
        address4  := _glob._strTokenAt(address,',',3);

        countryCode := d.getCountryCode(address4);

//        showmessage(Address1+'|'+address2+'|'+address3+'|'+address4);

        try
          oNewReservation := TNewReservation.Create(g.qHotelCode,g.qUser,address1,address2,address3,address4);
        Except
        end;


        currency := edCurrency.Text;
        sTmp := kbmRoomres.FieldByName('TotalCosts').AsString;
        sTmp := trim(sTmp);
        p := pos(' ',sTmp);
        if p = 4 then currency := copy(sTmp,1,3);

        contactname := copy(kbmReservations.FieldByName('contactName').asstring,1,100);
        if Trim(contactName) = '' then
        begin
          contactname := copy(mainGuest,1,100);
        end;
        contactName := trim(contactname);
        if contactName = '' then contactName := 'MainGuest';

        contactTel   := copy(kbmReservations.FieldByName('contacttel').asstring,1,31);
        contactEmail := copy(kbmReservations.FieldByName('contactEmail').asstring,1,50);


        oNewReservation.resMedhod := rmNormal;
        oNewReservation.IsQuick   := true;
        oNewReservation.HomeCustomer.Customer_update(customer);
        oNewReservation.HomeCustomer.IsGroupInvoice    := False;


        oNewReservation.HomeCustomer.Customer               := Customer;
        oNewReservation.HomeCustomer.GuestName              := mainGuest;
        oNewReservation.HomeCustomer.invRefrence            := refr;
        oNewReservation.HomeCustomer.Country                := countryCode;
        oNewReservation.HomeCustomer.ReservationName        := 'Booking.com';
        oNewReservation.HomeCustomer.RoomStatus             := 'P';
        oNewReservation.HomeCustomer.IsGroupInvoice         := False;
        oNewReservation.HomeCustomer.Currency               := currency;
        oNewReservation.HomeCustomer.ContactPerson          := contactName;
        oNewReservation.HomeCustomer.ContactPhone           := contactTel;
        oNewReservation.HomeCustomer.ContactEmail           := contactEmail;
        oNewReservation.HomeCustomer.ContactAddress1        := Address1;
        oNewReservation.HomeCustomer.ContactAddress2        := Address2;
        oNewReservation.HomeCustomer.ContactAddress3        := Address3;
        oNewReservation.HomeCustomer.ContactAddress4        := Address4;

                                                                    ;
        oNewReservation.HomeCustomer.ShowDiscountOnInvoice  := false;
        oNewReservation.HomeCustomer.isRoomResDiscountPrec  := True;
        oNewReservation.HomeCustomer.RoomResDiscount        := 0;


        remarks := kbmReservations.FieldByName('Resremarks').AsString;

        if trim(remarks) <>'' then
            generalinfo := generalinfo+#10+'---------'+#10+remarks;

        i := 0;
        kbmRoomres.first;
        while not kbmRoomres.eof do
        begin
          roomInfo := '';
          inc(i);
          Room            := '';
          RoomType        := KbmRoomres.fieldbyname('RoomType').asstring;
          if kbmRoomMap.Locate('BRoom',roomtype,[]) then
          begin
            RoomType := kbmRoomMap.fieldbyname('HRoom').AsString;
          end;
          roomtype := copy(roomtype,1,10);

          fs.DateSeparator := '-';
          fs.ShortDateFormat := 'dd-mm-yyyy';
          sTmp := KbmRoomRes.FieldByName('checkin').asString;
          Arrival := strToDateTime(sTmp,fs);

          fs.ShortDateFormat := 'dd-mm-yyyy';
          sTmp := KbmRoomRes.FieldByName('checkout').asString;
          Departure       := strToDateTime(sTmp,fs);

          sTmp := KbmRoomRes.FieldByName('NumberOfPersons').AsString;
          try
            GuestCount := strToInt(sTmp);
          except
            GuestCount := 1;
            // add to notes;
          end;
          roomreservation := RR_SetNewID();
          sTmp := KbmRoomRes.FieldByName('CostsPerNight').AsString;
          try
            AvragePrice := _strToFloat(sTmp);
          Except
            AvragePrice := 1;
            // Add to notes
          end;

          AvrageDiscount  := 0;
          RateCount       := 1;
          ChildrenCount   := 0;
          infantCount     := 0;
          PriceCode       := 'RACK';
          isPercentage    := False;
          mainGuestName   := KbmRoomRes.FieldByName('Guestname').AsString;
          if trim(mainGuestName) = '' then mainGuestName := contactName;
          if trim(mainGuestName) = '-' then mainGuestName :=contactName;

          mainGuestName := copy(mainGuestName,1,100);

          stmp := KbmRoomRes.FieldByName('status').AsString;
          if stmp <> '' then
             roomInfo := roomInfo+#10+'  --Status--'+sTmp;

          sTmp := trim(lowercase(stmp));

          if sTmp <> 'ok' then
          begin
            oNewReservation.HomeCustomer.RoomStatus := 'C';
          end;


          stmp := KbmRoomRes.FieldByName('GuestsRemarks').AsString;
          if stmp <> '' then
            roomInfo := roomInfo+#10+' --Guest remarks--'+sTmp;

          stmp := KbmRoomRes.FieldByName('Meal_Plan').AsString;
          if stmp <> '' then
            roomInfo := roomInfo+#10+'  --Mealplan--'+sTmp;

          stmp := KbmRoomRes.FieldByName('Cancellation_Policy').AsString;
          if stmp <> '' then
            roomInfo := roomInfo+#10+'  --Cancellation Policy--'+sTmp;

          stmp := KbmRoomRes.FieldByName('Deposit_Policy').AsString;
          if stmp <> '' then
            roomInfo := roomInfo+#10+'  --Deposit Policy--'+sTmp;

          stmp := KbmRoomRes.FieldByName('Smoking_preference').AsString;
          if stmp <> '' then
            roomInfo := roomInfo+#10+'  --Smoking preference--'+sTmp;





          oSelectedRoomItem := TnewRoomReservationItem.Create(roomreservation,
                                                               aRoom,
                                                               RoomType,
                                                               '',
                                                               Arrival,
                                                               departure,
                                                               GuestCount,
                                                               AvragePrice,
                                                               AvrageDiscount,
                                                               false,
                                                               rateCount,
                                                               ChildrenCount,
                                                               InfantCount,
                                                               PriceCode,
                                                               MainGuestName,
                                                               roomInfo);

            oNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
            dateCount := trunc(departure)-trunc(arrival);
            for ii := 1 to dateCount do
            begin
              rateRoomNumber   := '<'+inttostr(roomreservation)+'>';
              rateDate         := Arrival+ii-1;
              rate             := AvragePrice;
              ratePriceCode    := 'RACK';
              rateDiscount     := 0;
              rateIsPercentage := true;
              rateShowDiscount := false;
              rateIsPaid       := false;
              rateItem := TRateItem.Create(rate,rateDate,rateDiscount,rateShowDiscount,rateIsPercentage,rateisPaid,ratePriceCode,rateRoomNumber,-1,roomreservation);
              oNewReservation.newRoomReservations.RoomItemsList[i-1].oRates.RateItemsList.Add(rateItem);
            end;
            KbmRoomRes.Next;

           oNewReservation.HomeCustomer.ReservationPaymentInfo := paymentinfo;
           oNewReservation.HomeCustomer.ReservationGeneralInfo := generalInfo;


          end;
        screen.Cursor := crHourGlass;
        try
          oNewReservation.CreateReservation;
        finally
          screen.Cursor := crDefault;
        end;

      finally
        freeandnil(oNewReservation);
      end;
      kbmReservations.next;
    end;
  finally
    kbmRoomRes.EnableControls;
    kbmReservations.EnableControls;
    kbmRoomMap.EnableControls;
    zFirstTime := false;
  end;
end;

procedure TfrmTestData.fixRefr;
var
  sTmp : string;

begin
  zFirstTime := true;
  kbmRoomRes.DisableControls;
  kbmReservations.DisableControls;
  kbmRoomMap.DisableControls;
  try
    kbmReservations.First;
    while not kbmReservations.eof do
    begin
      sTmp := kbmReservations.FieldByName('refr').AsString;
      if pos('#',sTmp) = 1 then
      begin
        delete(stmp,1,1);
        kbmReservations.edit;
        kbmReservations.FieldByName('refr').AsString := sTmp;
        kbmReservations.post;
      end;
      kbmReservations.next;
    end;

    kbmRoomRes.First;
    while not kbmRoomRes.eof do
    begin
      sTmp := trim(kbmRoomRes.FieldByName('refr').AsString);
      if pos('#',sTmp) = 1 then
      begin
        delete(stmp,1,1);
        kbmRoomRes.edit;
        kbmRoomRes.FieldByName('refr').AsString := sTmp;
        kbmRoomRes.post;
      end;
      kbmRoomRes.next;
    end;
  finally
    kbmRoomRes.EnableControls;
    kbmReservations.EnableControls;
    kbmRoomMap.EnableControls;
    zFirstTime := false;
    kbmReservations.First;
    kbmRoomRes.First;
  end;
end;


procedure TfrmTestData.sButton1Click(Sender: TObject);
var
  i : integer;
  recRoomReservation : recRoomReservationHolder;

  roomreservation : integer;
  reservation     : integer;
  Arrival         : integer;
  departure       : integer;

  recPerson : recPersonHolder;
  Person : integer;

begin
  initRoomReservationHolderRec(recRoomReservation);
  SP_GET_RoomReservation(RoomReservation);
  recPerson := GET_Pesson(Person);
end;

procedure TfrmTestData.ApplyFilter;
begin
end;

procedure TfrmTestData.btnGetRoomTypesClick(Sender: TObject);
var
  RoomType : string;
  i : integer;
begin
  zFirstTime := true;
  screen.cursor := crHourGlass;
  i := kbmRoomres.recordCount;
  kbmRoomres.DisableControls;
  kbmRoomMap.DisableControls;
//  DBMemo1.DisableControls;
//  DBMemo2.DisableControls;
//  DBMemo3.DisableControls;
 try
    kbmRoomres.first;
    while not kbmRoomres.eof do
    begin
      i := i-1;
      //sLabel3.Caption := inttostr(i);
      //application.ProcessMessages;
      roomtype := kbmRoomres.fieldbyname('roomtype').AsString;
      if not kbmRoomMap.locate('BRoom',roomtype,[]) then
      begin
        kbmRoomMap.Insert;
        kbmRoomMap.FieldByName('BRoom').AsString := roomtype;
        kbmRoomMap.Post;
      end;
      kbmRoomres.next;
    end;
  finally
    kbmRoomres.EnableControls;
    kbmRoomMap.EnableControls;
//    DBMemo1.EnableControls;
//    DBMemo2.EnableControls;
//    DBMemo3.EnableControls;
    zFirsttime := false;
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmTestData.edCurrencyDblClick(Sender: TObject);
var
  theData : recCurrencyHolder;
begin
  theData.Currency := trim(edCurrency.text);
  if Currencies(actLookup,theData) then
  begin
    edCurrency.text := theData.Currency;
    labCurrencyname.caption := theData.Description;
  end;
end;

end.
