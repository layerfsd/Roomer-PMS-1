unit UnitStdVCL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, sCheckListBox, StdCtrls, sFrameAdapter, ExtCtrls,
  sCheckBox, sButton, CheckLst, Mask, Grids, ComCtrls, Buttons, sLabel;

type
  TFrameStdVCL = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    Edit1: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    ListBox1: TListBox;
    StringGrid1: TStringGrid;
    MaskEdit1: TMaskEdit;
    DrawGrid1: TDrawGrid;
    CheckListBox1: TCheckListBox;
    RichEdit1: TRichEdit;
    TreeView1: TTreeView;
    ListView1: TListView;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    RadioGroup1: TRadioGroup;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    SpeedButton1: TSpeedButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ScrollBar1: TScrollBar;
  end;

implementation

uses MainUnit;

{$R *.DFM}

end.
