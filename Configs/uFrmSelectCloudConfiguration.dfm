object FrmSelectCloudConfiguration: TFrmSelectCloudConfiguration
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Select Cloud Configuration'
  ClientHeight = 239
  ClientWidth = 715
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 128
    Top = 61
    Width = 186
    Height = 16
    Alignment = taRightJustify
    Caption = 'Environment to be connected to:'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object cbxEnvironment: TsComboBox
    Left = 320
    Top = 58
    Width = 265
    Height = 24
    Alignment = taLeftJustify
    VerticalAlignment = taAlignTop
    Style = csDropDownList
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = -1
    ParentFont = False
    TabOrder = 0
    OnChange = cbxEnvironmentChange
  end
  object btnOk: TsButton
    Left = 480
    Top = 101
    Width = 105
    Height = 25
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object StoreMain: TcxPropertiesStore
    Active = False
    Components = <
      item
        Component = cbxEnvironment
        Properties.Strings = (
          'ItemIndex')
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
    StorageName = 'Software\Roomer\FormStatus\SelectEnvironment2'
    StorageType = stRegistry
    Left = 144
    Top = 113
  end
end
