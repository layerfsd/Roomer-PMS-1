unit uReservationEmailingDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls, sComboBox, sLabel, Vcl.OleCtrls, SHDocVw, sButton, sEdit, cxClasses, cxPropertiesStore;

type

  TEmailType = (EMAIL_TYPE_NEW_RESERVATION_CONFIRMATION, EMAIL_TYPE_CANCEL_RESERVATION_CONFIRMATION);

  TFrmReservationEmailingDialog = class(TForm)
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sLabel1: TsLabel;
    edTemplate: TsComboBox;
    WebBrowser: TWebBrowser;
    btnOk: TsButton;
    btnResources: TsButton;
    btnEdit: TsButton;
    FormStore: TcxPropertiesStore;
    sLabel2: TsLabel;
    edTo: TsComboBox;
    sLabel3: TsLabel;
    edCC: TsComboBox;
    sLabel4: TsLabel;
    edSubject: TsEdit;
    shpTemplate: TShape;
    shpTo: TShape;
    shpSubject: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edTemplateCloseUp(Sender: TObject);
    procedure btnResourcesClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edToCloseUp(Sender: TObject);
    procedure edSubjectChange(Sender: TObject);
    procedure edToChange(Sender: TObject);
  private
    FEmailType: TEmailType;
    KeyString : String;
    tempFilename,
    filename : String;
    SubjectTemplate : String;
    procedure SetEmailType(const Value: TEmailType);
    procedure LoadHtmlIntoBrowser(browser: TWebBrowser; const html: String);
    procedure NavigateToFile;
    procedure EnableDisableOKButton;
    procedure GetEmailAddresses;
    { Private declarations }
  public
    { Public declarations }
    ReservationId : Integer;
    procedure SendConfirmationEmail;
    property EmailType : TEmailType read FEmailType write SetEmailType;
  end;

var
  FrmReservationEmailingDialog: TFrmReservationEmailingDialog;

function SendNewReservationConfirmation(ReservationId : Integer) : Boolean;
function SendCancellationConfirmation(ReservationId : Integer) : Boolean;

implementation

{$R *.dfm}

uses PrjConst,
     uAppGlobal,
     IOUtils,
     uRoomerLanguage,
     uFrmResources,
     uMain,
     uFrmEmbeddedHtmlEditor,
     uTemplateFiller,
     ActiveX,
     uFileSystemUtils,
     cmpRoomerDataset,
     uD,
     uG,
     HData,
     uUtils,
     uStringUtils,
     uResourceManagement
     ;

function SendNewReservationConfirmation(ReservationId : Integer) : Boolean;
var
  _FrmReservationEmailingDialog: TFrmReservationEmailingDialog;
begin
  _FrmReservationEmailingDialog := TFrmReservationEmailingDialog.Create(nil);
  try
    _FrmReservationEmailingDialog.EmailType := EMAIL_TYPE_NEW_RESERVATION_CONFIRMATION;
    _FrmReservationEmailingDialog.ReservationId := ReservationId;
    result := (_FrmReservationEmailingDialog.ShowModal = mrOk);
    if result then
      _FrmReservationEmailingDialog.SendConfirmationEmail;
  finally
    FreeAndNil(_FrmReservationEmailingDialog);
  end;
end;

function SendCancellationConfirmation(ReservationId : Integer) : Boolean;
var
  _FrmReservationEmailingDialog: TFrmReservationEmailingDialog;
begin
  _FrmReservationEmailingDialog := TFrmReservationEmailingDialog.Create(nil);
  try
    _FrmReservationEmailingDialog.EmailType := EMAIL_TYPE_CANCEL_RESERVATION_CONFIRMATION;
    _FrmReservationEmailingDialog.ReservationId := ReservationId;
    result := (_FrmReservationEmailingDialog.ShowModal = mrOk);
    if result then
      _FrmReservationEmailingDialog.SendConfirmationEmail;
  finally
    FreeAndNil(_FrmReservationEmailingDialog);
  end;
end;

{ TFrmReservationEmailingDialog }

procedure TFrmReservationEmailingDialog.SendConfirmationEmail;
var Strings,
    files : TStringlist;
    att : TStrings;
    attName : String;
    bcc : String;
