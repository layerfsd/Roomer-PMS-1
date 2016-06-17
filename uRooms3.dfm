object frmRooms3: TfrmRooms3
  Left = 0
  Top = 0
  Caption = 'Rooms'
  ClientHeight = 644
  ClientWidth = 1034
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1034
    Height = 72
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object cLabFilter: TsLabel
      Left = 34
      Top = 54
      Width = 31
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      Left = 382
      Top = 41
      Width = 65
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Clear'
      OnClick = btnClearClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      Images = DImages.PngImageList1
      ImageIndex = 4
    end
    object btnDelete: TsButton
      Left = 255
      Top = 9
      Width = 112
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOther: TsButton
      Left = 375
      Top = 9
      Width = 170
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Other actions'
      DropDownMenu = mnuOther
      ImageIndex = 76
      Images = DImages.PngImageList1
      Style = bsSplitButton
      TabOrder = 1
      OnClick = btnOtherClick
      SkinData.SkinSection = 'BUTTON'
    end
    object edFilter: TsEdit
      Left = 94
      Top = 42
      Width = 288
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      Left = 16
      Top = 9
      Width = 111
      Height = 25
      Hint = 'Add new record'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      Left = 135
      Top = 9
      Width = 112
      Height = 25
      Hint = 'Edit current record'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnEditClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sbMain: TsStatusBar
    Left = 0
    Top = 625
    Width = 1034
    Height = 19
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 592
    Width = 1034
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1034
      33)
    object btnCancel: TsButton
      Left = 948
      Top = 5
      Width = 80
      Height = 25
      Hint = 'Cancel and close'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      Left = 865
      Top = 5
      Width = 80
      Height = 25
      Hint = 'Apply and close'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
    Top = 72
    Width = 1034
    Height = 520
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    TabOrder = 3
    LookAndFeel.NativeStyle = False
    object tvData: TcxGridDBBandedTableView
      OnDblClick = tvDataDblClick
      Navigator.Buttons.CustomButtons = <>
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      DataController.DataSource = DS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Appending = True
      OptionsView.HeaderAutoHeight = True
      Bands = <
        item
          Caption = 'Room'
          FixedKind = fkLeft
          Width = 501
        end
        item
          Caption = 'Other'
          Width = 313
        end
        item
          Caption = 'Location'
          Width = 166
        end
        item
          Caption = 'Equipment'
        end>
      object tvDataRecId: TcxGridDBBandedColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDataID: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ID'
        Visible = False
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDataActive: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Active'
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvDataRoom: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Room'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ValidateOnEnter = True
        Properties.OnValidate = tvDataRoomPropertiesValidate
        Width = 85
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDataDescription: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Description'
        Width = 154
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDataRoomType: TcxGridDBBandedColumn
        Caption = 'Type'
        DataBinding.FieldName = 'RoomType'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 31
            Kind = bkGlyph
          end>
        Properties.Images = DImages.PngImageList1
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = tvDataRoomTypePropertiesButtonClick
        Properties.OnValidate = tvDataRoomTypePropertiesValidate
        Width = 87
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDataEquipments: TcxGridDBBandedColumn
        Caption = 'Comments'
        DataBinding.FieldName = 'Equipments'
        Width = 175
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvDatauseInNationalReport: TcxGridDBBandedColumn
        Caption = 'National Report'
        DataBinding.FieldName = 'useInNationalReport'
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object tvDataLocation: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Location'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 31
            Kind = bkGlyph
          end>
        Properties.Images = DImages.PngImageList1
        Properties.ReadOnly = True
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = tvDataLocationPropertiesButtonClick
        Width = 126
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDataFloor: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Floor'
        PropertiesClassName = 'TcxSpinEditProperties'
        Width = 45
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDataBath: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Bath'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDataShower: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Shower'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object tvDataSafe: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Safe'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDataTv: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Tv'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvDataVideo: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Video'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object tvDataRadio: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Radio'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object tvDataCDPlayer: TcxGridDBBandedColumn
        DataBinding.FieldName = 'CDPlayer'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object tvDataTelephone: TcxGridDBBandedColumn
        Caption = 'Phone'
        DataBinding.FieldName = 'Telephone'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object tvDataPress: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Press'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object tvDataCoffee: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Coffee'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object tvDataKitchen: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Kitchen'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object tvDataMinibar: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Minibar'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object tvDataFridge: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Fridge'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object tvDataHairdryer: TcxGridDBBandedColumn
        Caption = 'Hair- dryer'
        DataBinding.FieldName = 'Hairdryer'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object tvDataInternetPlug: TcxGridDBBandedColumn
        DataBinding.FieldName = 'InternetPlug'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object tvDataFax: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Fax'
        Width = 50
        Position.BandIndex = 3
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object tvDataSqrMeters: TcxGridDBBandedColumn
        Caption = 'Size'
        DataBinding.FieldName = 'SqrMeters'
        Width = 45
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvDataBedSize: TcxGridDBBandedColumn
        DataBinding.FieldName = 'BedSize'
        Visible = False
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object tvDataBookable: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Bookable'
        Visible = False
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object tvDataStatistics: TcxGridDBBandedColumn
        Caption = 'Stat- istics'
        DataBinding.FieldName = 'Statistics'
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object tvDataStatus: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Status'
        Visible = False
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object tvDataOrderIndex: TcxGridDBBandedColumn
        Caption = 'Order'
        DataBinding.FieldName = 'OrderIndex'
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object tvDatahidden: TcxGridDBBandedColumn
        DataBinding.FieldName = 'hidden'
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object tvDataDorm: TcxGridDBBandedColumn
        DataBinding.FieldName = 'Dorm'
        Visible = False
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object tvDatawildcard: TcxGridDBBandedColumn
        Caption = 'Not Room'
        DataBinding.FieldName = 'wildcard'
        Width = 60
        Position.BandIndex = 3
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object mnuOther: TPopupMenu
    Left = 126
    Top = 232
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
    object S1: TMenuItem
      Caption = 'Set all rooms clean'
      OnClick = S1Click
    end
    object S2: TMenuItem
      Caption = 'Set all rooms unclean'
      OnClick = S2Click
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
    Left = 448
    Top = 240
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_Active: TBooleanField
      FieldName = 'Active'
    end
    object m_Room: TWideStringField
      FieldName = 'Room'
      Size = 8
    end
    object m_Description: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object m_RoomType: TWideStringField
      FieldName = 'RoomType'
      Size = 10
    end
    object m_Bath: TBooleanField
      FieldName = 'Bath'
    end
    object m_Shower: TBooleanField
      FieldName = 'Shower'
    end
    object m_Safe: TBooleanField
      FieldName = 'Safe'
    end
    object m_Tv: TBooleanField
      FieldName = 'Tv'
    end
    object m_Video: TBooleanField
      FieldName = 'Video'
    end
    object m_Radio: TBooleanField
      FieldName = 'Radio'
    end
    object m_CDPlayer: TBooleanField
      FieldName = 'CDPlayer'
    end
    object m_Telephone: TBooleanField
      FieldName = 'Telephone'
    end
    object m_Press: TBooleanField
      FieldName = 'Press'
    end
    object m_Coffee: TBooleanField
      FieldName = 'Coffee'
    end
    object m_Kitchen: TBooleanField
      FieldName = 'Kitchen'
    end
    object m_Minibar: TBooleanField
      FieldName = 'Minibar'
    end
    object m_Fridge: TBooleanField
      FieldName = 'Fridge'
    end
    object m_Hairdryer: TBooleanField
      FieldName = 'Hairdryer'
    end
    object m_InternetPlug: TBooleanField
      FieldName = 'InternetPlug'
    end
    object m_Fax: TBooleanField
      FieldName = 'Fax'
    end
    object m_SqrMeters: TFloatField
      FieldName = 'SqrMeters'
    end
    object m_BedSize: TWideStringField
      FieldName = 'BedSize'
      Size = 1
    end
    object m_Equipments: TWideStringField
      FieldName = 'Equipments'
      Size = 100
    end
    object m_Bookable: TBooleanField
      FieldName = 'Bookable'
    end
    object m_Statistics: TBooleanField
      FieldName = 'Statistics'
    end
    object m_Status: TWideStringField
      FieldName = 'Status'
      Size = 1
    end
    object m_OrderIndex: TIntegerField
      FieldName = 'OrderIndex'
    end
    object m_hidden: TBooleanField
      FieldName = 'hidden'
    end
    object m_Location: TWideStringField
      FieldName = 'Location'
      Size = 10
    end
    object m_Dorm: TWideStringField
      FieldName = 'Dorm'
    end
    object m_Floor: TIntegerField
      FieldName = 'Floor'
    end
    object m_useInNationalReport: TBooleanField
      FieldName = 'useInNationalReport'
    end
    object m_wildcard: TBooleanField
      FieldName = 'wildcard'
    end
  end
  object FormStore: TcxPropertiesStore
    Components = <>
    StorageName = 'Software\Roomer\FormStatus\Rooms3'
    StorageType = stRegistry
    Left = 214
    Top = 296
  end
end
