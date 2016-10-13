unit uInvoicePayment;

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
  , StdCtrls
  , Buttons
  , ExtCtrls
  , ComCtrls
  , ADODB
  , Grids

  , hdata
  , _glob
  , ug

  , cmpRoomerDataSet
  , cmpRoomerConnection

  , sLabel
  , sBitBtn
  , sPanel
  , PlannerDatePicker
  , AdvEdit
  , AdvEdBtn

  , sButton
  , Vcl.Mask
  , sMaskEdit
  , sCustomComboEdit
  , sTooledit
  , sEdit
  , sSkinProvider
  , AdvObj
  , BaseGrid
  , AdvGrid, sComboBox, AdvUtil
  ;

type


  TfrmInvoicePayment = class(TForm)
    Panel1: TsPanel;
    Panel2: TsPanel;
    Panel3: TsPanel;
    edtCustomer: TsEdit;
    lblCustomername: TsLabel;
    agrPayTypes: TAdvStringGrid;
    Panel5: TsPanel;
    Label2: TsLabel;
    Label3: TsLabel;
    lblSelected: TsLabel;
    lblLeft: TsLabel;
    lblAmount: TsLabel;
    edtAmount: TsEdit;
    sPanel1: TsPanel;
    dtInvDate: TsDateEdit;
    sLabel1: TsLabel;
    dtPayDate: TsDateEdit;
    sLabel2: TsLabel;
    BtnOk: TsButton;
    btnCancel: TsButton;
    sSkinProvider1: TsSkinProvider;
    sLabel3: TsLabel;
    cbxLocation: TsComboBox;
    procedure FormShow(Sender: TObject);
    procedure agrPayTypesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure agrPayTypesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure agrPayTypesEnter(Sender: TObject);
    procedure edtAmountExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnOkClick(Sender: TObject);
    procedure agrPayTypesGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure agrPayTypesClickCell(Sender: TObject; ARow, ACol: Integer);

  private
    { Private declarations }
     CloseOK : boolean;
     err : integer;

     FAmount : Double;
     FCustomer : string;
     procedure Recalc;
     procedure FillPayGrid;
  public
    { Public declarations }
     procedure WndProc(var Message: TMessage); override;
  end;

var
  frmInvoicePayment: TfrmInvoicePayment;

var
  sSelectedCustomer  : string;
  fSelectedAmount    : Double;
  stlPaySelections   : TStringlist;
  FConfirmation      : string;

// --
function SelectPaymentTypes( Amount : Double;
                            Customer : string;
                            PaymentType : hdata.TPaymentTypes;
                            var lst : TstringList;
                            var zInvoiceDate : TDateTime; var zPayDate : TDate; var zLocation : string) : boolean;



implementation

uses
    uD
   , uSqlDefinitions
   , uAppGlobal
   , PrjConst
   , uUtils
  ;

{$R *.DFM}

function SelectPaymentTypes( Amount : Double;
                             Customer : string;
                             PaymentType : hdata.TPaymentTypes;
                             var lst : TstringList;
                             var zInvoiceDate : TDateTime; var zPayDate : TDate; var zLocation : string) : boolean;
var
  i : integer;
  selected : string;
  index : integer;
  sTemp : String;
