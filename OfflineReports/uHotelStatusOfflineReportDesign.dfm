inherited HotelStatusOfflineReportDesign: THotelStatusOfflineReportDesign
  OldCreateOrder = True
  inherited frxOfflineReport: TfrxReport
    DataSet = nil
    DataSetName = ''
    ReportOptions.LastChange = 42415.663324201390000000
    Datasets = <
      item
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
      end>
    Variables = <>
    Style = <>
    inherited Page1: TfrxReportPage
      inherited ReportTitle1: TfrxReportTitle
        inherited Memo2: TfrxMemoView
          Memo.UTF8W = (
            'Hotel: ')
        end
        inherited Memo3: TfrxMemoView
          Memo.UTF8W = (
            'Generated at: ')
        end
        inherited Memo5: TfrxMemoView
          Width = 472.441250000000000000
          Height = 26.456710000000000000
          Memo.UTF8W = (
            'Roomer Hotel status Offline report')
        end
      end
      inherited MasterData1: TfrxMasterData
        Top = 185.196970000000000000
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."Reservation"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 98.267780000000000000
          Top = 3.779530000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."ReservationName"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 272.126160000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = 'dd mmm yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."Arrival"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 370.393940000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = 'dd mmm yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."Departure"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 468.661720000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."Nights"]')
          ParentFont = False
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 268.346630000000000000
        inherited Memo1: TfrxMemoView
          Memo.UTF8W = (
            '[Page#]')
        end
        inherited Memo4: TfrxMemoView
          Memo.UTF8W = (
            'Printed: [Date]')
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 22.677180000000000000
        Top = 102.047310000000000000
        Width = 1046.929810000000000000
        object Line1: TfrxLineView
          Align = baBottom
          Left = 3.779530000000000000
          Top = 22.677180000000000000
          Width = 1035.591220000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Reservation#')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo12: TfrxMemoView
          Left = 98.267780000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Name')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo13: TfrxMemoView
          Left = 268.346630000000000000
          Top = 0.779530000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Arrival')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          Left = 366.614410000000000000
          Top = 0.779530000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Departure')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo15: TfrxMemoView
          Left = 464.882190000000000000
          Top = 0.779530000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '# of nights')
          ParentFont = False
          VAlign = vaBottom
        end
      end
    end
  end
  inherited frxDBDataset: TfrxDBDataset
    FieldAliases.Strings = (
      'Dummy=Dummy')
  end
end
