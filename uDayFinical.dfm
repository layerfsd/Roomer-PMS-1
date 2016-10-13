object frmDayFinical: TfrmDayFinical
  Left = 822
  Top = 210
  Caption = 'Finance Report'
  ClientHeight = 710
  ClientWidth = 1011
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LMDStatusBar1: TStatusBar
    Left = 0
    Top = 691
    Width = 1011
    Height = 19
    Panels = <>
  end
  object LMDSimplePanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1011
    Height = 135
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object labLocations: TsLabel
      AlignWithMargins = True
      Left = 657
      Top = 14
      Width = 148
      Height = 25
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Locations :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object __labLocationsList: TsLabel
      Left = 811
      Top = 14
      Width = 22
      Height = 19
      Caption = 'All'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object btnRefresh: TsButton
      Left = 551
      Top = 58
      Width = 100
      Height = 28
      Caption = 'Refresh'
      Default = True
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object GroupBox1: TsGroupBox
      Left = 274
      Top = 6
      Width = 271
      Height = 80
      Caption = '.. or Unconfirmed'
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object chkGetUnconfirmed: TsCheckBox
        Left = 21
        Top = 18
        Width = 99
        Height = 20
        Caption = 'Get unconfirmed'
        TabOrder = 0
        OnClick = chkGetUnconfirmedClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object btnConfirm: TsButton
        Left = 21
        Top = 50
        Width = 100
        Height = 25
        Caption = 'Confirm now'
        ImageIndex = 82
        Images = DImages.PngImageList1
        TabOrder = 1
        Visible = False
        OnClick = btnConfirmClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object getConfirmGroup: TsButton
      Left = 551
      Top = 13
      Width = 100
      Height = 42
      Caption = 'Get Selected confirm group'
      TabOrder = 3
      OnClick = getConfirmGroupClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnSwitchToDates: TsButton
      Left = 33
      Top = 60
      Width = 120
      Height = 20
      Caption = 'Switch to dates'
      TabOrder = 4
      OnClick = btnSwitchToDatesClick
      SkinData.SkinSection = 'BUTTON'
    end
    object gbxSelectDates: TsGroupBox
      Left = 11
      Top = 6
      Width = 257
      Height = 80
      Caption = 'Select Dates'
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object LMDSimpleLabel1: TsLabel
        Left = 67
        Top = 15
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'Date from :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object LMDSimpleLabel2: TsLabel
        Left = 79
        Top = 42
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Date to :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object dtDate: TsDateEdit
        Left = 128
        Top = 12
        Width = 121
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
        Text = '25-12-2012'
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        Date = 41268.000000000000000000
      end
      object dtDateTo: TsDateEdit
        Left = 128
        Top = 39
        Width = 121
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
        Text = '25-12-2012'
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        Date = 41268.000000000000000000
      end
      object chkOneday: TsCheckBox
        Left = 3
        Top = 60
        Width = 61
        Height = 20
        Caption = 'One day'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = chkOnedayClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object pnlButtons: TsPanel
      Left = 0
      Top = 92
      Width = 1011
      Height = 43
      Align = alBottom
      FullRepaint = False
      TabOrder = 5
      SkinData.SkinSection = 'PANEL'
      object cxButton3: TsButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 128
        Height = 35
        Align = alLeft
        Caption = 'Excel'
        ImageIndex = 115
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = btnExcel
        SkinData.SkinSection = 'BUTTON'
      end
      object btnPrint: TsButton
        AlignWithMargins = True
        Left = 138
        Top = 4
        Width = 128
        Height = 35
        Align = alLeft
        Caption = 'Print'
        ImageIndex = 3
        Images = DImages.PngImageList1
        TabOrder = 1
        OnClick = btnPrintClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnShowReservation: TsButton
        AlignWithMargins = True
        Left = 272
        Top = 4
        Width = 128
        Height = 35
        Align = alLeft
        Caption = 'Reservaton'
        ImageIndex = 56
        Images = DImages.PngImageList1
        TabOrder = 2
        OnClick = btnShowReservationClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnShowGuests: TsButton
        AlignWithMargins = True
        Left = 406
        Top = 4
        Width = 128
        Height = 35
        Align = alLeft
        Caption = 'Guests'
        ImageIndex = 39
        Images = DImages.PngImageList1
        TabOrder = 3
        OnClick = btnShowGuestsClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnShowSelectedInvoice: TsButton
        AlignWithMargins = True
        Left = 540
        Top = 4
        Width = 128
        Height = 35
        Align = alLeft
        Caption = 'Invoice'
        ImageIndex = 63
        Images = DImages.PngImageList1
        TabOrder = 4
        OnClick = btnShowSelectedInvoiceClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnShowInvoice: TsButton
        AlignWithMargins = True
        Left = 674
        Top = 4
        Width = 128
        Height = 35
        Align = alLeft
        Caption = 'Invoices'
        DropDownMenu = mnuFinishedInv
        ImageIndex = 63
        Images = DImages.PngImageList1
        Style = bsSplitButton
        TabOrder = 5
        AnimatEvents = [aeMouseEnter, aeGlobalDef]
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object mainPage: TsPageControl
    Left = 0
    Top = 135
    Width = 1011
    Height = 556
    ActivePage = SheetInvoicelist
    Align = alClient
    Style = tsFlatButtons
    TabHeight = 25
    TabOrder = 2
    TabWidth = 120
    OnChange = mainPageChange
    SkinData.SkinSection = 'PAGECONTROL'
    object sheetSums: TsTabSheet
      Caption = 'Sums'
      ImageIndex = 4
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel9: TsPanel
        Left = 265
        Top = 0
        Width = 738
        Height = 521
        Align = alClient
        Caption = 'Panel6'
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object Panel10: TsPanel
          Left = 1
          Top = 1
          Width = 736
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
        end
        object pageSums: TsPageControl
          Left = 1
          Top = 23
          Width = 736
          Height = 497
          ActivePage = sheetSums2
          Align = alClient
          TabOrder = 1
          SkinData.SkinSection = 'PAGECONTROL'
          object sheetSums2: TsTabSheet
            Caption = 'Sale type / paymentgroup'
            SkinData.CustomColor = False
            SkinData.CustomFont = False
            object grSums2: TcxGrid
              Left = 0
              Top = 0
              Width = 728
              Height = 469
              Align = alClient
              TabOrder = 0
              LookAndFeel.NativeStyle = False
              object tvSums2: TcxGridDBTableView
                Navigator.Buttons.CustomButtons = <>
                Navigator.Buttons.First.Visible = True
                Navigator.Buttons.PriorPage.Visible = True
                Navigator.Buttons.Prior.Visible = True
                Navigator.Buttons.Next.Visible = True
                Navigator.Buttons.NextPage.Visible = True
                Navigator.Buttons.Last.Visible = True
                Navigator.Buttons.Insert.Enabled = False
                Navigator.Buttons.Insert.Visible = False
                Navigator.Buttons.Append.Enabled = False
                Navigator.Buttons.Append.Visible = False
                Navigator.Buttons.Delete.Enabled = False
                Navigator.Buttons.Delete.Visible = False
                Navigator.Buttons.Edit.Enabled = False
                Navigator.Buttons.Edit.Visible = False
                Navigator.Buttons.Post.Enabled = False
                Navigator.Buttons.Post.Visible = False
                Navigator.Buttons.Cancel.Enabled = False
                Navigator.Buttons.Cancel.Visible = True
                Navigator.Buttons.Refresh.Visible = True
                Navigator.Buttons.SaveBookmark.Visible = True
                Navigator.Buttons.GotoBookmark.Visible = True
                Navigator.Buttons.Filter.Visible = True
                FilterBox.Visible = fvNever
                DataController.DataSource = mSums2DS
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'Payment'
                    Column = tvSums2Payment
                  end
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'Sale'
                    Column = tvSums2Sale
                  end>
                DataController.Summary.SummaryGroups = <>
                OptionsBehavior.IncSearch = True
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsView.Footer = True
                OptionsView.FooterAutoHeight = True
                OptionsView.FooterMultiSummaries = True
                OptionsView.GroupByBox = False
                OptionsView.Indicator = True
                object tvSums2RecId: TcxGridDBColumn
                  DataBinding.FieldName = 'RecId'
                  Visible = False
                end
                object tvSums2id: TcxGridDBColumn
                  DataBinding.FieldName = 'id'
                  Visible = False
                  Options.Editing = False
                  Options.Filtering = False
                  Options.FilteringFilteredItemsList = False
                  Options.FilteringMRUItemsList = False
                  Options.FilteringPopup = False
                  Options.FilteringPopupMultiSelect = False
                  Options.GroupFooters = False
                  Options.Grouping = False
                  Options.Moving = False
                end
                object tvSums2Code: TcxGridDBColumn
                  DataBinding.FieldName = 'Code'
                  Options.Editing = False
                  Options.Filtering = False
                  Options.FilteringFilteredItemsList = False
                  Options.FilteringMRUItemsList = False
                  Options.FilteringPopup = False
                  Options.FilteringPopupMultiSelect = False
                  Options.Moving = False
                  Width = 66
                end
                object tvSums2Description: TcxGridDBColumn
                  DataBinding.FieldName = 'Description'
                  Options.Editing = False
                  Options.Filtering = False
                  Options.FilteringFilteredItemsList = False
                  Options.FilteringMRUItemsList = False
                  Options.FilteringPopup = False
                  Options.FilteringPopupMultiSelect = False
                  Options.Moving = False
                  Width = 162
                end
                object tvSums2Sale: TcxGridDBColumn
                  DataBinding.FieldName = 'Sale'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  OnGetProperties = GetNativeCurrencyProperties
                  Options.Editing = False
                  Options.Filtering = False
                  Options.FilteringFilteredItemsList = False
                  Options.FilteringMRUItemsList = False
                  Options.FilteringPopupMultiSelect = False
                  Options.Moving = False
                  Width = 88
                end
                object tvSums2Payment: TcxGridDBColumn
                  DataBinding.FieldName = 'Payment'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  OnGetProperties = GetNativeCurrencyProperties
                  Options.Editing = False
                  Options.Filtering = False
                  Options.FilteringFilteredItemsList = False
                  Options.FilteringMRUItemsList = False
                  Options.FilteringPopup = False
                  Options.FilteringPopupMultiSelect = False
                  Options.Moving = False
                  Width = 84
                end
              end
              object lvSums2: TcxGridLevel
                GridView = tvSums2
                Options.DetailTabsPosition = dtpTop
              end
            end
          end
          object sheetSums3: TsTabSheet
            Caption = 'Sale item / payment type'
            ImageIndex = 1
            SkinData.CustomColor = False
            SkinData.CustomFont = False
            object grSums: TcxGrid
              Left = 0
              Top = 0
              Width = 728
              Height = 469
              Align = alClient
              TabOrder = 0
              LookAndFeel.NativeStyle = False
              object tvSums: TcxGridDBTableView
                Navigator.Buttons.CustomButtons = <>
                Navigator.Buttons.First.Visible = True
                Navigator.Buttons.PriorPage.Visible = True
                Navigator.Buttons.Prior.Visible = True
                Navigator.Buttons.Next.Visible = True
                Navigator.Buttons.NextPage.Visible = True
                Navigator.Buttons.Last.Visible = True
                Navigator.Buttons.Insert.Enabled = False
                Navigator.Buttons.Insert.Visible = False
                Navigator.Buttons.Append.Enabled = False
                Navigator.Buttons.Append.Visible = False
                Navigator.Buttons.Delete.Enabled = False
                Navigator.Buttons.Delete.Visible = False
                Navigator.Buttons.Edit.Enabled = False
                Navigator.Buttons.Edit.Visible = False
                Navigator.Buttons.Post.Enabled = False
                Navigator.Buttons.Post.Visible = False
                Navigator.Buttons.Cancel.Enabled = False
                Navigator.Buttons.Cancel.Visible = True
                Navigator.Buttons.Refresh.Visible = True
                Navigator.Buttons.SaveBookmark.Visible = True
                Navigator.Buttons.GotoBookmark.Visible = True
                Navigator.Buttons.Filter.Visible = True
                DataController.DataSource = mSumsDS
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'Payment'
                    Column = tvSumsPayment
                  end
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'Sale'
                    Column = tvSumsSale
                  end>
                DataController.Summary.SummaryGroups = <>
                OptionsBehavior.IncSearch = True
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsView.Footer = True
                OptionsView.FooterAutoHeight = True
                OptionsView.FooterMultiSummaries = True
                OptionsView.GroupByBox = False
                OptionsView.Indicator = True
                object tvSumsid: TcxGridDBColumn
                  DataBinding.FieldName = 'id'
                  Visible = False
                end
                object tvSumsCode: TcxGridDBColumn
                  DataBinding.FieldName = 'Code'
                  Width = 85
                end
                object tvSumsDescription: TcxGridDBColumn
                  DataBinding.FieldName = 'Description'
                  Width = 151
                end
                object tvSumsSale: TcxGridDBColumn
                  DataBinding.FieldName = 'Sale'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  OnGetProperties = GetNativeCurrencyProperties
                  Width = 84
                end
                object tvSumsPayment: TcxGridDBColumn
                  DataBinding.FieldName = 'Payment'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  OnGetProperties = GetNativeCurrencyProperties
                  Width = 84
                end
              end
              object lvSums: TcxGridLevel
                GridView = tvSums
              end
            end
          end
        end
      end
      object Panel11: TsPanel
        Left = 0
        Top = 0
        Width = 265
        Height = 521
        Align = alLeft
        Caption = 'Panel11'
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object Panel12: TsPanel
          Left = 1
          Top = 1
          Width = 263
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
        end
        object cxDBVerticalGrid1: TcxDBVerticalGrid
          Left = 1
          Top = 23
          Width = 263
          Height = 497
          Align = alClient
          LookAndFeel.NativeStyle = False
          OptionsView.RowHeaderWidth = 147
          Navigator.Buttons.CustomButtons = <>
          TabOrder = 1
          DataController.DataSource = mHeadDS
          Version = 1
          object cxDBVerticalGrid1RecId: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'RecId'
            Visible = False
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxDBVerticalGrid1CategoryRow1: TcxCategoryRow
            Properties.Caption = 'Head'
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxDBVerticalGrid1Company: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'Company'
            ID = 2
            ParentID = 1
            Index = 0
            Version = 1
          end
          object cxDBVerticalGrid1Staff: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'Staff'
            ID = 3
            ParentID = 1
            Index = 1
            Version = 1
          end
          object cxDBVerticalGrid1DateFrom: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'DateFrom'
            ID = 4
            ParentID = 1
            Index = 2
            Version = 1
          end
          object cxDBVerticalGrid1DateTo: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'DateTo'
            ID = 5
            ParentID = 1
            Index = 3
            Version = 1
          end
          object cxDBVerticalGrid1DateCount: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'DateCount'
            ID = 6
            ParentID = 1
            Index = 4
            Version = 1
          end
          object cxDBVerticalGrid1CategoryRow2: TcxCategoryRow
            Properties.Caption = 'Sale'
            ID = 7
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxDBVerticalGrid1InvoiceCount: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'InvoiceCount'
            ID = 8
            ParentID = 7
            Index = 0
            Version = 1
          end
          object cxDBVerticalGrid1SaleAmount: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
            Properties.DataBinding.FieldName = 'SaleAmount'
            ID = 9
            ParentID = 7
            Index = 1
            Version = 1
          end
          object cxDBVerticalGrid1SaleAmountWoVAT: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
            Properties.DataBinding.FieldName = 'SaleAmountWoVAT'
            ID = 10
            ParentID = 7
            Index = 2
            Version = 1
          end
          object cxDBVerticalGrid1VATAmount: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
            Properties.DataBinding.FieldName = 'VATAmount'
            ID = 11
            ParentID = 7
            Index = 3
            Version = 1
          end
          object cxDBVerticalGrid1SalePerDay: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
            Properties.DataBinding.FieldName = 'SalePerDay'
            ID = 12
            ParentID = 7
            Index = 4
            Version = 1
          end
          object cxDBVerticalGrid1SalePerInvoice: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
            Properties.DataBinding.FieldName = 'SalePerInvoice'
            ID = 13
            ParentID = 7
            Index = 5
            Version = 1
          end
          object cxDBVerticalGrid1CategoryRow3: TcxCategoryRow
            Properties.Caption = 'Payments'
            ID = 14
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxDBVerticalGrid1PaymentCount: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'PaymentCount'
            ID = 15
            ParentID = 14
            Index = 0
            Version = 1
          end
          object cxDBVerticalGrid1PaymentAmount: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
            Properties.DataBinding.FieldName = 'PaymentAmount'
            ID = 16
            ParentID = 14
            Index = 1
            Version = 1
          end
          object cxDBVerticalGrid1CategoryRow4: TcxCategoryRow
            Properties.Caption = 'Logding Tax'
            ID = 17
            ParentID = -1
            Index = 4
            Version = 1
          end
          object cxDBVerticalGrid1LodgingNights: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'LodgingNights'
            ID = 18
            ParentID = 17
            Index = 0
            Version = 1
          end
          object cxDBVerticalGrid1LodgingTax: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
            Properties.DataBinding.FieldName = 'LodgingTax'
            ID = 19
            ParentID = 17
            Index = 1
            Version = 1
          end
          object cxDBVerticalGrid1CategoryRow5: TcxCategoryRow
            Properties.Caption = 'Invoice categories'
            ID = 20
            ParentID = -1
            Index = 5
            Version = 1
          end
          object cxDBVerticalGrid1GroupInvoiceCount: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'GroupInvoiceCount'
            ID = 21
            ParentID = 20
            Index = 0
            Version = 1
          end
          object cxDBVerticalGrid1RoomInvoiceCount: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'RoomInvoiceCount'
            ID = 22
            ParentID = 20
            Index = 1
            Version = 1
          end
          object cxDBVerticalGrid1CashInvoiceCount: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'CashInvoiceCount'
            ID = 23
            ParentID = 20
            Index = 2
            Version = 1
          end
          object cxDBVerticalGrid1KeditInvoiceCount: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'KeditInvoiceCount'
            ID = 24
            ParentID = 20
            Index = 3
            Version = 1
          end
        end
      end
    end
    object SheetInvoicelist: TsTabSheet
      Caption = 'Sale - Invoice'
      ImageIndex = 3
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel4: TsPanel
        Left = 0
        Top = 0
        Width = 1003
        Height = 35
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object cxButton1: TsButton
          AlignWithMargins = True
          Left = 85
          Top = 4
          Width = 75
          Height = 27
          Align = alLeft
          Caption = 'expand all'
          TabOrder = 0
          OnClick = cxButton1Click
          SkinData.SkinSection = 'BUTTON'
        end
        object cxButton2: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 75
          Height = 27
          Align = alLeft
          Caption = 'Contract all'
          TabOrder = 1
          OnClick = cxButton2Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grInvoicelist: TcxGrid
        Left = 0
        Top = 35
        Width = 1003
        Height = 486
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvInvoiceHeads: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mInvoiceHeadsDS
          DataController.DetailKeyFieldNames = 'InvoiceNumber'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'ihAmountWithTax'
              Column = tvInvoiceHeadsihAmountWithTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'ihAmountNoTax'
              Column = tvInvoiceHeadsihAmountNoTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'ihAmountTax'
              Column = tvInvoiceHeadsihAmountTax
            end
            item
              Kind = skCount
              FieldName = 'InvoiceNumber'
              Column = tvInvoiceHeadsInvoiceNumber
            end
            item
              Format = '###0.;###0.'
              Kind = skSum
              FieldName = 'isKredit'
              Column = tvInvoiceHeadsisKredit
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalStayTax'
              Column = tvInvoiceHeadsTotalStayTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalStayTaxNights'
              Column = tvInvoiceHeadsTotalStayTaxNights
            end
            item
              Format = '###0.;###0.'
              Kind = skSum
              FieldName = 'isCash'
              Column = tvInvoiceHeadsisCash
            end
            item
              Format = '###0.;###0.'
              Kind = skSum
              FieldName = 'isGroup'
              Column = tvInvoiceHeadsisGroup
            end
            item
              Format = '###0.;###0.'
              Kind = skSum
              FieldName = 'isRoom'
              Column = tvInvoiceHeadsisRoom
            end
            item
              Kind = skCount
              FieldName = 'Reservation'
              Column = tvInvoiceHeadsReservation
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterAutoHeight = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.Indicator = True
          object tvInvoiceHeadsRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvInvoiceHeadsInvoiceNumber: TcxGridDBColumn
            Caption = 'Number'
            DataBinding.FieldName = 'InvoiceNumber'
            Width = 48
          end
          object tvInvoiceHeadsInvoiceDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'InvoiceDate'
            Width = 77
          end
          object tvInvoiceHeadsihAmountWithTax: TcxGridDBColumn
            Caption = 'Amount'
            DataBinding.FieldName = 'ihAmountWithTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 84
          end
          object tvInvoiceHeadsihAmountNoTax: TcxGridDBColumn
            Caption = 'W/O VAT'
            DataBinding.FieldName = 'ihAmountNoTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 70
          end
          object tvInvoiceHeadsihAmountTax: TcxGridDBColumn
            Caption = 'VAT'
            DataBinding.FieldName = 'ihAmountTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 72
          end
          object tvInvoiceHeadsCustomer: TcxGridDBColumn
            DataBinding.FieldName = 'Customer'
            Width = 90
          end
          object tvInvoiceHeadsCustomerName: TcxGridDBColumn
            Caption = 'Customer Name'
            DataBinding.FieldName = 'CustomerName'
            Width = 140
          end
          object tvInvoiceHeadsNameOnInvoice: TcxGridDBColumn
            Caption = 'Name on Invoice'
            DataBinding.FieldName = 'NameOnInvoice'
            Width = 140
          end
          object tvInvoiceHeadsAddress1: TcxGridDBColumn
            DataBinding.FieldName = 'Address1'
            Width = 100
          end
          object tvInvoiceHeadsAddress2: TcxGridDBColumn
            DataBinding.FieldName = 'Address2'
            Width = 100
          end
          object tvInvoiceHeadsAddress3: TcxGridDBColumn
            DataBinding.FieldName = 'Address3'
            Width = 100
          end
          object tvInvoiceHeadsRoomGuest: TcxGridDBColumn
            Caption = 'Roomguest'
            DataBinding.FieldName = 'RoomGuest'
            Width = 112
          end
          object tvInvoiceHeadsisAgency: TcxGridDBColumn
            Caption = 'Agency'
            DataBinding.FieldName = 'isAgency'
          end
          object tvInvoiceHeadsisKredit: TcxGridDBColumn
            DataBinding.FieldName = 'isKredit'
          end
          object tvInvoiceHeadsisRoom: TcxGridDBColumn
            DataBinding.FieldName = 'isRoom'
          end
          object tvInvoiceHeadsisGroup: TcxGridDBColumn
            DataBinding.FieldName = 'isGroup'
          end
          object tvInvoiceHeadsisCash: TcxGridDBColumn
            DataBinding.FieldName = 'isCash'
          end
          object tvInvoiceHeadsdueDate: TcxGridDBColumn
            Caption = 'Due date'
            DataBinding.FieldName = 'dueDate'
            Width = 88
          end
          object tvInvoiceHeadsinvRefrence: TcxGridDBColumn
            Caption = 'Reference'
            DataBinding.FieldName = 'invRefrence'
            Width = 63
          end
          object tvInvoiceHeadsCreditInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'CreditInvoice'
            Width = 77
          end
          object tvInvoiceHeadsOriginalInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'OriginalInvoice'
            Width = 69
          end
          object tvInvoiceHeadsReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
            Width = 75
          end
          object tvInvoiceHeadsRoomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'RoomReservation'
            Visible = False
            Width = 72
          end
          object tvInvoiceHeadsSplitNumber: TcxGridDBColumn
            DataBinding.FieldName = 'SplitNumber'
            Visible = False
          end
          object tvInvoiceHeadsTotalStayTax: TcxGridDBColumn
            Caption = 'Lodging Tax'
            DataBinding.FieldName = 'TotalStayTax'
          end
          object tvInvoiceHeadsTotalStayTaxNights: TcxGridDBColumn
            Caption = 'Lodging Nights'
            DataBinding.FieldName = 'TotalStayTaxNights'
          end
          object tvInvoiceHeadsConfirmedDate: TcxGridDBColumn
            DataBinding.FieldName = 'ConfirmedDate'
          end
          object tvInvoiceHeadsCurrency: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
          end
          object tvInvoiceHeadsRate: TcxGridDBColumn
            DataBinding.FieldName = 'Rate'
          end
          object tvInvoiceHeadsStaff: TcxGridDBColumn
            DataBinding.FieldName = 'Staff'
          end
          object tvInvoiceHeadsmarkedSegment: TcxGridDBColumn
            DataBinding.FieldName = 'markedSegment'
          end
          object tvInvoiceHeadsmarkedSegmentDescription: TcxGridDBColumn
            DataBinding.FieldName = 'markedSegmentDescription'
          end
        end
        object tvInvoiceLines: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mInvoiceLinesDS
          DataController.DetailKeyFieldNames = 'InvoiceNumber'
          DataController.KeyFieldNames = 'InvoiceNumber'
          DataController.MasterKeyFieldNames = 'InvoiceNumber'
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              FieldName = 'AmountWithTax'
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountWithTax'
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountNoTax'
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountTax'
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skCount
              FieldName = 'Item'
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object tvInvoiceLinesRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvInvoiceLinesItem: TcxGridDBColumn
            DataBinding.FieldName = 'Item'
            Width = 80
          end
          object tvInvoiceLinesDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 120
          end
          object tvInvoiceLinesQuantity: TcxGridDBColumn
            DataBinding.FieldName = 'Quantity'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Width = 48
          end
          object tvInvoiceLinesPrice: TcxGridDBColumn
            DataBinding.FieldName = 'Price'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
          end
          object tvInvoiceLinesVATType: TcxGridDBColumn
            DataBinding.FieldName = 'VATType'
          end
          object tvInvoiceLinesilAmountWithTax: TcxGridDBColumn
            DataBinding.FieldName = 'AmountWithTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
          end
          object tvInvoiceLinesilAmountNoTax: TcxGridDBColumn
            DataBinding.FieldName = 'AmountNoTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
          end
          object tvInvoiceLinesilAmountTax: TcxGridDBColumn
            DataBinding.FieldName = 'AmountTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
          end
          object tvInvoiceLinesCurrency: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
          end
          object tvInvoiceLinesCurrencyRate: TcxGridDBColumn
            DataBinding.FieldName = 'CurrencyRate'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
          end
          object tvInvoiceLinesImportRefrence: TcxGridDBColumn
            DataBinding.FieldName = 'ImportRefrence'
            Width = 72
          end
          object tvInvoiceLinesPurchaseDate: TcxGridDBColumn
            DataBinding.FieldName = 'PurchaseDate'
          end
          object tvInvoiceLinesImportSource: TcxGridDBColumn
            DataBinding.FieldName = 'ImportSource'
            Width = 64
          end
          object tvInvoiceLinesInvoiceNumber: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceNumber'
            Visible = False
          end
        end
        object lvInvoiceHeads: TcxGridLevel
          GridView = tvInvoiceHeads
          object lvInvoiceLines: TcxGridLevel
            GridView = tvInvoiceLines
          end
        end
      end
    end
    object sheetItemSale: TsTabSheet
      Caption = 'Sale - Item'
      ImageIndex = 2
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel3: TsPanel
        Left = 0
        Top = 0
        Width = 1003
        Height = 22
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
      object grItemSale: TcxGrid
        Left = 0
        Top = 22
        Width = 1003
        Height = 499
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvItemSale: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mItemSaleDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Total'
              Column = tvItemSaleTotal
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalWoVat'
              Column = tvItemSaleTotalWoVat
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalVat'
              Column = tvItemSaleTotalVat
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterAutoHeight = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.Indicator = True
          object tvItemSaleItem: TcxGridDBColumn
            DataBinding.FieldName = 'Item'
          end
          object tvItemSaleDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 168
          end
          object tvItemSaleItemCount: TcxGridDBColumn
            Caption = 'Count'
            DataBinding.FieldName = 'ItemCount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
          end
          object tvItemSaleTotal: TcxGridDBColumn
            DataBinding.FieldName = 'Total'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 101
          end
          object tvItemSaleTotalWoVat: TcxGridDBColumn
            DataBinding.FieldName = 'TotalWoVat'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 97
          end
          object tvItemSaleTotalVat: TcxGridDBColumn
            Caption = 'VAT'
            DataBinding.FieldName = 'TotalVat'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 75
          end
          object tvItemSaleItemType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'ItemType'
            Width = 86
          end
          object tvItemSaleItemTypeDescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'ItemTypeDescription'
            Width = 129
          end
          object tvItemSaleVATCode: TcxGridDBColumn
            Caption = 'VAT code'
            DataBinding.FieldName = 'VATCode'
          end
          object tvItemSaleAccountKey: TcxGridDBColumn
            DataBinding.FieldName = 'AccountKey'
            Width = 122
          end
        end
        object lvItemSale: TcxGridLevel
          GridView = tvItemSale
        end
      end
    end
    object sheetItemTypeSale: TsTabSheet
      Caption = 'Sale - Itemtype'
      ImageIndex = 5
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel7: TsPanel
        Left = 0
        Top = 0
        Width = 1003
        Height = 22
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
      object grItemTypeSale: TcxGrid
        Left = 0
        Top = 22
        Width = 1003
        Height = 499
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvItemTypeSale: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mItemTypeSaleDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Total'
              Column = tvItemTypeSaleTotal
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalWoVat'
              Column = tvItemTypeSaleTotalWoVat
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalVat'
              Column = tvItemTypeSaleTotalVat
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterAutoHeight = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.Indicator = True
          object tvItemTypeSaleRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvItemTypeSaleItemType: TcxGridDBColumn
            Caption = 'Itemtype'
            DataBinding.FieldName = 'ItemType'
            Width = 82
          end
          object tvItemTypeSaleItemTypeDescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'ItemTypeDescription'
            Width = 189
          end
          object tvItemTypeSaleItemCount: TcxGridDBColumn
            Caption = 'Count'
            DataBinding.FieldName = 'ItemCount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Width = 69
          end
          object tvItemTypeSaleTotal: TcxGridDBColumn
            DataBinding.FieldName = 'Total'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
          end
          object tvItemTypeSaleTotalWoVat: TcxGridDBColumn
            Caption = 'Total W/O VAT'
            DataBinding.FieldName = 'TotalWoVat'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
          end
          object tvItemTypeSaleTotalVat: TcxGridDBColumn
            Caption = 'VAT'
            DataBinding.FieldName = 'TotalVat'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
          end
          object tvItemTypeSaleVATCode: TcxGridDBColumn
            Caption = 'VAT code'
            DataBinding.FieldName = 'VATCode'
          end
        end
        object lvItemTypeSale: TcxGridLevel
          GridView = tvItemTypeSale
        end
      end
    end
    object sheetItemVATsale: TsTabSheet
      Caption = 'Sale - VAT'
      ImageIndex = 7
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel13: TsPanel
        Left = 0
        Top = 0
        Width = 1003
        Height = 22
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
      object grItemVATsale: TcxGrid
        Left = 0
        Top = 22
        Width = 1003
        Height = 499
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvItemVATsale: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mItemVATsaleDS
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalVat'
              Column = tvItemVATsaleTotalVat
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Total'
              Column = tvItemVATsaleTotal
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalWoVat'
              Column = tvItemVATsaleTotalWoVat
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalVat'
              Column = tvItemVATsaleTotalVat
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterAutoHeight = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.Indicator = True
          object tvItemVATsaleRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvItemVATsaleVATCode: TcxGridDBColumn
            Caption = 'Code'
            DataBinding.FieldName = 'VATCode'
          end
          object tvItemVATsaleDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
          end
          object tvItemVATsaleTotal: TcxGridDBColumn
            DataBinding.FieldName = 'Total'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 82
          end
          object tvItemVATsaleTotalWoVat: TcxGridDBColumn
            Caption = 'Without VAT'
            DataBinding.FieldName = 'TotalWoVat'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 88
          end
          object tvItemVATsaleTotalVat: TcxGridDBColumn
            Caption = 'VAT'
            DataBinding.FieldName = 'TotalVat'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 88
          end
          object tvItemVATsaleVATPercentage: TcxGridDBColumn
            DataBinding.FieldName = 'VATPercentage'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00%;-#,##0.00%'
          end
          object tvItemVATsaleItemCount: TcxGridDBColumn
            Caption = 'Items'
            DataBinding.FieldName = 'ItemCount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
          end
        end
        object lvItemVATsale: TcxGridLevel
          GridView = tvItemVATsale
        end
      end
    end
    object sheetPayments: TsTabSheet
      Caption = 'Payments - Invoice'
      ImageIndex = 4
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel5: TsPanel
        Left = 0
        Top = 0
        Width = 1003
        Height = 41
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnPaymentReport: TsButton
          Left = 1
          Top = 4
          Width = 100
          Height = 35
          Caption = 'Report'
          ImageIndex = 69
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnPaymentReportClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grPayments: TcxGrid
        Left = 0
        Top = 41
        Width = 1003
        Height = 480
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvPayments: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mPaymentsDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Amount'
              Column = tvPaymentsAmount
            end
            item
              Kind = skCount
              FieldName = 'InvoiceNumber'
              Column = tvPaymentsInvoiceNumber
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterAutoHeight = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.Indicator = True
          object tvPaymentsRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvPaymentsInvoiceNumber: TcxGridDBColumn
            Caption = 'Invoice'
            DataBinding.FieldName = 'InvoiceNumber'
          end
          object tvPaymentsInvoiceDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'InvoiceDate'
          end
          object tvPaymentsAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 77
          end
          object tvPaymentsPayTypeDescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'PayTypeDescription'
          end
          object tvPaymentspayGroupDescription: TcxGridDBColumn
            Caption = 'Group Description'
            DataBinding.FieldName = 'payGroupDescription'
          end
          object tvPaymentsCustomer: TcxGridDBColumn
            DataBinding.FieldName = 'Customer'
          end
          object tvPaymentsCurrency: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
            Width = 41
          end
          object tvPaymentsCurrencyRate: TcxGridDBColumn
            Caption = 'Rate'
            DataBinding.FieldName = 'CurrencyRate'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
          end
          object tvPaymentscurrencyAmount: TcxGridDBColumn
            DataBinding.FieldName = 'currencyAmount'
          end
          object tvPaymentsPayType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'PayType'
            Visible = False
          end
          object tvPaymentsPayGroup: TcxGridDBColumn
            Caption = 'Group'
            DataBinding.FieldName = 'PayGroup'
            Visible = False
          end
          object tvPaymentsReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
            Visible = False
          end
          object tvPaymentsRoomReservation: TcxGridDBColumn
            Caption = 'Room Reservation'
            DataBinding.FieldName = 'RoomReservation'
            Visible = False
          end
          object tvPaymentsPayDate: TcxGridDBColumn
            DataBinding.FieldName = 'PayDate'
          end
          object tvPaymentsNameOnInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'NameOnInvoice'
            Width = 120
          end
          object tvPaymentsihConfirmDate: TcxGridDBColumn
            DataBinding.FieldName = 'ihConfirmDate'
            Width = 87
          end
          object tvPaymentsSplitNumber: TcxGridDBColumn
            DataBinding.FieldName = 'SplitNumber'
            Visible = False
          end
          object tvPaymentsRoomGuest: TcxGridDBColumn
            DataBinding.FieldName = 'RoomGuest'
            Width = 120
          end
          object tvPaymentsCustomerName: TcxGridDBColumn
            DataBinding.FieldName = 'CustomerName'
            Width = 120
          end
          object tvPaymentsisAgency: TcxGridDBColumn
            DataBinding.FieldName = 'isAgency'
          end
          object tvPaymentsisRoom: TcxGridDBColumn
            DataBinding.FieldName = 'isRoom'
          end
          object tvPaymentsisGroup: TcxGridDBColumn
            DataBinding.FieldName = 'isGroup'
          end
          object tvPaymentsisKredit: TcxGridDBColumn
            DataBinding.FieldName = 'isKredit'
          end
          object tvPaymentsisCash: TcxGridDBColumn
            DataBinding.FieldName = 'isCash'
          end
          object tvPaymentsaDate: TcxGridDBColumn
            DataBinding.FieldName = 'aDate'
          end
        end
        object lvPayments: TcxGridLevel
          GridView = tvPayments
        end
      end
    end
    object sheetPaymentType: TsTabSheet
      Caption = 'Payments - Paytype'
      ImageIndex = 3
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel1: TsPanel
        Left = 0
        Top = 0
        Width = 1003
        Height = 22
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
      object grPaymentType: TcxGrid
        Left = 0
        Top = 22
        Width = 1003
        Height = 499
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvPaymentType: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mPaymentTypesDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Amount'
              Column = tvPaymentTypeAmount
            end
            item
              Kind = skSum
              FieldName = 'InvoiceCount'
              Column = tvPaymentTypeInvoiceCount
            end
            item
              Kind = skSum
              FieldName = 'Customercount'
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.Indicator = True
          object tvPaymentTypeRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvPaymentTypePayType: TcxGridDBColumn
            Caption = 'Pay type'
            DataBinding.FieldName = 'PayType'
          end
          object tvPaymentTypePayTypeDescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'PayTypeDescription'
          end
          object tvPaymentTypeAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
          end
          object tvPaymentTypePayGroup: TcxGridDBColumn
            DataBinding.FieldName = 'PayGroup'
            Width = 54
          end
          object tvPaymentTypeInvoiceCount: TcxGridDBColumn
            Caption = 'Invoices'
            DataBinding.FieldName = 'InvoiceCount'
            Width = 77
          end
        end
        object lvPaymentType: TcxGridLevel
          GridView = tvPaymentType
        end
      end
    end
    object sheetPaymentGroups: TsTabSheet
      Caption = 'Payments - Paygroup'
      ImageIndex = 6
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel8: TsPanel
        Left = 0
        Top = 0
        Width = 1003
        Height = 22
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
      object grPaymentGroups: TcxGrid
        Left = 0
        Top = 22
        Width = 1003
        Height = 499
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvPaymentGroups: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mPaymentGroupsDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Amount'
              Column = tvPaymentGroupsAmount
            end
            item
              Kind = skSum
              FieldName = 'InvoiceCount'
              Column = tvPaymentGroupsInvoiceCount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.Indicator = True
          object tvPaymentGroupsRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvPaymentGroupsPayGroup: TcxGridDBColumn
            DataBinding.FieldName = 'PayGroup'
            Width = 73
          end
          object tvPaymentGroupsDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
          end
          object tvPaymentGroupsAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = GetNativeCurrencyProperties
            Width = 95
          end
          object tvPaymentGroupsInvoiceCount: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceCount'
            Width = 76
          end
        end
        object lvPaymentGroups: TcxGridLevel
          GridView = tvPaymentGroups
        end
      end
    end
  end
  object mItemSale: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 732
    Top = 193
    object mItemSaleItemCount: TFloatField
      FieldName = 'ItemCount'
    end
    object mItemSaleTotal: TFloatField
      FieldName = 'Total'
    end
    object mItemSaleTotalWoVat: TFloatField
      FieldName = 'TotalWoVat'
    end
    object mItemSaleTotalVat: TFloatField
      FieldName = 'TotalVat'
    end
    object mItemSaleDescription: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object mItemSaleAccountKey: TWideStringField
      FieldName = 'AccountKey'
      Size = 50
    end
    object mItemSaleItemType: TWideStringField
      FieldName = 'ItemType'
    end
    object mItemSaleItemTypeDescription: TWideStringField
      FieldName = 'ItemTypeDescription'
      Size = 30
    end
    object mItemSaleVATCode: TWideStringField
      FieldName = 'VATCode'
      Size = 10
    end
    object mItemSaleItem: TWideStringField
      FieldName = 'Item'
    end
  end
  object mItemSaleDS: TDataSource
    DataSet = mItemSale
    Left = 740
    Top = 249
  end
  object mInvoiceLines: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 752
    Top = 320
    object mInvoiceLinesPurchaseDate: TWideStringField
      FieldName = 'PurchaseDate'
      Size = 10
    end
    object mInvoiceLinesItem: TWideStringField
      FieldName = 'Item'
    end
    object mInvoiceLinesQuantity: TFloatField
      FieldName = 'Quantity'
    end
    object mInvoiceLinesDescription: TWideStringField
      FieldName = 'Description'
      Size = 100
    end
    object mInvoiceLinesPrice: TFloatField
      FieldName = 'Price'
    end
    object mInvoiceLinesVATType: TWideStringField
      FieldName = 'VATType'
      Size = 10
    end
    object mInvoiceLinesilAmountWithTax: TFloatField
      FieldName = 'AmountWithTax'
    end
    object mInvoiceLinesilAmountNoTax: TFloatField
      FieldName = 'AmountNoTax'
    end
    object mInvoiceLinesilAmountTax: TFloatField
      FieldName = 'AmountTax'
    end
    object mInvoiceLinesCurrency: TWideStringField
      FieldName = 'Currency'
      Size = 5
    end
    object mInvoiceLinesCurrencyRate: TFloatField
      FieldName = 'CurrencyRate'
    end
    object mInvoiceLinesImportRefrence: TWideStringField
      FieldName = 'ImportRefrence'
      Size = 30
    end
    object mInvoiceLinesImportSource: TWideStringField
      FieldName = 'ImportSource'
      Size = 30
    end
    object mInvoiceLinesInvoiceNumber: TIntegerField
      FieldName = 'InvoiceNumber'
    end
  end
  object mInvoiceHeads: TdxMemData
    Indexes = <>
    SortOptions = []
    OnCalcFields = mInvoiceHeadsCalcFields
    Left = 544
    Top = 312
    object mInvoiceHeadsReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mInvoiceHeadsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mInvoiceHeadsSplitNumber: TIntegerField
      FieldName = 'SplitNumber'
    end
    object mInvoiceHeadsInvoiceNumber: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object mInvoiceHeadsCustomer: TWideStringField
      FieldName = 'Customer'
      Size = 15
    end
    object mInvoiceHeadsNameOnInvoice: TWideStringField
      FieldName = 'NameOnInvoice'
      Size = 100
    end
    object mInvoiceHeadsAddress1: TWideStringField
      FieldName = 'Address1'
      Size = 100
    end
    object mInvoiceHeadsAddress2: TWideStringField
      FieldName = 'Address2'
      Size = 100
    end
    object mInvoiceHeadsAddress3: TWideStringField
      FieldName = 'Address3'
      Size = 100
    end
    object mInvoiceHeadsihAmountWithTax: TFloatField
      FieldName = 'ihAmountWithTax'
    end
    object mInvoiceHeadsihAmountNoTax: TFloatField
      FieldName = 'ihAmountNoTax'
    end
    object mInvoiceHeadsihAmountTax: TFloatField
      FieldName = 'ihAmountTax'
    end
    object mInvoiceHeadsCreditInvoice: TIntegerField
      FieldName = 'CreditInvoice'
    end
    object mInvoiceHeadsOriginalInvoice: TIntegerField
      FieldName = 'OriginalInvoice'
    end
    object mInvoiceHeadsRoomGuest: TWideStringField
      FieldName = 'RoomGuest'
      Size = 100
    end
    object mInvoiceHeadsInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
    end
    object mInvoiceHeadsdueDate: TDateTimeField
      FieldName = 'dueDate'
    end
    object mInvoiceHeadsinvRefrence: TWideStringField
      FieldName = 'invRefrence'
      Size = 30
    end
    object mInvoiceHeadsisKredit: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'isKredit'
      Calculated = True
    end
    object mInvoiceHeadsisGroup: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'isGroup'
      Calculated = True
    end
    object mInvoiceHeadsisCash: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'isCash'
      Calculated = True
    end
    object mInvoiceHeadsisRoom: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'isRoom'
      Calculated = True
    end
    object mInvoiceHeadsTotalStayTax: TFloatField
      FieldName = 'TotalStayTax'
    end
    object mInvoiceHeadsTotalStayTaxNights: TIntegerField
      FieldName = 'TotalStayTaxNights'
    end
    object mInvoiceHeadsConfirmedDate: TDateTimeField
      FieldName = 'ConfirmedDate'
    end
    object mInvoiceHeadsCurrency: TWideStringField
      FieldName = 'Currency'
      Size = 5
    end
    object mInvoiceHeadsRate: TFloatField
      FieldName = 'Rate'
    end
    object mInvoiceHeadsStaff: TWideStringField
      FieldName = 'Staff'
      Size = 5
    end
    object mInvoiceHeadsCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 100
    end
    object mInvoiceHeadsisAgency: TBooleanField
      FieldName = 'isAgency'
    end
    object mInvoiceHeadsmarkedSegment: TWideStringField
      FieldName = 'markedSegment'
      Size = 5
    end
    object mInvoiceHeadsmarkedSegmentDescription: TWideStringField
      FieldName = 'markedSegmentDescription'
      Size = 30
    end
  end
  object mInvoiceHeadsDS: TDataSource
    DataSet = mInvoiceHeads
    Left = 536
    Top = 360
  end
  object mInvoiceLinesDS: TDataSource
    DataSet = mInvoiceLines
    Left = 744
    Top = 376
  end
  object mPaymentsDS: TDataSource
    DataSet = mPayments
    Left = 164
    Top = 273
  end
  object mPaymentTypes: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 380
    Top = 345
    object mPaymentTypesInvoiceCount: TIntegerField
      FieldName = 'InvoiceCount'
    end
    object mPaymentTypesAmount: TFloatField
      FieldName = 'Amount'
    end
    object mPaymentTypesCustomercount: TIntegerField
      FieldName = 'Customercount'
    end
    object mPaymentTypesPayType: TWideStringField
      FieldName = 'PayType'
      Size = 10
    end
    object mPaymentTypesPayTypeDescription: TWideStringField
      FieldName = 'PayTypeDescription'
    end
    object mPaymentTypesPayGroup: TWideStringField
      FieldName = 'PayGroup'
      Size = 5
    end
  end
  object mPaymentTypesDS: TDataSource
    DataSet = mPaymentTypes
    Left = 420
    Top = 241
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = grPrinterSums2
    Version = 0
    Left = 960
    Top = 237
    object grPrinterSums2: TdxGridReportLink
      Active = True
      Component = grSums2
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 13200
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageFooter.CenterTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageFooter.LeftTitle.Strings = (
        '')
      PrinterPage.PageFooter.RightTitle.Strings = (
        '')
      PrinterPage.PageHeader.RightTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'Sums2'
      ReportDocument.CreationDate = 42655.583263449070000000
      ReportTitle.TextAlignX = taLeft
      BuiltInReportLink = True
    end
    object grPrinterSums: TdxGridReportLink
      Active = True
      Component = grSums
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 42655.583263460650000000
      BuiltInReportLink = True
    end
    object grPrinterInvoicelist: TdxGridReportLink
      Component = grInvoicelist
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'Sums2'
      BuiltInReportLink = True
    end
    object grPrinterItemSale: TdxGridReportLink
      Active = True
      Component = grItemSale
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'Sums2'
      ReportDocument.CreationDate = 42655.583263472220000000
      BuiltInReportLink = True
    end
    object grPrinterItemTypeSale: TdxGridReportLink
      Active = True
      Component = grItemTypeSale
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'Sums2'
      ReportDocument.CreationDate = 42655.583263483790000000
      BuiltInReportLink = True
    end
    object grPrinterItemVATsale: TdxGridReportLink
      Active = True
      Component = grItemVATsale
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'Sums2'
      ReportDocument.CreationDate = 42655.583263483790000000
      BuiltInReportLink = True
    end
    object grPrinterPaymentGroups: TdxGridReportLink
      Active = True
      Component = grPaymentGroups
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'Sums2'
      ReportDocument.CreationDate = 42655.583263506950000000
      BuiltInReportLink = True
    end
    object grPrinterPayments: TdxGridReportLink
      Component = grPayments
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'Sums2'
      BuiltInReportLink = True
    end
    object grPrinterPaymentType: TdxGridReportLink
      Active = True
      Component = grPaymentType
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'Sums2'
      ReportDocument.CreationDate = 42655.583263506950000000
      BuiltInReportLink = True
    end
    object grPrinterLink1: TdxCompositionReportLink
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
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
      ReportDocument.CreationDate = 41262.872832372680000000
      ReportDocument.IsCaptionAssigned = True
      ShrinkToPageWidth = True
      Items = <
        item
          ReportLink = grPrinterItemSale
          BuiltInCompositionItem = True
        end
        item
          ReportLink = grPrinterItemTypeSale
          BuiltInCompositionItem = True
        end
        item
          ReportLink = grPrinterItemVATsale
          BuiltInCompositionItem = True
        end
        item
          ReportLink = grPrinterPaymentGroups
          BuiltInCompositionItem = True
        end
        item
          ReportLink = grPrinterPaymentType
          BuiltInCompositionItem = True
        end>
      StartEachItemFromNewPage = False
      BuiltInReportLink = True
    end
  end
  object grMenuInvoicelist: TcxGridPopupMenu
    Grid = grInvoicelist
    PopupMenus = <>
    Left = 44
    Top = 257
  end
  object mSums: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 284
    Top = 194
    object mSumsid: TIntegerField
      FieldName = 'id'
    end
    object mSumsCode: TWideStringField
      FieldName = 'Code'
    end
    object mSumsDescription: TWideStringField
      FieldName = 'Description'
      Size = 50
    end
    object mSumsSale: TFloatField
      FieldName = 'Sale'
    end
    object mSumsPayment: TFloatField
      FieldName = 'Payment'
    end
  end
  object mSumsDS: TDataSource
    DataSet = mSums
    Left = 284
    Top = 244
  end
  object mItemTypeSale: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 828
    Top = 313
    object WideStringField3: TWideStringField
      FieldName = 'ItemType'
    end
    object WideStringField4: TWideStringField
      FieldName = 'ItemTypeDescription'
      Size = 30
    end
    object FloatField1: TFloatField
      FieldName = 'Total'
    end
    object mItemTypeSaleItemCount: TFloatField
      FieldName = 'ItemCount'
    end
    object FloatField2: TFloatField
      FieldName = 'TotalWoVat'
    end
    object FloatField3: TFloatField
      FieldName = 'TotalVat'
    end
    object WideStringField5: TWideStringField
      FieldName = 'VATCode'
      Size = 10
    end
  end
  object mItemTypeSaleDS: TDataSource
    DataSet = mItemTypeSale
    Left = 820
    Top = 369
  end
  object mPaymentGroups: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 500
    Top = 193
    object IntegerField2: TIntegerField
      FieldName = 'InvoiceCount'
    end
    object FloatField4: TFloatField
      FieldName = 'Amount'
    end
    object WideStringField6: TWideStringField
      FieldName = 'PayGroup'
      Size = 5
    end
    object mPaymentGroupsDescription: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
  end
  object mPaymentGroupsDS: TDataSource
    DataSet = mPaymentGroups
    Left = 500
    Top = 241
  end
  object mSums2: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 348
    Top = 194
    object IntegerField3: TIntegerField
      FieldName = 'id'
    end
    object WideStringField1: TWideStringField
      FieldName = 'Code'
    end
    object WideStringField2: TWideStringField
      FieldName = 'Description'
      Size = 50
    end
    object FloatField5: TFloatField
      FieldName = 'Sale'
    end
    object FloatField6: TFloatField
      FieldName = 'Payment'
    end
  end
  object mSums2DS: TDataSource
    DataSet = mSums2
    Left = 348
    Top = 244
  end
  object mHead: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 284
    Top = 313
    object mHeadCompany: TStringField
      FieldName = 'Company'
      Size = 50
    end
    object mHeadStaff: TStringField
      FieldName = 'Staff'
      Size = 50
    end
    object mHeadDateFrom: TDateField
      FieldName = 'DateFrom'
    end
    object mHeadDateTo: TDateField
      FieldName = 'DateTo'
    end
    object mHeadDateCount: TIntegerField
      FieldName = 'DateCount'
    end
    object mHeadSaleAmount: TFloatField
      FieldName = 'SaleAmount'
    end
    object mHeadSaleAmountWoVAT: TFloatField
      FieldName = 'SaleAmountWoVAT'
    end
    object mHeadVATAmount: TFloatField
      FieldName = 'VATAmount'
    end
    object mHeadInvoiceCount: TIntegerField
      FieldName = 'InvoiceCount'
    end
    object mHeadSalePerDay: TFloatField
      FieldName = 'SalePerDay'
    end
    object mHeadSalePerInvoice: TFloatField
      FieldName = 'SalePerInvoice'
    end
    object mHeadPaymentAmount: TFloatField
      FieldName = 'PaymentAmount'
    end
    object mHeadPaymentCount: TFloatField
      FieldName = 'PaymentCount'
    end
    object mHeadLodgingNights: TIntegerField
      FieldName = 'LodgingNights'
    end
    object mHeadLodgingTax: TFloatField
      FieldName = 'LodgingTax'
    end
    object mHeadRoomInvoiceCount: TIntegerField
      FieldName = 'RoomInvoiceCount'
    end
    object mHeadGroupInvoiceCount: TIntegerField
      FieldName = 'GroupInvoiceCount'
    end
    object mHeadKeditInvoiceCount: TIntegerField
      FieldName = 'KeditInvoiceCount'
    end
    object mHeadCashInvoiceCount: TIntegerField
      FieldName = 'CashInvoiceCount'
    end
  end
  object mHeadDS: TDataSource
    DataSet = mHead
    Left = 284
    Top = 361
  end
  object mItemVATsale: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 820
    Top = 193
    object mItemVATsaleItemCount: TFloatField
      FieldName = 'ItemCount'
    end
    object FloatField7: TFloatField
      FieldName = 'Total'
    end
    object FloatField8: TFloatField
      FieldName = 'TotalWoVat'
    end
    object FloatField9: TFloatField
      FieldName = 'TotalVat'
    end
    object WideStringField9: TWideStringField
      FieldName = 'VATCode'
      Size = 10
    end
    object mItemVATsaleDescription: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object mItemVATsaleVATPercentage: TFloatField
      FieldName = 'VATPercentage'
    end
  end
  object mItemVATsaleDS: TDataSource
    DataSet = mItemVATsale
    Left = 828
    Top = 249
  end
  object grMenuItemSale: TcxGridPopupMenu
    Grid = grItemSale
    PopupMenus = <>
    Left = 44
    Top = 193
  end
  object grMenuItemTypeSale: TcxGridPopupMenu
    Grid = grItemTypeSale
    PopupMenus = <>
    Left = 44
    Top = 337
  end
  object grMenuItemVATsale: TcxGridPopupMenu
    Grid = grItemVATsale
    PopupMenus = <>
    Left = 44
    Top = 401
  end
  object grMenuPaymentGroups: TcxGridPopupMenu
    Grid = grPaymentGroups
    PopupMenus = <>
    Left = 44
    Top = 465
  end
  object grMenuPayments: TcxGridPopupMenu
    Grid = grPayments
    PopupMenus = <>
    Left = 44
    Top = 529
  end
  object grMenuPaymentType: TcxGridPopupMenu
    Grid = grPaymentType
    PopupMenus = <>
    Left = 36
    Top = 593
  end
  object pmnuLayout: TPopupMenu
    Left = 608
    Top = 472
    object All1: TMenuItem
      Caption = 'All'
      object mnuLayoutSaveAll: TMenuItem
        Caption = 'Save'
        OnClick = mnuLayoutSaveAllClick
      end
      object mnuLayoutRestoreAll: TMenuItem
        Caption = 'Restore'
        OnClick = mnuLayoutRestoreAllClick
      end
    end
    object Current1: TMenuItem
      Caption = 'Current'
      object mnuLayoutSaveCurrent: TMenuItem
        Caption = 'Save'
        OnClick = mnuLayoutSaveCurrentClick
      end
      object mnuLayoutRestoreCurrent: TMenuItem
        Caption = 'Restore'
        OnClick = mnuLayoutRestoreCurrentClick
      end
    end
  end
  object mnuFinishedInv: TPopupMenu
    Left = 528
    Top = 472
    object mnuThisRoom: TMenuItem
      Caption = 'Closed this Room'
      OnClick = mnuThisRoomClick
    end
    object mnuThisreservation: TMenuItem
      Caption = 'Closed this reservation'
      OnClick = mnuThisreservationClick
    end
    object OpenthisRoom1: TMenuItem
      Caption = 'Open this Room'
      OnClick = OpenthisRoom1Click
    end
    object OpenGroupInvoice1: TMenuItem
      Caption = 'Open Group Invoice'
      OnClick = OpenGroupInvoice1Click
    end
  end
  object StoreMain: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Position'
          'Top'
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\DayFinancials'
    StorageType = stRegistry
    Left = 968
    Top = 328
  end
  object rptbPayments: TppReport
    AutoStop = False
    DataPipeline = ppPayments
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    ModalCancelDialog = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    Left = 320
    Top = 568
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'ppPayments'
    object ppHeaderBand1: TppHeaderBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 16140
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Payments grouped by payment type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = []
        Transparent = True
        mmHeight = 7408
        mmLeft = 2117
        mmTop = 794
        mmWidth = 128852
        BandType = 0
        LayerName = Foreground
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4022
        mmLeft = 3175
        mmTop = 8996
        mmWidth = 29930
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 3969
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'PayDate'
        DataPipeline = ppPayments
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppPayments'
        mmHeight = 3175
        mmLeft = 2117
        mmTop = 529
        mmWidth = 19050
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'InvoiceNumber'
        DataPipeline = ppPayments
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppPayments'
        mmHeight = 3260
        mmLeft = 24606
        mmTop = 529
        mmWidth = 19844
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'Amount'
        DataPipeline = ppPayments
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppPayments'
        mmHeight = 3175
        mmLeft = 46831
        mmTop = 529
        mmWidth = 20373
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'Currency'
        DataPipeline = ppPayments
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppPayments'
        mmHeight = 3175
        mmLeft = 165894
        mmTop = 529
        mmWidth = 8202
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'Customer'
        DataPipeline = ppPayments
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppPayments'
        mmHeight = 3175
        mmLeft = 70644
        mmTop = 529
        mmWidth = 16933
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        DataField = 'CustomerName'
        DataPipeline = ppPayments
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppPayments'
        mmHeight = 3175
        mmLeft = 89429
        mmTop = 529
        mmWidth = 36248
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText17: TppDBText
        UserName = 'DBText9'
        DataField = 'NameOnInvoice'
        DataPipeline = ppPayments
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppPayments'
        mmHeight = 3175
        mmLeft = 127794
        mmTop = 529
        mmWidth = 36777
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText18: TppDBText
        UserName = 'DBText10'
        DataField = 'ihConfirmDate'
        DataPipeline = ppPayments
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppPayments'
        mmHeight = 3175
        mmLeft = 177007
        mmTop = 529
        mmWidth = 18521
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 6615
      mmPrintPosition = 0
    end
    object ppSummaryBand1: TppSummaryBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 44715
      mmPrintPosition = 0
      object ppDBCalc2: TppDBCalc
        UserName = 'DBCalc2'
        DataField = 'Amount'
        DataPipeline = ppPayments
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppPayments'
        mmHeight = 3969
        mmLeft = 67204
        mmTop = 1852
        mmWidth = 32544
        BandType = 7
        LayerName = Foreground
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 1058
        mmLeft = 0
        mmTop = 0
        mmWidth = 197300
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel19: TppLabel
        UserName = 'Label10'
        Caption = 'Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 5292
        mmTop = 1852
        mmWidth = 8202
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc3: TppDBCalc
        UserName = 'DBCalc3'
        DataField = 'InvoiceNumber'
        DataPipeline = ppPayments
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcCount
        DataPipelineName = 'ppPayments'
        mmHeight = 3969
        mmLeft = 16140
        mmTop = 1852
        mmWidth = 12171
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel20: TppLabel
        UserName = 'Label101'
        Caption = 'Payments   -  Total : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 30427
        mmTop = 1588
        mmWidth = 33867
        BandType = 7
        LayerName = Foreground
      end
      object ppShape1: TppShape
        UserName = 'Shape1'
        mmHeight = 33073
        mmLeft = 0
        mmTop = 7673
        mmWidth = 192352
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel21: TppLabel
        UserName = 'Label11'
        Caption = 'Cashier status'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4498
        mmLeft = 14288
        mmTop = 10848
        mmWidth = 26988
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel22: TppLabel
        UserName = 'Label22'
        Caption = 'Staff confirmation :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4498
        mmLeft = 85990
        mmTop = 11906
        mmWidth = 29369
        BandType = 7
        LayerName = Foreground
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        Weight = 0.750000000000000000
        mmHeight = 1588
        mmLeft = 44715
        mmTop = 14817
        mmWidth = 37571
        BandType = 7
        LayerName = Foreground
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Weight = 0.750000000000000000
        mmHeight = 1588
        mmLeft = 120121
        mmTop = 14817
        mmWidth = 37571
        BandType = 7
        LayerName = Foreground
      end
      object ppLine6: TppLine
        UserName = 'Line6'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 2117
        mmTop = 27252
        mmWidth = 187325
        BandType = 7
        LayerName = Foreground
      end
      object ppLine7: TppLine
        UserName = 'Line7'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 2117
        mmTop = 32808
        mmWidth = 187325
        BandType = 7
        LayerName = Foreground
      end
      object ppLine8: TppLine
        UserName = 'Line8'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 2646
        mmTop = 38365
        mmWidth = 187325
        BandType = 7
        LayerName = Foreground
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'PayType'
      DataPipeline = ppPayments
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      PreventOrphans = True
      OutlineSettings.CreateNode = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppPayments'
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        Background.Brush.Style = bsClear
        mmBottomOffset = 0
        mmHeight = 10848
        mmPrintPosition = 0
        object ppLabel4: TppLabel
          UserName = 'Label4'
          Caption = 'Paid with : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          Transparent = True
          mmHeight = 4868
          mmLeft = 3969
          mmTop = 1058
          mmWidth = 20743
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText4: TppDBText
          UserName = 'DBText4'
          AutoSize = True
          DataField = 'PayTypeDescription'
          DataPipeline = ppPayments
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppPayments'
          mmHeight = 4868
          mmLeft = 25665
          mmTop = 1058
          mmWidth = 37677
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel2: TppLabel
          UserName = 'Label2'
          AutoSize = False
          Caption = 'PayDate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3387
          mmLeft = 3969
          mmTop = 6615
          mmWidth = 17198
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel3: TppLabel
          UserName = 'Label3'
          AutoSize = False
          Caption = 'Amount'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3387
          mmLeft = 48154
          mmTop = 6615
          mmWidth = 19050
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel5: TppLabel
          UserName = 'Label5'
          AutoSize = False
          Caption = 'Invoice'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3387
          mmLeft = 24606
          mmTop = 6615
          mmWidth = 20373
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel7: TppLabel
          UserName = 'Label7'
          AutoSize = False
          Caption = 'Confirmed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3387
          mmLeft = 177007
          mmTop = 6615
          mmWidth = 18256
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel8: TppLabel
          UserName = 'Label8'
          AutoSize = False
          Caption = 'Name On Invoice'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3440
          mmLeft = 127529
          mmTop = 6615
          mmWidth = 30163
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel9: TppLabel
          UserName = 'Label9'
          AutoSize = False
          Caption = 'Customer'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3440
          mmLeft = 69586
          mmTop = 6615
          mmWidth = 16933
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel6: TppLabel
          UserName = 'Label6'
          AutoSize = False
          Caption = 'Customer Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3440
          mmLeft = 88371
          mmTop = 6615
          mmWidth = 36248
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLine1: TppLine
          UserName = 'Line1'
          ParentWidth = True
          Weight = 0.750000000000000000
          mmHeight = 1058
          mmLeft = 0
          mmTop = 10319
          mmWidth = 197300
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText6: TppDBText
          UserName = 'DBText6'
          DataField = 'Paid in'
          DataPipeline = ppPayments
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'ppPayments'
          mmHeight = 3440
          mmLeft = 165894
          mmTop = 6615
          mmWidth = 10054
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        Background.Brush.Style = bsClear
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 5556
        mmPrintPosition = 0
        object ppDBCalc1: TppDBCalc
          UserName = 'DBCalc1'
          DataField = 'Amount'
          DataPipeline = ppPayments
          DisplayFormat = '#,0.00;-#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppPayments'
          mmHeight = 3175
          mmLeft = 50006
          mmTop = 529
          mmWidth = 17198
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLine2: TppLine
          UserName = 'Line2'
          ParentWidth = True
          Weight = 0.750000000000000000
          mmHeight = 1058
          mmLeft = 0
          mmTop = 529
          mmWidth = 197300
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object kbmReportDS: TDataSource
    DataSet = kbmReport
    Left = 164
    Top = 401
  end
  object ppPayments: TppDBPipeline
    DataSource = kbmReportDS
    OpenDataSource = False
    AutoCreateFields = False
    UserName = 'Payments'
    Left = 408
    Top = 568
    object ppPaymentsppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'RecId'
      FieldName = 'RecId'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 0
    end
    object ppPaymentsppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'Reservation'
      FieldName = 'Reservation'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 1
    end
    object ppPaymentsppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'RoomReservation'
      FieldName = 'RoomReservation'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 2
    end
    object ppPaymentsppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'InvoiceNumber'
      FieldName = 'InvoiceNumber'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 3
    end
    object ppPaymentsppField5: TppField
      FieldAlias = 'PayDate'
      FieldName = 'PayDate'
      FieldLength = 10
      DisplayWidth = 10
      Position = 4
    end
    object ppPaymentsppField6: TppField
      FieldAlias = 'Customer'
      FieldName = 'Customer'
      FieldLength = 15
      DisplayWidth = 15
      Position = 5
    end
    object ppPaymentsppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'Amount'
      FieldName = 'Amount'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 6
    end
    object ppPaymentsppField8: TppField
      FieldAlias = 'Currency'
      FieldName = 'Currency'
      FieldLength = 5
      DisplayWidth = 5
      Position = 7
    end
    object ppPaymentsppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'CurrencyRate'
      FieldName = 'CurrencyRate'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 8
    end
    object ppPaymentsppField10: TppField
      FieldAlias = 'PayType'
      FieldName = 'PayType'
      FieldLength = 15
      DisplayWidth = 15
      Position = 9
    end
    object ppPaymentsppField11: TppField
      FieldAlias = 'InvoiceDate'
      FieldName = 'InvoiceDate'
      FieldLength = 10
      DisplayWidth = 10
      Position = 10
    end
    object ppPaymentsppField12: TppField
      FieldAlias = 'PayTypeDescription'
      FieldName = 'PayTypeDescription'
      FieldLength = 30
      DisplayWidth = 30
      Position = 11
    end
    object ppPaymentsppField13: TppField
      FieldAlias = 'payGroupDescription'
      FieldName = 'payGroupDescription'
      FieldLength = 30
      DisplayWidth = 30
      Position = 12
    end
    object ppPaymentsppField14: TppField
      FieldAlias = 'PayGroup'
      FieldName = 'PayGroup'
      FieldLength = 5
      DisplayWidth = 5
      Position = 13
    end
    object ppPaymentsppField15: TppField
      FieldAlias = 'NameOnInvoice'
      FieldName = 'NameOnInvoice'
      FieldLength = 100
      DisplayWidth = 100
      Position = 14
    end
    object ppPaymentsppField16: TppField
      FieldAlias = 'ihConfirmDate'
      FieldName = 'ihConfirmDate'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 15
    end
    object ppPaymentsppField17: TppField
      Alignment = taRightJustify
      FieldAlias = 'SplitNumber'
      FieldName = 'SplitNumber'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 16
    end
    object ppPaymentsppField18: TppField
      FieldAlias = 'RoomGuest'
      FieldName = 'RoomGuest'
      FieldLength = 100
      DisplayWidth = 100
      Position = 17
    end
    object ppPaymentsppField19: TppField
      FieldAlias = 'CustomerName'
      FieldName = 'CustomerName'
      FieldLength = 100
      DisplayWidth = 100
      Position = 18
    end
    object ppPaymentsppField20: TppField
      FieldAlias = 'isAgency'
      FieldName = 'isAgency'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 19
    end
    object ppPaymentsppField21: TppField
      FieldAlias = 'isRoom'
      FieldName = 'isRoom'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 20
    end
    object ppPaymentsppField22: TppField
      FieldAlias = 'isGroup'
      FieldName = 'isGroup'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 21
    end
    object ppPaymentsppField23: TppField
      FieldAlias = 'isKredit'
      FieldName = 'isKredit'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 22
    end
    object ppPaymentsppField24: TppField
      FieldAlias = 'isCash'
      FieldName = 'isCash'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 23
    end
    object ppPaymentsppField25: TppField
      FieldAlias = 'aDate'
      FieldName = 'aDate'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 24
    end
  end
  object dxMemData1: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    OnCalcFields = mPaymentsCalcFields
    Left = 284
    Top = 425
    object IntegerField5: TIntegerField
      FieldName = 'Reservation'
    end
    object IntegerField6: TIntegerField
      FieldName = 'RoomReservation'
    end
    object IntegerField7: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object WideStringField7: TWideStringField
      FieldName = 'PayDate'
      Size = 10
    end
    object WideStringField8: TWideStringField
      FieldName = 'Customer'
      Size = 15
    end
    object FloatField10: TFloatField
      FieldName = 'Amount'
    end
    object WideStringField10: TWideStringField
      FieldName = 'Currency'
      Size = 5
    end
    object FloatField11: TFloatField
      FieldName = 'CurrencyRate'
    end
    object WideStringField11: TWideStringField
      FieldName = 'PayType'
      Size = 15
    end
    object WideStringField12: TWideStringField
      FieldName = 'InvoiceDate'
      Size = 10
    end
    object WideStringField13: TWideStringField
      FieldName = 'PayTypeDescription'
      Size = 30
    end
    object WideStringField14: TWideStringField
      FieldName = 'payGroupDescription'
      Size = 30
    end
    object WideStringField15: TWideStringField
      FieldName = 'PayGroup'
      Size = 5
    end
    object WideStringField16: TWideStringField
      FieldName = 'NameOnInvoice'
      Size = 100
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'ihConfirmDate'
    end
    object IntegerField8: TIntegerField
      FieldName = 'SplitNumber'
    end
    object WideStringField17: TWideStringField
      FieldName = 'RoomGuest'
      Size = 100
    end
    object WideStringField18: TWideStringField
      FieldName = 'CustomerName'
      Size = 100
    end
    object BooleanField1: TBooleanField
      FieldName = 'isAgency'
    end
    object BooleanField2: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'isRoom'
      Calculated = True
    end
    object BooleanField3: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'isGroup'
      Calculated = True
    end
    object BooleanField4: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'isKredit'
      Calculated = True
    end
    object BooleanField5: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'isCash'
      Calculated = True
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'aDate'
    end
  end
  object mPayments: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'InvoiceNumber'
        DataType = ftInteger
      end
      item
        Name = 'PayDate'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'Amount'
        DataType = ftFloat
      end
      item
        Name = 'Currency'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'CurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'PayType'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'InvoiceDate'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'PayTypeDescription'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'payGroupDescription'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'PayGroup'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'NameOnInvoice'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'ihConfirmDate'
        DataType = ftDateTime
      end
      item
        Name = 'SplitNumber'
        DataType = ftInteger
      end
      item
        Name = 'RoomGuest'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'isAgency'
        DataType = ftBoolean
      end
      item
        Name = 'isRoom'
        DataType = ftBoolean
      end
      item
        Name = 'isGroup'
        DataType = ftBoolean
      end
      item
        Name = 'isKredit'
        DataType = ftBoolean
      end
      item
        Name = 'isCash'
        DataType = ftBoolean
      end
      item
        Name = 'aDate'
        DataType = ftDateTime
      end
      item
        Name = 'currencyAmount'
        DataType = ftFloat
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.22.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 168
    Top = 216
  end
  object kbmReport: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.22.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 160
    Top = 336
  end
end
