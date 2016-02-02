object frmHouseKeeping: TfrmHouseKeeping
  Left = 0
  Top = 0
  Caption = 'House keeping'
  ClientHeight = 505
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSimplePanel1: TsPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object labLocations: TsLabel
      AlignWithMargins = True
      Left = 406
      Top = 20
      Width = 70
      Height = 18
      Alignment = taRightJustify
      Caption = 'Locations :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labLocationsList: TsLabel
      Left = 485
      Top = 20
      Width = 13
      Height = 18
      Caption = 'All'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object gbxSElectDate: TsGroupBox
      Left = 8
      Top = 4
      Width = 193
      Height = 48
      Caption = 'Select date'
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      object sLabel1: TsLabel
        Left = 4
        Top = 20
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Date :'
      end
      object dtDate: TsDateEdit
        Left = 80
        Top = 17
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
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
    object sButton1: TsButton
      Left = 207
      Top = 19
      Width = 100
      Height = 25
      Caption = 'Refresh'
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 1
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object pageMain: TsPageControl
    Left = 0
    Top = 65
    Width = 900
    Height = 421
    ActivePage = sTabSheet1
    Align = alClient
    Style = tsFlatButtons
    TabHeight = 25
    TabOrder = 1
    TabWidth = 100
    SkinData.SkinSection = 'PAGECONTROL'
    object sTabSheet1: TsTabSheet
      Caption = 'List'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grCross: TAdvStringGrid
        Left = 0
        Top = 33
        Width = 892
        Height = 353
        Cursor = crDefault
        Align = alClient
        ColCount = 6
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing]
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        HoverRowCells = [hcNormal, hcSelected]
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
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
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
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
        ScrollWidth = 21
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        Version = '6.2.7.0'
        RowHeights = (
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22)
      end
      object LMDSimplePanel5: TsPanel
        Left = 0
        Top = 0
        Width = 892
        Height = 33
        Align = alTop
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object LMDSpeedButton6: TsButton
          Left = 4
          Top = 2
          Width = 100
          Height = 25
          Caption = 'EXCEL'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = LMDSpeedButton6Click
          SkinData.SkinSection = 'BUTTON'
        end
        object LMDSpeedButton12: TsButton
          Left = 107
          Top = 2
          Width = 100
          Height = 25
          Caption = 'HTML'
          ImageIndex = 99
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = LMDSpeedButton12Click
          SkinData.SkinSection = 'BUTTON'
        end
        object Button1: TsButton
          Left = 211
          Top = 2
          Width = 100
          Height = 25
          Caption = 'Report'
          ImageIndex = 69
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = Button1Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
    object tabActions: TsTabSheet
      Caption = 'Detailed'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grVar: TcxGrid
        Left = 0
        Top = 33
        Width = 892
        Height = 353
        Align = alClient
        TabOrder = 0
        LookAndFeel.NativeStyle = False
        object tvVar: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = mvarDS
          DataController.DetailKeyFieldNames = 'Room'
          DataController.KeyFieldNames = 'Room'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          object tvVarRoom: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
            Width = 70
          end
          object tvVarRoomType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'RoomType'
            Width = 62
          end
          object tvVarResStatus: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'ResStatus'
            Width = 149
          end
          object tvVarJobPr: TcxGridDBColumn
            Caption = '%'
            DataBinding.FieldName = 'JobPr'
            Width = 56
          end
          object tvVarLocation: TcxGridDBColumn
            DataBinding.FieldName = 'Location'
          end
          object tvVarFloor: TcxGridDBColumn
            DataBinding.FieldName = 'Floor'
            Width = 47
          end
          object tvVarArrival: TcxGridDBColumn
            DataBinding.FieldName = 'Arrival'
            Width = 77
          end
          object tvVarDeparture: TcxGridDBColumn
            DataBinding.FieldName = 'Departure'
            Width = 83
          end
          object tvVarRoomDescription: TcxGridDBColumn
            Caption = 'Room description'
            DataBinding.FieldName = 'RoomDescription'
            Width = 131
          end
          object tvVarRoomTypeDescription: TcxGridDBColumn
            DataBinding.FieldName = 'RoomTypeDescription'
            Visible = False
            Width = 133
          end
          object tvVarFirstGuest: TcxGridDBColumn
            Caption = 'Guest name'
            DataBinding.FieldName = 'FirstGuest'
            Width = 155
          end
          object tvVarResName: TcxGridDBColumn
            Caption = 'Reservation'
            DataBinding.FieldName = 'ResName'
            Width = 171
          end
          object tvVarNumberGuests: TcxGridDBColumn
            DataBinding.FieldName = 'NumberGuests'
            Visible = False
          end
          object tvVarGuestStatus: TcxGridDBColumn
            Caption = 'Guests'
            DataBinding.FieldName = 'GuestCount'
            Width = 54
          end
          object tvVarExtraGuest: TcxGridDBColumn
            Caption = 'Extra'
            DataBinding.FieldName = 'ExtraGuest'
          end
          object tvVarGuestCount: TcxGridDBColumn
            Caption = 'S'
            DataBinding.FieldName = 'GuestStatus'
            Width = 29
          end
          object tvVarNotes: TcxGridDBColumn
            DataBinding.FieldName = 'Notes'
            Width = 231
          end
          object tvVarRoomNotes: TcxGridDBColumn
            DataBinding.FieldName = 'RoomNotes'
          end
        end
        object grVarDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          FilterBox.CustomizeDialog = False
          FilterBox.Visible = fvNever
          DataController.DataSource = DS
          DataController.DetailKeyFieldNames = 'Room'
          DataController.KeyFieldNames = 'Room'
          DataController.MasterKeyFieldNames = 'Room'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.ColumnMRUItemsList = False
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          object grVarDBTableView1Action: TcxGridDBColumn
            DataBinding.FieldName = 'Action'
          end
          object grVarDBTableView1Description: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 120
          end
          object grVarDBTableView1Note: TcxGridDBColumn
            DataBinding.FieldName = 'Note'
            Width = 150
          end
          object grVarDBTableView1Finished: TcxGridDBColumn
            DataBinding.FieldName = 'Finished'
          end
        end
        object lvVar: TcxGridLevel
          GridView = tvVar
        end
      end
      object sPanel1: TsPanel
        Left = 0
        Top = 0
        Width = 892
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object sButton2: TsButton
          Left = 4
          Top = 2
          Width = 100
          Height = 25
          Caption = 'EXCEL'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton2Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 486
    Width = 900
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object ps: TatPascalScripter
    SaveCompiledCode = False
    ShortBooleanEval = False
    LibOptions.SearchPath.Strings = (
      '$(CURDIR)'
      '$(APPDIR)')
    LibOptions.SourceFileExt = '.psc'
    LibOptions.CompiledFileExt = '.pcu'
    LibOptions.UseScriptFiles = False
    CallExecHookEvent = False
    Left = 120
    Top = 217
  end
  object DS: TDataSource
    DataSet = m_
    Left = 360
    Top = 264
  end
  object m_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'aDate'
        DataType = ftDateTime
      end
      item
        Name = 'Room'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Action'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Finished'
        DataType = ftBoolean
      end
      item
        Name = 'Note'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'RoomNotes'
        DataType = ftWideMemo
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
    Left = 288
    Top = 264
  end
  object mvar_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'RoomType'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'NumberGuests'
        DataType = ftInteger
      end
      item
        Name = 'GuestCount'
        DataType = ftInteger
      end
      item
        Name = 'ExtraGuest'
        DataType = ftInteger
      end
      item
        Name = 'GuestStatus'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'StayDay'
        DataType = ftInteger
      end
      item
        Name = 'CheckIn'
        DataType = ftInteger
      end
      item
        Name = 'aDate'
        DataType = ftDateTime
      end
      item
        Name = 'Room'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'CheckOut'
        DataType = ftInteger
      end
      item
        Name = 'WeekDay'
        DataType = ftInteger
      end
      item
        Name = 'WeekEnd'
        DataType = ftBoolean
      end
      item
        Name = 'Location'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Floor'
        DataType = ftInteger
      end
      item
        Name = 'Hidden'
        DataType = ftBoolean
      end
      item
        Name = 'RoomStatus'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'RoomDescription'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'RoomTypeDescription'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Arrival'
        DataType = ftDateTime
      end
      item
        Name = 'Departure'
        DataType = ftDateTime
      end
      item
        Name = 'LastCheckOutDate'
        DataType = ftDateTime
      end
      item
        Name = 'LastCheckOut'
        DataType = ftInteger
      end
      item
        Name = 'NextCheckIndate'
        DataType = ftDateTime
      end
      item
        Name = 'NextCheckIn'
        DataType = ftInteger
      end
      item
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'NextRoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'LastRoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'LastUpdate'
        DataType = ftDateTime
      end
      item
        Name = 'Notes'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'FirstGuest'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ResName'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ResStatus'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'JobPr'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'RoomNotes'
        DataType = ftWideMemo
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
    Left = 288
    Top = 200
  end
  object mvarDS: TDataSource
    DataSet = mvar_
    Left = 360
    Top = 200
  end
  object grExcelCross: TAdvGridExcelIO
    AdvStringGrid = grCross
    Options.ExportOverwrite = omWarn
    Options.ExportOverwriteMessage = 'File %s already exists'#13'Ok to overwrite ?'
    Options.ExportRawRTF = False
    UseUnicode = False
    GridStartRow = 0
    GridStartCol = 0
    DateFormat = 'dd.mm.yyyy'
    TimeFormat = 'hh:nn:ss'
    Version = '3.4.1'
    Left = 160
    Top = 217
  end
  object rpt: TppReport
    AutoStop = False
    DataPipeline = ppMvar
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
    Left = 384
    Top = 368
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'ppMvar'
    object ppHeaderBand1: TppHeaderBand
      BeforePrint = ppHeaderBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 16140
      mmPrintPosition = 0
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'Houskeeping - '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 7535
        mmLeft = 2646
        mmTop = 529
        mmWidth = 45551
        BandType = 0
        LayerName = Foreground
      end
      object rlabDate: TppLabel
        UserName = 'rLabFrom'
        Caption = '01.01.2010'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 7408
        mmLeft = 49213
        mmTop = 794
        mmWidth = 31750
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
      object rLabHotelName: TppLabel
        UserName = 'rLabHotelName'
        Caption = 'Hotel nafn'
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
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Total rooms : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 2646
        mmTop = 10054
        mmWidth = 19177
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        Caption = 'Total actions : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 40746
        mmTop = 9525
        mmWidth = 20373
        BandType = 0
        LayerName = Foreground
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 2117
        mmLeft = 0
        mmTop = 14023
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      BeforePrint = ppDetailBand1BeforePrint
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 22754
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'Room'
        DataPipeline = ppMvar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppMvar'
        mmHeight = 3260
        mmLeft = 2117
        mmTop = 1058
        mmWidth = 14288
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'RoomType'
        DataPipeline = ppMvar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppMvar'
        mmHeight = 3260
        mmLeft = 18521
        mmTop = 1058
        mmWidth = 15081
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'RoomDescription'
        DataPipeline = ppMvar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppMvar'
        mmHeight = 3260
        mmLeft = 35983
        mmTop = 1058
        mmWidth = 36248
        BandType = 4
        LayerName = Foreground
      end
      object rlabLocation: TppLabel
        UserName = 'rlabLocation'
        AutoSize = False
        Caption = '[location] on floor [floor]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 74348
        mmTop = 1058
        mmWidth = 41010
        BandType = 4
        LayerName = Foreground
      end
      object rLabGuests: TppLabel
        UserName = 'rLabGuests'
        AutoSize = False
        Caption = 'Guest : 0  Extra : 0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 116152
        mmTop = 1058
        mmWidth = 30163
        BandType = 4
        LayerName = Foreground
      end
      object rlabNames: TppLabel
        UserName = 'rlabNames'
        Caption = '[Guestname]/[Reservationname]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 2117
        mmTop = 5292
        mmWidth = 40894
        BandType = 4
        LayerName = Foreground
      end
      object rlabDates: TppLabel
        UserName = 'rlabNames1'
        Caption = '[Arrival]/[Departure]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 2117
        mmTop = 9525
        mmWidth = 24553
        BandType = 4
        LayerName = Foreground
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 1588
        mmLeft = 0
        mmTop = 0
        mmWidth = 197300
        BandType = 4
        LayerName = Foreground
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 18521
        mmLeft = 146579
        mmTop = 0
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground
      end
      object rlabJob: TppLabel
        UserName = 'rlabNames2'
        Caption = '[job]/[Status]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 2117
        mmTop = 13758
        mmWidth = 15875
        BandType = 4
        LayerName = Foreground
      end
      object ppSubReport1: TppSubReport
        UserName = 'SubReport1'
        ExpandAll = False
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        TraverseAllData = False
        DataPipelineName = 'ppM'
        mmHeight = 4498
        mmLeft = 0
        mmTop = 18256
        mmWidth = 197300
        BandType = 4
        LayerName = Foreground
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        object ppChildReport1: TppChildReport
          AutoStop = False
          DataPipeline = ppM
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
          Version = '14.07'
          mmColumnWidth = 0
          DataPipelineName = 'ppM'
          object ppTitleBand1: TppTitleBand
            Background.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 0
            mmPrintPosition = 0
          end
          object ppDetailBand2: TppDetailBand
            Background1.Brush.Color = clSilver
            Background2.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 3969
            mmPrintPosition = 0
            object ppLabel2: TppLabel
              UserName = 'Label2'
              AutoSize = False
              Caption = 'Action [    ]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              mmHeight = 3175
              mmLeft = 529
              mmTop = 265
              mmWidth = 14288
              BandType = 4
              LayerName = Foreground1
            end
            object ppDBText2: TppDBText
              UserName = 'DBText2'
              AutoSize = True
              DataField = 'Action'
              DataPipeline = ppM
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppM'
              mmHeight = 3260
              mmLeft = 16404
              mmTop = 529
              mmWidth = 635
              BandType = 4
              LayerName = Foreground1
            end
          end
          object ppSummaryBand1: TppSummaryBand
            Background.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 0
            mmPrintPosition = 0
          end
          object ppDesignLayers2: TppDesignLayers
            object ppDesignLayer2: TppDesignLayer
              UserName = 'Foreground1'
              LayerType = ltBanded
              Index = 0
            end
          end
        end
      end
      object ppLabel3: TppLabel
        UserName = 'rlabNames3'
        AutoSize = False
        Caption = 'Days from checkin :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 147638
        mmTop = 1058
        mmWidth = 27781
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        AutoSize = False
        Caption = 'Days until checkout :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 147638
        mmTop = 5821
        mmWidth = 27781
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        AutoSize = False
        Caption = 'Next checkin :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 147638
        mmTop = 10054
        mmWidth = 27781
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Caption = 'Last checkout :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 147638
        mmTop = 14288
        mmWidth = 27781
        BandType = 4
        LayerName = Foreground
      end
      object rlabdaysfromCheckin: TppLabel
        UserName = 'rlabdaysfromCheckin'
        Caption = '[daysfromCheckin]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 176213
        mmTop = 1058
        mmWidth = 23537
        BandType = 4
        LayerName = Foreground
      end
      object rlabDaysUntilCheckout: TppLabel
        UserName = 'rlabdaysfromCheckin1'
        Caption = '[daysUntilCheckout]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 176213
        mmTop = 5821
        mmWidth = 25231
        BandType = 4
        LayerName = Foreground
      end
      object rlabNextCheckin: TppLabel
        UserName = 'rlabNextCheckin'
        Caption = '[NextCheckin]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 176213
        mmTop = 10054
        mmWidth = 17611
        BandType = 4
        LayerName = Foreground
      end
      object rLabLastCheckout: TppLabel
        UserName = 'Label101'
        Caption = '[lastCheckout]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 176213
        mmTop = 13758
        mmWidth = 18034
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 7938
      mmPrintPosition = 0
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
  object ppMvar: TppDBPipeline
    DataSource = mvarDS
    SkipWhenNoRecords = False
    UserName = 'Mvar'
    Left = 464
    Top = 368
  end
  object ppM: TppDBPipeline
    DataSource = DS
    SkipWhenNoRecords = False
    UserName = 'M'
    Left = 520
    Top = 376
    MasterDataPipelineName = 'ppMvar'
    object ppMppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'ID'
      FieldName = 'ID'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 0
    end
    object ppMppField2: TppField
      FieldAlias = 'aDate'
      FieldName = 'aDate'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 1
    end
    object ppMppField3: TppField
      FieldAlias = 'Room'
      FieldName = 'Room'
      FieldLength = 8
      DisplayWidth = 8
      Position = 2
    end
    object ppMppField4: TppField
      FieldAlias = 'Action'
      FieldName = 'Action'
      FieldLength = 8
      DisplayWidth = 8
      Position = 3
    end
    object ppMppField5: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 50
      DisplayWidth = 50
      Position = 4
    end
    object ppMppField6: TppField
      FieldAlias = 'Finished'
      FieldName = 'Finished'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 5
    end
    object ppMppField7: TppField
      FieldAlias = 'Note'
      FieldName = 'Note'
      FieldLength = 50
      DisplayWidth = 50
      Position = 6
    end
    object ppMppMasterFieldLink1: TppMasterFieldLink
      MasterFieldName = 'Room'
      GuidCollationType = gcString
      DetailFieldName = 'Room'
      DetailSortOrder = soAscending
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
    StorageName = 'Software\Roomer\FormStatus\HouseKeeping'
    StorageType = stRegistry
    Left = 294
    Top = 328
  end
end
