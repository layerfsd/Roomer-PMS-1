inherited HotelStatusOfflineReportDesign: THotelStatusOfflineReportDesign
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxOfflineReport: TfrxReport
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
            'Hotel: [frxDBDataset."fdHotelID"] - [frxDBDataset."fdHotelName"]')
        end
        inherited Memo3: TfrxMemoView
          Memo.UTF8W = (
            'Generated at: [frxDBDataset."fdGeneratedAt"]')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        inherited Memo1: TfrxMemoView
          Memo.UTF8W = (
            '[Page#]')
        end
        inherited Memo4: TfrxMemoView
          Memo.UTF8W = (
            'Printed: [Date]')
        end
      end
    end
  end
end
