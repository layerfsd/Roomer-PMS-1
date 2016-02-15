unit uFinishedInvoices2;

(* 130206 - Jóel
          Breytti textum sjá excel skjal *)

interface

uses
    Windows
  , Messages
  , SysUtils
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , ComCtrls
  , ExtCtrls
  , ImgList
  , StdCtrls


  , uInvoiceSummeryOBJ

  , BaseGrid
  , AdvGrid
  , AdvObj
  , Grids

  , hdata
  , PrjConst
  , ug
  , _GLOB

  , DB
  , kbmMemTable
  , Mask

  , frxClass
  , frxDBSet
  , frxDesgn
  , frxExportImage
  , frxExportRTF
  , frxExportHTML
  , frxExportPDF
  , frxExportMail
  , IOUtils

  , NativeXML

  , cmpRoomerDataSet
  , uFileSystemUtils
  , cmpRoomerConnection

  , sEdit
  , sTabControl
  , sLabel
  , sPanel
  , sButton
  , sMemo
  , sGroupBox
  , sCheckBox

  , cxPropertiesStore
  , cxClasses, AdvUtil


  ;




TYPE
//  TCurrencyTypes = (ctLocal, ctForeigin);
//  TCreditTypes   = (crDebit, crCredit, crCash);

  TfrmFinishedInvoices2 = class(TForm)
    FriendlyStatusBar1: TStatusBar;
    LMDBackPanel1: TsPanel;
    btnPrint: TsButton;
    LMDSpeedButton5: TsButton;
    frxDesigner1: TfrxDesigner;
    btnDesign: TsButton;
    rptDsLines: TfrxDBDataset;
    rptDs1: TfrxDBDataset;
    rptDsPayments: TfrxDBDataset;
    rptDsVAT: TfrxDBDataset;
    rptDsCompany: TfrxDBDataset;
    rptDsCaptions: TfrxDBDataset;
    Panel1: TsPanel;
    tcPages: TsTabControl;
    Panel3: TsPanel;
    labHeadInfoDate: TsLabel;
    Label13: TsLabel;
    labHead: TsLabel;
    Label12: TsLabel;
    Label15: TsLabel;
    GroupBox1: TsGroupBox;
    Label1: TsLabel;
    Label2: TsLabel;
    Label4: TsLabel;
    Label14: TsLabel;
    edtName: TsEdit;
    edtAddress1: TsEdit;
    edtAddress2: TsEdit;
    edtAddress3: TsEdit;
    edtCustomer: TsEdit;
    edtPersonalId: TsEdit;
    edtDate: TsEdit;
    edtCurrency: TsEdit;
    edtBreakfast: TsEdit;
    memExtraText: TsMemo;
    edtCurrencyRate: TsEdit;
    LMDSimplePanel1: TsPanel;
    Panel2: TsPanel;
    Label7: TsLabel;
    Label8: TsLabel;
    Label9: TsLabel;
    Label10: TsLabel;
    lblForeignCurrency: TsLabel;
    edtTotal: TsEdit;
    edtVat: TsEdit;
    edtInvoiceTotal: TsEdit;
    edtForeignCurrency: TsEdit;
    LMDSimplePanel2: TsPanel;
    LMDBackPanel2: TsPanel;
    LMDSimpleLabel1: TsLabel;
    agrVSK: TAdvStringGrid;
    LMDSimplePanel3: TsPanel;
    LMDBackPanel3: TsPanel;
    LMDSimpleLabel2: TsLabel;
    agrPayments: TAdvStringGrid;
    labReikningur: TsLabel;
    edtPaydate: TsEdit;
    edtReservation: TsEdit;
    edtKreditInvoice: TsEdit;
    edtOrginalInvoice: TsEdit;
    Label16: TsLabel;
    Label17: TsLabel;
    Label19: TsLabel;
    Label20: TsLabel;
    Label18: TsLabel;
    edtGuestName: TsEdit;
    edtRoom: TsEdit;
    Label21: TsLabel;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxRTFExport1: TfrxRTFExport;
    frxJPEGExport1: TfrxJPEGExport;
    timClose: TTimer;
    frxMailExport1: TfrxMailExport;
    btnEmailSend: TsButton;
    LMDSpeedButton3: TsButton;
    edtCountry: TsEdit;
    edtAddress4: TsEdit;
    edtStaff: TsEdit;
    Label5: TsLabel;
    agrLines: TAdvStringGrid;
    LMDSpeedButton2: TsButton;
    labExport: TsLabel;
    edtRefrence: TsEdit;
    Label6: TsLabel;
    Splitter1: TSplitter;
    FormStore: TcxPropertiesStore;
    chkShowPackage: TsCheckBox;
    Label3: TsLabel;
    Label11: TsLabel;
    edtPayments: TsEdit;
    frxReport1: TfrxReport;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tcPagesChange(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel3Resize(Sender: TObject);
    procedure agrVSKGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure agrLinesGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure agrPaymentsGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure LMDSpeedButton1Click(Sender: TObject);
    procedure lstViewTypeChange(Sender: TObject);
    procedure btnDesignClick(Sender: TObject);
    procedure timCloseTimer(Sender: TObject);
    procedure btnEmailSendClick(Sender: TObject);
    procedure LMDSpeedButton3Click(Sender: TObject);
    procedure LMDSpeedButton2Click(Sender: TObject);
    procedure frxReport1PrintPage(Page: TfrxReportPage; CopyNo: Integer);
    procedure frxReport1GetValue(const VarName: string; var Value: Variant);
    procedure frxPDFExport1BeginExport(Sender: TObject);
    function frxReport1UserFunction(const MethodName: string; var Params: Variant): Variant;
    function frxMailExport1SendMail(const Server: string; const Port: Integer; const UserField, PasswordField: string; FromField, ToField, SubjectField, CompanyField, TextField: WideString; FileNames: TStringList; Timeout: Integer;
      ConfurmReading: Boolean): string;


  private
    { Private declarations }
    zForeign : boolean;
    zNative : string;
    procedure DisplayTab;
    procedure DisplayInvoice(InvoiceNumber : integer );
    function  Display : boolean;
    procedure initGrid;
    Procedure doPrint;
    Procedure doSend;
    procedure PerformPrint;


  public
    { Public declarations }
    zType               : TInvoiceTypes;
    zCustomer           : string;
    zRoomRes            : integer;
    zReservation        : integer;
    zInvoiceNumber      : integer;
    zInvKind            : integer; //0=debit 1=Kredit 2=Cash
    zStartprinting      : Boolean;
    zXML_export         : boolean;
    zUseReportPrinter   : boolean;
    zShowPackage        : boolean;
    zEmailAddress       : String;

//    procedure ExportStolpi(invoicenumber : integer);

    procedure WndProc(var Message: TMessage); override;

  end;

var
  frmFinishedInvoices2: TfrmFinishedInvoices2;

procedure ShowFinishedInvoices2( iType    : TInvoiceTypes;
                                Customer : String;
                                iIndex   : integer
                              );

procedure ViewInvoice2(invoiceNumber : integer;
          startprinting : boolean;
          useReportPrinter,
          xmlExport : boolean;
          showpackage:boolean;
          emailAddress : String); //O=Debit 1=Kredit 2=Cash


implementation

uses
    UITypes
  , ADODB
  , DBTables
  , uMain
  , uSqlDefinitions
  , uD
  , uFileDependencyManager
  , uAppGlobal
  , uDImages
  , uStringUtils
  , uEmailingDialog;

{$R *.DFM}

const WM_NoInvoices = WM_USER + 1;


//------------------------------------------------------------------------------
//
//   Usage : When showing invoices (one or more)
//           by InvoiceType
//              itPerCustomer, itPerRoomRes, itPerReservation, itSpecificInvoice
//
//------------------------------------------------------------------------------

procedure ShowFinishedInvoices2(iType    : TInvoiceTypes;
                                Customer : String;
                                iIndex   : integer
                              );
begin
  frmFinishedInvoices2 := TfrmFinishedInvoices2.Create(nil);
  try
    frmFinishedInvoices2.zType        := iType;
    frmFinishedInvoices2.zCustomer    := Customer;
    frmFinishedInvoices2.zRoomRes     := iIndex;
    frmFinishedInvoices2.zReservation := iIndex;
    frmFinishedInvoices2.ShowModal;
  finally
    FreeAndNil(frmFinishedInvoices2);
  end;
end;



//------------------------------------------------------------------------------
//
//   Usage : When showing One Invoice by invoiceNumber
//
//------------------------------------------------------------------------------
procedure ViewInvoice2(invoiceNumber : integer;
          startprinting : boolean;
          useReportPrinter,
          xmlExport : boolean;
          showpackage:boolean;
          emailAddress : String); //O=Debit 1=Kredit 2=Cash
var
  _frmFinishedInvoices2 : TfrmFinishedInvoices2;
begin

  _frmFinishedInvoices2 := TfrmFinishedInvoices2.Create(nil);
  try
    _frmFinishedInvoices2.tcPages.Tabs.clear;
    _frmFinishedInvoices2.zType  := itSpecificInvoice;

    _frmFinishedInvoices2.zInvoiceNumber    := invoiceNumber;
    _frmFinishedInvoices2.zXML_export       :=  XMLexport;
    _frmFinishedInvoices2.zEmailAddress     := EmailAddress;
//  _frmFinishedInvoices2.zInvKind  := invKind;

    _frmFinishedInvoices2.zStartPrinting    := StartPrinting;
    _frmFinishedInvoices2.zuseReportPrinter := useReportPrinter;
    _frmFinishedInvoices2.zShowpackage      := showPackage;

    if StartPrinting then
      _frmFinishedInvoices2.PerformPrint
    else
      _frmFinishedInvoices2.ShowModal;
  finally
    FreeAndNil(_frmFinishedInvoices2);
  end;
end;


const
  vWidth  : integer   = 10;
  vDec    : integer   =  2;

  colItemID         : integer = 0;
  colDescription    : integer = 1;
  colItemCount      : integer = 2;
  colPrice          : integer = 3;
  colTotal          : integer = 4;
  colExtra          : integer = 5;

  colvatType        : integer = 0;
  colvatTotalWoWat  : integer = 1;
  colvatVatProcent  : integer = 2;
  colvatVat         : integer = 3;

  colPaymentType    : integer = 0;
  colPaymentAmount  : integer = 1;
  colPaymentDate    : integer = 2;

var
  zCurrency       : string;         // Gjaldmiðill;
  zCurrencyRate   : double;         // Gengi


procedure TfrmFinishedInvoices2.WndProc( var Message: TMessage );
begin
  if Message.Msg = WM_NoInvoices then
  begin
    //MessageDlg( 'No finished invoices found for your selection',
	  MessageDlg(GetTranslatedText('shTx_FinishedInvoices2_NoFinishedInvoices'),
                mtInformation,
                [ mbOK ],
                0
                );
    close;
  end else
  begin
    inherited;
  end;
end;


procedure TfrmFinishedInvoices2.initGrid;
begin
  EmptyStringGrid( agrLines );
  agrLines.ColCount := 6;
  agrLines.RowCount := 2;

  agrLines.ColWidths[colItemID]      := 100;
  agrLines.ColWidths[colDescription] := 120;
  agrLines.ColWidths[colItemCount]   :=  90;
  agrLines.ColWidths[colPrice]       :=  90;
  agrLines.ColWidths[colTotal]       :=  90;
  agrLines.ColWidths[colExtra]       :=  25;

  agrLines.ColumnSize.StretchColumn  := 1;
  agrLines.ColumnSize.Stretch        := true;

  agrLines.Cells[colItemID     ,0] := GetTranslatedText('shTx_FinishedInvoices2_Product');
  agrLines.Cells[colDescription,0] := GetTranslatedText('shTx_FinishedInvoices2_Description');
  agrLines.Cells[colItemCount  ,0] := GetTranslatedText('shTx_FinishedInvoices2_Number');
  agrLines.Cells[colPrice      ,0] := GetTranslatedText('shTx_FinishedInvoices2_Value');
  agrLines.Cells[colTotal      ,0] := GetTranslatedText('shTx_FinishedInvoices2_Total');
  agrLines.Cells[colExtra      ,0] := '!';

  // agrVSK
  EmptyStringGrid(agrVSK );

  agrVSK.ColCount   := 4;
  agrVSK.RowCount   := 2;

  agrVSK.ColWidths[colvatType      ] := 90;
  agrVSK.ColWidths[colvatTotalWoWat] := 90;
  agrVSK.ColWidths[colvatVatProcent] := 50;
  agrVSK.ColWidths[colvatVat       ] := 90;

  agrVSK.ColumnSize.StretchColumn := 0;
  agrVSK.ColumnSize.Stretch       := true;

  agrVSK.Cells[colvatType        ,0] := GetTranslatedText('shTx_FinishedInvoices2_Category');
  agrVSK.Cells[colvatTotalWoWat  ,0] := GetTranslatedText('shTx_FinishedInvoices2_Amount');
  agrVSK.Cells[colvatVatProcent  ,0] := '%';
  agrVSK.Cells[colvatVat         ,0] := GetTranslatedText('shTx_FinishedInvoices2_VAT');

  // agrPayments
  EmptyStringGrid(agrPayments );
  agrPayments.ColCount   := 3;
  agrPayments.RowCount   := 2;

  agrPayments.ColWidths[colvatType      ] := 70;
  agrPayments.ColWidths[colvatTotalWoWat] := 70;
  agrPayments.ColWidths[colPaymentDate]   := 70;

  agrPayments.ColumnSize.StretchColumn := 0;
  agrPayments.ColumnSize.Stretch       := true;

  // agrPayments.Cells[colPaymentType    ,0] := 'Category';
  // agrPayments.Cells[colPaymentAmount  ,0] := 'Amount';
  // agrPayments.Cells[colPaymentDate    ,0] := 'Date';
  agrPayments.Cells[colPaymentType    ,0] := GetTranslatedText('shTx_FinishedInvoices2_Category');
  agrPayments.Cells[colPaymentAmount  ,0] := GetTranslatedText('shTx_FinishedInvoices2_Amount');
  agrPayments.Cells[colPaymentDate    ,0] := GetTranslatedText('shTx_FinishedInvoices2_Date');
end;


procedure TfrmFinishedInvoices2.DisplayInvoice(invoiceNumber : integer);

var
  i          : integer;
  iRowIndex  : integer;
  s          : string;
  IvI        : TInvoiceInfo;
  doExport   : boolean;
  TotalPayments : Double;
  PaymentData : recPaymentHolder;
  invoiceData : recInvoiceHeadHolder;

begin
  initPaymentHolderRec(PaymentData);
  initInvoiceHeadHolderRec(invoiceData);

  initGrid;
  zInvoiceNumber := invoiceNumber;
  IvI := TInvoiceInfo.create(zInvoiceNumber,paymentData,invoiceData);
  try

    try
      IvI.UpdateInfo(invoicedata);
      Ivi.GatherPayments(doExport,paymentData,invoiceData);


      if ivi.KreditType = ktKredit then
      begin
        ivi.ivhTotal            := ivi.ivhTotal              *-1;
        ivi.ivhTotal_woVat      := ivi.ivhTotal_woVat        *-1;
        ivi.ivhTotal_VAT        := ivi.ivhTotal_VAT          *-1;
        ivi.ivhTotal_Currency   := ivi.ivhTotal_Currency     *-1;
        ivi.ivhTotalBreakFast   := ivi.ivhTotalBreakFast     *-1;

        for i := 0 to ivi.lineCount-1 do
        begin
          ivi.LinesList[i].Price        :=   ivi.LinesList[i].Price        *-1;
          ivi.LinesList[i].TotalPrice   :=   ivi.LinesList[i].TotalPrice   *-1;
        end;

        for i := 0 to ivi.paymentCount-1 do
        begin
          ivi.PaymentList[i].pmAmount   :=   ivi.PaymentList[i].pmAmount   *-1;
        end;

        for i := 0 to ivi.VATcount-1 do
        begin
          ivi.VATList[i].Price_woVAT    :=   ivi.VATList[i].Price_woVAT    *-1;
          ivi.VATList[i].Price_wVAT     :=   ivi.VATList[i].Price_wVAT     *-1;
          ivi.VATList[i].VATAmount      :=   ivi.VATList[i].VATAmount      *-1;
        end;
      end;

      zCurrency := ivi.Currency;
      zNative := ctrlGetString('NativeCurrency');

      zForeign := false;
      if _trimlower(zNative) <> _trimlower(zCurrency) then
      begin
        zForeign := true;
      end;

      labHeadInfoDate.caption := _islErl(ivi.invTxtHeadInfoDate,zForeign);

      if ivi.KreditType = ktDebit then
      begin
        labReikningur.Caption := _islErl(ivi.invTxtHeadDebit,zForeign)+' - '+inttostr(zInvoiceNumber);
        Panel3.Color := $00EAFFEA;                      // $00EAFFEA
        Panel2.Color := $00EAFFEA;                      // $00EAFFEA
      end else
      begin
        labReikningur.Caption := _islErl(ivi.invTxtHeadKredit,zForeign)+' - '+inttostr(zInvoiceNumber);
        Panel3.Color := $00F5ECFF;                      // $00EAFFEA
        Panel2.Color := $00F5ECFF;                      // $00EAFFEA
      end;

      chkShowpackage.checked := ivi.IvhShowPackage;

//      chkShowPackage.Checked  := ivi.CustomerInfo.IvShowPackage;
      edtCustomer.text        := ivi.CustomerInfo.IvCustomer;
      edtName.text            := ivi.CustomerInfo.IvName;
      edtAddress1.text        := ivi.CustomerInfo.IvAddress1;
      edtAddress2.text        := ivi.CustomerInfo.IvAddress2;
      edtAddress3.text        := ivi.CustomerInfo.IvAddress3;
      edtAddress4.text        := ivi.CustomerInfo.IvAddress4;

      edtCountry.text         := ivi.CustomerInfo.IvCountry;
      edtPersonalId.text      := ivi.CustomerInfo.IvPid;
      edtBreakfast.text       := _FloatToStr(ivi.ivhTotalBreakFast,0,0);
      memExtraText.lines.text := ivi.ivhExtraText;
      edtDate.text            := DateToStr(ivi.ivhDate);
      edtPayDate.text         := DateToStr(ivi.ivhPayDate);
      edtStaff.text           := ivi.ivhStaff;

      zCurrencyRate           := ivi.CurrencyRate;
      edtCurrencyRate.text    := _FloatToStr(zCurrencyRate, 0, 4);

      edtCurrency.text        := zCurrency;

      edtReservation.text    := inttostr(ivi.ivhReservation)+' / '+inttostr(ivi.ivhRoomReservation);
      edtKreditInvoice.text  := inttostr(ivi.ivhCreditInvoice);
      edtOrginalInvoice.text := inttostr(ivi.ivhOriginalInvoice);
      edtrEFRENCE.text       := ivi.ivhRefrence;
      edtGuestName.text      := ivi.CustomerInfo.IvRoomGuest;
      edtRoom.text           := ivi.ivhRoomNumber;

      iRowIndex := 0;
      for i := 0 to ivi.lineCount-1 do
      begin
        inc(iRowIndex );
        agrLines.RowCount := iRowIndex + 1;
//        agrLines.RowHeights[iRowIndex] := 18;

        agrLines.Cells[colItemID     ,iRowIndex] := ivi.LinesList[i].Code;
        agrLines.Cells[colDescription,iRowIndex] := ivi.LinesList[i].Description;
        agrLines.Cells[colItemCount  ,iRowIndex] := _FloatToStr(ivi.LinesList[i].Count,0,2); //-96
        agrLines.Cells[colPrice      ,iRowIndex] := _FloatToStr(ivi.LinesList[i].Price,0,2);
        agrLines.Cells[colTotal      ,iRowIndex] := _FloatToStr(ivi.LinesList[i].TotalPrice,0,2);
        agrLines.Cells[colExtra      ,iRowIndex] := inttostr(iRowIndex);

        if ivi.LinesList[i].ItemKind = ikRoomRent then
        begin
          agrLines.Cells[colExtra      ,iRowIndex] := 'Leiga';
        end;
        if ivi.LinesList[i].ItemKind = ikRoomRentDiscount then
        begin
          agrLines.Cells[colExtra      ,iRowIndex] := 'Leiga';
        end;
      end;

      edtTotal.text        := _FloatToStr(ivi.ivhTotal_woVat, vWidth, vDec);
      edtVAT.text          := _FloatToStr(ivi.ivhTotal_VAT, vWidth, vDec);
      edtInvoiceTotal.text := _FloatToStr(ivi.ivhTotal, vWidth, vDec);
      edtPayments.text     := _FloatToStr(0.00, vWidth, vDec);

      iRowIndex := 0;
      for i := 0 to ivi.VATCount-1 do
      begin
        inc(iRowIndex);
        agrVSK.RowCount := iRowIndex + 1;
//      agrVSK.RowHeights[iRowIndex] := 18;
        agrVSK.Cells[colvatType      ,iRowIndex] := ivi.VATList[i].VATDescription;
        agrVSK.Cells[colvatTotalWoWat,iRowIndex] := _PriceRoundToStr(ivi.VATList[i].Price_woVAT   ,50,  3,  '',  ' '+zNative);
        agrVSK.Cells[colvatVatProcent,iRowIndex] := _PriceRoundToStr(ivi.VATList[i].VATPercentage ,50,  2,  '',  '%'  );
        agrVSK.Cells[colvatVat       ,iRowIndex] := _PriceRoundToStr(ivi.VATList[i].VATAmount     ,50,  1,  '',  ' '+zNative);
      end;
      if ivi.VATCount > 1 then
      begin
        inc(iRowIndex);
        agrVSK.RowCount := iRowIndex + 1;
//        agrVSK.RowHeights[iRowIndex] := 18;
        agrVSK.RowColor[iRowIndex] := clGray;
        agrVSK.RowFontColor[iRowIndex]:= clWhite;
        agrVSK.Cells[colvatType,iRowIndex] := 'Total:';
        agrVSK.Cells[colvatVat,iRowIndex] := trim(_FloatToStr(ivi.ivhTotal_VAT, vWidth, vDec ));
      end;

      TotalPayments := 0.00;
      iRowIndex := 0;
      for i := 0 to ivi.paymentCount-1 do
      begin
        inc(iRowIndex);
        agrPayments.RowCount := iRowIndex + 1;
//        agrPayments.RowHeights[iRowIndex] := 18;
        agrPayments.Cells[colPaymentType   ,iRowIndex] := ivi.PaymentList[i].pmCode;
        agrPayments.Cells[colPaymentAmount ,iRowIndex] := _FloatToStr(ivi.PaymentList[i].pmAmount , vWidth, vDec );
        TotalPayments := TotalPayments + ivi.PaymentList[i].pmAmount;
        dateTimeToString(s,'dd.mm.yyyy',ivi.PaymentList[i].pmDate);
        agrPayments.Cells[colPaymentDate   ,iRowIndex] := S;
      end;

      if ivi.paymentCount > 1 then
      begin
        inc(iRowIndex);
        agrPayments.RowCount := iRowIndex + 1;
//        agrPayments.RowHeights[iRowIndex]  := 18;
        agrPayments.RowColor[iRowIndex]    := clGray;
        agrPayments.RowFontColor[iRowIndex]:= clWhite;
        agrPayments.Cells[colPaymentType  ,iRowIndex] := 'Total:';
        agrPayments.Cells[colPaymentAmount,iRowIndex] := trim(_FloatToStr(ivi.TotalPayments, vWidth, vDec ));
      end;

      edtPayments.text     := _FloatToStr(TotalPayments, vWidth, vDec);
      edtPayments.Visible := False;
      Label11.Visible := False;

    finally
    end;
  finally
    IvI.Free;
  end;
end;

procedure TfrmFinishedInvoices2.DisplayTab;
var
  i : integer;
begin
  i := integer(tcPages.Tabs.Objects[tcPages.TabIndex ]);
  DisplayInvoice(i);
end;

function TfrmFinishedInvoices2.Display : boolean;
var
  rSet : TRoomerDataSet;
  s      : string;
begin
  result := false;

  rSet := CreateNewDataSet;
  try
    s := '';
    s := s+ 'select * from [invoiceheads] ';
    s := s+ ' where [InvoiceNumber] <> -1 ' ;
    case zType of
      itPerCustomer    : s := s+ 'and [Customer] = '        + QuotedStr( zCustomer ) ;
      itPerRoomRes     : s := s+ 'and [RoomReservation] = ' + inttoStr( zRoomRes ) ;
      itPerReservation : s := s+ 'and [Reservation] = '     + inttoStr( zReservation ) ;
    end;

    if hData.rSet_bySQL(rSet,s) then
   	begin
      tcPages.Tabs.clear;
      result := true;

      while not rset.eof do
      begin
        tcPages.Tabs.AddObject( DateToStr( _DBDateToDate( rset.fieldByName( 'InvoiceDate' ).asString ) ) + ' R.' + inttostr( rSet.fieldByName( 'InvoiceNumber' ).asInteger ),
                                         pointer( rSet.fieldByName( 'InvoiceNumber' ).asInteger ) );
        rSet.next;
      end;
    end;
  finally
    freeandnil(rset);
  end;

  if result then
  begin
     if tcPages.Tabs.count > 0 then tcPages.TabIndex := 0;
     DisplayTab;
  end;
end;

procedure TfrmFinishedInvoices2.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFinishedInvoices2.PerformPrint;
begin
  d.CreateMtFields;
  doPrint;
end;

procedure TfrmFinishedInvoices2.FormShow(Sender: TObject);
begin
  d.CreateMtFields;

  if zStartprinting then
  begin
    doPrint;
    timClose.Enabled := true;
  end else
  begin
    if zType = itSpecificInvoice then
    begin
      DisplayInvoice(zInvoiceNumber);
    end else
    if not Display then
    begin
      postMessage( handle, WM_NoInvoices, 0, 0 );
    end;
  end;
end;

procedure TfrmFinishedInvoices2.tcPagesChange(Sender: TObject);
begin
  DisplayTab;
end;


procedure TfrmFinishedInvoices2.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);

  zForeign := false;
  zStartPrinting    := false;
  zUseReportPrinter := false;
