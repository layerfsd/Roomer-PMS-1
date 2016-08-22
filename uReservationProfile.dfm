object frmReservationProfile: TfrmReservationProfile
  Left = 739
  Top = 201
  Caption = 'Reservation profile'
  ClientHeight = 662
  ClientWidth = 1120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 11
  object Panel2: TsPanel
    Left = 0
    Top = 0
    Width = 1120
    Height = 110
    Align = alTop
    BevelOuter = bvSpace
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object gbxDates: TsGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 4
      Width = 186
      Height = 102
      Margins.Left = 5
      Align = alLeft
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object Label2: TsLabel
        Left = 65
        Top = 13
        Width = 31
        Height = 11
        Alignment = taRightJustify
        Caption = 'Arrival:'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label3: TsLabel
        Left = 52
        Top = 34
        Width = 44
        Height = 11
        Alignment = taRightJustify
        Caption = 'Departure:'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cxButton3: TsButton
        Left = 4
        Top = 53
        Width = 175
        Height = 32
        Caption = 'Change reservation dates'
        ImageIndex = 51
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = cxButton3Click
        SkinData.SkinSection = 'BUTTON'
      end
      object dtDeparture: TsDateEdit
        Left = 103
        Top = 31
        Width = 76
        Height = 19
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        Text = '  -  -    '
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtArrival: TsDateEdit
        Left = 103
        Top = 10
        Width = 76
        Height = 19
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = '  -  -    '
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
    object gbxResProperties: TsGroupBox
      AlignWithMargins = True
      Left = 200
      Top = 4
      Width = 273
      Height = 102
      Margins.Left = 5
      Align = alLeft
      Padding.Left = 5
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object Label8: TsLabel
        Left = 41
        Top = 36
        Width = 72
        Height = 11
        Alignment = taRightJustify
        Caption = 'Market Segment:'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object lblCustomerType: TsLabel
        Left = 201
        Top = 36
        Width = 3
        Height = 11
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sLabel1: TsLabel
        Left = 52
        Top = 59
        Width = 61
        Height = 11
        Alignment = taRightJustify
        Caption = 'Guest country:'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labCountry: TsLabel
        Left = 201
        Top = 59
        Width = 3
        Height = 11
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label61: TsLabel
        Left = 36
        Top = 82
        Width = 131
        Height = 11
        Alignment = taRightJustify
        Caption = 'Activate local taxes on invoice :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object lblMarket: TsLabel
        Left = 78
        Top = 14
        Width = 35
        Height = 11
        Alignment = taRightJustify
        Caption = 'Market :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edtType: TsEdit
        Left = 119
        Top = 33
        Width = 56
        Height = 20
        TabStop = False
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 30
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        OnDblClick = edtTypeDblClick
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object btnGetCustomerType: TsButton
        Left = 176
        Top = 33
        Width = 19
        Height = 19
        Caption = '...'
        TabOrder = 1
        OnClick = edtTypeDblClick
        SkinData.SkinSection = 'BUTTON'
      end
      object edCountry: TsEdit
        Left = 119
        Top = 56
        Width = 56
        Height = 20
        TabStop = False
        CharCase = ecUpperCase
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 30
        ParentFont = False
        TabOrder = 2
        OnChange = edCountryChange
        OnDblClick = edCountryDblClick
        OnExit = edCountryExit
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object btnGetCountry: TsButton
        Left = 176
        Top = 57
        Width = 19
        Height = 18
        Caption = '...'
        TabOrder = 3
        OnClick = edCountryDblClick
        SkinData.SkinSection = 'BUTTON'
      end
      object chkUseStayTax: TsCheckBox
        Left = 176
        Top = 79
        Width = 20
        Height = 20
        TabOrder = 4
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object cbxMarket: TsComboBox
        Left = 119
        Top = 11
        Width = 76
        Height = 19
        Alignment = taLeftJustify
        BoundLabel.Caption = 'Market:'
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csDropDownList
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 0
        OnCloseUp = cbxMarketCloseUp
        Items.Strings = (
          'Leisure'
          'Business')
      end
    end
    object gbxNumbers: TsGroupBox
      AlignWithMargins = True
      Left = 794
      Top = 4
      Width = 277
      Height = 102
      Margins.Left = 5
      Align = alLeft
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object clabReserveDate: TsLabel
        Left = 78
        Top = 10
        Width = 42
        Height = 11
        Alignment = taRightJustify
        Caption = 'Reserved:'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object __labReserveDate: TsLabel
        Left = 128
        Top = 10
        Width = 3
        Height = 11
        Caption = '-'
        Color = clMoneyGreen
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label5: TsLabel
        Left = 94
        Top = 23
        Width = 26
        Height = 11
        Alignment = taRightJustify
        Caption = 'Staff :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object __labStaff: TsLabel
        Left = 128
        Top = 23
        Width = 3
        Height = 11
        Caption = '-'
        Color = clMoneyGreen
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object __labResNumbers: TsLabel
        Left = 132
        Top = 36
        Width = 3
        Height = 11
        Caption = '/'
        Color = clMoneyGreen
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sLabel4: TsLabel
        Left = 52
        Top = 36
        Width = 68
        Height = 11
        Alignment = taRightJustify
        Caption = 'Reservation no :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sButton1: TsButton
        Left = 6
        Top = 53
        Width = 265
        Height = 32
        Caption = 'Reservation Documents'
        ImageIndex = 0
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = sButton1Click
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object gbxStatus: TsGroupBox
      AlignWithMargins = True
      Left = 481
      Top = 4
      Width = 305
      Height = 102
      Margins.Left = 5
      Align = alLeft
      TabOrder = 3
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object Label25: TsLabel
        Left = 68
        Top = 13
        Width = 70
        Height = 11
        Alignment = taRightJustify
        Caption = 'Payment details:'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label24: TsLabel
        Left = 98
        Top = 36
        Width = 42
        Height = 11
        Alignment = taRightJustify
        Caption = 'Breakfast:'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label26: TsLabel
        Left = 111
        Top = 59
        Width = 29
        Height = 11
        Alignment = taRightJustify
        Caption = 'Status:'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cbxStatus: TsComboBox
        Left = 144
        Top = 56
        Width = 154
        Height = 19
        Alignment = taLeftJustify
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csDropDownList
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 0
        OnCloseUp = cbxStatusCloseUp
        OnEnter = cbxStatusEnter
        Items.Strings = (
          'Mixed'
          'Not arrived'
          'Checked in'
          'Departed'
          'Waitinglist'
          'Alotment'
          'No-show'
          'Blocked'
          'Canceled'
          '[Unused]')
      end
      object cbxBreakfast: TsComboBox
        Left = 144
        Top = 33
        Width = 154
        Height = 19
        Alignment = taLeftJustify
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csDropDownList
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 1
        Text = 'Mixed'
        OnCloseUp = cbxBreakfastCloseUp
        Items.Strings = (
          'Mixed'
          'Included'
          'Not Included')
      end
      object cbxPaymentdetails: TsComboBox
        Left = 144
        Top = 10
        Width = 154
        Height = 19
        Alignment = taLeftJustify
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csDropDownList
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 2
        OnCloseUp = cbxPaymentdetailsCloseUp
        Items.Strings = (
          'Mixed'
          'Room Account'
          'Group Account')
      end
    end
  end
  object PageControl2: TsPageControl
    Left = 0
    Top = 110
    Width = 1120
    Height = 202
    ActivePage = TabSheet3
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PAGECONTROL'
    object TabSheet3: TsTabSheet
      Caption = 'Main'
      TabVisible = False
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel3: TsPanel
        Left = 0
        Top = 0
        Width = 1112
        Height = 192
        Align = alClient
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object Panel4: TsPanel
          Left = 1
          Top = 1
          Width = 213
          Height = 190
          Align = alLeft
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
          object PageControl3: TsPageControl
            Left = 1
            Top = 1
            Width = 211
            Height = 188
            ActivePage = TabSheet4
            Align = alClient
            TabOrder = 0
            SkinData.SkinSection = 'PAGECONTROL'
            object TabSheet4: TsTabSheet
              Caption = 'Customer'
              SkinData.CustomColor = False
              SkinData.CustomFont = False
              object Label9: TsLabel
                Left = 2
                Top = 3
                Width = 50
                Height = 11
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Customer:'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object Label19: TsLabel
                Left = 1
                Top = 24
                Width = 51
                Height = 11
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'PersonalID:'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object Label6: TsLabel
                Left = 1
                Top = 45
                Width = 51
                Height = 11
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Name:'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object Label7: TsLabel
                Left = 1
                Top = 66
                Width = 51
                Height = 11
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Address:'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object Bevel4: TBevel
                Left = 3
                Top = 148
                Width = 214
                Height = 3
                Shape = bsTopLine
              end
              object Label4: TsLabel
                Left = 1
                Top = 129
                Width = 51
                Height = 11
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Refrence:'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object edtCustomer: TsEdit
                Left = 58
                Top = 1
                Width = 69
                Height = 20
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 30
                ParentFont = False
                TabOrder = 0
                OnDblClick = edGetCustomerClick
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtKennitala: TsEdit
                Left = 58
                Top = 21
                Width = 140
                Height = 20
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 30
                ParentFont = False
                TabOrder = 1
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtName: TsEdit
                Left = 58
                Top = 42
                Width = 140
                Height = 20
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 30
                ParentFont = False
                TabOrder = 2
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtAddress1: TsEdit
                Left = 58
                Top = 63
                Width = 140
                Height = 20
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 30
                ParentFont = False
                TabOrder = 3
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtAddress2: TsEdit
                Left = 58
                Top = 84
                Width = 140
                Height = 20
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 30
                ParentFont = False
                TabOrder = 4
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtAddress3: TsEdit
                Left = 58
                Top = 105
                Width = 140
                Height = 20
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 30
                ParentFont = False
                TabOrder = 5
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtInvRefrence: TsEdit
                Left = 58
                Top = 126
                Width = 140
                Height = 20
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 100
                ParentFont = False
                TabOrder = 6
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edGetCustomer: TsButton
                Left = 133
                Top = 1
                Width = 19
                Height = 18
                Caption = '..'
                TabOrder = 7
                OnClick = edGetCustomerClick
                SkinData.SkinSection = 'BUTTON'
              end
            end
            object TabSheet5: TsTabSheet
              Caption = 'Customer Tel / Email'
              ImageIndex = 1
              SkinData.CustomColor = False
              SkinData.CustomFont = False
              object Label10: TsLabel
                Left = 33
                Top = 13
                Width = 18
                Height = 13
                Alignment = taRightJustify
                Caption = 'Tel:'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object Label11: TsLabel
                Left = 29
                Top = 34
                Width = 22
                Height = 13
                Alignment = taRightJustify
                Caption = 'Fax:'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object Label14: TsLabel
                Left = 20
                Top = 55
                Width = 31
                Height = 13
                Alignment = taRightJustify
                Caption = 'Email :'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object Label15: TsLabel
                Left = 9
                Top = 75
                Width = 42
                Height = 13
                Alignment = taRightJustify
                Caption = 'Web site'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object edtTel1: TsEdit
                Left = 53
                Top = 12
                Width = 75
                Height = 20
                Color = 3355443
                Font.Charset = ANSI_CHARSET
                Font.Color = 15724527
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 30
                ParentFont = False
                TabOrder = 0
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtTel2: TsEdit
                Left = 130
                Top = 12
                Width = 71
                Height = 20
                Color = 3355443
                Font.Charset = ANSI_CHARSET
                Font.Color = 15724527
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 30
                ParentFont = False
                TabOrder = 1
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtFax: TsEdit
                Left = 53
                Top = 33
                Width = 74
                Height = 20
                Color = 3355443
                Font.Charset = ANSI_CHARSET
                Font.Color = 15724527
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 15
                ParentFont = False
                TabOrder = 2
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtCustomerEmail: TsEdit
                Left = 53
                Top = 54
                Width = 148
                Height = 19
                Color = 3355443
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 15724527
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
                MaxLength = 30
                ParentFont = False
                TabOrder = 3
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtCustomerWebSite: TsEdit
                Left = 53
                Top = 74
                Width = 148
                Height = 19
                Color = 3355443
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 15724527
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
                MaxLength = 30
                ParentFont = False
                TabOrder = 4
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
            end
          end
        end
        object sGroupBox1: TsGroupBox
          Left = 214
          Top = 1
          Width = 202
          Height = 190
          Align = alLeft
          Caption = 'Contact'
          TabOrder = 1
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object Label20: TsLabel
            Left = 21
            Top = 16
            Width = 28
            Height = 11
            Alignment = taRightJustify
            Caption = 'Name:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel3: TsLabel
            Left = -1
            Top = 36
            Width = 50
            Height = 11
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Address:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object edtContact: TsLabel
            Left = -2
            Top = 120
            Width = 51
            Height = 11
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Country:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object Label21: TsLabel
            Left = -8
            Top = 141
            Width = 57
            Height = 11
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Tel:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object Label23: TsLabel
            Left = 23
            Top = 162
            Width = 26
            Height = 11
            Alignment = taRightJustify
            Caption = 'Email:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel6: TsLabel
            Left = -1
            Top = 78
            Width = 50
            Height = 11
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Zip:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object sLabel7: TsLabel
            Left = -1
            Top = 99
            Width = 50
            Height = 11
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'City:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object edtContactName: TsEdit
            Left = 54
            Top = 13
            Width = 141
            Height = 19
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 0
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtContactAddress1: TsEdit
            Left = 54
            Top = 33
            Width = 141
            Height = 20
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 1
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtContactAddress2: TsEdit
            Left = 54
            Top = 54
            Width = 141
            Height = 20
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 2
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtContactAddress3: TsEdit
            Left = 54
            Top = 75
            Width = 141
            Height = 20
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 3
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtContactPhone: TsEdit
            Left = 54
            Top = 138
            Width = 66
            Height = 19
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 40
            ParentFont = False
            TabOrder = 6
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtContactPhone2: TsEdit
            Left = 123
            Top = 138
            Width = 72
            Height = 19
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 40
            ParentFont = False
            TabOrder = 7
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtContactCountry: TsEdit
            Left = 54
            Top = 117
            Width = 27
            Height = 20
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 5
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtContactEmail: TsEdit
            Left = 54
            Top = 159
            Width = 141
            Height = 19
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 8
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtContactAddress4: TsEdit
            Left = 54
            Top = 96
            Width = 141
            Height = 20
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 4
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
        end
        object memPanel: TsPanel
          Left = 424
          Top = 1
          Width = 687
          Height = 190
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          BorderWidth = 5
          ParentBackground = False
          TabOrder = 2
          SkinData.SkinSection = 'PANEL'
          object cxSplitter2: TsSplitter
            Left = 241
            Top = 6
            Width = 7
            Height = 142
            SkinData.SkinSection = 'SPLITTER'
            ExplicitLeft = 221
            ExplicitTop = 32
            ExplicitHeight = 113
          end
          object sSplitter1: TsSplitter
            Left = 465
            Top = 6
            Width = 7
            Height = 142
            SkinData.SkinSection = 'SPLITTER'
            ExplicitLeft = 430
            ExplicitTop = 32
            ExplicitHeight = 113
          end
          object GroupBox1: TsGroupBox
            Left = 6
            Top = 6
            Width = 235
            Height = 142
            Align = alLeft
            Caption = 'General Information'
            TabOrder = 0
            SkinData.SkinSection = 'GROUPBOX'
            Checked = False
            object memInformation: TsMemo
              Left = 2
              Top = 13
              Width = 231
              Height = 127
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
              SkinData.SkinSection = 'EDIT'
            end
          end
          object GroupBox2: TsGroupBox
            Left = 248
            Top = 6
            Width = 217
            Height = 142
            Align = alLeft
            Caption = 'Payment Information'
            TabOrder = 1
            SkinData.SkinSection = 'GROUPBOX'
            Checked = False
            object memPMInfo: TsMemo
              Left = 2
              Top = 13
              Width = 213
              Height = 127
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
              SkinData.SkinSection = 'EDIT'
            end
          end
          object Panel8: TsPanel
            Left = 6
            Top = 148
            Width = 675
            Height = 36
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alBottom
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 2
            SkinData.SkinSection = 'PANEL'
            object btnShowHiddenMemo: TsButton
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 155
              Height = 30
              Align = alLeft
              Caption = 'Show hidden memo'
              TabOrder = 0
              OnClick = btnShowHiddenMemoClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnClipboardToHinndenMemo: TsButton
              AlignWithMargins = True
              Left = 164
              Top = 3
              Width = 155
              Height = 30
              Align = alLeft
              Caption = 'Clipboard to hidden memo'
              TabOrder = 1
              OnClick = btnClipboardToHinndenMemoClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnPasteFile: TsButton
              AlignWithMargins = True
              Left = 325
              Top = 3
              Width = 155
              Height = 30
              Align = alLeft
              Caption = 'Paste files into documents'
              TabOrder = 2
              OnClick = btnPasteFileClick
              SkinData.SkinSection = 'BUTTON'
            end
          end
          object gbxRoomInformation: TsGroupBox
            Left = 472
            Top = 6
            Width = 209
            Height = 142
            Align = alLeft
            Caption = 'Notes for room : '
            TabOrder = 3
            SkinData.SkinSection = 'GROUPBOX'
            Checked = False
            object sLabel5: TsLabel
              Left = 2
              Top = 65
              Width = 205
              Height = 11
              Align = alTop
              Caption = 'Request from booking channel'
              ExplicitWidth = 124
            end
            object memRoomNotes: TsMemo
              Left = 2
              Top = 13
              Width = 205
              Height = 52
              Align = alTop
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
              OnExit = memRoomNotesExit
              SkinData.SkinSection = 'EDIT'
            end
            object memRequestFromChannel: TsMemo
              Left = 2
              Top = 76
              Width = 205
              Height = 64
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              ScrollBars = ssVertical
              TabOrder = 1
              SkinData.SkinSection = 'EDIT'
            end
          end
        end
        object cxSplitter1: TcxSplitter
          Left = 416
          Top = 1
          Width = 8
          Height = 190
          HotZoneClassName = 'TcxMediaPlayer9Style'
          NativeBackground = False
          Control = sGroupBox1
          Color = clNone
          ParentColor = False
        end
      end
    end
  end
  object mainPage: TsPageControl
    Left = 0
    Top = 312
    Width = 1120
    Height = 317
    ActivePage = RoomsTab
    Align = alClient
    Style = tsButtons
    TabHeight = 25
    TabOrder = 2
    TabWidth = 100
    OnChange = mainPageChange
    ShowFocus = False
    SkinData.SkinSection = 'PAGECONTROL'
    object RoomsTab: TsTabSheet
      Caption = 'Rooms'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object grRooms: TcxGrid
        Left = 0
        Top = 82
        Width = 1112
        Height = 200
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        Images = DImages.cxSmallImagesFlat
        ParentFont = False
        TabOrder = 0
        LookAndFeel.NativeStyle = False
        object tvRooms: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          OnCellDblClick = tvRoomsCellDblClick
          OnInitEdit = tvRoomsInitEdit
          OnUpdateEdit = tvRoomsUpdateEdit
          DataController.DataSource = mRoomsDS
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0 nights;-#,##0 nights'
              Kind = skSum
              FieldName = 'dayCount'
              Column = tvRoomsdayCount
            end
            item
              Format = '#,##0 rooms;-#,##0 rooms'
              Kind = skCount
              FieldName = 'Room'
              Column = tvRoomsRoom
            end
            item
              Kind = skMin
              FieldName = 'Arrival'
              Column = tvRoomsArrival
              VisibleForCustomization = False
            end
            item
              Kind = skMax
              FieldName = 'Departure'
              Column = tvRoomsDeparture
            end
            item
              Format = '#,##0 guests;-#,##0 guests'
              Kind = skSum
              FieldName = 'GuestCount'
              Column = tvRoomsGuestCount
            end
            item
              Format = '###0.00;###0.00'
              Kind = skSum
              FieldName = 'TotalUnpaidRoomRent'
              Column = tvRoomsTotalUnpaidRoomRent
            end
            item
              Format = '###0.00;###0.00'
              Kind = skSum
              FieldName = 'unPaidRoomRent'
              Column = tvRoomsunPaidRoomRent
            end
            item
              Format = '###0.00;###0.00'
              Kind = skSum
              FieldName = 'DiscountUnpaidRoomRent'
              Column = tvRoomsDiscountUnpaidRoomRent
            end
            item
              Format = '#,##0 nights;-#,##0 nights'
              Kind = skSum
              FieldName = 'unpaidRentNights'
              Column = tvRoomsunpaidRentNights
            end
            item
              OnGetText = tvRoomsTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText
              FieldName = 'unpaidRentPrice'
              Column = tvRoomsunpaidRentPrice
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.AlwaysShowEditor = True
          OptionsBehavior.FocusCellOnTab = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object tvRoomsRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvRoomsReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
            Visible = False
          end
          object tvRoomsRoomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'RoomReservation'
            Visible = False
          end
          object tvRoomsRoom: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
            Options.Editing = False
          end
          object tvRoomsblockMove: TcxGridDBColumn
            Caption = 'Block'
            DataBinding.FieldName = 'blockMove'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.OnChange = tvRoomsblockMovePropertiesChange
            OnGetCellHint = tvRoomsblockMoveGetCellHint
          end
          object tvRoomsColumn1: TcxGridDBColumn
            Caption = 'FIL'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.OnButtonClick = tvRoomsColumn1PropertiesButtonClick
            Width = 20
          end
          object tvRoomsRoomType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'RoomType'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = tvRoomsRoomTypePropertiesButtonClick
            Width = 79
          end
          object tvRoomsRoomClass: TcxGridDBColumn
            DataBinding.FieldName = 'RoomClass'
            Visible = False
          end
          object tvRoomsRoomClassDescription: TcxGridDBColumn
            Caption = 'Channel Type'
            DataBinding.FieldName = 'RoomClassDescription'
            Width = 141
          end
          object tvRoomsArrival: TcxGridDBColumn
            DataBinding.FieldName = 'Arrival'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  20000000000000040000C30E0000C30E00000000000000000000254B5CD62E50
                  618C364851373942472333383B23303233223031311C31313117303030113030
                  300C3030300730303004303030023030300100000000000000002D5163756C94
                  A7FF638597FA334955B82C33375E3131313E3131313D31313139313131333131
                  312B313131233030301B313131143030300C3030300500000000456A7C0E5D84
                  98F19AC3D8FF96BBCEFF688A9DFC203A4AB327353D2E2F3334183030301C3131
                  311F3030301F3131311C31313117313131123131310A00000000000000004366
                  798E99C9E0FF90B8CCFF4F8398FF4FABC9FF0C4967DB2651641D2A444F012B34
                  38042E3031062F2F2F072F2F2F07313131063131310400000000000000004B73
                  871B658EA3F94E8095FF66D6F5FF64DBFCFF5AC1E0FF0C4A68DC245D741C0000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000275268A542ABC5FF69E5FEFF51DBFEFF5CD9FDFF5AC1E0FF0C4C6BDC246E
                  8C1C000000000000000000000000000000000000000000000000000000000000
                  0000276F8B1A0C5677DA6DCDE3FF8AEAFFFF52DBFEFF5CD9FDFF5BC2E1FF0C4C
                  6CDC2371911D0000000000000000000000000000000000000000000000000000
                  0000000000002B7D9B1B0E587ADA6FCDE4FF8AEAFFFF52DCFEFF5CD9FDFF5BC2
                  E1FF0D4D6DDC2572921E00000000000000000000000000000000000000000000
                  000000000000000000002D7E9D1B0E5A7CDA6FCDE4FF8AEAFFFF53DCFEFF5CD9
                  FDFF5BC3E2FF0D4F6FDD2F667E1E000000000000000000000000000000000000
                  00000000000000000000000000002D809E1A0D5B7DD96ECDE4FF8AEAFFFF54DC
                  FEFF5BD9FDFF598E9EFF41525CDD485F721E0000000000000000000000000000
                  0000000000000000000000000000000000002D809F1A0D5B7FD96ECDE4FF8AEA
                  FFFF66ADBEFF898787FF9C9A9AFF45505DDE3C437D1E00000000000000000000
                  000000000000000000000000000000000000000000002F809F1A0E5B7ED972A4
                  B1FFB4B3B4FFD2D1D2FFA9A8A8FF5F5D76FF161689D93033A01A000000000000
                  00000000000000000000000000000000000000000000000000003D78901A5265
                  6FD9AEADADFFCDCCCDFF7B7A92FF6868E0FF5858D8FF131497C3000000000000
                  0000000000000000000000000000000000000000000000000000000000005972
                  88195A6572D97C7F90FF7384E4FF7487E9FF6B81E8FF1C20ADFB000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00004A539A1F171AACD9657ADFFF8F9FF1FF4050CCFF1B1FB583000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000003841B9171011B7B21E20BFF01D22BD7F00000000}
                Kind = bkGlyph
              end>
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = tvRoomsArrivalPropertiesButtonClick
            Options.IncSearch = False
            Options.ShowEditButtons = isebAlways
            Width = 73
          end
          object tvRoomsExpectedTimeOfArrival: TcxGridDBColumn
            Caption = 'Exp TOA'
            DataBinding.FieldName = 'ExpectedTimeOfArrival'
            PropertiesClassName = 'TcxTimeEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ClearKey = 46
            Properties.SpinButtons.Visible = False
            Properties.TimeFormat = tfHourMin
            Properties.UseNullString = True
            Properties.UseTimeFormatWhenUnfocused = False
            OnGetDisplayText = FormatTextToShortFormat
            OnGetProperties = GetLocaltimeEditProperties
            HeaderAlignmentHorz = taCenter
            HeaderHint = 'Expected Time of Arrival'
            Width = 62
          end
          object tvRoomsDeparture: TcxGridDBColumn
            DataBinding.FieldName = 'Departure'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  20000000000000040000C30E0000C30E00000000000000000000254B5CD62E50
                  618C364851373942472333383B23303233223031311C31313117303030113030
                  300C3030300730303004303030023030300100000000000000002D5163756C94
                  A7FF638597FA334955B82C33375E3131313E3131313D31313139313131333131
                  312B313131233030301B313131143030300C3030300500000000456A7C0E5D84
                  98F19AC3D8FF96BBCEFF688A9DFC203A4AB327353D2E2F3334183030301C3131
                  311F3030301F3131311C31313117313131123131310A00000000000000004366
                  798E99C9E0FF90B8CCFF4F8398FF4FABC9FF0C4967DB2651641D2A444F012B34
                  38042E3031062F2F2F072F2F2F07313131063131310400000000000000004B73
                  871B658EA3F94E8095FF66D6F5FF64DBFCFF5AC1E0FF0C4A68DC245D741C0000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000275268A542ABC5FF69E5FEFF51DBFEFF5CD9FDFF5AC1E0FF0C4C6BDC246E
                  8C1C000000000000000000000000000000000000000000000000000000000000
                  0000276F8B1A0C5677DA6DCDE3FF8AEAFFFF52DBFEFF5CD9FDFF5BC2E1FF0C4C
                  6CDC2371911D0000000000000000000000000000000000000000000000000000
                  0000000000002B7D9B1B0E587ADA6FCDE4FF8AEAFFFF52DCFEFF5CD9FDFF5BC2
                  E1FF0D4D6DDC2572921E00000000000000000000000000000000000000000000
                  000000000000000000002D7E9D1B0E5A7CDA6FCDE4FF8AEAFFFF53DCFEFF5CD9
                  FDFF5BC3E2FF0D4F6FDD2F667E1E000000000000000000000000000000000000
                  00000000000000000000000000002D809E1A0D5B7DD96ECDE4FF8AEAFFFF54DC
                  FEFF5BD9FDFF598E9EFF41525CDD485F721E0000000000000000000000000000
                  0000000000000000000000000000000000002D809F1A0D5B7FD96ECDE4FF8AEA
                  FFFF66ADBEFF898787FF9C9A9AFF45505DDE3C437D1E00000000000000000000
                  000000000000000000000000000000000000000000002F809F1A0E5B7ED972A4
                  B1FFB4B3B4FFD2D1D2FFA9A8A8FF5F5D76FF161689D93033A01A000000000000
                  00000000000000000000000000000000000000000000000000003D78901A5265
                  6FD9AEADADFFCDCCCDFF7B7A92FF6868E0FF5858D8FF131497C3000000000000
                  0000000000000000000000000000000000000000000000000000000000005972
                  88195A6572D97C7F90FF7384E4FF7487E9FF6B81E8FF1C20ADFB000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00004A539A1F171AACD9657ADFFF8F9FF1FF4050CCFF1B1FB583000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000003841B9171011B7B21E20BFF01D22BD7F00000000}
                Kind = bkGlyph
              end>
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = tvRoomsDeparturePropertiesButtonClick
            Options.IncSearch = False
            Options.ShowEditButtons = isebAlways
            Width = 78
          end
          object tvRoomsExpectedCheckoutTime: TcxGridDBColumn
            Caption = 'Exp COT'
            DataBinding.FieldName = 'ExpectedCheckoutTime'
            PropertiesClassName = 'TcxTimeEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ClearKey = 46
            Properties.SpinButtons.Visible = False
            Properties.TimeFormat = tfHourMin
            Properties.UseTimeFormatWhenUnfocused = False
            OnGetDisplayText = FormatTextToShortFormat
            OnGetProperties = GetLocaltimeEditProperties
            HeaderAlignmentHorz = taCenter
            HeaderHint = 'Expected CheckoutTime'
            Width = 68
          end
          object tvRoomsdayCount: TcxGridDBColumn
            Caption = 'Nights'
            DataBinding.FieldName = 'dayCount'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Buttons = <
              item
                Default = True
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  20000000000000040000C30E0000C30E00000000000000000000254B5CD62E50
                  618C364851373942472333383B23303233223031311C31313117303030113030
                  300C3030300730303004303030023030300100000000000000002D5163756C94
                  A7FF638597FA334955B82C33375E3131313E3131313D31313139313131333131
                  312B313131233030301B313131143030300C3030300500000000456A7C0E5D84
                  98F19AC3D8FF96BBCEFF688A9DFC203A4AB327353D2E2F3334183030301C3131
                  311F3030301F3131311C31313117313131123131310A00000000000000004366
                  798E99C9E0FF90B8CCFF4F8398FF4FABC9FF0C4967DB2651641D2A444F012B34
                  38042E3031062F2F2F072F2F2F07313131063131310400000000000000004B73
                  871B658EA3F94E8095FF66D6F5FF64DBFCFF5AC1E0FF0C4A68DC245D741C0000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000275268A542ABC5FF69E5FEFF51DBFEFF5CD9FDFF5AC1E0FF0C4C6BDC246E
                  8C1C000000000000000000000000000000000000000000000000000000000000
                  0000276F8B1A0C5677DA6DCDE3FF8AEAFFFF52DBFEFF5CD9FDFF5BC2E1FF0C4C
                  6CDC2371911D0000000000000000000000000000000000000000000000000000
                  0000000000002B7D9B1B0E587ADA6FCDE4FF8AEAFFFF52DCFEFF5CD9FDFF5BC2
                  E1FF0D4D6DDC2572921E00000000000000000000000000000000000000000000
                  000000000000000000002D7E9D1B0E5A7CDA6FCDE4FF8AEAFFFF53DCFEFF5CD9
                  FDFF5BC3E2FF0D4F6FDD2F667E1E000000000000000000000000000000000000
                  00000000000000000000000000002D809E1A0D5B7DD96ECDE4FF8AEAFFFF54DC
                  FEFF5BD9FDFF598E9EFF41525CDD485F721E0000000000000000000000000000
                  0000000000000000000000000000000000002D809F1A0D5B7FD96ECDE4FF8AEA
                  FFFF66ADBEFF898787FF9C9A9AFF45505DDE3C437D1E00000000000000000000
                  000000000000000000000000000000000000000000002F809F1A0E5B7ED972A4
                  B1FFB4B3B4FFD2D1D2FFA9A8A8FF5F5D76FF161689D93033A01A000000000000
                  00000000000000000000000000000000000000000000000000003D78901A5265
                  6FD9AEADADFFCDCCCDFF7B7A92FF6868E0FF5858D8FF131497C3000000000000
                  0000000000000000000000000000000000000000000000000000000000005972
                  88195A6572D97C7F90FF7384E4FF7487E9FF6B81E8FF1C20ADFB000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00004A539A1F171AACD9657ADFFF8F9FF1FF4050CCFF1B1FB583000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000003841B9171011B7B21E20BFF01D22BD7F00000000}
                Kind = bkGlyph
              end>
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = tvRoomsdayCountPropertiesButtonClick
            Options.ShowEditButtons = isebAlways
            Width = 54
          end
          object tvRoomsPackage: TcxGridDBColumn
            DataBinding.FieldName = 'Package'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                ImageIndex = 124
                Kind = bkGlyph
              end
              item
                Caption = 'X'
                ImageIndex = 4
                Kind = bkGlyph
              end>
            Properties.Images = DImages.PngImageList1
            Properties.OnButtonClick = tvRoomsPackagePropertiesButtonClick
            Options.ShowEditButtons = isebAlways
            Width = 79
          end
          object tvRoomsStatusText: TcxGridDBColumn
            DataBinding.FieldName = 'StatusText'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.AutoSelect = False
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Mixed'
              'Not arrived'
              'Checked in'
              'Departed'
              'Waitinglist'
              'Alotment'
              'No-show'
              'Blocked'
              'Canceled'
              '[Unused]'
              'Awaiting Payment')
            Properties.OnChange = tvRoomsStatusTextPropertiesChange
            Width = 97
          end
          object tvRoomsStatus: TcxGridDBColumn
            DataBinding.FieldName = 'Status'
            PropertiesClassName = 'TcxLabelProperties'
            Visible = False
            Options.Editing = False
          end
          object rgrProfiles: TcxGridDBColumn
            Caption = 'Profiles'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                ImageIndex = 31
                Hint = 'Select profile'
                Kind = bkGlyph
              end
              item
                ImageIndex = 25
                Hint = 'Show profile'
                Kind = bkGlyph
              end>
            Properties.HideSelection = False
            Properties.Images = DImages.PngImageList1
            Properties.OnButtonClick = tvRoomsPersonsProfilesIdPropertiesButtonClick
            Options.ShowEditButtons = isebAlways
            Options.Sorting = False
            Width = 41
          end
          object tvRoomsGuestName: TcxGridDBColumn
            DataBinding.FieldName = 'GuestName'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.OnButtonClick = tvRoomsGuestCountPropertiesButtonClick
            Width = 106
          end
          object tvRoomsGuestCount: TcxGridDBColumn
            Caption = 'Guests'
            DataBinding.FieldName = 'GuestCount'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Buttons = <
              item
                Default = True
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  20000000000000040000C30E0000C30E00000000000000000000254B5CD62E50
                  618C364851373942472333383B23303233223031311C31313117303030113030
                  300C3030300730303004303030023030300100000000000000002D5163756C94
                  A7FF638597FA334955B82C33375E3131313E3131313D31313139313131333131
                  312B313131233030301B313131143030300C3030300500000000456A7C0E5D84
                  98F19AC3D8FF96BBCEFF688A9DFC203A4AB327353D2E2F3334183030301C3131
                  311F3030301F3131311C31313117313131123131310A00000000000000004366
                  798E99C9E0FF90B8CCFF4F8398FF4FABC9FF0C4967DB2651641D2A444F012B34
                  38042E3031062F2F2F072F2F2F07313131063131310400000000000000004B73
                  871B658EA3F94E8095FF66D6F5FF64DBFCFF5AC1E0FF0C4A68DC245D741C0000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000275268A542ABC5FF69E5FEFF51DBFEFF5CD9FDFF5AC1E0FF0C4C6BDC246E
                  8C1C000000000000000000000000000000000000000000000000000000000000
                  0000276F8B1A0C5677DA6DCDE3FF8AEAFFFF52DBFEFF5CD9FDFF5BC2E1FF0C4C
                  6CDC2371911D0000000000000000000000000000000000000000000000000000
                  0000000000002B7D9B1B0E587ADA6FCDE4FF8AEAFFFF52DCFEFF5CD9FDFF5BC2
                  E1FF0D4D6DDC2572921E00000000000000000000000000000000000000000000
                  000000000000000000002D7E9D1B0E5A7CDA6FCDE4FF8AEAFFFF53DCFEFF5CD9
                  FDFF5BC3E2FF0D4F6FDD2F667E1E000000000000000000000000000000000000
                  00000000000000000000000000002D809E1A0D5B7DD96ECDE4FF8AEAFFFF54DC
                  FEFF5BD9FDFF598E9EFF41525CDD485F721E0000000000000000000000000000
                  0000000000000000000000000000000000002D809F1A0D5B7FD96ECDE4FF8AEA
                  FFFF66ADBEFF898787FF9C9A9AFF45505DDE3C437D1E00000000000000000000
                  000000000000000000000000000000000000000000002F809F1A0E5B7ED972A4
                  B1FFB4B3B4FFD2D1D2FFA9A8A8FF5F5D76FF161689D93033A01A000000000000
                  00000000000000000000000000000000000000000000000000003D78901A5265
                  6FD9AEADADFFCDCCCDFF7B7A92FF6868E0FF5858D8FF131497C3000000000000
                  0000000000000000000000000000000000000000000000000000000000005972
                  88195A6572D97C7F90FF7384E4FF7487E9FF6B81E8FF1C20ADFB000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00004A539A1F171AACD9657ADFFF8F9FF1FF4050CCFF1B1FB583000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000003841B9171011B7B21E20BFF01D22BD7F00000000}
                Kind = bkGlyph
              end>
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = tvRoomsGuestCountPropertiesButtonClick
            HeaderAlignmentHorz = taCenter
            Options.ShowEditButtons = isebAlways
            Width = 58
          end
          object tvRoomschildrencount: TcxGridDBColumn
            Caption = 'Children'
            DataBinding.FieldName = 'childrencount'
            PropertiesClassName = 'TcxSpinEditProperties'
            Properties.AssignedValues.MinValue = True
            HeaderAlignmentHorz = taCenter
          end
          object tvRoomsinfantcount: TcxGridDBColumn
            Caption = 'Infants'
            DataBinding.FieldName = 'infantcount'
            PropertiesClassName = 'TcxSpinEditProperties'
            Properties.AssignedValues.MinValue = True
            HeaderAlignmentHorz = taCenter
          end
          object tvRoomsdefGuestCount: TcxGridDBColumn
            DataBinding.FieldName = 'defGuestCount'
            Visible = False
          end
          object tvRoomsratePlanCode: TcxGridDBColumn
            Caption = 'Rate Code'
            DataBinding.FieldName = 'ratePlanCode'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.OnCloseUp = tvRoomsratePlanCodePropertiesCloseUp
            Width = 63
          end
          object tvRoomsunpaidRentPrice: TcxGridDBColumn
            Caption = 'Room rate'
            DataBinding.FieldName = 'unpaidRentPrice'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;0.00'
            HeaderHint = 'Avrage price (Unpaid rent-discount)'
            Options.Editing = False
            Options.ShowEditButtons = isebAlways
            Width = 74
          end
          object __PriceViewer: TcxGridDBColumn
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                ImageIndex = 17
                Kind = bkGlyph
              end>
            Properties.Images = DImages.cxSmallImagesFlat
            Properties.OnButtonClick = tvRoomsunpaidRentPricePropertiesButtonClick
            HeaderGlyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000B6793C2AB4793A6DB578399CB4783A9DB579
              396FB379392C0000000000000000000000000000000000000000000000000000
              000000000000B6793C15B578399CB4783AF1B5793AFFB5793AFFB5793AFFB579
              3AFFB47839F3B57839A3B676361C000000000000000000000000000000000000
              0000B5783981B5793AFFB47839EAB5793AFFB578398EB87F3812AF7F3F10B579
              3A88B5793AFFB57839DEB47839F7B5793A91000000000000000000000000B478
              3AC0B47939F4B1793717B4793AD2B479397800000000B5793AA6B5793AA20000
              0000B3783870B47839D8AA7F2A06B5783AD3B4783AD17F7F0002B57939F2B579
              3AFF00000000B37C3725B47839F7AF7F3F10B5793A7AB5783AD3B5793AFFB478
              39E600000000B4793AF0B5793B4500000000B5783ACDB5793AFFB5793973B579
              3AFFB4793A82B5793973B47939ACBB77330FB5793AFFB57939FCB5793AFFB579
              3AFFB67F360EB47939A8B3783870B4793B63B5793AFFB578397D00000000B479
              3A7EB5793AFFB5793AFFB57839DEB1793717B57839ADB5793AFFB5793AFFB579
              39B0B6793C15B47939D9B5793AFFB5793AFFB5793A8800000000000000000000
              0000B4783966B5793AFFB5793AFFB5793AFFB5783AE0B4793AFEB4793AFEB479
              3ADFB5793AFFB5793AFFB5793AFFB4793A6D0000000000000000000000000000
              000000000000B2773B1EB4783AA5B5793AFFB5793AFFB5793AFFB5793AFFB579
              3AFFB5793AFFB57839A9B4783C22000000000000000000000000000000000000
              0000000000000000000000000000B6773931B4793A71B478399AB478399AB579
              3973B4783C330000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            Width = 24
          end
          object tvRoomsRateOrPackagePerDay: TcxGridDBColumn
            Caption = 'Nightly rate'
            DataBinding.FieldName = 'RateOrPackagePerDay'
            Options.Editing = False
            Width = 57
          end
          object tvRoomsCurrency: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
            Options.Editing = False
            Width = 40
          end
          object tvRoomsisGroupAccount: TcxGridDBColumn
            Caption = 'Group'
            DataBinding.FieldName = 'isGroupAccount'
            Visible = False
            Width = 38
          end
          object tvRoomsisNoRoom: TcxGridDBColumn
            DataBinding.FieldName = 'isNoRoom'
            Visible = False
          end
          object tvRoomsuseStayTax: TcxGridDBColumn
            DataBinding.FieldName = 'useStayTax'
            Visible = False
          end
          object tvRoomsRoomAlias: TcxGridDBColumn
            DataBinding.FieldName = 'RoomAlias'
            Visible = False
          end
          object tvRoomsRoomTypeAlias: TcxGridDBColumn
            DataBinding.FieldName = 'RoomTypeAlias'
            Visible = False
          end
          object tvRoomsBreakFast: TcxGridDBColumn
            DataBinding.FieldName = 'BreakFast'
            Visible = False
            Width = 37
          end
          object tvRoomsbreakfastText: TcxGridDBColumn
            Caption = 'Breakfast'
            DataBinding.FieldName = 'breakfastText'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Included'
              'Not included')
            Properties.OnChange = tvRoomsbreakfastTextPropertiesChange
            Width = 81
          end
          object tvRoomsStockItemsCount: TcxGridDBColumn
            Caption = 'Extras'
            DataBinding.FieldName = 'StockItemsCount'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            Properties.OnButtonClick = tvRoomsStockItemsCountPropertiesButtonClick
            Options.ShowEditButtons = isebAlways
          end
          object tvRoomsStockitemsPrice: TcxGridDBColumn
            Caption = 'Extras Price'
            DataBinding.FieldName = 'StockitemsPrice'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 56
          end
          object tvRoomsaccountTypeText: TcxGridDBColumn
            Caption = 'Account'
            DataBinding.FieldName = 'accountTypeText'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Room account'
              'Group account')
            Properties.OnChange = tvRoomsaccountTypeTextPropertiesChange
            Width = 87
          end
          object rgrinvoice: TcxGridDBColumn
            Caption = 'Invoice'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                ImageIndex = 62
                Kind = bkGlyph
              end
              item
                ImageIndex = 60
                Kind = bkGlyph
              end>
            Properties.Images = DImages.PngImageList1
            Properties.ViewStyle = vsButtonsOnly
            Properties.OnButtonClick = rgrinvoicePropertiesButtonClick
            Options.ShowEditButtons = isebAlways
            Width = 54
          end
          object tvRoomsTotalUnpaidRoomRent: TcxGridDBColumn
            Caption = 'Unpaid Rent'
            DataBinding.FieldName = 'TotalUnpaidRoomRent'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '###0.00;###0.00'
            Options.Editing = False
            Width = 84
          end
          object tvRoomsDiscountUnpaidRoomRent: TcxGridDBColumn
            Caption = 'Rent Discount'
            DataBinding.FieldName = 'DiscountUnpaidRoomRent'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '###0.00;###0.00'
            Options.Editing = False
            Width = 52
          end
          object tvRoomsunPaidRoomRent: TcxGridDBColumn
            Caption = 'Room rent'
            DataBinding.FieldName = 'unPaidRoomRent'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '###0.00;###0.00'
            Options.Editing = False
          end
          object tvRoomsunpaidRentNights: TcxGridDBColumn
            Caption = 'Rent Nights'
            DataBinding.FieldName = 'unpaidRentNights'
            Options.Editing = False
          end
          object tvRoomsPriceCode: TcxGridDBColumn
            DataBinding.FieldName = 'PriceCode'
            Options.Editing = False
          end
          object tvRoomsunPaidItems: TcxGridDBColumn
            DataBinding.FieldName = 'unPaidItems'
            Options.Editing = False
          end
          object tvRoomsPersonsProfilesId: TcxGridDBColumn
            DataBinding.FieldName = 'PersonsProfilesId'
          end
          object tvRoomsoutOfOrderBlocking: TcxGridDBColumn
            DataBinding.FieldName = 'outOfOrderBlocking'
          end
          object tvRoomsManualChannelId: TcxGridDBColumn
            DataBinding.FieldName = 'ManualChannelId'
          end
          object tvRoomsblockMoveReason: TcxGridDBColumn
            Caption = 'Reason for move blocking'
            DataBinding.FieldName = 'blockMoveReason'
            Options.Editing = False
          end
        end
        object lvRooms: TcxGridLevel
          Caption = 'Rooms'
          GridView = tvRooms
        end
      end
      object Panel9: TsPanel
        Left = 0
        Top = 38
        Width = 1112
        Height = 44
        Align = alTop
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object btnShowPrices: TsButton
          AlignWithMargins = True
          Left = 746
          Top = 4
          Width = 100
          Height = 36
          Align = alLeft
          Caption = 'Prices'
          ImageIndex = 88
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnShowPricesClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnShowInvoice: TsButton
          AlignWithMargins = True
          Left = 640
          Top = 4
          Width = 100
          Height = 36
          Align = alLeft
          Caption = 'Invoices'
          DropDownMenu = mnuFinishedInv
          ImageIndex = 63
          Images = DImages.PngImageList1
          Style = bsSplitButton
          TabOrder = 1
          OnClick = OpenthisRoom1Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnAddRoom: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 100
          Height = 36
          Align = alLeft
          Caption = 'Add Room'
          ImageIndex = 23
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = btnAddRoomClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnRemoveRoom: TsButton
          AlignWithMargins = True
          Left = 110
          Top = 4
          Width = 100
          Height = 36
          Align = alLeft
          Caption = 'Remove Room'
          ImageIndex = 24
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = btnRemoveRoomClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnProvideRoom: TsButton
          AlignWithMargins = True
          Left = 322
          Top = 4
          Width = 100
          Height = 36
          Align = alLeft
          Caption = 'Provide room'
          ImageIndex = 47
          Images = DImages.PngImageList1
          TabOrder = 4
          OnClick = btnProvideRoomClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnRoomToExcel: TsButton
          AlignWithMargins = True
          Left = 852
          Top = 4
          Width = 100
          Height = 36
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 5
          OnClick = btnRoomToExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object cxButton5: TsButton
          AlignWithMargins = True
          Left = 534
          Top = 4
          Width = 100
          Height = 36
          Align = alLeft
          Caption = 'Room'#13#10' Documents'
          ImageIndex = 0
          Images = DImages.PngImageList1
          TabOrder = 6
          OnClick = cxButton5Click
          SkinData.SkinSection = 'BUTTON'
        end
        object cxButton6: TsButton
          AlignWithMargins = True
          Left = 428
          Top = 4
          Width = 100
          Height = 36
          Align = alLeft
          Caption = 'Jump'
          ImageIndex = 57
          Images = DImages.PngImageList1
          TabOrder = 7
          OnClick = cxButton6Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnRoomsRefresh: TsButton
          AlignWithMargins = True
          Left = 1061
          Top = 4
          Width = 100
          Height = 36
          Align = alLeft
          Caption = 'Refresh'
          ImageIndex = 28
          Images = DImages.PngImageList1
          TabOrder = 8
          OnClick = btnRoomsRefreshClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton5: TsButton
          AlignWithMargins = True
          Left = 216
          Top = 4
          Width = 100
          Height = 36
          Align = alLeft
          Caption = 'Guest details'
          ImageIndex = 44
          Images = DImages.PngImageList1
          TabOrder = 9
          OnClick = sButton5Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnGroups: TsButton
          AlignWithMargins = True
          Left = 958
          Top = 4
          Width = 97
          Height = 36
          Align = alLeft
          Caption = 'Names in Group'
          TabOrder = 10
          OnClick = btnGroupsClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object sPanel1: TsPanel
        Left = 0
        Top = 0
        Width = 1112
        Height = 38
        Align = alTop
        Caption = 'OUT-OF-ORDER'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        Visible = False
        SkinData.SkinSection = 'PANEL'
      end
    end
    object GuestsTab: TsTabSheet
      Caption = 'Guests'
      ImageIndex = 1
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel10: TsPanel
        Left = 0
        Top = 0
        Width = 1112
        Height = 38
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          1112
          38)
        object btnGuestsRefresh: TsButton
          Left = 212
          Top = 2
          Width = 100
          Height = 30
          Caption = 'Refresh'
          ImageIndex = 28
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnGuestsRefreshClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnExpand: TsButton
          Left = 905
          Top = 2
          Width = 100
          Height = 30
          Anchors = [akTop, akRight]
          Caption = 'Expand all'
          TabOrder = 1
          OnClick = btnExpandClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnCollapse: TsButton
          Left = 1007
          Top = 2
          Width = 100
          Height = 30
          Anchors = [akTop, akRight]
          Caption = 'Collapse all'
          TabOrder = 2
          OnClick = btnCollapseClick
          SkinData.SkinSection = 'BUTTON'
        end
        object cxButton2: TsButton
          Left = 4
          Top = 2
          Width = 100
          Height = 30
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = cxButton2Click
          SkinData.SkinSection = 'BUTTON'
        end
        object chkShowAllGuests: TsCheckBox
          Left = 333
          Top = 11
          Width = 85
          Height = 20
          Caption = 'Show all guests'
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 4
          OnClick = chkShowAllGuestsClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object sButton4: TsButton
          Left = 108
          Top = 2
          Width = 100
          Height = 30
          Caption = 'Guestlist'
          ImageIndex = 33
          Images = DImages.PngImageList1
          TabOrder = 5
          OnClick = sButton4Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object pnlGuests: TsPanel
        Left = 0
        Top = 38
        Width = 1112
        Height = 244
        Align = alClient
        TabOrder = 1
        object grGuests: TcxGrid
          Left = 1
          Top = 1
          Width = 846
          Height = 242
          Align = alClient
          TabOrder = 0
          LevelTabs.Style = 8
          LookAndFeel.NativeStyle = False
          object tvGuestRooms: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.First.Visible = True
            Navigator.Buttons.PriorPage.Visible = True
            Navigator.Buttons.Prior.Visible = True
            Navigator.Buttons.Next.Visible = True
            Navigator.Buttons.NextPage.Visible = True
            Navigator.Buttons.Last.Visible = True
            Navigator.Buttons.Insert.Enabled = False
            Navigator.Buttons.Insert.Visible = False
            Navigator.Buttons.Append.Enabled = False
            Navigator.Buttons.Append.Visible = False
            Navigator.Buttons.Delete.Enabled = False
            Navigator.Buttons.Delete.Visible = False
            Navigator.Buttons.Edit.Enabled = False
            Navigator.Buttons.Edit.Visible = False
            Navigator.Buttons.Post.Enabled = False
            Navigator.Buttons.Post.Visible = False
            Navigator.Buttons.Cancel.Enabled = False
            Navigator.Buttons.Cancel.Visible = True
            Navigator.Buttons.Refresh.Visible = True
            Navigator.Buttons.SaveBookmark.Visible = True
            Navigator.Buttons.GotoBookmark.Visible = True
            Navigator.Buttons.Filter.Visible = True
            OnCanFocusRecord = tvGuestRoomsCanFocusRecord
            DataController.DataSource = mGuestRoomsDS
            DataController.DetailKeyFieldNames = 'RoomReservation'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.Indicator = True
            Preview.Visible = True
            object tvGuestRoomsRoomReservation: TcxGridDBColumn
              DataBinding.FieldName = 'RoomReservation'
            end
            object tvGuestRoomsReservation: TcxGridDBColumn
              DataBinding.FieldName = 'Reservation'
              Visible = False
            end
            object tvGuestRoomsRoom: TcxGridDBColumn
              DataBinding.FieldName = 'Room'
            end
            object tvGuestRoomsMainGuest: TcxGridDBColumn
              Caption = 'Guest Name'
              DataBinding.FieldName = 'MainGuest'
              Width = 120
            end
            object tvGuestRoomsGuestCount: TcxGridDBColumn
              Caption = 'Guests'
              DataBinding.FieldName = 'GuestCount'
              Width = 36
            end
            object tvGuestRoomsStatusText: TcxGridDBColumn
              Caption = 'Status'
              DataBinding.FieldName = 'StatusText'
              Width = 120
            end
            object tvGuestRoomsRoomType: TcxGridDBColumn
              Caption = 'Type'
              DataBinding.FieldName = 'RoomType'
            end
            object tvGuestRoomsRoomTypeDescription: TcxGridDBColumn
              Caption = 'Type Description'
              DataBinding.FieldName = 'RoomTypeDescription'
              Width = 120
            end
            object tvGuestRoomsRoomDescription: TcxGridDBColumn
              DataBinding.FieldName = 'RoomDescription'
              Width = 120
            end
            object tvGuestRoomsEquipments: TcxGridDBColumn
              DataBinding.FieldName = 'Equipments'
              Width = 100
            end
            object tvGuestRoomsFloor: TcxGridDBColumn
              DataBinding.FieldName = 'Floor'
              Width = 36
            end
            object tvGuestRoomsLocationDescription: TcxGridDBColumn
              Caption = 'Location'
              DataBinding.FieldName = 'LocationDescription'
              Width = 112
            end
            object tvGuestRoomsNoRoom: TcxGridDBColumn
              DataBinding.FieldName = 'NoRoom'
              Visible = False
            end
            object tvGuestRoomsRecId: TcxGridDBColumn
              DataBinding.FieldName = 'RecId'
              Visible = False
            end
            object tvGuestRoomsisGroup: TcxGridDBColumn
              DataBinding.FieldName = 'isGroup'
            end
            object tvGuestRoomsBreakfast: TcxGridDBColumn
              DataBinding.FieldName = 'Breakfast'
            end
            object tvGuestRoomsrrArrival: TcxGridDBColumn
              DataBinding.FieldName = 'rrArrival'
              Width = 80
            end
            object tvGuestRoomsrrDeparture: TcxGridDBColumn
              DataBinding.FieldName = 'rrDeparture'
              Width = 80
            end
            object tvGuestRoomsDefNumberGuests: TcxGridDBColumn
              Caption = 'Def'
              DataBinding.FieldName = 'DefNumberGuests'
              Width = 24
            end
            object tvGuestRoomsLocation: TcxGridDBColumn
              DataBinding.FieldName = 'Location'
              Visible = False
            end
            object tvGuestRoomsStatus: TcxGridDBColumn
              DataBinding.FieldName = 'Status'
              Visible = False
            end
          end
          object tvGuests: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.First.Visible = True
            Navigator.Buttons.PriorPage.Visible = True
            Navigator.Buttons.Prior.Visible = True
            Navigator.Buttons.Next.Visible = True
            Navigator.Buttons.NextPage.Visible = True
            Navigator.Buttons.Last.Visible = True
            Navigator.Buttons.Insert.Enabled = False
            Navigator.Buttons.Insert.Visible = False
            Navigator.Buttons.Append.Enabled = False
            Navigator.Buttons.Append.Visible = False
            Navigator.Buttons.Delete.Enabled = False
            Navigator.Buttons.Delete.Visible = False
            Navigator.Buttons.Edit.Enabled = False
            Navigator.Buttons.Edit.Visible = False
            Navigator.Buttons.Post.Enabled = False
            Navigator.Buttons.Post.Visible = False
            Navigator.Buttons.Cancel.Enabled = False
            Navigator.Buttons.Cancel.Visible = True
            Navigator.Buttons.Refresh.Visible = True
            Navigator.Buttons.SaveBookmark.Visible = True
            Navigator.Buttons.GotoBookmark.Visible = True
            Navigator.Buttons.Filter.Visible = True
            OnCanFocusRecord = tvGuestsCanFocusRecord
            DataController.DataModeController.SyncMode = False
            DataController.DataSource = mGuestsDS
            DataController.DetailKeyFieldNames = 'RoomReservation'
            DataController.KeyFieldNames = 'RoomReservation'
            DataController.MasterKeyFieldNames = 'RoomReservation'
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            OptionsView.Header = False
            object tvGuestsRecId: TcxGridDBColumn
              DataBinding.FieldName = 'RecId'
              Visible = False
            end
            object tvGuestsPerson: TcxGridDBColumn
              DataBinding.FieldName = 'Person'
              Visible = False
            end
            object tvGuestsRoomReservation: TcxGridDBColumn
              DataBinding.FieldName = 'RoomReservation'
            end
            object tvGuestsReservation: TcxGridDBColumn
              DataBinding.FieldName = 'Reservation'
              Visible = False
            end
            object tvGuestsGuestName: TcxGridDBColumn
              DataBinding.FieldName = 'GuestName'
              PropertiesClassName = 'TcxTextEditProperties'
              Width = 150
            end
            object tvGuestsCountry: TcxGridDBColumn
              DataBinding.FieldName = 'Country'
            end
            object tvGuestsAddress1: TcxGridDBColumn
              DataBinding.FieldName = 'Address1'
              Width = 150
            end
            object tvGuestsAddress2: TcxGridDBColumn
              DataBinding.FieldName = 'Address2'
              Width = 100
            end
            object tvGuestsAddress3: TcxGridDBColumn
              DataBinding.FieldName = 'Address3'
              Width = 100
            end
            object tvGuestsAddress4: TcxGridDBColumn
              DataBinding.FieldName = 'Address4'
              Visible = False
              Width = 100
            end
            object tvGuestsPID: TcxGridDBColumn
              DataBinding.FieldName = 'PID'
            end
          end
          object tvAllGuests: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.First.Visible = True
            Navigator.Buttons.PriorPage.Visible = True
            Navigator.Buttons.Prior.Visible = True
            Navigator.Buttons.Next.Visible = True
            Navigator.Buttons.NextPage.Visible = True
            Navigator.Buttons.Last.Visible = True
            Navigator.Buttons.Insert.Enabled = False
            Navigator.Buttons.Insert.Visible = False
            Navigator.Buttons.Append.Enabled = False
            Navigator.Buttons.Append.Visible = False
            Navigator.Buttons.Delete.Enabled = False
            Navigator.Buttons.Delete.Visible = False
            Navigator.Buttons.Edit.Enabled = False
            Navigator.Buttons.Edit.Visible = False
            Navigator.Buttons.Post.Enabled = False
            Navigator.Buttons.Post.Visible = False
            Navigator.Buttons.Cancel.Enabled = False
            Navigator.Buttons.Cancel.Visible = True
            Navigator.Buttons.Refresh.Visible = True
            Navigator.Buttons.SaveBookmark.Visible = True
            Navigator.Buttons.GotoBookmark.Visible = True
            Navigator.Buttons.Filter.Visible = True
            OnCanFocusRecord = tvAllGuestsCanFocusRecord
            DataController.DataSource = mAllGuestsDS
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.Indicator = True
            object tvAllGuestsRecId: TcxGridDBColumn
              DataBinding.FieldName = 'RecId'
              Visible = False
            end
            object tvAllGuestsReservation: TcxGridDBColumn
              DataBinding.FieldName = 'Reservation'
              Visible = False
            end
            object tvAllGuestsRoomReservation: TcxGridDBColumn
              DataBinding.FieldName = 'RoomReservation'
              Visible = False
            end
            object tvAllGuestsRoom: TcxGridDBColumn
              DataBinding.FieldName = 'Room'
            end
            object tvAllGuestsGuestName: TcxGridDBColumn
              DataBinding.FieldName = 'GuestName'
              Width = 120
            end
            object tvAllGuestsStatusText: TcxGridDBColumn
              Caption = 'Status'
              DataBinding.FieldName = 'StatusText'
              Width = 120
            end
            object tvAllGuestsRoomType: TcxGridDBColumn
              Caption = 'Type'
              DataBinding.FieldName = 'RoomType'
            end
            object tvAllGuestsRoomTypeDescription: TcxGridDBColumn
              Caption = 'Type Description'
              DataBinding.FieldName = 'RoomTypeDescription'
              Width = 120
            end
            object tvAllGuestsRoomDescription: TcxGridDBColumn
              Caption = 'Room Description'
              DataBinding.FieldName = 'RoomDescription'
              Width = 120
            end
            object tvAllGuestsEquipments: TcxGridDBColumn
              DataBinding.FieldName = 'Equipments'
              Width = 120
            end
            object tvAllGuestsFloor: TcxGridDBColumn
              DataBinding.FieldName = 'Floor'
              Width = 34
            end
            object tvAllGuestsLocationDescription: TcxGridDBColumn
              Caption = 'Location'
              DataBinding.FieldName = 'LocationDescription'
              Width = 120
            end
            object tvAllGuestsisGroup: TcxGridDBColumn
              DataBinding.FieldName = 'isGroup'
            end
            object tvAllGuestsBreakfast: TcxGridDBColumn
              DataBinding.FieldName = 'Breakfast'
            end
            object tvAllGuestsrrArrival: TcxGridDBColumn
              DataBinding.FieldName = 'rrArrival'
              Width = 70
            end
            object tvAllGuestsrrDeparture: TcxGridDBColumn
              DataBinding.FieldName = 'rrDeparture'
              Width = 70
            end
            object tvAllGuestsNoRoom: TcxGridDBColumn
              DataBinding.FieldName = 'NoRoom'
              Visible = False
            end
            object tvAllGuestsDefNumberGuests: TcxGridDBColumn
              DataBinding.FieldName = 'DefNumberGuests'
              Visible = False
            end
            object tvAllGuestsLocation: TcxGridDBColumn
              DataBinding.FieldName = 'Location'
              Visible = False
            end
            object tvAllGuestsPerson: TcxGridDBColumn
              DataBinding.FieldName = 'Person'
              Visible = False
            end
            object tvAllGuestsPID: TcxGridDBColumn
              Caption = 'Personal ID'
              DataBinding.FieldName = 'PID'
            end
            object tvAllGuestsAddress1: TcxGridDBColumn
              DataBinding.FieldName = 'Address1'
              Width = 120
            end
            object tvAllGuestsAddress2: TcxGridDBColumn
              DataBinding.FieldName = 'Address2'
              Width = 120
            end
            object tvAllGuestsAddress3: TcxGridDBColumn
              DataBinding.FieldName = 'Address3'
              Width = 120
            end
            object tvAllGuestsAddress4: TcxGridDBColumn
              DataBinding.FieldName = 'Address4'
              Visible = False
              Width = 120
            end
            object tvAllGuestsCountry: TcxGridDBColumn
              DataBinding.FieldName = 'Country'
            end
            object tvAllGuestsStatus: TcxGridDBColumn
              DataBinding.FieldName = 'Status'
              Visible = False
            end
          end
          object lvGuestRooms: TcxGridLevel
            Caption = 'Main Guest'
            GridView = tvGuestRooms
            object lvGuests: TcxGridLevel
              GridView = tvGuests
            end
          end
          object lvAllGuests: TcxGridLevel
            Caption = 'All guests'
            GridView = tvAllGuests
          end
        end
        object gbxProfileAlert: TsGroupBox
          AlignWithMargins = True
          Left = 852
          Top = 3
          Width = 254
          Height = 238
          Margins.Left = 5
          Margins.Top = 2
          Margins.Right = 5
          Margins.Bottom = 2
          Align = alRight
          Caption = 'Guest profile notes and preferences'
          TabOrder = 1
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object lblSpecialRequests: TsLabel
            Left = 2
            Top = 13
            Width = 250
            Height = 11
            Align = alTop
            Caption = 'Special Requests'
            ExplicitWidth = 69
          end
          object lblNotes: TsLabel
            Left = 2
            Top = 97
            Width = 250
            Height = 11
            Align = alTop
            Caption = 'Notes'
            ExplicitWidth = 24
          end
          object edtSpecialRequests: TMemo
            AlignWithMargins = True
            Left = 7
            Top = 29
            Width = 240
            Height = 63
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alTop
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object edtNotes: TMemo
            AlignWithMargins = True
            Left = 7
            Top = 113
            Width = 240
            Height = 66
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alTop
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 1
          end
          object gbxRoomAlert: TsGroupBox
            Left = 2
            Top = 184
            Width = 250
            Height = 105
            Align = alTop
            TabOrder = 2
            Checked = False
            object lblRoomType: TsLabel
              Left = 7
              Top = 43
              Width = 46
              Height = 11
              Caption = 'Room type'
            end
            object lblRoom: TsLabel
              Left = 7
              Top = 18
              Width = 24
              Height = 11
              Caption = 'Room'
            end
            object edtRoom: TsEdit
              Left = 151
              Top = 13
              Width = 94
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              SkinData.CustomFont = True
            end
            object edtRoomType: TsEdit
              Left = 152
              Top = 38
              Width = 94
              Height = 21
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              SkinData.CustomFont = True
            end
          end
        end
      end
    end
    object sTabSheet2: TsTabSheet
      Caption = 'ALERTS'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object pnlAlertHolder: TsPanel
        Left = 0
        Top = 0
        Width = 1112
        Height = 282
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        SkinData.SkinSection = 'TRANSPARENT'
      end
    end
    object InvoicesTab: TsTabSheet
      Caption = 'Finished Invoices'
      ImageIndex = 2
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object Panel11: TsPanel
        Left = 0
        Top = 0
        Width = 1112
        Height = 38
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          1112
          38)
        object cxButton1: TsButton
          Left = 1003
          Top = 3
          Width = 100
          Height = 29
          Anchors = [akTop, akRight]
          Caption = 'Refresh'
          ImageIndex = 28
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = cxButton1Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnInvoiceheadsExcel: TsButton
          Left = 4
          Top = 3
          Width = 100
          Height = 29
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnInvoiceheadsExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object Grid: TcxGrid
        Left = 0
        Top = 38
        Width = 1112
        Height = 244
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvInvoiceHeads: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mInvoiceHeadsDS
          DataController.DetailKeyFieldNames = 'InvoiceNumber'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Column = tvInvoiceHeadsAmountWithTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Column = tvInvoiceHeadsAmountNoTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Column = tvInvoiceHeadsAmountTax
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.Indicator = True
          object tvInvoiceHeadsRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvInvoiceHeadsInvoiceNumber: TcxGridDBColumn
            Caption = 'Number'
            DataBinding.FieldName = 'InvoiceNumber'
            Width = 32
          end
          object tvInvoiceHeadsInvoiceDate: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceDate'
          end
          object tvInvoiceHeadsRoom: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
            Width = 65
          end
          object tvInvoiceHeadsCustomer: TcxGridDBColumn
            DataBinding.FieldName = 'Customer'
            Width = 70
          end
          object tvInvoiceHeadsNameOnInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'NameOnInvoice'
            Width = 136
          end
          object tvInvoiceHeadsAmountWithTax: TcxGridDBColumn
            Caption = 'With Tax'
            DataBinding.FieldName = 'AmountWithTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceHeadsAmountWithTaxGetProperties
            Options.Editing = False
          end
          object tvInvoiceHeadsAmountNoTax: TcxGridDBColumn
            Caption = 'No Tax'
            DataBinding.FieldName = 'AmountNoTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceHeadsAmountNoTaxGetProperties
          end
          object tvInvoiceHeadsAmountTax: TcxGridDBColumn
            Caption = 'Tax'
            DataBinding.FieldName = 'AmountTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceHeadsAmountTaxGetProperties
          end
          object tvInvoiceHeadsPayTypes: TcxGridDBColumn
            Caption = 'Pay Type'
            DataBinding.FieldName = 'PayTypes'
            Width = 52
          end
          object tvInvoiceHeadsPayTypeDescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'PayTypeDescription'
            Width = 64
          end
          object tvInvoiceHeadsPayGroups: TcxGridDBColumn
            Caption = 'Pay Group'
            DataBinding.FieldName = 'PayGroups'
            Width = 52
          end
          object tvInvoiceHeadspayGroupDescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'payGroupDescription'
            Width = 64
          end
          object tvInvoiceHeadsAddress1: TcxGridDBColumn
            DataBinding.FieldName = 'Address1'
            Width = 80
          end
          object tvInvoiceHeadsAddress2: TcxGridDBColumn
            DataBinding.FieldName = 'Address2'
            Width = 80
          end
          object tvInvoiceHeadsAddress3: TcxGridDBColumn
            DataBinding.FieldName = 'Address3'
            Width = 80
          end
          object tvInvoiceHeadsRoomGuest: TcxGridDBColumn
            Caption = 'Room Guest'
            DataBinding.FieldName = 'RoomGuest'
            Width = 80
          end
          object tvInvoiceHeadsinvRefrence: TcxGridDBColumn
            Caption = 'Refrence'
            DataBinding.FieldName = 'invRefrence'
            Width = 80
          end
          object tvInvoiceHeadsdueDate: TcxGridDBColumn
            DataBinding.FieldName = 'dueDate'
          end
          object tvInvoiceHeadsCreditInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'CreditInvoice'
          end
          object tvInvoiceHeadsOriginalInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'OriginalInvoice'
          end
          object tvInvoiceHeadsReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
          end
          object tvInvoiceHeadsRoomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'RoomReservation'
          end
          object tvInvoiceHeadsSplitNumber: TcxGridDBColumn
            DataBinding.FieldName = 'SplitNumber'
            Visible = False
          end
        end
        object tvInvoiceLines: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DataSource = mInvoiceLinesDS
          DataController.DetailKeyFieldNames = 'InvoiceNumber'
          DataController.KeyFieldNames = 'InvoiceNumber'
          DataController.MasterKeyFieldNames = 'InvoiceNumber'
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              FieldName = 'AmountWithTax'
              Column = tvInvoiceLinesAmountWithTax
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountWithTax'
              Column = tvInvoiceLinesAmountWithTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountNoTax'
              Column = tvInvoiceLinesAmountNoTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountTax'
              Column = tvInvoiceLinesAmountTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skCount
              FieldName = 'Item'
              Column = tvInvoiceLinesItem
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object tvInvoiceLinesRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvInvoiceLinesInvoiceNumber: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceNumber'
            Visible = False
          end
          object tvInvoiceLinesItem: TcxGridDBColumn
            DataBinding.FieldName = 'Item'
            Width = 90
          end
          object tvInvoiceLinesDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 220
          end
          object tvInvoiceLinesQuantity: TcxGridDBColumn
            DataBinding.FieldName = 'Quantity'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Width = 32
          end
          object tvInvoiceLinesPrice: TcxGridDBColumn
            DataBinding.FieldName = 'Price'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.ReadOnly = False
            OnGetProperties = tvInvoiceLinesPriceGetProperties
          end
          object tvInvoiceLinesAmountWithTax: TcxGridDBColumn
            Caption = 'With Tax'
            DataBinding.FieldName = 'AmountWithTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceLinesAmountWithTaxGetProperties
            Options.Editing = False
          end
          object tvInvoiceLinesAmountNoTax: TcxGridDBColumn
            Caption = 'No Tax'
            DataBinding.FieldName = 'AmountNoTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceLinesAmountNoTaxGetProperties
          end
          object tvInvoiceLinesAmountTax: TcxGridDBColumn
            Caption = 'Tax'
            DataBinding.FieldName = 'AmountTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceLinesAmountTaxGetProperties
          end
          object tvInvoiceLinesCurrency: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
            Width = 22
          end
          object tvInvoiceLinesCurrencyRate: TcxGridDBColumn
            DataBinding.FieldName = 'CurrencyRate'
            Width = 48
          end
          object tvInvoiceLinespurchaseDate: TcxGridDBColumn
            DataBinding.FieldName = 'purchaseDate'
          end
          object tvInvoiceLinesImportRefrence: TcxGridDBColumn
            DataBinding.FieldName = 'ImportRefrence'
            Width = 100
          end
          object tvInvoiceLinesImportSource: TcxGridDBColumn
            DataBinding.FieldName = 'ImportSource'
            Width = 100
          end
          object tvInvoiceLinesVatType: TcxGridDBColumn
            DataBinding.FieldName = 'VatType'
            Width = 48
          end
        end
        object lvInvoiceHeads: TcxGridLevel
          GridView = tvInvoiceHeads
          object lvInvoiceLines: TcxGridLevel
            GridView = tvInvoiceLines
          end
        end
      end
    end
  end
  object pnlDataWait: TsPanel
    Left = 434
    Top = 135
    Width = 263
    Height = 90
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    object sLabel2: TsLabel
      Left = 63
      Top = 25
      Width = 137
      Height = 27
      Caption = 'Loading data'
      ParentFont = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
    end
  end
  object Panel1: TsPanel
    Left = 0
    Top = 629
    Width = 1120
    Height = 33
    Align = alBottom
    TabOrder = 4
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1120
      33)
    object sButton2: TsButton
      Left = 947
      Top = 4
      Width = 83
      Height = 25
      Hint = 'Confirm close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton3: TsButton
      Left = 1032
      Top = 4
      Width = 83
      Height = 25
      Hint = 'Confirm close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 2
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object mRooms: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforePost = mRoomsBeforePost
    AfterScroll = mRoomsAfterScroll
    Left = 352
    Top = 448
    object mRoomsReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mRoomsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mRoomsRoom: TWideStringField
      FieldName = 'Room'
      Size = 10
    end
    object mRoomsRoomType: TWideStringField
      FieldName = 'RoomType'
      Size = 10
    end
    object mRoomsArrival: TDateTimeField
      FieldName = 'Arrival'
    end
    object mRoomsDeparture: TDateTimeField
      FieldName = 'Departure'
    end
    object mRoomsStatusText: TStringField
      FieldName = 'StatusText'
    end
    object mRoomsStatus: TWideStringField
      FieldName = 'Status'
      Size = 5
    end
    object mRoomsCurrency: TWideStringField
      FieldName = 'Currency'
      Size = 5
    end
    object mRoomsisGroupAccount: TBooleanField
      FieldName = 'isGroupAccount'
    end
    object mRoomsisNoRoom: TBooleanField
      FieldName = 'isNoRoom'
    end
    object mRoomsuseStayTax: TBooleanField
      FieldName = 'useStayTax'
    end
    object mRoomsRoomAlias: TWideStringField
      FieldName = 'RoomAlias'
      Size = 5
    end
    object mRoomsRoomTypeAlias: TWideStringField
      FieldName = 'RoomTypeAlias'
      Size = 5
    end
    object mRoomsdayCount: TIntegerField
      FieldName = 'dayCount'
    end
    object mRoomsBreakFast: TBooleanField
      FieldName = 'BreakFast'
    end
    object mRoomsGuestCount: TIntegerField
      FieldName = 'GuestCount'
    end
    object mRoomsdefGuestCount: TIntegerField
      FieldName = 'defGuestCount'
    end
    object mRoomsPersonsProfilesId: TIntegerField
      FieldName = 'PersonsProfilesId'
    end
    object mRoomsGuestName: TWideStringField
      DisplayLabel = 'Guestname'
      FieldName = 'guestname'
      Size = 50
    end
    object mRoomsbreakfastText: TStringField
      FieldName = 'breakfastText'
    end
    object mRoomsaccountTypeText: TStringField
      FieldName = 'accountTypeText'
    end
    object mRoomsDiscountUnpaidRoomRent: TFloatField
      FieldName = 'DiscountUnpaidRoomRent'
    end
    object mRoomsunPaidRoomRent: TFloatField
      FieldName = 'unPaidRoomRent'
    end
    object mRoomsTotalUnpaidRoomRent: TFloatField
      FieldName = 'TotalUnpaidRoomRent'
    end
    object mRoomsunpaidRentNights: TIntegerField
      FieldName = 'unPaidRentNights'
    end
    object mRoomsunpaidRentPrice: TFloatField
      FieldName = 'unpaidRentPrice'
    end
    object mRoomsunPaidItems: TFloatField
      FieldName = 'unPaidItems'
    end
    object mRoomsPriceCode: TWideStringField
      FieldName = 'PriceCode'
      Size = 10
    end
    object mRoomsRoomClass: TWideStringField
      FieldName = 'RoomClass'
      Size = 10
    end
    object mRoomsRoomClassDescription: TWideStringField
      FieldName = 'RoomClassDescription'
      Size = 35
    end
    object mRoomsPackage: TWideStringField
      FieldName = 'Package'
    end
    object mRoomsoutOfOrderBlocking: TBooleanField
      FieldName = 'outOfOrderBlocking'
    end
    object mRoomsblockMove: TBooleanField
      FieldName = 'blockMove'
    end
    object mRoomsManualChannelId: TIntegerField
      FieldName = 'ManualChannelId'
    end
    object mRoomsratePlanCode: TWideStringField
      FieldName = 'ratePlanCode'
      Size = 15
    end
    object mRoomsExpectedTimeOfArrival: TWideStringField
      FieldName = 'ExpectedTimeOfArrival'
    end
    object mRoomsExpectedCheckoutTime: TWideStringField
      FieldName = 'ExpectedCheckoutTime'
    end
    object mRoomsRateOrPackagePerDay: TFloatField
      FieldName = 'RateOrPackagePerDay'
    end
    object mRoomsblockMoveReason: TWideStringField
      FieldName = 'blockMoveReason'
      Size = 255
    end
    object mRoomsStockItemsCount: TIntegerField
      FieldName = 'StockItemsCount'
    end
    object mRoomsStockitemsPrice: TFloatField
      FieldName = 'StockitemsPrice'
    end
    object mRoomschildrencount: TIntegerField
      FieldName = 'childrencount'
    end
    object mRoomsinfantcount: TIntegerField
      FieldName = 'infantcount'
    end
  end
  object mGuestRoomsDS: TDataSource
    DataSet = mGuestRooms
    Left = 56
    Top = 504
  end
  object mnuFinishedInv: TPopupMenu
    Left = 504
    Top = 336
    object mnuThisRoom: TMenuItem
      Caption = 'Closed this Room'
      OnClick = mnuThisRoomClick
    end
    object mnuThisreservation: TMenuItem
      Caption = 'Closed this reservation'
      OnClick = mnuThisreservationClick
    end
    object OpenthisRoom1: TMenuItem
      Caption = 'Open this Room'
      Default = True
      OnClick = OpenthisRoom1Click
    end
    object OpenGroupInvoice1: TMenuItem
      Caption = 'Open Group Invoice'
      OnClick = OpenGroupInvoice1Click
    end
  end
  object mGuests: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 160
    Top = 448
    object mGuestsPerson: TIntegerField
      FieldName = 'Person'
    end
    object mGuestsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mGuestsReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mGuestsGuestName: TWideStringField
      FieldName = 'GuestName'
      Size = 100
    end
    object mGuestsAddress1: TWideStringField
      FieldName = 'Address1'
      Size = 100
    end
    object mGuestsAddress2: TWideStringField
      FieldName = 'Address2'
      Size = 100
    end
    object mGuestsAddress3: TWideStringField
      FieldName = 'Address3'
      Size = 100
    end
    object mGuestsAddress4: TWideStringField
      FieldName = 'Address4'
      Size = 100
    end
    object mGuestsCountry: TWideStringField
      FieldName = 'Country'
      Size = 2
    end
    object mGuestsPID: TWideStringField
      FieldName = 'PID'
      Size = 15
    end
    object mGuestsPersonsProfilesId: TIntegerField
      FieldName = 'PersonsProfilesId'
    end
  end
  object mGuestsDS: TDataSource
    DataSet = mGuests
    Left = 160
    Top = 504
  end
  object mGuestRooms: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterScroll = mGuestRoomsAfterScroll
    Left = 56
    Top = 440
    object mGuestRoomsReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mGuestRoomsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mGuestRoomsisGroup: TBooleanField
      DisplayLabel = 'Group'
      FieldName = 'isGroup'
    end
    object mGuestRoomsBreakfast: TBooleanField
      FieldName = 'Breakfast'
    end
    object mGuestRoomsrrArrival: TDateTimeField
      DisplayLabel = 'Arrival'
      FieldName = 'rrArrival'
    end
    object mGuestRoomsrrDeparture: TDateTimeField
      DisplayLabel = 'Departure'
      FieldName = 'rrDeparture'
    end
    object mGuestRoomsRoom: TWideStringField
      FieldName = 'Room'
      Size = 10
    end
    object mGuestRoomsRoomDescription: TWideStringField
      FieldName = 'RoomDescription'
      Size = 30
    end
    object mGuestRoomsEquipments: TWideStringField
      FieldName = 'Equipments'
      Size = 30
    end
    object mGuestRoomsNoRoom: TBooleanField
      FieldName = 'NoRoom'
    end
    object mGuestRoomsRoomType: TWideStringField
      FieldName = 'RoomType'
      Size = 5
    end
    object mGuestRoomsRoomTypeDescription: TWideStringField
      FieldName = 'RoomTypeDescription'
      Size = 30
    end
    object mGuestRoomsDefNumberGuests: TIntegerField
      FieldName = 'DefNumberGuests'
    end
    object mGuestRoomsFloor: TIntegerField
      FieldName = 'Floor'
    end
    object mGuestRoomsLocation: TWideStringField
      FieldName = 'Location'
      Size = 10
    end
    object mGuestRoomsLocationDescription: TWideStringField
      FieldName = 'LocationDescription'
      Size = 35
    end
    object mGuestRoomsMainGuest: TWideStringField
      FieldName = 'MainGuest'
      Size = 100
    end
    object mGuestRoomsGuestCount: TIntegerField
      FieldName = 'GuestCount'
    end
    object mGuestRoomsStatus: TWideStringField
      FieldName = 'Status'
      Size = 5
    end
    object mGuestRoomsStatusText: TWideStringField
      FieldName = 'StatusText'
      Size = 25
    end
    object mGuestRoomsPersonsProfilesId: TIntegerField
      FieldName = 'PersonsProfilesId'
    end
  end
  object mRoomsDS: TDataSource
    DataSet = mRooms
    Left = 352
    Top = 512
  end
  object mAllGuests: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterScroll = mAllGuestsAfterScroll
    Left = 240
    Top = 440
    object mAllGuestsIntegerField1: TIntegerField
      FieldName = 'Reservation'
    end
    object mAllGuestsIntegerField2: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mAllGuestsIsGroup: TBooleanField
      DisplayLabel = 'Group'
      FieldName = 'isGroup'
    end
    object mAllGuestsBreakfast: TBooleanField
      FieldName = 'Breakfast'
    end
    object mAllGuestsrrArrival: TDateTimeField
      DisplayLabel = 'Arrival'
      FieldName = 'rrArrival'
    end
    object mAllGuestsDeparture: TDateTimeField
      DisplayLabel = 'Departure'
      FieldName = 'rrDeparture'
    end
    object mAllGuestsRoom: TWideStringField
      FieldName = 'Room'
      Size = 10
    end
    object mAllGuestsRoomDescription: TWideStringField
      FieldName = 'RoomDescription'
      Size = 30
    end
    object mAllGuestsEquipments: TWideStringField
      FieldName = 'Equipments'
      Size = 30
    end
    object mAllGuestsNoRoom: TBooleanField
      FieldName = 'NoRoom'
    end
    object mAllGuestsRoomType: TWideStringField
      FieldName = 'RoomType'
      Size = 5
    end
    object mAllGuestsRoomTypeDescription: TWideStringField
      FieldName = 'RoomTypeDescription'
      Size = 30
    end
    object mAllGuestsDefNumberGuests: TIntegerField
      FieldName = 'DefNumberGuests'
    end
    object mAllGuestsFloor: TIntegerField
      FieldName = 'Floor'
    end
    object mAllGuestsLocation: TWideStringField
      FieldName = 'Location'
      Size = 10
    end
    object mAllGuestsLocationDescription: TWideStringField
      FieldName = 'LocationDescription'
      Size = 35
    end
    object mAllGuestsPerson: TIntegerField
      FieldName = 'Person'
    end
    object mAllGuestsGuestName: TWideStringField
      FieldName = 'GuestName'
      Size = 100
    end
    object mAllGuestsAddress1: TWideStringField
      FieldName = 'Address1'
      Size = 100
    end
    object mAllGuestsAddress2: TWideStringField
      FieldName = 'Address2'
      Size = 100
    end
    object mAllGuestsAddress3: TWideStringField
      FieldName = 'Address3'
      Size = 100
    end
    object mAllGuestsAddress4: TWideStringField
      FieldName = 'Address4'
      Size = 100
    end
    object mAllGuestsCountry: TWideStringField
      FieldName = 'Country'
      Size = 2
    end
    object mAllGuestsPID: TWideStringField
      FieldName = 'PID'
      Size = 15
    end
    object mAllGuestsStatus: TWideStringField
      FieldName = 'Status'
      Size = 5
    end
    object mAllGuestsStatusText: TWideStringField
      FieldName = 'StatusText'
      Size = 25
    end
    object mAllGuestsPersonsProfilesId: TIntegerField
      FieldName = 'PersonsProfilesId'
    end
  end
  object mAllGuestsDS: TDataSource
    DataSet = mAllGuests
    Left = 248
    Top = 504
  end
  object mInvoiceLines: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 752
    Top = 456
    object mInvoiceLinesInvoiceNumber: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object mInvoiceLinesItem: TStringField
      FieldName = 'Item'
    end
    object mInvoiceLinesDescription: TStringField
      FieldName = 'Description'
      Size = 70
    end
    object mInvoiceLinesPrice: TFloatField
      FieldName = 'Price'
    end
    object mInvoiceLinesVatType: TStringField
      FieldName = 'VatType'
      Size = 10
    end
    object mInvoiceLinesAmountWithTax: TFloatField
      FieldName = 'AmountWithTax'
    end
    object mInvoiceLinesAmountNoTax: TFloatField
      FieldName = 'AmountNoTax'
    end
    object mInvoiceLinesAmountTax: TFloatField
      FieldName = 'AmountTax'
    end
    object mInvoiceLinesCurrency: TStringField
      FieldName = 'Currency'
      Size = 5
    end
    object mInvoiceLinesCurrencyRate: TFloatField
      FieldName = 'CurrencyRate'
    end
    object mInvoiceLinesImportRefrence: TStringField
      FieldName = 'ImportRefrence'
      Size = 30
    end
    object mInvoiceLinesImportSource: TStringField
      FieldName = 'ImportSource'
      Size = 30
    end
    object mInvoiceLinespurchaseDate: TDateField
      FieldName = 'purchaseDate'
    end
    object mInvoiceLinesQuantity: TFloatField
      FieldName = 'Quantity'
    end
  end
  object mInvoiceHeads: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 608
    Top = 448
    object mInvoiceHeadsInvoiceNumber: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object mInvoiceHeadsSplitNumber: TIntegerField
      FieldName = 'SplitNumber'
    end
    object mInvoiceHeadsInvoiceDate: TDateField
      FieldName = 'InvoiceDate'
    end
    object mInvoiceHeadsdueDate: TDateField
      FieldName = 'dueDate'
    end
    object mInvoiceHeadsReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mInvoiceHeadsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mInvoiceHeadsCustomer: TStringField
      FieldName = 'Customer'
      Size = 30
    end
    object mInvoiceHeadsNameOnInvoice: TStringField
      FieldName = 'NameOnInvoice'
      Size = 50
    end
    object mInvoiceHeadsAddress1: TStringField
      FieldName = 'Address1'
      Size = 50
    end
    object mInvoiceHeadsAddress2: TStringField
      FieldName = 'Address2'
      Size = 50
    end
    object mInvoiceHeadsAddress3: TStringField
      FieldName = 'Address3'
      Size = 50
    end
    object mInvoiceHeadsAmountWithTax: TFloatField
      FieldName = 'AmountWithTax'
    end
    object mInvoiceHeadsAmountNoTax: TFloatField
      FieldName = 'AmountNoTax'
    end
    object mInvoiceHeadsinvRefrence: TStringField
      FieldName = 'invRefrence'
      Size = 30
    end
    object mInvoiceHeadsAmountTax: TFloatField
      FieldName = 'AmountTax'
    end
    object mInvoiceHeadsCreditInvoice: TIntegerField
      FieldName = 'CreditInvoice'
    end
    object mInvoiceHeadsOriginalInvoice: TIntegerField
      FieldName = 'OriginalInvoice'
    end
    object mInvoiceHeadsRoomGuest: TStringField
      FieldName = 'RoomGuest'
      Size = 50
    end
    object mInvoiceHeadsPayTypes: TStringField
      FieldName = 'PayTypes'
      Size = 30
    end
    object mInvoiceHeadsPayGroups: TStringField
      FieldName = 'PayGroups'
      Size = 30
    end
    object mInvoiceHeadsPayTypeDescription: TStringField
      FieldName = 'PayTypeDescription'
      Size = 30
    end
    object mInvoiceHeadspayGroupDescription: TStringField
      FieldName = 'payGroupDescription'
      Size = 30
    end
    object mInvoiceHeadsRoom: TStringField
      FieldName = 'Room'
      Size = 15
    end
  end
  object mInvoiceHeadsDS: TDataSource
    DataSet = mInvoiceHeads
    Left = 592
    Top = 496
  end
  object mInvoiceLinesDS: TDataSource
    DataSet = mInvoiceLines
    Left = 592
    Top = 560
  end
  object StoreMain: TcxPropertiesStore
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
    StorageName = 'Software\Roomer\FormStatus\ReservationProfile2'
    StorageType = stRegistry
    Left = 448
    Top = 464
  end
  object timStart: TTimer
    Enabled = False
    Interval = 100
    OnTimer = timStartTimer
    Left = 512
    Top = 456
  end
  object timBlink: TTimer
    Enabled = False
    Interval = 500
    OnTimer = timBlinkTimer
    Left = 832
    Top = 456
  end
  object DropComboTarget1: TDropComboTarget
    DragTypes = [dtCopy, dtLink]
    OnDragOver = DropComboTarget1DragOver
    OnDrop = DropComboTarget1Drop
    OnGetDropEffect = DropComboTarget1GetDropEffect
    Target = Owner
    Left = 884
    Top = 512
  end
  object mExtras: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 448
    Top = 544
    object mExtrasRoomreservation: TIntegerField
      FieldName = 'Roomreservation'
    end
    object mExtrasItemid: TIntegerField
      FieldName = 'Itemid'
    end
    object mExtrasCount: TIntegerField
      FieldName = 'Count'
    end
    object mExtrasPricePerItemPerDay: TFloatField
      FieldName = 'PricePerItemPerDay'
    end
    object mExtrasFromdate: TDateTimeField
      FieldName = 'Fromdate'
    end
    object mExtrasToDate: TDateTimeField
      FieldName = 'ToDate'
    end
    object mExtrasItem: TStringField
      FieldName = 'Item'
    end
    object mExtrasDescription: TStringField
      FieldName = 'Description'
    end
    object mExtrasTotalPrice: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalPrice'
      Calculated = True
    end
  end
end
