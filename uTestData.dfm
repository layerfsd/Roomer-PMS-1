object frmTestData: TfrmTestData
  Left = 0
  Top = 0
  Caption = 'Booking.com to Roomer'
  ClientHeight = 600
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object panMainTop: TsPanel
    Left = 0
    Top = 0
    Width = 742
    Height = 36
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 799
    DesignSize = (
      742
      36)
    object btnExit: TsButton
      Left = 654
      Top = 5
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 8
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 711
    end
    object edResFileName: TsFilenameEdit
      Left = 120
      Top = 7
      Width = 353
      Height = 21
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 255
      ParentFont = False
      TabOrder = 1
      Text = ''
      BoundLabel.Active = True
      BoundLabel.Caption = 'Reservation file : '
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'EDIT'
      GlyphMode.Blend = 0
      GlyphMode.Grayed = False
      DirectInput = False
      OnAfterDialog = edResFileNameAfterDialog
      DefaultExt = '_res.csv'
      Filter = 'Reservation file|*_res.csv'
    end
    object btnInsertToRoomer: TsButton
      Left = 489
      Top = 5
      Width = 137
      Height = 25
      Caption = 'Insert to roomer'
      TabOrder = 2
      OnClick = btnInsertToRoomerClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 581
    Width = 742
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
    ExplicitWidth = 799
  end
  object pgMain: TsPageControl
    Left = 0
    Top = 36
    Width = 742
    Height = 545
    ActivePage = sTabSheet5
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PAGECONTROL'
    object sheetUpdateNames: TsTabSheet
      Caption = 'Update Names'
      TabVisible = False
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 791
      ExplicitHeight = 0
      object sPanel1: TsPanel
        Left = 0
        Top = 0
        Width = 734
        Height = 129
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        ExplicitWidth = 791
        DesignSize = (
          734
          129)
        object Label4: TsLabel
          Left = 1
          Top = 9
          Width = 80
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Import file : '
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labCountryName: TsLabel
          Left = 206
          Top = 94
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
        object sLabel2: TsLabel
          Left = 20
          Top = 94
          Width = 65
          Height = 13
          Caption = 'Reservation :'
        end
        object sButton3: TsButton
          Left = 5
          Top = 34
          Width = 80
          Height = 25
          Caption = 'Excel'
          TabOrder = 0
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton2: TsButton
          Left = 91
          Top = 34
          Width = 80
          Height = 25
          Caption = 'Refresh'
          TabOrder = 1
          SkinData.SkinSection = 'BUTTON'
        end
        object edImportfile: TsFilenameEdit
          Left = 87
          Top = 7
          Width = 647
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 255
          ParentFont = False
          TabOrder = 2
          Text = ''
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
          DirectInput = False
          AcceptFiles = True
          DefaultExt = 'CSV'
          FilterIndex = 2
          Filter = 'All files (*.*)|*.*|Comma seperated value (*.csv)|*.csv'
        end
        object edCountry: TcxButtonEdit
          Left = 91
          Top = 92
          ParentFont = False
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.CharCase = ecUpperCase
          Properties.MaxLength = 2
          Style.LookAndFeel.NativeStyle = False
          Style.ButtonStyle = btsOffice11
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 3
          TextHint = 'dbl click to select from list'
          Width = 109
        end
        object edFilter: TAdvEditBtn
          Left = 5
          Top = 65
          Width = 298
          Height = 21
          EmptyText = 'Enter text to filter grid'
          EmptyTextStyle = []
          Flat = False
          FullTextSearch = True
          LabelPosition = lpLeftCenter
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Lookup.Font.Charset = DEFAULT_CHARSET
          Lookup.Font.Color = clWindowText
          Lookup.Font.Height = -11
          Lookup.Font.Name = 'Arial'
          Lookup.Font.Style = []
          Lookup.Separator = ';'
          Color = clWindow
          ReadOnly = False
          TabOrder = 4
          Text = ''
          Visible = True
          Version = '1.3.4.0'
          ButtonStyle = bsButton
          ButtonWidth = 42
          ButtonHint = 'Clear filter'
          Etched = False
          ButtonCaption = 'Clear'
        end
        object sGroupBox1: TsGroupBox
          Left = 371
          Top = 30
          Width = 355
          Height = 93
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'Update'
          TabOrder = 5
          SkinData.SkinSection = 'GROUPBOX'
          ExplicitWidth = 412
          object sLabel1: TsLabel
            Left = 16
            Top = 27
            Width = 65
            Height = 13
            Caption = 'Reservation :'
          end
          object edReservation: TsEdit
            Left = 87
            Top = 24
            Width = 90
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            NumbersOnly = True
            ParentFont = False
            TabOrder = 0
            Text = '0'
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Indent = 0
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -11
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
            BoundLabel.Layout = sclLeft
            BoundLabel.MaxWidth = 0
            BoundLabel.UseSkinColor = True
          end
          object sButton1: TsButton
            Left = 183
            Top = 21
            Width = 73
            Height = 25
            Caption = 'Do it'
            TabOrder = 1
            OnClick = sButton1Click
            SkinData.SkinSection = 'BUTTON'
          end
        end
      end
      object grFakeNames: TcxGrid
        Left = 0
        Top = 129
        Width = 734
        Height = 388
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 791
        object tvFakeNames: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Visible = True
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Cancel.Visible = False
          Navigator.InfoPanel.Visible = True
          Navigator.Visible = True
          DataController.DetailKeyFieldNames = 'reservation'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              FieldName = 'dtCreated'
            end
            item
              Kind = skSum
              FieldName = 'GuestCount'
            end
            item
              Kind = skSum
              FieldName = 'roomCount'
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          object tvFakeNamesgender: TcxGridDBColumn
            DataBinding.FieldName = 'gender'
          end
          object tvFakeNamestitle: TcxGridDBColumn
            DataBinding.FieldName = 'title'
          end
          object tvFakeNamesgivenname: TcxGridDBColumn
            DataBinding.FieldName = 'givenname'
          end
          object tvFakeNamessurname: TcxGridDBColumn
            DataBinding.FieldName = 'surname'
          end
          object tvFakeNamesstreetaddress: TcxGridDBColumn
            DataBinding.FieldName = 'streetaddress'
            Width = 100
          end
          object tvFakeNamesCity: TcxGridDBColumn
            DataBinding.FieldName = 'City'
            Width = 100
          end
          object tvFakeNamesstate: TcxGridDBColumn
            DataBinding.FieldName = 'state'
            Width = 100
          end
          object tvFakeNameszipcode: TcxGridDBColumn
            DataBinding.FieldName = 'zipcode'
            Width = 100
          end
          object tvFakeNamesCountry: TcxGridDBColumn
            DataBinding.FieldName = 'Country'
            Width = 100
          end
          object tvFakeNamesemailaddress: TcxGridDBColumn
            DataBinding.FieldName = 'emailaddress'
            Width = 100
          end
          object tvFakeNamestelephonenumber: TcxGridDBColumn
            DataBinding.FieldName = 'telephonenumber'
          end
        end
        object cxGridDBTableView3: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DetailKeyFieldNames = 'Roomreservation'
          DataController.KeyFieldNames = 'Roomreservation'
          DataController.MasterKeyFieldNames = 'Roomreservation'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          object cxGridDBColumn60: TcxGridDBColumn
            DataBinding.FieldName = 'Roomreservation'
          end
          object cxGridDBColumn61: TcxGridDBColumn
            DataBinding.FieldName = 'reservation'
          end
          object cxGridDBColumn62: TcxGridDBColumn
            DataBinding.FieldName = 'roomDate'
          end
          object cxGridDBColumn63: TcxGridDBColumn
            DataBinding.FieldName = 'ResFlag'
          end
          object cxGridDBColumn64: TcxGridDBColumn
            DataBinding.FieldName = 'isNoRoom'
          end
          object cxGridDBColumn65: TcxGridDBColumn
            DataBinding.FieldName = 'PriceCode'
          end
          object cxGridDBColumn66: TcxGridDBColumn
            DataBinding.FieldName = 'RoomRate'
          end
          object cxGridDBColumn67: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
          end
          object cxGridDBColumn68: TcxGridDBColumn
            DataBinding.FieldName = 'Discount'
          end
          object cxGridDBColumn69: TcxGridDBColumn
            DataBinding.FieldName = 'isPercentage'
          end
          object cxGridDBColumn70: TcxGridDBColumn
            DataBinding.FieldName = 'showDiscount'
          end
          object cxGridDBColumn71: TcxGridDBColumn
            DataBinding.FieldName = 'Paid'
          end
        end
        object cxGridDBBandedTableView1: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Bands = <
            item
            end>
        end
        object lvFakeNames: TcxGridLevel
          GridView = tvFakeNames
        end
      end
    end
    object sheetChangeDates: TsTabSheet
      Caption = 'Change Dates'
      TabVisible = False
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 791
      ExplicitHeight = 0
    end
    object sTabSheet5: TsTabSheet
      Caption = 'Getbooking.com'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 791
      ExplicitHeight = 0
      object sPanel6: TsPanel
        Left = 0
        Top = 0
        Width = 734
        Height = 209
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        ExplicitWidth = 791
        DesignSize = (
          734
          209)
        object Label1: TLabel
          Left = 16
          Top = 11
          Width = 121
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Comtact Name :'
        end
        object Label2: TLabel
          Left = 16
          Top = 34
          Width = 121
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Room count :'
        end
        object Label3: TLabel
          Left = 16
          Top = 57
          Width = 121
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Address :'
        end
        object Label5: TLabel
          Left = 16
          Top = 80
          Width = 121
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Contact Tel :'
        end
        object Label6: TLabel
          Left = 16
          Top = 104
          Width = 121
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Contact Email :'
        end
        object Label7: TLabel
          Left = 16
          Top = 127
          Width = 121
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Order date :'
        end
        object Label8: TLabel
          Left = 14
          Top = 151
          Width = 121
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Refrence number :'
        end
        object Label9: TLabel
          Left = 14
          Top = 175
          Width = 121
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Nationality :'
        end
        object Label10: TLabel
          Left = 227
          Top = 34
          Width = 81
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total price :'
        end
        object PageControl2: TPageControl
          Left = 400
          Top = 7
          Width = 330
          Height = 186
          ActivePage = TabSheet2
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          ExplicitWidth = 387
          object TabSheet2: TTabSheet
            Caption = 'Reservation remarks'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 379
            ExplicitHeight = 0
            object DBMemo2: TDBMemo
              Left = 0
              Top = 0
              Width = 322
              Height = 158
              Align = alClient
              Anchors = [akLeft, akTop, akBottom]
              DataField = 'ResRemarks'
              DataSource = kbmReservationsDS
              ReadOnly = True
              TabOrder = 0
              ExplicitWidth = 379
            end
          end
          object TabSheet6: TTabSheet
            Caption = 'Room remarks'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 379
            ExplicitHeight = 0
            object DBMemo1: TDBMemo
              Left = 0
              Top = 0
              Width = 322
              Height = 158
              Align = alClient
              Anchors = [akLeft, akTop, akBottom]
              DataField = 'GuestsRemarks'
              DataSource = kbmRoomResDS
              TabOrder = 0
              ExplicitWidth = 379
            end
          end
          object TabSheet7: TTabSheet
            Caption = 'Canncelation Policy'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 379
            ExplicitHeight = 0
            object DBMemo3: TDBMemo
              Left = 0
              Top = 0
              Width = 322
              Height = 158
              Align = alClient
              Anchors = [akLeft, akTop, akBottom]
              DataField = 'Cancellation_Policy'
              DataSource = kbmRoomResDS
              TabOrder = 0
              ExplicitWidth = 379
            end
          end
        end
        object edContactName: TEdit
          Left = 148
          Top = 7
          Width = 246
          Height = 21
          TabOrder = 1
        end
        object edRoomCount: TEdit
          Left = 148
          Top = 31
          Width = 69
          Height = 21
          TabOrder = 2
        end
        object edTotalprice: TEdit
          Left = 313
          Top = 31
          Width = 81
          Height = 21
          TabOrder = 3
        end
        object edAddress: TEdit
          Left = 148
          Top = 54
          Width = 246
          Height = 21
          TabOrder = 4
        end
        object edContactTel: TEdit
          Left = 148
          Top = 77
          Width = 246
          Height = 21
          TabOrder = 5
        end
        object edContactEmail: TEdit
          Left = 148
          Top = 101
          Width = 246
          Height = 21
          TabOrder = 6
        end
        object edOrderdate: TEdit
          Left = 148
          Top = 124
          Width = 246
          Height = 21
          TabOrder = 7
        end
        object edRefr: TEdit
          Left = 148
          Top = 147
          Width = 246
          Height = 21
          TabOrder = 8
        end
        object edNationality: TEdit
          Left = 148
          Top = 171
          Width = 246
          Height = 21
          TabOrder = 9
        end
      end
      object PageControl1: TPageControl
        Left = 0
        Top = 209
        Width = 734
        Height = 308
        ActivePage = TabSheet1
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 791
        object TabSheet1: TTabSheet
          Caption = 'Source'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 783
          ExplicitHeight = 0
          object sPanel7: TsPanel
            Left = 0
            Top = 0
            Width = 726
            Height = 55
            Align = alTop
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            ExplicitWidth = 783
            object labCustomer: TsLabel
              Left = 119
              Top = 14
              Width = 169
              Height = 20
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Booking.com Customer :'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
            end
            object labRackCustomerName: TsLabel
              Left = 403
              Top = 14
              Width = 4
              Height = 14
              Caption = '-'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
            end
            object labCurrency: TsLabel
              Left = 420
              Top = 13
              Width = 169
              Height = 20
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Default currency :'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
            end
            object labCurrencyname: TsLabel
              Left = 704
              Top = 13
              Width = 4
              Height = 14
              Caption = '-'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
            end
            object btnGetRoomTypes: TsButton
              Left = 7
              Top = 10
              Width = 92
              Height = 25
              Caption = 'Get Roomtypes'
              TabOrder = 0
              OnClick = btnGetRoomTypesClick
              SkinData.SkinSection = 'BUTTON'
            end
            object edCustomer: TsEdit
              Left = 303
              Top = 11
              Width = 94
              Height = 22
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnDblClick = edCustomerDblClick
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Indent = 0
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -11
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              BoundLabel.Layout = sclLeft
              BoundLabel.MaxWidth = 0
              BoundLabel.UseSkinColor = True
            end
            object edCurrency: TsEdit
              Left = 604
              Top = 10
              Width = 94
              Height = 22
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              OnDblClick = edCurrencyDblClick
              SkinData.SkinSection = 'EDIT'
              BoundLabel.Indent = 0
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -11
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              BoundLabel.Layout = sclLeft
              BoundLabel.MaxWidth = 0
              BoundLabel.UseSkinColor = True
            end
            object sProgressBar2: TsProgressBar
              Left = 1
              Top = 37
              Width = 724
              Height = 17
              Align = alBottom
              TabOrder = 3
              SkinData.SkinSection = 'GAUGE'
              ExplicitWidth = 781
            end
          end
          object grRoomMap: TcxGrid
            Left = 0
            Top = 55
            Width = 726
            Height = 225
            Align = alClient
            TabOrder = 1
            LookAndFeel.NativeStyle = False
            ExplicitWidth = 783
            object tvRoomMap: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = kbmRoomMapDS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              object tvRoomMapBRoom: TcxGridDBColumn
                Caption = 'Booking roomtype'
                DataBinding.FieldName = 'BRoom'
                Width = 300
              end
              object tvRoomMapHRoom: TcxGridDBColumn
                Caption = 'Hotel RoomType'
                DataBinding.FieldName = 'HRoom'
              end
            end
            object lvRoomMap: TcxGridLevel
              GridView = tvRoomMap
            end
          end
        end
        object TabSheet3: TTabSheet
          Caption = 'Reservations'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 783
          ExplicitHeight = 0
          object grReservations: TcxGrid
            Left = 0
            Top = 0
            Width = 726
            Height = 280
            Align = alClient
            TabOrder = 0
            LookAndFeel.NativeStyle = False
            ExplicitWidth = 783
            object tvReservations: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = kbmReservationsDS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              object tvReservationsrefr: TcxGridDBColumn
                Caption = 'Refrence No.'
                DataBinding.FieldName = 'refr'
                Width = 109
              end
              object tvReservationscontactName: TcxGridDBColumn
                Caption = 'contact Name'
                DataBinding.FieldName = 'contactName'
                Width = 131
              end
              object tvReservationsroomcount: TcxGridDBColumn
                Caption = 'Room Count'
                DataBinding.FieldName = 'roomcount'
                Width = 79
              end
              object tvReservationsAddress: TcxGridDBColumn
                DataBinding.FieldName = 'Address'
                Width = 132
              end
              object tvReservationscontacttel: TcxGridDBColumn
                Caption = 'Contact Tel.'
                DataBinding.FieldName = 'contacttel'
                Width = 187
              end
              object tvReservationscontactEmail: TcxGridDBColumn
                Caption = 'contact Email'
                DataBinding.FieldName = 'contactEmail'
                Width = 181
              end
              object tvReservationsorderdate: TcxGridDBColumn
                Caption = 'Order Date'
                DataBinding.FieldName = 'orderdate'
                Width = 200
              end
            end
            object lvReservations: TcxGridLevel
              GridView = tvReservations
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'Rooms'
          ImageIndex = 4
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 783
          ExplicitHeight = 0
          object grRooms: TcxGrid
            Left = 0
            Top = 0
            Width = 726
            Height = 280
            Align = alClient
            Images = DImages.PngImageList1
            TabOrder = 0
            LookAndFeel.NativeStyle = False
            ExplicitWidth = 783
            object tvRooms: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = kbmRoomResDS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              object tvRoomsRefr: TcxGridDBColumn
                Caption = 'Refrence'
                DataBinding.FieldName = 'Refr'
                Width = 118
              end
              object tvRoomsRoomSerial: TcxGridDBColumn
                DataBinding.FieldName = 'RoomSerial'
              end
              object tvRoomsGuestName: TcxGridDBColumn
                DataBinding.FieldName = 'GuestName'
                Width = 114
              end
              object tvRoomsCheckin: TcxGridDBColumn
                DataBinding.FieldName = 'Checkin'
                Width = 100
              end
              object tvRoomsCheckout: TcxGridDBColumn
                DataBinding.FieldName = 'Checkout'
                Width = 100
              end
              object tvRoomsRoomtype: TcxGridDBColumn
                DataBinding.FieldName = 'Roomtype'
                Width = 100
              end
              object tvRoomsNumberOfPersons: TcxGridDBColumn
                DataBinding.FieldName = 'NumberOfPersons'
                Width = 100
              end
              object tvRoomsCostsPerNight: TcxGridDBColumn
                DataBinding.FieldName = 'CostsPerNight'
                Width = 100
              end
              object tvRoomsStatus: TcxGridDBColumn
                DataBinding.FieldName = 'Status'
                Width = 100
              end
              object tvRoomsSmoking_preference: TcxGridDBColumn
                DataBinding.FieldName = 'Smoking_preference'
                Width = 100
              end
              object tvRoomsCancellation_Policy: TcxGridDBColumn
                DataBinding.FieldName = 'Cancellation_Policy'
                Width = 100
              end
              object tvRoomsMeal_Plan: TcxGridDBColumn
                DataBinding.FieldName = 'Meal_Plan'
                Width = 100
              end
              object tvRoomsArrival: TcxGridDBColumn
                DataBinding.FieldName = 'Arrival'
                Width = 100
              end
              object tvRoomsDeparture: TcxGridDBColumn
                DataBinding.FieldName = 'Departure'
                Width = 100
              end
              object tvRoomsNumberofnights: TcxGridDBColumn
                DataBinding.FieldName = 'Numberofnights'
                Width = 100
              end
              object tvRoomsTotalCosts: TcxGridDBColumn
                DataBinding.FieldName = 'TotalCosts'
                Width = 100
              end
              object tvRoomsDeposit_Policy: TcxGridDBColumn
                DataBinding.FieldName = 'Deposit_Policy'
                Width = 100
              end
              object tvRoomsGuestsRemarks: TcxGridDBColumn
                DataBinding.FieldName = 'GuestsRemarks'
                PropertiesClassName = 'TcxMemoProperties'
              end
            end
            object lvRooms: TcxGridLevel
              GridView = tvRooms
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'TabSheet4'
          ImageIndex = 4
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 783
          ExplicitHeight = 0
          object Memo2: TMemo
            Left = 0
            Top = 0
            Width = 726
            Height = 280
            Align = alClient
            Lines.Strings = (
              'Memo1')
            TabOrder = 0
            ExplicitWidth = 783
          end
        end
      end
    end
  end
  object kbmRwavReservations: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'idprenota'
        DataType = ftInteger
      end
      item
        Name = 'id_client'
        DataType = ftInteger
      end
      item
        Name = 'id_apartment'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'id_startdate'
        DataType = ftInteger
      end
      item
        Name = 'id_enddate'
        DataType = ftInteger
      end
      item
        Name = 'app_assegnabili'
        DataType = ftMemo
      end
      item
        Name = 'people_numb'
        DataType = ftInteger
      end
      item
        Name = 'rate'
        DataType = ftMemo
      end
      item
        Name = 'weekly_rate'
        DataType = ftMemo
      end
      item
        Name = 'discount'
        DataType = ftFloat
      end
      item
        Name = 'total_rate'
        DataType = ftFloat
      end
      item
        Name = 'paid'
        DataType = ftFloat
      end
      item
        Name = 'code'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'origin'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'comments'
        DataType = ftMemo
      end
      item
        Name = 'confirmed'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'checkin'
        DataType = ftDateTime
      end
      item
        Name = 'checkout'
        DataType = ftDateTime
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
    Left = 936
    Top = 488
  end
  object RwavGuestsDS: TDataSource
    Left = 800
    Top = 480
  end
  object RwavReservationsDS: TDataSource
    DataSet = kbmRwavReservations
    Left = 904
    Top = 360
  end
  object kbmBookingcom: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ExcelLine'
        DataType = ftInteger
      end
      item
        Name = 'Refrence'
        DataType = ftWideString
        Size = 90
      end
      item
        Name = 'BookDate'
        DataType = ftDateTime
      end
      item
        Name = 'Contact'
        DataType = ftWideString
        Size = 150
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
        Name = 'Rooms'
        DataType = ftInteger
      end
      item
        Name = 'tel'
        DataType = ftWideString
        Size = 90
      end
      item
        Name = 'Email'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Country'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'noGuests'
        DataType = ftInteger
      end
      item
        Name = 'Notes'
        DataType = ftWideMemo
      end
      item
        Name = 'Extranotes'
        DataType = ftWideMemo
      end
      item
        Name = 'RoomTypes'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Res'
        DataType = ftInteger
      end
      item
        Name = 'roomRes'
        DataType = ftInteger
      end
      item
        Name = 'guestnames'
        DataType = ftWideMemo
      end
      item
        Name = 'Price'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BedPrefr'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'currency'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'pricePerNight'
        DataType = ftFloat
      end
      item
        Name = 'CountryCode'
        DataType = ftString
        Size = 20
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
    Left = 920
    Top = 408
  end
  object kbmBookingComRes: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Res'
        DataType = ftInteger
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
        Name = 'Customer'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'BookDate'
        DataType = ftDateTime
      end
      item
        Name = 'Notes'
        DataType = ftWideMemo
      end
      item
        Name = 'Extranotes'
        DataType = ftWideMemo
      end
      item
        Name = 'Contact'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'tel'
        DataType = ftWideString
        Size = 90
      end
      item
        Name = 'Email'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Refrence'
        DataType = ftWideString
        Size = 90
      end
      item
        Name = 'Country'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Rooms'
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
    Left = 888
    Top = 424
  end
  object DataSource2: TDataSource
    DataSet = kbmBookingComRes
    Left = 808
    Top = 400
  end
  object kbmMemTable1: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ExcelLine'
        DataType = ftInteger
      end
      item
        Name = 'Refrence'
        DataType = ftWideString
        Size = 90
      end
      item
        Name = 'BookDate'
        DataType = ftDateTime
      end
      item
        Name = 'Contact'
        DataType = ftWideString
        Size = 150
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
        Name = 'Rooms'
        DataType = ftInteger
      end
      item
        Name = 'tel'
        DataType = ftWideString
        Size = 90
      end
      item
        Name = 'Email'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Country'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'noGuests'
        DataType = ftInteger
      end
      item
        Name = 'Notes'
        DataType = ftWideMemo
      end
      item
        Name = 'Extranotes'
        DataType = ftWideMemo
      end
      item
        Name = 'RoomTypes'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Res'
        DataType = ftInteger
      end
      item
        Name = 'roomRes'
        DataType = ftInteger
      end
      item
        Name = 'guestnames'
        DataType = ftWideMemo
      end
      item
        Name = 'Price'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BedPrefr'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'currency'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'pricePerNight'
        DataType = ftFloat
      end
      item
        Name = 'CountryCode'
        DataType = ftString
        Size = 20
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
    Left = 872
    Top = 464
  end
  object DataSource1: TDataSource
    DataSet = kbmMemTable1
    Left = 808
    Top = 432
  end
  object kbmCSVStreamFormat1: TkbmCSVStreamFormat
    CommentChar = #0
    EscapeChar = '%'
    DefaultStringFieldSize = 255
    CSVQuote = '"'
    CSVFieldDelimiter = ';'
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    sfLocalFormat = []
    sfQuoteOnlyStrings = []
    sfNoHeader = []
    Version = '3.10'
    sfData = [sfSaveData, sfLoadData]
    sfCalculated = []
    sfLookup = []
    sfNonVisible = [sfSaveNonVisible, sfLoadNonVisible]
    sfBlobs = [sfSaveBlobs, sfLoadBlobs]
    sfDef = [sfSaveDef, sfLoadDef]
    sfIndexDef = [sfSaveIndexDef, sfLoadIndexDef]
    sfPlaceHolders = []
    sfFiltered = [sfSaveFiltered]
    sfIgnoreRange = [sfSaveIgnoreRange]
    sfIgnoreMasterDetail = [sfSaveIgnoreMasterDetail]
    sfDeltas = []
    sfDontFilterDeltas = []
    sfAppend = []
    sfFieldKind = [sfSaveFieldKind]
    sfFromStart = [sfLoadFromStart]
    sfDisplayWidth = []
    sfAutoInc = []
    Left = 56
    Top = 528
  end
  object kbmRoomRes: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'GuestName'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Checkin'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Checkout'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Roomtype'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'NumberOfPersons'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'CostsPerNight'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Status'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Smoking_preference'
        DataType = ftWideString
        Size = 512
      end
      item
        Name = 'Cancellation_Policy'
        DataType = ftWideMemo
      end
      item
        Name = 'Deposit_Policy'
        DataType = ftWideMemo
      end
      item
        Name = 'Meal_Plan'
        DataType = ftWideMemo
      end
      item
        Name = 'Arrival'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Departure'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Numberofnights'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'TotalCosts'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Refr'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'RoomSerial'
        DataType = ftInteger
      end
      item
        Name = 'GuestsRemarks'
        DataType = ftWideMemo
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
    DefaultFormat = kbmCSVStreamFormat1
    CommaTextFormat = kbmCSVStreamFormat1
    PersistentFormat = kbmCSVStreamFormat1
    FormFormat = kbmCSVStreamFormat1
    AfterScroll = kbmRoomResAfterScroll
    Left = 192
    Top = 480
  end
  object kbmReservations: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'contactName'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'roomcount'
        DataType = ftInteger
      end
      item
        Name = 'contacttel'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'contactEmail'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'orderdate'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'refr'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Address'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'ResRemarks'
        DataType = ftWideMemo
      end
      item
        Name = 'Nationality'
        DataType = ftWideString
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
    DefaultFormat = kbmCSVStreamFormat1
    CommaTextFormat = kbmCSVStreamFormat1
    PersistentFormat = kbmCSVStreamFormat1
    AllDataFormat = kbmCSVStreamFormat1
    FormFormat = kbmCSVStreamFormat1
    AfterScroll = kbmReservationsAfterScroll
    Left = 56
    Top = 408
  end
  object kbmReservationsDS: TDataSource
    DataSet = kbmReservations
    Left = 56
    Top = 464
  end
  object PopupMenu1: TPopupMenu
    Left = 448
    Top = 144
    object P1: TMenuItem
      Caption = 'Pharse'
      ShortCut = 16470
    end
  end
  object kbmRoomResDS: TDataSource
    DataSet = kbmRoomRes
    Left = 283
    Top = 488
  end
  object kbmRoomMap: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'BRoom'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'HRoom'
        DataType = ftWideString
        Size = 20
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
    Left = 184
    Top = 416
  end
  object kbmRoomMapDS: TDataSource
    DataSet = kbmRoomMap
    Left = 256
    Top = 424
  end
end
