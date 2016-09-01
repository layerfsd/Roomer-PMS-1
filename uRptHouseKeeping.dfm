object frmHouseKeepingReport: TfrmHouseKeepingReport
  Left = 0
  Top = 0
  Caption = 'HouseKeeping list'
  ClientHeight = 586
  ClientWidth = 1123
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
    Width = 1123
    Height = 137
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object btnRefresh: TsButton
      Left = 242
      Top = 22
      Width = 118
      Height = 26
      Caption = 'Refresh'
      Default = True
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object pnlExportButtons: TsPanel
      Left = 1
      Top = 93
      Width = 1121
      Height = 43
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
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
      object btnReport: TsButton
        AlignWithMargins = True
        Left = 990
        Top = 3
        Width = 128
        Height = 37
        Align = alRight
        Caption = 'Report'
        ImageIndex = 69
        Images = DImages.PngImageList1
        TabOrder = 1
        Visible = False
        OnClick = btnReportClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnPrintGrid: TsButton
        AlignWithMargins = True
        Left = 856
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
        ExplicitTop = 1
      end
    end
    object gbxSelection: TsGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 221
      Height = 86
      Align = alLeft
      Caption = 'Select date and location'
      TabOrder = 2
      Checked = False
      object lblDate: TsLabel
        Left = 47
        Top = 23
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Date: '
      end
      object lblLocation: TsLabel
        Left = 33
        Top = 50
        Width = 44
        Height = 13
        Alignment = taRightJustify
        Caption = 'Location:'
      end
      object dtDate: TsDateEdit
        Left = 91
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
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        DefaultToday = True
        DialogTitle = 'Housekeeping date'
      end
      object cbxLocations: TsComboBox
        Left = 91
        Top = 47
        Width = 105
        Height = 21
        Alignment = taLeftJustify
        VerticalAlignment = taAlignTop
        Style = csDropDownList
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 566
    Width = 1123
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object grHouseKeepingList: TcxGrid
    Left = 0
    Top = 137
    Width = 1123
    Height = 429
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    ExplicitTop = 139
    object grHouseKeepingListDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = HouseKeepingListDS
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      Styles.Group = cxStyle1
      Styles.GroupSummary = cxStyle1
      object grHouseKeepingListDBTableView1location: TcxGridDBColumn
        Caption = 'Location'
        DataBinding.FieldName = 'location'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
      end
      object grHouseKeepingListDBTableView1floor: TcxGridDBColumn
        Caption = 'Floor'
        DataBinding.FieldName = 'floor'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 67
      end
      object grHouseKeepingListDBTableView1room: TcxGridDBColumn
        Caption = 'Room'
        DataBinding.FieldName = 'room'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 2
        SortOrder = soAscending
        Width = 86
      end
      object grHouseKeepingListDBTableView1roomtype: TcxGridDBColumn
        Caption = 'RoomType'
        DataBinding.FieldName = 'roomtype'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 88
      end
      object grHouseKeepingListDBTableView1numguests: TcxGridDBColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'numguests'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
      end
      object grHouseKeepingListDBTableView1expectedcot: TcxGridDBColumn
        Caption = 'Checkout time'
        DataBinding.FieldName = 'expectedcot'
        PropertiesClassName = 'TcxTimeEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.TimeFormat = tfHourMin
        HeaderAlignmentHorz = taCenter
        Width = 105
      end
      object grHouseKeepingListDBTableView1status: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'status'
        PropertiesClassName = 'TcxTextEditProperties'
        Options.Editing = False
        Width = 666
      end
    end
    object lvHouseKeepingListLevel1: TcxGridLevel
      GridView = grHouseKeepingListDBTableView1
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
    StorageName = 'Software\Roomer\FormStatus\frmRptHouseKeeping'
    StorageType = stRegistry
    Left = 274
    Top = 358
  end
  object kbmHouseKeepingList: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'room'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'roomtype'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'floor'
        DataType = ftInteger
      end
      item
        Name = 'numberofguests'
        DataType = ftInteger
      end
      item
        Name = 'expectedcot'
        DataType = ftTime
      end
      item
        Name = 'status'
        DataType = ftString
        Size = 20
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
    AfterScroll = kbmHouseKeepingListAfterScroll
    Left = 432
    Top = 311
    object kbmHouseKeepingListroom: TStringField
      FieldName = 'room'
      Size = 10
    end
    object kbmHouseKeepingListroomtype: TStringField
      FieldName = 'roomtype'
      Size = 10
    end
    object kbmHouseKeepingListfloor: TIntegerField
      FieldName = 'floor'
    end
    object kbmHouseKeepingListnumberofguests: TIntegerField
      FieldName = 'numguests'
    end
    object kbmHouseKeepingListexpectedcot: TTimeField
      FieldName = 'expectedcot'
    end
    object kbmHouseKeepingListstatus: TStringField
      FieldName = 'status'
    end
    object kbmHouseKeepingListlocation: TStringField
      FieldName = 'location'
      Size = 10
    end
  end
  object HouseKeepingListDS: TDataSource
    DataSet = kbmHouseKeepingList
    Left = 440
    Top = 367
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
  object plHouseKeepingList: TppDBPipeline
    DataSource = dsHouseKeepingReport
    UserName = 'plHouseKeepingList'
    Left = 160
    Top = 451
    object plHouseKeepingListppField1: TppField
      FieldAlias = 'room'
      FieldName = 'room'
      FieldLength = 10
      DisplayWidth = 10
      Position = 0
    end
    object plHouseKeepingListppField2: TppField
      FieldAlias = 'roomtype'
      FieldName = 'roomtype'
      FieldLength = 10
      DisplayWidth = 10
      Position = 1
    end
    object plHouseKeepingListppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'floor'
      FieldName = 'floor'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 2
    end
    object plHouseKeepingListppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'numguests'
      FieldName = 'numguests'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 3
    end
    object plHouseKeepingListppField5: TppField
      FieldAlias = 'expectedcot'
      FieldName = 'expectedcot'
      FieldLength = 0
      DataType = dtTime
      DisplayWidth = 10
      Position = 4
    end
    object plHouseKeepingListppField6: TppField
      FieldAlias = 'location'
      FieldName = 'location'
      FieldLength = 10
      DisplayWidth = 10
      Position = 5
    end
    object plHouseKeepingListppField7: TppField
      FieldAlias = 'status'
      FieldName = 'status'
      FieldLength = 20
      DisplayWidth = 20
      Position = 6
    end
  end
  object rptHouseKeeping: TppReport
    AutoStop = False
    DataPipeline = plHouseKeepingList
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
    Left = 64
    Top = 451
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'plHouseKeepingList'
    object ppHeaderBand1: TppHeaderBand
      BeforePrint = ppHeaderBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 29633
      mmPrintPosition = 0
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'HouseKeeping List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 7535
        mmLeft = 2646
        mmTop = 529
        mmWidth = 57531
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        Caption = 'Date :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 2910
        mmTop = 9525
        mmWidth = 8805
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
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4498
        mmLeft = 43392
        mmTop = 23813
        mmWidth = 13758
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Roomtype'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4498
        mmLeft = 59002
        mmTop = 23813
        mmWidth = 19844
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'Floor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4487
        mmLeft = 27517
        mmTop = 23813
        mmWidth = 14552
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = 'Guests'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4487
        mmLeft = 80963
        mmTop = 23813
        mmWidth = 12361
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Exp. COT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4498
        mmLeft = 95250
        mmTop = 23813
        mmWidth = 18256
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Caption = 'Status'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4487
        mmLeft = 116417
        mmTop = 23813
        mmWidth = 11906
        BandType = 0
        LayerName = Foreground
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 794
        mmLeft = 0
        mmTop = 29104
        mmWidth = 197380
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        AutoSize = False
        Caption = 'Location'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4498
        mmLeft = 2910
        mmTop = 23813
        mmWidth = 14552
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
        DataPipeline = plHouseKeepingList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plHouseKeepingList'
        mmHeight = 4498
        mmLeft = 43656
        mmTop = 794
        mmWidth = 13494
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'roomtype'
        DataPipeline = plHouseKeepingList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plHouseKeepingList'
        mmHeight = 4498
        mmLeft = 59002
        mmTop = 794
        mmWidth = 19844
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'floor'
        DataPipeline = plHouseKeepingList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plHouseKeepingList'
        mmHeight = 4487
        mmLeft = 27781
        mmTop = 794
        mmWidth = 14288
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'numguests'
        DataPipeline = plHouseKeepingList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'plHouseKeepingList'
        mmHeight = 4487
        mmLeft = 80963
        mmTop = 794
        mmWidth = 12435
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'expectedcot'
        DataPipeline = plHouseKeepingList
        DisplayFormat = 'h:nn'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'plHouseKeepingList'
        mmHeight = 4498
        mmLeft = 95250
        mmTop = 794
        mmWidth = 18256
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'status'
        DataPipeline = plHouseKeepingList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plHouseKeepingList'
        mmHeight = 4498
        mmLeft = 116417
        mmTop = 794
        mmWidth = 79375
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'location'
        DataPipeline = plHouseKeepingList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plHouseKeepingList'
        mmHeight = 4498
        mmLeft = 2910
        mmTop = 794
        mmWidth = 22225
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
  object kbmHouseKeepingReport: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'room'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'roomtype'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'floor'
        DataType = ftInteger
      end
      item
        Name = 'numguests'
        DataType = ftInteger
      end
      item
        Name = 'expectedcot'
        DataType = ftTime
      end
      item
        Name = 'location'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'status'
        DataType = ftString
        Size = 20
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
    AfterScroll = kbmHouseKeepingListAfterScroll
    Left = 72
    Top = 319
    object kbmHouseKeepingReportroom: TStringField
      FieldName = 'room'
      Size = 10
    end
    object kbmHouseKeepingReportroomtype: TStringField
      FieldName = 'roomtype'
      Size = 10
    end
    object kbmHouseKeepingReportfloor: TIntegerField
      FieldName = 'floor'
    end
    object kbmHouseKeepingReportnumberguests: TIntegerField
      FieldName = 'numguests'
    end
    object kbmHouseKeepingReportexpectedcot: TTimeField
      FieldName = 'expectedcot'
    end
    object kbmHouseKeepingReportlocation: TStringField
      FieldName = 'location'
      Size = 10
    end
    object kbmHouseKeepingReportstatus: TStringField
      FieldName = 'status'
    end
  end
  object dsHouseKeepingReport: TDataSource
    DataSet = kbmHouseKeepingReport
    Left = 72
    Top = 383
  end
  object cxPropertiesStore1: TcxPropertiesStore
    Components = <>
    StorageName = 'cxPropertiesStore1'
    Left = 424
    Top = 312
  end
  object gridPrinter: TdxComponentPrinter
    CurrentLink = gridPrinterLink1
    Version = 0
    Left = 680
    Top = 328
    object gridPrinterLink1: TdxGridReportLink
      Active = True
      Component = grHouseKeepingList
      PageNumberFormat = pnfNumeral
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
      ReportDocument.CreationDate = 42614.400140000000000000
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clBlack
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Arial'
      ReportTitle.Font.Style = [fsBold]
      ShrinkToPageWidth = True
      AssignedFormatValues = [fvTime, fvPageNumber]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      OptionsFormatting.LookAndFeelKind = lfFlat
      OptionsFormatting.UseNativeStyles = True
      StyleRepository = cxStyleRepository2
      Styles.StyleSheet = dxGridReportLinkStyleSheet1
      BuiltInReportLink = True
    end
  end
  object cxStyleRepository2: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle6: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle7: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 16053492
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle8: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle9: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle10: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle11: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxStyle12: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxStyle13: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle14: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
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
end
