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
    object pnlExportButtons: TsPanel
      Left = 1
      Top = 93
      Width = 1121
      Height = 43
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object btnExcel: TsButton
        AlignWithMargins = True
        Left = 856
        Top = 3
        Width = 128
        Height = 37
        Align = alRight
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
        TabOrder = 2
        OnClick = btnRefreshClick
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
      TabOrder = 1
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
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
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = cxssRoomerGridTableView
      object grHouseKeepingListDBTableView1location: TcxGridDBColumn
        Caption = 'Loc.'
        DataBinding.FieldName = 'location'
        PropertiesClassName = 'TcxLabelProperties'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 57
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
        Width = 52
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
        Width = 56
      end
      object grHouseKeepingListDBTableView1roomtype: TcxGridDBColumn
        Caption = 'Room Type'
        DataBinding.FieldName = 'roomtype'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 51
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
        Width = 48
      end
      object grHouseKeepingListDBTableView1expectedcot: TcxGridDBColumn
        Caption = 'Checkout time'
        DataBinding.FieldName = 'expectedcot'
        PropertiesClassName = 'TcxTimeEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taTopJustify
        Properties.TimeFormat = tfHourMin
        HeaderAlignmentHorz = taCenter
        Width = 59
      end
      object grHouseKeepingListDBTableView1housekeepingstatus: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'housekeepingstatus'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taLeftJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
      end
      object grHouseKeepingListDBTableView1roomstatus: TcxGridDBColumn
        Caption = 'Roomstatus'
        DataBinding.FieldName = 'roomstatus'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taLeftJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
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
        Width = 65
      end
      object grHouseKeepingListDBTableView1expectedtoa: TcxGridDBColumn
        Caption = 'Arrival time'
        DataBinding.FieldName = 'expectedtoa'
        PropertiesClassName = 'TcxTimeEditProperties'
        Properties.Alignment.Vert = taTopJustify
        Properties.TimeFormat = tfHourMin
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 45
      end
      object grHouseKeepingListDBTableView1LiveNote: TcxGridDBColumn
        Caption = 'Cleaning note'
        DataBinding.FieldName = 'LiveNote'
        PropertiesClassName = 'TcxMemoProperties'
        Options.Editing = False
        Width = 305
      end
      object grHouseKeepingListDBTableView1Roomnotes: TcxGridDBColumn
        Caption = 'Room Notes'
        DataBinding.FieldName = 'roomnotes'
        PropertiesClassName = 'TcxMemoProperties'
        Options.Editing = False
        Width = 303
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
  inherited cxsrRoomerStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
    inherited dxssRoomerGridReportLink: TdxGridReportLinkStyleSheet
      BuiltIn = True
    end
    inherited cxssRoomerGridTableView: TcxGridTableViewStyleSheet
      BuiltIn = True
    end
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
    object kbmHouseKeepingListLiveNote: TMemoField
      FieldName = 'LiveNote'
      BlobType = ftMemo
      Size = 255
    end
    object kbmHouseKeepingListroomstatus: TStringField
      FieldName = 'roomstatus'
    end
  end
  object HouseKeepingListDS: TDataSource
    DataSet = kbmHouseKeepingList
    Left = 440
    Top = 367
  end
  object gridPrinter: TdxComponentPrinter
    CurrentLink = gridPrinterLink
    Version = 0
    Left = 680
    Top = 328
    object gridPrinterLink: TdxGridReportLink
      Active = True
      Component = grHouseKeepingList
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 6400
      PrinterPage.Margins.Right = 6400
      PrinterPage.Margins.Top = 6400
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageFooter.Font.Charset = ANSI_CHARSET
      PrinterPage.PageFooter.Font.Color = clBlack
      PrinterPage.PageFooter.Font.Height = -11
      PrinterPage.PageFooter.Font.Name = 'Arial'
      PrinterPage.PageFooter.Font.Style = []
      PrinterPage.PageFooter.LeftTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageHeader.Font.Charset = ANSI_CHARSET
      PrinterPage.PageHeader.Font.Color = clBlack
      PrinterPage.PageHeader.Font.Height = -11
      PrinterPage.PageHeader.Font.Name = 'Arial'
      PrinterPage.PageHeader.Font.Style = []
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 42662.498594375000000000
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
      OptionsFormatting.LookAndFeelKind = lfFlat
      OptionsFormatting.UseNativeStyles = True
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsSize.AutoWidth = True
      OptionsView.FilterBar = False
      ScaleFonts = False
      StyleRepository = cxsrRoomerStyleRepository
      Styles.StyleSheet = dxssRoomerGridReportLink
      BuiltInReportLink = True
    end
  end
end
