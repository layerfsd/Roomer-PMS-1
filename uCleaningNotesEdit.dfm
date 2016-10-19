inherited frmCleaningNotesEdit: TfrmCleaningNotesEdit
  Caption = 'Edit Cleaning Note Rule'
  ClientHeight = 448
  ClientWidth = 610
  Font.Height = -11
  OnShow = FormShow
  ExplicitWidth = 626
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel [0]
    Left = 105
    Top = 44
    Width = 66
    Height = 13
    Alignment = taRightJustify
    Caption = 'Service Type:'
  end
  object lblOnceType: TsLabel [1]
    Left = 139
    Top = 71
    Width = 32
    Height = 13
    Alignment = taRightJustify
    Caption = 'When:'
  end
  object __lblInterval: TsLabel [2]
    Left = 104
    Top = 98
    Width = 67
    Height = 13
    Alignment = taRightJustify
    Caption = 'Days interval:'
  end
  object lblMinimumDays: TsLabel [3]
    Left = 66
    Top = 125
    Width = 105
    Height = 13
    Alignment = taRightJustify
    Caption = 'Minimum stay in days:'
  end
  object sLabel5: TsLabel [4]
    Left = 144
    Top = 178
    Width = 27
    Height = 13
    Alignment = taRightJustify
    Caption = 'Note:'
  end
  inherited dxStatusBar: TdxStatusBar
    Top = 428
    Width = 610
    ExplicitTop = 428
    ExplicitWidth = 610
  end
  object panBtn: TsPanel [6]
    Left = 0
    Top = 395
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
  object __cbxServiceType: TsComboBox [7]
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
  object __cbxOnceType: TsComboBox [8]
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
  object cbxActive: TsCheckBox [9]
    Left = 187
    Top = 18
    Width = 50
    Height = 20
    Caption = 'Active'
    TabOrder = 7
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object edtInterval: TsEdit [10]
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
  object edtMinimumDays: TsEdit [11]
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
  object edtMessage: TsMemo [12]
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
  object cbxOnlyWhenRoomIsDirty: TsCheckBox [13]
    Left = 187
    Top = 151
    Width = 155
    Height = 20
    Caption = 'Only when room is not clean'
    Checked = True
    State = cbChecked
    TabOrder = 4
    ImgChecked = 0
    ImgUnchecked = 0
  end
  inherited psRoomerBase: TcxPropertiesStore
    Left = 536
    Top = 80
  end
  inherited cxsrRoomerStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
    inherited dxssRoomerGridReportLink: TdxGridReportLinkStyleSheet
      BuiltIn = True
    end
    inherited cxssRoomerGridTableView: TcxGridTableViewStyleSheet
      BuiltIn = True
    end
  end
end
