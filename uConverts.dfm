object frmConverts: TfrmConverts
  Left = 953
  Top = 265
  ActiveControl = btnOther
  Caption = 'Alter Table'
  ClientHeight = 490
  ClientWidth = 514
  Color = clBtnFace
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbMain: TsStatusBar
    Left = 0
    Top = 438
    Width = 514
    Height = 19
    Panels = <>
    SimplePanel = True
    SkinData.SkinSection = 'STATUSBAR'
  end
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 107
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      514
      107)
    object btnClear: TsSpeedButton
      Left = 271
      Top = 39
      Width = 67
      Height = 21
      Caption = 'Clear'
      OnClick = edFilterClickBtn
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 4
    end
    object labFilterWarning: TsLabel
      Left = 1
      Top = 92
      Width = 512
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
    object btnInsert: TsButton
      Left = 7
      Top = 7
      Width = 71
      Height = 25
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnInsertClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 80
      Top = 7
      Width = 70
      Height = 25
      Hint = 'Edit current record'
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnEditClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDelete: TsButton
      Left = 151
      Top = 7
      Width = 70
      Height = 25
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 2
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 223
      Top = 7
      Width = 115
      Height = 25
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      Style = bsSplitButton
      TabOrder = 3
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 213
      Height = 22
      Color = 3355443
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15724527
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
    object chkActive: TsCheckBox
      Left = 56
      Top = 66
      Width = 279
      Height = 19
      Caption = 'Active (if checked then just active are visible else all)'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = chkActiveClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object btnClose: TsButton
      Left = 427
      Top = 7
      Width = 80
      Height = 25
      Hint = 'Close form'
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 11
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnCloseClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 457
    Width = 514
    Height = 33
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      514
      33)
    object btnCancel: TsButton
      Left = 352
      Top = 4
      Width = 75
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
      Left = 432
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
  object grData: TcxGrid
    Left = 0
    Top = 107
    Width = 514
    Height = 331
    Align = alClient
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
      OnFocusedRecordChanged = tvDataFocusedRecordChanged
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
      object tvDatacvType: TcxGridDBColumn
        Caption = 'Type'
        DataBinding.FieldName = 'cvType'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 8
            Kind = bkGlyph
          end>
        Properties.Images = DImages.PngImageList1
        Properties.ReadOnly = False
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = tvDatacvTypePropertiesButtonClick
        Options.ShowEditButtons = isebAlways
        Width = 90
      end
      object tvDatacvFrom: TcxGridDBColumn
        Caption = 'Roomer value'
        DataBinding.FieldName = 'cvFrom'
        Width = 165
      end
      object tvDatacvTo: TcxGridDBColumn
        Caption = 'Convert to'
        DataBinding.FieldName = 'cvTo'
        Width = 194
      end
      object tvDataID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Visible = False
      end
      object tvDataActive: TcxGridDBColumn
        DataBinding.FieldName = 'Active'
        Width = 39
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
    Left = 344
    Top = 160
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_cvType: TWideStringField
      FieldName = 'cvType'
      Size = 10
    end
    object m_cvFrom: TWideStringField
      FieldName = 'cvFrom'
      Size = 50
    end
    object m_cvTo: TWideStringField
      FieldName = 'cvTo'
      Size = 50
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 240
    Top = 192
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
    Left = 392
    Top = 168
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
      ReportDocument.CreationDate = 42657.581022581020000000
      BuiltInReportLink = True
    end
  end
end
