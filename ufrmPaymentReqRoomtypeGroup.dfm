object frmPaymentReqRoomtypeGroup: TfrmPaymentReqRoomtypeGroup
  Left = 0
  Top = 0
  Caption = 'Payment requirements for Roomtypegroup'
  ClientHeight = 366
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 465
    Height = 366
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sPanel1: TsPanel
      Left = 0
      Top = 0
      Width = 465
      Height = 65
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object cLabFilter: TsLabel
        Left = 19
        Top = 11
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
        Left = 278
        Top = 9
        Width = 69
        Height = 20
        Caption = 'Clear'
        OnClick = btnClearClick
        SkinData.SkinSection = 'SPEEDBUTTON'
        Images = DImages.PngImageList1
        ImageIndex = 10
      end
      object edFilter: TsEdit
        Left = 56
        Top = 9
        Width = 216
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = edFilterChange
        SkinData.SkinSection = 'EDIT'
      end
    end
    object sbMain: TsStatusBar
      Left = 0
      Top = 347
      Width = 465
      Height = 19
      Panels = <>
      SkinData.SkinSection = 'STATUSBAR'
    end
    object panBtn: TsPanel
      Left = 0
      Top = 314
      Width = 465
      Height = 33
      Align = alBottom
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        465
        33)
      object btnCancel: TsButton
        Left = 376
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
        TabOrder = 0
        SkinData.SkinSection = 'BUTTON'
      end
      object BtnOk: TsButton
        Left = 284
        Top = 2
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
    object grData: TcxGrid
      Left = 0
      Top = 65
      Width = 465
      Height = 249
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
        Navigator.Buttons.Insert.Enabled = False
        Navigator.Buttons.Insert.Hint = 'Insert'
        Navigator.Buttons.Insert.Visible = False
        Navigator.Buttons.Append.Enabled = False
        Navigator.Buttons.Append.Hint = 'Append'
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Enabled = False
        Navigator.Buttons.Delete.Hint = 'Delete'
        Navigator.Buttons.Delete.Visible = False
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
        OptionsBehavior.IncSearch = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvDataRecId: TcxGridDBColumn
          DataBinding.FieldName = 'RecId'
          Visible = False
        end
        object tvDataChannelmanagerID: TcxGridDBColumn
          Caption = 'Channel'
          DataBinding.FieldName = 'ChannelmanagerID'
          Options.Editing = False
        end
        object tvDataName: TcxGridDBColumn
          DataBinding.FieldName = 'Name'
          Options.Editing = False
        end
        object tvDataPaymentRequired: TcxGridDBColumn
          Caption = 'Payment Required'
          DataBinding.FieldName = 'PaymentRequired'
          PropertiesClassName = 'TcxCheckBoxProperties'
          HeaderAlignmentHorz = taCenter
          Width = 104
        end
        object tvDataPrepaidPercentage: TcxGridDBColumn
          Caption = 'Percentage'
          DataBinding.FieldName = 'PrepaidPercentage'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '##0 %'
          Properties.ValidationOptions = []
          Properties.OnValidate = tvDataPrepaidPercentagePropertiesValidate
        end
      end
      object lvData: TcxGridLevel
        GridView = tvData
      end
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
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 208
    Top = 192
    object m_ChannelmanagerID: TStringField
      FieldName = 'ChannelmanagerID'
      Size = 11
    end
    object m_Name: TStringField
      FieldName = 'Name'
      Size = 35
    end
    object m_PaymentRequired: TBooleanField
      FieldName = 'PaymentRequired'
    end
    object m_PrepaidPercentage: TFloatField
      FieldName = 'PrepaidPercentage'
    end
    object m_Active: TBooleanField
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
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\RoomClassPaymentRequirements'
    StorageType = stRegistry
    Left = 369
    Top = 135
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 30
    Top = 192
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      ImageIndex = 3
    end
    object mnuiAllowGridEdit: TMenuItem
      Caption = 'Allow grid edit'
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
end
