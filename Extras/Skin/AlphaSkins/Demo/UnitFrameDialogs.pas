unit UnitFrameDialogs;
{$WARNINGS OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, sFrameAdapter, ExtCtrls, sPanel, sGroupBox, StdCtrls, sEdit,
  sCheckListBox, sRadioButton, sButton, sLabel, sCheckBox;

type
  TFrameDialogs = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sGroupBox1: TsGroupBox;
    sEdit1: TsEdit;
    sGroupBox2: TsGroupBox;
    sButton1: TsButton;
    sRadioButton1: TsRadioButton;
    sRadioButton2: TsRadioButton;
    sRadioButton3: TsRadioButton;
    sRadioButton4: TsRadioButton;
    sGroupBox3: TsGroupBox;
    sEdit2: TsEdit;
    sButton2: TsButton;
    sGroupBox4: TsGroupBox;
    sEdit3: TsEdit;
    sButton3: TsButton;
    sRadioGroup1: TsRadioGroup;
    sButton4: TsButton;
    sCheckBox1: TsCheckBox;
    sEdit4: TsEdit;
    procedure FrameResize(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrameDialogs : TFrameDialogs;

implementation

{$R *.DFM}

uses sDialogs, sConst;

procedure TFrameDialogs.FrameResize(Sender: TObject);
begin
  sRadioGroup1.ItemIndex := 1;
end;

procedure TFrameDialogs.sButton1Click(Sender: TObject);
var
  DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons;
begin
  if sRadioButton2.Checked
    then Dlgtype := mtError
    else if sRadioButton3.Checked
      then Dlgtype := mtInformation
      else if sRadioButton4.Checked
        then Dlgtype := mtConfirmation
        else Dlgtype := mtWarning;

  case sRadioGroup1.ItemIndex of
    0 : Buttons := [mbOk];
    1 : Buttons := [mbOk, mbCancel];
    2 : Buttons := [mbAbort, mbRetry, mbIgnore];
    3 : Buttons := [mbYes, mbNo, mbCancel];
    4 : Buttons := [mbYes, mbNo];
    5 : Buttons := [mbRetry, mbCancel];
  end;

  if sCheckBox1.Checked then Buttons := Buttons + [mbHelp];

  sMessageDlg(sEdit4.Text, sEdit1.Text, DlgType, Buttons, 1);
end;

procedure TFrameDialogs.sButton2Click(Sender: TObject);
begin
  sShowMessage(sEdit2.Text);
end;

procedure TFrameDialogs.sButton3Click(Sender: TObject);
var
  s : acString;
begin
  s := sEdit3.Text;
  if sInputQuery('Test of InputQuery', 'Please enter the test string :', s) then sEdit3.Text := s;
end;

procedure TFrameDialogs.sButton4Click(Sender: TObject);
begin
  Application.MessageBox(PChar(sEdit2.Text), 'Caption', MB_OK);
end;

end.
