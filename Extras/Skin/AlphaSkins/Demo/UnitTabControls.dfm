object FrameTabControls: TFrameTabControls
  Left = 0
  Top = 0
  Width = 620
  Height = 440
  AutoScroll = False
  TabOrder = 0
  object sPageControl1: TsPageControl
    Left = 11
    Top = 12
    Width = 422
    Height = 325
    ActivePage = sTabSheet1
    HotTrack = True
    Images = MainForm.ImageList16
    TabHeight = 28
    TabOrder = 0
    OnChange = sPageControl1Change
    ActiveIsBold = True
    ShowCloseBtns = True
    SkinData.SkinSection = 'PAGECONTROL'
    OnCloseBtnClick = sPageControl1CloseBtnClick
    object sTabSheet1: TsTabSheet
      Caption = '1'
      ImageIndex = 1
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      SkinData.SkinSection = 'TABSHEET'
      UseCloseBtn = False
      object sPageControl2: TsPageControl
        Left = 36
        Top = 36
        Width = 353
        Height = 209
        ActivePage = sTabSheet8
        HotTrack = True
        Images = MainForm.ImageList24
        TabHeight = 140
        TabOrder = 0
        TabWidth = 27
        ActiveIsBold = True
        RotateCaptions = True
        ShowCloseBtns = True
        SkinData.SkinSection = 'PAGECONTROL'
        object sTabSheet8: TsTabSheet
          Caption = 'sTabSheet8'
          SkinData.CustomColor = False
          SkinData.CustomFont = False
        end
        object sTabSheet9: TsTabSheet
          Caption = 'sTabSheet9'
          ImageIndex = 1
          SkinData.CustomColor = False
          SkinData.CustomFont = False
        end
        object sTabSheet10: TsTabSheet
          Caption = 'sTabSheet10'
          ImageIndex = 4
          SkinData.CustomColor = False
          SkinData.CustomFont = False
        end
        object sTabSheet11: TsTabSheet
          Caption = 'sTabSheet11'
          ImageIndex = 5
          SkinData.CustomColor = False
          SkinData.CustomFont = False
        end
      end
      object sCheckBox17: TsCheckBox
        Left = 40
        Top = 252
        Width = 95
        Height = 20
        Caption = 'RotateCaptions'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = sCheckBox17Click
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object sTabSheet2: TsTabSheet
      Caption = '+'
      ImageIndex = -1
      TabType = ttButton
      TabSkin = 'SPEEDBUTTON'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      SkinData.SkinSection = 'TABSHEET'
      UseCloseBtn = False
      OnClickBtn = sTabSheet2ClickBtn
      object sPageControl3: TsPageControl
        Left = 68
        Top = 60
        Width = 325
        Height = 205
        ActivePage = sTabSheet12
        HotTrack = True
        Images = MainForm.ImageList16
        TabOrder = 0
        ShowCloseBtns = True
        SkinData.SkinSection = 'PAGECONTROL'
        object sTabSheet12: TsTabSheet
          Caption = '1'
          SkinData.CustomColor = False
          SkinData.CustomFont = False
        end
        object sTabSheet13: TsTabSheet
          Caption = '+'
          ImageIndex = 8
          TabType = ttButton
          TabSkin = 'SPEEDBUTTON'
          SkinData.CustomColor = False
          SkinData.CustomFont = False
        end
      end
    end
  end
  object sRadioButton1: TsRadioButton
    Left = 24
    Top = 360
    Width = 52
    Height = 20
    Caption = 'tsTabs'
    Checked = True
    TabOrder = 1
    TabStop = True
    OnClick = sRadioButton1Click
    SkinData.SkinSection = 'RADIOBUTTON'
  end
  object sRadioButton2: TsRadioButton
    Left = 108
    Top = 360
    Width = 66
    Height = 20
    Caption = 'tsButtons'
    TabOrder = 2
    OnClick = sRadioButton2Click
    SkinData.SkinSection = 'RADIOBUTTON'
  end
  object sRadioButton3: TsRadioButton
    Left = 204
    Top = 360
    Width = 84
    Height = 20
    Caption = 'tsFlatButtons'
    TabOrder = 3
    OnClick = sRadioButton3Click
    SkinData.SkinSection = 'RADIOBUTTON'
  end
  object sComboBox1: TsComboBox
    Left = 448
    Top = 150
    Width = 153
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'SkinSection'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclTopLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'COMBOBOX'
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 15
    ItemIndex = -1
    ParentFont = False
    TabOrder = 4
    OnChange = sComboBox1Change
    Items.Strings = (
      'CHECKBOX'
      'PAGECONTROL'
      'PANEL'
      'PANEL_LOW'
      'GROUPBOX'
      'TOOLBAR'
      'BARPANEL')
  end
  object sCheckBox15: TsCheckBox
    Left = 452
    Top = 176
    Width = 115
    Height = 20
    Caption = 'Show Close buttons'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = sCheckBox15Click
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sCheckBox8: TsCheckBox
    Tag = 5
    Left = 452
    Top = 201
    Width = 58
    Height = 20
    Caption = 'Multiline'
    TabOrder = 6
    OnClick = sCheckBox8Change
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sGroupBox5: TsGroupBox
    Left = 448
    Top = 38
    Width = 153
    Height = 87
    Caption = 'Tabs position'
    TabOrder = 7
    SkinData.SkinSection = 'GROUPBOX'
    object sRadioButton6: TsRadioButton
      Tag = 5
      Left = 22
      Top = 25
      Width = 38
      Height = 20
      Caption = 'Top'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = sRadioButton6Change
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton7: TsRadioButton
      Tag = 5
      Left = 22
      Top = 51
      Width = 54
      Height = 20
      Caption = 'Bottom'
      TabOrder = 1
      OnClick = sRadioButton7Change
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton8: TsRadioButton
      Tag = 5
      Left = 90
      Top = 25
      Width = 39
      Height = 20
      Caption = 'Left'
      TabOrder = 2
      OnClick = sRadioButton8Change
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton9: TsRadioButton
      Tag = 5
      Left = 90
      Top = 51
      Width = 45
      Height = 20
      Caption = 'Right'
      TabOrder = 3
      OnClick = sRadioButton9Change
      SkinData.SkinSection = 'RADIOBUTTON'
    end
  end
  object sCheckBox1: TsCheckBox
    Left = 452
    Top = 226
    Width = 83
    Height = 20
    Caption = 'Active is Bold'
    Checked = True
    State = cbChecked
    TabOrder = 8
    OnClick = sCheckBox1Click
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sCheckBox2: TsCheckBox
    Left = 452
    Top = 252
    Width = 84
    Height = 20
    Caption = 'Disabled tabs'
    TabOrder = 9
    OnClick = sCheckBox2Click
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 351
    Top = 82
  end
end
