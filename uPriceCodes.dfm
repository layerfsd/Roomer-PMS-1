object frmPriceCodes: TfrmPriceCodes
  Left = 1308
  Top = 284
  Caption = 'Rate code '
  ClientHeight = 424
  ClientWidth = 550
  Color = clBtnFace
  Constraints.MinWidth = 460
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbMain: TsStatusBar
    Left = 0
    Top = 405
    Width = 550
    Height = 19
    Panels = <>
    SimplePanel = True
    SkinData.SkinSection = 'STATUSBAR'
  end
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 550
    Height = 89
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object cLabFilter: TsLabel
      Left = 9
      Top = 41
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Filter :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnClear: TsSpeedButton
      Left = 268
      Top = 39
      Width = 74
      Height = 21
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object labFilterWarning: TsLabel
      Left = 1
      Top = 74
      Width = 548
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = '-'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
      Transparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitWidth = 4
    end
    object btnDelete: TsButton
      Left = 199
      Top = 7
      Width = 90
      Height = 26
      Hint = 'Delete current record'
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 295
      Top = 7
      Width = 140
      Height = 26
      Hint = 'Other actions - Select from menu'
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      Style = bsSplitButton
      TabOrder = 1
      OnClick = btnOtherClick
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 49
      Top = 39
      Width = 218
      Height = 22
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
    object btnInsert: TsButton
      Left = 7
      Top = 7
      Width = 89
      Height = 26
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnInsertClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 102
      Top = 7
      Width = 91
      Height = 26
      Hint = 'Edit current record'
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnEditClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 372
    Width = 550
    Height = 33
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      550
      33)
    object btnCancel: TsButton
      Left = 462
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
    end
    object BtnOk: TsButton
      Left = 374
      Top = 4
      Width = 84
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
    Top = 89
    Width = 550
    Height = 283
    Align = alClient
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
      OnFocusedRecordChanged = tvDataFocusedRecordChanged
      DataController.DataSource = DS
      DataController.Filter.OnChanged = tvDataDataControllerFilterChanged
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
        Width = 43
      end
      object tvDatapcCode: TcxGridDBColumn
        Caption = 'Code'
        DataBinding.FieldName = 'pcCode'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.ValidateOnEnter = True
        Properties.OnValidate = tvDatapcCodePropertiesValidate
        Width = 78
      end
      object tvDatapcDescription: TcxGridDBColumn
        Caption = 'Description'
        DataBinding.FieldName = 'pcDescription'
        Width = 229
      end
      object tvDatapcRack: TcxGridDBColumn
        Caption = 'Is Rack'
        DataBinding.FieldName = 'pcRack'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.OnValidate = tvDatapcRackPropertiesValidate
        Width = 54
      end
      object tvDatapcRackCalc: TcxGridDBColumn
        Caption = 'Rack multiply'
        DataBinding.FieldName = 'pcRackCalc'
        Visible = False
        Width = 71
      end
      object tvDatapcShowDiscount: TcxGridDBColumn
        Caption = 'Show discount'
        DataBinding.FieldName = 'pcShowDiscount'
        Visible = False
      end
      object tvDatapcDiscountText: TcxGridDBColumn
        Caption = 'Discount text'
        DataBinding.FieldName = 'pcDiscountText'
        Visible = False
        Width = 188
      end
      object tvDatapcAutomatic: TcxGridDBColumn
        Caption = 'is Auto'
        DataBinding.FieldName = 'pcAutomatic'
        Visible = False
        Width = 52
      end
      object tvDatapcLastUpdate: TcxGridDBColumn
        Caption = 'LastUpdate'
        DataBinding.FieldName = 'pcLastUpdate'
        Visible = False
      end
      object tvDatapcDiscountMethod: TcxGridDBColumn
        Caption = 'Discount method'
        DataBinding.FieldName = 'pcDiscountMethod'
        Visible = False
      end
      object tvDatapcDiscountPriceAfter: TcxGridDBColumn
        Caption = 'Discount after'
        DataBinding.FieldName = 'pcDiscountPriceAfter'
        Visible = False
      end
      object tvDatapcDiscountDaysAfter: TcxGridDBColumn
        Caption = 'Discount days after'
        DataBinding.FieldName = 'pcDiscountDaysAfter'
        Visible = False
      end
      object tvDataActive: TcxGridDBColumn
        DataBinding.FieldName = 'Active'
        Width = 51
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 352
    Top = 128
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_pcCode: TWideStringField
      FieldName = 'pcCode'
      Size = 10
    end
    object m_pcDescription: TWideStringField
      FieldName = 'pcDescription'
      Size = 50
    end
    object m_pcRack: TBooleanField
      FieldName = 'pcRack'
    end
    object m_pcRackCalc: TFloatField
      FieldName = 'pcRackCalc'
    end
    object m_pcShowDiscount: TBooleanField
      FieldName = 'pcShowDiscount'
    end
    object m_pcDiscountText: TWideStringField
      FieldName = 'pcDiscountText'
      Size = 50
    end
    object m_pcAutomatic: TBooleanField
      FieldName = 'pcAutomatic'
    end
    object m_pcLastUpdate: TDateTimeField
      FieldName = 'pcLastUpdate'
    end
    object m_pcDiscountMethod: TIntegerField
      FieldName = 'pcDiscountMethod'
    end
    object m_pcDiscountPriceAfter: TFloatField
      FieldName = 'pcDiscountPriceAfter'
    end
    object m_pcDiscountDaysAfter: TIntegerField
      FieldName = 'pcDiscountDaysAfter'
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 296
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
        ImageIndex = 0
        OnClick = mnuiGridToXmlClick
      end
    end
  end
  object DS: TDataSource
    DataSet = m_
    Left = 400
    Top = 128
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 368
    Top = 224
    object prLink_grData: TdxGridReportLink
      Active = True
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
      ReportDocument.CreationDate = 42500.507228750000000000
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
    StorageName = 'Software\Roomer\FormStatus\PriceCodes'
    StorageType = stRegistry
    Left = 152
    Top = 216
  end
end
