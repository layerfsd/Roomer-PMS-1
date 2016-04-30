unit ufrmSelLang;

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

  , _Glob
  , ug, sComboBox, sButton, sPanel, sLabel
  ;

type
  TfrmSelLang = class(TForm)
    Label1: TsLabel;
    Panel1: TsPanel;
    cbxSelLang: TsComboBox;
    BtnOk: TsButton;
    btnCancel: TsButton;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    zLangId   : integer;
    zLangName : string;
    zLangExt : string;


  end;

var
  frmSelLang: TfrmSelLang;

implementation

{$R *.DFM}

uses uAppGlobal, uRoomerLanguage, uUtils;

procedure TfrmSelLang.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmSelLang.FormShow(Sender: TObject);
var
  i,
  iCurrentIndex : Integer;
begin
  iCurrentIndex := 0;
  for i := 0 to RoomerLanguage.LanguageCount-1 do
  begin
    if RoomerLanguage.Language[i].Active then
    begin
      cbxSelLang.Items.AddObject(RoomerLanguage.Language[i].LocalName, RoomerLanguage.Language[i]);
      if RoomerLanguage.Language[i].id = zLangId then
        iCurrentIndex := i;
    end;
  end;
  cbxSelLang.itemindex := iCurrentIndex;
end;

procedure TfrmSelLang.btnOkClick(Sender: TObject);
var
  line : string;
  languageItem : TRoomerLanguageItem;
begin
  languageItem := TRoomerLanguageItem(cbxSelLang.Items.Objects[cbxSelLang.itemindex]);
  zLangId   := languageItem.id;
  zLangName := languageItem.LocalName;
  zLangExt  := languageItem.CultureId;
end;

end.
