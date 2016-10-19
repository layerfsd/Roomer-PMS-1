object FrmCheckOut: TFrmCheckOut
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Check Out'
  ClientHeight = 296
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    AlignWithMargins = True
    Left = 16
    Top = 100
    Width = 323
    Height = 25
    Margins.Top = 100
    Alignment = taCenter
    Caption = 'Click [Checkout] button to confirm'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object panBtn: TsPanel
    Left = 0
    Top = 234
    Width = 626
    Height = 62
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'TRANSPARENT'
    DesignSize = (
      626
      62)
    object btnCancel: TsButton
      Left = 484
      Top = 30
      Width = 131
      Height = 25
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
    object BtnCheckOut: TsButton
      Left = 348
      Top = 30
      Width = 130
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'Checkout'
      Default = True
      Enabled = False
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      OnClick = BtnCheckOutClick
      SkinData.SkinSection = 'BUTTON'
    end
    object cbxForce: TsCheckBox
      Left = 348
      Top = 6
      Width = 235
      Height = 20
      Caption = 'Allow checkout in spite of open group invoice'
      TabOrder = 2
      Visible = False
      OnClick = cbxForceClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object pnlRoomBalance: TsPanel
    Left = 0
    Top = 0
    Width = 313
    Height = 234
    Align = alLeft
    BevelEdges = [beRight, beBottom]
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object __lblRoomBalance: TsLabel
      Left = 16
      Top = 24
      Width = 141
      Height = 16
      Caption = 'Room Invoice Balance'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel33: TsLabel
      Left = 129
      Top = 61
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = 'Room rent:'
    end
    object lbRoomRent: TsLabel
      Left = 193
      Top = 61
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
    end
    object lbSales: TsLabel
      Left = 193
      Top = 78
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
    end
    object sLabel36: TsLabel
      Left = 154
      Top = 78
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sales:'
    end
    object sLabel41: TsLabel
      Left = 150
      Top = 95
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Taxes:'
    end
    object lbTaxes: TsLabel
      Left = 193
      Top = 95
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
    end
    object sLabel38: TsLabel
      Left = 136
      Top = 116
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sub total:'
    end
    object sLabel40: TsLabel
      Left = 132
      Top = 132
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payments:'
    end
    object lbPAyments: TsLabel
      Left = 193
      Top = 132
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
    end
    object lbSubTotal: TsLabel
      Left = 193
      Top = 116
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
    end
    object lbBalance: TsLabel
      Left = 193
      Top = 153
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel42: TsLabel
      Left = 90
      Top = 153
      Width = 93
      Height = 13
      Alignment = taRightJustify
      Caption = 'Current balance:'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object Shape1: TShape
      Left = 189
      Top = 151
      Width = 86
      Height = 1
    end
    object Shape2: TShape
      Left = 189
      Top = 112
      Width = 86
      Height = 1
    end
    object lbCurrency: TsLabel
      Left = 249
      Top = 40
      Width = 24
      Height = 16
      Alignment = taRightJustify
      Caption = 'EUR'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object btnRoomInvoice: TsButton
      Left = 170
      Top = 172
      Width = 105
      Height = 25
      Caption = 'Invoice'
      TabOrder = 0
      OnClick = btnRoomInvoiceClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object pnlGroupBalance: TsPanel
    Left = 313
    Top = 0
    Width = 313
    Height = 234
    Align = alClient
    BevelEdges = [beBottom]
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object __lblGroupBalance: TsLabel
      Left = 16
      Top = 24
      Width = 143
      Height = 16
      Caption = 'Group Invoice Balance'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel2: TsLabel
      Left = 129
      Top = 61
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = 'Room rent:'
    end
    object lbRoomRentGr: TsLabel
      Left = 193
      Top = 61
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
    end
    object lbSalesGr: TsLabel
      Left = 193
      Top = 78
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
    end
    object sLabel5: TsLabel
      Left = 154
      Top = 78
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sales:'
    end
    object sLabel6: TsLabel
      Left = 150
      Top = 95
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Taxes:'
    end
    object lbTaxesGr: TsLabel
      Left = 193
      Top = 95
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
    end
    object sLabel8: TsLabel
      Left = 136
      Top = 116
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sub total:'
    end
    object sLabel9: TsLabel
      Left = 132
      Top = 132
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payments:'
    end
    object lbPaymentsGr: TsLabel
      Left = 193
      Top = 132
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
    end
    object lbSubTotalGr: TsLabel
      Left = 189
      Top = 114
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
    end
    object lbBalanceGr: TsLabel
      Left = 193
      Top = 153
      Width = 80
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel13: TsLabel
      Left = 90
      Top = 153
      Width = 93
      Height = 13
      Alignment = taRightJustify
      Caption = 'Current balance:'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object Shape3: TShape
      Left = 189
      Top = 112
      Width = 86
      Height = 1
    end
    object Shape4: TShape
      Left = 189
      Top = 151
      Width = 86
      Height = 1
    end
    object lbCurrencyGr: TsLabel
      Left = 249
      Top = 40
      Width = 24
      Height = 16
      Alignment = taRightJustify
      Caption = 'EUR'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object btnGroupInvoice: TsButton
      Left = 173
      Top = 172
      Width = 102
      Height = 25
      Caption = 'Invoice'
      TabOrder = 0
      OnClick = btnGroupInvoiceClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object StoreMain: TcxPropertiesStore
    Components = <
      item
        Properties.Strings = (
          'Checked')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Position'
          'Top'
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\CheckoutDialog'
    StorageType = stRegistry
    Left = 352
    Top = 120
  end
end
