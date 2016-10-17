object frmMaidActionsEdit: TfrmMaidActionsEdit
  Left = 1158
  Top = 221
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Housekeeping rule'
  ClientHeight = 266
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanBtn: TsPanel
    Left = 0
    Top = 226
    Width = 441
    Height = 40
    Align = alBottom
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = 221
    ExplicitWidth = 415
    DesignSize = (
      441
      40)
    object BtnOk: TsButton
      Left = 263
      Top = 6
      Width = 83
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 271
    end
    object btnCancel: TsButton
      Left = 351
      Top = 6
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 359
    end
  end
  object panTop: TsPanel
    Left = 0
    Top = 0
    Width = 441
    Height = 226
    Align = alClient
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 415
    ExplicitHeight = 105
    object sLabel1: TsLabel
      Left = 38
      Top = 30
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'Action:'
    end
    object sLabel2: TsLabel
      Left = 47
      Top = 86
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = 'Rule:'
    end
    object sLabel3: TsLabel
      Left = 15
      Top = 57
      Width = 57
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description:'
    end
    object cbActive: TDBCheckBox
      AlignWithMargins = True
      Left = 81
      Top = 4
      Width = 356
      Height = 17
      Margins.Left = 80
      Align = alTop
      Caption = 'Active'
      DataField = 'maUSE'
      TabOrder = 0
      ExplicitLeft = 76
      ExplicitTop = 8
      ExplicitWidth = 97
    end
    object edDescription: TsEdit
      AlignWithMargins = True
      Left = 81
      Top = 54
      Width = 356
      Height = 21
      Margins.Left = 80
      Align = alTop
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 76
      ExplicitTop = 31
      ExplicitWidth = 325
    end
    object edAction: TsEdit
      AlignWithMargins = True
      Left = 81
      Top = 27
      Width = 356
      Height = 21
      Margins.Left = 80
      Align = alTop
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ExplicitLeft = 76
      ExplicitTop = 31
      ExplicitWidth = 325
    end
    object edRule: TsMemo
      AlignWithMargins = True
      Left = 81
      Top = 81
      Width = 356
      Height = 141
      Margins.Left = 80
      Align = alClient
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      ExplicitWidth = 347
      ExplicitHeight = 136
    end
  end
end
