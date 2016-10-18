object frmHiddenInfo: TfrmHiddenInfo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Hidden Information'
  ClientHeight = 379
  ClientWidth = 517
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Padding.Left = 5
  Padding.Top = 5
  Padding.Right = 5
  Padding.Bottom = 5
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object panTop: TsPanel
    Left = 5
    Top = 5
    Width = 507
    Height = 34
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      507
      34)
    object cxLabel1: TsLabel
      Left = 62
      Top = 10
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valid until :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnClose: TsButton
      Left = 376
      Top = 5
      Width = 124
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = btnCloseClick
      SkinData.SkinSection = 'BUTTON'
    end
    object dtDeleteOn: TsDateEdit
      Left = 119
      Top = 7
      Width = 121
      Height = 21
      AutoSize = False
      Color = clWhite
      EditMask = '!99/99/9999;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  -  -    '
      CheckOnExit = True
      SkinData.SkinSection = 'EDIT'
      GlyphMode.Blend = 0
      GlyphMode.Grayed = False
    end
  end
  object dxStatusBar1: TsStatusBar
    Left = 5
    Top = 348
    Width = 507
    Height = 26
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object cxPageControl1: TsPageControl
    Left = 5
    Top = 39
    Width = 507
    Height = 309
    ActivePage = tabInformation
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PAGECONTROL'
    object tabInformation: TsTabSheet
      Caption = 'Information'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object panInformation: TsPanel
        Left = 0
        Top = 0
        Width = 499
        Height = 34
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          499
          34)
        object btnRevert: TsButton
          Left = 7
          Top = 5
          Width = 100
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Undo'
          ImageIndex = 11
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnRevertClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object memNotes: TsMemo
        AlignWithMargins = True
        Left = 3
        Top = 37
        Width = 493
        Height = 241
        Align = alClient
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'EDIT'
      end
    end
    object tabViewLog: TsTabSheet
      Caption = 'Viewlog'
      ImageIndex = 1
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object panViewLog: TsPanel
        Left = 0
        Top = 0
        Width = 499
        Height = 11
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
      object memViewLog: TsMemo
        AlignWithMargins = True
        Left = 3
        Top = 14
        Width = 493
        Height = 264
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'EDIT'
      end
    end
  end
  object timClose: TTimer
    Enabled = False
    Interval = 1
    OnTimer = timCloseTimer
    Left = 592
    Top = 160
  end
end
