object frmCreditPrompt: TfrmCreditPrompt
  Left = 1140
  Top = 529
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 106
  ClientWidth = 231
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
  PixelsPerInch = 96
  TextHeight = 13
  object lblRefNumber: TLabel
    Left = 31
    Top = 42
    Width = 64
    Height = 13
    Alignment = taRightJustify
    Caption = 'Reference :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cxLabel1: TsLabel
    AlignWithMargins = True
    Left = 8
    Top = 6
    Width = 214
    Height = 27
    Alignment = taCenter
    AutoSize = False
    Caption = 'A new credit invoice will be made.'
    Color = clBtnFace
    ParentColor = False
    ParentFont = False
    WordWrap = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object Panel1: TsPanel
    Left = 0
    Top = 73
    Width = 231
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = 120
    ExplicitWidth = 230
    DesignSize = (
      231
      33)
    object btnOk: TsButton
      Left = 73
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 72
    end
    object btnCancel: TsButton
      Left = 154
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 153
    end
  end
  object edRefNumber: TsEdit
    Left = 101
    Top = 39
    Width = 105
    Height = 21
    Alignment = taCenter
    Color = clWhite
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    Text = '0'
    SkinData.SkinSection = 'EDIT'
  end
end
