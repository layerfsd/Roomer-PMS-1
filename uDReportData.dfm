object DReportData: TDReportData
  OldCreateOrder = False
  Height = 509
  Width = 735
  object kbmUnconfirmedInvoicelines_: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = False
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ItemID'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'Itemtype'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'TypeDescription'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'VATCode'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'VATPercentage'
        DataType = ftFloat
      end
      item
        Name = 'Amount'
        DataType = ftFloat
      end
      item
        Name = 'VAT'
        DataType = ftFloat
      end
      item
        Name = 'Itemcount'
        DataType = ftFloat
      end
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'PurchaseDate'
        DataType = ftDateTime
      end
      item
        Name = 'reservation'
        DataType = ftInteger
      end
      item
        Name = 'roomReservation'
        DataType = ftInteger
      end
      item
        Name = 'confirmAmount'
        DataType = ftFloat
      end
      item
        Name = 'Room'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Staff'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'InvoiceNumber'
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
    AfterOpen = kbmUnconfirmedInvoicelines_AfterOpen
    Left = 78
    Top = 34
  end
  object UnconfirmedInvoicelinesDS: TDataSource
    DataSet = kbmUnconfirmedInvoicelines_
    Left = 78
    Top = 106
  end
end