end;

procedure TfrmFinishedInvoices2.Panel3Resize(Sender: TObject);
begin
//  memExtraText.Width := Panel3.Width - GroupBox1.Width - 10;
end;

procedure TfrmFinishedInvoices2.agrVSKGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  case Acol of
    0 : Halign := taLeftJustify;
    1 : Halign := taRightJustify;
    2 : Halign := taRightJustify;
    3 : Halign := taRightJustify;
  end;
end;

procedure TfrmFinishedInvoices2.agrLinesGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  case Acol of
    0 : Halign := taLeftJustify;
    1 : Halign := taLeftJustify;
    2 : Halign := taRightJustify;
    3 : Halign := taRightJustify;
    4 : Halign := taRightJustify;
  end;
end;

procedure TfrmFinishedInvoices2.agrPaymentsGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  case Acol of
    0 : Halign := taLeftJustify;
    1 : Halign := taRightJustify;
    2 : Halign := taLeftJustify;
  end;
end;

procedure TfrmFinishedInvoices2.LMDSpeedButton1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmFinishedInvoices2.lstViewTypeChange(Sender: TObject);
begin
//  DisplayTotals;
end;



Procedure TfrmFinishedInvoices2.doPrint;
var
  FileName        : string;
  NativeCurrency  : string;
  Currency       : string;
  s : string;
  showpackage : boolean;
