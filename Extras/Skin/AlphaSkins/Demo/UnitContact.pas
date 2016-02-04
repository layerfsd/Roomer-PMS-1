unit UnitContact;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, sSpeedButton, sFrameAdapter, StdCtrls, sLabel, ExtCtrls, sPanel,
  sGroupBox, sCheckBox, ActnList;

type
  TFrameContact = class(TFrame)
    sSpeedButton1: TsSpeedButton;
    sFrameAdapter1: TsFrameAdapter;
    sWebLabel1: TsWebLabel;
    sWebLabel2: TsWebLabel;
    sSpeedButton2: TsSpeedButton;
    sPanel1: TsPanel;
    sGroupBox1: TsGroupBox;
    sCheckBox1: TsCheckBox;
    sCheckBox2: TsCheckBox;
    sCheckBox3: TsCheckBox;
    sCheckBox4: TsCheckBox;
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sCheckBox2Click(Sender: TObject);
    procedure sCheckBox3Click(Sender: TObject);
    procedure sCheckBox4Click(Sender: TObject);
  end;

var
  FrameContact : TFrameContact;

implementation

uses ShellAPI, sConst, MainUnit;

{$R *.DFM}

procedure TFrameContact.sSpeedButton2Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PChar('http://www.alphaskins.com/pchase.php'), nil, nil, ord(soDefault));
end;

procedure TFrameContact.sCheckBox1Click(Sender: TObject);
begin
  if sCheckBox1.Checked
    then MainForm.sSkinManager1.AnimEffects.Buttons.Events := MainForm.sSkinManager1.AnimEffects.Buttons.Events + [beMouseEnter]
    else MainForm.sSkinManager1.AnimEffects.Buttons.Events := MainForm.sSkinManager1.AnimEffects.Buttons.Events - [beMouseEnter]
end;

procedure TFrameContact.sCheckBox2Click(Sender: TObject);
begin
  if sCheckBox2.Checked
    then MainForm.sSkinManager1.AnimEffects.Buttons.Events := MainForm.sSkinManager1.AnimEffects.Buttons.Events + [beMouseLeave]
    else MainForm.sSkinManager1.AnimEffects.Buttons.Events := MainForm.sSkinManager1.AnimEffects.Buttons.Events - [beMouseLeave]
end;

procedure TFrameContact.sCheckBox3Click(Sender: TObject);
begin
  if sCheckBox3.Checked
    then MainForm.sSkinManager1.AnimEffects.Buttons.Events := MainForm.sSkinManager1.AnimEffects.Buttons.Events + [beMouseDown]
    else MainForm.sSkinManager1.AnimEffects.Buttons.Events := MainForm.sSkinManager1.AnimEffects.Buttons.Events - [beMouseDown]
end;

procedure TFrameContact.sCheckBox4Click(Sender: TObject);
begin
  if sCheckBox4.Checked
    then MainForm.sSkinManager1.AnimEffects.Buttons.Events := MainForm.sSkinManager1.AnimEffects.Buttons.Events + [beMouseUp]
    else MainForm.sSkinManager1.AnimEffects.Buttons.Events := MainForm.sSkinManager1.AnimEffects.Buttons.Events - [beMouseUp]
end;

end.
