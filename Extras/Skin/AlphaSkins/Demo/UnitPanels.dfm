object FramePanels: TFramePanels
  Left = 0
  Top = 0
  Width = 618
  Height = 440
  TabOrder = 0
  DesignSize = (
    618
    440)
  object sPanel5: TsPanel
    Left = 28
    Top = 16
    Width = 560
    Height = 42
    Anchors = [akLeft, akTop, akRight]
    Caption = ' '
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sButton1: TsButton
      Tag = 5
      Left = 12
      Top = 8
      Width = 75
      Height = 27
      Caption = 'Lowered'
      TabOrder = 0
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton2: TsButton
      Tag = 5
      Left = 92
      Top = 8
      Width = 75
      Height = 27
      Caption = 'Raised'
      TabOrder = 1
      OnClick = sButton2Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton3: TsButton
      Tag = 5
      Left = 172
      Top = 8
      Width = 75
      Height = 27
      Caption = 'Box'
      TabOrder = 2
      OnClick = sButton3Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sPanel1: TsPanel
    Left = 28
    Top = 75
    Width = 560
    Height = 350
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    object sSplitter3: TsSplitter
      Left = 269
      Top = 0
      Height = 350
      ResizeStyle = rsUpdate
      ShowGrip = True
      SkinData.SkinSection = 'SPLITTER'
    end
    object sContainer2: TsPanel
      Left = 275
      Top = 0
      Width = 285
      Height = 350
      Align = alClient
      BevelOuter = bvLowered
      BorderWidth = 8
      Caption = ' '
      TabOrder = 0
      SkinData.SkinSection = 'PANEL_LOW'
      object sSplitter1: TsSplitter
        Left = 9
        Top = 194
        Width = 267
        Height = 6
        Cursor = crVSplit
        Align = alBottom
        ResizeStyle = rsUpdate
        ShowGrip = True
        SkinData.SkinSection = 'SPLITTER'
      end
      object sSplitter2: TsSplitter
        Left = 83
        Top = 9
        Height = 185
        ResizeStyle = rsUpdate
        ShowGrip = True
        SkinData.SkinSection = 'SPLITTER'
      end
      object sPanel2: TsPanel
        Left = 9
        Top = 200
        Width = 267
        Height = 141
        Align = alBottom
        BorderWidth = 5
        Caption = ' '
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sPanel6: TsPanel
          Left = 6
          Top = 6
          Width = 255
          Height = 129
          Align = alClient
          BevelOuter = bvLowered
          BorderWidth = 5
          Caption = ' '
          TabOrder = 0
          SkinData.SkinSection = 'PANEL_LOW'
          object sPanel7: TsPanel
            Left = 6
            Top = 6
            Width = 243
            Height = 117
            Align = alClient
            BorderWidth = 5
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
          end
        end
      end
      object sPanel3: TsPanel
        Left = 9
        Top = 9
        Width = 74
        Height = 185
        Align = alLeft
        TabOrder = 2
        SkinData.SkinSection = 'PANEL'
      end
      object sPanel4: TsPanel
        Left = 89
        Top = 9
        Width = 187
        Height = 185
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 1
        SkinData.SkinSection = 'PANEL_LOW'
      end
    end
    object sGroupBox1: TsGroupBox
      Left = 0
      Top = 0
      Width = 269
      Height = 350
      Align = alLeft
      Caption = 'sGroupBox1'
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      object sGroupBox2: TsGroupBox
        Left = 20
        Top = 28
        Width = 230
        Height = 110
        Caption = 'sGroupBox2'
        TabOrder = 0
        CaptionLayout = clTopCenter
        CaptionYOffset = 4
        SkinData.SkinSection = 'GROUPBOX'
      end
      object sPanel8: TsPanel
        Left = 20
        Top = 152
        Width = 230
        Height = 109
        Caption = 'sPanel3'
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
      end
      object sComboBox1: TsComboBox
        Tag = 5
        Left = 141
        Top = 285
        Width = 110
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
        DropDownCount = 10
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
          'FORMTITLE'
          'DRAGBAR'
          'EDIT'
          'PROGRESSH'
          'GRIPH'
          'EXTRALINE'
          'HINT'
          'BUTTON_HUGE')
      end
      object sComboBox2: TsComboBox
        Tag = 5
        Left = 141
        Top = 313
        Width = 110
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'GroupBox.CaptionSkin :'
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'MS Sans Serif'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        DropDownCount = 10
        SkinData.SkinSection = 'COMBOBOX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 15
        ItemIndex = -1
        ParentFont = False
        TabOrder = 3
        OnChange = sComboBox2Change
        Items.Strings = (
          'BUTTON_BIG'
          'CHECKBOX'
          'PANEL_LOW'
          'PANEL'
          'BUTTON'
          'SPEEDBUTTON'
          'GROUPBOX'
          'DIALOG'
          'FORMTITLE'
          'DRAGBAR'
          'EDIT'
          'PROGRESSH'
          'GRIPH'
          'EXTRALINE'
          'HINT')
      end
    end
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 200
    Top = 64
  end
end
