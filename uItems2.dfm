object frmItems2: TfrmItems2
  Left = 0
  Top = 0
  Caption = 'Sales Items'
  ClientHeight = 663
  ClientWidth = 761
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
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 761
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
      OnClick = btnOtherClick
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
      Width = 242
      Height = 17
      Caption = 'Active (if checked then just active are visible'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = chkActiveClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object sbMain: TsStatusBar
    Left = 0
    Top = 644
    Width = 761
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 612
    Width = 761
    Height = 32
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      761
      32)
    object btnCancel: TsButton
      Left = 682
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
      Left = 604
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
    Width = 761
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
      DataController.DataSource = DS
      DataController.Filter.AutoDataSetFilter = True
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
      object tvDataPrice: TcxGridDBColumn
        DataBinding.FieldName = 'Price'
        PropertiesClassName = 'TcxCalcEditProperties'
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
            Kind = bkText
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
    end
    object lvData: TcxGridLevel
      GridView = tvData
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
  object DS: TDataSource
    DataSet = m_
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
  object m_: TdxMemData
    Indexes = <>
    SortOptions = [soCaseInsensitive]
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    OnFilterRecord = m_FilterRecord
    Left = 256
    Top = 200
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
    object m_Iyem: TWideStringField
      FieldName = 'Item'
    end
    object m_Description: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object m_Price: TFloatField
      FieldName = 'Price'
    end
    object m_Itemtype: TWideStringField
      FieldName = 'Itemtype'
    end
    object m_AccountKey: TWideStringField
      FieldName = 'AccountKey'
      Size = 50
    end
    object m_MinibarItem: TBooleanField
      FieldName = 'MinibarItem'
    end
    object m_SystemItem: TBooleanField
      FieldName = 'SystemItem'
    end
    object m_RoomRentitem: TBooleanField
      FieldName = 'RoomRentitem'
    end
    object m_ReservationItem: TBooleanField
      FieldName = 'ReservationItem'
    end
    object m_Currency: TWideStringField
      FieldName = 'Currency'
      Size = 3
    end
    object m_Hide: TBooleanField
      FieldName = 'Hide'
    end
    object m_BreakfastItem: TBooleanField
      FieldName = 'BreakfastItem'
    end
    object m_BookKeepCode: TWideStringField
      FieldName = 'BookKeepCode'
      Size = 25
    end
    object m_NumberBase: TWideStringField
      FieldName = 'NumberBase'
      Size = 15
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
end
