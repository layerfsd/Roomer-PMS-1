object FrameForms: TFrameForms
  Left = 0
  Top = 0
  Width = 535
  Height = 395
  TabOrder = 0
  object sGroupBox7: TsGroupBox
    Left = 23
    Top = 16
    Width = 125
    Height = 165
    Caption = 'Border style'
    TabOrder = 0
    CaptionLayout = clTopCenter
    SkinData.SkinSection = 'GROUPBOX'
    object sRadioButton12: TsRadioButton
      Tag = 5
      Left = 14
      Top = 25
      Width = 60
      Height = 20
      Caption = 'bsDialog'
      TabOrder = 0
      OnClick = sRadioButton12Click
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton13: TsRadioButton
      Tag = 5
      Left = 14
      Top = 47
      Width = 56
      Height = 20
      Caption = 'bsNone'
      TabOrder = 1
      OnClick = sRadioButton12Click
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton14: TsRadioButton
      Tag = 5
      Left = 14
      Top = 69
      Width = 59
      Height = 20
      Caption = 'bsSingle'
      TabOrder = 2
      OnClick = sRadioButton12Click
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton15: TsRadioButton
      Tag = 5
      Left = 14
      Top = 91
      Width = 70
      Height = 20
      Caption = 'bsSizeable'
      Checked = True
      TabOrder = 3
      TabStop = True
      OnClick = sRadioButton12Click
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton16: TsRadioButton
      Tag = 5
      Left = 14
      Top = 113
      Width = 88
      Height = 20
      Caption = 'bsSizeToolWin'
      TabOrder = 4
      OnClick = sRadioButton12Click
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton17: TsRadioButton
      Tag = 5
      Left = 14
      Top = 135
      Width = 89
      Height = 20
      Caption = 'bsToolWindow'
      TabOrder = 5
      OnClick = sRadioButton12Click
      SkinData.SkinSection = 'RADIOBUTTON'
    end
  end
  object sButton1: TsButton
    Tag = 5
    Left = 256
    Top = 228
    Width = 169
    Height = 30
    Caption = 'Open'
    TabOrder = 1
    OnClick = sButton1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sGroupBox8: TsGroupBox
    Left = 23
    Top = 186
    Width = 125
    Height = 127
    Caption = 'Border icons'
    TabOrder = 2
    CaptionLayout = clTopCenter
    SkinData.SkinSection = 'GROUPBOX'
    object sCheckBox9: TsCheckBox
      Tag = 5
      Left = 13
      Top = 28
      Width = 89
      Height = 20
      Caption = 'biSystemMenu'
      Checked = True
      State = cbChecked
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sCheckBox15: TsCheckBox
      Tag = 5
      Left = 13
      Top = 50
      Width = 71
      Height = 20
      Caption = 'biMaximize'
      Checked = True
      State = cbChecked
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sCheckBox16: TsCheckBox
      Tag = 5
      Left = 13
      Top = 72
      Width = 67
      Height = 20
      Caption = 'biMinimize'
      Checked = True
      State = cbChecked
      TabOrder = 2
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sCheckBox17: TsCheckBox
      Tag = 5
      Left = 13
      Top = 94
      Width = 49
      Height = 20
      Caption = 'biHelp'
      Checked = True
      State = cbChecked
      TabOrder = 3
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object sGroupBox9: TsGroupBox
    Left = 157
    Top = 16
    Width = 116
    Height = 105
    Caption = 'Caption alignment'
    TabOrder = 3
    SkinData.SkinSection = 'GROUPBOX'
    object sRadioButton18: TsRadioButton
      Tag = 5
      Left = 14
      Top = 24
      Width = 81
      Height = 20
      Caption = 'taLeftJustify'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = sRadioButton18Change
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton19: TsRadioButton
      Tag = 5
      Left = 14
      Top = 46
      Width = 63
      Height = 20
      Caption = 'taCenter'
      TabOrder = 1
      OnClick = sRadioButton19Change
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton20: TsRadioButton
      Tag = 5
      Left = 14
      Top = 68
      Width = 87
      Height = 20
      Caption = 'taRightJustify'
      TabOrder = 2
      OnClick = sRadioButton20Change
      SkinData.SkinSection = 'RADIOBUTTON'
    end
  end
  object sCheckBox19: TsCheckBox
    Tag = 5
    Left = 289
    Top = 68
    Width = 89
    Height = 20
    Caption = 'Show app icon'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = sCheckBox19Change
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sCheckBox20: TsCheckBox
    Tag = 5
    Left = 289
    Top = 46
    Width = 67
    Height = 20
    Caption = 'Show grip'
    Checked = True
    State = cbChecked
    TabOrder = 5
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sEdit2: TsEdit
    Tag = 5
    Left = 255
    Top = 148
    Width = 173
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = 'Test form with custom title'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Caption text'
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
  object sSpinEdit4: TsSpinEdit
    Tag = 5
    Left = 384
    Top = 202
    Width = 44
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Text = '3'
    Visible = False
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Count of user buttons in title'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    MaxValue = 8
    MinValue = 0
    Value = 3
  end
  object sCheckBox1: TsCheckBox
    Tag = 5
    Left = 289
    Top = 23
    Width = 109
    Height = 20
    Caption = 'Resize border only'
    TabOrder = 10
    OnClick = sCheckBox1Change
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sComboBox1: TsComboBox
    Tag = 5
    Left = 255
    Top = 177
    Width = 174
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'Skinsection name'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'COMBOBOX'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 15
    ItemIndex = -1
    ParentFont = False
    TabOrder = 8
    Text = 'DIALOG'
    Items.Strings = (
      'FORM'
      'DIALOG'
      'BUTTON'
      'PAGECONTROL')
  end
  object sCheckBox2: TsCheckBox
    Tag = 5
    Left = 289
    Top = 88
    Width = 162
    Height = 20
    Caption = 'Make menu for skins choosing'
    Checked = True
    State = cbChecked
    TabOrder = 9
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sCheckBox3: TsCheckBox
    Tag = 5
    Left = 257
    Top = 279
    Width = 86
    Height = 20
    Caption = 'Allow skinning'
    Checked = True
    State = cbChecked
    TabOrder = 11
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 39
    Top = 6
  end
end
