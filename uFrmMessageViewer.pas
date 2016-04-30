unit uFrmMessageViewer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdMessage, Vcl.StdCtrls, sMemo, Vcl.OleCtrls, SHDocVw, sLabel, Vcl.ExtCtrls, sPanel, IdCoder,
  IdCoderQuotedPrintable, IdMessageCoderYenc, IdComponent, IdMessageCoder, IdMessageCoderMIME,
  IdText, IdEmailAddress, IdAttachment, sButton, ActiveX;

type
  TFrmMessageViewer = class(TForm)
    msg: TIdMessage;
    sPanel1: TsPanel;
    sLabel1: TsLabel;
    lblRecipients: TsLabel;
    lblCCs: TsLabel;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    lblSubject: TsLabel;
    wbrText: TWebBrowser;
    mmoText: TsMemo;
    sPanel2: TsPanel;
    sButton1: TsButton;
    IdMessageDecoderMIME1: TIdMessageDecoderMIME;
    IdMessageDecoderYenc1: TIdMessageDecoderYenc;
    IdDecoderQuotedPrintable1: TIdDecoderQuotedPrintable;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    bHtml : Boolean;
    function GetListAsString(List : TIdEmailAddressList) : String;
    procedure ShowRecipients;
    procedure ShowMessageBody;
    procedure LoadHtmlIntoBrowser(browser: TWebBrowser; const html: String);
  public
    { Public declarations }
    procedure PrepareMessage(filename : String);
  end;

var
  FrmMessageViewer: TFrmMessageViewer;

procedure ViewEmailMessage(filename : String);

implementation

{$R *.dfm}

uses uRoomerLanguage, uAppGlobal, uUtils;

procedure ViewEmailMessage(filename : String);
var
  _FrmMessageViewer: TFrmMessageViewer;
begin
  _FrmMessageViewer := TFrmMessageViewer.Create(nil);
  try
    _FrmMessageViewer.PrepareMessage(filename);
    _FrmMessageViewer.ShowModal;
  finally
    FreeAndNil(_FrmMessageViewer);
  end;
end;

{ TFrmMessageViewer }

procedure TFrmMessageViewer.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

function TFrmMessageViewer.GetListAsString(List: TIdEmailAddressList): String;
var i: Integer;
begin
  result := '';
  for i := 0 to List.Count - 1 do
    if result = '' then
      result := List[i].Name + '<' + List[i].Address + '>'
    else
      result := result + ';' + List[i].Name + '<' + List[i].Address + '>';
end;

procedure TFrmMessageViewer.PrepareMessage(filename: String);
begin
  Msg.LoadFromFile(filename);
  ShowRecipients;
  ShowMessageBody;
end;

procedure TFrmMessageViewer.LoadHtmlIntoBrowser(browser: TWebBrowser; const html: String);
var
  memStream: TMemoryStream;
begin
  //-------------------
  // Load a blank page.
  //-------------------
//  browser.Navigate('about:blank');
//  while browser.ReadyState <> READYSTATE_COMPLETE do
//  begin
//    Sleep(5);
//    Application.ProcessMessages;
//  end;
  //---------------
  // Load the html.
  //---------------
  memStream := TMemoryStream.Create;
  memStream.Write(Pointer(html)^,Length(html));
  memStream.Seek(0,0);
  (browser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(memStream));
  memStream.Free;
end;

procedure TFrmMessageViewer.ShowMessageBody;
var
  intIndex : Integer;
begin
 bHtml := False;
 for intIndex := 0 to Pred(Msg.MessageParts.Count) do
      begin
//         if (Msg.MessageParts.Items[intIndex] is TIdAttachment) then
//            begin //general attachment
//              TIdAttachment(Msg.MessageParts.Items[intIndex]).ContentType
//            end
//         else
//            begin //body text
                if Msg.MessageParts.Items[intIndex] is TIdText then
                begin
                   if LowerCase(TIdText(Msg.MessageParts.Items[intIndex]).ContentType) = 'text/html' then
                   begin
                     LoadHtmlIntoBrowser(wbrText, TIdText(Msg.MessageParts.Items[intIndex]).Body.Text);
                     bHtml := True;
                   end else
                   begin
                     mmoText.Lines.Clear;
                     mmoText.Lines.AddStrings(TIdText(Msg.MessageParts.Items[intIndex]).Body);
                   end;
                end
//            end;
      end;
  if bHtml then
  begin
    wbrText.Visible := True;
    wbrText.Align := alClient;
  end else
  begin
    mmoText.Visible := True;
    mmoText.Align := alClient;
  end;

end;

procedure TFrmMessageViewer.ShowRecipients;
begin
  lblRecipients.Caption := GetListAsString(Msg.Recipients);
  lblCCs.Caption := GetListAsString(Msg.CCList);
  lblSubject.Caption := Msg.Subject;
end;

end.
