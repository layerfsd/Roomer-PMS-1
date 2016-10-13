object frmInvoice: TfrmInvoice
  Left = 686
  Top = 154
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biMinimize, biMaximize]
  ClientHeight = 681
  ClientWidth = 1074
  Color = clBtnFace
  Constraints.MinWidth = 910
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PANmAIN: TsPanel
    Left = 0
    Top = 0
    Width = 1074
    Height = 662
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object lblChangedInvoiceActive: TsLabel
      Left = 0
      Top = 157
      Width = 1074
      Height = 3
      Hint = 'Search Filter Active'
      Align = alTop
      AutoSize = False
      Color = clRed
      ParentColor = False
      ParentFont = False
      Visible = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      UseSkinColor = False
      ExplicitTop = 27
      ExplicitWidth = 1153
    end
    object Panel1: TsPanel
      Left = 0
      Top = 0
      Width = 1074
      Height = 157
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        1074
        157)
      object clabCurrency: TsLabel
        Left = 661
        Top = 31
        Width = 57
        Height = 13
        Alignment = taRightJustify
        Caption = 'Currency :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object clabRate: TsLabel
        Left = 685
        Top = 52
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'Rate :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object clabRefrence: TsLabel
        Left = 661
        Top = 101
        Width = 57
        Height = 13
        Alignment = taRightJustify
        Caption = 'Refrence :'
        Color = 15400938
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object clabInvoice: TsLabel
        Left = 657
        Top = 7
        Width = 56
        Height = 18
        Alignment = taRightJustify
        Caption = 'Invoice'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object clabRoomGuest: TsLabel
        Left = 644
        Top = 78
        Width = 74
        Height = 13
        Alignment = taRightJustify
        Caption = 'Guest name :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object clabCustomer: TsLabel
        Left = 2
        Top = 22
        Width = 103
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Customer :'
        Color = 15400938
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object clabPId: TsLabel
        Left = 2
        Top = 45
        Width = 103
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ID :'
        Color = 15400938
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object clabCountry: TsLabel
        Left = 2
        Top = 140
        Width = 103
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Country :'
        Color = 15400938
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object clabAddress: TsLabel
        Left = 2
        Top = 81
        Width = 103
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Address :'
        Color = 15400938
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object cLabName: TsLabel
        Left = 2
        Top = 61
        Width = 103
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Name :'
        Color = 15400938
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object labTmpStatus: TsLabel
        Left = 719
        Top = 11
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
      object clabForeignCurrency: TsLabel
        Left = 616
        Top = 124
        Width = 102
        Height = 13
        Alignment = taRightJustify
        Caption = 'Foreign Currency :'
        ParentFont = False
        Visible = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object edtCurrency: TsEdit
        Left = 724
        Top = 28
        Width = 70
        Height = 20
        AutoSize = False
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 10
        OnDblClick = edtCurrencyDblClick
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object rgrInvoiceType: TsRadioGroup
        Left = 368
        Top = 0
        Width = 189
        Height = 151
        Caption = 'Invoice header method'
        ParentBackground = False
        TabOrder = 9
        OnClick = rgrInvoiceTypeClick
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        ItemIndex = 1
        Items.Strings = (
          'Customer'
          'Reservation Customer'
          'RoomGuest'
          'Last Saved '
          'Free Text'
          'Cash')
      end
      object edtRate: TsEdit
        Left = 724
        Top = 49
        Width = 70
        Height = 20
        AutoSize = False
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 12
        OnDblClick = edtRateDblClick
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object edtInvRefrence: TsEdit
        Left = 724
        Top = 101
        Width = 160
        Height = 17
        AutoSize = False
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 30
        ParentFont = False
        TabOrder = 15
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object btnGetCurrency: TsButton
        Left = 795
        Top = 28
        Width = 90
        Height = 20
        Caption = 'Get..'
        TabOrder = 11
        OnClick = edtCurrencyDblClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnGetRate: TsButton
        Left = 795
        Top = 49
        Width = 90
        Height = 20
        Caption = 'Get..'
        TabOrder = 13
        OnClick = edtRateDblClick
        SkinData.SkinSection = 'BUTTON'
      end
      object edtRoomGuest: TsEdit
        Left = 724
        Top = 78
        Width = 160
        Height = 17
        AutoSize = False
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 14
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object edtCustomer: TsEdit
        Left = 111
        Top = 19
        Width = 93
        Height = 17
        AutoSize = False
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 15
        ParentFont = False
        TabOrder = 0
        OnChange = edtCustomerChange
        OnDblClick = edtCustomerDblClick
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object edtPersonalId: TsEdit
        Left = 111
        Top = 42
        Width = 253
        Height = 17
        AutoSize = False
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 15
        ParentFont = False
        TabOrder = 3
        OnDblClick = edtCustomerDblClick
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object edtName: TsEdit
        Left = 111
        Top = 61
        Width = 253
        Height = 17
        AutoSize = False
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object edtAddress1: TsEdit
        Left = 111
        Top = 80
        Width = 253
        Height = 17
        AutoSize = False
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object edtAddress2: TsEdit
        Left = 111
        Top = 99
        Width = 253
        Height = 17
        AutoSize = False
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object edtAddress3: TsEdit
        Left = 111
        Top = 118
        Width = 253
        Height = 17
        AutoSize = False
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object edtAddress4: TsEdit
        Left = 111
        Top = 137
        Width = 253
        Height = 17
        AutoSize = False
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object btnClearAddresses: TsButton
        Left = 237
        Top = 21
        Width = 126
        Height = 17
        Caption = 'Clear addresses'
        TabOrder = 2
        OnClick = btnClearAddressesClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnExit: TcxButton
        Left = 907
        Top = -3
        Width = 161
        Height = 44
        Hint = 'Close form'
        Anchors = [akTop, akRight]
        Caption = 'Close'
        LookAndFeel.NativeStyle = False
        ModalResult = 1
        OptionsImage.ImageIndex = 4
        OptionsImage.Images = DImages.cxLargeImagesFlat
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.Flat = True
        TabOrder = 17
        WordWrap = True
        OnClick = btnExitClick
      end
      object btnInvoice: TcxButton
        Left = 907
        Top = 91
        Width = 161
        Height = 41
        Action = actPrintInvoice
        Anchors = [akTop, akRight]
        Caption = 'Pay and Print'
        LookAndFeel.NativeStyle = False
        OptionsImage.ImageIndex = 59
        OptionsImage.Images = DImages.cxLargeImagesFlat
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.Flat = True
        TabOrder = 19
        WordWrap = True
      end
      object btnProforma: TcxButton
        Left = 907
        Top = 44
        Width = 161
        Height = 41
        Action = actPrintProforma
        Anchors = [akTop, akRight]
        LookAndFeel.NativeStyle = False
        OptionsImage.ImageIndex = 3
        OptionsImage.Images = DImages.cxLargeImagesFlat
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.Flat = True
        TabOrder = 18
        WordWrap = True
      end
      object edtForeignCurrency: TsEdit
        Left = 724
        Top = 124
        Width = 105
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = bsNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 16
        Text = '0'
        Visible = False
        OnChange = edtTotalChange
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object chkShowPackage: TsCheckBox
        Left = 906
        Top = 135
        Width = 111
        Height = 20
        Caption = 'Package on invoice'
        Anchors = [akTop, akRight]
        Checked = True
        State = cbChecked
        TabOrder = 20
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object btnGetCustomer: TsButton
        Left = 204
        Top = 21
        Width = 27
        Height = 17
        Caption = '...'
        TabOrder = 1
        OnClick = edtCustomerDblClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object sPanel5: TsPanel
      Left = 0
      Top = 160
      Width = 1074
      Height = 502
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pageMain: TPageControl
        Left = 0
        Top = 0
        Width = 1018
        Height = 502
        ActivePage = tabInvoice
        Align = alClient
        TabOrder = 0
        object tabInvoice: TTabSheet
          Caption = 'Invoice'
          TabVisible = False
          object Panel2: TsPanel
            Left = 0
            Top = 340
            Width = 1010
            Height = 152
            Align = alBottom
            BevelOuter = bvLowered
            ParentColor = True
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            object memExtraText: TMemo
              Left = 1
              Top = 1
              Width = 336
              Height = 150
              Align = alLeft
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = 16384
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
            end
            object sPanel2: TsPanel
              Left = 337
              Top = 1
              Width = 256
              Height = 150
              Align = alLeft
              ParentBackground = False
              ParentColor = True
              TabOrder = 1
              SkinData.SkinSection = 'PANEL'
              object clabTotalwoVAT: TsLabel
                Left = 7
                Top = 9
                Width = 124
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Total w/o VAT :'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
              end
              object clavVAT: TsLabel
                Left = 7
                Top = 29
                Width = 124
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'VAT :'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
              end
              object clabInvoiceTotal: TsLabel
                Left = 7
                Top = 49
                Width = 124
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Invoice total :'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
              end
              object clabDownpayments: TsLabel
                Left = 7
                Top = 69
                Width = 124
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Down payments :'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
              end
              object clabBalance: TsLabel
                Left = 7
                Top = 89
                Width = 124
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Balance :'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
              end
              object edtTotal: TsEdit
                Left = 139
                Top = 6
                Width = 105
                Height = 17
                Alignment = taRightJustify
                AutoSize = False
                BorderStyle = bsNone
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
                OnChange = edtTotalChange
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtVat: TsEdit
                Left = 139
                Top = 26
                Width = 105
                Height = 17
                Alignment = taRightJustify
                AutoSize = False
                BorderStyle = bsNone
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 1
                OnChange = edtTotalChange
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtInvoiceTotal: TsEdit
                Left = 139
                Top = 46
                Width = 105
                Height = 17
                Alignment = taRightJustify
                AutoSize = False
                BorderStyle = bsNone
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 2
                OnChange = edtTotalChange
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtDownPayments: TsEdit
                Left = 139
                Top = 66
                Width = 105
                Height = 17
                Alignment = taRightJustify
                AutoSize = False
                BorderStyle = bsNone
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 3
                OnChange = edtTotalChange
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtBalance: TsEdit
                Left = 139
                Top = 86
                Width = 105
                Height = 17
                Alignment = taRightJustify
                AutoSize = False
                BorderStyle = bsNone
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                OnChange = edtTotalChange
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object grbInclutedTaxes: TsGroupBox
                Left = 16
                Top = 110
                Width = 228
                Height = 36
                Caption = 'Included taxes'
                TabOrder = 5
                SkinData.SkinSection = 'GROUPBOX'
                Checked = False
                object labLodgingTaxISK: TsLabel
                  Left = 12
                  Top = 16
                  Width = 22
                  Height = 13
                  Caption = '0,00'
                end
                object labLodgingTaxNights: TsLabel
                  Left = 192
                  Top = 16
                  Width = 22
                  Height = 13
                  Caption = '0,00'
                end
                object labTaxNights: TsLabel
                  Left = 95
                  Top = 16
                  Width = 53
                  Height = 13
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'units :'
                  ParentFont = False
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                end
                object ClabLodgingTaxCurrency: TsLabel
                  Left = 77
                  Top = 16
                  Width = 19
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'ISK'
                  ParentFont = False
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                end
              end
            end
            object TsPanel
              Left = 593
              Top = 1
              Width = 416
              Height = 150
              Align = alClient
              TabOrder = 2
              SkinData.SkinSection = 'PANEL'
              object sPanel3: TsPanel
                Left = 1
                Top = 1
                Width = 414
                Height = 20
                Align = alTop
                TabOrder = 0
                SkinData.SkinSection = 'PANEL'
                object labPayments: TsLabel
                  Left = 9
                  Top = 2
                  Width = 84
                  Height = 13
                  Caption = 'Down payments :'
                end
              end
              object grPayments: TcxGrid
                Left = 1
                Top = 21
                Width = 414
                Height = 128
                Align = alClient
                DragMode = dmAutomatic
                TabOrder = 1
                LookAndFeel.NativeStyle = False
                object tvPayments: TcxGridDBTableView
                  OnMouseDown = tvPaymentsMouseDown
                  Navigator.Buttons.CustomButtons = <>
                  OnCellDblClick = tvPaymentsCellDblClick
                  DataController.DataSource = PaymentsDS
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsData.CancelOnExit = False
                  OptionsData.Deleting = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Editing = False
                  OptionsData.Inserting = False
                  OptionsView.GroupByBox = False
                  object tvPaymentsPayDate: TcxGridDBColumn
                    Caption = 'Date'
                    DataBinding.FieldName = 'PayDate'
                    Width = 75
                  end
                  object tvPaymentsPayType: TcxGridDBColumn
                    Caption = 'Type'
                    DataBinding.FieldName = 'PayType'
                    Width = 78
                  end
                  object tvPaymentsAmount: TcxGridDBColumn
                    DataBinding.FieldName = 'Amount'
                    Width = 84
                  end
                  object tvPaymentsDescription: TcxGridDBColumn
                    DataBinding.FieldName = 'Description'
                    Width = 128
                  end
                  object tvPaymentsPayGroup: TcxGridDBColumn
                    DataBinding.FieldName = 'PayGroup'
                    Width = 70
                  end
                  object tvPaymentsMemo: TcxGridDBColumn
                    DataBinding.FieldName = 'Memo'
                    PropertiesClassName = 'TcxMemoProperties'
                    Options.Editing = False
                  end
                  object tvPaymentsconfirmDate: TcxGridDBColumn
                    DataBinding.FieldName = 'confirmDate'
                  end
                  object tvPaymentsid: TcxGridDBColumn
                    DataBinding.FieldName = 'id'
                  end
                end
                object lvPayments: TcxGridLevel
                  GridView = tvPayments
                end
              end
            end
          end
          object Panel4: TsPanel
            Left = 0
            Top = 0
            Width = 1010
            Height = 91
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            SkinData.SkinSection = 'PANEL'
            DesignSize = (
              1010
              91)
            object btnRoomToTemp: TsButton
              Left = 10
              Top = 4
              Width = 130
              Height = 40
              Action = actRRtoTemp
              TabOrder = 0
              SkinData.SkinSection = 'BUTTON'
            end
            object btnAddItem: TsButton
              Left = 10
              Top = 47
              Width = 130
              Height = 40
              Action = actAddLine
              TabOrder = 1
              SkinData.SkinSection = 'BUTTON'
            end
            object btnItemToTmp: TsButton
              Left = 141
              Top = 4
              Width = 130
              Height = 40
              Action = actItemToTemp
              TabOrder = 2
              SkinData.SkinSection = 'BUTTON'
            end
            object btnRemoveItem: TsButton
              Left = 141
              Top = 47
              Width = 130
              Height = 40
              Action = actDelLine
              TabOrder = 3
              SkinData.SkinSection = 'BUTTON'
            end
            object btnMoveItem: TsButton
              Left = 272
              Top = 4
              Width = 130
              Height = 40
              Action = actItemToGroupInvoice
              Caption = 'Move sales item'
              DropDownMenu = mnuMoveItem
              Style = bsSplitButton
              TabOrder = 4
              SkinData.SkinSection = 'BUTTON'
            end
            object btnMoveRoom: TsButton
              Left = 403
              Top = 4
              Width = 130
              Height = 40
              Caption = 'Move room item'
              DropDownMenu = mnuMoveRoom
              Enabled = False
              Style = bsSplitButton
              TabOrder = 6
              SkinData.SkinSection = 'BUTTON'
            end
            object btnRemoveLodgingTax2: TsButton
              Left = 403
              Top = 47
              Width = 130
              Height = 40
              Caption = 'Toggle lodging tax'
              TabOrder = 7
              OnClick = btnRemoveLodgingTax2Click
              SkinData.SkinSection = 'BUTTON'
            end
            object btnReservationNotes: TsButton
              Left = 272
              Top = 47
              Width = 130
              Height = 40
              Caption = 'Reservation notes'
              TabOrder = 5
              OnClick = btnReservationNotesClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnAddDownPayment: TsButton
              Left = 606
              Top = 47
              Width = 131
              Height = 40
              Action = actDownPayment
              Anchors = [akTop, akRight]
              TabOrder = 8
              SkinData.SkinSection = 'BUTTON'
            end
            object btnEditDownPayment: TsButton
              Left = 738
              Top = 47
              Width = 131
              Height = 40
              Anchors = [akTop, akRight]
              Caption = 'Edit Down Payment'
              TabOrder = 9
              OnClick = btnEditDownPaymentClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnDeleteDownpayment: TsButton
              Left = 870
              Top = 47
              Width = 134
              Height = 40
              Anchors = [akTop, akRight]
              Caption = 'Delete Down Payment'
              TabOrder = 10
              OnClick = btnDeleteDownpaymentClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnSaveChanges: TsButton
              Left = 870
              Top = 4
              Width = 134
              Height = 40
              Anchors = [akTop, akRight]
              Caption = 'Save changes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ImageIndex = 2
              Images = DImages.cxSmallImagesFlat
              ParentFont = False
              TabOrder = 11
              Visible = False
              OnClick = btnSaveChangesClick
              SkinData.CustomFont = True
              SkinData.ColorTone = clRed
            end
          end
          object sPanel1: TsPanel
            Left = 0
            Top = 91
            Width = 1010
            Height = 249
            Align = alClient
            BevelOuter = bvNone
            Caption = 'sPanel1'
            Padding.Left = 10
            Padding.Top = 5
            Padding.Right = 10
            Padding.Bottom = 5
            TabOrder = 2
            SkinData.SkinSection = 'PANEL'
            object agrLines: TAdvStringGrid
              Left = 10
              Top = 5
              Width = 990
              Height = 239
              Cursor = crDefault
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              ColCount = 7
              DefaultRowHeight = 19
              DrawingStyle = gdsClassic
              FixedCols = 0
              RowCount = 2
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goThumbTracking]
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
              OnDrawCell = agrLinesDrawCell
              OnGetEditText = agrLinesGetEditText
              OnKeyDown = agrLinesKeyDown
              OnMouseDown = agrLinesMouseDown
              HoverRowCells = [hcNormal, hcSelected]
              OnGetCellColor = agrLinesGetCellColor
              OnGetAlignment = agrLinesGetAlignment
              OnRowChanging = agrLinesRowChanging
              OnDblClickCell = agrLinesDblClickCell
              OnCanEditCell = agrLinesCanEditCell
              OnCellValidate = agrLinesCellValidate
              OnCheckBoxClick = agrLinesCheckBoxClick
              OnColumnSize = agrLinesColumnSize
              ActiveCellFont.Charset = DEFAULT_CHARSET
              ActiveCellFont.Color = clWindowText
              ActiveCellFont.Height = -13
              ActiveCellFont.Name = 'Tahoma'
              ActiveCellFont.Style = [fsBold]
              ControlLook.FixedGradientHoverFrom = clGray
              ControlLook.FixedGradientHoverTo = clWhite
              ControlLook.FixedGradientDownFrom = clGray
              ControlLook.FixedGradientDownTo = clSilver
              ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
              ControlLook.DropDownHeader.Font.Color = clWindowText
              ControlLook.DropDownHeader.Font.Height = -13
              ControlLook.DropDownHeader.Font.Name = 'Tahoma'
              ControlLook.DropDownHeader.Font.Style = []
              ControlLook.DropDownHeader.Visible = True
              ControlLook.DropDownHeader.Buttons = <>
              ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
              ControlLook.DropDownFooter.Font.Color = clWindowText
              ControlLook.DropDownFooter.Font.Height = -13
              ControlLook.DropDownFooter.Font.Name = 'Tahoma'
              ControlLook.DropDownFooter.Font.Style = []
              ControlLook.DropDownFooter.Visible = True
              ControlLook.DropDownFooter.Buttons = <>
              Filter = <>
              FilterDropDown.Font.Charset = DEFAULT_CHARSET
              FilterDropDown.Font.Color = clWindowText
              FilterDropDown.Font.Height = -13
              FilterDropDown.Font.Name = 'Tahoma'
              FilterDropDown.Font.Style = []
              FilterDropDownClear = '(All)'
              FilterEdit.TypeNames.Strings = (
                'Starts with'
                'Ends with'
                'Contains'
                'Not contains'
                'Equal'
                'Not equal'
                'Larger than'
                'Smaller than'
                'Clear')
              FixedColWidth = 24
              FixedRowHeight = 19
              FixedFont.Charset = DEFAULT_CHARSET
              FixedFont.Color = clWindowText
              FixedFont.Height = -13
              FixedFont.Name = 'Tahoma'
              FixedFont.Style = [fsBold]
              FloatFormat = '%.2f'
              HoverButtons.Buttons = <>
              HoverButtons.Position = hbLeftFromColumnLeft
              HTMLSettings.ImageFolder = 'images'
              HTMLSettings.ImageBaseName = 'img'
              PrintSettings.DateFormat = 'dd/mm/yyyy'
              PrintSettings.Font.Charset = DEFAULT_CHARSET
              PrintSettings.Font.Color = clWindowText
              PrintSettings.Font.Height = -13
              PrintSettings.Font.Name = 'Tahoma'
              PrintSettings.Font.Style = []
              PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
              PrintSettings.FixedFont.Color = clWindowText
              PrintSettings.FixedFont.Height = -13
              PrintSettings.FixedFont.Name = 'Tahoma'
              PrintSettings.FixedFont.Style = []
              PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
              PrintSettings.HeaderFont.Color = clWindowText
              PrintSettings.HeaderFont.Height = -13
              PrintSettings.HeaderFont.Name = 'Tahoma'
              PrintSettings.HeaderFont.Style = []
              PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
              PrintSettings.FooterFont.Color = clWindowText
              PrintSettings.FooterFont.Height = -13
              PrintSettings.FooterFont.Name = 'Tahoma'
              PrintSettings.FooterFont.Style = []
              PrintSettings.PageNumSep = '/'
              ScrollWidth = 21
              SearchFooter.FindNextCaption = 'Find &next'
              SearchFooter.FindPrevCaption = 'Find &previous'
              SearchFooter.Font.Charset = DEFAULT_CHARSET
              SearchFooter.Font.Color = clWindowText
              SearchFooter.Font.Height = -13
              SearchFooter.Font.Name = 'Tahoma'
              SearchFooter.Font.Style = []
              SearchFooter.HighLightCaption = 'Highlight'
              SearchFooter.HintClose = 'Close'
              SearchFooter.HintFindNext = 'Find next occurrence'
              SearchFooter.HintFindPrev = 'Find previous occurrence'
              SearchFooter.HintHighlight = 'Highlight occurrences'
              SearchFooter.MatchCaseCaption = 'Match case'
              SortSettings.DefaultFormat = ssAutomatic
              Version = '8.1.2.0'
              ColWidths = (
                24
                91
                348
                88
                83
                91
                31)
            end
          end
        end
        object tabRoomPrice: TTabSheet
          Caption = 'RoomPrice'
          TabVisible = False
          object panTopRoomRates: TsPanel
            Left = 0
            Top = 0
            Width = 1010
            Height = 85
            Align = alTop
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            object cxGroupBox4: TsGroupBox
              AlignWithMargins = True
              Left = 230
              Top = 4
              Width = 220
              Height = 77
              Align = alLeft
              Caption = 'Selected room'
              TabOrder = 0
              SkinData.SkinSection = 'GROUPBOX'
              Checked = False
              object btdEditRoomRate: TsButton
                Left = 8
                Top = 14
                Width = 206
                Height = 20
                Caption = 'Change rate per date'
                TabOrder = 0
                OnClick = btdEditRoomRateClick
                SkinData.SkinSection = 'BUTTON'
              end
              object sButton1: TsButton
                Left = 9
                Top = 33
                Width = 206
                Height = 20
                Caption = 'Apply to all roomtypes'
                TabOrder = 1
                OnClick = sButton1Click
                SkinData.SkinSection = 'BUTTON'
              end
              object sButton4: TsButton
                Left = 9
                Top = 53
                Width = 206
                Height = 20
                Caption = 'Apply to same roomtype'
                TabOrder = 2
                OnClick = sButton4Click
                SkinData.SkinSection = 'BUTTON'
              end
            end
            object sGroupBox2: TsGroupBox
              AlignWithMargins = True
              Left = 456
              Top = 4
              Width = 268
              Height = 77
              Align = alLeft
              Caption = 'Other properties'
              TabOrder = 1
              SkinData.SkinSection = 'GROUPBOX'
              Checked = False
              object chkReCalcPrices: TsCheckBox
                Left = 9
                Top = 20
                Width = 195
                Height = 20
                Caption = 'Recalc price on guestcount  changes'
                Checked = True
                State = cbChecked
                TabOrder = 0
                SkinData.SkinSection = 'CHECKBOX'
                ImgChecked = 0
                ImgUnchecked = 0
              end
              object chkAutoUpdateNullPrice: TsCheckBox
                Left = 9
                Top = 46
                Width = 126
                Height = 20
                Caption = 'Auto update Null Price'
                Checked = True
                State = cbChecked
                TabOrder = 1
                SkinData.SkinSection = 'CHECKBOX'
                ImgChecked = 0
                ImgUnchecked = 0
              end
            end
            object sGroupBox1: TsGroupBox
              AlignWithMargins = True
              Left = 4
              Top = 4
              Width = 220
              Height = 77
              Align = alLeft
              Caption = 'Back to Invoice'
              TabOrder = 2
              SkinData.SkinSection = 'GROUPBOX'
              Checked = False
              DesignSize = (
                220
                77)
              object sButton2: TsButton
                Left = 111
                Top = 16
                Width = 100
                Height = 55
                Anchors = [akTop, akRight]
                Caption = 'Cancel'
                ImageIndex = 10
                Images = DImages.cxLargeImagesFlat
                TabOrder = 0
                OnClick = sButton2Click
                SkinData.SkinSection = 'BUTTON'
              end
              object sButton3: TsButton
                Left = 6
                Top = 16
                Width = 100
                Height = 55
                Caption = 'Apply'
                ImageIndex = 82
                Images = DImages.cxLargeImagesFlat
                TabOrder = 1
                OnClick = sButton3Click
                SkinData.SkinSection = 'BUTTON'
              end
            end
          end
          object grRoomRes: TcxGrid
            Left = 0
            Top = 85
            Width = 1010
            Height = 407
            Align = alClient
            TabOrder = 1
            LookAndFeel.NativeStyle = False
            object tvRoomRes: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = mRoomResDS
              DataController.DetailKeyFieldNames = 'RoomReservation'
              DataController.KeyFieldNames = 'RoomReservation'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = '###0.;###0.'
                  Kind = skSum
                  FieldName = 'Guests'
                  Column = tvRoomResGuests
                end
                item
                  Format = '###0.;###0.'
                  Kind = skSum
                  FieldName = 'ChildrenCount'
                  Column = tvRoomResChildrenCount
                end
                item
                  Format = '###0.;###0.'
                  Kind = skSum
                  FieldName = 'infantCount'
                  Column = tvRoomResinfantCount
                end
                item
                  Format = '###0.00;###0.00'
                  Kind = skSum
                  FieldName = 'AvragePrice'
                  Column = tvRoomResAvragePrice
                end
                item
                  Format = '###0.00;###0.00'
                  Kind = skAverage
                  FieldName = 'AvragePrice'
                  Column = tvRoomResAvragePrice
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.Footer = True
              OptionsView.FooterAutoHeight = True
              OptionsView.FooterMultiSummaries = True
              OptionsView.GroupByBox = False
              object tvRoomResColumn1: TcxGridDBColumn
                Caption = 'Edit'
                PropertiesClassName = 'TcxButtonEditProperties'
                Properties.Buttons = <
                  item
                    Caption = 'Refresh'
                    Default = True
                    ImageIndex = 29
                    Kind = bkGlyph
                  end>
                Properties.ViewStyle = vsButtonsOnly
                Properties.OnButtonClick = tvRoomResColumn1PropertiesButtonClick
                Options.ShowEditButtons = isebAlways
                Width = 39
              end
              object tvRoomResRoom: TcxGridDBColumn
                DataBinding.FieldName = 'Room'
                Options.Editing = False
              end
              object tvRoomResRoomDescription: TcxGridDBColumn
                Caption = 'Description'
                DataBinding.FieldName = 'RoomDescription'
                Options.Editing = False
                Width = 95
              end
              object tvRoomResRoomType: TcxGridDBColumn
                Caption = 'Type'
                DataBinding.FieldName = 'RoomType'
                Options.Editing = False
              end
              object tvRoomResRoomTypeDescription: TcxGridDBColumn
                Caption = 'Description'
                DataBinding.FieldName = 'RoomTypeDescription'
                Visible = False
                Options.Editing = False
                Width = 111
              end
              object tvRoomResGuestName: TcxGridDBColumn
                Caption = 'Guest name'
                DataBinding.FieldName = 'GuestName'
                Width = 172
              end
              object tvRoomResArrival: TcxGridDBColumn
                DataBinding.FieldName = 'Arrival'
                Options.Editing = False
                Width = 80
              end
              object tvRoomResDeparture: TcxGridDBColumn
                DataBinding.FieldName = 'Departure'
                Options.Editing = False
                Width = 80
              end
              object tvRoomResGuests: TcxGridDBColumn
                DataBinding.FieldName = 'Guests'
                PropertiesClassName = 'TcxSpinEditProperties'
                Properties.MaxValue = 100.000000000000000000
                Properties.MinValue = 1.000000000000000000
                Properties.OnEditValueChanged = tvRoomResGuestsPropertiesEditValueChanged
                Width = 45
              end
              object tvRoomResChildrenCount: TcxGridDBColumn
                Caption = 'Children'
                DataBinding.FieldName = 'ChildrenCount'
                PropertiesClassName = 'TcxSpinEditProperties'
                Properties.MaxValue = 10.000000000000000000
                Properties.OnEditValueChanged = tvRoomResChildrenCountPropertiesEditValueChanged
                Width = 45
              end
              object tvRoomResinfantCount: TcxGridDBColumn
                Caption = 'infants'
                DataBinding.FieldName = 'infantCount'
                PropertiesClassName = 'TcxSpinEditProperties'
                Properties.MaxValue = 10.000000000000000000
                Properties.OnEditValueChanged = tvRoomResinfantCountPropertiesEditValueChanged
                Width = 45
              end
              object tvRoomResAvragePrice: TcxGridDBColumn
                DataBinding.FieldName = 'AvragePrice'
                PropertiesClassName = 'TcxCalcEditProperties'
                Properties.DisplayFormat = '###0.00;###0.00'
                Properties.OnEditValueChanged = tvRoomResAvragePricePropertiesEditValueChanged
              end
              object tvRoomResPackage: TcxGridDBColumn
                DataBinding.FieldName = 'Package'
                Width = 89
              end
              object tvRoomResRateCount: TcxGridDBColumn
                DataBinding.FieldName = 'RateCount'
                PropertiesClassName = 'TcxSpinEditProperties'
                Properties.DisplayFormat = '###0.;###0.'
                Options.Editing = False
              end
              object tvRoomResPriceCode: TcxGridDBColumn
                DataBinding.FieldName = 'PriceCode'
                Options.Editing = False
              end
              object tvRoomResAvrageDiscount: TcxGridDBColumn
                DataBinding.FieldName = 'AvrageDiscount'
                Options.Editing = False
              end
              object tvRoomResisPercentage: TcxGridDBColumn
                DataBinding.FieldName = 'isPercentage'
                Options.Editing = False
              end
              object tvRoomResRoomReservation: TcxGridDBColumn
                DataBinding.FieldName = 'RoomReservation'
              end
            end
            object tvRoomRates: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataModeController.SyncMode = False
              DataController.DataSource = kbmRoomRatesDS
              DataController.DetailKeyFieldNames = 'RoomReservation'
              DataController.KeyFieldNames = 'RoomReservation'
              DataController.MasterKeyFieldNames = 'RoomReservation'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.GroupByBox = False
              object tvRoomRatesReservation: TcxGridDBColumn
                DataBinding.FieldName = 'Reservation'
                Visible = False
              end
              object tvRoomRatesRoomReservation: TcxGridDBColumn
                DataBinding.FieldName = 'RoomReservation'
                Visible = False
              end
              object tvRoomRatesRoomNumber: TcxGridDBColumn
                Caption = 'Room'
                DataBinding.FieldName = 'RoomNumber'
                Visible = False
              end
              object tvRoomRatesRateDate: TcxGridDBColumn
                Caption = 'Date'
                DataBinding.FieldName = 'RateDate'
              end
              object tvRoomRatesPriceCode: TcxGridDBColumn
                Caption = 'Price code'
                DataBinding.FieldName = 'PriceCode'
              end
              object tvRoomRatesRate: TcxGridDBColumn
                Caption = 'Room Rate'
                DataBinding.FieldName = 'Rate'
                PropertiesClassName = 'TcxCalcEditProperties'
              end
              object tvRoomRatesDiscount: TcxGridDBColumn
                DataBinding.FieldName = 'Discount'
              end
              object tvRoomRatesisPercentage: TcxGridDBColumn
                Caption = 'is %'
                DataBinding.FieldName = 'isPercentage'
              end
              object tvRoomRatesShowDiscount: TcxGridDBColumn
                Caption = 'Show Discount'
                DataBinding.FieldName = 'ShowDiscount'
                Visible = False
              end
              object tvRoomRatesisPaid: TcxGridDBColumn
                Caption = 'Paid'
                DataBinding.FieldName = 'isPaid'
                Visible = False
              end
              object tvRoomRatesDiscountAmount: TcxGridDBColumn
                Caption = 'Total discount'
                DataBinding.FieldName = 'DiscountAmount'
              end
              object tvRoomRatesRentAmount: TcxGridDBColumn
                Caption = 'Total Rent'
                DataBinding.FieldName = 'RentAmount'
              end
              object tvRoomRatesNativeAmount: TcxGridDBColumn
                Caption = 'Native'
                DataBinding.FieldName = 'NativeAmount'
              end
            end
            object lvRoomRes: TcxGridLevel
              GridView = tvRoomRes
              object lvRoomRates: TcxGridLevel
                GridView = tvRoomRates
              end
            end
          end
        end
      end
      object sPanel4: TsPanel
        AlignWithMargins = True
        Left = 1021
        Top = 3
        Width = 50
        Height = 496
        Align = alRight
        TabOrder = 1
        object pnlInvoiceIndex0: TsPanel
          Left = 3
          Top = 4
          Width = 42
          Height = 31
          Alignment = taRightJustify
          BevelInner = bvLowered
          Caption = '1 '
          Color = 16764840
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          OnClick = pnlInvoiceIndex0Click
          OnDragDrop = pnlInvoiceIndex0DragDrop
          OnDragOver = pnlInvoiceIndex0DragOver
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          object shpInvoiceIndex0: TShape
            Left = 2
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Brush.Color = clRed
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 1
            ExplicitTop = 1
            ExplicitHeight = 29
          end
          object shpInvoiceIndexRR0: TShape
            Left = 10
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Brush.Color = clBlue
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 24
            ExplicitTop = 1
            ExplicitHeight = 29
          end
        end
        object pnlInvoiceIndex1: TsPanel
          Tag = 1
          Left = 3
          Top = 41
          Width = 42
          Height = 31
          Alignment = taRightJustify
          BevelInner = bvLowered
          Caption = '2 '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          OnClick = pnlInvoiceIndex0Click
          OnDragDrop = pnlInvoiceIndex0DragDrop
          OnDragOver = pnlInvoiceIndex0DragOver
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          object shpInvoiceIndex1: TShape
            Left = 2
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 17
            ExplicitHeight = 29
          end
          object shpInvoiceIndexRR1: TShape
            Left = 10
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 27
            ExplicitHeight = 29
          end
        end
        object pnlInvoiceIndex2: TsPanel
          Tag = 2
          Left = 3
          Top = 78
          Width = 42
          Height = 31
          Alignment = taRightJustify
          BevelInner = bvLowered
          Caption = '3 '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
          OnClick = pnlInvoiceIndex0Click
          OnDragDrop = pnlInvoiceIndex0DragDrop
          OnDragOver = pnlInvoiceIndex0DragOver
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          object shpInvoiceIndex2: TShape
            Left = 2
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 17
            ExplicitHeight = 29
          end
          object shpInvoiceIndexRR2: TShape
            Left = 10
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 27
            ExplicitHeight = 29
          end
        end
        object pnlInvoiceIndex3: TsPanel
          Tag = 3
          Left = 3
          Top = 115
          Width = 42
          Height = 31
          Alignment = taRightJustify
          BevelInner = bvLowered
          Caption = '4 '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 3
          OnClick = pnlInvoiceIndex0Click
          OnDragDrop = pnlInvoiceIndex0DragDrop
          OnDragOver = pnlInvoiceIndex0DragOver
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          object shpInvoiceIndex3: TShape
            Left = 2
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 17
            ExplicitHeight = 29
          end
          object shpInvoiceIndexRR3: TShape
            Left = 10
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 27
            ExplicitHeight = 29
          end
        end
        object pnlInvoiceIndex4: TsPanel
          Tag = 4
          Left = 3
          Top = 151
          Width = 42
          Height = 31
          Alignment = taRightJustify
          BevelInner = bvLowered
          Caption = '5 '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 4
          OnClick = pnlInvoiceIndex0Click
          OnDragDrop = pnlInvoiceIndex0DragDrop
          OnDragOver = pnlInvoiceIndex0DragOver
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          object shpInvoiceIndex4: TShape
            Left = 2
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 17
            ExplicitHeight = 29
          end
          object shpInvoiceIndexRR4: TShape
            Left = 10
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 27
            ExplicitHeight = 29
          end
        end
        object pnlInvoiceIndex5: TsPanel
          Tag = 5
          Left = 3
          Top = 189
          Width = 42
          Height = 31
          Alignment = taRightJustify
          BevelInner = bvLowered
          Caption = '6 '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
          OnClick = pnlInvoiceIndex0Click
          OnDragDrop = pnlInvoiceIndex0DragDrop
          OnDragOver = pnlInvoiceIndex0DragOver
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          object shpInvoiceIndex5: TShape
            Left = 2
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 17
            ExplicitHeight = 29
          end
          object shpInvoiceIndexRR5: TShape
            Left = 10
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 27
            ExplicitHeight = 29
          end
        end
        object pnlInvoiceIndex6: TsPanel
          Tag = 6
          Left = 3
          Top = 226
          Width = 42
          Height = 31
          Alignment = taRightJustify
          BevelInner = bvLowered
          Caption = '7 '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 6
          OnClick = pnlInvoiceIndex0Click
          OnDragDrop = pnlInvoiceIndex0DragDrop
          OnDragOver = pnlInvoiceIndex0DragOver
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          object shpInvoiceIndex6: TShape
            Left = 2
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 17
            ExplicitHeight = 29
          end
          object shpInvoiceIndexRR6: TShape
            Left = 10
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 27
            ExplicitHeight = 29
          end
        end
        object pnlInvoiceIndex7: TsPanel
          Tag = 7
          Left = 3
          Top = 263
          Width = 42
          Height = 31
          Alignment = taRightJustify
          BevelInner = bvLowered
          Caption = '8 '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 7
          OnClick = pnlInvoiceIndex0Click
          OnDragDrop = pnlInvoiceIndex0DragDrop
          OnDragOver = pnlInvoiceIndex0DragOver
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          object shpInvoiceIndex7: TShape
            Left = 2
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 17
            ExplicitHeight = 29
          end
          object shpInvoiceIndexRR7: TShape
            Left = 10
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 27
            ExplicitHeight = 29
          end
        end
        object pnlInvoiceIndex8: TsPanel
          Tag = 8
          Left = 3
          Top = 300
          Width = 42
          Height = 31
          Alignment = taRightJustify
          BevelInner = bvLowered
          Caption = '9 '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 8
          OnClick = pnlInvoiceIndex0Click
          OnDragDrop = pnlInvoiceIndex0DragDrop
          OnDragOver = pnlInvoiceIndex0DragOver
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          object shpInvoiceIndex8: TShape
            Left = 2
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 0
            ExplicitHeight = 29
          end
          object shpInvoiceIndexRR8: TShape
            Left = 10
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 27
            ExplicitHeight = 29
          end
        end
        object pnlInvoiceIndex9: TsPanel
          Tag = 9
          Left = 3
          Top = 337
          Width = 42
          Height = 31
          Alignment = taRightJustify
          BevelInner = bvLowered
          Caption = '10 '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 9
          OnClick = pnlInvoiceIndex0Click
          OnDragDrop = pnlInvoiceIndex0DragDrop
          OnDragOver = pnlInvoiceIndex0DragOver
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          object shpInvoiceIndex9: TShape
            Left = 2
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 1
            ExplicitTop = 1
            ExplicitHeight = 29
          end
          object shpInvoiceIndexRR9: TShape
            Left = 10
            Top = 2
            Width = 8
            Height = 27
            Align = alLeft
            Pen.Style = psClear
            OnDragDrop = shpInvoiceIndex0DragDrop
            OnDragOver = shpInvoiceIndex0DragOver
            OnMouseUp = shpInvoiceIndex0MouseUp
            ExplicitLeft = 25
            ExplicitTop = 1
            ExplicitHeight = 29
          end
        end
      end
    end
  end
  object FriendlyStatusBar1: TsStatusBar
    Left = 0
    Top = 662
    Width = 1074
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object MainMenu1: TMainMenu
    Left = 372
    Top = 304
    object File1: TMenuItem
      Caption = '&File'
      object ExitandSave1: TMenuItem
        Action = actSaveAndExit
        ShortCut = 16465
      end
      object S1: TMenuItem
        Caption = 'Sa&ve'
        ShortCut = 16467
        OnClick = S1Click
      end
      object Exit1: TMenuItem
        Caption = 'Close'
        OnClick = Exit1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object GuestName1: TMenuItem
        Caption = 'Copy Guest name to clipboard'
        ShortCut = 16455
      end
      object Refrence1: TMenuItem
        Caption = 'Copy Refrence to clipboard'
        ShortCut = 16466
      end
    end
    object Invoice2: TMenuItem
      Caption = '&Invoice'
      object Print2: TMenuItem
        Action = actPrintInvoice
        Caption = 'Pay '#39'n Print'
      end
      object PrintProforma1: TMenuItem
        Action = actPrintProforma
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Downpayment1: TMenuItem
        Action = actDownPayment
      end
    end
    object Items1: TMenuItem
      Caption = 'Items'
      object Add1: TMenuItem
        Action = actAddLine
      end
      object Delete1: TMenuItem
        Action = actDelLine
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Removetemporarily1: TMenuItem
        Action = actItemToTemp
      end
      object RemoveRoomRenttemporarity1: TMenuItem
        Action = actRRtoTemp
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object SendItemToGroupInvoice: TMenuItem
        Action = actItemToGroupInvoice
      end
    end
  end
  object GridImages: TImageList
    Left = 933
    Top = 328
    Bitmap = {
      494C010101000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      00007B7B7B0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000000000000000000000000000FFFF000000000000000000000000007B7B
      7B0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      000000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000000000000000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B0000FF
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0000FFFF000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FF7F000000000000DE79000000000000
      AE73000000000000D6E7000000000000EE2F000000000000FC1F000000000000
      F80F00000000000080080000000000001001000000000000F01F000000000000
      F83F000000000000E477000000000000CF6B0000000000009E75000000000000
      BE7B000000000000FEFF00000000000000000000000000000000000000000000
      000000000000}
  end
  object act: TActionList
    Left = 136
    Top = 300
    object actSaveAndExit: TAction
      Category = 'File'
      Caption = 'Save and close'
      OnExecute = actSaveAndExitExecute
    end
    object actPrintInvoice: TAction
      Category = 'Invoice'
      Caption = 'To invoice'
      OnExecute = actPrintInvoiceExecute
    end
    object actPrintProforma: TAction
      Category = 'Invoice'
      Caption = 'Print proforma'
      ImageIndex = 30
      OnExecute = actPrintProformaExecute
    end
    object actInvoiceProperties: TAction
      Caption = 'Properties'
    end
    object actDownPayment: TAction
      Category = 'Invoice'
      Caption = 'Add Down payment'
      OnExecute = actDownPaymentExecute
    end
    object actInfo: TAction
      Category = 'Invoice'
      Caption = 'Reservation notes'
      OnExecute = actInfoExecute
    end
    object actAddLine: TAction
      Category = 'Lines'
      Caption = 'Add item'
      ShortCut = 113
      OnExecute = actAddLineExecute
    end
    object actDelLine: TAction
      Category = 'Lines'
      Caption = 'Remove item'
      ShortCut = 16430
      OnExecute = actDelLineExecute
    end
    object actRRtoTemp: TAction
      Category = 'Lines'
      Caption = 'Room to temp'
      ShortCut = 115
      OnExecute = actRRtoTempExecute
    end
    object actItemToTemp: TAction
      Category = 'Lines'
      Caption = 'Item to temp'
      ShortCut = 114
      OnExecute = actItemToTempExecute
    end
    object actItemToGroupInvoice: TAction
      Category = 'Lines'
      Caption = 'Item to groupinvoice'
      ShortCut = 116
      OnExecute = actItemToGroupInvoiceExecute
    end
    object actCompressLines: TAction
      Category = 'Lines'
      Caption = 'Compress items'
    end
    object actAddPackage: TAction
      Caption = 'Add Package'
    end
    object Action2: TAction
      Category = 'Lines'
      Caption = 'Action2'
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 297
    object StofnaViskiptamann1: TMenuItem
      Caption = 'Stofna Vi'#240'skiptamann'
    end
  end
  object timCloseInvoice: TTimer
    Enabled = False
    Interval = 100
    OnTimer = timCloseInvoiceTimer
    Left = 57
    Top = 405
  end
  object StoreMain: TcxPropertiesStore
    Components = <
      item
        Component = actInvoiceProperties
        Properties.Strings = (
          'AutoCheck'
          'Caption'
          'Category'
          'Checked'
          'Enabled'
          'GroupIndex'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'ImageIndex'
          'Name'
          'SecondaryShortCuts'
          'ShortCut'
          'Tag'
          'Visible')
      end
      item
        Component = chkShowPackage
        Properties.Strings = (
          'Checked')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Position'
          'Top'
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\Invoice'
    StorageType = stRegistry
    Left = 448
    Top = 312
  end
  object mRoomResDS: TDataSource
    DataSet = mRoomRes
    Left = 48
    Top = 552
  end
  object kbmRoomRatesDS: TDataSource
    DataSet = mRoomRates
    Left = 168
    Top = 552
  end
  object PaymentsDS: TDataSource
    DataSet = mPayments
    Left = 320
    Top = 568
  end
  object rptDsLines: TfrxDBDataset
    UserName = 'rptDsLines'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 296
    Top = 304
  end
  object mRoomRates: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 136
    Top = 512
    object mRoomRatesReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mRoomRatesroomreservation: TIntegerField
      FieldName = 'roomreservation'
    end
    object mRoomRatesRoomNumber: TStringField
      FieldName = 'RoomNumber'
      Size = 10
    end
    object mRoomRatesRateDate: TDateTimeField
      FieldName = 'RateDate'
    end
    object mRoomRatesPriceCode: TStringField
      FieldName = 'PriceCode'
      Size = 10
    end
    object mRoomRatesRate: TFloatField
      FieldName = 'Rate'
    end
    object mRoomRatesDiscount: TFloatField
      FieldName = 'Discount'
    end
    object mRoomRatesisPercentage: TBooleanField
      FieldName = 'isPercentage'
    end
    object mRoomRatesShowDiscount: TBooleanField
      FieldName = 'ShowDiscount'
    end
    object mRoomRatesisPaid: TBooleanField
      FieldName = 'isPaid'
    end
    object mRoomRatesDiscountAmount: TFloatField
      FieldName = 'DiscountAmount'
    end
    object mRoomRatesRentAmount: TFloatField
      FieldName = 'RentAmount'
    end
    object mRoomRatesNativeAmount: TFloatField
      FieldName = 'NativeAmount'
    end
    object mRoomRatesGuestName: TWideStringField
      FieldName = 'GuestName'
      Size = 60
    end
  end
  object mRoomRatesTmp: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 216
    Top = 512
    object IntegerField1: TIntegerField
      FieldName = 'Reservation'
    end
    object IntegerField2: TIntegerField
      FieldName = 'roomreservation'
    end
    object StringField1: TStringField
      FieldName = 'RoomNumber'
      Size = 10
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'RateDate'
    end
    object StringField2: TStringField
      FieldName = 'PriceCode'
      Size = 10
    end
    object FloatField1: TFloatField
      FieldName = 'Rate'
    end
    object FloatField2: TFloatField
      FieldName = 'Discount'
    end
    object BooleanField1: TBooleanField
      FieldName = 'isPercentage'
    end
    object BooleanField2: TBooleanField
      FieldName = 'ShowDiscount'
    end
    object BooleanField3: TBooleanField
      FieldName = 'isPaid'
    end
    object FloatField3: TFloatField
      FieldName = 'DiscountAmount'
    end
    object FloatField4: TFloatField
      FieldName = 'RentAmount'
    end
    object FloatField5: TFloatField
      FieldName = 'NativeAmount'
    end
  end
  object mRoomRes: TdxMemData
    Indexes = <
      item
        FieldName = 'Room'
        SortOptions = []
      end>
    SortOptions = []
    Left = 48
    Top = 504
    object mRoomResReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mRoomResroomreservation: TIntegerField
      FieldName = 'roomreservation'
    end
    object mRoomResRoom: TStringField
      FieldName = 'Room'
      Size = 10
    end
    object mRoomResRoomType: TStringField
      FieldName = 'RoomType'
      Size = 10
    end
    object mRoomResGuests: TIntegerField
      FieldName = 'Guests'
    end
    object mRoomResAvragePrice: TFloatField
      FieldName = 'AvragePrice'
    end
    object mRoomResRateCount: TIntegerField
      FieldName = 'RateCount'
    end
    object mRoomResRoomDescription: TStringField
      FieldName = 'RoomDescription'
      Size = 30
    end
    object mRoomResRoomTypeDescription: TStringField
      FieldName = 'RoomTypeDescription'
      Size = 30
    end
    object mRoomResArrival: TDateTimeField
      FieldName = 'Arrival'
    end
    object mRoomResDeparture: TDateTimeField
      FieldName = 'Departure'
    end
    object mRoomResChildrenCount: TIntegerField
      FieldName = 'ChildrenCount'
    end
    object mRoomResinfantCount: TIntegerField
      FieldName = 'infantCount'
    end
    object mRoomResPriceCode: TStringField
      FieldName = 'PriceCode'
      Size = 10
    end
    object mRoomResAvrageDiscount: TFloatField
      FieldName = 'AvrageDiscount'
    end
    object mRoomResisPercentage: TBooleanField
      FieldName = 'isPercentage'
    end
    object mRoomResPackage: TWideStringField
      FieldName = 'Package'
    end
    object mRoomResInvoiceIndex: TIntegerField
      FieldName = 'InvoiceIndex'
    end
    object mRoomResGroupAccount: TBooleanField
      FieldName = 'GroupAccount'
    end
    object mRoomResGuestName: TWideStringField
      FieldName = 'GuestName'
      Size = 60
    end
  end
  object mPayments: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 320
    Top = 512
    object mPaymentsPayDate: TDateField
      FieldName = 'PayDate'
    end
    object mPaymentsPayType: TWideStringField
      FieldName = 'PayType'
    end
    object mPaymentsAmount: TFloatField
      FieldName = 'Amount'
    end
    object mPaymentsDescription: TWideStringField
      FieldName = 'Description'
      Size = 60
    end
    object mPaymentsPayGroup: TWideStringField
      FieldName = 'PayGroup'
    end
    object mPaymentsMemo: TMemoField
      FieldName = 'Memo'
      BlobType = ftMemo
    end
    object mPaymentsconfirmDate: TDateTimeField
      FieldName = 'confirmDate'
    end
    object mPaymentsid: TIntegerField
      FieldName = 'id'
    end
    object mPaymentsssss: TMemoField
      FieldName = 'ssss'
      BlobType = ftMemo
    end
    object mPaymentswww: TWideStringField
      FieldName = 'www'
    end
    object mPaymentsdddd: TDateField
      FieldName = 'dddd'
    end
  end
  object mRR_: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 432
    Top = 448
    object IntegerField3: TIntegerField
      FieldName = 'Reservation'
    end
    object IntegerField4: TIntegerField
      FieldName = 'roomreservation'
    end
    object StringField3: TStringField
      FieldName = 'RoomNumber'
      Size = 10
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'RateDate'
    end
    object StringField4: TStringField
      FieldName = 'PriceCode'
      Size = 10
    end
    object FloatField6: TFloatField
      FieldName = 'Rate'
    end
    object FloatField7: TFloatField
      FieldName = 'Discount'
    end
    object BooleanField4: TBooleanField
      FieldName = 'isPercentage'
    end
    object BooleanField5: TBooleanField
      FieldName = 'ShowDiscount'
    end
    object BooleanField6: TBooleanField
      FieldName = 'isPaid'
    end
    object FloatField8: TFloatField
      FieldName = 'DiscountAmount'
    end
    object FloatField9: TFloatField
      FieldName = 'RentAmount'
    end
    object FloatField10: TFloatField
      FieldName = 'NativeAmount'
    end
  end
  object mnuMoveItem: TPopupMenu
    OnPopup = mnuMoveItemPopup
    Left = 544
    Top = 336
    object T1: TMenuItem
      Caption = 'To group invoice'
      OnClick = T1Click
    end
    object mnuMoveItemToSpecifiedRoomAndInvoiceIndex: TMenuItem
      Caption = 'To room invoice'
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object mnuMoveItemToAnyOtherRoomAndInvoiceIndex: TMenuItem
      Caption = 'Transfer'
      object TMenuItem
      end
    end
  end
  object mnuMoveRoom: TPopupMenu
    OnPopup = mnuMoveRoomPopup
    Left = 544
    Top = 392
    object mnuMoveRoomRentFromRoomInvoiceToGroup: TMenuItem
      Caption = 'To group invoice'
      OnClick = mnuMoveRoomRentFromRoomInvoiceToGroupClick
    end
    object mnuMoveRoomRentFromGroupToNormalRoomInvoice: TMenuItem
      Caption = 'To room invoice'
      OnClick = mnuMoveRoomRentFromGroupToNormalRoomInvoiceClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object mnuTransferRoomRentToDifferentRoom: TMenuItem
      Caption = 'Transfer'
      object TMenuItem
      end
    end
  end
  object mnuInvoiceIndex: TPopupMenu
    Left = 632
    Top = 352
    object I1: TMenuItem
      Tag = -1
      Caption = 'Invoice index'
      Enabled = False
    end
    object N5: TMenuItem
      Tag = -1
      Caption = '-'
      Enabled = False
    end
    object N01: TMenuItem
      Caption = '1'
      OnClick = N91Click
    end
    object N11: TMenuItem
      Tag = 1
      Caption = '2'
      OnClick = N91Click
    end
    object N31: TMenuItem
      Tag = 2
      Caption = '3'
      OnClick = N91Click
    end
    object N41: TMenuItem
      Tag = 3
      Caption = '4'
      OnClick = N91Click
    end
    object N51: TMenuItem
      Tag = 4
      Caption = '5'
      OnClick = N91Click
    end
    object N61: TMenuItem
      Tag = 5
      Caption = '6'
      OnClick = N91Click
    end
    object N71: TMenuItem
      Tag = 6
      Caption = '7'
      OnClick = N91Click
    end
    object N81: TMenuItem
      Tag = 7
      Caption = '8'
      OnClick = N91Click
    end
    object N91: TMenuItem
      Tag = 8
      Caption = '9'
      OnClick = N91Click
    end
    object N12: TMenuItem
      Tag = 9
      Caption = '10'
    end
  end
end
