object frmDynamicPricing: TfrmDynamicPricing
  Left = 0
  Top = 0
  Caption = 'Dynamic rates rules'
  ClientHeight = 627
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1092
    Height = 100
    Align = alTop
    Constraints.MinWidth = 450
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1092
      100)
    object labFilterWarning: TsLabel
      Left = 1
      Top = 86
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
      Left = 92
      Top = 40
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
      Left = 322
      Top = 38
      Width = 71
      Height = 48
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object sLabel1: TsLabel
      Left = 25
      Top = 67
      Width = 98
      Height = 13
      Alignment = taRightJustify
      Caption = 'Manager / Channel :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnOther: TsButton
      Left = 278
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
      Left = 129
      Top = 38
      Width = 187
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
      Left = 64
      Top = 8
      Width = 70
      Height = 24
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
      Left = 136
      Top = 8
      Width = 69
      Height = 24
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
    object btnDelete: TsButton
      Left = 208
      Top = 8
      Width = 69
      Height = 24
      Hint = 'Delete current record'
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object cbxChannelManagers: TsComboBox
      Left = 129
      Top = 65
      Width = 105
      Height = 21
      Alignment = taLeftJustify
      VerticalAlignment = taAlignTop
      Style = csDropDownList
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 6
      OnCloseUp = cbxChannelManagersCloseUp
    end
    object cbxChannels: TsComboBox
      Left = 240
      Top = 65
      Width = 76
      Height = 21
      Alignment = taLeftJustify
      VerticalAlignment = taAlignTop
      Style = csDropDownList
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 7
      OnCloseUp = cbxChannelManagersCloseUp
    end
  end
  object sbMain: TsStatusBar
    Left = 0
    Top = 608
    Width = 1092
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 578
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
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object pnlGridHolder: TsPanel
    Left = 0
    Top = 100
    Width = 1092
    Height = 478
    Align = alClient
    TabOrder = 3
    object grData: TcxGrid
      Left = 47
      Top = 1
      Width = 1044
      Height = 476
      Align = alClient
      TabOrder = 0
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
        object tvDataROOMTYPEGROUP_CODE: TcxGridDBColumn
          Caption = 'Rate code'
          DataBinding.FieldName = 'ROOMTYPEGROUP_CODE'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = tvDataROOMTYPEGROUP_CODEPropertiesButtonClick
        end
        object tvDataRate_Name: TcxGridDBColumn
          Caption = 'Rate description'
          DataBinding.FieldName = 'Rate_Name'
          Width = 208
        end
        object tvDataCHANNEL_ID: TcxGridDBColumn
          Caption = 'Channel'
          DataBinding.FieldName = 'CHANNEL_ID'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.DropDownListStyle = lsFixedList
          Properties.DropDownRows = 16
          Properties.OnCloseUp = tvDataCHANNEL_IDPropertiesCloseUp
          Width = 63
        end
        object tvDataChannelName: TcxGridDBColumn
          Caption = 'Channel Name'
          DataBinding.FieldName = 'ChannelName'
          Width = 163
        end
        object tvDataCHANNEL_MANAGER_ID: TcxGridDBColumn
          Caption = 'Ch Manager'
          DataBinding.FieldName = 'CHANNEL_MANAGER_ID'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.DropDownListStyle = lsFixedList
          Properties.OnCloseUp = tvDataCHANNEL_MANAGER_IDPropertiesCloseUp
          Width = 80
        end
        object tvDataChannelManagerName: TcxGridDBColumn
          Caption = 'Channel Manager Name'
          DataBinding.FieldName = 'ChannelManagerName'
          Width = 169
        end
        object tvDataSTART_DATE_RANGE: TcxGridDBColumn
          Caption = 'Start date'
          DataBinding.FieldName = 'START_DATE_RANGE'
          PropertiesClassName = 'TcxDateEditProperties'
        end
        object tvDataEND_DATE_RANGE: TcxGridDBColumn
          Caption = 'End date'
          DataBinding.FieldName = 'END_DATE_RANGE'
          PropertiesClassName = 'TcxDateEditProperties'
        end
        object tvDataMIN_AVAIL: TcxGridDBColumn
          Caption = 'Min availability'
          DataBinding.FieldName = 'MIN_AVAIL'
          Width = 87
        end
        object tvDataMAX_AVAIL: TcxGridDBColumn
          Caption = 'Max availability'
          DataBinding.FieldName = 'MAX_AVAIL'
          Width = 83
        end
        object tvDataRULE_PRIORITY: TcxGridDBColumn
          Caption = 'Priority'
          DataBinding.FieldName = 'RULE_PRIORITY'
        end
        object tvDataVAL: TcxGridDBColumn
          Caption = 'Rate'
          DataBinding.FieldName = 'VAL'
        end
        object tvDataAPPLICATION_STRATEGY: TcxGridDBColumn
          Caption = 'Strategy'
          DataBinding.FieldName = 'APPLICATION_STRATEGY'
        end
        object tvDataHOTEL_ID: TcxGridDBColumn
          DataBinding.FieldName = 'HOTEL_ID'
          Visible = False
        end
      end
      object lvData: TcxGridLevel
        GridView = tvData
      end
    end
    object pnlButtons: TsPanel
      Left = 1
      Top = 1
      Width = 46
      Height = 476
      Align = alLeft
      TabOrder = 1
      object sButton1: TsButton
        Left = 8
        Top = 32
        Width = 27
        Height = 25
        Caption = 'sButton1'
        ImageIndex = 1
        Images = DImages.cxImagesSmallExtra
        TabOrder = 0
      end
      object sButton2: TsButton
        Left = 8
        Top = 63
        Width = 27
        Height = 25
        Caption = 'sButton1'
        ImageIndex = 0
        Images = DImages.cxImagesSmallExtra
        TabOrder = 1
      end
    end
  end
  object mnuOther: TPopupMenu
    Left = 78
    Top = 160
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
    OnNewRecord = m_NewRecord
    Left = 120
    Top = 152
    object m_ROOMTYPEGROUP_CODE: TWideStringField
      FieldName = 'ROOMTYPEGROUP_CODE'
      Size = 10
    end
    object m_Rate_Name: TWideStringField
      FieldName = 'Rate_Name'
      Size = 100
    end
    object m_CHANNEL_MANAGER_ID: TWideStringField
      FieldName = 'CHANNEL_MANAGER_ID'
      Size = 50
    end
    object m_ChannelManagerName: TWideStringField
      FieldName = 'ChannelManagerName'
      Size = 50
    end
    object m_CHANNEL_ID: TWideStringField
      FieldName = 'CHANNEL_ID'
      Size = 50
    end
    object m_ChannelName: TWideStringField
      FieldName = 'ChannelName'
      Size = 50
    end
    object m_START_DATE_RANGE: TDateField
      FieldName = 'START_DATE_RANGE'
    end
    object m_END_DATE_RANGE: TDateField
      FieldName = 'END_DATE_RANGE'
    end
    object m_MIN_AVAIL: TIntegerField
      FieldName = 'MIN_AVAIL'
    end
    object m_MAX_AVAIL: TIntegerField
      FieldName = 'MAX_AVAIL'
    end
    object m_RULE_PRIORITY: TIntegerField
      FieldName = 'RULE_PRIORITY'
    end
    object m_VAL: TFloatField
      FieldName = 'VAL'
    end
    object m_APPLICATION_STRATEGY: TWideStringField
      FieldName = 'APPLICATION_STRATEGY'
      Size = 25
    end
    object m_HOTEL_ID: TWideStringField
      FieldName = 'HOTEL_ID'
      Size = 10
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
    StorageName = 'Software\Roomer\FormStatus\DynamicRateRules'
    StorageType = stRegistry
    Left = 200
    Top = 280
  end
end
