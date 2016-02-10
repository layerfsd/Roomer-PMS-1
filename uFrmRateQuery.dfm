object FrmRateQuery: TFrmRateQuery
  Left = 0
  Top = 0
  Caption = 'FrmRateQuery'
  ClientHeight = 531
  ClientWidth = 826
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 826
    Height = 531
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object pnlTop: TsPanel
      Left = 0
      Top = 0
      Width = 826
      Height = 145
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object lblArrival: TsLabel
        Left = 77
        Top = 27
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Arrival:'
      end
      object sLabel1: TsLabel
        Left = 59
        Top = 81
        Width = 53
        Height = 13
        Alignment = taRightJustify
        Caption = 'Departure:'
      end
      object sLabel2: TsLabel
        Left = 78
        Top = 54
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Nights:'
      end
      object sLabel3: TsLabel
        Left = 66
        Top = 108
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = 'Mealplan:'
        Visible = False
      end
      object sLabel4: TsLabel
        Left = 324
        Top = 27
        Width = 36
        Height = 13
        Alignment = taRightJustify
        Caption = 'Rooms:'
        Visible = False
      end
      object sLabel5: TsLabel
        Left = 326
        Top = 54
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Adults:'
        Visible = False
      end
      object sLabel6: TsLabel
        Left = 677
        Top = 81
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Children:'
        Visible = False
      end
      object sLabel7: TsLabel
        Left = 681
        Top = 108
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Infants:'
        Visible = False
      end
      object sLabel8: TsLabel
        Left = 549
        Top = 27
        Width = 66
        Height = 13
        Alignment = taRightJustify
        Caption = 'Display rates:'
      end
      object sLabel9: TsLabel
        Left = 317
        Top = 81
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Channel:'
      end
      object edNights: TsSpinEdit
        Left = 132
        Top = 51
        Width = 65
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 1
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        OnDownClick = edNightsDownClick
        OnUpClick = edNightsUpClick
        MaxValue = 365
        MinValue = 0
        Value = 0
      end
      object sComboBox1: TsComboBox
        Left = 132
        Top = 105
        Width = 109
        Height = 21
        Alignment = taLeftJustify
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 2
        Text = 'None'
        Visible = False
        Items.Strings = (
          'None'
          'Breakfast included'
          'Halfboard'
          'Fullboard')
      end
      object sSpinEdit1: TsSpinEdit
        Left = 380
        Top = 24
        Width = 65
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Visible = False
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        MaxValue = 365
        MinValue = 1
        Value = 0
      end
      object sSpinEdit2: TsSpinEdit
        Left = 380
        Top = 51
        Width = 65
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Visible = False
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        MaxValue = 365
        MinValue = 1
        Value = 0
      end
      object sSpinEdit3: TsSpinEdit
        Left = 740
        Top = 78
        Width = 65
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Visible = False
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        MaxValue = 365
        MinValue = 1
        Value = 0
      end
      object sSpinEdit4: TsSpinEdit
        Left = 740
        Top = 105
        Width = 65
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Visible = False
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        MaxValue = 365
        MinValue = 1
        Value = 0
      end
      object rbTotal: TsRadioButton
        Left = 549
        Top = 52
        Width = 75
        Height = 19
        Caption = 'Total rate'
        Checked = True
        TabOrder = 8
        TabStop = True
        OnClick = rbTotalClick
        SkinData.SkinSection = 'CHECKBOX'
      end
      object rbAverage: TsRadioButton
        Left = 549
        Top = 77
        Width = 127
        Height = 19
        Caption = 'Average nightly rate'
        TabOrder = 7
        OnClick = rbTotalClick
        SkinData.SkinSection = 'CHECKBOX'
      end
      object btnRefresh: TsButton
        Left = 380
        Top = 103
        Width = 75
        Height = 25
        Caption = 'Refresh'
        Default = True
        TabOrder = 0
        OnClick = btnRefreshClick
        SkinData.SkinSection = 'BUTTON'
      end
      object cbxChannels: TsComboBox
        Left = 380
        Top = 78
        Width = 110
        Height = 21
        Alignment = taLeftJustify
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
        TabOrder = 9
        Text = 'cbxChannels'
        OnChange = cbxChannelsChange
      end
      object dtArrival: TcxDateEdit
        Left = 132
        Top = 28
        ParentFont = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        Properties.OnCloseUp = dtArrivalPropertiesCloseUp
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsNone
        Style.Color = clBlack
        Style.Edges = []
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.HotTrack = False
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = False
        Style.TextColor = clBlack
        Style.TextStyle = []
        Style.TransparentBorder = False
        Style.ButtonStyle = btsDefault
        Style.ButtonTransparency = ebtNone
        Style.PopupBorderStyle = epbsDefault
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 10
        Width = 109
      end
      object dtDeparture: TcxDateEdit
        Left = 132
        Top = 78
        ParentFont = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        Properties.OnCloseUp = dtDeparturePropertiesCloseUp
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsNone
        Style.Color = clBlack
        Style.Edges = []
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.HotTrack = False
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = False
        Style.TextColor = clBlack
        Style.TextStyle = []
        Style.TransparentBorder = False
        Style.ButtonStyle = btsDefault
        Style.ButtonTransparency = ebtNone
        Style.PopupBorderStyle = epbsDefault
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 11
        Width = 109
      end
    end
    object grdRates: TAdvStringGrid
      Left = 0
      Top = 145
      Width = 826
      Height = 386
      Cursor = crDefault
      Align = alClient
      DefaultColWidth = 120
      DrawingStyle = gdsClassic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 1
      OnDrawCell = grdRatesDrawCell
      HoverRowCells = [hcNormal, hcSelected]
      OnGetCellColor = grdRatesGetCellColor
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -12
      ActiveCellFont.Name = 'Tahoma'
      ActiveCellFont.Style = [fsBold]
      ControlLook.FixedGradientHoverFrom = clGray
      ControlLook.FixedGradientHoverTo = clWhite
      ControlLook.FixedGradientDownFrom = clGray
      ControlLook.FixedGradientDownTo = clSilver
      ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
      ControlLook.DropDownHeader.Font.Color = clWindowText
      ControlLook.DropDownHeader.Font.Height = -11
      ControlLook.DropDownHeader.Font.Name = 'Tahoma'
      ControlLook.DropDownHeader.Font.Style = []
      ControlLook.DropDownHeader.Visible = True
      ControlLook.DropDownHeader.Buttons = <>
      ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
      ControlLook.DropDownFooter.Font.Color = clWindowText
      ControlLook.DropDownFooter.Font.Height = -11
      ControlLook.DropDownFooter.Font.Name = 'Tahoma'
      ControlLook.DropDownFooter.Font.Style = []
      ControlLook.DropDownFooter.Visible = True
      ControlLook.DropDownFooter.Buttons = <>
      Filter = <>
      FilterDropDown.Font.Charset = DEFAULT_CHARSET
      FilterDropDown.Font.Color = clWindowText
      FilterDropDown.Font.Height = -11
      FilterDropDown.Font.Name = 'Tahoma'
      FilterDropDown.Font.Style = []
      FilterDropDownClear = '(All)'
      FilterEdit.TypeNames.Strings = (
        'Starts with'
        'Ends with'
        'Contains'
        'Not contains'
        'Equal'
        'Not equal'
        'Larger than'
        'Smaller than'
        'Clear')
      FixedColWidth = 120
      FixedRowHeight = 22
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -12
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = [fsBold]
      FloatFormat = '%.2f'
      HoverButtons.Buttons = <>
      HoverButtons.Position = hbLeftFromColumnLeft
      HTMLSettings.ImageFolder = 'images'
      HTMLSettings.ImageBaseName = 'img'
      PrintSettings.DateFormat = 'dd/mm/yyyy'
      PrintSettings.Font.Charset = DEFAULT_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -11
      PrintSettings.Font.Name = 'Tahoma'
      PrintSettings.Font.Style = []
      PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
      PrintSettings.FixedFont.Color = clWindowText
      PrintSettings.FixedFont.Height = -11
      PrintSettings.FixedFont.Name = 'Tahoma'
      PrintSettings.FixedFont.Style = []
      PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -11
      PrintSettings.HeaderFont.Name = 'Tahoma'
      PrintSettings.HeaderFont.Style = []
      PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -11
      PrintSettings.FooterFont.Name = 'Tahoma'
      PrintSettings.FooterFont.Style = []
      PrintSettings.PageNumSep = '/'
      SearchFooter.FindNextCaption = 'Find &next'
      SearchFooter.FindPrevCaption = 'Find &previous'
      SearchFooter.Font.Charset = DEFAULT_CHARSET
      SearchFooter.Font.Color = clWindowText
      SearchFooter.Font.Height = -11
      SearchFooter.Font.Name = 'Tahoma'
      SearchFooter.Font.Style = []
      SearchFooter.HighLightCaption = 'Highlight'
      SearchFooter.HintClose = 'Close'
      SearchFooter.HintFindNext = 'Find next occurrence'
      SearchFooter.HintFindPrev = 'Find previous occurrence'
      SearchFooter.HintHighlight = 'Highlight occurrences'
      SearchFooter.MatchCaseCaption = 'Match case'
      SortSettings.DefaultFormat = ssAutomatic
      Version = '7.8.9.0'
    end
  end
  object timRefresh: TTimer
    Enabled = False
    OnTimer = timRefreshTimer
    Left = 512
    Top = 248
  end
end
