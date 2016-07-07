unit uFrmHandleBookKeepingException;

interface

uses
    Winapi.Windows
  , Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sListBox, sButton, sRadioButton, Vcl.ExtCtrls, sPanel, sLabel, sMemo,uAppGlobal;

type

  TFrmHandleBookKeepingException = class(TForm)
    sLabel1: TsLabel;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    rbRetry: TsRadioButton;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    rbIgnore: TsRadioButton;
    sButton1: TsButton;
    sLabel5: TsLabel;
    sButton2: TsButton;
    sLabel6: TsLabel;
    sButton3: TsButton;
    sLabel7: TsLabel;
    panBtn: TsPanel;
    BtnOk: TsButton;
    sLabel4: TsLabel;
    sLabel8: TsLabel;
    memExplanations: TsMemo;
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbRetryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ProcessExplanations;
    { Private declarations }
  public
    { Public declarations }
    invoiceNumber : Integer;
    errors : String;
  end;

var
  FrmHandleBookKeepingException: TFrmHandleBookKeepingException;

procedure HandleFinanceBookKeepingExceptions(invoiceNumber : Integer; errors : String);

implementation

{$R *.dfm}

uses hData,
     uG,
     uRoomerLanguage,
     uD,
     uStringUtils,
     uCustomers2,
     uItems2,
     uPayTypes,
     uUtils;

const ERR_PRODUCT = 'PRODUCT';
      ERR_CUSTOMER = 'CUSTOMER';
      ERR_PAYTYPE = 'PAYTYPE';
      ERR_REMOTE_EXCEPTION = 'REMOTE_EXCEPTION';
      ERR_INTERNAL_EXCEPTION = 'INTERNAL_EXCEPTION';
      INVOICE_ALREADY_SENT = 'INVOICE_ALREADY_SENT';


function HandleError(invoiceNumber : Integer; var errors : String) : Boolean;
begin
    errors := d.roomerMainDataSet.SystemSendInvoiceToBookkeeping(invoiceNumber);
    result := errors = '';
end;

procedure HandleFinanceBookKeepingExceptions(invoiceNumber : Integer; errors : String);
var
  _FrmHandleBookKeepingException: TFrmHandleBookKeepingException;
begin
  repeat
    _FrmHandleBookKeepingException := TFrmHandleBookKeepingException.Create(nil);
    try
      _FrmHandleBookKeepingException.invoiceNumber := invoiceNumber;
      _FrmHandleBookKeepingException.errors := errors;
      _FrmHandleBookKeepingException.ShowModal;
      if _FrmHandleBookKeepingException.rbIgnore.Checked OR (_FrmHandleBookKeepingException.rbRetry.Checked AND HandleError(invoiceNumber, errors)) then
        Break;
    finally
      FreeAndNil(_FrmHandleBookKeepingException);
    end;
  until (False);
end;


procedure TFrmHandleBookKeepingException.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
end;

procedure TFrmHandleBookKeepingException.sButton1Click(Sender: TObject);
var
  theData: recCustomerHolder;
begin
  openCustomers(actNone, false, theData);
end;

procedure TFrmHandleBookKeepingException.sButton2Click(Sender: TObject);
var
  theData: recItemHolder;
begin
  OpenItems(actNone, false, theData);
end;

procedure TFrmHandleBookKeepingException.sButton3Click(Sender: TObject);
var
  theData: recPayTypeHolder;
begin
  payType(actNone, false, theData);
end;


procedure TFrmHandleBookKeepingException.FormShow(Sender: TObject);
begin
  SetCloseButtonEnabled(self, false);
  ProcessExplanations;
end;

procedure TFrmHandleBookKeepingException.ProcessExplanations;
var list, parts : TStrings;
    i : Integer;
    ErrorType,
    ErrorDescription,
    ErrorSystemName,
    ErrorCode : String;

    Msg : String;

begin
  memExplanations.Lines.Clear;
  list := SplitStringToTStrings(#13#10, errors);
  try
    for i := 0 to list.count - 1 do
    begin
      parts := SplitStringToTStrings(',', list[i]);
      try
        ErrorType := parts[0];
        ErrorDescription := parts[1];
        ErrorSystemName := parts[2];
        ErrorCode := parts[3];
        if (ErrorType = ERR_CUSTOMER) OR
           (ErrorType = ERR_PRODUCT) OR
           (ErrorType = ERR_PAYTYPE)
        then
          Msg := format('%s ''%s'' was not found in ''%s''.' + #13#10 + 'Please either correct in Roomer or create the missing code in ''%s''.',
                        [ErrorType, ErrorCode, ErrorSystemName, ErrorSystemName])
        else
        if ErrorType = ERR_REMOTE_EXCEPTION then
          Msg := format('Remote system ''%s'' answered with an error: ''%s''.' + #13#10 + 'Please contact the support agent of the remote system.',
                        [ErrorSystemName, ErrorDescription])
        else
        if ErrorType = ERR_INTERNAL_EXCEPTION then
          Msg := format('Roomer system gave an error: ''%s''.' + #13#10 + 'Please contact our support department and tell them about this error.',
                        [ErrorDescription])
        else
        if ErrorType = INVOICE_ALREADY_SENT then
        begin
          Msg := format('Roomer system said: ''%s''.' + #13#10 + '.',
                        [ErrorDescription]);
          rbIgnore.Checked := True;
          btnOK.Enabled := True;
        end;
      finally
        parts.Free;
      end;
      memExplanations.Lines.Add(Msg + #13#10);
    end;
  finally
    list.Free;
  end;

end;

procedure TFrmHandleBookKeepingException.rbRetryClick(Sender: TObject);
begin
  btnOK.Enabled := True;
end;

end.
