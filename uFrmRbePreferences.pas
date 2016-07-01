unit uFrmRbePreferences;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sComboBox, sLabel, sButton, Vcl.ExtCtrls, sPanel;

type
  TfrmRbePreferences = class(TForm)
    pnlHolder: TsPanel;
    sPanel1: TsPanel;
    btnClose: TsButton;
    sLabelFX12: TsLabelFX;
    sLabel1: TsLabel;
    __cbxSkins: TsComboBox;
    sLabel2: TsLabel;
    __cbxLanguages: TsComboBox;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure __cbxSkinsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure __cbxLanguagesChange(Sender: TObject);
  private
    procedure SaveData;
    procedure GetLanguages;
    { Private declarations }
  public
    { Public declarations }
    embedded : Boolean;
    EmbedWindowCloseEvent : TNotifyEvent;

    procedure PrepareUserInterface;
    procedure BringWindowToFront;
  end;

var
  frmRbePreferences: TfrmRbePreferences;
  frmRbePreferencesX: TfrmRbePreferences;

procedure OpenRbePREferences(embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil);

implementation

{$R *.dfm}

uses   uD
     , uG
     , uUtils
     , uStringUtils
     , uMain
     , uRoomerLanguage
     , uDateUtils
     , uFrmRBEContainer
     ;

procedure OpenRbePREferences( embedPanel : TsPanel = nil; WindowCloseEvent : TNotifyEvent = nil);
var _frmRbePreferences: TfrmRbePreferences;
begin
  _frmRbePreferences := TfrmRbePreferences.Create(nil);
  try
    _frmRbePreferences.embedded := (embedPanel <> nil);
    _frmRbePreferences.EmbedWindowCloseEvent := WindowCloseEvent;
    _frmRbePreferences.PrepareUserInterface;
    if _frmRbePreferences.embedded then
    begin
      _frmRbePreferences.pnlHolder.parent := embedPanel;
      embedPanel.Update;
      frmRbePreferencesX := _frmRbePreferences;
    end
    else
    begin
      _frmRbePreferences.ShowModal;
    end;
  finally
    if (embedPanel = nil) then
      FreeAndNil(_frmRbePreferences);
  end;
end;

{ TfrmRbePreferences }

procedure TfrmRbePreferences.BringWindowToFront;
begin
  pnlHolder.BringToFront;
end;

procedure TfrmRbePreferences.btnCloseClick(Sender: TObject);
begin
 //
  SaveData;
  if embedded then
    Close;
end;

procedure TfrmRbePreferences.SaveData;
begin
 //
end;

procedure TfrmRbePreferences.__cbxLanguagesChange(Sender: TObject);
var
  languageItem : TRoomerLanguageItem;
begin
  languageItem := TRoomerLanguageItem(__cbxLanguages.Items.Objects[__cbxLanguages.itemindex]);

  if g.ChangeLang(languageItem.id, true) then
  begin
    RoomerLanguage.SetLanguageId(g.qUserLanguage,
      g.qUser + '.' + inttostr(g.qUserLanguage) + '.' + dateTimeToStr(now));
    FrmRBEContainer.TranslateOpenRBEForms;
    frmMain.TranslateOpenForms;
  end;
end;

procedure TfrmRbePreferences.__cbxSkinsChange(Sender: TObject);
var
  skin: String;
begin
  frmMain.sSkinManager1.active := false;
  try
    skin := __cbxSkins.Items[__cbxSkins.ItemIndex];
    frmMain.sSkinManager1.skinName := DelChars(skin, '&');
    WriteStringValueToAnyRegistry('Software\Roomer\FormStatus\StoreMainV2\sSkinManager1', 'SkinName', frmMain.sSkinManager1.skinName);
  finally
    frmMain.sSkinManager1.active := true;
  end;
  frmMain.sSkinManager1.Loaded;
  frmMain.SetExtraSkinColors;
end;

procedure TfrmRbePreferences.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pnlHolder.Parent := self;
  update;
  if embedded then
    Action := caFree;
  if Assigned(EmbedWindowCloseEvent) then
    EmbedWindowCloseEvent(self);
end;

procedure TfrmRbePreferences.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
end;

procedure TfrmRbePreferences.PrepareUserInterface;
var i : Integer;
begin
 //
  for i := 0 to frmMain.sSkinManager1.InternalSkins.Count - 1 do
  begin
    __cbxSkins.Items.Add(frmMain.sSkinManager1.InternalSkins[i].name);
    if frmMain.sSkinManager1.InternalSkins[i].name = frmMain.sSkinManager1.skinName then
      __cbxSkins.ItemIndex := i;
  end;

  GetLanguages;
end;

procedure TfrmRbePreferences.GetLanguages;
var
  i,
  iCurrentIndex : Integer;
begin
  iCurrentIndex := 0;
  for i := 0 to RoomerLanguage.LanguageCount-1 do
  begin
    if RoomerLanguage.Language[i].Active then
    begin
      __cbxLanguages.Items.AddObject(RoomerLanguage.Language[i].LocalName, RoomerLanguage.Language[i]);
      if RoomerLanguage.Language[i].id = g.qUserLanguage then
        iCurrentIndex := i;
    end;
  end;
  __cbxLanguages.itemindex := iCurrentIndex;
end;

end.
