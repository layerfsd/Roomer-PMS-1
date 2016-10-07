object frmEditRoomPrice: TfrmEditRoomPrice
  Left = 0
  Top = 0
  Caption = 'Edit roomprice'
  ClientHeight = 411
  ClientWidth = 647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TsPanel
    Left = 0
    Top = 0
    Width = 647
    Height = 136
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object gbxForAllDates: TsGroupBox
      Left = 16
      Top = 3
      Width = 410
      Height = 126
      Caption = 'Set for all dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      DesignSize = (
        410
        126)
      object clabRate: TsLabel
        Left = 4
        Top = 44
        Width = 99
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Rate : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object clabPriceCode: TsLabel
        Left = 4
        Top = 21
        Width = 99
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Price Code : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object clabDiscount: TsLabel
        Left = 4
        Top = 65
        Width = 99
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Discount : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sSpeedButton2: TsSpeedButton
        Left = 256
        Top = 19
        Width = 23
        Height = 20
        Caption = '...'
        OnClick = btnSelectPriceCodeClick
        SkinData.SkinSection = 'SPEEDBUTTON'
      end
      object labRecs: TsLabel
        Left = 8
        Top = 107
        Width = 4
        Height = 13
        Caption = '-'
      end
      object edPcCode: TsEdit
        Left = 109
        Top = 20
        Width = 141
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TextHint = 'dbl click to select from list'
        OnDblClick = btnSelectPriceCodeClick
        SkinData.SkinSection = 'EDIT'
      end
      object edRoomResDiscount: TsSpinEdit
        Left = 109
        Top = 63
        Width = 109
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        MaxValue = 999999
        MinValue = 0
        Value = 0
      end
      object cbxIsRoomResDiscountPrec: TsComboBox
        Left = 224
        Top = 63
        Width = 56
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
        TabOrder = 5
        Text = 'cbxIsRoomResDiscountPrec'
        Items.Strings = (
          '%')
      end
      object ApplyDiscount: TsButton
        Left = 286
        Top = 63
        Width = 99
        Height = 21
        Anchors = [akTop, akRight]
        Caption = 'Apply for all dates'
        TabOrder = 6
        OnClick = ApplyDiscountClick
        SkinData.SkinSection = 'BUTTON'
      end
      object edRate: TsCalcEdit
        Left = 109
        Top = 43
        Width = 171
        Height = 21
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object btnApplyRate: TsButton
        Left = 286
        Top = 41
        Width = 99
        Height = 21
        Anchors = [akTop, akRight]
        Caption = 'Apply for all dates'
        TabOrder = 3
        OnClick = btnApplyRateClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnApplyPriceCode: TsButton
        Left = 286
        Top = 18
        Width = 99
        Height = 21
        Anchors = [akTop, akRight]
        Caption = 'Apply for all dates'
        TabOrder = 1
        OnClick = btnApplyPriceCodeClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object sGroupBox1: TsGroupBox
      Left = 432
      Top = 3
      Width = 201
      Height = 126
      Caption = 'Room info'
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object clabRoom: TsLabel
        Left = 12
        Top = 16
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Room : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object clabRomType: TsLabel
        Left = 12
        Top = 34
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Room type : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cLabCurrency: TsLabel
        Left = 12
        Top = 51
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Currency : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cLabAuduts: TsLabel
        Left = 12
        Top = 69
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Adults : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cLabChildren: TsLabel
        Left = 12
        Top = 86
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Children : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cLabInfants: TsLabel
        Left = 12
        Top = 104
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Infants : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labRoom: TsLabel
        Left = 97
        Top = 16
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
      object labRoomType: TsLabel
        Left = 97
        Top = 34
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
      object labCurrency: TsLabel
        Left = 97
        Top = 51
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
      object labAudults: TsLabel
        Left = 97
        Top = 69
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
      object labChildren: TsLabel
        Left = 97
        Top = 86
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
      object labInfants: TsLabel
        Left = 97
        Top = 104
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
    end
  end
  object grRoomRates: TcxGrid
    Left = 0
    Top = 136
    Width = 647
    Height = 219
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = False
    object tvRoomRates: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = kbmRoomRatesDS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '###0.00;###0.00'
          Kind = skSum
          FieldName = 'Rate'
          Column = tvRoomRatesRate
        end
        item
          Format = '###0.00;###0.00'
          Kind = skAverage
          FieldName = 'Discount'
          Column = tvRoomRatesDiscount
        end
        item
          Format = '###0.00;###0.00'
          Kind = skSum
          FieldName = 'DiscountAmount'
          Column = tvRoomRatesDiscountAmount
        end
        item
          Format = '###0.00;###0.00'
          Kind = skSum
          FieldName = 'RentAmount'
          Column = tvRoomRatesRentAmount
        end
        item
          Format = '###0.00;###0.00'
          Kind = skSum
          FieldName = 'NativeAmount'
          Column = tvRoomRatesNativeAmount
        end
        item
          Format = '###0.00;###0.00'
          Kind = skAverage
          FieldName = 'RentAmount'
          Column = tvRoomRatesRentAmount
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsView.Footer = True
      OptionsView.FooterAutoHeight = True
      OptionsView.FooterMultiSummaries = True
      OptionsView.GroupByBox = False
      object tvRoomRatesReservation: TcxGridDBColumn
        DataBinding.FieldName = 'Reservation'
        Visible = False
      end
      object tvRoomRatesRoomReservation: TcxGridDBColumn
        DataBinding.FieldName = 'RoomReservation'
        Visible = False
      end
      object tvRoomRatesRoomNumber: TcxGridDBColumn
        Caption = 'Room'
        DataBinding.FieldName = 'RoomNumber'
        Visible = False
      end
      object tvRoomRatesRateDate: TcxGridDBColumn
        Caption = 'Date'
        DataBinding.FieldName = 'RateDate'
        Width = 92
      end
      object tvRoomRatesPriceCode: TcxGridDBColumn
        DataBinding.FieldName = 'PriceCode'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Width = 100
      end
      object tvRoomRatesRate: TcxGridDBColumn
        DataBinding.FieldName = 'Rate'
        PropertiesClassName = 'TcxCalcEditProperties'
        Width = 88
      end
      object tvRoomRatesDiscount: TcxGridDBColumn
        DataBinding.FieldName = 'Discount'
        PropertiesClassName = 'TcxCalcEditProperties'
        Width = 68
      end
      object tvRoomRatesisPercentage: TcxGridDBColumn
        Caption = 'is %'
        DataBinding.FieldName = 'isPercentage'
        Width = 43
      end
      object tvRoomRatesShowDiscount: TcxGridDBColumn
        DataBinding.FieldName = 'ShowDiscount'
        Visible = False
      end
      object tvRoomRatesisPaid: TcxGridDBColumn
        DataBinding.FieldName = 'isPaid'
        Visible = False
      end
      object tvRoomRatesDiscountAmount: TcxGridDBColumn
        Caption = 'Total Discount '
        DataBinding.FieldName = 'DiscountAmount'
        Options.Editing = False
        Width = 92
      end
      object tvRoomRatesRentAmount: TcxGridDBColumn
        Caption = 'Total'
        DataBinding.FieldName = 'RentAmount'
        Options.Editing = False
        Width = 83
      end
      object tvRoomRatesNativeAmount: TcxGridDBColumn
        Caption = 'Native currency'
        DataBinding.FieldName = 'NativeAmount'
        Options.Editing = False
        Width = 74
      end
    end
    object lvRoomRates: TcxGridLevel
      GridView = tvRoomRates
    end
  end
  object Panel2: TsPanel
    Left = 0
    Top = 355
    Width = 647
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object btnCancel: TsButton
      Left = 529
      Top = 6
      Width = 104
      Height = 44
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOK: TsButton
      Left = 16
      Top = 6
      Width = 157
      Height = 43
      Caption = 'Apply to this room'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      OnClick = btnOKClick
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton1: TsButton
      Left = 175
      Top = 6
      Width = 157
      Height = 43
      Caption = 'Apply all rooms of this Roomtytpe'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 2
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton2: TsButton
      Left = 338
      Top = 6
      Width = 157
      Height = 43
      Caption = 'Apply all rooms'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 3
      OnClick = sButton2Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object _kbmRoomRates: TkbmMemTable
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
        Name = 'RoomNumber'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'RateDate'
        DataType = ftDateTime
      end
      item
        Name = 'PriceCode'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Rate'
        DataType = ftFloat
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
        Name = 'ShowDiscount'
        DataType = ftBoolean
      end
      item
        Name = 'isPaid'
        DataType = ftBoolean
      end
      item
        Name = 'DiscountAmount'
        DataType = ftFloat
      end
      item
        Name = 'RentAmount'
        DataType = ftFloat
      end
      item
        Name = 'NativeAmount'
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
    BeforePost = _kbmRoomRatesBeforePost
    Left = 256
    Top = 194
  end
  object kbmRoomRatesDS: TDataSource
    DataSet = mRoomRates
    Left = 32
    Top = 242
  end
  object mRoomRates: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforePost = mRoomRatesBeforePost
    Left = 32
    Top = 183
    object mRoomRatesReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mRoomRatesroomreservation: TIntegerField
      FieldName = 'roomreservation'
    end
    object mRoomRatesRoomNumber: TStringField
      FieldName = 'RoomNumber'
      Size = 10
    end
    object mRoomRatesRateDate: TDateTimeField
      FieldName = 'RateDate'
    end
    object mRoomRatesPriceCode: TStringField
      FieldName = 'PriceCode'
      Size = 10
    end
    object mRoomRatesRate: TFloatField
      FieldName = 'Rate'
    end
    object mRoomRatesDiscount: TFloatField
      FieldName = 'Discount'
    end
    object mRoomRatesisPercentage: TBooleanField
      FieldName = 'isPercentage'
    end
    object mRoomRatesShowDiscount: TBooleanField
      FieldName = 'ShowDiscount'
    end
    object mRoomRatesisPaid: TBooleanField
      FieldName = 'isPaid'
    end
    object mRoomRatesDiscountAmount: TFloatField
      FieldName = 'DiscountAmount'
    end
    object mRoomRatesRentAmount: TFloatField
      FieldName = 'RentAmount'
    end
    object mRoomRatesNativeAmount: TFloatField
      FieldName = 'NativeAmount'
    end
  end
end
