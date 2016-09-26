inherited frmRptTotallist: TfrmRptTotallist
  Caption = 'Totallist'
  ClientHeight = 633
  ClientWidth = 1347
  Constraints.MinWidth = 570
  Font.Height = -11
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 1363
  ExplicitHeight = 672
  PixelsPerInch = 96
  TextHeight = 13
  inherited dxStatusBar: TdxStatusBar
    Top = 613
    Width = 1347
    ExplicitTop = 613
    ExplicitWidth = 1347
  end
  object Panel3: TsPanel [1]
    Left = 0
    Top = 0
    Width = 1347
    Height = 97
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object labLocationsList: TsLabel
      Left = 170
      Top = 80
      Width = 11
      Height = 13
      Caption = 'All'
    end
    object labLocations: TsLabel
      AlignWithMargins = True
      Left = 112
      Top = 80
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Locations :'
    end
    object cxGroupBox2: TsGroupBox
      Left = 170
      Top = 3
      Width = 151
      Height = 78
      Caption = '.. or select month'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object cbxMonth: TsComboBox
        Left = 15
        Top = 20
        Width = 121
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 0
        Text = 'Choose a Month ...'
        OnCloseUp = cbxMonthCloseUp
        Items.Strings = (
          'Choose a Month ...'
          'January'
          'February'
          'March'
          'April'
          'may'
          'June'
          'July'
          'august'
          'September'
          'October'
          'November'
          'December')
      end
      object cbxYear: TsComboBox
        Left = 15
        Top = 47
        Width = 121
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 1
        Text = 'Choose a year ...'
        OnCloseUp = cbxMonthCloseUp
        Items.Strings = (
          'Choose year ...'
          '2011'
          '2012'
          '2013'
          '2014'
          '2015'
          '2016'
          '2017'
          '2018'
          '2020')
      end
    end
    object btnRefresh: TsButton
      Left = 332
      Top = 10
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
      Left = 15
      Top = 3
      Width = 146
      Height = 78
      Caption = 'Select dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object dtDateFrom: TsDateEdit
        Left = 16
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
        Text = '  -  -    '
        OnChange = dtDateFromChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtDateTo: TsDateEdit
        Left = 16
        Top = 47
        Width = 105
        Height = 20
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
        Text = '  -  -    '
        OnChange = dtDateFromChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
  end
  object Panel5: TsPanel [2]
    Left = 0
    Top = 97
    Width = 1347
    Height = 43
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object btnExcel: TsButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 100
      Height = 35
      Align = alLeft
      Caption = 'Excel'
      ImageIndex = 115
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnExcelClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object grTotallist: TcxGrid [3]
    Left = 0
    Top = 140
    Width = 1347
    Height = 473
    Align = alClient
    TabOrder = 3
    LookAndFeel.NativeStyle = False
    object lvTotallist: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Append.Visible = True
      Navigator.Buttons.Delete.Visible = False
      Navigator.Buttons.Edit.Visible = False
      Navigator.Buttons.Post.Visible = False
      Navigator.Buttons.Cancel.Visible = False
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      DataController.DataSource = TotallistDS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0'
          Kind = skSum
          FieldName = 'paxDeparture'
          Column = lvTotallistpaxDeparture
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'paxAllotment'
          Column = lvTotallistpaxAllotment
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'paxInhouse'
          Column = lvTotallistpaxInhouse
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'paxArrival'
          Column = lvTotallistpaxArrival
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'paxStay'
          Column = lvTotallistpaxStay
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'paxWaitinglist'
          Column = lvTotallistpaxWaitinglist
        end
        item
          Format = '0'
          FieldName = 'RoomsAllotment'
          Column = lvTotallistRoomsAllotment
        end
        item
          Format = '0'
          FieldName = 'roomsArrival'
          Column = lvTotallistroomsArrival
        end
        item
          Kind = skCount
          FieldName = 'dtDate'
          Column = lvTotallistdtDate
        end
        item
          Format = '0'
          FieldName = 'roomsDeparture'
          Column = lvTotallistroomsDeparture
        end
        item
          Format = '0'
          FieldName = 'roomsInhouse'
          Column = lvTotallistroomsInhouse
        end
        item
          Format = '0'
          FieldName = 'roomsStay'
          Column = lvTotallistroomsStay
        end
        item
          Format = '0'
          FieldName = 'roomsWaitinglist'
          Column = lvTotallistroomsWaitinglist
        end
        item
          Format = '0'
          FieldName = 'roomsOutOfOrder'
          Column = lvTotallistroomsOutOfOrder
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'paxOutOfOrder'
          Column = lvTotallistpaxOutOfOrder
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Bands = <
        item
          Caption = 'Dates'
          FixedKind = fkLeft
        end
        item
          Caption = 'Total'
          Visible = False
        end
        item
          Caption = 'Arrival'
          Width = 148
        end
        item
          Caption = 'Inhouse'
        end
        item
          Caption = 'Departure'
        end
        item
          Caption = 'Stay'
        end
        item
          Caption = 'Optional Booking'
        end
        item
          Caption = 'Allotments'
        end
        item
          Caption = 'OutOfOrder'
        end
        item
          Caption = 'Waiting list'
        end>
      object lvTotallistdtDate: TcxGridDBBandedColumn
        Caption = 'Date'
        DataBinding.FieldName = 'dtDate'
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object lvTotallistWeekNr: TcxGridDBBandedColumn
        Caption = 'Week'
        DataBinding.FieldName = 'WeekNr'
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object lvTotallistroomsArrival: TcxGridDBBandedColumn
        Caption = 'Rooms'
        DataBinding.FieldName = 'roomsArrival'
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object lvTotallistpaxArrival: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'paxArrival'
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object lvTotallistroomsInhouse: TcxGridDBBandedColumn
        Caption = 'Rooms'
        DataBinding.FieldName = 'roomsInhouse'
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object lvTotallistpaxInhouse: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'paxInhouse'
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object lvTotallistroomsDeparture: TcxGridDBBandedColumn
        Caption = 'Rooms'
        DataBinding.FieldName = 'roomsDeparture'
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object lvTotallistpaxDeparture: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'paxDeparture'
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object lvTotallistroomsStay: TcxGridDBBandedColumn
        Caption = 'Rooms'
        DataBinding.FieldName = 'roomsStay'
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object lvTotallistpaxStay: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'paxStay'
        Position.BandIndex = 5
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object lvTotallistroomsWaitinglist: TcxGridDBBandedColumn
        Caption = 'Rooms'
        DataBinding.FieldName = 'roomsWaitinglist'
        Position.BandIndex = 6
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object lvTotallistpaxWaitinglist: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'paxWaitinglist'
        Position.BandIndex = 6
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object lvTotallistRoomsAllotment: TcxGridDBBandedColumn
        Caption = 'Rooms'
        DataBinding.FieldName = 'RoomsAllotment'
        Position.BandIndex = 7
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object lvTotallistpaxAllotment: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'paxAllotment'
        Position.BandIndex = 7
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object lvTotallistroomsTotal: TcxGridDBBandedColumn
        Caption = 'Roomsl'
        DataBinding.FieldName = 'roomsTotal'
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object lvTotallistpaxTotal: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'paxTotal'
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object lvTotallistroomsOutOfOrder: TcxGridDBBandedColumn
        Caption = 'Rooms'
        DataBinding.FieldName = 'roomsOutOfOrder'
        Position.BandIndex = 8
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object lvTotallistpaxOutOfOrder: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'paxOutOfOrder'
        Position.BandIndex = 8
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object lvTotallistroomsWaitinglistNonOptional: TcxGridDBBandedColumn
        Caption = 'Rooms'
        DataBinding.FieldName = 'roomsWaitinglistNonOptional'
        Position.BandIndex = 9
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object lvTotallistpaxWaitinglistNonOptional: TcxGridDBBandedColumn
        Caption = 'Guests'
        DataBinding.FieldName = 'paxWaitinglistNonOptional'
        Position.BandIndex = 9
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
    end
    object lvTotallistLevel1: TcxGridLevel
      GridView = lvTotallist
    end
  end
  object kbmTotallist: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'dtDate'
        DataType = ftDate
      end
      item
        Name = 'WeekNr'
        DataType = ftInteger
      end
      item
        Name = 'roomsArrival'
        DataType = ftInteger
      end
      item
        Name = 'paxArrival'
        DataType = ftInteger
      end
      item
        Name = 'roomsInhouse'
        DataType = ftInteger
      end
      item
        Name = 'paxInhouse'
        DataType = ftInteger
      end
      item
        Name = 'roomsDeparture'
        DataType = ftInteger
      end
      item
        Name = 'paxDeparture'
        DataType = ftInteger
      end
      item
        Name = 'roomsStay'
        DataType = ftInteger
      end
      item
        Name = 'paxStay'
        DataType = ftInteger
      end
      item
        Name = 'roomsWaitinglist'
        DataType = ftInteger
      end
      item
        Name = 'paxWaitinglist'
        DataType = ftInteger
      end
      item
        Name = 'RoomsAllotment'
        DataType = ftInteger
      end
      item
        Name = 'paxAllotment'
        DataType = ftInteger
      end
      item
        Name = 'roomsTotal'
        DataType = ftInteger
      end
      item
        Name = 'paxTotal'
        DataType = ftInteger
      end
      item
        Name = 'roomsOutOfOrder'
        DataType = ftInteger
      end
      item
        Name = 'paxOutOfOrder'
        DataType = ftInteger
      end
      item
        Name = 'roomsWaitinglistNonOptional'
        DataType = ftInteger
      end
      item
        Name = 'paxWaitinglistNonOptional'
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
    Left = 32
    Top = 392
  end
  object TotallistDS: TDataSource
    DataSet = kbmTotallist
    Left = 120
    Top = 392
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
    StorageName = 'Software\Roomer\FormStatus\frmRptTotallist'
    StorageType = stRegistry
    Left = 114
    Top = 262
  end
end
