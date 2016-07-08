unit uAllotmentToRes;

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
  , Vcl.ExtCtrls
  , Vcl.ComCtrls
  , Vcl.Grids
  , Vcl.StdCtrls
  , Vcl.Buttons

  , Data.DB

  , AdvObj
  , BaseGrid
  , AdvGrid
  , ud
  , _glob
  , ug
  , kbmMemTable
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , uUtils
  , objNewReservation
  , objRoomRates
  , hData
  , uRoomerLanguage
  , uAppGlobal

  , sStatusBar
  , sPanel
  , sSplitter
  , sSpeedButton
  , sEdit
  , sPageControl
  , sLabel
  , sGroupBox


  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , cxStyles
  , dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxButtonEdit, cxSpinEdit, cxTextEdit, cxCalc, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, sCheckBox, sButton, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, AdvUtil
  , uReservationStatusDefinitions
  ;


const
  cCountFixedRows = 2;
  cCountEmptyRows = 1;

  cCountFixedCols = 4;
  cCountEmptyCols = 0;

  cColRoom = 0;
  cColRoomType = 1;
  cColRoomDescription = 2;
  cColInfo = 3;


type
  recColRow = record
    col : integer;
    row : integer;
  end;


TYPE

 TresCell = class
  private
    FrdID              : integer  ;
    FRoomReservation   : integer  ;
    FReservation       : integer  ;
    FdtDate            : Tdate    ;
    FRoom              : string   ;
    FRoomType          : string   ;
    FResFlag           : TReservationStatus   ;
    FisNoRoom          : boolean  ;
    FPriceCode         : string   ;
    FRoomRate          : double   ;
    FDiscount          : double   ;
    FisPercentage      : boolean  ;
    FshowDiscount      : boolean  ;
    FPaid              : boolean  ;
    FCurrency          : string   ;
    FMainGuest         : string   ;
    FnumGuests         : integer  ;
    FnumChildren       : integer  ;
    FnumInfants        : integer  ;
    FRoomCount         : integer ;

  public
    constructor Create(    rdID
                          ,RoomReservation
                          ,Reservation       : integer  ;
                           dtDate            : Tdate    ;
                           Room
                          ,RoomType          : string;
                           ReservationStatus : TReservationStatus   ;
                           isNoRoom          : boolean  ;
                           PriceCode         : string   ;
                           RoomRate
                          ,Discount          : double   ;
                           isPercentage
                          ,showDiscount      : boolean  ;
                           Paid              : boolean  ;
                           Currency
                          ,MainGuest         : string   ;
                           numGuests
                          ,numChildren
                          ,numInfants
                          ,RoomCount         : integer
                      );

    destructor Destroy; override;

    property rdID            : integer  read FrdID             write FrdID            ;
    property RoomReservation : integer  read FRoomReservation  write FRoomReservation ;
    property Reservation     : integer  read FReservation      write FReservation     ;
    property dtDate          : Tdate    read FdtDate           write FdtDate          ;
    property Room            : string   read FRoom             write FRoom            ;
    property RoomType        : string   read FRoomType         write FRoomType        ;
    property ResFlag         : TReservationStatus   read FResFlag          write FResFlag         ;
    property isNoRoom        : boolean  read FisNoRoom         write FisNoRoom        ;
    property PriceCode       : string   read FPriceCode        write FPriceCode       ;
    property RoomRate        : double   read FRoomRate         write FRoomRate        ;
    property Discount        : double   read FDiscount         write FDiscount        ;
    property isPercentage    : boolean  read FisPercentage     write FisPercentage    ;
    property showDiscount    : boolean  read FshowDiscount     write FshowDiscount    ;
    property Paid            : boolean  read FPaid             write FPaid            ;
    property Currency        : string   read FCurrency         write FCurrency        ;
    property MainGuest       : string   read FMainGuest        write FMainGuest       ;
    property numGuests       : integer  read FnumGuests        write FnumGuests       ;
    property numChildren     : integer  read FnumChildren      write FnumChildren     ;
    property numInfants      : integer  read FnumInfants       write FnumInfants      ;
    property RoomCount       : integer  read FRoomCount        write FRoomCount       ;
  end;


TYPE

  RecRRInfoAlot = record
    rdID                  : integer  ;
    RoomReservation       : integer  ;
    Reservation           : integer  ;
    dtDate                : Tdate    ;
    Room                  : string   ;
    RoomType              : string   ;
    ResFlag               : TReservationStatus;
    isNoRoom              : boolean  ;
    PriceCode	            : string   ;
    RoomRate	            : double   ;
    Discount              : double   ;
    isPercentage          : boolean  ;
    showDiscount	        : boolean  ;
    Paid                  : boolean  ;
    Currency	            : string   ;
    MainGuest             : string   ;
    numGuests             : integer  ;
    numChildren           : integer  ;
    numInfants            : integer  ;
    roomCount             : integer  ;
  end;



