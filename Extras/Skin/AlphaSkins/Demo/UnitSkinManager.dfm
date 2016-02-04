object FrameSkinManager: TFrameSkinManager
  Left = 0
  Top = 0
  Width = 455
  Height = 441
  TabOrder = 0
  object sLabelFX1: TsLabelFX
    Left = 24
    Top = 16
    Width = 369
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'TsSkinManager is a component for manipulations with application ' +
      'skins in the design-time and real-time.'
    ParentFont = False
    WordWrap = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
  end
  object sLabelFX2: TsLabelFX
    Left = 24
    Top = 64
    Width = 369
    Height = 140
    AutoSize = False
    Caption = 
      'Use this component if you want to provide AlphaSkins possibiliti' +
      'es in your applications. '#13#10#13#10'To use this component just put it t' +
      'o the main form of application and choose skin by SkinDirectory ' +
      'and SkinName properties. Also you can define list of internal sk' +
      'ins in the property InternalSkins. '#13#10#13#10'Skin placing within the E' +
      'xe-file simplifies the program expansion, there is no need to cr' +
      'eate a directory with skins and copy them into it. Built-in skin' +
      's are always available in the program.'
    ParentFont = False
    WordWrap = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
  end
  object sLabelFX3: TsLabelFX
    Left = 24
    Top = 224
    Width = 369
    Height = 33
    AutoSize = False
    Caption = 
      'Since version 4.60 AlphaControls have support of several TsSkinM' +
      'anagers in one application :'
    ParentFont = False
    WordWrap = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
  end
  object sSpeedButton1: TsSpeedButton
    Left = 32
    Top = 264
    Width = 337
    Height = 41
    Caption = 'Example of multi-skinning'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = sSpeedButton1Click
    SkinData.SkinSection = 'SPEEDBUTTON'
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 112
    Top = 56
  end
end
