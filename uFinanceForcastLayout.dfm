object frmFinanceForcast: TfrmFinanceForcast
  Left = 0
  Top = 0
  Caption = 'Finance Forcast Layout'
  ClientHeight = 191
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 128
    Width = 409
    Height = 63
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 120
    DesignSize = (
      409
      63)
    object sButton2: TsButton
      Left = 173
      Top = 30
      Width = 113
      Height = 31
      Anchors = [akRight, akBottom]
      Caption = 'Save and close'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
      ExplicitTop = 6
    end
    object sButton1: TsButton
      Left = 289
      Top = 29
      Width = 112
      Height = 31
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 436
      ExplicitTop = 5
    end
    object edDescription: TsEdit
      Left = 4
      Top = 3
      Width = 396
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnChange = edDescriptionChange
    end
  end
  object memText: TsMemo
    Left = 0
    Top = 0
    Width = 409
    Height = 128
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = memTextChange
    ExplicitTop = -3
  end
end
