inherited frmHouseKeepingReport: TfrmHouseKeepingReport
  Caption = 'Simple HouseKeeping report'
  ClientHeight = 586
  ClientWidth = 1123
  Font.Height = -11
  Position = poOwnerFormCenter
  ExplicitWidth = 1139
  ExplicitHeight = 625
  PixelsPerInch = 96
  TextHeight = 13
  inherited dxStatusBar: TdxStatusBar
    Top = 566
    Width = 1123
    ExplicitTop = 566
    ExplicitWidth = 1123
  end
  object pnlFilter: TsPanel [1]
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
      object btnPrintGrid: TsButton
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
        OnClick = btnPrintGridClick
        SkinData.SkinSection = 'BUTTON'
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
  object grHouseKeepingList: TcxGrid [2]
    Left = 0
    Top = 137
    Width = 1123
    Height = 429
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    ExplicitLeft = -1
    ExplicitTop = 139
    object grHouseKeepingListDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = HouseKeepingListDS
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsCustomize.DataRowSizing = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      object grHouseKeepingListDBTableView1location: TcxGridDBColumn
        Caption = 'Location'
        DataBinding.FieldName = 'location'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 39
      end
      object grHouseKeepingListDBTableView1floor: TcxGridDBColumn
        Caption = 'Floor'
        DataBinding.FieldName = 'floor'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 41
      end
      object grHouseKeepingListDBTableView1room: TcxGridDBColumn
        Caption = 'Room'
        DataBinding.FieldName = 'room'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 2
        SortOrder = soAscending
        Width = 50
      end
      object grHouseKeepingListDBTableView1roomtype: TcxGridDBColumn
        Caption = 'RoomType'
        DataBinding.FieldName = 'roomtype'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 53
      end
      object grHouseKeepingListDBTableView1LastGuests: TcxGridDBColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'LastGuests'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        OnGetDisplayText = grHouseKeepingListDBTableView1ArrivingGuestsGetDisplayText
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 42
      end
      object grHouseKeepingListDBTableView1expectedcot: TcxGridDBColumn
        Caption = 'Checkout time'
        DataBinding.FieldName = 'expectedcot'
        PropertiesClassName = 'TcxTimeEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        Properties.TimeFormat = tfHourMin
        HeaderAlignmentHorz = taCenter
        Width = 63
      end
      object grHouseKeepingListDBTableView1housekeepingstatus: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'housekeepingstatus'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taLeftJustify
        Options.Editing = False
        Width = 81
      end
      object grHouseKeepingListDBTableView1ArrivingGuests: TcxGridDBColumn
        Caption = 'Arriving Guests'
        DataBinding.FieldName = 'ArrivingGuests'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        OnGetDisplayText = grHouseKeepingListDBTableView1ArrivingGuestsGetDisplayText
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 68
      end
      object grHouseKeepingListDBTableView1expectedtoa: TcxGridDBColumn
        Caption = 'Arrival time'
        DataBinding.FieldName = 'expectedtoa'
        PropertiesClassName = 'TcxTimeEditProperties'
        Properties.Alignment.Vert = taTopJustify
        Properties.TimeFormat = tfHourMin
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 47
      end
      object grHouseKeepingListDBTableView1LiveNote: TcxGridDBColumn
        Caption = 'Cleaning note'
        DataBinding.FieldName = 'LiveNote'
        Width = 320
      end
      object grHouseKeepingListDBTableView1Roomnotes: TcxGridDBColumn
        Caption = 'Room Notes'
        DataBinding.FieldName = 'roomnotes'
        PropertiesClassName = 'TcxMemoProperties'
        Options.Editing = False
        Width = 315
      end
      object grHouseKeepingListDBTableView1maintenancenotes: TcxGridDBColumn
        Caption = 'Maintenance Notes'
        DataBinding.FieldName = 'maintenancenotes'
        PropertiesClassName = 'TcxMemoProperties'
        Visible = False
        Options.Editing = False
        Width = 441
      end
      object grHouseKeepingListDBTableView1cleaningnotes: TcxGridDBColumn
        Caption = 'Cleaning Notes'
        DataBinding.FieldName = 'cleaningnotes'
        PropertiesClassName = 'TcxMemoProperties'
        Visible = False
        Options.Editing = False
        Width = 441
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
        Name = 'LastGuests'
        DataType = ftInteger
      end
      item
        Name = 'ArrivingGuests'
        DataType = ftInteger
      end
      item
        Name = 'expectedcot'
        DataType = ftTime
      end
      item
        Name = 'housekeepingstatus'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'location'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'expectedtoa'
        DataType = ftTime
      end
      item
        Name = 'Roomnotes'
        DataType = ftMemo
      end
      item
        Name = 'maintenancenotes'
        DataType = ftMemo
      end
      item
        Name = 'cleaningnotes'
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
      FieldName = 'LastGuests'
    end
    object kbmHouseKeepingListArrivingGuests: TIntegerField
      FieldName = 'ArrivingGuests'
    end
    object kbmHouseKeepingListexpectedcot: TTimeField
      FieldName = 'expectedcot'
    end
    object kbmHouseKeepingListstatus: TStringField
      FieldName = 'housekeepingstatus'
    end
    object kbmHouseKeepingListlocation: TStringField
      FieldName = 'location'
      Size = 10
    end
    object kbmHouseKeepingListexpectedtoa: TTimeField
      FieldName = 'expectedtoa'
    end
    object kbmHouseKeepingListRoomnotes: TMemoField
      FieldName = 'Roomnotes'
      BlobType = ftMemo
    end
    object kbmHouseKeepingListmaintenancenotes: TMemoField
      FieldName = 'maintenancenotes'
      BlobType = ftMemo
    end
    object kbmHouseKeepingListcleaningnotes: TMemoField
      FieldName = 'cleaningnotes'
      BlobType = ftMemo
    end
    object kbmHouseKeepingListLiveNote: TWideStringField
      FieldName = 'LiveNote'
      Size = 255
    end
  end
  object HouseKeepingListDS: TDataSource
    DataSet = kbmHouseKeepingList
    Left = 440
    Top = 367
  end
  object gridPrinter: TdxComponentPrinter
    CurrentLink = gridPrinterLink1
    Version = 0
    Left = 680
    Top = 328
    object gridPrinterLink1: TdxGridReportLink
      Active = True
      Component = grHouseKeepingList
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
      ReportDocument.CreationDate = 42649.681261493060000000
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clBlack
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Arial'
      ReportTitle.Font.Style = [fsBold]
      ShrinkToPageWidth = True
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
  end
  object cxStyleRepository2: TcxStyleRepository
    Left = 352
    Top = 56
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
