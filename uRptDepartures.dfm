object frmDeparturesReport: TfrmDeparturesReport
  Left = 0
  Top = 0
  Caption = 'Departures'
  ClientHeight = 585
  ClientWidth = 1055
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
    Width = 1055
    Height = 144
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
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
      Top = 100
      Width = 1053
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
      object btnCheckOut: TsButton
        AlignWithMargins = True
        Left = 137
        Top = 3
        Width = 128
        Height = 37
        Align = alLeft
        Caption = 'Check out'
        ImageIndex = 46
        Images = DImages.PngImageList1
        TabOrder = 1
        OnClick = btnCheckOutClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnProfile: TsButton
        AlignWithMargins = True
        Left = 271
        Top = 3
        Width = 128
        Height = 37
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
        Left = 405
        Top = 3
        Width = 128
        Height = 37
        Align = alLeft
        Caption = 'Invoice'
        DropDownMenu = pmnuInvoiceMenu
        ImageIndex = 62
        Images = DImages.PngImageList1
        Style = bsSplitButton
        TabOrder = 3
        OnClick = mnuRoomInvoiceClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 565
    Width = 1055
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object grDeparturesList: TcxGrid
    Left = 0
    Top = 144
    Width = 1055
    Height = 421
    Align = alClient
    PopupMenu = pnmuGridMenu
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    object tvDeparturesList: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DeparturesListDS
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Kind = skCount
          Position = spFooter
          Column = tvDeparturesListRoom
        end
        item
          Kind = skSum
          Position = spFooter
          Column = tvDeparturesListNumGuests
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = tvDeparturesListRoom
        end
        item
          Format = '0'
          Kind = skSum
          Column = tvDeparturesListNumGuests
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupFooters = gfAlwaysVisible
      object tvDeparturesListRoom: TcxGridDBColumn
        DataBinding.FieldName = 'Room'
        SortIndex = 0
        SortOrder = soDescending
        Width = 56
      end
      object tvDeparturesListGuestName: TcxGridDBColumn
        DataBinding.FieldName = 'GuestName'
        Width = 200
      end
      object tvDeparturesListRoomerReservationId: TcxGridDBColumn
        Caption = 'Res. Id'
        DataBinding.FieldName = 'RoomerReservationId'
        Width = 83
      end
      object tvDeparturesListCompanyName: TcxGridDBColumn
        Caption = 'Company Name'
        DataBinding.FieldName = 'CompanyName'
        Width = 200
      end
      object tvDeparturesListArrival: TcxGridDBColumn
        DataBinding.FieldName = 'Arrival'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.ShowTime = False
      end
      object tvDeparturesListDeparture: TcxGridDBColumn
        DataBinding.FieldName = 'Departure'
      end
      object tvDeparturesListRoomType: TcxGridDBColumn
        DataBinding.FieldName = 'RoomType'
        Width = 64
      end
      object tvDeparturesListNumGuests: TcxGridDBColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'NumGuests'
        HeaderAlignmentHorz = taRightJustify
        Width = 64
      end
      object tvDeparturesListAverageRatePerNight: TcxGridDBColumn
        Caption = 'Rate Amount'
        DataBinding.FieldName = 'AverageRatePerNight'
        OnGetProperties = tvDeparturesList2AverageRatePerNightGetProperties
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object tvDeparturesListBalance: TcxGridDBColumn
        DataBinding.FieldName = 'Balance'
        OnGetProperties = tvDeparturesList2AverageRatePerNightGetProperties
        HeaderAlignmentHorz = taRightJustify
      end
      object tvDeparturesListExpectedCheckOutTime: TcxGridDBColumn
        Caption = 'Expected COT'
        DataBinding.FieldName = 'ExpectedCheckOutTime'
        PropertiesClassName = 'TcxTimeEditProperties'
        Properties.UseTimeFormatWhenUnfocused = False
        Width = 79
      end
    end
    object lvDeparturesList: TcxGridLevel
      GridView = tvDeparturesList
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
  object kbmDeparturesList: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'CheckOutDate'
        DataType = ftDate
      end
      item
        Name = 'RoomerReservationId'
        DataType = ftInteger
      end
      item
        Name = 'Room'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'RoomType'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'NumGuests'
        DataType = ftInteger
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
        Name = 'ExpectedCheckOutTime'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'CompanyName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'NumNights'
        DataType = ftInteger
      end
      item
        Name = 'AverageRatePerNight'
        DataType = ftFloat
      end
      item
        Name = 'Balance'
        DataType = ftFloat
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
    AfterScroll = kbmDeparturesListAfterScroll
    Left = 448
    Top = 231
  end
  object DeparturesListDS: TDataSource
    DataSet = kbmDeparturesList
    Left = 448
    Top = 279
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
    Left = 48
    Top = 272
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
    Left = 48
    Top = 328
    object mnuCheckin: TMenuItem
      Caption = 'Check in'
      OnClick = btnCheckOutClick
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
end
