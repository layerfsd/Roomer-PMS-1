inherited frmRptDailyRevenues: TfrmRptDailyRevenues
  Caption = 'Daily Revenues and Payments'
  ClientHeight = 644
  ClientWidth = 1128
  Font.Height = -11
  Position = poOwnerFormCenter
  ExplicitWidth = 1144
  ExplicitHeight = 683
  PixelsPerInch = 96
  TextHeight = 13
  inherited dxStatusBar: TdxStatusBar
    Top = 624
    Width = 1128
    ExplicitTop = 624
    ExplicitWidth = 1128
  end
  object pnlHolder: TsPanel [1]
    Left = 0
    Top = 0
    Width = 1128
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
      Left = 441
      Top = 147
      Height = 413
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
      Width = 1128
      Height = 147
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object pnlExportButtons: TsPanel
        Left = 1
        Top = 103
        Width = 1126
        Height = 43
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object btnExcel: TsButton
          AlignWithMargins = True
          Left = 861
          Top = 3
          Width = 128
          Height = 37
          Align = alRight
          Caption = 'Excel'
          ImageIndex = 115
          Images = DImages.PngImageList1
          TabOrder = 1
          SkinData.SkinSection = 'BUTTON'
        end
        object btnPrintGrid: TsButton
          AlignWithMargins = True
          Left = 995
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
          Left = 0
          Top = 0
          Width = 128
          Height = 43
          Align = alLeft
          Caption = 'Refresh'
          Default = True
          ImageIndex = 28
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnRefreshClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object gbxSelection: TsGroupBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 349
        Height = 96
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
          Color = clWhite
          EditMask = '!99/99/9999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
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
          DialogTitle = 'From date'
        end
        object dtToDate: TsDateEdit
          Left = 211
          Top = 47
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
          TabOrder = 4
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
          Width = 77
          Height = 19
          Caption = 'Yesterday'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbPresetDateClick
          SkinData.SkinSection = 'CHECKBOX'
        end
        object rbToday: TsRadioButton
          Left = 16
          Top = 43
          Width = 58
          Height = 19
          Caption = 'Today'
          TabOrder = 1
          OnClick = rbPresetDateClick
          SkinData.SkinSection = 'CHECKBOX'
        end
        object rbOther: TsRadioButton
          Left = 16
          Top = 64
          Width = 56
          Height = 19
          Caption = 'Other'
          TabOrder = 2
          OnClick = rbPresetDateClick
          SkinData.SkinSection = 'CHECKBOX'
        end
      end
    end
    object pnlLeft: TsPanel
      Left = 0
      Top = 147
      Width = 441
      Height = 413
      Align = alLeft
      TabOrder = 1
      object grDataPayments: TcxGrid
        Left = 1
        Top = 1
        Width = 439
        Height = 411
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
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfAlwaysVisible
          OptionsView.Indicator = True
          Styles.Group = cxStyle1
          Styles.Header = cxStyle1
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
        end
      end
    end
    object pnlRight: TsPanel
      Left = 447
      Top = 147
      Width = 681
      Height = 413
      Align = alClient
      TabOrder = 2
      object grDataRevenues: TcxGrid
        Left = 1
        Top = 1
        Width = 679
        Height = 411
        Align = alClient
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
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfAlwaysVisible
          OptionsView.Indicator = True
          Styles.Group = cxStyle1
          Styles.Header = cxStyle1
          object tvRevenuesdate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'date'
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
            Caption = 'Total without VAT'
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
    end
    object pnlBottom: TsPanel
      Left = 0
      Top = 560
      Width = 1128
      Height = 64
      Align = alBottom
      TabOrder = 3
    end
  end
  inherited psRoomerBase: TcxPropertiesStore
    Components = <
      item
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width'
          'WindowState')
      end
      item
        Component = pnlLeft
        Properties.Strings = (
          'Width')
      end>
  end
  object m_Payments: TdxMemData
    Indexes = <>
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
  object cxStyleRepository2: TcxStyleRepository
    Left = 152
    Top = 256
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle6: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle7: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 16053492
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle8: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle9: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle10: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle11: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxStyle12: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxStyle13: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle14: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object dxGridReportLinkStyleSheet1: TdxGridReportLinkStyleSheet
      Caption = 'Arial font'
      Styles.BandHeader = cxStyle2
      Styles.Caption = cxStyle3
      Styles.CardCaptionRow = cxStyle4
      Styles.CardRowCaption = cxStyle5
      Styles.Content = cxStyle6
      Styles.ContentEven = cxStyle7
      Styles.ContentOdd = cxStyle8
      Styles.FilterBar = cxStyle9
      Styles.Footer = cxStyle10
      Styles.Group = cxStyle11
      Styles.Header = cxStyle12
      Styles.Preview = cxStyle13
      Styles.Selection = cxStyle14
      BuiltIn = True
    end
  end
  object gridPrinter: TdxComponentPrinter
    CurrentLink = grdPrinterLinkPayments
    Version = 0
    Left = 240
    Top = 248
    object grdPrinterLinkPayments: TdxGridReportLink
      Active = True
      Component = grDataPayments
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 6350
      PrinterPage.Margins.Left = 5000
      PrinterPage.Margins.Right = 5000
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 42642.699096053240000000
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clBlack
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Arial'
      ReportTitle.Font.Style = [fsBold]
      ShrinkToPageWidth = True
      AssignedFormatValues = [fvTime, fvPageNumber]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      OptionsExpanding.ExpandGroupRows = True
      OptionsFormatting.LookAndFeelKind = lfFlat
      OptionsFormatting.UseNativeStyles = True
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsView.FilterBar = False
      StyleRepository = cxStyleRepository2
      Styles.StyleSheet = dxGridReportLinkStyleSheet1
      BuiltInReportLink = True
    end
    object grdPrinterLinkRevenues: TdxGridReportLink
      Active = True
      Component = grDataRevenues
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 6350
      PrinterPage.Margins.Left = 5000
      PrinterPage.Margins.Right = 5000
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 42642.695390497680000000
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clBlack
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Arial'
      ReportTitle.Font.Style = [fsBold]
      ShrinkToPageWidth = True
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      OptionsExpanding.ExpandGroupRows = True
      OptionsFormatting.LookAndFeelKind = lfFlat
      OptionsFormatting.UseNativeStyles = True
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsView.FilterBar = False
      StyleRepository = cxStyleRepository2
      Styles.StyleSheet = dxGridReportLinkStyleSheet1
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
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'grdPrinterLinkAll'
      ReportDocument.CreationDate = 42642.693297916670000000
      ShrinkToPageWidth = True
      Items = <
        item
          ReportLink = grdPrinterLinkPayments
          BuiltInCompositionItem = True
        end
        item
          ReportLink = grdPrinterLinkRevenues
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
    Indexes = <>
    SortOptions = []
    Left = 512
    Top = 264
    object m_Revenuesdate: TDateField
      FieldName = 'date'
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
end
