object FrmGuestCheckInForm: TFrmGuestCheckInForm
  Left = 0
  Top = 0
  Caption = 'Guest Check In'
  ClientHeight = 621
  ClientWidth = 842
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPageControl1: TsPageControl
    Left = 0
    Top = 0
    Width = 842
    Height = 588
    ActivePage = sTabSheet1
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PAGECONTROL'
    object sTabSheet1: TsTabSheet
      Caption = 'Room 101'
      object sPanel1: TsPanel
        Left = 0
        Top = 0
        Width = 473
        Height = 560
        Align = alLeft
        Padding.Left = 5
        Padding.Top = 5
        Padding.Right = 5
        Padding.Bottom = 5
        TabOrder = 0
        SkinData.SkinSection = 'TRANSPARENT'
        object sLabel7: TsLabel
          Left = 6
          Top = 6
          Width = 461
          Height = 25
          Align = alTop
          Caption = 'Guest details'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ExplicitWidth = 120
        end
        object sPageControl2: TsPageControl
          Left = 6
          Top = 31
          Width = 461
          Height = 523
          ActivePage = sTabSheet2
          Align = alClient
          TabOrder = 0
          SkinData.SkinSection = 'PAGECONTROL'
          object sTabSheet2: TsTabSheet
            Caption = 'Guest Info'
            SkinData.SkinSection = 'TRANSPARENT'
            object sLabel6: TsLabel
              Left = 97
              Top = 126
              Width = 87
              Height = 13
              Alignment = taRightJustify
              Caption = 'Passport/ID Card:'
            end
            object sLabel1: TsLabel
              Left = 121
              Top = 72
              Width = 63
              Height = 13
              Alignment = taRightJustify
              Caption = '* First name:'
            end
            object sLabel2: TsLabel
              Left = 122
              Top = 99
              Width = 62
              Height = 13
              Alignment = taRightJustify
              Caption = '* Last name:'
            end
            object sLabel3: TsLabel
              Left = 141
              Top = 369
              Width = 43
              Height = 13
              Alignment = taRightJustify
              Caption = 'Address:'
            end
            object sLabel4: TsLabel
              Left = 138
              Top = 423
              Width = 46
              Height = 13
              Alignment = taRightJustify
              Caption = 'Zip Code:'
            end
            object sLabel5: TsLabel
              Left = 132
              Top = 477
              Width = 52
              Height = 13
              Alignment = taRightJustify
              Caption = '* Country:'
            end
            object sLabel15: TsLabel
              Left = 119
              Top = 234
              Width = 65
              Height = 13
              Alignment = taRightJustify
              Caption = 'Date of birth:'
              Visible = False
            end
            object sLabel9: TsLabel
              Left = 152
              Top = 450
              Width = 32
              Height = 13
              Alignment = taRightJustify
              Caption = '* City:'
            end
            object lbCountryName: TsLabel
              Left = 253
              Top = 477
              Width = 178
              Height = 13
              AutoSize = False
            end
            object sLabel13: TsLabel
              Left = 91
              Top = 276
              Width = 93
              Height = 13
              Alignment = taRightJustify
              Caption = 'Telephone number:'
            end
            object sLabel14: TsLabel
              Left = 115
              Top = 330
              Width = 69
              Height = 13
              Alignment = taRightJustify
              Caption = 'Email address:'
            end
            object sLabel17: TsLabel
              Left = 111
              Top = 303
              Width = 73
              Height = 13
              Alignment = taRightJustify
              Caption = 'Mobile number:'
            end
            object sLabel18: TsLabel
              Left = 129
              Top = 207
              Width = 55
              Height = 13
              Alignment = taRightJustify
              Caption = 'Nationality:'
            end
            object sLabel19: TsLabel
              Left = 8
              Top = 17
              Width = 115
              Height = 16
              Caption = 'Guest information'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
            end
            object sLabel20: TsLabel
              Left = 8
              Top = 255
              Width = 129
              Height = 16
              Caption = 'Contact information'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
            end
            object sLabel21: TsLabel
              Left = 8
              Top = 349
              Width = 96
              Height = 16
              Caption = 'Postal address'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
            end
            object lbNationality: TsLabel
              Left = 254
              Top = 207
              Width = 178
              Height = 13
              AutoSize = False
            end
            object sLabel32: TsLabel
              Left = 160
              Top = 153
              Width = 24
              Height = 13
              Alignment = taRightJustify
              Caption = 'Title:'
            end
            object shpFirstname: TShape
              Left = 436
              Top = 70
              Width = 16
              Height = 17
              Brush.Color = clRed
              Pen.Color = clRed
              Shape = stCircle
              Visible = False
            end
            object shpLastname: TShape
              Left = 436
              Top = 97
              Width = 16
              Height = 17
              Brush.Color = clRed
              Pen.Color = clRed
              Shape = stCircle
              Visible = False
            end
            object shpCity: TShape
              Left = 436
              Top = 448
              Width = 16
              Height = 17
              Brush.Color = clRed
              Pen.Color = clRed
              Shape = stCircle
              Visible = False
            end
            object shpCountry: TShape
              Left = 436
              Top = 475
              Width = 16
              Height = 17
              Brush.Color = clRed
              Pen.Color = clRed
              Shape = stCircle
              Visible = False
            end
            object sLabel34: TsLabel
              Left = 73
              Top = 180
              Width = 111
              Height = 13
              Alignment = taRightJustify
              Caption = 'Social security number:'
            end
            object edCardId: TsEdit
              Left = 190
              Top = 123
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edLastName: TsEdit
              Left = 190
              Top = 96
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edAddress1: TsEdit
              Left = 190
              Top = 366
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edAddress2: TsEdit
              Left = 190
              Top = 393
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 11
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edZipcode: TsEdit
              Left = 190
              Top = 420
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edCountry: TsEdit
              Left = 190
              Top = 474
              Width = 34
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 14
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object sButton1: TsButton
              Left = 225
              Top = 474
              Width = 23
              Height = 21
              Caption = '...'
              TabOrder = 15
              OnClick = sButton1Click
              SkinData.SkinSection = 'BUTTON'
            end
            object edDateOfBirth: TsDateEdit
              Left = 190
              Top = 231
              Width = 107
              Height = 21
              AutoSize = False
              Color = clWhite
              EditMask = '!99/99/9999;1; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2302755
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              TabOrder = 6
              Text = '  -  -    '
              Visible = False
              CheckOnExit = True
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              SkinData.SkinSection = 'EDIT'
              GlyphMode.Blend = 0
              GlyphMode.Grayed = False
              GlyphMode.Images = DImages.cxImagesSmallExtra
              GlyphMode.ImageIndex = 4
              DirectInput = False
              ShowWeeks = True
              PopupWidth = 250
            end
            object edCity: TsEdit
              Left = 190
              Top = 447
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 13
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edTel1: TsEdit
              Left = 190
              Top = 273
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edEmail: TsEdit
              Left = 190
              Top = 327
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edMobile: TsEdit
              Left = 190
              Top = 300
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edNationality: TsEdit
              Left = 190
              Top = 204
              Width = 34
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object sButton3: TsButton
              Left = 225
              Top = 204
              Width = 23
              Height = 21
              Caption = '...'
              TabOrder = 16
              OnClick = sButton3Click
              SkinData.SkinSection = 'BUTTON'
            end
            object edTitle: TsEdit
              Left = 190
              Top = 150
              Width = 52
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object btnPortfolio: TsButton
              Left = 190
              Top = 5
              Width = 130
              Height = 41
              Caption = 'Guest portfolio'
              TabOrder = 17
              OnClick = btnPortfolioClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btNoPortfolio: TsButton
              Left = 326
              Top = 5
              Width = 105
              Height = 41
              Caption = 'Remove from guest portfolio'
              TabOrder = 18
              Visible = False
              OnClick = btNoPortfolioClick
              SkinData.SkinSection = 'BUTTON'
            end
            object edSSN: TsEdit
              Left = 190
              Top = 177
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object cbActiveLiveSearch: TsCheckBox
              Left = 190
              Top = 51
              Width = 82
              Height = 17
              Caption = 'Live search'
              TabOrder = 19
              OnClick = cbActiveLiveSearchClick
              SkinData.SkinSection = 'CHECKBOX'
              ImgChecked = 0
              ImgUnchecked = 0
            end
            object edFirstname: TRoomerFilterComboBox
              Left = 190
              Top = 69
              Width = 241
              Height = 21
              AutoCloseUp = True
              Alignment = taLeftJustify
              SkinData.SkinSection = 'COMBOBOX'
              VerticalAlignment = taAlignTop
              AutoComplete = False
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemIndex = -1
              ParentFont = False
              TabOrder = 0
              OnCloseUp = edFirstnameCloseUp
              OnChange = edLastNameChange
              OnKeyDown = edFirstnameKeyDown
            end
          end
          object sTabSheet6: TsTabSheet
            Caption = 'Company'
            object sLabel22: TsLabel
              Left = 11
              Top = 24
              Width = 137
              Height = 16
              Caption = 'Company information'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
            end
            object sLabel23: TsLabel
              Left = 114
              Top = 57
              Width = 78
              Height = 13
              Alignment = taRightJustify
              Caption = 'Company name:'
            end
            object sLabel24: TsLabel
              Left = 11
              Top = 241
              Width = 96
              Height = 16
              Caption = 'Postal address'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
            end
            object sLabel25: TsLabel
              Left = 149
              Top = 271
              Width = 43
              Height = 13
              Alignment = taRightJustify
              Caption = 'Address:'
            end
            object sLabel26: TsLabel
              Left = 146
              Top = 325
              Width = 46
              Height = 13
              Alignment = taRightJustify
              Caption = 'Zip Code:'
            end
            object sLabel27: TsLabel
              Left = 160
              Top = 352
              Width = 32
              Height = 13
              Alignment = taRightJustify
              Caption = '* City:'
            end
            object sLabel28: TsLabel
              Left = 140
              Top = 379
              Width = 52
              Height = 13
              Alignment = taRightJustify
              Caption = '* Country:'
            end
            object sLabel29: TsLabel
              Left = 123
              Top = 203
              Width = 69
              Height = 13
              Alignment = taRightJustify
              Caption = 'Email address:'
            end
            object sLabel30: TsLabel
              Left = 11
              Top = 121
              Width = 129
              Height = 16
              Caption = 'Contact information'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
            end
            object sLabel31: TsLabel
              Left = 99
              Top = 149
              Width = 93
              Height = 13
              Alignment = taRightJustify
              Caption = 'Telephone number:'
            end
            object lbCompCountry: TsLabel
              Left = 261
              Top = 325
              Width = 178
              Height = 13
              AutoSize = False
            end
            object sLabel37: TsLabel
              Left = 170
              Top = 176
              Width = 22
              Height = 13
              Alignment = taRightJustify
              Caption = 'Fax:'
            end
            object sLabel39: TsLabel
              Left = 129
              Top = 84
              Width = 63
              Height = 13
              Alignment = taRightJustify
              Caption = 'VAT Number:'
            end
            object edCompany: TsEdit
              Left = 198
              Top = 54
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2302755
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edCompAddress1: TsEdit
              Left = 198
              Top = 268
              Width = 241
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
              BoundLabel.Caption = 'test'
            end
            object edCompAddress2: TsEdit
              Left = 198
              Top = 295
              Width = 241
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
              BoundLabel.Caption = 'test'
            end
            object edCompZipcode: TsEdit
              Left = 198
              Top = 322
              Width = 241
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
              BoundLabel.Caption = 'test'
            end
            object edCompCity: TsEdit
              Left = 198
              Top = 349
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2302755
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edCompCountry: TsEdit
              Left = 198
              Top = 376
              Width = 34
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2302755
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object sButton4: TsButton
              Left = 233
              Top = 376
              Width = 23
              Height = 21
              Caption = '...'
              TabOrder = 9
              OnClick = sButton4Click
              SkinData.SkinSection = 'BUTTON'
            end
            object edCompEmail: TsEdit
              Left = 198
              Top = 200
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2302755
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edCompTelNumber: TsEdit
              Left = 198
              Top = 146
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2302755
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edFax: TsEdit
              Left = 198
              Top = 173
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2302755
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object edVAT: TsEdit
              Left = 198
              Top = 81
              Width = 241
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2302755
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
          end
        end
        object sButton2: TsButton
          Left = 336
          Top = 3
          Width = 105
          Height = 41
          HelpContext = 2
          Caption = 'Registration form'
          TabOrder = 1
          OnClick = sButton2Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton6: TsButton
          Left = 200
          Top = 3
          Width = 130
          Height = 41
          HelpContext = 3
          Caption = 'Form design mode'
          TabOrder = 2
          OnClick = sButton6Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object sPanel2: TsPanel
        Left = 473
        Top = 0
        Width = 361
        Height = 560
        Align = alClient
        Padding.Left = 5
        Padding.Top = 5
        Padding.Right = 5
        Padding.Bottom = 5
        TabOrder = 1
        OnDblClick = sPanel2DblClick
        SkinData.SkinSection = 'TRANSPARENT'
        object sLabel8: TsLabel
          Left = 6
          Top = 6
          Width = 349
          Height = 25
          Align = alTop
          Caption = 'Payment guarantee'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ExplicitWidth = 183
        end
        object sLabel10: TsLabel
          Left = 103
          Top = 256
          Width = 80
          Height = 13
          Alignment = taRightJustify
          Caption = 'Guarantee type:'
        end
        object sLabel33: TsLabel
          Left = 129
          Top = 102
          Width = 54
          Height = 13
          Alignment = taRightJustify
          Caption = 'Room rent:'
        end
        object lbRoomRent: TsLabel
          Left = 193
          Top = 102
          Width = 80
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
        end
        object sLabel35: TsLabel
          Left = 16
          Top = 73
          Width = 104
          Height = 16
          Caption = 'Current Balance'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object sLabel36: TsLabel
          Left = 154
          Top = 119
          Width = 29
          Height = 13
          Alignment = taRightJustify
          Caption = 'Sales:'
        end
        object lbSales: TsLabel
          Left = 193
          Top = 119
          Width = 80
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
        end
        object sLabel38: TsLabel
          Left = 136
          Top = 157
          Width = 47
          Height = 13
          Alignment = taRightJustify
          Caption = 'Sub total:'
        end
        object lbSubTotal: TsLabel
          Left = 193
          Top = 157
          Width = 80
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
        end
        object Shape1: TShape
          Left = 189
          Top = 152
          Width = 86
          Height = 1
        end
        object sLabel40: TsLabel
          Left = 132
          Top = 173
          Width = 51
          Height = 13
          Alignment = taRightJustify
          Caption = 'Payments:'
        end
        object lbPAyments: TsLabel
          Left = 193
          Top = 173
          Width = 80
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
        end
        object Shape2: TShape
          Left = 189
          Top = 189
          Width = 86
          Height = 1
        end
        object sLabel42: TsLabel
          Left = 90
          Top = 194
          Width = 93
          Height = 13
          Alignment = taRightJustify
          Caption = 'Current balance:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object lbBalance: TsLabel
          Left = 193
          Top = 194
          Width = 80
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object sLabel44: TsLabel
          Left = 16
          Top = 223
          Width = 68
          Height = 16
          Caption = 'Guarantee'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object shpGuarantee: TShape
          Left = 342
          Top = 254
          Width = 16
          Height = 17
          Brush.Color = clRed
          Pen.Color = clRed
          Shape = stCircle
          Visible = False
        end
        object sLabel41: TsLabel
          Left = 123
          Top = 136
          Width = 60
          Height = 13
          Alignment = taRightJustify
          Caption = 'Extra taxes:'
        end
        object lbTaxes: TsLabel
          Left = 193
          Top = 136
          Width = 80
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
        end
        object cbxGuaranteeTypes: TsComboBox
          Left = 189
          Top = 253
          Width = 149
          Height = 21
          Alignment = taLeftJustify
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 3
          ParentFont = False
          TabOrder = 0
          Text = 'Select'
          OnCloseUp = cbxGuaranteeTypesCloseUp
          Items.Strings = (
            'Credit card'
            'Down payment'
            'No guarantee provided'
            'Select')
        end
        object pgGuaranteeTypes: TsPageControl
          Left = 16
          Top = 294
          Width = 326
          Height = 170
          ActivePage = sTabSheet3
          TabOrder = 1
          SkinData.SkinSection = 'PAGECONTROL'
          object sTabSheet3: TsTabSheet
            Caption = 'Credit card'
            object sLabel12: TsLabel
              Left = 66
              Top = 69
              Width = 227
              Height = 68
              AutoSize = False
              Caption = 
                'Please make sure to make an imprint of credit card or block a su' +
                'fficient amount.'
              WordWrap = True
            end
            object shpCC: TShape
              Left = 300
              Top = 31
              Width = 16
              Height = 17
              Brush.Color = clRed
              Pen.Color = clRed
              Shape = stCircle
              Visible = False
            end
            object cbCreditCard: TsCheckBox
              Left = 47
              Top = 20
              Width = 247
              Height = 38
              Caption = '* Credit card provided as guarantee'
              AutoSize = False
              TabOrder = 0
              OnClick = cbCreditCardClick
              SkinData.SkinSection = 'CHECKBOX'
              ImgChecked = 0
              ImgUnchecked = 0
              WordWrap = True
            end
          end
          object sTabSheet4: TsTabSheet
            Caption = 'Cash'
            object sLabel16: TsLabel
              Left = 38
              Top = 21
              Width = 50
              Height = 13
              Alignment = taRightJustify
              Caption = '* Amount:'
            end
            object sLabel11: TsLabel
              Left = 94
              Top = 45
              Width = 211
              Height = 75
              AutoSize = False
              Caption = 'This amount will appear as down-payment on the guest'#39's invoice.'
              WordWrap = True
            end
            object lbPayment: TsLabel
              Left = 189
              Top = 21
              Width = 133
              Height = 13
              AutoSize = False
            end
            object shpCash: TShape
              Left = 298
              Top = 19
              Width = 16
              Height = 17
              Brush.Color = clRed
              Pen.Color = clRed
              Shape = stCircle
              Visible = False
            end
            object edAmount: TsEdit
              Left = 94
              Top = 18
              Width = 67
              Height = 21
              Alignment = taRightJustify
              Color = clWhite
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2302755
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              MaxLength = 7
              NumbersOnly = True
              ParentFont = False
              TabOrder = 0
              TextHint = 'Amount'
              OnChange = edLastNameChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Caption = 'test'
            end
            object sButton5: TsButton
              Left = 162
              Top = 18
              Width = 23
              Height = 21
              Caption = '...'
              TabOrder = 1
              OnClick = sButton5Click
              SkinData.SkinSection = 'BUTTON'
            end
            object pnlHidePayment: TsPanel
              Left = 56
              Top = 80
              Width = 185
              Height = 41
              TabOrder = 2
              Visible = False
              SkinData.SkinSection = 'PANEL'
            end
          end
          object sTabSheet5: TsTabSheet
            Caption = 'None'
          end
          object sTabSheet7: TsTabSheet
            Caption = 'Select'
          end
        end
      end
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 588
    Width = 842
    Height = 33
    Align = alBottom
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      842
      33)
    object btnCancel: TsButton
      Left = 700
      Top = 4
      Width = 131
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
      Left = 564
      Top = 4
      Width = 130
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      Enabled = False
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object rptForm: TfrxReport
    Version = '4.13.2'
    DataSet = dsForm
    DataSetName = 'frxDBDataset1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42022.613734120370000000
    ReportOptions.LastChange = 42022.613734120370000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 496
    Top = 520
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
    end
  end
  object dsForm: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 496
    Top = 408
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 496
    Top = 464
  end
end
