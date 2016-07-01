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
          ImageIndex = 115
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnGuestsExcelClick
          SkinData.SkinSection = 'BUTTON'
          ExplicitLeft = 16
          ExplicitTop = 6
          ExplicitHeight = 27
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
        ExplicitTop = 39
        ExplicitHeight = 468
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
end
