object frmInvoiceList: TfrmInvoiceList
  Left = 1113
  Top = 351
  Caption = 'Invoice Lists'
  ClientHeight = 628
  ClientWidth = 1017
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TsPanel
    Left = 0
    Top = 0
    Width = 1017
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    BevelWidth = 5
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object lblToDate: TsLabel
      Left = 261
      Top = 17
      Width = 12
      Height = 13
      Caption = 'To'
    end
    object lblToInvoice: TsLabel
      Left = 261
      Top = 45
      Width = 12
      Height = 13
      Caption = 'To'
      Enabled = False
    end
    object cLabFilter: TsLabel
      Left = 128
      Top = 100
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
      Left = 383
      Top = 97
      Width = 59
      Height = 21
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object RadioButton1: TsRadioButton
      Left = 18
      Top = 15
      Width = 117
      Height = 19
      Caption = 'By Date Range:'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RadioButton1Click
      AutoSize = False
      SkinData.SkinSection = 'CHECKBOX'
    end
    object RadioButton2: TsRadioButton
      Left = 18
      Top = 43
      Width = 118
      Height = 19
      Caption = 'By Number Range:'
      TabOrder = 3
      OnClick = RadioButton1Click
      AutoSize = False
      SkinData.SkinSection = 'CHECKBOX'
    end
    object dtFrom: TsDateEdit
      Left = 165
      Top = 14
      Width = 89
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
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
    object dtTo: TsDateEdit
      Left = 291
      Top = 14
      Width = 89
      Height = 21
      AutoSize = False
      BorderStyle = bsNone
      Color = clWhite
      EditMask = '!99/99/9999;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  -  -    '
      CheckOnExit = True
      SkinData.SkinSection = 'EDIT'
      GlyphMode.Blend = 0
      GlyphMode.Grayed = False
    end
    object edtInvoiceFrom: TsEdit
      Left = 165
      Top = 42
      Width = 89
      Height = 21
      Color = clWhite
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 4
      Text = '0'
      SkinData.SkinSection = 'EDIT'
    end
    object edtInvoiceTo: TsEdit
      Left = 291
      Top = 42
      Width = 89
      Height = 21
      Color = clWhite
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 5
      Text = '0'
      SkinData.SkinSection = 'EDIT'
    end
    object RadioButton3: TsRadioButton
      Left = 18
      Top = 72
      Width = 117
      Height = 19
      Caption = 'Specific Invoice:'
      TabOrder = 6
      OnClick = RadioButton1Click
      AutoSize = False
      SkinData.SkinSection = 'CHECKBOX'
    end
    object edtInvoice: TsEdit
      Left = 165
      Top = 70
      Width = 89
      Height = 21
      Color = clWhite
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 7
      Text = '0'
      SkinData.SkinSection = 'EDIT'
    end
    object sButton1: TsButton
      Left = 395
      Top = 12
      Width = 100
      Height = 25
      Caption = 'Refresh'
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 8
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 165
      Top = 97
      Width = 215
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
  end
  object Panel3: TsPanel
    Left = 0
    Top = 121
    Width = 1017
    Height = 507
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object grInvoices: TcxGrid
      Left = 1
      Top = 46
      Width = 1015
      Height = 460
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = False
      object tvInvoices: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.Insert.Enabled = False
        Navigator.Buttons.Append.Enabled = False
        Navigator.Buttons.Delete.Enabled = False
        Navigator.Buttons.Edit.Enabled = False
        Navigator.Buttons.Post.Enabled = False
        Navigator.InfoPanel.Visible = True
        Navigator.Visible = True
        OnCellDblClick = tvInvoicesCellDblClick
        DataController.DataSource = M_ds
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            FieldName = 'Amount'
            Column = tvInvoicesAmount
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        OptionsView.HeaderAutoHeight = True
        Bands = <
          item
            FixedKind = fkLeft
            Options.Moving = False
            Width = 407
          end
          item
          end>
        object tvInvoicesInvoiceNumber: TcxGridDBBandedColumn
          Caption = 'Number'
          DataBinding.FieldName = 'InvoiceNumber'
          Width = 72
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvInvoicesInvoicedate: TcxGridDBBandedColumn
          Caption = 'Date'
          DataBinding.FieldName = 'Invoicedate'
          Width = 99
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvInvoicesNameOnInvoice: TcxGridDBBandedColumn
          Caption = 'Name on invoice'
          DataBinding.FieldName = 'NameOnInvoice'
          Width = 148
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object tvInvoicesAmount: TcxGridDBBandedColumn
          DataBinding.FieldName = 'Amount'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          OnGetProperties = tvInvoicesAmountGetProperties
          Width = 88
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object tvInvoicesCustomer: TcxGridDBBandedColumn
          DataBinding.FieldName = 'Customer'
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvInvoicesinvRefrence: TcxGridDBBandedColumn
          Caption = 'Refrence'
          DataBinding.FieldName = 'invRefrence'
          Width = 84
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object tvInvoicesRoomGuest: TcxGridDBBandedColumn
          Caption = 'Guest'
          DataBinding.FieldName = 'RoomGuest'
          Width = 150
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvInvoicesihCurrency: TcxGridDBBandedColumn
          Caption = 'Currency'
          DataBinding.FieldName = 'ihCurrency'
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object tvInvoicesihCurrencyRate: TcxGridDBBandedColumn
          Caption = 'Currency Rate'
          DataBinding.FieldName = 'ihCurrencyRate'
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object tvInvoicesCreditInvoice: TcxGridDBBandedColumn
          Caption = 'Credit link'
          DataBinding.FieldName = 'CreditInvoice'
          Position.BandIndex = 1
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object tvInvoicesOriginalInvoice: TcxGridDBBandedColumn
          Caption = 'Original link'
          DataBinding.FieldName = 'OriginalInvoice'
          Position.BandIndex = 1
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object tvInvoicesReservation: TcxGridDBBandedColumn
          DataBinding.FieldName = 'Reservation'
          Width = 67
          Position.BandIndex = 1
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object tvInvoicesRoomReservation: TcxGridDBBandedColumn
          Caption = 'Room Reservation'
          DataBinding.FieldName = 'RoomReservation'
          Position.BandIndex = 1
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
      end
      object lvInvoices: TcxGridLevel
        GridView = tvInvoices
      end
    end
    object sPanel1: TsPanel
      Left = 1
      Top = 1
      Width = 1015
      Height = 45
      Align = alTop
      ShowCaption = False
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      object btnExcelTurnover: TsButton
        Left = 3
        Top = 4
        Width = 112
        Height = 37
        Caption = 'Excel'
        ImageIndex = 132
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = btnExcelTurnoverClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sButton2: TsButton
        Left = 121
        Top = 4
        Width = 112
        Height = 37
        Caption = 'Invoice'
        ImageIndex = 63
        Images = DImages.PngImageList1
        TabOrder = 1
        OnClick = sButton2Click
        SkinData.SkinSection = 'BUTTON'
      end
      object sButton3: TsButton
        Left = 239
        Top = 4
        Width = 112
        Height = 37
        Caption = 'Prenta'
        ImageIndex = 3
        Images = DImages.PngImageList1
        TabOrder = 2
        OnClick = sButton3Click
        SkinData.SkinSection = 'BUTTON'
      end
      object btnInvoiceListReservation: TsButton
        Left = 357
        Top = 4
        Width = 112
        Height = 37
        Caption = 'Reservation'
        ImageIndex = 56
        Images = DImages.PngImageList1
        TabOrder = 3
        OnClick = btnInvoiceListReservationClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object M_ds: TDataSource
    DataSet = m2_
    Left = 200
    Top = 336
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 392
    Top = 288
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
    end
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
    StorageName = 'Software\Roomer\FormStatus\InvoiceList'
    StorageType = stRegistry
    Left = 296
    Top = 288
  end
  object m2_: TkbmMemTable
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
        Name = 'InvoiceNumber'
        DataType = ftInteger
      end
      item
        Name = 'Invoicedate'
        DataType = ftDate
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'NameOnInvoice'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'Amount'
        DataType = ftFloat
      end
      item
        Name = 'CreditInvoice'
        DataType = ftInteger
      end
      item
        Name = 'OriginalInvoice'
        DataType = ftInteger
      end
      item
        Name = 'RoomGuest'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'ihCurrency'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'ihCurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'invRefrence'
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
    Left = 96
    Top = 296
  end
end
