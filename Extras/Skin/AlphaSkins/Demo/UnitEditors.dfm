object FrameEditors: TFrameEditors
  Left = 0
  Top = 0
  Width = 620
  Height = 544
  VertScrollBar.Tracking = True
  TabOrder = 0
  OnResize = FrameResize
  object sLabel1: TsLabel
    Left = 139
    Top = 419
    Width = 338
    Height = 94
    Alignment = taCenter
    AutoSize = False
    Caption = 'All edit controls in this package have the BoundLabel property'
    Layout = tlCenter
    WordWrap = True
  end
  object sMemo1: TsMemo
    Tag = 5
    Left = 245
    Top = 28
    Width = 228
    Height = 113
    Lines.Strings = (
      'unit Unit2;'
      ''
      'interface'
      ''
      'uses'
      
        '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Form' +
        's, Dialogs,'
      
        '  sButtonControl, sCustomButton, StdCtrls, sEdit, sCustomListBox' +
        ','
      
        '  sCustomMaskEdit, sMonthCalendar, sTrackBar, sGauge, sCustomCom' +
        'boBox,'
      
        '  sCurrEdit, sTooledit, sGroupBox, ExtCtrls, sPanel, sRadioButto' +
        'n,'
      
        '  sCheckedControl, sCheckbox, sComboEdit, Mask, sCustomComboEdit' +
        ','
      
        '  sCurrencyEdit, sSpinEdit, sMemo, sCustomLabel, sBevel, sStatus' +
        'Bar,'
      '  sPageControl, ComCtrls, sSkinProvider, sScrollBar, Menus;'
      ''
      'type'
      '  TForm2 = class(TForm)'
      '    sContainer1: TsContainer;'
      '    sStatusBar1: TsStatusBar;'
      '    sPageControl1: TsPageControl;'
      '    sTabSheet1: TsTabSheet;'
      '    sTabSheet2: TsTabSheet;'
      '    sTabSheet3: TsTabSheet;'
      '    sToolBar1: TsToolBar;'
      '    sToolButton1: TsSpeedButton;'
      '    sToolButton2: TsSpeedButton;'
      '    sToolButton3: TsSpeedButton;'
      '    sGroupBox1: TsGroupBox;'
      '    sContainer2: TsContainer;'
      '    sGauge1: TsGauge;'
      '    sPanel2: TsPanel;'
      '    sSpeedButton1: TsSpeedButton;'
      '    sBitBtn1: TsBitBtn;'
      '    sButton1: TsButton;'
      '    sTrackBar1: TsTrackBar;'
      '    sEdit1: TsEdit;'
      '    sSpinEdit1: TsSpinEdit;'
      '    sMemo1: TsMemo;'
      '    sListBox1: TsListBox;'
      '    sMaskEdit1: TsMaskEdit;'
      '    sDateEdit1: TsDateEdit;'
      '    sComboEdit1: TsComboEdit;'
      '    sCalcEdit1: TsCalcEdit;'
      '    sCurrencyEdit1: TsCurrencyEdit;'
      '    sComboBox1: TsComboBox;'
      '    sDirectoryEdit1: TsDirectoryEdit;'
      '    sFilenameEdit1: TsFilenameEdit;'
      '    sScrollBar1: TsScrollBar;'
      '    sColorSelect1: TsColorSelect;'
      '    sWebLabel1: TsWebLabel;'
      '    sLabel1: TsLabel;'
      '    sRadioButton2: TsRadioButton;'
      '    sCheckBox1: TsCheckBox;'
      '    sRadioButton1: TsRadioButton;'
      '    sCheckBox2: TsCheckBox;'
      '    sCheckBox3: TsCheckBox;'
      '    sScrollBar2: TsScrollBar;'
      '    sScrollBar3: TsScrollBar;'
      '    MainMenu1: TMainMenu;'
      '    Item11: TMenuItem;'
      '    Item111: TMenuItem;'
      '    Item121: TMenuItem;'
      '    Item131: TMenuItem;'
      '    Item141: TMenuItem;'
      '    Item151: TMenuItem;'
      '    Item161: TMenuItem;'
      '    Item171: TMenuItem;'
      '    Item1211: TMenuItem;'
      '    Item1221: TMenuItem;'
      '    Item1231: TMenuItem;'
      '    Item1241: TMenuItem;'
      '    Item21: TMenuItem;'
      '    Item211: TMenuItem;'
      '    Item221: TMenuItem;'
      '    Item231: TMenuItem;'
      '    Item31: TMenuItem;'
      '    sSkinProvider1: TsSkinProvider;'
      '    sMonthCalendar1: TsMonthCalendar;'
      '    sTabSheet4: TsTabSheet;'
      '    sTabSheet5: TsTabSheet;'
      '    sTabSheet6: TsTabSheet;'
      '    sTabSheet7: TsTabSheet;'
      '    sTabSheet8: TsTabSheet;'
      '    sTabSheet9: TsTabSheet;'
      '    sTabSheet10: TsTabSheet;'
      '    sTabSheet11: TsTabSheet;'
      '    sTabSheet12: TsTabSheet;'
      
        '    procedure FormClose(Sender: TObject; var Action: TCloseActio' +
        'n);'
      '    procedure sTrackBar1Change(Sender: TObject);'
      '  private'
      '    { Private declarations }'
      '  public'
      '    { Public declarations }'
      '  end;'
      ''
      'var'
      '  Form2: TForm2;'
      ''
      'implementation'
      ''
      'uses Unit1;'
      ''
      '{$R *.DFM}'
      ''
      
        'procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAc' +
        'tion);'
      'begin'
      '  Action := caFree;'
      'end;'
      ''
      'procedure TForm2.sTrackBar1Change(Sender: TObject);'
      'begin'
      
        '  if Sender = sTrackBar1  then sGauge1.Progress := sTrackBar1.Po' +
        'sition;'
      
        '  if Sender = sScrollBar1 then sGauge1.Progress := sScrollBar1.P' +
        'osition;'
      
        '  if Sender = sScrollBar2 then sGauge1.Progress := sScrollBar2.P' +
        'osition;'
      
        '  if Sender = sScrollBar3 then sGauge1.Progress := sScrollBar3.P' +
        'osition;'
      '  sTrackBar1.Position  := sGauge1.Progress;'
      '  sScrollBar1.Position := sGauge1.Progress;'
      '  sScrollBar2.Position := sGauge1.Progress;'
      '  sScrollBar3.Position := sGauge1.Progress;'
      'end;'
      ''
      'end.')
    ScrollBars = ssBoth
    TabOrder = 0
    Text = 
      'unit Unit2;'#13#10#13#10'interface'#13#10#13#10'uses'#13#10'  Windows, Messages, SysUtils,' +
      ' Classes, Graphics, Controls, Forms, Dialogs,'#13#10'  sButtonControl,' +
      ' sCustomButton, StdCtrls, sEdit, sCustomListBox,'#13#10'  sCustomMaskE' +
      'dit, sMonthCalendar, sTrackBar, sGauge, sCustomComboBox,'#13#10'  sCur' +
      'rEdit, sTooledit, sGroupBox, ExtCtrls, sPanel, sRadioButton,'#13#10'  ' +
      'sCheckedControl, sCheckbox, sComboEdit, Mask, sCustomComboEdit,'#13 +
      #10'  sCurrencyEdit, sSpinEdit, sMemo, sCustomLabel, sBevel, sStatu' +
      'sBar,'#13#10'  sPageControl, ComCtrls, sSkinProvider, sScrollBar, Menu' +
      's;'#13#10#13#10'type'#13#10'  TForm2 = class(TForm)'#13#10'    sContainer1: TsContaine' +
      'r;'#13#10'    sStatusBar1: TsStatusBar;'#13#10'    sPageControl1: TsPageCont' +
      'rol;'#13#10'    sTabSheet1: TsTabSheet;'#13#10'    sTabSheet2: TsTabSheet;'#13#10 +
      '    sTabSheet3: TsTabSheet;'#13#10'    sToolBar1: TsToolBar;'#13#10'    sToo' +
      'lButton1: TsSpeedButton;'#13#10'    sToolButton2: TsSpeedButton;'#13#10'    ' +
      'sToolButton3: TsSpeedButton;'#13#10'    sGroupBox1: TsGroupBox;'#13#10'    s' +
      'Container2: TsContainer;'#13#10'    sGauge1: TsGauge;'#13#10'    sPanel2: Ts' +
      'Panel;'#13#10'    sSpeedButton1: TsSpeedButton;'#13#10'    sBitBtn1: TsBitBt' +
      'n;'#13#10'    sButton1: TsButton;'#13#10'    sTrackBar1: TsTrackBar;'#13#10'    sE' +
      'dit1: TsEdit;'#13#10'    sSpinEdit1: TsSpinEdit;'#13#10'    sMemo1: TsMemo;'#13 +
      #10'    sListBox1: TsListBox;'#13#10'    sMaskEdit1: TsMaskEdit;'#13#10'    sDa' +
      'teEdit1: TsDateEdit;'#13#10'    sComboEdit1: TsComboEdit;'#13#10'    sCalcEd' +
      'it1: TsCalcEdit;'#13#10'    sCurrencyEdit1: TsCurrencyEdit;'#13#10'    sComb' +
      'oBox1: TsComboBox;'#13#10'    sDirectoryEdit1: TsDirectoryEdit;'#13#10'    s' +
      'FilenameEdit1: TsFilenameEdit;'#13#10'    sScrollBar1: TsScrollBar;'#13#10' ' +
      '   sColorSelect1: TsColorSelect;'#13#10'    sWebLabel1: TsWebLabel;'#13#10' ' +
      '   sLabel1: TsLabel;'#13#10'    sRadioButton2: TsRadioButton;'#13#10'    sCh' +
      'eckBox1: TsCheckBox;'#13#10'    sRadioButton1: TsRadioButton;'#13#10'    sCh' +
      'eckBox2: TsCheckBox;'#13#10'    sCheckBox3: TsCheckBox;'#13#10'    sScrollBa' +
      'r2: TsScrollBar;'#13#10'    sScrollBar3: TsScrollBar;'#13#10'    MainMenu1: ' +
      'TMainMenu;'#13#10'    Item11: TMenuItem;'#13#10'    Item111: TMenuItem;'#13#10'   ' +
      ' Item121: TMenuItem;'#13#10'    Item131: TMenuItem;'#13#10'    Item141: TMen' +
      'uItem;'#13#10'    Item151: TMenuItem;'#13#10'    Item161: TMenuItem;'#13#10'    It' +
      'em171: TMenuItem;'#13#10'    Item1211: TMenuItem;'#13#10'    Item1221: TMenu' +
      'Item;'#13#10'    Item1231: TMenuItem;'#13#10'    Item1241: TMenuItem;'#13#10'    I' +
      'tem21: TMenuItem;'#13#10'    Item211: TMenuItem;'#13#10'    Item221: TMenuIt' +
      'em;'#13#10'    Item231: TMenuItem;'#13#10'    Item31: TMenuItem;'#13#10'    sSkinP' +
      'rovider1: TsSkinProvider;'#13#10'    sMonthCalendar1: TsMonthCalendar;' +
      #13#10'    sTabSheet4: TsTabSheet;'#13#10'    sTabSheet5: TsTabSheet;'#13#10'    ' +
      'sTabSheet6: TsTabSheet;'#13#10'    sTabSheet7: TsTabSheet;'#13#10'    sTabSh' +
      'eet8: TsTabSheet;'#13#10'    sTabSheet9: TsTabSheet;'#13#10'    sTabSheet10:' +
      ' TsTabSheet;'#13#10'    sTabSheet11: TsTabSheet;'#13#10'    sTabSheet12: TsT' +
      'abSheet;'#13#10'    procedure FormClose(Sender: TObject; var Action: T' +
      'CloseAction);'#13#10'    procedure sTrackBar1Change(Sender: TObject);'#13 +
      #10'  private'#13#10'    { Private declarations }'#13#10'  public'#13#10'    { Public' +
      ' declarations }'#13#10'  end;'#13#10#13#10'var'#13#10'  Form2: TForm2;'#13#10#13#10'implementati' +
      'on'#13#10#13#10'uses Unit1;'#13#10#13#10'{$R *.DFM}'#13#10#13#10'procedure TForm2.FormClose(Se' +
      'nder: TObject; var Action: TCloseAction);'#13#10'begin'#13#10'  Action := ca' +
      'Free;'#13#10'end;'#13#10#13#10'procedure TForm2.sTrackBar1Change(Sender: TObject' +
      ');'#13#10'begin'#13#10'  if Sender = sTrackBar1  then sGauge1.Progress := sT' +
      'rackBar1.Position;'#13#10'  if Sender = sScrollBar1 then sGauge1.Progr' +
      'ess := sScrollBar1.Position;'#13#10'  if Sender = sScrollBar2 then sGa' +
      'uge1.Progress := sScrollBar2.Position;'#13#10'  if Sender = sScrollBar' +
      '3 then sGauge1.Progress := sScrollBar3.Position;'#13#10'  sTrackBar1.P' +
      'osition  := sGauge1.Progress;'#13#10'  sScrollBar1.Position := sGauge1' +
      '.Progress;'#13#10'  sScrollBar2.Position := sGauge1.Progress;'#13#10'  sScro' +
      'llBar3.Position := sGauge1.Progress;'#13#10'end;'#13#10#13#10'end.'#13#10
    BoundLabel.Active = True
    BoundLabel.Caption = 'sMemo1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclTopLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
  end
  object sSpinEdit1: TsSpinEdit
    Tag = 5
    Left = 105
    Top = 28
    Width = 130
    Height = 21
    TabOrder = 1
    Text = '0'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'sSpinEdit1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    MaxValue = 0
    MinValue = 0
    Value = 0
  end
  object sEdit1: TsEdit
    Tag = 5
    Left = 105
    Top = 58
    Width = 130
    Height = 21
    TabOrder = 2
    Text = 'sEdit1'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'sEdit1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object sMaskEdit1: TsMaskEdit
    Tag = 5
    Left = 105
    Top = 88
    Width = 130
    Height = 20
    AutoSize = False
    TabOrder = 3
    Text = 'sMaskEdit1'
    BoundLabel.Active = True
    BoundLabel.Caption = 'sMaskEdit1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
  end
  object sRichEdit1: TsRichEdit
    Tag = 5
    Left = 106
    Top = 147
    Width = 131
    Height = 117
    Lines.Strings = (
      'sRichEdit1')
    ScrollBars = ssBoth
    TabOrder = 4
    WordWrap = False
    Text = 'sRichEdit1'#13#10
    BoundLabel.Active = True
    BoundLabel.Caption = 'sRichEdit1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
  end
  object sButton1: TsButton
    Tag = 5
    Left = 105
    Top = 272
    Width = 133
    Height = 25
    Caption = 'Load RTF'
    TabOrder = 5
    OnClick = sButton1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sTreeView1: TsTreeView
    Tag = 5
    Left = 245
    Top = 156
    Width = 228
    Height = 141
    HideSelection = False
    Indent = 19
    TabOrder = 6
    Items.Data = {
      090000001F0000000300000000000000FFFFFFFFFFFFFFFF0000000003000000
      064974656D2031200000000300000000000000FFFFFFFFFFFFFFFF0000000000
      000000074974656D203131200000000300000000000000FFFFFFFFFFFFFFFF00
      00000000000000074974656D203132200000000300000000000000FFFFFFFFFF
      FFFFFF0000000004000000074974656D203133210000000300000000000000FF
      FFFFFFFFFFFFFF0000000000000000084974656D203133312100000003000000
      00000000FFFFFFFFFFFFFFFF0000000000000000084974656D20313332210000
      000300000000000000FFFFFFFFFFFFFFFF0000000000000000084974656D2031
      3333210000000300000000000000FFFFFFFFFFFFFFFF00000000040000000849
      74656D20313334220000000300000000000000FFFFFFFFFFFFFFFF0000000000
      000000094974656D2031333431220000000300000000000000FFFFFFFFFFFFFF
      FF0000000000000000094974656D2031333432220000000300000000000000FF
      FFFFFFFFFFFFFF0000000000000000094974656D203133343322000000030000
      0000000000FFFFFFFFFFFFFFFF0000000004000000094974656D203133343423
      0000000300000000000000FFFFFFFFFFFFFFFF00000000000000000A4974656D
      203133343431230000000300000000000000FFFFFFFFFFFFFFFF000000000000
      00000A4974656D203133343432230000000300000000000000FFFFFFFFFFFFFF
      FF00000000000000000A4974656D203133343433230000000300000000000000
      FFFFFFFFFFFFFFFF00000000000000000A4974656D2031333434341F00000003
      00000000000000FFFFFFFFFFFFFFFF0000000000000000064974656D20321F00
      00000300000000000000FFFFFFFFFFFFFFFF0000000004000000064974656D20
      33200000000300000000000000FFFFFFFFFFFFFFFF0000000000000000074974
      656D203331200000000300000000000000FFFFFFFFFFFFFFFF00000000000000
      00074974656D203332200000000300000000000000FFFFFFFFFFFFFFFF000000
      0000000000074974656D203333200000000300000000000000FFFFFFFFFFFFFF
      FF0000000000000000074974656D2033341F0000000300000000000000FFFFFF
      FFFFFFFFFF0000000000000000064974656D20341F0000000300000000000000
      FFFFFFFFFFFFFFFF0000000000000000064974656D20351F0000000300000000
      000000FFFFFFFFFFFFFFFF0000000000000000064974656D20361F0000000300
      000000000000FFFFFFFFFFFFFFFF0000000000000000064974656D20371F0000
      000300000000000000FFFFFFFFFFFFFFFF0000000000000000064974656D2038
      1F0000000300000000000000FFFFFFFFFFFFFFFF000000000000000006497465
      6D2039}
    BoundLabel.Active = True
    BoundLabel.Caption = 'sTreeView1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclTopLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
  end
  object sTimePicker1: TsTimePicker
    Tag = 5
    Left = 106
    Top = 117
    Width = 130
    Height = 21
    TabOrder = 7
    Text = '00:00:00'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'sTimePicker1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object sDateEdit1: TsDateEdit
    Tag = 5
    Left = 124
    Top = 332
    Width = 131
    Height = 21
    AutoSize = False
    EditMask = '!99/99/9999;1; '
    MaxLength = 10
    TabOrder = 8
    Text = '  .  .    '
    BoundLabel.Active = True
    BoundLabel.Caption = 'sDateEdit1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
    CheckOnExit = True
  end
  object sCalcEdit1: TsCalcEdit
    Tag = 5
    Left = 342
    Top = 332
    Width = 131
    Height = 21
    AutoSize = False
    TabOrder = 9
    BoundLabel.Active = True
    BoundLabel.Caption = 'sCalcEdit1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
  end
  object sComboEdit1: TsComboEdit
    Tag = 5
    Left = 124
    Top = 362
    Width = 131
    Height = 21
    AutoSize = False
    TabOrder = 10
    Text = 'sComboEdit1'
    BoundLabel.Active = True
    BoundLabel.Caption = 'sComboEdit1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
  end
  object sCurrencyEdit1: TsCurrencyEdit
    Tag = 5
    Left = 342
    Top = 362
    Width = 131
    Height = 21
    AutoSize = False
    TabOrder = 11
    BoundLabel.Active = True
    BoundLabel.Caption = 'sCurrencyEdit1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
  end
  object sFilenameEdit1: TsFilenameEdit
    Tag = 5
    Left = 124
    Top = 392
    Width = 131
    Height = 21
    AutoSize = False
    MaxLength = 255
    TabOrder = 12
    Text = 'sFilenameEdit1'
    BoundLabel.Active = True
    BoundLabel.Caption = 'sFilenameEdit1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
  end
  object sDirectoryEdit1: TsDirectoryEdit
    Tag = 5
    Left = 342
    Top = 392
    Width = 131
    Height = 21
    AutoSize = False
    MaxLength = 255
    TabOrder = 13
    Text = 'sDirectoryEdit1'
    BoundLabel.Active = True
    BoundLabel.Caption = 'sDirectoryEdit1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
    Root = 'rfDesktop'
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 15
    Top = 13
  end
  object sOpenDialog1: TOpenDialog
    Filter = 'RTF files|*.RTF'
    Left = 416
    Top = 328
  end
end
