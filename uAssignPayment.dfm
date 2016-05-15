object frmAssignPayment: TfrmAssignPayment
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Edit payment'
  ClientHeight = 501
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 450
    Height = 224
    Align = alTop
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sGroupBox2: TsGroupBox
      Left = 4
      Top = 4
      Width = 442
      Height = 216
      Align = alClient
      Caption = 'Payment details'
      Padding.Left = 3
      Padding.Top = 3
      Padding.Right = 3
      Padding.Bottom = 3
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      DesignSize = (
        442
        216)
      object clabReservation: TsLabel
        Left = 6
        Top = 19
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Reservation : '
      end
      object clabCustomer: TsLabel
        Left = 6
        Top = 36
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Customer : '
      end
      object clabArrivalDeparture: TsLabel
        Left = 6
        Top = 54
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Arrival-Departure : '
      end
      object clabRoom: TsLabel
        Left = 250
        Top = 54
        Width = 71
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Room : '
      end
      object clabPaymentType: TsLabel
        Left = 6
        Top = 116
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Payment type : '
      end
      object clabDate: TsLabel
        Left = 6
        Top = 72
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Date : '
      end
      object clabAmount: TsLabel
        Left = 6
        Top = 92
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Amount : '
      end
      object clabdescription: TsLabel
        Left = 6
        Top = 139
        Width = 121
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Description : '
      end
      object clabNotes: TsLabel
        Left = 6
        Top = 159
        Width = 121
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Notes : '
      end
      object labReservation: TsLabel
        Left = 136
        Top = 19
        Width = 4
        Height = 13
        Caption = '-'
      end
      object labCustomer: TsLabel
        Left = 136
        Top = 36
        Width = 4
        Height = 13
        Caption = '-'
      end
      object labArrivalDeparture: TsLabel
        Left = 136
        Top = 54
        Width = 4
        Height = 13
        Caption = '-'
      end
      object labDate: TsLabel
        Left = 136
        Top = 72
        Width = 4
        Height = 13
        Caption = '-'
      end
      object labRoom: TsLabel
        Left = 323
        Top = 54
        Width = 4
        Height = 13
        Caption = '-'
      end
      object edNotes: TsMemo
        Left = 137
        Top = 159
        Width = 299
        Height = 52
        Anchors = [akTop, akRight]
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        SkinData.SkinSection = 'EDIT'
      end
      object edDescription: TsEdit
        Left = 137
        Top = 136
        Width = 299
        Height = 21
        Anchors = [akTop, akRight]
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        SkinData.SkinSection = 'EDIT'
      end
      object cbxPaymentType: TsComboBox
        Left = 137
        Top = 113
        Width = 300
        Height = 21
        Alignment = taLeftJustify
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 2
        Text = 'Select one'
        OnCloseUp = cbxRoomSelectCloseUp
        Items.Strings = (
          '')
      end
      object edAmount: TsCalcEdit
        Left = 137
        Top = 89
        Width = 77
        Height = 21
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
  end
  object sPageControl1: TsPageControl
    Left = 0
    Top = 224
    Width = 450
    Height = 244
    ActivePage = sTabSheet1
    Align = alClient
    TabOrder = 1
    SkinData.SkinSection = 'PAGECONTROL'
    object sTabSheet1: TsTabSheet
      Caption = 'Work within reservation group'
      object btnSetToGroupAccount: TsButton
        Left = 16
        Top = 26
        Width = 137
        Height = 29
        Caption = 'Set to groupinvoice'
        Enabled = False
        TabOrder = 0
        OnClick = btnSetToGroupAccountClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sGroupBox1: TsGroupBox
        Left = 16
        Top = 61
        Width = 361
        Height = 82
        Caption = 'Assign to room'
        TabOrder = 1
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object cbxRoomSelect: TsComboBox
          Left = 8
          Top = 24
          Width = 345
          Height = 21
          Alignment = taLeftJustify
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'Select one'
          OnCloseUp = cbxRoomSelectCloseUp
          Items.Strings = (
            'Select one'
            '')
        end
        object btnExceuteAssingToroom: TsButton
          Left = 253
          Top = 51
          Width = 100
          Height = 25
          Caption = 'Execute'
          Enabled = False
          TabOrder = 1
          OnClick = btnExceuteAssingToroomClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
    object sTabSheet2: TsTabSheet
      Caption = 'Move to other reservation '
      DesignSize = (
        442
        216)
      object sGroupBox3: TsGroupBox
        Left = 3
        Top = 1
        Width = 436
        Height = 113
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Set to group invoice'
        TabOrder = 0
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        DesignSize = (
          436
          113)
        object sLabel1: TsLabel
          Left = 16
          Top = 24
          Width = 254
          Height = 13
          Alignment = taRightJustify
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = 'Reservation number :'
        end
        object btnCkeckReservation: TsSpeedButton
          Left = 354
          Top = 20
          Width = 75
          Height = 22
          Anchors = [akTop, akRight]
          Caption = 'Check'
          OnClick = btnCkeckReservationClick
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object labCheckReservation: TsLabel
          Left = 24
          Top = 48
          Width = 4
          Height = 13
          Caption = '-'
        end
        object edSetToGroupReservation: TsEdit
          Left = 276
          Top = 21
          Width = 72
          Height = 21
          Anchors = [akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          SkinData.SkinSection = 'EDIT'
        end
        object btnExecureReservation: TsButton
          Left = 354
          Top = 48
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Execute'
          Enabled = False
          TabOrder = 1
          OnClick = btnExecureReservationClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object sGroupBox4: TsGroupBox
        Left = 3
        Top = 114
        Width = 436
        Height = 115
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Set to room'
        TabOrder = 1
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        DesignSize = (
          436
          115)
        object sLabel2: TsLabel
          Left = 16
          Top = 24
          Width = 255
          Height = 13
          Alignment = taRightJustify
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = 'Room Reservation number :'
        end
        object btnCheckRoomReservation: TsSpeedButton
          Left = 352
          Top = 20
          Width = 75
          Height = 22
          Anchors = [akTop, akRight]
          Caption = 'Check'
          OnClick = btnCheckRoomReservationClick
          SkinData.SkinSection = 'SPEEDBUTTON'
        end
        object labCheckRoomReservation: TsLabel
          Left = 24
          Top = 56
          Width = 4
          Height = 13
          Caption = '-'
        end
        object edSetToRoomReservation: TsEdit
          Left = 276
          Top = 21
          Width = 72
          Height = 21
          Anchors = [akTop, akRight]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          SkinData.SkinSection = 'EDIT'
        end
        object btnExecuteRoomReservation: TsButton
          Left = 352
          Top = 48
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Execute'
          Enabled = False
          TabOrder = 1
          OnClick = btnExecuteRoomReservationClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
  end
  object Panel1: TsPanel
    Left = 0
    Top = 468
    Width = 450
    Height = 33
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      450
      33)
    object sButton1: TsButton
      Left = 273
      Top = 4
      Width = 83
      Height = 25
      Hint = 'Apply and close'
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOKClick
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton2: TsButton
      Left = 362
      Top = 4
      Width = 85
      Height = 25
      Hint = 'Cancel and close'
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 4
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
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
    StorageName = 'Software\Roomer\FormStatus\EditPayment'
    StorageType = stRegistry
    Left = 174
    Top = 304
  end
end
