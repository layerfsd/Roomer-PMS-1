inherited HotelStatusOfflineReportDesign: THotelStatusOfflineReportDesign
  OldCreateOrder = True
  inherited frxDBDataset: TfrxDBDataset
    FieldAliases.Strings = (
      'Dummy=Dummy')
  end
  object frxHotelStatusReport: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Roomer\Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 42412.493217257000000000
    ReportOptions.LastChange = 42423.550791932900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo27OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(Sender).text := <frxDBDataset."ResStatus">;      ' +
        '                                                                ' +
        '                                                                ' +
        '                                    '
      'end;'
      ''
      'begin'
      'end.          ')
    ShowProgress = False
    OnBeforePrint = frxHotelStatusReportBeforePrint
    Left = 40
    Top = 40
    Datasets = <
      item
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 60.472480000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo2: TfrxMemoView
          Align = baRight
          Left = 850.394250000000000000
          Width = 196.535560000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset."CompanyID"] - [frxDBDataset."CompanyName"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = 854.173780000000000000
          Top = 20.015770000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Generated at: [Date]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779527560000000000
          Top = 3.779530000000000000
          Width = 725.669760000000000000
          Height = 26.456710000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Roomer Hotel status Offline report')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baBottom
          Top = 60.472480000000000000
          Width = 1046.929810000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object MasterData1: TfrxMasterData
        Height = 18.897650000000000000
        Top = 241.889920000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
        RowCount = 0
        Stretched = True
        object Memo9: TfrxMemoView
          Left = 80.055350000000000000
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
          SuppressRepeated = True
        end
        object Memo10: TfrxMemoView
          Left = 159.661720000000000000
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
          Left = 203.913730000000000000
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
          Left = 240.709030000000000000
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
        object Memo21: TfrxMemoView
          Left = 320.929500000000000000
          Width = 41.574805590000000000
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
            '[frxDBDataset."NumGuests"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 363.504330000000000000
          Width = 30.236215590000000000
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
            '[frxDBDataset."NumChildren"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 394.079160000000000000
          Width = 41.574805590000000000
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
            '[frxDBDataset."NumInfants"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 441.874460000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."Guests"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 279.354670000000000000
          Width = 37.795275590000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo27OnBeforePrint'
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Test')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 605.669760000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."AvgRate"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 689.701300000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."AvgDiscount"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 741.717070000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."AvgRateAfterDiscount"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 831.819420000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."TotalSales"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
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
          SuppressRepeated = True
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 22.677180000000000000
        Top = 321.260050000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Align = baRight
          Left = 971.339210000000000000
          Top = 3.779530000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 113.385826770000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Printed: [Date]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Width = 1046.929810000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 37.795300000000000000
        Top = 102.047310000000000000
        Width = 1046.929810000000000000
        object Memo13: TfrxMemoView
          Align = baBottom
          Left = 0.346630000000000000
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
          Left = 81.055350000000000000
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
          Left = 161.102660000000000000
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
          Left = 204.913730000000000000
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
          Left = 241.709030000000000000
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
          Left = 279.724800000000000000
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
          Left = 321.929500000000000000
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
          Left = 364.504330000000000000
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
          Left = 395.079160000000000000
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
          Left = 321.929500000000000000
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
          Left = 442.874460000000000000
          Top = 18.897650000000000000
          Width = 132.283550000000000000
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
        object Memo31: TfrxMemoView
          Align = baBottom
          Left = 606.669760000000000000
          Top = 18.897650000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Avg Rate')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo32: TfrxMemoView
          Align = baBottom
          Left = 690.701300000000000000
          Top = 18.897650000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Disc.')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo33: TfrxMemoView
          Align = baBottom
          Left = 742.717070000000000000
          Top = 18.897650000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Net rate')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo7: TfrxMemoView
          Align = baBottom
          Left = 831.819420000000000000
          Top = 18.897650000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Sales')
          ParentFont = False
          VAlign = vaBottom
        end
        object Line3: TfrxLineView
          Align = baBottom
          Left = -36.000000000000000000
          Top = 37.795300000000000000
          Width = 1050.709340000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader1: TfrxGroupHeader
        Height = 18.897650000000000000
        Top = 200.315090000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBDataset."Reservation"'
        object Memo6: TfrxMemoView
          Width = 332.598640000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Reservation: [frxDBDataset."Reservation"] [frxDBDataset."Reserva' +
              'tionName"]')
          ParentFont = False
        end
      end
    end
  end
end
