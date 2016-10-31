object frmReservationProfile: TfrmReservationProfile
  Left = 739
  Top = 201
  Caption = 'Reservation profile'
  ClientHeight = 662
  ClientWidth = 1136
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
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
  object pnlTopButtons: TsPanel
    Left = 0
    Top = 0
    Width = 1136
    Height = 48
    Align = alTop
    TabOrder = 5
    SkinData.SkinSection = 'PANEL'
    object btnCheckIn: TsButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 128
      Height = 40
      Action = acCheckinRoom
      Align = alLeft
      DropDownMenu = ppmCheckin
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Images = DImages.PngImageList1
      ParentFont = False
      Style = bsSplitButton
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object btnExcel: TsButton
      AlignWithMargins = True
      Left = 272
      Top = 4
      Width = 128
      Height = 40
      Align = alLeft
      Caption = 'Excel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 115
      Images = DImages.PngImageList1
      ParentFont = False
      TabOrder = 2
      OnClick = btnExcelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCheckOut: TsButton
      AlignWithMargins = True
      Left = 138
      Top = 4
      Width = 128
      Height = 40
      Action = acCheckoutRoom
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Images = DImages.PngImageList1
      ParentFont = False
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDocuments: TsButton
      AlignWithMargins = True
      Left = 406
      Top = 4
      Width = 128
      Height = 40
      Action = acShowDocuments
      Align = alLeft
      DropDownMenu = ppmDocuments
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Images = DImages.PngImageList1
      ParentFont = False
      Style = bsSplitButton
      TabOrder = 3
      SkinData.SkinSection = 'BUTTON'
    end
    object btnHiddenMemo: TsButton
      AlignWithMargins = True
      Left = 540
      Top = 4
      Width = 128
      Height = 40
      Action = acShowHiddenMemo
      Align = alLeft
      DropDownMenu = ppmHiddenMemo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Images = DImages.PngImageList1
      ParentFont = False
      Style = bsSplitButton
      TabOrder = 4
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object Panel2: TsPanel
    Left = 0
    Top = 48
    Width = 1136
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
        Left = 33
        Top = 19
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
        Left = 20
        Top = 42
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
        AlignWithMargins = True
        Left = 5
        Top = 62
        Width = 176
        Height = 32
        Margins.Top = 5
        Align = alTop
        Caption = 'Change reservation dates'
        ImageIndex = 51
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = cxButton3Click
        SkinData.SkinSection = 'BUTTON'
      end
      object dtDeparture: TsDateEdit
        AlignWithMargins = True
        Left = 72
        Top = 38
        Width = 109
        Height = 19
        Margins.Left = 70
        Margins.Bottom = 0
        Align = alTop
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
        AlignWithMargins = True
        Left = 72
        Top = 16
        Width = 109
        Height = 19
        Margins.Left = 70
        Margins.Bottom = 0
        Align = alTop
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
      Width = 321
      Height = 102
      Margins.Left = 5
      Align = alLeft
      Padding.Left = 5
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object lblMarket: TsLabel
        Left = 68
        Top = 18
        Width = 32
        Height = 11
        Alignment = taRightJustify
        Caption = 'Market:'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cbxMarket: TsComboBox
        AlignWithMargins = True
        Left = 107
        Top = 16
        Width = 209
        Height = 19
        Margins.Left = 100
        Margins.Bottom = 0
        Align = alTop
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
      object pnlMarketSegment: TsPanel
        Left = 7
        Top = 35
        Width = 312
        Height = 27
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label8: TsLabel
          Left = 21
          Top = 7
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
          Left = 188
          Top = 6
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
        object edtType: TsEdit
          AlignWithMargins = True
          Left = 100
          Top = 3
          Width = 57
          Height = 20
          Margins.Left = 100
          Margins.Right = 80
          TabStop = False
          Color = clWhite
          Constraints.MaxWidth = 104
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 30
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnDblClick = edtTypeDblClick
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object btnGetCustomerType: TsButton
          Left = 163
          Top = 3
          Width = 19
          Height = 19
          Caption = '...'
          TabOrder = 1
          OnClick = edtTypeDblClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object sPanel3: TsPanel
        AlignWithMargins = True
        Left = 7
        Top = 62
        Width = 312
        Height = 23
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        OnResize = pnlTelephoneResize
      end
    end
    object gbxStatus: TsGroupBox
      AlignWithMargins = True
      Left = 529
      Top = 4
      Width = 305
      Height = 102
      Margins.Left = 5
      Align = alLeft
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object Label25: TsLabel
        Left = 27
        Top = 19
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
        Left = 55
        Top = 39
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
      object cbxBreakfast: TsComboBox
        AlignWithMargins = True
        Left = 102
        Top = 38
        Width = 198
        Height = 19
        Margins.Left = 100
        Margins.Bottom = 0
        Align = alTop
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
        AlignWithMargins = True
        Left = 102
        Top = 16
        Width = 198
        Height = 19
        Margins.Left = 100
        Margins.Bottom = 0
        Align = alTop
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
        OnCloseUp = cbxPaymentdetailsCloseUp
        Items.Strings = (
          'Mixed'
          'Room Account'
          'Group Account')
      end
    end
    object gbxInfo: TsGroupBox
      AlignWithMargins = True
      Left = 842
      Top = 4
      Width = 290
      Height = 102
      Margins.Left = 5
      Align = alClient
      TabOrder = 3
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object lblReservationNumber: TsLabel
        Left = 34
        Top = 19
        Width = 63
        Height = 11
        Alignment = taRightJustify
        Caption = 'Reservation nr:'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edtReservationNumber: TsEdit
        Left = 103
        Top = 15
        Width = 121
        Height = 19
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        SkinData.SkinSection = 'EDIT'
      end
    end
  end
  object PageControl2: TsPageControl
    Left = 0
    Top = 158
    Width = 1136
    Height = 216
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
        Width = 1128
        Height = 206
        Align = alClient
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object cxSplitter1: TsSplitter
          AlignWithMargins = True
          Left = 497
          Top = 4
          Width = 7
          Height = 198
          Color = clGradientActiveCaption
          ParentColor = False
          SkinData.CustomColor = True
          ExplicitTop = 6
        end
        object sSplitter3: TsSplitter
          AlignWithMargins = True
          Left = 254
          Top = 4
          Width = 7
          Height = 198
          Color = clGradientActiveCaption
          ParentColor = False
          SkinData.CustomColor = True
          ExplicitLeft = 274
          ExplicitTop = 0
        end
        object pnlContact: TsPanel
          Left = 1
          Top = 1
          Width = 250
          Height = 204
          Align = alLeft
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
          object PageControl3: TsPageControl
            Left = 1
            Top = 1
            Width = 248
            Height = 202
            ActivePage = tsContact
            Align = alClient
            TabOrder = 0
            SkinData.SkinSection = 'PAGECONTROL'
            object tsContact: TsTabSheet
              Caption = 'Contact'
              SkinData.CustomColor = False
              SkinData.CustomFont = False
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object lblContactName: TsLabel
                Left = 32
                Top = 5
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
              object lblCOntactEmail: TsLabel
                Left = 34
                Top = 137
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
              object sLabel3: TsLabel
                Left = 10
                Top = 27
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
              object sLabel6: TsLabel
                Left = 11
                Top = 71
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
                Left = 10
                Top = 92
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
              object edtContactAddress1: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 23
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Top = 2
                Margins.Bottom = 0
                Align = alTop
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
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
              object edtContactAddress2: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 45
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Top = 2
                Margins.Bottom = 0
                Align = alTop
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
              object edtContactAddress3: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 67
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Top = 2
                Margins.Bottom = 0
                Align = alTop
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
              object edtContactAddress4: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 89
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Top = 2
                Margins.Bottom = 0
                Align = alTop
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
              object edtContactEmail: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 134
                Width = 172
                Height = 19
                Margins.Left = 65
                Margins.Top = 2
                Margins.Bottom = 0
                Align = alTop
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Tahoma'
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
              object edtContactName: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 2
                Width = 172
                Height = 19
                Margins.Left = 65
                Margins.Top = 2
                Margins.Bottom = 0
                Align = alTop
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
                MaxLength = 100
                ParentFont = False
                TabOrder = 5
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object pnlTelephone: TsPanel
                AlignWithMargins = True
                Left = 0
                Top = 153
                Width = 238
                Height = 23
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 2
                Margins.Bottom = 0
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 6
                OnResize = pnlTelephoneResize
                object Label21: TsLabel
                  Left = 3
                  Top = 6
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
                object edtContactPhone: TsEdit
                  Left = 65
                  Top = 3
                  Width = 97
                  Height = 19
                  Color = clWhite
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -9
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  MaxLength = 40
                  ParentFont = False
                  TabOrder = 0
                  SkinData.SkinSection = 'EDIT'
                  BoundLabel.Font.Charset = DEFAULT_CHARSET
                  BoundLabel.Font.Color = clWindowText
                  BoundLabel.Font.Height = -13
                  BoundLabel.Font.Name = 'Tahoma'
                  BoundLabel.Font.Style = []
                end
                object edtContactPhone2: TsEdit
                  Left = 168
                  Top = 3
                  Width = 94
                  Height = 19
                  Color = clWhite
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -9
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  MaxLength = 40
                  ParentFont = False
                  TabOrder = 1
                  SkinData.SkinSection = 'EDIT'
                  BoundLabel.Font.Charset = DEFAULT_CHARSET
                  BoundLabel.Font.Color = clWindowText
                  BoundLabel.Font.Height = -13
                  BoundLabel.Font.Name = 'Tahoma'
                  BoundLabel.Font.Style = []
                end
              end
              object sPanel4: TsPanel
                AlignWithMargins = True
                Left = 0
                Top = 109
                Width = 240
                Height = 23
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 7
                OnResize = pnlTelephoneResize
                object edtContact: TsLabel
                  Left = 9
                  Top = 6
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
                object lblContactCountry: TsLabel
                  Left = 133
                  Top = 6
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
                object edtContactCountry: TsEdit
                  AlignWithMargins = True
                  Left = 65
                  Top = 3
                  Width = 35
                  Height = 20
                  Margins.Left = 65
                  Margins.Top = 2
                  Margins.Bottom = 0
                  Color = clWhite
                  Constraints.MaxWidth = 204
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -9
                  Font.Name = 'Arial'
                  Font.Style = []
                  MaxLength = 2
                  ParentFont = False
                  TabOrder = 0
                  SkinData.SkinSection = 'EDIT'
                  BoundLabel.Font.Charset = DEFAULT_CHARSET
                  BoundLabel.Font.Color = clWindowText
                  BoundLabel.Font.Height = -13
                  BoundLabel.Font.Name = 'Tahoma'
                  BoundLabel.Font.Style = []
                end
                object btnGetContactCountry: TsButton
                  Left = 106
                  Top = 3
                  Width = 19
                  Height = 19
                  Caption = '...'
                  TabOrder = 1
                  OnClick = edtContactCountryClick
                  SkinData.SkinSection = 'BUTTON'
                end
              end
            end
            object TabSheet4: TsTabSheet
              Caption = 'Customer'
              SkinData.CustomColor = False
              SkinData.CustomFont = False
              object Label19: TsLabel
                Left = 12
                Top = 32
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
                Left = 12
                Top = 53
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
                Left = 12
                Top = 76
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
              object Label4: TsLabel
                Left = 12
                Top = 145
                Width = 51
                Height = 11
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Reference:'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object edtKennitala: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 27
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Top = 2
                Margins.Bottom = 0
                Align = alTop
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
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
              object edtName: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 50
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Bottom = 0
                Align = alTop
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
              object edtAddress1: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 73
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Bottom = 0
                Align = alTop
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
              object edtAddress2: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 119
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Bottom = 0
                Align = alTop
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
              object edtAddress3: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 96
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Bottom = 0
                Align = alTop
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
              object edtInvRefrence: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 142
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Bottom = 0
                Align = alTop
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 100
                ParentFont = False
                TabOrder = 5
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object pnlCustomer: TsPanel
                AlignWithMargins = True
                Left = 0
                Top = 0
                Width = 240
                Height = 25
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 6
                DesignSize = (
                  240
                  25)
                object Label9: TsLabel
                  Left = 13
                  Top = 6
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
                object edtCustomer: TsEdit
                  AlignWithMargins = True
                  Left = 65
                  Top = 3
                  Width = 145
                  Height = 20
                  Margins.Left = 65
                  Margins.Right = 30
                  Margins.Bottom = 0
                  Align = alTop
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
                object edGetCustomer: TsButton
                  Left = 214
                  Top = 4
                  Width = 19
                  Height = 18
                  Anchors = [akTop, akRight]
                  Caption = '..'
                  TabOrder = 1
                  OnClick = edGetCustomerClick
                  SkinData.SkinSection = 'BUTTON'
                end
              end
            end
            object TabSheet5: TsTabSheet
              Caption = 'Customer Tel / Email'
              ImageIndex = 1
              SkinData.CustomColor = False
              SkinData.CustomFont = False
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object Label11: TsLabel
                Left = 45
                Top = 29
                Width = 18
                Height = 11
                Alignment = taRightJustify
                Caption = 'Fax:'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object Label14: TsLabel
                Left = 37
                Top = 52
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
              object Label15: TsLabel
                Left = 25
                Top = 71
                Width = 38
                Height = 11
                Alignment = taRightJustify
                Caption = 'Web site:'
                ParentFont = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
              end
              object edtFax: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 26
                Width = 172
                Height = 20
                Margins.Left = 65
                Margins.Bottom = 0
                Align = alTop
                Color = clWhite
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 15
                ParentFont = False
                TabOrder = 0
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
              object edtCustomerEmail: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 49
                Width = 172
                Height = 19
                Margins.Left = 65
                Margins.Bottom = 0
                Align = alTop
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Tahoma'
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
              object edtCustomerWebSite: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 71
                Width = 172
                Height = 19
                Margins.Left = 65
                Margins.Bottom = 0
                Align = alTop
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Tahoma'
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
              object pnlCustomerTelephone: TsPanel
                AlignWithMargins = True
                Left = 0
                Top = 0
                Width = 240
                Height = 23
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 3
                OnResize = pnlTelephoneResize
                object sLabel1: TsLabel
                  Left = 6
                  Top = 6
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
                object edtTel1: TsEdit
                  Left = 65
                  Top = 3
                  Width = 62
                  Height = 19
                  Color = clWhite
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -9
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  MaxLength = 40
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
                  Left = 133
                  Top = 3
                  Width = 62
                  Height = 19
                  Color = clWhite
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -9
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  MaxLength = 40
                  ParentFont = False
                  TabOrder = 1
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
        end
        object pnlMainGuests: TsPanel
          Left = 264
          Top = 1
          Width = 230
          Height = 204
          Align = alLeft
          TabOrder = 1
          object gbxGuest: TsGroupBox
            Left = 1
            Top = 1
            Width = 228
            Height = 152
            Align = alClient
            Caption = 'Main guest for room :'
            TabOrder = 0
            SkinData.SkinSection = 'GROUPBOX'
            Checked = False
            DesignSize = (
              228
              152)
            object lblGuestName: TsLabel
              Left = 35
              Top = 21
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
            object sLabel9: TsLabel
              Left = 13
              Top = 40
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
            object sLabel10: TsLabel
              Left = 14
              Top = 83
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
            object sLabel11: TsLabel
              Left = 14
              Top = 105
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
            object edtGuestName: TsEdit
              AlignWithMargins = True
              Left = 67
              Top = 15
              Width = 109
              Height = 20
              Margins.Left = 65
              Margins.Top = 2
              Margins.Right = 50
              Margins.Bottom = 0
              Align = alTop
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 100
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
            end
            object edtGuestAddress2: TsEdit
              AlignWithMargins = True
              Left = 67
              Top = 58
              Width = 156
              Height = 20
              Margins.Left = 65
              Margins.Top = 2
              Margins.Bottom = 0
              Align = alTop
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 100
              ParentFont = False
              ReadOnly = True
              TabOrder = 4
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
            end
            object edtGuestAddress3: TsEdit
              AlignWithMargins = True
              Left = 67
              Top = 80
              Width = 156
              Height = 20
              Margins.Left = 65
              Margins.Top = 2
              Margins.Bottom = 0
              Align = alTop
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 100
              ParentFont = False
              ReadOnly = True
              TabOrder = 5
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
            end
            object edtGuestAddress4: TsEdit
              AlignWithMargins = True
              Left = 67
              Top = 102
              Width = 156
              Height = 20
              Margins.Left = 65
              Margins.Top = 2
              Margins.Bottom = 0
              Align = alTop
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = []
              MaxLength = 2
              ParentFont = False
              ReadOnly = True
              TabOrder = 6
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
            end
            object edtGuestAddress1: TsEdit
              AlignWithMargins = True
              Left = 67
              Top = 37
              Width = 156
              Height = 19
              Margins.Left = 65
              Margins.Top = 2
              Margins.Bottom = 0
              Align = alTop
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Tahoma'
              Font.Style = []
              MaxLength = 100
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
            end
            object sPanel2: TsPanel
              AlignWithMargins = True
              Left = 2
              Top = 122
              Width = 224
              Height = 23
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 7
              OnResize = pnlTelephoneResize
              object sLabel8: TsLabel
                Left = 10
                Top = 6
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
              object lblGuestCountry: TsLabel
                Left = 109
                Top = 7
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
              object edtGuestCountry: TsEdit
                AlignWithMargins = True
                Left = 65
                Top = 3
                Width = 35
                Height = 20
                Margins.Left = 58
                Margins.Top = 2
                Margins.Bottom = 0
                Color = clWhite
                Constraints.MaxWidth = 140
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Style = []
                MaxLength = 100
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
                OnChange = edtGuestCountryChange
                SkinData.SkinSection = 'EDIT'
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
              end
            end
            object btnMainGuestSelectProfile: TsButton
              Left = 178
              Top = 13
              Width = 23
              Height = 23
              Hint = 'Select a guest profile'
              Anchors = [akTop, akRight]
              ImageAlignment = iaCenter
              ImageIndex = 31
              Images = DImages.PngImageList1
              TabOrder = 1
              OnClick = btnMainGuestSelectProfileClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnMainGuestEditProfile: TsButton
              Left = 202
              Top = 13
              Width = 23
              Height = 23
              Hint = 'Edit guest profile'
              Anchors = [akTop, akRight]
              ImageAlignment = iaCenter
              ImageIndex = 25
              Images = DImages.PngImageList1
              TabOrder = 2
              OnClick = btnMainGuestEditProfileClick
              SkinData.SkinSection = 'BUTTON'
            end
          end
          object gbxAllGuestsNationality: TsGroupBox
            Left = 1
            Top = 153
            Width = 228
            Height = 50
            Align = alBottom
            TabOrder = 1
            Checked = False
            object btnChangeNationality: TsButton
              Left = 67
              Top = 15
              Width = 150
              Height = 25
              Hint = 'Change nationality of all guests'
              Caption = 'Change all nationalities'
              TabOrder = 0
              OnClick = btnChangeNationalityClick
            end
          end
        end
        object memPanel: TsPanel
          Left = 507
          Top = 1
          Width = 620
          Height = 204
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          BorderWidth = 5
          ParentBackground = False
          TabOrder = 2
          SkinData.SkinSection = 'PANEL'
          object sSplitter2: TsSplitter
            AlignWithMargins = True
            Left = 219
            Top = 9
            Width = 7
            Height = 186
            Color = clGradientActiveCaption
            ParentColor = False
            SkinData.CustomColor = True
            SkinData.SkinSection = 'SPLITTER'
            ExplicitLeft = 199
            ExplicitTop = 3
            ExplicitHeight = 156
          end
          object sSplitter1: TsSplitter
            AlignWithMargins = True
            Left = 415
            Top = 9
            Width = 7
            Height = 186
            Color = clGradientActiveCaption
            ParentColor = False
            SkinData.CustomColor = True
            SkinData.SkinSection = 'SPLITTER'
            ExplicitLeft = 430
            ExplicitTop = 32
            ExplicitHeight = 113
          end
          object GroupBox1: TsGroupBox
            Left = 6
            Top = 6
            Width = 210
            Height = 192
            Align = alLeft
            Caption = 'General Information'
            TabOrder = 0
            SkinData.SkinSection = 'GROUPBOX'
            Checked = False
            object memInformation: TsMemo
              Left = 2
              Top = 13
              Width = 206
              Height = 177
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
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
            Left = 229
            Top = 6
            Width = 183
            Height = 192
            Align = alLeft
            Caption = 'Payment Information'
            TabOrder = 1
            SkinData.SkinSection = 'GROUPBOX'
            Checked = False
            object memPMInfo: TsMemo
              Left = 2
              Top = 13
              Width = 179
              Height = 177
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
              SkinData.SkinSection = 'EDIT'
            end
          end
          object pnlRoomInformation: TsPanel
            Left = 425
            Top = 6
            Width = 189
            Height = 192
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 2
            object gbxRoomInformation: TsGroupBox
              Left = 0
              Top = 0
              Width = 189
              Height = 72
              Align = alTop
              Caption = 'Notes for room : '
              TabOrder = 0
              SkinData.SkinSection = 'GROUPBOX'
              Checked = False
              object memRoomNotes: TsMemo
                Left = 2
                Top = 13
                Width = 185
                Height = 52
                Align = alTop
                BevelInner = bvNone
                BevelOuter = bvNone
                BorderStyle = bsNone
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ScrollBars = ssVertical
                TabOrder = 0
                OnExit = memRoomNotesExit
                SkinData.SkinSection = 'EDIT'
              end
            end
            object gbChannelInformation: TsGroupBox
              Left = 0
              Top = 72
              Width = 189
              Height = 120
              Align = alClient
              Caption = 'Requests from booking channel :'
              TabOrder = 1
              SkinData.SkinSection = 'GROUPBOX'
              Checked = False
              object memRequestFromChannel: TsMemo
                Left = 2
                Top = 13
                Width = 185
                Height = 105
                Align = alClient
                BevelInner = bvNone
                BevelOuter = bvNone
                BorderStyle = bsNone
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -9
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                ScrollBars = ssVertical
                TabOrder = 0
                SkinData.SkinSection = 'EDIT'
              end
            end
          end
        end
      end
    end
  end
  object mainPage: TsPageControl
    Left = 0
    Top = 374
    Width = 1136
    Height = 255
    ActivePage = RoomsTab
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabHeight = 27
    TabOrder = 2
    TabWidth = 150
    OnChange = mainPageChange
    ActiveTabEnlarged = False
    ActiveIsBold = True
    ShowFocus = False
    SkinData.SkinSection = 'PAGECONTROL'
    object RoomsTab: TsTabSheet
      Caption = 'Rooms'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object grRooms: TcxGrid
        Left = 0
        Top = 86
        Width = 1128
        Height = 132
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        Images = DImages.cxSmallImagesFlat
        ParentFont = False
        PopupMenu = mnuGrid
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
          OptionsBehavior.CellHints = True
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
            OnGetDisplayText = FormatTextToShortFormat
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
            DataBinding.FieldName = 'Status'
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
            Properties.OnDrawItem = tvRoomsStatusTextPropertiesDrawItem
            Width = 97
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
            OnGetProperties = tvGetCurrencyProperties
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
            Options.ShowEditButtons = isebAlways
            Width = 24
          end
          object tvRoomsRateOrPackagePerDay: TcxGridDBColumn
            Caption = 'Nightly rate'
            DataBinding.FieldName = 'RateOrPackagePerDay'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvGetCurrencyProperties
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
          object tvRoomsbreakfastText: TcxGridDBColumn
            Caption = 'Breakfast'
            DataBinding.FieldName = 'breakfast'
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
            OnGetProperties = tvGetCurrencyProperties
            Options.Editing = False
            Width = 56
          end
          object tvRoomsaccountTypeText: TcxGridDBColumn
            Caption = 'Account'
            DataBinding.FieldName = 'isGroupAccount'
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
            OnGetDisplayText = tvRoomsblockMoveReasonGetDisplayText
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
        Width = 1128
        Height = 48
        Align = alTop
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object btnShowPrices: TsButton
          AlignWithMargins = True
          Left = 746
          Top = 4
          Width = 100
          Height = 40
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
          Height = 40
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
          Height = 40
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
          Height = 40
          Align = alLeft
          Caption = 'Remove Room'
          ImageIndex = 43
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
          Height = 40
          Align = alLeft
          Caption = 'Provide room'
          ImageIndex = 47
          Images = DImages.PngImageList1
          TabOrder = 4
          OnClick = btnProvideRoomClick
          SkinData.SkinSection = 'BUTTON'
        end
        object cxButton5: TsButton
          AlignWithMargins = True
          Left = 534
          Top = 4
          Width = 100
          Height = 40
          Align = alLeft
          Caption = 'Room'#13#10' Documents'
          ImageIndex = 21
          Images = DImages.PngImageList1
          TabOrder = 5
          OnClick = cxButton5Click
          SkinData.SkinSection = 'BUTTON'
        end
        object cxButton6: TsButton
          AlignWithMargins = True
          Left = 428
          Top = 4
          Width = 100
          Height = 40
          Align = alLeft
          Caption = 'Jump'
          ImageIndex = 57
          Images = DImages.PngImageList1
          TabOrder = 6
          OnClick = cxButton6Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnRoomsRefresh: TsButton
          AlignWithMargins = True
          Left = 955
          Top = 4
          Width = 100
          Height = 40
          Align = alLeft
          Caption = 'Refresh'
          ImageIndex = 28
          Images = DImages.PngImageList1
          TabOrder = 7
          OnClick = btnRoomsRefreshClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton5: TsButton
          AlignWithMargins = True
          Left = 216
          Top = 4
          Width = 100
          Height = 40
          Align = alLeft
          Caption = 'Guest details'
          ImageIndex = 44
          Images = DImages.PngImageList1
          TabOrder = 8
          OnClick = sButton5Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnGroups: TsButton
          AlignWithMargins = True
          Left = 852
          Top = 4
          Width = 97
          Height = 40
          Align = alLeft
          Caption = 'Group guest names'
          TabOrder = 9
          OnClick = btnGroupsClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object sPanel1: TsPanel
        Left = 0
        Top = 0
        Width = 1128
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
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel10: TsPanel
        Left = 0
        Top = 0
        Width = 1128
        Height = 38
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          1128
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
          Left = 921
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
          Left = 1023
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
          Width = 94
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
        Width = 1128
        Height = 180
        Align = alClient
        TabOrder = 1
        object grGuests: TcxGrid
          Left = 1
          Top = 1
          Width = 862
          Height = 178
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
              DataBinding.FieldName = 'Status'
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
          Left = 868
          Top = 3
          Width = 254
          Height = 174
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
            Top = 15
            Width = 81
            Height = 13
            Align = alTop
            Caption = 'Special Requests'
          end
          object lblNotes: TsLabel
            Left = 2
            Top = 101
            Width = 28
            Height = 13
            Align = alTop
            Caption = 'Notes'
          end
          object edtSpecialRequests: TMemo
            AlignWithMargins = True
            Left = 7
            Top = 33
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
            Top = 119
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
            Top = 190
            Width = 250
            Height = 105
            Align = alTop
            TabOrder = 2
            Checked = False
            object lblRoomType: TsLabel
              Left = 7
              Top = 43
              Width = 52
              Height = 13
              Caption = 'Room type'
            end
            object lblRoom: TsLabel
              Left = 7
              Top = 18
              Width = 27
              Height = 13
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
      Caption = 'Alerts'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlAlertHolder: TsPanel
        Left = 0
        Top = 0
        Width = 1128
        Height = 218
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        SkinData.SkinSection = 'TRANSPARENT'
      end
    end
    object InvoicesTab: TsTabSheet
      Caption = 'Afgehandelde facturen'
      ImageIndex = 2
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel11: TsPanel
        Left = 0
        Top = 0
        Width = 1128
        Height = 38
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          1128
          38)
        object cxButton1: TsButton
          Left = 1019
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
        Width = 1128
        Height = 180
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
    Left = 833
    Top = 209
    Width = 263
    Height = 90
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    object sLabel2: TsLabel
      Left = 63
      Top = 30
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
    Width = 1136
    Height = 33
    Align = alBottom
    TabOrder = 4
    SkinData.SkinSection = 'PANEL'
    object sButton2: TsButton
      AlignWithMargins = True
      Left = 1049
      Top = 4
      Width = 83
      Height = 25
      Hint = 'Confirm close'
      Align = alRight
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object mRooms: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforePost = mRoomsBeforePost
    AfterPost = mRoomsAfterPost
    AfterScroll = mRoomsAfterScroll
    OnCalcFields = mRoomsCalcFields
    Left = 360
    Top = 424
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
    object mRoomsStatus: TWideStringField
      FieldName = 'Status'
      OnGetText = mRoomsStatusGetText
      Size = 5
    end
    object mRoomsCurrency: TWideStringField
      FieldName = 'Currency'
      Size = 5
    end
    object mRoomsisGroupAccount: TBooleanField
      FieldName = 'isGroupAccount'
      OnGetText = mRoomsisGroupAccountGetText
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
      FieldKind = fkCalculated
      FieldName = 'dayCount'
      Calculated = True
    end
    object mRoomsBreakFast: TBooleanField
      FieldName = 'BreakFast'
      OnGetText = mRoomsBreakFastGetText
    end
    object mRoomsGuestCount: TIntegerField
      FieldName = 'GuestCount'
    end
    object mRoomsdefGuestCount: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'defGuestCount'
      Calculated = True
    end
    object mRoomsPersonsProfilesId: TIntegerField
      FieldName = 'PersonsProfilesId'
    end
    object mRoomsGuestName: TWideStringField
      DisplayLabel = 'Guestname'
      FieldName = 'guestname'
      Size = 50
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
      FieldKind = fkCalculated
      FieldName = 'unpaidRentPrice'
      Calculated = True
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
    Left = 40
    Top = 544
  end
  object mnuFinishedInv: TPopupMenu
    Left = 680
    Top = 568
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
    Left = 112
    Top = 536
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
    Top = 544
  end
  object mGuestRooms: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterScroll = mGuestRoomsAfterScroll
    Left = 56
    Top = 424
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
      OnGetText = mRoomsStatusGetText
      Size = 5
    end
    object mGuestRoomsPersonsProfilesId: TIntegerField
      FieldName = 'PersonsProfilesId'
    end
  end
  object mRoomsDS: TDataSource
    DataSet = mRooms
    Left = 320
    Top = 544
  end
  object mAllGuests: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterScroll = mAllGuestsAfterScroll
    Left = 208
    Top = 536
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
      OnGetText = mRoomsStatusGetText
      Size = 5
    end
    object mAllGuestsPersonsProfilesId: TIntegerField
      FieldName = 'PersonsProfilesId'
    end
    object mAllGuestsMainName: TBooleanField
      FieldName = 'MainName'
    end
  end
  object mAllGuestsDS: TDataSource
    DataSet = mAllGuests
    Left = 256
    Top = 536
  end
  object mInvoiceLines: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 744
    Top = 544
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
    Left = 616
    Top = 512
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
    Left = 528
    Top = 552
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
      end
      item
        Component = gbxGuest
        Properties.Strings = (
          'Width')
      end
      item
        Component = GroupBox1
        Properties.Strings = (
          'Width')
      end
      item
        Component = GroupBox2
        Properties.Strings = (
          'Width')
      end
      item
        Component = pnlContact
        Properties.Strings = (
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\ReservationProfile2'
    StorageType = stRegistry
    Left = 880
    Top = 112
  end
  object timStart: TTimer
    Enabled = False
    Interval = 100
    OnTimer = timStartTimer
    Left = 944
    Top = 112
  end
  object timBlink: TTimer
    Enabled = False
    Interval = 500
    OnTimer = timBlinkTimer
    Left = 1000
    Top = 112
  end
  object DropComboTarget1: TDropComboTarget
    DragTypes = [dtCopy, dtLink]
    OnDragOver = DropComboTarget1DragOver
    OnDrop = DropComboTarget1Drop
    OnGetDropEffect = DropComboTarget1GetDropEffect
    Target = Owner
    Left = 1052
    Top = 112
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
  object ppmCheckin: TPopupMenu
    Left = 720
    Top = 16
    object mnuCheckinReservation: TMenuItem
      Action = acCheckinReservation
    end
    object mnuCheckinRoom: TMenuItem
      Action = acCheckinRoom
      Default = True
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuChangeRoomStateTo: TMenuItem
      Caption = 'Change State for room'
    end
    object mnuChangeResStateTo: TMenuItem
      Caption = 'Change Reservation State'
    end
  end
  object alReservation: TActionList
    Left = 1000
    Top = 8
    object acCheckinReservation: TAction
      Category = 'checkin'
      Caption = 'Checkin Reservation'
      ImageIndex = 44
      OnExecute = acCheckinReservationExecute
    end
    object acCheckinRoom: TAction
      Category = 'checkin'
      Caption = 'Checkin room'
      ImageIndex = 44
      OnExecute = acCheckinRoomExecute
    end
    object acCheckoutReservation: TAction
      Category = 'checkout'
      Caption = 'Checkout Reservation'
      ImageIndex = 46
      Visible = False
      OnExecute = acCheckoutReservationExecute
    end
    object acCheckoutRoom: TAction
      Category = 'checkout'
      Caption = 'Checkout room'
      ImageIndex = 46
      OnExecute = acCheckoutRoomExecute
    end
    object acShowDocuments: TAction
      Category = 'documents'
      Caption = 'Documents'
      OnExecute = acShowDocumentsExecute
    end
    object acPasteIntoDocuments: TAction
      Category = 'documents'
      Caption = 'Paste into Documents'
      OnExecute = acPasteIntoDocumentsExecute
    end
    object acShowHiddenMemo: TAction
      Category = 'hiddenmemo'
      Caption = 'Hidden memo'
      OnExecute = acShowHiddenMemoExecute
    end
    object acPasteIntoHiddenMemo: TAction
      Category = 'hiddenmemo'
      Caption = 'Clipboard to hidden memo'
      OnExecute = acPasteIntoHiddenMemoExecute
    end
  end
  object ppmDocuments: TPopupMenu
    Left = 456
    Top = 24
    object ppmShowdocuments: TMenuItem
      Action = acShowDocuments
      Default = True
    end
    object ppmPasteIntoDocuments: TMenuItem
      Action = acPasteIntoDocuments
    end
  end
  object ppmHiddenMemo: TPopupMenu
    Left = 584
    Top = 32
    object ShowHiddenMemo1: TMenuItem
      Action = acShowHiddenMemo
      Default = True
    end
    object Clipboardtohiddenmemo1: TMenuItem
      Action = acPasteIntoHiddenMemo
    end
  end
  object mnuGrid: TPopupMenu
    Left = 864
    Top = 536
    object R1: TMenuItem
      Caption = 'Remove Room'
      OnClick = btnRemoveRoomClick
    end
    object G1: TMenuItem
      Caption = 'Guest details'
      OnClick = sButton5Click
    end
    object P1: TMenuItem
      Caption = 'Provide room number'
      OnClick = btnProvideRoomClick
    end
    object J1: TMenuItem
      Caption = 'Jump'
      OnClick = cxButton6Click
    end
    object R2: TMenuItem
      Caption = 'Room documents'
      OnClick = cxButton5Click
    end
    object I1: TMenuItem
      Caption = 'Prices'
      OnClick = btnShowPricesClick
    end
    object G2: TMenuItem
      Caption = 'Group - guest names'
      OnClick = btnGroupsClick
    end
    object R4: TMenuItem
      Caption = 'Re-activate room charges'
      OnClick = R4Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object R3: TMenuItem
      Caption = 'Refresh'
      OnClick = btnRoomsRefreshClick
    end
  end
end
