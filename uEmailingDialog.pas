unit uEmailingDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uG, acPNG, Vcl.ExtCtrls, acImage, Vcl.StdCtrls, Generics.Collections,
  System.IOUtils, sMemo, sButton, cxClasses, cxPropertiesStore, sEdit, sLabel, sPanel, sComboBox;

type

  TEmailTemplateInfo = class
    Name : String;
    URI : String;
    ID : Integer;
  public
    constructor Create(_name, _uri : String; _id : Integer);
  end;

  TEmailTemplateInfoList = TObjectList<TEmailTemplateInfo>;

  TFrmEmailingDialog = class(TForm)
    sPanel1: TsPanel;
    sLabel1: TsLabel;
    edRecipient: TsComboBox;
    StoreMain: TcxPropertiesStore;
    sLabel2: TsLabel;
    edCC: TsComboBox;
    edBCC: TsComboBox;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    edSubject: TsEdit;
    sPanel2: TsPanel;
    sPanel3: TsPanel;
    sButton1: TsButton;
    sButton2: TsButton;
    edEmailText: TsMemo;
    sImage1: TsImage;
    __attahments: TsLabel;
    __imgHelp: TsImage;
    cbxTemplates: TsComboBox;
    procedure FormCreate(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure cbxTemplatesCloseUp(Sender: TObject);
  private
    FFiles: TStringList;
    FTemplates : TEmailTemplateInfoList;
    procedure SetFiles(const Value: TStringList);
    procedure LoadEmailTemplates;
    function Download(template : TEmailTemplateInfo): String;
    { Private declarations }
  public
    { Public declarations }
    property files : TStringList read FFiles write SetFiles;
  end;

var
  FrmEmailingDialog: TFrmEmailingDialog;

function sendFileAsAttachment(recipient, _caption : String; attachments : TStringList) : Boolean; overload;
function sendFileAsAttachment(recipients : TStrings; _caption : String; attachments : TStringList) : Boolean; overload;

implementation

{$R *.dfm}

uses uRoomerLanguage,
    cmpRoomerDataSet,
    uFrmResources,
    uAppGlobal,
    uD,
    hData,
    uUtils,
    uFileSystemUtils
    ;

function sendFileAsAttachment(recipient, _caption : String; attachments : TStringList) : Boolean;
var list : TStrings;
begin
  list := TStringList.Create;
  try
    SplitString(recipient, list, ';');
    result := sendFileAsAttachment(list, _caption, attachments);
  finally
    FreeAndNil(list);
  end;
end;

function sendFileAsAttachment(recipients : TStrings; _caption : String; attachments : TStringList) : Boolean;
var _frmEmailingDialog: TFrmEmailingDialog;
  i: Integer;
begin
  result := True;
  _frmEmailingDialog := TFrmEmailingDialog.Create(nil);
  try
    _frmEmailingDialog.Caption := _Caption;
    _frmEmailingDialog.files := attachments;
    _frmEmailingDialog.edRecipient.Items.Clear;
    _frmEmailingDialog.edCC.Items.Clear;
    _frmEmailingDialog.edBCC.Items.Clear;
    for i := 0 to recipients.Count - 1 do
      _frmEmailingDialog.edRecipient.Items.Add(recipients[i]);
    _frmEmailingDialog.edCC.Items.Assign(_frmEmailingDialog.edRecipient.Items);
    _frmEmailingDialog.edBCC.Items.Assign(_frmEmailingDialog.edRecipient.Items);
    _frmEmailingDialog.edRecipient.ItemIndex := ABS(ORD(_frmEmailingDialog.edRecipient.Items.Count > 0)) - 1;
    result := _frmEmailingDialog.ShowModal = mrOk;
  finally
    FreeAndNil(_frmEmailingDialog);
  end;
end;

function TFrmEmailingDialog.Download(template : TEmailTemplateInfo) : String;
var filename : String;
begin
  result := '';
  Screen.Cursor := crHourglass;
  try
    filename := TPath.Combine(GetTempDir, template.Name);
    if FileExists(filename) then
      DeleteFile(filename);
    if d.roomerMainDataSet.DownloadFileResourceOpenAPI(template.URI, filename) then
      result := filename;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmEmailingDialog.cbxTemplatesCloseUp(Sender: TObject);
begin
  if cbxTemplates.ItemIndex > 0 then
  begin
    //
  end;
end;

procedure TFrmEmailingDialog.FormClose(Sender: TObject; var Action: TCloseAction);
var Key : String;
begin
  Key := StringReplace(Caption + '_EMAIL_', ' ', '_', [rfReplaceAll, rfIgnoreCase]);
  WriteStringValueToAppRegistry('_ALL_USERS_', Key + 'TEXT', edEmailText.Text);
  WriteStringValueToAppRegistry('_ALL_USERS_', Key + 'SUBJECT', edSubject.Text);
  WriteStringValueToAppRegistry('_ALL_USERS_', Key + 'CC', edCC.Text);
  WriteStringValueToAppRegistry('_ALL_USERS_', Key + 'BCC', edBCC.Text);
end;

procedure TFrmEmailingDialog.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  FTemplates := TEmailTemplateInfoList.Create(True);
end;

procedure TFrmEmailingDialog.FormDestroy(Sender: TObject);
begin
  FTemplates.Free;
end;

procedure TFrmEmailingDialog.FormShow(Sender: TObject);
var Key : String;
    Value : String;
begin
  Key := StringReplace(Caption + '_EMAIL_', ' ', '_', [rfReplaceAll, rfIgnoreCase]);
  Value :=
    StringReplace(
        'Dear guest,' + #13#10 +
        '' + #13#10 +
        '   As per your request, please find the invoice for your stay at our hotel attached to this message.' + #13#10 +
        '' + #13#10 +
        '   We hope you enjoyed you stay at %hotelname%.' + #13#10 +
        '' + #13#10 +
        'With our kindest regards,' + #13#10 +
        '%hotelname%',
   '%hotelname%', hData.ctrlGetString('CompanyName'), [rfReplaceAll, rfIgnoreCase]);

  edEmailText.Text := ReadStringValueFromAppRegistry('_ALL_USERS_', Key + 'TEXT', Value);

  Value := 'Thank you for your stay at ' + hData.ctrlGetString('CompanyName');
  edSubject.Text := ReadStringValueFromAppRegistry('_ALL_USERS_', Key + 'SUBJECT', Value);

  edCC.Text := ReadStringValueFromAppRegistry('_ALL_USERS_', Key + 'CC', '');
  edBCC.Text := ReadStringValueFromAppRegistry('_ALL_USERS_', Key + 'BCC', '');

  //
  __attahments.visible := files.Count > 0;
  sImage1.visible := files.Count > 0;

//  LoadEmailTemplates;
end;


procedure TFrmEmailingDialog.LoadEmailTemplates;
var rSet : TRoomerDataSet;
    template : TEmailTemplateInfo;
begin
  cbxTemplates.Items.Clear;
  cbxTemplates.Items.Add('');
  rSet := CreateNewDataSet;
  try
    rSet.OpenDataset(rSet.SystemGetStaticResourcesFiltered(GUEST_EMAIL_TEMPLATE));
    rSet.First;
    while NOT rSet.Eof do
    begin
      template := TEmailTemplateInfo.Create(rSet['ORIGINAL_NAME'], rSet['URI'], rSet['ID']);
      FTemplates.Add(template);
      cbxTemplates.Items.AddObject(template.Name, template);
      rSet.Next;
    end;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure TFrmEmailingDialog.sButton1Click(Sender: TObject);
begin
  d.RoomerMainDataset.sendEmailOpenAPI(edSubject.Text, hData.ctrlGetString('CompanyEmail'),
        edRecipient.Text, edCc.Text, edBcc.Text, edEmailText.Text, simpleTextTosimpleHtml(edEmailText.Text), files);
  Close;
end;

procedure TFrmEmailingDialog.SetFiles(const Value: TStringList);
var
  i: Integer;
  filename,
  filePath : String;
begin
  __attahments.Caption := '';
  FFiles := Value;
  for i := 0 to FFiles.Count - 1 do
  begin
    filename := copy(files[i], pos('=', files[i]) + 1, maxint);
    filePath := copy(files[i], 1, pos('=', files[i]) - 1);
    if __attahments.Caption = '' then
      __attahments.Caption := filename
    else
      __attahments.Caption := __attahments.Caption + ', ' + filename;
  end;

end;

{ TEmailTemplateInfo }

constructor TEmailTemplateInfo.Create(_name, _uri: String; _id : Integer);
begin
  Name := _name;
  URI := _uri;
  ID := _id;
end;

end.
