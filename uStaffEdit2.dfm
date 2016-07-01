object frmStaffEdit2: TfrmStaffEdit2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Staff'
  ClientHeight = 520
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Padding.Left = 5
  Padding.Top = 5
  Padding.Right = 5
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object panBtn: TsPanel
    Left = 5
    Top = 487
    Width = 470
    Height = 33
    Align = alBottom
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      470
      33)
    object btnCancel: TsButton
      Left = 378
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
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 286
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
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object pageMain: TsPageControl
    Left = 5
    Top = 5
    Width = 470
    Height = 482
    ActivePage = sTabSheet2
    Align = alClient
    Style = tsFlatButtons
    TabHeight = 25
    TabOrder = 1
    TabWidth = 100
    SkinData.SkinSection = 'PAGECONTROL'
    object sTabSheet1: TsTabSheet
      Caption = 'Main'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object gbxGuest: TsGroupBox
        Left = 0
        Top = 0
        Width = 462
        Height = 72
        Align = alTop
        Caption = 'Login information'
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object clabInitials: TsLabel
          Left = 2
          Top = 18
          Width = 159
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Username :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object clabPassword: TsLabel
          Left = 2
          Top = 44
          Width = 159
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Password :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edInitials: TsEdit
          Left = 165
          Top = 15
          Width = 113
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
        object edPassword: TsEdit
          Left = 165
          Top = 41
          Width = 113
          Height = 21
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          SkinData.SkinSection = 'EDIT'
        end
        object chkActive: TsCheckBox
          Left = 287
          Top = 17
          Width = 50
          Height = 20
          Caption = 'Active'
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkPmsOnly: TsCheckBox
          Left = 374
          Top = 17
          Width = 63
          Height = 20
          Caption = 'PMS only'
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkWindowsAuth: TsCheckBox
          Left = 287
          Top = 42
          Width = 94
          Height = 20
          Caption = 'Windows audth'
          TabOrder = 4
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object cbxName: TsGroupBox
        AlignWithMargins = True
        Left = 0
        Top = 76
        Width = 462
        Height = 71
        Margins.Left = 0
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Name'
        TabOrder = 1
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        DesignSize = (
          462
          71)
        object clabName: TsLabel
          Left = 2
          Top = 44
          Width = 159
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Name :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object clabStaffPID: TsLabel
          Left = 2
          Top = 19
          Width = 159
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Personal Id :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edName: TsEdit
          Left = 165
          Top = 41
          Width = 311
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          SkinData.SkinSection = 'EDIT'
        end
        object edStaffPID: TsEdit
          Left = 165
          Top = 16
          Width = 113
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
      end
      object gbxAddress: TsGroupBox
        AlignWithMargins = True
        Left = 0
        Top = 151
        Width = 462
        Height = 111
        Margins.Left = 0
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Address'
        TabOrder = 2
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        DesignSize = (
          462
          111)
        object edAddress1: TsEdit
          Left = 165
          Top = 12
          Width = 342
          Height = 21
          Anchors = [akLeft, akTop, akRight]
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
        object edAddress2: TsEdit
          Left = 165
          Top = 36
          Width = 342
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          SkinData.SkinSection = 'EDIT'
        end
        object edAddress3: TsEdit
          Left = 165
          Top = 59
          Width = 342
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          SkinData.SkinSection = 'EDIT'
        end
        object edAddress4: TsEdit
          Left = 165
          Top = 83
          Width = 342
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          SkinData.SkinSection = 'EDIT'
        end
      end
      object gbxLanguage: TsGroupBox
        AlignWithMargins = True
        Left = 0
        Top = 360
        Width = 462
        Height = 72
        Margins.Left = 0
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Language'
        TabOrder = 3
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object clabStaffLanguage: TsLabel
          Left = 107
          Top = 44
          Width = 54
          Height = 13
          Alignment = taRightJustify
          Caption = 'Language :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object clabCountry: TsLabel
          Left = 2
          Top = 19
          Width = 159
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Country :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object btnGetGountry: TsSpeedButton
          Left = 257
          Top = 16
          Width = 20
          Height = 20
          Caption = '..'
          OnClick = btnGetGountryClick
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object labCountry: TsLabel
          Left = 287
          Top = 20
          Width = 4
          Height = 13
          Caption = '-'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labStaffLanguage: TsLabel
          Left = 287
          Top = 44
          Width = 4
          Height = 13
          Caption = '-'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edCountry: TsEdit
          Left = 165
          Top = 16
          Width = 90
          Height = 21
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnDblClick = btnGetGountryClick
          SkinData.SkinSection = 'EDIT'
        end
        object __cbxLanguage: TsComboBox
          Left = 165
          Top = 41
          Width = 112
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taLeftJustify
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          DropDownCount = 30
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
        end
      end
      object cbxContact: TsGroupBox
        AlignWithMargins = True
        Left = 0
        Top = 266
        Width = 462
        Height = 90
        Margins.Left = 0
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Contact Information'
        TabOrder = 4
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        DesignSize = (
          462
          90)
        object gbxContact: TsLabel
          Left = 2
          Top = 18
          Width = 159
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Phone : '
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object clabTel2: TsLabel
          Left = 284
          Top = 18
          Width = 47
          Height = 13
          AutoSize = False
          Caption = 'Phone : '
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object clabFax: TsLabel
          Left = 2
          Top = 41
          Width = 159
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Mobile : '
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object clabEmail: TsLabel
          Left = 2
          Top = 64
          Width = 159
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'E-mail :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edFax: TsEdit
          Left = 165
          Top = 38
          Width = 113
          Height = 21
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          SkinData.SkinSection = 'EDIT'
        end
        object edTel2: TsEdit
          Left = 328
          Top = 15
          Width = 179
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          SkinData.SkinSection = 'EDIT'
        end
        object edTel1: TsEdit
          Left = 165
          Top = 15
          Width = 113
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
        object edEmailAddress: TsEdit
          Left = 165
          Top = 61
          Width = 342
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
    object sTabSheet2: TsTabSheet
      Caption = 'Authorization'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object sGroupBox2: TsGroupBox
        AlignWithMargins = True
        Left = 0
        Top = 157
        Width = 462
        Height = 115
        Margins.Left = 0
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'IP restrictions'
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object memIPAddresses: TsMemo
          Left = 2
          Top = 48
          Width = 458
          Height = 65
          Align = alClient
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
        object sPanel1: TsPanel
          Left = 2
          Top = 15
          Width = 458
          Height = 33
          Align = alTop
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
          object btnAddCurrent: TsButton
            Left = 2
            Top = 4
            Width = 100
            Height = 25
            Caption = 'Add current'
            TabOrder = 0
            OnClick = btnAddCurrentClick
            SkinData.SkinSection = 'BUTTON'
          end
        end
      end
      object sGroupBox1: TsGroupBox
        AlignWithMargins = True
        Left = 0
        Top = 4
        Width = 462
        Height = 149
        Margins.Left = 0
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Authorization'
        TabOrder = 1
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object cLabStaffType: TsLabel
          Left = 0
          Top = 22
          Width = 159
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = '1 :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labStaffType: TsLabel
          Left = 287
          Top = 22
          Width = 4
          Height = 13
          Caption = '-'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cLabStaffType1: TsLabel
          Left = 2
          Top = 46
          Width = 159
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = '2 :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labStaffType1: TsLabel
          Left = 287
          Top = 46
          Width = 4
          Height = 13
          Caption = '-'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cLabStaffType2: TsLabel
          Left = 2
          Top = 68
          Width = 159
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = '3 :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cLabStaffType3: TsLabel
          Left = 2
          Top = 91
          Width = 159
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = '4 :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labStaffType2: TsLabel
          Left = 287
          Top = 68
          Width = 4
          Height = 13
          Caption = '-'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labStaffType3: TsLabel
          Left = 287
          Top = 91
          Width = 4
          Height = 13
          Caption = '-'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sSpeedButton1: TsSpeedButton
          Left = 257
          Top = 20
          Width = 20
          Height = 18
          Caption = '..'
          OnClick = btnGetStaffTypeClick
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object sSpeedButton2: TsSpeedButton
          Left = 257
          Top = 43
          Width = 20
          Height = 18
          Caption = '..'
          OnClick = btnGetStaffType1Click
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object sSpeedButton3: TsSpeedButton
          Left = 257
          Top = 66
          Width = 20
          Height = 18
          Caption = '..'
          OnClick = btnGetStaffType2Click
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object sSpeedButton4: TsSpeedButton
          Left = 257
          Top = 89
          Width = 20
          Height = 18
          Caption = '..'
          OnClick = btnGetStaffType3Click
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object cLabStaffType4: TsLabel
          Left = 0
          Top = 115
          Width = 159
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = '5 :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sSpeedButton5: TsSpeedButton
          Left = 257
          Top = 111
          Width = 20
          Height = 19
          Caption = '..'
          OnClick = btnGetStaffType4Click
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object labStaffType4: TsLabel
          Left = 287
          Top = 115
          Width = 4
          Height = 13
          Caption = '-'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edStaffType: TsEdit
          Left = 165
          Top = 20
          Width = 92
          Height = 21
          CharCase = ecUpperCase
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnDblClick = btnGetStaffTypeClick
          SkinData.SkinSection = 'EDIT'
        end
        object edStaffType1: TsEdit
          Left = 165
          Top = 43
          Width = 92
          Height = 21
          CharCase = ecUpperCase
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnDblClick = btnGetStaffType1Click
          SkinData.SkinSection = 'EDIT'
        end
        object edStaffType2: TsEdit
          Left = 165
          Top = 65
          Width = 92
          Height = 21
          CharCase = ecUpperCase
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnDblClick = btnGetStaffType2Click
          SkinData.SkinSection = 'EDIT'
        end
        object edStaffType3: TsEdit
          Left = 165
          Top = 88
          Width = 92
          Height = 21
          CharCase = ecUpperCase
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnDblClick = btnGetStaffType3Click
          SkinData.SkinSection = 'EDIT'
        end
        object edStaffType4: TsEdit
          Left = 165
          Top = 111
          Width = 92
          Height = 21
          CharCase = ecUpperCase
          Color = 3355443
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15724527
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          OnDblClick = btnGetStaffType4Click
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
  end
end
