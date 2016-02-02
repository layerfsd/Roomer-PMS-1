object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Guest Reviews'
  ClientHeight = 592
  ClientWidth = 747
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 747
    Height = 56
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      747
      56)
    object btnDelete: TsButton
      Left = 197
      Top = 10
      Width = 92
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Delete'
      ImageIndex = 24
      Images = DImages.PngImageList1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object btnClose: TsButton
      Left = 630
      Top = 9
      Width = 105
      Height = 34
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 27
      Images = DImages.PngImageList1
      ModalResult = 8
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
    object btnInsert: TsButton
      Left = 9
      Top = 9
      Width = 92
      Height = 34
      Hint = 'Add new record'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'New'
      ImageIndex = 23
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEdit: TsButton
      Left = 103
      Top = 9
      Width = 92
      Height = 34
      Hint = 'Edit current record'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Edit'
      ImageIndex = 25
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      SkinData.SkinSection = 'BUTTON'
    end
    object btnRefresh: TsButton
      Left = 522
      Top = 9
      Width = 104
      Height = 34
      Hint = 'Refresh'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      Caption = 'Refresh'
      ImageIndex = 28
      Images = DImages.PngImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object sListView1: TsListView
    Left = 0
    Top = 56
    Width = 747
    Height = 536
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
    Color = clWhite
    Columns = <
      item
        Caption = 'Channel'
        Width = 150
      end
      item
        Caption = 'Email'
        Width = 150
      end
      item
        Caption = 'Email Language'
      end
      item
        Caption = 'Country'
        Width = 70
      end
      item
        Caption = 'Rev lang'
        Width = 70
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 1
    ViewStyle = vsReport
  end
end
