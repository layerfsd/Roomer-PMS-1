object frmAllotmentToRes: TfrmAllotmentToRes
  Left = 0
  Top = 0
  Caption = 'Provide allotment'
  ClientHeight = 505
  ClientWidth = 1086
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sSplitter1: TsSplitter
    Left = 585
    Top = 0
    Height = 472
    SkinData.SkinSection = 'SPLITTER'
    ExplicitLeft = 676
    ExplicitHeight = 614
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 472
    Width = 1086
    Height = 33
    Align = alBottom
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1086
      33)
    object btnHideShowAllotment: TsButton
      Left = 8
      Top = 4
      Width = 130
      Height = 25
      Caption = 'Hide Allotment'
      ImageIndex = 17
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnHideShowAllotmentClick
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton5: TsButton
      Left = 926
      Top = 4
      Width = 78
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      OnClick = sButton5Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton6: TsButton
      Left = 1007
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 2
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object panLeft: TsPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 472
    Align = alLeft
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sPanel1: TsPanel
      Left = 1
      Top = 1
      Width = 583
      Height = 248
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object sPanel8: TsPanel
        Left = 1
        Top = 1
        Width = 581
        Height = 32
        Align = alTop
        Caption = 'Allotment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        SkinData.SkinSection = 'MENUCAPTION'
      end
      object sGroupBox2: TsGroupBox
        Left = 1
        Top = 33
        Width = 210
        Height = 172
        Align = alLeft
        Caption = 'Show in cells'
        TabOrder = 1
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object chkRoomCount: TsCheckBox
          Left = 14
          Top = 18
          Width = 113
          Height = 19
          Caption = 'Number of Rooms'
          Checked = True
          State = cbChecked
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkGuestName: TsCheckBox
          Left = 14
          Top = 53
          Width = 85
          Height = 19
          Caption = 'Guest name'
          Checked = True
          State = cbChecked
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkPrice: TsCheckBox
          Left = 14
          Top = 70
          Width = 192
          Height = 19
          Caption = 'Price info (Code - Price - Discount)'
          TabOrder = 2
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkNumGuests: TsCheckBox
          Left = 13
          Top = 36
          Width = 113
          Height = 19
          Caption = 'Number of guests'
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object chkShowRoomdescription: TsCheckBox
          Left = 14
          Top = 105
          Width = 136
          Height = 19
          Caption = 'Show room description'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = chkShowRoomdescriptionClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object sCheckBox1: TsCheckBox
          Left = 14
          Top = 128
          Width = 81
          Height = 19
          Caption = 'Fit columns'
          TabOrder = 5
          OnClick = sCheckBox1Click
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object sPanel6: TsPanel
        Left = 1
        Top = 205
        Width = 581
        Height = 42
        Align = alBottom
        TabOrder = 2
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          581
          42)
        object sButton4: TsButton
          Left = 374
          Top = 9
          Width = 204
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Add Allotment to Reservation'
          ImageAlignment = iaRight
          ImageIndex = 107
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton4Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object sGroupBox1: TsGroupBox
        Left = 211
        Top = 33
        Width = 248
        Height = 172
        Align = alLeft
        Caption = 'Allotment'
        TabOrder = 3
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object clabFirstDate: TsLabel
          Left = 8
          Top = 22
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'First date :'
        end
        object clabLastDate: TsLabel
          Left = 8
          Top = 39
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Last date :'
        end
        object clabRoomCount: TsLabel
          Left = 8
          Top = 72
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Res Rooms :'
        end
        object clabDayCount: TsLabel
          Left = 8
          Top = 55
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Days :'
        end
        object labFirstDate: TsLabel
          Left = 110
          Top = 22
          Width = 4
          Height = 13
          Caption = '-'
        end
        object labLastDate: TsLabel
          Left = 110
          Top = 39
          Width = 4
          Height = 13
          Caption = '-'
        end
        object labDays: TsLabel
          Left = 110
          Top = 53
          Width = 4
          Height = 13
          Caption = '-'
        end
        object labRooms: TsLabel
          Left = 110
          Top = 90
          Width = 4
          Height = 13
          Caption = '-'
        end
        object sLabel1: TsLabel
          Left = 8
          Top = 90
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Rooms :'
        end
        object labResRooms: TsLabel
          Left = 110
          Top = 72
          Width = 4
          Height = 13
          Caption = '-'
        end
      end
    end
    object grProvide: TAdvStringGrid
      Tag = 1
      Left = 1
      Top = 249
      Width = 583
      Height = 222
      Cursor = crDefault
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clWhite
      ColCount = 1
      Ctl3D = False
      DefaultRowHeight = 18
      DoubleBuffered = True
      DragKind = dkDock
      DrawingStyle = gdsClassic
      FixedColor = clSkyBlue
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing]
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 1
      StyleElements = [seClient, seBorder]
      GridLineColor = 15527152
      GridFixedLineColor = 13947601
      HoverRowCells = [hcNormal, hcSelected]
      OnGetCellColor = grProvideGetCellColor
      OnClickCell = grProvideClickCell
      OnDblClickCell = grProvideDblClickCell
      DragDropSettings.ShowCells = False
      DragDropSettings.OleAcceptFiles = False
      DragDropSettings.OleAcceptText = False
      DragDropSettings.OleAcceptURLs = False
      ActiveCellShow = True
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Tahoma'
      ActiveCellFont.Style = [fsBold]
      ActiveCellColor = 16575452
      ActiveCellColorTo = 16571329
      BackGround.Color = clWhite
      CellNode.NodeType = cnFlat
      ControlLook.FixedGradientMirrorFrom = 16049884
      ControlLook.FixedGradientMirrorTo = 16247261
      ControlLook.FixedGradientHoverFrom = 16710648
      ControlLook.FixedGradientHoverTo = 16446189
      ControlLook.FixedGradientHoverMirrorFrom = 16049367
      ControlLook.FixedGradientHoverMirrorTo = 15258305
      ControlLook.FixedGradientDownFrom = 15853789
      ControlLook.FixedGradientDownTo = 15852760
      ControlLook.FixedGradientDownMirrorFrom = 15522767
      ControlLook.FixedGradientDownMirrorTo = 15588559
      ControlLook.FixedGradientDownBorder = 14007466
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
      FixedColWidth = 132
      FixedRowHeight = 18
      FixedColAlways = True
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clBlack
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = [fsBold]
      Flat = True
      FloatFormat = '%.2f'
      HoverButtons.Buttons = <>
      HoverButtons.Position = hbLeftFromColumnLeft
      HTMLSettings.ImageFolder = 'images'
      HTMLSettings.ImageBaseName = 'img'
      Look = glWin7
      MouseActions.AllColumnSize = True
      MouseActions.AllRowSize = True
      MouseActions.DisjunctCellSelect = True
      Multilinecells = True
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
      ScrollWidth = 21
      SearchFooter.Color = 16645370
      SearchFooter.ColorTo = 16247261
      SearchFooter.FindNextCaption = 'Find next'
      SearchFooter.FindPrevCaption = 'Find previous'
      SearchFooter.Font.Charset = DEFAULT_CHARSET
      SearchFooter.Font.Color = clWindowText
      SearchFooter.Font.Height = -11
      SearchFooter.Font.Name = 'Tahoma'
      SearchFooter.Font.Style = []
      SearchFooter.HighLightCaption = 'Highlight'
      SearchFooter.HintClose = 'Close'
      SearchFooter.HintFindNext = 'Find next occurence'
      SearchFooter.HintFindPrev = 'Find previous occurence'
      SearchFooter.HintHighlight = 'Highlight occurences'
      SearchFooter.MatchCaseCaption = 'Match case'
      SizeWhileTyping.Height = True
      SortSettings.DefaultFormat = ssAutomatic
      SortSettings.HeaderColor = 16579058
      SortSettings.HeaderColorTo = 16579058
      SortSettings.HeaderMirrorColor = 16380385
      SortSettings.HeaderMirrorColorTo = 16182488
      Version = '7.9.1.0'
      ColWidths = (
        132)
      RowHeights = (
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18)
    end
  end
  object sPanel4: TsPanel
    Left = 591
    Top = 0
    Width = 495
    Height = 472
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object sLabel2: TsLabel
      Left = 240
      Top = 48
      Width = 3
      Height = 13
    end
    object sPanel5: TsPanel
      Left = 1
      Top = 1
      Width = 493
      Height = 248
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object sPanel7: TsPanel
        Left = 1
        Top = 1
        Width = 491
        Height = 32
        Align = alTop
        Caption = 'Reservation'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnDblClick = sPanel7DblClick
        SkinData.SkinSection = 'MENUCAPTION'
      end
      object sGroupBox3: TsGroupBox
        Left = 1
        Top = 33
        Width = 280
        Height = 172
        Align = alLeft
        Caption = 'Reservation'
        TabOrder = 1
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object cLabCountry: TsLabel
          Left = 19
          Top = 72
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Country :'
        end
        object clabReservationName: TsLabel
          Left = 19
          Top = 91
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'ReservationName :'
        end
        object labRefrence: TsLabel
          Left = 119
          Top = 53
          Width = 4
          Height = 13
          Caption = '-'
        end
        object labCountry: TsLabel
          Left = 121
          Top = 74
          Width = 4
          Height = 13
          Caption = '-'
        end
        object labReservationName: TsLabel
          Left = 121
          Top = 91
          Width = 4
          Height = 13
          Caption = '-'
        end
        object sLabel18: TsLabel
          Left = 3
          Top = 147
          Width = 112
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Reservation  status :'
        end
        object labResStatus: TsLabel
          Left = 121
          Top = 147
          Width = 4
          Height = 13
          Caption = '-'
        end
        object labPriceCode: TsLabel
          Left = 121
          Top = 113
          Width = 4
          Height = 13
          Caption = '-'
        end
        object clabRefrence: TsLabel
          Left = 19
          Top = 54
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Refrence :'
        end
        object labCurrency: TsLabel
          Left = 121
          Top = 131
          Width = 4
          Height = 13
          Caption = '-'
        end
        object sLabel3: TsLabel
          Left = 19
          Top = 18
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Customer :'
        end
        object clabCustomerName: TsLabel
          Left = 19
          Top = 36
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Customer name :'
        end
        object labCustomerName: TsLabel
          Left = 121
          Top = 36
          Width = 4
          Height = 13
          Caption = '-'
        end
        object labCustomer: TsLabel
          Left = 121
          Top = 18
          Width = 4
          Height = 13
          Caption = '-'
        end
      end
      object chkIsGroupInvoice: TsCheckBox
        Left = 287
        Top = 180
        Width = 100
        Height = 19
        Caption = 'is Groupinvoice'
        TabOrder = 2
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object sPanel3: TsPanel
        Left = 1
        Top = 205
        Width = 491
        Height = 42
        Align = alBottom
        TabOrder = 3
        SkinData.SkinSection = 'PANEL'
        object sButton2: TsButton
          Left = 4
          Top = 9
          Width = 204
          Height = 25
          Caption = 'Add Room to Allotment'
          ImageIndex = 106
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton2Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object sGroupBox4: TsGroupBox
        Left = 295
        Top = 39
        Width = 185
        Height = 98
        Caption = 'Recalculate Roomprices'
        TabOrder = 4
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object btnReCalc: TsButton
          Left = 12
          Top = 23
          Width = 137
          Height = 25
          Caption = 'Selected room'
          TabOrder = 0
          OnClick = btnReCalcClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnReclacAllPrices: TsButton
          Left = 12
          Top = 55
          Width = 137
          Height = 25
          Caption = 'All  rooms'
          TabOrder = 1
          OnClick = btnReclacAllPricesClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
    object grRoomRes: TcxGrid
      Left = 1
      Top = 249
      Width = 493
      Height = 222
      Align = alClient
      TabOrder = 1
      LookAndFeel.NativeStyle = False
      object tvRoomRes: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = mRoomResDS
        DataController.DetailKeyFieldNames = 'RoomReservation'
        DataController.KeyFieldNames = 'RoomReservation'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '###0.;###0.'
            Kind = skSum
            FieldName = 'Guests'
            Column = tvRoomResGuests
          end
          item
            Format = '###0.;###0.'
            Kind = skSum
            FieldName = 'ChildrenCount'
            Column = tvRoomResChildrenCount
          end
          item
            Format = '###0.;###0.'
            Kind = skSum
            FieldName = 'infantCount'
            Column = tvRoomResinfantCount
          end
          item
            Format = '###0.00;###0.00'
            Kind = skSum
            FieldName = 'AvragePrice'
            Column = tvRoomResAvragePrice
          end
          item
            Format = '###0.00;###0.00'
            Kind = skAverage
            FieldName = 'AvragePrice'
            Column = tvRoomResAvragePrice
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        OptionsView.FooterAutoHeight = True
        OptionsView.FooterMultiSummaries = True
        OptionsView.GroupByBox = False
        object tvRoomResColumn1: TcxGridDBColumn
          Caption = 'Edit'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = 'Refresh'
              Default = True
              ImageIndex = 29
              Kind = bkGlyph
            end>
          Properties.ViewStyle = vsButtonsOnly
          Options.ShowEditButtons = isebAlways
          Width = 39
        end
        object tvRoomResRoom: TcxGridDBColumn
          DataBinding.FieldName = 'Room'
          Options.Editing = False
        end
        object tvRoomResRoomDescription: TcxGridDBColumn
          Caption = 'Description'
          DataBinding.FieldName = 'RoomDescription'
          Options.Editing = False
          Width = 118
        end
        object tvRoomResRoomType: TcxGridDBColumn
          Caption = 'Type'
          DataBinding.FieldName = 'RoomType'
          Options.Editing = False
        end
        object tvRoomResRoomTypeDescription: TcxGridDBColumn
          Caption = 'Description'
          DataBinding.FieldName = 'RoomTypeDescription'
          Visible = False
          Options.Editing = False
          Width = 111
        end
        object tvRoomResArrival: TcxGridDBColumn
          DataBinding.FieldName = 'Arrival'
          Options.Editing = False
          Width = 88
        end
        object tvRoomResDeparture: TcxGridDBColumn
          DataBinding.FieldName = 'Departure'
          Options.Editing = False
          Width = 79
        end
        object tvRoomResGuests: TcxGridDBColumn
          DataBinding.FieldName = 'Guests'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.MaxValue = 100.000000000000000000
          Properties.MinValue = 1.000000000000000000
          Width = 45
        end
        object tvRoomResChildrenCount: TcxGridDBColumn
          Caption = 'Children'
          DataBinding.FieldName = 'ChildrenCount'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.MaxValue = 10.000000000000000000
          Width = 45
        end
        object tvRoomResinfantCount: TcxGridDBColumn
          Caption = 'infants'
          DataBinding.FieldName = 'infantCount'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.MaxValue = 10.000000000000000000
          Width = 45
        end
        object tvRoomResMainGuest: TcxGridDBColumn
          DataBinding.FieldName = 'MainGuest'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 150
        end
        object tvRoomResAvragePrice: TcxGridDBColumn
          Caption = 'Netto Rate'
          DataBinding.FieldName = 'AvragePrice'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '###0.00;###0.00'
          Width = 73
        end
        object tvRoomResRateCount: TcxGridDBColumn
          DataBinding.FieldName = 'RateCount'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.DisplayFormat = '###0.;###0.'
          Options.Editing = False
        end
        object tvRoomResRoomReservation: TcxGridDBColumn
          DataBinding.FieldName = 'RoomReservation'
          Visible = False
        end
        object tvRoomResAvrageDiscount: TcxGridDBColumn
          DataBinding.FieldName = 'AvrageDiscount'
          Options.Editing = False
        end
        object tvRoomResisPercentage: TcxGridDBColumn
          Caption = '%'
          DataBinding.FieldName = 'isPercentage'
          Options.Editing = False
        end
        object tvRoomResPriceCode: TcxGridDBColumn
          DataBinding.FieldName = 'PriceCode'
          Options.Editing = False
          Width = 74
        end
      end
      object tvRoomRates: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataModeController.SyncMode = False
        DataController.DataSource = kbmRoomRatesDS
        DataController.DetailKeyFieldNames = 'RoomReservation'
        DataController.KeyFieldNames = 'RoomReservation'
        DataController.MasterKeyFieldNames = 'RoomReservation'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object tvRoomRatesReservation: TcxGridDBColumn
          DataBinding.FieldName = 'Reservation'
          Visible = False
        end
        object tvRoomRatesRoomReservation: TcxGridDBColumn
          DataBinding.FieldName = 'RoomReservation'
          Visible = False
        end
        object tvRoomRatesRoomNumber: TcxGridDBColumn
          Caption = 'Room'
          DataBinding.FieldName = 'RoomNumber'
          Visible = False
        end
        object tvRoomRatesRateDate: TcxGridDBColumn
          Caption = 'Date'
          DataBinding.FieldName = 'RateDate'
        end
        object tvRoomRatesPriceCode: TcxGridDBColumn
          Caption = 'Price code'
          DataBinding.FieldName = 'PriceCode'
        end
        object tvRoomRatesRate: TcxGridDBColumn
          Caption = 'Room Rate'
          DataBinding.FieldName = 'Rate'
          PropertiesClassName = 'TcxCalcEditProperties'
        end
        object tvRoomRatesDiscount: TcxGridDBColumn
          DataBinding.FieldName = 'Discount'
        end
        object tvRoomRatesisPercentage: TcxGridDBColumn
          Caption = 'is %'
          DataBinding.FieldName = 'isPercentage'
        end
        object tvRoomRatesShowDiscount: TcxGridDBColumn
          Caption = 'Show Discount'
          DataBinding.FieldName = 'ShowDiscount'
          Visible = False
        end
        object tvRoomRatesisPaid: TcxGridDBColumn
          Caption = 'Paid'
          DataBinding.FieldName = 'isPaid'
          Visible = False
        end
        object tvRoomRatesDiscountAmount: TcxGridDBColumn
          Caption = 'Total discount'
          DataBinding.FieldName = 'DiscountAmount'
        end
        object tvRoomRatesRentAmount: TcxGridDBColumn
          Caption = 'Total Rent'
          DataBinding.FieldName = 'RentAmount'
        end
        object tvRoomRatesNativeAmount: TcxGridDBColumn
          Caption = 'Native'
          DataBinding.FieldName = 'NativeAmount'
        end
      end
      object lvRoomRes: TcxGridLevel
        GridView = tvRoomRes
        object lvRoomRates: TcxGridLevel
          GridView = tvRoomRates
        end
      end
    end
  end
  object mRrInfo: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'rdID'
        DataType = ftInteger
      end
      item
        Name = 'RoomReservation'
        DataType = ftInteger
      end
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'dtDate'
        DataType = ftDateTime
      end
      item
        Name = 'Room'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'RoomType'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ResFlag'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'isNoRoom'
        DataType = ftBoolean
      end
      item
        Name = 'PriceCode'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'RoomRate'
        DataType = ftFloat
      end
      item
        Name = 'Discount'
        DataType = ftFloat
      end
      item
        Name = 'isPercentage'
        DataType = ftBoolean
      end
      item
        Name = 'showDiscount'
        DataType = ftBoolean
      end
      item
        Name = 'Paid'
        DataType = ftBoolean
      end
      item
        Name = 'Currency'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'MainGuest'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'numChildren'
        DataType = ftInteger
      end
      item
        Name = 'numInfants'
        DataType = ftInteger
      end
      item
        Name = 'numGuests'
        DataType = ftInteger
      end
      item
        Name = 'RoomDescription'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'RoomCount'
        DataType = ftInteger
      end
      item
        Name = 'Col'
        DataType = ftInteger
      end
      item
        Name = 'Row'
        DataType = ftInteger
      end
      item
        Name = 'id'
        DataType = ftAutoInc
      end
      item
        Name = 'Processed'
        DataType = ftInteger
      end
      item
        Name = 'GroupAccount'
        DataType = ftBoolean
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
    BeforePost = mRrInfoBeforePost
    Left = 24
    Top = 384
  end
  object mRrInfoDS: TDataSource
    DataSet = mRrInfo
    Left = 80
    Top = 384
  end
  object mRooms: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Room'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'RoomType'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'RoomDescription'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'otherInfo'
        DataType = ftString
        Size = 255
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
    Left = 24
    Top = 480
  end
  object mRoomsDS: TDataSource
    DataSet = mRooms
    Left = 104
    Top = 480
  end
  object timClose: TTimer
    Enabled = False
    Interval = 5
    OnTimer = timCloseTimer
    Left = 152
    Top = 344
  end
  object kbmRoomRes: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'RoomReservation'
        DataType = ftInteger
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
        Name = 'Guests'
        DataType = ftInteger
      end
      item
        Name = 'AvragePrice'
        DataType = ftFloat
      end
      item
        Name = 'RateCount'
        DataType = ftInteger
      end
      item
        Name = 'RoomDescription'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'RoomTypeDescription'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Arrival'
        DataType = ftDateTime
      end
      item
        Name = 'Departure'
        DataType = ftDateTime
      end
      item
        Name = 'ChildrenCount'
        DataType = ftInteger
      end
      item
        Name = 'infantCount'
        DataType = ftInteger
      end
      item
        Name = 'PriceCode'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'AvrageDiscount'
        DataType = ftFloat
      end
      item
        Name = 'isPercentage'
        DataType = ftBoolean
      end
      item
        Name = 'MainGuest'
        DataType = ftString
        Size = 100
      end>
    IndexFieldNames = 'Room'
    IndexName = '__MT__DEFAULT_'
    IndexDefs = <>
    SortFields = 'Room'
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
    Left = 360
    Top = 304
  end
  object mRoomResDS: TDataSource
    DataSet = kbmRoomRes
    Left = 432
    Top = 304
  end
  object kbmRoomRates: TkbmMemTable
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
        Name = 'RoomNumber'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'RateDate'
        DataType = ftDateTime
      end
      item
        Name = 'PriceCode'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Rate'
        DataType = ftFloat
      end
      item
        Name = 'Discount'
        DataType = ftFloat
      end
      item
        Name = 'isPercentage'
        DataType = ftBoolean
      end
      item
        Name = 'ShowDiscount'
        DataType = ftBoolean
      end
      item
        Name = 'isPaid'
        DataType = ftBoolean
      end
      item
        Name = 'DiscountAmount'
        DataType = ftFloat
      end
      item
        Name = 'RentAmount'
        DataType = ftFloat
      end
      item
        Name = 'NativeAmount'
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
    Left = 360
    Top = 368
  end
  object kbmRoomRatesDS: TDataSource
    DataSet = kbmRoomRates
    Left = 448
    Top = 368
  end
  object mQuickResDS: TDataSource
    DataSet = mQuickRes
    Left = 176
    Top = 544
  end
  object mQuickRes: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Row'
        DataType = ftInteger
      end
      item
        Name = 'FirstCol'
        DataType = ftInteger
      end
      item
        Name = 'LastCol'
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
    Left = 96
    Top = 552
  end
  object kbmrestRoomRes: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'RoomReservation'
        DataType = ftInteger
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
        Name = 'Guests'
        DataType = ftInteger
      end
      item
        Name = 'AvragePrice'
        DataType = ftFloat
      end
      item
        Name = 'RateCount'
        DataType = ftInteger
      end
      item
        Name = 'RoomDescription'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'RoomTypeDescription'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Arrival'
        DataType = ftDateTime
      end
      item
        Name = 'Departure'
        DataType = ftDateTime
      end
      item
        Name = 'ChildrenCount'
        DataType = ftInteger
      end
      item
        Name = 'infantCount'
        DataType = ftInteger
      end
      item
        Name = 'PriceCode'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'AvrageDiscount'
        DataType = ftFloat
      end
      item
        Name = 'isPercentage'
        DataType = ftBoolean
      end
      item
        Name = 'MainGuest'
        DataType = ftString
        Size = 100
      end>
    IndexFieldNames = 'Room'
    IndexName = '__MT__DEFAULT_'
    IndexDefs = <>
    SortFields = 'Room'
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
    Left = 360
    Top = 432
  end
  object kbmrestRoomResDS: TDataSource
    DataSet = kbmrestRoomRes
    Left = 464
    Top = 432
  end
  object kbmRestRoomRatesDS: TDataSource
    DataSet = kbmRestRoomRates
    Left = 464
    Top = 504
  end
  object kbmRestRoomRates: TkbmMemTable
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
        Name = 'RoomNumber'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'RateDate'
        DataType = ftDateTime
      end
      item
        Name = 'PriceCode'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Rate'
        DataType = ftFloat
      end
      item
        Name = 'Discount'
        DataType = ftFloat
      end
      item
        Name = 'isPercentage'
        DataType = ftBoolean
      end
      item
        Name = 'ShowDiscount'
        DataType = ftBoolean
      end
      item
        Name = 'isPaid'
        DataType = ftBoolean
      end
      item
        Name = 'DiscountAmount'
        DataType = ftFloat
      end
      item
        Name = 'RentAmount'
        DataType = ftFloat
      end
      item
        Name = 'NativeAmount'
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
    Left = 360
    Top = 504
  end
end
