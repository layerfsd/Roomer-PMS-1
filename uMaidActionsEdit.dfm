object frmMaidActionsEdit: TfrmMaidActionsEdit
  Left = 1158
  Top = 221
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Housekeeping scripts'
  ClientHeight = 261
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanBtn: TsPanel
    Left = 0
    Top = 221
    Width = 415
    Height = 40
    Align = alBottom
    TabOrder = 0
    OnResize = PanBtnResize
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      415
      40)
    object BtnOk: TsButton
      Left = 242
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
    end
    object btnCancel: TsButton
      Left = 330
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
    end
  end
  object panTop: TsPanel
    Left = 0
    Top = 0
    Width = 415
    Height = 63
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object LMDSimpleLabel2: TsLabel
      Left = 7
      Top = 15
      Width = 91
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Action name: '
    end
    object BDECountry: TDBEdit
      Left = 106
      Top = 12
      Width = 49
      Height = 21
      CharCase = ecUpperCase
      DataField = 'maAction'
      DataSource = d.MaidActionsDS
      MaxLength = 5
      TabOrder = 0
    end
    object DBECountryName: TDBEdit
      Left = 160
      Top = 12
      Width = 233
      Height = 21
      DataField = 'maDescription'
      DataSource = d.MaidActionsDS
      TabOrder = 1
    end
    object wwCheckBox1: TDBCheckBox
      Left = 108
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Active'
      DataField = 'maUSE'
      DataSource = d.MaidActionsDS
      TabOrder = 2
    end
  end
  object DBMemo1: TDBMemo
    Left = 0
    Top = 63
    Width = 415
    Height = 158
    Align = alClient
    DataField = 'maRule'
    DataSource = d.MaidActionsDS
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    WordWrap = False
  end
end
