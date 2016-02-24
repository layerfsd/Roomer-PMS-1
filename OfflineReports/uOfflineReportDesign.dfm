object BaseOfflineReportDesign: TBaseOfflineReportDesign
  OldCreateOrder = False
  Height = 225
  Width = 305
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
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
  object dxOfflineData: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 48
    Top = 136
  end
end
