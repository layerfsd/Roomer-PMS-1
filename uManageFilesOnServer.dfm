object frmManageFilesOnServer: TfrmManageFilesOnServer
  Left = 0
  Top = 0
  Caption = 'Manage Files'
  ClientHeight = 384
  ClientWidth = 497
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object lvfileList: TListView
    Left = 0
    Top = 31
    Width = 497
    Height = 353
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BorderStyle = bsNone
    Columns = <
      item
        Width = 7
      end
      item
        Caption = 'Filename'
        Width = 267
      end
      item
        Caption = 'Modified'
        Width = 133
      end
      item
        Caption = 'Type'
        Width = 133
      end
      item
        Alignment = taRightJustify
        Caption = 'Size'
        Width = 133
      end>
    FlatScrollBars = True
    GridLines = True
    HideSelection = False
    Items.ItemData = {
      05220000000100000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000
      00047400650073007400}
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    SmallImages = ImageList1
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lvfileListClick
    OnDblClick = lvfileListDblClick
    ExplicitWidth = 479
  end
  object Panel1: TsPanel
    Left = 0
    Top = 0
    Width = 497
    Height = 31
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 479
    object cbxFileTypes: TComboBox
      Left = 6
      Top = 7
      Width = 109
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Enabled = False
      ItemIndex = 0
      TabOrder = 0
      Text = 'Templates'
      OnChange = cbxFileTypesChange
      Items.Strings = (
        'Templates'
        'Images'
        'Contracts'
        'Roomer')
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 272
    Top = 424
    object D1: TMenuItem
      Caption = 'Download'
      Default = True
      OnClick = D1Click
    end
    object R1: TMenuItem
      Caption = 'Rename'
      OnClick = R1Click
    end
    object D2: TMenuItem
      Caption = 'Delete'
      OnClick = D2Click
    end
    object U1: TMenuItem
      Caption = 'Upload'
    end
  end
  object dlgSave: TsSaveDialog
    Left = 176
    Top = 392
  end
  object dlgPath: TsPathDialog
    Root = 'rfDesktop'
    Left = 232
    Top = 360
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
      end
      item
        Component = lvfileList
        Properties.Strings = (
          'Columns')
      end>
    StorageName = 'Software\Roomer\FormStatus\ManageFiles'
    StorageType = stRegistry
    Left = 318
    Top = 328
  end
  object ImageList1: TImageList
    Left = 136
    Top = 304
  end
end
