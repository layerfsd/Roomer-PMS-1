object FrameEditorsAdd: TFrameEditorsAdd
  Left = 0
  Top = 0
  Width = 500
  Height = 468
  TabOrder = 0
  object sCheckListBox1: TsCheckListBox
    Tag = 5
    Left = 278
    Top = 31
    Width = 170
    Height = 215
    BorderStyle = bsSingle
    Columns = 2
    ItemHeight = 16
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
      'Item10'
      'Item11'
      'Item12'
      'Item13'
      'Item14'
      'Item15'
      'Item16'
      'Item17'
      'Item18'
      'Item19'
      'Item20'
      'Item21'
      'Item22'
      'Item23'
      'Item24'
      'Item25'
      'Item26'
      'Item27'
      'Item28'
      'Item29'
      'Item30'
      'Item31'
      'Item32'
      'Item33'
      'Item34'
      'Item35'
      'Item36'
      'Item37'
      'Item38'
      'Item39'
      'Item30')
    TabOrder = 0
    BoundLabel.Active = True
    BoundLabel.Caption = 'sCheckListBox1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclTopLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'ALPHAEDIT'
  end
  object sListBox1: TsListBox
    Tag = 5
    Left = 102
    Top = 121
    Width = 160
    Height = 126
    ItemHeight = 13
    Items.Strings = (
      'Item 0'
      'Item 1'
      'Item 2'
      'Item 3'
      'Item 4'
      'Item 5'
      'Item 6'
      'Item 7'
      'Item 8'
      'Item 9'
      'Item A'
      'Item B'
      'Item C'
      'Item D'
      'Item E'
      'Item F')
    TabOrder = 1
    BoundLabel.Active = True
    BoundLabel.Caption = 'sListBox1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'ALPHAEDIT'
  end
  object sColorBox1: TsColorBox
    Tag = 5
    Left = 102
    Top = 31
    Width = 160
    Height = 22
    BoundLabel.Active = True
    BoundLabel.Caption = 'sColorBox1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'ALPHACOMBOBOX'
    Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
    DropDownCount = 8
    ItemHeight = 16
    TabOrder = 2
  end
  object sComboBoxEx1: TsComboBoxEx
    Tag = 5
    Left = 102
    Top = 61
    Width = 160
    Height = 22
    BoundLabel.Active = True
    BoundLabel.Caption = 'sComboBoxEx1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'ALPHACOMBOBOX'
    ItemsEx = <
      item
        Caption = 'First item'
        ImageIndex = 0
        SelectedImageIndex = 0
      end
      item
        Caption = 'Second item'
        ImageIndex = 1
        Indent = 1
        SelectedImageIndex = 1
      end
      item
        Caption = 'Third item'
        ImageIndex = 2
        Indent = 2
        SelectedImageIndex = 2
      end>
    Style = csExDropDownList
    ItemIndex = -1
    ItemHeight = 16
    TabOrder = 3
    Images = MainForm.ImageList16
    DropDownCount = 180
  end
  object sComboBox1: TsComboBox
    Left = 278
    Top = 305
    Width = 170
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'SkinSection property : '
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'ALPHACOMBOBOX'
    Style = csDropDownList
    ItemHeight = 15
    ItemIndex = -1
    TabOrder = 4
    OnChange = sComboBox1Change
    Items.Strings = (
      'CHECKBOX'
      'GROUPBOX'
      'PANEL'
      'PANEL_LOW'
      'EDIT'
      'ALPHAEDIT'
      'ALPHACOMBOBOX'
      'HINT'
      'BAR'
      'MAINMENU')
  end
  object sCheckBox1: TsCheckBox
    Left = 104
    Top = 259
    Width = 105
    Height = 22
    Caption = 'AutoHideScroll'
    AutoSize = False
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = sCheckBox1Click
    Margin = 4
    SkinData.SkinSection = 'ALPHAEDIT'
    ImgChecked = 0
    ImgUnchecked = 0
    ShowFocus = False
  end
  object sFilterComboBox1: TsFilterComboBox
    Tag = 5
    Left = 102
    Top = 91
    Width = 160
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'sFilterComboBox1'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'ALPHACOMBOBOX'
    TabOrder = 6
  end
  object sCheckBox2: TsCheckBox
    Left = 284
    Top = 259
    Width = 70
    Height = 20
    Caption = 'Multiselect'
    TabOrder = 7
    OnClick = sCheckBox2Click
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 15
    Top = 13
  end
end
