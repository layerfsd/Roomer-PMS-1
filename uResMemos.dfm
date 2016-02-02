object frmResMemos: TfrmResMemos
  Left = 0
  Top = 0
  Caption = 'Reservation Memos'
  ClientHeight = 536
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TsPanel
    Left = 0
    Top = 0
    Width = 719
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object cxLabel1: TsLabel
      Left = 7
      Top = 8
      Width = 83
      Height = 17
      AutoSize = False
      Caption = 'Arrival :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxLabel2: TsLabel
      Left = 7
      Top = 25
      Width = 83
      Height = 17
      AutoSize = False
      Caption = 'Departure :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxLabel4: TsLabel
      Left = 337
      Top = 8
      Width = 80
      Height = 17
      AutoSize = False
      Caption = 'Customer :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxLabel5: TsLabel
      Left = 337
      Top = 25
      Width = 80
      Height = 17
      AutoSize = False
      Caption = 'Reservation :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labArrival: TsLabel
      Left = 96
      Top = 8
      Width = 234
      Height = 17
      AutoSize = False
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labDeparture: TsLabel
      Left = 96
      Top = 25
      Width = 234
      Height = 17
      AutoSize = False
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labCustomer: TsLabel
      Left = 423
      Top = 8
      Width = 254
      Height = 17
      AutoSize = False
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labReservation: TsLabel
      Left = 423
      Top = 25
      Width = 254
      Height = 17
      AutoSize = False
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnShowHidden: TsButton
      Left = 4
      Top = 48
      Width = 282
      Height = 25
      Caption = 'Show Hidden Information (password required)'
      TabOrder = 0
      OnClick = btnShowHiddenClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object cxPageControl1: TsPageControl
    Left = 0
    Top = 81
    Width = 719
    Height = 422
    ActivePage = tabReservation
    Align = alClient
    TabOrder = 1
    SkinData.SkinSection = 'PAGECONTROL'
    ExplicitTop = 49
    ExplicitHeight = 454
    object tabReservation: TsTabSheet
      Caption = 'Resevation'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 426
      object Panel4: TsPanel
        Left = 345
        Top = 0
        Width = 366
        Height = 394
        Align = alClient
        BevelOuter = bvNone
        Padding.Left = 8
        Padding.Top = 4
        Padding.Right = 8
        Padding.Bottom = 4
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        ExplicitHeight = 426
        object Panel5: TsPanel
          Left = 8
          Top = 4
          Width = 350
          Height = 49
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
          object cxLabel6: TsLabel
            Left = 0
            Top = 0
            Width = 350
            Height = 18
            Margins.Top = 0
            Align = alTop
            AutoSize = False
            Caption = 'Reservation Notes - Payment'
            Color = clBtnFace
            ParentColor = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ExplicitWidth = 354
          end
          object cxButton4: TsButton
            Left = 5
            Top = 17
            Width = 140
            Height = 25
            Caption = 'Move Selection to hidden'
            TabOrder = 1
            OnClick = cxButton4Click
            SkinData.SkinSection = 'BUTTON'
          end
          object cxButton7: TsButton
            Left = 151
            Top = 17
            Width = 138
            Height = 25
            Caption = 'Clipboard to hidden'
            TabOrder = 0
            OnClick = cxButton6Click
            SkinData.SkinSection = 'BUTTON'
          end
        end
        object memPMInfo: TDBMemo
          Left = 8
          Top = 53
          Width = 350
          Height = 337
          Align = alClient
          DataSource = resDS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ExplicitHeight = 369
        end
      end
      object Panel2: TsPanel
        Left = 0
        Top = 0
        Width = 337
        Height = 394
        Align = alLeft
        BevelOuter = bvNone
        Padding.Left = 8
        Padding.Top = 4
        Padding.Right = 8
        Padding.Bottom = 4
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        ExplicitHeight = 426
        object Panel3: TsPanel
          Left = 8
          Top = 4
          Width = 321
          Height = 49
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
          object cxLabel3: TsLabel
            Left = 0
            Top = 0
            Width = 321
            Height = 18
            Margins.Top = 0
            Align = alTop
            AutoSize = False
            Caption = 'Reservation Notes - General'
            Color = clBtnFace
            ParentColor = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
          end
          object cxButton3: TsButton
            Left = 5
            Top = 17
            Width = 140
            Height = 25
            Caption = 'Move Selection to hidden'
            TabOrder = 0
            OnClick = cxButton3Click
            SkinData.SkinSection = 'BUTTON'
          end
          object cxButton6: TsButton
            Left = 151
            Top = 17
            Width = 139
            Height = 25
            Caption = 'Clipboard to hidden'
            TabOrder = 1
            OnClick = cxButton6Click
            SkinData.SkinSection = 'BUTTON'
          end
        end
        object memInformation: TDBMemo
          Left = 8
          Top = 53
          Width = 321
          Height = 337
          Align = alClient
          DataSource = resDS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ExplicitHeight = 369
        end
      end
      object cxSplitter1: TcxSplitter
        Left = 337
        Top = 0
        Width = 8
        Height = 394
        HotZoneClassName = 'TcxMediaPlayer9Style'
        Control = Panel2
        ExplicitHeight = 426
      end
    end
    object tabRooms: TsTabSheet
      Caption = 'Rooms'
      ImageIndex = 1
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 426
      object Panel7: TsPanel
        Left = 0
        Top = 0
        Width = 345
        Height = 394
        Align = alLeft
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        ExplicitHeight = 426
        object cxGrid1: TcxGrid
          Left = 1
          Top = 1
          Width = 343
          Height = 392
          Align = alClient
          TabOrder = 0
          LookAndFeel.NativeStyle = False
          ExplicitHeight = 424
          object cxGrid1DBTableView1: TcxGridDBTableView
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
            FilterBox.Visible = fvNever
            DataController.DataSource = mRRDS
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnGrouping = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object cxGrid1DBTableView1RecId: TcxGridDBColumn
              DataBinding.FieldName = 'RecId'
              Visible = False
            end
            object cxGrid1DBTableView1Room: TcxGridDBColumn
              DataBinding.FieldName = 'Room'
              Width = 46
            end
            object cxGrid1DBTableView1RoomType: TcxGridDBColumn
              Caption = 'Type'
              DataBinding.FieldName = 'RoomType'
              Width = 57
            end
            object cxGrid1DBTableView1GuestName: TcxGridDBColumn
              Caption = 'Guest'
              DataBinding.FieldName = 'GuestName'
              Width = 167
            end
            object cxGrid1DBTableView1Arrival: TcxGridDBColumn
              DataBinding.FieldName = 'Arrival'
            end
            object cxGrid1DBTableView1Departure: TcxGridDBColumn
              DataBinding.FieldName = 'Departure'
            end
            object cxGrid1DBTableView1RoomReservation: TcxGridDBColumn
              Caption = 'RR Reference'
              DataBinding.FieldName = 'RoomReservation'
            end
            object cxGrid1DBTableView1mem: TcxGridDBColumn
              Caption = 'Notes'
              DataBinding.FieldName = 'mem'
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
      object cxSplitter2: TcxSplitter
        Left = 345
        Top = 0
        Width = 8
        Height = 394
        HotZoneClassName = 'TcxMediaPlayer8Style'
        NativeBackground = False
        Control = Panel7
        ExplicitHeight = 426
      end
      object Panel8: TsPanel
        Left = 353
        Top = 0
        Width = 358
        Height = 394
        Align = alClient
        TabOrder = 2
        SkinData.SkinSection = 'PANEL'
        ExplicitHeight = 426
        object Panel9: TsPanel
          Left = 1
          Top = 1
          Width = 356
          Height = 54
          Align = alTop
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
          object cxLabel7: TsLabel
            Left = 1
            Top = 1
            Width = 354
            Height = 18
            Margins.Top = 0
            Align = alTop
            AutoSize = False
            Caption = 'Room Notes'
            Color = clBtnFace
            ParentColor = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ExplicitWidth = 361
          end
          object cxButton5: TsButton
            Left = 3
            Top = 24
            Width = 139
            Height = 25
            Caption = 'Move Selection to hidden'
            TabOrder = 0
            OnClick = cxButton3Click
            SkinData.SkinSection = 'BUTTON'
          end
        end
        object cxDBMemo1: TDBMemo
          Left = 1
          Top = 55
          Width = 356
          Height = 338
          Align = alClient
          DataField = 'mem'
          DataSource = mRRDS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ExplicitHeight = 370
        end
      end
    end
  end
  object Panel6: TsPanel
    Left = 0
    Top = 503
    Width = 719
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object cxButton1: TsButton
      Left = 515
      Top = 4
      Width = 100
      Height = 25
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = cxButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object cxButton2: TsButton
      Left = 617
      Top = 4
      Width = 100
      Height = 25
      Caption = 'Cancel'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      OnClick = cxButton2Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object resDS: TDataSource
    DataSet = res_
    Left = 584
    Top = 56
  end
  object res_: TRoomerDataSet
    Connection = d.qConnection
    CursorType = ctStatic
    CommandText = 'Select * FROM Reservations'#13#10
    CommandType = cmdUnknown
    Parameters = <>
    Sql.Strings = (
      'Select * FROM Reservations')
    DataActive = False
    RoomerStoreUri = 'http://localhost:8080/services/'
    RoomerUri = 'http://localhost:8080/services/'
    RoomerEntitiesUri = 'http://localhost:8080/services/entities/'
    RoomerDatasetsUri = 'http://localhost:8080/services/datasets/'
    SessionLengthSeconds = 0
    Left = 592
    Top = 144
  end
  object RrDS: TDataSource
    DataSet = RR_
    Left = 560
    Top = 192
  end
  object RR_: TRoomerDataSet
    Connection = d.qConnection
    CursorType = ctStatic
    CommandText = 'SELECT TOP 20 * FROM Roomreservations'#13#10
    CommandType = cmdUnknown
    Parameters = <>
    Sql.Strings = (
      'SELECT TOP 20 * FROM Roomreservations')
    DataActive = False
    RoomerStoreUri = 'http://localhost:8080/services/'
    RoomerUri = 'http://localhost:8080/services/'
    RoomerEntitiesUri = 'http://localhost:8080/services/entities/'
    RoomerDatasetsUri = 'http://localhost:8080/services/datasets/'
    SessionLengthSeconds = 0
    Left = 552
    Top = 256
  end
  object mRR: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 448
    Top = 200
    object mRRRoom: TStringField
      FieldName = 'Room'
      Size = 10
    end
    object mRRArrival: TDateField
      FieldName = 'Arrival'
    end
    object mRRDeparture: TDateField
      FieldName = 'Departure'
    end
    object mRRGuestName: TStringField
      FieldName = 'GuestName'
      Size = 70
    end
    object mRRRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mRRmem: TMemoField
      FieldName = 'mem'
      BlobType = ftMemo
    end
    object mRRRoomType: TStringField
      FieldName = 'RoomType'
      Size = 10
    end
  end
  object mRRDS: TDataSource
    DataSet = mRR
    Left = 456
    Top = 256
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
    StorageName = 'Software\Roomer\FormStatus\ResMemos'
    StorageType = stRegistry
    Left = 510
    Top = 352
  end
end
