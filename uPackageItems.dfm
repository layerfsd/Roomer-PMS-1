object frmPackageItems: TfrmPackageItems
  Left = 0
  Top = 0
  Caption = 'Package Items'
  ClientHeight = 450
  ClientWidth = 875
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 875
    Height = 65
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      875
      65)
    object cLabFilter: TsLabel
      Left = 19
      Top = 39
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
    object Label1: TsLabel
      Left = 350
      Top = 13
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
    object btnClear: TsSpeedButton
      Left = 263
      Top = 39
      Width = 59
      Height = 21
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 10
      Images = DImages.PngImageList1
    end
    object btnClose: TsButton
      Left = 786
      Top = 8
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 8
      TabOrder = 0
      OnClick = btnCloseClick
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 198
      Height = 21
      Color = 3355443
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object btnInsert: TsButton
      Left = 10
      Top = 7
      Width = 62
      Height = 26
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnInsertClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 73
      Top = 7
      Width = 62
      Height = 26
      Hint = 'Edit current record'
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDelete: TsButton
      Left = 137
      Top = 7
      Width = 61
      Height = 26
      Hint = 'Delete current record'
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 200
      Top = 7
      Width = 124
      Height = 26
      Hint = 'Other actions - Select from menu'
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      Style = bsSplitButton
      TabOrder = 5
      OnClick = btnOtherClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sbMain: TsStatusBar
    Left = 0
    Top = 431
    Width = 875
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 397
    Width = 875
    Height = 34
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      875
      34)
    object btnCancel: TsButton
      Left = 786
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 698
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
    end
  end
  object grData: TcxGrid
    Left = 0
    Top = 123
    Width = 875
    Height = 274
    Align = alClient
    Constraints.MinWidth = 450
    TabOrder = 3
    LookAndFeel.NativeStyle = False
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
      OnEditDblClick = tvDataEditDblClick
      OnFocusedRecordChanged = tvDataFocusedRecordChanged
      DataController.DataSource = DS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          FieldName = 'TotalPrice'
          Column = tvDataTotalPrice
        end>
      DataController.Summary.SummaryGroups = <>
      DataController.OnSortingChanged = tvDataDataControllerSortingChanged
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.IncSearch = True
      OptionsData.Appending = True
      OptionsData.CancelOnExit = False
      OptionsData.DeletingConfirmation = False
      OptionsView.Footer = True
      OptionsView.FooterAutoHeight = True
      OptionsView.FooterMultiSummaries = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      OptionsView.Indicator = True
      object tvDataRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object tvDataid: TcxGridDBColumn
        DataBinding.FieldName = 'id'
        Visible = False
      end
      object tvDataItem: TcxGridDBColumn
        DataBinding.FieldName = 'Item'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = tvDataItemPropertiesButtonClick
        Properties.OnValidate = tvDataItemPropertiesValidate
        Options.ShowEditButtons = isebAlways
        Width = 105
      end
      object tvDatadescription: TcxGridDBColumn
        Caption = 'Package text'
        DataBinding.FieldName = 'description'
        Width = 227
      end
      object tvDatanumItems: TcxGridDBColumn
        Caption = 'Quantity'
        DataBinding.FieldName = 'numItems'
        PropertiesClassName = 'TcxSpinEditProperties'
      end
      object tvDatanumItemsMethodStr: TcxGridDBColumn
        Caption = 'Count Rule'
        DataBinding.FieldName = 'numItemsMethodStr'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.OnValidate = tvDatanumItemsMethodStrPropertiesValidate
        Width = 77
      end
      object tvDataIncludedInRate: TcxGridDBColumn
        Caption = 'Included In Rate'
        DataBinding.FieldName = 'IncludedInRate'
        Width = 66
      end
      object tvDataunitPrice: TcxGridDBColumn
        Caption = 'Unit Price'
        DataBinding.FieldName = 'unitPrice'
        PropertiesClassName = 'TcxCalcEditProperties'
        Width = 95
      end
      object tvDataTotalPrice: TcxGridDBColumn
        Caption = 'Total Price'
        DataBinding.FieldName = 'TotalPrice'
        Options.Editing = False
        Width = 103
      end
      object tvDatapackageId: TcxGridDBColumn
        Caption = 'Package Id'
        DataBinding.FieldName = 'packageId'
        Visible = False
      end
      object tvDataitemId: TcxGridDBColumn
        Caption = 'Item Id'
        DataBinding.FieldName = 'itemId'
        Visible = False
      end
      object tvDataitemDescription: TcxGridDBColumn
        Caption = 'Item Description'
        DataBinding.FieldName = 'itemDescription'
        Visible = False
      end
      object tvDataitemPrice: TcxGridDBColumn
        Caption = 'Item Price'
        DataBinding.FieldName = 'itemPrice'
        Visible = False
      end
      object tvDatanumItemsMethod: TcxGridDBColumn
        Caption = 'Method of calculation'
        DataBinding.FieldName = 'numItemsMethod'
        Visible = False
      end
      object tvDatavalueFormula: TcxGridDBColumn
        Caption = 'Overriding Value Formula'
        DataBinding.FieldName = 'valueFormula'
        Width = 200
      end
      object tvDataunitPriceVatFormula: TcxGridDBColumn
        Caption = 'Overriding Vat Formula'
        DataBinding.FieldName = 'unitPriceVatFormula'
        Width = 200
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object sGroupBox1: TsGroupBox
    Left = 0
    Top = 65
    Width = 875
    Height = 58
    Align = alTop
    Caption = 'Package'
    TabOrder = 4
    SkinData.SkinSection = 'GROUPBOX'
    object sLabel1: TsLabel
      Left = 29
      Top = 20
      Width = 60
      Height = 21
      Alignment = taRightJustify
      Caption = 'Name :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object labPackageName: TsLabel
      Left = 99
      Top = 20
      Width = 7
      Height = 21
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 54
    Top = 192
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
        OnClick = mnuiGridToXmlClick
      end
    end
  end
  object DS: TDataSource
    DataSet = m_
    Left = 232
    Top = 392
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 368
    Top = 224
    object prLink_grData: TdxGridReportLink
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
      ReportDocument.CreationDate = 41334.495374884260000000
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      BuiltInReportLink = True
    end
  end
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnCalcFields = m_CalcFields
    OnNewRecord = m_NewRecord
    Left = 232
    Top = 328
    object m_id: TIntegerField
      FieldName = 'id'
    end
    object m_description: TWideStringField
      FieldName = 'description'
      Size = 45
    end
    object m_unitPrice: TFloatField
      FieldName = 'unitPrice'
    end
    object m_packageId: TIntegerField
      FieldName = 'packageId'
    end
    object m_itemId: TIntegerField
      FieldName = 'itemId'
    end
    object m_Item: TWideStringField
      FieldName = 'Item'
    end
    object m_itemDescription: TWideStringField
      FieldName = 'itemDescription'
      Size = 30
    end
    object m_itemPrice: TFloatField
      FieldName = 'itemPrice'
    end
    object m_numItems: TIntegerField
      FieldName = 'numItems'
    end
    object m_TotalPrice: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalPrice'
      Calculated = True
    end
    object m_numItemsMethod: TIntegerField
      FieldName = 'numItemsMethod'
    end
    object m_numItemsMethodStr: TStringField
      FieldName = 'numItemsMethodStr'
    end
    object m_IncludedInRate: TBooleanField
      FieldName = 'IncludedInRate'
    end
    object m_valueFormula: TWideStringField
      FieldName = 'valueFormula'
      Size = 255
    end
    object m_unitPriceVatFormula: TWideStringField
      FieldName = 'unitPriceVatFormula'
      Size = 255
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
    StorageName = 'Software\Roomer\FormStatus\PackageItems'
    StorageType = stRegistry
    Left = 254
    Top = 240
  end
end
