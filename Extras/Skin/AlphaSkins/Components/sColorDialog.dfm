object sColorDialogForm: TsColorDialogForm
  Left = 388
  Top = 297
  ActiveControl = sEditDecimal
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Color'
  ClientHeight = 404
  ClientWidth = 544
  Color = clBtnFace
  Constraints.MinHeight = 380
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = PickFormKeyDown
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel2: TsLabel
    Left = 21
    Top = 160
    Width = 82
    Height = 13
    Caption = 'Additional colors:'
  end
  object sLabel4: TsLabel
    Left = 431
    Top = 286
    Width = 6
    Height = 13
    Caption = 'o'
  end
  object sLabel5: TsLabel
    Left = 431
    Top = 315
    Width = 11
    Height = 13
    Caption = '%'
  end
  object sLabel6: TsLabel
    Left = 431
    Top = 339
    Width = 11
    Height = 13
    Caption = '%'
  end
  object sSpeedButton1: TsSpeedButton
    Left = 17
    Top = 312
    Width = 56
    Height = 41
    Flat = True
    Glyph.Data = {
      06030000424D06030000000000003600000028000000100000000F0000000100
      180000000000D002000000000000000000000000000000000000FF00FFBFBF00
      BFBF00BFBF00BFBF00BFBF00BFBF00BFBF00FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFBFBF00BFBF00000000000000000000BFBF00BFBF00BF
      BF00BFBF00BFBF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBFBF00
      000000BFBF00BFBF00000000BFBF00BFBF00BFBF00FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFBFBF00000000FF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF000000FFFFFFFFFFFFBFBF00000000FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFBF
      BF00000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF000000FFFFFFFFFFFF808080000000FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF
      FFFFFFFFFF808080000000FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFF8080800000000000
      00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF000000FFFFFF000000000000000000000000FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000000000000000000000
      00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF000000000000000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000000000000000
      00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF000000C0C0C0000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000
      00000000000000FF00FF}
    OnClick = sSpeedButton1Click
  end
  object sBitBtn1: TsBitBtn
    Left = 88
    Top = 365
    Width = 67
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 9
    OnClick = sBitBtn1Click
    ShowFocus = False
  end
  object sBitBtn2: TsBitBtn
    Left = 160
    Top = 365
    Width = 67
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 10
    OnClick = sBitBtn2Click
    ShowFocus = False
  end
  object ColorPanel: TsPanel
    Left = 243
    Top = 13
    Width = 255
    Height = 255
    BevelOuter = bvNone
    Caption = ' '
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 15
    TabStop = True
    OnMouseDown = ColorPanelMouseDown
    OnMouseMove = ColorPanelMouseMove
    OnMouseUp = ColorPanelMouseUp
    OnPaint = ColorPanelPaint
  end
  object GradPanel: TsPanel
    Left = 511
    Top = 13
    Width = 20
    Height = 255
    BevelOuter = bvNone
    Caption = ' '
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 16
    TabStop = True
    OnMouseDown = GradPanelMouseDown
    OnMouseMove = GradPanelMouseMove
    OnMouseUp = GradPanelMouseUp
    OnPaint = GradPanelPaint
  end
  object sREdit: TsTrackEdit
    Left = 503
    Top = 289
    Width = 33
    Height = 19
    AutoSize = False
    TabOrder = 5
    Text = '0'
    OnChange = sREditChange
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Red:'
    AutoPopup = False
    Increment = 1
    MaxValue = 255
    DecimalPlaces = 0
  end
  object sGEdit: TsTrackEdit
    Left = 503
    Top = 313
    Width = 33
    Height = 19
    AutoSize = False
    TabOrder = 6
    Text = '0'
    OnChange = sREditChange
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Green:'
    AutoPopup = False
    Increment = 1
    MaxValue = 255
    DecimalPlaces = 0
  end
  object sBEdit: TsTrackEdit
    Left = 503
    Top = 337
    Width = 33
    Height = 19
    AutoSize = False
    TabOrder = 7
    Text = '0'
    OnChange = sREditChange
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Blue:'
    AutoPopup = False
    Increment = 1
    MaxValue = 255
    DecimalPlaces = 0
  end
  object sBitBtn3: TsBitBtn
    Left = 376
    Top = 365
    Width = 160
    Height = 25
    Caption = 'Add to custom colors set'
    TabOrder = 11
    OnClick = sBitBtn3Click
    ShowFocus = False
  end
  object sBitBtn4: TsBitBtn
    Left = 15
    Top = 275
    Width = 213
    Height = 25
    Caption = 'Define colors'
    Enabled = False
    TabOrder = 12
    OnClick = sBitBtn4Click
    ShowFocus = False
  end
  object sHEdit: TsTrackEdit
    Left = 395
    Top = 289
    Width = 33
    Height = 19
    AutoSize = False
    TabOrder = 2
    Text = '0'
    OnChange = sHEditChange
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'H:'
    AutoPopup = False
    Increment = 1
    MaxValue = 359
    DecimalPlaces = 0
  end
  object sSEdit: TsTrackEdit
    Left = 395
    Top = 313
    Width = 33
    Height = 19
    AutoSize = False
    TabOrder = 3
    Text = '0'
    OnChange = sHEditChange
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'S:'
    AutoPopup = False
    Increment = 1
    MaxValue = 100
    DecimalPlaces = 0
  end
  object sVEdit: TsTrackEdit
    Left = 395
    Top = 337
    Width = 33
    Height = 19
    AutoSize = False
    TabOrder = 4
    Text = '0'
    OnChange = sHEditChange
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'B:'
    AutoPopup = False
    Increment = 1
    MaxValue = 100
    DecimalPlaces = 0
  end
  object MainPal: TsColorsPanel
    Left = 10
    Top = 13
    Width = 223
    Height = 142
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 13
    TabStop = True
    OnDblClick = MainPalDblClick
    Colors.Strings = (
      '8080FF'
      '80FFFF'
      '80FF80'
      '80FF00'
      'FFFF80'
      'FF8000'
      'C080FF'
      'FF80FF'
      '0000FF'
      '00FFFF'
      '00FF80'
      '40FF00'
      'FFFF00'
      'C08000'
      'C08080'
      'FF00FF'
      '404080'
      '4080FF'
      '00FF00'
      '808000'
      '804000'
      'FF8080'
      '400080'
      '8000FF'
      '000080'
      '0080FF'
      '008000'
      '408000'
      'FF0000'
      'A00000'
      '800080'
      'FF0080'
      '000040'
      '004080'
      '004000'
      '004040'
      '800000'
      '400000'
      '400040'
      '800040'
      '000000'
      '008080'
      '408080'
      '808080'
      '808040'
      'C0C0C0'
      '400040'
      'FFFFFF')
    ColCount = 8
    ItemHeight = 17
    RowCount = 6
    OnChange = MainPalChange
  end
  object AddPal: TsColorsPanel
    Left = 10
    Top = 173
    Width = 223
    Height = 95
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 14
    TabStop = True
    OnDblClick = AddPalDblClick
    Colors.Strings = (
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF'
      'FFFFFF')
    ColCount = 6
    ItemHeight = 24
    ItemWidth = 30
    RowCount = 3
    OnChange = MainPalChange
  end
  object sEditDecimal: TsCurrencyEdit
    Left = 158
    Top = 309
    Width = 70
    Height = 19
    AutoSize = False
    TabOrder = 0
    OnChange = sEditDecimalChange
    BoundLabel.Active = True
    BoundLabel.Caption = 'Decimal - '
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
    Alignment = taLeftJustify
    DecimalPlaces = 0
    DisplayFormat = '0'
  end
  object sEditHex: TsMaskEdit
    Left = 158
    Top = 334
    Width = 70
    Height = 21
    CharCase = ecUpperCase
    EditMask = 'AAAAAA;1; '
    MaxLength = 6
    TabOrder = 1
    Text = '      '
    OnChange = sEditHexChange
    OnKeyPress = sEditHexKeyPress
    CheckOnExit = True
    BoundLabel.Active = True
    BoundLabel.Caption = 'Hex - '
  end
  object sBitBtn5: TsBitBtn
    Left = 16
    Top = 365
    Width = 67
    Height = 25
    Caption = 'Help'
    TabOrder = 8
    OnClick = sBitBtn5Click
    ShowFocus = False
  end
  object Panel1: TPanel
    Tag = 256
    Left = 243
    Top = 290
    Width = 122
    Height = 100
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 17
    object SelectedPanel: TShape
      Left = 0
      Top = 0
      Width = 120
      Height = 50
      Align = alTop
      Brush.Color = clGreen
      Pen.Color = clGreen
      Pen.Width = 0
    end
    object OldPanel: TShape
      Left = 0
      Top = 50
      Width = 120
      Height = 48
      Align = alClient
      Brush.Color = clGreen
      Pen.Color = clGreen
      Pen.Width = 0
    end
  end
  object sDragBar1: TsDragBar
    Left = 0
    Top = 0
    Width = 544
    Height = 6
    Cursor = crHandPoint
    Caption = ' '
    TabOrder = 18
    SkinData.SkinSection = 'DRAGBAR'
    DraggedControl = Owner
  end
  object sSkinProvider1: TsSkinProvider
    ScreenSnap = True
    ShowAppIcon = False
    CaptionAlignment = taCenter
    SkinData.SkinSection = 'DIALOG'
    TitleButtons = <>
    Left = 329
    Top = 33
  end
end
