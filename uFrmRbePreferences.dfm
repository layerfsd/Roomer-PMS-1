object frmRbePreferences: TfrmRbePreferences
  Left = 0
  Top = 0
  Caption = 'frmRbePreferences'
  ClientHeight = 344
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 344
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sLabelFX12: TsLabelFX
      Left = 7
      Top = 40
      Width = 84
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Alignment = taCenter
      Caption = 'User interface'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Angle = 0
      Shadow.OffsetKeeper.LeftTop = -1
      Shadow.OffsetKeeper.RightBottom = 3
    end
    object sLabel1: TsLabel
      Left = 63
      Top = 72
      Width = 58
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Alignment = taRightJustify
      Caption = 'Theme/Skin:'
    end
    object sLabel2: TsLabel
      Left = 73
      Top = 94
      Width = 48
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Alignment = taRightJustify
      Caption = 'Language:'
    end
    object sPanel1: TsPanel
      Left = 0
      Top = 0
      Width = 536
      Height = 37
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        536
        37)
      object btnClose: TsButton
        Left = 448
        Top = 7
        Width = 79
        Height = 25
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'Close'
        ImageIndex = 27
        Images = DImages.PngImageList1
        ModalResult = 8
        TabOrder = 0
        OnClick = btnCloseClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object __cbxSkins: TsComboBox
      Left = 132
      Top = 70
      Width = 109
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Alignment = taLeftJustify
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -13
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      Style = csDropDownList
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 1
      OnChange = __cbxSkinsChange
    end
    object __cbxLanguages: TsComboBox
      Left = 132
      Top = 92
      Width = 109
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Alignment = taLeftJustify
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -13
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      Style = csDropDownList
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 2
      OnChange = __cbxLanguagesChange
    end
  end
end
