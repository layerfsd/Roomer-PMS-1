inherited frmRptDailyRevenues: TfrmRptDailyRevenues
  Caption = 'Daily Revenues and Payments'
  ClientHeight = 644
  ClientWidth = 1390
  Font.Height = -11
  Position = poOwnerFormCenter
  ExplicitLeft = -279
  ExplicitWidth = 1406
  ExplicitHeight = 683
  PixelsPerInch = 96
  TextHeight = 13
  inherited dxStatusBar: TdxStatusBar
    Top = 624
    Width = 1390
    ExplicitTop = 624
    ExplicitWidth = 1390
  end
  object pnlHolder: TsPanel [1]
    Left = 0
    Top = 0
    Width = 1390
    Height = 624
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sSplitter1: TsSplitter
      Left = 393
      Top = 129
      Height = 495
      Color = clGradientActiveCaption
      ParentColor = False
      SkinData.CustomColor = True
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitHeight = 363
    end
    object pnlFilter: TsPanel
      Left = 0
      Top = 0
      Width = 1390
      Height = 129
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object pnlExportButtons: TsPanel
        Left = 1
        Top = 85
        Width = 1388
        Height = 43
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object btnExcel: TsButton
          AlignWithMargins = True
          Left = 1123
          Top = 3
          Width = 128
          Height = 37
          Align = alRight
          Caption = 'Excel'
          ImageIndex = 115
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnExcelClick
          SkinData.SkinSection = 'BUTTON'
          ExplicitTop = 2
        end
        object btnPrintGrid: TsButton
          AlignWithMargins = True
          Left = 1257
          Top = 3
          Width = 128
          Height = 37
          Align = alRight
          Caption = 'Report'
          ImageIndex = 69
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = btnPrintGridClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnRefresh: TsButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 128
          Height = 37
          Align = alLeft
          Caption = 'Refresh'
          Default = True
          ImageIndex = 28
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnRefreshClick
          SkinData.SkinSection = 'BUTTON'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitHeight = 43
        end
        object btnCloseCurrentDay: TsButton
          AlignWithMargins = True
          Left = 137
          Top = 3
          Width = 128
          Height = 37
          Align = alLeft
          Caption = 'Close fin. day now'
          ImageIndex = 64
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = btnCloseCurrentDayClick
          SkinData.SkinSection = 'BUTTON'
          ExplicitLeft = 1123
          ExplicitTop = 2
        end
      end
      object gbxSelection: TsGroupBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 349
        Height = 78
        Align = alLeft
        Caption = 'Select date or range'
        TabOrder = 0
        Checked = False
        object lblFromDate: TsLabel
          Left = 146
          Top = 23
          Width = 57
          Height = 13
          Alignment = taRightJustify
          Caption = 'From Date: '
        end
        object lblTodate: TsLabel
          Left = 161
          Top = 50
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'To Date:'
        end
        object dtFromDate: TsDateEdit
          Left = 211
          Top = 20
          Width = 105
          Height = 21
          AutoSize = False
          EditMask = '!99/99/9999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 2
          CheckOnExit = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
          DefaultToday = True
          DialogTitle = 'From date'
          Weekends = [dowSaturday, dowSunday]
        end
        object dtToDate: TsDateEdit
          Left = 211
          Top = 47
          Width = 105
          Height = 21
          AutoSize = False
          EditMask = '!99/99/9999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 3
          CheckOnExit = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
          DefaultToday = True
          DialogTitle = 'To date'
        end
        object rbYesterday: TsRadioButton
          Left = 16
          Top = 21
          Width = 69
          Height = 20
          Caption = 'Yesterday'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbPresetDateClick
          SkinData.SkinSection = 'CHECKBOX'
        end
        object rbOther: TsRadioButton
          Left = 16
          Top = 48
          Width = 48
          Height = 20
          Caption = 'Other'
          TabOrder = 1
          OnClick = rbPresetDateClick
          SkinData.SkinSection = 'CHECKBOX'
        end
      end
    end
    object pnlLeft: TsPanel
      Left = 0
      Top = 129
      Width = 393
      Height = 495
      Align = alLeft
      TabOrder = 1
      object grDataPayments: TcxGrid
        Left = 1
        Top = 1
        Width = 391
        Height = 493
        Align = alClient
        TabOrder = 0
        LookAndFeel.NativeStyle = False
        RootLevelOptions.DetailTabsPosition = dtpTop
        object tvPayments: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsPayments
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              Position = spFooter
              Column = tvPaymentsTotalAmount
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              Column = tvPaymentsTotalAmount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupFooters = gfAlwaysVisible
          OptionsView.Indicator = True
          Styles.Group = cxstGroup
          Styles.GroupSummary = cxstGroup
          Styles.Header = cxstHeader
          Styles.StyleSheet = cxssRoomerGridTableView
          object tvPaymentsDate: TcxGridDBColumn
            DataBinding.FieldName = 'Date'
            PropertiesClassName = 'TcxDateEditProperties'
            DateTimeGrouping = dtgByMonth
            GroupIndex = 0
            SortIndex = 0
            SortOrder = soAscending
          end
          object tvPaymentspaytype: TcxGridDBColumn
            Caption = 'Paytype'
            DataBinding.FieldName = 'paytype'
          end
          object tvPaymentsdescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'description'
          end
          object tvPaymentsTotalAmount: TcxGridDBColumn
            Caption = 'Total Amount'
            DataBinding.FieldName = 'TotalAmount'
            OnGetProperties = tvPaymentsTotalAmountGetProperties
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 82
          end
        end
        object lvPayments: TcxGridLevel
          Caption = 'Payments'
          GridView = tvPayments
          Options.DetailTabsPosition = dtpTop
          Styles.Tab = cxstGroup
        end
      end
    end
    object pnlRight: TsPanel
      Left = 399
      Top = 129
      Width = 991
      Height = 495
      Align = alClient
      TabOrder = 2
      object sSplitter2: TsSplitter
        Left = 641
        Top = 1
        Height = 493
        Color = clGradientActiveCaption
        ParentColor = False
        SkinData.CustomColor = True
        ExplicitLeft = 9
        ExplicitTop = 2
        ExplicitHeight = 411
      end
      object grDataRevenues: TcxGrid
        Left = 1
        Top = 1
        Width = 640
        Height = 493
        Align = alLeft
        TabOrder = 0
        LookAndFeel.NativeStyle = False
        RootLevelOptions.DetailTabsPosition = dtpTop
        object tvRevenues: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsRevenues
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
              Column = tvRevenuestotalamount
            end
            item
              Kind = skSum
              Position = spFooter
              Column = tvRevenuestotalwovat
            end
            item
              Kind = skSum
              Position = spFooter
              Column = tvRevenuestotalvat
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
            end
            item
              Kind = skSum
              Column = tvRevenuestotalamount
            end
            item
              Kind = skSum
              Column = tvRevenuestotalwovat
            end
            item
              Kind = skSum
              Column = tvRevenuestotalvat
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.AlwaysShowEditor = True
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupFooters = gfAlwaysVisible
          OptionsView.Indicator = True
          Styles.Group = cxstGroup
          Styles.Header = cxstHeader
          Styles.StyleSheet = cxssRoomerGridTableView
          object tvRevenuesdate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'revenuedate'
            PropertiesClassName = 'TcxDateEditProperties'
            DateTimeGrouping = dtgByMonth
            GroupIndex = 0
            SortIndex = 0
            SortOrder = soAscending
            Width = 72
          end
          object tvRevenuesitemtype: TcxGridDBColumn
            Caption = 'ItemType'
            DataBinding.FieldName = 'itemtype'
            Width = 109
          end
          object tvRevenuesdescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'description'
            Width = 167
          end
          object tvRevenuesvattype: TcxGridDBColumn
            Caption = 'Vattype'
            DataBinding.FieldName = 'vattype'
            Width = 69
          end
          object tvRevenuestotalamount: TcxGridDBColumn
            Caption = 'Total Amount'
            DataBinding.FieldName = 'totalamount'
            OnGetProperties = tvPaymentsTotalAmountGetProperties
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 111
          end
          object tvRevenuestotalwovat: TcxGridDBColumn
            Caption = 'Total w/o VAT'
            DataBinding.FieldName = 'totalwovat'
            OnGetProperties = tvPaymentsTotalAmountGetProperties
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 108
          end
          object tvRevenuestotalvat: TcxGridDBColumn
            Caption = 'Total VAT'
            DataBinding.FieldName = 'totalvat'
            OnGetProperties = tvPaymentsTotalAmountGetProperties
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 111
          end
        end
        object lvRevenues: TcxGridLevel
          Caption = 'Revenues'
          GridView = tvRevenues
          Options.DetailTabsPosition = dtpTop
        end
      end
      object grBalance: TcxGrid
        Left = 647
        Top = 1
        Width = 343
        Height = 493
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        RootLevelOptions.DetailTabsPosition = dtpTop
        object tvBalance: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsBalance
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
              Column = tvBalancetotalrevenues
            end
            item
              Kind = skSum
              Position = spFooter
              Column = tvBalancetotalpayments
            end
            item
              Kind = skSum
              Position = spFooter
              Column = tvBalancebalance
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
            end
            item
              Kind = skSum
              Column = tvBalancetotalrevenues
            end
            item
              Kind = skSum
              Column = tvBalancetotalpayments
            end
            item
              Kind = skSum
              Column = tvBalancebalance
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.AlwaysShowEditor = True
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupFooters = gfAlwaysVisible
          OptionsView.Indicator = True
          Styles.Group = cxstGroup
          Styles.Header = cxstHeader
          Styles.StyleSheet = cxssRoomerGridTableView
          object tvBalancerevenuedate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'revenuedate'
            PropertiesClassName = 'TcxDateEditProperties'
            DateTimeGrouping = dtgByMonth
            GroupIndex = 0
            SortIndex = 0
            SortOrder = soAscending
          end
          object tvBalancetotalrevenues: TcxGridDBColumn
            Caption = 'Revenues'
            DataBinding.FieldName = 'totalrevenues'
            OnGetProperties = tvPaymentsTotalAmountGetProperties
            HeaderAlignmentHorz = taRightJustify
          end
          object tvBalancetotalpayments: TcxGridDBColumn
            Caption = 'Payments'
            DataBinding.FieldName = 'totalpayments'
            OnGetProperties = tvPaymentsTotalAmountGetProperties
            HeaderAlignmentHorz = taRightJustify
          end
          object tvBalancebalance: TcxGridDBColumn
            Caption = 'Balance'
            DataBinding.FieldName = 'balance'
            OnGetProperties = tvPaymentsTotalAmountGetProperties
            HeaderAlignmentHorz = taRightJustify
          end
        end
        object lvBalance: TcxGridLevel
          Caption = 'Balance'
          GridView = tvBalance
          Options.DetailTabsPosition = dtpTop
        end
      end
    end
  end
  inherited psRoomerBase: TcxPropertiesStore
    Components = <
      item
        Component = grDataRevenues
        Properties.Strings = (
          'Width')
      end
      item
        Component = pnlLeft
        Properties.Strings = (
          'Width')
      end>
  end
  inherited cxsrRoomerStyleRepository: TcxStyleRepository
    Left = 456
    Top = 24
    PixelsPerInch = 96
    inherited dxssRoomerGridReportLink: TdxGridReportLinkStyleSheet
      BuiltIn = True
    end
    inherited cxssRoomerGridTableView: TcxGridTableViewStyleSheet
      BuiltIn = True
    end
  end
  object m_Payments: TdxMemData
    Indexes = <
      item
        FieldName = 'Date'
        SortOptions = []
      end>
    SortOptions = []
    Left = 208
    Top = 192
    object m_PaymentsDate: TDateField
      FieldName = 'Date'
    end
    object m_Paymentspaytype: TWideStringField
      FieldName = 'paytype'
      Size = 10
    end
    object m_Paymentsdescription: TWideStringField
      FieldName = 'description'
      Size = 30
    end
    object m_PaymentsTotalAmount: TFloatField
      FieldName = 'TotalAmount'
    end
  end
  object dsPayments: TDataSource
    DataSet = m_Payments
    Left = 152
    Top = 192
  end
  object gridPrinter: TdxComponentPrinter
    CurrentLink = grdPrinterLinkAll
    Version = 0
    Left = 240
    Top = 248
    object grdPrinterLinkRevenues: TdxGridReportLink
      Active = True
      Component = grDataRevenues
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 6350
      PrinterPage.Margins.Left = 10000
      PrinterPage.Margins.Right = 5000
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 42660.569067453700000000
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clBlack
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Arial'
      ReportTitle.Font.Style = [fsBold]
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      OptionsFormatting.LookAndFeelKind = lfFlat
      OptionsFormatting.UseNativeStyles = True
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsSize.AutoWidth = True
      OptionsView.FilterBar = False
      ScaleFonts = False
      StyleRepository = cxsrRoomerStyleRepository
      Styles.StyleSheet = dxssRoomerGridReportLink
      BuiltInReportLink = True
    end
    object grdPrinterLinkPayments: TdxGridReportLink
      Active = True
      Component = grDataPayments
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 6350
      PrinterPage.Margins.Left = 10000
      PrinterPage.Margins.Right = 5000
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 42660.569067546300000000
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clBlack
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Arial'
      ReportTitle.Font.Style = [fsBold]
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      OptionsCards.KeepSameHeight = False
      OptionsFormatting.LookAndFeelKind = lfFlat
      OptionsFormatting.UseNativeStyles = True
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsSize.AutoWidth = True
      OptionsView.FilterBar = False
      ScaleFonts = False
      StyleRepository = cxsrRoomerStyleRepository
      Styles.StyleSheet = dxssRoomerGridReportLink
      BuiltInReportLink = True
    end
    object gridPrinterLinkBalance: TdxGridReportLink
      Active = True
      Component = grBalance
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 6350
      PrinterPage.Margins.Left = 10000
      PrinterPage.Margins.Right = 5000
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 42660.569067569440000000
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clBlack
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Arial'
      ReportTitle.Font.Style = [fsBold]
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      OptionsFormatting.LookAndFeelKind = lfFlat
      OptionsFormatting.UseNativeStyles = True
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsSize.AutoWidth = True
      OptionsView.FilterBar = False
      ScaleFonts = False
      StyleRepository = cxsrRoomerStyleRepository
      Styles.StyleSheet = dxssRoomerGridReportLink
      BuiltInReportLink = True
    end
    object grdPrinterLinkAll: TdxCompositionReportLink
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageFooter.Font.Charset = ANSI_CHARSET
      PrinterPage.PageFooter.Font.Color = clBlack
      PrinterPage.PageFooter.Font.Height = -11
      PrinterPage.PageFooter.Font.Name = 'Arial Narrow'
      PrinterPage.PageFooter.Font.Style = []
      PrinterPage.PageFooter.LeftTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageHeader.CenterTitle.Strings = (
        'Daily Revenues and Payments')
      PrinterPage.PageHeader.Font.Charset = ANSI_CHARSET
      PrinterPage.PageHeader.Font.Color = clBlack
      PrinterPage.PageHeader.Font.Height = -16
      PrinterPage.PageHeader.Font.Name = 'Arial'
      PrinterPage.PageHeader.Font.Style = []
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'grdPrinterLinkAll'
      ReportDocument.CreationDate = 42649.700511134260000000
      TimeFormat = 2
      AssignedFormatValues = [fvTime]
      Items = <
        item
          ReportLink = grdPrinterLinkRevenues
          BuiltInCompositionItem = True
        end
        item
          ReportLink = grdPrinterLinkPayments
          BuiltInCompositionItem = True
        end
        item
          ReportLink = gridPrinterLinkBalance
          BuiltInCompositionItem = True
        end>
      StartEachItemFromNewPage = False
      BuiltInReportLink = True
    end
  end
  object dsRevenues: TDataSource
    DataSet = m_Revenues
    Left = 440
    Top = 272
  end
  object m_Revenues: TdxMemData
    Indexes = <
      item
        FieldName = 'revenuedate'
        SortOptions = []
      end>
    SortOptions = []
    Left = 512
    Top = 264
    object m_RevenuesRevenuedate: TDateField
      FieldName = 'revenuedate'
    end
    object m_Revenuesitemtype: TWideStringField
      FieldName = 'itemtype'
    end
    object m_Revenuesdescription: TWideStringField
      FieldName = 'description'
      Size = 30
    end
    object m_Revenuesvattype: TWideStringField
      FieldName = 'vattype'
      Size = 10
    end
    object m_Revenuestotalamount: TFloatField
      FieldName = 'totalamount'
    end
    object m_Revenuestotalwovat: TFloatField
      FieldName = 'totalwovat'
    end
    object m_Revenuestotalvat: TFloatField
      FieldName = 'totalvat'
    end
  end
  object m_Balance: TdxMemData
    Indexes = <
      item
        FieldName = 'revenuedate'
        SortOptions = []
      end>
    SortOptions = []
    OnCalcFields = m_BalanceCalcFields
    Left = 1152
    Top = 240
    object m_BalanceRevenueDate: TDateField
      FieldName = 'revenuedate'
    end
    object m_Balancetotalrevenues: TFloatField
      FieldName = 'totalrevenues'
    end
    object m_Balancetotalpayments: TFloatField
      FieldName = 'totalpayments'
    end
    object m_Balancebalance: TFloatField
      FieldKind = fkCalculated
      FieldName = 'balance'
      Calculated = True
    end
  end
  object dsBalance: TDataSource
    DataSet = m_Balance
    Left = 1080
    Top = 248
  end
end
