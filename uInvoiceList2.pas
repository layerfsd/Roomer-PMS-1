unit uInvoiceList2;

interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , shellapi
  , Forms
  , Dialogs
  , DateUtils
  , DB
  , ug
  , ADODB
  , Grids
  , StdCtrls
  , ExtCtrls

  , kbmMemTable
  , hdata
  , _glob
  , uUtils

  , Mask
  , ImgList
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
  , cxDBData
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridDBTableView
  , cxGridLevel
  , cxClasses
  , cxGridCustomView
  , cxGrid
  , cxPC
  , cxGridExportLink
  , cxPCdxBarPopupMenu
  , cxNavigator
  , cxGridBandedTableView
  , cxGridDBBandedTableView

  , DBCtrls
  , cmpRoomerDataSet
  , cmpRoomerConnection
  , dxSkinsCore
  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters
  , dxSkinscxPCPainter
  , cxPropertiesStore
  , sRadioButton
  , sComboBox
  , sEdit
  , sGroupBox
  , sButton
  , sPanel
  , sLabel
  , Vcl.Buttons

  , Vcl.ComCtrls
  , sSpeedButton
  , sSpinEdit
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sPageControl, cxCurrencyEdit, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDarkRoom, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue
  ;

type
  TfrmInvoiceList2 = class(TForm)
    LMDSimplePanel1: TsPanel;
    btnReservation: TsButton;
    LMDSpeedButton1: TsButton;
    LMDButton1: TsButton;
    LMDGroupBox1: TsGroupBox;
    dtFrom: TsDateEdit;
    dtTo: TsDateEdit;
    rbtDates: TsRadioButton;
    rbtInvoices: TsRadioButton;
    LMDSimpleLabel2: TsLabel;
    LMDSimpleLabel3: TsLabel;
    cbxPeriod: TsComboBox;
    edtFreeText: TsEdit;
    rbtFreeText: TsRadioButton;
    LMDSpeedButton3: TsButton;
    rbtLast: TsRadioButton;
    cbxTxtType: TsComboBox;
    LMDSpeedButton5: TsButton;
    btnViewInvoice: TsButton;
    LMDSpeedButton6: TsButton;
    LMDSpeedButton7: TsButton;
    edtLast: TsSpinEdit;
    edtInvoiceFrom: TsSpinEdit;
    edtInvoiceTo: TsSpinEdit;
    FormStore: TcxPropertiesStore;
    sButton1: TsButton;
    sPanel1: TsPanel;
    mDS: TDataSource;
    m22_: TkbmMemTable;
    grInvoiceHead: TcxGrid;
    tvInvoiceHead: TcxGridDBBandedTableView;
    tvInvoiceHeadInvoiceNumber: TcxGridDBBandedColumn;
    tvInvoiceHeadInvoiceDate: TcxGridDBBandedColumn;
    tvInvoiceHeadDueDate: TcxGridDBBandedColumn;
    tvInvoiceHeadCreditType: TcxGridDBBandedColumn;
    tvInvoiceHeadNameOnInvoice: TcxGridDBBandedColumn;
    tvInvoiceHeadInvoicetype: TcxGridDBBandedColumn;
    tvInvoiceHeadLink: TcxGridDBBandedColumn;
    tvInvoiceHeadAmount: TcxGridDBBandedColumn;
    tvInvoiceHeadWithOutVAT: TcxGridDBBandedColumn;
    tvInvoiceHeadVAT: TcxGridDBBandedColumn;
    tvInvoiceHeadTaxes: TcxGridDBBandedColumn;
    tvInvoiceHeadTaxunits: TcxGridDBBandedColumn;
    tvInvoiceHeadCurrency: TcxGridDBBandedColumn;
    tvInvoiceHeadCurrencyRate: TcxGridDBBandedColumn;
    tvInvoiceHeadCurrencyAmount: TcxGridDBBandedColumn;
    tvInvoiceHeadRoomGuest: TcxGridDBBandedColumn;
    tvInvoiceHeadCustomer: TcxGridDBBandedColumn;
    tvInvoiceHeadCompanyId: TcxGridDBBandedColumn;
    tvInvoiceHeadCustomerName: TcxGridDBBandedColumn;
    tvInvoiceHeadAddress1: TcxGridDBBandedColumn;
    tvInvoiceHeadAddress2: TcxGridDBBandedColumn;
    tvInvoiceHeadAddress3: TcxGridDBBandedColumn;
    tvInvoiceHeadRefrence: TcxGridDBBandedColumn;
    tvInvoiceHeadStaff: TcxGridDBBandedColumn;
    tvInvoiceHeadConfirmdate: TcxGridDBBandedColumn;
    tvInvoiceHeadReservation: TcxGridDBBandedColumn;
    tvInvoiceHeadRoomReservation: TcxGridDBBandedColumn;
    lvInvoiceHead: TcxGridLevel;
    sButton2: TsButton;
    cLabFilter: TsLabel;
    edFilter: TsEdit;
    btnClear: TsSpeedButton;
    btnExport: TsButton;
    tvInvoiceHeadRowSelected: TcxGridDBBandedColumn;
    tvInvoiceHeadexternalInvoiceId: TcxGridDBBandedColumn;
    procedure rbtDatesClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure cbxPeriodChange(Sender : TObject);
    procedure cbxTxtTypeChange(Sender : TObject);
    procedure edtFreeTextChange(Sender : TObject);
    procedure dtFromChange(Sender : TObject);
    procedure dtToChange(Sender : TObject);
    procedure LMDSpeedButton3Click(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure LMDSpeedButton5Click(Sender : TObject);
    procedure btnReservationClick(Sender : TObject);
    procedure LMDSpeedButton1Click(Sender : TObject);
    procedure LMDButton1Click(Sender : TObject);
    procedure btnViewInvoiceClick(Sender : TObject);
    procedure LMDSpeedButton6Click(Sender : TObject);
    procedure LMDSpeedButton7Click(Sender : TObject);
    procedure tvInvDblClick(Sender: TObject);
    procedure edLastCountChange(Sender: TObject);
    procedure edtInvoiceFromChange(Sender: TObject);
    procedure edtInvoiceToChange(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure tvInvoiceHeadDblClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure tvInvoiceHeadVATGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadTaxesGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure tvInvoiceHeadWithOutVATGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    r_ : TRoomerDataSet;
    zSortField : string;
    zSortDir : string;

    zRecordCount : integer;
    zLastInvoiceID : integer;

    firstTime : boolean;
    zEnterIndex : integer;

    procedure RunQuery;
    procedure runFilter;
    procedure doFilter;
    function GetGridFielNamesIndex(sFieldname : string) : integer;
    procedure ViewInvoice;
    procedure ApplyFilter;
    function GetSelectedInvoices : String;
    function GetExportTemplate: String;
    procedure InitSelections;
  public
    { Public declarations }
    dirArr : array [1 .. 20] of boolean;

    zFilterby : integer; // 1=period 2=invoicenumber 3=FreeText 4=InvoiceNumber
    zPeriodIndex : integer;
    zdtFrom : Tdate;
    zDTTo : Tdate;
    zInvoiceFrom : integer;
    zInvoiceTo : integer;
    zLast : integer;
    zText : string;
    zTextType : integer;

    zRoom : string;
    zArrival : Tdate;
  end;

var
  frmInvoiceList2 : TfrmInvoiceList2;

implementation

uses
  uD
  , uReservationProfile
  , uGuestProfile2
  , uFinishedInvoices2
  , uSqlDefinitions
  , uAppGlobal
  , PrjConst
  , uDImages
  , uFrmPostInvoices
  ;

{$R *.dfm}
(*
  function SQLDateStr( Date: TDateTime ): string;
  var y, m, d : word;
  sy, sm, sd : string;

  sTmp : string;

  begin
  decodeDate( Date, y, m, d );
  str( y:1, sy );
  str( m:1, sm );
  str( d:1, sd );
  sTmp :=  sm + '/' + sd + '/' + sy;
  result := quotedstr(sTmp);
  end;
*)

procedure TfrmInvoiceList2.rbtDatesClick(Sender : TObject);
begin
  // **
  // -- Date edits
  dtFrom.enabled := rbtDates.checked;
  dtTo.enabled := rbtDates.checked;
  cbxPeriod.enabled := rbtDates.checked;
  // lblToDate.enabled      := RadioButton1.checked;

  // -- Invoice edits
  edtInvoiceFrom.enabled := rbtInvoices.checked;
  edtInvoiceTo.enabled := rbtInvoices.checked;
  edtLast.enabled := rbtInvoices.checked;
  // lblToInvoice.enabled   := RadioButton2.checked;

  edtFreeText.enabled := rbtFreeText.checked;
  cbxTxtType.enabled := rbtFreeText.checked;

  edtLast.enabled := rbtLast.checked;

  if rbtLast.checked then
  begin
    zLast := edtLast.value;
    zInvoiceTo := zLastInvoiceID;
    zInvoiceFrom := zLastInvoiceID - zLast + 1;
    if zLast < 100 then
      RunQuery;
  end;
end;

procedure TfrmInvoiceList2.FormCreate(Sender : TObject);
var
  i : integer;
begin
  RoomerLanguage.TranslateThisForm(self);
   glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  for i := 1 to 20 do
  begin
    dirArr[i] := false;
  end;

  zSortField := 'InvoiceNumber';
  zSortDir := '';

  zRoom := '';
  zArrival := Date;

  firstTime := true;
  zFilterby := 0; // 0=period 1=invoicenumber 2=FreeText 3=InvoiceNumber
  zdtFrom := Date;
  zDTTo := Date;
  zInvoiceFrom := 0;
  zInvoiceTo := 0;
  zLast := 0;
  zText := '';
  zTextType := 0; // 0= Reikningsnúmer
  // 1= Kennitala
  // 2= Nafn Gests eða Fyrirtækis
  // 3= Nafn á Reikningi
  // 4= Bókunn númer
  // 5= Herbergjabókunn

  zPeriodIndex := 1;
  // 0=Í dag
  // 1=í gær
  // 2=Síðustu 3 daga
  // 3=Síðustu 5 daga
  // 4=Síðustu 10 daga
  // 5=í þessari viku
  // 6=Í síðustu viku
  // 7=Í þessum mánuði
  // 8=í síðasta mánuði
  // 9=Á þessu ári
  // 10=Á síðasta ári
  // 11=Frá upphafi

  edtLast.Value := 50;
  zLast := edtLast.Value;

  cbxPeriod.ItemIndex := zPeriodIndex;
  cbxPeriodChange(nil);
  cbxTxtType.ItemIndex := zTextType;

  tvInvoiceHeadRowSelected.Visible := GetExportTemplate <> '';
end;

procedure TfrmInvoiceList2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

function TfrmInvoiceList2.GetExportTemplate : String;
var rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  rSet_bySQL(rSet, 'SELECT InvoiceExportFilename FROM hotelconfigurations LIMIT 1');
  rSet.First;
  if NOT rSet.Eof then
  begin
    result := rSet['InvoiceExportFilename'];

  end else
    result := '';
end;

procedure TfrmInvoiceList2.cbxPeriodChange(Sender : TObject);
var
  ThisDay : word;
  ThisWeekDay : word;
  ThisMonth : word;
  ThisYear : word;

  LastMonth : word;
begin
  deCodeDate(now, ThisYear, ThisMonth, ThisDay);
  ThisWeekDay := DayOfTheWeek(now);
  zPeriodIndex := cbxPeriod.ItemIndex;

  case zPeriodIndex of
    0 :
      begin
        // - ekkert valið -
      end;
    1 :
      begin
        // Í dag
        dtTo.Date := Date;
        dtFrom.Date := Date;
      end;
    2 :
      begin
        // í gær
        dtTo.Date := Date - 1;
        dtFrom.Date := Date - 1;
      end;
    3 :
      begin
        // Síðustu 3 daga
        dtTo.Date := Date;
        dtFrom.Date := Date - 4;
      end;
    4 :
      begin
        // Síðustu 10 daga
        dtTo.Date := Date;
        dtFrom.Date := Date - 9;
      end;
    5 :
      begin
        // í þessari viku
        dtTo.Date := Date;
        dtFrom.Date := Date - ThisWeekDay + 1;
      end;
    6 :
      begin
        // Í síðustu viku
        dtTo.Date := (Date - ThisWeekDay);
        dtFrom.Date := (Date - ThisWeekDay) - 6;
      end;
    7 :
      begin
        dtTo.Date := (Date);
        dtFrom.Date := (Date - ThisDay) + 1;
      end;
    8 :
      begin
        // í síðasta mánuði
        if ThisMonth = 1 then
          LastMonth := 12
        else
          LastMonth := ThisMonth - 1;

        dtFrom.Date := (Date - ThisDay) - DaysInAMonth(ThisYear, LastMonth) + 1;
        dtTo.Date := (Date - ThisDay);
      end;
    9 :
      begin
        dtTo.Date := (Date);
        dtFrom.Date := (Date - DayOfTheYear(now)) + 1;
      end;
    10 :
      begin
        // Á síðasta ári
        dtFrom.Date := encodeDate(ThisYear - 1, 1, 1);
        dtTo.Date := encodeDate(ThisYear - 1, 12, 31)
      end;
    11 :
      begin
        dtFrom.Date := encodeDate(2000, 1, 1);
        dtTo.Date := Date;
      end;
  end;
  RunQuery;
end;

procedure TfrmInvoiceList2.cbxTxtTypeChange(Sender : TObject);
begin
  zTextType := cbxTxtType.ItemIndex;
end;

procedure TfrmInvoiceList2.edFilterChange(Sender: TObject);
begin
  if edFilter.Text = '' then
  begin
    tvInvoiceHead.DataController.Filter.Root.Clear;
    tvInvoiceHead.DataController.Filter.Active := false;
  end else
  begin
    applyFilter;
  end;
end;

procedure TfrmInvoiceList2.ApplyFilter;
begin
  tvInvoiceHead.DataController.Filter.Options := [fcoCaseInsensitive];
  tvInvoiceHead.DataController.Filter.Root.BoolOperatorKind := fboOr;
  tvInvoiceHead.DataController.Filter.Root.Clear;
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadCurrency,foLike,'%'+Uppercase(edFilter.Text)+'%','%'+Uppercase(edFilter.Text)+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadInvoiceNumber,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadCreditType,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadNameOnInvoice,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadInvoicetype,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadLink,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadRoomGuest,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadCustomer,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadCompanyId,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadCustomerName,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadAddress1,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadAddress3,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadAddress3,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadRefrence,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadStaff,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadReservation,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');
  tvInvoiceHead.DataController.Filter.Root.AddItem(tvInvoiceHeadRoomReservation,foLike,'%'+edFilter.Text+'%','%'+edFilter.Text+'%');

  tvInvoiceHead.DataController.Filter.Active := True;
end;


procedure TfrmInvoiceList2.edLastCountChange(Sender: TObject);
begin
//  zLast := edtLast.Value;
//  zInvoiceTo := zLastInvoiceID;
//  zInvoiceFrom := zLastInvoiceID - zLast + 1;
//  if zLast < 100 then
//    RunQuery;
end;

procedure TfrmInvoiceList2.edtFreeTextChange(Sender : TObject);
begin
  zText := edtFreeText.Text;
end;

procedure TfrmInvoiceList2.dtFromChange(Sender : TObject);
begin
  zdtFrom := dtFrom.Date;
end;

procedure TfrmInvoiceList2.dtToChange(Sender : TObject);
begin
  zDTTo := dtTo.Date;
end;

procedure TfrmInvoiceList2.RunQuery;
var
  s : string;
  rSet : TroomerDataSet;

begin
  if firstTime then exit;
  zdtFrom := dtFrom.Date;

  screen.Cursor := crHourGlass;
  rSet := CreateNewDataset;
  try
    s := s + 'SELECT '#10;
    s := s + '      invoiceheads.externalInvoiceId '#10;
    s := s + '    , invoiceheads.Reservation '#10;
    s := s + '    , invoiceheads.RoomReservation '#10;
    s := s + '    , invoiceheads.InvoiceNumber '#10;
    s := s + '    , invoiceheads.Customer '#10;
    s := s + '    , invoiceheads.Name AS NameOnInvoice'#10;
    s := s + '    , invoiceheads.Address1 '#10;
    s := s + '    , invoiceheads.Address2 '#10;
    s := s + '    , invoiceheads.Address3 '#10;
    s := s + '    , invoiceheads.invRefrence AS Refrence '#10;
    s := s + '    , invoiceheads.Total AS Amount '#10;
    s := s + '    , invoiceheads.TotalWOVat AS WithOutVAT'#10;
    s := s + '    , invoiceheads.TotalVat AS VAT '#10;
    s := s + '    , invoiceheads.RoomGuest '#10;
    s := s + '    , invoiceheads.ihInvoiceDate AS InvoiceDate'#10;
    s := s + '    , invoiceheads.ihConfirmDate AS Confirmdate'#10;
    s := s + '    , invoiceheads.ihPayDate AS DueDate'#10;
    s := s + '    , invoiceheads.ihStaff AS Staff'#10;
    s := s + '    , invoiceheads.custPID AS CompanyId'#10;
    s := s + '    , invoiceheads.ihcurrency AS Currency'#10;
    s := s + '    , invoiceheads.ihcurrencyRate AS CurrencyRate'#10;
    s := s + '    , invoiceheads.totalStayTax AS Taxes'#10;
    s := s + '    , invoiceheads.TotalStayTaxNights Taxunits'#10;
    s := s + '    , (if(invoiceheads.Splitnumber=1,'+_db('CREDIT')+','+_db('DEBIT')+')) AS CreditType '#10;
    s := s + '    , (invoiceheads.Total div invoiceheads.ihCurrencyRate) AS CurrencyAmount '#10;
    s := s + '    , (if(invoiceheads.Reservation = 0 and invoiceheads.Roomreservation=0,'+_db('Cash')+',if(invoiceheads.Reservation > 0 and invoiceheads.Roomreservation=0,'+_db('Group')+','+_db('Room')+'))) AS Invoicetype '#10;
    s := s + '    , (IF(invoiceheads.CreditInvoice<>0,invoiceheads.CreditInvoice,if(invoiceheads.OriginalInvoice<>0,invoiceheads.OriginalInvoice,0))) AS Link'#10;
    s := s + '    , (SELECT surName FROM customers WHERE Customer = invoiceheads.Customer Limit 1) As CustomerName'#10;
    s := s + '     FROM '#10;
    s := s + '        invoiceheads '#10;
    s := s + '    WHERE '#10;
    s := s + '      (invoiceheads.invoicenumber > 0) '#10;

    if rbtDates.checked then
    begin
      s := s + '    AND ((invoiceheads.ihInvoiceDate >= ' + _DateToDBDate(zdtFrom, true) + ')  AND (invoiceheads.ihInvoiceDate <= ' + _DateToDBDate(zDTTo, true)
        + ')) ';
    end;

    if (rbtInvoices.checked) or (rbtLast.checked) then
    begin
      s := s + '    AND ((invoiceheads.InvoiceNumber >= ' + _db(zInvoiceFrom) + ')  AND (invoiceheads.InvoiceNumber <= ' + _db(zInvoiceTo) + ')) ';
    end;

    if (rbtFreeText.checked) then
    begin
      case cbxTxtType.ItemIndex of
        0 :
          begin // InvoiceNumber;
            s := s + '  AND (invoiceheads.InvoiceNumber=' + _db(edtFreeText.Text) + ') ';
          end;
        1 :
          begin // Kennitala;
            s := s + '  AND (custPID=' + _db(edtFreeText.Text) + ') ';
          end;
        2 :
          begin // Customer Númer;
            s := s + '  AND (Customer=' + _db(edtFreeText.Text) + ') ';
          end;
        3 :
          begin // Nafn Gests eða Fyrirtækis;
            s := s + '  AND ((Name LIKE ' + _db('%' + edtFreeText.Text + '%') + ') OR (RoomGuest LIKE ' + _db('%' + edtFreeText.Text + '%') + ')) ';
          end;
        4 :
          begin // Númer bókunnar;
            if _isInteger(edtFreeText.Text) then
            begin
              s := s + '  AND (Reservation=' + edtFreeText.Text + ') ';
            end
            else
            begin
			        showmessage(GetTranslatedText('shTx_InvoiceList2_BookingNumber'));
            end;
          end;
        5 :
          begin // Númer herbergja bókunnar;
            if _isInteger(edtFreeText.Text) then
            begin
              s := s + '  AND (RoomReservation=' + edtFreeText.Text + ') ';
            end
            else
            begin
      			  showmessage(GetTranslatedText('shTx_InvoiceList2_BookingNumber'))
            end;
          end;
      end;
    end;
    s := s + ' ORDER BY ';
    s := s + '   invoiceheads.InvoiceNumber DESC';

//    copytoclipboard(s);
//    debugMessage(s);

    if hData.rSet_bySQL(rSet,s) then
    begin
       m22_.DisableControls;
      try
        if m22_.active then m22_.Close;
        m22_.open;
        LoadKbmMemtableFromDataSetQuiet(m22_,rset,[]);
        InitSelections;
      finally
         m22_.EnableControls;
      end;
      m22_.First;
    end else
    begin
    end;
  finally
    freeandnil(rSet);
    screen.Cursor := crDefault;
    zRecordCount := m22_.RecordCount;
  end;
end;

procedure TfrmInvoiceList2.sButton1Click(Sender: TObject);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := m22_.fieldbyname('InvoiceNumber').AsInteger;
  ViewInvoice2(InvoiceNumber, true, false, false,false, '');
end;

procedure TfrmInvoiceList2.sButton2Click(Sender: TObject);
begin
  tvInvoiceHead.ApplyBestFit();
end;

procedure TfrmInvoiceList2.InitSelections;
begin
  m22_.First;
  while NOT m22_.Eof do
  begin
    m22_.Edit;
    m22_['RowSelected'] := False;
    m22_.Post;
    m22_.Next;
  end;
  m22_.First;
end;

function TfrmInvoiceList2.GetSelectedInvoices : String;
begin
  result := '';
  m22_.DisableControls;
  try
    m22_.First;
    while NOT m22_.Eof do
    begin
      if (m22_['RowSelected']) then
      begin
        if result = '' then
          result := inttostr(m22_['InvoiceNumber'])
        else
          result := result + ',' + inttostr(m22_['InvoiceNumber']);
      end;
      m22_.Next;
    end;
  finally
     m22_.EnableControls;
  end;
  m22_.First;
end;

procedure TfrmInvoiceList2.btnExportClick(Sender: TObject);
begin
  PostInvoicesToBookKeepingSystem(GetSelectedInvoices);
end;

procedure TfrmInvoiceList2.LMDSpeedButton3Click(Sender : TObject);
begin
  RunQuery;
end;

procedure TfrmInvoiceList2.FormShow(Sender : TObject);
begin
  cbxPeriod.ItemIndex := 0;
  cbxTxtType.ItemIndex := 0;
  zLastInvoiceID := hdata.IVH_GetLastID();
  firstTime := false;

  frmInvoiceList2.ActiveControl := edtLast;

  if rbtLast.checked then
  begin
    zLast := edtLast.Value;
    zInvoiceTo := zLastInvoiceID;
    zInvoiceFrom := zLastInvoiceID - zLast + 1;
  end;

  RunQuery;
end;

procedure TfrmInvoiceList2.edtInvoiceFromChange(Sender: TObject);
begin
  if edtInvoiceTo.value < edtInvoiceFrom.value then
    edtInvoiceTo.Value := edtInvoiceFrom.value;
  zInvoiceFrom := edtInvoiceFrom.value;
end;

procedure TfrmInvoiceList2.edtInvoiceToChange(Sender: TObject);
begin
  if edtInvoiceTo.value < edtInvoiceFrom.Value then
    edtInvoiceTo.Value := edtInvoiceFrom.value;
  zInvoiceTo := edtInvoiceTo.value;
end;

procedure TfrmInvoiceList2.doFilter;
begin
end;

procedure TfrmInvoiceList2.runFilter;
begin
end;

function TfrmInvoiceList2.GetGridFielNamesIndex(sFieldname : string) : integer;
begin
  result := 0;
end;

procedure TfrmInvoiceList2.tvInvDblClick(Sender: TObject);
begin
  ViewInvoice;
end;

procedure TfrmInvoiceList2.tvInvoiceHeadAmountGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmInvoiceList2.tvInvoiceHeadDblClick(Sender: TObject);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := m22_.fieldbyname('InvoiceNumber').AsInteger;
  ViewInvoice2(InvoiceNumber, false, false, false,false, '');
end;

procedure TfrmInvoiceList2.tvInvoiceHeadTaxesGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmInvoiceList2.tvInvoiceHeadVATGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmInvoiceList2.tvInvoiceHeadWithOutVATGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
AProperties := d.getCurrencyProperties(g.qNativeCurrency);
end;

procedure TfrmInvoiceList2.LMDSpeedButton5Click(Sender : TObject);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := m22_.fieldbyname('invoicenumber').AsInteger;
  d.CreateMtFields;
  d.InsertMTdata(InvoiceNumber, true, false,false);
end;

procedure TfrmInvoiceList2.btnClearClick(Sender: TObject);
begin
  edFilter.Text := '';
end;

procedure TfrmInvoiceList2.btnReservationClick(Sender : TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
begin
  iReservation := m22_.fieldbyname('Reservation').AsInteger;
  iRoomReservation := m22_.fieldbyname('RoomReservation').AsInteger;

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

procedure TfrmInvoiceList2.LMDSpeedButton1Click(Sender : TObject);
var
  iReservation : integer;
  iRoomReservation : integer;
  sName : string;
  theData : recPersonHolder;
begin
  sName := m22_.fieldbyname('RoomGuest').asstring;
  iReservation := m22_.fieldbyname('Reservation').AsInteger;
  iRoomReservation := m22_.fieldbyname('RoomReservation').AsInteger;

  if (iReservation > 0) and (iRoomReservation = 0) then
  begin
    showmessage(GetTranslatedText('shTx_InvoiceList2_GroupInvoice'));
    exit;
  end;


  initPersonHolder(theData);
  theData.RoomReservation := iRoomreservation;
  theData.Reservation := iReservation;
  theData.name := sName;

  if openGuestProfile(actNone,theData) then
  begin
    //**
  end;
end;

procedure TfrmInvoiceList2.LMDButton1Click(Sender : TObject);
var
  iRoomReservation : integer;
begin

  iRoomReservation := m22_.fieldbyname('roomReservation').AsInteger;

  if iRoomReservation = 0 then
  begin
    showmessage(GetTranslatedText('shTx_InvoiceList2_NotRoomInvoice'));
    exit;
  end;

  zRoom := d.RR_GetRoomNr(iRoomReservation);
  zArrival := d.RR_GetArrivalDate(iRoomReservation);
end;

procedure TfrmInvoiceList2.btnViewInvoiceClick(Sender : TObject);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := m22_.fieldbyname('InvoiceNumber').AsInteger;
  ViewInvoice2(InvoiceNumber, false, false, false,false, '');
end;

procedure TfrmInvoiceList2.ViewInvoice;
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := m22_.fieldbyname('InvoiceNumber').AsInteger;
  ViewInvoice2(InvoiceNumber, false, false, false,false, '');
end;


procedure TfrmInvoiceList2.LMDSpeedButton6Click(Sender : TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := g.qProgramPath + s + '_Invoicelist';
  ExportGridToExcel(sFilename, grInvoicehead, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmInvoiceList2.LMDSpeedButton7Click(Sender : TObject);
var
  InvoiceNumber : integer;
  i : integer;
begin
  i := 0;
  m22_.First;
  while not m22_.Eof do
  begin
    inc(i);
    InvoiceNumber := m22_.fieldbyname('invoicenumber').AsInteger;
    d.CreateMtFields;
    d.InsertMTdata(InvoiceNumber, true, true,false);
    application.ProcessMessages;
    m22_.Next;
  end;
end;

end.