type
  TfrmAllotmentToRes = class(TForm)
    sPanel2: TsPanel;
    panLeft: TsPanel;
    sSplitter1: TsSplitter;
    sPanel4: TsPanel;
    sPanel5: TsPanel;
    mRrInfo: TkbmMemTable;
    mRrInfoDS: TDataSource;
    mRooms: TkbmMemTable;
    sPanel1: TsPanel;
    sPanel7: TsPanel;
    sPanel8: TsPanel;
    mRoomsDS: TDataSource;
    timClose: TTimer;
    sGroupBox2: TsGroupBox;
    chkRoomCount: TsCheckBox;
    chkGuestName: TsCheckBox;
    chkPrice: TsCheckBox;
    chkNumGuests: TsCheckBox;
    kbmRoomRes: TkbmMemTable;
    mRoomResDS: TDataSource;
    kbmRoomRates: TkbmMemTable;
    kbmRoomRatesDS: TDataSource;
    mQuickResDS: TDataSource;
    mQuickRes: TkbmMemTable;
    sLabel2: TsLabel;
    btnHideShowAllotment: TsButton;
    sButton5: TsButton;
    sButton6: TsButton;
    sGroupBox3: TsGroupBox;
    cLabCountry: TsLabel;
    clabReservationName: TsLabel;
    labRefrence: TsLabel;
    labCountry: TsLabel;
    labReservationName: TsLabel;
    sLabel18: TsLabel;
    labResStatus: TsLabel;
    labPriceCode: TsLabel;
    clabRefrence: TsLabel;
    kbmrestRoomRes: TkbmMemTable;
    kbmrestRoomResDS: TDataSource;
    kbmRestRoomRatesDS: TDataSource;
    kbmRestRoomRates: TkbmMemTable;
    chkShowRoomdescription: TsCheckBox;
    sCheckBox1: TsCheckBox;
    chkIsGroupInvoice: TsCheckBox;
    sPanel3: TsPanel;
    sButton2: TsButton;
    sPanel6: TsPanel;
    sButton4: TsButton;
    sGroupBox1: TsGroupBox;
    clabFirstDate: TsLabel;
    clabLastDate: TsLabel;
    clabRoomCount: TsLabel;
    clabDayCount: TsLabel;
    labFirstDate: TsLabel;
    labLastDate: TsLabel;
    labDays: TsLabel;
    labRooms: TsLabel;
    sLabel1: TsLabel;
    labResRooms: TsLabel;
    labCurrency: TsLabel;
    sLabel3: TsLabel;
    clabCustomerName: TsLabel;
    labCustomerName: TsLabel;
    labCustomer: TsLabel;
    grRoomRes: TcxGrid;
    tvRoomRes: TcxGridDBTableView;
    tvRoomResColumn1: TcxGridDBColumn;
    tvRoomResRoom: TcxGridDBColumn;
    tvRoomResRoomDescription: TcxGridDBColumn;
    tvRoomResRoomType: TcxGridDBColumn;
    tvRoomResRoomTypeDescription: TcxGridDBColumn;
    tvRoomResArrival: TcxGridDBColumn;
    tvRoomResDeparture: TcxGridDBColumn;
    tvRoomResGuests: TcxGridDBColumn;
    tvRoomResChildrenCount: TcxGridDBColumn;
    tvRoomResinfantCount: TcxGridDBColumn;
    tvRoomResMainGuest: TcxGridDBColumn;
    tvRoomResAvragePrice: TcxGridDBColumn;
    tvRoomResRateCount: TcxGridDBColumn;
    tvRoomResRoomReservation: TcxGridDBColumn;
    tvRoomResAvrageDiscount: TcxGridDBColumn;
    tvRoomResisPercentage: TcxGridDBColumn;
    tvRoomResPriceCode: TcxGridDBColumn;
    tvRoomRates: TcxGridDBTableView;
    tvRoomRatesReservation: TcxGridDBColumn;
    tvRoomRatesRoomReservation: TcxGridDBColumn;
    tvRoomRatesRoomNumber: TcxGridDBColumn;
    tvRoomRatesRateDate: TcxGridDBColumn;
    tvRoomRatesPriceCode: TcxGridDBColumn;
    tvRoomRatesRate: TcxGridDBColumn;
    tvRoomRatesDiscount: TcxGridDBColumn;
    tvRoomRatesisPercentage: TcxGridDBColumn;
    tvRoomRatesShowDiscount: TcxGridDBColumn;
    tvRoomRatesisPaid: TcxGridDBColumn;
    tvRoomRatesDiscountAmount: TcxGridDBColumn;
    tvRoomRatesRentAmount: TcxGridDBColumn;
    tvRoomRatesNativeAmount: TcxGridDBColumn;
    lvRoomRes: TcxGridLevel;
    lvRoomRates: TcxGridLevel;
    grProvide: TAdvStringGrid;
    sGroupBox4: TsGroupBox;
    btnReCalc: TsButton;
    btnReclacAllPrices: TsButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkShowRoomdescriptionClick(Sender: TObject);
    procedure grProvideGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure mRrInfoBeforePost(DataSet: TDataSet);
    procedure timCloseTimer(Sender: TObject);

    procedure sPanel7DblClick(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure grProvideClickCell(Sender: TObject; ARow, ACol: Integer);
    function updateCellInfo(aCol,aRow : integer; newRR : integer) : boolean;
    procedure grProvideDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure sCheckBox1Click(Sender: TObject);
    procedure btnHideShowAllotmentClick(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure btnReCalcClick(Sender: TObject);
    procedure btnReclacAllPricesClick(Sender: TObject);

  private
    { Private declarations }
    zFirstDate : Tdate;
    zNightCount : integer;

    zRoomCount : integer;


    zRows : integer;
    zCols : integer;
    zResFlag : string;

    zCountRoomTypes : integer;
    zShowRoomDescription  : boolean;

    zReservationInfo : recReservationHolder;
    zAllotmentIsGroupInvoice : boolean;


    procedure GetRrData(Reservation : integer);

    //Fill grid grProvide
    procedure FillgrProvideWithRooms;
    procedure SetDateHeads;
    procedure InitCell(c,r : integer);
    function SetCell(rrInfo : RecRRInfoAlot; col,row : integer; setText : boolean) : recColRow;
    function DateToCol(aDate : Tdate) : integer;
    function RoomAndDateToCell(Room,RoomType : string; aDate : Tdate) : recColRow;
    function RoomAndTypeToRow(room,roomType : string) : integer;

    function InitRRInfo : RecRRInfoAlot;
    function ColToDate(ACol : integer) : TdateTime;

    function GetResStatus(ACol, ARow : integer; var status : TReservationStatus) : boolean;
    procedure FillData;
    procedure InitAll;

    function isValidAllotment(reservation : integer) : boolean;
    function GetRooms : integer;
    function GetResInfo(ACol : Integer = -1; ARow : Integer = -1) : RecRRInfoAlot;
    function AddRoomRservation(Roomreservation : integer) : boolean;
    function Apply: boolean;
    function GetRest : integer;
    function AddRestRoomRservation(Roomreservation : integer) : boolean;
    function RoomsInAllotment : integer;
    function CalcOnePrice(roomreservation : integer; NewRate : double=0) : boolean;
    procedure ReclacAllPrices;

  public
    { Public declarations }
    zReservation : integer;
    zRestCount : integer;
    oNewReservation  : TNewReservation;
    oRestReservation : TNewReservation;
  end;

var
  frmAllotmentToRes: TfrmAllotmentToRes;

implementation

{$R *.dfm}

uses
  uDImages,
  uMain,
  PrjConst,
  uRoomerDefinitions
  , Math;

{ TfrmAllotmentToRes }


    function HexToTColor(sColor : string) : TColor;
    begin
      result := RGB(strToint('$' + copy(sColor, 1, 2)), strToint('$' + copy(sColor, 3, 2)), strToint('$' + copy(sColor, 5, 2)));
    end;


constructor TResCell.Create( rdID
                            ,RoomReservation
                            ,Reservation       : integer  ;
                             dtDate            : Tdate    ;
                             Room
                            ,RoomType          : string;
                             ReservationStatus : TReservationStatus;
                             isNoRoom          : boolean  ;
                             PriceCode         : string   ;
                             RoomRate
                            ,Discount          : double   ;
                             isPercentage
                            ,showDiscount      : boolean  ;
                             Paid              : boolean  ;
                             Currency
                            ,MainGuest         : string   ;
                             numGuests
                            ,numChildren
                            ,numInfants
                            ,RoomCount         : integer
                      );

begin
   FrdID              :=  rdID              ;
   FRoomReservation   :=  RoomReservation   ;
   FReservation       :=  Reservation       ;
   FdtDate            :=  dtDate            ;
   FRoom              :=  Room              ;
   FRoomType          :=  RoomType          ;
   FResFlag           :=  ResFlag           ;
   FisNoRoom          :=  isNoRoom          ;
   FPriceCode         :=  PriceCode         ;
   FRoomRate          :=  RoomRate          ;
   FDiscount          :=  Discount          ;
   FisPercentage      :=  isPercentage      ;
   FshowDiscount      :=  showDiscount      ;
   FPaid              :=  Paid              ;
   FCurrency          :=  Currency          ;
   FMainGuest         :=  MainGuest         ;
   FnumGuests         :=  numGuests         ;
   FnumChildren       :=  numChildren       ;
   FnumInfants        :=  numInfants        ;
   FRoomCount         :=  RoomCount         ;
end;

destructor TresCell.Destroy;
begin
  inherited Destroy;
end;

function TfrmAllotmentToRes.ColToDate(ACol : integer) : TdateTime;
begin
  result := zFirstDate + (ACol - (cCountFixedCols));
end;


function TfrmAllotmentToRes.DateToCol(aDate : Tdate) : integer;
begin
  result := (trunc(aDate) - trunc(zFirstDate)) + cCountFixedCols;
end;

function TfrmAllotmentToRes.RoomAndTypeToRow(room,roomType : string) : integer;
var
  i : integer;
begin
  Result := 0;
  for i := cCountFixedRows to grProvide.RowCount-(cCountFixedRows) do
  begin
    if Sametext(room, grProvide.Cells[0,i]) and Sametext(roomtype, grProvide.Cells[1,i])  then
    begin
      result := i;
      break;
    end;
  end;
end;

procedure TfrmAllotmentToRes.sButton2Click(Sender: TObject);
var
  Roomreservation : integer;
begin
  if KbmRoomRes.RecordCount = 0 then exit;

  KbmRoomRes.DisableControls;
  mRRinfo.DisableControls;
  kbmRoomRates.DisableControls;
  try
    RoomReservation := KbmRoomRes.fieldbyname('Roomreservation').asinteger;
    try
      mRRinfo.First;
      while not mRRinfo.eof do
      begin
        if mRRinfo.FieldByName('processed').asinteger = RoomReservation then
        begin
          mRRinfo.Edit;
          mRRinfo.FieldByName('processed').AsInteger := -1;
          mRRinfo.Post;
        end;
        mRRinfo.Next;
      end;
    finally
//      mRRinfo.Filtered := false;
    end;
    KbmRoomRes.Delete;
    kbmRoomRates.Filter := '(Roomreservation='+inttostr(roomreservation)+')';
    kbmRoomRates.Filtered := true;
    try
      kbmRoomRates.First;
      while not kbmRoomRates.eof do
      begin
        kbmRoomRates.Delete;
        kbmRoomRates.Next;
      end;
    finally
      kbmRoomRates.Filtered := false;
    end;
  finally
    kbmRoomRes.EnableControls;
    mRRinfo.EnableControls;
    kbmRoomRates.EnableControls;
  end;
  FillData;
  zRestCount := RoomsInAllotment;
end;

procedure TfrmAllotmentToRes.btnHideShowAllotmentClick(Sender: TObject);
begin
  panLeft.Visible := not panLeft.Visible;
  if panLeft.Visible then
  begin
    btnHideShowAllotment.Caption := 'Hide Allotment';
  end else
  begin
    btnHideShowAllotment.Caption := 'Show Allotment';
  end;
end;

procedure TfrmAllotmentToRes.sButton4Click(Sender: TObject);
begin
  GetRooms;
  zRestCount := RoomsInAllotment;
end;

procedure TfrmAllotmentToRes.sButton5Click(Sender: TObject);
begin
  if KbmRoomRes.RecordCount > 0 then
  begin
    apply;
    oNewReservation.ShowProfile := true;
  end else oNewReservation.ShowProfile := false;
end;


procedure TfrmAllotmentToRes.sCheckBox1Click(Sender: TObject);
begin
  if (sender as TsCheckBox).Checked then
  begin
     grProvide.AutoFitColumns(false);
  end else
  begin
    grProvide.AutoSizeColumns(false,2);
  end;
end;

function TfrmAllotmentToRes.isValidAllotment(reservation : integer) : boolean;
var
  s   : string;
  sql : string;

  rset1,
  rset2,
  rset3 : TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;
begin
  result := true;
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try
    //**zxhj

    s := '';
    s := s+' SELECT DISTINCT '#10;
    s := s+'    rd.resFlag '#10;
    s := s+' FROM '#10;
    s := s+'   roomsdate rd '#10;
    s := s+' WHERE '#10;
    s := s+'  (rd.Reservation = %d ) '#10;
    s := s+'   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '; //**zxhj b�tt vi�


    sql := format(s, [Reservation]);
//    copyToClipBoard(sql);
//    Debugmessage(sql);
    ExecutionPlan.AddQuery(sql);  //0


    s := '';
    s := s+' SELECT DISTINCT '#10;
    s := s+'    rd.resFlag '#10;
    s := s+' FROM '#10;
    s := s+'   roomsdate rd '#10;
    s := s+' WHERE '#10;
    s := s+'   (rd.resFlag not in ('+_db('A')+','+_db('P')+','+_db('X')+','+_db('O')+')) '#10; //**zxhj breytti
    s := s+'   AND (rd.Reservation = %d ) '#10;
    s := s+' LIMIT 1 '#10;

    sql := format(s, [Reservation]);
//    copyToClipBoard(sql);
//    Debugmessage(sql);
    ExecutionPlan.AddQuery(sql);  //0


    s := '';
    s := s+' SELECT '#10;
    s := s+'   paid '#10;
    s := s+' FROM '#10;
    s := s+'   roomsdate rd '#10;
    s := s+' WHERE '#10;
    s := s+'   (paid=1) and (rd.Reservation = %d ) '#10;
    s := s+'   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) ';//**zxhj line added
    s := s+' LIMIT 1 '#10;


    sql := format(s, [Reservation]);
//    copyToClipBoard(sql);
//    Debugmessage(sql);
    ExecutionPlan.AddQuery(sql);  //0

  screen.Cursor := crHourglass;
  try
    ExecutionPlan.Execute(ptQuery);

    zResFlag := '';
    rSet1 := ExecutionPlan.Results[0];
    if rSet1.RecordCount > 1 then
    begin
      result := false;
    end else
    begin
      zResFlag := rSet1.FieldByName('ResFlag').AsString;
      labResStatus.Caption := zResFlag;
    end;

    rSet2 := ExecutionPlan.Results[1];
    if rSet2.RecordCount > 0 then
    begin
      result := false;
    end;

    rSet3 := ExecutionPlan.Results[2];
    if rSet3.RecordCount > 0 then
    begin
      result := false;
    end;

    finally
      screen.Cursor := crDefault;
    end;
  finally
    ExecutionPlan.Free;
  end;
end;



function TfrmAllotmentToRes.RoomAndDateToCell(Room,RoomType : string; aDate : Tdate) : recColRow;
begin
  result.col := DateToCol(aDate);
  result.row := RoomAndTypeToRow(room,roomType);
end;


procedure TfrmAllotmentToRes.InitCell(c,r : integer);
var
  rrInfo : RecRRInfoAlot;
begin
  if grProvide.Objects[c,r] <> nil then
  begin
    grProvide.Objects[c,r] :=  nil;
    grProvide.Objects[c,r].Free;
  end;
  grProvide.Cells[c,r] := '';
  rrInfo := initRRInfo;

  grProvide.Objects[c,r] := TresCell.Create(
                                               rrInfo.rdID
                                              ,rrInfo.RoomReservation
                                              ,rrInfo.Reservation
                                              ,rrInfo.dtDate
                                              ,rrInfo.Room
                                              ,rrInfo.RoomType
                                              ,rrInfo.ResFlag
                                              ,rrInfo.isNoRoom
                                              ,rrInfo.PriceCode
                                              ,rrInfo.RoomRate
                                              ,rrInfo.Discount
                                              ,rrInfo.isPercentage
                                              ,rrInfo.showDiscount
                                              ,rrInfo.Paid
                                              ,rrInfo.Currency
                                              ,rrInfo.MainGuest
                                              ,rrInfo.numGuests
                                              ,rrInfo.numChildren
                                              ,rrInfo.numInfants
                                              ,rrInfo.roomCount
                                            );
end;





Function TfrmAllotmentToRes.InitRRInfo : RecRRInfoAlot;
begin
  result.rdID            := -1;
  result.RoomReservation := 0;
  result.Reservation     := 0;
  result.dtDate          := 1;
  result.Room            := '';
  result.RoomType        := '';
  result.ResFlag         := rsUnknown;
  result.isNoRoom        := false;
  result.PriceCode	     := '';
  result.RoomRate	       := 0.00;
  result.Discount        := 0.00;
  result.isPercentage    := false;
  result.showDiscount	   := false;
  result.Paid            := false;
  result.Currency	       := '';
  result.MainGuest       := '';
  result.numGuests     := 0;
  result.numChildren   := 0;
  result.numInfants    := 0;
  result.roomCount     := 0;
end;

procedure TfrmAllotmentToRes.mRrInfoBeforePost(DataSet: TDataSet);
begin
//  if dataset['roomCount'] = null then dataset['roomCount'] := 1;
//  if dataset['isNoroom'] = true then dataset['room'] := '';

end;

function TfrmAllotmentToRes.SetCell(rrInfo : RecRRInfoAlot; col,row : integer; setText : boolean) : recColRow;
var
  rcRec : recColRow;
  s,ss  : string;

  roomCount : integer;

begin
  roomCount := 0;
  rcRec := RoomAndDateToCell(rrInfo.Room,rrInfo.RoomType,rrInfo.dtDate);

  if col <> -1 then rcRec.col := col;
  if row <> -1 then rcRec.row := row;

  if grProvide.Objects[rcRec.col,rcRec.row] <> nil then
  begin
    roomcount := GetResInfo(Col,Row).roomCount;
    roomCount := roomCount+1;
    grProvide.Objects[rcRec.col,rcRec.row] :=  nil;
    grProvide.Objects[rcRec.col,rcRec.row].Free;
  end;

  if roomCount > 0 then
  begin
    if setText then
    begin
      s := '';
      if chkRoomCount.checked then s := s+ '['+inttoStr(RoomCount)+']';
      if chkNumGuests.checked then s := s+ '['+inttostr(rrInfo.numGuests)+']';
      if chkGuestName.checked then s := s+ ' '+rrInfo.mainGuest;
      if chkPrice.checked     then
      begin
         ss := '%';
         if rrInfo.isPercentage = false then ss := ' '+rrInfo.Currency;
         s := s+ ' '+FloatTostr(rrInfo.RoomRate)+rrInfo.Currency+'-'+FloatTostr(rrInfo.Discount)+ss;
      end;
      grProvide.Cells[rcRec.col,rcRec.row] := s;
    end;
    grProvide.Objects[rcRec.col,rcRec.row] := TresCell.Create(
                                       rrInfo.rdID
                                      ,rrInfo.RoomReservation
                                      ,rrInfo.Reservation
                                      ,rrInfo.dtDate
                                      ,rrInfo.Room
                                      ,rrInfo.RoomType
                                      ,rrInfo.ResFlag
                                      ,rrInfo.isNoRoom
                                      ,rrInfo.PriceCode
                                      ,rrInfo.RoomRate
                                      ,rrInfo.Discount
                                      ,rrInfo.isPercentage
                                      ,rrInfo.showDiscount
                                      ,rrInfo.Paid
                                      ,rrInfo.Currency
                                      ,rrInfo.MainGuest
                                      ,rrInfo.numGuests
                                      ,rrInfo.numChildren
                                      ,rrInfo.numInfants
                                      ,roomCount
                                );

  end else
  begin
    InitCell(col,row);
  end;
  result := rcRec;
end;

procedure TfrmAllotmentToRes.InitAll;
var
  i,ii : integer;
begin
  for i := cCountFixedCols to grProvide.ColCount-1 do
  for ii := cCountFixedRows to grProvide.rowCount-1 do
  begin
    InitCell(i,ii);
  end;
end;

procedure TfrmAllotmentToRes.FillData;
var
  rrInfo : RecRRInfoAlot;
  rcRec : recColRow;
  col,row : integer;
  processed : integer;
begin
  initAll;


  mRRInfo.DisableControls;
  screen.Cursor := crHourGlass;
  try
    mRRInfo.First;
    while not mRRInfo.eof do
    begin
      col := mRRInfo.fieldbyname('col').asInteger;
      row := mRRInfo.fieldbyname('row').asInteger;
      processed := mRRInfo.fieldbyname('processed').asInteger;

      if processed < 0 then
      begin
        rrInfo := InitRRInfo;
        rrInfo.rdID            := mRRInfo.fieldbyname('rdID').asInteger;
        rrInfo.RoomReservation := mRRInfo.fieldbyname('RoomReservation').asInteger;
        rrInfo.Reservation     := mRRInfo.fieldbyname('Reservation').asInteger;
        rrInfo.dtDate          := mRRInfo.fieldbyname('dtDate').asDateTime;
        rrInfo.Room            := mRRInfo.fieldbyname('Room').asString;
        rrInfo.RoomType        := mRRInfo.fieldbyname('RoomType').asString;
        rrInfo.ResFlag         := TReservationStatus.FromResStatus(mRRInfo.fieldbyname('ResFlag').asString);
        rrInfo.isNoRoom        := mRRInfo.fieldbyname('isNoRoom').asBoolean;
        rrInfo.PriceCode	     := mRRInfo.fieldbyname('PriceCode').asString;
        rrInfo.RoomRate	       := mRRInfo.fieldbyname('RoomRate').asFloat;
        rrInfo.Discount        := mRRInfo.fieldbyname('Discount').asFloat;
        rrInfo.isPercentage    := mRRInfo.fieldbyname('isPercentage').asBoolean;
        rrInfo.showDiscount	   := mRRInfo.fieldbyname('showDiscount').asBoolean;
        rrInfo.Paid            := mRRInfo.fieldbyname('Paid').asBoolean;
        rrInfo.Currency	       := mRRInfo.fieldbyname('Currency').asString;
        rrInfo.MainGuest       := mRRInfo.fieldbyname('MainGuest').asString;
        rrInfo.numGuests       := mRRInfo.fieldbyname('numGuests').asInteger;
        rrInfo.numChildren     := mRRInfo.fieldbyname('numChildren').asInteger;
        rrInfo.numInfants      := mRRInfo.fieldbyname('numInfants').asInteger;
        rrInfo.roomCount       := mRRInfo.fieldbyname('RoomCount').asInteger;
        rcRec := SetCell(rrInfo,col,row,true);
      end;
      mRRInfo.next;
    end;
  finally
    mRRInfo.enableControls;
    screen.Cursor := crDefault;
  end;
end;


procedure TfrmAllotmentToRes.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  //**
  zReservation := 0;
  zFirstDate := 2;
  zNightCount := 0;
end;

procedure TfrmAllotmentToRes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**
end;

procedure TfrmAllotmentToRes.FormDestroy(Sender: TObject);
begin
  //**
end;

procedure TfrmAllotmentToRes.FormShow(Sender: TObject);
begin
  if isValidAllotment(zreservation) then
  begin
    zShowRoomDescription := chkShowRoomDescription.Checked;
    GetRrData(zReservation);
    zReservationInfo := SP_GET_Reservation(zReservation);
  end else
  begin
    showmessage(GetTranslatedText('shTx_AllotmentToRes_InvalidAllotment'));
    timClose.Enabled := true;
  end;
end;

//-End Form Actions ---------------------------------------------------------


procedure TfrmAllotmentToRes.chkShowRoomdescriptionClick(Sender: TObject);
begin
  zShowRoomDescription := chkShowRoomDescription.Checked;
  FillgrProvideWithRooms;
end;

procedure TfrmAllotmentToRes.FillgrProvideWithRooms;
var
  Room: string;
  RoomType: string;
  RoomDescription: string;

  startRow : integer;
  RowIndex : integer;
  other : string;
begin
  mRooms.First;

  startRow := grProvide.FixedRows;
  rowIndex := startRow - 1;

  while not mRooms.Eof do
  begin
    inc(rowIndex);

    room            := mRooms.FieldByName('room').asString;
    RoomType        := mRooms.FieldByName('roomType').asString;
    RoomDescription := mRooms.FieldByName('RoomDescription').asString;
    other           := mRooms.FieldByName('otherInfo').asString;

    grProvide.cells[cColRoom, RowIndex]     := Room;
    grProvide.cells[cColRoomType, RowIndex] := RoomType;
    grProvide.cells[cColInfo, RowIndex] := other;
    if zShowRoomDescription then
    begin
      grProvide.cells[cColRoomDescription, RowIndex] := RoomDescription;
    end else
    begin
      grProvide.cells[cColRoomDescription, RowIndex] := '';
    end;

//    cellInfo := initRrInfo;
//    cellInfo.Room      := room;
//    cellInfo.RoomType  := roomType;
//    if room = '' then
//    begin
//      cellInfo.ResFlag   := zResFlag;
//      cellInfo.PriceCode := '';
//      cellInfo.RoomRate  := 0.00;
//      cellInfo.Discount  := 0.00;
//      cellInfo.isPercentage  := False;
//      cellInfo.showDiscount  := False;
//      cellInfo.numGuests     := 0;
//    end;
//    setCell(cellinfo,0,rowindex,false);
    mRooms.Next;
  end;

  grProvide.AutoSizeCol(0,1);
  grProvide.AutoSizeCol(1,1);
  grProvide.AutoSizeCol(2,1);
  grProvide.ColWidths[3] := 1;
  grProvide.AutoSizeRows(True);
  grProvide.RowHeights[0] := grProvide.RowHeights[1];
end;


procedure TfrmAllotmentToRes.SetDateHeads;
var
  dayStartCol : integer;
  i : integer;
  aDate : Tdate;
  s : string;
begin
  dayStartCol := cCountFixedCols-1;
  aDate := zFirstDate;
  for i := 1 to zNightCount + cCountFixedCols do
  begin
    dateTimeToString(s, g.qPeriodDateformat2, aDate);
    grProvide.cells[i + dayStartCol, 1] := s;
    dateTimeToString(s, g.qPeriodDateformat1, aDate);
    grProvide.cells[i + dayStartCol, 0] := s;
    aDate := aDate + 1;
  end;
end;

procedure TfrmAllotmentToRes.sPanel7DblClick(Sender: TObject);
begin
  sPanel4.width := width-40;
end;


procedure TfrmAllotmentToRes.timCloseTimer(Sender: TObject);
begin
  timClose.Enabled := false;
  close;
end;




function TfrmAllotmentToRes.GetResStatus(ACol, ARow : integer; var status : TReservationStatus) : boolean;
begin
  result := false;
  if grProvide.Objects[ACol, ARow] <> nil then
  begin
    status := (grProvide.Objects[ACol, ARow] as TresCell).resFlag;
    result := true;
  end;
end;


procedure TfrmAllotmentToRes.grProvideClickCell(Sender: TObject; ARow, ACol: Integer);
var
  info : RecRRInfoAlot;
begin
  if aRow >= cCountFixedRows then
    if aCol >= cCountFixedCols then
  begin
    info := GetResInfo();
  end;
end;

procedure TfrmAllotmentToRes.grProvideDblClickCell(Sender: TObject; ARow, ACol: Integer);
begin
//  updateCellInfo(aCol,aRow,100);
end;

procedure TfrmAllotmentToRes.grProvideGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush;
  AFont: TFont);
var
  colDate : TDate;
  weekDay : Integer;
  status  : TReservationStatus;
  BColor, FColor : Tcolor;

begin
  colDate := ColToDate(ACol);
  weekDay := dayOfWeek(colDate);
  ABrush.color := frmMain.sSkinManager1.GetActiveEditColor;
  AFont.color  := frmMain.sSkinManager1.GetActiveEditFontColor;
  AFont.Style := [];

  if (arow > cCountFixedRows-1) and (acol>cCountFixedCols-1) then
  begin
    if weekDay = 1 then
    begin
      ABrush.color := HexToTColor('FFC2C2');
    end;

    if weekDay = 7 then
    begin
      ABrush.color := HexToTColor('FFDCDC');
    end;

  GetResStatus(ACol, ARow, status);
  if Status.ToColor(BColor, FColor) then
  begin
    ABrush.color := BColor;
    AFont.color := FColor;
  end;


  end;
end;


function TfrmAllotmentToRes.GetRooms : integer;
var
  i : integer;
  iRow : integer;
  iCol : integer;
  sCellContent : string;

  aRow     : integer;
  aCol     : integer;
  FirstCol   : integer;
  LastCol : integer;

  NextRow       : integer;
  NextFirstCol : integer;
  NextLastCol   : integer;


  RoomReservation : integer;



begin
  result := 0;
  if mQuickRes.active then
    mQuickRes.Close;
  mQuickRes.Open;
  mQuickRes.SortFields := 'Row;FirstCol';

  for iRow := cCountFixedRows to grProvide.RowCount - 1 do
  begin
    for iCol := cCountFixedCols to grProvide.ColCount - 1 do
    begin
      sCellContent := trim(grProvide.cells[iCol, iRow]);
      if sCellContent <> '' then
      begin
        if grProvide.SelectedCells[iCol, iRow] then
        begin
            //aRoom := grProvide.cells[0, iRow];
            aRow := iRow;

            FirstCol := iCol;
            LastCol := FirstCol + 1;

            mQuickRes.append;
            mQuickRes.FieldByName('Row').asInteger := aRow;
            mQuickRes.FieldByName('FirstCol').AsInteger := FirstCol;
            mQuickRes.FieldByName('LastCol').AsInteger := LastCol;
            mQuickRes.Post;
        end;
      end;
    end;
  end;

  mQuickRes.first;
  while not mQuickRes.eof do
  begin
    aRow       := mQuickRes.FieldByName('Row').asInteger;
    LastCol   := mQuickRes.FieldByName('LastCol').asInteger;
    if not mQuickRes.eof then
    begin
      mQuickRes.next;
      NextRow      := mQuickRes.FieldByName('Row').asInteger;
      NextFirstCol := mQuickRes.FieldByName('FirstCol').asInteger;
      NextLastCol  := mQuickRes.FieldByName('LastCol').asInteger;

     if (NextFirstCol = LastCol) and (aRow = NextRow) then
     begin
       mQuickRes.Prior;
       mQuickRes.edit;
       mQuickRes.FieldByName('LastCol').asInteger := NextLastCol;
       mQuickRes.Post;

       mQuickRes.next;
       mQuickRes.Delete;
       mQuickRes.first;
      end;
    end else mQuickRes.next;
  end;

  mQuickRes.first;
  while not mQuickRes.eof do
  begin
    mQuickRes.Edit;
    mQuickRes.FieldByName('LastCol').asInteger := mQuickRes.FieldByName('LastCol').asInteger-1;
    mQuickRes.post;
    mQuickRes.next;
  end;

  mQuickRes.first;
  while not mQuickRes.eof do
  begin
    aRow     := mQuickRes.FieldByName('Row').asInteger;
    FirstCol := mQuickRes.FieldByName('firstCol').asInteger;
    LastCol  := mQuickRes.FieldByName('LastCol').asInteger;

    RoomReservation := RR_SetNewID();

    for i := FirstCol to LastCol do
    begin
      //**
      aCol := i;
      updateCellInfo(aCol,aRow,RoomReservation);
    end;
    AddRoomRservation(Roomreservation);
    mQuickRes.next;
  end;
end;

function TfrmAllotmentToRes.GetRest : integer;
var
  i,ii : integer;
  iRow : integer;
  iCol : integer;
  sCellContent : string;

  aRow     : integer;
  aCol     : integer;
  FirstCol   : integer;
  LastCol : integer;

  NextRow       : integer;
  NextFirstCol : integer;
  NextLastCol   : integer;


  RoomReservation : integer;

  rrCount : integer;
  sIDs : string;
  lstIDS : Tstringlist;

begin
  result := 0;

  lstIDs := TStringlist.Create;
  try
    if mQuickRes.active then
      mQuickRes.Close;
    mQuickRes.Open;
    mQuickRes.SortFields := 'Row;FirstCol';

    for iRow := cCountFixedRows to grProvide.RowCount - 1 do
    begin
      for iCol := cCountFixedCols to grProvide.ColCount - 1 do
      begin
        sCellContent := trim(grProvide.cells[iCol, iRow]);
        if sCellContent <> '' then
        begin
           inc(Result);
           //aRoom := grProvide.cells[0, iRow];
           aRow := iRow;

            FirstCol := iCol;
            LastCol := FirstCol + 1;

            mQuickRes.append;
            mQuickRes.FieldByName('Row').asInteger := aRow;
            mQuickRes.FieldByName('FirstCol').AsInteger := FirstCol;
            mQuickRes.FieldByName('LastCol').AsInteger := LastCol;
            mQuickRes.Post;
        end;
      end;
    end;

    if result = 0 then exit;

    mQuickRes.first;
    while not mQuickRes.eof do
    begin
      aRow       := mQuickRes.FieldByName('Row').asInteger;
      LastCol   := mQuickRes.FieldByName('LastCol').asInteger;
      if not mQuickRes.eof then
      begin
        mQuickRes.next;
        NextRow      := mQuickRes.FieldByName('Row').asInteger;
        NextFirstCol := mQuickRes.FieldByName('FirstCol').asInteger;
        NextLastCol  := mQuickRes.FieldByName('LastCol').asInteger;

       if (NextFirstCol = LastCol) and (aRow = NextRow) then
       begin
         mQuickRes.Prior;
         mQuickRes.edit;
         mQuickRes.FieldByName('LastCol').asInteger := NextLastCol;
         mQuickRes.Post;

         mQuickRes.next;
         mQuickRes.Delete;
         mQuickRes.first;
        end;
      end else mQuickRes.next;
    end;

    mQuickRes.first;
    while not mQuickRes.eof do
    begin
      mQuickRes.Edit;
      mQuickRes.FieldByName('LastCol').asInteger := mQuickRes.FieldByName('LastCol').asInteger-1;
      mQuickRes.post;
      mQuickRes.next;
    end;

    rrCount := mQuickRes.recordcount;
    sIDs := RR_GetIDs(rrCount);
    _glob._strTokenToStrings(sIDs,'|',lstIDs);

    ii := -1;
    mQuickRes.first;
    while not mQuickRes.eof do
    begin
      inc(ii);
      aRow     := mQuickRes.FieldByName('Row').asInteger;
      FirstCol := mQuickRes.FieldByName('firstCol').asInteger;
      LastCol  := mQuickRes.FieldByName('LastCol').asInteger;

      RoomReservation := strToInt(lstIds[ii]);//RR_SetNewID();

      for i := FirstCol to LastCol do
      begin
        //**
        aCol := i;
        updateCellInfo(aCol,aRow,RoomReservation);
      end;
      AddRestRoomRservation(Roomreservation);
      mQuickRes.next;
    end;
  finally
    freeandnil(lstIds);
  end;
end;




function TfrmAllotmentToRes.AddRoomRservation(Roomreservation : integer) : boolean;
var
  Room                : string; //*
  RoomType            : string; //*
  Guests              : integer;//
  AvragePrice         : double ;//
  RateCount           : integer;//
  RoomDescription     : String ;
  RoomTypeDescription : string ;
  Arrival             : TDate  ;//*
  Departure           : TDate  ;//*
  ChildrenCount       : Integer;//
  InfantCount         : Integer;//
  PriceCode           : String ;//*
  AvrageDiscount      : double ;//
  isPercentage        : boolean;//*
  MainGuest           : string ;//*

  ttPrice        : double;
  ttDiscount     : Double;
  ttPriceCount   : integer;
  ttNetPrice     : double;
  AvrageNetPrice : double ;//


  sFilter : string;
  tmpArrival : Tdate;
  tmpDeparture : Tdate;

  roomRate : double;
  discount : double;

  lstPrices        : TstringList;

  DiscountAmount : double;
  RentAmount     : double;
  NativeAmount   : double;

  currencyRate   : double;
  currency : string;
  oSelectedRoomItem : TnewRoomReservationItem;
begin

  result := false;

  lstPrices := TstringList.Create;
  try
    lstPrices.Sorted := true;
    lstPrices.Duplicates := dupIgnore;

    screen.Cursor := crHourGlass;
    mRRinfo.DisableControls;
    kbmRoomres.DisableControls;
    kbmRoomRates.DisableControls;
    try
      sFilter :='(processed='+inttostr(roomreservation)+')';

      mRRinfo.Filter   := sFilter;
      mRRinfo.Filtered := true;
      mRRinfo.First;

      RoomDescription     := mRRinfo.fieldbyname('RoomDescription').asstring;
      RoomTypeDescription := mRRinfo.fieldbyname('RoomDescription').asstring;
      MainGuest           := mRRinfo.fieldbyname('MainGuest').asstring;
      isPercentage        := mRRinfo.fieldbyname('isPercentage').asBoolean;
      PriceCode           := mRRinfo.fieldbyname('PriceCode').asstring;

      Guests         := mRRinfo.fieldbyname('numGuests').asinteger;
      ChildrenCount  := mRRinfo.fieldbyname('numChildren').asinteger;
      InfantCount    := mRRinfo.fieldbyname('numInfants').asinteger;

      RoomReservation := mRRinfo.FieldByName('Processed').asInteger;
      Room            := mRRinfo.FieldByName('Room').asString;
      if room         = '' then room := '<'+inttostr(roomReservation)+'>';
      RoomType        := mRRinfo.FieldByName('RoomType').asString;

      ttPrice      := 0.00;
      ttDiscount   := 0.00;
      ttPriceCount := 0;

      currency      := labCurrency.caption;
      CurrencyRate  := hData.GetRate(currency);

      tmpDeparture := 0;
      tmpArrival:= date+10000;
      mRRinfo.First;
      while not mRRinfo.eof do
      begin
        roomRate := mRRinfo.FieldByName('roomrate').asFloat;
        discount := mRRinfo.FieldByName('discount').asFloat;

        lstPrices.Add(floatTostr(RoomRate));
        ttPriceCount := ttPriceCount+1;
        ttPrice      := ttPrice   + RoomRate;
        ttDiscount   := ttDiscount+ discount;

        tmparrival := min(tmpArrival, mRRinfo.FieldByName('dtDate').asDateTime);
        tmpdeparture := max(tmpDeparture,mRRinfo.FieldByName('dtDate').asDateTime);

        mRRinfo.Next;
      end;

      Arrival := tmpArrival;
      Departure := tmpDeparture;

      AvrageDiscount := 0;
      if ttPriceCount <> 0 then
      begin
        AvrageDiscount := ttDiscount/ttPriceCount;
      end;

      rateCount := lstPrices.Count;
      Departure := departure+1;

      ttNetPrice := 0;
      mRRinfo.First;
      while not mRRinfo.eof do
      begin
        roomRate     := mRRinfo.FieldByName('RoomRate').asFloat;
        discount     := mRRinfo.FieldByName('Discount').asFloat;
        isPercentage := mRRinfo.FieldByName('isPercentage').asBoolean;

        DiscountAmount := 0;

        if roomrate <> 0 then
        begin
          if discount <> 0 then
          begin
            if isPercentage then
            begin
              DiscountAmount :=  RoomRate*discount/100;
            end else
            begin
              DiscountAmount := discount;
            end;
          end;
        end;
        RentAmount  := roomRate-DiscountAmount;
        if currencyRate = 0 then currencyRate := 1;
        NativeAmount := RentAmount*CurrencyRate;

        ttNetPrice := ttNetPrice+RentAmount;

        kbmRoomRates.Append;
        kbmRoomRates.FieldByName('Reservation').AsInteger       := mRRinfo.FieldByName('Reservation').asInteger;
        kbmRoomRates.FieldByName('RoomReservation').AsInteger   := mRRinfo.FieldByName('Processed').asInteger;
        kbmRoomRates.FieldByName('RoomNumber').AsString         := mRRinfo.FieldByName('Room').asString;
        kbmRoomRates.FieldByName('RateDate').AsDateTime         := mRRinfo.FieldByName('dtDate').asDateTime;
        kbmRoomRates.FieldByName('PriceCode').AsString          := mRRinfo.FieldByName('PriceCode').asString;
        kbmRoomRates.FieldByName('Rate').AsFloat                := Roomrate;
        kbmRoomRates.FieldByName('Discount').AsFloat            := discount;
        kbmRoomRates.FieldByName('isPercentage').AsBoolean      := isPercentage;
        kbmRoomRates.FieldByName('ShowDiscount').AsBoolean      := mRRinfo.FieldByName('Showdiscount').asBoolean;
        kbmRoomRates.FieldByName('isPaid').AsBoolean            := false;
        kbmRoomRates.FieldByName('DiscountAmount').AsFloat      := discountAmount;
        kbmRoomRates.FieldByName('RentAmount').AsFloat          := rentAmount;
        kbmRoomRates.FieldByName('NativeAmount').AsFloat        := NativeAmount;
        kbmRoomRates.Post;
        mRRinfo.Next;
      end;

      AvrageNetPrice := 0;
      if ttPriceCount <> 0 then
      begin
        AvrageNetPrice := ttnetPrice/ttPriceCount;
      end;


      kbmRoomres.Append;
      kbmRoomres.FieldByName('RoomReservation').AsInteger    :=RoomReservation     ;
      kbmRoomres.FieldByName('Room').AsString                :=Room                ;
      kbmRoomres.FieldByName('RoomType').AsString            :=RoomType            ;
      kbmRoomres.FieldByName('Guests').Asinteger             :=Guests              ;
      kbmRoomres.FieldByName('AvragePrice').AsFloat          :=AvrageNetPrice      ;
      kbmRoomres.FieldByName('RateCount').Asinteger          :=RateCount           ;
      kbmRoomres.FieldByName('RoomDescription').AsString     :=RoomDescription     ;
      kbmRoomres.FieldByName('RoomTypeDescription').Asstring :=RoomTypeDescription ;
      kbmRoomres.FieldByName('Arrival').AsDateTime           :=Arrival             ;
      kbmRoomres.FieldByName('Departure').AsDateTime         :=Departure           ;
      kbmRoomres.FieldByName('ChildrenCount').AsInteger      :=ChildrenCount       ;
      kbmRoomres.FieldByName('InfantCount').AsInteger        :=InfantCount         ;
      kbmRoomres.FieldByName('PriceCode').AsString           :=PriceCode           ;
      kbmRoomres.FieldByName('AvrageDiscount').AsFloat       :=AvrageDiscount      ;
      kbmRoomres.FieldByName('isPercentage').Asboolean       :=isPercentage        ;
      kbmRoomres.FieldByName('MainGuest').Asstring           :=MainGuest           ;
      kbmRoomRes.Post;

      oSelectedRoomItem := TnewRoomReservationItem.Create(RoomReservation,Room,RoomType,'',Arrival,departure,Guests,AvrageNetPrice,AvrageDiscount,isPercentage,RateCount,childrenCount,infantCount,PriceCode,MainGuest,'');
      oNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
      mRRinfo.Filtered := false;
    finally
      kbmRoomres.EnableControls;
      kbmRoomRates.EnableControls;
      mRRinfo.EnableControls;
      screen.Cursor := crDefault;
    end;
  finally
    freeandnil(lstPrices);
  end;

end;



function TfrmAllotmentToRes.updateCellInfo(aCol,aRow : integer; newRR : integer) : boolean;
var
  info : RecRRInfoAlot;
  processed : integer;
begin
  processed := -1;
  result := false;
  info := GetResInfo(ACol,ARow);
  mRrInfo.SortFields := 'RoomRate;isPercentage;Discount';
  mRrInfo.sort([mtcoDescending]);
  if mRRinfo.Locate('processed;Row;col',varArrayOf([processed,aRow,aCol]),[]) then
  begin
    mRRinfo.edit;
    mRRinfo.FieldByName('Processed').AsInteger := newRR;
    mRRinfo.post;
    mRrInfo.SortFields := 'RoomRate;isPercentage;Discount';
    mRrInfo.sort([]);
    filldata;
    result := true;
  end else
  begin
  end;
end;



function TfrmAllotmentToRes.GetResInfo(ACol : Integer = -1; ARow : Integer = -1) : RecRRInfoAlot;
var resCell : TresCell;
begin
  if ACol = -1 then
    ACol := grProvide.col;
  if ARow = -1 then
    ARow := grProvide.row;

  resCell := TresCell(grProvide.Objects[ACol, ARow]);

  result.rdID                := resCell.rdID            ;
  result.RoomReservation     := resCell.RoomReservation ;
  result.Reservation         := resCell.Reservation     ;
  result.dtDate              := resCell.dtDate          ;
  result.Room                := resCell.Room            ;
  result.RoomType            := resCell.RoomType        ;
  result.ResFlag             := resCell.ResFlag;
  result.isNoRoom            := resCell.isNoRoom        ;
  result.PriceCode	         := resCell.PriceCode	     ;
  result.RoomRate	           := resCell.RoomRate	       ;
  result.Discount            := resCell.Discount        ;
  result.isPercentage        := resCell.isPercentage    ;
  result.showDiscount	       := resCell.showDiscount	   ;
  result.Paid                := resCell.Paid            ;
  result.Currency	           := resCell.Currency	       ;
  result.MainGuest           := resCell.MainGuest       ;
  result.numGuests           := resCell.numGuests       ;
  result.numChildren         := resCell.numChildren     ;
  result.numInfants          := resCell.numInfants      ;
  result.roomCount           := resCell.roomCount       ;
end;


procedure TfrmAllotmentToRes.GetRrData(Reservation: integer);
var
  s   : string;
  sql : string;

  rset0,
  rset1: TRoomerDataset;
  ExecutionPlan : TRoomerExecutionPlan;

  lastDate : Tdate;
  strTmp : string;
  row,col : integer;

  Room,RoomType : string;

begin
  ExecutionPlan := d.roomerMainDataSet.CreateExecutionPlan;
  try


    s := '';
    s := s+' SELECT '#10;
    s := s+'       max(date(rd.Adate)) as maxDate '#10;
    s := s+'     , min(date(rd.Adate)) as minDate '#10;
    s := s+'     , count(room) as RoomCount '#10;
    s := s+'  FROM '#10;
    s := s+'    roomsdate rd '#10;
    s := s+' WHERE '#10;
    s := s+'   (rd.Reservation = %d) '#10;
    s := s+'   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '; //**zxhj line added
    sql := format(s, [Reservation]);
    ExecutionPlan.AddQuery(sql);     //0


    s := '';
    s := s+' SELECT '#10;
    s := s+'      rd.Id as rdID '#10;
    s := s+'    , rd.Reservation '#10;
    s := s+'    , rd.RoomReservation '#10;
    s := s+'    , date(rd.Adate) as dtDate '#10;
    s := s+'    , rd.Room '#10;
    s := s+'    , rd.RoomType '#10;
    s := s+'    , rd.resFlag '#10;
    s := s+'    , rd.isNoRoom '#10;
    s := s+'    , rd.PriceCode '#10;
    s := s+'    , rd.RoomRate '#10;
    s := s+'    , rd.Discount '#10;
    s := s+'    , rd.isPercentage '#10;
    s := s+'    , rd.showDiscount '#10;
    s := s+'    , rd.Paid '#10;
    s := s+'    , rd.Currency '#10;
    s := s+'    , rr.numGuests '#10;
    s := s+'    , rr.numChildren '#10;
    s := s+'    , rr.numInfants '#10;
    s := s+'    , rr.GroupAccount '#10;
    s := s+'    , (SELECT name FROM persons WHERE persons.roomreservation=rd.roomreservation LIMIT 1) AS MainGuest '#10;
    s := s+'    , (SELECT count(ID) FROM persons WHERE persons.roomreservation=rd.roomreservation) AS GuestCount '#10;
    s := s+'    , (SELECT Description FROM rooms WHERE rooms.room=rd.room) AS RoomDescription '#10;
    s := s+' FROM '#10;
    s := s+'   roomsdate rd '#10;
    s := s+' INNER JOIN '#10;
    s := s+'   roomreservations rr ON rd.roomreservation = rr.roomreservation ';
    s := s+' WHERE '#10;
    s := s+'   (rd.Reservation = %d) '#10;
    s := s+'   AND (ResFlag <> '+_db(STATUS_DELETED)+' ) '; //**zxhj line added



    s := s+' ORDER BY '#10;
    s := s+'      Room ';
    s := s+'    , rd.ADate '#10;

    sql := format(s, [Reservation]);
//  copyToClipBoard(sql);
//  Debugmessage(sql);
    ExecutionPlan.AddQuery(sql);  //1

    screen.Cursor := crHourGlass;
    mRrInfo.disableControls;
    try
      ExecutionPlan.Execute(ptQuery);

      rSet0       := ExecutionPlan.Results[0];
      lastDate     := _dbDateToDate(rSet0.FieldByName('maxDate').asString);
      zfirstDate   := _dbDateToDate(rSet0.FieldByName('minDate').asString);
      zRoomCount   := rSet0.FieldByName('RoomCount').asInteger;
      zNightCount  := trunc(lastDate)-trunc(zFirstDate);
      zNightCount  := zNightCount+1;

      labLastDate.Caption  := dateTostr(LastDate);
      labFirstDate.Caption := dateTostr(zFirstDate);
      labdays.Caption      := inttostr(zNightCount);
      labRooms.Caption     := inttostr(zRoomCount);

      rSet1 := ExecutionPlan.Results[1];

      if mRrInfo.Active then mRrInfo.Close;
      mRrInfo.open;
      LoadKbmMemtableFromDataSetQuiet(mRrInfo,rSet1,[]);

      mRrInfo.SortFields := 'Room;RoomType';
      mRrInfo.Sort([]);

      mRrInfo.first;

      while not mRrInfo.eof do
      begin
        room := mRrInfo.fieldbyname('room').AsString;
        if copy(room,1,1) = '<' then
        begin
          mRrInfo.Edit;
          mRrInfo.fieldbyname('isNoroom').AsBoolean := true;
          mRrInfo.FieldByName('room').AsString := '';
          mRrInfo.post;
        end;
        mRrInfo.Next;
      end;

      mRrInfo.first;
      labResRooms.Caption       := inttostr(rSet1.recordCount);
      labCurrency.Caption       := rSet1.FieldByName('Currency').AsString;;
      chkIsGroupInvoice.Checked := mRrInfo.FieldByName('GroupAccount').AsBoolean;
      zAllotmentIsGroupInvoice := mRrInfo.FieldByName('GroupAccount').AsBoolean;


      labPriceCode.Caption      := mRrInfo.FieldByName('PriceCode').AsString;

      if mRooms.Active then mRooms.Close;
      mRooms.open;
      strTmp := '';
      while not mRrInfo.eof do
      begin
        s := mRrInfo.FieldByName('room').AsString+mRrInfo.FieldByName('roomtype').AsString;
        if s <> strTmp then
        begin
          mRooms.append;
          mRooms.FieldByName('room').AsString     := mRrInfo.FieldByName('room').AsString;
          mRooms.FieldByName('RoomType').AsString := mRrInfo.FieldByName('RoomType').AsString;
          mRooms.FieldByName('RoomDescription').AsString := mRrInfo.FieldByName('RoomDescription').AsString;
          mRooms.Post;
          strTmp := s;
        end;
        mRrInfo.Next;
      end;


     mRooms.SortFields := 'RoomType;room';
     mRooms.Sort([]);
     zCountRoomTypes := mRooms.recordCount;


     zRows := 0;
     zRows := zRows + cCountFixedRows      ;
     zRows := zRows + zCountRoomTypes;
     zRows := zRows + cCountEmptyRows      ;

     zCols := 0;
     zCols := zCols +   cCountFixedCols  ;
     zCols := zCols +   zNightCount      ;
     zCols := zCols +   cCountEmptyCols  ;



     grProvide.ColCount := zCols;
     grProvide.rowCount := zRows;
     grProvide.FixedCols := cCountFixedCols;
     grProvide.FixedRows := cCountFixedRows;

     grProvide.FixedFont.Color    := frmMain.sSkinManager1.GetGlobalFontColor;
     grProvide.HighlightTextColor := frmMain.sSkinManager1.GetGlobalFontColor;
     grProvide.FixedColor         := frmMain.sSkinManager1.GetGlobalColor;

     SetDateHeads;
     FillgrProvideWithRooms;
     mRrInfo.First;
     while not mRrInfo.eof do
     begin
       col      := DateToCol(mRrInfo.fieldbyname('dtDate').asDateTime);
       room     := mRrInfo.fieldbyname('room').asString;
       roomType := mRrInfo.fieldbyname('roomType').asString;
       row := RoomAndTypeToRow(room,roomType);
       mRrInfo.edit;
       mRrInfo.FieldByName('row').AsInteger := row;
       mRrInfo.FieldByName('col').AsInteger := col;
       mRRinfo.FieldByName('Processed').AsInteger := -1;
       mRrInfo.Post;
       mRrInfo.Next;
     end;

      mRrInfo.SortFields := 'RoomRate;isPercentage;Discount';
//  mRrInfo.sort([mtcoDescending]);

//     mRrInfo.SortFields := 'row;col;RoomRate;isPercentage;Discount';
////     mRrInfo.sort([mtcoDescending]);
     FillData;
    finally
      screen.cursor := crDefault;
      mRrInfo.EnableControls;
    end;
  finally
    ExecutionPlan.Free;
  end;
end;


function TfrmAllotmentToRes.Apply: boolean;
var
  customer          : string;
  oSelectedRoomItem : TnewRoomReservationItem;
  rateItem         : TRateItem;

  Room              : string;
  RoomType          : string;
  Arrival           : TdateTime;
  Departure         : TdateTime;
  GuestCount        : Integer;
  roomReservation   : integer;
  AvragePrice       : double;
  AvrageDiscount    : double;
  isPercentage      : boolean;
  RateCount         : integer;
  ChildrenCount     : integer;
  infantCount       : integer;
  PriceCode         : string;

  rateRoomNumber   : string;
  rateDate         : Tdate;
  rate             : double;
  ratePriceCode    : string;
  rateDiscount     : double;
  rateIsPercentage : boolean;
  rateShowDiscount : boolean;
  rateIsPaid       : boolean;
  roomIndex        : integer;
  mainGuestName    : string;
  ii : integer;
begin

  result := true;
  repeat
    ii := GetRest;
  until ii = 0;

  customer := zReservationInfo.Customer;
  oNewReservation.HomeCustomer.Customer               := Customer;

  oNewReservation.HomeCustomer.GuestName              := ''                                     ;//edGuestName.text;
  oNewReservation.HomeCustomer.invRefrence            := zReservationInfo.invRefrence           ;//edinvRefrence.Text;
  oNewReservation.HomeCustomer.Country                := zReservationInfo.Country               ;//edCountry.text;
  oNewReservation.HomeCustomer.ReservationName        := zReservationInfo.Name                  ;//edReservationName.text;
  oNewReservation.HomeCustomer.RoomStatus             := 'P';            ;//RoomstatusToInfo(cbxRoomStatus.ItemIndex);
  oNewReservation.HomeCustomer.MarketSegmentCode      := zReservationInfo.MarketSegment         ;//edMarketSegmentCode.text;
  oNewReservation.HomeCustomer.Currency               := labCurrency.Caption                    ;//edCurrency.text;
  oNewReservation.HomeCustomer.PID                    := zReservationInfo.custPID             ;//edPID.text ;
  oNewReservation.HomeCustomer.CustomerName           := zReservationInfo.name ;//.CustomerName          ;// edCustomerName.text ;
  oNewReservation.HomeCustomer.Address1               := zReservationInfo.Address1              ;//edAddress1.text ;
  oNewReservation.HomeCustomer.Address2               := zReservationInfo.Address2              ;//edAddress2.text ;
  oNewReservation.HomeCustomer.Address3               := zReservationInfo.Address3              ;//edAddress3.text ;
  oNewReservation.HomeCustomer.Tel1                   := zReservationInfo.Tel1                  ;//edTel1.text     ;
  oNewReservation.HomeCustomer.Tel2                   := zReservationInfo.Tel2                  ;//edTel2.text     ;
  oNewReservation.HomeCustomer.Fax                    := zReservationInfo.Fax                   ;//edFax.text      ;
  oNewReservation.HomeCustomer.EmailAddress           := zReservationInfo.CustomerEmail         ;//edEmailAddress.text ;
  oNewReservation.HomeCustomer.HomePage               := zReservationInfo.CustomerWebSite       ;//edHomePage.text     ;
  oNewReservation.HomeCustomer.ContactPhone           := zReservationInfo.ContactPhone          ;//edContactPhone.text ;
  oNewReservation.HomeCustomer.ContactPerson          := zReservationInfo.ContactName           ;//edContactPerson.text;
  oNewReservation.HomeCustomer.ContactFax             := zReservationInfo.ContactFax            ;//edContactFax.text   ;
  oNewReservation.HomeCustomer.ContactEmail           := zReservationInfo.ContactEmail          ;//edContactEmail.text ;
  oNewReservation.HomeCustomer.ReservationPaymentInfo := zReservationInfo.PMInfo                ;//memReservationPaymentInfo.text;
  oNewReservation.HomeCustomer.ReservationGeneralInfo := zReservationInfo.Information           ;//memReservationGeneralInfo.text;

  // Below is depended on room not reservation
  oNewReservation.HomeCustomer.PcCode                 := labPriceCode.Caption                   ;//edPcCode.text;
  oNewReservation.HomeCustomer.IsGroupInvoice         := chkIsGroupInvoice.Checked              ;//chkIsGroupInvoice.checked;
  oNewReservation.HomeCustomer.ShowDiscountOnInvoice  := false                                  ;//chkShowDiscountOnInvoice.Checked;
  oNewReservation.HomeCustomer.isRoomResDiscountPrec  := true                                   ;//cbxIsRoomResDiscountPrec.ItemIndex=0;
  oNewReservation.HomeCustomer.RoomResDiscount        := 0                                      ; //edRoomResDiscount.Value;


  kbmRoomRates.SortFields := 'RoomReservation;RateDate';;
  kbmRoomRates.sort([]);

  oNewReservation.newRoomReservations.RoomItemsList.Clear;
  roomIndex := 0;
  kbmRoomRes.first;

  while not kbmRoomRes.eof do
  begin
    Room            := kbmRoomRes.FieldByName('Room').asString;
    RoomType        := kbmRoomRes.FieldByName('RoomType').asString;
    Arrival         := kbmRoomRes.FieldByName('Arrival').AsDateTime;
    Departure       := kbmRoomRes.FieldByName('Departure').AsDateTime;
    GuestCount      := kbmRoomRes.FieldByName('Guests').AsInteger;
    RoomReservation := kbmRoomRes.FieldByName('RoomReservation').AsInteger;
    AvragePrice     := kbmRoomRes.FieldByName('AvragePrice').AsFloat  ;
    AvrageDiscount  := kbmRoomRes.FieldByName('AvrageDiscount').AsFloat  ;
    RateCount       := kbmRoomRes.FieldByName('RateCount').AsInteger;
    ChildrenCount   := kbmRoomRes.FieldByName('ChildrenCount').AsInteger;
    infantCount     := kbmRoomRes.FieldByName('infantCount').AsInteger;
    PriceCode       := kbmRoomRes.FieldByName('PriceCode').AsString;
    isPercentage    := kbmRoomRes.FieldByName('isPercentage').AsBoolean;
    mainGuestName   := kbmRoomRes.FieldByName('MainGuest').AsString;


    oSelectedRoomItem := TnewRoomReservationItem.Create(RoomReservation,Room,RoomType,'',Arrival,departure,guestCount,AvragePrice,AvrageDiscount,isPercentage,RateCount,ChildrenCount,infantCount,priceCode,mainGuestName,'');
    oNewReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
    oNewReservation.newRoomReservations.RoomItemsList[roomIndex].oRates.SetCurrency(labCurrency.caption);

    kbmRoomRates.Filter := '(Roomreservation='+inttostr(roomreservation)+')';
    kbmRoomRates.Filtered := true;

    kbmRoomRates.First;
    while not kbmRoomRates.eof do
    begin
      rateRoomNumber   := kbmRoomRates.FieldByName('RoomNumber').AsString;
      rateDate         := kbmRoomRates.FieldByName('RateDate').AsdateTime;
      rate             := kbmRoomRates.FieldByName('rate').AsFloat;
      ratePriceCode    := kbmRoomRates.FieldByName('PriceCode').AsString;
      rateDiscount     := kbmRoomRates.FieldByName('Discount').AsFloat;
      rateIsPercentage := kbmRoomRates.FieldByName('isPercentage').AsBoolean;
      rateShowDiscount := kbmRoomRates.FieldByName('ShowDiscount').AsBoolean;
      rateIsPaid       := kbmRoomRates.FieldByName('isPaid').AsBoolean;
      rateItem := TRateItem.Create(rate,rateDate,rateDiscount,rateShowDiscount,rateIsPercentage,rateisPaid,ratePriceCode,rateRoomNumber,-1,roomreservation);
      oNewReservation.newRoomReservations.RoomItemsList[roomIndex].oRates.RateItemsList.Add(rateItem);
      kbmRoomRates.Next;
    end;
    inc(roomIndex);
    kbmRoomRes.next;
  end;


////////////////////////////////////////////////////////////////////
///
///
///  ///////////////////////////////////////////////////////////////
///



  if zRestCount > 0 then
  begin
    oRestReservation.HomeCustomer.Customer               := Customer;

    oRestReservation.HomeCustomer.GuestName              := ''                                     ;//edGuestName.text;
    oRestReservation.HomeCustomer.invRefrence            := zReservationInfo.invRefrence           ;//edinvRefrence.Text;
    oRestReservation.HomeCustomer.Country                := zReservationInfo.Country               ;//edCountry.text;
    oRestReservation.HomeCustomer.ReservationName        := zReservationInfo.Name                  ;//edReservationName.text;
    oRestReservation.HomeCustomer.RoomStatus             := zResFlag                               ;//RoomstatusToInfo(cbxRoomStatus.ItemIndex);
    oRestReservation.HomeCustomer.MarketSegmentCode      := zReservationInfo.MarketSegment         ;//edMarketSegmentCode.text;
    oRestReservation.HomeCustomer.Currency               := labCurrency.Caption                    ;//edCurrency.text;
    oRestReservation.HomeCustomer.PID                    := zReservationInfo.custPID             ;//edPID.text ;
    oRestReservation.HomeCustomer.CustomerName           := zReservationInfo.name ;//.CustomerName          ;// edCustomerName.text ;
    oRestReservation.HomeCustomer.Address1               := zReservationInfo.Address1              ;//edAddress1.text ;
    oRestReservation.HomeCustomer.Address2               := zReservationInfo.Address2              ;//edAddress2.text ;
    oRestReservation.HomeCustomer.Address3               := zReservationInfo.Address3              ;//edAddress3.text ;
    oRestReservation.HomeCustomer.Tel1                   := zReservationInfo.Tel1                  ;//edTel1.text     ;
    oRestReservation.HomeCustomer.Tel2                   := zReservationInfo.Tel2                  ;//edTel2.text     ;
    oRestReservation.HomeCustomer.Fax                    := zReservationInfo.Fax                   ;//edFax.text      ;
    oRestReservation.HomeCustomer.EmailAddress           := zReservationInfo.CustomerEmail         ;//edEmailAddress.text ;
    oRestReservation.HomeCustomer.HomePage               := zReservationInfo.CustomerWebSite       ;//edHomePage.text     ;
    oRestReservation.HomeCustomer.ContactPhone           := zReservationInfo.ContactPhone          ;//edContactPhone.text ;
    oRestReservation.HomeCustomer.ContactPerson          := zReservationInfo.ContactName           ;//edContactPerson.text;
    oRestReservation.HomeCustomer.ContactFax             := zReservationInfo.ContactFax            ;//edContactFax.text   ;
    oRestReservation.HomeCustomer.ContactEmail           := zReservationInfo.ContactEmail          ;//edContactEmail.text ;
    oRestReservation.HomeCustomer.ReservationPaymentInfo := zReservationInfo.PMInfo                ;//memReservationPaymentInfo.text;
    oRestReservation.HomeCustomer.ReservationGeneralInfo := zReservationInfo.Information           ;//memReservationGeneralInfo.text;

    // Below is depended on room not reservation
    oRestReservation.HomeCustomer.PcCode                 := labPriceCode.Caption                   ;//edPcCode.text;
    oRestReservation.HomeCustomer.IsGroupInvoice         := zAllotmentIsGroupInvoice               ;//chkIsGroupInvoice.checked;
    oRestReservation.HomeCustomer.ShowDiscountOnInvoice  := false                                  ;//chkShowDiscountOnInvoice.Checked;
    oRestReservation.HomeCustomer.isRoomResDiscountPrec  := true                                   ;//cbxIsRoomResDiscountPrec.ItemIndex=0;
    oRestReservation.HomeCustomer.RoomResDiscount        := 0                                      ; //edRoomResDiscount.Value;


    kbmRestRoomRates.SortFields := 'RoomReservation;RateDate';;
    kbmRestRoomRates.sort([]);

    oRestReservation.newRoomReservations.RoomItemsList.Clear;
    roomIndex := 0;
    kbmRestRoomRes.first;

    while not kbmRestRoomRes.eof do
    begin
      Room            := kbmRestRoomRes.FieldByName('Room').asString;
      RoomType        := kbmRestRoomRes.FieldByName('RoomType').asString;
      Arrival         := kbmRestRoomRes.FieldByName('Arrival').AsDateTime;
      Departure       := kbmRestRoomRes.FieldByName('Departure').AsDateTime;
      GuestCount      := kbmRestRoomRes.FieldByName('Guests').AsInteger;
      RoomReservation := kbmRestRoomRes.FieldByName('RoomReservation').AsInteger;
      AvragePrice     := kbmRestRoomRes.FieldByName('AvragePrice').AsFloat  ;
      AvrageDiscount  := kbmRestRoomRes.FieldByName('AvrageDiscount').AsFloat  ;
      RateCount       := kbmRestRoomRes.FieldByName('RateCount').AsInteger;
      ChildrenCount   := kbmRestRoomRes.FieldByName('ChildrenCount').AsInteger;
      infantCount     := kbmRestRoomRes.FieldByName('infantCount').AsInteger;
      PriceCode       := kbmRestRoomRes.FieldByName('PriceCode').AsString;
      isPercentage    := kbmRestRoomRes.FieldByName('isPercentage').AsBoolean;
      mainGuestName   := kbmRestRoomRes.FieldByName('MainGuest').AsString;


      oSelectedRoomItem := TnewRoomReservationItem.Create(RoomReservation,Room,RoomType,'',Arrival,departure,guestCount,AvragePrice,AvrageDiscount,isPercentage,RateCount,ChildrenCount,infantCount,priceCode,mainGuestName,'');
      oRestReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
      oRestReservation.newRoomReservations.RoomItemsList[roomIndex].oRates.SetCurrency(labCurrency.caption);

      kbmRestRoomRates.Filter := '(Roomreservation='+inttostr(roomreservation)+')';
      kbmRestRoomRates.Filtered := true;

      kbmRestRoomRates.First;
      while not kbmRestRoomRates.eof do
      begin
        rateRoomNumber   := kbmRestRoomRates.FieldByName('RoomNumber').AsString;
        rateDate         := kbmRestRoomRates.FieldByName('RateDate').AsdateTime;
        rate             := kbmRestRoomRates.FieldByName('rate').AsFloat;
        ratePriceCode    := kbmRestRoomRates.FieldByName('PriceCode').AsString;
        rateDiscount     := kbmRestRoomRates.FieldByName('Discount').AsFloat;
        rateIsPercentage := kbmRestRoomRates.FieldByName('isPercentage').AsBoolean;
        rateShowDiscount := kbmRestRoomRates.FieldByName('ShowDiscount').AsBoolean;
        rateIsPaid       := kbmRestRoomRates.FieldByName('isPaid').AsBoolean;
        rateItem := TRateItem.Create(rate,rateDate,rateDiscount,rateShowDiscount,rateIsPercentage,rateisPaid,ratePriceCode,rateRoomNumber,-1,roomreservation);
        oRestReservation.newRoomReservations.RoomItemsList[roomIndex].oRates.RateItemsList.Add(rateItem);
        kbmRestRoomRates.Next;
      end;
      inc(roomIndex);
      kbmRestRoomRes.next;
    end;
  end;

end;



function TfrmAllotmentToRes.AddRestRoomRservation(Roomreservation : integer) : boolean;
var
  Room                : string; //*
  RoomType            : string; //*
  Guests              : integer;//
  RateCount           : integer;//
  RoomDescription     : String ;
  RoomTypeDescription : string ;
  Arrival             : TDate  ;//*
  Departure           : TDate  ;//*
  ChildrenCount       : Integer;//
  InfantCount         : Integer;//
  PriceCode           : String ;//*
  AvrageDiscount      : double ;//
  isPercentage        : boolean;//*
  MainGuest           : string ;//*

  ttPrice        : double;
  ttDiscount     : Double;
  ttPriceCount   : integer;
  ttNetPrice     : double;
  AvrageNetPrice : double ;//


  sFilter : string;
  tmpArrival : Tdate;
  tmpDeparture : Tdate;

  roomRate : double;
  discount : double;

  lstPrices        : TstringList;

  DiscountAmount : double;
  RentAmount     : double;
  NativeAmount   : double;

  currencyRate   : double;
  currency : string;
  oSelectedRoomItem : TnewRoomReservationItem;
begin
  result := false;

  lstPrices := TstringList.Create;
  try
    lstPrices.Sorted := true;
    lstPrices.Duplicates := dupIgnore;

    screen.Cursor := crHourGlass;
    mRRinfo.DisableControls;
    kbmRestRoomres.DisableControls;
    kbmRestRoomRates.DisableControls;
    try
      sFilter :='(processed='+inttostr(roomreservation)+')';

      mRRinfo.Filter   := sFilter;
      mRRinfo.Filtered := true;
      mRRinfo.First;

      RoomDescription     := mRRinfo.fieldbyname('RoomDescription').asstring;
      RoomTypeDescription := mRRinfo.fieldbyname('RoomDescription').asstring;
      MainGuest           := mRRinfo.fieldbyname('MainGuest').asstring;
      isPercentage        := mRRinfo.fieldbyname('isPercentage').asBoolean;
      PriceCode           := mRRinfo.fieldbyname('PriceCode').asstring;

      Guests         := mRRinfo.fieldbyname('numGuests').asinteger;
      ChildrenCount  := mRRinfo.fieldbyname('numChildren').asinteger;
      InfantCount    := mRRinfo.fieldbyname('numInfants').asinteger;

      RoomReservation := mRRinfo.FieldByName('Processed').asInteger;
      Room            := mRRinfo.FieldByName('Room').asString;
      if room         = '' then room := '<'+inttostr(roomReservation)+'>';
      RoomType        := mRRinfo.FieldByName('RoomType').asString;

      ttPrice      := 0.00;
      ttDiscount   := 0.00;
      ttPriceCount := 0;

      currency      := labCurrency.caption;
      CurrencyRate  := hData.GetRate(currency);

      tmpDeparture := 0;
      Departure := tmpDeparture;
      tmpArrival:= date+10000;
      Arrival := tmpArrival;
      mRRinfo.First;
      while not mRRinfo.eof do
      begin
        roomRate := mRRinfo.FieldByName('roomrate').asFloat;
        discount := mRRinfo.FieldByName('discount').asFloat;

        lstPrices.Add(floatTostr(RoomRate));
        ttPriceCount := ttPriceCount+1;
        ttPrice      := ttPrice   + RoomRate;
        ttDiscount   := ttDiscount+ discount;

        if tmpArrival >= mRRinfo.FieldByName('dtDate').asDateTime then
          arrival :=  mRRinfo.FieldByName('dtDate').asDateTime;
        if tmpDeparture <= mRRinfo.FieldByName('dtDate').asDateTime then
          departure := mRRinfo.FieldByName('dtDate').asDateTime;

        tmpArrival   := Arrival;
        tmpDeparture := Departure;

        mRRinfo.Next;
      end;

      AvrageDiscount := 0;
      if ttPriceCount <> 0 then
      begin
        AvrageDiscount := ttDiscount/ttPriceCount;
      end;

      rateCount := lstPrices.Count;
      Departure := departure+1;

      ttNetPrice := 0;
      mRRinfo.First;
      while not mRRinfo.eof do
      begin
        roomRate     := mRRinfo.FieldByName('RoomRate').asFloat;
        discount     := mRRinfo.FieldByName('Discount').asFloat;
        isPercentage := mRRinfo.FieldByName('isPercentage').asBoolean;

        DiscountAmount := 0;

        if roomrate <> 0 then
        begin
          if discount <> 0 then
          begin
            if isPercentage then
            begin
              DiscountAmount :=  RoomRate*discount/100;
            end else
            begin
              DiscountAmount := discount;
            end;
          end;
        end;
        RentAmount  := roomRate-DiscountAmount;
        if currencyRate = 0 then currencyRate := 1;
        NativeAmount := RentAmount*CurrencyRate;

        ttNetPrice := ttNetPrice+RentAmount;

        kbmRestRoomRates.Append;
        kbmRestRoomRates.FieldByName('Reservation').AsInteger       := mRRinfo.FieldByName('Reservation').asInteger;
        kbmRestRoomRates.FieldByName('RoomReservation').AsInteger   := mRRinfo.FieldByName('Processed').asInteger;
        kbmRestRoomRates.FieldByName('RoomNumber').AsString         := mRRinfo.FieldByName('Room').asString;
        kbmRestRoomRates.FieldByName('RateDate').AsDateTime         := mRRinfo.FieldByName('dtDate').asDateTime;
        kbmRestRoomRates.FieldByName('PriceCode').AsString          := mRRinfo.FieldByName('PriceCode').asString;
        kbmRestRoomRates.FieldByName('Rate').AsFloat                := Roomrate;
        kbmRestRoomRates.FieldByName('Discount').AsFloat            := discount;
        kbmRestRoomRates.FieldByName('isPercentage').AsBoolean      := isPercentage;
        kbmRestRoomRates.FieldByName('ShowDiscount').AsBoolean      := mRRinfo.FieldByName('Showdiscount').asBoolean;
        kbmRestRoomRates.FieldByName('isPaid').AsBoolean            := false;
        kbmRestRoomRates.FieldByName('DiscountAmount').AsFloat      := discountAmount;
        kbmRestRoomRates.FieldByName('RentAmount').AsFloat          := rentAmount;
        kbmRestRoomRates.FieldByName('NativeAmount').AsFloat        := NativeAmount;
        kbmRestRoomRates.Post;
        mRRinfo.Next;
      end;

      AvrageNetPrice := 0;
      if ttPriceCount <> 0 then
      begin
        AvrageNetPrice := ttnetPrice/ttPriceCount;
      end;


      kbmRestRoomres.Append;
      kbmRestRoomres.FieldByName('RoomReservation').AsInteger    :=RoomReservation     ;
      kbmRestRoomres.FieldByName('Room').AsString                :=Room                ;
      kbmRestRoomres.FieldByName('RoomType').AsString            :=RoomType            ;
      kbmRestRoomres.FieldByName('Guests').Asinteger             :=Guests              ;
      kbmRestRoomres.FieldByName('AvragePrice').AsFloat          :=AvrageNetPrice      ;
      kbmRestRoomres.FieldByName('RateCount').Asinteger          :=RateCount           ;
      kbmRestRoomres.FieldByName('RoomDescription').AsString     :=RoomDescription     ;
      kbmRestRoomres.FieldByName('RoomTypeDescription').Asstring :=RoomTypeDescription ;
      kbmRestRoomres.FieldByName('Arrival').AsDateTime           :=Arrival             ;
      kbmRestRoomres.FieldByName('Departure').AsDateTime         :=Departure           ;
      kbmRestRoomres.FieldByName('ChildrenCount').AsInteger      :=ChildrenCount       ;
      kbmRestRoomres.FieldByName('InfantCount').AsInteger        :=InfantCount         ;
      kbmRestRoomres.FieldByName('PriceCode').AsString           :=PriceCode           ;
      kbmRestRoomres.FieldByName('AvrageDiscount').AsFloat       :=AvrageDiscount      ;
      kbmRestRoomres.FieldByName('isPercentage').Asboolean       :=isPercentage        ;
      kbmRestRoomres.FieldByName('MainGuest').Asstring           :=MainGuest           ;
      kbmRestRoomres.Post;

      oSelectedRoomItem := TnewRoomReservationItem.Create(RoomReservation,Room,RoomType,'',Arrival,departure,Guests,AvrageNetPrice,AvrageDiscount,isPercentage,RateCount,childrenCount,infantCount,PriceCode,MainGuest,'');
      oRestReservation.newRoomReservations.RoomItemsList.Add(oSelectedRoomItem);
      mRRinfo.Filtered := false;
    finally
      kbmRestRoomres.EnableControls;
      kbmRestRoomRates.EnableControls;
      mRRinfo.EnableControls;
      screen.Cursor := crDefault;
    end;
  finally
    freeandnil(lstPrices);
  end;
end;


function TfrmAllotmentToRes.RoomsInAllotment : integer;
var
  iRow,iCol    : integer;
  sCellContent : string ;
  RoomCount    : integer;
begin
  result := 0;
  for iRow := cCountFixedRows to grProvide.RowCount - 1 do
  begin
    for iCol := cCountFixedCols to grProvide.ColCount - 1 do
    begin
      sCellContent := trim(grProvide.cells[iCol, iRow]);
      if sCellContent <> '' then
      begin
        RoomCount := 0;
        if grProvide.Objects[iCol, iRow] <> nil then
        begin
          RoomCount := (grProvide.Objects[iCol, iRow] as TresCell).RoomCount;
        end;
        Result := Result + RoomCount;
      end;
    end;
  end;
  labRooms.Caption := inttostr(result);
end;


function TfrmAllotmentToRes.CalcOnePrice(roomreservation : integer; NewRate : double=0) : boolean;
var
  lstPrices       : Tstringlist;
//  RoomReservation : integer;

  i,ii : integer;

  room                : string   ;
  RoomType            : string;
  Guests              : integer  ;
  AvragePrice         : double   ;
  RateCount           : integer;
  RoomDescription     : string;
  RoomTypeDescription : string;
  Arrival             : TdateTime;
  Departure           : TDateTime;
  ChildrenCount       : integer;
  infantCount         : integer;
  DiscountAmount      : double;
  RentAmount          : double;
  NativeAmount        : double;

  priceID       : integer;
  priceCode     : string ;

  rateTotal     : double;
  rateAvrage    : double;

  discountTotal     : double;
  discountAvrage    : double;

  dayCount      : integer;
  aDate         : TDateTime;

  RateDate      : TdateTime    ;
  rate          : Double;

  IsPercentage  : Boolean ;
  IsPaid        : Boolean ;

  Currency      : string  ;
  CurrencyRate  : Double  ;
  Discount      : Double  ;
  showDiscount  : boolean ;
  found : boolean;


begin
  IsPaid := False;
  lstPrices := TstringList.Create;
  try
    lstPrices.Sorted := true;
    lstPrices.Duplicates := dupIgnore;

    currency      := labCurrency.caption;
    CurrencyRate  := hData.GetRate(currency);
//    discount      := edRoomResDiscount.Value;
    showDiscount  := false;
    isPercentage  := true;

    if kbmRoomRes.locate('roomreservation',roomreservation,[]) then
    begin
      repeat
        found :=  kbmRoomRates.Locate('roomreservation',roomreservation,[]);
        if found then
        begin
          kbmRoomRates.Delete;
        end;
      until not found;

      i := oNewReservation.newRoomReservations.FindRoomFromRoomReservation(RoomReservation,0);
      oNewReservation.newRoomReservations.RoomItemsList[i].oRates.RateItemsList.Clear;

      room                := kbmRoomRes.FieldByName('room').AsString                ;
      arrival             := kbmRoomRes.FieldByName('arrival').AsDateTime           ;
      departure           := kbmRoomRes.FieldByName('departure').AsDateTime         ;
      RoomType            := kbmRoomRes.FieldByName('RoomType').AsString            ;
      RoomTypeDescription := kbmRoomRes.FieldByName('RoomTypeDescription').AsString ;
      RoomDescription     := kbmRoomRes.FieldByName('RoomDescription').AsString     ;
      Guests              := kbmRoomRes.FieldByName('Guests').AsInteger             ;
      ChildrenCount       := kbmRoomRes.FieldByName('ChildrenCount').AsInteger      ;
      InfantCount         := kbmRoomRes.FieldByName('infantCount').AsInteger        ;
      discount            := kbmRoomRes.FieldByName('avrageDiscount').AsFloat             ;

      PriceCode           := trim(labPriceCode.caption);
      PriceID             := hdata.PriceCode_ID(priceCode);

      dayCount := trunc(departure)-trunc(arrival);
      aDate     := trunc(Arrival);
      rateTotal := 0;
      discountTotal := 0;
      lstPrices.Clear;
      for ii := 0  to dayCount-1 do
      begin
        if (newRate <> 0) then
        begin
          rate     := NewRate;
          discount := 0;
        end else
        begin
          Rate :=  oNewReservation.newRoomReservations.RoomItemsList[i].oRates.GetDayRate
                     (RoomType
                     ,Room
                     ,aDate
                     ,guests
                     ,ChildrenCount
                     ,infantCount
                     ,currency
                     ,PriceID
                     ,discount
                     ,showDiscount
                     ,isPercentage
                     ,isPaid
                     ,false
                     
                      );
        end;



        DiscountAmount := 0;
        if rate <> 0 then
        begin
          if discount <> 0 then
          begin
            if isPercentage then
            begin
              DiscountAmount :=  Rate*discount/100;
            end else
            begin
              DiscountAmount := discount;
            end;
          end;
        end;
        RentAmount  := Rate-DiscountAmount;
        if currencyRate = 0 then currencyRate := 1;
        NativeAmount := RentAmount*CurrencyRate;

        kbmRoomRates.append;
        kbmRoomRates.FieldByName('Reservation').AsInteger := -1;
        kbmRoomRates.FieldByName('RoomReservation').AsInteger := Roomreservation;
        kbmRoomRates.FieldByName('RoomNumber').AsString := Room;
        kbmRoomRates.FieldByName('RateDate').AsDateTime := aDate;
        kbmRoomRates.FieldByName('PriceCode').AsString := PriceCode;
        kbmRoomRates.FieldByName('Rate').AsFloat := Rate;
        kbmRoomRates.FieldByName('Discount').AsFloat := Discount;
        kbmRoomRates.FieldByName('isPercentage').AsBoolean := isPercentage;
        kbmRoomRates.FieldByName('ShowDiscount').AsBoolean := ShowDiscount;
        kbmRoomRates.FieldByName('isPaid').AsBoolean := isPaid;
        kbmRoomRates.FieldByName('DiscountAmount').AsFloat := DiscountAmount;
        kbmRoomRates.FieldByName('RentAmount').AsFloat := RentAmount;
        kbmRoomRates.FieldByName('NativeAmount').AsFloat := NativeAmount;
        kbmRoomRates.post;

        lstPrices.Add(floattostr(RentAmount));
        rateTotal := RateTotal+RentAmount;
        discountTotal := discountTotal+discount;
        aDate := aDate+1
      end;

      rateAvrage := 0;
      discountAvrage := 0;

      if dayCount <> 0 then
      begin
        rateAvrage := rateTotal/dayCount;
        discountAvrage := discountTotal/dayCount
      end;
      rateCount := lstPrices.Count;
      kbmRoomRes.edit;
        kbmRoomRes.FieldByName('AvragePrice').AsFloat := rateAvrage;
        kbmRoomRes.FieldByName('RateCount').AsFloat := rateCount;
        kbmRoomRes.FieldByName('AvrageDiscount').AsFloat := discountAvrage;
        kbmRoomRes.FieldByName('isPercentage').AsBoolean := isPercentage;
      kbmRoomRes.Post;
    end;
  finally
    freeandNil(lstPrices);
  end;
end;


procedure TfrmAllotmentToRes.btnReCalcClick(Sender: TObject);
var
   RoomReservation : integer;
begin
  RoomReservation := kbmRoomRes.FieldByName('Roomreservation').AsInteger;
  CalcOnePrice(roomreservation);
end;

procedure TfrmAllotmentToRes.btnReclacAllPricesClick(Sender: TObject);
begin
  ReclacAllPrices;
end;


procedure TfrmAllotmentToRes.ReclacAllPrices;
var
   RoomReservation : integer;
begin
  kbmRoomres.First;
  while not kbmRoomres.eof do
  begin
    RoomReservation := kbmRoomRes.FieldByName('Roomreservation').AsInteger;
    CalcOnePrice(roomreservation);
    kbmRoomres.Next;
  end;
end;


end.

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

