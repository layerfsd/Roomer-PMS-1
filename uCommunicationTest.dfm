object frmCommunicationTest: TfrmCommunicationTest
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Communication Test'
  ClientHeight = 393
  ClientWidth = 648
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object sPanel1: TsPanel
    Left = 0
    Top = 357
    Width = 648
    Height = 36
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      648
      36)
    object lblTestsStopped: TsLabel
      Left = 7
      Top = 12
      Width = 313
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Tests were stopped after the maximum of 50 rotations.'
      ParentFont = False
      Visible = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      UseSkinColor = False
    end
    object btnClose: TsButton
      Left = 586
      Top = 5
      Width = 56
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Close'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 8
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 0
    Width = 648
    Height = 357
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sSplitter1: TsSplitter
      Left = 325
      Top = 0
      Height = 357
      SkinData.SkinSection = 'SPLITTER'
    end
    object sPanel3: TsPanel
      Left = 0
      Top = 0
      Width = 325
      Height = 357
      Align = alLeft
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object sPanel4: TsPanel
        Left = 1
        Top = 1
        Width = 323
        Height = 50
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          323
          50)
        object sLabel1: TsLabel
          Left = 1
          Top = 1
          Width = 321
          Height = 13
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          Alignment = taCenter
          Caption = 'Test Log'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ExplicitWidth = 48
        end
        object sButton1: TsButton
          Left = 253
          Top = 18
          Width = 57
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akTop, akRight]
          Caption = 'Copy'
          ImageIndex = 7
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton1Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnStopStart: TsButton
          Left = 6
          Top = 18
          Width = 56
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Start'
          ImageIndex = 102
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnStopStartClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object mmoLogs: TsMemo
        AlignWithMargins = True
        Left = 9
        Top = 59
        Width = 307
        Height = 289
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alClient
        Color = 3355443
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 15724527
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'EDIT'
      end
    end
    object sPanel5: TsPanel
      Left = 331
      Top = 0
      Width = 317
      Height = 357
      Align = alClient
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      object sPanel6: TsPanel
        Left = 1
        Top = 1
        Width = 315
        Height = 50
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          315
          50)
        object sLabel2: TsLabel
          Left = 1
          Top = 1
          Width = 313
          Height = 13
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          Alignment = taCenter
          Caption = 'Top Delays'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ExplicitWidth = 62
        end
        object sButton2: TsButton
          Left = 243
          Top = 18
          Width = 57
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akTop, akRight]
          Caption = 'Copy'
          ImageIndex = 7
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton2Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object mmoTop: TsMemo
        AlignWithMargins = True
        Left = 2
        Top = 59
        Width = 306
        Height = 289
        Margins.Left = 1
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alClient
        Color = 3355443
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 15724527
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
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
  object timTest: TTimer
    Enabled = False
    Interval = 200
    OnTimer = timTestTimer
    Left = 64
    Top = 248
  end
end
