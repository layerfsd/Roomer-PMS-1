unit acSelectSkin;
{$I sDefs.inc}
//+

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, sListBox, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask,

  sBitBtn, sSkinProvider, sPanel, sMaskEdit, sSkinManager, sCustomComboEdit, sTooledit;


{$IFNDEF NOTFORHELP}
type
  TFormSkinSelect = class(TForm)
    sListBox1: TsListBox;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    sPanel1: TsPanel;
    sSkinProvider1: TsSkinProvider;
    sDirectoryEdit1: TsDirectoryEdit;
    procedure sListBox1Click(Sender: TObject);
    procedure sDirectoryEdit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sListBox1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  public
    sName: string;
    SkinTypes: TacSkinTypes;
    SkinPlaces: TacSkinPlaces;
    SkinManager: TsSkinManager;
    procedure InitLngCaptions;
  end;


var
  FormSkinSelect: TFormSkinSelect;
{$ENDIF}

function SelectSkin(var SkinName: string;  var SkinDir: string; SkinTypes: TacSkinTypes = stAllSkins): boolean; overload;
function SelectSkin(NameList: TStringList; var SkinDir: string; SkinTypes: TacSkinTypes = stAllSkins): boolean; overload;
function SelectSkin(SkinManager: TsSkinManager; SkinPlaces: TacSkinPlaces = spAllPlaces): boolean; overload;


implementation

uses
{$IFDEF TNTUNICODE}
  {$IFNDEF D2006}
    TntWideStrings,
  {$ELSE}
    WideStrings,
  {$ENDIF}
{$ENDIF}
  acntUtils, sStoreUtils, sConst, acSkinPreview;

{$R *.dfm}


function SelectSkin(SkinManager: TsSkinManager; SkinPlaces: TacSkinPlaces = spAllPlaces): boolean;
var
  s: string;
