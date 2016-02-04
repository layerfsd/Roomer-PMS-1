object FrameHints: TFrameHints
  Left = 0
  Top = 0
  Width = 546
  Height = 342
  TabOrder = 0
  OnResize = FrameResize
  object sLabelFX1: TsLabelFX
    Left = 48
    Top = 24
    Width = 377
    Height = 69
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Invisible component which redefines properties of standard hints' +
      ' in application and adds some additional properties'#13#10#13#10'For a com' +
      'ponent using it is enough to place him in one exemplar(!) to the' +
      ' main form of application'
    ParentFont = False
    WordWrap = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
  end
  object sBitBtn1: TsBitBtn
    Left = 264
    Top = 212
    Width = 129
    Height = 29
    Caption = 'Open templates editor'
    TabOrder = 0
    OnClick = sBitBtn1Click
    SkinData.SkinSection = 'BUTTON_BIG'
    ShowFocus = False
  end
  object sRadioGroup1: TsRadioGroup
    Left = 64
    Top = 124
    Width = 185
    Height = 117
    Caption = ' Hints mode : '
    ParentBackground = False
    TabOrder = 1
    OnClick = sRadioGroup1Click
    SkinData.SkinSection = 'GROUPBOX'
    ItemIndex = 0
    Items.Strings = (
      'ShowHint is disabled'
      'Skinned hints'
      'Templated hints'
      'Standard hints')
  end
  object sListBox1: TsListBox
    Left = 264
    Top = 128
    Width = 129
    Height = 77
    ItemHeight = 13
    TabOrder = 2
    OnClick = sListBox1Click
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 349
    Top = 10
  end
end
