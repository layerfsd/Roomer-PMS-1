inherited frmDateSelection: TfrmDateSelection
  Caption = ''
  ClientHeight = 81
  ClientWidth = 570
  ExplicitWidth = 586
  ExplicitHeight = 120
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDateSelection: TsPanel
    Left = 0
    Top = 0
    Width = 570
    Height = 81
    Align = alClient
    TabOrder = 0
    object gbxSelectMonths: TsGroupBox
      AlignWithMargins = True
      Left = 357
      Top = 4
      Width = 139
      Height = 73
      Align = alLeft
      Caption = '.. or select a month'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object cbxMonth: TsComboBox
        Left = 7
        Top = 18
        Width = 118
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 0
        Text = 'Select month ...'
        OnChange = cbxMonthChange
        Items.Strings = (
          'Select month ...'
          'January'
          'February'
          'March'
          'April'
          'May'
          'June'
          'July'
          'August'
          'September'
          'October'
          'November'
          'December')
      end
      object cbxYear: TsComboBox
        Left = 7
        Top = 45
        Width = 118
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 1
        Text = 'Select year ...'
        Items.Strings = (
          'Veldu '#225'r ...'
          '2011'
          '2012'
          '2013'
          '2014'
          '2015'
          '2016'
          '2017'
          '2018'
          '2020')
      end
    end
    object gbxSelectDates: TsGroupBox
      AlignWithMargins = True
      Left = 180
      Top = 4
      Width = 171
      Height = 73
      Align = alLeft
      Caption = '.. or select a date range'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object dtDateFrom: TsDateEdit
        Left = 57
        Top = 18
        Width = 105
        Height = 21
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  -  -    '
        CheckOnExit = True
        BoundLabel.Active = True
        BoundLabel.Caption = 'From:'
        BoundLabel.Indent = 10
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtDateTo: TsDateEdit
        Left = 57
        Top = 45
        Width = 105
        Height = 21
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  -  -    '
        CheckOnExit = True
        BoundLabel.Active = True
        BoundLabel.Caption = 'To:'
        BoundLabel.Indent = 10
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
    object gbxPresets: TsGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 170
      Height = 73
      Align = alLeft
      Caption = 'Select preset'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object cbxPresets: TsComboBox
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 160
        Height = 21
        Align = alTop
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 0
        OnChange = cbxPresetsChange
        ExplicitLeft = 3
        ExplicitWidth = 158
      end
    end
  end
end
