object FrmAlertPanel: TFrmAlertPanel
  Left = 0
  Top = 0
  ClientHeight = 150
  ClientWidth = 1011
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlAlertsHolder: TsPanel
    Left = 0
    Top = 0
    Width = 1011
    Height = 150
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'TRANSPARENT'
    object sPanel8: TsPanel
      Left = 0
      Top = 0
      Width = 1011
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object btnInsert: TsButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 90
        Height = 24
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
      object btnEdit: TsButton
        AlignWithMargins = True
        Left = 99
        Top = 3
        Width = 91
        Height = 24
        Hint = 'Edit current record'
        Align = alLeft
        Caption = 'Edit'
        Enabled = False
        ImageIndex = 25
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnEditClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnDelete: TsButton
        AlignWithMargins = True
        Left = 196
        Top = 3
        Width = 90
        Height = 24
        Align = alLeft
        Caption = 'Delete'
        Enabled = False
        ImageIndex = 24
        Images = DImages.PngImageList1
        TabOrder = 2
        OnClick = btnDeleteClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object lvAlerts: TsListView
      Left = 0
      Top = 30
      Width = 1011
      Height = 120
      SkinData.SkinSection = 'EDIT'
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Columns = <
        item
          Caption = 'Alert on'
          Width = 150
        end
        item
          Caption = 'Alert text'
          Width = 800
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      ParentFont = False
      TabOrder = 1
      ViewStyle = vsReport
      OnDblClick = btnEditClick
      OnSelectItem = lvAlertsSelectItem
    end
  end
end
