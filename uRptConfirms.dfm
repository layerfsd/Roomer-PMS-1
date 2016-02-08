object frmrptConfirms: TfrmrptConfirms
  Left = 0
  Top = 0
  Caption = 'Confirms'
  ClientHeight = 556
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 458
    Height = 97
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      458
      97)
    object gbxSelectDates: TsGroupBox
      Left = 14
      Top = 9
      Width = 214
      Height = 80
      Caption = 'Select Dates'
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object labDateFrom: TsLabel
        Left = 8
        Top = 18
        Width = 79
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Date from :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labDateTo: TsLabel
        Left = 3
        Top = 39
        Width = 84
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Date to :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object chkOneday: TsCheckBox
        Left = 3
        Top = 60
        Width = 69
        Height = 19
        Caption = 'One day'
        TabOrder = 0
        OnClick = chkOnedayClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object dtDate: TsDateEdit
        Left = 93
        Top = 16
        Width = 113
        Height = 21
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  -  -    '
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        OnCloseUp = dtDateCloseUp
      end
      object dtDateTo: TsDateEdit
        Left = 93
        Top = 38
        Width = 113
        Height = 21
        AutoSize = False
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 2
        Text = '  -  -    '
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
    object btnRefresh: TsButton
      Left = 241
      Top = 10
      Width = 114
      Height = 24
      Caption = 'Refresh ALL'
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 1
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnExit: TsButton
      Left = 366
      Top = 9
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Exit'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 8
      TabOrder = 2
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object pageMain: TsPageControl
    Left = 0
    Top = 130
    Width = 458
    Height = 394
    ActivePage = tabConfirms
    Align = alClient
    TabOrder = 1
    SkinData.SkinSection = 'PAGECONTROL'
    object tabConfirms: TsTabSheet
      Caption = 'Confirms'
      Constraints.MinWidth = 450
      TabVisible = False
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 450
        Height = 1
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
      object grConfirms: TcxGrid
        Left = 0
        Top = 1
        Width = 450
        Height = 383
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvConfirms: TcxGridDBTableView
          OnDblClick = BtnOkClick
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Visible = True
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Visible = False
          Navigator.Buttons.Refresh.Visible = False
          Navigator.InfoPanel.Visible = True
          Navigator.Visible = True
          DataController.DataSource = ConfirmsDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Turnover'
              Column = tvConfirmsTurnover
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Payments'
              Column = tvConfirmsPayments
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Diff'
              Column = tvConfirmsDiff
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.AlwaysShowEditor = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.Indicator = True
          object tvConfirmsConfirmDate: TcxGridDBColumn
            DataBinding.FieldName = 'ConfirmDate'
            Options.Editing = False
          end
          object tvConfirmsselected: TcxGridDBColumn
            Caption = 'Selected'
            DataBinding.FieldName = 'selected'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Width = 52
          end
          object tvConfirmsTurnover: TcxGridDBColumn
            DataBinding.FieldName = 'Turnover'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvConfirmsTurnoverGetProperties
            Options.Editing = False
            Width = 91
          end
          object tvConfirmsPayments: TcxGridDBColumn
            DataBinding.FieldName = 'Payments'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvConfirmsTurnoverGetProperties
            Options.Editing = False
            Width = 98
          end
          object tvConfirmsDiff: TcxGridDBColumn
            DataBinding.FieldName = 'Diff'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvConfirmsTurnoverGetProperties
            Options.Editing = False
            Width = 106
          end
        end
        object lvConfirms: TcxGridLevel
          GridView = tvConfirms
        end
      end
    end
  end
  object panBtn: TsPanel
    Left = 0
    Top = 524
    Width = 458
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      458
      32)
    object btnCancel: TsButton
      Left = 370
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object BtnOk: TsButton
      Left = 280
      Top = 4
      Width = 84
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      OnClick = BtnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sPanel3: TsPanel
    Left = 0
    Top = 97
    Width = 458
    Height = 33
    Align = alTop
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    object btnExcelTurnover: TsButton
      Left = 5
      Top = 4
      Width = 80
      Height = 25
      Caption = 'Excel'
      ImageIndex = 132
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnExcelTurnoverClick
      SkinData.SkinSection = 'BUTTON'
    end
    object cxButton4: TsButton
      Left = 99
      Top = 4
      Width = 90
      Height = 25
      Caption = 'Select'
      ImageIndex = 83
      Images = DImages.PngImageList1
      TabOrder = 1
      OnClick = cxButton4Click
      SkinData.SkinSection = 'BUTTON'
    end
    object cxButton1: TsButton
      Left = 195
      Top = 4
      Width = 90
      Height = 25
      Caption = 'Select all'
      ImageIndex = 75
      Images = DImages.PngImageList1
      TabOrder = 2
      OnClick = cxButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object cxButton3: TsButton
      Left = 287
      Top = 4
      Width = 90
      Height = 25
      Caption = 'Deselect all'
      ImageIndex = 86
      Images = DImages.PngImageList1
      TabOrder = 3
      OnClick = cxButton3Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object kbmConfirms_: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ConfirmDate'
        DataType = ftDateTime
      end
      item
        Name = 'Turnover'
        DataType = ftFloat
      end
      item
        Name = 'Payments'
        DataType = ftFloat
      end
      item
        Name = 'Diff'
        DataType = ftFloat
      end
      item
        Name = 'selected'
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
    OnNewRecord = kbmConfirms_NewRecord
    Left = 88
    Top = 232
  end
  object ConfirmsDS: TDataSource
    DataSet = kbmConfirms_
    Left = 192
    Top = 232
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
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end
      item
        Properties.Strings = (
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\frmrptConfirms'
    StorageType = stRegistry
    Left = 86
    Top = 312
  end
end
