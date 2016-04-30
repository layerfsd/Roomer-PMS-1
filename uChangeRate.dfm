object frmChangeRate: TfrmChangeRate
  Left = 1000
  Top = 316
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Change rate'
  ClientHeight = 266
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxLabel1: TsLabel
    Left = 8
    Top = 125
    Width = 219
    Height = 165
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Note :  '#13#10'If currency is changed without saving to currency tabl' +
      'e before leaving invoice, then changes will revert the next time' +
      ' the invoice is opened.'
    ParentFont = False
    WordWrap = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object cxLabel2: TsLabel
    Left = 10
    Top = 16
    Width = 58
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Currency :'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object cxLabel3: TsLabel
    Left = 13
    Top = 39
    Width = 55
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Rate :'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object labCurrency: TsLabel
    Left = 72
    Top = 13
    Width = 25
    Height = 21
    Caption = 'ISK'
    Color = clBtnFace
    ParentColor = False
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object Panel1: TsPanel
    Left = 0
    Top = 233
    Width = 240
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object btnOK: TsButton
      Left = 90
      Top = 4
      Width = 70
      Height = 25
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = cxButton2Click
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCancel: TsButton
      Left = 165
      Top = 4
      Width = 70
      Height = 25
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      OnClick = cxButton2Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object edRate: TsCalcEdit
    Left = 72
    Top = 37
    Width = 75
    Height = 21
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
  end
  object btnSave: TsButton
    Left = 157
    Top = 37
    Width = 70
    Height = 25
    Caption = 'Save'
    ImageIndex = 2
    Images = DImages.PngImageList1
    TabOrder = 2
    OnClick = btnSaveClick
    SkinData.SkinSection = 'BUTTON'
  end
  object btnGetFromWeb: TsButton
    Left = 8
    Top = 64
    Width = 219
    Height = 25
    Caption = 'Get from web service'
    ImageIndex = 100
    Images = DImages.PngImageList1
    TabOrder = 3
    OnClick = btnGetFromWebClick
    SkinData.SkinSection = 'BUTTON'
  end
  object cxButton1: TsButton
    Left = 8
    Top = 94
    Width = 219
    Height = 25
    Caption = 'Get from currencies'
    ImageIndex = 108
    Images = DImages.PngImageList1
    TabOrder = 4
    OnClick = cxButton1Click
    SkinData.SkinSection = 'BUTTON'
  end
end
