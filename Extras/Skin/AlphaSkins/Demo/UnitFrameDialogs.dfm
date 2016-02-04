object FrameDialogs: TFrameDialogs
  Left = 0
  Top = 0
  Width = 620
  Height = 440
  TabOrder = 0
  OnResize = FrameResize
  object sGroupBox1: TsGroupBox
    Left = 33
    Top = 19
    Width = 424
    Height = 218
    Caption = 'sMessageDlg function'
    TabOrder = 0
    SkinData.SkinSection = 'GROUPBOX'
    object sEdit1: TsEdit
      Left = 156
      Top = 26
      Width = 161
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Message text'
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object sGroupBox2: TsGroupBox
      Left = 214
      Top = 57
      Width = 185
      Height = 120
      Caption = 'Message type'
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      object sRadioButton1: TsRadioButton
        Left = 16
        Top = 21
        Width = 60
        Height = 20
        Caption = 'Warning'
        Checked = True
        TabOrder = 0
        TabStop = True
        SkinData.SkinSection = 'RADIOBUTTON'
      end
      object sRadioButton2: TsRadioButton
        Left = 16
        Top = 43
        Width = 44
        Height = 20
        Caption = 'Error'
        TabOrder = 1
        SkinData.SkinSection = 'RADIOBUTTON'
      end
      object sRadioButton3: TsRadioButton
        Left = 16
        Top = 65
        Width = 76
        Height = 20
        Caption = 'Information'
        TabOrder = 2
        SkinData.SkinSection = 'RADIOBUTTON'
      end
      object sRadioButton4: TsRadioButton
        Left = 16
        Top = 87
        Width = 81
        Height = 20
        Caption = 'Confirmation'
        TabOrder = 3
        SkinData.SkinSection = 'RADIOBUTTON'
      end
    end
    object sButton1: TsButton
      Left = 324
      Top = 24
      Width = 77
      Height = 25
      Caption = 'Show dialog'
      TabOrder = 2
      OnClick = sButton1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sRadioGroup1: TsRadioGroup
      Left = 20
      Top = 57
      Width = 185
      Height = 148
      Caption = 'Buttons'
      ParentBackground = False
      TabOrder = 3
      SkinData.SkinSection = 'GROUPBOX'
      Items.Strings = (
        'OK'
        'OKCANCEL'
        'ABORTRETRYIGNORE'
        'YESNOCANCEL'
        'YESNO'
        'RETRYCANCEL')
    end
    object sCheckBox1: TsCheckBox
      Left = 220
      Top = 184
      Width = 76
      Height = 20
      Caption = 'Help button'
      Checked = True
      State = cbChecked
      TabOrder = 4
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sEdit4: TsEdit
      Left = 20
      Top = 26
      Width = 129
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = 'Dialog title'
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
  end
  object sGroupBox3: TsGroupBox
    Left = 33
    Top = 246
    Width = 424
    Height = 87
    Caption = 'Messages'
    TabOrder = 1
    SkinData.SkinSection = 'GROUPBOX'
    object sEdit2: TsEdit
      Left = 20
      Top = 24
      Width = 353
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Message text for "sShowMessage" procedure'
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object sButton2: TsButton
      Left = 33
      Top = 52
      Width = 136
      Height = 25
      Caption = 'sShowMessage'
      TabOrder = 1
      OnClick = sButton2Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton4: TsButton
      Left = 177
      Top = 52
      Width = 184
      Height = 25
      Caption = 'Application.MessageBox'
      TabOrder = 2
      OnClick = sButton4Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sGroupBox4: TsGroupBox
    Left = 33
    Top = 337
    Width = 424
    Height = 56
    Caption = 'sInputQuery function'
    TabOrder = 2
    SkinData.SkinSection = 'GROUPBOX'
    object sEdit3: TsEdit
      Left = 20
      Top = 24
      Width = 275
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Message text for "sInputQuery" function'
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object sButton3: TsButton
      Left = 305
      Top = 21
      Width = 59
      Height = 25
      Caption = 'Show'
      TabOrder = 1
      OnClick = sButton3Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 11
    Top = 33
  end
end
