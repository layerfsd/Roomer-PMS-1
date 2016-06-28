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
  object pnlHolder: TPanel
    Left = 0
    Top = 0
    Width = 826
    Height = 531
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 826
      Height = 145
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblArrival: TLabel
        Left = 77
        Top = 10
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Arrival:'
      end
      object sLabel1: TLabel
        Left = 59
        Top = 61
        Width = 53
        Height = 13
        Alignment = taRightJustify
        Caption = 'Departure:'
      end
      object sLabel2: TLabel
        Left = 78
        Top = 37
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Nights:'
      end
      object sLabel3: TLabel
        Left = 674
        Top = 32
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = 'Mealplan:'
        Visible = False
      end
      object sLabel4: TLabel
        Left = 324
        Top = 8
        Width = 36
        Height = 13
        Alignment = taRightJustify
        Caption = 'Rooms:'
        Visible = False
      end
      object sLabel5: TLabel
        Left = 326
        Top = 35
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Adults:'
        Visible = False
      end
      object sLabel6: TLabel
        Left = 677
        Top = 62
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Children:'
        Visible = False
      end
      object sLabel7: TLabel
        Left = 681
        Top = 89
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Infants:'
        Visible = False
      end
      object sLabel8: TLabel
        Left = 549
        Top = 8
        Width = 66
        Height = 13
        Alignment = taRightJustify
        Caption = 'Display rates:'
      end
      object sLabel9: TLabel
        Left = 317
        Top = 62
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Channel:'
      end
      object Label1: TLabel
        Left = 63
        Top = 86
        Width = 49
        Height = 13
        Alignment = taRightJustify
        Caption = 'Company:'
      end
      object sLabel10: TsLabel
        Left = 102
        Top = 110
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Name:'
      end
      object sLabel11: TsLabel
        Left = 83
        Top = 129
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'Rate plan:'
      end
      object lbCustomerRate: TsLabel
        Left = 139
        Top = 129
        Width = 18
        Height = 13
        Caption = 'N/A'
      end
      object lbCustomerName: TsLabel
        Left = 139
        Top = 110
        Width = 18
        Height = 13
        Caption = 'N/A'
      end
      object edNights: TSpinEdit
        Left = 132
        Top = 32
        Width = 65
        Height = 22
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 365
        MinValue = 1
        ParentFont = False
        TabOrder = 1
        Value = 1
        OnChange = edNightsChange
      end
      object sComboBox1: TComboBox
        Left = 740
        Top = 29
        Width = 109
        Height = 21
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
      object sSpinEdit1: TSpinEdit
        Left = 380
        Top = 5
        Width = 65
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 365
        MinValue = 1
        ParentFont = False
        TabOrder = 3
        Value = 1
        Visible = False
      end
      object sSpinEdit2: TSpinEdit
        Left = 380
        Top = 32
        Width = 65
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 365
        MinValue = 1
        ParentFont = False
        TabOrder = 4
        Value = 1
        Visible = False
      end
      object sSpinEdit3: TSpinEdit
        Left = 740
        Top = 59
        Width = 65
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 365
        MinValue = 1
        ParentFont = False
        TabOrder = 5
        Value = 1
        Visible = False
      end
      object sSpinEdit4: TSpinEdit
        Left = 740
        Top = 86
        Width = 65
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 365
        MinValue = 1
        ParentFont = False
        TabOrder = 6
        Value = 1
        Visible = False
      end
      object rbTotal: TRadioButton
        Left = 549
        Top = 33
        Width = 75
        Height = 19
        Caption = 'Total rate'
        Checked = True
        TabOrder = 8
        TabStop = True
        OnClick = rbTotalClick
      end
      object rbAverage: TRadioButton
        Left = 549
        Top = 58
        Width = 127
        Height = 19
        Caption = 'Average nightly rate'
        TabOrder = 7
        OnClick = rbTotalClick
      end
      object btnRefresh: TButton
        Left = 380
        Top = 84
        Width = 75
        Height = 25
        Caption = 'Refresh'
        Default = True
        TabOrder = 0
        OnClick = btnRefreshClick
      end
      object cbxChannels: TComboBox
        Left = 380
        Top = 59
        Width = 110
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        Text = 'cbxChannels'
        OnChange = cbxChannelsChange
      end
      object dtArrival: TcxDateEdit
        Left = 132
        Top = 9
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
        Top = 60
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
      object edCustomer: TcxButtonEdit
        Left = 132
        Top = 83
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        TabOrder = 12
        OnClick = edCustomerClick
        Width = 121
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
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 1
      OnDrawCell = grdRatesDrawCell
      HoverRowCells = [hcNormal, hcSelected]
      OnGetCellColor = grdRatesGetCellColor
      OnClickCell = grdRatesClickCell
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
      Version = '7.9.1.0'
    end
  end
  object timRefresh: TTimer
    Enabled = False
    OnTimer = timRefreshTimer
    Left = 512
    Top = 248
  end
end