begin
  Result := False;
  FormSkinSelect := TFormSkinSelect.Create(Application);
  FormSkinSelect.InitLngCaptions;
  FormSkinSelect.SkinTypes := stAllSkins;
  FormSkinSelect.SkinPlaces := SkinPlaces;
  s := ReadRegString(HKEY_CURRENT_USER, 'SOFTWARE\' + s_RegName, s_IntSkinsPath);
  if not (csDesigning in SkinManager.ComponentState) or (s = '') {$IFDEF DELPHI6UP}or not DirectoryExists(s){$ENDIF} then
    FormSkinSelect.sDirectoryEdit1.Text := SkinManager.SkinDirectory
  else
    FormSkinSelect.sDirectoryEdit1.Text := s;

  FormSkinSelect.sName := SkinManager.SkinName;
  FormSkinSelect.SkinManager := SkinManager;
  if FormSkinSelect.ShowModal = mrOk then begin
    SkinManager.SkinDirectory := FormSkinSelect.sDirectoryEdit1.Text;
    WriteRegString(HKEY_CURRENT_USER, 'SOFTWARE\' + s_RegName, s_IntSkinsPath, SkinManager.SkinDirectory);
    SkinManager.SkinName := FormSkinSelect.sListBox1.Items[FormSkinSelect.sListBox1.ItemIndex];
    Result := True;
  end;
  FreeAndNil(FormSkinSelect);
end;


function SelectSkin(var SkinName: string; var SkinDir: string; SkinTypes: TacSkinTypes = stAllSkins): boolean;
var
  s: string;
begin
  Result := False;
  FormSkinSelect := TFormSkinSelect.Create(Application);
  FormSkinSelect.InitLngCaptions;
  FormSkinSelect.SkinTypes := SkinTypes;
  FormSkinSelect.SkinPlaces := spExternal;
  s := ReadRegString(HKEY_CURRENT_USER, 'SOFTWARE\' + s_RegName, s_IntSkinsPath);
  if not IsIDERunning or (s = '') {$IFDEF DELPHI6UP}or not DirectoryExists(s){$ENDIF} then
    FormSkinSelect.sDirectoryEdit1.Text := SkinDir
  else
    FormSkinSelect.sDirectoryEdit1.Text := s;

  FormSkinSelect.sName := SkinName;
  FormSkinSelect.SkinManager := nil;
  if FormSkinSelect.ShowModal = mrOk then begin
    SkinName := FormSkinSelect.sListBox1.Items[FormSkinSelect.sListBox1.ItemIndex];
    SkinDir := FormSkinSelect.sDirectoryEdit1.Text;
    WriteRegString(HKEY_CURRENT_USER, 'SOFTWARE\' + s_RegName, s_IntSkinsPath, SkinDir);
    Result := True;
  end;
  FreeAndNil(FormSkinSelect);
end;


function SelectSkin(NameList: TStringList; var SkinDir: string; SkinTypes: TacSkinTypes = stAllSkins): boolean; overload;
var
  s: string;
  i: integer;
begin
  Result := False;
  if NameList = nil then
    Exit;

  FormSkinSelect := TFormSkinSelect.Create(Application);
  FormSkinSelect.InitLngCaptions;
  FormSkinSelect.SkinTypes := SkinTypes;
  FormSkinSelect.SkinPlaces := spExternal;
  s := ReadRegString(HKEY_CURRENT_USER, 'SOFTWARE\' + s_RegName, s_IntSkinsPath);
  if not IsIDERunning or (s = '') {$IFDEF DELPHI6UP}or not DirectoryExists(s){$ENDIF} then
    FormSkinSelect.sDirectoryEdit1.Text := SkinDir
  else
    FormSkinSelect.sDirectoryEdit1.Text := s;

  if NameList.Count > 0 then
    FormSkinSelect.sName := NameList[0]
  else
    FormSkinSelect.sName := '';

  FormSkinSelect.SkinManager := nil;
  if FormSkinSelect.ShowModal = mrOk then begin
    NameList.Clear;
    for I := 0 to FormSkinSelect.sListBox1.Items.Count - 1 do
      if FormSkinSelect.sListBox1.Selected[I] then
        NameList.Add(FormSkinSelect.sListBox1.Items[i]);

    SkinDir := FormSkinSelect.sDirectoryEdit1.Text;
    WriteRegString(HKEY_CURRENT_USER, 'SOFTWARE\' + s_RegName, s_IntSkinsPath, SkinDir);
    Result := True;
  end;
  FreeAndNil(FormSkinSelect);
end;


procedure TFormSkinSelect.sListBox1Click(Sender: TObject);
begin
  if IsValidIndex(sListBox1.ItemIndex, sListBox1.Items.Count) then begin
    FormSkinPreview.PreviewManager.SkinName := sListBox1.Items[sListBox1.ItemIndex];
    FormSkinPreview.PreviewManager.Active := True;
    sBitBtn1.Enabled := True;
  end
  else
    sBitBtn1.Enabled := False;

  FormSkinPreview.Visible := sBitBtn1.Enabled;
end;


procedure TFormSkinSelect.sDirectoryEdit1Change(Sender: TObject);
var
  i: integer;
begin
  if Assigned(FormSkinPreview) and Assigned(FormSkinPreview.PreviewManager) then begin
    FormSkinPreview.PreviewManager.SkinDirectory := sDirectoryEdit1.Text;
    if SkinManager <> nil then begin
      FormSkinPreview.PreviewManager.InternalSkins.Clear;
      for i := 0 to SkinManager.InternalSkins.Count - 1 do with
        FormSkinPreview.PreviewManager.InternalSkins.Add do
          Assign(SkinManager.InternalSkins[i]);
    end;
    sListBox1.Items.BeginUpdate;
    sListBox1.Items.Clear;
    case SkinPlaces of
      spAllPlaces:
        FormSkinPreview.PreviewManager.GetSkinNames({$IFDEF TNTUNICODE}TWideStrings{$ENDIF}(sListBox1.Items), SkinTypes);

      spExternal: 
        FormSkinPreview.PreviewManager.GetExternalSkinNames({$IFDEF TNTUNICODE}TWideStrings{$ENDIF}(sListBox1.Items), SkinTypes);

      spInternal:
        if FormSkinPreview.PreviewManager.InternalSkins.Count > 0 then
          for i := 0 to FormSkinPreview.PreviewManager.InternalSkins.Count - 1 do
            sListBox1.Items.Add(FormSkinPreview.PreviewManager.InternalSkins[i].Name);
    end;
    sListBox1.Items.EndUpdate;
    if not sBitBtn1.Enabled and (sName <> '') then begin
      i := sListBox1.Items.IndexOf(sName);
      if i >= 0 then
        sListBox1.ItemIndex := i;
    end;
    sBitBtn1.Enabled := sListBox1.ItemIndex >= 0;
    if not sBitBtn1.Enabled then begin
      FormSkinPreview.Visible := False;
      FormSkinPreview.PreviewManager.Active := False;
    end
    else
      sListBox1.OnClick(sListBox1);
  end;
end;


procedure TFormSkinSelect.FormDestroy(Sender: TObject);
begin
  if FormSkinPreview <> nil then
    FreeAndNil(FormSkinPreview);
end;


procedure TFormSkinSelect.FormShow(Sender: TObject);
begin
  if FormSkinPreview = nil then begin
    FormSkinPreview := TFormSkinPreview.Create(Application);
    FormSkinPreview.Visible := False;
    FormSkinPreview.Align := alClient;
    if FormSkinSelect.SkinPlaces = spInternal then
      sDirectoryEdit1.Visible := False
  end;
  FormSkinPreview.Parent := sPanel1;
  sDirectoryEdit1.OnChange(sDirectoryEdit1);
end;


procedure TFormSkinSelect.sListBox1DblClick(Sender: TObject);
begin
  sBitBtn1.Click
end;


procedure TFormSkinSelect.InitLngCaptions;
begin
  sBitBtn1.Caption := acs_MsgDlgOK;
  sBitBtn2.Caption := acs_MsgDlgCancel;
  sDirectoryEdit1.BoundLabel.Caption := acs_DirWithSkins;
  Caption := acs_SelectSkinTitle;
  sPanel1.Caption := acs_SkinPreview;
end;

end.
