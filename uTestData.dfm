object frmTestData: TfrmTestData
  Left = 0
  Top = 0
  Caption = 'Booking.com to Roomer'
  ClientHeight = 690
  ClientWidth = 1132
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
    Width = 1132
    Height = 1
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1132
      1)
    object btnExit: TsButton
      Left = 1044
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
    end
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 671
    Width = 1132
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object sPageControl1: TsPageControl
    Left = 0
    Top = 1
    Width = 1132
    Height = 670
    ActivePage = DK
    Align = alClient
    TabOrder = 2
    object sTabSheet1: TsTabSheet
      Caption = 'Booking.com'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 1124
        Height = 41
        Align = alTop
        TabOrder = 0
        object edResFileName: TsFilenameEdit
          Left = 120
          Top = 7
          Width = 353
          Height = 21
          AutoSize = False
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 255
          ParentFont = False
          TabOrder = 0
          Text = ''
          CheckOnExit = True
          BoundLabel.Active = True
          BoundLabel.Caption = 'Reservation file : '
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
          TabOrder = 1
          OnClick = btnInsertToRoomerClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object pgMain: TsPageControl
        Left = 0
        Top = 41
        Width = 1124
        Height = 601
        ActivePage = sTabSheet5
        Align = alClient
        TabOrder = 1
        SkinData.SkinSection = 'PAGECONTROL'
        object sheetUpdateNames: TsTabSheet
          Caption = 'Update Names'
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
            Width = 1116
            Height = 129
            Align = alTop
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            DesignSize = (
              1116
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
              Width = 1029
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
              CheckOnExit = True
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
              Version = '1.3.6.0'
              ButtonStyle = bsButton
              ButtonWidth = 42
              ButtonHint = 'Clear filter'
              Etched = False
              ButtonCaption = 'Clear'
            end
            object sGroupBox1: TsGroupBox
              Left = 371
              Top = 30
              Width = 737
              Height = 93
              Anchors = [akLeft, akTop, akRight, akBottom]
              Caption = 'Update'
              TabOrder = 5
              SkinData.SkinSection = 'GROUPBOX'
              Checked = False
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
            Width = 1116
            Height = 444
            Align = alClient
            TabOrder = 1
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
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object sTabSheet5: TsTabSheet
          Caption = 'Getbooking.com'
          SkinData.CustomColor = False
          SkinData.CustomFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object sPanel6: TsPanel
            Left = 0
            Top = 0
            Width = 1116
            Height = 209
            Align = alTop
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            DesignSize = (
              1116
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
              Width = 712
              Height = 186
              ActivePage = TabSheet2
              Anchors = [akLeft, akTop, akRight, akBottom]
              TabOrder = 0
              object TabSheet2: TTabSheet
                Caption = 'Reservation remarks'
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object DBMemo2: TDBMemo
                  Left = 0
                  Top = 0
                  Width = 704
                  Height = 158
                  Align = alClient
                  Anchors = [akLeft, akTop, akBottom]
                  DataField = 'ResRemarks'
                  DataSource = kbmReservationsDS
                  ReadOnly = True
                  TabOrder = 0
                end
              end
              object TabSheet6: TTabSheet
                Caption = 'Room remarks'
                ImageIndex = 1
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object DBMemo1: TDBMemo
                  Left = 0
                  Top = 0
                  Width = 704
                  Height = 158
                  Align = alClient
                  Anchors = [akLeft, akTop, akBottom]
                  DataField = 'GuestsRemarks'
                  DataSource = kbmRoomResDS
                  TabOrder = 0
                end
              end
              object TabSheet7: TTabSheet
                Caption = 'Canncelation Policy'
                ImageIndex = 2
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object DBMemo3: TDBMemo
                  Left = 0
                  Top = 0
                  Width = 704
                  Height = 158
                  Align = alClient
                  Anchors = [akLeft, akTop, akBottom]
                  DataField = 'Cancellation_Policy'
                  DataSource = kbmRoomResDS
                  TabOrder = 0
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
            Width = 1116
            Height = 364
            ActivePage = TabSheet1
            Align = alClient
            TabOrder = 1
            object TabSheet1: TTabSheet
              Caption = 'Source'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object sPanel7: TsPanel
                Left = 0
                Top = 0
                Width = 1108
                Height = 55
                Align = alTop
                TabOrder = 0
                SkinData.SkinSection = 'PANEL'
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
                  Color = clWhite
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  OnDblClick = edCustomerDblClick
                  SkinData.SkinSection = 'EDIT'
                end
                object edCurrency: TsEdit
                  Left = 604
                  Top = 10
                  Width = 94
                  Height = 22
                  Color = clWhite
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 2
                  OnDblClick = edCurrencyDblClick
                  SkinData.SkinSection = 'EDIT'
                end
                object sProgressBar2: TsProgressBar
                  Left = 1
                  Top = 37
                  Width = 1106
                  Height = 17
                  Align = alBottom
                  TabOrder = 3
                  SkinData.SkinSection = 'GAUGE'
                end
              end
              object grRoomMap: TcxGrid
                Left = 0
                Top = 55
                Width = 1108
                Height = 281
                Align = alClient
                TabOrder = 1
                LookAndFeel.NativeStyle = False
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
              ExplicitWidth = 0
              ExplicitHeight = 0
              object grReservations: TcxGrid
                Left = 0
                Top = 0
                Width = 1108
                Height = 336
                Align = alClient
                TabOrder = 0
                LookAndFeel.NativeStyle = False
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
              ExplicitWidth = 0
              ExplicitHeight = 0
              object grRooms: TcxGrid
                Left = 0
                Top = 0
                Width = 1108
                Height = 336
                Align = alClient
                Images = DImages.PngImageList1
                TabOrder = 0
                LookAndFeel.NativeStyle = False
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
              ExplicitWidth = 0
              ExplicitHeight = 0
              object Memo2: TMemo
                Left = 0
                Top = 0
                Width = 1108
                Height = 336
                Align = alClient
                Lines.Strings = (
                  'Memo1')
                TabOrder = 0
              end
            end
          end
        end
      end
    end
    object DK: TsTabSheet
      Caption = 'DK'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ProgressBar1: TProgressBar
        Left = 0
        Top = 0
        Width = 1124
        Height = 17
        Align = alTop
        Step = 1
        TabOrder = 0
      end
      object PageControl3: TPageControl
        Left = 0
        Top = 17
        Width = 1124
        Height = 625
        ActivePage = TabSheet9
        Align = alClient
        TabOrder = 1
        object TabSheet8: TTabSheet
          Caption = 'XML file'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 225
            Height = 597
            Align = alLeft
            TabOrder = 0
            object TPanel
              Left = 1
              Top = 1
              Width = 223
              Height = 41
              Align = alTop
              TabOrder = 0
              object btnRunDlXml: TButton
                Left = 8
                Top = 8
                Width = 75
                Height = 25
                Caption = 'Run'
                TabOrder = 0
                OnClick = btnRunDlXmlClick
              end
              object edOwnerNumber: TEdit
                Left = 89
                Top = 10
                Width = 121
                Height = 21
                TabOrder = 1
              end
            end
          end
          object Panel3: TPanel
            Left = 225
            Top = 0
            Width = 891
            Height = 597
            Align = alClient
            TabOrder = 1
            object memXmlFile: TMemo
              Left = 1
              Top = 42
              Width = 889
              Height = 554
              Align = alClient
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Style = []
              Lines.Strings = (
                'Memo1')
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
              WordWrap = False
            end
            object TPanel
              Left = 1
              Top = 1
              Width = 889
              Height = 41
              Align = alTop
              TabOrder = 1
              DesignSize = (
                889
                41)
              object clabXmlFile: TLabel
                Left = 5
                Top = 11
                Width = 42
                Height = 13
                Caption = 'Xml File :'
              end
              object edXMLFile: TsFilenameEdit
                Left = 64
                Top = 10
                Width = 815
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                AutoSize = False
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                MaxLength = 255
                ParentFont = False
                TabOrder = 0
                Text = ''
                CheckOnExit = True
                GlyphMode.Blend = 0
                GlyphMode.Grayed = False
                OnAfterDialog = edXMLFileAfterDialog
                DefaultExt = '.xml'
                Filter = 'All files (*.*)|*.*|XML|*.xml'
              end
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'Data'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Splitter1: TSplitter
            Left = 569
            Top = 32
            Height = 565
            ExplicitLeft = 360
            ExplicitTop = 184
            ExplicitHeight = 100
          end
          object TPanel
            Left = 0
            Top = 0
            Width = 1116
            Height = 32
            Align = alTop
            TabOrder = 0
            object DBEdit1: TDBEdit
              Left = 736
              Top = 6
              Width = 121
              Height = 21
              DataField = 'bookingnumber'
              DataSource = mBookingsDS
              TabOrder = 0
              Visible = False
              OnChange = DBEdit1Change
            end
            object CheckBox1: TCheckBox
              Left = 8
              Top = 8
              Width = 97
              Height = 17
              Caption = 'filtered'
              TabOrder = 1
              OnClick = CheckBox1Click
            end
            object btnToExcel: TButton
              Left = 76
              Top = 2
              Width = 96
              Height = 25
              Caption = 'All To Excel'
              TabOrder = 2
              OnClick = btnToExcelClick
            end
            object Button5: TButton
              Left = 178
              Top = 2
              Width = 96
              Height = 25
              Caption = 'All To Roomer'
              TabOrder = 3
              OnClick = Button5Click
            end
            object chkOccupied: TCheckBox
              Left = 297
              Top = 9
              Width = 97
              Height = 17
              Caption = 'Check Occupied'
              TabOrder = 4
            end
            object Button6: TButton
              Left = 410
              Top = 1
              Width = 96
              Height = 25
              Caption = 'Test integrety'
              TabOrder = 5
              OnClick = Button6Click
            end
          end
          object Panel4: TPanel
            Left = 0
            Top = 32
            Width = 569
            Height = 565
            Align = alLeft
            TabOrder = 1
            object Splitter4: TSplitter
              Left = 1
              Top = 289
              Width = 567
              Height = 3
              Cursor = crVSplit
              Align = alTop
              ExplicitWidth = 279
            end
            object Splitter5: TSplitter
              Left = 297
              Top = 292
              Height = 272
              ExplicitLeft = 328
              ExplicitTop = 384
              ExplicitHeight = 100
            end
            object Panel10: TPanel
              Left = 1
              Top = 1
              Width = 567
              Height = 288
              Align = alTop
              TabOrder = 0
              object Label11: TLabel
                Left = 1
                Top = 1
                Width = 135
                Height = 13
                Align = alTop
                Caption = 'bookings / reservations'
                Color = clHotLight
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
              end
              object grBookings: TcxGrid
                Left = 1
                Top = 14
                Width = 565
                Height = 273
                Align = alClient
                TabOrder = 0
                object tvBookings: TcxGridDBTableView
                  Navigator.Buttons.CustomButtons = <>
                  Navigator.Buttons.PriorPage.Visible = False
                  Navigator.Buttons.NextPage.Visible = False
                  Navigator.Buttons.Insert.Visible = False
                  Navigator.Buttons.Append.Visible = False
                  Navigator.Buttons.Delete.Visible = False
                  Navigator.Buttons.Edit.Visible = False
                  Navigator.Buttons.Post.Visible = False
                  Navigator.Buttons.Cancel.Visible = False
                  Navigator.Buttons.Refresh.Visible = False
                  Navigator.Buttons.SaveBookmark.Visible = False
                  Navigator.Buttons.GotoBookmark.Visible = False
                  Navigator.InfoPanel.Visible = True
                  Navigator.Visible = True
                  DataController.DataSource = mBookingsDS
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsView.GroupByBox = False
                  object tvBookingsbookingnumber: TcxGridDBColumn
                    DataBinding.FieldName = 'bookingnumber'
                    Width = 100
                  end
                  object tvBookingsownerNumber: TcxGridDBColumn
                    DataBinding.FieldName = 'ownerNumber'
                    Width = 100
                  end
                  object tvBookingsbookingTypeCode: TcxGridDBColumn
                    DataBinding.FieldName = 'bookingTypeCode'
                    Width = 100
                  end
                  object tvBookingsname: TcxGridDBColumn
                    DataBinding.FieldName = 'name'
                    Width = 100
                  end
                  object tvBookingsdescription: TcxGridDBColumn
                    DataBinding.FieldName = 'description'
                    Width = 100
                  end
                  object tvBookingsreference: TcxGridDBColumn
                    DataBinding.FieldName = 'reference'
                    Width = 100
                  end
                  object tvBookingstravelAgentBookingId: TcxGridDBColumn
                    DataBinding.FieldName = 'travelAgentBookingId'
                    Width = 100
                  end
                  object tvBookingsdateFrom: TcxGridDBColumn
                    DataBinding.FieldName = 'dateFrom'
                    Width = 100
                  end
                  object tvBookingsdateTo: TcxGridDBColumn
                    DataBinding.FieldName = 'dateTo'
                    Width = 100
                  end
                  object tvBookingscolor: TcxGridDBColumn
                    DataBinding.FieldName = 'color'
                    Width = 100
                  end
                  object tvBookingscustomer: TcxGridDBColumn
                    DataBinding.FieldName = 'customer'
                    Width = 100
                  end
                  object tvBookingsphone: TcxGridDBColumn
                    DataBinding.FieldName = 'phone'
                    Width = 100
                  end
                  object tvBookingsemail: TcxGridDBColumn
                    DataBinding.FieldName = 'email'
                    Width = 100
                  end
                  object tvBookingsbookingConfirmed: TcxGridDBColumn
                    DataBinding.FieldName = 'bookingConfirmed'
                    Width = 100
                  end
                  object tvBookingsconfirmationDeadline: TcxGridDBColumn
                    DataBinding.FieldName = 'confirmationDeadline'
                    Width = 100
                  end
                  object tvBookingsoneInvoiceForAllRooms: TcxGridDBColumn
                    DataBinding.FieldName = 'oneInvoiceForAllRooms'
                    Width = 100
                  end
                  object tvBookingsseperateExtrasInvoice: TcxGridDBColumn
                    DataBinding.FieldName = 'seperateExtrasInvoice'
                    Width = 100
                  end
                  object tvBookingspaymentType: TcxGridDBColumn
                    DataBinding.FieldName = 'paymentType'
                    Width = 100
                  end
                  object tvBookingsdiscount: TcxGridDBColumn
                    DataBinding.FieldName = 'discount'
                    Width = 100
                  end
                  object tvBookingscurrencyCode: TcxGridDBColumn
                    DataBinding.FieldName = 'currencyCode'
                    Width = 100
                  end
                  object tvBookingscountryCode: TcxGridDBColumn
                    DataBinding.FieldName = 'countryCode'
                    Width = 100
                  end
                  object tvBookingsexchange: TcxGridDBColumn
                    DataBinding.FieldName = 'exchange'
                    Width = 100
                  end
                  object tvBookingserr: TcxGridDBColumn
                    DataBinding.FieldName = 'err'
                    Width = 150
                  end
                end
                object lvBookings: TcxGridLevel
                  GridView = tvBookings
                end
              end
            end
            object Panel11: TPanel
              Left = 1
              Top = 292
              Width = 296
              Height = 272
              Align = alLeft
              TabOrder = 1
              object Label12: TLabel
                Left = 1
                Top = 1
                Width = 94
                Height = 13
                Align = alTop
                Caption = 'Participant / Guests'
                Color = clHotLight
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                Transparent = True
              end
              object grParticipant: TcxGrid
                Left = 1
                Top = 14
                Width = 294
                Height = 257
                Align = alClient
                TabOrder = 0
                object tvParticipant: TcxGridDBTableView
                  Navigator.Buttons.CustomButtons = <>
                  Navigator.Buttons.PriorPage.Visible = False
                  Navigator.Buttons.NextPage.Visible = False
                  Navigator.Buttons.Insert.Visible = False
                  Navigator.Buttons.Delete.Visible = False
                  Navigator.Buttons.Edit.Visible = False
                  Navigator.Buttons.Post.Visible = False
                  Navigator.Buttons.Cancel.Visible = False
                  Navigator.Buttons.Refresh.Visible = False
                  Navigator.Buttons.SaveBookmark.Visible = False
                  Navigator.Buttons.GotoBookmark.Visible = False
                  Navigator.InfoPanel.Visible = True
                  Navigator.Visible = True
                  DataController.DataSource = mParticipantsDS
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsView.GroupByBox = False
                  object tvParticipantbookingNumber: TcxGridDBColumn
                    DataBinding.FieldName = 'bookingNumber'
                    Width = 80
                  end
                  object tvParticipantnumber: TcxGridDBColumn
                    DataBinding.FieldName = 'number'
                    Width = 80
                  end
                  object tvParticipantname: TcxGridDBColumn
                    DataBinding.FieldName = 'name'
                    Width = 80
                  end
                  object tvParticipantcountryCode: TcxGridDBColumn
                    DataBinding.FieldName = 'countryCode'
                    Width = 80
                  end
                  object tvParticipantresourceCode: TcxGridDBColumn
                    DataBinding.FieldName = 'resourceCode'
                    Width = 80
                  end
                end
                object lvParticipant: TcxGridLevel
                  GridView = tvParticipant
                end
              end
            end
            object Panel12: TPanel
              Left = 300
              Top = 292
              Width = 268
              Height = 272
              Align = alClient
              TabOrder = 2
              object Panel13: TPanel
                Left = 1
                Top = 1
                Width = 266
                Height = 270
                Align = alClient
                TabOrder = 0
                object Label13: TLabel
                  Left = 1
                  Top = 1
                  Width = 98
                  Height = 13
                  Align = alTop
                  Caption = 'BookingSaleLines'
                  Color = clHotLight
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWhite
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentColor = False
                  ParentFont = False
                  Transparent = True
                end
                object grBookingSaleLines: TcxGrid
                  Left = 1
                  Top = 14
                  Width = 264
                  Height = 255
                  Align = alClient
                  TabOrder = 0
                  object tvBookingSaleLines: TcxGridDBTableView
                    Navigator.Buttons.CustomButtons = <>
                    Navigator.Buttons.PriorPage.Visible = False
                    Navigator.Buttons.NextPage.Visible = False
                    Navigator.Buttons.Insert.Visible = False
                    Navigator.Buttons.Delete.Visible = False
                    Navigator.Buttons.Edit.Visible = False
                    Navigator.Buttons.Post.Visible = False
                    Navigator.Buttons.Cancel.Visible = False
                    Navigator.Buttons.Refresh.Visible = False
                    Navigator.Buttons.SaveBookmark.Visible = False
                    Navigator.Buttons.GotoBookmark.Visible = False
                    Navigator.InfoPanel.Visible = True
                    Navigator.Visible = True
                    DataController.DataSource = mBookingSaleLinesDS
                    DataController.Summary.DefaultGroupSummaryItems = <>
                    DataController.Summary.FooterSummaryItems = <>
                    DataController.Summary.SummaryGroups = <>
                    OptionsView.GroupByBox = False
                    object tvBookingSaleLinesbookingNumber: TcxGridDBColumn
                      DataBinding.FieldName = 'bookingNumber'
                      Width = 100
                    end
                    object tvBookingSaleLinescurrencyCode: TcxGridDBColumn
                      DataBinding.FieldName = 'currencyCode'
                      Width = 100
                    end
                    object tvBookingSaleLinesexchange: TcxGridDBColumn
                      DataBinding.FieldName = 'exchange'
                      Width = 100
                    end
                    object tvBookingSaleLinesitemCode: TcxGridDBColumn
                      DataBinding.FieldName = 'itemCode'
                      Width = 100
                    end
                    object tvBookingSaleLinesresourceCode: TcxGridDBColumn
                      DataBinding.FieldName = 'resourceCode'
                      Width = 100
                    end
                    object tvBookingSaleLinessalesPerson: TcxGridDBColumn
                      DataBinding.FieldName = 'salesPerson'
                      Width = 100
                    end
                    object tvBookingSaleLinescustomer: TcxGridDBColumn
                      DataBinding.FieldName = 'customer'
                      Width = 100
                    end
                    object tvBookingSaleLinesresourceGroup: TcxGridDBColumn
                      DataBinding.FieldName = 'resourceGroup'
                      Width = 100
                    end
                    object tvBookingSaleLinespriceID: TcxGridDBColumn
                      DataBinding.FieldName = 'priceID'
                      Width = 100
                    end
                    object tvBookingSaleLinesquantity: TcxGridDBColumn
                      DataBinding.FieldName = 'quantity'
                      Width = 100
                    end
                    object tvBookingSaleLinesincludedInPrice: TcxGridDBColumn
                      DataBinding.FieldName = 'includedInPrice'
                      Width = 100
                    end
                    object tvBookingSaleLinesdateFrom: TcxGridDBColumn
                      DataBinding.FieldName = 'dateFrom'
                      Width = 100
                    end
                    object tvBookingSaleLinesdateTo: TcxGridDBColumn
                      DataBinding.FieldName = 'dateTo'
                      Width = 100
                    end
                    object tvBookingSaleLinesaddTime: TcxGridDBColumn
                      DataBinding.FieldName = 'addTime'
                      Width = 100
                    end
                    object tvBookingSaleLinesitemPrice: TcxGridDBColumn
                      DataBinding.FieldName = 'itemPrice'
                      Width = 100
                    end
                    object tvBookingSaleLinesitemDiscount: TcxGridDBColumn
                      DataBinding.FieldName = 'itemDiscount'
                      Width = 100
                    end
                    object tvBookingSaleLinesitemDiscountPercent: TcxGridDBColumn
                      DataBinding.FieldName = 'itemDiscountPercent'
                      Width = 100
                    end
                    object tvBookingSaleLinesitemPriceWithTax: TcxGridDBColumn
                      DataBinding.FieldName = 'itemPriceWithTax'
                      Width = 100
                    end
                    object tvBookingSaleLinesitemDiscountWithTax: TcxGridDBColumn
                      DataBinding.FieldName = 'itemDiscountWithTax'
                      Width = 100
                    end
                    object tvBookingSaleLinesitemDescription: TcxGridDBColumn
                      DataBinding.FieldName = 'itemDescription'
                      Width = 100
                    end
                    object tvBookingSaleLinesinvoiceStatus: TcxGridDBColumn
                      DataBinding.FieldName = 'invoiceStatus'
                      Width = 100
                    end
                    object tvBookingSaleLinessoHeadRecId: TcxGridDBColumn
                      DataBinding.FieldName = 'soHeadRecId'
                      Width = 100
                    end
                    object tvBookingSaleLinesitemPriceForeign: TcxGridDBColumn
                      DataBinding.FieldName = 'itemPriceForeign'
                      Width = 100
                    end
                    object tvBookingSaleLinesitemPriceForeignWithTax: TcxGridDBColumn
                      DataBinding.FieldName = 'itemPriceForeignWithTax'
                      Width = 100
                    end
                    object tvBookingSaleLinesmBookingSaleLinesField25: TcxGridDBColumn
                      DataBinding.FieldName = 'mBookingSaleLinesField25'
                      Width = 100
                    end
                    object tvBookingSaleLinesmBookingSaleLinesField26: TcxGridDBColumn
                      DataBinding.FieldName = 'mBookingSaleLinesField26'
                      Width = 100
                    end
                  end
                  object lvBookingSaleLines: TcxGridLevel
                    GridView = tvBookingSaleLines
                  end
                end
              end
            end
          end
          object Panel5: TPanel
            Left = 572
            Top = 32
            Width = 544
            Height = 565
            Align = alClient
            TabOrder = 2
            object Splitter2: TSplitter
              Left = 1
              Top = 313
              Width = 542
              Height = 3
              Cursor = crVSplit
              Align = alTop
              ExplicitWidth = 255
            end
            object Panel6: TPanel
              Left = 1
              Top = 1
              Width = 542
              Height = 312
              Align = alTop
              Caption = 'Panel6'
              TabOrder = 0
              object PageControl4: TPageControl
                Left = 1
                Top = 1
                Width = 540
                Height = 310
                ActivePage = TabSheet10
                Align = alClient
                TabOrder = 0
                object TabSheet10: TTabSheet
                  Caption = '-'
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object Label14: TLabel
                    Left = 0
                    Top = 0
                    Width = 116
                    Height = 13
                    Align = alTop
                    Caption = 'Resourcebookings / '
                    Color = clHotLight
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWhite
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = [fsBold]
                    ParentColor = False
                    ParentFont = False
                    Transparent = True
                  end
                  object grResourceBookings: TcxGrid
                    Left = 0
                    Top = 13
                    Width = 532
                    Height = 269
                    Align = alClient
                    TabOrder = 0
                    object tvResourceBookings: TcxGridDBTableView
                      Navigator.Buttons.CustomButtons = <>
                      Navigator.Buttons.PriorPage.Visible = False
                      Navigator.Buttons.NextPage.Visible = False
                      Navigator.Buttons.Insert.Visible = False
                      Navigator.Buttons.Delete.Visible = False
                      Navigator.Buttons.Edit.Visible = False
                      Navigator.Buttons.Post.Visible = False
                      Navigator.Buttons.Cancel.Visible = False
                      Navigator.Buttons.Refresh.Visible = False
                      Navigator.Buttons.SaveBookmark.Visible = False
                      Navigator.Buttons.GotoBookmark.Visible = False
                      Navigator.InfoPanel.Visible = True
                      Navigator.Visible = True
                      DataController.DataSource = mResourceBookingsDS
                      DataController.Summary.DefaultGroupSummaryItems = <>
                      DataController.Summary.FooterSummaryItems = <>
                      DataController.Summary.SummaryGroups = <>
                      OptionsView.GroupByBox = False
                      object tvResourceBookingsbookingNumber: TcxGridDBColumn
                        DataBinding.FieldName = 'bookingNumber'
                        Width = 77
                      end
                      object tvResourceBookingsdateFrom: TcxGridDBColumn
                        DataBinding.FieldName = 'dateFrom'
                        Width = 100
                      end
                      object tvResourceBookingsdateTo: TcxGridDBColumn
                        DataBinding.FieldName = 'dateTo'
                        Width = 100
                      end
                      object tvResourceBookingsresourceGroup: TcxGridDBColumn
                        DataBinding.FieldName = 'resourceGroup'
                        Width = 100
                      end
                      object tvResourceBookingscolor: TcxGridDBColumn
                        DataBinding.FieldName = 'color'
                        Width = 100
                      end
                      object tvResourceBookingsreserved: TcxGridDBColumn
                        DataBinding.FieldName = 'reserved'
                        Width = 100
                      end
                      object tvResourceBookingsconfirmed: TcxGridDBColumn
                        DataBinding.FieldName = 'confirmed'
                        Width = 100
                      end
                    end
                    object lvResourceBookings: TcxGridLevel
                      GridView = tvResourceBookings
                    end
                  end
                end
                object TabSheet11: TTabSheet
                  Caption = 'Memo'
                  ImageIndex = 1
                  object Label15: TLabel
                    Left = 0
                    Top = 0
                    Width = 532
                    Height = 13
                    Align = alTop
                    Caption = 'Memos /'
                    Color = clHotLight
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWhite
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = [fsBold]
                    ParentColor = False
                    ParentFont = False
                    Transparent = True
                    ExplicitWidth = 50
                  end
                  object Label16: TLabel
                    Left = 0
                    Top = 105
                    Width = 532
                    Height = 13
                    Align = alTop
                    Caption = 'memoText'
                    ExplicitWidth = 50
                  end
                  object Panel14: TPanel
                    Left = 0
                    Top = 13
                    Width = 532
                    Height = 92
                    Align = alTop
                    TabOrder = 0
                    object Label17: TLabel
                      Left = 32
                      Top = 12
                      Width = 54
                      Height = 13
                      Caption = 'Memoname'
                    end
                    object Label18: TLabel
                      Left = 33
                      Top = 36
                      Width = 30
                      Height = 13
                      Caption = 'miscId'
                    end
                    object Label19: TLabel
                      Left = 33
                      Top = 63
                      Width = 34
                      Height = 13
                      Caption = 'pageId'
                    end
                    object DBEdit2: TDBEdit
                      Left = 120
                      Top = 6
                      Width = 385
                      Height = 21
                      DataField = 'memoName'
                      DataSource = mMemosDS
                      TabOrder = 0
                    end
                    object DBEdit3: TDBEdit
                      Left = 120
                      Top = 33
                      Width = 385
                      Height = 21
                      DataField = 'miscId'
                      DataSource = mMemosDS
                      TabOrder = 1
                    end
                    object DBEdit4: TDBEdit
                      Left = 120
                      Top = 60
                      Width = 385
                      Height = 21
                      DataField = 'pageId'
                      DataSource = mMemosDS
                      TabOrder = 2
                    end
                  end
                  object DBMemo4: TDBMemo
                    Left = 0
                    Top = 118
                    Width = 532
                    Height = 164
                    Align = alClient
                    DataField = 'memoText'
                    DataSource = mMemosDS
                    TabOrder = 1
                  end
                end
              end
            end
            object Panel7: TPanel
              Left = 1
              Top = 316
              Width = 542
              Height = 248
              Align = alClient
              TabOrder = 1
              object Splitter3: TSplitter
                Left = 249
                Top = 1
                Height = 246
                ExplicitLeft = 272
                ExplicitTop = 40
                ExplicitHeight = 100
              end
              object Panel8: TPanel
                Left = 1
                Top = 1
                Width = 248
                Height = 246
                Align = alLeft
                Caption = 'Panel8'
                TabOrder = 0
                object Label20: TLabel
                  Left = 1
                  Top = 1
                  Width = 46
                  Height = 13
                  Align = alTop
                  Caption = 'Prices / '
                  Color = clHotLight
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWhite
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentColor = False
                  ParentFont = False
                  Transparent = True
                end
                object grPrices: TcxGrid
                  Left = 1
                  Top = 14
                  Width = 246
                  Height = 231
                  Align = alClient
                  TabOrder = 0
                  object tvPrices: TcxGridDBTableView
                    Navigator.Buttons.CustomButtons = <>
                    Navigator.Buttons.PriorPage.Visible = False
                    Navigator.Buttons.NextPage.Visible = False
                    Navigator.Buttons.Insert.Visible = False
                    Navigator.Buttons.Delete.Visible = False
                    Navigator.Buttons.Edit.Visible = False
                    Navigator.Buttons.Post.Visible = False
                    Navigator.Buttons.Cancel.Visible = False
                    Navigator.Buttons.Refresh.Visible = False
                    Navigator.Buttons.SaveBookmark.Visible = False
                    Navigator.Buttons.GotoBookmark.Visible = False
                    Navigator.InfoPanel.Visible = True
                    Navigator.Visible = True
                    DataController.DataSource = mPricesDS
                    DataController.Summary.DefaultGroupSummaryItems = <>
                    DataController.Summary.FooterSummaryItems = <>
                    DataController.Summary.SummaryGroups = <>
                    OptionsView.GroupByBox = False
                    object tvPricesbookingNumber: TcxGridDBColumn
                      DataBinding.FieldName = 'bookingNumber'
                      Width = 50
                    end
                    object tvPricespriceID: TcxGridDBColumn
                      DataBinding.FieldName = 'priceID'
                      Width = 50
                    end
                    object tvPricescount: TcxGridDBColumn
                      DataBinding.FieldName = 'count'
                      Width = 50
                    end
                    object tvPricesallocated: TcxGridDBColumn
                      DataBinding.FieldName = 'allocated'
                      Width = 50
                    end
                    object tvPricesdateFrom: TcxGridDBColumn
                      DataBinding.FieldName = 'dateFrom'
                      Width = 50
                    end
                    object tvPricesdateTo: TcxGridDBColumn
                      DataBinding.FieldName = 'dateTo'
                      Width = 50
                    end
                  end
                  object lvPrices: TcxGridLevel
                    GridView = tvPrices
                  end
                end
              end
              object Panel9: TPanel
                Left = 252
                Top = 1
                Width = 289
                Height = 246
                Align = alClient
                Caption = 'Panel9'
                TabOrder = 1
                object Label21: TLabel
                  Left = 1
                  Top = 1
                  Width = 176
                  Height = 13
                  Align = alTop
                  Caption = 'Alloactions / roomreservations'
                  Color = clHotLight
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWhite
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentColor = False
                  ParentFont = False
                  Transparent = True
                end
                object grAllocations: TcxGrid
                  Left = 1
                  Top = 14
                  Width = 287
                  Height = 231
                  Align = alClient
                  TabOrder = 0
                  object tvAllocations: TcxGridDBTableView
                    Navigator.Buttons.CustomButtons = <>
                    Navigator.Buttons.Images = DImages.cxLargeImagesFlat
                    Navigator.Buttons.PriorPage.Visible = False
                    Navigator.Buttons.NextPage.Visible = False
                    Navigator.Buttons.Insert.Visible = False
                    Navigator.Buttons.Delete.Visible = False
                    Navigator.Buttons.Edit.Visible = False
                    Navigator.Buttons.Post.Visible = False
                    Navigator.Buttons.Refresh.Visible = False
                    Navigator.Buttons.SaveBookmark.Visible = False
                    Navigator.Buttons.GotoBookmark.Visible = False
                    Navigator.InfoPanel.Visible = True
                    Navigator.Visible = True
                    DataController.DataSource = mAllocationsDS
                    DataController.Summary.DefaultGroupSummaryItems = <>
                    DataController.Summary.FooterSummaryItems = <>
                    DataController.Summary.SummaryGroups = <>
                    OptionsView.GroupByBox = False
                    object tvAllocationsbookingNumber: TcxGridDBColumn
                      DataBinding.FieldName = 'bookingNumber'
                      Width = 50
                    end
                    object tvAllocationsdateFrom: TcxGridDBColumn
                      DataBinding.FieldName = 'dateFrom'
                      Width = 50
                    end
                    object tvAllocationsdateTo: TcxGridDBColumn
                      DataBinding.FieldName = 'dateTo'
                      Width = 50
                    end
                    object tvAllocationsresourceCode: TcxGridDBColumn
                      DataBinding.FieldName = 'resourceCode'
                      Width = 50
                    end
                    object tvAllocationsresourceGroup: TcxGridDBColumn
                      DataBinding.FieldName = 'resourceGroup'
                      Width = 50
                    end
                    object tvAllocationscolor: TcxGridDBColumn
                      DataBinding.FieldName = 'color'
                      Width = 50
                    end
                    object tvAllocationspriceID: TcxGridDBColumn
                      DataBinding.FieldName = 'priceID'
                      Width = 50
                    end
                  end
                  object lvAllocations: TcxGridLevel
                    GridView = tvAllocations
                  end
                end
              end
            end
          end
        end
        object TabSheet12: TTabSheet
          Caption = 'Rooms'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object TPanel
            Left = 0
            Top = 0
            Width = 1116
            Height = 32
            Align = alTop
            TabOrder = 0
            object btnGetRoomerRooms: TButton
              Left = 1
              Top = 2
              Width = 153
              Height = 25
              Caption = 'Get roomer Rooms'
              TabOrder = 0
              OnClick = btnGetRoomerRoomsClick
            end
            object btnSaveToCSV: TButton
              Left = 329
              Top = 1
              Width = 153
              Height = 25
              Caption = 'Save to CSV'
              TabOrder = 1
              OnClick = btnSaveToCSVClick
            end
            object btnLoadFromCSV: TButton
              Left = 488
              Top = 1
              Width = 153
              Height = 25
              Caption = 'Load from CSV'
              TabOrder = 2
              OnClick = btnLoadFromCSVClick
            end
            object btnGetImportRooms: TButton
              Left = 160
              Top = 2
              Width = 153
              Height = 25
              Caption = 'Get Import Rooms'
              TabOrder = 3
              OnClick = btnGetImportRoomsClick
            end
          end
          object grDrRooms: TcxGrid
            Left = 0
            Top = 32
            Width = 1116
            Height = 565
            Align = alClient
            TabOrder = 1
            object tvDrRooms: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              Navigator.InfoPanel.Visible = True
              Navigator.Visible = True
              DataController.DataSource = mRoomsDS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              object tvDrRoomsRoom: TcxGridDBColumn
                DataBinding.FieldName = 'Room'
              end
              object tvDrRoomsDescription: TcxGridDBColumn
                DataBinding.FieldName = 'Description'
              end
              object tvDrRoomsRoomType: TcxGridDBColumn
                DataBinding.FieldName = 'RoomType'
              end
              object tvDrRoomsimpRoom: TcxGridDBColumn
                DataBinding.FieldName = 'impRoom'
              end
              object tvDrRoomsimpRoomType: TcxGridDBColumn
                DataBinding.FieldName = 'impRoomType'
              end
            end
            object lvDrRooms: TcxGridLevel
              GridView = tvDrRooms
            end
          end
        end
        object Customers: TTabSheet
          Caption = 'Customers'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object TPanel
            Left = 0
            Top = 0
            Width = 1116
            Height = 73
            Align = alTop
            TabOrder = 0
            object Label22: TLabel
              Left = 341
              Top = 13
              Width = 45
              Height = 13
              Caption = 'CSV File :'
            end
            object Label23: TLabel
              Left = 8
              Top = 49
              Width = 86
              Height = 13
              Caption = 'Default PriceCode'
            end
            object Label24: TLabel
              Left = 187
              Top = 49
              Width = 99
              Height = 13
              Caption = 'Default Market Code'
            end
            object Label25: TLabel
              Left = 374
              Top = 49
              Width = 82
              Height = 13
              Caption = 'Default Currency'
            end
            object CustomerCSV: TsFilenameEdit
              Left = 394
              Top = 10
              Width = 375
              Height = 21
              AutoSize = False
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4473924
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              MaxLength = 255
              ParentFont = False
              TabOrder = 0
              Text = ''
              TextHint = 'Get customer file in csv format'
              CheckOnExit = True
              GlyphMode.Blend = 0
              GlyphMode.Grayed = False
              OnAfterDialog = CustomerCSVAfterDialog
              DefaultExt = 'csv'
              Filter = 'CSV|*.csv|All files (*.*)|*.*'
            end
            object Button1: TButton
              Left = 0
              Top = 9
              Width = 105
              Height = 25
              Caption = 'Save to file'
              TabOrder = 1
              OnClick = Button1Click
            end
            object Button2: TButton
              Left = 110
              Top = 9
              Width = 105
              Height = 25
              Caption = 'Load from file'
              TabOrder = 2
              OnClick = Button2Click
            end
            object Button3: TButton
              Left = 221
              Top = 8
              Width = 105
              Height = 25
              Caption = 'Clear'
              TabOrder = 3
              OnClick = Button3Click
            end
            object Button4: TButton
              Left = 778
              Top = 8
              Width = 105
              Height = 25
              Caption = 'Load To Roomer'
              TabOrder = 4
              OnClick = Button4Click
            end
            object edDefPcCode: TEdit
              Left = 100
              Top = 46
              Width = 65
              Height = 21
              TabOrder = 5
            end
            object edDefCustomerType: TEdit
              Left = 295
              Top = 46
              Width = 65
              Height = 21
              TabOrder = 6
            end
            object edDEfCurrency: TEdit
              Left = 467
              Top = 46
              Width = 65
              Height = 21
              TabOrder = 7
            end
          end
          object grCustomers: TcxGrid
            Left = 0
            Top = 73
            Width = 1116
            Height = 524
            Align = alClient
            TabOrder = 1
            object tvCustomers: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              Navigator.InfoPanel.Visible = True
              Navigator.Visible = True
              DataController.DataSource = mCustomersDS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              object tvCustomersId: TcxGridDBColumn
                DataBinding.FieldName = 'Id'
              end
              object tvCustomersNumer: TcxGridDBColumn
                DataBinding.FieldName = 'Numer'
                Width = 150
              end
              object tvCustomersHeiti: TcxGridDBColumn
                DataBinding.FieldName = 'Heiti'
                Width = 150
              end
              object tvCustomersHeimili: TcxGridDBColumn
                DataBinding.FieldName = 'Heimili'
                Width = 150
              end
              object tvCustomersPostnumer: TcxGridDBColumn
                DataBinding.FieldName = 'Postnumer'
                Width = 150
              end
              object tvCustomersstadur: TcxGridDBColumn
                DataBinding.FieldName = 'stadur'
                Width = 150
              end
              object tvCustomersLand: TcxGridDBColumn
                DataBinding.FieldName = 'Land'
                Width = 150
              end
              object tvCustomersKennitala: TcxGridDBColumn
                DataBinding.FieldName = 'Kennitala'
                Width = 150
              end
              object tvCustomersFlokkur: TcxGridDBColumn
                DataBinding.FieldName = 'Flokkur'
                Width = 150
              end
              object tvCustomerssimi: TcxGridDBColumn
                DataBinding.FieldName = 'simi'
                Width = 150
              end
              object tvCustomersGreidslumati: TcxGridDBColumn
                DataBinding.FieldName = 'Greidslumati'
                Width = 150
              end
              object tvCustomersnetfang: TcxGridDBColumn
                DataBinding.FieldName = 'netfang'
                Width = 150
              end
            end
            object lvCustomers: TcxGridLevel
              GridView = tvCustomers
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = 'Items'
          ImageIndex = 4
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object TPanel
            Left = 0
            Top = 0
            Width = 1116
            Height = 41
            Align = alTop
            TabOrder = 0
            object Label26: TLabel
              Left = 341
              Top = 13
              Width = 45
              Height = 13
              Caption = 'CSV File :'
            end
            object itemsCSV: TsFilenameEdit
              Left = 394
              Top = 10
              Width = 375
              Height = 21
              AutoSize = False
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4473924
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              MaxLength = 255
              ParentFont = False
              TabOrder = 0
              Text = ''
              TextHint = 'Get items file in csv format'
              CheckOnExit = True
              GlyphMode.Blend = 0
              GlyphMode.Grayed = False
              OnAfterDialog = itemsCSVAfterDialog
              DefaultExt = 'csv'
              Filter = 'CSV|*.csv|All files (*.*)|*.*'
            end
            object btnItemsSaveToFile: TButton
              Left = 0
              Top = 9
              Width = 105
              Height = 25
              Caption = 'Save to file'
              TabOrder = 1
              OnClick = Button1Click
            end
            object btnItemsLoadFromFile: TButton
              Left = 110
              Top = 9
              Width = 105
              Height = 25
              Caption = 'Load from file'
              TabOrder = 2
              OnClick = Button2Click
            end
            object btnItemsClear: TButton
              Left = 221
              Top = 8
              Width = 105
              Height = 25
              Caption = 'Clear'
              TabOrder = 3
              OnClick = Button3Click
            end
            object itemsLoadToRoomer: TButton
              Left = 775
              Top = 10
              Width = 105
              Height = 25
              Caption = 'Load To Roomer'
              TabOrder = 4
              OnClick = itemsLoadToRoomerClick
            end
          end
          object grItems: TcxGrid
            Left = 0
            Top = 41
            Width = 1116
            Height = 556
            Align = alClient
            TabOrder = 1
            object tvItems: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              Navigator.InfoPanel.Visible = True
              Navigator.Visible = True
              DataController.DataSource = mVorurDS
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              object tvItemsvorunumer: TcxGridDBColumn
                DataBinding.FieldName = 'vorunumer'
                Width = 120
              end
              object tvItemsvorulysing: TcxGridDBColumn
                DataBinding.FieldName = 'vorulysing'
                Width = 120
              end
              object tvItemsverdmvsk: TcxGridDBColumn
                DataBinding.FieldName = 'verdmvsk'
                Width = 120
              end
              object tvItemsvorufl: TcxGridDBColumn
                DataBinding.FieldName = 'vorufl'
                Width = 120
              end
              object tvItemsid: TcxGridDBColumn
                DataBinding.FieldName = 'id'
              end
            end
            object lvItems: TcxGridLevel
              GridView = tvItems
            end
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
    Left = 304
    Top = 648
  end
  object RwavGuestsDS: TDataSource
    Left = 664
    Top = 64
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
    Left = 480
    Top = 632
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
    Left = 584
    Top = 632
  end
  object DataSource2: TDataSource
    DataSet = kbmBookingComRes
    Left = 800
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
    Left = 400
    Top = 632
  end
  object DataSource1: TDataSource
    DataSet = kbmMemTable1
    Left = 544
    Top = 496
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
    Left = 128
    Top = 648
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
    Top = 640
  end
  object kbmReservationsDS: TDataSource
    DataSet = kbmReservations
    Left = 8
    Top = 648
  end
  object PopupMenu1: TPopupMenu
    Left = 120
    Top = 528
    object P1: TMenuItem
      Caption = 'Pharse'
      ShortCut = 16470
    end
  end
  object kbmRoomResDS: TDataSource
    DataSet = kbmRoomRes
    Left = 211
    Top = 648
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
    Left = 176
    Top = 648
  end
  object kbmRoomMapDS: TDataSource
    DataSet = kbmRoomMap
    Left = 256
    Top = 648
  end
  object mMemos: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'memoName'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'miscId'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'pageId'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'memoText'
        DataType = ftWideMemo
      end
      item
        Name = 'bookingNumber'
        DataType = ftWideString
        Size = 50
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
    DefaultFormat = kbmCSVStreamFormat2
    CommaTextFormat = kbmCSVStreamFormat2
    PersistentFormat = kbmCSVStreamFormat2
    AllDataFormat = kbmCSVStreamFormat2
    FormFormat = kbmCSVStreamFormat2
    Left = 104
    Top = 200
  end
  object mMemosDS: TDataSource
    DataSet = mMemos
    Left = 608
    Top = 64
  end
  object mParticipants: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'bookingNumber'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'number'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'name'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'countryCode'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'resourceCode'
        DataType = ftWideString
        Size = 100
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
    Left = 128
    Top = 152
  end
  object mParticipantsDS: TDataSource
    DataSet = mParticipants
    Left = 672
    Top = 8
  end
  object mBookingSaleLines: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'bookingNumber'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'currencyCode'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'exchange'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'itemCode'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'resourceCode'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'salesPerson'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'customer'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'resourceGroup'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'priceID'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'quantity'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'includedInPrice'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'dateFrom'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'dateTo'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'addTime'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'itemPrice'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'itemDiscount'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'itemDiscountPercent'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'itemPriceWithTax'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'itemDiscountWithTax'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'itemDescription'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'invoiceStatus'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'soHeadRecId'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'itemPriceForeign'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'itemPriceForeignWithTax'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'mBookingSaleLinesField25'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'mBookingSaleLinesField26'
        DataType = ftWideString
        Size = 100
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
    Left = 40
    Top = 296
  end
  object mBookingSaleLinesDS: TDataSource
    DataSet = mBookingSaleLines
    Left = 600
    Top = 65528
  end
  object mBookingsDS: TDataSource
    DataSet = mBookings
    Left = 728
    Top = 65528
  end
  object mBookings: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'bookingnumber'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'ownerNumber'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'bookingTypeCode'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'name'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'description'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'reference'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'travelAgentBookingId'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'dateFrom'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'dateTo'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'color'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'customer'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'phone'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'email'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'bookingConfirmed'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'confirmationDeadline'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'oneInvoiceForAllRooms'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'seperateExtrasInvoice'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'paymentType'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'discount'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'currencyCode'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'countryCode'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'exchange'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'err'
        DataType = ftString
        Size = 200
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
    Left = 40
    Top = 144
  end
  object mResourceBookings: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'dateFrom'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'dateTo'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'resourceGroup'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'color'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'reserved'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'confirmed'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'bookingNumber'
        DataType = ftWideString
        Size = 50
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
    Left = 40
    Top = 248
  end
  object mResourceBookingsDS: TDataSource
    DataSet = mResourceBookings
    Left = 952
    Top = 16
  end
  object mAllocations: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'bookingNumber'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'dateFrom'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'dateTo'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'resourceCode'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'resourceGroup'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'color'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'priceID'
        DataType = ftWideMemo
        Size = 100
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
    Left = 40
    Top = 200
  end
  object mAllocationsDS: TDataSource
    DataSet = mAllocations
    Left = 864
    Top = 8
  end
  object mPrices: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'bookingNumber'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'priceID'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'count'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'allocated'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'dateFrom'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'dateTo'
        DataType = ftWideString
        Size = 100
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
    Left = 280
    Top = 152
  end
  object mPricesDS: TDataSource
    DataSet = mPrices
    Left = 360
    Top = 336
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
        Size = 8
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'RoomType'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'impRoom'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'impRoomType'
        DataType = ftString
        Size = 40
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
    DefaultFormat = kbmCSVStreamFormat2
    CommaTextFormat = kbmCSVStreamFormat2
    PersistentFormat = kbmCSVStreamFormat2
    AllDataFormat = kbmCSVStreamFormat2
    FormFormat = kbmCSVStreamFormat2
    Left = 216
    Top = 152
  end
  object mRoomsDS: TDataSource
    DataSet = mRooms
    Left = 992
    Top = 8
  end
  object kbmCSVStreamFormat2: TkbmCSVStreamFormat
    CommentChar = #0
    EscapeChar = '%'
    DefaultStringFieldSize = 255
    CSVQuote = '"'
    CSVFieldDelimiter = ';'
    CSVRecordDelimiter = ';'
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
    Left = 800
  end
  object mCustomers: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Numer'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Heiti'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Heimili'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Postnumer'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'stadur'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Land'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Kennitala'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Flokkur'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'simi'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Greidslumati'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'netfang'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Id'
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
    DefaultFormat = kbmCSVStreamFormat2
    CommaTextFormat = kbmCSVStreamFormat2
    PersistentFormat = kbmCSVStreamFormat2
    AllDataFormat = kbmCSVStreamFormat2
    FormFormat = kbmCSVStreamFormat2
    Left = 176
    Top = 208
  end
  object mCustomersDS: TDataSource
    DataSet = mCustomers
    Left = 112
    Top = 424
  end
  object mVorur: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'vorunumer'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'vorulysing'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'verdmvsk'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'vorufl'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'id'
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
    Left = 240
    Top = 544
  end
  object mVorurDS: TDataSource
    DataSet = mVorur
    Left = 288
    Top = 544
  end
end
