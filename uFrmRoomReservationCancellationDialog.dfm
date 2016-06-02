object FrmRoomReservationCancellationDialog: TFrmRoomReservationCancellationDialog
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Room Cancellation'
  ClientHeight = 346
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 211
    Top = 73
    Width = 91
    Height = 13
    Alignment = taRightJustify
    Caption = 'Reservation name:'
  end
  object lblResName: TsLabel
    Left = 323
    Top = 73
    Width = 5
    Height = 13
    Caption = '-'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel3: TsLabel
    Left = 260
    Top = 92
    Width = 42
    Height = 13
    Alignment = taRightJustify
    Caption = 'Contact:'
  end
  object lblContact: TsLabel
    Left = 323
    Top = 92
    Width = 5
    Height = 13
    Caption = '-'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel5: TsLabel
    Left = 267
    Top = 111
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = 'Arrival:'
  end
  object lblArrival: TsLabel
    Left = 323
    Top = 111
    Width = 5
    Height = 13
    Caption = '-'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel7: TsLabel
    Left = 249
    Top = 130
    Width = 53
    Height = 13
    Alignment = taRightJustify
    Caption = 'Departure:'
  end
  object lblDeparture: TsLabel
    Left = 323
    Top = 130
    Width = 5
    Height = 13
    Caption = '-'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel9: TsLabel
    Left = 216
    Top = 149
    Width = 86
    Height = 13
    Alignment = taRightJustify
    Caption = 'Number of rooms:'
  end
  object lblRooms: TsLabel
    Left = 323
    Top = 149
    Width = 5
    Height = 13
    Caption = '-'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel11: TsLabel
    Left = 213
    Top = 168
    Width = 89
    Height = 13
    Alignment = taRightJustify
    Caption = 'Number of guests:'
  end
  object lblGuests: TsLabel
    Left = 323
    Top = 168
    Width = 5
    Height = 13
    Caption = '-'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel2: TsLabel
    Left = 13
    Top = 185
    Width = 40
    Height = 13
    Caption = 'Reason:'
  end
  object sLabel4: TsLabel
    Left = 118
    Top = 42
    Width = 61
    Height = 13
    Alignment = taRightJustify
    Caption = 'Guest name:'
  end
  object lblGuest: TsLabel
    Left = 200
    Top = 42
    Width = 5
    Height = 13
    Caption = '-'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel8: TsLabel
    Left = 148
    Top = 23
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Room:'
  end
  object lblRoom: TsLabel
    Left = 200
    Top = 23
    Width = 5
    Height = 13
    Caption = '-'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 305
    Width = 583
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sButton1: TsButton
      Left = 441
      Top = 8
      Width = 106
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton2: TsButton
      Left = 336
      Top = 8
      Width = 99
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object mmoReason: TsMemo
    AlignWithMargins = True
    Left = 10
    Top = 202
    Width = 563
    Height = 100
    Margins.Left = 10
    Margins.Right = 10
    Align = alBottom
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    SkinData.SkinSection = 'EDIT'
    ExplicitLeft = 5
    ExplicitTop = 204
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
    StorageName = 'Software\Roomer\FormStatus\FrmRoomReservationCancellationDialog'
    StorageType = stRegistry
    Left = 450
    Top = 126
  end
end
