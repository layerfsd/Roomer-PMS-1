object frmTaxes: TfrmTaxes
  Left = 0
  Top = 0
  Caption = 'Taxes'
  ClientHeight = 531
  ClientWidth = 1098
  Color = clBtnFace
  Constraints.MinWidth = 750
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
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 1098
    Height = 531
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
      Width = 1098
      Height = 81
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        1098
        81)
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
        Left = 271
        Top = 39
        Width = 66
        Height = 20
        Caption = 'Clear'
        OnClick = btnClearClick
        SkinData.SkinSection = 'SPEEDBUTTON'
        Images = DImages.PngImageList1
        ImageIndex = 10
      end
      object btnDelete: TsButton
        Left = 199
        Top = 7
        Width = 90
        Height = 26
        Caption = 'Delete'
        ImageIndex = 24
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = btnDeleteClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnOther: TsButton
        Left = 295
        Top = 7
        Width = 134
        Height = 26
        Caption = 'Other actions'
        DropDownMenu = mnuOther
        ImageIndex = 76
        Images = DImages.PngImageList1
        Style = bsSplitButton
        TabOrder = 1
        OnClick = btnOtherClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClose: TsButton
        Left = 1009
        Top = 7
        Width = 80
        Height = 26
        Anchors = [akTop, akRight]
        Caption = 'Close'
        ImageIndex = 27
        Images = DImages.PngImageList1
        ModalResult = 8
        TabOrder = 2
        OnClick = btnCloseClick
        SkinData.SkinSection = 'BUTTON'
      end
      object edFilter: TsEdit
        Left = 56
        Top = 39
        Width = 213
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = edFilterChange
        SkinData.SkinSection = 'EDIT'
      end
      object chkActive: TsCheckBox
        Left = 56
        Top = 62
        Width = 238
        Height = 20
        Caption = 'Active (if checked then just active are visible)'
        Checked = True
        State = cbChecked
        TabOrder = 4
        Visible = False
        OnClick = chkActiveClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object btnInsert: TsButton
        Left = 7
        Top = 7
        Width = 90
        Height = 26
        Hint = 'Add new record'
        Caption = 'New'
        ImageIndex = 23
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = btnInsertClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnEdit: TsButton
        Left = 103
        Top = 7
        Width = 90
        Height = 26
        Hint = 'Edit current record'
        Caption = 'Edit'
        ImageIndex = 25
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = btnEditClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnRefresh: TsButton
        Left = 435
        Top = 7
        Width = 79
        Height = 26
        Hint = 'Refresh'
        Anchors = [akTop, akRight]
        Caption = 'Refresh'
        ImageIndex = 28
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = btnRefreshClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object sbMain: TsStatusBar
      Left = 0
      Top = 512
      Width = 1098
      Height = 19
      Panels = <>
      SkinData.SkinSection = 'STATUSBAR'
    end
    object panBtn: TsPanel
      Left = 0
      Top = 479
      Width = 1098
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        1098
        33)
      object btnCancel: TsButton
        Left = 1009
        Top = 4
        Width = 84
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
        Left = 919
        Top = 2
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
      Top = 81
      Width = 1098
      Height = 398
      Align = alClient
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      Images = DImages.PngImageList1
      PopupMenu = PopupMenu1
      TabOrder = 3
      LookAndFeel.NativeStyle = False
      ExplicitTop = 79
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
        OnFocusedRecordChanged = tvDataFocusedRecordChanged
        DataController.DataSource = DS
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
        object tvDataID: TcxGridDBColumn
          DataBinding.FieldName = 'ID'
          Visible = False
        end
        object tvDataDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          MinWidth = 150
          Width = 336
        end
        object tvDataValid_From: TcxGridDBColumn
          DataBinding.FieldName = 'Valid_From'
        end
        object tvDataValid_To: TcxGridDBColumn
          DataBinding.FieldName = 'Valid_To'
        end
        object tvDataAmount: TcxGridDBColumn
          DataBinding.FieldName = 'Amount'
          MinWidth = 100
        end
        object tvDataTax_Type: TcxGridDBColumn
          Caption = 'Tax Type'
          DataBinding.FieldName = 'Tax_Type'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.Items.Strings = (
            'FIXED_AMOUNT'
            'PERCENTAGE')
          Properties.MaxLength = 30
          MinWidth = 125
          Width = 125
        end
        object tvDataTax_Base: TcxGridDBColumn
          Caption = 'Tax Based On'
          DataBinding.FieldName = 'Tax_Base'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.Items.Strings = (
            'ROOM_NIGHT'
            'GUEST_NIGHT'
            'ROOM'
            'GUEST'
            'BOOKING')
          Properties.MaxLength = 30
          MinWidth = 136
          Width = 136
        end
        object tvDataTime_Due: TcxGridDBColumn
          Caption = 'Tax Due'
          DataBinding.FieldName = 'Time_Due'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.Items.Strings = (
            'PREPAID'
            'CHECKOUT')
          MinWidth = 148
          Width = 148
        end
        object tvDataReTaxable: TcxGridDBColumn
          Caption = 'Re-taxable'
          DataBinding.FieldName = 'ReTaxable'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.Items.Strings = (
            'FALSE'
            'TRUE')
          MinWidth = 84
        end
        object tvDataTaxChildren: TcxGridDBColumn
          Caption = 'Tax Children'
          DataBinding.FieldName = 'TaxChildren'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.Items.Strings = (
            'FALSE'
            'TRUE')
          Width = 84
        end
        object tvDataBooking_Item_Id: TcxGridDBColumn
          DataBinding.FieldName = 'Booking_Item_Id'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = tvDataBooking_Item_IdPropertiesButtonClick
          Visible = False
        end
        object tvDataBooking_Item: TcxGridDBColumn
          Caption = 'Booking Item'
          DataBinding.FieldName = 'Booking_Item'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = tvDataBooking_Item_IdPropertiesButtonClick
          Properties.OnValidate = tvDataBooking_ItemPropertiesValidate
          MinWidth = 64
        end
        object tvDataIncl_Excl: TcxGridDBColumn
          Caption = 'Included in price'
          DataBinding.FieldName = 'Incl_Excl'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.Items.Strings = (
            'EXCLUDED'
            'INCLUDED'
            'PER_CUSTOMER')
        end
        object tvDataNetto_Amount_Based: TcxGridDBColumn
          Caption = 'Based on netto amount'
          DataBinding.FieldName = 'Netto_Amount_Based'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.Items.Strings = (
            'FALSE'
            'TRUE')
        end
        object tvDataValue_Formula: TcxGridDBColumn
          Caption = 'Overriding calculation Formula'
          DataBinding.FieldName = 'Value_Formula'
        end
      end
      object lvData: TcxGridLevel
        GridView = tvData
      end
    end
  end
  object mnuOther: TPopupMenu
    Left = 190
    Top = 160
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      ImageIndex = 3
      OnClick = mnuiPrintClick
    end
    object A1: TMenuItem
      Caption = 'Apply best fit'
      OnClick = A1Click
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
    Left = 104
    Top = 160
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
    BeforeInsert = m_BeforeInsert
    BeforePost = m_BeforePost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 104
    Top = 272
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_Description: TWideStringField
      FieldName = 'Description'
      Size = 64
    end
    object m_Amount: TFloatField
      FieldName = 'Amount'
    end
    object m_Tax_Type: TWideStringField
      FieldName = 'Tax_Type'
      Size = 30
    end
    object m_Tax_Base: TWideStringField
      FieldName = 'Tax_Base'
      Size = 30
    end
    object m_Time_Due: TWideStringField
      FieldName = 'Time_Due'
      Size = 30
    end
    object m_ReTaxable: TWideStringField
      FieldName = 'ReTaxable'
      Size = 10
    end
    object m_Booking_Item_Id: TIntegerField
      FieldName = 'Booking_Item_Id'
    end
    object m_Hotel_Id: TWideStringField
      FieldName = 'Hotel_Id'
      Size = 10
    end
    object m_Booking_Item: TWideStringField
      FieldName = 'Booking_Item'
      Size = 30
    end
    object m_Incl_Excl: TWideStringField
      FieldName = 'Incl_Excl'
      Size = 15
    end
    object m_Netto_Amount_Based: TWideStringField
      FieldName = 'Netto_Amount_Based'
      Size = 10
    end
    object m_Value_Formula: TWideStringField
      FieldName = 'Value_Formula'
      Size = 255
    end
    object m_Valid_From: TDateField
      FieldName = 'Valid_From'
    end
    object m_Valid_To: TDateField
      FieldName = 'Valid_To'
    end
    object m_TaxChildren: TWideStringField
      DisplayWidth = 10
      FieldName = 'TaxChildren'
      Size = 10
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
      end
      item
        Component = tvDataAmount
        Properties.Strings = (
          'Width')
      end
      item
        Component = tvDataBooking_Item
        Properties.Strings = (
          'Width')
      end
      item
        Component = tvDataDescription
        Properties.Strings = (
          'Width')
      end
      item
        Component = tvDataReTaxable
        Properties.Strings = (
          'Width')
      end
      item
        Component = tvDataTax_Base
        Properties.Strings = (
          'Width')
      end
      item
        Component = tvDataTax_Type
        Properties.Strings = (
          'Width')
      end
      item
        Component = tvDataTime_Due
        Properties.Strings = (
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\Taxes'
    StorageType = stRegistry
    Left = 494
    Top = 264
  end
  object PopupMenu1: TPopupMenu
    Left = 264
    Top = 136
    object C1: TMenuItem
      Caption = 'Duplicate current'
      OnClick = C1Click
    end
  end
end
