object FrameContact: TFrameContact
  Left = 0
  Top = 0
  Width = 135
  Height = 278
  AutoScroll = False
  TabOrder = 0
  DesignSize = (
    135
    278)
  object sSpeedButton1: TsSpeedButton
    Left = 25
    Top = 157
    Width = 86
    Height = 28
    Cursor = crHandPoint
    Anchors = [akLeft, akTop, akRight]
    Flat = True
    NumGlyphs = 2
    Blend = 50
    SkinData.SkinSection = 'WEBBUTTON'
    Images = MainForm.ImageList16
  end
  object sWebLabel1: TsWebLabel
    Left = 17
    Top = 253
    Width = 118
    Height = 11
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'support@alphaskins.com'
    ParentFont = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = 14692866
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    HoverFont.Charset = RUSSIAN_CHARSET
    HoverFont.Color = clBlue
    HoverFont.Height = -9
    HoverFont.Name = 'Small Fonts'
    HoverFont.Style = [fsUnderline]
    URL = 'mailto:support@alphaskins.com'
  end
  object sWebLabel2: TsWebLabel
    Left = 16
    Top = 237
    Width = 121
    Height = 11
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'http://www.alphaskins.com'
    ParentFont = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = 14692866
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    HoverFont.Charset = RUSSIAN_CHARSET
    HoverFont.Color = clBlue
    HoverFont.Height = -9
    HoverFont.Name = 'Small Fonts'
    HoverFont.Style = [fsUnderline]
    URL = 'http://www.alphaskins.com'
  end
  object sSpeedButton2: TsSpeedButton
    Left = 26
    Top = 187
    Width = 85
    Height = 28
    Cursor = crHandPoint
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Buy now!'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    OnClick = sSpeedButton2Click
    Blend = 25
    SkinData.CustomFont = True
    SkinData.SkinSection = 'WEBBUTTON'
    ImageIndex = 2
    Images = MainForm.ImgList_Multi16
  end
  object sPanel1: TsPanel
    Left = 12
    Top = 224
    Width = 112
    Height = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = ' '
    TabOrder = 0
    SkinData.SkinSection = 'PANEL_LOW'
  end
  object sGroupBox1: TsGroupBox
    Left = 8
    Top = 22
    Width = 123
    Height = 111
    Caption = ' Animation '
    TabOrder = 1
    SkinData.SkinSection = 'GROUPBOX'
    DesignSize = (
      123
      111)
    object sCheckBox1: TsCheckBox
      Left = 12
      Top = 19
      Width = 77
      Height = 20
      Cursor = crHandPoint
      Caption = 'MouseEnter'
      Anchors = [akLeft, akTop, akRight]
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = sCheckBox1Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
      ShowFocus = False
    end
    object sCheckBox2: TsCheckBox
      Left = 12
      Top = 40
      Width = 80
      Height = 20
      Cursor = crHandPoint
      Caption = 'MouseLeave'
      Anchors = [akLeft, akTop, akRight]
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = sCheckBox2Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
      ShowFocus = False
    end
    object sCheckBox3: TsCheckBox
      Left = 12
      Top = 61
      Width = 78
      Height = 20
      Cursor = crHandPoint
      Caption = 'MouseDown'
      Anchors = [akLeft, akTop, akRight]
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = sCheckBox3Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
      ShowFocus = False
    end
    object sCheckBox4: TsCheckBox
      Left = 12
      Top = 82
      Width = 64
      Height = 20
      Cursor = crHandPoint
      Caption = 'MouseUp'
      Anchors = [akLeft, akTop, akRight]
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = sCheckBox4Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
      ShowFocus = False
    end
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'BARPANEL'
    Left = 107
    Top = 114
  end
end
