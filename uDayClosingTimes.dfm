object frmDayClosingTimes: TfrmDayClosingTimes
  Left = 0
  Top = 0
  Caption = 'DayClosingTimes'
  ClientHeight = 495
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 448
    Height = 495
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sPanel2: TsPanel
      Left = 0
      Top = 0
      Width = 448
      Height = 81
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object lbStartFrom: TsLabel
        Left = 13
        Top = 51
        Width = 83
        Height = 13
        Caption = 'Show from date: '
      end
      object btnDelete: TsButton
        Left = 205
        Top = 7
        Width = 90
        Height = 26
        Caption = 'Delete'
        ImageIndex = 24
        Images = DImages.PngImageList1
        TabOrder = 2
        OnClick = btnDeleteClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnOther: TsButton
        Left = 301
        Top = 7
        Width = 134
        Height = 26
        Caption = 'Other actions'
        ImageIndex = 76
        Images = DImages.PngImageList1
        Style = bsSplitButton
        TabOrder = 3
        Visible = False
        SkinData.SkinSection = 'BUTTON'
      end
      object btnNew: TsButton
        Left = 13
        Top = 7
        Width = 90
        Height = 26
        Hint = 'Add new record'
        Caption = 'New'
        ImageIndex = 23
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnNewClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnEdit: TsButton
        Left = 109
        Top = 7
        Width = 90
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
      object edtLastDate: TsDateEdit
        Left = 109
        Top = 48
        Width = 90
        Height = 21
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 4
        CheckOnExit = True
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        DefaultToday = True
      end
      object btnRefresh: TsButton
        Left = 205
        Top = 46
        Width = 90
        Height = 26
        Hint = 'Refresh grid'
        Caption = 'Refresh'
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = btnRefreshClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object sbMain: TsStatusBar
      Left = 0
      Top = 476
      Width = 448
      Height = 19
      Panels = <>
      SkinData.SkinSection = 'STATUSBAR'
    end
    object panBtn: TsPanel
      Left = 0
      Top = 443
      Width = 448
      Height = 33
      Align = alBottom
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        448
        33)
      object btnCancel: TsButton
        Left = 359
        Top = 4
        Width = 86
        Height = 25
        Hint = 'Cancel and close'
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'Cancel'
        ImageIndex = 4
        Images = DImages.PngImageList1
        ModalResult = 2
        TabOrder = 1
        SkinData.SkinSection = 'BUTTON'
      end
      object BtnOk: TsButton
        Left = 267
        Top = 4
        Width = 86
        Height = 25
        Hint = 'Apply and close'
        Anchors = [akTop, akRight]
        Caption = 'OK'
        Default = True
        ImageIndex = 82
        Images = DImages.PngImageList1
        ModalResult = 1
        TabOrder = 0
        OnClick = BtnOkClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object grData: TcxGrid
      Left = 0
      Top = 81
      Width = 448
      Height = 362
      Align = alClient
      TabOrder = 3
      LookAndFeel.NativeStyle = False
      object tvData: TcxGridDBTableView
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
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.AlwaysShowEditor = True
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.IncSearch = True
        OptionsData.Appending = True
        OptionsData.CancelOnExit = False
        OptionsData.DeletingConfirmation = False
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvDataDay: TcxGridDBColumn
          DataBinding.FieldName = 'Day'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.ShowTime = False
          HeaderAlignmentHorz = taCenter
          SortIndex = 0
          SortOrder = soDescending
          Width = 108
        end
        object tvDataClosingTime: TcxGridDBColumn
          DataBinding.FieldName = 'ClosingTimestamp'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.Kind = ckDateTime
          HeaderAlignmentHorz = taCenter
          Width = 121
        end
      end
      object lvData: TcxGridLevel
        GridView = tvData
      end
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 14
    Top = 120
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
    StorageName = 'Software\Roomer\FormStatus\BookKeepingCodes'
    StorageType = stRegistry
    Left = 334
    Top = 208
  end
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 208
    Top = 192
    object m_day: TDateField
      FieldName = 'Day'
    end
    object m_ClosingTime: TDateTimeField
      FieldName = 'ClosingTimestamp'
    end
  end
  object DS: TDataSource
    DataSet = m_
    Left = 152
    Top = 192
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 96
    Top = 192
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
end
