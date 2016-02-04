object FrameTest: TFrameTest
  Left = 0
  Top = 0
  Width = 203
  Height = 58
  TabOrder = 0
  object sComboBox1: TsComboBox
    Left = 82
    Top = 17
    Width = 105
    Height = 22
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'SkinSection :'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'ALPHACOMBOBOX'
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = -1
    TabOrder = 0
    OnChange = sComboBox1Change
    Items.Strings = (
      'PANEL'
      'GROUPBOX'
      'PANEL_LOW'
      'CHECKBOX'
      'BUTTON'
      'PROGRESSH')
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'GROUPBOX'
    Left = 4
    Top = 3
  end
end
