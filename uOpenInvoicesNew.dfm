object frmOpenInvoicesNew: TfrmOpenInvoicesNew
  Left = 0
  Top = 0
  Caption = 'Open Invoices'
  ClientHeight = 628
  ClientWidth = 1070
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 1070
    Height = 85
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object btnExecute: TsButton
      Left = 151
      Top = 9
      Width = 100
      Height = 25
      Caption = 'Refresh'
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnExecuteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object chkShowNull: TsCheckBox
      Left = 152
      Top = 37
      Width = 158
      Height = 17
      Caption = 'Show invoices with 0 prices'
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object gbxSelectDates: TsGroupBox
      Left = 9
      Top = 0
      Width = 136
      Height = 80
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
      object dtedFrom: TsDateEdit
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
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtEdTo: TsDateEdit
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
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
  end
  object cxPageControl1: TsPageControl
    Left = 0
    Top = 85
    Width = 1070
    Height = 543
    ActivePage = sTabSheet2
    Align = alClient
    TabOrder = 1
    SkinData.SkinSection = 'PAGECONTROL'
    object sTabSheet2: TsTabSheet
      Caption = 'Rent'
      TabVisible = False
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 1062
        Height = 44
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnExcelRoomsDate: TsButton
          Left = 5
          Top = 2
          Width = 127
          Height = 39
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnExcelRoomsDateClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnReservationRoomsDate: TsButton
          Left = 137
          Top = 2
          Width = 127
          Height = 39
          Caption = 'Reservation'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnReservationRoomsDateClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnRoomRoomsDate: TsButton
          Left = 270
          Top = 2
          Width = 127
          Height = 39
          Caption = 'Guests'
          ImageIndex = 39
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = btnRoomRoomsDateClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton7: TsButton
          Left = 403
          Top = 2
          Width = 127
          Height = 39
          Caption = 'Group Invoice'
          ImageIndex = 60
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = sButton7Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton8: TsButton
          Left = 536
          Top = 2
          Width = 127
          Height = 39
          Caption = 'Room Invoice'
          ImageIndex = 62
          Images = DImages.PngImageList1
          TabOrder = 4
          OnClick = sButton8Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton9: TsButton
          Left = 669
          Top = 2
          Width = 127
          Height = 39
          Caption = 'Exclute from list'
          ImageIndex = 61
          Images = DImages.PngImageList1
          TabOrder = 5
          OnClick = sButton9Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grRoomsDate: TcxGrid
        Left = 0
        Top = 44
        Width = 1062
        Height = 489
        Align = alClient
        Images = DImages.PngImageList1
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvRoomsDate: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = RoomsDateDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Total'
              Column = tvRoomsDateTotal
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalItems'
              Column = tvRoomsDateTotalItems
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalRate'
              Column = tvRoomsDateTotalRate
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          object tvRoomsDateArrival: TcxGridDBColumn
            DataBinding.FieldName = 'Arrival'
            Width = 94
          end
          object tvRoomsDateDeparture: TcxGridDBColumn
            DataBinding.FieldName = 'Departure'
            Width = 89
          end
          object tvRoomsDateRoom: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
            Width = 71
          end
          object tvRoomsDateRoomType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'RoomType'
            Width = 42
          end
          object tvRoomsDateTotalRate: TcxGridDBColumn
            Caption = 'Room amount'
            DataBinding.FieldName = 'TotalRate'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvRoomsDateTotalRateGetProperties
            Width = 86
          end
          object tvRoomsDateTotalItems: TcxGridDBColumn
            Caption = 'Item Amount'
            DataBinding.FieldName = 'TotalItems'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvRoomsDateTotalItemsGetProperties
            Width = 76
          end
          object tvRoomsDateTotal: TcxGridDBColumn
            DataBinding.FieldName = 'Total'
            OnGetProperties = tvRoomsDateTotalGetProperties
          end
          object tvRoomsDateisGroupAccount: TcxGridDBColumn
            Caption = 'Group'
            DataBinding.FieldName = 'isGroupAccount'
          end
          object tvRoomsDatestatusDescription: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'statusDescription'
            Width = 122
          end
          object tvRoomsDateReservationName: TcxGridDBColumn
            Caption = 'Reservation name'
            DataBinding.FieldName = 'ReservationName'
            Width = 196
          end
          object tvRoomsDatecustomer: TcxGridDBColumn
            DataBinding.FieldName = 'customer'
            Width = 90
          end
          object tvRoomsDateGuestName: TcxGridDBColumn
            Caption = 'Guest'
            DataBinding.FieldName = 'GuestName'
            Width = 183
          end
          object tvRoomsDatediscount: TcxGridDBColumn
            DataBinding.FieldName = 'discount'
            Visible = False
          end
          object tvRoomsDateisPercentage: TcxGridDBColumn
            DataBinding.FieldName = 'isPercentage'
            Visible = False
          end
          object tvRoomsDateRoomRentPaymentInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'RoomRentPaymentInvoice'
          end
          object tvRoomsDateunPaidRoomRent: TcxGridDBColumn
            DataBinding.FieldName = 'unPaidRoomRent'
            Visible = False
          end
          object tvRoomsDateDiscountUnPaidRoomRent: TcxGridDBColumn
            DataBinding.FieldName = 'DiscountUnPaidRoomRent'
            Visible = False
          end
          object tvRoomsDateTotalUnpaidRoomRent: TcxGridDBColumn
            DataBinding.FieldName = 'TotalUnpaidRoomRent'
            Visible = False
          end
          object tvRoomsDateNameOnInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'NameOnInvoice'
            Visible = False
          end
          object tvRoomsDatecurrency: TcxGridDBColumn
            DataBinding.FieldName = 'currency'
            Width = 48
          end
          object tvRoomsDateCurrencyRate: TcxGridDBColumn
            Caption = 'Currency Rate'
            DataBinding.FieldName = 'CurrencyRate'
          end
          object tvRoomsDateisNoroom: TcxGridDBColumn
            DataBinding.FieldName = 'isNoroom'
            Visible = False
          end
          object tvRoomsDateroomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'roomReservation'
          end
          object tvRoomsDateReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
            Width = 77
          end
          object tvRoomsDateResFlag: TcxGridDBColumn
            DataBinding.FieldName = 'ResFlag'
            Visible = False
          end
        end
        object lvRoomsDate: TcxGridLevel
          GridView = tvRoomsDate
        end
      end
    end
  end
  object InvoiceLinesDS: TDataSource
    DataSet = kbmInvoiceLines_
    Left = 224
    Top = 200
  end
  object kbmInvoiceLines_: TkbmMemTable
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
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'Amount'
        DataType = ftFloat
      end
      item
        Name = 'currencyRate'
        DataType = ftFloat
      end
      item
        Name = 'statusDescription'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Arrival'
        DataType = ftDate
      end
      item
        Name = 'Departure'
        DataType = ftDate
      end
      item
        Name = 'isGroupAccount'
        DataType = ftBoolean
      end
      item
        Name = 'RoomRentPaymentInvoice'
        DataType = ftInteger
      end
      item
        Name = 'Status'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Currency'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'ReservationName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'GuestCount'
        DataType = ftInteger
      end
      item
        Name = 'room'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'roomType'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'isNoRoom'
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
    Left = 64
    Top = 192
  end
  object kbmRoomsDate_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'roomReservation'
        DataType = ftInteger
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'Room'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'RoomType'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'isNoroom'
        DataType = ftBoolean
      end
      item
        Name = 'ResFlag'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'currency'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'TotalRate'
        DataType = ftFloat
      end
      item
        Name = 'discount'
        DataType = ftFloat
      end
      item
        Name = 'isPercentage'
        DataType = ftBoolean
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
        Name = 'isGroupAccount'
        DataType = ftBoolean
      end
      item
        Name = 'RoomRentPaymentInvoice'
        DataType = ftInteger
      end
      item
        Name = 'customer'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'unPaidRoomRent'
        DataType = ftFloat
      end
      item
        Name = 'DiscountUnPaidRoomRent'
        DataType = ftFloat
      end
      item
        Name = 'TotalUnpaidRoomRent'
        DataType = ftFloat
      end
      item
        Name = 'ReservationName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'NameOnInvoice'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'TotalItems'
        DataType = ftFloat
      end
      item
        Name = 'Total'
        DataType = ftFloat
      end
      item
        Name = 'statusDescription'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'CurrencyRate'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'idxRoomreservation'
        Fields = 'Roomreservation'
      end
      item
        Name = 'idxReservation_roomreservation'
        Fields = 'Reservation;roomreservation'
      end>
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
    BeforePost = kbmRoomsDate_BeforePost
    Left = 56
    Top = 256
  end
  object RoomsDateDS: TDataSource
    DataSet = kbmRoomsDate_
    Left = 224
    Top = 264
  end
  object kbmGroupInvoiceLines_: TkbmMemTable
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
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'Amount'
        DataType = ftFloat
      end
      item
        Name = 'dtArrival'
        DataType = ftDateTime
      end
      item
        Name = 'dtDeparture'
        DataType = ftDateTime
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'ReservationName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'CurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'statusDescription'
        DataType = ftWideString
        Size = 100
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
    Left = 56
    Top = 336
  end
  object kbmGroupInvoiceLinesDS: TDataSource
    DataSet = kbmGroupInvoiceLines_
    Left = 224
    Top = 328
  end
end
