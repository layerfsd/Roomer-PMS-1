object frmRptManagment: TfrmRptManagment
  Left = 0
  Top = 0
  Caption = 'Statitic'
  ClientHeight = 643
  ClientWidth = 1167
  Color = clBtnFace
  Constraints.MinWidth = 570
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 1167
    Height = 89
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object cxGroupBox2: TsGroupBox
      Left = 148
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
      Left = 305
      Top = 13
      Width = 118
      Height = 37
      Caption = 'Refresh ALL'
      Default = True
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 1
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object gbxSelectDates: TsGroupBox
      Left = 8
      Top = 3
      Width = 135
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
    object chkCompareLasYear: TsCheckBox
      Left = 306
      Top = 56
      Width = 116
      Height = 19
      Caption = 'Compare last year'
      TabOrder = 3
      Visible = False
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 624
    Width = 1167
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object pageMain: TsPageControl
    Left = 0
    Top = 89
    Width = 1167
    Height = 535
    ActivePage = tabStatGrid
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PAGECONTROL'
    object tabStatGrid: TsTabSheet
      Caption = 'Data'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel1: TsPanel
        Left = 0
        Top = 0
        Width = 1159
        Height = 43
        Align = alTop
        FullRepaint = False
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnGuestsExcel: TsButton
          AlignWithMargins = True
          Left = 11
          Top = 4
          Width = 128
          Height = 35
          Margins.Left = 10
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnGuestsExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnReport: TsButton
          AlignWithMargins = True
          Left = 1027
          Top = 4
          Width = 128
          Height = 35
          Margins.Left = 10
          Align = alRight
          Caption = 'Report'
          ImageIndex = 118
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnReportClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grStat: TcxGrid
        Left = 0
        Top = 43
        Width = 1159
        Height = 464
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvStat: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = StatDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
        end
        object tvStats: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = StatDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'revenue'
              Column = tvStatsrevenue
            end
            item
              Format = ',0.%;-,0.%'
              Kind = skAverage
              FieldName = 'occ'
              Column = tvStatsocc
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skAverage
              FieldName = 'adr'
              Column = tvStatsadr
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skAverage
              FieldName = 'revPar'
              Column = tvStatsrevPar
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'totalDiscount'
              Column = tvStatstotalDiscount
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skMax
              FieldName = 'maxRate'
              Column = tvStatsmaxRate
            end
            item
              Format = ',0.;-,0.'
              Kind = skCount
              FieldName = 'ADate'
              Column = tvStatsADate
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skAverage
              FieldName = 'averageRate'
              Column = tvStatsaverageRate
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'totalGuests'
              Column = tvStatstotalGuests
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skMin
              FieldName = 'minRate'
              Column = tvStatsminRate
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'totalRooms'
              Column = tvStatstotalRooms
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'soldRooms'
              Column = tvStatssoldRooms
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'occupiedRooms'
              Column = tvStatsoccupiedRooms
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'checkedInToday'
              Column = tvStatscheckedInToday
            end
            item
              Format = ',0.;-,0.'
              FieldName = 'arrivingRooms'
              Column = tvStatsarrivingRooms
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'noShow'
              Column = tvStatsnoShow
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'departingRooms'
              Column = tvStatsdepartingRooms
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'departedRooms'
              Column = tvStatsdepartedRooms
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Bands = <
            item
              Caption = 'Main'
              FixedKind = fkLeft
            end
            item
              Caption = 'Rate'
            end
            item
              Caption = 'Status'
            end>
          object tvStatsADate: TcxGridDBBandedColumn
            Caption = 'Date'
            DataBinding.FieldName = 'ADate'
            Width = 81
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object tvStatssoldRooms: TcxGridDBBandedColumn
            Caption = 'Sold Rooms'
            DataBinding.FieldName = 'soldRooms'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.;-,0.'
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object tvStatsrevenue: TcxGridDBBandedColumn
            Caption = 'Revenue'
            DataBinding.FieldName = 'revenue'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvStatsrevenueGetProperties
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object tvStatstotalDiscount: TcxGridDBBandedColumn
            Caption = 'Total Discount'
            DataBinding.FieldName = 'totalDiscount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetPropertiesForEdit = tvStatsrevenueGetProperties
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object tvStatsmaxRate: TcxGridDBBandedColumn
            Caption = 'Max'
            DataBinding.FieldName = 'maxRate'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetPropertiesForEdit = tvStatsrevenueGetProperties
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object tvStatsminRate: TcxGridDBBandedColumn
            Caption = 'MIN'
            DataBinding.FieldName = 'minRate'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetPropertiesForEdit = tvStatsrevenueGetProperties
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object tvStatsaverageRate: TcxGridDBBandedColumn
            Caption = 'Average'
            DataBinding.FieldName = 'averageRate'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetPropertiesForEdit = tvStatsrevenueGetProperties
            Position.BandIndex = 1
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object tvStatscheckedInToday: TcxGridDBBandedColumn
            Caption = 'CheckedIn Today'
            DataBinding.FieldName = 'checkedInToday'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.;-,0.'
            Position.BandIndex = 2
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object tvStatsarrivingRooms: TcxGridDBBandedColumn
            Caption = 'Arriving Rooms'
            DataBinding.FieldName = 'arrivingRooms'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.;-,0.'
            Position.BandIndex = 2
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object tvStatsnoShow: TcxGridDBBandedColumn
            DataBinding.FieldName = 'noShow'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.;-,0.'
            Position.BandIndex = 2
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object tvStatsdepartingRooms: TcxGridDBBandedColumn
            Caption = 'Departing Rooms'
            DataBinding.FieldName = 'departingRooms'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.;-,0.'
            Position.BandIndex = 2
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object tvStatsdepartedRooms: TcxGridDBBandedColumn
            Caption = 'Departed Rooms'
            DataBinding.FieldName = 'departedRooms'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.;-,0.'
            Position.BandIndex = 2
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object tvStatsoccupiedRooms: TcxGridDBBandedColumn
            Caption = 'Occupied Rooms'
            DataBinding.FieldName = 'occupiedRooms'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.;-,0.'
            Position.BandIndex = 2
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object tvStatstotalRooms: TcxGridDBBandedColumn
            Caption = 'Tota lRooms'
            DataBinding.FieldName = 'totalRooms'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.;-,0.'
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object tvStatslocalCurrency: TcxGridDBBandedColumn
            Caption = 'Curr- ency'
            DataBinding.FieldName = 'localCurrency'
            Width = 55
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object tvStatstotalGuests: TcxGridDBBandedColumn
            Caption = 'Total Guests'
            DataBinding.FieldName = 'totalGuests'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.;-,0.'
            Position.BandIndex = 1
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object tvStatsocc: TcxGridDBBandedColumn
            Caption = 'OCC'
            DataBinding.FieldName = 'occ'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.%;-,0.%'
            HeaderHint = 'Occupancy'
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object tvStatsadr: TcxGridDBBandedColumn
            Caption = 'ADR'
            DataBinding.FieldName = 'adr'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetPropertiesForEdit = tvStatsrevenueGetProperties
            HeaderHint = 'Average daily rates'
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object tvStatsrevPar: TcxGridDBBandedColumn
            Caption = 'Rev Par'
            DataBinding.FieldName = 'revPar'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvStatsrevenueGetProperties
            HeaderHint = 'Revenue Per Available Room'
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
        end
        object lvStat: TcxGridLevel
          GridView = tvStats
        end
      end
    end
    object tabGraph: TsTabSheet
      Caption = 'Charts'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pageCharts: TsPageControl
        Left = 0
        Top = 0
        Width = 1159
        Height = 507
        ActivePage = tabOcc
        Align = alClient
        TabOrder = 0
        SkinData.SkinSection = 'PAGECONTROL'
        object tabOcc: TsTabSheet
          Caption = 'OCC'
          SkinData.CustomColor = False
          SkinData.CustomFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object sPanel2: TsPanel
            Left = 0
            Top = 0
            Width = 1151
            Height = 33
            Align = alTop
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            object sButton2: TsButton
              AlignWithMargins = True
              Left = 16
              Top = 6
              Width = 128
              Height = 21
              Margins.Left = 15
              Margins.Top = 5
              Margins.Bottom = 5
              Align = alLeft
              Caption = 'Create Chart'
              ImageIndex = 0
              TabOrder = 0
              OnClick = sButton2Click
              SkinData.SkinSection = 'BUTTON'
            end
          end
          object Chart1: TChart
            Left = 0
            Top = 33
            Width = 1151
            Height = 446
            Legend.Visible = False
            SubTitle.Font.Color = clBlack
            Title.Text.Strings = (
              'Occupancy')
            BottomAxis.LabelsFont.Height = -12
            SeriesGroups = <
              item
                Name = 'Group1'
              end>
            View3DWalls = False
            Align = alClient
            BevelOuter = bvNone
            Color = clWhite
            TabOrder = 1
            PrintMargins = (
              15
              29
              15
              29)
            ColorPaletteIndex = 10
            object Series1: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              Brush.BackColor = clDefault
              LinePen.Color = 390140
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              TreatNulls = tnIgnore
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
              Data = {
                0007000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000}
            end
          end
        end
      end
    end
  end
  object kbmStat: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ADate'
        DataType = ftDate
      end
      item
        Name = 'soldRooms'
        DataType = ftInteger
      end
      item
        Name = 'revenue'
        DataType = ftFloat
      end
      item
        Name = 'totalDiscount'
        DataType = ftFloat
      end
      item
        Name = 'maxRate'
        DataType = ftFloat
      end
      item
        Name = 'minRate'
        DataType = ftFloat
      end
      item
        Name = 'averageRate'
        DataType = ftFloat
      end
      item
        Name = 'checkedInToday'
        DataType = ftInteger
      end
      item
        Name = 'arrivingRooms'
        DataType = ftInteger
      end
      item
        Name = 'noShow'
        DataType = ftInteger
      end
      item
        Name = 'departingRooms'
        DataType = ftInteger
      end
      item
        Name = 'departedRooms'
        DataType = ftInteger
      end
      item
        Name = 'occupiedRooms'
        DataType = ftInteger
      end
      item
        Name = 'totalRooms'
        DataType = ftInteger
      end
      item
        Name = 'localCurrency'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'totalGuests'
        DataType = ftInteger
      end
      item
        Name = 'ooo'
        DataType = ftFloat
      end
      item
        Name = 'occ'
        DataType = ftFloat
      end
      item
        Name = 'adr'
        DataType = ftFloat
      end
      item
        Name = 'revPar'
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
    Left = 584
    Top = 280
  end
  object StatDS: TDataSource
    DataSet = kbmStat
    Left = 640
    Top = 280
  end
  object AdvChartPanesEditorDialog1: TAdvChartPanesEditorDialog
    Left = 824
    Top = 32
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
    StorageName = 'Software\Roomer\FormStatus\frmRptManagment'
    StorageType = stRegistry
    Left = 114
    Top = 262
  end
  object kbmStatReport: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ADate'
        DataType = ftDate
      end
      item
        Name = 'soldRooms'
        DataType = ftInteger
      end
      item
        Name = 'revenue'
        DataType = ftFloat
      end
      item
        Name = 'totalDiscount'
        DataType = ftFloat
      end
      item
        Name = 'maxRate'
        DataType = ftFloat
      end
      item
        Name = 'minRate'
        DataType = ftFloat
      end
      item
        Name = 'averageRate'
        DataType = ftFloat
      end
      item
        Name = 'checkedInToday'
        DataType = ftInteger
      end
      item
        Name = 'arrivingRooms'
        DataType = ftInteger
      end
      item
        Name = 'noShow'
        DataType = ftInteger
      end
      item
        Name = 'departingRooms'
        DataType = ftInteger
      end
      item
        Name = 'departedRooms'
        DataType = ftInteger
      end
      item
        Name = 'occupiedRooms'
        DataType = ftInteger
      end
      item
        Name = 'totalRooms'
        DataType = ftInteger
      end
      item
        Name = 'localCurrency'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'totalGuests'
        DataType = ftInteger
      end
      item
        Name = 'ooo'
        DataType = ftFloat
      end
      item
        Name = 'occ'
        DataType = ftFloat
      end
      item
        Name = 'adr'
        DataType = ftFloat
      end
      item
        Name = 'revPar'
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
    Left = 248
    Top = 280
  end
  object dsStatReport: TDataSource
    DataSet = kbmStatReport
    Left = 328
    Top = 280
  end
  object plStats: TppDBPipeline
    DataSource = dsStatReport
    UserName = 'plStats'
    Left = 336
    Top = 331
    object plStatsppField1: TppField
      FieldAlias = 'ADate'
      FieldName = 'ADate'
      FieldLength = 0
      DataType = dtDate
      DisplayWidth = 10
      Position = 0
    end
    object plStatsppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'soldRooms'
      FieldName = 'soldRooms'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 1
    end
    object plStatsppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'revenue'
      FieldName = 'revenue'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 2
    end
    object plStatsppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'totalDiscount'
      FieldName = 'totalDiscount'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 3
    end
    object plStatsppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'maxRate'
      FieldName = 'maxRate'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 4
    end
    object plStatsppField6: TppField
      Alignment = taRightJustify
      FieldAlias = 'minRate'
      FieldName = 'minRate'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 5
    end
    object plStatsppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'averageRate'
      FieldName = 'averageRate'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 6
    end
    object plStatsppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'checkedInToday'
      FieldName = 'checkedInToday'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 7
    end
    object plStatsppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'arrivingRooms'
      FieldName = 'arrivingRooms'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 8
    end
    object plStatsppField10: TppField
      Alignment = taRightJustify
      FieldAlias = 'noShow'
      FieldName = 'noShow'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 9
    end
    object plStatsppField11: TppField
      Alignment = taRightJustify
      FieldAlias = 'departingRooms'
      FieldName = 'departingRooms'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 10
    end
    object plStatsppField12: TppField
      Alignment = taRightJustify
      FieldAlias = 'departedRooms'
      FieldName = 'departedRooms'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 11
    end
    object plStatsppField13: TppField
      Alignment = taRightJustify
      FieldAlias = 'occupiedRooms'
      FieldName = 'occupiedRooms'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 12
    end
    object plStatsppField14: TppField
      Alignment = taRightJustify
      FieldAlias = 'totalRooms'
      FieldName = 'totalRooms'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 13
    end
    object plStatsppField15: TppField
      FieldAlias = 'localCurrency'
      FieldName = 'localCurrency'
      FieldLength = 10
      DisplayWidth = 10
      Position = 14
    end
    object plStatsppField16: TppField
      Alignment = taRightJustify
      FieldAlias = 'totalGuests'
      FieldName = 'totalGuests'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 15
    end
    object plStatsppField17: TppField
      Alignment = taRightJustify
      FieldAlias = 'ooo'
      FieldName = 'ooo'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 16
    end
    object plStatsppField18: TppField
      Alignment = taRightJustify
      FieldAlias = 'occ'
      FieldName = 'occ'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 17
    end
    object plStatsppField19: TppField
      Alignment = taRightJustify
      FieldAlias = 'adr'
      FieldName = 'adr'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 18
    end
    object plStatsppField20: TppField
      Alignment = taRightJustify
      FieldAlias = 'revPar'
      FieldName = 'revPar'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 19
    end
  end
  object rptStats: TppReport
    AutoStop = False
    DataPipeline = plStats
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 210000
    PrinterSetup.mmPaperWidth = 297000
    PrinterSetup.PaperSize = 9
    AllowPrintToArchive = True
    AllowPrintToFile = True
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    Left = 248
    Top = 331
    Version = '14.07'
    mmColumnWidth = 284300
    DataPipelineName = 'plStats'
    object ppHeaderBand1: TppHeaderBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 34131
      mmPrintPosition = 0
      object ppLine1: TppLine
        UserName = 'Line1'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 1588
        mmLeft = 0
        mmTop = 32543
        mmWidth = 284300
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'Room/Rent statistics Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 7535
        mmLeft = 2646
        mmTop = 529
        mmWidth = 85344
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        Caption = 'From :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 2910
        mmTop = 9525
        mmWidth = 9790
        BandType = 0
        LayerName = Foreground
      end
      object rlabFrom: TppLabel
        UserName = 'rLabFrom'
        Caption = '01.01.2010'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 15081
        mmTop = 9525
        mmWidth = 15875
        BandType = 0
        LayerName = Foreground
      end
      object rLabTo: TppLabel
        UserName = 'rLabTo'
        Caption = '01.01.2010'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 42333
        mmTop = 9525
        mmWidth = 15875
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = 'To :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 34660
        mmTop = 9525
        mmWidth = 5556
        BandType = 0
        LayerName = Foreground
      end
      object rLabHotelName: TppLabel
        UserName = 'rLabHotelName'
        Caption = 'Hotel name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 268553
        mmTop = 529
        mmWidth = 15610
        BandType = 0
        LayerName = Foreground
      end
      object rlabUser: TppLabel
        UserName = 'rLabUser'
        Caption = 'hj'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 281253
        mmTop = 4763
        mmWidth = 2910
        BandType = 0
        LayerName = Foreground
      end
      object rLabTimeCreated: TppLabel
        UserName = 'rLabTimeCreated'
        Caption = '01.01.2010 22:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 259028
        mmTop = 9525
        mmWidth = 25135
        BandType = 0
        LayerName = Foreground
      end
      object ppLine11: TppLine
        UserName = 'Line11'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 529
        mmLeft = 0
        mmTop = 14288
        mmWidth = 284300
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 1588
        mmTop = 26458
        mmWidth = 18521
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Revenue'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 20638
        mmTop = 26458
        mmWidth = 15610
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'Occ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 39158
        mmTop = 26458
        mmWidth = 7673
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'ADR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 48419
        mmTop = 26458
        mmWidth = 11113
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Caption = 'RevPar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 60590
        mmTop = 26458
        mmWidth = 11113
        BandType = 0
        LayerName = Foreground
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 18256
        mmLeft = 72761
        mmTop = 14288
        mmWidth = 265
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        AutoSize = False
        Caption = 'Curr'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 75142
        mmTop = 26458
        mmWidth = 7408
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        AutoSize = False
        Caption = 'Total Discount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        mmHeight = 7673
        mmLeft = 84138
        mmTop = 22490
        mmWidth = 14552
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel12: TppLabel
        UserName = 'Label12'
        AutoSize = False
        Caption = 'Max'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 101071
        mmTop = 26458
        mmWidth = 16404
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        AutoSize = False
        Caption = 'Min'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 118004
        mmTop = 26458
        mmWidth = 16404
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel14: TppLabel
        UserName = 'Label14'
        AutoSize = False
        Caption = 'Average'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3598
        mmLeft = 135202
        mmTop = 26458
        mmWidth = 16404
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel15: TppLabel
        UserName = 'Label15'
        AutoSize = False
        Caption = 'Total Guests'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        mmHeight = 7673
        mmLeft = 154517
        mmTop = 22490
        mmWidth = 14023
        BandType = 0
        LayerName = Foreground
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 17992
        mmLeft = 169863
        mmTop = 14288
        mmWidth = 265
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel16: TppLabel
        UserName = 'Label16'
        AutoSize = False
        Caption = 'Total Rooms'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        mmHeight = 7673
        mmLeft = 171186
        mmTop = 22490
        mmWidth = 16404
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel17: TppLabel
        UserName = 'Label17'
        AutoSize = False
        Caption = 'Sold Rooms'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        mmHeight = 7673
        mmLeft = 188119
        mmTop = 22490
        mmWidth = 15346
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel18: TppLabel
        UserName = 'Label18'
        AutoSize = False
        Caption = 'Occupied Rooms'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        mmHeight = 7408
        mmLeft = 204259
        mmTop = 22754
        mmWidth = 16404
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel19: TppLabel
        UserName = 'Label19'
        AutoSize = False
        Caption = 'CheckedIn Today'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        mmHeight = 7408
        mmLeft = 221457
        mmTop = 22754
        mmWidth = 16404
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel20: TppLabel
        UserName = 'Label20'
        AutoSize = False
        Caption = 'Arriving Rooms'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        mmHeight = 7408
        mmLeft = 239448
        mmTop = 22754
        mmWidth = 15081
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel21: TppLabel
        UserName = 'Label21'
        AutoSize = False
        Caption = 'No Show'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        mmHeight = 7673
        mmLeft = 255588
        mmTop = 22490
        mmWidth = 11906
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel22: TppLabel
        UserName = 'Label22'
        AutoSize = False
        Caption = 'Departing Rooms'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        WordWrap = True
        mmHeight = 7673
        mmLeft = 268817
        mmTop = 22490
        mmWidth = 14817
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel23: TppLabel
        UserName = 'Label23'
        AutoSize = False
        Caption = 'Main'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 0
        mmTop = 16140
        mmWidth = 72496
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel24: TppLabel
        UserName = 'Label24'
        AutoSize = False
        Caption = 'Rate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 72761
        mmTop = 16140
        mmWidth = 96573
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel25: TppLabel
        UserName = 'Label25'
        AutoSize = False
        Caption = 'Status'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3810
        mmLeft = 171186
        mmTop = 16140
        mmWidth = 112448
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 6085
      mmPrintPosition = 0
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'revenue'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 20638
        mmTop = 0
        mmWidth = 15346
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'occ'
        DataPipeline = plStats
        DisplayFormat = '0 %'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 39158
        mmTop = 0
        mmWidth = 7673
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'adr'
        DataPipeline = plStats
        DisplayFormat = '$#,0;-$#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 48419
        mmTop = 0
        mmWidth = 11113
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'revPar'
        DataPipeline = plStats
        DisplayFormat = '$#,0;-$#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 60590
        mmTop = 0
        mmWidth = 11113
        BandType = 4
        LayerName = Foreground
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        ParentHeight = True
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 6085
        mmLeft = 72761
        mmTop = 0
        mmWidth = 265
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'localCurrency'
        DataPipeline = plStats
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3704
        mmLeft = 75142
        mmTop = 0
        mmWidth = 7408
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'totalDiscount'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 84138
        mmTop = 0
        mmWidth = 14552
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        DataField = 'maxRate'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 101071
        mmTop = 0
        mmWidth = 16404
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText9: TppDBText
        UserName = 'DBText9'
        DataField = 'minRate'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 118004
        mmTop = 0
        mmWidth = 16404
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText10: TppDBText
        UserName = 'DBText10'
        DataField = 'averageRate'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 135202
        mmTop = 0
        mmWidth = 16404
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText11: TppDBText
        UserName = 'DBText11'
        DataField = 'totalGuests'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 154517
        mmTop = 0
        mmWidth = 14023
        BandType = 4
        LayerName = Foreground
      end
      object ppLine6: TppLine
        UserName = 'Line6'
        ParentHeight = True
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 6085
        mmLeft = 169863
        mmTop = 0
        mmWidth = 265
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText12: TppDBText
        UserName = 'DBText12'
        DataField = 'totalRooms'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 171186
        mmTop = 0
        mmWidth = 16404
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText13: TppDBText
        UserName = 'DBText13'
        DataField = 'soldRooms'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 188119
        mmTop = 0
        mmWidth = 15346
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText14: TppDBText
        UserName = 'DBText14'
        DataField = 'occupiedRooms'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 204259
        mmTop = 0
        mmWidth = 16404
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText15: TppDBText
        UserName = 'DBText15'
        DataField = 'checkedInToday'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 221457
        mmTop = 0
        mmWidth = 16404
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText16: TppDBText
        UserName = 'DBText16'
        DataField = 'arrivingRooms'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 239448
        mmTop = 0
        mmWidth = 15081
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText17: TppDBText
        UserName = 'DBText17'
        DataField = 'noShow'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 255588
        mmTop = 0
        mmWidth = 11906
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText18: TppDBText
        UserName = 'DBText18'
        DataField = 'departingRooms'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 268817
        mmTop = 0
        mmWidth = 14817
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'ADate'
        DataPipeline = plStats
        DisplayFormat = 'm/d/yy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3704
        mmLeft = 1588
        mmTop = 0
        mmWidth = 18521
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 6615
      mmPrintPosition = 0
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtPageSet
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 13229
        mmTop = 2117
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        Caption = 'Page :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 2910
        mmTop = 2117
        mmWidth = 9260
        BandType = 8
        LayerName = Foreground
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 794
        mmLeft = 0
        mmTop = 265
        mmWidth = 284300
        BandType = 8
        LayerName = Foreground
      end
    end
    object ppSummaryBand1: TppSummaryBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppLine7: TppLine
        UserName = 'Line7'
        Pen.Width = 2
        ParentWidth = True
        Weight = 1.500000000000000000
        mmHeight = 265
        mmLeft = 0
        mmTop = 0
        mmWidth = 284300
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc1: TppDBCalc
        UserName = 'DBCalc1'
        DataField = 'adate'
        DataPipeline = plStats
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DBCalcType = dcCount
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 1852
        mmTop = 794
        mmWidth = 18256
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc2: TppDBCalc
        UserName = 'DBCalc2'
        DataField = 'revenue'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 20638
        mmTop = 794
        mmWidth = 15346
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc3: TppDBCalc
        UserName = 'DBCalc3'
        DataField = 'occ'
        DataPipeline = plStats
        DisplayFormat = '0 %'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcAverage
        DataPipelineName = 'plStats'
        mmHeight = 3704
        mmLeft = 39158
        mmTop = 794
        mmWidth = 7673
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc4: TppDBCalc
        UserName = 'DBCalc4'
        DataField = 'adr'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcAverage
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 48419
        mmTop = 794
        mmWidth = 10583
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc5: TppDBCalc
        UserName = 'DBCalc5'
        DataField = 'revpar'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcAverage
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 60590
        mmTop = 794
        mmWidth = 11113
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc6: TppDBCalc
        UserName = 'DBCalc6'
        DataField = 'totaldiscount'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 84138
        mmTop = 794
        mmWidth = 14552
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc7: TppDBCalc
        UserName = 'DBCalc7'
        DataField = 'maxrate'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcMaximum
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 101071
        mmTop = 794
        mmWidth = 16404
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc8: TppDBCalc
        UserName = 'DBCalc8'
        DataField = 'minrate'
        DataPipeline = plStats
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcMinimum
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 118004
        mmTop = 794
        mmWidth = 16404
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc9: TppDBCalc
        UserName = 'DBCalc9'
        DataField = 'averagerate'
        DataPipeline = plStats
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcAverage
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 135202
        mmTop = 794
        mmWidth = 16404
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc10: TppDBCalc
        UserName = 'DBCalc10'
        DataField = 'totalguests'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 154517
        mmTop = 794
        mmWidth = 14023
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc12: TppDBCalc
        UserName = 'DBCalc12'
        DataField = 'soldRooms'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 188119
        mmTop = 794
        mmWidth = 15346
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc13: TppDBCalc
        UserName = 'DBCalc13'
        DataField = 'occupiedRooms'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 204259
        mmTop = 794
        mmWidth = 16404
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc14: TppDBCalc
        UserName = 'DBCalc14'
        DataField = 'checkedInToday'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 221457
        mmTop = 794
        mmWidth = 16404
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc15: TppDBCalc
        UserName = 'DBCalc15'
        DataField = 'arrivingRooms'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 239448
        mmTop = 794
        mmWidth = 16404
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc16: TppDBCalc
        UserName = 'DBCalc16'
        DataField = 'noShow'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 255588
        mmTop = 794
        mmWidth = 11906
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc17: TppDBCalc
        UserName = 'DBCalc17'
        DataField = 'departingRooms'
        DataPipeline = plStats
        DisplayFormat = '#,0;-#,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'plStats'
        mmHeight = 3598
        mmLeft = 268553
        mmTop = 794
        mmWidth = 15081
        BandType = 7
        LayerName = Foreground
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
end