begin
  datetimetostring(s,'yyyyddmmhhnn',now);
  frxPDFExport1.FileName := 'Invoice_'+inttostr(zInvoiceNumber)+'.pdf';
  frxHTMLExport1.FileName := 'Invoice_'+inttostr(zInvoiceNumber)+'.xls';
  frxHTMLExport1.FileName := 'Invoice_'+inttostr(zInvoiceNumber)+'.html';
  frxRTFExport1.FileName := 'Invoice_'+inttostr(zInvoiceNumber)+'.rtf';
  frxJPEGExport1.FileName := 'Invoice_'+inttostr(zInvoiceNumber)+'.jpg';

  frxMailExport1.Address := zEmailAddress;  // get from customer table
//  frxMailExport1.Subject := '';  // get from controle
//
//  frxMailExport1.Lines := ''; //Get from controle (some kind of template)
//  frxMailExport1.FromMail := ''; //?
//  frxMailExport1.FromName := ''; //?
//  frxMailExport1.FromCompany := ''; //?
//
//  frxMailExport1.Signature := ''; //?
//  frxMailExport1.SmtpHost := ''; //?
//  frxMailExport1.SmtpPort := ''; //?
//
//  frxMailExport1.UseMAPI
//  frxMailExport1.ShowDialog
//  frxMailExport1.ShowProgress


  showPackage := chkShowPackage.Checked or zShowPackage;

  d.InsertMTdata(zInvoiceNumber,zXML_export,false,ShowPackage);

