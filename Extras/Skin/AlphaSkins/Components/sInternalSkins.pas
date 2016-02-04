unit sInternalSkins;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, FileCtrl, ActnList, ExtCtrls,
  {$IFDEF DELPHI_XE2} UITypes,   {$ENDIF}
  sSkinManager, acntUtils, sSkinProvider, sPanel, sButton, sListBox, sLabel;


type
  TFormInternalSkins = class(TForm)
    ActionList1: TActionList;
    ActionAddNew: TAction;
    ActionDelete: TAction;
    ActionRename: TAction;
    ActionClose: TAction;
    sSkinProvider1: TsSkinProvider;
    ActionClear: TAction;
    ActionExtract: TAction;
    ActionUpdateAll: TAction;
    sPanel2: TsPanel;
    ListBox1: TsListBox;
    sPanel3: TsPanel;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sPanel1: TsPanel;
    sPanel4: TsPanel;
    sButton2: TsButton;
    sButton3: TsButton;
    sButton4: TsButton;
    sButton1: TsButton;
    sButton5: TsButton;
    sButton6: TsButton;
    sPanel5: TsPanel;
    sBitBtn1: TsButton;
    procedure ActionAddNewExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionRenameExecute(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionExtractExecute(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionUpdateAllExecute(Sender: TObject);
  public
    NewName: string;
    NewDir: string;
    SkinManager: TsSkinManager;
    procedure AddNewSkin;
    procedure UpdateMyActions;
  end;


var
  FormInternalSkins: TFormInternalSkins;


implementation

uses
  IniFiles,
  {$IFNDEF ALITE} acSelectSkin, {$ENDIF}
  sStrings, sDefaults, sConst;

{$R *.DFM}

procedure TFormInternalSkins.AddNewSkin;
var
  s, IntName: string;
  i: integer;
begin
  s := NormalDir(NewDir) + NewName + s_Dot + acSkinExt;
  if FileExists(s) then begin
    IntName := NewName + s_Space + acs_InternalSkin;
    for i := 0 to SkinManager.InternalSkins.Count - 1 do
      if SkinManager.InternalSkins[i].Name = IntName then
        Exit;

    SkinManager.InternalSkins.Add;
    SkinManager.InternalSkins[SkinManager.InternalSkins.Count - 1].Name := IntName;
    SkinManager.InternalSkins[SkinManager.InternalSkins.Count - 1].PackedData.LoadFromFile(s);
    ListBox1.Items.Add(SkinManager.InternalSkins[SkinManager.InternalSkins.Count - 1].Name);
  end
  else begin
    s := s + s_Dot + acSkinExt + ' file with a skin data does not exists';
    ShowWarning(s);
  end;
end;


procedure TFormInternalSkins.ActionAddNewExecute(Sender: TObject);
var
{$IFDEF ALITE}
  fod: TOpenDialog;
{$ELSE}
  sl: TStringList;
  i: integer;
{$ENDIF}
begin
{$IFNDEF ALITE}
  sl := TStringList.Create;
  if NewName <> '' then
    sl.Add(NewName);

  if SelectSkin(sl, NewDir, stPacked) then
    for i := 0 to sl.Count - 1 do begin
      NewName := sl[i];
      AddNewSkin;
    end;

  sLabel1.Caption := NewDir;
  FreeAndNil(sl);
{$ELSE}
  fod := TOpenDialog.Create(Application);
  fod.Filter := 'Packed AlphaSkins|*.' + acSkinExt;
  fod.InitialDir := NewDir;
  if fod.Execute then begin
    NewDir := ExtractFilePath(fod.FileName);
    NewName := ExtractFileName(fod.FileName);
    Delete(NewName, Length(NewName) - 3, 4);
    SkinManager.InternalSkins.Add;
    SkinManager.InternalSkins[SkinManager.InternalSkins.Count - 1].Name := NewName + s_Space + acs_InternalSkin;
    SkinManager.InternalSkins[SkinManager.InternalSkins.Count - 1].PackedData.LoadFromFile(fod.FileName);
    ListBox1.Items.Add(SkinManager.InternalSkins[SkinManager.InternalSkins.Count - 1].Name);
  end;
  sLabel1.Caption := fod.InitialDir;
  fod.Free;
{$ENDIF}
  UpdateMyActions;
end;


procedure TFormInternalSkins.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;


procedure TFormInternalSkins.ActionRenameExecute(Sender: TObject);
var
  i: integer;
  s: string;
begin
  s := ListBox1.Items[ListBox1.ItemIndex];
  if InputQuery('String input', 'Enter new name:', s) then begin
    if ListBox1.ItemIndex > -1 then begin
      for i := 0 to SkinManager.InternalSkins.Count - 1 do
        if SkinManager.InternalSkins.Items[i].Name = ListBox1.Items[ListBox1.ItemIndex] then begin
          SkinManager.InternalSkins.Items[i].Name := s;
          break;
        end;

      ListBox1.Items[ListBox1.ItemIndex] := s;
    end;
    UpdateMyActions;
  end;
end;


procedure TFormInternalSkins.ActionDeleteExecute(Sender: TObject);
var
  i: integer;
begin
  if ListBox1.ItemIndex > -1 then begin
    for i := 0 to SkinManager.InternalSkins.Count - 1 do
      if SkinManager.InternalSkins.Items[i].Name = ListBox1.Items[ListBox1.ItemIndex] then begin
        SkinManager.InternalSkins.Delete(i);
        break;
      end;

    ListBox1.Items.Delete(ListBox1.ItemIndex);
  end;
  UpdateMyActions;
end;


procedure TFormInternalSkins.ListBox1Click(Sender: TObject);
begin
  UpdateMyActions;
end;


procedure TFormInternalSkins.FormShow(Sender: TObject);
begin
  NewDir := DefaultManager.SkinDirectory;
  if not acDirExists(NewDir) then
    NewDir := DefSkinsDir;

  sLabel1.Caption := NewDir;
  UpdateMyActions;
  ReleaseCapture;
end;


procedure TFormInternalSkins.UpdateMyActions;
begin
  ActionClear.Enabled := (ListBox1.Items.Count > 0);
  ActionUpdateAll.Enabled := ActionClear.Enabled;
  ActionDelete.Enabled := ActionClear.Enabled and (ListBox1.ItemIndex > -1);
  ActionRename.Enabled := ActionDelete.Enabled;
  ActionExtract.Enabled := ActionDelete.Enabled;
end;


procedure TFormInternalSkins.ActionExtractExecute(Sender: TObject);
var
  s: string;
begin
  s := s_Slash;
  SelectDirectory(s, [], -1);
  if s <> s_Slash then
    SkinManager.ExtractInternalSkin(ListBox1.Items[ListBox1.ItemIndex], s);
end;


procedure TFormInternalSkins.ActionClearExecute(Sender: TObject);
begin
{$IFNDEF ALITE}
  if Customrequest('Do you really want to delete all internal skins?') then begin
{$ELSE}
  if MessageDlg('Do you really want to delete all internal skins?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
{$ENDIF}
    while SkinManager.InternalSkins.Count > 0 do
      SkinManager.InternalSkins.Delete(0);

    ListBox1.Items.Clear;
    UpdateMyActions;
  end;
end;


procedure TFormInternalSkins.ActionUpdateAllExecute(Sender: TObject);
var
  i, p: integer;
  sFileName, sn: string;
begin
  for i := 0 to SkinManager.InternalSkins.Count - 1 do begin
    sFileName := SkinManager.InternalSkins[i].Name;
    p := Pos(s_Space + acs_InternalSkin, sFileName);
    if p > 0 then
      Delete(sFileName, p, Length(s_Space + acs_InternalSkin));
      
    sFileName := NormalDir(NewDir) + sFileName + s_Dot + acSkinExt;
    if FileExists(sFileName) then begin
      SkinManager.InternalSkins[i].PackedData.Clear;
      SkinManager.InternalSkins[i].PackedData.LoadFromFile(sFileName);
    end
    else begin
      if sn <> '' then
        sn := sn + ', ';
        
      sn := sn + SkinManager.InternalSkins[i].Name;
    end;
  end;
  if sn <> '' then
    ShowWarning('These skins are not updated:' + s_0D0A + sn)
  else
    MessageDlg('All internal skins were reloaded from disk!', mtInformation, [mbOk], 0);
end;

end.
