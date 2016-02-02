object FrmCustomerDepartmentEdit: TFrmCustomerDepartmentEdit
  Left = 0
  Top = 0
  Caption = 'Customer Company Department'
  ClientHeight = 411
  ClientWidth = 588
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
  object sLabel1: TsLabel
    Left = 96
    Top = 24
    Width = 90
    Height = 13
    Alignment = taRightJustify
    Caption = 'Department name:'
  end
  object sLabel2: TsLabel
    Left = 143
    Top = 48
    Width = 43
    Height = 13
    Alignment = taRightJustify
    Caption = 'Address:'
  end
  object sLabel4: TsLabel
    Left = 168
    Top = 96
    Width = 18
    Height = 13
    Alignment = taRightJustify
    Caption = 'Zip:'
  end
  object sLabel5: TsLabel
    Left = 163
    Top = 120
    Width = 23
    Height = 13
    Alignment = taRightJustify
    Caption = 'City:'
  end
  object sLabel6: TsLabel
    Left = 143
    Top = 144
    Width = 43
    Height = 13
    Alignment = taRightJustify
    Caption = 'Country:'
  end
  object sLabel7: TsLabel
    Left = 123
    Top = 168
    Width = 63
    Height = 13
    Alignment = taRightJustify
    Caption = 'Telephone 1:'
  end
  object sLabel8: TsLabel
    Left = 123
    Top = 192
    Width = 63
    Height = 13
    Alignment = taRightJustify
    Caption = 'Telephone 2:'
  end
  object sLabel9: TsLabel
    Left = 164
    Top = 216
    Width = 22
    Height = 13
    Alignment = taRightJustify
    Caption = 'Fax:'
  end
  object sLabel10: TsLabel
    Left = 158
    Top = 240
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'Email:'
  end
  object sLabel11: TsLabel
    Left = 154
    Top = 264
    Width = 32
    Height = 13
    Alignment = taRightJustify
    Caption = 'Notes:'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 378
    Width = 588
    Height = 33
    Align = alBottom
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      588
      33)
    object btnCancel: TsButton
      Left = 500
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 409
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
  object edtDepartmentName: TsEdit
    Left = 192
    Top = 21
    Width = 233
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    SkinData.SkinSection = 'EDIT'
  end
  object edtAddress1: TsEdit
    Left = 192
    Top = 45
    Width = 233
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    SkinData.SkinSection = 'EDIT'
  end
  object edtAddress2: TsEdit
    Left = 192
    Top = 69
    Width = 233
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    SkinData.SkinSection = 'EDIT'
  end
  object edtZip: TsEdit
    Left = 192
    Top = 93
    Width = 233
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    SkinData.SkinSection = 'EDIT'
  end
  object edtCity: TsEdit
    Left = 192
    Top = 117
    Width = 233
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    SkinData.SkinSection = 'EDIT'
  end
  object edtCountry: TsEdit
    Left = 192
    Top = 141
    Width = 233
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    SkinData.SkinSection = 'EDIT'
  end
  object edtTelNo1: TsEdit
    Left = 192
    Top = 165
    Width = 233
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    SkinData.SkinSection = 'EDIT'
  end
  object edtTelNo2: TsEdit
    Left = 192
    Top = 189
    Width = 233
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    SkinData.SkinSection = 'EDIT'
  end
  object edtFax: TsEdit
    Left = 192
    Top = 213
    Width = 233
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    SkinData.SkinSection = 'EDIT'
  end
  object edtEmailAddress: TsEdit
    Left = 192
    Top = 237
    Width = 233
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    SkinData.SkinSection = 'EDIT'
  end
  object edtNotes: TsMemo
    Left = 192
    Top = 261
    Width = 329
    Height = 103
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    SkinData.SkinSection = 'EDIT'
  end
end