//  try
//    Filename := getLocalInvoiceFilePath;
//  Except
//    on e: Exception do begin
//      DebugMessage(e.Message);
//      raise;
//    end;
//  end;

  NativeCurrency  := _trimlower(ctrlGetString('NativeCurrency'));
  currency := d.GetInvoiceCurrency(zInvoiceNumber);


  if _trimlower(NativeCurrency) <> _trimLower(Currency) then
  begin
    try
      Filename := getForeignInvoiceFilePath;
    EXCEPT
      on e: Exception do begin
        DebugMessage(e.Message);
        raise;
      end;
    end;
  end else
  begin
    TRY
      Filename := getLocalInvoiceFilePath;
    EXCEPT
      on e: Exception do begin
        DebugMessage(e.Message);
        raise;
      end;
    END;
  end;

  if (not fileExists(filename)) OR (uFileSystemUtils.GetFileSize(filename) = 0) then
  begin
  	showmessage(format(GetTranslatedText('shTx_FinishedInvoices2_FileNotFound'), [filename]));
    exit;
  end;

  frxReport1.LoadFromFile(filename);
  frxReport1.PrintOptions.Printer := 'Default';


  if zuseReportPrinter then
  begin
    if g.qReportPrinter <> '' then
    begin
      frxReport1.PrintOptions.Printer := g.qReportPrinter;
    end;
  end else
  begin
    if g.qInvoicePrinter <> '' then
    begin
      frxReport1.PrintOptions.Printer := g.qInvoicePrinter;
    end;
  end;


  frxReport1.ShowReport(false);

  if d.mtHead_.Active then d.mtHead_.Close;
  if d.mtLines_.Active then d.mtLines_.Close;
  if d.mtPayments_.Active then d.mtPayments_.Close;
  if d.mtVAT_.Active then d.mtVAT_.Close;
  if d.mtCompany_.Active then d.mtCompany_.Close;
  if d.mtCaptions_.Active then d.mtCaptions_.Close;

  if zStartPrinting then
  begin
    close;
  end;

