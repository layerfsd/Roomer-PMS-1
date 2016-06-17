object frmGuestProfiles: TfrmGuestProfiles
  Left = 0
  Top = 0
  Caption = 'Guest profiles'
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
  OnShow = FormShow
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
        TabOrder = 0
        OnChange = edFilterChange
        SkinData.SkinSection = 'EDIT'
      end
      object chkActive: TsCheckBox
        Left = 55
        Top = 63
        Width = 238
        Height = 20
        Caption = 'Active (if checked then just active are visible)'
        Checked = True
        State = cbChecked
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object sPanel2: TsPanel
        Left = 1
        Top = 1
        Width = 851
        Height = 34
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        SkinData.SkinSection = 'TRANSPARENT'
        object btnOther: TsButton
          AlignWithMargins = True
          Left = 411
          Top = 3
          Width = 134
          Height = 28
          Align = alLeft
          Caption = 'Other actions'
          DropDownMenu = mnuOther
          ImageIndex = 76
          Images = DImages.PngImageList1
          Style = bsSplitButton
          TabOrder = 0
          OnClick = btnOtherClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnMerge: TsButton
          AlignWithMargins = True
          Left = 309
          Top = 3
          Width = 96
          Height = 28
          Align = alLeft
          Caption = 'Merge'
          Enabled = False
          ImageIndex = 75
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnMergeClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnDelete: TsButton
          AlignWithMargins = True
          Left = 207
          Top = 3
          Width = 96
          Height = 28
          Align = alLeft
          Caption = 'Delete'
          ImageIndex = 24
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = btnDeleteClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnEdit: TsButton
          AlignWithMargins = True
          Left = 105
          Top = 3
          Width = 96
          Height = 28
          Hint = 'Edit current record'
          Align = alLeft
          Caption = 'Edit'
          ImageIndex = 25
          Images = DImages.PngImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = btnEditClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnInsert: TsButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 96
          Height = 28
          Hint = 'Add new record'
          Align = alLeft
          Caption = 'New'
          ImageIndex = 23
          Images = DImages.PngImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = btnInsertClick
          SkinData.SkinSection = 'BUTTON'
        end
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
        Left = 768
        Top = 2
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
        object tvData_SELECTED_ROW_: TcxGridDBColumn
          Caption = '[  ]'
          DataBinding.FieldName = '_SELECTED_ROW_'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.OnEditValueChanged = tvData_SELECTED_ROW_PropertiesEditValueChanged
          Width = 40
        end
        object tvDataRecId: TcxGridDBColumn
          DataBinding.FieldName = 'RecId'
          Visible = False
        end
        object tvDataID: TcxGridDBColumn
          DataBinding.FieldName = 'ID'
        end
        object tvDataMaleFemale: TcxGridDBColumn
          DataBinding.FieldName = 'MaleFemale'
        end
        object tvDataTitle: TcxGridDBColumn
          DataBinding.FieldName = 'Title'
        end
        object tvDataSocialSecurityNumber: TcxGridDBColumn
          Caption = 'Social security number'
          DataBinding.FieldName = 'SocialSecurityNumber'
          Width = 125
        end
        object tvDataFirstname: TcxGridDBColumn
          DataBinding.FieldName = 'Firstname'
        end
        object tvDataLastname: TcxGridDBColumn
          DataBinding.FieldName = 'Lastname'
        end
        object tvDataProfession: TcxGridDBColumn
          DataBinding.FieldName = 'Profession'
        end
        object tvDataNationality: TcxGridDBColumn
          DataBinding.FieldName = 'Nationality'
        end
        object tvDataDateOfBirth: TcxGridDBColumn
          DataBinding.FieldName = 'DateOfBirth'
        end
        object tvDataPassportNumber: TcxGridDBColumn
          DataBinding.FieldName = 'PassportNumber'
        end
        object tvDataPassportExpiry: TcxGridDBColumn
          DataBinding.FieldName = 'PassportExpiry'
        end
        object tvDataAddress1: TcxGridDBColumn
          DataBinding.FieldName = 'Address1'
        end
        object tvDataAddress2: TcxGridDBColumn
          DataBinding.FieldName = 'Address2'
        end
        object tvDataZip: TcxGridDBColumn
          DataBinding.FieldName = 'Zip'
        end
        object tvDataCity: TcxGridDBColumn
          DataBinding.FieldName = 'City'
        end
        object tvDataState: TcxGridDBColumn
          DataBinding.FieldName = 'State'
        end
        object tvDataCountry: TcxGridDBColumn
          DataBinding.FieldName = 'Country'
        end
        object tvDataTelLandLine: TcxGridDBColumn
          DataBinding.FieldName = 'TelLandLine'
        end
        object tvDataTelMobile: TcxGridDBColumn
          DataBinding.FieldName = 'TelMobile'
        end
        object tvDataEmail: TcxGridDBColumn
          DataBinding.FieldName = 'Email'
        end
        object tvDataWebsite: TcxGridDBColumn
          DataBinding.FieldName = 'Website'
        end
        object tvDataTwitter: TcxGridDBColumn
          DataBinding.FieldName = 'Twitter'
        end
        object tvDataLinkedIn: TcxGridDBColumn
          DataBinding.FieldName = 'LinkedIn'
        end
        object tvDataFacebookLink: TcxGridDBColumn
          Caption = 'Facebook link'
          DataBinding.FieldName = 'FacebookLink'
          Width = 244
        end
        object tvDataTripadvisorAccount: TcxGridDBColumn
          Caption = 'Tripadvisor account'
          DataBinding.FieldName = 'TripadvisorAccount'
          Width = 244
        end
        object tvDataSpouseName: TcxGridDBColumn
          DataBinding.FieldName = 'SpouseName'
        end
        object tvDataContactPerson: TcxGridDBColumn
          DataBinding.FieldName = 'ContactPerson'
        end
        object tvDataSpouseBirthdate: TcxGridDBColumn
          DataBinding.FieldName = 'SpouseBirthdate'
        end
        object tvDataCustomerCode: TcxGridDBColumn
          DataBinding.FieldName = 'CustomerCode'
        end
        object tvDataCompanyName: TcxGridDBColumn
          DataBinding.FieldName = 'CompanyName'
        end
        object tvDataCarLicensePlate: TcxGridDBColumn
          DataBinding.FieldName = 'CarLicensePlate'
        end
        object tvDataCompVATNumber: TcxGridDBColumn
          DataBinding.FieldName = 'CompVATNumber'
        end
        object tvDataCompFax: TcxGridDBColumn
          DataBinding.FieldName = 'CompFax'
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
    object mnuOnlyDuplicateTelNums: TMenuItem
      Caption = 'Show only duplicate telephone numbers'
      OnClick = mnuOnlyDuplicateTelNumsClick
    end
    object mnuOnlyDuplicates: TMenuItem
      Caption = 'Show only duplicate names'
      OnClick = mnuOnlyDuplicatesClick
    end
    object mnuOnlyDuplicateEmails: TMenuItem
      Caption = 'Show only duplicate email addresses'
      OnClick = mnuOnlyDuplicateEmailsClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      ImageIndex = 3
      OnClick = mnuiPrintClick
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
      BuiltInReportLink = True
    end
  end
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforeDelete = m_BeforeDelete
    AfterScroll = m_AfterScroll
    Left = 208
    Top = 192
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_MaleFemale: TWideStringField
      FieldName = 'MaleFemale'
      Size = 10
    end
    object m_Title: TWideStringField
      FieldName = 'Title'
      Size = 10
    end
    object m_Firstname: TWideStringField
      DisplayWidth = 40
      FieldName = 'Firstname'
      Size = 100
    end
    object m_Lastname: TWideStringField
      DisplayWidth = 40
      FieldName = 'Lastname'
      Size = 100
    end
    object m_Profession: TWideStringField
      DisplayWidth = 40
      FieldName = 'Profession'
      Size = 100
    end
    object m_Nationality: TWideStringField
      FieldName = 'Nationality'
      Size = 2
    end
    object m_DateOfBirth: TDateField
      FieldName = 'DateOfBirth'
    end
    object m_PassportNumber: TWideStringField
      FieldName = 'PassportNumber'
      Size = 10
    end
    object m_PassportExpiry: TDateField
      FieldName = 'PassportExpiry'
    end
    object m_Address1: TWideStringField
      DisplayWidth = 40
      FieldName = 'Address1'
      Size = 100
    end
    object m_Address2: TWideStringField
      DisplayWidth = 40
      FieldName = 'Address2'
      Size = 100
    end
    object m_Zip: TWideStringField
      DisplayWidth = 40
      FieldName = 'Zip'
      Size = 100
    end
    object m_City: TWideStringField
      DisplayWidth = 40
      FieldName = 'City'
      Size = 100
    end
    object m_State: TWideStringField
      DisplayWidth = 40
      FieldName = 'State'
      Size = 100
    end
    object m_Country: TWideStringField
      FieldName = 'Country'
      Size = 100
    end
    object m_TelLandLine: TWideStringField
      FieldName = 'TelLandLine'
      Size = 40
    end
    object m_TelMobile: TWideStringField
      FieldName = 'TelMobile'
      Size = 40
    end
    object m_Email: TWideStringField
      DisplayWidth = 40
      FieldName = 'Email'
      Size = 100
    end
    object m_Website: TWideStringField
      DisplayWidth = 40
      FieldName = 'Website'
      Size = 100
    end
    object m_Twitter: TWideStringField
      DisplayWidth = 40
      FieldName = 'Twitter'
      Size = 100
    end
    object m_LinkedIn: TWideStringField
      DisplayWidth = 40
      FieldName = 'LinkedIn'
      Size = 100
    end
    object m_SpouseName: TWideStringField
      DisplayWidth = 40
      FieldName = 'SpouseName'
      Size = 100
    end
    object m_ContactPerson: TWideStringField
      DisplayWidth = 40
      FieldName = 'ContactPerson'
      Size = 100
    end
    object m_SpouseBirthdate: TDateField
      FieldName = 'SpouseBirthdate'
    end
    object m_CustomerCode: TWideStringField
      FieldName = 'CustomerCode'
      Size = 15
    end
    object m_CompanyName: TWideStringField
      DisplayWidth = 40
      FieldName = 'CompanyName'
      Size = 100
    end
    object m_CarLicensePlate: TWideStringField
      FieldName = 'CarLicensePlate'
    end
    object m_SocialSecurityNumber: TWideStringField
      FieldName = 'SocialSecurityNumber'
      Size = 45
    end
    object m_FacebookLink: TWideStringField
      FieldName = 'FacebookLink'
      Size = 225
    end
    object m_TripadvisorAccount: TWideStringField
      FieldName = 'TripadvisorAccount'
      Size = 225
    end
    object m_CompVATNumber: TWideStringField
      FieldName = 'CompVATNumber'
      Size = 45
    end
    object m_CompFax: TWideStringField
      FieldName = 'CompFax'
      Size = 40
    end
    object m__SELECTED_ROW_: TBooleanField
      FieldName = '_SELECTED_ROW_'
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
    StorageName = 'Software\Roomer\FormStatus\GuestProfiles'
    StorageType = stRegistry
    Left = 710
    Top = 152
  end
  object timFilter: TTimer
    Enabled = False
    Interval = 500
    OnTimer = timFilterTimer
    Left = 400
    Top = 336
  end
end
