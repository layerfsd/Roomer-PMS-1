object frmCountries: TfrmCountries
  Left = 2633
  Top = 63
  Caption = 'Countries'
  ClientHeight = 546
  ClientWidth = 620
  Color = clBtnFace
  Constraints.MinWidth = 460
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 620
    Height = 546
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sbMain: TStatusBar
      Left = 0
      Top = 527
      Width = 620
      Height = 19
      Panels = <>
      SimplePanel = True
    end
    object PanTop: TsPanel
      Left = 0
      Top = 0
      Width = 620
      Height = 88
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      ExplicitTop = -6
      DesignSize = (
        620
        88)
      object labInfo2: TLabel
        Left = 333
        Top = 42
        Width = 4
        Height = 13
        Caption = '-'
      end
      object cLabFilter: TsLabel
        Left = 12
        Top = 41
        Width = 38
        Height = 16
        Alignment = taRightJustify
        Caption = 'Filter :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object btnClear: TsSpeedButton
        Left = 274
        Top = 39
        Width = 72
        Height = 21
        Caption = 'Clear'
        OnClick = edFilterClickBtn
        SkinData.SkinSection = 'SPEEDBUTTON'
        Images = DImages.PngImageList1
        ImageIndex = 4
      end
      object btnInsert: TsButton
        Left = 7
        Top = 7
        Width = 90
        Height = 24
        Hint = 'Add new record'
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
        Left = 103
        Top = 7
        Width = 89
        Height = 24
        Hint = 'Edit current record'
        Caption = 'Edit'
        ImageIndex = 25
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnEditClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnDelete: TsButton
        Left = 198
        Top = 7
        Width = 110
        Height = 24
        Hint = 'Delete current record'
        Caption = 'Delete'
        ImageIndex = 24
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnDeleteClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnOther: TsButton
        Left = 314
        Top = 9
        Width = 165
        Height = 24
        Hint = 'Other actions - Select from menu'
        Caption = 'Other actions'
        DropDownMenu = mnuOther
        ImageIndex = 76
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        Style = bsSplitButton
        TabOrder = 3
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClose: TsButton
        Left = 529
        Top = 7
        Width = 84
        Height = 24
        Hint = 'Close form'
        Anchors = [akTop, akRight]
        Caption = 'Close'
        ImageIndex = 27
        Images = DImages.PngImageList1
        ModalResult = 11
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = btnCloseClick
        SkinData.SkinSection = 'BUTTON'
      end
      object chkActive: TsCheckBox
        Left = 55
        Top = 63
        Width = 242
        Height = 19
        Caption = 'Active (if checked then just active are visible'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = chkActiveClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object edFilter: TsEdit
        Left = 56
        Top = 39
        Width = 216
        Height = 24
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnChange = edFilterChange
        SkinData.SkinSection = 'EDIT'
      end
    end
    object panBtn: TsPanel
      Left = 0
      Top = 493
      Width = 620
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      object sPanel1: TsPanel
        Left = 421
        Top = 0
        Width = 199
        Height = 34
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alRight
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          199
          34)
        object BtnOk: TsButton
          Left = 21
          Top = 3
          Width = 85
          Height = 25
          Hint = 'Apply and close'
          Anchors = [akTop, akRight]
          Caption = 'OK'
          ImageIndex = 82
          Images = DImages.PngImageList1
          ModalResult = 1
          TabOrder = 0
          OnClick = BtnOkClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnCancel: TsButton
          Left = 112
          Top = 3
          Width = 83
          Height = 25
          Hint = 'Cancel and close'
          Anchors = [akTop, akRight]
          Cancel = True
          Caption = 'Cancel'
          ImageIndex = 4
          Images = DImages.PngImageList1
          ModalResult = 2
          TabOrder = 1
          OnClick = btnCancelClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
    object grData: TcxGrid
      Left = 0
      Top = 88
      Width = 620
      Height = 405
      Align = alClient
      TabOrder = 3
      LevelTabs.Slants.Kind = skCutCorner
      LookAndFeel.NativeStyle = False
      object tvData: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.InfoPanel.Visible = True
        Navigator.Visible = True
        OnCellDblClick = tvDataCellDblClick
        DataController.DataSource = DS
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.OnSortingChanged = tvDataDataControllerSortingChanged
        NewItemRow.InfoText = 'H'#230' h'#243
        NewItemRow.SeparatorColor = clRed
        OptionsCustomize.BandHiding = True
        OptionsCustomize.BandMoving = False
        OptionsData.Appending = True
        OptionsData.DeletingConfirmation = False
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Bands = <
          item
            Caption = 'Country'
            Options.Moving = False
            Width = 456
          end
          item
            Caption = 'Countrygroup'
            Options.Moving = False
            Width = 178
          end
          item
            Caption = 'Currency'
            Options.Moving = False
          end>
        object tvDataRecId: TcxGridDBBandedColumn
          DataBinding.FieldName = 'RecId'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object tvDataCountry: TcxGridDBBandedColumn
          DataBinding.FieldName = 'Country'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.CharCase = ecUpperCase
          Properties.ValidateOnEnter = True
          Properties.OnValidate = tvDataCountryPropertiesValidate
          Width = 66
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvDataIslCountryName: TcxGridDBBandedColumn
          Caption = 'Local country name'
          DataBinding.FieldName = 'islCountryName'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ValidateOnEnter = True
          Width = 163
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object tvDataCountryName: TcxGridDBBandedColumn
          Caption = 'English name'
          DataBinding.FieldName = 'CountryName'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 139
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object tvDataOrderIndex: TcxGridDBBandedColumn
          Caption = 'Order'
          DataBinding.FieldName = 'OrderIndex'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.MaxValue = 9999.000000000000000000
          Width = 41
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object tvDataactive: TcxGridDBBandedColumn
          DataBinding.FieldName = 'active'
          Width = 47
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvDataCountryGroup: TcxGridDBBandedColumn
          Caption = 'Group'
          DataBinding.FieldName = 'CountryGroup'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              ImageIndex = 31
              Kind = bkGlyph
            end>
          Properties.CharCase = ecUpperCase
          Properties.Images = DImages.PngImageList1
          Properties.ReadOnly = False
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = tvDataCountryGroupPropertiesButtonClick
          Options.ShowEditButtons = isebAlways
          Width = 60
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvDataCountryGroupsGroupName: TcxGridDBBandedColumn
          Caption = 'Name'
          DataBinding.FieldName = 'CountryGroupsGroupName'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          Width = 117
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvDataCurrency: TcxGridDBBandedColumn
          DataBinding.FieldName = 'Currency'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = '...'
              ContentAlignment = taLeftJustify
              Default = True
              ImageIndex = 31
              Kind = bkGlyph
              Stretchable = False
              Width = 18
            end>
          Properties.CharCase = ecUpperCase
          Properties.Images = DImages.PngImageList1
          Properties.ReadOnly = False
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = tvDataCurrencyPropertiesButtonClick
          Options.ShowEditButtons = isebAlways
          Width = 69
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvDataCurrenciesDescription: TcxGridDBBandedColumn
          Caption = 'Name'
          DataBinding.FieldName = 'CurrenciesDescription'
          Width = 168
          Position.BandIndex = 2
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvDataID: TcxGridDBBandedColumn
          DataBinding.FieldName = 'ID'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
      end
      object lvData: TcxGridLevel
        Caption = 'Grid'
        GridView = tvData
        Options.DetailTabsPosition = dtpTop
      end
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 336
    Top = 184
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      ImageIndex = 3
      OnClick = mnuiPrintClick
    end
    object mnuiAllowGridEdit: TMenuItem
      Caption = 'Allow grid edit'
      Checked = True
      OnClick = mnuiAllowGridEditClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Export1: TMenuItem
      Caption = 'Export'
      ImageIndex = 98
      object mnuiGridToExcel: TMenuItem
        Caption = 'Grid to Excel'
        OnClick = mnuiGridToExcelClick
      end
      object mnuiGridToHtml: TMenuItem
        Caption = 'Grid to HTML'
        ImageIndex = 99
        OnClick = mnuiGridToHtmlClick
      end
      object mnuiGridToText: TMenuItem
        Caption = 'Grid to text'
        OnClick = mnuiGridToTextClick
      end
      object mnuiGridToXml: TMenuItem
        Caption = 'Grid to XML'
        OnClick = mnuiGridToXmlClick
      end
    end
  end
  object DS: TDataSource
    DataSet = m_
    Left = 416
    Top = 184
  end
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    AfterPost = m_AfterPost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 376
    Top = 184
    object m_Country: TWideStringField
      FieldName = 'Country'
      Size = 2
    end
    object m_CountryName: TWideStringField
      FieldName = 'CountryName'
      Size = 50
    end
    object m_islCountryName: TWideStringField
      FieldName = 'islCountryName'
      Size = 50
    end
    object m_Currency: TWideStringField
      FieldName = 'Currency'
      Size = 5
    end
    object m_CountryGroup: TWideStringField
      FieldName = 'CountryGroup'
      Size = 5
    end
    object m_OrderIndex: TIntegerField
      FieldName = 'OrderIndex'
    end
    object m_CurrenciesDescription: TWideStringField
      FieldName = 'CurrenciesDescription'
      Size = 30
    end
    object m_CountryGroupsGroupName: TWideStringField
      FieldName = 'CountryGroupsGroupName'
      Size = 50
    end
    object m_active: TBooleanField
      FieldName = 'active'
    end
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 456
    Top = 184
    object prLink_grData: TdxGridReportLink
      Component = grData
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      BuiltInReportLink = True
    end
  end
  object FormStore: TcxPropertiesStore
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
    StorageName = 'Software\Roomer\FormStatus\Countries'
    StorageType = stRegistry
    Left = 526
    Top = 176
  end
end
