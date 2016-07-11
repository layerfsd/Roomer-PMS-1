object frmGuestPortfolio: TfrmGuestPortfolio
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Guest portfolio'
  ClientHeight = 682
  ClientWidth = 567
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 567
    Height = 643
    Align = alClient
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object pgPages: TsPageControl
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 559
      Height = 635
      ActivePage = sTabSheet1
      Align = alClient
      TabOrder = 0
      OnChange = pgPagesChange
      SkinData.SkinSection = 'PAGECONTROL'
      object sTabSheet1: TsTabSheet
        Caption = 'Person'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object sGroupBox1: TsGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 10
          Width = 531
          Height = 319
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alTop
          Caption = 'Persona'
          TabOrder = 0
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object clabInitials: TsLabel
            Left = 124
            Top = 38
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = 'Gender:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel2: TsLabel
            Left = 139
            Top = 65
            Width = 24
            Height = 13
            Alignment = taRightJustify
            Caption = 'Title:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel1: TsLabel
            Left = 109
            Top = 92
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Caption = 'First name:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel3: TsLabel
            Left = 110
            Top = 119
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = 'Last name:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel11: TsLabel
            Left = 109
            Top = 173
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Caption = 'Profession:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel4: TsLabel
            Left = 108
            Top = 200
            Width = 55
            Height = 13
            Alignment = taRightJustify
            Caption = 'Nationality:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel5: TsLabel
            Left = 112
            Top = 227
            Width = 51
            Height = 13
            Alignment = taRightJustify
            Caption = 'Birth date:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel6: TsLabel
            Left = 78
            Top = 254
            Width = 85
            Height = 13
            Alignment = taRightJustify
            Caption = 'Passport number:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel7: TsLabel
            Left = 84
            Top = 281
            Width = 79
            Height = 13
            Alignment = taRightJustify
            Caption = 'Passport expiry:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sSpeedButton2: TsSpeedButton
            Left = 265
            Top = 197
            Width = 22
            Height = 21
            Caption = '...'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton2Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sSpeedButton8: TsSpeedButton
            Left = 293
            Top = 197
            Width = 22
            Height = 21
            Caption = 'X'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton8Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sLabel40: TsLabel
            Left = 56
            Top = 146
            Width = 107
            Height = 13
            Alignment = taRightJustify
            Caption = 'Social security number'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object cmbGender: TsComboBox
            Left = 197
            Top = 35
            Width = 118
            Height = 21
            Alignment = taLeftJustify
            SkinData.SkinSection = 'COMBOBOX'
            VerticalAlignment = taAlignTop
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            Text = 'MALE'
            OnChange = cmbGenderChange
            Items.Strings = (
              'MALE'
              'FEMALE')
          end
          object edtTitle: TsEdit
            Left = 197
            Top = 62
            Width = 118
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtFirstname: TsEdit
            Left = 196
            Top = 89
            Width = 328
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtLastname: TsEdit
            Left = 196
            Top = 116
            Width = 328
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtProfession: TsEdit
            Left = 196
            Top = 170
            Width = 328
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtNationality: TsEdit
            Left = 197
            Top = 197
            Width = 62
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            TextHint = 'Dbl click for list'
            OnChange = cmbGenderChange
            OnDblClick = sSpeedButton2Click
            SkinData.SkinSection = 'EDIT'
          end
          object edtBirthday: TsDateEdit
            Left = 197
            Top = 224
            Width = 118
            Height = 21
            AutoSize = False
            Color = clWhite
            EditMask = '!99/99/9999;1; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 7
            Text = '  -  -    '
            OnChange = edtBirthdayChange
            CheckOnExit = True
            SkinData.SkinSection = 'EDIT'
            GlyphMode.Blend = 0
            GlyphMode.Grayed = False
          end
          object edtPassport: TsEdit
            Left = 197
            Top = 251
            Width = 118
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtPassportExpiry: TsDateEdit
            Left = 197
            Top = 278
            Width = 118
            Height = 21
            AutoSize = False
            Color = clWhite
            EditMask = '!99/99/9999;1; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 9
            Text = '  -  -    '
            OnChange = edtBirthdayChange
            CheckOnExit = True
            SkinData.SkinSection = 'EDIT'
            GlyphMode.Blend = 0
            GlyphMode.Grayed = False
          end
          object edtSSN: TsEdit
            Left = 197
            Top = 143
            Width = 268
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
        end
        object sGroupBox2: TsGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 342
          Width = 531
          Height = 101
          Margins.Left = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alTop
          Caption = 'Spouse'
          TabOrder = 1
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object sLabel8: TsLabel
            Left = 82
            Top = 32
            Width = 81
            Height = 13
            Alignment = taRightJustify
            Caption = 'Name of spouse:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel9: TsLabel
            Left = 74
            Top = 59
            Width = 89
            Height = 13
            Alignment = taRightJustify
            Caption = 'Spouse birth date:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object edtSpousename: TsEdit
            Left = 197
            Top = 29
            Width = 327
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtSpouseBirthdate: TsDateEdit
            Left = 197
            Top = 56
            Width = 118
            Height = 21
            AutoSize = False
            Color = clWhite
            EditMask = '!99/99/9999;1; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 1
            Text = '  -  -    '
            OnChange = edtBirthdayChange
            CheckOnExit = True
            SkinData.SkinSection = 'EDIT'
            GlyphMode.Blend = 0
            GlyphMode.Grayed = False
          end
        end
        object sGroupBox3: TsGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 456
          Width = 531
          Height = 103
          Margins.Left = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alTop
          Caption = 'Extra'
          TabOrder = 2
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object sLabel12: TsLabel
            Left = 80
            Top = 59
            Width = 83
            Height = 13
            Alignment = taRightJustify
            Caption = 'Car license plate:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel10: TsLabel
            Left = 85
            Top = 32
            Width = 78
            Height = 13
            Alignment = taRightJustify
            Caption = 'Contact person:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object edtContactname: TsEdit
            Left = 197
            Top = 29
            Width = 327
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtLicensePlate: TsEdit
            Left = 197
            Top = 56
            Width = 118
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
        end
        object pnlChecksPerson: TsPanel
          Left = 179
          Top = 21
          Width = 26
          Height = 535
          BevelOuter = bvNone
          TabOrder = 3
          SkinData.SkinSection = 'TRANSPARENT'
          object xcmbGender: TsCheckBox
            Left = 4
            Top = 27
            Width = 20
            Height = 16
            TabOrder = 0
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtTitle: TsCheckBox
            Left = 4
            Top = 54
            Width = 20
            Height = 16
            TabOrder = 1
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtLastname: TsCheckBox
            Left = 4
            Top = 108
            Width = 20
            Height = 16
            TabOrder = 2
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtFirstName: TsCheckBox
            Left = 4
            Top = 81
            Width = 20
            Height = 16
            TabOrder = 3
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtBirthDay: TsCheckBox
            Left = 4
            Top = 216
            Width = 20
            Height = 16
            TabOrder = 4
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtNationality: TsCheckBox
            Left = 4
            Top = 189
            Width = 20
            Height = 16
            TabOrder = 5
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtProfession: TsCheckBox
            Left = 4
            Top = 162
            Width = 20
            Height = 16
            TabOrder = 6
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtSSN: TsCheckBox
            Left = 4
            Top = 135
            Width = 20
            Height = 16
            TabOrder = 7
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtPassportExpiry: TsCheckBox
            Left = 4
            Top = 270
            Width = 20
            Height = 16
            TabOrder = 8
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtPassport: TsCheckBox
            Left = 4
            Top = 243
            Width = 20
            Height = 16
            TabOrder = 9
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtSpousename: TsCheckBox
            Left = 4
            Top = 353
            Width = 20
            Height = 16
            TabOrder = 10
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtSpouseBirthdate: TsCheckBox
            Left = 4
            Top = 380
            Width = 20
            Height = 16
            TabOrder = 11
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtContactName: TsCheckBox
            Left = 4
            Top = 467
            Width = 20
            Height = 16
            TabOrder = 12
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtLicensePlate: TsCheckBox
            Left = 4
            Top = 494
            Width = 20
            Height = 16
            TabOrder = 13
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
        end
      end
      object sTabSheet7: TsTabSheet
        Caption = 'Contact'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object sGroupBox4: TsGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 366
          Width = 531
          Height = 231
          Margins.Left = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alTop
          Caption = 'Internet'
          TabOrder = 0
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object sLabel19: TsLabel
            Left = 139
            Top = 38
            Width = 28
            Height = 13
            Alignment = taRightJustify
            Caption = 'Email:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel21: TsLabel
            Left = 124
            Top = 65
            Width = 43
            Height = 13
            Alignment = taRightJustify
            Caption = 'Website:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel22: TsLabel
            Left = 134
            Top = 92
            Width = 33
            Height = 13
            Alignment = taRightJustify
            Caption = 'Skype:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel29: TsLabel
            Left = 129
            Top = 119
            Width = 38
            Height = 13
            Alignment = taRightJustify
            Caption = 'Twitter:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel30: TsLabel
            Left = 120
            Top = 146
            Width = 47
            Height = 13
            Alignment = taRightJustify
            Caption = 'Linked In:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel41: TsLabel
            Left = 117
            Top = 173
            Width = 50
            Height = 13
            Alignment = taRightJustify
            Caption = 'Facebook:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel42: TsLabel
            Left = 110
            Top = 200
            Width = 57
            Height = 13
            Alignment = taRightJustify
            Caption = 'Tripadvisor:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object edtEmail: TsEdit
            Tag = 11
            Left = 201
            Top = 35
            Width = 288
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtWebsite: TsEdit
            Tag = 12
            Left = 201
            Top = 62
            Width = 288
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtSkype: TsEdit
            Tag = 13
            Left = 201
            Top = 89
            Width = 288
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtTwitter: TsEdit
            Tag = 14
            Left = 201
            Top = 116
            Width = 288
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtLinkedIn: TsEdit
            Tag = 15
            Left = 201
            Top = 143
            Width = 288
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object btnEmail: TsButton
            Tag = 11
            Left = 495
            Top = 35
            Width = 29
            Height = 21
            Hint = 'Send email'
            Enabled = False
            ImageIndex = 22
            TabOrder = 7
            OnClick = btnEmailClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnWebsite: TsButton
            Tag = 12
            Left = 495
            Top = 62
            Width = 29
            Height = 21
            Hint = 'Visit website'
            Enabled = False
            ImageIndex = 16
            TabOrder = 8
            OnClick = btnEmailClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnLinkedIn: TsButton
            Tag = 15
            Left = 495
            Top = 142
            Width = 29
            Height = 21
            Hint = 'Visit website'
            Enabled = False
            ImageIndex = 16
            TabOrder = 11
            OnClick = btnEmailClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnTwitter: TsButton
            Tag = 14
            Left = 495
            Top = 116
            Width = 29
            Height = 21
            Hint = 'Visit website'
            Enabled = False
            ImageIndex = 16
            TabOrder = 10
            OnClick = btnEmailClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnSkype: TsButton
            Tag = 13
            Left = 495
            Top = 89
            Width = 29
            Height = 21
            Hint = 'Visit website'
            Enabled = False
            ImageIndex = 16
            TabOrder = 9
            OnClick = btnEmailClick
            SkinData.SkinSection = 'BUTTON'
          end
          object edtFaceBook: TsEdit
            Tag = 14
            Left = 201
            Top = 170
            Width = 288
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtTripadvisor: TsEdit
            Tag = 15
            Left = 201
            Top = 197
            Width = 288
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
        end
        object sGroupBox5: TsGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 10
          Width = 531
          Height = 205
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alTop
          Caption = 'Home address:'
          TabOrder = 1
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object sLabel18: TsLabel
            Left = 124
            Top = 38
            Width = 43
            Height = 13
            Alignment = taRightJustify
            Caption = 'Address:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel20: TsLabel
            Left = 123
            Top = 92
            Width = 44
            Height = 13
            Alignment = taRightJustify
            Caption = 'Zip code:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel24: TsLabel
            Left = 144
            Top = 119
            Width = 23
            Height = 13
            Alignment = taRightJustify
            Caption = 'City:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel26: TsLabel
            Left = 137
            Top = 146
            Width = 30
            Height = 13
            Alignment = taRightJustify
            Caption = 'State:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel27: TsLabel
            Left = 124
            Top = 173
            Width = 43
            Height = 13
            Alignment = taRightJustify
            Caption = 'Country:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sSpeedButton9: TsSpeedButton
            Left = 269
            Top = 170
            Width = 22
            Height = 21
            Caption = '...'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton9Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sSpeedButton10: TsSpeedButton
            Left = 297
            Top = 170
            Width = 22
            Height = 21
            Caption = 'X'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton10Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object edtAddress1: TsEdit
            Left = 201
            Top = 35
            Width = 323
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtAddress2: TsEdit
            Left = 201
            Top = 62
            Width = 323
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtZip: TsEdit
            Left = 201
            Top = 89
            Width = 118
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtCity: TsEdit
            Left = 201
            Top = 116
            Width = 323
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtState: TsEdit
            Left = 201
            Top = 143
            Width = 118
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtCountry: TsEdit
            Left = 201
            Top = 170
            Width = 62
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            TextHint = 'Dbl click for list'
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
        end
        object sGroupBox6: TsGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 228
          Width = 531
          Height = 125
          Margins.Left = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alTop
          Caption = 'Telephone'
          TabOrder = 2
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object sLabel23: TsLabel
            Left = 124
            Top = 38
            Width = 43
            Height = 13
            Alignment = taRightJustify
            Caption = 'Landline:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel25: TsLabel
            Left = 133
            Top = 65
            Width = 34
            Height = 13
            Alignment = taRightJustify
            Caption = 'Mobile:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel28: TsLabel
            Left = 145
            Top = 92
            Width = 22
            Height = 13
            Alignment = taRightJustify
            Caption = 'Fax:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object edtLandline: TsEdit
            Left = 201
            Top = 35
            Width = 148
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtMobile: TsEdit
            Left = 201
            Top = 62
            Width = 148
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtFax: TsEdit
            Left = 201
            Top = 89
            Width = 148
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
        end
        object pnlChecksContact: TsPanel
          Left = 179
          Top = 21
          Width = 26
          Height = 573
          BevelOuter = bvNone
          TabOrder = 3
          SkinData.SkinSection = 'TRANSPARENT'
          object xedtAddress1: TsCheckBox
            Left = 4
            Top = 27
            Width = 20
            Height = 16
            TabOrder = 0
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtAddress2: TsCheckBox
            Left = 4
            Top = 54
            Width = 20
            Height = 16
            TabOrder = 1
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCity: TsCheckBox
            Left = 4
            Top = 108
            Width = 20
            Height = 16
            TabOrder = 2
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtZip: TsCheckBox
            Left = 4
            Top = 81
            Width = 20
            Height = 16
            TabOrder = 3
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtMobile: TsCheckBox
            Left = 4
            Top = 272
            Width = 20
            Height = 16
            TabOrder = 4
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtLandline: TsCheckBox
            Left = 4
            Top = 245
            Width = 20
            Height = 16
            TabOrder = 5
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCountry: TsCheckBox
            Left = 4
            Top = 162
            Width = 20
            Height = 16
            TabOrder = 6
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtState: TsCheckBox
            Left = 4
            Top = 135
            Width = 20
            Height = 16
            TabOrder = 7
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtEmail: TsCheckBox
            Left = 4
            Top = 383
            Width = 20
            Height = 16
            TabOrder = 8
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtFax: TsCheckBox
            Left = 4
            Top = 299
            Width = 20
            Height = 16
            TabOrder = 9
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtWebsite: TsCheckBox
            Left = 4
            Top = 410
            Width = 20
            Height = 16
            TabOrder = 10
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtSkype: TsCheckBox
            Left = 4
            Top = 437
            Width = 20
            Height = 16
            TabOrder = 11
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtFaceBook: TsCheckBox
            Left = 4
            Top = 518
            Width = 20
            Height = 16
            TabOrder = 12
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtTripadvisor: TsCheckBox
            Left = 4
            Top = 545
            Width = 20
            Height = 16
            TabOrder = 13
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtLinkedIn: TsCheckBox
            Left = 4
            Top = 491
            Width = 20
            Height = 16
            TabOrder = 14
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtTwitter: TsCheckBox
            Left = 4
            Top = 464
            Width = 20
            Height = 16
            TabOrder = 15
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
        end
      end
      object sTabSheet2: TsTabSheet
        Caption = 'Company'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object sGroupBox7: TsGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 10
          Width = 531
          Height = 281
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alTop
          Caption = 'Company info'
          TabOrder = 0
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object sLabel14: TsLabel
            Left = 91
            Top = 41
            Width = 76
            Height = 13
            Alignment = taRightJustify
            Caption = 'Customer code:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel15: TsLabel
            Left = 89
            Top = 95
            Width = 78
            Height = 13
            Alignment = taRightJustify
            Caption = 'Company name:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel16: TsLabel
            Left = 124
            Top = 122
            Width = 43
            Height = 13
            Alignment = taRightJustify
            Caption = 'Address:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sSpeedButton4: TsSpeedButton
            Left = 325
            Top = 38
            Width = 22
            Height = 21
            Caption = '...'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton4Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sSpeedButton5: TsSpeedButton
            Left = 353
            Top = 38
            Width = 22
            Height = 21
            Caption = 'X'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton5Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sLabel13: TsLabel
            Left = 137
            Top = 230
            Width = 30
            Height = 13
            Alignment = taRightJustify
            Caption = 'State:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel17: TsLabel
            Left = 144
            Top = 203
            Width = 23
            Height = 13
            Alignment = taRightJustify
            Caption = 'City:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel31: TsLabel
            Left = 123
            Top = 176
            Width = 44
            Height = 13
            Alignment = taRightJustify
            Caption = 'Zip code:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel32: TsLabel
            Left = 124
            Top = 257
            Width = 43
            Height = 13
            Alignment = taRightJustify
            Caption = 'Country:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sSpeedButton1: TsSpeedButton
            Left = 269
            Top = 254
            Width = 22
            Height = 21
            Caption = '...'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton1Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sSpeedButton3: TsSpeedButton
            Left = 297
            Top = 254
            Width = 22
            Height = 21
            Caption = 'X'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton3Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sLabel44: TsLabel
            Left = 104
            Top = 68
            Width = 63
            Height = 13
            Alignment = taRightJustify
            Caption = 'VAT Number:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object edtCustomer: TsEdit
            Left = 201
            Top = 38
            Width = 118
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtCompName: TsEdit
            Left = 201
            Top = 92
            Width = 323
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtCompAddress1: TsEdit
            Left = 201
            Top = 119
            Width = 323
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtCompAddress2: TsEdit
            Left = 201
            Top = 146
            Width = 323
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtCompZip: TsEdit
            Left = 201
            Top = 173
            Width = 118
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtCompCity: TsEdit
            Left = 201
            Top = 200
            Width = 323
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtCompState: TsEdit
            Left = 201
            Top = 227
            Width = 118
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtCompCountry: TsEdit
            Left = 201
            Top = 254
            Width = 62
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtVAT: TsEdit
            Left = 201
            Top = 65
            Width = 323
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
        end
        object sGroupBox8: TsGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 304
          Width = 531
          Height = 141
          Margins.Left = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alTop
          Caption = 'Contact'
          TabOrder = 1
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object sLabel33: TsLabel
            Left = 113
            Top = 38
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Caption = 'Telephone:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel34: TsLabel
            Left = 139
            Top = 92
            Width = 28
            Height = 13
            Alignment = taRightJustify
            Caption = 'Email:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel43: TsLabel
            Left = 145
            Top = 65
            Width = 22
            Height = 13
            Alignment = taRightJustify
            Caption = 'Fax:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object edtCompTel: TsEdit
            Left = 201
            Top = 35
            Width = 148
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtCompEmail: TsEdit
            Left = 200
            Top = 89
            Width = 289
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object btnEmailComp: TsButton
            Left = 495
            Top = 89
            Width = 29
            Height = 21
            Hint = 'Send email'
            Enabled = False
            ImageIndex = 22
            TabOrder = 3
            SkinData.SkinSection = 'BUTTON'
          end
          object edtCompFax: TsEdit
            Left = 201
            Top = 62
            Width = 148
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
        end
        object pnlChecksCompany: TsPanel
          Left = 179
          Top = 21
          Width = 26
          Height = 580
          BevelOuter = bvNone
          TabOrder = 2
          SkinData.SkinSection = 'TRANSPARENT'
          object xedtCustomer: TsCheckBox
            Left = 4
            Top = 30
            Width = 20
            Height = 16
            TabOrder = 0
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtVAT: TsCheckBox
            Left = 4
            Top = 57
            Width = 20
            Height = 16
            TabOrder = 1
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCompAddress1: TsCheckBox
            Left = 4
            Top = 111
            Width = 20
            Height = 16
            TabOrder = 2
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCompName: TsCheckBox
            Left = 4
            Top = 84
            Width = 20
            Height = 16
            TabOrder = 3
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCompState: TsCheckBox
            Left = 4
            Top = 219
            Width = 20
            Height = 16
            TabOrder = 4
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCompCity: TsCheckBox
            Left = 4
            Top = 192
            Width = 20
            Height = 16
            TabOrder = 5
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCompZip: TsCheckBox
            Left = 4
            Top = 165
            Width = 20
            Height = 16
            TabOrder = 6
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCompAddress2: TsCheckBox
            Left = 4
            Top = 138
            Width = 20
            Height = 16
            TabOrder = 7
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCompCountry: TsCheckBox
            Left = 4
            Top = 246
            Width = 20
            Height = 16
            TabOrder = 8
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCompTel: TsCheckBox
            Left = 4
            Top = 321
            Width = 20
            Height = 16
            TabOrder = 9
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCompFax: TsCheckBox
            Left = 4
            Top = 348
            Width = 20
            Height = 16
            TabOrder = 10
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtCompEmail: TsCheckBox
            Left = 4
            Top = 375
            Width = 20
            Height = 16
            TabOrder = 11
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
        end
      end
      object sTabSheet4: TsTabSheet
        Caption = 'Preferences'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object sGroupBox11: TsGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 10
          Width = 531
          Height = 599
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alTop
          Caption = 'Guest preferences'
          TabOrder = 0
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object sLabel35: TsLabel
            Left = 100
            Top = 41
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Specific room:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel36: TsLabel
            Left = 75
            Top = 68
            Width = 92
            Height = 13
            Alignment = taRightJustify
            Caption = 'Specific room type:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel37: TsLabel
            Left = 87
            Top = 95
            Width = 80
            Height = 13
            Alignment = taRightJustify
            Caption = 'Invoice address:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sSpeedButton6: TsSpeedButton
            Left = 325
            Top = 38
            Width = 22
            Height = 21
            Caption = '...'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton6Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sSpeedButton7: TsSpeedButton
            Left = 353
            Top = 38
            Width = 22
            Height = 21
            Caption = 'X'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton7Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sSpeedButton11: TsSpeedButton
            Left = 325
            Top = 65
            Width = 22
            Height = 21
            Caption = '...'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton11Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sSpeedButton12: TsSpeedButton
            Left = 353
            Top = 65
            Width = 22
            Height = 21
            Caption = 'X'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = sSpeedButton12Click
            SkinData.SkinSection = 'SPEEDBUTTON'
          end
          object sLabel38: TsLabel
            Left = 77
            Top = 170
            Width = 90
            Height = 13
            Alignment = taRightJustify
            Caption = 'Preparation notes:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel39: TsLabel
            Left = 135
            Top = 385
            Width = 32
            Height = 13
            Alignment = taRightJustify
            Caption = 'Notes:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object edtRoom: TsEdit
            Left = 201
            Top = 38
            Width = 118
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtRoomType: TsEdit
            Left = 201
            Top = 65
            Width = 118
            Height = 21
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtInvoiceAddress: TsComboBox
            Left = 201
            Top = 92
            Width = 118
            Height = 21
            Alignment = taLeftJustify
            SkinData.SkinSection = 'COMBOBOX'
            VerticalAlignment = taAlignTop
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 2
            Text = 'HOME ADDRESS'
            OnChange = cmbGenderChange
            Items.Strings = (
              'HOME ADDRESS'
              'WORK ADDRESS')
          end
          object cbxEmailSpecials: TsCheckBox
            Left = 201
            Top = 121
            Width = 119
            Height = 17
            Caption = 'Email special offers'
            TabOrder = 3
            OnClick = cbxEmailSpecialsClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object cbxEmailNews: TsCheckBox
            Left = 201
            Top = 146
            Width = 107
            Height = 17
            Caption = 'Email hotel news'
            TabOrder = 4
            OnClick = cbxEmailSpecialsClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object edtPreparationNotes: TsMemo
            Left = 201
            Top = 169
            Width = 320
            Height = 209
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
          object edtGuestNotes: TsMemo
            Left = 201
            Top = 384
            Width = 320
            Height = 209
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnChange = cmbGenderChange
            SkinData.SkinSection = 'EDIT'
          end
        end
        object pnlChecksPreferences: TsPanel
          Left = 179
          Top = 21
          Width = 26
          Height = 580
          BevelOuter = bvNone
          TabOrder = 1
          SkinData.SkinSection = 'TRANSPARENT'
          object xedtRoom: TsCheckBox
            Left = 4
            Top = 30
            Width = 20
            Height = 16
            TabOrder = 0
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtRoomType: TsCheckBox
            Left = 4
            Top = 57
            Width = 20
            Height = 16
            TabOrder = 1
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xcbxEmailSpecials: TsCheckBox
            Left = 4
            Top = 110
            Width = 20
            Height = 16
            TabOrder = 2
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtInvoiceAddress: TsCheckBox
            Left = 4
            Top = 84
            Width = 20
            Height = 16
            TabOrder = 3
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtPreparationNotes: TsCheckBox
            Left = 4
            Top = 159
            Width = 20
            Height = 16
            TabOrder = 4
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xcbxEmailNews: TsCheckBox
            Left = 4
            Top = 135
            Width = 20
            Height = 16
            TabOrder = 5
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object xedtGuestNotes: TsCheckBox
            Left = 4
            Top = 374
            Width = 20
            Height = 16
            TabOrder = 6
            OnClick = xcmbGenderClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
        end
      end
      object tabHistory: TsTabSheet
        Caption = 'History'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object grData: TcxGrid
          Left = 0
          Top = 41
          Width = 551
          Height = 566
          Align = alClient
          TabOrder = 0
          LookAndFeel.NativeStyle = False
          object tvData: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.First.Visible = True
            Navigator.Buttons.PriorPage.Hint = 'Prior page'
            Navigator.Buttons.PriorPage.Visible = True
            Navigator.Buttons.Prior.Hint = 'Prior'
            Navigator.Buttons.Prior.Visible = True
            Navigator.Buttons.Next.Hint = 'Next'
            Navigator.Buttons.Next.Visible = True
            Navigator.Buttons.NextPage.Hint = 'Next page'
            Navigator.Buttons.NextPage.Visible = True
            Navigator.Buttons.Last.Hint = 'Last'
            Navigator.Buttons.Last.Visible = True
            Navigator.Buttons.Insert.Hint = 'Insert'
            Navigator.Buttons.Insert.Visible = True
            Navigator.Buttons.Append.Enabled = False
            Navigator.Buttons.Append.Hint = 'Append'
            Navigator.Buttons.Append.Visible = False
            Navigator.Buttons.Delete.Hint = 'Delete'
            Navigator.Buttons.Delete.Visible = True
            Navigator.Buttons.Edit.Enabled = False
            Navigator.Buttons.Edit.Hint = 'Edit'
            Navigator.Buttons.Edit.Visible = False
            Navigator.Buttons.Post.Hint = 'Post'
            Navigator.Buttons.Post.Visible = True
            Navigator.Buttons.Cancel.Hint = 'Cancel'
            Navigator.Buttons.Cancel.Visible = True
            Navigator.Buttons.Refresh.Enabled = False
            Navigator.Buttons.Refresh.Hint = 'Refresh'
            Navigator.Buttons.Refresh.Visible = False
            Navigator.Buttons.SaveBookmark.Enabled = False
            Navigator.Buttons.SaveBookmark.Hint = 'Save bookmark'
            Navigator.Buttons.SaveBookmark.Visible = False
            Navigator.Buttons.GotoBookmark.Enabled = False
            Navigator.Buttons.GotoBookmark.Hint = 'Goto bookmark'
            Navigator.Buttons.GotoBookmark.Visible = False
            Navigator.Buttons.Filter.Hint = 'Filter'
            Navigator.Buttons.Filter.Visible = True
            Navigator.InfoPanel.Visible = True
            Navigator.Visible = True
            OnCellDblClick = tvDataCellDblClick
            DataController.DataSource = DS_history
            DataController.Summary.DefaultGroupSummaryItems = <
              item
                Kind = skSum
                Position = spFooter
                Column = tvDataTotalInvoice
              end
              item
                Kind = skSum
                Position = spFooter
                Column = tvDataTotalStay
              end
              item
                Kind = skSum
                Position = spFooter
                Column = tvDataAvgRate
              end
              item
                Kind = skSum
                Column = tvDataTotalInvoice
              end
              item
                Kind = skSum
                Column = tvDataTotalStay
              end
              item
                Kind = skSum
                Column = tvDataAvgRate
              end>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.AlwaysShowEditor = True
            OptionsBehavior.IncSearch = True
            OptionsData.Appending = True
            OptionsData.CancelOnExit = False
            OptionsData.DeletingConfirmation = False
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object tvDataRecId: TcxGridDBColumn
              DataBinding.FieldName = 'RecId'
              Visible = False
            end
            object tvDataArrival: TcxGridDBColumn
              DataBinding.FieldName = 'Arrival'
              Options.Editing = False
            end
            object tvDataDeparture: TcxGridDBColumn
              DataBinding.FieldName = 'Departure'
              Options.Editing = False
            end
            object tvDataNights: TcxGridDBColumn
              DataBinding.FieldName = 'Nights'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
            end
            object tvDataRoomType: TcxGridDBColumn
              Caption = 'Room Type'
              DataBinding.FieldName = 'RoomType'
              Options.Editing = False
              Width = 74
            end
            object tvDataRoom: TcxGridDBColumn
              DataBinding.FieldName = 'Room'
              Options.Editing = False
              Width = 62
            end
            object tvDataResStatus: TcxGridDBColumn
              Caption = 'Res Status'
              DataBinding.FieldName = 'ResStatus'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 60
            end
            object tvDataAvgRate: TcxGridDBColumn
              Caption = 'Avg Rate'
              DataBinding.FieldName = 'AvgRate'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 83
            end
            object tvDataTotalStay: TcxGridDBColumn
              Caption = 'Total Stay'
              DataBinding.FieldName = 'TotalStay'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 80
            end
            object tvDataTotalInvoice: TcxGridDBColumn
              Caption = 'Total Invoice'
              DataBinding.FieldName = 'TotalInvoice'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 84
            end
          end
          object lvData: TcxGridLevel
            GridView = tvData
          end
        end
        object sPanel1: TsPanel
          Left = 0
          Top = 0
          Width = 551
          Height = 41
          Align = alTop
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
          object sButton1: TsButton
            Left = 110
            Top = 4
            Width = 100
            Height = 33
            Caption = 'Print'
            ImageIndex = 3
            TabOrder = 0
            OnClick = sButton1Click
            SkinData.SkinSection = 'BUTTON'
          end
          object LMDSpeedButton6: TsButton
            Left = 4
            Top = 4
            Width = 100
            Height = 33
            Caption = 'EXCEL'
            ImageIndex = 132
            TabOrder = 1
            OnClick = LMDSpeedButton6Click
            SkinData.SkinSection = 'BUTTON'
          end
        end
      end
      object tabInvoices: TsTabSheet
        Caption = 'Invoices'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object grInvoices: TcxGrid
          Left = 0
          Top = 41
          Width = 551
          Height = 566
          Align = alClient
          TabOrder = 0
          LookAndFeel.NativeStyle = False
          object tvInvoices: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.First.Visible = True
            Navigator.Buttons.PriorPage.Hint = 'Prior page'
            Navigator.Buttons.PriorPage.Visible = True
            Navigator.Buttons.Prior.Hint = 'Prior'
            Navigator.Buttons.Prior.Visible = True
            Navigator.Buttons.Next.Hint = 'Next'
            Navigator.Buttons.Next.Visible = True
            Navigator.Buttons.NextPage.Hint = 'Next page'
            Navigator.Buttons.NextPage.Visible = True
            Navigator.Buttons.Last.Hint = 'Last'
            Navigator.Buttons.Last.Visible = True
            Navigator.Buttons.Insert.Hint = 'Insert'
            Navigator.Buttons.Insert.Visible = True
            Navigator.Buttons.Append.Enabled = False
            Navigator.Buttons.Append.Hint = 'Append'
            Navigator.Buttons.Append.Visible = False
            Navigator.Buttons.Delete.Hint = 'Delete'
            Navigator.Buttons.Delete.Visible = True
            Navigator.Buttons.Edit.Enabled = False
            Navigator.Buttons.Edit.Hint = 'Edit'
            Navigator.Buttons.Edit.Visible = False
            Navigator.Buttons.Post.Hint = 'Post'
            Navigator.Buttons.Post.Visible = True
            Navigator.Buttons.Cancel.Hint = 'Cancel'
            Navigator.Buttons.Cancel.Visible = True
            Navigator.Buttons.Refresh.Enabled = False
            Navigator.Buttons.Refresh.Hint = 'Refresh'
            Navigator.Buttons.Refresh.Visible = False
            Navigator.Buttons.SaveBookmark.Enabled = False
            Navigator.Buttons.SaveBookmark.Hint = 'Save bookmark'
            Navigator.Buttons.SaveBookmark.Visible = False
            Navigator.Buttons.GotoBookmark.Enabled = False
            Navigator.Buttons.GotoBookmark.Hint = 'Goto bookmark'
            Navigator.Buttons.GotoBookmark.Visible = False
            Navigator.Buttons.Filter.Hint = 'Filter'
            Navigator.Buttons.Filter.Visible = True
            Navigator.InfoPanel.Visible = True
            Navigator.Visible = True
            OnCellDblClick = tvInvoicesCellDblClick
            DataController.DataSource = DS_invoices
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.AlwaysShowEditor = True
            OptionsBehavior.IncSearch = True
            OptionsData.Appending = True
            OptionsData.CancelOnExit = False
            OptionsData.DeletingConfirmation = False
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object tvInvoicesRecId: TcxGridDBColumn
              DataBinding.FieldName = 'RecId'
              Visible = False
            end
            object tvInvoicesinvoiceDate: TcxGridDBColumn
              Caption = 'Date'
              DataBinding.FieldName = 'invoiceDate'
              Options.Editing = False
            end
            object tvInvoicesInvoiceNumber: TcxGridDBColumn
              Caption = 'Invoice #'
              DataBinding.FieldName = 'InvoiceNumber'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
            end
            object tvInvoicesTotalStay: TcxGridDBColumn
              Caption = 'Total room rent'
              DataBinding.FieldName = 'TotalStay'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 102
            end
            object tvInvoicesTotalItems: TcxGridDBColumn
              Caption = 'Totel items sales'
              DataBinding.FieldName = 'TotalItems'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 109
            end
            object tvInvoicesTotalInvoice: TcxGridDBColumn
              Caption = 'Invoice Total'
              DataBinding.FieldName = 'TotalInvoice'
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Width = 124
            end
          end
          object lvInvoices: TcxGridLevel
            GridView = tvInvoices
          end
        end
        object sPanel2: TsPanel
          Left = 0
          Top = 0
          Width = 551
          Height = 41
          Align = alTop
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
          object sButton2: TsButton
            Left = 110
            Top = 4
            Width = 100
            Height = 33
            Caption = 'Print'
            ImageIndex = 3
            TabOrder = 0
            OnClick = sButton2Click
            SkinData.SkinSection = 'BUTTON'
          end
          object sButton3: TsButton
            Left = 4
            Top = 4
            Width = 100
            Height = 33
            Caption = 'EXCEL'
            ImageIndex = 132
            TabOrder = 1
            OnClick = sButton3Click
            SkinData.SkinSection = 'BUTTON'
          end
        end
      end
    end
  end
  object panBtn: TsPanel
    AlignWithMargins = True
    Left = 3
    Top = 646
    Width = 561
    Height = 33
    Align = alBottom
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      561
      33)
    object btnCancel: TsButton
      Left = 469
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 4
      ModalResult = 2
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 378
      Top = 3
      Width = 85
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ImageIndex = 82
      ModalResult = 1
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
    object btnBack: TsButton
      Left = 136
      Top = 4
      Width = 27
      Height = 25
      Hint = 'Previous'
      ImageIndex = 106
      TabOrder = 2
      Visible = False
      OnClick = btnBackClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnForward: TsButton
      Left = 169
      Top = 4
      Width = 27
      Height = 25
      Hint = 'Next'
      ImageIndex = 107
      TabOrder = 3
      Visible = False
      OnClick = btnForwardClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnTabForward: TsButton
      Left = 41
      Top = 4
      Width = 27
      Height = 25
      Hint = 'Next'
      ImageIndex = 107
      TabOrder = 4
      OnClick = btnTabForwardClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnTabBack: TsButton
      Left = 8
      Top = 4
      Width = 27
      Height = 25
      Hint = 'Previous'
      Enabled = False
      ImageIndex = 106
      TabOrder = 5
      OnClick = btnTabBackClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object history_: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 448
    Top = 176
    object history_Reservation: TIntegerField
      FieldName = 'Reservation'
    end
    object history_RoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object history_Nights: TIntegerField
      FieldName = 'Nights'
    end
    object history_ResStatus: TStringField
      FieldName = 'ResStatus'
      Size = 1
    end
    object history_Arrival: TDateField
      FieldName = 'Arrival'
    end
    object history_Departure: TDateField
      FieldName = 'Departure'
    end
    object history_Room: TStringField
      FieldName = 'Room'
      Size = 15
    end
    object history_RoomType: TStringField
      FieldName = 'RoomType'
      Size = 15
    end
    object history_AvgRate: TFloatField
      FieldName = 'AvgRate'
    end
    object history_TotalStay: TFloatField
      FieldName = 'TotalStay'
    end
    object history_TotalInvoice: TFloatField
      FieldName = 'TotalInvoice'
    end
  end
  object DS_history: TDataSource
    DataSet = history_
    Left = 400
    Top = 184
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 72
    Top = 168
    object prLink_grData: TdxGridReportLink
      Component = grData
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 5080
      PrinterPage.GrayShading = True
      PrinterPage.Header = 2540
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210820
      PrinterPage.PageSize.Y = 297180
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 41334.495374884260000000
      BuiltInReportLink = True
    end
  end
  object invoices_: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 472
    Top = 256
    object invoices_invoiceDate: TDateField
      FieldName = 'invoiceDate'
    end
    object invoices_InvoiceNumber: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object FloatField2: TFloatField
      FieldName = 'TotalStay'
    end
    object invoices_TotalItems: TFloatField
      FieldName = 'TotalItems'
    end
    object FloatField3: TFloatField
      FieldName = 'TotalInvoice'
    end
  end
  object DS_invoices: TDataSource
    DataSet = invoices_
    Left = 416
    Top = 264
  end
end
