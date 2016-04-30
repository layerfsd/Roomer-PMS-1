object frmGoToRoomandDate: TfrmGoToRoomandDate
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Goto Room and date'
  ClientHeight = 195
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TsPanel
    Left = 0
    Top = 162
    Width = 332
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = 148
    ExplicitWidth = 280
    DesignSize = (
      332
      33)
    object cxButton1: TsButton
      Left = 137
      Top = 4
      Width = 96
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = cxButton1Click
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 200
    end
    object btnCancel: TsButton
      Left = 239
      Top = 4
      Width = 91
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 302
    end
  end
  object gbxFind: TsGroupBox
    Left = 11
    Top = 81
    Width = 313
    Height = 70
    Caption = 'Find by Refrence'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    SkinData.SkinSection = 'GROUPBOX'
    Checked = False
    object labErr: TsLabel
      Left = 9
      Top = 46
      Width = 4
      Height = 13
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object edRefrence: TsEdit
      Left = 196
      Top = 19
      Width = 104
      Height = 21
      Color = 3355443
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'EDIT'
    end
    object cbxRefrenceType: TsComboBox
      Left = 8
      Top = 19
      Width = 178
      Height = 21
      Alignment = taLeftJustify
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      Color = 3355443
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 1
      Text = 'Internal Room Reservation'
      Items.Strings = (
        'Internal Room Reservation'
        'Internal Reservation'
        'Invoice'
        'Booking refreance')
    end
  end
  object gbxGoto: TsGroupBox
    Left = 11
    Top = 3
    Width = 313
    Height = 73
    Caption = 'GoTo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    SkinData.SkinSection = 'GROUPBOX'
    Checked = False
    object cxLabel1: TsLabel
      Left = 150
      Top = 18
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Room : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxLabel2: TsLabel
      Left = 154
      Top = 45
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Date : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object edRoom: TsEdit
      Left = 196
      Top = 15
      Width = 104
      Height = 21
      Color = 3355443
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'EDIT'
    end
    object dtDate: TsDateEdit
      Left = 196
      Top = 42
      Width = 104
      Height = 21
      AutoSize = False
      Color = 3355443
      EditMask = '!99/99/9999;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
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
end
