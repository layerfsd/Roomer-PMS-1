object FrmInvoiceLineEdit: TFrmInvoiceLineEdit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Invoice Article'
  ClientHeight = 295
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 112
    Top = 76
    Width = 26
    Height = 13
    Alignment = taRightJustify
    Caption = 'Item:'
  end
  object sLabel2: TsLabel
    Left = 112
    Top = 103
    Width = 26
    Height = 13
    Alignment = taRightJustify
    Caption = 'Text:'
  end
  object sLabel3: TsLabel
    Left = 56
    Top = 130
    Width = 82
    Height = 13
    Alignment = taRightJustify
    Caption = 'Number of items:'
  end
  object sLabel4: TsLabel
    Left = 111
    Top = 157
    Width = 27
    Height = 13
    Alignment = taRightJustify
    Caption = 'Price:'
  end
  object sLabel6: TsLabel
    Left = 104
    Top = 198
    Width = 34
    Height = 16
    Alignment = taRightJustify
    Caption = 'Total:'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object Shape1: TShape
    Left = 144
    Top = 184
    Width = 121
    Height = 2
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 257
    Width = 541
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      541
      38)
    object BtnOk: TsButton
      Left = 318
      Top = 6
      Width = 104
      Height = 28
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCancel: TsButton
      Left = 428
      Top = 6
      Width = 104
      Height = 28
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object edtText: TsEdit
    Left = 144
    Top = 100
    Width = 321
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    SkinData.SkinSection = 'EDIT'
  end
  object edtNumItems: TsCalcEdit
    Left = 144
    Top = 127
    Width = 121
    Height = 21
    AutoSize = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnChange = edtPriceChange
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
  end
  object edtPrice: TsCalcEdit
    Left = 144
    Top = 154
    Width = 121
    Height = 21
    AutoSize = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnChange = edtPriceChange
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 0
    Width = 541
    Height = 34
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 6
    SkinData.SkinSection = 'PANEL'
    object sLabel5: TsLabel
      Left = 12
      Top = 10
      Width = 109
      Height = 16
      Caption = 'New invoice item...'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
    end
  end
  object edtTotal: TsCalcEdit
    Left = 144
    Top = 195
    Width = 121
    Height = 23
    AutoSize = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    SkinData.SkinSection = 'EDIT'
    ShowButton = False
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
  end
  object edtItem: TcxButtonEdit
    Left = 144
    Top = 73
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ViewStyle = vsHideCursor
    Properties.OnButtonClick = edtItemPropertiesButtonClick
    Style.BorderStyle = ebsUltraFlat
    Style.ButtonStyle = btsUltraFlat
    TabOrder = 0
    Width = 121
  end
end
