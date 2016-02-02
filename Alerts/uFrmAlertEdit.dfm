object FrmAlertEdit: TFrmAlertEdit
  Left = 0
  Top = 0
  Caption = 'Edit Alert'
  ClientHeight = 314
  ClientWidth = 508
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
    Left = 56
    Top = 28
    Width = 42
    Height = 13
    Alignment = taRightJustify
    Caption = 'Alert on:'
  end
  object sLabel2: TsLabel
    Left = 71
    Top = 52
    Width = 27
    Height = 13
    Alignment = taRightJustify
    Caption = 'Alert:'
  end
  object __cbxAlertOn: TsComboBox
    Left = 104
    Top = 25
    Width = 145
    Height = 21
    Alignment = taLeftJustify
    SkinData.SkinSection = 'COMBOBOX'
    VerticalAlignment = taAlignTop
    Style = csDropDownList
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 0
    Text = 'CHECK IN'
    Items.Strings = (
      'CHECK IN'
      'CHECK OUT'
      'OPEN RESERVATION')
  end
  object mmoText: TsMemo
    Left = 104
    Top = 52
    Width = 385
    Height = 181
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
  object sPanel1: TsPanel
    Left = 0
    Top = 280
    Width = 508
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object BtnOk: TsButton
      AlignWithMargins = True
      Left = 329
      Top = 3
      Width = 85
      Height = 28
      Hint = 'Apply and close'
      Align = alRight
      Caption = 'OK'
      Default = True
      ImageIndex = 82
      ModalResult = 1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCancel: TsButton
      AlignWithMargins = True
      Left = 420
      Top = 3
      Width = 85
      Height = 28
      Hint = 'Cancel and close'
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 4
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
  end
end
