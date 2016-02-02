object frmStaffMembers2: TfrmStaffMembers2
  Left = 0
  Top = 0
  Caption = 'Staff'
  ClientHeight = 529
  ClientWidth = 780
  Color = clBtnFace
  Constraints.MinWidth = 470
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
    Width = 780
    Height = 68
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      780
      68)
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
      Left = 267
      Top = 39
      Width = 69
      Height = 20
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 10
      Images = DImages.PngImageList1
    end
    object btnOther: TsButton
      Left = 220
      Top = 8
      Width = 116
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
      Left = 691
      Top = 8
      Width = 79
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
      Width = 209
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
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
      Left = 4
      Top = 7
      Width = 70
      Height = 26
      Hint = 'Add new record'
      HelpContext = 6
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
      Left = 80
      Top = 7
      Width = 69
      Height = 26
      Hint = 'Edit current record'
      HelpContext = 6
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
      Left = 149
      Top = 7
      Width = 70
      Height = 26
      Hint = 'Delete current record'
      HelpContext = 6
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sbMain: TsStatusBar
    Left = 0
    Top = 510
    Width = 780
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 477
    Width = 780
    Height = 33
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      780
      33)
    object btnCancel: TsButton
      Left = 691
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
      Left = 603
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
    Top = 68
    Width = 780
    Height = 409
    Align = alClient
    TabOrder = 3
    LookAndFeel.NativeStyle = False
    object tvData: TcxGridDBBandedTableView
      OnDblClick = tvDataDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.HeaderAutoHeight = True
      Bands = <
        item
          Caption = 'Login'
          FixedKind = fkLeft
          Width = 123
        end
        item
          Caption = 'Name'
          FixedKind = fkLeft
          Width = 229
        end
        item
          Caption = 'Address'
        end
        item
          Caption = 'Contact'
        end
        item
          Caption = 'Language'
        end
        item
          Caption = 'Authorization'
        end>
      object tvDataID: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ID'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDataInitials: TcxGridDBBandedColumn
        Tag = 6
        DataBinding.FieldName = 'Initials'
        Width = 69
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDataPassword: TcxGridDBBandedColumn
        Tag = 6
        DataBinding.FieldName = 'Password'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.PasswordChar = '*'
        Visible = False
        Width = 72
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDataActive: TcxGridDBBandedColumn
        Tag = 6
        DataBinding.FieldName = 'Active'
        Width = 54
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvDataPmsOnly: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Only PMS'
        DataBinding.FieldName = 'PmsOnly'
        Width = 56
        Position.BandIndex = 5
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object tvDataStaffPID: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Personal Id'
        DataBinding.FieldName = 'StaffPID'
        Width = 81
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDataName: TcxGridDBBandedColumn
        Tag = 6
        DataBinding.FieldName = 'Name'
        Width = 121
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDataWindowsauth: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Windows Auth'
        DataBinding.FieldName = 'Windowsauth'
        Width = 54
        Position.BandIndex = 5
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object tvDataStaffType: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Auth Type'
        DataBinding.FieldName = 'StaffType'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataStaffTypePropertiesButtonClick
        Width = 64
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDataStaffType1: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Auth Type'
        DataBinding.FieldName = 'StaffType1'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataStaffType1PropertiesButtonClick
        Width = 64
        Position.BandIndex = 5
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDataStaffType2: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Auth Type'
        DataBinding.FieldName = 'StaffType2'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataStaffType2PropertiesButtonClick
        Width = 64
        Position.BandIndex = 5
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDataStaffType3: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Auth Type'
        DataBinding.FieldName = 'StaffType3'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataStaffType3PropertiesButtonClick
        Width = 64
        Position.BandIndex = 5
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvDataStaffType4: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Auth Type'
        DataBinding.FieldName = 'StaffType4'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataStaffType4PropertiesButtonClick
        Width = 64
        Position.BandIndex = 5
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvDataIPAddresses: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Allowed IP Addresses'
        DataBinding.FieldName = 'IPAddresses'
        Width = 120
        Position.BandIndex = 5
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object tvDataAddress1: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Address1'
        Width = 100
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDataAddress2: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Address2'
        Width = 100
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDataAddress3: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Address3'
        Width = 100
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDataAddress4: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Address4'
        Width = 100
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvDataCountry: TcxGridDBBandedColumn
        Tag = 6
        DataBinding.FieldName = 'Country'
        Width = 64
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDataStaffLanguage: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Language'
        DataBinding.FieldName = 'StaffLanguage'
        Width = 71
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDatatel1: TcxGridDBBandedColumn
        Tag = 6
        DataBinding.FieldName = 'tel1'
        Width = 100
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDatatel2: TcxGridDBBandedColumn
        Tag = 6
        DataBinding.FieldName = 'tel2'
        Width = 100
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDatafax: TcxGridDBBandedColumn
        Tag = 6
        Caption = 'Mobile'
        DataBinding.FieldName = 'fax'
        Width = 100
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDataActiveMember: TcxGridDBBandedColumn
        Tag = 6
        DataBinding.FieldName = 'ActiveMember'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 134
    Top = 56
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      ImageIndex = 3
      OnClick = mnuiPrintClick
    end
    object mnuiAllowGridEdit: TMenuItem
      Caption = 'Allow grid edit'
      Checked = True
      HelpContext = 2
      OnClick = mnuiAllowGridEditClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Export1: TMenuItem
      Caption = 'Export'
      HelpContext = 6
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
    Left = 208
    Top = 176
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
    StorageName = 'Software\Roomer\FormStatus\StaffMembers'
    StorageType = stRegistry
    Left = 366
    Top = 312
  end
  object m_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'Active'
        DataType = ftBoolean
      end
      item
        Name = 'StaffType1'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'StaffType2'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'StaffType3'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'StaffType4'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Initials'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Password'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Name'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Address1'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Address2'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Address3'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Address4'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'tel1'
        DataType = ftString
        Size = 31
      end
      item
        Name = 'tel2'
        DataType = ftString
        Size = 31
      end
      item
        Name = 'fax'
        DataType = ftString
        Size = 31
      end
      item
        Name = 'ActiveMember'
        DataType = ftBoolean
      end
      item
        Name = 'StaffType'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'StaffLanguage'
        DataType = ftInteger
      end
      item
        Name = 'StaffPID'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'IPAddresses'
        DataType = ftString
        Size = 254
      end
      item
        Name = 'PmsOnly'
        DataType = ftBoolean
      end
      item
        Name = 'Windowsauth'
        DataType = ftBoolean
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
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 168
    Top = 176
  end
end
