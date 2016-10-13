object frmRptCashier: TfrmRptCashier
  Left = 0
  Top = 0
  Caption = 'Cashier report'
  ClientHeight = 684
  ClientWidth = 1098
  Color = clBtnFace
  Constraints.MinWidth = 570
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
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
    Width = 1098
    Height = 113
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object btnRefresh: TsButton
      Left = 585
      Top = 8
      Width = 110
      Height = 37
      Caption = 'Show'
      Default = True
      Enabled = False
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object gbxSelectDates: TsGroupBox
      Left = 8
      Top = 0
      Width = 571
      Height = 103
      Caption = 'Select dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object sLabel1: TsLabel
        Left = 102
        Top = 27
        Width = 79
        Height = 13
        Alignment = taRightJustify
        Caption = 'Report for date:'
      end
      object sLabel2: TsLabel
        Left = 124
        Top = 53
        Width = 57
        Height = 13
        Alignment = taRightJustify
        Caption = 'Staff users:'
        Visible = False
      end
      object sLabel3: TsLabel
        Left = 155
        Top = 78
        Width = 26
        Height = 13
        Alignment = taRightJustify
        Caption = 'Shift:'
      end
      object dtDateFrom: TsDateEdit
        Left = 187
        Top = 24
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
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        OnCloseUp = dtDateFromCloseUp
      end
      object cbxStaff: TCheckListEdit
        Left = 187
        Top = 50
        Width = 311
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        AutoDropWidthSize = True
        Color = 3355443
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 15724527
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = False
        OnChange = cbxStaffChange
        Items.Strings = (
          'All Room Types')
        DropWidth = 121
        DropHeight = 400
        DropFont.Charset = DEFAULT_CHARSET
        DropFont.Color = clWindowText
        DropFont.Height = -11
        DropFont.Name = 'Tahoma'
        DropFont.Style = []
        TextDelimiter = '|'
        TextEndChar = ''
        TextStartChar = ''
        OnClickCheck = cbxStaffClickCheck
        Version = '1.3.9.2'
      end
      object btnClearStaff: TsButton
        Left = 503
        Top = 49
        Width = 24
        Height = 22
        Hint = 'Unselect/uncheck all'
        Caption = '[ ]'
        TabOrder = 2
        Visible = False
        OnClick = btnClearStaffClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnCheckAllStaff: TsButton
        Left = 533
        Top = 49
        Width = 24
        Height = 22
        Hint = 'Select/Check all'
        Caption = '[x]'
        TabOrder = 3
        Visible = False
        OnClick = btnCheckAllStaffClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnBack: TcxButton
        AlignWithMargins = True
        Left = 298
        Top = 22
        Width = 25
        Height = 25
        Hint = 'Back one day. '
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        LookAndFeel.Kind = lfFlat
        LookAndFeel.NativeStyle = False
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = DImages.ilGuests
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 4
        OnClick = btnBackClick
      end
      object btnForward: TcxButton
        AlignWithMargins = True
        Left = 329
        Top = 22
        Width = 27
        Height = 25
        Hint = 'Forward one day.'
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        LookAndFeel.NativeStyle = False
        OptionsImage.ImageIndex = 3
        OptionsImage.Images = DImages.ilGuests
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 5
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clCaptionText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnForwardClick
      end
      object cbxShifts: TsComboBox
        Left = 187
        Top = 75
        Width = 105
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
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
        TabOrder = 6
        OnChange = cbxShiftsChange
        Items.Strings = (
          '1'
          '2'
          '3'
          '4')
      end
      object cbxByUsers: TsCheckBox
        Left = 366
        Top = 25
        Width = 120
        Height = 19
        Caption = 'By selected user(s)'
        TabOrder = 7
        OnClick = cbxByUsersClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object gbxTotals: TsGroupBox
      Left = 701
      Top = 0
      Width = 377
      Height = 103
      Caption = 'Totals'
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object lblTotalsale: TsLabel
        Left = 73
        Top = 21
        Width = 51
        Height = 13
        Alignment = taRightJustify
        Caption = 'Total Sale:'
      end
      object __Totalsale: TsLabel
        Left = 136
        Top = 21
        Width = 4
        Height = 13
        Caption = '-'
      end
      object lblTotalPayments: TsLabel
        Left = 46
        Top = 38
        Width = 78
        Height = 13
        Alignment = taRightJustify
        Caption = 'Total Payments:'
      end
      object __TotalPayments: TsLabel
        Left = 136
        Top = 38
        Width = 4
        Height = 13
        Caption = '-'
      end
      object lblBalance: TsLabel
        Left = 83
        Top = 55
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'Balance:'
      end
      object __Balance: TsLabel
        Left = 136
        Top = 55
        Width = 4
        Height = 13
        Caption = '-'
      end
    end
    object btnPaymentReport: TsButton
      Left = 585
      Top = 51
      Width = 110
      Height = 35
      Caption = 'Report'
      Enabled = False
      ImageIndex = 69
      Images = DImages.PngImageList1
      TabOrder = 3
      OnClick = btnPaymentReportClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 665
    Width = 1098
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object pageMain: TsPageControl
    Left = 0
    Top = 113
    Width = 1098
    Height = 552
    ActivePage = sTabSheet1
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PAGECONTROL'
    object tabStatGrid: TsTabSheet
      Caption = 'Data'
      TabVisible = False
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel1: TsPanel
        Left = 0
        Top = 0
        Width = 1090
        Height = 45
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnGuestsExcel: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 101
          Height = 37
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnGuestsExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton1: TsButton
          AlignWithMargins = True
          Left = 111
          Top = 4
          Width = 102
          Height = 37
          Align = alLeft
          Caption = 'Export CSV'
          ImageIndex = 69
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = sButton1Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grReport: TAdvStringGrid
        Left = 0
        Top = 45
        Width = 1090
        Height = 479
        Cursor = crDefault
        Align = alClient
        BorderStyle = bsNone
        ColCount = 1
        Ctl3D = False
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
        ParentCtl3D = False
        ScrollBars = ssBoth
        TabOrder = 1
        HoverRowCells = [hcNormal, hcSelected]
        OnGetCellColor = grReportGetCellColor
        OnGetAlignment = grReportGetAlignment
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        Flat = True
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SortSettings.DefaultFormat = ssAutomatic
        Version = '8.1.2.0'
        WordWrap = False
      end
    end
    object sTabSheet1: TsTabSheet
      Caption = 'Cashier functions'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object grGet: TcxGrid
        Left = 0
        Top = 43
        Width = 1090
        Height = 481
        Align = alClient
        TabOrder = 0
        LookAndFeel.NativeStyle = False
        object tvGet: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = kbmGetDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          object tvGetCategory: TcxGridDBColumn
            DataBinding.FieldName = 'Category'
            Visible = False
            GroupIndex = 0
            Width = 120
          end
          object tvGetLineTypeInt: TcxGridDBColumn
            DataBinding.FieldName = 'LineTypeInt'
            Visible = False
            Width = 24
          end
          object tvGetLineType: TcxGridDBColumn
            DataBinding.FieldName = 'LineType'
            Visible = False
            Options.Editing = False
            Width = 116
            IsCaptionAssigned = True
          end
          object tvGetStaff: TcxGridDBColumn
            DataBinding.FieldName = 'Staff'
            Options.Editing = False
            Width = 63
          end
          object tvGetNameCol: TcxGridDBColumn
            Caption = 'Name'
            DataBinding.FieldName = 'NameCol'
            Options.Editing = False
            Width = 169
          end
          object tvGetDescriptionCol: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'DescriptionCol'
            Options.Editing = False
            Width = 144
          end
          object tvGetTypeCol: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'TypeCol'
            Options.Editing = False
            Width = 152
          end
          object tvGetnativeTotalPrice: TcxGridDBColumn
            Caption = 'Amount'
            DataBinding.FieldName = 'nativeTotalPrice'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvGetnativeTotalPriceGetProperties
            Options.Editing = False
            Width = 79
          end
          object tvGetCreated: TcxGridDBColumn
            DataBinding.FieldName = 'Created'
            OnGetProperties = tvGetCreatedGetProperties
            Options.Editing = False
            Width = 110
          end
          object tvGettxDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'txDate'
            Visible = False
            Options.Editing = False
          end
          object tvGetnumberofitems: TcxGridDBColumn
            Caption = 'Items'
            DataBinding.FieldName = 'numberofitems'
            Visible = False
            Options.Editing = False
            Width = 78
          end
          object tvGetReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
            Visible = False
            Options.Editing = False
          end
          object tvGetRoomReservation: TcxGridDBColumn
            Caption = 'Room Reservation'
            DataBinding.FieldName = 'RoomReservation'
            Visible = False
            Options.Editing = False
          end
          object tvGetInvoiceNumber: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceNumber'
            Visible = False
          end
          object tvGetroom: TcxGridDBColumn
            DataBinding.FieldName = 'room'
            Visible = False
            Width = 83
          end
          object tvGetName: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            Visible = False
            Width = 226
          end
          object tvGetproduct: TcxGridDBColumn
            DataBinding.FieldName = 'product'
            Visible = False
          end
          object tvGetproductdescription: TcxGridDBColumn
            DataBinding.FieldName = 'productdescription'
            Visible = False
          end
          object tvGetDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Visible = False
          end
          object tvGetLineIndex: TcxGridDBColumn
            DataBinding.FieldName = 'LineIndex'
            Visible = False
          end
          object tvGetTypeIndex: TcxGridDBColumn
            DataBinding.FieldName = 'TypeIndex'
            Visible = False
          end
        end
        object lvGet: TcxGridLevel
          GridView = tvGet
        end
      end
      object Panel5: TsPanel
        Left = 0
        Top = 0
        Width = 1090
        Height = 43
        Align = alTop
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object btnExcel: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 69
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton6: TsButton
          AlignWithMargins = True
          Left = 138
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Invoice'
          ImageIndex = 63
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = sButton6Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton23: TsButton
          AlignWithMargins = True
          Left = 272
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Reservation'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = sButton23Click
          SkinData.SkinSection = 'BUTTON'
        end
        object chkGroup: TsCheckBox
          AlignWithMargins = True
          Left = 406
          Top = 4
          Width = 120
          Height = 35
          Caption = 'Group by Category'
          Align = alLeft
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = chkGroupClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object btnExpand: TsButton
          AlignWithMargins = True
          Left = 532
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Expand'
          ImageIndex = 94
          TabOrder = 4
          OnClick = btnExpandClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnCollapse: TsButton
          AlignWithMargins = True
          Left = 666
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Collapse'
          ImageIndex = 94
          TabOrder = 5
          OnClick = btnCollapseClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
    object sTabSheet2: TsTabSheet
      Caption = 'Received Payments'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 1090
        Height = 43
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton3: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 100
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 69
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton3Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grPayments: TcxGrid
        Left = 0
        Top = 43
        Width = 1090
        Height = 481
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvPayments: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = kbmPaymentsDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Amount'
              Column = tvPaymentsAmount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsView.Footer = True
          object tvPaymentsType: TcxGridDBColumn
            DataBinding.FieldName = 'Type'
            Options.Editing = False
            Width = 106
          end
          object tvPaymentsDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Options.Editing = False
            Width = 278
          end
          object tvPaymentsAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvGetnativeTotalPriceGetProperties
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 107
          end
        end
        object lvPayments: TcxGridLevel
          GridView = tvPayments
        end
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
    StorageName = 'Software\Roomer\FormStatus\frmRptCashier'
    StorageType = stRegistry
    Left = 362
    Top = 262
  end
  object dlgSave: TFileSaveDialog
    DefaultExtension = '.csv'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'CSV files (*.csv)'
        FileMask = '*.csv'
      end
      item
        DisplayName = 'Text files (*.txt)'
        FileMask = '*.txt'
      end
      item
        DisplayName = 'All files (*.*)'
        FileMask = '*.*'
      end>
    Options = []
    Left = 360
    Top = 320
  end
  object _kbmGet: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'LineType'
        DataType = ftWideString
        Size = 35
      end
      item
        Name = 'TypeIndex'
        DataType = ftInteger
      end
      item
        Name = 'Staff'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Name'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'LineIndex'
        DataType = ftInteger
      end
      item
        Name = 'InvoiceNumber'
        DataType = ftInteger
      end
      item
        Name = 'txDate'
        DataType = ftDate
      end
      item
        Name = 'Created'
        DataType = ftDateTime
      end
      item
        Name = 'room'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'product'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'productdescription'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'numberofitems'
        DataType = ftInteger
      end
      item
        Name = 'nativeTotalPrice'
        DataType = ftFloat
      end
      item
        Name = 'NameCol'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'DescriptionCol'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'TypeCol'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'LineTypeInt'
        DataType = ftInteger
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'Category'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'BookingId'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'Arrival'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'Departure'
        DataType = ftWideString
        Size = 10
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
    Left = 152
    Top = 296
  end
  object kbmGetDS: TDataSource
    DataSet = kbmGet
    Left = 368
    Top = 448
  end
  object rptbCashier: TppReport
    AutoStop = False
    DataPipeline = ppCashier
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 210000
    PrinterSetup.mmPaperWidth = 297000
    PrinterSetup.PaperSize = 9
    Units = utMillimeters
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    ModalCancelDialog = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    Left = 200
    Top = 440
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'ppCashier'
    object ppHeaderBand1: TppHeaderBand
      BeforePrint = ppHeaderBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 21696
      mmPrintPosition = 0
      object ppLabelReportname: TppLabel
        UserName = 'LabelReportname'
        Caption = 'Payments grouped by payment type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = []
        Transparent = True
        mmHeight = 7408
        mmLeft = 6879
        mmTop = 794
        mmWidth = 128852
        BandType = 0
        LayerName = Foreground
      end
      object rLabHotelName: TppLabel
        UserName = 'rLabHotelName'
        Caption = 'Hotel name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 266701
        mmTop = 794
        mmWidth = 15610
        BandType = 0
        LayerName = Foreground
      end
      object rlabUser: TppLabel
        UserName = 'rLabUser'
        Caption = 'hj'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 279401
        mmTop = 5027
        mmWidth = 2910
        BandType = 0
        LayerName = Foreground
      end
      object rlabUsers: TppLabel
        UserName = 'rLabUser1'
        Caption = 'hj'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = []
        Transparent = True
        mmHeight = 5715
        mmLeft = 6879
        mmTop = 9525
        mmWidth = 3852
        BandType = 0
        LayerName = Foreground
      end
      object ppLine9: TppLine
        UserName = 'Line9'
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 6879
        mmTop = 19050
        mmWidth = 279665
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      BeforeGenerate = ppDetailBand1BeforeGenerate
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 4498
      mmPrintPosition = 0
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'Staff'
        DataPipeline = ppCashier
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppCashier'
        mmHeight = 2910
        mmLeft = 6879
        mmTop = 1058
        mmWidth = 9525
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        DataField = 'nativeTotalPrice'
        DataPipeline = ppCashier
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppCashier'
        mmHeight = 2879
        mmLeft = 234421
        mmTop = 1058
        mmWidth = 18256
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'numberofitems'
        DataPipeline = ppCashier
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppCashier'
        mmHeight = 2879
        mmLeft = 275961
        mmTop = 1058
        mmWidth = 7938
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText10: TppDBText
        UserName = 'DBText10'
        DataField = 'NameCol'
        DataPipeline = ppCashier
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppCashier'
        mmHeight = 2879
        mmLeft = 154252
        mmTop = 1058
        mmWidth = 28310
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'DescriptionCol'
        DataPipeline = ppCashier
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppCashier'
        mmHeight = 2879
        mmLeft = 201613
        mmTop = 1058
        mmWidth = 31485
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        OnPrint = ppLabel6Print
        UserName = 'Label6'
        Caption = 'Label6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        mmHeight = 2879
        mmLeft = 20638
        mmTop = 1058
        mmWidth = 7324
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel8: TppLabel
        OnPrint = ppLabel8Print
        UserName = 'Label8'
        AutoSize = False
        Caption = 'Label8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        mmHeight = 2879
        mmLeft = 45773
        mmTop = 1058
        mmWidth = 11642
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        UserName = 'DBText101'
        DataField = 'GuestName'
        DataPipeline = ppCashier
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppCashier'
        mmHeight = 2879
        mmLeft = 121709
        mmTop = 1058
        mmWidth = 31750
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        OnPrint = ppLabel7Print
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Label7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        mmHeight = 2879
        mmLeft = 58473
        mmTop = 1058
        mmWidth = 12700
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel10: TppLabel
        OnPrint = ppLabel10Print
        UserName = 'Label10'
        AutoSize = False
        Caption = 'Label10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        mmHeight = 2879
        mmLeft = 72231
        mmTop = 1058
        mmWidth = 12700
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        OnPrint = ppLabel9Print
        UserName = 'Label101'
        AutoSize = False
        Caption = 'Label101'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 2879
        mmLeft = 104775
        mmTop = 1058
        mmWidth = 14817
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel11: TppLabel
        OnPrint = ppLabel11Print
        UserName = 'Label11'
        AutoSize = False
        Caption = 'Label11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        mmHeight = 2879
        mmLeft = 253736
        mmTop = 1058
        mmWidth = 20638
        BandType = 4
        LayerName = Foreground
      end
      object LabTxItem: TppLabel
        OnPrint = LabTxItemPrint
        UserName = 'Label102'
        AutoSize = False
        Caption = 'Label102'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        Transparent = True
        mmHeight = 2910
        mmLeft = 183092
        mmTop = 1058
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
      object LabTxReservation: TppLabel
        OnPrint = LabTxReservationPrint
        UserName = 'Label103'
        AutoSize = False
        Caption = 'Label103'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 7
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 2879
        mmLeft = 86254
        mmTop = 1058
        mmWidth = 17463
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 7673
      mmPrintPosition = 0
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtPrintDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 7673
        mmTop = 1588
        mmWidth = 23548
        BandType = 8
        LayerName = Foreground
      end
      object ppSystemVariable3: TppSystemVariable
        UserName = 'SystemVariable3'
        VarType = vtPageNo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 197115
        mmTop = 1588
        mmWidth = 1588
        BandType = 8
        LayerName = Foreground
      end
    end
    object ppSummaryBand1: TppSummaryBand
      BeforePrint = ppSummaryBand1BeforePrint
      Background.Brush.Style = bsClear
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 22490
      mmPrintPosition = 0
      object ppSubReport1: TppSubReport
        UserName = 'SubReport1'
        ExpandAll = False
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        TraverseAllData = False
        DataPipelineName = 'ppPayments'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 13758
        mmWidth = 284300
        BandType = 7
        LayerName = Foreground
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        object ppChildReport1: TppChildReport
          AutoStop = False
          DataPipeline = ppPayments
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.Orientation = poLandscape
          PrinterSetup.PaperName = 'A4'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.SaveDeviceSettings = False
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 210000
          PrinterSetup.mmPaperWidth = 297000
          PrinterSetup.PaperSize = 9
          Units = utMillimeters
          Version = '14.07'
          mmColumnWidth = 0
          DataPipelineName = 'ppPayments'
          object ppTitleBand1: TppTitleBand
            Background.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 16140
            mmPrintPosition = 0
            object ppLabel2: TppLabel
              UserName = 'Label2'
              AutoSize = False
              Caption = 'Type'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 3937
              mmLeft = 2381
              mmTop = 10319
              mmWidth = 16404
              BandType = 1
              LayerName = Foreground1
            end
            object ppLabel3: TppLabel
              UserName = 'Label3'
              AutoSize = False
              Caption = 'Description'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 9
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 3937
              mmLeft = 24606
              mmTop = 10319
              mmWidth = 22225
              BandType = 1
              LayerName = Foreground1
            end
            object ppLabel4: TppLabel
              UserName = 'Label4'
              AutoSize = False
              Caption = 'Amount'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3429
              mmLeft = 83873
              mmTop = 10319
              mmWidth = 18785
              BandType = 1
              LayerName = Foreground1
            end
            object ppLabel5: TppLabel
              UserName = 'Label5'
              Caption = 'Payment list'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 12
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4953
              mmLeft = 2381
              mmTop = 3969
              mmWidth = 24384
              BandType = 1
              LayerName = Foreground1
            end
            object ppLine4: TppLine
              UserName = 'Line4'
              Weight = 0.750000000000000000
              mmHeight = 794
              mmLeft = 794
              mmTop = 15346
              mmWidth = 115623
              BandType = 1
              LayerName = Foreground1
            end
          end
          object ppDetailBand2: TppDetailBand
            Background1.Brush.Style = bsClear
            Background2.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 3969
            mmPrintPosition = 0
            object ppDBText9: TppDBText
              UserName = 'DBText9'
              DataField = 'Type'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3175
              mmLeft = 2381
              mmTop = 529
              mmWidth = 16404
              BandType = 4
              LayerName = Foreground1
            end
            object ppDBText11: TppDBText
              UserName = 'DBText11'
              DataField = 'Description'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3175
              mmLeft = 21960
              mmTop = 794
              mmWidth = 58208
              BandType = 4
              LayerName = Foreground1
            end
            object ppDBText12: TppDBText
              UserName = 'DBText12'
              DataField = 'Amount'
              DataPipeline = ppPayments
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3302
              mmLeft = 83873
              mmTop = 529
              mmWidth = 18785
              BandType = 4
              LayerName = Foreground1
            end
          end
          object ppSummaryBand2: TppSummaryBand
            Background.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 9260
            mmPrintPosition = 0
            object ppDBCalc7: TppDBCalc
              UserName = 'DBCalc7'
              DataField = 'Amount'
              DataPipeline = ppPayments
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3429
              mmLeft = 85461
              mmTop = 1323
              mmWidth = 17198
              BandType = 7
              LayerName = Foreground1
            end
          end
          object ppDesignLayers2: TppDesignLayers
            object ppDesignLayer2: TppDesignLayer
              UserName = 'Foreground1'
              LayerType = ltBanded
              Index = 0
            end
          end
        end
      end
      object ppDBCalc6: TppDBCalc
        UserName = 'DBCalc6'
        DataPipeline = ppCashier
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcCount
        DataPipelineName = 'ppCashier'
        mmHeight = 3440
        mmLeft = 257969
        mmTop = 5292
        mmWidth = 10319
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc4: TppDBCalc
        UserName = 'DBCalc4'
        DataField = 'numberofitems'
        DataPipeline = ppCashier
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppCashier'
        mmHeight = 3440
        mmLeft = 271728
        mmTop = 5292
        mmWidth = 11642
        BandType = 7
        LayerName = Foreground
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Pen.Width = 2
        Weight = 1.500000000000000000
        mmHeight = 1058
        mmLeft = 234421
        mmTop = 3969
        mmWidth = 20108
        BandType = 7
        LayerName = Foreground
      end
      object ppLine6: TppLine
        UserName = 'Line6'
        Pen.Width = 2
        Weight = 1.500000000000000000
        mmHeight = 1058
        mmLeft = 234421
        mmTop = 9260
        mmWidth = 20108
        BandType = 7
        LayerName = Foreground
      end
      object ppLabTotalBalance: TppLabel
        UserName = 'LabTotalPalance'
        AutoSize = False
        Caption = 'Balance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3440
        mmLeft = 203465
        mmTop = 5292
        mmWidth = 26194
        BandType = 7
        LayerName = Foreground
      end
      object ppLine7: TppLine
        UserName = 'Line7'
        Pen.Width = 2
        Weight = 1.500000000000000000
        mmHeight = 1058
        mmLeft = 6879
        mmTop = 10848
        mmWidth = 279665
        BandType = 7
        LayerName = Foreground
      end
      object ppLine8: TppLine
        UserName = 'Line8'
        Weight = 0.750000000000000000
        mmHeight = 1588
        mmLeft = 6879
        mmTop = 794
        mmWidth = 279665
        BandType = 7
        LayerName = Foreground
      end
      object ppLabBalance: TppLabel
        UserName = 'LabBalance'
        Caption = 'LabBalance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3440
        mmLeft = 239184
        mmTop = 5027
        mmWidth = 15346
        BandType = 7
        LayerName = Foreground
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'LineType'
      DataPipeline = ppCashier
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      KeepTogether = True
      OutlineSettings.CreateNode = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppCashier'
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        BeforePrint = ppGroupHeaderBand1BeforePrint
        Background.Brush.Style = bsClear
        mmBottomOffset = 0
        mmHeight = 14552
        mmPrintPosition = 0
        object ppDBText1: TppDBText
          UserName = 'DBText1'
          DataField = 'LineType'
          DataPipeline = ppCashier
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          Visible = False
          DataPipelineName = 'ppCashier'
          mmHeight = 4233
          mmLeft = 191294
          mmTop = 2646
          mmWidth = 2646
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabStaff: TppLabel
          UserName = 'LabStaff'
          AutoSize = False
          Caption = 'LabStaff'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 2921
          mmLeft = 6879
          mmTop = 9525
          mmWidth = 9525
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabtxDate: TppLabel
          UserName = 'LabtxDate'
          AutoSize = False
          Caption = 'LabtxDate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 2921
          mmLeft = 20638
          mmTop = 9525
          mmWidth = 24342
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object pplabName: TppLabel
          UserName = 'labName'
          AutoSize = False
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 2921
          mmLeft = 154252
          mmTop = 9525
          mmWidth = 28310
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object pplabDescription: TppLabel
          UserName = 'labDescription'
          AutoSize = False
          Caption = 'productdescription'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 2921
          mmLeft = 201613
          mmTop = 9525
          mmWidth = 31485
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabNativeTotalPrice: TppLabel
          UserName = 'LabNativeTotalPrice'
          AutoSize = False
          Caption = 'nativeTotalPrice'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 2921
          mmLeft = 234421
          mmTop = 9525
          mmWidth = 18256
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object pplabType: TppLabel
          UserName = 'labType'
          AutoSize = False
          Caption = 'Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 2921
          mmLeft = 253736
          mmTop = 9525
          mmWidth = 20638
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object pplabnumberofitems: TppLabel
          UserName = 'numberofitems'
          AutoSize = False
          Caption = 'numberofitems'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 2921
          mmLeft = 275432
          mmTop = 9525
          mmWidth = 7938
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLine3: TppLine
          UserName = 'Line3'
          Weight = 0.750000000000000000
          mmHeight = 794
          mmLeft = 6879
          mmTop = 13494
          mmWidth = 279665
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel1: TppLabel
          UserName = 'Label1'
          AutoSize = False
          Caption = 'Category'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = []
          Transparent = True
          mmHeight = 4763
          mmLeft = 16404
          mmTop = 2117
          mmWidth = 0
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText3: TppDBText
          UserName = 'DBText3'
          DataField = 'Category'
          DataPipeline = ppCashier
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'ppCashier'
          mmHeight = 4953
          mmLeft = 6879
          mmTop = 1588
          mmWidth = 160338
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabtxRoom: TppLabel
          UserName = 'LabtxDate1'
          AutoSize = False
          Caption = 'LabtxRoom'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 2921
          mmLeft = 45773
          mmTop = 9525
          mmWidth = 11377
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object LabTxArrival: TppLabel
          UserName = 'LabTxArrival'
          AutoSize = False
          Caption = 'Arrival'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 2921
          mmLeft = 58473
          mmTop = 9525
          mmWidth = 12965
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object LabGuestName: TppLabel
          UserName = 'labName1'
          AutoSize = False
          Caption = 'Guest'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 2921
          mmLeft = 121709
          mmTop = 9525
          mmWidth = 31750
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object LabTxResId: TppLabel
          UserName = 'LabTxResId'
          AutoSize = False
          Caption = 'LabTxResId'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 2921
          mmLeft = 86254
          mmTop = 9525
          mmWidth = 17463
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object LabTxDeparture: TppLabel
          UserName = 'LabTxArrival1'
          AutoSize = False
          Caption = 'Departure'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 2921
          mmLeft = 72231
          mmTop = 9525
          mmWidth = 12965
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object LabTxInvoice: TppLabel
          UserName = 'LabTxResId1'
          AutoSize = False
          Caption = 'Invoice'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 2921
          mmLeft = 104775
          mmTop = 9525
          mmWidth = 16140
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel12: TppLabel
          UserName = 'Label12'
          AutoSize = False
          Caption = 'Item Id'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 7
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 2910
          mmLeft = 183092
          mmTop = 9525
          mmWidth = 17463
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        Background.Brush.Style = bsClear
        PrintHeight = phDynamic
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 10848
        mmPrintPosition = 0
        object ppDBCalc1: TppDBCalc
          UserName = 'DBCalc1'
          DataField = 'nativeTotalPrice'
          DataPipeline = ppCashier
          DisplayFormat = '$#,0.00;-$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppCashier'
          mmHeight = 3440
          mmLeft = 234421
          mmTop = 1852
          mmWidth = 18256
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBCalc2: TppDBCalc
          UserName = 'DBCalc2'
          DataField = 'numberofitems'
          DataPipeline = ppCashier
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppCashier'
          mmHeight = 3440
          mmLeft = 274903
          mmTop = 1852
          mmWidth = 8996
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLine1: TppLine
          UserName = 'Line1'
          Weight = 0.750000000000000000
          mmHeight = 265
          mmLeft = 234421
          mmTop = 1058
          mmWidth = 18256
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLine2: TppLine
          UserName = 'Line2'
          Weight = 0.750000000000000000
          mmHeight = 265
          mmLeft = 275432
          mmTop = 529
          mmWidth = 7938
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBCalc5: TppDBCalc
          UserName = 'DBCalc5'
          DataPipeline = ppCashier
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DBCalcType = dcCount
          DataPipelineName = 'ppCashier'
          mmHeight = 3440
          mmLeft = 254794
          mmTop = 1852
          mmWidth = 10319
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ppCashier: TppBDEPipeline
    DataSource = kbmReportDS
    OpenDataSource = False
    UserName = 'Cashier'
    Left = 200
    Top = 504
    object ppCashierppField1: TppField
      FieldAlias = 'RecId'
      FieldName = 'RecId'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppCashierppField2: TppField
      FieldAlias = 'LineType'
      FieldName = 'LineType'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppCashierppField3: TppField
      FieldAlias = 'TypeIndex'
      FieldName = 'TypeIndex'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppCashierppField4: TppField
      FieldAlias = 'Staff'
      FieldName = 'Staff'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppCashierppField5: TppField
      FieldAlias = 'Name'
      FieldName = 'Name'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppCashierppField6: TppField
      FieldAlias = 'LineIndex'
      FieldName = 'LineIndex'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppCashierppField7: TppField
      FieldAlias = 'InvoiceNumber'
      FieldName = 'InvoiceNumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppCashierppField8: TppField
      FieldAlias = 'txDate'
      FieldName = 'txDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppCashierppField9: TppField
      FieldAlias = 'Created'
      FieldName = 'Created'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppCashierppField10: TppField
      FieldAlias = 'room'
      FieldName = 'room'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object ppCashierppField11: TppField
      FieldAlias = 'product'
      FieldName = 'product'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object ppCashierppField12: TppField
      FieldAlias = 'productdescription'
      FieldName = 'productdescription'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object ppCashierppField13: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object ppCashierppField14: TppField
      FieldAlias = 'numberofitems'
      FieldName = 'numberofitems'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object ppCashierppField15: TppField
      FieldAlias = 'nativeTotalPrice'
      FieldName = 'nativeTotalPrice'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object ppCashierppField16: TppField
      FieldAlias = 'NameCol'
      FieldName = 'NameCol'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object ppCashierppField17: TppField
      FieldAlias = 'DescriptionCol'
      FieldName = 'DescriptionCol'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object ppCashierppField18: TppField
      FieldAlias = 'TypeCol'
      FieldName = 'TypeCol'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object ppCashierppField19: TppField
      FieldAlias = 'LineTypeInt'
      FieldName = 'LineTypeInt'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
    object ppCashierppField20: TppField
      FieldAlias = 'Reservation'
      FieldName = 'Reservation'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 19
      Searchable = False
      Sortable = False
    end
    object ppCashierppField21: TppField
      FieldAlias = 'RoomReservation'
      FieldName = 'RoomReservation'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 20
      Searchable = False
      Sortable = False
    end
    object ppCashierppField22: TppField
      FieldAlias = 'Category'
      FieldName = 'Category'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 21
      Searchable = False
      Sortable = False
    end
    object ppCashierppField23: TppField
      FieldAlias = 'BookingId'
      FieldName = 'BookingId'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 22
      Searchable = False
      Sortable = False
    end
    object ppCashierppField24: TppField
      FieldAlias = 'GuestName'
      FieldName = 'GuestName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 23
      Searchable = False
      Sortable = False
    end
    object ppCashierppField25: TppField
      FieldAlias = 'Arrival'
      FieldName = 'Arrival'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 24
      Searchable = False
      Sortable = False
    end
    object ppCashierppField26: TppField
      FieldAlias = 'Departure'
      FieldName = 'Departure'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 25
      Searchable = False
      Sortable = False
    end
  end
  object _kbmPayments: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Type'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Amount'
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
    Left = 72
    Top = 296
  end
  object kbmPaymentsDS: TDataSource
    DataSet = kbmPayments
    Left = 544
    Top = 456
  end
  object ppPayments: TppBDEPipeline
    DataSource = kbmPaymentsDS
    OpenDataSource = False
    UserName = 'Payments'
    Left = 280
    Top = 504
  end
  object kbmReportDS: TDataSource
    DataSet = kbmReport
    Left = 52
    Top = 393
  end
  object erGrid: TcxEditRepository
    Left = 544
    Top = 312
    object erGridTextItem1: TcxEditRepositoryTextItem
    end
  end
  object _kbmReport: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'LineType'
        DataType = ftWideString
        Size = 35
      end
      item
        Name = 'TypeIndex'
        DataType = ftInteger
      end
      item
        Name = 'Staff'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Name'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'LineIndex'
        DataType = ftInteger
      end
      item
        Name = 'InvoiceNumber'
        DataType = ftInteger
      end
      item
        Name = 'txDate'
        DataType = ftDate
      end
      item
        Name = 'Created'
        DataType = ftDateTime
      end
      item
        Name = 'room'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'product'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'productdescription'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'numberofitems'
        DataType = ftInteger
      end
      item
        Name = 'nativeTotalPrice'
        DataType = ftFloat
      end
      item
        Name = 'NameCol'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'DescriptionCol'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'TypeCol'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'LineTypeInt'
        DataType = ftInteger
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'Category'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'BookingId'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'Arrival'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'Departure'
        DataType = ftWideString
        Size = 10
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
    Left = 224
    Top = 296
  end
  object kbmReport: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 64
    Top = 552
    object kbmReportLineType: TWideStringField
      FieldName = 'LineType'
      Size = 35
    end
    object kbmReportTypeIndex: TIntegerField
      FieldName = 'TypeIndex'
    end
    object kbmReportStaff: TWideStringField
      FieldName = 'Staff'
    end
    object kbmReportName: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
    object kbmReportLineIndex: TIntegerField
      FieldName = 'LineIndex'
    end
    object kbmReportInvoiceNumber: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object kbmReporttxDate: TDateField
      FieldName = 'txDate'
    end
    object kbmReportCreated: TDateTimeField
      FieldName = 'Created'
    end
    object kbmReportroom: TStringField
      FieldName = 'room'
      Size = 30
    end
    object kbmReportproduct: TWideStringField
      FieldName = 'product'
    end
    object kbmReportproductdescription: TWideStringField
      FieldName = 'productdescription'
      Size = 100
    end
    object kbmReportDescription: TWideStringField
      FieldName = 'Description'
      Size = 100
    end
    object kbmReportnumberofitems: TIntegerField
      FieldName = 'numberofitems'
    end
    object kbmReportnativeTotalPrice: TFloatField
      FieldName = 'nativeTotalPrice'
    end
    object kbmReportNameCol: TWideStringField
      FieldName = 'NameCol'
      Size = 100
    end
    object kbmReportDescriptionCol: TWideStringField
      FieldName = 'DescriptionCol'
      Size = 100
    end
    object kbmReportTypeCol: TWideStringField
      FieldName = 'TypeCol'
      Size = 100
    end
    object kbmReportLineTypeInt: TIntegerField
      FieldName = 'LineTypeInt'
    end
    object kbmReportReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object kbmReportRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object kbmReportCategory: TWideStringField
      FieldName = 'Category'
      Size = 100
    end
    object kbmReportBookingId: TWideStringField
      FieldName = 'BookingId'
      Size = 40
    end
    object kbmReportGuestName: TWideStringField
      FieldName = 'GuestName'
      Size = 50
    end
    object kbmReportArrival: TWideStringField
      FieldName = 'Arrival'
      Size = 10
    end
    object kbmReportDeparture: TWideStringField
      FieldName = 'Departure'
      Size = 10
    end
  end
  object kbmPayments: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 544
    Top = 408
    object kbmPaymentsType: TWideStringField
      FieldName = 'Type'
    end
    object kbmPaymentsDescription: TWideStringField
      FieldName = 'Description'
      Size = 100
    end
    object kbmAmount: TFloatField
      FieldName = 'Amount'
    end
  end
  object kbmGet: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 408
    Top = 568
    object WideStringField1: TWideStringField
      FieldName = 'LineType'
      Size = 35
    end
    object IntegerField1: TIntegerField
      FieldName = 'TypeIndex'
    end
    object WideStringField2: TWideStringField
      FieldName = 'Staff'
    end
    object WideStringField3: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
    object IntegerField2: TIntegerField
      FieldName = 'LineIndex'
    end
    object IntegerField3: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object DateField1: TDateField
      FieldName = 'txDate'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'Created'
    end
    object StringField1: TStringField
      FieldName = 'room'
      Size = 30
    end
    object WideStringField4: TWideStringField
      FieldName = 'product'
    end
    object WideStringField5: TWideStringField
      FieldName = 'productdescription'
      Size = 100
    end
    object WideStringField6: TWideStringField
      FieldName = 'Description'
      Size = 100
    end
    object IntegerField4: TIntegerField
      FieldName = 'numberofitems'
    end
    object FloatField1: TFloatField
      FieldName = 'nativeTotalPrice'
    end
    object WideStringField7: TWideStringField
      FieldName = 'NameCol'
      Size = 100
    end
    object WideStringField8: TWideStringField
      FieldName = 'DescriptionCol'
      Size = 100
    end
    object WideStringField9: TWideStringField
      FieldName = 'TypeCol'
      Size = 100
    end
    object IntegerField5: TIntegerField
      FieldName = 'LineTypeInt'
    end
    object IntegerField6: TIntegerField
      FieldName = 'Reservation'
    end
    object IntegerField7: TIntegerField
      FieldName = 'RoomReservation'
    end
    object WideStringField10: TWideStringField
      FieldName = 'Category'
      Size = 100
    end
    object WideStringField11: TWideStringField
      FieldName = 'BookingId'
      Size = 40
    end
    object WideStringField12: TWideStringField
      FieldName = 'GuestName'
      Size = 50
    end
    object WideStringField13: TWideStringField
      FieldName = 'Arrival'
      Size = 10
    end
    object WideStringField14: TWideStringField
      FieldName = 'Departure'
      Size = 10
    end
  end
end
