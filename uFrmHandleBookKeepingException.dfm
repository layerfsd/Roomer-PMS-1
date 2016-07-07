object FrmHandleBookKeepingException: TFrmHandleBookKeepingException
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Problem posting invoice to Finances '
  ClientHeight = 674
  ClientWidth = 508
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 5
  Padding.Right = 5
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 5
    Top = 0
    Width = 498
    Height = 48
    Align = alTop
    Caption = 
      'There was a problem posting the invoice to your finance system. ' +
      #13#10'Please review the problem explanations below and select one of' +
      ' the available options.'
    ParentFont = False
    WordWrap = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ExplicitWidth = 446
  end
  object sPanel1: TsPanel
    Left = 5
    Top = 48
    Width = 498
    Height = 182
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 5
    Padding.Top = 15
    Padding.Right = 5
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sLabel4: TsLabel
      Left = 5
      Top = 15
      Width = 488
      Height = 16
      Align = alTop
      Caption = 'Problem Explanations:'
      ParentFont = False
      WordWrap = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ExplicitWidth = 142
    end
    object memExplanations: TsMemo
      Left = 5
      Top = 31
      Width = 488
      Height = 151
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      SkinData.SkinSection = 'EDIT'
    end
  end
  object sPanel2: TsPanel
    Left = 5
    Top = 230
    Width = 498
    Height = 411
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 5
    Padding.Top = 15
    Padding.Right = 5
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sLabel2: TsLabel
      Left = 56
      Top = 291
      Width = 423
      Height = 29
      AutoSize = False
      Caption = 'Retry will try again posting the invoice to the finance system.'
      WordWrap = True
    end
    object sLabel3: TsLabel
      Left = 56
      Top = 350
      Width = 423
      Height = 46
      AutoSize = False
      Caption = 
        'Although you ignore the problem you can always try posting the i' +
        'nvoice again when reviewing "Close Invoices"'
      WordWrap = True
    end
    object sLabel5: TsLabel
      Left = 113
      Top = 48
      Width = 366
      Height = 64
      AutoSize = False
      Caption = 
        'If there was a problem posting the invoice because of a unknown ' +
        'or wrong ID, then make the needed corrections and afterwards sel' +
        'ect "Retry posting the invoice"'
      WordWrap = True
    end
    object sLabel6: TsLabel
      Left = 113
      Top = 117
      Width = 366
      Height = 64
      AutoSize = False
      Caption = 
        'If there was a problem posting the invoice because of a unknown ' +
        'or wrong Account Key in Sales-Items, then make the needed correc' +
        'tions and afterwards select "Retry posting the invoice"'
      WordWrap = True
    end
    object sLabel7: TsLabel
      Left = 113
      Top = 184
      Width = 366
      Height = 64
      AutoSize = False
      Caption = 
        'If there was a problem posting the invoice because of a unknown ' +
        'or wrong Account Key in Pay Types, then make the needed correcti' +
        'ons and afterwards select "Retry posting the invoice"'
      WordWrap = True
    end
    object sLabel8: TsLabel
      Left = 5
      Top = 15
      Width = 117
      Height = 16
      Align = alTop
      Caption = 'Available Options:'
      ParentFont = False
      WordWrap = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object rbRetry: TsRadioButton
      Left = 32
      Top = 265
      Width = 140
      Height = 20
      Caption = 'Retry posting the invoice'
      TabOrder = 0
      OnClick = rbRetryClick
      SkinData.SkinSection = 'CHECKBOX'
    end
    object rbIgnore: TsRadioButton
      Left = 32
      Top = 324
      Width = 112
      Height = 20
      Caption = 'Ignore the problem'
      TabOrder = 1
      OnClick = rbRetryClick
      SkinData.SkinSection = 'CHECKBOX'
    end
    object sButton1: TsButton
      Left = 32
      Top = 46
      Width = 75
      Height = 25
      Caption = 'Customers'
      TabOrder = 2
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton2: TsButton
      Left = 32
      Top = 115
      Width = 75
      Height = 25
      Caption = 'Sales Items'
      TabOrder = 3
      OnClick = sButton2Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton3: TsButton
      Left = 32
      Top = 182
      Width = 75
      Height = 25
      Caption = 'Pay types'
      TabOrder = 4
      OnClick = sButton3Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object panBtn: TsPanel
    Left = 5
    Top = 641
    Width = 498
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      498
      33)
    object BtnOk: TsButton
      Left = 396
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Enabled = False
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
  end
end
