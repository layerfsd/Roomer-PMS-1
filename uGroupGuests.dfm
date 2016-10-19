object frmGroupGuests: TfrmGroupGuests
  Left = 0
  Top = 0
  Caption = 'Group Guests'
  ClientHeight = 654
  ClientWidth = 1121
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1121
    Height = 113
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object rgrShow: TsRadioGroup
      Left = 14
      Top = 10
      Width = 147
      Height = 64
      Caption = 'Select'
      TabOrder = 0
      OnClick = rgrShowClick
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      ItemIndex = 1
      Items.Strings = (
        'All Guests'
        'Just Main Guests')
    end
    object chkCompactView: TsCheckBox
      Left = 14
      Top = 84
      Width = 87
      Height = 20
      Caption = 'Compact view'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = chkCompactViewClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 621
    Width = 1121
    Height = 33
    Align = alBottom
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1121
      33)
    object BtnOk: TsButton
      Left = 1029
      Top = 3
      Width = 83
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sPageControl1: TsPageControl
    Left = 0
    Top = 113
    Width = 1121
    Height = 508
    ActivePage = sTabSheet1
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PAGECONTROL'
    object sTabSheet1: TsTabSheet
      Caption = 'Guests'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 1113
        Height = 35
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnExcel: TsButton
          Left = 1
          Top = 1
          Width = 120
          Height = 33
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton1: TsButton
          Left = 121
          Top = 1
          Width = 120
          Height = 33
          Align = alLeft
          Caption = 'Notes'
          ImageIndex = 94
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = sButton1Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnExpand: TsButton
          Left = 601
          Top = 1
          Width = 120
          Height = 33
          Align = alLeft
          Caption = 'Expand'
          ImageIndex = 94
          TabOrder = 2
          Visible = False
          OnClick = btnExpandClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnCollapse: TsButton
          Left = 481
          Top = 1
          Width = 120
          Height = 33
          Align = alLeft
          Caption = 'Collapse'
          ImageIndex = 94
          TabOrder = 3
          Visible = False
          OnClick = btnCollapseClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnEdit: TsButton
          Left = 241
          Top = 1
          Width = 120
          Height = 33
          Hint = 'Edit current record'
          Align = alLeft
          Caption = 'Edit'
          ImageIndex = 25
          Images = DImages.PngImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = btnEditClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnOther: TsButton
          Left = 721
          Top = 1
          Width = 120
          Height = 33
          Hint = 'Other actions - Select from menu'
          Align = alLeft
          Caption = 'Other actions'
          DropDownMenu = mnuOther
          ImageIndex = 76
          Images = DImages.PngImageList1
          ParentShowHint = False
          ShowHint = True
          Style = bsSplitButton
          TabOrder = 5
          SkinData.SkinSection = 'BUTTON'
        end
        object btnClearAddress: TsButton
          Left = 361
          Top = 1
          Width = 120
          Height = 33
          Align = alLeft
          Caption = 'Clear Address'
          ImageIndex = 11
          Images = DImages.PngImageList1
          TabOrder = 6
          Visible = False
          OnClick = btnClearAddressClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grGuests: TcxGrid
        Left = 0
        Top = 35
        Width = 1113
        Height = 445
        Align = alClient
        TabOrder = 1
        ExplicitTop = 33
        object tvGuests: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.InfoPanel.Visible = True
          DataController.DataModeController.GridMode = True
          DataController.DataSource = kbmGuestsDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          OptionsView.BandHeaderEndEllipsis = True
          Bands = <
            item
              Caption = 'Main'
            end
            item
              Caption = 'Address'
            end
            item
              Caption = 'Contact'
            end
            item
              Caption = 'Other'
            end>
          object tvGuestsroomDetails: TcxGridDBBandedColumn
            DataBinding.FieldName = 'roomDetails'
            Visible = False
            Width = 250
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object tvGuestsroom: TcxGridDBBandedColumn
            DataBinding.FieldName = 'room'
            Width = 50
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object tvGueststitle: TcxGridDBBandedColumn
            Caption = 'Title'
            DataBinding.FieldName = 'title'
            Width = 50
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object tvGuestsname: TcxGridDBBandedColumn
            DataBinding.FieldName = 'name'
            MinWidth = 150
            Width = 210
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object tvGuestsMainName: TcxGridDBBandedColumn
            Caption = 'Main Name'
            DataBinding.FieldName = 'MainName'
            Options.Editing = False
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object tvGuestsRoomDescription: TcxGridDBBandedColumn
            Caption = 'Room Description'
            DataBinding.FieldName = 'RoomDescription'
            Options.Editing = False
            Width = 120
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object tvGuestsRoomType: TcxGridDBBandedColumn
            Caption = 'Room Type'
            DataBinding.FieldName = 'RoomType'
            Position.BandIndex = 0
            Position.ColIndex = 11
            Position.RowIndex = 0
          end
          object tvGuestsrrArrival: TcxGridDBBandedColumn
            Caption = 'Arrival'
            DataBinding.FieldName = 'rrArrival'
            Options.Editing = False
            Width = 64
            Position.BandIndex = 0
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object tvGuestsrrDeparture: TcxGridDBBandedColumn
            Caption = 'Departure'
            DataBinding.FieldName = 'rrDeparture'
            Options.Editing = False
            Width = 64
            Position.BandIndex = 0
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object tvGuestsStatusText: TcxGridDBBandedColumn
            Caption = 'Status'
            DataBinding.FieldName = 'StatusText'
            Options.Editing = False
            Width = 80
            Position.BandIndex = 0
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
          object tvGuestsnumGuests: TcxGridDBBandedColumn
            Caption = 'Guests'
            DataBinding.FieldName = 'numGuests'
            Options.Editing = False
            Position.BandIndex = 0
            Position.ColIndex = 9
            Position.RowIndex = 0
          end
          object tvGuestsBreakfast: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Breakfast'
            Position.BandIndex = 0
            Position.ColIndex = 10
            Position.RowIndex = 0
          end
          object tvGuestsTel1: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Tel1'
            Width = 100
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object tvGuestsTel2: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Tel2'
            Width = 100
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object tvGuestsFax: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Fax'
            Width = 100
            Position.BandIndex = 2
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object tvGuestsEmail: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Email'
            Width = 142
            Position.BandIndex = 2
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object tvGuestsAddress1: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Address1'
            Width = 100
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object tvGuestsAddress2: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Address2'
            Width = 100
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object tvGuestsAddress3: TcxGridDBBandedColumn
            Caption = 'Zip code'
            DataBinding.FieldName = 'Address3'
            Width = 100
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object tvGuestsAddress4: TcxGridDBBandedColumn
            Caption = 'City'
            DataBinding.FieldName = 'Address4'
            Width = 100
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object tvGuestsState: TcxGridDBBandedColumn
            DataBinding.FieldName = 'State'
            Width = 118
            Position.BandIndex = 1
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object tvGuestsCountry: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Country'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.CharCase = ecUpperCase
            Properties.OnButtonClick = tvGuestsCountryPropertiesButtonClick
            Properties.OnValidate = tvGuestsCountryPropertiesValidate
            Width = 64
            Position.BandIndex = 1
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object tvGuestsNationality: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Nationality'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.CharCase = ecUpperCase
            Properties.OnButtonClick = tvGuestsNationalityPropertiesButtonClick
            Properties.OnValidate = tvGuestsNationalityPropertiesValidate
            Width = 59
            Position.BandIndex = 1
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object tvGuestsCustomer: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Customer'
            Options.Editing = False
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 9
            Position.RowIndex = 0
          end
          object tvGuestsPID: TcxGridDBBandedColumn
            DataBinding.FieldName = 'PID'
            Width = 65
            Position.BandIndex = 3
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
          object tvGuestsDateOfBirth: TcxGridDBBandedColumn
            Caption = 'Date of Birth'
            DataBinding.FieldName = 'DateOfBirth'
            Width = 65
            Position.BandIndex = 3
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object tvGuestsPersonalIdentificationId: TcxGridDBBandedColumn
            Caption = 'Personal ID number'
            DataBinding.FieldName = 'PersonalIdentificationId'
            Width = 65
            Position.BandIndex = 3
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object tvGuestsSocialSecurityNumber: TcxGridDBBandedColumn
            Caption = 'Social Security Number'
            DataBinding.FieldName = 'SocialSecurityNumber'
            Width = 65
            Position.BandIndex = 3
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object tvGuestsId: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Id'
            Visible = False
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object tvGuestsPerson: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Person'
            Visible = False
            Position.BandIndex = 3
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object tvGuestsReservation: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Reservation'
            Visible = False
            Position.BandIndex = 3
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object tvGuestsRoomReservation: TcxGridDBBandedColumn
            DataBinding.FieldName = 'RoomReservation'
            Visible = False
            Position.BandIndex = 3
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object tvGuestsPersonsProfilesId: TcxGridDBBandedColumn
            DataBinding.FieldName = 'PersonsProfilesId'
            Visible = False
            Position.BandIndex = 3
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
        end
        object lvGuests: TcxGridLevel
          GridView = tvGuests
        end
      end
    end
  end
  object _kbmGuests: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = False
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Id'
        DataType = ftInteger
      end
      item
        Name = 'Person'
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
        Name = 'PersonsProfilesId'
        DataType = ftInteger
      end
      item
        Name = 'title'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'name'
        DataType = ftWideString
        Size = 200
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
        Name = 'Address4'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Country'
        DataType = ftWideString
        Size = 4
      end
      item
        Name = 'Tel1'
        DataType = ftWideString
        Size = 80
      end
      item
        Name = 'Tel2'
        DataType = ftWideString
        Size = 80
      end
      item
        Name = 'Fax'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Email'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Nationality'
        DataType = ftWideString
        Size = 4
      end
      item
        Name = 'PID'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'MainName'
        DataType = ftBoolean
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'State'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'PersonalIdentificationId'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'DateOfBirth'
        DataType = ftDateTime
      end
      item
        Name = 'SocialSecurityNumber'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'room'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'Roomtype'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'Breakfast'
        DataType = ftBoolean
      end
      item
        Name = 'rrArrival'
        DataType = ftDateTime
      end
      item
        Name = 'rrDeparture'
        DataType = ftDateTime
      end
      item
        Name = 'numGuests'
        DataType = ftInteger
      end
      item
        Name = 'RoomDescription'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'StatusText'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'roomDetails'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'CompanyName'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'CompVATNumber'
        DataType = ftWideString
        Size = 45
      end
      item
        Name = 'CompAddress1'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'CompAddress2'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'CompZip'
        DataType = ftWideString
        Size = 45
      end
      item
        Name = 'CompCity'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'CompCountry'
        DataType = ftWideString
        Size = 2
      end
      item
        Name = 'CompTel'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'CompFax'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'CompEmail'
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
    Left = 192
    Top = 336
  end
  object kbmGuestsDS: TDataSource
    DataSet = mGuests
    Left = 528
    Top = 336
  end
  object _kbmCompare: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Id'
        DataType = ftInteger
      end
      item
        Name = 'Person'
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
        Name = 'PersonsProfilesId'
        DataType = ftInteger
      end
      item
        Name = 'title'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'name'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'surname'
        DataType = ftWideString
        Size = 200
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
        Name = 'Address4'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Country'
        DataType = ftWideString
        Size = 4
      end
      item
        Name = 'Tel1'
        DataType = ftWideString
        Size = 80
      end
      item
        Name = 'Tel2'
        DataType = ftWideString
        Size = 80
      end
      item
        Name = 'Fax'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Email'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'GuestType'
        DataType = ftWideString
        Size = 5
      end
      item
        Name = 'Information'
        DataType = ftWideMemo
      end
      item
        Name = 'Nationality'
        DataType = ftWideString
        Size = 4
      end
      item
        Name = 'PID'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'MainName'
        DataType = ftBoolean
      end
      item
        Name = 'Company'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'Customer'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'CompanyName'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'CompAddress1'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'CompAddress2'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'CompZip'
        DataType = ftWideString
        Size = 45
      end
      item
        Name = 'CompCity'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'CompCountry'
        DataType = ftWideString
        Size = 4
      end
      item
        Name = 'CompTel'
        DataType = ftWideString
        Size = 80
      end
      item
        Name = 'CompEmail'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'CompFax'
        DataType = ftWideString
        Size = 80
      end
      item
        Name = 'CompVATNumber'
        DataType = ftWideString
        Size = 90
      end
      item
        Name = 'State'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'SourceID'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'PersonalIdentificationId'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'DateOfBirth'
        DataType = ftDateTime
      end
      item
        Name = 'SocialSecurityNumber'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'confirmDate'
        DataType = ftDateTime
      end
      item
        Name = 'lastUpdate'
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
    Left = 192
    Top = 408
  end
  object CompareDS: TDataSource
    Left = 528
    Top = 400
  end
  object FormStore: TcxPropertiesStore
    Components = <
      item
        Component = chkCompactView
        Properties.Strings = (
          'Action'
          'Align'
          'Alignment'
          'AlignWithMargins'
          'AllowGrayed'
          'Anchors'
          'AnimatEvents'
          'AutoSize'
          'BiDiMode'
          'Caption'
          'Checked'
          'Color'
          'Constraints'
          'Ctl3D'
          'Cursor'
          'CustomHint'
          'DisabledKind'
          'DragCursor'
          'DragKind'
          'DragMode'
          'Enabled'
          'Font'
          'GlyphChecked'
          'GlyphUnChecked'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'Images'
          'ImgChecked'
          'ImgUnchecked'
          'Left'
          'Margin'
          'Margins'
          'Name'
          'ParentBiDiMode'
          'ParentColor'
          'ParentCtl3D'
          'ParentCustomHint'
          'ParentFont'
          'ParentShowHint'
          'PopupMenu'
          'ReadOnly'
          'ShowFocus'
          'ShowHint'
          'SkinData'
          'State'
          'TabOrder'
          'TabStop'
          'Tag'
          'TextIndent'
          'Top'
          'VerticalAlign'
          'Visible'
          'Width'
          'WordWrap')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Position'
          'Top'
          'Width')
      end
      item
        Component = rgrShow
        Properties.Strings = (
          'Align'
          'AlignWithMargins'
          'Anchors'
          'AnimatEvents'
          'BiDiMode'
          'Caption'
          'CaptionLayout'
          'CaptionMargin'
          'CaptionSkin'
          'CaptionWidth'
          'CaptionYOffset'
          'Color'
          'Columns'
          'Constraints'
          'Ctl3D'
          'Cursor'
          'CustomHint'
          'DockSite'
          'DoubleBuffered'
          'DragCursor'
          'DragKind'
          'DragMode'
          'Enabled'
          'Font'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'ItemIndex'
          'Items'
          'Left'
          'Margins'
          'Name'
          'Padding'
          'ParentBackground'
          'ParentBiDiMode'
          'ParentColor'
          'ParentCtl3D'
          'ParentCustomHint'
          'ParentDoubleBuffered'
          'ParentFont'
          'ParentShowHint'
          'PopupMenu'
          'ShowFocus'
          'ShowHint'
          'SkinData'
          'StyleElements'
          'TabOrder'
          'TabStop'
          'Tag'
          'Top'
          'Touch'
          'Visible'
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\GroupGuests'
    StorageType = stRegistry
    Left = 787
    Top = 448
  end
  object grPrinter: TdxComponentPrinter
    CurrentLink = grPrinterLink1
    Version = 0
    Left = 792
    Top = 384
    object grPrinterLink1: TdxGridReportLink
      Component = grGuests
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
      BuiltInReportLink = True
    end
  end
  object mnuOther: TPopupMenu
    Images = DImages.PngImageList1
    Left = 792
    Top = 336
    object mnuiPrint: TMenuItem
      Caption = 'Print'
      OnClick = mnuiPrintClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Export1: TMenuItem
      Caption = 'Export'
      object mnuiGridToExcel: TMenuItem
        Caption = 'Grid to Excel'
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
  object mGuests: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 456
    Top = 328
    object mGuestsId: TIntegerField
      FieldName = 'Id'
    end
    object mGuestsPerson: TIntegerField
      FieldName = 'Person'
    end
    object mGuestsReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mGuestsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mGuestsPersonsProfilesId: TIntegerField
      FieldName = 'PersonsProfilesId'
    end
    object mGueststitle: TWideStringField
      FieldName = 'title'
      Size = 10
    end
    object mGuestsName: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
    object mGuestsAddress1: TWideStringField
      FieldName = 'Address1'
      Size = 100
    end
    object mGuestsAddress2: TWideStringField
      FieldName = 'Address2'
    end
    object mGuestsAddress3: TWideStringField
      FieldName = 'Address3'
      Size = 100
    end
    object mGuestsAddress4: TWideStringField
      FieldName = 'Address4'
      Size = 100
    end
    object mGuestsCountry: TWideStringField
      FieldName = 'Country'
      Size = 2
    end
    object mGueststel1: TWideStringField
      FieldName = 'tel1'
      Size = 40
    end
    object mGueststel2: TWideStringField
      FieldName = 'tel2'
      Size = 40
    end
    object mGuestsFax: TWideStringField
      FieldName = 'Fax'
      Size = 31
    end
    object mGuestsEmail: TWideStringField
      FieldName = 'Email'
      Size = 100
    end
    object mGuestsNationality: TWideStringField
      FieldName = 'Nationality'
      Size = 2
    end
    object mGuestsPID: TWideStringField
      FieldName = 'PID'
      Size = 30
    end
    object mGuestsMainName: TBooleanField
      FieldName = 'MainName'
    end
    object mGuestsCustomer: TWideStringField
      FieldName = 'Customer'
      Size = 15
    end
    object mGuestsState: TWideStringField
      FieldName = 'State'
      Size = 10
    end
    object mGuestsPersonalIdentificationId: TWideStringField
      FieldName = 'PersonalIdentificationId'
      Size = 50
    end
    object mGuestsDateOfBirth: TDateTimeField
      FieldName = 'DateOfBirth'
    end
    object mGuestsSocialSecurityNumber: TWideStringField
      FieldName = 'SocialSecurityNumber'
      Size = 45
    end
    object mGuestsRoom: TWideStringField
      FieldName = 'Room'
      Size = 8
    end
    object mGuestsBreakfast: TBooleanField
      FieldName = 'Breakfast'
    end
    object mGuestsrrArrival: TDateTimeField
      FieldName = 'rrArrival'
    end
    object mGuestsrrDeparture: TDateTimeField
      FieldName = 'rrDeparture'
    end
    object mGuestsnumGuests: TIntegerField
      FieldName = 'numGuests'
    end
    object mGuestsRoomDescription: TWideStringField
      FieldName = 'RoomDescription'
    end
    object mGuestsStatusText: TWideStringField
      FieldName = 'StatusText'
      Size = 45
    end
    object mGuestsroomDetails: TWideStringField
      FieldName = 'roomDetails'
      Size = 200
    end
    object mGuestsCompanyName: TStringField
      FieldName = 'CompanyName'
      Size = 100
    end
    object mGuestsCompVATNumber: TWideStringField
      FieldName = 'CompVATNumber'
      Size = 45
    end
    object mGuestsCompAddress1: TStringField
      FieldName = 'CompAddress1'
      Size = 100
    end
    object mGuestsCompAddress2: TWideStringField
      FieldName = 'CompAddress2'
      Size = 100
    end
    object mGuestsCompZip: TWideStringField
      FieldName = 'CompZip'
      Size = 100
    end
    object mGuestsCompCity: TWideStringField
      FieldName = 'CompCity'
      Size = 100
    end
    object mGuestsCompCountry: TWideStringField
      FieldName = 'CompCountry'
      Size = 2
    end
    object mGuestsCompTel: TWideStringField
      FieldName = 'CompTel'
      Size = 40
    end
    object mGuestsCompFax: TWideStringField
      FieldName = 'CompFax'
      Size = 40
    end
    object mGuestsCompEmail: TWideStringField
      FieldName = 'CompEmail'
      Size = 255
    end
    object mGuestsRoomType: TWideStringField
      FieldName = 'RoomType'
      Size = 10
    end
  end
  object mCompare: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 456
    Top = 392
    object IntegerField1: TIntegerField
      FieldName = 'Id'
    end
    object IntegerField2: TIntegerField
      FieldName = 'Person'
    end
    object IntegerField3: TIntegerField
      FieldName = 'Reservation'
    end
    object IntegerField4: TIntegerField
      FieldName = 'RoomReservation'
    end
    object IntegerField5: TIntegerField
      FieldName = 'PersonsProfilesId'
    end
    object WideStringField1: TWideStringField
      FieldName = 'title'
      Size = 10
    end
    object WideStringField2: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
    object WideStringField3: TWideStringField
      FieldName = 'Address1'
      Size = 100
    end
    object WideStringField4: TWideStringField
      FieldName = 'Address2'
    end
    object WideStringField5: TWideStringField
      FieldName = 'Address3'
      Size = 100
    end
    object WideStringField6: TWideStringField
      FieldName = 'Address4'
      Size = 100
    end
    object WideStringField7: TWideStringField
      FieldName = 'Country'
      Size = 2
    end
    object WideStringField8: TWideStringField
      FieldName = 'tel1'
      Size = 40
    end
    object WideStringField9: TWideStringField
      FieldName = 'tel2'
      Size = 40
    end
    object WideStringField10: TWideStringField
      FieldName = 'Fax'
      Size = 31
    end
    object WideStringField11: TWideStringField
      FieldName = 'Email'
      Size = 100
    end
    object WideStringField12: TWideStringField
      FieldName = 'Nationality'
      Size = 2
    end
    object WideStringField13: TWideStringField
      FieldName = 'PID'
      Size = 30
    end
    object BooleanField1: TBooleanField
      FieldName = 'MainName'
    end
    object WideStringField14: TWideStringField
      FieldName = 'Customer'
      Size = 15
    end
    object WideStringField15: TWideStringField
      FieldName = 'State'
      Size = 10
    end
    object WideStringField16: TWideStringField
      FieldName = 'PersonalIdentificationId'
      Size = 50
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DateOfBirth'
    end
    object WideStringField17: TWideStringField
      FieldName = 'SocialSecurityNumber'
      Size = 45
    end
    object WideStringField18: TWideStringField
      FieldName = 'Room'
      Size = 8
    end
    object BooleanField2: TBooleanField
      FieldName = 'Breakfast'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'rrArrival'
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'rrDeparture'
    end
    object IntegerField6: TIntegerField
      FieldName = 'numGuests'
    end
    object WideStringField19: TWideStringField
      FieldName = 'RoomDescription'
    end
    object WideStringField20: TWideStringField
      FieldName = 'StatusText'
      Size = 45
    end
    object WideStringField21: TWideStringField
      FieldName = 'roomDetails'
      Size = 200
    end
    object StringField1: TStringField
      FieldName = 'CompanyName'
      Size = 100
    end
    object WideStringField22: TWideStringField
      FieldName = 'CompVATNumber'
      Size = 45
    end
    object StringField2: TStringField
      FieldName = 'CompAddress1'
      Size = 100
    end
    object WideStringField23: TWideStringField
      FieldName = 'CompAddress2'
      Size = 100
    end
    object WideStringField24: TWideStringField
      FieldName = 'CompZip'
      Size = 100
    end
    object WideStringField25: TWideStringField
      FieldName = 'CompCity'
      Size = 100
    end
    object WideStringField26: TWideStringField
      FieldName = 'CompCountry'
      Size = 2
    end
    object WideStringField27: TWideStringField
      FieldName = 'CompTel'
      Size = 40
    end
    object WideStringField28: TWideStringField
      FieldName = 'CompFax'
      Size = 40
    end
    object WideStringField29: TWideStringField
      FieldName = 'CompEmail'
      Size = 255
    end
    object WideStringField30: TWideStringField
      FieldName = 'RoomType'
      Size = 10
    end
  end
  object ALWinInetHTTPClient1: TALWinInetHTTPClient
    AccessType = wHttpAt_Direct
    Left = 872
    Top = 296
  end
end
