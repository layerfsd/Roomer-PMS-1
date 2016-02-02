object frmRptDownPayments: TfrmRptDownPayments
  Left = 0
  Top = 0
  Caption = 'Down Payments'
  ClientHeight = 530
  ClientWidth = 1013
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 510
    Width = 1013
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 1013
    Height = 121
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object cLabFilter: TsLabel
      Left = 46
      Top = 96
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
      Left = 349
      Top = 94
      Width = 54
      Height = 20
      Caption = 'Clear'
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object cxGroupBox2: TsGroupBox
      Left = 210
      Top = 3
      Width = 151
      Height = 85
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
        Top = 18
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
        Font.Color = 2302755
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
        Top = 43
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
        Font.Color = 2302755
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
      Left = 662
      Top = 9
      Width = 100
      Height = 36
      Caption = 'Refresh'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      TabOrder = 1
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object gbxSelectDates: TsGroupBox
      Left = 22
      Top = 3
      Width = 182
      Height = 85
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
        Top = 18
        Width = 105
        Height = 21
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
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
        Top = 45
        Width = 105
        Height = 21
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
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
    object edFilter: TsEdit
      Left = 82
      Top = 93
      Width = 264
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      SkinData.SkinSection = 'EDIT'
    end
    object rgrInvoiced: TsRadioGroup
      Left = 369
      Top = 3
      Width = 139
      Height = 85
      Caption = '.. Invoiced'
      TabOrder = 4
      OnClick = rgrInvoicedClick
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      ItemIndex = 2
      Items.Strings = (
        'All'
        'Invoiced'
        'Not Invoiced')
    end
    object rgrConfirmed: TsRadioGroup
      Left = 516
      Top = 3
      Width = 139
      Height = 85
      Caption = '.. Confirmed'
      TabOrder = 5
      OnClick = rgrInvoicedClick
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      ItemIndex = 0
      Items.Strings = (
        'All'
        'Confirmed'
        'Not Confirmed')
    end
    object sButton1: TsButton
      Left = 662
      Top = 51
      Width = 100
      Height = 36
      Caption = 'Jump to'
      ImageIndex = 57
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 6
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object pageMain: TsPageControl
    Left = 0
    Top = 121
    Width = 1013
    Height = 389
    ActivePage = sTabSheet1
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PAGECONTROL'
    object sTabSheet1: TsTabSheet
      Caption = 'sTabSheet1'
      TabVisible = False
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grPayments: TcxGrid
        Left = 0
        Top = 43
        Width = 1005
        Height = 336
        Align = alClient
        TabOrder = 0
        LookAndFeel.NativeStyle = False
        object tvPayments: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.InfoPanel.Visible = True
          Navigator.Visible = True
          DataController.DataSource = kbmPaymentsDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Amount'
              Column = tvPaymentsAmount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          object tvPaymentsInvoiceNumber: TcxGridDBColumn
            Caption = 'Invoice'
            DataBinding.FieldName = 'InvoiceNumber'
            Width = 83
          end
          object tvPaymentsdtCreated: TcxGridDBColumn
            Caption = 'Created'
            DataBinding.FieldName = 'dtCreated'
            Width = 100
          end
          object tvPaymentsPayDate: TcxGridDBColumn
            Caption = 'Pay Date'
            DataBinding.FieldName = 'PayDate'
            Width = 74
          end
          object tvPaymentsPayType: TcxGridDBColumn
            Caption = 'Pay Type'
            DataBinding.FieldName = 'PayType'
            Width = 97
          end
          object tvPaymentsDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 187
          end
          object tvPaymentsAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvPaymentsAmountGetProperties
            Width = 90
          end
          object tvPaymentsNotes: TcxGridDBColumn
            DataBinding.FieldName = 'Notes'
            Width = 92
          end
          object tvPaymentsCustomer: TcxGridDBColumn
            DataBinding.FieldName = 'Customer'
            Width = 70
          end
          object tvPaymentsCustomerName: TcxGridDBColumn
            Caption = 'Customername'
            DataBinding.FieldName = 'CustomerName'
            Width = 175
          end
          object tvPaymentsReservationName: TcxGridDBColumn
            DataBinding.FieldName = 'ReservationName'
            Width = 304
          end
          object tvPaymentschannelName: TcxGridDBColumn
            Caption = 'channelname'
            DataBinding.FieldName = 'channelName'
            Width = 151
          end
          object tvPaymentsRefrence: TcxGridDBColumn
            DataBinding.FieldName = 'Refrence'
            Width = 131
          end
          object tvPaymentsroom: TcxGridDBColumn
            Caption = 'Room'
            DataBinding.FieldName = 'room'
            Width = 56
          end
          object tvPaymentsarrival: TcxGridDBColumn
            Caption = 'Arrival'
            DataBinding.FieldName = 'arrival'
            Width = 100
          end
          object tvPaymentsdeparture: TcxGridDBColumn
            Caption = 'Departure'
            DataBinding.FieldName = 'departure'
          end
          object tvPaymentsCurrencyRate: TcxGridDBColumn
            Caption = 'Currency rate'
            DataBinding.FieldName = 'CurrencyRate'
          end
          object tvPaymentsCurrency: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
          end
          object tvPaymentsconfirmDate: TcxGridDBColumn
            Caption = 'ConfirmDate'
            DataBinding.FieldName = 'confirmDate'
          end
          object tvPaymentsReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
          end
          object tvPaymentsRoomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'RoomReservation'
          end
          object tvPaymentsPerson: TcxGridDBColumn
            DataBinding.FieldName = 'Person'
            Visible = False
          end
          object tvPaymentsTypeIndex: TcxGridDBColumn
            DataBinding.FieldName = 'TypeIndex'
            Visible = False
          end
          object tvPaymentsID: TcxGridDBColumn
            DataBinding.FieldName = 'ID'
            Visible = False
          end
        end
        object lvPayments: TcxGridLevel
          GridView = tvPayments
        end
      end
      object Panel5: TsPanel
        Left = 0
        Top = 0
        Width = 1005
        Height = 43
        Align = alTop
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object btnGuestsExcel: TsButton
          Left = 4
          Top = 2
          Width = 110
          Height = 39
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnGuestsExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object brnGuestsReservation: TsButton
          Left = 120
          Top = 2
          Width = 110
          Height = 39
          Caption = 'Reservaton '
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = brnGuestsReservationClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnGuestsRoom: TsButton
          Left = 236
          Top = 2
          Width = 110
          Height = 39
          Caption = 'Room'
          ImageIndex = 39
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = btnGuestsRoomClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton2: TsButton
          Left = 352
          Top = 2
          Width = 110
          Height = 39
          Caption = 'Invoice'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = sButton2Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnEdit: TsButton
          Left = 584
          Top = 2
          Width = 110
          Height = 39
          Caption = 'Edit'
          ImageIndex = 25
          Images = DImages.PngImageList1
          TabOrder = 4
          OnClick = btnEditClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton3: TsButton
          Left = 468
          Top = 2
          Width = 110
          Height = 39
          Caption = 'Report'
          ImageIndex = 69
          Images = DImages.PngImageList1
          TabOrder = 5
          OnClick = sButton3Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sCheckBox1: TsCheckBox
          Left = 700
          Top = 4
          Width = 112
          Height = 19
          Caption = 'Group on paytype'
          TabOrder = 6
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
    end
  end
  object kbmPayments_: TkbmMemTable
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
        Name = 'Person'
        DataType = ftInteger
      end
      item
        Name = 'TypeIndex'
        DataType = ftInteger
      end
      item
        Name = 'InvoiceNumber'
        DataType = ftInteger
      end
      item
        Name = 'PayDate'
        DataType = ftDate
      end
      item
        Name = 'Customer'
        DataType = ftWideString
      end
      item
        Name = 'PayType'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Amount'
        DataType = ftFloat
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'CurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'Currency'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'confirmDate'
        DataType = ftDateTime
      end
      item
        Name = 'Notes'
        DataType = ftWideMemo
      end
      item
        Name = 'dtCreated'
        DataType = ftDateTime
      end
      item
        Name = 'arrival'
        DataType = ftDateTime
      end
      item
        Name = 'departure'
        DataType = ftDateTime
      end
      item
        Name = 'ReservationName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'channelName'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Refrence'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'room'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'ID'
        DataType = ftInteger
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
    AfterScroll = kbmPayments_AfterScroll
    Left = 184
    Top = 224
  end
  object kbmPaymentsDS: TDataSource
    DataSet = kbmPayments_
    Left = 288
    Top = 224
  end
  object FormStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Position'
          'Top'
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\frmRptDownPayments'
    StorageType = stRegistry
    Left = 174
    Top = 312
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = ReportDS
    UserName = 'DBPipeline1'
    Left = 352
    Top = 312
    object ppDBPipeline1ppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'Reservation'
      FieldName = 'Reservation'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 0
    end
    object ppDBPipeline1ppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'RoomReservation'
      FieldName = 'RoomReservation'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 1
    end
    object ppDBPipeline1ppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'Person'
      FieldName = 'Person'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 2
    end
    object ppDBPipeline1ppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'TypeIndex'
      FieldName = 'TypeIndex'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 3
    end
    object ppDBPipeline1ppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'InvoiceNumber'
      FieldName = 'InvoiceNumber'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 4
    end
    object ppDBPipeline1ppField6: TppField
      FieldAlias = 'PayDate'
      FieldName = 'PayDate'
      FieldLength = 0
      DataType = dtDate
      DisplayWidth = 10
      Position = 5
    end
    object ppDBPipeline1ppField7: TppField
      FieldAlias = 'Customer'
      FieldName = 'Customer'
      FieldLength = 0
      DisplayWidth = 0
      Position = 6
    end
    object ppDBPipeline1ppField8: TppField
      FieldAlias = 'PayType'
      FieldName = 'PayType'
      FieldLength = 20
      DisplayWidth = 20
      Position = 7
    end
    object ppDBPipeline1ppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'Amount'
      FieldName = 'Amount'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 8
    end
    object ppDBPipeline1ppField10: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 100
      DisplayWidth = 100
      Position = 9
    end
    object ppDBPipeline1ppField11: TppField
      Alignment = taRightJustify
      FieldAlias = 'CurrencyRate'
      FieldName = 'CurrencyRate'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 10
    end
    object ppDBPipeline1ppField12: TppField
      FieldAlias = 'Currency'
      FieldName = 'Currency'
      FieldLength = 10
      DisplayWidth = 10
      Position = 11
    end
    object ppDBPipeline1ppField13: TppField
      FieldAlias = 'confirmDate'
      FieldName = 'confirmDate'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 12
    end
    object ppDBPipeline1ppField14: TppField
      FieldAlias = 'Notes'
      FieldName = 'Notes'
      FieldLength = 0
      DataType = dtMemo
      DisplayWidth = 10
      Position = 13
      Searchable = False
      Sortable = False
    end
    object ppDBPipeline1ppField15: TppField
      FieldAlias = 'dtCreated'
      FieldName = 'dtCreated'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 14
    end
    object ppDBPipeline1ppField16: TppField
      FieldAlias = 'arrival'
      FieldName = 'arrival'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 15
    end
    object ppDBPipeline1ppField17: TppField
      FieldAlias = 'departure'
      FieldName = 'departure'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 16
    end
    object ppDBPipeline1ppField18: TppField
      FieldAlias = 'ReservationName'
      FieldName = 'ReservationName'
      FieldLength = 200
      DisplayWidth = 200
      Position = 17
    end
    object ppDBPipeline1ppField19: TppField
      FieldAlias = 'channelName'
      FieldName = 'channelName'
      FieldLength = 100
      DisplayWidth = 100
      Position = 18
    end
    object ppDBPipeline1ppField20: TppField
      FieldAlias = 'Refrence'
      FieldName = 'Refrence'
      FieldLength = 100
      DisplayWidth = 100
      Position = 19
    end
    object ppDBPipeline1ppField21: TppField
      FieldAlias = 'room'
      FieldName = 'room'
      FieldLength = 20
      DisplayWidth = 20
      Position = 20
    end
    object ppDBPipeline1ppField22: TppField
      FieldAlias = 'CustomerName'
      FieldName = 'CustomerName'
      FieldLength = 100
      DisplayWidth = 100
      Position = 21
    end
    object ppDBPipeline1ppField23: TppField
      Alignment = taRightJustify
      FieldAlias = 'ID'
      FieldName = 'ID'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 22
    end
  end
  object ppReport2: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
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
    OnInitializeParameters = ppReport2InitializeParameters
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
    Left = 280
    Top = 312
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand1: TppHeaderBand
      BeforePrint = ppHeaderBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 24342
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Invoice no.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 1058
        mmTop = 19844
        mmWidth = 18521
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Amount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 43656
        mmTop = 19844
        mmWidth = 19579
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'PayDate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 21431
        mmTop = 19844
        mmWidth = 17992
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        AutoSize = False
        Caption = 'Description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 67204
        mmTop = 19844
        mmWidth = 38894
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        AutoSize = False
        Caption = 'Customer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 129117
        mmTop = 19844
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        AutoSize = False
        Caption = 'PayType'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 109538
        mmTop = 19844
        mmWidth = 17198
        BandType = 0
        LayerName = Foreground
      end
      object pplDates: TppLabel
        UserName = 'lDates'
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 2117
        mmTop = 8731
        mmWidth = 1058
        BandType = 0
        LayerName = Foreground
      end
      object ppc: TppLabel
        UserName = 'c'
        Caption = 'Downpayments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5821
        mmLeft = 2117
        mmTop = 1058
        mmWidth = 49742
        BandType = 0
        LayerName = Foreground
      end
      object pplFilterProperties: TppLabel
        UserName = 'rlabDates1'
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 2117
        mmTop = 14023
        mmWidth = 1058
        BandType = 0
        LayerName = Foreground
      end
      object rLabHotelName: TppLabel
        UserName = 'rLabHotelName'
        Caption = 'Hotel name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3810
        mmLeft = 180182
        mmTop = 529
        mmWidth = 15579
        BandType = 0
        LayerName = Foreground
      end
      object rlabUser: TppLabel
        UserName = 'rLabUser'
        Caption = 'hj'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3810
        mmLeft = 192882
        mmTop = 4763
        mmWidth = 2836
        BandType = 0
        LayerName = Foreground
      end
      object rLabTimeCreated: TppLabel
        UserName = 'rLabTimeCreated'
        Caption = '01.01.2010 22:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3810
        mmLeft = 170657
        mmTop = 9525
        mmWidth = 25019
        BandType = 0
        LayerName = Foreground
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 0
        mmTop = 23813
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 2117
        mmLeft = 0
        mmTop = 19050
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 3440
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'InvoiceNumber'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,;-#,'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3260
        mmLeft = 1323
        mmTop = 180
        mmWidth = 18521
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'Amount'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3260
        mmLeft = 44450
        mmTop = 180
        mmWidth = 19579
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'Description'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3175
        mmLeft = 65617
        mmTop = 265
        mmWidth = 41540
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'dtCreated'
        DataPipeline = ppDBPipeline1
        DisplayFormat = 'dd.mm.yy  hh:nn:ss'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3175
        mmLeft = 21431
        mmTop = 265
        mmWidth = 20902
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'Customer'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3175
        mmLeft = 129117
        mmTop = 265
        mmWidth = 20373
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'CustomerName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3175
        mmLeft = 151077
        mmTop = 265
        mmWidth = 44715
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'PayType'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3175
        mmLeft = 109538
        mmTop = 265
        mmWidth = 18521
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        Visible = False
        mmHeight = 3175
        mmLeft = 65088
        mmTop = 265
        mmWidth = 265
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 8202
      mmPrintPosition = 0
      object ppLabel8: TppLabel
        UserName = 'Label8'
        Caption = 'Page :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 2117
        mmTop = 4498
        mmWidth = 9260
        BandType = 8
        LayerName = Foreground
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtPageSet
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 11906
        mmTop = 4498
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground
      end
    end
    object ppSummaryBand1: TppSummaryBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppGroup1: TppGroup
      BreakName = 'ppLabel7'
      BreakType = btCustomField
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      KeepTogether = True
      OutlineSettings.CreateNode = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = ''
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        Background.Brush.Style = bsClear
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        Background.Brush.Style = bsClear
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 7408
        mmPrintPosition = 0
        object ppcLabTotal: TppLabel
          UserName = 'cLabTotal'
          AutoSize = False
          Caption = 'Total :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3704
          mmLeft = 9260
          mmTop = 1058
          mmWidth = 31750
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppSum: TppDBCalc
          UserName = 'Sum'
          DataField = 'Amount'
          DataPipeline = ppDBPipeline1
          DisplayFormat = '$#,0.00;-$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppDBPipeline1'
          mmHeight = 3704
          mmLeft = 44450
          mmTop = 1058
          mmWidth = 19579
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLine3: TppLine
          UserName = 'Line3'
          Weight = 1.000000000000000000
          mmHeight = 794
          mmLeft = 45508
          mmTop = 529
          mmWidth = 16933
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
  object kbmReport_: TkbmMemTable
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
        Name = 'Person'
        DataType = ftInteger
      end
      item
        Name = 'TypeIndex'
        DataType = ftInteger
      end
      item
        Name = 'InvoiceNumber'
        DataType = ftInteger
      end
      item
        Name = 'PayDate'
        DataType = ftDate
      end
      item
        Name = 'Customer'
        DataType = ftWideString
      end
      item
        Name = 'PayType'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Amount'
        DataType = ftFloat
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'CurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'Currency'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'confirmDate'
        DataType = ftDateTime
      end
      item
        Name = 'Notes'
        DataType = ftWideMemo
      end
      item
        Name = 'dtCreated'
        DataType = ftDateTime
      end
      item
        Name = 'arrival'
        DataType = ftDateTime
      end
      item
        Name = 'departure'
        DataType = ftDateTime
      end
      item
        Name = 'ReservationName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'channelName'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Refrence'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'room'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'ID'
        DataType = ftInteger
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
    AfterScroll = kbmPayments_AfterScroll
    Left = 632
    Top = 320
  end
  object ReportDS: TDataSource
    DataSet = kbmReport_
    Left = 696
    Top = 320
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PassSetting = psTwoPass
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
    OnInitializeParameters = ppReport2InitializeParameters
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
    Left = 280
    Top = 368
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand2: TppHeaderBand
      BeforePrint = ppHeaderBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 24342
      mmPrintPosition = 0
      object ppLabel9: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Invoice no.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 1058
        mmTop = 19844
        mmWidth = 18521
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel10: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Amount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 43656
        mmTop = 19844
        mmWidth = 19579
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel11: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'PayDate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 21431
        mmTop = 19844
        mmWidth = 17992
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel12: TppLabel
        UserName = 'Label4'
        AutoSize = False
        Caption = 'Description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 67204
        mmTop = 19844
        mmWidth = 38894
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel13: TppLabel
        UserName = 'Label5'
        AutoSize = False
        Caption = 'Customer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 129117
        mmTop = 19844
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel15: TppLabel
        UserName = 'lDates'
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 2117
        mmTop = 8731
        mmWidth = 1058
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel16: TppLabel
        UserName = 'c'
        Caption = 'Downpayments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5821
        mmLeft = 2117
        mmTop = 1058
        mmWidth = 49742
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel17: TppLabel
        UserName = 'rlabDates1'
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 2117
        mmTop = 14023
        mmWidth = 1058
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel18: TppLabel
        UserName = 'rLabHotelName'
        Caption = 'Hotel name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3810
        mmLeft = 180182
        mmTop = 529
        mmWidth = 15579
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel19: TppLabel
        UserName = 'rLabUser'
        Caption = 'hj'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3810
        mmLeft = 192882
        mmTop = 4763
        mmWidth = 2836
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel20: TppLabel
        UserName = 'rLabTimeCreated'
        Caption = '01.01.2010 22:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3810
        mmLeft = 170657
        mmTop = 9525
        mmWidth = 25019
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine4: TppLine
        UserName = 'Line1'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 0
        mmTop = 23813
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine5: TppLine
        UserName = 'Line2'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 2117
        mmLeft = 0
        mmTop = 19315
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground1
      end
    end
    object ppDetailBand2: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 3440
      mmPrintPosition = 0
      object ppDBText8: TppDBText
        UserName = 'DBText1'
        DataField = 'InvoiceNumber'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,;-#,'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3260
        mmLeft = 1323
        mmTop = 180
        mmWidth = 18521
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText9: TppDBText
        UserName = 'DBText2'
        DataField = 'Amount'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3260
        mmLeft = 44450
        mmTop = 180
        mmWidth = 19579
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText10: TppDBText
        UserName = 'DBText4'
        DataField = 'Description'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3175
        mmLeft = 65617
        mmTop = 265
        mmWidth = 41540
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText11: TppDBText
        UserName = 'DBText5'
        DataField = 'dtCreated'
        DataPipeline = ppDBPipeline1
        DisplayFormat = 'dd.mm.yy  hh:nn'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3175
        mmLeft = 21431
        mmTop = 265
        mmWidth = 20902
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText12: TppDBText
        UserName = 'DBText6'
        DataField = 'Customer'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3175
        mmLeft = 129117
        mmTop = 265
        mmWidth = 20373
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText13: TppDBText
        UserName = 'DBText7'
        DataField = 'CustomerName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3175
        mmLeft = 151077
        mmTop = 265
        mmWidth = 44715
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel21: TppLabel
        UserName = 'Label7'
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        Visible = False
        mmHeight = 3175
        mmLeft = 65088
        mmTop = 265
        mmWidth = 265
        BandType = 4
        LayerName = Foreground1
      end
    end
    object ppFooterBand2: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 8202
      mmPrintPosition = 0
      object ppLabel22: TppLabel
        UserName = 'Label8'
        Caption = 'Page :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 2117
        mmTop = 4498
        mmWidth = 9260
        BandType = 8
        LayerName = Foreground1
      end
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtPageSet
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 11906
        mmTop = 4498
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground1
      end
    end
    object ppSummaryBand2: TppSummaryBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppGroup2: TppGroup
      BreakName = 'ppLabel21'
      BreakType = btCustomField
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      KeepTogether = True
      OutlineSettings.CreateNode = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = ''
      NewFile = False
      object ppGroupHeaderBand2: TppGroupHeaderBand
        Background.Brush.Style = bsClear
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppGroupFooterBand2: TppGroupFooterBand
        Background.Brush.Style = bsClear
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 7408
        mmPrintPosition = 0
        object ppLabel23: TppLabel
          UserName = 'cLabTotal'
          AutoSize = False
          Caption = 'Total :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3704
          mmLeft = 9260
          mmTop = 1058
          mmWidth = 31750
          BandType = 5
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppDBCalc1: TppDBCalc
          UserName = 'Sum'
          DataField = 'Amount'
          DataPipeline = ppDBPipeline1
          DisplayFormat = '$#,0.00;-$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          ResetGroup = ppGroup2
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppDBPipeline1'
          mmHeight = 3704
          mmLeft = 44450
          mmTop = 1058
          mmWidth = 19579
          BandType = 5
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppLine6: TppLine
          UserName = 'Line3'
          Weight = 1.000000000000000000
          mmHeight = 794
          mmLeft = 45508
          mmTop = 529
          mmWidth = 16933
          BandType = 5
          GroupNo = 0
          LayerName = Foreground1
        end
      end
    end
    object ppGroup3: TppGroup
      BreakName = 'PayType'
      DataPipeline = ppDBPipeline1
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      KeepTogether = True
      OutlineSettings.CreateNode = True
      StartOnOddPage = False
      UserName = 'Group3'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipeline1'
      NewFile = False
      object ppGroupHeaderBand3: TppGroupHeaderBand
        Background.Brush.Style = bsClear
        mmBottomOffset = 0
        mmHeight = 6085
        mmPrintPosition = 0
        object ppLabel14: TppLabel
          UserName = 'Label6'
          AutoSize = False
          Caption = 'PayType'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3704
          mmLeft = 3704
          mmTop = 529
          mmWidth = 17198
          BandType = 3
          GroupNo = 1
          LayerName = Foreground1
        end
        object ppDBText14: TppDBText
          UserName = 'DBText3'
          DataField = 'PayType'
          DataPipeline = ppDBPipeline1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipeline1'
          mmHeight = 3175
          mmLeft = 23813
          mmTop = 1058
          mmWidth = 18521
          BandType = 3
          GroupNo = 1
          LayerName = Foreground1
        end
        object ppDBCalc2: TppDBCalc
          UserName = 'Sum1'
          DataField = 'Amount'
          DataPipeline = ppDBPipeline1
          DisplayFormat = '$#,0.00;-$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = [fsBold]
          ResetGroup = ppGroup3
          TextAlignment = taRightJustified
          Transparent = True
          LookAhead = True
          DataPipelineName = 'ppDBPipeline1'
          mmHeight = 3704
          mmLeft = 45508
          mmTop = 529
          mmWidth = 19579
          BandType = 3
          GroupNo = 1
          LayerName = Foreground1
        end
      end
      object ppGroupFooterBand3: TppGroupFooterBand
        Background.Brush.Style = bsClear
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 6879
        mmPrintPosition = 0
      end
    end
    object ppDesignLayers2: TppDesignLayers
      object ppDesignLayer2: TppDesignLayer
        UserName = 'Foreground1'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList2: TppParameterList
    end
  end
end
