object frmArrivalsReport: TfrmArrivalsReport
  Left = 0
  Top = 0
  Caption = 'Arrivals Report'
  ClientHeight = 560
  ClientWidth = 881
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
    Width = 881
    Height = 137
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object btnRefresh: TsButton
      Left = 405
      Top = 9
      Width = 118
      Height = 25
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
        Width = 50
        Height = 20
        Caption = 'Today'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rbRadioButtonClick
      end
      object rbTomorrow: TsRadioButton
        Left = 4
        Top = 46
        Width = 68
        Height = 20
        Caption = 'Tomorrow'
        TabOrder = 1
        OnClick = rbRadioButtonClick
      end
      object rbManualRange: TsRadioButton
        Left = 119
        Top = 21
        Width = 114
        Height = 20
        Caption = 'Manual date range:'
        TabOrder = 2
        OnClick = rbRadioButtonClick
      end
      object dtDateFrom: TsDateEdit
        Left = 139
        Top = 46
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
        DialogTitle = 'Date from select'
      end
      object dtDateTo: TsDateEdit
        Left = 250
        Top = 46
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
        DialogTitle = 'Date to select'
      end
    end
    object pnlLocations: TsPanel
      Left = 1
      Top = 84
      Width = 879
      Height = 18
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object labLocations: TsLabel
        AlignWithMargins = True
        Left = 20
        Top = 3
        Width = 52
        Height = 12
        Margins.Left = 20
        Align = alLeft
        Alignment = taRightJustify
        Caption = 'Locations :'
        ExplicitHeight = 13
      end
      object labLocationsList: TsLabel
        AlignWithMargins = True
        Left = 78
        Top = 3
        Width = 11
        Height = 12
        Align = alLeft
        Caption = 'All'
        ExplicitHeight = 13
      end
    end
    object pnlExportButtons: TsPanel
      Left = 1
      Top = 102
      Width = 879
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      SkinData.SkinSection = 'PANEL'
      object btnExcel: TsButton
        AlignWithMargins = True
        Left = 15
        Top = 5
        Width = 100
        Height = 24
        Margins.Left = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alLeft
        Caption = 'Excel'
        ImageIndex = 132
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = btnExcelClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 540
    Width = 881
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object grArrivalsList: TcxGrid
    Left = 0
    Top = 137
    Width = 881
    Height = 403
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    object grArrivalsListDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = ArrivalsListDS
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Styles.Group = cxStyle1
      Styles.GroupSummary = cxStyle1
      object grArrivalsListDBTableView1Room: TcxGridDBColumn
        DataBinding.FieldName = 'Room'
        SortIndex = 0
        SortOrder = soAscending
      end
      object grArrivalsListDBTableView1GuestName: TcxGridDBColumn
        DataBinding.FieldName = 'GuestName'
        Width = 181
      end
      object grArrivalsListDBTableView1RoomerReservationID: TcxGridDBColumn
        Caption = 'Reservation ID'
        DataBinding.FieldName = 'RoomerReservationID'
        Width = 99
      end
      object grArrivalsListDBTableView1CompanyCode: TcxGridDBColumn
        DataBinding.FieldName = 'CompanyCode'
      end
      object grArrivalsListDBTableView1Arrival: TcxGridDBColumn
        DataBinding.FieldName = 'Arrival'
        Visible = False
        GroupIndex = 0
      end
      object grArrivalsListDBTableView1Departure: TcxGridDBColumn
        DataBinding.FieldName = 'Departure'
        Width = 80
      end
      object grArrivalsListDBTableView1Roomtype: TcxGridDBColumn
        DataBinding.FieldName = 'Roomtype'
      end
      object grArrivalsListDBTableView1NumGuests: TcxGridDBColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'NumGuests'
      end
      object grArrivalsListDBTableView1AverageRoomRate: TcxGridDBColumn
        Caption = 'Avg Rate'
        DataBinding.FieldName = 'AverageRoomRate'
        Width = 72
      end
      object grArrivalsListDBTableView1ExpectedTimeOfArrival: TcxGridDBColumn
        Caption = 'Expected TOA'
        DataBinding.FieldName = 'ExpectedTimeOfArrival'
        Width = 78
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
  end
  object ArrivalsListDS: TDataSource
    DataSet = kbmArrivalsList
    Left = 488
    Top = 359
  end
  object cxStyleRepository1: TcxStyleRepository
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
end
