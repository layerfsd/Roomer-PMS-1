inherited HotelStatusOfflineReportDesign: THotelStatusOfflineReportDesign
  OldCreateOrder = True
  Height = 288
  Width = 311
  inherited frxOfflineReport: TfrxReport
    ReportOptions.LastChange = 42416.682840694450000000
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
            '[frxDBDataset."CompanyID"] - [frxDBDataset."CompanyName"]')
        end
        inherited Memo3: TfrxMemoView
          Top = 20.015770000000000000
          DisplayFormat.FormatStr = 'hh:mm'
          Memo.UTF8W = (
            'Generated at: [Date]')
        end
        inherited Memo5: TfrxMemoView
          Left = 3.779527559055120000
          Width = 472.441250000000000000
          Height = 26.456710000000000000
          Memo.UTF8W = (
            'Roomer Hotel status Offline report')
        end
      end
      inherited MasterData1: TfrxMasterData
        Height = 18.897650000000000000
        Top = 200.315090000000000000
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."Reservation"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 77.267780000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."ReservationName"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 245.346630000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = 'dd mmm yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."Arrival"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 326.834880000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = 'dd mmm yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."Departure"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 405.661720000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."Nights"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 449.913730000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."Room"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 486.709030000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."RoomType"]')
          ParentFont = False
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 279.685220000000000000
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
        Height = 37.795300000000000000
        Top = 102.047310000000000000
        Width = 1046.929810000000000000
        object Line1: TfrxLineView
          Align = baBottom
          Left = 3.779530000000000000
          Top = 37.795300000000000000
          Width = 1035.591220000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo11: TfrxMemoView
          Align = baBottom
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Reservation#')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo12: TfrxMemoView
          Align = baBottom
          Left = 77.267780000000000000
          Top = 18.897650000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Name')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo13: TfrxMemoView
          Align = baBottom
          Left = 245.346630000000000000
          Top = 18.897650000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Arrival')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          Align = baBottom
          Left = 326.055350000000000000
          Top = 18.897650000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Departure')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo15: TfrxMemoView
          Align = baBottom
          Left = 406.102660000000000000
          Top = 18.897650000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Nights')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo16: TfrxMemoView
          Align = baBottom
          Left = 449.913730000000000000
          Top = 18.897650000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Room')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo17: TfrxMemoView
          Align = baBottom
          Left = 486.709030000000000000
          Top = 18.897650000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Type')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo18: TfrxMemoView
          Align = baBottom
          Left = 524.724800000000000000
          Top = 18.897650000000000000
          Width = 37.795275590000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Status')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo22: TfrxMemoView
          Align = baBottom
          Left = 566.929500000000000000
          Top = 18.897650000000000000
          Width = 41.574805590000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Guests')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo23: TfrxMemoView
          Align = baBottom
          Left = 609.504330000000000000
          Top = 18.897650000000000000
          Width = 30.236215590000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Child')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo24: TfrxMemoView
          Align = baBottom
          Left = 640.079160000000000000
          Top = 18.897650000000000000
          Width = 41.574805590000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Infants')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo28: TfrxMemoView
          Left = 566.929500000000000000
          Width = 113.385875590000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Number of')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo29: TfrxMemoView
          Align = baBottom
          Left = 687.874460000000000000
          Top = 18.897650000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Guests')
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
