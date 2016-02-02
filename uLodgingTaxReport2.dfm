object frmLodgingTaxReport2: TfrmLodgingTaxReport2
  Left = 961
  Top = 264
  Caption = 'Lodging Tax Report'
  ClientHeight = 641
  ClientWidth = 997
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pageMain: TsPageControl
    Left = 0
    Top = 97
    Width = 997
    Height = 524
    ActivePage = sheetMain
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PAGECONTROL'
    object sheetMain: TsTabSheet
      Caption = 'Main'
      TabVisible = False
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TsPanel
        Left = 0
        Top = 0
        Width = 989
        Height = 45
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object btnExcelS1: TsButton
          Left = 2
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Excel'
          ImageIndex = 132
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = btnExcelS1Click
          SkinData.SkinSection = 'BUTTON'
        end
        object btnReportS1: TsButton
          Left = 108
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Report'
          ImageIndex = 69
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnReportS1Click
          SkinData.SkinSection = 'BUTTON'
        end
        object chkPageBreak: TsCheckBox
          Left = 531
          Top = 4
          Width = 203
          Height = 20
          Caption = 'Page break before summary on report'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object btnShowReservation: TsButton
          Left = 214
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Reservaton'
          ImageIndex = 56
          Images = DImages.PngImageList1
          TabOrder = 3
          OnClick = btnShowReservationClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnShowGuests: TsButton
          Left = 320
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Guests'
          ImageIndex = 39
          Images = DImages.PngImageList1
          TabOrder = 4
          OnClick = btnShowGuestsClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnShowInvoice: TsButton
          Left = 426
          Top = 4
          Width = 100
          Height = 37
          Caption = 'Invoices'
          DropDownMenu = mnuFinishedInv
          ImageIndex = 63
          Images = DImages.PngImageList1
          Style = bsSplitButton
          TabOrder = 5
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object gInvoiceHeads: TcxGrid
        Left = 0
        Top = 45
        Width = 989
        Height = 469
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = cxcbsNone
        TabOrder = 1
        LookAndFeel.NativeStyle = False
        ExplicitTop = 43
        object tvInvoiceHeads: TcxGridDBTableView
          OnDblClick = tvInvoiceHeadsDblClick
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
          DataController.DataSource = mInvoiceHeadsDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'Total'
              Column = tvInvoiceHeadsTotal
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalWOVAT'
              Column = tvInvoiceHeadsTotalWOVAT
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalVAT'
              Column = tvInvoiceHeadsTotalVAT
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalStayTax'
              Column = tvInvoiceHeadsTotalStayTax
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalStayTaxNights'
              Column = tvInvoiceHeadsTotalStayTaxNights
            end
            item
              Kind = skCount
              FieldName = 'InvoiceNumber'
              Column = tvInvoiceHeadsInvoiceNumber
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'totalStayTaxExcluted'
              Column = tvInvoiceHeadstotalStayTaxExcluted
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'TotalTax'
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          object tvInvoiceHeadsRecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            Visible = False
          end
          object tvInvoiceHeadsReservation: TcxGridDBColumn
            DataBinding.FieldName = 'Reservation'
            Visible = False
          end
          object tvInvoiceHeadsRoomReservation: TcxGridDBColumn
            DataBinding.FieldName = 'RoomReservation'
            Visible = False
          end
          object tvInvoiceHeadsInvoiceNumber: TcxGridDBColumn
            Caption = 'Number'
            DataBinding.FieldName = 'InvoiceNumber'
          end
          object tvInvoiceHeadsinvoiceDate: TcxGridDBColumn
            Caption = 'Invoice Date'
            DataBinding.FieldName = 'invoiceDate'
            Width = 82
          end
          object tvInvoiceHeadsCustomer: TcxGridDBColumn
            DataBinding.FieldName = 'Customer'
          end
          object tvInvoiceHeadsName: TcxGridDBColumn
            Caption = 'Name on invoice'
            DataBinding.FieldName = 'Name'
            Width = 117
          end
          object tvInvoiceHeadsTotal: TcxGridDBColumn
            DataBinding.FieldName = 'Total'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvInvoiceHeadsTotalGetProperties
          end
          object tvInvoiceHeadsTotalWOVAT: TcxGridDBColumn
            Caption = 'Total wo VAT'
            DataBinding.FieldName = 'TotalWOVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvInvoiceHeadsTotalWOVATGetProperties
            Width = 85
          end
          object tvInvoiceHeadsTotalVAT: TcxGridDBColumn
            Caption = 'Total VAT'
            DataBinding.FieldName = 'TotalVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvInvoiceHeadsTotalVATGetProperties
            Width = 74
          end
          object tvInvoiceHeadsTotalStayTax: TcxGridDBColumn
            Caption = 'City Tax Incluted'
            DataBinding.FieldName = 'TotalStayTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvInvoiceHeadsTotalStayTaxGetProperties
          end
          object tvInvoiceHeadstotalStayTaxExcluted: TcxGridDBColumn
            Caption = 'City Tax excluted'
            DataBinding.FieldName = 'totalStayTaxExcluted'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvInvoiceHeadstotalStayTaxExclutedGetProperties
            Width = 75
          end
          object tvInvoiceHeadsTotalTax: TcxGridDBColumn
            Caption = 'Total Tax'
            DataBinding.FieldName = 'TotalTax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnGetProperties = tvInvoiceHeadsTotalTaxGetProperties
          end
          object tvInvoiceHeadsTotalStayTaxNights: TcxGridDBColumn
            Caption = 'Total Tax Nights'
            DataBinding.FieldName = 'TotalStayTaxNights'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0. 00;-,0. 00'
            Width = 73
          end
        end
        object lvInvoiceHeads: TcxGridLevel
          GridView = tvInvoiceHeads
        end
      end
    end
  end
  object dxStatusBar1: TsStatusBar
    Left = 0
    Top = 621
    Width = 997
    Height = 20
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object Panel3: TsPanel
    Left = 0
    Top = 0
    Width = 997
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object labLocations: TsLabel
      AlignWithMargins = True
      Left = 481
      Top = 24
      Width = 148
      Height = 25
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Locations :'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object __labLocationsList: TsLabel
      Left = 635
      Top = 24
      Width = 22
      Height = 19
      Caption = 'All'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxGroupBox1: TsGroupBox
      Left = 14
      Top = 11
      Width = 158
      Height = 79
      Caption = 'Select dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object dtDateFrom: TsDateEdit
        Left = 16
        Top = 23
        Width = 121
        Height = 21
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BevelKind = bkFlat
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  -  -    '
        OnChange = dtDateFromChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object dtDateTo: TsDateEdit
        Left = 16
        Top = 50
        Width = 121
        Height = 21
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BevelKind = bkFlat
        Color = clWhite
        EditMask = '!99/99/9999;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  -  -    '
        OnChange = dtDateFromChange
        CheckOnExit = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
    end
    object cxGroupBox2: TsGroupBox
      Left = 178
      Top = 11
      Width = 168
      Height = 79
      Caption = '.. or select month'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object cbxMonth: TsComboBox
        Left = 15
        Top = 22
        Width = 121
        Height = 21
        Alignment = taLeftJustify
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 0
        Text = 'Choose month ...'
        OnCloseUp = cbxMonthCloseUp
        Items.Strings = (
          'Choose month ...'
          'January'
          'February'
          'March'
          'April'
          'may'
          'June'
          'July'
          'August'
          'September'
          'October'
          'November'
          'December')
      end
      object cbxYear: TsComboBox
        Left = 15
        Top = 50
        Width = 121
        Height = 21
        Alignment = taLeftJustify
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2302755
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 1
        Text = 'Choose year ...'
        OnCloseUp = cbxYearCloseUp
        Items.Strings = (
          'Choose year ...'
          '2011'
          '2012'
          '2013'
          '2014'
          '2015'
          '2016'
          '2017'
          '2018'
          '2020')
      end
    end
    object btnRefresh: TsButton
      Left = 352
      Top = 18
      Width = 100
      Height = 37
      Caption = 'Refresh ALL'
      ImageIndex = 28
      Images = DImages.PngImageList1
      TabOrder = 2
      OnClick = btnRefreshClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object mnuFinishedInv: TPopupMenu
    Left = 488
    Top = 264
    object mnuThisRoom: TMenuItem
      Caption = 'Closed this Room'
      OnClick = mnuThisRoomClick
    end
    object mnuThisreservation: TMenuItem
      Caption = 'Closed this reservation'
      OnClick = mnuThisreservationClick
    end
    object OpenthisRoom1: TMenuItem
      Caption = 'Open this Room'
      OnClick = OpenthisRoom1Click
    end
    object OpenGroupInvoice1: TMenuItem
      Caption = 'Open Group Invoice'
      OnClick = OpenGroupInvoice1Click
    end
  end
  object mInvoiceHeads: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 256
    Top = 321
    object mInvoiceHeadsReservation: TIntegerField
      FieldName = 'Reservation'
    end
    object mInvoiceHeadsRoomReservation: TIntegerField
      FieldName = 'RoomReservation'
    end
    object mInvoiceHeadsInvoiceNumber: TIntegerField
      FieldName = 'InvoiceNumber'
    end
    object mInvoiceHeadsCustomer: TWideStringField
      FieldName = 'Customer'
      Size = 15
    end
    object mInvoiceHeadsName: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
    object mInvoiceHeadsTotal: TFloatField
      FieldName = 'Total'
    end
    object mInvoiceHeadsTotalWOVAT: TFloatField
      FieldName = 'TotalWOVAT'
    end
    object mInvoiceHeadsTotalVAT: TFloatField
      FieldName = 'TotalVAT'
    end
    object mInvoiceHeadsTotalStayTax: TFloatField
      FieldName = 'TotalStayTax'
    end
    object mInvoiceHeadsTotalStayTaxNights: TFloatField
      FieldName = 'TotalStayTaxNights'
    end
    object mInvoiceHeadstotalStayTaxExcluted: TFloatField
      FieldName = 'totalStayTaxExcluted'
    end
    object mInvoiceHeadsinvoiceDate: TDateTimeField
      FieldName = 'invoiceDate'
    end
    object mInvoiceHeadsTotalTax: TFloatField
      FieldName = 'TotalTax'
    end
  end
  object mInvoiceHeadsDS: TDataSource
    DataSet = mInvoiceHeads
    Left = 344
    Top = 321
  end
  object rptbLodgingtaxList: TppReport
    AutoStop = False
    DataPipeline = dplMinvoiceheads
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Lodgingtax'
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
    AllowPrintToArchive = True
    AllowPrintToFile = True
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
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
    Left = 48
    Top = 273
    Version = '14.07'
    mmColumnWidth = 0
    DataPipelineName = 'dplMinvoiceheads'
    object ppHeaderBand1: TppHeaderBand
      BeforePrint = ppHeaderBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 20373
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Lodging tax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 7535
        mmLeft = 529
        mmTop = 529
        mmWidth = 36068
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'From :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 1323
        mmTop = 9525
        mmWidth = 9790
        BandType = 0
        LayerName = Foreground
      end
      object rlabFrom: TppLabel
        UserName = 'rLabFrom'
        Caption = '01.01.2010'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 13494
        mmTop = 9790
        mmWidth = 16002
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = 'To :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3810
        mmLeft = 33073
        mmTop = 9525
        mmWidth = 5546
        BandType = 0
        LayerName = Foreground
      end
      object rLabTo: TppLabel
        UserName = 'rLabFrom1'
        Caption = '01.01.2010'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 40746
        mmTop = 9525
        mmWidth = 15875
        BandType = 0
        LayerName = Foreground
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
        mmHeight = 3810
        mmLeft = 180182
        mmTop = 529
        mmWidth = 15579
        BandType = 0
        LayerName = Foreground
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
        mmHeight = 3810
        mmLeft = 170773
        mmTop = 9525
        mmWidth = 25019
        BandType = 0
        LayerName = Foreground
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
        mmHeight = 3810
        mmLeft = 192956
        mmTop = 4763
        mmWidth = 2836
        BandType = 0
        LayerName = Foreground
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Border.Weight = 1.000000000000000000
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 0
        mmTop = 13758
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground
      end
      object rlabCaption_number: TppLabel
        UserName = 'Label11'
        AutoSize = False
        Caption = 'Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3387
        mmLeft = 1323
        mmTop = 16140
        mmWidth = 16140
        BandType = 0
        LayerName = Foreground
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        Border.Weight = 1.000000000000000000
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 0
        mmTop = 20108
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground
      end
      object rlabCaption_date: TppLabel
        UserName = 'rlabCaption_date'
        AutoSize = False
        Caption = 'Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3387
        mmLeft = 18521
        mmTop = 16140
        mmWidth = 16140
        BandType = 0
        LayerName = Foreground
      end
      object rlabCaption_customer: TppLabel
        UserName = 'rlabCaption_customer'
        AutoSize = False
        Caption = 'Name on invoice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3387
        mmLeft = 36513
        mmTop = 16140
        mmWidth = 41804
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel18: TppLabel
        UserName = 'Label18'
        AutoSize = False
        Caption = 'Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3387
        mmLeft = 106363
        mmTop = 16140
        mmWidth = 15081
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel19: TppLabel
        UserName = 'Label19'
        AutoSize = False
        Caption = 'wo VAT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3387
        mmLeft = 123296
        mmTop = 16140
        mmWidth = 15081
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel20: TppLabel
        UserName = 'Label20'
        AutoSize = False
        Caption = 'VAT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3387
        mmLeft = 139700
        mmTop = 16140
        mmWidth = 14288
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel21: TppLabel
        UserName = 'Label201'
        AutoSize = False
        Caption = 'Incluted'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3387
        mmLeft = 156634
        mmTop = 16140
        mmWidth = 15081
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel22: TppLabel
        UserName = 'Label22'
        AutoSize = False
        Caption = 'Nights'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3387
        mmLeft = 185209
        mmTop = 16140
        mmWidth = 10583
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        AutoSize = False
        Caption = 'Customer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3387
        mmLeft = 81756
        mmTop = 16140
        mmWidth = 21431
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel11: TppLabel
        UserName = 'Label12'
        AutoSize = False
        Caption = 'Excluted'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3440
        mmLeft = 169334
        mmTop = 16140
        mmWidth = 15081
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 4498
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'InvoiceNumber'
        DataPipeline = dplMinvoiceheads
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 1323
        mmTop = 794
        mmWidth = 16140
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'Name'
        DataPipeline = dplMinvoiceheads
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 36513
        mmTop = 794
        mmWidth = 41804
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'invoiceDate'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = 'dd.mm.yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 18521
        mmTop = 794
        mmWidth = 16140
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'Total'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 106363
        mmTop = 794
        mmWidth = 15081
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'TotalWOVAT'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,##0'#39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 123296
        mmTop = 794
        mmWidth = 15081
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'TotalVAT'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 139700
        mmTop = 794
        mmWidth = 14288
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'TotalStayTax'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3175
        mmLeft = 157163
        mmTop = 794
        mmWidth = 13758
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        DataField = 'TotalStayTaxNights'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,##0'#39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 186532
        mmTop = 794
        mmWidth = 9260
        BandType = 4
        LayerName = Foreground
      end
      object ppLine11: TppLine
        UserName = 'Line11'
        ParentHeight = True
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 4498
        mmLeft = 104511
        mmTop = 0
        mmWidth = 1323
        BandType = 4
        LayerName = Foreground
      end
      object ppLine12: TppLine
        UserName = 'Line12'
        ParentHeight = True
        Position = lpRight
        Weight = 0.750000000000000000
        mmHeight = 4498
        mmLeft = 154252
        mmTop = 0
        mmWidth = 1323
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText9: TppDBText
        UserName = 'DBText9'
        DataField = 'Customer'
        DataPipeline = dplMinvoiceheads
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3175
        mmLeft = 80169
        mmTop = 794
        mmWidth = 23813
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText10: TppDBText
        UserName = 'DBText10'
        DataField = 'totalStayTaxExcluted'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3175
        mmLeft = 171715
        mmTop = 794
        mmWidth = 13758
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 8202
      mmPrintPosition = 0
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3598
        mmLeft = 3969
        mmTop = 4498
        mmWidth = 720
        BandType = 8
        LayerName = Foreground
      end
    end
    object ppSummaryBand1: TppSummaryBand
      BeforePrint = ppSummaryBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 32808
      mmPrintPosition = 0
      object ppLabel3: TppLabel
        UserName = 'Label3'
        Caption = 'Summery'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5027
        mmLeft = 1323
        mmTop = 10054
        mmWidth = 19315
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Lodging tax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 1588
        mmTop = 20902
        mmWidth = 23283
        BandType = 7
        LayerName = Foreground
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 14552
        mmLeft = 25929
        mmTop = 16140
        mmWidth = 3440
        BandType = 7
        LayerName = Foreground
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 1058
        mmTop = 20108
        mmWidth = 80963
        BandType = 7
        LayerName = Foreground
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 1058
        mmTop = 25135
        mmWidth = 80963
        BandType = 7
        LayerName = Foreground
      end
      object ppLine6: TppLine
        UserName = 'Line6'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 9790
        mmLeft = 1058
        mmTop = 20373
        mmWidth = 3440
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        AutoSize = False
        Caption = 'Nights'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 71173
        mmTop = 15875
        mmWidth = 9790
        BandType = 7
        LayerName = Foreground
      end
      object ppLine7: TppLine
        UserName = 'Line7'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 1323
        mmTop = 30427
        mmWidth = 80698
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Incluted'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3704
        mmLeft = 27517
        mmTop = 16140
        mmWidth = 18521
        BandType = 7
        LayerName = Foreground
      end
      object ppLine8: TppLine
        UserName = 'Line8'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 14552
        mmLeft = 45773
        mmTop = 16140
        mmWidth = 3440
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        AutoSize = False
        Caption = 'Excluted'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3704
        mmLeft = 48154
        mmTop = 16140
        mmWidth = 18521
        BandType = 7
        LayerName = Foreground
      end
      object ppLine9: TppLine
        UserName = 'Line9'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 14552
        mmLeft = 66411
        mmTop = 16140
        mmWidth = 3440
        BandType = 7
        LayerName = Foreground
      end
      object ppLine10: TppLine
        UserName = 'Line10'
        Position = lpLeft
        Weight = 0.750000000000000000
        mmHeight = 14552
        mmLeft = 82021
        mmTop = 15875
        mmWidth = 529
        BandType = 7
        LayerName = Foreground
      end
      object rlabttLodgingTax: TppLabel
        UserName = 'rlabttLodgingTax'
        Caption = '18.000.000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 28840
        mmTop = 20902
        mmWidth = 15875
        BandType = 7
        LayerName = Foreground
      end
      object rlabttBilledTax: TppLabel
        UserName = 'Label101'
        Caption = '18.000.000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 49213
        mmTop = 20902
        mmWidth = 15875
        BandType = 7
        LayerName = Foreground
      end
      object rlabttLodgingNights: TppLabel
        UserName = 'Label102'
        Caption = '4.700'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 68527
        mmTop = 20902
        mmWidth = 12171
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc1: TppDBCalc
        UserName = 'DBCalc1'
        DataField = 'TotalStayTax'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 157163
        mmTop = 1588
        mmWidth = 13758
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc2: TppDBCalc
        UserName = 'DBCalc2'
        DataField = 'TotalVAT'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 139700
        mmTop = 1588
        mmWidth = 14288
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc3: TppDBCalc
        UserName = 'DBCalc3'
        DataField = 'TotalWOVAT'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 123296
        mmTop = 1588
        mmWidth = 15081
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc4: TppDBCalc
        UserName = 'DBCalc4'
        DataField = 'Total'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 106363
        mmTop = 1588
        mmWidth = 15081
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc5: TppDBCalc
        UserName = 'DBCalc5'
        DataField = 'InvoiceNumber'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,##0'#39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcCount
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3704
        mmLeft = 1588
        mmTop = 1588
        mmWidth = 14288
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc6: TppDBCalc
        UserName = 'DBCalc6'
        DataField = 'TotalStayTaxNights'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,##0'#39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3260
        mmLeft = 185738
        mmTop = 1588
        mmWidth = 10054
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel23: TppLabel
        UserName = 'Label13'
        Caption = 'total invoices.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 17463
        mmTop = 1588
        mmWidth = 21251
        BandType = 7
        LayerName = Foreground
      end
      object ppLine19: TppLine
        UserName = 'Line19'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 105040
        mmTop = 6085
        mmWidth = 15081
        BandType = 7
        LayerName = Foreground
      end
      object ppLine20: TppLine
        UserName = 'Line20'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 136525
        mmTop = 6085
        mmWidth = 15081
        BandType = 7
        LayerName = Foreground
      end
      object ppLine22: TppLine
        UserName = 'Line22'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 153194
        mmTop = 6085
        mmWidth = 14288
        BandType = 7
        LayerName = Foreground
      end
      object ppLine23: TppLine
        UserName = 'Line23'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 170657
        mmTop = 6085
        mmWidth = 13758
        BandType = 7
        LayerName = Foreground
      end
      object ppLine24: TppLine
        UserName = 'Line24'
        Weight = 0.750000000000000000
        mmHeight = 1323
        mmLeft = 185738
        mmTop = 6085
        mmWidth = 10054
        BandType = 7
        LayerName = Foreground
      end
      object rlbltotalStayTaxExcluted: TppDBCalc
        UserName = 'rlbltotalStayTaxExcluted'
        DataField = 'totalStayTaxExcluted'
        DataPipeline = dplMinvoiceheads
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dplMinvoiceheads'
        mmHeight = 3175
        mmLeft = 171715
        mmTop = 1588
        mmWidth = 13758
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
    object ppParameterList1: TppParameterList
    end
  end
  object dplMinvoiceheads: TppDBPipeline
    DataSource = mInvoiceHeadsDS
    CloseDataSource = True
    UserName = 'dplMinvoiceheads'
    Left = 144
    Top = 276
    object dplMinvoiceheadsppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'RecId'
      FieldName = 'RecId'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 0
    end
    object dplMinvoiceheadsppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'Reservation'
      FieldName = 'Reservation'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 1
    end
    object dplMinvoiceheadsppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'RoomReservation'
      FieldName = 'RoomReservation'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 2
    end
    object dplMinvoiceheadsppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'InvoiceNumber'
      FieldName = 'InvoiceNumber'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 3
    end
    object dplMinvoiceheadsppField5: TppField
      FieldAlias = 'Customer'
      FieldName = 'Customer'
      FieldLength = 15
      DisplayWidth = 15
      Position = 4
    end
    object dplMinvoiceheadsppField6: TppField
      FieldAlias = 'Name'
      FieldName = 'Name'
      FieldLength = 100
      DisplayWidth = 100
      Position = 5
    end
    object dplMinvoiceheadsppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'Total'
      FieldName = 'Total'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 6
    end
    object dplMinvoiceheadsppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalWOVAT'
      FieldName = 'TotalWOVAT'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 7
    end
    object dplMinvoiceheadsppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalVAT'
      FieldName = 'TotalVAT'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 8
    end
    object dplMinvoiceheadsppField10: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalStayTax'
      FieldName = 'TotalStayTax'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 9
    end
    object dplMinvoiceheadsppField11: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalStayTaxNights'
      FieldName = 'TotalStayTaxNights'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 10
    end
    object dplMinvoiceheadsppField12: TppField
      Alignment = taRightJustify
      FieldAlias = 'totalStayTaxExcluted'
      FieldName = 'totalStayTaxExcluted'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 11
    end
    object dplMinvoiceheadsppField13: TppField
      FieldAlias = 'invoiceDate'
      FieldName = 'invoiceDate'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 12
    end
    object dplMinvoiceheadsppField14: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalTax'
      FieldName = 'TotalTax'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 13
    end
  end
  object m: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 48
    Top = 345
  end
  object StoreMain: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Position'
          'Top'
          'Width')
      end>
    StorageName = 'Software\Roomer\FormStatus\LodgingTaxReport'
    StorageType = stRegistry
    Left = 496
    Top = 344
  end
end