end;


Procedure TfrmFinishedInvoices2.doSend;
var
  FileName : string;
  Currency       : string;
begin
  d.InsertMTdata(zInvoiceNumber,zXML_export,false,false);

  TRY
    Filename := getLocalInvoiceFilePath;
  EXCEPT
  END;

  currency := d.GetInvoiceCurrency(zInvoiceNumber);
  if _trimlower(ctrlGetString('NativeCurrency')) <> _trimlower(Currency) then
  begin
    TRY
      Filename := getForeignInvoiceFilePath;;
    EXCEPT
    END;
  end;

  if not fileExists(filename) then
  begin
  	showmessage(format(GetTranslatedText('shTx_FinishedInvoices2_FileNotFound'), [filename]));
    exit;
  end;

  frxReport1.LoadFromFile(filename);

  frxReport1.PrintOptions.Printer := 'Default';

  if zuseReportPrinter then
  begin
    if g.qReportPrinter <> '' then
    begin
      frxReport1.PrintOptions.Printer := g.qReportPrinter;
    end;
  end else
  begin
    if g.qInvoicePrinter <> '' then
    begin
      frxReport1.PrintOptions.Printer := g.qInvoicePrinter;
    end;
  end;

  FrxReport1.PrepareReport(false);

  frxPDFExport1.Report          := frxReport1;
  frxPDFExport1.Compressed      := true;
  frxPDFExport1.FileName        := d.mtHead_.fieldbyname('Customer').AsString +'_'+ d.mtHead_.fieldbyname('InvoiceNumber').AsString+'.pdf';

  if fileexists(frxPDFExport1.FileName) then
  begin
    try
      deleteFile(frxPDFExport1.FileName);
    except
    end;
  end;

  frxPDFExport1.DefaultPath     := CtrlGetString('invEmailDefaultPath');
  frxPDFExport1.ShowDialog      := false;

  try
    FrxReport1.Export(frxPdfExport1);
  except
  end;


  if d.mtHead_.Active then d.mtHead_.Close;
  if d.mtLines_.Active then d.mtLines_.Close;
  if d.mtPayments_.Active then d.mtPayments_.Close;
  if d.mtVAT_.Active then d.mtVAT_.Close;
  if d.mtCompany_.Active then d.mtCompany_.Close;
  if d.mtCaptions_.Active then d.mtCaptions_.Close;

  if zStartPrinting then
  begin
    close;
  end;
