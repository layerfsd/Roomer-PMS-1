object frmReservationExtras: TfrmReservationExtras
  Left = 0
  Top = 0
  Caption = 'Reservation Extras'
  ClientHeight = 432
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 41
    Width = 781
    Height = 81
    Align = alTop
    TabOrder = 0
    object sGroupBox1: TsGroupBox
      Left = 1
      Top = 1
      Width = 779
      Height = 79
      Align = alClient
      Caption = 'Room info'
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object clabRoom: TsLabel
        Left = 12
        Top = 16
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Room : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object clabRomType: TsLabel
        Left = 12
        Top = 33
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Room type : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cLabCurrency: TsLabel
        Left = 12
        Top = 51
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Currency : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cLabAdults: TsLabel
        Left = 382
        Top = 16
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Adults : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cLabChildren: TsLabel
        Left = 386
        Top = 33
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Children : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object cLabInfants: TsLabel
        Left = 386
        Top = 51
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Infants : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labRoom: TsLabel
        Left = 97
        Top = 16
        Width = 4
        Height = 13
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labRoomType: TsLabel
        Left = 97
        Top = 33
        Width = 4
        Height = 13
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labCurrency: TsLabel
        Left = 97
        Top = 51
        Width = 4
        Height = 13
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labAdults: TsLabel
        Left = 475
        Top = 16
        Width = 4
        Height = 13
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labChildren: TsLabel
        Left = 475
        Top = 32
        Width = 4
        Height = 13
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labInfants: TsLabel
        Left = 475
        Top = 51
        Width = 4
        Height = 13
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object clabArrival: TsLabel
        Left = 198
        Top = 16
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Arrival : '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object clabDeparture: TsLabel
        Left = 202
        Top = 33
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Departure :  '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labArrival: TsLabel
        Left = 291
        Top = 16
        Width = 4
        Height = 13
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labDeparture: TsLabel
        Left = 291
        Top = 33
        Width = 4
        Height = 13
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object clabNights: TsLabel
        Left = 202
        Top = 51
        Width = 83
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Nights :  '
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labNights: TsLabel
        Left = 291
        Top = 51
        Width = 4
        Height = 13
        Caption = '-'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
    end
  end
  object grdExtras: TcxGrid
    Left = 0
    Top = 122
    Width = 781
    Height = 254
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = False
    object tvExtras: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = mExtrasDS
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = tvExtrasCount
        end
        item
          Kind = skSum
          Column = tvExtrasTotalPrice
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.ExpandMasterRowOnDblClick = False
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsData.Appending = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.FooterAutoHeight = True
      OptionsView.FooterMultiSummaries = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object tvExtrasItem: TcxGridDBColumn
        DataBinding.FieldName = 'Item'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = grdExtrasDBTableView1ItemPropertiesButtonClick
        Options.ShowEditButtons = isebAlways
      end
      object tvExtrasDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        PropertiesClassName = 'TcxTextEditProperties'
      end
      object tvExtrasCount: TcxGridDBColumn
        DataBinding.FieldName = 'Count'
        PropertiesClassName = 'TcxCalcEditProperties'
        HeaderAlignmentHorz = taCenter
      end
      object tvExtrasPricePerItemPerDay: TcxGridDBColumn
        Caption = 'Price Per Item Per Day'
        DataBinding.FieldName = 'PricePerItemPerDay'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
      end
      object tvExtrasFromdate: TcxGridDBColumn
        Caption = 'From'
        DataBinding.FieldName = 'Fromdate'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.ValidationOptions = [evoShowErrorIcon]
        HeaderAlignmentHorz = taCenter
      end
      object tvExtrasToDate: TcxGridDBColumn
        Caption = 'To'
        DataBinding.FieldName = 'ToDate'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
        HeaderAlignmentHorz = taCenter
      end
      object tvExtrasTotalPrice: TcxGridDBColumn
        Caption = 'Total Price'
        DataBinding.FieldName = 'Totalprice'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
      end
    end
    object grdExtrasLevel1: TcxGridLevel
      GridView = tvExtras
    end
  end
  object sbMain: TsStatusBar
    Left = 0
    Top = 413
    Width = 781
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object panBtn: TsPanel
    Left = 0
    Top = 376
    Width = 781
    Height = 37
    Align = alBottom
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      781
      37)
    object btnCancel: TsButton
      Left = 695
      Top = 6
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      HotImageIndex = 4
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 604
      Top = 6
      Width = 85
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object pnlTopButtons: TPanel
    Left = 0
    Top = 0
    Width = 781
    Height = 41
    Align = alTop
    TabOrder = 4
    object btnInsert: TsButton
      Left = 6
      Top = 8
      Width = 90
      Height = 25
      Hint = 'Add new record'
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btAddClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 102
      Top = 8
      Width = 91
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
      Left = 199
      Top = 8
      Width = 90
      Height = 25
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 2
      OnClick = btDeleteClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object mExtras: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Roomreservation'
        DataType = ftInteger
      end
      item
        Name = 'Itemid'
        DataType = ftInteger
      end
      item
        Name = 'Item'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Count'
        DataType = ftInteger
      end
      item
        Name = 'PricePerItemPerDay'
        DataType = ftFloat
      end
      item
        Name = 'Fromdate'
        DataType = ftDateTime
      end
      item
        Name = 'ToDate'
        DataType = ftDateTime
      end
      item
        Name = 'Totalprice'
        DataType = ftFloat
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.22.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = mExtrasBeforePost
    OnCalcFields = mExtrasCalcFields
    OnNewRecord = mExtrasNewRecord
    Left = 97
    Top = 168
    object mExtrasRoomreservation: TIntegerField
      FieldName = 'Roomreservation'
    end
    object mExtrasItemid: TIntegerField
      FieldName = 'Itemid'
    end
    object mExtrasItem: TStringField
      FieldName = 'Item'
    end
    object mExtrasDescription: TStringField
      FieldName = 'Description'
    end
    object mExtrasCount: TIntegerField
      FieldName = 'Count'
    end
    object mExtrasPricePerItemPerDay: TFloatField
      FieldName = 'PricePerItemPerDay'
    end
    object mExtrasFromdate: TDateTimeField
      FieldName = 'Fromdate'
    end
    object mExtrasToDate: TDateTimeField
      FieldName = 'ToDate'
    end
    object mExtrasTotalprice: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Totalprice'
      Calculated = True
    end
  end
  object mExtrasDS: TDataSource
    DataSet = mExtras
    OnDataChange = mExtrasDSDataChange
    Left = 96
    Top = 240
  end
end
