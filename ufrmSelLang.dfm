object frmSelLang: TfrmSelLang
  Left = 1134
  Top = 357
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Select'
  ClientHeight = 113
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TsLabel
    Left = 16
    Top = 10
    Width = 76
    Height = 13
    Caption = 'Select language'
  end
  object Panel1: TsPanel
    Left = 0
    Top = 80
    Width = 284
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = 69
    ExplicitWidth = 282
    DesignSize = (
      284
      33)
    object BtnOk: TsButton
      Left = 98
      Top = 4
      Width = 85
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
      ExplicitLeft = 513
    end
    object btnCancel: TsButton
      Left = 192
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 607
    end
  end
  object cbxSelLang: TsComboBox
    Left = 16
    Top = 33
    Width = 259
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    DropDownCount = 30
    SkinData.SkinSection = 'COMBOBOX'
    Style = csDropDownList
    ItemIndex = -1
    ParentFont = False
    TabOrder = 1
  end
end
