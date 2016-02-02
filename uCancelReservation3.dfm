object frmCancelReservation3: TfrmCancelReservation3
  Left = 8
  Top = 8
  Caption = 'Remove reservation  - all rooms'
  ClientHeight = 510
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TsPanel
    Left = 0
    Top = 0
    Width = 502
    Height = 185
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 542
    object cxGroupBox1: TsGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 63
      Width = 490
      Height = 116
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Caption = 'Reason details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      ExplicitWidth = 530
      object memReason: TsMemo
        AlignWithMargins = True
        Left = 8
        Top = 21
        Width = 474
        Height = 87
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        SkinData.SkinSection = 'EDIT'
        ExplicitWidth = 514
      end
    end
    object cxGroupBox2: TsGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 490
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Reason'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      ExplicitWidth = 530
      DesignSize = (
        490
        45)
      object cbxReason: TsComboBox
        Left = 8
        Top = 19
        Width = 474
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Alignment = taLeftJustify
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        SkinData.SkinSection = 'COMBOBOX'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 0
        Text = 'cbxReason'
        Items.Strings = (
          'Not identified'
          'Decision of employee'
          'Customer cancelled booking with sufficient notice'
          'Customer failed to cancel booking with sufficient notice'
          'Channel Modification')
        ExplicitWidth = 514
      end
    end
  end
  object panBottom: TsPanel
    Left = 0
    Top = 390
    Width = 502
    Height = 87
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = 411
    ExplicitWidth = 542
    DesignSize = (
      502
      87)
    object cxLabel2: TsLabel
      Left = 14
      Top = 42
      Width = 98
      Height = 17
      AutoSize = False
      Caption = 'Customer : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labCustomerInfo: TsLabel
      Left = 116
      Top = 43
      Width = 379
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = '-'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitWidth = 419
    end
    object labRoomInfo: TsLabel
      Left = 0
      Top = 0
      Width = 502
      Height = 35
      Align = alTop
      AutoSize = False
      Caption = 'labRoomInfo'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitWidth = 542
    end
  end
  object Panel2: TsPanel
    Left = 0
    Top = 185
    Width = 502
    Height = 205
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 542
    ExplicitHeight = 226
    object gRooms: TcxGrid
      Left = 1
      Top = 34
      Width = 500
      Height = 170
      Align = alClient
      TabOrder = 0
      LookAndFeel.NativeStyle = False
      ExplicitTop = 33
      ExplicitWidth = 540
      ExplicitHeight = 192
      object tvRooms: TcxGridDBTableView
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
        DataController.DataSource = mRoomsDS
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvRoomsSelect: TcxGridDBColumn
          DataBinding.FieldName = 'Select'
          Visible = False
        end
        object tvRoomsRecId: TcxGridDBColumn
          DataBinding.FieldName = 'RecId'
          Visible = False
          Options.Editing = False
        end
        object tvRoomsRoom: TcxGridDBColumn
          DataBinding.FieldName = 'Room'
          Options.Editing = False
          Width = 66
        end
        object tvRoomsRoomType: TcxGridDBColumn
          DataBinding.FieldName = 'RoomType'
          Options.Editing = False
          Width = 83
        end
        object tvRoomsGuests: TcxGridDBColumn
          DataBinding.FieldName = 'Guests'
          Options.Editing = False
          Width = 269
        end
        object tvRoomsArrival: TcxGridDBColumn
          DataBinding.FieldName = 'Arrival'
          Options.Editing = False
          Width = 81
        end
        object tvRoomsDeparture: TcxGridDBColumn
          DataBinding.FieldName = 'Departure'
          Options.Editing = False
          Width = 76
        end
        object tvRoomsStatus: TcxGridDBColumn
          DataBinding.FieldName = 'Status'
          Options.Editing = False
          Width = 118
        end
      end
      object lvRooms: TcxGridLevel
        GridView = tvRooms
      end
    end
    object panSelect: TsPanel
      Left = 1
      Top = 1
      Width = 500
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      ExplicitWidth = 540
      object cxButton1: TsButton
        Left = 171
        Top = 4
        Width = 160
        Height = 25
        Caption = 'Select all'
        ImageIndex = 75
        Images = DImages.PngImageList1
        TabOrder = 0
        Visible = False
        OnClick = cxButton1Click
        SkinData.SkinSection = 'BUTTON'
      end
      object cxButton3: TsButton
        Left = 335
        Top = 4
        Width = 160
        Height = 25
        Caption = 'Deselect all'
        ImageIndex = 86
        Images = DImages.PngImageList1
        TabOrder = 1
        Visible = False
        OnClick = cxButton3Click
        SkinData.SkinSection = 'BUTTON'
      end
      object cxButton4: TsButton
        Left = 7
        Top = 4
        Width = 160
        Height = 25
        Caption = 'Select rooms to delete'
        ImageIndex = 83
        Images = DImages.PngImageList1
        TabOrder = 2
        OnClick = cxButton4Click
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 477
    Width = 502
    Height = 33
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = 498
    ExplicitWidth = 542
    DesignSize = (
      502
      33)
    object btnOK: TBitBtn
      Left = 356
      Top = 4
      Width = 70
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 429
      Top = 4
      Width = 70
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object mRooms: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterEdit = mRoomsAfterEdit
    Left = 160
    Top = 328
    object mRoomsRoom: TWideStringField
      FieldName = 'Room'
    end
    object mRoomsRoomType: TWideStringField
      FieldName = 'RoomType'
    end
    object mRoomsGuests: TWideStringField
      FieldName = 'Guests'
      Size = 200
    end
    object mRoomsArrival: TDateTimeField
      FieldName = 'Arrival'
    end
    object mRoomsDeparture: TDateTimeField
      FieldName = 'Departure'
    end
    object mRoomsStatus: TWideStringField
      FieldName = 'Status'
    end
    object mRoomsSelect: TBooleanField
      FieldName = 'Select'
    end
    object mRoomsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
  end
  object mRoomsDS: TDataSource
    DataSet = mRooms
    Left = 240
    Top = 313
  end
end
