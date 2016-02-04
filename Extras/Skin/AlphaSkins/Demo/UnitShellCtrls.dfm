object FrameShellControls: TFrameShellControls
  Left = 0
  Top = 0
  Width = 641
  Height = 424
  AutoScroll = False
  TabOrder = 0
  DesignSize = (
    641
    424)
  object sShellComboBox1: TsShellComboBox
    Tag = 5
    Left = 8
    Top = 8
    Width = 189
    Height = 22
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'ALPHACOMBOBOX'
    DropDownCount = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Root = 'rfDesktop'
    ShellTreeView = sShellTreeView1
    ShellListView = sShellListView1
  end
  object sShellTreeView1: TsShellTreeView
    Tag = 5
    Left = 8
    Top = 36
    Width = 189
    Height = 381
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Indent = 19
    ParentFont = False
    ShowRoot = False
    TabOrder = 1
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
    ObjectTypes = [otFolders]
    Root = 'rfDesktop'
    ShellComboBox = sShellComboBox1
    ShellListView = sShellListView1
    UseShellImages = True
    AutoRefresh = False
    ShowExt = seSystem
  end
  object sShellListView1: TsShellListView
    Tag = 5
    Left = 200
    Top = 8
    Width = 433
    Height = 385
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
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Sorted = True
    HideSelection = False
    ParentFont = False
    TabOrder = 2
    ObjectTypes = [otFolders, otNonFolders]
    Root = 'rfDesktop'
    ShellTreeView = sShellTreeView1
    ShellComboBox = sShellComboBox1
    ShowExt = seSystem
  end
  object sComboBox1: TsComboBox
    Tag = 5
    Left = 488
    Top = 396
    Width = 145
    Height = 19
    Anchors = [akRight, akBottom]
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'View style'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'COMBOBOX'
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ItemIndex = -1
    ParentFont = False
    TabOrder = 3
    OnChange = sComboBox1Change
    Items.Strings = (
      'vsIcon'
      'vsList'
      'vsReport'
      'vsSmallIcon')
  end
  object sFrameAdapter1: TsFrameAdapter
    SkinData.SkinSection = 'CHECKBOX'
    Left = 15
    Top = 13
  end
end
