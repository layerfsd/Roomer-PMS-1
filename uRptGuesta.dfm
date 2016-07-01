object frmRptNotes: TfrmRptNotes
  Left = 0
  Top = 0
  Caption = 'Reservation Notes'
  ClientHeight = 556
  ClientWidth = 1141
  Color = clBtnFace
  Constraints.MinWidth = 920
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 1141
    Height = 89
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 923
    DesignSize = (
      1141
      89)
    object __labLocationsList: TsLabel
      Left = 456
      Top = 15
      Width = 11
      Height = 13
      Caption = 'All'
    end
    object labLocations: TsLabel
      AlignWithMargins = True
      Left = 302
      Top = 15
      Width = 148
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Locations :'
    end
    object cLabFilter: TsLabel
      Left = 275
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
      Left = 523
      Top = 39
      Width = 74
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
      Left = 274
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
      Left = 11
      Top = 2
      Width = 257
      Height = 81
      Caption = 'Select Dates'
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object LMDSimpleLabel1: TsLabel
        Left = 67
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
        Left = 79
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
        Left = 128
        Top = 12
        Width = 121
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
        Text = '25-12-2012'
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        Date = 41268.000000000000000000
      end
      object dtDateTo: TsDateEdit
        Left = 128
        Top = 35
        Width = 121
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
      Left = 312
      Top = 39
      Width = 205
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
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
      Width = 69
      Height = 19
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
      Left = 808
      Top = 9
      Width = 323
      Height = 74
      Anchors = [akTop, akRight]
      Caption = 'Use Room with status of : '
      TabOrder = 4
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object chkExcluteWaitingList: TsCheckBox
        Left = 14
        Top = 17
        Width = 77
        Height = 19
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
        Width = 73
        Height = 19
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
        Width = 83
        Height = 19
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
        Width = 69
        Height = 19
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
        Width = 73
        Height = 19
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
        Width = 64
        Height = 19
        Caption = 'Blocked'
        TabOrder = 5
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object chkExcluteGuest: TsCheckBox
        Left = 134
        Top = 34
        Width = 56
        Height = 19
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
        Width = 66
        Height = 19
        Caption = 'Cancled'
        TabOrder = 7
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
  end
  object Panel5: TsPanel
    Left = 0
    Top = 89
    Width = 1141
    Height = 43
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 923
    object btnExcel: TsButton
      AlignWithMargins = True
      Left = 138
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
      ExplicitTop = 2
    end
    object btnReport: TsButton
      AlignWithMargins = True
      Left = 1009
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
      ExplicitLeft = 1037
    end
    object btnReservation: TsButton
      AlignWithMargins = True
      Left = 272
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
      ExplicitLeft = 244
    end
    object sButton1: TsButton
      AlignWithMargins = True
      Left = 4
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
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 536
    Width = 1141
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ExplicitWidth = 923
  end
  object grNotes: TcxGrid
    Left = 0
    Top = 132
    Width = 1141
    Height = 404
    Align = alClient
    TabOrder = 3
    ExplicitTop = 121
    ExplicitWidth = 923
    ExplicitHeight = 415
    object tvNotes: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = NotesDS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      Bands = <
        item
          Caption = 'Reservation'
          FixedKind = fkLeft
        end
        item
          Caption = 'Notes'
        end
        item
          Caption = 'Other'
        end>
      object tvNotesFirstArrival: TcxGridDBBandedColumn
        Caption = 'First Arrival'
        DataBinding.FieldName = 'FirstArrival'
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvNotesLastDeparture: TcxGridDBBandedColumn
        Caption = 'Last Departure'
        DataBinding.FieldName = 'LastDeparture'
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvNotesReservationName: TcxGridDBBandedColumn
        Caption = 'Reservation Name'
        DataBinding.FieldName = 'ReservationName'
        Width = 198
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvNotesRoomCount: TcxGridDBBandedColumn
        Caption = 'Rooms'
        DataBinding.FieldName = 'RoomCount'
        Width = 50
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvNotesGuestCount: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'GuestCount'
        Width = 50
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvNotesGeneralNotes: TcxGridDBBandedColumn
        Caption = 'General'
        DataBinding.FieldName = 'GeneralNotes'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 4
        Width = 219
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvNotesPaymentNotes: TcxGridDBBandedColumn
        Caption = 'Payment'
        DataBinding.FieldName = 'PaymentNotes'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 4
        Width = 210
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvNotescustomer: TcxGridDBBandedColumn
        Caption = 'Customer'
        DataBinding.FieldName = 'customer'
        Width = 115
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvNotesCustomerName: TcxGridDBBandedColumn
        Caption = 'Customer Name'
        DataBinding.FieldName = 'CustomerName'
        Width = 136
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvNotesChannel: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Channel'
        Width = 150
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvNotesReservation: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Reservation'
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvNotescontactName: TcxGridDBBandedColumn
        Caption = 'Contact Name'
        DataBinding.FieldName = 'contactName'
        Width = 150
        Position.BandIndex = 2
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvNotescontactEmail: TcxGridDBBandedColumn
        Caption = 'Contact Email'
        DataBinding.FieldName = 'contactEmail'
        Width = 150
        Position.BandIndex = 2
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
    end
    object lvNotes: TcxGridLevel
      GridView = tvNotes
    end
  end
  object kbmNotes: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'GeneralNotes'
        DataType = ftWideMemo
      end
      item
        Name = 'PaymentNotes'
        DataType = ftWideMemo
      end
      item
        Name = 'customer'
        DataType = ftWideString
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'ReservationName'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'Channel'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'FirstArrival'
        DataType = ftDateTime
      end
      item
        Name = 'LastDeparture'
        DataType = ftDateTime
      end
      item
        Name = 'RoomCount'
        DataType = ftInteger
      end
      item
        Name = 'GuestCount'
        DataType = ftInteger
      end
      item
        Name = 'contactName'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'contactEmail'
        DataType = ftWideString
        Size = 150
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
    Left = 160
    Top = 216
  end
  object NotesDS: TDataSource
    DataSet = kbmNotes
    Left = 160
    Top = 272
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
    StorageName = 'Software\Roomer\FormStatus\rptNotes'
    StorageType = stRegistry
    Left = 158
    Top = 344
  end
end
