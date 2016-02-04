object MaskEditTextForm: TMaskEditTextForm
  Left = 300
  Top = 277
  Width = 327
  Height = 142
  Caption = 'Mask Text Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 51
    Height = 13
    Caption = 'Input Text:'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 50
    Height = 13
    Caption = 'Edit Mask:'
  end
  object Lbl_EditMask: TLabel
    Left = 80
    Top = 48
    Width = 225
    Height = 13
    AutoSize = False
  end
  object TntMEdit_InputText: TTntMaskEdit
    Left = 80
    Top = 16
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object Btn_Ok: TButton
    Left = 80
    Top = 75
    Width = 75
    Height = 25
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Btn_Cancel: TButton
    Left = 160
    Top = 75
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
