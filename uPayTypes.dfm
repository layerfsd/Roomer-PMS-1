object frmPayTypes: TfrmPayTypes
  Left = 2028
  Top = 228
  Caption = 'Payment types'
  ClientHeight = 450
  ClientWidth = 872
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbMain: TsStatusBar
    Left = 0
    Top = 431
    Width = 872
    Height = 19
    Panels = <>
    SimplePanel = True
    SkinData.SkinSection = 'STATUSBAR'
  end
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 872
    Height = 87
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sLabel1: TsLabel
      Left = 18
      Top = 43
      Width = 30
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Filter:'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnClear: TsSpeedButton
      Left = 251
      Top = 39
      Width = 66
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
      Width = 83
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
      Left = 270
      Top = 7
      Width = 140
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
      Width = 193
      Height = 22
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
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
      Width = 281
      Height = 17
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
    Top = 398
    Width = 872
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      872
      33)
    object btnCancel: TsButton
      Left = 784
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
      Left = 696
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
    Top = 87
    Width = 872
    Height = 311
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
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
      OptionsData.DeletingConfirmation = False
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object tvDataRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object tvDatapayType: TcxGridDBColumn
        Caption = 'Code'
        DataBinding.FieldName = 'payType'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.AutoSelect = False
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = False
        Properties.ValidateOnEnter = True
        Properties.OnValidate = tvDatapayTypePropertiesValidate
      end
      object tvDataDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.AutoSelect = False
      end
      object tvDataPayGroup: TcxGridDBColumn
        Caption = 'Group'
        DataBinding.FieldName = 'PayGroup'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = False
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = tvDataPayGroupPropertiesButtonClick
        Width = 69
      end
      object tvDatapayGroupDescription: TcxGridDBColumn
        DataBinding.FieldName = 'payGroupDescription'
        Visible = False
      end
      object tvDataptDays: TcxGridDBColumn
        Caption = 'Days'
        DataBinding.FieldName = 'ptDays'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.AssignedValues.MinValue = True
      end
      object tvDataAskCode: TcxGridDBColumn
        Caption = 'Confirm'
        DataBinding.FieldName = 'AskCode'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Width = 51
      end
      object tvDatadoExport: TcxGridDBColumn
        Caption = 'Export'
        DataBinding.FieldName = 'doExport'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Width = 50
      end
      object tvDataID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Visible = False
      end
      object tvDataActive: TcxGridDBColumn
        DataBinding.FieldName = 'Active'
        Width = 49
      end
      object tvDataBookKey: TcxGridDBColumn
        Caption = 'Booking key'
        DataBinding.FieldName = 'BookKey'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = '...'
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataBookKeyPropertiesButtonClick
        MinWidth = 16
        Options.ShowEditButtons = isebAlways
        Width = 94
      end
      object tvDataBookKeepCode: TcxGridDBColumn
        Caption = 'Book-keeping code'
        DataBinding.FieldName = 'BookKeepCode'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = '...'
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = tvDataBookKeepCodePropertiesButtonClick
        Options.ShowEditButtons = isebAlways
        Width = 123
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
    object m_payType: TWideStringField
      FieldName = 'payType'
      Size = 10
    end
    object m_Description: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object m_PayGroup: TWideStringField
      FieldName = 'PayGroup'
      Size = 5
    end
    object m_payGroupDescription: TWideStringField
      FieldName = 'payGroupDescription'
      Size = 30
    end
    object m_AskCode: TBooleanField
      FieldName = 'AskCode'
    end
    object m_ptDays: TIntegerField
      FieldName = 'ptDays'
    end
    object m_doExport: TBooleanField
      FieldName = 'doExport'
    end
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
    object m_BookKey: TStringField
      FieldName = 'BookKey'
      Size = 16
    end
    object m_BookKeepCode: TWideStringField
      FieldName = 'BookKeepCode'
      Size = 25
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 24
    Top = 176
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
      ReportDocument.CreationDate = 42500.508372465280000000
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
    StorageName = 'Software\Roomer\FormStatus\PayTypes'
    StorageType = stRegistry
    Left = 426
    Top = 224
  end
end
