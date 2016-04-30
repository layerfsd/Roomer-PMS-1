object frmPhoneRates: TfrmPhoneRates
  Left = 2497
  Top = 261
  Caption = 'Phone rates'
  ClientHeight = 461
  ClientWidth = 794
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbMain: TsStatusBar
    Left = 0
    Top = 442
    Width = 794
    Height = 19
    Panels = <>
    SimplePanel = True
    SkinData.SkinSection = 'STATUSBAR'
  end
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 794
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sLabel1: TsLabel
      Left = 17
      Top = 43
      Width = 38
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Filter : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnClear: TsSpeedButton
      Left = 253
      Top = 39
      Width = 67
      Height = 21
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object btnDelete: TsButton
      Left = 181
      Top = 7
      Width = 82
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
      Left = 269
      Top = 7
      Width = 144
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
    object btnInsert: TsButton
      Left = 6
      Top = 7
      Width = 81
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
      Left = 93
      Top = 7
      Width = 82
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
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 195
      Height = 22
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4473924
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
    object chkActive: TsCheckBox
      Left = 57
      Top = 64
      Width = 278
      Height = 19
      Caption = 'Active (if checked then just active are visible else all)'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = chkActiveClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 409
    Width = 794
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      794
      33)
    object btnCancel: TsButton
      Left = 706
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
      Left = 618
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
    Width = 794
    Height = 320
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 3
    LookAndFeel.NativeStyle = False
    object tvData: TcxGridDBTableView
      OnDblClick = tvDataDblClick
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
      OptionsData.Deleting = False
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object tvDataRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object tvDataIdentification: TcxGridDBColumn
        DataBinding.FieldName = 'Identification'
      end
      object tvDataDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
      end
      object tvDataminuteRate: TcxGridDBColumn
        Caption = 'Minute rate'
        DataBinding.FieldName = 'minuteRate'
        Width = 77
      end
      object tvDataminimumCost: TcxGridDBColumn
        Caption = 'Minimum amount'
        DataBinding.FieldName = 'minimumCost'
        Width = 89
      end
      object tvDataID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Visible = False
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object m_: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 352
    Top = 128
    object m_Identification: TWideStringField
      FieldName = 'Identification'
    end
    object m_Description: TWideStringField
      DisplayWidth = 70
      FieldName = 'Description'
      Size = 70
    end
    object m_minuteRate: TFloatField
      FieldName = 'minuteRate'
    end
    object m_minimumCost: TFloatField
      FieldName = 'minimumCost'
    end
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 88
    Top = 168
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
      ReportDocument.CreationDate = 42490.533673043980000000
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
    StorageName = 'Software\Roomer\FormStatus\PhoneRates'
    StorageType = stRegistry
    Left = 232
    Top = 176
  end
end
