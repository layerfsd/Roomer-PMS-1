object frmMaidActions: TfrmMaidActions
  Left = 0
  Top = 0
  Caption = 'Housekeeping rules'
  ClientHeight = 458
  ClientWidth = 838
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 838
    Height = 68
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
      Left = 264
      Top = 39
      Width = 70
      Height = 20
      Caption = 'Clear'
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 10
    end
    object btnDelete: TsButton
      Left = 199
      Top = 6
      Width = 100
      Height = 26
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 305
      Top = 6
      Width = 145
      Height = 26
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
      Width = 206
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      SkinData.SkinSection = 'EDIT'
    end
    object btnEdit: TsButton
      Left = 112
      Top = 6
      Width = 81
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
    object btnInsert: TsButton
      Left = 6
      Top = 6
      Width = 100
      Height = 26
      Hint = 'Add new record'
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
  object sbMain: TsStatusBar
    Left = 0
    Top = 439
    Width = 838
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 406
    Width = 838
    Height = 33
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      838
      33)
    object btnCancel: TsButton
      Left = 749
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
      Left = 661
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
    Width = 838
    Height = 338
    Align = alClient
    Constraints.MinWidth = 450
    TabOrder = 3
    LookAndFeel.NativeStyle = False
    ExplicitTop = 66
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
      DataController.DataSource = DS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.IncSearch = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object tvDataRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object tvDatamaAction: TcxGridDBColumn
        Caption = 'Action'
        DataBinding.FieldName = 'maAction'
        Width = 55
      end
      object tvDatamaDescription: TcxGridDBColumn
        Caption = 'Description'
        DataBinding.FieldName = 'maDescription'
        Width = 229
      end
      object tvDatamaRule: TcxGridDBColumn
        Caption = 'Rule'
        DataBinding.FieldName = 'maRule'
        PropertiesClassName = 'TcxMemoProperties'
        Width = 297
      end
      object tvDatamaUSe: TcxGridDBColumn
        Caption = 'Use'
        DataBinding.FieldName = 'maUSe'
        Width = 79
      end
      object tvDatamaCross: TcxGridDBColumn
        Caption = 'Cross'
        DataBinding.FieldName = 'maCross'
        Width = 82
      end
      object tvDatamaActive: TcxGridDBColumn
        DataBinding.FieldName = 'Active'
        Width = 80
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
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 198
    Top = 200
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      ImageIndex = 3
    end
    object mnuiAllowGridEdit: TMenuItem
      Caption = 'Allow grid edit'
      Enabled = False
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
      end
      object mnuiGridToHtml: TMenuItem
        Caption = 'Grid to HTML'
        ImageIndex = 99
      end
      object mnuiGridToText: TMenuItem
        Caption = 'Grid to text'
        ImageIndex = 0
      end
      object mnuiGridToXml: TMenuItem
        Caption = 'Grid to XML'
        ImageIndex = 0
      end
    end
  end
  object DS: TDataSource
    DataSet = m_
    Left = 368
    Top = 288
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
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforeDelete = m_BeforeDelete
    Left = 368
    Top = 344
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_maAction: TWideStringField
      FieldName = 'maAction'
      Size = 5
    end
    object m_maDescription: TWideStringField
      FieldName = 'maDescription'
      Size = 50
    end
    object m_maRule: TWideMemoField
      FieldName = 'maRule'
      BlobType = ftWideMemo
    end
    object m_maUSe: TBooleanField
      FieldName = 'maUSe'
    end
    object m_maCross: TBooleanField
      FieldName = 'maCross'
    end
    object m_maActive: TBooleanField
      FieldName = 'Active'
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
          'Width'
          'WindowState')
      end>
    StorageName = 'Software\Roomer\FormStatus\MaidActions'
    StorageType = stRegistry
    Left = 244
    Top = 344
  end
end
