object FrmInvoice2015: TFrmInvoice2015
  Left = 0
  Top = 0
  Caption = 'Invoice'
  ClientHeight = 687
  ClientWidth = 947
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pContainer: TsPanel
    Left = 0
    Top = 0
    Width = 947
    Height = 687
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'TRANSPARENT'
    object pTop: TsPanel
      Left = 0
      Top = 0
      Width = 947
      Height = 197
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'TRANSPARENT'
      object sLabel1: TsLabel
        Left = 55
        Top = 9
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'Customer:'
      end
      object sLabel2: TsLabel
        Left = 74
        Top = 66
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Name:'
      end
      object sLabel3: TsLabel
        Left = 62
        Top = 92
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Address:'
      end
      object sLabel4: TsLabel
        Left = 58
        Top = 138
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'Zip / City:'
      end
      object sLabel5: TsLabel
        Left = 62
        Top = 162
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Country:'
      end
      object sLabel6: TsLabel
        Left = 13
        Top = 33
        Width = 92
        Height = 13
        Alignment = taRightJustify
        Caption = 'Invoice addressee:'
      end
      object sLabel14: TsLabel
        Left = 291
        Top = 9
        Width = 21
        Height = 13
        Alignment = taRightJustify
        Caption = 'PID:'
      end
      object edtCustomer: TcxButtonEdit
        Left = 111
        Top = 6
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = edtCustomerPropertiesButtonClick
        Style.BorderStyle = ebsUltraFlat
        Style.ButtonStyle = btsUltraFlat
        TabOrder = 0
        Width = 141
      end
      object edtName: TsEdit
        Left = 111
        Top = 63
        Width = 348
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
        Left = 111
        Top = 87
        Width = 348
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
      object edtZip: TsEdit
        Left = 111
        Top = 135
        Width = 90
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
      object edtAddress2: TsEdit
        Left = 111
        Top = 111
        Width = 348
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
        Left = 207
        Top = 135
        Width = 252
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
      object edtCountryName: TsEdit
        Left = 207
        Top = 159
        Width = 252
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        SkinData.SkinSection = 'EDIT'
      end
      object edtCountry: TcxButtonEdit
        Left = 111
        Top = 159
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsHideCursor
        Style.BorderStyle = ebsUltraFlat
        Style.ButtonStyle = btsUltraFlat
        Style.ButtonTransparency = ebtNone
        TabOrder = 7
        Width = 90
      end
      object cbCustomerNameMethod: TsComboBox
        Left = 111
        Top = 30
        Width = 141
        Height = 21
        Alignment = taLeftJustify
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csDropDownList
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 1
        ParentFont = False
        TabOrder = 8
        Text = 'Reservation Customer'
        OnCloseUp = cbCustomerNameMethodCloseUp
        Items.Strings = (
          'Customer'
          'Reservation Customer'
          'Room guest'
          'Last saved'
          'Free text'
          'Cash')
      end
      object sPanel6: TsPanel
        Left = 633
        Top = 0
        Width = 314
        Height = 197
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 9
        SkinData.SkinSection = 'TRANSPARENT'
        object sLabel7: TsLabel
          Left = 89
          Top = 9
          Width = 48
          Height = 13
          Alignment = taRightJustify
          Caption = 'Currency:'
        end
        object sLabel8: TsLabel
          Left = 110
          Top = 33
          Width = 27
          Height = 13
          Alignment = taRightJustify
          Caption = 'Rate:'
        end
        object Shape1: TShape
          Left = 42
          Top = 57
          Width = 216
          Height = 2
        end
        object sLabel9: TsLabel
          Left = 90
          Top = 66
          Width = 47
          Height = 13
          Alignment = taRightJustify
          Caption = 'Total net:'
        end
        object sLabel10: TsLabel
          Left = 114
          Top = 90
          Width = 23
          Height = 13
          Alignment = taRightJustify
          Caption = 'VAT:'
        end
        object sLabel11: TsLabel
          Left = 73
          Top = 114
          Width = 64
          Height = 13
          Alignment = taRightJustify
          Caption = 'Invoice total:'
        end
        object sLabel12: TsLabel
          Left = 86
          Top = 138
          Width = 51
          Height = 13
          Alignment = taRightJustify
          Caption = 'Payments:'
        end
        object sLabel13: TsLabel
          Left = 82
          Top = 162
          Width = 55
          Height = 16
          Alignment = taRightJustify
          Caption = 'Balance:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object edtCurrency: TcxButtonEdit
          Left = 143
          Top = 6
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = edtCurrencyPropertiesButtonClick
          Style.BorderStyle = ebsUltraFlat
          Style.ButtonStyle = btsUltraFlat
          TabOrder = 0
          Width = 114
        end
        object edtCurrencyRate: TsEdit
          Left = 143
          Top = 30
          Width = 114
          Height = 21
          Alignment = taRightJustify
          BorderStyle = bsNone
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
        object edtTotalNet: TsEdit
          Left = 143
          Top = 63
          Width = 114
          Height = 21
          Alignment = taRightJustify
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          SkinData.SkinSection = 'EDIT'
        end
        object edtVat: TsEdit
          Left = 143
          Top = 87
          Width = 114
          Height = 21
          Alignment = taRightJustify
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          SkinData.SkinSection = 'EDIT'
        end
        object edtInvoiceTotal: TsEdit
          Left = 143
          Top = 111
          Width = 114
          Height = 21
          Alignment = taRightJustify
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          SkinData.SkinSection = 'EDIT'
        end
        object edtPayments: TsEdit
          Left = 143
          Top = 135
          Width = 114
          Height = 21
          Alignment = taRightJustify
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          SkinData.SkinSection = 'EDIT'
        end
        object edtBalance: TsEdit
          Left = 143
          Top = 159
          Width = 114
          Height = 21
          Alignment = taRightJustify
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2302755
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          SkinData.SkinSection = 'EDIT'
        end
      end
      object edtPersonalId: TcxButtonEdit
        Left = 318
        Top = 6
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = edtCustomerPropertiesButtonClick
        Style.BorderStyle = ebsUltraFlat
        Style.ButtonStyle = btsUltraFlat
        TabOrder = 10
        Width = 141
      end
    end
    object pBottom: TsPanel
      Left = 0
      Top = 197
      Width = 947
      Height = 404
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      SkinData.SkinSection = 'TRANSPARENT'
      object sPanel2: TsPanel
        Left = 650
        Top = 0
        Width = 297
        Height = 404
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        SkinData.SkinSection = 'TRANSPARENT'
        object sPageControl1: TsPageControl
          Left = 0
          Top = 0
          Width = 297
          Height = 404
          ActivePage = sTabSheet2
          Align = alClient
          TabOrder = 0
          SkinData.SkinSection = 'PAGECONTROL'
          object sTabSheet2: TsTabSheet
            Caption = 'Invoices'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
          end
        end
      end
      object pgContainer: TsPageControl
        Left = 0
        Top = 0
        Width = 650
        Height = 404
        ActivePage = sTabSheet4
        Align = alClient
        TabOrder = 1
        SkinData.SkinSection = 'PAGECONTROL'
        object sTabSheet3: TsTabSheet
          Caption = 'Invoice'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object lvLines: TsListView
            Left = 0
            Top = 40
            Width = 642
            Height = 336
            SkinData.SkinSection = 'EDIT'
            OnItemChecked = lvLinesItemChecked
            Align = alClient
            Checkboxes = True
            Color = clWhite
            Columns = <
              item
                Caption = 'Product'
                Width = 110
              end
              item
                Caption = 'Text'
                Width = 250
              end
              item
                Alignment = taRightJustify
                Caption = 'No items'
                Width = 70
              end
              item
                Alignment = taRightJustify
                Caption = 'Price'
                Width = 100
              end
              item
                Alignment = taRightJustify
                Caption = 'Total'
                Width = 100
              end>
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            FlatScrollBars = True
            GridLines = True
            ReadOnly = True
            RowSelect = True
            ParentFont = False
            TabOrder = 0
            ViewStyle = vsReport
            OnDblClick = lvLinesDblClick
            OnSelectItem = lvLinesSelectItem
            ExplicitWidth = 0
          end
          object sPanel3: TsPanel
            Left = 0
            Top = 0
            Width = 642
            Height = 40
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            SkinData.SkinSection = 'TRANSPARENT'
            object btnInsert: TsButton
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 114
              Height = 34
              Hint = 'Add new record'
              Align = alLeft
              Caption = 'New'
              ImageIndex = 23
              Images = DImages.PngImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = btnInsertClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnEdit: TsButton
              AlignWithMargins = True
              Left = 123
              Top = 3
              Width = 114
              Height = 34
              Hint = 'Delete current record'
              Align = alLeft
              Caption = 'Edit'
              Enabled = False
              ImageIndex = 25
              Images = DImages.PngImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = btnEditClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnDelete: TsButton
              AlignWithMargins = True
              Left = 243
              Top = 3
              Width = 114
              Height = 34
              Hint = 'Delete current record'
              Align = alLeft
              Caption = 'Delete'
              Enabled = False
              ImageIndex = 24
              Images = DImages.PngImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnClick = btnDeleteClick
              SkinData.SkinSection = 'BUTTON'
            end
          end
        end
        object sTabSheet4: TsTabSheet
          Caption = 'Down payments'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object sPanel5: TsPanel
            Left = 0
            Top = 0
            Width = 642
            Height = 40
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            SkinData.SkinSection = 'TRANSPARENT'
            object sButton1: TsButton
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 114
              Height = 34
              Hint = 'Add new record'
              Align = alLeft
              Caption = 'New'
              ImageIndex = 23
              Images = DImages.PngImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = sButton1Click
              SkinData.SkinSection = 'BUTTON'
            end
            object btnEditPayment: TsButton
              AlignWithMargins = True
              Left = 123
              Top = 3
              Width = 114
              Height = 34
              Hint = 'Delete current record'
              Align = alLeft
              Caption = 'Edit'
              Enabled = False
              ImageIndex = 25
              Images = DImages.PngImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = btnEditPaymentClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnDeletePayment: TsButton
              AlignWithMargins = True
              Left = 243
              Top = 3
              Width = 114
              Height = 34
              Hint = 'Delete current record'
              Align = alLeft
              Caption = 'Delete'
              Enabled = False
              ImageIndex = 24
              Images = DImages.PngImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnClick = btnDeletePaymentClick
              SkinData.SkinSection = 'BUTTON'
            end
          end
          object lvPayments: TsListView
            Left = 0
            Top = 40
            Width = 642
            Height = 336
            SkinData.SkinSection = 'EDIT'
            OnItemChecked = lvPaymentsItemChecked
            Align = alClient
            Checkboxes = True
            Color = clWhite
            Columns = <
              item
                Caption = 'Date'
                Width = 80
              end
              item
                Caption = 'Type'
              end
              item
                Alignment = taRightJustify
                Caption = 'Amount'
                Width = 100
              end
              item
                Caption = 'Text'
                Width = 150
              end
              item
                Caption = 'Paygroup'
                Width = 70
              end
              item
                Caption = 'Notes'
                Width = 100
              end>
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            FlatScrollBars = True
            GridLines = True
            ReadOnly = True
            RowSelect = True
            ParentFont = False
            TabOrder = 1
            ViewStyle = vsReport
            OnDblClick = btnEditPaymentClick
            OnSelectItem = lvPaymentsSelectItem
          end
        end
      end
    end
    object sPanel1: TsPanel
      Left = 0
      Top = 640
      Width = 947
      Height = 47
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      SkinData.SkinSection = 'TRANSPARENT'
      object btnProforma: TcxButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 161
        Height = 41
        Align = alLeft
        Caption = 'Print proforma'
        LookAndFeel.NativeStyle = False
        OptionsImage.ImageIndex = 3
        OptionsImage.Images = DImages.cxLargeImagesFlat
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.Flat = True
        TabOrder = 0
        WordWrap = True
      end
      object btnInvoice: TcxButton
        AlignWithMargins = True
        Left = 170
        Top = 3
        Width = 161
        Height = 41
        Align = alLeft
        Caption = 'Pay and Print'
        LookAndFeel.NativeStyle = False
        OptionsImage.ImageIndex = 59
        OptionsImage.Images = DImages.cxLargeImagesFlat
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.Flat = True
        TabOrder = 1
        WordWrap = True
      end
    end
    object sPanel4: TsPanel
      Left = 0
      Top = 601
      Width = 947
      Height = 39
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      SkinData.SkinSection = 'TRANSPARENT'
      DesignSize = (
        947
        39)
      object chkShowPackage: TsCheckBox
        Left = 7
        Top = 2
        Width = 116
        Height = 19
        Caption = 'Package on invoice'
        Anchors = [akTop, akRight]
        Checked = True
        State = cbChecked
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
  end
  object StoreMain: TcxPropertiesStore
    Active = False
    Components = <
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
    StorageName = 'Software\Roomer\FormStatus\Invoice2015'
    StorageType = stRegistry
    Left = 392
    Top = 616
  end
end
