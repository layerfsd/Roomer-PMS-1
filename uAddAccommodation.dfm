object frmAddAccommodation: TfrmAddAccommodation
  Left = 931
  Top = 376
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Add accommodation'
  ClientHeight = 172
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxLabel1: TsLabel
    Left = 24
    Top = 16
    Width = 114
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Number of persons :'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object cxLabel2: TsLabel
    Left = 24
    Top = 39
    Width = 114
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Nights :'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object cxLabel3: TsLabel
    Left = 24
    Top = 72
    Width = 114
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Rooms :'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object cxLabel4: TsLabel
    Left = 24
    Top = 96
    Width = 114
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Room price :'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object edPersons: TsSpinEdit
    Left = 144
    Top = 13
    Width = 81
    Height = 21
    Color = 3355443
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 15724527
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -13
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    MaxValue = 0
    MinValue = 0
    Value = 0
  end
  object edNights: TsSpinEdit
    Left = 144
    Top = 36
    Width = 81
    Height = 21
    Color = 3355443
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 15724527
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -13
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    MaxValue = 0
    MinValue = 0
    Value = 0
  end
  object edRooms: TsSpinEdit
    Left = 144
    Top = 69
    Width = 81
    Height = 21
    Color = 3355443
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 15724527
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -13
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    MaxValue = 0
    MinValue = 0
    Value = 0
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 131
    Width = 248
    Height = 41
    Align = alBottom
    TabOrder = 4
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      248
      41)
    object BtnOk: TsButton
      Left = 64
      Top = 6
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
    object btnCancel: TsButton
      Left = 153
      Top = 6
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
  object edRoomPrice: TsCalcEdit
    Left = 144
    Top = 93
    Width = 81
    Height = 21
    AutoSize = False
    Color = 3355443
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 15724527
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
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
    StorageName = 'Software\Roomer\FormStatus\frmAddAccommodation'
    StorageType = stRegistry
    Left = 2
    Top = 6
  end
end
