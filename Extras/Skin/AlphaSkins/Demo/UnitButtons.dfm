object FrameButtons: TFrameButtons
  Left = 0
  Top = 0
  Width = 602
  Height = 440
  TabOrder = 0
  object sLabel5: TsLabel
    Tag = 5
    Left = 369
    Top = 171
    Width = 62
    Height = 13
    Caption = 'HUE offset : '
  end
  object sLabel6: TsLabel
    Tag = 5
    Left = 538
    Top = 171
    Width = 6
    Height = 13
    Caption = '0'
  end
  object sLabel7: TsLabel
    Tag = 5
    Left = 19
    Top = 372
    Width = 186
    Height = 26
    Alignment = taRightJustify
    Caption = 
      'Buttons with SkinData.SkinSection'#13'property changed to '#39'BUTTON_HU' +
      'GE'#39' :'
  end
  object sBitBtn3: TsBitBtn
    Tag = 5
    Left = 427
    Top = 355
    Width = 146
    Height = 64
    Caption = 'Exit'
    TabOrder = 0
    OnClick = sBitBtn3Click
    SkinData.SkinSection = 'BUTTON_HUGE'
    ImageIndex = 4
    Images = MainForm.ImageList32
    Reflected = True
  end
  object sComboBox2: TsComboBox
    Tag = 5
    Left = 436
    Top = 80
    Width = 137
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'Parent controls SkinData.SkinSection property value :'
    BoundLabel.Indent = 2
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
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 15
    ItemIndex = 3
    ParentFont = False
    TabOrder = 1
    Text = 'PANEL'
    OnChange = sComboBox2Change
    Items.Strings = (
      'BUTTON_BIG'
      'CHECKBOX'
      'PANEL_LOW'
      'PANEL'
      'BUTTON'
      'SPEEDBUTTON'
      'GROUPBOX'
      'BAR'
      'DRAGBAR'
      'PROGRESSH'
      'TOOLBAR'
      'GRIPH')
  end
  object sBitBtn8: TsBitBtn
    Tag = 5
    Left = 289
    Top = 355
    Width = 64
    Height = 64
    TabOrder = 2
    NumGlyphs = 2
    SkinData.SkinSection = 'BUTTON_HUGE'
    ImageIndex = 1
    Images = MainForm.ImgList_MultiState
    Reflected = True
    ShowCaption = False
  end
  object sGroupBox2: TsGroupBox
    Tag = 5
    Left = 352
    Top = 199
    Width = 221
    Height = 118
    Caption = ' Glyphs : '
    TabOrder = 3
    SkinData.SkinSection = 'GROUPBOX'
    object sLabel1: TsLabel
      Tag = 5
      Left = 17
      Top = 57
      Width = 50
      Height = 13
      Caption = 'Blending : '
    end
    object sLabel2: TsLabel
      Tag = 5
      Left = 173
      Top = 57
      Width = 6
      Height = 13
      Caption = '0'
    end
    object sLabel3: TsLabel
      Tag = 5
      Left = 173
      Top = 26
      Width = 12
      Height = 13
      Caption = '32'
    end
    object sLabel4: TsLabel
      Tag = 5
      Left = 39
      Top = 26
      Width = 29
      Height = 13
      Caption = 'Size : '
    end
    object sCheckBox1: TsCheckBox
      Tag = 5
      Left = 36
      Top = 86
      Width = 55
      Height = 20
      Caption = 'Grayed'
      TabOrder = 0
      OnClick = sCheckBox1Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sTrackBar1: TsTrackBar
      Tag = 5
      Left = 64
      Top = 52
      Width = 109
      Height = 25
      Max = 100
      TabOrder = 1
      OnChange = sTrackBar1Change
      SkinData.SkinSection = 'TRACKBAR'
      BarOffsetV = 0
      BarOffsetH = 0
    end
    object sCheckBox2: TsCheckBox
      Tag = 5
      Left = 120
      Top = 86
      Width = 66
      Height = 20
      Caption = 'Reflected'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = sCheckBox2Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sTrackBar2: TsTrackBar
      Tag = 5
      Left = 64
      Top = 22
      Width = 109
      Height = 25
      Max = 32
      Min = 16
      Position = 32
      TabOrder = 3
      OnChange = sTrackBar2Change
      SkinData.SkinSection = 'TRACKBAR'
      BarOffsetV = 0
      BarOffsetH = 0
    end
  end
  object sBitBtn4: TsBitBtn
    Tag = 5
    Left = 358
    Top = 355
    Width = 64
    Height = 64
    TabOrder = 4
    NumGlyphs = 2
    SkinData.SkinSection = 'BUTTON_HUGE'
    ImageIndex = 2
    Images = MainForm.ImgList_MultiState
    Reflected = True
    ShowCaption = False
  end
  object sPanel2: TsPanel
    Left = 4
    Top = 112
    Width = 341
    Height = 205
    BevelOuter = bvLowered
    TabOrder = 5
    SkinData.SkinSection = 'PANEL_LOW'
    object sSpeedButton1: TsSpeedButton
      Tag = 5
      Left = 264
      Top = 12
      Width = 66
      Height = 45
      Flat = True
      Layout = blGlyphTop
      NumGlyphs = 2
      Spacing = 0
      SkinData.SkinSection = 'SPEEDBUTTON'
      DisabledGlyphKind = []
      ImageIndex = 0
      Images = MainForm.ImgList_MultiState
      Reflected = True
      ShowCaption = False
      TextAlignment = taLeftJustify
    end
    object sSpeedButton2: TsSpeedButton
      Tag = 5
      Left = 264
      Top = 62
      Width = 66
      Height = 45
      Flat = True
      Layout = blGlyphTop
      NumGlyphs = 2
      Spacing = 0
      ButtonStyle = tbsDropDown
      SkinData.SkinSection = 'SPEEDBUTTON'
      DisabledGlyphKind = []
      DropdownMenu = PopupMenu1
      ImageIndex = 1
      Images = MainForm.ImgList_MultiState
      Reflected = True
      ShowCaption = False
      TextAlignment = taLeftJustify
    end
    object sBitBtn1: TsBitBtn
      Tag = 5
      Left = 12
      Top = 116
      Width = 100
      Height = 43
      Caption = 'Default'#13#10'button'
      Default = True
      TabOrder = 0
      NumGlyphs = 2
      Spacing = 5
      SkinData.SkinSection = 'BUTTON'
      DisabledGlyphKind = []
      ImageIndex = 0
      Images = MainForm.ImgList_MultiState
      Reflected = True
      ShowFocus = False
    end
    object sButton1: TsButton
      Tag = 5
      Left = 12
      Top = 12
      Width = 242
      Height = 96
      Caption = 'bsCommandLink style'
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      CommandLinkHint = 
        'This style is supported in TsButton in all Delphi and Windows ve' +
        'rsions'
      DisabledImageIndex = 2
      HotImageIndex = 1
      Images = MainForm.ImageList32
      ImageIndex = 0
      ImageMargins.Left = 2
      ImageMargins.Right = 2
      PressedImageIndex = 3
      SelectedImageIndex = 4
      ContentMargin = 14
      Style = bsCommandLink
      Reflected = True
    end
    object sBitBtn2: TsBitBtn
      Tag = 5
      Left = 121
      Top = 116
      Width = 100
      Height = 43
      Caption = 'BitBtn'
      TabOrder = 2
      NumGlyphs = 2
      Spacing = 5
      SkinData.SkinSection = 'BUTTON'
      DisabledGlyphKind = []
      ImageIndex = 1
      Images = MainForm.ImgList_MultiState
      Reflected = True
      ShowFocus = False
    end
    object sBitBtn5: TsBitBtn
      Tag = 5
      Left = 230
      Top = 116
      Width = 100
      Height = 43
      Caption = 'sBitBtn'
      TabOrder = 3
      NumGlyphs = 2
      Spacing = 5
      SkinData.SkinSection = 'BUTTON'
      DisabledGlyphKind = []
      ImageIndex = 2
      Images = MainForm.ImgList_MultiState
      Reflected = True
      ShowFocus = False
    end
  end
  object sBitBtn6: TsBitBtn
    Tag = 5
    Left = 220
    Top = 355
    Width = 64
    Height = 64
    TabOrder = 6
    NumGlyphs = 2
    SkinData.SkinSection = 'BUTTON_HUGE'
    ImageIndex = 0
    Images = MainForm.ImgList_MultiState
    Reflected = True
    ShowCaption = False
  end
  object sComboBox4: TsComboBox
    Tag = 5
    Left = 436
    Top = 139
    Width = 137
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'SkinSection :'
    BoundLabel.Indent = 2
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
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 15
    ItemIndex = 4
    ParentFont = False
    TabOrder = 7
    Text = 'BUTTON'
    OnChange = sComboBox4Change
    Items.Strings = (
      'TOOLBUTTON'
      'BUTTON_BIG'
      'BUTTON_HUGE'
      'CHECKBOX'
      'BUTTON'
      'SPEEDBUTTON'
      'SPEEDBUTTON_SMALL'
      'WEBBUTTON')
  end
  object sCoolBar1: TsCoolBar
    Left = 0
    Top = 0
    Width = 573
    Height = 75
    Align = alNone
    BandBorderStyle = bsNone
    Bands = <
      item
        Control = sToolBar1
        ImageIndex = -1
        MinHeight = 36
        Width = 121
      end
      item
        Break = False
        Control = sToolBar2
        ImageIndex = -1
        MinHeight = 36
        Width = 436
      end>
    BorderWidth = 4
    EdgeBorders = []
    SkinData.SkinSection = 'TOOLBAR'
    object sToolBar2: TsToolBar
      Left = 130
      Top = 0
      Width = 423
      Height = 36
      Align = alNone
      ButtonHeight = 34
      ButtonWidth = 34
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = MainForm.ImageList24
      TabOrder = 0
      Transparent = True
      SkinData.SkinSection = 'CHECKBOX'
      object ToolButton1: TToolButton
        Tag = 5
        Left = 0
        Top = 2
        ImageIndex = 3
      end
      object ToolButton4: TToolButton
        Tag = 5
        Left = 34
        Top = 2
        DropdownMenu = PopupMenu1
        ImageIndex = 2
        Style = tbsDropDown
      end
      object ToolButton5: TToolButton
        Left = 83
        Top = 2
        Width = 8
        ImageIndex = 4
        Style = tbsDivider
      end
      object ToolButton8: TToolButton
        Tag = 5
        Left = 91
        Top = 2
        Grouped = True
        ImageIndex = 0
        Style = tbsCheck
      end
      object ToolButton6: TToolButton
        Tag = 5
        Left = 125
        Top = 2
        Grouped = True
        ImageIndex = 1
        Style = tbsCheck
      end
      object ToolButton7: TToolButton
        Tag = 5
        Left = 159
        Top = 2
        Grouped = True
        ImageIndex = 4
        Style = tbsCheck
      end
    end
    object sToolBar1: TsToolBar
      Left = 9
      Top = 0
      Width = 108
      Height = 36
      Align = alNone
      ButtonHeight = 34
      ButtonWidth = 34
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = MainForm.ImageList24
      TabOrder = 1
      Transparent = True
      SkinData.SkinSection = 'CHECKBOX'
      object ToolButton2: TToolButton
        Tag = 5
        Left = 0
        Top = 2
        ImageIndex = 6
      end
      object ToolButton10: TToolButton
        Tag = 5
        Left = 34
        Top = 2
        ImageIndex = 5
      end
      object ToolButton12: TToolButton
        Tag = 5
        Left = 68
        Top = 2
        ImageIndex = 4
      end
    end
  end
  object sTrackBar3: TsTrackBar
    Tag = 5
    Left = 428
    Top = 164
    Width = 109
    Height = 29
    Max = 360
    Frequency = 10
    TabOrder = 9
    TickStyle = tsNone
    OnChange = sTrackBar3Change
    SkinData.SkinSection = 'TRACKBAR'
    BarOffsetV = 0
    BarOffsetH = 0
  end
  object sCheckBox3: TsCheckBox
    Left = 1
    Top = 80
    Width = 38
    Height = 20
    Caption = 'Flat'
    Checked = True
    State = cbChecked
    TabOrder = 10
    OnClick = sCheckBox3Click
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 533
    Top = 94
  end
  object PopupMenu1: TPopupMenu
    OwnerDraw = True
    Left = 505
    Top = 94
    object Item11: TMenuItem
      Caption = 'Item 1'
    end
    object Item21: TMenuItem
      Caption = 'Item 2'
    end
    object Item31: TMenuItem
      Caption = 'Item 3'
    end
    object Item41: TMenuItem
      Caption = 'Item 4'
      object Subitem411: TMenuItem
        Caption = 'Subitem 41'
      end
      object Subitem421: TMenuItem
        Caption = 'Subitem 42'
      end
      object Subitem431: TMenuItem
        Caption = 'Subitem 43'
      end
      object Subitem441: TMenuItem
        Caption = 'Subitem 44'
      end
      object Subitem451: TMenuItem
        Caption = 'Subitem 45'
      end
      object Subitem461: TMenuItem
        Caption = 'Subitem 46'
      end
      object Subitem471: TMenuItem
        Caption = 'Subitem 47'
      end
    end
  end
end
