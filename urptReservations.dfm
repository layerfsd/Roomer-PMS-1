object frmRptReservations: TfrmRptReservations
  Left = 788
  Top = 319
  Caption = 'Reservations list'
  ClientHeight = 644
  ClientWidth = 1094
  Color = clBtnFace
  Constraints.MinWidth = 920
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
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 1094
    Height = 644
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
      Top = 117
      Width = 1094
      Height = 507
      ActivePage = tabReservation
      Align = alClient
      TabOrder = 0
      SkinData.SkinSection = 'PAGECONTROL'
      OnPageChanging = pageMainPageChanging
      object tabReservation: TsTabSheet
        Caption = 'Reservations'
        ImageIndex = 2
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object Panel5: TsPanel
          Left = 0
          Top = 0
          Width = 1086
          Height = 44
          Align = alTop
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
          object btnGuestsExcel: TsButton
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 100
            Height = 36
            Align = alLeft
            Caption = 'Excel'
            ImageIndex = 132
            Images = DImages.PngImageList1
            TabOrder = 0
            OnClick = btnGuestsExcelClick
            SkinData.SkinSection = 'BUTTON'
          end
          object brnGuestsReservation: TsButton
            AlignWithMargins = True
            Left = 110
            Top = 4
            Width = 100
            Height = 36
            Align = alLeft
            Caption = 'Reservaton'
            ImageIndex = 56
            Images = DImages.PngImageList1
            TabOrder = 1
            OnClick = brnGuestsReservationClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnExpandAll: TsButton
            AlignWithMargins = True
            Left = 349
            Top = 4
            Width = 100
            Height = 36
            Margins.Left = 30
            Align = alLeft
            Caption = 'Expand All'
            TabOrder = 2
            OnClick = btnExpandAllClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnCollapseAll: TsButton
            AlignWithMargins = True
            Left = 455
            Top = 4
            Width = 100
            Height = 36
            Align = alLeft
            Caption = 'Collapse All'
            TabOrder = 3
            OnClick = btnCollapseAllClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnGuestsRoom: TsButton
            AlignWithMargins = True
            Left = 216
            Top = 4
            Width = 100
            Height = 36
            Align = alLeft
            Caption = 'Room'
            ImageIndex = 39
            Images = DImages.PngImageList1
            TabOrder = 4
            OnClick = btnGuestsRoomClick
            SkinData.SkinSection = 'BUTTON'
          end
        end
        object grReservations: TcxGrid
          Left = 0
          Top = 44
          Width = 1086
          Height = 435
          Align = alClient
          PopupMenu = PopupMenu1
          TabOrder = 1
          LookAndFeel.NativeStyle = False
          object tvReservations: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.Insert.Visible = False
            Navigator.Buttons.Append.Visible = True
            Navigator.Buttons.Delete.Visible = False
            Navigator.Buttons.Edit.Visible = False
            Navigator.Buttons.Cancel.Visible = False
            Navigator.InfoPanel.Visible = True
            Navigator.Visible = True
            DataController.DataSource = kbmReservationsDS
            DataController.DetailKeyFieldNames = 'reservation'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                FieldName = 'dtCreated'
                Column = tvReservationsdtCreated
              end
              item
                Kind = skSum
                FieldName = 'GuestCount'
                Column = tvReservationsGuestCount
              end
              item
                Kind = skSum
                FieldName = 'roomCount'
                Column = tvReservationsroomCount
              end
              item
                Kind = skSum
                FieldName = 'totalNights'
                Column = tvReservationstotalNights
              end
              item
                Kind = skSum
                FieldName = 'TotalRoomRent'
                Column = tvReservationsTotalRoomRent
              end
              item
                Format = ',0.;-,0.'
                Kind = skSum
                FieldName = 'Discount'
                Column = tvReservationsDiscount
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.Footer = True
            object tvReservationsdtCreated: TcxGridDBColumn
              Caption = 'Date/time booked'
              DataBinding.FieldName = 'dtCreated'
              PropertiesClassName = 'TcxDateEditProperties'
              Properties.Kind = ckDateTime
              Width = 160
            end
            object tvReservationsdtArrival: TcxGridDBColumn
              Caption = 'Arrival'
              DataBinding.FieldName = 'dtArrival'
            end
            object tvReservationsdtDeparture: TcxGridDBColumn
              Caption = 'Departure'
              DataBinding.FieldName = 'dtDeparture'
            end
            object tvReservationsGuestName: TcxGridDBColumn
              DataBinding.FieldName = 'GuestName'
              Width = 170
            end
            object tvReservationsChannelName: TcxGridDBColumn
              Caption = 'Channel'
              DataBinding.FieldName = 'ChannelName'
              Width = 80
            end
            object tvReservationsinvRefrence: TcxGridDBColumn
              Caption = 'Refrence'
              DataBinding.FieldName = 'invRefrence'
              Width = 231
            end
            object tvReservationsGuestCount: TcxGridDBColumn
              Caption = 'Guests'
              DataBinding.FieldName = 'GuestCount'
            end
            object tvReservationsroomCount: TcxGridDBColumn
              Caption = 'Rooms'
              DataBinding.FieldName = 'roomCount'
            end
            object tvReservationsReservationName: TcxGridDBColumn
              Caption = 'Reservation name'
              DataBinding.FieldName = 'ReservationName'
              Width = 100
            end
            object tvReservationsCustomer: TcxGridDBColumn
              DataBinding.FieldName = 'Customer'
              Width = 100
            end
            object tvReservationsCustomerName: TcxGridDBColumn
              Caption = 'Customer name'
              DataBinding.FieldName = 'CustomerName'
              Width = 80
            end
            object tvReservationsAddress1: TcxGridDBColumn
              DataBinding.FieldName = 'Address1'
              Width = 100
            end
            object tvReservationsAddress2: TcxGridDBColumn
              DataBinding.FieldName = 'Address2'
              Width = 100
            end
            object tvReservationsAddress3: TcxGridDBColumn
              DataBinding.FieldName = 'Address3'
              Width = 100
            end
            object tvReservationsAddress4: TcxGridDBColumn
              DataBinding.FieldName = 'Address4'
              Width = 100
            end
            object tvReservationsCustomerEmail: TcxGridDBColumn
              Caption = 'Customer Email'
              DataBinding.FieldName = 'CustomerEmail'
              Width = 100
            end
            object tvReservationsCustomerWebsite: TcxGridDBColumn
              Caption = 'Customer Website'
              DataBinding.FieldName = 'CustomerWebsite'
              Width = 100
            end
            object tvReservationsContactName: TcxGridDBColumn
              Caption = 'Contact Name'
              DataBinding.FieldName = 'ContactName'
              Width = 100
            end
            object tvReservationsCustPID: TcxGridDBColumn
              DataBinding.FieldName = 'CustPID'
            end
            object tvReservationsContactPhone: TcxGridDBColumn
              Caption = 'Contact Phone'
              DataBinding.FieldName = 'ContactPhone'
              Width = 50
            end
            object tvReservationsContactFax: TcxGridDBColumn
              Caption = 'Contact Fax'
              DataBinding.FieldName = 'ContactFax'
              Width = 50
            end
            object tvReservationsContactEmail: TcxGridDBColumn
              Caption = 'Contact Email'
              DataBinding.FieldName = 'ContactEmail'
              Width = 100
            end
            object tvReservationsCountry: TcxGridDBColumn
              DataBinding.FieldName = 'Country'
            end
            object tvReservationsStaff: TcxGridDBColumn
              DataBinding.FieldName = 'Staff'
              Width = 25
            end
            object tvReservationsInformation: TcxGridDBColumn
              Caption = 'Notes'
              DataBinding.FieldName = 'Information'
            end
            object tvReservationsPMInfo: TcxGridDBColumn
              Caption = 'Payment Notes'
              DataBinding.FieldName = 'PMInfo'
            end
            object tvReservationsinputsource: TcxGridDBColumn
              DataBinding.FieldName = 'inputsource'
            end
            object tvReservationssrcrequest: TcxGridDBColumn
              DataBinding.FieldName = 'srcrequest'
            end
            object tvReservationsmarketSegment: TcxGridDBColumn
              DataBinding.FieldName = 'marketSegment'
            end
            object tvReservationsexternalIds: TcxGridDBColumn
              DataBinding.FieldName = 'externalIds'
              Width = 100
            end
            object tvReservationsreservation: TcxGridDBColumn
              DataBinding.FieldName = 'reservation'
            end
            object tvReservationsID: TcxGridDBColumn
              DataBinding.FieldName = 'ID'
              Visible = False
            end
            object tvReservationsuseStayTax: TcxGridDBColumn
              DataBinding.FieldName = 'useStayTax'
            end
            object tvReservationschannel: TcxGridDBColumn
              DataBinding.FieldName = 'channel'
            end
            object tvReservationstotalNights: TcxGridDBColumn
              DataBinding.FieldName = 'totalNights'
            end
            object tvReservationsCurrency: TcxGridDBColumn
              DataBinding.FieldName = 'Currency'
              OnGetProperties = tvReservationsTotalRoomRentGetProperties
            end
            object tvReservationsCurrencyrate: TcxGridDBColumn
              Caption = 'Rate'
              DataBinding.FieldName = 'Currencyrate'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object tvReservationsRoomRent: TcxGridDBColumn
              Caption = 'Room Rent'
              DataBinding.FieldName = 'RoomRent'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              OnGetProperties = tvReservationsDiscountGetProperties
            end
            object tvReservationsDiscount: TcxGridDBColumn
              DataBinding.FieldName = 'Discount'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              OnGetProperties = tvReservationsDiscountGetProperties
            end
            object tvReservationsTotalRoomRent: TcxGridDBColumn
              Caption = 'Tota lRoom Rent'
              DataBinding.FieldName = 'TotalRoomRent'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              OnGetProperties = tvReservationsTotalRoomRentGetProperties
            end
            object tvReservationsAvrageRoomRent: TcxGridDBColumn
              Caption = 'Per Night'
              DataBinding.FieldName = 'AvrageRoomRent'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              OnGetProperties = tvReservationsTotalRoomRentGetProperties
            end
          end
          object tvRoomReservations: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = kbmRoomReservationsDS
            DataController.DetailKeyFieldNames = 'reservation'
            DataController.KeyFieldNames = 'reservation'
            DataController.MasterKeyFieldNames = 'reservation'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.GroupByBox = False
            object tvRoomReservationsRoomreservation: TcxGridDBColumn
              DataBinding.FieldName = 'Roomreservation'
              Visible = False
            end
            object tvRoomReservationsreservation: TcxGridDBColumn
              DataBinding.FieldName = 'reservation'
              Visible = False
            end
            object tvRoomReservationsroom: TcxGridDBColumn
              DataBinding.FieldName = 'room'
            end
            object tvRoomReservationsRoomType: TcxGridDBColumn
              Caption = 'Type'
              DataBinding.FieldName = 'RoomType'
            end
            object tvRoomReservationsrrArrival: TcxGridDBColumn
              Caption = 'Arrival'
              DataBinding.FieldName = 'rrArrival'
            end
            object tvRoomReservationsExpectedTimeOfArrival: TcxGridDBColumn
              Caption = 'Exp. TOA'
              DataBinding.FieldName = 'ExpectedTimeOfArrival'
              PropertiesClassName = 'TcxTimeEditProperties'
            end
            object tvRoomReservationsrrDeparture: TcxGridDBColumn
              Caption = 'Departure'
              DataBinding.FieldName = 'rrDeparture'
            end
            object tvRoomReservationsExpectedCheckoutTime: TcxGridDBColumn
              Caption = 'Exp. COT'
              DataBinding.FieldName = 'ExpectedCheckoutTime'
              PropertiesClassName = 'TcxTimeEditProperties'
            end
            object tvRoomReservationsGuestName: TcxGridDBColumn
              DataBinding.FieldName = 'GuestName'
            end
            object tvRoomReservationsGuestCount: TcxGridDBColumn
              DataBinding.FieldName = 'GuestCount'
            end
            object tvRoomReservationsnumGuests: TcxGridDBColumn
              DataBinding.FieldName = 'numGuests'
            end
            object tvRoomReservationsnumChildren: TcxGridDBColumn
              DataBinding.FieldName = 'numChildren'
            end
            object tvRoomReservationsnumInfants: TcxGridDBColumn
              DataBinding.FieldName = 'numInfants'
            end
            object tvRoomReservationsStatus: TcxGridDBColumn
              DataBinding.FieldName = 'Status'
            end
            object tvRoomReservationsGroupAccount: TcxGridDBColumn
              DataBinding.FieldName = 'GroupAccount'
            end
            object tvRoomReservationsinvBreakfast: TcxGridDBColumn
              DataBinding.FieldName = 'invBreakfast'
            end
            object tvRoomReservationsCurrency: TcxGridDBColumn
              DataBinding.FieldName = 'Currency'
            end
            object tvRoomReservationsDiscount: TcxGridDBColumn
              DataBinding.FieldName = 'Discount'
            end
            object tvRoomReservationsPercentage: TcxGridDBColumn
              DataBinding.FieldName = 'Percentage'
            end
            object tvRoomReservationsPriceType: TcxGridDBColumn
              DataBinding.FieldName = 'PriceType'
            end
            object tvRoomReservationsRoomRentPaymentInvoice: TcxGridDBColumn
              DataBinding.FieldName = 'RoomRentPaymentInvoice'
            end
            object tvRoomReservationsPMInfo: TcxGridDBColumn
              DataBinding.FieldName = 'PMInfo'
            end
            object tvRoomReservationsHiddenInfo: TcxGridDBColumn
              DataBinding.FieldName = 'HiddenInfo'
            end
            object tvRoomReservationsID: TcxGridDBColumn
              DataBinding.FieldName = 'ID'
              Visible = False
            end
            object tvRoomReservationsrrIsNoRoom: TcxGridDBColumn
              DataBinding.FieldName = 'rrIsNoRoom'
            end
            object tvRoomReservationsuseStayTax: TcxGridDBColumn
              DataBinding.FieldName = 'useStayTax'
            end
            object tvRoomReservationsuseinNationalReport: TcxGridDBColumn
              DataBinding.FieldName = 'useinNationalReport'
            end
            object tvRoomReservationsAvrageRate: TcxGridDBColumn
              DataBinding.FieldName = 'AvrageRate'
            end
            object tvRoomReservationsRateCount: TcxGridDBColumn
              DataBinding.FieldName = 'RateCount'
            end
            object tvRoomReservationsdtCreated: TcxGridDBColumn
              DataBinding.FieldName = 'dtCreated'
            end
          end
          object tvRoomsDate: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = kbmRoomsDateDS
            DataController.DetailKeyFieldNames = 'Roomreservation'
            DataController.KeyFieldNames = 'Roomreservation'
            DataController.MasterKeyFieldNames = 'Roomreservation'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.GroupByBox = False
            object tvRoomsDateRoomreservation: TcxGridDBColumn
              DataBinding.FieldName = 'Roomreservation'
            end
            object tvRoomsDatereservation: TcxGridDBColumn
              DataBinding.FieldName = 'reservation'
            end
            object tvRoomsDateroomDate: TcxGridDBColumn
              DataBinding.FieldName = 'roomDate'
            end
            object tvRoomsDateGuestName: TcxGridDBColumn
              DataBinding.FieldName = 'GuestName'
            end
            object tvRoomsDateResFlag: TcxGridDBColumn
              DataBinding.FieldName = 'ResFlag'
            end
            object tvRoomsDateisNoRoom: TcxGridDBColumn
              DataBinding.FieldName = 'isNoRoom'
            end
            object tvRoomsDatePriceCode: TcxGridDBColumn
              DataBinding.FieldName = 'PriceCode'
            end
            object tvRoomsDateRoomRate: TcxGridDBColumn
              DataBinding.FieldName = 'RoomRate'
            end
            object tvRoomsDateCurrency: TcxGridDBColumn
              DataBinding.FieldName = 'Currency'
            end
            object tvRoomsDateDiscount: TcxGridDBColumn
              DataBinding.FieldName = 'Discount'
            end
            object tvRoomsDateisPercentage: TcxGridDBColumn
              DataBinding.FieldName = 'isPercentage'
            end
            object tvRoomsDateshowDiscount: TcxGridDBColumn
              DataBinding.FieldName = 'showDiscount'
            end
            object tvRoomsDatePaid: TcxGridDBColumn
              DataBinding.FieldName = 'Paid'
            end
          end
          object grReservationsDBBandedTableView1: TcxGridDBBandedTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            Bands = <
              item
              end>
          end
          object lvReservations: TcxGridLevel
            GridView = tvReservations
            object lvRoomReservations: TcxGridLevel
              GridView = tvRoomReservations
              object lvRoomsDate: TcxGridLevel
                GridView = tvRoomsDate
              end
            end
          end
        end
      end
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
          Width = 1086
          Height = 435
          Align = alClient
          PopupMenu = PopupMenu1
          TabOrder = 0
          LookAndFeel.NativeStyle = False
          object cxGridDBTableView2: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = kbmRoomReservationsDS
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
            DataController.DataSource = kbmRoomsDateDS
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
          object tvRooms: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.Next.Visible = False
            Navigator.Buttons.Last.Visible = False
            Navigator.Buttons.Insert.Visible = False
            Navigator.Buttons.Append.Visible = True
            Navigator.Buttons.Delete.Visible = False
            Navigator.Buttons.Edit.Visible = False
            Navigator.Buttons.Post.Visible = False
            Navigator.Buttons.Cancel.Visible = False
            Navigator.InfoPanel.Visible = True
            Navigator.Visible = True
            DataController.DataSource = RoomsDS
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.Footer = True
            OptionsView.HeaderAutoHeight = True
            OptionsView.Indicator = True
            object tvRoomsdtCreated: TcxGridDBColumn
              Caption = 'Booked on'
              DataBinding.FieldName = 'dtCreated'
            end
            object tvRoomsrrArrival: TcxGridDBColumn
              Caption = 'Arrival'#13#10'date'
              DataBinding.FieldName = 'rrArrival'
            end
            object tvRoomsrrDeparture: TcxGridDBColumn
              Caption = 'Departure date'
              DataBinding.FieldName = 'rrDeparture'
            end
            object tvRoomsReservationName: TcxGridDBColumn
              Caption = 'Reservation Name'
              DataBinding.FieldName = 'ReservationName'
              Width = 185
            end
            object tvRoomsChannelName: TcxGridDBColumn
              Caption = 'Channel Name'
              DataBinding.FieldName = 'ChannelName'
              Width = 97
            end
            object tvRoomsroom: TcxGridDBColumn
              Caption = 'Room'
              DataBinding.FieldName = 'room'
              Width = 75
            end
            object tvRoomsRoomType: TcxGridDBColumn
              Caption = 'Room Type'
              DataBinding.FieldName = 'RoomType'
              Width = 95
            end
            object tvRoomsRoomClass: TcxGridDBColumn
              Caption = 'Channel Room Type'
              DataBinding.FieldName = 'RoomClass'
              Width = 67
            end
            object tvRoomsGuestName: TcxGridDBColumn
              Caption = 'Guest Name'
              DataBinding.FieldName = 'GuestName'
              Width = 193
            end
            object tvRoomsGuestCount: TcxGridDBColumn
              Caption = 'No of Guests'
              DataBinding.FieldName = 'GuestCount'
            end
            object tvRoomsStatus: TcxGridDBColumn
              DataBinding.FieldName = 'Status'
              Width = 41
            end
            object tvRoomsGroupAccount: TcxGridDBColumn
              Caption = 'is Group'
              DataBinding.FieldName = 'GroupAccount'
            end
            object tvRoomsinvBreakfast: TcxGridDBColumn
              Caption = 'Break- fast'
              DataBinding.FieldName = 'invBreakfast'
              Width = 41
            end
            object tvRoomsCustomer: TcxGridDBColumn
              DataBinding.FieldName = 'Customer'
              Width = 71
            end
            object tvRoomsCustPID: TcxGridDBColumn
              Caption = 'Company Id'
              DataBinding.FieldName = 'CustPID'
              Width = 62
            end
            object tvRoomsCustomerName: TcxGridDBColumn
              Caption = 'Customer Name'
              DataBinding.FieldName = 'CustomerName'
              Width = 166
            end
            object tvRoomsCurrency: TcxGridDBColumn
              DataBinding.FieldName = 'Currency'
              Visible = False
              Width = 54
            end
            object tvRoomsDiscount: TcxGridDBColumn
              DataBinding.FieldName = 'Discount'
              Visible = False
              Width = 62
            end
            object tvRoomsPercentage: TcxGridDBColumn
              Caption = 'Is %'
              DataBinding.FieldName = 'Percentage'
              Visible = False
            end
            object tvRoomsCountry: TcxGridDBColumn
              DataBinding.FieldName = 'Country'
              Width = 52
            end
            object tvRoomsCustomerEmail: TcxGridDBColumn
              Caption = 'Customer Email'
              DataBinding.FieldName = 'CustomerEmail'
              Width = 150
            end
            object tvRoomsContactName: TcxGridDBColumn
              Caption = 'Contact Name'
              DataBinding.FieldName = 'ContactName'
              Width = 150
            end
            object tvRoomsContactEmail: TcxGridDBColumn
              Caption = 'Contact Email'
              DataBinding.FieldName = 'ContactEmail'
              Width = 150
            end
            object tvRoomsPriceType: TcxGridDBColumn
              Caption = 'Price Type'
              DataBinding.FieldName = 'PriceType'
              Width = 106
            end
            object tvRoomsRoomRentPaymentInvoice: TcxGridDBColumn
              DataBinding.FieldName = 'RoomRentPaymentInvoice'
              Visible = False
            end
            object tvRoomsrrIsNoRoom: TcxGridDBColumn
              DataBinding.FieldName = 'rrIsNoRoom'
              Visible = False
            end
            object tvRoomsuseStayTax: TcxGridDBColumn
              DataBinding.FieldName = 'useStayTax'
              Visible = False
            end
            object tvRoomsnumGuests: TcxGridDBColumn
              Caption = 'Guests'
              DataBinding.FieldName = 'numGuests'
            end
            object tvRoomsnumChildren: TcxGridDBColumn
              Caption = 'Children'
              DataBinding.FieldName = 'numChildren'
            end
            object tvRoomsnumInfants: TcxGridDBColumn
              Caption = 'Infants'
              DataBinding.FieldName = 'numInfants'
            end
            object tvRoomsRateCount: TcxGridDBColumn
              DataBinding.FieldName = 'RateCount'
              Visible = False
            end
            object tvRoomsRoomreservation: TcxGridDBColumn
              Caption = 'Room Reservation'
              DataBinding.FieldName = 'Roomreservation'
            end
            object tvRoomsreservation: TcxGridDBColumn
              Caption = 'Reservation'
              DataBinding.FieldName = 'reservation'
            end
            object tvRoomsuseinNationalReport: TcxGridDBColumn
              DataBinding.FieldName = 'useinNationalReport'
              Visible = False
            end
            object tvRoomsID: TcxGridDBColumn
              DataBinding.FieldName = 'ID'
              Visible = False
            end
            object tvRoomsPMInfo: TcxGridDBColumn
              DataBinding.FieldName = 'PMInfo'
              Visible = False
            end
            object tvRoomsHiddenInfo: TcxGridDBColumn
              DataBinding.FieldName = 'HiddenInfo'
              Visible = False
            end
            object tvRoomsinvRefrence: TcxGridDBColumn
              Caption = 'Refrence'
              DataBinding.FieldName = 'invRefrence'
              Width = 68
            end
            object tvRoomsmarketSegment: TcxGridDBColumn
              Caption = 'Market'
              DataBinding.FieldName = 'marketSegment'
              Width = 40
            end
            object tvRoomsAvrageRate: TcxGridDBColumn
              DataBinding.FieldName = 'AvrageRate'
            end
          end
          object lvRooms: TcxGridLevel
            GridView = tvRooms
          end
        end
        object sPanel1: TsPanel
          Left = 0
          Top = 0
          Width = 1086
          Height = 44
          Align = alTop
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
          object sButton2: TsButton
            Left = 3
            Top = 2
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
          object sButton4: TsButton
            Left = 517
            Top = 2
            Width = 100
            Height = 37
            Caption = 'Expand All'
            Images = DImages.PngImageList1
            TabOrder = 2
            Visible = False
            OnClick = btnExpandAllClick
            SkinData.SkinSection = 'BUTTON'
          end
          object sButton5: TsButton
            Left = 623
            Top = 2
            Width = 100
            Height = 37
            Caption = 'Collapse All'
            Images = DImages.PngImageList1
            TabOrder = 3
            Visible = False
            OnClick = btnCollapseAllClick
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
            TabOrder = 4
            OnClick = btnRoomsTabRoomClick
            SkinData.SkinSection = 'BUTTON'
          end
        end
      end
    end
    object dxStatusBar1: TdxStatusBar
      Left = 0
      Top = 624
      Width = 1094
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
      Width = 1094
      Height = 117
      Align = alTop
      Anchors = [akTop, akRight]
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        1094
        117)
      object cLabFilter: TsLabel
        Left = 67
        Top = 91
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
        Left = 362
        Top = 90
        Width = 60
        Height = 20
        Caption = 'Clear'
        OnClick = btnClearClick
        SkinData.SkinSection = 'SPEEDBUTTON'
        Images = DImages.PngImageList1
        ImageIndex = 10
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
        Left = 517
        Top = 8
        Width = 122
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
      object edFilter: TsEdit
        Left = 104
        Top = 89
        Width = 255
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = edFilterChange
        SkinData.SkinSection = 'EDIT'
      end
      object rgrDateRangeFor: TsRadioGroup
        Left = 322
        Top = 3
        Width = 189
        Height = 78
        Caption = 'Date range for..'
        TabOrder = 4
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        ItemIndex = 0
        Items.Strings = (
          'Reservation made'
          'Reservation arrival'
          'Reservation stay')
      end
      object btnJumpToRoom: TsButton
        Left = 852
        Top = 8
        Width = 117
        Height = 38
        Anchors = [akTop, akRight]
        Caption = 'Jump to'
        ImageIndex = 57
        Images = DImages.PngImageList1
        ModalResult = 1
        TabOrder = 5
        OnClick = btnJumpToRoomClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClose: TsButton
        Left = 975
        Top = 8
        Width = 117
        Height = 38
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'Close'
        ImageIndex = 27
        Images = DImages.PngImageList1
        ModalResult = 8
        TabOrder = 6
        OnClick = btnCloseClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object kbmReservations_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'reservation'
        DataType = ftInteger
      end
      item
        Name = 'ReservationDate'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'dtArrival'
        DataType = ftDate
      end
      item
        Name = 'dtDeparture'
        DataType = ftDate
      end
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'ReservationName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Address1'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Address2'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Address3'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Address4'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Tel1'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'Tel2'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'Fax'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'ReservationStatus'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Staff'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'Information'
        DataType = ftMemo
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
        Name = 'RoomRentPaid1'
        DataType = ftFloat
      end
      item
        Name = 'RoomRentPaid2'
        DataType = ftFloat
      end
      item
        Name = 'RoomRentPaid3'
        DataType = ftFloat
      end
      item
        Name = 'RoomRentPaymentInvoice'
        DataType = ftInteger
      end
      item
        Name = 'ContactName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'ContactPhone'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ContactFax'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ContactEmail'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'inputsource'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'webconfirmed'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'arrivaltime'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'srcrequest'
        DataType = ftMemo
      end
      item
        Name = 'rvTmp'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'CustPID'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'invRefrence'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'marketSegment'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'CustomerEmail'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'CustomerWebsite'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'useStayTax'
        DataType = ftBoolean
      end
      item
        Name = 'channel'
        DataType = ftInteger
      end
      item
        Name = 'eventsProcessed'
        DataType = ftBoolean
      end
      item
        Name = 'alteredReservation'
        DataType = ftBoolean
      end
      item
        Name = 'externalIds'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'dtCreated'
        DataType = ftDateTime
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'ChannelName'
        DataType = ftWideString
        Size = 70
      end
      item
        Name = 'GuestCount'
        DataType = ftInteger
      end
      item
        Name = 'roomCount'
        DataType = ftInteger
      end
      item
        Name = 'totalNights'
        DataType = ftFloat
      end
      item
        Name = 'Currency'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Currencyrate'
        DataType = ftFloat
      end
      item
        Name = 'RoomRent'
        DataType = ftFloat
      end
      item
        Name = 'Discount'
        DataType = ftFloat
      end
      item
        Name = 'TotalRoomRent'
        DataType = ftFloat
      end
      item
        Name = 'AvrageRoomRent'
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
    Left = 80
    Top = 240
  end
  object kbmReservationsDS: TDataSource
    DataSet = kbmReservations_
    Left = 224
    Top = 240
  end
  object kbmRoomReservations_: TkbmMemTable
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
    Top = 320
  end
  object kbmRoomReservationsDS: TDataSource
    DataSet = kbmRoomReservations_
    Left = 224
    Top = 320
  end
  object kbmRoomsDate_: TkbmMemTable
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
        Name = 'roomDate'
        DataType = ftDateTime
      end
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 40
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
        Name = 'PriceCode'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'RoomRate'
        DataType = ftFloat
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
        Name = 'isPercentage'
        DataType = ftBoolean
      end
      item
        Name = 'showDiscount'
        DataType = ftBoolean
      end
      item
        Name = 'Paid'
        DataType = ftBoolean
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
    Top = 392
  end
  object kbmRoomsDateDS: TDataSource
    DataSet = kbmRoomsDate_
    Left = 224
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
    Grid = grReservations
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
        Name = 'AvrageRate'
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
    Left = 80
    Top = 480
  end
  object RoomsDS: TDataSource
    DataSet = kbmRooms
    Left = 232
    Top = 480
  end
end
