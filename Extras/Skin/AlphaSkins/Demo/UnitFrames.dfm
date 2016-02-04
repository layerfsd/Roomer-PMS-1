object FrameFrames: TFrameFrames
  Left = 0
  Top = 0
  Width = 560
  Height = 423
  TabOrder = 0
  object sButton1: TsButton
    Tag = 5
    Left = 13
    Top = 12
    Width = 117
    Height = 52
    Caption = 'Create new frame'
    TabOrder = 0
    OnClick = sButton1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sButton2: TsButton
    Tag = 5
    Left = 133
    Top = 12
    Width = 117
    Height = 52
    Caption = 'Remove frame'
    Enabled = False
    TabOrder = 1
    OnClick = sButton2Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 7
    Top = 9
  end
end
