object frmResGuestList: TfrmResGuestList
  Left = 926
  Top = 215
  Caption = 'Bookings Guestlist'
  ClientHeight = 756
  ClientWidth = 1074
  Color = clBtnFace
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
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LMDStatusBar1: TStatusBar
    Left = 0
    Top = 737
    Width = 1074
    Height = 19
    Panels = <>
  end
  object LMDSimplePanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1074
    Height = 31
    Align = alTop
    Padding.Left = 5
    Padding.Top = 5
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object Label1: TsLabel
      Left = 6
      Top = 6
      Width = 106
      Height = 24
      Align = alLeft
      Alignment = taRightJustify
      Caption = 'Booking Number : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitHeight = 16
    end
    object Label16: TsLabel
      Left = 217
      Top = 6
      Width = 43
      Height = 24
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'arrive : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitLeft = 218
      ExplicitTop = -2
      ExplicitHeight = 29
    end
    object Label18: TsLabel
      Left = 353
      Top = 6
      Width = 50
      Height = 24
      Align = alLeft
      Alignment = taRightJustify
      Caption = 'depart : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitHeight = 16
    end
    object Label19: TsLabel
      Left = 496
      Top = 6
      Width = 101
      Height = 24
      Align = alLeft
      Alignment = taRightJustify
      Caption = 'date of booking : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitHeight = 16
    end
    object Label20: TsLabel
      Left = 690
      Top = 6
      Width = 92
      Height = 24
      Align = alLeft
      Alignment = taRightJustify
      Caption = 'Staff member : '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitHeight = 16
    end
    object edArrival: TsLabel
      Left = 260
      Top = 6
      Width = 93
      Height = 24
      Align = alLeft
      AutoSize = False
      Caption = '-'
      Color = clWhite
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitLeft = 264
      ExplicitTop = 8
      ExplicitHeight = 16
    end
    object edDeparture: TsLabel
      Left = 403
      Top = 6
      Width = 93
      Height = 24
      Align = alLeft
      AutoSize = False
      Caption = '-'
      Color = clWhite
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitLeft = 412
      ExplicitTop = 8
      ExplicitHeight = 16
    end
    object edReservationDate: TsLabel
      Left = 597
      Top = 6
      Width = 93
      Height = 24
      Align = alLeft
      AutoSize = False
      Caption = '-'
      Color = clWhite
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitLeft = 628
      ExplicitTop = 8
      ExplicitHeight = 16
    end
    object edStaff: TsLabel
      Left = 782
      Top = 6
      Width = 57
      Height = 24
      Align = alLeft
      AutoSize = False
      Caption = '-'
      Color = clWhite
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitLeft = 812
      ExplicitTop = 8
      ExplicitHeight = 16
    end
    object edReservation: TsLabel
      Left = 112
      Top = 6
      Width = 105
      Height = 24
      Align = alLeft
      AutoSize = False
      Caption = '-'
      Color = clWhite
      ParentColor = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitLeft = 107
      ExplicitTop = 1
      ExplicitHeight = 29
    end
  end
  object PageControl1: TsPageControl
    Left = 0
    Top = 312
    Width = 1074
    Height = 425
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PAGECONTROL'
    object TabSheet1: TsTabSheet
      Caption = 'Room Reservations'
      TabVisible = False
      object LMDSimplePanel2: TsPanel
        Left = 0
        Top = 0
        Width = 1066
        Height = 33
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          1066
          33)
        object btnRefresh: TsButton
          Left = 310
          Top = 0
          Width = 100
          Height = 27
          Caption = 'Refresh'
          ImageIndex = 28
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnRefreshClick
          SkinData.SkinSection = 'BUTTON'
        end
        object LMDSpeedButton3: TsButton
          Left = 5
          Top = 0
          Width = 100
          Height = 27
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = LMDSpeedButton3Click
          SkinData.SkinSection = 'BUTTON'
        end
        object LMDSpeedButton4: TsButton
          Left = 107
          Top = 0
          Width = 100
          Height = 27
          Caption = 'Print'
          ImageIndex = 3
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = LMDSpeedButton4Click
          SkinData.SkinSection = 'BUTTON'
        end
        object LMDSpeedButton5: TsButton
          Left = 209
          Top = 0
          Width = 100
          Height = 27
          Caption = 'Design'
          ImageIndex = 29
          Images = DImages.PngImageList1
          TabOrder = 4
          OnClick = LMDSpeedButton5Click
          SkinData.SkinSection = 'BUTTON'
        end
        object chkShowAllGuests: TsCheckBox
          Left = 419
          Top = 4
          Width = 102
          Height = 17
          Caption = 'Show all guests'
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnClick = chkShowAllGuestsClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object cxPageControl1: TcxPageControl
        Left = 0
        Top = 33
        Width = 1066
        Height = 382
        Align = alClient
        TabOrder = 1
        Properties.CustomButtons.Buttons = <>
        LookAndFeel.NativeStyle = False
        ClientRectBottom = 380
        ClientRectLeft = 2
        ClientRectRight = 1064
        ClientRectTop = 2
      end
      object cxGrid1: TcxGrid
        Left = 0
        Top = 33
        Width = 1066
        Height = 382
        Align = alClient
        TabOrder = 2
        LookAndFeel.NativeStyle = False
        object cxGrid1DBTableView1: TcxGridDBTableView
          OnDblClick = cxGrid1DBTableView1DblClick
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
          DataController.DataSource = DS_
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
          object cxGrid1DBTableView1Room: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
            Width = 72
          end
          object cxGrid1DBTableView1RoomType: TcxGridDBColumn
            DataBinding.FieldName = 'RoomType'
            Width = 87
          end
          object cxGrid1DBTableView1RoomTypeDescription: TcxGridDBColumn
            DataBinding.FieldName = 'RoomTypeDescription'
          end
          object cxGrid1DBTableView1GuestName: TcxGridDBColumn
            DataBinding.FieldName = 'GuestName'
            Width = 162
          end
          object cxGrid1DBTableView1Address1: TcxGridDBColumn
            DataBinding.FieldName = 'Address1'
            Width = 148
          end
          object cxGrid1DBTableView1Address2: TcxGridDBColumn
            DataBinding.FieldName = 'Address2'
            Width = 130
          end
          object cxGrid1DBTableView1Address3: TcxGridDBColumn
            DataBinding.FieldName = 'Address3'
          end
          object cxGrid1DBTableView1Country: TcxGridDBColumn
            DataBinding.FieldName = 'Country'
          end
          object cxGrid1DBTableView1CountryName: TcxGridDBColumn
            DataBinding.FieldName = 'CountryName'
          end
          object cxGrid1DBTableView1CountryGroup: TcxGridDBColumn
            DataBinding.FieldName = 'CountryGroup'
          end
          object cxGrid1DBTableView1GroupName: TcxGridDBColumn
            DataBinding.FieldName = 'GroupName'
          end
          object cxGrid1DBTableView1Arrival: TcxGridDBColumn
            DataBinding.FieldName = 'Arrival'
          end
          object cxGrid1DBTableView1Departure: TcxGridDBColumn
            DataBinding.FieldName = 'Departure'
          end
          object cxGrid1DBTableView1RoomStatus: TcxGridDBColumn
            DataBinding.FieldName = 'RoomStatus'
          end
          object cxGrid1DBTableView1StatusText: TcxGridDBColumn
            DataBinding.FieldName = 'StatusText'
          end
          object cxGrid1DBTableView1PersionalID: TcxGridDBColumn
            DataBinding.FieldName = 'PersionalID'
          end
          object cxGrid1DBTableView1Floor: TcxGridDBColumn
            DataBinding.FieldName = 'Floor'
          end
          object cxGrid1DBTableView1Location: TcxGridDBColumn
            DataBinding.FieldName = 'Location'
          end
          object cxGrid1DBTableView1LocationDescription: TcxGridDBColumn
            DataBinding.FieldName = 'LocationDescription'
          end
          object cxGrid1DBTableView1Information: TcxGridDBColumn
            DataBinding.FieldName = 'Information'
          end
          object cxGrid1DBTableView1isMainName: TcxGridDBColumn
            DataBinding.FieldName = 'isMainName'
          end
          object cxGrid1DBTableView1isNoRoom: TcxGridDBColumn
            DataBinding.FieldName = 'isNoRoom'
          end
          object cxGrid1DBTableView1Reservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
          end
          object cxGrid1DBTableView1GuestType: TcxGridDBColumn
            DataBinding.FieldName = 'GuestType'
          end
          object cxGrid1DBTableView1RoomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'RoomReservation'
          end
          object cxGrid1DBTableView1inStatistics: TcxGridDBColumn
            DataBinding.FieldName = 'inStatistics'
          end
          object cxGrid1DBTableView1Person: TcxGridDBColumn
            DataBinding.FieldName = 'Person'
            Visible = False
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
    end
  end
  object Panel1: TsPanel
    Left = 0
    Top = 31
    Width = 1074
    Height = 281
    Align = alTop
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1074
      281)
    object GroupBox1: TsGroupBox
      Left = 8
      Top = 2
      Width = 377
      Height = 188
      Caption = 'Group Booking'
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object Label2: TsLabel
        Left = 5
        Top = 12
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Customer Number :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label3: TsLabel
        Left = 5
        Top = 29
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ID :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label4: TsLabel
        Left = 5
        Top = 47
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Name :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label5: TsLabel
        Left = 5
        Top = 63
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Address :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label6: TsLabel
        Left = 5
        Top = 80
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label7: TsLabel
        Left = 5
        Top = 96
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label8: TsLabel
        Left = 5
        Top = 114
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Country :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label9: TsLabel
        Left = 5
        Top = 131
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Phone :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label10: TsLabel
        Left = 5
        Top = 148
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Phone :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label11: TsLabel
        Left = 5
        Top = 165
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Fax :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edCustomerNo: TsLabel
        Left = 135
        Top = 12
        Width = 234
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edCustPID: TsLabel
        Left = 135
        Top = 29
        Width = 234
        Height = 18
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edName: TsLabel
        Left = 135
        Top = 47
        Width = 234
        Height = 16
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edAddress1: TsLabel
        Left = 135
        Top = 63
        Width = 234
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edAddress2: TsLabel
        Left = 135
        Top = 80
        Width = 234
        Height = 16
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edAddress3: TsLabel
        Left = 135
        Top = 96
        Width = 234
        Height = 18
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edCountry: TsLabel
        Left = 135
        Top = 114
        Width = 37
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edTel1: TsLabel
        Left = 135
        Top = 131
        Width = 234
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edTel2: TsLabel
        Left = 135
        Top = 148
        Width = 234
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edFax: TsLabel
        Left = 135
        Top = 165
        Width = 234
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edCountryName: TsLabel
        Left = 177
        Top = 114
        Width = 191
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
    end
    object GroupBox2: TsGroupBox
      Left = 8
      Top = 187
      Width = 377
      Height = 87
      Caption = 'contacts'
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object Label12: TsLabel
        Left = 5
        Top = 13
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Name of Contact'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label13: TsLabel
        Left = 5
        Top = 30
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Phone :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label14: TsLabel
        Left = 5
        Top = 47
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Fax :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label15: TsLabel
        Left = 5
        Top = 64
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Email :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object Label17: TsLabel
        Left = 5
        Top = 109
        Width = 126
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
      end
      object edContact: TsLabel
        Left = 135
        Top = 13
        Width = 234
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edContactPhone: TsLabel
        Left = 135
        Top = 30
        Width = 234
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edContactFax: TsLabel
        Left = 135
        Top = 47
        Width = 234
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object edContactEmail: TsLabel
        Left = 135
        Top = 64
        Width = 234
        Height = 17
        AutoSize = False
        Caption = '-'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
    end
    object GroupBox3: TsGroupBox
      Left = 388
      Top = 2
      Width = 686
      Height = 138
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Booking comments'
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object memResInfo: TsMemo
        AlignWithMargins = True
        Left = 10
        Top = 18
        Width = 666
        Height = 115
        Margins.Left = 8
        Margins.Right = 8
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'memResInfo')
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        Text = 'memResInfo'#13#10
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'EDIT'
      end
    end
    object GroupBox4: TsGroupBox
      Left = 391
      Top = 148
      Width = 686
      Height = 124
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Payment details'
      TabOrder = 3
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object memPaymentInfo: TsMemo
        AlignWithMargins = True
        Left = 10
        Top = 18
        Width = 666
        Height = 101
        Margins.Left = 8
        Margins.Right = 8
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        Text = 'Memo1'#13#10
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'EDIT'
      end
    end
  end
  object R_: TRoomerDataSet
    CommandText = ''
    CommandType = cmdUnknown
    Parameters = <>
    DataActive = False
    RoomerStoreUri = 'http://localhost:8080/services/'
    RoomerUri = 'http://localhost:8080/services/'
    RoomerEntitiesUri = 'http://localhost:8080/services/entities/'
    RoomerDatasetsUri = 'http://localhost:8080/services/datasets/'
    SessionLengthSeconds = 0
    Left = 600
    Top = 60
  end
  object DS_: TDataSource
    DataSet = m_
    Left = 800
    Top = 124
  end
  object m_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Room'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'RoomType'
        DataType = ftWideString
        Size = 30
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
        Name = 'RoomStatus'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Arrival'
        DataType = ftDate
      end
      item
        Name = 'Departure'
        DataType = ftDate
      end
      item
        Name = 'StatusText'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'GuestType'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CountryName'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'CountryGroup'
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'GroupName'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'inStatistics'
        DataType = ftBoolean
      end
      item
        Name = 'Location'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'LocationDescription'
        DataType = ftWideString
        Size = 70
      end
      item
        Name = 'RoomTypeDescription'
        DataType = ftWideString
        Size = 70
      end
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 90
      end
      item
        Name = 'Address1'
        DataType = ftWideString
        Size = 70
      end
      item
        Name = 'Address2'
        DataType = ftWideString
        Size = 70
      end
      item
        Name = 'Address3'
        DataType = ftWideString
        Size = 70
      end
      item
        Name = 'Information'
        DataType = ftMemo
      end
      item
        Name = 'PersionalID'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'isMainName'
        DataType = ftBoolean
      end
      item
        Name = 'isNoRoom'
        DataType = ftBoolean
      end
      item
        Name = 'Floor'
        DataType = ftInteger
      end
      item
        Name = 'Person'
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
    Left = 752
    Top = 128
  end
  object ImageList1: TImageList
    Left = 672
    Top = 68
    Bitmap = {
      494C010106000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF00000000000000FFFFFF0000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000FFFFFF0000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000FFFFFF0000000000FFFFFF0000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FF000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF00000000000000FFFFFF00FFFFFF00FFFFFF0000000000FF0000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF0000000000FF00
      000000000000000000000000000000000000FF0000000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000084000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FF0000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF0000000000FF00000084000000FF000000FF00
      0000FF000000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FF000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      00000000000000FFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00000084000000FF00
      0000FF00000000000000FF000000FF000000FF00000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FF000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000008400
      0000FF000000FF000000FF00000000000000FF000000FF00000000000000FFFF
      FF0000000000FF0000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000084000000FF0000000000000000000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00000084000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000084000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00000084000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FEFFFFFF00000000FC7FF01F00000000F83FF01F00000000F01FFFFF00000000
      E00FFC0700000000C007FC07000000008003FFFF00000000F01FF01F00000000
      F01FF01F00000000F01FFFFF00000000F01F80FF00000000FFFF80FF00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFDFFFE3FFFFF
      1FFFF8FFF81FFFFF041FF07FF40FF83F000FE03FE007F83F000FC01F8003F83F
      0007800F4001F83F0001000700008003000000030000C007000180018001E00F
      003FC003C003F01FFC7FE00FE00FF83FFFFFF00FF07FFC7FFFFFF81FF8FFFEFF
      FFFFFC7FFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object rpt: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Roomer\Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39582.595856111100000000
    ReportOptions.LastChange = 40133.857691875000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 532
    Top = 59
    Datasets = <
      item
        DataSet = rptDs1
        DataSetName = 'ReservationGuests'
      end
      item
        DataSet = rptDSHead
        DataSetName = 'Head'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 20.000000000000000000
        Top = 16.000000000000000000
        Width = 740.409927000000000000
        object HeadHotelName: TfrxMemoView
          Width = 208.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'HotelName'
          DataSet = rptDSHead
          DataSetName = 'Head'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Head."HotelName"]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 20.000000000000000000
        Top = 56.000000000000000000
        Width = 740.409927000000000000
        object Memo1: TfrxMemoView
          Left = 8.000000000000000000
          Width = 136.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hva'#240' sem er')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 20.000000000000000000
        Top = 256.000000000000000000
        Width = 740.409927000000000000
      end
      object MasterData1: TfrxMasterData
        Height = 20.000000000000000000
        Top = 136.000000000000000000
        Width = 740.409927000000000000
        RowCount = 0
      end
      object DetailData1: TfrxDetailData
        Height = 20.000000000000000000
        Top = 176.000000000000000000
        Width = 740.409927000000000000
        RowCount = 0
        object CustomerStayRoom: TfrxMemoView
          Width = 56.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'Room'
          DataSet = rptDs1
          DataSetName = 'ReservationGuests'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ReservationGuests."Room"]')
          ParentFont = False
        end
        object CustomerStayRoomType: TfrxMemoView
          Left = 64.000000000000000000
          Width = 40.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'RoomType'
          DataSet = rptDs1
          DataSetName = 'ReservationGuests'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ReservationGuests."RoomType"]')
          ParentFont = False
        end
        object CustomerStayGuestName: TfrxMemoView
          Left = 112.000000000000000000
          Width = 152.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'GuestName'
          DataSet = rptDs1
          DataSetName = 'ReservationGuests'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ReservationGuests."GuestName"]')
          ParentFont = False
        end
        object CustomerStayArrival: TfrxMemoView
          Left = 272.000000000000000000
          Width = 80.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'Arrival'
          DataSet = rptDs1
          DataSetName = 'ReservationGuests'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ReservationGuests."Arrival"]')
          ParentFont = False
        end
        object CustomerStayDeparture: TfrxMemoView
          Left = 360.000000000000000000
          Width = 80.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'Departure'
          DataSet = rptDs1
          DataSetName = 'ReservationGuests'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ReservationGuests."Departure"]')
          ParentFont = False
        end
        object CustomerStayRoomStatus: TfrxMemoView
          Left = 448.000000000000000000
          Width = 72.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'RoomStatus'
          DataSet = rptDs1
          DataSetName = 'ReservationGuests'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ReservationGuests."RoomStatus"]')
          ParentFont = False
        end
        object CustomerStayStatusText: TfrxMemoView
          Left = 528.000000000000000000
          Width = 160.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'StatusText'
          DataSet = rptDs1
          DataSetName = 'ReservationGuests'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ReservationGuests."StatusText"]')
          ParentFont = False
        end
      end
    end
  end
  object rptDesign: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 564
    Top = 60
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    Creator = 'FastReport'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 589
    Top = 152
  end
  object frxHTMLExport1: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 561
    Top = 152
  end
  object frxRTFExport1: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 529
    Top = 152
  end
  object frxJPEGExport1: TfrxJPEGExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 625
    Top = 152
  end
  object rptDs1: TfrxDBDataset
    UserName = 'ReservationGuests'
    CloseDataSource = False
    DataSet = m_
    BCDToCurrency = False
    Left = 712
    Top = 132
  end
  object rptDSHead: TfrxDBDataset
    UserName = 'Head'
    CloseDataSource = False
    DataSet = mHead_
    BCDToCurrency = False
    Left = 712
    Top = 160
  end
  object mHead_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'HotelName'
        DataType = ftWideString
        Size = 90
      end
      item
        Name = 'DateFrom'
        DataType = ftDate
      end
      item
        Name = 'DateTo'
        DataType = ftDate
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
    Left = 752
    Top = 172
  end
  object mResCustomer: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Name'
        DataType = ftWideString
        Size = 140
      end
      item
        Name = 'Address1'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Address2'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Address3'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CountryName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Tel1'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Tel2'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Fax'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'ReservationDate'
        DataType = ftDateTime
      end
      item
        Name = 'Contact'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'ContactPhone'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'ContactFax'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'ContactEmail'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Staff'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'ResInfo'
        DataType = ftMemo
      end
      item
        Name = 'PaymentInfo'
        DataType = ftMemo
      end
      item
        Name = 'HiddenInfo'
        DataType = ftMemo
      end
      item
        Name = 'CustomerNo'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'CustPID'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Arrival'
        DataType = ftDateTime
      end
      item
        Name = 'Departure'
        DataType = ftDateTime
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
    Left = 752
    Top = 228
  end
  object rptDSResCustomer: TfrxDBDataset
    UserName = 'ResInfo'
    CloseDataSource = False
    DataSet = mResCustomer
    BCDToCurrency = False
    Left = 848
    Top = 204
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
    StorageName = 'Software\Roomer\FormStatus\ResGuestList'
    StorageType = stRegistry
    Left = 998
    Top = 248
  end
end
