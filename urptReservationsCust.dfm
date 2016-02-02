object frmRptReservationsCust: TfrmRptReservationsCust
  Left = 788
  Top = 319
  Caption = 'Reservations list'
  ClientHeight = 667
  ClientWidth = 1054
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
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 1054
    Height = 667
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object pageMain: TsPageControl
      Left = 0
      Top = 113
      Width = 1054
      Height = 534
      ActivePage = tabRoom
      Align = alClient
      TabOrder = 0
      SkinData.SkinSection = 'PAGECONTROL'
      object tabRoom: TsTabSheet
        Caption = 'Rooms'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object grRooms: TcxGrid
          Left = 0
          Top = 44
          Width = 1046
          Height = 462
          Align = alClient
          PopupMenu = PopupMenu1
          TabOrder = 0
          LookAndFeel.NativeStyle = False
          object cxGridDBTableView2: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DetailKeyFieldNames = 'reservation'
            DataController.KeyFieldNames = 'reservation'
            DataController.MasterKeyFieldNames = 'reservation'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.GroupByBox = False
            object cxGridDBColumn35: TcxGridDBColumn
              DataBinding.FieldName = 'Roomreservation'
              Visible = False
            end
            object cxGridDBColumn36: TcxGridDBColumn
              DataBinding.FieldName = 'reservation'
              Visible = False
            end
            object cxGridDBColumn37: TcxGridDBColumn
              DataBinding.FieldName = 'room'
            end
            object cxGridDBColumn38: TcxGridDBColumn
              Caption = 'Type'
              DataBinding.FieldName = 'RoomType'
            end
            object cxGridDBColumn39: TcxGridDBColumn
              Caption = 'Arrival'
              DataBinding.FieldName = 'rrArrival'
            end
            object cxGridDBColumn40: TcxGridDBColumn
              Caption = 'Departure'
              DataBinding.FieldName = 'rrDeparture'
            end
            object cxGridDBColumn41: TcxGridDBColumn
              DataBinding.FieldName = 'GuestName'
            end
            object cxGridDBColumn42: TcxGridDBColumn
              DataBinding.FieldName = 'GuestCount'
            end
            object cxGridDBColumn43: TcxGridDBColumn
              DataBinding.FieldName = 'numGuests'
            end
            object cxGridDBColumn44: TcxGridDBColumn
              DataBinding.FieldName = 'numChildren'
            end
            object cxGridDBColumn45: TcxGridDBColumn
              DataBinding.FieldName = 'numInfants'
            end
            object cxGridDBColumn46: TcxGridDBColumn
              DataBinding.FieldName = 'Status'
            end
            object cxGridDBColumn47: TcxGridDBColumn
              DataBinding.FieldName = 'GroupAccount'
            end
            object cxGridDBColumn48: TcxGridDBColumn
              DataBinding.FieldName = 'invBreakfast'
            end
            object cxGridDBColumn49: TcxGridDBColumn
              DataBinding.FieldName = 'Currency'
            end
            object cxGridDBColumn50: TcxGridDBColumn
              DataBinding.FieldName = 'Discount'
            end
            object cxGridDBColumn51: TcxGridDBColumn
              DataBinding.FieldName = 'Percentage'
            end
            object cxGridDBColumn52: TcxGridDBColumn
              DataBinding.FieldName = 'PriceType'
            end
            object cxGridDBColumn53: TcxGridDBColumn
              DataBinding.FieldName = 'RoomRentPaymentInvoice'
            end
            object cxGridDBColumn54: TcxGridDBColumn
              DataBinding.FieldName = 'PMInfo'
            end
            object cxGridDBColumn55: TcxGridDBColumn
              DataBinding.FieldName = 'HiddenInfo'
            end
            object cxGridDBColumn56: TcxGridDBColumn
              DataBinding.FieldName = 'ID'
              Visible = False
            end
            object cxGridDBColumn57: TcxGridDBColumn
              DataBinding.FieldName = 'rrIsNoRoom'
            end
            object cxGridDBColumn58: TcxGridDBColumn
              DataBinding.FieldName = 'useStayTax'
            end
            object cxGridDBColumn59: TcxGridDBColumn
              DataBinding.FieldName = 'useinNationalReport'
            end
            object cxGridDBColumn60: TcxGridDBColumn
              DataBinding.FieldName = 'AvrageRate'
            end
            object cxGridDBColumn61: TcxGridDBColumn
              DataBinding.FieldName = 'RateCount'
            end
            object cxGridDBColumn62: TcxGridDBColumn
              DataBinding.FieldName = 'dtCreated'
            end
          end
          object cxGridDBTableView3: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DetailKeyFieldNames = 'Roomreservation'
            DataController.KeyFieldNames = 'Roomreservation'
            DataController.MasterKeyFieldNames = 'Roomreservation'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.GroupByBox = False
            object cxGridDBColumn63: TcxGridDBColumn
              DataBinding.FieldName = 'Roomreservation'
            end
            object cxGridDBColumn64: TcxGridDBColumn
              DataBinding.FieldName = 'reservation'
            end
            object cxGridDBColumn65: TcxGridDBColumn
              DataBinding.FieldName = 'roomDate'
            end
            object cxGridDBColumn66: TcxGridDBColumn
              DataBinding.FieldName = 'GuestName'
            end
            object cxGridDBColumn67: TcxGridDBColumn
              DataBinding.FieldName = 'ResFlag'
            end
            object cxGridDBColumn68: TcxGridDBColumn
              DataBinding.FieldName = 'isNoRoom'
            end
            object cxGridDBColumn69: TcxGridDBColumn
              DataBinding.FieldName = 'PriceCode'
            end
            object cxGridDBColumn70: TcxGridDBColumn
              DataBinding.FieldName = 'RoomRate'
            end
            object cxGridDBColumn71: TcxGridDBColumn
              DataBinding.FieldName = 'Currency'
            end
            object cxGridDBColumn72: TcxGridDBColumn
              DataBinding.FieldName = 'Discount'
            end
            object cxGridDBColumn73: TcxGridDBColumn
              DataBinding.FieldName = 'isPercentage'
            end
            object cxGridDBColumn74: TcxGridDBColumn
              DataBinding.FieldName = 'showDiscount'
            end
            object cxGridDBColumn75: TcxGridDBColumn
              DataBinding.FieldName = 'Paid'
            end
          end
          object cxGridDBBandedTableView1: TcxGridDBBandedTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            Bands = <
              item
              end>
          end
          object tvRooms: TcxGridDBBandedTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = RoomsDS
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            Bands = <
              item
                Caption = 'Dates'
                FixedKind = fkLeft
              end
              item
                Caption = 'Description'
              end
              item
                Caption = 'Contact'
              end
              item
                Caption = 'Other'
              end
              item
                Caption = 'Reservation'
              end>
            object tvRoomsdtCreated: TcxGridDBBandedColumn
              DataBinding.FieldName = 'dtCreated'
              Position.BandIndex = 0
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object tvRoomsrrArrival: TcxGridDBBandedColumn
              DataBinding.FieldName = 'rrArrival'
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object tvRoomsrrDeparture: TcxGridDBBandedColumn
              DataBinding.FieldName = 'rrDeparture'
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object tvRoomsresDescription: TcxGridDBBandedColumn
              DataBinding.FieldName = 'resDescription'
              Width = 218
              Position.BandIndex = 1
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object tvRoomsroom: TcxGridDBBandedColumn
              DataBinding.FieldName = 'room'
              Width = 62
              Position.BandIndex = 1
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object tvRoomsGuestName: TcxGridDBBandedColumn
              DataBinding.FieldName = 'GuestName'
              Width = 109
              Position.BandIndex = 1
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object tvRoomsGuestCount: TcxGridDBBandedColumn
              DataBinding.FieldName = 'GuestCount'
              Position.BandIndex = 1
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object tvRoomsContactName: TcxGridDBBandedColumn
              DataBinding.FieldName = 'ContactName'
              Position.BandIndex = 2
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object tvRoomsContactEmail: TcxGridDBBandedColumn
              DataBinding.FieldName = 'ContactEmail'
              Position.BandIndex = 2
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object tvRoomsStatus: TcxGridDBBandedColumn
              DataBinding.FieldName = 'Status'
              Position.BandIndex = 3
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object tvRoomsGroupAccount: TcxGridDBBandedColumn
              DataBinding.FieldName = 'GroupAccount'
              Position.BandIndex = 3
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object tvRoomsinvBreakfast: TcxGridDBBandedColumn
              DataBinding.FieldName = 'invBreakfast'
              Position.BandIndex = 3
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object tvRoomsCurrency: TcxGridDBBandedColumn
              DataBinding.FieldName = 'Currency'
              Position.BandIndex = 3
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object tvRoomsDiscount: TcxGridDBBandedColumn
              DataBinding.FieldName = 'Discount'
              Position.BandIndex = 3
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object tvRoomsPercentage: TcxGridDBBandedColumn
              DataBinding.FieldName = 'Percentage'
              Position.BandIndex = 3
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object tvRoomsPriceType: TcxGridDBBandedColumn
              DataBinding.FieldName = 'PriceType'
              Position.BandIndex = 3
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object tvRoomsRoomType: TcxGridDBBandedColumn
              DataBinding.FieldName = 'RoomType'
              Position.BandIndex = 3
              Position.ColIndex = 7
              Position.RowIndex = 0
            end
            object tvRoomsPMInfo: TcxGridDBBandedColumn
              DataBinding.FieldName = 'PMInfo'
              Position.BandIndex = 3
              Position.ColIndex = 8
              Position.RowIndex = 0
            end
            object tvRoomsHiddenInfo: TcxGridDBBandedColumn
              DataBinding.FieldName = 'HiddenInfo'
              Position.BandIndex = 3
              Position.ColIndex = 9
              Position.RowIndex = 0
            end
            object tvRoomsRoomRentPaymentInvoice: TcxGridDBBandedColumn
              DataBinding.FieldName = 'RoomRentPaymentInvoice'
              Position.BandIndex = 3
              Position.ColIndex = 10
              Position.RowIndex = 0
            end
            object tvRoomsID: TcxGridDBBandedColumn
              DataBinding.FieldName = 'ID'
              Position.BandIndex = 3
              Position.ColIndex = 11
              Position.RowIndex = 0
            end
            object tvRoomsrrIsNoRoom: TcxGridDBBandedColumn
              DataBinding.FieldName = 'rrIsNoRoom'
              Position.BandIndex = 3
              Position.ColIndex = 12
              Position.RowIndex = 0
            end
            object tvRoomsuseStayTax: TcxGridDBBandedColumn
              DataBinding.FieldName = 'useStayTax'
              Position.BandIndex = 3
              Position.ColIndex = 13
              Position.RowIndex = 0
            end
            object tvRoomsuseinNationalReport: TcxGridDBBandedColumn
              DataBinding.FieldName = 'useinNationalReport'
              Position.BandIndex = 3
              Position.ColIndex = 14
              Position.RowIndex = 0
            end
            object tvRoomsnumGuests: TcxGridDBBandedColumn
              DataBinding.FieldName = 'numGuests'
              Position.BandIndex = 3
              Position.ColIndex = 15
              Position.RowIndex = 0
            end
            object tvRoomsnumChildren: TcxGridDBBandedColumn
              DataBinding.FieldName = 'numChildren'
              Position.BandIndex = 3
              Position.ColIndex = 16
              Position.RowIndex = 0
            end
            object tvRoomsnumInfants: TcxGridDBBandedColumn
              DataBinding.FieldName = 'numInfants'
              Position.BandIndex = 3
              Position.ColIndex = 17
              Position.RowIndex = 0
            end
            object tvRoomsRateCount: TcxGridDBBandedColumn
              DataBinding.FieldName = 'RateCount'
              Position.BandIndex = 3
              Position.ColIndex = 18
              Position.RowIndex = 0
            end
            object tvRoomsReservationName: TcxGridDBBandedColumn
              DataBinding.FieldName = 'ReservationName'
              Position.BandIndex = 3
              Position.ColIndex = 19
              Position.RowIndex = 0
            end
            object tvRoomsCustomerName: TcxGridDBBandedColumn
              DataBinding.FieldName = 'CustomerName'
              Position.BandIndex = 3
              Position.ColIndex = 20
              Position.RowIndex = 0
            end
            object tvRoomsChannelName: TcxGridDBBandedColumn
              DataBinding.FieldName = 'ChannelName'
              Position.BandIndex = 3
              Position.ColIndex = 21
              Position.RowIndex = 0
            end
            object tvRoomsRoomClass: TcxGridDBBandedColumn
              DataBinding.FieldName = 'RoomClass'
              Position.BandIndex = 3
              Position.ColIndex = 22
              Position.RowIndex = 0
            end
            object tvRoomsCustomer: TcxGridDBBandedColumn
              DataBinding.FieldName = 'Customer'
              Position.BandIndex = 3
              Position.ColIndex = 23
              Position.RowIndex = 0
            end
            object tvRoomsCountry: TcxGridDBBandedColumn
              DataBinding.FieldName = 'Country'
              Position.BandIndex = 3
              Position.ColIndex = 24
              Position.RowIndex = 0
            end
            object tvRoomsCustPID: TcxGridDBBandedColumn
              DataBinding.FieldName = 'CustPID'
              Position.BandIndex = 3
              Position.ColIndex = 25
              Position.RowIndex = 0
            end
            object tvRoomsinvRefrence: TcxGridDBBandedColumn
              DataBinding.FieldName = 'invRefrence'
              Position.BandIndex = 3
              Position.ColIndex = 26
              Position.RowIndex = 0
            end
            object tvRoomsmarketSegment: TcxGridDBBandedColumn
              DataBinding.FieldName = 'marketSegment'
              Position.BandIndex = 3
              Position.ColIndex = 27
              Position.RowIndex = 0
            end
            object tvRoomsCustomerEmail: TcxGridDBBandedColumn
              DataBinding.FieldName = 'CustomerEmail'
              Position.BandIndex = 3
              Position.ColIndex = 28
              Position.RowIndex = 0
            end
            object tvRoomsRoomreservation: TcxGridDBBandedColumn
              DataBinding.FieldName = 'Roomreservation'
              Position.BandIndex = 4
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object tvRoomsreservation: TcxGridDBBandedColumn
              DataBinding.FieldName = 'reservation'
              Position.BandIndex = 4
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
          end
          object lvRooms: TcxGridLevel
            GridView = tvRooms
          end
        end
        object sPanel1: TsPanel
          Left = 0
          Top = 0
          Width = 1046
          Height = 44
          Align = alTop
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
          object sButton2: TsButton
            Left = 3
            Top = 1
            Width = 100
            Height = 37
            Caption = 'Excel'
            ImageIndex = 132
            Images = DImages.PngImageList1
            TabOrder = 0
            OnClick = sButton2Click
            SkinData.SkinSection = 'BUTTON'
          end
          object brnRoomsTabReservation: TsButton
            Left = 109
            Top = 2
            Width = 102
            Height = 37
            Caption = 'Reservaton'
            ImageIndex = 56
            Images = DImages.PngImageList1
            TabOrder = 1
            OnClick = brnRoomsTabReservationClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnRoomsTabRoom: TsButton
            Left = 217
            Top = 2
            Width = 100
            Height = 37
            Caption = 'Room'
            ImageIndex = 39
            Images = DImages.PngImageList1
            TabOrder = 2
            OnClick = btnRoomsTabRoomClick
            SkinData.SkinSection = 'BUTTON'
          end
        end
      end
    end
    object dxStatusBar1: TdxStatusBar
      Left = 0
      Top = 647
      Width = 1054
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
      Width = 1054
      Height = 113
      Align = alTop
      Anchors = [akTop, akRight]
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      object cLabFilter: TsLabel
        Left = 65
        Top = 89
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
        Left = 360
        Top = 88
        Width = 60
        Height = 20
        Caption = 'Clear'
        OnClick = btnClearClick
        SkinData.SkinSection = 'SPEEDBUTTON'
        ImageIndex = 10
        Images = DImages.PngImageList1
      end
      object cxGroupBox2: TsGroupBox
        Left = 163
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
        object cbxMonth: TsComboBox
          Left = 15
          Top = 20
          Width = 121
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
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
          Top = 47
          Width = 121
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
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
        Left = 664
        Top = 8
        Width = 117
        Height = 38
        Caption = 'Refresh ALL'
        Default = True
        ImageIndex = 28
        Images = DImages.PngImageList1
        TabOrder = 1
        OnClick = btnRefreshClick
        SkinData.SkinSection = 'BUTTON'
      end
      object gbxSelectDates: TsGroupBox
        Left = 22
        Top = 3
        Width = 132
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
        object dtDateFrom: TsDateEdit
          Left = 16
          Top = 20
          Width = 105
          Height = 21
          AutoSize = False
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
          Text = '  .  .    '
          OnChange = dtDateFromChange
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
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
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 1
          Text = '  .  .    '
          OnChange = dtDateFromChange
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
      end
      object edFilter: TsEdit
        Left = 102
        Top = 87
        Width = 255
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = edFilterChange
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
      end
      object rgrDateRangeFor: TsRadioGroup
        Left = 322
        Top = 3
        Width = 189
        Height = 78
        Caption = 'Date range for..'
        TabOrder = 4
        SkinData.SkinSection = 'GROUPBOX'
        ItemIndex = 0
        Items.Strings = (
          'Reservation made'
          'Reservation arrival'
          'Reservation stay')
      end
      object btnJumpToRoom: TsButton
        Left = 664
        Top = 52
        Width = 117
        Height = 38
        Caption = 'Jump to'
        ImageIndex = 57
        Images = DImages.PngImageList1
        ModalResult = 1
        TabOrder = 5
        OnClick = btnJumpToRoomClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sGroupBox1: TsGroupBox
        Left = 517
        Top = 3
        Width = 141
        Height = 78
        Caption = 'Customer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        SkinData.SkinSection = 'GROUPBOX'
        object btnGetCustomer: TsSpeedButton
          Left = 104
          Top = 18
          Width = 23
          Height = 21
          Caption = '...'
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object labCustomerName: TsLabel
          Left = 11
          Top = 48
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
        object edCustomer: TsEdit
          Left = 7
          Top = 20
          Width = 92
          Height = 21
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TextHint = 'dbl-click to select from list'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
        end
      end
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
    StorageName = 'Software\Roomer\FormStatus\RptReservations'
    StorageType = stRegistry
    Left = 486
    Top = 320
  end
  object PopupMenu1: TPopupMenu
    Left = 424
    Top = 312
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    PopupMenus = <>
    Left = 488
    Top = 264
  end
  object kbmRooms: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Roomreservation'
        DataType = ftInteger
      end
      item
        Name = 'reservation'
        DataType = ftInteger
      end
      item
        Name = 'room'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'rrArrival'
        DataType = ftDate
      end
      item
        Name = 'rrDeparture'
        DataType = ftDate
      end
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'GuestCount'
        DataType = ftInteger
      end
      item
        Name = 'Status'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'GroupAccount'
        DataType = ftBoolean
      end
      item
        Name = 'invBreakfast'
        DataType = ftBoolean
      end
      item
        Name = 'Currency'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Discount'
        DataType = ftFloat
      end
      item
        Name = 'Percentage'
        DataType = ftBoolean
      end
      item
        Name = 'PriceType'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'RoomType'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'PMInfo'
        DataType = ftMemo
      end
      item
        Name = 'HiddenInfo'
        DataType = ftMemo
      end
      item
        Name = 'RoomRentPaymentInvoice'
        DataType = ftInteger
      end
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'rrIsNoRoom'
        DataType = ftBoolean
      end
      item
        Name = 'useStayTax'
        DataType = ftBoolean
      end
      item
        Name = 'useinNationalReport'
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
        Name = 'RateCount'
        DataType = ftInteger
      end
      item
        Name = 'dtCreated'
        DataType = ftDateTime
      end
      item
        Name = 'ReservationName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'ChannelName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'RoomClass'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'Country'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'ContactName'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'ContactEmail'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'CustPID'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'invRefrence'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'marketSegment'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'CustomerEmail'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'resDescription'
        DataType = ftWideMemo
        Size = 200
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
    Left = 80
    Top = 480
  end
  object RoomsDS: TDataSource
    DataSet = kbmRooms
    Left = 232
    Top = 480
  end
end
