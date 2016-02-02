object frmMaidActions: TfrmMaidActions
  Left = 1131
  Top = 260
  Caption = 'Housekeeping rules'
  ClientHeight = 409
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object wwDBGrid1: TDBGrid
    Left = 0
    Top = 40
    Width = 379
    Height = 317
    Align = alClient
    Constraints.MinWidth = 320
    DataSource = d.MaidActionsDS
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = wwDBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'maID'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'maAction'
        Title.Caption = 'Action'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'maDescription'
        Title.Caption = 'Description'
        Width = 231
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'maRule'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'maUse'
        Title.Caption = 'Use'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'maCross'
        Visible = False
      end>
  end
  object LMDStatusBar1: TStatusBar
    Left = 0
    Top = 390
    Width = 379
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 423
  end
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 379
    Height = 40
    Align = alTop
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      379
      40)
    object btnInsert: TsButton
      Left = 6
      Top = 7
      Width = 70
      Height = 26
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnInsertClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 77
      Top = 7
      Width = 71
      Height = 26
      Hint = 'Edit current record'
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnEditClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDelete: TsButton
      Left = 149
      Top = 7
      Width = 70
      Height = 26
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 2
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnClose: TsButton
      Left = 293
      Top = 7
      Width = 79
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 8
      TabOrder = 3
      OnClick = btnCloseClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 357
    Width = 379
    Height = 33
    Align = alBottom
    TabOrder = 3
    OnResize = panBtnResize
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = 390
    DesignSize = (
      379
      33)
    object BtnOk: TsButton
      Left = 198
      Top = 4
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCancel: TsButton
      Left = 287
      Top = 4
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object FormStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Position'
          'Top'
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\MaidActions'
    StorageType = stRegistry
    Left = 291
    Top = 208
  end
end