begin
  files := TStringlist.Create;
  Strings := TStringlist.Create;
  att := TStringlist.Create;
  try
//    att.Text := format('Sent from %s by %s', [hData.ctrlGetString('CompanyName'), d.roomerMainDataSet.username]);
//    attName := GetTempFileName('.dat');
//    att.SaveToFile(attName);
//    files.Add(attName + '=sender.dat');
    try
    Strings.LoadFromFile(tempFilename, TEncoding.UTF8);

    bcc := '';
    if g.qDefaultSendCCEmailToHotel then
      bcc := ctrlGetString('CompanyEmail');

    d.RoomerMainDataset.sendEmailOpenAPI(edSubject.Text, hData.ctrlGetString('CompanyEmail'),
        edTo.Text, edCc.Text, bcc, '', ConvertToEncion(Strings.Text), files);
    Close;
    finally
      if attName <> '' then
         try TFile.Delete(attName); except end;
    end;
  finally
    att.Free;
    Strings.Free;
    files.Free;
  end;
end;

procedure TFrmReservationEmailingDialog.btnResourcesClick(Sender: TObject);
var idx : Integer;
    RoomerResourceManagement : TRoomerResourceManagement;
begin
  if KeyString = GUEST_EMAIL_TEMPLATE then
    frmMain.ShowBookingConfirmationTemplates
  else if KeyString = Cancel_EMAIL_TEMPLATE then
    frmMain.ShowCancelConfirmationTemplates;
  idx := edTemplate.ItemIndex;
  edTemplate.Items.Clear;

  RoomerResourceManagement := TRoomerResourceManagement.Create(KeyString, ACCESS_RESTRICTED);
  try
  edTemplate.Items.AddStrings(RoomerResourceManagement.StaticResourceListAsStrings);
  finally
    RoomerResourceManagement.Free;
  end;
  edTemplate.ItemIndex := idx;
end;

procedure TFrmReservationEmailingDialog.EnableDisableOKButton;
begin
  btnOk.Enabled := ((edTemplate.ItemIndex >= 0) OR (edTemplate.Text <> '')) AND
                   ((edTo.ItemIndex >= 0) OR (edTo.Text <> '')) AND
                   (Trim(edSubject.Text) <> '');

  shpTemplate.Visible := NOT ((edTemplate.ItemIndex >= 0) OR (edTemplate.Text <> ''));
  shpTo.Visible := NOT ((edTo.ItemIndex >= 0) OR (edTo.Text <> ''));
  shpSubject.Visible := (Trim(edSubject.Text) = '');
  btnEdit.Enabled := (edTemplate.ItemIndex >= 0);
end;

procedure TFrmReservationEmailingDialog.edSubjectChange(Sender: TObject);
begin
  EnableDisableOKButton;
end;

procedure TFrmReservationEmailingDialog.edTemplateCloseUp(Sender: TObject);
var Strings : TStrings;
    Subject : String;
    RoomerResourceManagement : TRoomerResourceManagement;
begin
  try
    RoomerResourceManagement := TRoomerResourceManagement.Create(KeyString, ACCESS_RESTRICTED);
    try
      edTemplate.Items.AddStrings(RoomerResourceManagement.StaticResourceListAsStrings);
      filename := RoomerResourceManagement.DownloadResourceByName(edTemplate.Items[edTemplate.ItemIndex], SubjectTemplate);
    finally
      RoomerResourceManagement.Free;
    end;
    Strings := TStringlist.Create;
    try
      Strings.LoadFromFile(filename, TEncoding.UTF8);
      Strings.SaveToFile(tempFilename, TEncoding.UTF8);
    finally
      Strings.Free;
    end;

    NavigateToFile;
    EnableDisableOKButton;
  except
    edTemplate.ItemIndex := -1;
  end;
end;

procedure TFrmReservationEmailingDialog.edToChange(Sender: TObject);
begin
  EnableDisableOKButton;
end;

procedure TFrmReservationEmailingDialog.edToCloseUp(Sender: TObject);
begin
  EnableDisableOKButton;
end;

procedure TFrmReservationEmailingDialog.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  tempFilename := GetTempFileName('.html');
end;

procedure TFrmReservationEmailingDialog.FormDestroy(Sender: TObject);
begin
  try DeleteFile(tempFilename); except end;
