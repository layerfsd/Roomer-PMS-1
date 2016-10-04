object frmRptResStatsRooms: TfrmRptResStatsRooms
  Left = 0
  Top = 0
  Caption = 'Reservation Statistics'
  ClientHeight = 789
  ClientWidth = 1165
  Color = clBtnFace
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 1165
    Height = 127
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object gbxSelectDates: TsGroupBox
      Left = 8
      Top = 4
      Width = 132
      Height = 74
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
      object dtDateFrom: TsDateEdit
        Left = 16
        Top = 18
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
        Top = 45
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
        TabOrder = 1
        Text = '  -  -    '
        OnChange = dtDateToChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
    object gbxSelectMonths: TsGroupBox
      Left = 143
      Top = 4
      Width = 142
      Height = 74
      Caption = '.. or select month'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object cbxMonth: TsComboBox
        Left = 10
        Top = 18
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
        Text = 'Select month ...'
        OnCloseUp = cbxMonthCloseUp
        Items.Strings = (
          'Select month ...'
          'January'
          'February'
          'March'
          'April'
          'May'
          'June'
          'July'
          'August'
          'September'
          'October'
          'November'
          'December')
      end
      object cbxYear: TsComboBox
        Left = 10
        Top = 43
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
        Text = 'Select year ...'
        OnCloseUp = cbxMonthCloseUp
        Items.Strings = (
          'Veldu '#225'r ...'
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
      Left = 8
      Top = 84
      Width = 100
      Height = 37
      Caption = 'Refresh ALL'
      Default = True
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 2
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object sGroupBox1: TsGroupBox
      Left = 354
      Top = 1
      Width = 810
      Height = 125
      Align = alRight
      TabOrder = 3
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      DesignSize = (
        810
        125)
      object btnsetUseStatusAsDefault: TsButton
        Left = 491
        Top = 85
        Width = 147
        Height = 33
        Anchors = [akTop, akRight]
        Caption = 'Set Default'
        Enabled = False
        TabOrder = 0
        OnClick = btnRefreshClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnGetUseStatusAsDefault: TsButton
        Left = 644
        Top = 85
        Width = 147
        Height = 33
        Anchors = [akTop, akRight]
        Caption = 'Get Default'
        Enabled = False
        TabOrder = 1
        SkinData.SkinSection = 'BUTTON'
      end
      object gbxUseStatusOfRooms: TsGroupBox
        Left = 3
        Top = 7
        Width = 382
        Height = 74
        Anchors = [akTop, akRight]
        Caption = 'Use Room with status of : '
        TabOrder = 2
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
          Left = 14
          Top = 51
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
          Left = 244
          Top = 34
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
          Left = 244
          Top = 17
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
        object chkExcludeWaitingListNonOptional: TsCheckBox
          Left = 134
          Top = 51
          Width = 77
          Height = 19
          Caption = 'Waitinglist'
          Checked = True
          State = cbChecked
          TabOrder = 7
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object gbxUseStatusNoRooms: TsGroupBox
        Left = 391
        Top = 7
        Width = 391
        Height = 74
        Anchors = [akTop, akRight]
        Caption = 'Use NO Rooms with status of : '
        TabOrder = 3
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object chkExcluteWaitingListNoRooms: TsCheckBox
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
        object chkExcluteAlotmentNoRooms: TsCheckBox
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
        object chkExcluteOrderNorooms: TsCheckBox
          Left = 14
          Top = 51
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
        object chkExcluteNoShowNoRooms: TsCheckBox
          Left = 246
          Top = 34
          Width = 69
          Height = 19
          Caption = 'No show'
          Checked = True
          State = cbChecked
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteDepartedNoRooms: TsCheckBox
          Left = 134
          Top = 17
          Width = 73
          Height = 19
          Caption = 'Departed'
          Checked = True
          State = cbChecked
          TabOrder = 4
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteBlockedNoRooms: TsCheckBox
          Left = 246
          Top = 17
          Width = 64
          Height = 19
          Caption = 'Blocked'
          TabOrder = 5
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteGuestNoRooms: TsCheckBox
          Left = 134
          Top = 34
          Width = 56
          Height = 19
          Caption = 'Guest'
          Checked = True
          State = cbChecked
          TabOrder = 6
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcludeWaitingListNonOptional_NoRooms: TsCheckBox
          Left = 134
          Top = 51
          Width = 77
          Height = 19
          Caption = 'Waitinglist'
          Checked = True
          State = cbChecked
          TabOrder = 7
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object chkStatistics: TsCheckBox
        Left = 17
        Top = 90
        Width = 251
        Height = 19
        Caption = 'Only use rooms marked to be used in Statistics'
        Checked = True
        State = cbChecked
        TabOrder = 4
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
  end
  object pageMain: TsPageControl
    Left = 0
    Top = 127
    Width = 1165
    Height = 662
    ActivePage = SheetMainResult
    Align = alClient
    TabOrder = 1
    SkinData.SkinSection = 'PAGECONTROL'
    object SheetMainResult: TsTabSheet
      Caption = 'Pivot Result'
      OnShow = SheetMainResultShow
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel1: TPanel
        Left = 240
        Top = 0
        Width = 917
        Height = 634
        Align = alClient
        TabOrder = 0
        object Panel5: TPanel
          Left = 1
          Top = 1
          Width = 915
          Height = 343
          Align = alTop
          TabOrder = 0
          object sPageControl2: TsPageControl
            Left = 1
            Top = 1
            Width = 913
            Height = 341
            ActivePage = sTabSheet2
            Align = alClient
            TabOrder = 0
            SkinData.SkinSection = 'PAGECONTROL'
            object sTabSheet2: TsTabSheet
              Caption = 'Result'
              SkinData.CustomColor = False
              SkinData.CustomFont = False
              object pg001: TcxDBPivotGrid
                Left = 0
                Top = 43
                Width = 905
                Height = 270
                Customization.AvailableFieldsSorted = True
                Customization.FormStyle = cfsAdvanced
                Align = alClient
                DataSource = kbmRoomsDataDS
                Groups = <>
                LookAndFeel.NativeStyle = False
                OptionsPrefilter.CustomizeButton = False
                OptionsPrefilter.MRUItemsList = False
                OptionsSelection.MultiSelect = True
                OptionsView.ColumnFields = False
                OptionsView.ColumnTotalsLocation = ctlNear
                OptionsView.DataFields = False
                OptionsView.FilterFields = False
                OptionsView.RowFields = False
                TabOrder = 0
                object pg001dtDate: TcxDBPivotGridField
                  Area = faRow
                  AreaIndex = 0
                  DataBinding.FieldName = 'dtDate'
                  GroupInterval = giDate
                  Visible = True
                  UniqueName = 'dtDate'
                end
                object pg001Week: TcxDBPivotGridField
                  AreaIndex = 0
                  IsCaptionAssigned = True
                  Caption = 'Week'
                  DataBinding.FieldName = 'dtDate'
                  GroupInterval = giDateWeekOfYear
                  Visible = True
                  UniqueName = 'Week'
                end
                object pg001Month: TcxDBPivotGridField
                  AreaIndex = 1
                  IsCaptionAssigned = True
                  Caption = 'Month'
                  DataBinding.FieldName = 'dtDate'
                  GroupInterval = giDateMonth
                  Visible = True
                  UniqueName = 'Month'
                end
                object pg001RoomType: TcxDBPivotGridField
                  Area = faColumn
                  AreaIndex = 0
                  DataBinding.FieldName = 'RoomType'
                  Visible = True
                  UniqueName = 'RoomType'
                end
                object pg001room: TcxDBPivotGridField
                  AreaIndex = 2
                  DataBinding.FieldName = 'room'
                  Visible = True
                  UniqueName = 'room'
                end
                object pg001TotalRooms: TcxDBPivotGridField
                  Area = faData
                  AreaIndex = 0
                  DataBinding.FieldName = 'TotalRooms'
                  Visible = True
                  Width = 70
                  UniqueName = 'TotalRooms'
                end
                object pg001occRooms: TcxDBPivotGridField
                  Area = faData
                  AreaIndex = 1
                  DataBinding.FieldName = 'occRooms'
                  Visible = True
                  Width = 61
                  UniqueName = 'occRooms'
                end
                object pg001OccPr: TcxDBPivotGridField
                  Area = faData
                  AreaIndex = 2
                  IsCaptionAssigned = True
                  Caption = 'Occ %'
                  SummaryType = stCustom
                  Visible = True
                  OnCalculateCustomSummary = pg001OccPrCalculateCustomSummary
                  UniqueName = 'Occ %'
                end
                object pg001NettoRooms: TcxDBPivotGridField
                  AreaIndex = 3
                  IsCaptionAssigned = True
                  Caption = 'Free Rooms'
                  DataBinding.FieldName = 'NettoRooms'
                  Visible = True
                  UniqueName = 'Free Rooms'
                end
                object pg001EmptyRooms: TcxDBPivotGridField
                  AreaIndex = 4
                  DataBinding.FieldName = 'EmptyRooms'
                  Visible = True
                  Width = 71
                  UniqueName = 'EmptyRooms'
                end
                object pg001NoRooms: TcxDBPivotGridField
                  AreaIndex = 5
                  DataBinding.FieldName = 'NoRooms'
                  Visible = True
                  UniqueName = 'NoRooms'
                end
                object pg001numGuests: TcxDBPivotGridField
                  AreaIndex = 6
                  DataBinding.FieldName = 'numGuests'
                  Visible = True
                  UniqueName = 'numGuests'
                end
                object pg001totalNumberOfGuests: TcxDBPivotGridField
                  AreaIndex = 7
                  DataBinding.FieldName = 'totalNumberOfGuests'
                  Visible = True
                  UniqueName = 'totalNumberOfGuests'
                end
                object pg001totalNumberOfBeds: TcxDBPivotGridField
                  AreaIndex = 8
                  DataBinding.FieldName = 'totalNumberOfBeds'
                  Visible = True
                  UniqueName = 'totalNumberOfBeds'
                end
                object pg001isNoRoom: TcxDBPivotGridField
                  AreaIndex = 13
                  DataBinding.ValueType = 'Boolean'
                  DataBinding.FieldName = 'isNoRoom'
                  Width = 67
                  UniqueName = 'isNoRoom'
                end
                object pg001GuestsCountry: TcxDBPivotGridField
                  AreaIndex = 11
                  DataBinding.FieldName = 'GuestsCountry'
                  UniqueName = 'GuestsCountry'
                end
                object pg001ResFlag: TcxDBPivotGridField
                  AreaIndex = 9
                  DataBinding.FieldName = 'ResFlag'
                  UniqueName = 'ResFlag'
                end
                object pg001Paid: TcxDBPivotGridField
                  AreaIndex = 10
                  DataBinding.FieldName = 'Paid'
                  UniqueName = 'Paid'
                end
                object pg001ChannelName: TcxDBPivotGridField
                  AreaIndex = 12
                  DataBinding.FieldName = 'ChannelName'
                  UniqueName = 'ChannelName'
                end
                object pg001Location: TcxDBPivotGridField
                  AreaIndex = 14
                  DataBinding.FieldName = 'Location'
                  Visible = True
                  UniqueName = 'Location'
                end
              end
              object sPanel7: TsPanel
                Left = 0
                Top = 0
                Width = 905
                Height = 43
                Align = alTop
                TabOrder = 1
                SkinData.SkinSection = 'PANEL'
                object labIsFiltered: TsLabel
                  AlignWithMargins = True
                  Left = 406
                  Top = 4
                  Width = 4
                  Height = 35
                  Align = alLeft
                  Caption = '-'
                  ParentFont = False
                  Layout = tlCenter
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ExplicitHeight = 13
                end
                object btnPivgrRequestsExcel: TsButton
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
                  OnClick = btnPivgrRequestsExcelClick
                  SkinData.SkinSection = 'BUTTON'
                end
                object btnpivgrRequestsPrint: TsButton
                  AlignWithMargins = True
                  Left = 138
                  Top = 4
                  Width = 128
                  Height = 35
                  Hint = 'Print'
                  Align = alLeft
                  Caption = 'Print Grid'
                  ImageIndex = 3
                  Images = DImages.PngImageList1
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 1
                  OnClick = btnpivgrRequestsPrintClick
                  SkinData.SkinSection = 'BUTTON'
                end
                object btnPivgrRequestsBestfit: TsButton
                  AlignWithMargins = True
                  Left = 272
                  Top = 4
                  Width = 128
                  Height = 35
                  Align = alLeft
                  Caption = 'Best Fit'
                  Images = DImages.PngImageList1
                  TabOrder = 2
                  OnClick = btnPivgrRequestsBestfitClick
                  SkinData.SkinSection = 'BUTTON'
                end
              end
            end
            object sTabSheet3: TsTabSheet
              Caption = 'Graph'
              SkinData.CustomColor = False
              SkinData.CustomFont = False
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object cxGrid: TcxGrid
                Left = 0
                Top = 0
                Width = 905
                Height = 313
                Align = alClient
                TabOrder = 0
                LookAndFeel.NativeStyle = False
                object cxGridDBTableView1: TcxGridDBTableView
                  Navigator.Buttons.CustomButtons = <>
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                end
                object cxGridChartView: TcxGridChartView
                  DiagramColumn.Active = True
                  ToolBox.CustomizeButton = True
                  ToolBox.DiagramSelector = True
                end
                object cxGridLevel: TcxGridLevel
                  GridView = cxGridChartView
                end
              end
            end
          end
        end
        object cxSplitter2: TcxSplitter
          Left = 1
          Top = 344
          Width = 915
          Height = 8
          HotZoneClassName = 'TcxMediaPlayer8Style'
          AlignSplitter = salTop
          Control = Panel5
        end
        object Panel6: TPanel
          Left = 1
          Top = 352
          Width = 915
          Height = 281
          Align = alClient
          ParentColor = True
          TabOrder = 2
          object grDrill: TcxGrid
            Left = 1
            Top = 44
            Width = 913
            Height = 236
            Align = alClient
            TabOrder = 0
            LookAndFeel.NativeStyle = False
            object tvDrill001: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = Dril001DS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.GroupByBox = False
            end
            object grDrillLevel1: TcxGridLevel
              GridView = tvDrill001
            end
          end
          object sPanel3: TsPanel
            Left = 1
            Top = 1
            Width = 913
            Height = 43
            Align = alTop
            TabOrder = 1
            SkinData.SkinSection = 'PANEL'
            object btnGrDrillExcel: TsButton
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
              OnClick = btnGrDrillExcelClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnGrdrillPrint: TsButton
              AlignWithMargins = True
              Left = 138
              Top = 4
              Width = 128
              Height = 35
              Hint = 'Print'
              Align = alLeft
              Caption = 'Print grid'
              ImageIndex = 3
              Images = DImages.PngImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              SkinData.SkinSection = 'BUTTON'
            end
            object btnGrDrillBestFit: TsButton
              AlignWithMargins = True
              Left = 272
              Top = 4
              Width = 128
              Height = 35
              Align = alLeft
              Caption = 'Best Fit'
              Images = DImages.PngImageList1
              TabOrder = 2
              SkinData.SkinSection = 'BUTTON'
            end
            object sButton2: TsButton
              AlignWithMargins = True
              Left = 406
              Top = 4
              Width = 128
              Height = 35
              Align = alLeft
              Caption = 'Format fields'
              Images = DImages.PngImageList1
              TabOrder = 3
              SkinData.SkinSection = 'BUTTON'
            end
            object sButton3: TsButton
              AlignWithMargins = True
              Left = 540
              Top = 4
              Width = 128
              Height = 35
              Align = alLeft
              Caption = 'Reservation'
              ImageIndex = 56
              Images = DImages.PngImageList1
              TabOrder = 4
              SkinData.SkinSection = 'BUTTON'
            end
          end
        end
      end
      object cxSplitter1: TcxSplitter
        Left = 232
        Top = 0
        Width = 8
        Height = 634
        HotZoneClassName = 'TcxMediaPlayer8Style'
        Control = sPanel2
      end
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 232
        Height = 634
        Align = alLeft
        TabOrder = 2
        SkinData.SkinSection = 'PANEL'
        object sPanel4: TsPanel
          Left = 1
          Top = 1
          Width = 230
          Height = 72
          Align = alTop
          Enabled = False
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
          DesignSize = (
            230
            72)
          object cbxSel: TsComboBox
            Left = 5
            Top = 7
            Width = 216
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Alignment = taLeftJustify
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
          end
          object btnLayoutShowMore: TsButton
            AlignWithMargins = True
            Left = 4
            Top = 33
            Width = 222
            Height = 35
            Align = alBottom
            Caption = 'show more ..'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            SkinData.SkinSection = 'BUTTON'
          end
        end
        object gbxCustomization: TsGroupBox
          Left = 1
          Top = 240
          Width = 230
          Height = 393
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
        end
        object panLayoutShowMore: TsPanel
          Left = 1
          Top = 73
          Width = 230
          Height = 167
          Align = alTop
          TabOrder = 2
          Visible = False
          SkinData.SkinSection = 'PANEL'
          DesignSize = (
            230
            167)
          object sLabel1: TsLabel
            Left = 5
            Top = 2
            Width = 34
            Height = 13
            Caption = 'Name :'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel3: TsLabel
            Left = 5
            Top = 45
            Width = 35
            Height = 13
            Caption = 'Notes :'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object btnSaveLayout: TsButton
            AlignWithMargins = True
            Left = 4
            Top = 128
            Width = 68
            Height = 35
            Margins.Top = 127
            Align = alLeft
            Caption = 'Create'
            TabOrder = 0
            SkinData.SkinSection = 'BUTTON'
          end
          object edLayoutName: TsEdit
            Left = 4
            Top = 21
            Width = 218
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TextHint = 'Set name for this data layout'
            SkinData.SkinSection = 'EDIT'
          end
          object cxButton2: TsButton
            AlignWithMargins = True
            Left = 78
            Top = 128
            Width = 68
            Height = 35
            Margins.Top = 127
            Align = alLeft
            Caption = 'Update'
            TabOrder = 2
            SkinData.SkinSection = 'BUTTON'
          end
          object cxButton1: TsButton
            AlignWithMargins = True
            Left = 152
            Top = 128
            Width = 69
            Height = 35
            Margins.Top = 127
            Align = alLeft
            Caption = 'Delete'
            TabOrder = 3
            SkinData.SkinSection = 'BUTTON'
          end
          object memLayoutNotes: TsMemo
            Left = 4
            Top = 60
            Width = 217
            Height = 62
            Anchors = [akLeft, akTop, akRight]
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            SkinData.SkinSection = 'EDIT'
          end
        end
      end
    end
    object sTabSheet4: TsTabSheet
      Caption = 'Data'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object sPanel6: TsPanel
        Left = 0
        Top = 0
        Width = 1157
        Height = 45
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnExcel: TsButton
          Left = 1
          Top = 2
          Width = 100
          Height = 37
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnReport: TsButton
          Left = 107
          Top = 2
          Width = 100
          Height = 37
          Caption = 'Report'
          ImageIndex = 69
          Images = DImages.PngImageList1
          TabOrder = 1
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grRoomsData: TcxGrid
        Left = 0
        Top = 45
        Width = 1157
        Height = 589
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvRoomsData: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = kbmRoomsDataDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Editing = False
          object tvRoomsDatadtDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'dtDate'
            Width = 70
          end
          object tvRoomsDataroom: TcxGridDBColumn
            DataBinding.FieldName = 'room'
          end
          object tvRoomsDataADate: TcxGridDBColumn
            DataBinding.FieldName = 'ADate'
            Visible = False
          end
          object tvRoomsDataRoomType: TcxGridDBColumn
            DataBinding.FieldName = 'RoomType'
          end
          object tvRoomsDataReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
          end
          object tvRoomsDataRoomreservation: TcxGridDBColumn
            DataBinding.FieldName = 'Roomreservation'
          end
          object tvRoomsDataResFlag: TcxGridDBColumn
            DataBinding.FieldName = 'ResFlag'
          end
          object tvRoomsDataisNoRoom: TcxGridDBColumn
            DataBinding.FieldName = 'isNoRoom'
            Width = 49
          end
          object tvRoomsDataNoRooms: TcxGridDBColumn
            DataBinding.FieldName = 'NoRooms'
          end
          object tvRoomsDataPaid: TcxGridDBColumn
            DataBinding.FieldName = 'Paid'
          end
          object tvRoomsDatagroupAccount: TcxGridDBColumn
            DataBinding.FieldName = 'groupAccount'
          end
          object tvRoomsDatanumGuests: TcxGridDBColumn
            DataBinding.FieldName = 'numGuests'
          end
          object tvRoomsDatanumChildren: TcxGridDBColumn
            DataBinding.FieldName = 'numChildren'
          end
          object tvRoomsDatanumInfants: TcxGridDBColumn
            DataBinding.FieldName = 'numInfants'
          end
          object tvRoomsDatatotalNumberOfBeds: TcxGridDBColumn
            DataBinding.FieldName = 'totalNumberOfBeds'
          end
          object tvRoomsDatatotalNumberOfGuests: TcxGridDBColumn
            DataBinding.FieldName = 'totalNumberOfGuests'
          end
          object tvRoomsDataGuestsCountry: TcxGridDBColumn
            DataBinding.FieldName = 'GuestsCountry'
          end
          object tvRoomsDatachannelID: TcxGridDBColumn
            DataBinding.FieldName = 'channelID'
          end
          object tvRoomsDataChannelName: TcxGridDBColumn
            DataBinding.FieldName = 'ChannelName'
          end
          object tvRoomsDatacustomer: TcxGridDBColumn
            DataBinding.FieldName = 'customer'
          end
          object tvRoomsDataCustName: TcxGridDBColumn
            DataBinding.FieldName = 'CustName'
            Width = 196
          end
          object tvRoomsDatastaff: TcxGridDBColumn
            DataBinding.FieldName = 'staff'
          end
          object tvRoomsDataMarket: TcxGridDBColumn
            DataBinding.FieldName = 'Market'
          end
          object tvRoomsDataMarketName: TcxGridDBColumn
            DataBinding.FieldName = 'MarketName'
            Width = 178
          end
          object tvRoomsDatanumRooms: TcxGridDBColumn
            DataBinding.FieldName = 'numRooms'
          end
          object tvRoomsDataStatistics: TcxGridDBColumn
            DataBinding.FieldName = 'Statistics'
          end
          object tvRoomsDataTotalRooms: TcxGridDBColumn
            DataBinding.FieldName = 'TotalRooms'
          end
          object tvRoomsDataEmptyRooms: TcxGridDBColumn
            DataBinding.FieldName = 'EmptyRooms'
          end
          object tvRoomsDataoccRooms: TcxGridDBColumn
            DataBinding.FieldName = 'occRooms'
          end
          object tvRoomsDataLocation: TcxGridDBColumn
            DataBinding.FieldName = 'Location'
          end
        end
        object lvRoomsData: TcxGridLevel
          GridView = tvRoomsData
        end
      end
    end
  end
  object Dril001: TcxPivotGridDrillDownDataSet
    PivotGrid = pg001
    SynchronizeData = True
    OnDataChanged = Dril001DataChanged
    Left = 544
    Top = 368
  end
  object Dril001DS: TDataSource
    DataSet = Dril001
    Left = 488
    Top = 368
  end
  object pgGraph001: TcxPivotGridChartConnection
    GridChartView = cxGridChartView
    PivotGrid = pg001
    Left = 792
    Top = 288
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLinkGrDrill
    Version = 0
    Left = 940
    Top = 256
    object prLinkPg001: TcxPivotGridReportLink
      Component = pg001
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      BuiltInReportLink = True
    end
    object prLinkGrDrill: TdxGridReportLink
      Component = grDrill
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      BuiltInReportLink = True
    end
  end
  object store1: TcxPropertiesStore
    Components = <>
    StorageName = 'storeMain'
    StorageType = stStream
    Left = 704
    Top = 248
  end
  object kbmRoomsData_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'dtDate'
        DataType = ftDateTime
      end
      item
        Name = 'ADate'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'room'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'RoomType'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'Roomreservation'
        DataType = ftInteger
      end
      item
        Name = 'ResFlag'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'isNoRoom'
        DataType = ftBoolean
      end
      item
        Name = 'Paid'
        DataType = ftBoolean
      end
      item
        Name = 'groupAccount'
        DataType = ftBoolean
      end
      item
        Name = 'numGuests'
        DataType = ftInteger
      end
      item
        Name = 'numChildren'
        DataType = ftInteger
      end
      item
        Name = 'numInfants'
        DataType = ftInteger
      end
      item
        Name = 'occRooms'
        DataType = ftInteger
      end
      item
        Name = 'totalNumberOfBeds'
        DataType = ftInteger
      end
      item
        Name = 'totalNumberOfGuests'
        DataType = ftInteger
      end
      item
        Name = 'GuestsCountry'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'channelID'
        DataType = ftInteger
      end
      item
        Name = 'ChannelName'
        DataType = ftString
        Size = 35
      end
      item
        Name = 'customer'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'CustName'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'staff'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Market'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'MarketName'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Statistics'
        DataType = ftBoolean
      end
      item
        Name = 'TotalRooms'
        DataType = ftInteger
      end
      item
        Name = 'EmptyRooms'
        DataType = ftInteger
      end
      item
        Name = 'NoRooms'
        DataType = ftInteger
      end
      item
        Name = 'NettoRooms'
        DataType = ftInteger
      end
      item
        Name = 'Location'
        DataType = ftString
        Size = 20
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
    BeforePost = kbmRoomsData_BeforePost
    Left = 336
    Top = 344
  end
  object kbmRoomsDataDS: TDataSource
    DataSet = kbmRoomsData_
    Left = 336
    Top = 400
  end
  object mHead: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 356
    Top = 273
    object mHeadCompany: TStringField
      FieldName = 'Company'
      Size = 50
    end
    object mHeadStaff: TStringField
      FieldName = 'Staff'
      Size = 50
    end
    object mHeadDateFrom: TDateField
      FieldName = 'DateFrom'
    end
    object mHeadDateTo: TDateField
      FieldName = 'DateTo'
    end
    object mHeadDateCount: TIntegerField
      FieldName = 'DateCount'
    end
    object mHeadSaleAmount: TFloatField
      FieldName = 'SaleAmount'
    end
    object mHeadSaleAmountWoVAT: TFloatField
      FieldName = 'SaleAmountWoVAT'
    end
    object mHeadVATAmount: TFloatField
      FieldName = 'VATAmount'
    end
    object mHeadInvoiceCount: TIntegerField
      FieldName = 'InvoiceCount'
    end
    object mHeadSalePerDay: TFloatField
      FieldName = 'SalePerDay'
    end
    object mHeadSalePerInvoice: TFloatField
      FieldName = 'SalePerInvoice'
    end
    object mHeadPaymentAmount: TFloatField
      FieldName = 'PaymentAmount'
    end
    object mHeadPaymentCount: TFloatField
      FieldName = 'PaymentCount'
    end
    object mHeadLodgingNights: TIntegerField
      FieldName = 'LodgingNights'
    end
    object mHeadLodgingTax: TFloatField
      FieldName = 'LodgingTax'
    end
    object mHeadRoomInvoiceCount: TIntegerField
      FieldName = 'RoomInvoiceCount'
    end
    object mHeadGroupInvoiceCount: TIntegerField
      FieldName = 'GroupInvoiceCount'
    end
    object mHeadKeditInvoiceCount: TIntegerField
      FieldName = 'KeditInvoiceCount'
    end
    object mHeadCashInvoiceCount: TIntegerField
      FieldName = 'CashInvoiceCount'
    end
  end
  object mHeadDS: TDataSource
    DataSet = mHead
    Left = 404
    Top = 273
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
    StorageName = 'Software\Roomer\FormStatus\frmRptResStatsRooms'
    StorageType = stRegistry
    Left = 114
    Top = 262
  end
end
