object frmArrivalsReport: TfrmArrivalsReport
  Left = 0
  Top = 0
  Caption = 'Arrivals'
  ClientHeight = 586
  ClientWidth = 991
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
  object pnlFilter: TsPanel
    Left = 0
    Top = 0
    Width = 991
    Height = 144
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 972
    object btnRefresh: TsButton
      Left = 398
      Top = 9
      Width = 118
      Height = 26
      Caption = 'Refresh'
      Default = True
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 1
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object gbxSelectDates: TsGroupBox
      Left = 21
      Top = 2
      Width = 370
      Height = 78
      Caption = 'Select dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object rbToday: TsRadioButton
        Left = 4
        Top = 21
        Width = 58
        Height = 19
        Caption = 'Today'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rbRadioButtonClick
      end
      object rbTomorrow: TsRadioButton
        Left = 4
        Top = 46
        Width = 76
        Height = 19
        Caption = 'Tomorrow'
        TabOrder = 1
        OnClick = rbRadioButtonClick
      end
      object rbManualRange: TsRadioButton
        Left = 119
        Top = 21
        Width = 122
        Height = 19
        Caption = 'Manual date range:'
        TabOrder = 2
        OnClick = rbRadioButtonClick
      end
      object dtDateFrom: TsDateEdit
        Left = 122
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
        TabOrder = 3
        Text = '  -  -    '
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        OnCloseUp = dtDateFromCloseUp
        DialogTitle = 'Date from select'
      end
      object dtDateTo: TsDateEdit
        Left = 233
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
        TabOrder = 4
        Text = '  -  -    '
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        OnCloseUp = dtDateToCloseUp
        DialogTitle = 'Date to select'
      end
    end
    object pnlExportButtons: TsPanel
      Left = 1
      Top = 104
      Width = 989
      Height = 39
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      ExplicitLeft = 2
      ExplicitTop = 105
      ExplicitWidth = 953
      object btnExcel: TsButton
        AlignWithMargins = True
        Left = 15
        Top = 5
        Width = 128
        Height = 29
        Margins.Left = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alLeft
        Caption = 'Excel'
        ImageIndex = 115
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = btnExcelClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnCheckIn: TsButton
        AlignWithMargins = True
        Left = 161
        Top = 5
        Width = 128
        Height = 29
        Margins.Left = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alLeft
        Caption = 'Check in'
        ImageIndex = 44
        Images = DImages.PngImageList1
        TabOrder = 1
        OnClick = btnCheckInClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnProfile: TsButton
        AlignWithMargins = True
        Left = 307
        Top = 5
        Width = 100
        Height = 29
        Margins.Left = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alLeft
        Caption = 'Profile'
        ImageIndex = 37
        Images = DImages.PngImageList1
        TabOrder = 2
        OnClick = btnProfileClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnInvoice: TsButton
        AlignWithMargins = True
        Left = 425
        Top = 5
        Width = 128
        Height = 29
        Margins.Left = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alLeft
        Caption = 'Invoice'
        DropDownMenu = pmnuInvoiceMenu
        ImageIndex = 62
        Images = DImages.PngImageList1
        Style = bsSplitButton
        TabOrder = 3
        SkinData.SkinSection = 'BUTTON'
      end
      object btnReport: TsButton
        AlignWithMargins = True
        Left = 846
        Top = 5
        Width = 128
        Height = 29
        Margins.Left = 15
        Margins.Top = 5
        Margins.Right = 15
        Margins.Bottom = 5
        Align = alRight
        Caption = 'Report'
        ImageIndex = 69
        Images = DImages.PngImageList1
        TabOrder = 4
        OnClick = btnReportClick
        SkinData.SkinSection = 'BUTTON'
        ExplicitLeft = 827
      end
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 566
    Width = 991
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ExplicitTop = 540
    ExplicitWidth = 972
  end
  object grArrivalsList: TcxGrid
    Left = 0
    Top = 144
    Width = 991
    Height = 422
    Align = alClient
    PopupMenu = pnmuGridMenu
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    ExplicitLeft = 1
    ExplicitTop = 146
    ExplicitWidth = 955
    object grArrivalsListDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = grArrivalsListDBTableView1CellDblClick
      DataController.DataSource = ArrivalsListDS
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsView.ColumnAutoWidth = True
      Styles.Group = cxStyle1
      Styles.GroupSummary = cxStyle1
      object grArrivalsListDBTableView1Room: TcxGridDBColumn
        DataBinding.FieldName = 'Room'
        Options.Editing = False
      end
      object grArrivalsListDBTableView1GuestName: TcxGridDBColumn
        Caption = 'Guest name'
        DataBinding.FieldName = 'GuestName'
        Options.Editing = False
        Width = 263
      end
      object grArrivalsListDBTableView1RoomerReservationID: TcxGridDBColumn
        Caption = 'Reservation ID'
        DataBinding.FieldName = 'RoomerReservationID'
        Options.Editing = False
        Width = 83
      end
      object grArrivalsListDBTableView1CompanyCode: TcxGridDBColumn
        Caption = 'Company code'
        DataBinding.FieldName = 'CompanyCode'
        Options.Editing = False
      end
      object grArrivalsListDBTableView1Arrival: TcxGridDBColumn
        DataBinding.FieldName = 'Arrival'
        Options.Editing = False
      end
      object grArrivalsListDBTableView1Departure: TcxGridDBColumn
        DataBinding.FieldName = 'Departure'
        Options.Editing = False
      end
      object grArrivalsListDBTableView1Roomtype: TcxGridDBColumn
        Caption = 'Room type'
        DataBinding.FieldName = 'Roomtype'
        Options.Editing = False
        Width = 66
      end
      object grArrivalsListDBTableView1NumGuests: TcxGridDBColumn
        Caption = 'Num guests'
        DataBinding.FieldName = 'NumGuests'
        Options.Editing = False
      end
      object grArrivalsListDBTableView1AverageRoomRate: TcxGridDBColumn
        Caption = 'Average Rate'
        DataBinding.FieldName = 'AverageRoomRate'
        Options.Editing = False
        Width = 82
      end
      object grArrivalsListDBTableView1ExpectedTimeOfArrival: TcxGridDBColumn
        Caption = 'Expected TOA'
        DataBinding.FieldName = 'ExpectedTimeOfArrival'
        PropertiesClassName = 'TcxTimeEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.UseTimeFormatWhenUnfocused = False
        OnGetDisplayText = grArrivalsListDBTableView1ExpectedTimeOfArrivalGetDisplayText
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 88
      end
      object grArrivalsListDBTableView1RoomerRoomReservationID: TcxGridDBColumn
        Caption = 'Room Res ID'
        DataBinding.FieldName = 'RoomerRoomReservationID'
        Visible = False
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
      end
    end
    object lvArrivalsListLevel1: TcxGridLevel
      GridView = grArrivalsListDBTableView1
    end
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
      end>
    StorageName = 'Software\Roomer\FormStatus\frmRptArrivals'
    StorageType = stRegistry
    Left = 330
    Top = 358
  end
  object kbmArrivalsList: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Room'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Roomtype'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'RoomerReservationID'
        DataType = ftInteger
      end
      item
        Name = 'GuestName'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'CompanyCode'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Arrival'
        DataType = ftDate
      end
      item
        Name = 'Departure'
        DataType = ftDate
      end
      item
        Name = 'NumGuests'
        DataType = ftInteger
      end
      item
        Name = 'AverageRoomRate'
        DataType = ftFloat
      end
      item
        Name = 'ExpectedTimeOfArrival'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'RoomerRoomReservationID'
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
    AfterScroll = kbmArrivalsListAfterScroll
    Left = 416
    Top = 359
    object kbmArrivalsListfldRoom: TStringField
      FieldName = 'Room'
      Size = 10
    end
    object kbmArrivalsListfldRoomtype: TStringField
      FieldName = 'Roomtype'
    end
    object kbmArrivalsListfldRoomerReservationID: TIntegerField
      FieldName = 'RoomerReservationID'
    end
    object kbmArrivalsListfldGuestName: TStringField
      FieldName = 'GuestName'
      Size = 100
    end
    object kbmArrivalsListfldCompanyCode: TStringField
      FieldName = 'CompanyCode'
      Size = 15
    end
    object kbmArrivalsListfldArrival: TDateField
      FieldName = 'Arrival'
    end
    object kbmArrivalsListfldDeparture: TDateField
      FieldName = 'Departure'
    end
    object kbmArrivalsListfldNumGuests: TIntegerField
      FieldName = 'NumGuests'
    end
    object kbmArrivalsListAverageRoomRate: TFloatField
      FieldName = 'AverageRoomRate'
      currency = True
    end
    object kbmArrivalsListExpectedTimeOfArrival: TStringField
      FieldName = 'ExpectedTimeOfArrival'
      Size = 5
    end
    object kbmArrivalsListRoomerRoomReservationID: TIntegerField
      FieldName = 'RoomerRoomReservationID'
    end
  end
  object ArrivalsListDS: TDataSource
    DataSet = kbmArrivalsList
    Left = 488
    Top = 359
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 176
    Top = 240
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object pmnuInvoiceMenu: TPopupMenu
    Images = DImages.cxSmallImagesFlat
    Left = 480
    Top = 224
    object R1: TMenuItem
      Caption = 'Room Invoice'
      Default = True
      ImageIndex = 62
      OnClick = mnuRoomInvoiceClick
    end
    object G1: TMenuItem
      Caption = 'Group Invoice'
      ImageIndex = 60
      OnClick = mnuGroupInvoiceClick
    end
  end
  object pnmuGridMenu: TPopupMenu
    Left = 184
    Top = 368
    object mnuCheckin: TMenuItem
      Caption = 'Check in'
      OnClick = btnCheckInClick
    end
    object mnuProfile: TMenuItem
      Caption = 'Profile'
      OnClick = btnProfileClick
    end
    object mnuInvoice: TMenuItem
      Caption = 'Invoice'
      object mnuRoomInvoice: TMenuItem
        Caption = 'Room invoice'
        OnClick = mnuRoomInvoiceClick
      end
      object mnuGroupInvoice: TMenuItem
        Caption = 'Group invoice'
        OnClick = mnuGroupInvoiceClick
      end
    end
  end
  object plArrivalsList: TppDBPipeline
    DataSource = dsArrivalsReport
    UserName = 'plArrivalsList'
    Left = 120
    Top = 283
  end
  object rptArrivals: TppReport
    AutoStop = False
    DataPipeline = plArrivalsList
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
    AllowPrintToArchive = True
    AllowPrintToFile = True
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
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
    Left = 40
    Top = 283
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'plArrivalsList'
    object ppHeaderBand1: TppHeaderBand
      BeforePrint = ppHeaderBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 29633
      mmPrintPosition = 0
      object ppLine1: TppLine
        UserName = 'Line1'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 1588
        mmLeft = 0
        mmTop = 29369
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'Arrivals Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 7535
        mmLeft = 2646
        mmTop = 529
        mmWidth = 45508
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        Caption = 'From :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 2910
        mmTop = 9525
        mmWidth = 9790
        BandType = 0
        LayerName = Foreground
      end
      object rlabFrom: TppLabel
        UserName = 'rLabFrom'
        Caption = '01.01.2010'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 15081
        mmTop = 9525
        mmWidth = 15875
        BandType = 0
        LayerName = Foreground
      end
      object rLabTo: TppLabel
        UserName = 'rLabTo'
        Caption = '01.01.2010'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 42333
        mmTop = 9525
        mmWidth = 15875
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = 'To :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 34660
        mmTop = 9525
        mmWidth = 5556
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
      object ppLine11: TppLine
        UserName = 'Line11'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 0
        mmTop = 14288
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Room'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 2646
        mmTop = 23813
        mmWidth = 10054
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'GuestName'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 15081
        mmTop = 23813
        mmWidth = 23019
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'Res ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 46302
        mmTop = 23813
        mmWidth = 14817
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Company'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 61913
        mmTop = 23813
        mmWidth = 29104
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Caption = 'Arrival'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 92340
        mmTop = 23813
        mmWidth = 15346
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        AutoSize = False
        Caption = 'Departure'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 109273
        mmTop = 23813
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        AutoSize = False
        Caption = 'Roomtype'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 129117
        mmTop = 23813
        mmWidth = 14552
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel12: TppLabel
        UserName = 'Label12'
        AutoSize = False
        Caption = 'Guests'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 144727
        mmTop = 23813
        mmWidth = 11377
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        AutoSize = False
        Caption = 'Avg rate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 157163
        mmTop = 23813
        mmWidth = 18785
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel14: TppLabel
        UserName = 'Label14'
        AutoSize = False
        Caption = 'Arrival time'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 177536
        mmTop = 23813
        mmWidth = 16933
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 7673
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'Room'
        DataPipeline = plArrivalsList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plArrivalsList'
        mmHeight = 3704
        mmLeft = 2910
        mmTop = 794
        mmWidth = 9790
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'GuestName'
        DataPipeline = plArrivalsList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plArrivalsList'
        mmHeight = 3704
        mmLeft = 15081
        mmTop = 794
        mmWidth = 30427
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'RoomerReservationID'
        DataPipeline = plArrivalsList
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plArrivalsList'
        mmHeight = 3598
        mmLeft = 46302
        mmTop = 794
        mmWidth = 14817
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'CompanyCode'
        DataPipeline = plArrivalsList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plArrivalsList'
        mmHeight = 3704
        mmLeft = 61913
        mmTop = 794
        mmWidth = 29104
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'Arrival'
        DataPipeline = plArrivalsList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plArrivalsList'
        mmHeight = 3704
        mmLeft = 92340
        mmTop = 794
        mmWidth = 15346
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'Departure'
        DataPipeline = plArrivalsList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plArrivalsList'
        mmHeight = 3704
        mmLeft = 109273
        mmTop = 794
        mmWidth = 19050
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'Roomtype'
        DataPipeline = plArrivalsList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plArrivalsList'
        mmHeight = 3704
        mmLeft = 129117
        mmTop = 794
        mmWidth = 14552
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        DataField = 'NumGuests'
        DataPipeline = plArrivalsList
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plArrivalsList'
        mmHeight = 3598
        mmLeft = 144727
        mmTop = 794
        mmWidth = 11377
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText9: TppDBText
        UserName = 'DBText9'
        DataField = 'AverageRoomRate'
        DataPipeline = plArrivalsList
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plArrivalsList'
        mmHeight = 3598
        mmLeft = 157163
        mmTop = 794
        mmWidth = 18785
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText10: TppDBText
        UserName = 'DBText10'
        DataField = 'ExpectedTimeOfArrival'
        DataPipeline = plArrivalsList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plArrivalsList'
        mmHeight = 3598
        mmLeft = 177536
        mmTop = 794
        mmWidth = 16933
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 6615
      mmPrintPosition = 0
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
        mmLeft = 13229
        mmTop = 2117
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground
      end
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
        mmLeft = 2910
        mmTop = 2117
        mmWidth = 9260
        BandType = 8
        LayerName = Foreground
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 794
        mmLeft = 0
        mmTop = 265
        mmWidth = 197300
        BandType = 8
        LayerName = Foreground
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
  object kbmArrivalsReport: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Room'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Roomtype'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'RoomerReservationID'
        DataType = ftInteger
      end
      item
        Name = 'GuestName'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'CompanyCode'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Arrival'
        DataType = ftDate
      end
      item
        Name = 'Departure'
        DataType = ftDate
      end
      item
        Name = 'NumGuests'
        DataType = ftInteger
      end
      item
        Name = 'AverageRoomRate'
        DataType = ftFloat
      end
      item
        Name = 'ExpectedTimeOfArrival'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'RoomerRoomReservationID'
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
    AfterScroll = kbmArrivalsListAfterScroll
    Left = 72
    Top = 335
    object StringField1: TStringField
      FieldName = 'Room'
      Size = 10
    end
    object StringField2: TStringField
      FieldName = 'Roomtype'
    end
    object IntegerField1: TIntegerField
      FieldName = 'RoomerReservationID'
    end
    object StringField3: TStringField
      FieldName = 'GuestName'
      Size = 100
    end
    object StringField4: TStringField
      FieldName = 'CompanyCode'
      Size = 15
    end
    object DateField1: TDateField
      FieldName = 'Arrival'
    end
    object DateField2: TDateField
      FieldName = 'Departure'
    end
    object IntegerField2: TIntegerField
      FieldName = 'NumGuests'
    end
    object FloatField1: TFloatField
      FieldName = 'AverageRoomRate'
      currency = True
    end
    object StringField5: TStringField
      FieldName = 'ExpectedTimeOfArrival'
      Size = 5
    end
    object IntegerField3: TIntegerField
      FieldName = 'RoomerRoomReservationID'
    end
  end
  object dsArrivalsReport: TDataSource
    DataSet = kbmArrivalsReport
    Left = 72
    Top = 383
  end
end