end;

procedure TFrmReservationEmailingDialog.GetEmailAddresses;
var s : String;
    rSet : TRoomerDataset;
begin
  s := format(
       'SELECT DISTINCT Email FROM ' +
       '( ' +
       'SELECT ContactEmail AS Email FROM reservations WHERE Reservation=%d AND ContactEmail<>'''' AND (NOT ISNULL(ContactEmail)) ' +
       'UNION ALL ' +
       'SELECT Email FROM persons WHERE Reservation=%d AND Email<>'''' AND (NOT ISNULL(Email)) ' +
       ') xxx', [ReservationId, ReservationId]);
  rSet := CreateNewDataset;
  edTo.Items.Clear;
  edCC.Items.Clear;
  if hData.rSet_bySQL(rSet, s) then
  begin
    rSet.First;
    while NOT rSet.Eof do
    begin
      edTo.Items.Add(rSet['Email']);
      edCC.Items.Add(rSet['Email']);
      rSet.Next;
    end;
  end;
end;

procedure TFrmReservationEmailingDialog.FormShow(Sender: TObject);
var rSet : TRoomerDataset;
    RoomerResourceManagement : TRoomerResourceManagement;
begin
  edTemplate.Items.Clear;
  RoomerResourceManagement := TRoomerResourceManagement.Create(KeyString, ACCESS_RESTRICTED);
  try
    edTemplate.Items.AddStrings(RoomerResourceManagement.StaticResourceListAsStrings);
  finally
    RoomerResourceManagement.Free;
  end;
  EnableDisableOKButton;
  GetEmailAddresses;
//  if g.qDefaultSendCCEmailToHotel then
//  begin
//    edCC.Items.Insert(0, ctrlGetString('CompanyEmail'));
//    edCC.ItemIndex := 0;
//  end;
end;

procedure TFrmReservationEmailingDialog.LoadHtmlIntoBrowser(browser: TWebBrowser; const html: String);
var
  memStream: TMemoryStream;
begin
  //-------------------
  // Load a blank page.
  //-------------------
  browser.Navigate('about:blank');
  while browser.ReadyState <> READYSTATE_COMPLETE do
  begin
    Sleep(5);
    Application.ProcessMessages;
  end;
  //---------------
  // Load the html.
  //---------------
  memStream := TMemoryStream.Create;
  memStream.Write(Pointer(html)^,Length(html));
  memStream.Seek(0,0);
  (browser.Document as IPersistStreamInit).Load(
    TStreamAdapter.Create(memStream));
  memStream.Free;
end;

procedure TFrmReservationEmailingDialog.NavigateToFile;
var Strings : TStrings;
    Subject : String;
begin
  Strings := TStringlist.Create;
  try
    Strings.LoadFromFile(filename, TEncoding.UTF8);
    Subject := SubjectTemplate;
    Strings.Text := fillInBookingInformation(ReservationId, Strings.Text, Subject, EmailType = EMAIL_TYPE_NEW_RESERVATION_CONFIRMATION);
    Strings.SaveToFile(tempFilename, TEncoding.UTF8);
    WebBrowser.Navigate2(tempFilename);
    edSubject.Text := Subject;
//    LoadHtmlIntoBrowser(WebBrowser, src);
  finally
    Strings.Free;
  end;
end;

procedure TFrmReservationEmailingDialog.btnEditClick(Sender: TObject);
begin
  if EditHtmlFile(tempFilename) then
    WebBrowser.Navigate2(tempFilename);
end;

procedure TFrmReservationEmailingDialog.SetEmailType(const Value: TEmailType);
begin
  FEmailType := Value;
  if Value = EMAIL_TYPE_NEW_RESERVATION_CONFIRMATION then
  begin
    Caption := GetTranslatedText('shUI_NewReservationConfirmationEmail');
    KeyString := GUEST_EMAIL_TEMPLATE;
  end else
  if Value = EMAIL_TYPE_CANCEL_RESERVATION_CONFIRMATION then
  begin
    Caption := GetTranslatedText('shUI_CancelReservationConfirmationEmail');
    KeyString := CANCEL_EMAIL_TEMPLATE;
  end;
end;

end.
