object FrmReservationCancellationDialog: TFrmReservationCancellationDialog
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Reservation Cancellation'
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
    Left = 88
    Top = 40
    Width = 91
    Height = 13
    Alignment = taRightJustify
    Caption = 'Reservation name:'
  end
  object lblResName: TsLabel
    Left = 200
    Top = 40
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
    Left = 137
    Top = 59
    Width = 42
    Height = 13
    Alignment = taRightJustify
    Caption = 'Contact:'
  end
  object lblContact: TsLabel
    Left = 200
    Top = 59
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
    Left = 144
    Top = 78
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = 'Arrival:'
  end
  object lblArrival: TsLabel
    Left = 200
    Top = 78
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
    Left = 126
    Top = 97
    Width = 53
    Height = 13
    Alignment = taRightJustify
    Caption = 'Departure:'
  end
  object lblDeparture: TsLabel
    Left = 200
    Top = 97
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
    Left = 93
    Top = 116
    Width = 86
    Height = 13
    Alignment = taRightJustify
    Caption = 'Number of rooms:'
  end
  object lblRooms: TsLabel
    Left = 200
    Top = 116
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
    Left = 90
    Top = 135
    Width = 89
    Height = 13
    Alignment = taRightJustify
    Caption = 'Number of guests:'
  end
  object lblGuests: TsLabel
    Left = 200
    Top = 135
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
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
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
    ExplicitLeft = 15
    ExplicitTop = 204
  end
  object sCheckBox1: TsCheckBox
    Left = 200
    Top = 154
    Width = 200
    Height = 19
    Caption = 'Send Cancellation confirmation'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
end
