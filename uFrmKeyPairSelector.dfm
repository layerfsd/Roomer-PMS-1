object frmKeyPairSelector: TfrmKeyPairSelector
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Key Selector'
  ClientHeight = 326
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object sPanel1: TsPanel
    Left = 0
    Top = 293
    Width = 372
    Height = 33
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object pnlEditButtons: TsPanel
      Left = 209
      Top = 0
      Width = 163
      Height = 33
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        163
        33)
      object BtnOk: TsButton
        Left = 5
        Top = 4
        Width = 71
        Height = 25
        Hint = 'Apply and close'
        Anchors = [akTop, akRight]
        Caption = 'OK'
        Default = True
        ImageIndex = 82
        Images = DImages.PngImageList1
        ModalResult = 1
        TabOrder = 0
        SkinData.SkinSection = 'BUTTON'
      end
      object btnCancel: TsButton
        Left = 82
        Top = 4
        Width = 71
        Height = 25
        Hint = 'Cancel and close'
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'Cancel'
        ImageIndex = 10
        Images = DImages.PngImageList1
        ModalResult = 2
        TabOrder = 1
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 0
    Width = 372
    Height = 31
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sLabel1: TsLabel
      Left = 10
      Top = 9
      Width = 31
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Search'
    end
    object edtFilter: TsEdit
      Left = 54
      Top = 7
      Width = 281
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edtFilterChange
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -13
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object __btnClear: TsButton
      Left = 336
      Top = 6
      Width = 20
      Height = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'X'
      TabOrder = 1
      OnClick = __btnClearClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object lvList: TsListView
    Left = 0
    Top = 31
    Width = 372
    Height = 262
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -13
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    Align = alClient
    BorderStyle = bsNone
    Columns = <
      item
        Caption = 'Key'
        Width = 113
      end
      item
        Caption = 'Value'
        Width = 225
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FlatScrollBars = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    SortType = stText
    TabOrder = 2
    ViewStyle = vsReport
    OnColumnClick = lvListColumnClick
    OnCompare = lvListCompare
    OnDblClick = lvListDblClick
  end
end
