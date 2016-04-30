object frmInvoiceCompare: TfrmInvoiceCompare
  Left = 0
  Top = 0
  Caption = 'invoicecompare'
  ClientHeight = 569
  ClientWidth = 1065
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1065
    Height = 41
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sPanel3: TsPanel
      Left = 1
      Top = 1
      Width = 1063
      Height = 41
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object sButton1: TsButton
        Left = 16
        Top = 9
        Width = 75
        Height = 25
        Caption = 'getAfter'
        TabOrder = 0
        OnClick = sButton1Click
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 550
    Width = 1065
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object sPageControl1: TsPageControl
    Left = 0
    Top = 41
    Width = 1065
    Height = 509
    ActivePage = sTabSheet1
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PAGECONTROL'
    object sTabSheet1: TsTabSheet
      Caption = 'Invoicehead'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sSplitter1: TsSplitter
        Left = 0
        Top = 197
        Width = 1057
        Height = 6
        Cursor = crVSplit
        Align = alTop
        SkinData.SkinSection = 'SPLITTER'
        ExplicitTop = 161
        ExplicitWidth = 198
      end
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 1057
        Height = 16
        Align = alTop
        Caption = 'before'
        Color = clGreen
        ParentBackground = False
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
      object sPanel6: TsPanel
        Left = 0
        Top = 16
        Width = 1057
        Height = 181
        Align = alTop
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        ExplicitTop = 25
        object gridInvoiceLines_before: TcxGrid
          Left = 1
          Top = 1
          Width = 1055
          Height = 179
          Align = alClient
          TabOrder = 0
          object tvInvoiceLines_before: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = mInvoicelines_beforeDS
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            object tvInvoiceLines_beforeisSystemLine: TcxGridDBColumn
              DataBinding.FieldName = 'isSystemLine'
              PropertiesClassName = 'TcxCheckBoxProperties'
            end
            object tvInvoiceLines_beforeAutoGen: TcxGridDBColumn
              DataBinding.FieldName = 'AutoGen'
              Width = 100
            end
            object tvInvoiceLines_beforeReservation: TcxGridDBColumn
              DataBinding.FieldName = 'Reservation'
              Width = 100
            end
            object tvInvoiceLines_beforeRoomReservation: TcxGridDBColumn
              DataBinding.FieldName = 'RoomReservation'
              Width = 100
            end
            object tvInvoiceLines_beforeSplitNumber: TcxGridDBColumn
              DataBinding.FieldName = 'SplitNumber'
              Width = 100
            end
            object tvInvoiceLines_beforeItemNumber: TcxGridDBColumn
              DataBinding.FieldName = 'ItemNumber'
              Width = 100
            end
            object tvInvoiceLines_beforeInvoiceNumber: TcxGridDBColumn
              DataBinding.FieldName = 'InvoiceNumber'
              Width = 100
            end
            object tvInvoiceLines_beforeItemID: TcxGridDBColumn
              DataBinding.FieldName = 'ItemID'
              Width = 100
            end
            object tvInvoiceLines_beforeNumber: TcxGridDBColumn
              DataBinding.FieldName = 'Number'
              Width = 100
            end
            object tvInvoiceLines_beforeDescription: TcxGridDBColumn
              DataBinding.FieldName = 'Description'
              Width = 100
            end
            object tvInvoiceLines_beforePrice: TcxGridDBColumn
              DataBinding.FieldName = 'Price'
              Width = 100
            end
            object tvInvoiceLines_beforeVATType: TcxGridDBColumn
              DataBinding.FieldName = 'VATType'
              Width = 100
            end
            object tvInvoiceLines_beforeTotal: TcxGridDBColumn
              DataBinding.FieldName = 'Total'
              Width = 100
            end
            object tvInvoiceLines_beforeTotalWOVAT: TcxGridDBColumn
              DataBinding.FieldName = 'TotalWOVAT'
              Width = 100
            end
            object tvInvoiceLines_beforeVat: TcxGridDBColumn
              DataBinding.FieldName = 'Vat'
              Width = 100
            end
            object tvInvoiceLines_beforeAutoGenerated: TcxGridDBColumn
              DataBinding.FieldName = 'AutoGenerated'
              Width = 100
            end
            object tvInvoiceLines_beforeCurrencyRate: TcxGridDBColumn
              DataBinding.FieldName = 'CurrencyRate'
              Width = 100
            end
            object tvInvoiceLines_beforeCurrency: TcxGridDBColumn
              DataBinding.FieldName = 'Currency'
              Width = 100
            end
            object tvInvoiceLines_beforeReportDate: TcxGridDBColumn
              DataBinding.FieldName = 'ReportDate'
              Width = 100
            end
            object tvInvoiceLines_beforeReportTime: TcxGridDBColumn
              DataBinding.FieldName = 'ReportTime'
              Width = 100
            end
            object tvInvoiceLines_beforePersons: TcxGridDBColumn
              DataBinding.FieldName = 'Persons'
              Width = 100
            end
            object tvInvoiceLines_beforeNights: TcxGridDBColumn
              DataBinding.FieldName = 'Nights'
              Width = 100
            end
            object tvInvoiceLines_beforeBreakfastPrice: TcxGridDBColumn
              DataBinding.FieldName = 'BreakfastPrice'
              Width = 100
            end
            object tvInvoiceLines_beforeAYear: TcxGridDBColumn
              DataBinding.FieldName = 'AYear'
              Width = 100
            end
            object tvInvoiceLines_beforeAMon: TcxGridDBColumn
              DataBinding.FieldName = 'AMon'
              Width = 100
            end
            object tvInvoiceLines_beforeADay: TcxGridDBColumn
              DataBinding.FieldName = 'ADay'
              Width = 100
            end
            object tvInvoiceLines_beforeilTmp: TcxGridDBColumn
              DataBinding.FieldName = 'ilTmp'
              Width = 100
            end
            object tvInvoiceLines_beforeilID: TcxGridDBColumn
              DataBinding.FieldName = 'ilID'
              Width = 100
            end
            object tvInvoiceLines_beforeilAccountKey: TcxGridDBColumn
              DataBinding.FieldName = 'ilAccountKey'
              Width = 100
            end
            object tvInvoiceLines_beforeItemCurrency: TcxGridDBColumn
              DataBinding.FieldName = 'ItemCurrency'
              Width = 100
            end
            object tvInvoiceLines_beforeItemCurrencyRate: TcxGridDBColumn
              DataBinding.FieldName = 'ItemCurrencyRate'
              Width = 100
            end
            object tvInvoiceLines_beforeDiscount: TcxGridDBColumn
              DataBinding.FieldName = 'Discount'
              Width = 100
            end
            object tvInvoiceLines_beforeDiscount_isPrecent: TcxGridDBColumn
              DataBinding.FieldName = 'Discount_isPrecent'
              Width = 100
            end
            object tvInvoiceLines_beforeImportRefrence: TcxGridDBColumn
              DataBinding.FieldName = 'ImportRefrence'
              Width = 100
            end
            object tvInvoiceLines_beforeImportSource: TcxGridDBColumn
              DataBinding.FieldName = 'ImportSource'
              Width = 100
            end
            object tvInvoiceLines_beforeIsPackage: TcxGridDBColumn
              DataBinding.FieldName = 'IsPackage'
              Width = 100
            end
            object tvInvoiceLines_beforeconfirmdate: TcxGridDBColumn
              DataBinding.FieldName = 'confirmdate'
              Width = 100
            end
            object tvInvoiceLines_beforePurchaseDate: TcxGridDBColumn
              DataBinding.FieldName = 'PurchaseDate'
            end
            object tvInvoiceLines_beforeconfirmAmount: TcxGridDBColumn
              DataBinding.FieldName = 'confirmAmount'
            end
            object tvInvoiceLines_beforeRoomReservationAlias: TcxGridDBColumn
              DataBinding.FieldName = 'RoomReservationAlias'
            end
          end
          object lvInvoiceLines_before: TcxGridLevel
            GridView = tvInvoiceLines_before
          end
        end
      end
      object sPanel7: TsPanel
        Left = 0
        Top = 203
        Width = 1057
        Height = 278
        Align = alClient
        TabOrder = 2
        SkinData.SkinSection = 'PANEL'
        ExplicitTop = 212
        ExplicitHeight = 269
        object gridInvoiceLines_after: TcxGrid
          Left = 1
          Top = 18
          Width = 1055
          Height = 259
          Align = alClient
          TabOrder = 0
          ExplicitTop = 73
          ExplicitHeight = 267
          object tvInvoiceLines_after: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = mInvoicelines_afterDS
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            object tvInvoiceLines_afterisSystemLine: TcxGridDBColumn
              DataBinding.FieldName = 'isSystemLine'
              PropertiesClassName = 'TcxCheckBoxProperties'
            end
            object tvInvoiceLines_afterAutoGen: TcxGridDBColumn
              DataBinding.FieldName = 'AutoGen'
              Width = 100
            end
            object tvInvoiceLines_afterReservation: TcxGridDBColumn
              DataBinding.FieldName = 'Reservation'
              Width = 100
            end
            object tvInvoiceLines_afterRoomReservation: TcxGridDBColumn
              DataBinding.FieldName = 'RoomReservation'
              Width = 100
            end
            object tvInvoiceLines_afterSplitNumber: TcxGridDBColumn
              DataBinding.FieldName = 'SplitNumber'
              Width = 100
            end
            object tvInvoiceLines_afterItemNumber: TcxGridDBColumn
              DataBinding.FieldName = 'ItemNumber'
              Width = 100
            end
            object tvInvoiceLines_afterInvoiceNumber: TcxGridDBColumn
              DataBinding.FieldName = 'InvoiceNumber'
              Width = 100
            end
            object tvInvoiceLines_afterItemID: TcxGridDBColumn
              DataBinding.FieldName = 'ItemID'
              Width = 100
            end
            object tvInvoiceLines_afterNumber: TcxGridDBColumn
              DataBinding.FieldName = 'Number'
              Width = 100
            end
            object tvInvoiceLines_afterDescription: TcxGridDBColumn
              DataBinding.FieldName = 'Description'
              Width = 100
            end
            object tvInvoiceLines_afterPrice: TcxGridDBColumn
              DataBinding.FieldName = 'Price'
              Width = 100
            end
            object tvInvoiceLines_afterVATType: TcxGridDBColumn
              DataBinding.FieldName = 'VATType'
              Width = 100
            end
            object tvInvoiceLines_afterTotal: TcxGridDBColumn
              DataBinding.FieldName = 'Total'
              Width = 100
            end
            object tvInvoiceLines_afterTotalWOVAT: TcxGridDBColumn
              DataBinding.FieldName = 'TotalWOVAT'
              Width = 100
            end
            object tvInvoiceLines_afterVat: TcxGridDBColumn
              DataBinding.FieldName = 'Vat'
              Width = 100
            end
            object tvInvoiceLines_afterAutoGenerated: TcxGridDBColumn
              DataBinding.FieldName = 'AutoGenerated'
              Width = 100
            end
            object tvInvoiceLines_afterCurrencyRate: TcxGridDBColumn
              DataBinding.FieldName = 'CurrencyRate'
              Width = 100
            end
            object tvInvoiceLines_afterCurrency: TcxGridDBColumn
              DataBinding.FieldName = 'Currency'
              Width = 100
            end
            object tvInvoiceLines_afterReportDate: TcxGridDBColumn
              DataBinding.FieldName = 'ReportDate'
              Width = 100
            end
            object tvInvoiceLines_afterReportTime: TcxGridDBColumn
              DataBinding.FieldName = 'ReportTime'
              Width = 100
            end
            object tvInvoiceLines_afterPersons: TcxGridDBColumn
              DataBinding.FieldName = 'Persons'
              Width = 100
            end
            object tvInvoiceLines_afterNights: TcxGridDBColumn
              DataBinding.FieldName = 'Nights'
              Width = 100
            end
            object tvInvoiceLines_afterBreakfastPrice: TcxGridDBColumn
              DataBinding.FieldName = 'BreakfastPrice'
              Width = 100
            end
            object tvInvoiceLines_afterAYear: TcxGridDBColumn
              DataBinding.FieldName = 'AYear'
              Width = 100
            end
            object tvInvoiceLines_afterAMon: TcxGridDBColumn
              DataBinding.FieldName = 'AMon'
              Width = 100
            end
            object tvInvoiceLines_afterADay: TcxGridDBColumn
              DataBinding.FieldName = 'ADay'
              Width = 100
            end
            object tvInvoiceLines_afterilTmp: TcxGridDBColumn
              DataBinding.FieldName = 'ilTmp'
              Width = 100
            end
            object tvInvoiceLines_afterilID: TcxGridDBColumn
              DataBinding.FieldName = 'ilID'
              Width = 100
            end
            object tvInvoiceLines_afterilAccountKey: TcxGridDBColumn
              DataBinding.FieldName = 'ilAccountKey'
              Width = 100
            end
            object tvInvoiceLines_afterItemCurrency: TcxGridDBColumn
              DataBinding.FieldName = 'ItemCurrency'
              Width = 100
            end
            object tvInvoiceLines_afterItemCurrencyRate: TcxGridDBColumn
              DataBinding.FieldName = 'ItemCurrencyRate'
              Width = 100
            end
            object tvInvoiceLines_afterDiscount: TcxGridDBColumn
              DataBinding.FieldName = 'Discount'
              Width = 100
            end
            object tvInvoiceLines_afterDiscount_isPrecent: TcxGridDBColumn
              DataBinding.FieldName = 'Discount_isPrecent'
              Width = 100
            end
            object tvInvoiceLines_afterImportRefrence: TcxGridDBColumn
              DataBinding.FieldName = 'ImportRefrence'
              Width = 100
            end
            object tvInvoiceLines_afterImportSource: TcxGridDBColumn
              DataBinding.FieldName = 'ImportSource'
              Width = 100
            end
            object tvInvoiceLines_afterIsPackage: TcxGridDBColumn
              DataBinding.FieldName = 'IsPackage'
              Width = 100
            end
            object tvInvoiceLines_afterconfirmdate: TcxGridDBColumn
              DataBinding.FieldName = 'confirmdate'
              Width = 100
            end
            object tvInvoiceLines_afterPurchaseDate: TcxGridDBColumn
              DataBinding.FieldName = 'PurchaseDate'
            end
            object tvInvoiceLines_afterconfirmAmount: TcxGridDBColumn
              DataBinding.FieldName = 'confirmAmount'
            end
            object tvInvoiceLines_afterRoomReservationAlias: TcxGridDBColumn
              DataBinding.FieldName = 'RoomReservationAlias'
            end
          end
          object lvInvoiceLines_after: TcxGridLevel
            GridView = tvInvoiceLines_after
          end
        end
        object sPanel8: TsPanel
          Left = 1
          Top = 1
          Width = 1055
          Height = 17
          Align = alTop
          Caption = 'after'
          Color = clYellow
          ParentBackground = False
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
        end
      end
    end
    object sTabSheet2: TsTabSheet
      Caption = 'Invoicelines'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel4: TsPanel
        Left = 0
        Top = 0
        Width = 1057
        Height = 41
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
    end
    object sTabSheet3: TsTabSheet
      Caption = 'Payments'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel5: TsPanel
        Left = 0
        Top = 0
        Width = 1057
        Height = 41
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
    end
    object sTabSheet4: TsTabSheet
      Caption = 'Log'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel9: TsPanel
        Left = 0
        Top = 0
        Width = 1057
        Height = 41
        Align = alTop
        Caption = 'log'
        Color = clGreen
        ParentBackground = False
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
      end
      object grInvoiceLog: TcxGrid
        Left = 0
        Top = 41
        Width = 1057
        Height = 440
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 344
        ExplicitTop = 200
        ExplicitWidth = 250
        ExplicitHeight = 200
        object tvInvoiceLog: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = mInvoicelogDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          object tvInvoiceLoguser: TcxGridDBColumn
            DataBinding.FieldName = 'user'
          end
          object tvInvoiceLogreservation: TcxGridDBColumn
            DataBinding.FieldName = 'reservation'
          end
          object tvInvoiceLogroomreservation: TcxGridDBColumn
            DataBinding.FieldName = 'roomreservation'
          end
          object tvInvoiceLoginvoiceIndex: TcxGridDBColumn
            DataBinding.FieldName = 'invoiceIndex'
          end
          object tvInvoiceLogaction: TcxGridDBColumn
            DataBinding.FieldName = 'action'
          end
          object tvInvoiceLogcode: TcxGridDBColumn
            DataBinding.FieldName = 'code'
          end
          object tvInvoiceLogvalue: TcxGridDBColumn
            DataBinding.FieldName = 'value'
          end
          object tvInvoiceLoglineId: TcxGridDBColumn
            DataBinding.FieldName = 'lineId'
          end
          object tvInvoiceLogmoreInfo: TcxGridDBColumn
            DataBinding.FieldName = 'moreInfo'
          end
        end
        object lvInvoiceLog: TcxGridLevel
          GridView = tvInvoiceLog
        end
      end
    end
  end
  object mInvoicelines_beforeDS: TDataSource
    DataSet = d.mInvoicelines_before
    Left = 248
    Top = 344
  end
  object mInvoicelines_afterDS: TDataSource
    DataSet = d.mInvoicelines_after
    Left = 104
    Top = 340
  end
  object mInvoicelogDS: TDataSource
    DataSet = d.mInvoicelog
    Left = 528
    Top = 208
  end
end
