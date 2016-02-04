object FrameCheckBoxes: TFrameCheckBoxes
  Left = 0
  Top = 0
  Width = 539
  Height = 424
  TabOrder = 0
  object sGroupBox2: TsGroupBox
    Left = 39
    Top = 33
    Width = 173
    Height = 164
    Caption = 'RadioButtons'
    TabOrder = 0
    CaptionLayout = clTopCenter
    SkinData.SkinSection = 'GROUPBOX'
    object sRadioButton1: TsRadioButton
      Tag = 5
      Left = 24
      Top = 29
      Width = 90
      Height = 20
      Caption = 'sRadioButton1'
      Checked = True
      TabOrder = 0
      TabStop = True
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton2: TsRadioButton
      Tag = 5
      Left = 24
      Top = 58
      Width = 90
      Height = 20
      Caption = 'sRadioButton2'
      TabOrder = 1
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton3: TsRadioButton
      Tag = 5
      Left = 24
      Top = 88
      Width = 90
      Height = 20
      Caption = 'sRadioButton3'
      TabOrder = 2
      SkinData.SkinSection = 'RADIOBUTTON'
    end
    object sRadioButton5: TsRadioButton
      Tag = 5
      Left = 24
      Top = 111
      Width = 98
      Height = 32
      Caption = 'multiline sRadioButton5'
      TabOrder = 3
      WordWrap = True
      AutoSize = False
      SkinData.SkinSection = 'RADIOBUTTON'
    end
  end
  object sGroupBox6: TsGroupBox
    Left = 245
    Top = 33
    Width = 173
    Height = 164
    Caption = 'CheckBoxes'
    TabOrder = 1
    CaptionLayout = clTopCenter
    SkinData.SkinSection = 'GROUPBOX'
    object sCheckBox1: TsCheckBox
      Tag = 5
      Left = 28
      Top = 27
      Width = 78
      Height = 20
      Caption = 'sCheckBox1'
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sCheckBox2: TsCheckBox
      Tag = 5
      Left = 28
      Top = 58
      Width = 78
      Height = 20
      Caption = 'sCheckBox2'
      Checked = True
      State = cbChecked
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sCheckBox3: TsCheckBox
      Tag = 5
      Left = 28
      Top = 87
      Width = 108
      Height = 20
      Caption = 'With Grayed state'
      AllowGrayed = True
      State = cbGrayed
      TabOrder = 2
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sCheckBox5: TsCheckBox
      Tag = 5
      Left = 28
      Top = 111
      Width = 90
      Height = 33
      Caption = 'multiline sCheckBox5'
      AllowGrayed = True
      AutoSize = False
      TabOrder = 3
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
      WordWrap = True
    end
  end
  object sRadioGroup1: TsRadioGroup
    Tag = 5
    Left = 39
    Top = 248
    Width = 378
    Height = 105
    Caption = 'sRadioGroup1'
    ParentBackground = False
    TabOrder = 2
    SkinData.SkinSection = 'GROUPBOX'
    Columns = 4
    ItemIndex = 1
    Items.Strings = (
      'Item0'
      'Item1'
      'Item2'
      'Item3'
      'Item4'
      'Item5'
      'Item6'
      'Item7'
      'Item8'
      'Item9'
      'ItemA')
  end
  object sComboBox1: TsComboBox
    Tag = 5
    Left = 276
    Top = 210
    Width = 133
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'SkinSection property :'
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
    Style = csDropDownList
    ItemHeight = 15
    ItemIndex = -1
    TabOrder = 3
    OnChange = sComboBox1Change
    Items.Strings = (
      'CHECKBOX'
      'PANEL_LOW'
      'PANEL'
      'BUTTON'
      'SPEEDBUTTON'
      'GROUPBOX'
      'TOOLBUTTON'
      'MENUITEM')
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 9
    Top = 14
  end
end
