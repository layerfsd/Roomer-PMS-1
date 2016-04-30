object FrmNotepad: TFrmNotepad
  Left = 0
  Top = 0
  Caption = 'Text Editor'
  ClientHeight = 468
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object sPanel1: TsPanel
    Left = 0
    Top = 426
    Width = 781
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = 350
    ExplicitWidth = 440
    DesignSize = (
      781
      42)
    object btnClose: TsButton
      Left = 692
      Top = 5
      Width = 79
      Height = 26
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 2
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 351
    end
    object sButton1: TsButton
      Left = 601
      Top = 5
      Width = 79
      Height = 26
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ImageIndex = 82
      Images = DImages.PngImageList1
      ModalResult = 1
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 260
    end
  end
  object sMemo1: TsMemo
    Left = 0
    Top = 0
    Width = 781
    Height = 426
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    HideSelection = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -13
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    SkinData.SkinSection = 'EDIT'
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
    StorageName = 'Software\Roomer\FormStatus\FrmNotePad'
    StorageType = stRegistry
    Left = 254
    Top = 112
  end
end
