object FrmPostInvoices: TFrmPostInvoices
  Left = 0
  Top = 0
  Caption = 'Post Invoices'
  ClientHeight = 314
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 72
    Top = 32
    Width = 101
    Height = 13
    Alignment = taRightJustify
    Caption = 'From Invoice number'
  end
  object sLabel2: TsLabel
    Left = 83
    Top = 59
    Width = 90
    Height = 13
    Alignment = taRightJustify
    Caption = 'To Invoice Number'
  end
  object sLabel4: TsLabel
    Left = 133
    Top = 86
    Width = 40
    Height = 13
    Alignment = taRightJustify
    Caption = 'Invoices'
  end
  object edtFrom: TsEdit
    Left = 216
    Top = 29
    Width = 57
    Height = 21
    Alignment = taRightJustify
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 0
    Text = '1000'
    SkinData.SkinSection = 'EDIT'
  end
  object edtTo: TsEdit
    Left = 216
    Top = 56
    Width = 57
    Height = 21
    Alignment = taRightJustify
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 1
    Text = '1000'
    SkinData.SkinSection = 'EDIT'
  end
  object btnProcess: TsButton
    Left = 216
    Top = 147
    Width = 137
    Height = 25
    Caption = 'Process'
    TabOrder = 2
    OnClick = btnProcessClick
    SkinData.SkinSection = 'BUTTON'
  end
  object pnlProcess: TsPanel
    Left = 0
    Top = 215
    Width = 554
    Height = 99
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    SkinData.SkinSection = 'PANEL'
    object sLabel3: TsLabel
      Left = 16
      Top = 6
      Width = 55
      Height = 13
      Caption = 'Processing:'
    end
    object lblInvoice: TsLabel
      Left = 83
      Top = 38
      Width = 12
      Height = 13
      Caption = '...'
    end
  end
  object edtInvoiceList: TsEdit
    Left = 216
    Top = 83
    Width = 313
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 4
    SkinData.SkinSection = 'EDIT'
  end
  object dlgSave: TSaveDialog
    DefaultExt = '.CSV'
    FileName = 'Invoices.CSV'
    Left = 472
    Top = 152
  end
end
