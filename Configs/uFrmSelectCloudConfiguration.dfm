object FrmSelectCloudConfiguration: TFrmSelectCloudConfiguration
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Select Cloud Configuration'
  ClientHeight = 72
  ClientWidth = 481
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
    Left = 16
    Top = 13
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
    Left = 208
    Top = 10
    Width = 265
    Height = 24
    Alignment = taLeftJustify
    VerticalAlignment = taAlignTop
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = -1
    ParentFont = False
    TabOrder = 0
    OnChange = cbxEnvironmentChange
  end
  object btnOk: TsButton
    Left = 257
    Top = 40
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
  object sButton1: TsButton
    Left = 368
    Top = 40
    Width = 105
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
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
    Left = 32
    Top = 41
  end
end