end;




procedure TfrmFinishedInvoices2.btnPrintClick(Sender: TObject);
begin
  doPrint;
end;



procedure TfrmFinishedInvoices2.btnDesignClick(Sender: TObject);
var
  fileName : string;
  currency : string;
begin
  d.InsertMTdata(zInvoiceNumber,false,false,chkShowPackage.Checked);
  TRY
    Filename := getLocalInvoiceFilePath;
  EXCEPT
  END;

  currency := d.GetInvoiceCurrency(zInvoiceNumber);
  if _trimlower(ctrlGetString('NativeCurrency')) <> _trimlower(Currency) then
  begin
    TRY
      Filename := getForeignInvoiceFilePath;;
    EXCEPT
    END;
  end;

  if not fileExists(filename) then
  begin
  	showmessage(format(GetTranslatedText('shTx_FinishedInvoices2_FileNotFound'), [filename]));
    exit;
  end;

  frxReport1.LoadFromFile(filename);


  frxReport1.DesignReport(true);

  if d.mtHead_.Active then d.mtHead_.Close;
  if d.mtLines_.Active then d.mtLines_.Close;
  if d.mtPayments_.Active then d.mtPayments_.Close;
  if d.mtVAT_.Active then d.mtVAT_.Close;
  if d.mtCompany_.Active then d.mtCompany_.Close;
  if d.mtCaptions_.Active then d.mtCaptions_.Close;

  try
    frxReport1.LoadFromFile('');
  except
  end;
  frxReport1.Clear;

  sendChangedFile(filename);
