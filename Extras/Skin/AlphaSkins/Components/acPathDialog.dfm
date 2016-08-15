object PathDialogForm: TPathDialogForm
  Left = 434
  Top = 310
  AutoScroll = False
  Caption = 'Select directory'
  ClientHeight = 415
  ClientWidth = 370
  Color = clBtnFace
  Constraints.MinHeight = 415
  Constraints.MinWidth = 370
  OldCreateOrder = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 18
    Top = 3
    Width = 3
    Height = 13
  end
  object sBitBtn1: TsBitBtn
    Left = 204
    Top = 376
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = sBitBtn1Click
    ShowFocus = False
  end
  object sBitBtn2: TsBitBtn
    Left = 281
    Top = 376
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = sBitBtn2Click
    ShowFocus = False
  end
  object sBitBtn3: TsBitBtn
    Left = 19
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Create'
    Enabled = False
    TabOrder = 3
    OnClick = sBitBtn3Click
    ShowFocus = False
  end
  object sShellTreeView1: TsShellTreeView
    Left = 15
    Top = 20
    Width = 345
    Height = 349
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Indent = 19
    ParentFont = False
    ShowRoot = False
    TabOrder = 0
    OnChange = sShellTreeView1Change
    BoundLabel.Active = True
    BoundLabel.Caption = ' '
    BoundLabel.Indent = 4
    BoundLabel.Layout = sclTopLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    ObjectTypes = [otFolders, otHidden]
    Root = 'rfDesktop'
    UseShellImages = True
    AutoRefresh = False
    ShowExt = seSystem
  end
  object sScrollBox1: TsScrollBox
    Left = 15
    Top = 20
    Width = 101
    Height = 349
    VertScrollBar.Tracking = True
    TabOrder = 4
    Visible = False
    SkinData.SkinSection = 'BAR'
  end
  object sSkinProvider1: TsSkinProvider
    SkinData.SkinSection = 'DIALOG'
    GripMode = gmRightBottom
    ShowAppIcon = False
    TitleButtons = <>
    Left = 219
    Top = 168
  end
  object ImageList1: TsAlphaImageList
    ShareImages = True
    Left = 187
    Top = 168
  end
end
