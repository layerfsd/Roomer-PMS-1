object frmRates: TfrmRates
  Left = 0
  Top = 0
  Caption = 'Rates'
  ClientHeight = 465
  ClientWidth = 829
  Color = clBtnFace
  Constraints.MinWidth = 750
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 829
    Height = 83
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 734
    DesignSize = (
      829
      83)
    object cLabFilter: TsLabel
      Left = 19
      Top = 41
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Filter :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnClear: TsSpeedButton
      Left = 271
      Top = 39
      Width = 66
      Height = 20
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object btnDelete: TsButton
      Left = 199
      Top = 7
      Width = 90
      Height = 26
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 295
      Top = 7
      Width = 134
      Height = 26
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      Style = bsSplitButton
      TabOrder = 1
      OnClick = btnOtherClick
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 213
      Height = 21
      Color = 3355443
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
    object gbxFilter: TsGroupBox
      Left = 469
      Top = 1
      Width = 265
      Height = 59
      Caption = 'Filter'
      TabOrder = 3
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object sLabel1: TsLabel
        Left = 11
        Top = 19
        Width = 85
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Currency : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cbxCurrencies: TColumnComboBox
        Left = 106
        Top = 16
        Width = 153
        Height = 22
        Color = clWindow
        Version = '1.5.0.0'
        Visible = True
        Ctl3D = True
        Columns = <
          item
            Color = clWindow
            ColumnType = ctText
            Width = 30
            Alignment = taLeftJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          item
            Color = clSilver
            ColumnType = ctText
            Width = 100
            Alignment = taLeftJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end>
        ComboItems = <>
        EditColumn = -1
        EditHeight = 16
        EmptyText = ''
        EmptyTextStyle = []
        DropWidth = 145
        DropHeight = 200
        Enabled = True
        FocusBorder = True
        GridLines = True
        ItemIndex = -1
        LookupColumn = 0
        LabelCaption = ''
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        ParentCtl3D = False
        SortColumn = 0
        TabOrder = 0
        OnCloseUp = cbxCurrenciesCloseUp
      end
    end
    object chkActive: TsCheckBox
      Left = 56
      Top = 62
      Width = 244
      Height = 19
      Caption = 'Active (if checked then just active are visible)'
      Checked = True
      State = cbChecked
      TabOrder = 4
      Visible = False
      OnClick = chkActiveClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object btnInsert: TsButton
      Left = 7
      Top = 7
      Width = 90
      Height = 26
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnInsertClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 103
      Top = 7
      Width = 90
      Height = 26
      Hint = 'Edit current record'
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = btnEditClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnRefresh: TsButton
      Left = 740
      Top = 9
      Width = 80
      Height = 38
      Hint = 'Refresh'
      Anchors = [akTop, akRight]
      Caption = 'Refresh'
      ImageIndex = 28
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sbMain: TsStatusBar
    Left = 0
    Top = 446
    Width = 829
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
    ExplicitWidth = 734
  end
  object panBtn: TsPanel
    Left = 0
    Top = 413
    Width = 829
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 734
    DesignSize = (
      829
      33)
    object btnCancel: TsButton
      Left = 740
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
      ExplicitLeft = 645
    end
    object BtnOk: TsButton
      Left = 652
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 557
    end
  end
  object grData: TcxGrid
    Left = 0
    Top = 83
    Width = 829
    Height = 330
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 3
    LookAndFeel.NativeStyle = False
    ExplicitWidth = 734
    object tvData: TcxGridDBTableView
      OnDblClick = tvDataDblClick
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
      OnFocusedRecordChanged = tvDataFocusedRecordChanged
      DataController.DataSource = DS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnSortingChanged = tvDataDataControllerSortingChanged
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
      object tvDataID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Visible = False
      end
      object tvDataisDefault: TcxGridDBColumn
        Caption = 'Def'
        DataBinding.FieldName = 'isDefault'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.OnValidate = tvDataisDefaultPropertiesValidate
      end
      object tvDataDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = tvDataDescriptionPropertiesValidate
        Width = 169
      end
      object tvDataActive: TcxGridDBColumn
        DataBinding.FieldName = 'Active'
        Width = 41
      end
      object tvDataCurrency: TcxGridDBColumn
        DataBinding.FieldName = 'Currency'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataCurrencyPropertiesButtonClick
        Properties.OnValidate = tvDataCurrencyPropertiesValidate
        Width = 67
      end
      object tvDataRate1Person: TcxGridDBColumn
        Caption = '1 person'
        DataBinding.FieldName = 'Rate1Person'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '###0.00;###0.00'
        Width = 76
      end
      object tvDataRate2Persons: TcxGridDBColumn
        Caption = '2 persons'
        DataBinding.FieldName = 'Rate2Persons'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '###0.00;###0.00'
        Width = 76
      end
      object tvDataRate3Persons: TcxGridDBColumn
        Caption = '3 persons'
        DataBinding.FieldName = 'Rate3Persons'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '###0.00;###0.00'
        Width = 76
      end
      object tvDataRate4Persons: TcxGridDBColumn
        Caption = '4 persons'
        DataBinding.FieldName = 'Rate4Persons'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '###0.00;###0.00'
        Width = 76
      end
      object tvDataRate5Persons: TcxGridDBColumn
        Caption = '5 persons'
        DataBinding.FieldName = 'Rate5Persons'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '###0.00;###0.00'
        Width = 76
      end
      object tvDataRate6Persons: TcxGridDBColumn
        Caption = '6 persons'
        DataBinding.FieldName = 'Rate6Persons'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '###0.00;###0.00'
        Width = 76
      end
      object tvDataRateExtraPerson: TcxGridDBColumn
        Caption = 'Extra person'
        DataBinding.FieldName = 'RateExtraPerson'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '###0.00;###0.00'
        Width = 76
      end
      object tvDataRateExtraInfant: TcxGridDBColumn
        Caption = 'Infant'
        DataBinding.FieldName = 'RateExtraInfant'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '###0.00;###0.00'
        Width = 76
      end
      object tvDataRateExtraChildren: TcxGridDBColumn
        Caption = 'Child'
        DataBinding.FieldName = 'RateExtraChildren'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '###0.00;###0.00'
        Width = 76
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 190
    Top = 160
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      ImageIndex = 3
      OnClick = mnuiPrintClick
    end
    object A1: TMenuItem
      Caption = 'Apply best fit'
      OnClick = A1Click
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
        ImageIndex = 132
        OnClick = mnuiGridToExcelClick
      end
      object mnuiGridToHtml: TMenuItem
        Caption = 'Grid to HTML'
        ImageIndex = 99
        OnClick = mnuiGridToHtmlClick
      end
      object mnuiGridToText: TMenuItem
        Caption = 'Grid to text'
        ImageIndex = 0
        OnClick = mnuiGridToTextClick
      end
      object mnuiGridToXml: TMenuItem
        Caption = 'Grid to XML'
        ImageIndex = 0
        OnClick = mnuiGridToXmlClick
      end
    end
  end
  object DS: TDataSource
    DataSet = m_
    Left = 104
    Top = 160
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 216
    Top = 240
    object prLink_grData: TdxGridReportLink
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
      ReportDocument.CreationDate = 41334.495374884260000000
      BuiltInReportLink = True
    end
  end
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 104
    Top = 272
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_Description: TWideStringField
      FieldName = 'Description'
      Size = 50
    end
    object m_Currency: TWideStringField
      FieldName = 'Currency'
      Size = 5
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
    object m_Rate1Person: TFloatField
      FieldName = 'Rate1Person'
    end
    object m_Rate2Persons: TFloatField
      FieldName = 'Rate2Persons'
    end
    object m_Rate3Persons: TFloatField
      FieldName = 'Rate3Persons'
    end
    object m_Rate4Persons: TFloatField
      FieldName = 'Rate4Persons'
    end
    object m_Rate5Persons: TFloatField
      FieldName = 'Rate5Persons'
    end
    object m_Rate6Persons: TFloatField
      FieldName = 'Rate6Persons'
    end
    object m_RateExtraPerson: TFloatField
      FieldName = 'RateExtraPerson'
    end
    object m_RateExtraChildren: TFloatField
      FieldName = 'RateExtraChildren'
    end
    object m_RateExtraInfant: TFloatField
      FieldName = 'RateExtraInfant'
    end
    object m_isDefault: TBooleanField
      FieldName = 'isDefault'
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
    StorageName = 'Software\Roomer\FormStatus\Rates'
    StorageType = stRegistry
    Left = 494
    Top = 264
  end
end
