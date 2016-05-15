object frmGuestSearch: TfrmGuestSearch
  Left = 0
  Top = 0
  ActiveControl = btnExecute
  Caption = 'Guest Search'
  ClientHeight = 574
  ClientWidth = 1083
  Color = clBtnFace
  Constraints.MinWidth = 830
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1083
    Height = 118
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1083
      118)
    object Query: TsGroupBox
      Left = 15
      Top = 5
      Width = 454
      Height = 81
      Caption = 'Query'
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object sLabel1: TsLabel
        Left = 109
        Top = 51
        Width = 79
        Height = 13
        Alignment = taRightJustify
        Caption = 'Search method :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edText: TsEdit
        Left = 12
        Top = 21
        Width = 434
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        SkinData.SkinSection = 'EDIT'
      end
      object cbxMedhod: TsComboBox
        Left = 191
        Top = 48
        Width = 255
        Height = 21
        Alignment = taLeftJustify
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 1
        Text = 'Any part of text'
        OnChange = cbxMedhodChange
        Items.Strings = (
          'Any part of text'
          'Start of text'
          'End of text')
      end
    end
    object gbxDates: TsGroupBox
      Left = 681
      Top = 5
      Width = 158
      Height = 81
      Caption = ' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object sLabel3: TsLabel
        Left = 19
        Top = 23
        Width = 31
        Height = 13
        Caption = 'From :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sLabel4: TsLabel
        Left = 31
        Top = 52
        Width = 19
        Height = 13
        Caption = 'To :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object dtDateFrom: TsDateEdit
        Left = 56
        Top = 21
        Width = 89
        Height = 21
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BevelKind = bkFlat
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
        Text = '  -  -    '
        OnChange = dtDateFromChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtDateTo: TsDateEdit
        Left = 56
        Top = 48
        Width = 89
        Height = 21
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BevelKind = bkFlat
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
        Text = '  -  -    '
        OnChange = dtDateFromChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
    object chkUseDates: TsCheckBox
      Left = 690
      Top = 2
      Width = 76
      Height = 17
      Caption = 'Use dates'
      TabOrder = 2
      OnClick = chkUseDatesClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object btnReservation: TsButton
      Left = 151
      Top = 89
      Width = 130
      Height = 25
      Caption = 'Reservation'
      ImageIndex = 56
      Images = DImages.PngImageList1
      TabOrder = 3
      OnClick = btnReservationClick
      SkinData.SkinSection = 'BUTTON'
    end
    object LMDSpeedButton1: TsButton
      Left = 287
      Top = 89
      Width = 130
      Height = 25
      Caption = 'Guests'
      ImageIndex = 39
      Images = DImages.PngImageList1
      TabOrder = 4
      OnClick = LMDSpeedButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object LMDButton1: TsButton
      Left = 962
      Top = 5
      Width = 110
      Height = 31
      Anchors = [akTop, akRight]
      Caption = 'Jump to room'
      ImageIndex = 57
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 5
      OnClick = LMDButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton1: TsButton
      Left = 15
      Top = 89
      Width = 130
      Height = 25
      Caption = 'Excel'
      ImageIndex = 132
      Images = DImages.PngImageList1
      TabOrder = 6
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object btnExecute: TsButton
      Left = 428
      Top = 89
      Width = 159
      Height = 25
      Caption = 'Search'
      Default = True
      ImageIndex = 129
      Images = DImages.PngImageList1
      TabOrder = 7
      OnClick = btnExecuteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object sGroupBox1: TsGroupBox
      Left = 477
      Top = 5
      Width = 196
      Height = 81
      Caption = 'Just search in'
      TabOrder = 8
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object chkbxFields: TsCheckListBox
        Left = 5
        Top = 17
        Width = 185
        Height = 54
        BorderStyle = bsSingle
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Items.Strings = (
          'Guest name'
          'Reservation Name'
          'Customer Name')
        ParentFont = False
        TabOrder = 0
        SkinData.SkinSection = 'EDIT'
        OnClickCheck = chkbxFieldsClickCheck
      end
    end
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 555
    Width = 1083
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object grData: TcxGrid
    Left = 0
    Top = 151
    Width = 1083
    Height = 404
    Align = alClient
    Images = DImages.PngImageList1
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    object tvData: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = kbmDataDS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.HeaderAutoHeight = True
      object tvDataRoomReservation: TcxGridDBColumn
        DataBinding.FieldName = 'RoomReservation'
        Visible = False
      end
      object tvDataReservation: TcxGridDBColumn
        DataBinding.FieldName = 'Reservation'
        Visible = False
      end
      object tvDataRoom: TcxGridDBColumn
        DataBinding.FieldName = 'Room'
        Options.Editing = False
      end
      object tvDataArrival: TcxGridDBColumn
        DataBinding.FieldName = 'Arrival'
        Options.Editing = False
      end
      object tvDataDeparture: TcxGridDBColumn
        DataBinding.FieldName = 'Departure'
        Options.Editing = False
      end
      object tvDataStatus: TcxGridDBColumn
        DataBinding.FieldName = 'Status'
        Options.Editing = False
        Width = 44
      end
      object tvDataGuestName: TcxGridDBColumn
        DataBinding.FieldName = 'GuestName'
        Options.Editing = False
        Width = 150
      end
      object tvDataReservationName: TcxGridDBColumn
        Caption = 'Reservation name'
        DataBinding.FieldName = 'ReservationName'
        Options.Editing = False
        Width = 150
      end
      object tvDataCustomerName: TcxGridDBColumn
        Caption = 'Customer name'
        DataBinding.FieldName = 'CustomerName'
        Options.Editing = False
        Width = 150
      end
      object tvDataCustomer: TcxGridDBColumn
        DataBinding.FieldName = 'Customer'
        Options.Editing = False
        Width = 82
      end
      object tvDataCountry: TcxGridDBColumn
        DataBinding.FieldName = 'Country'
        Options.Editing = False
        Width = 51
      end
      object tvDatareference: TcxGridDBColumn
        DataBinding.FieldName = 'reference'
        Width = 118
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 118
    Width = 1083
    Height = 33
    Align = alTop
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    object cLabFilter: TsLabel
      Left = 19
      Top = 10
      Width = 60
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Filter :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnClear: TsSpeedButton
      Left = 290
      Top = 8
      Width = 58
      Height = 20
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object sLabel2: TsLabel
      Left = 365
      Top = 9
      Width = 113
      Height = 13
      Caption = 'Max result (0 no limit)  :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labRecordCount: TsLabel
      Left = 565
      Top = 10
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
    object edFilter: TsEdit
      Left = 85
      Top = 7
      Width = 201
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
    object edLimitTo: TsSpinEdit
      Left = 483
      Top = 7
      Width = 73
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '2000'
      OnChange = edLimitToChange
      SkinData.SkinSection = 'EDIT'
      MaxValue = 2000
      MinValue = 0
      Value = 2000
    end
  end
  object kbmData: TkbmMemTable
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
        Name = 'Country'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Room'
        DataType = ftString
        Size = 10
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
        Name = 'Status'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Customer'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'GuestName'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ReservationName'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'CustomerName'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'reference'
        DataType = ftString
        Size = 30
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
    Left = 536
    Top = 248
  end
  object kbmDataDS: TDataSource
    DataSet = kbmData
    Left = 616
    Top = 248
  end
  object StoreMain: TcxPropertiesStore
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
    StorageName = 'Software\Roomer\FormStatus\GuestSearch'
    StorageType = stRegistry
    Left = 112
    Top = 264
  end
end
