object FrmStaffNote: TFrmStaffNote
  Left = 0
  Top = 0
  Caption = 'Note for the day'
  ClientHeight = 537
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel3: TsLabel
    Left = 67
    Top = 139
    Width = 86
    Height = 19
    Alignment = taRightJustify
    Caption = 'Action type:'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sLabel4: TsLabel
    Left = 114
    Top = 171
    Width = 39
    Height = 19
    Alignment = taRightJustify
    Caption = 'Note:'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object panBtn: TsPanel
    Left = 0
    Top = 505
    Width = 657
    Height = 32
    Align = alBottom
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      657
      32)
    object btnCancel: TsButton
      Left = 578
      Top = 4
      Width = 75
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 500
      Top = 4
      Width = 75
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 657
    Height = 113
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sLabel1: TsLabel
      Left = 106
      Top = 16
      Width = 99
      Height = 19
      Alignment = taRightJustify
      Caption = 'Note for date:'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sLabel2: TsLabel
      Left = 123
      Top = 41
      Width = 82
      Height = 19
      Alignment = taRightJustify
      Caption = 'Created by:'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object lblNoteDate: TsLabel
      Left = 220
      Top = 16
      Width = 6
      Height = 19
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object lblAuthor: TsLabel
      Left = 220
      Top = 41
      Width = 6
      Height = 19
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object lblWhen: TsLabel
      Left = 220
      Top = 66
      Width = 6
      Height = 19
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sLabel6: TsLabel
      Left = 127
      Top = 66
      Width = 78
      Height = 19
      Alignment = taRightJustify
      Caption = 'Created at:'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
    end
  end
  object __cbxAction: TsComboBox
    Left = 166
    Top = 136
    Width = 427
    Height = 27
    Alignment = taLeftJustify
    SkinData.SkinSection = 'COMBOBOX'
    VerticalAlignment = taAlignTop
    Style = csDropDownList
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = -1
    ParentFont = False
    TabOrder = 2
    Items.Strings = (
      'NO_ACTION_NEEDED'
      'ACTION_NEEDED'
      'ACTION_FINISHED')
  end
  object mmoText: TsMemo
    Left = 166
    Top = 171
    Width = 427
    Height = 286
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    SkinData.SkinSection = 'EDIT'
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
    StorageName = 'Software\Roomer\FormStatus\StaffCommEdit'
    StorageType = stRegistry
    Left = 371
    Top = 264
  end
end
