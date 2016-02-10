object FrmReservationEmailingDialog: TFrmReservationEmailingDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Reservation emailing dialog'
  ClientHeight = 568
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 760
    Height = 153
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sLabel1: TsLabel
      Left = 95
      Top = 15
      Width = 88
      Height = 13
      Alignment = taRightJustify
      Caption = 'Email template:'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel2: TsLabel
      Left = 127
      Top = 42
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Recipient:'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel3: TsLabel
      Left = 110
      Top = 69
      Width = 73
      Height = 13
      Alignment = taRightJustify
      Caption = 'Carbon copy:'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel4: TsLabel
      Left = 137
      Top = 96
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Subject:'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object shpTemplate: TShape
      Left = 573
      Top = 14
      Width = 16
      Height = 17
      Brush.Color = clRed
      Pen.Color = clRed
      Shape = stCircle
      Visible = False
    end
    object shpTo: TShape
      Left = 573
      Top = 41
      Width = 16
      Height = 17
      Brush.Color = clRed
      Pen.Color = clRed
      Shape = stCircle
      Visible = False
    end
    object shpSubject: TShape
      Left = 573
      Top = 95
      Width = 16
      Height = 17
      Brush.Color = clRed
      Pen.Color = clRed
      Shape = stCircle
      Visible = False
    end
    object edTemplate: TsComboBox
      Left = 189
      Top = 12
      Width = 380
      Height = 21
      Alignment = taLeftJustify
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      Style = csDropDownList
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 0
      OnCloseUp = edTemplateCloseUp
    end
    object btnResources: TsButton
      Left = 596
      Top = 10
      Width = 125
      Height = 25
      Caption = 'Resources'
      TabOrder = 1
      OnClick = btnResourcesClick
      SkinData.SkinSection = 'BUTTON'
    end
    object edTo: TsComboBox
      Left = 189
      Top = 39
      Width = 380
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
      OnCloseUp = edToCloseUp
      OnChange = edToChange
    end
    object edCC: TsComboBox
      Left = 189
      Top = 66
      Width = 380
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
      TabOrder = 3
      OnCloseUp = edToCloseUp
      OnChange = edToChange
    end
    object edSubject: TsEdit
      Left = 189
      Top = 93
      Width = 380
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = edSubjectChange
      SkinData.SkinSection = 'EDIT'
    end
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 522
    Width = 760
    Height = 46
    Align = alBottom
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      760
      46)
    object btnOk: TsButton
      Left = 620
      Top = 10
      Width = 111
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Send'
      Default = True
      Enabled = False
      ModalResult = 1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 25
      Top = 10
      Width = 111
      Height = 25
      Caption = 'Edit text'
      Enabled = False
      TabOrder = 1
      OnClick = btnEditClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object WebBrowser: TWebBrowser
    AlignWithMargins = True
    Left = 3
    Top = 156
    Width = 754
    Height = 363
    Align = alClient
    TabOrder = 2
    ExplicitLeft = -2
    ExplicitTop = 153
    ControlData = {
      4C000000EE4D0000842500000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
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
    StorageName = 'Software\Roomer\FormStatus\ReservationEmailingDialog'
    StorageType = stRegistry
    Left = 423
    Top = 328
  end
end
