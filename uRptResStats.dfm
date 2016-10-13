object frmRptResStats: TfrmRptResStats
  Left = 0
  Top = 0
  Caption = 'Finance forecast'
  ClientHeight = 684
  ClientWidth = 1128
  Color = clBtnFace
  Constraints.MinWidth = 520
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 1128
    Height = 115
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object gbxSelectDates: TsGroupBox
      Left = 9
      Top = 4
      Width = 129
      Height = 75
      Caption = 'Select dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object dtDateFrom: TsDateEdit
        Left = 16
        Top = 18
        Width = 105
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
        TabOrder = 0
        Text = '  -  -    '
        OnChange = dtDateFromChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtDateTo: TsDateEdit
        Left = 16
        Top = 45
        Width = 105
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
        TabOrder = 1
        Text = '  -  -    '
        OnChange = dtDateToChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
    object gbxSelectMonths: TsGroupBox
      Left = 146
      Top = 4
      Width = 139
      Height = 75
      Caption = '.. or select month'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object cbxMonth: TsComboBox
        Left = 7
        Top = 18
        Width = 118
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 0
        Text = 'Select month ...'
        OnCloseUp = cbxMonthCloseUp
        Items.Strings = (
          'Select month ...'
          'January'
          'February'
          'March'
          'April'
          'May'
          'June'
          'July'
          'August'
          'September'
          'October'
          'November'
          'December')
      end
      object cbxYear: TsComboBox
        Left = 7
        Top = 45
        Width = 118
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 1
        Text = 'Select year ...'
        OnCloseUp = cbxMonthCloseUp
        Items.Strings = (
          'Veldu '#225'r ...'
          '2011'
          '2012'
          '2013'
          '2014'
          '2015'
          '2016'
          '2017'
          '2018'
          '2020')
      end
    end
    object btnRefresh: TsButton
      Left = 13
      Top = 82
      Width = 106
      Height = 27
      Caption = 'Refresh ALL'
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 2
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object sGroupBox1: TsGroupBox
      Left = 456
      Top = 1
      Width = 671
      Height = 113
      Align = alRight
      Anchors = [akTop, akRight]
      TabOrder = 3
      SkinData.SkinSection = 'TRANSPARENT'
      Checked = False
      DesignSize = (
        671
        113)
      object gbxUseStatusOfRooms: TsGroupBox
        Left = -1
        Top = 3
        Width = 312
        Height = 75
        Anchors = [akTop, akRight]
        Caption = 'Use Room with status of : '
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object chkExcluteWaitingList: TsCheckBox
          Left = 14
          Top = 17
          Width = 77
          Height = 17
          Caption = 'Waitinglist'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteAlotment: TsCheckBox
          Left = 14
          Top = 34
          Width = 73
          Height = 17
          Caption = 'Allotment'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteOrder: TsCheckBox
          Left = 14
          Top = 51
          Width = 83
          Height = 17
          Caption = 'Not Arrived'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteNoShow: TsCheckBox
          Left = 227
          Top = 34
          Width = 69
          Height = 17
          Caption = 'No show'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteDeparted: TsCheckBox
          Left = 129
          Top = 17
          Width = 73
          Height = 17
          Caption = 'Departed'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteBlocked: TsCheckBox
          Left = 227
          Top = 17
          Width = 64
          Height = 17
          Caption = 'Blocked'
          TabOrder = 5
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteGuest: TsCheckBox
          Left = 129
          Top = 34
          Width = 56
          Height = 17
          Caption = 'Guest'
          Checked = True
          State = cbChecked
          TabOrder = 6
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcludeWaitingListNonOptional: TsCheckBox
          Left = 129
          Top = 51
          Width = 77
          Height = 17
          Caption = 'Waitinglist'
          Checked = True
          State = cbChecked
          TabOrder = 7
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object gbxUseStatusNoRooms: TsGroupBox
        Left = 317
        Top = 3
        Width = 318
        Height = 75
        Anchors = [akTop, akRight]
        Caption = 'Use NO Rooms with status of : '
        TabOrder = 1
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object chkExcluteWaitingListNoRooms: TsCheckBox
          Left = 14
          Top = 17
          Width = 77
          Height = 17
          Caption = 'Waitinglist'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteAlotmentNoRooms: TsCheckBox
          Left = 14
          Top = 34
          Width = 73
          Height = 17
          Caption = 'Allotment'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteOrderNorooms: TsCheckBox
          Left = 14
          Top = 49
          Width = 83
          Height = 17
          Caption = 'Not Arrived'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteNoShowNoRooms: TsCheckBox
          Left = 215
          Top = 34
          Width = 69
          Height = 17
          Caption = 'No show'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteDepartedNoRooms: TsCheckBox
          Left = 129
          Top = 17
          Width = 73
          Height = 17
          Caption = 'Departed'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteBlockedNoRooms: TsCheckBox
          Left = 217
          Top = 17
          Width = 64
          Height = 17
          Caption = 'Blocked'
          TabOrder = 5
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcluteGuestNoRooms: TsCheckBox
          Left = 129
          Top = 34
          Width = 56
          Height = 17
          Caption = 'Guest'
          Checked = True
          State = cbChecked
          TabOrder = 6
          OnClick = chkExcluteWaitingListClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkExcludeWaitingListNonOptional_NoRooms: TsCheckBox
          Left = 129
          Top = 51
          Width = 77
          Height = 17
          Caption = 'Waitinglist'
          Checked = True
          State = cbChecked
          TabOrder = 7
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object btnsetUseStatusAsDefault: TsButton
        Left = 429
        Top = 84
        Width = 100
        Height = 26
        Anchors = [akTop, akRight]
        Caption = 'Set Default'
        TabOrder = 2
        OnClick = btnsetUseStatusAsDefaultClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnGetUseStatusAsDefault: TsButton
        Left = 535
        Top = 84
        Width = 100
        Height = 26
        Anchors = [akTop, akRight]
        Caption = 'Get Default'
        TabOrder = 3
        OnClick = btnGetUseStatusAsDefaultClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object pageMain: TsPageControl
    Left = 0
    Top = 115
    Width = 1128
    Height = 569
    ActivePage = SheetMainResult
    Align = alClient
    TabOrder = 1
    SkinData.SkinSection = 'PAGECONTROL'
    object SheetMainResult: TsTabSheet
      Caption = 'Result'
      OnShow = SheetMainResultShow
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 320
        Top = 0
        Width = 800
        Height = 541
        Align = alClient
        TabOrder = 0
        object Panel5: TPanel
          Left = 1
          Top = 1
          Width = 798
          Height = 360
          Align = alTop
          TabOrder = 0
          object sPageControl2: TsPageControl
            Left = 1
            Top = 1
            Width = 796
            Height = 358
            ActivePage = sTabSheet2
            Align = alClient
            TabOrder = 0
            SkinData.SkinSection = 'PAGECONTROL'
            object sTabSheet2: TsTabSheet
              Caption = 'Result'
              OnShow = sTabSheet2Show
              SkinData.CustomColor = False
              SkinData.CustomFont = False
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object pg001: TcxDBPivotGrid
                Left = 0
                Top = 33
                Width = 788
                Height = 297
                Customization.FormStyle = cfsAdvanced
                Align = alClient
                DataSource = RoomsDateDS
                Groups = <>
                LookAndFeel.NativeStyle = False
                OptionsPrefilter.CustomizeButton = False
                OptionsPrefilter.MRUItemsList = False
                OptionsSelection.MultiSelect = True
                OptionsView.ColumnFields = False
                OptionsView.ColumnTotalsLocation = ctlNear
                OptionsView.DataFields = False
                OptionsView.FilterFields = False
                OptionsView.RowFields = False
                TabOrder = 0
                object pg001incomeTotal: TcxDBPivotGridField
                  Area = faData
                  AreaIndex = 2
                  IsCaptionAssigned = True
                  Caption = 'Income'
                  DataBinding.FieldName = 'incomeTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Income'
                end
                object pg001RoomCount: TcxDBPivotGridField
                  Area = faData
                  AreaIndex = 0
                  IsCaptionAssigned = True
                  Caption = 'Rooms'
                  DataBinding.FieldName = 'NoOfRooms'
                  Visible = True
                  UniqueName = 'Rooms'
                end
                object pg001RRGuestCount: TcxDBPivotGridField
                  Area = faData
                  AreaIndex = 1
                  IsCaptionAssigned = True
                  Caption = 'Guests'
                  DataBinding.FieldName = 'RRGuestCount'
                  Visible = True
                  UniqueName = 'Guests'
                end
                object pg001CustomerType: TcxDBPivotGridField
                  Area = faColumn
                  AreaIndex = 0
                  IsCaptionAssigned = True
                  Caption = 'Market'
                  DataBinding.FieldName = 'CustomerType'
                  Visible = True
                  UniqueName = 'Market'
                end
                object pg001dtDate: TcxDBPivotGridField
                  Area = faRow
                  AreaIndex = 0
                  IsCaptionAssigned = True
                  Caption = 'Date'
                  DataBinding.FieldName = 'dtDate'
                  Visible = True
                  UniqueName = 'Date'
                end
                object pg00Week: TcxDBPivotGridField
                  AreaIndex = 0
                  IsCaptionAssigned = True
                  Caption = 'Week'
                  DataBinding.FieldName = 'dtDate'
                  GroupInterval = giDateWeekOfYear
                  Visible = True
                  UniqueName = 'Week'
                end
                object pg001Month: TcxDBPivotGridField
                  AreaIndex = 1
                  IsCaptionAssigned = True
                  Caption = 'Month'
                  DataBinding.FieldName = 'dtDate'
                  GroupInterval = giDateMonth
                  Visible = True
                  UniqueName = 'Month'
                end
                object pg001RoomType: TcxDBPivotGridField
                  AreaIndex = 2
                  IsCaptionAssigned = True
                  Caption = 'Room Type'
                  DataBinding.FieldName = 'RoomType'
                  Visible = True
                  UniqueName = 'Type'
                end
                object pg001Room: TcxDBPivotGridField
                  AreaIndex = 3
                  IsCaptionAssigned = True
                  Caption = 'Room nr'
                  DataBinding.FieldName = 'Room'
                  Visible = True
                  UniqueName = 'Room'
                end
                object pg001StatusText: TcxDBPivotGridField
                  AreaIndex = 4
                  IsCaptionAssigned = True
                  Caption = 'Status'
                  DataBinding.FieldName = 'StatusText'
                  Visible = True
                  UniqueName = 'Status'
                end
                object pg001Country: TcxDBPivotGridField
                  AreaIndex = 5
                  DataBinding.FieldName = 'Country'
                  UniqueName = 'Country'
                end
                object pg001Location: TcxDBPivotGridField
                  AreaIndex = 6
                  DataBinding.FieldName = 'Location'
                  Visible = True
                  UniqueName = 'Location'
                end
                object pg001currency: TcxDBPivotGridField
                  AreaIndex = 7
                  IsCaptionAssigned = True
                  Caption = 'Currency'
                  DataBinding.FieldName = 'currency'
                  UniqueName = 'Currency'
                end
                object pg001CustomerName: TcxDBPivotGridField
                  AreaIndex = 8
                  IsCaptionAssigned = True
                  Caption = 'Cust. Name'
                  DataBinding.FieldName = 'CustomerName'
                  Visible = True
                  UniqueName = 'CustomerName'
                end
                object pg001Customer: TcxDBPivotGridField
                  AreaIndex = 9
                  IsCaptionAssigned = True
                  Caption = 'Customer'
                  DataBinding.FieldName = 'Customer'
                  UniqueName = 'Customer'
                end
                object pg001IncomeTotalNoVAT: TcxDBPivotGridField
                  AreaIndex = 59
                  IsCaptionAssigned = True
                  Caption = 'Income no VAT'
                  DataBinding.FieldName = 'IncomeTotalWoVAT'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Income no VAT'
                end
                object pg001RoomRentTotal: TcxDBPivotGridField
                  AreaIndex = 54
                  IsCaptionAssigned = True
                  Caption = 'Rent'
                  DataBinding.FieldName = 'RoomRentTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Rent'
                end
                object pg001RoomRentTotalWoVAT: TcxDBPivotGridField
                  AreaIndex = 55
                  IsCaptionAssigned = True
                  Caption = 'Rent no VAT'
                  DataBinding.FieldName = 'RoomRentTotalWoVAT'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Rent no VAT'
                end
                object pg001RoomRentBilled: TcxDBPivotGridField
                  AreaIndex = 10
                  IsCaptionAssigned = True
                  Caption = 'Rent billed'
                  DataBinding.FieldName = 'RoomRentBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Rent billed'
                end
                object pg001RoomRentUnBilled: TcxDBPivotGridField
                  AreaIndex = 11
                  IsCaptionAssigned = True
                  Caption = 'Rent unbilled'
                  DataBinding.FieldName = 'RoomRentUnBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Rent unbilled'
                end
                object pg001RoomDiscountTotal: TcxDBPivotGridField
                  AreaIndex = 53
                  IsCaptionAssigned = True
                  Caption = 'Rent disc.'
                  DataBinding.FieldName = 'RoomDiscountTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Rent disc.'
                end
                object pg001RoomDiscountBilled: TcxDBPivotGridField
                  AreaIndex = 52
                  IsCaptionAssigned = True
                  Caption = 'Rent disc billed'
                  DataBinding.FieldName = 'RoomDiscountBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Rent disc billed'
                end
                object pg001RoomDiscountUnBilled: TcxDBPivotGridField
                  AreaIndex = 51
                  IsCaptionAssigned = True
                  Caption = 'Rent disc unbilled'
                  DataBinding.FieldName = 'RoomDiscountUnBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Rent disc unbilled'
                end
                object pg001ItemsTotal: TcxDBPivotGridField
                  AreaIndex = 56
                  IsCaptionAssigned = True
                  Caption = 'Items'
                  DataBinding.FieldName = 'ItemsTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Items'
                end
                object pg001ItemsBilled: TcxDBPivotGridField
                  AreaIndex = 12
                  IsCaptionAssigned = True
                  Caption = 'Items billed'
                  DataBinding.FieldName = 'ItemsBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Items billed'
                end
                object pg001itemsUnBilled: TcxDBPivotGridField
                  AreaIndex = 13
                  IsCaptionAssigned = True
                  Caption = 'items unbilled'
                  DataBinding.FieldName = 'itemsUnBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'items unbilled'
                end
                object pg001VatTotal: TcxDBPivotGridField
                  AreaIndex = 60
                  IsCaptionAssigned = True
                  Caption = 'VAT Total'
                  DataBinding.FieldName = 'VatTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'VAT Total'
                end
                object pg001VatBilled: TcxDBPivotGridField
                  AreaIndex = 61
                  IsCaptionAssigned = True
                  Caption = 'VAT billed'
                  DataBinding.FieldName = 'VatBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'VAT billed'
                end
                object pg001VatUnbilled: TcxDBPivotGridField
                  AreaIndex = 14
                  IsCaptionAssigned = True
                  Caption = 'VAT not billed'
                  DataBinding.FieldName = 'VatUnbilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'VAT not billed'
                end
                object pg001CtaxTotal: TcxDBPivotGridField
                  AreaIndex = 15
                  IsCaptionAssigned = True
                  Caption = 'Citytax Total'
                  DataBinding.FieldName = 'CtaxTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'City Tax Total'
                end
                object pg001CTaxTotalWoVAT: TcxDBPivotGridField
                  AreaIndex = 57
                  IsCaptionAssigned = True
                  Caption = 'Citytax no VAT'
                  DataBinding.FieldName = 'CtaxTotalWoVAT'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Citytax no VAT'
                end
                object pg001CtaxBilled: TcxDBPivotGridField
                  AreaIndex = 16
                  IsCaptionAssigned = True
                  Caption = 'City tax billed'
                  DataBinding.FieldName = 'CtaxBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'City tax billed'
                end
                object pg001CtaxUnbilled: TcxDBPivotGridField
                  AreaIndex = 17
                  IsCaptionAssigned = True
                  Caption = 'City tax unbilled'
                  DataBinding.FieldName = 'CtaxUnbilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'City tax unbilled'
                end
                object pg001TaxesTotal: TcxDBPivotGridField
                  AreaIndex = 18
                  IsCaptionAssigned = True
                  Caption = 'Taxes'
                  DataBinding.FieldName = 'TaxesTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Taxes'
                end
                object pg001TaxesBilled: TcxDBPivotGridField
                  AreaIndex = 19
                  IsCaptionAssigned = True
                  Caption = 'Taxes billed'
                  DataBinding.FieldName = 'TaxesBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Taxes billed'
                end
                object pg001TaxesUnbilled: TcxDBPivotGridField
                  AreaIndex = 20
                  IsCaptionAssigned = True
                  Caption = 'Taxes unbilled'
                  DataBinding.FieldName = 'TaxesUnbilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Taxes unbilled'
                end
                object pg001DayCount: TcxDBPivotGridField
                  AreaIndex = 21
                  IsCaptionAssigned = True
                  Caption = 'Days'
                  DataBinding.FieldName = 'DayCount'
                  UniqueName = 'Days'
                end
                object pg001RvGuestCount: TcxDBPivotGridField
                  AreaIndex = 22
                  IsCaptionAssigned = True
                  Caption = 'Res guests'
                  DataBinding.FieldName = 'RvGuestCount'
                  UniqueName = 'Res guests'
                end
                object pg001CurrencyRate: TcxDBPivotGridField
                  AreaIndex = 23
                  IsCaptionAssigned = True
                  Caption = 'Curr Rate'
                  DataBinding.FieldName = 'CurrencyRate'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.000;-,0.000'
                  UniqueName = 'Curr Rate'
                end
                object pg001discountAmount: TcxDBPivotGridField
                  AreaIndex = 24
                  IsCaptionAssigned = True
                  Caption = 'Discount amount'
                  DataBinding.FieldName = 'discountAmount'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Hidden = True
                  UniqueName = 'Discount amount'
                end
                object pg001discount: TcxDBPivotGridField
                  AreaIndex = 25
                  IsCaptionAssigned = True
                  Caption = 'Discount'
                  DataBinding.FieldName = 'discount'
                  Hidden = True
                  UniqueName = 'Discount'
                end
                object pg001isPercentage: TcxDBPivotGridField
                  AreaIndex = 26
                  IsCaptionAssigned = True
                  Caption = 'Is %'
                  DataBinding.FieldName = 'isPercentage'
                  Hidden = True
                  UniqueName = 'Is %'
                end
                object pg001NativeRate: TcxDBPivotGridField
                  AreaIndex = 27
                  IsCaptionAssigned = True
                  Caption = 'Native rate'
                  DataBinding.FieldName = 'NativeRate'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.000;-,0.000'
                  UniqueName = 'Native rate'
                end
                object pg001sArrival: TcxDBPivotGridField
                  AreaIndex = 28
                  IsCaptionAssigned = True
                  Caption = 'Arrival'
                  DataBinding.FieldName = 'sArrival'
                  UniqueName = 'Arrival'
                end
                object pg001sDeparture: TcxDBPivotGridField
                  AreaIndex = 29
                  IsCaptionAssigned = True
                  Caption = 'Departure'
                  DataBinding.FieldName = 'sDeparture'
                  UniqueName = 'Departure'
                end
                object pg001MainGuests: TcxDBPivotGridField
                  AreaIndex = 30
                  IsCaptionAssigned = True
                  Caption = 'Guest name'
                  DataBinding.FieldName = 'MainGuests'
                  UniqueName = 'Guest name'
                end
                object pg001paid: TcxDBPivotGridField
                  AreaIndex = 31
                  IsCaptionAssigned = True
                  Caption = 'Is paid'
                  DataBinding.FieldName = 'paid'
                  UniqueName = 'Is paid'
                end
                object pg001isNoroom: TcxDBPivotGridField
                  AreaIndex = 32
                  IsCaptionAssigned = True
                  Caption = 'No room'
                  DataBinding.FieldName = 'isNoroom'
                  UniqueName = 'No room'
                end
                object pg001roomReservation: TcxDBPivotGridField
                  AreaIndex = 33
                  IsCaptionAssigned = True
                  Caption = 'Room Reservation'
                  DataBinding.FieldName = 'roomReservation'
                  UniqueName = 'roomReservation'
                end
                object pg001Reservation: TcxDBPivotGridField
                  AreaIndex = 34
                  DataBinding.FieldName = 'Reservation'
                  UniqueName = 'Reservation'
                end
                object pg001ResFlag: TcxDBPivotGridField
                  AreaIndex = 35
                  IsCaptionAssigned = True
                  Caption = 'Status char'
                  DataBinding.FieldName = 'ResFlag'
                  UniqueName = 'Status char'
                end
                object pg001FilterFlag: TcxDBPivotGridField
                  AreaIndex = 36
                  IsCaptionAssigned = True
                  Caption = 'Status Filter char'
                  DataBinding.FieldName = 'FilterFlag'
                  UniqueName = 'Status Filter char'
                end
                object pg001Invoicenumbers: TcxDBPivotGridField
                  AreaIndex = 37
                  DataBinding.FieldName = 'Invoicenumbers'
                  UniqueName = 'Invoicenumbers'
                end
                object pg001aDate: TcxDBPivotGridField
                  AreaIndex = 38
                  IsCaptionAssigned = True
                  Caption = 'Date std'
                  DataBinding.FieldName = 'aDate'
                  UniqueName = 'Date std'
                end
                object pg001ItemsTotalWoVAT: TcxDBPivotGridField
                  AreaIndex = 58
                  IsCaptionAssigned = True
                  Caption = 'Items no VAT'
                  DataBinding.FieldName = 'ItemsTotalWoVAT'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Visible = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'Items no VAT'
                end
                object pg001vatItemsTotal: TcxDBPivotGridField
                  AreaIndex = 39
                  IsCaptionAssigned = True
                  Caption = 'Items VAT'
                  DataBinding.FieldName = 'vatItemsTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatItemsTotal'
                end
                object pg001vatItemsUnbilled: TcxDBPivotGridField
                  AreaIndex = 40
                  DataBinding.FieldName = 'vatItemsUnbilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatItemsUnbilled'
                end
                object pg001vatItemsBilled: TcxDBPivotGridField
                  AreaIndex = 41
                  IsCaptionAssigned = True
                  Caption = 'vatItemsBilled'
                  DataBinding.FieldName = 'vatItemsBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatItemsTotal'
                end
                object pg001vatRentTotal: TcxDBPivotGridField
                  AreaIndex = 42
                  IsCaptionAssigned = True
                  Caption = 'Rent VAT'
                  DataBinding.FieldName = 'vatRentTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatRentTotal'
                end
                object pg001vatRentBilled: TcxDBPivotGridField
                  AreaIndex = 43
                  DataBinding.FieldName = 'vatRentBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatRentBilled'
                end
                object pg001VatRentUnbilled: TcxDBPivotGridField
                  AreaIndex = 44
                  DataBinding.FieldName = 'VatRentUnbilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatRentUnbilled'
                end
                object pg001vatCtaxTotal: TcxDBPivotGridField
                  AreaIndex = 45
                  IsCaptionAssigned = True
                  Caption = 'Citytax VAT'
                  DataBinding.FieldName = 'vatCtaxTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatCtaxTotal'
                end
                object pg001vatCtaxbilled: TcxDBPivotGridField
                  AreaIndex = 46
                  DataBinding.FieldName = 'vatCtaxbilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatCtaxbilled'
                end
                object pg001vatCtaxUnbilled: TcxDBPivotGridField
                  AreaIndex = 47
                  DataBinding.FieldName = 'vatCtaxUnbilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatCtaxUnbilled'
                end
                object pg001vatDiscountTotal: TcxDBPivotGridField
                  AreaIndex = 48
                  IsCaptionAssigned = True
                  Caption = 'Discount VAT'
                  DataBinding.FieldName = 'vatDiscountTotal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatDiscountTotal'
                end
                object pg001vatDiscountBilled: TcxDBPivotGridField
                  AreaIndex = 49
                  DataBinding.FieldName = 'vatDiscountBilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatDiscountBilled'
                end
                object pg001vatDiscountUnbilled: TcxDBPivotGridField
                  AreaIndex = 50
                  DataBinding.FieldName = 'vatDiscountUnbilled'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Hidden = True
                  OnGetProperties = pg001incomeTotalGetProperties
                  UniqueName = 'vatDiscountUnbilled'
                end
              end
              object sPanel7: TsPanel
                Left = 0
                Top = 0
                Width = 788
                Height = 33
                Align = alTop
                TabOrder = 1
                SkinData.SkinSection = 'TRANSPARENT'
                object labIsFiltered: TsLabel
                  Left = 310
                  Top = 7
                  Width = 4
                  Height = 13
                  Caption = '-'
                end
                object btnPivgrRequestsBestfit: TsButton
                  Left = 204
                  Top = 4
                  Width = 100
                  Height = 25
                  Caption = 'Best Fit'
                  Images = DImages.PngImageList1
                  TabOrder = 0
                  OnClick = btnPivgrRequestsBestfitClick
                  SkinData.SkinSection = 'BUTTON'
                end
                object btnpivgrRequestsPrint: TsButton
                  Left = 103
                  Top = 4
                  Width = 100
                  Height = 25
                  Hint = 'Print'
                  Caption = 'Print Grid'
                  ImageIndex = 3
                  Images = DImages.PngImageList1
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 1
                  OnClick = btnpivgrRequestsPrintClick
                  SkinData.SkinSection = 'BUTTON'
                end
                object btnPivgrRequestsExcel: TsButton
                  Left = 2
                  Top = 4
                  Width = 100
                  Height = 25
                  Caption = 'Excel'
                  ImageIndex = 132
                  Images = DImages.PngImageList1
                  TabOrder = 2
                  OnClick = btnPivgrRequestsExcelClick
                  SkinData.SkinSection = 'BUTTON'
                end
              end
            end
            object sTabSheet3: TsTabSheet
              Caption = 'Graph'
              SkinData.CustomColor = False
              SkinData.CustomFont = False
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object cxGrid: TcxGrid
                Left = 0
                Top = 0
                Width = 788
                Height = 330
                Align = alClient
                TabOrder = 0
                LookAndFeel.NativeStyle = False
                object cxGridDBTableView1: TcxGridDBTableView
                  Navigator.Buttons.CustomButtons = <>
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                end
                object cxGridChartView: TcxGridChartView
                  DiagramColumn.Active = True
                  ToolBox.CustomizeButton = True
                  ToolBox.DiagramSelector = True
                end
                object cxGridLevel: TcxGridLevel
                  GridView = cxGridChartView
                end
              end
            end
          end
        end
        object cxSplitter2: TcxSplitter
          Left = 1
          Top = 361
          Width = 798
          Height = 8
          HotZoneClassName = 'TcxMediaPlayer8Style'
          AlignSplitter = salTop
          NativeBackground = False
          Control = Panel5
          ExplicitWidth = 8
        end
        object Panel6: TPanel
          Left = 1
          Top = 369
          Width = 798
          Height = 171
          Align = alClient
          TabOrder = 2
          object grDrill: TcxGrid
            Left = 1
            Top = 46
            Width = 796
            Height = 124
            Align = alClient
            TabOrder = 0
            LookAndFeel.NativeStyle = False
            object tvDrill001: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = Dril001DS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.GroupByBox = False
            end
            object grDrillLevel1: TcxGridLevel
              GridView = tvDrill001
            end
          end
          object sPanel6: TsPanel
            Left = 1
            Top = 1
            Width = 796
            Height = 45
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            SkinData.SkinSection = 'TRANSPARENT'
            object btnGrDrillExcel: TsButton
              Left = 6
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Excel'
              ImageIndex = 132
              Images = DImages.PngImageList1
              TabOrder = 0
              OnClick = btnGrDrillExcelClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnGrdrillPrint: TsButton
              Left = 112
              Top = 2
              Width = 100
              Height = 37
              Hint = 'Print'
              Caption = 'Print grid'
              ImageIndex = 3
              Images = DImages.PngImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = btnGrdrillPrintClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnGrDrillBestFit: TsButton
              Left = 218
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Best Fit'
              Images = DImages.PngImageList1
              TabOrder = 2
              OnClick = btnGrDrillBestFitClick
              SkinData.SkinSection = 'BUTTON'
            end
            object sButton2: TsButton
              Left = 324
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Format fields'
              Images = DImages.PngImageList1
              TabOrder = 3
              OnClick = sButton2Click
              SkinData.SkinSection = 'BUTTON'
            end
            object sButton3: TsButton
              Left = 430
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Reservation'
              ImageIndex = 56
              Images = DImages.PngImageList1
              TabOrder = 4
              OnClick = sButton3Click
              SkinData.SkinSection = 'BUTTON'
            end
            object sButton4: TsButton
              Left = 536
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Room/Guests'
              ImageIndex = 39
              Images = DImages.PngImageList1
              TabOrder = 5
              OnClick = sButton4Click
              SkinData.SkinSection = 'BUTTON'
            end
          end
        end
      end
      object cxSplitter1: TcxSplitter
        Left = 312
        Top = 0
        Width = 8
        Height = 541
        HotZoneClassName = 'TcxMediaPlayer8Style'
        Control = sPanel2
      end
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 312
        Height = 541
        Align = alLeft
        TabOrder = 2
        SkinData.SkinSection = 'TRANSPARENT'
        object sPanel4: TsPanel
          Left = 1
          Top = 1
          Width = 310
          Height = 60
          Align = alTop
          TabOrder = 0
          SkinData.SkinSection = 'TRANSPARENT'
          DesignSize = (
            310
            60)
          object sSpeedButton1: TsSpeedButton
            Left = 278
            Top = 4
            Width = 23
            Height = 22
            Anchors = [akTop, akRight]
            Caption = '?'
            ParentShowHint = False
            ShowHint = True
            OnClick = sSpeedButton1Click
          end
          object cbxSel: TsComboBox
            Left = 5
            Top = 3
            Width = 267
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Alignment = taLeftJustify
            SkinData.SkinSection = 'COMBOBOX'
            VerticalAlignment = taAlignTop
            Style = csDropDownList
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = -1
            ParentFont = False
            TabOrder = 0
            OnCloseUp = cbxSelCloseUp
          end
          object btnSetDefaultLayout: TsButton
            Left = 103
            Top = 30
            Width = 96
            Height = 26
            Caption = 'Set default'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Images = DImages.PngImageList1
            ParentFont = False
            TabOrder = 1
            OnClick = btnSetDefaultLayoutClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnSaveLayout: TsButton
            Left = 5
            Top = 30
            Width = 96
            Height = 26
            Caption = 'Create'
            ImageIndex = 23
            Images = DImages.PngImageList1
            TabOrder = 2
            OnClick = btnSaveLayoutClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnUpdateLayout: TsButton
            Left = 5
            Top = 58
            Width = 106
            Height = 26
            Caption = 'Update'
            ImageIndex = 25
            Images = DImages.PngImageList1
            TabOrder = 3
            Visible = False
            SkinData.SkinSection = 'BUTTON'
          end
          object cxButton1: TsButton
            Left = 201
            Top = 30
            Width = 96
            Height = 26
            Caption = 'Delete'
            ImageIndex = 25
            Images = DImages.PngImageList1
            TabOrder = 4
            OnClick = cxButton1Click
            SkinData.SkinSection = 'BUTTON'
          end
        end
        object gbxCustomization: TsGroupBox
          Left = 1
          Top = 61
          Width = 310
          Height = 479
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
        end
      end
    end
    object sheetMainData: TsTabSheet
      Caption = 'Data'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pageData: TsPageControl
        Left = 0
        Top = 0
        Width = 1120
        Height = 541
        ActivePage = sTabSheet7
        Align = alClient
        TabOrder = 0
        SkinData.SkinSection = 'PAGECONTROL'
        object sTabSheet7: TsTabSheet
          Caption = 'Reservations'
          SkinData.CustomColor = False
          SkinData.CustomFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel2: TsPanel
            Left = 0
            Top = 0
            Width = 1112
            Height = 45
            Align = alTop
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            object btnExcelRoomsDate: TsButton
              Left = 2
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Excel'
              ImageIndex = 132
              Images = DImages.PngImageList1
              TabOrder = 0
              OnClick = btnExcelRoomsDateClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnReservationRoomsDate: TsButton
              Left = 108
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Reservation'
              ImageIndex = 56
              Images = DImages.PngImageList1
              TabOrder = 1
              OnClick = btnReservationRoomsDateClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnRoomRoomsDate: TsButton
              Left = 214
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Room/Guests'
              ImageIndex = 39
              Images = DImages.PngImageList1
              TabOrder = 2
              OnClick = btnRoomRoomsDateClick
              SkinData.SkinSection = 'BUTTON'
            end
          end
          object grRoomsDate: TcxGrid
            Left = 0
            Top = 45
            Width = 1112
            Height = 468
            Align = alClient
            TabOrder = 1
            LookAndFeel.NativeStyle = False
            object tvRoomsDate: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = RoomsDateDS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'incomeTotal'
                  Column = tvRoomsDateincomeTotal
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'discountAmount'
                  Column = tvRoomsDatediscountAmount
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'ItemsBilled'
                  Column = tvRoomsDateItemsBilled
                end
                item
                  Format = ',0.00;-,0.00'#39
                  Kind = skSum
                  FieldName = 'ItemsTotal'
                  Column = tvRoomsDateItemsTotal
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'itemsUnBilled'
                  Column = tvRoomsDateitemsUnBilled
                end
                item
                  Format = '#,##0.;-#,##0.'
                  Kind = skAverage
                  FieldName = 'RoomCount'
                  Column = tvRoomsDateRoomCount
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'RoomDiscountTotal'
                  Column = tvRoomsDateRoomDiscountTotal
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'RoomDiscountUnBilled'
                  Column = tvRoomsDateRoomDiscountUnBilled
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'RoomRentTotal'
                  Column = tvRoomsDateRoomRentTotal
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'TaxesTotal'
                  Column = tvRoomsDateTaxesTotal
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'RoomRentBilled'
                  Column = tvRoomsDateRoomRentBilled
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'RoomRentUnBilled'
                  Column = tvRoomsDateRoomRentUnBilled
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'RoomDiscountBilled'
                  Column = tvRoomsDateRoomDiscountBilled
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'TaxesBilled'
                  Column = tvRoomsDateTaxesBilled
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'RoomRentUnBilled'
                  Column = tvRoomsDateRoomRentUnBilled
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'RoomDiscountUnBilled'
                  Column = tvRoomsDateRoomDiscountUnBilled
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'NativeRate'
                  Column = tvRoomsDateNativeRate
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'NettoRent'
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'TaxesUnbilled'
                  Column = tvRoomsDateTaxesUnbilled
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.Footer = True
              object tvRoomsDatedtDate: TcxGridDBColumn
                Caption = 'Date'
                DataBinding.FieldName = 'dtDate'
              end
              object tvRoomsDateRoom: TcxGridDBColumn
                DataBinding.FieldName = 'Room'
              end
              object tvRoomsDateRoomType: TcxGridDBColumn
                Caption = 'Type'
                DataBinding.FieldName = 'RoomType'
                Width = 48
              end
              object tvRoomsDateStatusText: TcxGridDBColumn
                Caption = 'Status'
                DataBinding.FieldName = 'StatusText'
                Width = 116
              end
              object tvRoomsDateisNoroom: TcxGridDBColumn
                Caption = 'No room'
                DataBinding.FieldName = 'isNoroom'
                Width = 52
              end
              object tvRoomsDateLocation: TcxGridDBColumn
                DataBinding.FieldName = 'Location'
              end
              object tvRoomsDateCountry: TcxGridDBColumn
                DataBinding.FieldName = 'Country'
                Width = 32
              end
              object tvRoomsDateCustomer: TcxGridDBColumn
                DataBinding.FieldName = 'Customer'
                Width = 114
              end
              object tvRoomsDateCustomerName: TcxGridDBColumn
                DataBinding.FieldName = 'CustomerName'
                Width = 256
              end
              object tvRoomsDateCustomerType: TcxGridDBColumn
                Caption = 'Market'
                DataBinding.FieldName = 'CustomerType'
              end
              object tvRoomsDateincomeTotal: TcxGridDBColumn
                Caption = 'Income'
                DataBinding.FieldName = 'incomeTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
                Width = 81
              end
              object tvRoomsDateRoomRentTotal: TcxGridDBColumn
                Caption = 'Rent'
                DataBinding.FieldName = 'RoomRentTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateRoomDiscountTotal: TcxGridDBColumn
                Caption = 'Rent disc'
                DataBinding.FieldName = 'RoomDiscountTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateItemsTotal: TcxGridDBColumn
                Caption = 'Items'
                DataBinding.FieldName = 'ItemsTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateTaxesTotal: TcxGridDBColumn
                Caption = 'Taxes'
                DataBinding.FieldName = 'TaxesTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateRRGuestCount: TcxGridDBColumn
                Caption = 'Guests'
                DataBinding.FieldName = 'RRGuestCount'
              end
              object tvRoomsDateMainGuests: TcxGridDBColumn
                Caption = 'Guest name'
                DataBinding.FieldName = 'MainGuests'
                Width = 215
              end
              object tvRoomsDatepaid: TcxGridDBColumn
                Caption = 'Is paid'
                DataBinding.FieldName = 'paid'
                Width = 39
              end
              object tvRoomsDateRoomRentBilled: TcxGridDBColumn
                Caption = 'Rent billed'
                DataBinding.FieldName = 'RoomRentBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateRoomDiscountBilled: TcxGridDBColumn
                Caption = 'Rent Disc billed'
                DataBinding.FieldName = 'RoomDiscountBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateItemsBilled: TcxGridDBColumn
                Caption = 'Items billed'
                DataBinding.FieldName = 'ItemsBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateTaxesBilled: TcxGridDBColumn
                Caption = 'Taxes billed'
                DataBinding.FieldName = 'TaxesBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateRoomRentUnBilled: TcxGridDBColumn
                Caption = 'Rent unbilled'
                DataBinding.FieldName = 'RoomRentUnBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateRoomDiscountUnBilled: TcxGridDBColumn
                Caption = 'Rent disc unbilled'
                DataBinding.FieldName = 'RoomDiscountUnBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateitemsUnBilled: TcxGridDBColumn
                Caption = 'Items unbilled'
                DataBinding.FieldName = 'itemsUnBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDateTaxesUnbilled: TcxGridDBColumn
                Caption = 'Taxes unbilled'
                DataBinding.FieldName = 'TaxesUnbilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDatecurrency: TcxGridDBColumn
                Caption = 'Currency'
                DataBinding.FieldName = 'currency'
                Width = 53
              end
              object tvRoomsDateCurrencyRate: TcxGridDBColumn
                Caption = 'Curr Rate'
                DataBinding.FieldName = 'CurrencyRate'
              end
              object tvRoomsDateNativeRate: TcxGridDBColumn
                Caption = 'Native Rate'
                DataBinding.FieldName = 'NativeRate'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDatediscount: TcxGridDBColumn
                Caption = 'Discount'
                DataBinding.FieldName = 'discount'
              end
              object tvRoomsDateisPercentage: TcxGridDBColumn
                Caption = 'is %'
                DataBinding.FieldName = 'isPercentage'
              end
              object tvRoomsDatediscountAmount: TcxGridDBColumn
                Caption = 'disc Amount'
                DataBinding.FieldName = 'discountAmount'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvRoomsDatesArrival: TcxGridDBColumn
                Caption = 'Arrival'
                DataBinding.FieldName = 'sArrival'
              end
              object tvRoomsDatesDeparture: TcxGridDBColumn
                Caption = 'Departure'
                DataBinding.FieldName = 'sDeparture'
              end
              object tvRoomsDateDayCount: TcxGridDBColumn
                Caption = 'Room Days'
                DataBinding.FieldName = 'DayCount'
              end
              object tvRoomsDateRoomCount: TcxGridDBColumn
                Caption = 'Room Count'
                DataBinding.FieldName = 'RoomCount'
              end
              object tvRoomsDateRvGuestCount: TcxGridDBColumn
                Caption = 'Res Guests'
                DataBinding.FieldName = 'RvGuestCount'
                Width = 93
              end
              object tvRoomsDateroomReservation: TcxGridDBColumn
                Caption = 'RoomRes No'
                DataBinding.FieldName = 'roomReservation'
              end
              object tvRoomsDateReservation: TcxGridDBColumn
                Caption = 'Res No'
                DataBinding.FieldName = 'Reservation'
              end
              object tvRoomsDateInvoicenumbers: TcxGridDBColumn
                Caption = 'Invoice numbers'
                DataBinding.FieldName = 'Invoicenumbers'
                Width = 268
              end
              object tvRoomsDateResFlag: TcxGridDBColumn
                DataBinding.FieldName = 'ResFlag'
                Visible = False
              end
              object tvRoomsDateFilterFlag: TcxGridDBColumn
                Caption = 'Status Filter char'
                DataBinding.FieldName = 'FilterFlag'
                Visible = False
              end
              object tvRoomsDateaDate: TcxGridDBColumn
                DataBinding.FieldName = 'aDate'
                Visible = False
              end
              object tvRoomsDateRoomCount2: TcxGridDBColumn
                DataBinding.FieldName = 'RoomCount2'
                Visible = False
              end
              object tvRoomsDateNoOfRooms: TcxGridDBColumn
                DataBinding.FieldName = 'NoOfRooms'
              end
              object tvRoomsDateItemId: TcxGridDBColumn
                DataBinding.FieldName = 'ItemId'
              end
              object tvRoomsDateIncomeTotalWoVAT: TcxGridDBColumn
                DataBinding.FieldName = 'IncomeTotalWoVAT'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDateRoomRentTotalWoVAT: TcxGridDBColumn
                DataBinding.FieldName = 'RoomRentTotalWoVAT'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDateRoomDiscountTotalWoVAT: TcxGridDBColumn
                DataBinding.FieldName = 'RoomDiscountTotalWoVAT'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDateItemsTotalWoVAT: TcxGridDBColumn
                DataBinding.FieldName = 'ItemsTotalWoVAT'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDateVatTotal: TcxGridDBColumn
                DataBinding.FieldName = 'VatTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDateVatBilled: TcxGridDBColumn
                DataBinding.FieldName = 'VatBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDateVatUnbilled: TcxGridDBColumn
                DataBinding.FieldName = 'VatUnbilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDateCtaxTotal: TcxGridDBColumn
                DataBinding.FieldName = 'CtaxTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDateCtaxTotalWoVAT: TcxGridDBColumn
                DataBinding.FieldName = 'CtaxTotalWoVAT'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDateCtaxBilled: TcxGridDBColumn
                DataBinding.FieldName = 'CtaxBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDateCtaxUnbilled: TcxGridDBColumn
                DataBinding.FieldName = 'CtaxUnbilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatRentUnbilled: TcxGridDBColumn
                DataBinding.FieldName = 'vatRentUnbilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatRentBilled: TcxGridDBColumn
                DataBinding.FieldName = 'vatRentBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatRentTotal: TcxGridDBColumn
                DataBinding.FieldName = 'vatRentTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatItemsUnbilled: TcxGridDBColumn
                DataBinding.FieldName = 'vatItemsUnbilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatItemsBilled: TcxGridDBColumn
                DataBinding.FieldName = 'vatItemsBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatItemsTotal: TcxGridDBColumn
                DataBinding.FieldName = 'vatItemsTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatCtaxUnbilled: TcxGridDBColumn
                DataBinding.FieldName = 'vatCtaxUnbilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatCtaxbilled: TcxGridDBColumn
                DataBinding.FieldName = 'vatCtaxbilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatCtaxTotal: TcxGridDBColumn
                DataBinding.FieldName = 'vatCtaxTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatDiscountTotal: TcxGridDBColumn
                DataBinding.FieldName = 'vatDiscountTotal'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatDiscountBilled: TcxGridDBColumn
                DataBinding.FieldName = 'vatDiscountBilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
              object tvRoomsDatevatDiscountUnbilled: TcxGridDBColumn
                DataBinding.FieldName = 'vatDiscountUnbilled'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                OnGetProperties = tvRoomsDateincomeTotalGetProperties
              end
            end
            object lvRoomsDate: TcxGridLevel
              GridView = tvRoomsDate
            end
          end
        end
        object sTabSheet8: TsTabSheet
          Caption = 'Roominvoice'
          SkinData.CustomColor = False
          SkinData.CustomFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object sPanel1: TsPanel
            Left = 0
            Top = 0
            Width = 1112
            Height = 45
            Align = alTop
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            object btnExcelInvoiceLines: TsButton
              Left = 2
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Excel'
              ImageIndex = 132
              Images = DImages.PngImageList1
              TabOrder = 0
              OnClick = btnExcelInvoiceLinesClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnInvoiceInvoicelines: TsButton
              Left = 320
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Invoice'
              ImageIndex = 63
              Images = DImages.PngImageList1
              TabOrder = 1
              OnClick = btnInvoiceInvoicelinesClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnReservationInvoiceLines: TsButton
              Left = 108
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Reservation'
              ImageIndex = 56
              Images = DImages.PngImageList1
              TabOrder = 2
              OnClick = btnReservationInvoiceLinesClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnRoomInvoicelines: TsButton
              Left = 214
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Room/Guests'
              ImageIndex = 39
              Images = DImages.PngImageList1
              TabOrder = 3
              OnClick = btnRoomInvoicelinesClick
              SkinData.SkinSection = 'BUTTON'
            end
          end
          object grInvoicelines: TcxGrid
            Left = 0
            Top = 45
            Width = 1112
            Height = 468
            Align = alClient
            TabOrder = 1
            LookAndFeel.NativeStyle = False
            object tvInvoicelines: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = InvoiceLinesDS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skCount
                  FieldName = 'InvoiceNumber'
                  Column = tvInvoicelinesInvoiceNumber
                end
                item
                  Format = 'avr  #,##0.##;-#,##0.##'
                  Kind = skAverage
                  FieldName = 'Number'
                  Column = tvInvoicelinesNumber
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'Price'
                  Column = tvInvoicelinesPrice
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'Total'
                  Column = tvInvoicelinesTotal
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'Vat'
                  Column = tvInvoicelinesVat
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.Footer = True
              OptionsView.FooterAutoHeight = True
              OptionsView.FooterMultiSummaries = True
              object tvInvoicelinesInvoiceNumber: TcxGridDBColumn
                DataBinding.FieldName = 'InvoiceNumber'
                Width = 96
              end
              object tvInvoicelinesItemID: TcxGridDBColumn
                Caption = 'Item'
                DataBinding.FieldName = 'ItemID'
              end
              object tvInvoicelinesDescription: TcxGridDBColumn
                DataBinding.FieldName = 'Description'
                Width = 221
              end
              object tvInvoicelinesNumber: TcxGridDBColumn
                Caption = 'Count'
                DataBinding.FieldName = 'Number'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvInvoicelinesPrice: TcxGridDBColumn
                DataBinding.FieldName = 'Price'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                Width = 109
              end
              object tvInvoicelinesTotal: TcxGridDBColumn
                DataBinding.FieldName = 'Total'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                Width = 109
              end
              object tvInvoicelinesVATType: TcxGridDBColumn
                Caption = 'VAT Type'
                DataBinding.FieldName = 'VATType'
              end
              object tvInvoicelinesTotalWOVat: TcxGridDBColumn
                DataBinding.FieldName = 'TotalWOVat'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                Visible = False
              end
              object tvInvoicelinesVat: TcxGridDBColumn
                DataBinding.FieldName = 'Vat'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvInvoicelinesSplitNumber: TcxGridDBColumn
                Caption = 'Type'
                DataBinding.FieldName = 'SplitNumber'
                Width = 77
              end
              object tvInvoicelinesReservation: TcxGridDBColumn
                DataBinding.FieldName = 'Reservation'
                Width = 85
              end
              object tvInvoicelinesRoomReservation: TcxGridDBColumn
                DataBinding.FieldName = 'RoomReservation'
                Width = 90
              end
            end
            object lvInvoicelines: TcxGridLevel
              GridView = tvInvoicelines
            end
          end
        end
        object sTabSheet9: TsTabSheet
          Caption = 'Groupinvoice'
          SkinData.CustomColor = False
          SkinData.CustomFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object sPanel3: TsPanel
            Left = 0
            Top = 0
            Width = 1112
            Height = 45
            Align = alTop
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            object btnExcelGroupInvoiceSums: TsButton
              Left = 2
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Excel'
              ImageIndex = 132
              Images = DImages.PngImageList1
              TabOrder = 0
              OnClick = btnExcelGroupInvoiceSumsClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnReservationGroupInvoiceSums: TsButton
              Left = 108
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Reservation'
              ImageIndex = 56
              Images = DImages.PngImageList1
              TabOrder = 1
              OnClick = btnReservationGroupInvoiceSumsClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnRoomGroupInvoiceSums: TsButton
              Left = 214
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Room/Guests'
              ImageIndex = 39
              Images = DImages.PngImageList1
              TabOrder = 2
              OnClick = btnRoomGroupInvoiceSumsClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnInvoiceGroupInvoiceSums: TsButton
              Left = 320
              Top = 2
              Width = 100
              Height = 37
              Caption = 'Invoice'
              ImageIndex = 63
              Images = DImages.PngImageList1
              TabOrder = 3
              OnClick = btnInvoiceGroupInvoiceSumsClick
              SkinData.SkinSection = 'BUTTON'
            end
          end
          object gr: TcxGrid
            Left = 0
            Top = 45
            Width = 1112
            Height = 468
            Align = alClient
            TabOrder = 1
            LookAndFeel.NativeStyle = False
            object tvGroupInvoiceSums: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = GroupInvoiceSumsDS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skCount
                  FieldName = 'invoiceNumber'
                  Column = tvGroupInvoiceSumsinvoiceNumber
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'avragePrice'
                  Column = tvGroupInvoiceSumsavragePrice
                end
                item
                  Kind = skSum
                  FieldName = ',0.00;-,0.00'
                  Column = tvGroupInvoiceSumsTotal
                end
                item
                  Format = ',0.00;-,0.00'
                  Kind = skSum
                  FieldName = 'TotalVat'
                  Column = tvGroupInvoiceSumsTotalVat
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.Footer = True
              OptionsView.FooterAutoHeight = True
              OptionsView.FooterMultiSummaries = True
              object tvGroupInvoiceSumsinvoiceNumber: TcxGridDBColumn
                Caption = 'invoice'
                DataBinding.FieldName = 'invoiceNumber'
                Width = 121
              end
              object tvGroupInvoiceSumsItemId: TcxGridDBColumn
                Caption = 'Item'
                DataBinding.FieldName = 'ItemId'
              end
              object tvGroupInvoiceSumsnoItems: TcxGridDBColumn
                Caption = 'count'
                DataBinding.FieldName = 'noItems'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvGroupInvoiceSumsavragePrice: TcxGridDBColumn
                DataBinding.FieldName = 'Price (avr)'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvGroupInvoiceSumsTotal: TcxGridDBColumn
                DataBinding.FieldName = 'Total'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                Width = 94
              end
              object tvGroupInvoiceSumsTotalWOVat: TcxGridDBColumn
                DataBinding.FieldName = 'TotalWOVat'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                Visible = False
              end
              object tvGroupInvoiceSumsTotalVat: TcxGridDBColumn
                Caption = 'VAT'
                DataBinding.FieldName = 'TotalVat'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
              end
              object tvGroupInvoiceSumsnoInvoices: TcxGridDBColumn
                Caption = 'Invoice count'
                DataBinding.FieldName = 'noInvoices'
                Width = 102
              end
              object tvGroupInvoiceSumsRoomCount: TcxGridDBColumn
                Caption = 'Rooms'
                DataBinding.FieldName = 'RoomCount'
              end
              object tvGroupInvoiceSumsReservation: TcxGridDBColumn
                DataBinding.FieldName = 'Reservation'
              end
            end
            object lvGroupInvoiceSums: TcxGridLevel
              GridView = tvGroupInvoiceSums
            end
          end
        end
      end
    end
  end
  object kbmRoomsDate_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'dtDate'
        DataType = ftDate
      end
      item
        Name = 'Room'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'RoomType'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'StatusText'
        DataType = ftString
        Size = 45
      end
      item
        Name = 'isNoroom'
        DataType = ftBoolean
      end
      item
        Name = 'Location'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CustomerType'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'RRGuestCount'
        DataType = ftInteger
      end
      item
        Name = 'MainGuests'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'paid'
        DataType = ftBoolean
      end
      item
        Name = 'currency'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'CurrencyRate'
        DataType = ftFloat
      end
      item
        Name = 'NativeRate'
        DataType = ftFloat
      end
      item
        Name = 'discount'
        DataType = ftFloat
      end
      item
        Name = 'isPercentage'
        DataType = ftBoolean
      end
      item
        Name = 'discountAmount'
        DataType = ftFloat
      end
      item
        Name = 'sArrival'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'sDeparture'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DayCount'
        DataType = ftInteger
      end
      item
        Name = 'RoomCount'
        DataType = ftInteger
      end
      item
        Name = 'RvGuestCount'
        DataType = ftInteger
      end
      item
        Name = 'roomReservation'
        DataType = ftInteger
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'Invoicenumbers'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ResFlag'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'FilterFlag'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'aDate'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Customer'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CustomerName'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'RoomCount2'
        DataType = ftInteger
      end
      item
        Name = 'NoOfRooms'
        DataType = ftInteger
      end
      item
        Name = 'incomeTotal'
        DataType = ftFloat
      end
      item
        Name = 'IncomeTotalWoVAT'
        DataType = ftFloat
      end
      item
        Name = 'RoomRentTotal'
        DataType = ftFloat
      end
      item
        Name = 'RoomRentTotalWoVAT'
        DataType = ftFloat
      end
      item
        Name = 'RoomRentBilled'
        DataType = ftFloat
      end
      item
        Name = 'RoomRentUnBilled'
        DataType = ftFloat
      end
      item
        Name = 'RoomDiscountTotal'
        DataType = ftFloat
      end
      item
        Name = 'RoomDiscountTotalWoVAT'
        DataType = ftFloat
      end
      item
        Name = 'RoomDiscountBilled'
        DataType = ftFloat
      end
      item
        Name = 'RoomDiscountUnBilled'
        DataType = ftFloat
      end
      item
        Name = 'ItemsTotal'
        DataType = ftFloat
      end
      item
        Name = 'ItemsTotalWoVAT'
        DataType = ftFloat
      end
      item
        Name = 'ItemsBilled'
        DataType = ftFloat
      end
      item
        Name = 'itemsUnBilled'
        DataType = ftFloat
      end
      item
        Name = 'TaxesTotal'
        DataType = ftFloat
      end
      item
        Name = 'TaxesBilled'
        DataType = ftFloat
      end
      item
        Name = 'TaxesUnbilled'
        DataType = ftFloat
      end
      item
        Name = 'VatTotal'
        DataType = ftFloat
      end
      item
        Name = 'VatBilled'
        DataType = ftFloat
      end
      item
        Name = 'VatUnbilled'
        DataType = ftFloat
      end
      item
        Name = 'CtaxTotal'
        DataType = ftFloat
      end
      item
        Name = 'CtaxTotalWoVAT'
        DataType = ftFloat
      end
      item
        Name = 'CtaxBilled'
        DataType = ftFloat
      end
      item
        Name = 'CtaxUnbilled'
        DataType = ftFloat
      end
      item
        Name = 'vatRentUnbilled'
        DataType = ftFloat
      end
      item
        Name = 'vatRentBilled'
        DataType = ftFloat
      end
      item
        Name = 'vatRentTotal'
        DataType = ftFloat
      end
      item
        Name = 'vatItemsUnbilled'
        DataType = ftFloat
      end
      item
        Name = 'vatItemsBilled'
        DataType = ftFloat
      end
      item
        Name = 'vatItemsTotal'
        DataType = ftFloat
      end
      item
        Name = 'vatCtaxUnbilled'
        DataType = ftFloat
      end
      item
        Name = 'vatCtaxbilled'
        DataType = ftFloat
      end
      item
        Name = 'vatCtaxTotal'
        DataType = ftFloat
      end
      item
        Name = 'ItemId'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'vatDiscountTotal'
        DataType = ftFloat
      end
      item
        Name = 'vatDiscountBilled'
        DataType = ftFloat
      end
      item
        Name = 'vatDiscountUnbilled'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'idxRoomreservation'
        Fields = 'Roomreservation'
      end
      item
        Name = 'idxDtDate'
        Fields = 'dtDate'
      end
      item
        Name = 'idxReservation_roomreservation'
        Fields = 'Reservation;roomreservation'
      end>
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
    BeforePost = kbmRoomsDate_BeforePost
    Left = 432
    Top = 320
  end
  object RoomsDateDS: TDataSource
    DataSet = kbmRoomsDate_
    Left = 536
    Top = 320
  end
  object kbmInvoiceLines_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'SplitNumber'
        DataType = ftInteger
      end
      item
        Name = 'InvoiceNumber'
        DataType = ftInteger
      end
      item
        Name = 'ItemID'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Number'
        DataType = ftFloat
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Price'
        DataType = ftFloat
      end
      item
        Name = 'VATType'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Total'
        DataType = ftFloat
      end
      item
        Name = 'TotalWOVat'
        DataType = ftFloat
      end
      item
        Name = 'Vat'
        DataType = ftFloat
      end
      item
        Name = 'RRGuestCount'
        DataType = ftInteger
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
    Left = 80
    Top = 416
  end
  object InvoiceLinesDS: TDataSource
    DataSet = kbmInvoiceLines_
    Left = 152
    Top = 488
  end
  object kbmGroupInvoiceSums_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'ItemId'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'noInvoices'
        DataType = ftInteger
      end
      item
        Name = 'noItems'
        DataType = ftFloat
      end
      item
        Name = 'avragePrice'
        DataType = ftFloat
      end
      item
        Name = 'Total'
        DataType = ftFloat
      end
      item
        Name = 'TotalWOVat'
        DataType = ftFloat
      end
      item
        Name = 'TotalVat'
        DataType = ftFloat
      end
      item
        Name = 'RoomCount'
        DataType = ftInteger
      end
      item
        Name = 'invoiceNumber'
        DataType = ftInteger
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
    Left = 80
    Top = 496
  end
  object GroupInvoiceSumsDS: TDataSource
    DataSet = kbmGroupInvoiceSums_
    Left = 152
    Top = 592
  end
  object Dril001: TcxPivotGridDrillDownDataSet
    PivotGrid = pg001
    SynchronizeData = True
    OnDataChanged = Dril001DataChanged
    Left = 680
    Top = 424
  end
  object Dril001DS: TDataSource
    DataSet = Dril001
    Left = 760
    Top = 424
  end
  object pgGraph001: TcxPivotGridChartConnection
    GridChartView = cxGridChartView
    PivotGrid = pg001
    Left = 296
    Top = 312
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLinkGrDrill
    Version = 0
    Left = 940
    Top = 336
    object prLinkPg001: TcxPivotGridReportLink
      Component = pg001
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
      BuiltInReportLink = True
    end
    object prLinkGrDrill: TdxGridReportLink
      Component = grDrill
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
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      BuiltInReportLink = True
    end
  end
  object store1: TcxPropertiesStore
    Active = False
    Components = <
      item
        Component = pg001aDate
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001Country
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001CtaxBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001CtaxTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001CTaxTotalWoVAT
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001CtaxUnbilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001currency
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001CurrencyRate
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001Customer
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001CustomerName
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001CustomerType
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001DayCount
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001discount
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001discountAmount
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001dtDate
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001FilterFlag
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001incomeTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001IncomeTotalNoVAT
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001Invoicenumbers
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001isNoroom
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001isPercentage
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001ItemsBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001ItemsTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001ItemsTotalWoVAT
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001itemsUnBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001Location
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001MainGuests
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001Month
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001NativeRate
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001paid
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001Reservation
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001ResFlag
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001Room
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RoomCount
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RoomDiscountBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RoomDiscountTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RoomDiscountUnBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RoomRentBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RoomRentTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RoomRentTotalWoVAT
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RoomRentUnBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001roomReservation
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RoomType
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RRGuestCount
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001RvGuestCount
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001sArrival
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001sDeparture
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001StatusText
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001TaxesBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001TaxesTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001TaxesUnbilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001VatBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatCtaxbilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatCtaxTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatCtaxUnbilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatDiscountBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatDiscountTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatDiscountUnbilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatItemsBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatItemsTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatItemsUnbilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatRentBilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001vatRentTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001VatRentUnbilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001VatTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg001VatUnbilled
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end
      item
        Component = pg00Week
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Hidden'
          'Visible')
      end>
    StorageName = 'storeMain'
    StorageType = stStream
    Left = 720
    Top = 320
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
    StorageName = 'Software\Roomer\FormStatus\frmRptResStat'
    StorageType = stRegistry
    Left = 34
    Top = 446
  end
  object storeOld: TcxPropertiesStore
    Active = False
    Components = <
      item
        Component = pg001aDate
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001Country
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001currency
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001CurrencyRate
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001CustomerType
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001DayCount
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001discount
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001discountAmount
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001dtDate
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001FilterFlag
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001incomeTotal
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001Invoicenumbers
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001isNoroom
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001isPercentage
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001ItemsBilled
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001ItemsTotal
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001itemsUnBilled
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001Location
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001MainGuests
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001Month
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001NativeRate
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001paid
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001Reservation
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001ResFlag
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001Room
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001RoomCount
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001RoomDiscountBilled
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001RoomDiscountTotal
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001RoomDiscountUnBilled
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001RoomRentBilled
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001RoomRentTotal
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001RoomRentUnBilled
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001roomReservation
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001RoomType
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001RRGuestCount
        Properties.Strings = (
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001RvGuestCount
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001sArrival
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001sDeparture
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001StatusText
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001TaxesBilled
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001TaxesTotal
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg001TaxesUnbilled
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end
      item
        Component = pg00Week
        Properties.Strings = (
          'AllowedAreas'
          'Area'
          'AreaIndex'
          'Visible')
      end>
    StorageName = 'storeMain'
    StorageType = stStream
    Left = 896
    Top = 232
  end
end
