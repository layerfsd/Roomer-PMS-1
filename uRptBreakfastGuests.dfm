object frmRptBreakfastGuests: TfrmRptBreakfastGuests
  Left = 0
  Top = 0
  Caption = 'Current breakfast Guests'
  ClientHeight = 577
  ClientWidth = 916
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 916
    Height = 65
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitTop = -2
    object __labLocationsList: TsLabel
      Left = 178
      Top = 41
      Width = 11
      Height = 13
      Caption = 'All'
    end
    object labLocations: TsLabel
      AlignWithMargins = True
      Left = 24
      Top = 41
      Width = 148
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Locations :'
    end
    object btnRefresh: TsButton
      Left = 10
      Top = 10
      Width = 118
      Height = 25
      Caption = 'Refresh'
      Default = True
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 557
    Width = 916
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object Panel5: TsPanel
    Left = 0
    Top = 65
    Width = 916
    Height = 43
    Align = alTop
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object btnExcel: TsButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 128
      Height = 35
      Align = alLeft
      Caption = 'Excel'
      ImageIndex = 115
      Images = DImages.PngImageList1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 0
    end
    object btnReport: TsButton
      AlignWithMargins = True
      Left = 138
      Top = 4
      Width = 128
      Height = 35
      Align = alLeft
      Caption = 'Report'
      ImageIndex = 72
      Images = DImages.PngImageList1
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      ExplicitLeft = 4
    end
  end
  object grBreakfastGuests: TcxGrid
    Left = 0
    Top = 108
    Width = 916
    Height = 449
    Align = alClient
    TabOrder = 3
    ExplicitTop = 97
    ExplicitHeight = 460
    object tvBreakfastGuests: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Bands = <
        item
          Caption = 'Main'
        end
        item
          Caption = 'Extra'
        end>
    end
    object lvBreakfastGuests: TcxGridLevel
      GridView = tvBreakfastGuests
    end
  end
  object kbmBreakfastGuests: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Reservation'
        DataType = ftInteger
      end
      item
        Name = 'Roomreservation'
        DataType = ftInteger
      end
      item
        Name = 'GuestCount'
        DataType = ftInteger
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.22.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 56
    Top = 192
  end
  object BreakfastGuestsDS: TDataSource
    DataSet = kbmBreakfastGuests
    Left = 208
    Top = 200
  end
end
