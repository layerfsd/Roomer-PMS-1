object frmCancelReservation2: TfrmCancelReservation2
  Left = 968
  Top = 296
  Caption = 'Remove Room from Reservation'
  ClientHeight = 397
  ClientWidth = 563
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
    Width = 563
    Height = 247
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 7
      Top = 64
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Caption = 'Reason details'
      ParentFont = False
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 0
      Height = 176
      Width = 549
      object memReason: TcxMemo
        AlignWithMargins = True
        Left = 8
        Top = 24
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        ParentFont = False
        Properties.ScrollBars = ssVertical
        Style.Color = clInfoBk
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 0
        ExplicitLeft = 9
        ExplicitTop = 22
        ExplicitWidth = 531
        ExplicitHeight = 142
        Height = 144
        Width = 533
      end
    end
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 7
      Top = 7
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Reason'
      ParentFont = False
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 1
      DesignSize = (
        549
        45)
      Height = 45
      Width = 549
      object cbxReason: TcxComboBox
        Left = 17
        Top = 17
        Anchors = [akLeft, akTop, akRight]
        ParentFont = False
        Properties.Items.Strings = (
          'Ekki skilgreint'
          'Employees decision'
          'Customer cancelled with sufficient notice'
          'Customer did not cancel with sufficient notice')
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 0
        Text = 'cbxReason'
        Width = 529
      end
    end
  end
  object panBottom: TsPanel
    Left = 0
    Top = 247
    Width = 563
    Height = 117
    Align = alBottom
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      563
      117)
    object cxLabel1: TsLabel
      Left = 14
      Top = 2
      Width = 98
      Height = 17
      AutoSize = False
      Caption = 'Room : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxLabel2: TsLabel
      Left = 14
      Top = 19
      Width = 98
      Height = 17
      AutoSize = False
      Caption = 'Customer : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxLabel3: TsLabel
      Left = 14
      Top = 53
      Width = 98
      Height = 17
      AutoSize = False
      Caption = 'Arrival/departure : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxLabel4: TsLabel
      Left = 14
      Top = 36
      Width = 98
      Height = 18
      AutoSize = False
      Caption = 'Guests : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labRoomInfo: TsLabel
      Left = 112
      Top = 2
      Width = 444
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = '-'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object labCustomerInfo: TsLabel
      Left = 112
      Top = 19
      Width = 444
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = '-'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object labGuestInfo: TsLabel
      Left = 112
      Top = 36
      Width = 444
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = '-'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object labdateInfo: TsLabel
      Left = 112
      Top = 53
      Width = 444
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = '-'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxLabel5: TsLabel
      Left = 14
      Top = 70
      Width = 98
      Height = 17
      AutoSize = False
      Caption = 'Status : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labResStatus: TsLabel
      Left = 112
      Top = 70
      Width = 444
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = '-'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 364
    Width = 563
    Height = 33
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    OnClick = btnOKClick
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      563
      33)
    object BitBtn1: TBitBtn
      Left = 412
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
    end
    object btnCancel: TBitBtn
      Left = 486
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
    Left = 208
    Top = 176
  end
  object ADODataSet1: TRoomerDataSet
    CommandText = ''
    CommandType = cmdUnknown
    Parameters = <>
    DataActive = False
    RoomerStoreUri = 'http://localhost:8080/services/'
    RoomerUri = 'http://localhost:8080/services/'
    RoomerEntitiesUri = 'http://localhost:8080/services/entities/'
    RoomerDatasetsUri = 'http://localhost:8080/services/datasets/'
    SessionLengthSeconds = 0
    Left = 119
    Top = 128
  end
end