begin
  // --
  result := false;
  Application.CreateForm(TfrmInvoicePayment, frmInvoicePayment);
  try
    frmInvoicePayment.FAmount := Amount;
    FConfirmation := '';
    frmInvoicePayment.edtAmount.text := trim( _FloatToStr( Amount, 9, 2 ) );
    frmInvoicePayment.FCustomer := Customer;
    frmInvoicePayment.lblSelected.caption := '0';
    frmInvoicePayment.lblLeft.caption := trim( _FloatToStr( Amount, 9, 2 ) );
    frmInvoicePayment.dtInvDate.Date := Date;
    frmInvoicePayment.dtPayDate.Date := Date;
    sSelectedCustomer := Customer;
    stlPaySelections.clear;

    // get all locations from data
    glb.Locations.First;
    while not glb.Locations.Eof do begin
      frmInvoicePayment.cbxLocation.items.Add(glb.Locations.FieldByName('Location').asstring);
      glb.Locations.Next;
    end;


    if lst.Count = 1 then
    begin
      selected := lst[0];
      for i := 0 to frmInvoicePayment.cbxLocation.Items.Count-1 do
      begin
        if frmInvoicePayment.cbxLocation.Items[i].ToLower.Equals(selected.ToLower) then break;
      end;
      frmInvoicePayment.cbxLocation.ItemIndex := i;
    end else
    begin
      frmInvoicePayment.cbxLocation.ItemIndex := frmInvoicePayment.cbxLocation.Items.Count-1;
    end;


    if PaymentType = ptDownPayment then
    begin
      // frmInvoicePayment.Caption := 'Down payment';
      frmInvoicePayment.Caption := GetTranslatedText('shTx_InvoicePayment_DownPayment');
      frmInvoicePayment.panel2.visible := true;
    end else
    begin
    //  frmInvoicePayment.Caption := 'Invocie Payment';
	    frmInvoicePayment.Caption := GetTranslatedText('shTx_InvoicePayment_InvoicePayment');
      frmInvoicePayment.panel2.visible := false;
    end;

    if frmInvoicePayment.ShowModal <> mrOK then
    begin
      result := false;
    end else
    begin
      result := true;
      sSelectedCustomer := frmInvoicePayment.edtCustomer.text;
      fSelectedAmount   := _StrToFloat( frmInvoicePayment.edtAmount.text );
      zInvoiceDate      := frmInvoicePayment.dtInvDate.date;
      zPayDate          := frmInvoicePayment.dtPayDate.date;


      zLocation := '';

      if frmInvoicePayment.cbxLocation.itemindex > 0 then
      begin
        zLocation := frmInvoicePayment.cbxLocation.items[frmInvoicePayment.cbxLocation.itemindex];
      end;

      for i := 0 to frmInvoicePayment.agrPayTypes.RowCount - 1  do
      begin
        if GridCellFloatValue( frmInvoicePayment.agrPayTypes, 1, i ) <> 0 then
        begin
          sTemp := frmInvoicePayment.agrPayTypes.Cells[ 0, i ];
          glb.LocateSpecificRecordAndGetValue('paytypes', 'PayType', sTemp, 'Description', sTemp);
          stlPaySelections.add( frmInvoicePayment.agrPayTypes.Cells[ 0, i ] + '|' + frmInvoicePayment.agrPayTypes.Cells[ 1, i ] + '|' + sTemp );
          if d.AskApproval( frmInvoicePayment.agrPayTypes.Cells[ 0, i ] ) then
            // FConfirmation := InputBox( 'Confirm code', 'Code :', '' );
    			 FConfirmation := InputBox( GetTranslatedText('shTx_InvoicePayment_ConfirmCode'), GetTranslatedText('shTx_InvoicePayment_Code'), '' );
        end;
      end;
    end;
  finally
    frmInvoicePayment.free;
  end;
end;



const WM_ActivateAmount = WM_User + 381;

procedure TfrmInvoicePayment.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_ActivateAmount then
  begin
    Recalc;
  end else
    inherited;
end;


procedure TfrmInvoicePayment.FillPayGrid;
var
  l : integer;

//  rSet : TRoomerDataSet;
//  s    : string;
begin
//  rSet := CreateNewDataSet;
//  try
//    
//    rSet.CommandType := cmdText;
//    s := format(select_InvoicePayment_FillPayGrid, []);
//    hData.rSet_bySQL(rSet,s);
    l := 0;
    glb.PaytypesSet.First;
    while not glb.PaytypesSet.eof do
    begin
      if glb.PaytypesSet.FieldByName('active').AsBoolean then
      begin
        inc(l);
        agrPayTypes.RowCount := l;
        agrPayTypes.Cells[ 0, l - 1 ] := glb.PaytypesSet.FieldByName( 'PayType' ).AsString;
      end;
      glb.PaytypesSet.next;
    end;