end;

procedure TfrmFinishedInvoices2.timCloseTimer(Sender: TObject);
begin
  timClose.Enabled := false;
  close;
end;

procedure TfrmFinishedInvoices2.btnEmailSendClick(Sender: TObject);
begin
  doSend;
end;

procedure TfrmFinishedInvoices2.LMDSpeedButton3Click(Sender: TObject);
begin
  //if MessageDlg('This account will be recreated - no change is made to older account',
  if MessageDlg(GetTranslatedText('shTx_FinishedInvoices2_NoChange'),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    D.CopyInvoiceToInvoiceLinesTmp(zInvoiceNumber,false);
  end;
end;


procedure TfrmFinishedInvoices2.LMDSpeedButton2Click(Sender: TObject);
begin
  d.InsertMTdata(zInvoiceNumber,true,false,false);
end;

function TfrmFinishedInvoices2.frxMailExport1SendMail(const Server: string; const Port: Integer; const UserField, PasswordField: string; FromField, ToField, SubjectField, CompanyField, TextField: WideString; FileNames: TStringList; Timeout: Integer;
  ConfurmReading: Boolean): string;
var filename : String;
    List : TStringList;
begin
  //
//   ShowMEssage(filenames.Text);
   frxPDFExport1.ShowDialog := False;
   frxPDFExport1.ShowProgress := False;
   try
     filename := CreateNewFileName(TPath.Combine(GetTempPath, 'Invoice'), '.pdf');
     frxPDFExport1.Filename := filename;
     List := TStringList.Create;
     List.Add(filename + '=invoice.pdf');
     frxReport1.Export(frxPDFExport1);
   finally
     frxPDFExport1.ShowDialog := True;
     frxPDFExport1.ShowProgress := True;
   end;
   try
     if sendFileAsAttachment(ToField, GetTranslatedText('shTxEmailInvoice'), list) then;
   finally
     if fileExists(filename) then
       try
         DeleteFile(filename);
       except
         // Is okey if it fails
       end;
   end;
end;

procedure TfrmFinishedInvoices2.frxPDFExport1BeginExport(Sender: TObject);
//var
//  s : string;
begin
//  datetimetostring(s,'yyyy-dd-mm hh-nn',now);
//  frxPDFExport1.FileName := 'Invoice_'+inttostr(zInvoiceNumber)+s+'.pdf';
end;

procedure TfrmFinishedInvoices2.frxReport1GetValue(const VarName: string; var Value: Variant);
begin
//  DebugMessage(VarName);
end;

procedure TfrmFinishedInvoices2.frxReport1PrintPage(Page: TfrxReportPage; CopyNo: Integer);
var
  ar : TInvoiceActionRec;
  s : string;

begin
//    d.InsertMTdata(zInvoiceNumber,false,false);
//    frxReport1.PrepareReport(true);
    s := frxReport1.PrintOptions.Printer;
    ar.reservation      := d.mtHead_.fieldbyname('Reservation').asInteger;
    ar.RoomReservation  := d.mtHead_.fieldbyname('RoomReservation').asInteger;
    ar.InvoiceNumber    := d.mtHead_.fieldbyname('InvoiceNumber').asInteger;
    ar.ActionDate := now;
    ar.ActionID := 1001;
    ar.Action := 'Printed to printer';
    ar.ActionNote := s;
    ar.Staff := g.qUser;
    d.InsInvoiceAction(ar);
end;


function TfrmFinishedInvoices2.frxReport1UserFunction(const MethodName: string; var Params: Variant): Variant;
begin
  //
end;

end.


