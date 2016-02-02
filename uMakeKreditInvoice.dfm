object frmMakeKreditInvoice: TfrmMakeKreditInvoice
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Create kredit Invoice'
  ClientHeight = 544
  ClientWidth = 703
  Color = clBtnFace
  Constraints.MinHeight = 450
  Constraints.MinWidth = 520
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 703
    Height = 359
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      703
      359)
    object sGroupBox2: TsGroupBox
      Left = 9
      Top = 10
      Width = 216
      Height = 79
      Caption = 'Create credit invoice by reference'
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object edInvoiceNumber: TsEdit
        Left = 9
        Top = 20
        Width = 110
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 0
        Text = '0'
        OnChange = edInvoiceNumberChange
        SkinData.SkinSection = 'EDIT'
      end
      object chkCreateNew: TsCheckBox
        Left = 8
        Top = 47
        Width = 136
        Height = 20
        Caption = 'Create new from orginal'
        TabOrder = 1
        OnClick = chkCreateNewClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object sPanel2: TsPanel
      Left = 1
      Top = 305
      Width = 701
      Height = 53
      Align = alBottom
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      object btnReservation: TsButton
        Left = 132
        Top = 10
        Width = 120
        Height = 36
        Caption = 'Reservation'
        ImageIndex = 56
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = btnReservationClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnPreviewOrginal: TsButton
        Left = 8
        Top = 10
        Width = 120
        Height = 36
        Caption = 'Preview Orginal'
        ImageIndex = 30
        Images = DImages.PngImageList1
        TabOrder = 1
        OnClick = btnPreviewOrginalClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClosedThisRoom: TsButton
        Left = 381
        Top = 10
        Width = 120
        Height = 36
        Caption = 'Closed this room'
        ImageIndex = 66
        Images = DImages.PngImageList1
        TabOrder = 2
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClosedThisRes: TsButton
        Left = 257
        Top = 10
        Width = 120
        Height = 36
        Caption = 'Closed this reservation'
        ImageIndex = 67
        Images = DImages.PngImageList1
        TabOrder = 3
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object sGroupBox1: TsGroupBox
      Left = 426
      Top = 10
      Width = 264
      Height = 103
      Caption = 'Dates'
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object sLabel2: TsLabel
        Left = 3
        Top = 17
        Width = 130
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Invoice date :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sLabel1: TsLabel
        Left = 3
        Top = 39
        Width = 130
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Due Date :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sSpeedButton1: TsSpeedButton
        Left = 136
        Top = 60
        Width = 115
        Height = 22
        Caption = 'Set as orginal date'
        OnClick = sSpeedButton1Click
        SkinData.SkinSection = 'SPEEDBUTTON'
      end
      object dtInvoiceDate: TsDateEdit
        Left = 139
        Top = 14
        Width = 113
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
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtPayDate: TsDateEdit
        Left = 139
        Top = 36
        Width = 113
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
        TabOrder = 1
        Text = '  .  .    '
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
    object sGroupBox3: TsGroupBox
      Left = 10
      Top = 134
      Width = 680
      Height = 165
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Orginal info'
      TabOrder = 3
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object __lblCustomer: TsLabel
        Left = 16
        Top = 21
        Width = 85
        Height = 18
        Caption = '00000 N/A'
        ParentFont = False
        Visible = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object __lblAddress1: TsLabel
        Left = 16
        Top = 45
        Width = 18
        Height = 13
        Caption = 'N/A'
        Visible = False
      end
      object __lblAddress2: TsLabel
        Left = 16
        Top = 64
        Width = 18
        Height = 13
        Caption = 'N/A'
        Visible = False
      end
      object __lblAddress3: TsLabel
        Left = 16
        Top = 83
        Width = 18
        Height = 13
        Caption = 'N/A'
        Visible = False
      end
      object __lblAddress4: TsLabel
        Left = 16
        Top = 102
        Width = 18
        Height = 13
        Caption = 'N/A'
        Visible = False
      end
      object lblRefrence: TsLabel
        Left = 16
        Top = 140
        Width = 65
        Height = 13
        AutoSize = False
        Caption = 'Reference : '
        Visible = False
      end
      object __lblRefrence: TsLabel
        Left = 86
        Top = 140
        Width = 18
        Height = 13
        Caption = 'N/A'
        Visible = False
      end
      object __lblEmailAddress: TsLabel
        Left = 17
        Top = 121
        Width = 18
        Height = 13
        Caption = 'N/A'
        Visible = False
      end
      object gbAmounts: TsGroupBox
        AlignWithMargins = True
        Left = 480
        Top = 18
        Width = 195
        Height = 142
        Align = alRight
        Caption = 'Amounts'
        Color = clBtnFace
        Ctl3D = True
        ParentBackground = False
        ParentColor = False
        ParentCtl3D = False
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object lblTotal: TsLabel
          Left = 19
          Top = 19
          Width = 34
          Height = 13
          Alignment = taRightJustify
          Caption = 'Total : '
        end
        object __lblTotal: TsLabel
          Left = 79
          Top = 19
          Width = 22
          Height = 13
          Caption = '0.00'
        end
        object __lblPayment: TsLabel
          Left = 19
          Top = 38
          Width = 172
          Height = 14
          AutoSize = False
          Caption = 'N/A'
        end
        object lblCurrency: TsLabel
          Left = 19
          Top = 58
          Width = 54
          Height = 13
          Alignment = taRightJustify
          Caption = 'Currency : '
        end
        object __lblCurrency: TsLabel
          Left = 79
          Top = 58
          Width = 90
          Height = 14
          AutoSize = False
          Caption = 'N/A'
        end
        object sGroupBox5: TsGroupBox
          AlignWithMargins = True
          Left = 5
          Top = 96
          Width = 185
          Height = 41
          Align = alBottom
          Caption = 'Reservation IDs'
          TabOrder = 0
          CaptionLayout = clTopCenter
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object __lblReservationIds: TsLabel
            Left = 14
            Top = 18
            Width = 18
            Height = 13
            Caption = 'N/A'
          end
        end
      end
    end
    object btnCancelChanges: TsButton
      Left = 231
      Top = 95
      Width = 189
      Height = 37
      Caption = 'Cancel chances'
      ImageIndex = 11
      Images = DImages.PngImageList1
      TabOrder = 4
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton1: TsButton
      Left = 10
      Top = 95
      Width = 215
      Height = 36
      Caption = 'Refresh'
      Default = True
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 5
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object btnWithoutRefr: TsButton
      Left = 231
      Top = 16
      Width = 189
      Height = 35
      Caption = 'New Credit invoice without reference'
      ImageIndex = 61
      Images = DImages.PngImageList1
      TabOrder = 6
      OnClick = btnWithoutRefrClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 501
    Width = 703
    Height = 43
    Align = alBottom
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      703
      43)
    object btnCancel: TsButton
      Left = 615
      Top = 4
      Width = 85
      Height = 29
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 485
      Top = 4
      Width = 127
      Height = 29
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'Create and print'
      Enabled = False
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object memExtratext: TsMemo
    Left = 0
    Top = 359
    Width = 703
    Height = 142
    Align = alClient
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    SkinData.SkinSection = 'EDIT'
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
    StorageName = 'Software\Roomer\FormStatus\makeCreditInvoice'
    StorageType = stRegistry
    Left = 293
    Top = 337
  end
  object kbmInvoiceHeads: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'SplitNumber'
        DataType = ftInteger
      end
      item
        Name = 'InvoiceNumber'
        DataType = ftInteger
      end
      item
        Name = 'InvoiceDate'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'name'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'Address1'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'Address2'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'Address3'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'Address4'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'Country'
        DataType = ftWideString
        Size = 4
      end
      item
        Name = 'Total'
        DataType = ftFloat
      end
      item
        Name = 'TotalWOVAT'
        DataType = ftFloat
      end
      item
        Name = 'TotalVAT'
        DataType = ftFloat
      end
      item
        Name = 'TotalBreakFast'
        DataType = ftFloat
      end
      item
        Name = 'ExtraText'
        DataType = ftWideMemo
      end
      item
        Name = 'Finished'
        DataType = ftBoolean
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
        Name = 'InvoiceType'
        DataType = ftInteger
      end
      item
        Name = 'ihTmp'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'custPID'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'RoomGuest'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'ihDate'
        DataType = ftDateTime
      end
      item
        Name = 'ihInvoiceDate'
        DataType = ftDateTime
      end
      item
        Name = 'ihConfirmDate'
        DataType = ftDateTime
      end
      item
        Name = 'ihPayDate'
        DataType = ftDateTime
      end
      item
        Name = 'ihStaff'
        DataType = ftWideString
        Size = 10
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
        Name = 'ReportDate'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ReportTime'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'invRefrence'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'TotalStayTax'
        DataType = ftFloat
      end
      item
        Name = 'TotalStayTaxNights'
        DataType = ftInteger
      end
      item
        Name = 'ShowPackage'
        DataType = ftBoolean
      end
      item
        Name = 'Location'
        DataType = ftWideString
        Size = 20
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.62.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 32
    Top = 336
  end
  object kbmInvoiceLines: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'AutoGen'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'SplitNumber'
        DataType = ftInteger
      end
      item
        Name = 'ItemNumber'
        DataType = ftInteger
      end
      item
        Name = 'PurchaseDate'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'InvoiceNumber'
        DataType = ftInteger
      end
      item
        Name = 'ItemID'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Number'
        DataType = ftFloat
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'Price'
        DataType = ftFloat
      end
      item
        Name = 'VATType'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Total'
        DataType = ftFloat
      end
      item
        Name = 'TotalWOVAT'
        DataType = ftFloat
      end
      item
        Name = 'VAT'
        DataType = ftFloat
      end
      item
        Name = 'AutoGenerated'
        DataType = ftBoolean
      end
      item
        Name = 'CurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'Currency'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'ReportDate'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ReportTime'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Persons'
        DataType = ftInteger
      end
      item
        Name = 'Nights'
        DataType = ftInteger
      end
      item
        Name = 'BreakfastPrice'
        DataType = ftInteger
      end
      item
        Name = 'Ayear'
        DataType = ftInteger
      end
      item
        Name = 'Amon'
        DataType = ftInteger
      end
      item
        Name = 'Aday'
        DataType = ftInteger
      end
      item
        Name = 'ilTmp'
        DataType = ftInteger
      end
      item
        Name = 'ilID'
        DataType = ftInteger
      end
      item
        Name = 'ilAccountKey'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'ItemCurrency'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'ItemCurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'Discount'
        DataType = ftFloat
      end
      item
        Name = 'Discount_isPrecent'
        DataType = ftBoolean
      end
      item
        Name = 'ImportRefrence'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'ImportSource'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'IsPackage'
        DataType = ftBoolean
      end
      item
        Name = 'confirmDate'
        DataType = ftDateTime
      end
      item
        Name = 'confirmAmount'
        DataType = ftFloat
      end
      item
        Name = 'ItemAdded'
        DataType = ftDateTime
      end
      item
        Name = 'RoomReservationAlias'
        DataType = ftInteger
      end
      item
        Name = 'invoiceIndex'
        DataType = ftInteger
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.62.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 128
    Top = 337
  end
  object InvoiceLinesDS: TDataSource
    DataSet = kbmInvoiceLines
    Left = 127
    Top = 384
  end
  object kbmPayments: TkbmMemTable
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
        Name = 'Person'
        DataType = ftInteger
      end
      item
        Name = 'AutoGen'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TypeIndex'
        DataType = ftInteger
      end
      item
        Name = 'InvoiceNumber'
        DataType = ftInteger
      end
      item
        Name = 'PayDate'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'PayType'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Amount'
        DataType = ftFloat
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'CurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'Currency'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ReportDate'
        DataType = ftString
        Size = 16
      end
      item
        Name = 'ReportTime'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Ayear'
        DataType = ftInteger
      end
      item
        Name = 'Amon'
        DataType = ftInteger
      end
      item
        Name = 'Aday'
        DataType = ftInteger
      end
      item
        Name = 'pmTmp'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'confirmDate'
        DataType = ftDateTime
      end
      item
        Name = 'Notes'
        DataType = ftWideMemo
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
    Version = '7.62.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 210
    Top = 337
  end
  object PaymentsDS: TDataSource
    DataSet = kbmPayments
    Left = 215
    Top = 384
  end
  object InvoiceHeadsDS: TDataSource
    DataSet = kbmInvoiceHeads
    Left = 31
    Top = 384
  end
end
