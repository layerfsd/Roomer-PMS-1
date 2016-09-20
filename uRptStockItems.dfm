object frmRptStockItems: TfrmRptStockItems
  Left = 0
  Top = 0
  Caption = 'Stock items report'
  ClientHeight = 572
  ClientWidth = 1011
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFilter: TsPanel
    Left = 0
    Top = 0
    Width = 1011
    Height = 144
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object btnRefresh: TsButton
      Left = 378
      Top = 14
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
      Left = 4
      Top = 0
      Width = 368
      Height = 94
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
      Top = 100
      Width = 1009
      Height = 43
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      object btnExcel: TsButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 128
        Height = 37
        Align = alLeft
        Caption = 'Excel'
        ImageIndex = 115
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = btnExcelClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnProfile: TsButton
        AlignWithMargins = True
        Left = 137
        Top = 3
        Width = 100
        Height = 37
        Align = alLeft
        Caption = 'Profile'
        ImageIndex = 37
        Images = DImages.PngImageList1
        TabOrder = 1
        OnClick = btnProfileClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnReport: TsButton
        AlignWithMargins = True
        Left = 878
        Top = 3
        Width = 128
        Height = 37
        Align = alRight
        Caption = 'Report'
        ImageIndex = 69
        Images = DImages.PngImageList1
        TabOrder = 3
        OnClick = btnReportClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnInvoice: TsButton
        AlignWithMargins = True
        Left = 243
        Top = 3
        Width = 128
        Height = 37
        Align = alLeft
        Caption = 'Invoice'
        DropDownMenu = pmnuInvoiceMenu
        ImageIndex = 62
        Images = DImages.PngImageList1
        Style = bsSplitButton
        TabOrder = 2
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 552
    Width = 1011
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object grStockItems: TcxGrid
    Left = 0
    Top = 144
    Width = 1011
    Height = 408
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    object grStockItemsDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsStockitems
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.HeaderAutoHeight = True
      object grStockItemsDBTableView1Room: TcxGridDBColumn
        DataBinding.FieldName = 'Room'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 78
      end
      object grStockItemsDBTableView1Reservation: TcxGridDBColumn
        DataBinding.FieldName = 'Reservation'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 78
      end
      object grStockItemsDBTableView1Guestname: TcxGridDBColumn
        DataBinding.FieldName = 'Guestname'
        Width = 175
      end
      object grStockItemsDBTableView1Company: TcxGridDBColumn
        DataBinding.FieldName = 'Company'
        Width = 172
      end
      object grStockItemsDBTableView1Description: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Width = 247
      end
      object grStockItemsDBTableView1Count: TcxGridDBColumn
        DataBinding.FieldName = 'Count'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 72
      end
      object grStockItemsDBTableView1ReservedFrom: TcxGridDBColumn
        Caption = 'Reserved From'
        DataBinding.FieldName = 'ReservedFrom'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 95
      end
      object grStockItemsDBTableView1ReservedTo: TcxGridDBColumn
        Caption = 'Reserved To'
        DataBinding.FieldName = 'ReservedTo'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 92
      end
    end
    object lvStockitemsLevel1: TcxGridLevel
      GridView = grStockItemsDBTableView1
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
    StorageName = 'Software\Roomer\FormStatus\frmRptStockItems'
    StorageType = stRegistry
    Left = 330
    Top = 358
  end
  object kbmStockItems: TkbmMemTable
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
    AfterScroll = kbmStockItemsAfterScroll
    Left = 336
    Top = 287
    object kbmStockItemsRoom: TStringField
      FieldName = 'Room'
    end
    object kbmStockItemsGuestname: TStringField
      FieldName = 'Guestname'
      Size = 100
    end
    object kbmStockItemsReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object kbmStockItemsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object kbmStockItemsCompany: TStringField
      FieldName = 'Company'
      Size = 100
    end
    object kbmStockItemsStockitem: TStringField
      FieldName = 'Stockitem'
      Size = 30
    end
    object kbmStockItemsCount: TIntegerField
      FieldName = 'Count'
    end
    object kbmStockItemsReservedFrom: TDateField
      FieldName = 'ReservedFrom'
    end
    object kbmStockItemsReservedTo: TDateField
      FieldName = 'ReservedTo'
    end
    object kbmStockItemsDescription: TStringField
      FieldName = 'Description'
      Size = 45
    end
  end
  object dsStockitems: TDataSource
    DataSet = kbmStockItems
    Left = 432
    Top = 287
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 672
    Top = 232
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
  object plStockItems: TppDBPipeline
    DataSource = dsStockitemsReport
    UserName = 'plStockItems'
    Left = 120
    Top = 283
    object plStockItemsppField1: TppField
      FieldAlias = 'Room'
      FieldName = 'Room'
      FieldLength = 20
      DisplayWidth = 20
      Position = 0
    end
    object plStockItemsppField2: TppField
      FieldAlias = 'Guestname'
      FieldName = 'Guestname'
      FieldLength = 100
      DisplayWidth = 100
      Position = 1
    end
    object plStockItemsppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'Reservation'
      FieldName = 'Reservation'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 2
    end
    object plStockItemsppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'RoomReservation'
      FieldName = 'RoomReservation'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 3
    end
    object plStockItemsppField5: TppField
      FieldAlias = 'Company'
      FieldName = 'Company'
      FieldLength = 100
      DisplayWidth = 100
      Position = 4
    end
    object plStockItemsppField6: TppField
      FieldAlias = 'Stockitem'
      FieldName = 'Stockitem'
      FieldLength = 30
      DisplayWidth = 30
      Position = 5
    end
    object plStockItemsppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'Count'
      FieldName = 'Count'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 6
    end
    object plStockItemsppField8: TppField
      FieldAlias = 'ReservedFrom'
      FieldName = 'ReservedFrom'
      FieldLength = 0
      DataType = dtDate
      DisplayWidth = 10
      Position = 7
    end
    object plStockItemsppField9: TppField
      FieldAlias = 'ReservedTo'
      FieldName = 'ReservedTo'
      FieldLength = 0
      DataType = dtDate
      DisplayWidth = 10
      Position = 8
    end
    object plStockItemsppField10: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 45
      DisplayWidth = 45
      Position = 9
    end
  end
  object rptStockitems: TppReport
    AutoStop = False
    DataPipeline = plStockItems
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
    Left = 40
    Top = 283
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'plStockItems'
    object ppHeaderBand1: TppHeaderBand
      BeforePrint = ppHeaderBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 29104
      mmPrintPosition = 0
      object ppLine1: TppLine
        UserName = 'Line1'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 1588
        mmLeft = 0
        mmTop = 27516
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'Stockitems Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 7535
        mmLeft = 2646
        mmTop = 529
        mmWidth = 56049
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
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3598
        mmLeft = 2910
        mmTop = 18785
        mmWidth = 12171
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Guestname'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 34925
        mmTop = 18785
        mmWidth = 23813
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'Reservation'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 16140
        mmTop = 18785
        mmWidth = 17727
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
        mmLeft = 72496
        mmTop = 18785
        mmWidth = 20902
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Caption = 'Description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 110331
        mmTop = 18785
        mmWidth = 22225
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        AutoSize = False
        Caption = 'Count'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3598
        mmLeft = 143404
        mmTop = 18785
        mmWidth = 10054
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        AutoSize = False
        Caption = 'Reserved From'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 8202
        mmLeft = 155046
        mmTop = 18785
        mmWidth = 18785
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel12: TppLabel
        UserName = 'Label12'
        AutoSize = False
        Caption = 'Reserved To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 8202
        mmLeft = 177800
        mmTop = 18785
        mmWidth = 17727
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 5292
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'Room'
        DataPipeline = plStockItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'plStockItems'
        mmHeight = 3598
        mmLeft = 2910
        mmTop = 794
        mmWidth = 12171
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'Guestname'
        DataPipeline = plStockItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plStockItems'
        mmHeight = 3704
        mmLeft = 34925
        mmTop = 794
        mmWidth = 36513
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'Reservation'
        DataPipeline = plStockItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'plStockItems'
        mmHeight = 3598
        mmLeft = 16140
        mmTop = 794
        mmWidth = 17727
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'Company'
        DataPipeline = plStockItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plStockItems'
        mmHeight = 3704
        mmLeft = 72496
        mmTop = 794
        mmWidth = 37042
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'Description'
        DataPipeline = plStockItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plStockItems'
        mmHeight = 3704
        mmLeft = 110331
        mmTop = 794
        mmWidth = 31750
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'Count'
        DataPipeline = plStockItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'plStockItems'
        mmHeight = 3598
        mmLeft = 143404
        mmTop = 794
        mmWidth = 10054
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'ReservedFrom'
        DataPipeline = plStockItems
        DisplayFormat = 'mm/dd/yy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'plStockItems'
        mmHeight = 3598
        mmLeft = 155046
        mmTop = 794
        mmWidth = 18785
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        DataField = 'ReservedTo'
        DataPipeline = plStockItems
        DisplayFormat = 'mm/dd/yy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'plStockItems'
        mmHeight = 3598
        mmLeft = 177271
        mmTop = 794
        mmWidth = 18785
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
  object kbmStockitemsReport: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Room'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Guestname'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'Company'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Stockitem'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Count'
        DataType = ftInteger
      end
      item
        Name = 'ReservedFrom'
        DataType = ftDate
      end
      item
        Name = 'ReservedTo'
        DataType = ftDate
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 45
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
    Left = 72
    Top = 335
    object kbmStockItemsReportRoom: TStringField
      FieldName = 'Room'
    end
    object kbmStockItemsReportGuestname: TStringField
      FieldName = 'Guestname'
      Size = 100
    end
    object kbmStockItemsReportReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object kbmStockItemsReportRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object kbmStockItemsReportCompany: TStringField
      FieldName = 'Company'
      Size = 100
    end
    object kbmStockItemsReportStockitem: TStringField
      FieldName = 'Stockitem'
      Size = 30
    end
    object kbmStockItemsReportCount: TIntegerField
      FieldName = 'Count'
    end
    object kbmStockItemsReportReservedFrom: TDateField
      FieldName = 'ReservedFrom'
    end
    object kbmStockItemsReportReservedTo: TDateField
      FieldName = 'ReservedTo'
    end
    object kbmStockItemsReportDescription: TStringField
      FieldName = 'Description'
      Size = 45
    end
  end
  object dsStockitemsReport: TDataSource
    DataSet = kbmStockitemsReport
    Left = 72
    Top = 383
  end
  object pmnuInvoiceMenu: TPopupMenu
    Images = DImages.cxSmallImagesFlat
    Left = 383
    Top = 90
    object mnuRoomInvoice: TMenuItem
      Caption = 'Room Invoice'
      Default = True
      ImageIndex = 62
      OnClick = mnuRoomInvoiceClick
    end
    object mnuGroupInvoice: TMenuItem
      Caption = 'Group Invoice'
      ImageIndex = 60
      OnClick = mnuGroupInvoiceClick
    end
  end
end
