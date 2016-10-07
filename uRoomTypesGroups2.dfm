object frmRoomTypesGroups2: TfrmRoomTypesGroups2
  Left = 0
  Top = 0
  Caption = 'Room Classes'
  ClientHeight = 620
  ClientWidth = 853
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 853
    Height = 620
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sPanel1: TsPanel
      Left = 0
      Top = 0
      Width = 853
      Height = 89
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        853
        89)
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
        Left = 274
        Top = 39
        Width = 69
        Height = 20
        Caption = 'Clear'
        OnClick = btnClearClick
        SkinData.SkinSection = 'SPEEDBUTTON'
        Images = DImages.PngImageList1
        ImageIndex = 10
      end
      object btnDelete: TsButton
        Left = 205
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
        Left = 301
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
      object btnClose: TsButton
        Left = 763
        Top = 7
        Width = 80
        Height = 26
        Anchors = [akTop, akRight]
        Caption = 'Close'
        ImageIndex = 27
        Images = DImages.PngImageList1
        ModalResult = 8
        TabOrder = 2
        OnClick = btnCloseClick
        SkinData.SkinSection = 'BUTTON'
      end
      object edFilter: TsEdit
        Left = 56
        Top = 39
        Width = 216
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = edFilterChange
        SkinData.SkinSection = 'EDIT'
      end
      object btnInsert: TsButton
        Left = 13
        Top = 7
        Width = 90
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
        Left = 109
        Top = 7
        Width = 90
        Height = 26
        Hint = 'Edit current record'
        Caption = 'Edit'
        ImageIndex = 25
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = btnEditClick
        SkinData.SkinSection = 'BUTTON'
      end
      object chkActive: TCheckBox
        Left = 55
        Top = 63
        Width = 246
        Height = 17
        Caption = 'Active (if checked then just active are visible)'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
    end
    object sbMain: TsStatusBar
      Left = 0
      Top = 601
      Width = 853
      Height = 19
      Panels = <>
      SkinData.SkinSection = 'STATUSBAR'
    end
    object panBtn: TsPanel
      Left = 0
      Top = 568
      Width = 853
      Height = 33
      Align = alBottom
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        853
        33)
      object btnCancel: TsButton
        Left = 764
        Top = 4
        Width = 86
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
        Left = 676
        Top = 4
        Width = 86
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
      Width = 853
      Height = 479
      Align = alClient
      TabOrder = 3
      LookAndFeel.NativeStyle = False
      ExplicitTop = 87
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
          Caption = 'Id'
          DataBinding.FieldName = 'ID'
          Width = 52
        end
        object tvDataActive: TcxGridDBColumn
          DataBinding.FieldName = 'Active'
        end
        object tvDataColumn2: TcxGridDBColumn
          Caption = 'Rules'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = tvDataColumn2PropertiesButtonClick
          Width = 33
        end
        object tvDataCode: TcxGridDBColumn
          DataBinding.FieldName = 'Code'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.CharCase = ecUpperCase
          Properties.OnValidate = tvDataCodePropertiesValidate
        end
        object tvDataRATE_PLAN_TYPE: TcxGridDBColumn
          Caption = 'Rate plan type'
          DataBinding.FieldName = 'RATE_PLAN_TYPE'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.DropDownListStyle = lsFixedList
          Properties.DropDownRows = 16
          Properties.OnCloseUp = tvDataRATE_PLAN_TYPEPropertiesCloseUp
        end
        object tvDataTopClass: TcxGridDBColumn
          Caption = 'Top Class'
          DataBinding.FieldName = 'TopClass'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = tvDataTopClassPropertiesButtonClick
        end
        object tvDataOrderIndex: TcxGridDBColumn
          Caption = 'Order index'
          DataBinding.FieldName = 'OrderIndex'
        end
        object tvDataPriorityRule: TcxGridDBColumn
          Caption = 'Priority rule'
          DataBinding.FieldName = 'PriorityRule'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = tvDataPriorityRulePropertiesButtonClick
          Width = 135
        end
        object tvDataColumn1: TcxGridDBColumn
          Caption = 'Images'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.HideSelection = False
          Properties.OnButtonClick = tvDataColumn1PropertiesButtonClick
          Width = 60
        end
        object tvDataPackage: TcxGridDBColumn
          DataBinding.FieldName = 'Package'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = tvDataPackagePropertiesButtonClick
        end
        object tvDataDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 220
        end
        object tvDataDetailedDescriptionHtml: TcxGridDBColumn
          Caption = 'Html description'
          DataBinding.FieldName = 'DetailedDescriptionHtml'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = tvDataDetailedDescriptionHtmlPropertiesButtonClick
          Width = 110
        end
        object tvDataDetailedDescription: TcxGridDBColumn
          Caption = 'Long description'
          DataBinding.FieldName = 'DetailedDescription'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = tvDataDetailedDescriptionPropertiesButtonClick
          Width = 115
        end
        object tvDataBreakfastIncluded: TcxGridDBColumn
          Caption = 'Breakfast Incl'
          DataBinding.FieldName = 'BreakfastIncluded'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.OnEditValueChanged = tvDataBreakfastIncludedPropertiesEditValueChanged
          Width = 90
        end
        object tvDataHalfBoard: TcxGridDBColumn
          DataBinding.FieldName = 'HalfBoard'
          Width = 71
        end
        object tvDataFullBoard: TcxGridDBColumn
          DataBinding.FieldName = 'FullBoard'
          Width = 64
        end
        object tvDatanumGuests: TcxGridDBColumn
          Caption = 'Guests'
          DataBinding.FieldName = 'numGuests'
        end
        object tvDataNonRefundable: TcxGridDBColumn
          Caption = 'Non Refundable'
          DataBinding.FieldName = 'NonRefundable'
          Width = 110
        end
        object tvDataPAYMENTS_REQUIRED: TcxGridDBColumn
          Caption = 'Auto charge rules'
          DataBinding.FieldName = 'PAYMENTS_REQUIRED'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.ReadOnly = True
          Properties.OnButtonClick = tvDataPAYMENTS_REQUIREDPropertiesButtonClick
          Width = 100
        end
        object tvDataAutoChargeCreditcards: TcxGridDBColumn
          Caption = 'Auto Charge Creditcards'
          DataBinding.FieldName = 'AutoChargeCreditcards'
          Width = 169
        end
        object tvDataRateExtraBed: TcxGridDBColumn
          Caption = 'Rate Extra Bed'
          DataBinding.FieldName = 'RateExtraBed'
          Width = 111
        end
        object tvDataAvailabilityTypes: TcxGridDBColumn
          DataBinding.FieldName = 'AvailabilityTypes'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = tvDataAvailabilityTypesPropertiesButtonClick
          Visible = False
          Width = 100
        end
        object tvDataminGuests: TcxGridDBColumn
          Caption = 'Minimum Guests'
          DataBinding.FieldName = 'minGuests'
          PropertiesClassName = 'TcxSpinEditProperties'
          Width = 112
        end
        object tvDatamaxGuests: TcxGridDBColumn
          Caption = 'Max Guests'
          DataBinding.FieldName = 'maxGuests'
          PropertiesClassName = 'TcxSpinEditProperties'
        end
        object tvDatamaxChildren: TcxGridDBColumn
          Caption = 'Max Children'
          DataBinding.FieldName = 'maxChildren'
          PropertiesClassName = 'TcxSpinEditProperties'
          Width = 95
        end
        object tvDataMaxCount: TcxGridDBColumn
          Caption = 'Max rooms'
          DataBinding.FieldName = 'MaxCount'
          PropertiesClassName = 'TcxSpinEditProperties'
          Visible = False
        end
        object tvDatacolor: TcxGridDBColumn
          Caption = 'Color'
          DataBinding.FieldName = 'color'
          PropertiesClassName = 'TcxTextEditProperties'
          Visible = False
          Width = 133
        end
        object tvDatasendAvailability: TcxGridDBColumn
          Caption = 'Send Availability'
          DataBinding.FieldName = 'sendAvailability'
          Width = 102
        end
        object tvDatasendRate: TcxGridDBColumn
          Caption = 'send Rate'
          DataBinding.FieldName = 'sendRate'
          Width = 76
        end
        object tvDatasendStopSell: TcxGridDBColumn
          Caption = 'send StopSell'
          DataBinding.FieldName = 'sendStopSell'
          Width = 95
        end
        object tvDatasendMinStay: TcxGridDBColumn
          Caption = 'send MinStay'
          DataBinding.FieldName = 'sendMinStay'
          Width = 90
        end
        object tvDatadefRate: TcxGridDBColumn
          Caption = 'Default Rate'
          DataBinding.FieldName = 'defRate'
          PropertiesClassName = 'TcxCalcEditProperties'
          Width = 90
        end
        object tvDatadefStopSale: TcxGridDBColumn
          Caption = 'Default Stop Sale'
          DataBinding.FieldName = 'defStopSale'
          Width = 123
        end
        object tvDatadefAvailability: TcxGridDBColumn
          Caption = 'Default Availability'
          DataBinding.FieldName = 'defAvailability'
          PropertiesClassName = 'TcxSpinEditProperties'
          Width = 118
        end
        object tvDatadefMinStay: TcxGridDBColumn
          Caption = 'Default Min Stay'
          DataBinding.FieldName = 'defMinStay'
          PropertiesClassName = 'TcxSpinEditProperties'
          Width = 110
        end
        object tvDatadefMaxStay: TcxGridDBColumn
          Caption = 'Default Max Stay'
          DataBinding.FieldName = 'defMaxStay'
          Width = 104
        end
        object tvDatadefClosedToArrival: TcxGridDBColumn
          Caption = 'Default Closed To Arrival'
          DataBinding.FieldName = 'defClosedToArrival'
          Width = 130
        end
        object tvDatadefClosedToDeparture: TcxGridDBColumn
          Caption = 'Default Closed To Departure'
          DataBinding.FieldName = 'defClosedToDeparture'
          Width = 147
        end
        object tvDatadefMaxAvailability: TcxGridDBColumn
          Caption = 'Default Max Availability'
          DataBinding.FieldName = 'defMaxAvailability'
          PropertiesClassName = 'TcxSpinEditProperties'
          Width = 125
        end
        object tvDataconnectRateToMasterRate: TcxGridDBColumn
          Caption = 'Connect Rate To Master Rate'
          DataBinding.FieldName = 'connectRateToMasterRate'
          Width = 121
        end
        object tvDatamasterRateRateDeviation: TcxGridDBColumn
          Caption = 'Master Rate Deviation'
          DataBinding.FieldName = 'masterRateRateDeviation'
          Width = 111
        end
        object tvDataRateDeviationType: TcxGridDBColumn
          Caption = 'Rate Deviation Type'
          DataBinding.FieldName = 'RateDeviationType'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.Items.Strings = (
            'PERCENTAGE'
            'FIXED_AMOUNT')
          Width = 111
        end
        object tvDataconnectSingleUseRateToMasterRate: TcxGridDBColumn
          Caption = 'Connect Single Use Rate To MasterRate'
          DataBinding.FieldName = 'connectSingleUseRateToMasterRate'
          SortIndex = 0
          SortOrder = soAscending
          Width = 197
        end
        object tvDatamasterRateSingleUseRateDeviation: TcxGridDBColumn
          Caption = 'Single Use Rate Deviation'
          DataBinding.FieldName = 'masterRateSingleUseRateDeviation'
          Width = 128
        end
        object tvDatasingleUseRateDeviationType: TcxGridDBColumn
          Caption = 'Single Use Rate Deviation Type'
          DataBinding.FieldName = 'singleUseRateDeviationType'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.Items.Strings = (
            'PERCENTAGE'
            'FIXED_AMOUNT')
          Width = 155
        end
        object tvDataconnectAvailabilityToMasterRate: TcxGridDBColumn
          Caption = 'Connect Availability To MasterRate'
          DataBinding.FieldName = 'connectAvailabilityToMasterRate'
          Width = 185
        end
        object tvDataconnectStopSellToMasterRate: TcxGridDBColumn
          Caption = 'Connect Stop Sell To MasterRate'
          DataBinding.FieldName = 'connectStopSellToMasterRate'
          Width = 163
        end
        object tvDataconnectMinStayToMasterRate: TcxGridDBColumn
          Caption = 'Connect Min Stay To MasterRate'
          DataBinding.FieldName = 'connectMinStayToMasterRate'
          Width = 175
        end
        object tvDataconnectMaxStayToMasterRate: TcxGridDBColumn
          Caption = 'Connect Max Stay To MasterRate'
          DataBinding.FieldName = 'connectMaxStayToMasterRate'
          Width = 167
        end
        object tvDataconnectCOAToMasterRate: TcxGridDBColumn
          Caption = 'Connect COA To MasterRate'
          DataBinding.FieldName = 'connectCOAToMasterRate'
          Width = 144
        end
        object tvDataconnectCODToMasterRate: TcxGridDBColumn
          Caption = 'Connect COD To MasterRate'
          DataBinding.FieldName = 'connectCODToMasterRate'
          Width = 144
        end
        object tvDataconnectLOSToMasterRate: TcxGridDBColumn
          Caption = 'Connect LOS To MasterRate'
          DataBinding.FieldName = 'connectLOSToMasterRate'
          Width = 153
        end
      end
      object lvData: TcxGridLevel
        GridView = tvData
      end
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 30
    Top = 192
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      ImageIndex = 3
      OnClick = mnuiPrintClick
    end
    object mnuiAllowGridEdit: TMenuItem
      Caption = 'Allow grid edit'
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
    Left = 152
    Top = 192
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 96
    Top = 192
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
    AfterScroll = m_AfterScroll
    OnNewRecord = m_NewRecord
    Left = 208
    Top = 192
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
    object m_Code: TWideStringField
      FieldName = 'Code'
      Size = 10
    end
    object m_Description: TWideStringField
      DisplayWidth = 160
      FieldName = 'Description'
      Size = 160
    end
    object m_numGuests: TIntegerField
      FieldName = 'numGuests'
    end
    object m_BreakfastIncluded: TBooleanField
      FieldName = 'BreakfastIncluded'
    end
    object m_HalfBoard: TBooleanField
      FieldName = 'HalfBoard'
    end
    object m_FullBoard: TBooleanField
      FieldName = 'FullBoard'
    end
    object m_PriorityRule: TWideStringField
      FieldName = 'PriorityRule'
      Size = 50
    end
    object m_minGuests: TIntegerField
      FieldName = 'minGuests'
    end
    object m_maxGuests: TIntegerField
      FieldName = 'maxGuests'
    end
    object m_maxChildren: TIntegerField
      FieldName = 'maxChildren'
    end
    object m_MaxCount: TIntegerField
      FieldName = 'MaxCount'
    end
    object m_color: TWideStringField
      FieldName = 'color'
      Size = 50
    end
    object m_TopClass: TWideStringField
      FieldName = 'TopClass'
      Size = 10
    end
    object m_RATE_PLAN_TYPE: TWideStringField
      FieldName = 'RATE_PLAN_TYPE'
      Size = 15
    end
    object m_AvailabilityTypes: TWideStringField
      FieldName = 'AvailabilityTypes'
      Size = 150
    end
    object m_defAvailability: TIntegerField
      FieldName = 'defAvailability'
    end
    object m_defStopSale: TBooleanField
      FieldName = 'defStopSale'
    end
    object m_defRate: TFloatField
      FieldName = 'defRate'
    end
    object m_defMinStay: TIntegerField
      FieldName = 'defMinStay'
    end
    object m_defMaxStay: TIntegerField
      FieldName = 'defMaxStay'
    end
    object m_defClosedToArrival: TBooleanField
      FieldName = 'defClosedToArrival'
    end
    object m_defClosedToDeparture: TBooleanField
      FieldName = 'defClosedToDeparture'
    end
    object m_defMaxAvailability: TIntegerField
      FieldName = 'defMaxAvailability'
    end
    object m_Package: TWideStringField
      FieldName = 'Package'
    end
    object m_NonRefundable: TBooleanField
      FieldName = 'NonRefundable'
    end
    object m_AutoChargeCreditcards: TBooleanField
      FieldName = 'AutoChargeCreditcards'
    end
    object m_RateExtraBed: TFloatField
      FieldName = 'RateExtraBed'
    end
    object m_PhotoUri: TWideStringField
      DisplayWidth = 50
      FieldName = 'PhotoUri'
      Size = 255
    end
    object m_sendAvailability: TBooleanField
      FieldName = 'sendAvailability'
    end
    object m_sendRate: TBooleanField
      FieldName = 'sendRate'
    end
    object m_sendStopSell: TBooleanField
      FieldName = 'sendStopSell'
    end
    object m_sendMinStay: TBooleanField
      FieldName = 'sendMinStay'
    end
    object m_DetailedDescriptionHtml: TWideStringField
      FieldName = 'DetailedDescriptionHtml'
      Size = 4096
    end
    object m_DetailedDescription: TWideStringField
      FieldName = 'DetailedDescription'
      Size = 4096
    end
    object m_OrderIndex: TIntegerField
      FieldName = 'OrderIndex'
    end
    object m_connectRateToMasterRate: TBooleanField
      FieldName = 'connectRateToMasterRate'
    end
    object m_masterRateRateDeviation: TFloatField
      FieldName = 'masterRateRateDeviation'
    end
    object m_RateDeviationType: TWideStringField
      FieldName = 'RateDeviationType'
      Size = 15
    end
    object m_connectSingleUseRateToMasterRate: TBooleanField
      FieldName = 'connectSingleUseRateToMasterRate'
    end
    object m_masterRateSingleUseRateDeviation: TFloatField
      FieldName = 'masterRateSingleUseRateDeviation'
    end
    object m_singleUseRateDeviationType: TWideStringField
      FieldName = 'singleUseRateDeviationType'
      Size = 15
    end
    object m_connectAvailabilityToMasterRate: TBooleanField
      FieldName = 'connectAvailabilityToMasterRate'
    end
    object m_connectStopSellToMasterRate: TBooleanField
      FieldName = 'connectStopSellToMasterRate'
    end
    object m_connectMinStayToMasterRate: TBooleanField
      FieldName = 'connectMinStayToMasterRate'
    end
    object m_connectMaxStayToMasterRate: TBooleanField
      FieldName = 'connectMaxStayToMasterRate'
    end
    object m_connectCOAToMasterRate: TBooleanField
      FieldName = 'connectCOAToMasterRate'
    end
    object m_connectCODToMasterRate: TBooleanField
      FieldName = 'connectCODToMasterRate'
    end
    object m_connectLOSToMasterRate: TBooleanField
      FieldName = 'connectLOSToMasterRate'
    end
    object m_PAYMENTS_REQUIRED: TWideStringField
      FieldName = 'PAYMENTS_REQUIRED'
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
    StorageName = 'Software\Roomer\FormStatus\RoomClasses'
    StorageType = stRegistry
    Left = 710
    Top = 152
  end
end
