object frmChannels: TfrmChannels
  Left = 0
  Top = 0
  Caption = 'Channels'
  ClientHeight = 500
  ClientWidth = 1092
  Color = clBtnFace
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
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
    Width = 1092
    Height = 89
    Align = alTop
    Constraints.MinWidth = 450
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1092
      89)
    object labFilterWarning: TsLabel
      Left = 1
      Top = 75
      Width = 1090
      Height = 13
      Align = alBottom
      Alignment = taCenter
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitWidth = 4
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
      Left = 265
      Top = 39
      Width = 71
      Height = 20
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object btnOther: TsButton
      Left = 221
      Top = 8
      Width = 115
      Height = 25
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      Style = bsSplitButton
      TabOrder = 0
      OnClick = btnOtherClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnClose: TsButton
      Left = 1002
      Top = 8
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 8
      TabOrder = 1
      OnClick = btnCloseClick
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 206
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
    object Button1: TsButton
      Left = 342
      Top = 8
      Width = 140
      Height = 25
      Hint = 'Add new record'
      Caption = 'Payment Matrix'
      ImageIndex = 113
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object Button2: TsButton
      Left = 342
      Top = 34
      Width = 140
      Height = 25
      Hint = 'Add new record'
      Caption = 'Confirmation emails'
      ImageIndex = 113
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Button2Click
      SkinData.SkinSection = 'BUTTON'
    end
    object Button3: TsButton
      Left = 342
      Top = 60
      Width = 140
      Height = 25
      Hint = 'Add new record'
      Caption = 'Hotel notification emails'
      ImageIndex = 113
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Button3Click
      SkinData.SkinSection = 'BUTTON'
    end
    object btnInsert: TsButton
      Left = 7
      Top = 9
      Width = 70
      Height = 24
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = btnInsertClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 79
      Top = 9
      Width = 69
      Height = 24
      Hint = 'Edit current record'
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnEditClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDelete: TsButton
      Left = 151
      Top = 9
      Width = 69
      Height = 24
      Hint = 'Delete current record'
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sbMain: TsStatusBar
    Left = 0
    Top = 481
    Width = 1092
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 451
    Width = 1092
    Height = 30
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1092
      30)
    object btnCancel: TsButton
      Left = 1003
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
      Left = 915
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
    Top = 89
    Width = 1092
    Height = 362
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
      OptionsView.HeaderAutoHeight = True
      OptionsView.Indicator = True
      object tvDataRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object tvDataID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Visible = False
      end
      object tvDatachannelManagerId: TcxGridDBColumn
        Caption = 'Code'
        DataBinding.FieldName = 'channelManagerId'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
      end
      object tvDatadirectConnection: TcxGridDBColumn
        Caption = 'Direct Connection'
        DataBinding.FieldName = 'directConnection'
        Width = 97
      end
      object tvDataname: TcxGridDBColumn
        Caption = 'Channel name'
        DataBinding.FieldName = 'name'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 200
      end
      object tvDatacolor: TcxGridDBColumn
        Caption = 'Color'
        DataBinding.FieldName = 'color'
        PropertiesClassName = 'TcxColorComboBoxProperties'
        Properties.CustomColors = <>
        Options.ShowEditButtons = isebAlways
        Width = 40
      end
      object tvDataroomClasses: TcxGridDBColumn
        Caption = 'Room Classes'
        DataBinding.FieldName = 'roomClasses'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataroomClassesPropertiesButtonClick
        Width = 220
      end
      object tvDataactivePlanCode: TcxGridDBColumn
        Caption = 'Plan Code'
        DataBinding.FieldName = 'activePlanCode'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataactivePlanCodePropertiesButtonClick
      end
      object tvDataratesExcludingTaxes: TcxGridDBColumn
        Caption = 'Rates Excl Taxes'
        DataBinding.FieldName = 'ratesExcludingTaxes'
        Width = 50
      end
      object tvDataminAlotment: TcxGridDBColumn
        Caption = 'Min Allot'
        DataBinding.FieldName = 'minAlotment'
        PropertiesClassName = 'TcxSpinEditProperties'
        Width = 72
      end
      object tvDatadefaultAvailability: TcxGridDBColumn
        Caption = 'Def Availability'
        DataBinding.FieldName = 'defaultAvailability'
        PropertiesClassName = 'TcxSpinEditProperties'
        Width = 100
      end
      object tvDatadefaultPricePP: TcxGridDBColumn
        Caption = 'Def Price/Person'
        DataBinding.FieldName = 'defaultPricePP'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.ImmediateDropDownWhenKeyPressed = True
        Width = 110
      end
      object tvDataActive: TcxGridDBColumn
        DataBinding.FieldName = 'Active'
        Width = 54
      end
      object tvDatamarketSegment: TcxGridDBColumn
        Caption = 'Market'
        DataBinding.FieldName = 'marketSegment'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDatamarketSegmentPropertiesButtonClick
        Width = 64
      end
      object tvDatacurrencyId: TcxGridDBColumn
        Caption = 'curr Id'
        DataBinding.FieldName = 'currencyId'
        Visible = False
        Width = 60
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
        Width = 88
      end
      object tvDatamanagedByChannelManager: TcxGridDBColumn
        Caption = 'Channel Manager'
        DataBinding.FieldName = 'managedByChannelManager'
        Width = 120
      end
      object tvDataCHANNEL_ARRANGES_PAYMENT: TcxGridDBColumn
        Caption = 'Channel arranges payment'
        DataBinding.FieldName = 'CHANNEL_ARRANGES_PAYMENT'
        Width = 153
      end
      object tvDatadefaultChannel: TcxGridDBColumn
        Caption = 'Is Default'
        DataBinding.FieldName = 'defaultChannel'
        Width = 82
      end
      object tvDatapush: TcxGridDBColumn
        Caption = 'Push'
        DataBinding.FieldName = 'push'
        Width = 49
      end
      object tvDatacustomerId: TcxGridDBColumn
        Caption = 'Customer'
        DataBinding.FieldName = 'customerId'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDatacustomerIdPropertiesButtonClick
      end
      object tvDatarateRoundingType: TcxGridDBColumn
        Caption = 'Rate Rounding'
        DataBinding.FieldName = 'RateRoundingText'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'No rounding'
          'Round to nearest whole number'
          'Round up to whole number'
          'Round down to whole number'
          'Round to 1 decimal'
          'Round to 2 decimals'
          'Round to 3 decimals')
        Width = 148
      end
      object tvDatacompensationPercentage: TcxGridDBColumn
        Caption = 'Compen- sation %'
        DataBinding.FieldName = 'compensationPercentage'
        Width = 53
      end
      object tvDatahotelsBookingEngine: TcxGridDBColumn
        Caption = 'Is Hotel owned'
        DataBinding.FieldName = 'hotelsBookingEngine'
        Width = 54
      end
      object tvDatarateRoundingType1: TcxGridDBColumn
        DataBinding.FieldName = 'rateRoundingType'
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object mnuOther: TPopupMenu
    Left = 38
    Top = 152
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
    Left = 368
    Top = 288
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 368
    Top = 224
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
    Left = 120
    Top = 152
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
    object m_name: TWideStringField
      FieldName = 'name'
      Size = 35
    end
    object m_channelManagerId: TWideStringField
      FieldName = 'channelManagerId'
      Size = 10
    end
    object m_minAlotment: TIntegerField
      FieldName = 'minAlotment'
    end
    object m_defaultAvailability: TIntegerField
      FieldName = 'defaultAvailability'
    end
    object m_defaultPricePP: TFloatField
      FieldName = 'defaultPricePP'
    end
    object m_marketSegment: TWideStringField
      FieldName = 'marketSegment'
    end
    object m_currencyId: TIntegerField
      FieldName = 'currencyId'
    end
    object m_roomClasses: TWideStringField
      DisplayWidth = 2096
      FieldName = 'roomClasses'
      Size = 2096
    end
    object m_Currency: TWideStringField
      FieldName = 'Currency'
      Size = 5
    end
    object m_managedByChannelManager: TBooleanField
      FieldName = 'managedByChannelManager'
    end
    object m_default: TBooleanField
      DisplayLabel = 'default'
      FieldName = 'defaultChannel'
    end
    object m_push: TBooleanField
      FieldName = 'push'
    end
    object m_customerId: TIntegerField
      FieldName = 'customerId'
    end
    object m_color: TWideStringField
      FieldName = 'color'
      Size = 50
    end
    object m_ratesExcludingTaxes: TBooleanField
      FieldName = 'ratesExcludingTaxes'
    end
    object m_rateRoundingType: TIntegerField
      FieldName = 'rateRoundingType'
    end
    object m_compensationPercentage: TFloatField
      FieldName = 'compensationPercentage'
    end
    object m_hotelsBookingEngine: TBooleanField
      FieldName = 'hotelsBookingEngine'
    end
    object m_RateRoundingText: TStringField
      FieldName = 'RateRoundingText'
      Size = 30
    end
    object m_CHANNEL_ARRANGES_PAYMENT: TBooleanField
      FieldName = 'CHANNEL_ARRANGES_PAYMENT'
    end
    object m_directConnection: TBooleanField
      FieldName = 'directConnection'
    end
    object m_activePlanCode: TIntegerField
      FieldName = 'activePlanCode'
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
    StorageName = 'Software\Roomer\FormStatus\Channels'
    StorageType = stRegistry
    Left = 200
    Top = 280
  end
end
