object FrameBar: TFrameBar
  Left = 0
  Top = 0
  Width = 566
  Height = 426
  TabOrder = 0
  object BarSpeedButton: TsSpeedButton
    Left = 197
    Top = 0
    Width = 10
    Height = 426
    Caption = '<'#13#10'<'#13#10'<'#13#10'<'#13#10'<'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = sSpeedButton2Click
    Align = alLeft
    OnMouseEnter = sSpeedButton2MouseEnter
    SkinData.SkinSection = 'SPLITTER'
  end
  object sFrameBar1: TsFrameBar
    Tag = 5
    Left = 0
    Top = 0
    Width = 197
    Height = 426
    HorzScrollBar.Range = 185
    HorzScrollBar.Visible = False
    VertScrollBar.Increment = 22
    VertScrollBar.Range = 458
    VertScrollBar.Tracking = True
    OnMouseLeave = sFrameBar1MouseLeave
    AutoMouseWheel = True
    AutoScroll = False
    TabOrder = 0
    SkinData.SkinSection = 'BAR'
    BorderWidth = 6
    AutoFrameSize = False
    Images = MainForm.ImageList16
    Items = <
      item
        Caption = 'Title button 1'
        Cursor = crDefault
        ImageIndex = 0
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 2'
        Cursor = crDefault
        ImageIndex = 1
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 3'
        Cursor = crDefault
        ImageIndex = 2
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 4'
        Cursor = crDefault
        ImageIndex = 3
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 5'
        Cursor = crDefault
        ImageIndex = 0
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 6'
        Cursor = crDefault
        ImageIndex = 1
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 7'
        Cursor = crDefault
        ImageIndex = 2
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 8'
        Cursor = crDefault
        ImageIndex = 3
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 9'
        Cursor = crDefault
        ImageIndex = 0
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 10'
        Cursor = crDefault
        ImageIndex = 1
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 11'
        Cursor = crDefault
        ImageIndex = 2
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 12'
        Cursor = crDefault
        ImageIndex = 3
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end
      item
        Caption = 'Title button 13'
        Cursor = crDefault
        ImageIndex = 0
        SkinSection = 'BARTITLE'
        OnCreateFrame = sFrameBar1Items0CreateFrame
      end>
    Spacing = 0
    ActiveFrameIndex = -1
  end
  object sPanel1: TsPanel
    Left = 207
    Top = 0
    Width = 359
    Height = 426
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    object sLabel1: TsLabel
      Tag = 5
      Left = 27
      Top = 146
      Width = 61
      Height = 13
      Caption = 'Border width'
    end
    object sLabel2: TsLabel
      Tag = 5
      Left = 33
      Top = 171
      Width = 53
      Height = 13
      Caption = 'Title height'
    end
    object sSpeedButton1: TsSpeedButton
      Tag = 5
      Left = 38
      Top = 80
      Width = 186
      Height = 22
      AllowAllUp = True
      GroupIndex = 1
      Down = True
      Caption = 'Animation enabled'
      OnClick = sSpeedButton1Click
      SkinData.SkinSection = 'SPEEDBUTTON'
    end
    object sTrackBar1: TsTrackBar
      Tag = 5
      Left = 96
      Top = 141
      Width = 132
      Height = 26
      Position = 6
      TabOrder = 0
      OnChange = sTrackBar1Change
      SkinData.SkinSection = 'TRACKBAR'
      BarOffsetV = 0
      BarOffsetH = 0
    end
    object sTrackBar2: TsTrackBar
      Tag = 5
      Left = 96
      Top = 167
      Width = 132
      Height = 26
      Max = 64
      Min = 18
      Position = 28
      TabOrder = 1
      OnChange = sTrackBar2Change
      SkinData.SkinSection = 'TRACKBAR'
      BarOffsetV = 0
      BarOffsetH = 0
    end
    object sGroupBox1: TsGroupBox
      Left = 26
      Top = 200
      Width = 210
      Height = 117
      Caption = 'SkinSections'
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      object sComboBox1: TsComboBox
        Tag = 5
        Left = 88
        Top = 20
        Width = 110
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'General'
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'MS Sans Serif'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        DropDownCount = 8
        SkinData.SkinSection = 'COMBOBOX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 15
        ItemIndex = -1
        ParentFont = False
        TabOrder = 0
        OnChange = sComboBox1Change
        Items.Strings = (
          'BUTTON_BIG'
          'CHECKBOX'
          'PANEL_LOW'
          'PANEL'
          'BUTTON'
          'SPEEDBUTTON'
          'GROUPBOX'
          'DIALOG'
          'BAR'
          'FORM')
      end
      object sComboBox2: TsComboBox
        Tag = 5
        Left = 88
        Top = 52
        Width = 110
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'Title buttons'
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'MS Sans Serif'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        DropDownCount = 8
        SkinData.SkinSection = 'COMBOBOX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 15
        ItemIndex = -1
        ParentFont = False
        TabOrder = 1
        OnChange = sComboBox2Change
        Items.Strings = (
          'BUTTON_BIG'
          'MENUITEM'
          'PANEL_LOW'
          'PANEL'
          'BUTTON'
          'SPEEDBUTTON'
          'TOOLBUTTON'
          'BARTITLE'
          'FORM')
      end
      object sComboBox3: TsComboBox
        Tag = 5
        Left = 88
        Top = 84
        Width = 110
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'Frame'
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'MS Sans Serif'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        DropDownCount = 8
        SkinData.SkinSection = 'COMBOBOX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 15
        ItemIndex = -1
        ParentFont = False
        TabOrder = 2
        OnChange = sComboBox3Change
        Items.Strings = (
          'BUTTON_BIG'
          'CHECKBOX'
          'PANEL_LOW'
          'PANEL'
          'BUTTON'
          'SPEEDBUTTON'
          'TOOLBUTTON'
          'GROUPBOX'
          'DIALOG'
          'BARPANEL'
          'FORM')
      end
    end
    object sCheckBox1: TsCheckBox
      Left = 35
      Top = 112
      Width = 82
      Height = 20
      Caption = 'AllowAllClose'
      TabOrder = 3
      OnClick = sCheckBox1Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sCheckBox2: TsCheckBox
      Left = 139
      Top = 112
      Width = 82
      Height = 20
      Caption = 'AllowAllOpen'
      TabOrder = 4
      OnClick = sCheckBox2Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sGroupBox2: TsGroupBox
      Left = 26
      Top = 8
      Width = 210
      Height = 53
      Caption = 'AutoHide'
      TabOrder = 5
      SkinData.SkinSection = 'GROUPBOX'
      object sCheckBox3: TsCheckBox
        Left = 12
        Top = 20
        Width = 58
        Height = 20
        Caption = 'Enabled'
        TabOrder = 0
        OnClick = sCheckBox3Click
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object sButton1: TsButton
      Left = 26
      Top = 328
      Width = 210
      Height = 25
      Caption = 'Add new item'
      TabOrder = 6
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 15
    Top = 13
  end
end
