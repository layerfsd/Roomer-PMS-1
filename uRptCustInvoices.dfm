object frmRptCustInvoices: TfrmRptCustInvoices
  Left = 0
  Top = 0
  Caption = 'Customer Invoices'
  ClientHeight = 586
  ClientWidth = 984
  Color = clBtnFace
  Constraints.MinWidth = 570
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splitLeft: TsSplitter
    Left = 400
    Top = 89
    Width = 10
    Height = 477
    AutoSnap = False
    MinSize = 20
    ShowGrip = True
    OnDblClick = splitLeftDblClick
    SkinData.SkinSection = 'SPLITTER'
  end
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 89
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object cxGroupBox2: TsGroupBox
      Left = 210
      Top = 3
      Width = 151
      Height = 78
      Caption = '.. or select month'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object cbxMonth: TsComboBox
        Left = 15
        Top = 20
        Width = 121
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
        Text = 'Choose a Month ...'
        OnCloseUp = cbxMonthCloseUp
        Items.Strings = (
          'Choose a Month ...'
          'January'
          'February'
          'March'
          'April'
          'may'
          'June'
          'July'
          'august'
          'September'
          'October'
          'November'
          'December')
      end
      object cbxYear: TsComboBox
        Left = 15
        Top = 47
        Width = 121
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
        Text = 'Choose a year ...'
        OnCloseUp = cbxMonthCloseUp
        Items.Strings = (
          'Choose year ...'
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
    object btnRefresh: TsButton
      Left = 379
      Top = 10
      Width = 132
      Height = 25
      Caption = 'Refresh ALL'
      Default = True
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 1
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object gbxSelectDates: TsGroupBox
      Left = 22
      Top = 3
      Width = 182
      Height = 78
      Caption = 'Select dates'
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
        Left = 16
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
        TabOrder = 0
        Text = '  -  -    '
        OnChange = dtDateFromChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtDateTo: TsDateEdit
        Left = 16
        Top = 47
        Width = 105
        Height = 20
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
        OnChange = dtDateFromChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 566
    Width = 984
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 89
    Width = 400
    Height = 477
    Align = alLeft
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object Panel5: TsPanel
      Left = 1
      Top = 1
      Width = 398
      Height = 70
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object cLabFilter: TsLabel
        Left = 44
        Top = 49
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Filter :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object btnClear: TsSpeedButton
        Left = 287
        Top = 45
        Width = 59
        Height = 21
        Caption = 'Clear'
        OnClick = btnClearClick
        SkinData.SkinSection = 'SPEEDBUTTON'
        Images = DImages.PngImageList1
        ImageIndex = 10
      end
      object btnGuestsExcel: TsButton
        Left = 8
        Top = 2
        Width = 100
        Height = 37
        Caption = 'Excel'
        ImageIndex = 132
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = btnGuestsExcelClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnGetData: TsButton
        Left = 112
        Top = 2
        Width = 100
        Height = 37
        Caption = 'Get Data'
        ImageAlignment = iaRight
        ImageIndex = 107
        Images = DImages.PngImageList1
        TabOrder = 1
        OnClick = btnGetDataClick
        SkinData.SkinSection = 'BUTTON'
      end
      object edFilter: TsEdit
        Left = 81
        Top = 45
        Width = 206
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnChange = edFilterChange
        SkinData.SkinSection = 'EDIT'
      end
    end
    object grTotal: TcxGrid
      Left = 1
      Top = 71
      Width = 398
      Height = 405
      Align = alClient
      TabOrder = 1
      LookAndFeel.NativeStyle = False
      object tvTotal: TcxGridDBTableView
        Navigator.Buttons.ConfirmDelete = True
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.Insert.Visible = False
        Navigator.Buttons.Append.Visible = True
        Navigator.Buttons.Delete.Visible = False
        Navigator.Buttons.Edit.Visible = False
        Navigator.Buttons.Post.Visible = False
        Navigator.InfoPanel.Visible = True
        Navigator.Visible = True
        OnCellClick = tvTotalCellClick
        OnCellDblClick = tvTotalCellDblClick
        DataController.DataSource = TotalDS
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            FieldName = 'Customer'
            Column = tvTotalCustomer
          end
          item
            Kind = skSum
            FieldName = 'TotalAmount'
            Column = tvTotalTotalAmount
          end
          item
            Kind = skAverage
            FieldName = 'TotalAmount'
            Column = tvTotalTotalAmount
          end
          item
            Kind = skSum
            FieldName = 'InvoiceCount'
            Column = tvTotalInvoiceCount
            DisplayText = 'ff :'
          end
          item
            Kind = skAverage
            FieldName = 'InvoiceCount'
            Column = tvTotalInvoiceCount
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        OptionsView.FooterMultiSummaries = True
        OptionsView.GroupByBox = False
        object tvTotalCustomer: TcxGridDBColumn
          DataBinding.FieldName = 'Customer'
          Width = 88
        end
        object tvTotalCustomerName: TcxGridDBColumn
          Caption = 'Customer Name'
          DataBinding.FieldName = 'CustomerName'
          Width = 150
        end
        object tvTotalTotalAmount: TcxGridDBColumn
          Caption = 'Amount'
          DataBinding.FieldName = 'TotalAmount'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          OnGetProperties = tvTotalTotalAmountGetProperties
          Width = 95
        end
        object tvTotalInvoiceCount: TcxGridDBColumn
          Caption = 'Count'
          DataBinding.FieldName = 'InvoiceCount'
          Width = 42
        end
      end
      object lvTotal: TcxGridLevel
        GridView = tvTotal
      end
    end
  end
  object tabsMain: TsPageControl
    Left = 410
    Top = 89
    Width = 574
    Height = 477
    ActivePage = tabOpenInvoices
    Align = alClient
    TabOrder = 3
    SkinData.SkinSection = 'PAGECONTROL'
    object tabOpenInvoices: TsTabSheet
      Caption = 'Item summery'
      object sPanel3: TsPanel
        Left = 0
        Top = 0
        Width = 566
        Height = 44
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton4: TsButton
          Left = 3
          Top = 2
          Width = 100
          Height = 37
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton4Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grItems: TcxGrid
        Left = 0
        Top = 44
        Width = 566
        Height = 405
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvItems: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = ItemsDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'Amount'
              Column = tvItemsAmount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          object tvItemsItemNumber: TcxGridDBColumn
            DataBinding.FieldName = 'ItemNumber'
            Width = 89
          end
          object tvItemsDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 99
          end
          object tvItemsItems: TcxGridDBColumn
            DataBinding.FieldName = 'Items'
            Width = 68
          end
          object tvItemsAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvTotalTotalAmountGetProperties
            Width = 106
          end
          object tvItemsLines: TcxGridDBColumn
            DataBinding.FieldName = 'Lines'
          end
        end
        object lvItems: TcxGridLevel
          GridView = tvItems
        end
      end
    end
    object tabFinishedInvoices: TsTabSheet
      Caption = 'Invoice list'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 566
        Height = 45
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnToExcel: TsButton
          Left = 4
          Top = 2
          Width = 100
          Height = 37
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnToExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnShowReservation: TsButton
          Left = 110
          Top = 2
          Width = 100
          Height = 37
          Caption = 'Reservation'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnShowReservationClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnInvoiceInvoicelines: TsButton
          Left = 216
          Top = 2
          Width = 100
          Height = 37
          Caption = 'Invoice'
          ImageIndex = 63
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = btnInvoiceInvoicelinesClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnExpandAll: TsButton
          Left = 428
          Top = 2
          Width = 100
          Height = 37
          Caption = 'Expand all'
          Images = DImages.PngImageList1
          TabOrder = 3
          SkinData.SkinSection = 'BUTTON'
        end
        object btnCollapseAll: TsButton
          Left = 322
          Top = 2
          Width = 100
          Height = 37
          Caption = 'Collapse all'
          Images = DImages.PngImageList1
          TabOrder = 4
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object Grid: TcxGrid
        Left = 0
        Top = 45
        Width = 566
        Height = 404
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = cxcbsNone
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        ExplicitLeft = 2
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
              Column = tvInvoiceHeadsAmountWithTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Column = tvInvoiceHeadsAmountNoTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Column = tvInvoiceHeadsAmountTax
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.Indicator = True
          object tvInvoiceHeadsRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvInvoiceHeadsInvoiceNumber: TcxGridDBColumn
            Caption = 'Number'
            DataBinding.FieldName = 'InvoiceNumber'
            Width = 32
          end
          object tvInvoiceHeadsInvoiceDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'InvoiceDate'
          end
          object tvInvoiceHeadsCustomer: TcxGridDBColumn
            DataBinding.FieldName = 'Customer'
            Width = 103
          end
          object tvInvoiceHeadsNameOnInvoice: TcxGridDBColumn
            Caption = 'Name on invoice'
            DataBinding.FieldName = 'NameOnInvoice'
            Width = 136
          end
          object tvInvoiceHeadsAmountWithTax: TcxGridDBColumn
            Caption = 'With VAT'
            DataBinding.FieldName = 'AmountWithTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvTotalTotalAmountGetProperties
            Options.Editing = False
            Width = 82
          end
          object tvInvoiceHeadsAmountNoTax: TcxGridDBColumn
            Caption = 'No VAT'
            DataBinding.FieldName = 'AmountNoTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvTotalTotalAmountGetProperties
            Width = 80
          end
          object tvInvoiceHeadsAmountTax: TcxGridDBColumn
            Caption = 'VAT'
            DataBinding.FieldName = 'AmountTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvTotalTotalAmountGetProperties
            Width = 80
          end
          object tvInvoiceHeadsPayTypes: TcxGridDBColumn
            Caption = 'Pay Type'
            DataBinding.FieldName = 'PayTypes'
            Width = 76
          end
          object tvInvoiceHeadsPayTypeDescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'PayTypeDescription'
            Width = 153
          end
          object tvInvoiceHeadsPayGroups: TcxGridDBColumn
            Caption = 'Pay Group'
            DataBinding.FieldName = 'PayGroups'
            Width = 82
          end
          object tvInvoiceHeadspayGroupDescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'payGroupDescription'
            Width = 118
          end
          object tvInvoiceHeadsAddress1: TcxGridDBColumn
            DataBinding.FieldName = 'Address1'
            Visible = False
            Width = 80
          end
          object tvInvoiceHeadsAddress2: TcxGridDBColumn
            DataBinding.FieldName = 'Address2'
            Visible = False
            Width = 80
          end
          object tvInvoiceHeadsAddress3: TcxGridDBColumn
            DataBinding.FieldName = 'Address3'
            Visible = False
            Width = 80
          end
          object tvInvoiceHeadsRoomGuest: TcxGridDBColumn
            Caption = 'Room Guest'
            DataBinding.FieldName = 'RoomGuest'
            Width = 157
          end
          object tvInvoiceHeadsinvRefrence: TcxGridDBColumn
            Caption = 'Reference'
            DataBinding.FieldName = 'invRefrence'
            Width = 105
          end
          object tvInvoiceHeadsdueDate: TcxGridDBColumn
            DataBinding.FieldName = 'dueDate'
          end
          object tvInvoiceHeadsCreditInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'CreditInvoice'
          end
          object tvInvoiceHeadsOriginalInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'OriginalInvoice'
          end
          object tvInvoiceHeadsReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
            Visible = False
          end
          object tvInvoiceHeadsRoomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'RoomReservation'
            Visible = False
          end
          object tvInvoiceHeadsSplitNumber: TcxGridDBColumn
            DataBinding.FieldName = 'SplitNumber'
            Visible = False
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
              Column = tvInvoiceLinesAmountWithTax
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountWithTax'
              Column = tvInvoiceLinesAmountWithTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountNoTax'
              Column = tvInvoiceLinesAmountNoTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountTax'
              Column = tvInvoiceLinesAmountTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skCount
              FieldName = 'Item'
              Column = tvInvoiceLinesItem
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
          object tvInvoiceLinesInvoiceNumber: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceNumber'
            Visible = False
          end
          object tvInvoiceLinesItem: TcxGridDBColumn
            DataBinding.FieldName = 'Item'
            Width = 90
          end
          object tvInvoiceLinesDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 220
          end
          object tvInvoiceLinesQuantity: TcxGridDBColumn
            DataBinding.FieldName = 'Quantity'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Width = 32
          end
          object tvInvoiceLinesPrice: TcxGridDBColumn
            DataBinding.FieldName = 'Price'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.ReadOnly = False
            OnGetProperties = tvTotalTotalAmountGetProperties
          end
          object tvInvoiceLinesAmountWithTax: TcxGridDBColumn
            Caption = 'With Tax'
            DataBinding.FieldName = 'AmountWithTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvTotalTotalAmountGetProperties
            Options.Editing = False
          end
          object tvInvoiceLinesAmountNoTax: TcxGridDBColumn
            Caption = 'No Tax'
            DataBinding.FieldName = 'AmountNoTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvTotalTotalAmountGetProperties
          end
          object tvInvoiceLinesAmountTax: TcxGridDBColumn
            Caption = 'Tax'
            DataBinding.FieldName = 'AmountTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvTotalTotalAmountGetProperties
          end
          object tvInvoiceLinesCurrency: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
            Width = 22
          end
          object tvInvoiceLinesCurrencyRate: TcxGridDBColumn
            DataBinding.FieldName = 'CurrencyRate'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.000;-,0.000'
            Width = 48
          end
          object tvInvoiceLinespurchaseDate: TcxGridDBColumn
            DataBinding.FieldName = 'purchaseDate'
          end
          object tvInvoiceLinesImportRefrence: TcxGridDBColumn
            DataBinding.FieldName = 'ImportRefrence'
            Width = 100
          end
          object tvInvoiceLinesImportSource: TcxGridDBColumn
            DataBinding.FieldName = 'ImportSource'
            Width = 100
          end
          object tvInvoiceLinesVatType: TcxGridDBColumn
            DataBinding.FieldName = 'VatType'
            Width = 48
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
  end
  object kbmTotal: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'TotalAmount'
        DataType = ftFloat
      end
      item
        Name = 'InvoiceCount'
        DataType = ftInteger
      end
      item
        Name = 'Invoicelist'
        DataType = ftMemo
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
    Left = 600
    Top = 24
  end
  object TotalDS: TDataSource
    DataSet = kbmTotal
    Left = 544
    Top = 24
  end
  object mInvoiceHeads: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 744
    Top = 8
    object mInvoiceHeadsInvoiceNumber: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object mInvoiceHeadsSplitNumber: TIntegerField
      FieldName = 'SplitNumber'
    end
    object mInvoiceHeadsInvoiceDate: TDateField
      FieldName = 'InvoiceDate'
    end
    object mInvoiceHeadsdueDate: TDateField
      FieldName = 'dueDate'
    end
    object mInvoiceHeadsReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mInvoiceHeadsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mInvoiceHeadsCustomer: TStringField
      FieldName = 'Customer'
      Size = 30
    end
    object mInvoiceHeadsNameOnInvoice: TStringField
      FieldName = 'NameOnInvoice'
      Size = 50
    end
    object mInvoiceHeadsAddress1: TStringField
      FieldName = 'Address1'
      Size = 50
    end
    object mInvoiceHeadsAddress2: TStringField
      FieldName = 'Address2'
      Size = 50
    end
    object mInvoiceHeadsAddress3: TStringField
      FieldName = 'Address3'
      Size = 50
    end
    object mInvoiceHeadsAmountWithTax: TFloatField
      FieldName = 'AmountWithTax'
    end
    object mInvoiceHeadsAmountNoTax: TFloatField
      FieldName = 'AmountNoTax'
    end
    object mInvoiceHeadsinvRefrence: TStringField
      FieldName = 'invRefrence'
      Size = 30
    end
    object mInvoiceHeadsAmountTax: TFloatField
      FieldName = 'AmountTax'
    end
    object mInvoiceHeadsCreditInvoice: TIntegerField
      FieldName = 'CreditInvoice'
    end
    object mInvoiceHeadsOriginalInvoice: TIntegerField
      FieldName = 'OriginalInvoice'
    end
    object mInvoiceHeadsRoomGuest: TStringField
      FieldName = 'RoomGuest'
      Size = 50
    end
    object mInvoiceHeadsPayTypes: TStringField
      FieldName = 'PayTypes'
      Size = 30
    end
    object mInvoiceHeadsPayGroups: TStringField
      FieldName = 'PayGroups'
      Size = 30
    end
    object mInvoiceHeadsPayTypeDescription: TStringField
      FieldName = 'PayTypeDescription'
      Size = 30
    end
    object mInvoiceHeadspayGroupDescription: TStringField
      FieldName = 'payGroupDescription'
      Size = 30
    end
  end
  object mInvoiceLines: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 840
    Top = 8
    object mInvoiceLinesInvoiceNumber: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object mInvoiceLinesItem: TStringField
      FieldName = 'Item'
    end
    object mInvoiceLinesQuantity: TFloatField
      FieldName = 'Quantity'
    end
    object mInvoiceLinesDescription: TStringField
      FieldName = 'Description'
      Size = 70
    end
    object mInvoiceLinesPrice: TFloatField
      FieldName = 'Price'
    end
    object mInvoiceLinesVatType: TStringField
      FieldName = 'VatType'
      Size = 10
    end
    object mInvoiceLinesAmountWithTax: TFloatField
      FieldName = 'AmountWithTax'
    end
    object mInvoiceLinesAmountNoTax: TFloatField
      FieldName = 'AmountNoTax'
    end
    object mInvoiceLinesAmountTax: TFloatField
      FieldName = 'AmountTax'
    end
    object mInvoiceLinesCurrency: TStringField
      FieldName = 'Currency'
      Size = 5
    end
    object mInvoiceLinesCurrencyRate: TFloatField
      FieldName = 'CurrencyRate'
    end
    object mInvoiceLinesImportRefrence: TStringField
      FieldName = 'ImportRefrence'
      Size = 30
    end
    object mInvoiceLinesImportSource: TStringField
      FieldName = 'ImportSource'
      Size = 30
    end
    object mInvoiceLinespurchaseDate: TDateField
      FieldName = 'purchaseDate'
    end
  end
  object mInvoiceHeadsDS: TDataSource
    DataSet = mInvoiceHeads
    Left = 816
    Top = 72
  end
  object mInvoiceLinesDS: TDataSource
    DataSet = mInvoiceLines
    Left = 840
    Top = 136
  end
  object kbmItems: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Amount'
        DataType = ftFloat
      end
      item
        Name = 'LineCount'
        DataType = ftInteger
      end
      item
        Name = 'Items'
        DataType = ftFloat
      end
      item
        Name = 'ItemNumber'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 100
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
    Left = 480
    Top = 240
  end
  object ItemsDS: TDataSource
    DataSet = kbmItems
    Left = 480
    Top = 296
  end
end
