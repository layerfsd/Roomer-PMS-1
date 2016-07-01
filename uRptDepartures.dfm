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
        Text = '  .  .    '
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
        Text = '  .  .    '
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
      Width = 1053
      Height = 39
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
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
        Caption = 'Check out'
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
    TabOrder = 2
    object tvDeparturesList: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DeparturesListDS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Bands = <
        item
          Caption = 'Guest'
          FixedKind = fkLeft
        end
        item
          Caption = 'Customer'
          Width = 271
        end
        item
          Caption = 'Finance'
        end
        item
          Caption = 'Other'
        end>
      object tvDeparturesListRoom: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Room'
        Width = 62
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDeparturesListRoomType: TcxGridDBBandedColumn
        DataBinding.FieldName = 'RoomType'
        Width = 64
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object tvDeparturesListGuestName: TcxGridDBBandedColumn
        Caption = 'Main Guest'
        DataBinding.FieldName = 'GuestName'
        Width = 173
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDeparturesListNumGuests: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'NumGuests'
        Width = 44
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object tvDeparturesListArrival: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Arrival'
        Width = 69
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvDeparturesListDeparture: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Departure'
        Width = 59
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvDeparturesListExpectedCheckOutTime: TcxGridDBBandedColumn
        Caption = 'Exp. COT'
        DataBinding.FieldName = 'ExpectedCheckOutTime'
        Width = 54
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object tvDeparturesListCustomer: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Customer'
        Width = 108
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDeparturesListCompanyName: TcxGridDBBandedColumn
        Caption = 'Company Name'
        DataBinding.FieldName = 'CompanyName'
        Width = 215
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDeparturesListNumNights: TcxGridDBBandedColumn
        Caption = 'Nights'
        DataBinding.FieldName = 'NumNights'
        Width = 70
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDeparturesListAverageRatePerNight: TcxGridDBBandedColumn
        Caption = 'Rate Per Night'
        DataBinding.FieldName = 'AverageRatePerNight'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        OnGetProperties = tvDeparturesListAverageRatePerNightGetProperties
        Width = 70
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDeparturesListTotalRent: TcxGridDBBandedColumn
        Caption = 'Total Rent'
        DataBinding.FieldName = 'TotalRent'
        Width = 70
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDeparturesListTotalSale: TcxGridDBBandedColumn
        Caption = 'Total Sale'
        DataBinding.FieldName = 'TotalSale'
        Width = 70
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvDeparturesListTotalPayments: TcxGridDBBandedColumn
        Caption = 'Payments'
        DataBinding.FieldName = 'TotalPayments'
        Width = 70
        Position.BandIndex = 2
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvDeparturesListBalance: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Balance'
        Width = 70
        Position.BandIndex = 2
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object tvDeparturesListRoomerReservationId: TcxGridDBBandedColumn
        Caption = 'Roomer Res. Id'
        DataBinding.FieldName = 'RoomerReservationId'
        Width = 70
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDeparturesListRoomerRoomReservationId: TcxGridDBBandedColumn
        Caption = 'Roomer RoomRes. Id'
        DataBinding.FieldName = 'RoomerRoomReservationId'
        Width = 70
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDeparturesListCheckOutDate: TcxGridDBBandedColumn
        DataBinding.FieldName = 'CheckOutDate'
        Visible = False
        Width = 70
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
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
        Name = 'RoomerRoomReservationId'
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
        Name = 'TotalRent'
        DataType = ftFloat
      end
      item
        Name = 'TotalSale'
        DataType = ftFloat
      end
      item
        Name = 'TotalPayments'
        DataType = ftFloat
      end
      item
        Name = 'Balance'
        DataType = ftFloat
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.62.00 Standard Edition'
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
end
