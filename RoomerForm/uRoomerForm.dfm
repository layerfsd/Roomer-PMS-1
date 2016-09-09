object frmBaseRoomerForm: TfrmBaseRoomerForm
  Left = 0
  Top = 0
  Caption = 'Base Roomer Form'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 11
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 279
    Width = 635
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object psRoomerBase: TcxPropertiesStore
    Components = <
      item
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width'
          'WindowState')
      end>
    StorageName = 'cxPropertiesStore1'
    StorageType = stRegistry
    Left = 592
    Top = 8
  end
end
