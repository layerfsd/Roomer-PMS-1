object frmGuestProfile2: TfrmGuestProfile2
  Left = 2968
  Top = 305
  Caption = 'RoomGuests'
  ClientHeight = 611
  ClientWidth = 974
  Color = clBtnFace
  Constraints.MinWidth = 671
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbMain: TsStatusBar
    Left = 0
    Top = 592
    Width = 974
    Height = 19
    Panels = <>
    SimplePanel = True
    SkinData.SkinSection = 'STATUSBAR'
  end
  object PanTop: TsPanel
    Left = 0
    Top = 0
    Width = 974
    Height = 410
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sPanel1: TsPanel
      Left = 1
      Top = 369
      Width = 972
      Height = 40
      Align = alBottom
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object btnInsert: TsButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 124
        Height = 32
        Hint = 'Add new record'
        Align = alLeft
        Caption = 'New'
        ImageIndex = 23
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnInsertClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnEdit: TsButton
        AlignWithMargins = True
        Left = 134
        Top = 4
        Width = 124
        Height = 32
        Hint = 'Edit current record'
        Align = alLeft
        Caption = 'Edit'
        ImageIndex = 25
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnEditClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnDelete: TsButton
        AlignWithMargins = True
        Left = 264
        Top = 4
        Width = 124
        Height = 32
        Hint = 'Delete current record'
        Align = alLeft
        Caption = 'Delete'
        ImageIndex = 24
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnDeleteClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnOther: TsButton
        AlignWithMargins = True
        Left = 394
        Top = 4
        Width = 142
        Height = 32
        Hint = 'Other actions - Select from menu'
        Align = alLeft
        Caption = 'Other actions'
        DropDownMenu = mnuOther
        ImageIndex = 76
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        Style = bsSplitButton
        TabOrder = 3
        OnClick = btnOtherClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClearAddress: TsButton
        AlignWithMargins = True
        Left = 542
        Top = 4
        Width = 133
        Height = 32
        Align = alLeft
        Caption = 'Clear Address'
        ImageIndex = 11
        Images = DImages.PngImageList1
        TabOrder = 4
        OnClick = btnClearAddressClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object sPanel3: TsPanel
      Left = 1
      Top = 1
      Width = 320
      Height = 368
      Align = alLeft
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      object Label61: TsLabel
        Left = 16
        Top = 109
        Width = 227
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Include room in National report :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labResNumbers: TsLabel
        Left = 9
        Top = 5
        Width = 5
        Height = 16
        Caption = '/'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sLabel3: TsLabel
        Left = 16
        Top = 131
        Width = 227
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Block user from moving to different room :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object grbReservation: TsGroupBox
        Left = 4
        Top = 18
        Width = 306
        Height = 78
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object labroom: TsLabel
          Left = 12
          Top = 8
          Width = 7
          Height = 16
          Caption = '2'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object labres: TsLabel
          Left = 12
          Top = 24
          Width = 7
          Height = 16
          Caption = '2'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edSurName: TsEdit
          Left = 12
          Top = 49
          Width = 285
          Height = 21
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = 'edSurName'
          SkinData.SkinSection = 'EDIT'
        end
      end
      object chkUseInNationalReport: TsCheckBox
        Left = 250
        Top = 109
        Width = 20
        Height = 18
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object sGroupBox3: TsGroupBox
        Left = 8
        Top = 163
        Width = 302
        Height = 57
        Caption = 'Create new reservation from this room'
        TabOrder = 2
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object sLabel1: TsLabel
          Left = 10
          Top = 24
          Width = 125
          Height = 13
          Alignment = taRightJustify
          Caption = 'Name of new reservation:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object btnConfirmNewReservation: TsSpeedButton
          Left = 242
          Top = 24
          Width = 48
          Height = 18
          Caption = 'Confirm'
          OnClick = btnConfirmNewReservationClick
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object edNewReservation: TsEdit
          Left = 138
          Top = 22
          Width = 101
          Height = 21
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 0
          SkinData.SkinSection = 'EDIT'
        end
      end
      object sGroupBox4: TsGroupBox
        Left = 5
        Top = 230
        Width = 304
        Height = 53
        Caption = 'Assign this reservation to another reservation'
        TabOrder = 3
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object sLabel2: TsLabel
          Left = 31
          Top = 24
          Width = 107
          Height = 13
          Alignment = taRightJustify
          Caption = 'Reservation number : '
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object btnGetCurrency: TsButton
          Left = 245
          Top = 21
          Width = 50
          Height = 20
          Caption = 'Confirm'
          TabOrder = 0
          OnClick = btnGetCurrencyClick
          SkinData.SkinSection = 'BUTTON'
        end
        object edNewRoomRes: TsSpinEdit
          Left = 141
          Top = 22
          Width = 101
          Height = 21
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          SkinData.SkinSection = 'EDIT'
          MaxValue = 0
          MinValue = 0
          Value = 0
        end
      end
      object sGroupBox6: TsGroupBox
        Left = 4
        Top = 295
        Width = 306
        Height = 68
        Caption = 'Room invoiceline descripton formula'
        TabOrder = 4
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object Label12: TsLabel
          Left = 9
          Top = 41
          Width = 177
          Height = 13
          Caption = '&& = Add guest name    -- = New text'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object edrrDescription: TsEdit
          Left = 9
          Top = 17
          Width = 285
          Height = 24
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
      end
      object chkBlockMove: TsCheckBox
        Left = 250
        Top = 131
        Width = 20
        Height = 18
        TabOrder = 5
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object sPanel4: TsPanel
      Left = 321
      Top = 1
      Width = 652
      Height = 368
      Align = alClient
      TabOrder = 2
      SkinData.SkinSection = 'PANEL'
      object sSplitter1: TsSplitter
        Left = 1
        Top = 168
        Width = 650
        Height = 6
        Cursor = crVSplit
        Align = alTop
        SkinData.SkinSection = 'SPLITTER'
        ExplicitWidth = 333
      end
      object sPanel2: TsPanel
        Left = 1
        Top = 1
        Width = 650
        Height = 41
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton1: TsButton
          Left = 5
          Top = 4
          Width = 160
          Height = 31
          Hint = 'Show reservation memos'
          Caption = 'Show reservation memos'
          ImageIndex = 72
          Images = DImages.PngImageList1
          ModalResult = 11
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = sButton1Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object sGroupBox1: TsGroupBox
        Left = 1
        Top = 42
        Width = 650
        Height = 126
        Align = alTop
        Caption = 'Notes for Room'
        TabOrder = 1
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object memRoomNotes: TcxMemo
          Left = 2
          Top = 15
          Align = alClient
          Lines.Strings = (
            'cxMemo1')
          ParentFont = False
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 0
          Height = 109
          Width = 646
        end
      end
      object sGroupBox2: TsGroupBox
        Left = 1
        Top = 174
        Width = 650
        Height = 193
        Align = alClient
        Caption = 'Notes for guest'
        TabOrder = 2
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object cxDBMemo1: TcxDBMemo
          Left = 2
          Top = 15
          Align = alClient
          DataBinding.DataField = 'Information'
          DataBinding.DataSource = DS
          ParentFont = False
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 0
          Height = 176
          Width = 646
        end
      end
    end
  end
  object grData: TcxGrid
    Left = 0
    Top = 410
    Width = 974
    Height = 149
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    ExplicitLeft = 1
    ExplicitTop = 411
    object tvData: TcxGridDBTableView
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
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Enabled = False
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = True
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      OnFocusedItemChanged = tvDataFocusedItemChanged
      DataController.DataSource = DS
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnSortingChanged = tvDataDataControllerSortingChanged
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.IncSearch = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      OptionsView.Indicator = True
      object tvDataRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object tvBtnSelectProfile: TcxGridDBColumn
        Caption = 'Select profile'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 31
            Kind = bkGlyph
          end>
        Properties.Images = DImages.PngImageList1
        Properties.ViewStyle = vsButtonsOnly
        Properties.OnButtonClick = tvSeLlistPropertiesButtonClick
        OnGetProperties = tvBtnSelectProfileGetProperties
        Options.ShowEditButtons = isebAlways
        Width = 42
      end
      object tvBtnNewProfile: TcxGridDBColumn
        Caption = 'Add to Profile'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 23
            Kind = bkGlyph
          end>
        Properties.Images = DImages.PngImageList1
        Properties.ViewStyle = vsButtonsOnly
        Properties.OnButtonClick = tvBtnNewProfilePropertiesButtonClick
        OnGetProperties = tvBtnNewProfileGetProperties
        Options.ShowEditButtons = isebAlways
        Width = 41
      end
      object tvBtnEdCurrProfile: TcxGridDBColumn
        Caption = 'Edit Profile'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 25
            Kind = bkGlyph
          end>
        Properties.Images = DImages.PngImageList1
        Properties.ViewStyle = vsButtonsOnly
        Properties.OnButtonClick = tvBtnEdCurrPropertiesButtonClick
        OnGetProperties = tvBtnEdCurrProfileGetProperties
        Options.ShowEditButtons = isebAlways
        Options.SortByDisplayText = isbtOff
        Options.Sorting = False
        Width = 39
      end
      object tvDataMainName: TcxGridDBColumn
        Caption = 'Is Contact'
        DataBinding.FieldName = 'MainName'
        Width = 45
      end
      object tvDataRoomReservation: TcxGridDBColumn
        DataBinding.FieldName = 'RoomReservation'
        Visible = False
      end
      object tvDataReservation: TcxGridDBColumn
        DataBinding.FieldName = 'Reservation'
        Visible = False
      end
      object tvDataName: TcxGridDBColumn
        DataBinding.FieldName = 'Name'
        Width = 172
      end
      object tvDataSurname: TcxGridDBColumn
        DataBinding.FieldName = 'Surname'
        Visible = False
        Width = 150
      end
      object tvDataPID: TcxGridDBColumn
        DataBinding.FieldName = 'PID'
        Width = 100
      end
      object tvDataCountry: TcxGridDBColumn
        DataBinding.FieldName = 'Country'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 31
            Kind = bkGlyph
          end>
        Properties.Images = DImages.PngImageList1
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = tvDataCountryPropertiesButtonClick
        Options.ShowEditButtons = isebAlways
        Width = 57
      end
      object tvDatatel1: TcxGridDBColumn
        DataBinding.FieldName = 'tel1'
        Width = 72
      end
      object tvDatatel2: TcxGridDBColumn
        DataBinding.FieldName = 'tel2'
        Width = 78
      end
      object tvDataEmail: TcxGridDBColumn
        DataBinding.FieldName = 'Email'
        Width = 100
      end
      object tvDataAddress1: TcxGridDBColumn
        DataBinding.FieldName = 'Address1'
        Width = 120
      end
      object tvDataAddress2: TcxGridDBColumn
        DataBinding.FieldName = 'Address2'
        Width = 120
      end
      object tvDataAddress3: TcxGridDBColumn
        DataBinding.FieldName = 'Address3'
        Width = 120
      end
      object tvDataAddress4: TcxGridDBColumn
        DataBinding.FieldName = 'Address4'
        Width = 120
      end
      object tvDataGuestType: TcxGridDBColumn
        DataBinding.FieldName = 'GuestType'
        Visible = False
        Width = 71
      end
      object tvDataInformation: TcxGridDBColumn
        DataBinding.FieldName = 'Information'
        Visible = False
      end
      object tvDataCustomer: TcxGridDBColumn
        DataBinding.FieldName = 'Customer'
        Visible = False
      end
      object tvDataID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Visible = False
      end
      object tvDataCompany: TcxGridDBColumn
        DataBinding.FieldName = 'Company'
        Visible = False
        Width = 163
      end
      object tvDataFax: TcxGridDBColumn
        DataBinding.FieldName = 'Fax'
      end
      object tvDataPersonsProfilesId: TcxGridDBColumn
        DataBinding.FieldName = 'PersonsProfilesId'
      end
      object tvDataPerson: TcxGridDBColumn
        DataBinding.FieldName = 'Person'
        Visible = False
      end
    end
    object lvData: TcxGridLevel
      GridView = tvData
    end
  end
  object Panel1: TsPanel
    Left = 0
    Top = 559
    Width = 974
    Height = 33
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      974
      33)
    object sButton2: TsButton
      Left = 886
      Top = 4
      Width = 84
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = sButton2Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton3: TsButton
      Left = 531
      Top = 2
      Width = 84
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      Visible = False
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object m_: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforePost = m_BeforePost
    AfterPost = m_AfterPost
    BeforeDelete = m_BeforeDelete
    OnNewRecord = m_NewRecord
    Left = 256
    Top = 272
    object m_Person: TIntegerField
      FieldName = 'Person'
    end
    object m_PID: TWideStringField
      FieldName = 'PID'
      Size = 15
    end
    object m_RoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object m_Reservation: TIntegerField
      FieldName = 'Reservation'
    end
    object m_Name: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
    object m_Surname: TWideStringField
      FieldName = 'Surname'
      Size = 100
    end
    object m_Address1: TWideStringField
      FieldName = 'Address1'
      Size = 100
    end
    object m_Address2: TWideStringField
      FieldName = 'Address2'
      Size = 100
    end
    object m_Address3: TWideStringField
      FieldName = 'Address3'
      Size = 100
    end
    object m_Address4: TWideStringField
      FieldName = 'Address4'
      Size = 100
    end
    object m_Country: TWideStringField
      FieldName = 'Country'
      Size = 2
    end
    object m_Company: TWideStringField
      FieldName = 'Company'
      Size = 100
    end
    object m_GuestType: TWideStringField
      FieldName = 'GuestType'
      Size = 5
    end
    object m_Information: TMemoField
      FieldName = 'Information'
      BlobType = ftMemo
    end
    object m_MainName: TBooleanField
      FieldName = 'MainName'
    end
    object m_Customer: TWideStringField
      FieldName = 'Customer'
      Size = 15
    end
    object m_ID: TIntegerField
      FieldName = 'ID'
    end
    object m_tel2: TWideStringField
      FieldName = 'tel2'
      Size = 31
    end
    object m_tel1: TWideStringField
      FieldName = 'tel1'
      Size = 31
    end
    object m_Fax: TWideStringField
      FieldName = 'Fax'
      Size = 31
    end
    object m_Email: TWideStringField
      FieldName = 'Email'
      Size = 100
    end
    object m_PersonsProfilesId: TIntegerField
      FieldName = 'PersonsProfilesId'
    end
  end
  object mnuOther: TPopupMenu
    Left = 616
    Top = 128
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      OnClick = mnuiPrintClick
    end
    object mnuiAllowGridEdit: TMenuItem
      Caption = 'Allow grid edit'
      Checked = True
      OnClick = mnuiAllowGridEditClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Export1: TMenuItem
      Caption = 'Export'
      object mnuiGridToExcel: TMenuItem
        Caption = 'Grid to Excel'
        OnClick = mnuiGridToExcelClick
      end
      object mnuiGridToHtml: TMenuItem
        Caption = 'Grid to HTML'
        OnClick = mnuiGridToHtmlClick
      end
      object mnuiGridToText: TMenuItem
        Caption = 'Grid to text'
        OnClick = mnuiGridToTextClick
      end
      object mnuiGridToXml: TMenuItem
        Caption = 'Grid to XML'
        OnClick = mnuiGridToXmlClick
      end
    end
  end
  object DS: TDataSource
    DataSet = m_
    Left = 216
    Top = 272
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = prLink_grData
    Version = 0
    Left = 656
    Top = 232
    object prLink_grData: TdxGridReportLink
      Active = True
      Component = grData
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
      ReportDocument.CreationDate = 42653.891623576390000000
      AssignedFormatValues = [fvDate, fvTime, fvPageNumber]
      BuiltInReportLink = True
    end
  end
  object StoreMain: TcxPropertiesStore
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
    StorageName = 'Software\Roomer\FormStatus\GuestProfile2'
    StorageType = stRegistry
    Left = 16
    Top = 448
  end
  object erGrid: TcxEditRepository
    Left = 704
    Top = 232
    object eriProfile: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end
        item
        end
        item
        end>
      Properties.Images = DImages.PngImageList1
      Properties.ViewStyle = vsButtonsOnly
    end
    object eriBtnSelectProfileVisable: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 32
          Kind = bkGlyph
        end>
      Properties.Images = DImages.PngImageList1
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = tvSeLlistPropertiesButtonClick
    end
    object eriBtnSelectProfileNotVisable: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 32
          Kind = bkGlyph
          Visible = False
        end>
      Properties.Images = DImages.PngImageList1
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = tvSeLlistPropertiesButtonClick
    end
    object eriBtnNewProfileVisible: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 23
          Kind = bkGlyph
        end>
      Properties.Images = DImages.PngImageList1
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = tvBtnNewProfilePropertiesButtonClick
    end
    object eriBtnNewProfileNotVisible: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 23
          Kind = bkGlyph
          Visible = False
        end>
      Properties.Images = DImages.PngImageList1
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = tvBtnNewProfilePropertiesButtonClick
    end
    object eriBtnEdCurrProfileNotVisible: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 25
          Kind = bkGlyph
          Visible = False
        end>
      Properties.Images = DImages.PngImageList1
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = tvBtnEdCurrPropertiesButtonClick
    end
    object eriBtnEdCurrProfileVisible: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 25
          Kind = bkGlyph
        end>
      Properties.Images = DImages.PngImageList1
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = tvBtnEdCurrPropertiesButtonClick
    end
  end
end
