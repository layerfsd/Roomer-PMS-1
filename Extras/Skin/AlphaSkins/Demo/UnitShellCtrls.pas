unit UnitShellCtrls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, sListView, acShellCtrls, sTreeView, sComboBoxes, sFrameAdapter,
  StdCtrls, sComboBox;

type
  TFrameShellControls = class(TFrame)
    sShellComboBox1: TsShellComboBox;
    sShellTreeView1: TsShellTreeView;
    sShellListView1: TsShellListView;
    sFrameAdapter1: TsFrameAdapter;
    sComboBox1: TsComboBox;
    procedure sComboBox1Change(Sender: TObject);
  end;

implementation

uses sVCLUtils;

{$R *.DFM}

procedure TFrameShellControls.sComboBox1Change(Sender: TObject);
const
  ViewStyles : array [0..3] of TViewStyle = (vsIcon, vsList, vsReport, vsSmallIcon);
begin
  sShellListView1.ViewStyle := ViewStyles[sComboBox1.ItemIndex];
//  if Assigned(Ac_SetWindowTheme) then Ac_SetWindowTheme(sShellListView1.Handle, nil, nil);
end;

end.
