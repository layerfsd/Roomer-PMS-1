object EditMaskForm: TEditMaskForm
  Left = 261
  Top = 119
  Caption = 'Input Mask Editor'
  ClientHeight = 219
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 216
    Top = 8
    Width = 72
    Height = 13
    Caption = 'Sample Masks:'
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 13
    Caption = 'Input Mask:'
  end
  object Label3: TLabel
    Left = 32
    Top = 64
    Width = 99
    Height = 13
    Caption = 'Character for Blanks:'
  end
  object LB_Masks: TListBox
    Left = 216
    Top = 24
    Width = 265
    Height = 150
    Style = lbOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 0
    OnClick = LB_MasksClick
    OnDrawItem = LB_MasksDrawItem
  end
  object Edt_InputMask: TEdit
    Left = 8
    Top = 24
    Width = 201
    Height = 21
    TabOrder = 1
  end
  object Edt_Blank: TEdit
    Left = 152
    Top = 61
    Width = 40
    Height = 21
    MaxLength = 1
    TabOrder = 2
    OnChange = Edt_BlankChange
  end
  object chk_SaveLiteral: TCheckBox
    Left = 8
    Top = 93
    Width = 137
    Height = 17
    Caption = '&Save Literal Characters'
    TabOrder = 3
    OnClick = chk_SaveLiteralClick
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 119
    Width = 203
    Height = 55
    TabOrder = 4
    object Label4: TLabel
      Left = 5
      Top = 9
      Width = 51
      Height = 13
      Caption = 'Test Input:'
    end
    object TntMEdit_TestInput: TTntMaskEdit
      Left = 6
      Top = 26
      Width = 189
      Height = 21
      TabOrder = 0
    end
  end
  object Btn_Masks: TButton
    Left = 18
    Top = 182
    Width = 75
    Height = 25
    Caption = '&Masks...'
    TabOrder = 5
    OnClick = Btn_MasksClick
  end
  object Btn_ok: TButton
    Left = 320
    Top = 182
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object Btn_Cancel: TButton
    Left = 400
    Top = 182
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object Dlg_OpenFile: TOpenDialog
    DefaultExt = '*.dem'
    Filter = 'Edit Masks (*.dem)|*.dem|All Files (*.*)|*.*'
    Left = 104
    Top = 176
  end
end
