object frmDayNotes: TfrmDayNotes
  Left = 809
  Top = 230
  Caption = 'Live Data'
  ClientHeight = 629
  ClientWidth = 947
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DateLabel1: TDateLabel
    Left = 480
    Top = 328
    Width = 50
    Height = 13
    Caption = '15-5-2016'
    DateTimeFormat = 'd/m/yyyy'
    Version = '1.1.0.0'
    RefreshInterval = 0
    RefreshEnabled = False
  end
  object LMDStatusBar1: TStatusBar
    Left = 0
    Top = 610
    Width = 947
    Height = 19
    Panels = <>
  end
  object pageMain: TsPageControl
    Left = 0
    Top = 0
    Width = 947
    Height = 610
    ActivePage = tabStatus
    Align = alClient
    HotTrack = True
    Style = tsButtons
    TabHeight = 25
    TabOrder = 1
    TabWidth = 150
    OnChange = pageMainChange
    ActiveIsBold = True
    SkinData.SkinSection = 'PAGECONTROL'
    object tabDayNotes: TsTabSheet
      Caption = 'Front'
      object sGroupBox1: TsGroupBox
        Left = 0
        Top = 0
        Width = 939
        Height = 113
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alTop
        Caption = 'Notes'
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object sWebLabel1: TsWebLabel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 929
          Height = 90
          Align = alClient
          Alignment = taCenter
          Caption = 
            'This window will always stay on top of other windows '#13#10'and its d' +
            'ata will change if roomer date is changed'#13#10#13#10'Use F11 to toggle t' +
            'his window on and off'
          ParentFont = False
          Layout = tlCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HoverFont.Charset = DEFAULT_CHARSET
          HoverFont.Color = clWindowText
          HoverFont.Height = -11
          HoverFont.Name = 'Tahoma'
          HoverFont.Style = []
          ExplicitWidth = 351
          ExplicitHeight = 64
        end
      end
      object edCurrentDate: TEdit
        Left = 872
        Top = 11
        Width = 41
        Height = 21
        TabOrder = 1
        Visible = False
        OnChange = edCurrentDateChange
      end
    end
    object tabStatus: TsTabSheet
      Caption = 'Availibility status'
      ImageIndex = 3
      object Panel3: TsPanel
        Left = 0
        Top = 33
        Width = 939
        Height = 31
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object cxLabel1: TsLabel
          Left = 0
          Top = 5
          Width = 118
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Days to show :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labCol: TsLabel
          Left = 492
          Top = 5
          Width = 5
          Height = 16
          Caption = '-'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cxLabel3: TsLabel
          Left = 196
          Top = 5
          Width = 58
          Height = 17
          AutoSize = False
          Caption = 'From :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object cxLabel4: TsLabel
          Left = 323
          Top = 5
          Width = 32
          Height = 17
          AutoSize = False
          Caption = 'To :'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labStatusDateFrom: TsLabel
          Left = 248
          Top = 5
          Width = 64
          Height = 16
          Caption = '10.10.2011'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labStatusDateTo: TsLabel
          Left = 365
          Top = 5
          Width = 64
          Height = 16
          Caption = '10.10.2011'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edRefresh: TEdit
          Left = 944
          Top = 2
          Width = 321
          Height = 21
          TabOrder = 0
          Visible = False
          OnChange = edRefreshChange
        end
        object edDaysToShow: TsSpinEdit
          Left = 124
          Top = 2
          Width = 60
          Height = 24
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = edDaysToShowPropertiesChange
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 0
          MinValue = 1
          Value = 0
        end
      end
      object cxPageControl1: TcxPageControl
        Left = 0
        Top = 64
        Width = 939
        Height = 511
        Align = alClient
        TabOrder = 1
        Properties.CustomButtons.Buttons = <>
        LookAndFeel.NativeStyle = False
        ClientRectBottom = 509
        ClientRectLeft = 2
        ClientRectRight = 937
        ClientRectTop = 2
      end
      object Panel4: TsPanel
        Left = 0
        Top = 0
        Width = 939
        Height = 33
        Align = alTop
        TabOrder = 2
        SkinData.SkinSection = 'PANEL'
        object cxButton7: TsButton
          Left = 12
          Top = 3
          Width = 100
          Height = 24
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = cxButton7Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnRefreshPivStatus: TsButton
          Left = 124
          Top = 4
          Width = 100
          Height = 25
          Caption = 'Refresh'
          ImageIndex = 28
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnRefreshPivStatusClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object pivStatus: TcxDBPivotGrid
        Left = 0
        Top = 64
        Width = 939
        Height = 511
        Align = alClient
        DataSource = RoomStatusDS
        Groups = <>
        LookAndFeel.Kind = lfStandard
        LookAndFeel.NativeStyle = False
        LookAndFeel.SkinName = ''
        OptionsPrefilter.Visible = pfvAlways
        TabOrder = 3
        object cxDBPivotGrid1resDate: TcxDBPivotGridField
          Area = faRow
          AreaIndex = 0
          DataBinding.FieldName = 'resDate'
          Visible = True
          UniqueName = 'resDate'
        end
        object cxDBPivotGrid1RoomType: TcxDBPivotGridField
          Area = faColumn
          AreaIndex = 0
          DataBinding.FieldName = 'RoomType'
          PropertiesClassName = 'TcxLabelProperties'
          Visible = True
          UniqueName = 'RoomType'
        end
        object cxDBPivotGrid1Description: TcxDBPivotGridField
          AreaIndex = 0
          DataBinding.FieldName = 'Description'
          Visible = True
          UniqueName = 'Description'
        end
        object cxDBPivotGrid1available: TcxDBPivotGridField
          Area = faData
          AreaIndex = 0
          DataBinding.FieldName = 'available'
          Visible = True
          UniqueName = 'available'
        end
        object cxDBPivotGrid1RoomTypeGroup: TcxDBPivotGridField
          AreaIndex = 1
          DataBinding.FieldName = 'RoomTypeGroup'
          Visible = True
          UniqueName = 'RoomTypeGroup'
        end
        object pivStatusNumberGuests: TcxDBPivotGridField
          AreaIndex = 2
          DataBinding.FieldName = 'NumberGuests'
          Visible = True
          UniqueName = 'NumberGuests'
        end
      end
    end
    object tabLog: TsTabSheet
      Caption = 'Log'
      ImageIndex = 1
      object Panel1: TsPanel
        Left = 0
        Top = 0
        Width = 939
        Height = 9
        Align = alTop
        Color = clHighlight
        ParentBackground = False
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
      object pageLog: TcxPageControl
        Left = 0
        Top = 9
        Width = 939
        Height = 566
        Align = alClient
        TabOrder = 1
        Properties.ActivePage = tabImportLog
        Properties.CustomButtons.Buttons = <>
        LookAndFeel.NativeStyle = False
        OnPageChanging = pageLogPageChanging
        ClientRectBottom = 564
        ClientRectLeft = 2
        ClientRectRight = 937
        ClientRectTop = 22
        object tabActionLog: TcxTabSheet
          Caption = 'Actions'
          ImageIndex = 0
          object memLog: TsMemo
            Left = 0
            Top = 41
            Width = 935
            Height = 501
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            WordWrap = False
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
            SkinData.SkinSection = 'EDIT'
          end
          object Panel5: TsPanel
            Left = 0
            Top = 0
            Width = 935
            Height = 41
            Align = alTop
            TabOrder = 1
            SkinData.SkinSection = 'PANEL'
            object btnFormatLog: TsButton
              Left = 11
              Top = 10
              Width = 80
              Height = 25
              Caption = 'Format'
              TabOrder = 0
              OnClick = btnFormatLogClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnClearLog: TsButton
              Left = 96
              Top = 10
              Width = 81
              Height = 25
              Caption = 'Clear'
              TabOrder = 1
              OnClick = btnClearLogClick
              SkinData.SkinSection = 'BUTTON'
            end
            object btnLogLogToClipboard: TsButton
              Left = 183
              Top = 10
              Width = 80
              Height = 25
              Caption = 'To clipboard'
              TabOrder = 2
              OnClick = btnLogLogToClipboardClick
              SkinData.SkinSection = 'BUTTON'
            end
            object sButton1: TsButton
              Left = 269
              Top = 10
              Width = 80
              Height = 25
              Caption = 'To top'
              TabOrder = 3
              OnClick = sButton1Click
              SkinData.SkinSection = 'BUTTON'
            end
            object sButton3: TsButton
              Left = 355
              Top = 10
              Width = 79
              Height = 25
              Caption = 'downLine'
              TabOrder = 4
              OnClick = sButton3Click
              SkinData.SkinSection = 'BUTTON'
            end
            object sButton4: TsButton
              Left = 441
              Top = 10
              Width = 80
              Height = 25
              Caption = 'UpLine'
              TabOrder = 5
              OnClick = sButton4Click
              SkinData.SkinSection = 'BUTTON'
            end
          end
        end
        object tabImportLog: TcxTabSheet
          Caption = 'Import'
          ImageIndex = 1
          object Panel6: TsPanel
            Left = 0
            Top = 0
            Width = 935
            Height = 65
            Align = alTop
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            object cxLabel5: TsLabel
              Left = 177
              Top = 11
              Width = 75
              Height = 17
              AutoSize = False
              Caption = 'Days to show :'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
            end
            object cxLabel6: TsLabel
              Left = 320
              Top = 11
              Width = 46
              Height = 17
              AutoSize = False
              Caption = 'From :'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
            end
            object cxLabel7: TsLabel
              Left = 369
              Top = 11
              Width = 64
              Height = 16
              Caption = '10.10.2011'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
            end
            object cxLabel8: TsLabel
              Left = 430
              Top = 11
              Width = 33
              Height = 17
              AutoSize = False
              Caption = 'To :'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
            end
            object cxLabel9: TsLabel
              Left = 473
              Top = 11
              Width = 64
              Height = 16
              Caption = '10.10.2011'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
            end
            object dtImportLogDate: TsDateEdit
              Left = 21
              Top = 8
              Width = 112
              Height = 21
              AutoSize = False
              Color = clWhite
              EditMask = '!99/99/9999;1; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2302755
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              TabOrder = 0
              Text = '  -  -    '
              OnChange = dtImportLogDateChange
              CheckOnExit = True
              SkinData.SkinSection = 'EDIT'
              GlyphMode.Blend = 0
              GlyphMode.Grayed = False
            end
            object cxButton5: TsButton
              Left = 544
              Top = 8
              Width = 75
              Height = 21
              Caption = 'Refresh'
              TabOrder = 1
              OnClick = cxButton5Click
              SkinData.SkinSection = 'BUTTON'
            end
            object edImportLogDaysToShow: TsSpinEdit
              Left = 255
              Top = 9
              Width = 59
              Height = 24
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              OnChange = edImportLogDaysToShowPropertiesChange
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              MaxValue = 0
              MinValue = 1
              Value = 0
            end
            object cxButton10: TsButton
              Left = 17
              Top = 35
              Width = 79
              Height = 25
              Caption = 'Excel'
              TabOrder = 8
              OnClick = cxButton10Click
              SkinData.SkinSection = 'BUTTON'
            end
            object cxButton11: TsButton
              Left = 99
              Top = 35
              Width = 79
              Height = 25
              Caption = 'Reservaton'
              TabOrder = 3
              OnClick = cxButton11Click
              SkinData.SkinSection = 'BUTTON'
            end
            object cxButton12: TsButton
              Left = 180
              Top = 35
              Width = 80
              Height = 25
              Caption = 'Room'
              TabOrder = 4
              SkinData.SkinSection = 'BUTTON'
            end
            object cxButton13: TsButton
              Left = 262
              Top = 35
              Width = 80
              Height = 25
              Caption = 'Guests'
              TabOrder = 5
              OnClick = cxButton13Click
              SkinData.SkinSection = 'BUTTON'
            end
            object cxButton14: TsButton
              Left = 343
              Top = 35
              Width = 81
              Height = 25
              Caption = 'Invoices'
              DropDownMenu = mnuFinishedInv
              TabOrder = 6
              SkinData.SkinSection = 'BUTTON'
            end
            object cxButton15: TsButton
              Left = 430
              Top = 35
              Width = 111
              Height = 25
              Caption = 'Reservation Notes'
              TabOrder = 7
              OnClick = cxButton15Click
              SkinData.SkinSection = 'BUTTON'
            end
          end
          object Panel7: TsPanel
            Left = 0
            Top = 65
            Width = 935
            Height = 326
            Align = alTop
            TabOrder = 1
            SkinData.SkinSection = 'PANEL'
            object gridImportLogs: TcxGrid
              Left = 1
              Top = 1
              Width = 933
              Height = 324
              Align = alClient
              TabOrder = 0
              LookAndFeel.NativeStyle = False
              object gridImportLogsDBTableView1: TcxGridDBTableView
                Navigator.Buttons.CustomButtons = <>
                Navigator.Buttons.First.Visible = True
                Navigator.Buttons.PriorPage.Visible = True
                Navigator.Buttons.Prior.Visible = True
                Navigator.Buttons.Next.Visible = True
                Navigator.Buttons.NextPage.Visible = True
                Navigator.Buttons.Last.Visible = True
                Navigator.Buttons.Insert.Enabled = False
                Navigator.Buttons.Insert.Visible = False
                Navigator.Buttons.Append.Enabled = False
                Navigator.Buttons.Append.Visible = False
                Navigator.Buttons.Delete.Enabled = False
                Navigator.Buttons.Delete.Visible = False
                Navigator.Buttons.Edit.Enabled = False
                Navigator.Buttons.Edit.Visible = False
                Navigator.Buttons.Post.Enabled = False
                Navigator.Buttons.Post.Visible = False
                Navigator.Buttons.Cancel.Enabled = False
                Navigator.Buttons.Cancel.Visible = True
                Navigator.Buttons.Refresh.Visible = True
                Navigator.Buttons.SaveBookmark.Visible = True
                Navigator.Buttons.GotoBookmark.Visible = True
                Navigator.Buttons.Filter.Visible = True
                Navigator.Visible = True
                DataController.DataSource = ImportLogsDS
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsBehavior.IncSearch = True
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsView.Indicator = True
                object gridImportLogsDBTableView1RecId: TcxGridDBColumn
                  DataBinding.FieldName = 'RecId'
                  Visible = False
                end
                object gridImportLogsDBTableView1ID: TcxGridDBColumn
                  DataBinding.FieldName = 'ID'
                  Visible = False
                end
                object gridImportLogsDBTableView1DateInsert: TcxGridDBColumn
                  Caption = 'To Home'
                  DataBinding.FieldName = 'DateInsert'
                end
                object gridImportLogsDBTableView1DateExport: TcxGridDBColumn
                  Caption = 'From Pos'
                  DataBinding.FieldName = 'DateExport'
                end
                object gridImportLogsDBTableView1ImportTypeID: TcxGridDBColumn
                  DataBinding.FieldName = 'ImportTypeID'
                  Visible = False
                  Width = 78
                end
                object gridImportLogsDBTableView1ImportType: TcxGridDBColumn
                  DataBinding.FieldName = 'ImportType'
                  Width = 116
                end
                object gridImportLogsDBTableView1ImportResultId: TcxGridDBColumn
                  DataBinding.FieldName = 'ImportResultId'
                  Visible = False
                end
                object gridImportLogsDBTableView1ImportResult: TcxGridDBColumn
                  DataBinding.FieldName = 'ImportResult'
                  Width = 143
                end
                object gridImportLogsDBTableView1SaleRefrence: TcxGridDBColumn
                  DataBinding.FieldName = 'SaleRefrence'
                  Width = 101
                end
                object gridImportLogsDBTableView1RoomNumber: TcxGridDBColumn
                  Caption = 'Room'
                  DataBinding.FieldName = 'RoomNumber'
                end
                object gridImportLogsDBTableView1ItemCount: TcxGridDBColumn
                  Caption = 'Items'
                  DataBinding.FieldName = 'ItemCount'
                end
                object gridImportLogsDBTableView1HotelCode: TcxGridDBColumn
                  Caption = 'Hotel'
                  DataBinding.FieldName = 'HotelCode'
                  Width = 40
                end
                object gridImportLogsDBTableView1Staff: TcxGridDBColumn
                  DataBinding.FieldName = 'Staff'
                  Width = 64
                end
                object gridImportLogsDBTableView1isGroupInvoice: TcxGridDBColumn
                  Caption = 'is GroupInv'
                  DataBinding.FieldName = 'isGroupInvoice'
                end
                object gridImportLogsDBTableView1invCustomer: TcxGridDBColumn
                  DataBinding.FieldName = 'invCustomer'
                  Width = 67
                end
                object gridImportLogsDBTableView1invPersonalID: TcxGridDBColumn
                  DataBinding.FieldName = 'invPersonalID'
                  Width = 59
                end
                object gridImportLogsDBTableView1invCustomerName: TcxGridDBColumn
                  DataBinding.FieldName = 'invCustomerName'
                  Width = 50
                end
                object gridImportLogsDBTableView1InvAddress1: TcxGridDBColumn
                  DataBinding.FieldName = 'InvAddress1'
                  Width = 50
                end
                object gridImportLogsDBTableView1invAddress2: TcxGridDBColumn
                  DataBinding.FieldName = 'invAddress2'
                  Width = 50
                end
                object gridImportLogsDBTableView1invAddress3: TcxGridDBColumn
                  DataBinding.FieldName = 'invAddress3'
                  Width = 62
                end
                object gridImportLogsDBTableView1invAddress4: TcxGridDBColumn
                  DataBinding.FieldName = 'invAddress4'
                  Width = 50
                end
                object gridImportLogsDBTableView1GuestName: TcxGridDBColumn
                  DataBinding.FieldName = 'GuestName'
                  Width = 50
                end
                object gridImportLogsDBTableView1Reservation: TcxGridDBColumn
                  DataBinding.FieldName = 'Reservation'
                end
                object gridImportLogsDBTableView1RoomReservation: TcxGridDBColumn
                  DataBinding.FieldName = 'RoomReservation'
                end
                object gridImportLogsDBTableView1Customer: TcxGridDBColumn
                  DataBinding.FieldName = 'Customer'
                end
                object gridImportLogsDBTableView1invoiceNumber: TcxGridDBColumn
                  DataBinding.FieldName = 'invoiceNumber'
                end
              end
              object gridImportLogsLevel1: TcxGridLevel
                GridView = gridImportLogsDBTableView1
              end
            end
          end
          object cxSplitter1: TcxSplitter
            Left = 0
            Top = 391
            Width = 935
            Height = 8
            HotZoneClassName = 'TcxMediaPlayer9Style'
            AlignSplitter = salTop
            Control = Panel7
          end
          object Panel8: TsPanel
            Left = 0
            Top = 399
            Width = 935
            Height = 143
            Align = alClient
            TabOrder = 3
            SkinData.SkinSection = 'PANEL'
            object Panel9: TsPanel
              Left = 425
              Top = 1
              Width = 509
              Height = 141
              Align = alClient
              TabOrder = 0
              SkinData.SkinSection = 'PANEL'
              object Panel10: TsPanel
                Left = 1
                Top = 1
                Width = 507
                Height = 33
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                OnDblClick = Panel10DblClick
                SkinData.SkinSection = 'PANEL'
                object cxButton6: TsButton
                  Left = 5
                  Top = 3
                  Width = 76
                  Height = 25
                  Caption = 'Refresh'
                  TabOrder = 0
                  OnClick = cxButton6Click
                  SkinData.SkinSection = 'BUTTON'
                end
              end
              object memImportData: TsMemo
                Left = 1
                Top = 34
                Width = 507
                Height = 106
                Align = alClient
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ScrollBars = ssBoth
                TabOrder = 1
                WordWrap = False
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
                SkinData.SkinSection = 'EDIT'
              end
            end
            object cxSplitter2: TcxSplitter
              Left = 417
              Top = 1
              Width = 8
              Height = 141
              HotZoneClassName = 'TcxMediaPlayer9Style'
              Control = Panel11
            end
            object Panel11: TsPanel
              Left = 1
              Top = 1
              Width = 416
              Height = 141
              Align = alLeft
              TabOrder = 2
              SkinData.SkinSection = 'PANEL'
              object Panel12: TsPanel
                Left = 1
                Top = 1
                Width = 414
                Height = 26
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                SkinData.SkinSection = 'PANEL'
              end
              object cxDBMemo1: TcxDBMemo
                Left = 1
                Top = 27
                Align = alClient
                DataBinding.DataField = 'ImportData'
                DataBinding.DataSource = ImportLogsDS
                ParentFont = False
                Properties.ScrollBars = ssBoth
                Properties.WordWrap = False
                Style.Font.Charset = ANSI_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -13
                Style.Font.Name = 'Courier New'
                Style.Font.Style = []
                Style.LookAndFeel.NativeStyle = False
                Style.IsFontAssigned = True
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.NativeStyle = False
                TabOrder = 1
                Height = 113
                Width = 414
              end
            end
          end
        end
      end
    end
    object tabCurrentGuests: TsTabSheet
      Caption = 'In house'
      ImageIndex = 3
      object Panel2: TsPanel
        Left = 0
        Top = 0
        Width = 939
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnGetCurrentGuestsRefresh: TsButton
          Left = 526
          Top = 1
          Width = 100
          Height = 26
          Caption = 'Refresh'
          ImageIndex = 28
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnGetCurrentGuestsRefreshClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnRrToExcel: TsButton
          Left = 2
          Top = 1
          Width = 100
          Height = 26
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnRrToExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnRrShowReservation: TsButton
          Left = 107
          Top = 1
          Width = 100
          Height = 26
          Caption = 'Reservaton'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = btnRrShowReservationClick
          SkinData.SkinSection = 'BUTTON'
        end
        object cxButton4: TsButton
          Left = 210
          Top = 2
          Width = 100
          Height = 26
          Caption = 'Guests'
          ImageIndex = 39
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = cxButton4Click
          SkinData.SkinSection = 'BUTTON'
        end
        object cxButton2: TsButton
          Left = 316
          Top = 2
          Width = 100
          Height = 26
          Caption = 'Invoices'
          DropDownMenu = mnuFinishedInv
          Images = DImages.PngImageList1
          TabOrder = 4
          SkinData.SkinSection = 'BUTTON'
        end
        object cxButton1: TsButton
          Left = 421
          Top = 2
          Width = 100
          Height = 26
          Caption = 'Reservation Notes'
          ImageIndex = 0
          Images = DImages.PngImageList1
          TabOrder = 5
          OnClick = cxButton1Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object gridCurrentGuests: TcxGrid
        Left = 0
        Top = 33
        Width = 939
        Height = 542
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object gridCurrentGuestsDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          Navigator.Visible = True
          DataController.DataSource = mCurrentGuestsDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Indicator = True
          object gridCurrentGuestsDBTableView1RecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object gridCurrentGuestsDBTableView1Room: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
            Width = 52
          end
          object gridCurrentGuestsDBTableView1RoomDescription: TcxGridDBColumn
            Caption = '-'
            DataBinding.FieldName = 'RoomDescription'
            Width = 121
          end
          object gridCurrentGuestsDBTableView1RoomType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'RoomType'
            Width = 47
          end
          object gridCurrentGuestsDBTableView1RoomTypeDescription: TcxGridDBColumn
            Caption = '-'
            DataBinding.FieldName = 'RoomTypeDescription'
            Width = 143
          end
          object gridCurrentGuestsDBTableView1location: TcxGridDBColumn
            Caption = 'Location'
            DataBinding.FieldName = 'location'
            Width = 77
          end
          object gridCurrentGuestsDBTableView1Floor: TcxGridDBColumn
            DataBinding.FieldName = 'Floor'
          end
          object gridCurrentGuestsDBTableView1GuestName: TcxGridDBColumn
            Caption = 'Guest Name'
            DataBinding.FieldName = 'GuestName'
            Width = 155
          end
          object gridCurrentGuestsDBTableView1GuestCountry: TcxGridDBColumn
            Caption = 'Country'
            DataBinding.FieldName = 'GuestCountry'
            Width = 99
          end
          object gridCurrentGuestsDBTableView1Arrival: TcxGridDBColumn
            DataBinding.FieldName = 'Arrival'
          end
          object gridCurrentGuestsDBTableView1Departure: TcxGridDBColumn
            DataBinding.FieldName = 'Departure'
          end
          object gridCurrentGuestsDBTableView1StatusText: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'StatusText'
            Width = 167
          end
          object gridCurrentGuestsDBTableView1NightsTotal: TcxGridDBColumn
            Caption = 'Nights'
            DataBinding.FieldName = 'NightsTotal'
          end
          object gridCurrentGuestsDBTableView1NightsFromArrival: TcxGridDBColumn
            Caption = 'From Arrival'
            DataBinding.FieldName = 'NightsFromArrival'
          end
          object gridCurrentGuestsDBTableView1NightsUntilDeparture: TcxGridDBColumn
            Caption = 'Until Departure'
            DataBinding.FieldName = 'NightsUntilDeparture'
          end
          object gridCurrentGuestsDBTableView1GuestCount: TcxGridDBColumn
            Caption = 'Guests'
            DataBinding.FieldName = 'GuestCount'
            Width = 55
          end
          object gridCurrentGuestsDBTableView1isMainGuest: TcxGridDBColumn
            Caption = 'Main'
            DataBinding.FieldName = 'isMainGuest'
          end
          object gridCurrentGuestsDBTableView1Customer: TcxGridDBColumn
            DataBinding.FieldName = 'Customer'
            Width = 99
          end
          object gridCurrentGuestsDBTableView1CustomerName: TcxGridDBColumn
            Caption = 'Customer Name'
            DataBinding.FieldName = 'CustomerName'
            Width = 159
          end
          object gridCurrentGuestsDBTableView1customerPID: TcxGridDBColumn
            Caption = 'Personal ID'
            DataBinding.FieldName = 'customerPID'
          end
          object gridCurrentGuestsDBTableView1ReservationName: TcxGridDBColumn
            Caption = 'Reservation Text'
            DataBinding.FieldName = 'ReservationName'
            Width = 175
          end
          object gridCurrentGuestsDBTableView1RoomReservation: TcxGridDBColumn
            Caption = 'RR'
            DataBinding.FieldName = 'RoomReservation'
          end
          object gridCurrentGuestsDBTableView1Reservation: TcxGridDBColumn
            Caption = 'RV'
            DataBinding.FieldName = 'Reservation'
          end
          object gridCurrentGuestsDBTableView1Groupaccount: TcxGridDBColumn
            Caption = 'GA'
            DataBinding.FieldName = 'Groupaccount'
          end
          object gridCurrentGuestsDBTableView1breakfast: TcxGridDBColumn
            Caption = 'BF'
            DataBinding.FieldName = 'breakfast'
          end
        end
        object gridCurrentGuestsLevel1: TcxGridLevel
          GridView = gridCurrentGuestsDBTableView1
        end
      end
    end
  end
  object mCurrentGuestsDS: TDataSource
    DataSet = mCurrentGuests_
    Left = 300
    Top = 180
  end
  object mCurrentGuests_: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 88
    Top = 320
    object mCurrentGuests_Room: TStringField
      FieldName = 'Room'
      Size = 10
    end
    object mCurrentGuests_RoomDescription: TStringField
      FieldName = 'RoomDescription'
      Size = 50
    end
    object mCurrentGuests_RoomType: TStringField
      FieldName = 'RoomType'
      Size = 10
    end
    object mCurrentGuests_RoomTypeDescription: TStringField
      FieldName = 'RoomTypeDescription'
      Size = 30
    end
    object mCurrentGuests_location: TStringField
      FieldName = 'location'
      Size = 35
    end
    object mCurrentGuests_Floor: TIntegerField
      FieldName = 'Floor'
    end
    object mCurrentGuests_StatusText: TStringField
      FieldName = 'StatusText'
      Size = 50
    end
    object mCurrentGuests_GuestName: TStringField
      FieldName = 'GuestName'
      Size = 70
    end
    object mCurrentGuests_GuestCountry: TStringField
      FieldName = 'GuestCountry'
    end
    object mCurrentGuests_Arrival: TDateField
      FieldName = 'Arrival'
    end
    object mCurrentGuests_Departure: TDateField
      FieldName = 'Departure'
    end
    object mCurrentGuests_isMainGuest: TBooleanField
      FieldName = 'isMainGuest'
    end
    object mCurrentGuests_Customer: TStringField
      FieldName = 'Customer'
    end
    object mCurrentGuests_CustomerName: TStringField
      FieldName = 'CustomerName'
      Size = 50
    end
    object mCurrentGuests_ReservationName: TStringField
      FieldName = 'ReservationName'
      Size = 50
    end
    object mCurrentGuests_RoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mCurrentGuests_Reservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mCurrentGuests_customerPID: TStringField
      FieldName = 'customerPID'
      Size = 15
    end
    object mCurrentGuests_GuestCount: TIntegerField
      FieldName = 'GuestCount'
    end
    object mCurrentGuests_NightsTotal: TIntegerField
      FieldName = 'NightsTotal'
    end
    object mCurrentGuests_NightsFromArrival: TIntegerField
      FieldName = 'NightsFromArrival'
    end
    object mCurrentGuests_NightsUntilDeparture: TIntegerField
      FieldName = 'NightsUntilDeparture'
    end
    object mCurrentGuests_Groupaccount: TBooleanField
      FieldName = 'Groupaccount'
    end
    object mCurrentGuests_breakfast: TBooleanField
      FieldName = 'breakfast'
    end
  end
  object mnuFinishedInv: TPopupMenu
    Left = 296
    Top = 312
    object mnuThisRoom: TMenuItem
      Caption = 'Closed this Room'
      OnClick = mnuThisRoomClick
    end
    object mnuThisreservation: TMenuItem
      Caption = 'Closed this reservation'
      OnClick = mnuThisreservationClick
    end
    object OpenthisRoom1: TMenuItem
      Caption = 'Open this Room'
      OnClick = OpenthisRoom1Click
    end
    object OpenGroupInvoice1: TMenuItem
      Caption = 'Open Group Invoice'
      OnClick = OpenGroupInvoice1Click
    end
  end
  object InportLogsDS_: TDataSource
    Left = 96
    Top = 224
  end
  object ImportLogsDS: TDataSource
    DataSet = mImportLog
    Left = 264
    Top = 248
  end
  object mImportLog: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterScroll = mImportLogAfterScroll
    Left = 152
    Top = 280
    object mImportLogID: TIntegerField
      FieldName = 'ID'
    end
    object mImportLogDateInsert: TDateTimeField
      FieldName = 'DateInsert'
      DisplayFormat = 'dd.mm.yyyy hh:nn'
    end
    object mImportLogDateExport: TDateTimeField
      FieldName = 'DateExport'
    end
    object mImportLogImportTypeID: TIntegerField
      FieldName = 'ImportTypeID'
    end
    object mImportLogImportType: TStringField
      FieldKind = fkLookup
      FieldName = 'ImportType'
      LookupDataSet = d.memImportTypes
      LookupKeyFields = 'ID'
      LookupResultField = 'Description'
      KeyFields = 'ImportTypeID'
      Size = 30
      Lookup = True
    end
    object mImportLogImportData: TMemoField
      FieldName = 'ImportData'
      BlobType = ftMemo
    end
    object mImportLogImportResultId: TIntegerField
      FieldName = 'ImportResultId'
    end
    object mImportLogReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mImportLogRoomreservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mImportLogCustomer: TStringField
      FieldName = 'Customer'
    end
    object mImportLogItemcount: TIntegerField
      FieldName = 'ItemCount'
    end
    object mImportLogHotelCode: TStringField
      FieldName = 'HotelCode'
      Size = 5
    end
    object mImportLogStaff: TStringField
      FieldName = 'Staff'
      Size = 15
    end
    object mImportLogRoomNumber: TStringField
      FieldName = 'RoomNumber'
      Size = 15
    end
    object mImportLogisGroupInvoice: TBooleanField
      FieldName = 'isGroupInvoice'
    end
    object mImportLoginvCustomer: TStringField
      DisplayWidth = 20
      FieldName = 'invCustomer'
      Size = 50
    end
    object mImportLoginvPersonalID: TStringField
      FieldName = 'invPersonalID'
    end
    object mImportLoginvCustomerName: TStringField
      FieldName = 'invCustomerName'
      Size = 50
    end
    object mImportLogInvAddress1: TStringField
      FieldName = 'InvAddress1'
      Size = 50
    end
    object mImportLoginvAddress2: TStringField
      FieldName = 'invAddress2'
      Size = 50
    end
    object mImportLoginvAddress3: TStringField
      FieldName = 'invAddress3'
      Size = 50
    end
    object mImportLoginvAddress4: TStringField
      FieldName = 'invAddress4'
      Size = 50
    end
    object mImportLogGuestName: TStringField
      FieldName = 'GuestName'
      Size = 50
    end
    object mImportLogSaleRefrence: TStringField
      FieldName = 'SaleRefrence'
    end
    object mImportLogImportResult: TStringField
      FieldKind = fkLookup
      FieldName = 'ImportResult'
      LookupDataSet = d.memImportResults
      LookupKeyFields = 'ID'
      LookupResultField = 'Description'
      KeyFields = 'ImportResultId'
      Size = 30
      Lookup = True
    end
    object mImportLoginvoiceNumber: TIntegerField
      FieldName = 'invoiceNumber'
    end
  end
  object memImportTypesDS: TDataSource
    DataSet = d.memImportTypes
    Left = 104
    Top = 448
  end
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 192
    Top = 176
    object m_RoomType: TStringField
      FieldName = 'RoomType'
      Size = 10
    end
    object m_aDate: TDateTimeField
      FieldName = 'aDate'
    end
    object m_RoomTypeGroup: TStringField
      FieldName = 'RoomTypeGroup'
    end
    object m_MaxFree: TIntegerField
      FieldName = 'MaxFree'
    end
    object m_occTotal: TIntegerField
      FieldName = 'occTotal'
    end
    object m_occDeparted: TIntegerField
      FieldName = 'occDeparted'
    end
    object m_occGuest: TIntegerField
      FieldName = 'occGuest'
    end
    object m_occOrder: TIntegerField
      FieldName = 'occOrder'
    end
    object m_occAllotment: TIntegerField
      FieldName = 'occAllotment'
    end
    object m_occWaitinglist: TIntegerField
      FieldName = 'occWaitinglist'
    end
    object m_occNoShow: TIntegerField
      FieldName = 'occNoShow'
    end
    object m_occBlocked: TIntegerField
      FieldName = 'occBlocked'
    end
    object m_nrTotal: TIntegerField
      FieldName = 'nrTotal'
    end
    object m_nrDeparted: TIntegerField
      FieldName = 'nrDeparted'
    end
    object m_nrGuest: TIntegerField
      FieldName = 'nrGuest'
    end
    object m_nrOrder: TIntegerField
      FieldName = 'nrOrder'
    end
    object m_nrAllotment: TIntegerField
      FieldName = 'nrAllotment'
    end
    object m_nrWaitingList: TIntegerField
      FieldName = 'nrWaitingList'
    end
    object m_nrNoShow: TIntegerField
      FieldName = 'nrNoShow'
    end
    object m_nrBlocked: TIntegerField
      FieldName = 'nrBlocked'
    end
    object m_FreeRooms: TIntegerField
      FieldName = 'FreeRooms'
    end
  end
  object mDS: TDataSource
    DataSet = m_
    Left = 236
    Top = 173
  end
  object RoomStatusDS: TDataSource
    DataSet = mRoomStatus
    Left = 608
    Top = 232
  end
  object mRoomStatus: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    AfterScroll = mImportLogAfterScroll
    Left = 264
    Top = 376
    object mRoomStatusresDate: TDateTimeField
      FieldName = 'resDate'
    end
    object mRoomStatusRoomType: TStringField
      FieldName = 'RoomType'
      Size = 10
    end
    object mRoomStatusDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
    object mRoomStatusNumberGuests: TIntegerField
      FieldName = 'NumberGuests'
    end
    object mRoomStatusRoomTypeGroup: TStringField
      FieldName = 'RoomTypeGroup'
    end
    object mRoomStatusavailable: TIntegerField
      FieldName = 'available'
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
    StorageName = 'Software\Roomer\FormStatus\DayNotes'
    StorageType = stRegistry
    Left = 710
    Top = 152
  end
end
