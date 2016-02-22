object BaseOfflineReportDesign: TBaseOfflineReportDesign
  OldCreateOrder = False
  Height = 225
  Width = 305
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    DataSet = kbmOfflineReportDS
    BCDToCurrency = False
    Left = 144
    Top = 40
  end
  object frxOfflinePDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbeddedFonts = True
    PrintOptimized = True
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 100
    Author = 'Roomer'
    Subject = 'FastReport PDF export'
    Creator = 'Roomer'
    Producer = 'Roomer PMS'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = True
    Left = 156
    Top = 132
  end
  object kbmOfflineReportDS: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Dummy'
        DataType = ftString
        Size = 80
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
    Left = 40
    Top = 128
  end
end
