object frmRptTurnoverAndPayments: TfrmRptTurnoverAndPayments
  Left = 0
  Top = 0
  Caption = 'Turnover and payments'
  ClientHeight = 645
  ClientWidth = 1061
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSimplePanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1061
    Height = 145
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sLabel1: TsLabel
      Left = 494
      Top = 11
      Width = 103
      Height = 16
      Alignment = taRightJustify
      Caption = 'Total turnover :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel2: TsLabel
      Left = 488
      Top = 30
      Width = 109
      Height = 16
      Alignment = taRightJustify
      Caption = 'Total payments :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel3: TsLabel
      Left = 502
      Top = 49
      Width = 95
      Height = 16
      Alignment = taRightJustify
      Caption = 'Total balance :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object labTotalTurnover: TsLabel
      Left = 605
      Top = 11
      Width = 128
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object labTotalPayments: TsLabel
      Left = 605
      Top = 30
      Width = 128
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object labTotalBalance: TsLabel
      Left = 605
      Top = 49
      Width = 128
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel4: TsLabel
      Left = 1016
      Top = 11
      Width = 21
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '1'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object GroupBox1: TsGroupBox
      Left = 9
      Top = 6
      Width = 321
      Height = 92
      Caption = '.. or Unconfirmed'
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object chkGetUnconfirmed: TsCheckBox
        Left = 15
        Top = 18
        Width = 107
        Height = 19
        Caption = 'Get unconfirmed'
        TabOrder = 0
        OnClick = chkGetUnconfirmedClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object btnConfirm: TsButton
        Left = 15
        Top = 44
        Width = 146
        Height = 37
        Caption = 'Confirm now'
        ImageIndex = 82
        Images = DImages.PngImageList1
        TabOrder = 1
        Visible = False
        OnClick = btnConfirmClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object sPanel10: TsPanel
      AlignWithMargins = True
      Left = 3
      Top = 99
      Width = 1055
      Height = 43
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      SkinData.SkinSection = 'TRANSPARENT'
      object btnGetOld: TsButton
        AlignWithMargins = True
        Left = 119
        Top = 3
        Width = 110
        Height = 37
        Align = alLeft
        Caption = 'Get Previus '
        ImageIndex = 51
        Images = DImages.PngImageList1
        TabOrder = 0
        OnClick = btnGetOldClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnRefresh: TsButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 110
        Height = 37
        Align = alLeft
        Caption = 'Refresh ALL'
        ImageIndex = 28
        Images = DImages.PngImageList1
        TabOrder = 1
        OnClick = btnRefreshClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnReportsReport: TsButton
        AlignWithMargins = True
        Left = 235
        Top = 3
        Width = 128
        Height = 37
        Align = alLeft
        Caption = 'Report'
        ImageIndex = 69
        Images = DImages.PngImageList1
        TabOrder = 2
        OnClick = btnReportsReportClick
        SkinData.SkinSection = 'BUTTON'
      end
      object edUnconfirmedDate: TsEdit
        AlignWithMargins = True
        Left = 369
        Top = 11
        Width = 148
        Height = 21
        Margins.Top = 11
        Margins.Bottom = 11
        Align = alLeft
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Visible = False
        SkinData.SkinSection = 'EDIT'
      end
    end
  end
  object LMDStatusBar1: TStatusBar
    Left = 0
    Top = 626
    Width = 1061
    Height = 19
    Panels = <>
  end
  object sPageControl1: TsPageControl
    Left = 0
    Top = 145
    Width = 1061
    Height = 481
    ActivePage = sTabSheet1
    Align = alClient
    TabOrder = 2
    OnChange = sPageControl1Change
    SkinData.SkinSection = 'PAGECONTROL'
    object sTabSheet1: TsTabSheet
      Caption = 'Sum Turnover'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      object sPanel1: TsPanel
        Left = 0
        Top = 0
        Width = 1053
        Height = 43
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnExcelTurnover: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnExcelTurnoverClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grTurnover: TcxGrid
        Left = 0
        Top = 43
        Width = 1053
        Height = 410
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvTurnover: TcxGridDBTableView
          Navigator.Buttons.ConfirmDelete = True
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Visible = False
          Navigator.InfoPanel.Visible = True
          Navigator.InfoPanel.Width = 60
          Navigator.Visible = True
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Amount'
              Column = tvTurnoverAmount
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'VAT'
              Column = tvTurnoverVAT
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'Itemcount'
              Column = tvTurnoverItemcount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsBehavior.NavigatorHints = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          object tvTurnoverItemID: TcxGridDBColumn
            Caption = 'Item'
            DataBinding.FieldName = 'ItemID'
            Width = 91
          end
          object tvTurnoverDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 165
          end
          object tvTurnoverItemtype: TcxGridDBColumn
            Caption = 'Item type'
            DataBinding.FieldName = 'Itemtype'
            Width = 138
          end
          object tvTurnoverTypeDescription: TcxGridDBColumn
            Caption = 'Type description'
            DataBinding.FieldName = 'TypeDescription'
            Width = 171
          end
          object tvTurnoverItemcount: TcxGridDBColumn
            Caption = 'Count'
            DataBinding.FieldName = 'Itemcount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Width = 67
          end
          object tvTurnoverAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            OnGetProperties = tvTurnoverAmountGetProperties
            Width = 82
          end
          object tvTurnoverVAT: TcxGridDBColumn
            DataBinding.FieldName = 'VAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvTurnoverVATGetProperties
            Width = 70
          end
          object tvTurnoverVATCode: TcxGridDBColumn
            Caption = 'VAT code'
            DataBinding.FieldName = 'VATCode'
            Width = 74
          end
          object tvTurnoverVATPercentage: TcxGridDBColumn
            Caption = 'VAT %'
            DataBinding.FieldName = 'VATPercentage'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.##%;-#,##0.##%'
          end
        end
        object lvTurnover: TcxGridLevel
          GridView = tvTurnover
        end
      end
    end
    object Payments: TsTabSheet
      Caption = 'Sum Payments'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grPayments: TcxGrid
        Left = 0
        Top = 43
        Width = 1053
        Height = 410
        Align = alClient
        TabOrder = 0
        LookAndFeel.NativeStyle = False
        object tvPayments: TcxGridDBTableView
          Navigator.Buttons.ConfirmDelete = True
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Visible = False
          Navigator.InfoPanel.Visible = True
          Navigator.InfoPanel.Width = 60
          Navigator.Visible = True
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Amount'
              Column = tvPaymentsAmount
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'PaymentCount'
              Column = tvPaymentsPaymentCount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          object tvPaymentsPayType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'PayType'
          end
          object tvPaymentspaytypeDescription: TcxGridDBColumn
            Caption = 'Description'
            DataBinding.FieldName = 'paytypeDescription'
            Width = 147
          end
          object tvPaymentsPaymentCount: TcxGridDBColumn
            Caption = 'Count'
            DataBinding.FieldName = 'PaymentCount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Width = 88
          end
          object tvPaymentsAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvPaymentsAmountGetProperties
            Width = 94
          end
          object tvPaymentspaygroupDescripion: TcxGridDBColumn
            Caption = 'Group'
            DataBinding.FieldName = 'paygroupDescripion'
            Width = 183
          end
        end
        object lvPayments: TcxGridLevel
          GridView = tvPayments
        end
      end
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 1053
        Height = 43
        Align = alTop
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object btnExcelPayments: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnExcelPaymentsClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
    object sTabSheet2: TsTabSheet
      Caption = 'List Unpaid roomrent'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel4: TsPanel
        Left = 0
        Top = 0
        Width = 1053
        Height = 43
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton2: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton2Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton23: TsButton
          AlignWithMargins = True
          Left = 138
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Reservation'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = sButton23Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton6: TsButton
          AlignWithMargins = True
          Left = 272
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Invoice'
          ImageIndex = 63
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = sButton6Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grRoomsDate: TcxGrid
        Left = 0
        Top = 43
        Width = 1053
        Height = 410
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvRoomsDate: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'DiscountAmount'
              Column = tvRoomsDateDiscountAmount
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalStayTax'
              Column = tvRoomsDateTotalStayTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'RentAmount'
              Column = tvRoomsDateRentAmount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          object tvRoomsDateStayDate: TcxGridDBColumn
            Caption = 'Stay Date'
            DataBinding.FieldName = 'StayDate'
          end
          object tvRoomsDateRentAmount: TcxGridDBColumn
            Caption = 'Rent Amount'
            DataBinding.FieldName = 'RentAmount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvRoomsDateRentAmountGetProperties
          end
          object tvRoomsDatecurrency: TcxGridDBColumn
            Caption = 'Currency'
            DataBinding.FieldName = 'currency'
            Width = 63
          end
          object tvRoomsDateconfirmdate: TcxGridDBColumn
            Caption = 'Confirm- date'
            DataBinding.FieldName = 'confirmdate'
            Width = 82
          end
          object tvRoomsDatecurrencyRate: TcxGridDBColumn
            Caption = 'Currency Rate'
            DataBinding.FieldName = 'currencyRate'
          end
          object tvRoomsDateisTaxIncluted: TcxGridDBColumn
            Caption = 'Is Tax Incluted'
            DataBinding.FieldName = 'isTaxIncluted'
            Width = 51
          end
          object tvRoomsDateDiscountAmount: TcxGridDBColumn
            Caption = 'Discount Amount'
            DataBinding.FieldName = 'DiscountAmount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvRoomsDateDiscountAmountGetProperties
          end
          object tvRoomsDateTotalStayTax: TcxGridDBColumn
            Caption = 'Total City tax'
            DataBinding.FieldName = 'TotalStayTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvRoomsDateTotalStayTaxGetProperties
          end
          object tvRoomsDateinvoicenumber: TcxGridDBColumn
            Caption = 'Invoice number'
            DataBinding.FieldName = 'invoicenumber'
          end
          object tvRoomsDateid: TcxGridDBColumn
            DataBinding.FieldName = 'id'
            Visible = False
          end
          object tvRoomsDatereservation: TcxGridDBColumn
            Caption = 'Reservation'
            DataBinding.FieldName = 'reservation'
            Width = 68
          end
          object tvRoomsDateroomreservation: TcxGridDBColumn
            Caption = 'Room Reservation'
            DataBinding.FieldName = 'roomreservation'
            Width = 67
          end
        end
        object lvRoomsDate: TcxGridLevel
          GridView = tvRoomsDate
        end
      end
    end
    object sTabSheet3: TsTabSheet
      Caption = 'List Invoiced Roomrent'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel3: TsPanel
        Left = 0
        Top = 0
        Width = 1053
        Height = 43
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton1: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton1Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton19: TsButton
          AlignWithMargins = True
          Left = 138
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Invoice'
          ImageIndex = 63
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = sButton19Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grRoomrentOnInvoice: TcxGrid
        Left = 0
        Top = 43
        Width = 1053
        Height = 410
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvRoomrentOnInvoice: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Amount'
              Column = tvRoomrentOnInvoiceAmount
            end
            item
              Format = ',0.;-,0. '
              Kind = skSum
              FieldName = 'Itemcount'
              Column = tvRoomrentOnInvoiceItemcount
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'totalStayTax'
              Column = tvRoomrentOnInvoicetotalStayTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'VAT'
              Column = tvRoomrentOnInvoiceVAT
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          object tvRoomrentOnInvoiceInvoiceNumber: TcxGridDBColumn
            Caption = 'Invoice number'
            DataBinding.FieldName = 'InvoiceNumber'
          end
          object tvRoomrentOnInvoiceRoom: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
          end
          object tvRoomrentOnInvoiceStaff: TcxGridDBColumn
            Caption = 'User'
            DataBinding.FieldName = 'Staff'
          end
          object tvRoomrentOnInvoiceItemID: TcxGridDBColumn
            Caption = 'Item'
            DataBinding.FieldName = 'ItemID'
            Width = 77
          end
          object tvRoomrentOnInvoiceDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 117
          end
          object tvRoomrentOnInvoiceItemtype: TcxGridDBColumn
            Caption = 'Item Type'
            DataBinding.FieldName = 'Itemtype'
            Width = 82
          end
          object tvRoomrentOnInvoiceTypeDescription: TcxGridDBColumn
            Caption = 'Type Description'
            DataBinding.FieldName = 'TypeDescription'
            Width = 107
          end
          object tvRoomrentOnInvoiceVATCode: TcxGridDBColumn
            Caption = 'VAT Code'
            DataBinding.FieldName = 'VATCode'
          end
          object tvRoomrentOnInvoiceVATPercentage: TcxGridDBColumn
            Caption = 'VAT %'
            DataBinding.FieldName = 'VATPercentage'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00%;-,0.00%'
            Width = 63
          end
          object tvRoomrentOnInvoiceAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvRoomrentOnInvoiceAmountGetProperties
            Width = 96
          end
          object tvRoomrentOnInvoiceVAT: TcxGridDBColumn
            DataBinding.FieldName = 'VAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvRoomrentOnInvoiceVATGetProperties
          end
          object tvRoomrentOnInvoiceItemcount: TcxGridDBColumn
            Caption = 'Items'
            DataBinding.FieldName = 'Itemcount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Width = 84
          end
          object tvRoomrentOnInvoiceisTaxIncluted: TcxGridDBColumn
            Caption = 'Is Tax Incluted'
            DataBinding.FieldName = 'isTaxIncluted'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Width = 48
          end
          object tvRoomrentOnInvoicetotalStayTax: TcxGridDBColumn
            Caption = 'Total City Tax'
            DataBinding.FieldName = 'totalStayTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvRoomrentOnInvoicetotalStayTaxGetProperties
          end
          object tvRoomrentOnInvoicesplitNumber: TcxGridDBColumn
            DataBinding.FieldName = 'splitNumber'
            Visible = False
          end
        end
        object lvRoomrentOnInvoice: TcxGridLevel
          GridView = tvRoomrentOnInvoice
        end
      end
    end
    object sTabSheet4: TsTabSheet
      Caption = 'List Invoices'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel5: TsPanel
        Left = 0
        Top = 0
        Width = 1053
        Height = 43
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnInvoiceListExcel: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 129
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnInvoiceListExcelClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnInvoiceListExpandAll: TsButton
          AlignWithMargins = True
          Left = 787
          Top = 4
          Width = 128
          Height = 35
          Align = alRight
          Caption = 'Expand all'
          TabOrder = 1
          OnClick = btnInvoiceListExpandAllClick
        end
        object btnInvoiceListContractAll: TsButton
          AlignWithMargins = True
          Left = 921
          Top = 4
          Width = 128
          Height = 35
          Align = alRight
          Caption = 'Contract all'
          TabOrder = 2
          OnClick = btnInvoiceListContractAllClick
        end
        object btnInvoiceListInvoice: TsButton
          AlignWithMargins = True
          Left = 139
          Top = 4
          Width = 129
          Height = 35
          Align = alLeft
          Caption = 'Invoice'
          ImageIndex = 63
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = btnInvoiceListInvoiceClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnInvoiceListReservation: TsButton
          AlignWithMargins = True
          Left = 274
          Top = 4
          Width = 129
          Height = 35
          Align = alLeft
          Caption = 'Reservation'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 4
          OnClick = btnInvoiceListReservationClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grInvoicelist: TcxGrid
        Left = 0
        Top = 43
        Width = 1053
        Height = 410
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvInvoiceHeads: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DetailKeyFieldNames = 'InvoiceNumber'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'ihAmountWithTax'
              Column = tvInvoiceHeadsihAmountWithTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'ihAmountNoTax'
              Column = tvInvoiceHeadsihAmountNoTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'ihAmountTax'
              Column = tvInvoiceHeadsihAmountTax
            end
            item
              Format = ',0.;-,0.'
              Kind = skCount
              FieldName = 'InvoiceNumber'
              Column = tvInvoiceHeadsInvoiceNumber
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'isKredit'
              Column = tvInvoiceHeadsisKredit
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalStayTax'
              Column = tvInvoiceHeadsTotalStayTax
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'TotalStayTaxNights'
              Column = tvInvoiceHeadsTotalStayTaxNights
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'isCash'
              Column = tvInvoiceHeadsisCash
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'isGroup'
              Column = tvInvoiceHeadsisGroup
            end
            item
              Format = ',0.;-,0.'
              Kind = skSum
              FieldName = 'isRoom'
              Column = tvInvoiceHeadsisRoom
            end
            item
              Format = ',0.;-,0.'
              Kind = skCount
              FieldName = 'Reservation'
              Column = tvInvoiceHeadsReservation
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterAutoHeight = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          object tvInvoiceHeadsRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvInvoiceHeadsInvoiceNumber: TcxGridDBColumn
            Caption = 'Number'
            DataBinding.FieldName = 'InvoiceNumber'
            Width = 48
          end
          object tvInvoiceHeadsInvoiceDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'InvoiceDate'
            Width = 77
          end
          object tvInvoiceHeadsihAmountWithTax: TcxGridDBColumn
            Caption = 'Amount'
            DataBinding.FieldName = 'ihAmountWithTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceHeadsihAmountWithTaxGetProperties
            Width = 84
          end
          object tvInvoiceHeadsihAmountNoTax: TcxGridDBColumn
            Caption = 'W/O VAT'
            DataBinding.FieldName = 'ihAmountNoTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceHeadsihAmountNoTaxGetProperties
            Width = 70
          end
          object tvInvoiceHeadsihAmountTax: TcxGridDBColumn
            Caption = 'VAT'
            DataBinding.FieldName = 'ihAmountTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceHeadsihAmountTaxGetProperties
            Width = 72
          end
          object tvInvoiceHeadsCustomer: TcxGridDBColumn
            DataBinding.FieldName = 'Customer'
            Width = 90
          end
          object tvInvoiceHeadsCustomerName: TcxGridDBColumn
            Caption = 'Customer Name'
            DataBinding.FieldName = 'CustomerName'
            Width = 140
          end
          object tvInvoiceHeadsNameOnInvoice: TcxGridDBColumn
            Caption = 'Name on Invoice'
            DataBinding.FieldName = 'NameOnInvoice'
            Width = 140
          end
          object tvInvoiceHeadsAddress1: TcxGridDBColumn
            DataBinding.FieldName = 'Address1'
            Width = 100
          end
          object tvInvoiceHeadsAddress2: TcxGridDBColumn
            DataBinding.FieldName = 'Address2'
            Width = 100
          end
          object tvInvoiceHeadsAddress3: TcxGridDBColumn
            DataBinding.FieldName = 'Address3'
            Width = 100
          end
          object tvInvoiceHeadsRoomGuest: TcxGridDBColumn
            Caption = 'Roomguest'
            DataBinding.FieldName = 'RoomGuest'
            Width = 112
          end
          object tvInvoiceHeadsisAgency: TcxGridDBColumn
            Caption = 'Agency'
            DataBinding.FieldName = 'isAgency'
          end
          object tvInvoiceHeadsisKredit: TcxGridDBColumn
            DataBinding.FieldName = 'isKredit'
          end
          object tvInvoiceHeadsisRoom: TcxGridDBColumn
            DataBinding.FieldName = 'isRoom'
          end
          object tvInvoiceHeadsisGroup: TcxGridDBColumn
            DataBinding.FieldName = 'isGroup'
          end
          object tvInvoiceHeadsisCash: TcxGridDBColumn
            DataBinding.FieldName = 'isCash'
          end
          object tvInvoiceHeadsdueDate: TcxGridDBColumn
            Caption = 'Due date'
            DataBinding.FieldName = 'dueDate'
            Width = 88
          end
          object tvInvoiceHeadsinvRefrence: TcxGridDBColumn
            Caption = 'Reference'
            DataBinding.FieldName = 'invRefrence'
            Width = 63
          end
          object tvInvoiceHeadsCreditInvoice: TcxGridDBColumn
            Caption = 'Credit Invoice'
            DataBinding.FieldName = 'CreditInvoice'
            Width = 77
          end
          object tvInvoiceHeadsOriginalInvoice: TcxGridDBColumn
            Caption = 'Original Invoice'
            DataBinding.FieldName = 'OriginalInvoice'
            Width = 69
          end
          object tvInvoiceHeadsReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
            Width = 75
          end
          object tvInvoiceHeadsRoomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'RoomReservation'
            Visible = False
            Width = 72
          end
          object tvInvoiceHeadsSplitNumber: TcxGridDBColumn
            DataBinding.FieldName = 'SplitNumber'
            Visible = False
          end
          object tvInvoiceHeadsTotalStayTax: TcxGridDBColumn
            Caption = 'City Tax'
            DataBinding.FieldName = 'TotalStayTax'
            OnGetProperties = tvInvoiceHeadsTotalStayTaxGetProperties
          end
          object tvInvoiceHeadsTotalStayTaxNights: TcxGridDBColumn
            Caption = 'Lodging Nights'
            DataBinding.FieldName = 'TotalStayTaxNights'
          end
          object tvInvoiceHeadsConfirmedDate: TcxGridDBColumn
            Caption = 'Confirmed date'
            DataBinding.FieldName = 'ConfirmedDate'
          end
          object tvInvoiceHeadsCurrency: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
          end
          object tvInvoiceHeadsRate: TcxGridDBColumn
            DataBinding.FieldName = 'Rate'
          end
          object tvInvoiceHeadsStaff: TcxGridDBColumn
            DataBinding.FieldName = 'Staff'
          end
          object tvInvoiceHeadsmarkedSegment: TcxGridDBColumn
            Caption = 'Marked'
            DataBinding.FieldName = 'markedSegment'
          end
          object tvInvoiceHeadsmarkedSegmentDescription: TcxGridDBColumn
            Caption = 'Marked Name'
            DataBinding.FieldName = 'markedSegmentDescription'
          end
        end
        object tvInvoiceLines: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          DataController.DetailKeyFieldNames = 'InvoiceNumber'
          DataController.KeyFieldNames = 'InvoiceNumber'
          DataController.MasterKeyFieldNames = 'InvoiceNumber'
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              FieldName = 'AmountWithTax'
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountWithTax'
              Column = tvInvoiceLinesilAmountWithTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountNoTax'
              Column = tvInvoiceLinesilAmountNoTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'AmountTax'
              Column = tvInvoiceLinesilAmountTax
            end
            item
              Format = ',0.;-,0.'
              Kind = skCount
              FieldName = 'Item'
              Column = tvInvoiceLinesItem
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object tvInvoiceLinesRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvInvoiceLinesItem: TcxGridDBColumn
            DataBinding.FieldName = 'Item'
            Width = 80
          end
          object tvInvoiceLinesDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 120
          end
          object tvInvoiceLinesQuantity: TcxGridDBColumn
            DataBinding.FieldName = 'Quantity'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Width = 48
          end
          object tvInvoiceLinesPrice: TcxGridDBColumn
            DataBinding.FieldName = 'Price'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-#,##0.00'
          end
          object tvInvoiceLinesVATType: TcxGridDBColumn
            DataBinding.FieldName = 'VATType'
          end
          object tvInvoiceLinesilAmountWithTax: TcxGridDBColumn
            DataBinding.FieldName = 'ilAmountWithTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceLinesilAmountWithTaxGetProperties
          end
          object tvInvoiceLinesilAmountNoTax: TcxGridDBColumn
            DataBinding.FieldName = 'ilAmountNoTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceLinesilAmountNoTaxGetProperties
          end
          object tvInvoiceLinesilAmountTax: TcxGridDBColumn
            DataBinding.FieldName = 'ilAmountTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceLinesilAmountTaxGetProperties
          end
          object tvInvoiceLinesCurrency: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
          end
          object tvInvoiceLinesCurrencyRate: TcxGridDBColumn
            DataBinding.FieldName = 'CurrencyRate'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-#,##0.00'
          end
          object tvInvoiceLinesImportRefrence: TcxGridDBColumn
            DataBinding.FieldName = 'ImportRefrence'
            Width = 72
          end
          object tvInvoiceLinesPurchaseDate: TcxGridDBColumn
            DataBinding.FieldName = 'PurchaseDate'
          end
          object tvInvoiceLinesImportSource: TcxGridDBColumn
            DataBinding.FieldName = 'ImportSource'
            Width = 64
          end
          object tvInvoiceLinesInvoiceNumber: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceNumber'
            Visible = False
          end
        end
        object lvInvoiceHeads: TcxGridLevel
          GridView = tvInvoiceHeads
          object lvInvoiceLines: TcxGridLevel
            GridView = tvInvoiceLines
          end
        end
      end
    end
    object sTabSheet6: TsTabSheet
      Caption = 'Unconfirmed items'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel7: TsPanel
        Left = 0
        Top = 0
        Width = 1053
        Height = 43
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton7: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton7Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton8: TsButton
          AlignWithMargins = True
          Left = 272
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Invoice'
          ImageIndex = 63
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = sButton8Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton9: TsButton
          AlignWithMargins = True
          Left = 138
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Reservation'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = sButton9Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grUnconfirmedInvoicelines: TcxGrid
        Left = 0
        Top = 43
        Width = 1053
        Height = 410
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvUnconfirmedInvoicelines: TcxGridDBTableView
          Navigator.Buttons.ConfirmDelete = True
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Visible = False
          Navigator.InfoPanel.Visible = True
          Navigator.InfoPanel.Width = 60
          Navigator.Visible = True
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'Amount'
              Column = tvUnconfirmedInvoicelinesAmount
            end
            item
              Kind = skSum
              FieldName = 'VAT'
              Column = tvUnconfirmedInvoicelinesVAT
            end
            item
              Kind = skSum
              FieldName = 'Itemcount'
              Column = tvUnconfirmedInvoicelinesItemcount
            end
            item
              Kind = skSum
              FieldName = 'confirmAmount'
              Column = tvUnconfirmedInvoicelinesconfirmAmount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsBehavior.NavigatorHints = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          object tvUnconfirmedInvoicelinesPurchaseDate: TcxGridDBColumn
            Caption = 'Purchase Date'
            DataBinding.FieldName = 'PurchaseDate'
            Width = 93
          end
          object tvUnconfirmedInvoicelinesRoom: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
          end
          object tvUnconfirmedInvoicelinesStaff: TcxGridDBColumn
            Caption = 'User'
            DataBinding.FieldName = 'Staff'
            Width = 50
          end
          object tvUnconfirmedInvoicelinesInvoiceNumber: TcxGridDBColumn
            Caption = 'Invoice no'
            DataBinding.FieldName = 'InvoiceNumber'
            HeaderAlignmentHorz = taRightJustify
          end
          object tvUnconfirmedInvoicelinesItemID: TcxGridDBColumn
            Caption = 'Item'
            DataBinding.FieldName = 'ItemID'
            Width = 83
          end
          object tvUnconfirmedInvoicelinesDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 182
          end
          object tvUnconfirmedInvoicelinesItemcount: TcxGridDBColumn
            Caption = 'Items'
            DataBinding.FieldName = 'Itemcount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
          end
          object tvUnconfirmedInvoicelinesItemtype: TcxGridDBColumn
            Caption = 'Item Type'
            DataBinding.FieldName = 'Itemtype'
            Width = 125
          end
          object tvUnconfirmedInvoicelinesAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            OnGetProperties = tvUnconfirmedInvoicelinesAmountGetProperties
            Width = 84
          end
          object tvUnconfirmedInvoicelinesTypeDescription: TcxGridDBColumn
            Caption = 'Type Description'
            DataBinding.FieldName = 'TypeDescription'
            Width = 128
          end
          object tvUnconfirmedInvoicelinesVATCode: TcxGridDBColumn
            Caption = 'VAT Code'
            DataBinding.FieldName = 'VATCode'
            Width = 84
          end
          object tvUnconfirmedInvoicelinesVATPercentage: TcxGridDBColumn
            Caption = 'VAT %'
            DataBinding.FieldName = 'VATPercentage'
          end
          object tvUnconfirmedInvoicelinesVAT: TcxGridDBColumn
            DataBinding.FieldName = 'VAT'
            OnGetProperties = tvUnconfirmedInvoicelinesVATGetProperties
          end
          object tvUnconfirmedInvoicelinesconfirmAmount: TcxGridDBColumn
            Caption = 'Confirmed Amount'
            DataBinding.FieldName = 'confirmAmount'
            OnGetProperties = tvUnconfirmedInvoicelinesconfirmAmountGetProperties
            Width = 81
          end
          object tvUnconfirmedInvoicelinesreservation: TcxGridDBColumn
            Caption = 'Reservation'
            DataBinding.FieldName = 'reservation'
          end
          object tvUnconfirmedInvoicelinesroomReservation: TcxGridDBColumn
            Caption = 'Room Reservation'
            DataBinding.FieldName = 'roomReservation'
          end
          object tvUnconfirmedInvoicelinesid: TcxGridDBColumn
            DataBinding.FieldName = 'id'
            Visible = False
          end
        end
        object lvUnconfirmedInvoicelines: TcxGridLevel
          GridView = tvUnconfirmedInvoicelines
        end
      end
    end
    object sTabSheet7: TsTabSheet
      Caption = 'Confirmed Item Changed Price'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel8: TsPanel
        Left = 0
        Top = 0
        Width = 1053
        Height = 43
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton11: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton11Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton13: TsButton
          AlignWithMargins = True
          Left = 138
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Reservation'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = sButton13Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grInvoiceLinePriceChange: TcxGrid
        Left = 0
        Top = 43
        Width = 1053
        Height = 410
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvInvoiceLinePriceChange: TcxGridDBTableView
          Navigator.Buttons.ConfirmDelete = True
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Visible = False
          Navigator.InfoPanel.Visible = True
          Navigator.InfoPanel.Width = 60
          Navigator.Visible = True
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'Amount'
              Column = tvInvoiceLinePriceChangeAmount
            end
            item
              Kind = skSum
              FieldName = 'VAT'
              Column = tvInvoiceLinePriceChangeVAT
            end
            item
              Kind = skSum
              FieldName = 'Itemcount'
              Column = tvInvoiceLinePriceChangeItemcount
            end
            item
              Kind = skSum
              FieldName = 'confirmAmount'
              Column = tvInvoiceLinePriceChangeconfirmAmount
            end
            item
              Kind = skSum
              FieldName = 'PriceChange'
              Column = tvInvoiceLinePriceChangePriceChange
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsBehavior.NavigatorHints = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          object tvInvoiceLinePriceChangePurchaseDate: TcxGridDBColumn
            Caption = 'Purchase Date'
            DataBinding.FieldName = 'PurchaseDate'
          end
          object tvInvoiceLinePriceChangeItemID: TcxGridDBColumn
            Caption = 'Item'
            DataBinding.FieldName = 'ItemID'
            Width = 80
          end
          object tvInvoiceLinePriceChangeDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 182
          end
          object tvInvoiceLinePriceChangeItemcount: TcxGridDBColumn
            Caption = 'Item count'
            DataBinding.FieldName = 'Itemcount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
          end
          object tvInvoiceLinePriceChangeAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceLinePriceChangeAmountGetProperties
          end
          object tvInvoiceLinePriceChangeconfirmAmount: TcxGridDBColumn
            Caption = 'Confirm Amount'
            DataBinding.FieldName = 'confirmAmount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceLinePriceChangeconfirmAmountGetProperties
          end
          object tvInvoiceLinePriceChangePriceChange: TcxGridDBColumn
            Caption = 'Price Change'
            DataBinding.FieldName = 'PriceChange'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceLinePriceChangePriceChangeGetProperties
          end
          object tvInvoiceLinePriceChangeItemtype: TcxGridDBColumn
            Caption = 'Item Type'
            DataBinding.FieldName = 'Itemtype'
            Width = 89
          end
          object tvInvoiceLinePriceChangeTypeDescription: TcxGridDBColumn
            Caption = 'Type Description'
            DataBinding.FieldName = 'TypeDescription'
            Width = 143
          end
          object tvInvoiceLinePriceChangeVATCode: TcxGridDBColumn
            Caption = 'VAT Code'
            DataBinding.FieldName = 'VATCode'
            Width = 67
          end
          object tvInvoiceLinePriceChangeVATPercentage: TcxGridDBColumn
            Caption = 'VAT %'
            DataBinding.FieldName = 'VATPercentage'
          end
          object tvInvoiceLinePriceChangeVAT: TcxGridDBColumn
            DataBinding.FieldName = 'VAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceLinePriceChangeVATGetProperties
          end
          object tvInvoiceLinePriceChangereservation: TcxGridDBColumn
            Caption = 'Reservation'
            DataBinding.FieldName = 'reservation'
          end
          object tvInvoiceLinePriceChangeroomReservation: TcxGridDBColumn
            Caption = 'Room Reservation'
            DataBinding.FieldName = 'roomReservation'
          end
          object tvInvoiceLinePriceChangeid: TcxGridDBColumn
            DataBinding.FieldName = 'id'
            Visible = False
          end
        end
        object lvInvoiceLinePriceChange: TcxGridLevel
          GridView = tvInvoiceLinePriceChange
        end
      end
    end
    object sTabSheet8: TsTabSheet
      Caption = 'Confirmed Roomrent Pricechange'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel9: TsPanel
        Left = 0
        Top = 0
        Width = 1053
        Height = 43
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton15: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          HotImageIndex = 132
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton15Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton17: TsButton
          AlignWithMargins = True
          Left = 138
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Reservation'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = sButton17Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grRoomsDateChange: TcxGrid
        Left = 0
        Top = 43
        Width = 1053
        Height = 410
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvRoomsDateChange: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'DiscountAmount'
              Column = tvRoomsDateChangeDiscountAmount
            end
            item
              Kind = skSum
              FieldName = 'TotalStayTax'
              Column = tvRoomsDateChangeTotalStayTax
            end
            item
              Kind = skSum
              FieldName = 'RentAmount'
              Column = tvRoomsDateChangeRentAmount
            end
            item
              Kind = skSum
              FieldName = 'RentChange'
              Column = tvRoomsDateChangeRentChange
            end
            item
              Kind = skSum
              FieldName = 'DiscountChange'
              Column = tvRoomsDateChangeDiscountChange
            end
            item
              Kind = skSum
              FieldName = 'TaxChange'
              Column = tvRoomsDateChangeTaxChange
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          object tvRoomsDateChangeStayDate: TcxGridDBColumn
            Caption = 'Stay Date'
            DataBinding.FieldName = 'StayDate'
            Width = 76
          end
          object tvRoomsDateChangeconfirmdate: TcxGridDBColumn
            Caption = 'Confirm date'
            DataBinding.FieldName = 'confirmdate'
            Width = 91
          end
          object tvRoomsDateChangeRentAmount: TcxGridDBColumn
            Caption = 'Rent Amount'
            DataBinding.FieldName = 'RentAmount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvRoomsDateChangeRentAmountGetProperties
          end
          object tvRoomsDateChangeisTaxIncluted: TcxGridDBColumn
            Caption = 'Is Tax Incluted'
            DataBinding.FieldName = 'isTaxIncluted'
            Width = 46
          end
          object tvRoomsDateChangeDiscountAmount: TcxGridDBColumn
            Caption = 'Discount Amount'
            DataBinding.FieldName = 'DiscountAmount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvRoomsDateChangeDiscountAmountGetProperties
          end
          object tvRoomsDateChangeTotalStayTax: TcxGridDBColumn
            Caption = 'Total City Tax'
            DataBinding.FieldName = 'TotalStayTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
          end
          object tvRoomsDateChangeid: TcxGridDBColumn
            DataBinding.FieldName = 'id'
            Visible = False
          end
          object tvRoomsDateChangeinvoicenumber: TcxGridDBColumn
            Caption = 'Invoice number'
            DataBinding.FieldName = 'invoicenumber'
          end
          object tvRoomsDateChangeDiscountChange: TcxGridDBColumn
            Caption = 'Discount Change'
            DataBinding.FieldName = 'DiscountChange'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceHeadsTotalStayTaxGetProperties
          end
          object tvRoomsDateChangeTaxChange: TcxGridDBColumn
            Caption = 'Tax Change'
            DataBinding.FieldName = 'TaxChange'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceHeadsihAmountNoTaxGetProperties
          end
          object tvRoomsDateChangeRentChange: TcxGridDBColumn
            Caption = 'Rent Change'
            DataBinding.FieldName = 'RentChange'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            OnGetProperties = tvInvoiceHeadsihAmountNoTaxGetProperties
          end
          object tvRoomsDateChangecurrency: TcxGridDBColumn
            Caption = 'Currency'
            DataBinding.FieldName = 'currency'
            Width = 57
          end
          object tvRoomsDateChangecurrencyRate: TcxGridDBColumn
            Caption = 'Currency Rate'
            DataBinding.FieldName = 'currencyRate'
          end
          object tvRoomsDateChangereservation: TcxGridDBColumn
            Caption = 'Reservation'
            DataBinding.FieldName = 'reservation'
          end
          object tvRoomsDateChangeroomreservation: TcxGridDBColumn
            Caption = 'Room Reservation'
            DataBinding.FieldName = 'roomreservation'
            Width = 85
          end
        end
        object lvRoomsDateChange: TcxGridLevel
          GridView = tvRoomsDateChange
        end
      end
    end
    object sTabSheet5: TsTabSheet
      Caption = 'PaymentList'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sPanel6: TsPanel
        Left = 0
        Top = 0
        Width = 1053
        Height = 43
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton3: TsButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = sButton3Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton4: TsButton
          AlignWithMargins = True
          Left = 138
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Invoice'
          ImageIndex = 63
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = sButton4Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sButton5: TsButton
          AlignWithMargins = True
          Left = 272
          Top = 4
          Width = 128
          Height = 35
          Align = alLeft
          Caption = 'Reservation'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 2
          OnClick = sButton5Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grPaymentList: TcxGrid
        Left = 0
        Top = 43
        Width = 1053
        Height = 410
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        object tvPaymentList: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Post.Enabled = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.InfoPanel.Visible = True
          Navigator.Visible = True
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'Amount'
              Column = tvPaymentListAmount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          object tvPaymentListdtPayDate: TcxGridDBColumn
            Caption = 'Pay date'
            DataBinding.FieldName = 'dtPayDate'
            Width = 84
          end
          object tvPaymentListMedhod: TcxGridDBColumn
            DataBinding.FieldName = 'Medhod'
            Width = 79
          end
          object tvPaymentListAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            OnGetProperties = tvPaymentListAmountGetProperties
            Width = 98
          end
          object tvPaymentListDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 163
          end
          object tvPaymentListPayType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'PayType'
            Width = 113
          end
          object tvPaymentListpaytypeDescription: TcxGridDBColumn
            Caption = 'Type description'
            DataBinding.FieldName = 'paytypeDescription'
            Width = 162
          end
          object tvPaymentListpaygroupDescripion: TcxGridDBColumn
            Caption = 'Paygroup descripion'
            DataBinding.FieldName = 'paygroupDescripion'
            Width = 156
          end
          object tvPaymentListinvoicenumber: TcxGridDBColumn
            Caption = 'Invoice number'
            DataBinding.FieldName = 'invoicenumber'
            Width = 69
          end
          object tvPaymentListcustomer: TcxGridDBColumn
            Caption = 'Customer'
            DataBinding.FieldName = 'customer'
          end
          object tvPaymentListcustomername: TcxGridDBColumn
            Caption = 'Customer name'
            DataBinding.FieldName = 'customername'
            Width = 214
          end
          object tvPaymentListNameOnInvoice: TcxGridDBColumn
            Caption = 'Name On Invoice'
            DataBinding.FieldName = 'NameOnInvoice'
            Width = 262
          end
          object tvPaymentListreservation: TcxGridDBColumn
            Caption = 'Reservation'
            DataBinding.FieldName = 'reservation'
            Width = 70
          end
          object tvPaymentListroomreservation: TcxGridDBColumn
            Caption = 'Room Reservation'
            DataBinding.FieldName = 'roomreservation'
          end
        end
        object lvPaymentList: TcxGridLevel
          GridView = tvPaymentList
        end
      end
    end
  end
  object rptTurnowerPayments: TppReport
    AutoStop = False
    DataPipeline = ppDBPPayments
    NoDataBehaviors = [ndBlankReport]
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    ModalCancelDialog = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    Left = 128
    Top = 368
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPPayments'
    object ppTitleBand1: TppTitleBand
      BeforePrint = ppTitleBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 26458
      mmPrintPosition = 0
      object ppLabel5: TppLabel
        UserName = 'Label5'
        Caption = 'Turnover and Payments Overview'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4995
        mmLeft = 2381
        mmTop = 3440
        mmWidth = 67860
        BandType = 1
        LayerName = Foreground1
      end
      object labConfirmdate: TppLabel
        UserName = 'labConfirmdate'
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4995
        mmLeft = 3440
        mmTop = 9790
        mmWidth = 1397
        BandType = 1
        LayerName = Foreground1
      end
      object rLabHotelName: TppLabel
        UserName = 'rLabHotelName'
        Caption = 'Hotel name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 180182
        mmTop = 1323
        mmWidth = 15610
        BandType = 1
        LayerName = Foreground1
      end
      object rlabUser: TppLabel
        UserName = 'rLabUser'
        Caption = 'hj'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 192882
        mmTop = 5556
        mmWidth = 2910
        BandType = 1
        LayerName = Foreground1
      end
      object rLabTimeCreated: TppLabel
        UserName = 'rLabTimeCreated'
        Caption = '01.01.2010 22:33'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 170657
        mmTop = 10319
        mmWidth = 25135
        BandType = 1
        LayerName = Foreground1
      end
    end
    object ppHeaderBand2: TppHeaderBand
      Background.Brush.Style = bsClear
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 14023
      mmPrintPosition = 0
      object ppSubReport1: TppSubReport
        UserName = 'SubReport1'
        ExpandAll = False
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        TraverseAllData = False
        DataPipelineName = 'ppDBPTurnover'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 1323
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground1
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        object ppChildReport1: TppChildReport
          AutoStop = False
          DataPipeline = ppDBPTurnover
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.PaperName = 'A4'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.SaveDeviceSettings = False
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 297000
          PrinterSetup.mmPaperWidth = 210000
          PrinterSetup.PaperSize = 9
          Version = '14.07'
          mmColumnWidth = 0
          DataPipelineName = 'ppDBPTurnover'
          object ppTitleBand2: TppTitleBand
            Background.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 13229
            mmPrintPosition = 0
            object ppLabel3: TppLabel
              UserName = 'Label3'
              Caption = 'Turnover'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 12
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4995
              mmLeft = 265
              mmTop = 7408
              mmWidth = 17992
              BandType = 1
              LayerName = Foreground
            end
          end
          object ppDetailBand1: TppDetailBand
            Background1.Brush.Style = bsClear
            Background2.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 5027
            mmPrintPosition = 0
            object ppDBText5: TppDBText
              UserName = 'DBText5'
              DataField = 'ItemID'
              DataPipeline = ppDBPTurnover
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppDBPTurnover'
              mmHeight = 3969
              mmLeft = 25135
              mmTop = 265
              mmWidth = 25665
              BandType = 4
              LayerName = Foreground
            end
            object ppDBText6: TppDBText
              UserName = 'DBText6'
              DataField = 'Description'
              DataPipeline = ppDBPTurnover
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppDBPTurnover'
              mmHeight = 3969
              mmLeft = 53711
              mmTop = 265
              mmWidth = 70115
              BandType = 4
              LayerName = Foreground
            end
            object ppDBText7: TppDBText
              UserName = 'DBText7'
              DataField = 'Amount'
              DataPipeline = ppDBPTurnover
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppDBPTurnover'
              mmHeight = 3969
              mmLeft = 126736
              mmTop = 265
              mmWidth = 32015
              BandType = 4
              LayerName = Foreground
            end
          end
          object ppSummaryBand2: TppSummaryBand
            Background.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 8202
            mmPrintPosition = 0
            object ppLabel4: TppLabel
              UserName = 'Label4'
              Caption = 'Total Turnover'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 12
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4995
              mmLeft = 92075
              mmTop = 794
              mmWidth = 28998
              BandType = 7
              LayerName = Foreground
            end
            object ppDBCalc2: TppDBCalc
              UserName = 'DBCalc2'
              DataField = 'Amount'
              DataPipeline = ppDBPTurnover
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppDBPTurnover'
              mmHeight = 4233
              mmLeft = 126736
              mmTop = 794
              mmWidth = 32015
              BandType = 7
              LayerName = Foreground
            end
          end
          object ppDesignLayers1: TppDesignLayers
            object ppDesignLayer1: TppDesignLayer
              UserName = 'Foreground'
              LayerType = ltBanded
              Index = 0
            end
          end
        end
      end
      object ppSubReport2: TppSubReport
        UserName = 'SubReport2'
        ExpandAll = False
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        ShiftRelativeTo = ppSubReport1
        TraverseAllData = False
        DataPipelineName = 'ppDBPPayments'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 7673
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground1
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        object ppChildReport2: TppChildReport
          AutoStop = False
          DataPipeline = ppDBPPayments
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.PaperName = 'A4'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.SaveDeviceSettings = False
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 297000
          PrinterSetup.mmPaperWidth = 210000
          PrinterSetup.PaperSize = 9
          Version = '14.07'
          mmColumnWidth = 0
          DataPipelineName = 'ppDBPPayments'
          object ppTitleBand3: TppTitleBand
            Background.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 17727
            mmPrintPosition = 0
            object ppLabel1: TppLabel
              UserName = 'Label1'
              Caption = 'Payments'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 12
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 5027
              mmLeft = 0
              mmTop = 12171
              mmWidth = 19844
              BandType = 1
              LayerName = Foreground2
            end
          end
          object ppDetailBand3: TppDetailBand
            Background1.Brush.Style = bsClear
            Background2.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 5556
            mmPrintPosition = 0
            object ppDBText1: TppDBText
              UserName = 'DBText1'
              DataField = 'PayType'
              DataPipeline = ppDBPPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppDBPPayments'
              mmHeight = 3969
              mmLeft = 25400
              mmTop = 265
              mmWidth = 25929
              BandType = 4
              LayerName = Foreground2
            end
            object ppDBText2: TppDBText
              UserName = 'DBText2'
              DataField = 'Amount'
              DataPipeline = ppDBPPayments
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppDBPPayments'
              mmHeight = 4022
              mmLeft = 127265
              mmTop = 265
              mmWidth = 31485
              BandType = 4
              LayerName = Foreground2
            end
            object ppDBText3: TppDBText
              UserName = 'DBText3'
              DataField = 'paytypeDescription'
              DataPipeline = ppDBPPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppDBPPayments'
              mmHeight = 3969
              mmLeft = 53975
              mmTop = 265
              mmWidth = 69056
              BandType = 4
              LayerName = Foreground2
            end
          end
          object ppSummaryBand3: TppSummaryBand
            Background.Brush.Style = bsClear
            mmBottomOffset = 0
            mmHeight = 8996
            mmPrintPosition = 0
            object ppDBCalc1: TppDBCalc
              UserName = 'DBCalc1'
              DataField = 'Amount'
              DataPipeline = ppDBPPayments
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = [fsBold]
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppDBPPayments'
              mmHeight = 4233
              mmLeft = 127265
              mmTop = 794
              mmWidth = 31485
              BandType = 7
              LayerName = Foreground2
            end
            object ppLabel2: TppLabel
              UserName = 'Label2'
              Caption = 'Total Payments'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 12
              Font.Style = [fsBold]
              Transparent = True
              mmHeight = 4995
              mmLeft = 92075
              mmTop = 794
              mmWidth = 30946
              BandType = 7
              LayerName = Foreground2
            end
          end
          object ppDesignLayers3: TppDesignLayers
            object ppDesignLayer3: TppDesignLayer
              UserName = 'Foreground2'
              LayerType = ltBanded
              Index = 0
            end
          end
        end
      end
    end
    object ppDetailBand2: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppFooterBand2: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 10848
      mmPrintPosition = 0
      object ppLabel8: TppLabel
        UserName = 'Label8'
        Caption = 'Page :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 2117
        mmTop = 5821
        mmWidth = 9260
        BandType = 8
        LayerName = Foreground1
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtPageSet
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 11906
        mmTop = 5821
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground1
      end
    end
    object ppSummaryBand1: TppSummaryBand
      BeforePrint = ppSummaryBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 35719
      mmPrintPosition = 0
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = 'Total Payments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5027
        mmLeft = 5556
        mmTop = 12171
        mmWidth = 30956
        BandType = 7
        LayerName = Foreground1
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        Caption = 'Total Turnover'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5027
        mmLeft = 7408
        mmTop = 5821
        mmWidth = 29104
        BandType = 7
        LayerName = Foreground1
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Caption = 'Balance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4995
        mmLeft = 5556
        mmTop = 22754
        mmWidth = 29633
        BandType = 7
        LayerName = Foreground1
      end
      object rLabBalance: TppLabel
        UserName = 'rLabBalance'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4191
        mmLeft = 39952
        mmTop = 22754
        mmWidth = 31485
        BandType = 7
        LayerName = Foreground1
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Weight = 0.750000000000000000
        mmHeight = 2381
        mmLeft = 6615
        mmTop = 19050
        mmWidth = 64823
        BandType = 7
        LayerName = Foreground1
      end
      object rlabTotalTurnover: TppLabel
        UserName = 'rLabBalance1'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 39952
        mmTop = 5821
        mmWidth = 31485
        BandType = 7
        LayerName = Foreground1
      end
      object rlabTotalPayments: TppLabel
        UserName = 'rlabTotalPayments'
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 39952
        mmTop = 12965
        mmWidth = 31485
        BandType = 7
        LayerName = Foreground1
      end
    end
    object ppDesignLayers2: TppDesignLayers
      object ppDesignLayer2: TppDesignLayer
        UserName = 'Foreground1'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList2: TppParameterList
    end
  end
  object ppDBPPayments: TppDBPipeline
    OpenDataSource = False
    UserName = 'DBPPayments'
    Left = 128
    Top = 480
    object ppDBPPaymentsppField1: TppField
      FieldAlias = 'PayType'
      FieldName = 'PayType'
      FieldLength = 20
      DisplayWidth = 20
      Position = 0
    end
    object ppDBPPaymentsppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'Amount'
      FieldName = 'Amount'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 1
    end
    object ppDBPPaymentsppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'PaymentCount'
      FieldName = 'PaymentCount'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 2
    end
    object ppDBPPaymentsppField4: TppField
      FieldAlias = 'paytypeDescription'
      FieldName = 'paytypeDescription'
      FieldLength = 60
      DisplayWidth = 60
      Position = 3
    end
    object ppDBPPaymentsppField5: TppField
      FieldAlias = 'paygroupDescripion'
      FieldName = 'paygroupDescripion'
      FieldLength = 60
      DisplayWidth = 60
      Position = 4
    end
  end
  object ppDBPTurnover: TppDBPipeline
    OpenDataSource = False
    UserName = 'DBPTurnover'
    Left = 120
    Top = 424
    object ppDBPTurnoverppField1: TppField
      FieldAlias = 'ItemID'
      FieldName = 'ItemID'
      FieldLength = 40
      DisplayWidth = 40
      Position = 0
    end
    object ppDBPTurnoverppField2: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 60
      DisplayWidth = 60
      Position = 1
    end
    object ppDBPTurnoverppField3: TppField
      FieldAlias = 'Itemtype'
      FieldName = 'Itemtype'
      FieldLength = 40
      DisplayWidth = 40
      Position = 2
    end
    object ppDBPTurnoverppField4: TppField
      FieldAlias = 'TypeDescription'
      FieldName = 'TypeDescription'
      FieldLength = 60
      DisplayWidth = 60
      Position = 3
    end
    object ppDBPTurnoverppField5: TppField
      FieldAlias = 'VATCode'
      FieldName = 'VATCode'
      FieldLength = 20
      DisplayWidth = 20
      Position = 4
    end
    object ppDBPTurnoverppField6: TppField
      Alignment = taRightJustify
      FieldAlias = 'VATPercentage'
      FieldName = 'VATPercentage'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 5
    end
    object ppDBPTurnoverppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'Amount'
      FieldName = 'Amount'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 6
    end
    object ppDBPTurnoverppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'VAT'
      FieldName = 'VAT'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 7
    end
    object ppDBPTurnoverppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'Itemcount'
      FieldName = 'Itemcount'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 8
    end
  end
end
