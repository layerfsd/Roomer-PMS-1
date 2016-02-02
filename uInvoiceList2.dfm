object frmInvoiceList2: TfrmInvoiceList2
  Left = 738
  Top = 198
  Caption = 'Invoices'
  ClientHeight = 616
  ClientWidth = 1133
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSimplePanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1133
    Height = 183
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object btnReservation: TsButton
      Left = 113
      Top = 136
      Width = 100
      Height = 37
      Caption = 'Reservation'
      ImageIndex = 56
      Images = DImages.PngImageList1
      TabOrder = 2
      OnClick = btnReservationClick
      SkinData.SkinSection = 'BUTTON'
    end
    object LMDSpeedButton1: TsButton
      Left = 219
      Top = 136
      Width = 100
      Height = 37
      Caption = 'Guests'
      ImageIndex = 39
      Images = DImages.PngImageList1
      TabOrder = 3
      OnClick = LMDSpeedButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object LMDSpeedButton5: TsButton
      Left = 537
      Top = 136
      Width = 100
      Height = 37
      Caption = 'Export'
      HotImageIndex = 98
      ImageIndex = 98
      Images = DImages.PngImageList1
      TabOrder = 4
      OnClick = LMDSpeedButton5Click
      SkinData.SkinSection = 'BUTTON'
    end
    object btnViewInvoice: TsButton
      Left = 325
      Top = 136
      Width = 100
      Height = 37
      Caption = 'Invoice'
      ImageIndex = 63
      Images = DImages.PngImageList1
      TabOrder = 5
      OnClick = btnViewInvoiceClick
      SkinData.SkinSection = 'BUTTON'
    end
    object LMDSpeedButton6: TsButton
      Left = 7
      Top = 136
      Width = 100
      Height = 37
      Caption = 'EXCEL'
      ImageIndex = 132
      Images = DImages.PngImageList1
      TabOrder = 6
      OnClick = LMDSpeedButton6Click
      SkinData.SkinSection = 'BUTTON'
    end
    object LMDSpeedButton7: TsButton
      Left = 643
      Top = 136
      Width = 100
      Height = 37
      Caption = 'Export all'
      ImageIndex = 98
      Images = DImages.PngImageList1
      TabOrder = 7
      OnClick = LMDSpeedButton7Click
      SkinData.SkinSection = 'BUTTON'
    end
    object LMDButton1: TsButton
      Left = 855
      Top = 136
      Width = 100
      Height = 37
      Caption = 'Jump to room'
      ImageIndex = 57
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = LMDButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object LMDGroupBox1: TsGroupBox
      Left = 10
      Top = 10
      Width = 531
      Height = 120
      Caption = 'Search'
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object LMDSimpleLabel2: TsLabel
        Left = 251
        Top = 20
        Width = 11
        Height = 16
        Caption = 'to'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object LMDSimpleLabel3: TsLabel
        Left = 251
        Top = 44
        Width = 11
        Height = 16
        Caption = 'to'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object LMDSpeedButton3: TsButton
        Left = 251
        Top = 89
        Width = 122
        Height = 25
        Caption = 'Refresh'
        ImageIndex = 28
        Images = DImages.PngImageList1
        TabOrder = 9
        OnClick = LMDSpeedButton3Click
        SkinData.SkinSection = 'BUTTON'
      end
      object dtFrom: TsDateEdit
        Left = 146
        Top = 18
        Width = 102
        Height = 21
        AutoSize = False
        Color = clWhite
        Enabled = False
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
        OnChange = dtFromChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtTo: TsDateEdit
        Left = 285
        Top = 18
        Width = 102
        Height = 21
        AutoSize = False
        Color = clWhite
        Enabled = False
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
        OnChange = dtToChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object rbtDates: TsRadioButton
        Left = 4
        Top = 19
        Width = 79
        Height = 19
        Caption = 'Date range'
        TabOrder = 2
        OnClick = rbtDatesClick
        SkinData.SkinSection = 'CHECKBOX'
      end
      object rbtInvoices: TsRadioButton
        Left = 4
        Top = 42
        Width = 93
        Height = 19
        Caption = 'Number range'
        TabOrder = 3
        OnClick = rbtDatesClick
        SkinData.SkinSection = 'CHECKBOX'
      end
      object cbxPeriod: TsComboBox
        Left = 393
        Top = 18
        Width = 131
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csDropDownList
        Color = clWhite
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 4
        OnChange = cbxPeriodChange
        Items.Strings = (
          ' - None Selected -'
          'Today'
          'Yesterday'
          'In the last 5 Days'
          'In the last 10 Days'
          'In the this Week'
          'last Week'
          'In this Month'
          'Last Month'
          'In this Year'
          'Last Year'
          'From the beginning'
          ' ')
      end
      object edtFreeText: TsEdit
        Left = 146
        Top = 67
        Width = 241
        Height = 21
        Color = clWhite
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnChange = edtFreeTextChange
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object rbtFreeText: TsRadioButton
        Left = 4
        Top = 68
        Width = 72
        Height = 19
        Caption = 'Text filter'
        TabOrder = 6
        OnClick = rbtDatesClick
        SkinData.SkinSection = 'CHECKBOX'
      end
      object rbtLast: TsRadioButton
        Left = 4
        Top = 92
        Width = 45
        Height = 19
        Caption = 'Last'
        Checked = True
        TabOrder = 7
        TabStop = True
        OnClick = rbtDatesClick
        SkinData.SkinSection = 'CHECKBOX'
      end
      object cbxTxtType: TsComboBox
        Left = 393
        Top = 68
        Width = 131
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csDropDownList
        Color = clWhite
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 8
        OnChange = cbxTxtTypeChange
        Items.Strings = (
          'Invoice Number'
          'Customer number'
          'Name of Guest or Company'
          'Refernce'
          'Booking number'
          'Room Booking')
      end
      object edtLast: TsSpinEdit
        Left = 146
        Top = 91
        Width = 102
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnChange = edLastCountChange
        SkinData.SkinSection = 'EDIT'
        MaxValue = 99
        MinValue = 1
        Value = 0
      end
      object edtInvoiceFrom: TsSpinEdit
        Left = 146
        Top = 41
        Width = 102
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnChange = edtInvoiceFromChange
        SkinData.SkinSection = 'EDIT'
        MaxValue = 999999
        MinValue = 0
        Value = 0
      end
      object edtInvoiceTo: TsSpinEdit
        Left = 285
        Top = 42
        Width = 102
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        OnChange = edtInvoiceToChange
        SkinData.SkinSection = 'EDIT'
        MaxValue = 999999
        MinValue = 0
        Value = 0
      end
    end
    object sButton1: TsButton
      Left = 431
      Top = 136
      Width = 100
      Height = 37
      Caption = 'Print'
      ImageIndex = 3
      Images = DImages.PngImageList1
      TabOrder = 8
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton2: TsButton
      Left = 749
      Top = 136
      Width = 100
      Height = 37
      Caption = 'Best fit'
      Images = DImages.PngImageList1
      TabOrder = 9
      OnClick = sButton2Click
      SkinData.SkinSection = 'BUTTON'
    end
    object btnExport: TsButton
      Left = 550
      Top = 17
      Width = 118
      Height = 40
      Caption = 'Export invoices'
      TabOrder = 10
      OnClick = btnExportClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 183
    Width = 1133
    Height = 33
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object cLabFilter: TsLabel
      Left = 70
      Top = 9
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
      Left = 311
      Top = 6
      Width = 59
      Height = 21
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object edFilter: TsEdit
      Left = 107
      Top = 6
      Width = 206
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
  end
  object grInvoiceHead: TcxGrid
    Left = 0
    Top = 216
    Width = 1133
    Height = 400
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    object tvInvoiceHead: TcxGridDBBandedTableView
      OnDblClick = tvInvoiceHeadDblClick
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.PriorPage.Enabled = False
      Navigator.Buttons.Prior.Enabled = False
      Navigator.Buttons.Insert.Enabled = False
      Navigator.Buttons.Append.Enabled = False
      Navigator.Buttons.Delete.Enabled = False
      Navigator.Buttons.Edit.Enabled = False
      Navigator.Buttons.Post.Enabled = False
      Navigator.Buttons.Cancel.Enabled = False
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      DataController.DataSource = mDS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          FieldName = 'Amount'
          Column = tvInvoiceHeadAmount
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          FieldName = 'WithOutVAT'
          Column = tvInvoiceHeadWithOutVAT
        end
        item
          Format = ',0.00;-,0.00'
          FieldName = 'VAT'
          Column = tvInvoiceHeadVAT
        end
        item
        end
        item
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.HeaderAutoHeight = True
      OptionsView.Indicator = True
      Bands = <
        item
          Caption = 'Invoice'
          FixedKind = fkLeft
          Width = 592
        end
        item
          Caption = 'Amounts'
          Width = 650
        end
        item
          Caption = 'Customer'
        end
        item
          Caption = 'Other'
        end>
      object tvInvoiceHeadRowSelected: TcxGridDBBandedColumn
        DataBinding.FieldName = 'RowSelected'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
        IsCaptionAssigned = True
      end
      object tvInvoiceHeadInvoiceNumber: TcxGridDBBandedColumn
        Caption = 'Number'
        DataBinding.FieldName = 'InvoiceNumber'
        Options.Editing = False
        Width = 63
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvInvoiceHeadexternalInvoiceId: TcxGridDBBandedColumn
        Caption = 'External #'
        DataBinding.FieldName = 'externalInvoiceId'
        Width = 65
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvInvoiceHeadInvoiceDate: TcxGridDBBandedColumn
        Caption = 'Date'
        DataBinding.FieldName = 'InvoiceDate'
        Options.Editing = False
        Width = 63
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvInvoiceHeadDueDate: TcxGridDBBandedColumn
        Caption = 'Due Date'
        DataBinding.FieldName = 'DueDate'
        Options.Editing = False
        Width = 75
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvInvoiceHeadCreditType: TcxGridDBBandedColumn
        DataBinding.FieldName = 'CreditType'
        Options.Editing = False
        Width = 69
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvInvoiceHeadNameOnInvoice: TcxGridDBBandedColumn
        Caption = 'Name on Invoice'
        DataBinding.FieldName = 'NameOnInvoice'
        Options.Editing = False
        Width = 136
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object tvInvoiceHeadInvoicetype: TcxGridDBBandedColumn
        Caption = 'Type'
        DataBinding.FieldName = 'Invoicetype'
        Options.Editing = False
        Width = 67
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object tvInvoiceHeadLink: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Link'
        Options.Editing = False
        Width = 60
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object tvInvoiceHeadAmount: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Amount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        OnGetProperties = tvInvoiceHeadAmountGetProperties
        Options.Editing = False
        Width = 88
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvInvoiceHeadWithOutVAT: TcxGridDBBandedColumn
        Caption = 'Without VAT'
        DataBinding.FieldName = 'WithOutVAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        OnGetProperties = tvInvoiceHeadWithOutVATGetProperties
        Options.Editing = False
        Width = 83
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvInvoiceHeadVAT: TcxGridDBBandedColumn
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        OnGetProperties = tvInvoiceHeadVATGetProperties
        Options.Editing = False
        Width = 93
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvInvoiceHeadTaxes: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Taxes'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        OnGetProperties = tvInvoiceHeadTaxesGetProperties
        Options.Editing = False
        Width = 86
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvInvoiceHeadTaxunits: TcxGridDBBandedColumn
        Caption = 'Tax units'
        DataBinding.FieldName = 'Taxunits'
        Options.Editing = False
        Width = 66
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object tvInvoiceHeadCurrency: TcxGridDBBandedColumn
        Caption = 'Curr.'
        DataBinding.FieldName = 'Currency'
        Options.Editing = False
        Width = 36
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object tvInvoiceHeadCurrencyRate: TcxGridDBBandedColumn
        Caption = 'Rate'
        DataBinding.FieldName = 'CurrencyRate'
        Options.Editing = False
        Width = 62
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object tvInvoiceHeadCurrencyAmount: TcxGridDBBandedColumn
        Caption = 'Currency Amount'
        DataBinding.FieldName = 'CurrencyAmount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Options.Editing = False
        Width = 135
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object tvInvoiceHeadRoomGuest: TcxGridDBBandedColumn
        DataBinding.FieldName = 'RoomGuest'
        Options.Editing = False
        Width = 156
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvInvoiceHeadCustomer: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Customer'
        Options.Editing = False
        Width = 80
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvInvoiceHeadCompanyId: TcxGridDBBandedColumn
        DataBinding.FieldName = 'CompanyId'
        Options.Editing = False
        Width = 80
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvInvoiceHeadCustomerName: TcxGridDBBandedColumn
        DataBinding.FieldName = 'CustomerName'
        Options.Editing = False
        Width = 150
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvInvoiceHeadAddress1: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Address1'
        Options.Editing = False
        Width = 150
        Position.BandIndex = 2
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvInvoiceHeadAddress2: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Address2'
        Options.Editing = False
        Width = 150
        Position.BandIndex = 2
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object tvInvoiceHeadAddress3: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Address3'
        Options.Editing = False
        Width = 150
        Position.BandIndex = 2
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object tvInvoiceHeadRefrence: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Refrence'
        Options.Editing = False
        Width = 120
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvInvoiceHeadStaff: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Staff'
        Options.Editing = False
        Width = 37
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvInvoiceHeadConfirmdate: TcxGridDBBandedColumn
        Caption = 'Confirm date'
        DataBinding.FieldName = 'Confirmdate'
        Options.Editing = False
        Width = 64
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvInvoiceHeadReservation: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Reservation'
        Options.Editing = False
        Width = 64
        Position.BandIndex = 3
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvInvoiceHeadRoomReservation: TcxGridDBBandedColumn
        Caption = 'Room Reservation'
        DataBinding.FieldName = 'RoomReservation'
        Options.Editing = False
        Width = 64
        Position.BandIndex = 3
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
    end
    object lvInvoiceHead: TcxGridLevel
      GridView = tvInvoiceHead
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
    StorageName = 'Software\Roomer\FormStatus\InvoiceList2x'
    StorageType = stRegistry
    Left = 478
    Top = 328
  end
  object mDS: TDataSource
    DataSet = m22_
    Left = 184
    Top = 464
  end
  object m22_: TkbmMemTable
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
        Name = 'Customer'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'NameOnInvoice'
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
        Name = 'Refrence'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Amount'
        DataType = ftFloat
      end
      item
        Name = 'WithOutVAT'
        DataType = ftFloat
      end
      item
        Name = 'VAT'
        DataType = ftFloat
      end
      item
        Name = 'RoomGuest'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'InvoiceDate'
        DataType = ftDateTime
      end
      item
        Name = 'Confirmdate'
        DataType = ftDateTime
      end
      item
        Name = 'DueDate'
        DataType = ftDateTime
      end
      item
        Name = 'Staff'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'CompanyId'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'Currency'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'CurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'Taxes'
        DataType = ftFloat
      end
      item
        Name = 'Taxunits'
        DataType = ftInteger
      end
      item
        Name = 'CreditType'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'CurrencyAmount'
        DataType = ftFloat
      end
      item
        Name = 'Invoicetype'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Link'
        DataType = ftInteger
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'RowSelected'
        DataType = ftBoolean
      end
      item
        Name = 'externalInvoiceId'
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
    Left = 344
    Top = 432
  end
end