//  finally
//    freeandNil(rSet);
//  end;
end;

procedure TfrmInvoicePayment.Recalc;
var
  i : integer;
      fSelected,
      fLeft : Double;

  maxDays : integer;
  payType : string;
  days : integer;
begin
  // --
  maxDays   := 0;
  fSelected := 0;
  fLeft     := 0;

  for i := 0 to agrPayTypes.RowCount - 1 do
  begin
    payType := agrPayTypes.Cells[0,i];

    fSelected := fSelected + GridCellFloatValue( agrPayTypes, 1, i );

    if GridCellFloatValue( agrPayTypes, 1, i ) <> 0 then
    begin
      days := PayTypesDays(payType);
      if days > maxDays then Maxdays := days;
    end;


//    if GridCellFloatValue( agrPayTypes, 1, i ) < 0 then
//    begin
//      agrPayTypes.Cells[1,i] := '';
//      closeok := false;
//      err := 1;
//    end;
  end;

  fLeft               := FAmount - fSelected;
  lblSelected.caption := _FloatToStr( fSelected, 12, 2 );
  lblLeft.caption     := _FloatToStr( fLeft,     12, 2 );
  if fLeft = 0 then beep;

  dtpayDate.Date := MaxDays + dtInvDate.Date
end;

procedure TfrmInvoicePayment.FormShow(Sender: TObject);
begin
  edtCustomer.text := FCustomer;
  recalc;
  FillPayGrid;
  lblSelected.caption := _FloatToStr( 0, 12, 2 );
  lblLeft.caption     := _FloatToStr( FAmount, 12, 2 );
  postmessage( handle, WM_ActivateAmount, 0, 0 );
end;

procedure TfrmInvoicePayment.agrPayTypesGetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  HAlign := taRightJustify;
end;

procedure TfrmInvoicePayment.agrPayTypesSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  // --
   Recalc;
   agrPayTypes.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goEditing];
  // --
   agrPayTypes.OnSelectCell := nil;
   try
      if trunc( GridCellFloatValue( agrPayTypes, 1, ARow ) ) = 0 then
      begin
        agrPayTypes.Cells[ ACol, ARow ] := lblLeft.caption;
      end;
   finally
      agrPayTypes.OnSelectCell := agrPayTypesSelectCell;
   end;
end;

procedure TfrmInvoicePayment.BtnOkClick(Sender: TObject);
begin
  if frmInvoicePayment.cbxLocation.itemindex = 0 then
  begin
    closeok := false;
    err := 2;
  end;

  if not closeOk then
  begin
    case err of
      1 : MessageDlg(GetTranslatedText('shTx_InvoicePayment_ExceedsInvoice'), mtError, [mbOk], 0);
      2 : MessageDlg('Select Location', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TfrmInvoicePayment.agrPayTypesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Return then
      Recalc;
end;

procedure TfrmInvoicePayment.agrPayTypesClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  postMessage( handle, WM_ActivateAmount, 0, 0 );
end;

procedure TfrmInvoicePayment.agrPayTypesEnter(Sender: TObject);
begin
  if (FAmount = 0) and edtAmount.CanFocus then
    ActiveControl := edtAmount;
  postMessage( handle, WM_ActivateAmount, 0, 0 );
end;

procedure TfrmInvoicePayment.edtAmountExit(Sender: TObject);
begin
  // --
  FAmount := _StrToFloat( edtAmount.text );
  fSelectedAmount := FAmount;
  // --
  postMessage( handle, WM_ActivateAmount, 0, 0 );
end;

procedure TfrmInvoicePayment.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  closeOk := true;
end;

procedure TfrmInvoicePayment.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  canClose := closeOk;
  closeOk  := true;
end;

initialization
begin
   stlPaySelections := TStringlist.create;
end;

finalization
begin
   stlPaySelections.free;
end;

end.



