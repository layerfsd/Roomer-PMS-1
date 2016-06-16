object frmChangeRRdates: TfrmChangeRRdates
  Left = 1072
  Top = 281
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Change room reservation dates'
  ClientHeight = 347
  ClientWidth = 617
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TsPanel
    Left = 0
    Top = 314
    Width = 617
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      617
      33)
    object btnCancel: TsButton
      Left = 502
      Top = 5
      Width = 107
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object pbProgress: TsProgressBar
      Left = 7
      Top = 6
      Width = 474
      Height = 23
      Position = 50
      TabOrder = 1
      Visible = False
      SkinData.SkinSection = 'GAUGE'
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 165
    Width = 617
    Height = 149
    Align = alClient
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object gbrNextRR: TsGroupBox
      Left = 310
      Top = 6
      Width = 299
      Height = 125
      Caption = 'Next Reservation'
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object labNextName: TsLabel
        Left = 8
        Top = 20
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
      object labNextGuest: TsLabel
        Left = 8
        Top = 39
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
      object LMDSimpleLabel3: TsLabel
        Left = 75
        Top = 60
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Arrival :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object LMDSimpleLabel4: TsLabel
        Left = 58
        Top = 81
        Width = 56
        Height = 13
        Alignment = taRightJustify
        Caption = 'Departure :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object LMDSimpleLabel5: TsLabel
        Left = 76
        Top = 101
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Status :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labNextArrival: TsLabel
        Left = 122
        Top = 60
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
      object labNextDeparture: TsLabel
        Left = 122
        Top = 81
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
      object labNextStatus: TsLabel
        Left = 122
        Top = 101
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
      object labNextDays: TsLabel
        Left = 187
        Top = 60
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
    end
    object gbrLastRR: TsGroupBox
      Left = 11
      Top = 6
      Width = 295
      Height = 125
      Caption = 'Previous reservation'
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object labLastName: TsLabel
        Left = 8
        Top = 20
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
      object labLastGuest: TsLabel
        Left = 8
        Top = 36
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
      object LMDSimpleLabel6: TsLabel
        Left = 75
        Top = 60
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Arrival :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object LMDSimpleLabel7: TsLabel
        Left = 57
        Top = 81
        Width = 56
        Height = 13
        Alignment = taRightJustify
        Caption = 'Departure :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object LMDSimpleLabel8: TsLabel
        Left = 75
        Top = 101
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Status :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object LabLastArrival: TsLabel
        Left = 122
        Top = 60
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
      object labLastDeparture: TsLabel
        Left = 122
        Top = 81
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
      object labLastStatus: TsLabel
        Left = 122
        Top = 101
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
      object labLastDays: TsLabel
        Left = 187
        Top = 60
        Width = 4
        Height = 13
        Caption = '-'
      end
    end
  end
  object LMDSimplePanel1: TsPanel
    Left = 0
    Top = 0
    Width = 617
    Height = 165
    Align = alTop
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object gbxReservationsDates: TsGroupBox
      Left = 7
      Top = 6
      Width = 299
      Height = 147
      Caption = 'Change dates'
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      DesignSize = (
        299
        147)
      object labArrival: TsLabel
        Left = 64
        Top = 25
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Arrival :'
      end
      object labDeparture: TsLabel
        Left = 46
        Top = 51
        Width = 56
        Height = 13
        Alignment = taRightJustify
        Caption = 'Departure :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labNights: TsLabel
        Left = 65
        Top = 78
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Nights :'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object labWeekDayFrom: TsLabel
        Left = 208
        Top = 25
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
      object labWeekDayTo: TsLabel
        Left = 208
        Top = 51
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
      object labErr: TsLabel
        Left = 4
        Top = 92
        Width = 3
        Height = 13
        Color = clYellow
        ParentColor = False
        ParentFont = False
        Transparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object btnOK: TsButton
        Left = 220
        Top = 119
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'OK'
        ImageIndex = 82
        Images = DImages.PngImageList1
        ModalResult = 1
        TabOrder = 0
        OnClick = btnOKClick
        SkinData.SkinSection = 'BUTTON'
      end
      object dtArrival: TsDateEdit
        Left = 108
        Top = 21
        Width = 94
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
        OnChange = dtArrivalChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtDeparture: TsDateEdit
        Left = 108
        Top = 48
        Width = 94
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
        OnChange = dtDepartureChange
        OnDblClick = dtDepartureDblClick
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object edNightCount: TsSpinEdit
        Left = 108
        Top = 75
        Width = 96
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '1'
        OnChange = edNightCountChange
        SkinData.SkinSection = 'EDIT'
        MaxValue = 1000
        MinValue = 1
        Value = 1
      end
    end
    object sGroupBox1: TsGroupBox
      Left = 310
      Top = 6
      Width = 299
      Height = 147
      Caption = '.. or split reservation in two'
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      DesignSize = (
        299
        147)
      object Label1: TsLabel
        Left = 62
        Top = 24
        Width = 40
        Height = 13
        Alignment = taRightJustify
        Caption = 'Split at :'
      end
      object sLabel1: TsLabel
        Left = 200
        Top = 24
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
        Left = 108
        Top = 45
        Width = 152
        Height = 13
        Caption = 'First date in second reservation'
      end
      object labPart1: TsLabel
        Left = 27
        Top = 71
        Width = 4
        Height = 13
        Caption = '-'
      end
      object labPart2: TsLabel
        Left = 27
        Top = 92
        Width = 4
        Height = 13
        Caption = '-'
      end
      object sButton1: TsButton
        Left = 221
        Top = 119
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'OK'
        ImageIndex = 82
        Images = DImages.PngImageList1
        ModalResult = 1
        TabOrder = 0
        OnClick = sButton1Click
        SkinData.SkinSection = 'BUTTON'
      end
      object dtSplitAt: TsDateEdit
        Left = 108
        Top = 21
        Width = 86
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
        OnChange = dtSplitAtChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
  end
  object sSkinProvider1: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    FormHeader.AdditionalHeight = 0
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 32
    Top = 104
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 168
    Top = 168
  end
end
