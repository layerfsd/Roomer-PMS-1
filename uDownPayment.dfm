object frmDownPayment: TfrmDownPayment
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Downpayment'
  ClientHeight = 437
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TsPanel
    Left = 0
    Top = 404
    Width = 489
    Height = 33
    Align = alBottom
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 388
    DesignSize = (
      489
      33)
    object btnOk: TsButton
      Left = 285
      Top = 2
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 184
    end
    object btnCancel: TsButton
      Left = 386
      Top = 2
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 10
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 285
    end
  end
  object cxGroupBox1: TsGroupBox
    Left = 0
    Top = 0
    Width = 489
    Height = 112
    Align = alTop
    Caption = 'Amount'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    SkinData.SkinSection = 'GROUPBOX'
    ExplicitWidth = 388
    object labReservation: TsLabel
      Left = 96
      Top = 89
      Width = 6
      Height = 13
      Caption = '0'
      ParentFont = False
      Visible = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labRoomReservation: TsLabel
      Left = 174
      Top = 89
      Width = 6
      Height = 13
      Caption = '0'
      ParentFont = False
      Visible = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labInvoice: TsLabel
      Left = 249
      Top = 89
      Width = 6
      Height = 13
      Caption = '0'
      ParentFont = False
      Visible = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object labPayment: TsLabel
      Left = 102
      Top = 37
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payment :'
    end
    object labDescription: TsLabel
      Left = 91
      Top = 64
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
    end
    object sSpeedButton1: TsButton
      Left = 251
      Top = 34
      Width = 132
      Height = 21
      Caption = 'Get invoice balance'
      TabOrder = 2
      OnClick = sSpeedButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object edDescription: TsEdit
      Left = 157
      Top = 61
      Width = 226
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'Downpayment'
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
    object edAmount: TsCalcEdit
      Left = 157
      Top = 34
      Width = 88
      Height = 21
      AutoSize = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
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
    end
  end
  object sGroupBox1: TsGroupBox
    Left = 0
    Top = 112
    Width = 489
    Height = 81
    Align = alTop
    Caption = 'Notes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    SkinData.SkinSection = 'GROUPBOX'
    ExplicitWidth = 388
    object memNotes: TsMemo
      AlignWithMargins = True
      Left = 8
      Top = 21
      Width = 473
      Height = 52
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
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
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 384
      ExplicitHeight = 64
    end
  end
  object sScrollBox1: TsScrollBox
    Left = 0
    Top = 193
    Width = 489
    Height = 211
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PANEL_LOW'
    ExplicitWidth = 388
    object grPayType: TcxGrid
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 473
      Height = 195
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      TabOrder = 0
      LookAndFeel.NativeStyle = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 384
      ExplicitHeight = 207
      object tvPayType: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = PayTypeDS
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.AlwaysShowEditor = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvPayTypePayType: TcxGridDBColumn
          DataBinding.FieldName = 'PayType'
          Width = 65
        end
        object tvPayTypeDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 276
        end
        object tvPayTypePayGroup: TcxGridDBColumn
          DataBinding.FieldName = 'PayGroup'
          Width = 74
        end
      end
      object lvPayType: TcxGridLevel
        GridView = tvPayType
      end
    end
  end
  object kbmPayType: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'PayType'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'PayGroup'
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
    Left = 104
    Top = 256
  end
  object PayTypeDS: TDataSource
    DataSet = kbmPayType
    Left = 200
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
    StorageName = 'Software\Roomer\FormStatus\DownPaymentEdit'
    StorageType = stRegistry
    Left = 174
    Top = 304
  end
end
