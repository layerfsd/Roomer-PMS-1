object frmNationalReport3: TfrmNationalReport3
  Left = 788
  Top = 319
  Caption = 'National Lodging Report'
  ClientHeight = 616
  ClientWidth = 1079
  Color = clBtnFace
  Constraints.MinWidth = 920
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel5: TBevel
    Left = 785
    Top = 7
    Width = 17
    Height = 87
    Shape = bsRightLine
  end
  object pageMain: TsPageControl
    Left = 0
    Top = 117
    Width = 1079
    Height = 479
    ActivePage = sheetNationalStatistics1
    Align = alClient
    Style = tsButtons
    TabHeight = 25
    TabOrder = 0
    TabWidth = 150
    SkinData.SkinSection = 'PAGECONTROL'
    object sheetNationalStatistics1: TsTabSheet
      Caption = 'Room Nights'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TsPanel
        Left = 0
        Top = 0
        Width = 1071
        Height = 49
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnNationalStatisticsExcel: TsButton
          Left = 3
          Top = 6
          Width = 100
          Height = 37
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnNationalStatisticsExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnNationalStatisticsReport: TsButton
          Left = 109
          Top = 6
          Width = 127
          Height = 37
          Caption = 'Report'
          ImageIndex = 69
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnNationalStatisticsReportClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grNationalStatistics1: TcxGrid
        Left = 0
        Top = 49
        Width = 1071
        Height = 395
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvNationalStatistics1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          Navigator.Visible = True
          DataController.DataSource = mHagstofaDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'Nights'
              Column = tvNationalStatistics1Nights
            end
            item
              Kind = skSum
              FieldName = 'Guests'
              Column = tvNationalStatistics1Guests
            end
            item
              Kind = skCount
              FieldName = 'CountryGroup'
              Column = tvNationalStatistics1CountryGroup
            end
            item
              Kind = skSum
              FieldName = 'ReservationCount'
              Column = tvNationalStatistics1ReservationCount
            end
            item
              Kind = skSum
              FieldName = 'RoomReservationCount'
              Column = tvNationalStatistics1RoomReservationCount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.Indicator = True
          object tvNationalStatistics1RecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvHagstofa1Country: TcxGridDBColumn
            DataBinding.FieldName = 'Country'
            Visible = False
            Width = 32
          end
          object tvHagstofa1CountryName: TcxGridDBColumn
            DataBinding.FieldName = 'CountryName'
            Width = 169
          end
          object tvNationalStatistics1CountryGroup: TcxGridDBColumn
            DataBinding.FieldName = 'CountryGroup'
            Visible = False
            Width = 61
          end
          object tvNationalStatistics1GroupName: TcxGridDBColumn
            DataBinding.FieldName = 'GroupName'
            Width = 138
          end
          object tvNationalStatistics1Nights: TcxGridDBColumn
            DataBinding.FieldName = 'Nights'
          end
          object tvNationalStatistics1Precent: TcxGridDBColumn
            Caption = '%'
            DataBinding.FieldName = 'Precent'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '0.00 %'
            Options.Editing = False
          end
          object tvNationalStatistics1Guests: TcxGridDBColumn
            DataBinding.FieldName = 'Guests'
          end
          object tvNationalStatistics1PrecentGuests: TcxGridDBColumn
            Caption = '%'
            DataBinding.FieldName = 'PrecentGuests'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '0.00 %'
          end
          object tvNationalStatistics1orderIndex: TcxGridDBColumn
            DataBinding.FieldName = 'orderIndex'
            Visible = False
          end
          object tvNationalStatistics1ReservationCount: TcxGridDBColumn
            Caption = 'Reservations'
            DataBinding.FieldName = 'ReservationCount'
          end
          object tvNationalStatistics1RoomReservationCount: TcxGridDBColumn
            Caption = 'Rooms'
            DataBinding.FieldName = 'RoomReservationCount'
          end
        end
        object levNationalStatistics1: TcxGridLevel
          GridView = tvNationalStatistics1
        end
      end
    end
    object cxTabSheet1: TsTabSheet
      Caption = 'Guests'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel5: TsPanel
        Left = 0
        Top = 0
        Width = 1071
        Height = 33
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          1071
          33)
        object btnGuestsExcel: TsButton
          Left = 4
          Top = 3
          Width = 100
          Height = 25
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnGuestsExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object brnGuestsReservation: TsButton
          Left = 106
          Top = 3
          Width = 100
          Height = 25
          Caption = 'Reservaton'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = brnGuestsReservationClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnExpandAll: TsButton
          Left = 864
          Top = 2
          Width = 100
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Expand All'
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = btnExpandAllClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnCollapseAll: TsButton
          Left = 967
          Top = 2
          Width = 100
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Collapse All'
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = btnCollapseAllClick
          SkinData.SkinSection = 'BUTTON'
        end
        object cxButton1: TsButton
          Left = 207
          Top = 3
          Width = 125
          Height = 25
          Caption = 'Change Country'
          ImageIndex = 100
          Images = DImages.PngImageList1
          TabOrder = 4
          OnClick = cxButton1Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grAllGuests: TcxGrid
        Left = 0
        Top = 33
        Width = 1071
        Height = 411
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvAllGuests: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mAllGuests2DS
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skCount
              FieldName = 'Room'
              Column = tvAllGuestsRoom
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              FieldName = 'ResInfo'
              Column = tvAllGuestsResInfo
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object tvAllGuestsRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvAllGuestsRoomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'RoomReservation'
            Visible = False
          end
          object tvAllGuestsReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
            Visible = False
          end
          object tvAllGuestsReservationsName: TcxGridDBColumn
            DataBinding.FieldName = 'ReservationsName'
            Visible = False
            Width = 151
          end
          object tvAllGuestsReservationCountry: TcxGridDBColumn
            DataBinding.FieldName = 'ReservationCountry'
            Visible = False
          end
          object tvAllGuestsRoom: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
          end
          object tvAllGuestsRoomType: TcxGridDBColumn
            DataBinding.FieldName = 'RoomType'
          end
          object tvAllGuestsGuestName: TcxGridDBColumn
            DataBinding.FieldName = 'GuestName'
            Width = 139
          end
          object tvAllGuestsGuestsCountry: TcxGridDBColumn
            DataBinding.FieldName = 'GuestsCountry'
            Width = 27
          end
          object tvAllGuestsGuestCountryName: TcxGridDBColumn
            DataBinding.FieldName = 'GuestCountryName'
            Width = 140
          end
          object tvAllGuestsGuestGroupName: TcxGridDBColumn
            DataBinding.FieldName = 'GuestGroupName'
            Width = 130
          end
          object tvAllGuestsPerson: TcxGridDBColumn
            DataBinding.FieldName = 'Person'
            Visible = False
          end
          object tvAllGuestsArrival: TcxGridDBColumn
            DataBinding.FieldName = 'Arrival'
            Width = 84
          end
          object tvAllGuestsDeparture: TcxGridDBColumn
            DataBinding.FieldName = 'Departure'
            Width = 85
          end
          object tvAllGuestsResInfo: TcxGridDBColumn
            Caption = 'Res'
            DataBinding.FieldName = 'ResInfo'
            PropertiesClassName = 'TcxLabelProperties'
            Visible = False
            GroupIndex = 0
            MinWidth = 200
            Options.Editing = False
            Options.Filtering = False
            Options.FilteringFilteredItemsList = False
            Options.FilteringMRUItemsList = False
            Options.FilteringPopup = False
            Options.FilteringPopupMultiSelect = False
            Options.Focusing = False
            Options.IgnoreTimeForFiltering = False
            Options.IncSearch = False
            Options.ShowEditButtons = isebNever
            Options.GroupFooters = False
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Moving = False
            Options.ShowCaption = False
            Options.SortByDisplayText = isbtOff
            Options.Sorting = False
            Width = 200
          end
          object tvAllGuestsGroupAccount: TcxGridDBColumn
            DataBinding.FieldName = 'GroupAccount'
          end
          object tvAllGuestsStatus: TcxGridDBColumn
            DataBinding.FieldName = 'Status'
          end
          object tvAllGuestsNoRoom: TcxGridDBColumn
            DataBinding.FieldName = 'NoRoom'
          end
        end
        object lvAllGuests: TcxGridLevel
          GridView = tvAllGuests
        end
      end
    end
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 596
    Width = 1079
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 1079
    Height = 117
    Align = alTop
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object labLocations: TsLabel
      AlignWithMargins = True
      Left = 112
      Top = 80
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Locations :'
    end
    object labLocationsList: TsLabel
      Left = 170
      Top = 80
      Width = 11
      Height = 13
      Caption = 'All'
    end
    object cxGroupBox1: TsGroupBox
      Left = 10
      Top = 3
      Width = 148
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
      object dtDateFrom: TsDateEdit
        Left = 16
        Top = 17
        Width = 121
        Height = 21
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BevelKind = bkFlat
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
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
        Top = 42
        Width = 121
        Height = 21
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BevelKind = bkFlat
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
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
    object cxGroupBox2: TsGroupBox
      Left = 165
      Top = 3
      Width = 151
      Height = 76
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
        Left = 15
        Top = 16
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
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 0
        Text = 'Choose a Month ...'
        OnCloseUp = cbxMonthPropertiesCloseUp
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
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 1
        Text = 'Choose a year ...'
        OnCloseUp = cbxMonthPropertiesCloseUp
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
      Left = 322
      Top = 10
      Width = 122
      Height = 37
      Caption = 'Refresh'
      Default = True
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 2
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object Panel4: TsPanel
      Left = 451
      Top = 1
      Width = 627
      Height = 115
      Align = alRight
      Anchors = [akTop, akRight]
      TabOrder = 3
      SkinData.SkinSection = 'PANEL'
      object Panel8: TsPanel
        Left = 1
        Top = 1
        Width = 625
        Height = 113
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Anchors = [akTop, akRight]
        BevelInner = bvLowered
        BevelOuter = bvNone
        Color = clMoneyGreen
        ParentBackground = False
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object Bevel2: TBevel
          Left = 231
          Top = 6
          Width = 10
          Height = 87
          Shape = bsRightLine
        end
        object Bevel3: TBevel
          Left = 8
          Top = 15
          Width = 612
          Height = 2
          Shape = bsTopLine
        end
        object Bevel4: TBevel
          Left = 412
          Top = 6
          Width = 5
          Height = 87
          Shape = bsRightLine
        end
        object labcReservations: TsLabel
          Left = 99
          Top = 23
          Width = 70
          Height = 13
          Alignment = taRightJustify
          Caption = 'Reservations :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labcRoomReservations: TsLabel
          Left = 72
          Top = 37
          Width = 97
          Height = 13
          Alignment = taRightJustify
          Caption = 'Room reservations :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labReservations: TsLabel
          Left = 170
          Top = 19
          Width = 54
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          Color = clMoneyGreen
          ParentColor = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labRoomreservations: TsLabel
          Left = 170
          Top = 37
          Width = 54
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          Color = clMoneyGreen
          ParentColor = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cxLabel1: TsLabel
          Left = 129
          Top = 54
          Width = 40
          Height = 13
          Alignment = taRightJustify
          Caption = 'Guests :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labGuestNights: TsLabel
          Left = 170
          Top = 54
          Width = 54
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          Color = clMoneyGreen
          ParentColor = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cxLabel2: TsLabel
          Left = 132
          Top = 72
          Width = 37
          Height = 13
          Alignment = taRightJustify
          Caption = 'Nights :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labNights: TsLabel
          Left = 170
          Top = 72
          Width = 54
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          Color = clMoneyGreen
          ParentColor = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cxLabel4: TsLabel
          Left = 9
          Top = 0
          Width = 231
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Stat'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cxLabel5: TsLabel
          Left = 241
          Top = 0
          Width = 175
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Hotel available'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cxLabel10: TsLabel
          Left = 321
          Top = 54
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Days :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labDays: TsLabel
          Left = 353
          Top = 54
          Width = 50
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          Color = clMoneyGreen
          ParentColor = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cxLabel8: TsLabel
          Left = 322
          Top = 37
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'Beds :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cxLabel6: TsLabel
          Left = 313
          Top = 19
          Width = 39
          Height = 13
          Alignment = taRightJustify
          Caption = 'Rooms :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labRooms: TsLabel
          Left = 353
          Top = 19
          Width = 50
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          Color = clMoneyGreen
          ParentColor = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labBeds: TsLabel
          Left = 353
          Top = 37
          Width = 50
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          Color = clMoneyGreen
          ParentColor = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel1: TsLabel
          Left = 492
          Top = 24
          Width = 41
          Height = 13
          Alignment = taRightJustify
          Caption = 'Private :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel2: TsLabel
          Left = 470
          Top = 46
          Width = 63
          Height = 13
          Alignment = taRightJustify
          Caption = 'Conferance :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel3: TsLabel
          Left = 485
          Top = 69
          Width = 48
          Height = 13
          Alignment = taRightJustify
          Caption = 'Business :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel4: TsLabel
          Left = 416
          Top = 1
          Width = 205
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Type of visit'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object LabTotalVisitType: TsLabel
          Left = 540
          Top = 92
          Width = 48
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          Color = clMoneyGreen
          ParentColor = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel6: TsLabel
          Left = 502
          Top = 92
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Total :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edPrivate: TsSpinEdit
          Left = 535
          Top = 21
          Width = 63
          Height = 21
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = edPrivateChange
          SkinData.SkinSection = 'EDIT'
          MaxValue = 0
          MinValue = 0
          Value = 0
        end
        object edConfress: TsSpinEdit
          Left = 535
          Top = 43
          Width = 63
          Height = 21
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = edPrivateChange
          SkinData.SkinSection = 'EDIT'
          MaxValue = 0
          MinValue = 0
          Value = 0
        end
        object edBuisiness: TsSpinEdit
          Left = 535
          Top = 65
          Width = 63
          Height = 21
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = edPrivateChange
          SkinData.SkinSection = 'EDIT'
          MaxValue = 0
          MinValue = 0
          Value = 0
        end
      end
    end
  end
  object mHagstofa1: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 368
    Top = 432
    object mHagstofa1Country: TWideStringField
      FieldName = 'Country'
      Size = 2
    end
    object mHagstofa1CountryName: TWideStringField
      FieldName = 'CountryName'
      Size = 30
    end
    object mHagstofa1Nights: TIntegerField
      FieldName = 'Nights'
    end
    object mHagstofa1CountryGroup: TWideStringField
      FieldName = 'CountryGroup'
      Size = 5
    end
    object mHagstofa1GroupName: TWideStringField
      FieldName = 'GroupName'
      Size = 30
    end
    object mHagstofa1Precent: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Precent'
      Calculated = True
    end
    object mHagstofa1Guests: TIntegerField
      FieldName = 'Guests'
    end
    object mHagstofa1PrecentGuests: TFloatField
      FieldKind = fkCalculated
      FieldName = 'PrecentGuests'
      Calculated = True
    end
    object mHagstofa1orderIndex: TIntegerField
      FieldName = 'orderIndex'
    end
    object mHagstofa1ReservationCount: TIntegerField
      FieldName = 'ReservationCount'
    end
    object mHagstofa1RoomReservationCount: TIntegerField
      FieldName = 'RoomReservationCount'
    end
  end
  object mHagstofaDS: TDataSource
    DataSet = mHagstofa1
    Left = 536
    Top = 368
  end
  object mNationalStatistics: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 232
    Top = 304
    object WideStringField1: TWideStringField
      FieldName = 'Country'
      Size = 2
    end
    object WideStringField2: TWideStringField
      FieldName = 'CountryName'
      Size = 30
    end
    object IntegerField1: TIntegerField
      FieldName = 'Nights'
    end
    object WideStringField3: TWideStringField
      FieldName = 'CountryGroup'
      Size = 5
    end
    object WideStringField4: TWideStringField
      FieldName = 'GroupName'
      Size = 30
    end
    object FloatField1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Precent'
      Calculated = True
    end
    object IntegerField2: TIntegerField
      FieldName = 'Guests'
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 424
    Top = 200
    object mnuThisRoom: TMenuItem
      Caption = 'Closed this Room'
    end
    object MenuItem1: TMenuItem
      Caption = 'Closed this reservation'
    end
    object OpenthisRoom1: TMenuItem
      Caption = 'Open this Room'
    end
    object MenuItem2: TMenuItem
      Caption = 'Open Group Invoice'
    end
  end
  object mAllGuests: TdxMemData
    Indexes = <
      item
        FieldName = 'Reservation'
        SortOptions = []
      end>
    SortOptions = []
    Left = 208
    Top = 456
    object mAllGuestsReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mAllGuestsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mAllGuestsGuestName: TWideStringField
      FieldName = 'GuestName'
      Size = 100
    end
    object mAllGuestsPerson: TIntegerField
      FieldName = 'Person'
    end
    object mAllGuestsStatus: TWideStringField
      FieldName = 'Status'
      Size = 5
    end
    object mAllGuestsGroupAccount: TBooleanField
      FieldName = 'GroupAccount'
    end
    object mAllGuestsArrival: TDateTimeField
      FieldName = 'Arrival'
    end
    object mAllGuestsDeparture: TDateTimeField
      FieldName = 'Departure'
    end
    object mAllGuestsNoRoom: TBooleanField
      FieldName = 'NoRoom'
    end
    object mAllGuestsReservationCountry: TWideStringField
      FieldName = 'ReservationCountry'
      Size = 2
    end
    object mAllGuestsGuestsCountry: TWideStringField
      FieldName = 'GuestsCountry'
      Size = 2
    end
    object mAllGuestsGuestCountryName: TWideStringField
      FieldName = 'GuestCountryName'
      Size = 50
    end
    object mAllGuestsGuestGroupName: TWideStringField
      FieldName = 'GuestGroupName'
      Size = 50
    end
    object mAllGuestsReservationsName: TWideStringField
      FieldName = 'ReservationsName'
      Size = 100
    end
    object mAllGuestsResInfo: TStringField
      FieldName = 'ResInfo'
      Size = 120
    end
    object mAllGuestsRoom: TWideStringField
      FieldName = 'Room'
      Size = 10
    end
    object mAllGuestsRoomType: TWideStringField
      FieldName = 'RoomType'
      Size = 10
    end
  end
  object mAllGuests2DS: TDataSource
    DataSet = mAllGuests
    Left = 278
    Top = 456
  end
  object m: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'CountryGroup'
        DataType = ftWideString
        Size = 5
      end
      item
        Name = 'GroupName'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'OrderIndex'
        DataType = ftInteger
      end
      item
        Name = 'Guests'
        DataType = ftInteger
      end
      item
        Name = 'Nights'
        DataType = ftInteger
      end
      item
        Name = 'Country'
        DataType = ftWideString
        Size = 5
      end
      item
        Name = 'CountryName'
        DataType = ftWideString
        Size = 50
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
    Left = 40
    Top = 353
  end
  object rptbHagstofa: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
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
    Left = 40
    Top = 283
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand1: TppHeaderBand
      BeforePrint = ppHeaderBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 29633
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Guest nationality'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        mmHeight = 4763
        mmLeft = 2646
        mmTop = 24871
        mmWidth = 29104
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'Guest arrivals'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4868
        mmLeft = 79713
        mmTop = 24871
        mmWidth = 26120
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        Caption = 'nights'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4868
        mmLeft = 117814
        mmTop = 24871
        mmWidth = 11303
        BandType = 0
        LayerName = Foreground
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Weight = 0.750000000000000000
        mmHeight = 1588
        mmLeft = 1323
        mmTop = 29369
        mmWidth = 129911
        BandType = 0
        LayerName = Foreground
      end
      object ppLine7: TppLine
        UserName = 'Line7'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 5292
        mmLeft = 63500
        mmTop = 24077
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground
      end
      object ppLine8: TppLine
        UserName = 'Line8'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 5292
        mmLeft = 794
        mmTop = 24077
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground
      end
      object ppLine9: TppLine
        UserName = 'Line9'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 5292
        mmLeft = 130969
        mmTop = 24077
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'overnights Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 7408
        mmLeft = 2646
        mmTop = 529
        mmWidth = 51065
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
        UserName = 'rLabFrom1'
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
        mmHeight = 3810
        mmLeft = 180182
        mmTop = 529
        mmWidth = 15579
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
        mmHeight = 3810
        mmLeft = 192882
        mmTop = 4763
        mmWidth = 2836
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
        mmHeight = 3810
        mmLeft = 170657
        mmTop = 9525
        mmWidth = 25019
        BandType = 0
        LayerName = Foreground
      end
      object ppLine11: TppLine
        UserName = 'Line11'
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 0
        mmTop = 14288
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground
      end
      object ppLine12: TppLine
        UserName = 'Line12'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 5556
        mmLeft = 107686
        mmTop = 24342
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 7144
      mmPrintPosition = 0
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'CountryName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4763
        mmLeft = 2646
        mmTop = 794
        mmWidth = 60061
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'Guests'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4868
        mmLeft = 86519
        mmTop = 794
        mmWidth = 19315
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'Nights'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4763
        mmLeft = 110861
        mmTop = 794
        mmWidth = 18256
        BandType = 4
        LayerName = Foreground
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        Weight = 0.750000000000000000
        mmHeight = 794
        mmLeft = 1323
        mmTop = 6879
        mmWidth = 129911
        BandType = 4
        LayerName = Foreground
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        ParentHeight = True
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 7144
        mmLeft = 63500
        mmTop = 0
        mmWidth = 2910
        BandType = 4
        LayerName = Foreground
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        ParentHeight = True
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 7144
        mmLeft = 107686
        mmTop = 0
        mmWidth = 2910
        BandType = 4
        LayerName = Foreground
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        ParentHeight = True
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 7144
        mmLeft = 130969
        mmTop = 0
        mmWidth = 2910
        BandType = 4
        LayerName = Foreground
      end
      object ppLine6: TppLine
        UserName = 'Line6'
        ParentHeight = True
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 7144
        mmLeft = 794
        mmTop = 0
        mmWidth = 2910
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
    end
    object ppSummaryBand1: TppSummaryBand
      BeforePrint = ppSummaryBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 70644
      mmPrintPosition = 0
      object ppShape1: TppShape
        UserName = 'Shape1'
        mmHeight = 29104
        mmLeft = 92340
        mmTop = 3704
        mmWidth = 99484
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Guest arrival :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 1323
        mmTop = 4763
        mmWidth = 65881
        BandType = 7
        LayerName = Foreground
      end
      object labGuestCount: TppLabel
        UserName = 'labGuestCount'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4868
        mmLeft = 67998
        mmTop = 4763
        mmWidth = 17198
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Caption = 'nights'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 1323
        mmTop = 10583
        mmWidth = 65881
        BandType = 7
        LayerName = Foreground
      end
      object labNightCount: TppLabel
        UserName = 'labNightCount'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4868
        mmLeft = 67998
        mmTop = 10583
        mmWidth = 17198
        BandType = 7
        LayerName = Foreground
      end
      object labReservationCount: TppLabel
        UserName = 'labGuestCount1'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4868
        mmLeft = 67998
        mmTop = 21960
        mmWidth = 17198
        BandType = 7
        LayerName = Foreground
      end
      object labRoomReservationCount: TppLabel
        UserName = 'labNightCount1'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4868
        mmLeft = 67998
        mmTop = 27781
        mmWidth = 17198
        BandType = 7
        LayerName = Foreground
      end
      object labRoomCount: TppLabel
        UserName = 'labGuestCount2'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 67998
        mmTop = 39688
        mmWidth = 17463
        BandType = 7
        LayerName = Foreground
      end
      object labBedCount: TppLabel
        UserName = 'labNightCount2'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 124619
        mmTop = 39688
        mmWidth = 17198
        BandType = 7
        LayerName = Foreground
      end
      object labDayCount: TppLabel
        UserName = 'labDayCount'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 67998
        mmTop = 45773
        mmWidth = 17463
        BandType = 7
        LayerName = Foreground
      end
      object labReservationsCaption: TppLabel
        UserName = 'labReservationsCaption'
        AutoSize = False
        Caption = 'Bookings :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 1323
        mmTop = 21960
        mmWidth = 65881
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel10: TppLabel
        UserName = 'labReservationsCaption1'
        AutoSize = False
        Caption = 'Rented rooms :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 1323
        mmTop = 27781
        mmWidth = 65881
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        AutoSize = False
        Caption = 'Available Rooms:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 1323
        mmTop = 39688
        mmWidth = 65881
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel12: TppLabel
        UserName = 'Label10'
        Caption = 'Room with '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 97896
        mmTop = 39688
        mmWidth = 25135
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel13: TppLabel
        UserName = 'Label101'
        Caption = 'beds'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 144992
        mmTop = 39688
        mmWidth = 14817
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel14: TppLabel
        UserName = 'Label14'
        AutoSize = False
        Caption = 'Days on Report:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 1323
        mmTop = 45773
        mmWidth = 65881
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel15: TppLabel
        UserName = 'Label15'
        AutoSize = False
        Caption = 'Total Availability :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 1323
        mmTop = 51594
        mmWidth = 65881
        BandType = 7
        LayerName = Foreground
      end
      object labTotalRoomCount: TppLabel
        UserName = 'labTotalRoomCount'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 67998
        mmTop = 51594
        mmWidth = 17463
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel17: TppLabel
        UserName = 'Label102'
        Caption = 'Room with'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 97896
        mmTop = 51594
        mmWidth = 25135
        BandType = 7
        LayerName = Foreground
      end
      object labTotalBedCount: TppLabel
        UserName = 'labTotalBedCount'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 124619
        mmTop = 51594
        mmWidth = 17198
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel19: TppLabel
        UserName = 'Label19'
        Caption = 'beds'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 144992
        mmTop = 51594
        mmWidth = 14817
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel16: TppLabel
        UserName = 'Label12'
        Caption = 
          '*2 - Number of beds in room are calculated from the given room t' +
          'ype'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 794
        mmTop = 67204
        mmWidth = 86360
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel18: TppLabel
        UserName = 'Label18'
        Caption = '*1 - Booked nights belong to the month of departure'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3260
        mmLeft = 794
        mmTop = 62971
        mmWidth = 65151
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel20: TppLabel
        UserName = 'Label13'
        Caption = '*1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 87577
        mmTop = 11113
        mmWidth = 2646
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel21: TppLabel
        UserName = 'Label21'
        Caption = '*1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 162454
        mmTop = 40481
        mmWidth = 2646
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel22: TppLabel
        UserName = 'Label22'
        AutoSize = False
        Caption = 'Personal Requests :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 93134
        mmTop = 10054
        mmWidth = 76994
        BandType = 7
        LayerName = Foreground
      end
      object rlabPrivate: TppLabel
        UserName = 'labGuestCount3'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 170392
        mmTop = 10054
        mmWidth = 17198
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel24: TppLabel
        UserName = 'Label24'
        AutoSize = False
        Caption = 'conference :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 93134
        mmTop = 15875
        mmWidth = 76994
        BandType = 7
        LayerName = Foreground
      end
      object rLabConfress: TppLabel
        UserName = 'rLabConfress'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 170392
        mmTop = 15875
        mmWidth = 17198
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel26: TppLabel
        UserName = 'Label26'
        AutoSize = False
        Caption = 'Customer request :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 93134
        mmTop = 21696
        mmWidth = 76994
        BandType = 7
        LayerName = Foreground
      end
      object rLabBusiness: TppLabel
        UserName = 'rLabBussines'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 170392
        mmTop = 21696
        mmWidth = 17198
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel23: TppLabel
        UserName = 'Label23'
        AutoSize = False
        Caption = 'Purpose of visit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        mmHeight = 5027
        mmLeft = 94192
        mmTop = 1323
        mmWidth = 32015
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
  object ppDBPipeline1: TppDBPipeline
    DataSource = mDS
    UserName = 'DBPipeline1'
    Left = 120
    Top = 283
    object ppDBPipeline1ppField1: TppField
      FieldAlias = 'CountryGroup'
      FieldName = 'CountryGroup'
      FieldLength = 5
      DisplayWidth = 5
      Position = 0
    end
    object ppDBPipeline1ppField2: TppField
      FieldAlias = 'GroupName'
      FieldName = 'GroupName'
      FieldLength = 50
      DisplayWidth = 50
      Position = 1
    end
    object ppDBPipeline1ppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'OrderIndex'
      FieldName = 'OrderIndex'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 2
    end
    object ppDBPipeline1ppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'Guests'
      FieldName = 'Guests'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 3
    end
    object ppDBPipeline1ppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'Nights'
      FieldName = 'Nights'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 4
    end
    object ppDBPipeline1ppField6: TppField
      FieldAlias = 'Country'
      FieldName = 'Country'
      FieldLength = 5
      DisplayWidth = 5
      Position = 5
    end
    object ppDBPipeline1ppField7: TppField
      FieldAlias = 'CountryName'
      FieldName = 'CountryName'
      FieldLength = 50
      DisplayWidth = 50
      Position = 6
    end
  end
  object mDS: TDataSource
    DataSet = m
    Left = 120
    Top = 347
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
    StorageName = 'Software\Roomer\FormStatus\NationalReport'
    StorageType = stRegistry
    Left = 310
    Top = 312
  end
end
