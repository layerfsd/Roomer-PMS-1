object frmCurrencies: TfrmCurrencies
  Left = 2968
  Top = 305
  Caption = 'Currencies'
  ClientHeight = 518
  ClientWidth = 736
  Color = clBtnFace
  Constraints.MinWidth = 460
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 736
    Height = 518
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sbMain: TsStatusBar
      Left = 0
      Top = 499
      Width = 736
      Height = 19
      Panels = <>
      SimplePanel = True
      SkinData.SkinSection = 'STATUSBAR'
    end
    object PanTop: TsPanel
      Left = 0
      Top = 0
      Width = 736
      Height = 89
      Align = alTop
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        736
        89)
      object cLabFilter: TsLabel
        Left = 19
        Top = 42
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
        Left = 260
        Top = 39
        Width = 59
        Height = 21
        Caption = 'Clear'
        OnClick = btnClearClick
        SkinData.SkinSection = 'SPEEDBUTTON'
        Images = DImages.PngImageList1
        ImageIndex = 10
      end
      object btnInsert: TsButton
        Left = 10
        Top = 7
        Width = 82
        Height = 26
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
        Left = 98
        Top = 7
        Width = 82
        Height = 26
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
        Left = 186
        Top = 7
        Width = 81
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
        Left = 273
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
        TabOrder = 3
        OnClick = btnOtherClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClose: TsButton
        Left = 643
        Top = 7
        Width = 84
        Height = 26
        Hint = 'Close form'
        Anchors = [akTop, akRight]
        Caption = 'Close'
        ImageIndex = 27
        Images = DImages.PngImageList1
        ModalResult = 11
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = btnCloseClick
        SkinData.SkinSection = 'BUTTON'
      end
      object chkActive: TsCheckBox
        Left = 56
        Top = 65
        Width = 281
        Height = 17
        Caption = 'Active (if checked then just active are visible else all)'
        Checked = True
        State = cbChecked
        TabOrder = 6
        OnClick = chkActiveClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object edFilter: TsEdit
        Left = 56
        Top = 39
        Width = 206
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnChange = edFilterChange
        SkinData.SkinSection = 'EDIT'
      end
    end
    object panBtn: TsPanel
      Left = 0
      Top = 466
      Width = 736
      Height = 33
      Align = alBottom
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        736
        33)
      object btnCancel: TsButton
        Left = 648
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
        Left = 562
        Top = 4
        Width = 83
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
      Width = 736
      Height = 377
      Align = alClient
      TabOrder = 3
      LookAndFeel.NativeStyle = False
      ExplicitTop = 88
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
        object tvDataCurrency: TcxGridDBColumn
          DataBinding.FieldName = 'Currency'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.CharCase = ecUpperCase
          Properties.ReadOnly = False
          Properties.ValidateOnEnter = True
          Properties.OnValidate = tvDataCurrencyPropertiesValidate
          Width = 66
        end
        object tvDataDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 269
        end
        object tvDataAValue: TcxGridDBColumn
          Caption = 'Rate'
          DataBinding.FieldName = 'AValue'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.OnValidate = tvDataAValuePropertiesValidate
          Width = 112
        end
        object tvDataactive: TcxGridDBColumn
          Caption = 'Active'
          DataBinding.FieldName = 'active'
          Width = 47
        end
        object tvDataID: TcxGridDBColumn
          DataBinding.FieldName = 'ID'
          Visible = False
        end
        object tvDatadisplayformat: TcxGridDBColumn
          Caption = 'Displayformat'
          DataBinding.FieldName = 'displayformat'
          PropertiesClassName = 'TcxMaskEditProperties'
        end
        object tvDatadecimals: TcxGridDBColumn
          Caption = 'Decimals'
          DataBinding.FieldName = 'decimals'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 10.000000000000000000
        end
      end
      object lvData: TcxGridLevel
        GridView = tvData
      end
    end
  end
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 312
    Top = 136
    object m_Currency: TWideStringField
      FieldName = 'Currency'
      Size = 5
    end
    object m_Description: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object m_AValue: TFloatField
      FieldName = 'AValue'
    end
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_active: TBooleanField
      FieldName = 'active'
    end
    object m_displayformat: TWideStringField
      FieldName = 'displayformat'
    end
    object m_decimals: TIntegerField
      FieldName = 'decimals'
    end
    object m_SellValue: TFloatField
      FieldName = 'SellValue'
    end
    object m_CurrencySign: TStringField
      FieldName = 'CurrencySign'
      Size = 6
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 336
    Top = 40
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
    Left = 360
    Top = 136
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 168
    Top = 176
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
      ReportDocument.CreationDate = 42628.505476006940000000
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
    StorageName = 'Software\Roomer\FormStatus\Currencies'
    StorageType = stRegistry
    Left = 75
    Top = 176
  end
end
