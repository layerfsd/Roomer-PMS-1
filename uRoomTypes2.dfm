object frmRoomTypes2: TfrmRoomTypes2
  Left = 0
  Top = 0
  Caption = 'Room Types'
  ClientHeight = 495
  ClientWidth = 942
  Color = clBtnFace
  Constraints.MinWidth = 470
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
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 942
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
      Width = 942
      Height = 495
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
        Width = 942
        Height = 75
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          942
          75)
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
          Left = 283
          Top = 39
          Width = 64
          Height = 20
          Caption = '5'
          OnClick = btnClearClick
          SkinData.SkinSection = 'SPEEDBUTTON'
          Images = DImages.PngImageList1
          ImageIndex = 10
        end
        object btnDelete: TsButton
          Left = 204
          Top = 7
          Width = 95
          Height = 26
          Caption = 'Delete'
          ImageIndex = 24
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = btnDeleteClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnOther: TsButton
          Left = 305
          Top = 7
          Width = 135
          Height = 26
          Caption = 'Other actions'
          DropDownMenu = mnuOther
          ImageIndex = 82
          Images = DImages.PngImageList1
          Style = bsSplitButton
          TabOrder = 3
          OnClick = btnOtherClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnClose: TsButton
          Left = 852
          Top = 7
          Width = 80
          Height = 26
          Anchors = [akTop, akRight]
          Caption = 'Close'
          ImageIndex = 27
          Images = DImages.PngImageList1
          ModalResult = 8
          TabOrder = 5
          OnClick = btnCloseClick
          SkinData.SkinSection = 'BUTTON'
        end
        object edFilter: TsEdit
          Left = 56
          Top = 39
          Width = 225
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
        object btnInsert: TsButton
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
          OnClick = btnInsertClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnEdit: TsButton
          Left = 109
          Top = 7
          Width = 89
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
      end
      object sbMain: TsStatusBar
        Left = 0
        Top = 476
        Width = 942
        Height = 19
        Panels = <>
        SkinData.SkinSection = 'STATUSBAR'
      end
      object panBtn: TsPanel
        Left = 0
        Top = 442
        Width = 942
        Height = 34
        Align = alBottom
        TabOrder = 2
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          942
          34)
        object btnCancel: TsButton
          Left = 814
          Top = 4
          Width = 118
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
          Left = 714
          Top = 4
          Width = 94
          Height = 25
          Hint = 'Apply and close'
          Anchors = [akTop, akRight]
          Caption = 'OK'
          Default = True
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
        Top = 75
        Width = 942
        Height = 367
        Align = alClient
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
          object tvDataRoomType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'RoomType'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 5
            Properties.OnValidate = tvDataRoomTypePropertiesValidate
            Width = 70
          end
          object tvDataDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 154
          end
          object tvDataNumberGuests: TcxGridDBColumn
            Caption = 'Guests'
            DataBinding.FieldName = 'NumberGuests'
            PropertiesClassName = 'TcxSpinEditProperties'
          end
          object tvDataRoomTypeGroup: TcxGridDBColumn
            Caption = 'Room class'
            DataBinding.FieldName = 'RoomTypeGroup'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                ImageIndex = 8
                Kind = bkGlyph
              end>
            Properties.Images = DImages.PngImageList1
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = tvDataRoomTypeGroupPropertiesButtonClick
            Options.ShowEditButtons = isebAlways
          end
          object tvDataPriorityRule: TcxGridDBColumn
            DataBinding.FieldName = 'PriorityRule'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.CharCase = ecUpperCase
            Width = 100
          end
          object tvDataPriceType: TcxGridDBColumn
            DataBinding.FieldName = 'PriceType'
            Visible = False
          end
          object tvDataWebable: TcxGridDBColumn
            DataBinding.FieldName = 'Webable'
            Visible = False
          end
          object tvDatacolor: TcxGridDBColumn
            DataBinding.FieldName = 'color'
            PropertiesClassName = 'TcxColorComboBoxProperties'
            Properties.CustomColors = <>
            Options.ShowEditButtons = isebAlways
            Width = 39
          end
          object tvDataActive: TcxGridDBColumn
            DataBinding.FieldName = 'Active'
            Width = 54
          end
          object tvDatalocation: TcxGridDBColumn
            DataBinding.FieldName = 'location'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.OnButtonClick = tvDatalocationPropertiesButtonClick
            Width = 70
          end
        end
        object lvData: TcxGridLevel
          GridView = tvData
        end
      end
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 30
    Top = 160
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
    object F1: TMenuItem
      Caption = 'Fix Roomtypes'
      OnClick = F1Click
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
    Left = 28
    Top = 208
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
    AfterScroll = m_AfterScroll
    OnNewRecord = m_NewRecord
    Left = 312
    Top = 288
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
    object m_RoomType: TWideStringField
      FieldName = 'RoomType'
      Size = 10
    end
    object m_Description: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object m_NumberGuests: TIntegerField
      FieldName = 'NumberGuests'
    end
    object m_PriceType: TWideStringField
      FieldName = 'PriceType'
      Size = 10
    end
    object m_Webable: TBooleanField
      FieldName = 'Webable'
    end
    object m_RoomTypeGroup: TWideStringField
      FieldName = 'RoomTypeGroup'
      Size = 10
    end
    object m_color: TWideStringField
      FieldName = 'color'
      Size = 50
    end
    object m_PriorityRule: TWideStringField
      FieldName = 'PriorityRule'
      Size = 50
    end
    object m_location: TStringField
      FieldName = 'location'
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
      end>
    StorageName = 'Software\Roomer\FormStatus\RoomTypes'
    StorageType = stRegistry
    Left = 262
    Top = 216
  end
end
