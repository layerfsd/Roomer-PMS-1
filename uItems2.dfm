object frmItems2: TfrmItems2
  Left = 0
  Top = 0
  Caption = 'Sales Items'
  ClientHeight = 663
  ClientWidth = 1145
  Color = clBtnFace
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel3: TsLabel
    Left = 85
    Top = 28
    Width = 83
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Adults : '
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sLabel4: TsLabel
    Left = 164
    Top = 28
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
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1145
    Height = 89
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
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
      Left = 273
      Top = 39
      Width = 63
      Height = 20
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 4
    end
    object btnDelete: TsButton
      Left = 199
      Top = 8
      Width = 90
      Height = 25
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 295
      Top = 8
      Width = 135
      Height = 25
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      Style = bsSplitButton
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 215
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
    object btnInsert: TsButton
      Left = 6
      Top = 8
      Width = 90
      Height = 25
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnInsertClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 102
      Top = 8
      Width = 91
      Height = 25
      Hint = 'Edit current record'
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnEditClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnTaxLinks: TsButton
      Left = 436
      Top = 8
      Width = 115
      Height = 25
      Hint = 'Open window to link taxes to items'
      Caption = 'Tax Links'
      ImageIndex = 108
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Visible = False
      OnClick = btnTaxLinksClick
      SkinData.SkinSection = 'BUTTON'
    end
    object chkActive: TsCheckBox
      Left = 55
      Top = 63
      Width = 246
      Height = 19
      Caption = 'Active (if checked then just active are visible)'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = chkActiveClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object pnlInfo: TsPanel
      Left = 816
      Top = 1
      Width = 328
      Height = 87
      Align = alRight
      TabOrder = 7
      Visible = False
      object cLabAvailFrom: TsLabel
        Left = 18
        Top = 12
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Availability from :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labAvailFrom: TsLabel
        Left = 108
        Top = 12
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
      object clabAvailTo: TsLabel
        Left = 18
        Top = 31
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Availability to :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labAvailTo: TsLabel
        Left = 108
        Top = 32
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
    end
  end
  object sbMain: TsStatusBar
    Left = 0
    Top = 644
    Width = 1145
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 612
    Width = 1145
    Height = 32
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1145
      32)
    object btnCancel: TsButton
      Left = 1066
      Top = 4
      Width = 75
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
      Left = 988
      Top = 4
      Width = 75
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
    Width = 1145
    Height = 523
    Align = alClient
    Constraints.MinWidth = 440
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
      OnEditing = tvDataEditing
      DataController.DataSource = dsItems
      DataController.Filter.AutoDataSetFilter = True
      DataController.KeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnDetailExpanding = tvDataDataControllerDetailExpanding
      DataController.OnSortingChanged = tvDataDataControllerSortingChanged
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.FocusCellOnTab = True
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
      object tvDataActive: TcxGridDBColumn
        DataBinding.FieldName = 'Active'
        Width = 59
      end
      object tvDataItem: TcxGridDBColumn
        DataBinding.FieldName = 'Item'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.OnValidate = tvDataItemPropertiesValidate
        Width = 84
      end
      object tvDataDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Width = 181
      end
      object tvDataStockItem: TcxGridDBColumn
        DataBinding.FieldName = 'StockItem'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taCenter
        Width = 55
      end
      object tvDataPrice: TcxGridDBColumn
        DataBinding.FieldName = 'Price'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = tvDataPriceCustomDrawCell
        OnGetProperties = GetPriceProperties
        Width = 83
      end
      object tvDataNumberBase: TcxGridDBColumn
        DataBinding.FieldName = 'NumberBase'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'USER_EDIT'
          'ROOM_NIGHT'
          'GUEST_NIGHT'
          'GUEST'
          'ROOM'
          'BOOKING')
      end
      object tvDataItemtype: TcxGridDBColumn
        Caption = 'Type'
        DataBinding.FieldName = 'Itemtype'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = tvDataItemtypePropertiesButtonClick
        Width = 105
      end
      object tvDataCurrency: TcxGridDBColumn
        DataBinding.FieldName = 'Currency'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Visible = False
        Width = 48
      end
      object tvDataAccountKey: TcxGridDBColumn
        DataBinding.FieldName = 'AccountKey'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = '...'
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataAccountKeyPropertiesButtonClick
        Options.ShowEditButtons = isebAlways
        Width = 129
      end
      object tvDataBookKeepCode: TcxGridDBColumn
        Caption = 'Book-keeping code'
        DataBinding.FieldName = 'BookKeepCode'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataBookKeepCodePropertiesButtonClick
        Options.ShowEditButtons = isebAlways
      end
      object tvDataMinibarItem: TcxGridDBColumn
        Caption = 'Minibar'
        DataBinding.FieldName = 'MinibarItem'
        Width = 50
      end
      object tvDataSystemItem: TcxGridDBColumn
        DataBinding.FieldName = 'SystemItem'
        Visible = False
        Width = 60
      end
      object tvDataRoomRentitem: TcxGridDBColumn
        DataBinding.FieldName = 'RoomRentitem'
        Visible = False
      end
      object tvDataReservationItem: TcxGridDBColumn
        DataBinding.FieldName = 'ReservationItem'
        Visible = False
      end
      object tvDataHide: TcxGridDBColumn
        DataBinding.FieldName = 'Hide'
        Visible = False
      end
      object tvDataTotalStock: TcxGridDBColumn
        Caption = 'Total Stock'
        DataBinding.FieldName = 'TotalStock'
        PropertiesClassName = 'TcxCalcEditProperties'
      end
      object tvDataAvailableStock: TcxGridDBColumn
        Caption = 'Available'
        DataBinding.FieldName = 'AvailableStock'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.ReadOnly = True
        OnCustomDrawCell = tvDataAvailableStockCustomDrawCell
        Options.Editing = False
      end
    end
    object tvPrices: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Edit.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = False
      Navigator.Visible = True
      FilterBox.Visible = fvNever
      DataController.DataSource = dsprices
      DataController.DetailKeyFieldNames = 'itemID'
      DataController.KeyFieldNames = 'ID'
      DataController.MasterKeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DateTimeHandling.UseLongDateFormat = False
      OptionsBehavior.FocusCellOnTab = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Appending = True
      OptionsData.DeletingConfirmation = False
      OptionsView.NavigatorOffset = 500
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Preview.LeftIndent = 300
      object tvPricesitemID: TcxGridDBColumn
        DataBinding.FieldName = 'itemID'
        Visible = False
      end
      object tvPricesfromdate: TcxGridDBColumn
        Caption = 'From Date'
        DataBinding.FieldName = 'fromdate'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.ShowTime = False
      end
      object tvPricesprice: TcxGridDBColumn
        Caption = 'Price'
        DataBinding.FieldName = 'price'
        PropertiesClassName = 'TcxCalcEditProperties'
        OnGetProperties = GetPriceProperties
        Width = 83
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
      object lvPrices: TcxGridLevel
        Caption = 'Stockprices'
        GridView = tvPrices
      end
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 22
    Top = 160
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
  object dsItems: TDataSource
    DataSet = m_Items
    Left = 168
    Top = 144
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 80
    Top = 136
    object prLink_grData: TdxGridReportLink
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 5080
      PrinterPage.GrayShading = True
      PrinterPage.Header = 2540
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210820
      PrinterPage.PageSize.Y = 297180
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 41334.495374884260000000
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      BuiltInReportLink = True
    end
  end
  object m_Items: TdxMemData
    Indexes = <
      item
        SortOptions = []
      end>
    SortOptions = [soCaseInsensitive]
    BeforeInsert = m_ItemsBeforeInsert
    BeforePost = m_ItemsBeforePost
    AfterPost = m_ItemsAfterPost
    BeforeDelete = m_ItemsBeforeDelete
    OnCalcFields = m_ItemsCalcFields
    OnNewRecord = m_ItemsNewRecord
    OnFilterRecord = m_ItemsFilterRecord
    Left = 168
    Top = 194
    object m_ItemsID: TIntegerField
      FieldName = 'ID'
    end
    object m_ItemsActive: TBooleanField
      FieldName = 'Active'
    end
    object m_ItemsItem: TWideStringField
      FieldName = 'Item'
    end
    object m_ItemsDescription: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object m_ItemsPrice: TFloatField
      FieldName = 'Price'
    end
    object m_ItemsItemtype: TWideStringField
      FieldName = 'Itemtype'
    end
    object m_ItemsAccountKey: TWideStringField
      FieldName = 'AccountKey'
      Size = 50
    end
    object m_ItemsMinibarItem: TBooleanField
      FieldName = 'MinibarItem'
    end
    object m_ItemsSystemItem: TBooleanField
      FieldName = 'SystemItem'
    end
    object m_ItemsRoomRentitem: TBooleanField
      FieldName = 'RoomRentitem'
    end
    object m_ItemsReservationItem: TBooleanField
      FieldName = 'ReservationItem'
    end
    object m_ItemsCurrency: TWideStringField
      FieldName = 'Currency'
      Size = 3
    end
    object m_ItemsHide: TBooleanField
      FieldName = 'Hide'
    end
    object m_ItemsBreakfastItem: TBooleanField
      FieldName = 'BreakfastItem'
    end
    object m_ItemsBookKeepCode: TWideStringField
      FieldName = 'BookKeepCode'
      Size = 25
    end
    object m_ItemsNumberBase: TWideStringField
      FieldName = 'NumberBase'
      Size = 15
    end
    object m_ItemsStockItem: TBooleanField
      DefaultExpression = 'false'
      FieldName = 'StockItem'
    end
    object m_ItemsTotalStock: TIntegerField
      FieldName = 'TotalStock'
      OnGetText = m_ItemsTotalStockGetText
    end
    object m_ItemsAvailableStock: TIntegerField
      DisplayLabel = 'Available Stock'
      FieldKind = fkCalculated
      FieldName = 'AvailableStock'
      Calculated = True
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
    StorageName = 'Software\Roomer\FormStatus\Items'
    StorageType = stRegistry
    Left = 371
    Top = 264
  end
  object timFilter: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = timFilterTimer
    Left = 200
    Top = 304
  end
  object dsprices: TDataSource
    DataSet = kbmStockItemprices
    Left = 232
    Top = 144
  end
  object kbmStockItemprices: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'kbmStockItempricesIndex1'
        DescFields = 'fromdate'
        Fields = 'itemid;fromdate;'
        Options = [ixDescending]
      end>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.22.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = m_StockitemPricesBeforePost
    AfterPost = kbmStockItempricesAfterPost
    BeforeDelete = m_StockitemPricesBeforeDelete
    OnNewRecord = m_StockitemPricesNewRecord
    Left = 240
    Top = 200
    object kbmStockitemPricesID: TIntegerField
      FieldName = 'ID'
    end
    object kbmStockitemPricesitemID: TIntegerField
      FieldName = 'itemID'
    end
    object kbmStockitemPricesprice: TFloatField
      FieldName = 'price'
    end
    object kbmStockitemPricesfromdate: TDateTimeField
      FieldName = 'fromdate'
    end
  end
  object m_Availability: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Stockitem'
        DataType = ftInteger
      end
      item
        Name = 'InUse'
        DataType = ftInteger
      end
      item
        Name = 'UseDate'
        DataType = ftDate
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.22.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 104
    Top = 210
    object m_AvailabilityStockitem: TIntegerField
      FieldName = 'Stockitem'
    end
    object m_AvailabilityInUse: TIntegerField
      FieldName = 'InUse'
    end
    object m_AvailabilityUseDate: TDateField
      FieldName = 'UseDate'
    end
    object m_Availabilityavailable: TIntegerField
      FieldName = 'available'
    end
  end
end
