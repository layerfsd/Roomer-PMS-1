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
  ,NativeXML

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

  , cxGridExportLink
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

  , sMemo
  , AdvEdit
  , AdvEdBtn

  , dxSkinsCore
  , dxSkinCaramel
  , dxSkinCoffee
  , dxSkinDarkSide
  , dxSkinTheAsphaltWorld
  , dxSkinsDefaultPainters
  , dxSkinscxPCPainter

  ;

type
  TfrmTestData = class(TForm)
    panMainTop: TsPanel;
    sStatusBar1: TsStatusBar;
    btnExit: TsButton;
    kbmRwavReservations: TkbmMemTable;
    RwavGuestsDS: TDataSource;
    RwavReservationsDS: TDataSource;
    kbmBookingcom: TkbmMemTable;
    kbmBookingComRes: TkbmMemTable;
    DataSource2: TDataSource;
    kbmMemTable1: TkbmMemTable;
    DataSource1: TDataSource;
    kbmCSVStreamFormat1: TkbmCSVStreamFormat;
    kbmRoomRes: TkbmMemTable;
    kbmReservations: TkbmMemTable;
    kbmReservationsDS: TDataSource;
    PopupMenu1: TPopupMenu;
    P1: TMenuItem;
    kbmRoomResDS: TDataSource;
    kbmRoomMap: TkbmMemTable;
    kbmRoomMapDS: TDataSource;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    DK: TsTabSheet;
    sPanel2: TsPanel;
    edResFileName: TsFilenameEdit;
    btnInsertToRoomer: TsButton;
    pgMain: TsPageControl;
    sheetUpdateNames: TsTabSheet;
    sPanel1: TsPanel;
    Label4: TsLabel;
    labCountryName: TsLabel;
    sLabel2: TsLabel;
    sButton3: TsButton;
    sButton2: TsButton;
    edImportfile: TsFilenameEdit;
    edCountry: TcxButtonEdit;
    edFilter: TAdvEditBtn;
    sGroupBox1: TsGroupBox;
    sLabel1: TsLabel;
    edReservation: TsEdit;
    sButton1: TsButton;
    grFakeNames: TcxGrid;
    tvFakeNames: TcxGridDBTableView;
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
    sheetChangeDates: TsTabSheet;
    sTabSheet5: TsTabSheet;
    sPanel6: TsPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    DBMemo2: TDBMemo;
    TabSheet6: TTabSheet;
    DBMemo1: TDBMemo;
    TabSheet7: TTabSheet;
    DBMemo3: TDBMemo;
    edContactName: TEdit;
    edRoomCount: TEdit;
    edTotalprice: TEdit;
    edAddress: TEdit;
    edContactTel: TEdit;
    edContactEmail: TEdit;
    edOrderdate: TEdit;
    edRefr: TEdit;
    edNationality: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    sPanel7: TsPanel;
    labCustomer: TsLabel;
    labRackCustomerName: TsLabel;
    labCurrency: TsLabel;
    labCurrencyname: TsLabel;
    btnGetRoomTypes: TsButton;
    edCustomer: TsEdit;
    edCurrency: TsEdit;
    sProgressBar2: TsProgressBar;
    grRoomMap: TcxGrid;
    tvRoomMap: TcxGridDBTableView;
    tvRoomMapBRoom: TcxGridDBColumn;
    tvRoomMapHRoom: TcxGridDBColumn;
    lvRoomMap: TcxGridLevel;
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
    TabSheet4: TTabSheet;
    Memo2: TMemo;
    ProgressBar1: TProgressBar;
    PageControl3: TPageControl;
    TabSheet8: TTabSheet;
    Panel2: TPanel;
    btnRunDlXml: TButton;
    Panel3: TPanel;
    memXmlFile: TMemo;
    clabXmlFile: TLabel;
    edXMLFile: TsFilenameEdit;
    TabSheet9: TTabSheet;
    Splitter1: TSplitter;
    DBEdit1: TDBEdit;
    Panel4: TPanel;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Panel10: TPanel;
    Label11: TLabel;
    grBookings: TcxGrid;
    tvBookings: TcxGridDBTableView;
    tvBookingsbookingnumber: TcxGridDBColumn;
    tvBookingsownerNumber: TcxGridDBColumn;
    tvBookingsbookingTypeCode: TcxGridDBColumn;
    tvBookingsname: TcxGridDBColumn;
    tvBookingsdescription: TcxGridDBColumn;
    tvBookingsreference: TcxGridDBColumn;
    tvBookingstravelAgentBookingId: TcxGridDBColumn;
    tvBookingsdateFrom: TcxGridDBColumn;
    tvBookingsdateTo: TcxGridDBColumn;
    tvBookingscolor: TcxGridDBColumn;
    tvBookingscustomer: TcxGridDBColumn;
    tvBookingsphone: TcxGridDBColumn;
    tvBookingsemail: TcxGridDBColumn;
    tvBookingsbookingConfirmed: TcxGridDBColumn;
    tvBookingsconfirmationDeadline: TcxGridDBColumn;
    tvBookingsoneInvoiceForAllRooms: TcxGridDBColumn;
    tvBookingsseperateExtrasInvoice: TcxGridDBColumn;
    tvBookingspaymentType: TcxGridDBColumn;
    tvBookingsdiscount: TcxGridDBColumn;
    tvBookingscurrencyCode: TcxGridDBColumn;
    tvBookingscountryCode: TcxGridDBColumn;
    tvBookingsexchange: TcxGridDBColumn;
    lvBookings: TcxGridLevel;
    Panel11: TPanel;
    Label12: TLabel;
    grParticipant: TcxGrid;
    tvParticipant: TcxGridDBTableView;
    tvParticipantbookingNumber: TcxGridDBColumn;
    tvParticipantnumber: TcxGridDBColumn;
    tvParticipantname: TcxGridDBColumn;
    tvParticipantcountryCode: TcxGridDBColumn;
    tvParticipantresourceCode: TcxGridDBColumn;
    lvParticipant: TcxGridLevel;
    Panel12: TPanel;
    Panel13: TPanel;
    Label13: TLabel;
    grBookingSaleLines: TcxGrid;
    tvBookingSaleLines: TcxGridDBTableView;
    tvBookingSaleLinesbookingNumber: TcxGridDBColumn;
    tvBookingSaleLinescurrencyCode: TcxGridDBColumn;
    tvBookingSaleLinesexchange: TcxGridDBColumn;
    tvBookingSaleLinesitemCode: TcxGridDBColumn;
    tvBookingSaleLinesresourceCode: TcxGridDBColumn;
    tvBookingSaleLinessalesPerson: TcxGridDBColumn;
    tvBookingSaleLinescustomer: TcxGridDBColumn;
    tvBookingSaleLinesresourceGroup: TcxGridDBColumn;
    tvBookingSaleLinespriceID: TcxGridDBColumn;
    tvBookingSaleLinesquantity: TcxGridDBColumn;
    tvBookingSaleLinesincludedInPrice: TcxGridDBColumn;
    tvBookingSaleLinesdateFrom: TcxGridDBColumn;
    tvBookingSaleLinesdateTo: TcxGridDBColumn;
    tvBookingSaleLinesaddTime: TcxGridDBColumn;
    tvBookingSaleLinesitemPrice: TcxGridDBColumn;
    tvBookingSaleLinesitemDiscount: TcxGridDBColumn;
    tvBookingSaleLinesitemDiscountPercent: TcxGridDBColumn;
    tvBookingSaleLinesitemPriceWithTax: TcxGridDBColumn;
    tvBookingSaleLinesitemDiscountWithTax: TcxGridDBColumn;
    tvBookingSaleLinesitemDescription: TcxGridDBColumn;
    tvBookingSaleLinesinvoiceStatus: TcxGridDBColumn;
    tvBookingSaleLinessoHeadRecId: TcxGridDBColumn;
    tvBookingSaleLinesitemPriceForeign: TcxGridDBColumn;
    tvBookingSaleLinesitemPriceForeignWithTax: TcxGridDBColumn;
    tvBookingSaleLinesmBookingSaleLinesField25: TcxGridDBColumn;
    tvBookingSaleLinesmBookingSaleLinesField26: TcxGridDBColumn;
    lvBookingSaleLines: TcxGridLevel;
    Panel5: TPanel;
    Splitter2: TSplitter;
    Panel6: TPanel;
    PageControl4: TPageControl;
    TabSheet10: TTabSheet;
    Label14: TLabel;
    grResourceBookings: TcxGrid;
    tvResourceBookings: TcxGridDBTableView;
    tvResourceBookingsbookingNumber: TcxGridDBColumn;
    tvResourceBookingsdateFrom: TcxGridDBColumn;
    tvResourceBookingsdateTo: TcxGridDBColumn;
    tvResourceBookingsresourceGroup: TcxGridDBColumn;
    tvResourceBookingscolor: TcxGridDBColumn;
    tvResourceBookingsreserved: TcxGridDBColumn;
    tvResourceBookingsconfirmed: TcxGridDBColumn;
    lvResourceBookings: TcxGridLevel;
    TabSheet11: TTabSheet;
    Label15: TLabel;
    Label16: TLabel;
    Panel14: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBMemo4: TDBMemo;
    Panel7: TPanel;
    Splitter3: TSplitter;
    Panel8: TPanel;
    Label20: TLabel;
    grPrices: TcxGrid;
    tvPrices: TcxGridDBTableView;
    tvPricesbookingNumber: TcxGridDBColumn;
    tvPricespriceID: TcxGridDBColumn;
    tvPricescount: TcxGridDBColumn;
    tvPricesallocated: TcxGridDBColumn;
    tvPricesdateFrom: TcxGridDBColumn;
    tvPricesdateTo: TcxGridDBColumn;
    lvPrices: TcxGridLevel;
    Panel9: TPanel;
    Label21: TLabel;
    grAllocations: TcxGrid;
    tvAllocations: TcxGridDBTableView;
    tvAllocationsbookingNumber: TcxGridDBColumn;
    tvAllocationsdateFrom: TcxGridDBColumn;
    tvAllocationsdateTo: TcxGridDBColumn;
    tvAllocationsresourceCode: TcxGridDBColumn;
    tvAllocationsresourceGroup: TcxGridDBColumn;
    tvAllocationscolor: TcxGridDBColumn;
    tvAllocationspriceID: TcxGridDBColumn;
    lvAllocations: TcxGridLevel;
    mMemos: TkbmMemTable;
    mMemosDS: TDataSource;
    mParticipants: TkbmMemTable;
    mParticipantsDS: TDataSource;
    mBookingSaleLines: TkbmMemTable;
    mBookingSaleLinesDS: TDataSource;
    mBookingsDS: TDataSource;
    mBookings: TkbmMemTable;
    mResourceBookings: TkbmMemTable;
    mResourceBookingsDS: TDataSource;
    mAllocations: TkbmMemTable;
    mAllocationsDS: TDataSource;
    mPrices: TkbmMemTable;
    mPricesDS: TDataSource;
    TabSheet12: TTabSheet;
    mRooms: TkbmMemTable;
    tvDrRooms: TcxGridDBTableView;
    lvDrRooms: TcxGridLevel;
    grDrRooms: TcxGrid;
    mRoomsDS: TDataSource;
    tvDrRoomsRoom: TcxGridDBColumn;
    tvDrRoomsDescription: TcxGridDBColumn;
    tvDrRoomsRoomType: TcxGridDBColumn;
    tvDrRoomsimpRoom: TcxGridDBColumn;
    tvDrRoomsimpRoomType: TcxGridDBColumn;
    btnGetRoomerRooms: TButton;
    btnSaveToCSV: TButton;
    btnLoadFromCSV: TButton;
    btnGetImportRooms: TButton;
    edOwnerNumber: TEdit;
    CheckBox1: TCheckBox;
    kbmCSVStreamFormat2: TkbmCSVStreamFormat;
    btnToExcel: TButton;
    Customers: TTabSheet;
    Label22: TLabel;
    CustomerCSV: TsFilenameEdit;
    grCustomers: TcxGrid;
    tvCustomers: TcxGridDBTableView;
    lvCustomers: TcxGridLevel;
    mCustomers: TkbmMemTable;
    Button1: TButton;
    mCustomersDS: TDataSource;
    tvCustomersNumer: TcxGridDBColumn;
    tvCustomersHeiti: TcxGridDBColumn;
    tvCustomersHeimili: TcxGridDBColumn;
    tvCustomersPostnumer: TcxGridDBColumn;
    tvCustomersstadur: TcxGridDBColumn;
    tvCustomersLand: TcxGridDBColumn;
    tvCustomersKennitala: TcxGridDBColumn;
    tvCustomersFlokkur: TcxGridDBColumn;
    tvCustomerssimi: TcxGridDBColumn;
    tvCustomersGreidslumati: TcxGridDBColumn;
    tvCustomersnetfang: TcxGridDBColumn;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    edDefPcCode: TEdit;
    Label23: TLabel;
    Label24: TLabel;
    edDefCustomerType: TEdit;
    edDEfCurrency: TEdit;
    Label25: TLabel;
    tvCustomersId: TcxGridDBColumn;
    TabSheet13: TTabSheet;
    Label26: TLabel;
    itemsCSV: TsFilenameEdit;
    btnItemsSaveToFile: TButton;
    btnItemsLoadFromFile: TButton;
    btnItemsClear: TButton;
    itemsLoadToRoomer: TButton;
    mVorur: TkbmMemTable;
    tvItems: TcxGridDBTableView;
    lvItems: TcxGridLevel;
    grItems: TcxGrid;
    mVorurDS: TDataSource;
    tvItemsvorunumer: TcxGridDBColumn;
    tvItemsvorulysing: TcxGridDBColumn;
    tvItemsverdmvsk: TcxGridDBColumn;
    tvItemsvorufl: TcxGridDBColumn;
    tvItemsid: TcxGridDBColumn;
    Button5: TButton;
    tvBookingserr: TcxGridDBColumn;
    chkOccupied: TCheckBox;
    Button6: TButton;
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
    procedure btnRunDlXmlClick(Sender: TObject);
    procedure edXMLFileAfterDialog(Sender: TObject; var Name: string;
      var Action: Boolean);
    procedure DBEdit1Change(Sender: TObject);
    procedure btnGetRoomerRoomsClick(Sender: TObject);
    procedure btnSaveToCSVClick(Sender: TObject);
    procedure btnLoadFromCSVClick(Sender: TObject);
    procedure btnGetImportRoomsClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure btnToExcelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CustomerCSVAfterDialog(Sender: TObject; var Name: string;
      var Action: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure itemsCSVAfterDialog(Sender: TObject; var Name: string;
      var Action: Boolean);
    procedure itemsLoadToRoomerClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    zFirstTime : boolean;
    zDKIsReading : boolean;
    zDKXmlFilename : string;

    zDkDataPath : string;

    procedure fixRefr;
    procedure ApplyFilter;
    procedure ClearFilter;
    procedure DkInsertToRoomer;
    procedure DkInsertToRoomerSmari;

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



 type
    TArrayOfString = array of String;



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

  zDkDataPath := ExtractFilePath(ParamStr(0));

  zDKXMLFileName := '';
  edXMLFile.InitialDir :=  zDkDataPath;



end;

procedure TfrmTestData.FormShow(Sender: TObject);
begin
  zFirstTime := true;
end;

procedure TfrmTestData.itemsCSVAfterDialog(Sender: TObject; var Name: string;
  var Action: Boolean);
var
   lstVorur : TStringList;
   lstLine : Tstrings;
   sFileName : string;
   i : integer;
   s : string;
begin
  //**
  if mVorur.Active then mVorur.Close;
  mVorur.open;

  mVorur.DisableControls;
  try
    lstVorur := Tstringlist.Create;
    try
      sFilename := name;
      if fileexists(sFilename) then
      begin
        lstVorur.LoadFromFile(sFileName);
        for i := 0 to lstVorur.count-1 do
        begin
          s := lstVorur[i];
          lstLine := SplitStringToTStrings(';', S);
          try
            if lstLine.Count = 6 then
            begin
              mVorur.Append;
              mVorur['vorunumer']    := UTF8String(lstLine[0]);
              mVorur['vorulysing']   := UTF8String(lstLine[1]);
              mVorur['verdmvsk']     := UTF8String(lstLine[2]);
              mVorur['vorufl']       := UTF8String(lstLine[3]);
              mVorur.Post;
            end;
          finally
            lstLine.Free;
          end;
        end;
      end;
      mVorur.First;
    finally
      freeandnil(lstVorur);
    end;
  finally
    mVorur.EnableControls;
  end;
end;


procedure TfrmTestData.itemsLoadToRoomerClick(Sender: TObject);
var
 zData   : recItemHolder;
 newID   : integer;
begin

   newID := 0;

  ProgressBar1.Position := 0;
  ProgressBar1.Max := mCustomers.RecordCount;

  mCustomers.First;
  while not mVorur.Eof do
  begin
    ProgressBar1.stepIt;
    if not ItemExist(mVorur['vorunumer']) then
    begin
      initItemHolder(zData);
      zData.Active                   :=  true;
      zData.Item                     :=  mVorur['Vorunumer'] ;
      zData.Description              :=  mVorur['vorulysing'] ;
      zData.ItemType                 :=  mVorur['Vorufl'] ;
      zData.Price                    :=  strToFloat(mVorur['verdmvsk']) ;
      if INS_Item(zData,NewID) then
      begin
        mVorur.Edit;
        mVorur.FieldByName('id').AsInteger := NewID;
        mVorur.Post;
      end;
    end;
    mVorur.Next;
  end;
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


////////////////////////////////////////////////////////////////////////////////
///
///  DK XML IMPORT
///
////////////////////////////////////////////////////////////////////////////////


procedure TfrmTestData.btnRunDlXmlClick(Sender: TObject);
var
  i,ii,iii,iiii,iiiii : integer;

  bookingsCount : integer;


  aDoc       : TNativeXml;
  nBooking   : TXmlNode;
  nBookings  : TXmlNode;




  sBooking_bookingNumber             : string;
  sBooking_ownerNumber               : string;
  sBooking_bookingTypeCode           : string;
  sBooking_name                      : string;
  sBooking_description               : string;
  sBooking_reference                 : string;
  sBooking_travelAgentBookingId      : string;
  sBooking_dateFrom                  : string;
  sBooking_dateTo                    : string;
  sBooking_color                     : string;
  sBooking_customer                  : string;
  sBooking_phone                     : string;
  sBooking_email                     : string;
  sBooking_bookingConfirmed          : string;
  sBooking_confirmationDeadline      : string;
  sBooking_oneInvoiceForAllRooms     : string;
  sBooking_seperateExtrasInvoice     : string;
  sBooking_paymentType               : string;
  sBooking_discount                  : string;
  sBooking_currencyCode              : string;
  sBooking_countryCode               : string;
  sBooking_exchange                  : string;


  nResourceBookings : TXmlNode;
  nResourceBooking  : TXmlNode;

  ResourceBooking_dateFrom       : string;
  ResourceBooking_dateTo         : string;
  ResourceBooking_resourceGroup  : string;
  ResourceBooking_color          : string;
  ResourceBooking_reserved       : string;
  ResourceBooking_confirmed      : string;

  nPrices : TXmlNode;
  nPrice  : TXmlNode;

  Price_priceID      : string;
  Price_count        : string;
  Price_allocated    : string;
  Price_dateFrom     : string;
  Price_dateTo       : string;

  nAllocations : TXmlNode;
  nAllocation  : TXmlNode;

  nAllocation_dateFrom        : string;
  nAllocation_dateTo          : string;
  nAllocation_resourceCode    : string;
  nAllocation_resourceGroup   : string;
  nAllocation_color           : string;
  nAllocation_priceID         : string;


  nParticipants : TXmlNode;
  nParticipant : TXmlNode;

  participant_number        : string;
  participant_name          : string;
  participant_countryCode   : string;
  participant_resourceCode  : string;

  nBookingSaleLines : TXmlNode;
  nBookingSaleLine : TXmlNode;

  BookingSaleLine_currencyCode              : string;
  BookingSaleLine_exchange                  : string;
  BookingSaleLine_itemCode                  : string;
  BookingSaleLine_resourceCode              : string;
  BookingSaleLine_salesPerson               : string;
  BookingSaleLine_customer                  : string;
  BookingSaleLine_resourceGroup             : string;
  BookingSaleLine_priceID                   : string;
  BookingSaleLine_quantity                  : string;
  BookingSaleLine_includedInPrice           : string;
  BookingSaleLine_dateFrom                  : string;
  BookingSaleLine_dateTo                    : string;
  BookingSaleLine_addTime                   : string;
  BookingSaleLine_itemPrice                 : string;
  BookingSaleLine_itemDiscount              : string;
  BookingSaleLine_itemDiscountPercent       : string;
  BookingSaleLine_itemPriceWithTax          : string;
  BookingSaleLine_itemDiscountWithTax       : string;
  BookingSaleLine_itemDescription           : string;
  BookingSaleLine_invoiceStatus             : string;
  BookingSaleLine_soHeadRecId               : string;
  BookingSaleLine_itemPriceForeign          : string;
  BookingSaleLine_itemPriceForeignWithTax   : string;

  nMemos  : TXmlNode;
  nMemo   : TXmlNode;

  memo_memoText  : string;
  memo_memoName  : string;
  memo_miscId    : string;
  memo_pageId    : string;



begin
  zDKIsReading := true;
  bookingsCount := 0;
  ProgressBar1.Max := bookingsCount;

  if mBookings.Active = true then mBookings.Close;
  mBookings.Active := true;

  if mResourceBookings.Active = true then mResourceBookings.Close;
  mResourceBookings.Active := true;

  if mPrices.Active = true then mPrices.Close;
  mPrices.Active := true;

  if mAllocations.Active = true then mAllocations.Close;
  mAllocations.Active := true;

  if mParticipants.Active = true then mParticipants.Close;
  mParticipants.Active := true;

  if mMemos.Active = true then mMemos.Close;
  mMemos.Active := true;

  if mBookingSaleLines.Active = true then mBookingSaleLines.Close;
  mBookingSaleLines.Active := true;


  if fileExists(zDKXmlFilename) then
  begin
    mBookings.DisableControls;
    mResourceBookings.DisableControls;
    mPrices.DisableControls;
    mAllocations.DisableControls;
    mParticipants.DisableControls;
    mBookingSaleLines.DisableControls;
    mMemos.DisableControls;

    try
      aDoc := TNativeXml.Create(nil);
      try
        aDoc.Clear;
        aDoc.LoadFromFile(zDKXmlFilename);
        aDoc.XmlFormat := xfReadable;

        nBookings := aDoc.Root;
        if assigned(nBookings) then
        begin
          bookingsCount := nBookings.NodeCount;
          ProgressBar1.Max := bookingsCount;
          for i := 0 to nBookings.NodeCount - 1 do
          begin
            ProgressBar1.stepIt;
            nBooking  := nBookings[i];
            if assigned(nBooking) then
            begin
              sBooking_bookingNumber        :=    String(nBooking.ReadString(UTF8String('bookingNumber')));
              sBooking_ownerNumber          :=    String(nBooking.ReadString(UTF8String('ownerNumber')));
              sBooking_bookingTypeCode      :=    String(nBooking.ReadString(UTF8String('bookingTypeCode')));
              sBooking_name                 :=    String(nBooking.ReadString(UTF8String('name')));
              sBooking_description          :=    String(nBooking.ReadString(UTF8String('description')));
              sBooking_reference            :=    String(nBooking.ReadString(UTF8String('reference')));
              sBooking_travelAgentBookingId :=    String(nBooking.ReadString(UTF8String('travelAgentBookingId')));
              sBooking_dateFrom             :=    String(nBooking.ReadString(UTF8String('dateFrom')));
              sBooking_dateTo               :=    String(nBooking.ReadString(UTF8String('dateTo')));
              sBooking_color                :=    String(nBooking.ReadString(UTF8String('color')));
              sBooking_customer             :=    String(nBooking.ReadString(UTF8String('customer')));
              sBooking_phone                :=    String(nBooking.ReadString(UTF8String('phone')));
              sBooking_email                :=    String(nBooking.ReadString(UTF8String('email')));
              sBooking_bookingConfirmed     :=    String(nBooking.ReadString(UTF8String('bookingConfirmed')));
              sBooking_confirmationDeadline :=    String(nBooking.ReadString(UTF8String('confirmationDeadline')));
              sBooking_oneInvoiceForAllRooms:=    String(nBooking.ReadString(UTF8String('oneInvoiceForAllRooms')));
              sBooking_seperateExtrasInvoice:=    String(nBooking.ReadString(UTF8String('seperateExtrasInvoice')));
              sBooking_paymentType          :=    String(nBooking.ReadString(UTF8String('paymentType')));
              sBooking_discount             :=    String(nBooking.ReadString(UTF8String('discount')));
              sBooking_currencyCode         :=    String(nBooking.ReadString(UTF8String('currencyCode')));
              sBooking_countryCode          :=    String(nBooking.ReadString(UTF8String('countryCode')));
              sBooking_exchange             :=    String(nBooking.ReadString(UTF8String('exchange')));

              if edOwnerNumber.text <> '' then
              if sBooking_ownerNumber <> edOwnerNumber.text then
              begin
                continue;
              end;

                mBookings.insert;
                mBookings.FieldByName('bookingNumber').AsString :=  sBooking_bookingNumber                    ;
                mBookings.FieldByName('ownerNumber').AsString :=  sBooking_ownerNumber                        ;
                mBookings.FieldByName('bookingTypeCode').AsString :=  sBooking_bookingTypeCode                ;
                mBookings.FieldByName('name').AsString :=  sBooking_name                                      ;
                mBookings.FieldByName('description').AsString :=  sBooking_description                        ;
                mBookings.FieldByName('reference').AsString :=  sBooking_reference                            ;
                mBookings.FieldByName('travelAgentBookingId').AsString :=  sBooking_travelAgentBookingId      ;
                mBookings.FieldByName('dateFrom').AsString :=  sBooking_dateFrom                              ;
                mBookings.FieldByName('dateTo').AsString :=  sBooking_dateTo                                  ;
                mBookings.FieldByName('color').AsString :=  sBooking_color                                    ;
                mBookings.FieldByName('customer').AsString :=  sBooking_customer                              ;
                mBookings.FieldByName('phone').AsString :=  sBooking_phone                                    ;
                mBookings.FieldByName('email').AsString :=  sBooking_email                                    ;
                mBookings.FieldByName('bookingConfirmed').AsString :=  sBooking_bookingConfirmed              ;
                mBookings.FieldByName('confirmationDeadline').AsString :=  sBooking_confirmationDeadline      ;
                mBookings.FieldByName('oneInvoiceForAllRooms').AsString :=  sBooking_oneInvoiceForAllRooms    ;
                mBookings.FieldByName('seperateExtrasInvoice').AsString :=  sBooking_seperateExtrasInvoice    ;
                mBookings.FieldByName('paymentType').AsString :=  sBooking_paymentType                        ;
                mBookings.FieldByName('discount').AsString :=  sBooking_discount                              ;
                mBookings.FieldByName('currencyCode').AsString :=  sBooking_currencyCode                      ;
                mBookings.FieldByName('countryCode').AsString :=  sBooking_countryCode                        ;
                mBookings.FieldByName('exchange').AsString :=  sBooking_exchange                              ;
                mBookings.Post;



              nResourceBookings:= nBooking.Findnode('resourceBookings');
              if assigned(nResourceBookings) then
              begin
                for ii := 0 to nResourceBookings.NodeCount - 1 do
                begin
                  nResourceBooking  := nResourceBookings[ii];
                  if assigned(nResourceBooking) then
                  begin
                    ResourceBooking_dateFrom       := String(nResourceBooking.ReadString(UTF8String('dateFrom')));
                    ResourceBooking_dateTo         := String(nResourceBooking.ReadString(UTF8String('dateTo')));
                    ResourceBooking_resourceGroup  := String(nResourceBooking.ReadString(UTF8String('resourceGroup')));
                    ResourceBooking_color          := String(nResourceBooking.ReadString(UTF8String('color')));
                    ResourceBooking_reserved       := String(nResourceBooking.ReadString(UTF8String('reserved')));
                    ResourceBooking_confirmed      := String(nResourceBooking.ReadString(UTF8String('confirmed')));


                    mResourceBookings.Insert;
                    mResourceBookings.FieldByName('bookingNumber').AsString      :=   mBookings.FieldByName('bookingNumber').AsString        ;
                    mResourceBookings.FieldByName('dateFrom').AsString      :=   ResourceBooking_dateFrom          ;
                    mResourceBookings.FieldByName('dateTo').AsString        :=   ResourceBooking_dateTo            ;
                    mResourceBookings.FieldByName('resourceGroup').AsString :=   ResourceBooking_resourceGroup     ;
                    mResourceBookings.FieldByName('color').AsString         :=   ResourceBooking_color             ;
                    mResourceBookings.FieldByName('reserved').AsString      :=   ResourceBooking_reserved          ;
                    mResourceBookings.FieldByName('confirmed').AsString     :=   ResourceBooking_confirmed         ;
                    mResourceBookings.post;

                    nPrices := nResourceBooking.Findnode('prices');
                    if assigned(nPrices) then
                    begin
                      for iii := 0 to nPrices.NodeCount - 1 do
                      begin
                        nPrice  := nPrices[iii];
                        if assigned(nPrice) then
                        begin
                          Price_priceID     := String(nPrice.ReadString(UTF8String('priceID')));
                          Price_count       := String(nPrice.ReadString(UTF8String('count')));
                          Price_allocated   := String(nPrice.ReadString(UTF8String('allocated')));
                          Price_dateFrom    := String(nPrice.ReadString(UTF8String('dateFrom')));
                          Price_dateTo      := String(nPrice.ReadString(UTF8String('dateTo')));

                          mPrices.insert;
                          mPrices.FieldByName('bookingNumber').AsString :=  mBookings.FieldByName('bookingNumber').AsString        ;
                          mPrices.FieldByName('priceID').AsString       := Price_priceID  ;
                          mPrices.FieldByName('count').AsString         := Price_count    ;
                          mPrices.FieldByName('allocated').AsString     := Price_allocated;
                          mPrices.FieldByName('dateFrom').AsString      := Price_dateFrom ;
                          mPrices.FieldByName('dateTo').AsString        := Price_dateTo   ;
                          mPrices.post;
                        end;
                      end;
                    end;

                    nAllocations := nResourceBooking.Findnode('allocations');
                    if assigned(nAllocations) then
                    begin
                      for iiii := 0 to nAllocations.NodeCount - 1 do
                      begin
                        nAllocation  := nAllocations[iiii];
                        if assigned(nAllocation) then
                        begin
                          nAllocation_dateFrom      := String(nAllocation.ReadString(UTF8String('dateFrom')));
                          nAllocation_dateTo        := String(nAllocation.ReadString(UTF8String('dateTo')));
                          nAllocation_resourceCode  := String(nAllocation.ReadString(UTF8String('resourceCode')));
                          nAllocation_resourceGroup := String(nAllocation.ReadString(UTF8String('resourceGroup')));
                          nAllocation_color         := String(nAllocation.ReadString(UTF8String('color')));
                          nAllocation_priceID       := String(nAllocation.ReadString(UTF8String('priceID')));

                          mAllocations.insert;
                          mAllocations.FieldByName('bookingNumber').AsString  := mBookings.FieldByName('bookingNumber').AsString        ;
                          mAllocations.FieldByName('dateFrom').AsString       := nAllocation_dateFrom     ;
                          mAllocations.FieldByName('dateTo').AsString         := nAllocation_dateTo       ;
                          mAllocations.FieldByName('resourceCode').AsString   := nAllocation_resourceCode ;
                          mAllocations.FieldByName('resourceGroup').AsString  := nAllocation_resourceGroup;
                          mAllocations.FieldByName('color').AsString          := nAllocation_color        ;
                          mAllocations.FieldByName('priceID').AsString        := nAllocation_priceID      ;
                          mAllocations.post;
                        end;
                      end;
                    end;
                  end;
                end;
              end;  //end resourcebookings

              nParticipants:= nBooking.Findnode('Participants');
              if assigned(nParticipants) then
              begin
                for ii := 0 to nParticipants.NodeCount - 1 do
                begin
                  nParticipant  := nParticipants[ii];
                  if assigned(nParticipant) then
                  begin
                    participant_number        := String(nParticipant.ReadString(UTF8String('number')));
                    participant_name          := String(nParticipant.ReadString(UTF8String('name')));
                    participant_countryCode   := String(nParticipant.ReadString(UTF8String('countryCode ')));
                    participant_resourceCode  := String(nParticipant.ReadString(UTF8String('resourceCode')));

                    mParticipants.Insert;
                    mParticipants.FieldByName('bookingNumber').AsString := mBookings.FieldByName('bookingNumber').AsString        ;
                    mParticipants.FieldByName('number').AsString        := participant_number;
                    mParticipants.FieldByName('name').AsString          := participant_name;
                    mParticipants.FieldByName('countryCode').AsString   := participant_countryCode;
                    mParticipants.FieldByName('resourceCode').AsString  := participant_resourceCode;
                    mParticipants.post;
                  end;
                end;
              end;


              nBookingSaleLines:= nBooking.Findnode('bookingSaleLines');
              if assigned(nBookingSaleLines) then
              begin
                for ii := 0 to nBookingSaleLines.NodeCount - 1 do
                begin
                  nBookingSaleLine  := nBookingSaleLines[ii];
                  if assigned(nBookingSaleLine) then
                  begin
                    BookingSaleLine_currencyCode             := String(nBookingSaleLine.ReadString(UTF8String('currencyCode')));
                    BookingSaleLine_exchange                 := String(nBookingSaleLine.ReadString(UTF8String('exchange')));
                    BookingSaleLine_itemCode                 := String(nBookingSaleLine.ReadString(UTF8String('itemCode')));
                    BookingSaleLine_resourceCode             := String(nBookingSaleLine.ReadString(UTF8String('resourceCode')));
                    BookingSaleLine_salesPerson              := String(nBookingSaleLine.ReadString(UTF8String('salesPerson')));
                    BookingSaleLine_customer                 := String(nBookingSaleLine.ReadString(UTF8String('customer')));
                    BookingSaleLine_resourceGroup            := String(nBookingSaleLine.ReadString(UTF8String('resourceGroup')));
                    BookingSaleLine_priceID                  := String(nBookingSaleLine.ReadString(UTF8String('priceID')));
                    BookingSaleLine_quantity                 := String(nBookingSaleLine.ReadString(UTF8String('quantity')));
                    BookingSaleLine_includedInPrice          := String(nBookingSaleLine.ReadString(UTF8String('includedInPrice')));
                    BookingSaleLine_dateFrom                 := String(nBookingSaleLine.ReadString(UTF8String('dateFrom')));
                    BookingSaleLine_dateTo                   := String(nBookingSaleLine.ReadString(UTF8String('dateTo')));
                    BookingSaleLine_addTime                  := String(nBookingSaleLine.ReadString(UTF8String('addTime')));
                    BookingSaleLine_itemPrice                := String(nBookingSaleLine.ReadString(UTF8String('itemPrice')));
                    BookingSaleLine_itemDiscount             := String(nBookingSaleLine.ReadString(UTF8String('itemDiscount')));
                    BookingSaleLine_itemDiscountPercent      := String(nBookingSaleLine.ReadString(UTF8String('itemDiscountPercent')));
                    BookingSaleLine_itemPriceWithTax         := String(nBookingSaleLine.ReadString(UTF8String('itemPriceWithTax')));
                    BookingSaleLine_itemDiscountWithTax      := String(nBookingSaleLine.ReadString(UTF8String('itemDiscountWithTax')));
                    BookingSaleLine_itemDescription          := String(nBookingSaleLine.ReadString(UTF8String('itemDescription')));
                    BookingSaleLine_invoiceStatus            := String(nBookingSaleLine.ReadString(UTF8String('invoiceStatus')));
                    BookingSaleLine_soHeadRecId              := String(nBookingSaleLine.ReadString(UTF8String('soHeadRecId')));
                    BookingSaleLine_itemPriceForeign         := String(nBookingSaleLine.ReadString(UTF8String('itemPriceForeign')));
                    BookingSaleLine_itemPriceForeignWithTax  := String(nBookingSaleLine.ReadString(UTF8String('itemPriceForeignWithTax')));

                    mBookingSaleLines.Insert;
                    mBookingSaleLines.FieldByName('bookingNumber').AsString           := mBookings.FieldByName('bookingNumber').AsString        ;
                    mBookingSaleLines.FieldByName('currencyCode').AsString            :=  BookingSaleLine_currencyCode           ;
                    mBookingSaleLines.FieldByName('exchange').AsString                :=  BookingSaleLine_exchange               ;
                    mBookingSaleLines.FieldByName('itemCode').AsString                :=  BookingSaleLine_itemCode               ;
                    mBookingSaleLines.FieldByName('resourceCode').AsString            :=  BookingSaleLine_resourceCode           ;
                    mBookingSaleLines.FieldByName('salesPerson').AsString             :=  BookingSaleLine_salesPerson            ;
                    mBookingSaleLines.FieldByName('customer').AsString                :=  BookingSaleLine_customer               ;
                    mBookingSaleLines.FieldByName('resourceGroup').AsString           :=  BookingSaleLine_resourceGroup          ;
                    mBookingSaleLines.FieldByName('priceID').AsString                 :=  BookingSaleLine_priceID                ;
                    mBookingSaleLines.FieldByName('quantity').AsString                :=  BookingSaleLine_quantity               ;
                    mBookingSaleLines.FieldByName('includedInPrice').AsString         :=  BookingSaleLine_includedInPrice        ;
                    mBookingSaleLines.FieldByName('dateFrom').AsString                :=  BookingSaleLine_dateFrom               ;
                    mBookingSaleLines.FieldByName('dateTo').AsString                  :=  BookingSaleLine_dateTo                 ;
                    mBookingSaleLines.FieldByName('addTime').AsString                 :=  BookingSaleLine_addTime                ;
                    mBookingSaleLines.FieldByName('itemPrice').AsString               :=  BookingSaleLine_itemPrice              ;
                    mBookingSaleLines.FieldByName('itemDiscount').AsString            :=  BookingSaleLine_itemDiscount           ;
                    mBookingSaleLines.FieldByName('itemDiscountPercent').AsString     :=  BookingSaleLine_itemDiscountPercent    ;
                    mBookingSaleLines.FieldByName('itemPriceWithTax').AsString        :=  BookingSaleLine_itemPriceWithTax       ;
                    mBookingSaleLines.FieldByName('itemDiscountWithTax').AsString     :=  BookingSaleLine_itemDiscountWithTax    ;
                    mBookingSaleLines.FieldByName('itemDescription').AsString         :=  BookingSaleLine_itemDescription        ;
                    mBookingSaleLines.FieldByName('invoiceStatus').AsString           :=  BookingSaleLine_invoiceStatus          ;
                    mBookingSaleLines.FieldByName('soHeadRecId').AsString             :=  BookingSaleLine_soHeadRecId            ;
                    mBookingSaleLines.FieldByName('itemPriceForeign').AsString        :=  BookingSaleLine_itemPriceForeign       ;
                    mBookingSaleLines.FieldByName('itemPriceForeignWithTax').AsString :=  BookingSaleLine_itemPriceForeignWithTax;
                    mBookingSaleLines.post;
                  end;
                end;
              end;

              nMemos:= nBooking.Findnode('Memos');
              if assigned(nMemos) then
              begin
                for ii := 0 to nMemos.NodeCount - 1 do
                begin
                  nMemo  := nMemos[ii];
                  if assigned(nMemo) then
                  begin
                    memo_memoText  := String(nMemo.ReadString(UTF8String('memoText')));
                    memo_memoName  := String(nMemo.ReadString(UTF8String('memoName')));
                    memo_miscId    := String(nMemo.ReadString(UTF8String('miscId')));
                    memo_pageId    := String(nMemo.ReadString(UTF8String('pageId')));

                    mMemos.Insert;
                    mMemos.FieldByName('bookingNumber').AsString  := mBookings.FieldByName('bookingNumber').AsString        ;
                    mMemos.FieldByName('memoText').AsString       := memo_memoText ;
                    mMemos.FieldByName('memoName').AsString       := memo_memoName ;
                    mMemos.FieldByName('miscId').AsString         := memo_miscId   ;
                    mMemos.FieldByName('pageId').AsString         := memo_pageId   ;
                    mMemos.Insert;

                  end;
                end;
              end;
            end;

          end;
        end;
      finally
        freeandnil(aDoc);
      end;
    finally
      mBookings.EnableControls;
      mResourceBookings.EnableControls;
      mPrices.EnableControls;
      mAllocations.EnableControls;
      mParticipants.EnableControls;
      mBookingSaleLines.EnableControls;
      mMemos.EnableControls;
      zDKIsReading := false;
      CheckBox1.Checked := true;

    end;
  end;
end;




procedure TfrmTestData.DBEdit1Change(Sender: TObject);
var
  s : string;
begin
  if not zDKisReading then
  begin
    s := quotedstr(DBEdit1.Text);
    mResourceBookings.Filter := '(bookingNumber='+s+')';
    mResourceBookings.Filtered := true;

    mPrices.Filter := '(bookingNumber='+s+')';
    mPrices.Filtered := true;

    mAllocations.Filter := '(bookingNumber='+s+')';
    mAllocations.Filtered := true;

    mParticipants.Filter := '(bookingNumber='+s+')';
    mParticipants.Filtered := true;

    mBookingSaleLines.Filter := '(bookingNumber='+s+')';
    mBookingSaleLines.Filtered := true;

    mBookingSaleLines.Filter := '(bookingNumber='+s+')';
    mBookingSaleLines.Filtered := true;

    mMemos.Filter := '(bookingNumber='+s+')';
    mMemos.Filtered := true;
  end;
end;


procedure TfrmTestData.edXMLFileAfterDialog(Sender: TObject; var Name: string;
  var Action: Boolean);
begin
  zDKXMLFileName := Name;
  Caption := zDKXMLFileName;
  zDkDataPath := extractFilePath(zDKXMLFileName);
  memXMLFile.Lines.LoadFromFile(zDKXMLFileName);
end;



procedure TfrmTestData.btnGetImportRoomsClick(Sender: TObject);
var
  room : string;
  roomType : string;
begin
  screen.Cursor := crHourGlass;
  mAllocations.DisableControls;
  mRooms.DisableControls;
  try
    mAllocations.First;
    while not mAllocations.eof do
    begin
      room := mAllocations.fieldbyname('resourceCode').asstring;
      roomtype := mAllocations.fieldbyname('resourceGroup').asstring;


      if mRooms.Locate('Room',Room,[])  then
      begin
        if mRooms.FieldByName('Room').AsString <> '' then
        begin
          mRooms.Edit;
          mRooms.FieldByName('impRoom').AsString := Room;
          mRooms.FieldByName('impRoomType').AsString := Roomtype;
          mRooms.Post;
        end else
        begin
        end;
      end else
      begin
        if not mRooms.Locate('impRoom',Room,[])  then
        begin
          mRooms.Append;
          mRooms.FieldByName('impRoom').AsString := Room;
          mRooms.FieldByName('impRoomType').AsString := Roomtype;
          mRooms.Post;
        end;
      end;
      mAllocations.next;
    end;
  finally
    mAllocations.enableControls;
    mRooms.enableControls;
    screen.Cursor := crDefault;
  end;
end;

procedure TfrmTestData.btnGetRoomerRoomsClick(Sender: TObject);
var
  s : string;
  rSet : TRoomerDataset;

begin
  //
  s := '';
  s := 'Select Room, Description, roomType from rooms order by room';

  rSet := CreateNewDataSet;
  try
    if rSet_bySQL(rSet,s) then
    begin
      if mRooms.active then mRooms.Close;
      mRooms.LoadFromDataSet(rSet,[]);
    end;
  finally
    freeandnil(rSet);
  end;
end;

procedure TfrmTestData.btnSaveToCSVClick(Sender: TObject);
var
  filename : string;
begin
  filename := zdkDataPath+'rooms.dat';
  mRooms.SaveToFile(filename);  //
end;



procedure TfrmTestData.btnLoadFromCSVClick(Sender: TObject);
var
  Filename : string;
begin
  filename := zdkDataPath+'rooms.dat';
  if fileexists(filename) then
  begin
    mRooms.LoadFromFile(filename);
  end;
end;


procedure TfrmTestData.ApplyFilter;
var
  s : string;
begin
  if CheckBox1.Checked then
  begin
    s := quotedstr(DBEdit1.Text);
    mResourceBookings.Filter := '(bookingNumber='+s+')';
    mResourceBookings.Filtered := true;

    mPrices.Filter := '(bookingNumber='+s+')';
    mPrices.Filtered := true;

    mAllocations.Filter := '(bookingNumber='+s+')';
    mAllocations.Filtered := true;

    mParticipants.Filter := '(bookingNumber='+s+')';
    mParticipants.Filtered := true;

    mBookingSaleLines.Filter := '(bookingNumber='+s+')';
    mBookingSaleLines.Filtered := true;

    mBookingSaleLines.Filter := '(bookingNumber='+s+')';
    mBookingSaleLines.Filtered := true;

    mMemos.Filter := '(bookingNumber='+s+')';
    mMemos.Filtered := true;
  end;
end;


procedure TfrmTestData.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    applyFilter;
  end else
  begin
    clearfilter;
  end;
end;

procedure TfrmTestData.ClearFilter;
var
  s : string;
begin
    mResourceBookings.Filter := '';
    mResourceBookings.Filtered := false;

    mPrices.Filter := '';
    mPrices.Filtered := false;

    mAllocations.Filter := '';
    mAllocations.Filtered := false;

    mParticipants.Filter := '';
    mParticipants.Filtered := false;

    mBookingSaleLines.Filter := '';
    mBookingSaleLines.Filtered := false;

    mBookingSaleLines.Filter := '';
    mBookingSaleLines.Filtered := false;

    mMemos.Filter := '';
    mMemos.Filtered := true;
end;

procedure TfrmTestData.CustomerCSVAfterDialog(Sender: TObject; var Name: string;
  var Action: Boolean);
var
   lstCustomers : TStringList;
   lstLine : Tstrings;
   sFileName : string;
   i : integer;
   s : string;
begin
  //**
  if mCustomers.Active then mCustomers.Close;
  mCustomers.open;

  mCustomers.DisableControls;
  try
    lstCustomers := Tstringlist.Create;
    try
      //Númer;Heiti;Heimili;Póstnúmer;Staður;Land;Kennitala;Flokkur;Sími 1;Greiðslumáti;Netfang
      sFilename := name;
      if fileexists(sFilename) then
      begin
        lstCustomers.LoadFromFile(sFileName);
        for i := 0 to lstCustomers.count-1 do
        begin
          s := lstCustomers[i];
          lstLine := SplitStringToTStrings(';', S);
          try
            if lstLine.Count = 11 then
            begin
              mCustomers.Append;
              mCustomers['numer']       := UTF8String(lstLine[0]);
              mCustomers['heiti']       := UTF8String(lstLine[1]);
              mCustomers['heimili']     := UTF8String(lstLine[2]);
              mCustomers['postnumer']   := UTF8String(lstLine[3]);
              mCustomers['stadur']      := UTF8String(lstLine[4]);
              mCustomers['land']        := UTF8String(lstLine[5]);
              mCustomers['kennitala']   := UTF8String(lstLine[6]);
              mCustomers['flokkur']     := UTF8String(lstLine[7]);
              mCustomers['simi']        := UTF8String(lstLine[8]);
              mCustomers['greidslumati']:= UTF8String(lstLine[9]);
              mCustomers['netfang']     := UTF8String(lstLine[10]);
              mCustomers.Post;
            end;
          finally
            lstLine.Free;
          end;
        end;
      end;
      mCustomers.First;
    finally
      freeandnil(lstCustomers);
    end;
  finally
    mCustomers.EnableControls;
  end;
end;

procedure TfrmTestData.btnToExcelClick(Sender: TObject);
var
  sFilename : string;
  s         : string;
  memoFile : TextFile;
  atext : string;


begin
  screen.cursor := crHourglass;
  try
    dateTimeToString(s, 'yyyymmddhhnn', now);

    sFilename := zdkdataPath + s + '_dkBookings';
    ExportGridToExcel(sFilename, grBookings, true, true, true);

    sFilename := zdkdataPath + s + '_dkResourceBookings';
    ExportGridToExcel(sFilename, grResourceBookings, true, true, true);

    sFilename := zdkdataPath + s + '_dkParticipant';
    ExportGridToExcel(sFilename, grParticipant, true, true, true);

    sFilename := zdkdataPath + s + '_dkBookingSaleLines';
    ExportGridToExcel(sFilename, grBookingSaleLines, true, true, true);

    sFilename := zdkdataPath + s + '_dkPrices';
    ExportGridToExcel(sFilename, grPrices, true, true, true);

    sFilename := zdkdataPath + s + '_dkAllocations';
    ExportGridToExcel(sFilename, grAllocations, true, true, true);

    sFilename := zdkdataPath + s + '_dkAllocations';
    ExportGridToExcel(sFilename, grAllocations, true, true, true);

    sFilename := zdkdataPath + s + '_dkMemos.txt';

    System.AssignFile(memoFile, sFilename);
    System.Rewrite(memoFile);

    mMemos.first;
    while not mMemos.eof do
    begin
      aText := '------------------------------------------------';
      WriteLn(memofile,atext);
      aText := 'BookingNumber : '+mMemos.fieldbyname('bookingNumber').asstring;
      WriteLn(memofile,atext);
      aText := mMemos.fieldbyname('memoText').asstring;
      WriteLn(memofile,atext);
      mMemos.Next;
    end;
    System.CloseFile(memoFile);
  finally
    screen.cursor := crDefault;
  end;
end;


procedure TfrmTestData.Button1Click(Sender: TObject);
var
  filename : string;
begin
  filename := zdkDataPath+'customers.dat';
  mCustomers.SaveToFile(filename);  //
end;

procedure TfrmTestData.Button2Click(Sender: TObject);
var
  filename : string;
begin
  filename := zdkDataPath+'customers.dat';
  if fileexists(filename) then
  begin
    if mCustomers.active then mCustomers.Close;
    mCustomers.open;
    mCustomers.loadFromFile(filename);  //
  end else
  begin
    Showmessage('File not Found : '+fileName);
  end;
end;

procedure TfrmTestData.Button3Click(Sender: TObject);
begin
   if mCustomers.active then mCustomers.Close;
   mCustomers.open;
end;

procedure TfrmTestData.Button4Click(Sender: TObject);
var
 zData   : recCustomerHolder;
 newID   : integer;

 defPcCode : string;
 defCustomerType : string;
 DefCurrency   : string;

begin

  defPcCode       := edDefPcCode.text      ;
  defCustomerType := edDefCustomerType.text;
  DefCurrency     := edDefCurrency.text    ;

  newID := 0;

  ProgressBar1.Position := 0;
  ProgressBar1.Max := mCustomers.RecordCount;

  mCustomers.First;
  while not mCustomers.Eof do
  begin
    ProgressBar1.stepIt;
    if not CustomerExist(mCustomers['numer']) then
    begin
      initCustomerHolder(zData);
      zData.Active                   :=  true;
      zData.Customer                 :=  mCustomers['numer'] ;
      zData.Surname                  :=  mCustomers['heiti'] ;
      zData.PID                      :=  mCustomers['numer'] ;
      zData.Address1                 :=  mCustomers['heimili'] ;
      zData.Address2                 :=  '' ;
      zData.Address3                 :=  trim(mCustomers['postnumer']+' '+mCustomers['Stadur'])  ;
      zData.Address4                 :=  mCustomers['land'] ;
      zData.Country                  :=  '00';
      zData.Tel1                     :=  mCustomers['simi'] ;
      zData.Tel2                     :=  '' ;
      zData.Fax                      :=  '' ;
      zData.DiscountPercent          :=  0 ;
      zData.EmailAddress             :=  mCustomers['netfang'] ;
      zData.ContactPerson            :=  '' ;
      zData.TravelAgency             :=  false;
      zData.Homepage                 :=  '' ;
      zData.notes                    :=  '' ;
      zData.stayTaxIncluted          :=  true;
      zData.pcID                     :=  PriceCode_ID(defPcCode);
      zData.CustomerType             :=  defCustomerType;
      zData.Currency                 :=  DefCurrency ;


      if INS_Customer(zData,NewID) then
      begin
        mCustomers.Edit;
        mCustomers.FieldByName('id').AsInteger := NewID;
        mCustomers.Post;
      end;
    end;
    mCustomers.Next;
  end;

end;

procedure TfrmTestData.Button5Click(Sender: TObject);
begin
  DkInsertToRoomerSmari;
end;

procedure TfrmTestData.Button6Click(Sender: TObject);

var
  countRB : integer;
  countAL : integer;
  customer : string;

begin
  //
  mBookings.DisableControls;
  mResourcebookings.DisableControls;
  mAllocations.DisableControls;
  mBookingSaleLines.DisableControls;
  mParticipants.DisableControls;
  mPrices.DisableControls;

  ProgressBar1.Max := mBookings.recordcount;
  ProgressBar1.Position := 0;

  try
    mBookings.First;
    while Not mbookings.Eof do
    begin
      ProgressBar1.StepIt;
      countRB := mResourcebookings.RecordCount;
      countAL := mAllocations.RecordCount;

      customer := mbookings.fieldbyname('customer').AsString;

      if not glb.LocateSpecificRecord('customers', 'Customer', Customer) then
      begin
        mBookings.Edit;
        mBookings.fieldbyname('err').AsString := customer;
        mBookings.Post;
      end;

      if CountRB = 0 then
      begin
        mBookings.Edit;
        mBookings.fieldbyname('err').AsString :=  mBookings.fieldbyname('err').AsString+';NoRB';
        mBookings.Post;
      end else
      begin
        if countAL = 0 then
        begin
          mBookings.Edit;
          mBookings.fieldbyname('err').AsString := mBookings.fieldbyname('err').AsString+';NoAL';
          mBookings.Post;
        end;
      end;
      mBookings.Next;
    end;
  finally
    mBookings.enableControls;
    mResourcebookings.enableControls;
    mAllocations.enableControls;
    mBookingSaleLines.enableControls;
    mParticipants.enableControls;
    mPrices.enableControls;
  end;

end;

procedure TfrmTestData.DkInsertToRoomer;
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
  paymentRemarks : string;


  dkCustomer : string;
  dkCustFound : boolean;
  bookingnumber : string;

  CustomerName : string;

  numberOfRooms    : integer;
  TotalNumberOfRooms : integer;

  TotalAllocated : integer;
  TotalGuestCount : integer;
  GuestsPerRoom : integer;
  GuestMod : integer;
  sNow : string;
  iii : integer;
begin
  //**
  zFirstTime := true;
  try
    ProgressBar1.Max := mBookings.recordcount;
    ProgressBar1.Position := 0;

    mBookings.First;
    oo := 0;
    while not mBookings.Eof {and (oo < 20)} do
    begin
      dateTimeTostring(snow,'yyyy-mm-dd hh:nn:ss',now);
      inc(oo);
      ProgressBar1.StepIt;
      try
        paymentInfo := '';
        generalInfo := '';
        aInfantCount     := 0;
        aChildrenCount   := 0;

        dkCustFound := false;

        bookingnumber := trim(mBookings.FieldByName('bookingnumber').AsString);
        dkCustomer := trim(mBookings.FieldByName('Customer').AsString);

        try
          oNewReservation := TNewReservation.Create(g.qHotelCode,g.qUser);
        Except
        end;


        if glb.LocateSpecificRecord('customers', 'Customer', DkCustomer) then
        begin
          dkCustFound := true;
        end;

        if mResourcebookings.RecordCount = 0 then
        begin
          mBookings.edit;
          mBookings.FieldByName('err').AsString := mBookings.FieldByName('err').AsString+';No Resourcebookings ';
          mBookings.post;
          mBookings.next;
          continue;
        end;

        if not dkCustFound then
        begin
          mBookings.edit;
          mBookings.FieldByName('err').AsString := mBookings.FieldByName('err').AsString+';notFound : '+dkCustomer;
          mBookings.post;
          mBookings.next;
          continue;
        end;


        refr := '';
        contactName := trim(mBookings.FieldByName('name').AsString);
        refr := trim(mBookings.FieldByName('description').AsString);
        if trim(mBookings.FieldByName('travelAgentBookingId').AsString) <> '' then
        begin
          if refr <> '' then refr := refr +' : ';
          refr := refr + trim(mBookings.FieldByName('travelAgentBookingId').AsString)
        end;

        mainGuest := '';
        mParticipants.last;
        if not mParticipants.bof then
        begin
          mainGuest := mParticipants.FieldByName('Name').AsString;
        end;

        CountryCode  := trim(mBookings.fieldbyname('countryCode').AsString);
        Currency     := trim(mBookings.fieldbyname('CurrencyCode').AsString);
        contactTel   := trim(mBookings.fieldbyname('phone').AsString);
        contactEmail := trim(mBookings.fieldbyname('email').AsString);


        oNewReservation.resMedhod := rmNormal;
        oNewReservation.IsQuick   := true;
        oNewReservation.HomeCustomer.Customer_update(customer);
        oNewReservation.HomeCustomer.IsGroupInvoice    := False;

        oNewReservation.HomeCustomer.ShowDiscountOnInvoice  := false;
        oNewReservation.HomeCustomer.isRoomResDiscountPrec  := True;
        oNewReservation.HomeCustomer.RoomResDiscount        := 0;

        oNewReservation.HomeCustomer.Customer               := dkCustomer;
        oNewReservation.HomeCustomer.CustomerName           := glb.CustomersSet['surname'];
        oNewReservation.HomeCustomer.GuestName              := mainGuest;
        oNewReservation.HomeCustomer.invRefrence            := refr;
        oNewReservation.HomeCustomer.Country                := countryCode;
        oNewReservation.HomeCustomer.ReservationName        := glb.CustomersSet['surname'];
        oNewReservation.HomeCustomer.RoomStatus             := 'P';
        oNewReservation.HomeCustomer.IsGroupInvoice         := False;
        oNewReservation.HomeCustomer.Currency               := currency;
        oNewReservation.HomeCustomer.ContactPerson          := contactName;
        oNewReservation.HomeCustomer.ContactPhone           := contactTel;
        oNewReservation.HomeCustomer.ContactEmail           := contactEmail;
        oNewReservation.HomeCustomer.ContactAddress1        := '';
        oNewReservation.HomeCustomer.ContactAddress2        := '';
        oNewReservation.HomeCustomer.ContactAddress3        := bookingnumber;
        oNewReservation.HomeCustomer.ContactAddress4        := '';



        mMemos.First;
        if not mMemos.eof then
        begin
          paymentremarks := mMemos.FieldByName('memoText').AsString;
        end;

        remarks := snow;
        if trim(remarks) <>'' then
            generalinfo := generalinfo+'<imported> '+remarks;

        if trim(paymentremarks) <>'' then
            Paymentinfo := Paymentinfo+#10+'---------'+#10+paymentremarks;

        TotalGuestCount := mParticipants.RecordCount;

        i := 0;
        mResourceBookings.first;
        TotalNumberOfRooms := 0;
        TotalAllocated := mAllocations.RecordCount;
        while not mResourceBookings.eof do
        begin
          try
            numberOfRooms := strtoint(mResourceBookings.FieldByName('reserved').asstring);
          Except
            numberOfRooms := 0;
          end;
          totalNumberOfRooms := totalNumberOfRooms+numberOfRooms;
          mResourceBookings.next
        end;


       GuestsPerRoom := 0;
       GuestMod      := 0;

        if totalNumberOfRooms <> 0 then
        begin
          GuestsPerRoom := TotalGuestCount div totalNumberOfRooms;
          GuestMod := TotalGuestCount MOD totalNumberOfRooms;
        end;

        generalinfo := generalinfo+#10+'<TotalGuestCount> '+inttostr(TotalGuestCount) ;
        if mBookingSaleLines.RecordCount > 0 then
        begin
          generalinfo := generalinfo+#10+'-----------------';
          mBookingSaleLines.first;
          while not mBookingSaleLines.eof do
          begin
            generalinfo := generalinfo+#10+'<SaleLine-number> '+mBookingSaleLines.fieldbyname('soHeadRecId').asstring; ;
            generalinfo := generalinfo+#10+'<SaleLine-Code> '+mBookingSaleLines.fieldbyname('ItemCode').asstring; ;
            generalinfo := generalinfo+#10+'<SaleLine-Amount> '+mBookingSaleLines.fieldbyname('itemPriceForeignWithTax').asstring; ;
            mBookingSaleLines.next
          end;
          generalinfo := generalinfo+#10+'-----------------';
        end;



        if TotalAllocated <> totalNumberOfRooms then
        begin
          mBookings.edit;
          mBookings.FieldByName('err').AsString := mBookings.FieldByName('err').AsString+';No Room ';
          mBookings.post;
          mResourcebookings.First;
          iii := 0;
          while not mResourcebookings.eof do
          begin
            inc(iii);
            //Create NoRooms
            aroom := '';
            roomType := mResourcebookings.FieldByName('resourceGroup').asstring;
            roomInfo := '';
            roomInfo := roomInfo+'<Bookingnumber> '+bookingNumber;

            inc(i);

            fs.DateSeparator := '.';
            fs.ShortDateFormat := 'dd.mm.yyyy';
            sTmp :=  mResourcebookings.fieldbyname('dateFrom').asstring;
            Arrival := strToDateTime(sTmp,fs);

            fs.ShortDateFormat := 'dd-mm-yyyy';
            sTmp := mResourcebookings.FieldByName('dateto').asString;
            Departure       := strToDateTime(sTmp,fs);

  //        sTmp := KbmRoomRes.FieldByName('NumberOfPersons').AsString;


            try
              if totalNumberOfRooms = 1 then
              begin
                GuestCount := TotalGuestCount
              end else
              begin
                GuestCount := GuestsPerRoom;
                if (GuestMod <> 0) and (totalNumberOfRooms=iii) then
                begin
                  GuestCount := GuestCount+1
                end;
              end;
            except
            end;
            roomreservation := RR_SetNewID();
            try
              AvragePrice := 1;
            Except
              AvragePrice := 1;
            end;

            AvrageDiscount  := 0;
            RateCount       := 1;
            ChildrenCount   := 0;
            infantCount     := 0;
            PriceCode       := 'RACK';
            isPercentage    := False;
            mainGuestName   := mainGuest;
            if trim(mainGuestName) = '' then mainGuestName := contactName;
            if trim(mainGuestName) = '-' then mainGuestName :=contactName;

            mainGuestName := copy(mainGuestName,1,100);


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
              mResourcebookings.Next;

             oNewReservation.HomeCustomer.ReservationPaymentInfo := paymentinfo;
             oNewReservation.HomeCustomer.ReservationGeneralInfo := generalInfo;
          end;
          screen.Cursor := crHourGlass;
          try
            oNewReservation.CreateReservation;
          finally
            screen.Cursor := crDefault;
          end;
        end else
        begin
          iii := 0;
          while not mAllocations.eof do
          begin
            inc(iii);
            aroom     := mAllocations.FieldByName('resourceCode').asstring;
            roomType  := mAllocations.FieldByName('resourceGroup').asstring;

            roomInfo := '';
            roomInfo := roomInfo+'<Bookingnumber> '+bookingNumber;
            roomInfo := roomInfo+#10+'<PriceID> '+mAllocations.FieldByName('PriceID').asstring;;
            inc(i);

            fs.DateSeparator := '.';
            fs.ShortDateFormat := 'dd.mm.yyyy';
            sTmp :=  mAllocations.fieldbyname('dateFrom').asstring;
            Arrival := strToDateTime(sTmp,fs);

            fs.ShortDateFormat := 'dd-mm-yyyy';
            sTmp := mAllocations.FieldByName('dateto').asString;
            Departure       := strToDateTime(sTmp,fs);

  //          sTmp := KbmRoomRes.FieldByName('NumberOfPersons').AsString;
            try
              if totalNumberOfRooms = 1 then
              begin
                GuestCount := TotalGuestCount
              end else
              begin
                GuestCount := GuestsPerRoom;
                if (GuestMod <> 0) and (TotalAllocated=iii) then
                begin
                  GuestCount := GuestCount+1
                end;
              end;
            except
            end;
            roomreservation := RR_SetNewID();
            try
              AvragePrice := 1;
            Except
              AvragePrice := 1;
            end;

            AvrageDiscount  := 0;
            RateCount       := 1;
            ChildrenCount   := 0;
            infantCount     := 0;
            PriceCode       := 'RACK';
            isPercentage    := False;
            mainGuestName   := mainGuest;
            if trim(mainGuestName) = '' then mainGuestName := contactName;
            if trim(mainGuestName) = '-' then mainGuestName :=contactName;

            mainGuestName := copy(mainGuestName,1,100);

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
              rateRoomNumber   := aroom;
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
            mAllocations.Next;

            oNewReservation.HomeCustomer.ReservationPaymentInfo := paymentinfo;
            oNewReservation.HomeCustomer.ReservationGeneralInfo := generalInfo;
          end;

          screen.Cursor := crHourGlass;
          try
            oNewReservation.CreateReservation;
          finally
            screen.Cursor := crDefault;
          end;
        end;
      finally
        freeandnil(oNewReservation);
      end;
      mBookings.next;
    end;
  finally
//    kbmRoomRes.EnableControls;
//    kbmReservations.EnableControls;
//    kbmRoomMap.EnableControls;
    zFirstTime := false;
  end;
end;


procedure TfrmTestData.DkInsertToRoomerSmari;
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
  paymentRemarks : string;


  dkCustomer : string;
  dkCustFound : boolean;
  bookingnumber : string;

  CustomerName : string;

  numberOfRooms    : integer;
  TotalNumberOfRooms : integer;

  TotalAllocated : integer;
  TotalGuestCount : integer;
  GuestsPerRoom : integer;
  GuestMod : integer;
  sNow : string;
  iii : integer;
begin
  //**

  mBookings.DisableControls;
  mResourcebookings.DisableControls;
  mAllocations.DisableControls;
  mBookingSaleLines.DisableControls;
  mParticipants.DisableControls;
  mPrices.DisableControls;

  zFirstTime := true;
  try
    ProgressBar1.Max := mBookings.recordcount;
    ProgressBar1.Position := 0;

    mBookings.First;
    oo := 0;
    while not mBookings.Eof {and (oo < 5)} do
    begin
      dateTimeTostring(snow,'yyyy-mm-dd hh:nn:ss',now);
      inc(oo);
      ProgressBar1.StepIt;
      try
        paymentInfo := '';
        generalInfo := '';
        aInfantCount     := 0;
        aChildrenCount   := 0;

        dkCustFound := false;

        bookingnumber := trim(mBookings.FieldByName('bookingnumber').AsString);
//        showmessage(bookingNumber);

//    quotedstr(

    mResourceBookings.Filter := '(bookingNumber='+quotedstr(bookingnumber)+')';
    mResourceBookings.Filtered := true;

    mPrices.Filter := '(bookingNumber='+quotedstr(bookingnumber)+')';
    mPrices.Filtered := true;

    mAllocations.Filter := '(bookingNumber='+quotedstr(bookingnumber)+')';
    mAllocations.Filtered := true;

    mParticipants.Filter := '(bookingNumber='+quotedstr(bookingnumber)+')';
    mParticipants.Filtered := true;

    mBookingSaleLines.Filter := '(bookingNumber='+quotedstr(bookingnumber)+')';
    mBookingSaleLines.Filtered := true;

    mBookingSaleLines.Filter := '(bookingNumber='+quotedstr(bookingnumber)+')';
    mBookingSaleLines.Filtered := true;

    mMemos.Filter := '(bookingNumber='+quotedstr(bookingnumber)+')';
    mMemos.Filtered := true;

        dkCustomer := trim(mBookings.FieldByName('Customer').AsString);
        try
          oNewReservation := TNewReservation.Create(g.qHotelCode,g.qUser);
        Except
        end;


        if glb.LocateSpecificRecord('customers', 'Customer', DkCustomer) then
        begin
          dkCustFound := true;
        end;

        if mResourcebookings.RecordCount = 0 then
        begin
          mBookings.edit;
          mBookings.FieldByName('err').AsString := mBookings.FieldByName('err').AsString+';No Resourcebookings ';
          mBookings.post;
          mBookings.next;
          continue;
        end;

        if not dkCustFound then
        begin
          mBookings.edit;
          mBookings.FieldByName('err').AsString := mBookings.FieldByName('err').AsString+';notFound : '+dkCustomer;
          mBookings.post;
          mBookings.next;
          continue;
        end;


        refr := '';
        contactName := trim(mBookings.FieldByName('name').AsString);
        refr := trim(mBookings.FieldByName('description').AsString);
        if trim(mBookings.FieldByName('travelAgentBookingId').AsString) <> '' then
        begin
          if refr <> '' then refr := refr +' : ';
          refr := refr + trim(mBookings.FieldByName('travelAgentBookingId').AsString)
        end;

        CountryCode  := trim(mBookings.fieldbyname('countryCode').AsString);
        Currency     := trim(mBookings.fieldbyname('CurrencyCode').AsString);
        contactTel   := trim(mBookings.fieldbyname('phone').AsString);
        contactEmail := trim(mBookings.fieldbyname('email').AsString);


        oNewReservation.resMedhod := rmNormal;
        oNewReservation.IsQuick   := true;
        oNewReservation.HomeCustomer.Customer_update(customer);
        oNewReservation.HomeCustomer.IsGroupInvoice    := False;

        oNewReservation.HomeCustomer.ShowDiscountOnInvoice  := false;
        oNewReservation.HomeCustomer.isRoomResDiscountPrec  := True;
        oNewReservation.HomeCustomer.RoomResDiscount        := 0;

        oNewReservation.HomeCustomer.Customer               := dkCustomer;
        oNewReservation.HomeCustomer.CustomerName           := glb.CustomersSet['surname'];
        oNewReservation.HomeCustomer.GuestName              := mainGuest;
        oNewReservation.HomeCustomer.invRefrence            := refr;
        oNewReservation.HomeCustomer.Country                := countryCode;
        oNewReservation.HomeCustomer.ReservationName        := glb.CustomersSet['surname'];
        oNewReservation.HomeCustomer.RoomStatus             := 'P';
        oNewReservation.HomeCustomer.IsGroupInvoice         := False;
        oNewReservation.HomeCustomer.Currency               := currency;
        oNewReservation.HomeCustomer.ContactPerson          := contactName;
        oNewReservation.HomeCustomer.ContactPhone           := contactTel;
        oNewReservation.HomeCustomer.ContactEmail           := contactEmail;
        oNewReservation.HomeCustomer.ContactAddress1        := '';
        oNewReservation.HomeCustomer.ContactAddress2        := '';
        oNewReservation.HomeCustomer.ContactAddress3        := bookingnumber;
        oNewReservation.HomeCustomer.ContactAddress4        := '';



        mMemos.First;
        if not mMemos.eof then
        begin
          paymentremarks := mMemos.FieldByName('memoText').AsString;
        end;

        remarks := snow;
        if trim(remarks) <>'' then
            generalinfo := generalinfo+'<imported> '+remarks;

        if trim(paymentremarks) <>'' then
            Paymentinfo := Paymentinfo+#10+'---------'+#10+paymentremarks;

        TotalGuestCount := mParticipants.RecordCount;

        i := 0;
        mResourceBookings.first;
        TotalNumberOfRooms := 0;
        TotalAllocated := mAllocations.RecordCount;
        while not mResourceBookings.eof do
        begin
          try
            numberOfRooms := strtoint(mResourceBookings.FieldByName('reserved').asstring);
          Except
            numberOfRooms := 0;
          end;
          totalNumberOfRooms := totalNumberOfRooms+numberOfRooms;
          mResourceBookings.next
        end;


       GuestsPerRoom := 0;
       GuestMod      := 0;

        if totalNumberOfRooms <> 0 then
        begin
          GuestsPerRoom := TotalGuestCount div totalNumberOfRooms;
          GuestMod := TotalGuestCount MOD totalNumberOfRooms;
        end;

        generalinfo := generalinfo+#10+'<TotalGuestCount> '+inttostr(TotalGuestCount) ;
        if mBookingSaleLines.RecordCount > 0 then
        begin
          generalinfo := generalinfo+#10+'-----------------';
          mBookingSaleLines.first;
          while not mBookingSaleLines.eof do
          begin
            generalinfo := generalinfo+#10+'<SaleLine-number> '+mBookingSaleLines.fieldbyname('soHeadRecId').asstring; ;
            generalinfo := generalinfo+#10+'<SaleLine-Code> '+mBookingSaleLines.fieldbyname('ItemCode').asstring; ;
            generalinfo := generalinfo+#10+'<SaleLine-Amount> '+mBookingSaleLines.fieldbyname('itemPriceForeignWithTax').asstring; ;
            mBookingSaleLines.next
          end;
          generalinfo := generalinfo+#10+'-----------------';
        end;



        if TotalAllocated <> totalNumberOfRooms then
        begin
          mBookings.edit;
          mBookings.FieldByName('err').AsString := mBookings.FieldByName('err').AsString+';No Room ';
          mBookings.post;
        end else
        begin
          mAllocations.first;
          iii := 0;
          while not mAllocations.eof do
          begin
            inc(iii);
            aroom     := mAllocations.FieldByName('resourceCode').asstring;

            if glb.LocateSpecificRecord('rooms', 'room', aRoom) then
            begin
              roomtype := glb.RoomsSet['roomType']
            end else
            begin
              RoomType := 'NA';
              aroom := '';
            end;


//            roomType  := mAllocations.FieldByName('resourceGroup').asstring;

            roomInfo := '';
            roomInfo := roomInfo+'<Bookingnumber> '+bookingNumber;
            roomInfo := roomInfo+#10+'<PriceID> '+mAllocations.FieldByName('PriceID').asstring;;
            inc(i);

            fs.DateSeparator := '.';
            fs.ShortDateFormat := 'dd.mm.yyyy';
            sTmp :=  mAllocations.fieldbyname('dateFrom').asstring;
            Arrival := strToDateTime(sTmp,fs);

            fs.ShortDateFormat := 'dd-mm-yyyy';
            sTmp := mAllocations.FieldByName('dateto').asString;
            Departure       := strToDateTime(sTmp,fs);

            try
              if totalNumberOfRooms = 1 then
              begin
                GuestCount := TotalGuestCount
              end else
              begin
                GuestCount := 0;
                mParticipants.First;
                while not mParticipants.eof do
                begin
                  if mParticipants.FieldByName('resourceCode').asstring = aroom then
                  begin
                    inc(GuestCount);
                  end;
                  mParticipants.next
                end;
                if guestCount = 0 then GuestCount := 1;
              end;
            except
            end;
            roomreservation := RR_SetNewID();
            try
              AvragePrice := 1;
            Except
              AvragePrice := 1;
            end;

            AvrageDiscount  := 0;
            RateCount       := 1;
            ChildrenCount   := 0;
            infantCount     := 0;
            PriceCode       := 'RACK';
            isPercentage    := False;
            mainGuestName   := contactName;
            if trim(mainGuestName) = '' then mainGuestName := contactName;
            if trim(mainGuestName) = '-' then mainGuestName :=contactName;

            mainGuestName := copy(mainGuestName,1,100);

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
              rateRoomNumber   := aroom;
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
            mAllocations.Next;

            oNewReservation.HomeCustomer.ReservationPaymentInfo := paymentinfo;
            oNewReservation.HomeCustomer.ReservationGeneralInfo := generalInfo;
          end;

          screen.Cursor := crHourGlass;
          try
            oNewReservation.CreateReservation;
          finally
            screen.Cursor := crDefault;
          end;
        end;

      finally
        freeandnil(oNewReservation);
      end;
      mBookings.next;
    end;
  finally
  mBookings.EnableControls;
  mResourcebookings.EnableControls;
  mAllocations.EnableControls;
  mBookingSaleLines.EnableControls;
  mParticipants.EnableControls;
  mPrices.EnableControls;

//    kbmRoomRes.EnableControls;
//    kbmReservations.EnableControls;
//    kbmRoomMap.EnableControls;
    zFirstTime := false;
  end;
end;



end.

CREATE TABLE `invoiceheads` (
  `Reservation` int(11) DEFAULT '0',
  `RoomReservation` int(11) DEFAULT '0',
  `SplitNumber` int(11) DEFAULT '0',
  `InvoiceNumber` int(11) DEFAULT '0',
  `InvoiceDate` varchar(10) DEFAULT '',
  `Customer` varchar(15) DEFAULT '',
  `Name` varchar(100) DEFAULT '',
  `Address1` varchar(100) DEFAULT '',
  `Address2` varchar(100) DEFAULT '',
  `Address3` varchar(100) DEFAULT '',
  `Address4` varchar(100) DEFAULT '',
  `Country` varchar(2) DEFAULT '',
  `Total` double DEFAULT '0',
  `TotalWOVAT` double DEFAULT '0',
  `TotalVAT` double DEFAULT '0',
  `TotalBreakFast` double DEFAULT '0',
  `ExtraText` longtext,
  `Finished` tinyint(1) NOT NULL DEFAULT '0',
  `ReportDate` varchar(10) DEFAULT '',
  `ReportTime` varchar(5) DEFAULT '',
  `CreditInvoice` int(11) DEFAULT '0',
  `OriginalInvoice` int(11) DEFAULT '0',
  `InvoiceType` int(11) DEFAULT '0',
  `ihTmp` char(3) DEFAULT '',
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `custPID` varchar(15) DEFAULT '',
  `RoomGuest` varchar(100) DEFAULT '',
  `ihDate` datetime DEFAULT NULL,
  `ihStaff` varchar(11) DEFAULT NULL,
  `ihPayDate` datetime DEFAULT NULL,
  `ihConfirmDate` datetime DEFAULT NULL,
  `ihInvoiceDate` datetime DEFAULT NULL,
  `ihCurrency` varchar(5) DEFAULT '',
  `ihCurrencyRate` double DEFAULT '0',
  `invRefrence` varchar(100) DEFAULT '',
  `TotalStayTax` double DEFAULT '0',
  `TotalStayTaxNights` int(11) DEFAULT '0',
  `showPackage` tinyint(1) DEFAULT '0',
  `staff` varchar(5) DEFAULT NULL,
  `location` varchar(10) DEFAULT NULL,
  `externalInvoiceId` int(11) DEFAULT NULL,
  `InvoiceFinalized` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `InvoiceHeads_IX_InvoiceHeadsID` (`ID`),
  KEY `InvoiceHeads_IX_IhInvoiceDate` (`ihInvoiceDate`),
  KEY `InvoiceHeads_IX_InvoiceDate` (`InvoiceDate`),
  KEY `IX_InvoiceHeads_confirmdate` (`ihConfirmDate`),
  KEY `IX_InvoiceHeads_Num_Res` (`InvoiceNumber`,`RoomReservation`),
  KEY `IX_InvoiceHeads_number_date` (`InvoiceNumber`,`InvoiceDate`),
  KEY `InvoiceHeads_IX_InvoiceNumber` (`InvoiceNumber`),
  KEY `InvoiceHeads_IX_Res_Roomres` (`Reservation`,`RoomReservation`),
  KEY `InvoiceHeads_ID_RoomRes_Inv` (`RoomReservation`,`InvoiceNumber`),
  KEY `InvoiceHeads_IX_ExternalInvoiceId` (`externalInvoiceId`),
  KEY `InvoiceHeads_IX_InvoiceFinalized` (`InvoiceFinalized`,`InvoiceNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=30940 DEFAULT CHARSET=utf8;





CREATE TABLE `invoiceheads` (                                                      CREATE TABLE `invoiceheads` (
  `Reservation` int(11) DEFAULT '0',                                                 `Reservation` int(11) DEFAULT '0',
  `RoomReservation` int(11) DEFAULT '0',                                             `RoomReservation` int(11) DEFAULT '0',
  `SplitNumber` int(11) DEFAULT '0',                                                 `SplitNumber` int(11) DEFAULT '0',
  `InvoiceNumber` int(11) DEFAULT '0',                                               `InvoiceNumber` int(11) DEFAULT '0',
  `InvoiceDate` varchar(10) DEFAULT '',                                              `InvoiceDate` varchar(10) DEFAULT '',
  `Customer` varchar(15) DEFAULT '',                                                 `Customer` varchar(15) DEFAULT '',
  `Name` varchar(100) DEFAULT '',                                                    `Name` varchar(100) DEFAULT '',
  `Address1` varchar(100) DEFAULT '',                                                `Address1` varchar(100) DEFAULT '',
  `Address2` varchar(100) DEFAULT '',                                                `Address2` varchar(100) DEFAULT '',
  `Address3` varchar(100) DEFAULT '',                                                `Address3` varchar(100) DEFAULT '',
  `Address4` varchar(100) DEFAULT '',                                                `Address4` varchar(100) DEFAULT '',
  `Country` varchar(2) DEFAULT '',                                                   `Country` varchar(2) DEFAULT '',
  `Total` double DEFAULT '0',                                                        `Total` double DEFAULT '0',
  `TotalWOVAT` double DEFAULT '0',                                                   `TotalWOVAT` double DEFAULT '0',
  `TotalVAT` double DEFAULT '0',                                                     `TotalVAT` double DEFAULT '0',
  `TotalBreakFast` double DEFAULT '0',                                               `TotalBreakFast` double DEFAULT '0',
  `ExtraText` longtext,                                                              `ExtraText` longtext,
  `Finished` tinyint(1) NOT NULL DEFAULT '0',                                        `Finished` tinyint(1) NOT NULL DEFAULT '0',
  `ReportDate` varchar(10) DEFAULT '',                                               `ReportDate` varchar(10) DEFAULT '',
  `ReportTime` varchar(5) DEFAULT '',                                                `ReportTime` varchar(5) DEFAULT '',
  `CreditInvoice` int(11) DEFAULT '0',                                               `CreditInvoice` int(11) DEFAULT '0',
  `OriginalInvoice` int(11) DEFAULT '0',                                             `OriginalInvoice` int(11) DEFAULT '0',
  `InvoiceType` int(11) DEFAULT '0',                                                 `InvoiceType` int(11) DEFAULT '0',
  `ihTmp` char(3) DEFAULT '',                                                        `ihTmp` char(3) DEFAULT '',
  `ID` int(11) NOT NULL AUTO_INCREMENT,                                              `ID` int(11) NOT NULL AUTO_INCREMENT,
  `custPID` varchar(15) DEFAULT '',                                                  `custPID` varchar(15) DEFAULT '',
  `RoomGuest` varchar(100) DEFAULT '',                                               `RoomGuest` varchar(100) DEFAULT '',
  `ihDate` datetime DEFAULT NULL,                                                    `ihDate` datetime DEFAULT NULL,
  `ihStaff` varchar(11) DEFAULT NULL,                                                `ihStaff` varchar(11) DEFAULT NULL,
  `ihPayDate` datetime DEFAULT NULL,                                                 `ihPayDate` datetime DEFAULT NULL,
  `ihConfirmDate` datetime DEFAULT NULL,                                             `ihConfirmDate` datetime DEFAULT NULL,
  `ihInvoiceDate` datetime DEFAULT NULL,                                             `ihInvoiceDate` datetime DEFAULT NULL,
  `ihCurrency` varchar(5) DEFAULT '',                                                `ihCurrency` varchar(5) DEFAULT '',
  `ihCurrencyRate` double DEFAULT '0',                                               `ihCurrencyRate` double DEFAULT '0',
  `invRefrence` varchar(100) DEFAULT '',                                             `invRefrence` varchar(100) DEFAULT '',
  `TotalStayTax` double DEFAULT '0',                                                 `TotalStayTax` double DEFAULT '0',
  `TotalStayTaxNights` int(11) DEFAULT '0',                                          `TotalStayTaxNights` int(11) DEFAULT '0',
  `showPackage` tinyint(1) DEFAULT '0',                                              `showPackage` tinyint(1) DEFAULT '0',
  `staff` varchar(5) DEFAULT NULL,                                                   `staff` varchar(5) DEFAULT NULL,
  `location` varchar(10) DEFAULT NULL,                                               `location` varchar(10) DEFAULT NULL,
  `externalInvoiceId` int(11) DEFAULT NULL,                                          `externalInvoiceId` int(11) DEFAULT NULL,
  `InvoiceFinalized` datetime DEFAULT NULL,                                          `InvoiceFinalized` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),                                                                PRIMARY KEY (`ID`),
  UNIQUE KEY `InvoiceHeads_IX_InvoiceHeadsID` (`ID`),                                UNIQUE KEY `InvoiceHeads_IX_InvoiceHeadsID` (`ID`),
  KEY `InvoiceHeads_IX_IhInvoiceDate` (`ihInvoiceDate`),                             KEY `InvoiceHeads_IX_IhInvoiceDate` (`ihInvoiceDate`),
  KEY `InvoiceHeads_IX_InvoiceDate` (`InvoiceDate`),                                 KEY `InvoiceHeads_IX_InvoiceDate` (`InvoiceDate`),
  KEY `IX_InvoiceHeads_confirmdate` (`ihConfirmDate`),                               KEY `IX_InvoiceHeads_confirmdate` (`ihConfirmDate`),
  KEY `IX_InvoiceHeads_Num_Res` (`InvoiceNumber`,`RoomReservation`),                 KEY `IX_InvoiceHeads_Num_Res` (`InvoiceNumber`,`RoomReservation`),
  KEY `IX_InvoiceHeads_number_date` (`InvoiceNumber`,`InvoiceDate`),                 KEY `IX_InvoiceHeads_number_date` (`InvoiceNumber`,`InvoiceDate`),
  KEY `InvoiceHeads_IX_InvoiceNumber` (`InvoiceNumber`),                             KEY `InvoiceHeads_IX_InvoiceNumber` (`InvoiceNumber`),
  KEY `InvoiceHeads_IX_Res_Roomres` (`Reservation`,`RoomReservation`),               KEY `InvoiceHeads_IX_Res_Roomres` (`Reservation`,`RoomReservation`),
  KEY `InvoiceHeads_ID_RoomRes_Inv` (`RoomReservation`,`InvoiceNumber`),             KEY `InvoiceHeads_ID_RoomRes_Inv` (`RoomReservation`,`InvoiceNumber`),
  KEY `InvoiceHeads_IX_ExternalInvoiceId` (`externalInvoiceId`),                     KEY `InvoiceHeads_IX_ExternalInvoiceId` (`externalInvoiceId`),
  KEY `InvoiceHeads_IX_InvoiceFinalized` (`InvoiceFinalized`,`InvoiceNumber`)        KEY `InvoiceHeads_IX_InvoiceFinalized` (`InvoiceFinalized`,`InvoiceNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=15938 DEFAULT CHARSET=utf8;                         ) ENGINE=InnoDB AUTO_INCREMENT=30940 DEFAULT CHARSET=utf8;


CREATE TABLE `invoicelines` (
  `AutoGen` varchar(50) DEFAULT '',
  `Reservation` int(11) DEFAULT '0',
  `RoomReservation` int(11) DEFAULT '0',
  `SplitNumber` int(11) DEFAULT '0',
  `ItemNumber` int(11) DEFAULT '0',
  `PurchaseDate` varchar(10) DEFAULT '',
  `InvoiceNumber` int(11) DEFAULT '0',
  `ItemID` varchar(20) DEFAULT '',
  `Number` double DEFAULT '0',
  `Description` varchar(100) DEFAULT '',
  `Price` double DEFAULT '0',
  `VATType` varchar(10) DEFAULT '',
  `Total` double DEFAULT '0',
  `TotalWOVat` double DEFAULT '0',
  `Vat` double DEFAULT '0',
  `AutoGenerated` tinyint(1) NOT NULL DEFAULT '0',
  `CurrencyRate` double DEFAULT '0',
  `Currency` varchar(5) DEFAULT '',
  `ReportDate` varchar(10) DEFAULT '',
  `ReportTime` varchar(5) DEFAULT '',
  `Persons` int(11) DEFAULT '0',
  `Nights` int(11) DEFAULT '0',
  `BreakfastPrice` double DEFAULT '0',
  `Ayear` int(11) DEFAULT '0',
  `Amon` int(11) DEFAULT '0',
  `Aday` int(11) DEFAULT '0',
  `ilTmp` char(3) DEFAULT '',
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ilAccountKey` varchar(30) DEFAULT '',
  `ItemCurrency` varchar(5) DEFAULT '',
  `ItemCurrencyRate` double DEFAULT '0',
  `Discount` double DEFAULT '0',
  `Discount_isprecent` tinyint(1) DEFAULT '0',
  `ImportRefrence` varchar(100) DEFAULT NULL,
  `ImportSource` varchar(100) DEFAULT NULL,
  `isPackage` tinyint(1) DEFAULT '0',
  `itemAdded` datetime DEFAULT CURRENT_TIMESTAMP,
  `confirmDate` datetime DEFAULT '1900-01-01 00:00:00',
  `confirmAmount` double DEFAULT '0',
  `RoomReservationAlias` int(11) DEFAULT NULL,
  `ItemSource` varchar(15) DEFAULT 'ROOMER' COMMENT 'ROOMER,\n EXTERNAL',
  `InvoiceIndex` int(11) DEFAULT '0',
  `staffCreated` varchar(15) DEFAULT NULL,
  `staffLastEdit` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `InvoiceLines_IX_InvoiceLinesID` (`ID`),
  KEY `InvoiceLines_IX_InvoiceLinesTmp` (`ilTmp`),
  KEY `InvoiceLines_IX_RoomReservation` (`RoomReservation`),
  KEY `InvoiceLines_IX_RoomReservationAndInvoiceNumber` (`RoomReservation`,`InvoiceNumber`),
  KEY `InvoiceLines_IX_RoomResInvNumdPack` (`RoomReservation`,`SplitNumber`,`ItemNumber`,`ImportSource`,`isPackage`),
  KEY `InvoiceLines_IX_RoomResAndPack` (`RoomReservation`,`ImportSource`),
  KEY `InvoiceLines_IX_itemInvoicenumber` (`ItemID`,`InvoiceNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=62232 DEFAULT CHARSET=utf8;


CREATE TABLE `invoicelines` (
  `AutoGen` varchar(50) DEFAULT '',
  `Reservation` int(11) DEFAULT '0',
  `RoomReservation` int(11) DEFAULT '0',
  `SplitNumber` int(11) DEFAULT '0',
  `ItemNumber` int(11) DEFAULT '0',
  `PurchaseDate` varchar(10) DEFAULT '',
  `InvoiceNumber` int(11) DEFAULT '0',
  `ItemID` varchar(20) DEFAULT '',
  `Number` double DEFAULT '0',
  `Description` varchar(100) DEFAULT '',
  `Price` double DEFAULT '0',
  `VATType` varchar(10) DEFAULT '',
  `Total` double DEFAULT '0',
  `TotalWOVat` double DEFAULT '0',
  `Vat` double DEFAULT '0',
  `AutoGenerated` tinyint(1) NOT NULL DEFAULT '0',
  `CurrencyRate` double DEFAULT '0',
  `Currency` varchar(5) DEFAULT '',
  `ReportDate` varchar(10) DEFAULT '',
  `ReportTime` varchar(5) DEFAULT '',
  `Persons` int(11) DEFAULT '0',
  `Nights` int(11) DEFAULT '0',
  `BreakfastPrice` double DEFAULT '0',
  `Ayear` int(11) DEFAULT '0',
  `Amon` int(11) DEFAULT '0',
  `Aday` int(11) DEFAULT '0',
  `ilTmp` char(3) DEFAULT '',
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ilAccountKey` varchar(30) DEFAULT '',
  `ItemCurrency` varchar(5) DEFAULT '',
  `ItemCurrencyRate` double DEFAULT '0',
  `Discount` double DEFAULT '0',
  `Discount_isprecent` tinyint(1) DEFAULT '0',
  `ImportRefrence` varchar(100) DEFAULT NULL,
  `ImportSource` varchar(100) DEFAULT NULL,
  `isPackage` tinyint(1) DEFAULT '0',
  `itemAdded` datetime DEFAULT CURRENT_TIMESTAMP,
  `confirmDate` datetime DEFAULT '1900-01-01 00:00:00',
  `confirmAmount` double DEFAULT '0',
  `RoomReservationAlias` int(11) DEFAULT NULL,
  `ItemSource` varchar(15) DEFAULT 'ROOMER' COMMENT 'ROOMER,\n EXTERNAL',
  `InvoiceIndex` int(11) DEFAULT '0',
  `staffCreated` varchar(15) DEFAULT NULL,
  `staffLastEdit` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `InvoiceLines_IX_InvoiceLinesID` (`ID`),
  KEY `InvoiceLines_IX_InvoiceLinesTmp` (`ilTmp`),
  KEY `InvoiceLines_IX_RoomReservation` (`RoomReservation`),
  KEY `InvoiceLines_IX_RoomReservationAndInvoiceNumber` (`RoomReservation`,`InvoiceNumber`),
  KEY `InvoiceLines_IX_RoomResInvNumdPack` (`RoomReservation`,`SplitNumber`,`ItemNumber`,`ImportSource`,`isPackage`),
  KEY `InvoiceLines_IX_RoomResAndPack` (`RoomReservation`,`ImportSource`),
  KEY `InvoiceLines_IX_itemInvoicenumber` (`ItemID`,`InvoiceNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=62232 DEFAULT CHARSET=utf8;

