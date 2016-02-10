object frmCountryGroups: TfrmCountryGroups
  Left = 988
  Top = 281
  BorderIcons = [biSystemMenu]
  Caption = 'Countrygroups'
  ClientHeight = 522
  ClientWidth = 560
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
    Top = 503
    Width = 560
    Height = 19
    Panels = <>
    SimplePanel = True
    SkinData.SkinSection = 'STATUSBAR'
    ExplicitWidth = 486
  end
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 560
    Height = 81
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 486
    object labFilterWarning: TsLabel
      Left = 1
      Top = 66
      Width = 4
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = '-'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnClear: TsSpeedButton
      Left = 274
      Top = 39
      Width = 72
      Height = 21
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 4
    end
    object cLabFilter: TsLabel
      Left = 12
      Top = 41
      Width = 38
      Height = 16
      Alignment = taRightJustify
      Caption = 'Filter :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnInsert: TsButton
      Left = 5
      Top = 4
      Width = 90
      Height = 26
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 101
      Top = 4
      Width = 90
      Height = 26
      Hint = 'Edit current record'
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDelete: TsButton
      Left = 197
      Top = 4
      Width = 90
      Height = 26
      Hint = 'Delete current record'
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 293
      Top = 4
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
      TabOrder = 3
      OnClick = btnOtherClick
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 216
      Height = 24
      Color = 3355443
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 468
    Width = 560
    Height = 35
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 486
    DesignSize = (
      560
      35)
    object BtnOk: TsButton
      Left = 375
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 16
      ModalResult = 1
      TabOrder = 0
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 301
    end
    object btnCancel: TsButton
      Left = 464
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 4
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 390
    end
  end
  object grData: TcxGrid
    Left = 0
    Top = 81
    Width = 560
    Height = 387
    Align = alClient
    TabOrder = 3
    LevelTabs.Slants.Kind = skCutCorner
    LookAndFeel.NativeStyle = False
    ExplicitWidth = 486
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
      object tvDataCountryGroup: TcxGridDBColumn
        Caption = 'Group'
        DataBinding.FieldName = 'CountryGroup'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.AutoSelect = False
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 5
        Properties.ValidateOnEnter = True
        Properties.OnValidate = tvDataCountryGroupPropertiesValidate
        Options.Editing = False
      end
      object tvDataIslGroupName: TcxGridDBColumn
        Caption = 'Name'
        DataBinding.FieldName = 'IslGroupName'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 128
      end
      object tvDataGroupName: TcxGridDBColumn
        Caption = 'English name'
        DataBinding.FieldName = 'GroupName'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 146
      end
      object tvDataOrderIndex: TcxGridDBColumn
        Caption = 'Order'
        DataBinding.FieldName = 'OrderIndex'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.AutoSelect = False
        Properties.MaxValue = 9999.000000000000000000
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
    Left = 496
    Top = 160
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 440
    Top = 112
    object prLink_grData: TdxGridReportLink
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
    object m_CountryGroup: TWideStringField
      FieldName = 'CountryGroup'
      Size = 5
    end
    object m_GroupName: TWideStringField
      FieldName = 'GroupName'
      Size = 50
    end
    object m_IslGroupName: TWideStringField
      FieldName = 'IslGroupName'
      Size = 50
    end
    object m_OrderIndex: TIntegerField
      FieldName = 'OrderIndex'
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
    StorageName = 'Software\Roomer\FormStatus\CountryGroups'
    StorageType = stRegistry
    Left = 288
    Top = 248
  end
end
