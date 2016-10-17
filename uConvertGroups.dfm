object frmConvertGroups: TfrmConvertGroups
  Left = 1107
  Top = 365
  Caption = 'Convert Groups'
  ClientHeight = 519
  ClientWidth = 444
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
    Top = 500
    Width = 444
    Height = 19
    Panels = <>
    SimplePanel = True
    SkinData.SkinSection = 'STATUSBAR'
    ExplicitWidth = 445
  end
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 444
    Height = 103
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 445
    DesignSize = (
      444
      103)
    object btnClear: TsSpeedButton
      Left = 265
      Top = 39
      Width = 71
      Height = 21
      Caption = 'Clear'
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 4
    end
    object cLabFilter: TsLabel
      Left = 16
      Top = 41
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Filter :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labFilterWarning: TsLabel
      Left = 1
      Top = 88
      Width = 442
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
      ExplicitWidth = 4
    end
    object btnClose: TsButton
      Left = 357
      Top = 4
      Width = 82
      Height = 25
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
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 207
      Height = 22
      Color = 3355443
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
    object btnOther: TsButton
      Left = 222
      Top = 4
      Width = 115
      Height = 25
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      Style = bsSplitButton
      TabOrder = 2
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDelete: TsButton
      Left = 150
      Top = 4
      Width = 69
      Height = 25
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 3
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 78
      Top = 4
      Width = 70
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
    object btnInsert: TsButton
      Left = 6
      Top = 4
      Width = 70
      Height = 25
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
    object chkActive: TsCheckBox
      Left = 56
      Top = 66
      Width = 279
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
    Top = 467
    Width = 444
    Height = 33
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 445
    DesignSize = (
      444
      33)
    object BtnOk: TsButton
      Left = 365
      Top = 3
      Width = 74
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
      ExplicitLeft = 366
    end
    object btnCancel: TsButton
      Left = 285
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 286
    end
  end
  object grData: TcxGrid
    Left = 0
    Top = 103
    Width = 444
    Height = 364
    Align = alClient
    TabOrder = 3
    LookAndFeel.NativeStyle = False
    ExplicitWidth = 445
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
      OnFocusedRecordChanged = tvDataFocusedRecordChanged
      DataController.DataSource = DS
      DataController.Filter.OnChanged = tvDataDataControllerFilterChanged
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnSortingChanged = tvDataDataControllerSortingChanged
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
      object tvDatacgCode: TcxGridDBColumn
        Caption = 'Code'
        DataBinding.FieldName = 'cgCode'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.ValidateOnEnter = True
        Properties.OnValidate = tvDatacgCodePropertiesValidate
        Width = 86
      end
      object tvDatacgDescription: TcxGridDBColumn
        Caption = 'Description'
        DataBinding.FieldName = 'cgDescription'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 270
      end
      object tvDataActive: TcxGridDBColumn
        DataBinding.FieldName = 'Active'
        Width = 45
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
    Indexes = <>
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 352
    Top = 128
    object m_cgCode: TWideStringField
      FieldName = 'cgCode'
      Size = 10
    end
    object m_cgDescription: TWideStringField
      FieldName = 'cgDescription'
      Size = 50
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 176
    Top = 224
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
      ReportDocument.CreationDate = 42657.581129062500000000
      BuiltInReportLink = True
    end
  end
end
