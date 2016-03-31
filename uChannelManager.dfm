object frmChannelManager: TfrmChannelManager
  Left = 988
  Top = 281
  BorderIcons = [biSystemMenu]
  Caption = 'Channel Managers'
  ClientHeight = 477
  ClientWidth = 672
  Color = clBtnFace
  Constraints.MinWidth = 600
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbMain: TStatusBar
    Left = 0
    Top = 458
    Width = 672
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 89
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      672
      89)
    object labChannelManager: TsLabel
      Left = 252
      Top = 21
      Width = 5
      Height = 16
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
    end
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
      Left = 262
      Top = 39
      Width = 74
      Height = 21
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object btnClose: TsButton
      Left = 581
      Top = 5
      Width = 84
      Height = 26
      Hint = 'Close form'
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 11
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnCloseClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 221
      Top = 6
      Width = 115
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
    object Button1: TsButton
      Left = 364
      Top = 5
      Width = 140
      Height = 26
      Hint = 'Add new record'
      Caption = 'Payment Matrix'
      ImageIndex = 113
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object Button2: TsButton
      Left = 364
      Top = 32
      Width = 140
      Height = 26
      Hint = 'Add new record'
      Caption = 'Confirmation emails'
      ImageIndex = 113
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button2Click
      SkinData.SkinSection = 'BUTTON'
    end
    object Button3: TsButton
      Left = 364
      Top = 59
      Width = 140
      Height = 25
      Hint = 'Add new record'
      Caption = 'Hotel notification emails'
      ImageIndex = 113
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Button3Click
      SkinData.SkinSection = 'BUTTON'
    end
    object btnInsert: TsButton
      Left = 7
      Top = 7
      Width = 70
      Height = 24
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
      Left = 78
      Top = 7
      Width = 69
      Height = 24
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
    object btnDelete: TsButton
      Left = 149
      Top = 7
      Width = 69
      Height = 24
      Hint = 'Delete current record'
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 205
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 423
    Width = 672
    Height = 35
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      672
      35)
    object BtnOk: TsButton
      Left = 487
      Top = 4
      Width = 84
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
      Left = 575
      Top = 4
      Width = 86
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object grData: TcxGrid
    Left = 0
    Top = 89
    Width = 672
    Height = 334
    Align = alClient
    TabOrder = 3
    LevelTabs.Slants.Kind = skCutCorner
    LookAndFeel.NativeStyle = False
    object tvData: TcxGridDBTableView
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
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      OnCellDblClick = tvDataCellDblClick
      DataController.DataSource = DS
      DataController.Filter.OnChanged = tvDataDataControllerFilterChanged
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoInsertOnNewItemRowFocusing]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnSortingChanged = tvDataDataControllerSortingChanged
      NewItemRow.Visible = True
      OptionsBehavior.IncSearch = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object tvDataRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object tvDatacode: TcxGridDBColumn
        DataBinding.FieldName = 'code'
      end
      object tvDataDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Width = 220
      end
      object tvDatachannels: TcxGridDBColumn
        Caption = 'Channels'
        DataBinding.FieldName = 'schannels'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDatachannelsPropertiesButtonClick
      end
      object tvDatadirectConnection: TcxGridDBColumn
        DataBinding.FieldName = 'directConnection'
        Visible = False
      end
      object tvDataactive: TcxGridDBColumn
        DataBinding.FieldName = 'active'
      end
      object tvDatamaintenanceDays: TcxGridDBColumn
        DataBinding.FieldName = 'maintenanceDays'
      end
      object tvDatawebserviceURI: TcxGridDBColumn
        DataBinding.FieldName = 'webserviceURI'
        Width = 120
      end
      object tvDatawebserviceUsername: TcxGridDBColumn
        Caption = 'Service Username'
        DataBinding.FieldName = 'webserviceUsername'
        Width = 120
      end
      object tvDatawebservicePassword: TcxGridDBColumn
        Caption = 'Service Password'
        DataBinding.FieldName = 'webservicePassword'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.EchoMode = eemPassword
        Properties.PasswordChar = '*'
        Width = 120
      end
      object tvDatawebserviceHotelCode: TcxGridDBColumn
        Caption = 'Hotel Code'
        DataBinding.FieldName = 'webserviceHotelCode'
        Width = 100
      end
      object tvDataweserviceRequestor: TcxGridDBColumn
        Caption = 'Requestor'
        DataBinding.FieldName = 'weserviceRequestor'
        Width = 100
      end
      object tvDatasendRate: TcxGridDBColumn
        Caption = 'Send Rate'
        DataBinding.FieldName = 'sendRate'
        Width = 84
      end
      object tvDatasendAvailability: TcxGridDBColumn
        Caption = 'Send Availability'
        DataBinding.FieldName = 'sendAvailability'
        Width = 118
      end
      object tvDatasendStopSell: TcxGridDBColumn
        Caption = 'Send Stop Sell'
        DataBinding.FieldName = 'sendStopSell'
        Width = 107
      end
      object tvDatasendMinStay: TcxGridDBColumn
        Caption = 'Send Min Stay'
        DataBinding.FieldName = 'sendMinStay'
        Width = 92
      end
      object tvDataadminUsername: TcxGridDBColumn
        Caption = 'Admin Username'
        DataBinding.FieldName = 'adminUsername'
        Width = 120
      end
      object tvDataadminPassword: TcxGridDBColumn
        Caption = 'Admin Password'
        DataBinding.FieldName = 'adminPassword'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.EchoMode = eemPassword
        Properties.PasswordChar = '*'
        Width = 120
      end
      object tvDataId: TcxGridDBColumn
        DataBinding.FieldName = 'Id'
        Visible = False
      end
    end
    object lvData: TcxGridLevel
      Caption = 'Grid'
      GridView = tvData
      Options.DetailTabsPosition = dtpTop
    end
  end
  object mnuOther: TPopupMenu
    Left = 424
    Top = 32
    object mnuiPrint: TMenuItem
      Caption = 'Print'
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
      object mnuiGridToExcel: TMenuItem
        Caption = 'Grid to Excel'
        OnClick = mnuiGridToExcelClick
      end
      object mnuiGridToHtml: TMenuItem
        Caption = 'Grid to HTML'
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
    Left = 520
    Top = 232
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 464
    Top = 168
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
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforeEdit = m_BeforeEdit
    BeforePost = m_BeforePost
    AfterPost = m_AfterPost
    OnNewRecord = m_NewRecord
    Left = 424
    Top = 176
    object m_code: TWideStringField
      FieldName = 'code'
    end
    object m_Description: TWideStringField
      FieldName = 'Description'
      Size = 45
    end
    object m_schannels: TWideStringField
      FieldName = 'schannels'
      Size = 255
    end
    object m_maintenanceDays: TIntegerField
      FieldName = 'maintenanceDays'
    end
    object m_webserviceUsername: TWideStringField
      FieldName = 'webserviceUsername'
      Size = 128
    end
    object m_webservicePassword: TWideStringField
      FieldName = 'webservicePassword'
      Size = 128
    end
    object m_webserviceHotelCode: TWideStringField
      FieldName = 'webserviceHotelCode'
      Size = 16
    end
    object m_weserviceRequestor: TWideStringField
      FieldName = 'weserviceRequestor'
      Size = 16
    end
    object m_adminUsername: TWideStringField
      FieldName = 'adminUsername'
      Size = 128
    end
    object m_adminPassword: TWideStringField
      FieldName = 'adminPassword'
      Size = 128
    end
    object m_Id: TIntegerField
      FieldName = 'Id'
    end
    object m_webserviceURI: TWideStringField
      FieldName = 'webserviceURI'
      Size = 255
    end
    object m_active: TBooleanField
      FieldName = 'active'
    end
    object m_sendRate: TBooleanField
      FieldName = 'sendRate'
    end
    object m_sendAvailability: TBooleanField
      FieldName = 'sendAvailability'
    end
    object m_sendStopSell: TBooleanField
      FieldName = 'sendStopSell'
    end
    object m_sendMinStay: TBooleanField
      FieldName = 'sendMinStay'
    end
    object m_directConnection: TBooleanField
      FieldName = 'directConnection'
    end
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
      end>
    StorageName = 'Software\Roomer\FormStatus\ChannelManagers'
    StorageType = stRegistry
    Left = 584
    Top = 176
  end
end
