unit UnitEditors;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, sFrameAdapter, StdCtrls, sMemo, sComboBoxes, sTooledit, sCurrencyEdit, sComboEdit,
  sCurrEdit, sCustomComboEdit, Mask, sEdit, sSpinEdit, sComboBox, sMaskEdit, sListBox, sLabel, ComCtrls, sRichEdit, sButton, sDialogs, sCheckListBox, sTreeView,
  sCheckBox, sGroupBox, sFileCtrl, acShellCtrls, sFontCtrls;

type
  TFrameEditors = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sMemo1: TsMemo;
    sSpinEdit1: TsSpinEdit;
    sEdit1: TsEdit;
    sMaskEdit1: TsMaskEdit;                                                                                                                              
    sLabel1: TsLabel;
    sRichEdit1: TsRichEdit;
    sButton1: TsButton;
    sOpenDialog1: TOpenDialog;
    sTreeView1: TsTreeView;
    sTimePicker1: TsTimePicker;
    sDateEdit1: TsDateEdit;
    sCalcEdit1: TsCalcEdit;
    sComboEdit1: TsComboEdit;
    sCurrencyEdit1: TsCurrencyEdit;
    sFilenameEdit1: TsFilenameEdit;
    sDirectoryEdit1: TsDirectoryEdit;
    procedure sButton1Click(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  end;

implementation

uses sVCLUtils;

{$R *.DFM}

procedure TFrameEditors.sButton1Click(Sender: TObject);
begin
  if sOpenDialog1.Execute then sRichedit1.Lines.LoadFromFile(sOpenDialog1.fileName);
end;

procedure TFrameEditors.FrameResize(Sender: TObject);
begin
  sTreeView1.Items[0].Expand(True);
end;

end.
