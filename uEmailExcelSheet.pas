unit uEmailExcelSheet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, cxSSheet, Vcl.StdCtrls, sComboBox, sButton,
  Vcl.ExtCtrls, sPanel, cxClasses, cxPropertiesStore, sEdit, acPNG, acImage, sLabel, sMemo;

type
  TFrmEmailExcelSheet = class(TForm)
    Excel: TcxSpreadSheetBook;
    sPanel2: TsPanel;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sImage1: TsImage;
    __attahments: TsLabel;
    __imgHelp: TsImage;
    edtRecipient: TsEdit;
    edCC: TsEdit;
    edBCC: TsEdit;
    edSubject: TsEdit;
    cbxTemplates: TsComboBox;
    sPanel1: TsPanel;
    sPanel3: TsPanel;
    StoreMain: TcxPropertiesStore;
    edEmailText: TsMemo;
    sPanel4: TsPanel;
    sPanel5: TsPanel;
    sButton3: TsButton;
    sButton4: TsButton;
    sLabel5: TsLabel;
    procedure FormShow(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FExcelFile: String;
    procedure SetExcelFile(const Value: String);
    function GetFilenameOfExcelSheet: String;
    function GetFilePathOfExcelSheet: String;
    { Private declarations }
  public
    { Public declarations }
    AllowEditAndSend : Boolean;
    property ExcelFile : String read FExcelFile write SetExcelFile;
  end;

var
  FrmEmailExcelSheet: TFrmEmailExcelSheet;

procedure sendFileAsAttachment(recipient, _caption : String; ExcelFile : String; AllowEditAndSendEmail : Boolean) ;

implementation

{$R *.dfm}

uses hData,
     uUtils,
     uD,
     uRoomerLanguage,
     uAppGlobal;

procedure sendFileAsAttachment(recipient, _caption : String; ExcelFile : String; AllowEditAndSendEmail : Boolean);
var _FrmEmailExcelSheet: TFrmEmailExcelSheet;
begin
  _FrmEmailExcelSheet := TFrmEmailExcelSheet.Create(nil);
  try
    _FrmEmailExcelSheet.Caption := _Caption;
    _FrmEmailExcelSheet.ExcelFile := ExcelFile;
    _FrmEmailExcelSheet.edtRecipient.Text := recipient;

    _FrmEmailExcelSheet.AllowEditAndSend := AllowEditAndSendEmail;

    _FrmEmailExcelSheet.ShowModal;
  finally
    FreeAndNil(_FrmEmailExcelSheet);
  end;
end;


procedure TFrmEmailExcelSheet.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
end;

procedure TFrmEmailExcelSheet.FormShow(Sender: TObject);
var Key : String;
    Value : String;
begin
  Key := StringReplace(Caption + '_EXCEL_', ' ', '_', [rfReplaceAll, rfIgnoreCase]);
  Value :=
        'Dear receipient,' + #13#10 +
        '' + #13#10 +
        '   Please find our most recent rate changes in the attached excel sheet.' + #13#10 +
        '' + #13#10 +
        'With our kindest regards,' + #13#10 +
        'Roomer Revenue managers';
  EdEmailText.Text := ReadStringValueFromAppRegistry('_ALL_USERS_', Key + 'TEXT', Value);

  Value := 'Roomer Rate changes for ' + hData.ctrlGetString('CompanyName');
  edSubject.Text := ReadStringValueFromAppRegistry('_ALL_USERS_', Key + 'RATE_CHANGES_SUBJECT', Value);

  edtRecipient.Text := hData.ctrlGetString('CompanyEmail');
  edCC.Text := ReadStringValueFromAppRegistry('_ALL_USERS_', Key + 'CC', '');
  edBCC.Text := ReadStringValueFromAppRegistry('_ALL_USERS_', Key + 'BCC', 'revenue.management@roomerpms.com');

  //
  __attahments.visible := true;
  sImage1.visible := true;

  sPanel4.Visible     := AllowEditAndSend;
  sPanel2.Visible     := AllowEditAndSend;
  edEmailText.Visible := AllowEditAndSend;
  sPanel1.Visible     := AllowEditAndSend;
  Excel.ReadOnly      := NOT AllowEditAndSend;

end;

procedure TFrmEmailExcelSheet.sButton1Click(Sender: TObject);
var list : TStringlist;
begin
  list := TStringlist.create;
  try
    list.Add(FExcelFile);
    Excel.SaveToFile(GetFilePathOfExcelSheet);
    d.RoomerMainDataset.sendEmailOpenAPI(edSubject.Text, 'revenue.management@roomerpms.com',
          edtRecipient.Text, edCc.Text, edBcc.Text, edEmailText.Text, simpleTextTosimpleHtml(edEmailText.Text), list);
    Close;
  finally
    list.Free;
  end;
end;

function TFrmEmailExcelSheet.GetFilenameOfExcelSheet : String;
begin
  result := copy(FExcelFile, pos('=', FExcelFile) + 1, maxint);
end;

function TFrmEmailExcelSheet.GetFilePathOfExcelSheet : String;
begin
  result := copy(FExcelFile, 1, pos('=', FExcelFile) - 1);
end;


procedure TFrmEmailExcelSheet.SetExcelFile(const Value: String);
var
  filename,
  filePath : String;
begin
  __attahments.Caption := '';
  FExcelFile := Value;
  filename := GetFilenameOfExcelSheet;
  filePath := GetFilePathOfExcelSheet;
  if __attahments.Caption = '' then
    __attahments.Caption := filename
  else
    __attahments.Caption := __attahments.Caption + ', ' + filename;
  Excel.LoadFromFile(FilePath);
end;

end.
