unit uRoomerMessageDialog;

interface

uses
  Dialogs, Forms, Graphics, StdCtrls, Registry, Windows;

function RoomerMessageDialogWithCaptions(Const Msg: String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DialogId : String; defaultResultButton : Integer; Captions: array of string): Integer;
function RoomerMessageDialog(Const Msg: String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DialogId : String; defaultResultButton : Integer): Integer;

implementation

uses uG
    , uRegistryServices
    , PrjConst
    , _Glob
    ;

function GetMessageDlgBooleanRegistryValue(ValueName : String) : Boolean; forward;
procedure PutMessageDlgBooleanRegistryValue(ValueName : String; Value : Boolean); forward;

function RoomerMessageDialog(Const Msg: String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DialogId : String; defaultResultButton : Integer): Integer;
var
  AMsgDialog: TForm;
  ACheckBox: TCheckBox;
  dlgButton: TButton;
  iWidth, CaptionIndex: Integer;
begin
  if GetMessageDlgBooleanRegistryValue(DialogId) then
  begin
    result := defaultResultButton;
    exit;
  end;

  AMsgDialog := CreateMessageDialog(Msg, DlgType, Buttons);
  ACheckBox := TCheckBox.Create(AMsgDialog);
  with AMsgDialog do
    try
//      Caption := Title;
      Height := 170;
      CaptionIndex := 0;
      with ACheckBox do
      begin
        Parent := AMsgDialog;
        Caption := GetTranslatedText('Dialog_Do_Not_Show_Again');
        iWidth := Canvas.TextWidth(Caption)+30;

        Width := iWidth;
        Top := 121;
        Left := 8;
      end;
      if ACheckBox.Width + 30 > Width then
        Width := ACheckBox.Width + 30;
      result := ShowModal;
      PutMessageDlgBooleanRegistryValue(DialogId, ACheckBox.Checked);
    finally
      Free;
    end;
end;

function RoomerMessageDialogWithCaptions(Const Msg: String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DialogId : String; defaultResultButton : Integer; Captions: array of string): Integer;
var
  AMsgDialog: TForm;
  ACheckBox: TCheckBox;
  dlgButton: TButton;
  i, CaptionIndex: Integer;
begin
  if GetMessageDlgBooleanRegistryValue(DialogId) then
  begin
    result := defaultResultButton;
    exit;
  end;

  AMsgDialog := CreateMessageDialog(Msg, DlgType, Buttons);
  ACheckBox := TCheckBox.Create(AMsgDialog);
  with AMsgDialog do
    try
//      Caption := Title;
      Height := 170;
      CaptionIndex := 0;
      for i := 0 to ComponentCount - 1 do
      begin
        if Components[i] is TButton then
        begin
          dlgButton := TButton(Components[i]);
          if CaptionIndex > High(Captions) then
            Break;
          dlgButton.Caption := Captions[CaptionIndex];
          Inc(CaptionIndex);
        end;
      end;
      repaint;
      with ACheckBox do
      begin
        Parent := AMsgDialog;
        Caption := GetTranslatedText('Dialog_Do_Not_Show_Again');
        width := Canvas.TextWidth(Caption)+30;
        Top := 121;
        Left := 8;
      end;
      result := ShowModal;
      PutMessageDlgBooleanRegistryValue(DialogId, ACheckBox.Checked);
    finally
      Free;
    end;
end;

function GetMessageDlgBooleanRegistryValue(ValueName : String) : Boolean;
var
  reg        : TRoomerRegistryIniFile;
  Key : String;
begin
  Key := g.qUser + '_' + ValueName;
  reg := TRoomerRegistryIniFile.Create(GetHotelIniFilename);
  reg.RegIniFile.RootKey := HKEY_CURRENT_USER;
  result := reg.ReadBool('RoomerMessageDialogs', Key, false);
end;

procedure PutMessageDlgBooleanRegistryValue(ValueName : String; Value : Boolean);
var
  reg        : TRoomerRegistryIniFile;
  Key : String;
begin
  Key := g.qUser + '_' + ValueName;
  reg := TRoomerRegistryIniFile.Create(GetHotelIniFilename);
  reg.RegIniFile.RootKey := HKEY_CURRENT_USER;
  reg.WriteBool('RoomerMessageDialogs', Key, Value);
end;

end.
