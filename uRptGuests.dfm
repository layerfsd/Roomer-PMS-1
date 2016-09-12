object frmRptGuests: TfrmRptGuests
  Left = 0
  Top = 0
  Caption = 'Guests'
  ClientHeight = 564
  ClientWidth = 1126
  Color = clBtnFace
  Constraints.MinWidth = 970
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 1126
    Height = 89
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1126
      89)
    object __labLocationsList: TsLabel
      Left = 426
      Top = 15
      Width = 11
      Height = 13
      Caption = 'All'
    end
    object labLocations: TsLabel
      AlignWithMargins = True
      Left = 272
      Top = 15
      Width = 148
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Locations :'
    end
    object cLabFilter: TsLabel
      Left = 245
      Top = 41
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Filter :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnClear: TsSpeedButton
      Left = 453
      Top = 39
      Width = 56
      Height = 21
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object labRecordCount: TsLabel
      Left = 474
      Top = 68
      Width = 4
      Height = 13
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnRefresh: TsButton
      Left = 244
      Top = 8
      Width = 100
      Height = 25
      Caption = 'Refresh'
      Default = True
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object gbxSelectDates: TsGroupBox
      Left = 8
      Top = 2
      Width = 230
      Height = 81
      Caption = 'Select Dates'
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object LMDSimpleLabel1: TsLabel
        Left = 37
        Top = 15
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'Date from :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object LMDSimpleLabel2: TsLabel
        Left = 49
        Top = 38
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Date to :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object dtDate: TsDateEdit
        Left = 98
        Top = 12
        Width = 121
        Height = 21
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4473924
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '25-12-2012'
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        Date = 41268.000000000000000000
      end
      object dtDateTo: TsDateEdit
        Left = 98
        Top = 35
        Width = 121
        Height = 21
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4473924
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '25-12-2012'
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        Date = 41268.000000000000000000
      end
    end
    object edFilter: TsEdit
      Left = 282
      Top = 39
      Width = 166
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4473924
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
    object chkOneday: TsCheckBox
      Left = 23
      Top = 59
      Width = 66
      Height = 17
      Caption = 'One day'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = chkOnedayClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object gbxUseStatusOfRooms: TsGroupBox
      Left = 784
      Top = 9
      Width = 333
      Height = 74
      Anchors = [akTop, akRight]
      Caption = 'Use Room with status of : '
      TabOrder = 4
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object chkExcluteWaitingList: TsCheckBox
        Left = 14
        Top = 17
        Width = 74
        Height = 17
        Caption = 'Waitinglist'
        Checked = True
        State = cbChecked
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object chkExcluteAlotment: TsCheckBox
        Left = 14
        Top = 34
        Width = 70
        Height = 17
        Caption = 'Allotment'
        Checked = True
        State = cbChecked
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object chkExcluteOrder: TsCheckBox
        Left = 134
        Top = 52
        Width = 80
        Height = 17
        Caption = 'Not Arrived'
        Checked = True
        State = cbChecked
        TabOrder = 2
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object chkExcluteNoShow: TsCheckBox
        Left = 14
        Top = 52
        Width = 66
        Height = 17
        Caption = 'No show'
        Checked = True
        State = cbChecked
        TabOrder = 6
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object chkExcluteDeparted: TsCheckBox
        Left = 134
        Top = 17
        Width = 70
        Height = 17
        Caption = 'Departed'
        Checked = True
        State = cbChecked
        TabOrder = 3
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object chkExcluteBlocked: TsCheckBox
        Left = 228
        Top = 34
        Width = 61
        Height = 17
        Caption = 'Blocked'
        TabOrder = 5
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object chkExcluteGuest: TsCheckBox
        Left = 134
        Top = 34
        Width = 53
        Height = 17
        Caption = 'Guest'
        Checked = True
        State = cbChecked
        TabOrder = 4
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object chkExcluteCANCELED: TsCheckBox
        Left = 228
        Top = 17
        Width = 69
        Height = 17
        Caption = 'Canceled'
        TabOrder = 7
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object chkExcludeWaitingListNonOptional: TsCheckBox
        Left = 228
        Top = 52
        Width = 74
        Height = 17
        Caption = 'Waitinglist'
        Checked = True
        State = cbChecked
        TabOrder = 8
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object rgrShow: TsRadioGroup
      Left = 631
      Top = 9
      Width = 147
      Height = 74
      Anchors = [akTop, akRight]
      Caption = 'Select'
      TabOrder = 5
      OnClick = rgrShowClick
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      ItemIndex = 2
      Items.Strings = (
        'All Guests'
        'Just Named Guests'
        'Just Main Guests')
    end
    object chkGroup: TsCheckBox
      Left = 282
      Top = 66
      Width = 127
      Height = 17
      Caption = 'Group by reservation'
      TabOrder = 6
      OnClick = chkGroupClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object Panel5: TsPanel
    Left = 0
    Top = 89
    Width = 1126
    Height = 43
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object btnExcel: TsButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 128
      Height = 35
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
      Left = 994
      Top = 4
      Width = 128
      Height = 35
      Align = alRight
      Caption = 'Report'
      ImageIndex = 72
      Images = DImages.PngImageList1
      TabOrder = 1
      Visible = False
      SkinData.SkinSection = 'BUTTON'
    end
    object btnReservation: TsButton
      AlignWithMargins = True
      Left = 138
      Top = 4
      Width = 128
      Height = 35
      Align = alLeft
      Caption = 'Reservation'
      ImageIndex = 56
      Images = DImages.PngImageList1
      TabOrder = 2
      OnClick = btnReservationClick
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton1: TsButton
      AlignWithMargins = True
      Left = 272
      Top = 4
      Width = 128
      Height = 35
      Align = alLeft
      Caption = 'Notes'
      ImageIndex = 94
      Images = DImages.PngImageList1
      TabOrder = 3
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object btnExpand: TsButton
      AlignWithMargins = True
      Left = 406
      Top = 4
      Width = 128
      Height = 35
      Align = alLeft
      Caption = 'Expand'
      ImageIndex = 94
      TabOrder = 4
      Visible = False
      OnClick = btnExpandClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCollapse: TsButton
      AlignWithMargins = True
      Left = 540
      Top = 4
      Width = 128
      Height = 35
      Align = alLeft
      Caption = 'Collapse'
      ImageIndex = 94
      TabOrder = 5
      Visible = False
      OnClick = btnCollapseClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 544
    Width = 1126
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object cxGrid1: TcxGrid
    Left = 1088
    Top = 584
    Width = 250
    Height = 200
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object grGuests: TcxGrid
    Left = 0
    Top = 132
    Width = 1126
    Height = 412
    Align = alClient
    TabOrder = 4
    object tvGuests: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = GuestsDS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Appending = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsView.HeaderAutoHeight = True
      Bands = <
        item
          Caption = 'Main'
          FixedKind = fkLeft
          Width = 1043
        end
        item
          Caption = 'Guest'
        end
        item
          Caption = 'Room'
        end
        item
          Caption = 'Customer'
        end
        item
          Caption = 'Reservation'
        end
        item
          Caption = 'Extra'
        end>
      object tvGuestsBookingId: TcxGridDBBandedColumn
        Caption = 'Booking Id'
        DataBinding.FieldName = 'BookingId'
        Width = 97
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvGuestsArrival: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Arrival'
        Width = 86
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvGuestsDeparture: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Departure'
        Width = 83
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvGuestsroom: TcxGridDBBandedColumn
        Caption = 'Room'
        DataBinding.FieldName = 'room'
        Width = 65
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvGuestsroomtype: TcxGridDBBandedColumn
        Caption = 'Room type'
        DataBinding.FieldName = 'roomtype'
        Width = 67
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvGuestsStatusText: TcxGridDBBandedColumn
        Caption = 'Status'
        DataBinding.FieldName = 'StatusText'
        Width = 98
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object tvGuestsGuestName: TcxGridDBBandedColumn
        Caption = 'Guest'
        DataBinding.FieldName = 'GuestName'
        Width = 106
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object tvGuestsReservationName: TcxGridDBBandedColumn
        Caption = 'Reservation'
        DataBinding.FieldName = 'ReservationName'
        Width = 104
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object tvGuestsCurrency: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Currency'
        Width = 55
        Position.BandIndex = 0
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object tvGuestsAverageRate: TcxGridDBBandedColumn
        Caption = 'Avrage rate'
        DataBinding.FieldName = 'AverageRate'
        OnGetProperties = tvGuestsTotalStayRateGetProperties
        Width = 63
        Position.BandIndex = 0
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object tvGuestsNumDays: TcxGridDBBandedColumn
        Caption = 'Nights'
        DataBinding.FieldName = 'NumDays'
        Visible = False
        Width = 24
        Position.BandIndex = 0
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object tvGuestsTotalStayRate: TcxGridDBBandedColumn
        Caption = 'Total stay rate'
        DataBinding.FieldName = 'TotalStayRate'
        OnGetProperties = tvGuestsTotalStayRateGetProperties
        Width = 79
        Position.BandIndex = 0
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object tvGuestsCurrencyRate: TcxGridDBBandedColumn
        Caption = 'Currency rate'
        DataBinding.FieldName = 'CurrencyRate'
        OnGetProperties = tvGuestsCurrencyRateGetProperties
        Width = 62
        Position.BandIndex = 0
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object tvGuestsTotalStayRateNative: TcxGridDBBandedColumn
        Caption = 'Total Stay'
        DataBinding.FieldName = 'TotalStayRateNative'
        OnGetProperties = tvGuestsCurrencyRateGetProperties
        Width = 78
        Position.BandIndex = 0
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object tvGuestsisMain: TcxGridDBBandedColumn
        DataBinding.FieldName = 'isMain'
        Visible = False
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvGuestsBreakfast: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Breakfast'
        Width = 36
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvGuestsemail: TcxGridDBBandedColumn
        Caption = 'Email'
        DataBinding.FieldName = 'email'
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvGuestsLocationDescription: TcxGridDBBandedColumn
        Caption = 'Location'
        DataBinding.FieldName = 'LocationDescription'
        Width = 100
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvGuestsfloor: TcxGridDBBandedColumn
        Caption = 'Floor'
        DataBinding.FieldName = 'floor'
        Width = 30
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvGuestsRoomDescription: TcxGridDBBandedColumn
        Caption = 'Room Description'
        DataBinding.FieldName = 'RoomDescription'
        Width = 100
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvGuestsmarketSegmentDescription: TcxGridDBBandedColumn
        Caption = 'Market'
        DataBinding.FieldName = 'marketSegmentDescription'
        Width = 100
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvGuestscustomer: TcxGridDBBandedColumn
        Caption = 'Customer'
        DataBinding.FieldName = 'customer'
        Width = 71
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvGuestsPersonalID: TcxGridDBBandedColumn
        DataBinding.FieldName = 'PersonalID'
        Visible = False
        Width = 119
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvGuestsCustomerName: TcxGridDBBandedColumn
        Caption = 'Customer Name'
        DataBinding.FieldName = 'CustomerName'
        Width = 142
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvGuestsRoomCount: TcxGridDBBandedColumn
        DataBinding.FieldName = 'RoomCount'
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvGuestsAdults: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Adults'
        Width = 50
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvGuestsChildren: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Children'
        Width = 50
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvGuestsInfants: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Infants'
        Width = 50
        Position.BandIndex = 4
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvGuestsRvGuestCount: TcxGridDBBandedColumn
        DataBinding.FieldName = 'RvGuestCount'
        Visible = False
        Position.BandIndex = 4
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvGuestsRRGuestCount: TcxGridDBBandedColumn
        Caption = 'Room Guests'
        DataBinding.FieldName = 'RRGuestCount'
        Visible = False
        Position.BandIndex = 4
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object tvGuestschannel: TcxGridDBBandedColumn
        Caption = 'Channel'
        DataBinding.FieldName = 'channel'
        Position.BandIndex = 4
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object tvGuestsresInfo: TcxGridDBBandedColumn
        Caption = 'Res info'
        DataBinding.FieldName = 'resInfo'
        Width = 100
        Position.BandIndex = 4
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object tvGuestsReservation: TcxGridDBBandedColumn
        Caption = 'Res Id'
        DataBinding.FieldName = 'Reservation'
        Width = 25
        Position.BandIndex = 4
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object tvGuestsRoomReservation: TcxGridDBBandedColumn
        Caption = 'Room Res'
        DataBinding.FieldName = 'RoomReservation'
        Width = 50
        Position.BandIndex = 4
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
    end
    object lvGuests: TcxGridLevel
      GridView = tvGuests
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
    StorageName = 'Software\Roomer\FormStatus\rptGuests'
    StorageType = stRegistry
    Left = 158
    Top = 336
  end
  object kbmGuests: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'ReservationName'
        DataType = ftWideString
        Size = 200
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
        Name = 'Adults'
        DataType = ftInteger
      end
      item
        Name = 'Children'
        DataType = ftInteger
      end
      item
        Name = 'Infants'
        DataType = ftInteger
      end
      item
        Name = 'CurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'Currency'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'AverageRate'
        DataType = ftFloat
      end
      item
        Name = 'NumDays'
        DataType = ftInteger
      end
      item
        Name = 'TotalStayRate'
        DataType = ftFloat
      end
      item
        Name = 'room'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'roomtype'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'customer'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'PersonalID'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Breakfast'
        DataType = ftBoolean
      end
      item
        Name = 'RoomDescription'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'floor'
        DataType = ftInteger
      end
      item
        Name = 'LocationDescription'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'marketSegmentDescription'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'email'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'StatusText'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'resInfo'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'RoomCount'
        DataType = ftInteger
      end
      item
        Name = 'RvGuestCount'
        DataType = ftInteger
      end
      item
        Name = 'RRGuestCount'
        DataType = ftInteger
      end
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'isMain'
        DataType = ftBoolean
      end
      item
        Name = 'channel'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'BookingId'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'TotalStayRateNative'
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
    Left = 512
    Top = 352
  end
  object GuestsDS: TDataSource
    DataSet = kbmGuests
    Left = 432
    Top = 328
  end
end
