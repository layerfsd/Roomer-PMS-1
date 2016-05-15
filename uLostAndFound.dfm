object frmLostAndFound: TfrmLostAndFound
  Left = 0
  Top = 0
  Caption = 'Lost and found'
  ClientHeight = 615
  ClientWidth = 911
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 911
    Height = 97
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
      Left = 262
      Top = 39
      Width = 74
      Height = 21
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object btnOther: TsButton
      Left = 383
      Top = 7
      Width = 135
      Height = 26
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      Style = bsSplitButton
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object btnInsert: TsButton
      Left = 6
      Top = 7
      Width = 90
      Height = 26
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnInsertClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 102
      Top = 7
      Width = 91
      Height = 26
      Hint = 'Edit current record'
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnEditClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDelete: TsButton
      Left = 199
      Top = 7
      Width = 90
      Height = 26
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 3
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 56
      Top = 39
      Width = 205
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = edFilterChange
      SkinData.SkinSection = 'EDIT'
    end
    object btnPivgrRequestsExcel: TsButton
      Left = 292
      Top = 8
      Width = 88
      Height = 25
      Caption = 'Excel'
      ImageIndex = 132
      Images = DImages.PngImageList1
      TabOrder = 5
      OnClick = mnuiGridToExcelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object chkActive: TsCheckBox
      Left = 56
      Top = 66
      Width = 373
      Height = 17
      Caption = 
        'Not returned (if checked then just not returned items are visibl' +
        'e else all)'
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
    Top = 596
    Width = 911
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object grData: TcxGrid
    Left = 0
    Top = 97
    Width = 911
    Height = 466
    Align = alClient
    TabOrder = 2
    object tvData: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      OptionsView.Indicator = True
      OptionsView.IndicatorWidth = 18
      Bands = <
        item
          Caption = 'Item'
          FixedKind = fkLeft
          Options.Sizing = False
          Width = 169
        end
        item
          Caption = 'Details'
        end>
      object tvDataRecId: TcxGridDBBandedColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDataID: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ID'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDataDateFound: TcxGridDBBandedColumn
        Caption = 'Date found'
        DataBinding.FieldName = 'DateFound'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Kind = ckDateTime
        BestFitMaxWidth = 100
        MinWidth = 100
        Width = 129
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDataitemDescription: TcxGridDBBandedColumn
        Caption = 'Item notes'
        DataBinding.FieldName = 'itemDescription'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.ScrollBars = ssVertical
        MinWidth = 150
        Width = 221
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDatalocationDescription: TcxGridDBBandedColumn
        Caption = 'Location notes'
        DataBinding.FieldName = 'locationDescription'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 3
        MinWidth = 150
        Width = 226
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDatareturnedNotes: TcxGridDBBandedColumn
        Caption = 'Returned notes'
        DataBinding.FieldName = 'returnedNotes'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.ScrollBars = ssVertical
        MinWidth = 150
        Width = 209
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDatareturnedToOwner: TcxGridDBBandedColumn
        Caption = 'Returned'
        DataBinding.FieldName = 'returnedToOwner'
        PropertiesClassName = 'TcxCheckBoxProperties'
        BestFitMaxWidth = 70
        MinWidth = 40
        Width = 40
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 563
    Width = 911
    Height = 33
    Align = alBottom
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      911
      33)
    object btnCancel: TsButton
      Left = 821
      Top = 4
      Width = 86
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 733
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
  object mnuOther: TPopupMenu
    Left = 30
    Top = 176
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
    Left = 152
    Top = 240
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 152
    Top = 184
    object prLink_grData: TdxGridReportLink
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
    Left = 96
    Top = 176
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_DateFound: TDateTimeField
      FieldName = 'DateFound'
    end
    object m_locationDescription: TWideStringField
      FieldName = 'locationDescription'
      Size = 200
    end
    object m_returnedNotes: TWideStringField
      FieldName = 'returnedNotes'
      Size = 200
    end
    object m_returnedToOwner: TBooleanField
      FieldName = 'returnedToOwner'
    end
    object m_itemDescription: TWideStringField
      FieldName = 'itemDescription'
      Size = 200
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
    StorageName = 'Software\Roomer\FormStatus\lostandfound'
    StorageType = stRegistry
    Left = 150
    Top = 288
  end
end
