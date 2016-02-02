object frmMergePortfolios: TfrmMergePortfolios
  Left = 0
  Top = 0
  Caption = 'Merge Guest Portfolios'
  ClientHeight = 672
  ClientWidth = 1150
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGuest1: TsPanel
    Left = 0
    Top = 0
    Width = 573
    Height = 633
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'TRANSPARENT'
  end
  object pnlGuest2: TsPanel
    Left = 583
    Top = 0
    Width = 567
    Height = 633
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'TRANSPARENT'
  end
  object sPanel3: TsPanel
    Left = 573
    Top = 0
    Width = 10
    Height = 633
    Align = alLeft
    BevelOuter = bvNone
    Color = 8421440
    ParentBackground = False
    TabOrder = 2
    SkinData.CustomColor = True
    SkinData.SkinSection = 'TRANSPARENT'
  end
  object panBtn: TsPanel
    AlignWithMargins = True
    Left = 3
    Top = 636
    Width = 1144
    Height = 33
    Align = alBottom
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1144
      33)
    object btnCancel: TsButton
      Left = 1052
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 4
      ModalResult = 2
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 960
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ImageIndex = 82
      ModalResult = 1
      TabOrder = 1
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
end
