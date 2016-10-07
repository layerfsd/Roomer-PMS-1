inherited frmCleaningNotes: TfrmCleaningNotes
  Caption = 'Cleaning notes'
  ClientHeight = 458
  ClientWidth = 975
  Constraints.MinWidth = 450
  Font.Height = -11
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 991
  ExplicitHeight = 497
  PixelsPerInch = 96
  TextHeight = 13
  inherited dxStatusBar: TdxStatusBar
    Top = 438
    Width = 975
    ExplicitTop = 438
    ExplicitWidth = 975
  end
  object sPanel1: TsPanel [1]
    Left = 0
    Top = 0
    Width = 975
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
      Left = 273
      Top = 39
      Width = 63
      Height = 20
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 4
    end
    object btnDelete: TsButton
      Left = 199
      Top = 8
      Width = 90
      Height = 25
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 295
      Top = 8
      Width = 135
      Height = 25
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      Style = bsSplitButton
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 215
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
      Left = 6
      Top = 8
      Width = 90
      Height = 25
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
      Left = 102
      Top = 8
      Width = 91
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
    object chkActive: TsCheckBox
      Left = 55
      Top = 63
      Width = 246
      Height = 17
      Caption = 'Active (if checked then just active are visible)'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = chkActiveClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object panBtn: TsPanel [2]
    Left = 0
    Top = 406
    Width = 975
    Height = 32
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      975
      32)
    object btnCancel: TsButton
      Left = 896
      Top = 4
      Width = 75
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
      Left = 818
      Top = 4
      Width = 75
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
  object grData: TcxGrid [3]
    Left = 0
    Top = 89
    Width = 975
    Height = 317
    Align = alClient
    Constraints.MinWidth = 440
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
      OnCellDblClick = tvDataCellDblClick
      DataController.DataSource = dsCleaningNotes
      DataController.Filter.AutoDataSetFilter = True
      DataController.KeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnSortingChanged = tvDataDataControllerSortingChanged
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.IncSearch = True
      OptionsData.Appending = True
      OptionsData.CancelOnExit = False
      OptionsData.DeletingConfirmation = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      OptionsView.Indicator = True
      Styles.StyleSheet = cxssRoomerGridTableView
      object tvDataRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object tvDataID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        MinWidth = 50
        Width = 50
      end
      object tvDataactive: TcxGridDBColumn
        Caption = 'Active'
        DataBinding.FieldName = 'active'
        MinWidth = 50
        Width = 52
      end
      object tvDataonlyWhenRoomIsDirty: TcxGridDBColumn
        Caption = 'Only when dirty'
        DataBinding.FieldName = 'onlyWhenRoomIsDirty'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Width = 55
      end
      object tvDataserviceType: TcxGridDBColumn
        Caption = 'Service type'
        DataBinding.FieldName = 'serviceType'
        MinWidth = 50
        Width = 82
      end
      object tvDataonceType: TcxGridDBColumn
        Caption = 'When'
        DataBinding.FieldName = 'onceType'
        OnCustomDrawCell = tvDataonceTypeCustomDrawCell
        MinWidth = 50
      end
      object tvDatainterval: TcxGridDBColumn
        Caption = 'Days'
        DataBinding.FieldName = 'interval'
        OnCustomDrawCell = tvDataintervalCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 50
        Width = 71
      end
      object tvDataminimumDays: TcxGridDBColumn
        Caption = 'Min stay'
        DataBinding.FieldName = 'minimumDays'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 50
        Width = 63
      end
      object tvDatamessage: TcxGridDBColumn
        Caption = 'Cleaning note'
        DataBinding.FieldName = 'message'
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  inherited cxsrRoomerStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
    inherited dxssRoomerGridReportLink: TdxGridReportLinkStyleSheet
      BuiltIn = True
    end
    inherited cxssRoomerGridTableView: TcxGridTableViewStyleSheet
      BuiltIn = True
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 382
    Top = 24
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
  object dsCleaningNotes: TDataSource
    DataSet = m_CleaningNotes
    Left = 168
    Top = 144
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 80
    Top = 136
    object prLink_grData: TdxGridReportLink
      Active = True
      Component = grData
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 5080
      PrinterPage.GrayShading = True
      PrinterPage.Header = 3303
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageSize.X = 210820
      PrinterPage.PageSize.Y = 297180
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 42650.665394074070000000
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clBlack
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Arial'
      ReportTitle.Font.Style = [fsBold]
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      OptionsSize.AutoWidth = True
      ScaleFonts = False
      StyleRepository = cxsrRoomerStyleRepository
      Styles.StyleSheet = dxssRoomerGridReportLink
      BuiltInReportLink = True
    end
  end
  object m_CleaningNotes: TdxMemData
    Indexes = <
      item
        SortOptions = []
      end>
    SortOptions = [soCaseInsensitive]
    BeforePost = m_CleaningNotesBeforePost
    AfterPost = m_CleaningNotesAfterPost
    BeforeDelete = m_CleaningNotesBeforeDelete
    AfterScroll = m_CleaningNotesAfterScroll
    OnNewRecord = m_CleaningNotesNewRecord
    OnFilterRecord = m_CleaningNotesFilterRecord
    Left = 168
    Top = 194
    object m_CleaningNotesID: TIntegerField
      FieldName = 'ID'
    end
    object m_CleaningNotesActive: TBooleanField
      FieldName = 'active'
    end
    object m_CleaningNotesserviceType: TWideStringField
      FieldName = 'serviceType'
      Size = 10
    end
    object m_CleaningNotesonceType: TWideStringField
      FieldName = 'onceType'
      Size = 25
    end
    object m_CleaningNotesinterval: TIntegerField
      FieldName = 'interval'
    end
    object m_CleaningNotesminimumDays: TIntegerField
      FieldName = 'minimumDays'
    end
    object m_CleaningNotesmessage: TWideStringField
      FieldName = 'message'
      Size = 255
    end
    object m_CleaningNotesonlyWhenRoomIsDirty: TBooleanField
      FieldName = 'onlyWhenRoomIsDirty'
    end
  end
  object timFilter: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = timFilterTimer
    Left = 200
    Top = 304
  end
end
