object frmTestTax: TfrmTestTax
  Left = 0
  Top = 0
  Caption = 'frmTestTax'
  ClientHeight = 632
  ClientWidth = 986
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
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 986
    Height = 81
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sLabel1: TsLabel
      Left = 32
      Top = 19
      Width = 92
      Height = 13
      Caption = 'RoomReservation :'
    end
    object sLabel2: TsLabel
      Left = 58
      Top = 33
      Width = 68
      Height = 13
      Caption = 'Reservation : '
    end
    object sLabel4: TsLabel
      Left = 65
      Top = 55
      Width = 56
      Height = 13
      Caption = 'Customer : '
    end
    object sLabel5: TsLabel
      Left = 125
      Top = 55
      Width = 4
      Height = 13
      Caption = '-'
    end
    object labReservation: TsLabel
      Left = 130
      Top = 33
      Width = 4
      Height = 13
      Caption = '-'
    end
    object labRoomreservation: TsLabel
      Left = 130
      Top = 19
      Width = 4
      Height = 13
      Caption = '-'
    end
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 613
    Width = 986
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 81
    Width = 986
    Height = 532
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object sMemo1: TsMemo
        Left = 0
        Top = 41
        Width = 978
        Height = 168
        Align = alTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'sMemo1')
        ParentFont = False
        TabOrder = 0
        Text = 'sMemo1'
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        SkinData.SkinSection = 'EDIT'
      end
      object sPanel2: TsPanel
        Left = 0
        Top = 0
        Width = 978
        Height = 41
        Align = alTop
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object sButton1: TsButton
          Left = 8
          Top = 8
          Width = 75
          Height = 25
          Caption = 'sButton1'
          TabOrder = 0
          OnClick = sButton1Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object sPanel3: TsPanel
        Left = 0
        Top = 0
        Width = 978
        Height = 41
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sButton2: TsButton
          Left = 8
          Top = 10
          Width = 75
          Height = 25
          Caption = 'sButton1'
          TabOrder = 0
          OnClick = sButton2Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object grTaxes: TcxGrid
        Left = 0
        Top = 41
        Width = 978
        Height = 463
        Align = alClient
        TabOrder = 1
        object tvTaxes: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = TaxesDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          object tvTaxesRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvTaxesReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
          end
          object tvTaxesRoomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'RoomReservation'
            Width = 89
          end
          object tvTaxestheDate: TcxGridDBColumn
            DataBinding.FieldName = 'theDate'
          end
          object tvTaxesItem: TcxGridDBColumn
            DataBinding.FieldName = 'Item'
            Width = 66
          end
          object tvTaxesRoomWithVAT: TcxGridDBColumn
            DataBinding.FieldName = 'RoomWithVAT'
            Width = 79
          end
          object tvTaxesRoomWithoutVAT: TcxGridDBColumn
            DataBinding.FieldName = 'RoomWithoutVAT'
            Width = 98
          end
          object tvTaxesVAT: TcxGridDBColumn
            DataBinding.FieldName = 'VAT'
            Width = 69
          end
          object tvTaxesTax: TcxGridDBColumn
            DataBinding.FieldName = 'Tax'
            Width = 78
          end
          object tvTaxesRoom: TcxGridDBColumn
            DataBinding.FieldName = 'Room'
          end
          object tvTaxesRoomType: TcxGridDBColumn
            DataBinding.FieldName = 'RoomType'
          end
          object tvTaxesresFlag: TcxGridDBColumn
            DataBinding.FieldName = 'resFlag'
          end
          object tvTaxesRoomRate: TcxGridDBColumn
            DataBinding.FieldName = 'RoomRate'
          end
          object tvTaxesdiscount: TcxGridDBColumn
            DataBinding.FieldName = 'discount'
          end
          object tvTaxesisPercentage: TcxGridDBColumn
            DataBinding.FieldName = 'isPercentage'
          end
          object tvTaxesRateWithDiscount: TcxGridDBColumn
            DataBinding.FieldName = 'RateWithDiscount'
          end
          object tvTaxesCurrency: TcxGridDBColumn
            DataBinding.FieldName = 'Currency'
          end
          object tvTaxespaid: TcxGridDBColumn
            DataBinding.FieldName = 'paid'
          end
          object tvTaxesinvoicenumber: TcxGridDBColumn
            DataBinding.FieldName = 'invoicenumber'
          end
          object tvTaxesconfirmdate: TcxGridDBColumn
            DataBinding.FieldName = 'confirmdate'
          end
          object tvTaxesGuestCount: TcxGridDBColumn
            DataBinding.FieldName = 'GuestCount'
          end
        end
        object lvTaxes: TcxGridLevel
          GridView = tvTaxes
        end
      end
    end
  end
  object Taxes_: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 184
    Top = 80
    object Taxes_Reservation: TIntegerField
      FieldName = 'Reservation'
    end
    object Taxes_RoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object Taxes_theDate: TDateField
      FieldName = 'theDate'
    end
    object Taxes_Item: TStringField
      FieldName = 'Item'
    end
    object Taxes_RoomWithVAT: TFloatField
      FieldName = 'RoomWithVAT'
    end
    object Taxes_RoomWithoutVAT: TFloatField
      FieldName = 'RoomWithoutVAT'
    end
    object Taxes_VAT: TFloatField
      FieldName = 'VAT'
    end
    object Taxes_Tax: TFloatField
      FieldName = 'Tax'
    end
    object Taxes_Room: TStringField
      FieldName = 'Room'
    end
    object Taxes_RoomType: TStringField
      FieldName = 'RoomType'
    end
    object Taxes_resFlag: TStringField
      FieldName = 'resFlag'
      Size = 1
    end
    object Taxes_RoomRate: TFloatField
      FieldName = 'RoomRate'
    end
    object Taxes_discount: TFloatField
      FieldName = 'discount'
    end
    object Taxes_isPercentage: TBooleanField
      FieldName = 'isPercentage'
    end
    object Taxes_RateWithDiscount: TFloatField
      FieldName = 'RateWithDiscount'
    end
    object Taxes_Currency: TStringField
      FieldName = 'Currency'
      Size = 3
    end
    object Taxes_paid: TBooleanField
      FieldName = 'paid'
    end
    object Taxes_invoicenumber: TIntegerField
      FieldName = 'invoicenumber'
    end
    object Taxes_confirmdate: TDateTimeField
      FieldName = 'confirmdate'
    end
    object Taxes_GuestCount: TIntegerField
      FieldName = 'GuestCount'
    end
  end
  object TaxesDS: TDataSource
    DataSet = Taxes_
    Left = 264
    Top = 80
  end
end
