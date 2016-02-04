unit UnitOtherAdd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, sLabel, sFrameAdapter, Buttons, sSpeedButton, sColorSelect,
  sBitBtn, sMonthCalendar, ExtCtrls, sPanel, sFontCtrls, sScrollBar, ComCtrls, acHeaderControl, sCheckBox, sComboBox, sEdit, sListBox;

type
  TFrameOtherAdd = class(TFrame)
    sWebLabel1: TsWebLabel;
    sFrameAdapter1: TsFrameAdapter;
    sColorSelect1: TsColorSelect;
    sMonthCalendar1: TsMonthCalendar;
    sHeaderControl1: TsHeaderControl;
    sFontListBox1: TsFontListBox;
    sFontComboBox1: TsFontComboBox;
    sComboBox1: TsComboBox;
    procedure FrameResize(Sender: TObject);
    procedure sComboBox1Change(Sender: TObject);
  end;

implementation

uses MainUnit;

{$R *.DFM}

procedure TFrameOtherAdd.FrameResize(Sender: TObject);
begin
    sFontComboBox1.ItemIndex := 0;
end;

procedure TFrameOtherAdd.sComboBox1Change(Sender: TObject);
begin
  sMonthCalendar1.SkinData.SkinSection := sComboBox1.Text
end;

end.
