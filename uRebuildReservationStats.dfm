object frmRebuildReservationStats: TfrmRebuildReservationStats
  Left = 0
  Top = 0
  Caption = 'frmRebuildReservationStats'
  ClientHeight = 113
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 82
    Width = 482
    Height = 31
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = '-'
      end
      item
        PanelStyleClassName = 'TdxStatusBarContainerPanelStyle'
        PanelStyle.Container = dxStatusBar1Container1
        Text = 'Progress'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    object dxStatusBar1Container1: TdxStatusBarContainerControl
      Left = 56
      Top = 4
      Width = 408
      Height = 25
      object barProcess: TcxProgressBar
        Left = 0
        Top = 0
        Align = alClient
        ParentFont = False
        TabOrder = 0
        Width = 408
      end
    end
  end
  object Button1: TButton
    Left = 112
    Top = 22
    Width = 205
    Height = 25
    Caption = 'Rebuild RoomRate in RoomsDate'
    TabOrder = 1
    OnClick = Button1Click
  end
end
