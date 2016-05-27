object frmArrivalsReport: TfrmArrivalsReport
  Left = 0
  Top = 0
  Caption = 'Arrivals'
  ClientHeight = 560
  ClientWidth = 972
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
    Width = 972
    Height = 144
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = -6
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
        OnCloseUp = dtDateFromCloseUp
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
        OnCloseUp = dtDateToCloseUp
        DialogTitle = 'Date to select'
      end
    end
    object pnlExportButtons: TsPanel
      Left = 1
      Top = 104
      Width = 970
      Height = 39
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      ExplicitTop = 97
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
        ExplicitHeight = 24
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
        ExplicitLeft = 160
        ExplicitHeight = 24
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
        ExplicitLeft = 251
        ExplicitTop = 8
        ExplicitHeight = 24
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
        DropDownMenu = PopupMenu1
        ImageIndex = 62
        Images = DImages.PngImageList1
        Style = bsSplitButton
        TabOrder = 3
        SkinData.SkinSection = 'BUTTON'
        ExplicitLeft = 424
        ExplicitHeight = 24
      end
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 540
    Width = 972
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
    Top = 144
    Width = 972
    Height = 396
    Align = alClient
    PopupMenu = PopupMenu2
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    ExplicitLeft = -1
    ExplicitTop = 139
    ExplicitHeight = 403
    object grArrivalsListDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = grArrivalsListDBTableView1CellDblClick
      DataController.DataSource = ArrivalsListDS
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Styles.Group = cxStyle1
      Styles.GroupSummary = cxStyle1
      object grArrivalsListDBTableView1Room: TcxGridDBColumn
        DataBinding.FieldName = 'Room'
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
      object grArrivalsListDBTableView1NumGuests: TcxGridDBColumn
        Caption = 'Num guests'
        DataBinding.FieldName = 'NumGuests'
        Options.Editing = False
      end
      object grArrivalsListDBTableView1Roomtype: TcxGridDBColumn
        Caption = 'Room type'
        DataBinding.FieldName = 'Roomtype'
        Options.Editing = False
        Width = 66
      end
      object grArrivalsListDBTableView1RoomerReservationID: TcxGridDBColumn
        Caption = 'Reservation ID'
        DataBinding.FieldName = 'RoomerReservationID'
        Options.Editing = False
        Width = 83
      end
      object grArrivalsListDBTableView1GuestName: TcxGridDBColumn
        Caption = 'Guest name'
        DataBinding.FieldName = 'GuestName'
        Options.Editing = False
        Width = 263
      end
      object grArrivalsListDBTableView1CompanyCode: TcxGridDBColumn
        Caption = 'Company code'
        DataBinding.FieldName = 'CompanyCode'
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
        Options.Editing = False
        Width = 88
      end
      object grArrivalsListDBTableView1RoomerRoomReservationID: TcxGridDBColumn
        Caption = 'Room Res ID'
        DataBinding.FieldName = 'RoomerRoomReservationID'
        Options.Editing = False
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
  object PopupMenu1: TPopupMenu
    Images = DImages.cxSmallImagesFlat
    Left = 480
    Top = 224
    object R1: TMenuItem
      Caption = 'Room Invoice'
      Default = True
      ImageIndex = 62
      OnClick = R1Click
    end
    object G1: TMenuItem
      Caption = 'Group Invoice'
      ImageIndex = 60
      OnClick = G1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 184
    Top = 368
    object C1: TMenuItem
      Caption = 'Check in'
      OnClick = btnCheckInClick
    end
    object P1: TMenuItem
      Caption = 'Profile'
      OnClick = btnProfileClick
    end
    object I1: TMenuItem
      Caption = 'Invoice'
      object R2: TMenuItem
        Caption = 'Room invoice'
        OnClick = R1Click
      end
      object G2: TMenuItem
        Caption = 'Group invoice'
        OnClick = G1Click
      end
    end
  end
end
