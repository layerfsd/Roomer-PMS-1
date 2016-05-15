object frmCustomers2: TfrmCustomers2
  Left = 0
  Top = 0
  Caption = 'Customers'
  ClientHeight = 562
  ClientWidth = 861
  Color = clBtnFace
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
  object sSplitter1: TsSplitter
    Left = 0
    Top = 414
    Width = 861
    Height = 10
    Cursor = crVSplit
    Align = alBottom
    MinSize = 50
    ShowGrip = True
    SkinData.SkinSection = 'SPLITTER'
    ExplicitTop = 541
    ExplicitWidth = 943
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 861
    Height = 89
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object cLabFilter: TsLabel
      Left = 15
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
      Left = 278
      Top = 39
      Width = 58
      Height = 20
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object btnOther: TsButton
      Left = 293
      Top = 7
      Width = 134
      Height = 26
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      Style = bsSplitButton
      TabOrder = 0
      OnClick = btnOtherClick
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 52
      Top = 39
      Width = 224
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
    object btnInsert: TsButton
      Left = 5
      Top = 7
      Width = 90
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
      Left = 101
      Top = 7
      Width = 90
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
    object sButton1: TsButton
      Left = 197
      Top = 7
      Width = 90
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
    object DBEdit1: TDBEdit
      Left = 616
      Top = 9
      Width = 121
      Height = 21
      DataField = 'Customer'
      DataSource = DS
      TabOrder = 5
      Visible = False
      OnChange = DBEdit1Change
    end
    object chkActive: TsCheckBox
      Left = 52
      Top = 64
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
    Top = 543
    Width = 861
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 510
    Width = 861
    Height = 33
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      861
      33)
    object btnCancel: TsButton
      Left = 772
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
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 684
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 424
    Width = 861
    Height = 86
    Align = alBottom
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    object sSplitter2: TsSplitter
      Left = 261
      Top = 1
      Width = 8
      Height = 84
      MinSize = 50
      ShowGrip = True
      SkinData.SkinSection = 'SPLITTER'
      ExplicitHeight = 122
    end
    object grMemo: TcxGrid
      Left = 1
      Top = 1
      Width = 260
      Height = 84
      Align = alLeft
      Constraints.MinWidth = 260
      TabOrder = 0
      LookAndFeel.NativeStyle = False
      object tvMemo: TcxGridDBTableView
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
        FilterBox.CustomizeDialog = False
        FilterBox.Visible = fvNever
        OnFocusedRecordChanged = tvDataFocusedRecordChanged
        DataController.DataSource = mMemoDS
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.OnSortingChanged = tvDataDataControllerSortingChanged
        OptionsBehavior.AlwaysShowEditor = True
        OptionsBehavior.IncSearch = True
        OptionsData.Appending = True
        OptionsData.CancelOnExit = False
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvMemoRecId: TcxGridDBColumn
          DataBinding.FieldName = 'RecId'
          Visible = False
        end
        object tvMemoActive: TcxGridDBColumn
          DataBinding.FieldName = 'Active'
        end
        object tvMemoCustomer: TcxGridDBColumn
          DataBinding.FieldName = 'Customer'
          Visible = False
        end
        object tvMemoDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 204
        end
        object tvMemoPreference: TcxGridDBColumn
          DataBinding.FieldName = 'Preference'
          Visible = False
        end
        object tvMemoID: TcxGridDBColumn
          DataBinding.FieldName = 'ID'
        end
      end
      object lvMemo: TcxGridLevel
        GridView = tvMemo
      end
    end
    object DBMemo1: TDBMemo
      Left = 269
      Top = 1
      Width = 591
      Height = 84
      Align = alClient
      DataField = 'Preference'
      DataSource = mMemoDS
      TabOrder = 1
    end
  end
  object sPanel3: TsPanel
    Left = 0
    Top = 89
    Width = 861
    Height = 325
    Align = alClient
    TabOrder = 4
    SkinData.SkinSection = 'PANEL'
    object grData: TcxGrid
      Left = 1
      Top = 1
      Width = 859
      Height = 323
      Align = alClient
      PopupMenu = mnuOther
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
        OptionsView.Indicator = True
        object tvDataRecId: TcxGridDBColumn
          DataBinding.FieldName = 'RecId'
          Visible = False
        end
        object tvDataID: TcxGridDBColumn
          DataBinding.FieldName = 'ID'
          Visible = False
        end
        object tvDataCustomer: TcxGridDBColumn
          Caption = 'CustomerID'
          DataBinding.FieldName = 'Customer'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.CharCase = ecUpperCase
          Properties.OnValidate = tvDataCustomerPropertiesValidate
          Width = 115
        end
        object tvDataPID: TcxGridDBColumn
          Caption = 'Personal ID'
          DataBinding.FieldName = 'PID'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = '...'
              Default = True
              Kind = bkText
            end>
          Properties.OnButtonClick = tvDataPIDPropertiesButtonClick
          Width = 128
        end
        object tvDataColumn1: TcxGridDBColumn
          Caption = 'IMG'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = tvDataColumn1PropertiesButtonClick
          Width = 25
        end
        object tvDataSurname: TcxGridDBColumn
          Caption = 'Full name'
          DataBinding.FieldName = 'Surname'
          Width = 120
        end
        object tvDataName: TcxGridDBColumn
          DataBinding.FieldName = 'Name'
          Visible = False
          Width = 150
        end
        object tvDataCustomerType: TcxGridDBColumn
          DataBinding.FieldName = 'CustomerType'
          Visible = False
          Width = 90
        end
        object tvDatastaytaxincluted: TcxGridDBColumn
          DataBinding.FieldName = 'staytaxincluted'
        end
        object tvDataTravelAgency: TcxGridDBColumn
          DataBinding.FieldName = 'TravelAgency'
        end
        object tvDataAddress1: TcxGridDBColumn
          DataBinding.FieldName = 'Address1'
          Width = 120
        end
        object tvDataAddress2: TcxGridDBColumn
          DataBinding.FieldName = 'Address2'
          Width = 120
        end
        object tvDataAddress3: TcxGridDBColumn
          Caption = 'Postal code '
          DataBinding.FieldName = 'Address3'
          Width = 120
        end
        object tvDataAddress4: TcxGridDBColumn
          Caption = 'City'
          DataBinding.FieldName = 'Address4'
          Width = 120
        end
        object tvDataCountry: TcxGridDBColumn
          DataBinding.FieldName = 'Country'
          Visible = False
        end
        object tvDataCountryName: TcxGridDBColumn
          DataBinding.FieldName = 'CountryName'
          Width = 100
        end
        object tvDataTel1: TcxGridDBColumn
          DataBinding.FieldName = 'Tel1'
          Width = 70
        end
        object tvDataTel2: TcxGridDBColumn
          DataBinding.FieldName = 'Tel2'
          Width = 70
        end
        object tvDataFAX: TcxGridDBColumn
          DataBinding.FieldName = 'FAX'
          Width = 70
        end
        object tvDataEmailAddress: TcxGridDBColumn
          DataBinding.FieldName = 'EmailAddress'
          Width = 100
        end
        object tvDataHomepage: TcxGridDBColumn
          DataBinding.FieldName = 'Homepage'
          Width = 100
        end
        object tvDataContactPerson: TcxGridDBColumn
          DataBinding.FieldName = 'ContactPerson'
          Width = 100
        end
        object tvDatapcCode: TcxGridDBColumn
          DataBinding.FieldName = 'pcCode'
        end
        object tvDataRatePlanId: TcxGridDBColumn
          DataBinding.FieldName = 'RatePlanId'
        end
        object tvDataCurrency: TcxGridDBColumn
          DataBinding.FieldName = 'Currency'
        end
        object tvDataDiscountPercent: TcxGridDBColumn
          Caption = 'Disc'
          DataBinding.FieldName = 'DiscountPercent'
          PropertiesClassName = 'TcxCalcEditProperties'
          Width = 46
        end
        object tvDatadele: TcxGridDBColumn
          DataBinding.FieldName = 'dele'
          Visible = False
        end
        object tvDataCustomerTypeDescription: TcxGridDBColumn
          Caption = 'Market segment'
          DataBinding.FieldName = 'CustomerTypeDescription'
          Width = 100
        end
        object tvDatapcID: TcxGridDBColumn
          DataBinding.FieldName = 'pcID'
        end
        object tvDataActive: TcxGridDBColumn
          DataBinding.FieldName = 'Active'
          Width = 54
        end
        object tvDatanotes: TcxGridDBColumn
          DataBinding.FieldName = 'notes'
          PropertiesClassName = 'TcxMemoProperties'
        end
      end
      object lvData: TcxGridLevel
        GridView = tvData
      end
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 398
    Top = 32
    object C2: TMenuItem
      Caption = 'Create guest-profile from currently selected customer'
      OnClick = C2Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
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
    Left = 304
    Top = 280
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 248
    Top = 280
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
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    AfterScroll = m_AfterScroll
    OnNewRecord = m_NewRecord
    Left = 272
    Top = 176
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
    object m_Customer: TWideStringField
      FieldName = 'Customer'
      Size = 15
    end
    object m_PID: TWideStringField
      FieldName = 'PID'
      Size = 15
    end
    object m_Surname: TWideStringField
      FieldName = 'Surname'
      Size = 100
    end
    object m_Name: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
    object m_CustomerType: TWideStringField
      FieldName = 'CustomerType'
      Size = 5
    end
    object m_Address1: TWideStringField
      FieldName = 'Address1'
      Size = 100
    end
    object m_Address2: TWideStringField
      FieldName = 'Address2'
      Size = 100
    end
    object m_Address3: TWideStringField
      FieldName = 'Address3'
      Size = 100
    end
    object m_Address4: TWideStringField
      FieldName = 'Address4'
      Size = 100
    end
    object m_Country: TWideStringField
      FieldName = 'Country'
      Size = 2
    end
    object m_Tel1: TWideStringField
      FieldName = 'Tel1'
      Size = 15
    end
    object m_Tel2: TWideStringField
      FieldName = 'Tel2'
      Size = 2
    end
    object m_FAX: TWideStringField
      FieldName = 'FAX'
      Size = 15
    end
    object m_EmailAddress: TWideStringField
      FieldName = 'EmailAddress'
      Size = 100
    end
    object m_Homepage: TWideStringField
      FieldName = 'Homepage'
      Size = 100
    end
    object m_ContactPerson: TWideStringField
      FieldName = 'ContactPerson'
      Size = 100
    end
    object m_TravelAgency: TBooleanField
      FieldName = 'TravelAgency'
    end
    object m_Currency: TWideStringField
      FieldName = 'Currency'
      Size = 5
    end
    object m_DiscountPercent: TFloatField
      FieldName = 'DiscountPercent'
    end
    object m_dele: TWideStringField
      FieldName = 'dele'
      Size = 1
    end
    object m_pcID: TIntegerField
      FieldName = 'pcID'
    end
    object m_CountryName: TWideStringField
      FieldName = 'CountryName'
      Size = 50
    end
    object m_CustomerTypeDescription: TWideStringField
      FieldName = 'CustomerTypeDescription'
      Size = 30
    end
    object m_pcCode: TWideStringField
      FieldName = 'pcCode'
      Size = 10
    end
    object m_staytaxincluted: TBooleanField
      FieldName = 'staytaxincluted'
    end
    object m_notes: TMemoField
      FieldName = 'notes'
      BlobType = ftMemo
    end
    object m_RatePlanId: TIntegerField
      FieldName = 'RatePlanId'
    end
  end
  object mMemo_: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 120
    Top = 112
    object IntegerField1: TIntegerField
      FieldName = 'ID'
    end
    object BooleanField1: TBooleanField
      FieldName = 'Active'
    end
    object WideStringField1: TWideStringField
      FieldName = 'Customer'
      Size = 15
    end
    object mMemo_Description: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object mMemo_Preference: TMemoField
      FieldName = 'Preference'
      BlobType = ftMemo
    end
  end
  object mMemoDS: TDataSource
    DataSet = Memo_
    Left = 472
    Top = 368
  end
  object Memo_: TRoomerDataSet
    BeforeDelete = Memo_BeforeDelete
    AfterDelete = Memo_AfterDelete
    OnNewRecord = Memo_NewRecord
    CommandText = ''
    CommandType = cmdUnknown
    Parameters = <>
    DataActive = False
    RoomerStoreUri = 'http://localhost:8080/services/'
    RoomerUri = 'http://mobile.roomerpms.com:8080/services/'
    RoomerEntitiesUri = 'http://mobile.roomerpms.com:8080/services/entities/'
    RoomerDatasetsUri = 'http://mobile.roomerpms.com:8080/services/datasets/'
    SessionLengthSeconds = 0
    Left = 544
    Top = 368
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
    StorageName = 'Software\Roomer\FormStatus\Customers'
    StorageType = stRegistry
    Left = 710
    Top = 152
  end
end
