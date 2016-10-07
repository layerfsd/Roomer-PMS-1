object frmCleaningNotesEdit: TfrmCleaningNotesEdit
  Left = 0
  Top = 0
  Caption = 'Edit Cleaning Note Rule'
  ClientHeight = 434
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 105
    Top = 44
    Width = 66
    Height = 13
    Alignment = taRightJustify
    Caption = 'Service Type:'
  end
  object lblOnceType: TsLabel
    Left = 139
    Top = 71
    Width = 32
    Height = 13
    Alignment = taRightJustify
    Caption = 'When:'
  end
  object __lblInterval: TsLabel
    Left = 104
    Top = 98
    Width = 67
    Height = 13
    Alignment = taRightJustify
    Caption = 'Days interval:'
  end
  object lblMinimumDays: TsLabel
    Left = 66
    Top = 125
    Width = 105
    Height = 13
    Alignment = taRightJustify
    Caption = 'Minimum stay in days:'
  end
  object sLabel5: TsLabel
    Left = 144
    Top = 178
    Width = 27
    Height = 13
    Alignment = taRightJustify
    Caption = 'Note:'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 401
    Width = 610
    Height = 33
    Align = alBottom
    TabOrder = 6
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      610
      33)
    object btnCancel: TsButton
      Left = 518
      Top = 4
      Width = 85
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
      Left = 426
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object __cbxServiceType: TsComboBox
    Left = 187
    Top = 41
    Width = 145
    Height = 21
    Alignment = taLeftJustify
    VerticalAlignment = taAlignTop
    Style = csDropDownList
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 0
    Text = 'INTERVAL'
    OnCloseUp = __cbxServiceTypeCloseUp
    Items.Strings = (
      'INTERVAL'
      'ONCE')
  end
  object __cbxOnceType: TsComboBox
    Left = 187
    Top = 68
    Width = 145
    Height = 21
    Alignment = taLeftJustify
    VerticalAlignment = taAlignTop
    Style = csDropDownList
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 1
    Text = 'CHECK_IN_DAY'
    OnCloseUp = __cbxOnceTypeCloseUp
    Items.Strings = (
      'CHECK_IN_DAY'
      'DAY_BEFORE_CHECK_OUT'
      'CHECK_OUT_DAY'
      'XTH_DAY'
      'X_DAYS_AFTER_CHECK_OUT')
  end
  object cbxActive: TsCheckBox
    Left = 187
    Top = 18
    Width = 50
    Height = 20
    Caption = 'Active'
    TabOrder = 7
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object edtInterval: TsEdit
    Left = 187
    Top = 95
    Width = 58
    Height = 21
    Alignment = taRightJustify
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = '3'
  end
  object edtMinimumDays: TsEdit
    Left = 187
    Top = 122
    Width = 58
    Height = 21
    Alignment = taRightJustify
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '3'
  end
  object edtMessage: TsMemo
    Left = 187
    Top = 177
    Width = 324
    Height = 207
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object cbxOnlyWhenRoomIsDirty: TsCheckBox
    Left = 187
    Top = 151
    Width = 155
    Height = 20
    Caption = 'Only when room is not clean'
    TabOrder = 4
    ImgChecked = 0
    ImgUnchecked = 0
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
    StorageName = 'Software\Roomer\FormStatus\CleaningNotesEdit'
    StorageType = stRegistry
    Left = 539
    Top = 208
  end
end
