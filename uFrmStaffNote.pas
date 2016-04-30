unit uFrmStaffNote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sLabel, sButton, Vcl.ExtCtrls, sPanel, sMemo, sComboBox, cxClasses, cxPropertiesStore;

type
  TFrmStaffNote = class(TForm)
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    sPanel1: TsPanel;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    lblNoteDate: TsLabel;
    lblAuthor: TsLabel;
    lblWhen: TsLabel;
    sLabel6: TsLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    __cbxAction: TsComboBox;
    mmoText: TsMemo;
    FormStore: TcxPropertiesStore;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmStaffNote: TFrmStaffNote;

function EditDayNote(ForDate : TDate; Author : String; When : TDateTime; var Action : String; var Memo : String) : Boolean;

implementation

{$R *.dfm}

uses uRoomerLanguage, uAppGlobal, uUtils;

function EditDayNote(ForDate : TDate; Author : String; When : TDateTime; var Action : String; var Memo : String) : Boolean;
var _FrmStaffNote: TFrmStaffNote;
begin
  result := False;
  _FrmStaffNote := TFrmStaffNote.Create(nil);
  try
    _FrmStaffNote.lblNoteDate.Caption := DateToStr(ForDate);
    _FrmStaffNote.lblAuthor.Caption := Author;
    _FrmStaffNote.lblWhen.Caption := DateTimeToStr(When);

    _FrmStaffNote.__cbxAction.ItemIndex := _FrmStaffNote.__cbxAction.IndexOf(Action);
    if _FrmStaffNote.__cbxAction.ItemIndex < 0 then
      _FrmStaffNote.__cbxAction.ItemIndex := 0;
    _FrmStaffNote.mmoText.Lines.Text := Memo;

    if _FrmStaffNote.ShowModal = mrOk then
    begin
      result := True;
      Action := _FrmStaffNote.__cbxAction.Text;
      Memo := _FrmStaffNote.mmoText.Lines.Text;
    end;
  finally
    FreeAndNil(_FrmStaffNote)
  end;
end;

procedure TFrmStaffNote.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

end.
