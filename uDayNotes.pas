unit uDayNotes;


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
  StdCtrls,
  shellapi,
  Grids,
  ComCtrls,
  ExtCtrls,
  DB,
  Menus,
  ADODB,
  Mask,

  _glob,
  hData,
  uStringUtils,
  ug,


  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxDBData,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  cxContainer,
  cxLabel,
  cxTextEdit,
  cxMaskEdit,
  cxSpinEdit,
  cxGridExportLink,
  cxSplitter,
  dxmdaset,
  cxButtons,
  cxCustomPivotGrid,
  cxDBPivotGrid,
  cxPC,
  cxMemo,
  cxDBEdit,
  cxPCdxBarPopupMenu,
  cxExportPivotGridLink,
  cxNavigator


//  , datelbl
//  , AdvEdit
//  , AdvEdBtn
//  , PlannerDatePicker

  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, sPageControl, sMemo, sLabel, sPanel, sEdit, sSpinEdit, sButton,
  cxDateUtils, cxDropDownEdit, cxCalendar, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxPropertiesStore, AdvEdit, AdvEdBtn, PlannerDatePicker, datelbl, sGroupBox, sMaskEdit,
  sCustomComboEdit, sTooledit, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue


  ;

type
  TfrmDayNotes = class(TForm)
    LMDStatusBar1: TStatusBar;
    pageMain: TsPageControl;
    tabDayNotes: TsTabSheet;
    mCurrentGuestsDS: TDataSource;
    tabLog: TsTabSheet;
    Panel1: TsPanel;
    tabStatus: TsTabSheet;
    Panel3: TsPanel;
    edRefresh : TEdit;
    edDaysToShow: TsSpinEdit;
    cxLabel1: TsLabel;
    labCol: TsLabel;
    tabCurrentGuests: TsTabSheet;
    Panel2: TsPanel;
    gridCurrentGuestsDBTableView1: TcxGridDBTableView;
    gridCurrentGuestsLevel1: TcxGridLevel;
    gridCurrentGuests: TcxGrid;
    mCurrentGuests_: TdxMemData;
    mCurrentGuests_Room: TStringField;
    mCurrentGuests_RoomType: TStringField;
    mCurrentGuests_RoomReservation: TIntegerField;
    mCurrentGuests_Reservation: TIntegerField;
    mCurrentGuests_StatusText: TStringField;
    mCurrentGuests_GuestName: TStringField;
    mCurrentGuests_Arrival: TDateField;
    mCurrentGuests_Departure: TDateField;
    mCurrentGuests_RoomTypeDescription: TStringField;
    mCurrentGuests_GuestCountry: TStringField;
    mCurrentGuests_isMainGuest: TBooleanField;
    mCurrentGuests_location: TStringField;
    gridCurrentGuestsDBTableView1RecId: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1Room: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1RoomType: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1RoomReservation: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1Reservation: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1StatusText: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1GuestName: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1GuestCountry: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1Arrival: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1Departure: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1RoomTypeDescription: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1isMainGuest: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1location: TcxGridDBColumn;
    mCurrentGuests_Customer: TStringField;
    mCurrentGuests_CustomerName: TStringField;
    mCurrentGuests_ReservationName: TStringField;
    mCurrentGuests_RoomDescription: TStringField;
    mCurrentGuests_Floor: TIntegerField;
    gridCurrentGuestsDBTableView1RoomDescription: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1Floor: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1Customer: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1CustomerName: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1ReservationName: TcxGridDBColumn;
    mCurrentGuests_customerPID: TStringField;
    gridCurrentGuestsDBTableView1customerPID: TcxGridDBColumn;
    mCurrentGuests_GuestCount: TIntegerField;
    gridCurrentGuestsDBTableView1GuestCount: TcxGridDBColumn;
    cxLabel3: TsLabel;
    cxLabel4: TsLabel;
    labStatusDateFrom: TsLabel;
    labStatusDateTo: TsLabel;
    mCurrentGuests_NightsTotal: TIntegerField;
    mCurrentGuests_NightsFromArrival: TIntegerField;
    mCurrentGuests_NightsUntilDeparture: TIntegerField;
    gridCurrentGuestsDBTableView1NightsTotal: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1NightsFromArrival: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1NightsUntilDeparture: TcxGridDBColumn;
    mCurrentGuests_Groupaccount: TBooleanField;
    mCurrentGuests_breakfast: TBooleanField;
    gridCurrentGuestsDBTableView1Groupaccount: TcxGridDBColumn;
    gridCurrentGuestsDBTableView1breakfast: TcxGridDBColumn;
    btnGetCurrentGuestsRefresh: TsButton;
    btnRrToExcel: TsButton;
    btnRrShowReservation: TsButton;
    cxButton4: TsButton;
    cxButton2: TsButton;
    mnuFinishedInv: TPopupMenu;
    mnuThisRoom: TMenuItem;
    mnuThisreservation: TMenuItem;
    OpenthisRoom1: TMenuItem;
    OpenGroupInvoice1: TMenuItem;
    cxButton1: TsButton;
    cxPageControl1: TcxPageControl;
    pageLog: TcxPageControl;
    tabActionLog: TcxTabSheet;
    tabImportLog: TcxTabSheet;
    memLog: TsMemo;
    Panel5: TsPanel;
    Panel6: TsPanel;
    Panel7: TsPanel;
    gridImportLogs: TcxGrid;
    gridImportLogsDBTableView1: TcxGridDBTableView;
    gridImportLogsLevel1: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    Panel8: TsPanel;
    Panel9: TsPanel;
    Panel10: TsPanel;
    memImportData: TsMemo;
    cxSplitter2: TcxSplitter;
    Panel11: TsPanel;
    Panel12: TsPanel;
    InportLogsDS_: TDataSource;
    ImportLogsDS: TDataSource;
    cxDBMemo1: TcxDBMemo;
    mImportLog: TdxMemData;
    mImportLogID: TIntegerField;
    mImportLogDateInsert: TDateTimeField;
    mImportLogImportTypeID: TIntegerField;
    memImportTypesDS: TDataSource;
    mImportLogImportType: TStringField;
    gridImportLogsDBTableView1RecId: TcxGridDBColumn;
    gridImportLogsDBTableView1ID: TcxGridDBColumn;
    gridImportLogsDBTableView1DateInsert: TcxGridDBColumn;
    gridImportLogsDBTableView1ImportTypeID: TcxGridDBColumn;
    gridImportLogsDBTableView1ImportType: TcxGridDBColumn;
    dtImportLogDate: TsDateEdit;
    mImportLogImportData: TMemoField;
    cxButton5: TsButton;
    mImportLogDateExport: TDateTimeField;
    gridImportLogsDBTableView1DateExport: TcxGridDBColumn;
    mImportLogImportResultId: TIntegerField;
    mImportLogReservation: TIntegerField;
    mImportLogRoomreservation: TIntegerField;
    mImportLogCustomer: TStringField;
    mImportLogItemcount: TIntegerField;
    mImportLogHotelCode: TStringField;
    mImportLogStaff: TStringField;
    mImportLogRoomNumber: TStringField;
    mImportLogisGroupInvoice: TBooleanField;
    mImportLoginvCustomer: TStringField;
    mImportLoginvPersonalID: TStringField;
    mImportLoginvCustomerName: TStringField;
    mImportLogInvAddress1: TStringField;
    mImportLoginvAddress2: TStringField;
    mImportLoginvAddress3: TStringField;
    mImportLoginvAddress4: TStringField;
    mImportLogGuestName: TStringField;
    mImportLogSaleRefrence: TStringField;
    gridImportLogsDBTableView1ImportResultId: TcxGridDBColumn;
    gridImportLogsDBTableView1ImportResult: TcxGridDBColumn;
    gridImportLogsDBTableView1Reservation: TcxGridDBColumn;
    gridImportLogsDBTableView1RoomReservation: TcxGridDBColumn;
    gridImportLogsDBTableView1Customer: TcxGridDBColumn;
    gridImportLogsDBTableView1ItemCount: TcxGridDBColumn;
    gridImportLogsDBTableView1HotelCode: TcxGridDBColumn;
    gridImportLogsDBTableView1Staff: TcxGridDBColumn;
    gridImportLogsDBTableView1RoomNumber: TcxGridDBColumn;
    gridImportLogsDBTableView1isGroupInvoice: TcxGridDBColumn;
    gridImportLogsDBTableView1invCustomer: TcxGridDBColumn;
    gridImportLogsDBTableView1invPersonalID: TcxGridDBColumn;
    gridImportLogsDBTableView1invCustomerName: TcxGridDBColumn;
    gridImportLogsDBTableView1InvAddress1: TcxGridDBColumn;
    gridImportLogsDBTableView1invAddress2: TcxGridDBColumn;
    gridImportLogsDBTableView1invAddress3: TcxGridDBColumn;
    gridImportLogsDBTableView1invAddress4: TcxGridDBColumn;
    gridImportLogsDBTableView1SaleRefrence: TcxGridDBColumn;
    gridImportLogsDBTableView1GuestName: TcxGridDBColumn;
    mImportLogImportResult: TStringField;
    cxButton6: TsButton;
    cxLabel5: TsLabel;
    edImportLogDaysToShow: TsSpinEdit;
    cxLabel6: TsLabel;
    cxLabel7: TsLabel;
    cxLabel8: TsLabel;
    cxLabel9: TsLabel;
    cxButton10: TsButton;
    cxButton11: TsButton;
    cxButton12: TsButton;
    cxButton13: TsButton;
    cxButton14: TsButton;
    cxButton15: TsButton;
    mImportLoginvoiceNumber: TIntegerField;
    gridImportLogsDBTableView1invoiceNumber: TcxGridDBColumn;
    DateLabel1: TDateLabel;
    Panel4: TsPanel;
    cxButton7: TsButton;
    pivStatus: TcxDBPivotGrid;
    cxDBPivotGrid1resDate: TcxDBPivotGridField;
    cxDBPivotGrid1RoomType: TcxDBPivotGridField;
    cxDBPivotGrid1Description: TcxDBPivotGridField;
    cxDBPivotGrid1available: TcxDBPivotGridField;
    cxDBPivotGrid1RoomTypeGroup: TcxDBPivotGridField;
    m_: TdxMemData;
    m_RoomType: TStringField;
    m_aDate: TDateTimeField;
    m_RoomTypeGroup: TStringField;
    m_MaxFree: TIntegerField;
    m_occTotal: TIntegerField;
    m_occDeparted: TIntegerField;
    m_occGuest: TIntegerField;
    m_occOrder: TIntegerField;
    m_occAllotment: TIntegerField;
    m_occWaitinglist: TIntegerField;
    m_occBlocked: TIntegerField;
    m_nrDeparted: TIntegerField;
    m_nrGuest: TIntegerField;
    m_nrOrder: TIntegerField;
    m_nrAllotment: TIntegerField;
    m_nrWaitingList: TIntegerField;
    m_nrNoShow: TIntegerField;
    m_nrBlocked: TIntegerField;
    mDS: TDataSource;
    m_occNoShow: TIntegerField;
    m_nrTotal: TIntegerField;
    m_FreeRooms: TIntegerField;
    RoomStatusDS: TDataSource;
    mRoomStatus: TdxMemData;
    mRoomStatusresDate: TDateTimeField;
    mRoomStatusRoomType: TWideStringField;
    mRoomStatusDescription: TWideStringField;
    mRoomStatusNumberGuests: TIntegerField;
    mRoomStatusRoomTypeGroup: TWideStringField;
    mRoomStatusavailable: TIntegerField;
    pivStatusNumberGuests: TcxDBPivotGridField;
    btnFormatLog: TsButton;
    btnClearLog: TsButton;
    btnLogLogToClipboard: TsButton;
    sButton1: TsButton;
    sButton3: TsButton;
    sButton4: TsButton;
    FormStore: TcxPropertiesStore;
    btnRefreshPivStatus: TsButton;
    sGroupBox1: TsGroupBox;
    sWebLabel1: TsWebLabel;
    edCurrentDate: TEdit;
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure FormHide(Sender : TObject);
    procedure FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure FormKeyPress(Sender : TObject; var Key : Char);
    procedure FormDestroy(Sender : TObject);
    procedure FormCloseQuery(Sender : TObject; var CanClose : Boolean);
    procedure edRefreshChange(Sender : TObject);
    procedure edDaysToShowPropertiesChange(Sender : TObject);
    procedure edOkLevelPropertiesChange(Sender : TObject);
    procedure pageMainChange(Sender: TObject);
    procedure btnStatusLeftExcelClick(Sender: TObject);
    procedure btnStatusRightExcelClick(Sender: TObject);
    procedure btnGetCurrentGuestsRefreshClick(Sender: TObject);
    procedure btnRrToExcelClick(Sender: TObject);
    procedure btnRrShowReservationClick(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure mnuThisRoomClick(Sender: TObject);
    procedure mnuThisreservationClick(Sender: TObject);
    procedure OpenthisRoom1Click(Sender: TObject);
    procedure OpenGroupInvoice1Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
    procedure pageLogPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure cxButton5Click(Sender: TObject);
    procedure cxButton6Click(Sender: TObject);
    procedure mImportLogAfterScroll(DataSet: TDataSet);
    procedure dtImportLogDateChange(Sender: TObject);
    procedure cxButton9Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure edImportLogDaysToShowPropertiesChange(Sender: TObject);
    procedure cxButton10Click(Sender: TObject);
    procedure cxButton11Click(Sender: TObject);
    procedure cxButton13Click(Sender: TObject);
    procedure cxButton15Click(Sender: TObject);
    procedure edCurrentDateChange(Sender: TObject);
    procedure btnFormatLogClick(Sender: TObject);
    procedure btnLogLogToClipboardClick(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure btnRefreshPivStatusClick(Sender: TObject);
    procedure Panel10DblClick(Sender: TObject);
  private
    zDaysToShow : integer;
    zLeftIsExpand : boolean;
    zRightIsExpand : boolean;

    zReservation : integer;
    zRoomReservation : integer;

    zCurrentDate : TDate;

    { Private declarations }
    procedure showdates;

  public
    { Public declarations }
    v : Boolean;
    lastDate : Tdate;
    activeTab : integer;

    function xDoLog(theAction, theText : string) : string;
    procedure GetCurrentGuests(aDate : TDate);
    procedure RefreshImPortLog;
    procedure RefreshRoomStatus;
    procedure FormatLog;
    procedure ClearLog(firstLine : string);

  end;

var
  frmDayNotes : TfrmDayNotes;

implementation

uses
   uD
  ,uMain
  ,uReservationProfile
  ,uFinishedInvoices2
  ,uInvoice
  ,uGuestProfile2
  ,objPosSale
  ,uSqlDefinitions
  ,uAppGlobal

  , uDImages
  , uRoomerDefinitions
  , uReservationStateDefinitions
  ;



{$R *.dfm}

procedure TfrmDayNotes.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  pageMain.ActivePageIndex := 0;


  v := false;
  edCurrentDate.text := dateToStr(frmMain.dtdate.Date);
  lastDate := frmMain.dtDate.date;

  edDaysToShow.Value := 2;
  zDaysToShow := 2;
  zLeftIsExpand := false;
  zRightIsExpand := false;
  dtImportLogDate.Date := date;
end;

procedure TfrmDayNotes.FormShow(Sender : TObject);
begin
  if activeTab <> -1  then
     pageMain.ActivePageIndex := activeTab;

  pageLog.ActivePage := tabImportLog;
  tabActionlog.TabVisible := false;

end;

procedure TfrmDayNotes.FormHide(Sender : TObject);
begin
  // V := false;
end;

procedure TfrmDayNotes.FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  if Key = VK_ESCAPE then
    Close
  else
  if Key = vk_F11 then
  begin
    if frmDayNotes.v then
    begin
      frmDayNotes.v := false;
      frmDayNotes.hide;
    end
    else
    begin
      frmDayNotes.v := true;
      frmDayNotes.show;
    end;
  end;
end;

procedure TfrmDayNotes.FormKeyPress(Sender : TObject; var Key : Char);
begin
  // DebugMessage(inttostr(ord(key)));
end;

procedure TfrmDayNotes.GetCurrentGuests(aDate : TDate);
var
  rSet : TRoomerDataSet;

  lstRR : TstringList;
  i : integer;
  s : string;

  Room                 : string;
  RoomDescription      : string;
  RoomType             : string;
  RoomTypeDescription  : string;
  Location             : string;
  Floor                : string;
  GuestName            : string;
  GuestCountry         : string;
  Arrival              : Tdate;
  Departure            : TDate;
  isMainGuest          : boolean;
  Customer             : string;
  CustomerName         : string;
  CustomerPID          : string;
  ReservationName      : string;
  StatusText           : String;
  GuestCount           : integer;

  rCount : integer;

  Person               : integer;
  Reservation          : integer;
  RoomReservation      : integer;
  Status               : string;

  NightsTotal          : Integer;
  NightsFromArrival    : integer;
  NightsUntilDeparture : integer;

  GroupAccount : boolean;
  Breakfast    : boolean;


begin
  mCurrentGuests_.DisableControls;
  try
    rSet := CreateNewDataSet;
    try
      
      rSet.CommandType := cmdText;

      if mCurrentGuests_.Active then mCurrentGuests_.Close;

      mCurrentGuests_.Open;

      lstRR := d.lstRR_CurrentlyCheckedIn(aDate);
      try
        for i := 0 to lstRR.Count - 1 do
        begin
        // use the list;
          roomReservation := strToInt(lstRR[i]);
          //rSet := SP_GET_GuestsInfoByRoomReservation(RoomReservation);
          rSet := CreateNewDataSet;
          try
            s := format(select_GuestsInfoByRoomReservation, [RoomReservation]);
            if hData.rSet_bySQL(rSet,s) then
            begin
              rSet.First;
              GuestCount := rSet.RecordCount;
              rCount := 0;
              while not rSet.Eof do
              begin
                inc(rCount);
                isMainGuest := false;

                if rCount = 1 then
                begin
                  isMainGuest := true;
                end;

                Room                 := rSet.FieldByName('Room').asstring;
                RoomDescription      := rSet.FieldByName('RoomDescription').asstring;
                RoomType             := rSet.FieldByName('RoomType').asstring;
                RoomTypeDescription  := rSet.FieldByName('RoomTypeDescription').asstring;
                Location             := rSet.FieldByName('Location').asstring;
                Floor                := rSet.FieldByName('Floor').asstring;
                GuestName            := rSet.FieldByName('GuestName').asstring;
                GuestCountry         := rSet.FieldByName('CountryName').asstring;
                Arrival              := rSet.FieldByName('rrArrival').asDateTime;
                Departure            := rSet.FieldByName('rrDeparture').asDateTime;

                Customer             := rSet.FieldByName('Customer').asstring;
                CustomerName         := rSet.FieldByName('CustomerName').asstring;
                CustomerPID          := rSet.FieldByName('CustomerPID').asstring;
                ReservationName      := rSet.FieldByName('ReservationName').asstring;
                Status               := rSet.FieldByName('Status').asString;
                Reservation          := rSet.FieldByName('Reservation').asInteger;
                GroupAccount         := rSet['GroupAccount'];
                Breakfast            := rSet['invBreakfast'];

                StatusText := d.ExtStatusText(status,aDate, Arrival, departure);

                NightsTotal          := trunc(Departure)-trunc(Arrival);
                NightsFromArrival    := trunc(adate)-trunc(Arrival) ;
                NightsUntilDeparture := trunc(Departure)-trunc(Date);

                mCurrentGuests_.append;
                mCurrentGuests_.fieldbyname('Room').Asstring                 :=  Room                ;
                mCurrentGuests_.fieldbyname('RoomDescription').Asstring      :=  RoomDescription     ;
                mCurrentGuests_.fieldbyname('RoomType').Asstring             :=  RoomType            ;
                mCurrentGuests_.fieldbyname('RoomTypeDescription').Asstring  :=  RoomTypeDescription ;
                mCurrentGuests_.fieldbyname('Location').Asstring             :=  Location            ;
                mCurrentGuests_.fieldbyname('Floor').Asstring                :=  Floor               ;
                mCurrentGuests_.fieldbyname('GuestName').Asstring            :=  GuestName           ;
                mCurrentGuests_.fieldbyname('GuestCountry').Asstring         :=  GuestCountry        ;
                mCurrentGuests_.fieldbyname('Arrival').AsdateTime            :=  Arrival             ;
                mCurrentGuests_.fieldbyname('Departure').AsdateTime          :=  Departure           ;
                mCurrentGuests_.fieldbyname('isMainGuest').Asboolean         :=  isMainGuest         ;
                mCurrentGuests_.fieldbyname('Customer').Asstring             :=  Customer            ;
                mCurrentGuests_.fieldbyname('CustomerName').Asstring         :=  CustomerName        ;
                mCurrentGuests_.fieldbyname('ReservationName').Asstring      :=  ReservationName     ;
                mCurrentGuests_.fieldbyname('StatusText').AsString           :=  StatusText          ;
                mCurrentGuests_.fieldbyname('RoomReservation').AsInteger     :=  RoomReservation     ;
                mCurrentGuests_.fieldbyname('Reservation').AsInteger         :=  Reservation         ;
                mCurrentGuests_.fieldbyname('GuestCount').AsInteger          :=  GuestCount          ;
                mCurrentGuests_.fieldbyname('GroupAccount').AsBoolean        :=  GroupAccount         ;
                mCurrentGuests_.fieldbyname('Breakfast').AsBoolean           :=  Breakfast           ;

                mCurrentGuests_.fieldbyname('NightsTotal').AsInteger          := NightsTotal          ;
                mCurrentGuests_.fieldbyname('NightsFromArrival').AsInteger    := NightsFromArrival    ;
                mCurrentGuests_.fieldbyname('NightsUntilDeparture').AsInteger := NightsUntilDeparture ;

                mCurrentGuests_.Post;
                rSet.next;
              end;
            end;
          finally
            freeandnil(rset);
          end;
        end;
      finally
        freeandNil(lstRR);
      end;
    finally
      if rSet <> nil then freeandnil(rSet);
    end;
    mCurrentGuests_.SortedField := 'Room';
  finally
    mCurrentGuests_.EnableControls;
  end;
end;


procedure TfrmDayNotes.dtImportLogDateChange(Sender: TObject);
begin
  if pageMain.ActivePage = tabLog then
  if pageLog.ActivePage = tabImportLog then
  begin
    RefreshImPortLog;
  end;
end;


procedure TfrmDayNotes.RefreshImPortLog;
var
  rSet : TRoomerDataSet;
  s : string;

  dtDateFrom : TDateTime;
  dtDateTo : TdateTime;

begin
  dtDateFrom  := dtImportLogDate.Date;  //ATHTODO á að vera datetime
  dtDateTo    := dtImportLogDate.Date+edImportLogDaysToShow.Value-1; //ATHTODO á að vera datetime

  cxLabel7.Caption := dateToStr(dtDateFrom);
  cxLabel9.Caption := dateToStr(dtDateTo);

  mImportLog.DisableControls;
  try
    rSet := CreateNewDataSet;
    try
//      s := '';
//      s := s+' SELECT ';
//      s := s+'        Id ';
//      s := s+'      , DateInsert ';
//      s := s+'      , ImportTypeID ';
//      s := s+'      , ImportData ';
//      s := s+'      , ImportResultID ';
//      s := s+'      , Reservation ';
//      s := s+'      , RoomReservation ';
//      s := s+'      , Customer ';
//      s := s+'      , DateExport ';
//      s := s+'      , ItemCount ';
//      s := s+'      , HotelCode ';
//      s := s+'      , Staff ';
//      s := s+'      , RoomNumber ';
//      s := s+'      , isGroupInvoice ';
//      s := s+'      , invCustomer ';
//      s := s+'      , invPersonalID ';
//      s := s+'      , invCustomerName ';
//      s := s+'      , invAddress1 ';
//      s := s+'      , invAddress2 ';
//      s := s+'      , invAddress3 ';
//      s := s+'      , invAddress4 ';
//      s := s+'      , GuestName ';
//      s := s+'      , SaleRefrence ';
//      s := s+'      , invoiceNumber ';
//      s := s+'    FROM ';
//      s := s+'      tblImportLogs ';
//      s := s+'    WHERE ';
//      s := s+'      ( (DateInsert >='+_db(dtDateFrom)+ ') AND (DateInsert <='+_db(dtDateTo)+ ') )';


		s := format(select_DayNotes_RefreshImPortLog , [_db(dtDateFrom),_db(dtDateTo)]);
//	CopyToClipboard(s);
//	DebugMessage('select_DayNotes_RefreshImPortLog'#10#10+s);
		hData.rSet_bySQL(rSet,s);

      if mImportLog.active then mImportLog.close;
      mImportLog.Open;

      while not rSet.Eof do
      begin
        mImportLog.Insert;
        mImportLog.FieldByName('ID').AsInteger := rSet.FieldByName('Id').AsInteger;
        mImportLog.FieldByName('DateInsert').AsDateTime := rSet.FieldByName('DateInsert').AsDateTime;
        mImportLog.FieldByName('ImportTypeID').AsInteger := rSet.FieldByName('ImportTypeID').AsInteger;
        mImportLog.FieldByName('ImportData').AsString := rSet.FieldByName('ImportData').AsString;
        mImportLog.FieldByName('DateExport').AsDateTime := rSet.FieldByName('DateExport').AsDateTime;

        mImportLog.FieldByName('ImportResultID').AsInteger := rSet.FieldByName('ImportResultID').AsInteger;
        mImportLog.FieldByName('Reservation').AsInteger := rSet.FieldByName('Reservation').AsInteger;
        mImportLog.FieldByName('roomReservation').AsInteger := rSet.FieldByName('roomReservation').AsInteger;

        mImportLog.FieldByName('ItemCount').AsInteger := rSet.FieldByName('ItemCount').AsInteger;
        mImportLog.FieldByName('HotelCode').AsString := rSet.FieldByName('HotelCode').AsString;
        mImportLog.FieldByName('Staff').AsString := rSet.FieldByName('Staff').AsString;
        mImportLog.FieldByName('RoomNumber').AsString := rSet.FieldByName('RoomNumber').AsString;
        mImportLog.FieldByName('isGroupInvoice').AsBoolean := rSet['isGroupInvoice'];
        mImportLog.FieldByName('invCustomer').AsString := rSet.FieldByName('invCustomer').AsString;
        mImportLog.FieldByName('invPersonalID').AsString := rSet.FieldByName('invPersonalID').AsString;
        mImportLog.FieldByName('invCustomerName').AsString := rSet.FieldByName('invCustomerName').AsString;
        mImportLog.FieldByName('invAddress1').AsString := rSet.FieldByName('invAddress1').AsString;
        mImportLog.FieldByName('invAddress2').AsString := rSet.FieldByName('invAddress2').AsString;
        mImportLog.FieldByName('invAddress3').AsString := rSet.FieldByName('invAddress3').AsString;
        mImportLog.FieldByName('invAddress4').AsString := rSet.FieldByName('invAddress4').AsString;
        mImportLog.FieldByName('GuestName').AsString := rSet.FieldByName('GuestName').AsString;
        mImportLog.FieldByName('SaleRefrence').AsString := rSet.FieldByName('SaleRefrence').AsString;
        mImportLog.FieldByName('InvoiceNumber').AsInteger := rSet.FieldByName('InvoiceNumber').AsInteger;
        mImportLog.Post;
        rset.Next;
      end;

      mImportLog.SortOptions := [soDesc];
      mImportLog.SortedField := 'id';
      mImportLog.First;

  (*
  Id
  DateInsert
  ImportTypeID

  ImportData
  ImportResultID
  Reservation
  RoomReservation
  Customer
  *)
    finally
      freeandNil(rSet);
    end;
  finally
    mImportLog.EnableControls;
  end;

end;

procedure TfrmDayNotes.FormDestroy(Sender : TObject);
begin
  // **
end;

function TfrmDayNotes.xDoLog(theAction, theText : string) : string;
var
  s : string;
begin
  dateTimeToString(s, 'yyyy-mm-dd hh.nn.ss', now);
  memLog.Lines.insert(0, s + ' ; ' + theAction + ' ; ' + theText);
end;




procedure TfrmDayNotes.btnClearLogClick(Sender: TObject);
begin
  memlog.Clear;
end;

procedure TfrmDayNotes.btnFormatLogClick(Sender: TObject);
var
  s : string;
  i : integer;
  ch : char;
  ii : integer;

  ss : string;


begin
  //**
  s := memlog.Text;

  ss := '';
  ii := 0;
  for i := 1 to length(s)-1 do
  begin
    ch := s[i];
    if ch = chr(10) then
    begin
      ss := ss+chr(13)+ch;
    end else
    begin
      ss := ss+ch;
    end;
  end;

  memlog.Text := ss;
end;

procedure TfrmDayNotes.FormatLog;
var
  s : string;
  i : integer;
  ch : char;
  ii : integer;
  ss : string;
begin
  //**
  s := memlog.Text;

  ss := '';
  ii := 0;
  for i := 1 to length(s)-1 do
  begin
    ch := s[i];
    if ch = chr(10) then
    begin
      ss := ss+chr(13)+ch;
    end else
    begin
      ss := ss+ch;
    end;
  end;

  memlog.Text := ss;
end;


procedure TfrmDayNotes.ClearLog(FirstLine : string);
begin
  memlog.Clear;
  memlog.lines.add(firstLine);
  memlog.lines.add('#---');
end;



procedure TfrmDayNotes.showdates;
begin
end;

procedure TfrmDayNotes.mImportLogAfterScroll(DataSet: TDataSet);
begin
  memImportData.Clear;
end;

procedure TfrmDayNotes.mnuThisreservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  if pageMain.ActivePage = tabLog then
    if pageLog.ActivePage = tabImportLog then
  begin
    iReservation := mImportLog.fieldbyname('Reservation').asinteger;
    iRoomReservation := mImportLog.fieldbyname('RoomReservation').asinteger;
  end else
  begin
    iReservation := mCurrentGuests_.fieldbyname('Reservation').asinteger;
    iRoomReservation := mCurrentGuests_.fieldbyname('RoomReservation').asinteger;
  end;
  ShowFinishedInvoices2(itPerReservation, '', iReservation);
end;

procedure TfrmDayNotes.mnuThisRoomClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  if pageMain.ActivePage = tabLog then
    if pageLog.ActivePage = tabImportLog then
  begin
    iReservation := mImportLog.fieldbyname('Reservation').asinteger;
    iRoomReservation := mImportLog.fieldbyname('RoomReservation').asinteger;
  end else
  begin
    iReservation := mCurrentGuests_.fieldbyname('Reservation').asinteger;
    iRoomReservation := mCurrentGuests_.fieldbyname('RoomReservation').asinteger;
  end;



  ShowFinishedInvoices2(itPerRoomRes, '', iRoomReservation);
end;

procedure TfrmDayNotes.OpenGroupInvoice1Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  Arrival : Tdate;
  Departure : Tdate;
begin
  Arrival := date;
  Departure := date;

  if pageMain.ActivePage = tabLog then
    if pageLog.ActivePage = tabImportLog then
  begin
    iReservation := mImportLog.fieldbyname('Reservation').asinteger;
    iRoomReservation := mImportLog.fieldbyname('RoomReservation').asinteger;
  end else
  begin
    iReservation := mCurrentGuests_.fieldbyname('Reservation').asinteger;
    iRoomReservation := mCurrentGuests_.fieldbyname('RoomReservation').asinteger;
  end;

  EditInvoice(iReservation, 0, 0, 0, 0, 0, false, true,false);
end;

procedure TfrmDayNotes.OpenthisRoom1Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  Arrival : Tdate;
  Departure : Tdate;
begin
  Arrival := date;
  Departure := date;


  if pageMain.ActivePage = tabLog then
    if pageLog.ActivePage = tabImportLog then
  begin
    iReservation := mImportLog.fieldbyname('Reservation').asinteger;
    iRoomReservation := mImportLog.fieldbyname('RoomReservation').asinteger;
  end else
  begin
    iReservation := mCurrentGuests_.fieldbyname('Reservation').asinteger;
    iRoomReservation := mCurrentGuests_.fieldbyname('RoomReservation').asinteger;
  end;

  EditInvoice(iReservation, iRoomReservation, 0, 0, 0, 0, false, true,false);
end;

procedure TfrmDayNotes.pageMainChange(Sender: TObject);
begin
  if PageMain.ActivePage = tabStatus then
  begin
    RefreshRoomStatus;
  end else
  if PageMain.ActivePage = tabDayNotes then
  begin

  end;
  if PageMain.ActivePage = tabCurrentGuests then
  begin
    getCurrentGuests(date);
  end;

end;

procedure TfrmDayNotes.Panel10DblClick(Sender: TObject);
begin
{IFDEF DEBUG}
  tabActionlog.TabVisible := true;
{ENDIF}
end;

procedure TfrmDayNotes.FormCloseQuery(Sender : TObject; var CanClose : Boolean);
begin
  CanClose := false;
  if frmDayNotes.v then
  begin
    frmDayNotes.v := false;
    frmDayNotes.hide;
  end
  else
  begin
    frmDayNotes.v := true;
    frmDayNotes.show;
  end;
end;



/////////////////////////////////////////////////////////////////////////////////////////
///  Status tab
///\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

procedure TfrmDayNotes.edOkLevelPropertiesChange(Sender : TObject);
begin
  RefreshRoomStatus;
end;

procedure TfrmDayNotes.edRefreshChange(Sender : TObject);
begin
  RefreshRoomStatus;
end;

procedure TfrmDayNotes.RefreshRoomStatus;
var
  sSQL : string;
  s : string;
  rSet : TRoomerDataSet;
begin

  if (pageMain.ActivePage <> tabStatus) or (NOT Showing)  then
    exit;


  //**ATH setja á server
  s := '';
  s := s+'SELECT predefineddates.date AS ResDate, '#10;
  s := s+'       roomtypes.RoomType, '#10;
  s := s+'       roomtypes.RoomTypeGroup, '#10;
  s := s+'       roomtypes.description, '#10;
  s := s+'       roomtypes.NumberGuests, '#10;
  s := s+'       (SELECT COUNT(*) '#10;
  s := s+'        FROM rooms '#10;
  s := s+'        WHERE rooms.Active=1 AND rooms.RoomType=roomtypes.RoomType) - '#10;
  s := s+'       (SELECT COUNT(*) '#10;
  s := s+'        FROM roomsdate '#10;
  s := s+'           LEFT JOIN roomreservations ON roomreservations.roomreservation=roomsdate.roomreservation '#10;
  s := s+'        WHERE roomsdate.RoomType=roomtypes.RoomType '#10;
  s := s+'        AND roomsdate.ADate=predefineddates.date '#10;
  s := s+'        AND ((NOT control.ExcluteWaitingList) OR roomreservations.Status<>'+quotedStr('O')+') '#10;
  s := s+'        AND ((NOT control.ExcludeWaitingList_NEW) OR roomreservations.Status<>'+quotedStr('L')+') '#10;
  s := s+'        AND ((NOT control.ExcluteAllotment) OR roomreservations.Status<>'+quotedStr('A')+') '#10;
  s := s+'        AND ((NOT control.ExcluteOrder) OR roomreservations.Status<>'+quotedStr('P')+') '#10;
  s := s+'        AND ((NOT control.ExcluteDeparted) OR roomreservations.Status<>'+quotedStr(STATUS_CHECKED_OUT)+') '#10;
  s := s+'        AND ((NOT control.ExcluteGuest) OR roomreservations.Status<>'+quotedStr('G')+') '#10;
  s := s+'        AND ((NOT control.ExcluteBlocked) OR roomreservations.Status<>'+quotedStr('B')+') '#10;
  s := s+'        AND ((NOT control.ExcluteNoShow) OR roomreservations.Status<>'+quotedStr('N')+') '#10;
  s := s+'        AND (roomreservations.Status<>'+quotedStr('C')+') '#10;
  s := s+'        AND (roomsdate.ResFlag<>'+quotedStr('X')+') '#10;
  s := s+'        ) AS available '#10;
  s := s+'FROM predefineddates, roomtypes, control '#10;
  s := s+'WHERE roomtypes.Active=1 AND predefineddates.date>=%s AND predefineddates.date<=DATE_ADD(%s,INTERVAL %d DAY) '#10;
  s := s+'GROUP BY predefineddates.date, roomtypes.RoomType ';

	s := format(s, [ _dateToDBDate(zCurrentDate,true),_dateToDBDate(zCurrentDate,true), zDaysToShow]);

//  copytoclipboard(s);
//  debugmessage(s);

  RSet := CreateNewDataSet;
  try
    if hData.rSet_bySQL(rSet,s) then
    begin
      if mRoomStatus.active then mRoomStatus.Close;
      mRoomStatus.LoadFromDataSet(rSet);
      mRoomStatus.Open;
    end;
  finally
    freeandnil(rSet);
  end;

  PivStatus.ApplyBestFit;

//***************************************************************************************

  dateTimeTostring(s,'dd.mm.yyyy',zCurrentDate);
  labStatusDateFrom.caption := s;

  dateTimeToString(s,'dd.mm.yyyy',zCurrentDate+zDaysToShow-1);
  labStatusDateTo.caption := s;
end;


procedure TfrmDayNotes.edDaysToShowPropertiesChange(Sender : TObject);
begin
  zDaysToShow := edDaysToShow.Value;
  RefreshRoomStatus;
end;

procedure TfrmDayNotes.edImportLogDaysToShowPropertiesChange(Sender: TObject);
begin
  if pageMain.ActivePage = tabLog then
    if pageLog.ActivePage = tabImportLog then
  begin
    RefreshImPortLog;
  end;
end;

procedure TfrmDayNotes.edCurrentDateChange(Sender: TObject);
begin
  try
    zCurrentDate := strTodate(edCurrentDate.Text);
    RefreshRoomStatus;
  Except
  end;
end;

procedure TfrmDayNotes.btnRefreshPivStatusClick(Sender: TObject);
begin
  RefreshRoomStatus;
end;

procedure TfrmDayNotes.btnRrShowReservationClick(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := mCurrentGuests_.fieldbyname('Reservation').asinteger;
  iRoomReservation := mCurrentGuests_.fieldbyname('RoomReservation').asinteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
  end;
end;

procedure TfrmDayNotes.btnRrToExcelClick(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_CurrentGuests';
  ExportGridToExcel(sFilename, gridCurrentGuests, True, True, True);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmDayNotes.btnStatusLeftExcelClick(Sender: TObject);
begin
end;


///************

procedure TfrmDayNotes.cxButton10Click(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_importLog';
  ExportGridToExcel(sFilename, gridImportLogs, True, True, True);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;



procedure TfrmDayNotes.cxButton11Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := mImportLog.fieldbyname('Reservation').asinteger;
  iRoomReservation := mImportLog.fieldbyname('RoomReservation').asinteger;

  if EditReservation(iReservation, iRoomReservation) then
  begin
  end;
end;

procedure TfrmDayNotes.cxButton13Click(Sender: TObject);
var
  iReservation     : integer;
  iRoomReservation : integer;
  sGuest           : string;
  theData          : recPersonHolder;

begin
  iReservation := mImportLog.fieldbyname('Reservation').asinteger;
  iRoomReservation := mImportLog.fieldbyname('RoomReservation').asinteger;
  sGuest := '';

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := sGuest;
  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;

procedure TfrmDayNotes.cxButton15Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := mImportLog.fieldbyname('Reservation').asinteger;
  iRoomReservation := mImportLog.fieldbyname('RoomReservation').asinteger;

  if g.openresMemo(iReservation) then
  begin
  end;
end;

procedure TfrmDayNotes.cxButton1Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := mCurrentGuests_.fieldbyname('Reservation').asinteger;
  iRoomReservation := mCurrentGuests_.fieldbyname('RoomReservation').asinteger;

  if g.openresMemo(iReservation) then
  begin
  end;
end;

procedure TfrmDayNotes.cxButton4Click(Sender: TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  sGuest : string;
  theData : recPersonHolder;

begin
  iReservation := mCurrentGuests_.fieldbyname('Reservation').asinteger;
  iRoomReservation := mCurrentGuests_.fieldbyname('RoomReservation').asinteger;
  sGuest := '';

  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := sGuest;

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;

procedure TfrmDayNotes.cxButton5Click(Sender: TObject);
begin
  RefreshImPortLog;
end;

procedure TfrmDayNotes.cxButton6Click(Sender: TObject);
var
  fileName  : string;
  posSale   : TPosSale;
  lst       : TstringList;

begin
  memImportData.Clear;
  fileName := g.qProgramPath+'tmp.xml';
  try
    cxDBMemo1.Lines.SaveToFile(FileName);
  Except
    exit;
  end;

  if fileExists(fileName) then
  begin
    posSale := TPosSale.Create(fileName);
    try
      lst := posSaleTextLog(posSale);
      try
        memImportData.Lines.Text := lst.Text;
      finally
        freeandNil(lst);
      end;
    finally
      freeandnil(posSale);
    end;
  end;

end;

procedure TfrmDayNotes.cxButton7Click(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  datetimeTostring(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_RoomStatus1';
  cxExportPivotGridToExcel(sFileName, pivStatus);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmDayNotes.cxButton8Click(Sender: TObject);
begin
 dtImportLogDate.Date := dtImportLogDate.Date+1;
end;

procedure TfrmDayNotes.cxButton9Click(Sender: TObject);
begin
  dtImportLogDate.Date := dtImportLogDate.Date-1;
end;

procedure TfrmDayNotes.pageLogPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  if NewPage = tabImportLog then
  begin
    dtImportLogDate.Date := date;
    RefreshImPortLog;
  end;
end;

procedure TfrmDayNotes.btnStatusRightExcelClick(Sender: TObject);
begin
end;

///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// Gurrent Guests tab


procedure TfrmDayNotes.btnGetCurrentGuestsRefreshClick(Sender: TObject);
begin
  getCurrentGuests(Date);
end;

procedure TfrmDayNotes.btnLogLogToClipboardClick(Sender: TObject);
begin
  uStringUtils.ClipboardCopy(frmdayNotes.memLog.text);
end;

procedure TfrmDayNotes.sButton1Click(Sender: TObject);
begin
  frmdayNotes.memLog.SelStart := 0;
end;

procedure TfrmDayNotes.sButton3Click(Sender: TObject);
begin
  frmdayNotes.memLog.Perform(EM_LINESCROLL,0,1)
end;



procedure TfrmDayNotes.sButton4Click(Sender: TObject);
begin
  frmdayNotes.memLog.Perform(EM_LINESCROLL,0,-1)
end;

end.



