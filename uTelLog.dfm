object FrmTelLog: TFrmTelLog
  Left = 1282
  Top = 310
  Caption = 'FrmTelLog'
  ClientHeight = 535
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TsPanel
    Left = 0
    Top = 0
    Width = 854
    Height = 120
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      854
      120)
    object cxGroupBox1: TsGroupBox
      Left = 13
      Top = 12
      Width = 191
      Height = 85
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      object cxLabel1: TsLabel
        Left = 3
        Top = 20
        Width = 48
        Height = 17
        AutoSize = False
        Caption = 'From :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labTo: TsLabel
        Left = 7
        Top = 48
        Width = 43
        Height = 17
        AutoSize = False
        Caption = 'To :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object dtDateFrom: TsDateEdit
        Left = 56
        Top = 20
        Width = 121
        Height = 21
        AutoSize = False
        EditMask = '!99/99/9999;1; '
        MaxLength = 10
        TabOrder = 0
        Text = '  .  .    '
        OnChange = dtDateFromChange
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
      object dtDateTo: TsDateEdit
        Left = 56
        Top = 47
        Width = 121
        Height = 21
        AutoSize = False
        EditMask = '!99/99/9999;1; '
        MaxLength = 10
        TabOrder = 1
        Text = '  .  .    '
        OnChange = dtDateToChange
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
    object chkOneDay: TsCheckBox
      Left = 20
      Top = 7
      Width = 125
      Height = 20
      Caption = 'One day - Select date'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
      OnClick = chkOneDayPropertiesChange
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object btnRrShowReservation: TsButton
      Left = 20
      Top = 92
      Width = 80
      Height = 25
      Caption = 'Reservation'
      TabOrder = 2
      OnClick = btnRrShowReservationClick
      SkinData.SkinSection = 'BUTTON'
    end
    object cxButton4: TsButton
      Left = 102
      Top = 92
      Width = 80
      Height = 25
      Caption = 'Guests'
      TabOrder = 3
      OnClick = cxButton4Click
      SkinData.SkinSection = 'BUTTON'
    end
    object cxButton2: TsButton
      Left = 185
      Top = 92
      Width = 80
      Height = 25
      Caption = 'Invoices'
      DropDownMenu = mnuFinishedInv
      TabOrder = 4
      SkinData.SkinSection = 'BUTTON'
    end
    object btnExcel: TsButton
      Left = 271
      Top = 92
      Width = 80
      Height = 25
      Caption = 'Excel'
      TabOrder = 5
      OnClick = btnExcelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnRefresh: TsButton
      Left = 217
      Top = 13
      Width = 80
      Height = 25
      Caption = 'Refresh'
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 6
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnExit: TsButton
      Left = 761
      Top = 13
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 27
      Images = DImages.PngImageList1
      TabOrder = 7
      OnClick = btnExitClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object dxStatusBar1: TsStatusBar
    Left = 0
    Top = 515
    Width = 854
    Height = 20
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object Grid: TcxGrid
    Left = 0
    Top = 120
    Width = 854
    Height = 395
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    object tvTelLog: TcxGridDBTableView
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
      DataController.DataSource = TelLogDS
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
      object tvTelLogRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object tvTelLogID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Visible = False
      end
      object tvTelLogCallStart: TcxGridDBColumn
        Caption = 'Call start time'
        DataBinding.FieldName = 'CallStart'
        Width = 102
      end
      object tvTelLogConnectedTimeSec: TcxGridDBColumn
        Caption = 'Duration Sec'
        DataBinding.FieldName = 'ConnectedTimeSec'
      end
      object tvTelLogConnectedTime: TcxGridDBColumn
        Caption = 'Duration'
        DataBinding.FieldName = 'ConnectedTime'
        Width = 56
      end
      object tvTelLogRingTime: TcxGridDBColumn
        Caption = 'Ring Time'
        DataBinding.FieldName = 'RingTime'
      end
      object tvTelLogCaller: TcxGridDBColumn
        Caption = 'Caller '
        DataBinding.FieldName = 'Caller'
        Width = 112
      end
      object tvTelLogDirection: TcxGridDBColumn
        DataBinding.FieldName = 'Direction'
        Width = 27
      end
      object tvTelLogisInternal: TcxGridDBColumn
        DataBinding.FieldName = 'isInternal'
      end
      object tvTelLogCalledNumber: TcxGridDBColumn
        Caption = 'Called Number'
        DataBinding.FieldName = 'CalledNumber'
        Width = 106
      end
      object tvTelLogDialledNumber: TcxGridDBColumn
        Caption = 'Dialled Number'
        DataBinding.FieldName = 'DialledNumber'
        Width = 100
      end
      object tvTelLogAccount: TcxGridDBColumn
        DataBinding.FieldName = 'Account'
        Visible = False
      end
      object tvTelLogCallId: TcxGridDBColumn
        DataBinding.FieldName = 'CallId'
        Visible = False
      end
      object tvTelLogContinuation: TcxGridDBColumn
        DataBinding.FieldName = 'Continuation'
        Visible = False
      end
      object tvTelLogParty1Device: TcxGridDBColumn
        DataBinding.FieldName = 'Party1Device'
        Visible = False
      end
      object tvTelLogParty1Name: TcxGridDBColumn
        DataBinding.FieldName = 'Party1Name'
        Visible = False
        Width = 125
      end
      object tvTelLogParty2Device: TcxGridDBColumn
        DataBinding.FieldName = 'Party2Device'
        Visible = False
        Width = 79
      end
      object tvTelLogParty2Name: TcxGridDBColumn
        DataBinding.FieldName = 'Party2Name'
        Visible = False
        Width = 195
      end
      object tvTelLogHoldTime: TcxGridDBColumn
        DataBinding.FieldName = 'HoldTime'
        Visible = False
      end
      object tvTelLogParkTime: TcxGridDBColumn
        DataBinding.FieldName = 'ParkTime'
        Visible = False
      end
      object tvTelLogAuthValid: TcxGridDBColumn
        DataBinding.FieldName = 'AuthValid'
        Visible = False
      end
      object tvTelLogAuthCode: TcxGridDBColumn
        DataBinding.FieldName = 'AuthCode'
        Visible = False
      end
      object tvTelLogUserCharged: TcxGridDBColumn
        DataBinding.FieldName = 'UserCharged'
        Visible = False
      end
      object tvTelLogCallCharge: TcxGridDBColumn
        DataBinding.FieldName = 'CallCharge'
        Visible = False
      end
      object tvTelLogCurrency: TcxGridDBColumn
        DataBinding.FieldName = 'Currency'
        Visible = False
      end
      object tvTelLogAmountAtLastUserChange: TcxGridDBColumn
        DataBinding.FieldName = 'AmountAtLastUserChange'
        Visible = False
      end
      object tvTelLogCallUnits: TcxGridDBColumn
        DataBinding.FieldName = 'CallUnits'
        Visible = False
      end
      object tvTelLogUnitsAtLastUserChange: TcxGridDBColumn
        DataBinding.FieldName = 'UnitsAtLastUserChange'
        Visible = False
      end
      object tvTelLogCostPerUnit: TcxGridDBColumn
        DataBinding.FieldName = 'CostPerUnit'
        Visible = False
      end
      object tvTelLogMarkUp: TcxGridDBColumn
        DataBinding.FieldName = 'MarkUp'
        Visible = False
      end
      object tvTelLogExternalTargetingCause: TcxGridDBColumn
        DataBinding.FieldName = 'ExternalTargetingCause'
        Visible = False
      end
      object tvTelLogExternalTargeterId: TcxGridDBColumn
        DataBinding.FieldName = 'ExternalTargeterId'
        Visible = False
        Width = 106
      end
      object tvTelLogExternalTargetedNumber: TcxGridDBColumn
        DataBinding.FieldName = 'ExternalTargetedNumber'
        Visible = False
      end
      object tvTelLogRoom: TcxGridDBColumn
        DataBinding.FieldName = 'Room'
        Width = 58
      end
      object tvTelLogDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Width = 141
      end
      object tvTelLogReservation: TcxGridDBColumn
        DataBinding.FieldName = 'Reservation'
      end
      object tvTelLogRoomReservation: TcxGridDBColumn
        DataBinding.FieldName = 'RoomReservation'
      end
      object tvTelLogInvoiceNumber: TcxGridDBColumn
        DataBinding.FieldName = 'InvoiceNumber'
        Width = 86
      end
      object tvTelLogPriceRule: TcxGridDBColumn
        DataBinding.FieldName = 'PriceRule'
      end
      object tvTelLogPriceGroup: TcxGridDBColumn
        DataBinding.FieldName = 'PriceGroup'
      end
      object tvTelLogminutePrice: TcxGridDBColumn
        DataBinding.FieldName = 'minutePrice'
      end
      object tvTelLogstartPrice: TcxGridDBColumn
        DataBinding.FieldName = 'startPrice'
      end
      object tvTelLogchargedTime: TcxGridDBColumn
        DataBinding.FieldName = 'chargedTime'
      end
      object tvTelLogChargedAmount: TcxGridDBColumn
        DataBinding.FieldName = 'ChargedAmount'
      end
      object tvTelLogImportRefrence: TcxGridDBColumn
        DataBinding.FieldName = 'ImportRefrence'
      end
      object tvTelLogRecordSource: TcxGridDBColumn
        DataBinding.FieldName = 'RecordSource'
      end
      object tvTelLogLogDateTime: TcxGridDBColumn
        Caption = 'Date Logged'
        DataBinding.FieldName = 'LogDateTime'
      end
    end
    object lvTelLog: TcxGridLevel
      GridView = tvTelLog
    end
  end
  object TelLogDS: TDataSource
    DataSet = mTelLog
    Left = 848
    Top = 32
  end
  object mTelLog: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 800
    Top = 24
    object mTelLogID: TIntegerField
      FieldName = 'ID'
    end
    object mTelLogLogDateTime: TDateTimeField
      FieldName = 'LogDateTime'
    end
    object mTelLogCallStart: TDateTimeField
      FieldName = 'CallStart'
    end
    object mTelLogConnectedTime: TStringField
      FieldName = 'ConnectedTime'
      Size = 8
    end
    object mTelLogRingTime: TIntegerField
      FieldName = 'RingTime'
    end
    object mTelLogCaller: TStringField
      FieldName = 'Caller'
      Size = 50
    end
    object mTelLogDirection: TStringField
      FieldName = 'Direction'
      Size = 1
    end
    object mTelLogCalledNumber: TStringField
      FieldName = 'CalledNumber'
      Size = 100
    end
    object mTelLogDialledNumber: TStringField
      FieldName = 'DialledNumber'
      Size = 100
    end
    object mTelLogAccount: TStringField
      FieldName = 'Account'
      Size = 50
    end
    object mTelLogisInternal: TBooleanField
      FieldName = 'isInternal'
    end
    object mTelLogCallId: TIntegerField
      FieldName = 'CallId'
    end
    object mTelLogContinuation: TBooleanField
      FieldName = 'Continuation'
    end
    object mTelLogParty1Device: TStringField
      FieldName = 'Party1Device'
    end
    object mTelLogParty1Name: TStringField
      FieldName = 'Party1Name'
      Size = 50
    end
    object mTelLogParty2Device: TStringField
      FieldName = 'Party2Device'
    end
    object mTelLogParty2Name: TStringField
      FieldName = 'Party2Name'
      Size = 50
    end
    object mTelLogHoldTime: TIntegerField
      FieldName = 'HoldTime'
    end
    object mTelLogParkTime: TIntegerField
      FieldName = 'ParkTime'
    end
    object mTelLogAuthValid: TBooleanField
      FieldName = 'AuthValid'
    end
    object mTelLogAuthCode: TStringField
      FieldName = 'AuthCode'
      Size = 50
    end
    object mTelLogUserCharged: TStringField
      FieldName = 'UserCharged'
      Size = 50
    end
    object mTelLogCallCharge: TFloatField
      FieldName = 'CallCharge'
    end
    object mTelLogCurrency: TStringField
      FieldName = 'Currency'
      Size = 10
    end
    object mTelLogAmountAtLastUserChange: TFloatField
      FieldName = 'AmountAtLastUserChange'
    end
    object mTelLogCallUnits: TIntegerField
      FieldName = 'CallUnits'
    end
    object mTelLogUnitsAtLastUserChange: TIntegerField
      FieldName = 'UnitsAtLastUserChange'
    end
    object mTelLogCostPerUnit: TIntegerField
      FieldName = 'CostPerUnit'
    end
    object mTelLogMarkUp: TIntegerField
      FieldName = 'MarkUp'
    end
    object mTelLogExternalTargetingCause: TStringField
      FieldName = 'ExternalTargetingCause'
    end
    object mTelLogExternalTargeterId: TStringField
      FieldName = 'ExternalTargeterId'
      Size = 50
    end
    object mTelLogExternalTargetedNumber: TStringField
      FieldName = 'ExternalTargetedNumber'
    end
    object mTelLogRoom: TStringField
      FieldName = 'Room'
      Size = 15
    end
    object mTelLogReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mTelLogRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mTelLogInvoiceNumber: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object mTelLogPriceRule: TStringField
      FieldName = 'PriceRule'
      Size = 15
    end
    object mTelLogPriceGroup: TStringField
      FieldName = 'PriceGroup'
      Size = 15
    end
    object mTelLogminutePrice: TFloatField
      FieldName = 'minutePrice'
    end
    object mTelLogstartPrice: TFloatField
      FieldName = 'startPrice'
    end
    object mTelLogchargedTime: TIntegerField
      FieldName = 'chargedTime'
    end
    object mTelLogChargedAmount: TFloatField
      FieldName = 'ChargedAmount'
    end
    object mTelLogImportRefrence: TStringField
      FieldName = 'ImportRefrence'
    end
    object mTelLogRecordSource: TStringField
      FieldName = 'RecordSource'
      Size = 50
    end
    object mTelLogConnectedTimeSec: TIntegerField
      FieldName = 'ConnectedTimeSec'
    end
    object mTelLogDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
  end
  object mnuFinishedInv: TPopupMenu
    Left = 672
    Top = 56
    object mnuThisRoom: TMenuItem
      Caption = 'Closed this Room'
      OnClick = mnuThisRoomClick
    end
    object mnuThisreservation: TMenuItem
      Caption = 'Closed this reservation'
      OnClick = mnuThisreservationClick
    end
    object OpenthisRoom1: TMenuItem
      Caption = 'Open this Room'
      OnClick = OpenthisRoom1Click
    end
    object OpenGroupInvoice1: TMenuItem
      Caption = 'Open Group Invoice'
      OnClick = OpenGroupInvoice1Click
    end
  end
end
