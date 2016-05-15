object FrmResources: TFrmResources
  Left = 0
  Top = 0
  Caption = 'Resources'
  ClientHeight = 518
  ClientWidth = 871
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object pnlHolder: TsPanel
    Left = 0
    Top = 0
    Width = 871
    Height = 518
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sPanel1: TsPanel
      Left = 0
      Top = 0
      Width = 871
      Height = 75
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      OnDragDrop = lvResourcesDragDrop
      OnDragOver = lvResourcesDragOver
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        871
        75)
      object btnInsert: TsButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 114
        Height = 42
        Hint = 'Add new record'
        Align = alLeft
        Caption = 'New'
        ImageIndex = 23
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnInsertClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnDelete: TsButton
        AlignWithMargins = True
        Left = 243
        Top = 3
        Width = 114
        Height = 42
        Hint = 'Delete current record'
        Align = alLeft
        Caption = 'Delete'
        Enabled = False
        ImageIndex = 24
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnDeleteClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClose: TsButton
        Left = 765
        Top = 5
        Width = 100
        Height = 25
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'Close'
        ImageIndex = 27
        Images = DImages.PngImageList1
        ModalResult = 8
        TabOrder = 2
        OnClick = btnCloseClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnView: TsButton
        AlignWithMargins = True
        Left = 123
        Top = 3
        Width = 114
        Height = 42
        Hint = 'Delete current record'
        Align = alLeft
        Caption = 'View'
        Enabled = False
        ImageIndex = 17
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = lvResourcesDblClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnEdit: TsButton
        AlignWithMargins = True
        Left = 483
        Top = 3
        Width = 114
        Height = 42
        Hint = 'Delete current record'
        Align = alLeft
        Caption = 'Edit'
        Enabled = False
        ImageIndex = 25
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        Visible = False
        OnClick = btnEditClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnRename: TsButton
        AlignWithMargins = True
        Left = 363
        Top = 3
        Width = 114
        Height = 42
        Hint = 'Delete current record'
        Align = alLeft
        Caption = 'Name and subject'
        Enabled = False
        ImageIndex = 29
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = btnRenameClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnSource: TsButton
        AlignWithMargins = True
        Left = 603
        Top = 3
        Width = 114
        Height = 42
        Hint = 'Delete current record'
        Align = alLeft
        Caption = 'Source'
        Enabled = False
        ImageIndex = 115
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        Visible = False
        OnClick = btnSourceClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sPanel3: TsPanel
        Left = 0
        Top = 48
        Width = 871
        Height = 27
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 7
        object sLabel1: TsLabel
          Left = 91
          Top = 6
          Width = 26
          Height = 12
          Alignment = taRightJustify
          Caption = 'Filter:'
        end
        object edtFilter: TButtonedEdit
          Left = 123
          Top = 3
          Width = 234
          Height = 20
          Images = DImages.cxSmallImagesFlat
          RightButton.ImageIndex = 10
          RightButton.Visible = True
          TabOrder = 0
          OnChange = edtFilterChange
          OnRightButtonClick = edtFilterRightButtonClick
        end
      end
    end
    object lvResources: TListView
      AlignWithMargins = True
      Left = 2
      Top = 77
      Width = 867
      Height = 397
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      BorderStyle = bsNone
      Color = 4210752
      Columns = <
        item
          Caption = 'Filename'
          Width = 250
        end
        item
          Caption = 'User'
        end
        item
          Caption = 'Date/Time'
          Width = 130
        end
        item
          Caption = 'Subject'
          Width = 250
        end
        item
          Caption = 'URI'
          Width = 350
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      FlatScrollBars = True
      MultiSelect = True
      RowSelect = True
      ParentFont = False
      PopupMenu = PopupMenu1
      SortType = stText
      TabOrder = 1
      ViewStyle = vsReport
      OnColumnClick = lvResourcesColumnClick
      OnCompare = lvResourcesCompare
      OnDblClick = lvResourcesDblClick
      OnEdited = lvResourcesEdited
      OnDragDrop = lvResourcesDragDrop
      OnDragOver = lvResourcesDragOver
      OnSelectItem = lvResourcesSelectItem
    end
    object sPanel2: TsPanel
      Left = 0
      Top = 476
      Width = 871
      Height = 42
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        871
        42)
      object sButton1: TsButton
        Left = 753
        Top = 5
        Width = 112
        Height = 26
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = 'Cancel'
        ImageIndex = 27
        Images = DImages.PngImageList1
        ModalResult = 2
        TabOrder = 0
        SkinData.SkinSection = 'BUTTON'
      end
      object sButton2: TsButton
        Left = 637
        Top = 5
        Width = 110
        Height = 26
        Anchors = [akRight, akBottom]
        Caption = 'OK'
        Default = True
        ImageIndex = 82
        Images = DImages.PngImageList1
        ModalResult = 1
        TabOrder = 1
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object FormStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Position'
          'Top'
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\StaticResources2'
    StorageType = stRegistry
    Left = 311
    Top = 176
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 224
    Top = 264
    object C2: TMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = C2Click
    end
    object P1: TMenuItem
      Caption = 'Paste'
      ShortCut = 16470
      OnClick = P1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object V1: TMenuItem
      Caption = 'View'
      Default = True
      OnClick = lvResourcesDblClick
    end
    object D1: TMenuItem
      Caption = 'Download'
      OnClick = D1Click
    end
    object U1: TMenuItem
      Caption = 'Upload'
      OnClick = btnInsertClick
    end
    object D2: TMenuItem
      Caption = 'Delete'
      OnClick = btnDeleteClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object C1: TMenuItem
      Caption = 'Copy link'
      OnClick = C1Click
    end
  end
  object dlgSaveFile: TsSaveDialog
    Filter = 
      'Any file (*.*)|*.*|Acrobat PDF files (*.pdf)|*.pdf|Microsoft Wor' +
      'd (*.doc;*.docx)|*.doc;*.docx|Images (*.jpg;*.png;*.bmp;*.gif)|*' +
      '.jpg;*.png;*.bmp;*.gif|Videos (*.wmv;*.avi;*.mp4)|*.wmv;*.avi;*.' +
      'mp4|Sound (*.mp3)|*.mp3'
    FilterIndex = 0
    Left = 160
    Top = 184
  end
  object dlgOpenFile: TsOpenDialog
    Filter = 
      'Any file (*.*)|*.*|Acrobat PDF files (*.pdf)|*.pdf|Microsoft Wor' +
      'd (*.doc;*.docx)|*.doc;*.docx|Images (*.jpg;*.png;*.bmp;*.gif)|*' +
      '.jpg;*.png;*.bmp;*.gif|Videos (*.wmv;*.avi;*.mp4)|*.wmv;*.avi;*.' +
      'mp4|Sound (*.mp3)|*.mp3'
    FilterIndex = 0
    Left = 160
    Top = 112
  end
  object DropComboTarget1: TDropComboTarget
    DragTypes = [dtCopy, dtLink]
    OnDrop = DropComboTarget1Drop
    Target = Owner
    Left = 372
    Top = 304
  end
  object DropFileSource1: TDropFileSource
    DragTypes = [dtCopy]
    Left = 368
    Top = 384
  end
  object timFilter: TTimer
    Enabled = False
    Interval = 500
    OnTimer = timFilterTimer
    Left = 296
    Top = 240
  end
end
