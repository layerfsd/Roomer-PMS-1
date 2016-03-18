object frmCustomerEdit2: TfrmCustomerEdit2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Modify Customer'
  ClientHeight = 685
  ClientWidth = 472
  Color = 2434341
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object panBtn: TsPanel
    Left = 0
    Top = 652
    Width = 472
    Height = 33
    Align = alBottom
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = 626
    DesignSize = (
      472
      33)
    object btnCancel: TsButton
      Left = 384
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
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 293
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
  object pgMain: TsPageControl
    Left = 0
    Top = 0
    Width = 472
    Height = 652
    ActivePage = SheetMain
    Align = alClient
    TabOrder = 1
    OnChange = pgMainChange
    SkinData.SkinSection = 'PAGECONTROL'
    ExplicitHeight = 626
    object SheetMain: TsTabSheet
      Caption = 'Customer'
      ExplicitHeight = 598
      object gbxAddress: TsGroupBox
        Left = 0
        Top = 291
        Width = 464
        Height = 132
        Align = alTop
        Caption = 'Address'
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        ExplicitTop = 254
        DesignSize = (
          464
          132)
        object sLabel4: TsLabel
          Left = 95
          Top = 75
          Width = 62
          Height = 13
          Alignment = taRightJustify
          Caption = 'Postal code :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel5: TsLabel
          Left = 131
          Top = 102
          Width = 26
          Height = 13
          Alignment = taRightJustify
          Caption = 'City :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edAddress1: TsEdit
          AlignWithMargins = True
          Left = 163
          Top = 18
          Width = 290
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          SkinData.SkinSection = 'EDIT'
        end
        object edAddress2: TsEdit
          AlignWithMargins = True
          Left = 163
          Top = 45
          Width = 290
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          SkinData.SkinSection = 'EDIT'
        end
        object edAddress3: TsEdit
          AlignWithMargins = True
          Left = 163
          Top = 72
          Width = 290
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          SkinData.SkinSection = 'EDIT'
        end
        object edAddress4: TsEdit
          AlignWithMargins = True
          Left = 163
          Top = 99
          Width = 290
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          SkinData.SkinSection = 'EDIT'
        end
      end
      object cbxName: TsGroupBox
        Left = 0
        Top = 37
        Width = 464
        Height = 101
        Align = alTop
        Caption = 'Name'
        TabOrder = 1
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        ExplicitTop = 17
        DesignSize = (
          464
          101)
        object sLabel1: TsLabel
          Left = 104
          Top = 18
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'Customer :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel2: TsLabel
          Left = 123
          Top = 72
          Width = 34
          Height = 13
          Alignment = taRightJustify
          Caption = 'Name :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel3: TsLabel
          Left = 96
          Top = 44
          Width = 61
          Height = 13
          Alignment = taRightJustify
          Caption = 'Personal Id :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sSpeedButton1: TsSpeedButton
          Left = 280
          Top = 15
          Width = 40
          Height = 21
          Caption = 'Next'
          OnClick = sSpeedButton1Click
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object sSpeedButton2: TsSpeedButton
          Left = 280
          Top = 42
          Width = 22
          Height = 21
          Caption = '...'
          OnClick = sSpeedButton2Click
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object edCustomer: TsEdit
          Left = 163
          Top = 15
          Width = 113
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = edCustomerChange
          OnExit = edCustomerExit
          SkinData.SkinSection = 'EDIT'
        end
        object edSurName: TsEdit
          AlignWithMargins = True
          Left = 163
          Top = 69
          Width = 292
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          SkinData.SkinSection = 'EDIT'
        end
        object chkActive: TsCheckBox
          Left = 329
          Top = 16
          Width = 58
          Height = 17
          Caption = 'Active'
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object edPID: TsEdit
          Left = 163
          Top = 42
          Width = 113
          Height = 21
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnDblClick = edPIDDblClick
          OnExit = edCustomerExit
          SkinData.SkinSection = 'EDIT'
        end
        object chkTravelAgency: TsCheckBox
          Left = 329
          Top = 42
          Width = 97
          Height = 17
          Caption = 'Travel Agency'
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object LMDGroupBox5: TsGroupBox
        Left = 0
        Top = 138
        Width = 464
        Height = 153
        Align = alTop
        Caption = 'Contact Information'
        TabOrder = 2
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        ExplicitTop = 101
        DesignSize = (
          464
          153)
        object gbxContact: TsLabel
          Left = 120
          Top = 18
          Width = 37
          Height = 13
          Alignment = taRightJustify
          Caption = 'Phone :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object LMDSimpleLabel10: TsLabel
          Left = 284
          Top = 18
          Width = 47
          Height = 14
          AutoSize = False
          Caption = 'Phone : '
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object LMDSimpleLabel11: TsLabel
          Left = 132
          Top = 45
          Width = 25
          Height = 13
          Alignment = taRightJustify
          Caption = 'Fax :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object LMDSimpleLabel14: TsLabel
          Left = 122
          Top = 72
          Width = 35
          Height = 13
          Alignment = taRightJustify
          Caption = 'E-mail :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object LMDSimpleLabel13: TsLabel
          Left = 112
          Top = 126
          Width = 45
          Height = 13
          Alignment = taRightJustify
          Caption = 'Contact :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object LMDSimpleLabel19: TsLabel
          Left = 99
          Top = 99
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Homepage :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edFax: TsEdit
          Left = 163
          Top = 42
          Width = 101
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
        end
        object edTel2: TsEdit
          AlignWithMargins = True
          Left = 328
          Top = 15
          Width = 127
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          SkinData.SkinSection = 'EDIT'
        end
        object edTel1: TsEdit
          Left = 163
          Top = 15
          Width = 113
          Height = 21
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          SkinData.SkinSection = 'EDIT'
        end
        object edEmailAddress: TsEdit
          AlignWithMargins = True
          Left = 163
          Top = 70
          Width = 278
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          SkinData.SkinSection = 'EDIT'
        end
        object edContactPerson: TsEdit
          AlignWithMargins = True
          Left = 163
          Top = 123
          Width = 278
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          SkinData.SkinSection = 'EDIT'
        end
        object edHomepage: TsEdit
          AlignWithMargins = True
          Left = 163
          Top = 96
          Width = 278
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          SkinData.SkinSection = 'EDIT'
        end
      end
      object gbxGuest: TsGroupBox
        Left = 0
        Top = 423
        Width = 464
        Height = 201
        Align = alClient
        Caption = 'Default values for this customer'
        TabOrder = 3
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        ExplicitTop = 386
        ExplicitHeight = 212
        object clabMarkedSegment: TsLabel
          Left = 73
          Top = 22
          Width = 84
          Height = 13
          Alignment = taRightJustify
          Caption = 'Market segment :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labCustomerType: TsLabel
          Left = 307
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
        object LMDSimpleLabel7: TsLabel
          Left = 111
          Top = 49
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = 'Country :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labCountry: TsLabel
          Left = 307
          Top = 49
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
        object LMDSimpleLabel8: TsLabel
          Left = 63
          Top = 76
          Width = 94
          Height = 13
          Alignment = taRightJustify
          Caption = 'Payment currency :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object LMDSimpleLabel5: TsLabel
          Left = 101
          Top = 130
          Width = 56
          Height = 13
          Alignment = taRightJustify
          Caption = 'Rate code :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object LMDSimpleLabel12: TsLabel
          Left = 95
          Top = 157
          Width = 62
          Height = 13
          Alignment = taRightJustify
          Caption = 'Discount % :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labCurrency: TsLabel
          Left = 307
          Top = 76
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
        object labPcCode: TsLabel
          Left = 307
          Top = 130
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
        object btnGetCustomerType: TsSpeedButton
          Left = 282
          Top = 19
          Width = 20
          Height = 21
          Caption = '..'
          OnClick = btnGetCustomerTypeClick
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object btnGetCountry: TsSpeedButton
          Left = 282
          Top = 46
          Width = 20
          Height = 21
          Caption = '..'
          OnClick = btnGetCountryClick
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object btnCetCurrency: TsSpeedButton
          Left = 282
          Top = 73
          Width = 20
          Height = 21
          Caption = '..'
          OnClick = btnCetCurrencyClick
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object btnGetPCCode: TsSpeedButton
          Left = 282
          Top = 127
          Width = 20
          Height = 21
          Caption = '..'
          OnClick = btnGetPCCodeClick
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object lblRatePlan: TsLabel
          Left = 104
          Top = 103
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'Rate Plan :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object btnRatePlan: TsSpeedButton
          Left = 283
          Top = 100
          Width = 20
          Height = 21
          Caption = '..'
          OnClick = btnRatePlanClick
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object lblSelRatePlan: TsLabel
          Left = 307
          Top = 103
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
        object edCustomerType: TsEdit
          Left = 163
          Top = 19
          Width = 115
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          SkinData.SkinSection = 'EDIT'
        end
        object edCountry: TsEdit
          Left = 163
          Top = 46
          Width = 115
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          SkinData.SkinSection = 'EDIT'
        end
        object edCurrency: TsEdit
          Left = 163
          Top = 73
          Width = 115
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          SkinData.SkinSection = 'EDIT'
        end
        object edPcCode: TsEdit
          Left = 163
          Top = 127
          Width = 115
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          SkinData.SkinSection = 'EDIT'
        end
        object edDiscountPercent: TsCalcEdit
          Left = 163
          Top = 154
          Width = 141
          Height = 21
          AutoSize = False
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object chkStayTaxIncluted: TsCheckBox
          Left = 161
          Top = 180
          Width = 106
          Height = 17
          Caption = 'Staytax incluted'
          TabOrder = 5
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object edtRatePlan: TsEdit
          Left = 163
          Top = 100
          Width = 115
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          SkinData.SkinSection = 'EDIT'
        end
      end
      object pnlDocs: TsPanel
        Left = 0
        Top = 0
        Width = 464
        Height = 37
        Align = alTop
        TabOrder = 4
        object btnDocuments: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 253
          Height = 29
          Align = alLeft
          Caption = 'Manage customer Documents'
          Enabled = False
          TabOrder = 0
          OnClick = btnDocumentsClick
        end
        object btnPasteFile: TsButton
          AlignWithMargins = True
          Left = 263
          Top = 4
          Width = 197
          Height = 29
          Align = alRight
          Caption = 'Paste files into documents'
          TabOrder = 1
          OnClick = btnPasteFileClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
    object SheetExtra: TsTabSheet
      Caption = 'More'
      ExplicitHeight = 598
      object sGroupBox1: TsGroupBox
        Left = 0
        Top = 0
        Width = 464
        Height = 249
        Align = alTop
        Caption = 'Notes'
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object memNotes: TsMemo
          Left = 2
          Top = 15
          Width = 460
          Height = 232
          Align = alClient
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Lines.Strings = (
            '')
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          Text = #13#10
          SkinData.SkinSection = 'EDIT'
          ExplicitHeight = 138
        end
      end
    end
    object tabDepartments: TsTabSheet
      Caption = 'Departments'
      ExplicitHeight = 598
      object sSplitter1: TsSplitter
        Left = 185
        Top = 0
        Height = 624
        SkinData.SkinSection = 'SPLITTER'
        ExplicitLeft = 248
        ExplicitTop = 376
        ExplicitHeight = 100
      end
      object pnlDepartments: TsPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 624
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        ExplicitHeight = 598
        object lvDepartments: TsListView
          AlignWithMargins = True
          Left = 3
          Top = 51
          Width = 179
          Height = 570
          SkinData.SkinSection = 'EDIT'
          Align = alClient
          Color = clWhite
          Columns = <
            item
              Caption = 'Departments'
              Width = 170
            end>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          SmallImages = DImages.PngImageList1
          TabOrder = 0
          ViewStyle = vsReport
          OnDblClick = lvDepartmentsDblClick
          OnSelectItem = lvDepartmentsSelectItem
          ExplicitHeight = 544
        end
        object sPanel3: TsPanel
          Left = 0
          Top = 0
          Width = 185
          Height = 48
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
          object sLabel6: TsLabel
            Left = 0
            Top = 35
            Width = 185
            Height = 13
            Align = alBottom
            Caption = 'Departments'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ExplicitWidth = 75
          end
          object btnAddDepartment: TsButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 30
            Height = 29
            Hint = 'Add new record'
            Align = alLeft
            DropDownMenu = PopupMenu1
            ImageIndex = 23
            Images = DImages.PngImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = btnAddDepartmentClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnEditDepartment: TsButton
            AlignWithMargins = True
            Left = 39
            Top = 3
            Width = 30
            Height = 29
            Hint = 'Edit current record'
            Align = alLeft
            Enabled = False
            ImageIndex = 25
            Images = DImages.PngImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btnEditDepartmentClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnDeleteDepartment: TsButton
            AlignWithMargins = True
            Left = 75
            Top = 3
            Width = 30
            Height = 29
            Align = alLeft
            Enabled = False
            ImageIndex = 24
            Images = DImages.PngImageList1
            TabOrder = 2
            OnClick = btnDeleteDepartmentClick
            SkinData.SkinSection = 'BUTTON'
          end
        end
      end
      object pnlContacts: TsPanel
        Left = 191
        Top = 0
        Width = 273
        Height = 624
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        ExplicitHeight = 598
        object lvContacts: TsListView
          AlignWithMargins = True
          Left = 3
          Top = 51
          Width = 267
          Height = 570
          SkinData.SkinSection = 'EDIT'
          Align = alClient
          Color = clWhite
          Columns = <
            item
              Caption = 'Title'
            end
            item
              Caption = 'Firstname'
              Width = 100
            end
            item
              Caption = 'Lastname'
              Width = 200
            end>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          SmallImages = DImages.PngImageList1
          TabOrder = 0
          ViewStyle = vsReport
          OnDblClick = lvContactsDblClick
          OnSelectItem = lvContactsSelectItem
          ExplicitHeight = 544
        end
        object sPanel4: TsPanel
          Left = 0
          Top = 0
          Width = 273
          Height = 48
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
          object sLabel7: TsLabel
            Left = 0
            Top = 35
            Width = 273
            Height = 13
            Align = alBottom
            Caption = 'Contacts'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ExplicitWidth = 50
          end
          object btnAddContact: TsButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 30
            Height = 29
            Hint = 'Add new record'
            Align = alLeft
            DropDownMenu = PopupMenu1
            Enabled = False
            ImageIndex = 23
            Images = DImages.PngImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = btnAddContactClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnEditContact: TsButton
            AlignWithMargins = True
            Left = 39
            Top = 3
            Width = 30
            Height = 29
            Hint = 'Edit current record'
            Align = alLeft
            Enabled = False
            ImageIndex = 25
            Images = DImages.PngImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btnEditContactClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnDeleteContact: TsButton
            AlignWithMargins = True
            Left = 75
            Top = 3
            Width = 30
            Height = 29
            Align = alLeft
            Enabled = False
            ImageIndex = 24
            Images = DImages.PngImageList1
            TabOrder = 2
            OnClick = btnDeleteContactClick
            SkinData.SkinSection = 'BUTTON'
          end
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 392
    Top = 424
    object D1: TMenuItem
      Caption = 'Department'
      Default = True
      OnClick = D1Click
    end
    object C1: TMenuItem
      Caption = 'Contact'
    end
  end
  object DropComboTarget1: TDropComboTarget
    DragTypes = [dtCopy, dtLink]
    OnDrop = DropComboTarget1Drop
    Target = Owner
    Left = 388
    Top = 488
  end
  object timBlink: TTimer
    Enabled = False
    Interval = 500
    OnTimer = timBlinkTimer
    Left = 348
    Top = 472
  end
end
