object frmRptResInvoices: TfrmRptResInvoices
  Left = 0
  Top = 0
  Caption = 'Reservation Invoices'
  ClientHeight = 584
  ClientWidth = 1120
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
    Left = 461
    Top = 89
    Width = 10
    Height = 475
    AutoSnap = False
    MinSize = 20
    ShowGrip = True
    OnDblClick = splitLeftDblClick
    SkinData.SkinSection = 'SPLITTER'
  end
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 1120
    Height = 89
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object cxGroupBox2: TsGroupBox
      Left = 159
      Top = 5
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
      Left = 316
      Top = 13
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
      Top = 5
      Width = 131
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
        Text = '  .  .    '
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
        Text = '  .  .    '
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
    Top = 564
    Width = 1120
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
    Width = 461
    Height = 475
    Align = alLeft
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object Panel5: TsPanel
      Left = 1
      Top = 1
      Width = 459
      Height = 67
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object cLabFilter: TsLabel
        Left = 53
        Top = 47
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
        Left = 299
        Top = 43
        Width = 59
        Height = 21
        Caption = 'Clear'
        SkinData.SkinSection = 'SPEEDBUTTON'
        Images = DImages.PngImageList1
        ImageIndex = 10
      end
      object btnGuestsExcel: TsButton
        Left = 7
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
        Left = 90
        Top = 43
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
      Top = 68
      Width = 459
      Height = 406
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
            FieldName = 'RoomInvoicecount'
            Column = tvTotalGroupInvoiceCount
          end
          item
            Kind = skSum
            FieldName = 'numPersons'
            Column = tvTotalnumPersons
          end
          item
            FieldName = 'RoomInvoicecount'
            Column = tvTotalRoomInvoicecount
          end
          item
            Kind = skSum
            FieldName = 'roomCount'
            Column = tvTotalroomCount
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
        OptionsView.HeaderAutoHeight = True
        OptionsView.Indicator = True
        object tvTotalCustomer: TcxGridDBColumn
          DataBinding.FieldName = 'Customer'
          Width = 100
        end
        object tvTotalCustomerName: TcxGridDBColumn
          Caption = 'Customer Name'
          DataBinding.FieldName = 'CustomerName'
          Width = 150
        end
        object tvTotalreservationName: TcxGridDBColumn
          Caption = 'Reservation Name'
          DataBinding.FieldName = 'reservationName'
          Visible = False
          Width = 151
        end
        object tvTotalroomCount: TcxGridDBColumn
          Caption = 'Room Count'
          DataBinding.FieldName = 'roomCount'
          Width = 48
        end
        object tvTotalFirstArrival: TcxGridDBColumn
          Caption = 'First'#13#10'Arrival'
          DataBinding.FieldName = 'FirstArrival'
        end
        object tvTotalLastDeparture: TcxGridDBColumn
          Caption = 'Last Departure'
          DataBinding.FieldName = 'LastDeparture'
          Width = 68
        end
        object tvTotalnumPersons: TcxGridDBColumn
          Caption = 'Persons'
          DataBinding.FieldName = 'numPersons'
          Width = 56
        end
        object tvTotaltotalDays: TcxGridDBColumn
          Caption = 'Total Days'
          DataBinding.FieldName = 'totalDays'
          Visible = False
          Width = 48
        end
        object tvTotalDaysPaid: TcxGridDBColumn
          Caption = 'Days Paid'
          DataBinding.FieldName = 'DaysPaid'
          Visible = False
          Width = 48
        end
        object tvTotalDaysUnPaid: TcxGridDBColumn
          Caption = 'Days UnPaid'
          DataBinding.FieldName = 'DaysUnPaid'
          Visible = False
          Width = 48
        end
        object tvTotalRoomInvoicecount: TcxGridDBColumn
          Caption = 'Room invoice count'
          DataBinding.FieldName = 'RoomInvoicecount'
          Width = 60
        end
        object tvTotalGroupInvoiceCount: TcxGridDBColumn
          Caption = 'Group Invoice Count'
          DataBinding.FieldName = 'GroupInvoiceCount'
          Width = 54
        end
        object tvTotalreservation: TcxGridDBColumn
          DataBinding.FieldName = 'reservation'
          Visible = False
        end
      end
      object lvTotal: TcxGridLevel
        GridView = tvTotal
      end
    end
  end
  object tabsMain: TsPageControl
    Left = 471
    Top = 89
    Width = 649
    Height = 475
    ActivePage = sTabSheet1
    Align = alClient
    TabOrder = 3
    SkinData.SkinSection = 'PAGECONTROL'
    OnPageChanging = tabsMainPageChanging
    object tabOpenInvoices: TsTabSheet
      Caption = 'Item summery'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object sPanel3: TsPanel
        Left = 0
        Top = 0
        Width = 641
        Height = 44
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton4: TsButton
          Left = 3
          Top = 1
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
        Width = 641
        Height = 403
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
      Caption = 'Closed Invoice list'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 641
        Height = 44
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnToExcel: TsButton
          Left = 1
          Top = 2
          Width = 100
          Height = 37
          HelpContext = 100
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnToExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnShowReservation: TsButton
          Left = 107
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
          Left = 213
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
          Left = 425
          Top = 2
          Width = 100
          Height = 37
          Caption = 'Expand all'
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = btnExpandAllClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnCollapseAll: TsButton
          Left = 319
          Top = 2
          Width = 100
          Height = 37
          Caption = 'Collapse all'
          Images = DImages.PngImageList1
          TabOrder = 4
          OnClick = btnCollapseAllClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object Grid: TcxGrid
        Left = 0
        Top = 44
        Width = 641
        Height = 403
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = cxcbsNone
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
    object sTabSheet1: TsTabSheet
      Caption = 'Open Invoice list'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object sPanel4: TsPanel
        Left = 0
        Top = 0
        Width = 641
        Height = 45
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton2: TsButton
          Left = 5
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton2Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton3: TsButton
          Left = 111
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Reservation'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = sButton3Click
          SkinData.SkinSection = 'BUTTON'
        end
        object brtGroupInvoice: TsButton
          Left = 217
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Group Invoice'
          ImageIndex = 60
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = brtGroupInvoiceClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton5: TsButton
          Left = 323
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Room Invoice'
          ImageIndex = 62
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = sButton5Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton6: TsButton
          Left = 535
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Expand All'
          Images = DImages.PngImageList1
          TabOrder = 4
          OnClick = sButton6Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton7: TsButton
          Left = 429
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Collapse all'
          Images = DImages.PngImageList1
          TabOrder = 5
          OnClick = sButton7Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grOpenInvoices: TcxGrid
        Left = 0
        Top = 45
        Width = 641
        Height = 402
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvOpenInvoices: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = tvOpenInvoicesCellDblClick
          DataController.DataSource = OpenInvoicesDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          OptionsView.Indicator = True
          object tvOpenInvoicescustomer: TcxGridDBColumn
            DataBinding.FieldName = 'customer'
            Width = 86
          end
          object tvOpenInvoicescustomerName: TcxGridDBColumn
            DataBinding.FieldName = 'customerName'
            Width = 139
          end
          object tvOpenInvoicesRoom: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
            Width = 71
          end
          object tvOpenInvoicesRoomType: TcxGridDBColumn
            DataBinding.FieldName = 'RoomType'
            Width = 71
          end
          object tvOpenInvoicesroomclass: TcxGridDBColumn
            DataBinding.FieldName = 'roomclass'
            Width = 71
          end
          object tvOpenInvoicesarrival: TcxGridDBColumn
            Caption = 'Arrival'
            DataBinding.FieldName = 'arrival'
            Width = 77
          end
          object tvOpenInvoicesDeparture: TcxGridDBColumn
            DataBinding.FieldName = 'Departure'
            Width = 74
          end
          object tvOpenInvoicesisGroup: TcxGridDBColumn
            Caption = 'Group'
            DataBinding.FieldName = 'isGroup'
            Width = 42
          end
          object tvOpenInvoicesunPaidRentNights: TcxGridDBColumn
            Caption = 'Unpaid Nights'
            DataBinding.FieldName = 'unPaidRentNights'
          end
          object tvOpenInvoicesGuestCount: TcxGridDBColumn
            Caption = 'Total Guests'
            DataBinding.FieldName = 'GuestCount'
          end
          object tvOpenInvoicesunPaidRoomRent: TcxGridDBColumn
            Caption = 'Room Rent (Currency)'
            DataBinding.FieldName = 'unPaidRoomRent'
            OnGetProperties = tvTotalTotalAmountGetProperties
          end
          object tvOpenInvoicescurrency: TcxGridDBColumn
            DataBinding.FieldName = 'currency'
            Width = 50
          end
          object tvOpenInvoicesDiscountUnPaidRoomRent: TcxGridDBColumn
            Caption = 'Room Discount '
            DataBinding.FieldName = 'DiscountUnPaidRoomRent'
            OnGetProperties = tvTotalTotalAmountGetProperties
          end
          object tvOpenInvoicesTotalUnpaidRoomRent: TcxGridDBColumn
            Caption = 'Room Rent Balance'
            DataBinding.FieldName = 'TotalUnpaidRoomRent'
            OnGetProperties = tvTotalTotalAmountGetProperties
          end
          object tvOpenInvoicesitemAmount: TcxGridDBColumn
            Caption = 'Items (Native)'
            DataBinding.FieldName = 'itemAmount'
          end
          object tvOpenInvoicesstatus: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'status'
            Width = 40
          end
          object tvOpenInvoicesMainGuest: TcxGridDBColumn
            DataBinding.FieldName = 'MainGuest'
            Width = 150
          end
          object tvOpenInvoicesinvRefrence: TcxGridDBColumn
            DataBinding.FieldName = 'invRefrence'
            Width = 124
          end
          object tvOpenInvoicesinformation: TcxGridDBColumn
            DataBinding.FieldName = 'information'
            Width = 98
          end
          object tvOpenInvoicesRoomreservation: TcxGridDBColumn
            Caption = 'Room reservation'
            DataBinding.FieldName = 'Roomreservation'
            Width = 83
          end
          object tvOpenInvoicesReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
          end
          object tvOpenInvoicestheReservation: TcxGridDBColumn
            DataBinding.FieldName = 'theReservation'
            Visible = False
            GroupIndex = 0
            Width = 400
          end
        end
        object lvOpenInvoices: TcxGridLevel
          GridView = tvOpenInvoices
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
        Name = 'roomCount'
        DataType = ftInteger
      end
      item
        Name = 'totalDays'
        DataType = ftInteger
      end
      item
        Name = 'DaysPaid'
        DataType = ftInteger
      end
      item
        Name = 'DaysUnPaid'
        DataType = ftInteger
      end
      item
        Name = 'reservation'
        DataType = ftInteger
      end
      item
        Name = 'FirstArrival'
        DataType = ftDate
      end
      item
        Name = 'LastDeparture'
        DataType = ftDate
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'reservationName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'RoomInvoicecount'
        DataType = ftInteger
      end
      item
        Name = 'GroupInvoiceCount'
        DataType = ftInteger
      end
      item
        Name = 'numPersons'
        DataType = ftInteger
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 200
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.62.00 Standard Edition'
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
    Left = 752
    Top = 72
  end
  object mInvoiceLinesDS: TDataSource
    DataSet = mInvoiceLines
    Left = 840
    Top = 56
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
    Version = '7.62.00 Standard Edition'
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
  object kbmOpenInvoices: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Roomreservation'
        DataType = ftInteger
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'arrival'
        DataType = ftDateTime
      end
      item
        Name = 'Departure'
        DataType = ftDateTime
      end
      item
        Name = 'Room'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'status'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'isGroup'
        DataType = ftBoolean
      end
      item
        Name = 'currency'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'customer'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'customerName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'itemAmount'
        DataType = ftFloat
      end
      item
        Name = 'unPaidRentNights'
        DataType = ftInteger
      end
      item
        Name = 'GuestCount'
        DataType = ftInteger
      end
      item
        Name = 'unPaidRoomRent'
        DataType = ftFloat
      end
      item
        Name = 'DiscountUnPaidRoomRent'
        DataType = ftFloat
      end
      item
        Name = 'TotalUnpaidRoomRent'
        DataType = ftFloat
      end
      item
        Name = 'theReservation'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'MainGuest'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'RoomType'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'roomclass'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'invRefrence'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'information'
        DataType = ftWideMemo
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.62.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 656
    Top = 232
  end
  object OpenInvoicesDS: TDataSource
    DataSet = kbmOpenInvoices
    Left = 664
    Top = 296
  end
end
